package oss.user.vo;

public class LOGINLOGVO {

	private String loginDttm;
	private String id;
	private String pcYn;
	private String ip;
	private String telnum;

	public void setLoginDttm(String loginDttm) {
		this.loginDttm = loginDttm;
	}
	public String getLoginDttm() {
		return loginDttm;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getId() {
		return id;
	}
	public void setPcYn(String pcYn) {
		this.pcYn = pcYn;
	}
	public String getPcYn() {
		return pcYn;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getTelnum() {
		return telnum;
	}
	public void setTelnum(String telnum) {
		this.telnum = telnum;
	}

}
