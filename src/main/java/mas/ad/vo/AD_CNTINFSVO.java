package mas.ad.vo;

import java.util.List;

import oss.cmm.vo.pageDefaultVO;

public class AD_CNTINFSVO extends pageDefaultVO{
	
	private String sPrdtNum;
	private String sAplDt;
	
	private String startDt;
	private String endDt;
	private List<String> wdayList;
	
	private String sNights;
	
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
	public String getsPrdtNum() {
		return sPrdtNum;
	}
	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}
	public String getsAplDt() {
		return sAplDt;
	}
	public void setsAplDt(String sAplDt) {
		this.sAplDt = sAplDt;
	}
	public String getsNights() {
		return sNights;
	}
	public void setsNights(String sNights) {
		this.sNights = sNights;
	}
	
	
	
	
}
