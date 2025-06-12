package mas.ad.vo;

import oss.cmm.vo.CALENDARVO;

public class ADCNTCALENDARVO extends CALENDARVO{
	
	private String prdtNum;
	
	private String totalRoomNum;
	private String useRoomNum;
	private String ddlYn;
	
	private String startDt;
	private String endDt;
	private String wday;
	
	private String totalRoomNumSmp;
	private String useRoomNumSmp;
	private String ddlYnSmp;

	/** 입력완료 구분자 2017.01.03 최영철 추가 */
	private String ioDiv;

	/** 채널톡 상담 예외일 **/
	private String outDay;

	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getTotalRoomNum() {
		return totalRoomNum;
	}
	public void setTotalRoomNum(String totalRoomNum) {
		this.totalRoomNum = totalRoomNum;
	}
	public String getUseRoomNum() {
		return useRoomNum;
	}
	public void setUseRoomNum(String useRoomNum) {
		this.useRoomNum = useRoomNum;
	}
	public String getDdlYn() {
		return ddlYn;
	}
	public void setDdlYn(String ddlYn) {
		this.ddlYn = ddlYn;
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
	public String getWday() {
		return wday;
	}
	public void setWday(String wday) {
		this.wday = wday;
	}
	public String getTotalRoomNumSmp() {
		return totalRoomNumSmp;
	}
	public void setTotalRoomNumSmp(String totalRoomNumSmp) {
		this.totalRoomNumSmp = totalRoomNumSmp;
	}
	public String getUseRoomNumSmp() {
		return useRoomNumSmp;
	}
	public void setUseRoomNumSmp(String useRoomNumSmp) {
		this.useRoomNumSmp = useRoomNumSmp;
	}
	public String getDdlYnSmp() {
		return ddlYnSmp;
	}
	public void setDdlYnSmp(String ddlYnSmp) {
		this.ddlYnSmp = ddlYnSmp;
	}
	public String getIoDiv() {
		return ioDiv;
	}
	public void setIoDiv(String ioDiv) {
		this.ioDiv = ioDiv;
	}

	public String getOutDay() {
		return outDay;
	}

	public void setOutDay(String outDay) {
		this.outDay = outDay;
	}
}

