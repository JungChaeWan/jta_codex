package api.web;

import api.service.APIService;
import api.vo.ApiNextezSVO;
import common.LowerHashMap;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class APINextEzController {
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name="apiService")
	private APIService apiService;

	final static String authKey = "nextnextez";

	@RequestMapping(value="/apiNextEz/ad.do")
	public @ResponseBody Map<String, Object> apiNextEzAd(ApiNextezSVO apiNextezSVO) {
        log.info("/apiNextEz/ad.do" );
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String, Object> validateMap = apiValidator(apiNextezSVO);
        if(!"ok".equals(validateMap.get("status"))){
            validateMap.remove("status");
            return validateMap;
        }
        List<LowerHashMap> resultList;
        try {
            resultList = apiService.selectlistAdNextez(apiNextezSVO);
            if(resultList.size() > 0){
                resultMap.put("items",resultList);
                resultMap.put("code","200");
                resultMap.put("message","성공");
            }else{
                resultMap.put("code","201");
                resultMap.put("message","조회정보가 없습니다.");
            }

            return resultMap;
        } catch (Exception e) {
            resultMap.put("code","500");
            resultMap.put("message","시스템 장애");
            e.printStackTrace();
        } finally {
            return resultMap;
        }
	}

	@RequestMapping(value="/apiNextEz/rc.do")
	public @ResponseBody Map<String, Object> apiNextEzRc(ApiNextezSVO apiNextezSVO) {
        log.info("/apiNextEz/rc.do" );
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String, Object> validateMap = apiValidator(apiNextezSVO);
        if(!"ok".equals(validateMap.get("status"))){
            validateMap.remove("status");
            return validateMap;
        }
        List<LowerHashMap> resultList;
        try {
            resultList = apiService.selectlistRcNextez(apiNextezSVO);
            if(resultList.size() > 0){
                resultMap.put("items",resultList);
                resultMap.put("code","200");
                resultMap.put("message","성공");
            }else{
                resultMap.put("code","201");
                resultMap.put("message","조회정보가 없습니다.");
            }

            return resultMap;
        } catch (Exception e) {
            resultMap.put("code","500");
            resultMap.put("message","시스템 장애");
            e.printStackTrace();
        } finally {
            return resultMap;
        }
	}

	@RequestMapping(value="/apiNextEz/sp.do")
	public @ResponseBody Map<String, Object> apiNextSp(ApiNextezSVO apiNextezSVO) {
        log.info("/apiNextEz/sp.do" );
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String, Object> validateMap = apiValidator(apiNextezSVO);
        if(!"ok".equals(validateMap.get("status"))){
            validateMap.remove("status");
            return validateMap;
        }
        List<LowerHashMap> resultList;
        try {
            resultList = apiService.selectlistSpNextez(apiNextezSVO);
            if(resultList.size() > 0){
                resultMap.put("items",resultList);
                resultMap.put("code","200");
                resultMap.put("message","성공");
            }else{
                resultMap.put("code","201");
                resultMap.put("message","조회정보가 없습니다.");
            }

            return resultMap;
        } catch (Exception e) {
            resultMap.put("code","500");
            resultMap.put("message","시스템 장애");
            e.printStackTrace();
        } finally {
            return resultMap;
        }
	}

	/** API Validater */
	Map<String, Object> apiValidator(ApiNextezSVO apiNextezSVO){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("status","ok");
        if(!authKey.equals(apiNextezSVO.getAuthKey())){
            resultMap.put("code","401");
            resultMap.put("message","유효하지않은 인증키입니다.");
            resultMap.put("status","no");
            return resultMap;
        }
        if(apiNextezSVO.getSrcDt() == null || "".equals(apiNextezSVO.getSrcDt())){
            resultMap.put("code","402");
            resultMap.put("message","날짜정보가 정의되지 않았습니다.");
            resultMap.put("status","no");
            return resultMap;
        };
        if(apiNextezSVO.getSrcType() == null || "".equals(apiNextezSVO.getSrcType())){
            resultMap.put("code","403");
            resultMap.put("message","조회타입이 정의되지 않았습니다.");
            resultMap.put("status","no");
            return resultMap;
        };
        return resultMap;
    };
}

