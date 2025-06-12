package mas.rsv.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import mas.rsv.vo.SP_RSVHISTVO;
import org.springframework.stereotype.Repository;
import oss.user.vo.REFUNDACCINFVO;
import web.order.vo.*;

import java.util.List;


@Repository("rsvDAO")
public class RsvDAO extends EgovAbstractDAO {

	/**
	 * 렌터카 예약내역 조회
	 * 파일명 : selectRcRsvList
	 * 작성일 : 2015. 11. 30. 오후 3:46:02
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RC_RSVVO> selectRcRsvList(RSVSVO rsvSVO) {
		return (List<RC_RSVVO>) list("RC_RSV_S_01", rsvSVO);
	}

	/**
	 * 렌터카 예약내역 카운트
	 * 파일명 : getCntRcRsvList
	 * 작성일 : 2015. 11. 30. 오후 3:46:20
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	public Integer getCntRcRsvList(RSVSVO rsvSVO) {
		return (Integer) select("RC_RSV_S_02", rsvSVO);
	}

	/**
	 * 숙박 예약내역 조회
	 * 파일명 : selectAdRsvList
	 * 작성일 : 2015. 12. 1. 오전 9:37:19
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_RSVVO> selectAdRsvList(RSVSVO rsvSVO) {
		return (List<AD_RSVVO>) list("AD_RSV_S_01", rsvSVO);
	}


	public AD_RSVVO selectAdRsv(AD_RSVVO adRsvVO) {
		return (AD_RSVVO)select("AD_RSV_S_00", adRsvVO);
	}

	@SuppressWarnings("unchecked")
	public List<AD_RSVVO> selectAdRsvListFromRsvNum(AD_RSVVO adRsvVO) {
		return (List<AD_RSVVO>) list("AD_RSV_S_00", adRsvVO);
	}


	/**
	 * 숙박 예약 내역 카운트
	 * 파일명 : getCntAdRsvList
	 * 작성일 : 2015. 12. 1. 오전 9:37:43
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	public Integer getCntAdRsvList(RSVSVO rsvSVO) {
		return (Integer) select("AD_RSV_S_02", rsvSVO);
	}

	/**
	 * 렌터카 예약상세
	 * 파일명 : selectRcDetailRsv
	 * 작성일 : 2015. 12. 10. 오전 10:18:45
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 * @return
	 */
	public RC_RSVVO selectRcDetailRsv(RC_RSVVO rcRsvVO) {
		return (RC_RSVVO) select("RC_RSV_S_03", rcRsvVO);
	}

	/**
	 * 소셜 예약 내역 조회
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SP_RSVVO> selectSpRsvList(RSVSVO rsvSVO) {
		return (List<SP_RSVVO>) list("SP_RSV_S_01", rsvSVO);
	}

	public SP_RSVVO selectSpRsv(SP_RSVVO rsvVO) {
		return (SP_RSVVO) select("SP_RSV_S_00", rsvVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_RSVVO> selectSpRsvList2(SP_RSVVO rsvVO) {
		return (List<SP_RSVVO>) list("SP_RSV_S_00", rsvVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_RSVVO> selectSpRsvList3(SP_RSVVO rsvVO) {
		return (List<SP_RSVVO>) list("SP_RSV_S_08", rsvVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_RSVVO> selectSpRsvQrList(SP_RSVVO spRsvVO) {
		return (List<SP_RSVVO>) list("SP_RSV_S_06", spRsvVO);
	}

	/**
	 * 소셜 예약 내역 카운트
	 * @param rsvSVO
	 * @return
	 */
	public Integer getCntSpRsvList(RSVSVO rsvSVO) {
		return (Integer) select("SP_RSV_S_02", rsvSVO);
	}

	/**
	 * 소셜 예약 상세
	 * @param spRsvVO
	 * @return
	 */
	public SP_RSVVO selectSpDetailRsv(SP_RSVVO spRsvVO) {
		return (SP_RSVVO) select("SP_RSV_S_03", spRsvVO);
	}


