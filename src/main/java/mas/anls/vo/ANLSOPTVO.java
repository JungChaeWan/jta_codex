package mas.anls.vo;

/**
 * 숙박 통계 관련 VO
 * 파일명 : ADANLSVO.java
 * 작성일 : 2015. 12. 14. 오후 8:08:30
 * 작성자 : 최영철
 */
public class ANLSOPTVO extends ANLSVO{

	/** 상품명 */
	private String prdtNm;
	
	/** 구분자 명 */
	private String prdtDivNm;
	
	/** 옵션명 */
	private String optNm;

	public String getPrdtNm() {
		return prdtNm;
	}

	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}

	public String getPrdtDivNm() {
		return prdtDivNm;
	}

	public void setPrdtDivNm(String prdtDivNm) {
		this.prdtDivNm = prdtDivNm;
	}

	public String getOptNm() {
		return optNm;
	}

	public void setOptNm(String optNm) {
		this.optNm = optNm;
	}
	
}
