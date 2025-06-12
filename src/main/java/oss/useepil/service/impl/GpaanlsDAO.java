package oss.useepil.service.impl;

import org.springframework.stereotype.Repository;

import oss.useepil.vo.GPAANLSSVO;
import oss.useepil.vo.GPAANLSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;




/**
 * 평점 통계 관련
 * 파일명 : GpaanlsDAO.java
 * 작성일 : 2015. 10. 27. 오전 9:14:01
 * 작성자 : 신우섭
 */
@Repository("gpaanlsDAO")
public class GpaanlsDAO extends EgovAbstractDAO {

	/**
	 * 평점 평균,숫자 단건 검색
	 * 파일명 : selectByGpaanls
	 * 작성일 : 2015. 10. 27. 오전 9:11:57
	 * 작성자 : 신우섭
	 * @param gpaanlsVO
	 * @return
	 */
	public GPAANLSVO selectByGpaanls(GPAANLSVO gpaanlsVO) {
		return (GPAANLSVO) select("GPAANLS_S_00", gpaanlsVO);
	}

	/**
	 * 평점 평균,숫자 얻기
	 * 파일명 : GetGpaanls
	 * 작성일 : 2015. 10. 27. 오전 9:12:22
	 * 작성자 : 신우섭
	 * @param gpaanlsSVO
	 * @return
	 */
	public GPAANLSVO GetGpaanls(GPAANLSSVO gpaanlsSVO) {
		return (GPAANLSVO) select("GPAANLS_S_01", gpaanlsSVO);
	}

	/**
	 * 평점 평균,숫자 머지
	 * 파일명 : mergeGpaanls
	 * 작성일 : 2015. 10. 27. 오전 9:13:46
	 * 작성자 : 신우섭
	 * @param gpaanlsSVO
	 */
	public void mergeGpaanls(GPAANLSSVO gpaanlsSVO) {
		update("GPAANLSF_M_00", gpaanlsSVO);
	}
}
