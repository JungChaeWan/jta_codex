package web.order.service.impl;

import api.service.*;
import api.vo.APIAligoButtonVO;
import api.vo.APIAligoVO;
import common.Constant;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.cmmn.service.SmsService;
import egovframework.cmmn.service.impl.ScheduleDAO;
import egovframework.cmmn.vo.MMSVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.ad.service.impl.AdDAO;
import mas.prmt.service.impl.PrmtDAO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rsv.service.MasRsvService;
import mas.rsv.service.impl.RsvDAO;
import mas.sp.vo.SP_PRDTINFVO;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vdurmont.emoji.EmojiParser;

import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssMailService;
import oss.corp.service.OssCorpService;
import oss.corp.service.impl.CorpDAO;
import oss.corp.vo.CORPVO;
import oss.coupon.vo.CPVO;
import oss.marketing.serive.OssSmsEmailWordsService;
import oss.marketing.vo.EVNTINFVO;
import oss.marketing.vo.SMSEMAILWORDSVO;
import oss.point.service.OssPointService;
import oss.point.vo.POINTVO;
import oss.sp.service.impl.SpDAO;
import web.mypage.service.WebMypageService;
import web.mypage.service.impl.UserCpDAO;
import web.mypage.vo.RSV_HISSVO;
import web.mypage.vo.USER_CPVO;
import web.order.service.WebOrderService;
import web.order.vo.*;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;
import web.product.service.impl.WebAdDAO;
import web.product.vo.CARTVO;
import web.product.vo.WEB_DTLPRDTVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import static java.lang.System.out;


