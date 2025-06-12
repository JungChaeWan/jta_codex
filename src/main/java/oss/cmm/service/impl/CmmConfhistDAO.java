package oss.cmm.service.impl;

import org.springframework.stereotype.Repository;

import oss.cmm.vo.CM_CONFHISTVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("cmmConfhistDAO")
public class CmmConfhistDAO extends EgovAbstractDAO {
	
	public void insertConfhist(CM_CONFHISTVO confhistVO) {
		insert("CM_CONFHIST_I_00", confhistVO);
	}

	public String selectHistNum(String linkNum) {
		return (String) select("CM_CONFHIST_S_00", linkNum);
	}

	public CM_CONFHISTVO selectPrdtApprInfo(CM_CONFHISTVO cm_CONFHISTVO) {
		return (CM_CONFHISTVO) select("CM_CONFHIST_S_01", cm_CONFHISTVO);
	}
	
	public String selectApprMsg(String linkNum) {
		return (String) select("CM_CONFHIST_S_02", linkNum);
	}
}
