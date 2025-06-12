package oss.marketing.serive.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.marketing.vo.MKINGHISTVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("mkingHistDAO")
public class MkingHistDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<MKINGHISTVO> selectMkingHistList(MKINGHISTVO mkinghistVO) {
		return (List<MKINGHISTVO>) list("MKING_HIST_S_01", mkinghistVO);
	}

	public int getMkingHistListCnt(MKINGHISTVO mkinghistVO) {
		return (Integer) select("MKING_HIST_S_02", mkinghistVO);
	}

	public MKINGHISTVO selectMkingHist(MKINGHISTVO mkinghistVO) {
		return (MKINGHISTVO) select("MKING_HIST_S_00", mkinghistVO);
	}

	public MKINGHISTVO getMkingHistSale(MKINGHISTVO mkinghistVO) {
		return (MKINGHISTVO) select("MKING_HIST_S_04", mkinghistVO);
	}


	public void insertMkingHist(MKINGHISTVO mkinghistVO) {
		insert("MKING_HIST_I_00", mkinghistVO);
	}

	public void updateMkingHist(MKINGHISTVO mkinghistVO) {
		update("MKING_HIST_U_00", mkinghistVO);
	}

	public void deleteMkingHist(MKINGHISTVO mkinghistVO) {
		delete("MKING_HIST_D_00", mkinghistVO);
	}


}
