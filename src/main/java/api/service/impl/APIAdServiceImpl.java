package api.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.ad.service.impl.AdDAO;
import mas.ad.vo.AD_CNTINFVO;
import mas.ad.vo.AD_PRDTINFVO;
import mas.rsv.service.impl.RsvDAO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import oss.corp.service.impl.CorpDAO;
import oss.corp.vo.CORPVO;
import web.order.service.impl.WebOrderDAO;
import web.order.vo.AD_RSVVO;
import web.order.vo.ORDERVO;
import web.order.vo.RSVVO;
import api.service.APIAdService;
import api.vo.ADSUKSOVO;

import common.Constant;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("apiAdService")
public class APIAdServiceImpl extends EgovAbstractServiceImpl implements APIAdService {

	@Resource(name = "adDAO")
	private AdDAO adDAO;
	
	@Resource(name = "corpDAO")
	private CorpDAO corpDAO;
	
	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;
	
	@Resource(name = "webOrderDAO")
	private WebOrderDAO webOrderDAO;
	
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	private String m_strOK = "OK!";

	@Override
	public String cancelResInfo(ADSUKSOVO adSukso) {
		
		if(adSukso.getYeyakNo() == null || adSukso.getYeyakNo().isEmpty()){
			log.info("cancelResInfo>>>> YeyakNo is Null ");
			return "ERR901";
		}
		
		String apiUrl = adSukso.getUrl() + "/sukso/api/cancelResInfo.do"
				+ "?authkey=" 		+ adSukso.getAuthkey()
				+ "&corpId=" 		+ adSukso.getCorpId()
				+ "&yeyakNo=" 		+ adSukso.getYeyakNo()
				+ "&cancelCharge=" 	+ adSukso.getCancelCharge()
				+ "&cancelAutoYn=" 	+ adSukso.getCancelAutoYn()
				+ "&CancelReslYn=" 	+ adSukso.getCancelReslYn();
		log.info("cancelResInfo>>>>url:"+apiUrl);
		
		//API호출
		RestTemplate restTemplate = new RestTemplate();
		@SuppressWarnings("unchecked")
		Map<String, Object> apiResult = restTemplate.getForObject(apiUrl, Map.class);
		
		//기본 오류 검사
		log.info("cancelResInfo>>>>res:" + apiResult.get("rtCode"));
		if(m_strOK.equals(apiResult.get("rtCode")) == false){
			//APIAdValidation.isWrongComm(resultMap, (String)apiResult.get("rtCode"), null);
				//return resultMap;
			log.info("Error:"+apiResult.get("rtCode"));
			return (String)apiResult.get("errorCode");
		}
		/*
		//DB에 저장
    	if(updateAllRoomDB(adSukso.getCorpId(), apiResult) == false){
    		log.info("Error:Not CorpID");
			return "ERR901";
    	}
    	*/

		return m_strOK;
	}
	
	@Override
	public String cancelResInfo(String adRsvNum, String CancelAutoYn, String CancelReslYn){
		
		String strApiErr="";
		
		AD_RSVVO adRsvVO = new AD_RSVVO();
     	log.info("cancelResInfo>>>>>>1:" + adRsvNum);
    	adRsvVO.setAdRsvNum(adRsvNum);
    	List<AD_RSVVO> adRsvList = rsvDAO.selectAdRsvListFromRsvNum(adRsvVO);
    	
     	if(adRsvList == null){//숙소 예약일때
     		return Constant.SUKSO_OK;
     	}
     	
     	log.info("cancelResInfo>>>>>>2:");
     	
     	for (AD_RSVVO adRsv : adRsvList) {//뭐 하나밖에 없을꺼지만....
     		
     		CORPVO corpVO = new CORPVO();
        	corpVO.setCorpId(adRsv.getCorpId());
        	CORPVO corpRes = corpDAO.selectCorpByCorpId(corpVO);
        	if( "Y".equals(corpRes.getCorpLinkYn()) ){
         	
	        	//연계번호검사
	        	AD_PRDTINFVO adPrdtInfoVO = new AD_PRDTINFVO();
	        	adPrdtInfoVO.setPrdtNum(adRsv.getPrdtNum());
	        	AD_PRDTINFVO adPrdtRes = adDAO.selectByAdPrdinf(adPrdtInfoVO);
	        	if( !(adPrdtRes.getMappingNum() == null || adPrdtRes.getMappingNum().isEmpty()) ){
	        		
	        		ADSUKSOVO adSukso = new ADSUKSOVO();
	            	adSukso.setUrl("http://"+Constant.SUKSO_DOMAIN);
	            	adSukso.setAuthkey(Constant.SUKSO_AUTH_KEY);
	            	adSukso.setCorpId(adRsv.getCorpId());
	            	adSukso.setYeyakNo(adRsv.getMappingRsvNum());
	            	adSukso.setCancelCharge(adRsv.getCmssAmt());
	            	adSukso.setCancelAutoYn(CancelAutoYn);
	            	adSukso.setCancelReslYn(CancelReslYn);
	            	
	            	log.info(">>>>>cancelResInfo 3:");
	            	
	            	strApiErr = cancelResInfo(adSukso);
	            	if( Constant.SUKSO_OK.equals(strApiErr)==false ){
	            		//오류 처리......
	            		log.info("cancelResInfo API Call Error");
	            	}
	        		
	        	}
        	}
			
		}

		return strApiErr;
	}

