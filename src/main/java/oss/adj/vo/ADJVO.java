package oss.adj.vo;

public class ADJVO extends ADJSVO{

	/** 정산 일자  */
	private String adjDt;
	/** 업체 아이디  */
	private String corpId;
	/** 업체 명  */
	private String corpNm;
	/** 정산 상태 코드  */
	private String adjStatusCd;
	/** 판매 금액  */
	private String saleAmt;
	/** 할인 금액  */
	private String disAmt;
	/** 지원 할인 금액  */
	private String supportDisAmt;
	/** 미지원 할인 금액  */
	private String unsupportedDisAmt;
	/** 지원할인 포인트 금액*/
	private String supportedPointAmt;
	/** 미지원할인 포인트 금액*/
	private String unsupportedPointAmt;
	/** 수수료 금액  */
	private String cmssAmt;
	/** 판매 수수료  */
	private String saleCmss;
	/** 정산 금액  */
	private String adjAmt;
	/** 최종 정산 금액  */
	private String lastAdjAmt;
	/** 정산 예정 일자  */
	private String adjItdDt;
	/** 정산 완료 일자  */
	private String adjCmplDt;
	/** 최초 등록 일시  */
	private String frstRegDttm;
	/** 최종 수정 일시  */
	private String lastModDttm;
	/** 은행 명 */
	private String bankNm;
	/** 계좌 번호 */
	private String accNum;
	/** 예금주 */
	private String depositor;
	/** 비정상 정산건수 */
	private String modCnt;
	/** 쿠폰 금액 */
	private String adjCouponAmt;
	/** 포인트 금액 */
	private String adjPointAmt;
	/** 쿠폰 수수료 금액 */
	private String couponCmssAmt;
	/** 포인트 수수료 금액 */
	private String pointCmssAmt;
	/** 포인트 정산 금액*/
	private String pointJsYsAmt;
	/** 수수료율 */
	private String adjAplPct;
	/** 사업자등록번호 */
	private String coRegNum;
	/** 대표자명 */
	private String ceoNm;
	/** 대표자명 */
	private String bigo;
	/** 상품구분 */
	private String prdtDiv;
	/** 지원할인금액 정산금액 */
	private String disJsYsAmt;
	/** 지원할인금액 수수료 */
	private String disCmssAmt;
	/** 업체쿠폰지원금 */
	private String corpDisAmt;

	public String getAdjDt() {
		return adjDt;
	}
	public void setAdjDt(String adjDt) {
		this.adjDt = adjDt;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getAdjStatusCd() {
		return adjStatusCd;
	}
	public void setAdjStatusCd(String adjStatusCd) {
		this.adjStatusCd = adjStatusCd;
	}
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getCmssAmt() {
		return cmssAmt;
	}
	public void setCmssAmt(String cmssAmt) {
		this.cmssAmt = cmssAmt;
	}
	public String getSaleCmss() {
		return saleCmss;
	}
	public void setSaleCmss(String saleCmss) {
		this.saleCmss = saleCmss;
	}
	public String getAdjAmt() {
		return adjAmt;
	}
	public void setAdjAmt(String adjAmt) {
		this.adjAmt = adjAmt;
	}
	public String getLastAdjAmt() {
		return lastAdjAmt;
	}
	public void setLastAdjAmt(String lastAdjAmt) {
		this.lastAdjAmt = lastAdjAmt;
	}
	public String getAdjItdDt() {
		return adjItdDt;
	}
	public void setAdjItdDt(String adjItdDt) {
		this.adjItdDt = adjItdDt;
	}
	public String getAdjCmplDt() {
		return adjCmplDt;
	}
	public void setAdjCmplDt(String adjCmplDt) {
		this.adjCmplDt = adjCmplDt;
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
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getBankNm() {
		return bankNm;
	}
	public void setBankNm(String bankNm) {
		this.bankNm = bankNm;
	}
	public String getAccNum() {
		return accNum;
	}
	public void setAccNum(String accNum) {
		this.accNum = accNum;
	}
	public String getDepositor() {
		return depositor;
	}
	public void setDepositor(String depositor) {
		this.depositor = depositor;
	}
	public String getDisAmt() {
		return disAmt;
	}
	public void setDisAmt(String disAmt) {
		this.disAmt = disAmt;
	}
	public String getSupportDisAmt() {
		return supportDisAmt;
	}
	public void setSupportDisAmt(String supportDisAmt) {
		this.supportDisAmt = supportDisAmt;
	}
	public String getUnsupportedDisAmt() {
		return unsupportedDisAmt;
	}
	public void setUnsupportedDisAmt(String unsupportedDisAmt) {
		this.unsupportedDisAmt = unsupportedDisAmt;
	}
	public String getModCnt() {
		return modCnt;
	}
	public void setModCnt(String modCnt) {
		this.modCnt = modCnt;
	}
	public String getAdjCouponAmt() {
		return adjCouponAmt;
	}
	public void setAdjCouponAmt(String adjCouponAmt) {
		this.adjCouponAmt = adjCouponAmt;
	}
	public String getAdjPointAmt() {
		return adjPointAmt;
	}
	public void setAdjPointAmt(String adjPointAmt) {
		this.adjPointAmt = adjPointAmt;
	}
	public String getCouponCmssAmt() {
		return couponCmssAmt;
	}
	public void setCouponCmssAmt(String couponCmssAmt) {
		this.couponCmssAmt = couponCmssAmt;
	}
	public String getPointCmssAmt() {
		return pointCmssAmt;
	}
	public void setPointCmssAmt(String pointCmssAmt) {
		this.pointCmssAmt = pointCmssAmt;
	}

	public String getAdjAplPct() {
		return adjAplPct;
	}

	public void setAdjAplPct(String adjAplPct) {
		this.adjAplPct = adjAplPct;
	}

	public String getCoRegNum() {
		return coRegNum;
	}

	public void setCoRegNum(String coRegNum) {
		this.coRegNum = coRegNum;
	}

	public String getCeoNm() {
		return ceoNm;
	}

	public void setCeoNm(String ceoNm) {
		this.ceoNm = ceoNm;
	}

	public String getBigo() {
		return bigo;
	}

	public void setBigo(String bigo) {
		this.bigo = bigo;
	}
	public String getPrdtDiv() {
		return prdtDiv;
	}
	public void setPrdtDiv(String prdtDiv) {
		this.prdtDiv = prdtDiv;
	}

	public String getDisJsYsAmt() {
		return disJsYsAmt;
	}

	public void setDisJsYsAmt(String disJsYsAmt) {
		this.disJsYsAmt = disJsYsAmt;
	}

	public String getDisCmssAmt() {
		return disCmssAmt;
	}

	public void setDisCmssAmt(String disCmssAmt) {
		this.disCmssAmt = disCmssAmt;
	}

	public String getSupportedPointAmt() {
		return supportedPointAmt;
	}

	public void setSupportedPointAmt(String supportedPointAmt) {
		this.supportedPointAmt = supportedPointAmt;
	}

	public String getUnsupportedPointAmt() {
		return unsupportedPointAmt;
	}

	public void setUnsupportedPointAmt(String unsupportedPointAmt) {
		this.unsupportedPointAmt = unsupportedPointAmt;
	}

	public String getPointJsYsAmt() {
		return pointJsYsAmt;
	}

	public void setPointJsYsAmt(String pointJsYsAmt) {
		this.pointJsYsAmt = pointJsYsAmt;
	}

	public String getCorpDisAmt() {
		return corpDisAmt;
	}

	public void setCorpDisAmt(String corpDisAmt) {
		this.corpDisAmt = corpDisAmt;
	}
}
