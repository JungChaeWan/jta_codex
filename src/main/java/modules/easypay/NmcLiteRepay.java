package modules.easypay;

import org.json.simple.JSONObject;

import common.NmcConstants;
import common.NmcException;


public class NmcLiteRepay extends NmcLite {
	
	
	public NmcLiteRepay(String mer_key,String key, String iv) {		
		super(mer_key,key,iv,"Repay");		
	}

	
	
	protected JSONObject createEncryptedJsonData(){		
		JSONObject json = super.createEncryptedJsonData();
		
		json.put("mer_no", getReqValue("mer_no"));
		json.put("org_tid", getReqValue("org_tid"));
		json.put("moid", getReqValue("moid"));
		json.put("cancel_amt", getReqValue("cancel_amt"));
		json.put("remain_amt", getReqValue("remain_amt"));
		json.put("repay_msg", getReqValue("repay_msg"));
		json.put("app_req_dt", getReqValue("app_req_dt"));
		json.put("app_req_tm", getReqValue("app_req_tm"));
		json.put("tax_free_amt", getReqValue("tax_free_amt"));
		json.put("vat_amt", getReqValue("vat_amt"));
		
		
		log.debug(json.toJSONString());
		
		return json;
	}



	@Override
	protected String createHashData() throws Exception {
		String[] hashFields ={"mer_no", "org_tid",  "moid", "app_req_dt", "app_req_tm", "cancel_amt", "remain_amt"};
		StringBuilder sb = new StringBuilder();
		sb.append(merKey);
		for(String field : hashFields){
			sb.append( getReqValue(field));
		}			
		return makeHash(sb.toString());
	}
	
	
	
	protected  String getUri() {
		return  NmcConstants.NMC_REPAY;
	}



	@Override
	protected void verifyHashData() throws Exception {
		String[] hashFields ={"mer_no", "tid", "org_tid" , "moid", "cancel_amt", "remain_amt", "appr_dt", "appr_tm", "result_cd"};
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
