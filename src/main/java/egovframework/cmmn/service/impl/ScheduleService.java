package egovframework.cmmn.service.impl;

import api.service.*;
import api.vo.APIAligoButtonVO;
import api.vo.APIAligoVO;
import api.vo.NAVERVO;
import com.jcraft.jsch.*;
import common.Constant;
import common.LowerHashMap;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.cmmn.service.SmsService;
import egovframework.cmmn.vo.MMSVO;
import egovframework.cmmn.vo.SMSVO;
import mas.rc.service.impl.RcDAO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.sp.vo.SP_PRDTINFVO;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import oss.adj.vo.ADJSVO;
import oss.adj.vo.ADJVO;
import oss.cmm.service.OssMailService;
import oss.cmm.service.impl.MailDAO;
import web.mypage.service.WebUserCpService;
import web.mypage.service.impl.UserCpDAO;
import web.mypage.vo.USER_CPVO;
import web.order.service.WebOrderService;
import web.order.service.impl.WebOrderDAO;
import web.order.vo.*;
import web.order.web.WebOrderController;

import javax.annotation.Resource;
import java.io.*;
import java.lang.reflect.Field;
import java.net.URL;
import java.net.URLConnection;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("ScheduleService")
public class ScheduleService{
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@Resource(name = "scheduleDAO")
	private ScheduleDAO scheduleDAO;
	
	@Resource(name = "webOrderDAO")
	private WebOrderDAO webOrderDAO;

	@Resource(name = "userCpDAO")
	private UserCpDAO userCpDAO;
	
	@Resource(name="apiAdService")
    private APIAdService apiAdService;
	
	@Resource(name="SmsDAO")
	private SmsDAO smsDAO;
	
	@Resource(name="mailDAO")
	private MailDAO mailDAO;

	@Resource(name="ossMailService")
	private OssMailService ossMailService;
	
	@Resource(name="apiService")
	private APIService apiService;
	
	@Resource(name="webOrderService")
    private WebOrderService webOrderService;
	
	@Resource(name="webUserCpService")
	protected WebUserCpService webUserCpService;

	@Resource(name = "rcDAO")
	private RcDAO rcDAO;

	@Resource(name="apiGoodsFlowService")
	private APIGoodsFlowService apiGoodsFlowService;

	@Resource(name="apitlBookingService")
	private APITLBookingService apitlBookingService;

	@Resource(name="apiInsService")
	private APIInsService apiInsService;

	@Resource(name="apiLsService")
	private APILsService apiLsService;

	@Autowired
	private SmsService smsService;

	@Autowired
	private APIAligoService apiAligoService;

	/**
	 * 예약 자동취소 처리
	 * 파일명 : deleteNotRsv
	 * 작성일 : 2015. 12. 26. 오후 3:36:44
	 * 작성자 : 최영철
	 * @throws IOException 
	 * @throws NoSuchAlgorithmException 
	 * @throws InvalidKeyException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 */
	public void deleteNotRsv() throws JsonParseException, JsonMappingException, InvalidKeyException, NoSuchAlgorithmException, IOException{
		log.info("deleteNotRsv action Start!");
		/** 취소순서 숙소,렌터카,소셜,특산기념품*/

		/** 공통 쿠폰 반환 처리 */
		scheduleDAO.returnUserCp();

		/** 자동 취소되는 상품 예약번호 목록 */
		List<String> cancelRsvNumList = new ArrayList<String>();
		
		/***** 숙소 취소시작 *****/

		/** 숙소 반환목록 */
		List<AD_RSVVO> adRsvList = scheduleDAO.selectAdAutoCancelList();
		log.info("adCancelResult cnt : " + adRsvList.size());
		
		/** 각 숙소 예약건에 대한 처리 */
		for(AD_RSVVO rsvVO : adRsvList) {
			cancelRsvNumList.add(rsvVO.getAdRsvNum());
			
			/** 사용 객실수 감소 처리 */
			if("RS00".equals(rsvVO.getRsvStatusCd())){
				webOrderDAO.updateAdCntInfMin(rsvVO);
				webOrderDAO.updateAdBuyNumMin(rsvVO);
			}

			/** 상세예약건 취소코드로 변경 RS99 */
			rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_ACC);
			scheduleDAO.updateAdAutoCancel(rsvVO);

			/** 통계처리(판매감소) */
			webOrderDAO.downSaleAnls(rsvVO.getPrdtNum());

			/** LPOINT 사용취소 */
			LPOINTUSEINFVO lpointUseInfVO = new LPOINTUSEINFVO();
			lpointUseInfVO.setRsvNum(rsvVO.getRsvNum());
			lpointUseInfVO.setMaxSaleDtlRsvNum(rsvVO.getAdRsvNum());
			lpointUseInfVO.setCancelYn(Constant.FLAG_N);
			lpointUseInfVO.setRsvCancelYn(Constant.FLAG_N);
			lpointUseInfVO = webOrderService.selectLpointUsePoint(lpointUseInfVO);
			if(lpointUseInfVO != null) {
				log.info("AD => L.Point delete action!");
				lpointUseCancel(lpointUseInfVO);
			}

			USER_CPVO userCpVO = new USER_CPVO();
			userCpVO.setUserId(rsvVO.getUserId());
			userCpVO.setCpDiv(Constant.USER_CP_DIV_ACNR);
			int cpCnt = userCpDAO.getCntAutoCancelCoupon(userCpVO);
			if(EgovStringUtil.isEmpty(rsvVO.getRsvEmail()) == false && "Y".equals(rsvVO.getEmailRcvAgrYn()) && cpCnt == 0) {
				/** 자동취소쿠폰 발행 */
				webUserCpService.acnrCpPublish(rsvVO.getUserId());
				/** 자동취소메일 발송 */
				ossMailService.autoCancelCouponSendMail(rsvVO.getRsvEmail(), Constant.USER_CP_DIV_ACNR);
			}

			/** TL린칸 취소*/
			/*apitlBookingService.bookingCancel(rsvVO.getAdRsvNum());*/
		}

		/***** 렌터카 취소시작 *****/

		/** 렌터카 반환목록 */
		List<RC_RSVVO> rcRsvList = scheduleDAO.selectRcAutoCancelList();
		
		log.info("rcCancelResult cnt : " + rcRsvList.size());

		/** 각 렌터카 예약건에 대한 처리 */
		for(RC_RSVVO rsvVO : rcRsvList) {
			cancelRsvNumList.add(rsvVO.getRcRsvNum());

			/** 사용 렌터카상품 수 감소 처리 */
			webOrderDAO.updateRcBuyNumMin(rsvVO);

			/** 상세예약건 취소코드로 변경 RS99 */
			rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_ACC);
			scheduleDAO.updateRcAutoCancel(rsvVO);

			/** 통계처리(판매감소) */
			webOrderDAO.downSaleAnls(rsvVO.getPrdtNum());

			/** LPOINT 사용취소 */
			LPOINTUSEINFVO lpointUseInfVO = new LPOINTUSEINFVO();
			lpointUseInfVO.setRsvNum(rsvVO.getRsvNum());
			lpointUseInfVO.setMaxSaleDtlRsvNum(rsvVO.getRcRsvNum());
			lpointUseInfVO.setCancelYn(Constant.FLAG_N);
			lpointUseInfVO.setRsvCancelYn(Constant.FLAG_N);
			lpointUseInfVO = webOrderService.selectLpointUsePoint(lpointUseInfVO);
			if(lpointUseInfVO != null) {
				log.info("RC => L.Point delete action!");
				lpointUseCancel(lpointUseInfVO);
			}

