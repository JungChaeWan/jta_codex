package mas.prmt.vo;


import java.util.List;

public class PRMTPRDTVO {
	private String prmtNum;

	private String prdtNum;
	private String prdtNm;
	private String savePath;
	private String saveFileNm;
	private String saleAmt;
	private String prdtDiv;

	private String printSn;

	private String corpId;
	private String corpNm;

	private Integer oldSn;
	private Integer newSn;

	private String corpCd;
	private Object data;

	private String label1;
	private String label2;
	private String label3;
	private String note;
	private List<String> notes;


	public String getPrmtNum() {
		return prmtNum;
	}

	public void setPrmtNum(String prmtNum) {
		this.prmtNum = prmtNum;
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

	public String getPrdtDiv() {
		return prdtDiv;
	}

	public void setPrdtDiv(String prdtDiv) {
		this.prdtDiv = prdtDiv;
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

	public Integer getOldSn() {
		return oldSn;
	}

	public void setOldSn(Integer oldSn) {
		this.oldSn = oldSn;
	}

	public Integer getNewSn() {
		return newSn;
	}

	public void setNewSn(Integer newSn) {
		this.newSn = newSn;
	}


	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public String getCorpCd() {
		return corpCd;
	}

	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}

	public String getLabel1() {
		return label1;
	}

	public void setLabel1(String label1) {
		this.label1 = label1;
	}

	public String getLabel2() {
		return label2;
	}

	public void setLabel2(String label2) {
		this.label2 = label2;
	}

	public String getLabel3() {
		return label3;
	}

	public void setLabel3(String label3) {
		this.label3 = label3;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public List<String> getNotes() {
		return notes;
	}

	public void setNotes(List<String> notes) {
		this.notes = notes;
	}
}