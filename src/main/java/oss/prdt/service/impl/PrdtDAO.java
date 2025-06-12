package oss.prdt.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;
import oss.corp.vo.CMSSPGVO;
import oss.prdt.vo.PRDTSVO;
import oss.prdt.vo.PRDTVO;

import java.util.List;


/**
 * <pre>
 * 파 일 명 : CorpDAO.java
 * 작 성 일 : 2015. 9. 17. 오전 10:38:15
 * 작 성 자 : 최영철
 */
@Repository("prdtDAO")
public class PrdtDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<PRDTVO> selectPrdtList(PRDTSVO prdtSVO) {
		return (List<PRDTVO>) list("PRDT_S_01", prdtSVO);
	}

	public Integer getCntPrdtList(PRDTSVO prdtSVO) {
		return (Integer) select("PRDT_S_02", prdtSVO);
	}

	
	public Integer getCntRTPrdtMain(PRDTVO prdtVO) {
		return (Integer) select("PRDT_S_03", prdtVO);
	}
	
	
	public Integer getCntSPPrdtMain(PRDTVO prdtVO) {
		return (Integer) select("PRDT_S_04", prdtVO);
	}
	
	public Integer getCntSVPrdtMain(PRDTVO prdtVO) {
		return (Integer) select("PRDT_S_05", prdtVO);
	}

	public Integer getCntRfAcc(PRDTVO prdtVO) {
		return (Integer) select("PRDT_S_10", prdtVO);
	}

	@SuppressWarnings("unchecked")
	public  List<PRDTVO> chckPrdtExpireList(PRDTSVO prdtSVO) {
		return (List<PRDTVO>) list("PRDT_S_06", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public  List<PRDTVO> chckPrdtEndList(PRDTSVO prdtSVO) {
		return (List<PRDTVO>) list("PRDT_S_11", prdtSVO);
	}

	Integer chckPrdtExpireListCnt(PRDTSVO prdtSVO) {
		return (Integer) select("PRDT_S_07", prdtSVO);
	};
	
	@SuppressWarnings("unchecked")
	public  List<PRDTVO> chckPrdtStasticsCnt1(PRDTSVO prdtSVO) {
		return (List<PRDTVO>) list("PRDT_S_08", prdtSVO);
	}
	
	@SuppressWarnings("unchecked")
	public  List<PRDTVO> chckPrdtStasticsCnt2(PRDTSVO prdtSVO) {
		return (List<PRDTVO>) list("PRDT_S_09", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public List<PRDTVO> selectPrdtAllList(PRDTSVO prdtSVO) {
		return (List<PRDTVO>) list("PRDT_S_12", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public Integer selectPrdtAllCnt(PRDTSVO prdtSVO) {
		return (Integer) select("PRDT_S_13", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public void updateTamnacardPrdtYn(PRDTSVO prdtSVO) {
		update("PRDT_U_01", prdtSVO);
	}

	public PRDTVO selectPrdtInfo(String prdtNum) {
		return (PRDTVO) select("PRDT_S_14", prdtNum);
	}
}
