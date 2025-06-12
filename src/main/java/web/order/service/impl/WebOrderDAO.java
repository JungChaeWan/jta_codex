package web.order.service.impl;

import egovframework.cmmn.vo.MMSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;
import oss.ad.vo.AD_USEHISTVO;
import web.mypage.vo.RSV_HISSVO;
import web.order.vo.*;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 * 파일명 : WebOrderDAO.java
 * 작성일 : 2015. 11. 19. 오전 11:12:28
 * 작성자 : 최영철
 */
/**
 * <pre>
 * 파일명 : WebOrderDAO.java
 * 작성일 : 2015. 12. 14. 오후 6:13:20
 * 작성자 : 최영철
 */
@Repository("webOrderDAO")
public class WebOrderDAO extends EgovAbstractDAO {

	/**
	 * 예약테이블 등록
	 * 파일명 : insertRsv
	 * 작성일 : 2015. 11. 17. 오후 8:51:04
	 * 작성자 : 최영철
	 * @return	예약번호
	 */
	public String insertRsv(RSVVO rsvVO) {
		return (String) insert("RSV_I_01", rsvVO);
	}

	/**
	 * 렌터카 예약 처리
	 * 파일명 : insertRcRsv
	 * 작성일 : 2015. 11. 18. 오전 9:59:33
	 * 작성자 : 최영철
	 */
	public String insertRcRsv(RC_RSVVO rcRsvVO) {
		return (String) insert("RC_RSV_I_01", rcRsvVO);
	}

	/**
	 * 렌터카 이용내역 처리
	 * 파일명 : insertRcHist
	 * 작성일 : 2015. 11. 18. 오전 10:37:57
	 * 작성자 : 최영철
	 */
	public void insertRcHist(RC_RSVVO rcRsvVO) {
		insert("RC_USEHIST_I_00", rcRsvVO);
	}

	/**
	 * 숙박 예약 처리
	 * 파일명 : insertAdRsv
	 * 작성일 : 2015. 11. 18. 오후 1:33:00
	 * 작성자 : 최영철
	 * @return
	 */
	public String insertAdRsv(AD_RSVVO adRsvVO) {
		return (String) insert("AD_RSV_I_01", adRsvVO);
	}

	/**
	 * 사용숙박에 대해 수량 증가
	 * 파일명 : updateAdCntInf
	 * 작성일 : 2015. 11. 18. 오후 1:44:54
	 * 작성자 : 최영철
	 */
	public void updateAdCntInfAdd(AD_RSVVO adRsvVO) {
		update("AD_CNTINF_U_02", adRsvVO);
	}

	/**
	 * 사용숙박에 대해 수량 감소
	 * 파일명 : updateAdCntInfMin
	 * 작성일 : 2015. 11. 18. 오후 1:44:54
	 * 작성자 : 최영철
	 */
	public void updateAdCntInfMin(AD_RSVVO adRsvVO) {
		update("AD_CNTINF_U_03", adRsvVO);
	}

	/**
	 * 숙박 예약의 날짜별 금액 저장
	 * Function : insertAdUsehist
	 * 작성일 : 2017. 08. 28. 오후 1:54:15
	 * 작성자 : 정동수
	 * @return
	 */
	public String insertAdUsehist(AD_USEHISTVO adUsehistVO) {
		return (String) insert("AD_USEHIST_I_00", adUsehistVO);
	}
	/**
	 * 소셜상품 예약 처리
	 * 파일명 : insertSpRsv
	 * 작성일 : 2015. 11. 18. 오후 5:22:22
	 * 작성자 : 최영철
	 * @return
	 */
	public String insertSpRsv(SP_RSVVO spRsvVO) {
		return (String) insert("SP_RSV_I_01", spRsvVO);
	}

	/**
	 * 소셜상품 판매 수 증가 처리
	 * 파일명 : updateSpCntInfAdd
	 * 작성일 : 2015. 11. 18. 오후 5:27:43
	 * 작성자 : 최영철
	 */
	public void updateSpCntInfAdd(SP_RSVVO spRsvVO) {
		update("SP_OPTINF_U_04", spRsvVO);
	}

