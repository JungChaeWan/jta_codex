package mas.ad.vo;

import oss.cmm.vo.CM_IMGVO;

import java.util.List;

public class AD_PRDTINFVO extends AD_PRDTINFSVO{

	private String prdtNum; 	
	private String prdtNm; 		
	private String corpId; 		
	private String tradeStatus; 	
	private String stdMem; 		
	private String maxiMem; 	
	private String prdtExp; 	
	private String memExcdAbleYn; 	
	private String printYn; 	
	private String viewSn; 		
	private String frstRegDttm; 	
	private String frstRegId; 	
	private String lastModDttm; 	
	private String lastModId; 	
	private String breakfastYn; 	
	private String buyNum; 		
	private String ableRsvNum;
	private String confRequestDttm; 
	private String confDttm;
	private String mappingNum;
	private String eventCnt;
	private String couponCnt;
	
	private String addamtYn;
	private String ctnAplYn;
	private String ctnAmt;	
	private String minRsvNight;
	private String maxRsvNight;
	
	
	private Integer newSn;
	private Integer oldSn;
	
	private List<CM_IMGVO> imgList;
	
	private String saleAmt;
	private String nmlAmt;
	private String hotdallYn;
	private String daypriceYn;
	private String daypriceAmt;
	private String disDaypriceAmt;
	
	private String ossMaster;
	
	private String fromDt;
	private String toDt;
	private String nights;
	private String searchYn;
	
	private String totMem;
	
	private String cmssRate;	// 정산 적용률
	
	private String adultAddAmt;
	private String juniorAddAmt;
	private String childAddAmt;
	
	private String roomNum;
	
	/*상품기한*/
	private String cntAplDt;
	private String amtAplDt;

	/** 탐나는전 예약가능 여부 **/
	private String tamnacardYn;

	/** 예약가능 여부 **/
	private String rsvAbleYn;

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
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getTradeStatus() {
		return tradeStatus;
	}
	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
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
	public String getPrdtExp() {
		return prdtExp;
	}
	public void setPrdtExp(String prdtExp) {
		this.prdtExp = prdtExp;
	}
	public String getMemExcdAbleYn() {
		return memExcdAbleYn;
	}
	public void setMemExcdAbleYn(String memExcdAbleYn) {
		this.memExcdAbleYn = memExcdAbleYn;
	}
	public String getPrintYn() {
		return printYn;
	}
	public void setPrintYn(String printYn) {
		this.printYn = printYn;
	}
	public String getViewSn() {
		return viewSn;
	}
	public void setViewSn(String viewSn) {
		this.viewSn = viewSn;
	}
	public String getFrstRegDttm() {
		return frstRegDttm;
	}
	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}
	public String getFrstRegId() {
		return frstRegId;
	}
	public void setFrstRegId(String frstRegId) {
		this.frstRegId = frstRegId;
	}
	public String getLastModDttm() {
		return lastModDttm;
	}
	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}
	public String getLastModId() {
		return lastModId;
	}
	public void setLastModId(String lastModId) {
		this.lastModId = lastModId;
	}
	public String getBreakfastYn() {
		return breakfastYn;
	}
	public void setBreakfastYn(String breakfastYn) {
		this.breakfastYn = breakfastYn;
	}
	public String getBuyNum() {
		return buyNum;
	}
	public void setBuyNum(String buyNum) {
		this.buyNum = buyNum;
	}
	public String getAbleRsvNum() {
		return ableRsvNum;
	}
	public void setAbleRsvNum(String ableRsvNum) {
		this.ableRsvNum = ableRsvNum;
	}
	public String getConfRequestDttm() {
		return confRequestDttm;
	}
	public void setConfRequestDttm(String confRequestDttm) {
		this.confRequestDttm = confRequestDttm;
	}
	public String getConfDttm() {
		return confDttm;
	}
	public void setConfDttm(String confDttm) {
		this.confDttm = confDttm;
	}
	public Integer getNewSn() {
		return newSn;
	}
	public void setNewSn(Integer newSn) {
		this.newSn = newSn;
	}
	public Integer getOldSn() {
		return oldSn;
	}
	public void setOldSn(Integer oldSn) {
		this.oldSn = oldSn;
	}
	public List<CM_IMGVO> getImgList() {
		return imgList;
	}
	public void setImgList(List<CM_IMGVO> imgList) {
		this.imgList = imgList;
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
	public String getOssMaster() {
		return ossMaster;
	}
	public void setOssMaster(String ossMaster) {
		this.ossMaster = ossMaster;
	}
	public String getMappingNum() {
		return mappingNum;
	}
	public void setMappingNum(String mappingNum) {
		this.mappingNum = mappingNum;
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
	public String getDisDaypriceAmt() {
		return disDaypriceAmt;
	}
	public void setDisDaypriceAmt(String disDaypriceAmt) {
		this.disDaypriceAmt = disDaypriceAmt;
	}
	public String getFromDt() {
		return fromDt;
	}
	public void setFromDt(String fromDt) {
		this.fromDt = fromDt;
	}
	public String getToDt() {
		return toDt;
	}
	public void setToDt(String toDt) {
		this.toDt = toDt;
	}
	public String getNights() {
		return nights;
	}
	public void setNights(String nights) {
		this.nights = nights;
	}
	public String getSearchYn() {
		return searchYn;
	}
	public void setSearchYn(String searchYn) {
		this.searchYn = searchYn;
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
	public String getAddamtYn() {
		return addamtYn;
	}
	public void setAddamtYn(String addamtYn) {
		this.addamtYn = addamtYn;
	}
	public String getCtnAplYn() {
		return ctnAplYn;
	}
	public void setCtnAplYn(String ctnAplYn) {
		this.ctnAplYn = ctnAplYn;
	}
	
	public String getCtnAmt() {
		return ctnAmt;
	}
	public void setCtnAmt(String ctnAmt) {
		this.ctnAmt = ctnAmt;
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
	public String getTotMem() {
		return totMem;
	}
	public void setTotMem(String totMem) {
		this.totMem = totMem;
	}
	public String getCmssRate() {
		return cmssRate;
	}
	public void setCmssRate(String cmssRate) {
		this.cmssRate = cmssRate;
	}
	public String getAdultAddAmt() {
		return adultAddAmt;
	}
	public void setAdultAddAmt(String adultAddAmt) {
		this.adultAddAmt = adultAddAmt;
	}
	public String getJuniorAddAmt() {
		return juniorAddAmt;
	}
	public void setJuniorAddAmt(String juniorAddAmt) {
		this.juniorAddAmt = juniorAddAmt;
	}
	public String getChildAddAmt() {
		return childAddAmt;
	}
	public void setChildAddAmt(String childAddAmt) {
		this.childAddAmt = childAddAmt;
	}
	public String getCntAplDt() {
		return cntAplDt;
	}
	public void setCntAplDt(String cntAplDt) {
		this.cntAplDt = cntAplDt;
	}
	public String getAmtAplDt() {
		return amtAplDt;
	}
	public void setAmtAplDt(String amtAplDt) {
		this.amtAplDt = amtAplDt;
	}
	public String getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
	}

	public String getTamnacardYn() {
		return tamnacardYn;
	}

	public void setTamnacardYn(String tamnacardYn) {
		this.tamnacardYn = tamnacardYn;
	}

	public String getRsvAbleYn() {
		return rsvAbleYn;
	}

	public void setRsvAbleYn(String rsvAbleYn) {
		this.rsvAbleYn = rsvAbleYn;
	}
}
