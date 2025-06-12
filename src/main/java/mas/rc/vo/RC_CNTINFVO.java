package mas.rc.vo;

public class RC_CNTINFVO {

	/** 상품 번호 */
	private String prdtNum;
	/** 적용 일자 */
	private String aplDt;
	/** 적용 일자 */
	private String viewAplDt;
	/** 총 차량 수 */
	private String totalCarNum;
	
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
	public String getTotalCarNum() {
		return totalCarNum;
	}
	public void setTotalCarNum(String totalCarNum) {
		this.totalCarNum = totalCarNum;
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
