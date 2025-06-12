package api.service;

import api.vo.APILSRECIEVEVO;
import api.vo.APILSRESULTVO;
import api.vo.APILSVO;
import api.vo.APIVPRECIEVEVO;
import mas.sp.vo.SP_PRDTINFVO;
import org.json.simple.parser.ParseException;

import java.util.HashMap;
import java.util.LinkedHashMap;

public interface APIVpService {


	/** 티켓 주문*/
	String requestOrderVpCompany(APILSVO apilsVO);

	/** 티켓 상태확인*/
	LinkedHashMap<String, String> requestOrderChkVpCompany(APILSVO apilsVO);

	/** 티켓 발권취소*/
	APILSRECIEVEVO requestCancelVpCompany(APILSVO apilsVO) throws ParseException;

	/** 티켓 상태변경*/
	APILSRESULTVO apiLsUseCancelTicket(SP_PRDTINFVO apilsVO);

	/** 티켓 재발송*/
	APIVPRECIEVEVO requestSMSVpCompany(APILSVO apilsVO);

	/**바코드리스트*/
	APILSRESULTVO apiLsBarcodeList(SP_PRDTINFVO apilsVO);

	APILSVO selectPinCodeLsCompanany(APILSRECIEVEVO apiLsRecieveVO);

	void updatePinCodeLsCompany(APILSRECIEVEVO apiLsRecieveVO);

	void updateVpStatus(APILSVO apilsvo);
}
