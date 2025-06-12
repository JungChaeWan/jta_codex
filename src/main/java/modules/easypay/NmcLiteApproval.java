package modules.easypay;

import org.json.simple.JSONObject;

import common.NmcConstants;
import common.NmcException;


public class NmcLiteApproval extends NmcLite {
	
	
	public NmcLiteApproval(String mer_key,String key, String iv) {		
		super(mer_key,key,iv,"Approval");		
	}

	
	
	protected JSONObject createEncryptedJsonData(){		
		JSONObject json = super.createEncryptedJsonData();
		
		json.put("mer_no", getReqValue("mer_no"));
		json.put("tid", getReqValue("tid"));
		json.put("moid", getReqValue("moid"));
		json.put("goods_amt", getReqValue("goods_amt"));
		json.put("cust_id", getReqValue("cust_id"));
		json.put("auth_token", getReqValue("auth_token"));
		json.put("appr_req_dt", getReqValue("appr_req_dt"));
		json.put("appr_req_tm", getReqValue("appr_req_tm"));
		
		return json;
	}



	@Override
	protected String createHashData() throws Exception {
		String[] hashFields ={"mer_no", "tid",  "appr_req_dt", "appr_req_tm", "goods_amt", "auth_token"};
		StringBuilder sb = new StringBuilder();
		sb.append(merKey);
		for(String field : hashFields){
			sb.append( getReqValue(field));
		}			
		return makeHash(sb.toString());
	}
	
	
	
	protected  String getUri() {
		return  NmcConstants.NMC_APPROVAL;
	}



	@Override
	protected void verifyHashData() throws Exception {
		String[] hashFields ={"mer_no", "tid",  "appr_dt", "appr_tm", "goods_amt", "result_cd", "appr_no"};
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
