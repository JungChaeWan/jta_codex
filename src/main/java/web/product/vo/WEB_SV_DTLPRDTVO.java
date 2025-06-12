package web.product.vo;

public class WEB_SV_DTLPRDTVO {

	/** 기념품 번호 */
	private String prdtNum;
	/** 업체 아이디 */
	private String corpId;
	/** 업체 명 */
	private String corpNm;
	/** 상호명 */
	private String shopNm;
	/** 업체 예약 전화번호 */
	private String rsvTelNum;
	/** 업체 광고 이미지 */
	private String adtmImg;
	/** 업체 광고 URL */
	private String adtmUrl;
	/** 광고 간략 설명 */
	private String adtmSimpleExp;
	/** 카테고리 */
	private String ctgr;
	/** 카테고리 명 */
	private String ctgrNm;
	/** 서브 카테고리 */
	private String subCtgr;
	/** 상품 명 */
	private String prdtNm;
	/** 생산자 */
	private String prdc;
	/** 원산지 */
	private String org;
	/** 판매금액 */
	private String saleAmt;
	/** 상품 정보 */
	private String prdtInf;
	/** 판매 건수 */
	private String saleNum;
	/** 판매 시작일자 */
	private String saleStartDt;
	/** 판매 종료일자 */
	private String saleEndDt;
	/** 경도 */
	private String lon;
	/** 위도 */
	private String lat;
	/** 취급 주의사항 */
	private String hdlPrct;
	/** 배송안내 */
	private String dlvGuide;
	/** 취소 안내 */
	private String cancelGuide;
	/** 반품안내 */
	private String tkbkGuide;

	/** 기념품 구분 순번 */
	private String svDivSn;
	/** 기념품 옵션 순번 */
	private String svOptSn;
	/** 옵션 명 */
	private String optNm;
	/** 정상 금액 */
	private String nmlAmt;
	/** 마감여부 */
	private String ddlYn;
	/** 재고 수량 ( 옵션 상품 수 - 판매수 ) */
	private String stockNum;
	/** 대표 이미지 저장경로 */
	private String savePath;
	/** 대표 이미지 파일명 */
	private String saveFileNm;

	/** 이벤트 갯수 */
	private Integer eventCnt;
	
	/** 할인쿠폰 적용 갯수 */
	private Integer couponCnt;

	/** 미리보기 여부 */
	private String previewYn;

	private String roadNmAddr;
	private String dtlAddr;

	/** 구분자 명 */
	private String prdtDivNm;

	/** 우수관광기념품 */
	private String superbSvYn;
	/** JQ인증기념품 */
	private String jqYn;

	private String dlvAmtDiv;
	private String dlvAmt;
	private String inDlvAmt;
	private String maxiBuyNum;
	private String aplAmt;
	private String prdtExp;

	private String superbCorpYn;

	/** 최초 등록 일시 */
	private String frstRegDttm;
	/** 최종 수정 일시 */
	private String lastModDttm;

	private String directRecvYn;
	private String deliveryYn;
	private String adMov;

	/** 탐나는전 예약가능 여부 **/
	private String tamnacardYn;

