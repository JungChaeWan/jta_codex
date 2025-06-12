package oss.visitjeju.service.impl;

import java.util.List;

import common.LowerHashMap;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import oss.visitjeju.vo.VISITJEJUSVO;
import oss.visitjeju.vo.VISITJEJUVO;

@Repository("visitjejuDAO")
public class VisitjejuDAO extends EgovAbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List<VISITJEJUVO> selectVisitjejuList(VISITJEJUSVO visitjejuSVO) {
		return (List<VISITJEJUVO>) list("VISITJEJU_S_00", visitjejuSVO);
	}

	public Integer getCntVisitjejuList(VISITJEJUSVO visitjejuSVO) {
		return (Integer) select("VISITJEJU_S_01", visitjejuSVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<VISITJEJUVO> selectPrdtVisitjejuList(VISITJEJUSVO visitjejuSVO) {
		return (List<VISITJEJUVO>) list("VISITJEJU_S_02", visitjejuSVO);
	}

	@SuppressWarnings("unchecked")
	public Integer selectPrdtVisitjejuListCnt(VISITJEJUSVO visitjejuSVO) {
		return (Integer) select("VISITJEJU_S_03", visitjejuSVO);
	}

	public LowerHashMap selectVisitjejuTypeCnt() {return (LowerHashMap) select("VISITJEJU_S_05", "");}

	public void insertVisitjeju (VISITJEJUSVO visitjejuSVO) {
		insert("VISITJEJU_I_00", visitjejuSVO);
	}

	public void deleteVisitjeju (VISITJEJUSVO visitjejuSVO) {
		delete("VISITJEJU_D_00", visitjejuSVO);
	}
	
	public void deleteApiCorpY (VISITJEJUSVO visitjejuSVO) {
		delete("VISITJEJU_D_01", visitjejuSVO);
	}
	
	public void deleteApiCorpN (VISITJEJUSVO visitjejuSVO) {
		delete("VISITJEJU_D_02", visitjejuSVO);
	}
}
