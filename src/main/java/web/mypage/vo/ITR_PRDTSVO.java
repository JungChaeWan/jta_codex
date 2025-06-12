package web.mypage.vo;

import oss.cmm.vo.pageDefaultVO;

public class ITR_PRDTSVO extends pageDefaultVO{

	private String prdtNum;
	private String prdtNm;
	private String disInf;
	private String prdtDiv;
	private String exprStartDt;
	private String exprEndDt;
	private String userId;
	
	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getDisInf() {
		return disInf;
	}
	public void setDisInf(String disInf) {
		this.disInf = disInf;
	}
	public String getPrdtDiv() {
		return prdtDiv;
	}
	public void setPrdtDiv(String prdtDiv) {
		this.prdtDiv = prdtDiv;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getExprStartDt() {
		return exprStartDt;
	}
	public void setExprStartDt(String exprStartDt) {
		this.exprStartDt = exprStartDt;
	}
	public String getExprEndDt() {
		return exprEndDt;
	}
	public void setExprEndDt(String exprEndDt) {
		this.exprEndDt = exprEndDt;
	}
}