	/**
	 * 숙소 예약 상세
	 * 파일명 : selectAdDetailRsv
	 * 작성일 : 2015. 12. 12. 오전 11:58:22
	 * 작성자 : 신우섭
	 * @param adRsvVO
	 * @return
	 */
	public AD_RSVVO selectAdDetailRsv(AD_RSVVO adRsvVO) {
		return (AD_RSVVO) select("AD_RSV_S_03", adRsvVO);
	}

	/**
	 * 통합 예약 내역 리스트 조회
	 * 파일명 : selectRsvList
	 * 작성일 : 2015. 12. 11. 오전 10:21:09
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RSVVO> selectRsvList(RSVSVO rsvSVO) {
		return (List<RSVVO>) list("RSV_S_05", rsvSVO);
	}

	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectDtlRsvList(RSVSVO rsvSVO) {
		return (List<ORDERVO>) list("RSV_S_07", rsvSVO);
	}

	public Integer getCntRsvList(RSVSVO rsvSVO) {
		return (Integer) select("RSV_S_06", rsvSVO);
	}


	public Integer getCntRsvMainToday(RSVSVO rsvSVO) {
		return (Integer) select("RSV_S_10", rsvSVO);
	}

	public Integer getCntRsvMainCalPay(RSVSVO rsvSVO) {
		return (Integer) select("RSV_S_11", rsvSVO);
	}

	public Integer getCntRsvMainTotPay(RSVSVO rsvSVO) {
		return (Integer) select("RSV_S_12", rsvSVO);
	}

	public Long getAmtRsvMainTot(RSVSVO rsvSVO) {
		return (Long) select("RSV_S_13", rsvSVO);
	}
	public Integer getAmtRsvMainTotCal(RSVSVO rsvSVO) {
		return (Integer) select("RSV_S_14", rsvSVO);
	}

	public Integer getRsvOssMain(RSVVO rsvVO) {
		return (Integer) select("RSV_S_16", rsvVO);
	}

	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectUseCompleteMailList() {
		return (List<ORDERVO>) list("RSV_S_23");
	}
	
	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectTourPrev7MailList() {
		return (List<ORDERVO>) list("RSV_S_28");
	}
	
	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectTourPrev7RsvList() {
		return (List<ORDERVO>) list("RSV_S_29");
	}

	public void updateCancelRsv(RSVVO rsvVO) {
		update("RSV_U_05", rsvVO);
	}

	public void updateRsvAdmMemo(SP_RSVVO spRsvVO) {
		update("SP_RSV_U_03", spRsvVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_RSVHISTVO> selectSpRsvHistList(SP_RSVVO spRsvVO) {
		return (List<SP_RSVHISTVO>) list("SP_RSVHIST_S_00", spRsvVO);
	}

	public void insertSpRsvhist(SP_RSVHISTVO sp_RSVHISTVO) {
		insert("SP_RSVHIST_I_00", sp_RSVHISTVO);
	}

	public void updateSpUseDttm(SP_RSVVO spRsvVO) {
		update("SP_RSV_U_04", spRsvVO);
	}

	/**
	 * 환불요청건 리스트 조회
	 * 파일명 : selectRefundList
	 * 작성일 : 2016. 1. 17. 오후 1:38:23
	 * 작성자 : 최영철
	 * @param orderSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectRefundList(ORDERSVO orderSVO) {
		return (List<ORDERVO>) list("RSV_S_15", orderSVO);
	}

	/**
	 * 환불요청건 리스트 카운트
	 * 파일명 : getCntRefundList
	 * @param orderSVO
	 * @return
	 */
	public Integer getCntRefundList(ORDERSVO orderSVO) {
		return (Integer) select("RSV_S_32", orderSVO);
	}	

	/**
	 * 환불요청건 단건 조회
	 * 파일명 : selectByPrdtRsvInfo
	 * 작성일 : 2016. 1. 22. 오후 3:18:42
	 * 작성자 : 최영철
	 * @param orderSVO
	 * @return
	 */
	public ORDERVO selectByPrdtRsvInfo(ORDERSVO orderSVO) {
		return (ORDERVO) select("RSV_S_15", orderSVO);
	}

