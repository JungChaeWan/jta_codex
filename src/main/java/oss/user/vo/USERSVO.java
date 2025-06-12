package oss.user.vo;

import oss.cmm.vo.pageDefaultVO;

public class USERSVO extends pageDefaultVO{

	private String sUserNm;
	private String sTelNum;
	private String sEmail;
	private String authNum;
	private String sUserId;
	private String sOption;
	
	/** 관리자 조회 구분 */
	private String sCorpAdminDiv;

	private String sBadUserYn;
	private String sPartnerCd;

	/** 파트너(협력사) 포인트 코드*/
	private String partnerCode;

	public String getsUserNm() {
		return sUserNm;
	}
	public void setsUserNm(String sUserNm) {
		this.sUserNm = sUserNm;
	}
	public String getsTelNum() {
		return sTelNum;
	}
	public void setsTelNum(String sTelNum) {
		this.sTelNum = sTelNum;
	}
	public String getsEmail() {
		return sEmail;
	}
	public void setsEmail(String sEmail) {
		this.sEmail = sEmail;
	}
	public String getAuthNum() {
		return authNum;
	}
	public void setAuthNum(String authNum) {
		this.authNum = authNum;
	}
	public String getsUserId() {
		return sUserId;
	}
	public void setsUserId(String sUserId) {
		this.sUserId = sUserId;
	}
	public String getsCorpAdminDiv() {
		return sCorpAdminDiv;
	}
	public void setsCorpAdminDiv(String sCorpAdminDiv) {
		this.sCorpAdminDiv = sCorpAdminDiv;
	}
	public String getsBadUserYn() {
		return sBadUserYn;
	}
	public void setsBadUserYn(String sBadUserYn) {
		this.sBadUserYn = sBadUserYn;
	}
	public String getsPartnerCd() {
		return sPartnerCd;
	}
	public void setsPartnerCd(String sPartnerCd) {
		this.sPartnerCd = sPartnerCd;
	}

	public String getPartnerCode() {
		return partnerCode;
	}

	public void setPartnerCode(String partnerCode) {
		this.partnerCode = partnerCode;
	}
	public String getsOption() {
		return sOption;
	}
	public void setsOption(String sOption) {
		this.sOption = sOption;
	}
}
