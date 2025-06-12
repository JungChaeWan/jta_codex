package api.vo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class APIGoodsFlowReceiveTraceResultItemsVO {

	private String transUniqueCode;
	private Integer seq;
	private String dlvStatType;

	public String getTransUniqueCode() {
		return transUniqueCode;
	}

	public void setTransUniqueCode(String transUniqueCode) {
		this.transUniqueCode = transUniqueCode;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getDlvStatType() {
		return dlvStatType;
	}

	public void setDlvStatType(String dlvStatType) {
		this.dlvStatType = dlvStatType;
	}
}
