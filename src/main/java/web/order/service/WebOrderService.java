package web.order.service;

import egovframework.cmmn.vo.MMSVO;
import oss.marketing.vo.EVNTINFVO;
import web.mypage.vo.RSV_HISSVO;
import web.mypage.vo.USER_CPVO;
import web.order.vo.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;


public interface WebOrderService {

	/**
	 * 예약 테이블 등록
	 * 파일명 : insertRsv
	 * 작성일 : 2015. 11. 17. 오후 8:49:44
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	//todo insertRsv 사용 되는 controller 전부 처리
	//WebOrderController 처리 완료
	//OssRsvController x 2 확인 해봐
	//MwOrderController 확인 해봐
	//MasB2bSpController 확인 해봐
	String insertRsv(RSVVO rsvVO);

	/**
	 * 렌터카 상품 예약 처리
	 * 파일명 : insertRcRsv
	 * 작성일 : 2015. 11. 18. 오전 9:57:47
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 * @throws IOException
	 */
	String insertRcRsv(RC_RSVVO rcRsvVO) throws IOException;

	/**
	 * 렌터카 이용내역 처리
	 * 파일명 : insertRcHist
	 * 작성일 : 2015. 11. 18. 오전 10:36:48
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	void insertRcHist(RC_RSVVO rcRsvVO);

	/**
	 * 숙박 상품 예약 처리
	 * 파일명 : insertAdRsv
	 * 작성일 : 2015. 11. 18. 오후 1:31:52
	 * 작성자 : 최영철
	 * @param adRsvVO
	 * @return
	 */
	String insertAdRsv(AD_RSVVO adRsvVO);

	/**
	 * 소셜 상품 예약 처리
	 * 파일명 : insertSpRsv
	 * 작성일 : 2015. 11. 18. 오후 5:21:30
	 * 작성자 : 최영철
	 * @param spRsvVO
	 * @return
	 */
	String insertSpRsv(SP_RSVVO spRsvVO);

	/**
	 * 각 상품의 예약처리 후 금액 합계 처리
	 * 파일명 : updateTotalAmt
	 * 작성일 : 2015. 11. 18. 오후 5:44:23
	 * 작성자 : 최영철
	 * @param rsvVO
	 */
	void updateTotalAmt(RSVVO rsvVO);

	/** 환불계좌번호 */
	void updateRefundAcc(ORDERVO orderVO);

	/**
	 * 예약건 리스트 조회
	 * 파일명 : selectOrderList
	 * 작성일 : 2015. 11. 18. 오후 6:38:07
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	List<ORDERVO> selectOrderList(RSVVO rsvVO);

	/** Sms/Email  */
	List<ORDERVO> selectSmsMailList(RSVVO rsvVO);

	/**
	 * 예약 마스터 조회
	 * 파일명 : selectByRsv
	 * 작성일 : 2015. 11. 19. 오전 11:11:40
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	RSVVO selectByRsv(RSVVO rsvVO);

	/**
	 * 예약 목록조회
	 * 파일명 : selectRsvList
	 * 작성일 : 2015. 11. 20. 오전 11:10:53
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	List<RSVVO> selectRsvList(RSVVO rsvVO);

	/**
	 * 사용자 쿠폰 조회
	 * 파일명 : selectUserCpList
	 * 작성일 : 2015. 11. 23. 오후 2:50:18
	 * 작성자 : 최영철
	 * @param userCpVO
	 * @return
	 */
	List<USER_CPVO> selectUserCpList(USER_CPVO userCpVO);


	/**
	 * 상품평을 남길 수 있는 구매 목록 조회
	 * 파일명 : selectRsvEpilList
	 * 작성일 : 2015. 11. 25. 오전 10:57:06
	 * 작성자 : 신우섭
	 * @param reVO
	 * @return
	 */
	List<RSVEPILVO> selectRsvEpilList(RSVEPILVO reVO);


	/**
	 * 상품평 남긴거 표시
	 * 파일명 : updateRsvEpil
	 * 작성일 : 2015. 11. 25. 오후 2:04:56
	 * 작성자 : 신우섭
	 * @param epVO
	 */
	void updateRsvEpil(RSVEPILVO epVO);

