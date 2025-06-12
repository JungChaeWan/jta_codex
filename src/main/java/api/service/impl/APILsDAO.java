package api.service.impl;

import api.vo.APILSRECIEVEVO;
import api.vo.APILSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("apiLsDAO")
public class APILsDAO extends EgovAbstractDAO {

	public APILSVO selectLsCorpId(){ return (APILSVO) select("APILS_S_00");}

	public Integer countProductCode(APILSVO apilsvo){ return (Integer) select("APILS_S_01",apilsvo);}


	public List<APILSVO> selectLsProductList() {
		return (List<APILSVO>) list("APILS_S_02");
	}

	public List<APILSVO> requestOrderLsCompany(APILSVO apilsVO) {
		return (List<APILSVO>) list("APILS_S_04", apilsVO);
	}

	APILSVO selectPinCodeLsCompanany(APILSRECIEVEVO apiLsRecieveVO) {
		return (APILSVO) select("APILS_S_05",apiLsRecieveVO);
	}

	public Integer countOptCode(APILSVO apilsvo){ return (Integer) select("APILS_S_06",apilsvo);}

	public List<APILSVO> selectListProductCode(APILSVO apilsvo){ return (List<APILSVO>) list("APILS_S_07",apilsvo);}

	public void updateProductCode(APILSVO apilsvo ){ update("APILS_U_00",apilsvo);}

	public void updateOptCode(APILSVO apilsvo ){ update("APILS_U_01",apilsvo);}

	public void updateProductDetailImg(APILSVO apilsvo ){ update("APILS_U_02",apilsvo);}

	void updatePinCodeLsCompany(APILSRECIEVEVO apiLsRecieveVO) {
		update("APILS_U_03", apiLsRecieveVO);
	}

	public Integer checkSMSLsCompany(APILSVO apilsVO) {
		return (Integer) select("APILS_S_03",apilsVO);
	}
}
