package web.product.service.impl;

import api.service.APIInsService;
import api.service.APIOrcService;
import api.service.APIRibbonService;
import api.service.APIService;
import api.vo.APIOrcCarlistVO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import common.Constant;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import io.burt.jmespath.Expression;
import io.burt.jmespath.jackson.JacksonRuntime;
import mas.rc.service.impl.RcDAO;
import mas.rc.vo.RC_PRDTCNTVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import oss.cmm.service.OssCmmService;
import oss.corp.vo.CMSSVO;
import web.product.service.WebRcProductService;
import javax.annotation.Resource;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.*;
import java.util.concurrent.*;
import java.util.stream.Collectors;

@Service("webRcProductService")
public class WebRcProductServiceImpl extends EgovAbstractServiceImpl implements WebRcProductService {

	org.apache.logging.log4j.Logger log = (org.apache.logging.log4j.Logger) LogManager.getLogger(this.getClass());

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(WebRcProductServiceImpl.class);

	@Resource(name = "rcDAO")
	private RcDAO rcDAO;

	@Resource(name = "webRcDAO")
	private WebRcDAO webRcDAO;

	@Resource(name = "apiService")
	private APIService apiService;

	@Resource(name="apiInsService")
	private APIInsService apiInsService;

	@Resource(name="apiRibbonService")
	private APIRibbonService apiRibbonService;

