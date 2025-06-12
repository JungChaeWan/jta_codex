package oss.bis.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import mas.anls.vo.ANLSSVO;

import org.springframework.stereotype.Service;

import oss.adj.vo.ADJVO;
import oss.anls.vo.ANLS10VO;
import oss.anls.vo.ANLS11VO;
import oss.bis.service.OssBisService;
import oss.bis.vo.BIS62VO;
import oss.bis.vo.BISSVO;
import oss.bis.vo.BISVO;

@Service("ossBisService")
public class OssBisServiceImpl implements OssBisService {
	@Resource(name = "ossBisDAO")
	private OssBisDAO ossBisDAO;
	
	@Resource(name = "ossBisHiDAO")
	private OssBisHiDAO ossBisHiDAO;
	
	@Override
	public Map<String, String> getTotalMemCnt() {
		Map<String, String> resultMap = new HashMap<String, String>();
		
		List<BISVO> bisList = ossBisDAO.selectTotalMemCnt();
		
		resultMap.put("totalMem", bisList.get(0).getTotalMemCnt());
		resultMap.put("totalCus", bisList.get(1).getTotalMemCnt());
		
		return resultMap;
	}

	@Override
	public ANLS10VO getUserPer(BISSVO bisSVO) {		
		return ossBisDAO.selectUserPer(bisSVO);
	}

	@Override
	public ANLS11VO getSaleAmtCnt(BISSVO bisSVO) {		
		return ossBisDAO.selectSaleAmtCnt(bisSVO);
	}

	@Override
	public List<BISVO> getAreaMemCusPer() {		
		String[] areaArr = {"서울", "경기", "인천", "부산", "대구", "대전", "광주", "울산", "강원", "경남", "경북", "전남", "전북", "충남", "충북", "제주특별자치도", "세종특별자치시"};
		
		List<BISVO> resultList = new ArrayList<BISVO>();
		List<BISVO> areaList = ossBisDAO.selectAreaMemCusPer(); 
		
		for (String area : areaArr) {
			for (Iterator<BISVO> item = areaList.iterator(); item.hasNext();) {
				BISVO bis = item.next();
				
				if (area.equals(bis.getArea())) {
					resultList.add(bis);
					item.remove();
					break;
				}
			}
		}
		
		return resultList;
	}

	@Override
	public Map<String, Object> getCorpAnlsList(BISSVO bisSVO) {
		Map<String, Object> restulMap = new HashMap<String, Object>();
		
		restulMap.put("totalCnt", ossBisDAO.selectTotalCorpAnls(bisSVO));
		restulMap.put("corpAnlsList", ossBisDAO.selectCorpAnls(bisSVO));		
		
		return restulMap;
	}

	@Override
	public BISVO getSumCorpAnls(BISSVO bisSVO) {		
		return ossBisDAO.selectSumCorpAnls(bisSVO);
	}

	@Override
	public List<ANLS11VO> selectSaleMonth(ANLSSVO anlsSVO) {		
		return ossBisDAO.selectSaleMonth(anlsSVO);
	}

	@Override
	public List<BISVO> selectYearSaleAmt(ANLSSVO anlsSVO) {
		return ossBisDAO.selectYearSaleAmt(anlsSVO);
	}

