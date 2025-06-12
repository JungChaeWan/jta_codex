package apiCn.vo;

public class APILOGVO {

	/** API 아이디 */
	private String apiId;
	/** 요청 일자 */
	private String requestDt;
	/** API 순번 */
	private String apiSn;
	/** 요청 구분 */
	private String requestDiv;
	/** 요청 URL */
	private String requestUrl;
	/** 결과 코드 */
	private String rstCd;
	/** 결과 정보 */
	private String rstInf;
	/** 요청 일시 */
	private String requestDttm;
	
	public String getApiId() {
		return apiId;
	}
	public void setApiId(String apiId) {
		this.apiId = apiId;
	}
	public String getRequestDt() {
		return requestDt;
	}
	public void setRequestDt(String requestDt) {
		this.requestDt = requestDt;
	}
	public String getApiSn() {
		return apiSn;
	}
	public void setApiSn(String apiSn) {
		this.apiSn = apiSn;
	}
	public String getRequestDiv() {
		return requestDiv;
	}
	public void setRequestDiv(String requestDiv) {
		this.requestDiv = requestDiv;
	}
	public String getRequestUrl() {
		return requestUrl;
	}
	public void setRequestUrl(String requestUrl) {
		this.requestUrl = requestUrl;
	}
	public String getRstCd() {
		return rstCd;
	}
	public void setRstCd(String rstCd) {
		this.rstCd = rstCd;
	}
	public String getRstInf() {
		return rstInf;
	}
	public void setRstInf(String rstInf) {
		this.rstInf = rstInf;
	}
	public String getRequestDttm() {
		return requestDttm;
	}
	public void setRequestDttm(String requestDttm) {
		this.requestDttm = requestDttm;
	}

}
