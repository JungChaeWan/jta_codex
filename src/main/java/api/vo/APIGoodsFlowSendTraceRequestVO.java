package api.vo;

import java.util.List;

public class APIGoodsFlowSendTraceRequestVO {
	/** 배송번호 */
	private String transUniqueCode;
	/** 보내는분 명(판매업체명) */
	private String fromName;
	/** 받는분 명(고객명) */
	private String toName;
	/** 배송사코드 */
	private String logisticsCode;
	/** 운송장번호*/
	private String invoiceNo;
	/** 배송구분(D:정상, 반품(R)*/
	private String dlvretType;

	/** variables in 'requestDetails' are defined below */
	/** 주문번호 */
	private String orderNo;
	/** 주문행번호 */
	private String orderLine;
	/** 주문행 상품명*/
	private String itemName;
	/** 주문행 상품수량*/
	private String itemQty;
	/** 주문일시(YYYYMMDDHHMMSS)*/
	private String orderDate;
	/** 입금일시(YYYYMMDDHHMMSS)*/
	private String paymentDate;

	public String getTransUniqueCode() {
		return transUniqueCode;
	}

	public void setTransUniqueCode(String transUniqueCode) {
		this.transUniqueCode = transUniqueCode;
	}

	public String getFromName() {
		return fromName;
	}

	public void setFromName(String fromName) {
		this.fromName = fromName;
	}

	public String getToName() {
		return toName;
	}

	public void setToName(String toName) {
		this.toName = toName;
	}

	public String getLogisticsCode() {
		return logisticsCode;
	}

	public void setLogisticsCode(String logisticsCode) {
		this.logisticsCode = logisticsCode;
	}

	public String getInvoiceNo() {
		return invoiceNo;
	}

	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}

	public String getDlvretType() {
		return dlvretType;
	}

	public void setDlvretType(String dlvretType) {
		this.dlvretType = dlvretType;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getOrderLine() {
		return orderLine;
	}

	public void setOrderLine(String orderLine) {
		this.orderLine = orderLine;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemQty() {
		return itemQty;
	}

	public void setItemQty(String itemQty) {
		this.itemQty = itemQty;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
}
