package api.vo;

import org.apache.commons.beanutils.PropertyUtils;

import oss.corp.vo.CORPVO;

import common.Constant;

public class APIValidation {
	
	public static final String ERR101 = "ERR101";
	public static final String ERR201 = "ERR201";
	public static final String ERR202 = "ERR202";
	public static final String ERR301 = "ERR301";
	public static final String ERR901 = "ERR901";

    
	public static ERRORVO isEmptyOrWhitespace(ParamVO paramVO,  String[] args) throws Exception {
		ERRORVO errorVO = null;	
		for(String key : args) {
				Object aaa = PropertyUtils.getProperty(paramVO, key);
			if(paramVO==null || aaa == null || aaa.toString().trim().length() == 0){
				errorVO = new ERRORVO();
				errorVO.setRetCode("ERR");
				errorVO.setErrorCode(ERR201);
				errorVO.setErrorMsg(key + "은(는) 필수 파라미터 입니다.");
				return errorVO;
			}
		}
		return errorVO;
	}
	
	public static ERRORVO isWrongCorp(String key, CORPVO value) {
		ERRORVO errorVO = new ERRORVO();
		if(value == null) {
			errorVO.setRetCode("ERR");
			errorVO.setErrorCode(ERR202);
			errorVO.setErrorMsg(key + "은(는) 값이 잘못되었습니다.");
			return errorVO;
		}
		// 해당 업체가 승인중인 상태인지 체크
		else if(!Constant.TRADE_STATUS_APPR.equals(value.getTradeStatusCd())){
			errorVO.setRetCode("ERR");
			errorVO.setErrorCode(ERR301);
			errorVO.setErrorMsg(key + "은(는) 판매중인 업체가 아닙니다.");
			return errorVO;
		}
		return null;
	}
	
	public static ERRORVO isExcepton() {
		ERRORVO errorVO = new ERRORVO();
		errorVO.setRetCode("ERR");
		errorVO.setErrorCode(ERR901);
		errorVO.setErrorMsg("알수 없는 에러가 발생했습니다.");
		return errorVO;
	}
}
