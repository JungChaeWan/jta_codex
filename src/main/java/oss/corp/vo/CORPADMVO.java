package oss.corp.vo;

public class CORPADMVO extends CORPADMSVO{

	/** 업체 아이디 */
	private String corpId;
	/** 사용자 아이디 */
	private String userId;
	/** 사용자 명 */
	private String userNm;
	
	private String email;
	
	private String telNum;
	
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
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTelNum() {
		return telNum;
	}
	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}

	

}
