package egovframework.cmmn.vo;

public class SMSVO {

	/** ★ 메시지 고유번호 */
	private String trNum;
	
	/** ★ 메시지 전송할 시간 */
	private String trSenddate;
	
	/** 고객 발급번호(null) */
	private String trSerialnum;
	
	/** 고객 발급 SubID(null) */
	private String trId;
	
	/** ★ 발송상태(0:발송대기, 1:전송완료, 2:결과수신완료) */
	private String trSendstat;
	
	/** 발송결과수신값(결과코드표 참조) */
	private String trrsltstat;
	
	/** ★ 문자전송형태(0:일반메시지, 1:콜백 URL 메시지 */
	private String trMsgtype;
	
	/** ★ 수신할 번호 */
	private String trPhone;
	
	/** ★ 송신자 번호 */
	private String trCallback;
	
	/** 이동통신사로부터 결과통보 받은 시간 */
	private String trRsltdate;
	
	/** 프로그램 내부적사용? */
	private String trModified;
	
	/** ★ 전송메시지 */
	private String trMsg;
	
	/** 전송 완료 후 최종 이동통신사 정보(011,016,019,000) */
	private String trNet;
	
	/** 기타필드1(사용자사용필드 6번까지 존재) */
	private String trEtc1;
	
	/** 기타필드6() */
	private String trEtc6;
	
	/** 실제 모듈이 발송한시간 */
	private String trRealsenddate;
	
	/** 실제 발송한 세션ID */
	private String trRouteid;
	
	/**
	 * @return the trNum
	 */
	public String getTrNum() {
		return trNum;
	}
	/**
	 * @param trNum the trNum to set
	 */
	public void setTrNum(String trNum) {
		this.trNum = trNum;
	}
	/**
	 * @return the trSenddate
	 */
	public String getTrSenddate() {
		return trSenddate;
	}
	/**
	 * @param trSenddate the trSenddate to set
	 */
	public void setTrSenddate(String trSenddate) {
		this.trSenddate = trSenddate;
	}
	/**
	 * @return the trSerialnum
	 */
	public String getTrSerialnum() {
		return trSerialnum;
	}
	/**
	 * @param trSerialnum the trSerialnum to set
	 */
	public void setTrSerialnum(String trSerialnum) {
		this.trSerialnum = trSerialnum;
	}
	/**
	 * @return the trId
	 */
	public String getTrId() {
		return trId;
	}
	/**
	 * @param trId the trId to set
	 */
	public void setTrId(String trId) {
		this.trId = trId;
	}
	/**
	 * @return the trSendstat
	 */
	public String getTrSendstat() {
		return trSendstat;
	}
	/**
	 * @param trSendstat the trSendstat to set
	 */
	public void setTrSendstat(String trSendstat) {
		this.trSendstat = trSendstat;
	}
	/**
	 * @return the trrsltstat
	 */
	public String getTrrsltstat() {
		return trrsltstat;
	}
	/**
	 * @param trrsltstat the trrsltstat to set
	 */
	public void setTrrsltstat(String trrsltstat) {
		this.trrsltstat = trrsltstat;
	}
	/**
	 * @return the trMsgtype
	 */
	public String getTrMsgtype() {
		return trMsgtype;
	}
	/**
	 * @param trMsgtype the trMsgtype to set
	 */
	public void setTrMsgtype(String trMsgtype) {
		this.trMsgtype = trMsgtype;
	}
	/**
	 * @return the trPhone
	 */
	public String getTrPhone() {
		return trPhone;
	}
	/**
	 * @param trPhone the trPhone to set
	 */
	public void setTrPhone(String trPhone) {
		this.trPhone = trPhone;
	}
	/**
	 * @return the trCallback
	 */
	public String getTrCallback() {
		return trCallback;
	}
	/**
	 * @param trCallback the trCallback to set
	 */
	public void setTrCallback(String trCallback) {
		this.trCallback = trCallback;
	}
	/**
	 * @return the trRsltdate
	 */
	public String getTrRsltdate() {
		return trRsltdate;
	}
	/**
	 * @param trRsltdate the trRsltdate to set
	 */
	public void setTrRsltdate(String trRsltdate) {
		this.trRsltdate = trRsltdate;
	}
	/**
	 * @return the trModified
	 */
	public String getTrModified() {
		return trModified;
	}
	/**
	 * @param trModified the trModified to set
	 */
	public void setTrModified(String trModified) {
		this.trModified = trModified;
	}
	/**
	 * @return the trMsg
	 */
	public String getTrMsg() {
		return trMsg;
	}
	/**
	 * @param trMsg the trMsg to set
	 */
	public void setTrMsg(String trMsg) {
		this.trMsg = trMsg;
	}
	/**
	 * @return the trNet
	 */
	public String getTrNet() {
		return trNet;
	}
	/**
	 * @param trNet the trNet to set
	 */
	public void setTrNet(String trNet) {
		this.trNet = trNet;
	}
	/**
	 * @return the trEtc1
	 */
	public String getTrEtc1() {
		return trEtc1;
	}
	/**
	 * @param trEtc1 the trEtc1 to set
	 */
	public void setTrEtc1(String trEtc1) {
		this.trEtc1 = trEtc1;
	}
	/**
	 * @return the trRealsenddate
	 */
	public String getTrRealsenddate() {
		return trRealsenddate;
	}
	/**
	 * @param trRealsenddate the trRealsenddate to set
	 */
	public void setTrRealsenddate(String trRealsenddate) {
		this.trRealsenddate = trRealsenddate;
	}
	/**
	 * @return the trRouteid
	 */
	public String getTrRouteid() {
		return trRouteid;
	}
	/**
	 * @param trRouteid the trRouteid to set
	 */
	public void setTrRouteid(String trRouteid) {
		this.trRouteid = trRouteid;
	}
	public String getTrEtc6() {
		return trEtc6;
	}
	public void setTrEtc6(String trEtc6) {
		this.trEtc6 = trEtc6;
	}
	
	
}
