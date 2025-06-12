package oss.site.vo;

public class SVCRTNPRDTVO {
	private String crtnNum;		/* 큐레이션 번호 */
	private String prdtNum;		/* 기념품 상품 번호 */
	private String prdtNm;		/* 기념품 상품 명 */
	private String printSn;		/* 출력 순번 */
	private String corpId;
	private String corpNm;
	private int oldSn;
	private int newSn;
	private String savePath;
	private String saveFileNm;
	private String saleAmt;

	/** 탐나는전 예약가능 여부 **/
	private String tamnacardYn;

	public String getCrtnNum() {
		return crtnNum;
	}
	public void setCrtnNum(String crtnNum) {
		this.crtnNum = crtnNum;
	}
	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getPrintSn() {
		return printSn;
	}
	public void setPrintSn(String printSn) {
		this.printSn = printSn;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public int getOldSn() {
		return oldSn;
	}
	public void setOldSn(int oldSn) {
		this.oldSn = oldSn;
	}
	public int getNewSn() {
		return newSn;
	}
	public void setNewSn(int newSn) {
		this.newSn = newSn;
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
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}

	public String getTamnacardYn() {
		return tamnacardYn;
	}

	public void setTamnacardYn(String tamnacardYn) {
		this.tamnacardYn = tamnacardYn;
	}
}
