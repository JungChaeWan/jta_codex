package web.product.vo;

public class WEB_DTLPRDTVO {
	/** 소셜 상품 번호 */
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
	/** 상품 구분 */
	private String prdtDiv;
	/** 상품 명 */
	private String prdtNm;
	/** 판매금액 */
	private String saleAmt;
	/**상품 정보 */
	private String prdtInf;
	/**사용 조건 */
	private String useQlfct;
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
	/** 할인 정보 */
	private String disInf;
	/** 취소 안내 */
	private String cancelGuide;

	/** 소셜상품 구분 순번 */
	private String spDivSn;
	/** 소셜상품 옵션 순번 */
	private String spOptSn;
	/** 옵션 명 */
	private String optNm;
	/** 상품 구분자 명 */
	private String prdtDivNm;
	/** 정상 금액 */
	private String nmlAmt;
	/** 적용 일자 */
	private String aplDt;
	/** 마감여부 */
	private String ddlYn;
	/** 재고 수량 ( 옵션 상품 수 - 판매수 ) */
	private String stockNum;
	/** 대표 이미지 저장경로 */
	private String savePath;
	/** 대표 이미지 파일명 */
	private String saveFileNm;

	private String exprStartDt;
	private String exprEndDt;

	/** 이벤트 갯수 */
	private Integer eventCnt;
	
	/** 할인쿠폰 갯수 */
	private Integer couponCnt;

	/** 미리보기 여부 */
	private String previewYn;

	private String exprDaynumYn;
	private Integer exprDaynum;
	private Integer useAbleTm;

	private String roadNmAddr;
	private String dtlAddr;

	private String superbCorpYn;

	/** LINK 상품 여부 */
	private String linkPrdtYn;
	/** LINK URL */
	private String linkUrl;

	/** 최초 등록일시 */
	private String frstRegDttm;
	/** 최종 수정일시 */
	private String lastModDttm;

	private String adMov;
	private String area;
	private String areaNm;
	private String visitMappingId;

	/** 탐나는전 예약가능 여부 **/
	private String tamnacardYn;

	private String apiImgThumb;

	private String apiImgDetail;

	private String lsLinkYn;

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

	public String getPrdtDiv() {
		return prdtDiv;
	}

	public void setPrdtDiv(String prdtDiv) {
		this.prdtDiv = prdtDiv;
	}

	public String getPrdtNm() {
		return prdtNm;
	}

	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
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

	public String getUseQlfct() {
		return useQlfct;
	}

	public void setUseQlfct(String useQlfct) {
		this.useQlfct = useQlfct;
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

	public String getDisInf() {
		return disInf;
	}

	public void setDisInf(String disInf) {
		this.disInf = disInf;
	}

	public String getSpDivSn() {
		return spDivSn;
	}

	public void setSpDivSn(String spDivSn) {
		this.spDivSn = spDivSn;
	}

	public String getSpOptSn() {
		return spOptSn;
	}

	public void setSpOptSn(String spOptSn) {
		this.spOptSn = spOptSn;
	}

	public String getAplDt() {
		return aplDt;
	}

	public void setAplDt(String aplDt) {
		this.aplDt = aplDt;
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

	public String getOptNm() {
		return optNm;
	}

	public void setOptNm(String optNm) {
		this.optNm = optNm;
	}

	public String getPrdtDivNm() {
		return prdtDivNm;
	}

	public void setPrdtDivNm(String prdtDivNm) {
		this.prdtDivNm = prdtDivNm;
	}

	public String getNmlAmt() {
		return nmlAmt;
	}

	public void setNmlAmt(String nmlAmt) {
		this.nmlAmt = nmlAmt;
	}

	public String getPreviewYn() {
		return previewYn;
	}

	public void setPreviewYn(String previewYn) {
		this.previewYn = previewYn;
	}

	public String getExprStartDt() {
		return exprStartDt;
	}

	public void setExprStartDt(String exprStartDt) {
		this.exprStartDt = exprStartDt;
	}

	public String getExprEndDt() {
		return exprEndDt;
	}

	public void setExprEndDt(String exprEndDt) {
		this.exprEndDt = exprEndDt;
	}

	public String getCancelGuide() {
		return cancelGuide;
	}

	public void setCancelGuide(String cancelGuide) {
		this.cancelGuide = cancelGuide;
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

	public String getExprDaynumYn() {
		return exprDaynumYn;
	}

	public void setExprDaynumYn(String exprDaynumYn) {
		this.exprDaynumYn = exprDaynumYn;
	}

	public Integer getExprDaynum() {
		return exprDaynum;
	}

	public void setExprDaynum(Integer exprDaynum) {
		this.exprDaynum = exprDaynum;
	}

	public Integer getUseAbleTm() {
		return useAbleTm;
	}

	public void setUseAbleTm(Integer useAbleTm) {
		this.useAbleTm = useAbleTm;
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

	public String getSuperbCorpYn() {
		return superbCorpYn;
	}

	public void setSuperbCorpYn(String superbCorpYn) {
		this.superbCorpYn = superbCorpYn;
	}

	public String getLinkPrdtYn() {
		return linkPrdtYn;
	}

	public void setLinkPrdtYn(String linkPrdtYn) {
		this.linkPrdtYn = linkPrdtYn;
	}

	public String getLinkUrl() {
		return linkUrl;
	}

	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
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

	public String getAdMov() {
		return adMov;
	}

	public void setAdMov(String adMov) {
		this.adMov = adMov;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getAreaNm() {
		return areaNm;
	}

	public void setAreaNm(String areaNm) {
		this.areaNm = areaNm;
	}

	public String getVisitMappingId() {
		return visitMappingId;
	}

	public void setVisitMappingId(String visitMappingId) {
		this.visitMappingId = visitMappingId;
	}

	public String getTamnacardYn() {
		return tamnacardYn;
	}

	public void setTamnacardYn(String tamnacardYn) {
		this.tamnacardYn = tamnacardYn;
	}

	public String getApiImgThumb() {
		return apiImgThumb;
	}

	public void setApiImgThumb(String apiImgThumb) {
		this.apiImgThumb = apiImgThumb;
	}

	public String getApiImgDetail() {
		return apiImgDetail;
	}

	public void setApiImgDetail(String apiImgDetail) {
		this.apiImgDetail = apiImgDetail;
	}

	public String getLsLinkYn() {
		return lsLinkYn;
	}

	public void setLsLinkYn(String lsLinkYn) {
		this.lsLinkYn = lsLinkYn;
	}
}