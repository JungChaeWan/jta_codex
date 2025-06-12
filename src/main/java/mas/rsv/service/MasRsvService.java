package mas.rsv.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import mas.rsv.vo.SP_RSVHISTVO;
import web.order.vo.AD_RSVVO;
import web.order.vo.ORDERVO;
import web.order.vo.PAYVO;
import web.order.vo.RC_RSVVO;
import web.order.vo.RSVSVO;
import web.order.vo.RSVVO;
import web.order.vo.SP_RSVVO;
import web.order.vo.SV_RSVVO;




public interface MasRsvService {

	/**
	 * 렌터카 예약 내역 조회
	 * 파일명 : selectRcRsvList
	 * 작성일 : 2015. 11. 30. 오후 3:42:48
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	Map<String, Object> selectRcRsvList(RSVSVO rsvSVO);

	/**
	 * 렌터카 예약 내역 전체 조회
	 * 파일명 : selectRcRsvListAll
	 * 작성일 : 2017. 8. 7. 오전 9:55:15
	 * 작성자 : 정동수
	 * @param rsvSVO
	 * @return
	 */
	List<RC_RSVVO> selectRcRsvListAll(RSVSVO rsvSVO);

	/**
	 * 숙박 예약 내역 조회
	 * 파일명 : selectAdRsvList
	 * 작성일 : 2015. 12. 1. 오전 9:36:24
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	Map<String, Object> selectAdRsvList(RSVSVO rsvSVO);

	/**
	 * 숙박 예약 내역 전체 조회
	 * 파일명 : selectAdRsvListAll
	 * 작성일 : 2017. 8. 2. 오후 5:55:15
	 * 작성자 : 정동수
	 * @param rsvSVO
	 * @return
	 */
	List<AD_RSVVO> selectAdRsvListAll(RSVSVO rsvSVO);

	/**
	 * 렌터카 예약 상세
	 * 파일명 : selectRcDetailRsv
	 * 작성일 : 2015. 12. 10. 오전 10:17:11
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 * @return
	 */
	RC_RSVVO selectRcDetailRsv(RC_RSVVO rcRsvVO);

	/**
	 * LG U+ 부분취소처리
	 * 파일명 : partialCancelPay
	 * 작성일 : 2015. 12. 10. 오후 1:16:45
	 * 작성자 : 최영철
	 * @param payVO
	 * @param refundAmt		철회금액
	 * @param rsvNum		예약번호
	 * @param dtlRsvNum		상세예약번호
	 * @param payDiv		취소 구분
	 * @return
	 */
	PAYVO partialCancelPay(PAYVO payVO, String rsvNum, String dtlRsvNum, String refundAmt, String payDiv);

	PAYVO partialCancelPayCyberAccount(PAYVO payVO, String rsvNum, String dtlRsvNum, String refundAmt, String payDiv, String LGD_RFBANKCODE, String LGD_RFACCOUNTNUM, String LGD_RFCUSTOMERNAME);

	/**
	 * 소셜 예약 내역 조회
	 * @param rsvSVO
	 * @return
	 */
	Map<String, Object> selectSpRsvList(RSVSVO rsvSVO);

	SP_RSVVO selectSpDetailRsv(SP_RSVVO spRsvVO);


	/**
	 * 숙소 예약 상세
	 * 파일명 : selectAdDetailRsv
	 * 작성일 : 2015. 12. 12. 오전 11:59:40
	 * 작성자 : 신우섭
	 * @param adRsvVO
	 * @return
	 */
	AD_RSVVO selectAdDetailRsv(AD_RSVVO adRsvVO);
	/**
	 * 취소처리
	 * 파일명 : cancelPay
	 * 작성일 : 2015. 12. 14. 오후 1:11:17
	 * 작성자 : 최영철
	 * @param payDiv
	 * @param rsvNum
	 * @param rcRsvNum
	 * @param saleAmt
	 * @return
	 * @throws ParseException
	 */
	Map<String, Object> cancelPay(String payDiv, String rsvNum, String rcRsvNum, String saleAmt, String userIp, String LGD_RFBANKCODE, String LGD_RFACCOUNTNUM, String LGD_RFCUSTOMERNAME) throws ParseException;

