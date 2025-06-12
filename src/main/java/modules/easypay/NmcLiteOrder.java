package modules.easypay;

import java.util.ArrayList;

import org.json.simple.JSONObject;

import common.NmcConstants;
import common.NmcException;


public class NmcLiteOrder extends modules.easypay.NmcLite {
	
	
	public NmcLiteOrder(String mer_key,String key, String iv) {		
		super(mer_key,key,iv,"Order");		
	}

	
	
	protected JSONObject createEncryptedJsonData(){		
		JSONObject json = super.createEncryptedJsonData();
		
		json.put("mer_no", getReqValue("mer_no"));
		json.put("moid", getReqValue("moid"));
		json.put("card_goods_id", getReqValue("card_goods_id"));
		json.put("goods_amt", getReqValue("goods_amt"));
		json.put("goods_name", getReqValue("goods_name"));
		json.put("goods_code", getReqValue("goods_code"));
		json.put("cust_id", getReqValue("cust_id"));
		json.put("order_req_dt", getReqValue("order_req_dt"));
		json.put("order_req_tm", getReqValue("order_req_tm"));
		json.put("p_callback_url", getReqValue("p_callback_url"));
		json.put("tax_free_amt", getReqValue("tax_free_amt"));
		json.put("vat_amt", getReqValue("vat_amt"));
		
		log.debug(json.toJSONString());
		
		return json;
	}



	@Override
	protected String createHashData() throws Exception {
		String[] hashFields ={"mer_no", "goods_amt",  "order_req_dt", "order_req_tm"};
		StringBuilder sb = new StringBuilder();
		sb.append(merKey);
		for(String field : hashFields){
			sb.append( getReqValue(field));
		}			
		return makeHash(sb.toString());
	}
	
	
	
	protected  String getUri() {
		return  common.NmcConstants.NMC_ORDER;
	}



	@Override
	protected void verifyHashData() throws Exception {
		String[] hashFields ={"tid", "hash_tid",  "order_dt", "order_tm", "result_cd"};
		StringBuilder sb = new StringBuilder();
		sb.append(merKey);
		for(String field : hashFields){
			sb.append( getResValue(field));
		}			
		String hashValue = makeHash(sb.toString());
		String dataHash = getResValue("data_hash");
	
		if(!hashValue.equals(dataHash)){			
			log.error("Verify HashData Failed! [" + hashValue +"][" + dataHash +"]");			
			throw new common.NmcException(common.NmcConstants.API_ERR_4004_CODE, common.NmcConstants.API_ERR_4004_MSG);
		}	
	}
	

}