	@Override
	public String PayDoneResInfo(ADSUKSOVO adSukso) {
		
		if(adSukso.getYeyakNo() == null || adSukso.getYeyakNo().isEmpty() ){
			log.info("PayDoneResInfo>>>> YeyakNo is Null ");
			return "ERR901";
		}
		
		String apiUrl = adSukso.getUrl() + "/sukso/api/PayDoneResInfo.do"
				+ "?authkey=" 		+ adSukso.getAuthkey()
				+ "&corpId=" 		+ adSukso.getCorpId()
				+ "&yeyakNo=" 		+ adSukso.getYeyakNo();
		log.info("PayDoneResInfo>>>>url:"+apiUrl);
		
		//API호출
		RestTemplate restTemplate = new RestTemplate();
		@SuppressWarnings("unchecked")
		Map<String, Object> apiResult = restTemplate.getForObject(apiUrl, Map.class);
		
		//기본 오류 검사
		log.info("resRoom>>>>res:" + apiResult.get("rtCode"));
		if(m_strOK.equals(apiResult.get("rtCode")) == false){
			//APIAdValidation.isWrongComm(resultMap, (String)apiResult.get("rtCode"), null);
				//return resultMap;
			log.info("Error:"+apiResult.get("rtCode"));
			return (String)apiResult.get("errorCode");
		}
		

		return m_strOK;
	}
	
	@Override
	public	String PayDoneResInfo(RSVVO rsvInfo){
		
		String strApiErr="";
		
		AD_RSVVO adRsvVO = new AD_RSVVO();
     	log.info("PayDoneResInfo>>>>>>1:" + rsvInfo.getRsvNum());
    	adRsvVO.setRsvNum(rsvInfo.getRsvNum());
    	
    	List<AD_RSVVO> adRsvList = rsvDAO.selectAdRsvListFromRsvNum(adRsvVO);
    	
     	if(adRsvList == null){//숙소 예약일때
     		return Constant.SUKSO_OK;
     	}
     	
     	log.info("PayDoneResInfo>>>>>>2:");
     	
     	for (AD_RSVVO adRsv : adRsvList) {
     		
     		log.info("PayDoneResInfo>>>>>>2.1:"+adRsv.getCorpId());
     		
     		CORPVO corpVO = new CORPVO();
        	corpVO.setCorpId(adRsv.getCorpId());
        	CORPVO corpRes = corpDAO.selectCorpByCorpId(corpVO);
        	if( "Y".equals(corpRes.getCorpLinkYn()) ){
         	
	        	//연계번호검사
	        	AD_PRDTINFVO adPrdtInfoVO = new AD_PRDTINFVO();
	        	adPrdtInfoVO.setPrdtNum(adRsv.getPrdtNum());
	        	AD_PRDTINFVO adPrdtRes = adDAO.selectByAdPrdinf(adPrdtInfoVO);
	        	if( !(adPrdtRes.getMappingNum() == null || adPrdtRes.getMappingNum().isEmpty()) ){
	         		
		    		//숙소114로 API날리기
		    		log.info("PayDoneResInfo>>>>>>3:corpid:"+ adRsv.getCorpId() +" -prdtNum:" +adRsv.getPrdtNum() +" -MappingRsvNum:" + adRsv.getMappingRsvNum());
		
		         	ADSUKSOVO adSukso = new ADSUKSOVO();
		        	adSukso.setUrl("http://"+Constant.SUKSO_DOMAIN);
		        	adSukso.setAuthkey(Constant.SUKSO_AUTH_KEY);
		        	adSukso.setCorpId(adRsv.getCorpId());
		        	adSukso.setYeyakNo(adRsv.getMappingRsvNum());
		        	strApiErr = PayDoneResInfo(adSukso);
		        	if( Constant.SUKSO_OK.equals(strApiErr)==false ){
		        		//오류 처리......
		        		log.info("PayDoneResInfo API Call Error");
		        	}
	        	}
        	}
			
		}

		return strApiErr;
	}


	

