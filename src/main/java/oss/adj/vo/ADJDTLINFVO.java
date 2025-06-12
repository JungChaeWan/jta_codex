package oss.adj.vo;

public class ADJDTLINFVO {

	/** 정산 상세 번호 */
	private String adjDtlNum;
	/** 상세 예약 번호 */
	private String dtlRsvNum;
	/** 예약 상태 코드 */
	private String rsvStatusCd;
	/** 정산 일자 */
	private String adjDt;
	/** 업체 아이디 */
	private String corpId;
	/** 업체 명 */
	private String corpNm;
	/** 상품 번호 */
	private String prdtNum;
	/** 상품 명 */
	private String prdtNm;
	/** 상품 정보 */
	private String prdtInf;
	/** 판매 금액 */
	private String saleAmt;
	/** 할인 금액 */
	private String disAmt;
	/** 지원 할인 금액  */
	private String supportDisAmt;
	/** 미지원 할인 금액  */
	private String unsupportedDisAmt;
	/** 수수료 금액 */
	private String cmssAmt;
	/** 판매 수수료 */
	private String saleCmss;
	/** 수정 여부 */
	private String modYn;
	/** 수정 사유 */
	private String modRsn;
	/** 결제 구분 */
	private String payDiv;
	/** 예약자명 */
	private String rsvNm;
	/** 예약번호 */
	private String rsvNum;
	/** L.Point 사용 여부 */
	private String lpointUseFlag;
	/** L.Point 적립 여부 */
	private String lpointSaveFlag;
	/** Lpoint 사용 취소여부*/
	private String lpointUseCancelFlag;
	/** L.Point 사용 금액 */
	private String lpointUsePoint;
	/** 정산 적용 비율 */
	private String adjAplPct;
	/** 정산 상태 코드 */
	private String adjStatusCd;
	/** 쿠폰 정산 금액 */
	private String adjCouponAmt;
	/** 포인트 정산 금액 */
	private String adjPointAmt;
	/** 쿠폰 수수료 금액 */
	private String couponCmssAmt;
	/** 상품권명*/
	private String vcNm;
	/** 쿠폰명*/
	private String cpNm;
	/** 상품구분*/
	private String prdtDiv;	
	/** 실제금액*/
	private String realAmt;
	/** PG사 수수료*/
	private String pgCmssAmt;
	/** PG사 협회 입금금액*/
	private String pgDepositAmt;
	/** 업체정산 대상금액*/
	private String masJsYsAmt;
	/** 협회 실수익*/
	private String realProfit;
	/** 앱구분*/
	private String appDiv;
	/** 지원할인금액 정산금액 */
	private String disJsYsAmt;
	/** 지원할인금액 수수료 */
	private String disCmssAmt;
	/** 지원할인 포인트명 */
	private String partnerNm;
	/** 지원할인 포인트금액 */
	private String supportedPointAmt;
	/** 지원할인 포인트금액 */
	private String unsupportedPointAmt;
	/** 포인트 수수료 금액 */
	private String pointCmssAmt;
	/** 포인트 정산액 */
	private String pointJsYsAmt;
	/** 포인트 정산액 */
	private String rsvEmail;
	/** 업체쿠폰지원금  */
	private String corpDisAmt;


