package mas.rc.vo;

public class RC_RSVCHARTVO extends RC_RSVCHARTSVO{

	/** 상품번호 */
	private String prdtNum;
	/** 상품명 */
	private String prdtNm;
	/** 노출순번 */
	private String viewSn;
	/** 거래상태 */
	private String tradeStatus;
	/** 날짜 */
	private String dt;
	/** 수량 */
	private String totalCarNum;
	/** 예약수량 */
	private String useCnt;
	/** 월 마지막날 */
	private String lastDt;
	
	private String useFuelDiv;
	
	private String isrDiv;
	
	private String isrTypeDiv;
	
	public void setViewSn(String viewSn) {
		this.viewSn = viewSn; 
	}
	public String getViewSn() {
		return viewSn; 
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm; 
	}
	public String getPrdtNm() {
		return prdtNm; 
	}
	public void setTotalCarNum(String totalCarNum) {
		this.totalCarNum = totalCarNum; 
	}
	public String getTotalCarNum() {
		return totalCarNum; 
	}
	public void setDt(String dt) {
		this.dt = dt; 
	}
	public String getDt() {
		return dt; 
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum; 
	}
	public String getPrdtNum() {
		return prdtNum; 
	}
	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus; 
	}
	public String getTradeStatus() {
		return tradeStatus; 
	}
	public void setUseCnt(String useCnt) {
		this.useCnt = useCnt; 
	}
	public String getUseCnt() {
		return useCnt; 
	}
	public String getLastDt() {
		return lastDt;
	}
	public void setLastDt(String lastDt) {
		this.lastDt = lastDt;
	}
	public String getUseFuelDiv() {
		return useFuelDiv;
	}
	public void setUseFuelDiv(String useFuelDiv) {
		this.useFuelDiv = useFuelDiv;
	}
	public String getIsrDiv() {
		return isrDiv;
	}
	public void setIsrDiv(String isrDiv) {
		this.isrDiv = isrDiv;
	}
	public String getIsrTypeDiv() {
		return isrTypeDiv;
	}
	public void setIsrTypeDiv(String isrTypeDiv) {
		this.isrTypeDiv = isrTypeDiv;
	}

}
