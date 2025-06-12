package api.service.impl;

import api.service.APILsService;
import api.vo.APILSRECIEVEVO;
import api.vo.APILSRESULTVO;
import api.vo.APILSVO;
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
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("apiLsService")
public class APILsServiceImpl extends EgovAbstractServiceImpl implements APILsService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	public static final String LS_COMPANY_URL = "https://unity-prod.lscompany-api.com/Api_v3/";
	public static final String LS_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoic2VsbGVyIiwicGFyYW1zIjp7ImNvZGUiOiJDSDIzMDIyMjMifX0.F3y57lbbKkKl6LOXrRqQ9VTEWhiqj8RkWNYN4SHHW0w";
	public static final String LS_AGENT_NO = "CH2302223";

	public static final String LS_COMPANY_URL_DEV = "https://unity-dev.lscompany-api.com/Api_v3/";
	public static final String LS_TOKEN_DEV = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoic2VsbGVyIiwicGFyYW1zIjp7ImNvZGUiOiJDSDIzMDIxMDEifX0.ZKxTzMrwNF5zQDfX5JgqooVoqesvY_OovOimBvXAK8I";
	public static final String LS_AGENT_NO_DEV = "CH2302101";

   /* public static final String LS_COMPANY_URL = "https://unity-prod.lscompany-api.com/Api_v3/";
	public static final String LS_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoic2VsbGVyIiwicGFyYW1zIjp7ImNvZGUiOiJDSDIzMDIyMjMifX0.F3y57lbbKkKl6LOXrRqQ9VTEWhiqj8RkWNYN4SHHW0w";
	public static final String LS_AGENT_NO = "CH2302223";

	public static final String LS_COMPANY_URL_DEV = "https://unity-prod.lscompany-api.com/Api_v3/";
	public static final String LS_TOKEN_DEV = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoic2VsbGVyIiwicGFyYW1zIjp7ImNvZGUiOiJDSDIzMDIyMjMifX0.F3y57lbbKkKl6LOXrRqQ9VTEWhiqj8RkWNYN4SHHW0w";
	public static final String LS_AGENT_NO_DEV = "CH2302223";*/

	public static final String CST_PLATFORM  = EgovProperties.getOptionalProp("CST_PLATFORM");

	@Resource(name = "apiLsDAO")
	private APILsDAO apiLsDAO;

	/** 개발대기 */
    @Override
    public HashMap<String,Object> apiLsCompanyList(SP_PRDTINFVO apilsVO) {
        JSONObject jsonObject1 = new JSONObject();
        JSONObject jsonObject2 = new JSONObject();
        if("test".equals(CST_PLATFORM.trim())) {
            jsonObject2.put("agentNo",LS_AGENT_NO_DEV);
        }else{
            jsonObject2.put("agentNo",LS_AGENT_NO);
        }

        jsonObject1.put("data",jsonObject2);
        log.info("send apiLsCompanyList to lsCompany : " + jsonObject1.toString());

        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("UTF-8");
        MediaType mediaType = new MediaType("application", "json", utf8);
        headers.setContentType(mediaType);
        if("test".equals(CST_PLATFORM.trim())) {
            headers.add("Authorization",LS_TOKEN_DEV);
        }else{
            headers.add("Authorization",LS_TOKEN);
        }

        HttpEntity param= new HttpEntity(jsonObject1.toString(), headers);
        RestTemplate restTemplate = new RestTemplate();
        HashMap<String,Object> map = new HashMap<>();
        if("test".equals(CST_PLATFORM.trim())) {
            map = restTemplate.postForObject(LS_COMPANY_URL_DEV +"/place" ,param, HashMap.class);
        }else{
            map = restTemplate.postForObject(LS_COMPANY_URL +"/place" ,param, HashMap.class);
        }

        return map;
    }

    /** 완료 */
    @Override
    public APILSRECIEVEVO apiLsProductList(SP_PRDTINFVO webParam) {
        JSONObject jsonObject1 = new JSONObject();
        JSONObject jsonObject2 = new JSONObject();
        if("test".equals(CST_PLATFORM.trim())) {
            jsonObject2.put("agentNo",LS_AGENT_NO_DEV);
        }else{
            jsonObject2.put("agentNo",LS_AGENT_NO);
        }
        jsonObject2.put("type",webParam.getType());
        jsonObject1.put("data",jsonObject2);
        log.info("send apiLsProductList to lsCompany : " + jsonObject1.toString());

        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("UTF-8");
        MediaType mediaType = new MediaType("application", "json", utf8);
        headers.setContentType(mediaType);
        if("test".equals(CST_PLATFORM.trim())) {
            headers.add("Authorization",LS_TOKEN_DEV);
        }else{
            headers.add("Authorization",LS_TOKEN);
        }

        HttpEntity param= new HttpEntity(jsonObject1.toString(), headers);
        RestTemplate restTemplate = new RestTemplate();
        APILSRECIEVEVO receiveVO;
        if("test".equals(CST_PLATFORM.trim())) {
            receiveVO = restTemplate.postForObject(LS_COMPANY_URL_DEV +"/product" ,param, APILSRECIEVEVO.class);
        }else{
            receiveVO = restTemplate.postForObject(LS_COMPANY_URL +"/product" ,param, APILSRECIEVEVO.class);
        }
        /**LS연동업체ID get*/
        /*APILSVO coprVo = apiLsDAO.selectLsCorpId();*/
        APILSVO coprVo = new APILSVO();
        coprVo.setCorpId("C160000276");
        List<APILSVO> productList = apiLsDAO.selectListProductCode(coprVo);

        Integer optCnt = 0;

        if("0000".equals(receiveVO.getResultCode())){
            APILSVO apilsvo = new APILSVO();
            apilsvo.setCorpId(coprVo.getCorpId());
            for(int i = 0; i < receiveVO.getList().size() ; i++  ){
                boolean prdtIsYn = false;


                String expireType = "";

                apilsvo.setLsLinkPrdtNum(receiveVO.getList().get(i).getProduct_code());

                for(APILSVO tempVO : productList){
                    if(tempVO.getLsLinkPrdtNum().equals(receiveVO.getList().get(i).getProduct_code())){
                        prdtIsYn = true;
                        break;
                    }
                }

                for(int k = 0; k < receiveVO.getList().get(i).getOption().size(); k++){

                    apilsvo.setLsLinkOptNum(receiveVO.getList().get(i).getOption().get(k).getOptionId());
                    if(apiLsDAO.countOptCode(apilsvo) > 0){
                        receiveVO.getList().get(i).getOption().get(k).setOption_match("Y");
                    }else{
                        optCnt++;
                    }

                    expireType = receiveVO.getList().get(i).getOption().get(k).getExpireType();

                    if("date".equals(expireType)){
                        receiveVO.getList().get(i).getOption().get(k).setExpireType("유효기간");
                    }else if("day".equals(expireType)){
                        receiveVO.getList().get(i).getOption().get(k).setExpireType("유효일자");                    }
                }

                if(prdtIsYn){
                    receiveVO.getList().get(i).setProduct_match("Y");
                }
            }
        }
        receiveVO.setNoOptCnt(optCnt);

        return receiveVO;
    }

    /** 완료 */
    @Override
    public APILSRECIEVEVO apiLsProduct(SP_PRDTINFVO webParam) {
        JSONObject jsonObject1 = new JSONObject();
        JSONObject jsonObject2 = new JSONObject();
        if("test".equals(CST_PLATFORM.trim())) {
            jsonObject2.put("agentNo",LS_AGENT_NO_DEV);
        }else{
            jsonObject2.put("agentNo",LS_AGENT_NO);
        }
        jsonObject2.put("type",webParam.getType());
        jsonObject2.put("product_code",webParam.getLsLinkPrdtNum());
        jsonObject1.put("data",jsonObject2);
        log.info("send apiLsProduct to lsCompany : " + jsonObject1.toString());

        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("UTF-8");
        MediaType mediaType = new MediaType("application", "json", utf8);
        headers.setContentType(mediaType);
        if("test".equals(CST_PLATFORM.trim())) {
            headers.add("Authorization",LS_TOKEN_DEV);
        }else{
            headers.add("Authorization",LS_TOKEN);
        }

        HttpEntity param= new HttpEntity(jsonObject1.toString(), headers);
        RestTemplate restTemplate = new RestTemplate();
        APILSRECIEVEVO receiveVO;
        if("test".equals(CST_PLATFORM.trim())) {
            receiveVO = restTemplate.postForObject(LS_COMPANY_URL_DEV +"/product" ,param, APILSRECIEVEVO.class);
        }else{
            receiveVO = restTemplate.postForObject(LS_COMPANY_URL +"/product" ,param, APILSRECIEVEVO.class);
        }

        APILSVO coprVo = new APILSVO();
        coprVo.setLsLinkPrdtNum(webParam.getLsLinkPrdtNum());
        Integer product = apiLsDAO.countProductCode(coprVo);

        if("0000".equals(receiveVO.getResultCode()) && product > 0){
            APILSVO apilsvo = new APILSVO();
            apilsvo.setCorpId(coprVo.getCorpId());
            for(int i = 0; i < receiveVO.getList().size() ; i++  ){
                apilsvo.setLsLinkPrdtNum(receiveVO.getList().get(i).getProduct_code());

                for(int k = 0; k < receiveVO.getList().get(i).getOption().size(); k++){
                    if(receiveVO.getList().get(i).getOption().get(k).getOptionId().equals(webParam.getLsLinkOptNum())){
                        receiveVO.setResultMessage("옵션매칭성공\r상품구분명 : "+receiveVO.getList().get(i).getOption().get(k).getName()
                                +"\r"+ "정상가 : " + receiveVO.getList().get(i).getOption().get(k).getNormalPrice()
                                +"\r"+ "판매가 : " + receiveVO.getList().get(i).getOption().get(k).getSalePrice()
                                +"\r"+ "옵션명 : " + receiveVO.getList().get(i).getOption().get(k).getClassify()
                        );
                        break;
                    }
              }
            }
        }

        return receiveVO;
    }

    /** 완료 */
    @Override
    public APILSRESULTVO apiLsProductListSync(SP_PRDTINFVO webParam) {
        JSONObject jsonObject1 = new JSONObject();
        JSONObject jsonObject2 = new JSONObject();
        if("test".equals(CST_PLATFORM.trim())) {
            jsonObject2.put("agentNo",LS_AGENT_NO_DEV);
        }else{
            jsonObject2.put("agentNo",LS_AGENT_NO);
        }
        jsonObject2.put("type",webParam.getType());
        jsonObject1.put("data",jsonObject2);
        log.info("send apiLsProduct to lsCompany : " + jsonObject1.toString());

        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("UTF-8");
        MediaType mediaType = new MediaType("application", "json", utf8);
        headers.setContentType(mediaType);
        if("test".equals(CST_PLATFORM.trim())) {
            headers.add("Authorization",LS_TOKEN_DEV);
        }else{
            headers.add("Authorization",LS_TOKEN);
        }

        HttpEntity param= new HttpEntity(jsonObject1.toString(), headers);
        RestTemplate restTemplate = new RestTemplate();
        APILSRECIEVEVO receiveVO;
        if("test".equals(CST_PLATFORM.trim())) {
            receiveVO = restTemplate.postForObject(LS_COMPANY_URL_DEV +"/product" ,param, APILSRECIEVEVO.class);
        }else{
            receiveVO = restTemplate.postForObject(LS_COMPANY_URL +"/product" ,param, APILSRECIEVEVO.class);
        }

        /**LS연동업체ID get*/
        /*APILSVO coprVo = apiLsDAO.selectLsCorpId();*/
        APILSVO coprVo = new APILSVO();
        coprVo.setCorpId("C160000276");

        if("0000".equals(receiveVO.getResultCode())){
            APILSVO apilsvo = new APILSVO();
             apilsvo.setCorpId(coprVo.getCorpId());
            for(int i = 0; i < receiveVO.getList().size() ; i++  ){
                Integer prdtCnt = 0;
                Integer optCnt = 0;

                String imageUri = "";
                String startDate = "";
                String endDate = "";
                String expireType = "";
                String expireStartDate = "";
                String expireEndDate = "";
                String expireDay = "";

                apilsvo.setLsLinkPrdtNum(receiveVO.getList().get(i).getProduct_code());
                prdtCnt = apiLsDAO.countProductCode(apilsvo);

                for(int j = 0; j < receiveVO.getList().get(i).getImages().size(); j++){
                   if("all".equals(webParam.getType()) && "main".equals(receiveVO.getList().get(i).getImages().get(j).getImageType())){
                        imageUri = receiveVO.getList().get(i).getImages().get(j).getImageUri();
                        break;
                   }else if("single".equals(webParam.getType()) && "detail".equals(receiveVO.getList().get(i).getImages().get(j).getImageType())){
                        imageUri += receiveVO.getList().get(i).getImages().get(j).getImageUri()+"||";
                   }
                }
                for(int k = 0; k < receiveVO.getList().get(i).getOption().size(); k++){

                    //resultStr.getList().get(i).getOption().get(k).getName();

                    /** if옵션명*/
                    apilsvo.setLsLinkOptNum(receiveVO.getList().get(i).getOption().get(k).getOptionId());
                    apilsvo.setNmlAmt(receiveVO.getList().get(i).getOption().get(k).getNormalPrice());
                    apilsvo.setSaleAmt(receiveVO.getList().get(i).getOption().get(k).getSalePrice());
                    apilsvo.setOptNm(receiveVO.getList().get(i).getOption().get(k).getClassify());
                    apiLsDAO.updateOptCode(apilsvo);

                    /*startDate = receiveVO.getList().get(i).getOption().get(k).getStartDate();
                    endDate = receiveVO.getList().get(i).getOption().get(k).getEndDate();
                    expireType = receiveVO.getList().get(i).getOption().get(k).getExpireType();
                    expireStartDate = receiveVO.getList().get(i).getOption().get(k).getExpireStartDate();
                    expireEndDate = receiveVO.getList().get(i).getOption().get(k).getExpireEndDate();
                    expireDay = receiveVO.getList().get(i).getOption().get(k).getExpireDay();*/
                }

                /** 썸네일 수정 */
                if(prdtCnt > 0){
                    /*apilsvo.setPrdtNm(receiveVO.getList().get(i).getProduct_name());

                    startDate = startDate.replaceAll("-","");
                    startDate = startDate.substring(0,8);
                    endDate = endDate.replaceAll("-","");
                    endDate = endDate.substring(0,8);

                    apilsvo.setSaleStartDt(startDate);
                    apilsvo.setSaleEndDt(endDate);

                    if("date".equals(expireType)){
                        expireStartDate = expireStartDate.replaceAll("-","");
                        expireStartDate = expireStartDate.substring(0,8);
                        expireEndDate = expireEndDate.replaceAll("-","");
                        expireEndDate = expireEndDate.substring(0,8);

                        apilsvo.setExprStartDt(expireStartDate);
                        apilsvo.setExprEndDt(expireEndDate);
                        apilsvo.setExprDaynumYn("N");
                    }else if("day".equals(expireType)){
                        apilsvo.setExprDaynum(expireDay);
                        apilsvo.setExprDaynumYn("Y");
                    }*/
                    apilsvo.setApiImgThumb(imageUri);
                    apiLsDAO.updateProductCode(apilsvo);
                }
            }
        }

        updateDetailImg();
        return null;
    }

    void updateDetailImg(){
        List<APILSVO> apisVO = apiLsDAO.selectLsProductList();
        for(APILSVO tempVO : apisVO ){
            JSONObject jsonObject1 = new JSONObject();
            JSONObject jsonObject2 = new JSONObject();
            if("test".equals(CST_PLATFORM.trim())) {
                jsonObject2.put("agentNo",LS_AGENT_NO_DEV);
            }else{
                jsonObject2.put("agentNo",LS_AGENT_NO);
            }
            jsonObject2.put("type","single");
            jsonObject2.put("product_code",tempVO.getLsLinkPrdtNum());

            jsonObject1.put("data",jsonObject2);

            log.info("send product data to lsCompany : " + jsonObject1.toString());

            HttpHeaders headers = new HttpHeaders();
            Charset utf8 = Charset.forName("UTF-8");
            MediaType mediaType = new MediaType("application", "json", utf8);
            headers.setContentType(mediaType);
            if("test".equals(CST_PLATFORM.trim())) {
                headers.add("Authorization",LS_TOKEN_DEV);
            }else{
                headers.add("Authorization",LS_TOKEN);
            }

            HttpEntity param= new HttpEntity(jsonObject1.toString(), headers);
            RestTemplate restTemplate = new RestTemplate();
            APILSRECIEVEVO receiveVO;
            if("test".equals(CST_PLATFORM.trim())) {
                receiveVO = restTemplate.postForObject(LS_COMPANY_URL_DEV +"/product" ,param, APILSRECIEVEVO.class);
            }else{
                receiveVO = restTemplate.postForObject(LS_COMPANY_URL +"/product" ,param, APILSRECIEVEVO.class);
            }

            if("0000".equals(receiveVO.getResultCode())){
                APILSVO apilsvo = new APILSVO();
                for(int i = 0; i < receiveVO.getList().size() ; i++  ){
                    String imageUri = "";
                    int prdtCnt = 0;
                    apilsvo.setLsLinkPrdtNum(receiveVO.getList().get(i).getProduct_code());
                    prdtCnt = apiLsDAO.countProductCode(apilsvo);

                    if(prdtCnt > 0){
                        int k = 0;
                        for(int j = 0; j < receiveVO.getList().get(i).getImages().size(); j++){
                           if("detail".equals(receiveVO.getList().get(i).getImages().get(j).getImageType())){
                                imageUri += receiveVO.getList().get(i).getImages().get(j).getImageUri() + "||";
                                k++;
                           }
                        }
                        if(k > 0){
                            imageUri = imageUri.substring(0,imageUri.lastIndexOf("||"));
                            apilsvo.setApiImgDetail(imageUri);
                            apiLsDAO.updateProductDetailImg(apilsvo);
                        }
                    }
                }
            }
        }
    }

    /** LS컴퍼니 발권 */
	@Override
	public String requestOrderLsCompany(APILSVO apilsVO) throws ParseException {

		String resultYn = "N";
		List<APILSVO> resultList =  apiLsDAO.requestOrderLsCompany(apilsVO);

		if(resultList.size() < 1 ){
            resultYn = "Y";
        }else{
		    SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
            Calendar time = Calendar.getInstance();
            String curTime = format1.format(time.getTime());

            for(APILSVO resultVO : resultList){
                /** 발권 */
                JSONObject jsonObject1 = new JSONObject();
                JSONObject jsonObject2 = new JSONObject();
                JSONArray req_array = new JSONArray();

                /** 트랜잭션 ID*/
                JSONObject jsonObject3 = new JSONObject();

                if("test".equals(CST_PLATFORM.trim())) {
                    jsonObject2.put("agentNo", LS_AGENT_NO_DEV);
                }else{
                    jsonObject2.put("agentNo", LS_AGENT_NO);
                }
                jsonObject2.put("orderName", resultVO.getRsvNm());
                jsonObject2.put("orderHp", resultVO.getRsvTelnum());
                jsonObject2.put("name", resultVO.getUseNm());
                jsonObject2.put("hp", resultVO.getUseTelnum());
                jsonObject2.put("date", curTime);
                jsonObject2.put("orderNo", resultVO.getSpRsvNum());

                for(int i = 0; i < resultVO.getBuyNum(); i++) {
                    JSONObject data = new JSONObject();
                    data.put("transactionId", resultVO.getSpRsvNum() + "_" + i);
                    data.put("optionId", resultVO.getLsLinkOptNum());
                    data.put("price", resultVO.getSaleAmt());
                    req_array.add(data);

                    jsonObject3.put(resultVO.getSpRsvNum() + "_" + i,0);
                }
                jsonObject2.put("order", req_array);
                jsonObject1.put("data",jsonObject2);

                log.info("send issue data to lsCompany : " + jsonObject1.toString());

                /** send order data to lsCompany */
                HttpHeaders headers = new HttpHeaders();
                Charset utf8 = Charset.forName("UTF-8");
                MediaType mediaType = new MediaType("application", "json", utf8);
                headers.setContentType(mediaType);
                if("test".equals(CST_PLATFORM.trim())) {
                    headers.add("Authorization",LS_TOKEN_DEV);
                }else{
                    headers.add("Authorization",LS_TOKEN);
                }

                HttpEntity param= new HttpEntity(jsonObject1.toString(), headers);
                RestTemplate restTemplate = new RestTemplate();
                APILSRECIEVEVO receiveVO;
                if("test".equals(CST_PLATFORM.trim())) {
                    receiveVO = restTemplate.postForObject(LS_COMPANY_URL_DEV +"/issue" ,param, APILSRECIEVEVO.class);
                }else{
                    receiveVO = restTemplate.postForObject(LS_COMPANY_URL +"/issue" ,param, APILSRECIEVEVO.class);
                }

                if("0000".equals(receiveVO.getResultCode())){
                    APILSRECIEVEVO updateVO = new APILSRECIEVEVO();
                    updateVO.setOrderNo(receiveVO.getOrderNo());
                    updateVO.setBarcode(jsonObject3.toJSONString());
                    /** LS상품 바코드 업데이트*/
                    apiLsDAO.updatePinCodeLsCompany(updateVO);
                    resultYn = "Y";
                }else{
                    resultYn = "N";
                }

                /** 예약이 하나라도 잘못되면 이후로는 주문API 멈춤 */
                if("N".equals(resultYn)){
                    break;
                }
            }
        }
		return resultYn;
	}

	/** LS컴퍼니 예약상태확인 */
	@Override
	public LinkedHashMap<String, String> requestOrderChkLsCompany(APILSVO apilsVO){
        LinkedHashMap<String, String> receiveMap = new LinkedHashMap<String, String>();

        for(int i = 0; i < apilsVO.getBuyNum(); ++i ){
            JSONObject jsonObject1 = new JSONObject();
            JSONObject jsonObject2 = new JSONObject();

            if("test".equals(CST_PLATFORM.trim())) {
                jsonObject2.put("agentNo",LS_AGENT_NO_DEV);
            }else{
                jsonObject2.put("agentNo",LS_AGENT_NO);
            }
            jsonObject2.put("transactionId",apilsVO.getSpRsvNum()+"_" + i);
            jsonObject1.put("data",jsonObject2);

            log.info("send inquiry to lsCompany : " + jsonObject1.toString());

            HttpHeaders headers = new HttpHeaders();
            Charset utf8 = Charset.forName("UTF-8");
            MediaType mediaType = new MediaType("application", "json", utf8);
            headers.setContentType(mediaType);
            if("test".equals(CST_PLATFORM.trim())) {
                headers.add("Authorization",LS_TOKEN_DEV);
            }else{
                headers.add("Authorization",LS_TOKEN);
            }


            HttpEntity param= new HttpEntity(jsonObject1.toString(), headers);
            RestTemplate restTemplate = new RestTemplate();
            APILSRECIEVEVO receiveVO;
            if("test".equals(CST_PLATFORM.trim())) {
                receiveVO = restTemplate.postForObject(LS_COMPANY_URL_DEV +"/inquiry" ,param, APILSRECIEVEVO.class);
            }else{
                receiveVO = restTemplate.postForObject(LS_COMPANY_URL +"/inquiry" ,param, APILSRECIEVEVO.class);
            }

            receiveMap.put(apilsVO.getSpRsvNum()+"_" + i, receiveVO.getResultMessage());
        }
        return receiveMap;
	}

	/** LS컴퍼니 문자재발송 요청 */
	@Override
	public APILSRECIEVEVO requestSMSLsCompany(APILSVO apilsVO){
	    JSONObject jsonObject1 = new JSONObject();
        JSONObject jsonObject2 = new JSONObject();
        if("test".equals(CST_PLATFORM.trim())) {
            jsonObject2.put("agentNo",LS_AGENT_NO_DEV);
        }else{
            jsonObject2.put("agentNo",LS_AGENT_NO);
        }
        jsonObject2.put("orderNo",apilsVO.getSpRsvNum());
        jsonObject1.put("data",jsonObject2);
        log.info("send resend to lsCompany : " + jsonObject1.toString());

        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("UTF-8");
        MediaType mediaType = new MediaType("application", "json", utf8);
        headers.setContentType(mediaType);
        if("test".equals(CST_PLATFORM.trim())) {
            headers.add("Authorization",LS_TOKEN_DEV);
        }else{
            headers.add("Authorization",LS_TOKEN);
        }

        HttpEntity param= new HttpEntity(jsonObject1.toString(), headers);
        RestTemplate restTemplate = new RestTemplate();
        APILSRECIEVEVO receiveVO;
        if("test".equals(CST_PLATFORM.trim())) {
            receiveVO = restTemplate.postForObject(LS_COMPANY_URL_DEV +"/resend" ,param, APILSRECIEVEVO.class);
        }else{
            receiveVO = restTemplate.postForObject(LS_COMPANY_URL +"/resend" ,param, APILSRECIEVEVO.class);
        }
        return receiveVO;
	}

    /** LS컴퍼니 취소요청 */
	@Override
	public APILSRECIEVEVO requestCancelLsCompany(APILSVO apilsVO) throws ParseException {
	    JSONParser jsonParse = new JSONParser();
        JSONObject transactionObj = (JSONObject) jsonParse.parse(apilsVO.getTransactionId());
        JSONObject updatetransactionObj = new JSONObject();
        boolean resultStatus = false;
        for(int i = 0; i<apilsVO.getBuyNum(); i++){
            Long transactionValue =  (Long) transactionObj.get(apilsVO.getSpRsvNum()+"_"+i);
            if(transactionValue == 0){
                JSONObject jsonObject1 = new JSONObject();
                JSONObject jsonObject2 = new JSONObject();
                if("test".equals(CST_PLATFORM.trim())) {
                    jsonObject2.put("agentNo",LS_AGENT_NO_DEV);
                }else{
                    jsonObject2.put("agentNo",LS_AGENT_NO);
                }

                jsonObject2.put("transactionId",apilsVO.getSpRsvNum()+"_"+i);
                jsonObject1.put("data",jsonObject2);
                log.info("send cancel to lsCompany : " + jsonObject1.toString());

                HttpHeaders headers = new HttpHeaders();
                Charset utf8 = Charset.forName("UTF-8");
                MediaType mediaType = new MediaType("application", "json", utf8);
                headers.setContentType(mediaType);
                if("test".equals(CST_PLATFORM.trim())) {
                    headers.add("Authorization",LS_TOKEN_DEV);
                }else{
                    headers.add("Authorization",LS_TOKEN);
                }

                HttpEntity param= new HttpEntity(jsonObject1.toString(), headers);
                RestTemplate restTemplate = new RestTemplate();
                APILSRECIEVEVO receiveVO;
                if("test".equals(CST_PLATFORM.trim())) {
                    receiveVO = restTemplate.postForObject(LS_COMPANY_URL_DEV +"/cancel" ,param, APILSRECIEVEVO.class);
                }else{
                    receiveVO = restTemplate.postForObject(LS_COMPANY_URL +"/cancel" ,param, APILSRECIEVEVO.class);
                }

                /** 취소 */
                if("0000".equals(receiveVO.getResultCode())){
                    transactionValue = 2L;
                    resultStatus = true;
                    log.info(receiveVO.getResultCode());
                    log.info(receiveVO.getResultMessage());
                }else{
                    transactionValue = 1L;
                    log.info(receiveVO.getResultCode());
                    log.info(receiveVO.getResultMessage());
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
            apiLsDAO.updatePinCodeLsCompany(updateVO);
            finalVO.setResultCode("0000");
        }else{
            finalVO.setResultCode("9999");
        }
        return finalVO;
	}

	@Override
	public void updatePinCodeLsCompany(APILSRECIEVEVO apiLsRecieveVO){
	    apiLsDAO.updatePinCodeLsCompany(apiLsRecieveVO);
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
        return apiLsDAO.selectPinCodeLsCompanany(apiLsRecieveVO);
    }

	/** LS컴퍼니 상품연동 확인 */
	@Override
	public APILSRESULTVO requestUseableLsCompanyProduct(APILSVO apilsVO){
        RestTemplate restTemplate = new RestTemplate();
        /** 미디어타입이 text/html/ 일경우 */
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setSupportedMediaTypes(Collections.singletonList(MediaType.TEXT_HTML));
        restTemplate.getMessageConverters().add(converter);
        APILSRESULTVO resultVO = new APILSRESULTVO();
        /** 상품조회요청 */
        String sendApi = LS_COMPANY_URL + "/Product/" + apilsVO.getLsLinkPrdtNum() + "/" + apilsVO.getLsLinkOptNum() ;
        log.info("useable product request lsCompany : " + sendApi);
        try {
            resultVO = restTemplate.getForObject(sendApi, APILSRESULTVO.class);
        }catch (HttpClientErrorException e){
            /** 예외처리(외부요인) */
            resultVO.setCode(e.getStatusCode().toString());
            resultVO.setMessage("External Error");
        }
        log.info("useable product result lsCompany : "+ sendApi + " (code : " +  resultVO.getCode() + "),(message: " + resultVO.getMessage() + ")");
        return resultVO;
	}

	/** LS컴퍼니 문자재발송 요청 */
	@Override
	public Integer checkSMSLsCompany(APILSVO apilsVO){
        return apiLsDAO.checkSMSLsCompany(apilsVO);
	}
}