	/**
	 * 쿠폰 예약 처리
	 * 파일명 : updateUseCp
	 * 작성일 : 2015. 12. 4. 오후 4:39:42
	 * 작성자 : 최영철
	 * @param useCp
	 */
	void updateUseCp(USER_CPVO useCp);

	/**
	 * 예약시 사용한 쿠폰 리스트 조회
	 * 파일명 : selectUseCpList
	 * 작성일 : 2015. 12. 7. 오전 11:03:23
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	USER_CPVO selectUseCpList(ORDERVO rsvVO);


	LGPAYINFVO selectLGPAYINFO(String ID);

	LGPAYINFVO selectLGPAYINFO_V(RSVVO rsvVO);

	/**
	 * 결제완료 처리
	 * 파일명 : updateRsvComplete
	 * 작성일 : 2015. 12. 8. 오전 9:48:46
	 * 작성자 : 최영철
	 * @param lGPAYINFO
	 */
	void updateRsvComplete(LGPAYINFVO lGPAYINFO);

	/** 무통장입금 결제완료 처리*/
	void updateRsvCompleteCyberAccount(LGPAYINFVO lGPAYINFO);

	/**
	 * LG 결제정보 등록
	 * 파일명 : insertLDGINFO
	 * 작성일 : 2015. 12. 8. 오전 11:05:25
	 * 작성자 : 최영철
	 * @param lGPAYINFO
	 */
	void insertLDGINFO(LGPAYINFVO lGPAYINFO);

	/**
	 * 마이페이지 예약내역조회
	 * 파일명 : selectOrderList2
	 * 작성일 : 2015. 12. 8. 오후 3:43:11
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	List<ORDERVO> selectOrderList2(RSVVO rsvVO);
	List<ORDERVO> selectOrderList2Guest(RSVVO rsvVO);

	List<ORDERVO> selectOrderList2(RSV_HISSVO rsvHisSVO);
	List<ORDERVO> selectOrderList2Guest(RSV_HISSVO rsvHisSVO);

	/**
	* 설명 : 나의예약/구매 내역 web용 paging 처리 시 필요 (회원)
	* 파일명 : selectOrderList2Cnt
	* 작성일 : 25. 2. 3. 오전 11:18
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	Integer selectOrderList2Cnt(RSV_HISSVO rsvHisSVO);

	/**
	 * 설명 : 나의예약/구매 내역 web용 paging 처리 시 필요 (비회원)
	 * 파일명 : selectOrderList2GuestCnt
	 * 작성일 : 25. 2. 3. 오후 5:14
	 * 작성자 : chaewan.jung
	 * @param :
	 * @return :
	 * @throws Exception
	 */
	Integer selectOrderList2GuestCnt(RSV_HISSVO rsvHisSVO);

	/**
	 * 각 예약건 상태 변경
	 * 파일명 : updateDtlRsvStatus
	 * 작성일 : 2015. 12. 9. 오후 5:28:25
	 * 작성자 : 최영철
	 * @param orderVO
	 */
	void updateDtlRsvStatus(ORDERVO orderVO);

	/**
	 * 초기 결제 성공건 조회
	 * 파일명 : selectByPayInfo
	 * 작성일 : 2015. 12. 10. 오후 1:23:39
	 * 작성자 : 최영철
	 * @param payVO
	 * @return
	 */
	PAYVO selectByPayInfo(PAYVO payVO);

	/**
	 * 렌터카 예약테이블 취소 처리
	 * 파일명 : updateRcCancelDtlRsv
	 * 작성일 : 2015. 12. 10. 오후 3:39:52
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	void updateRcCancelDtlRsv(RC_RSVVO rcRsvVO);

	/**
	 * 예약취소시 사용자 쿠폰 반환처리
	 * 파일명 : cancelUserCp
	 * 작성일 : 2015. 12. 10. 오후 3:44:53
	 * 작성자 : 최영철
	 * @param prdtRsvNum	각 상세예약번호
	 */
	void cancelUserCp(String prdtRsvNum);