	@Override
	public Map<String, Map<String, String>> selectYearPrdtAmt(ANLSSVO anlsSVO) {
		LinkedHashMap<String, Map<String, String>> resultMap = new LinkedHashMap<String, Map<String,String>>();
		String[] prdtCateArr = {"AV", "AD", "RC", "C200", "C300", "C100", "SV", "C500"};
		String[] prdtColorArr = {"237,125,49", "91,155,213", "165,165,165", "68,114,196", "255,192,0", "24,188,16", "204,51,204", "255,0,102"};
		
		List<BISVO> prdtAmtList = ossBisDAO.selectYearPrdtAmt(anlsSVO);
		
		for (int i=0, end=prdtCateArr.length; i<end; i++) {
			ArrayList<String> amtArr = new ArrayList<String>();
			Map<String, String> prdtMap = new HashMap<String, String>();
			for (BISVO bisVO : prdtAmtList) {
				if (prdtCateArr[i].equals(bisVO.getPrdtGubun())) {
					
					if ("AD".equals(prdtCateArr[i])) {	// 숙소 단품을 숙소에 포함
						for (BISVO C410 : prdtAmtList) {
							if ("C410".equals(C410.getPrdtGubun())) {
								bisVO.setTotalRsvAmt(bisVO.getTotalRsvAmt() + C410.getTotalRsvAmt());
								break;
							}
						}
					} else if ("RC".equals(prdtCateArr[i])) { // 렌터카 단품을 렌터카에 포함
						for (BISVO C420 : prdtAmtList) {
							if ("C420".equals(C420.getPrdtGubun())) {
								bisVO.setTotalRsvAmt(bisVO.getTotalRsvAmt() + C420.getTotalRsvAmt());
								break;
							}
						}
					}
					
					amtArr.add(bisVO.getTotalRsvAmt());
					
					prdtMap.put("title", bisVO.getPrdtCateNm());
					prdtMap.put("borderColor", prdtColorArr[i]);
				}
			}
			
			for (int s=amtArr.size()+1; s<=12; s++) {
				amtArr.add("0");
			}
				
			prdtMap.put("data", amtArr.toString());
			
			resultMap.put(prdtCateArr[i], prdtMap);
		}
		
		return resultMap;
	}

	@Override
	public List<BISVO> selectCancelDftCur(ANLSSVO anlsSVO) {
		return ossBisDAO.selectCancelDftCur(anlsSVO);
	}

	@Override
	public List<BISVO> selectCancelDftPrev(ANLSSVO anlsSVO) {
		return ossBisDAO.selectCancelDftPrev(anlsSVO);
	}

	@Override
	public BISVO selectPrdtRsvCancelAmt(BISSVO bisSVO) {		
		return ossBisDAO.selectPrdtRsvCancelAmt(bisSVO);
	}

	@Override
	public LinkedHashMap<String, LinkedHashMap<String, String>> selectPrdtRsvTimeCnt(BISSVO bisSVO) {
		LinkedHashMap<String, LinkedHashMap<String, String>> resultMap = new LinkedHashMap<String, LinkedHashMap<String,String>>();
		List<BISVO> bisList = ossBisDAO.selectPrdtRsvTimeCnt(bisSVO);
		
		String timeGubun = null;
		LinkedHashMap<String, String> weekMap = new LinkedHashMap<String, String>();
		LinkedHashMap<String, String> totalWeekMap = new LinkedHashMap<String, String>();
		for (BISVO bis : bisList) {			
			if (timeGubun == null) {
				timeGubun = bis.getPrdtGubun();
			}
			
			if (bis.getPrdtGubun().equals(timeGubun)) {
				weekMap.put(bis.getRsvWeekGubun(), bis.getRsvCnt());
			}
			else {
				resultMap.put(timeGubun, weekMap);
				timeGubun = bis.getPrdtGubun();
				
				weekMap = new LinkedHashMap<String, String>();
				weekMap.put(bis.getRsvWeekGubun(), bis.getRsvCnt());
			}
			
			// 요일별 합계
			if (totalWeekMap.get(bis.getRsvWeekGubun()) == null) {
				totalWeekMap.put(bis.getRsvWeekGubun(), "0");
			}
			
			totalWeekMap.put(bis.getRsvWeekGubun(), "" + (Integer.parseInt(totalWeekMap.get(bis.getRsvWeekGubun())) + Integer.parseInt(bis.getRsvCnt())));
		}
		resultMap.put(timeGubun, weekMap);
		resultMap.put("totalWeek", totalWeekMap);
		
		return resultMap;
	}

	@Override
	public List<BISVO> selectPrdtCancelCnt(BISSVO bisSVO) {
		return ossBisDAO.selectPrdtCancelCnt(bisSVO);
	}

