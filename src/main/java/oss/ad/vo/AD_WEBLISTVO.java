package oss.ad.vo;

public class AD_WEBLISTVO extends AD_WEBLISTSVO{
	private String corpId;
	private String corpCd;
	private String prdtNum;
	private String adArea;
	private String adDiv;
	private String adNm;
	private String roomNm;
	private String adSimpleExp;
	private String tip;
	private String totalBuyNum;
	private String aplDt;
	private String nmlAmt;
	private String saleAmt;
	private String hotdallYn;
	private String daypriceYn;
	private String daypriceAmt;
	private String continueNightYn;
	private String continueNightAmt;
	private String salePent;
	private String stdMem;
	private String maxiMem;
	private String totalRoomNum;
	private String useRoomNum;
	private String ddlYn;
	private String saveFileNm;
	private String savePath;
	private String gpaAvg;
	private String gpaCnt;
	private String lon;
	private String lat;
	private String adAreaNm;
	private String eventCnt;
	private String couponCnt;
	private String printSn;
	private String prmtContents;
	private String superbCorpYn;
	private String iconCd;
	private String minRsvNight;
	private String maxRsvNight;
	private String stayNight;

	/** 예약가능 여부 - 재고나 요금이 없을 경우 하단으로 SORT **/
	private String rsvAbleYn;

	/** 탐나는전 예약가능 여부 **/
	private String tamnacardYn;

	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getAdArea() {
		return adArea;
	}
	public void setAdArea(String adArea) {
		this.adArea = adArea;
	}
	public String getAdDiv() {
		return adDiv;
	}
	public void setAdDiv(String adDiv) {
		this.adDiv = adDiv;
	}
	public String getAdNm() {
		return adNm;
	}
	public void setAdNm(String adNm) {
		this.adNm = adNm;
	}
	public String getRoomNm() {
		return roomNm;
	}
	public void setRoomNm(String roomNm) {
		this.roomNm = roomNm;
	}
	public String getAdSimpleExp() {
		return adSimpleExp;
	}
	public void setAdSimpleExp(String adSimpleExp) {
		this.adSimpleExp = adSimpleExp;
	}
	public String getTip() {
		return tip;
	}
	public void setTip(String tip) {
		this.tip = tip;
	}
	public String getTotalBuyNum() {
		return totalBuyNum;
	}
	public void setTotalBuyNum(String totalBuyNum) {
		this.totalBuyNum = totalBuyNum;
	}
	public String getAplDt() {
		return aplDt;
	}
	public void setAplDt(String aplDt) {
		this.aplDt = aplDt;
	}
	public String getNmlAmt() {
		return nmlAmt;
	}
	public void setNmlAmt(String nmlAmt) {
		this.nmlAmt = nmlAmt;
	}
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getSalePent() {
		return salePent;
	}
	public void setSalePent(String salePent) {
		this.salePent = salePent;
	}
	public String getStdMem() {
		return stdMem;
	}
	public void setStdMem(String stdMem) {
		this.stdMem = stdMem;
	}
	public String getMaxiMem() {
		return maxiMem;
	}
	public void setMaxiMem(String maxiMem) {
		this.maxiMem = maxiMem;
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
	public String getRsvAbleYn() {
		return rsvAbleYn;
	}
	public void setRsvAbleYn(String rsvAbleYn) {
		this.rsvAbleYn = rsvAbleYn;
	}
	public String getSaveFileNm() {
		return saveFileNm;
	}
	public void setSaveFileNm(String saveFileNm) {
		this.saveFileNm = saveFileNm;
	}
	public String getSavePath() {
		return savePath;
	}
	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	public String getGpaAvg() {
		return gpaAvg;
	}
	public void setGpaAvg(String gpaAvg) {
		this.gpaAvg = gpaAvg;
	}
	public String getGpaCnt() {
		return gpaCnt;
	}
	public void setGpaCnt(String gpaCnt) {
		this.gpaCnt = gpaCnt;
	}
	public String getLon() {
		return lon;
	}
	public void setLon(String lon) {
		this.lon = lon;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getAdAreaNm() {
		return adAreaNm;
	}
	public void setAdAreaNm(String adAreaNm) {
		this.adAreaNm = adAreaNm;
	}
	public String getHotdallYn() {
		return hotdallYn;
	}
	public void setHotdallYn(String hotdallYn) {
		this.hotdallYn = hotdallYn;
	}
	public String getDaypriceYn() {
		return daypriceYn;
	}
	public void setDaypriceYn(String daypriceYn) {
		this.daypriceYn = daypriceYn;
	}
	public String getDaypriceAmt() {
		return daypriceAmt;
	}
	public void setDaypriceAmt(String daypriceAmt) {
		this.daypriceAmt = daypriceAmt;
	}
	public String getContinueNightYn() {
		return continueNightYn;
	}
	public void setContinueNightYn(String continueNightYn) {
		this.continueNightYn = continueNightYn;
	}
	public String getContinueNightAmt() {
		return continueNightAmt;
	}
	public void setContinueNightAmt(String continueNightAmt) {
		this.continueNightAmt = continueNightAmt;
	}
	public String getEventCnt() {
		return eventCnt;
	}
	public void setEventCnt(String eventCnt) {
		this.eventCnt = eventCnt;
	}
	public String getCouponCnt() {
		return couponCnt;
	}
	public void setCouponCnt(String couponCnt) {
		this.couponCnt = couponCnt;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getPrintSn() {
		return printSn;
	}
	public void setPrintSn(String printSn) {
		this.printSn = printSn;
	}
	public String getPrmtContents() {
		return prmtContents;
	}
	public void setPrmtContents(String prmtContents) {
		this.prmtContents = prmtContents;
	}
	public String getSuperbCorpYn() {
		return superbCorpYn;
	}
	public void setSuperbCorpYn(String superbCorpYn) {
		this.superbCorpYn = superbCorpYn;
	}

	public String getIconCd() {
		return iconCd;
	}

	public void setIconCd(String iconCd) {
		this.iconCd = iconCd;
	}

	public String getMinRsvNight() {
		return minRsvNight;
	}

	public void setMinRsvNight(String minRsvNight) {
		this.minRsvNight = minRsvNight;
	}

	public String getMaxRsvNight() {
		return maxRsvNight;
	}

	public void setMaxRsvNight(String maxRsvNight) {
		this.maxRsvNight = maxRsvNight;
	}

	public String getStayNight() {
		return stayNight;
	}

	public void setStayNight(String stayNight) {
		this.stayNight = stayNight;
	}

	public String getTamnacardYn() {
		return tamnacardYn;
	}

	public void setTamnacardYn(String tamnacardYn) {
		this.tamnacardYn = tamnacardYn;
	}
}