	/**
	 * 소셜상품 예약테이블 취소 처리
	 * 파일명 : updateSpCancelDtlRsv
	 * 작성일 : 2015. 12. 14. 오후 5:58:19
	 * 작성자 : 최영철
	 * @param spRsvVO
	 */
	void updateSpCancelDtlRsv(SP_RSVVO spRsvVO);

	/**
	 * 숙박 예약테이블 취소 처리
	 * 파일명 : updateAdCancelDtlRsv
	 * 작성일 : 2015. 12. 14. 오후 6:12:32
	 * 작성자 : 최영철
	 * @param adRsvVO
	 */
	void updateAdCancelDtlRsv(AD_RSVVO adRsvVO);

	/**
	 * 렌터카 이용내역 테이블 삭제
	 * 파일명 : deleteRcUseHist
	 * 작성일 : 2015. 12. 17. 오후 12:04:09
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	void deleteRcUseHist(RC_RSVVO rcRsvVO);

	/**
	 * 소셜상품 판매 수 감소 처리
	 * 파일명 : updateSpCntInfMin
	 * 작성일 : 2015. 12. 17. 오후 1:16:11
	 * 작성자 : 최영철
	 * @param spRsvVO
	 */
	void updateSpCntInfMin(SP_RSVVO spRsvVO);

	/**
	 * 숙박 판매 수량 감소 처리
	 * 파일명 : updateAdCntInfMin
	 * 작성일 : 2015. 12. 17. 오후 1:23:35
	 * 작성자 : 최영철
	 * @param rsvDtlVO
	 */
	void updateAdCntInfMin(AD_RSVVO rsvDtlVO);

	/**
	 * 사용자 예약내역 조회
	 * 파일명 : selectUserRsvList
	 * 작성일 : 2015. 12. 23. 오후 2:37:54
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	List<RSVVO> selectUserRsvList(RSVVO rsvVO);

	List<RSVVO> selectUserRsvListGuest(RSV_HISSVO rsvHisSVO);

	/**
	 * 환불 완료 처리
	 * 파일명 : refundComplete
	 * 작성일 : 2015. 12. 23. 오후 4:03:12
	 * 작성자 : 최영철
	 * @param orderVO
	 * @param request
	 * @throws Exception
	 */
	void refundComplete(ORDERVO orderVO, HttpServletRequest request) throws Exception;
	
	
	/**
	 * 예약건의 예약상태 변경
	 * Function : chgRsvStatus
	 * 작성일 : 2018. 2. 2. 오후 2:29:58
	 * 작성자 : 정동수
	 * @param rsvVO
	 */
	void chgRsvStatus(RSVVO rsvVO);



	/**
	 * 결제 완료되면 문자,메일 보내기
	 * 파일명 : orderCompleteSnedSMSMail
	 * 작성일 : 2015. 12. 30. 오후 4:56:20
	 * 작성자 : 신우섭
	 * @param rsvVO
	 * @param request
	 * @throws Exception
	 */
	void orderCompleteSnedSMSMail(RSVVO rsvVO, HttpServletRequest request);

	void orderCompleteSnedSMSMailResend(RSVVO rsvVO, HttpServletRequest request);

	/**
	 * 사용자 취소 요청시 문자 보내기
	 * 파일명 : reqCancelSnedSMS
	 * 작성일 : 2016. 1. 4. 오전 11:02:39
	 * 작성자 : 신우섭
	 * @param prdtRsvNum
	 */
	void reqCancelSnedSMS(String prdtRsvNum);

	/**
	 * 사용자 전체 취소 요청시 문자 보내기
	 * 파일명 : reqCancelSnedSMSAll
	 * 작성일 : 2016. 1. 5. 오전 11:49:27
	 * 작성자 : 신우섭
	 * @param rsvNum
	 */
	void reqCancelSnedSMSAll(String rsvNum);


	/**
	 * 자동 결제 취소시 문자/메일 전송
	 * 파일명 : cancelRsvAutoSnedSMSEmail
	 * 작성일 : 2016. 1. 4. 오후 2:23:20
	 * 작성자 : 신우섭
	 * @param prdtRsvNum
	 * @param request
	 */
	void cancelRsvAutoSnedSMSEmail(String prdtRsvNum, HttpServletRequest request);