	/**
	 * 예약 취소 시 업데이트 처리
	 * 파일명 : updateCancelRsv
	 * 작성일 : 2015. 12. 14. 오후 2:19:25
	 * 작성자 : 최영철
	 * @param rsvVO
	 */
	void updateCancelRsv(RSVVO rsvVO);

	/**
	 * 소셜 상품 예약 일 경우 관리자 메모  update
	 * @param spRsvVO
	 */
	void updateRsvAdmMemo(SP_RSVVO spRsvVO);

	/**
	 * 소셜상품 예약 사용내역 리스트.
	 * @param spRsvVO
	 * @return
	 */
	List<SP_RSVHISTVO> selectSpRsvHistList(SP_RSVVO spRsvVO);

	/**
	 * 소셜상품 예약 사용내역 등록
	 * @param sp_RSVHISTVO
	 */
	void insertSpRsvhist(SP_RSVHISTVO sp_RSVHISTVO);

	/**
	 * 소셜 사용일시 update
	 * @param
	 */
	void updateSpUseDttm(SP_RSVVO spRsvVO);


	AD_RSVVO selectAdRsv(AD_RSVVO adRsvVO);


	int getCntRsvMainToday(RSVSVO rsvSVO);
	int getCntRsvMainCalPay(RSVSVO rsvSVO);
	int getCntRsvMainTotPay(RSVSVO rsvSVO);
	long getAmtRsvMainTot(RSVSVO rsvSVO);
	long getAmtRsvMainTotCal(RSVSVO rsvSVO);

	/**
	 * 예약확인 처리
	 * 파일명 : updateRsvIdt
	 * 작성일 : 2016. 2. 25. 오후 1:54:17
	 * 작성자 : 최영철
	 * @param orderVO
	 */
	void updateRsvIdt(ORDERVO orderVO);

	/**
	 * 소셜 구분자 옵션에 따른 예약존재확인
	 * 파일명 : selectSpRsvList2
	 * 작성일 : 2016. 3. 10. 오전 10:26:21
	 * 작성자 : 최영철
	 * @param spRsvVO
	 * @return
	 */
	List<SP_RSVVO> selectSpRsvList2(SP_RSVVO spRsvVO);

	/**
	 * 입점업체 소셜 예약 엑셀 다운로드용 조회
	 * 파일명 : selectSpRsvExcelList
	 * 작성일 : 2016. 5. 3. 오전 9:38:58
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	List<SP_RSVVO> selectSpRsvExcelList(RSVSVO rsvSVO);

	/**
	 * 소셜(관광지)의 QR 코드 리스트 조회
	 * Function : selectSpRsvQrList
	 * 작성일 : 2016. 10. 25. 오후 3:31:56
	 * 작성자 : 정동수
	 * @param
	 * @return
	 */
	Map<String, Object> selectSpRsvQrList(SP_RSVVO spRsvVO);

	/**
	 * 관광지 기념품 옵션에 따른 예약존재확인.
	 * @param svRsvVO
	 * @return
	 */
	List<SV_RSVVO> selectSvRsvList2(SV_RSVVO svRsvVO);

	/**
	 * 제주특산품 구매 리스트
	 * @param rsvSVO
	 * @return
	 */
	Map<String, Object> selectSvRsvList(RSVSVO rsvSVO);

	/**
	 * 제주 특산품 구매 상세
	 * @param svRsvVO
	 * @return
	 */
	SV_RSVVO selectSvDetailRsv(SV_RSVVO svRsvVO);

	/**
	 * 운송장번호 입력
	 * @param svRsvVO
	 */
	void updateDlvNum(SV_RSVVO svRsvVO);

	/**
	 * 운송장번호 초기화
	 * @param svRsvNum
	 * @return
	 */
	int resetDlvNum(String svRsvNum);
	/**
	 * 입점업체 기념품 예약 엑셀 다운로드용 조회
	 * 파일명 : selectSvRsvExcelList
	 * 작성일 : 2017. 1. 11. 오후 5:08:07
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	List<SV_RSVVO> selectSvRsvExcelList(RSVSVO rsvSVO);


	/**
	 * 상품수령
	 * 파일명 : updateSVdirectRecvComp
	 * 작성일 : 2017. 8. 31. 오전 10:26:48
	 * 작성자 : 신우섭
	 * @param svRsvVO
	 */
	void updateSVDirectRecvComp(SV_RSVVO svRsvVO);
}
