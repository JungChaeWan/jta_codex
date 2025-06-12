package api.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class APIHIJEJURESULTVO {

	/** 통신결과 코드 */
	private String code;

	/** 통신결과 메시지 */
	private String message;

	/** 주문 아이템 번호 */
	private String orderItemId;

	/** 엘에스 핀번호 */
	private String pinCode;

	/** 취소일시 */
	private String cancelDateTime;

	/** 상품명 */
	@JsonProperty("PrNm")
	private String prNm;

	/** 옵션명 */
	@JsonProperty("OtNm")
	private String otNm;

	/** 주문상태 */
	private String status;

	/** 발권/이용시간 */
	private String useDateTime;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(String orderItemId) {
		this.orderItemId = orderItemId;
	}

	public String getPinCode() {
		return pinCode;
	}

	public void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}

	public String getCancelDateTime() {
		return cancelDateTime;
	}

	public void setCancelDateTime(String cancelDateTime) {
		this.cancelDateTime = cancelDateTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUseDateTime() {
		return useDateTime;
	}

	public void setUseDateTime(String useDateTime) {
		this.useDateTime = useDateTime;
	}

	public String getPrNm() {
		return prNm;
	}

	public void setPrNm(String prNm) {
		this.prNm = prNm;
	}

	public String getOtNm() {
		return otNm;
	}

	public void setOtNm(String otNm) {
		this.otNm = otNm;
	}
}
