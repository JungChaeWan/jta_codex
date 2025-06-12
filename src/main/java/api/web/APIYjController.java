package api.web;

import api.service.APIYjService;
import api.vo.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.util.HashMap;
import java.util.Map;

@Controller
public class APIYjController {
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name="apiYjService")
    private APIYjService apiYjService;

	@RequestMapping(value="/ext/yjCallback/pins/use", produces = "application/json; charset=utf8")
	public ModelAndView yjCallbackUse(HttpServletRequest request){
		log.info("yj callback");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			StringBuffer json = new StringBuffer();
		String line = null;
		try {
			BufferedReader reader = request.getReader();
			while((line = reader.readLine()) != null) {
				json.append(line);
			}
		}catch(Exception e) {}

		JSONParser parser = new JSONParser();
        JSONObject jsonObj = (JSONObject) parser.parse(json.toString());

        JSONArray pinNumbersArray = (JSONArray) jsonObj.get("pinNumbers");

		APITOURSVO apiyjdataVO = new APITOURSVO();
		APITOURSVO resultApi = new APITOURSVO();
		int j = 0;
        for(Object pinNumber : pinNumbersArray){
        	log.info("jsonContents :::" + pinNumber);
        	apiyjdataVO.setPinCode(pinNumber.toString());
        	/** APIRSV 상태변경*/
        	apiYjService.requestUseStatusYj(apiyjdataVO);
        	/** 대예약번호 한번만 select*/
        	if(j == 0 ){
				resultApi = apiYjService.selectRsvNum(apiyjdataVO);
			}
        	apiYjService.requestAddCnt(resultApi.getSpRsvNum());
        	j++;
		}
        /** 대예약번호로 사용처리*/
        apiyjdataVO.setRsvStatusCd("RS30");
        apiyjdataVO.setRsvNum(resultApi.getRsvNum());
        apiYjService.requestUseStatusRsv(apiyjdataVO);

		resultMap.put("code", "0");
		resultMap.put("message", "OK");
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;

		} catch(Exception ex) {
			resultMap.put("code", "1");
			resultMap.put("message", "NO");
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
        	return mav;
		}
	}

	@RequestMapping(value="/ext/yjCallback/pins/cancel-used", produces = "application/json; charset=utf8")
	public ModelAndView yjCallbackCancelUsed(HttpServletRequest request) throws ParseException {
		log.info("yj callback");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			StringBuffer json = new StringBuffer();
		String line = null;
		try {
			BufferedReader reader = request.getReader();
			while((line = reader.readLine()) != null) {
				json.append(line);
			}
		}catch(Exception e) {}

		JSONParser parser = new JSONParser();
        JSONObject jsonObj = (JSONObject) parser.parse(json.toString());

        JSONArray pinNumbersArray = (JSONArray) jsonObj.get("pinNumbers");

		APITOURSVO apiyjdataVO = new APITOURSVO();
		APITOURSVO resultApi = new APITOURSVO();
		int j = 0;
		String rsvNum = "";
        for(Object pinNumber : pinNumbersArray){
        	log.info("jsonContents :::" + pinNumber);
        	apiyjdataVO.setPinCode(pinNumber.toString());
        	/** APIRSV 상태변경*/
        	apiYjService.requestUseUndoStatusYj(apiyjdataVO);
        	/** 대예약번호 한번만 select*/
        	if(j == 0 ){
				resultApi = apiYjService.selectRsvNum(apiyjdataVO);
			}
        	apiYjService.requestSubCnt(resultApi.getSpRsvNum());
        	j++;
		}
        /** 대예약번호로 사용처리*/
        apiyjdataVO.setRsvStatusCd("RS02");
        apiyjdataVO.setRsvNum(resultApi.getRsvNum());
        apiYjService.requestUseStatusRsv(apiyjdataVO);

		resultMap.put("code", "0");
		resultMap.put("message", "OK");
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;

		} catch(Exception ex) {
			resultMap.put("code", "1");
			resultMap.put("message", "NO");
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
        	return mav;
		}
	}

}