	@Override
	public LinkedHashMap<String, LinkedHashMap<String, String>> selectAvFromTimeCnt(BISSVO bisSVO) {
		LinkedHashMap<String, LinkedHashMap<String, String>> resultMap = new LinkedHashMap<String, LinkedHashMap<String,String>>();
		List<BISVO> bisList = ossBisDAO.selectAvFromTimeCnt(bisSVO);
		
		String timeGubun = null;
		LinkedHashMap<String, String> weekMap = new LinkedHashMap<String, String>();
		LinkedHashMap<String, String> totalWeekMap = new LinkedHashMap<String, String>();
		for (BISVO bis : bisList) {
			if ("07PREV".equals(bis.getPrdtGubun())) {
				bis.setPrdtGubun("20:00~08:00");
			}
			if (timeGubun == null) {
				timeGubun = bis.getPrdtGubun();
			}
			
			if (bis.getPrdtGubun().equals(timeGubun)) {
				weekMap.put(bis.getRsvWeekGubun(), bis.getRsvCnt());
			}
			else {
				resultMap.put(timeGubun, weekMap);
				timeGubun = bis.getPrdtGubun();
				
				weekMap = new LinkedHashMap<String, String>();
				weekMap.put(bis.getRsvWeekGubun(), bis.getRsvCnt());
			}
			
			// 요일별 합계
			if (totalWeekMap.get(bis.getRsvWeekGubun()) == null) {
				totalWeekMap.put(bis.getRsvWeekGubun(), "0");
			}
			
			totalWeekMap.put(bis.getRsvWeekGubun(), "" + (Integer.parseInt(totalWeekMap.get(bis.getRsvWeekGubun())) + Integer.parseInt(bis.getRsvCnt())));
		}
		resultMap.put(timeGubun, weekMap);
		resultMap.put("totalWeek", totalWeekMap);
		
		return resultMap;
	}

	@Override
	public List<BISVO> selectAvRsvPeriodPer(BISSVO bisSVO) {		
		return ossBisDAO.selectAvRsvPeriodPer(bisSVO);
	}

	@Override
	public List<BISVO> selectAvTypePer(BISSVO bisSVO) {		
		return ossBisDAO.selectAvTypePer(bisSVO);
	}

	@Override
	public List<BISVO> selectAvCompanyPer(BISSVO bisSVO) {
		return ossBisDAO.selectAvCompanyPer(bisSVO);
	}

	@Override
	public List<BISVO> selectAvFromCityPer(BISSVO bisSVO) {		
		return ossBisDAO.selectAvFromCityPer(bisSVO);
	}

	@Override
	public List<BISVO> selectAvTourPeriodPer(BISSVO bisSVO) {		
		return ossBisDAO.selectAvTourPeriodPer(bisSVO);
	}
	
	@Override
	public List<BISVO> selectAdCheckInCnt(BISSVO bisSVO) {		
		return ossBisDAO.selectAdCheckInCnt(bisSVO);
	}

	@Override
	public List<BISVO> selectAdCheckOutCnt(BISSVO bisSVO) {
		return ossBisDAO.selectAdCheckOutCnt(bisSVO);
	}

	@Override
	public List<BISVO> selectAdTypePer(BISSVO bisSVO) {		
		return ossBisDAO.selectAdTypePer(bisSVO);
	}

	@Override
	public List<BISVO> selectAdPeriodPer(BISSVO bisSVO) {		
		return ossBisDAO.selectAdPeriodPer(bisSVO);
	}

	@Override
	public List<BISVO> selectAdPricePer(BISSVO bisSVO) {
		return ossBisDAO.selectAdPricePer(bisSVO);
	}

	@Override
	public List<BISVO> selectAdAreaPer(BISSVO bisSVO) {		
		return ossBisDAO.selectAdAreaPer(bisSVO);
	}

	@Override
	public BISVO selectAdCurRsvPer(BISSVO bisSVO) {		
		return ossBisDAO.selectAdCurRsvPer(bisSVO);
	}

	@Override
	public List<BISVO> selectAdCancelRsvPer(BISSVO bisSVO) {
		return ossBisDAO.selectAdCancelRsvPer(bisSVO);
	}