	/**
	 * 소셜상품 판매 수 감소 처리
	 * 파일명 : updateSpCntInfMin
	 * 작성일 : 2015. 11. 18. 오후 5:27:43
	 * 작성자 : 최영철
	 */
	public void updateSpCntInfMin(SP_RSVVO spRsvVO) {
		update("SP_OPTINF_U_05", spRsvVO);
	}

	/**
	 * 각 상품의 예약처리 후 금액 합계 처리
	 * 파일명 : updateTotalAmt
	 * 작성일 : 2015. 11. 18. 오후 5:44:23
	 * 작성자 : 최영철
	 */
	public void updateToTalAmt(RSVVO rsvVO) {
		update("RSV_U_01", rsvVO);
	}

	public void updateRefundAcc(ORDERVO orderVO) {
		update("RSV_U_11", orderVO);
	}

	/**
	 * 예약상품 리스트 조회
	 * 파일명 : selectOrderList
	 * 작성일 : 2015. 11. 18. 오후 6:39:14
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectOrderList(RSVVO rsvVO) {
		return (List<ORDERVO>) list("RSV_S_01", rsvVO);
	}


	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectSmsMailList(RSVVO rsvVO) {
		return (List<ORDERVO>) list("RSV_S_30", rsvVO);
	}



	/**
	 * 예약 마스터 조회
	 * 파일명 : selectByRsv
	 * 작성일 : 2015. 11. 19. 오전 11:12:30
	 * 작성자 : 최영철
	 * @return
	 */
	public RSVVO selectByRsv(RSVVO rsvVO) {
		return (RSVVO) select("RSV_S_00", rsvVO);
	}

	/**
	 * 예약 목록 조회
	 * 파일명 : selectRsvList
	 * 작성일 : 2015. 11. 20. 오전 11:12:00
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RSVVO> selectRsvList(RSVVO rsvVO) {
		return (List<RSVVO>) list("RSV_S_00", rsvVO);
	}

	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectByRsvCnt(RSVVO rsvInfo) {
		return (List<ORDERVO>) list("RSV_S_02", rsvInfo);
	}


	/**
	 * 상품평을 남길 수 있는 구매 목록 조회
	 * 파일명 : selectByRsvCnt
	 * 작성일 : 2015. 11. 25. 오전 11:00:23
	 * 작성자 : 신우섭
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RSVEPILVO> selectRsvEpil(RSVEPILVO epVO) {
		return (List<RSVEPILVO>) list("RSV_S_03", epVO);
	}


	/**
	 * 상품평 쓴거 표시
	 * 파일명 : updateRsvEpil
	 * 작성일 : 2015. 11. 25. 오후 2:01:30
	 * 작성자 : 신우섭
	 * @param epVO
	 */
	public void updateRsvEpil(RSVEPILVO epVO) {
		update("RSV_U_03", epVO);
	}

	/**
	 * 예약테이블 예약상태 변경
	 * 파일명 : updateRsvStatus
	 * 작성일 : 2015. 12. 8. 오전 9:51:09
	 * 작성자 : 최영철
	 * @param rsvVO
	 */
	public void updateRsvStatus(RSVVO rsvVO) {
		update("RSV_U_04", rsvVO);
	}

	/**
	 * 각 상세 예약건 업데이트
	 * 파일명 : updateDtlRsvStatus
	 * 작성일 : 2015. 12. 8. 오전 10:01:55
	 * 작성자 : 최영철
	 */
	public void updateDtlRsvStatus(RSVVO rsvVO) {
		update("AD_RSV_U_01", rsvVO);
		update("RC_RSV_U_01", rsvVO);
		update("SP_RSV_U_01", rsvVO);
		update("SV_RSV_U_01", rsvVO);
	}

