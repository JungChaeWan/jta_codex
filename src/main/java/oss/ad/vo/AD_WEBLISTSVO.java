package oss.ad.vo;

import java.util.List;

import oss.cmm.vo.pageDefaultVO;

public class AD_WEBLISTSVO extends pageDefaultVO {

	private String sResEnable; /* 예약 가능 여부 */

	private String sAdDiv; /* 숙박유형 */
	private String sAdAdar; /* 숙박지역 */
	private List<String> arrAdAdar; /* 숙박지역 - multi */
	private String iconCd; /* 편의시설 */

	private String sPriceSe; /* 가격 구간 */

	private String sPrdtNum; /* 상품 Id */
	private String sPrdtNm; /* 상품명 */

	private String sMen; /* 인원 */
	
	private String sAdultCnt; /* 성인 인원수 */
	private String sChildCnt; /* 소아 인원수 */
	private String sBabyCnt; /* 유아 인원수 */

	private String sFromDt; /* 입실일 */
	private String sFromDtView;
	private String sToDt; /* 퇴실일 */
	private String sToDtView;
	private String sNights; /* n박 */
	private String sRoomNum; /* 객실 수 */
	private String sFromDtMap;
	private String sToDtMap;

	private String sAdDivCdView; /* 탭에서 구분 */

	private String orderCd; /* 정렬방식 */
	private String orderAsc; /* 정렬순위 */

	private String sLON; /* 위도 */
	private String sLAT; /* 경도 */

	private String sKey;
	private String sKeyOpt;

	private String sCorpId;

	private String sDaypriceYn; // 당일특가

	private String sPrmtNum;// 프로모션 번호

	private List<String> sIconCd; // 주요정보
	
	private String searchWord;	// 검색어
	
	private String sSearchYn;	// 검색 여부
	
	private String isBack;

	/** Y:예약 가능 , Null or N:예약마감 */
	private String rsvAbleYn;

	/**탐나는전*/
	private String sTamnacardYn;

	/**우수관광 사업체*/
	private String sSuperbCorpYn;

	/**할인쿠폰 1:있음, 0:없음*/
	private String sCouponCnt;

	public List<String> getsIconCd() {
		return sIconCd;
	}

	public void setsIconCd(List<String> sIconCd) {
		this.sIconCd = sIconCd;
	}

	public String getsResEnable() {
		return sResEnable;
	}

	public void setsResEnable(String sResEnable) {
		this.sResEnable = sResEnable;
	}

	public String getsAdDiv() {
		return sAdDiv;
	}

	public void setsAdDiv(String sAdDiv) {
		this.sAdDiv = sAdDiv;
	}

	public String getsAdAdar() {
		return sAdAdar;
	}

	public void setsAdAdar(String sAdAdar) {
		this.sAdAdar = sAdAdar;
	}

	public String getsPriceSe() {
		return sPriceSe;
	}

	public void setsPriceSe(String sPriceSe) {
		this.sPriceSe = sPriceSe;
	}

