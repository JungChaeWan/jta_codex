package mas.prmt.vo;

import oss.cmm.vo.pageDefaultVO;

public class PRMTCMTVO extends pageDefaultVO {
	private String prmtNum;		/* 프로모션 번호 */
	private String cmtSn;		/* 댓글 순번 */
	private String userId;		/* 사용자 아이디 */
	private String contents;	/* 내용 */
	private String printYn;		/* 출력 여부 */
	private String frstRegDttm;/* 최초 등록 일시 */
	private String lastModDttm;/* 최종 수정 일시 */
	private String frstRegId;	/* 최초 등록 아이디 */
	private String lastModId;	/* 최종 수정 아이디 */
	private String frstRegIp;	/* 최초 등록 아이피 */
	private String lastModIp;	/* 최종 수정 아이피 */
	private String email;		/* 이메일 */

	private String userNm;
	private String telNum;

	public String getPrmtNum() {
		return prmtNum;
	}
	public void setPrmtNum(String prmtNum) {
		this.prmtNum = prmtNum;
	}
	public String getCmtSn() {
		return cmtSn;
	}
	public void setCmtSn(String cmtSn) {
		this.cmtSn = cmtSn;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getPrintYn() {
		return printYn;
	}
	public void setPrintYn(String printYn) {
		this.printYn = printYn;
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
	public String getFrstRegId() {
		return frstRegId;
	}
	public void setFrstRegId(String frstRegId) {
		this.frstRegId = frstRegId;
	}
	public String getLastModId() {
		return lastModId;
	}
	public void setLastModId(String lastModId) {
		this.lastModId = lastModId;
	}
	public String getFrstRegIp() {
		return frstRegIp;
	}
	public void setFrstRegIp(String frstRegIp) {
		this.frstRegIp = frstRegIp;
	}
	public String getLastModIp() {
		return lastModIp;
	}
	public void setLastModIp(String lastModIp) {
		this.lastModIp = lastModIp;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getTelNum() {
		return telNum;
	}
	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}

}