	public void setCmssAmt(String cmssAmt) {
		this.cmssAmt = cmssAmt;
	}
	public String getCmssAmt() {
		return cmssAmt;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setDtlRsvNum(String dtlRsvNum) {
		this.dtlRsvNum = dtlRsvNum;
	}
	public String getDtlRsvNum() {
		return dtlRsvNum;
	}
	public void setAdjDt(String adjDt) {
		this.adjDt = adjDt;
	}
	public String getAdjDt() {
		return adjDt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setAdjDtlNum(String adjDtlNum) {
		this.adjDtlNum = adjDtlNum;
	}
	public String getAdjDtlNum() {
		return adjDtlNum;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setSaleCmss(String saleCmss) {
		this.saleCmss = saleCmss;
	}
	public String getSaleCmss() {
		return saleCmss;
	}
	public void setPrdtInf(String prdtInf) {
		this.prdtInf = prdtInf;
	}
	public String getPrdtInf() {
		return prdtInf;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getPrdtNum() {
		return prdtNum;
	}
	public void setRsvStatusCd(String rsvStatusCd) {
		this.rsvStatusCd = rsvStatusCd;
	}
	public String getRsvStatusCd() {
		return rsvStatusCd;
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
	public String getPayDiv() {
		return payDiv;
	}
	public void setPayDiv(String payDiv) {
		this.payDiv = payDiv;
	}
	public String getRsvNm() {
		return rsvNm;
	}
	public void setRsvNm(String rsvNm) {
		this.rsvNm = rsvNm;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getRsvNum() {
		return rsvNum;
	}
	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}
	public String getLpointUseFlag() {
		return lpointUseFlag;
	}
	public void setLpointUseFlag(String lpointUseFlag) {
		this.lpointUseFlag = lpointUseFlag;
	}
	public String getLpointSaveFlag() {
		return lpointSaveFlag;
	}
	public void setLpointSaveFlag(String lpointSaveFlag) {
		this.lpointSaveFlag = lpointSaveFlag;
	}
	public String getModYn() {
		return modYn;
	}
	public void setModYn(String modYn) {
		this.modYn = modYn;
	}
	public String getModRsn() {
		return modRsn;
	}
	public void setModRsn(String modRsn) {
		this.modRsn = modRsn;
	}
	public String getAdjAplPct() {
		return adjAplPct;
	}
	public void setAdjAplPct(String adjAplPct) {
		this.adjAplPct = adjAplPct;
	}
	public String getAdjStatusCd() {
		return adjStatusCd;
	}
	public void setAdjStatusCd(String adjStatusCd) {
		this.adjStatusCd = adjStatusCd;
	}
	public String getLpointUsePoint() {
		return lpointUsePoint;
	}
	public void setLpointUsePoint(String lpointUsePoint) {
		this.lpointUsePoint = lpointUsePoint;
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
	public String getVcNm() {
		return vcNm;
	}
	public void setVcNm(String vcNm) {
		this.vcNm = vcNm;
	}
	public String getLpointUseCancelFlag() {
		return lpointUseCancelFlag;
	}
	public void setLpointUseCancelFlag(String lpointUseCancelFlag) {
		this.lpointUseCancelFlag = lpointUseCancelFlag;
	}

	public String getCpNm() {
		return cpNm;
	}

	public void setCpNm(String cpNm) {
		this.cpNm = cpNm;
	}

	public String getPrdtDiv() {
		return prdtDiv;
	}

	public void setPrdtDiv(String prdtDiv) {
		this.prdtDiv = prdtDiv;
	}
	public String getRealAmt() {
		return realAmt;
	}
	public void setRealAmt(String realAmt) {
		this.realAmt = realAmt;
	}
	public String getPgCmssAmt() {
		return pgCmssAmt;
	}
	public void setPgCmssAmt(String pgCmssAmt) {
		this.pgCmssAmt = pgCmssAmt;
	}
	public String getPgDepositAmt() {
		return pgDepositAmt;
	}
	public void setPgDepositAmt(String pgDepositAmt) {
		this.pgDepositAmt = pgDepositAmt;
	}
	public String getMasJsYsAmt() {
		return masJsYsAmt;
	}
	public void setMasJsYsAmt(String masJsYsAmt) {
		this.masJsYsAmt = masJsYsAmt;
	}
	public String getRealProfit() {
		return realProfit;
	}
	public void setRealProfit(String realProfit) {
		this.realProfit = realProfit;
	}

	public String getAppDiv() {
		return appDiv;
	}

	public void setAppDiv(String appDiv) {
		this.appDiv = appDiv;
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

	public String getPartnerNm() {
		return partnerNm;
	}

	public void setPartnerNm(String partnerNm) {
		this.partnerNm = partnerNm;
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

	public String getRsvEmail() {
		return rsvEmail;
	}

	public void setRsvEmail(String rsvEmail) {
		this.rsvEmail = rsvEmail;
	}

	public String getCorpDisAmt() {
		return corpDisAmt;
	}

	public void setCorpDisAmt(String corpDisAmt) {
		this.corpDisAmt = corpDisAmt;
	}
}
