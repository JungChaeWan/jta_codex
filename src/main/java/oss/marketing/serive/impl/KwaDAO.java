package oss.marketing.serive.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.marketing.vo.KWAPRDTVO;
import oss.marketing.vo.KWASVO;
import oss.marketing.vo.KWAVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("kwaDAO")
public class KwaDAO extends EgovAbstractDAO {

	public KWAVO selectKaw(KWAVO kwaVO) {
		return (KWAVO) select("KWA_S_00", kwaVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<KWAVO> selectKawList(KWASVO kwaSVO) {
		return (List<KWAVO>) list("KWA_S_01", kwaSVO);
	}

	public int selectKawListCnt(KWASVO kwaSVO) {
		return (Integer) select("KWA_S_02", kwaSVO);
	}

	public String selectKawListNewPk() {
		return (String) select("KWA_S_03", "");
	}
	
	@SuppressWarnings("unchecked")
	public List<KWAVO> selectKawListFind(KWASVO kwaSVO) {
		return (List<KWAVO>) list("KWA_S_04", kwaSVO);
	}	
	
	public int selectKawListCntFind(KWASVO kwaSVO) {
		return (Integer) select("KWA_S_05", kwaSVO);
	}

	public void insertKaw(KWAVO kwaVO) {
		insert("KWA_I_00", kwaVO);
	}

	public void updateKaw(KWAVO kwaVO) {
		update("KWA_U_00", kwaVO);
	}

	public void deleteKaw(KWAVO kwaVO) {
		delete("KWA_D_00", kwaVO);
	}


	@SuppressWarnings("unchecked")
	public List<KWAVO> selectKawWebList(KWASVO kwaSVO) {
		return (List<KWAVO>) list("KWA_WEB_S_00", kwaSVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<KWAVO> selectKawWebPrdtList(KWASVO kwaSVO) {
		return (List<KWAVO>) list("KWA_WEB_S_01", kwaSVO);
	}


	@SuppressWarnings("unchecked")
	public List<KWAPRDTVO> selectKawPrdtList(KWAPRDTVO kwaprdtVO) {
		return (List<KWAPRDTVO>) list("KWA_PRDT_S_00", kwaprdtVO);
	}


	public void insertKawPrdt(KWAPRDTVO kwaprdtVO) {
		insert("KWA_PRDT_I_01", kwaprdtVO);
	}


	public void incremntKawPrdtPrintSn(KWAPRDTVO kwaprdtVO) {
		update("KWA_PRDT_U_00", kwaprdtVO);
	}

	public void downKawPrdtPrintSn(KWAPRDTVO kwaprdtVO) {
		update("KWA_PRDT_U_01", kwaprdtVO);
	}

	public void updateKawPrdtPrintSn(KWAPRDTVO kwaprdtVO) {
		update("KWA_PRDT_U_02", kwaprdtVO);
	}

	public void deleteKawPrdtAll(String kwaNum) {
		delete("KWA_PRDT_D_00", kwaNum);
	}

}
