package apiCn.vo;

public class APICNVO extends APICNSVO{

	/** API 아이디 */
	private String apiId;
	/** 업체 아이디 */
	private String corpId;
	/** 업체 명 */
	private String corpNm;
	/** 인증키 */
	private String authkey;
	/** 연계 여부 */
	private String linkYn;
	/** 최초 등록 일시 */
	private String frstRegDttm;
	/** 최초 등록 아이디 */
	private String frstRegId;
	/** 최종 수정 일시 */
	private String lastModDttm;
	/** 최종 수정 아이디 */
	private String lastModId;
	public String getApiId() {
		return apiId;
	}
	public void setApiId(String apiId) {
		this.apiId = apiId;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getAuthkey() {
		return authkey;
	}
	public void setAuthkey(String authkey) {
		this.authkey = authkey;
	}
	public String getLinkYn() {
		return linkYn;
	}
	public void setLinkYn(String linkYn) {
		this.linkYn = linkYn;
	}
	public String getFrstRegDttm() {
		return frstRegDttm;
	}
	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}
	public String getFrstRegId() {
		return frstRegId;
	}
	public void setFrstRegId(String frstRegId) {
		this.frstRegId = frstRegId;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getLastModDttm() {
		return lastModDttm;
	}
	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}
	public String getLastModId() {
		return lastModId;
	}
	public void setLastModId(String lastModId) {
		this.lastModId = lastModId;
	}


}
