package oss.cmm.vo;

public class CDVO extends CDSVO implements Comparable<CDVO> {

	/** 코드 번호 */
	private String cdNum;
	/** 상위 코드 번호 */
	private String hrkCdNum;
	/** 코드 명 */
	private String cdNm;
	/** 사용 여부 */
	private String useYn;
	/** 노출 순번 */
	private String viewSn;
	/** 변경 전 노출 순번 */
	private String oldSn;
	/** 변경 후 노출 순번 */
	private String newSn;
	/** 코드명 유의어 */
	private String cdNmLike;

	public String getCdNum() {
		return cdNum;
	}
	public void setCdNum(String cdNum) {
		this.cdNum = cdNum;
	}
	public String getHrkCdNum() {
		return hrkCdNum;
	}
	public void setHrkCdNum(String hrkCdNum) {
		this.hrkCdNum = hrkCdNum;
	}
	public String getCdNm() {
		return cdNm;
	}
	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
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

	public String getCdNmLike() {
		return cdNmLike;
	}

	public void setCdNmLike(String cdNmLike) {
		this.cdNmLike = cdNmLike;
	}

	// 코드명순 정렬
	@Override
	public int compareTo(CDVO cd) {
		return cdNm.compareTo(cd.getCdNm());
	}

}
