package api.service.impl;

import api.service.APIVpService;
import api.vo.APILSRECIEVEVO;
import api.vo.APILSRESULTVO;
import api.vo.APILSVO;
import api.vo.APIVPRECIEVEVO;
import common.AES128;
import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.sp.vo.SP_PRDTINFVO;
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
import sun.security.krb5.internal.crypto.Aes128;

import javax.annotation.Resource;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("apiVpService")
public class APIVpServiceImpl extends EgovAbstractServiceImpl implements APIVpService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

    public static final String DEV_VPASS_URL = "http://devel.jejuv.com/api/partner";
    public static final String DEV_BEARER_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.IjI1OTci.pd5dGJR60pODewaDmBU9s-2Yck47VBR5O961gQmz04I";

	public static final String REAL_VPASS_URL = "http://cp.jejuv.com/api/partner";
	public static final String REAL_BEARER_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.IjI1OTci.BeqI9TY69mwlZoIT4n2namkL_DAoWLI0EStJJpBusyg";


	public static final String AES_128KEY_VPASS= "5178800e17d58029";

	public static final String CST_PLATFORM  = EgovProperties.getOptionalProp("CST_PLATFORM");

	@Resource(name = "apiVpDAO")
	private APIVpDAO apiVpDAO;

	/** 브이패스 발권 */
	@Override
	public String requestOrderVpCompany(APILSVO apilsVO) {

		String resultYn = "N";
		List<APILSVO> resultList =  apiVpDAO.requestOrderLsCompany(apilsVO);

		if(resultList.size() < 1 ){
            resultYn = "Y";
        }else{
            int j = 0;
            JSONObject jsonObject1 = new JSONObject();
            JSONArray req_array = new JSONArray();
            for(APILSVO resultVO : resultList){
                /** 발권 */

                JSONObject jsonObject2 = new JSONObject();
                if(j == 0) {
                    jsonObject1.put("STATE", "issue");
                    jsonObject1.put("ORDER_SEQ", resultVO.getRsvNum());
                    jsonObject1.put("NAME", resultVO.getUseNm());
                    jsonObject1.put("HP", resultVO.getUseTelnum());
                }

                for(int i = 0; i < resultVO.getBuyNum(); i++) {
                    JSONObject data = new JSONObject();
                    data.put("PIN", resultVO.getSpRsvNum() + "_" + i);
                    data.put("OPT", resultVO.getLsLinkOptNum());

                    jsonObject2.put(resultVO.getSpRsvNum() + "_" + i,0);

                    req_array.add(data);
                }
                jsonObject1.put("ITEM_ARR", req_array);
                APILSRECIEVEVO updateVO = new APILSRECIEVEVO();
                updateVO.setOrderNo(resultVO.getSpRsvNum());
                updateVO.setBarcode(jsonObject2.toJSONString());
                /** LS상품 바코드 업데이트 */
                try{
                    apiVpDAO.updatePinCodeLsCompany(updateVO);
                }catch(Exception e){
                    return "N";
                }
                j++;
            }
            log.info("send issue data to Vpass : " + jsonObject1.toString());

            /** send order data to lsCompany */
            HttpHeaders headers = new HttpHeaders();
            Charset utf8 = Charset.forName("UTF-8");
            MediaType mediaType = new MediaType("application", "json", utf8);
            headers.setContentType(mediaType);
            if("test".equals(CST_PLATFORM.trim())) {
                headers.add("Authorization", "Bearer " + DEV_BEARER_TOKEN);
            }else{
                headers.add("Authorization", "Bearer " + REAL_BEARER_TOKEN);
            }

            AES128 aes128 = new AES128();
            String encryptJson = aes128.encrypt(jsonObject1.toString(),AES_128KEY_VPASS);

            HttpEntity param = new HttpEntity(encryptJson, headers);
            RestTemplate restTemplate = new RestTemplate();
            APIVPRECIEVEVO receiveVO;

            if("test".equals(CST_PLATFORM.trim())) {
                receiveVO = restTemplate.postForObject(DEV_VPASS_URL, param, APIVPRECIEVEVO.class);
            }else{
                receiveVO = restTemplate.postForObject(REAL_VPASS_URL, param, APIVPRECIEVEVO.class);
            }

            if("0000".equals(receiveVO.getRESULT())){
                resultYn = "Y";
            }else{
                resultYn = "N";
            }
        }
		return resultYn;
	}

    /** 브이패스 취소요청 */
	@Override
	public APILSRECIEVEVO requestCancelVpCompany(APILSVO apilsVO) throws ParseException {
	    JSONParser jsonParse = new JSONParser();
        JSONObject transactionObj = (JSONObject) jsonParse.parse(apilsVO.getTransactionId());
        JSONObject updatetransactionObj = new JSONObject();
        boolean resultStatus = false;
        for(int i = 0; i<apilsVO.getBuyNum(); i++){
            System.out.println("step2");
            Long transactionValue =  (Long) transactionObj.get(apilsVO.getSpRsvNum()+"_"+i);
            if(transactionValue == 0){
                JSONObject jsonObject1 = new JSONObject();

                jsonObject1.put("STATE","cancel");
                jsonObject1.put("ORDER_SEQ",apilsVO.getRsvNum());
                jsonObject1.put("PIN",apilsVO.getSpRsvNum()+"_"+i);

                log.info("send cancel to vpass : " + jsonObject1.toString());

                /** send order data to lsCompany */
                HttpHeaders headers = new HttpHeaders();
                Charset utf8 = Charset.forName("UTF-8");
                MediaType mediaType = new MediaType("application", "json", utf8);
                headers.setContentType(mediaType);
                if("test".equals(CST_PLATFORM.trim())) {
                    headers.add("Authorization", "Bearer " + DEV_BEARER_TOKEN);
                }else{
                    headers.add("Authorization", "Bearer " + REAL_BEARER_TOKEN);
                }

                AES128 aes128 = new AES128();
                String encryptJson = aes128.encrypt(jsonObject1.toString(),AES_128KEY_VPASS);

                HttpEntity param = new HttpEntity(encryptJson, headers);
                RestTemplate restTemplate = new RestTemplate();
                APIVPRECIEVEVO receiveVO;

                if("test".equals(CST_PLATFORM.trim())) {
                    receiveVO = restTemplate.postForObject(DEV_VPASS_URL, param, APIVPRECIEVEVO.class);
                }else{
                    receiveVO = restTemplate.postForObject(REAL_VPASS_URL, param, APIVPRECIEVEVO.class);
                }

                /** 취소 */
                if("0000".equals(receiveVO.getRESULT())){
                    transactionValue = 2L;
                    resultStatus = true;
                    log.info(receiveVO.getRESULT());
                    log.info(receiveVO.getMSG());
                }else{
                    transactionValue = 1L;
                    log.info(receiveVO.getRESULT());
                    log.info(receiveVO.getMSG());
                }
            }
            updatetransactionObj.put(apilsVO.getSpRsvNum()+"_"+i,transactionValue);
        }

        APILSRECIEVEVO finalVO = new APILSRECIEVEVO();
        if(resultStatus){
            APILSRECIEVEVO updateVO = new APILSRECIEVEVO();
            updateVO.setOrderNo(apilsVO.getSpRsvNum());
            updateVO.setBarcode(updatetransactionObj.toJSONString());
            /** LS상품 핀코드 업데이트*/
            apiVpDAO.updatePinCodeLsCompany(updateVO);
            finalVO.setResultCode("0000");
        }else{
            finalVO.setResultCode("9999");
        }
        return finalVO;
	}

	/** 브이패스 정보조회 */
	@Override
	public LinkedHashMap<String, String> requestOrderChkVpCompany(APILSVO apilsVO){
        LinkedHashMap<String, String> receiveMap = new LinkedHashMap<String, String>();

        for(int i = 0; i < apilsVO.getBuyNum(); ++i ){
            JSONObject jsonObject1 = new JSONObject();

            jsonObject1.put("ORDER_SEQ",apilsVO.getRsvNum());
            jsonObject1.put("PIN",apilsVO.getSpRsvNum()+"_" + i);
            jsonObject1.put("STATE","search");

            log.info("send inquiry to Vpass : " + jsonObject1.toString());

            HttpHeaders headers = new HttpHeaders();
            Charset utf8 = Charset.forName("UTF-8");
            MediaType mediaType = new MediaType("application", "json", utf8);
            headers.setContentType(mediaType);
            if("test".equals(CST_PLATFORM.trim())) {
                headers.add("Authorization", "Bearer " + DEV_BEARER_TOKEN);
            }else{
                headers.add("Authorization", "Bearer " + REAL_BEARER_TOKEN);
            }

            AES128 aes128 = new AES128();
            String encryptJson = aes128.encrypt(jsonObject1.toString(),AES_128KEY_VPASS);

            HttpEntity param= new HttpEntity(encryptJson, headers);
            RestTemplate restTemplate = new RestTemplate();
            APIVPRECIEVEVO receiveVO;
            if("test".equals(CST_PLATFORM.trim())) {
                receiveVO = restTemplate.postForObject(DEV_VPASS_URL, param, APIVPRECIEVEVO.class);
            }else{
                receiveVO = restTemplate.postForObject(REAL_VPASS_URL,param, APIVPRECIEVEVO.class);
            }
            receiveMap.put(apilsVO.getSpRsvNum()+"_" + i, receiveVO.getABLE_CANCEL());
        }
        return receiveMap;
	}

	@Override
    public void updateVpStatus(APILSVO apilsVO) {
        apiVpDAO.updateVpStatus(apilsVO);
    }

	/** 브이패스 문자재발송 요청 */
	@Override
	public APIVPRECIEVEVO requestSMSVpCompany(APILSVO apilsVO){
	    JSONObject jsonObject1 = new JSONObject();

	    jsonObject1.put("ORDER_SEQ",apilsVO.getRsvNum());
        jsonObject1.put("PIN",apilsVO.getSpRsvNum()+"_0");
        jsonObject1.put("STATE","resend");
        jsonObject1.put("HP",apilsVO.getUseTelnum());

        log.info("send resend to lsCompany : " + jsonObject1.toString());

        /** send order data to lsCompany */
        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("UTF-8");
        MediaType mediaType = new MediaType("application", "json", utf8);
        headers.setContentType(mediaType);
        if("test".equals(CST_PLATFORM.trim())) {
            headers.add("Authorization", "Bearer " + DEV_BEARER_TOKEN);
        }else{
            headers.add("Authorization", "Bearer " + REAL_BEARER_TOKEN);
        }

        AES128 aes128 = new AES128();
                String encryptJson = aes128.encrypt(jsonObject1.toString(),AES_128KEY_VPASS);

        HttpEntity param = new HttpEntity(encryptJson, headers);
        RestTemplate restTemplate = new RestTemplate();
        APIVPRECIEVEVO receiveVO;

        if("test".equals(CST_PLATFORM.trim())) {
            receiveVO = restTemplate.postForObject(DEV_VPASS_URL, param, APIVPRECIEVEVO.class);
        }else{
            receiveVO = restTemplate.postForObject(REAL_VPASS_URL, param, APIVPRECIEVEVO.class);
        }

        return receiveVO;
	}

	@Override
	public void updatePinCodeLsCompany(APILSRECIEVEVO apiLsRecieveVO){
	    apiVpDAO.updatePinCodeLsCompany(apiLsRecieveVO);
    };

    @Override
    public APILSRESULTVO apiLsUseCancelTicket(SP_PRDTINFVO apilsVO) {
        return null;
    }

    @Override
    public APILSRESULTVO apiLsBarcodeList(SP_PRDTINFVO apilsVO) {
        return null;
    }

    @Override
    public APILSVO selectPinCodeLsCompanany(APILSRECIEVEVO apiLsRecieveVO) {
        return apiVpDAO.selectPinCodeLsCompanany(apiLsRecieveVO);
    }

}
