package web.order.vo;

public class LPOINTUSEINFVO {
	/** 예약 번호 */
	private String rsvNum;
	/** 카드 번호 */	
	private String cardNum;
	/** 거래 일시 */
	private String tradeDttm;
	/** 결제 금액 */
	private String payAmt;
	/** 사용 포인트 */
	private String usePoint;
	/** 거래 승인번호 */
	private String tradeConfnum;
	/** 요청 번호 */
	private String requestNum;
	/** 응답 코드 */
	private String respCd;
	/** 예약 취소 여부 */
	private String rsvCancelYn;
	/** 취소 여부 */
	private String cancelYn;
	/** 사용 결과 */
	private String useRst;
	/** 적용포인트 */
	private String maxSaleDtlRsvNum;

	public String getRsvNum() {
		return rsvNum;
	}
	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}
	public String getCardNum() {
		return cardNum;
	}
	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}
	public String getTradeDttm() {
		return tradeDttm;
	}
	public void setTradeDttm(String tradeDttm) {
		this.tradeDttm = tradeDttm;
	}
	public String getPayAmt() {
		return payAmt;
	}
	public void setPayAmt(String payAmt) {
		this.payAmt = payAmt;
	}
	public String getUsePoint() {
		return usePoint;
	}
	public void setUsePoint(String usePoint) {
		this.usePoint = usePoint;
	}
	public String getTradeConfnum() {
		return tradeConfnum;
	}
	public void setTradeConfnum(String tradeConfnum) {
		this.tradeConfnum = tradeConfnum;
	}
	public String getRequestNum() {
		return requestNum;
	}
	public void setRequestNum(String requestNum) {
		this.requestNum = requestNum;
	}
	public String getRespCd() {
		return respCd;
	}
	public void setRespCd(String respCd) {
		this.respCd = respCd;
	}
	public String getRsvCancelYn() {
		return rsvCancelYn;
	}
	public void setRsvCancelYn(String rsvCancelYn) {
		this.rsvCancelYn = rsvCancelYn;
	}
	public String getCancelYn() {
		return cancelYn;
	}
	public void setCancelYn(String cancelYn) {
		this.cancelYn = cancelYn;
	}
	public String getUseRst() {
		return useRst;
	}
	public void setUseRst(String useRst) {
		this.useRst = useRst;
	}

	public String getMaxSaleDtlRsvNum() {
		return maxSaleDtlRsvNum;
	}

	public void setMaxSaleDtlRsvNum(String maxSaleDtlRsvNum) {
		this.maxSaleDtlRsvNum = maxSaleDtlRsvNum;
	}
}