	/**
	 * 예약 불가건 삭제
	 * 파일명 : deleteNotRsv
	 * 작성일 : 2015. 12. 8. 오전 10:01:47
	 * 작성자 : 최영철
	 */
	public void deleteNotRsv(RSVVO rsvVO) {
		update("AD_RSV_D_01", rsvVO);
		update("RC_RSV_D_01", rsvVO);
		update("SP_RSV_D_01", rsvVO);
		update("SV_RSV_D_01", rsvVO);
	}


	public LGPAYINFVO selectLGPAYINFO(LGPAYINFVO lgpayinfVO) {
		return (LGPAYINFVO) select("LGPAYINF_S_00", lgpayinfVO);
	}

	public LGPAYINFVO selectLGPAYINFO_V(RSVVO rsvVO) {
		return (LGPAYINFVO) select("LGPAYINF_S_01", rsvVO);
	}

	/**
	 * LG 결제정보 등록
	 * 파일명 : insertLGPAYINFO
	 * 작성일 : 2015. 12. 8. 오전 10:36:45
	 * 작성자 : 최영철
	 */
	public void insertLGPAYINFO(LGPAYINFVO lGPAYINFO) {
		insert("LGPAYINF_I_00", lGPAYINFO);
	}

	/**
	 * LG 결제정보 등록
	 * 파일명 : insertLGPAYINFO
	 * 작성일 : 2015. 12. 8. 오전 10:36:45
	 * 작성자 : 최영철
	 */
	public void updateLGPAYINFO(LGPAYINFVO lGPAYINFO) {
		insert("LGPAYINF_U_00", lGPAYINFO);
	}

	/**
	 * 결제 테이블 등록
	 * 파일명 : insertPay
	 * 작성일 : 2015. 12. 8. 오전 10:55:29
	 * 작성자 : 최영철
	 */
	public void insertPay(PAYVO payVO) {
		insert("PAY_I_00", payVO);
	}

	public void updatePay(PAYVO payVO) {
		insert("PAY_U_00", payVO);
	}

	/**
	 * 마이페이지 예약내역조회
	 * 파일명 : selectOrderList2
	 * 작성일 : 2015. 12. 8. 오후 3:44:10
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectOrderList2(RSVVO rsvVO) {
		return (List<ORDERVO>) list("RSV_S_04", rsvVO);
	}

	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectOrderList2Guest(RSVVO rsvVO) {
		return (List<ORDERVO>) list("RSV_S_21", rsvVO);
	}

	public List<ORDERVO> selectOrderList2(RSV_HISSVO rsvHisSVO) {
		return (List<ORDERVO>) list("RSV_S_04", rsvHisSVO);
	}

	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectOrderList2Guest(RSV_HISSVO rsvHisSVO) {
		return (List<ORDERVO>) list("RSV_S_21", rsvHisSVO);
	}
	/**
	 * 각 예약건 상태 변경
	 * 파일명 : updateDtlRsvStatus2
	 * 작성일 : 2015. 12. 9. 오후 5:30:39
	 * 작성자 : 최영철
	 */
	public void updateDtlRsvStatus2(ORDERVO orderVO) {
		update("AD_RSV_U_01", orderVO);
		update("RC_RSV_U_01", orderVO);
		update("SP_RSV_U_01", orderVO);
		update("SV_RSV_U_01", orderVO);
	}

	/**
	 * 최초 결제 성공건 조회
	 * 파일명 : selectByPayInfo
	 * 작성일 : 2015. 12. 10. 오후 1:24:36
	 * 작성자 : 최영철
	 * @return
	 */
	public PAYVO selectByPayInfo(PAYVO payVO) {
		return (PAYVO) select("PAY_S_01", payVO);
	}

	/**
	 * 렌터카 예약건 취소 처리
	 * 파일명 : updateRcCancelDtlRsv
	 * 작성일 : 2015. 12. 10. 오후 3:41:04
	 * 작성자 : 최영철
	 */
	public void updateRcCancelDtlRsv(RC_RSVVO rcRsvVO) {
		update("RC_RSV_U_02", rcRsvVO);
	}

