package oss.bbs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.bbs.vo.BBSGRPINFSVO;
import oss.bbs.vo.BBSGRPINFVO;
import oss.bbs.vo.BBSGRPSVO;
import oss.bbs.vo.BBSGRPVO;
import oss.bbs.vo.BBSSVO;
import oss.bbs.vo.BBSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


/**
 * <pre>
 * 파일명 : BbsDAO.java
 * 작성일 : 2015. 10. 2. 오전 9:32:28
 * 작성자 : 신우섭
 */
@Repository("bbsDAO")
public class BbsDAO extends EgovAbstractDAO {


	
	/**
	 * 게시판 전체 목록
	 * 파일명 : selectBbsList
	 * 작성일 : 2015. 10. 1. 오후 2:23:01
	 * 작성자 : 신우섭
	 * @param bbsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BBSVO> selectBbsList(BBSSVO bbsSVO) {
		return (List<BBSVO>) list("BBS_S_01", bbsSVO);
	}
	
	
	/**
	 * 게시판 전체 카운트
	 * 파일명 : getCntBbsList
	 * 작성일 : 2015. 10. 1. 오후 2:27:21
	 * 작성자 : 신우섭
	 * @param bbsSVO
	 * @return
	 */
	public Integer getCntBbsList(BBSSVO bbsSVO) {
		return (Integer) select("BBS_S_02", bbsSVO);
	}
	
	
	/**
	 * 게시판 삽입
	 * 파일명 : insertBbs
	 * 작성일 : 2015. 10. 2. 오전 9:32:50
	 * 작성자 : 신우섭
	 * @param bbsVO
	 */
	public void insertBbs(BBSVO bbsVO) {
		insert("BBS_I_00", bbsVO);
	}

	/**
	 * 게시판 단건 조회
	 * 파일명 : selectByCd
	 * 작성일 : 2015. 10. 1. 오후 2:28:14
	 * 작성자 : 신우섭
	 * @param bbssVO
	 * @return
	 */
	public BBSVO selectByBbs(BBSSVO bbssVO) {
		return (BBSVO) select("BBS_S_00", bbssVO);
	}

	/**
	 * 게시판 수정
	 * 파일명 : updateBbs
	 * 작성일 : 2015. 10. 2. 오전 9:39:00
	 * 작성자 : 신우섭
	 * @param bbsVO
	 */
	public void updateBbs(BBSVO bbsVO) {
		update("BBS_U_00", bbsVO);
	}

	/**
	 * 게시판 삭제
	 * 파일명 : deleteBbs
	 * 작성일 : 2015. 10. 2. 오전 9:39:37
	 * 작성자 : 신우섭
	 * @param bbsVO
	 */
	public void deleteBbs(BBSVO bbsVO) {
		delete("BBS_D_00", bbsVO);
	}
	
	
	
	@SuppressWarnings("unchecked")
	public List<BBSGRPINFVO> selectBbsGrpInfList(BBSGRPINFSVO bbsGrpInfSVO) {
		return (List<BBSGRPINFVO>) list("BBSGRPINF_S_01", bbsGrpInfSVO);
	}
	
	public Integer getCntBbsGrpInfList(BBSGRPINFSVO bbsGrpInfSVO) {
		return (Integer) select("BBSGRPINF_S_02", bbsGrpInfSVO);
	}
	
	public BBSGRPINFVO selectByBbsGrp(BBSGRPINFSVO bbsGrpInfSVO) {
		return (BBSGRPINFVO) select("BBSGRPINF_S_00", bbsGrpInfSVO);
	}
	
	public void insertBbsGrpInf(BBSGRPINFVO bbsGrpInfVO) {
		insert("BBSGRPINF_I_00", bbsGrpInfVO);
	}
	
	public void updateBbsGrpInf(BBSGRPINFVO bbsGrpInfVO) {
		update("BBSGRPINF_U_00", bbsGrpInfVO);
	}
	
	public void deleteBbsGrpInf(BBSGRPINFVO bbsGrpInfVO) {
		delete("BBSGRPINF_D_00", bbsGrpInfVO);
	}
	
	
	
	@SuppressWarnings("unchecked")
	public List<BBSGRPVO> selectBbsGrpList(BBSGRPSVO bbsGrpSVO) {
		return (List<BBSGRPVO>) list("BBSGRP_S_00", bbsGrpSVO);
	}
	
	public Integer getCntBbsGrp(BBSGRPVO bbsGrpVO) {
		return (Integer) select("BBSGRP_S_01", bbsGrpVO);
	}

	public void insertBbsGrp(BBSGRPVO bbsGrpVO) {
		insert("BBSGRP_I_00", bbsGrpVO);
	}
	
	public void deleteBbsGrp(BBSGRPVO bbsGrpVO) {
		delete("BBSGRP_D_00", bbsGrpVO);
	}
	
	public void deleteBbsGrpAll(BBSGRPVO bbsGrpVO) {
		delete("BBSGRP_D_01", bbsGrpVO);
	}

}
