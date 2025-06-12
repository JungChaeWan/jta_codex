package api.vo;

public class APILSVO {

	/** 탐나오 주문번호 */
	private String rsvNum;
	/** 구매자 휴대폰 번호 */
	private String rsvTelnum;
	/** 구매자명 */
	private String rsvNm;
	/** 이용자 휴대폰 번호 */
	private String useTelnum;
	/** 이용자명 */
	private String useNm;
	/** 구매 개수  */
	private int buyNum;
	/** 사용 개수  */
	private int useNum;
	/** 탐나오 아이템번호 */
	private String spRsvNum;
	/** LS컴퍼니 상품번호 */
	private String lsLinkPrdtNum;
	/** LS컴퍼니 옵션번호 */
	private String lsLinkOptNum;
	/** 상품명 */
	private String prdtNm;
	/** 옵션명 */
	private String optNm;
	/** 판매가 */
	private String nmlAmt;
	/** 결제금액 */
	private String saleAmt;
	/** 수수료 */
	private String cmssAmt;
	/** 연동여부 LS:Y, 하이제주:H */
	private String lsLinkYn;

	private String corpId;

	private String saleStartDt;

	private String saleEndDt;

	private String prdtDiv;

	private String exprStartDt;

	private String exprEndDt;

	private String exprDaynumYn;

	private String exprDaynum;

	private String apiImgThumb;

	private String apiImgDetail;

	private String transactionId;

	private String lsLinkOptPincode;

	private String leadLsLinkPrdtNum;

	public String getRsvNum() {
		return rsvNum;
	}

	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}

	public String getRsvTelnum() {
		return rsvTelnum;
	}

	public void setRsvTelnum(String rsvTelnum) {
		this.rsvTelnum = rsvTelnum;
	}

	public String getRsvNm() {
		return rsvNm;
	}

	public void setRsvNm(String rsvNm) {
		this.rsvNm = rsvNm;
	}

	public String getUseTelnum() {
		return useTelnum;
	}

	public void setUseTelnum(String useTelnum) {
		this.useTelnum = useTelnum;
	}

	public String getUseNm() {
		return useNm;
	}

	public void setUseNm(String useNm) {
		this.useNm = useNm;
	}

	public int getBuyNum() {
		return buyNum;
	}

	public String getSpRsvNum() {
		return spRsvNum;
	}

	public void setSpRsvNum(String spRsvNum) {
		this.spRsvNum = spRsvNum;
	}

	public String getLsLinkPrdtNum() {
		return lsLinkPrdtNum;
	}

	public void setLsLinkPrdtNum(String lsLinkPrdtNum) {
		this.lsLinkPrdtNum = lsLinkPrdtNum;
	}

	public String getLsLinkOptNum() {
		return lsLinkOptNum;
	}

	public void setLsLinkOptNum(String lsLinkOptNum) {
		this.lsLinkOptNum = lsLinkOptNum;
	}

	public String getPrdtNm() {
		return prdtNm;
	}

	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
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

	public String getSaleAmt() {
		return saleAmt;
	}

	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}

	public void setBuyNum(int buyNum) {
		this.buyNum = buyNum;
	}

	public String getCmssAmt() {
		return cmssAmt;
	}

	public void setCmssAmt(String cmssAmt) {
		this.cmssAmt = cmssAmt;
	}

	public String getLsLinkYn() {
		return lsLinkYn;
	}

	public void setLsLinkYn(String lsLinkYn) {
		this.lsLinkYn = lsLinkYn;
	}

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
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

	public String getPrdtDiv() {
		return prdtDiv;
	}

	public void setPrdtDiv(String prdtDiv) {
		this.prdtDiv = prdtDiv;
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

	public String getExprDaynumYn() {
		return exprDaynumYn;
	}

	public void setExprDaynumYn(String exprDaynumYn) {
		this.exprDaynumYn = exprDaynumYn;
	}

	public String getExprDaynum() {
		return exprDaynum;
	}

	public void setExprDaynum(String exprDaynum) {
		this.exprDaynum = exprDaynum;
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

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public String getLsLinkOptPincode() {
		return lsLinkOptPincode;
	}

	public void setLsLinkOptPincode(String lsLinkOptPincode) {
		this.lsLinkOptPincode = lsLinkOptPincode;
	}

	public int getUseNum() {
		return useNum;
	}

	public void setUseNum(int useNum) {
		this.useNum = useNum;
	}

	public String getLeadLsLinkPrdtNum() {
		return leadLsLinkPrdtNum;
	}

	public void setLeadLsLinkPrdtNum(String leadLsLinkPrdtNum) {
		this.leadLsLinkPrdtNum = leadLsLinkPrdtNum;
	}
}