	/**
	 * 소셜상품 예약건 취소 처리
	 * 파일명 : updateSpCancelDtlRsv
	 * 작성일 : 2015. 12. 14. 오후 6:01:04
	 * 작성자 : 최영철
	 */
	public void updateSpCancelDtlRsv(SP_RSVVO spRsvVO) {
		update("SP_RSV_U_02", spRsvVO);
	}

	/**
	 * 숙박 예약건 취소 처리
	 * 파일명 : updateAdCancelDtlRsv
	 * 작성일 : 2015. 12. 14. 오후 6:13:21
	 * 작성자 : 최영철
	 */
	public void updateAdCancelDtlRsv(AD_RSVVO adRsvVO) {
		update("AD_RSV_U_02", adRsvVO);
	}

	/**
	 * 렌터카 이용내역 삭제
	 * 파일명 : deleteRcUseHist
	 * 작성일 : 2015. 12. 17. 오후 12:05:01
	 * 작성자 : 최영철
	 */
	public void deleteRcUseHist(RC_RSVVO rcRsvVO) {
		delete("RC_USEHIST_D_00", rcRsvVO);
	}

	/**
	 * 사용자 예약내역 조회
	 * 파일명 : selectUserRsvList
	 * 작성일 : 2015. 12. 23. 오후 2:38:48
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RSVVO> selectUserRsvList(RSVVO rsvVO) {
		return (List<RSVVO>) list("RSV_S_08", rsvVO);
	}

	@SuppressWarnings("unchecked")
	public List<RSVVO> selectUserRsvListGuest(RSV_HISSVO rsvHisSVO) {
		return (List<RSVVO>) list("RSV_S_20", rsvHisSVO);
	}

	/**
	 * 상품 예약 번호로 정보 얻기
	 * 파일명 : selectUserRsvFromPrdtRsvNum
	 * 작성일 : 2016. 1. 4. 오전 11:25:30
	 * 작성자 : 신우섭
	 * @return
	 */
	public ORDERVO selectUserRsvFromPrdtRsvNum(ORDERVO orderVO) {
		return (ORDERVO) select("RSV_S_09", orderVO);
	}

	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectUserRsvListFromRsvNum(ORDERVO orderVO) {
		return (List<ORDERVO>) list("RSV_S_09", orderVO);
	}


	/**
	 * 카카오 결제 정보 등록
	 * 파일명 : insertKAKAOPAYINF
	 * 작성일 : 2016. 1. 4. 오후 2:36:41
	 * 작성자 : 최영철
	 */
	public void insertKAKAOPAYINF(KAKAOPAYINFVO kakaoPayInfVO) {
		insert("KAKAOPAYINF_I_00", kakaoPayInfVO);
	}

	/**
	 * 판매통계 MERGE
	 * 파일명 : mergeSaleAnls
	 * 작성일 : 2016. 1. 18. 오전 10:00:51
	 * 작성자 : 최영철
	 */
	public void mergeSaleAnls(String prdtNum) {
		update("SALE_ANLS_M_00", prdtNum);
	}

	/**
	 * 판매통계 취소 처리
	 * 파일명 : downSaleAnls
	 * 작성일 : 2016. 1. 18. 오전 10:04:44
	 * 작성자 : 최영철
	 */
	public void downSaleAnls(String prdtNum) {
		update("SALE_ANLS_U_00", prdtNum);
	}

	/**
	 * 판매통계 취소 처리 - 상세예약번호 별
	 * 파일명 : downSaleAnlsByDtlRsv
	 * 작성일 : 2016. 11. 8. 오후 12:08:09
	 * 작성자 : 최영철
	 */
	public void downSaleAnlsByDtlRsv(String dtlRsvNum) {
		update("SALE_ANLS_U_01", dtlRsvNum);
	}

