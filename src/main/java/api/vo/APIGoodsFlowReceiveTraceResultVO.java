package api.vo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;


import java.util.List;
import java.util.Map;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class APIGoodsFlowReceiveTraceResultVO {

	private Data data;

	public static class Data{
		private int totalItems;
		private List<APIGoodsFlowReceiveTraceResultItemsVO> items;

		public int getTotalItems() {
			return totalItems;
		}

		public void setTotalItems(int totalItems) {
			this.totalItems = totalItems;
		}

		public List<APIGoodsFlowReceiveTraceResultItemsVO> getItems() {
			return items;
		}

		public void setItems(List<APIGoodsFlowReceiveTraceResultItemsVO> items) {
			this.items = items;
		}
	}

	public Data getData() {
		return data;
	}

	public void setData(Data data) {
		this.data = data;
	}

	private Error error;
	public static class Error{
		public String status;
		public String message;
		public String detailMessage;

		public String getStatus() {
			return status;
		}

		public void setStatus(String status) {
			this.status = status;
		}

		public String getMessage() {
			return message;
		}

		public void setMessage(String message) {
			this.message = message;
		}

		public String getDetailMessage() {
			return detailMessage;
		}

		public void setDetailMessage(String detailMessage) {
			this.detailMessage = detailMessage;
		}
	}
	private String success;
	private String context;

	public Error getError() {
		return error;
	}

	public void setError(Error error) {
		this.error = error;
	}

	public String getSuccess() {
		return success;
	}

	public void setSuccess(String success) {
		this.success = success;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

}