	@Override
	public List<BISVO> selectAdCancelUsePer(BISSVO bisSVO) {		
		return ossBisDAO.selectAdCancelUsePer(bisSVO);
	}

	@Override
	public List<BISVO> selectRcStartCnt(BISSVO bisSVO) {
		return ossBisDAO.selectRcStartCnt(bisSVO);
	}

	@Override
	public List<BISVO> selectRcTypePer(BISSVO bisSVO) {		
		return ossBisDAO.selectRcTypePer(bisSVO);
	}

	@Override
	public List<BISVO> selectRcPeriodPer(BISSVO bisSVO) {		
		return ossBisDAO.selectRcPeriodPer(bisSVO);
	}

	@Override
	public List<BISVO> selectRcFuelPer(BISSVO bisSVO) {		
		return ossBisDAO.selectRcFuelPer(bisSVO);
	}

	@Override
	public List<BISVO> selectRcCancelRsvPer(BISSVO bisSVO) {		
		return ossBisDAO.selectRcCancelRsvPer(bisSVO);
	}

	@Override
	public List<BISVO> selectRcCancelUsePer(BISSVO bisSVO) {		
		return ossBisDAO.selectRcCancelUsePer(bisSVO);
	}

	@Override
	public List<BISVO> selectSpcUseCnt(BISSVO bisSVO) {		
		return ossBisDAO.selectSpcUseCnt(bisSVO);
	}

	@Override
	public List<BISVO> selectSpcTypePer(BISSVO bisSVO) {		
		return ossBisDAO.selectSpcTypePer(bisSVO);
	}

	@Override
	public List<BISVO> selectSpcBuyCntPer(BISSVO bisSVO) {		
		return ossBisDAO.selectSpcBuyCntPer(bisSVO);
	}

	@Override
	public List<BISVO> selectSpcBuyTimePer(BISSVO bisSVO) {
		return ossBisDAO.selectSpcBuyTimePer(bisSVO);
	}

	@Override
	public List<BISVO> selectSpcCancelRsvPer(BISSVO bisSVO) {
		return ossBisDAO.selectSpcCancelRsvPer(bisSVO);
	}

	@Override
	public List<BISVO> selectSptTypePer(BISSVO bisSVO) {		
		return ossBisDAO.selectSptTypePer(bisSVO);
	}

	@Override
	public List<BISVO> selectSptPricePer(BISSVO bisSVO) {		
		return ossBisDAO.selectSptPricePer(bisSVO);
	}

	@Override
	public List<BISVO> selectSptCancelRsvPer(BISSVO bisSVO) {
		return ossBisDAO.selectSptCancelRsvPer(bisSVO);
	}

	@Override
	public List<BISVO> selectSptCancelUsePer(BISSVO bisSVO) {
		return ossBisDAO.selectSptCancelUsePer(bisSVO);
	}
	
	@Override
	public List<BISVO> selectSvTypePer(BISSVO bisSVO) {
		return ossBisDAO.selectSvTypePer(bisSVO);
	}

	@Override
	public List<BISVO> selectSvBuyCntPer(BISSVO bisSVO) {
		return ossBisDAO.selectSvBuyCntPer(bisSVO);
	}

	@Override
	public List<BISVO> selectSvCancelRsvPer(BISSVO bisSVO) {
		return ossBisDAO.selectSvCancelRsvPer(bisSVO);
	}

	@Override
	public List<BISVO> selectAdtmYear(BISSVO bisSVO) {		
		return ossBisDAO.selectAdtmYear(bisSVO);
	}

	@Override
	public List<BISVO> selectAdtmMonth(BISSVO bisSVO) {
		return ossBisDAO.selectAdtmMonth(bisSVO);
	}
	