	/**
	 * 숙박 총 구매수 증가
	 * 파일명 : updateAdBuyNumAdd
	 * 작성일 : 2016. 2. 1. 오후 6:42:09
	 * 작성자 : 최영철
	 */
	public void updateAdBuyNumAdd(AD_RSVVO adRsvVO) {
		update("AD_DFTINF_U_02", adRsvVO);
		update("AD_PRDTINF_U_06", adRsvVO);
	}

	/**
	 * 숙박 총 구매수 감소
	 * 파일명 : updateAdBuyNumMin
	 * 작성일 : 2016. 2. 1. 오후 6:42:09
	 * 작성자 : 최영철
	 */
	public void updateAdBuyNumMin(AD_RSVVO adRsvVO) {
		update("AD_DFTINF_U_03", adRsvVO);
		update("AD_PRDTINF_U_07", adRsvVO);
	}

	/**
	 * 렌터카 총 구매수 증가
	 * 파일명 : updateRcBuyNumAdd
	 * 작성일 : 2016. 2. 1. 오후 6:48:03
	 * 작성자 : 최영철
	 */
	public void updateRcBuyNumAdd(RC_RSVVO rcRsvVO) {
		update("RC_PRDTINF_U_03", rcRsvVO);
	}

	/**
	 * 렌터카 총 구매수 감소
	 * 파일명 : updateRcBuyNumMin
	 * 작성일 : 2016. 2. 1. 오후 6:48:03
	 * 작성자 : 최영철
	 */
	public void updateRcBuyNumMin(RC_RSVVO rcRsvVO) {
		update("RC_PRDTINF_U_04", rcRsvVO);
	}

	/**
	 * 관광 기념품 예약 처리
	 * @return
	 */
	public String insertSvRsv(SV_RSVVO svRsvVO) {
		return (String) insert("SV_RSV_I_01", svRsvVO);
	}

	/**
	 * 관광기념품 판매 증가 처리
	 */
	public void updateSvCntInfAdd(SV_RSVVO svRsvVO) {
		update("SV_OPTINF_U_04", svRsvVO);
	}

	/**
	 * 배송지 수정
	 */
	public void updateDlv(RSVVO rsvVO) {
		update("RSV_U_08", rsvVO);
	}

	/**
	 * 최근 주문 배송지
	 * @return
	 */
	public RSVVO orderRecentDlv(RSVVO rsvVO) {
		return (RSVVO) select("RSV_S_22", rsvVO);
	}

	/**
	 *  구매확정
	 */
	public void confirmOrder(String svRsvNum) {
		update("SV_RSV_U_11", svRsvNum);
	}

	/**
	 * 관광기념품 예약테이블 취소 처리
	 * 파일명 : updateSvCancelDtlRsv
	 * 작성일 : 2016. 10. 14. 오후 3:32:04
	 * 작성자 : 최영철
	 */
	public void updateSvCancelDtlRsv(SV_RSVVO svRsvVO) {
		update("SV_RSV_U_02", svRsvVO);
	}

	/**
	 * 관광기념품 판매 수량 제어
	 * 파일명 : updateSvCntInfMin
	 * 작성일 : 2016. 10. 14. 오후 3:35:53
	 * 작성자 : 최영철
	 */
	public void updateSvCntInfMin(SV_RSVVO rsvDtlVO) {
		update("SV_OPTINF_U_05", rsvDtlVO);
	}

	public void updateSvRsvDlvAmt(SV_RSVVO svRsvVO) {
		update("SV_RSV_U_12", svRsvVO);
	}

	public void updateSvRsvDlvPoint(SV_RSVVO svRsvVO) {
		update("SV_RSV_U_14", svRsvVO);
	}

	/**
	 * 예약 자동취소 처리
	 * 파일명 : updateAcc
	 * 작성일 : 2016. 11. 8. 오후 2:17:41
	 * 작성자 : 최영철
	 */
	public void updateAcc(RSVVO rsvVO) {
		update("RSV_U_09", rsvVO);
	}

