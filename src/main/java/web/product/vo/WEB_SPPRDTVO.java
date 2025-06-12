package web.product.vo;

import oss.cmm.vo.pageDefaultVO;

public class WEB_SPPRDTVO extends pageDefaultVO {
	/** 상품 번호 */
	private String prdtNum;
	/** 상품 명 */
	private String prdtNm;
	/** 업체 아이디 */
	private String corpId;
	/** 업체 명 */
	private String corpNm;
	/** 거래 상태 */
	private String tradeStatus;
	/** 거래 상태명 */
	private String tradeStatusNm;
	/** 승인 요청 일시 */
	private String confRequestDttm;
	/** 승인 일시 */
	private String confDttm;
	/** 정상가 */
	private String nmlAmt;
	/** 판매가 */
	private String saleAmt;
	/** 할인율 */
	private String disPer;
	/** 대표 이미지 저장경로 */
	private String savePath;
	/** 대표 이미지 파일명 */
	private String saveFileNm;
	/** 프로모션 명 */
	private String promotionNm;
	/** 카테고리 */
	private String ctgr;
	/** 카테고리 명 */
	private String ctgrNm;
	/** 소셜상품 구분 순번 */
	private String spDivSn;
	/** 소셜상품 옵션 순번 */
	private String spOptSn;
	/** 판매 수 */
	private String saleNum;
	/** 상품 구분 */
	private String prdtDiv;
	/** 상품 수량 */
	private String prdtCount;
	/** 평점 평균 */
	private String gpaAvg;
	private String prdtInf;

	private Integer qty;

	private Integer eventCnt;
	
	private Integer couponCnt;

	/** 유효 시작 일자 */
	private String exprStartDt;
	/** 유효 종료 일자 */
	private String exprEndDt;
	/** 이용가능시간 */
	private Integer useAbleTm;

	/** 유효일수 여부 */
	private String exprDaynumYn;

	/** 유효일수 */
	private Integer exprDaynum;

	private String prdtDivNm;

	private String optNm;

	private String printSn;
	
	private String advRvYn;
	
	/** 베스트상품 프로모션 내용 */
	private String prmtContents;
	
	private String superbCorpYn;

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

	public String getCorpNm() {
		return corpNm;
	}

	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}

	public String getTradeStatus() {
		return tradeStatus;
	}

	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
	}

	public String getTradeStatusNm() {
		return tradeStatusNm;
	}

	public void setTradeStatusNm(String tradeStatusNm) {
		this.tradeStatusNm = tradeStatusNm;
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

	public String getDisPer() {
		return disPer;
	}

	public void setDisPer(String disPer) {
		this.disPer = disPer;
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
	public String getPromotionNm() {
		return promotionNm;
	}

	public void setPromotionNm(String promotionNm) {
		this.promotionNm = promotionNm;
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

	public String getSaleNum() {
		return saleNum;
	}

	public void setSaleNum(String saleNum) {
		this.saleNum = saleNum;
	}

	public String getPrdtDiv() {
		return prdtDiv;
	}

	public void setPrdtDiv(String prdtDiv) {
		this.prdtDiv = prdtDiv;
	}

	public String getPrdtCount() {
		return prdtCount;
	}

	public void setPrdtCount(String prdtCount) {
		this.prdtCount = prdtCount;
	}

	public String getGpaAvg() {
		return gpaAvg;
	}

	public void setGpaAvg(String gpaAvg) {
		this.gpaAvg = gpaAvg;
	}

	public String getPrdtInf() {
		return prdtInf;
	}

	public void setPrdtInf(String prdtInf) {
		this.prdtInf = prdtInf;
	}

	public Integer getQty() {
		return qty;
	}

	public void setQty(Integer qty) {
		this.qty = qty;
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

	public Integer getUseAbleTm() {
		return useAbleTm;
	}

	public void setUseAbleTm(Integer useAbleTm) {
		this.useAbleTm = useAbleTm;
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

	public String getPrdtDivNm() {
		return prdtDivNm;
	}

	public void setPrdtDivNm(String prdtDivNm) {
		this.prdtDivNm = prdtDivNm;
	}

	public String getOptNm() {
		return optNm;
	}

	public void setOptNm(String optNm) {
		this.optNm = optNm;
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

	public String getAdvRvYn() {
		return advRvYn;
	}

	public void setAdvRvYn(String advRvYn) {
		this.advRvYn = advRvYn;
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