package mas.anls.vo;

import oss.cmm.vo.pageDefaultVO;

public class ANLSSVO extends pageDefaultVO{

	private String sCorpId;
	private String sFromDt;
	private String sFromYear;
	private String sFromMonth;
	private String sFromDtView;
	private String sToDt;
	private String sToDtView;
	private String sCtgr;
	
	public String getsCorpId() {
		return sCorpId;
	}
	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}
	public String getsFromDt() {
		return sFromDt;
	}
	public void setsFromDt(String sFromDt) {
		this.sFromDt = sFromDt;
	}
	public String getsToDt() {
		return sToDt;
	}
	public void setsToDt(String sToDt) {
		this.sToDt = sToDt;
	}
	public String getsFromDtView() {
		return sFromDtView;
	}
	public void setsFromDtView(String sFromDtView) {
		this.sFromDtView = sFromDtView;
	}
	public String getsToDtView() {
		return sToDtView;
	}
	public void setsToDtView(String sToDtView) {
		this.sToDtView = sToDtView;
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
	public String getsCtgr() {
		return sCtgr;
	}
	public void setsCtgr(String sCtgr) {
		this.sCtgr = sCtgr;
	}		
	
}