	@Override
	public List<BISVO> selectDayCondition(BISSVO bisSVO) {
		List<BISVO> resultList = new ArrayList<BISVO>();
		Map<String, BISVO> tmpMap = new HashMap<String, BISVO>();
		LinkedHashMap<String, String> cateMap = new LinkedHashMap<String, String>();
		
		cateMap.put("AD", "숙박");
		cateMap.put("RC", "렌터카");
		/*cateMap.put("C170", "골프패키지");	*/
		/*cateMap.put("C180", "테마여행");*/
		/*cateMap.put("C120", "에어카텔");*/
		cateMap.put("C200", "관광지/레저");
		cateMap.put("C300", "맛집");
		/*cateMap.put("C410", "숙소 단품");*/
		cateMap.put("C100", "여행사 상품");
		/*cateMap.put("C130", "카텔/에어카텔");
		cateMap.put("C160", "버스/택시");*/
		cateMap.put("SV", "제주특산/기념품");
		/*cateMap.put("C420", "렌터카 단품");*/
		cateMap.put("C500", "카시트/유모차");
		
		//(제외) cateMap.put("C140", "에어카");
		// cateMap.put("C150", "에어텔");
		// cateMap.put("C110", "할인/특가항공");
		
		Map<String, String> matchMap = new HashMap<String, String>();
		matchMap.put("C410", "AD");		// 숙박 <- 숙소단품 포함
		matchMap.put("C420", "RC");		// 렌터카 <- 렌터카단품 포함
		/*matchMap.put("C120", "C130");	// 여행사 상품 <- 에어카텔 포함
		matchMap.put("C160", "C130");	// 여행사 상품 <- 버스/택시 포함
		matchMap.put("C170", "C130");	// 여행사 상품 <- 골프패키지 포함		
		matchMap.put("C180", "C130");	// 여행사 상품 <- 테마여행 포함
*/		
		List<BISVO> dayList = ossBisDAO.selectDayCondition(bisSVO);
		
		// 포함되는 값 설정
		for (BISVO bisVO : dayList) {
			if (matchMap.containsKey(bisVO.getPrdtGubun())) {				
				tmpMap.put(matchMap.get(bisVO.getPrdtGubun()), bisVO);
				
				bisVO.setPrdtGubun(matchMap.get(bisVO.getPrdtGubun()));
			}
		}
		
		
		for (Entry<String, String> cate : cateMap.entrySet()) {
			int containChk = 0;
						
			for (BISVO bisVO : dayList) {
				if (cate.getKey().equals(bisVO.getPrdtGubun())) {
					containChk = 1;
										
					if (tmpMap.containsKey(cate.getKey())) {
						BISVO tmpObj = tmpMap.get(cate.getKey());
						
						bisVO.setRsvCnt("" + (Integer.parseInt(bisVO.getRsvCnt()) + Integer.parseInt(tmpObj.getRsvCnt())));
						bisVO.setAccountCnt("" + (Integer.parseInt(bisVO.getAccountCnt()) + Integer.parseInt(tmpObj.getAccountCnt())));
						bisVO.setSaleAmt("" + (Integer.parseInt(bisVO.getSaleAmt()) + Integer.parseInt(tmpObj.getSaleAmt())));
						bisVO.setDisAmt("" + (Integer.parseInt(bisVO.getDisAmt()) + Integer.parseInt(tmpObj.getDisAmt())));
						bisVO.setCancelReqAmt("" + (Integer.parseInt(bisVO.getCancelReqAmt()) + Integer.parseInt(tmpObj.getCancelReqAmt())));
						bisVO.setRefundReqAmt("" + (Integer.parseInt(bisVO.getRefundReqAmt()) + Integer.parseInt(tmpObj.getRefundReqAmt())));
					}
					
					bisVO.setPrdtGubun(cate.getValue());
					resultList.add(bisVO);
					break;
				}
			}
			
			if (containChk == 0) {
				BISVO bisVO = new BISVO();
				bisVO.setPrdtGubun(cate.getValue());
				bisVO.setRsvCnt("0");
				bisVO.setAccountCnt("0");
				bisVO.setDisAccountCnt("0");
				bisVO.setSaleAmt("0");
				bisVO.setDisAmt("0");
				bisVO.setPointAmt("0");
				bisVO.setCancelReqAmt("0");
				bisVO.setRefundReqAmt("0");
				
				resultList.add(bisVO);
			}
		}
		
		return resultList;
	}

