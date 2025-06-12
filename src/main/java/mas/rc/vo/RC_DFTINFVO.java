package mas.rc.vo;

public class RC_DFTINFVO extends RC_DFTINFSVO{

	/** 업체 아이디 */
	private String corpId;
	/** 렌트카 명 */
	private String rcNm;
	/** 렌트카 간략 설명 */
	private String rcSimpleExp;
	/** 렌트카 정보 */
	private String rcInf;
	/** 총 구매 수 */
	private String totalBuyNum;
	/** 주말 할인율 적용 여부 */
	private String wkdDisPerAplYn;
	/** 주말 할인율 적용 요일 */
	private String wkdDisPerAplWeek;
	/** 추가 이용 가능 시간 */
	private String addUseAbleTm;
	/** 추가 이용 최대 시간 */
	private String addUseMaxiTm;
	/** 추가 이용 적용 시간 */
	private String addUseAplTm;
	/** 예약 가능 최소 시간 */
	private String rsvAbleMiniTm;
	/** 할인율 적용 시간 */
	private String disPerAplTm;
	/** 대여 기준 정보 */
	private String rntStdInf;
	/** 차량  인수 정보 */
	private String carTkovInf;
	/** 참고사항 */
	private String nti;
	/** 취소 안내 */
	private String cancelGuide;
	/** 최초 등록 일시 */
	private String frstRegDttm;
	/** 최초 등록 아이디 */
	private String frstRegId;
	/** 최종 수정 일시 */
	private String lastModDttm;
	/** 최종 수정 아이디 */
	private String lastModId;
	/** 보험 공통 안내 */
	private String isrCmGuide;
	/** 추가 이용 할인율 적용 여부 */
	private String addUseDisPerAplYn;
	/** 당일 예약 불가 여부 */
	private String dayRsvUnableYn;
	/** 당일 예약 불가 시간 */
	private String dayRsvUnableTm;
	/** 예약 최대 시간 적용 여부 */
	private String rsvMaxiTmAplYn;
	/** 예약 최대 시간 */
	private String rsvMaxiTm;

	private String tkovRoadNmAddr;
	private String tkovDtlAddr;
	private String tkovLon;
	private String tkovLat;

	private String shutZone1;
	private String shutZone2;
	private String shutRunTm;
	private String shutRunInter;
	private String shutCostTm;
	private String tkovTm;
	private String rtnTm;

	/**인수시간, 반납시간 **/
	private String tkovMaxTm;
	private String tkovMinTm;
	private String rtnMaxTm;
	private String rtnMinTm;

	/** 홍보영상 URL */
	private String sccUrl;
	private String cancelAbleTm;

