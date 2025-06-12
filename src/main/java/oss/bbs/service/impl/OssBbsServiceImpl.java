package oss.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import oss.bbs.service.OssBbsService;
import oss.bbs.vo.BBSGRPINFSVO;
import oss.bbs.vo.BBSGRPINFVO;
import oss.bbs.vo.BBSGRPSVO;
import oss.bbs.vo.BBSGRPVO;
import oss.bbs.vo.BBSSVO;
import oss.bbs.vo.BBSVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("ossBbsService")
public class OssBbsServiceImpl extends EgovAbstractServiceImpl implements OssBbsService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(OssBbsServiceImpl.class);

	@Resource(name = "bbsDAO")
	private BbsDAO bbsDAO;
	
	/**
	 * 게시판 목록
	 * 파일명 : selectBbsList
	 * 작성일 : 2015. 10. 1. 오후 2:43:00
	 * 작성자 : 신우섭
	 * @param bbsSV0
	 * @return
	 */
	@Override
	public Map<String, Object> selectBbsList(BBSSVO bbsSV0) {	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<BBSVO> resultList = bbsDAO.selectBbsList(bbsSV0);
		Integer totalCnt = bbsDAO.getCntBbsList(bbsSV0);
						
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}

	/**
	 * 게시판 단건 검색
	 * 파일명 : selectByBbs
	 * 작성일 : 2015. 10. 1. 오후 2:52:15
	 * 작성자 : 신우섭
	 * @param bbsSV0
	 * @return
	 */
	@Override
	public BBSVO selectByBbs(BBSSVO bbsSV0) {
		return bbsDAO.selectByBbs(bbsSV0);
	}

	/**
	 * 게시판 추가
	 * 파일명 : insertBbs
	 * 작성일 : 2015. 10. 2. 오전 9:44:39
	 * 작성자 : 신우섭
	 * @param bbsV0
	 */
	@Override
	public void insertBbs(BBSVO bbsV0) {
		bbsDAO.insertBbs(bbsV0);
		
	}

	/**
	 * 게시판 수정
	 * 파일명 : updateBbs
	 * 작성일 : 2015. 10. 2. 오전 9:44:41
	 * 작성자 : 신우섭
	 * @param bbsV0
	 */
	@Override
	public void updateBbs(BBSVO bbsV0) {
		bbsDAO.updateBbs(bbsV0);
		
	}

	/**
	 * 게시판 삭제
	 * 파일명 : deleteBbs
	 * 작성일 : 2015. 10. 2. 오전 9:44:44
	 * 작성자 : 신우섭
	 * @param bbsV0
	 */
	@Override
	public void deleteBbs(BBSVO bbsV0) {
		bbsDAO.deleteBbs(bbsV0);
		
	}


	/**
	 * 게시판 그룹 목록
	 * 파일명 : selectBbsGrpInfList
	 * 작성일 : 2015. 10. 2. 오후 3:17:59
	 * 작성자 : 신우섭
	 * @param bbsGrpInfSV0
	 * @return
	 */
	@Override
	public Map<String, Object> selectBbsGrpInfList(BBSGRPINFSVO bbsGrpInfSV0){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<BBSGRPINFVO> resultList = bbsDAO.selectBbsGrpInfList(bbsGrpInfSV0);
		Integer totalCnt = bbsDAO.getCntBbsGrpInfList(bbsGrpInfSV0);
						
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	@Override
	public BBSGRPINFVO selectByBbsGrpInf(BBSGRPINFSVO bbsGrpInfSV0) {		
		return bbsDAO.selectByBbsGrp(bbsGrpInfSV0);
	}

	
	@Override
	public void insertBbsGrpInf(BBSGRPINFVO bbsGrpInfV0) {
		bbsDAO.insertBbsGrpInf(bbsGrpInfV0);
	}
	
	@Override
	public void updateBbsGrpInf(BBSGRPINFVO bbsGrpInfV0) {
		bbsDAO.updateBbsGrpInf(bbsGrpInfV0);
		
	}
	
	@Override
	public void deleteBbsGrpInf(BBSGRPINFVO bbsGrpInfV0) {
		bbsDAO.deleteBbsGrpInf(bbsGrpInfV0);
		
	}

	@Override
	public Map<String, Object> selectBbsGrpList(BBSGRPSVO bbsGrpSV0) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<BBSGRPVO> resultList = bbsDAO.selectBbsGrpList(bbsGrpSV0);
		//Integer totalCnt = bbsDAO.getCntBbsGrpInfList(bbsGrpInfSV0);
						
		resultMap.put("resultList", resultList);
		//resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}

	@Override
	public Integer getCntByBbsInf(BBSGRPVO bbsGrpV0) {
		return bbsDAO.getCntBbsGrp(bbsGrpV0);
	}

	@Override
	public void insertBbsGrp(BBSGRPVO bbsGrpV0) {
		bbsDAO.insertBbsGrp(bbsGrpV0);
		
	}

	@Override
	public void deleteBbsGrp(BBSGRPVO bbsGrpV0) {
		bbsDAO.deleteBbsGrp(bbsGrpV0);
		
	}

	@Override
	public void deleteBbsGrpAll(BBSGRPVO bbsGrpV0) {
		bbsDAO.deleteBbsGrpAll(bbsGrpV0);
		
	}

}
