package oss.bis.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import mas.anls.vo.ANLSSVO;
import oss.adj.vo.ADJVO;
import oss.anls.vo.ANLS10VO;
import oss.anls.vo.ANLS11VO;
import oss.bis.vo.BIS62VO;
import oss.bis.vo.BISSVO;
import oss.bis.vo.BISVO;

public interface OssBisService {
	/**
	 * 보유하고 있는 회원 & 고객 총 인원
	 * Function : getTotalMemCnt
	 * 작성일 : 2016. 9. 6. 오전 10:36:44
	 * 작성자 : 정동수
	 * @return
	 * Note : 고객 => 한건이라도 구매를 진행한 회원
	 */
	Map<String, String> getTotalMemCnt();
	
	/**
	 * 년월 검색에 따른 누적 고객 통계
	 * Function : getUserPer
	 * 작성일 : 2016. 9. 6. 오후 3:30:50
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	ANLS10VO getUserPer(BISSVO bisSVO);
	
	/**
	 * 년월 검색에 따른 누적 매출 금액 & 건수
	 * Function : getSaleAmtCnt
	 * 작성일 : 2016. 9. 6. 오후 5:07:37
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	ANLS11VO getSaleAmtCnt(BISSVO bisSVO);
	
	/**
	 * 지역별 회원&고객 비율
	 * Function : getAreaMemCusPer
	 * 작성일 : 2016. 9. 8. 오전 11:05:12
	 * 작성자 : 정동수
	 * @return
	 */
	List<BISVO> getAreaMemCusPer();
	
	/**
	 * 입점업체 통계 리스트
	 * Function : getCorpAnlsList
	 * 작성일 : 2016. 9. 12. 오후 3:55:25
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	Map<String, Object> getCorpAnlsList(BISSVO bisSVO);
	
	/**
	 * 입점업체 통계의 각 부분별 합
	 * Function : getSumCorpAnls
	 * 작성일 : 2016. 9. 12. 오후 5:58:54
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	BISVO getSumCorpAnls(BISSVO bisSVO);
	
	/**
	 * 판매통계의 월간매출 통계
	 * Function : selectSaleMonth
	 * 작성일 : 2016. 9. 22. 오전 10:02:41
	 * 작성자 : 정동수
	 * @param anlsSVO
	 * @return
	 */
	List<ANLS11VO> selectSaleMonth(ANLSSVO anlsSVO);
	
	/**
	 * 판매통계의 전체 연간 매출 통계
	 * Function : selectYearSaleAmt
	 * 작성일 : 2016. 9. 22. 오후 2:56:32
	 * 작성자 : 정동수
	 * @param anlsSVO
	 * @return
	 */
	List<BISVO> selectYearSaleAmt(ANLSSVO anlsSVO);
	
	/**
	 * 판매통계의 항목별 연간 매출 통계
	 * Function : selectYearPrdtAmt
	 * 작성일 : 2016. 9. 22. 오후 2:56:38
	 * 작성자 : 정동수
	 * @param anlsSVO
	 * @return
	 */
	Map<String, Map<String, String>> selectYearPrdtAmt(ANLSSVO anlsSVO);
	
	/**
	 * 판매통계의 당월 취소 통계 상세
	 * Function : selectCancelDftCur
	 * 작성일 : 2016. 9. 23. 오전 9:40:26
	 * 작성자 : 정동수
	 * @param anlsSVO
	 * @return
	 */
	List<BISVO> selectCancelDftCur(ANLSSVO anlsSVO);
	
	/**
	 * 판매통계의 당월 이전 취소 통계 상세
	 * Function : selectCancelDftPrev
	 * 작성일 : 2016. 9. 23. 오전 9:40:42
	 * 작성자 : 정동수
	 * @param anlsSVO
	 * @return
	 */
	List<BISVO> selectCancelDftPrev(ANLSSVO anlsSVO);
	
