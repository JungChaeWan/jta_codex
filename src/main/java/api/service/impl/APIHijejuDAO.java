package api.service.impl;

import api.vo.APILSRESULTVO;
import api.vo.APILSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("apiHijejuDAO")
public class APIHijejuDAO extends EgovAbstractDAO {

	public List<APILSVO> requestOrderHijeju(APILSVO apilsvo) {
		return (List<APILSVO>) list("APIHIJEJU_S_00", apilsvo);
	}

	void updatePinCodeHijeju(APILSRESULTVO apilsresultvo) {
		update("APIHIJEJU_U_00", apilsresultvo);
	}

	public Integer checkSMSHijeju(APILSVO apilsvo) {
		return (Integer) select("APIHIJEJU_S_01",apilsvo);
	}
}
