package api.service.impl;

import api.vo.APILSRECIEVEVO;
import api.vo.APILSVO;
import api.vo.APITOURSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("apiYjDAO")
public class APIYjDAO extends EgovAbstractDAO {

	public List<APILSVO> requestOrderYanolja(APILSVO apilsVO) {
		return (List<APILSVO>) list("APIYJ_S_04", apilsVO);
	}

	void updatePinCodeYj(APITOURSVO apitourSVo) {
		insert("APIYJ_I_00", apitourSVo);
	}

	List<String> selectPinCodeYj(APILSVO apilsVO) {return (List<String>) list("APIYJ_S_00",apilsVO);
	}

	public void updateSpRsvStatus(APILSVO apilsvo ){ update("APIYJ_U_00",apilsvo);}

	public void updateApiTourStatus(APILSVO apilsvo ){ update("APIYJ_U_01",apilsvo);}

	public void requestUseStatusYj(APITOURSVO apitoursVo){ update("APIYJ_U_02",apitoursVo);}

	public void requestUseUndoStatusYj(APITOURSVO apitoursVo){ update("APIYJ_U_03",apitoursVo);}

	public void requestUseStatusRsv(APITOURSVO apitoursVo){ update("APIYJ_U_04",apitoursVo);}

	public APITOURSVO selectRsvNum(APITOURSVO apitoursVo){ return (APITOURSVO) select("APIYJ_S_01",apitoursVo);}

	public List<APILSVO> selectListProductCode(APILSVO apilsvo){ return (List<APILSVO>) list("APILS_S_07",apilsvo);}

	public void requestAddCnt(String spRsvNum){ update("APIYJ_U_05",spRsvNum);}

	public void requestSubCnt(String spRsvNum){ update("APIYJ_U_06",spRsvNum);}
}
