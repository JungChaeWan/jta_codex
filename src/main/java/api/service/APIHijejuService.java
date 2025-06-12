package api.service;

import api.vo.APILSRESULTVO;
import api.vo.APILSVO;
import org.json.simple.parser.ParseException;

public interface APIHijejuService {

	/** LS컴퍼니 주문요청*/
	String requestOrderHijeju(APILSVO apilsVO) throws ParseException;

	/** LS컴퍼니 취소요청*/
	APILSRESULTVO requestCancelHijeju(APILSVO apilsVO);

	/** LS컴퍼니 SMS재발송요청*/
	APILSRESULTVO requestSMSHijeju(APILSVO apilsVO);

	/** LS컴퍼니 예약상태확인*/
	APILSRESULTVO requestOrderChkHijeju(APILSVO apilsVO);

	/** LS컴퍼니 상품연동 확인*/
	APILSRESULTVO requestUseableHijejuProduct(APILSVO apilsVO);

	/** LS컴퍼니 상품확인 SMS재발송 확인용*/
	Integer checkSMSHijeju(APILSVO apilsVO);

}
