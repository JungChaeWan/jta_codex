package oss.visitjeju.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import common.LowerHashMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import oss.visitjeju.service.VisitjejuService;
import oss.visitjeju.vo.VISITJEJUSVO;
import oss.visitjeju.vo.VISITJEJUVO;

@Service("visitjejuService")
public class VisitjejuServiceImpl extends EgovAbstractServiceImpl implements VisitjejuService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(VisitjejuServiceImpl.class);

	@Resource(name = "visitjejuDAO")
	private VisitjejuDAO visitjejuDAO;
	
	@Override
	public Map<String, Object> selectVisitjejuList(VISITJEJUSVO visitjejuSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<VISITJEJUVO> resultList = visitjejuDAO.selectVisitjejuList(visitjejuSVO); 
		Integer totalCnt = visitjejuDAO.getCntVisitjejuList(visitjejuSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}
	
	@Override
	public Map<String, Object> selectPrdtVisitjejuList(VISITJEJUSVO visitjejuSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<VISITJEJUVO> resultList = visitjejuDAO.selectPrdtVisitjejuList(visitjejuSVO);
		Integer totalCnt = visitjejuDAO.selectPrdtVisitjejuListCnt(visitjejuSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public LowerHashMap selectVisitjejuTypeCnt(){
		return visitjejuDAO.selectVisitjejuTypeCnt();
	}

	@Override
	public void insertVisitjeju(VISITJEJUSVO visitjejuSVO) {
		visitjejuDAO.insertVisitjeju(visitjejuSVO);
	}
	
	@Override
	public void deleteVisitjeju(VISITJEJUSVO visitjejuSVO) {
		visitjejuDAO.deleteVisitjeju(visitjejuSVO);
	}
	
	@Override
	public void deleteApiCorpY(VISITJEJUSVO visitjejuSVO) {
		visitjejuDAO.deleteApiCorpY(visitjejuSVO);
	}
	
	@Override
	public void deleteApiCorpN(VISITJEJUSVO visitjejuSVO) {
		visitjejuDAO.deleteApiCorpN(visitjejuSVO);
	}
}
