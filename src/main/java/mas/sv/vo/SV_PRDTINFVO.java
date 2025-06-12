package mas.sv.vo;

public class SV_PRDTINFVO extends SV_PRDTINFSVO {

	/** 기념품 번호 */
	private String prdtNum;
	/** 업체 아이디 */
	private String corpId;
	/** 거래상태 */
	private String tradeStatus;
	/** 카테고리 */
	private String ctgr;
	/** 상품 명 */
	private String prdtNm;
	/** 생산자 */
	private String prdc;
	/** 원산지 */
	private String org;
	/** 판매 시작 일자 */
	private String saleStartDt;
	/** 판매 종료 일자 */
	private String saleEndDt;
	/** 유효 시작 일자 */
	private String exprStartDt;
	/** 상품 정보 */
	private String prdtInf;
	/** 취급 주의사항 */
	private String hdlPrct;
	/** 배송안내 */
	private String dlvGuide;
	/** 취소 안내 */
	private String cancelGuide;
	/** 반품안내 */
	private String tkbkGuide;
	/** 승인 요청 일시 */
	private String confRequestDttm;
	/** 승인 일시 */
	private String confDttm;
	/** 최초 등록일시 */
	private String frstRegDttm;
	/** 최초 등록 아이디 */
	private String frstRegId;
	/** 최초 등록 아이피 */
	private String frstRegIp;
	/** 최종 수정 일시 */
	private String lastModDttm;
	/** 최종 수정 아이디 */
	private String lastModId;
	/** 최종 수정 아이피 */
	private String lastModIp;

	/** 카테고리 이름 */
	private String ctgrNm;
	/** 업체 명 */
	private String corpNm;
	/** 신규 상품번호 */
	private String newPrdtNum;

	/** 옵션갯수 */
	private Integer optCnt;

	/** 검색어 */
	private String srchWord1;
	private String srchWord2;
	private String srchWord3;
	private String srchWord4;
	private String srchWord5;
	private String srchWord6;
	private String srchWord7;
	private String srchWord8;
	private String srchWord9;
	private String srchWord10;

	/** 우수관광기념품 */
	private String superbSvYn;
    /** JQ인증 여부 */
	private String jqYn;

	/** 상품설명 */
	private String prdtExp;

	/** 서브 카테고리 */
	private String subCtgr;
	/** 서브 카테고리 이름 */
	private String subCtgrNm;
	/** 직접 수령 여부 */
	private String directRecvYn;
	// 배송 가능 여부
	private String deliveryYn;

	/** 홍보 영상 */
	private String adMov;

	/** 6차산업인증 카테고리 */
	private String sixCertiCate;

	private String apiImgThumb;

	private String apiImgDetail;

