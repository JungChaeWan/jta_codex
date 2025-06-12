package oss.marketing.vo;

import oss.cmm.vo.pageDefaultVO;

public class SMSEMAILWORDSVO extends pageDefaultVO {
	private String smsEmailNum;
	private String wordsDiv;
	private String wordsSubject;
	private String wordsContents;
	private String aplStartDt;
	private String aplEndDt;
	
	public String getSmsEmailNum() {
		return smsEmailNum;
	}
	public void setSmsEmailNum(String smsEmailNum) {
		this.smsEmailNum = smsEmailNum;
	}
	public String getWordsDiv() {
		return wordsDiv;
	}
	public void setWordsDiv(String wordsDiv) {
		this.wordsDiv = wordsDiv;
	}
	public String getWordsSubject() {
		return wordsSubject;
	}
	public void setWordsSubject(String wordsSubject) {
		this.wordsSubject = wordsSubject;
	}
	public String getWordsContents() {
		return wordsContents;
	}
	public void setWordsContents(String wordsContents) {
		this.wordsContents = wordsContents;
	}

	public String getAplStartDt() {
		return aplStartDt;
	}

	public void setAplStartDt(String aplStartDt) {
		this.aplStartDt = aplStartDt;
	}

	public String getAplEndDt() {
		return aplEndDt;
	}

	public void setAplEndDt(String aplEndDt) {
		this.aplEndDt = aplEndDt;
	}
}
