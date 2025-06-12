package mas.sp.vo;

import java.util.List;

public class SP_DTLINFVO {

	private String spDtlinfNum;
	private String prdtNum;
	private String dtlinfType;
	private String printSn;
	private String printYn;
	private String selNm;
	private String subject;
	private String dtlinfExp;

	private String oldSn;
	private String newSn;

	private List<SP_DTLINF_ITEMVO> spDtlinfItem;
	private String itmeEtcViewYn;



	public String getSpDtlinfNum() {
		return spDtlinfNum;
	}
	public void setSpDtlinfNum(String spDtlinfNum) {
		this.spDtlinfNum = spDtlinfNum;
	}
	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getDtlinfType() {
		return dtlinfType;
	}
	public void setDtlinfType(String dtlinfType) {
		this.dtlinfType = dtlinfType;
	}
	public String getPrintSn() {
		return printSn;
	}
	public void setPrintSn(String printSn) {
		this.printSn = printSn;
	}
	public String getPrintYn() {
		return printYn;
	}
	public void setPrintYn(String printYn) {
		this.printYn = printYn;
	}
	public String getSelNm() {
		return selNm;
	}
	public void setSelNm(String selNm) {
		this.selNm = selNm;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getDtlinfExp() {
		return dtlinfExp;
	}
	public void setDtlinfExp(String dtlinfExp) {
		this.dtlinfExp = dtlinfExp;
	}
	public String getOldSn() {
		return oldSn;
	}
	public void setOldSn(String oldSn) {
		this.oldSn = oldSn;
	}
	public String getNewSn() {
		return newSn;
	}
	public void setNewSn(String newSn) {
		this.newSn = newSn;
	}
	public List<SP_DTLINF_ITEMVO> getSpDtlinfItem() {
		return spDtlinfItem;
	}
	public void setSpDtlinfItem(List<SP_DTLINF_ITEMVO> spDtlinfItem) {
		this.spDtlinfItem = spDtlinfItem;
	}
	public String getItmeEtcViewYn() {
		return itmeEtcViewYn;
	}
	public void setItmeEtcViewYn(String itmeEtcViewYn) {
		this.itmeEtcViewYn = itmeEtcViewYn;
	}


}
