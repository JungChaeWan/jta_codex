package oss.bbs.vo;

import oss.cmm.vo.pageDefaultVO;


public class BBSSVO extends pageDefaultVO{
    
	private String sBbsNum;
	private String sBbsNm;
	
	public String getsBbsNum() {
		return sBbsNum;
	}
	public void setsBbsNum(String sBbsNum) {
		this.sBbsNum = sBbsNum;
	}
	public String getsBbsNm() {
		return sBbsNm;
	}
	public void setsBbsNm(String sBbsNm) {
		this.sBbsNm = sBbsNm;
	}
	
	
	private String sKey;
	private String sKeyOpt;

	public String getsKey() {
		return sKey;
	}
	public void setsKey(String sKey) {
		this.sKey = sKey;
	}
	public String getsKeyOpt() {
		return sKeyOpt;
	}
	public void setsKeyOpt(String sKeyOpt) {
		this.sKeyOpt = sKeyOpt;
	}
	
}