	public String getPrdtNum() {
		return prdtNum;
	}

	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}

	public String getTradeStatus() {
		return tradeStatus;
	}

	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
	}

	public String getCtgr() {
		return ctgr;
	}

	public void setCtgr(String ctgr) {
		this.ctgr = ctgr;
	}

	public String getPrdtNm() {
		return prdtNm;
	}

	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}

	public String getPrdc() {
		return prdc;
	}

	public void setPrdc(String prdc) {
		this.prdc = prdc;
	}

	public String getOrg() {
		return org;
	}

	public void setOrg(String org) {
		this.org = org;
	}

	public String getSaleStartDt() {
		return saleStartDt;
	}

	public void setSaleStartDt(String saleStartDt) {
		this.saleStartDt = saleStartDt;
	}

	public String getSaleEndDt() {
		return saleEndDt;
	}

	public void setSaleEndDt(String saleEndDt) {
		this.saleEndDt = saleEndDt;
	}

	public String getExprStartDt() {
		return exprStartDt;
	}

	public void setExprStartDt(String exprStartDt) {
		this.exprStartDt = exprStartDt;
	}

	public String getPrdtInf() {
		return prdtInf;
	}

	public void setPrdtInf(String prdtInf) {
		this.prdtInf = prdtInf;
	}

	public String getHdlPrct() {
		return hdlPrct;
	}

	public void setHdlPrct(String hdlPrct) {
		this.hdlPrct = hdlPrct;
	}

	public String getDlvGuide() {
		return dlvGuide;
	}

	public void setDlvGuide(String dlvGuide) {
		this.dlvGuide = dlvGuide;
	}

	public String getCancelGuide() {
		return cancelGuide;
	}

	public void setCancelGuide(String cancelGuide) {
		this.cancelGuide = cancelGuide;
	}

	public String getTkbkGuide() {
		return tkbkGuide;
	}

	public void setTkbkGuide(String tkbkGuide) {
		this.tkbkGuide = tkbkGuide;
	}

	public String getConfRequestDttm() {
		return confRequestDttm;
	}

	public void setConfRequestDttm(String confRequestDttm) {
		this.confRequestDttm = confRequestDttm;
	}

	public String getConfDttm() {
		return confDttm;
	}

	public void setConfDttm(String confDttm) {
		this.confDttm = confDttm;
	}

	public String getFrstRegDttm() {
		return frstRegDttm;
	}

	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}

	public String getFrstRegId() {
		return frstRegId;
	}

	public void setFrstRegId(String frstRegId) {
		this.frstRegId = frstRegId;
	}

	public String getFrstRegIp() {
		return frstRegIp;
	}

	public void setFrstRegIp(String frstRegIp) {
		this.frstRegIp = frstRegIp;
	}

	public String getLastModDttm() {
		return lastModDttm;
	}

	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}

	public String getLastModId() {
		return lastModId;
	}

	public void setLastModId(String lastModId) {
		this.lastModId = lastModId;
	}

	public String getLastModIp() {
		return lastModIp;
	}

	public void setLastModIp(String lastModIp) {
		this.lastModIp = lastModIp;
	}

	public String getCtgrNm() {
		return ctgrNm;
	}

	public void setCtgrNm(String ctgrNm) {
		this.ctgrNm = ctgrNm;
	}

	public String getCorpNm() {
		return corpNm;
	}

	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}

	public String getNewPrdtNum() {
		return newPrdtNum;
	}

	public void setNewPrdtNum(String newPrdtNum) {
		this.newPrdtNum = newPrdtNum;
	}

	public Integer getOptCnt() {
		return optCnt;
	}

	public void setOptCnt(Integer optCnt) {
		this.optCnt = optCnt;
	}

	public String getSrchWord1() {
		return srchWord1;
	}

	public void setSrchWord1(String srchWord1) {
		this.srchWord1 = srchWord1;
	}

	public String getSrchWord2() {
		return srchWord2;
	}

	public void setSrchWord2(String srchWord2) {
		this.srchWord2 = srchWord2;
	}

	public String getSrchWord3() {
		return srchWord3;
	}

	public void setSrchWord3(String srchWord3) {
		this.srchWord3 = srchWord3;
	}

	public String getSrchWord4() {
		return srchWord4;
	}

	public void setSrchWord4(String srchWord4) {
		this.srchWord4 = srchWord4;
	}

	public String getSrchWord5() {
		return srchWord5;
	}

	public void setSrchWord5(String srchWord5) {
		this.srchWord5 = srchWord5;
	}

	public String getSrchWord6() {
		return srchWord6;
	}

	public void setSrchWord6(String srchWord6) {
		this.srchWord6 = srchWord6;
	}

	public String getSrchWord7() {
		return srchWord7;
	}

	public void setSrchWord7(String srchWord7) {
		this.srchWord7 = srchWord7;
	}

	public String getSrchWord8() {
		return srchWord8;
	}

	public void setSrchWord8(String srchWord8) {
		this.srchWord8 = srchWord8;
	}

	public String getSrchWord9() {
		return srchWord9;
	}

	public void setSrchWord9(String srchWord9) {
		this.srchWord9 = srchWord9;
	}

	public String getSrchWord10() {
		return srchWord10;
	}

	public void setSrchWord10(String srchWord10) {
		this.srchWord10 = srchWord10;
	}

	public String getSuperbSvYn() {
		return superbSvYn;
	}

	public void setSuperbSvYn(String superbSvYn) {
		this.superbSvYn = superbSvYn;
	}

	public String getPrdtExp() {
		return prdtExp;
	}

	public void setPrdtExp(String prdtExp) {
		this.prdtExp = prdtExp;
	}

	public String getSubCtgr() {
		return subCtgr;
	}

	public void setSubCtgr(String subCtgr) {
		this.subCtgr = subCtgr;
	}

	public String getSubCtgrNm() {
		return subCtgrNm;
	}

	public void setSubCtgrNm(String subCtgrNm) {
		this.subCtgrNm = subCtgrNm;
	}

	public String getDirectRecvYn() {
		return directRecvYn;
	}

	public void setDirectRecvYn(String directRecvYn) {
		this.directRecvYn = directRecvYn;
	}

	public String getDeliveryYn() {
		return deliveryYn;
	}

	public void setDeliveryYn(String deliveryYn) {
		this.deliveryYn = deliveryYn;
	}

	public String getAdMov() {
		return adMov;
	}

	public void setAdMov(String adMov) {
		this.adMov = adMov;
	}

	public String getJqYn() {
		return jqYn;
	}

	public void setJqYn(String jqYn) {
		this.jqYn = jqYn;
	}

	public String getSixCertiCate() {
		return sixCertiCate;
	}

	public void setSixCertiCate(String sixCertiCate) {
		this.sixCertiCate = sixCertiCate;
	}

	public String getApiImgThumb() {
		return apiImgThumb;
	}

	public void setApiImgThumb(String apiImgThumb) {
		this.apiImgThumb = apiImgThumb;
	}

	public String getApiImgDetail() {
		return apiImgDetail;
	}

	public void setApiImgDetail(String apiImgDetail) {
		this.apiImgDetail = apiImgDetail;
	}
}
