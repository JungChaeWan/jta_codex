package mas.rc.vo;

import java.util.List;

import oss.cmm.vo.pageDefaultVO;

public class RC_PRDTINFSVO extends pageDefaultVO{

	private String sCorpId;
	private String sPrdtNm;
	private String sPrdtNum;

	private String sPrmtNum;
	
	/** 차량구분코드 */
	private String sCarDivCd;
	private List<String> sCarDivCdList;
	/** 차량구분코드(탭) */
	private String sCarDivCdView;
	
	/** 검색시작일 */
	private String sFromDt;
	/** 검색종료일 */
	private String sToDt;
	/** 검색시작일_V */
	private String sFromDtView;
	/** 검색종료일_V */
	private String sToDtView;
	/** 검색시작시간 */
	private String sFromTm;
	/** 검색종료시간 */
	private String sToTm;
	/** 예약가능여부 */
	private String sAbleYn;
	/** 거래 상태 코드 */
	private String sTradeStatus;
	
	/** 미리보기 여부 */
	private String preViewYn;
	/** 메인 확인 여부 - 예약가능불가능 표시처리 파라미터 */
	private String mYn;
	/** 검색 여부 */
	private String searchYn;
	
	private String searchWord;	// 검색어
	
	/**
	 * 정렬
	 * 판매순(SALE)
	 */
	private String orderCd;
	
	/**
	 * 정렬 순서(A or D)
	 */
	private String orderAsc;
	
	/** 
	 * 이벤트 속한 상품
	 */
	private List<String> prdtNumList;
	
	/** 연계 번호 */
	private String sMappingNum;
	
	/** 주요정보 */
	private List<String> sIconCd;
	
	/** 차량코드 */
	private String sCarCd;
	private List<String> sCarCds;
	
	/** 보험 구분 */
	private String sIsrDiv;
	
	/** 메인 리스트 출력 여부 */
	private String sMainViewYn;
		
	/** 제조사 검색 */
	private String sMakerDivCd;
	/** 사용연료 검색 */
	private String sUseFuelDiv;
	/** 연식 검색 */
	private String sModelYear;
	
	// 보험 종류 구분	
	private String sIsrTypeDiv;
	
	private String sIconCdCnt;
	
	private String sRntQlfctAge;

	private String sRntQlfctCareer;

	private String sDisperDiv;

	private String sRcCardivNum;

	/**탐나는전*/
	private String sTamnacardYn;

	/**우수관광사업체*/
	private String sSuperbCorpYn;

	/**할인쿠폰*/
	private String sCouponCnt;

	private String sApiRentDiv;

	private String sInfo;

	public String getsDisperDiv() {
		return sDisperDiv;
	}

	public void setsDisperDiv(String sDisperDiv) {
		this.sDisperDiv = sDisperDiv;
	}
	
	public String getsFromDt() {
		return sFromDt;
	}

	public void setsFromDt(String sFromDt) {
		this.sFromDt = sFromDt;
	}

	public String getsToDt() {
		return sToDt;
	}

	public void setsToDt(String sToDt) {
		this.sToDt = sToDt;
	}

	public String getsFromDtView() {
		return sFromDtView;
	}

	public void setsFromDtView(String sFromDtView) {
		this.sFromDtView = sFromDtView;
	}

	public String getsToDtView() {
		return sToDtView;
	}

	public void setsToDtView(String sToDtView) {
		this.sToDtView = sToDtView;
	}

	public String getsFromTm() {
		return sFromTm;
	}

	public void setsFromTm(String sFromTm) {
		this.sFromTm = sFromTm;
	}

	public String getsToTm() {
		return sToTm;
	}

	public void setsToTm(String sToTm) {
		this.sToTm = sToTm;
	}

	public String getsPrdtNm() {
		return sPrdtNm;
	}

	public void setsPrdtNm(String sPrdtNm) {
		this.sPrdtNm = sPrdtNm;
	}