			USER_CPVO userCpVO = new USER_CPVO();
			userCpVO.setUserId(rsvVO.getUserId());
			userCpVO.setCpDiv(Constant.USER_CP_DIV_ACNR);
			int cpCnt = userCpDAO.getCntAutoCancelCoupon(userCpVO);
			if(EgovStringUtil.isEmpty(rsvVO.getRsvEmail()) == false && "Y".equals(rsvVO.getEmailRcvAgrYn()) && cpCnt == 0) {
				/** 자동취소쿠폰 발행 */
				webUserCpService.acnrCpPublish(rsvVO.getUserId());
				/** 자동취소메일 발송 */
				ossMailService.autoCancelCouponSendMail(rsvVO.getRsvEmail(), Constant.USER_CP_DIV_ACNR);
			}
		}

		/***** 소셜 취소시작 *****/

		/** 소셜 반환목록 */
		List<SP_RSVVO> spRsvList = scheduleDAO.selectSpAutoCancelList();
		log.info("spCancelResult cnt : " + spRsvList.size());

		/** 각 소셜 예약건에 대한 처리 */
		for(SP_RSVVO rsvVO : spRsvList) {
			cancelRsvNumList.add(rsvVO.getSpRsvNum());

			/** 구매수 감소 처리 */
			if("RS00".equals(rsvVO.getRsvStatusCd())){
				webOrderDAO.updateSpCntInfMin(rsvVO);
			}

			/** 상세예약건 취소코드로 변경 RS99 */
			rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_ACC);
			scheduleDAO.updateSpAutoCancel(rsvVO);

			/** 통계처리(판매감소) */
			webOrderDAO.downSaleAnls(rsvVO.getPrdtNum());

			/** LPOINT 사용취소 */
			LPOINTUSEINFVO lpointUseInfVO = new LPOINTUSEINFVO();
			lpointUseInfVO.setRsvNum(rsvVO.getRsvNum());
			lpointUseInfVO.setMaxSaleDtlRsvNum(rsvVO.getSpRsvNum());
			lpointUseInfVO.setCancelYn(Constant.FLAG_N);
			lpointUseInfVO.setRsvCancelYn(Constant.FLAG_N);
			lpointUseInfVO = webOrderService.selectLpointUsePoint(lpointUseInfVO);
			if(lpointUseInfVO != null) {
				log.info("SP => L.Point delete action!");
				lpointUseCancel(lpointUseInfVO);
			}

			USER_CPVO userCpVO = new USER_CPVO();
			userCpVO.setUserId(rsvVO.getUserId());
			userCpVO.setCpDiv(Constant.USER_CP_DIV_ACNR);
			int cpCnt = userCpDAO.getCntAutoCancelCoupon(userCpVO);
			if(EgovStringUtil.isEmpty(rsvVO.getRsvEmail()) == false && "Y".equals(rsvVO.getEmailRcvAgrYn()) && cpCnt == 0) {
				/** 자동취소쿠폰 발행 */
				webUserCpService.acnrCpPublish(rsvVO.getUserId());
				/** 자동취소메일 발송 */
				ossMailService.autoCancelCouponSendMail(rsvVO.getRsvEmail(), Constant.USER_CP_DIV_ACNR);
			}
			
			//마라톤 티셔츠수량 사용취소처리
			String mrtCorpId = rsvVO.getCorpId();
			if(mrtCorpId != null) {
				if("CSPM".equals(mrtCorpId.substring(0, 4))) {
					MRTNVO mrtnVO = new MRTNVO();
					mrtnVO.setRsvNum(rsvVO.getRsvNum());
					mrtnVO.setSpRsvNum(rsvVO.getSpRsvNum());
					mrtnVO.setCorpId(mrtCorpId);
					mrtnVO.setPrdtNum(rsvVO.getPrdtNum());
					webOrderService.updateReturnTshirtsCnt(mrtnVO);
				}
			}
		}
		
		/***** 관광기념품 취소시작 *****/

		/** 관광기념품 반환목록 */
		List<SV_RSVVO> svRsvList = scheduleDAO.selectSvAutoCancelList();
		log.info("svCancelResult cnt : " + svRsvList.size());

		/** 각 특산기념품 구매건에 대한 처리 */
		for(SV_RSVVO rsvVO : svRsvList) {
			cancelRsvNumList.add(rsvVO.getSvRsvNum());

			/** 구매수 감소 처리 */
			if("RS00".equals(rsvVO.getRsvStatusCd())){
				webOrderDAO.updateSvCntInfMin(rsvVO);
			}

			/** 상세예약건 취소코드로 변경 RS99 */
			rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_ACC);
			scheduleDAO.updateSvAutoCancel(rsvVO);

			/** 통계처리(판매감소) */
			webOrderDAO.downSaleAnls(rsvVO.getPrdtNum());

			/** LPOINT 사용취소 */
			LPOINTUSEINFVO lpointUseInfVO = new LPOINTUSEINFVO();
			lpointUseInfVO.setRsvNum(rsvVO.getRsvNum());
			lpointUseInfVO.setMaxSaleDtlRsvNum(rsvVO.getSvRsvNum());
			lpointUseInfVO.setCancelYn(Constant.FLAG_N);
			lpointUseInfVO.setRsvCancelYn(Constant.FLAG_N);
			lpointUseInfVO = webOrderService.selectLpointUsePoint(lpointUseInfVO);
			if(lpointUseInfVO != null) {
				log.info("SV => L.Point delete action!");
				lpointUseCancel(lpointUseInfVO);
			}

			USER_CPVO userCpVO = new USER_CPVO();
			userCpVO.setUserId(rsvVO.getUserId());
			userCpVO.setCpDiv(Constant.USER_CP_DIV_ACNV);
			int cpCnt = userCpDAO.getCntAutoCancelCoupon(userCpVO);
			if(EgovStringUtil.isEmpty(rsvVO.getRsvEmail()) == false && "Y".equals(rsvVO.getEmailRcvAgrYn()) && cpCnt == 0) {
				/** 자동취소쿠폰 발행 */
				webUserCpService.acnvCpPublish(rsvVO.getUserId());
				/** 자동취소메일 발송 */
				ossMailService.autoCancelCouponSendMail(rsvVO.getRsvEmail(), Constant.USER_CP_DIV_ACNV);
			}
		}

		/** LPOINT 적립취소 */
		if(!cancelRsvNumList.isEmpty()){
			log.info("L.Point save cancel action!");
			LPOINTSAVEINFVO lpointSaveInfVO = new LPOINTSAVEINFVO();
			lpointSaveInfVO.setCancelRsvNumList(cancelRsvNumList);
			webOrderService.updateLpointRsvCancel(lpointSaveInfVO);
		}

		/** 공통 예약 테이블 예약코드 취소로 변경 */
		scheduleDAO.updateAutoCancel();
		log.info("deleteNotRsv action End!");
	}
	
	/**
     * L.Point 사용 취소 처리
     * @param lpointUseInfVO
     * @return
     * @throws IOException
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeyException
     * @throws JsonMappingException
     * @throws JsonParseException
     */
    public void lpointUseCancel(LPOINTUSEINFVO lpointUseInfVO) throws JsonParseException, JsonMappingException, InvalidKeyException, NoSuchAlgorithmException, IOException {
    	WebOrderController webOrder = new WebOrderController();

		LPOINTREQDATAVO reqVO = new LPOINTREQDATAVO();
		reqVO.setServiceID("O740");
		reqVO.setCdno(lpointUseInfVO.getCardNum());
		reqVO.setCcoAprno(lpointUseInfVO.getRsvNum());
		reqVO.setTtnUPt(lpointUseInfVO.getUsePoint());
		reqVO.setOtAprno(lpointUseInfVO.getTradeConfnum());
		reqVO.setOtDt(lpointUseInfVO.getTradeDttm().substring(0, 10).replaceAll("-", ""));
		ModelMap resultLpoint = webOrder.actionLPoint(reqVO).getModelMap();
		LPOINTRESPDATAVO lpointVO = (LPOINTRESPDATAVO) resultLpoint.get("lpoint");

		log.info("L.Point Cancel agree No ==> " + lpointVO.aprno + " :: msg ==> " + lpointVO.msgCn1);
		if (lpointVO.aprno != "") {	// L.Point 취소 성공 시 DB 등록		
    		lpointUseInfVO.setTradeDttm(lpointVO.aprDt + lpointVO.aprHr);
    		lpointUseInfVO.setTradeConfnum(lpointVO.aprno);
    		lpointUseInfVO.setRequestNum(lpointVO.control.flwNo);
    		lpointUseInfVO.setRespCd(lpointVO.control.rspC);
    		lpointUseInfVO.setUseRst("취소 성공");
    		lpointUseInfVO.setRsvCancelYn(Constant.FLAG_Y);    		
    		lpointUseInfVO.setCancelYn(Constant.FLAG_Y);  
    		
    		webOrderService.cancelLpointUsePoint(lpointUseInfVO);
    		log.info("L.Point lpointUseCancel End ==> ");
    	} else { // L.Point 포인트 취소 실패 시
    		String useRst = lpointVO.msgCn1;
    		// L.Point 망취소 전송
    		log.info("L.Point Cancel (60) ==> start");
    		reqVO.setRspC("60");
   // 		resultLpoint = webOrder.actionLPoint(reqVO).getModelMap();
    		log.info("L.Point Cancel (60) ==> end");

    		// 결과 DB 등록
    		Date today = new Date();
			SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyyMMddHHmmss");

    		lpointUseInfVO.setTradeDttm(sdfDateTime.format(today));
    		lpointUseInfVO.setTradeConfnum(lpointVO.aprno);
    		lpointUseInfVO.setRsvCancelYn(Constant.FLAG_Y);
    		lpointUseInfVO.setUseRst("취소 실패 (" + useRst + ")");
    		webOrderService.cancelLpointUsePoint(lpointUseInfVO);
    	}
    }
	
	public void exprCheck(){
		
		// 각 예약건 사용완료 처리 & 기간만료 처리
		
		/***********************************************
		 * 소셜상품 사용완료 처리
		 * APL_DT(적용 일자)가 해당 날짜보다 과거이며, 예약상태코드가 예약(RS02) 인 경우 
		 * 사용완료(RS30) 처리
		 **********************************************/
		scheduleDAO.useCompleteSp();
		
		/***********************************************
		 * 소셜상품 기간만료 처리
		 * EXPR_END_DT(유효 종료 일자)가 해당 날짜보다 과거이며, 예약상태코드가 예약(RS02) 인 경우 
		 * 기간만료(RS31) 처리
		 **********************************************/
		scheduleDAO.exprCompleteSp();
		
		/***********************************************
		 * 렌터카 사용완료 처리
		 * RENT_START_DT(렌트 시작 일자)가 해당 날짜보다 과거이며, 예약상태코드가 예약(RS02) 인 경우 
		 * 사용완료(RS30) 처리
		 **********************************************/
		scheduleDAO.useCompleteRc();

		/***********************************************
		 * 숙박 사용완료 처리
		 * USE_DT(이용 일자)가 해당 날짜보다 과거이며, 예약상태코드가 예약(RS02) 인 경우 
		 * 사용완료(RS30) 처리
		 **********************************************/
		scheduleDAO.useCompleteAd();
		
		/***********************************************
		 * 관광기념품 자동구매확정 처리
		 ***********************************************/
		scheduleDAO.useCompleteSv();
		
		/***********************************************
		 * 입점업체 현황 배치 추가
		 * 2017.02.13
		 ***********************************************/
		scheduleDAO.corpAnls();
	}
	
	public void adjust(){
		
		// 1. 정산일자(가장 가까운 목요일)를 구한다.
		String adjDt = scheduleDAO.getAdjDt();
		
		// 2. 해당 날짜에 대한 정산건이 존재하는지 체크
		ADJSVO adjSVO = new ADJSVO();
		adjSVO.setsAdjDt(adjDt);
		List<ADJVO> adjList = scheduleDAO.selectAdjList(adjSVO);
		
		// 2-1. 해당 날짜에 대한 정산건이 존재하는경우
		if(adjList.size() > 0){
			log.error(adjDt + " 날짜에 대한 정산건이 이미 존재 합니다.");
		}else{
			// 3. 정산 대상 예약건 추출
			scheduleDAO.insertAdjDtlList(adjSVO);
			
			// 4. 정산 마스터 테이블 데이터 추출
			scheduleDAO.insertAdj(adjSVO);
			
			// 5-1. 숙박 정산 대상건에 정산여부, 정산일자 업데이트
			scheduleDAO.updateAdAdj(adjSVO);
			// 5-2. 렌터카 정산 대상건에 정산여부, 정산일자 업데이트
			scheduleDAO.updateRcAdj(adjSVO);
			// 5-4. 소셜상품 정산 대상건에 정산여부, 정산일자 업데이트
			scheduleDAO.updateSpAdj(adjSVO);
			// 5-5. 관광기념품 정산 대상건에 정산여부, 정산일자 업데이트
			scheduleDAO.updateSvAdj(adjSVO);
			
		}
	}

	public void adjust2(){
		// 1. 정산일자(가장 가까운 목요일)를 구한다.
		String adjDt = scheduleDAO.getAdjDt();
		ADJSVO adjSVO = new ADJSVO();
		adjSVO.setsAdjDt(adjDt);
		scheduleDAO.insertAdjDtlListCityTour(adjSVO);
		/**정산 마스터 테이블 그리고 각 카테고리별 예약테이블에 정산여부, 정산일자 업데이트는 adjust()에서 수행
		 * 그래서 항상 adjust2() 가 adjust() 보다 먼저 실행이 되어야 함.
		 * */
	}
	
	/**
	 * 메일과 SMS DB 트랜젝션 연장
	 * 파일명 : refreshSmsMail
	 * 작성일 : 2016. 1. 11. 오전 9:58:44
	 * 작성자 : 최영철
	 */
	public void refreshSmsMail(){
		smsDAO.selectRefresh();
		mailDAO.selectRefresh();
	}

	
	/**
	 * 사용 완료된 예약건에 자동 메일 발송
	 * Function : useCompleteMail
	 * 작성일 : 2016. 11. 11. 오전 11:58:56
	 * 작성자 : 정동수
	 */
	public void useCompleteMail() {
		ossMailService.useCompleteSendMailAcc();
	}
	
	/**
	 * 방문 7일전 자동 메일 발송
	 * Function : tourPrev7SendMail
	 * 작성일 : 2018. 3. 9. 오전 10:35:09
	 * 작성자 : 정동수
	 */
	public void tourPrev7SendMail() {
		ossMailService.tourPrev7SendMail();
	}
	
	/**
	 * 휴면 예정 고객 자동 메일 발송 (휴면 처리 7일전)
	 * Function : restUserPrevSendMail
	 * 작성일 : 2018. 3. 9. 오후 1:54:24
	 * 작성자 : 정동수
	 */
	public void restUserPrevSendMail() {
		ossMailService.restUserPrevSendMail();
	}	
	
	/**
	 * 휴면 대상 고객 자동 메일 발송
	 * Function : restUserTargetSendMail
	 * 작성일 : 2018. 3. 9. 오후 2:41:08
	 * 작성자 : 정동수
	 */
	public void restUserTargetSendMail() {
		ossMailService.restUserTargetSendMail();
	}
	
	/**
	 * 방문 10개월된 고객 자동 메일 발송
	 * Function : visit10MonthSendMail
	 * 작성일 : 2018. 3. 12. 오후 1:46:03
	 * 작성자 : 정동수
	 */
	public void visit10MonthSendMail() {
		ossMailService.visit10MonthSendMail();
	}

	public void facebookPrdt() {
		/*log.info("facebookPrdt");
		*//*String url = EgovProperties.getProperty("Globals.Web");
		String naverTextFileUrl = "c:/data/facebook";*//*
		
		String url = EgovProperties.getProperty("Globals.Web");
		String naverTextFileUrl = EgovProperties.getProperty("HOST.WEBROOT") + "/data/facebook";
		log.info(naverTextFileUrl);
		try{
			File epFile = new File(naverTextFileUrl);
			if(!epFile.isDirectory()) {
				boolean _flag = epFile.mkdirs();
				if (!_flag) {
				    throw new IOException("Directory creation Failed ");
				}
			}
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(naverTextFileUrl + File.separator + "facebook.txt"), "utf-8"));
			
			*//*헤더 작성*//*
			bw.write("id,availability,condition,description,image_link,link,title,price,brand,google_product_category");
			bw.newLine();
			
			// 렌트카. (내일 9시부터 그 다음날 9시)
			Calendar calNow = Calendar.getInstance();
			String sFromDt, sToDt;
			sFromDt= EgovStringUtil.getDateFormat(calNow);
			calNow.add(Calendar.DAY_OF_MONTH, 1);
			sToDt = EgovStringUtil.getDateFormat(calNow);

			RC_PRDTINFSVO searchVO = new RC_PRDTINFSVO();
			searchVO.setsToDt(sToDt);
			searchVO.setsToTm("0900");
			searchVO.setsFromDt(sFromDt);
			searchVO.setsFromTm("0900");
			List<NAVERVO> rcList = scheduleDAO.selectNaverRc(searchVO);
			for(NAVERVO naver : rcList) {
				String value;
					value = naver.getId();
					value +=",";
					value += "in stock";
					value +=",";
					value += "new";
					value +=",";
					value += '"'+naver.getTitle().toLowerCase()+'"';	
					value +=",";
					value += url + naver.getImage_link();
					value +=",";
					value += url + "/web/rentcar/car-detail.do?prdtNum=" + naver.getId();
					value +=",";
					value += '"'+naver.getTitle().toLowerCase()+'"';	
					value +=",";
					value += naver.getPrice_pc() + " KRW";
					value +=",";
					value += '"'+naver.getBrand()+'"';	
					value +=",";
					value += naver.getCategory_name1();
					
					bw.write(value);
					
				bw.newLine();
			}
			// 쇼셜상품 
			List<NAVERVO> spList = scheduleDAO.selectNaverSp();
			for(NAVERVO naver : spList) {
				String value;
				value = naver.getId();
				value +=",";
				value += "in stock";
				value +=",";
				value += "new";
				value +=",";
				value += '"'+naver.getTitle()+'"';
				value +=",";
				value += url + naver.getImage_link();
				value +=",";
				value += url + "/web/sp/detailPrdt.do?prdtNum=" + naver.getId();
				value +=",";
				value += '"'+naver.getTitle()+'"';	
				value +=",";
				value += naver.getPrice_pc() + " KRW";
				value +=",";
				value += '"'+naver.getBrand()+'"';	
				value +=",";
				value += naver.getCategory_name1();
				
				bw.write(value);
				bw.newLine();
			}
			// 기념품
			List<NAVERVO> svList = scheduleDAO.selectNaverSv();
			for(NAVERVO naver : svList) {
				String value;
				value = naver.getId();
				value +=",";
				value += "in stock";
				value +=",";
				value += "new";
				value +=",";
				value += '"'+naver.getTitle()+'"';	
				value +=",";
				value += url + naver.getImage_link();
				value +=",";
				value += url + "/web/sv/detailPrdt.do?prdtNum=" + naver.getId();
				value +=",";
				value += '"'+naver.getTitle()+'"';	
				value +=",";
				value += naver.getPrice_pc() + " KRW";
				value +=",";
				value += '"'+naver.getBrand()+'"';	
				value +=",";
				value += naver.getCategory_name1();
				
				bw.write(value);
				bw.newLine();
			}
			// 숙소
			List<NAVERVO> adList = scheduleDAO.selectNaverAd();
			for(NAVERVO naver : adList) {
				String value;
				value = naver.getId();
				value +=",";
				value += "in stock";
				value +=",";
				value += "new";
				value +=",";
				value += '"'+naver.getTitle()+'"';	
				value +=",";
				value += url + naver.getImage_link();
				value +=",";
				value += url + "/web/ad/detailPrdt.do?sPrdtNum=" + naver.getId();
				value +=",";
				value += '"'+naver.getTitle()+'"';	
				value +=",";
				value += naver.getPrice_pc() + " KRW";
				value +=",";
				value += '"'+naver.getBrand()+'"';	
				value +=",";
				value += naver.getCategory_name1();
				
				bw.write(value);
				bw.newLine();
			}
			
			bw.close();
			
		}catch (Exception e){
			e.printStackTrace();
		}*/
	}
	
	/**
	 * L.Point 적립 배치 파일 생성
	 * 생성일시 : 2017. 09. 01.오전 11:12:42
	 * 생성자   : 정동수
	 * @return
	 * @throws IOException 
	 */
	public void lpointBatch() throws IOException{
		log.info("lpointBatch() call");
		
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    cal.setTime(new Date());
	    cal.add(Calendar.DAY_OF_YEAR, -1); // 전일 산출
	    String prevDate = sdfDate.format(cal.getTime());
	    
	    // 배치 파일 폴더
	    String batchFolder = EgovProperties.getProperty("L.POINT.Folder.batch") + prevDate.substring(0, 6) + "/";
		
	    File batchTemp = new File(batchFolder);
		if(!batchTemp.isDirectory()) {
			log.info("lpointBatch create folder!!");
			
			boolean _flag = batchTemp.mkdirs();
			if (!_flag) {
			    throw new IOException("Directory creation Failed ");
			}
		}
	    
		String serviceID = "O920";
		int batchCnt = 0;
		
		// 배치 파일 생성
		String batchStr = "";
		batchStr += "BH" + prevDate + serviceID + EgovProperties.getProperty("L.POINT.corpCode") + StringUtils.rightPad(" ", 1077) + "\n";	// 배치 파일 시작
		
		// 적립 자료
		List<LPOINTSAVEINFVO> lpointSaveList = webOrderService.selectLpointSaveList();
		
		// 적립 건수
		batchCnt += lpointSaveList != null ? lpointSaveList.size() : 0;
		
		// 적립 시
		for (LPOINTSAVEINFVO saveVO : lpointSaveList) {	
			batchStr += "BD" + "3" + "1" 
				+ StringUtils.rightPad(saveVO.getCardNum(), 37) 
				+ StringUtils.rightPad(" ", 20) + EgovProperties.getProperty("L.POINT.copMcno") 
				+ StringUtils.rightPad(saveVO.getPrdtRsvNum(), 19) 
				+ saveVO.getTradeDttm().substring(0, 10).replaceAll("-", "")
				+ saveVO.getTradeDttm().substring(11, 19).replaceAll(":", "") + "10" + "100" + "1" + "0" + "1" 
				+ String.format("%012d", Integer.parseInt(saveVO.getPayAmt())) 
				+ String.format("%012d", Integer.parseInt(saveVO.getPayAmt())) + String.format("%048d", 0) 
				+ String.format("%012d", Integer.parseInt(saveVO.getPayAmt())) + String.format("%054d", 0) + StringUtils.rightPad(" ", 845) + "\n";
		}

		batchStr += "BT" + String.format("%09d", batchCnt) + StringUtils.rightPad(" ", 1084);				// 배치 파일 종료
		
		String batchFile = "L-PointBatch_" + prevDate + ".txt";
		BufferedWriter fw = new BufferedWriter(new FileWriter(batchFolder + batchFile, true));
		
		fw.write(batchStr);
		fw.flush();
		fw.close();		
		log.info(batchFile + " file created!");
		
		// 배치 암호화 파일 생성
		String[] batch = new String[] {"java", "-jar", EgovProperties.getProperty("L.POINT.Folder") + "AFE.jar", EgovProperties.getProperty("L.POINT.Folder") + EgovProperties.getProperty("L.POINT.Key.batch"), batchFolder + batchFile, batchFolder + EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01"};
		Process process = new ProcessBuilder(batch).start();
		SequenceInputStream seqIn = new SequenceInputStream(process.getInputStream(), process.getErrorStream());	
		Scanner s = new Scanner(seqIn); 
		while (s.hasNextLine() == true) { 
			log.info("batch file encryption => " + s.nextLine());
		}
		// FIN 파일 생성 (배치 파일 종료를 위해 빈 파일(.FIN) 생성)
		fw = new BufferedWriter(new FileWriter(batchFolder + EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01.FIN", true));
		fw.flush();
		fw.close();
		log.info("batch encryption file created!");
		
		// SFTP 전송
		JSch jsch = new JSch();
		ChannelSftp channelSftp = null;
		Session session = null;
		Channel channel = null;
		try {
			session = jsch.getSession(EgovProperties.getProperty("L.POINT.Batch.user"), EgovProperties.getProperty("L.POINT.Batch.ip"), Integer.parseInt(EgovProperties.getProperty("L.POINT.Batch.port")));			
			session.setPassword(EgovProperties.getProperty("L.POINT.Batch.pass"));

	        java.util.Properties config = new java.util.Properties();
	        config.put("StrictHostKeyChecking", "no");
	        session.setConfig(config);
	        session.connect();

	        channel = session.openChannel("sftp");
	        channel.connect();
	        log.info("SFTP connect success!");
		} catch (JSchException e) {			
			e.printStackTrace();
			log.info("SFTP connect fail!!");
		}
		channelSftp = (ChannelSftp) channel;
		
		FileInputStream in = null;
		File file = new File(batchFolder + EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01");
        try { //파일을 가져와서 inputStream에 넣고 저장경로를 찾아 put
            in = new FileInputStream(file);
//		    channelSftp.cd(dir);
            channelSftp.put(in,file.getName());
            log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01 => upload success!");
        }catch(SftpException se){
            se.printStackTrace();
            log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01 => upload fail!!");
        }catch(FileNotFoundException fe){
            fe.printStackTrace();
            log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01 => file not found!!");
        }finally{
            try{
                in.close();
            } catch(IOException ioe){
                ioe.printStackTrace();
            }
        }
        
        file = new File(batchFolder + EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01.FIN");
        try { //파일을 가져와서 inputStream에 넣고 저장경로를 찾아 put
            in = new FileInputStream(file);
//	        channelSftp.cd(dir);
            channelSftp.put(in,file.getName());
            log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01.FIN => upload success!");
        }catch(SftpException se){
            se.printStackTrace();
            log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01.FIN => upload fail!!");
        }catch(FileNotFoundException fe){
            fe.printStackTrace();
            log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01.FIN => file not found!!");
        }finally{
            try{
                in.close();
            } catch(IOException ioe){
                ioe.printStackTrace();
            }
        }        
        
        channelSftp.quit();
        channel.disconnect();
        session.disconnect();
        
        log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01" + " file upload end!");
	}
	
	/**
	 * L.Point 적립 배치 파일 Download (SFTP)
	 * 생성일시 : 2017. 09. 01.오전 11:12:42
	 * 생성자   : 정동수
	 * @return 
	 */
	public void lpointBatchDownload() throws IOException {
		log.info("lpointBatchDownload() call");
		
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = new GregorianCalendar(Locale.KOREA);
	    cal.setTime(new Date());
	    cal.add(Calendar.DAY_OF_YEAR, -1); // 전일 산출
	    String prevDate = sdfDate.format(cal.getTime());
	    
	    // 배치 파일 폴더
	    String batchFolder = EgovProperties.getProperty("L.POINT.Folder.batch") + prevDate.substring(0, 6) + "/";
	
		// SFTP file download
		JSch jsch = new JSch();
		ChannelSftp channelSftp = null;
		Session session = null;
		Channel channel = null;
		String batchFile = EgovProperties.getProperty("L.POINT.Batch.download") + prevDate + ".01";
		String batchDecryptionFile = "L-PointBatch_decryption_" + prevDate + ".txt";
		try {
			session = jsch.getSession(EgovProperties.getProperty("L.POINT.Batch.user"), EgovProperties.getProperty("L.POINT.Batch.ip"), Integer.parseInt(EgovProperties.getProperty("L.POINT.Batch.port")));			
			session.setPassword(EgovProperties.getProperty("L.POINT.Batch.pass"));

	        java.util.Properties config = new java.util.Properties();
	        config.put("StrictHostKeyChecking", "no");
	        session.setConfig(config);
	        session.connect();

	        channel = session.openChannel("sftp");
	        channel.connect();
	        log.info("SFTP connect success!");
		} catch (JSchException e) {			
			e.printStackTrace();
			log.info("SFTP connect fail!!");
		}
		channelSftp = (ChannelSftp) channel;
		
		InputStream in = null;
		FileOutputStream out = null;
        try { //파일을 inputStream에 get            
		    channelSftp.cd("send");
		    in = channelSftp.get(batchFile);
            log.info(batchFile + " => download success!");
        }catch(SftpException se){
            se.printStackTrace();
            log.info(batchFile + " => download fail!!");
        }       
        
        try {
        	int i;
			out = new FileOutputStream(new File(batchFolder + batchFile));
			while ((i = in.read()) != -1) {
				out.write(i);
			}
		} catch (IOException  e) {
			e.printStackTrace();
			log.info(batchFile + " => create fail!!");
		} finally{
			out.close();
			in.close();
			
			// 배치 복호화 파일 생성	       
			String[] batch = new String[] {"java", "-jar", EgovProperties.getProperty("L.POINT.Folder") + "AFD.jar", EgovProperties.getProperty("L.POINT.Folder") + EgovProperties.getProperty("L.POINT.Key.batch"), batchFolder + batchFile, batchFolder + batchDecryptionFile };
			Process process = new ProcessBuilder(batch).start();
			SequenceInputStream seqIn = new SequenceInputStream(process.getInputStream(), process.getErrorStream());	
			Scanner s = new Scanner(seqIn); 
			while (s.hasNextLine() == true) { 
				log.info("batch file decryption => " + s.nextLine());
			}		
			log.info("batch decryption file created!");
        }
        
        channelSftp.quit();
        channel.disconnect();
        session.disconnect();
        
        log.info(batchFile + " file download end!");
        	
        log.info(batchFile + " file parse Start !!");
        String line = null;
        LPOINTSAVEINFVO lpointSaveInfVO = new LPOINTSAVEINFVO();
        BufferedReader fi = new BufferedReader(new FileReader(new File(batchFolder + batchDecryptionFile)));
        while ((line = fi.readLine()) != null) {
        	if ("BD".equals(line.substring(0, 2))) {
        		int savePoint = "00".equals(line.substring(929, 931)) ? Integer.parseInt(line.substring(911, 920)) : 0;
        		int evntPoint = "00".equals(line.substring(929, 931)) ? Integer.parseInt(line.substring(920, 929)) : 0;
	        	lpointSaveInfVO.setSaveYn(Constant.FLAG_Y);
	        	lpointSaveInfVO.setPrdtRsvNum(line.substring(71, 90).trim());
	        	lpointSaveInfVO.setCardNum(line.substring(4, 41).trim());
	        	lpointSaveInfVO.setConfNum(line.substring(888, 897).trim());
	        	if (line.substring(897, 905).trim() != "")
	        		lpointSaveInfVO.setConfDttm(line.substring(897, 905).trim() + line.substring(905, 911).trim());
	        	lpointSaveInfVO.setRespCd(line.substring(929, 931));
	        	lpointSaveInfVO.setSavePoint("" + savePoint);
	        	lpointSaveInfVO.setEvntPoint("" + evntPoint);	        	
	        	lpointSaveInfVO.setSaveRst(new String(line.substring(931, 995).trim()));
	        	
	        	webOrderService.updateLpointSave(lpointSaveInfVO);
        	}
        }
        fi.close();
        log.info(batchFile + " file parse End !");
	}
	
	/**
	 * 업체 지수 일별 등록
	 * 파일명 : updateCorpLevel
	 * 작성일 : 2017. 9. 29. 오후 3:29:28
	 * 작성자 : 정동수
	 */
	public void updateCorpLevel() {
		log.info("updateCorpLevel() call");
		
		scheduleDAO.updateCorpLevel();
	}
	
	/** 렌터카 기준금액*/
	public void updateRcApproxAmt() throws IOException, ParseException {
		/** API대략금액 컬럼 초기화*/
		rcDAO.deleteRcApproxAmt();

		String grimLoginId = "xkaskdhrmfladusruf2018";
		String grimLoginPw = "qlqjs2018";
		RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
		Calendar calNow = Calendar.getInstance();
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
		prdtSVO.setsFromTm("1200");
		prdtSVO.setsToTm("1200");
		prdtSVO.setSearchYn("Y");

		List<RC_PRDTINFVO> resultList = rcDAO.selectAPIRcPrdtList(prdtSVO);
		String sDate = prdtSVO.getsFromDt() + prdtSVO.getsFromTm();
		String eDate = prdtSVO.getsToDt() + prdtSVO.getsToTm();

		String rcAbleChkUrl = "http://tamnao.mygrim.com/carlist.php";
		String rcAbleChkParam = "tamnao_loginid=" + grimLoginId + "&tamnao_loginpw=" + grimLoginPw + "&st=" + sDate + "&et=" + eDate;

		URL url = new URL(rcAbleChkUrl);
		URLConnection conn = url.openConnection();

		conn.setDoOutput(true);
		OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
		wr.write(rcAbleChkParam);
		wr.flush();

		BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		JSONParser jsonParser = new JSONParser();
		/** obj는 업체ID를 담고 있음*/
		JSONObject obj = (JSONObject) jsonParser.parse(rd.readLine());
		/** corpId 키값 세팅 */
		Set key = obj.keySet();
		Iterator<String> iter = key.iterator();
		/** 리스트에 담을 API결과 초기화 */
		List<RC_PRDTINFVO> resultList2 = new ArrayList<RC_PRDTINFVO>();
		/** corpId키값을 루프*/
		while (iter.hasNext()) {
			/** 키값 세팅*/
			String keyname = iter.next();
			/** 키값이 null이 아닐결우 또는 []문자열 예외처리 */
			if (obj.get(keyname) != null && obj.get(keyname).toString() != "" && !obj.get(keyname).toString().contains("[]")) {
				/** obj2는 linkMappingNum을 가지고 있음*/
				JSONObject obj2 = (JSONObject) jsonParser.parse(obj.get(keyname).toString());
				/** linkMappingNum 키값 세팅*/
				Set key2 = obj2.keySet();
				Iterator<String> iter2 = key2.iterator();
				/** linkMappingNum 키값을 루프*/
				while (iter2.hasNext()) {
					String keyname2 = iter2.next();
					/**예외처리*/
					if (keyname2.equals("resultcode") || keyname2.equals("errorcode") | keyname2.equals("errormsg") | keyname2.equals("codemsg")) {
						continue;
					}
					/** linkMappingNum이 있으면*/
					if (org.apache.commons.lang.StringUtils.isNotEmpty(keyname2)) {
						RC_PRDTINFVO rcPrdtinfo = new RC_PRDTINFVO();
						/** 회사ID 셋*/
						rcPrdtinfo.setCorpId(keyname);
						/** linkMappingNum 셋 */
						rcPrdtinfo.setLinkMappingNum(keyname2);
						/** obj3는 대여료/보험정보를 가지고 있음*/
						JSONObject obj3 = new JSONObject();
						try {
							obj3 = (JSONObject) jsonParser.parse(obj2.get(keyname2).toString());
						}catch(ParseException ex){
							ex.printStackTrace();
							continue;
						}
						/** 대여료가 있으면*/
						if(obj3.get("model_salefee") != null){
							/** 대여료 셋 */
							rcPrdtinfo.setLinkMappingSaleAmt(obj3.get("model_salefee").toString());
							rcPrdtinfo.setNmlAmt(obj3.get("model_defaultfee").toString());
						}
						/** 보험정보가 있으면*/
						if(obj3.get("insurance") != null){
							JSONObject obj4 = (JSONObject) jsonParser.parse(obj3.get("insurance").toString());
							/** 보험ID 키값 세팅*/
							Set key3 = obj4.keySet();
							Iterator<String> iter3 = key3.iterator();
							/** 보험ID 키값을 루프*/
							while (iter3.hasNext()) {
								String keyname3 = iter3.next();
								if (org.apache.commons.lang.StringUtils.isNotEmpty(keyname3)) {
									JSONObject obj5 = (JSONObject) jsonParser.parse(obj4.get(keyname3).toString());
									if(obj5.get("insurance_salefee") != null){
										RC_PRDTINFVO apiResultVo = new RC_PRDTINFVO();
										apiResultVo.setCorpId(rcPrdtinfo.getCorpId());
										apiResultVo.setLinkMappingNum(rcPrdtinfo.getLinkMappingNum());
										apiResultVo.setLinkMappingSaleAmt(rcPrdtinfo.getLinkMappingSaleAmt());
										apiResultVo.setNmlAmt(rcPrdtinfo.getNmlAmt());
										apiResultVo.setLinkMappingIsrNum(obj5.get("insurance_id").toString());
										apiResultVo.setLinkMappingIsrAmt(obj5.get("insurance_salefee").toString());
										resultList2.add(apiResultVo);
									}
								}
							}
						/** 보험정보가 없다면*/
						}else{
							resultList2.add(rcPrdtinfo);
						}
					}
				}
			}
		}

		// 예약 여부 확인
		for (Iterator<RC_PRDTINFVO> it = resultList.iterator(); it.hasNext(); ) {
			RC_PRDTINFVO prdtVO = it.next();

			// 최대 예약 일시 체크
				if (Constant.FLAG_Y.equals(prdtVO.getCorpLinkYn()) && Constant.RC_RENTCAR_COMPANY_GRI.equals(prdtVO.getApiRentDiv()) && !EgovStringUtil.isEmpty(prdtVO.getLinkMappingNum()) && Constant.FLAG_Y.equals(prdtVO.getCorpAbleYn())) {
					if (Constant.FLAG_Y.equals(prdtSVO.getSearchYn())) {
						String ableYn = "0";
						String saleAmt = "0";
						String nmlAmt = "0";
						String isrAmt = "0";
						for (RC_PRDTINFVO rcPrdtinfovo : resultList2) {
							if (rcPrdtinfovo.getCorpId().equals(prdtVO.getCorpId()) && rcPrdtinfovo.getLinkMappingNum().equals(prdtVO.getLinkMappingNum())) {
								ableYn = "1";
								saleAmt = rcPrdtinfovo.getLinkMappingSaleAmt();
								nmlAmt = rcPrdtinfovo.getNmlAmt();
								if(rcPrdtinfovo.getLinkMappingIsrNum() != null && prdtVO.getLinkMappingIsrNum() != null ){
									if(rcPrdtinfovo.getLinkMappingIsrNum().equals(prdtVO.getLinkMappingIsrNum())){
										isrAmt = rcPrdtinfovo.getLinkMappingIsrAmt();
									}
								}
							}
						}
						if (Integer.parseInt(ableYn) > 0 && Integer.parseInt(saleAmt) > 0 ) {
							prdtVO.setAbleYn(Constant.FLAG_Y);
							/** 보험료 연동 */
							int iSaleAmt = Integer.parseInt(saleAmt);
							int iNmlAmt = Integer.parseInt(nmlAmt);
							int iIsrAmt = Integer.parseInt(isrAmt);
							int totalSaleAmt = 0;
							int totalNmlAmt = 0;
							if ("ID20".equals(prdtVO.getIsrDiv())) {
								totalSaleAmt = iSaleAmt;
								totalNmlAmt = iNmlAmt;
							}else{
								totalSaleAmt = iSaleAmt + iIsrAmt;
								totalNmlAmt = iNmlAmt + iIsrAmt;
							}
							prdtVO.setSaleAmt(Integer.toString(totalSaleAmt));
							prdtVO.setNmlAmt(Integer.toString(totalNmlAmt));
							rcDAO.updateRcApproxAmt(prdtVO);
						}
					}
				}
		}
		rd.close();
	}

	/** 배송추적 */
	public void goodsFlowReceiveTrace() {
		apiGoodsFlowService.receiveTraceResult();
	}

	/** 배송상품구매확정 */
	public void updateSVBuyFix() {
		scheduleDAO.updateSVBuyFix();
	}

	/** 탐나는전 정산 */
	public void insertTamnacardAdj() {
		scheduleDAO.insertTamnacardAdj();
	}

	/** 탐나는전 정산 */
	public void lsProudctSync() {
		SP_PRDTINFVO webParam = new SP_PRDTINFVO();
		webParam.setType("all");
		apiLsService.apiLsProductListSync(webParam);
	}

	/** POINT 에러체크 */
	public void checkPointErrAlarm() {
		Integer errCnt = scheduleDAO.checkPointErrAlarm();
		//전송실패 시 카카오톡 전송
		if (errCnt > 0){
			String[] receivers = {Constant.TAMNAO_TESTER1,Constant.TAMNAO_TESTER2};
			String[] recvNames = {Constant.TAMNAO_TESTER_NAME1,Constant.TAMNAO_TESTER_NAME2};

			APIAligoVO aligoVO = new APIAligoVO();
			aligoVO.setTplCode("TT_6608");
			aligoVO.setReceivers(receivers);
			aligoVO.setRecvNames(recvNames);
			aligoVO.setSubject("[시스템]POINT 결제 오류");
			aligoVO.setMsg("[긴급] POINT 결제 오류\n" +
				"POINT 오류건이 "+errCnt+"건 발생 하였습니다.");
			aligoVO.setFailover("Y"); //대체문자발송여부

			apiAligoService.aligoKakaoSend(aligoVO);

		}
	}

	public void sendEvent1User() {
		log.info("sendEvent1User call");
		String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
		if("test".equals(CST_PLATFORM.trim())) {
		/*if("1".equals(CST_PLATFORM.trim())) {*/
			log.info("sendEvent1User test end");
		}else{
			log.info("sendEvent1User push");
			MMSVO mmsVO = new MMSVO();
			mmsVO.setSubject("(광고) [탐나오] 사용완료 및 이벤트 알림");
			mmsVO.setMsg("탐나오와 함께한 제주여행 어떠셨나요~?\n"
					+"탐나오 렌트카, 관광지 이용고객 대상 설문이벤트를 진행하고 있습니다.\n"
					+"선착순 참여자 전원 상품을 드리오니 많은 참여 부탁드립니다.\n\n"
					+"* 상품 소진시, 사전 안내 없이 이벤트 조기 마감\n"
					+"* 자세한 내용 아래 링크 혹은 탐나오 홈페이지 참고\n"
					+"https://m.site.naver.com/1n7ij"
			);
			mmsVO.setStatus("0");
			mmsVO.setFileCnt("0");
			mmsVO.setType("0");
			mmsVO.setCallback(EgovProperties.getProperty("CS.PHONE"));

			List<LowerHashMap> userList = scheduleDAO.event1Userlist();
			log.info("send eventMsg size : " +  userList.size());
			for(HashMap<String,String> tempHashMap : userList){
				mmsVO.setPhone(tempHashMap.get("useTelnum"));
				log.info("send eventMsg : " + tempHashMap.get("useTelnum") + " - " + tempHashMap.get("userId"));
				smsService.sendMMS(mmsVO);
			}
		}
	}

	/**  알림톡 사용완료 7일 후 발송 **/
	public void kakaoSendAfter7Days() {
		log.info("call kakaoSendAfter7Days");
		//7일전 사용완료된 사용자 중 7일 이내 발송 이력이 없는 사용자
		List<Map<String, Object>> targetList = scheduleDAO.selectKakaoSendAfter7Days();

		/** 각 숙소 예약건에 대한 처리 */
		for (Map<String, Object> user : targetList) {

			//알림톡 발송 로그 테이블 저장
			scheduleDAO.insertKakaoConfirmAfterLog(user);

			//사용자 알림톡 보내기
			APIAligoVO aligoVO = new APIAligoVO();
			aligoVO.setTplCode("TZ_3109");
			aligoVO.setReceivers(new String[]{user.get("rsvTelnum").toString()});
			aligoVO.setRecvNames(new String[]{user.get("rsvNm").toString()});
			aligoVO.setSubject("상품 사용 완료 알림");

			String cateMessage = "SV".equals(user.get("cate").toString())  ? "특산/기념품 쇼핑" : "함께한 제주여행은";

			aligoVO.setMsg("[탐나오] 상품 사용 완료 알림\n" +
				"안녕하세요! 고객님\n" +
				"탐나오와 "+cateMessage+" 어떠셨나요~?\n" +
				"\n" +
				"많은 분들께 도움이 될 수 있도록\n" +
				"고객님의 소중한 리뷰를 남겨주세요.\n" +
				"\n" +
				"탐나오 리뷰 작성 고객 대상 선물을 드리고 있어요!");

			aligoVO.setFailover("Y"); //대체문자발송여부

			List<APIAligoButtonVO> buttonList = new ArrayList<>();

			APIAligoButtonVO button1 = new APIAligoButtonVO();
			button1.setName("리뷰 쓰러 가기");
			button1.setLinkType("WL");
			button1.setLinkTypeName("웹링크");
			button1.setLinkMo("https://www.tamnao.com/mw/coustomer/viewInsertUseepil.do");
			button1.setLinkPc("https://www.tamnao.com/web/coustmer/viewInsertUseepil.do");
			buttonList.add(button1);

			APIAligoButtonVO button2 = new APIAligoButtonVO();
			button2.setName("리뷰이벤트 확인하기");
			button2.setLinkType("WL");
			button2.setLinkTypeName("웹링크");
			button2.setLinkMo("https://m.site.naver.com/1B9j7");
			button2.setLinkPc("https://m.site.naver.com/1B9j7");
			buttonList.add(button2);

			// APIAligoVO에 버튼 그룹 설정
			aligoVO.setButtons(buttonList.toArray(new APIAligoButtonVO[0]));

			aligoVO.setSendDept("marketing");
			//System.out.println(aligoVO.getMsg());
			apiAligoService.aligoKakaoSend(aligoVO);
		}
	}

	/** 알림톡 유효기간(관광지, 맛집) 알림 3일 전 발송 */
	public void kakaoSendSpBefore3Days(){
		log.info("call kakaoSendSpBefore3Days");
		List<Map<String, Object>> targetList = scheduleDAO.kakaoSendSpBefore3Days();

		/** 각 숙소 예약건에 대한 처리 */
		for (Map<String, Object> user : targetList) {

			//사용자 알림톡 보내기
			APIAligoVO aligoVO = new APIAligoVO();
			aligoVO.setTplCode("TZ_3487");
			aligoVO.setReceivers(new String[]{user.get("rsvTelnum").toString()});
			aligoVO.setRecvNames(new String[]{user.get("rsvNm").toString()});
			aligoVO.setSubject("관광지, 맛집, 시티투어 3일전 알림");

			aligoVO.setMsg("[탐나오] 이용권 유효기간 안내\n" +
				"\n" +
				"안녕하세요, 고객님!\n" +
				"탐나오에서 예약하신 상품의 유효기간이 곧 만료됩니다.\n" +
				"상품 예약정보를 다시 한번 확인해주세요.\n" +
				"\n" +
				"[예약내역]\n" +				
				"-업체정보: "+user.get("corpNm")+", "+user.get("corpTelnum")+"\n" +
				"-예약내역: "+user.get("prdtNm")+"\n" +
				"-결제금액: "+user.get("saleAmt")+"원\n" +
				"\n" +
				"남은 기간 동안 즐거운 이용 되시길 바랍니다.\n" +
				"즐거운 여행 되세요!\n" +
				"\n" +
				"★ 예약하신 상품 이용일이 변경되었거나 사용 예정이 없으신 경우 이용일 이전 취소 신청 가능하며, 수수료가 발생할 수 있습니다.\n" +
				"\n" +
				"★ 상품과 관련된 자세한 내용은 [마이탐나오] →[나의예약/구매내역] 예약 건 상세페이지 내에서 확인 가능합니다.\n" +
				"\n" +
				"★ 추가 문의사항은 <탐나오 고객센터> 1522-3454 및 tamnao@jta.or.kr 로 문의 바랍니다. (운영시간: 평일 09:00 ~ 18:00 / 점심 12:00 ~ 13:00)\n" +
				"※ 운영시간 이외 유선 또는 메일 문의 접수가 어려울 수 있습니다.");


			aligoVO.setFailover("Y");

			List<APIAligoButtonVO> buttonList = new ArrayList<>();

			APIAligoButtonVO button1 = new APIAligoButtonVO();
			button1.setName("마이탐나오");
			button1.setLinkType("WL");
			button1.setLinkTypeName("웹링크");
			button1.setLinkMo("https://www.tamnao.com/mw/mypage/mainList.do");
			button1.setLinkPc("https://www.tamnao.com/web/mypage/rsvList.do");
			buttonList.add(button1);

			// APIAligoVO에 버튼 그룹 설정
			aligoVO.setButtons(buttonList.toArray(new APIAligoButtonVO[0]));

			apiAligoService.aligoKakaoSend(aligoVO);
		}
	}

	/** 알림톡 유효기간(숙박, 렌트카) 알림 7일 전 발송 */
	public void kakaoSendRcAdBefore7Days(){
		log.info("call kakaoSendRcAdBefore7Days");
		List<Map<String, Object>> targetList = scheduleDAO.kakaoSendRcAdBefore7Days();

		/** 각 숙소 예약건에 대한 처리 */
		for (Map<String, Object> user : targetList) {

			//사용자 알림톡 보내기
			APIAligoVO aligoVO = new APIAligoVO();
			aligoVO.setTplCode("TZ_3492");
			aligoVO.setReceivers(new String[]{user.get("rsvTelnum").toString()});
			aligoVO.setRecvNames(new String[]{user.get("rsvNm").toString()});
			aligoVO.setSubject("숙소, 렌트카 7일전 알림");

			aligoVO.setMsg("[탐나오] 탐나오와 함께 즐거운 여행되세요!\n" +
				"\n" +
				"안녕하세요, 고객님!\n" +
				"다가오는 여행 준비를 한 번 더 체크해드릴게요!\n" +
				"\n" +
				"[예약내역]\n" +
				"-업체정보: "+user.get("corpNm")+", "+user.get("corpTelnum")+"\n" +
				"-예약내역: "+user.get("prdtNm")+"\n" +
				"-결제금액: "+user.get("saleAmt")+"원\n" +
				"\n" +
				"여행 준비는 이제 탐나오와 함께!\n" +
				"모든 게 준비됐으니, 이제 마음껏 여행을 즐기세요!\n" +
				"\n" +
				"★ 예약하신 상품 이용일이 변경되었거나 사용 예정이 없으신 경우 이용일 이전 취소 신청 가능하며, 수수료가 발생할 수 있습니다.\n" +
				"\n" +
				"★ 상품과 관련된 자세한 내용은 [마이탐나오] →[나의예약/구매내역] 예약 건 상세페이지 내에서 확인 가능합니다.\n" +
				"\n" +
				"★ 추가 문의사항은 <탐나오 고객센터> 1522-3454 및 tamnao@jta.or.kr 로 문의 바랍니다. (운영시간: 평일 09:00 ~ 18:00 / 점심 12:00 ~ 13:00) \n" +
				"※ 운영시간 이외 유선 또는 메일 문의 접수가 어려울 수 있습니다.");

			aligoVO.setFailover("Y"); //대체문자발송여부

			List<APIAligoButtonVO> buttonList = new ArrayList<>();

			APIAligoButtonVO button1 = new APIAligoButtonVO();
			button1.setName("마이탐나오");
			button1.setLinkType("WL");
			button1.setLinkTypeName("웹링크");
			button1.setLinkMo("https://www.tamnao.com/mw/mypage/mainList.do");
			button1.setLinkPc("https://www.tamnao.com/web/mypage/rsvList.do");
			buttonList.add(button1);

			// APIAligoVO에 버튼 그룹 설정
			aligoVO.setButtons(buttonList.toArray(new APIAligoButtonVO[0]));

			apiAligoService.aligoKakaoSend(aligoVO);
		}
	}
}


