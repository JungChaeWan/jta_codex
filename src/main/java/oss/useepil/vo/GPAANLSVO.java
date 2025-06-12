package oss.useepil.vo;

public class GPAANLSVO extends GPAANLSSVO{

	private String linkNum;
	private String gpaAvg;
	private String gpaCnt;
	
	public void setLinkNum(String linkNum) {
		this.linkNum = linkNum; 
	}
	public String getLinkNum() {
		return linkNum; 
	}
	public void setGpaAvg(String gpaAvg) {
		this.gpaAvg = gpaAvg; 
	}
	public String getGpaAvg() {
		return gpaAvg; 
	}
	public void setGpaCnt(String gpaCnt) {
		this.gpaCnt = gpaCnt; 
	}
	public String getGpaCnt() {
		return gpaCnt; 
	}

}
