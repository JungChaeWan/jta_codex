package api.web;

import api.service.APIVpService;
import api.vo.APILSRECIEVEVO;
import api.vo.APILSVO;
import api.vo.APIVPRECIEVEVO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

@Controller
public class APIVpController {
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name="apiVpService")
    private APIVpService apiVpService;
	
	/** 상품판매 Request*/
	@RequestMapping("/vpIssue.do")
    public String vpIssue(ModelMap model, APILSVO apilsVO){

        String apiLsCompanyList =  apiVpService.requestOrderVpCompany(apilsVO);
        return "/oss/monitoring/lsCompanyList";
    }

    @RequestMapping("/apiVp/sendLscompanyOrderChk.ajax")
	public ModelAndView sendLscompanyOrderChk(	@ModelAttribute("searchVO") APILSVO apilsVO) {
		LinkedHashMap<String, String> receiveMap =  apiVpService.requestOrderChkVpCompany(apilsVO);
		ModelAndView mav = new ModelAndView("jsonView", receiveMap);
		return mav;
	}

    /** 티켓 재전송 ajax*/
	@RequestMapping("/apiVp/sendVpassMMSmsg.ajax")
	public ModelAndView sendVpassMMSmsg(	@ModelAttribute("searchVO") APILSVO apilsVO) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		APIVPRECIEVEVO receiveVO = apiVpService.requestSMSVpCompany(apilsVO);

		if("0000".equals(receiveVO.getRESULT())){
			resultMap.put("success","전송이 완료 되었습니다.");
		}else{
			resultMap.put("success","전송이 실패했습니다.");
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	@RequestMapping(value="/ext/vpCallback", produces = "application/json; charset=utf8")
	public ModelAndView vpCallback(HttpServletRequest request) throws ParseException {
		log.info("vpass callback");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		StringBuffer json = new StringBuffer();
		String line = null;
		try {
			BufferedReader reader = request.getReader();
			while((line = reader.readLine()) != null) {
				json.append(line);
			}
		}catch(Exception e) {}

		try {
			APILSRECIEVEVO apiLsRecieveVO = new APILSRECIEVEVO();
			APILSVO apilsVO = new APILSVO();

			JSONParser jsonParse = new JSONParser();
			log.info("before parse ::: " + json);
			JSONObject jsonObj = (JSONObject) jsonParse.parse(json.toString());

			String state = "";
			if(jsonObj.get("state") != null ){
				state = jsonObj.get("state").toString();
				log.info("state ::: " + state);
			}
			String coupon = "";
			if(jsonObj.get("coupon") != null ){
				coupon = jsonObj.get("coupon").toString();
				log.info("coupon ::: " + coupon);
			}
			String orderSeq = "";
			if(jsonObj.get("orderSeq") != null ){
				orderSeq = jsonObj.get("orderSeq").toString();
				log.info("orderSeq ::: " + orderSeq);
			}

			if(state.equals("refund")){
				/** 쿠폰번호가 없을경우 전체 취소*/
				if("".equals(coupon)){
					apilsVO.setSpRsvNum("");
					apilsVO.setRsvNum(orderSeq);
					apiVpService.updateVpStatus(apilsVO);
					resultMap.put("code", "0000");
					resultMap.put("message", "성공");
					ModelAndView mav = new ModelAndView("jsonView", resultMap);
					return mav;
				/** 쿠폰번호가 있을경우 부분 취소*/
				}else{
					String[] arrayCoupon = coupon.split("_");
					apilsVO.setSpRsvNum(arrayCoupon[0]);
					apilsVO.setRsvNum(orderSeq);
					apiVpService.updateVpStatus(apilsVO);
					resultMap.put("code", "0000");
					resultMap.put("message", "성공");
					ModelAndView mav = new ModelAndView("jsonView", resultMap);
					return mav;
				}
			}

			String[] arrSpRsvNum =  jsonObj.get("coupon").toString().split("_");
			String spRsvNum = arrSpRsvNum[0];

			apiLsRecieveVO.setOrderNo(spRsvNum);
			apilsVO = apiVpService.selectPinCodeLsCompanany(apiLsRecieveVO);

			JSONParser resultParse = new JSONParser();
			JSONObject resultObj = (JSONObject) resultParse.parse(apilsVO.getTransactionId());

			if(state.equals("use") || state.equals("cancel") ){
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
					if((spRsvNum+"_"+i).equals(coupon)){
						if(state.equals("use")){
							transactionValue = 1L;
							useNum++;
						}else if(state.equals("cancel") ){
							transactionValue = 0L;
						useNum--;
						}
					}
					updatetransactionObj.put(spRsvNum+"_"+i, transactionValue);
				}
				if(isNotCancel){
					APILSRECIEVEVO updateVO = new APILSRECIEVEVO();
					updateVO.setOrderNo(spRsvNum);
					updateVO.setBarcode(updatetransactionObj.toJSONString());

					if(useNum >= buyNum){
						updateVO.setStatus("RS30");
					}else{
						updateVO.setStatus("RS02");
					}
					updateVO.setUseNum(useNum);
					apiVpService.updatePinCodeLsCompany(updateVO);
				}

				if(isNotCancel){
					resultMap.put("code", "0000");
					resultMap.put("message", "성공");
					ModelAndView mav = new ModelAndView("jsonView", resultMap);
					return mav;
				}else{
					resultMap.put("code", "1000");
					resultMap.put("message", "실패");
					ModelAndView mav = new ModelAndView("jsonView", resultMap);
					return mav;
				}
			}else if(state.equals("search")){
				int buyNum = apilsVO.getBuyNum();
				if(buyNum > 0){
					resultMap.put("code", "0000");
					resultMap.put("message", "성공");
					ModelAndView mav = new ModelAndView("jsonView", resultMap);
					return mav;
				}
			}
		} catch(Exception ex) {
			resultMap.put("code", "1000");
			resultMap.put("message", "실패");
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
        	return mav;
		}
		resultMap.put("code", "1000");
		resultMap.put("message", "실패");
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}



	/** 개별취소 Request*/

	/** 재전송 Request*/

	/** 사용처리 Response */

	/** 사용처리 Response */

	/** 사용처리 Response */

	/** 사용처리 Response */

	/*
	*//** 상품리스트 *//*
	@RequestMapping("/oss/lsProductList.do")
    public String lsProductList(ModelMap model, SP_PRDTINFVO webParam){
		webParam.setType("all");
        APILSRECIEVEVO resultVO =  apiVpService.apiLsProductList(webParam);
        model.addAttribute("resultList", resultVO);
        return "/oss/monitoring/lsProductList";
    }

    *//** 상품상세 *//*
	@RequestMapping("/oss/lsProductDetail.ajax")
    public ModelAndView lsProductDetail(ModelMap model, SP_PRDTINFVO webParam){
        HashMap<String,Object> resultData = new HashMap<>();
        webParam.setType("single");
		APILSRECIEVEVO resultVO =  apiVpService.apiLsProduct(webParam);
		resultData.put("resultData",resultVO);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;

    }

	*//**상품정보 리스트 완료*//**//*
	@RequestMapping("/oss/tlCorpList.do")
	public ModelAndView productList(@ModelAttribute("searchVO") SP_PRDTINFVO webParam) throws ParseException, IOException {
		HashMap<String,Object> resultData = new HashMap<>();
		webParam.setType("all");
		APILSRECIEVEVO resultVO =  apiVpService.apiLsProductList(webParam);
		resultData.put("resultData",resultVO.getList());
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}*//*

	*//**상품정보 동기화 완료*//*
	@RequestMapping("/apiLs/productListSync.ajax")
	public ModelAndView productListSync(@ModelAttribute("searchVO") SP_PRDTINFVO webParam) throws ParseException, IOException {
		HashMap<String,Object> resultData = new HashMap<>();
		webParam.setType("all");
		APILSRESULTVO resultVO =  apiVpService.apiLsProductListSync(webParam);
		resultData.put("resultData",resultVO);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}

	@RequestMapping("/apiLs/sendLscompanyOrderChk.ajax")
	public ModelAndView sendLscompanyOrderChk(	@ModelAttribute("searchVO") APILSVO apilsVO) {
		LinkedHashMap<String, String> receiveMap =  apiVpService.requestOrderChkLsCompany(apilsVO);
		ModelAndView mav = new ModelAndView("jsonView", receiveMap);
		return mav;
	}

	*//** API SERVER*//*
	*//**티켓 상태변경*//*
	@RequestMapping("/apiLs/useCancelTicket.ajax")
	public ModelAndView useTicket(@ModelAttribute("searchVO") SP_PRDTINFVO webParam) throws ParseException, IOException {
		HashMap<String,Object> resultData = new HashMap<>() ;
		APILSRESULTVO resultVO =  apiVpService.apiLsUseCancelTicket(webParam);
		resultData.put("resultData",resultVO);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}

	*//**바코드리스트 조회*//*
	@RequestMapping("/apiLs/barcodeList.ajax")
	public ModelAndView barcodeList(@ModelAttribute("searchVO") SP_PRDTINFVO webParam) throws ParseException, IOException {
		HashMap<String,Object> resultData = new HashMap<>() ;
		APILSRESULTVO resultVO =  apiVpService.apiLsBarcodeList(webParam);
		resultData.put("resultData",resultVO);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}

	*//** 티켓 재전송 ajax*//*
	@RequestMapping("/apiLs/sendLscompanyMMSmsg.ajax")
	public ModelAndView sendLscompanyMMSmsg(	@ModelAttribute("searchVO") APILSVO apilsVO) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		APILSRECIEVEVO receiveVO = apiVpService.requestSMSLsCompany(apilsVO);

		if("0000".equals(receiveVO.getResultCode())){
			resultMap.put("success","전송이 완료 되었습니다.");
		}else{
			resultMap.put("success","전송이 실패했습니다.");
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	*//*@RequestMapping("/ext/lsCallback")
	public String tamnacardCallback(HashMap<String,Object> map)  throws IOException {
		log.info("lscompany callback");
		System.out.println("param : " + map.get("data"));
		return null;
	}*//*



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
		APILSVO apilsVO = apiVpService.selectPinCodeLsCompanany(apiLsRecieveVO);

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

			if(useNum == buyNum){
				updateVO.setStatus("RS30");
			}else{
				updateVO.setStatus("RS02");
			}
			updateVO.setUseNum(useNum);
			apiVpService.updatePinCodeLsCompany(updateVO);
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
	}*/

}

