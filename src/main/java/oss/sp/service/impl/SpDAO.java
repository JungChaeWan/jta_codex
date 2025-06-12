package oss.sp.service.impl;

import java.util.List;

import mas.sp.vo.SP_ADDOPTINFVO;
import mas.sp.vo.SP_DIVINFVO;
import mas.sp.vo.SP_DTLINFVO;
import mas.sp.vo.SP_DTLINF_ITEMVO;
import mas.sp.vo.SP_GUIDINFOVO;
import mas.sp.vo.SP_OPTINFVO;
import mas.sp.vo.SP_PRDTINFSVO;
import mas.sp.vo.SP_PRDTINFVO;

import org.springframework.stereotype.Repository;

import oss.sp.vo.OSS_PRDTINFSVO;
import web.order.vo.MRTNVO;
import web.order.vo.RSVSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("spDAO")
public class SpDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<SP_PRDTINFVO> selectSpPrdtInfList(SP_PRDTINFSVO spSVO) {
		return  (List<SP_PRDTINFVO>) list("SP_PRDTINF_S_00", spSVO);
	}

	public Integer getCntSpPrdtInfList(SP_PRDTINFSVO spSVO) {
		return (Integer) select("SP_PRDTINF_S_01", spSVO);
	}

	public SP_PRDTINFVO selectBySpPrdtInf(SP_PRDTINFVO spVO) {
		return (SP_PRDTINFVO) select("SP_PRDTINF_S_02", spVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_PRDTINFVO> selectSpPrdtSaleList(SP_PRDTINFVO spSVO) {
		return  (List<SP_PRDTINFVO>) list("SP_PRDTINF_S_02", spSVO);
	}

	public String insertSpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO) {
			return (String) insert("SP_PRDTINF_I_00", sp_PRDTINFVO);
	}

	public void updateSpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO) {
		update("SP_PRDTINF_U_00", sp_PRDTINFVO);
	}

	public void insertSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		insert("SP_OPTINF_I_00", sp_OPTINFVO);
	}

	public int insertSpDivInf(SP_DIVINFVO sp_DIVINFVO) {
		return (Integer) insert("SP_DIVINF_I_00", sp_DIVINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_OPTINFVO> selectSpDivOptInf(SP_OPTINFVO sp_OPTINFVO) {
		return (List<SP_OPTINFVO>) list("SP_OPTINF_S_01", sp_OPTINFVO);
	}

	public SP_DIVINFVO selectSpDivInf(SP_DIVINFVO sp_DIVINFVO) {
		return (SP_DIVINFVO) select("SP_DIVINF_S_00", sp_DIVINFVO);
	}

	public Integer selectDivInfMaxViewSn(SP_DIVINFVO sp_DIVINFVO) {
		return (Integer) select("SP_DIVINF_S_01", sp_DIVINFVO);
	}

	public void addDivViewSn(SP_DIVINFVO oldVO) {
		update("SP_DIVINF_U_01", oldVO);
	}

	public void minusDivViewSn(SP_DIVINFVO oldVO) {
		update("SP_DIVINF_U_02", oldVO);
	}

	public void updateSpDivInf(SP_DIVINFVO sp_DIVINFVO) {
		update("SP_DIVINF_U_00", sp_DIVINFVO);
	}

	public void deleteSpDivInf(SP_DIVINFVO sp_DIVINFVO) {
		delete("SP_DIVINF_D_00", sp_DIVINFVO);
	}

	public void deleteSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		delete("SP_OPTINF_D_00", sp_OPTINFVO);
	}

	public void deleteSpAllOptInf(SP_OPTINFVO sp_OPTINFVO) {
		delete("SP_OPTINF_D_01", sp_OPTINFVO);
	}

	public Integer selectOptInfMaxViewSn(SP_OPTINFVO sp_OPTINFVO) {
		return (Integer) select("SP_OPTINF_S_02", sp_OPTINFVO);
	}

	public void addOptViewSn(SP_OPTINFVO oldVO) {
		update("SP_OPTINF_U_01", oldVO);
	}

	public void minusOptViewSn(SP_OPTINFVO oldVO) {
		update("SP_OPTINF_U_02", oldVO);
	}

	public void updateDdlYn(SP_OPTINFVO sp_OPTINFVO) {
		update("SP_OPTINF_U_03", sp_OPTINFVO);
	}

	public SP_OPTINFVO selectSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		return (SP_OPTINFVO) select("SP_OPTINF_S_00", sp_OPTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_OPTINFVO> selectSpOptInfList(SP_OPTINFVO sp_OPTINFVO) {
		return ( List<SP_OPTINFVO>) list("SP_OPTINF_S_00", sp_OPTINFVO);
	}

	public void updateSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		update("SP_OPTINF_U_00", sp_OPTINFVO);
	}

	public void deleteSpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO) {
		delete("SP_PRDTINF_D_00", sp_PRDTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<OSS_PRDTINFSVO> selectOssSpPrdtInfList(OSS_PRDTINFSVO oss_PRDTINFSVO) {
		return  (List<OSS_PRDTINFSVO>) list("SP_PRDTINF_S_03", oss_PRDTINFSVO);
	}

	public Integer getCntOssSpPrdtInfList(OSS_PRDTINFSVO oss_PRDTINFSVO) {
		return (Integer) select("SP_PRDTINF_S_04", oss_PRDTINFSVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_OPTINFVO> selectStockList(SP_PRDTINFVO sp_PRDTINFVO) {
		return (List<SP_OPTINFVO>) list("SP_OPTINF_S_03", sp_PRDTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_PRDTINFVO> selectPrmtProductList(SP_PRDTINFVO sp_PRDTINFVO) {
		return (List<SP_PRDTINFVO>) list("SP_PRDTINF_S_05", sp_PRDTINFVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<OSS_PRDTINFSVO> selectOssSpPrdtInfList2(OSS_PRDTINFSVO oss_PRDTINFSVO) {
		return  (List<OSS_PRDTINFSVO>) list("SP_PRDTINF_S_06", oss_PRDTINFSVO);
	}
	
	public Integer getCntOssSpPrdtInfList2(OSS_PRDTINFSVO oss_PRDTINFSVO) {
		return (Integer) select("SP_PRDTINF_S_07", oss_PRDTINFSVO);
	}

	public void insertBatchSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		insert("SP_OPTINF_I_01", sp_OPTINFVO);
	}

	public String copyBySpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO) {
		return (String) insert("SP_PRDTINF_I_01", sp_PRDTINFVO);
	}

	public void copyBySpDivInf(SP_PRDTINFVO sp_PRDTINFVO) {
		insert("SP_DIVINF_I_01", sp_PRDTINFVO);
	}

	public void copyBySpOptInf(SP_PRDTINFVO sp_PRDTINFVO) {
		insert("SP_OPTINF_I_02", sp_PRDTINFVO);
	}

	public void approvalPrdt(SP_PRDTINFVO sp_PRDTINFVO) {
		update("SP_PRDTINF_U_01", sp_PRDTINFVO);
	}
	
	public void salePrintN(SP_PRDTINFVO sp_PRDTINFVO) {
		update("SP_PRDTINF_U_02", sp_PRDTINFVO);
	}	

	public int updateBatchSpOptInf(SP_OPTINFVO sp_OPTINFVO) {
		return update("SP_OPTINF_U_06", sp_OPTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_OPTINFVO> selectTourDivList(SP_OPTINFVO sp_OPTINFVO) {
		return (List<SP_OPTINFVO>) list("SP_DIVINF_S_02", sp_OPTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_ADDOPTINFVO> selectPrdtAddOptionList(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		return (List<SP_ADDOPTINFVO>) list("SP_ADDOPT_S_00", sp_ADDOPTINFVO);
	}

	public Integer selectAddOptInfMaxViewSn(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		return (Integer) select("SP_ADDOPT_S_01", sp_ADDOPTINFVO);
	}

	public void addAddOptViewSn(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		update("SP_ADDOPT_U_01", sp_ADDOPTINFVO);
	}

	public void insetSpAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		insert("SP_ADDOPT_I_00", sp_ADDOPTINFVO);
	}

	public SP_ADDOPTINFVO selectSpAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		return (SP_ADDOPTINFVO) select("SP_ADDOPT_S_02", sp_ADDOPTINFVO);
	}

	public void minusAddOptViewSn(SP_ADDOPTINFVO oldVO) {
		update("SP_ADDOPT_U_02", oldVO);
	}

	public void updateSpAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		update("SP_ADDOPT_U_00", sp_ADDOPTINFVO);
	}

	public void deleteAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO) {
		delete("SP_ADDOPT_D_00", sp_ADDOPTINFVO);
	}

	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오후 4:20:13
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	public Integer checkExsistPrdt(RSVSVO rsvSVO) {
		return (Integer) select("SP_RSV_S_07", rsvSVO);
	}



	public SP_DTLINFVO selectDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		return (SP_DTLINFVO) select("SP_DTLINF_S_00", sp_DTLINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_DTLINFVO> selectDtlInfList(SP_DTLINFVO sp_DTLINFVO) {
		return (List<SP_DTLINFVO>) list("SP_DTLINF_S_00", sp_DTLINFVO);
	}

	public String getDtlInfNextNum() {
		return (String) select("SP_DTLINF_S_01", null);
	}

	public Integer getDtlInfMaxSN(SP_DTLINFVO sp_DTLINFVO) {
		return (Integer) select("SP_DTLINF_S_02", sp_DTLINFVO);
	}

	public void insetDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		insert("SP_DTLINF_I_00", sp_DTLINFVO);
	}

	public void updateDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		update("SP_DTLINF_U_00", sp_DTLINFVO);
	}

	public void addViewSnDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		update("SP_DTLINF_U_01", sp_DTLINFVO);
	}

	public void minusViewSnDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		update("SP_DTLINF_U_02", sp_DTLINFVO);
	}

	public void deleteDtlInf(SP_DTLINFVO sp_DTLINFVO) {
		delete("SP_DTLINF_D_00", sp_DTLINFVO);
	}


	//public SP_DTLINF_ITEMVO selectDtlInfItem(SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO) {
	//	return (SP_DTLINF_ITEMVO) select("SP_DTLINF_ITEM_S_00", sp_DTLINF_ITEMVO);
	//}

	@SuppressWarnings("unchecked")
	public List<SP_DTLINF_ITEMVO> selectDtlInfItemList(SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO) {
		return (List<SP_DTLINF_ITEMVO>) list("SP_DTLINF_ITEM_S_00", sp_DTLINF_ITEMVO);
	}

	public void insetDtlInfItem(SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO){
		insert("SP_DTLINF_ITEM_I_00", sp_DTLINF_ITEMVO);
	}

	public void deleteDtlInfItem(SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO) {
		delete("SP_DTLINF_ITEM_D_00", sp_DTLINF_ITEMVO);
	}




	public SP_GUIDINFOVO selectGuidinfo(SP_GUIDINFOVO sp_GUIDINFOVO) {
		return (SP_GUIDINFOVO) select("SP_GUIDINFO_S_00", sp_GUIDINFOVO);
	}

	public void insertGuidinfo(SP_GUIDINFOVO sp_GUIDINFOVO) {
		insert("SP_GUIDINFO_I_00", sp_GUIDINFOVO);
	}

	public void updateGuidinfo(SP_GUIDINFOVO sp_GUIDINFOVO) {
		update("SP_GUIDINFO_U_00", sp_GUIDINFOVO);
	}

	public void insertGuidinfoBgColor(SP_GUIDINFOVO sp_GUIDINFOVO) {
		insert("SP_GUIDINFO_I_01", sp_GUIDINFOVO);
	}

	public void updateGuidinfoBgColor(SP_GUIDINFOVO sp_GUIDINFOVO) {
		update("SP_GUIDINFO_U_01", sp_GUIDINFOVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<MRTNVO> selectMrtnUserList(MRTNVO mrtnSVO){
		return (List<MRTNVO>) list("SP_MRTNUSER_S_00", mrtnSVO);
	}
	
	public void mrtnUserUpdate(MRTNVO mrtnVO){
		update("SP_MRTNUSER_U_00", mrtnVO);
	}
	
	public MRTNVO selectMrtnTshirts(MRTNVO mrtnSVO) {
		return (MRTNVO) select("SP_MRTNUSER_S_01", mrtnSVO);
	}
	
	public void insertTshirts(MRTNVO mrtnVO){
		insert("SP_MRTNUSER_I_00", mrtnVO);
	}
	
	public void mrtnTshirtsUpdate(MRTNVO mrtnVO){
		update("SP_MRTNUSER_U_01", mrtnVO);
	}
	
}
