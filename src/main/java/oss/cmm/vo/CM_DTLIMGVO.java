package oss.cmm.vo;

public class CM_DTLIMGVO extends CM_DTLIMGSVO{

	private String imgNum;
	private String linkNum;
	private String imgSn;
	private String pcImgYn;
	private String savePath;
	private String saveFileNm;
	private String realFileNm;
	
	private Integer newSn;
	private Integer oldSn;
	
	private String newLinkNum;
	
	public String getImgNum() {
		return imgNum;
	}
	public void setImgNum(String imgNum) {
		this.imgNum = imgNum;
	}
	public String getLinkNum() {
		return linkNum;
	}
	public void setLinkNum(String linkNum) {
		this.linkNum = linkNum;
	}
	public String getImgSn() {
		return imgSn;
	}
	public void setImgSn(String imgSn) {
		this.imgSn = imgSn;
	}
	public String getPcImgYn() {
		return pcImgYn;
	}
	public void setPcImgYn(String pcImgYn) {
		this.pcImgYn = pcImgYn;
	}
	public String getSavePath() {
		return savePath;
	}
	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	public String getSaveFileNm() {
		return saveFileNm;
	}
	public void setSaveFileNm(String saveFileNm) {
		this.saveFileNm = saveFileNm;
	}
	public String getRealFileNm() {
		return realFileNm;
	}
	public void setRealFileNm(String realFileNm) {
		this.realFileNm = realFileNm;
	}
	public Integer getNewSn() {
		return newSn;
	}
	public void setNewSn(Integer newSn) {
		this.newSn = newSn;
	}
	public Integer getOldSn() {
		return oldSn;
	}
	public void setOldSn(Integer oldSn) {
		this.oldSn = oldSn;
	}
	public String getNewLinkNum() {
		return newLinkNum;
	}
	public void setNewLinkNum(String newLinkNum) {
		this.newLinkNum = newLinkNum;
	}
}
