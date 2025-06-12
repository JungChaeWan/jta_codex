package api.service.impl;

import api.service.APIRibbonService;
import api.vo.*;
import common.Constant;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.SmsService;
import egovframework.cmmn.vo.MMSVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service("apiRibbonService")
public class APIRibbonServiceImpl extends EgovAbstractServiceImpl implements APIRibbonService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name = "apiRibbonDAO")
	private APIRibbonDAO apiRibbonDAO;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "apiDAO")
	private APIDAO apiDAO;

	@Resource(name = "smsService")
	protected SmsService smsService;

	/** INS common API url*/
	private static final String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
	public static final String RIB_URL =  "test".equals(CST_PLATFORM.trim()) ? "http://api.roof926.com/api/v1/external/" : "https://api.roof926.com/api/v1/external/";
	public static final String RIB_KEY = "p1i5p0e54x468323";
	public static final String RIB_AUTH_KEY = "x6jxv2t1vife447a";

	@Override
	public List<APIRibbonVO> selectListRibbonTamnaoCarType() {
		return apiRibbonDAO.selectListRibbonTamnaoCarType();
	}

	@Override
	public HashMap<String,Object> carModelInfo(RC_PRDTINFVO webParam) {
		HashMap<String,Object> resultMap = new HashMap<>();
		int resultCnt1 = 0;
		int resultCnt2 = 0;
		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (보험정보) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<>();
		request.add("crtfcKey", RIB_KEY);
		request.add("crtfcAuthorKey",RIB_AUTH_KEY);
		request.add("clientId",webParam.getCorpId());

		HttpEntity param = new HttpEntity<>(request, headers);

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		APIRibbonCarModelinfoVO APIRibbonCarModelinfoVo = restTemplate.postForObject(RIB_URL+"carModelInfo.xml", param, APIRibbonCarModelinfoVO.class);

		/** 통신성공 */
		if("OK".equals(APIRibbonCarModelinfoVo.getHead().getResultCode())){

			if("Y".equals(webParam.getTotalInterlock())){
				apiRibbonDAO.updateCarSaleEnd(webParam);
			}
			/** 매핑시작 */
			for(APIRibbonCarModelinfoVOitem item : APIRibbonCarModelinfoVo.getBody().getItem() ){

				RC_PRDTINFVO apiRcPrdtVO = new RC_PRDTINFVO();
				/** 등록자*/
				apiRcPrdtVO.setFrstRegId("admin");
				apiRcPrdtVO.setLastModId("admin");
				/** 업체ID(탐나오)*/
				apiRcPrdtVO.setCorpId(item.getClientId());
				/** 차량ID(탐나오) */
				apiRcPrdtVO.setRcCardivNum(item.getBcncVhctyCode());
				/** 차량매핑코드(리본) */
				apiRcPrdtVO.setLinkMappingNum(item.getVhctyCode());
				/** 변속기 */
				if(item.getGearNm().equals("자동")){
					apiRcPrdtVO.setTransDiv("TR02");
				}else{
					apiRcPrdtVO.setTransDiv("TR01");
				}
				/** 연식 */
				apiRcPrdtVO.setModelYear(item.getYemodel());
				/** 면허 */
				apiRcPrdtVO.setRntQlfctLicense(item.getLicense());
				/** 연령 */
				apiRcPrdtVO.setRntQlfctAge(item.getLicenseLmttAge());
				/** 경력 */
				apiRcPrdtVO.setRntQlfctCareer(item.getLicenseLmttCareer());

				Integer iCnt = 0;
				Boolean updateOption = false;

				/** 0.자차자율 생성 및 업데이트 */
				if("2".equals(webParam.getInsIsrDiv0())) {
					apiRcPrdtVO.setIsrDiv("ID00");
					iCnt = apiRibbonDAO.selectCntRibList(apiRcPrdtVO);
					apiRcPrdtVO.setLinkMappingIsrNum("1");

					/**옵션연동 여부*/

					/** 0-0.자차자율 생성*/
					if (iCnt < 1) {
						apiRibbonDAO.insertRibList(apiRcPrdtVO);
						resultCnt1++;
						updateOption = true;
						/** 0-0.자차자율 업데이트*/
					}else{
						if ("Y".equals(webParam.getTotalInterlock())) {
							apiRibbonDAO.updateRibList(apiRcPrdtVO);
							resultCnt2++;
						}
					}
				}

				/** 보험포함*/
				apiRcPrdtVO.setIsrDiv("ID10");
				if("1".equals(webParam.getInsIsrDiv1()) || "2".equals(webParam.getInsIsrDiv1()) ) {
					/** 1.일반자차 생성 및 업데이트  */
						apiRcPrdtVO.setIsrTypeDiv("GENL");
						iCnt = apiRibbonDAO.selectCntRibList(apiRcPrdtVO);
					if("1".equals(webParam.getInsIsrDiv1())){
						apiRcPrdtVO.setLinkMappingIsrNum("2");
					}else{
						apiRcPrdtVO.setLinkMappingIsrNum("3");
					}

					/** 1-0.일반자차 생성*/
					if(iCnt < 1){
						apiRibbonDAO.insertRibList(apiRcPrdtVO);
						resultCnt1 ++;
						updateOption = true;
					/** 1-1.일반자차 업데이트*/
					}else{
						if("Y".equals(webParam.getTotalInterlock())) {
							apiRibbonDAO.updateRibList(apiRcPrdtVO);
							resultCnt2++;
						}
					}
				}

				if("1".equals(webParam.getInsIsrDiv2()) || "2".equals(webParam.getInsIsrDiv2()) ) {
					/** 2.고급자차 생성 및 업데이트  */
					apiRcPrdtVO.setIsrTypeDiv("LUXY");
					iCnt = apiRibbonDAO.selectCntRibList(apiRcPrdtVO);
					if("1".equals(webParam.getInsIsrDiv2())){
						apiRcPrdtVO.setLinkMappingIsrNum("2");
					}else{
						apiRcPrdtVO.setLinkMappingIsrNum("3");
					}

					/** 2-0.고급자차 생성*/
					if(iCnt < 1){
						apiRibbonDAO.insertRibList(apiRcPrdtVO);
						resultCnt1 ++;
						updateOption = true;
					/** 2-1.고급자차 업데이트*/
					}else{
						if("Y".equals(webParam.getTotalInterlock())) {
							apiRibbonDAO.updateRibList(apiRcPrdtVO);
							resultCnt2 ++;
						}
					}
				}

				if(updateOption){
					/** 차량옵션 삭제 */
					apiRibbonDAO.deleteCarOptList(apiRcPrdtVO);

					/** 차량옵션 추가 */
					apiRcPrdtVO.setFrstRegId("admin");
					List<CDVO> iconCdList = ossCmmService.selectCode(Constant.ICON_CD_RCAT);
					for(CDVO cdvo : iconCdList){
						/** 차량옵션(안전,편의,음향) */
						if(item.getOptionSafeNm().contains(cdvo.getCdNm()) || item.getOptionCnvncNm().contains(cdvo.getCdNm()) || item.getOptionSondNm().contains(cdvo.getCdNm())){
							apiRcPrdtVO.setIconCds(cdvo.getCdNum());
							apiRibbonDAO.insertCarOptList(apiRcPrdtVO);
						}else if(cdvo.getCdNmLike() != null && !"".equals(cdvo.getCdNmLike())){
							if(cdvo.getCdNmLike().contains("||")){
								String[] parseStr = cdvo.getCdNmLike().split("\\|\\|");
								for(int j = 0; j<parseStr.length; j++){
									if(item.getOptionSafeNm().contains(parseStr[j]) || item.getOptionCnvncNm().contains(parseStr[j]) || item.getOptionSondNm().contains(parseStr[j])){
										apiRcPrdtVO.setIconCds(cdvo.getCdNum());
										apiRibbonDAO.insertCarOptList(apiRcPrdtVO);
									}
								}
							}else{
								if(item.getOptionSafeNm().contains(cdvo.getCdNmLike()) || item.getOptionCnvncNm().contains(cdvo.getCdNmLike()) || item.getOptionSondNm().contains(cdvo.getCdNmLike())){
									apiRcPrdtVO.setIconCds(cdvo.getCdNum());
									apiRibbonDAO.insertCarOptList(apiRcPrdtVO);
								}
							}
						}
					}
				}

			}
			resultMap.put("resultCnt1",resultCnt1);
			resultMap.put("resultCnt2",resultCnt2);
		/** 통신실패 */
		}else{
			resultMap.put("result","fail");
		}

		return resultMap;
	}

	@Override
	public List<RC_PRDTINFVO> riblist(RC_PRDTINFSVO webParam) {

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (보험정보) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<>();
		request.add("crtfcKey", RIB_KEY);
		request.add("crtfcAuthorKey",RIB_AUTH_KEY);
		request.add("resveBeginDe",webParam.getsFromDt());
		request.add("resveBeginHm",webParam.getsFromTm());
		request.add("resveEndDe",webParam.getsToDt());
		request.add("resveEndHm",webParam.getsToTm());
		HttpEntity param = new HttpEntity<>(request, headers);

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		APIRibbonCarlistVO carlistVO = restTemplate.postForObject(RIB_URL+"carList.xml", param, APIRibbonCarlistVO.class);

		List<RC_PRDTINFVO> apiRcPrdtListVO = new ArrayList<>() ;

		for(APIRibbonCarlistVOitems items : carlistVO.getBody().getItems() ){

			/** 차량이 한대도 없으면 continue */
			if(Integer.parseInt(items.getPossibleCount()) < 1){
				continue;
			}

			for(APIRibbonCarlistVOitem item : items.getItem() ){

				if(Integer.parseInt(item.getPossibleCount()) < 1){
					continue;
				}

				/** 차량-자차미포함 판매여부*/
				if(Constant.FLAG_Y.equals(item.getStdSaleYn())){
					RC_PRDTINFVO apiRcPrdtVO = new RC_PRDTINFVO();
					/** 차량코드 */
					apiRcPrdtVO.setRcCardivNum(items.getVhctyCode());

					/** 업체코드 */
					apiRcPrdtVO.setCorpId(item.getClientCode());

					/** 차량 판매요금 */
					apiRcPrdtVO.setSaleAmt(item.getStdSalePrice());

					/** 차량 대여제한 나이 */
					apiRcPrdtVO.setRntQlfctAge(item.getStdAge());

					/** 차량 대여제한 경력 */
					apiRcPrdtVO.setRntQlfctCareer(item.getStdCareer());

					/** 자차미보험 */
					apiRcPrdtVO.setLinkMappingIsrNum("1");

					/** 오브젝트 추가 */
					apiRcPrdtListVO.add(apiRcPrdtVO);
				}

				/** 일반자차*/
				if(Constant.FLAG_Y.equals(item.getInsuGnrlSaleYn())){
					RC_PRDTINFVO apiRcPrdtVO = new RC_PRDTINFVO();
					/** 차량코드 */
					apiRcPrdtVO.setRcCardivNum(items.getVhctyCode());

					/** 업체코드 */
					apiRcPrdtVO.setCorpId(item.getClientCode());

					/** 일반보험포함 차량 판매금액 */
					apiRcPrdtVO.setSaleAmt(item.getInsuGnrlSaleAdupPrice());

					/** 일반보험 제한나이 */
					apiRcPrdtVO.setRntQlfctAge(item.getInsuGnrlApplcLmttAge());

					/** 일반보험 제한경력 */
					apiRcPrdtVO.setRntQlfctCareer(item.getInsuGnrlApplcDrverLmttCareer());

					/** 일반보험 보상한도 금액 */
					apiRcPrdtVO.setGeneralIsrRewardAmt(item.getInsuGnrlRewardLmtAmount());
					
					/** 일반보험 면책금 금액 */
					apiRcPrdtVO.setGeneralIsrBurcha(item.getInsuGnrlAcdntNoresponsAmount());

					/** 일반보험 보상한도 내용 */
					apiRcPrdtVO.setIsrAmtGuide(item.getInsuGnrlRewardLmtContents());

					/** 일반자차 */
					apiRcPrdtVO.setLinkMappingIsrNum("2");

					/** 오브젝트 추가 */
					apiRcPrdtListVO.add(apiRcPrdtVO);
				}

				/** 고급자차 판매여부 */
				if(Constant.FLAG_Y.equals(item.getInsuPrfectSaleYn())){
					RC_PRDTINFVO apiRcPrdtVO = new RC_PRDTINFVO();
					/** 차량코드 */
					apiRcPrdtVO.setRcCardivNum(items.getVhctyCode());

					/** 업체코드 */
					apiRcPrdtVO.setCorpId(item.getClientCode());

					/** 고급보험포함 차량 판매금액 */
					apiRcPrdtVO.setSaleAmt(item.getInsuPrfectSaleAdupPrice());

					/** 고급보험 제한나이 */
					apiRcPrdtVO.setRntQlfctAge(item.getInsuPrfectApplcLmttAge());

					/** 고급보험 제한경력 */
					apiRcPrdtVO.setRntQlfctCareer(item.getInsuPrfectApplcDrverLmttCareer());

					/** 고급보험 보상한도 금액 */
					apiRcPrdtVO.setLuxyIsrRewardAmt(item.getInsuPrfectRewardLmtAmount());
					
					/** 고급보험 면책금 금액 */
					apiRcPrdtVO.setLuxyIsrBurcha(item.getInsuPrfectAcdntNoresponsAmount());

					/** 고급보험 보상한도 내용 */
					apiRcPrdtVO.setIsrAmtGuide(item.getInsuPrfectRewardLmtContents());

					/** 고급자차 */
					apiRcPrdtVO.setLinkMappingIsrNum("3");

					/** 오브젝트 추가 */
					apiRcPrdtListVO.add(apiRcPrdtVO);
				}
			}
		}

		return apiRcPrdtListVO;
	}

	@Override
	public RC_PRDTINFVO ribDetail(RC_PRDTINFSVO prdtSVO, RC_PRDTINFVO prdtVO) {
		/** get 렌터카 수수료율 for 입금가계산 */
		CMSSVO cmssVO = new CMSSVO();
		cmssVO.setCmssNum("CMSS000001");
		cmssVO = ossCmmService.selectByCmss(cmssVO);
		Float tamnaoCmss = Float.parseFloat(cmssVO.getAdjAplPct());

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (보험정보) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<>();
		request.add("crtfcKey", RIB_KEY);
		request.add("crtfcAuthorKey",RIB_AUTH_KEY);
		request.add("resveBeginDe",prdtSVO.getsFromDt());
		request.add("resveBeginHm",prdtSVO.getsFromTm());
		request.add("resveEndDe",prdtSVO.getsToDt());
		request.add("resveEndHm",prdtSVO.getsToTm());
		request.add("clientCode",prdtVO.getCorpId());
		request.add("vhctyCode",prdtVO.getRcCardivNum());
		HttpEntity param = new HttpEntity<>(request, headers);

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		APIRibbonCarlistVO carlistVO = restTemplate.postForObject(RIB_URL+"carDetail.xml", param, APIRibbonCarlistVO.class);

		for(APIRibbonCarlistVOitems items : carlistVO.getBody().getItems() ){

			/** 차량이 한대도 없으면 continue */
			if(Integer.parseInt(items.getPossibleCount()) < 1){
				continue;
			}

			for(APIRibbonCarlistVOitem item : items.getItem() ){

				/** 차량코드 */
					prdtVO.setRcCardivNum(items.getVhctyCode());

				/** 업체코드 */
				prdtVO.setCorpId(item.getClientCode());

				/** 차량 정요금 */
				prdtVO.setRegularCarAmt(item.getStdPrice());

				/** 차량 할인율 */
				prdtVO.setCarDisRate(item.getStdDiscount());

				/** 차량 판매요금 */
				prdtVO.setSellCarAmt(item.getStdSalePrice());

				/** 차량-자차미포함 판매여부*/
				if("1".equals(prdtVO.getLinkMappingIsrNum())){

					/** 차량 판매요금 */
					prdtVO.setSaleAmt(item.getStdSalePrice());

					/** 판매가/입금가 */
					if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
						prdtVO.setSaleAmt(Integer.toString((int)((Integer.parseInt(item.getStdSalePrice()) * 100) / (100 - tamnaoCmss) / 10) * 10));
					}

					/** 차량 대여제한 나이 */
					prdtVO.setRntQlfctAge(item.getStdAge());

					/** 차량 대여제한 경력 */
					prdtVO.setRntQlfctCareer(item.getStdCareer());

					/** 자차미보험 */
					prdtVO.setLinkMappingIsrNum("1");

					prdtVO.setAbleYn("Y");
				}

				/** 일반자차*/
				if("2".equals(prdtVO.getLinkMappingIsrNum())){

					/** 일반보험포함 차량 판매금액 */
					prdtVO.setSaleAmt(item.getInsuGnrlSaleAdupPrice());

					/** 판매가/입금가 */
					if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
						prdtVO.setSaleAmt(Integer.toString((int)((Integer.parseInt(item.getInsuGnrlSaleAdupPrice()) * 100) / (100 - tamnaoCmss) / 10) * 10));
					}

					/** 일반보험 제한나이 */
					prdtVO.setGeneralIsrAge(item.getInsuGnrlApplcLmttAge());

					/** 일반보험 제한경력 */
					prdtVO.setGeneralIsrCareer(item.getInsuGnrlApplcDrverLmttCareer());

					/** 일반보험 보상한도 금액 */
					prdtVO.setGeneralIsrRewardAmt(item.getInsuGnrlRewardLmtAmount());

					/** 일반보험 면책금 금액 */
					prdtVO.setGeneralIsrBurcha(item.getInsuGnrlAcdntNoresponsAmount());

					/** 일반보험 보상한도 내용 */
					prdtVO.setIsrAmtGuide(item.getInsuGnrlRewardLmtContents());

					/** 일반보험 정요금 */
					prdtVO.setRegularInsuranceAmt(item.getInsuGnrlPrice());

					/** 일반보험 할인율 */
					prdtVO.setInsuranceDisRate(item.getInsuGnrlDiscount());

					/** 일반보험 판매요금 */
					prdtVO.setSellInsuranceAmt(item.getInsuGnrlSalePrice());

					prdtVO.setAbleYn("Y");
				}

				/** 고급자차 판매여부 */
				if("3".equals(prdtVO.getLinkMappingIsrNum())){

					/** 고급보험포함 차량 판매금액 */
					prdtVO.setSaleAmt(item.getInsuPrfectSaleAdupPrice());

					/** 판매가/입금가 */
					if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
						prdtVO.setSaleAmt(Integer.toString((int)((Integer.parseInt(item.getInsuPrfectSaleAdupPrice()) * 100) / (100 - tamnaoCmss) / 10) * 10));
					}

					/** 고급보험 제한나이 */
					prdtVO.setLuxyIsrAge(item.getInsuPrfectApplcLmttAge());

					/** 고급보험 제한경력 */
					prdtVO.setLuxyIsrCareer(item.getInsuPrfectApplcDrverLmttCareer());

					/** 고급보험 보상한도 금액 */
					prdtVO.setLuxyIsrRewardAmt(item.getInsuPrfectRewardLmtAmount());

					/** 고급보험 면책금 금액 */
					prdtVO.setLuxyIsrBurcha(item.getInsuPrfectAcdntNoresponsAmount());

					/** 고급보험 보상한도 내용 */
					prdtVO.setIsrAmtGuide(item.getInsuPrfectRewardLmtContents());

					/** 고급보험 정요금 */
					prdtVO.setRegularInsuranceAmt(item.getInsuPrfectPrice());

					/** 고급보험 할인율 */
					prdtVO.setInsuranceDisRate(item.getInsuPrfectDiscount());

					/** 고급보험 판매요금 */
					prdtVO.setSellInsuranceAmt(item.getInsuPrfectSalePrice());

					prdtVO.setAbleYn("Y");
				}
			}
		}

		return prdtVO;
	}

	public String carResv(String rcRsvNum){
		/** 예약정보 */
		RC_RSVVO rsvDtlVO = new RC_RSVVO();
		rsvDtlVO.setRcRsvNum(rcRsvNum);
		rsvDtlVO = rsvDAO.selectRcDetailRsv(rsvDtlVO);

		/** 상품정보 */
		RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
		prdtSVO.setsPrdtNum(rsvDtlVO.getPrdtNum());
		prdtSVO.setsFromDt(rsvDtlVO.getRentStartDt());
		prdtSVO.setsFromTm(rsvDtlVO.getRentStartTm());
		prdtSVO.setsToDt(rsvDtlVO.getRentEndDt());
		prdtSVO.setsToTm(rsvDtlVO.getRentEndTm());
		prdtSVO.setsApiRentDiv(rsvDtlVO.getApiRentDiv());
		RC_PRDTINFVO prdtVO = webRcProductService.selectRcPrdt(prdtSVO);


		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (보험정보) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<>();
		request.add("crtfcKey", RIB_KEY);
		request.add("crtfcAuthorKey",RIB_AUTH_KEY);
		request.add("resveBeginDe",prdtSVO.getsFromDt());
		request.add("resveBeginHm",prdtSVO.getsFromTm());
		request.add("resveEndDe",prdtSVO.getsToDt());
		request.add("resveEndHm",prdtSVO.getsToTm());
		/**업체코드*/
		request.add("clientCode",prdtVO.getCorpId());
		/**차량코드*/
		request.add("vhctyCode",prdtVO.getRcCardivNum());
		/**예약자명*/
		request.add("rsvctmNm",rsvDtlVO.getRsvNm());
		/**예약자연락처*/
		request.add("rsvctmCttpc1Encpt",rsvDtlVO.getRsvTelnum());
		/** 차량 정요금*/
		request.add("vhcleChrge",prdtVO.getRegularCarAmt());
		/** 차량 판매가격*/
		request.add("vhcleApplcChrge",prdtVO.getSellCarAmt());
		/** 차량 할인율*/
		request.add("vhcleChrgeDscntRt",prdtVO.getCarDisRate());
		/** 보험종류코드*/
		request.add("insrncKndSn",prdtVO.getLinkMappingIsrNum());
		if(!"1".equals(prdtVO.getLinkMappingIsrNum())){
			/** 보험정요금*/
			request.add("insrncChrge",prdtVO.getRegularInsuranceAmt());
			/**보험판매금액*/
			request.add("insrncApplcChrge",prdtVO.getSellInsuranceAmt());
			/**보험할인율*/
			request.add("insrncChrgeDscntRt",prdtVO.getInsuranceDisRate());
		}
		/**예약자(운전자)명*/
		request.add("drverNm",rsvDtlVO.getUseNm());
		/**예약자(운전자)연락처*/
		request.add("rsvctmCttpc2Encpt",rsvDtlVO.getUseTelnum());
		/**예약번호(탐나오)*/
		request.add("resveNo",rsvDtlVO.getRcRsvNum());
		/**블록사용여부*/
		request.add("blckUseYn","N");
		/**메모내용*/
		request.add("cmmnEtcContents","");
		/**직불금액*/
		request.add("fipayamntAmount","0");

		HttpEntity param = new HttpEntity<>(request, headers);

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		APIRibbonCarlistVO carlistVO = restTemplate.postForObject(RIB_URL+"carResv.xml", param, APIRibbonCarlistVO.class);

		/** 로그저장 초기화 */
		APIRCLOGVO apiRcLogVO = new APIRCLOGVO() ;
		/** 예약FLAG */
		apiRcLogVO.setApiRentDiv("R");
		apiRcLogVO.setSeqNum("0");
		apiRcLogVO.setRcRsvNum(rsvDtlVO.getRcRsvNum());
		apiRcLogVO.setRsvNum(rsvDtlVO.getRsvNum());
		apiRcLogVO.setRequestMsg(request.toString());

		/** if 성공시 예약번호 반환 */
		String linkMappingRsvnum = "";
		if(carlistVO.getHead().getResultCode().equals("OK")){
			linkMappingRsvnum = carlistVO.getBody().getResveNo();
			rsvDtlVO.setLinkMappingRsvnum(linkMappingRsvnum);
			/** 예약번호 업데이트 */
			rsvDAO.updateRcLinkYn(rsvDtlVO);
			apiRcLogVO.setRsvResult("0");
		}else{
			apiRcLogVO.setRsvResult("1");

			/** 실패 문자발송*/
			String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
			/** 인스 #이후 숫자제거*/
			String rsvNumStr = linkMappingRsvnum;
			if(rsvNumStr.lastIndexOf("#") >= 0){
				rsvNumStr = rsvNumStr.substring(0,rsvNumStr.lastIndexOf("#"));
			}
			MMSVO mmsVO = new MMSVO();
			mmsVO.setSubject("[탐나오]렌터카실시간API 취소오류알림");
			mmsVO.setMsg("[탐나오]렌터카실시간API 취소오류알림\n"
					+"예약번호(업체) : " + rsvNumStr + "\n"
					+"예약번호(탐나오) : " + rsvDtlVO.getRsvNum() + "\n"
					+"예약자 : " + rsvDtlVO.getRsvNm() + "\n"
					+"연락처 : " + rsvDtlVO.getRsvTelnum() + "\n"
					+"취소불가이유 : " + carlistVO.getHead().getResultMsg() + "\n\n"
					+"*연계시스템 취소 불가건으로 탐나오상점관리자에 예약건이 없을경우, 업체시스템에서 직접 취소바랍니다."
			);
			mmsVO.setStatus("0");
			mmsVO.setFileCnt("0");
			mmsVO.setType("0");
			/*담당자 MMS발송 - 테스트빌드시 결제 메시지 김재성*/
			if("test".equals(CST_PLATFORM.trim())) {
				mmsVO.setPhone(Constant.TAMNAO_TESTER1);
			}else{
				mmsVO.setPhone(rsvDtlVO.getAdmMobile());
			}
			mmsVO.setCallback(EgovProperties.getProperty("CS.PHONE"));
			try {
				smsService.sendMMS(mmsVO);
			} catch (Exception e) {
				log.info("MMS Error");
			}

			/* 담당자2 MMS 발송 */
			if(StringUtils.isNotEmpty(rsvDtlVO.getAdmMobile2())) {
				/*테스트빌드시*/
				if("test".equals(CST_PLATFORM.trim())) {
					mmsVO.setPhone(Constant.TAMNAO_TESTER2);
				}else{
					mmsVO.setPhone(rsvDtlVO.getAdmMobile2());
				}
				try {
					smsService.sendMMS(mmsVO);
				} catch (Exception e) {
					log.info("MMS Error");
				}
			}

			/* 담당자3 MMS 발송 */
			if(StringUtils.isNotEmpty(rsvDtlVO.getAdmMobile3())) {
				/*테스트빌드시*/
				if("test".equals(CST_PLATFORM.trim())) {
					mmsVO.setPhone(Constant.TAMNAO_TESTER3);
				}else{
					mmsVO.setPhone(rsvDtlVO.getAdmMobile3());
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
		return linkMappingRsvnum;

	};

	public Boolean carCancel(RC_RSVVO rcRsvVO){

		Boolean cancelResult = false;

		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (보험정보) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<>();
		request.add("crtfcKey", RIB_KEY);
		request.add("crtfcAuthorKey",RIB_AUTH_KEY);
		request.add("resveNo",rcRsvVO.getRcRsvNum());

		HttpEntity param = new HttpEntity<>(request, headers);

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		APIRibbonCarlistVO carlistVO = restTemplate.postForObject(RIB_URL+"carCancel.xml", param, APIRibbonCarlistVO.class);

		/** 로그저장 초기화 */
		APIRCLOGVO apiRcLogVO = new APIRCLOGVO() ;
		/** 예약FLAG */
		apiRcLogVO.setApiRentDiv("R");
		apiRcLogVO.setSeqNum("1");
		apiRcLogVO.setRcRsvNum(rcRsvVO.getRcRsvNum());
		apiRcLogVO.setRsvNum(rcRsvVO.getRsvNum());
		apiRcLogVO.setRequestMsg(request.toString());

		/** if 성공시 예약번호 반환 */
		if(carlistVO.getHead().getResultCode().equals("OK")){
			cancelResult = true;
			apiRcLogVO.setRsvResult("0");
		}else{
			apiRcLogVO.setRsvResult("1");
		}
		/**로그 저장*/
		apiDAO.insertRcApiLog(apiRcLogVO);
		return cancelResult;

	};

	@Override
	public RC_PRDTINFVO ribDetailInfo(RC_PRDTINFVO webParam) {
		/** set Header with a json type */
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		/** set api cmd (보험정보) */
		MultiValueMap<String, String> request = new LinkedMultiValueMap<>();
		request.add("crtfcKey", RIB_KEY);
		request.add("crtfcAuthorKey",RIB_AUTH_KEY);
		request.add("clientId",webParam.getCorpId());

		HttpEntity param = new HttpEntity<>(request, headers);

		/** send Api */
		RestTemplate restTemplate = new RestTemplate();
		APIRibbonCarModelinfoVO APIRibbonCarModelinfoVo = restTemplate.postForObject(RIB_URL+"carModelInfo.xml", param, APIRibbonCarModelinfoVO.class);

		RC_PRDTINFVO apiRcPrdtVO = new RC_PRDTINFVO();
		/** 통신성공 */
		if("OK".equals(APIRibbonCarModelinfoVo.getHead().getResultCode())){
			/** 매핑시작 */
			for(APIRibbonCarModelinfoVOitem item : APIRibbonCarModelinfoVo.getBody().getItem()){
				if(webParam.getRcCardivNum().equals(item.getBcncVhctyCode())){
				/** 등록자*/
				apiRcPrdtVO.setFrstRegId("admin");
				apiRcPrdtVO.setLastModId("admin");
				/** 업체ID(탐나오)*/
				apiRcPrdtVO.setCorpId(item.getClientId());
				/** 차량ID(탐나오) */
				apiRcPrdtVO.setRcCardivNum(item.getBcncVhctyCode());
				/** 차량명(리본) */
				apiRcPrdtVO.setCarDivNm(item.getBcncVhctyNm());
				/** 차량매핑코드(리본) */
				apiRcPrdtVO.setLinkMappingNum(item.getVhctyCode());
				/** 변속기 */
				if(item.getGearNm().equals("자동")){
					apiRcPrdtVO.setTransDivNm("자동");
				}else{
					apiRcPrdtVO.setTransDivNm("수동");
				}
				/** 연식 */
				apiRcPrdtVO.setModelYear(item.getYemodel());
				/** 면허 */
				apiRcPrdtVO.setRntQlfctLicense(item.getLicense());
				/** 연령 */
				apiRcPrdtVO.setRntQlfctAge(item.getLicenseLmttAge());
				/** 경력 */
				apiRcPrdtVO.setRntQlfctCareer(item.getLicenseLmttCareer());
				apiRcPrdtVO.setIconCds(item.getOptionSafeNm()+","+item.getOptionCnvncNm()+","+item.getOptionSondNm());
				break;
				}
			}
		/** 통신실패 */
		}else{
			apiRcPrdtVO.setAbleYn("N");
		}
		return apiRcPrdtVO;
	}
}
