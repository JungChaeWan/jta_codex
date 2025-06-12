package oss.marketing.vo;

import oss.cmm.vo.pageDefaultVO;

public class BESTPRDTSVO extends pageDefaultVO {

	private String sBestprdtNum;

	private String sCorpCd;
	private String sCorpSubCd;



	private String cnt;



	public String getsBestprdtNum() {
		return sBestprdtNum;
	}



	public void setsBestprdtNum(String sBestprdtNum) {
		this.sBestprdtNum = sBestprdtNum;
	}



	public String getsCorpCd() {
		return sCorpCd;
	}



	public void setsCorpCd(String sCorpCd) {
		this.sCorpCd = sCorpCd;
	}



	public String getsCorpSubCd() {
		return sCorpSubCd;
	}



	public void setsCorpSubCd(String sCorpSubCd) {
		this.sCorpSubCd = sCorpSubCd;
	}



	public String getCnt() {
		return cnt;
	}



	public void setCnt(String cnt) {
		this.cnt = cnt;
	}



}