	@Override
	public String requestCancelResInfo(ADSUKSOVO adSukso) {
		
		String apiUrl = adSukso.getUrl() + "/sukso/api/requestCancelResInfo.do"
				+ "?authkey=" 		+ adSukso.getAuthkey()
				+ "&corpId=" 		+ adSukso.getCorpId()
				+ "&yeyakNo=" 		+ adSukso.getYeyakNo();
		log.info("requestCancelResInfo>>>>url:"+apiUrl);
		
		//API호출
		RestTemplate restTemplate = new RestTemplate();
		@SuppressWarnings("unchecked")
		Map<String, Object> apiResult = restTemplate.getForObject(apiUrl, Map.class);
		
		//기본 오류 검사
		log.info("resRoom>>>>res:" + apiResult.get("rtCode"));
		if(m_strOK.equals(apiResult.get("rtCode")) == false){
			//APIAdValidation.isWrongComm(resultMap, (String)apiResult.get("rtCode"), null);
				//return resultMap;
			log.info("Error:"+apiResult.get("rtCode"));
			return (String)apiResult.get("errorCode");
		}
		

		return m_strOK;
	}
	
	@Override
	public String requestCancelResInfo(String adRsvNum){
		String strApiErr="";
		
		AD_RSVVO adRsvVO = new AD_RSVVO();
     	log.info("PayDoneResInfo>>>>>>1:" + adRsvNum);
    	adRsvVO.setAdRsvNum(adRsvNum);
    	
    	List<AD_RSVVO> adRsvList = rsvDAO.selectAdRsvListFromRsvNum(adRsvVO);
    	
     	if(adRsvList == null){//숙소 예약일때
     		return Constant.SUKSO_OK;
     	}
     	
     	log.info("PayDoneResInfo>>>>>>2:");
     	
     	for (AD_RSVVO adRsv : adRsvList) {
     		
     		CORPVO corpVO = new CORPVO();
        	corpVO.setCorpId(adRsv.getCorpId());
        	CORPVO corpRes = corpDAO.selectCorpByCorpId(corpVO);
        	if( "Y".equals(corpRes.getCorpLinkYn()) ){
         	
	        	//연계번호검사
	        	AD_PRDTINFVO adPrdtInfoVO = new AD_PRDTINFVO();
	        	adPrdtInfoVO.setPrdtNum(adRsv.getPrdtNum());
	        	AD_PRDTINFVO adPrdtRes = adDAO.selectByAdPrdinf(adPrdtInfoVO);
	        	if( !(adPrdtRes.getMappingNum() == null || adPrdtRes.getMappingNum().isEmpty()) ){
	        		
	        		log.info("requestCancelResInfo>>>>>>3:"+ adRsv.getCorpId() + "-" + adRsv.getMappingRsvNum());

		         	ADSUKSOVO adSukso = new ADSUKSOVO();
		        	adSukso.setUrl("http://"+Constant.SUKSO_DOMAIN);
		        	adSukso.setAuthkey(Constant.SUKSO_AUTH_KEY);
		        	adSukso.setCorpId(adRsv.getCorpId());
		        	adSukso.setYeyakNo(adRsv.getMappingRsvNum());
		        	strApiErr = requestCancelResInfo(adSukso);
		        	if( Constant.SUKSO_OK.equals(strApiErr)==false ){
			    		//오류 처리......
		        		log.info("requestCancelResInfo API Call Error");
			    	}
	        	}
        	}
     	}
     	return strApiErr;
	}
}
