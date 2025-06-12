package modules.easypay;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.SocketTimeoutException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import org.apache.commons.httpclient.ConnectTimeoutException;
import org.apache.commons.httpclient.ConnectionPoolTimeoutException;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.HttpVersion;
import org.apache.commons.httpclient.NoHttpResponseException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.apache.log4j.MDC;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;


import common.NmcConstants;
import common.NmcException;
import modules.utils.StringEncrypter;
import modules.utils.UserRand;

public abstract class NmcLite {
	
	protected ArrayList<modules.easypay.QueryString>reqList;
	protected ArrayList<modules.easypay.QueryString>resList;

	protected String merKey;
	protected String symmKey;
	protected String symmIv;
	
	protected StringEncrypter stringEncrypter;
	protected String actionType = "";
	
	protected boolean  testServer= false;
	protected boolean  isTrNetCancel= false;

	protected Logger log = Logger.getLogger(NmcLite.class);

	
	public NmcLite(String mer_key,String key, String iv, String actionType) {
		
		MDC.put("TID", System.currentTimeMillis() +"");
		
		reqList = new ArrayList<modules.easypay.QueryString>();
		resList = new ArrayList<modules.easypay.QueryString>();
		
		merKey = mer_key;
		symmKey = key;
		symmIv = iv;
		this.actionType = actionType;
	}
	
	public void setTestServer(boolean dev){
		testServer = dev;
	}
	
	private void setError(String result_code, String result_msg){
		setResField("result_code", result_code);
		setResField("result_msg", result_msg);
	}
	

	public void startAction() {
		
		StopWatch stopWatch = new StopWatch();
		log.info(NmcConstants.NMC_LIB_VERSION);		
		try {
			doProcess();	
		}catch(Exception e){
			log.error(" doProcess Error",e);
		}
		finally{						
			if(isTrNetCancel){
				log.info("Start NetCancel!");
				startTrNetCancel();
			}			
			log.info("END [" + actionType +"][" + getResValue("result_code") +"][" +getResValue("result_msg") +"][" +stopWatch.getTotalTimeString()+"]");
		}		
	}


	private void doProcess() throws Exception{
		
		stringEncrypter = new StringEncrypter(symmKey, symmIv);
				
		String msg = ""; 
		try  {
			msg = makeMessage();
			log.info("Make Msg Ok!");											
		}catch(NmcException e){
			setError(e.getCode(), e.getMsg());			
			log.error("Make Msg Faild",e);		
			throw e;
		}
		catch(Exception e){
			setError(NmcConstants.API_ERR_4001_CODE, NmcConstants.API_ERR_4001_MSG);
			log.error("Make Msg Faild",e);
			throw e;
		}
		
		String responeBody = "";
		try  {
			responeBody = sendMessage( msg );						
		}catch(NmcException e){			
			if( NmcConstants.API_ERR_5002_CODE.equals(e.getCode())
				||  NmcConstants.API_ERR_5003_CODE.equals(e.getCode())
				||  NmcConstants.API_ERR_5004_CODE.equals(e.getCode())){
				setTrNetCancel(true);
			}			
			log.error("Server Http Send & Recive Faild(NmcException)",e);			
			setError(e.getCode(), e.getMsg());						
			throw e;			
		}
		
		
		try  {
			parseResult( responeBody );			
			log.info("Parse Result OK!");							
		}catch(NmcException e){	
			setTrNetCancel(true);
			setError(e.getCode(), e.getMsg());						
			throw e;		
		}
		catch(Exception e){
			setTrNetCancel(true);
			log.error("Parse Result Failed!",e);							
			throw e;
		}		
		
		try  {
			verifyHashData();
			log.info("Verify HashData OK!");							
		}catch(NmcException e){	
			setTrNetCancel(true);
			setError(e.getCode(), e.getMsg());						
			throw e;		
		}catch(Exception e){
			log.error("Verify HashData Failed!",e);							
			setTrNetCancel(true);
			throw e;
		}		

		
	}
	
