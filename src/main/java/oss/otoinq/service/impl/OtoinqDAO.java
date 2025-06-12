package oss.otoinq.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.otoinq.vo.OTOINQ5VO;
import oss.otoinq.vo.OTOINQSVO;
import oss.otoinq.vo.OTOINQVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;





@Repository("otoinqDAO")
public class OtoinqDAO extends EgovAbstractDAO {


	public OTOINQVO selectByOtoinq(OTOINQVO otoinqVO) {
		return (OTOINQVO) select("OTOINQ_S_00", otoinqVO);
	}

	@SuppressWarnings("unchecked")
	public List<OTOINQVO> selectOtoinqList(OTOINQSVO otoinqSVO) {
		return (List<OTOINQVO>) list("OTOINQ_S_01", otoinqSVO);
	}
	
	public Integer getCntOtoinqlList(OTOINQSVO otoinqSVO) {
		return (Integer) select("OTOINQ_S_02", otoinqSVO);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<OTOINQVO> selectOtoinqListWeb(OTOINQSVO otoinqSVO) {
		return (List<OTOINQVO>) list("OTOINQ_S_03", otoinqSVO);
	}
	
	public Integer getCntOtoinqlListWeb(OTOINQSVO otoinqSVO) {
		return (Integer) select("OTOINQ_S_04", otoinqSVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<OTOINQVO> selectOtoinqListMas(OTOINQSVO otoinqSVO) {
		return (List<OTOINQVO>) list("OTOINQ_S_06", otoinqSVO);
	}
	
	public Integer getCntOtoinqlListMas(OTOINQSVO otoinqSVO) {
		return (Integer) select("OTOINQ_S_07", otoinqSVO);
	}
	
	public Integer getCntOtoinqNotCmt(OTOINQSVO otoinqSVO) {
		return (Integer) select("OTOINQ_S_08", otoinqSVO);
	}

	
	public void insertOtoinq(OTOINQVO otoinqVO) {
		insert("OTOINQ_I_00", otoinqVO);
	}
	
	public void updateOtoinq(OTOINQVO otoinqVO) {
		update("OTOINQ_U_00", otoinqVO);
	}
	
	public void updateOtoinqByPrint(OTOINQVO otoinqVO) {
		update("OTOINQ_U_01", otoinqVO);
	}
	
	public void updateOtoinqByAnsFrst(OTOINQVO otoinqVO) {
		update("OTOINQ_U_02", otoinqVO);
	}
	
	public void updateOtoinqByAns(OTOINQVO otoinqVO) {
		update("OTOINQ_U_03", otoinqVO);
	}

	public void deleteOtoinqByOtoinqNum(OTOINQVO otoinqVO) {
		delete("OTOINQ_D_00", otoinqVO);
	}
	
	public OTOINQ5VO geteOtoinqByCPName(OTOINQ5VO useepil5VO) {
		return (OTOINQ5VO) select("OTOINQ_S_05", useepil5VO);
	}

}
