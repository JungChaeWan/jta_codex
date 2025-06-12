package oss.bis.service.impl;

import java.util.List;

import mas.anls.vo.ANLSSVO;

import org.springframework.stereotype.Repository;

import oss.adj.vo.ADJVO;
import oss.anls.vo.ANLS10VO;
import oss.anls.vo.ANLS11VO;
import oss.bis.vo.BIS62VO;
import oss.bis.vo.BISSVO;
import oss.bis.vo.BISVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("ossBisDAO")
public class OssBisDAO extends EgovAbstractDAO {
	
	/**
	 * 보유하고 있는 회원 & 고객 총 인원
	 * Function : selectTotalMemCnt
	 * 작성일 : 2016. 9. 6. 오전 10:28:27
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectTotalMemCnt() {
		return (List<BISVO>) list("BIS_S_00");
	}
	
	/**
	 * 년월 검색에 따른 누적 고객 통계
	 * Function : selectUserPer
	 * 작성일 : 2016. 9. 6. 오후 5:08:44
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public ANLS10VO selectUserPer(BISSVO bisSVO) {
		return (ANLS10VO) select("BIS_S_01", bisSVO);
	}
	
	/**
	 * 년월 검색에 따른 누적 매출 금액 & 건수
	 * Function : selectSaleAmtCnt
	 * 작성일 : 2016. 9. 6. 오후 5:09:42
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public ANLS11VO selectSaleAmtCnt(BISSVO bisSVO) {
		return (ANLS11VO) select("BIS_S_02", bisSVO);
	}
	
	/**
	 * 지역별 회원&고객 비율
	 * Function : selectAreaMemCusPer
	 * 작성일 : 2016. 9. 8. 오후 3:52:23
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAreaMemCusPer() {
		return (List<BISVO>) list("BIS_S_03");
	}
	
	/**
	 * 입점업체 통계 리스트
	 * Function : selectCorpAnls
	 * 작성일 : 2016. 9. 12. 오후 3:54:31
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectCorpAnls(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_04", bisSVO);
	}
	
	/**
	 * 입점업체 통계 총 건수
	 * Function : selectTotalCorpanls
	 * 작성일 : 2016. 9. 12. 오후 4:33:37
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public int selectTotalCorpAnls(BISSVO bisSVO) {
		return (Integer) select("BIS_S_05", bisSVO);
	}
	
	/**
	 * 입점업체 통계의 각 부분별 합
	 * Function : selectSumCorpAnls
	 * 작성일 : 2016. 9. 12. 오후 5:57:31
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public BISVO selectSumCorpAnls(BISSVO bisSVO) {
		return (BISVO) select("BIS_S_06", bisSVO);
	}
	
	/**
	 * 판매통계의 월간매출 통계
	 * Function : selectSaleMonth
	 * 작성일 : 2016. 9. 22. 오전 10:01:01
	 * 작성자 : 정동수
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLS11VO> selectSaleMonth(ANLSSVO anlsSVO) {
		return (List<ANLS11VO>) list("BIS_S_07", anlsSVO);
	}
	
	/**
	 * 판매통계의 전체 연간 매출 통계
	 * Function : selectYearSaleAmt
	 * 작성일 : 2016. 9. 22. 오후 2:31:14
	 * 작성자 : 정동수
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectYearSaleAmt(ANLSSVO anlsSVO) {
		return (List<BISVO>) list("BIS_S_08", anlsSVO);
	}
	
	/**
	 * 판매통계의 항목별 연간 매출 통계
	 * Function : selectYearPrdtAmt
	 * 작성일 : 2016. 9. 22. 오후 2:54:38
	 * 작성자 : 정동수
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectYearPrdtAmt(ANLSSVO anlsSVO) {
		return (List<BISVO>) list("BIS_S_09", anlsSVO);
	}
	
	/**
	 * 판매통계의 당월 취소 통계 상세
	 * Function : selectCancelDftCur
	 * 작성일 : 2016. 9. 23. 오전 9:32:02
	 * 작성자 : 정동수
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectCancelDftCur(ANLSSVO anlsSVO) {
		return (List<BISVO>) list("BIS_S_10", anlsSVO);
	}
	
	/**
	 * 판매통계의 당월 이전 취소 통계 상세
	 * Function : selectCancelDftPrev
	 * 작성일 : 2016. 9. 23. 오전 9:32:49
	 * 작성자 : 정동수
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectCancelDftPrev(ANLSSVO anlsSVO) {
		return (List<BISVO>) list("BIS_S_11", anlsSVO);
	}
	
	/**
	 * 판매통계의 예약 전체 매출 금액 및 취소 금액
	 * Function : selectPrdtRsvCancelAmt
	 * 작성일 : 2016. 9. 23. 오전 9:35:11
	 * 작성자 : 정동수
	 * @param anlsSVO
	 * @return
	 */
	public BISVO selectPrdtRsvCancelAmt(BISSVO bisSVO) {
		return (BISVO) select("BIS_S_12", bisSVO);
	}
	
