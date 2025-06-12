package web.product.service;

import mas.ad.vo.*;
import oss.ad.vo.*;
import web.product.vo.ADTOTALPRICEVO;

import java.util.List;
import java.util.Map;




public interface WebAdProductService {

	Map<String, Object> selectAdPrdtList(AD_WEBLISTSVO prdtSVO); //카운트쿼리 포함 - 모바일용
	List<AD_WEBLISTVO> selectAdList(AD_WEBLISTSVO prdtSVO); //카운트쿼리 미포함 - 웹용
	List<AD_WEBLISTVO> selectAdMapList(AD_WEBLISTSVO prdtSVO); //모바일 지도 리스트
	List<AD_WEBLISTVO> selectAdListOssPrmt(AD_WEBLISTSVO prdtSVO); //기획전

	/**
	 * 주변 숙소 검색
	 * 파일명 : selectAdPrdtListDist
	 * 작성일 : 2015. 11. 12. 오후 5:02:54
	 * 작성자 : 신우섭
	 * @param strLat  : 위도
	 * @param strLon  : 경도
	 * @param nRowCnt : 가저올 개수
	 * @return
	 */
	List<AD_WEBLISTVO> selectAdPrdtListDist(String strLat, String strLon, int nRowCnt);


	List<AD_PRDTCNTVO> selectAdPrdtCnt(AD_WEBLISTSVO prdtSVO);

	List<AD_WEBLIST2VO> selectBestAdList(AD_WEBLISTSVO prdtSVO);

	AD_WEBDTLVO selectWebdtlByPrdt(AD_WEBDTLSVO prdtVO);


	List<AD_PRDTINFVO> selectAdPrdList(AD_PRDTINFVO prdtSVO);
	List<AD_AMTINFVO> selectAdAmtListDtl(AD_AMTINFSVO prdtSVO);

	AD_ADDAMTVO selectAddamtByDt(AD_ADDAMTVO prdtVO);

	AD_PRDTINFVO selectPrdtInfByMaster(AD_PRDTINFVO prdtVO);
	
	AD_PRDTINFVO selectPrdtInfByPrdtNum(AD_PRDTINFVO adPrdtVO);
	
	/**
	 * 날짜,몇박,인원 입력하면 금액 리턴하는 함수
	 * 파일명 : getTotalPrice
	 * 작성일 : 2015. 11. 4. 오전 8:53:07
	 * 작성자 : 신우섭
	 * @param prdtNum		: 상품명
	 * @param sFromDt		: 예약일자
	 * @param iNight		: 몇박
	 * @param iMenAdult		: 성인 예약인원
	 * @param iMenJunior	: 소아 예약인원
	 * @param iMenChild		: 유아 예약인원
	 * @return 0보다 큰 숫자이면 총금액, 0=예약인원 0, -1=예약가능인원 오버, -2=예약불가(마감/미정), -3=없는 상품번호
	 */
	int getTotalPrice(String prdtNum, String sFromDt, int iNight, int iMenAdult, int iMenJunior, int iMenChild);
	int getTotalPrice(ADTOTALPRICEVO adTotPrice);

	int getNmlAmt(String prdtNum, String sFromDt, int iNight, int iMenAdult, int iMenJunior, int iMenChild);
	int getNmlAmt(ADTOTALPRICEVO adTotPrice);
	
	/**
	 * 날짜,몇박,인원 입력하면 ADTOTALPRICEVO 리턴
	 * Function : getTotalPrice
	 * 작성일 : 2017. 10. 20. 오후 5:05:26
	 * 작성자 : 정동수
	 * @param prdtNum
	 * @param adTotPrice
	 * @return ADTOTALPRICEVO
	 */
	ADTOTALPRICEVO getTotalPrice(String prdtNum, ADTOTALPRICEVO adTotPrice);

	/*ADTOTALPRICEVO getNmlAmt(String prdtNum, ADTOTALPRICEVO adTotPrice);*/

	int getTotalPrice(String prdtNum, String sFromDt, String sNight, String sMenAdult, String sMenJunior, String sMenChild);

	int getNmlAmt(String prdtNum, String sFromDt, String sNight, String sMenAdult, String sMenJunior, String sMenChild);

	List<AD_WEBLIST4VO> selectAdListDist(AD_WEBDTLSVO prdtSVO);

	/**
	 * 숙박일에 해당하는 연박 적용 요금 리스트 출력
	 * Function : selectCtnAmtList
	 * 작성일 : 2017. 6. 29. 오전 10:53:15
	 * 작성자 : 정동수
	 * @param adAmtSVO
	 * @return
	 */
	List<AD_CTNAMTVO> selectCtnAmtList(AD_AMTINFSVO adAmtSVO);

	/**
	 * 날짜,박수에 핫딜,당일 특가 있는지 검사
	 * 파일명 : getHotdeallAndDayPrice
	 * 작성일 : 2015. 12. 4. 오전 9:44:08
	 * 작성자 : 신우섭
	 * @param adWeb
	 * @return
	 */
	AD_WEBLIST5VO getHotdeallAndDayPrice(AD_WEBLIST5VO adWeb);



	/**
	 * 숙소 전체의 이벤트 수
	 * 파일명 : getAllEventCnt
	 * 작성일 : 2015. 12. 21. 오후 5:46:33
	 * 작성자 : 신우섭
	 * @param prdtSVO
	 * @return
	 */
	Integer getAllEventCnt(AD_WEBLISTSVO prdtSVO);

	/**
	 * 숙소 카운트
	 * @param prdtSVO
	 * @return
	 */
	Integer getCntAdList(AD_WEBLISTSVO prdtSVO);

	/**
	 * 지도 현재 판매중인 숙소 리스트
	 * @return
	 */
	List<AD_WEBDTLVO> selectProductCorpMapList();

	/**
	 * 여행경비산출용 숙박 리스트 조회
	 * 파일명 : selectTeAdPrdtList
	 * 작성일 : 2016. 10. 25. 오전 11:33:04
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	Map<String, Object> selectTeAdPrdtList(AD_WEBLISTSVO prdtSVO);


	List<AD_WEBLISTVO> selectAdListOssKwa(String kwaNum);
	
	/**
	 * 숙박 베스트 상품 리스트 조회
	 * Function : selectAdBestList
	 * 작성일 : 2017. 11. 16. 오후 3:16:04
	 * 작성자 : 정동수
	 * @return
	 */
	List<AD_WEBLISTVO> selectAdBestList();

	List<AD_WEBLISTVO> selectAdNmList(AD_WEBLISTSVO prdtSVO);

	/**
	* 설명 : 일별 숙박요금 저장
	* 파일명 :
	* 작성일 : 2021-06-28 오전 11:27
	* 작성자 : chaewan.jung
	* @param : rsvNum, adRsvNum, ADTOTALPRICEVO
	* @return :
	* @throws Exception
	*/
	void insertRsvDayPrice( String rsvNum, String adRsvNum,ADTOTALPRICEVO adTotPrice);

	String selectTamnacardYn(String sPrdtNum);

	/**
	* 설명 : 당일예약 가능여부 체크
	* 파일명 :
	* 작성일 : 2022-01-06 오전 11:29
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	int getDayRsvCnt(Map<String, String> dayRsvCntMap);
}
