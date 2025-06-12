package oss.otoinq.vo;

import oss.cmm.vo.pageDefaultVO;


public class OTOINQSVO extends pageDefaultVO{
    
	private String sCorpId;
	private String sPrdtNum;
	private String sPrintYn;
	
	private String corpCd;
	private String corpTel;
	
	private String sWriter;
	
	private String sKey;
	private String sKeyOpt;
	
	public String getsCorpId() {
		return sCorpId;
	}
	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}
	public String getsPrdtNum() {
		return sPrdtNum;
	}
	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}
	public String getsPrintYn() {
		return sPrintYn;
	}
	public void setsPrintYn(String sPrintYn) {
		this.sPrintYn = sPrintYn;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getCorpTel() {
		return corpTel;
	}
	public void setCorpTel(String corpTel) {
		this.corpTel = corpTel;
	}
	public String getsKey() {
		return sKey;
	}
	public void setsKey(String sKey) {
		this.sKey = sKey;
	}
	public String getsKeyOpt() {
		return sKeyOpt;
	}
	public void setsKeyOpt(String sKeyOpt) {
		this.sKeyOpt = sKeyOpt;
	}
	public String getsWriter() {
		return sWriter;
	}
	public void setsWriter(String sWriter) {
		this.sWriter = sWriter;
	}




}