	public String getsPrdtNum() {
		return sPrdtNum;
	}

	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}

	public String getsPrdtNm() {
		return sPrdtNm;
	}

	public void setsPrdtNm(String sPrdtNm) {
		this.sPrdtNm = sPrdtNm;
	}

	public String getsMen() {
		return sMen;
	}

	public void setsMen(String sMen) {
		this.sMen = sMen;
	}

	public String getsAdultCnt() {
		return sAdultCnt;
	}

	public void setsAdultCnt(String sAdultCnt) {
		this.sAdultCnt = sAdultCnt;
	}

	public String getsChildCnt() {
		return sChildCnt;
	}

	public void setsChildCnt(String sChildCnt) {
		this.sChildCnt = sChildCnt;
	}

	public String getsBabyCnt() {
		return sBabyCnt;
	}

	public void setsBabyCnt(String sBabyCnt) {
		this.sBabyCnt = sBabyCnt;
	}

	public String getsFromDt() {
		return sFromDt;
	}

	public void setsFromDt(String sFromDt) {
		this.sFromDt = sFromDt;
	}

	public String getsFromDtView() {
		return sFromDtView;
	}

	public void setsFromDtView(String sFromDtView) {
		this.sFromDtView = sFromDtView;
	}

	public String getsToDt() {
		return sToDt;
	}

	public void setsToDt(String sToDt) {
		this.sToDt = sToDt;
	}

	public String getsToDtView() {
		return sToDtView;
	}

	public void setsToDtView(String sToDtView) {
		this.sToDtView = sToDtView;
	}

	public String getsNights() {
		return sNights;
	}

	public void setsNights(String sNights) {
		this.sNights = sNights;
	}

	public String getsRoomNum() {
		return sRoomNum;
	}

	public void setsRoomNum(String sRoomNum) {
		this.sRoomNum = sRoomNum;
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

	public String getsAdDivCdView() {
		return sAdDivCdView;
	}

	public void setsAdDivCdView(String sAdDivCdView) {
		this.sAdDivCdView = sAdDivCdView;
	}

	public String getOrderCd() {
		return orderCd;
	}

	public void setOrderCd(String orderCd) {
		this.orderCd = orderCd;
	}

	public String getOrderAsc() {
		return orderAsc;
	}

	public void setOrderAsc(String orderAsc) {
		this.orderAsc = orderAsc;
	}

	public String getsLON() {
		return sLON;
	}

	public void setsLON(String sLON) {
		this.sLON = sLON;
	}

	public String getsLAT() {
		return sLAT;
	}

	public void setsLAT(String sLAT) {
		this.sLAT = sLAT;
	}

	public String getsCorpId() {
		return sCorpId;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsDaypriceYn() {
		return sDaypriceYn;
	}

	public void setsDaypriceYn(String sDaypriceYn) {
		this.sDaypriceYn = sDaypriceYn;
	}

	public String getsPrmtNum() {
		return sPrmtNum;
	}

	public void setsPrmtNum(String sPrmtNum) {
		this.sPrmtNum = sPrmtNum;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getsSearchYn() {
		return sSearchYn;
	}

	public void setsSearchYn(String sSearchYn) {
		this.sSearchYn = sSearchYn;
	}

	public String getIsBack() {
		return isBack;
	}

	public void setIsBack(String isBack) {
		this.isBack = isBack;
	}

	public String getIconCd() {
		return iconCd;
	}

	public void setIconCd(String iconCd) {
		this.iconCd = iconCd;
	}

	public String getsFromDtMap() {
		return sFromDtMap;
	}

	public void setsFromDtMap(String sFromDtMap) {
		this.sFromDtMap = sFromDtMap;
	}

	public String getsToDtMap() {
		return sToDtMap;
	}

	public void setsToDtMap(String sToDtMap) {
		this.sToDtMap = sToDtMap;
	}

	public String getRsvAbleYn() {
		return rsvAbleYn;
	}

	public void setRsvAbleYn(String rsvAbleYn) {
		this.rsvAbleYn = rsvAbleYn;
	}

	//검색시 성인,소인,유아,인원 default 설정 2021.11.29 chaewan.jung
	public AD_WEBLISTSVO() {
		this.sMen = "2";
		this.sAdultCnt = "2";
		this.sChildCnt = "0";
		this.sBabyCnt = "0";
	}

	public String getsTamnacardYn() {
		return sTamnacardYn;
	}

	public void setsTamnacardYn(String sTamnacardYn) {
		this.sTamnacardYn = sTamnacardYn;
	}

	public List<String> getArrAdAdar() {
		return arrAdAdar;
	}

	public void setArrAdAdar(List<String> arrAdAdar) {
		this.arrAdAdar = arrAdAdar;
	}

	public String getsSuperbCorpYn() {
		return sSuperbCorpYn;
	}

	public void setsSuperbCorpYn(String sSuperbCorpYn) {
		this.sSuperbCorpYn = sSuperbCorpYn;
	}

	public String getsCouponCnt() {
		return sCouponCnt;
	}

	public void setsCouponCnt(String sCouponCnt) {
		this.sCouponCnt = sCouponCnt;
	}
}
