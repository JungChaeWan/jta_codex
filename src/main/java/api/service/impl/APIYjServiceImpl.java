package api.service.impl;

import api.service.APIYjService;
import api.vo.*;
import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import java.nio.charset.Charset;
import java.util.List;
import java.util.stream.Collectors;

@Service("apiYjService")
public class APIYjServiceImpl extends EgovAbstractServiceImpl implements APIYjService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	public static final String YJ_TOUR_URL = "https://t-bridge.io/";
	public static final String YJ_TOUR_URL_DEV = "http://tbridge.klkim.com/";
	public static final String YJ_TOUR_CH_CODE = "TAMNAO";
	public static final String YJ_TOUR_TOKEN = "e10adc3949ba59abbe56e057f20f883e";

	public static final String CST_PLATFORM  = EgovProperties.getOptionalProp("CST_PLATFORM");

	@Resource(name = "apiYjDAO")
	private APIYjDAO apiYjDAO;

    /** LS컴퍼니 발권 */
	@Override
	public String requestOrderYanolja(APILSVO apilsVO) throws ParseException {

		String resultYn = "N";
		List<APILSVO> resultList =  apiYjDAO.requestOrderYanolja(apilsVO);
        List<String> requestKey = resultList.stream().map(data->data.getLsLinkPrdtNum()).distinct().collect(Collectors.toList());

		if(resultList.size() < 1 ){
            resultYn = "Y";
        }else{
            int j = 0;
            JSONObject orderInfo = new JSONObject();
            JSONArray productInfo = new JSONArray();

            /** 발권 */
            for(APILSVO resultVO : resultList){
                if(j == 0) {
                    orderInfo.put("orderNumber", resultVO.getRsvNum());
                    orderInfo.put("ordererPhoneNumber", resultVO.getUseTelnum());
                    orderInfo.put("ordererName", resultVO.getRsvNm());
                    break;
                }
                j++;
            }

            for(String tempKey : requestKey ) {
                JSONArray itemArray = new JSONArray();
                JSONObject item = new JSONObject();
                for (APILSVO resultVO2 : resultList) {
                    if (resultVO2.getLsLinkPrdtNum().equals(tempKey)) {
                        JSONObject itemDetail = new JSONObject();
                        itemDetail.put("productOptionNumber", resultVO2.getLsLinkOptNum());
                        itemDetail.put("productOptionName", resultVO2.getOptNm());
                        itemDetail.put("count", resultVO2.getBuyNum());
                        itemDetail.put("amount", Integer.parseInt(resultVO2.getSaleAmt()) * resultVO2.getBuyNum());
                        itemArray.add(itemDetail);
                        if(resultVO2.getLeadLsLinkPrdtNum() == null || !resultVO2.getLsLinkPrdtNum().equals(resultVO2.getLeadLsLinkPrdtNum())){
                            item.put("productNumber", resultVO2.getLsLinkPrdtNum());
                            item.put("productDetails", itemArray);
                            productInfo.add(item);
                        }else{
                            continue;
                        }
                    }
                }
            }

            orderInfo.put("products", productInfo);

            log.info("send issue data to Yanolja : " + orderInfo.toString());

            /** send order data to lsCompany */
            HttpHeaders headers = new HttpHeaders();
            Charset utf8 = Charset.forName("UTF-8");
            MediaType mediaType = new MediaType("application", "json", utf8);
            headers.setContentType(mediaType);
            headers.add("Authorization",YJ_TOUR_TOKEN);

            HttpEntity param= new HttpEntity(orderInfo.toString(), headers);
            RestTemplate restTemplate = new RestTemplate();
            APIYJRECIEVEVO receiveVO;

            if("test".equals(CST_PLATFORM.trim())) {
                receiveVO = restTemplate.postForObject(YJ_TOUR_URL_DEV + YJ_TOUR_CH_CODE +"/order" ,param, APIYJRECIEVEVO.class);
            }else{
                receiveVO = restTemplate.postForObject(YJ_TOUR_URL + YJ_TOUR_CH_CODE +"/order" ,param, APIYJRECIEVEVO.class);
            }

            if("0".equals(receiveVO.getCode())){
                log.info("succeed request yanolja");
                log.info(receiveVO.getMessage());
                resultYn = "Y";
                for(APIYJDATAVO rData : receiveVO.getData().getPins()){
                    APITOURSVO apitourSVo = new APITOURSVO();
                    for(APILSVO resultVO : resultList){
                        if(resultVO.getLsLinkPrdtNum().equals(rData.getProductNumber()) && resultVO.getLsLinkOptNum().equals(rData.getProductOptionNumber())){
                            apitourSVo.setRsvNum(resultVO.getRsvNum());
                            apitourSVo.setSpRsvNum(resultVO.getSpRsvNum());
                            apitourSVo.setApiDiv("J");
                            apitourSVo.setPinCode(rData.getPinNumber());
                            apitourSVo.setRsvStatusCd("RS02");
                        }
                    }
                    apiYjDAO.updatePinCodeYj(apitourSVo);
                }
            }else{
                log.info("failed request yanolja");
                log.info(receiveVO.getMessage());
                resultYn = "N";
            }
        }
		return resultYn;
	}

	/** 야놀자 취소요청 */
	@Override
	public APILSRECIEVEVO requestCancelYj(APILSVO apilsVO) {

	    boolean result = false;

	    List<String> resultList = apiYjDAO.selectPinCodeYj(apilsVO);
	    APILSRECIEVEVO finalVO = new APILSRECIEVEVO();
	    String getMessage = "";

	    for(String tempResult : resultList){
            JSONObject requestJson = new JSONObject();
            JSONArray jsonArray = new JSONArray();
            requestJson.put("orderNumber", apilsVO.getRsvNum());

                JSONObject jsonObject2 = new JSONObject();
                jsonObject2.put("pinNumber",tempResult);
                jsonArray.add(jsonObject2);

            requestJson.put("pins",jsonArray);

            log.info("requestJson ::: "+requestJson);

            /** send order data to lsCompany */
            HttpHeaders headers = new HttpHeaders();
            Charset utf8 = Charset.forName("UTF-8");
            MediaType mediaType = new MediaType("application", "json", utf8);
            headers.setContentType(mediaType);
            headers.add("Authorization",YJ_TOUR_TOKEN);

            HttpEntity param= new HttpEntity(requestJson.toString(), headers);
            RestTemplate restTemplate = new RestTemplate();
            APIYJRECIEVEVO receiveVO;

            if("test".equals(CST_PLATFORM.trim())) {
                receiveVO = restTemplate.postForObject(YJ_TOUR_URL_DEV + YJ_TOUR_CH_CODE +"/cancel" ,param, APIYJRECIEVEVO.class);
            }else{
                receiveVO = restTemplate.postForObject(YJ_TOUR_URL + YJ_TOUR_CH_CODE +"/cancel" ,param, APIYJRECIEVEVO.class);
            }
            if("0".equals(receiveVO.getCode())){
                /** 관광지 API상태 업데이트*/
                apilsVO.setLsLinkOptPincode(tempResult);
                apiYjDAO.updateApiTourStatus(apilsVO);
                log.info("succeed");
                log.info(receiveVO.getMessage());
                getMessage = receiveVO.getMessage();
                result = true;
            }else{
                log.info("failed");
                log.info(receiveVO.getMessage());
                getMessage = receiveVO.getMessage();
                result = false;
                break;
            }
        }

	    if(result){
	        /** 탐나오 예약상태 업데이트*/
            apiYjDAO.updateSpRsvStatus(apilsVO);
            finalVO.setResultCode("0000");
            finalVO.setResultMessage(getMessage);
        }else{
	        finalVO.setResultCode("9999");
            finalVO.setResultMessage(getMessage);
        }

        return finalVO;
	}

	@Override
	public void requestUseStatusYj(APITOURSVO apitoursVo){
	    apiYjDAO.requestUseStatusYj(apitoursVo);
    };

	@Override
	public void requestUseUndoStatusYj(APITOURSVO apitoursVo){
	    apiYjDAO.requestUseUndoStatusYj(apitoursVo);
    };

	@Override
	public APITOURSVO selectRsvNum(APITOURSVO apitoursVo){
	    return apiYjDAO.selectRsvNum(apitoursVo);
    };
	@Override
	public void requestUseStatusRsv(APITOURSVO apitoursVo){
	    apiYjDAO.requestUseStatusRsv(apitoursVo);
    };

	@Override
	public void requestAddCnt(String spRsvNum){
	    apiYjDAO.requestAddCnt(spRsvNum);
    };

	@Override
	public void requestSubCnt(String spRsvNum){
	    apiYjDAO.requestSubCnt(spRsvNum);
    };

}
