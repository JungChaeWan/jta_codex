package oss.cmm.vo;

public class CM_IMGVO extends CM_IMGSVO{

	/** 이미지 번호 */
	private String imgNum;
	/** 연계 번호 */
	private String linkNum;
	/** 이미지 순번 */
	private String imgSn;
	/** 저장 경로 */
	private String savePath;
	/** 실제 파일 명 */
	private String realFileNm;
	/** 저장 파일 명 */
	private String saveFileNm;
	
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
	public String getSavePath() {
		return savePath;
	}
	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	public String getRealFileNm() {
		return realFileNm;
	}
	public void setRealFileNm(String realFileNm) {
		this.realFileNm = realFileNm;
	}
	public String getSaveFileNm() {
		return saveFileNm;
	}
	public void setSaveFileNm(String saveFileNm) {
		this.saveFileNm = saveFileNm;
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