	@Override
	public BISVO selectDayMember(BISSVO bisSVO) {
		return ossBisDAO.selectDayMember(bisSVO);
	}

	@Override
	public BISVO selectTotalAdj(BISSVO bisSVO) {		
		return ossBisDAO.selectTotalAdj(bisSVO);
	}

	@Override
	public Map<String, Object> selectAdjList(BISSVO bisSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("adjList", ossBisDAO.selectAdjList(bisSVO));
		resultMap.put("adjTotalCnt", ossBisDAO.selectAdjTotalCnt(bisSVO));
		
		return resultMap;
	}	
	
	@Override
	public List<BISVO> selectAdjListExcel(BISSVO bisSVO) {		
		return ossBisDAO.selectAdjListExcel(bisSVO);
	}

	@Override
	public List<BISVO> selectPayDivPer(BISSVO bisSVO) {		
		return ossBisDAO.selectPayDivPer(bisSVO);
	}

	@Override
	public BISVO selectRsvMemberPer(BISSVO bisSVO) {		
		return ossBisDAO.selectRsvMemberPer(bisSVO);
	}

	@Override
	public Map<String, Object> selectCorpNmList(BISSVO bisSVO) {		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("corpList", ossBisDAO.selectCorpNmList(bisSVO));
		resultMap.put("corpTotalCnt", ossBisDAO.selectCorpNmTotalCnt(bisSVO));
		
		return resultMap;
	}

	@Override
	public List<BISVO> selectRcTypeCntPer(BISSVO bisSVO) {
		return ossBisDAO.selectRcTypeCntPer(bisSVO);
	}

	@Override
	public List<ADJVO> selectCorpAdjList(BISSVO bisSVO) {		
		return ossBisDAO.selectCorpAdjList(bisSVO);
	}

	@Override
	public BISVO selectCouponRsvAmt(BISSVO bisSVO) {
		return ossBisHiDAO.selectCouponRsvAmt(bisSVO);
	}

	@Override
	public LinkedHashMap<String, LinkedHashMap<String, String>> selectCouponRsvTimeCnt(BISSVO bisSVO) {
		LinkedHashMap<String, LinkedHashMap<String, String>> resultMap = new LinkedHashMap<String, LinkedHashMap<String,String>>();
		List<BISVO> bisList = ossBisHiDAO.selectCouponRsvTimeCnt(bisSVO);
		
		String timeGubun = null;
		LinkedHashMap<String, String> weekMap = new LinkedHashMap<String, String>();
		LinkedHashMap<String, String> totalWeekMap = new LinkedHashMap<String, String>();
		for (BISVO bis : bisList) {			
			if (timeGubun == null) {
				timeGubun = bis.getPrdtGubun();
			}
			
			if (bis.getPrdtGubun().equals(timeGubun)) {
				weekMap.put(bis.getRsvWeekGubun(), bis.getRsvCnt());
			}
			else {
				resultMap.put(timeGubun, weekMap);
				timeGubun = bis.getPrdtGubun();
				
				weekMap = new LinkedHashMap<String, String>();
				weekMap.put(bis.getRsvWeekGubun(), bis.getRsvCnt());
			}
			
			// 요일별 합계
			if (totalWeekMap.get(bis.getRsvWeekGubun()) == null) {
				totalWeekMap.put(bis.getRsvWeekGubun(), "0");
			}
			
			totalWeekMap.put(bis.getRsvWeekGubun(), "" + (Integer.parseInt(totalWeekMap.get(bis.getRsvWeekGubun())) + Integer.parseInt(bis.getRsvCnt())));
		}
		resultMap.put(timeGubun, weekMap);
		resultMap.put("totalWeek", totalWeekMap);
		
		return resultMap;
	}

	@Override
	public List<BISVO> selectCouponBuyCntPer(BISSVO bisSVO) {		
		return ossBisHiDAO.selectCouponBuyCntPer(bisSVO);
	}
	
