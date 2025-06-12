package web.product.vo;

import oss.cmm.vo.pageDefaultVO;

public class WEB_SVPRDTVO extends pageDefaultVO {
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
	/** 기념품 구분 순번 */
	private String svDivSn;
	/** 기념품 옵션 순번 */
	private String svOptSn;
	/** 판매 수 */
	private String saleNum;
	/** 상품 수량 */
	private String prdtCount;
	/** 평점 평균 */
	private String gpaAvg;
	private String prdtInf;

	/** 수량 */
	private Integer qty;

	/** 이벤트 수 */
	private Integer eventCnt;
	
	/** 할인쿠폰 수 */
	private Integer couponCnt;

	/** 옵션명 */
	private String optNm;

	/** 구분자 명 */
	private String prdtDivNm;

	/** 우수관광기념품 */
	private String superbSvYn;
	/** JQ인증기념품 */
	private String jqYn;

	/** 서브 카테고리 */
	private String subCtgr;

	private String printSn;
	
	private String corpCd;
	private String corpAliasNm;
	private String prtinYn;
	private String regDttm;
	private String modDttm;

	/** 탐나는전 예약가능 여부 **/
	private String tamnacardYn;

	/** 우수관광사업체 여부 **/
	private String superbCorpYn;

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

	public String getSaleNum() {
		return saleNum;
	}

	public void setSaleNum(String saleNum) {
		this.saleNum = saleNum;
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

	public String getSuperbSvYn() {
		return superbSvYn;
	}

	public void setSuperbSvYn(String superbSvYn) {
		this.superbSvYn = superbSvYn;
	}

	public String getJqYn() {
		return jqYn;
	}

	public void setJqYn(String jqYn) {
		this.jqYn = jqYn;
	}

	public String getSubCtgr() {
		return subCtgr;
	}

	public void setSubCtgr(String subCtgr) {
		this.subCtgr = subCtgr;
	}

	public String getPrintSn() {
		return printSn;
	}

	public void setPrintSn(String printSn) {
		this.printSn = printSn;
	}

	public String getCorpCd() {
		return corpCd;
	}

	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}

	public String getCorpAliasNm() {
		return corpAliasNm;
	}

	public void setCorpAliasNm(String corpAliasNm) {
		this.corpAliasNm = corpAliasNm;
	}

	public String getPrtinYn() {
		return prtinYn;
	}

	public void setPrtinYn(String prtinYn) {
		this.prtinYn = prtinYn;
	}

	public String getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}

	public String getModDttm() {
		return modDttm;
	}

	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}

	public String getTamnacardYn() {
		return tamnacardYn;
	}

	public void setTamnacardYn(String tamnacardYn) {
		this.tamnacardYn = tamnacardYn;
	}

	public String getSuperbCorpYn() {
		return superbCorpYn;
	}

	public void setSuperbCorpYn(String superbCorpYn) {
		this.superbCorpYn = superbCorpYn;
	}
}
