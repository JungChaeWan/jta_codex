package mas.rc.vo;

import oss.cmm.vo.pageDefaultVO;

public class RC_RSVCHARTSVO extends pageDefaultVO{

	private String sFromYear;
	private String sFromMonth;
	private String sCorpId;
	private String sTradeStatus;
	private String sDay;
	
	
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
	public String getsCorpId() {
		return sCorpId;
	}
	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}
	public String getsTradeStatus() {
		return sTradeStatus;
	}
	public void setsTradeStatus(String sTradeStatus) {
		this.sTradeStatus = sTradeStatus;
	}

	public String getsDay() {
		return sDay;
	}

	public void setsDay(String sDay) {
		this.sDay = sDay;
	}
}
