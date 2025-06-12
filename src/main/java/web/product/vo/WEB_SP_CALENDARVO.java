package web.product.vo;

import oss.cmm.service.OssCmmUtil;
import oss.cmm.vo.CALENDARVO;

public class WEB_SP_CALENDARVO extends CALENDARVO {

	/** 상품 판매 시작일자 */
	private String saleStartDt;
	/** 상품 판매 종료 일자 */
	private String saleEndDt;

	/** 마감여부 */
	private String ddlYn;
	/** 판매 여부 */
	private String saleYn;
	/** 20151030 년월일 */
	private String fullDay;
	
	private String prevYn;
	private String NextYn;

	public String getSaleStartDt() {
		return saleStartDt;
	}

	public void setSaleStartDt(String saleStartDt) {
		this.saleStartDt = saleStartDt;
	}

	public String getSaleEndDt() {
		return saleEndDt;
	}

	public void setSaleEndDt(String saleEndDt) {
		this.saleEndDt = saleEndDt;
	}

	public String getDdlYn() {
		return ddlYn;
	}

	public void setDdlYn(String ddlYn) {
		this.ddlYn = ddlYn;
	}
	
	public String getSaleYn() {
		return saleYn;
	}

	public void setSaleYn(String saleYn) {
		this.saleYn = saleYn;
	}

	public String getFullDay() {
		return OssCmmUtil.getFullDay(super.getiYear(), super.getiMonth(), super.getiDay());
	}
	
	public String getPrevYn() {
		return prevYn;
	}

	public void setPrevYn(String prevYn) {
		this.prevYn = prevYn;
	}

	public String getNextYn() {
		return NextYn;
	}

	public void setNextYn(String nextYn) {
		NextYn = nextYn;
	}

	@Override
	public String toString() {
		return "WEB_SP_CALENDARVO [saleStartDt=" + saleStartDt + ", saleEndDt="
				+ saleEndDt + ", ddlYn=" + ddlYn + "]"
				+ "CALENDARVO [iYear=" + super.getiYear() + ", iMonth=" + super.getiMonth()
				+ ", iMonthLastDay=" + super.getiMonthLastDay() + ", iDay=" + super.getiDay() + ", iWeek=" + super.getiWeek()
				+ "]";
	}

	public void setFullDay(String fullDay) {
		this.fullDay = fullDay;
	}
	
}