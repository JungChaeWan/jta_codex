package api.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class APIYJDATAVO {

	/** 결과상태 */
	private String productNumber;
	private String productOptionNumber;
	private String pinNumber;

	public String getProductNumber() {
		return productNumber;
	}

	public void setProductNumber(String productNumber) {
		this.productNumber = productNumber;
	}

	public String getProductOptionNumber() {
		return productOptionNumber;
	}

	public void setProductOptionNumber(String productOptionNumber) {
		this.productOptionNumber = productOptionNumber;
	}

	public String getPinNumber() {
		return pinNumber;
	}

	public void setPinNumber(String pinNumber) {
		this.pinNumber = pinNumber;
	}
}
