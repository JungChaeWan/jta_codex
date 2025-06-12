package mas.sp.vo;

public class SP_DIVINFVO {
	/** 소셜 상품 번호 */
	private String prdtNum;
	/** 소셜상품 구분 순번 */
	private Integer spDivSn;
	/** 상품 구분 명 */
	private String prdtDivNm;
	/** 노출 순번 */
	private String viewSn;
	
	/** 이전 노출순번 */
	private String oldSn;
	/** 새로운 노출 순번 */
	private String newSn;
	
	private String pageIndex;
	
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

	public String getPrdtDivNm() {
		return prdtDivNm;
	}

	public void setPrdtDivNm(String prdtDivNm) {
		this.prdtDivNm = prdtDivNm;
	}

	public String getViewSn() {
		return viewSn;
	}

	public void setViewSn(String viewSn) {
		this.viewSn = viewSn;
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
