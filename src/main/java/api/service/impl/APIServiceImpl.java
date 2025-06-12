package api.service.impl;

import api.service.*;
import api.vo.*;
import common.Constant;
import common.LowerHashMap;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.cmmn.service.SmsService;
import egovframework.cmmn.vo.MMSVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.AD_PRDTINFSVO;
import mas.prmt.vo.PRMTVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.service.impl.RcDAO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rsv.service.impl.RsvDAO;
import mas.sp.vo.SP_PRDTINFVO;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.corp.vo.CORPVO;
import oss.sp.service.impl.SpDAO;
import web.order.vo.RC_RSVVO;
import web.product.service.WebRcProductService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Service("apiService")
public class APIServiceImpl extends EgovAbstractServiceImpl implements APIService {
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@Resource(name = "apiDAO")
	private APIDAO apiDAO;

	@Resource(name="masAdPrdtService")
	private MasAdPrdtService masAdPrdtService;
	
	@Resource(name="masRcPrdtService")
	private MasRcPrdtService masRcPrdtService;
	
	@Resource(name="ossCmmService")
    private OssCmmService ossCmmService;
	
	@Resource(name = "spDAO")
	private SpDAO spDAO;
	
	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;
	
	@Resource(name = "rcDAO")
	private RcDAO rcDAO;

	@Resource(name="smsService")
	protected SmsService smsService;

	@Resource(name="apitlBookingService")
	private APITLBookingService apitlBookingService;

	@Resource(name="apiInsService")
	private APIInsService apiInsService;

	@Resource(name="apiRibbonService")
	private APIRibbonService apiRibbonService;

