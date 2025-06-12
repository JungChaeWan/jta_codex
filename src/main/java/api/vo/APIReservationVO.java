package api.vo;

public class APIReservationVO {

	/** 카테고리*/
	private String corpCd;

	/** 업체코드*/
	private String corpId;

	/** 대 예약번호*/
	private String rsvNum;

	/** 상세 예약번호*/
	private String dtlRsvNum;

	/** API 예약번호*/
	private String apiRsvNum;

	/** API 구분*/
	private String apiDiv;

	private String rsvNm;

	private String rsvTelnum;

	private String buyNum;

	private String useNum;

	private String admMobile;

	private String admMobile2;

	private String admMobile3;

	public String getCorpCd() {
		return corpCd;
	}

	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}

	public String getRsvNum() {
		return rsvNum;
	}

	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}

	public String getDtlRsvNum() {
		return dtlRsvNum;
	}

	public void setDtlRsvNum(String dtlRsvNum) {
		this.dtlRsvNum = dtlRsvNum;
	}

	public String getApiDiv() {
		return apiDiv;
	}

	public void setApiDiv(String apiDiv) {
		this.apiDiv = apiDiv;
	}

	public String getApiRsvNum() {
		return apiRsvNum;
	}

	public void setApiRsvNum(String apiRsvNum) {
		this.apiRsvNum = apiRsvNum;
	}

	public String getRsvNm() {
		return rsvNm;
	}

	public void setRsvNm(String rsvNm) {
		this.rsvNm = rsvNm;
	}

	public String getRsvTelnum() {
		return rsvTelnum;
	}

	public void setRsvTelnum(String rsvTelnum) {
		this.rsvTelnum = rsvTelnum;
	}

	public String getBuyNum() {
		return buyNum;
	}

	public void setBuyNum(String buyNum) {
		this.buyNum = buyNum;
	}

	public String getUseNum() {
		return useNum;
	}

	public void setUseNum(String useNum) {
		this.useNum = useNum;
	}

	public String getAdmMobile() {
		return admMobile;
	}

	public void setAdmMobile(String admMobile) {
		this.admMobile = admMobile;
	}

	public String getAdmMobile2() {
		return admMobile2;
	}

	public void setAdmMobile2(String admMobile2) {
		this.admMobile2 = admMobile2;
	}

	public String getAdmMobile3() {
		return admMobile3;
	}

	public void setAdmMobile3(String admMobile3) {
		this.admMobile3 = admMobile3;
	}
}
