package api.service;

import api.vo.APILSRECIEVEVO;
import api.vo.APILSRESULTVO;
import api.vo.APILSVO;
import mas.sp.vo.SP_PRDTINFVO;
import org.json.simple.parser.ParseException;

import java.util.HashMap;
import java.util.LinkedHashMap;

public interface APILsService {

	/** 시설정보 조회*/
	HashMap<String,Object> apiLsCompanyList(SP_PRDTINFVO apilsVO);

	/** 상품리스트정보 조회*/
	APILSRECIEVEVO apiLsProductList(SP_PRDTINFVO apilsVO);

	/** 상품상세정보 조회*/
	APILSRECIEVEVO apiLsProduct(SP_PRDTINFVO apilsVO);

	/** 상품정보 동기화*/
	APILSRESULTVO apiLsProductListSync(SP_PRDTINFVO apilsVO);

	/** 티켓 주문*/
	String requestOrderLsCompany(APILSVO apilsVO) throws ParseException;

	/** 티켓 상태확인*/
	LinkedHashMap<String, String> requestOrderChkLsCompany(APILSVO apilsVO);

	/** 티켓 발권취소*/
	APILSRECIEVEVO requestCancelLsCompany(APILSVO apilsVO) throws ParseException;

	/** 티켓 상태변경*/
	APILSRESULTVO apiLsUseCancelTicket(SP_PRDTINFVO apilsVO);

	/** 티켓 재발송*/
	APILSRECIEVEVO requestSMSLsCompany(APILSVO apilsVO);

	/**바코드리스트*/
	APILSRESULTVO apiLsBarcodeList(SP_PRDTINFVO apilsVO);

	APILSVO selectPinCodeLsCompanany(APILSRECIEVEVO apiLsRecieveVO);

	/** LS컴퍼니 상품연동 확인*/
	APILSRESULTVO requestUseableLsCompanyProduct(APILSVO apilsVO);

	/** LS컴퍼니 상품확인 SMS재발송 확인용*/
	Integer checkSMSLsCompany(APILSVO apilsVO);

	void updatePinCodeLsCompany(APILSRECIEVEVO apiLsRecieveVO);

}