	public String sendMessage(String message) throws Exception{
		
		int timout = NmcConstants.SERVER_TIMEOUT_MILL;

		String url = getServiceURL();		
		log.info("Server Url:[" + url +"], Timeout:[" + timout +"]");
				
		HttpClient client = new HttpClient();
		client.getHttpConnectionManager().getParams().setParameter(HttpMethodParams.PROTOCOL_VERSION, HttpVersion.HTTP_1_0);
		client.getHttpConnectionManager().getParams().setConnectionTimeout(timout);
		client.getHttpConnectionManager().getParams().setSoTimeout(timout);
	
		PostMethod post = new PostMethod(url);

		try {
			
			post.addRequestHeader("Content-Type", "application/json");
			post.setRequestEntity(new StringRequestEntity(message));		
			log.info("executeMethod");
			int returnCode = client.executeMethod(post);			
			if(returnCode != HttpStatus.SC_OK){
				log.error("Remote Server Receive Failed(Internal Error Http Status Code:[" + returnCode+"])");
				throw new NmcException(NmcConstants.API_ERR_5002_CODE, NmcConstants.API_ERR_5002_MSG);							
			}			
			log.info("Recv Msg OK!");		
			String body = post.getResponseBodyAsString();				
			return body;			
		}catch(ConnectTimeoutException ex){
			log.error("Remote Server Conenction Failed(ConnectTimeoutException)",ex);
			throw new NmcException(NmcConstants.API_ERR_5001_CODE, NmcConstants.API_ERR_5001_MSG);							
		}catch(SocketTimeoutException ex){
			log.error("Remote Server Receive Failed(SocketTimeoutException)",ex);
			throw new NmcException(NmcConstants.API_ERR_5003_CODE, NmcConstants.API_ERR_5003_MSG);							
		}catch(NmcException ex){
			throw ex;
		}
		catch(Exception ex){
			log.error("Remote Server Error(Exception)",ex);
			throw new NmcException(NmcConstants.API_ERR_5004_CODE, NmcConstants.API_ERR_5004_MSG);
		}
		finally{
			post.releaseConnection();
		}
	
	}
	
	protected String  makeMessage() throws Exception{
		
		JSONObject plainObject = new JSONObject();
		JSONObject encJson = createEncryptedJsonData();
		
		String encryptedData = "";
		try {
			 encryptedData =  encrypt (encJson.toString() );	
		}catch(Exception e){
			log.error("Encrypt Failed!" ,e);
			throw new NmcException(NmcConstants.API_ERR_4002_CODE, NmcConstants.API_ERR_4002_MSG);
		}
		
		String hashedData  = "";
		try {
		 hashedData = createHashData();
		}catch(Exception e){
			log.error("Make Hash Failed!" ,e);
			throw new NmcException(NmcConstants.API_ERR_4003_CODE, NmcConstants.API_ERR_4003_MSG);
		}
		
		plainObject.put("trace_no", getReqValue("trace_no"));
		plainObject.put("mer_no", getReqValue("mer_no"));
		plainObject.put("data_hash", hashedData);
		plainObject.put("data", encryptedData);
	
		return plainObject.toString();
	}
	
	protected void parseResult(String responeMsg) throws Exception{
		
		
		try  {
			JSONObject resultPlainObject =  (JSONObject)JSONValue.parse(responeMsg);
			String result_data = (String)resultPlainObject.get("data");
			if (result_data != null) {
				String decryptedJsonString = stringEncrypter.decrypt(result_data);
				JSONObject resultDecJsonObject = (JSONObject)JSONValue.parse(decryptedJsonString);						
				parseJsonOjbect ( resultDecJsonObject );
			}
			
			String data_hash = (String)resultPlainObject.get("data_hash");
			
			setResField("data_hash", data_hash);
		}catch(Exception e){
			log.error("Parse Result Failed!" ,e);
			throw new NmcException(NmcConstants.API_ERR_6001_CODE, NmcConstants.API_ERR_6001_MSG);
		}
		
	}
	
	protected void parseJsonOjbect(JSONObject jsonObj){		
		for (Object key : jsonObj.keySet()){				
			String keyStr = (String)key;
			Object keyValue = jsonObj.get(keyStr); 					
			if(keyValue instanceof JSONObject){
				parseJsonOjbect((JSONObject)keyValue);
			}			
			else {
				setResField(keyStr, keyValue +"");
			}			
		}		
	}
	
	
	