	public String getsCorpId() {
		return sCorpId;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsCarDivCd() {
		return sCarDivCd;
	}

	public void setsCarDivCd(String sCarDivCd) {
		this.sCarDivCd = sCarDivCd;
	}
	
	public List<String> getsCarDivCdList() {
		return sCarDivCdList;
	}

	public void setsCarDivCdList(List<String> sCarDivCdList) {
		this.sCarDivCdList = sCarDivCdList;
	}
	

	public String getsCarDivCdView() {
		return sCarDivCdView;
	}

	public void setsCarDivCdView(String sCarDivCdView) {
		this.sCarDivCdView = sCarDivCdView;
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

	public String getsPrdtNum() {
		return sPrdtNum;
	}

	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}

	public String getsAbleYn() {
		return sAbleYn;
	}

	public void setsAbleYn(String sAbleYn) {
		this.sAbleYn = sAbleYn;
	}

	public String getPreViewYn() {
		return preViewYn;
	}

	public void setPreViewYn(String preViewYn) {
		this.preViewYn = preViewYn;
	}

	public List<String> getPrdtNumList() {
		return prdtNumList;
	}

	public void setPrdtNumList(List<String> prdtNumList) {
		this.prdtNumList = prdtNumList;
	}

	public String getmYn() {
		return mYn;
	}

	public void setmYn(String mYn) {
		this.mYn = mYn;
	}

	public String getSearchYn() {
		return searchYn;
	}

	public void setSearchYn(String searchYn) {
		this.searchYn = searchYn;
	}

	public String getsTradeStatus() {
		return sTradeStatus;
	}

	public void setsTradeStatus(String sTradeStatus) {
		this.sTradeStatus = sTradeStatus;
	}

	public String getsPrmtNum() {
		return sPrmtNum;
	}

	public void setsPrmtNum(String sPrmtNum) {
		this.sPrmtNum = sPrmtNum;
	}

	public String getsMappingNum() {
		return sMappingNum;
	}

	public void setsMappingNum(String sMappingNum) {
		this.sMappingNum = sMappingNum;
	}

	public List<String> getsIconCd() {
		return sIconCd;
	}

	public void setsIconCd(List<String> sIconCd) {
		this.sIconCd = sIconCd;
	}

	public String getsCarCd() {
		return sCarCd;
	}

	public void setsCarCd(String sCarCd) {
		this.sCarCd = sCarCd;
	}

	public List<String> getsCarCds() {
		return sCarCds;
	}

	public void setsCarCds(List<String> sCarCds) {
		this.sCarCds = sCarCds;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getsIsrDiv() {
		return sIsrDiv;
	}

	public void setsIsrDiv(String sIsrDiv) {
		this.sIsrDiv = sIsrDiv;
	}

	public String getsMainViewYn() {
		return sMainViewYn;
	}

	public void setsMainViewYn(String sMainViewYn) {
		this.sMainViewYn = sMainViewYn;
	}

	public String getsMakerDivCd() {
		return sMakerDivCd;
	}

	public void setsMakerDivCd(String sMakerDivCd) {
		this.sMakerDivCd = sMakerDivCd;
	}

	public String getsUseFuelDiv() {
		return sUseFuelDiv;
	}

	public void setsUseFuelDiv(String sUseFuelDiv) {
		this.sUseFuelDiv = sUseFuelDiv;
	}

	public String getsModelYear() {
		return sModelYear;
	}

	public void setsModelYear(String sModelYear) {
		this.sModelYear = sModelYear;
	}

	public String getsIsrTypeDiv() {
		return sIsrTypeDiv;
	}

	public void setsIsrTypeDiv(String sIsrTypeDiv) {
		this.sIsrTypeDiv = sIsrTypeDiv;
	}
	
	public String getsIconCdCnt() {
		return sIconCdCnt;
	}

	public void setsIconCdCnt(String sIconCdCnt) {
		this.sIconCdCnt = sIconCdCnt;
	}

	public String getsRntQlfctAge() {
		return sRntQlfctAge;
	}

	public void setsRntQlfctAge(String sRntQlfctAge) {
		this.sRntQlfctAge = sRntQlfctAge;
	}

	public String getsRcCardivNum() {
		return sRcCardivNum;
	}

	public void setsRcCardivNum(String sRcCardivNum) {
		this.sRcCardivNum = sRcCardivNum;
	}

	public String getsTamnacardYn() {
		return sTamnacardYn;
	}

	public void setsTamnacardYn(String sTamnacardYn) {
		this.sTamnacardYn = sTamnacardYn;
	}

	public String getsApiRentDiv() {
		return sApiRentDiv;
	}

	public void setsApiRentDiv(String sApiRentDiv) {
		this.sApiRentDiv = sApiRentDiv;
	}

	public String getsRntQlfctCareer() {
		return sRntQlfctCareer;
	}

	public void setsRntQlfctCareer(String sRntQlfctCareer) {
		this.sRntQlfctCareer = sRntQlfctCareer;
	}

	public String getsInfo() {
		return sInfo;
	}

	public void setsInfo(String sInfo) {
		this.sInfo = sInfo;
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
