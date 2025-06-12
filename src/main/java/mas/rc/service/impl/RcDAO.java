package mas.rc.service.impl;

import java.util.HashMap;
import java.util.List;

import mas.rc.vo.RC_AMTINFVO;
import mas.rc.vo.RC_CARDIVSVO;
import mas.rc.vo.RC_CARDIVVO;
import mas.rc.vo.RC_CNTINFVO;
import mas.rc.vo.RC_DFTINFVO;
import mas.rc.vo.RC_DISPERINFVO;
import mas.rc.vo.RC_PRDTCNTVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rc.vo.RC_RSVCHARTSVO;
import mas.rc.vo.RC_RSVCHARTVO;

import org.springframework.stereotype.Repository;

import web.order.vo.RC_RSVVO;
import web.order.vo.RSVSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


/**
 * 렌트카 관련 DAO
 * 파일명 : RcDAO.java
 * 작성일 : 2015. 9. 21. 오후 6:29:12
 * 작성자 : 최영철
 */
@Repository("rcDAO")
public class RcDAO extends EgovAbstractDAO {

	public RC_DFTINFVO selectByRcInfo(RC_DFTINFVO rcVO) {
		return (RC_DFTINFVO) select("RC_DFTINF_S_00", rcVO);
	}

	public void mergeRcDftInfo(RC_DFTINFVO dftInfFVO) {
		update("RC_DFTINF_M_00", dftInfFVO);
	}

	/**
	 * 렌트카 상품 리스트 조회 - 페이징
	 * 파일명 : selectRcPrdtList
	 * 작성일 : 2015. 10. 6. 오전 9:29:22
	 * 작성자 : 최영철
	 * @param prdtInfSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RC_PRDTINFVO> selectRcPrdtList(RC_PRDTINFSVO prdtInfSVO) {
		return (List<RC_PRDTINFVO>) list("RC_PRDTINF_S_01", prdtInfSVO);
	}

	public Integer getCntRcPrdtList(RC_PRDTINFSVO prdtInfSVO) {
		return (Integer) select("RC_PRDTINF_S_02", prdtInfSVO);
	}

	/**
	 * 상품 등록
	 * 파일명 : insertPrdt
	 * 작성일 : 2015. 10. 12. 오전 9:36:33
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 * @return
	 */
	public String insertPrdt(RC_PRDTINFVO prdtInfVO) {
		return (String) insert("RC_PRDTINF_I_00", prdtInfVO);
	}

	/**
	 * 렌터카 상품 단건 조회
	 * 파일명 : selectByPrdt
	 * 작성일 : 2015. 10. 12. 오전 9:36:43
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 * @return
	 */
	public RC_PRDTINFVO selectByPrdt(RC_PRDTINFVO prdtInfVO) {
		return (RC_PRDTINFVO) select("RC_PRDTINF_S_00", prdtInfVO);
	}

	/**
	 * 렌터카 상품 수정
	 * 파일명 : updatePrdt
	 * 작성일 : 2015. 10. 12. 오전 9:36:55
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	public void updatePrdt(RC_PRDTINFVO prdtInfVO) {
		update("RC_PRDTINF_U_00", prdtInfVO);
	}

	/**
	 * 렌터카 요금 리스트 조회
	 * 파일명 : selectRcPrdtAmtList
	 * 작성일 : 2015. 10. 12. 오전 9:36:20
	 * 작성자 : 최영철
	 * @param amtInfVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RC_AMTINFVO> selectRcPrdtAmtList(RC_AMTINFVO amtInfVO) {
		return (List<RC_AMTINFVO>) list("RC_AMTINF_S_01", amtInfVO);
	}

	public RC_AMTINFVO selectByPrdtAmt(RC_AMTINFVO amtInfVO) {
		return (RC_AMTINFVO) select("RC_AMTINF_S_00", amtInfVO);
	}

	/**
	 * 렌터카 요금 추가
	 * 파일명 : insertPrdtAmt
	 * 작성일 : 2015. 10. 12. 오후 7:58:23
	 * 작성자 : 최영철
	 * @param amtInfVO
	 */
	public void insertPrdtAmt(RC_AMTINFVO amtInfVO) {
		insert("RC_AMTINF_I_00", amtInfVO);
	}

