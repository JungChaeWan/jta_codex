package oss.marketing.vo;

public class SMSSENDVO {
	
	
	private String sendTels; //받을 사람 목록
	private String sendType; //SMS / MMS
	private String subject;
	private String msg;
	private String resSend;
	private String reqdate;	
	private String callbak;
	
	private String sendNames;
	
	public String getSendTels() {
		return sendTels;
	}
	public void setSendTels(String sendTels) {
		this.sendTels = sendTels;
	}
	public String getSendType() {
		return sendType;
	}
	public void setSendType(String sendType) {
		this.sendType = sendType;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getResSend() {
		return resSend;
	}
	public void setResSend(String resSend) {
		this.resSend = resSend;
	}
	public String getReqdate() {
		return reqdate;
	}
	public void setReqdate(String reqdate) {
		this.reqdate = reqdate;
	}
	public String getCallbak() {
		return callbak;
	}
	public void setCallbak(String callbak) {
		this.callbak = callbak;
	}
	public String getSendNames() {
		return sendNames;
	}
	public void setSendNames(String sendNames) {
		this.sendNames = sendNames;
	}
	
}