	/**
	 * 판매통계의 예약 시간 건수 통계 (요일 & 시간별)
	 * Function : selectPrdtRsvTimeCnt
	 * 작성일 : 2016. 9. 23. 오전 9:38:15
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectPrdtRsvTimeCnt(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_13", bisSVO);
	}
	
	/**
	 * 판매통계의 예약 취소 건수 (요일별)
	 * Function : selectPrdtCancelCnt
	 * 작성일 : 2016. 9. 23. 오전 9:39:42
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectPrdtCancelCnt(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_14", bisSVO);
	}
	
	/**
	 * 숙박 입실 통계
	 * Function : selectAdCheckInCnt
	 * 작성일 : 2016. 9. 23. 오후 4:01:53
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdCheckInCnt(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_15", bisSVO);
	}
	
	/**
	 * 숙박 퇴실 통계
	 * Function : selectAdCheckOutCnt
	 * 작성일 : 2016. 9. 23. 오후 4:02:04
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdCheckOutCnt(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_16", bisSVO);
	}
	
	/**
	 * 숙박 유형 통계 (그래프)
	 * Function : selectAdTypeGp
	 * 작성일 : 2016. 9. 23. 오후 4:23:41
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdTypePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_17", bisSVO);
	}
	
	/**
	 * 숙박 기간 통계 (그래프)
	 * Function : selectAdPeriodPer
	 * 작성일 : 2016. 9. 23. 오후 11:24:25
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdPeriodPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_18", bisSVO);
	}
	
	/**
	 * 숙박 가격 통계 (그래프)
	 * Function : selectAdPricePer
	 * 작성일 : 2016. 9. 23. 오후 11:25:03
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdPricePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_19", bisSVO);
	}
	
	/**
	 * 숙박 지역 통계 (그래프)
	 * Function : selectAdAreaPer
	 * 작성일 : 2016. 9. 23. 오후 11:25:49
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdAreaPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_20", bisSVO);
	}
	
	/**
	 * 숙박 당일 예약 통계 (그래프)
	 * Function : selectAdCurRsvPer
	 * 작성일 : 2016. 9. 23. 오후 11:26:51
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */	
	public BISVO selectAdCurRsvPer(BISSVO bisSVO) {
		return (BISVO) select("BIS_S_21", bisSVO);
	}
	
