package oss.adj.service.impl;

import java.util.List;
import java.util.Map;

import common.LowerHashMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import oss.adj.vo.ADJDTLINFVO;
import oss.adj.vo.ADJSVO;
import oss.adj.vo.ADJTAMNACARDVO;
import oss.adj.vo.ADJVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import oss.point.vo.POINTVO;


@Repository("adjDAO")
public class AdjDAO extends EgovAbstractDAO {

	/**
	 * 해당 년월 정산 리스트 조회
	 * 파일명 : selectAdjListYM
	 * 작성일 : 2016. 1. 12. 오전 10:16:40
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADJVO> selectAdjListYM(ADJSVO adjSVO) {
		return (List<ADJVO>) list("ADJ_S_02", adjSVO);
	}

	// 월별 업체별 정산 리스트
	public List<ADJVO> selectAdjListYM2(ADJSVO adjSVO) {
		return (List<ADJVO>) list("ADJ_S_08", adjSVO);
	}

	/**
	 * 정산일에 대한 정산 리스트 조회
	 * 파일명 : selectAdjList2
	 * 작성일 : 2016. 1. 12. 오후 1:45:59
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADJVO> selectAdjList2(ADJSVO adjSVO) {
		return (List<ADJVO>) list("ADJ_S_03", adjSVO);
	}

	/**
	 * 정산완료 처리
	 * 파일명 : adjustComplete
	 * 작성일 : 2016. 1. 12. 오후 4:44:46
	 * 작성자 : 최영철
	 * @param adjSVO
	 */
	public void adjustComplete(ADJSVO adjSVO) {
		update("ADJ_U_01", adjSVO);
	}
	
	/**
	 * 정산 판매 수수료율 수정 시 판매 수수료 수정
	 * Function : adjustUpdate
	 * 작성일 : 2017. 5. 25. 오전 11:58:44
	 * 작성자 : 정동수
	 * @param adjDtlInfVO
	 */
	public void adjustUpdate(ADJDTLINFVO adjDtlInfVO) {
		update("ADJ_U_02", adjDtlInfVO);
	}

	/**
	 * 업체별 정산 상세 내역 리스트
	 * 파일명 : selectAdjInfList
	 * 작성일 : 2016. 1. 12. 오후 5:43:57
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADJDTLINFVO> selectAdjInfList(ADJSVO adjSVO) {
		return (List<ADJDTLINFVO>) list("ADJDTLINF_S_02", adjSVO);
	}

	/**
	 * 업체 정산 조회
	 * 파일명 : selectCorpAdjListYM
	 * 작성일 : 2016. 1. 13. 오전 11:53:14
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADJVO> selectCorpAdjListYM(ADJSVO adjSVO) {
		return (List<ADJVO>) list("ADJ_S_04", adjSVO);
	}
	
	/**
	 * 정산상세 단건 조회
	 * 파일명 : selectByAdjDtlInf
	 * 작성일 : 2016. 5. 31. 오후 1:37:00
	 * 작성자 : 최영철
	 * @param adjDtlInfVO
	 * @return
	 */
	public ADJDTLINFVO selectByAdjDtlInf(ADJDTLINFVO adjDtlInfVO) {
		return (ADJDTLINFVO) select("ADJDTLINF_S_00", adjDtlInfVO);
	}

	/**
	 * 정산상세 수정 처리
	 * 파일명 : updateAdjDtlInf
	 * 작성일 : 2016. 5. 31. 오후 1:44:28
	 * 작성자 : 최영철
	 * @param adjDtlInfVO
	 */
	public void updateAdjDtlInf(ADJDTLINFVO adjDtlInfVO) {
		update("ADJDTLINF_U_00", adjDtlInfVO);
	}
	
	/**
	 * 검색 기간에 해당하는 정산 리스트
	 * Function : selectAdjListSearch
	 * 작성일 : 2017. 5. 22. 오후 2:10:08
	 * 작성자 : 정동수
	 * @param adjSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADJVO> selectAdjListSearch(ADJSVO adjSVO) {
		return (List<ADJVO>) list("ADJ_S_05", adjSVO);
	}

	/**
	 * 검색 기간에 해당하는 정상 리스트
	 * Function : selectCorpListSearch
	 * 작성일 : 2017. 5. 23. 오전 10:23:35
	 * 작성자 : 정동수
	 * @param adjSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADJVO> selectCorpAdjListSearch(ADJSVO adjSVO) {
		return (List<ADJVO>) list("ADJ_S_06", adjSVO);
	}
	
	/**
	 * 정산 총 누적 금액 산출
	 * Function : selectCorpAdjTotal
	 * 작성일 : 2017. 5. 23. 오전 11:57:47
	 * 작성자 : 정동수
	 * @param adjSVO
	 * @return
	 */
	public int selectCorpAdjTotal(ADJSVO adjSVO) {
		return (Integer) select("ADJ_S_07", adjSVO);
	}


	/**
	* 설명 : 쿠폰 정산(업체별) 엑셀다운로드
	* 파일명 :
	* 작성일 : 2022-02-14 오후 5:24
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public List<ADJVO> selectAdjList3(ADJSVO adjSVO) {
		return (List<ADJVO>) list("ADJ_S_09", adjSVO);
	}

	public 	List<ADJTAMNACARDVO> selectAdjTamnacardList(ADJSVO adjSVO){
		return (List<ADJTAMNACARDVO>) list("ADJ_S_10", adjSVO);
	}

	public List<LowerHashMap> selectPointList(ADJSVO adjSVO){
		return (List<LowerHashMap>) list("ADJ_S_11", adjSVO);
	}
}
