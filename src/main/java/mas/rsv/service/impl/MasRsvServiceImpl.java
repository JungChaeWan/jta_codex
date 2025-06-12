package mas.rsv.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import lgdacom.XPayClient.XPayClient;
import mas.rsv.service.MasRsvService;
import mas.rsv.vo.SP_RSVHISTVO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.service.OssFileUtilService;
import web.order.service.impl.WebOrderDAO;
import web.order.vo.AD_RSVVO;
import web.order.vo.ORDERVO;
import web.order.vo.PAYVO;
import web.order.vo.RC_RSVVO;
import web.order.vo.RSVSVO;
import web.order.vo.RSVVO;
import web.order.vo.SP_RSVVO;
import web.order.vo.SV_RSVVO;
import common.Constant;
import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("masRsvService")
public class MasRsvServiceImpl extends EgovAbstractServiceImpl implements MasRsvService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;

	@Resource(name = "webOrderDAO")
	private WebOrderDAO webOrderDAO;

	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;


	/**
	 * 렌터카 예약 내역 조회
	 * 파일명 : selectRcRsvList
	 * 작성일 : 2015. 11. 30. 오후 3:42:48
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectRcRsvList(RSVSVO rsvSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<RC_RSVVO> resultList = rsvDAO.selectRcRsvList(rsvSVO);
		Integer totalCnt = rsvDAO.getCntRcRsvList(rsvSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	/**
	 * 렌터카 예약 내역 전체 조회
	 * 파일명 : selectRcRsvListAll
	 * 작성일 : 2017. 8. 7. 오전 9:24:45
	 * 작성자 : 정동수
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public List<RC_RSVVO> selectRcRsvListAll(RSVSVO rsvSVO) {
		rsvSVO.setLastIndex(0);
		return rsvDAO.selectRcRsvList(rsvSVO);
	}

	/**
	 * 숙박 예약 내역 조회
	 * 파일명 : selectAdRsvList
	 * 작성일 : 2015. 12. 1. 오전 9:36:24
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectAdRsvList(RSVSVO rsvSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<AD_RSVVO> resultList = rsvDAO.selectAdRsvList(rsvSVO);
		Integer totalCnt = rsvDAO.getCntAdRsvList(rsvSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	/**
	 * 숙박 예약 내역 전체 조회
	 * 파일명 : selectAdRsvListAll
	 * 작성일 : 2017. 8. 2. 오후 5:55:15
	 * 작성자 : 정동수
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public List<AD_RSVVO> selectAdRsvListAll(RSVSVO rsvSVO) {
		rsvSVO.setLastIndex(0);
		return rsvDAO.selectAdRsvList(rsvSVO);
	}

	/**
	 * 렌터카 예약 상세
	 * 파일명 : selectRcDetailRsv
	 * 작성일 : 2015. 12. 10. 오전 10:17:11
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 * @return
	 */
	@Override
	public RC_RSVVO selectRcDetailRsv(RC_RSVVO rcRsvVO){
		return rsvDAO.selectRcDetailRsv(rcRsvVO);
	}

	/**
	 * LG U+ 부분취소처리
	 * 파일명 : partialCancelPay
	 * 작성일 : 2015. 12. 10. 오후 1:16:45
	 * 작성자 : 최영철
	 * @param payVO
	 * @param refundAmt		취소금액
	 * @param rsvNum		예약번호
	 * @return
	 */
	@Override
	public PAYVO partialCancelPay(PAYVO payVO, String rsvNum, String dtlRsvNum, String refundAmt, String payDiv){
		PAYVO payResult = new PAYVO();
		payResult.setRsvNum(rsvNum);
		payResult.setDtlRsvNum(dtlRsvNum);
		payResult.setPayAmt(refundAmt);
		payResult.setPayDiv(payDiv);

		String CST_PLATFORM        = EgovProperties.getOptionalProp("CST_PLATFORM");     	//LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
	    String CST_MID             = EgovProperties.getProperty("Globals.LgdID.PRE");           	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
	    String LGD_MID             = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.

		if(Constant.PAY_DIV_LG_HC.equals(payDiv)){
		    CST_MID             = EgovProperties.getProperty("Globals.LgdID.HP");           	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
		    LGD_MID             = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.

		}

		log.info("*************************************");
		log.info("CST_MID :: " + CST_MID);
		log.info("*************************************");

	    String LGD_TID = payVO.getLGD_TID();
	    payResult.setLGD_TID(LGD_TID);

	    String configPath 			= EgovProperties.getProperty(Constant.FLAG_INIT + ".LgdFolder");

	    LGD_TID     				= ( LGD_TID == null )?"":LGD_TID;

	    XPayClient xpay = new XPayClient();
    	xpay.Init(configPath, CST_PLATFORM);
    	xpay.Init_TX(LGD_MID);
    	xpay.Set("LGD_TXNAME", "PartialCancel");
    	xpay.Set("LGD_TID", LGD_TID);
    	xpay.Set("LGD_CANCELAMOUNT", refundAmt);

    	if (xpay.TX()) {
    		//1)결제취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
    		log.info("결제 취소요청이 완료되었습니다.");
    		log.info( "TX Response_code = " + xpay.m_szResCode);
    		log.info( "TX Response_msg = " + xpay.m_szResMsg);

    		if("0000".equals(xpay.m_szResCode)){

    			payResult.setPayRstCd("0000");
    			payResult.setPayRstInf("취소성공");

    		}else{
    			log.error("결제 취소요청이 실패하였습니다.");
    			log.error( "TX Response_code = " + xpay.m_szResCode);
    			log.error( "TX Response_msg = " + xpay.m_szResMsg);

    			payResult.setPayRstCd(xpay.m_szResCode);
    			payResult.setPayRstInf(xpay.m_szResMsg);
    		}
    	}else {
    		//2)API 요청 실패 화면처리
    		log.error("결제 취소요청이 실패하였습니다.");
    		log.error( "TX Response_code = " + xpay.m_szResCode);
    		log.error( "TX Response_msg = " + xpay.m_szResMsg);

    		payResult.setPayRstCd(xpay.m_szResCode);
    		payResult.setPayRstInf(xpay.m_szResMsg);
    	}

    	webOrderDAO.insertPay(payResult);

		return payResult;
	}

	@Override
	public PAYVO partialCancelPayCyberAccount(PAYVO payVO, String rsvNum, String dtlRsvNum, String refundAmt, String payDiv, String LGD_RFBANKCODE, String LGD_RFACCOUNTNUM, String LGD_RFCUSTOMERNAME){
		PAYVO payResult = new PAYVO();
		payResult.setRsvNum(rsvNum);
		payResult.setDtlRsvNum(dtlRsvNum);
		payResult.setPayAmt(refundAmt);
		payResult.setPayDiv(payDiv);

		String CST_PLATFORM        = EgovProperties.getOptionalProp("CST_PLATFORM");     	//LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
	    String CST_MID             = EgovProperties.getProperty("Globals.LgdID.PRE");           	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
	    String LGD_MID             = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.

		if(Constant.PAY_DIV_LG_HC.equals(payDiv)){
		    CST_MID             = EgovProperties.getProperty("Globals.LgdID.HP");           	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
		    LGD_MID             = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.

		}

		log.info("*************************************");
		log.info("CST_MID :: " + CST_MID);
		log.info("*************************************");

	    String LGD_TID = payVO.getLGD_TID();
	    payResult.setLGD_TID(LGD_TID);

	    String configPath 			= EgovProperties.getProperty(Constant.FLAG_INIT + ".LgdFolder");

	    LGD_TID     				= ( LGD_TID == null )?"":LGD_TID;

	    XPayClient xpay = new XPayClient();
    	xpay.Init(configPath, CST_PLATFORM);
    	xpay.Init_TX(LGD_MID);
    	xpay.Set("LGD_TXNAME", "PartialCancel");
    	xpay.Set("LGD_TID", LGD_TID);
    	xpay.Set("LGD_CANCELAMOUNT", refundAmt);

    	System.out.println(LGD_RFBANKCODE);
    	System.out.println(LGD_RFACCOUNTNUM);
    	System.out.println(LGD_RFCUSTOMERNAME);
    	xpay.Set("LGD_RFBANKCODE", LGD_RFBANKCODE);
    	xpay.Set("LGD_RFACCOUNTNUM", LGD_RFACCOUNTNUM);
    	xpay.Set("LGD_RFCUSTOMERNAME", LGD_RFCUSTOMERNAME);

    	if (xpay.TX()) {
    		//1)결제취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
    		log.info("결제 취소요청이 완료되었습니다.");
    		log.info( "TX Response_code = " + xpay.m_szResCode);
    		log.info( "TX Response_msg = " + xpay.m_szResMsg);

    		if("0000".equals(xpay.m_szResCode)){

    			payResult.setPayRstCd("0000");
    			payResult.setPayRstInf("취소성공");

    		}else{
    			log.error("결제 취소요청이 실패하였습니다.");
    			log.error( "TX Response_code = " + xpay.m_szResCode);
    			log.error( "TX Response_msg = " + xpay.m_szResMsg);

    			payResult.setPayRstCd(xpay.m_szResCode);
    			payResult.setPayRstInf(xpay.m_szResMsg);
    		}
    	}else {
    		//2)API 요청 실패 화면처리
    		log.error("결제 취소요청이 실패하였습니다.");
    		log.error( "TX Response_code = " + xpay.m_szResCode);
    		log.error( "TX Response_msg = " + xpay.m_szResMsg);

    		payResult.setPayRstCd(xpay.m_szResCode);
    		payResult.setPayRstInf(xpay.m_szResMsg);
    	}

    	webOrderDAO.insertPay(payResult);

		return payResult;
	}


	/**
	 * LG U+ 휴대폰 취소처리
	 * 파일명 : hpCancelPay
	 * 작성일 : 2015. 12. 10. 오후 1:16:45
	 * 작성자 : 최영철
	 * @param payVO
	 * @param refundAmt		취소금액
	 * @param rsvNum		예약번호
	 * @return
	 */
	public PAYVO hpCancelPay(PAYVO payVO, String rsvNum, String dtlRsvNum, String refundAmt, String payDiv){
		PAYVO payResult = new PAYVO();
		payResult.setRsvNum(rsvNum);
		payResult.setDtlRsvNum(dtlRsvNum);
		payResult.setPayAmt(refundAmt);
		payResult.setPayDiv(payDiv);

		String CST_PLATFORM        = EgovProperties.getOptionalProp("CST_PLATFORM");     	//LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
		String CST_MID             = EgovProperties.getProperty("Globals.LgdID.HP");             	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
		String LGD_MID             = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.

		log.info("*************************************");
		log.info("CST_MID :: " + CST_MID);
		log.info("*************************************");

		String LGD_TID = payVO.getLGD_TID();
		payResult.setLGD_TID(LGD_TID);

		String configPath 			= EgovProperties.getProperty(Constant.FLAG_INIT + ".LgdFolder");

		LGD_TID     				= ( LGD_TID == null )?"":LGD_TID;

		XPayClient xpay = new XPayClient();
		xpay.Init(configPath, CST_PLATFORM);
		xpay.Init_TX(LGD_MID);
		xpay.Set("LGD_TXNAME", "Cancel");
		xpay.Set("LGD_TID", LGD_TID);
		xpay.Set("LGD_CANCELAMOUNT", refundAmt);

		if (xpay.TX()) {
			//1)결제취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
			log.info("결제 취소요청이 완료되었습니다.");
			log.info( "TX Response_code = " + xpay.m_szResCode);
			log.info( "TX Response_msg = " + xpay.m_szResMsg);

			if("0000".equals(xpay.m_szResCode)){

				payResult.setPayRstCd("0000");
				payResult.setPayRstInf("취소성공");

			}else{
				log.error("결제 취소요청이 실패하였습니다.");
				log.error( "TX Response_code = " + xpay.m_szResCode);
				log.error( "TX Response_msg = " + xpay.m_szResMsg);

				payResult.setPayRstCd(xpay.m_szResCode);
				payResult.setPayRstInf(xpay.m_szResMsg);
			}
		}else {
			//2)API 요청 실패 화면처리
			log.error("결제 취소요청이 실패하였습니다.");
			log.error( "TX Response_code = " + xpay.m_szResCode);
			log.error( "TX Response_msg = " + xpay.m_szResMsg);

			payResult.setPayRstCd(xpay.m_szResCode);
			payResult.setPayRstInf(xpay.m_szResMsg);
		}

		webOrderDAO.insertPay(payResult);

		return payResult;
	}

	@Override
	public Map<String, Object> selectSpRsvList(RSVSVO rsvSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<SP_RSVVO> resultList = rsvDAO.selectSpRsvList(rsvSVO);
		Integer totalCnt = rsvDAO.getCntSpRsvList(rsvSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public SP_RSVVO selectSpDetailRsv(SP_RSVVO spRsvVO) {
		return rsvDAO.selectSpDetailRsv(spRsvVO);
	}


	/**
	 * 숙소 예약 상세
	 * 파일명 : selectAdDetailRsv
	 * 작성일 : 2015. 12. 12. 오후 12:01:56
	 * 작성자 : 신우섭
	 * @param adRsvVO
	 * @return
	 */
	@Override
	public AD_RSVVO selectAdDetailRsv(AD_RSVVO adRsvVO) {
		return rsvDAO.selectAdDetailRsv(adRsvVO);
	}

	@Override
	public Map<String, Object> cancelPay(String payDiv, String rsvNum, String rcRsvNum, String cancelAmt, String userIp, String LGD_RFBANKCODE, String LGD_RFACCOUNTNUM, String LGD_RFCUSTOMERNAME) throws ParseException{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		PAYVO payResult = new PAYVO();
		String success = "";

		// 결제정보VO
    	PAYVO payVO = new PAYVO();
    	// 예약번호
    	payVO.setRsvNum(rsvNum);
    	// 결제수단
    	payVO.setPayDiv(payDiv);
    	// 결제결과코드(0000 : 결제성공)
    	payVO.setPayRstCd("0000");
    	// 초기 결제 성공건에 대한 조회
		payVO = webOrderDAO.selectByPayInfo(payVO);
		
		if ("0".equals(cancelAmt) == false && payVO != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			SimpleDateFormat sdfM = new SimpleDateFormat("yyyy-MM");

			Date fromDate = Calendar.getInstance().getTime();
			Date toDate = sdf.parse(payVO.getPayDttm());
	
			/** 토스 신용카드결제, 간편결제 */
	    	if(Constant.PAY_DIV_LG_CI.equals(payDiv) || Constant.PAY_DIV_LG_NP.equals(payDiv) || Constant.PAY_DIV_LG_KP.equals(payDiv) || Constant.PAY_DIV_LG_AP.equals(payDiv) || Constant.PAY_DIV_LG_TP.equals(payDiv)){
	    		// 해당건에 대해 취소 처리 PAY_DIV_LG_CC(L101 : 카드결제취소)
	    		payResult = partialCancelPay(payVO, rsvNum, rcRsvNum, cancelAmt, Constant.PAY_DIV_LG_CC);
	
	    		if("0000".equals(payResult.getPayRstCd()) || "AV11".equals(payResult.getPayRstCd())){
	    			success = Constant.FLAG_Y;
	    		}else{
	    			success = Constant.FLAG_N;
	    		}
	    	}
	    	/** 토스 휴대폰결제 */
	    	else if(Constant.PAY_DIV_LG_HI.equals(payDiv)){
	    		if(payVO.getPayAmt().equals(cancelAmt)){
	    			String sFromDate = sdfM.format(fromDate);
	        		String sToDate = sdfM.format(toDate);
	        		// 당월 결제건인 경우 자동취소가능
	        		if(sFromDate.equals(sToDate)){
	        			// 해당건에 대해 취소 처리 PAY_DIV_LG_HC(L201 : 핸드폰결제취소)
	            		payResult = hpCancelPay(payVO, rsvNum, rcRsvNum, cancelAmt, Constant.PAY_DIV_LG_HC);
	
	            		if("0000".equals(payResult.getPayRstCd())){
	            			success = Constant.FLAG_Y;
	            		}else{
	            			success = Constant.FLAG_N;
	            		}
	        		}else{
	        			success = Constant.FLAG_N;
	        			payResult.setPayRstInf("휴대폰결제는 당월 구매건만 자동처리 됩니다.");
	        		}
	    		}else{
	    			success = Constant.FLAG_N;
	    			payResult.setPayRstInf("휴대폰결제는 부분취소가 불가능합니다.");
	    		}
	
	    	}
			/** 토스 실시간계좌이체 */
	    	else if(Constant.PAY_DIV_LG_TI.equals(payDiv) || Constant.PAY_DIV_LG_ETI.equals(payDiv)){
	    		// 결제일로부터 10일이 지나지 않은경우에 자동취소
	    		if(OssCmmUtil.getDifDay(toDate, fromDate) < 10){
	    			// 해당건에 대해 취소 처리 PAY_DIV_LG_TC(L301 : 계좌이체 취소)
	        		payResult = partialCancelPay(payVO, rsvNum, rcRsvNum, cancelAmt, Constant.PAY_DIV_LG_TC);
	
	        		if(	"0000".equals(payResult.getPayRstCd()) ||
	        			"RF00".equals(payResult.getPayRstCd()) ||
	        			"RF10".equals(payResult.getPayRstCd()) ||
	        			"RF09".equals(payResult.getPayRstCd()) ||
	        			"RF15".equals(payResult.getPayRstCd()) ||
	        			"RF19".equals(payResult.getPayRstCd()) ||
	        			"RF23".equals(payResult.getPayRstCd()) ||
	        			"RF25".equals(payResult.getPayRstCd())){
	        			success = Constant.FLAG_Y;
	        		}else{
	        			success = Constant.FLAG_N;
	        		}
	    		}else{
	    			success = Constant.FLAG_N;
	    			payResult.setPayRstInf("계좌이체는 10일이내건만 자동처리 됩니다.");
	    		}
	    	}
	    	/** 토스 무통장이체 */
	    	else if(Constant.PAY_DIV_LG_MI.equals(payDiv)){

				payResult = partialCancelPayCyberAccount(payVO, rsvNum, rcRsvNum, cancelAmt, Constant.PAY_DIV_LG_MC, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME  );

				if(	"0000".equals(payResult.getPayRstCd()) || "RF00".equals(payResult.getPayRstCd()) ){
					success = Constant.FLAG_Y;
				}else{
					payResult.setPayRstInf(payResult.getPayRstInf());
					success = Constant.FLAG_N;
				}
	    	}
	    } else {
	    	success = Constant.FLAG_Y;
	    	payResult.setPayRstInf("취소완료");
	    }
    	resultMap.put("success", success);
    	resultMap.put("payResult", payResult);

    	return resultMap;
	}

	/**
	 * 예약 취소 시 업데이트 처리
	 * 파일명 : updateCancelRsv
	 * 작성일 : 2015. 12. 14. 오후 2:19:25
	 * 작성자 : 최영철
	 * @param rsvVO
	 */
	@Override
	public void updateCancelRsv(RSVVO rsvVO){
		rsvDAO.updateCancelRsv(rsvVO);
	}

	@Override
	public void updateRsvAdmMemo(SP_RSVVO spRsvVO) {
		rsvDAO.updateRsvAdmMemo(spRsvVO);

	}

	@Override
	public List<SP_RSVHISTVO> selectSpRsvHistList(SP_RSVVO spRsvVO) {
		return rsvDAO.selectSpRsvHistList(spRsvVO);
	}

	@Override
	public void insertSpRsvhist(SP_RSVHISTVO sp_RSVHISTVO) {
		rsvDAO.insertSpRsvhist(sp_RSVHISTVO);
	}

	@Override
	public void updateSpUseDttm(SP_RSVVO spRsvVO) {
		rsvDAO.updateSpUseDttm(spRsvVO);
	}

	@Override
	public AD_RSVVO selectAdRsv(AD_RSVVO adRsvVO) {
		return rsvDAO.selectAdRsv(adRsvVO);
	}

	@Override
	public int getCntRsvMainToday(RSVSVO rsvSVO) {
		return rsvDAO.getCntRsvMainToday(rsvSVO);
	}

	@Override
	public int getCntRsvMainCalPay(RSVSVO rsvSVO) {
		return rsvDAO.getCntRsvMainCalPay(rsvSVO);
	}

	@Override
	public int getCntRsvMainTotPay(RSVSVO rsvSVO) {
		return rsvDAO.getCntRsvMainTotPay(rsvSVO);
	}

	@Override
	public long getAmtRsvMainTot(RSVSVO rsvSVO) {
		return rsvDAO.getAmtRsvMainTot(rsvSVO);
	}

	@Override
	public long getAmtRsvMainTotCal(RSVSVO rsvSVO) {
		return rsvDAO.getAmtRsvMainTotCal(rsvSVO);
	}

	/**
	 * 예약확인 처리
	 * 파일명 : updateRsvIdt
	 * 작성일 : 2016. 2. 25. 오후 1:54:17
	 * 작성자 : 최영철
	 * @param orderVO
	 */
	@Override
	public void updateRsvIdt(ORDERVO orderVO){
		rsvDAO.updateRsvIdt(orderVO);
	}

	/**
	 * 소셜 구분자 옵션에 따른 예약존재확인
	 * 파일명 : selectSpRsvList2
	 * 작성일 : 2016. 3. 10. 오전 10:26:21
	 * 작성자 : 최영철
	 * @param spRsvVO
	 * @return
	 */
	@Override
	public List<SP_RSVVO> selectSpRsvList2(SP_RSVVO spRsvVO){
		return rsvDAO.selectSpRsvList2(spRsvVO);
	}

	/**
	 * 입점업체 소셜 예약 엑셀 다운로드용 조회
	 * 파일명 : selectSpRsvExcelList
	 * 작성일 : 2016. 5. 3. 오전 9:38:58
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public List<SP_RSVVO> selectSpRsvExcelList(RSVSVO rsvSVO){
		return rsvDAO.selectSpRsvExcelList(rsvSVO);
	}

	/**
	 * 소셜(관광지)의 QR 코드 리스트 조회
	 * Function : selectSpRsvQrList
	 * 작성일 : 2016. 10. 25. 오후 3:31:56
	 * 작성자 : 정동수
	 * @return
	 */
	@Override
	public Map<String, Object> selectSpRsvQrList(SP_RSVVO spRsvVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		Integer remainRsv = 0;
		String regDttm = null;
		List<SP_RSVVO> posList = new ArrayList<SP_RSVVO>();
		List<SP_RSVVO> directList = new ArrayList<SP_RSVVO>();
		List<SP_RSVVO> rsvList = rsvDAO.selectSpRsvQrList(spRsvVO);

		for (SP_RSVVO rsv : rsvList) {
			if (regDttm == null) {
				regDttm = rsv.getRegDttm();
			}

			if (Constant.FLAG_Y.equals(rsv.getPosUseYn())) {
				posList.add(rsv);
				if (Constant.RSV_STATUS_CD_COM.equals(rsv.getRsvStatusCd())) {
					remainRsv++;
				}
			} else {
				directList.add(rsv);
				if (Constant.RSV_STATUS_CD_COM.equals(rsv.getRsvStatusCd())) {
					remainRsv++;
				}
			}
		}

		resultMap.put("rsvNum", spRsvVO.getRsvNum());			// 예약 번호
		resultMap.put("regDttm", regDttm);						// 예약 일시
		resultMap.put("remainRsv", remainRsv);					// 남은 쿠폰 수
		resultMap.put("totalRsv", posList.size() + directList.size()); // 예약 쿠폰 수
		resultMap.put("posList", posList);						// 포스 사용 쿠폰 리스트
		resultMap.put("directList", directList);				// 바로 사용 쿠폰 리스트 (포스 X)

		return resultMap;
	}

	/**
	 * 기념품 구분자 옵션에 따른 예약존재 확인.
	 */
	@Override
	public List<SV_RSVVO> selectSvRsvList2(SV_RSVVO svRsvVO) {
		return rsvDAO.selectSvRsvList2(svRsvVO);
	}

	/**
	 * 기념품 구매 리스트
	 */
	@Override
	public Map<String, Object> selectSvRsvList(RSVSVO rsvSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<SV_RSVVO> resultList = rsvDAO.selectSvRsvList(rsvSVO);
		Integer totalCnt = rsvDAO.getCntSvRsvList(rsvSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	/**
	 * 기념품 상세
	 */
	@Override
	public SV_RSVVO selectSvDetailRsv(SV_RSVVO svRsvVO) {
		return rsvDAO.selectSvDetailRsv(svRsvVO);
	}

	@Override
	public void updateDlvNum(SV_RSVVO svRsvVO) {
		rsvDAO.updateDlvNum(svRsvVO);
	}

	@Override
	public int resetDlvNum(String svRsvNum) {
		return rsvDAO.resetDlvNum(svRsvNum);
	}

	/**
	 * 입점업체 기념품 예약 엑셀 다운로드용 조회
	 * 파일명 : selectSvRsvExcelList
	 * 작성일 : 2017. 1. 11. 오후 5:08:07
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public List<SV_RSVVO> selectSvRsvExcelList(RSVSVO rsvSVO){
		return rsvDAO.selectSvRsvExcelsList(rsvSVO);
	}

	@Override
	public void updateSVDirectRecvComp(SV_RSVVO svRsvVO) {
		rsvDAO.updateSVDirectRecvComp(svRsvVO);

	}

}
