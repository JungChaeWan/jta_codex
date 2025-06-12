package api.service.impl;

import api.service.APIHijejuService;
import api.vo.APILSRESULTVO;
import api.vo.APILSVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;

@Service("apiHijejuService")
public class APIHijejuServiceImpl extends EgovAbstractServiceImpl implements APIHijejuService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());
	public static final String HI_JEJU_URL = "http://tamnao.ls-api.co.kr";
	public static final String HI_JEJU_AUTH = "HXNdHXBsHXNg";

	@Resource(name = "apiHijejuDAO")
	private APIHijejuDAO apiHijejuDAO;

	/** 하이제주 주문요청 */
	@Override
	public String requestOrderHijeju(APILSVO apilsvo) throws ParseException {

		String resultYn = "N";
		List<APILSVO> resultList =  apiHijejuDAO.requestOrderHijeju(apilsvo);

		if(resultList.size() < 1 ){
            resultYn = "Y";
        }else{
            SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
            Calendar time = Calendar.getInstance();
            String curTime = format1.format(time.getTime());
            JSONObject jsonObject = new JSONObject();
            JSONArray req_array = new JSONArray();
            int j = 0;
            for(APILSVO resultVO : resultList){
                if(j == 0){
                    jsonObject.put("orderId", resultVO.getRsvNum());
                    jsonObject.put("orderDateTime", curTime);
                    jsonObject.put("payUserHp", resultVO.getRsvTelnum());
                    jsonObject.put("payUserName", resultVO.getRsvNm());
                    jsonObject.put("userHp", resultVO.getUseTelnum());
                    jsonObject.put("userName", resultVO.getUseNm());
                }

                for(int i = 0; i < resultVO.getBuyNum(); i++) {
                    JSONObject data = new JSONObject();
                    data.put("orderItemId", resultVO.getSpRsvNum());
                    data.put("productId", resultVO.getLsLinkPrdtNum());
                    data.put("optionId", resultVO.getLsLinkOptNum());
                    data.put("BarCode", "");
                    data.put("productName", resultVO.getPrdtNm());
                    data.put("optionName", resultVO.getOptNm());
                    data.put("PayPrice", resultVO.getNmlAmt());
                    data.put("salePrice", resultVO.getSaleAmt());
                    data.put("costPrice", resultVO.getCmssAmt());
                    req_array.add(data);
                }
                jsonObject.put("items", req_array);
                j++;
            }
		    log.info(" send order data to Hijeju : " + jsonObject.toString());
            /** send order data to Hijeju */
            HttpHeaders headers = new HttpHeaders();
            Charset utf8 = Charset.forName("UTF-8");
            MediaType mediaType = new MediaType("application", "json", utf8);
            headers.add("Authorization", HI_JEJU_AUTH);
            headers.setContentType(mediaType);
            HttpEntity param= new HttpEntity(jsonObject.toString(), headers);
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
            String resultStr = restTemplate.postForObject(HI_JEJU_URL +"/order/" ,param, String.class);
            log.info("order result Hijeju str : " + resultStr);
            /** jsonData handling */
            JSONParser jsonParse = new JSONParser();
	        JSONObject jsonObj = (JSONObject) jsonParse.parse(resultStr);
	        log.info("order result Hijeju : "+ jsonObj + " (code : " +  jsonObj.get("code") + "),(message: " + jsonObj.get("message") + ")");
	        JSONArray returnArray = (JSONArray) jsonObj.get("items");
	        if(returnArray != null && returnArray.size() > 0 && "200".equals(jsonObj.get("code"))) {
	        	for(int i=0; i < returnArray.size(); i++) {
		        JSONObject personObject = (JSONObject) returnArray.get(i);
		        APILSRESULTVO updateVO = new APILSRESULTVO();
                updateVO.setOrderItemId(personObject.get("orderItemId").toString());
                updateVO.setPinCode(personObject.get("pinCode").toString());
                /** 하이제주상품 핀코드 업데이트*/
                apiHijejuDAO.updatePinCodeHijeju(updateVO);
		        resultYn = "Y";
              }
	        }else{
	            resultYn = "N";
            }
        }
		return resultYn;
	}

	/** 하이제주 취소요청 */
	@Override
	public APILSRESULTVO requestCancelHijeju(APILSVO apilsVO){
        RestTemplate restTemplate = new RestTemplate();
        /** 미디어타입이 text/html/ 일경우 */
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setSupportedMediaTypes(Collections.singletonList(MediaType.TEXT_HTML));
        restTemplate.getMessageConverters().add(converter);

        APILSRESULTVO resultVO = new APILSRESULTVO();
        /** 주문아이템번호 */
        JSONObject contents = new JSONObject();
        contents.put("orderItemId",apilsVO.getSpRsvNum());
        JSONObject data = new JSONObject();
        data.put("data",contents);

        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("UTF-8");
        MediaType mediaType = new MediaType("application", "json", utf8);
        headers.add("Authorization", HI_JEJU_AUTH);
        headers.setContentType(mediaType);
        HttpEntity param= new HttpEntity(data.toString(), headers);
        log.info("cancel request Hijeju : " + data.toString());
        resultVO = restTemplate.postForObject(HI_JEJU_URL +"/Itemcancel/" ,param, APILSRESULTVO.class);
        log.info("cancel result Hijeju : "+ data.toString() + "(code : " +  resultVO.getCode() + "),(message : " + resultVO.getMessage() + ")");
        return resultVO;
	}

	/** 하이제주 상품연동 확인 */
	@Override
	public APILSRESULTVO requestUseableHijejuProduct(APILSVO apilsvo){
        RestTemplate restTemplate = new RestTemplate();
        /** 미디어타입이 text/html/ 일경우 */
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setSupportedMediaTypes(Collections.singletonList(MediaType.TEXT_HTML));

        restTemplate.getMessageConverters().add(converter);
        APILSRESULTVO resultVO = new APILSRESULTVO();

        JSONObject jsonObject = new JSONObject();
        /*jsonObject.put("orderItemId",);*/
        /** 상품조회요청 */
        String sendApi = HI_JEJU_URL + "/Product/?" + apilsvo.getLsLinkPrdtNum() + "/" + apilsvo.getLsLinkOptNum() ;
        log.info("useable product request Hijeju : " + sendApi);
        try {
            resultVO = restTemplate.getForObject(sendApi, APILSRESULTVO.class);
            /*resultVO = restTemplate.postForObject(HI_JEJU_URL +"/Status/" ,param, String.class);*/
        }catch (HttpClientErrorException e){
            /** 예외처리(외부요인) */
            resultVO.setCode(e.getStatusCode().toString());
            resultVO.setMessage("External Error");
        }
        log.info("useable product result Hijeju : "+ sendApi + " (code : " +  resultVO.getCode() + "),(message: " + resultVO.getMessage() + ")");
        return resultVO;
	}

	/** LS컴퍼니 문자재발송 요청 */
	@Override
	public APILSRESULTVO requestSMSHijeju(APILSVO apilsvo){
        RestTemplate restTemplate = new RestTemplate();
        APILSRESULTVO resultVO = new APILSRESULTVO();
        /** 주문번호 */
        String sendApi = HI_JEJU_URL + "/Order/SMS/" + apilsvo.getRsvNum();
        log.info("SMS request Hijeju : " + sendApi);
        try {
            /** 문자재발송요청 */
            resultVO = restTemplate.getForObject(sendApi, APILSRESULTVO.class);
        }catch (HttpClientErrorException e){
            /** 예외처리(외부요인) */
            resultVO.setCode(e.getStatusCode().toString());
            resultVO.setMessage("External Error");
        }
        log.info("SMS result Hijeju : "+ sendApi + " (code : " +  resultVO.getCode() + "),(message: " + resultVO.getMessage() + ")");
        return resultVO;
	}

	/** 하이제주 예약상태확인 */
	@Override
	public APILSRESULTVO requestOrderChkHijeju(APILSVO apilsVO){
        RestTemplate restTemplate = new RestTemplate();
        /** 미디어타입이 text/html/ 일경우 */
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setSupportedMediaTypes(Collections.singletonList(MediaType.TEXT_HTML));
        restTemplate.getMessageConverters().add(converter);

        APILSRESULTVO resultVO = new APILSRESULTVO();
        /** 주문아이템번호 */
        JSONObject contents = new JSONObject();
        contents.put("orderItemId",apilsVO.getSpRsvNum());
        JSONObject data = new JSONObject();
        data.put("data",contents);

        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("UTF-8");
        MediaType mediaType = new MediaType("application", "json", utf8);
        headers.add("Authorization", HI_JEJU_AUTH);
        headers.setContentType(mediaType);
        HttpEntity param= new HttpEntity(data.toString(), headers);
        log.info("orderchk request Hijeju : " + data.toString());
        resultVO = restTemplate.postForObject(HI_JEJU_URL +"/Status/" ,param, APILSRESULTVO.class);
        log.info("orderchk result Hijeju : "+ data.toString() + "(code : " +  resultVO.getCode() + "),(message : " + resultVO.getMessage() + ")");
        return resultVO;
	}
	/** 하이제주 문자재발송 요청 */
	@Override
	public Integer checkSMSHijeju(APILSVO apilsVO){
        return apiHijejuDAO.checkSMSHijeju(apilsVO);
	}
}
