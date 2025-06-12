package oss.cmm.vo;

public class ISEARCHVO {

	/** 검색날짜 */
	private String srchDttm;
	/** 검색어 순번 */
	private String ip;
	/** 최초 등록 일시 */
	private String srchWord;

	public String getSrchDttm() {
		return srchDttm;
	}

	public void setSrchDttm(String srchDttm) {
		this.srchDttm = srchDttm;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getSrchWord() {
		return srchWord;
	}

	public void setSrchWord(String srchWord) {
		this.srchWord = srchWord;
	}
}
