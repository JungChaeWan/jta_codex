package oss.corp.vo;

import oss.cmm.vo.pageDefaultVO;

public class CORPADTMMNGVO extends pageDefaultVO{
    
	/** 업체 아이디 */
	private String corpId;
	/** 업체 대표 이미지 경로 */
	private String corpRptImgPath;
	/** 업체 대표 이미지 파일 명 */
	private String corpRptImgFileNm;
	/** 업체 대표 설명 */
	private String corpRptExp;
	
	
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getCorpRptImgPath() {
		return corpRptImgPath;
	}
	public void setCorpRptImgPath(String corpRptImgPath) {
		this.corpRptImgPath = corpRptImgPath;
	}
	public String getCorpRptImgFileNm() {
		return corpRptImgFileNm;
	}
	public void setCorpRptImgFileNm(String corpRptImgFileNm) {
		this.corpRptImgFileNm = corpRptImgFileNm;
	}
	public String getCorpRptExp() {
		return corpRptExp;
	}
	public void setCorpRptExp(String corpRptExp) {
		this.corpRptExp = corpRptExp;
	}

	

}
