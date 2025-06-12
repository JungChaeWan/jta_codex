package mas.ad.vo;

import oss.cmm.vo.CALENDARVO;

public class ADDTLCALENDARVO extends CALENDARVO{
	
	private String prdtNum;
	private String corpId;
	
	private String totalRoomNum;
	private String useRoomNum;
	private String ddlYn;
	
	private String saleAmt;
	private String nmlAmt;
	
	private String sFromDt; //선택한 날짜
	private int iNight;
	
	private int adCalMen1;
	private int adCalMen2;
	private int adCalMen3;
	
	
	private String status; //상태 E:예약가능, D:미정, M:마감
	private String selDayYn;
	
	//Ajax 호출 후 스크립트 실행 할꺼지?
	// CR : 방변경 후 실행
	// SD : 날짜 변경 실행
	private String scriptVal;
	
	
	private String prevYn;
	private String NextYn;
	
	
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
	public String getNmlAmt() {
		return nmlAmt;
	}
	public void setNmlAmt(String nmlAmt) {
		this.nmlAmt = nmlAmt;
	}
	public int getiNight() {
		return iNight;
	}
	public void setiNight(int iNight) {
		this.iNight = iNight;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSelDayYn() {
		return selDayYn;
	}
	public void setSelDayYn(String selDayYn) {
		this.selDayYn = selDayYn;
	}
	public String getsFromDt() {
		return sFromDt;
	}
	public void setsFromDt(String sFromDt) {
		this.sFromDt = sFromDt;
	}
	public String getScriptVal() {
		return scriptVal;
	}
	public void setScriptVal(String scriptVal) {
		this.scriptVal = scriptVal;
	}
	public String getPrevYn() {
		return prevYn;
	}
	public void setPrevYn(String prevYn) {
		this.prevYn = prevYn;
	}
	public String getNextYn() {
		return NextYn;
	}
	public void setNextYn(String nextYn) {
		NextYn = nextYn;
	}
	public int getAdCalMen1() {
		return adCalMen1;
	}
	public void setAdCalMen1(int adCalMen1) {
		this.adCalMen1 = adCalMen1;
	}
	public int getAdCalMen2() {
		return adCalMen2;
	}
	public void setAdCalMen2(int adCalMen2) {
		this.adCalMen2 = adCalMen2;
	}
	public int getAdCalMen3() {
		return adCalMen3;
	}
	public void setAdCalMen3(int adCalMen3) {
		this.adCalMen3 = adCalMen3;
	}

	
	
}