	/** 입금가/판매가 */
	private String sellLink;

	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getRcNm() {
		return rcNm;
	}
	public void setRcNm(String rcNm) {
		this.rcNm = rcNm;
	}
	public String getRcSimpleExp() {
		return rcSimpleExp;
	}
	public void setRcSimpleExp(String rcSimpleExp) {
		this.rcSimpleExp = rcSimpleExp;
	}
	public String getRcInf() {
		return rcInf;
	}
	public void setRcInf(String rcInf) {
		this.rcInf = rcInf;
	}
	public String getTotalBuyNum() {
		return totalBuyNum;
	}
	public void setTotalBuyNum(String totalBuyNum) {
		this.totalBuyNum = totalBuyNum;
	}
	public String getWkdDisPerAplYn() {
		return wkdDisPerAplYn;
	}
	public void setWkdDisPerAplYn(String wkdDisPerAplYn) {
		this.wkdDisPerAplYn = wkdDisPerAplYn;
	}
	public String getWkdDisPerAplWeek() {
		return wkdDisPerAplWeek;
	}
	public void setWkdDisPerAplWeek(String wkdDisPerAplWeek) {
		this.wkdDisPerAplWeek = wkdDisPerAplWeek;
	}
	public String getAddUseAbleTm() {
		return addUseAbleTm;
	}
	public void setAddUseAbleTm(String addUseAbleTm) {
		this.addUseAbleTm = addUseAbleTm;
	}
	public String getAddUseMaxiTm() {
		return addUseMaxiTm;
	}
	public void setAddUseMaxiTm(String addUseMaxiTm) {
		this.addUseMaxiTm = addUseMaxiTm;
	}
	public String getAddUseAplTm() {
		return addUseAplTm;
	}
	public void setAddUseAplTm(String addUseAplTm) {
		this.addUseAplTm = addUseAplTm;
	}
	public String getRsvAbleMiniTm() {
		return rsvAbleMiniTm;
	}
	public void setRsvAbleMiniTm(String rsvAbleMiniTm) {
		this.rsvAbleMiniTm = rsvAbleMiniTm;
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
	public String getRntStdInf() {
		return rntStdInf;
	}
	public void setRntStdInf(String rntStdInf) {
		this.rntStdInf = rntStdInf;
	}
	public String getCarTkovInf() {
		return carTkovInf;
	}
	public void setCarTkovInf(String carTkovInf) {
		this.carTkovInf = carTkovInf;
	}
	public String getNti() {
		return nti;
	}
	public void setNti(String nti) {
		this.nti = nti;
	}
	public String getDisPerAplTm() {
		return disPerAplTm;
	}
	public void setDisPerAplTm(String disPerAplTm) {
		this.disPerAplTm = disPerAplTm;
	}
	public String getCancelGuide() {
		return cancelGuide;
	}
	public void setCancelGuide(String cancelGuide) {
		this.cancelGuide = cancelGuide;
	}
	public String getIsrCmGuide() {
		return isrCmGuide;
	}
	public void setIsrCmGuide(String isrCmGuide) {
		this.isrCmGuide = isrCmGuide;
	}
	public String getAddUseDisPerAplYn() {
		return addUseDisPerAplYn;
	}
	public void setAddUseDisPerAplYn(String addUseDisPerAplYn) {
		this.addUseDisPerAplYn = addUseDisPerAplYn;
	}
	public String getDayRsvUnableYn() {
		return dayRsvUnableYn;
	}
	public void setDayRsvUnableYn(String dayRsvUnableYn) {
		this.dayRsvUnableYn = dayRsvUnableYn;
	}
	public String getDayRsvUnableTm() {
		return dayRsvUnableTm;
	}
	public void setDayRsvUnableTm(String dayRsvUnableTm) {
		this.dayRsvUnableTm = dayRsvUnableTm;
	}
	public String getRsvMaxiTmAplYn() {
		return rsvMaxiTmAplYn;
	}
	public void setRsvMaxiTmAplYn(String rsvMaxiTmAplYn) {
		this.rsvMaxiTmAplYn = rsvMaxiTmAplYn;
	}
	public String getRsvMaxiTm() {
		return rsvMaxiTm;
	}
	public void setRsvMaxiTm(String rsvMaxiTm) {
		this.rsvMaxiTm = rsvMaxiTm;
	}
	public String getTkovRoadNmAddr() {
		return tkovRoadNmAddr;
	}
	public void setTkovRoadNmAddr(String tkovRoadNmAddr) {
		this.tkovRoadNmAddr = tkovRoadNmAddr;
	}
	public String getTkovDtlAddr() {
		return tkovDtlAddr;
	}
	public void setTkovDtlAddr(String tkovDtlAddr) {
		this.tkovDtlAddr = tkovDtlAddr;
	}
	public String getTkovLon() {
		return tkovLon;
	}
	public void setTkovLon(String tkovLon) {
		this.tkovLon = tkovLon;
	}
	public String getTkovLat() {
		return tkovLat;
	}
	public void setTkovLat(String tkovLat) {
		this.tkovLat = tkovLat;
	}
	public String getShutZone1() {
		return shutZone1;
	}
	public void setShutZone1(String shutZone1) {
		this.shutZone1 = shutZone1;
	}
	public String getShutZone2() {
		return shutZone2;
	}
	public void setShutZone2(String shutZone2) {
		this.shutZone2 = shutZone2;
	}
	public String getShutRunTm() {
		return shutRunTm;
	}
	public void setShutRunTm(String shutRunTm) {
		this.shutRunTm = shutRunTm;
	}
	public String getShutRunInter() {
		return shutRunInter;
	}
	public void setShutRunInter(String shutRunInter) {
		this.shutRunInter = shutRunInter;
	}
	public String getShutCostTm() {
		return shutCostTm;
	}
	public void setShutCostTm(String shutCostTm) {
		this.shutCostTm = shutCostTm;
	}
	public String getTkovTm() {
		return tkovTm;
	}
	public void setTkovTm(String tkovTm) {
		this.tkovTm = tkovTm;
	}
	public String getRtnTm() {
		return rtnTm;
	}
	public void setRtnTm(String rtnTm) {
		this.rtnTm = rtnTm;
	}
	public String getSccUrl() {
		return sccUrl;
	}
	public void setSccUrl(String sccUrl) {
		this.sccUrl = sccUrl;
	}

	public String getTkovMaxTm() {
		return tkovMaxTm;
	}

	public void setTkovMaxTm(String tkovMaxTm) {
		this.tkovMaxTm = tkovMaxTm;
	}

	public String getTkovMinTm() {
		return tkovMinTm;
	}

	public void setTkovMinTm(String tkovMinTm) {
		this.tkovMinTm = tkovMinTm;
	}

	public String getRtnMaxTm() {
		return rtnMaxTm;
	}

	public void setRtnMaxTm(String rtnMaxTm) {
		this.rtnMaxTm = rtnMaxTm;
	}

	public String getRtnMinTm() {
		return rtnMinTm;
	}

	public void setRtnMinTm(String rtnMinTm) {
		this.rtnMinTm = rtnMinTm;
	}

	public String getCancelAbleTm() {
		return cancelAbleTm;
	}

	public void setCancelAbleTm(String cancelAbleTm) {
		this.cancelAbleTm = cancelAbleTm;
	}

	public String getSellLink() {
		return sellLink;
	}

	public void setSellLink(String sellLink) {
		this.sellLink = sellLink;
	}
}
