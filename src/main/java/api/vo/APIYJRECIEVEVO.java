package api.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class APIYJRECIEVEVO {

	/** 결과상태 */
	private String code;

	/** 결과코드 */
	private String message;

	private Data data;

	public static class Data{
		private String agencyApproveNumber;
		private List<APIYJDATAVO> pins;

		public String getAgencyApproveNumber() {
			return agencyApproveNumber;
		}

		public void setAgencyApproveNumber(String agencyApproveNumber) {
			this.agencyApproveNumber = agencyApproveNumber;
		}

		public List<APIYJDATAVO> getPins() {
			return pins;
		}

		public void setPins(List<APIYJDATAVO> pins) {
			this.pins = pins;
		}
	}

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

	public Data getData() {
		return data;
	}

	public void setData(Data data) {
		this.data = data;
	}
}
