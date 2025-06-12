package web.order.vo;

import java.util.List;

public class LPOINTSAVEINFVO {	
	/** 상품 예약 번호 */	
	private String prdtRsvNum;
	/** 결제 금액 */
	private String payAmt;
	/** 카드 번호 */
	private String cardNum;
	/** 거래 일시 */
	private String tradeDttm;
	/** 승인 번호 */
	private String confNum;
	/** 승인 일시 */
	private String confDttm;
	/** 응답 코드 */
	private String respCd;
	/** 적립 포인트 */
	private String savePoint;
	/** 이벤트 포인트 */
	private String evntPoint;
	/** 적립 여부 */
	private String saveYn;
	/** 예약 취소 여부 */
	private String rsvCancelYn;
	/** 적립 결과 */
	private String saveRst;
	/** 취소 상품 예약번호 리스트 */
	private List<String> cancelRsvNumList;
	
	public String getPrdtRsvNum() {
		return prdtRsvNum;
	}
	public void setPrdtRsvNum(String prdtRsvNum) {
		this.prdtRsvNum = prdtRsvNum;
	}
	public String getPayAmt() {
		return payAmt;
	}
	public void setPayAmt(String pay_amt) {
		this.payAmt = pay_amt;
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
	public String getConfNum() {
		return confNum;
	}
	public void setConfNum(String confNum) {
		this.confNum = confNum;
	}
	public String getConfDttm() {
		return confDttm;
	}
	public void setConfDttm(String confDttm) {
		this.confDttm = confDttm;
	}
	public String getRespCd() {
		return respCd;
	}
	public void setRespCd(String respCd) {
		this.respCd = respCd;
	}
	public String getSavePoint() {
		return savePoint;
	}
	public void setSavePoint(String savePoint) {
		this.savePoint = savePoint;
	}
	public String getEvntPoint() {
		return evntPoint;
	}
	public void setEvntPoint(String evntPoint) {
		this.evntPoint = evntPoint;
	}
	public String getSaveYn() {
		return saveYn;
	}
	public void setSaveYn(String saveYn) {
		this.saveYn = saveYn;
	}
	public String getRsvCancelYn() {
		return rsvCancelYn;
	}
	public void setRsvCancelYn(String rsvCancelYn) {
		this.rsvCancelYn = rsvCancelYn;
	}
	public String getSaveRst() {
		return saveRst;
	}
	public void setSaveRst(String saveRst) {
		this.saveRst = saveRst;
	}
	public List<String> getCancelRsvNumList() {
		return cancelRsvNumList;
	}
	public void setCancelRsvNumList(List<String> cancelRsvNumList) {
		this.cancelRsvNumList = cancelRsvNumList;
	}	
}
