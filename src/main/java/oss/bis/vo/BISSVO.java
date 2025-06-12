package oss.bis.vo;

import oss.cmm.vo.pageDefaultVO;

public class BISSVO extends pageDefaultVO {
	private String sYear;
	private String sMonth;
	private String sCategory;
	private String sType;
	private String sGubun;
	private String sStartDt;
	private String sEndDt;
	private String sCorpId;
	private String sCorpCd;
	private String sCorpNm;
	private String sPrdtNm;
	private String sSortField;
	private String sSortOption;
	private String sFlag;

	public String getsYear() {
		return sYear;
	}
	public void setsYear(String sYear) {
		this.sYear = sYear;
	}
	public String getsMonth() {
		return sMonth;
	}
	public void setsMonth(String sMonth) {
		this.sMonth = sMonth;
	}	
	public String getsCategory() {
		return sCategory;
	}
	public void setsCategory(String sCategory) {
		this.sCategory = sCategory;
	}
	public String getsStartDt() {
		return sStartDt;
	}
	public String getsType() {
		return sType;
	}
	public void setsType(String sType) {
		this.sType = sType;
	}
	public String getsGubun() {
		return sGubun;
	}
	public void setsGubun(String sGubun) {
		this.sGubun = sGubun;
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
	public String getsCorpId() {
		return sCorpId;
	}
	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}
	public String getsCorpNm() {
		return sCorpNm;
	}
	public void setsCorpNm(String sCorpNm) {
		this.sCorpNm = sCorpNm;
	}
	public String getsSortField() {
		return sSortField;
	}
	public void setsSortField(String sSortField) {
		this.sSortField = sSortField;
	}
	public String getsSortOption() {
		return sSortOption;
	}
	public void setsSortOption(String sSortOption) {
		this.sSortOption = sSortOption;
	}

	public String getsCorpCd() {
		return sCorpCd;
	}

	public void setsCorpCd(String sCorpCd) {
		this.sCorpCd = sCorpCd;
	}

	public String getsPrdtNm() {
		return sPrdtNm;
	}
	
	public void setsPrdtNm(String sPrdtNm) {
		this.sPrdtNm = sPrdtNm;
	}
	
	public String getsFlag() {
		return sFlag;
	}
	public void setsFlag(String sFlag) {
		this.sFlag = sFlag;
	}
	
}
