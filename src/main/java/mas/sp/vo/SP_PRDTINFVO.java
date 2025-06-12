package mas.sp.vo;

import java.util.List;


public class SP_PRDTINFVO extends SP_PRDTINFSVO {
	/** all 또는 single 타입*/
	private String type;

	/** 소셜 상품 번호 */
	private String prdtNum;
	/** 업체 아이디 */
	private String corpId;
	/** 거래상태 */
	private String tradeStatus;
	/** 카테고리 */
	private String ctgr;
	/** 상품 명 */
	private String prdtNm;
	/** 상품 정보 */
	private String prdtInf;
	/** 서브 설명 */
	private String subExp;
	/** 판매 시작 일자 */
	private String saleStartDt;
	/** 판매 종료 일자 */
	private String saleEndDt;
	/** 유효 시작 일자 */
	private String exprStartDt;
	/** 유효 종료 일자 */
	private String exprEndDt;
	/** 상품 구분 */
	private String prdtDiv;
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
	/** 사용 조건 */
	private String useQlfct;
	/** 할인 정보 */
	private String disInf;
	/** 승인 요청 일시 */
	private String confRequestDttm;
	/** 승인 일시 */
	private String confDttm;
	/** 취소 안내 */
	private String cancelGuide;

	/** 카테고리 이름 */
	private String ctgrNm;
	/** 업체 명 */
	private String corpNm;
	/** 신규 상품번호 */
	private String newPrdtNum;

	/** 이용가능시간 */
	private Integer useAbleTm;

	/** 유효일수 여부 */
	private String exprDaynumYn;

	/** 유효일수 */
	private Integer exprDaynum;

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

	/** 숙박 구분 */
	private String adDiv;
	/** 숙박 지역 */
	private String adArea;
	/** 도로명 주소 */
	private String roadNmAddr;
	/** 상세 주소 */
	private String dtlAddr;
	/** 경도 */
	private String lon;
	/** 위도 */
	private String lat;
	/** LINK 상품 여부 */
	private String linkPrdtYn;
	/** LINK URL */
	private String linkUrl;

	private String adMov;

	private List<String> iconCd;

	/** 업체 수수료율 */
	private String cmssRate;

	private String area;
	/** LS컴퍼니 링크 여부*/
	private String lsLinkYn;
	/** LS컴퍼니 링크 상품번호*/
	private String lsLinkPrdtNum;

	private String lsLinkOptNum;

	private String advRvYn;
	/** 6차산업인증 카테고리 */
	private String sixCertiCate;

	private String apiImgThumb;

	private String apiImgDetail;

	public String getAdDiv() {
		return adDiv;
	}

	public void setAdDiv(String adDiv) {
		this.adDiv = adDiv;
	}

	public String getAdArea() {
		return adArea;
	}

	public void setAdArea(String adArea) {
		this.adArea = adArea;
	}

	public String getRoadNmAddr() {
		return roadNmAddr;
	}

	public void setRoadNmAddr(String roadNmAddr) {
		this.roadNmAddr = roadNmAddr;
	}

	public String getDtlAddr() {
		return dtlAddr;
	}

	public void setDtlAddr(String dtlAddr) {
		this.dtlAddr = dtlAddr;
	}

	public String getLon() {
		return lon;
	}

	public void setLon(String lon) {
		this.lon = lon;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

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

	public String getPrdtInf() {
		return prdtInf;
	}

	public void setPrdtInf(String prdtInf) {
		this.prdtInf = prdtInf;
	}

	public String getSubExp() {
		return subExp;
	}

	public void setSubExp(String subExp) {
		this.subExp = subExp;
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

	public String getExprEndDt() {
		return exprEndDt;
	}

	public void setExprEndDt(String exprEndDt) {
		this.exprEndDt = exprEndDt;
	}

	public String getPrdtDiv() {
		return prdtDiv;
	}

	public void setPrdtDiv(String prdtDiv) {
		this.prdtDiv = prdtDiv;
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

	public String getUseQlfct() {
		return useQlfct;
	}

	public void setUseQlfct(String useQlfct) {
		this.useQlfct = useQlfct;
	}

	public String getDisInf() {
		return disInf;
	}

	public void setDisInf(String disInf) {
		this.disInf = disInf;
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

	public String getCancelGuide() {
		return cancelGuide;
	}

	public void setCancelGuide(String cancelGuide) {
		this.cancelGuide = cancelGuide;
	}

	public String getNewPrdtNum() {
		return newPrdtNum;
	}

	public void setNewPrdtNum(String newPrdtNum) {
		this.newPrdtNum = newPrdtNum;
	}

	public Integer getUseAbleTm() {
		return useAbleTm;
	}

	public void setUseAbleTm(Integer useAbleTm) {
		this.useAbleTm = useAbleTm;
	}

	public String getExprDaynumYn() {
		return exprDaynumYn;
	}

	public void setExprDaynumYn(String exprDaynumYn) {
		this.exprDaynumYn = exprDaynumYn;
	}

	public Integer getExprDaynum() {
		return exprDaynum;
	}

	public void setExprDaynum(Integer exprDaynum) {
		this.exprDaynum = exprDaynum;
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

	public List<String> getIconCd() {
		return iconCd;
	}

	public void setIconCd(List<String> iconCd) {
		this.iconCd = iconCd;
	}

	public String getLinkPrdtYn() {
		return linkPrdtYn;
	}

	public void setLinkPrdtYn(String linkPrdtYn) {
		this.linkPrdtYn = linkPrdtYn;
	}

	public String getLinkUrl() {
		return linkUrl;
	}

	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}

	public String getCmssRate() {
		return cmssRate;
	}

	public void setCmssRate(String cmssRate) {
		this.cmssRate = cmssRate;
	}

	public String getAdMov() {
		return adMov;
	}

	public void setAdMov(String adMov) {
		this.adMov = adMov;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getLsLinkYn() {
		return lsLinkYn;
	}

	public void setLsLinkYn(String lsLinkYn) {
		this.lsLinkYn = lsLinkYn;
	}

	public String getLsLinkPrdtNum() {
		return lsLinkPrdtNum;
	}

	public void setLsLinkPrdtNum(String lsLinkPrdtNum) {
		this.lsLinkPrdtNum = lsLinkPrdtNum;
	}

	public String getAdvRvYn() {
		return advRvYn;
	}

	public void setAdvRvYn(String advRvYn) {
		this.advRvYn = advRvYn;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getLsLinkOptNum() {
		return lsLinkOptNum;
	}

	public void setLsLinkOptNum(String lsLinkOptNum) {
		this.lsLinkOptNum = lsLinkOptNum;
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