	/**
	 * 환불완료시 문자/메일 전송
	 * 파일명 : refundCompleteSnedSMSEmail
	 * 작성일 : 2016. 1. 5. 오후 6:07:32
	 * 작성자 : 신우섭
	 * @param prdtRsvNum
	 * @param request
	 */
	void refundCompleteSnedSMSEmail(String prdtRsvNum, HttpServletRequest request);




	/**
	 * 카카오페이 결제 완료 처리
	 * 파일명 : updateRsvComplete2
	 * 작성일 : 2016. 1. 4. 오후 2:34:51
	 * 작성자 : 최영철
	 * @param kakaoPayInfVO
	 */
	void updateRsvComplete2(KAKAOPAYINFVO kakaoPayInfVO);
	
	/**
	 * 무료쿠폰 & L.Point 전체 결제 완료 처리
	 * Function : updateRsvComplete3
	 * 작성일 : 2017. 10. 23. 오전 11:40:26
	 * 작성자 : 정동수
	 * @param rsvVO
	 */
	void updateRsvComplete3(RSVVO rsvVO);

	/** 탐나는전 결제완료 처리*/
	void updateRsvComplete4(RSVVO rsvVO);

	/**
	 * 카카오페이 결제정보 등록
	 * 파일명 : insertKakaoPayInf
	 * 작성일 : 2016. 1. 4. 오후 2:47:50
	 * 작성자 : 최영철
	 * @param kakaoPayInfVO
	 */
	void insertKakaoPayInf(KAKAOPAYINFVO kakaoPayInfVO);

	/**
	 * 상품예약번호 상세
	 * @param orderVO
	 * @return
	 */
	ORDERVO selectUserRsvFromPrdtRsvNum(ORDERVO orderVO);

	/**
	 * 판매통계 MERGE
	 * 파일명 : mergeSaleAnls
	 * 작성일 : 2016. 1. 18. 오전 9:59:59
	 * 작성자 : 최영철
	 * @param prdtNum
	 */
	void mergeSaleAnls(String prdtNum);

	/**
	 * 판매통계 감소 처리
	 * 파일명 : downSaleAnls
	 * 작성일 : 2016. 1. 18. 오전 10:24:31
	 * 작성자 : 최영철
	 * @param prdtNum
	 */
	void downSaleAnls(String prdtNum);

	/**
	 * 판매통계 취소 처리 - 상세예약번호 별
	 * 파일명 : downSaleAnlsByDtlRsv
	 * 작성일 : 2016. 11. 8. 오후 12:09:00
	 * 작성자 : 최영철
	 * @param dtlRsvNum
	 */
	void downSaleAnlsByDtlRsv(String dtlRsvNum);

	/**
	 * 관광기념품 예약 처리
	 * @param svRsvVO
	 * @return
	 */
	String insertSvRsv(SV_RSVVO svRsvVO);

	/**
	 * 배송지 변경
	 * @param rsvVO
	 */
	void changeDlv(RSVVO rsvVO);

	/**
	 * 최근 주문 배송지
	 * @param rsvVO
	 * @return
	 */
	RSVVO orderRecentDlv(RSVVO rsvVO);

	/**
	 * 구매확정
	 * @param svRsvNum
	 */
	void confirmOrder(String svRsvNum);

	/**
	 * 관광기념품 예약테이블 취소 처리
	 * 파일명 : updateSvCancelDtlRsv
	 * 작성일 : 2016. 10. 14. 오후 3:30:39
	 * 작성자 : 최영철
	 * @param svRsvVO
	 */
	void updateSvCancelDtlRsv(SV_RSVVO svRsvVO);

	/**
	 * 관광기념품 판매 수량 제어
	 * 파일명 : updateSvCntInfMin
	 * 작성일 : 2016. 10. 14. 오후 3:34:45
	 * 작성자 : 최영철
	 * @param rsvDtlVO
	 */
	void updateSvCntInfMin(SV_RSVVO rsvDtlVO);