	/**
	 * 판매통계의 예약 전체 매출 금액 및 취소 금액
	 * Function : selectPrdtRsvCancelAmt
	 * 작성일 : 2016. 9. 23. 오전 9:41:47
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	BISVO selectPrdtRsvCancelAmt(BISSVO bisSVO);
	
	/**
	 * 판매통계의 예약 시간 건수 통계 (요일 & 시간별)
	 * Function : selectPrdtRsvTimeCnt
	 * 작성일 : 2016. 9. 23. 오전 9:42:35
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	LinkedHashMap<String, LinkedHashMap<String, String>> selectPrdtRsvTimeCnt(BISSVO bisSVO);
	
	/**
	 * 판매통계의 예약 취소 건수 (요일별)
	 * Function : selectPrdtCancelCnt
	 * 작성일 : 2016. 9. 23. 오전 9:42:52
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectPrdtCancelCnt(BISSVO bisSVO);
	
	/**
	 * 항공의 출발 시간 통계 (요일 & 시간별)
	 * Function : selectAvFromTimeCnt
	 * 작성일 : 2016. 9. 26. 오후 2:32:17
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	LinkedHashMap<String, LinkedHashMap<String, String>> selectAvFromTimeCnt(BISSVO bisSVO);
	
	/**
	 * 항공의 항공권 예약 시기 통계
	 * Function : selectAvRsvPeriodPer
	 * 작성일 : 2016. 9. 26. 오후 2:32:49
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAvRsvPeriodPer(BISSVO bisSVO);
	
	/**
	 * 항공의 항공권 유형 통계
	 * Function : selectAvTypePer
	 * 작성일 : 2016. 9. 26. 오후 2:34:38
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAvTypePer(BISSVO bisSVO);
	
	/**
	 * 항공의 항공사 통계
	 * Function : selectAvCompanyPer
	 * 작성일 : 2016. 9. 26. 오후 2:33:16
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAvCompanyPer(BISSVO bisSVO);
	
	/**
	 * 항공의 출발하는 도시 통계
	 * Function : selectAvFromCityPer
	 * 작성일 : 2016. 9. 26. 오후 2:33:46
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAvFromCityPer(BISSVO bisSVO);
	
	/**
	 * 항공의 여행기간 통계
	 * Function : selectAvTourPeriodPer
	 * 작성일 : 2016. 9. 26. 오후 2:35:09
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAvTourPeriodPer(BISSVO bisSVO);
	
	/**
	 * 숙박 입실 통계
	 * Function : selectAdCheckInCnt
	 * 작성일 : 2016. 9. 23. 오후 4:02:39
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAdCheckInCnt(BISSVO bisSVO);
	
	/**
	 * 숙박 퇴실 통계
	 * Function : selectAdCheckOutCnt
	 * 작성일 : 2016. 9. 23. 오후 4:02:51
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAdCheckOutCnt(BISSVO bisSVO);
	
	/**
	 * 숙박 유형 통계 (그래프)
	 * Function : selectAdTypeGp
	 * 작성일 : 2016. 9. 23. 오후 4:24:11
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAdTypePer(BISSVO bisSVO);
	
	/**
	 * 숙박 기간 통계 (그래프)
	 * Function : selectAdPeriodPer
	 * 작성일 : 2016. 9. 23. 오후 11:30:38
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAdPeriodPer(BISSVO bisSVO);
	
	/**
	 * 숙박 가격 통계 (그래프)
	 * Function : selectAdPricePer
	 * 작성일 : 2016. 9. 23. 오후 11:31:02
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAdPricePer(BISSVO bisSVO);
	
	/**
	 * 숙박 지역 통계 (그래프)
	 * Function : selectAdAreaPer
	 * 작성일 : 2016. 9. 23. 오후 11:31:24
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAdAreaPer(BISSVO bisSVO);
	
	/**
	 * 숙박 당일 예약 통계 (그래프)
	 * Function : selectAdCurRsvPer
	 * 작성일 : 2016. 9. 23. 오후 11:31:52
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	BISVO selectAdCurRsvPer(BISSVO bisSVO);
	
	/**
	 * 숙박 예약 취소 주기 통계 (예약일 기준 - 그래프)
	 * Function : selectAdCancelRsvPer
	 * 작성일 : 2016. 9. 23. 오후 11:32:36
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAdCancelRsvPer(BISSVO bisSVO);
	
	/**
	 * 숙박 예약 취소 주기 통계 (사용일 기준 - 그래프)
	 * Function : selectAdCancelUsePer
	 * 작성일 : 2016. 9. 23. 오후 11:32:59
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAdCancelUsePer(BISSVO bisSVO);
	
	
	/**
	 * 렌터카 인수 통계
	 * Function : selectRcStartCnt
	 * 작성일 : 2016. 9. 24. 오전 1:09:07
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectRcStartCnt(BISSVO bisSVO);
	
	/**
	 * 렌터카 유형 통계 (그래프)
	 * Function : selectRcTypePer
	 * 작성일 : 2016. 9. 24. 오후 10:59:39
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectRcTypePer(BISSVO bisSVO);
	
	/**
	 * 렌터카 기간 통계 (그래프)
	 * Function : selectRcPeriodPer
	 * 작성일 : 2016. 9. 24. 오후 11:00:04
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectRcPeriodPer(BISSVO bisSVO);
	
	/**
	 * 렌터카 연료 통계 (그래프)
	 * Function : selectRcFuelPer
	 * 작성일 : 2016. 9. 24. 오후 11:00:55
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectRcFuelPer(BISSVO bisSVO);
	
	/**
	 * 렌터카 예약 취소 주기 통계 (예약일 기준 - 그래프)
	 * Function : selectRcCancelRsvPer
	 * 작성일 : 2016. 9. 24. 오후 11:01:16
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectRcCancelRsvPer(BISSVO bisSVO);
	
	/**
	 * 렌터카 예약 취소 주기 통계 (사용일 기준 - 그래프)
	 * Function : selectRcCancelUsePer
	 * 작성일 : 2016. 9. 24. 오후 11:01:33
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectRcCancelUsePer(BISSVO bisSVO);
	
	/**
	 * 관광지 요일별 구매건수 통계
	 * Function : selectSpcUseCnt
	 * 작성일 : 2016. 9. 25. 오전 2:32:55
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSpcUseCnt(BISSVO bisSVO);
	
	/**
	 * 관광지 유형 통계 (그래프)
	 * Function : selectSpcTypePer
	 * 작성일 : 2016. 9. 25. 오전 2:32:59
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSpcTypePer(BISSVO bisSVO);
	
	/**
	 * 관광지 구매 개수 통계 (그래프)
	 * Function : selectSpcBuyCntPer
	 * 작성일 : 2016. 9. 25. 오전 2:33:03
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSpcBuyCntPer(BISSVO bisSVO);
	
	/**
	 * 관광지 구매 시기 통계 (그래프)
	 * Function : selectSpcBuyTimePer
	 * 작성일 : 2016. 9. 25. 오전 2:33:07
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSpcBuyTimePer(BISSVO bisSVO);
	
	/**
	 * 관광지 예약 취소 주기 통계 (예약일 기준 - 그래프)
	 * Function : selectSpcCancelRsvPer
	 * 작성일 : 2016. 9. 25. 오전 2:33:10
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSpcCancelRsvPer(BISSVO bisSVO);
	
	/**
	 * 패키지 유형 통계 (그래프)
	 * Function : selectSptTypePer
	 * 작성일 : 2016. 9. 25. 오전 2:33:13
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSptTypePer(BISSVO bisSVO);
	
	/**
	 * 패키지 가격 통계 (그래프)
	 * Function : selectSptPricePer
	 * 작성일 : 2016. 9. 25. 오전 2:33:16
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSptPricePer(BISSVO bisSVO);
	
	/**
	 * 패키지 예약 취소 주기 통계 (예약일 기준 - 그래프)
	 * Function : selectSptCancelRsvPer
	 * 작성일 : 2016. 9. 25. 오전 2:33:19
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSptCancelRsvPer(BISSVO bisSVO);
	
	/**
	 * 패키지 예약 취소 주기 통계 (사용일 기준 - 그래프)
	 * Function : selectSptCancelUsePer
	 * 작성일 : 2016. 9. 25. 오전 2:33:23
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSptCancelUsePer(BISSVO bisSVO);
		
	/**
	 * 기념품 유형 통계 (그래프)
	 * Function : selectSvTypePer
	 * 작성일 : 2016. 11. 9. 오후 2:41:57
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSvTypePer(BISSVO bisSVO);
		
	/**
	 * 기념품 구매 개수 통계 (그래프)
	 * Function : selectSvBuyCntPer
	 * 작성일 : 2016. 11. 9. 오후 2:42:00
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSvBuyCntPer(BISSVO bisSVO);
		
	/**
	 * 기념품 예약 취소 주기 통계 (예약일 기준 - 그래프)
	 * Function : selectSvCancelRsvPer
	 * 작성일 : 2016. 11. 9. 오후 2:42:03
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectSvCancelRsvPer(BISSVO bisSVO);
	
	/**
	 * 월별 광고 수익율 통계
	 * Function : selectAdtmYear
	 * 작성일 : 2016. 9. 28. 오전 9:37:40
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAdtmYear(BISSVO bisSVO);
	
	/**
	 * 일별 광고 수익율 통계
	 * Function : selectAdtmMonth
	 * 작성일 : 2016. 9. 28. 오전 9:37:51
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAdtmMonth(BISSVO bisSVO);
	
	/**
	 * 일별 현황 통계
	 * Function : selectDayCondition
	 * 작성일 : 2016. 9. 28. 오후 2:35:32
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectDayCondition(BISSVO bisSVO);
	
	/**
	 * 일별 현황 통계 (회원 현황)
	 * Function : selectDayMember
	 * 작성일 : 2016. 9. 28. 오후 2:35:35
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	BISVO selectDayMember(BISSVO bisSVO);
	
	/**
	 * 정산 통계 (총 판매액 & 총 판매수수료액 & 총 정산대상금액)
	 * Function : selectTotalAdj
	 * 작성일 : 2016. 9. 29. 오전 10:03:30
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	BISVO selectTotalAdj(BISSVO bisSVO);
	
	/**
	 * 정산 통계 리스트
	 * Function : selectAdjList
	 * 작성일 : 2016. 9. 29. 오전 10:04:00
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	Map<String, Object> selectAdjList(BISSVO bisSVO);
	
	/**
	 * 정산 통계 Excel 리스트
	 * Function : selectAdjListExcel
	 * 작성일 : 2016. 11. 22. 오후 2:30:12
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectAdjListExcel(BISSVO bisSVO);
	
	/**
	 * 결제방법 (그래프)
	 * Function : selectPayDivPer
	 * 작성일 : 2016. 9. 29. 오전 10:04:30
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectPayDivPer(BISSVO bisSVO);
	
	/**
	 * 회원/비회원 결제비율 통계 (그래프)
	 * Function : selectRsvMemberPer
	 * 작성일 : 2016. 9. 29. 오전 10:04:58
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	BISVO selectRsvMemberPer(BISSVO bisSVO);
	
	/**
	 * 업체명 검색에 따른 업체명 리스트
	 * Function : selectCorpNmList
	 * 작성일 : 2016. 9. 29. 오후 2:49:13
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	Map<String, Object> selectCorpNmList(BISSVO bisSVO);
	
	/**
	 * 렌터카 유형에 따른 예약 차량 건수 통계 (그래프)
	 * Function : selectRcTypeCntPer
	 * 작성일 : 2016. 9. 30. 오전 9:12:09
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectRcTypeCntPer(BISSVO bisSVO);
	
	/**
	 * 기간 검색에 대한 업체 정산 리스트
	 * Function : selectCorpAdjList
	 * 작성일 : 2016. 11. 3. 오후 5:41:25
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<ADJVO> selectCorpAdjList(BISSVO bisSVO);
	
	/**
	 * 하이제주의 관광지 입장권 예약 전체 매출 금액
	 * Function : selectCouponRsvAmt
	 * 작성일 : 2016. 12. 7. 오전 11:01:13
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	BISVO selectCouponRsvAmt(BISSVO bisSVO);
	
	/**
	 * 하이제주의 관광지 입장권 예약 시간 건수 통계 (요일 & 시간별)
	 * Function : selectCouponRsvTimeCnt
	 * 작성일 : 2016. 12. 7. 오후 4:03:19
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	LinkedHashMap<String, LinkedHashMap<String, String>> selectCouponRsvTimeCnt(BISSVO bisSVO);
	
	/**
	 * 하이제주의 관광지 입장권 구매 개수 통계 (그래프)
	 * Function : selectCouponBuyCntPer
	 * 작성일 : 2016. 12. 7. 오후 4:56:39
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	List<BISVO> selectCouponBuyCntPer(BISSVO bisSVO);

	/**
	 * 입점업체현황
	 * 파일명 : selectDayCorpList
	 * 작성일 : 2017. 2. 14. 오전 10:46:46
	 * 작성자 : 최영철
	 * @param bisSVO
	 * @return
	 */
	List<BIS62VO> selectDayCorpList(BISSVO bisSVO);