	protected JSONObject createEncryptedJsonData(){
		
		JSONObject json = new JSONObject();
		return json;
	}
	
	
	protected JSONObject createOrderEncryptedJsonData() throws UnsupportedEncodingException{
		
		JSONObject json = new JSONObject();
		
		
		json.put("event_id", getReqValue("event_id"));
		json.put("tr_id", getReqValue("tr_id"));
		json.put("member_id", getReqValue("member_id"));
		json.put("goods_id", getReqValue("goods_id"));		
		json.put("order_mobile", getReqValue("order_mobile"));
		json.put("receivermobile", getReqValue("receivermobile"));
		return json;
	}
	
	
	
	protected abstract String createHashData() throws Exception;
	protected abstract void verifyHashData() throws Exception;

	protected abstract String getUri();

	
	public void setReqField(String name, String value){
		
		if(value == null) value= "";

		modules.easypay.QueryString qs = getReqQueryString(name);
		
		if(qs != null) qs.setValue(value);
		
		qs  = new modules.easypay.QueryString(name,value);
		reqList.add(qs);
	}
	

	protected modules.easypay.QueryString getReqQueryString(String name){
		
		for(modules.easypay.QueryString qs : reqList){
			if(name.equals(qs.getName()))
				return qs;	
		}
		
		return null;
	}

	protected String getReqValue(String name){
		
		for(modules.easypay.QueryString qs : reqList){
			if(name.equals(qs.getName()))
				return qs.getValue();			
		}
		
		return "";
	}
	
	
	public void setResField(String name, String value){
		
		if(value == null) value= "";
		
		modules.easypay.QueryString qs = getResQueryString(name);
		
		if(qs != null) qs.setValue(value);
		
		qs  = new modules.easypay.QueryString(name,value);
		resList.add(qs);
	}

	protected modules.easypay.QueryString getResQueryString(String name){
		
		for(modules.easypay.QueryString qs : resList){
			if(name.equals(qs.getName()))
				return qs;	
		}
		
		return null;
	}

	public String getResValue(String name){
		
		for(modules.easypay.QueryString qs : resList){
			if(name.equals(qs.getName()))
				return qs.getValue();			
		}
		
		return "";
	}
	
	
	protected String encrypt(String plainText) throws Exception{
		return stringEncrypter.encrypt(plainText);
	}
	
	protected String makeHash(String plainText) throws Exception{
		return stringEncrypter.sha256(plainText);
	}
	
	

	private String getServiceURL(){				
		if(testServer){
			return NmcConstants.TEST_NMC_SERVER_DOMAIN + getUri();
		}else {
			return NmcConstants.NMC_SERVER_DOMAIN + getUri();
		}
	}
	
	private void setTrNetCancel(boolean trNetCancel){
		isTrNetCancel = trNetCancel;
	}
	
	
	private void startTrNetCancel(){
		
		if("Approval".equals(actionType)){		
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat tf = new SimpleDateFormat("HHmmss");	
			SimpleDateFormat trdf = new SimpleDateFormat("yyyyMMddHHmmssSS");

			Date today = new Date();			
			String tr_id = trdf.format(today);
			
			modules.easypay.NmcLiteApprovalCancel nmcLite = new modules.easypay.NmcLiteApprovalCancel(merKey, symmKey, symmIv);
			nmcLite.setTestServer(testServer);
			
			nmcLite.setReqField("trace_no", System.currentTimeMillis() + "");		//요청 번호 (단순 로그 추적용)
			nmcLite.setReqField("mer_no", getReqValue("mer_no"));	//가맹점번호
			nmcLite.setReqField("tid", getReqValue("tid"));		//취소 요청 TID
			nmcLite.setReqField("goods_amt", getReqValue("goods_amt")); //취소 금액(전체금액)
		    nmcLite.setReqField("cc_msg", ""); //취소사유
		    nmcLite.setReqField("net_cancel", "1"); //취소타입 0:일반 1:망취소
			nmcLite.setReqField("appr_req_dt", df.format(today));								//요청일자
			nmcLite.setReqField("appr_req_tm", tf.format(today));								//요청시간
	
			nmcLite.startAction();
			
			String result_code = nmcLite.getResValue("result_code"); 			//응답코드 '0000' 경우 만 성공
			String result_msg = nmcLite.getResValue("result_msg");				//응답메시지 
			
			log.info("END NetCancelResult[" + actionType +"][" + result_code +"][" +result_msg+"]");
		}
		
	}
	

}