	/**
	 * L.Point 사용 취소 처리
	 * 파일명 : updateLpointCancel
	 * 작성일 : 2017. 9. 5. 오전 11:44:21
	 * 작성자 : 정동수
	 */
	public void updateLpointCancel(RSVVO rsvVO) {
		update("RSV_U_10", rsvVO);
	}

	/**
	 * 예약번호에 따른 L.Point 사용 정보
	 * 파일명 : selectLpointUsePoint
	 * 작성일 : 2017. 9. 8. 오후 3:53:42
	 * 작성자 : 정동수
	 * @return
	 */
	public LPOINTUSEINFVO selectLpointUsePoint(LPOINTUSEINFVO lpointUseInfVO) {
		return (LPOINTUSEINFVO) select("LPOINTUSEINF_S_00", lpointUseInfVO);
	}

	/**
	 * L.Point 사용 등록
	 * 파일명 : insertLpointUsePoint
	 * 작성일 : 2017. 9. 7. 오후 11:00:12
	 * 작성자 : 정동수
	 * @param lpointUseInfVO
	 */
	public void insertLpointUsePoint(LPOINTUSEINFVO lpointUseInfVO) {
		insert("LPOINTUSEINF_I_00", lpointUseInfVO);
	}

	/**
	 * L.Point 사용 취소
	 * 파일명 : cancelLpointUsePoint
	 * 작성일 : 2017. 9. 7. 오후 11:00:35
	 * 작성자 : 정동수
	 * @param lpointUseInfVO
	 */
	public void cancelLpointUsePoint(LPOINTUSEINFVO lpointUseInfVO) {
		update("LPOINTUSEINF_U_00", lpointUseInfVO);
	}

	/**
	 * L.Point 일괄 적립 리스트
	 * 파일명 : selectLpointSaveList
	 * 작성일 : 2017. 9. 10. 오후 21:58:12
	 * 작성자 : 정동수
	 * @param
	 * @return List<LPOINTSAVEINFVO>
	 */
	@SuppressWarnings("unchecked")
	public List<LPOINTSAVEINFVO> selectLpointSaveList() {
		return (List<LPOINTSAVEINFVO>)list("LPOINTSAVEINF_S_00");
	}

	/**
	 * L.Point 적립 카드번호 등록
	 * 파일명 : insertLpointCardNum
	 * 작성일 : 2017. 9. 7. 오후 11:01:22
	 * 작성자 : 정동수
	 * @param lpointSaveInfVO
	 */
	public void insertLpointCardNum(LPOINTSAVEINFVO lpointSaveInfVO) {
		update("LPOINTSAVEINF_I_00", lpointSaveInfVO);
	}

	/**
	 * L.Point 적립 예약 취소 처리
	 * 파일명 : updateLpointRsvCancel
	 * 작성일 : 2017. 9. 10. 오후 10:46:45
	 * 작성자 : 정동수
	 * @param lpointSaveInfVO
	 */
	public void updateLpointRsvCancel(LPOINTSAVEINFVO lpointSaveInfVO) {
		update("LPOINTSAVEINF_U_00", lpointSaveInfVO);
	}

	/**
	 * L.Point 적립 처리
	 * 파일명 : insertLpointCardNum
	 * 작성일 : 2017. 9. 7. 오후 11:01:22
	 * 작성자 : 정동수
	 * @param lpointSaveInfVO
	 */
	public void updateLpointSave(LPOINTSAVEINFVO lpointSaveInfVO) {
		update("LPOINTSAVEINF_U_01", lpointSaveInfVO);
	}

	/**
	 * 숙박 예약 시 사용내역 저장
	 * Function : insertAdRsvhist
	 * 작성일 : 2017. 08. 28. 오후 2:27:15
	 * 작성자 : 정동수
	 */
	/*public void insertAdRsvhist(AD_USEHISTVO adUseHistVO) {
		insert("AD_USEHIST_I_00", adUseHistVO.getUseHistList());
	}*/