	/**
	 * 렌터카 요금 수정
	 * 파일명 : updatePrdtAmt
	 * 작성일 : 2015. 10. 12. 오후 9:18:25
	 * 작성자 : 최영철
	 * @param amtInfVO
	 */
	public void updatePrdtAmt(RC_AMTINFVO amtInfVO) {
		update("RC_AMTINF_U_00", amtInfVO);
	}

	/**
	 * 렌터카 요금 삭제
	 * 파일명 : deletePrdtAmt
	 * 작성일 : 2015. 10. 12. 오후 9:22:29
	 * 작성자 : 최영철
	 * @param amtInfVO
	 */
	public void deletePrdtAmt(RC_AMTINFVO amtInfVO) {
		delete("RC_AMTINF_D_00", amtInfVO);
	}

	@SuppressWarnings("unchecked")
	public List<RC_DISPERINFVO> selectDisPerList(RC_DISPERINFVO disPerInfVO) {
		return (List<RC_DISPERINFVO>) list("RC_DISPERINF_S_01", disPerInfVO);
	}

	public RC_DISPERINFVO selectByDefDisPer(RC_DISPERINFVO disPerInfVO) {
		return (RC_DISPERINFVO) select("RC_DISPERINF_S_02", disPerInfVO);
	}

	/**
	 * 렌터카 할인율 등록
	 * 파일명 : insertDisPerInf
	 * 작성일 : 2015. 10. 13. 오후 6:05:41
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	public void insertDisPerInf(RC_DISPERINFVO disPerInfVO) {
		insert("RC_DISPERINF_I_00", disPerInfVO);
	}

	/**
	 * 렌터카 할인율 수정
	 * 파일명 : updateDisPerInf
	 * 작성일 : 2015. 10. 13. 오후 8:19:19
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	public void updateDisPerInf(RC_DISPERINFVO disPerInfVO) {
		update("RC_DISPERINF_U_00", disPerInfVO);
	}

	public void insertRangeDisPer(RC_DISPERINFVO disPerInfVO) {
		insert("RC_DISPERINF_I_01", disPerInfVO);
	}

	/**
	 * 할인율 범위 중복 체크
	 * 파일명 : checkRangeAplDt
	 * 작성일 : 2015. 10. 14. 오전 11:39:19
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	public Integer checkRangeAplDt(RC_DISPERINFVO disPerInfVO) {
		return (Integer) select("RC_DISPERINF_S_03", disPerInfVO);
	}

	/**
	 * 할인율 단건 조회
	 * 파일명 : selectByDisPerInf
	 * 작성일 : 2015. 10. 14. 오후 2:49:00
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	public RC_DISPERINFVO selectByDisPerInf(RC_DISPERINFVO disPerInfVO) {
		return (RC_DISPERINFVO) select("RC_DISPERINF_S_00", disPerInfVO);
	}

	public void updateRangeDisPer(RC_DISPERINFVO disPerInfVO) {
		update("RC_DISPERINF_U_00", disPerInfVO);
	}

	/**
	 * 렌터카 기간할인율 삭제
	 * 파일명 : deleteRangeDisPer
	 * 작성일 : 2015. 10. 14. 오후 3:42:34
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	public void deleteRangeDisPer(RC_DISPERINFVO disPerInfVO) {
		delete("RC_DISPERINF_D_00", disPerInfVO);
	}

	/**
	 * 상품 승인요청
	 * 파일명 : approvalPrdt
	 * 작성일 : 2015. 10. 14. 오후 7:34:23
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	public void approvalPrdt(RC_PRDTINFVO prdtInfVO) {
		update("RC_PRDTINF_U_01", prdtInfVO);
	}

	public void deleteDisPerInf(RC_PRDTINFVO prdtInfVO) {
		delete("RC_DISPERINF_D_01", prdtInfVO);
	}

	public void deleteAmt(RC_PRDTINFVO prdtInfVO) {
		delete("RC_AMTINF_D_01", prdtInfVO);
	}

	public void deletePrdt(RC_PRDTINFVO prdtInfVO) {
		delete("RC_PRDTINF_D_00", prdtInfVO);
	}

	/**
	 * 상품 승인 취소 요청
	 * 파일명 : approvalCancelPrdt
	 * 작성일 : 2015. 10. 19. 오전 11:37:08
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	public void approvalCancelPrdt(RC_PRDTINFVO prdtInfVO) {
		update("RC_PRDTINF_U_02", prdtInfVO);
	}

	@SuppressWarnings("unchecked")
	public List<RC_PRDTINFVO> selectPrdtList(RC_PRDTINFSVO prdtInfSVO) {
		return (List<RC_PRDTINFVO>) list("RC_PRDTINF_S_03", prdtInfSVO);
	}

	/**
	 * 렌터카 상품 수량 리스트 조회
	 * 파일명 : selectCntList
	 * 작성일 : 2015. 10. 20. 오후 3:53:02
	 * 작성자 : 최영철
	 * @param cntInfVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RC_CNTINFVO> selectCntList(RC_CNTINFVO cntInfVO) {
		return (List<RC_CNTINFVO>) list("RC_CNTINF_S_01", cntInfVO);
	}

	/**
	 * 렌터카 상품 수량 단건 조회
	 * 파일명 : selectByPrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 5:35:59
	 * 작성자 : 최영철
	 * @param cntInfVO
	 * @return
	 */
	public RC_CNTINFVO selectByPrdtCnt(RC_CNTINFVO cntInfVO) {
		return (RC_CNTINFVO) select("RC_CNTINF_S_00", cntInfVO);
	}

