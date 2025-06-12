package web.order.vo;

public class KAKAOPAYINFVO {

	/** 예약 번호 */
	private String rsvNum;
	/** 결제 순번 */
	private String paySn;
	/** 결제결과코드 */
	private String resultCode;
	/** 결제결과메시지 */
	private String resultMsg;
	/** 거래번호 */
	private String tid;
	/** 가맹점 주문번호 */
	private String moid;
	/** 가맹점 ID */
	private String mid;
	/** 결제 수단 코드 */
	private String payMethod;
	/** 결제상품금액 */
	private String amt;
	/** 프로모션 할인금액 */
	private String discountAmt;
	/** 승인 날짜 */
	private String authDate;
	/** 승인 코드 */
	private String authCode;
	/** 발급사 카드코드 */
	private String cardCode;
	/** 매입사 카드코드 */
	private String acquCardCode;
	/** 카드명 */
	private String cardName;
	/** 할부개월수 */
	private String cardQuota;
	/** 무이자여부 */
	private String cardInterest;
	/** 체크카드여부 */
	private String cardCl;
	/** 카드BIN번호 */
	private String cardBin;
	/** 카드사포인트사용여부 */
	private String cardPoint;
	/** 부분취소 가능여부 */
	private String ccPartCl;
	/** 프로모션 부분취소가능여부 */
	private String promotionCcPartCl;
	/** 등록 일시 */
	private String regDttm;
	
	public String getRsvNum() {
		return rsvNum;
	}
	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}
	public String getPaySn() {
		return paySn;
	}
	public void setPaySn(String paySn) {
		this.paySn = paySn;
	}
	public String getResultCode() {
		return resultCode;
	}
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	public String getResultMsg() {
		return resultMsg;
	}
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getMoid() {
		return moid;
	}
	public void setMoid(String moid) {
		this.moid = moid;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getPayMethod() {
		return payMethod;
	}
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}
	public String getAmt() {
		return amt;
	}
	public void setAmt(String amt) {
		this.amt = amt;
	}
	public String getDiscountAmt() {
		return discountAmt;
	}
	public void setDiscountAmt(String discountAmt) {
		this.discountAmt = discountAmt;
	}
	public String getAuthDate() {
		return authDate;
	}
	public void setAuthDate(String authDate) {
		this.authDate = authDate;
	}
	public String getAuthCode() {
		return authCode;
	}
	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}
	public String getCardCode() {
		return cardCode;
	}
	public void setCardCode(String cardCode) {
		this.cardCode = cardCode;
	}
	public String getAcquCardCode() {
		return acquCardCode;
	}
	public void setAcquCardCode(String acquCardCode) {
		this.acquCardCode = acquCardCode;
	}
	public String getCardName() {
		return cardName;
	}
	public void setCardName(String cardName) {
		this.cardName = cardName;
	}
	public String getCardQuota() {
		return cardQuota;
	}
	public void setCardQuota(String cardQuota) {
		this.cardQuota = cardQuota;
	}
	public String getCardInterest() {
		return cardInterest;
	}
	public void setCardInterest(String cardInterest) {
		this.cardInterest = cardInterest;
	}
	public String getCardCl() {
		return cardCl;
	}
	public void setCardCl(String cardCl) {
		this.cardCl = cardCl;
	}
	public String getCardBin() {
		return cardBin;
	}
	public void setCardBin(String cardBin) {
		this.cardBin = cardBin;
	}
	public String getCardPoint() {
		return cardPoint;
	}
	public void setCardPoint(String cardPoint) {
		this.cardPoint = cardPoint;
	}
	public String getCcPartCl() {
		return ccPartCl;
	}
	public void setCcPartCl(String ccPartCl) {
		this.ccPartCl = ccPartCl;
	}
	public String getPromotionCcPartCl() {
		return promotionCcPartCl;
	}
	public void setPromotionCcPartCl(String promotionCcPartCl) {
		this.promotionCcPartCl = promotionCcPartCl;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}


}
