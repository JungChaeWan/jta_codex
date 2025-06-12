package web.mypage.vo;

public class EVNTPRDTRCVVO {
	/** 이벤트 상품 순번 */
	private String evntPrdtSn;
	/** 사용자 아아디 */
	private String userId;	
	/** 사용자 명 */
	private String userNm;
	/** 이벤트 코드 */
	private String evntCd;
	/** 전화번호 */
	private String telnum;
	/** 이벤트 수 */
	private String evntNum;
	/** 수신 일시 */
	private String rcvDttm;
	
	public String getEvntPrdtSn() {
		return evntPrdtSn;
	}
	public void setEvntPrdtSn(String evntPrdtSn) {
		this.evntPrdtSn = evntPrdtSn;
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
	public String getEvntCd() {
		return evntCd;
	}
	public void setEvntCd(String evntCd) {
		this.evntCd = evntCd;
	}
	public String getTelnum() {
		return telnum;
	}
	public void setTelnum(String telnum) {
		this.telnum = telnum;
	}
	public String getEvntNum() {
		return evntNum;
	}
	public void setEvntNum(String evntNum) {
		this.evntNum = evntNum;
	}
	public String getRcvDttm() {
		return rcvDttm;
	}
	public void setRcvDttm(String rcvDttm) {
		this.rcvDttm = rcvDttm;
	}		
}