	/**
	 * 관광기념품 배송정보 입력 시 문자/메일 전송
	 * Function : dlvNumSnedSMSEmail
	 * 작성일 : 2016. 10. 28. 오후 6:26:34
	 * 작성자 : 정동수
	 * @param svRsvNum
	 * @param request
	 */
	void dlvNumSnedSMSEmail(String svRsvNum, HttpServletRequest request);

	/**
	 * APL배송일 경우 배송비 업데이트
	 * @param svRsvVO
	 */
	void updateSvRsvDlvAmt(SV_RSVVO svRsvVO);

	void updateSvRsvDlvPoint(SV_RSVVO svRsvVO);

	/**
	 * 숙박 자동취소 처리
	 * 파일명 : updateAdAcc
	 * 작성일 : 2016. 11. 8. 오후 1:47:51
	 * 작성자 : 최영철
	 * @param adRsvVO
	 */
	void updateAdAcc(AD_RSVVO adRsvVO);

	/**
	 * 렌터카 자동취소 처리
	 * 파일명 : updateRcAcc
	 * 작성일 : 2016. 11. 8. 오후 1:55:29
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	void updateRcAcc(RC_RSVVO rcRsvVO) throws IOException;

	/**
	 * 소셜 자동 취소 처리
	 * 파일명 : updateSpAcc
	 * 작성일 : 2016. 11. 8. 오후 2:04:37
	 * 작성자 : 최영철
	 * @param spRsvVO
	 */
	void updateSpAcc(SP_RSVVO spRsvVO);

	/**
	 * 기념품 자동 취소 처리
	 * 파일명 : updateSvAcc
	 * 작성일 : 2016. 11. 8. 오후 2:09:52
	 * 작성자 : 최영철
	 * @param svRsvVO
	 */
	void updateSvAcc(SV_RSVVO svRsvVO);

	/**
	 * 예약 자동취소처리
	 * 파일명 : updateAcc
	 * 작성일 : 2016. 11. 8. 오후 2:17:11
	 * 작성자 : 최영철
	 * @param rsvVO
	 */
	void updateAcc(RSVVO rsvVO);

	/**
	 * L.Point 사용 취소 처리
	 * 파일명 : updateLpointCancel
	 * 작성일 : 2017. 9. 5. 오전 11:44:21
	 * 작성자 : 정동수
	 * @param rsvVO
	 */
	void updateLpointCancel(RSVVO rsvVO);

	/**
	 * 예약번호에 따른 L.Point 사용 정보
	 * 파일명 : selectLpointUsePoint
	 * 작성일 : 2017. 9. 8. 오후 3:53:42
	 * 작성자 : 정동수
	 * @param lpointUseInfVO
	 */
	LPOINTUSEINFVO selectLpointUsePoint(LPOINTUSEINFVO lpointUseInfVO);

	/**
	 * L.Point 사용 등록
	 * 파일명 : insertLpointUsePoint
	 * 작성일 : 2017. 9. 7. 오후 11:00:12
	 * 작성자 : 정동수
	 * @param lpointUseInfVO
	 */
	void insertLpointUsePoint(LPOINTUSEINFVO lpointUseInfVO);

	/**
	 * L.Point 사용 취소
	 * 파일명 : cancelLpointUsePoint
	 * 작성일 : 2017. 9. 7. 오후 11:00:35
	 * 작성자 : 정동수
	 * @param lpointUseInfVO
	 */
	void cancelLpointUsePoint(LPOINTUSEINFVO lpointUseInfVO);

	/**
	 * L.Point 일괄 적립 리스트
	 * 파일명 : selectLpointSaveList
	 * 작성일 : 2017. 9. 10. 오후 21:58:12
	 * 작성자 : 정동수
	 * @param
	 * @return List<LPOINTSAVEINFVO>
	 */
	List<LPOINTSAVEINFVO> selectLpointSaveList();

	/**
	 * L.Point 적립 카드번호 등록
	 * 파일명 : insertLpointCardNum
	 * 작성일 : 2017. 9. 7. 오후 11:01:22
	 * 작성자 : 정동수
	 * @param lpointSaveInfVO
	 */
	void insertLpointCardNum(LPOINTSAVEINFVO lpointSaveInfVO);

