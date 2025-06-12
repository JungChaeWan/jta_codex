package mas.sp.vo;

import java.util.List;

public class SP_OPTINFVO extends SP_OPTINFSVO {
	/** 소셜 상품 번호 */
	private String prdtNum;
	/** 소셜상품 구분 순번 */
	private Integer spDivSn;
	/** 소셜상품 옵션 순번 */
	private Integer spOptSn;
	/** 옵션 명 */
	private String optNm;
	/** 정상금액 */
	private int nmlAmt;
	/** 판매금액 */
	private int saleAmt;
	/** 노출 순번 */
	private String viewSn;
	/** 적용 일자 */
	private String aplDt;
	/** 옵션 상품 수 */
	private Integer optPrdtNum;
	/** 판매 수 */
	private Integer saleNum;
	/** 마감여부 */
	private String ddlYn;
	/** 기준 인원 */
	private String stdMem;

	/** 구분 명 */
	private String prdtDivNm;
	/** 옵션 갯수 */
	private int optCount;
	/** 이전 노출 순번 */
	private String oldSn;
	/** 새로운 노출 순번 */
	private String newSn;
	/** 재고 갯수 ( 옵션상품수 - 판매수) */
	private String stockNum;

	private String startAplDt;
	private String endAplDt;
	private String[] aplWeek;
	
	private String printYn;
	/** 예약 건수 */
	private String rsvNum;
	/** 선택된 옵션 목록*/
	private List<String> selOptList;

	/** LS컴퍼니 상품옵션번호*/
	private String lsLinkOptNum;
	
	public String getPrdtNum() {
		return prdtNum;
	}

	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}

	public Integer getSpDivSn() {
		return spDivSn;
	}

	public void setSpDivSn(Integer spDivSn) {
		this.spDivSn = spDivSn;
	}

	public Integer getSpOptSn() {
		return spOptSn;
	}

	public void setSpOptSn(Integer spOptSn) {
		this.spOptSn = spOptSn;
	}

	public String getOptNm() {
		return optNm;
	}

	public void setOptNm(String optNm) {
		this.optNm = optNm;
	}


	public int getNmlAmt() {
		return nmlAmt;
	}

	public void setNmlAmt(int nmlAmt) {
		this.nmlAmt = nmlAmt;
	}

	public String getViewSn() {
		return viewSn;
	}

	public void setViewSn(String viewSn) {
		this.viewSn = viewSn;
	}

	public String getAplDt() {
		return aplDt;
	}

	public void setAplDt(String aplDt) {
		this.aplDt = aplDt;
	}



	public int getSaleAmt() {
		return saleAmt;
	}

	public void setSaleAmt(int saleAmt) {
		this.saleAmt = saleAmt;
	}

	public Integer getOptPrdtNum() {
		return optPrdtNum;
	}

	public void setOptPrdtNum(Integer optPrdtNum) {
		this.optPrdtNum = optPrdtNum;
	}

	public Integer getSaleNum() {
		return saleNum;
	}

	public void setSaleNum(Integer saleNum) {
		this.saleNum = saleNum;
	}

	public String getDdlYn() {
		return ddlYn;
	}

	public void setDdlYn(String ddlYn) {
		this.ddlYn = ddlYn;
	}

	public String getPrdtDivNm() {
		return prdtDivNm;
	}

	public void setPrdtDivNm(String prdtDivNm) {
		this.prdtDivNm = prdtDivNm;
	}

	public int getOptCount() {
		return optCount;
	}

	public void setOptCount(int optCount) {
		this.optCount = optCount;
	}

	public String getOldSn() {
		return oldSn;
	}

	public void setOldSn(String oldSn) {
		this.oldSn = oldSn;
	}

	public String getNewSn() {
		return newSn;
	}

	public void setNewSn(String newSn) {
		this.newSn = newSn;
	}

	public String getStockNum() {
		return stockNum;
	}

	public void setStockNum(String stockNum) {
		this.stockNum = stockNum;
	}

	
	public String getStartAplDt() {
		return startAplDt;
	}

	public void setStartAplDt(String startAplDt) {
		this.startAplDt = startAplDt;
	}

	public String getEndAplDt() {
		return endAplDt;
	}

	public void setEndAplDt(String endAplDt) {
		this.endAplDt = endAplDt;
	}

	public String[] getAplWeek() {
		return aplWeek;
	}

	public void setAplWeek(String[] aplWeek) {
		this.aplWeek = aplWeek;
	}

	public String getStdMem() {
		return stdMem;
	}

	public void setStdMem(String stdMem) {
		this.stdMem = stdMem;
	}

	public String getPrintYn() {
		return printYn;
	}

	public void setPrintYn(String printYn) {
		this.printYn = printYn;
	}

	public String getRsvNum() {
		return rsvNum;
	}

	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}

	public List<String> getSelOptList() {
		return selOptList;
	}

	public void setSelOptList(List<String> selOptList) {
		this.selOptList = selOptList;
	}

	public String getLsLinkOptNum() {
		return lsLinkOptNum;
	}

	public void setLsLinkOptNum(String lsLinkOptNum) {
		this.lsLinkOptNum = lsLinkOptNum;
	}
}