	public String getPrdtNum() {
		return prdtNum;
	}

	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}

	public String getCorpNm() {
		return corpNm;
	}

	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}

	public String getShopNm() {
		return shopNm;
	}

	public void setShopNm(String shopNm) {
		this.shopNm = shopNm;
	}

	public String getRsvTelNum() {
		return rsvTelNum;
	}

	public void setRsvTelNum(String rsvTelNum) {
		this.rsvTelNum = rsvTelNum;
	}

	public String getAdtmImg() {
		return adtmImg;
	}

	public void setAdtmImg(String adtmImg) {
		this.adtmImg = adtmImg;
	}

	public String getAdtmUrl() {
		return adtmUrl;
	}

	public void setAdtmUrl(String adtmUrl) {
		this.adtmUrl = adtmUrl;
	}

	public String getAdtmSimpleExp() {
		return adtmSimpleExp;
	}

	public void setAdtmSimpleExp(String adtmSimpleExp) {
		this.adtmSimpleExp = adtmSimpleExp;
	}

	public String getCtgr() {
		return ctgr;
	}

	public void setCtgr(String ctgr) {
		this.ctgr = ctgr;
	}

	public String getCtgrNm() {
		return ctgrNm;
	}

	public void setCtgrNm(String ctgrNm) {
		this.ctgrNm = ctgrNm;
	}

	public String getSubCtgr() {
		return subCtgr;
	}

	public void setSubCtgr(String subCtgr) {
		this.subCtgr = subCtgr;
	}

	public String getPrdtNm() {
		return prdtNm;
	}

	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}

	public String getPrdc() {
		return prdc;
	}

	public void setPrdc(String prdc) {
		this.prdc = prdc;
	}

	public String getOrg() {
		return org;
	}

	public void setOrg(String org) {
		this.org = org;
	}

	public String getSaleAmt() {
		return saleAmt;
	}

	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}

	public String getPrdtInf() {
		return prdtInf;
	}

	public void setPrdtInf(String prdtInf) {
		this.prdtInf = prdtInf;
	}

	public String getSaleNum() {
		return saleNum;
	}

	public void setSaleNum(String saleNum) {
		this.saleNum = saleNum;
	}

	public String getSaleStartDt() {
		return saleStartDt;
	}

	public void setSaleStartDt(String saleStartDt) {
		this.saleStartDt = saleStartDt;
	}

	public String getSaleEndDt() {
		return saleEndDt;
	}

	public void setSaleEndDt(String saleEndDt) {
		this.saleEndDt = saleEndDt;
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

	public String getHdlPrct() {
		return hdlPrct;
	}

	public void setHdlPrct(String hdlPrct) {
		this.hdlPrct = hdlPrct;
	}

	public String getDlvGuide() {
		return dlvGuide;
	}

	public void setDlvGuide(String dlvGuide) {
		this.dlvGuide = dlvGuide;
	}

	public String getCancelGuide() {
		return cancelGuide;
	}

	public void setCancelGuide(String cancelGuide) {
		this.cancelGuide = cancelGuide;
	}

	public String getTkbkGuide() {
		return tkbkGuide;
	}

	public void setTkbkGuide(String tkbkGuide) {
		this.tkbkGuide = tkbkGuide;
	}

	public String getSvDivSn() {
		return svDivSn;
	}

	public void setSvDivSn(String svDivSn) {
		this.svDivSn = svDivSn;
	}

	public String getSvOptSn() {
		return svOptSn;
	}

	public void setSvOptSn(String svOptSn) {
		this.svOptSn = svOptSn;
	}

	public String getOptNm() {
		return optNm;
	}

	public void setOptNm(String optNm) {
		this.optNm = optNm;
	}

	public String getNmlAmt() {
		return nmlAmt;
	}

	public void setNmlAmt(String nmlAmt) {
		this.nmlAmt = nmlAmt;
	}

	public String getDdlYn() {
		return ddlYn;
	}

	public void setDdlYn(String ddlYn) {
		this.ddlYn = ddlYn;
	}

	public String getStockNum() {
		return stockNum;
	}

	public void setStockNum(String stockNum) {
		this.stockNum = stockNum;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String getSaveFileNm() {
		return saveFileNm;
	}

	public void setSaveFileNm(String saveFileNm) {
		this.saveFileNm = saveFileNm;
	}

	public Integer getEventCnt() {
		return eventCnt;
	}

	public void setEventCnt(Integer eventCnt) {
		this.eventCnt = eventCnt;
	}

	public Integer getCouponCnt() {
		return couponCnt;
	}

	public void setCouponCnt(Integer couponCnt) {
		this.couponCnt = couponCnt;
	}

	public String getPreviewYn() {
		return previewYn;
	}

	public void setPreviewYn(String previewYn) {
		this.previewYn = previewYn;
	}

	public String getRoadNmAddr() {
		return roadNmAddr;
	}

	public void setRoadNmAddr(String roadNmAddr) {
		this.roadNmAddr = roadNmAddr;
	}

	public String getDtlAddr() {
		return dtlAddr;
	}

	public void setDtlAddr(String dtlAddr) {
		this.dtlAddr = dtlAddr;
	}

	public String getPrdtDivNm() {
		return prdtDivNm;
	}

	public void setPrdtDivNm(String prdtDivNm) {
		this.prdtDivNm = prdtDivNm;
	}

	public String getSuperbSvYn() {
		return superbSvYn;
	}

	public void setSuperbSvYn(String superbSvYn) {
		this.superbSvYn = superbSvYn;
	}

	public String getDlvAmtDiv() {
		return dlvAmtDiv;
	}

	public void setDlvAmtDiv(String dlvAmtDiv) {
		this.dlvAmtDiv = dlvAmtDiv;
	}

	public String getDlvAmt() {
		return dlvAmt;
	}

	public void setDlvAmt(String dlvAmt) {
		this.dlvAmt = dlvAmt;
	}

	public String getMaxiBuyNum() {
		return maxiBuyNum;
	}

	public void setMaxiBuyNum(String maxiBuyNum) {
		this.maxiBuyNum = maxiBuyNum;
	}

	public String getAplAmt() {
		return aplAmt;
	}

	public void setAplAmt(String aplAmt) {
		this.aplAmt = aplAmt;
	}

	public String getPrdtExp() {
		return prdtExp;
	}

	public void setPrdtExp(String prdtExp) {
		this.prdtExp = prdtExp;
	}

	public String getSuperbCorpYn() {
		return superbCorpYn;
	}

	public void setSuperbCorpYn(String superbCorpYn) {
		this.superbCorpYn = superbCorpYn;
	}

	public String getJqYn() {
		return jqYn;
	}

	public void setJqYn(String jqYn) {
		this.jqYn = jqYn;
	}

	public String getFrstRegDttm() {
		return frstRegDttm;
	}

	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}

	public String getLastModDttm() {
		return lastModDttm;
	}

	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}

	public String getDirectRecvYn() {
		return directRecvYn;
	}

	public void setDirectRecvYn(String directRecvYn) {
		this.directRecvYn = directRecvYn;
	}

	public String getDeliveryYn() {
		return deliveryYn;
	}

	public void setDeliveryYn(String deliveryYn) {
		this.deliveryYn = deliveryYn;
	}

	public String getAdMov() {
		return adMov;
	}

	public void setAdMov(String adMov) {
		this.adMov = adMov;
	}

	public String getInDlvAmt() {
		return inDlvAmt;
	}

	public void setInDlvAmt(String inDlvAmt) {
		this.inDlvAmt = inDlvAmt;
	}

	public String getTamnacardYn() {
		return tamnacardYn;
	}

	public void setTamnacardYn(String tamnacardYn) {
		this.tamnacardYn = tamnacardYn;
	}
}
