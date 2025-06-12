package api.service.impl;

import api.service.APIInsService;
import api.vo.APIRCLOGVO;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import common.Constant;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.SmsService;
import egovframework.cmmn.vo.MMSVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.rc.service.impl.RcDAO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rsv.service.impl.RsvDAO;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.corp.vo.CMSSVO;
import web.order.vo.RC_RSVVO;
import web.product.service.WebRcProductService;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service("apiInsService")
public class APIInsServiceImpl extends EgovAbstractServiceImpl implements APIInsService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name = "apiInsDAO")
	private APIInsDAO apiInsDAO;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;

	@Resource(name = "smsService")
	protected SmsService smsService;

	@Resource(name = "apiDAO")
	private APIDAO apiDAO;

	@Resource(name = "rcDAO")
	private RcDAO rcDAO;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	/** INS common API url*/
	private static final String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
	public static final String INS_URL =  "test".equals(CST_PLATFORM.trim()) ? "http://rt.wrent.seejeju.com/rtapi/ws.aspx" : "https://rt.wrent.seejeju.com/rtapi/ws.aspx";
	public static final String INS_UID = "tamnao";
	public static final String INS_PASSCODE = "G19JZGV7K7Y25X8X12U5";

	/** 보험정보 */
	@Override
	public HashMap<String,Object> inslist(RC_PRDTINFVO webParam) throws IOException {

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (보험정보) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<String, String>();
		request.add("cmd", "inslist");
		request.add("uid",INS_UID);
		request.add("passcode",INS_PASSCODE);
		request.add("rccode",webParam.getCorpId());
		request.add("option_ins","1");
		HttpEntity param = new HttpEntity<>(request, headers);

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		String modeListStr = restTemplate.postForObject(INS_URL, param, String.class);
		log.info("inslistResult ::: " + modeListStr);

		/** convert to Hashmap (key가 한글이라 value object 역직렬화 실패, 대안으로 Hashmap사용) */
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		HashMap<String,Object> modelMap = mapper.readValue(modeListStr, HashMap.class);
		List<HashMap<String,Object>> modelListMap;

		String compareModelCode = "";
		int resultCnt1 = 0;
		int resultCnt2 = 0;

		/** set 보험정보 동기화*/
		if(!modelMap.containsKey("보험목록")){
			log.info("보험목록 has no key");
		}else{
			/** 모두연동 상태일 경우 전체차량 승인요청상태로 변경*/
			if("Y".equals(webParam.getTotalInterlock())){
				apiInsDAO.updateCarSaleEnd(webParam);
			}
			modelListMap = (List<HashMap<String,Object>>)modelMap.get("보험목록");
			for(int i =0; i < modelListMap.size(); i++ ){
				RC_PRDTINFVO apiRcPrdtVO = new RC_PRDTINFVO();

				apiRcPrdtVO.setRcCardivNum(modelListMap.get(i).get("L모델코드").toString());
				apiRcPrdtVO.setCorpId(modelListMap.get(i).get("L렌트회사코드").toString());

				/** 자차미포함 생성*/
				if("2".equals(webParam.getInsIsrDiv0())){
					int insCarNum = apiInsDAO.selectCntInsList(apiRcPrdtVO);
						apiRcPrdtVO.setFrstRegId("admin");
						apiRcPrdtVO.setLastModId("admin");
						apiRcPrdtVO.setIsrDiv("ID00");
					if(insCarNum < 1){
						/** 자차미포함 선택일 경우 */
						compareModelCode += modelListMap.get(i).get("L모델코드").toString();
						apiInsDAO.inserInsList(apiRcPrdtVO);
						resultCnt1 ++;
					}else if(insCarNum > 0 && "Y".equals(webParam.getTotalInterlock())) {
						apiInsDAO.updateInsList(apiRcPrdtVO);
						resultCnt2++;
					}else if(insCarNum > 0 && !"Y".equals(webParam.getTotalInterlock())) {
						apiInsDAO.updateInsList2(apiRcPrdtVO);
						resultCnt2++;
					}
				}

				/** 연령(숫자이외 문자제거)*/
				String rntQlfctAge = modelListMap.get(i).get("R가능나이").toString();
				rntQlfctAge = rntQlfctAge.replaceAll("[^0-9]", "");
				apiRcPrdtVO.setRntQlfctAge(rntQlfctAge);

				/** 경력*/
				String rntQlfctCareer = modelListMap.get(i).get("R운전경력").toString();
				rntQlfctCareer = rntQlfctCareer.replaceAll("[^0-9]", "");
				apiRcPrdtVO.setRntQlfctCareer(rntQlfctCareer);

				/** 보험요금안내 */
				apiRcPrdtVO.setIsrAmtGuide(modelListMap.get(i).get("R보험내용").toString());

				/** 보험타입,보험번호 부여*/
				if(modelListMap.get(i).get("R보험타입").equals("자차옵션1")){
					if("1".equals(webParam.getInsIsrDiv1())){
						apiRcPrdtVO.setIsrTypeDiv("GENL");
						apiRcPrdtVO.setIsrDiv("ID10");
						apiRcPrdtVO.setLinkMappingIsrNum(webParam.getInsIsrDiv1());
						apiRcPrdtVO.setGeneralIsrAge(rntQlfctAge);
						apiRcPrdtVO.setGeneralIsrCareer(rntQlfctCareer);
						apiRcPrdtVO.setGeneralIsrRewardAmt(modelListMap.get(i).get("R보상한도").toString());
						apiRcPrdtVO.setGeneralIsrBurcha("면책금:"+modelListMap.get(i).get("R면책금").toString() + "<pre></pre>휴차보상료:" + modelListMap.get(i).get("R휴차보상료").toString());
					}else if("1".equals(webParam.getInsIsrDiv2())){
						apiRcPrdtVO.setIsrDiv("ID10");
						apiRcPrdtVO.setIsrTypeDiv("LUXY");
						apiRcPrdtVO.setLinkMappingIsrNum(webParam.getInsIsrDiv2());
						apiRcPrdtVO.setLuxyIsrAge(rntQlfctAge);
						apiRcPrdtVO.setLuxyIsrCareer(rntQlfctCareer);
						apiRcPrdtVO.setLuxyIsrRewardAmt(modelListMap.get(i).get("R보상한도").toString());
						apiRcPrdtVO.setLuxyIsrBurcha("면책금:"+modelListMap.get(i).get("R면책금").toString() + "<pre></pre>휴차보상료:" + modelListMap.get(i).get("R휴차보상료").toString());
					}else{
						apiRcPrdtVO.setIsrDiv("ID00");
					}
				}else if(modelListMap.get(i).get("R보험타입").equals("자차옵션2")){
					if("2".equals(webParam.getInsIsrDiv1())){
						apiRcPrdtVO.setIsrDiv("ID10");
						apiRcPrdtVO.setIsrTypeDiv("GENL");
						apiRcPrdtVO.setLinkMappingIsrNum(webParam.getInsIsrDiv1());
						apiRcPrdtVO.setGeneralIsrAge(rntQlfctAge);
						apiRcPrdtVO.setGeneralIsrCareer(rntQlfctCareer);
						apiRcPrdtVO.setGeneralIsrRewardAmt(modelListMap.get(i).get("R보상한도").toString());
						apiRcPrdtVO.setGeneralIsrBurcha("면책금:"+modelListMap.get(i).get("R면책금").toString() + "<pre></pre>휴차보상료:" + modelListMap.get(i).get("R휴차보상료").toString());
					}else if("2".equals(webParam.getInsIsrDiv2())){
						apiRcPrdtVO.setIsrDiv("ID10");
						apiRcPrdtVO.setIsrTypeDiv("LUXY");
						apiRcPrdtVO.setLinkMappingIsrNum(webParam.getInsIsrDiv2());
						apiRcPrdtVO.setLuxyIsrAge(rntQlfctAge);
						apiRcPrdtVO.setLuxyIsrCareer(rntQlfctCareer);
						apiRcPrdtVO.setLuxyIsrRewardAmt(modelListMap.get(i).get("R보상한도").toString());
						apiRcPrdtVO.setLuxyIsrBurcha("면책금:"+modelListMap.get(i).get("R면책금").toString() + "<pre></pre>휴차보상료:" + modelListMap.get(i).get("R휴차보상료").toString());
					}else{
						apiRcPrdtVO.setIsrDiv("ID00");
					}
				}

				/** 일반자차,고급자차가 아닐경우 자차미포함일 경우 continue 자차미포함은 [자차미포함 생성] 로직에서 처리  */
				if("".equals(apiRcPrdtVO.getIsrTypeDiv()) || apiRcPrdtVO.getIsrTypeDiv() == null){
					continue;
				}

				int insNum = apiInsDAO.selectCntInsList(apiRcPrdtVO);
				log.info("insNum ::: " + i);

				apiRcPrdtVO.setFrstRegId("admin");
				apiRcPrdtVO.setLastModId("admin");


				if(insNum < 1){
				apiInsDAO.inserInsList(apiRcPrdtVO);
				compareModelCode += modelListMap.get(i).get("L모델코드").toString();
				resultCnt1 ++;
				}else if(insNum > 0 && "Y".equals(webParam.getTotalInterlock())){
					apiInsDAO.updateInsList(apiRcPrdtVO);
					resultCnt2 ++;
				}else if(insNum > 0 && !"Y".equals(webParam.getTotalInterlock())){
					apiInsDAO.updateInsList2(apiRcPrdtVO);
					resultCnt2 ++;
				}

			}
		}

		webParam.setRcCardivNum(compareModelCode);
		HashMap<String,Object> modelMap2 = carlist(webParam);
		modelMap.putAll(modelMap2);
		modelMap.put("resultCnt1", resultCnt1);
		modelMap.put("resultCnt2", resultCnt2);

		return modelMap;
	}


	/** 차량정보(매핑) */
	HashMap<String,Object> carlist(RC_PRDTINFVO webParam) throws IOException {

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (차량정보) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<String, String>();
		request.add("cmd", "carlist");
		request.add("uid",INS_UID);
		request.add("passcode",INS_PASSCODE);
		request.add("rccode",webParam.getCorpId());
		request.add("option_ins","1");
		HttpEntity param = new HttpEntity<>(request, headers);

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		String modeListStr = restTemplate.postForObject(INS_URL, param, String.class);
		log.info("carListResult ::: " + modeListStr);

		/** convert to Hashmap (key가 한글이라 value object 역직렬화 실패, 대안으로 Hashmap사용) */
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		HashMap<String,Object> modelMap = mapper.readValue(modeListStr, HashMap.class);
		List<HashMap<String,Object>> modelListMap;

		/** set 렌터카차량 동기화*/
		if(!modelMap.containsKey("모델목록")){
			log.info("모델목록 has no key");
		}else{
			modelListMap = (List<HashMap<String,Object>>)modelMap.get("모델목록");
			for(int i =0; i < modelListMap.size(); i++ ){
				/** if 완전연동 or 부분연동 */
				if("Y".equals(webParam.getTotalInterlock()) || webParam.getRcCardivNum().contains(modelListMap.get(i).get("L모델코드").toString()) ){
					RC_PRDTINFVO apiRcPrdtVO = new RC_PRDTINFVO();

					/** 검색조건 */
					apiRcPrdtVO.setLinkMappingNum(modelListMap.get(i).get("R모델번호").toString());
					apiRcPrdtVO.setRcCardivNum(modelListMap.get(i).get("L모델코드").toString());
					apiRcPrdtVO.setCorpId(modelListMap.get(i).get("L렌트회사코드").toString());

					/** 연식 */
					apiRcPrdtVO.setModelYear(modelListMap.get(i).get("R연식").toString());
					/** 연령(숫자이외 문자제거)*/
					String rntQlfctAge = modelListMap.get(i).get("R가능연령").toString();
					rntQlfctAge = rntQlfctAge.replaceAll("[^0-9]", "");
					apiRcPrdtVO.setRntQlfctAge(rntQlfctAge);

					/** 경력*/
					String rntQlfctCareer = modelListMap.get(i).get("R운전경력").toString();
					rntQlfctCareer = rntQlfctCareer.replaceAll("[^0-9]", "");
					apiRcPrdtVO.setRntQlfctCareer(rntQlfctCareer);

					/** 변속기 */
					String rTransDiv = modelListMap.get(i).get("R변속기").toString();
					String compTransDiv = "수동,M,메뉴얼";
					if(compTransDiv.contains(rTransDiv)){
						apiRcPrdtVO.setTransDiv("TR01");
					}else{
						apiRcPrdtVO.setTransDiv("TR02");
						apiRcPrdtVO.setRntQlfctLicense("2");
					}
					/** 면허종류*/
					String passengersCnt = modelListMap.get(i).get("R승차인원").toString();
					if(Integer.parseInt(passengersCnt) <= 10){
						apiRcPrdtVO.setRntQlfctLicense("2");
					}else{
						apiRcPrdtVO.setRntQlfctLicense("1");
					}

					apiRcPrdtVO.setLastModId("admin");

					/** 차량정보 업데이트 */
					apiInsDAO.updateCarList(apiRcPrdtVO);

					/** 차량옵션 삭제 */
					apiInsDAO.deleteCarOptList(apiRcPrdtVO);

					/** 차량옵션 추가 */
					apiRcPrdtVO.setFrstRegId("admin");
					List<CDVO> iconCdList = ossCmmService.selectCode(Constant.ICON_CD_RCAT);
					for(CDVO cdvo : iconCdList){
						/** 차량모델옵션*/
						if(modelListMap.get(i).get("R모델옵션").toString().contains(cdvo.getCdNm())){
							apiRcPrdtVO.setIconCds(cdvo.getCdNum());
							apiInsDAO.insertCarOptList(apiRcPrdtVO);
						}else if(cdvo.getCdNmLike() != null && !"".equals(cdvo.getCdNmLike())){
							if(cdvo.getCdNmLike().contains("||")){
								String[] parseStr = cdvo.getCdNmLike().split("\\|\\|");

								for(int j = 0; j<parseStr.length; j++){
									if(modelListMap.get(i).get("R모델옵션").toString().contains(parseStr[j])){
										apiRcPrdtVO.setIconCds(cdvo.getCdNum());
										apiInsDAO.insertCarOptList(apiRcPrdtVO);
									}
								}
							}else{
								if(modelListMap.get(i).get("R모델옵션").toString().contains(cdvo.getCdNmLike())){
									apiRcPrdtVO.setIconCds(cdvo.getCdNum());
									apiInsDAO.insertCarOptList(apiRcPrdtVO);
								}
							}
						}
						/** 구동방식(탐나오는 구동방식이 옵션*/
						if(modelListMap.get(i).get("R구동방식").toString().contains(cdvo.getCdNm())){
							apiRcPrdtVO.setIconCds(cdvo.getCdNum());
							apiInsDAO.insertCarOptList(apiRcPrdtVO);
						}else if(cdvo.getCdNmLike() != null && !"".equals(cdvo.getCdNmLike())){
							if("||".contains(cdvo.getCdNmLike())){
								String parseStr[] = cdvo.getCdNmLike().split("||");
								for(String tempCdNm : parseStr){
									if(modelListMap.get(i).get("R구동방식").toString().contains(tempCdNm)){
										apiRcPrdtVO.setIconCds(cdvo.getCdNum());
										apiInsDAO.insertCarOptList(apiRcPrdtVO);
									}
								}
							}else{
								if(modelListMap.get(i).get("R구동방식").toString().contains(cdvo.getCdNmLike())){
									apiRcPrdtVO.setIconCds(cdvo.getCdNum());
									apiInsDAO.insertCarOptList(apiRcPrdtVO);
								}
							}
						}

					}
				}
			}
		}
		return modelMap;
	}

	/** 업체차량정보 */
	@Override
	public HashMap<String,Object> carlist_r(RC_PRDTINFVO webParam) throws IOException {

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (업체차량정보) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<String, String>();
		request.add("cmd", "carlist_r");
		request.add("uid",INS_UID);
		request.add("passcode",INS_PASSCODE);
		request.add("rccode",webParam.getCorpId());
		HttpEntity param = new HttpEntity<>(request, headers);

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		String modeListStr = restTemplate.postForObject(INS_URL, param, String.class);
		log.info("carlist_r_Result ::: " + modeListStr);

		/** convert to Hashmap (key가 한글이라 value object 역직렬화 실패, 대안으로 Hashmap사용) */
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		HashMap<String,Object> modelMap = mapper.readValue(modeListStr, HashMap.class);

		if(webParam.getLinkMappingNum() != null && !"".equals(webParam.getLinkMappingNum())){
			List<HashMap<String,Object>> modelListMap;

			/** set 렌터카차량 동기화*/
			if(!modelMap.containsKey("모델목록")){
				log.info("모델목록 has no key");
			}else{
				modelListMap = (List<HashMap<String,Object>>)modelMap.get("모델목록");
				for(int i =0; i < modelListMap.size(); i++ ){
					if(webParam.getLinkMappingNum().equals(modelListMap.get(i).get("R모델번호").toString())){
						modelMap = modelListMap.get(i);
					}
				}
			}
		}
		return modelMap;
	}

	/** 차량정보 전체 */
	@Override
	public List<RC_PRDTINFVO> carsearch(RC_PRDTINFSVO webParam) throws IOException {

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (차량정보) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<String, String>();
		request.add("cmd", "carsearch");
		request.add("uid",INS_UID);
		request.add("passcode",INS_PASSCODE);
		request.add("sd",webParam.getsFromDt() + webParam.getsFromTm());
		request.add("ed",webParam.getsToDt() + webParam.getsToTm());
		request.add("option_ins","1");
		HttpEntity param = new HttpEntity<>(request, headers);

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		String modeListStr = restTemplate.postForObject(INS_URL, param, String.class);

		/** convert to Hashmap (key가 한글이라 value object 역직렬화 실패, 대안으로 Hashmap사용) */
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		HashMap<String,Object> modelMap = mapper.readValue(modeListStr, HashMap.class);
		List<HashMap<String,Object>> modelListMap;

		List<RC_PRDTINFVO> apiRcPrdtListVO = new ArrayList<>() ;

		/** set 렌터카차량 동기화*/
		if(!modelMap.containsKey("모델목록")){
			log.info("모델목록 has no key");
		}else{
			modelListMap = (List<HashMap<String,Object>>)modelMap.get("모델목록");
			for(int i =0; i < modelListMap.size(); i++ ){
				RC_PRDTINFVO apiRcPrdtVO = new RC_PRDTINFVO();
				/** 차량정보 */
				apiRcPrdtVO.setLinkMappingNum(modelListMap.get(i).get("R모델번호").toString());
				apiRcPrdtVO.setRcCardivNum(modelListMap.get(i).get("L모델코드").toString());
				apiRcPrdtVO.setCorpId(modelListMap.get(i).get("L렌트회사코드").toString());
				/** 차량금액 */
				apiRcPrdtVO.setNetAmt(modelListMap.get(i).get("R입금가").toString());
				apiRcPrdtVO.setNet1Amt(modelListMap.get(i).get("R옵션1입금가").toString());
				apiRcPrdtVO.setNet2Amt(modelListMap.get(i).get("R옵션2입금가").toString());
				/** 대여가능여부 */
				String ableCnt = modelListMap.get(i).get("R가능수").toString().replaceAll("[^0-9]", "");
				Integer ableCntInt =  Integer.parseInt(ableCnt);

				/** 대여가능일 경우 */
				if(ableCntInt > 0){
					apiRcPrdtListVO.add(apiRcPrdtVO);
				}
			}
		}
		return apiRcPrdtListVO;
	}

	/** 차량정보 단건 */
	@Override
	public RC_PRDTINFVO carsearchbymodelcodes(RC_PRDTINFSVO prdtSVO, RC_PRDTINFVO prdtVO) throws IOException {
		/** get 렌터카 수수료율 for 입금가계산 */
		CMSSVO cmssVO = new CMSSVO();
		cmssVO.setCmssNum("CMSS000001");
		cmssVO = ossCmmService.selectByCmss(cmssVO);
		Float tamnaoCmss = Float.parseFloat(cmssVO.getAdjAplPct());

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (차량정보) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<String, String>();
		request.add("cmd", "carsearchbymodelcodes");
		request.add("uid",INS_UID);
		request.add("passcode",INS_PASSCODE);
		request.add("sd",prdtSVO.getsFromDt() + prdtSVO.getsFromTm());
		request.add("ed",prdtSVO.getsToDt() + prdtSVO.getsToTm());
		request.add("rccode",prdtVO.getCorpId());
		request.add("mcode",prdtVO.getRcCardivNum());
		request.add("option_ins","1");
		HttpEntity param = new HttpEntity<>(request, headers);

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		String modeListStr = restTemplate.postForObject(INS_URL, param, String.class);
		/*log.info("carsearchbymodelcodesResult ::: " + modeListStr);*/

		/** convert to Hashmap (key가 한글이라 value object 역직렬화 실패, 대안으로 Hashmap사용) */
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		HashMap<String,Object> modelMap = mapper.readValue(modeListStr, HashMap.class);
		List<HashMap<String,Object>> modelListMap;

		/** set 차량정보 동기화*/
		if(!modelMap.containsKey("모델목록")){
			log.info("모델목록 has no key");
		}else{
			modelListMap = (List<HashMap<String,Object>>)modelMap.get("모델목록");
			if(modelListMap.size() > 0){
				for(int i =0; i < modelListMap.size(); i++ ){
					/** 차량금액 */
					prdtVO.setAbleYn("Y");
					if(prdtVO.getLinkMappingIsrNum() == null || "".equals(prdtVO.getLinkMappingIsrNum()) ){
						if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
							String saleVal = Integer.toString((int)((Integer.parseInt(modelListMap.get(i).get("R입금가").toString()) * 100) / (100 - tamnaoCmss) / 10) * 10);
							prdtVO.setSaleAmt(saleVal);
							prdtVO.setNetAmt(modelListMap.get(i).get("R입금가").toString());
						}else{
							prdtVO.setSaleAmt(modelListMap.get(i).get("R입금가").toString());
							prdtVO.setNetAmt(modelListMap.get(i).get("R입금가").toString());
						}
					}else if(prdtVO.getLinkMappingIsrNum().equals("1")){
						if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
							String saleVal = Integer.toString((int)((Integer.parseInt(modelListMap.get(i).get("R옵션1입금가").toString()) * 100) / (100 - tamnaoCmss) / 10) * 10);
							prdtVO.setSaleAmt(saleVal);
							prdtVO.setNetAmt(modelListMap.get(i).get("R옵션1입금가").toString());
						}else{
							prdtVO.setSaleAmt(modelListMap.get(i).get("R옵션1입금가").toString());
							prdtVO.setNetAmt(modelListMap.get(i).get("R옵션1입금가").toString());
						}
					}else if(prdtVO.getLinkMappingIsrNum().equals("2")){
						if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
							String saleVal = Integer.toString((int)((Integer.parseInt(modelListMap.get(i).get("R옵션2입금가").toString()) * 100) / (100 - tamnaoCmss) / 10) * 10);
							prdtVO.setSaleAmt(saleVal);
							prdtVO.setNetAmt(modelListMap.get(i).get("R옵션2입금가").toString());
						}else{
							prdtVO.setSaleAmt(modelListMap.get(i).get("R옵션2입금가").toString());
							prdtVO.setNetAmt(modelListMap.get(i).get("R옵션2입금가").toString());
						}
					}else{
						prdtVO.setAbleYn("N");
					}
				}
			}else{
				prdtVO.setAbleYn("N");
			}
		}
		return prdtVO;
	}

	/** 예약 */
	@Override
	public String revadd(String rcRsvNum) throws IOException {
		/** 예약정보 */
		RC_RSVVO rsvDtlVO = new RC_RSVVO();
		rsvDtlVO.setRcRsvNum(rcRsvNum);
		rsvDtlVO = rsvDAO.selectRcDetailRsv(rsvDtlVO);

		String checkAmtStr = rsvDtlVO.getNmlAmt();

		/** 상품정보 */
		RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
		prdtSVO.setsPrdtNum(rsvDtlVO.getPrdtNum());
		prdtSVO.setsFromDt(rsvDtlVO.getRentStartDt());
		prdtSVO.setsFromTm(rsvDtlVO.getRentStartTm());
		prdtSVO.setsToDt(rsvDtlVO.getRentEndDt());
		prdtSVO.setsToTm(rsvDtlVO.getRentEndTm());
		prdtSVO.setsApiRentDiv(rsvDtlVO.getApiRentDiv());
		RC_PRDTINFVO prdtVO = webRcProductService.selectRcPrdt(prdtSVO);

		/** get 렌터카 수수료율 for 입금가계산 */
		CMSSVO cmssVO = new CMSSVO();
		cmssVO.setCmssNum("CMSS000001");
		cmssVO = ossCmmService.selectByCmss(cmssVO);
		final Float adjAplPct = Float.parseFloat(cmssVO.getAdjAplPct());

		/** 입금가일 경우 금액 변환*/
		if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
			int checkAmtInt = Integer.parseInt(checkAmtStr);
			checkAmtInt = (checkAmtInt - ((int)(checkAmtInt * adjAplPct  / 1000) * 10));
			checkAmtStr = String.valueOf(checkAmtInt);
		}

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (예약) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<String, String>();
		request.add("cmd", "revadd");
		request.add("uid",INS_UID);
		request.add("passcode",INS_PASSCODE);
		request.add("rccode",rsvDtlVO.getCorpId());
		request.add("sd",rsvDtlVO.getRentStartDt() + rsvDtlVO.getRentStartTm());
		request.add("ed",rsvDtlVO.getRentEndDt() + rsvDtlVO.getRentEndTm());
		request.add("custfee","0");
		request.add("mid",prdtVO.getLinkMappingNum());
		request.add("option_ins",prdtVO.getLinkMappingIsrNum());
		request.add("carfeechk",checkAmtStr);
		request.add("dealerrevnum",rsvDtlVO.getRcRsvNum());

		request.add("uname",rsvDtlVO.getRsvNm());
		request.add("phone",rsvDtlVO.getRsvTelnum());
		request.add("uname1",rsvDtlVO.getUseNm());
		request.add("phone1",rsvDtlVO.getUseTelnum());

		HttpEntity param = new HttpEntity<>(request, headers);

		/** 로그저장 초기화 */
		APIRCLOGVO apiRcLogVO = new APIRCLOGVO() ;
		/** 예약FLAG */
		apiRcLogVO.setApiRentDiv("I");
		apiRcLogVO.setSeqNum("0");
		apiRcLogVO.setRcRsvNum(rsvDtlVO.getRcRsvNum());
		apiRcLogVO.setRsvNum(rsvDtlVO.getRsvNum());
		apiRcLogVO.setRequestMsg(request.toString());

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		String modeListStr = restTemplate.postForObject(INS_URL, param, String.class);
		log.info("revaddResult ::: " + modeListStr);
		apiRcLogVO.setResultMsg(modeListStr);

		/** convert to Hashmap (key가 한글이라 value object 역직렬화 실패, 대안으로 Hashmap사용) */
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		HashMap<String,String> modelMap = mapper.readValue(modeListStr, HashMap.class);
		/** if 성공시 예약번호 반환 */
		String linkMappingRsvnum = "";
		if(modelMap.get("resCode").equals("0000")){
			linkMappingRsvnum = modelMap.get("R예약번호");
			rsvDtlVO.setLinkMappingRsvnum(linkMappingRsvnum);
			/** 예약번호 업데이트 */
			rsvDAO.updateRcLinkYn(rsvDtlVO);
			apiRcLogVO.setRsvResult("0");
		}else if(modelMap.get("resCode").equals("0130")){
			apiRcLogVO.setRsvResult("2");
			linkMappingRsvnum = "0000";
		}else{
			apiRcLogVO.setRsvResult("1");
		}
		/**로그 저장*/
		apiDAO.insertRcApiLog(apiRcLogVO);
		return linkMappingRsvnum;
	}

	/** 취소 */
	@Override
	public Boolean revcancel(RC_RSVVO rcRsvVO) throws IOException {

		Boolean cancelResult = false;
		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (자차보험) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<String, String>();
		request.add("cmd", "revcancel");
		request.add("uid",INS_UID);
		request.add("passcode",INS_PASSCODE);
		request.add("rccode",rcRsvVO.getCorpId());
		request.add("revnum",rcRsvVO.getLinkMappingRsvnum());

		HttpEntity param = new HttpEntity<>(request, headers);

		/** 로그저장 초기화 */
		APIRCLOGVO apiRcLogVO = new APIRCLOGVO() ;
		/** 취소FLAG */
		apiRcLogVO.setApiRentDiv("I");
		apiRcLogVO.setSeqNum("1");
		apiRcLogVO.setRcRsvNum(rcRsvVO.getRcRsvNum());
		apiRcLogVO.setRsvNum(rcRsvVO.getRsvNum());

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		String modeListStr = restTemplate.postForObject(INS_URL, param, String.class);
		log.info("revcancelResult ::: " + modeListStr);
		apiRcLogVO.setResultMsg(modeListStr);

		/** convert to Hashmap (key가 한글이라 value object 역직렬화 실패, 대안으로 Hashmap사용) */
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		HashMap<String,String> modelMap = mapper.readValue(modeListStr, HashMap.class);
		/** if 취소성공 */
		if(modelMap.get("resCode").equals("0000")){
			cancelResult = true;
			apiRcLogVO.setRsvResult("0");
		}else{
			apiRcLogVO.setRsvResult("1");
			apiRcLogVO.setFaultReason(modelMap.get("resMsg"));
			/** 실패 문자발송*/
			String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
			/** 인스 #이후 숫자제거*/
			String rsvNumStr = rcRsvVO.getLinkMappingRsvnum();
			if(rsvNumStr.lastIndexOf("#") >= 0){
				rsvNumStr = rsvNumStr.substring(0,rsvNumStr.lastIndexOf("#"));
			}
			MMSVO mmsVO = new MMSVO();
			mmsVO.setSubject("[탐나오]렌터카실시간API 취소오류알림");
			mmsVO.setMsg("[탐나오]렌터카실시간API 취소오류알림\n"
					+"예약번호(업체) : " + rsvNumStr + "\n"
					+"예약번호(탐나오) : " + rcRsvVO.getRsvNum() + "\n"
					+"예약자 : " + rcRsvVO.getRsvNm() + "\n"
					+"연락처 : " + rcRsvVO.getRsvTelnum() + "\n"
					+"취소불가이유 : " + modelMap.get("resMsg") + "\n\n"
					+"*연계시스템 취소 불가건으로 탐나오상점관리자에 예약건이 없을경우, 업체시스템에서 직접 취소바랍니다."
			);
			mmsVO.setStatus("0");
			mmsVO.setFileCnt("0");
			mmsVO.setType("0");
			/*담당자 MMS발송 - 테스트빌드시 결제 메시지 김재성*/
			if("test".equals(CST_PLATFORM.trim())) {
				mmsVO.setPhone(Constant.TAMNAO_TESTER1);
			}else{
				mmsVO.setPhone(rcRsvVO.getAdmMobile());
			}
			mmsVO.setCallback(EgovProperties.getProperty("CS.PHONE"));
			try {
				smsService.sendMMS(mmsVO);
			} catch (Exception e) {
				log.info("MMS Error");
			}

			/* 담당자2 MMS 발송 */
			if(StringUtils.isNotEmpty(rcRsvVO.getAdmMobile2())) {
				/*테스트빌드시*/
				if("test".equals(CST_PLATFORM.trim())) {
					mmsVO.setPhone(Constant.TAMNAO_TESTER2);
				}else{
					mmsVO.setPhone(rcRsvVO.getAdmMobile2());
				}
				try {
					smsService.sendMMS(mmsVO);
				} catch (Exception e) {
					log.info("MMS Error");
				}
			}

			/* 담당자3 MMS 발송 */
			if(StringUtils.isNotEmpty(rcRsvVO.getAdmMobile3())) {
				/*테스트빌드시*/
				if("test".equals(CST_PLATFORM.trim())) {
					mmsVO.setPhone(Constant.TAMNAO_TESTER3);
				}else{
					mmsVO.setPhone(rcRsvVO.getAdmMobile3());
				}
				try {
					smsService.sendMMS(mmsVO);
				} catch (Exception e) {
					log.info("MMS Error");
				}
			}

			/** 렌터카 담당자 부민수*/
			mmsVO.setPhone("010-8229-0954");
			smsService.sendMMS(mmsVO);
		}
		/**로그 저장*/
		apiDAO.insertRcApiLog(apiRcLogVO);
		return cancelResult;
	}

	@Override
	public void updateCarSaleStart(RC_PRDTINFVO webParam) throws IOException {
		apiInsDAO.updateCarSaleStart(webParam);
	}
}

