package oss.adj.vo;

import java.util.List;

import oss.cmm.vo.pageDefaultVO;

public class ADJSVO extends pageDefaultVO{

	private String sAdjDt;
	private String sFromYear;
	private String sFromMonth;
	private String sCorpId;
	private String sStartDt;
	private String sEndDt;
	private String sOrder;
	private String sDirection;
	private	List<String> arrCpId;
	private List<String> corpList;
	private List<String> arrPartnerCode;

	public String getsAdjDt() {
		return sAdjDt;
	}

	public void setsAdjDt(String sAdjDt) {
		this.sAdjDt = sAdjDt;
	}

	public String getsFromYear() {
		return sFromYear;
	}

	public void setsFromYear(String sFromYear) {
		this.sFromYear = sFromYear;
	}

	public String getsFromMonth() {
		return sFromMonth;
	}

	public void setsFromMonth(String sFromMonth) {
		this.sFromMonth = sFromMonth;
	}

	public List<String> getCorpList() {
		return corpList;
	}

	public void setCorpList(List<String> corpList) {
		this.corpList = corpList;
	}

	public String getsCorpId() {
		return sCorpId;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsStartDt() {
		return sStartDt;
	}

	public void setsStartDt(String sStartDt) {
		this.sStartDt = sStartDt;
	}

	public String getsEndDt() {
		return sEndDt;
	}

	public void setsEndDt(String sEndDt) {
		this.sEndDt = sEndDt;
	}

	public String getsOrder() {
		return sOrder;
	}

	public void setsOrder(String sOrder) {
		this.sOrder = sOrder;
	}

	public String getsDirection() {
		return sDirection;
	}

	public void setsDirection(String sDirection) {
		this.sDirection = sDirection;
	}

	public List<String> getArrCpId() {
		return arrCpId;
	}

	public void setArrCpId(List<String> arrCpId) {
		this.arrCpId = arrCpId;
	}

	public List<String> getArrPartnerCode() {
		return arrPartnerCode;
	}

	public void setArrPartnerCode(List<String> arrPartnerCode) {
		this.arrPartnerCode = arrPartnerCode;
	}
}
