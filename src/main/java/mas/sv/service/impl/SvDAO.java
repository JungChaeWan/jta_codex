package mas.sv.service.impl;

import java.util.List;

import mas.sv.vo.SV_ADDOPTINFVO;
import mas.sv.vo.SV_CORPDLVAMTVO;
import mas.sv.vo.SV_DFTINFVO;
import mas.sv.vo.SV_DIVINFVO;
import mas.sv.vo.SV_OPTINFVO;
import mas.sv.vo.SV_PRDTINFSVO;
import mas.sv.vo.SV_PRDTINFVO;

import org.springframework.stereotype.Repository;

import oss.sv.vo.OSS_SV_PRDTINFSVO;
import oss.sv.vo.OSS_SV_PRDTINFVO;
import web.order.vo.RSVSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("svDAO")
public class SvDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<SV_PRDTINFVO> selectPrdtInfList(SV_PRDTINFSVO sv_PRDTINFSVO) {
		return  (List<SV_PRDTINFVO>) list("SV_PRDTINF_S_00", sv_PRDTINFSVO);
	}

	public Integer getCntPrdtInfList(SV_PRDTINFSVO sv_PRDTINFSVO) {
		return  (Integer) select("SV_PRDTINF_S_01", sv_PRDTINFSVO);
	}


	public SV_PRDTINFVO selectBySvPrdtInf(SV_PRDTINFVO spVO) {
		return (SV_PRDTINFVO) select("SV_PRDTINF_S_02", spVO);
	}

	@SuppressWarnings("unchecked")
	public List<SV_PRDTINFVO> selectSvPrdtSaleList(SV_PRDTINFVO spSVO) {
		return  (List<SV_PRDTINFVO>) list("SV_PRDTINF_S_02", spSVO);
	}

	public String insertSvPrdtInf(SV_PRDTINFVO SV_PRDTINFVO) {
			return (String) insert("SV_PRDTINF_I_00", SV_PRDTINFVO);
	}

	public void updateSvPrdtInf(SV_PRDTINFVO sv_PRDTINFVO) {
		update("SV_PRDTINF_U_00", sv_PRDTINFVO);
	}


	public void updateSvPrdtInfData(SV_PRDTINFVO sv_PRDTINFVO) {
		update("SV_PRDTINF_U_02", sv_PRDTINFVO);
	}
	
	public void salePrintN(SV_PRDTINFVO sv_PRDTINFVO) {
		update("SV_PRDTINF_U_03", sv_PRDTINFVO);
	}	


	public void insertSvOptInf(SV_OPTINFVO sv_OPTINFVO) {
		insert("SV_OPTINF_I_00", sv_OPTINFVO);
	}

	public int insertSvDivInf(SV_DIVINFVO sv_DIVINFVO) {
		return (Integer) insert("SV_DIVINF_I_00", sv_DIVINFVO);
	}

	/** API임시 */
	public void insertSvDivInf2(SV_DIVINFVO sv_DIVINFVO) {
		insert("SV_DIVINF_I_02", sv_DIVINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SV_OPTINFVO> selectSvDivOptInf(SV_OPTINFVO sv_OPTINFVO) {
		return (List<SV_OPTINFVO>) list("SV_OPTINF_S_01", sv_OPTINFVO);
	}

	public SV_DIVINFVO selectSvDivInf(SV_DIVINFVO sv_DIVINFVO) {
		return (SV_DIVINFVO) select("SV_DIVINF_S_00", sv_DIVINFVO);
	}

	public Integer selectDivInfMaxViewSn(SV_DIVINFVO sv_DIVINFVO) {
		return (Integer) select("SV_DIVINF_S_01", sv_DIVINFVO);
	}

	public void addDivViewSn(SV_DIVINFVO oldVO) {
		update("SV_DIVINF_U_01", oldVO);
	}

	public void minusDivViewSn(SV_DIVINFVO oldVO) {
		update("SV_DIVINF_U_02", oldVO);
	}

	public void updateSvDivInf(SV_DIVINFVO sv_DIVINFVO) {
		update("SV_DIVINF_U_00", sv_DIVINFVO);
	}

	public void deleteSvDivInf(SV_DIVINFVO sv_DIVINFVO) {
		delete("SV_DIVINF_D_00", sv_DIVINFVO);
	}

	public void deleteSvOptInf(SV_OPTINFVO sv_OPTINFVO) {
		delete("SV_OPTINF_D_00", sv_OPTINFVO);

	}

	public Integer selectOptInfMaxViewSn(SV_OPTINFVO sv_OPTINFVO) {
		return (Integer) select("SV_OPTINF_S_02", sv_OPTINFVO);
	}

	public void addOptViewSn(SV_OPTINFVO oldVO) {
		update("SV_OPTINF_U_01", oldVO);
	}

	public void minusOptViewSn(SV_OPTINFVO oldVO) {
		update("SV_OPTINF_U_02", oldVO);
	}

	public void updateDdlYn(SV_OPTINFVO sv_OPTINFVO) {
		update("SV_OPTINF_U_03", sv_OPTINFVO);
	}

	public SV_OPTINFVO selectSvOptInf(SV_OPTINFVO sv_OPTINFVO) {
		return (SV_OPTINFVO) select("SV_OPTINF_S_00", sv_OPTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SV_OPTINFVO> selectSvOptInfList(SV_OPTINFVO sv_OPTINFVO) {
		return ( List<SV_OPTINFVO>) list("SV_OPTINF_S_00", sv_OPTINFVO);
	}

	public void updateSvOptInf(SV_OPTINFVO sv_OPTINFVO) {
		update("SV_OPTINF_U_00", sv_OPTINFVO);
	}

	public void deleteSvPrdtInf(SV_PRDTINFVO SV_PRDTINFVO) {
		delete("SV_PRDTINF_D_00", SV_PRDTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<OSS_SV_PRDTINFSVO> selectOssSvPrdtInfList(OSS_SV_PRDTINFSVO oss_PRDTINFSVO) {
		return  (List<OSS_SV_PRDTINFSVO>) list("SV_PRDTINF_S_03", oss_PRDTINFSVO);
	}

	public Integer getCntOssSvPrdtInfList(OSS_SV_PRDTINFSVO oss_PRDTINFSVO) {
		return (Integer) select("SV_PRDTINF_S_04", oss_PRDTINFSVO);
	}

	@SuppressWarnings("unchecked")
	public List<SV_OPTINFVO> selectStockList(SV_PRDTINFVO SV_PRDTINFVO) {
		return (List<SV_OPTINFVO>) list("SV_OPTINF_S_03", SV_PRDTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SV_PRDTINFVO> selectPrmtProductList(SV_PRDTINFVO SV_PRDTINFVO) {
		return (List<SV_PRDTINFVO>) list("SV_PRDTINF_S_05", SV_PRDTINFVO);
	}

	public void insertBatchSvOptInf(SV_OPTINFVO sv_OPTINFVO) {
		insert("SV_OPTINF_I_01", sv_OPTINFVO);
	}

	public String copyBySvPrdtInf(SV_PRDTINFVO SV_PRDTINFVO) {
		return (String) insert("SV_PRDTINF_I_01", SV_PRDTINFVO);
	}

	public void copyBySvDivInf(SV_PRDTINFVO SV_PRDTINFVO) {
		insert("SV_DIVINF_I_01", SV_PRDTINFVO);
	}

	public void copyBySvOptInf(SV_PRDTINFVO SV_PRDTINFVO) {
		insert("SV_OPTINF_I_02", SV_PRDTINFVO);
	}

	public void approvalPrdt(SV_PRDTINFVO SV_PRDTINFVO) {
		update("SV_PRDTINF_U_01", SV_PRDTINFVO);
	}

	public int updateBatchSvOptInf(SV_OPTINFVO sv_OPTINFVO) {
		return update("SV_OPTINF_U_06", sv_OPTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SV_OPTINFVO> selectDivList(SV_OPTINFVO sv_OPTINFVO) {
		return (List<SV_OPTINFVO>) list("SV_DIVINF_S_02", sv_OPTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SV_ADDOPTINFVO> selectPrdtAddOptionList(SV_ADDOPTINFVO sv_ADDOPTINFVO) {
		return (List<SV_ADDOPTINFVO>) list("SV_ADDOPT_S_00", sv_ADDOPTINFVO);
	}

	public Integer selectAddOptInfMaxViewSn(SV_ADDOPTINFVO SV_ADDOPTINFVO) {
		return (Integer) select("SV_ADDOPT_S_01", SV_ADDOPTINFVO);
	}

	public void addAddOptViewSn(SV_ADDOPTINFVO SV_ADDOPTINFVO) {
		update("SV_ADDOPT_U_01", SV_ADDOPTINFVO);
	}

	public void insetSvAddOptInf(SV_ADDOPTINFVO SV_ADDOPTINFVO) {
		insert("SV_ADDOPT_I_00", SV_ADDOPTINFVO);
	}

	public SV_ADDOPTINFVO selectSvAddOptInf(SV_ADDOPTINFVO SV_ADDOPTINFVO) {
		return (SV_ADDOPTINFVO) select("SV_ADDOPT_S_02", SV_ADDOPTINFVO);
	}

	public void minusAddOptViewSn(SV_ADDOPTINFVO oldVO) {
		update("SV_ADDOPT_U_02", oldVO);
	}

	public void updateSvAddOptInf(SV_ADDOPTINFVO SV_ADDOPTINFVO) {
		update("SV_ADDOPT_U_00", SV_ADDOPTINFVO);
	}

	public void deleteAddOptInf(SV_ADDOPTINFVO SV_ADDOPTINFVO) {
		delete("SV_ADDOPT_D_00", SV_ADDOPTINFVO);
	}

	public SV_CORPDLVAMTVO selectCorpDlvAmt(String corpId) {
		return (SV_CORPDLVAMTVO) select("SV_CORPDLVAMT_S_00", corpId);
	}

	public void saveCorpDlvAmt(SV_CORPDLVAMTVO sv_CORPDLVAMTVO) {
		update("SV_CORPDLVAMT_M_00", sv_CORPDLVAMTVO);
	}

	public void updateOptinfDlvAmt(String corpId) {
		update("SV_OPTINF_U_06", corpId);
	}

	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오후 4:28:00
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	public Integer checkExsistPrdt(RSVSVO rsvSVO) {
		return (Integer) select("SV_RSV_S_07", rsvSVO);
	}

	/**
	 * 통합운영 기념품 상품 엑셀 다운로드 용
	 * 파일명 : selectOssSvPrdtInfList2
	 * 작성일 : 2017. 1. 10. 오후 3:38:18
	 * 작성자 : 최영철
	 * @param oss_SV_PRDTINFSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<OSS_SV_PRDTINFVO> selectOssSvPrdtInfList2(OSS_SV_PRDTINFSVO oss_SV_PRDTINFSVO) {
		return (List<OSS_SV_PRDTINFVO>) list("SV_PRDTINF_S_06", oss_SV_PRDTINFSVO);
	}




	public SV_DFTINFVO selectBySvDftinf(SV_DFTINFVO spVO) {
		return (SV_DFTINFVO) select("SV_DFTINF_S_00", spVO);
	}

	public String insertSvDftinf(SV_DFTINFVO spVO) {
			return (String) insert("SV_DFTINF_I_00", spVO);
	}

	public void updateSvDftinf(SV_DFTINFVO spVO) {
		update("SV_DFTINF_U_00", spVO);
	}
}
