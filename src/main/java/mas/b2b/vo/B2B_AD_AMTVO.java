package mas.b2b.vo;

import java.util.List;

public class B2B_AD_AMTVO {

	/** 요금 그룹 번호 */
	private String amtGrpNum;
	/** 상품 번호 */
	private String prdtNum;
	/** 적용 일자 */
	private String aplDt;
	/** 업체 아이디 */
	private String corpId;
	/** 판매 금액 */
	private String saleAmt;
	/** 시작 일자 */
	private String startDt;
	/** 종료 일자 */
	private String endDt;
	
	private List<String> wdayList;
	
	public String getAmtGrpNum() {
		return amtGrpNum;
	}
	public void setAmtGrpNum(String amtGrpNum) {
		this.amtGrpNum = amtGrpNum;
	}
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
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
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
	public List<String> getWdayList() {
		return wdayList;
	}
	public void setWdayList(List<String> wdayList) {
		this.wdayList = wdayList;
	}


}
