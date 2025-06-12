package mas.sp.vo;

import oss.cmm.vo.pageDefaultVO;

public class SP_PRDTINFSVO extends pageDefaultVO {

	// 업체 ID
	private String sCorpId;
	// 처리상태
	private String sTradeStatus;
	// 신청시작일
	private String sConfRequestStartDt;
	// 신청종료일
	private String sConfRequestEndDt;
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
	
	// 정렬
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

	public String getsOrderCd() {
		return sOrderCd;
	}

	public void setsOrderCd(String sOrderCd) {
		this.sOrderCd = sOrderCd;
	}
}
