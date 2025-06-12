package oss.coupon.vo;

import oss.cmm.vo.pageDefaultVO;

public class CPSVO extends pageDefaultVO{
	private String corpId;
	private String userId;
	private String sPrdtNum;
	private String sFromDt;
	private String sToDt;
	private String cpDiv;

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getsPrdtNum() {
		return sPrdtNum;
	}

	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}

	public String getsFromDt() {
		return sFromDt;
	}

	public void setsFromDt(String sFromDt) {
		this.sFromDt = sFromDt;
	}

	public String getsToDt() {
		return sToDt;
	}

	public void setsToDt(String sToDt) {
		this.sToDt = sToDt;
	}

	public String getCpDiv() {
		return cpDiv;
	}

	public void setCpDiv(String cpDiv) {
		this.cpDiv = cpDiv;
	}
}