	/**
	 * 렌터카 상품 수량 등록
	 * 파일명 : insertPrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 5:51:12
	 * 작성자 : 최영철
	 * @param cntInfVO
	 */
	public void insertPrdtCnt(RC_CNTINFVO cntInfVO) {
		insert("RC_CNTINF_I_00", cntInfVO);
	}

	/**
	 * 렌터카 상품 수량 수정
	 * 파일명 : updatePrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 8:24:06
	 * 작성자 : 최영철
	 * @param cntInfVO
	 */
	public void updatePrdtCnt(RC_CNTINFVO cntInfVO) {
		update("RC_CNTINF_U_00", cntInfVO);
	}

	/**
	 * 렌터카 상품 수량 삭제
	 * 파일명 : deletePrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 8:29:40
	 * 작성자 : 최영철
	 * @param cntInfVO
	 */
	public void deletePrdtCnt(RC_CNTINFVO cntInfVO) {
		delete("RC_CNTINF_D_00", cntInfVO);
	}

	/**
	 * 사용자 렌터카 리스트 조회
	 * 파일명 : selectWebRcPrdtList
	 * 작성일 : 2015. 10. 21. 오후 7:16:28
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RC_PRDTINFVO> selectWebRcPrdtList(RC_PRDTINFSVO prdtSVO) {
		return (List<RC_PRDTINFVO>) list("RC_PRDTINF_S_04", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public List<RC_PRDTINFVO> selectAPIRcPrdtList(RC_PRDTINFSVO prdtSVO) {
		return (List<RC_PRDTINFVO>) list("RC_PRDTINF_S_21", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public RC_PRDTINFVO selectAPIRcPrdt(RC_PRDTINFSVO prdtSVO) {
		return (RC_PRDTINFVO) select("RC_PRDTINF_S_21", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public String selectAPIRentDiv(RC_PRDTINFSVO prdtSVO) {
		return (String) select("RC_PRDTINF_S_22", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public RC_PRDTINFVO selectWebRcPrdt(RC_PRDTINFSVO prdtSVO) {
		return (RC_PRDTINFVO) select("RC_PRDTINF_S_04", prdtSVO);
	}
	
	// 통합검색 렌터카 리스트
	@SuppressWarnings("unchecked")
	public List<RC_PRDTINFVO> selectTotSchRcPrdtList(RC_PRDTINFSVO prdtSVO) {
		return (List<RC_PRDTINFVO>) list("RC_PRDTINF_S_17", prdtSVO);
	}

		@SuppressWarnings("unchecked")
	public List<RC_PRDTINFVO> selectCarNmList(RC_PRDTINFSVO prdtSVO) {
		return (List<RC_PRDTINFVO>) list("RC_PRDTINF_S_18", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public List<RC_PRDTINFVO> selectCancelPrdtList(RC_PRDTINFSVO prdtSVO) {
		return (List<RC_PRDTINFVO>) list("RC_PRDTINF_S_20", prdtSVO);
	}
	
	@SuppressWarnings("unchecked")
	public Integer selectWebRcPrdtListCnt(RC_PRDTINFSVO prdtSVO) {
		return (Integer) select("RC_PRDTINF_S_16", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public List<RC_PRDTINFVO> selectWebRcPrdtListOssPrmt(RC_PRDTINFSVO prdtSVO) {
		return (List<RC_PRDTINFVO>) list("RC_PRDTINF_S_10", prdtSVO);
	}

	/**
	 * 사용자 렌터카 차량유형별 카운트 조회
	 * 파일명 : selectRcPrdtCntList
	 * 작성일 : 2015. 10. 22. 오후 9:09:48
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RC_PRDTCNTVO> selectRcPrdtCntList(RC_PRDTINFSVO prdtSVO) {
		return (List<RC_PRDTCNTVO>) list("RC_PRDTINF_S_05", prdtSVO);
	}

	/**
	 * 렌터카 단건 사용가능여부 확인
	 * 파일명 : selectRcAble
	 * 작성일 : 2015. 10. 30. 오전 9:44:11
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	public RC_PRDTINFVO selectRcAble(RC_PRDTINFSVO prdtSVO) {
		return (RC_PRDTINFVO) select("RC_PRDTINF_S_07", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public List<RC_PRDTINFVO> selectRcBestPrdtList() {
		return (List<RC_PRDTINFVO>) list("RC_PRDTINF_S_08", "");
	}


	public Integer getCntRcPrdtFormCorp(RC_PRDTINFVO prdtInfVO) {
		return (Integer) select("RC_PRDTINF_S_09", prdtInfVO);
	}


	@SuppressWarnings("unchecked")
	public List<RC_PRDTINFVO> selectWebRcPrdtListOssKwa(String kwaNum) {
		return (List<RC_PRDTINFVO>) list("RC_PRDTINF_S_15", kwaNum);
	}

	/**
	 * 렌터카 상품 판매중지 처리
	 * 파일명 : saleStopPrdt
	 * 작성일 : 2016. 2. 4. 오전 11:38:45
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	public void saleStopPrdt(RC_PRDTINFVO prdtInfVO) {
		update("RC_PRDTINF_U_05", prdtInfVO);
	}
	
	public void salePrintN(RC_PRDTINFVO prdtInfVO) {
		update("RC_PRDTINF_U_10", prdtInfVO);
	}
	
	

	/**
	 * 렌터카 상품 수량 삭제
	 * 파일명 : deleteCntInf
	 * 작성일 : 2016. 3. 17. 오전 11:40:13
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	public void deleteCntInf(RC_PRDTINFVO prdtInfVO) {
		delete("RC_CNTINF_D_01", prdtInfVO);
	}

	/**
	 * 노출 순번 증가
	 * 파일명 : addRcPrdtViewSn
	 * 작성일 : 2016. 6. 8. 오전 10:47:37
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	public void addRcPrdtViewSn(RC_PRDTINFVO prdtInfVO) {
		update("RC_PRDTINF_U_06", prdtInfVO);
	}

	/**
	 * 노출 순번 감소
	 * 파일명 : minusRcPrdtViewSn
	 * 작성일 : 2016. 6. 8. 오전 11:20:15
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	public void minusRcPrdtViewSn(RC_PRDTINFVO prdtInfVO) {
		update("RC_PRDTINF_U_07", prdtInfVO);
	}

	/**
	 * 노출 순번 변경
	 * 파일명 : updateRcPrdtViewSn
	 * 작성일 : 2016. 6. 8. 오전 11:20:34
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	public void updateRcPrdtViewSn(RC_PRDTINFVO prdtInfVO) {
		update("RC_PRDTINF_U_08", prdtInfVO);
	}

	/**
	 * 연계 번호에 대한 상품 번호 구하기
	 * 파일명 : selectByPrdtNumAtLinkNum
	 * 작성일 : 2016. 7. 19. 오후 1:36:52
	 * 작성자 : 최영철
	 * @param rcPrdtSVO
	 * @return
	 */
	public String selectByPrdtNumAtLinkNum(RC_PRDTINFSVO rcPrdtSVO) {
		return (String) select("RC_PRDTINF_S_11", rcPrdtSVO);
	}

