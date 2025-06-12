package oss.corp.vo;

import oss.cmm.vo.pageDefaultVO;

public class CORPSVO extends pageDefaultVO{
    
	private String sCorpNm;
	private String sCorpCd;
	private String sCorpSubCd;

	private Integer sDist;

	private String sCoRegNum;
	
	private String sKey;
	
	private String sKeyOpt;
	private String sCorpId;
	private String sTradeStatusCd;
	
	private String sAsctMemYn;
	private String sSuperbCorpYn;
	
	private String sSpCtgr;

	/** 실시간 연동 유무 **/
	private String sCorpLinkYn;

	/** 실시간 연동 업체 2022.08.09**/
	private String sCorpLinkApi;

	private String sFileYn;
	private String[] sFileNum;

	private String sCorpCd2;
	
	private String sVisitMappingYn;

	private String sTamnacardMngYn;

	/** 파트너(협력사) 코드 **/
	private String partnerCode;
	
	public String getsCorpNm() {
		return sCorpNm;
	}

	public void setsCorpNm(String sCorpNm) {
		this.sCorpNm = sCorpNm;
	}

	public Integer getsDist() {
		return sDist;
	}

	public void setsDist(Integer sDist) {
		this.sDist = sDist;
	}

	public String getsCoRegNum() {
		return sCoRegNum;
	}

	public void setsCoRegNum(String sCoRegNum) {
		this.sCoRegNum = sCoRegNum;
	}

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

	public String getsCorpCd() {
		return sCorpCd;
	}

	public void setsCorpCd(String sCorpCd) {
		this.sCorpCd = sCorpCd;
	}

	public String getsCorpId() {
		return sCorpId;
	}

	public String getsCorpSubCd() {
		return sCorpSubCd;
	}

	public void setsCorpSubCd(String sCorpSubCd) {
		this.sCorpSubCd = sCorpSubCd;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsTradeStatusCd() {
		return sTradeStatusCd;
	}

	public void setsTradeStatusCd(String sTradeStatusCd) {
		this.sTradeStatusCd = sTradeStatusCd;
	}

	public String getsAsctMemYn() {
		return sAsctMemYn;
	}

	public void setsAsctMemYn(String sAsctMemYn) {
		this.sAsctMemYn = sAsctMemYn;
	}

	public String getsSuperbCorpYn() {
		return sSuperbCorpYn;
	}

	public void setsSuperbCorpYn(String sSuperbCorpYn) {
		this.sSuperbCorpYn = sSuperbCorpYn;
	}

	public String getsSpCtgr() {
		return sSpCtgr;
	}

	public void setsSpCtgr(String sSpCtgr) {
		this.sSpCtgr = sSpCtgr;
	}

	public String getsCorpLinkYn() {
		return sCorpLinkYn;
	}

	public void setsCorpLinkYn(String sCorpLinkYn) {
		this.sCorpLinkYn = sCorpLinkYn;
	}

	public String getsFileYn() {
		return sFileYn;
	}

	public void setsFileYn(String sFileYn) {
		this.sFileYn = sFileYn;
	}

	public String[] getsFileNum() {
		return sFileNum;
	}

	public void setsFileNum(String[] sFileNum) {
		this.sFileNum = sFileNum;
	}

	public String getsCorpCd2() {
		return sCorpCd2;
	}

	public void setsCorpCd2(String sCorpCd2) {
		this.sCorpCd2 = sCorpCd2;
	}

	public String getsVisitMappingYn() {
		return sVisitMappingYn;
	}

	public void setsVisitMappingYn(String sVisitMappingYn) {
		this.sVisitMappingYn = sVisitMappingYn;
	}

	public String getsTamnacardMngYn() {
		return sTamnacardMngYn;
	}

	public void setsTamnacardMngYn(String sTamnacardMngYn) {
		this.sTamnacardMngYn = sTamnacardMngYn;
	}

	public String getsCorpLinkApi() {
		return sCorpLinkApi;
	}

	public void setsCorpLinkApi(String sCorpLinkApi) {
		this.sCorpLinkApi = sCorpLinkApi;
	}

	public String getPartnerCode() {
		return partnerCode;
	}

	public void setPartnerCode(String partnerCode) {
		this.partnerCode = partnerCode;
	}
}
