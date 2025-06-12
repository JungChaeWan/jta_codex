package api.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public class APIInsVO {

	private String resCode;

	private String resMsg;

	private String resID;

	private String resTime;

	private List<APIInsModelListVO> 모델목록;

	public String getResCode() {
		return resCode;
	}

	public void setResCode(String resCode) {
		this.resCode = resCode;
	}

	public String getResMsg() {
		return resMsg;
	}

	public void setResMsg(String resMsg) {
		this.resMsg = resMsg;
	}

	public String getResID() {
		return resID;
	}

	public void setResID(String resID) {
		this.resID = resID;
	}

	public String getResTime() {
		return resTime;
	}

	public void setResTime(String resTime) {
		this.resTime = resTime;
	}

	public List<APIInsModelListVO> get모델목록() {
		return 모델목록;
	}

	public void set모델목록(List<APIInsModelListVO> 모델목록) {
		this.모델목록 = 모델목록;
	}
}
