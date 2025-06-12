package api.service.impl;

import api.service.APIGoodsFlowService;
import api.vo.APIGoodsFlowReceiveTraceResultItemsVO;
import api.vo.APIGoodsFlowReceiveTraceResultVO;
import api.vo.APIGoodsFlowSendTraceRequestVO;
import api.vo.APILSVO;
import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.rsv.service.impl.RsvDAO;
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
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Calendar;

@Service("apiGoodsFlowService")
public class APIGoodsFlowServiceImpl extends EgovAbstractServiceImpl implements APIGoodsFlowService {

    /** 배송완료처리 */
    @Resource(name = "rsvDAO")
    private RsvDAO rsvDAO;

    /** 굿스플로우 common API url*/
    public static final String GOODSFLOW_URL = "https://ws1.goodsflow.com/gws/api/Member/v3";

    Logger log = (Logger) LogManager.getLogger(this.getClass());
    String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");

    /** 굿스플로우 회원사코드(탐나오) */
    private String goodsFlowMemberCode(){
        String memberCode;
        if("test".equals(CST_PLATFORM.trim())) {
            memberCode = "visitjejutest";
        }else{
            memberCode = "visitjeju";
        }
        return memberCode;
    };

    /** 굿스플로우 APIKEY(탐나오) */
    private String goodsFlowApiKey(){
        String apiKey;
        if("test".equals(CST_PLATFORM.trim())) {
            apiKey = "87051836-d879-4cc2-807d-d4d719";
        }else{
            apiKey = "6cf411c6-d01f-4f03-8e91-224554";
        }
        return apiKey;
    };

    /** 배송추적요청 */
    @Override
    public String sendTraceRequest(APIGoodsFlowSendTraceRequestVO requestVO) throws ParseException {
        /** request param */
        SimpleDateFormat format1 = new SimpleDateFormat ( "yyyyMMddHHmmss");
        Calendar time = Calendar.getInstance();
        String curTime = format1.format(time.getTime());

        JSONObject jsonObject = new JSONObject();

        JSONObject data = new JSONObject();
        JSONArray itemsArray = new JSONArray();
        JSONObject items = new JSONObject();
        items.put("transUniqueCode", requestVO.getTransUniqueCode());
        items.put("fromName", requestVO.getFromName());
        items.put("toName", requestVO.getToName());
        items.put("logisticsCode", requestVO.getLogisticsCode());
        items.put("invoiceNo", requestVO.getInvoiceNo());
        items.put("dlvretType", "D");
        itemsArray.add(items);
        data.put("items",itemsArray);
        jsonObject.put("data",data);

        JSONArray requestDetailsArray = new JSONArray();
        JSONObject requestDetails = new JSONObject();
        requestDetails.put("orderNo", requestVO.getOrderNo());
        requestDetails.put("orderLine", 1); /** numeric */
        requestDetails.put("itemName", requestVO.getItemName());
        requestDetails.put("itemQty",  Integer.parseInt(requestVO.getItemQty())); /** numeric */
        requestDetails.put("orderDate", curTime);
        requestDetails.put("paymentDate", curTime);

        requestDetailsArray.add(requestDetails);
        items.put("requestDetails", requestDetailsArray);

        log.info("sendTraceRequest : " + jsonObject.toString());

        /** send api */
        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("UTF-8");
        MediaType mediaType = new MediaType("application", "json", utf8);
        headers.add("goodsFLOW-Api-Key", goodsFlowApiKey());
        headers.setContentType(mediaType);
        HttpEntity param = new HttpEntity(jsonObject.toString(), headers);
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
        String resultStr = restTemplate.postForObject(GOODSFLOW_URL +"/SendTraceRequest/" + goodsFlowMemberCode() ,param, String.class);
        /** response api */
        log.info("SendTraceRequest result : " + resultStr);
        JSONParser jsonParse = new JSONParser();
        JSONObject jsonObj = (JSONObject) jsonParse.parse(resultStr);
        String resultYn;
        if((Boolean) jsonObj.get("success") == true){
            log.info("resultYn : " + "Y");
            resultYn = "Y";
        }else{
            log.info("resultYn : " + "N");
            resultYn = "N";
        }
        return resultYn;
    };

    /** 배송결과수신 */
    @Override
    public void receiveTraceResult() {
        /** send api */
        HttpHeaders headers = new HttpHeaders();
        Charset utf8 = Charset.forName("utf-8");
        MediaType mediaType = new MediaType("application", "json", utf8);
        headers.add("goodsFLOW-Api-Key", goodsFlowApiKey());
        headers.setContentType(mediaType);
        HttpEntity param = new HttpEntity("", headers);
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(utf8));
        APIGoodsFlowReceiveTraceResultVO apiGoodsFlowReceiveTraceResultVO = restTemplate.postForObject(GOODSFLOW_URL +"/ReceiveTraceResult/" + goodsFlowMemberCode() ,param, APIGoodsFlowReceiveTraceResultVO.class);
        /** response api */
        if(apiGoodsFlowReceiveTraceResultVO.getData() != null && !"".equals(apiGoodsFlowReceiveTraceResultVO.getData())){
            JSONObject jsonObject = new JSONObject();
            JSONObject data = new JSONObject();
            JSONArray itemsArray = new JSONArray();
            for(APIGoodsFlowReceiveTraceResultItemsVO apiGoodsFlowReceiveTraceResultItemsVO : apiGoodsFlowReceiveTraceResultVO.getData().getItems()){
                /** 배달완료 상품코드변경*/
                if("70".equals(apiGoodsFlowReceiveTraceResultItemsVO.getDlvStatType())){
                    rsvDAO.updateSVDlvDone(apiGoodsFlowReceiveTraceResultItemsVO.getTransUniqueCode());
                }
                JSONObject items = new JSONObject();
                items.put("transUniqueCode", apiGoodsFlowReceiveTraceResultItemsVO.getTransUniqueCode());
                items.put("seq", apiGoodsFlowReceiveTraceResultItemsVO.getSeq());
                itemsArray.add(items);
            }
            data.put("items",itemsArray);
            jsonObject.put("data",data);
            receiveTraceResponse(jsonObject.toString(), headers);
        }
    }

    /** 배송결과수신 응답처리 */
    public void receiveTraceResponse(String responseStr, HttpHeaders headers){
        /** send api */
        log.info(" send order data to Hijeju : " + responseStr);
        HttpEntity param = new HttpEntity(responseStr, headers);
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("utf-8")));
        String resultreceiveTraceResponse = restTemplate.postForObject(GOODSFLOW_URL +"/SendTraceResultResponse/" + goodsFlowMemberCode() ,param, String.class);
        /** response api */
        log.info("SendTraceResultResponse result : " + resultreceiveTraceResponse);
        JSONParser jsonParse = new JSONParser();
        JSONObject jsonObj = null;
        try {
            jsonObj = (JSONObject) jsonParse.parse(resultreceiveTraceResponse);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        if((Boolean) jsonObj.get("success") == true){
            log.info("responseResultYn : " + "Y");
        }else{
            log.info("responseResultYn : " + "N");
        }
    }
}