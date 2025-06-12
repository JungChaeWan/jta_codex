package web.order.vo;

import oss.cmm.vo.pageDefaultVO;

public class AV_RSVSVO extends pageDefaultVO {
	/** 검색시작일 */
	private String sStartDt;
	/** 검색종료일 */
	private String sEndDt;
	/** 출발시작일 */
	private String sUsedStartDt;
	/** 출발종료일 */
	private String sUsedEndDt;
	/** 예약자 */
	private String sRsvNm;
	/** 판매업체 */
	private String sSaleCorp;
	/** 예약현황 */
	private String sRsvStatus;
	
	public String getsStartDt() {
		return sStartDt;
	}
	public void setsStartDt(String sStartDt) {
		this.sStartDt = sStartDt;
	}
	public String getsEndDt() {
		return sEndDt;
	}
	public void setsEndDt(String sEndDt) {
		this.sEndDt = sEndDt;
	}
	public String getsUsedStartDt() {
		return sUsedStartDt;
	}
	public void setsUsedStartDt(String sUsedStartDt) {
		this.sUsedStartDt = sUsedStartDt;
	}
	public String getsUsedEndDt() {
		return sUsedEndDt;
	}
	public void setsUsedEndDt(String sUsedEndDt) {
		this.sUsedEndDt = sUsedEndDt;
	}
	public String getsRsvNm() {
		return sRsvNm;
	}
	public void setsRsvNm(String sRsvNm) {
		this.sRsvNm = sRsvNm;
	}
	public String getsSaleCorp() {
		return sSaleCorp;
	}
	public void setsSaleCorp(String sSaleCorp) {
		this.sSaleCorp = sSaleCorp;
	}
	public String getsRsvStatus() {
		return sRsvStatus;
	}
	public void setsRsvStatus(String sRsvStatus) {
		this.sRsvStatus = sRsvStatus;
	}	
	
}
