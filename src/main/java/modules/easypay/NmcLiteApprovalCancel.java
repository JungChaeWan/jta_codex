package modules.easypay;

import org.json.simple.JSONObject;

import common.NmcConstants;
import common.NmcException;


public class NmcLiteApprovalCancel extends NmcLite {
	
	
	public NmcLiteApprovalCancel(String mer_key,String key, String iv) {		
		super(mer_key,key,iv,"ApprovalCancel");		
	}

	
	
	protected JSONObject createEncryptedJsonData(){		
		JSONObject json = super.createEncryptedJsonData();
		
		json.put("mer_no", getReqValue("mer_no"));
		json.put("tid", getReqValue("tid"));
		json.put("goods_amt", getReqValue("goods_amt"));
		json.put("cc_msg", getReqValue("cc_msg"));
		json.put("net_cancel", "0");
		json.put("appr_req_dt", getReqValue("appr_req_dt"));
		json.put("appr_req_tm", getReqValue("appr_req_tm"));
		
		return json;
	}



	@Override
	protected String createHashData() throws Exception {
		String[] hashFields ={"mer_no", "tid",  "appr_req_dt", "appr_req_tm", "goods_amt"};
		StringBuilder sb = new StringBuilder();
		sb.append(merKey);
		for(String field : hashFields){
			sb.append( getReqValue(field));
		}			
		return makeHash(sb.toString());
	}
	
	
	
	protected  String getUri() {
		return  NmcConstants.NMC_APPROVAL_CANCEL;
	}



	@Override
	protected void verifyHashData() throws Exception {
		String[] hashFields ={"mer_no", "tid",  "goods_amt",  "result_cd","appr_dt", "appr_tm"};
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
