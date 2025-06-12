package mw.app.vo;

public class DEVICEINFVO {

	/** 디바이스 번호  */
	private String deviceNum;
	/** 등록 아이디  */
	private String regId;
	/** 전화 번호  */
	private String telNum;
	/** 디바이스 구분  */
	private String deviceDiv;
	/** 디바이스 버전  */
	private String deviceVer;
	/** 푸시 여부  */
	private String pushYn;
	/** 최초 등록 일시  */
	private String frstRegDttm;
	/** 최종 수정 일시  */
	private String lastModDttm;
	
	public String getDeviceNum() {
		return deviceNum;
	}
	public void setDeviceNum(String deviceNum) {
		this.deviceNum = deviceNum;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getTelNum() {
		return telNum;
	}
	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}
	public String getDeviceDiv() {
		return deviceDiv;
	}
	public void setDeviceDiv(String deviceDiv) {
		this.deviceDiv = deviceDiv;
	}
	public String getDeviceVer() {
		return deviceVer;
	}
	public void setDeviceVer(String deviceVer) {
		this.deviceVer = deviceVer;
	}
	public String getPushYn() {
		return pushYn;
	}
	public void setPushYn(String pushYn) {
		this.pushYn = pushYn;
	}
	public String getFrstRegDttm() {
		return frstRegDttm;
	}
	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}
	public String getLastModDttm() {
		return lastModDttm;
	}
	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}


}
