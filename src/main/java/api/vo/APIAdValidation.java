package api.vo;

import java.util.Map;

import mas.ad.vo.AD_DFTINFVO;

import org.apache.commons.beanutils.PropertyUtils;

public class APIAdValidation {
	
	public static final String ERR101 = "ERR101";
	public static final String ERR201 = "ERR201";
	public static final String ERR202 = "ERR202";
	public static final String ERR901 = "ERR901";

    
	public static boolean isEmptyOrWhitespace(Map<String, Object> resultMap, ParamAdVO paramVO,  String[] args) throws Exception {
		
		//Logger log = (Logger) LogManager.getLogger();
		
		//ERRORVO errorVO = null;	
		for(String key : args) {
				Object aaa = PropertyUtils.getProperty(paramVO, key);
			if(paramVO==null || aaa == null || aaa.toString().trim().length() == 0){
				//errorVO = new ERRORVO();
				//errorVO.setErrorCode(ERR201);
				//errorVO.setErrorMsg(key + "은(는) 필수 파라미터 입니다.");
				
				resultMap.put("rtCode", "ERR");
	   			resultMap.put("errorCode", "ERR201");
	   			resultMap.put("errorMsg", key + "은(는) 필수 파라미터 입니다.");
				
				return false;
			}
		}
		return true;
	}
	
	public static void isWrongCorp(Map<String, Object> resultMap, String key, AD_DFTINFVO value) {
		if(value == null) {
			//errorVO.setErrorCode(ERR202);
			//errorVO.setErrorMsg(key + "은(는) 값이 잘못되었습니다.");
			
			resultMap.put("rtCode", "ERR");
   			resultMap.put("errorCode", "ERR202");
   			resultMap.put("errorMsg", key + "은(는) 값이 잘못되었습니다.");
			
			//return ;
		}
		//return null;
	}
	
	public static void isWrongComm(Map<String, Object> resultMap, String key, AD_DFTINFVO value) {
		if(value == null) {
			
			resultMap.put("rtCode", "ERR");
   			resultMap.put("errorCode", "ERR901");
   			resultMap.put("errorMsg", "통신 오류가 발생 하였습니다.("+key+")");
			
			//return ;
		}
		//return null;
	}
	
	public static void isExcepton(Map<String, Object> resultMap) {
		//ERRORVO errorVO = new ERRORVO();
		//errorVO.setErrorCode(ERR901);
		//errorVO.setErrorMsg("알수 없는 에러가 발생했습니다.");
		//return errorVO;
		
		resultMap.put("rtCode", "ERR");
		resultMap.put("errorCode", "ERR901");
		resultMap.put("errorMsg", "알수 없는 에러가 발생했습니다.");
	}
}
