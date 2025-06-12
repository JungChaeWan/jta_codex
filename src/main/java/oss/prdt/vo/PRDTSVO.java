package oss.prdt.vo;

import oss.cmm.vo.pageDefaultVO;

public class PRDTSVO extends pageDefaultVO{

	/** 상품명 */
	private String sPrdtNm;
	/** 거래상태 */
	private String sTradeStatus;
	/** 업체명 */
	private String sCorpNm;
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
	/** 승인요청시작일 */
	private String sConfRequestStartDt;
	/** 승인요청종료일 */
	private String sConfRequestEndDt;
	/** 승인시작일 */
	private String sConfStartDt;
	/** 승인종료일 */
	private String sConfEndDt;
	/** 상품검색코드 */
	private String sPrdtCd;
	
	/** 노출 여부 */
	private String sDisplayYn;
	
	/** 업체 아이디 */
	private String sCorpId;
	
	/** 지역 */
	private String sAreaCd;
	
	/*수량만료 개월수*/
	private String sMonthEnd;

	private String sCorpCd;

	private String sTamnacardPrdtYn;

	private String sPrdtNum;

	public String getsPrdtNm() {
		return sPrdtNm;
	}

	public void setsPrdtNm(String sPrdtNm) {
		this.sPrdtNm = sPrdtNm;
	}

	public String getsTradeStatus() {
		return sTradeStatus;
	}

	public void setsTradeStatus(String sTradeStatus) {
		this.sTradeStatus = sTradeStatus;
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

	public String getsCorpNm() {
		return sCorpNm;
	}

	public void setsCorpNm(String sCorpNm) {
		this.sCorpNm = sCorpNm;
	}

	public String getsConfRequestStartDt() {
		return sConfRequestStartDt;
	}

	public void setsConfRequestStartDt(String sConfRequestStartDt) {
		this.sConfRequestStartDt = sConfRequestStartDt;
	}

	public String getsConfRequestEndDt() {
		return sConfRequestEndDt;
	}

	public void setsConfRequestEndDt(String sConfRequestEndDt) {
		this.sConfRequestEndDt = sConfRequestEndDt;
	}

	public String getsPrdtCd() {
		return sPrdtCd;
	}

	public void setsPrdtCd(String sPrdtCd) {
		this.sPrdtCd = sPrdtCd;
	}

	public String getsDisplayYn() {
		return sDisplayYn;
	}

	public void setsDisplayYn(String sDisplayYn) {
		this.sDisplayYn = sDisplayYn;
	}

	public String getsCorpId() {
		return sCorpId;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsAreaCd() {
		return sAreaCd;
	}

	public void setsAreaCd(String sAreaCd) {
		this.sAreaCd = sAreaCd;
	}

	public String getsMonthEnd() {
		return sMonthEnd;
	}

	public void setsMonthEnd(String sMonthEnd) {
		this.sMonthEnd = sMonthEnd;
	}

	public String getsCorpCd() {
		return sCorpCd;
	}

	public void setsCorpCd(String sCorpCd) {
		this.sCorpCd = sCorpCd;
	}

	public String getsTamnacardPrdtYn() {
		return sTamnacardPrdtYn;
	}

	public void setsTamnacardPrdtYn(String sTamnacardPrdtYn) {
		this.sTamnacardPrdtYn = sTamnacardPrdtYn;
	}

	public String getsPrdtNum() {
		return sPrdtNum;
	}

	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}

	public String getsConfStartDt() {
		return sConfStartDt;
	}

	public void setsConfStartDt(String sConfStartDt) {
		this.sConfStartDt = sConfStartDt;
	}

	public String getsConfEndDt() {
		return sConfEndDt;
	}

	public void setsConfEndDt(String sConfEndDt) {
		this.sConfEndDt = sConfEndDt;
	}
}