	/**
	 * 할인율 일괄 조회
	 * 파일명 : selectDisperPackList
	 * 작성일 : 2016. 8. 2. 오전 10:12:39
	 * 작성자 : 최영철
	 * @param prdtInfSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RC_DISPERINFVO> selectDisperPackList(RC_PRDTINFSVO prdtInfSVO) {
		return (List<RC_DISPERINFVO>) list("RC_DISPERINF_S_04", prdtInfSVO);
	}

	/**
	 * 기본 할인율이 등록안된 상품 조회
	 * 파일명 : selectDefDisPerPrdt
	 * 작성일 : 2016. 8. 3. 오후 2:49:45
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RC_DISPERINFVO> selectDefDisPerPrdt(RC_PRDTINFSVO searchVO) {
		return (List<RC_DISPERINFVO>) list("RC_DISPERINF_S_05", searchVO);
	}

	/**
	 * 설명 : 렌터카 예약현황 조회
	 * 파일명 : selectRsvChart
	 * 작성일 : 2023-02-28 오후 3:24
	 * 작성자 : chaewan.jung
	 * @param : [searchVO]
	 * @return : java.util.List<mas.rc.vo.RC_RSVCHARTVO>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<RC_RSVCHARTVO> selectRsvChart(RC_RSVCHARTSVO searchVO) {
		return (List<RC_RSVCHARTVO>) list("RC_RSVCHART_S_00", searchVO);
	}

	/**
	 * 예약현황 상세
	 * 파일명 : selectRsvChartDtl
	 * 작성일 : 2016. 8. 9. 오전 9:46:28
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RC_RSVVO> selectRsvChartDtl(RSVSVO rsvSVO) {
		return (List<RC_RSVVO>) list("RC_RSVCHART_S_01", rsvSVO);
	}

	/**
	 * 여행사 렌터카 단품 카운트
	 * 파일명 : selectRcPackCnt
	 * 작성일 : 2016. 10. 25. 오후 3:33:04
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	public Integer selectRcPackCnt(RC_PRDTINFSVO prdtSVO) {
		return (Integer) select("RC_PRDTINF_S_13", prdtSVO);
	}

	/**
	 * 여행사 렌터카 단품 리스트
	 * 파일명 : selectRcPackList
	 * 작성일 : 2016. 10. 25. 오후 3:42:05
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RC_PRDTINFVO> selectRcPackList(RC_PRDTINFSVO prdtSVO) {
		return (List<RC_PRDTINFVO>) list("RC_PRDTINF_S_12", prdtSVO);
	}

	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오전 10:34:06
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	public Integer checkExsistPrdt(RSVSVO rsvSVO) {
		return (Integer) select("RC_RSV_S_05", rsvSVO);
	}

	/**
	 * 연계 설정/해제
	 * 파일명 : updatePrdtLinkYn
	 * 작성일 : 2016. 12. 5. 오전 10:32:08
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	public void updatePrdtLinkYn(RC_PRDTINFVO prdtInfVO) {
		update("RC_PRDTINF_U_09", prdtInfVO);
	}

	/**
	 * 업체에 해당하는 상품인지 체크
	 * Function : checkCorpPrdt
	 * 작성일 : 2017. 5. 2. 오전 10:16:06
	 * 작성자 : 정동수
	 * @param prdtInfVO
	 * @return
	 */
	public Integer checkCorpPrdt(RC_PRDTINFVO prdtInfVO) {
		return (Integer) select("RC_PRDTINF_S_14", prdtInfVO);
	}






