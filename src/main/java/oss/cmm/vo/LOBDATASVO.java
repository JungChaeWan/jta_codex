package oss.cmm.vo;

public class LOBDATASVO extends pageDefaultVO{
	
	/** 테이블 구분 */
	private String tbDiv;
	/** 컬럼 구분 */
	private String colDiv;
	/** 검색 파라미터 */
	private String sParam;
	/** 검색 파라미터2 */
	private String sParam2;
	/** 업체 아이디 */
	private String sCorpId;
	/** 검색 인덱스 */
	private String sIndex;

	public String getTbDiv() {
		return tbDiv;
	}

	public void setTbDiv(String tbDiv) {
		this.tbDiv = tbDiv;
	}

	public String getColDiv() {
		return colDiv;
	}

	public void setColDiv(String colDiv) {
		this.colDiv = colDiv;
	}

	public String getsIndex() {
		return sIndex;
	}

	public void setsIndex(String sIndex) {
		this.sIndex = sIndex;
	}

	public String getsCorpId() {
		return sCorpId;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsParam() {
		return sParam;
	}

	public void setsParam(String sParam) {
		this.sParam = sParam;
	}

	public String getsParam2() {
		return sParam2;
	}

	public void setsParam2(String sParam2) {
		this.sParam2 = sParam2;
	}
}
