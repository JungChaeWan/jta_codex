package mas.ad.vo;

public class AD_AMTINFVO extends AD_AMTINFSVO{

	private String prdtNum;
	private String aplDt;
	private String saleAmt;
	private String nmlAmt;
	private String hotdallYn;
	private String daypriceYn;
	private String daypriceAmt;
	private String disDaypriceAmt;
	/** 입금가 **/
	private String depositAmt;
	
	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getAplDt() {
		return aplDt;
	}
	public void setAplDt(String aplDt) {
		this.aplDt = aplDt;
	}
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getNmlAmt() {
		return nmlAmt;
	}
	public void setNmlAmt(String nmlAmt) {
		this.nmlAmt = nmlAmt;
	}
	public String getHotdallYn() {
		return hotdallYn;
	}
	public void setHotdallYn(String hotdallYn) {
		this.hotdallYn = hotdallYn;
	}
	public String getDaypriceYn() {
		return daypriceYn;
	}
	public void setDaypriceYn(String daypriceYn) {
		this.daypriceYn = daypriceYn;
	}
	public String getDaypriceAmt() {
		return daypriceAmt;
	}
	public void setDaypriceAmt(String daypriceAmt) {
		this.daypriceAmt = daypriceAmt;
	}
	public String getDisDaypriceAmt() {
		return disDaypriceAmt;
	}
	public void setDisDaypriceAmt(String disDaypriceAmt) {
		this.disDaypriceAmt = disDaypriceAmt;
	}

	public String getDepositAmt() {
		return depositAmt;
	}

	public void setDepositAmt(String depositAmt) {
		this.depositAmt = depositAmt;
	}
}
