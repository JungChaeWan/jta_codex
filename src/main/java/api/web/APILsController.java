package api.web;

import api.service.APILsService;
import api.vo.*;
import mas.sp.vo.SP_PRDTINFVO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import oss.monitoring.vo.TLCORPVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.*;

@Controller
public class APILsController {
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name="apiLsService")
    private APILsService apiLsService;

	/** 시설정보 */
	@RequestMapping("/oss/lsCompanyList.do")
    public String lsCompanyList(ModelMap model, SP_PRDTINFVO webParam){
		webParam.setType("all");
        HashMap<String,Object> resultVO =  apiLsService.apiLsCompanyList(webParam);
        model.addAttribute("resultList", resultVO);
        return "/oss/monitoring/lsCompanyList";
    }

	/** 상품리스트 */
	@RequestMapping("/oss/lsProductList.do")
    public String lsProductList(ModelMap model, SP_PRDTINFVO webParam){
		webParam.setType("all");
        APILSRECIEVEVO resultVO =  apiLsService.apiLsProductList(webParam);
        model.addAttribute("resultList", resultVO);
        return "/oss/monitoring/lsProductList";
    }

    /** 상품상세 */
	@RequestMapping("/oss/lsProductDetail.ajax")
    public ModelAndView lsProductDetail(ModelMap model, SP_PRDTINFVO webParam){
        HashMap<String,Object> resultData = new HashMap<>();
        webParam.setType("single");
		APILSRECIEVEVO resultVO =  apiLsService.apiLsProduct(webParam);
		resultData.put("resultData",resultVO);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;

    }

	/**상품정보 리스트 완료*//*
	@RequestMapping("/oss/tlCorpList.do")
	public ModelAndView productList(@ModelAttribute("searchVO") SP_PRDTINFVO webParam) throws ParseException, IOException {
		HashMap<String,Object> resultData = new HashMap<>();
		webParam.setType("all");
		APILSRECIEVEVO resultVO =  apiLsService.apiLsProductList(webParam);
		resultData.put("resultData",resultVO.getList());
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}*/

	/**상품정보 동기화 완료*/
	@RequestMapping("/apiLs/productListSync.ajax")
	public ModelAndView productListSync(@ModelAttribute("searchVO") SP_PRDTINFVO webParam) throws ParseException, IOException {
		HashMap<String,Object> resultData = new HashMap<>();
		webParam.setType("all");
		APILSRESULTVO resultVO =  apiLsService.apiLsProductListSync(webParam);
		resultData.put("resultData",resultVO);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}

	@RequestMapping("/apiLs/sendLscompanyOrderChk.ajax")
	public ModelAndView sendLscompanyOrderChk(	@ModelAttribute("searchVO") APILSVO apilsVO) {
		LinkedHashMap<String, String> receiveMap =  apiLsService.requestOrderChkLsCompany(apilsVO);
		ModelAndView mav = new ModelAndView("jsonView", receiveMap);
		return mav;
	}

	/** API SERVER*/
	/**티켓 상태변경*/
	@RequestMapping("/apiLs/useCancelTicket.ajax")
	public ModelAndView useTicket(@ModelAttribute("searchVO") SP_PRDTINFVO webParam) throws ParseException, IOException {
		HashMap<String,Object> resultData = new HashMap<>() ;
		APILSRESULTVO resultVO =  apiLsService.apiLsUseCancelTicket(webParam);
		resultData.put("resultData",resultVO);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}

	/**바코드리스트 조회*/
	@RequestMapping("/apiLs/barcodeList.ajax")
	public ModelAndView barcodeList(@ModelAttribute("searchVO") SP_PRDTINFVO webParam) throws ParseException, IOException {
		HashMap<String,Object> resultData = new HashMap<>() ;
		APILSRESULTVO resultVO =  apiLsService.apiLsBarcodeList(webParam);
		resultData.put("resultData",resultVO);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}

	/** 티켓 재전송 ajax*/
	@RequestMapping("/apiLs/sendLscompanyMMSmsg.ajax")
	public ModelAndView sendLscompanyMMSmsg(	@ModelAttribute("searchVO") APILSVO apilsVO) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		APILSRECIEVEVO receiveVO = apiLsService.requestSMSLsCompany(apilsVO);

		if("0000".equals(receiveVO.getResultCode())){
			resultMap.put("success","전송이 완료 되었습니다.");
		}else{
			resultMap.put("success","전송이 실패했습니다.");
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/*@RequestMapping("/ext/lsCallback")
	public String tamnacardCallback(HashMap<String,Object> map)  throws IOException {
		log.info("lscompany callback");
		System.out.println("param : " + map.get("data"));
		return null;
	}*/



	@RequestMapping(value="/ext/lsCallback", produces = "application/json; charset=utf8")
	public ModelAndView lsCallback(HttpServletRequest request) throws ParseException {
		log.info("lscompany callback");
		log.info("sysout");

		StringBuffer json = new StringBuffer();
		String line = null;
		try {
			BufferedReader reader = request.getReader();
			while((line = reader.readLine()) != null) {
				json.append(line);
			}
		}catch(Exception e) {}

		JSONParser jsonParse = new JSONParser();
        JSONObject jsonObj = (JSONObject) jsonParse.parse(json.toString());
        JSONObject jsonContents = (JSONObject) jsonParse.parse(json.toString());

        jsonContents = (JSONObject)jsonObj.get("data");

        APILSRECIEVEVO apiLsRecieveVO = new APILSRECIEVEVO();
        apiLsRecieveVO.setOrderNo(jsonContents.get("orderNo").toString());
		APILSVO apilsVO = apiLsService.selectPinCodeLsCompanany(apiLsRecieveVO);

		JSONParser resultParse = new JSONParser();
        JSONObject resultObj = (JSONObject) resultParse.parse(apilsVO.getTransactionId());

        String spRsvNum = jsonContents.get("orderNo").toString();
        int buyNum = apilsVO.getBuyNum();
        int useNum = apilsVO.getUseNum();

        boolean isNotCancel = true;
        JSONObject updatetransactionObj = new JSONObject();
        for(int i=0; i < apilsVO.getBuyNum(); i++){
			Long transactionValue =  (Long) resultObj.get(spRsvNum+"_"+i);
			if(transactionValue == 2){
				isNotCancel = false;
				break;
			}
			if((spRsvNum+"_"+i).equals(jsonContents.get("transactionId"))){
				if(jsonContents.get("code").equals("use")){
					transactionValue = 1L;
					useNum++;
				}else if(jsonContents.get("code").equals("useCancel") ){
					transactionValue = 0L;
				useNum--;
				}
			}
			updatetransactionObj.put(spRsvNum+"_"+i, transactionValue);
		}

        if(isNotCancel){
        	APILSRECIEVEVO updateVO = new APILSRECIEVEVO();
			updateVO.setOrderNo(jsonContents.get("orderNo").toString());
			updateVO.setBarcode(updatetransactionObj.toJSONString());

			if(useNum >= buyNum){
				updateVO.setStatus("RS30");
			}else{
				updateVO.setStatus("RS02");
			}
			updateVO.setUseNum(useNum);
			apiLsService.updatePinCodeLsCompany(updateVO);
		}

			Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			if(isNotCancel){
				resultMap.put("status", "success");
				resultMap.put("resultCode", "0000");
				resultMap.put("resultMessage", "성공");
				ModelAndView mav = new ModelAndView("jsonView", resultMap);
				return mav;
			}else{
				resultMap.put("status", "failed");
				resultMap.put("resultCode", "9999");
				resultMap.put("resultMessage", "이미 취소된 건 입니다.");
				ModelAndView mav = new ModelAndView("jsonView", resultMap);
				return mav;
			}


		} catch(Exception ex) {
			resultMap.put("status", "failed");
			resultMap.put("resultCode", "9999");
			resultMap.put("resultMessage", "실패");
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
        	return mav;
		}
	}

}

