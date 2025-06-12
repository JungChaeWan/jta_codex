package api.service;

import api.vo.APILSRECIEVEVO;
import api.vo.APILSRESULTVO;
import api.vo.APILSVO;
import api.vo.APITOURSVO;
import mas.sp.vo.SP_PRDTINFVO;
import org.json.simple.parser.ParseException;

import java.util.HashMap;
import java.util.LinkedHashMap;

public interface APIYjService {

	/** 티켓 주문*/
	String requestOrderYanolja(APILSVO apilsVO) throws ParseException;

	/** 티켓 발권취소*/
	APILSRECIEVEVO requestCancelYj(APILSVO apilsVO) throws ParseException;

	/** 티켓 사용처리*/
	void requestUseStatusYj(APITOURSVO apitoursVo);

	APITOURSVO selectRsvNum(APITOURSVO apitoursVo);

	void requestUseStatusRsv(APITOURSVO apitoursVo);

	void requestAddCnt(String spRsvNum);

	void requestSubCnt(String spRsvNum);

	/** 티켓 복원처리*/
	void requestUseUndoStatusYj(APITOURSVO apitoursVo);
}
