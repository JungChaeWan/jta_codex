package egovframework.cmmn.vo;

public class MMSVO {

	/** ★ 메시지 고유번호 */
	private String msgkey;
	
	/** ★ 메시지 제목(40Byte) */
	private String subject;
	
	/** ★ 수신할 번호 */
	private String phone;
	
	/** ★ 송신자 번호 */
	private String callback;
	
	/** ★ 발송상태(0: 전송대기, 2: 송신완료, 3: 결과수신) */
	private String status;
	
	/** ★ 메시지 전송할 시간 */
	private String reqdate;
	
	/** 전송메시지 */
	private String msg;
	
	/** 전송파일 개수 */
	private String fileCnt;
	
	/** 전송파일1 위치 */
	private String filePath1;
	
	/** 전송파일2 위치 */
	private String filePath2;
	
	/** 전송파일3 위치 */
	private String filePath3;
	
	/** 전송파일4 위치 */
	private String filePath4;
	
	/** 전송파일5 위치 */
	private String filePath5;
	
	/** 사용자필드1 */
	private String etc1;
	
	/** 사용자필드2 */
	private String etc2;
	
	/** 사용자필드3 */
	private String etc3;
	
	/** 0:MMS, 1:MMSURL, 7:HTML */
	private String type;

	/** MMS 메시지 티베로 백업용 */

	/** 예약번호*/
	private String rsvNum;
	/** 상세예약번호*/
	private String prdtRsvNum;
	/** 예약자전화번호*/
	private String phone1;
	/** 사용자전화번호*/
	private String phone2;

	/**
	 * @return the msgkey
	 */
	public String getMsgkey() {
		return msgkey;
	}

	/**
	 * @param msgkey the msgkey to set
	 */
	public void setMsgkey(String msgkey) {
		this.msgkey = msgkey;
	}

	/**
	 * @return the subject
	 */
	public String getSubject() {
		return subject;
	}

	/**
	 * @param subject the subject to set
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}

	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * @param phone the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * @return the callback
	 */
	public String getCallback() {
		return callback;
	}

	/**
	 * @param callback the callback to set
	 */
	public void setCallback(String callback) {
		this.callback = callback;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the reqdate
	 */
	public String getReqdate() {
		return reqdate;
	}

	/**
	 * @param reqdate the reqdate to set
	 */
	public void setReqdate(String reqdate) {
		this.reqdate = reqdate;
	}

	/**
	 * @return the msg
	 */
	public String getMsg() {
		return msg;
	}

	/**
	 * @param msg the msg to set
	 */
	public void setMsg(String msg) {
		this.msg = msg;
	}

	/**
	 * @return the fileCnt
	 */
	public String getFileCnt() {
		return fileCnt;
	}

	/**
	 * @param fileCnt the fileCnt to set
	 */
	public void setFileCnt(String fileCnt) {
		this.fileCnt = fileCnt;
	}

	/**
	 * @return the filePath1
	 */
	public String getFilePath1() {
		return filePath1;
	}

	/**
	 * @param filePath1 the filePath1 to set
	 */
	public void setFilePath1(String filePath1) {
		this.filePath1 = filePath1;
	}

	/**
	 * @return the filePath2
	 */
	public String getFilePath2() {
		return filePath2;
	}

	/**
	 * @param filePath2 the filePath2 to set
	 */
	public void setFilePath2(String filePath2) {
		this.filePath2 = filePath2;
	}

	/**
	 * @return the filePath3
	 */
	public String getFilePath3() {
		return filePath3;
	}

	/**
	 * @param filePath3 the filePath3 to set
	 */
	public void setFilePath3(String filePath3) {
		this.filePath3 = filePath3;
	}

	/**
	 * @return the filePath4
	 */
	public String getFilePath4() {
		return filePath4;
	}

	/**
	 * @param filePath4 the filePath4 to set
	 */
	public void setFilePath4(String filePath4) {
		this.filePath4 = filePath4;
	}

	/**
	 * @return the filePath5
	 */
	public String getFilePath5() {
		return filePath5;
	}

	/**
	 * @param filePath5 the filePath5 to set
	 */
	public void setFilePath5(String filePath5) {
		this.filePath5 = filePath5;
	}

	/**
	 * @return the etc1
	 */
	public String getEtc1() {
		return etc1;
	}

	/**
	 * @param etc1 the etc1 to set
	 */
	public void setEtc1(String etc1) {
		this.etc1 = etc1;
	}

	/**
	 * @return the etc2
	 */
	public String getEtc2() {
		return etc2;
	}

	/**
	 * @param etc2 the etc2 to set
	 */
	public void setEtc2(String etc2) {
		this.etc2 = etc2;
	}

	/**
	 * @return the etc3
	 */
	public String getEtc3() {
		return etc3;
	}

	/**
	 * @param etc3 the etc3 to set
	 */
	public void setEtc3(String etc3) {
		this.etc3 = etc3;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRsvNum() {
		return rsvNum;
	}

	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}

	public String getPrdtRsvNum() {
		return prdtRsvNum;
	}

	public void setPrdtRsvNum(String prdtRsvNum) {
		this.prdtRsvNum = prdtRsvNum;
	}

	public String getPhone1() {

		return phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}


}
