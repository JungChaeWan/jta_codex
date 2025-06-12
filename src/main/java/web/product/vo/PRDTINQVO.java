package web.product.vo;

public class PRDTINQVO {
	private String inqDt;		// 조회 일자
	private String linkNum;		// 연계 번호
	private String inqDiv;		// 조회 구분
	private int inqNum;		// 조회 수
	private int snsPublicNum;	// SNS 공유 수
	private String snsDiv;
	private String corpCd;
	
	public String getInqDt() {
		return inqDt;
	}
	public void setInqDt(String inqDt) {
		this.inqDt = inqDt;
	}
	public String getLinkNum() {
		return linkNum;
	}
	public void setLinkNum(String linkNum) {
		this.linkNum = linkNum;
	}
	public String getInqDiv() {
		return inqDiv;
	}
	public void setInqDiv(String inqDiv) {
		this.inqDiv = inqDiv;
	}
	public int getInqNum() {
		return inqNum;
	}
	public void setInqNum(int inqNum) {
		this.inqNum = inqNum;
	}
	public int getSnsPublicNum() {
		return snsPublicNum;
	}
	public void setSnsPublicNum(int snsPublicNum) {
		this.snsPublicNum = snsPublicNum;
	}

	public String getSnsDiv() {
		return snsDiv;
	}

	public void setSnsDiv(String snsDiv) {
		this.snsDiv = snsDiv;
	}

	public String getCorpCd() {
		return corpCd;
	}

	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
}
