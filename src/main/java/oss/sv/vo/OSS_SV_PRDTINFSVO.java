package oss.sv.vo;

import oss.cmm.vo.pageDefaultVO;

public class OSS_SV_PRDTINFSVO extends pageDefaultVO {
	// 업체 ID
	private String sCorpId;
	// 처리상태
	private String sTradeStatus;
	// 신청시작일
	private String sConfRequestStartDt;
	// 신청종료일
	private String sConfRequestEndDt;
	// 요청시작일
	private String sConfStartDt;
	// 요청종료일
	private String sConfEndDt;
	// 판매시작일
	private String sSaleStartDt;
	// 판매종료일
	private String sSaleEndDt;
	// 업체명
	private String sCorpNm;
	// 상품명
	private String sPrdtNm;
	// 소셜상품번호
	private String sPrdtNum;

	// 판매중 이거나 판매 예정 == true;.
	private String stockYn;

	// 카테고리
	private String sCtgr;
	
	// 서브 카테고리
	private String sSubCtgr;

	// 기간만료 상품.(2주)
	private String sExprYn;
	
	//우수기념품 여부
	private String sSuperbSvYn;
	// JQ인증 여부
	private String sJqYn;
	
	// 노출 여부
	private String sDisplayYn;

	private String sOrderCd;

	public String getsCorpId() {
		return sCorpId;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsTradeStatus() {
		return sTradeStatus;
	}

	public void setsTradeStatus(String sTradeStatus) {
		this.sTradeStatus = sTradeStatus;
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

	public String getsSaleStartDt() {
		return sSaleStartDt;
	}

	public void setsSaleStartDt(String sSaleStartDt) {
		this.sSaleStartDt = sSaleStartDt;
	}

	public String getsSaleEndDt() {
		return sSaleEndDt;
	}

	public void setsSaleEndDt(String sSaleEndDt) {
		this.sSaleEndDt = sSaleEndDt;
	}

	public String getsCorpNm() {
		return sCorpNm;
	}

	public void setsCorpNm(String sCorpNm) {
		this.sCorpNm = sCorpNm;
	}

	public String getsPrdtNm() {
		return sPrdtNm;
	}

	public void setsPrdtNm(String sPrdtNm) {
		this.sPrdtNm = sPrdtNm;
	}

	public String getsPrdtNum() {
		return sPrdtNum;
	}

	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}

	public String getStockYn() {
		return stockYn;
	}

	public void setStockYn(String stockYn) {
		this.stockYn = stockYn;
	}

	public String getsCtgr() {
		return sCtgr;
	}

	public void setsCtgr(String sCtgr) {
		this.sCtgr = sCtgr;
	}

	public String getsSubCtgr() {
		return sSubCtgr;
	}

	public void setsSubCtgr(String sSubCtgr) {
		this.sSubCtgr = sSubCtgr;
	}

	public String getsExprYn() {
		return sExprYn;
	}

	public void setsExprYn(String sExprYn) {
		this.sExprYn = sExprYn;
	}

	public String getsSuperbSvYn() {
		return sSuperbSvYn;
	}

	public void setsSuperbSvYn(String sSuperbSvYn) {
		this.sSuperbSvYn = sSuperbSvYn;
	}

	public String getsDisplayYn() {
		return sDisplayYn;
	}

	public void setsDisplayYn(String sDisplayYn) {
		this.sDisplayYn = sDisplayYn;
	}

	public String getsJqYn() {
		return sJqYn;
	}

	public void setsJqYn(String sJqYn) {
		this.sJqYn = sJqYn;
	}

	public String getsOrderCd() {
		return sOrderCd;
	}

	public void setsOrderCd(String sOrderCd) {
		this.sOrderCd = sOrderCd;
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
