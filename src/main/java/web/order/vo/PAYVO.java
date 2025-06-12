package web.order.vo;

public class PAYVO {

	/** 예약 번호 */
	private String rsvNum;
	/** 결제 순번 */
	private String paySn;
	/** 상세 예약 번호 */
	private String dtlRsvNum;
	/** 결제 구분 */
	private String payDiv;
	/** 결제 결과 코드 */
	private String payRstCd;
	/** 결제 결과 정보 */
	private String payRstInf;
	/** 결제 금액 */
	private String payAmt;
	/** 거래 번호 */
	private String LGD_TID;
	/** 결제 일시 */
	private String payDttm;
	
	
	public String getRsvNum() {
		return rsvNum;
	}
	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}
	public String getPaySn() {
		return paySn;
	}
	public void setPaySn(String paySn) {
		this.paySn = paySn;
	}
	public String getDtlRsvNum() {
		return dtlRsvNum;
	}
	public void setDtlRsvNum(String dtlRsvNum) {
		this.dtlRsvNum = dtlRsvNum;
	}
	public String getPayDiv() {
		return payDiv;
	}
	public void setPayDiv(String payDiv) {
		this.payDiv = payDiv;
	}
	public String getPayRstCd() {
		return payRstCd;
	}
	public void setPayRstCd(String payRstCd) {
		this.payRstCd = payRstCd;
	}
	public String getPayRstInf() {
		return payRstInf;
	}
	public void setPayRstInf(String payRstInf) {
		this.payRstInf = payRstInf;
	}
	public String getPayAmt() {
		return payAmt;
	}
	public void setPayAmt(String payAmt) {
		this.payAmt = payAmt;
	}
	public String getLGD_TID() {
		return LGD_TID;
	}
	public void setLGD_TID(String lGD_TID) {
		LGD_TID = lGD_TID;
	}
	public String getPayDttm() {
		return payDttm;
	}
	public void setPayDttm(String payDttm) {
		this.payDttm = payDttm;
	}
	
}