	@Resource(name="apiOrcService")
	private APIOrcService apiOrcService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name="executorService")
    private ExecutorService executor;

	/*실시간 렌터카 리스트 카운트 조회*/
	@Override
	public Integer selectWebRcPrdtListCnt(RC_PRDTINFSVO prdtSVO) {
		return rcDAO.selectWebRcPrdtListCnt(prdtSVO);
	}

	/** 렌터카API + 탐나오상품 리스트 가져오기*/
	@Override
	public Map<String, Object> selectRcPrdtList(RC_PRDTINFSVO prdtSVO) throws IOException, ParseException, InterruptedException, ExecutionException {
		Map<String, Object> resultMap = new HashMap<>();
		/** get API 렌터카 리스트*/
		List<RC_PRDTINFVO> apiResultList = rcDAO.selectAPIRcPrdtList(prdtSVO);

		List<RC_PRDTINFVO> finalResultList = new ArrayList<>();

		String sDate = prdtSVO.getsFromDt() + prdtSVO.getsFromTm();
		String eDate = prdtSVO.getsToDt() + prdtSVO.getsToTm();

		if(Constant.FLAG_Y.equals(prdtSVO.getSearchYn())) {

        	Map<String, Future<List<RC_PRDTINFVO>>> futureMap = new LinkedHashMap<>();

			/** get 렌터카 수수료율 for 입금가계산 */
			CMSSVO cmssVO = new CMSSVO();
			cmssVO.setCmssNum("CMSS000001");
			cmssVO = ossCmmService.selectByCmss(cmssVO);
			final Float adjAplPct = Float.parseFloat(cmssVO.getAdjAplPct());

			/** thread0 탐나오 */
			futureMap.put("tamnao", executor.submit(() -> {
				prdtSVO.setsApiRentDiv("N");
				List<RC_PRDTINFVO> resultList = rcDAO.selectWebRcPrdtList(prdtSVO);
				return resultList;
			}));
			/** thread1 그림API */
			futureMap.put("gri", executor.submit(() -> {
				List<RC_PRDTINFVO> resultStreamGri = apiResultList.stream().filter(t -> StringUtils.equals("G", t.getApiRentDiv())).collect(Collectors.toList());
				try{
					/** set Api */
					BufferedReader rd = null;
					String rcAbleChkUrl = "http://tamnao.mygrim.com/carlist.php";
					String rcAbleChkParam = "tamnao_loginid=" + "xkaskdhrmfladusruf2018" + "&tamnao_loginpw=" + "qlqjs2018" + "&st=" + sDate + "&et=" + eDate;

					URL url = new URL(rcAbleChkUrl);
					URLConnection conn = url.openConnection();

					conn.setDoOutput(true);
					OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
					wr.write(rcAbleChkParam);
					wr.flush();

					rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
					/** API결과 */
					StringBuilder rdStr = new StringBuilder();
					rdStr.append(rd.readLine());

					ObjectMapper objectMapper = new ObjectMapper();
					JsonNode rootNode = objectMapper.readTree(rdStr.toString());
					JacksonRuntime runtime = new JacksonRuntime();

					for (Iterator<RC_PRDTINFVO> it = resultStreamGri.iterator(); it.hasNext(); ) {
						RC_PRDTINFVO prdtVO = it.next();

						/** 고급자차 무제한으로 변경 */
						if("LUXY".equals(prdtVO.getIsrTypeDiv())){
							if("0".equals(prdtVO.getLuxyIsrRewardAmt())  && "0".equals(prdtVO.getLuxyIsrBurcha()) || "-1".equals(prdtVO.getLuxyIsrRewardAmt())  && "0".equals(prdtVO.getLuxyIsrBurcha())){
								prdtVO.setIsrTypeDiv("ULIM");
							}
						}

						int saleAmt = 0;
						int isrAmt = 0;
						int totalSaleAmt = 0;

						/** 차량금액 */
						Expression<JsonNode> expression1 = runtime.compile(prdtVO.getCorpId() + "." + "\"" + prdtVO.getLinkMappingNum() + "\"" + ".model_salefee");
						JsonNode carfee = expression1.search(rootNode);
						if(!carfee.isNull()){
							saleAmt = carfee.asInt();
							prdtVO.setAbleYn("Y");
						}else{
							it.remove();
							continue;
						}

						/** 보험금액 */
						if ("ID10".equals(prdtVO.getIsrDiv())) {
							if(prdtVO.getLinkMappingIsrNum() != null && !"".equals(prdtVO.getLinkMappingIsrNum()) ){
								Expression<JsonNode> expression2 = runtime.compile(prdtVO.getCorpId() + "." + "\"" + prdtVO.getLinkMappingNum() + "\"" + ".insurance." + "\"" + prdtVO.getLinkMappingIsrNum() + "\".insurance_salefee" );
								JsonNode isrFee = expression2.search(rootNode);
								if(!isrFee.isNull()){
									isrAmt = isrFee.asInt();
									prdtVO.setAbleYn("Y");
								}else{
									it.remove();
									continue;
								}
							}else{
								it.remove();
								continue;
							}
						}

						if ("ID10".equals(prdtVO.getIsrDiv())) {
							totalSaleAmt = saleAmt + isrAmt;
							if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
								totalSaleAmt = (int)((totalSaleAmt * 100) / (100 - adjAplPct) / 10) * 10;
							}
						} else {
							totalSaleAmt = saleAmt;
							if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
								totalSaleAmt = (int)((totalSaleAmt * 100) / (100 - adjAplPct) / 10) * 10;
							}
						}

						if(totalSaleAmt < 1){
							it.remove();
						}
						prdtVO.setSaleAmt(Integer.toString(totalSaleAmt));
					}
					rd.close();
				}catch(Exception e){
					log.info("gri api error : " + e.getMessage());
					resultStreamGri = Collections.emptyList();
				}
				return resultStreamGri;
			}));
			/** thread2 인스API */
			futureMap.put("ins", executor.submit(() -> {
				List<RC_PRDTINFVO> resultStreamIns = apiResultList.stream().filter(t -> StringUtils.equals("I", t.getApiRentDiv())).collect(Collectors.toList());
				List<RC_PRDTINFVO> insList = apiInsService.carsearch(prdtSVO);
				try {
					/** 인스 매핑*/
					for (Iterator<RC_PRDTINFVO> it = resultStreamIns.iterator(); it.hasNext(); ) {
						RC_PRDTINFVO prdtVO = it.next();
						/** 인스 */
						try{
							if(Constant.RC_RENTCAR_COMPANY_INS.equals(prdtVO.getApiRentDiv())){
							for(RC_PRDTINFVO insPrdt : insList){
								if(prdtVO.getCorpId().equals(insPrdt.getCorpId()) && prdtVO.getLinkMappingNum().equals(insPrdt.getLinkMappingNum())){
									prdtVO.setAbleYn("Y");

									/** 고급자차 무제한으로 변경 */
									if("LUXY".equals(prdtVO.getIsrTypeDiv())){
										if("0".equals(prdtVO.getLuxyIsrRewardAmt())  && "0".equals(prdtVO.getLuxyIsrBurcha()) || "-1".equals(prdtVO.getLuxyIsrRewardAmt())  && "0".equals(prdtVO.getLuxyIsrBurcha())){
											prdtVO.setIsrTypeDiv("ULIM");
										}
									}

									/** set 입금가 with 판매가변환*/
									if(prdtVO.getLinkMappingIsrNum() == null || "".equals(prdtVO.getLinkMappingIsrNum()) ){
										String saleVal = insPrdt.getNetAmt();
										if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
											saleVal = Integer.toString((int)((Integer.parseInt(insPrdt.getNetAmt()) * 100) / (100 - adjAplPct) / 10) * 10);
										}
										prdtVO.setSaleAmt(saleVal);
										break;
									}else if(prdtVO.getLinkMappingIsrNum().equals("1")){
										String saleVal = insPrdt.getNet1Amt();
										if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
											saleVal = Integer.toString((int)((Integer.parseInt(insPrdt.getNet1Amt()) * 100) / (100 - adjAplPct) / 10) * 10);
										}
										prdtVO.setSaleAmt(saleVal);
										break;
									}else if(prdtVO.getLinkMappingIsrNum().equals("2")){
										String saleVal = insPrdt.getNet2Amt();
										if(Constant.FLAG_N.equals(prdtVO.getSellLink())) {
											saleVal = Integer.toString((int) ((Integer.parseInt(insPrdt.getNet2Amt()) * 100) / (100 - adjAplPct) / 10) * 10);
										}
										prdtVO.setSaleAmt(saleVal);
										break;
									}else{
										prdtVO.setAbleYn("N");
										break;
									}
								}
							}

							if (!Constant.FLAG_Y.equals(prdtVO.getAbleYn()) || "0".equals(prdtVO.getSaleAmt())) {
								it.remove();
							}
						}
					}catch (Exception e){
						log.info(e);
					}finally {

					}
				}
				}catch (Exception e){
					log.info("ins api error : " + e.getMessage());
					resultStreamIns = Collections.emptyList();
				}

				return resultStreamIns;
			}));
			/** thread3 리본API */
			futureMap.put("rib", executor.submit(() -> {
				List<RC_PRDTINFVO> resultStreamRib = apiResultList.stream().filter(t -> StringUtils.equals("R", t.getApiRentDiv())).collect(Collectors.toList());
				List<RC_PRDTINFVO> riblist = apiRibbonService.riblist(prdtSVO);
				try {
					/** 리본매핑 */
					for (Iterator<RC_PRDTINFVO> it = resultStreamRib.iterator(); it.hasNext(); ) {
						RC_PRDTINFVO prdtVO = it.next();
						if(Constant.RC_RENTCAR_COMPANY_RIB.equals(prdtVO.getApiRentDiv())) {

							for (RC_PRDTINFVO ribPrdt : riblist) {

								if (prdtVO.getCorpId().equals(ribPrdt.getCorpId()) && prdtVO.getRcCardivNum().equals(ribPrdt.getRcCardivNum()) && prdtVO.getLinkMappingIsrNum().equals(ribPrdt.getLinkMappingIsrNum())) {
									prdtVO.setRntQlfctAge(ribPrdt.getRntQlfctAge());
									prdtVO.setRntQlfctCareer(ribPrdt.getRntQlfctCareer());
									prdtVO.setGeneralIsrRewardAmt(ribPrdt.getGeneralIsrRewardAmt());
									prdtVO.setGeneralIsrBurcha(ribPrdt.getGeneralIsrBurcha());
									prdtVO.setLuxyIsrRewardAmt(ribPrdt.getLuxyIsrRewardAmt());
									prdtVO.setLuxyIsrBurcha(ribPrdt.getLuxyIsrBurcha());
									prdtVO.setAbleYn("Y");
									prdtVO.setSaleAmt(ribPrdt.getSaleAmt());
									/** 판매가/입금가 */
									if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
										prdtVO.setSaleAmt(Integer.toString((int)((Integer.parseInt(ribPrdt.getSaleAmt()) * 100) / (100 - adjAplPct) / 10) * 10));
									}

									/** 고급자차 무제한으로 변경 */
									if("LUXY".equals(prdtVO.getIsrTypeDiv()) && !"CRCO180002".equals(prdtVO.getCorpId())){
										if("0".equals(prdtVO.getLuxyIsrRewardAmt())  && "0".equals(prdtVO.getLuxyIsrBurcha()) || "-1".equals(prdtVO.getLuxyIsrRewardAmt())  && "0".equals(prdtVO.getLuxyIsrBurcha())){
											prdtVO.setIsrTypeDiv("ULIM");
										}
									}
									break;
								}
							}
							if (!Constant.FLAG_Y.equals(prdtVO.getAbleYn()) || "0".equals(prdtVO.getSaleAmt())) {
								it.remove();
							}
						}
					}
				}catch(Exception e){
					log.info("rib api error : " + e.getMessage());
					resultStreamRib = Collections.emptyList();
				}
				return resultStreamRib;
			}));
			/** thread4 오르카API */
			futureMap.put("orc", executor.submit(() -> {
				List<RC_PRDTINFVO> resultStreamOrc = apiResultList.stream().filter(t -> StringUtils.equals("O", t.getApiRentDiv())).collect(Collectors.toList());
				try {
					List<APIOrcCarlistVO> orcList = apiOrcService.vehicleAvailList(prdtSVO);
					for (Iterator<RC_PRDTINFVO> it = resultStreamOrc.iterator(); it.hasNext(); ) {
						RC_PRDTINFVO prdtVO = it.next();
						if (Constant.RC_RENTCAR_COMPANY_ORC.equals(prdtVO.getApiRentDiv())) {
							for (APIOrcCarlistVO orcPrdt : orcList) {
								if (prdtVO.getCorpId().equals(orcPrdt.getVehicleModel().getPartnersCompanyCode()) && prdtVO.getLinkMappingNum().equals(Integer.toString(orcPrdt.getVehicleModel().getId()))) {
									/** 수량없으면 */
									if (orcPrdt.getAvailableVehicleCount() < 1) {
										prdtVO.setAbleYn("N");
										break;
									}

									if (prdtVO.getLinkMappingIsrNum() == null) {
										prdtVO.setSaleAmt(Integer.toString(orcPrdt.getStandardPrice()));
										if (Constant.FLAG_N.equals(prdtVO.getSellLink())) {
											prdtVO.setSaleAmt(Integer.toString((int) ((orcPrdt.getStandardPrice() * 100) / (100 - adjAplPct) / 10) * 10));
										}
										prdtVO.setAbleYn("Y");
										break;
									}
									if (prdtVO.getLinkMappingIsrNum().equals("1")) {
										prdtVO.setSaleAmt(Integer.toString(orcPrdt.getBasicInsuredPrice()));
										if (Constant.FLAG_N.equals(prdtVO.getSellLink())) {
											prdtVO.setSaleAmt(Integer.toString((int) ((orcPrdt.getBasicInsuredPrice() * 100) / (100 - adjAplPct) / 10) * 10));
										}
										prdtVO.setAbleYn("Y");
										break;
									}
									if (prdtVO.getLinkMappingIsrNum().equals("2")) {
										prdtVO.setSaleAmt(Integer.toString(orcPrdt.getPremiumInsuredPrice()));
										if (Constant.FLAG_N.equals(prdtVO.getSellLink())) {
											prdtVO.setSaleAmt(Integer.toString((int) ((orcPrdt.getPremiumInsuredPrice() * 100) / (100 - adjAplPct) / 10) * 10));
										}
										prdtVO.setAbleYn("Y");
										break;
									}
								}
							}
							if (!Constant.FLAG_Y.equals(prdtVO.getAbleYn()) || "0".equals(prdtVO.getSaleAmt())) {
								it.remove();
							}
						}
					}
				}catch (Exception e){
					log.info("orc api error : " + e.getMessage());
					resultStreamOrc = Collections.emptyList();
				}
				return resultStreamOrc;
			}));

			for (Map.Entry<String, Future<List<RC_PRDTINFVO>>> entry : futureMap.entrySet()) {
            try {
                List<RC_PRDTINFVO> result = entry.getValue().get(5, TimeUnit.SECONDS);
                finalResultList.addAll(result);
            } catch (TimeoutException e) {
                log.warn("[TIMEOUT] " + entry.getKey() + " API 응답 지연으로 무시됨");
            } catch (Exception e) {
                log.warn("[ERROR] " + entry.getKey() + " API 예외 발생: " + e.getMessage());
            }
        }
		}
		resultMap.put("resultList", finalResultList);
		return resultMap;
	}


	/** 렌터카상품정보 단건 가져오기*/
	@Override
	public RC_PRDTINFVO selectRcPrdt(RC_PRDTINFSVO prdtSVO){
		/** get 렌터카상품정보 */
		RC_PRDTINFVO prdtVO;
		/** 실시간 비실시간 분기 */
		if(Constant.FLAG_N.equals(rcDAO.selectAPIRentDiv(prdtSVO))){
			prdtVO = rcDAO.selectWebRcPrdt(prdtSVO);
		}else{
			prdtVO = rcDAO.selectAPIRcPrdt(prdtSVO);
		}

		/** if 상품정보없을경우 */
		if(prdtVO == null){
			prdtVO.setAbleYn("N");
			prdtVO.setSaleAmt("");
			return prdtVO;
		}

		try {
			/** chk 최대예약시간, 최소예약시간 */
				if(Constant.FLAG_Y.equals(prdtVO.getCorpLinkYn()) && !EgovStringUtil.isEmpty(prdtVO.getLinkMappingNum()) && Constant.FLAG_Y.equals(prdtVO.getCorpAbleYn())){
					/** chk그림API */
					if(Constant.RC_RENTCAR_COMPANY_GRI.equals(prdtVO.getApiRentDiv())){
						try{
							prdtVO = apiRcData(prdtSVO , prdtVO);
						}catch(NullPointerException e){
							prdtVO.setAbleYn("N");
							prdtVO.setSaleAmt("-2");
						}
					/** chk인스API */
					}else if(Constant.RC_RENTCAR_COMPANY_INS.equals(prdtVO.getApiRentDiv())){
						try{
							prdtVO = apiInsService.carsearchbymodelcodes(prdtSVO , prdtVO);
						}catch(NullPointerException e){
							prdtVO.setAbleYn("N");
							prdtVO.setSaleAmt("-2");
						}
					/** chk리본API */
					}else if(Constant.RC_RENTCAR_COMPANY_RIB.equals(prdtVO.getApiRentDiv())){
						try{
							prdtVO = apiRibbonService.ribDetail(prdtSVO , prdtVO);
						}catch(NullPointerException e){
							prdtVO.setAbleYn("N");
							prdtVO.setSaleAmt("-2");
						}
					}else if(Constant.RC_RENTCAR_COMPANY_ORC.equals(prdtVO.getApiRentDiv())){
						try{
							prdtVO = apiOrcService.vehicleAvailDetail(prdtSVO , prdtVO);
						}catch(NullPointerException e){
							prdtVO.setAbleYn("N");
							prdtVO.setSaleAmt("-2");
						}
					}
				}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return prdtVO;
	}

	@Override
	public RC_PRDTINFVO apiRcData(RC_PRDTINFSVO prdtSVO, RC_PRDTINFVO prdtVO) throws IOException, ParseException {
		BufferedReader rd = null;

		String sDate = prdtSVO.getsFromDt() + prdtSVO.getsFromTm();
		String eDate = prdtSVO.getsToDt() + prdtSVO.getsToTm();

		String rcAbleChkUrl = "http://tamnao.mygrim.com/carlist.php";
		String rcAbleChkParam = "tamnao_loginid=" + grimLoginId + "&tamnao_loginpw=" + grimLoginPw +"&st=" + sDate + "&et=" + eDate + "&tamnao_cid=" + prdtVO.getCorpId() + "&rentcar_mid=" + prdtVO.getLinkMappingNum();

		URL url = null;
		try {
			url = new URL(rcAbleChkUrl);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
		URLConnection conn = url.openConnection();

		conn.setDoOutput(true);
		OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
		wr.write(rcAbleChkParam);
		wr.flush();

		rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		/** API결과 */

		StringBuilder rdStr = new StringBuilder();
		rdStr.append(rd.readLine());

		JSONParser jsonParser = new JSONParser();
		/** obj는 업체ID를 담고 있음*/
		JSONObject obj = (JSONObject) jsonParser.parse(rdStr.toString());
		JSONObject obj2 = null;
		JSONObject obj3 = null;
		JSONObject obj4 = null;
		JSONObject obj5 = null;

		Integer saleAmt = 0;
		Integer istAmt = 0;
		if(obj != null){
			/** 업체ID SET*/
			try {
				obj2 = (JSONObject) jsonParser.parse(obj.get(prdtVO.getCorpId()).toString());
			}catch (Exception e){
				prdtVO.setAbleYn("N");
				return prdtVO;
			}
		}else{
			return prdtVO;
		}
		if(obj2 != null){
			obj3 = (JSONObject) jsonParser.parse(obj2.get(prdtVO.getLinkMappingNum()).toString());
			saleAmt = Integer.parseInt(obj3.get("model_salefee").toString());
			prdtVO.setCarAmt(obj3.get("model_salefee").toString());
			prdtVO.setAbleYn("Y");
			if(obj3.get("insurance") != null){
				obj4 = (JSONObject) jsonParser.parse(obj3.get("insurance").toString());
			}
		}else{
			return prdtVO;
		}
		if(obj4 != null && StringUtils.isNotEmpty(prdtVO.getLinkMappingIsrNum())){
			obj5 = (JSONObject) jsonParser.parse(obj4.get(prdtVO.getLinkMappingIsrNum()).toString());
			istAmt = Integer.parseInt(obj5.get("insurance_salefee").toString());
			prdtVO.setIsrAmt(obj5.get("insurance_salefee").toString());
		}
		Integer sumSaleAmt =  saleAmt + istAmt;

		/** get 렌터카 수수료율 for 입금가계산 */
		CMSSVO cmssVO = new CMSSVO();
		cmssVO.setCmssNum("CMSS000001");
		cmssVO = ossCmmService.selectByCmss(cmssVO);
		final Float adjAplPct = Float.parseFloat(cmssVO.getAdjAplPct());

		if ("ID00".equals(prdtVO.getIsrDiv())) {
			prdtVO.setNetAmt(Integer.toString(saleAmt));
			if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
				saleAmt = (int)((saleAmt * 100) / (100 - adjAplPct) / 10) * 10;
			}
			prdtVO.setSaleAmt(Integer.toString(saleAmt));
		}else{
			/** 판매가/입금가 변환 */
			prdtVO.setNetAmt(Integer.toString(sumSaleAmt));
			if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
				sumSaleAmt = (int)((sumSaleAmt * 100) / (100 - adjAplPct) / 10) * 10;
			}
			prdtVO.setSaleAmt(Integer.toString(sumSaleAmt));
		}

		prdtVO.setAbleYn("Y");
		/** 판매금액이 0원일 경우 판매불가 */
		if(saleAmt < 1 ){
			prdtVO.setAbleYn("N");
		}
		rd.close();
		return prdtVO;
	}

	// 그림 API 로그인 ID/PW
	public String grimLoginId = "xkaskdhrmfladusruf2018";
	public String grimLoginPw = "qlqjs2018";



	/**
	 * 사용자 차량유형별 카운트 조회
	 * 파일명 : selectRcPrdtCntList
	 * 작성일 : 2015. 10. 22. 오후 9:07:13
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@Override
	public List<RC_PRDTCNTVO> selectRcPrdtCntList(RC_PRDTINFSVO prdtSVO){
		return rcDAO.selectRcPrdtCntList(prdtSVO);
	}

	/**
	 * 사용자 렌터카 기본정보 조회
	 * 파일명 : selectByPrdt
	 * 작성일 : 2015. 10. 26. 오후 5:43:58
	 * 작성자 : 최영철
	 * @param prdtVO
	 * @return
	 */
	@Override
	public RC_PRDTINFVO selectByPrdt(RC_PRDTINFVO prdtVO){
		return webRcDAO.selectByPrdt(prdtVO);
	}

	public List<RC_PRDTINFVO> selectRcPrdtList2(RC_PRDTINFSVO prdtSVO){
		prdtSVO.setsMainViewYn(null);
		List<RC_PRDTINFVO> resultList = rcDAO.selectWebRcPrdtList(prdtSVO);

		RC_PRDTINFVO prdtVO = resultList.get(0);
		if(Constant.FLAG_Y.equals(prdtVO.getCorpLinkYn()) && !EgovStringUtil.isEmpty(prdtVO.getLinkMappingNum())){
			String ableYn = apiService.chkGrimRcAble(prdtVO, prdtSVO).get("possiblenum");

			log.info("ableYn = " + ableYn);

			if(Integer.parseInt(ableYn) > 0){
				prdtVO.setAbleYn("Y");
			}else{
				prdtVO.setAbleYn("N");
			}
		}
		if(Constant.FLAG_Y.equals(prdtVO.getAbleYn()) && Constant.FLAG_Y.equals(prdtVO.getCorpAbleYn())){
			prdtVO.setAbleYn("Y");
		}else{
			prdtVO.setAbleYn("N");
		}
		resultList.set(0, prdtVO);

		return resultList;
	}



	/**
	 * 단건 가능여부 확인
	 * 파일명 : selectRcAble
	 * 작성일 : 2015. 10. 30. 오전 9:43:19
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@Override
	public RC_PRDTINFVO selectRcAble(RC_PRDTINFSVO prdtSVO){
		prdtSVO.setFirstIndex(0);
		prdtSVO.setLastIndex(1);
		RC_PRDTINFVO prdtVO = new RC_PRDTINFVO();

		List<RC_PRDTINFVO> resultList = rcDAO.selectWebRcPrdtList(prdtSVO);
		if(resultList.size() > 0){
			prdtVO = resultList.get(0);

			if(Constant.FLAG_Y.equals(prdtVO.getCorpLinkYn()) && !EgovStringUtil.isEmpty(prdtVO.getLinkMappingNum())){

				/** chk그림API */
				if(Constant.RC_RENTCAR_COMPANY_GRI.equals(prdtVO.getApiRentDiv())){
					String ableYn = apiService.chkGrimRcAble(prdtVO, prdtSVO).get("possiblenum");
					if(Integer.parseInt(ableYn) > 0){
						prdtVO.setAbleYn(Constant.FLAG_Y);
					}else{
						prdtVO.setAbleYn(Constant.FLAG_N);
					}
				/** chk인스API */
				}else if(Constant.RC_RENTCAR_COMPANY_INS.equals(prdtVO.getApiRentDiv())){
					try{
						prdtVO = apiInsService.carsearchbymodelcodes(prdtSVO , prdtVO);
					}catch(NullPointerException | IOException e){
						prdtVO.setAbleYn("N");
						prdtVO.setSaleAmt("-2");
					}
				/** chk리본API */
				}else if(Constant.RC_RENTCAR_COMPANY_RIB.equals(prdtVO.getApiRentDiv())){

				}
			}
		}else{
			prdtVO.setAbleYn(Constant.FLAG_N);
		}
		return prdtVO;
	}

	/**
	 * 베스트 상품
	 * 파일명 : selectRcBestPrdtList
	 * 작성일 : 2015. 11. 4. 오후 5:59:57
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<RC_PRDTINFVO> selectRcBestPrdtList(){
		return rcDAO.selectRcBestPrdtList();
	}


	@Override
	public List<RC_PRDTINFVO> selectWebRcPrdtListOssPrmt(RC_PRDTINFSVO prdtSVO) {
		return rcDAO.selectWebRcPrdtListOssPrmt(prdtSVO);
	}

	/**
	 * 여행사 렌터카 단품 카운트
	 * 파일명 : selectRcPackCnt
	 * 작성일 : 2016. 10. 25. 오후 3:32:12
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@Override
	public Integer selectRcPackCnt(RC_PRDTINFSVO prdtSVO){
		return rcDAO.selectRcPackCnt(prdtSVO);
	}

	/**
	 * 여행사 렌터카 단품 리스트
	 * 파일명 : selectRcPackList
	 * 작성일 : 2016. 10. 25. 오후 3:41:22
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@Override
	public List<RC_PRDTINFVO> selectRcPackList(RC_PRDTINFSVO prdtSVO){
		return rcDAO.selectRcPackList(prdtSVO);
	}



	@Override
	public List<RC_PRDTINFVO> selectWebRcPrdtListOssKwa(String kwaNum) {
		return rcDAO.selectWebRcPrdtListOssKwa(kwaNum);
	}


	/**
	 * 통합검색 렌터카 리스트 조회
	 * 파일명 : selectTotSchRcPrdtList
	 * 작성일 : 2020.06.22
	 * 작성자 : 김지연
	 * @param prdtSVO
	 * @return
	 */
	@Override
	public List<RC_PRDTINFVO> selectTotSchRcPrdtList(RC_PRDTINFSVO prdtSVO){
		return rcDAO.selectTotSchRcPrdtList(prdtSVO);
	}

	/**
	* 설명 : 누적예약, 예약가능 차량, 입점업체 수
	* 파일명 :
	* 작성일 : 2022-06-22 오후 2:39
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	@Cacheable(value = "selectIntroCount", key = "'main'")
	public HashMap<String, Integer> selectIntroCount(){
		return rcDAO.selectIntroCount();
	}
}