	/*미결제 조회*/
	public List<RSVVO> selectUnpaidRsvList(RSVVO rsvVO) {
		return (List<RSVVO>) list("RSV_S_31", rsvVO);
	}

	/** MMS 메시지백업*/
	public void insertMMSmsg(MMSVO mmsVO){ insert("MMS_BACKUP_MSG_I_00", mmsVO);	}

	/** MMS 백업메시지 전송*/
	public List<MMSVO> selectListMMSmsg(MMSVO mmsVO){ return (List<MMSVO>) list("MMS_BACKUP_MSG_S_00", mmsVO);	}

	public void updateRsvTamnacardRefInfo(RSVVO rsvvo) {
		update("RSV_U_15", rsvvo);
	}

	/**
	* 설명 : 에스크로 배송등록 정보 GET
	* 작성일 : 2021-09-01 오후 3:29
	* 작성자 : chaewan.jung
	* @param :
	* @param svRsvNum
	 * @return :
	* @throws Exception
	*/
	public ESCROWVO getEscrowInfo(Map<String, String> svRsvNum){
		return (ESCROWVO) select("ESCROW_S_00", svRsvNum);
	}

	/**
	* 설명 : 에스크로 처리결과 수신 insert
	* 작성일 : 2021-09-03 오후 1:21
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void insertEscrowReceive(ESCROWVO escrowVO){
		insert("ESCROW_I_00", escrowVO);
	}

	/**
	* 설명 : 에스크로 발송 정보 insert
	* 작성일 : 2021-09-08 오후 2:07
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void insertEscrowSend(ESCROWVO escrowVO){
		insert("ESCROW_I_01", escrowVO);
	}

	public void insertTamnacardInfo(TAMNACARD_VO tamnacardVo){
		insert("TAMNACARD_I_00", tamnacardVo);
	}

	public TAMNACARD_VO selectTamnacardInfo(TAMNACARD_VO tamnacardVo){
		return (TAMNACARD_VO)select("TAMNACARD_S_00", tamnacardVo);
	}

	public String tamnacardCompanyUseYn(String corpId){
		return (String)select("TAMNACARD_S_01", corpId);
	}

	public String tamnacardPrdtUseYn(String prdtNum){
		return (String)select("TAMNACARD_S_02", prdtNum);
	}

	/**
	* 설명 : 에스크로 특산/기념품 취소요청상태로 변경
	* 파일명 :
	* 작성일 : 2023-05-18 오후 2:21
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void updateSvRsvCancelReq(String svRsvNum) {
		update("SV_RSV_U_17", svRsvNum);
	}
	
	/**
	* 설명 : 마라톤 신청인원등록
	* 파일명 : insertMrtnUser
	* 작성일 : 2023-11-23 오전 11:00
	* 작성자 : 
	* @param :
	* @return :
	* @throws Exception
	*/
	public void insertMrtnUser(MRTNVO mrtnVO) {
		insert("SP_RSV_I_02", mrtnVO);
	}
	
	public MRTNVO selectTshirtsCntVO(MRTNVO mrtnSVO){
		return (MRTNVO)select("SP_RSV_S_09", mrtnSVO);
	}
	
	public void updateUseTshirtsCnt(MRTNVO mrtnVO) {
		update("SP_RSV_U_10", mrtnVO);
	}
	
	public void updateReturnTshirtsCnt(MRTNVO mrtnVO) {
		update("SP_RSV_U_11", mrtnVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<MRTNVO> selectCancelUserList(MRTNVO mrtnVO) {
		return (List<MRTNVO>) list("SP_RSV_S_10", mrtnVO);
	}

	public Integer selectOrderList2Cnt(RSV_HISSVO rsvHisSVO) {
		return (Integer) select("RSV_S_33", rsvHisSVO);
	}

	public Integer selectOrderList2GuestCnt(RSV_HISSVO rsvHisSVO) {
		return (Integer) select("RSV_S_34", rsvHisSVO);
	}
}