	/**
	 * 업체구분별 상품현황
	 * 파일명 : selectDayPrdtList
	 * 작성일 : 2017. 2. 14. 오후 3:37:24
	 * 작성자 : 최영철
	 * @param bisSVO
	 * @return
	 */
	List<BIS62VO> selectDayPrdtList(BISSVO bisSVO);
	
	/**
	 * 매출현황 일일 보고 정보 출력
	 * Function : selectDaydayAnls
	 * 작성일 : 2018. 2. 22. 오후 12:05:00
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	BISVO selectDaydayAnls(BISSVO bisSVO);
	
	/**
	 * 매출현황 일일 보고의 방문자수 정보 출력
	 * Function : selectVisitorInfo
	 * 작성일 : 2018. 2. 22. 오후 2:22:49
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	BISVO selectVisitorInfo(BISSVO bisSVO);
	
	/**
	 * 매출현황 일일 보고의 광고금액 출력
	 * Function : selectAdtmAmt
	 * 작성일 : 2018. 2. 22. 오후 2:52:34
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	int selectAdtmAmt(BISSVO bisSVO);
	
	/**
	 * 매출현황 일일 보고의 항공 정보 출력
	 * Function : selectDayAvInfo
	 * 작성일 : 2018. 2. 22. 오후 3:37:51
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	BISVO selectDayAvInfo(BISSVO bisSVO);
	
	/**
	 * 매출현황 일일 보고의 예약 정보 출력
	 * Function : selectDayRsvInfo
	 * 작성일 : 2018. 2. 23. 오전 9:00:07
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	Map<String, BISVO> selectDayRsvInfo(BISSVO bisSVO);
	
	/**
	 * 매출현황 일일 보고의 전년도 동월 매출 정보 출력
	 * Function : selectDayPrevInfo
	 * 작성일 : 2018. 3. 2. 오전 11:17:32
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	BISVO selectDayPrevInfo(BISSVO bisSVO);
	
	/**
	 * 매출현황 일일 보고 수정
	 * Function : updateDaydayAnls
	 * 작성일 : 2018. 2. 22. 오전 11:39:38
	 * 작성자 : 정동수
	 * @param bisSVO
	 */
	void updateDaydayAnls(BISVO bisVO);

	Map<String, Object> selectPrdtSaleList(BISSVO bisSVO);

	Map<String, Object> selectPrdtSaleDtl(BISSVO bisSVO);

}
