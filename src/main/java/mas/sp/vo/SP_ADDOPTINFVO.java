package mas.sp.vo;

public class SP_ADDOPTINFVO {

	private String prdtNum;
	private String addOptSn;
	private String viewSn;
	private String addOptNm;
	private String addOptAmt;

	private String frstRegDt;
	private String frstRegId;
	private String lastModDt;
	private String lastModId;
	
	private String pageIndex;

	/** 이전 노출 순번 */
	private String oldSn;
	/** 새로운 노출 순번 */
	private String newSn;

	public String getPrdtNum() {
		return prdtNum;
	}

	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}

	public String getAddOptSn() {
		return addOptSn;
	}

	public void setAddOptSn(String addOptSn) {
		this.addOptSn = addOptSn;
	}

	public String getViewSn() {
		return viewSn;
	}

	public void setViewSn(String viewSn) {
		this.viewSn = viewSn;
	}

	public String getAddOptNm() {
		return addOptNm;
	}

	public void setAddOptNm(String addOptNm) {
		this.addOptNm = addOptNm;
	}

	public String getAddOptAmt() {
		return addOptAmt;
	}

	public void setAddOptAmt(String addOptAmt) {
		this.addOptAmt = addOptAmt;
	}

	public String getFrstRegDt() {
		return frstRegDt;
	}

	public void setFrstRegDt(String frstRegDt) {
		this.frstRegDt = frstRegDt;
	}

	public String getFrstRegId() {
		return frstRegId;
	}

	public void setFrstRegId(String frstRegId) {
		this.frstRegId = frstRegId;
	}

	public String getLastModDt() {
		return lastModDt;
	}

	public void setLastModDt(String lastModDt) {
		this.lastModDt = lastModDt;
	}

	public String getLastModId() {
		return lastModId;
	}

	public void setLastModId(String lastModId) {
		this.lastModId = lastModId;
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

	public String getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(String pageIndex) {
		this.pageIndex = pageIndex;
	}

}