	/**
	 * 입점업체현황
	 * 파일명 : selectDayCorpList
	 * 작성일 : 2017. 2. 14. 오전 10:46:46
	 * 작성자 : 최영철
	 * @param bisSVO
	 * @return
	 */
	@Override
	public List<BIS62VO> selectDayCorpList(BISSVO bisSVO){
		return ossBisDAO.selectDayCorpList(bisSVO);
	}
	
	/**
	 * 업체구분별 상품현황
	 * 파일명 : selectDayPrdtList
	 * 작성일 : 2017. 2. 14. 오후 3:37:24
	 * 작성자 : 최영철
	 * @param bisSVO
	 * @return
	 */
	@Override
	public List<BIS62VO> selectDayPrdtList(BISSVO bisSVO){
		return ossBisDAO.selectDayPrdtList(bisSVO);
	}

	/**
	 * 매출현황 일일 보고 정보 출력
	 * Function : selectDaydayAnls
	 * 작성일 : 2018. 2. 22. 오후 12:03:45
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@Override
	public BISVO selectDaydayAnls(BISSVO bisSVO) {		
		return ossBisDAO.selectDaydayAnls(bisSVO);
	}
	
	/**
	 * 매출현황 일일 보고 수정
	 * Function : updateDaydayAnls
	 * 작성일 : 2018. 2. 22. 오전 11:39:38
	 * 작성자 : 정동수
	 * @param bisSVO
	 */
	@Override
	public void updateDaydayAnls(BISVO bisVO) {
		ossBisDAO.updateDaydayAnls(bisVO);
	}

	/**
	 * 매출현황 일일 보고의 방문자수 정보 출력
	 * Function : selectVisitorInfo
	 * 작성일 : 2018. 2. 22. 오후 2:22:49
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@Override
	public BISVO selectVisitorInfo(BISSVO bisSVO) {
		return ossBisDAO.selectVisitorInfo(bisSVO);
	}

	/**
	 * 매출현황 일일 보고의 광고금액 출력
	 * Function : selectAdtmAmt
	 * 작성일 : 2018. 2. 22. 오후 2:52:34
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@Override
	public int selectAdtmAmt(BISSVO bisSVO) {		
		return ossBisDAO.selectAdtmAmt(bisSVO);
	}

	/**
	 * 매출현황 일일 보고의 항공 정보 출력
	 * Function : selectDayAvInfo
	 * 작성일 : 2018. 2. 22. 오후 3:37:51
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@Override
	public BISVO selectDayAvInfo(BISSVO bisSVO) {
		return ossBisDAO.selectDayAvInfo(bisSVO);
	}

	/**
	 * 매출현황 일일 보고의 예약 정보 출력
	 * Function : selectDayRsvInfo
	 * 작성일 : 2018. 2. 23. 오전 9:00:07
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@Override
	public Map<String, BISVO> selectDayRsvInfo(BISSVO bisSVO) {
		Map<String, BISVO> resultMap = new HashMap<String, BISVO>();
		
		List<BISVO> rsvList = ossBisDAO.selectDayRsvInfo(bisSVO);
		for (BISVO rsv : rsvList) {
			resultMap.put(rsv.getPrdtGubun(), rsv);
		}
		
		return resultMap;
	}

	/**
	 * 매출현황 일일 보고의 전년도 동월 매출 정보 출력
	 * Function : selectDayPrevInfo
	 * 작성일 : 2018. 3. 2. 오전 11:17:32
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @return
	 */
	@Override
	public BISVO selectDayPrevInfo(BISSVO bisSVO) {		
		return ossBisDAO.selectDayPrevInfo(bisSVO);
	}

	@Override
	public Map<String, Object> selectPrdtSaleList(BISSVO bisSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultList", ossBisDAO.selectPrdtSaleList(bisSVO));
		resultMap.put("resultCnt", ossBisDAO.selectPrdtSaleListCnt(bisSVO));

		return resultMap;
	}

	@Override
	public Map<String, Object> selectPrdtSaleDtl(BISSVO bisSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultList", ossBisDAO.selectPrdtSaleDtl(bisSVO));

		return resultMap;
	}
}
