package api.service.impl;

import api.vo.APILSRECIEVEVO;
import api.vo.APILSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("apiVpDAO")
public class APIVpDAO extends EgovAbstractDAO {

	public APILSVO selectLsCorpId(){ return (APILSVO) select("APIVP_S_00");}

	public Integer countProductCode(APILSVO apilsvo){ return (Integer) select("APIVP_S_01",apilsvo);}


	public List<APILSVO> selectLsProductList() {
		return (List<APILSVO>) list("APIVP_S_02");
	}

	public List<APILSVO> requestOrderLsCompany(APILSVO apilsVO) {
		return (List<APILSVO>) list("APIVP_S_04", apilsVO);
	}

	APILSVO selectPinCodeLsCompanany(APILSRECIEVEVO apiLsRecieveVO) {
		return (APILSVO) select("APIVP_S_05",apiLsRecieveVO);
	}

	public Integer countOptCode(APILSVO apilsvo){ return (Integer) select("APIVP_S_06",apilsvo);}

	public List<APILSVO> selectListProductCode(APILSVO apilsvo){ return (List<APILSVO>) list("APIVP_S_07",apilsvo);}

	public void updateVpStatus(APILSVO apilsvo ){ update("APIVP_U_00",apilsvo);}

	public void updateOptCode(APILSVO apilsvo ){ update("APIVP_U_01",apilsvo);}

	public void updateProductDetailImg(APILSVO apilsvo ){ update("APIVP_U_02",apilsvo);}

	void updatePinCodeLsCompany(APILSRECIEVEVO apiLsRecieveVO) {
		update("APIVP_U_03", apiLsRecieveVO);
	}

	public Integer checkSMSLsCompany(APILSVO apilsVO) {
		return (Integer) select("APIVP_S_03",apilsVO);
	}
}