	/**
	 * 숙박 예약 취소 주기 통계 (예약일 기준 - 그래프)
	 * Function : selectAdCancelRsvPer
	 * 작성일 : 2016. 9. 23. 오후 11:27:41
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdCancelRsvPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_22", bisSVO);
	}
	
	/**
	 * 숙박 예약 취소 주기 통계 (사용일 기준 - 그래프)
	 * Function : selectAdCancelUsePer
	 * 작성일 : 2016. 9. 23. 오후 11:28:31
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdCancelUsePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_23", bisSVO);
	}
	
	/**
	 * 렌터카 인수 통계
	 * Function : selectRcStartPer
	 * 작성일 : 2016. 9. 24. 오전 1:08:11
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectRcStartCnt(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_24", bisSVO);
	}
	
	/**
	 * 렌터카 유형 통계 (그래프)
	 * Function : selectRcTypePer
	 * 작성일 : 2016. 9. 24. 오전 2:00:14
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectRcTypePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_25", bisSVO);
	}
	
	/**
	 * 렌터카 기간 통계 (그래프)
	 * Function : selectRcPeriodPer
	 * 작성일 : 2016. 9. 24. 오전 2:00:45
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectRcPeriodPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_26", bisSVO);
	}
	
	/**
	 * 렌터카 연료 통계 (그래프)
	 * Function : selectRcFuelPer
	 * 작성일 : 2016. 9. 24. 오전 2:00:54
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectRcFuelPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_27", bisSVO);
	}
	
	/**
	 * 렌터카 예약 취소 주기 통계 (예약일 기준 - 그래프)
	 * Function : selectRcCancelRsvPer
	 * 작성일 : 2016. 9. 24. 오전 2:01:16
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectRcCancelRsvPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_28", bisSVO);
	}
	
	/**
	 * 렌터카 예약 취소 주기 통계 (사용일 기준 - 그래프)
	 * Function : selectRcCancelUsePer
	 * 작성일 : 2016. 9. 24. 오전 2:01:30
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectRcCancelUsePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_29", bisSVO);
	}
	
	/**
	 * 관광지 요일별 구매건수 통계
	 * Function : selectSpcUseCnt
	 * 작성일 : 2016. 9. 25. 오전 2:26:17
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSpcUseCnt(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_30", bisSVO);
	}
	
	/**
	 * 관광지 유형 통계 (그래프)
	 * Function : selectSpcTypePer
	 * 작성일 : 2016. 9. 25. 오전 2:26:34
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSpcTypePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_31", bisSVO);
	}
	
	/**
	 * 관광지 구매 개수 통계 (그래프)
	 * Function : selectSpcBuyCntPer
	 * 작성일 : 2016. 9. 25. 오전 2:27:17
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSpcBuyCntPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_32", bisSVO);
	}
	
	/**
	 * 관광지 구매 시기 통계 (그래프)
	 * Function : selectSpcBuyTimePer
	 * 작성일 : 2016. 9. 25. 오전 2:27:41
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSpcBuyTimePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_33", bisSVO);
	}
	
	/**
	 * 관광지 예약 취소 주기 통계 (예약일 기준 - 그래프)
	 * Function : selectSpcCancelRsvPer
	 * 작성일 : 2016. 9. 25. 오전 2:28:10
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSpcCancelRsvPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_34", bisSVO);
	}
	
	/**
	 * 패키지 유형 통계 (그래프)
	 * Function : selectSptTypePer
	 * 작성일 : 2016. 9. 25. 오전 2:29:04
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSptTypePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_35", bisSVO);
	}
	
	/**
	 * 패키지 가격 통계 (그래프)
	 * Function : selectSptPricePer
	 * 작성일 : 2016. 9. 25. 오전 2:29:40
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSptPricePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_36", bisSVO);
	}
	
	/**
	 * 패키지 예약 취소 주기 통계 (예약일 기준 - 그래프)
	 * Function : selectSptCancelRsvPer
	 * 작성일 : 2016. 9. 25. 오전 2:30:35
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSptCancelRsvPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_37", bisSVO);
	}
	
	/**
	 * 패키지 예약 취소 주기 통계 (사용일 기준 - 그래프)
	 * Function : selectSptCancelUsePer
	 * 작성일 : 2016. 9. 25. 오전 2:31:27
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSptCancelUsePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_38", bisSVO);
	}
	
	/**
	 * 항공의 출발 시간 통계
	 * Function : selectAvFromTimeCnt
	 * 작성일 : 2016. 9. 26. 오후 2:18:56
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAvFromTimeCnt(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_39", bisSVO);
	}
	
	/**
	 * 항공의 항공권 예약 시기 통계 (그래프)
	 * Function : selectAvRsvPeriodPer
	 * 작성일 : 2016. 9. 26. 오후 2:19:17
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAvRsvPeriodPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_40", bisSVO);
	}
	
	/**
	 * 항공의 항공권 유형 통계 (그래프)
	 * Function : selectAvCompanyPer
	 * 작성일 : 2016. 9. 26. 오후 2:22:58
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAvTypePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_41", bisSVO);
	}
	
	/**
	 * 항공의 항공사 통계 (그래프)
	 * Function : selectAvCompanyPer
	 * 작성일 : 2016. 9. 26. 오후 2:19:46
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAvCompanyPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_42", bisSVO);
	}
	
	/**
	 * 항공의 출발하는 도시 통계 (그래프)
	 * Function : selectAvFromCityPer
	 * 작성일 : 2016. 9. 26. 오후 2:20:01
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAvFromCityPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_43", bisSVO);
	}
	
	/**
	 * 항공의 여행기간 통계 (왕복 - 그래프)
	 * Function : selectAvTourPeriodPer
	 * 작성일 : 2016. 9. 26. 오후 2:24:12
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAvTourPeriodPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_44", bisSVO);
	}
	
	
	/**
	 * 월별 광고 수익율 통계
	 * Function : selectAdtmYear
	 * 작성일 : 2016. 9. 28. 오전 9:36:21
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdtmYear(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_45", bisSVO);
	}
	
	/**
	 * 일별 광고 수익율 통계
	 * Function : selectAdtmMonth
	 * 작성일 : 2016. 9. 28. 오전 9:36:56
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdtmMonth(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_46", bisSVO);
	}
	
	/**
	 * 일별 현황 통계
	 * Function : selectDayCondition
	 * 작성일 : 2016. 9. 28. 오후 2:34:39
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectDayCondition(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_47", bisSVO);
	}
		
	/**
	 * 일별 현황 통계 (회원 현황)
	 * Function : selectDayMember
	 * 작성일 : 2016. 9. 28. 오후 2:34:55
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public BISVO selectDayMember(BISSVO bisSVO) {
		return (BISVO) select("BIS_S_48", bisSVO);
	}
	
	/**
	 * 정산 통계 (총 판매액 & 총 판매수수료액 & 총 정산대상금액)
	 * Function : selectTotalAdj
	 * 작성일 : 2016. 9. 29. 오전 9:58:30
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public BISVO selectTotalAdj(BISSVO bisSVO) {
		return (BISVO) select("BIS_S_49", bisSVO);
	}
	
	/**
	 * 정산 통계 리스트
	 * Function : selectAdjList
	 * 작성일 : 2016. 9. 29. 오전 9:59:30
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdjList(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_50", bisSVO);
	}
	
	/**
	 * 정산 통계 Excel 리스트
	 * Function : selectAdjListExcel
	 * 작성일 : 2016. 11. 22. 오후 2:34:32
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectAdjListExcel(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_61", bisSVO);
	}
	
	/**
	 * 정산 통계 총 건수
	 * Function : selectAdjTotalCnt
	 * 작성일 : 2016. 9. 29. 오후 12:00:54
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public int selectAdjTotalCnt(BISSVO bisSVO) {
		return (Integer) select("BIS_S_51", bisSVO);
	}
	
	/**
	 * 결제방법 (그래프)
	 * Function : selectPayDivPer
	 * 작성일 : 2016. 9. 29. 오전 10:00:54
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectPayDivPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_52", bisSVO);
	}
	
	/**
	 * 회원/비회원 결제비율 통계 (그래프)
	 * Function : selectRsvMemberPer
	 * 작성일 : 2016. 9. 29. 오전 10:01:44
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public BISVO selectRsvMemberPer(BISSVO bisSVO) {
		return (BISVO) select("BIS_S_53", bisSVO);
	}
	
	/**
	 * 업체명 검색에 따른 업체명 리스트
	 * Function : selectCorpNmList
	 * 작성일 : 2016. 9. 29. 오후 2:48:34
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectCorpNmList(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_54", bisSVO);
	}
	
	/**
	 * 입점업체 검색 총 건수
	 * Function : selectCorpNmTotalCnt
	 * 작성일 : 2016. 9. 29. 오후 2:55:52
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public int selectCorpNmTotalCnt(BISSVO bisSVO) {
		return (Integer) select("BIS_S_55", bisSVO);
	}
	
	/**
	 * 렌터카 유형에 따른 예약 차량 건수 통계 (그래프)
	 * Function : selectRcTypeCntPer
	 * 작성일 : 2016. 9. 30. 오전 9:11:30
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectRcTypeCntPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_56", bisSVO);
	}
	
	/**
	 * 기간 검색에 대한 업체 정산 리스트
	 * Function : selectCorpAdjList
	 * 작성일 : 2016. 11. 3. 오후 5:40:25
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADJVO> selectCorpAdjList(BISSVO bisSVO) {
		return (List<ADJVO>) list("BIS_S_57", bisSVO);
	}
	
	/**
	 * 기념품 유형 통계 (그래프)
	 * Function : selectSvTypePer
	 * 작성일 : 2016. 11. 9. 오후 3:43:52
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSvTypePer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_58", bisSVO);
	}
	
	/**
	 * 기념품 구매 개수 통계 (그래프)
	 * Function : selectSvBuyCntPer
	 * 작성일 : 2016. 11. 9. 오후 3:43:56
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSvBuyCntPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_59", bisSVO);
	}
	
	/**
	 * 기념품 예약 취소 주기 통계 (예약일 기준 - 그래프)
	 * Function : selectSvCancelRsvPer
	 * 작성일 : 2016. 11. 9. 오후 3:43:59
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectSvCancelRsvPer(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_60", bisSVO);
	}

	/**
	 * 입점업체현황
	 * 파일명 : selectDayCorpList
	 * 작성일 : 2017. 2. 14. 오전 10:47:41
	 * 작성자 : 최영철
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BIS62VO> selectDayCorpList(BISSVO bisSVO) {
		return (List<BIS62VO>) list("BIS_S_62", bisSVO);
	}

	/**
	 * 업체구분별 상품현황
	 * 파일명 : selectDayPrdtList
	 * 작성일 : 2017. 2. 14. 오후 3:39:06
	 * 작성자 : 최영철
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BIS62VO> selectDayPrdtList(BISSVO bisSVO) {
		return (List<BIS62VO>) list("BIS_S_63", bisSVO);
	}
	
	/**
	 * 매출현황 일일 보고의 방문자수 정보 출력
	 * Function : selectVisitorInfo
	 * 작성일 : 2018. 2. 22. 오후 2:21:43
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public BISVO selectVisitorInfo(BISSVO bisSVO) {
		return (BISVO) select("BIS_S_64", bisSVO);
	}
	
	/**
	 * 매출현황 일일 보고의 광고금액 출력
	 * Function : selectAdtmAmt
	 * 작성일 : 2018. 2. 22. 오후 2:52:34
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public int selectAdtmAmt(BISSVO bisSVO) {
		return (Integer) select("BIS_S_65", bisSVO);
	}
	
	/**
	 * 매출현황 일일 보고의 항공 정보 출력
	 * Function : selectDayAvInfo
	 * 작성일 : 2018. 2. 22. 오후 3:37:51
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public BISVO selectDayAvInfo(BISSVO bisSVO) {
		return (BISVO) select("BIS_S_66", bisSVO);
	}
	
	/**
	 * 매출현황 일일 보고의 예약 정보 출력
	 * Function : selectDayRsvInfo
	 * 작성일 : 2018. 2. 22. 오후 5:59:43
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BISVO> selectDayRsvInfo(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_67", bisSVO);
	}
	
	/**
	 * 매출현황 일일 보고의 전년도 동월 매출 정보 출력
	 * Function : selectDayPrevInfo
	 * 작성일 : 2018. 3. 2. 오전 11:17:32
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public BISVO selectDayPrevInfo(BISSVO bisSVO) {
		return (BISVO) select("BIS_S_68", bisSVO);
	}
	
	/**
	 * 매출현황 일일 보고 정보 출력
	 * Function : selectDaydayAnls
	 * 작성일 : 2018. 2. 22. 오후 12:03:45
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	public BISVO selectDaydayAnls(BISSVO bisSVO) {
		return (BISVO) select("DAY_S_00", bisSVO);
	}
	
	/**
	 * 매출현황 일일 보고 수정
	 * Function : updateDaydayAnls
	 * 작성일 : 2018. 2. 22. 오전 11:39:38
	 * 작성자 : 정동수
	 */
	public void updateDaydayAnls(BISVO bisVO) {
		update("DAY_M_00", bisVO);
	}

	public List<BISVO> selectPrdtSaleList(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_69", bisSVO);
	}

	public int selectPrdtSaleListCnt(BISSVO bisSVO) {
		return (Integer) select("BIS_S_70", bisSVO);
	}

	public List<BISVO> selectPrdtSaleDtl(BISSVO bisSVO) {
		return (List<BISVO>) list("BIS_S_71", bisSVO);
	}
}
