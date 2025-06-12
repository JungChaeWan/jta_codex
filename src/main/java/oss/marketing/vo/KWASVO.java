package oss.marketing.vo;

import oss.cmm.vo.pageDefaultVO;

public class KWASVO extends pageDefaultVO {

	private String skwaNum;
	private String skwaNm;
	private String slocation;
	private String sCorpCd;
	private String sNotInYn;

	private String cnt;

	public String getSkwaNum() {
		return skwaNum;
	}
	public void setSkwaNum(String skwaNum) {
		this.skwaNum = skwaNum;
	}
	public String getSkwaNm() {
		return skwaNm;
	}
	public void setSkwaNm(String skwaNm) {
		this.skwaNm = skwaNm;
	}	
	public String getSlocation() {
		return slocation;
	}
	public void setSlocation(String slocation) {
		this.slocation = slocation;
	}
	public String getsCorpCd() {
		return sCorpCd;
	}
	public void setsCorpCd(String sCorpCd) {
		this.sCorpCd = sCorpCd;
	}
	public String getsNotInYn() {
		return sNotInYn;
	}
	public void setsNotInYn(String sNotInYn) {
		this.sNotInYn = sNotInYn;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
}
