package oss.marketing.serive.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.marketing.vo.BESTPRDTSVO;
import oss.marketing.vo.BESTPRDTVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("bestPrdtDAO")
public class BestPrdtDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<BESTPRDTVO> selectBestprdtList(BESTPRDTSVO bestprdtSVO) {
		return (List<BESTPRDTVO>) list("BESTPRDT_S_01", bestprdtSVO);
	}

	public int selectBestprdtListCnt(BESTPRDTSVO bestprdtSVO) {
		return (Integer) select("BESTPRDT_S_02", bestprdtSVO);
	}

	public BESTPRDTVO selectBestprdt(BESTPRDTVO bestprdtVO) {
		return (BESTPRDTVO) select("BESTPRDT_S_00", bestprdtVO);
	}

	public Integer getMaxCntBestprdtPos(BESTPRDTVO bestprdtVO) {
		return (Integer) select("BESTPRDT_S_03", bestprdtVO);
	}

	public void insertBestprdt(BESTPRDTVO bestprdtVO) {
		insert("BESTPRDT_I_00", bestprdtVO);
	}

	public void updateBestprdt(BESTPRDTVO bestprdtVO) {
		update("BESTPRDT_U_00", bestprdtVO);
	}

	public void addViewSn(BESTPRDTVO bestprdtVO) {
		update("BESTPRDT_U_01", bestprdtVO);
	}

	public void minusViewSn(BESTPRDTVO bestprdtVO) {
		update("BESTPRDT_U_02", bestprdtVO);
	}

	public void deleteBestprdt(BESTPRDTVO bestprdtVO) {
		delete("BESTPRDT_D_00", bestprdtVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<BESTPRDTVO> selectBestprdtWebList(BESTPRDTSVO bestprdtSVO) {
		return (List<BESTPRDTVO>) list("WEB_BESTPRDT_S_00", bestprdtSVO);
	}

}
