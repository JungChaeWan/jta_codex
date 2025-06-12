package oss.corp.vo;

public class CORP_PNSREQFILEVO {

	private String requestNum;		// 요청 번호
	private String fileNum;			// 파일 번호
	private String savePath;		// 저장 경로
	private String realFileNm;		// 실제 파일명
	private String saveFileNm;		// 저장 파일명
	private String corpId;


	public String getRequestNum() {
		return requestNum;
	}

	public void setRequestNum(String requestNum) {
		this.requestNum = requestNum;
	}

	public String getFileNum() {
		return fileNum;
	}

	public void setFileNum(String fileNum) {
		this.fileNum = fileNum;
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

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
}
