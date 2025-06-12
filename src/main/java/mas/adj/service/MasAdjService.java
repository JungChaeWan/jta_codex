package mas.adj.service;

import java.util.List;

import oss.adj.vo.ADJSVO;
import oss.adj.vo.ADJVO;


public interface MasAdjService {

	/**
	 * 업체 정산 조회
	 * 파일명 : selectCorpAdjListYM
	 * 작성일 : 2016. 1. 13. 오전 11:52:22
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	List<ADJVO> selectCorpAdjListYM(ADJSVO adjSVO);
	
	/**
	 * 검색 기간에 해당하는 업체 정상 리스트
	 * Function : selectAdjListSearch
	 * 작성일 : 2017. 5. 23. 오전 10:21:47
	 * 작성자 : 정동수
	 * @param adjSVO
	 * @return
	 */
	List<ADJVO> selectCorpAdjListSearch(ADJSVO adjSVO);
	
	/**
	 * 대기 중인 정산 총 금액 산출
	 * Function : selectCorpAdjTotal
	 * 작성일 : 2017. 5. 23. 오전 11:55:37
	 * 작성자 : 정동수
	 * @param adjSVO
	 * @return
	 */
	int selectCorpAdjTotal(ADJSVO adjSVO);

}
