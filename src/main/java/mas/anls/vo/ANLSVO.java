package mas.anls.vo;

/**
 * 숙박 통계 관련 VO
 * 파일명 : ADANLSVO.java
 * 작성일 : 2015. 12. 14. 오후 8:08:30
 * 작성자 : 최영철
 */
public class ANLSVO {

	/** 상품 번호 */
	private String prdtNum;
	/** 상품 명 */
	private String prdtNm;
	/** 예약 건수 */
	private String rsvCnt;
	/** 판매 금액 */
	private String sumAmt;
	/** 예약 건수 퍼센트 */
	private String rsvCntPer;
	/** 판매 금액 퍼센트 */
	private String sumAmtPer;
	
	/** 통계일자 */
	private String dt;
	/** 취소 건수 */
	private String cancelCnt;
	/** 취소 금액 */
	private String cancelAmt;
	/** 판매 금액 */
	private String nmlAmt;
	/** 수수료 금액 */
	private String cmssAmt;
	
	
	public String getDt() {
		return dt;
	}
	public void setDt(String dt) {
		this.dt = dt;
	}
	public String getCancelCnt() {
		return cancelCnt;
	}
	public void setCancelCnt(String cancelCnt) {
		this.cancelCnt = cancelCnt;
	}
	public String getNmlAmt() {
		return nmlAmt;
	}
	public void setNmlAmt(String nmlAmt) {
		this.nmlAmt = nmlAmt;
	}
	public String getCmssAmt() {
		return cmssAmt;
	}
	public void setCmssAmt(String cmssAmt) {
		this.cmssAmt = cmssAmt;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm; 
	}
	public String getPrdtNm() {
		return prdtNm; 
	}
	public void setRsvCnt(String rsvCnt) {
		this.rsvCnt = rsvCnt; 
	}
	public String getRsvCnt() {
		return rsvCnt; 
	}
	public void setSumAmt(String sumAmt) {
		this.sumAmt = sumAmt; 
	}
	public String getSumAmt() {
		return sumAmt; 
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum; 
	}
	public String getPrdtNum() {
		return prdtNum; 
	}
	public String getRsvCntPer() {
		return rsvCntPer;
	}
	public void setRsvCntPer(String rsvCntPer) {
		this.rsvCntPer = rsvCntPer;
	}
	public String getSumAmtPer() {
		return sumAmtPer;
	}
	public void setSumAmtPer(String sumAmtPer) {
		this.sumAmtPer = sumAmtPer;
	}

	public String getCancelAmt() {
		return cancelAmt;
	}

	public void setCancelAmt(String cancelAmt) {
		this.cancelAmt = cancelAmt;
	}
}
