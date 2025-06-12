package oss.corp.vo;

public class CMSSPGVO {

	/** 결제 구분 */
	private String pgDiv;
	/** 결제 구분 순번 */
	private String pgDivSeq;
	/** 적용 시작 일자 */
	private String aplStartDt;
	/** 적용 종료 일자*/
	private String aplEndDt;
	/** 수수료 구분*/
	private String pgCmssDiv;
	/** 수수료율*/
	private String pgCmssPer;
	/** 수수료금액*/
	private String pgCmssAmt;
	/** 최소 수수료*/
	private String minCmss;
	/** 취소 수수료*/
	private String cancelCmss;
	/** 최초 등록 일시 */
	private String frstRegDttm;
	/** 최종 수정 일시 */
	private String lastModDttm;
	
	public String getPgDiv() {
		return pgDiv;
	}
	public void setPgDiv(String pgDiv) {
		this.pgDiv = pgDiv;
	}
	public String getPgDivSeq() {
		return pgDivSeq;
	}
	public void setPgDivSeq(String pgDivSeq) {
		this.pgDivSeq = pgDivSeq;
	}
	public String getAplStartDt() {
		return aplStartDt;
	}
	public void setAplStartDt(String aplStartDt) {
		this.aplStartDt = aplStartDt;
	}
	public String getAplEndDt() {
		return aplEndDt;
	}
	public void setAplEndDt(String aplEndDt) {
		this.aplEndDt = aplEndDt;
	}
	public String getPgCmssDiv() {
		return pgCmssDiv;
	}
	public void setPgCmssDiv(String pgCmssDiv) {
		this.pgCmssDiv = pgCmssDiv;
	}
	public String getPgCmssPer() {
		return pgCmssPer;
	}
	public void setPgCmssPer(String pgCmssPer) {
		this.pgCmssPer = pgCmssPer;
	}
	public String getPgCmssAmt() {
		return pgCmssAmt;
	}
	public void setPgCmssAmt(String pgCmssAmt) {
		this.pgCmssAmt = pgCmssAmt;
	}
	public String getMinCmss() {
		return minCmss;
	}
	public void setMinCmss(String minCmss) {
		this.minCmss = minCmss;
	}
	public String getCancelCmss() {
		return cancelCmss;
	}
	public void setCancelCmss(String cancelCmss) {
		this.cancelCmss = cancelCmss;
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
