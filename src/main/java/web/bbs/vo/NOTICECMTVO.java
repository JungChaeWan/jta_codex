package web.bbs.vo;

public class NOTICECMTVO extends NOTICECMTSVO{

	private String cmtSn;
	private String bbsNum;
	private String noticeNum;
	private String cmtContents;
	private String regDttm;
	private String regId;
	private String gpa;
	private String email;
	private String admCmtYn;
	
	private String cmtContentsOrg;
	
	public String getCmtSn() {
		return cmtSn;
	}
	public void setCmtSn(String cmtSn) {
		this.cmtSn = cmtSn;
	}
	public String getBbsNum() {
		return bbsNum;
	}
	public void setBbsNum(String bbsNum) {
		this.bbsNum = bbsNum;
	}
	public String getNoticeNum() {
		return noticeNum;
	}
	public void setNoticeNum(String noticeNum) {
		this.noticeNum = noticeNum;
	}
	public String getCmtContents() {
		return cmtContents;
	}
	public void setCmtContents(String cmtContents) {
		this.cmtContents = cmtContents;
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
	public String getGpa() {
		return gpa;
	}
	public void setGpa(String gpa) {
		this.gpa = gpa;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCmtContentsOrg() {
		return cmtContentsOrg;
	}
	public void setCmtContentsOrg(String cmtContentsOrg) {
		this.cmtContentsOrg = cmtContentsOrg;
	}
	public String getAdmCmtYn() {
		return admCmtYn;
	}
	public void setAdmCmtYn(String admCmtYn) {
		this.admCmtYn = admCmtYn;
	}

}