@Service("webOrderService")
public class WebOrderServiceImpl extends EgovAbstractServiceImpl implements WebOrderService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name = "webOrderDAO")
	private WebOrderDAO webOrderDAO;

	@Resource(name = "userCpDAO")
	private UserCpDAO userCpDAO;

	@Resource(name = "adDAO")
	private AdDAO adDAO;

	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;

	@Resource(name = "corpDAO")
	private CorpDAO corpDAO;

	@Resource(name = "spDAO")
	private SpDAO spDAO;

	@Resource(name = "prmtDAO")
	private PrmtDAO prmtDAO;

	@Resource(name = "webAdDAO")
	private WebAdDAO webAdDAO;

	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;

	@Resource(name="smsService")
	protected SmsService smsService;

	@Resource(name = "ossMailService")
	protected OssMailService ossMailService;

	@Resource(name="ossCorpService")
    private OssCorpService ossCorpService;

	@Resource(name="masRsvService")
	private MasRsvService masRsvService;

	@Resource(name="masRcPrdtService")
	private MasRcPrdtService masRcPrdtService;

	@Resource(name="scheduleDAO")
	private ScheduleDAO scheduleDAO;

	@Resource(name="apiAdService")
	private APIAdService apiAdService;

	@Resource(name="apiService")
	private APIService apiService;

	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;
	
	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;
	
	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name = "ossSmsEmailWordsService")
	protected OssSmsEmailWordsService ossSmsEmailWordsService;

	@Resource(name="apiInsService")
	private APIInsService apiInsService;

	@Resource(name="apiRibbonService")
	private APIRibbonService apiRibbonService;

	@Resource(name="ossPointService")
	private OssPointService ossPointService;

	@Autowired
	APIAligoService apiAligoService;

	/**
	 * 예약 테이블 등록
	 * 파일명 : insertRsv
	 * 작성일 : 2015. 11. 17. 오후 8:49:44
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	@Override
	public String insertRsv(RSVVO rsvVO){
		return webOrderDAO.insertRsv(rsvVO);
	}

	/**
	 * 렌터카 상품 예약 처리
	 * 파일명 : insertRcRsv
	 * 작성일 : 2015. 11. 18. 오전 9:57:47
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 * @throws IOException
	 */
	@Override
	public String insertRcRsv(RC_RSVVO rcRsvVO){
		String rcRsvNum = webOrderDAO.insertRcRsv(rcRsvVO);

		// 정상 예약건인 경우 사용 카운트 증가
		if(Constant.RSV_STATUS_CD_READY.equals(rcRsvVO.getRsvStatusCd())){
			webOrderDAO.updateRcBuyNumAdd(rcRsvVO);

			// 연계 처리
			/*apiService.insertRcRsv(rcRsvNum);*/
		}
		return rcRsvNum;
	}

	/**
	 * 렌터카 이용내역 처리
	 * 파일명 : insertRcHist
	 * 작성일 : 2015. 11. 18. 오전 10:36:48
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	@Override
	public void insertRcHist(RC_RSVVO rcRsvVO){
		webOrderDAO.insertRcHist(rcRsvVO);
	}

	/**
	 * 숙박 상품 예약 처리
	 * 파일명 : insertAdRsv
	 * 작성일 : 2015. 11. 18. 오후 1:31:52
	 * 작성자 : 최영철
	 * @param adRsvVO
	 */
	@Override
	public String insertAdRsv(AD_RSVVO adRsvVO){
		String adRsvNum = webOrderDAO.insertAdRsv(adRsvVO);
		/** 정상 예약건인 경우 사용 카운트 증가 */
		if(Constant.RSV_STATUS_CD_READY.equals(adRsvVO.getRsvStatusCd())){
			webOrderDAO.updateAdCntInfAdd(adRsvVO);
			webOrderDAO.updateAdBuyNumAdd(adRsvVO);
		}
		return adRsvNum;
	}

	/**
	 * 숙박 판매 수량 감소 처리
	 * 파일명 : updateAdCntInfMin
	 * 작성일 : 2015. 12. 17. 오후 1:23:35
	 * 작성자 : 최영철
	 * @param rsvDtlVO
	 */
	@Override
	public void updateAdCntInfMin(AD_RSVVO rsvDtlVO){
		webOrderDAO.updateAdCntInfMin(rsvDtlVO);
		webOrderDAO.updateAdBuyNumMin(rsvDtlVO);
	}

	/**
	 * 소셜 상품 예약 처리
	 * 파일명 : insertSpRsv
	 * 작성일 : 2015. 11. 18. 오후 5:21:30
	 * 작성자 : 최영철
	 * @param spRsvVO
	 */
	@Override
	public String insertSpRsv(SP_RSVVO spRsvVO){
		String spRsvNum = webOrderDAO.insertSpRsv(spRsvVO);
		/** 정상 예약건인 경우 사용 카운트 증가 */
		if(Constant.RSV_STATUS_CD_READY.equals(spRsvVO.getRsvStatusCd())){
			webOrderDAO.updateSpCntInfAdd(spRsvVO);
		}
		return spRsvNum;
	}

	/**
	 * 소셜상품 판매 수 감소 처리
	 * 파일명 : updateSpCntInfMin
	 * 작성일 : 2015. 12. 17. 오후 1:16:11
	 * 작성자 : 최영철
	 * @param spRsvVO
	 */
	@Override
	public void updateSpCntInfMin(SP_RSVVO spRsvVO){
		webOrderDAO.updateSpCntInfMin(spRsvVO);
	}

	/**
	 * 각 상품의 예약처리 후 금액 합계 처리
	 * 파일명 : updateTotalAmt
	 * 작성일 : 2015. 11. 18. 오후 5:44:23
	 * 작성자 : 최영철
	 * @param rsvVO
	 */
	@Override
	public void updateTotalAmt(RSVVO rsvVO){
		webOrderDAO.updateToTalAmt(rsvVO);
	}

	@Override
	public void updateRefundAcc(ORDERVO orderVO){
		webOrderDAO.updateRefundAcc(orderVO);
	}

	/**
	 * 예약건 리스트 조회
	 * 파일명 : selectOrderList
	 * 작성일 : 2015. 11. 18. 오후 6:38:07
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	@Override
	public List<ORDERVO> selectOrderList(RSVVO rsvVO){
		return webOrderDAO.selectOrderList(rsvVO);
	}

	@Override
	public List<ORDERVO> selectSmsMailList(RSVVO rsvVO){
		return webOrderDAO.selectSmsMailList(rsvVO);
	}

	/**
	 * 예약 마스터 조회
	 * 파일명 : selectByRsv
	 * 작성일 : 2015. 11. 19. 오전 11:11:40
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	@Override
	public RSVVO selectByRsv(RSVVO rsvVO){
		/** 탐나는전 번호 있을경우 */
		if(!EgovStringUtil.isEmpty(rsvVO.getTamnacardRefHashid())){
			return webOrderDAO.selectByRsv(rsvVO);
		/** 예약번호, userId 없을경우 */
		}else if(EgovStringUtil.isEmpty(rsvVO.getRsvNum()) && EgovStringUtil.isEmpty(rsvVO.getUserId())){
			return null;
		}else{
			return webOrderDAO.selectByRsv(rsvVO);
		}
	}

	/**
	 * 예약 목록조회
	 * 파일명 : selectRsvList
	 * 작성일 : 2015. 11. 20. 오전 11:10:53
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	@Override
	public List<RSVVO> selectRsvList(RSVVO rsvVO){
		List<RSVVO> rsvList = webOrderDAO.selectRsvList(rsvVO);
		return rsvList;
	}

	/**
	 * 사용자 예약내역 조회
	 * 파일명 : selectUserRsvList
	 * 작성일 : 2015. 12. 23. 오후 2:37:54
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	@Override
	public List<RSVVO> selectUserRsvList(RSVVO rsvVO){
		 return webOrderDAO.selectUserRsvList(rsvVO);
	}

	@Override
	public List<RSVVO> selectUserRsvListGuest(RSV_HISSVO rsvHisSVO){
		 return webOrderDAO.selectUserRsvListGuest(rsvHisSVO);
	}


	/**
	 * 사용자 쿠폰 조회
	 * 파일명 : selectUserCpList
	 * 작성일 : 2015. 11. 23. 오후 2:50:18
	 * 작성자 : 최영철
	 * @param userCpVO
	 * @return
	 */
	@Override
	public List<USER_CPVO> selectUserCpList(USER_CPVO userCpVO){
		return userCpDAO.selectUserCpList(userCpVO);
	}



	/**
	 * 상품평을 남길 수 있는 구매 목록 조회
	 * 파일명 : selectRsvEpilList
	 * 작성일 : 2015. 11. 25. 오전 10:59:28
	 * 작성자 : 신우섭
	 * @param reVO
	 * @return
	 */
	@Override
	public List<RSVEPILVO> selectRsvEpilList(RSVEPILVO reVO) {
		return webOrderDAO.selectRsvEpil(reVO);
	}


	/**
	 * 상품평 된거 남기기
	 * 파일명 : updateRsvEpil
	 * 작성일 : 2015. 11. 25. 오후 2:05:37
	 * 작성자 : 신우섭
	 * @param epVO
	 */
	@Override
	public void updateRsvEpil(RSVEPILVO epVO) {
		webOrderDAO.updateRsvEpil(epVO);

	}

	/**
	 * 쿠폰 예약 처리
	 * 파일명 : updateUseCp
	 * 작성일 : 2015. 12. 4. 오후 4:39:42
	 * 작성자 : 최영철
	 * @param useCp
	 */
	@Override
	public void updateUseCp(USER_CPVO useCp){
		userCpDAO.updateUseCp(useCp);
	}

	/**
	 * 예약시 사용한 쿠폰 리스트 조회
	 * 파일명 : selectUseCpList
	 * 작성일 : 2015. 12. 7. 오전 11:03:23
	 * 작성자 : 최영철
	 * @param
	 * @return
	 */
	@Override
	public USER_CPVO selectUseCpList(ORDERVO orderVO){
		return userCpDAO.selectUseCpList(orderVO);
	}

	@Override
	public LGPAYINFVO selectLGPAYINFO(String ID){
		LGPAYINFVO lgpayinfVO = new LGPAYINFVO();
		lgpayinfVO.setLGD_OID(ID);
		return webOrderDAO.selectLGPAYINFO(lgpayinfVO);

	}

	@Override
	public LGPAYINFVO selectLGPAYINFO_V(RSVVO rsvVO){
		return webOrderDAO.selectLGPAYINFO_V(rsvVO);
	}

	/**
	 * LG 결제완료 처리
	 * 파일명 : updateRsvComplete
	 * 작성일 : 2015. 12. 8. 오전 9:48:46
	 * 작성자 : 최영철
	 * @param
	 */
	@Override
	public void updateRsvComplete(LGPAYINFVO lGPAYINFO){

		if("R".equals(lGPAYINFO.getLGD_CASFLAGY())){
			lGPAYINFO.setLGD_RESPMSG("결제대기");
			lGPAYINFO.setLGD_RESPCODE("8888");
		}
		/** 1. LG 결제 정보 등록 */
		webOrderDAO.insertLGPAYINFO(lGPAYINFO);

		/** 2. 예약마스터 업데이트 */
		RSVVO rsvVO = new RSVVO();
		PAYVO payVO = new PAYVO();
		rsvVO.setRsvNum(lGPAYINFO.getLGD_OID());
		// Constant.RSV_STATUS_CD_COM : RS02(예약)
		rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_COM);
		log.info("결제 방법 : " + lGPAYINFO.getLGD_PAYTYPE());
		/** LG 카드결제(L100) */
		if("SC0010".equals(lGPAYINFO.getLGD_PAYTYPE())){
			rsvVO.setPayDiv(Constant.PAY_DIV_LG_CI);
			payVO.setPayDiv(Constant.PAY_DIV_LG_CI);
			if(lGPAYINFO.getLGD_EASYPAY_TRANTYPE().equals("KAKAOPAY")){
				rsvVO.setPayDiv(Constant.PAY_DIV_LG_KP);
				payVO.setPayDiv(Constant.PAY_DIV_LG_KP);
			}else if(lGPAYINFO.getLGD_EASYPAY_TRANTYPE().equals("APPLEPAY")){
				rsvVO.setPayDiv(Constant.PAY_DIV_LG_AP);
				payVO.setPayDiv(Constant.PAY_DIV_LG_AP);
			}else if(lGPAYINFO.getLGD_EASYPAY_TRANTYPE().equals("NAVERPAY")){
				rsvVO.setPayDiv(Constant.PAY_DIV_LG_NP);
				payVO.setPayDiv(Constant.PAY_DIV_LG_NP);
			}else if(lGPAYINFO.getLGD_EASYPAY_TRANTYPE().equals("TOSSPAY")){
				rsvVO.setPayDiv(Constant.PAY_DIV_LG_TP);
				payVO.setPayDiv(Constant.PAY_DIV_LG_TP);
			}
		}
		/** LG 휴대폰결제(L200) */
		else if("SC0060".equals(lGPAYINFO.getLGD_PAYTYPE())){
			rsvVO.setPayDiv(Constant.PAY_DIV_LG_HI);
			payVO.setPayDiv(Constant.PAY_DIV_LG_HI);
		}
		/** 계좌이체(L300) */
		else if("SC0030".equals(lGPAYINFO.getLGD_PAYTYPE()) && "N".equals(lGPAYINFO.getLGD_ESCROWYN())){
			rsvVO.setPayDiv(Constant.PAY_DIV_LG_TI);
			payVO.setPayDiv(Constant.PAY_DIV_LG_TI);
		}

		/** 에스크로 - 계좌이체(L310) */
		else if("SC0030".equals(lGPAYINFO.getLGD_PAYTYPE()) && "Y".equals(lGPAYINFO.getLGD_ESCROWYN())){
			rsvVO.setPayDiv(Constant.PAY_DIV_LG_ETI);
			payVO.setPayDiv(Constant.PAY_DIV_LG_ETI);
		}

		/** 계좌이체(L400) */
		else if("SC0040".equals(lGPAYINFO.getLGD_PAYTYPE())){
			rsvVO.setPayDiv(Constant.PAY_DIV_LG_MI);
			payVO.setPayDiv(Constant.PAY_DIV_LG_MI);
		}
		if(!"R".equals(lGPAYINFO.getLGD_CASFLAGY())) {
			webOrderDAO.updateRsvStatus(rsvVO);

			/** 3. 예약 불가건 삭제 */
			webOrderDAO.deleteNotRsv(rsvVO);

			/** 4. 각 예약건 상태 변경 */
			webOrderDAO.updateDtlRsvStatus(rsvVO);
		}

		/** 5. 결제 테이블 인서트 */
		payVO.setRsvNum(lGPAYINFO.getLGD_OID());
		payVO.setPayRstCd(lGPAYINFO.getLGD_RESPCODE());
		payVO.setPayRstInf(lGPAYINFO.getLGD_RESPMSG());
		payVO.setPayAmt(lGPAYINFO.getLGD_AMOUNT());
		payVO.setLGD_TID(lGPAYINFO.getLGD_TID());
		if("R".equals(lGPAYINFO.getLGD_CASFLAGY())){
			payVO.setPayRstInf("결제대기");
		}
		webOrderDAO.insertPay(payVO);
	}

	@Override
	public void updateRsvCompleteCyberAccount(LGPAYINFVO lGPAYINFO){

        /** 1. 무통장이 입금상태(I)도 아니고 취소상태(C)도 아니면*/
        lGPAYINFO.setLGD_RESPMSG("결제성공");
        webOrderDAO.updateLGPAYINFO(lGPAYINFO);
		/** 2. 예약마스터 업데이트 */
		RSVVO rsvVO = new RSVVO();
		PAYVO payVO = new PAYVO();
		rsvVO.setRsvNum(lGPAYINFO.getLGD_OID());
		/** Constant.RSV_STATUS_CD_COM : RS02(예약) */
		rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_COM);
		log.info("결제 방법 : " + lGPAYINFO.getLGD_PAYTYPE());
		rsvVO.setPayDiv(Constant.PAY_DIV_LG_MI);
		payVO.setPayDiv(Constant.PAY_DIV_LG_MI);
		webOrderDAO.updateRsvStatus(rsvVO);
		/** 3. 예약 불가건 삭제 */
		webOrderDAO.deleteNotRsv(rsvVO);
		/** 4. 각 예약건 상태 변경 */
		webOrderDAO.updateDtlRsvStatus(rsvVO);
		/** 5. 결제 테이블 인서트 */
		payVO.setRsvNum(lGPAYINFO.getLGD_OID());
		payVO.setPayRstCd(lGPAYINFO.getLGD_RESPCODE());
		payVO.setPayRstInf("결제성공");
		payVO.setPayAmt(lGPAYINFO.getLGD_AMOUNT());
		payVO.setLGD_TID(lGPAYINFO.getLGD_TID());
		payVO.setPayRstCd("0000");
		webOrderDAO.updatePay(payVO);
	}

	/**
	 * LG 결제정보 등록
	 * 파일명 : insertLDGINFO
	 * 작성일 : 2015. 12. 8. 오전 11:05:25
	 * 작성자 : 최영철
	 * @param lGPAYINFO
	 */
	@Override
	public void insertLDGINFO(LGPAYINFVO lGPAYINFO){
		/** LG 결제 정보 등록 */
		webOrderDAO.insertLGPAYINFO(lGPAYINFO);
	}

	/**
	 * 마이탐나오 예약내역조회
	 * 파일명 : selectOrderList2
	 * 작성일 : 2015. 12. 8. 오후 3:43:11
	 * 작성자 : 최영철
	 * 수성일 : 2025. 01. 7. 오후 4:12:20
	 * 수정자 : chaewan.jung
	 * @param rsvVO
	 * @return
	 */
	public List<ORDERVO> selectOrderList2(RSVVO rsvVO){
		return webOrderDAO.selectOrderList2(rsvVO);
	}
	public List<ORDERVO> selectOrderList2Guest(RSVVO rsvVO){
		return webOrderDAO.selectOrderList2Guest(rsvVO);
	}

	public List<ORDERVO> selectOrderList2(RSV_HISSVO rsvHisSVO){
		return webOrderDAO.selectOrderList2(rsvHisSVO);
	}
	public List<ORDERVO> selectOrderList2Guest(RSV_HISSVO rsvHisSVO){
		return webOrderDAO.selectOrderList2Guest(rsvHisSVO);
	}

	@Override
	public Integer selectOrderList2Cnt(RSV_HISSVO rsvHisSVO) {
		return webOrderDAO.selectOrderList2Cnt(rsvHisSVO);
	}

	@Override
	public Integer selectOrderList2GuestCnt(RSV_HISSVO rsvHisSVO) {
		return webOrderDAO.selectOrderList2GuestCnt(rsvHisSVO);
	}

	/**
	 * 각 예약건 상태 변경
	 * 파일명 : updateDtlRsvStatus
	 * 작성일 : 2015. 12. 9. 오후 5:28:25
	 * 작성자 : 최영철
	 * @param orderVO
	 */
	@Override
	public void updateDtlRsvStatus(ORDERVO orderVO){
		webOrderDAO.updateDtlRsvStatus2(orderVO);
	}

	/**
	 * 초기 결제 성공건 조회
	 * 파일명 : selectByPayInfo
	 * 작성일 : 2015. 12. 10. 오후 1:23:39
	 * 작성자 : 최영철
	 * @param payVO
	 * @return
	 */
	@Override
	public PAYVO selectByPayInfo(PAYVO payVO){
		return webOrderDAO.selectByPayInfo(payVO);
	}

	/**
	 * 렌터카 예약테이블 취소 처리
	 * 파일명 : updateRcCancelDtlRsv
	 * 작성일 : 2015. 12. 10. 오후 3:39:52
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	@Override
	public void updateRcCancelDtlRsv(RC_RSVVO rcRsvVO){
		webOrderDAO.updateRcCancelDtlRsv(rcRsvVO);
	}

	/**
	 * 예약취소시 사용자 쿠폰 반환처리
	 * 파일명 : cancelUserCp
	 * 작성일 : 2015. 12. 10. 오후 3:44:53
	 * 작성자 : 최영철
	 * @param
	 */
	@Override
	public void cancelUserCp(String prdtRsvNum){
		USER_CPVO cpVO = new USER_CPVO();
		cpVO.setUseRsvNum(prdtRsvNum);

		/** 연계쿠폰이 있으면 삭제 */
		ORDERVO orderVO = new ORDERVO();
		orderVO.setPrdtRsvNum(prdtRsvNum);
		/** 연계쿠폰 검색 */
		USER_CPVO resultCp = userCpDAO.selectUseCpList(orderVO);
		/** 연계쿠폰이 있으면 사용처리 된 쿠폰을 제외하고 삭제 */
		if(resultCp != null){
			userCpDAO.deleteUserCouponByRelatedCpId(resultCp);
		}

		/** 본 쿠폰은 미사용처리 */
		userCpDAO.cancelUserCp(cpVO);
	}

	/**
	 * 소셜상품 예약테이블 취소 처리
	 * 파일명 : updateSpCancelDtlRsv
	 * 작성일 : 2015. 12. 14. 오후 5:58:19
	 * 작성자 : 최영철
	 * @param spRsvVO
	 */
	@Override
	public void updateSpCancelDtlRsv(SP_RSVVO spRsvVO){
		webOrderDAO.updateSpCancelDtlRsv(spRsvVO);
	}

	/**
	 * 숙박 예약테이블 취소 처리
	 * 파일명 : updateAdCancelDtlRsv
	 * 작성일 : 2015. 12. 14. 오후 6:12:32
	 * 작성자 : 최영철
	 * @param adRsvVO
	 */
	@Override
	public void updateAdCancelDtlRsv(AD_RSVVO adRsvVO){
		webOrderDAO.updateAdCancelDtlRsv(adRsvVO);
	}

	/**
	 * 렌터카 이용내역 테이블 삭제
	 * 파일명 : deleteRcUseHist
	 * 작성일 : 2015. 12. 17. 오후 12:04:09
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	@Override
	public void deleteRcUseHist(RC_RSVVO rcRsvVO){
		webOrderDAO.deleteRcUseHist(rcRsvVO);
	}

	/**
	 * 환불 완료 처리
	 * 파일명 : refundComplete
	 * 작성일 : 2015. 12. 23. 오후 4:03:12
	 * 작성자 : 최영철
	 * @param orderVO
	 * @throws Exception
	 */
	@Override
	public void refundComplete(ORDERVO orderVO, HttpServletRequest request) throws Exception{
		/** 사용 쿠폰 취소 처리 */
		cancelUserCp(orderVO.getPrdtRsvNum());

		boolean refundYn = false;
		/** 소셜 상품 취소 처리 */
		if(Constant.SOCIAL.equals(orderVO.getPrdtRsvNum().substring(0,2).toUpperCase())){
			SP_RSVVO spRsvVO = new SP_RSVVO();
			spRsvVO.setRsvNum(orderVO.getRsvNum());
			spRsvVO.setSpRsvNum(orderVO.getPrdtRsvNum());
			SP_RSVVO rsvDtlVO = rsvDAO.selectSpDetailRsv(spRsvVO);

			if(Constant.RSV_STATUS_CD_SREQ.equals(rsvDtlVO.getRsvStatusCd())){
				refundYn = true;
			}

			/** 통합 예약건에 대한 처리 */
			RSVVO rsvVO = new RSVVO();
			rsvVO.setRsvNum(rsvDtlVO.getRsvNum());
			rsvVO.setTotalCancelAmt(rsvDtlVO.getCancelAmt());
			rsvVO.setTotalCmssAmt(rsvDtlVO.getCmssAmt());
			rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisCancelAmt());
			// 접속 IP
			String userIp = EgovClntInfo.getClntIP(request);

			rsvVO.setModIp(userIp);
			rsvDAO.updateCancelRsv(rsvVO);
		}
		// 숙박 상품 취소 처리
		else if(Constant.ACCOMMODATION.equals(orderVO.getPrdtRsvNum().substring(0,2).toUpperCase())){
			AD_RSVVO adRsvVO = new AD_RSVVO();
			adRsvVO.setRsvNum(orderVO.getRsvNum());
			adRsvVO.setAdRsvNum(orderVO.getPrdtRsvNum());
			AD_RSVVO rsvDtlVO = rsvDAO.selectAdDetailRsv(adRsvVO);

			// 통합 예약건에 대한 처리
			RSVVO rsvVO = new RSVVO();
			rsvVO.setRsvNum(rsvDtlVO.getRsvNum());
			rsvVO.setTotalCancelAmt(rsvDtlVO.getCancelAmt());
			rsvVO.setTotalCmssAmt(rsvDtlVO.getCmssAmt());
			rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisCancelAmt());
			// 접속 IP
			String userIp = EgovClntInfo.getClntIP(request);

			rsvVO.setModIp(userIp);
			rsvDAO.updateCancelRsv(rsvVO);

		}
		// 렌터카 상품 취소 처리
		else if(Constant.ACCOMMODATION.equals(orderVO.getPrdtRsvNum().substring(0,2).toUpperCase())){
			RC_RSVVO rcRsvVO = new RC_RSVVO();
			rcRsvVO.setRsvNum(orderVO.getRsvNum());
			rcRsvVO.setRcRsvNum(orderVO.getPrdtRsvNum());
			RC_RSVVO rsvDtlVO = rsvDAO.selectRcDetailRsv(rcRsvVO);

			// 통합 예약건에 대한 처리
			RSVVO rsvVO = new RSVVO();
			rsvVO.setRsvNum(rsvDtlVO.getRsvNum());
			rsvVO.setTotalCancelAmt(rsvDtlVO.getCancelAmt());
			rsvVO.setTotalCmssAmt(rsvDtlVO.getCmssAmt());
			rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisCancelAmt());
			// 접속 IP
			String userIp = EgovClntInfo.getClntIP(request);

			rsvVO.setModIp(userIp);
			rsvDAO.updateCancelRsv(rsvVO);

			// 예약내역 삭제
			webOrderDAO.deleteRcUseHist(rsvDtlVO);

			// 연계중인 예약에 대해 처리
			if(Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn())){

			}
		}
		RSVVO rsvVO = new RSVVO();
		rsvVO.setPrdtRsvNum(orderVO.getPrdtRsvNum());
		if(!refundYn){
			// RSV_STATUS_CD_CCOM(RS20 : 취소)
			rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);
			// 판매 통계 감소 처리
		}else{
			// RSV_STATUS_CD_SCOM(RS32 : 부분환불완료)
			rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_SCOM);
		}

		// 각 예약건에 예약 코드 변경
		webOrderDAO.updateDtlRsvStatus(rsvVO);
	}
	

	@Override
	public void orderCompleteSnedSMSMail(RSVVO rsvVO,
										 HttpServletRequest request) {

		// 예약기본정보
		RSVVO rsvInfo = selectByRsv(rsvVO);

		//예약 상품 리스트
		List<ORDERVO> orderList = selectSmsMailList(rsvVO);

		//메일보내기(사용자)
		ossMailService.sendOrderComplete(rsvInfo, orderList, request);

		//메일보내기(업체)
		ossMailService.sendOrderCompleteCorp(rsvInfo, orderList, request);

		DecimalFormat df = new DecimalFormat("#,##0");

		for (ORDERVO ordervo : orderList) {

			log.info(">>>>>>>1>[revNum:"+ordervo.getRsvNum()
					+ "][prdtCd:"+ordervo.getPrdtCd()
					+ "][corpId:"+ordervo.getCorpId()
					+ "][prdtNum:"+ordervo.getPrdtNum()
					+ "][prdtRsvNum:"+ordervo.getPrdtRsvNum()
					+ "][email:"+rsvInfo.getRsvEmail()
					+ "][tel:"+rsvInfo.getRsvTelnum());

			log.info(">>>>>>>1>[UserSmsYn:" + rsvInfo.getUserSmsYn() + "][tel:" + rsvInfo.getUseTelnum());

			ArrayList<String> msgList = new ArrayList<String>(); //알림톡내용
			ArrayList<String> msgCoprList = new ArrayList<String>(); //업체발송내용

			String strSubject = "";
			String strMsg = "";

			String strPrdtCD = ordervo.getPrdtNum().substring(0, 2).toUpperCase();

			CORPVO corpVO = new CORPVO();
			corpVO.setCorpId(ordervo.getCorpId());
			CORPVO corpRes = corpDAO.selectCorpByCorpId(corpVO);

			String url = request.getScheme() + "://" + request.getServerName();

			//사용자 알림톡 보내기
			APIAligoVO aligoVO = new APIAligoVO();
			boolean isSendQr = false; //QR버튼 생성

			if(Constant.SOCIAL.equals(strPrdtCD)) {//소셜 상품일때
				SP_PRDTINFVO spPrdtVO = new SP_PRDTINFVO();
				spPrdtVO.setPrdtNum(ordervo.getPrdtNum());

				SP_PRDTINFVO spPrdtRes = spDAO.selectBySpPrdtInf(spPrdtVO);
				log.info(">>>>>>>2>[PrdtDiv:" + spPrdtRes.getPrdtDiv());

				if(Constant.SP_PRDT_DIV_TOUR.equals(spPrdtRes.getPrdtDiv())) {

					aligoVO.setTplCode("TU_3501"); //알림톡 템플릿코드 설정 (예약완료_예약상품(야간버스포함))

					strMsg = "[탐나오] [" + ordervo.getPrdtNm() + "] 구매가 완료됐습니다.\n\n";
					strMsg += "[구매내역]\n";
					strMsg += ordervo.getPrdtInf() + "\n";
					strMsg += "- 판매처 : " + ordervo.getCorpNm() + " (" + corpRes.getRsvTelNum() + ")\n";

					// 시티투어 야간코스
					if("SP00002387".equals(ordervo.getPrdtNum())) {
						strMsg += "\n예약번호 : " + ordervo.getRsvNum() + "\n";
					} else {
						strMsg += "\n본 상품은 해당 판매업체와 전화통화 후 예약이 확정됩니다.\n";
					}

					msgList.add(strMsg);

					String msgCorp = "[탐나오] [" + ordervo.getCorpNm() + "] " + rsvInfo.getRsvNm() + "님(" + rsvInfo.getRsvTelnum() + ") [" + ordervo.getPrdtNm() + "] 예약이 접수됐습니다.\n";
					msgCorp += "\n[구매내역] " + ordervo.getPrdtNm() + "\n";
					msgCorp += "\n상세한 내용은 관리자 페이지를 참조바랍니다.\n";
					msgCorp += url + "/mas\n";

					msgCoprList.add(msgCorp);

				} else if(Constant.SP_PRDT_DIV_COUP.equals(spPrdtRes.getPrdtDiv())) {

					isSendQr = true;
					aligoVO.setTplCode("TU_3523"); //알림톡 템플릿코드 설정 (예약완료_쿠폰상품)

					//관광지 입장권
					SP_RSVVO spRsvVO = new SP_RSVVO();
					spRsvVO.setRsvNum(ordervo.getRsvNum());
					spRsvVO.setCorpId(ordervo.getCorpId());
					spRsvVO.setSpDivSn(ordervo.getSpDivSn());

					List<SP_RSVVO> spRsvList;

					spRsvList = rsvDAO.selectSpRsvList3(spRsvVO);
					//각옵션별 정보 넣을때.
					for (SP_RSVVO spRsvRes : spRsvList) {
						log.info(">>>>>>>3>[" + spRsvRes.getExprStartDt() + "~" + spRsvRes.getExprEndDt());

						String strStY="", strStM="'", strStD="";
						String strEnY="", strEnM="'", strEnD="";

						if(!(spRsvRes.getExprStartDt()==null
								|| spRsvRes.getExprStartDt().isEmpty()
								|| spRsvRes.getExprStartDt().length() < 8)){
							strStY = spRsvRes.getExprStartDt().substring(0,4);
							strStM = spRsvRes.getExprStartDt().substring(4,6);
							strStD = spRsvRes.getExprStartDt().substring(6,8);
						}

						if(!(spRsvRes.getExprEndDt()==null
								|| spRsvRes.getExprEndDt().isEmpty()
								|| spRsvRes.getExprEndDt().length() < 8)){
							strEnY = spRsvRes.getExprEndDt().substring(0,4);
							strEnM = spRsvRes.getExprEndDt().substring(4,6);
							strEnD = spRsvRes.getExprEndDt().substring(6,8);
						}

						strMsg = "[탐나오] [" + ordervo.getPrdtNm() + "] 구매가 완료됐습니다.\n\n";
						strMsg += "[고객정보]\n";
						strMsg += ordervo.getUseNm() + "/" + ordervo.getUseTelnum();
						strMsg += "\n\n[구매내역]\n";
						strMsg += "- 탐나오예약번호 : "+rsvInfo.getRsvNum() + "\n";
						strMsg += "- 구매내역 : " + spRsvRes.getPrdtInf() + "\n";
						strMsg += "- 유효기간 : " + strStY + "." + strStM + "." + strStD + " ~ " + strEnY + "." + strEnM + "." + strEnD + "\n";
						strMsg += "- 판매처 : "+ ordervo.getCorpNm() +" ("+ corpRes.getRsvTelNum() +")\n";

						if(ordervo.getPrdtNum().equals("SP00001022") || ordervo.getPrdtNum().equals("SP00001071")){
							aligoVO.setTplCode("TU_3524"); //알림톡 템플릿코드 설정 (예약완료_쿠폰상품_시티투어)
							//아래 내용은 변수로 설정해서 변경해도 알림톡 발송 됨.
							strMsg += "- 탑승 장소 : 22개 모든 장소 (상품 상세페이지 참조)\n";
							strMsg += "* 제주 국제공항(1층 도착 2번 게이트 앞 3번 버스정류장)\n";
							strMsg += "* 24년 7월 26일부터 해안코스와 도심코스가 통합 운행됩니다.\n";
							strMsg += "\n이용방법:\n제주시티투어 버스에 탑승하신 후, 받으신 문자메시지 또는 QR코드를 제시하시면 됩니다.\n";
						}else{
							strMsg += "- 주소 : " + corpRes.getRoadNmAddr() + " " + corpRes.getDtlAddr() +"\n";
							strMsg += "관광지 방문하셔서 제주관광협회(탐나오 모바일) 쿠폰이라고 말씀하시고, QR코드를 제시하거나, 휴대폰 뒷 4자리와 성명만 알려주시면 입장 OK!\n";
						}
						
						//----------마라톤 분기----------//
						String mrtCorpId = spRsvRes.getCorpId();
						if(mrtCorpId != null) {
							if("CSPM".equals(mrtCorpId.substring(0, 4))) {
								isSendQr = false;
								aligoVO.setTplCode("TU_4376"); //알림톡 템플릿코드 설정 (마라톤)
							}
						}

						String msgCorp = "[탐나오] [" + ordervo.getCorpNm() + "] " + rsvInfo.getRsvNm() + "님(" + rsvInfo.getRsvTelnum() + ") [" + ordervo.getPrdtNm() + "]["+ spRsvRes.getPrdtInf() + "] 예약이 접수됐습니다.\n";
						msgCorp += "\n상세한 내용은 관리자 페이지를 참조바랍니다.\n";
						msgCorp += url + "/mas\n";

						/** 야놀자/LS컴퍼니/브이패스 상품일 경우 업체에만 문자보냄  */
						if(("J".equals(spPrdtRes.getLsLinkYn()) && spPrdtRes.getLsLinkPrdtNum() != null) || ("Y".equals(spPrdtRes.getLsLinkYn()) && spPrdtRes.getLsLinkPrdtNum() != null) || ("V".equals(spPrdtRes.getLsLinkYn()) && spPrdtRes.getLsLinkPrdtNum() != null)){
							msgCoprList.add(msgCorp);
						}else{
							msgList.add(strMsg);
							msgCoprList.add(msgCorp);
						}
					}
				}
			}else{

				String numbering = "";

				if(!ordervo.getCorpMaxCount().equals("1")){
					numbering = ordervo.getRnCorp();
				};
				if(Constant.SV.equals(strPrdtCD)) {
					strMsg = "[탐나오] 아래 내용으로 구매가 완료됐습니다.";
					strMsg += "\n[구매내역"+numbering+"]\n";
					aligoVO.setTplCode("TU_3702"); //알림톡 템플릿코드 설정(예약완료_특산/기념품)

				}else if (Constant.RENTCAR.equals(strPrdtCD)){
					strMsg = "[탐나오] 아래 내용으로 예약내역을 알려드립니다.";
					strMsg += "\n[예약내역"+numbering+"]\n";
					aligoVO.setTplCode("TU_3476"); //알림톡 템플릿코드 설정(예약완료_렌트카)

				}else{
					strMsg = "[탐나오] 아래 내용으로 예약이 완료됐습니다.";
					strMsg += "\n[예약내역"+numbering+"]\n";
				}
				strMsg += "- 업체정보: "+ordervo.getCorpNm()+" ("+corpRes.getRsvTelNum()+")\n" +
					"- 구매내역: "+ordervo.getPrdtNm()+" ("+ordervo.getPrdtInf()+")\n" +
					"- 결제금액: "+df.format(Integer.parseInt(ordervo.getSaleAmt()))+"원\n";

				if (Constant.RENTCAR.equals(strPrdtCD)) {
					// 예약 렌터카 상품 정보
					RC_PRDTINFVO prdtInfVO = new RC_PRDTINFVO();
					prdtInfVO.setPrdtNum(ordervo.getPrdtNum());

					RC_PRDTINFVO rcPrdt = masRcPrdtService.selectByPrdt(prdtInfVO);

					String insGuide ="";
					if ("ID20".equals(rcPrdt.getIsrDiv())) {	// 자차보험 필수 이면..
						insGuide += "\n[자차보험] 본 상품은 인수 현장에서 자차보험료 추가 결제 필수 상품입니다.\n";
					} else if ("ID10".equals(rcPrdt.getIsrDiv())) {	// 자차보험 포함이면..
						insGuide += "\n[자차보험]본 상품은 자차보험료 포함 상품입니다. 자차보험 관련 문의는 판매처로 확인바랍니다.\n";
					} else {  // 자차보험 자율 이면..
						insGuide += "\n[자차보험] 렌트카 상품은 자차 보험이 제외된 예약비용이며, 인수 현장에서 선택 및 결제 가능합니다.\n";
					}
					strMsg = strMsg + insGuide + "\n실시간 예약현황에 따라, 차량이용이 불가할 경우 별도 연락을 드리고 있습니다.\n";
					
					/* 현대캐피탈 one-card */
					@SuppressWarnings("unchecked")
					List<CARTVO> hcOneCardYnList = (List<CARTVO>) request.getSession().getAttribute("hcOneCardYnList");
					if (hcOneCardYnList != null) {
						for(CARTVO sessionVO : hcOneCardYnList) {
							if(ordervo.getPrdtNum().equals(sessionVO.getPrdtNum())) {
								if(sessionVO.getHcOneCardYn().equals("Y")) {

									strMsg += "\n상세내역은 마이탐나오를 참조 바랍니다.\n";

									String hcOneCardUrlType = "A";
									strMsg += "\n★ 채비 버튼을 눌러 회원가입 후 현대캐피탈 EV 충전카드 혜택을 이용해보세요!";
									strMsg += "\n※ 유의사항";
									strMsg += "\n-반드시 채비 버튼을 통해 회원가입해야만 카드 발급이 가능합니다.";
									strMsg += "\n-채비앱으로 회원가입 시 혜택이 적용되지 않으니 주의하세요.\n\n";
									
									RSVVO hcOneCardvo = new RSVVO();
									hcOneCardvo.setRsvNum(ordervo.getRsvNum());
									hcOneCardvo.setPrdtNum(ordervo.getPrdtNum());
									hcOneCardvo.setPrdtRsvNum(ordervo.getPrdtRsvNum());
									hcOneCardvo.setUserId(rsvInfo.getUserId());
									hcOneCardvo.setRsvEmail(rsvInfo.getRsvEmail());
									hcOneCardvo.setRsvTelnum(rsvInfo.getRsvTelnum());
									hcOneCardvo.setUrlType(hcOneCardUrlType);
									rsvDAO.insertHcOneCard(hcOneCardvo)	;

									aligoVO.setTplCode("TU_4253"); //알림톡 템플릿코드 설정(예약완료_렌트카_현대캐피탈ONECARD)
								}
							}
						}
					}
				// 숙박이면 주소 추가
				} else if (Constant.ACCOMMODATION.equals(strPrdtCD)) {
					strMsg += "- 주소 : "+ ordervo.getRoadNmAddr() +"\n";
					aligoVO.setTplCode("TU_3340"); //알림톡 템플릿코드 설정 (예약완료_숙박)
				}
				msgList.add(strMsg);

				String msgCorp = "[탐나오] [" + ordervo.getCorpNm() + "] " + rsvInfo.getRsvNm() + "님(" + rsvInfo.getRsvTelnum() + ") 예약이 접수됐습니다.\n";

				msgCorp += "\n[구매내역"+ numbering + "] " + ordervo.getPrdtNm() + "(" + ordervo.getPrdtInf() + ")\n";
				msgCorp += "\n상세한 내용은 관리자 페이지를 참조바랍니다.\n";
				msgCorp += url + "/mas\n";
				msgCoprList.add(msgCorp);
			}

			//대체문자
			String strMsgSMS = "";

			//공통 문구 추가
			String comMsg = "";
			if (!"TU_4253".equals(aligoVO.getTplCode())) {
				comMsg += "\n상세내역은 마이탐나오를 참조 바랍니다.\n\n";
			}
			comMsg += "★ 탐나오 구매 고객 대상으로 제주관광공사 온·오프라인 면세점 할인 쿠폰을 제공해 드려요!\n\n";

			/** 알림톡 전송*/
			String tmpSubject = Constant.RENTCAR.equals(strPrdtCD) ? ordervo.getPrdtNm() : ordervo.getCorpNm();
			strSubject = "[탐나오] [" + EmojiParser.removeAllEmojis(tmpSubject) + "] 결제 완료";

			for (int i = 0; i < msgList.size(); i++){
				String strMsgS = msgList.get(i);

				//공통 문구 추가
				strMsgS += comMsg;

				//대체문자 set
				strMsgSMS = strMsgS;

				aligoVO.setReceivers(new String[]{rsvInfo.getRsvTelnum()});
				aligoVO.setRecvNames(new String[]{""});
				aligoVO.setSubject(strSubject);
				aligoVO.setMsg(strMsgS);
				aligoVO.setFailover("Y"); //대체문자발송여부

				List<APIAligoButtonVO> buttonList = new ArrayList<>();

				if(isSendQr) {
					APIAligoButtonVO buttonQr = new APIAligoButtonVO();
					buttonQr.setName("QR코드 및 구매내역");
					buttonQr.setLinkType("WL");
					buttonQr.setLinkTypeName("웹링크");
					buttonQr.setLinkMo("https://www.tamnao.com/mw/qr.do?rsvNum="+rsvInfo.getRsvNum()+"&telNum="+StringUtils.substringAfterLast(rsvInfo.getRsvTelnum(), "-")+"&SCID=tamnao");
					buttonQr.setLinkPc("https://www.tamnao.com/mw/qr.do?rsvNum="+rsvInfo.getRsvNum()+"&telNum="+StringUtils.substringAfterLast(rsvInfo.getRsvTelnum(), "-")+"&SCID=tamnao");
					buttonList.add(buttonQr);

					//대체문자 QR코드 set
					strMsgSMS += "▼QR코드 및 구매내역 보기\n";
					strMsgSMS += "https://www.tamnao.com/mw/qr.do?rsvNum=" + rsvInfo.getRsvNum() + "&telNum="+ StringUtils.substringAfterLast(rsvInfo.getRsvTelnum(), "-") + "&SCID=tamnao\n\n";

				}

				//현대캐피탈 ONE CARD - 채비버튼
				if ("TU_4253".equals(aligoVO.getTplCode())){
					APIAligoButtonVO buttonChaevi = new APIAligoButtonVO();
					buttonChaevi.setName("채비");
					buttonChaevi.setLinkType("WL");
					buttonChaevi.setLinkTypeName("웹링크");
					buttonChaevi.setLinkMo("https://chaevi.com/kr/associate/hyundaiCapital.php");
					buttonChaevi.setLinkPc("https://chaevi.com/kr/associate/hyundaiCapital.php");
					buttonList.add(buttonChaevi);

					//대체문자 채비 set
					strMsgSMS += "▼채비 바로가기\n";
					strMsgSMS += "https://chaevi.com/kr/associate/hyundaiCapital.php\n\n";
				}

				APIAligoButtonVO button1 = new APIAligoButtonVO();
				button1.setName("마이탐나오");
				button1.setLinkType("WL");
				button1.setLinkTypeName("웹링크");
				button1.setLinkMo("https://www.tamnao.com/mw/mypage/mainList.do");
				button1.setLinkPc("https://www.tamnao.com/web/mypage/rsvList.do");
				buttonList.add(button1);

				APIAligoButtonVO button2 = new APIAligoButtonVO();
				button2.setName("제주면세점할인쿠폰");
				button2.setLinkType("WL");
				button2.setLinkTypeName("웹링크");
				button2.setLinkMo("https://bit.ly/제주면세점_할인쿠폰");
				button2.setLinkPc("https://bit.ly/제주면세점_할인쿠폰");
				buttonList.add(button2);

				//대체문자 공통 문구 set
				strMsgSMS += "▼마이탐나오 바로가기\n";
				strMsgSMS += "https://www.tamnao.com/mw/mypage/mainList.do\n\n";
				strMsgSMS += "▼제주면세점할인쿠폰 받기\n";
				strMsgSMS += "https://bit.ly/제주면세점_할인쿠폰";

				try {
					aligoVO.setMsgSMS(URLEncoder.encode(strMsgSMS,"UTF-8"));
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}

				//예약자 알림톡 전송
				aligoVO.setButtons(buttonList.toArray(new APIAligoButtonVO[0]));
				apiAligoService.aligoKakaoSend(aligoVO);

				//사용자 알림톡 전송
				if("Y".equals(rsvInfo.getUserSmsYn()) && !rsvInfo.getRsvTelnum().equals(rsvInfo.getUseTelnum())){
					aligoVO.setReceivers(new String[]{rsvInfo.getUseTelnum()});
					aligoVO.setButtons(buttonList.toArray(new APIAligoButtonVO[0]));
					apiAligoService.aligoKakaoSend(aligoVO);
				}
			}

			MMSVO mmsVO = new MMSVO();

			String rsvNm = "";
			for (int i = 0; i < msgCoprList.size(); i++){
				String strCorpMsgS = msgCoprList.get(i);
				
				rsvNm = rsvInfo.getRsvNm();
				if(rsvNm != null) {
					rsvNm = EmojiParser.removeAllEmojis(rsvNm);
				}
				
				//업체
				CORPVO corpVO1 = new CORPVO();
				corpVO1.setCorpId(ordervo.getCorpId());

				CORPVO corpRes1 = ossCorpService.selectByCorp(corpVO1);

				String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");

				mmsVO.setSubject("[탐나오] " + rsvNm + "님 예약 접수");
				if(strCorpMsgS != null) {
					strCorpMsgS = EmojiParser.removeAllEmojis(strCorpMsgS); 
				}
				mmsVO.setMsg(strCorpMsgS);
				mmsVO.setStatus("0");
				mmsVO.setFileCnt("0");
				mmsVO.setType("0");
				/*담당자 MMS발송 - 테스트빌드시 결제 메시지 김재성*/
				if("test".equals(CST_PLATFORM.trim())) {
					mmsVO.setPhone(Constant.TAMNAO_TESTER1);
				}else{
					mmsVO.setPhone(corpRes1.getAdmMobile());
				}
				mmsVO.setCallback(EgovProperties.getProperty("CS.PHONE"));

				try {
					smsService.sendMMS(mmsVO);
				} catch (Exception e) {
					log.info("MMS Error");
				}
				
				/* 담당자2 MMS 발송 */
				if(StringUtils.isNotEmpty(corpRes1.getAdmMobile2())) {
					/*테스트빌드시 */
					if("test".equals(CST_PLATFORM.trim())) {
						mmsVO.setPhone(Constant.TAMNAO_TESTER2);
					}else{
						mmsVO.setPhone(corpRes1.getAdmMobile2());
					}
					try {
						smsService.sendMMS(mmsVO);
					} catch (Exception e) {
						log.info("MMS Error");
					}
				}

				/* 담당자3 MMS 발송 */
				if(StringUtils.isNotEmpty(corpRes1.getAdmMobile3())) {
					/*테스트빌드시 */
					if("test".equals(CST_PLATFORM.trim())) {
						mmsVO.setPhone(Constant.TAMNAO_TESTER3);
					}else{
						mmsVO.setPhone(corpRes1.getAdmMobile3());
					}
					try {
						smsService.sendMMS(mmsVO);
					} catch (Exception e) {
						log.info("MMS Error");
					}
				}
			}
		}
	}

	@Override
	public void orderCompleteSnedSMSMailResend(RSVVO rsvVO,
										 HttpServletRequest request) {

		// 예약기본정보
		RSVVO rsvInfo = selectByRsv(rsvVO);

		//예약 상품 리스트
		List<ORDERVO> orderList = selectSmsMailList(rsvVO);

		//메일보내기(사용자)
		/*ossMailService.sendOrderComplete(rsvInfo, orderList, request);*/

		//메일보내기(업체)
		/*ossMailService.sendOrderCompleteCorp(rsvInfo, orderList, request);*/

		DecimalFormat df = new DecimalFormat("#,##0");

		//문자 보내기
		for (ORDERVO ordervo : orderList) {

			log.info(">>>>>>>1>[revNum:"+ordervo.getRsvNum()
					+ "][prdtCd:"+ordervo.getPrdtCd()
					+ "][corpId:"+ordervo.getCorpId()
					+ "][prdtNum:"+ordervo.getPrdtNum()
					+ "][prdtRsvNum:"+ordervo.getPrdtRsvNum()
					+ "][email:"+rsvInfo.getRsvEmail()
					+ "][tel:"+rsvInfo.getRsvTelnum());

			log.info(">>>>>>>1>[UserSmsYn:" + rsvInfo.getUserSmsYn() + "][tel:" + rsvInfo.getUseTelnum());

			ArrayList<String> msgList = new ArrayList<String>();
			ArrayList<String> msgCoprList = new ArrayList<String>();
			ArrayList<String> subjectList = new ArrayList<String>();

			String strSubject;
			String strMsg;

			String strPrdtCD = ordervo.getPrdtNum().substring(0, 2).toUpperCase();

			CORPVO corpVO = new CORPVO();
			corpVO.setCorpId(ordervo.getCorpId());
			CORPVO corpRes = corpDAO.selectCorpByCorpId(corpVO);

			String url = "https://www.tamnao.com";
			String urlMypage = url + "/mw/mypage/mainList.do";

			if(Constant.SOCIAL.equals(strPrdtCD)) {//소셜 상품일때
				SP_PRDTINFVO spPrdtVO = new SP_PRDTINFVO();
				spPrdtVO.setPrdtNum(ordervo.getPrdtNum());

				SP_PRDTINFVO spPrdtRes = spDAO.selectBySpPrdtInf(spPrdtVO);
				log.info(">>>>>>>2>[PrdtDiv:" + spPrdtRes.getPrdtDiv());

				if(Constant.SP_PRDT_DIV_TOUR.equals(spPrdtRes.getPrdtDiv())) {
					//패키지
					strSubject = "[탐나오] [" + ordervo.getPrdtNm() + "] 예약 완료";
					subjectList.add(strSubject);

					strMsg = "[탐나오] [" + ordervo.getPrdtNm() + "] 구매가 완료됐습니다.\n";
					strMsg += "\n[구매내역]\n";
					strMsg += ordervo.getPrdtInf() + "\n";
					strMsg += "- 판매처 : " + ordervo.getCorpNm() + " " + corpRes.getRsvTelNum() + "\n";

					// 시티투어 야간코스
					if("SP00001770".equals(ordervo.getPrdtNum())) {
						strMsg += "\n예약번호 : " + ordervo.getRsvNum() + "\n";
					} else {
						strMsg += "\n본 상품은 해당 판매업체와 전화통화 후 예약이 확정됩니다.\n";
					}
					strMsg += "\n상세내역은 마이탐나오를 참조 바랍니다.\n";
					strMsg += urlMypage + "\n";

					msgList.add(strMsg);

					String msgCorp = "[탐나오] [" + ordervo.getCorpNm() + "] " + rsvInfo.getRsvNm() + "님(" + rsvInfo.getRsvTelnum() + ") [" + ordervo.getPrdtNm() + "] 예약이 접수됐습니다.\n";
					msgCorp += "\n[구매내역] " + ordervo.getPrdtNm() + "\n";
					msgCorp += "\n상세한 내용은 관리자 페이지를 참조바랍니다.\n";
					msgCorp += url + "/mas\n";

					msgCoprList.add(msgCorp);

				} else if(Constant.SP_PRDT_DIV_COUP.equals(spPrdtRes.getPrdtDiv())) {
					//관광지 입장권
					SP_RSVVO spRsvVO = new SP_RSVVO();
					spRsvVO.setRsvNum(ordervo.getRsvNum());
					spRsvVO.setCorpId(ordervo.getCorpId());
					spRsvVO.setSpDivSn(ordervo.getSpDivSn());

					List<SP_RSVVO> spRsvList;

					spRsvList = rsvDAO.selectSpRsvList3(spRsvVO);
					//각옵션별 정보 넣을때.
					for (SP_RSVVO spRsvRes : spRsvList) {
						log.info(">>>>>>>3>[" + spRsvRes.getExprStartDt() + "~" + spRsvRes.getExprEndDt());

						String strStY="", strStM="'", strStD="";
						String strEnY="", strEnM="'", strEnD="";

						if(!(spRsvRes.getExprStartDt()==null
								|| spRsvRes.getExprStartDt().isEmpty()
								|| spRsvRes.getExprStartDt().length() < 8)){
							strStY = spRsvRes.getExprStartDt().substring(0,4);
							strStM = spRsvRes.getExprStartDt().substring(4,6);
							strStD = spRsvRes.getExprStartDt().substring(6,8);
						}

						if(!(spRsvRes.getExprEndDt()==null
								|| spRsvRes.getExprEndDt().isEmpty()
								|| spRsvRes.getExprEndDt().length() < 8)){
							strEnY = spRsvRes.getExprEndDt().substring(0,4);
							strEnM = spRsvRes.getExprEndDt().substring(4,6);
							strEnD = spRsvRes.getExprEndDt().substring(6,8);
						}

						strSubject = "[탐나오] [" + ordervo.getPrdtNm() + "] 구매 완료";

						subjectList.add(strSubject);

						strMsg = "[탐나오] [" + ordervo.getPrdtNm() + "] 구매가 완료됐습니다.\n";
						strMsg += "[고객정보]\n";
						strMsg += ordervo.getUseNm() + "/" + ordervo.getUseTelnum();
						strMsg += "\n[구매내역]\n";
						strMsg += "- " + spRsvRes.getPrdtInf() + "\n";
						strMsg += "- 유효기간 : " + strStY + "." + strStM + "." + strStD + "~" + strEnY + "." + strEnM + "." + strEnD + "\n";
						strMsg += "- 판매처 : " + ordervo.getCorpNm() + " " + corpRes.getRsvTelNum() + "\n";

						if(ordervo.getPrdtNum().equals("SP00001022") || ordervo.getPrdtNum().equals("SP00001071")){
							strMsg += "- 탑승 장소 : 22개 모든 장소 (상품 상세페이지 참조)\n";
							strMsg += "* 제주 국제공항(도착 2번-3번 게이트 사이 3번 정류장\n";
						}else{
							strMsg += "- 주소 : " + corpRes.getRoadNmAddr() + " " + corpRes.getDtlAddr() +"\n";
						}
						strMsg += "\n이용방법:\n";

						if(ordervo.getPrdtNum().equals("SP00001022") || ordervo.getPrdtNum().equals("SP00001071")){
							strMsg += "제주시티투어 버스에 탑승하신 후, 받으신 문자메시지 또는 QR코드를 제시하시면 됩니다.\n";
						}else{
							strMsg += "관광지 방문하셔서 제주관광협회(탐나오 모바일) 쿠폰이라고 말씀하시고, QR코드를 제시하거나, 휴대폰 뒷 4자리와 성명만 알려주시면 입장 OK!\n";
						}

						String urlRsv = url + "/mw/qr.do?rsvNum=" + rsvInfo.getRsvNum() + "&telNum="+ StringUtils.substringAfterLast(rsvInfo.getRsvTelnum(), "-") + "&SCID=tamnao";

						strMsg += "\nQR코드 및 구매 내역 확인 : \n";
						strMsg += urlRsv + "\n";

						strMsg += "\n상세내역은 마이탐나오를 참조 바랍니다.\n";
						strMsg += urlMypage + "\n";

						String msgCorp = "[탐나오] [" + ordervo.getCorpNm() + "] " + rsvInfo.getRsvNm() + "님(" + rsvInfo.getRsvTelnum() + ") [" + ordervo.getPrdtNm() + "]["+ spRsvRes.getPrdtInf() + "] 예약이 접수됐습니다.\n";
						msgCorp += "\n상세한 내용은 관리자 페이지를 참조바랍니다.\n";
						msgCorp += url + "/mas\n";
						/** LS컴퍼니/하이제주/브이패스 상품일 경우 업체에만 문자보냄  */
						if(("H".equals(spPrdtRes.getLsLinkYn()) && spPrdtRes.getLsLinkPrdtNum() != null) || ("Y".equals(spPrdtRes.getLsLinkYn()) && spPrdtRes.getLsLinkPrdtNum() != null) || ("V".equals(spPrdtRes.getLsLinkYn()) && spPrdtRes.getLsLinkPrdtNum() != null)){
							msgCoprList.add(msgCorp);
						}else{
							msgList.add(strMsg);
							msgCoprList.add(msgCorp);
						}
					}
				}
			}else{
				String tmpSubject = Constant.RENTCAR.equals(strPrdtCD) ? ordervo.getPrdtNm() : ordervo.getCorpNm();
				strSubject = "[탐나오] [" + tmpSubject + "] 결제 완료";

				subjectList.add(strSubject);

				String numbering = "";

				if(!ordervo.getCorpMaxCount().equals("1")){
					numbering = ordervo.getRnCorp();
				};
				if(Constant.SV.equals(strPrdtCD)) {
					strMsg = "[탐나오] 아래 내용으로 구매가 완료됐습니다.\n";
					strMsg += "\n[구매내역"+numbering+"]\n";
				}else if (Constant.RENTCAR.equals(strPrdtCD)){
					strMsg = "[탐나오] 아래 내용으로 예약내역을 알려드립니다.\n";
					strMsg += "\n[예약내역"+numbering+"]\n";
				}else{
					strMsg = "[탐나오] 아래 내용으로 예약이 완료됐습니다.\n";
					strMsg += "\n[예약내역"+numbering+"]\n";
				}
				strMsg += "[" + ordervo.getCorpNm() + "(" + corpRes.getRsvTelNum() + ")" + " " + ordervo.getPrdtNm() + "(" + ordervo.getPrdtInf() + ")] [" + df.format(Integer.parseInt(ordervo.getSaleAmt())) + "원]\n";

				if (Constant.RENTCAR.equals(strPrdtCD)) {
					// 예약 렌터카 상품 정보
					RC_PRDTINFVO prdtInfVO = new RC_PRDTINFVO();
					prdtInfVO.setPrdtNum(ordervo.getPrdtNum());

					RC_PRDTINFVO rcPrdt = masRcPrdtService.selectByPrdt(prdtInfVO);

					if ("ID20".equals(rcPrdt.getIsrDiv())) {	// 자차보험 필수 이면..
						strMsg += "\n[자차보험] 본 상품은 인수 현장에서 자차보험료 추가 결제 필수 상품입니다.\n";
					} else if ("ID10".equals(rcPrdt.getIsrDiv())) {	// 자차보험 포함이면..
						strMsg += "\n[자차보험]본 상품은 자차보험료 포함 상품입니다. 자차보험 관련 문의는 판매처로 확인바랍니다.\n";
					} else {  // 자차보험 자율 이면..
						strMsg += "\n[자차보험] 렌트카 상품은 자차 보험이 제외된 예약비용이며, 인수 현장에서 선택 및 결제 가능합니다.\n";
					}
					strMsg += "\n실시간 예약현황에 따라, 차량이용이 불가할 경우 별도 연락을 드리고 있습니다.\n";
				} else if (Constant.ACCOMMODATION.equals(strPrdtCD)) {
					// 숙박이면 주소 추가
					strMsg += "\n[주소] " + ordervo.getRoadNmAddr() + "\n";
				}
				strMsg += "\n상세내역은 마이탐나오를 참조 바랍니다.\n";
				strMsg += urlMypage + "\n";

				msgList.add(strMsg);

				String msgCorp = "[탐나오] [" + ordervo.getCorpNm() + "] " + rsvInfo.getRsvNm() + "님(" + rsvInfo.getRsvTelnum() + ") 예약이 접수됐습니다.\n";

				msgCorp += "\n[구매내역"+ numbering + "] " + ordervo.getPrdtNm() + "(" + ordervo.getPrdtInf() + ")\n";
				msgCorp += "\n상세한 내용은 관리자 페이지를 참조바랍니다.\n";
				msgCorp += url + "/mas\n";

				msgCoprList.add(msgCorp);
			}

			MMSVO mmsVO = new MMSVO();

			// 이벤트 문구 가져오기
			Calendar calNow = Calendar.getInstance();
			String today = EgovStringUtil.getDateFormat(calNow);

			SMSEMAILWORDSVO smsEmailWordsVO = new SMSEMAILWORDSVO();
			smsEmailWordsVO.setWordsDiv("SMS");
			smsEmailWordsVO.setWordsSubject("이벤트");
			smsEmailWordsVO.setAplStartDt(today);
			smsEmailWordsVO.setAplEndDt(today);
			smsEmailWordsVO.setFirstIndex(0);

			Map<String, Object> resultMap = ossSmsEmailWordsService.selectWordsList(smsEmailWordsVO);

			List<SMSEMAILWORDSVO> wordsList = (List<SMSEMAILWORDSVO>) resultMap.get("resultList");

			String eventWords = "";
			for(SMSEMAILWORDSVO words : wordsList) {
				eventWords += "\n";
				eventWords += words.getWordsContents();
				eventWords += "\n";
			}

			for (int i = 0; i < msgList.size(); i++){
				String strMsgS = msgList.get(i);
				// 이벤트 문구 추가
				strMsgS += eventWords;

				String strSubjectS = subjectList.get(i);

				//예약자
				mmsVO.setSubject(strSubjectS);
				mmsVO.setMsg(strMsgS);
				mmsVO.setStatus("0");
				mmsVO.setFileCnt("0");
				mmsVO.setType("0");
				mmsVO.setPhone(rsvInfo.getRsvTelnum());
				mmsVO.setCallback(EgovProperties.getProperty("CS.PHONE"));

				try {
					smsService.sendMMS(mmsVO);
				} catch (Exception e) {
					log.info("MMS Error");
				}

				if("Y".equals(rsvInfo.getUserSmsYn())){
					//사용자
					mmsVO.setPhone(rsvInfo.getUseTelnum());
					try {
						smsService.sendMMS(mmsVO);
					} catch (Exception e) {
						log.info("MMS Error");
					}
				}

				/** 메시지 재발송용 */
				mmsVO.setRsvNum(ordervo.getRsvNum());
				mmsVO.setPrdtRsvNum(ordervo.getPrdtRsvNum());
				mmsVO.setPhone1(rsvInfo.getRsvTelnum());
				mmsVO.setPhone2(rsvInfo.getUseTelnum());

				/*webOrderDAO.insertMMSmsg(mmsVO);*/
			}

			for (int i = 0; i < msgCoprList.size(); i++){
				String strCorpMsgS = msgCoprList.get(i);

				//업체
				CORPVO corpVO1 = new CORPVO();
				corpVO1.setCorpId(ordervo.getCorpId());

				CORPVO corpRes1 = ossCorpService.selectByCorp(corpVO1);

				String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");

				mmsVO.setSubject("[탐나오] " + rsvInfo.getRsvNm() + "님 예약 접수");
				mmsVO.setMsg(strCorpMsgS);
				mmsVO.setStatus("0");
				mmsVO.setFileCnt("0");
				mmsVO.setType("0");
				/*담당자 MMS발송 - 테스트빌드시 결제 메시지 김재성*/
				if("test".equals(CST_PLATFORM.trim())) {
					mmsVO.setPhone(Constant.TAMNAO_TESTER1);
				}else{
					mmsVO.setPhone(corpRes1.getAdmMobile());
				}
				mmsVO.setCallback(EgovProperties.getProperty("CS.PHONE"));

				try {
					smsService.sendMMS(mmsVO);
				} catch (Exception e) {
					log.info("MMS Error");
				}

				/* 담당자2 MMS 발송 */
				if(StringUtils.isNotEmpty(corpRes1.getAdmMobile2())) {
					/*테스트빌드시 */
					if("test".equals(CST_PLATFORM.trim())) {
						mmsVO.setPhone(Constant.TAMNAO_TESTER2);
					}else{
						mmsVO.setPhone(corpRes1.getAdmMobile2());
					}
					try {
						smsService.sendMMS(mmsVO);
					} catch (Exception e) {
						log.info("MMS Error");
					}
				}

				/* 담당자3 MMS 발송 */
				if(StringUtils.isNotEmpty(corpRes1.getAdmMobile3())) {
					/*테스트빌드시 */
					if("test".equals(CST_PLATFORM.trim())) {
						mmsVO.setPhone(Constant.TAMNAO_TESTER3);
					}else{
						mmsVO.setPhone(corpRes1.getAdmMobile3());
					}
					try {
						smsService.sendMMS(mmsVO);
					} catch (Exception e) {
						log.info("MMS Error");
					}
				}
			}
		}
	}
	
	/**
	 * 예약건의 예약상태 변경
	 * Function : chgRsvStatus
	 * 작성일 : 2018. 2. 2. 오후 2:29:58
	 * 작성자 : 정동수
	 * @param rsvVO
	 */
	@Override
	public void chgRsvStatus(RSVVO rsvVO) {
		// 각 예약건에 예약 코드 변경
		webOrderDAO.updateDtlRsvStatus(rsvVO);
	}

	/**
	 * 카카오페이 결제 완료 처리
	 * 파일명 : updateRsvComplete2
	 * 작성일 : 2016. 1. 4. 오후 2:34:51
	 * 작성자 : 최영철
	 * @param kakaoPayInfVO
	 */
	@Override
	public void updateRsvComplete2(KAKAOPAYINFVO kakaoPayInfVO){
		// 1. 카카오 결제 정보 등록
		webOrderDAO.insertKAKAOPAYINF(kakaoPayInfVO);
		// 2. 예약마스터 업데이트
		RSVVO rsvVO = new RSVVO();
		PAYVO payVO = new PAYVO();

		rsvVO.setRsvNum(kakaoPayInfVO.getRsvNum());
		// Constant.RSV_STATUS_CD_COM : RS02(예약)
		rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_COM);
		// 카카오페이 결제(L400)
		rsvVO.setPayDiv(Constant.PAY_DIV_LG_KI);
		payVO.setPayDiv(Constant.PAY_DIV_LG_KI);
		webOrderDAO.updateRsvStatus(rsvVO);

		// 3. 예약 불가건 삭제
		webOrderDAO.deleteNotRsv(rsvVO);

		// 4. 각 예약건 상태 변경
		webOrderDAO.updateDtlRsvStatus(rsvVO);

		// 5. 결제 테이블 인서트
		payVO.setRsvNum(kakaoPayInfVO.getRsvNum());
		payVO.setPayRstCd("0000");
		payVO.setPayRstInf(kakaoPayInfVO.getResultMsg());
		payVO.setPayAmt(kakaoPayInfVO.getAmt());
		payVO.setLGD_TID(kakaoPayInfVO.getTid());

		webOrderDAO.insertPay(payVO);

	}
	
	/**
	 * 무료쿠폰 & L.Point 전체 결제 완료 처리
	 * Function : updateRsvComplete3
	 * 작성일 : 2017. 10. 23. 오전 11:40:26
	 * 작성자 : 정동수
	 * @param
	 */
	@Override
	public void updateRsvComplete3(RSVVO rsvVO){

		// RsvStatusCd = RS02(예약)
		rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_COM);

		// 1. 결제 완료 예약상태 변경
		webOrderDAO.updateRsvStatus(rsvVO);

		// 2. 예약 불가건 삭제
		webOrderDAO.deleteNotRsv(rsvVO);

		// 3. 각 예약건 상태 변경
		webOrderDAO.updateDtlRsvStatus(rsvVO);

		// 4. 파트너 포인트로 전체 결제시 사용처리
		if(rsvVO.getPayDiv().equals(Constant.PAY_DIV_TA_PI)){
			POINTVO pointVO = new POINTVO();
			pointVO.setPlusMinus("M");
			pointVO.setTypes("USE");
			pointVO.setRsvNum(rsvVO.getRsvNum());
			pointVO.setUserId(rsvVO.getUserId());
			pointVO.setPartnerCode(rsvVO.getPartnerCode());
			pointVO.setTotalSaleAmt(Integer.parseInt(rsvVO.getTotalSaleAmt()));
			pointVO.setContents("ALL_POINT"); //ALL_POINT 일경우 포인트 전체 결제로 봄
			ossPointService.pointCpUse(pointVO);
		}
	}

	/** 탐나는전 업데이트 완료 */
	@Override
	public void updateRsvComplete4(RSVVO rsvVO){
		/** 예약 코드(RS02) set*/
		rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_COM);
		/** 전체예약 테이블 update */
		webOrderDAO.updateRsvStatus(rsvVO);
		/** 상세예약 테이블 update */
		webOrderDAO.updateDtlRsvStatus(rsvVO);
	}

	@Override
	public void reqCancelSnedSMS(String prdtRsvNum) {
		log.info(">>>>reqCancelSnedSMS 호출:"+prdtRsvNum);

		// 예약 상품 정보
		ORDERVO orderVO = new ORDERVO();
		orderVO.setPrdtRsvNum(prdtRsvNum);
		ORDERVO orderRes = webOrderDAO.selectUserRsvFromPrdtRsvNum(orderVO);
		if(orderRes == null){
			log.info("Not prdtRsvNum");
			return;
		}

		// 예약기본정보
		RSVVO rsvVO = new RSVVO();
		rsvVO.setRsvNum(orderRes.getRsvNum());
		RSVVO rsvInfo = selectByRsv(rsvVO);
		if(rsvInfo == null){
			log.info("Not rsvNum");
			return;
		}

		log.info(">>>>>>>1>[revNum:"+orderRes.getRsvNum()
				+ "][prdtRsvNum:"+orderRes.getPrdtRsvNum()
				+ "][corpId:"+orderRes.getCorpId()
				+ "][prdtNum:"+orderRes.getPrdtNum()
				+ "][prdtNm:"+orderRes.getPrdtNm()
				+ "][email:"+rsvInfo.getRsvEmail()
				+ "][tel:"+rsvInfo.getRsvTelnum()	);

		String prdtNm = orderRes.getCorpNm() + "-" + orderRes.getPrdtNm();
		String prdtDtlUrl = orderRes.getPrdtNum().substring(0, 2).toLowerCase() + "/detailPrdt.do?prdtNum=" + orderRes.getPrdtNum() + "&sPrdtNum=" + orderRes.getPrdtNum();
		if (Constant.SOCIAL.equals(orderRes.getPrdtNum().substring(0, 2))) {
			WEB_DTLPRDTVO prdtVO = new WEB_DTLPRDTVO();
			prdtVO.setPrdtNum(orderRes.getPrdtNum());
			prdtVO.setPreviewYn("Y");
			WEB_DTLPRDTVO prdtInfo =  webSpService.selectByPrdt(prdtVO);
			prdtDtlUrl += "&prdtDiv=" + prdtInfo.getPrdtDiv();
		} else if (Constant.RENTCAR.equals(orderRes.getPrdtNum().substring(0, 2))) {

			prdtDtlUrl ="rentcar/car-detail.do?prdtNum="+orderRes.getPrdtNum();

			RC_PRDTINFVO prdtVO = new RC_PRDTINFVO();
			prdtVO.setPrdtNum(orderRes.getPrdtNum());
			prdtVO = webRcProductService.selectByPrdt(prdtVO);
			
			if ("ID00".equals(prdtVO.getIsrDiv())) {
				prdtNm += "/자차자율";
			} else if ("ID10".equals(prdtVO.getIsrDiv())) {
				prdtNm += "/자차포함";
				if (Constant.RC_ISR_TYPE_GEN.equals(prdtVO.getIsrTypeDiv())) {
					prdtNm += "-일반자차";
				} else if (Constant.RC_ISR_TYPE_LUX.equals(prdtVO.getIsrTypeDiv())) {
					prdtNm += "-고급자차";
				}
			} else if ("ID20".equals(prdtVO.getIsrDiv())) {
				prdtNm += "/자차필수";
			}
		}

		//사용자 알림톡 보내기
		APIAligoVO aligoVO = new APIAligoVO();
		aligoVO.setTplCode("TU_1943");
		aligoVO.setReceivers(new String[]{rsvInfo.getRsvTelnum()});
		aligoVO.setRecvNames(new String[]{""});
		aligoVO.setSubject("예약상품취소접수완료");

		aligoVO.setMsg("[탐나오] ["+prdtNm+"]의 취소 요청이 정상적으로 접수됐습니다.\n\n" +
			"취소 수수료가 발생될 수 있으니 취소/환불 규정은 ["+orderRes.getCorpNm()+"] 상세페이지에서 꼭 확인해주세요.");

		aligoVO.setFailover("Y"); //대체문자발송여부

		List<APIAligoButtonVO> buttonList = new ArrayList<>();
		APIAligoButtonVO button1 = new APIAligoButtonVO();

		button1.setName("상세페이지");
		button1.setLinkType("WL");
		button1.setLinkTypeName("웹링크");
		button1.setLinkMo("https://www.tamnao.com/mw/"+prdtDtlUrl);
		button1.setLinkPc("https://www.tamnao.com/web/"+prdtDtlUrl);
		buttonList.add(button1);

		// APIAligoVO에 버튼 그룹 설정
		aligoVO.setButtons(buttonList.toArray(new APIAligoButtonVO[0]));

		apiAligoService.aligoKakaoSend(aligoVO);

		//업체
		MMSVO mmsVO = new MMSVO();
		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(orderRes.getCorpId());
		CORPVO corpRes = ossCorpService.selectByCorp(corpVO);
		if(corpRes == null){
			log.info("Not corpId");
			return;
		}
		log.info(">>>>[corp:"+ corpRes.getCorpId()+ "][" + corpRes.getAdmEmail()+ "][" + corpRes.getAdmMobile() +"]");
		String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");

		mmsVO.setSubject("[탐나오] "+rsvInfo.getRsvNm()+"님 취소요청");
		mmsVO.setMsg("[탐나오] "
						+rsvInfo.getRsvNm()+"님("+rsvInfo.getRsvTelnum()+")"
						+" ["+prdtNm+"]이 취소요청이 접수됐습니다. \n"
						+"24시간내 처리바라며, 상세한 내용은 관리자페이지를 참조바랍니다.\n"
						+ "www.tamnao.com/mas"
					);
		mmsVO.setStatus("0");
		mmsVO.setFileCnt("0");
		mmsVO.setType("0");
		/*테스트빌드시 취소 메시지 김재성*/
		if("test".equals(CST_PLATFORM.trim())) {
			mmsVO.setPhone(Constant.TAMNAO_TESTER1);
		}else{
			mmsVO.setPhone(corpRes.getAdmMobile());
		}
		mmsVO.setCallback(EgovProperties.getProperty("CS.PHONE"));
		try {
			smsService.sendMMS(mmsVO);
		} catch (Exception e) {
			log.info("MMS Error");
		}

		/* 담당자2 MMS 발송 */
		if(StringUtils.isNotEmpty(corpRes.getAdmMobile2())) {
			/*테스트빌드시*/
			if("test".equals(CST_PLATFORM.trim())) {
				mmsVO.setPhone(Constant.TAMNAO_TESTER2);
			}else{
				mmsVO.setPhone(corpRes.getAdmMobile2());
			}
			
			try {
				smsService.sendMMS(mmsVO);
			} catch (Exception e) {
				log.info("MMS Error");
			}
		}

		/* 담당자3 MMS 발송 */
		if(StringUtils.isNotEmpty(corpRes.getAdmMobile3())) {
			/*테스트빌드시*/
			if("test".equals(CST_PLATFORM.trim())) {
				mmsVO.setPhone(Constant.TAMNAO_TESTER3);
			}else{
				mmsVO.setPhone(corpRes.getAdmMobile3());
			}

			try {
				smsService.sendMMS(mmsVO);
			} catch (Exception e) {
				log.info("MMS Error");
			}
		}
	}


	@Override
	public void reqCancelSnedSMSAll(String rsvNum) {
		log.info(">>>>reqCancelSnedSMSAll 호출:"+rsvNum);

		ORDERVO orderVO = new ORDERVO();
		orderVO.setRsvNum(rsvNum);
		orderVO.setRsvStatusCd("RS10");
		List<ORDERVO> orderList =  webOrderDAO.selectUserRsvListFromRsvNum(orderVO);

		for (ORDERVO order : orderList) {
			log.info(">>>>reqCancelSnedSMSAll 호출:prdtRsvNum:"+order.getPrdtRsvNum());

			reqCancelSnedSMS( order.getPrdtRsvNum() );
		}
	}


	@Override
	public void cancelRsvAutoSnedSMSEmail(String prdtRsvNum,
											HttpServletRequest request) {
		log.info(">>>>cancelRsvAutoSnedSMSEmail 호출:"+prdtRsvNum);

		// 예약 상품 정보
		ORDERVO orderVO = new ORDERVO();
		orderVO.setPrdtRsvNum(prdtRsvNum);
		ORDERVO orderRes = webOrderDAO.selectUserRsvFromPrdtRsvNum(orderVO);
		if(orderRes == null){
			log.info("Not prdtRsvNum");
			return;
		}

		// 예약기본정보
		RSVVO rsvVO = new RSVVO();
		rsvVO.setRsvNum(orderRes.getRsvNum());
		RSVVO rsvInfo = selectByRsv(rsvVO);
		if(rsvInfo == null){
			log.info("Not rsvNum");
			return;
		}

		log.info(">>>>>>>1>[revNum:"+orderRes.getRsvNum()
				+ "][prdtRsvNum:"+orderRes.getPrdtRsvNum()
				+ "][corpId:"+orderRes.getCorpId()
				+ "][prdtNum:"+orderRes.getPrdtNum()
				+ "][prdtNm:"+orderRes.getPrdtNm()
				+ "][email:"+rsvInfo.getRsvEmail()
				+ "][tel:"+rsvInfo.getRsvTelnum()	);

		//메일보내기
		ossMailService.sendCancelRsvAuto(rsvInfo, orderRes, request);
		
		String prdtNm = orderRes.getCorpNm() + "-" + orderRes.getPrdtNm();
		String prdtDtlUrl = orderRes.getPrdtNum().substring(0, 2).toLowerCase() + "/detailPrdt.do?prdtNum=" + orderRes.getPrdtNum() + "&sPrdtNum=" + orderRes.getPrdtNum();
		if (Constant.SOCIAL.equals(orderRes.getPrdtNum().substring(0, 2))) {
			WEB_DTLPRDTVO prdtVO = new WEB_DTLPRDTVO();
			prdtVO.setPrdtNum(orderRes.getPrdtNum());
			prdtVO.setPreviewYn("Y");
			WEB_DTLPRDTVO prdtInfo =  webSpService.selectByPrdt(prdtVO);
			prdtDtlUrl += "&prdtDiv=" + prdtInfo.getPrdtDiv();
		} else if (Constant.RENTCAR.equals(orderRes.getPrdtNum().substring(0, 2))) {
			RC_PRDTINFVO prdtVO = new RC_PRDTINFVO();
			prdtVO.setPrdtNum(orderRes.getPrdtNum());
			prdtVO = webRcProductService.selectByPrdt(prdtVO);
			
			if ("ID00".equals(prdtVO.getIsrDiv())) {
				prdtNm += "/자차자율";
			} else if ("ID10".equals(prdtVO.getIsrDiv())) {
				prdtNm += "/자차포함";
				if (Constant.RC_ISR_TYPE_GEN.equals(prdtVO.getIsrTypeDiv())) {
					prdtNm += "-일반자차";
				} else if (Constant.RC_ISR_TYPE_LUX.equals(prdtVO.getIsrTypeDiv())) {
					prdtNm += "-고급자차";
				}
			} else if ("ID20".equals(prdtVO.getIsrDiv())) {
				prdtNm += "/자차필수";
			}
		}

		//사용자 알림톡 보내기
		APIAligoVO aligoVO = new APIAligoVO();
		aligoVO.setTplCode("TU_2978");
		aligoVO.setReceivers(new String[]{rsvInfo.getRsvTelnum()});
		aligoVO.setRecvNames(new String[]{""});
		aligoVO.setSubject("예약상품취소완료");

		aligoVO.setMsg("[탐나오] ["+prdtNm+"]의 결제취소가 정상적으로 처리가 됐습니다.\n\n" +
			"상세내역은 마이탐나오를 참조 바랍니다.\n\n" +
			"취소수수료가 발생될 수 있으니 취소/환불 규정은 상세페이지에서 꼭 확인해주세요.");

		aligoVO.setFailover("Y"); //대체문자발송여부

		List<APIAligoButtonVO> buttonList = new ArrayList<>();

		APIAligoButtonVO button1 = new APIAligoButtonVO();
		button1.setName("마이탐나오");
		button1.setLinkType("WL");
		button1.setLinkTypeName("웹링크");
		button1.setLinkMo("https://www.tamnao.com/mw/mypage/mainList.do");
		button1.setLinkPc("https://www.tamnao.com/web/mypage/rsvList.do");
		buttonList.add(button1);

		APIAligoButtonVO button2 = new APIAligoButtonVO();
		button2.setName("상세페이지");
		button2.setLinkType("WL");
		button2.setLinkTypeName("웹링크");
		button2.setLinkMo("https://www.tamnao.com/mw/"+prdtDtlUrl);
		button2.setLinkPc("https://www.tamnao.com/web/"+prdtDtlUrl);
		buttonList.add(button2);

		// APIAligoVO에 버튼 그룹 설정
		aligoVO.setButtons(buttonList.toArray(new APIAligoButtonVO[0]));

		apiAligoService.aligoKakaoSend(aligoVO);
	}


	/**
	 * 환불완료시 문자/메일 전송
	 * 파일명 : refundCompleteSnedSMSEmail
	 * 작성일 : 2016. 1. 5. 오후 6:07:32
	 * 작성자 : 신우섭
	 * @param prdtRsvNum
	 * @param request
	 */
	@Override
	public void refundCompleteSnedSMSEmail(String prdtRsvNum,
			HttpServletRequest request) {
		log.info(">>>>refundCompleteSnedSMSEmail 호출:"+prdtRsvNum);

		// 예약 상품 정보
		ORDERVO orderVO = new ORDERVO();
		orderVO.setPrdtRsvNum(prdtRsvNum);
		ORDERVO orderRes = webOrderDAO.selectUserRsvFromPrdtRsvNum(orderVO);
		if(orderRes == null){
			log.info("Not prdtRsvNum");
			return;
		}

		// 예약기본정보
		RSVVO rsvVO = new RSVVO();
		rsvVO.setRsvNum(orderRes.getRsvNum());
		RSVVO rsvInfo = selectByRsv(rsvVO);
		if(rsvInfo == null){
			log.info("Not rsvNum");
			return;
		}

		log.info(">>>>>>>1>[revNum:"+orderRes.getRsvNum()
				+ "][prdtRsvNum:"+orderRes.getPrdtRsvNum()
				+ "][corpId:"+orderRes.getCorpId()
				+ "][prdtNum:"+orderRes.getPrdtNum()
				+ "][prdtNm:"+orderRes.getPrdtNm()
				+ "][email:"+rsvInfo.getRsvEmail()
				+ "][tel:"+rsvInfo.getRsvTelnum()	);

		//메일보내기
		ossMailService.sendRefundComplete(rsvInfo, orderRes, request);


		//문자 - 사용자
		MMSVO mmsVO = new MMSVO();
		mmsVO.setSubject("[탐나오] ["+orderRes.getPrdtNm()+"] 환불 완료");
		mmsVO.setMsg("[탐나오] ["+orderRes.getPrdtNm()+"]환불이 완료됐습니다.\n 상세내역은 마이탐나오를 참조바랍니다.\n www.tamnao.com/mw/mypage/mainList.do");
		mmsVO.setStatus("0");
		mmsVO.setFileCnt("0");
		mmsVO.setType("0");
		mmsVO.setPhone(rsvInfo.getRsvTelnum());
		mmsVO.setCallback(EgovProperties.getProperty("CS.PHONE"));
		try {
			smsService.sendMMS(mmsVO);
		} catch (Exception e) {
			log.info("MMS Error");
		}



	}


	/**
	 * 카카오페이 결제정보 등록
	 * 파일명 : insertKakaoPayInf
	 * 작성일 : 2016. 1. 4. 오후 2:47:50
	 * 작성자 : 최영철
	 * @param kakaoPayInfVO
	 */
	@Override
	public void insertKakaoPayInf(KAKAOPAYINFVO kakaoPayInfVO){
		// 1. 카카오 결제 정보 등록
		webOrderDAO.insertKAKAOPAYINF(kakaoPayInfVO);
	}

	@Override
	public ORDERVO selectUserRsvFromPrdtRsvNum(ORDERVO orderVO) {
		return (ORDERVO) webOrderDAO.selectUserRsvFromPrdtRsvNum(orderVO);
	}

	/**
	 * 판매통계 MERGE
	 * 파일명 : mergeSaleAnls
	 * 작성일 : 2016. 1. 18. 오전 9:59:59
	 * 작성자 : 최영철
	 * @param prdtNum
	 */
	@Override
	public void mergeSaleAnls(String prdtNum){
		webOrderDAO.mergeSaleAnls(prdtNum);
	}

	/**
	 * 판매통계 감소 처리
	 * 파일명 : downSaleAnls
	 * 작성일 : 2016. 1. 18. 오전 10:24:31
	 * 작성자 : 최영철
	 * @param prdtNum
	 */
	@Override
	public void downSaleAnls(String prdtNum){
		webOrderDAO.downSaleAnls(prdtNum);
	}

	/**
	 * 판매통계 취소 처리 - 상세예약번호 별
	 * 파일명 : downSaleAnlsByDtlRsv
	 * 작성일 : 2016. 11. 8. 오후 12:09:00
	 * 작성자 : 최영철
	 * @param dtlRsvNum
	 */
	@Override
	public void downSaleAnlsByDtlRsv(String dtlRsvNum){
		webOrderDAO.downSaleAnlsByDtlRsv(dtlRsvNum);
	}

	/**
	 * 관광기념품 예약 처리
	 */
	@Override
	public String insertSvRsv(SV_RSVVO svRsvVO) {
		String svRsvNum = webOrderDAO.insertSvRsv(svRsvVO);
		// 정상 예약건인 경우 사용 카운트 증가
		if(Constant.RSV_STATUS_CD_READY.equals(svRsvVO.getRsvStatusCd())){
			webOrderDAO.updateSvCntInfAdd(svRsvVO);
		}
		return svRsvNum;
	}

	/**
	 * 배송지 변경
	 */
	@Override
	public void changeDlv(RSVVO rsvVO) {
		webOrderDAO.updateDlv(rsvVO);
	}

	@Override
	public RSVVO orderRecentDlv(RSVVO rsvVO) {
		return webOrderDAO.orderRecentDlv(rsvVO);
	}

	@Override
	public void confirmOrder(String svRsvNum) {
		webOrderDAO.confirmOrder(svRsvNum);
	}

	/**
	 * 관광기념품 예약테이블 취소 처리
	 * 파일명 : updateSvCancelDtlRsv
	 * 작성일 : 2016. 10. 14. 오후 3:30:39
	 * 작성자 : 최영철
	 * @param svRsvVO
	 */
	@Override
	public void updateSvCancelDtlRsv(SV_RSVVO svRsvVO){
		webOrderDAO.updateSvCancelDtlRsv(svRsvVO);
	}

	/**
	 * 관광기념품 판매 수량 제어
	 * 파일명 : updateSvCntInfMin
	 * 작성일 : 2016. 10. 14. 오후 3:34:45
	 * 작성자 : 최영철
	 * @param rsvDtlVO
	 */
	@Override
	public void updateSvCntInfMin(SV_RSVVO rsvDtlVO){
		webOrderDAO.updateSvCntInfMin(rsvDtlVO);
	}

	@Override
	public void dlvNumSnedSMSEmail(String prdtRsvNum, HttpServletRequest request) {
	log.info(">>>>dlvNumSnedSMSEmail 호출:"+prdtRsvNum);

		// 예약 상품 정보
		ORDERVO orderVO = new ORDERVO();
		orderVO.setPrdtRsvNum(prdtRsvNum);
		ORDERVO orderRes = webOrderDAO.selectUserRsvFromPrdtRsvNum(orderVO);
		if(orderRes == null){
			log.info("Not prdtRsvNum");
			return;
		}

		// 제주 특산품 구매 상세
		SV_RSVVO rsvInfo = new SV_RSVVO();
		rsvInfo.setSvRsvNum(prdtRsvNum);
		rsvInfo = masRsvService.selectSvDetailRsv(rsvInfo);

		//메일보내기
		ossMailService.sendDeliveryComplete(rsvInfo, orderRes, request);

		/**알림톡 - 사용자 발송*/
		APIAligoVO aligoVO = new APIAligoVO();
		aligoVO.setTplCode("TU_0500");
		aligoVO.setSubject("[탐나오] ["+orderRes.getPrdtNm()+"] 상품 발송 완료");

		//알림톡 메세지
		String message = "[탐나오] ["+orderRes.getPrdtNm()+"] 상품이 발송 완료됐습니다.";
		if (rsvInfo.getDlvCorpNm() != null) {
			aligoVO.setTplCode("TU_0597");
			message += "\n택배사정보: "+rsvInfo.getDlvCorpNm()+" / "+rsvInfo.getDlvNum();
		}
		aligoVO.setMsg(message);

		//대체문자 메세지
		String messageSMS = message + "\n상세내역은 마이탐나오를 참조바랍니다.\n";
		messageSMS += "www.tamnao.com/mw/mypage/mainList.do";
		aligoVO.setMsgSMS(messageSMS);

		String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
		if("test".equals(CST_PLATFORM.trim())) {
			String[] receivers = {Constant.TAMNAO_TESTER1};
			String[] recvNames = {Constant.TAMNAO_TESTER_NAME1};
			aligoVO.setReceivers(receivers);
			aligoVO.setRecvNames(recvNames);
		}else{
			aligoVO.setReceivers(new String[]{rsvInfo.getRsvTelnum()});
			aligoVO.setRecvNames(new String[]{""});
		}

		aligoVO.setFailover("Y"); //대체문자발송여부

		//알림톡 버튼 설정
		List<APIAligoButtonVO> buttonList = new ArrayList<>();
		APIAligoButtonVO button1 = new APIAligoButtonVO();
		button1.setName("마이탐나오");
		button1.setLinkType("WL");
		button1.setLinkTypeName("웹링크");
		button1.setLinkMo("https://www.tamnao.com/mw/mypage/mainList.do");
		button1.setLinkPc("https://www.tamnao.com/web/mypage/rsvList.do");
		buttonList.add(button1);

		aligoVO.setButtons(buttonList.toArray(new APIAligoButtonVO[0]));

		apiAligoService.aligoKakaoSend(aligoVO);
	}

	@Override
	public void updateSvRsvDlvAmt(SV_RSVVO svRsvVO) {
		webOrderDAO.updateSvRsvDlvAmt(svRsvVO);
	}

	@Override
	public void updateSvRsvDlvPoint(SV_RSVVO svRsvVO) {
		webOrderDAO.updateSvRsvDlvPoint(svRsvVO);
	}

	/**
	 * 숙박 자동취소 처리
	 * 파일명 : updateAdAcc
	 * 작성일 : 2016. 11. 8. 오후 1:47:51
	 * 작성자 : 최영철
	 * @param adRsvVO
	 */
	@Override
	public void updateAdAcc(AD_RSVVO adRsvVO){
		// 2. 사용 객실수 감소 처리
		if("RS00".equals(adRsvVO.getRsvStatusCd())) {
			webOrderDAO.updateAdCntInfMin(adRsvVO);
			webOrderDAO.updateAdBuyNumMin(adRsvVO);
		}
		// 3. 예약상태코드 자동취소(RS99)로 코드 변경
		adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_ACC);
		scheduleDAO.updateAdAutoCancel(adRsvVO);
		// 4. 판매 통계 감소 처리
		webOrderDAO.downSaleAnlsByDtlRsv(adRsvVO.getAdRsvNum());

		apiAdService.cancelResInfo(adRsvVO.getAdRsvNum(), "Y", "N");
	}

	/**
	 * 렌터카 자동취소 처리
	 * 파일명 : updateRcAcc
	 * 작성일 : 2016. 11. 8. 오후 1:55:29
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	@Override
	public void updateRcAcc(RC_RSVVO rcRsvVO) throws IOException {
		// 2. 탐나오 예약 현황 내역 삭제
		webOrderDAO.deleteRcUseHist(rcRsvVO);
		webOrderDAO.updateRcBuyNumMin(rcRsvVO);
		// 3. 예약상태코드 자동취소(RS99)로 코드 변경
		rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_ACC);
		scheduleDAO.updateRcAutoCancel(rcRsvVO);
		// 4. 판매 통계 감소 처리
		webOrderDAO.downSaleAnlsByDtlRsv(rcRsvVO.getRcRsvNum());
		if(Constant.FLAG_Y.equals(rcRsvVO.getLinkYn())){
			if(Constant.RC_RENTCAR_COMPANY_GRI.equals(rcRsvVO.getApiRentDiv())){
				apiService.cancelGrimRcRsv(rcRsvVO.getRcRsvNum());
			}else if(Constant.RC_RENTCAR_COMPANY_INS.equals(rcRsvVO.getApiRentDiv())){
				apiInsService.revcancel(rcRsvVO);
			}else if(Constant.RC_RENTCAR_COMPANY_RIB.equals(rcRsvVO.getApiRentDiv())){
				apiRibbonService.carCancel(rcRsvVO);
			}

		}
	}

	/**
	 * 소셜 자동 취소 처리
	 * 파일명 : updateSpAcc
	 * 작성일 : 2016. 11. 8. 오후 2:04:37
	 * 작성자 : 최영철
	 * @param spRsvVO
	 */
	@Override
	public void updateSpAcc(SP_RSVVO spRsvVO){
		// 2. 사용 객실수 감소 처리
		webOrderDAO.updateSpCntInfMin(spRsvVO);
		// 3. 예약상태코드 자동취소(RS99)로 코드 변경
		spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_ACC);
		scheduleDAO.updateSpAutoCancel(spRsvVO);
		// 4. 판매 통계 감소 처리
		webOrderDAO.downSaleAnlsByDtlRsv(spRsvVO.getSpRsvNum());
	}

	/**
	 * 기념품 자동 취소 처리
	 * 파일명 : updateSvAcc
	 * 작성일 : 2016. 11. 8. 오후 2:09:52
	 * 작성자 : 최영철
	 * @param svRsvVO
	 */
	@Override
	public void updateSvAcc(SV_RSVVO svRsvVO){
		// 2. 사용 수 감소 처리
		webOrderDAO.updateSvCntInfMin(svRsvVO);
		// 3. 예약상태코드 자동취소(RS99)로 코드 변경
		svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_ACC);
		scheduleDAO.updateSvAutoCancel(svRsvVO);
		// 4. 판매 통계 감소 처리
		webOrderDAO.downSaleAnlsByDtlRsv(svRsvVO.getSvRsvNum());
	}

	/**
	 * 예약 자동취소처리
	 * 파일명 : updateAcc
	 * 작성일 : 2016. 11. 8. 오후 2:17:11
	 * 작성자 : 최영철
	 * @param rsvVO
	 */
	@Override
	public void updateAcc(RSVVO rsvVO){
		webOrderDAO.updateAcc(rsvVO);
	}

	/**
	 * L.Point 사용 취소 처리
	 * 파일명 : updateLpointCancel
	 * 작성일 : 2017. 9. 5. 오전 11:44:21
	 * 작성자 : 정동수
	 * @param rsvVO
	 */
	@Override
	public void updateLpointCancel(RSVVO rsvVO){
		webOrderDAO.updateLpointCancel(rsvVO);
	}

	/**
	 * 예약번호에 따른 L.Point 사용 정보
	 * 파일명 : selectLpointCancelList
	 * 작성일 : 2017. 9. 8. 오후 3:53:42
	 * 작성자 : 정동수
	 * @param lpointUseInfVO
	 */
	@Override
	public LPOINTUSEINFVO selectLpointUsePoint(LPOINTUSEINFVO lpointUseInfVO) {
		return webOrderDAO.selectLpointUsePoint(lpointUseInfVO);
	}

	/**
	 * L.Point 사용 등록
	 * 파일명 : insertLpointUsePoint
	 * 작성일 : 2017. 9. 7. 오후 11:00:12
	 * 작성자 : 정동수
	 * @param
	 */
	@Override
	public void insertLpointUsePoint(LPOINTUSEINFVO lpointUseInfVO) {
		webOrderDAO.insertLpointUsePoint(lpointUseInfVO);
	}

	/**
	 * L.Point 사용 취소
	 * 파일명 : cancelLpointUsePoint
	 * 작성일 : 2017. 9. 7. 오후 11:00:35
	 * 작성자 : 정동수
	 * @param
	 */
	@Override
	public void cancelLpointUsePoint(LPOINTUSEINFVO lpointUseInfVO) {    
		webOrderDAO.cancelLpointUsePoint(lpointUseInfVO);
	}

	/**
	 * L.Point 일괄 적립 리스트
	 * 파일명 : selectLpointSaveList
	 * 작성일 : 2017. 9. 10. 오후 21:58:12
	 * 작성자 : 정동수
	 * @param
	 * @return List<LPOINTSAVEINFVO>
	 */
	@Override
	public 	List<LPOINTSAVEINFVO> selectLpointSaveList() {
		return webOrderDAO.selectLpointSaveList();
	}

	/**
	 * L.Point 적립 카드번호 등록
	 * 파일명 : insertLpointCardNum
	 * 작성일 : 2017. 9. 7. 오후 11:01:22
	 * 작성자 : 정동수
	 * @param lpointSaveInfVO
	 */
	@Override
	public void insertLpointCardNum(LPOINTSAVEINFVO lpointSaveInfVO) {
		webOrderDAO.insertLpointCardNum(lpointSaveInfVO);
	}

	/**
	 * L.Point 적립 예약 취소 처리
	 * 파일명 : updateLpointRsvCancel
	 * 작성일 : 2017. 9. 10. 오후 10:46:45
	 * 작성자 : 정동수
	 * @param lpointSaveInfVO
	 */
	@Override
	public void updateLpointRsvCancel(LPOINTSAVEINFVO lpointSaveInfVO) {
		webOrderDAO.updateLpointRsvCancel(lpointSaveInfVO);
	}

	/**
	 * L.Point 적립 처리
	 * 파일명 : insertLpointCardNum
	 * 작성일 : 2017. 9. 7. 오후 11:01:22
	 * 작성자 : 정동수
	 * @param lpointSaveInfVO
	 */
	@Override
	public void updateLpointSave(LPOINTSAVEINFVO lpointSaveInfVO) {
		webOrderDAO.updateLpointSave(lpointSaveInfVO);
	}

	/**
	 * 이벤트 코드 확인
	 * 파일명 : evntCdConfirm
	 * 작성일 : 2017. 3. 13. 오전 10:10:32
	 * 작성자 : 최영철
	 * @param evntInfVO
	 * @return
	 */
	@Override
	public String evntCdConfirm(EVNTINFVO evntInfVO){
		EVNTINFVO resultVO = prmtDAO.evntCdConfirm(evntInfVO);

		if(resultVO == null){
			return Constant.FLAG_N;
		}else{
			return Constant.FLAG_Y;
		}
	}

	/*미결제 조회*/
	@Override
	public List<RSVVO> selectUnpaidRsvList(RSVVO rsvVO) {
		return webOrderDAO.selectUnpaidRsvList(rsvVO);
	}

	/** MMS 메시지 조회 */
	@Override
	public List<MMSVO> selectListMMSmsg(MMSVO mmsVO){
		return webOrderDAO.selectListMMSmsg(mmsVO);
	};


	/**
	 * 관리자 직접 예약 시 관광기념품 예약 처리
	 */
	@Override
	public String insertSvAdminRsv(SV_RSVVO svRsvVO) {
		String svRsvNum = webOrderDAO.insertSvRsv(svRsvVO);
		// 정상 예약건인 경우 사용 카운트 증가
		if(Constant.RSV_STATUS_CD_COM.equals(svRsvVO.getRsvStatusCd())){
			webOrderDAO.updateSvCntInfAdd(svRsvVO);
		}
		return svRsvNum;
	}

	@Override
	public void updateRsvTamnacardRefInfo(RSVVO rsvvo) {
		webOrderDAO.updateRsvTamnacardRefInfo(rsvvo);
	}

	/**
	* 설명 : 에스크로 배송결과등록 프로그램 연동
	* 파일명 : escrowResp
	* 작성일 : 2021-09-07 오전 10:11
	* 작성자 : chaewan.jung
	* @param : request
	* @return : boolean
	* @throws Exception
	*/
	public boolean escrowResp(HttpServletRequest request) {
		boolean resp = false;
		try {
			/** 프로그램연동에 필요한 정보 get**/
			Map<String, String> paramMap = new HashMap<String, String>();
			String svRsvNum = request.getParameter("svRsvNum");
			paramMap.put("svRsvNum", svRsvNum);
			paramMap.put("dlvCorpCd", request.getParameter("dlvCorpCd"));
			ESCROWVO escrowVO = webOrderDAO.getEscrowInfo(paramMap);

			//에스크로 계좌이체 (L310)
			if (Constant.PAY_DIV_LG_ETI.equals(escrowVO.getPayDiv())) {

				/** 파라미터 value setting **/
				Date dt = new Date();
				SimpleDateFormat dtFmt = new SimpleDateFormat("yyyyMMddHHmm");

				//공통
				String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");    //LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
				String service_url = "test".equals(CST_PLATFORM.trim()) ? "https://pgweb.tosspayments.com:9091/pg/wmp/testadmin/jsp/escrow/rcvdlvinfo.jsp" : "https://pgweb.tosspayments.com/pg/wmp/mertadmin/jsp/escrow/rcvdlvinfo.jsp";
				String CST_MID = EgovProperties.getProperty("Globals.LgdID.PRE");            //상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
				String mid = ("test".equals(CST_PLATFORM.trim()) ? "t" : "") + CST_MID;//테스트 아이디는 't'를 제외하고 입력하세요.
				String mertkey = EgovProperties.getProperty("Globals.LgdMertKey.PRE");        //LG유플러스에서 발급한 상점키로 변경해 주시기 바랍니다.
				String oid = escrowVO.getOid();                                        //주문번호
				String productid = svRsvNum;                                                    //상품ID (LGD_ESCROW_GOODID 매핑)
				String dlvtype = "03";                                                    //등록내용구분 01:수령정보, 03:발송정보
				String hashdata = "";                                                        //보안용 인증키

				//발송정보
				String dlvdate = dtFmt.format(dt);                                        //발송일자
				String dlvcompcode = escrowVO.getDlvCompCode();
				String dlvno = request.getParameter("dlvNum");
				String dlvworker = escrowVO.getDlvWorker();
				String dlvworkertel = escrowVO.getDlvWorkertel();

				//수령정보
				String rcvdate = "";                                                        // 실수령일자
				String rcvname = "";                                                        // 실수령인명
				String rcvrelation = "";                                                        // 관계

				/** validate check **/
				//2023. 06. 07 해당 log 막음. chaewan.jung
				//[특산/기념품] 및 [에스크로 실시간 결제] 인지 체크
//			if(!Constant.SV.equals(escrowVO.getCorpCd()) || !Constant.PAY_DIV_LG_ETI.equals(escrowVO.getPayDiv())){
//				escrowVO.setRespMsg("특산기념품 결제가 아니거나 에스크로 결제 상품이 아닙니다.");
//				escrowVO.setResp("false");
//				webOrderDAO.insertEscrowSend(escrowVO);
//				return false;
//			}

				//에스크로 코드가 없는 택배 (농협택배등)인지 체크
				if ("".equals(escrowVO.getDlvCompCode()) || escrowVO.getDlvCompCode() == null) {
					escrowVO.setRespMsg("에스크로 배송 필드가 없거나 입력되지 않았습니다.");
					escrowVO.setResp("false");
					webOrderDAO.insertEscrowSend(escrowVO);
					return false;
				}

				/** 보안용 인증키 생성 - 시작 */
				StringBuffer sb = new StringBuffer();
				if ("03".equals(dlvtype)) {
					// 발송정보
					sb.append(mid);
					sb.append(oid);
					sb.append(dlvdate);
					sb.append(dlvcompcode);
					sb.append(dlvno);
					sb.append(mertkey);
				} else if ("01".equals(dlvtype)) {
					// 수령정보
					sb.append(mid);
					sb.append(oid);
					sb.append(dlvtype);
					sb.append(rcvdate);
					sb.append(mertkey);
				}

				byte[] bNoti = sb.toString().getBytes();
				MessageDigest md = MessageDigest.getInstance("MD5");
				byte[] digest = md.digest(bNoti);

				StringBuffer strBuf = new StringBuffer();

				for (int i = 0; i < digest.length; i++) {
					int c = digest[i] & 0xff;
					if (c <= 15) {
						strBuf.append("0");
					}
					strBuf.append(Integer.toHexString(c));
				}

				hashdata = strBuf.toString();

				/** 전송할 파라미터 문자열 생성 - 시작 */
				String sendMsg = "";
				StringBuffer msgBuf = new StringBuffer();
				//발송정보 등록시
				msgBuf.append("mid=" + mid + "&");
				msgBuf.append("oid=" + oid + "&");
				msgBuf.append("dlvtype=" + dlvtype + "&");
				msgBuf.append("dlvdate=" + dlvdate + "&");
				msgBuf.append("dlvcompcode=" + dlvcompcode + "&");
				msgBuf.append("dlvno=" + dlvno + "&");
				msgBuf.append("dlvworker=" + dlvworker + "&");
				msgBuf.append("dlvworkertel=" + dlvworkertel + "&");
				msgBuf.append("hashdata=" + hashdata + "&");
				//2023.07.05 chaewan.jung 처리결과수신이 안되는 원인으로 판단하여 토스측 요청으로 보내지 않게 처리.
				//msgBuf.append("productid=" + productid + "&");

				//수령정보 등록 시
				msgBuf.append("rcvdate=" + rcvdate + "&");
				msgBuf.append("rcvname=" + rcvname + "&");
				msgBuf.append("rcvrelation=" + rcvrelation + "&");

				sendMsg = msgBuf.toString();
				StringBuffer errmsg = new StringBuffer();

				/** HTTP로 배송결과 등록 */
				URL url = new URL(service_url);
				resp = sendRCVInfo(sendMsg, url, errmsg);

				out.println("상점주문번호 : " + oid + "\r\n");
				out.println("dlvworker : " + dlvworker + "\r\n");
				out.println("hashdata : " + hashdata + "\r\n");
				out.println("상품ID : " + productid + "\r\n");

				/** log insert **/
				escrowVO.setSvRsvNum(svRsvNum);
				escrowVO.setSendMsg(sendMsg);
				escrowVO.setRespMsg(errmsg.toString());
				escrowVO.setResp(String.valueOf(resp));
				webOrderDAO.insertEscrowSend(escrowVO);
			}else{
				resp = true;
			}

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resp;
	}

	/**
	 * 설명 : 에스크로 배송결과 송신 (수정 불가)
	 * 작성일 : 2021-09-01 오후 1:21
	 * 작성자 :
	 * @param :
	 * @return :boolean
	 * @throws Exception
	 */
	private boolean sendRCVInfo(String sendMsg, URL url, StringBuffer errmsg) throws Exception{
		OutputStreamWriter wr = null;
		BufferedReader br = null;
		HttpURLConnection conn = null;
		boolean result = false;
		String errormsg = null;

		try {
			conn = (HttpURLConnection)url.openConnection();
			conn.setDoOutput(true);
			wr = new OutputStreamWriter(conn.getOutputStream());
			wr.write(sendMsg);
			wr.flush();
			for (int i=0; ; i++) {
				String headerName = conn.getHeaderFieldKey(i);
				String headerValue = conn.getHeaderField(i);

				if (headerName == null && headerValue == null) {
					break;
				}
				if (headerName == null) {
					headerName = "Version";
				}

				errmsg.append(headerName + ":" + headerValue + "\n");
			}

			br = new BufferedReader(new InputStreamReader(conn.getInputStream (),"EUC-KR"));

			String in;
			StringBuffer sb = new StringBuffer();
			while(((in = br.readLine ()) != null )){
				sb.append(in);
			}

			errmsg.append(sb.toString().trim());
			if ( sb.toString().trim().equals("OK")){
				result = true;
			}else{
				errormsg = sb.toString().trim();
			}

		} catch ( Exception ex ) {
			errmsg.append("EXCEPTION : " + ex.getMessage());
			ex.printStackTrace();
		} finally {
			try {
				if ( wr != null) wr.close();
				if ( br != null) br.close();
			} catch(Exception e){
			}
		}

		return result;
	}

	/**
	 * 설명 : 에스크로 처리결과 수신 insert
	 * 작성일 : 2021-09-03 오전 11:32
	 * 작성자 : chaewan.jung
	 * @param : escrowVO
	 * @return : void
	 * @throws Exception
	 */
	public void insertEscrowReceive(ESCROWVO escrowVO){
		webOrderDAO.insertEscrowReceive(escrowVO);
	}

	public void insertTamnacardInfo(TAMNACARD_VO tamnacardVo){
		webOrderDAO.insertTamnacardInfo(tamnacardVo);
	}

	public TAMNACARD_VO selectTamnacardInfo(TAMNACARD_VO tamnacardVo){
		return webOrderDAO.selectTamnacardInfo(tamnacardVo);
	}

	public String tamnacardCompanyUseYn(String corpId){
		return webOrderDAO.tamnacardCompanyUseYn(corpId);
	}

	public String tamnacardPrdtUseYn(String prdtNum){
		return webOrderDAO.tamnacardPrdtUseYn(prdtNum);
	}

	@Override
	public void updateSvRsvCancelReq(String svRsvNum) {
		webOrderDAO.updateSvRsvCancelReq(svRsvNum);
	}
	
	@Override
	public void insertMrtnUser(MRTNVO mrtnVO) {
		
		int limit = mrtnVO.getApctNm().split(",").length;
		String[] apctNm = mrtnVO.getApctNm().split(",", limit);
		String[] birth = mrtnVO.getBirth().split(",", limit);
		String[] lrrn = mrtnVO.getLrrn().split(",", limit);
		String[] apctTelnum= mrtnVO.getApctTelnum().split(",", limit);
		String[] ageRange = mrtnVO.getAgeRange().split(",", limit);
		String[] gender = mrtnVO.getGender().split(",", limit);
		String[] bloodType = mrtnVO.getBloodType().split(",", limit);
		String[] region = mrtnVO.getRegion().split(",", limit);
		String[] apctPostNum = mrtnVO.getApctPostNum().split(",", limit);
		String[] apctRoadNmAddr = mrtnVO.getApctRoadNmAddr().split(",", limit);
		String[] apctDtlAddr = mrtnVO.getApctDtlAddr().split(",", limit);
		String[] apctEmail = mrtnVO.getApctEmail().split(",", limit);
		String[] course = mrtnVO.getCourse().split(",", limit);
		String[] tshirts = mrtnVO.getTshirts().split(",", limit);
		
		int txsUseCnt = 0;int tsUseCnt = 0;int tmUseCnt = 0;int tlUseCnt = 0;int txlUseCnt = 0;int t2xlUseCnt = 0;int t3xlUseCnt = 0;
		MRTNVO mrtniVO = new MRTNVO();
		mrtniVO.setRsvNum(mrtnVO.getRsvNum());
		mrtniVO.setSpRsvNum(mrtnVO.getSpRsvNum());
		mrtniVO.setCorpId(mrtnVO.getCorpId());
		mrtniVO.setPrdtNum(mrtnVO.getPrdtNum());
		mrtniVO.setGroupNm(mrtnVO.getGroupNm());

		int i = mrtnVO.getIndex();

		mrtniVO.setApctNm(apctNm[i]);
		mrtniVO.setBirth(birth[i]);
		mrtniVO.setLrrn(lrrn[i]);
		mrtniVO.setApctTelnum(apctTelnum[i]);
		mrtniVO.setAgeRange(ageRange[i]);
		mrtniVO.setGender(gender[i]);
		mrtniVO.setBloodType(bloodType[i]);
		mrtniVO.setRegion(region[i]);
		mrtniVO.setFullAddr("("+apctPostNum[i]+") "+apctRoadNmAddr[i]+" "+apctDtlAddr[i]);
		mrtniVO.setApctEmail(apctEmail[i]);

		String courseCd = "";
		if("1".equals(course[i])) {				//풀코스
			courseCd = "F";
		} else if("2".equals(course[i])) {		//하프코스
			courseCd = "H";
		} else if("3".equals(course[i])) {		//10km
			courseCd = "T";
		} else if("4".equals(course[i])) {		//5km
			courseCd = "W";
		}

		mrtniVO.setCourse(courseCd);
		mrtniVO.setTshirts(tshirts[i]);
		webOrderDAO.insertMrtnUser(mrtniVO);

		if("XS".equals(tshirts[i])) {
			txsUseCnt++;
		} else if ("S".equals(tshirts[i])) {
			tsUseCnt++;
		} else if ("M".equals(tshirts[i])) {
			tmUseCnt++;
		} else if ("L".equals(tshirts[i])) {
			tlUseCnt++;
		} else if ("XL".equals(tshirts[i])) {
			txlUseCnt++;
		} else if ("2XL".equals(tshirts[i])) {
			t2xlUseCnt++;
		} else if ("3XL".equals(tshirts[i])) {
			t3xlUseCnt++;
		}

		mrtniVO.setTxsUseCnt(Integer.toString(txsUseCnt));
		mrtniVO.setTsUseCnt(Integer.toString(tsUseCnt));
		mrtniVO.setTmUseCnt(Integer.toString(tmUseCnt));
		mrtniVO.setTlUseCnt(Integer.toString(tlUseCnt));
		mrtniVO.setTxlUseCnt(Integer.toString(txlUseCnt));
		mrtniVO.setT2xlUseCnt(Integer.toString(t2xlUseCnt));
		mrtniVO.setT3xlUseCnt(Integer.toString(t3xlUseCnt));
		webOrderDAO.updateUseTshirtsCnt(mrtniVO);
	}

	@Override
	public MRTNVO selectTshirtsCntVO(MRTNVO mrtnSVO) {
		return webOrderDAO.selectTshirtsCntVO(mrtnSVO);
	}
	
	@Override
	public void updateReturnTshirtsCnt(MRTNVO mrtnVO) {
		
		List<MRTNVO> selectCancelList = webOrderDAO.selectCancelUserList(mrtnVO);
		
		int txsUseCnt = 0;int tsUseCnt = 0;int tmUseCnt = 0;int tlUseCnt = 0;int txlUseCnt = 0;int t2xlUseCnt = 0;int t3xlUseCnt = 0;
		String tshirts = "";
		for(MRTNVO tshirtsVO : selectCancelList) {
			tshirts = tshirtsVO.getTshirts().trim();
			if("XS".equals(tshirts)) {
				txsUseCnt++;
			} else if ("S".equals(tshirts)) {
				tsUseCnt++;
			} else if ("M".equals(tshirts)) {
				tmUseCnt++;
			} else if ("L".equals(tshirts)) {
				tlUseCnt++;
			} else if ("XL".equals(tshirts)) {
				txlUseCnt++;
			} else if ("2XL".equals(tshirts)) {
				t2xlUseCnt++;
			} else if ("3XL".equals(tshirts)) {
				t3xlUseCnt++;
			}
		}
		
		mrtnVO.setTxsUseCnt(Integer.toString(txsUseCnt));
		mrtnVO.setTsUseCnt(Integer.toString(tsUseCnt));
		mrtnVO.setTmUseCnt(Integer.toString(tmUseCnt));
		mrtnVO.setTlUseCnt(Integer.toString(tlUseCnt));
		mrtnVO.setTxlUseCnt(Integer.toString(txlUseCnt));
		mrtnVO.setT2xlUseCnt(Integer.toString(t2xlUseCnt));
		mrtnVO.setT3xlUseCnt(Integer.toString(t3xlUseCnt));
		webOrderDAO.updateReturnTshirtsCnt(mrtnVO);
	}
}
