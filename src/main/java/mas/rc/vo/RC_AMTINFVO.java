package mas.rc.vo;

public class RC_AMTINFVO extends RC_AMTINFSVO{

	/** 상품 번호 */
	private String prdtNum;
	/** 적용 일자 */
	private String viewAplDt;
	/** 적용 일자 */
	private String aplDt;
	/** 6시간 금액 */
	private String tm6Amt;
	/** 12시간 금액 */
	private String tm12Amt;
	/** 24시간 금액 */
	private String tm24Amt;
	/** 1시간 추가 금액 */
	private String tm1AddAmt;
	
	private String gubun;
	
	
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
	public String getTm6Amt() {
		return tm6Amt;
	}
	public void setTm6Amt(String tm6Amt) {
		this.tm6Amt = tm6Amt;
	}
	public String getTm12Amt() {
		return tm12Amt;
	}
	public void setTm12Amt(String tm12Amt) {
		this.tm12Amt = tm12Amt;
	}
	public String getTm24Amt() {
		return tm24Amt;
	}
	public void setTm24Amt(String tm24Amt) {
		this.tm24Amt = tm24Amt;
	}
	public String getTm1AddAmt() {
		return tm1AddAmt;
	}
	public void setTm1AddAmt(String tm1AddAmt) {
		this.tm1AddAmt = tm1AddAmt;
	}
	public String getViewAplDt() {
		return viewAplDt;
	}
	public void setViewAplDt(String viewAplDt) {
		this.viewAplDt = viewAplDt;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}


}
