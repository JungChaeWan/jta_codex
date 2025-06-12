package web.product.vo;

import java.util.List;

import oss.cmm.vo.pageDefaultVO;

public class WEB_SPSVO extends pageDefaultVO{
	/** 카테고리 */
	private String sCtgr;
	/** 카테고리 뎁스 */
	private String sCtgrDepth;
	/** 상품 가격 */
	private String sPrice;
	/** 적용일자 */
	private String sAplDt;
	/** 정렬 조건 */
	private String orderCd;
	/** 정렬 순서 */
	private String orderAsc;
	/** 상품 리스트 탭 카테고리 */
	private String sTabCtgr;
	/** 카데고리 구분 */
	private String sCtgrDiv;
	/** 상품 구분 */
	private String sPrdtDiv;
	/** 업체아이디 */
	private String sCorpId;
	/** 위도 */
	private String sLAT;
	/** 경도 */
	private String sLON;
	/** 지역 */
	private String sSpAdar;
	/** 상품명 */
	private String sPrdtNm;
	/** 결과 탭 */
	private String sCtgrTab;
	/** 경비산출 여부 */
	private String sTeMainYn;


	private String sPrmtNum;

	/** 이벤트 상품 */
	private List<String> prdtNumList;

	/** 예약 쿠폰/뷰티 상품 */
	/** 쿠폰&뷰티 추천상품에서 예약상품을 제외 시 사용 (2016-08-16, By JDongS) */
	private List<String> rsvPrdtNumList;

	/** 지도 카테고리리스트 */
	private List<String> ctgrList;
	
	/** 지역 카테고리리스트 */
	private List<String> spAdarList;	

	private String searchWord;	// 검색어

	private String kwaNum; //키워드 광고 번호
	private String ctgr;	//서브 카타고리
	
	private String corpSubCd;	// 업체 서브 코드

	public String getsCtgr() {
		return sCtgr;
	}

	public void setsCtgr(String sCtgr) {
		this.sCtgr = sCtgr;
	}

	public String getsCtgrDepth() {
		return sCtgrDepth;
	}

	public void setsCtgrDepth(String sCtgrDepth) {
		this.sCtgrDepth = sCtgrDepth;
	}

	public String getsPrice() {
		return sPrice;
	}

	public void setsPrice(String sPrice) {
		this.sPrice = sPrice;
	}

	public String getsAplDt() {
		return sAplDt;
	}

	public void setsAplDt(String sAplDt) {
		this.sAplDt = sAplDt;
	}

	public String getOrderCd() {
		return orderCd;
	}

	public String getOrderAsc() {
		return orderAsc;
	}

	public void setOrderAsc(String orderAsc) {
		this.orderAsc = orderAsc;
	}

	public void setOrderCd(String orderCd) {
		this.orderCd = orderCd;
	}

	public String getsTabCtgr() {
		return sTabCtgr;
	}

	public void setsTabCtgr(String sTabCtgr) {
		this.sTabCtgr = sTabCtgr;
	}

	public String getsCtgrDiv() {
		return sCtgrDiv;
	}

	public void setsCtgrDiv(String sCtgrDiv) {
		this.sCtgrDiv = sCtgrDiv;
	}

	public String getsPrdtDiv() {
		return sPrdtDiv;
	}

	public void setsPrdtDiv(String sPrdtDiv) {
		this.sPrdtDiv = sPrdtDiv;
	}

	public String getsCorpId() {
		return sCorpId;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsLAT() {
		return sLAT;
	}

	public void setsLAT(String sLAT) {
		this.sLAT = sLAT;
	}

	public String getsLON() {
		return sLON;
	}

	public void setsLON(String sLON) {
		this.sLON = sLON;
	}

	public String getsSpAdar() {
		return sSpAdar;
	}

	public void setsSpAdar(String sSpAdar) {
		this.sSpAdar = sSpAdar;
	}

	public String getsPrdtNm() {
		return sPrdtNm;
	}

	public void setsPrdtNm(String sPrdtNm) {
		this.sPrdtNm = sPrdtNm;
	}

	public List<String> getPrdtNumList() {
		return prdtNumList;
	}

	public void setPrdtNumList(List<String> prdtNumList) {
		this.prdtNumList = prdtNumList;
	}

	public List<String> getRsvPrdtNumList() {
		return rsvPrdtNumList;
	}

	public void setRsvPrdtNumList(List<String> rsvPrdtNumList) {
		this.rsvPrdtNumList = rsvPrdtNumList;
	}

	public String getsCtgrTab() {
		return sCtgrTab;
	}

	public void setsCtgrTab(String sCtgrTab) {
		this.sCtgrTab = sCtgrTab;
	}

	public String getsPrmtNum() {
		return sPrmtNum;
	}

	public void setsPrmtNum(String sPrmtNum) {
		this.sPrmtNum = sPrmtNum;
	}

	public List<String> getCtgrList() {
		return ctgrList;
	}

	public void setCtgrList(List<String> ctgrList) {
		this.ctgrList = ctgrList;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getsTeMainYn() {
		return sTeMainYn;
	}

	public void setsTeMainYn(String sTeMainYn) {
		this.sTeMainYn = sTeMainYn;
	}

	public String getKwaNum() {
		return kwaNum;
	}

	public void setKwaNum(String kwaNum) {
		this.kwaNum = kwaNum;
	}

	public String getCtgr() {
		return ctgr;
	}

	public void setCtgr(String ctgr) {
		this.ctgr = ctgr;
	}

	public String getCorpSubCd() {
		return corpSubCd;
	}

	public void setCorpSubCd(String corpSubCd) {
		this.corpSubCd = corpSubCd;
	}

	public List<String> getSpAdarList() {
		return spAdarList;
	}

	public void setSpAdarList(List<String> spAdarList) {
		this.spAdarList = spAdarList;
	}

}
