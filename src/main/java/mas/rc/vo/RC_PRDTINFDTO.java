package mas.rc.vo;

public class RC_PRDTINFDTO {

	/** 업체 아이디 */
	private String corpId;
	/** 상품 번호 */
	private String prdtNum;
	/** 상품 명 */
	private String prdtNm;
	/** 정원 */
	private String maxiNum;
	/** 차량 구분 */
	private String carDiv;
	/** 사용 연료 구분 */
	private String useFuelDiv;
	/** 사용 연료 구분 명 */
	private String useFuelDivNm;

	/** 제조사 구분  */
	private String makerDiv;
	/** 구매 수  */
	private String buyNum;
	/** 연식 */
	private String modelYear;
	/** 선택시간 */
	private String rsvTm;
	/** 계산된 기준시간 */
	private String saleTm;
	/** 업체 명 */
	private String corpNm;
	/** 정상가 */
	private String nmlAmt;
	/** 판매가 */
	private String saleAmt;
	/** 대표 이미지 파일명 */
	private String saveFileNm;

	/** 주요정보 */
	private String iconCds;

	/** 보험여부 구분 */
	private String isrDiv;
	private String rcCardivNum;
	/** 보험 종류 구분 */
	private String isrTypeDiv;
	/** 대여 조건 */
	private String rntQlfctAge; // 나이
	private String rntQlfctCareer; // 운전경력
	private String rntQlfctLicense; // 면허종류
	/** 일반자차 */
	private String generalIsrAmt; // 요금
	private String generalIsrAge; // 나이
	private String generalIsrCareer; // 운전경력
	private String generalIsrRewardAmt; // 보상한도
	private String generalIsrBurcha; // 고객부담금
	/** 고급자차 */
	private String luxyIsrAmt; // 요금
	private String luxyIsrAge; // 나이
	private String luxyIsrCareer; // 운전경력
	private String luxyIsrRewardAmt; // 보상한도
	private String luxyIsrBurcha; // 고객부담금
	/** 탐나는전 예약가능 여부 **/
	private String tamnacardYn;
	/** 우수관광사업체 */
	private String superbCorpYn;
	/** 할인쿠폰 1:있음 0:없음 */
	private String couponCnt;

	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getNmlAmt() {
		return nmlAmt;
	}
	public void setNmlAmt(String nmlAmt) {
		this.nmlAmt = nmlAmt;
	}
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getSaveFileNm() {
		return saveFileNm;
	}
	public void setSaveFileNm(String saveFileNm) {
		this.saveFileNm = saveFileNm;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getMaxiNum() {
		return maxiNum;
	}
	public void setMaxiNum(String maxiNum) {
		this.maxiNum = maxiNum;
	}
	public String getCarDiv() {
		return carDiv;
	}
	public void setCarDiv(String carDiv) {
		this.carDiv = carDiv;
	}
	public String getUseFuelDiv() {
		return useFuelDiv;
	}
	public void setUseFuelDiv(String useFuelDiv) {
		this.useFuelDiv = useFuelDiv;
	}
	public String getMakerDiv() {
		return makerDiv;
	}
	public void setMakerDiv(String makerDiv) {
		this.makerDiv = makerDiv;
	}
	public String getBuyNum() {
		return buyNum;
	}
	public void setBuyNum(String buyNum) {
		this.buyNum = buyNum;
	}
	public String getRsvTm() {
		return rsvTm;
	}
	public void setRsvTm(String rsvTm) {
		this.rsvTm = rsvTm;
	}
	public String getSaleTm() {
		return saleTm;
	}
	public void setSaleTm(String saleTm) {
		this.saleTm = saleTm;
	}
	public String getUseFuelDivNm() {
		return useFuelDivNm;
	}
	public void setUseFuelDivNm(String useFuelDivNm) {
		this.useFuelDivNm = useFuelDivNm;
	}
	public String getIsrDiv() {
		return isrDiv;
	}
	public void setIsrDiv(String isrDiv) {
		this.isrDiv = isrDiv;
	}
	public String getRcCardivNum() {
		return rcCardivNum;
	}
	public void setRcCardivNum(String rcCardivNum) {
		this.rcCardivNum = rcCardivNum;
	}
	public String getIsrTypeDiv() {
		return isrTypeDiv;
	}
	public void setIsrTypeDiv(String isrTypeDiv) {
		this.isrTypeDiv = isrTypeDiv;
	}
	public String getRntQlfctAge() {
		return rntQlfctAge;
	}
	public void setRntQlfctAge(String rntQlfctAge) {
		this.rntQlfctAge = rntQlfctAge;
	}
	public String getRntQlfctCareer() {
		return rntQlfctCareer;
	}
	public void setRntQlfctCareer(String rntQlfctCareer) {
		this.rntQlfctCareer = rntQlfctCareer;
	}
	public String getRntQlfctLicense() {
		return rntQlfctLicense;
	}
	public void setRntQlfctLicense(String rntQlfctLicense) {
		this.rntQlfctLicense = rntQlfctLicense;
	}
	public String getGeneralIsrAmt() {
		return generalIsrAmt;
	}
	public void setGeneralIsrAmt(String generalIsrAmt) {
		this.generalIsrAmt = generalIsrAmt;
	}
	public String getGeneralIsrAge() {
		return generalIsrAge;
	}
	public void setGeneralIsrAge(String generalIsrAge) {
		this.generalIsrAge = generalIsrAge;
	}
	public String getGeneralIsrCareer() {
		return generalIsrCareer;
	}
	public void setGeneralIsrCareer(String generalIsrCareer) {
		this.generalIsrCareer = generalIsrCareer;
	}
	public String getGeneralIsrRewardAmt() {
		return generalIsrRewardAmt;
	}
	public void setGeneralIsrRewardAmt(String generalIsrRewardAmt) {
		this.generalIsrRewardAmt = generalIsrRewardAmt;
	}
	public String getGeneralIsrBurcha() {
		return generalIsrBurcha;
	}
	public void setGeneralIsrBurcha(String generalIsrBurcha) {
		this.generalIsrBurcha = generalIsrBurcha;
	}
	public String getLuxyIsrAmt() {
		return luxyIsrAmt;
	}
	public void setLuxyIsrAmt(String luxyIsrAmt) {
		this.luxyIsrAmt = luxyIsrAmt;
	}
	public String getLuxyIsrAge() {
		return luxyIsrAge;
	}
	public void setLuxyIsrAge(String luxyIsrAge) {
		this.luxyIsrAge = luxyIsrAge;
	}
	public String getLuxyIsrCareer() {
		return luxyIsrCareer;
	}
	public void setLuxyIsrCareer(String luxyIsrCareer) {
		this.luxyIsrCareer = luxyIsrCareer;
	}
	public String getLuxyIsrRewardAmt() {
		return luxyIsrRewardAmt;
	}
	public void setLuxyIsrRewardAmt(String luxyIsrRewardAmt) {
		this.luxyIsrRewardAmt = luxyIsrRewardAmt;
	}
	public String getLuxyIsrBurcha() {
		return luxyIsrBurcha;
	}
	public void setLuxyIsrBurcha(String luxyIsrBurcha) {
		this.luxyIsrBurcha = luxyIsrBurcha;
	}
	public String getIconCds() {
		return iconCds;
	}
	public void setIconCds(String iconCds) {
		this.iconCds = iconCds;
	}
	public String getTamnacardYn() {
		return tamnacardYn;
	}
	public void setTamnacardYn(String tamnacardYn) {
		this.tamnacardYn = tamnacardYn;
	}

	public String getModelYear() {
		return modelYear;
	}

	public void setModelYear(String modelYear) {
		this.modelYear = modelYear;
	}

	public String getSuperbCorpYn() {
		return superbCorpYn;
	}

	public void setSuperbCorpYn(String superbCorpYn) {
		this.superbCorpYn = superbCorpYn;
	}

	public String getCouponCnt() {
		return couponCnt;
	}

	public void setCouponCnt(String couponCnt) {
		this.couponCnt = couponCnt;
	}
}
