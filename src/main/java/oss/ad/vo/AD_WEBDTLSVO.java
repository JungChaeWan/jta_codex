package oss.ad.vo;

import oss.cmm.vo.pageDefaultVO;

public class AD_WEBDTLSVO extends pageDefaultVO{
	
	//private String sResEnable; /*예약 가능 여부*/
	
	private String sAdDiv; /*숙박유형*/
	private String sAdAdar; /*숙박지역*/
	
	private String sPriceSe; /*가격 구간*/

	//private String sPrdtNm; /*상품명*/
	
	private String sMen; /*인원*/
	
	private String corpId;
	
	private String sAdultCnt; /* 성인 인원수 */
	private String sChildCnt; /* 소아 인원수 */
	private String sBabyCnt; /* 유아 인원수 */

	private String sFromDt; /* 입실일 */
	private String sFromDtView;
	private String sToDt; /* 퇴실일 */
	private String sToDtView;
	private String sNights; /* n박 */
	private String sRoomNum; /* 객실 수 */
	
	private String sPrdtNum;
	
	private String orderCd; /* 정렬방식 */
	private String orderAsc; /* 정렬순위 */
	private String searchWord;	// 검색어
	
	private String lon;
	private String lat;
	private String sRowCount;
	
	/** 검색 여부 */
	private String sSearchYn;
	
	public String getsPrdtNum() {
		return sPrdtNum;
	}
	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
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
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
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
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
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
	public String getsRowCount() {
		return sRowCount;
	}
	public void setsRowCount(String sRowCount) {
		this.sRowCount = sRowCount;
	}
	public String getsSearchYn() {
		return sSearchYn;
	}
	public void setsSearchYn(String sSearchYn) {
		this.sSearchYn = sSearchYn;
	}	
}