	/**
	 * 예약환불정보 등록
	 * 파일명 : insertRefundInfo
	 * 작성일 : 2016. 1. 22. 오후 4:46:08
	 * 작성자 : 최영철
	 * @param orderVO
	 */
	public void updateRefundInfo(ORDERVO orderVO) {
		update("RSV_U_07", orderVO);
	}

	/**
	 * 환불사유 등록
	 */
	public void updateRefundRsn(ORDERVO orderVO) {
		update("RSV_U_12", orderVO);
	}

	/**
	 * 환불계좌정보 등록
	 * 파일명 : mergeAccNum
	 * 작성일 : 2016. 1. 28. 오전 11:08:06
	 * 작성자 : 최영철
	 * @param refundAccInfVO
	 */
	public void mergeAccNum(REFUNDACCINFVO refundAccInfVO) {
		update("REFUNDACCINF_M_00", refundAccInfVO);
	}

	/**
	 * 예약확인처리
	 * 파일명 : updateRsvIdt
	 * 작성일 : 2016. 2. 25. 오후 1:55:27
	 * 작성자 : 최영철
	 * @param orderVO
	 */
	public void updateRsvIdt(ORDERVO orderVO) {
		update("RC_RSV_U_06", orderVO);
		update("AD_RSV_U_06", orderVO);
		update("SP_RSV_U_09", orderVO);
	}

	/**
	 * 상품별 예약 리스트
	 * 파일명 : selectRsvAtPrdtList
	 * 작성일 : 2016. 3. 2. 오후 2:40:52
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectRsvAtPrdtList(RSVSVO rsvSVO) {
		return (List<ORDERVO>) list("RSV_S_17", rsvSVO);
	}

	/**
	 * 상품별 예약 리스트 카운트
	 * 파일명 : getCntRsvAtPrdtList
	 * 작성일 : 2016. 3. 2. 오후 2:42:05
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	public Integer getCntRsvAtPrdtList(RSVSVO rsvSVO) {
		return (Integer) select("RSV_S_18", rsvSVO);
	}

	/**
	 * 상품별 예약 리스트 전체 조회
	 * 파일명 : selectRsvAtPrdtListAll
	 * 작성일 : 2016. 3. 2. 오후 3:39:28
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectRsvAtPrdtListAll(RSVSVO rsvSVO) {
		return (List<ORDERVO>) list("RSV_S_19", rsvSVO);
	}

	/**
	 * 입점업체 소셜 예약 엑셀 다운로드용 조회
	 * 파일명 : selectSpRsvExcelList
	 * 작성일 : 2016. 5. 3. 오전 9:39:51
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SP_RSVVO> selectSpRsvExcelList(RSVSVO rsvSVO) {
		return (List<SP_RSVVO>) list("SP_RSV_S_05", rsvSVO);
	}

	/**
	 * 기념품 구분자 옵션에 따른 예약존재 확인.
	 * @param svRsvVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SV_RSVVO> selectSvRsvList2(SV_RSVVO svRsvVO) {
		return (List<SV_RSVVO>) list("SV_RSV_S_00", svRsvVO);
	}

	/**
	 * 항공 예약 검색 리스트
	 * Function : selectAvRsvList
	 * 작성일 : 2016. 9. 2. 오후 5:21:40
	 * 작성자 : 정동수
	 * @param avRsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AV_RSVVO> selectAvRsvList(AV_RSVSVO avRsvSVO) {
		return (List<AV_RSVVO>) list("AV_RSV_S_00", avRsvSVO);
	}

	/**
	 * 항공 예약 검색 건수
	 * Function : getCntAvRsvList
	 * 작성일 : 2016. 9. 2. 오후 5:42:21
	 * 작성자 : 정동수
	 * @param avRsvSVO
	 * @return
	 */
	public Integer getCntAvRsvList(AV_RSVSVO avRsvSVO) {
		return (Integer) select("AV_RSV_S_01", avRsvSVO);
	}

	/**
	 * 항공 예약의 Excel 파일 업로드 등록
	 * Function : insertAvRsvExcel
	 * 작성일 : 2016. 8. 30. 오후 2:31:13
	 * 작성자 : 정동수
	 * @param avRsvVO
	 */
	public void insertAvRsvExcel(AV_RSVVO avRsvVO) {
		insert("AV_RSV_I_00", avRsvVO);
	}

