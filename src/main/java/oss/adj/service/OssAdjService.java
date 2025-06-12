package oss.adj.service;

import java.util.List;
import java.util.Map;

import common.LowerHashMap;
import oss.adj.vo.ADJDTLINFVO;
import oss.adj.vo.ADJSVO;
import oss.adj.vo.ADJTAMNACARDVO;
import oss.adj.vo.ADJVO;
import oss.coupon.vo.CPSVO;
import oss.point.vo.POINTVO;

public interface OssAdjService {

	/**
	 * 정산일자 구하기
	 * 파일명 : getAdjDt
	 * 작성일 : 2016. 1. 11. 오후 4:29:42
	 * 작성자 : 최영철
	 * @return
	 */
	String getAdjDt();

	/**
	 * 해당 날짜에 대한 정산건 조회
	 * 파일명 : selectAdjList
	 * 작성일 : 2016. 1. 11. 오후 4:33:46
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	List<ADJVO> selectAdjList(ADJSVO adjSVO);

	/**
	 * 정산건 추출 처리
	 * 파일명 : getAdjust
	 * 작성일 : 2016. 1. 11. 오후 5:38:51
	 * 작성자 : 최영철
	 * @param adjSVO
	 */
	void getAdjust(ADJSVO adjSVO);

	/**
	 * 정산 년월에 대한 정산건 리스트 조회
	 * 파일명 : selectAdjListYM
	 * 작성일 : 2016. 1. 12. 오전 10:14:14
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	List<ADJVO> selectAdjListYM(ADJSVO adjSVO);

	List<ADJVO> selectAdjListYM2(ADJSVO adjSVO);

	/**
	 * 날짜에 대한 정산 리스트 조회
	 * 파일명 : selectAdjList2
	 * 작성일 : 2016. 1. 12. 오후 1:44:46
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	List<ADJVO> selectAdjList2(ADJSVO adjSVO);

	/**
	 * 정산완료 처리
	 * 파일명 : adjustComplete
	 * 작성일 : 2016. 1. 12. 오후 4:44:04
	 * 작성자 : 최영철
	 * @param adjSVO
	 */
	void adjustComplete(ADJSVO adjSVO);

	/**
	 * 업체별 정산상세 리스트
	 * 파일명 : selectAdjInfList
	 * 작성일 : 2016. 1. 12. 오후 5:43:12
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	List<ADJDTLINFVO> selectAdjInfList(ADJSVO adjSVO);

	/**
	 * 정산 상세 단건 조회
	 * 파일명 : selectByAdjDtlInf
	 * 작성일 : 2016. 5. 31. 오후 1:36:24
	 * 작성자 : 최영철
	 * @param adjDtlInfVO
	 * @return
	 */
	ADJDTLINFVO selectByAdjDtlInf(ADJDTLINFVO adjDtlInfVO);
	
	/**
	 * 검색 기간에 해당하는 정상 리스트
	 * Function : selectAdjListSearch
	 * 작성일 : 2017. 5. 22. 오후 12:29:47
	 * 작성자 : 정동수
	 * @param adjSVO
	 * @return
	 */
	List<ADJVO> selectAdjListSearch(ADJSVO adjSVO);

	/**
	 * 정산 상세 수정
	 * 파일명 : updateAdjDtlInf
	 * 작성일 : 2016. 5. 31. 오후 1:43:42
	 * 작성자 : 최영철
	 * @param adjDtlInfVO
	 */
	void updateAdjDtlInf(ADJDTLINFVO adjDtlInfVO);

	/**
	* 설명 : 쿠폰 정산(업체별) 엑셀다운로드
	* 파일명 :
	* 작성일 : 2022-02-14 오후 5:22
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	List<ADJVO> selectAdjList3(ADJSVO adjSVO);

	/**
	* 설명 : 탐나는전 정산 엑셀다운로드
	* 파일명 :
	* 작성일 : 2022-05-26 오후 3:01
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	List<ADJTAMNACARDVO> selectAdjTamnacardList(ADJSVO adjSVO);

	List<LowerHashMap> selectPointList(ADJSVO adjSVO);
}
