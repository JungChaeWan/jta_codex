package oss.marketing.vo;

import java.util.List;

public class KWAVO extends KWASVO{

	private String kwaNum;
	private String kwaNm;
	private String startDttm;
	private String endDttm;
	private String regDttm;
	private String pcUrl;
	private String mobileUrl;
	private String location;
	private String locationNm;

	private String prdtCnt;
	
	private String savePath;
	private String saveFileNm;
	private String corpCd;

	private List<String> prdtNumAD;
	private List<String> prdtNumRC;
	private List<String> prdtNumSPC100;
	private List<String> prdtNumSPC200;
	private List<String> prdtNumSPC300;
	private List<String> prdtNumSPC500;
	private List<String> prdtNumSV;

	public String getKwaNum() {
		return kwaNum;
	}
	public void setKwaNum(String kwaNum) {
		this.kwaNum = kwaNum;
	}
	public String getKwaNm() {
		return kwaNm;
	}
	public void setKwaNm(String kwaNm) {
		this.kwaNm = kwaNm;
	}
	public String getStartDttm() {
		return startDttm;
	}
	public void setStartDttm(String startDttm) {
		this.startDttm = startDttm;
	}
	public String getEndDttm() {
		return endDttm;
	}
	public void setEndDttm(String endDttm) {
		this.endDttm = endDttm;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getPcUrl() {
		return pcUrl;
	}
	public void setPcUrl(String pcUrl) {
		this.pcUrl = pcUrl;
	}
	public String getMobileUrl() {
		return mobileUrl;
	}
	public void setMobileUrl(String mobileUrl) {
		this.mobileUrl = mobileUrl;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getLocationNm() {
		return locationNm;
	}
	public void setLocationNm(String locationNm) {
		this.locationNm = locationNm;
	}
	public List<String> getPrdtNumAD() {
		return prdtNumAD;
	}
	public void setPrdtNumAD(List<String> prdtNumAD) {
		this.prdtNumAD = prdtNumAD;
	}
	public List<String> getPrdtNumRC() {
		return prdtNumRC;
	}
	public void setPrdtNumRC(List<String> prdtNumRC) {
		this.prdtNumRC = prdtNumRC;
	}
	public List<String> getPrdtNumSPC100() {
		return prdtNumSPC100;
	}
	public void setPrdtNumSPC100(List<String> prdtNumSPC100) {
		this.prdtNumSPC100 = prdtNumSPC100;
	}
	public List<String> getPrdtNumSPC200() {
		return prdtNumSPC200;
	}
	public void setPrdtNumSPC200(List<String> prdtNumSPC200) {
		this.prdtNumSPC200 = prdtNumSPC200;
	}
	public List<String> getPrdtNumSPC300() {return prdtNumSPC300;}
	public void setPrdtNumSPC300(List<String> prdtNumSPC300) {
		this.prdtNumSPC300 = prdtNumSPC300;
	}
	public List<String> getPrdtNumSPC500() {return prdtNumSPC500;}
	public void setPrdtNumSPC500(List<String> prdtNumSPC500) {
		this.prdtNumSPC500 = prdtNumSPC500;
	}
	public List<String> getPrdtNumSV() {
		return prdtNumSV;
	}
	public void setPrdtNumSV(List<String> prdtNumSV) {
		this.prdtNumSV = prdtNumSV;
	}
	public String getPrdtCnt() {
		return prdtCnt;
	}
	public void setPrdtCnt(String prdtCnt) {
		this.prdtCnt = prdtCnt;
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

	public String getCorpCd() {
		return corpCd;
	}

	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
}
