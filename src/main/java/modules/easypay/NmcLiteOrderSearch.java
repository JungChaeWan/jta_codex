package modules.easypay;

import org.json.simple.JSONObject;

import common.NmcConstants;
import common.NmcException;


public class NmcLiteOrderSearch extends NmcLite {
	
	
	public NmcLiteOrderSearch(String mer_key,String key, String iv) {		
		super(mer_key,key,iv,"OrderSearch");		
	}

	
	
	protected JSONObject createEncryptedJsonData(){		
		JSONObject json = super.createEncryptedJsonData();
		
		json.put("mer_no", getReqValue("mer_no"));
		json.put("tid", getReqValue("tid"));
		json.put("order_req_dt", getReqValue("order_req_dt"));
		json.put("order_req_tm", getReqValue("order_req_tm"));
		
		log.debug(json.toJSONString());
		
		return json;
	}



	@Override
	protected String createHashData() throws Exception {
		String[] hashFields ={"mer_no", "tid",  "order_req_dt", "order_req_tm"};
		StringBuilder sb = new StringBuilder();
		sb.append(merKey);
		for(String field : hashFields){
			sb.append( getReqValue(field));
		}			
		return makeHash(sb.toString());
	}
	
	
	
	protected  String getUri() {
		return  NmcConstants.NMC_ORDER_SEARCH;
	}



	@Override
	protected void verifyHashData() throws Exception {
		String[] hashFields ={"mer_no", "tid",  "result_cd", "trans_cd"};
		StringBuilder sb = new StringBuilder();
		sb.append(merKey);
		for(String field : hashFields){
			sb.append( getResValue(field));
		}			
		String hashValue = makeHash(sb.toString());
		String dataHash = getResValue("data_hash");
	
		if(!hashValue.equals(dataHash)){			
			log.error("Verify HashData Failed! [" + hashValue +"][" + dataHash +"]");			
			throw new NmcException(NmcConstants.API_ERR_4004_CODE, NmcConstants.API_ERR_4004_MSG); 
		}	
	}
	

}
