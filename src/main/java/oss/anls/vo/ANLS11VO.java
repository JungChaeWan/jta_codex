package oss.anls.vo;

public class ANLS11VO {

	private String dt;
	private String saleAmt;
	private String cancelAmt;
	private String totalAmt;
	private String totalCnt;
	private String totalAmtPer;
	
	public void setCancelAmt(String cancelAmt) {
		this.cancelAmt = cancelAmt; 
	}
	public String getCancelAmt() {
		return cancelAmt; 
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt; 
	}
	public String getSaleAmt() {
		return saleAmt; 
	}
	public void setDt(String dt) {
		this.dt = dt; 
	}
	public String getDt() {
		return dt; 
	}
	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt; 
	}
	public String getTotalAmt() {
		return totalAmt; 
	}	
	public String getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(String totalCnt) {
		this.totalCnt = totalCnt;
	}
	public void setTotalAmtPer(String totalAmtPer) {
		this.totalAmtPer = totalAmtPer; 
	}
	public String getTotalAmtPer() {
		return totalAmtPer; 
	}

}
