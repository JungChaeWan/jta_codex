package oss.cmm.vo;

public class CM_CONFHISTVO {
	private String linkNum ; 
	private String histNum ; 
	private String tradeStatus ; 
	private String msg ; 
	private String regDttm ; 
	private String regId ; 
	private String regIp;
	
	private String prdtCd;
	private String corpId;
	private String corpNm;
	private String prdtNm;
	
	private String superbSvYn;
	private String jqYn;		// JQ인증 여부JQ인증 여부
	private String msgSendYn;	// 전송여부
	private String sixCertiCate; //6차산업인증 카테고리
	
	public String getLinkNum() {
		return linkNum;
	}
	public void setLinkNum(String linkNum) {
		this.linkNum = linkNum;
	}
	public String getHistNum() {
		return histNum;
	}
	public void setHistNum(String histNum) {
		this.histNum = histNum;
	}
	public String getTradeStatus() {
		return tradeStatus;
	}
	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegIp() {
		return regIp;
	}
	public void setRegIp(String regIp) {
		this.regIp = regIp;
	}
	public String getPrdtCd() {
		return prdtCd;
	}
	public void setPrdtCd(String prdtCd) {
		this.prdtCd = prdtCd;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getSuperbSvYn() {
		return superbSvYn;
	}
	public void setSuperbSvYn(String superbSvYn) {
		this.superbSvYn = superbSvYn;
	}
	public String getJqYn() {
		return jqYn;
	}
	public void setJqYn(String jqYn) {
		this.jqYn = jqYn;
	}

	public String getMsgSendYn() {
		return msgSendYn;
	}

	public void setMsgSendYn(String msgSendYn) {
		this.msgSendYn = msgSendYn;
	}

	public String getSixCertiCate() {
		return sixCertiCate;
	}

	public void setSixCertiCate(String sixCertiCate) {
		this.sixCertiCate = sixCertiCate;
	}
}
