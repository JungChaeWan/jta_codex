package web.order.vo;

import oss.cmm.vo.pageDefaultVO;

public class RSVSVO extends pageDefaultVO{

	private String sCorpId;
	/** 대여일 */
	private String sRentStartDt;
	/** 대여일 View */
	private String sRentStartDtView;
	/** 이용 종료일 */
	private String sRentEndDt;
	/** 이용 종료일 View */
	private String sRentEndDtView;
	/** 예약자 */
	private String sRsvNm;
	/** 사용자 */
	private String sUseNm;
	/** 예약자 전화번호 */
	private String sRsvTelnum;
	/** 사용자 전화번호 */
	private String sUseTelnum;
	/** 상품 */
	private String sPrdtNum;
	/** 상품 명 */
	private String sPrdtNm;
	/** 옵션 명 */
	private String sOptNm;
	/** 업체 명 */
	private String sCorpNm;
	/** 예약번호 */
	private String sRsvNum;
	
	/** 예약 상태 */
	private String sRsvStatusCd;
	
	/** 자동취소포함여부 */
	private String sAutoCancelViewYn;
	
	/** 검색시작일 */
	private String sStartDt;
	/** 검색종료일 */
	private String sEndDt;
	/** 사용시작일 */
	private String sUsedStartDt;
	/** 사용종료일 */
	private String sUsedEndDt;
	/** 상품 구분 */
	private String sPrdtCd;
	/** 상품 sub 구분 */
	private String sPrdtSubCd;
	
	private String [] sRsvNumList;
	
	private String sGuestYn;
	
	private String sUseDt;
	
	private String sRsvCorpId;
	/** 앱 구분 */
	private String sAppDiv;
	/** 이벤트 코드 */
	private String sEvntCd;
	
	private String sLpointDiv;
	/** 적용일자 */
	private String sAplDt;
	
	/** 미예약확인 */
	private String sRsvIdtYn;

	/**파트너(협력사) 포인트*/
	private String partnerCode;

	/** 사용자 아이디 */
	private String userId;

	public String getsCorpId() {
		return sCorpId;
	}

	public void setsCorpId(String sCorpId) {
		this.sCorpId = sCorpId;
	}

	public String getsRentStartDt() {
		return sRentStartDt;
	}

	public void setsRentStartDt(String sRentStartDt) {
		this.sRentStartDt = sRentStartDt;
	}

	public String getsRsvNm() {
		return sRsvNm;
	}

	public void setsRsvNm(String sRsvNm) {
		this.sRsvNm = sRsvNm;
	}

	public String getsRsvTelnum() {
		return sRsvTelnum;
	}

	public void setsRsvTelnum(String sRsvTelnum) {
		this.sRsvTelnum = sRsvTelnum;
	}

	public String getsPrdtNum() {
		return sPrdtNum;
	}

	public void setsPrdtNum(String sPrdtNum) {
		this.sPrdtNum = sPrdtNum;
	}

	public String getsRentStartDtView() {
		return sRentStartDtView;
	}

	public void setsRentStartDtView(String sRentStartDtView) {
		this.sRentStartDtView = sRentStartDtView;
	}

	public String getsPrdtNm() {
		return sPrdtNm;
	}

	public void setsPrdtNm(String sPrdtNm) {
		this.sPrdtNm = sPrdtNm;
	}

	public String [] getsRsvNumList() {
		return sRsvNumList;
	}

	public void setsRsvNumList(String [] sRsvNumList) {
		this.sRsvNumList = sRsvNumList;
	}

	public String getsRsvNum() {
		return sRsvNum;
	}

	public void setsRsvNum(String sRsvNum) {
		this.sRsvNum = sRsvNum;
	}

	public String getsRsvStatusCd() {
		return sRsvStatusCd;
	}

	public void setsRsvStatusCd(String sRsvStatusCd) {
		this.sRsvStatusCd = sRsvStatusCd;
	}

	public String getsAutoCancelViewYn() {
		return sAutoCancelViewYn;
	}

	public void setsAutoCancelViewYn(String sAutoCancelViewYn) {
		this.sAutoCancelViewYn = sAutoCancelViewYn;
	}

	public String getsCorpNm() {
		return sCorpNm;
	}

	public void setsCorpNm(String sCorpNm) {
		this.sCorpNm = sCorpNm;
	}

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

	public String getsPrdtCd() {
		return sPrdtCd;
	}

	public void setsPrdtCd(String sPrdtCd) {
		this.sPrdtCd = sPrdtCd;
	}
	
	public String getsPrdtSubCd() {
		return sPrdtSubCd;
	}

	public void setsPrdtSubCd(String sPrdtSubCd) {
		this.sPrdtSubCd = sPrdtSubCd;
	}

	public String getsGuestYn() {
		return sGuestYn;
	}
	public void setsGuestYn(String sGuestYn) {
		this.sGuestYn = sGuestYn;
	}

	public String getsUseDt() {
		return sUseDt;
	}

	public void setsUseDt(String sUseDt) {
		this.sUseDt = sUseDt;
	}

	public String getsRsvCorpId() {
		return sRsvCorpId;
	}

	public void setsRsvCorpId(String sRsvCorpId) {
		this.sRsvCorpId = sRsvCorpId;
	}

	public String getsUseNm() {
		return sUseNm;
	}

	public void setsUseNm(String sUseNm) {
		this.sUseNm = sUseNm;
	}

	public String getsAppDiv() {
		return sAppDiv;
	}

	public void setsAppDiv(String sAppDiv) {
		this.sAppDiv = sAppDiv;
	}

	public String getsEvntCd() {
		return sEvntCd;
	}

	public void setsEvntCd(String sEvntCd) {
		this.sEvntCd = sEvntCd;
	}

	public String getsLpointDiv() {
		return sLpointDiv;
	}

	public void setsLpointDiv(String sLpointDiv) {
		this.sLpointDiv = sLpointDiv;
	}

	public String getsOptNm() {
		return sOptNm;
	}

	public void setsOptNm(String sOptNm) {
		this.sOptNm = sOptNm;
	}

	public String getsAplDt() {
		return sAplDt;
	}

	public void setsAplDt(String sAplDt) {
		this.sAplDt = sAplDt;
	}

	public String getsUseTelnum() {
		return sUseTelnum;
	}

	public void setsUseTelnum(String sUseTelnum) {
		this.sUseTelnum = sUseTelnum;
	}

	public String getsRsvIdtYn() {
		return sRsvIdtYn;
	}

	public void setsRsvIdtYn(String sRsvIdtYn) {
		this.sRsvIdtYn = sRsvIdtYn;
	}

	public String getsRentEndDt() {
		return sRentEndDt;
	}

	public void setsRentEndDt(String sRentEndDt) {
		this.sRentEndDt = sRentEndDt;
	}

	public String getsRentEndDtView() {
		return sRentEndDtView;
	}

	public void setsRentEndDtView(String sRentEndDtView) {
		this.sRentEndDtView = sRentEndDtView;
	}

	public String getPartnerCode() {
		return partnerCode;
	}

	public void setPartnerCode(String partnerCode) {
		this.partnerCode = partnerCode;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
}