	/**
	 * 차종관리
	 * 파일명 : selectCardiv
	 * 작성일 : 2017. 10. 17. 오전 10:14:09
	 * 작성자 : 신우섭
	 * @param rcCardivVO
	 * @return
	 */
	public RC_CARDIVVO selectCardiv(RC_CARDIVVO rcCardivVO) {
		return (RC_CARDIVVO) select("RC_CARDIV_S_00", rcCardivVO);
	}

	@SuppressWarnings("unchecked")
	public List<RC_CARDIVVO> selectCardivList(RC_CARDIVSVO rcCardivSVO) {
		return (List<RC_CARDIVVO>) list("RC_CARDIV_S_01", rcCardivSVO);
	}

	public int selectCardivListCnt(RC_CARDIVSVO rcCardivSVO) {
		return (Integer) select("RC_CARDIV_S_02", rcCardivSVO);
	}
	
	public int selectCardivCnt(RC_CARDIVVO rcCardivVO) {
		return (Integer) select("RC_CARDIV_S_03", rcCardivVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<RC_CARDIVVO> selectCardivTotalList(RC_CARDIVSVO rcCardivSVO) {
		return (List<RC_CARDIVVO>) list("RC_CARDIV_S_04", rcCardivSVO);
	}

	public void insertCardiv(RC_CARDIVVO rcCardivVO) {
		insert("RC_CARDIV_I_00", rcCardivVO);
	}

	public void updateCardiv(RC_CARDIVVO rcCardivVO) {
		update("RC_CARDIV_U_00", rcCardivVO);
	}

	public void deleteCardiv(RC_CARDIVVO rcCardivVO) {
		delete("RC_CARDIV_D_00", rcCardivVO);
	}
	
	Integer selectCardivAutoIncrementNum(RC_CARDIVVO rcCardivVo) {
		return (Integer) select("RC_CARDIV_S_05", rcCardivVo);
	};

	@SuppressWarnings("unchecked")
	public List<RC_CARDIVVO> selectCarNmList(RC_CARDIVSVO rcCardivSVO) {
		return (List<RC_CARDIVVO>) list("RC_CARDIV_S_06", rcCardivSVO);
	}

	@SuppressWarnings("unchecked")
	public void updateRcApproxAmt(RC_PRDTINFSVO prdtSVO) {
		update("RC_PRDTINF_U_11", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public void deleteRcApproxAmt() {update("RC_PRDTINF_U_12");
	}

	/**
	* 설명 : 누적예약, 예약가능 차량, 입점업체 수
	* 파일명 :
	* 작성일 : 2022-06-22 오후 2:41
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public HashMap<String, Integer> selectIntroCount(){
		return (HashMap<String, Integer>) select("RC_INTRO_S_00");
	}
}