	/**
	 * 기념품 구매 리스트
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SV_RSVVO> selectSvRsvList(RSVSVO rsvSVO) {
		return (List<SV_RSVVO>) list("SV_RSV_S_01", rsvSVO);
	}

	/**
	 * 기념품 구매 리스트 카운트
	 * @param rsvSVO
	 * @return
	 */
	public Integer getCntSvRsvList(RSVSVO rsvSVO) {
		return (Integer) select("SV_RSV_S_02", rsvSVO);
	}

	/**
	 * 기념품 구매 상세
	 * @param svRsvVO
	 * @return
	 */
	public SV_RSVVO selectSvDetailRsv(SV_RSVVO svRsvVO) {
		return (SV_RSVVO) select("SV_RSV_S_03", svRsvVO);
	}

	public void updateDlvNum(SV_RSVVO svRsvVO) {
		update("SV_RSV_U_10", svRsvVO);
	}

	public int resetDlvNum(String svRsvNum) {
		return update("SV_RSV_U_18", svRsvNum);
	}

	/**
	 * 상품수령
	 * 파일명 : updateSVdirectRecvComp
	 * 작성일 : 2017. 8. 31. 오전 10:25:54
	 * 작성자 : 신우섭
	 * @param svRsvVO
	 */
	public void updateSVDirectRecvComp(SV_RSVVO svRsvVO) {
		update("SV_RSV_U_13", svRsvVO);
	}

	public void updateSVDlvDone(String svRsvnum) {
		update("SV_RSV_U_15", svRsvnum);
	}

	/**
	 * 렌터카 연계 여부 처리
	 * 파일명 : updateRcLinkYn
	 * 작성일 : 2016. 12. 15. 오전 10:39:45
	 * 작성자 : 최영철
	 * @param rsvDtlVO
	 */
	public void updateRcLinkYn(RC_RSVVO rsvDtlVO) {
		update("RC_RSV_U_07", rsvDtlVO);
	}

	/**
	 * 기념품 상품별 예약 리스트 조회
	 * 파일명 : selectRsvAtSvPrdtList
	 * 작성일 : 2016. 12. 26. 오후 5:24:36
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectRsvAtSvPrdtList(RSVSVO rsvSVO) {
		return (List<ORDERVO>) list("RSV_S_24", rsvSVO);
	}

	/**
	 * 기념품 상품별 예약 리스트 카운트
	 * 파일명 : getCntRsvAtSvPrdtList
	 * 작성일 : 2016. 12. 26. 오후 5:26:49
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	public Integer getCntRsvAtSvPrdtList(RSVSVO rsvSVO) {
		return (Integer) select("RSV_S_25", rsvSVO);
	}

	/**
	 * 기념품 상품별 예약 조회 엑셀 다운로드용
	 * 파일명 : selectRsvAtSvPrdtListAll
	 * 작성일 : 2016. 12. 27. 오전 11:19:40
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ORDERVO> selectRsvAtSvPrdtListAll(RSVSVO rsvSVO) {
		return (List<ORDERVO>) list("RSV_S_26", rsvSVO);
	}

	/**
	 * 입점업체 기념품 예약 엑셀 다운로드용 조회
	 * 파일명 : selectSvRsvExcelsList
	 * 작성일 : 2017. 1. 11. 오후 5:10:34
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SV_RSVVO> selectSvRsvExcelsList(RSVSVO rsvSVO) {
		return (List<SV_RSVVO>) list("SV_RSV_S_05", rsvSVO);
	}

	/**
	* 설명 : 관리자 직접 예약 시 예약처리 후 금액 합계 처리
	* 파일명 :
	* 작성일 : 2023-04-03 오후 3:35
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void updateToTalAmt(RSVVO rsvVO) {
		update("RSV_U_13", rsvVO);
	}
	
	//현대캐피탈 ONE-CARD 전기차 이벤트
	public void insertHcOneCard(RSVVO rsvvo) {
		insert("RSV_HCONECARD_I_00", rsvvo);
	}
}
