package oss.site.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.site.vo.SVCRTNPRDTVO;
import oss.site.vo.SVCRTNVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 제주특산/기념품 큐레이터 DAO 관리
 * 파일명 : CrtnDAO.java
 * 작성일 : 2017. 11. 13. 오후 4:07:50
 * 작성자 : 정동수
 */
@Repository("crtnDAO")
public class CrtnDAO extends EgovAbstractDAO {
	@SuppressWarnings("unchecked")
	public List<SVCRTNVO> selectCrtnList(SVCRTNVO crtnVO) {
		return (List<SVCRTNVO>) list("CRTN_S_00", crtnVO);
	}
	
	public Integer getCntCrtnList(SVCRTNVO crtnVO) {
		return (Integer) select("CRTN_S_01", crtnVO);
	}
	
	public String getCrtnPk(SVCRTNVO crtnVO) {
		return (String) select("CRTN_S_02", crtnVO);
	}
	
	public SVCRTNVO selectByCrtn(SVCRTNVO crtnVO) {
		return (SVCRTNVO) select("CRTN_S_03", crtnVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<SVCRTNVO> selectCrtnWebList() {
		return (List<SVCRTNVO>) list("CRTN_S_04");
	}
	
	public String insertCrtn(SVCRTNVO crtnVO) {
		return (String) insert("CRTN_I_00", crtnVO);
	}
	
	public void updateCrtn(SVCRTNVO crtnVO) {
		update("CRTN_U_00", crtnVO);
	}
	
	public void incremntCrtnPrintSn(SVCRTNVO crtnVO) {
		update("CRTN_U_01", crtnVO);
	}
	
	public void downCrtnPrintSn(SVCRTNVO crtnVO) {
		update("CRTN_U_02", crtnVO);
	}
	
	public void deleteCrtn(SVCRTNVO crtnVO) {
		delete("CRTN_D_00", crtnVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<SVCRTNPRDTVO> selectCrtnPrdtList(SVCRTNVO crtnVO) {
		return (List<SVCRTNPRDTVO>) list("CRTN_PRDT_S_01", crtnVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<SVCRTNPRDTVO> selectCrtnPrdtWebList() {
		return (List<SVCRTNPRDTVO>) list("CRTN_PRDT_S_02");
	}
	
	public void insertCrtnPrdtOne(SVCRTNVO crtnVO) {
		insert("CRTN_PRDT_I_00", crtnVO);
	}
	
	public void incremntCrtnPrdtPrintSn(SVCRTNPRDTVO crtnPrdtVO) {
		update("CRTN_PRDT_U_00", crtnPrdtVO);
	}
	
	public void downCrtnPrdtPrintSn(SVCRTNPRDTVO crtnPrdtVO) {
		update("CRTN_PRDT_U_01", crtnPrdtVO);
	}
	
	public void updateCrtnPrintSn(SVCRTNPRDTVO crtnPrdtVO) {
		update("CRTN_PRDT_U_02", crtnPrdtVO);
	}
	
	public void deleteCrtnPrdt(String crtnNum) {
		delete("CRTN_PRDT_D_00", crtnNum);
	}
}
