package oss.cmm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import oss.cmm.vo.CM_ICONINFVO;

@Repository("cmmIconinfDAO")
public class CmmIconinfDAO extends EgovAbstractDAO {

	public void insertCmIconinf(CM_ICONINFVO icon) {
		insert("CM_ICONINF_I_00", icon);
	}

	@SuppressWarnings("unchecked")
	public List<CM_ICONINFVO> selectCmIconinf(CM_ICONINFVO icon) {
		return (List<CM_ICONINFVO>) list("CM_ICONINF_S_00", icon);
	}
	
	public int selectCmIconfChkIsr(CM_ICONINFVO icon) {
		return (Integer) select("CM_ICONINF_S_01", icon);
	}

	public void deleteCmIconinf(String linkNum) {
		delete("CM_ICONINF_D_00", linkNum);
	}

}
