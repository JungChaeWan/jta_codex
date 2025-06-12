package mas.ad.vo;

import oss.cmm.vo.CALENDARVO;

public class ADCALENDARVO extends CALENDARVO{
	
	private String prdtNum;
	
	private String saleAmt;
	private String nmlAmt;
	private String hotdallYn;
	private String daypriceYn;
	private String daypriceAmt;
	
	private String startDt;
	private String endDt;
	private String wday;
	
	private String saleAmtSmp;
	private String nmlAmtSmp;
	private String hotdallYnSmp;
	private String daypriceYnSmp;
	private String daypriceAmtSmp;
	
	/** 입력완료 구분자 2017.01.03 최영철 추가 */
	private String ioDiv;

	/** 입금가 2022.03.15 chaewan.jung */
	private String depositAmtSmp;
	private String depositAmt;
	
	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
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
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getWday() {
		return wday;
	}
	public void setWday(String wday) {
		this.wday = wday;
	}
	public String getSaleAmtSmp() {
		return saleAmtSmp;
	}
	public void setSaleAmtSmp(String saleAmtSmp) {
		this.saleAmtSmp = saleAmtSmp;
	}
	public String getNmlAmtSmp() {
		return nmlAmtSmp;
	}
	public void setNmlAmtSmp(String nmlAmtSmp) {
		this.nmlAmtSmp = nmlAmtSmp;
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
	public String getHotdallYnSmp() {
		return hotdallYnSmp;
	}
	public void setHotdallYnSmp(String hotdallYnSmp) {
		this.hotdallYnSmp = hotdallYnSmp;
	}
	public String getDaypriceYnSmp() {
		return daypriceYnSmp;
	}
	public void setDaypriceYnSmp(String daypriceYnSmp) {
		this.daypriceYnSmp = daypriceYnSmp;
	}
	public String getDaypriceAmtSmp() {
		return daypriceAmtSmp;
	}
	public void setDaypriceAmtSmp(String daypriceAmtSmp) {
		this.daypriceAmtSmp = daypriceAmtSmp;
	}
	public String getIoDiv() {
		return ioDiv;
	}
	public void setIoDiv(String ioDiv) {
		this.ioDiv = ioDiv;
	}

	public String getDepositAmt() {
		return depositAmt;
	}

	public void setDepositAmt(String depositAmt) {
		this.depositAmt = depositAmt;
	}

	public String getDepositAmtSmp() {
		return depositAmtSmp;
	}

	public void setDepositAmtSmp(String depositAmtSmp) {
		this.depositAmtSmp = depositAmtSmp;
	}
}

