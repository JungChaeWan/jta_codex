package web.order.vo;

import java.util.Date;

public class AV_RSVVO {
	/** 항공 예약 번호 */
	private String avRsvNum;
	/** 판매 업체 구분 */
	private String saleCorpDiv;
	/** 예약번호 */
	private String rsvNum;
	/** 예약 명 */
	private String rsvNm;
	/** 예약 일시 */
	private Date rsvDttm;
	/** 항공 업체 구분 */
	private String avCorpDiv;
	/** 시작 코스 구분 */
	private String startCourseDiv;
	/** 종료 코스 구분 */
	private String endCourseDiv;
	/** 이용 일시 */
	private Date useDttm;
	/** 인원 */
	private String mem;
	/** 판매 금액 */
	private String saleAmt;
	/** 예약 상태 코드 */
	private String rsvStatusCd;
	
	public String getAvRsvNum() {
		return avRsvNum;
	}
	public void setAvRsvNum(String avRsvNum) {
		this.avRsvNum = avRsvNum;
	}
	public String getSaleCorpDiv() {
		return saleCorpDiv;
	}
	public void setSaleCorpDiv(String saleCorpDiv) {
		this.saleCorpDiv = saleCorpDiv;
	}
	public String getRsvNum() {
		return rsvNum;
	}
	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}
	public String getRsvNm() {
		return rsvNm;
	}
	public void setRsvNm(String rsvNm) {
		this.rsvNm = rsvNm;
	}
	public Date getRsvDttm() {
		return rsvDttm;
	}
	public void setRsvDttm(Date rsvDttm) {
		this.rsvDttm = rsvDttm;
	}
	public String getAvCorpDiv() {
		return avCorpDiv;
	}
	public void setAvCorpDiv(String avCorpDiv) {
		this.avCorpDiv = avCorpDiv;
	}
	public String getStartCourseDiv() {
		return startCourseDiv;
	}
	public void setStartCourseDiv(String startCourseDiv) {
		this.startCourseDiv = startCourseDiv;
	}
	public String getEndCourseDiv() {
		return endCourseDiv;
	}
	public void setEndCourseDiv(String endCourseDiv) {
		this.endCourseDiv = endCourseDiv;
	}
	public Date getUseDttm() {
		return useDttm;
	}
	public void setUseDttm(Date useDttm) {
		this.useDttm = useDttm;
	}
	public String getMem() {
		return mem;
	}
	public void setMem(String mem) {
		this.mem = mem;
	}
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getRsvStatusCd() {
		return rsvStatusCd;
	}
	public void setRsvStatusCd(String rsvStatusCd) {
		this.rsvStatusCd = rsvStatusCd;
	}	
}