	/**
	 * L.Point 적립 예약 취소 처리
	 * 파일명 : updateLpointRsvCancel
	 * 작성일 : 2017. 9. 10. 오후 10:46:45
	 * 작성자 : 정동수
	 * @param lpointSaveInfVO
	 */
	void updateLpointRsvCancel(LPOINTSAVEINFVO lpointSaveInfVO);

	/**
	 * L.Point 적립 처리
	 * 파일명 : updateLpointSave
	 * 작성일 : 2017. 9. 7. 오후 11:01:22
	 * 작성자 : 정동수
	 * @param lpointSaveInfVO
	 */
	void updateLpointSave(LPOINTSAVEINFVO lpointSaveInfVO);

	/**
	 * 이벤트 코드 확인
	 * 파일명 : evntCdConfirm
	 * 작성일 : 2017. 3. 13. 오전 10:10:32
	 * 작성자 : 최영철
	 * @param evntInfVO
	 * @return
	 */
	String evntCdConfirm(EVNTINFVO evntInfVO);

	/*미결제 조회*/
	List<RSVVO> selectUnpaidRsvList(RSVVO rsvVO);

	/** MMS 메시지 조회 */
	List<MMSVO> selectListMMSmsg(MMSVO mmsVO);

	/**
	* 설명 : 관리자 직접 예약 시 관광기념품 예약 처리
	* 파일명 :
	* 작성일 : 2021-06-22 오전 9:54
	* 작성자 : chaewan.jung
	* @param : svRsvVO
	* @return : String
	* @throws Exception
	*/
	String insertSvAdminRsv(SV_RSVVO svRsvVO);

	void updateRsvTamnacardRefInfo(RSVVO rsvvo);

	/**
	* 설명 : 에스크로 배송결과등록 프로그램 연동
	* 파일명 : escrowResp
	* 작성일 : 2021-09-07 오전 10:11
	* 작성자 : chaewan.jung
	* @param : request
	* @return : boolean
	* @throws Exception
	*/
	boolean escrowResp(HttpServletRequest request);

	/**
	* 설명 : 에스크로 처리결과 수신 insert
	* 파일명 : insertEscrowReceive
	* 작성일 : 2021-09-03 오전 11:32
	* 작성자 : chaewan.jung
	* @param : escrowVO
	* @return : void
	* @throws Exception
	*/
	void insertEscrowReceive(ESCROWVO escrowVO);

	void insertTamnacardInfo(TAMNACARD_VO tamnacardVo);

	TAMNACARD_VO selectTamnacardInfo(TAMNACARD_VO tamnacardVo);

	String tamnacardCompanyUseYn(String corpId);

	String tamnacardPrdtUseYn(String prdtNum);

	/**
	* 설명 : 에스크로 특산/기념품 취소요청상태로 변경
	* 파일명 :
	* 작성일 : 2023-05-18 오후 2:25
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	void updateSvRsvCancelReq(String svRsvNum);
	
	/**
	* 설명 : 마라톤 신청인원등록
	* 파일명 : insertMrtnUser
	* 작성일 : 2023-11-23 오전 11:00
	* 작성자 : 
	* @param :
	* @return :
	* @throws Exception
	*/
	void insertMrtnUser(MRTNVO mrtnVO);
	
	/**
	* 설명 : 마라톤 신청인원등록
	* 파일명 : selectTshirtsCntVO
	* 작성일 : 2023-11-27 오전 09:50
	* 작성자 : 
	* @param :
	* @return :
	* @throws Exception
	*/
	MRTNVO selectTshirtsCntVO(MRTNVO mrtnSVO);
	
	/**
	* 설명 : 마라톤 티셔츠 수량 원복처리
	* 파일명 : selectTshirtsCntVO
	* 작성일 : 2023-11-28 오전 09:50
	* 작성자 : 
	* @param :
	* @return :
	* @throws Exception
	*/
	void updateReturnTshirtsCnt(MRTNVO mrtnVO);
}