	@Resource(name="apiOrcService")
	private APIOrcService apiOrcService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "apiLsService")
	APILsService apiLsService;

	@Resource(name = "apiVpService")
	APIVpService apiVpService;

	@Resource(name = "apiYjService")
	APIYjService apiYjService;

	@Autowired
	APIAligoService apiAligoService;
	@Override
	public boolean apiReservation(String rsvNum) {
		boolean result = true;

		/** 예약 카테고리  */
		List<APIReservationVO> rsvVO = apiDAO.selectApiReservationCorpCdList(rsvNum);
		try {
			for (APIReservationVO resultVO : rsvVO) {
				/** 렌터카 예약처리*/
				if (resultVO.getCorpCd().equals(Constant.RENTCAR)) {
					result = apiRcReservation(rsvNum);
					/** 실패처리 */
					if(!result){
						break;
					}
				}
				/** 숙소 예약처리*/
				if (resultVO.getCorpCd().equals(Constant.ACCOMMODATION)) {
					/** TL린칸 */
					List<APITLBookingLogVO> listBooking = apitlBookingService.bookingSend(rsvNum);
					for ( APITLBookingLogVO bookingVO : listBooking) {
						if ("N".equals(bookingVO.getRsvResult())) {
							/** 실패처리 */
							result = false;
							break;
						}
					}
				}

				/** 소셜 예약처리*/
				if (resultVO.getCorpCd().equals(Constant.SOCIAL)) {
					/** LS컴퍼니 연동 */
					APILSVO apilsVO = new APILSVO();
					apilsVO.setRsvNum(rsvNum);
					if(!"Y".equals(apiLsService.requestOrderLsCompany(apilsVO))){
						log.info("fail : not available lsCompany order");
						result = false;
						break;
					}
					/** 브이패스 연동 */
					if(!"Y".equals(apiVpService.requestOrderVpCompany(apilsVO))){
						log.info("fail : not available vass order");
						result = false;
						break;
					}

					/** 야놀자 연동 */
					if(!"Y".equals(apiYjService.requestOrderYanolja(apilsVO))){
						log.info("fail : not available yanolja order");
						result = false;
						break;
					}
				}
			}
			/** 예약불가 발생시 전체취소 */
			if(!result){
				log.debug("start apiCancellation");
				apiCancellation(rsvNum);
			}
		} catch (Exception e){
			/** 예외발생 */
			result = false;
			/** 예약불가 발생시 전체취소 */
			apiCancellation(rsvNum);
		}
		return result;
	}

	public boolean apiRcReservation(String rsvNum) {
		boolean result = true;
		List<APIReservationVO> rsvVO = apiDAO.selectApiReservationDtlRsvNumList(rsvNum);
		try {
			for (APIReservationVO resultVO : rsvVO) {
				/** 그림API */
				if (Constant.RC_RENTCAR_COMPANY_GRI.equals(resultVO.getApiDiv())) {
					String dtlRsvNum = insertGrimRcRsv(resultVO.getDtlRsvNum());
					result = !EgovStringUtil.isEmpty(dtlRsvNum);
					/** 실패시 */
					if (!result) {
						break;
					}
				/** 인스API */
				} else if (Constant.RC_RENTCAR_COMPANY_INS.equals(resultVO.getApiDiv())) {
					String dtlRsvNum = apiInsService.revadd(resultVO.getDtlRsvNum());
					result = !EgovStringUtil.isEmpty(dtlRsvNum);
					/** 실패시 */
					if (!result) {
						break;
					}
				/** 리본API */
				} else if (Constant.RC_RENTCAR_COMPANY_RIB.equals(resultVO.getApiDiv())) {
					String dtlRsvNum = apiRibbonService.carResv(resultVO.getDtlRsvNum());
					result = !EgovStringUtil.isEmpty(dtlRsvNum);
					/** 실패시 */
					if (!result) {
						break;
					}
				/** 오르카API */
				} else if (Constant.RC_RENTCAR_COMPANY_ORC.equals(resultVO.getApiDiv())) {
					String dtlRsvNum = apiOrcService.vehicleReservation(resultVO.getDtlRsvNum());
					result = !EgovStringUtil.isEmpty(dtlRsvNum);
					if (!result) {
						break;
					}
				}
			}
		} catch (Exception e){
			result = false;
		}

		return result;
	}

	@Override
	public void apiCancellation(String rsvNum) {
		boolean result = true;
		/** 상세예약 카테고리, 업체코드 */
		List<APIReservationVO> dtlRsvVO = apiDAO.selectApiCancelList(rsvNum);
		try {
			for (APIReservationVO resultVO : dtlRsvVO) {
				/** 렌터카 취소*/
				if (resultVO.getCorpCd().equals(Constant.RENTCAR)) {
					/** 그림 취소*/
					if (Constant.RC_RENTCAR_COMPANY_GRI.equals(resultVO.getApiDiv())) {
						if(apiDAO.selectApiRcCancelItem(resultVO.getDtlRsvNum()) > 0 ){
							cancelGrimRcRsv(resultVO.getDtlRsvNum());
						}
					}
					/** 인스 취소 */
					if (Constant.RC_RENTCAR_COMPANY_INS.equals(resultVO.getApiDiv())) {
						RC_RSVVO rsvVO = new RC_RSVVO();
						rsvVO.setRsvNum(rsvNum);
						rsvVO.setRcRsvNum(resultVO.getDtlRsvNum());
						rsvVO.setLinkMappingRsvnum(resultVO.getApiRsvNum());
						rsvVO.setCorpId(resultVO.getCorpId());
						rsvVO.setRsvNm(resultVO.getRsvNm());
						rsvVO.setRsvTelnum(resultVO.getRsvTelnum());
						rsvVO.setAdmMobile(resultVO.getAdmMobile());
						rsvVO.setAdmMobile2(resultVO.getAdmMobile2());
						rsvVO.setAdmMobile3(resultVO.getAdmMobile3());
						try {
							if(apiDAO.selectApiRcCancelItem(resultVO.getDtlRsvNum()) > 0 ){
								apiInsService.revcancel(rsvVO);
							}
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					/** 리본 취소 */
					if (Constant.RC_RENTCAR_COMPANY_RIB.equals(resultVO.getApiDiv())) {
						RC_RSVVO rsvVO = new RC_RSVVO();
						rsvVO.setRsvNum(rsvNum);
						rsvVO.setRcRsvNum(resultVO.getDtlRsvNum());
						rsvVO.setLinkMappingRsvnum(resultVO.getApiRsvNum());
						rsvVO.setCorpId(resultVO.getCorpId());
						rsvVO.setRsvNm(resultVO.getRsvNm());
						rsvVO.setRsvTelnum(resultVO.getRsvTelnum());
						rsvVO.setAdmMobile(resultVO.getAdmMobile());
						rsvVO.setAdmMobile2(resultVO.getAdmMobile2());
						rsvVO.setAdmMobile3(resultVO.getAdmMobile3());
						try {
							if(apiDAO.selectApiRcCancelItem(resultVO.getDtlRsvNum()) > 0 ){
								apiRibbonService.carCancel(rsvVO);
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					/** 오르카 취소 */
					if (Constant.RC_RENTCAR_COMPANY_ORC.equals(resultVO.getApiDiv())) {
						RC_RSVVO rsvVO = new RC_RSVVO();
						rsvVO.setRsvNum(rsvNum);
						rsvVO.setRcRsvNum(resultVO.getDtlRsvNum());
						rsvVO.setLinkMappingRsvnum(resultVO.getApiRsvNum());
						rsvVO.setCorpId(resultVO.getCorpId());
						rsvVO.setRsvNm(resultVO.getRsvNm());
						rsvVO.setRsvTelnum(resultVO.getRsvTelnum());
						rsvVO.setAdmMobile(resultVO.getAdmMobile());
						rsvVO.setAdmMobile2(resultVO.getAdmMobile2());
						rsvVO.setAdmMobile3(resultVO.getAdmMobile3());
						try {
							if(apiDAO.selectApiRcCancelItem(resultVO.getDtlRsvNum()) > 0 ){
								apiOrcService.vehicleCancel(rsvVO);
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}

				/** 숙소 취소*/
				if (resultVO.getCorpCd().equals(Constant.ACCOMMODATION)) {
					/** TL린칸 취소*/
					if ("TLL".equals(resultVO.getApiDiv())) {
						APITLBookingLogVO bookingCancel = apitlBookingService.bookingCancel(resultVO.getDtlRsvNum());

						//취소 전송이 성공 하면 로직 실행 후 실패 처리
						if ("N".equals(bookingCancel.getRsvResult())) {
							result = false;
						}
					}
				}

				/** 소셜 취소*/
				if (resultVO.getCorpCd().equals(Constant.SOCIAL)) {
					/** 엘에스 취소*/
					if("Y".equals(resultVO.getApiDiv())){
						APILSVO apilsVO = new APILSVO();
						apilsVO.setSpRsvNum(resultVO.getDtlRsvNum());
						int j = Integer.parseInt(resultVO.getBuyNum()) - Integer.parseInt(resultVO.getUseNum()) ;
						log.info("lsCompany requst cancel cnt : " + j );
						JSONObject jsonObject = new JSONObject();
						for(int i=0; i<j; i++ ){
							/** transactionId, 0은예약상태 1은 취소*/
							jsonObject.put(resultVO.getDtlRsvNum() + "_" + i, 0);
						}
						apilsVO.setTransactionId(jsonObject.toString());
						apilsVO.setBuyNum(j);
						APILSRECIEVEVO apilsResultVO = apiLsService.requestCancelLsCompany(apilsVO);
						if(!"0000".equals(apilsResultVO.getResultCode())){
							result = false;
						}
					}
					/** 브이패스 취소*/
					if("V".equals(resultVO.getApiDiv())){
						APILSVO apilsVO = new APILSVO();
						apilsVO.setRsvNum(resultVO.getRsvNum());
						apilsVO.setSpRsvNum(resultVO.getDtlRsvNum());
						int j = Integer.parseInt(resultVO.getBuyNum()) - Integer.parseInt(resultVO.getUseNum()) ;
						log.info("vpass requst cancel cnt : " + j );
						JSONObject jsonObject = new JSONObject();
						for(int i=0; i<j; i++ ){
							/** transactionId, 0은예약상태 1은 취소*/
							jsonObject.put(resultVO.getDtlRsvNum() + "_" + i, 0);
						}
						apilsVO.setTransactionId(jsonObject.toString());
						apilsVO.setBuyNum(j);
						APILSRECIEVEVO apilsResultVO = apiVpService.requestCancelVpCompany(apilsVO);
						if(!"0000".equals(apilsResultVO.getResultCode())){
							result = false;
						}
					}

					if("J".equals(resultVO.getApiDiv())){
						APILSVO apilsVO = new APILSVO();
						apilsVO.setRsvNum(resultVO.getRsvNum());
						apilsVO.setSpRsvNum(resultVO.getDtlRsvNum());
						APILSRECIEVEVO apilsResultVO = apiYjService.requestCancelYj(apilsVO);
						if(!"0000".equals(apilsResultVO.getResultCode())){
							result = false;
						}
					}
				}
			}
		}catch(Exception e){
			sendAligoErrNoti(rsvNum);
		}

		if(!result){
			sendAligoErrNoti(rsvNum);
		}
	}

	private void sendAligoErrNoti(String rsvNum){
		String[] receivers = {Constant.TAMNAO_TESTER1,Constant.TAMNAO_TESTER2};
		String[] recvNames = {Constant.TAMNAO_TESTER_NAME1,Constant.TAMNAO_TESTER_NAME2};

		APIAligoVO aligoVO = new APIAligoVO();
		aligoVO.setTplCode("TT_1178");
		aligoVO.setReceivers(receivers);
		aligoVO.setRecvNames(recvNames);
		aligoVO.setSubject("[시스템]API 취소오류알림");
		aligoVO.setMsg("[탐나오]API 취소오류알림\n"
			+"예약번호 : " + rsvNum + "\n"
			+"취소오류발생!");
		aligoVO.setFailover("Y"); //대체문자발송여부

		apiAligoService.aligoKakaoSend(aligoVO);
	}

	@Override
	public DtlPrdtVO detailProductByCorp(CORPVO corpVO, HttpServletRequest request) {
		String url = request.getScheme() + "://" + request.getServerName();
		if(80 != request.getServerPort()) {
			url += ":" + request.getServerPort();
		}
		url += request.getContextPath() + "/web/" + corpVO.getCorpCd().toLowerCase()  ;
		
		if(corpVO.getCorpCd().equals(Constant.SOCIAL)) {
			String prdtNum = apiDAO.selectSpProductByCorp(corpVO.getCorpId());
			
			SP_PRDTINFVO spVO = new SP_PRDTINFVO();
			spVO.setPrdtNum(prdtNum);
			spVO = spDAO.selectBySpPrdtInf(spVO);
			
			if(Constant.SP_PRDT_DIV_FREE.equals(spVO.getPrdtDiv())){
				url += "/detailPrdt.do?prdtNum=" + prdtNum + "&prdtDiv=" + Constant.SP_PRDT_DIV_FREE;				
			}else{
				url += "/detailPrdt.do?prdtNum=" + prdtNum;
			}
		} else if(corpVO.getCorpCd().equals(Constant.RENTCAR)){
			url += "/productList.do?sCorpId=" + corpVO.getCorpId();
		} else if(corpVO.getCorpCd().equals(Constant.ACCOMMODATION)) {
			url +="/detailPrdt.do?corpId=" + corpVO.getCorpId();
		}
		
		DtlPrdtVO dtlPrdtVO = new DtlPrdtVO();
		dtlPrdtVO.setCorpNm(corpVO.getCorpNm());
		dtlPrdtVO.setUrl(url);
		return dtlPrdtVO;
	}
	
	@Override
	public DtlPrdtVO detailProductByVisitjeju(CORPVO corpVO, HttpServletRequest request) {
		String url = request.getScheme() + "://" + request.getServerName();
		if(80 != request.getServerPort()) {
			url += ":" + request.getServerPort();
		}
		url += request.getContextPath() + "/web/" + corpVO.getCorpCd().toLowerCase()  ;
		
		if(corpVO.getCorpCd().equals(Constant.SOCIAL)) {
			String prdtNum = apiDAO.selectSpProductByCorp(corpVO.getCorpId());
			
			SP_PRDTINFVO spVO = new SP_PRDTINFVO();
			spVO.setPrdtNum(prdtNum);
			spVO = spDAO.selectBySpPrdtInf(spVO);
			
			if(Constant.SP_PRDT_DIV_FREE.equals(spVO.getPrdtDiv())){
				url += "/detailPrdt.do?prdtNum=" + prdtNum + "&prdtDiv=" + Constant.SP_PRDT_DIV_FREE;				
			}else{
				url += "/detailPrdt.do?prdtNum=" + prdtNum;
			}
		} else if(corpVO.getCorpCd().equals(Constant.SV)) {
			String prdtNum = apiDAO.selectSvProductByCorp(corpVO.getCorpId());
			url += "/detailPrdt.do?prdtNum=" + prdtNum;
		} else if(corpVO.getCorpCd().equals(Constant.RENTCAR)){
			url += "/productList.do?sCorpId=" + corpVO.getCorpId();
		} else if(corpVO.getCorpCd().equals(Constant.ACCOMMODATION)) {
			url +="/detailPrdt.do?corpId=" + corpVO.getCorpId();
		}
		
		DtlPrdtVO dtlPrdtVO = new DtlPrdtVO();
		dtlPrdtVO.setRetCode("OK");
		dtlPrdtVO.setCorpNm(corpVO.getCorpNm());
		dtlPrdtVO.setUrl(url);
		return dtlPrdtVO;
	}

	@Override
	public List<SPPRDTSVO> spProductList(ParamVO paramVO, HttpServletRequest request) {
		String url = request.getScheme() + "://" + request.getServerName();
		if(80 != request.getServerPort()) {
			url += ":" + request.getServerPort();
		}
		String detailUrl = url + request.getContextPath() + "/web/sp/detailPrdt.do?prdtNum=";
		String imgUrl = url;
		
		List<SPPRDTSVO> spPrdtsVO = apiDAO.selectSpProductList(paramVO);
		
		for(SPPRDTSVO sp : spPrdtsVO) {
			sp.setUrl(detailUrl + sp.getPrdtNum());
			if(sp.getImg() != null) {
				sp.setImg(imgUrl + sp.getImg());
			}
		}
		return spPrdtsVO;
		
		
		
	}

	@Override
	public List<RCSVO> rcList(HttpServletRequest request) {
		String url = request.getScheme() + "://" + request.getServerName();
		if(80 != request.getServerPort()) {
			url += ":" + request.getServerPort();
		}
		String detailUrl = url + request.getContextPath() + "/web/rentcar/car-list.do?sCorpId=";
		
		
		CORPVO corpVO = new CORPVO();
    	corpVO.setCorpCd(Constant.RENTCAR);
    	corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
		List<RCSVO> rcCorpList = apiDAO.selectRcCorpList(corpVO);
		
		for(RCSVO rc : rcCorpList) {
			rc.setUrl(detailUrl + rc.getRcId());
		}
		return rcCorpList;
	}
	
	/**
	 * 해당 업체에 판매중인 상품이 있는지 체크
	 * 파일명 : checkPrdtByCorp
	 * 작성일 : 2016. 9. 5. 오전 11:13:44
	 * 작성자 : 최영철
	 * @param corpVO
	 * @return
	 */
	@Override
	public ERRORVO checkPrdtByCorp(CORPVO corpVO){
		ERRORVO errorVO = new ERRORVO();
		
		int nTotCnt = 0;
		
		// 숙박
		if(Constant.ACCOMMODATION.equals(corpVO.getCorpCd())){
			AD_PRDTINFSVO ad_PRDTINFSVO = new AD_PRDTINFSVO();
			ad_PRDTINFSVO.setsCorpId(corpVO.getCorpId());
			ad_PRDTINFSVO.setsTradeStatus(Constant.TRADE_STATUS_APPR);
			
			nTotCnt = masAdPrdtService.getCntAdPrdinf(ad_PRDTINFSVO);
		}
		// 렌터카
		else if(Constant.RENTCAR.equals(corpVO.getCorpCd())){
			RC_PRDTINFSVO rc_PRDTINFSVO = new RC_PRDTINFSVO();
			rc_PRDTINFSVO.setsCorpId(corpVO.getCorpId());
			rc_PRDTINFSVO.setsTradeStatus(Constant.TRADE_STATUS_APPR);
			
			nTotCnt = masRcPrdtService.getCntRcPrdtList(rc_PRDTINFSVO);
		}
		// 소셜상품
		else if(Constant.SOCIAL.equals(corpVO.getCorpCd())){
			String prdtNum = apiDAO.selectSpProductByCorp(corpVO.getCorpId());
			if(prdtNum != null){
				nTotCnt = 1;
			}
		}
		// 제주특산/기념품
		else if(Constant.SV.equals(corpVO.getCorpCd())){
			String prdtNum = apiDAO.selectSvProductByCorp(corpVO.getCorpId());
			if(prdtNum != null){
				nTotCnt = 1;
			}
		}
		
		if(nTotCnt > 0){
			return null;	
		}else{
			errorVO.setRetCode("ERR");
			errorVO.setErrorCode("ERR302");
			errorVO.setErrorMsg(corpVO.getCorpId() + "은(는) 판매중인 상품이 없습니다.");
			return errorVO;
		}
		
	}

	/**
	 * 콕콕114 업체 리스트
	 * 파일명 : selectCokCokList
	 * 작성일 : 2017. 2. 28. 오후 5:49:48
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<LowerHashMap> visitjejuList(){
		return apiDAO.visitjejuList();
	}

	
	// 그림 API 로그인 ID/PW
	public String grimLoginId = "xkaskdhrmfladusruf2018";
	public String grimLoginPw = "qlqjs2018";
	
	/**
	 * 그림 API를 이용한 예약 가능여부 확인
	 * Function : chkGrimRcAble
	 * 작성일 : 2018. 2. 8. 오후 5:57:42
	 * 작성자 : 정동수
	 * @param prdtVO
	 * @param prdtSVO
	 * @return
	 */
	@SuppressWarnings({ "finally", "unchecked" })
	@Override
	public Map<String, String> chkGrimRcAble(RC_PRDTINFVO prdtVO, RC_PRDTINFSVO prdtSVO) {		
		BufferedReader rd = null;
		Map<String, String> returnMap = new HashMap<String, String>();
		
		String possiblenum = "";
		
		try {    		
    		String sDate = prdtSVO.getsFromDt() + prdtSVO.getsFromTm();
    		String eDate = prdtSVO.getsToDt() + prdtSVO.getsToTm();
    		
    		String rcAbleChkUrl = "http://tamnao.mygrim.com/carlist.php";
    		String rcAbleChkParam = "tamnao_loginid=" + grimLoginId + "&tamnao_loginpw=" + grimLoginPw +"&st=" + sDate + "&et=" + eDate + "&tamnao_cid=" + prdtVO.getCorpId() + "&rentcar_mid=" + prdtVO.getLinkMappingNum();
    		log.info("RC ABLE CHECK RARAM : " + rcAbleChkParam);
    		
			URL url = new URL(rcAbleChkUrl);
			URLConnection conn = url.openConnection();
			
			conn.setDoOutput(true);
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
			wr.write(rcAbleChkParam);
			wr.flush();
			
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String jsonText = EgovStringUtil.readAll(rd);
			
			StringBuffer sbuf = new StringBuffer();
			sbuf.append(jsonText);			
			
			String sbufStr = sbuf.toString();

			Map<String, Object> chkMap = "[]".equals(sbufStr) == false ? new ObjectMapper().readValue(sbufStr, HashMap.class) : new HashMap<String, Object>();
			Map<String, Object> corpMap = new HashMap<String, Object>();
			Map<String, Object> resultMap = new HashMap<String, Object>();
			Map<String, Object> insuranceMap = new HashMap<String, Object>();
			if (chkMap.containsKey(prdtVO.getCorpId()) && chkMap.get(prdtVO.getCorpId()) != null) {
			    // ClassCastException: java.util.ArrayList cannot be cast to java.util.Map 방지
			    if(chkMap.get(prdtVO.getCorpId()) instanceof HashMap) {
                    corpMap.putAll((Map<? extends String, ? extends Object>) chkMap.get(prdtVO.getCorpId()));
                    if (corpMap.containsKey(prdtVO.getLinkMappingNum())) {
                        resultMap.putAll((Map<? extends String, ? extends Object>) corpMap.get(prdtVO.getLinkMappingNum()));
                        if (resultMap.containsKey("insurance")) {
                            Map<String, Object> typeMap = new HashMap<String, Object>();
                            insuranceMap.putAll((Map<? extends String, ? extends Object>) resultMap.get("insurance"));
                            Iterator<String> insurKeys = insuranceMap.keySet().iterator();
                            while (insurKeys.hasNext()) {
                                String iKey = insurKeys.next();
                                typeMap.putAll((Map<? extends String, ? extends Object>) insuranceMap.get(iKey));

                                if (("" + typeMap.get("insurance_name")).contains("1.")) {
                                    returnMap.put("ID20_GENL", "" + typeMap.get("insurance_id"));
                                    returnMap.put("ID20_GENL_AMT", "" + typeMap.get("insurance_salefee"));
                                } else if (("" + typeMap.get("insurance_name")).contains("2.")) {
                                    returnMap.put("ID20_LUXY", "" + typeMap.get("insurance_id"));
                                    returnMap.put("ID20_LUXY_AMT", "" + typeMap.get("insurance_salefee"));
                                } else if (("" + typeMap.get("insurance_name")).contains("3.")) {
                                    returnMap.put("ID10_GENL", "" + typeMap.get("insurance_id"));
                                    returnMap.put("ID10_GENL_AMT", "0");
                                } else if (("" + typeMap.get("insurance_name")).contains("4.")) {
                                    returnMap.put("ID10_LUXY", "" + typeMap.get("insurance_id"));
                                    returnMap.put("ID10_LUXY_AMT", "0");
                                }
                            }
                        }
                    }
                }
			}
							
			possiblenum = resultMap.containsKey("possiblenum") ?  "" + resultMap.get("possiblenum") : "0";
			returnMap.put("possiblenum", possiblenum);

			log.info("possiblenum = " + possiblenum);
		} catch (Exception e) {
			possiblenum = "0";
			returnMap.put("possiblenum", possiblenum);
			e.printStackTrace();			
		} finally {
			try {
				rd.close();
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
			
			return returnMap;
		}
	}

	@SuppressWarnings({ "unchecked" })
	@Override
	public String insertGrimRcRsv(String rcRsvNum) {

		log.info("RC RSV LINK START : " + rcRsvNum);
		String linkMappingRsvnum = "";
		String dirtIsrAmt = "0";
		
		BufferedReader rd = null;
		// 탐나오 렌터카 예약 정보 조회
		RC_RSVVO rsvDtlVO = new RC_RSVVO();
		rsvDtlVO.setRcRsvNum(rcRsvNum);
		rsvDtlVO = rsvDAO.selectRcDetailRsv(rsvDtlVO);
		
		// 렌터카 상품에 대한 정보 확인
		RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
		prdtSVO.setsPrdtNum(rsvDtlVO.getPrdtNum());
		prdtSVO.setsFromDt(rsvDtlVO.getRentStartDt());
		prdtSVO.setsFromTm(rsvDtlVO.getRentStartTm());
		prdtSVO.setsToDt(rsvDtlVO.getRentEndDt());
		prdtSVO.setsToTm(rsvDtlVO.getRentEndTm());

		RC_PRDTINFVO prdtInfo = webRcProductService.selectRcPrdt(prdtSVO);
		String carAmt = prdtInfo.getNetAmt();
		String insuranceNum = "";

		insuranceNum = prdtInfo.getLinkMappingIsrNum();

		RC_PRDTINFVO prdtVO = rcDAO.selectAPIRcPrdt(prdtSVO);

		String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");

		/** 로그저장 초기화 */
		APIRCLOGVO apiRcLogVO = new APIRCLOGVO() ;
		/**예약FLAG*/
		apiRcLogVO.setApiRentDiv("G");
		apiRcLogVO.setSeqNum("0");
		apiRcLogVO.setRcRsvNum(rcRsvNum);
		apiRcLogVO.setRsvNum(rsvDtlVO.getRsvNum());
		
		// 해당 상품이 연계 상품인 경우 실행
		if(Constant.FLAG_Y.equals(prdtVO.getCorpLinkYn()) && Constant.RC_RENTCAR_COMPANY_GRI.equals(prdtVO.getApiRentDiv()) &&  !EgovStringUtil.isEmpty(prdtVO.getLinkMappingNum())){
			log.info("RC RSV LINK ING... : link_mapping_num - " + prdtVO.getLinkMappingNum());
			CDVO cdVO = new CDVO();
			cdVO.setCdNum(prdtVO.getIsrDiv());
			cdVO = ossCmmService.selectByCd(cdVO);
			
			String memoStr = cdVO.getCdNm();
			/**자차포함*/
			if ("ID10".equals(prdtVO.getIsrDiv())) {
				String isrStr = Constant.RC_ISR_TYPE_GEN.equals(prdtVO.getIsrTypeDiv()) ? "일반자차" : "고급자차";
				memoStr += "(" + isrStr + ")";
			}
			if(Constant.FLAG_N.equals(prdtVO.getSellLink())){
				memoStr += " / 입금금액("+ carAmt + "원)";
			}else{
				memoStr += " / 판매금액("+ carAmt + "원)";
			}

			try {
				String rcRsvUrl = "http://tamnao.mygrim.com/resconfirm.php";
	    		String rcRsvParam = "tamnao_cid=" + rsvDtlVO.getCorpId();
	    		rcRsvParam += "&rentcar_mid=" + prdtVO.getLinkMappingNum();
	    		rcRsvParam += "&tamnao_resid=" + rsvDtlVO.getRsvNum();
	    		rcRsvParam += "&tamnao_loginid=" + grimLoginId;
	    		rcRsvParam += "&tamnao_loginpw=" + grimLoginPw;
	    		rcRsvParam += "&st=" + rsvDtlVO.getRentStartDt() + rsvDtlVO.getRentStartTm();	// 대여일시분 - 필수
	    		rcRsvParam += "&et=" + rsvDtlVO.getRentEndDt() + rsvDtlVO.getRentEndTm();		// 반납일시분 - 필수
	    		rcRsvParam += "&insurance=" + insuranceNum;
				/*rcRsvParam += "&hope_salefee=" + carAmt;*/
	    		rcRsvParam += "&dirfee=" + 0;
	    		rcRsvParam += "&insurance_dirfee=" + 0;
	    		rcRsvParam += "&memo=" + URLEncoder.encode(memoStr, "UTF-8");

	    		if(!rsvDtlVO.getCorpId().equals("CRCO200001")){
	    			rcRsvParam += "&user_name1=" + URLEncoder.encode(rsvDtlVO.getRsvNm(), "UTF-8");
		    		rcRsvParam += "&user_tel1=" + rsvDtlVO.getRsvTelnum();
				}else{
					rcRsvParam += "&user_name1=" + URLEncoder.encode(rsvDtlVO.getUseNm(), "UTF-8");
		    		rcRsvParam += "&user_tel1=" + rsvDtlVO.getUseTelnum();
				}

	    		if(!rsvDtlVO.getCorpId().equals("CRCO200001")){
	    			rcRsvParam += "&user_name2=" + URLEncoder.encode(rsvDtlVO.getUseNm(), "UTF-8");
	    			rcRsvParam += "&user_tel2=" + rsvDtlVO.getUseTelnum();
				}else{
	    			rcRsvParam += "&user_name2=" + URLEncoder.encode(rsvDtlVO.getRsvNm(), "UTF-8");
	    			rcRsvParam += "&user_tel2=" + rsvDtlVO.getRsvTelnum();
				}

	    		log.info("RC RSV RARAM : " + rcRsvParam);
	    		apiRcLogVO.setRequestMsg(rcRsvParam);

				if("test".equals(CST_PLATFORM.trim())) {
					log.info("rcApiInsert");
					linkMappingRsvnum = "test";
				}else{
					URL url = new URL(rcRsvUrl);
					URLConnection conn = url.openConnection();

					conn.setDoOutput(true);
					OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
					wr.write(rcRsvParam);
					wr.flush();

					rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));

					String jsonText = EgovStringUtil.readAll(rd);

					StringBuffer sbuf = new StringBuffer();
					sbuf.append(jsonText);

					Map<String, Object> resultMap = new ObjectMapper().readValue(sbuf.toString(), HashMap.class);

					// 렌터카 연계 여부 업데이트
					if (resultMap.containsKey("resultcode")) {
						String resultCode = "" + resultMap.get("resultcode");
						if ("200".equals(resultCode)) {
							linkMappingRsvnum = (resultMap.containsKey("rentcar_resid") ? "" + resultMap.get("rentcar_resid") : "");
							rsvDtlVO.setLinkMappingRsvnum(linkMappingRsvnum);
							rsvDAO.updateRcLinkYn(rsvDtlVO);
							log.info("RC RSV LINK SUCCESS : " + resultMap.get("rentcar_resid"));
							apiRcLogVO.setRsvResult("0");
						} else {
							String failMsg = resultMap.containsKey("codemsg") ? "" + resultMap.get("codemsg") : "";
							log.info("RC RSV LINK FAIL : " + failMsg);
							apiRcLogVO.setRsvResult("1");
							apiRcLogVO.setFaultReason(failMsg);
						}
					}
					/**로그 저장*/
					apiDAO.insertRcApiLog(apiRcLogVO);
				}
				log.info("RC RSV LINK END");
			} catch (Exception e) {
				log.info("Exception!");
				
				e.printStackTrace();
				
				log.info(e.getMessage());
				
				log.info("RC RSV LINK Exception");
			} finally {
				try {
					if("test".equals(CST_PLATFORM.trim())) {
						log.info("rcApiInsert");
						linkMappingRsvnum = "test";
					}else {
						rd.close();
					}
				} catch (IOException ioe) {
					ioe.printStackTrace();
				}
			}
		} else {
			log.info("RC RSV ERROR : corp_link_yn => " + prdtVO.getCorpLinkYn() + " ; link_mapping_num => " + prdtVO.getLinkMappingNum());
		}
		
		return linkMappingRsvnum;
	}

	@SuppressWarnings("unchecked")
	@Override
	public String cancelGrimRcRsv(String rcRsvNum) {
		String success = "Y";
		log.info("RC CANCEL LINK START : " + rcRsvNum);
		
		BufferedReader rd = null;
		// 탐나오 렌터카 예약 정보 조회
		RC_RSVVO rsvDtlVO = new RC_RSVVO();
		rsvDtlVO.setRcRsvNum(rcRsvNum);
		rsvDtlVO = rsvDAO.selectRcDetailRsv(rsvDtlVO);
		
		/** 로그저장 초기화 */
		APIRCLOGVO apiRcLogVO = new APIRCLOGVO() ;
		/**취소FLAG*/
		apiRcLogVO.setApiRentDiv("G");
		apiRcLogVO.setSeqNum("1");
		apiRcLogVO.setRcRsvNum(rcRsvNum);
		apiRcLogVO.setRsvNum(rsvDtlVO.getRsvNum());

		try {
			String rcCancelUrl = "http://tamnao.mygrim.com/rescancel.php";
			String rcCancelParam = "tamnao_cid=" + rsvDtlVO.getCorpId();
			rcCancelParam += "&rentcar_resid=" + rsvDtlVO.getLinkMappingRsvnum();
			rcCancelParam += "&tamnao_loginid=" + grimLoginId;
			rcCancelParam += "&tamnao_loginpw=" + grimLoginPw;
			log.info("RC CANCEL RARAM : " + rcCancelParam);
			apiRcLogVO.setRequestMsg(rcCancelParam);

			URL url = new URL(rcCancelUrl);
			URLConnection conn = url.openConnection();

			conn.setDoOutput(true);
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
			wr.write(rcCancelParam);
			wr.flush();

			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String jsonText = EgovStringUtil.readAll(rd);

			StringBuffer sbuf = new StringBuffer();
			sbuf.append(jsonText);

			Map<String, Object> resultMap = new ObjectMapper().readValue(sbuf.toString(), HashMap.class);

			// 렌터카 연계 여부 업데이트
			if (resultMap.containsKey("resultcode")) {
				if ("200".equals(resultMap.get("resultcode")) || "215".equals(resultMap.get("resultcode")) || "210".equals(resultMap.get("resultcode"))) {
					log.info("RC CANCEL LINK SUCCESS : " + resultMap.get("resultcode"));
					apiRcLogVO.setRsvResult("0");
				} else {
					String failMsg = resultMap.containsKey("codemsg") ? "" + resultMap.get("codemsg") : "";
					apiRcLogVO.setRsvResult("1");
					apiRcLogVO.setFaultReason(failMsg);
					log.info("RC CANCEL LINK CODE : " + resultMap.get("resultcode"));
					log.info("RC CANCEL LINK FAIL : " + failMsg);
					success = failMsg;
					if(!resultMap.get("resultcode").equals("404")){
						/** 실패 문자발송*/
						String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
						/** 인스 #이후 숫자제거*/
						String rsvNumStr = rsvDtlVO.getLinkMappingRsvnum();
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
										+"취소불가이유 : " + failMsg + "\n\n"
										+"*연계시스템 취소 불가건으로 탐나오상점관리자에 예약건이 없을경우, 업체시스템에서 직접 취소바랍니다."
									);
						mmsVO.setStatus("0");
						mmsVO.setFileCnt("0");
						mmsVO.setType("0");
						/*담당자 MMS발송 - 테스트빌드시 취소 메시지 김재성*/
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
				}
			}
			/**로그 저장*/
			apiDAO.insertRcApiLog(apiRcLogVO);
			log.info("RC CANCEL LINK END");
		} catch (Exception e) {
			success = "예약취소 불가 상태입니다.";
			log.info("Exception!");

			e.printStackTrace();

			log.info(e.getMessage());

			log.info("RC CANCEL LINK Exception");

		} finally {
			try {

				rd.close();
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}

		}

		return success;

	}

	@Override
	public void insertNexezData(ApiNextezPrcAdd apiNextezPrcAdd) { apiDAO.insertNexezData(apiNextezPrcAdd); }

	@Override
	public List<LowerHashMap> selectlistAdNextez(ApiNextezSVO apiNextezSVO){
		if("view".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistAdViewNextez(apiNextezSVO);
		}else if("like".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistAdLikeNextez(apiNextezSVO);
		}else if("share".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistAdShareNextez(apiNextezSVO);
		}else if("point".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistAdPointNextez(apiNextezSVO);
		}else if("order".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistAdOrderNextez(apiNextezSVO);
		}else{
			return apiDAO.selectlistAdCancelNextez(apiNextezSVO);
		}

	}

	@Override
	public List<LowerHashMap> selectlistRcNextez(ApiNextezSVO apiNextezSVO){
		if("view".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistRcViewNextez(apiNextezSVO);
		}else if("like".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistRcLikeNextez(apiNextezSVO);
		}else if("share".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistRcShareNextez(apiNextezSVO);
		}else if("point".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistRcPointNextez(apiNextezSVO);
		}else if("order".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistRcOrderNextez(apiNextezSVO);
		}else{
			return apiDAO.selectlistRcCancelNextez(apiNextezSVO);
		}

	}

	@Override
	public List<LowerHashMap> selectlistSpNextez(ApiNextezSVO apiNextezSVO){
		if("view".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistSpViewNextez(apiNextezSVO);
		}else if("like".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistSpLikeNextez(apiNextezSVO);
		}else if("share".equals(apiNextezSVO.getSrcType())){
			return apiDAO.selectlistSpShareNextez(apiNextezSVO);
		}else{
			return apiDAO.selectlistSpPointNextez(apiNextezSVO);
		}
	}

	@Override
	public int daehongPreventSaleNum (String telNum){
		return apiDAO.daehongPreventSaleNum(telNum);
	}

	@Override
	public List<LowerHashMap> hdcReqCnt(){
		return apiDAO.hdcReqCnt();
	}

	@Override
	public String corpCert(Map<String,Object> map){
		return apiDAO.corpCert(map);
	}

	@Override
	public String selectCorpId(Map<String,Object> map){
		return apiDAO.selectCorpId(map);
	}

	@Override
	public List<HashMap<String,Object>> selectMallRsvList(Map<String,Object> map){
		return apiDAO.selectMallRsvList(map);
	}

	@Override
	public List<HashMap<String,Object>> selectMallRsvDetail(Map<String,Object> map){
		return apiDAO.selectMallRsvDetail(map);
	}

	@Override
	public void updatePrdt(Map<String,Object> map){
		apiDAO.updatePrdt(map);
	}

	@Override
	public void updateDiv(Map<String,Object> map){
		apiDAO.updateDiv(map);
	}

	@Override
	public void updateOpt(Map<String,Object> map){
		apiDAO.updateOpt(map);
	}
	
	@Override
	public List<LowerHashMap> prmtAuthList(PRMTVO prmtVO){
		return apiDAO.prmtAuthList(prmtVO);
	}
}
