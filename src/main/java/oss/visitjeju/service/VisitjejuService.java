package oss.visitjeju.service;

import java.util.List;
import java.util.Map;

import common.LowerHashMap;
import oss.visitjeju.vo.VISITJEJUSVO;
import oss.visitjeju.vo.VISITJEJUVO;

public interface VisitjejuService {

	public Map<String, Object> selectVisitjejuList(VISITJEJUSVO visitjejuSVO);
	
	public Map<String, Object> selectPrdtVisitjejuList(VISITJEJUSVO visitjejuSVO);

	public LowerHashMap selectVisitjejuTypeCnt();

	public void insertVisitjeju(VISITJEJUSVO visitjejuSVO);
	
	public void deleteVisitjeju(VISITJEJUSVO visitjejuSVO);
	
	public void deleteApiCorpY(VISITJEJUSVO visitjejuVO);
	
	public void deleteApiCorpN(VISITJEJUSVO visitjejuVO);
}
