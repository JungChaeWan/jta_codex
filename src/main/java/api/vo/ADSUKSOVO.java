package api.vo;

public class ADSUKSOVO {
	
	private String url;
	private String rtCode;
	
	private String authkey;		//인증키
	private String corpId;			//탐나오 입점 업체 아이디(숙소코드동일)
	private String prdtNum;		//제품 번호
	
	private String roomType;		//객실타입 유형
	private String startDt;		//투숙시작일자(YYYYMMDD)
	private String useDay;			//숙박일수
	private String yeyakNm;		//예약자 이름
	private String userNm;			//투숙자 이름
	private String mobile;			//연락처
	private String email;			//이메일 
	private String inwonBig;		//성인인원
	private String inwonSmall;		//소아인원
	private String inwonTiny;		//유아인원
	private String chargeNormal;	//정상가
	private String charge;			//판매가
	
	private String yeyakNo; 		//예약번호
	private String cancelCharge;	//취소수수료
	private String cancelAutoYn;	//자동취소 된 경우 Y/ 아니면 N
	private String CancelReslYn;	//취소접수 된 경우 Y/ 아니면 N
	
	
	public String getFromDt() {
		return startDt;
	}
	public void setFromDt(String startDt) {
		this.startDt = startDt;
	}
	public String getNight() {
		return useDay;
	}
	public void setNight(String useDay) {
		this.useDay = useDay;
	}
	public String getMenAdult() {
		return inwonBig;
	}
	public void setMenAdult(String inwonBig) {
		this.inwonBig = inwonBig;
	}
	public String getMenJunior() {
		return inwonSmall;
	}
	public void setMenJunior(String inwonSmall) {
		this.inwonSmall = inwonSmall;
	}
	public String getMenChild() {
		return inwonTiny;
	}
	public void setMenChild(String inwonTiny) {
		this.inwonTiny = inwonTiny;
	}
	public String getTotalNmlAmt() {
		return chargeNormal;
	}
	public void setTotalNmlAmt(String chargeNormal) {
		this.chargeNormal = chargeNormal;
	}
	public String getTotalPrice() {
		return charge;
	}
	public void setTotalPrice(String charge) {
		this.charge = charge;
	}

	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getRtCode() {
		return rtCode;
	}
	public void setRtCode(String rtCode) {
		this.rtCode = rtCode;
	}
	public String getAuthkey() {
		return authkey;
	}
	public void setAuthkey(String authkey) {
		this.authkey = authkey;
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
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getUseDay() {
		return useDay;
	}
	public void setUseDay(String useDay) {
		this.useDay = useDay;
	}
	public String getYeyakNm() {
		return yeyakNm;
	}
	public void setYeyakNm(String yeyakNm) {
		this.yeyakNm = yeyakNm;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getInwonBig() {
		return inwonBig;
	}
	public void setInwonBig(String inwonBig) {
		this.inwonBig = inwonBig;
	}
	public String getInwonSmall() {
		return inwonSmall;
	}
	public void setInwonSmall(String inwonSmall) {
		this.inwonSmall = inwonSmall;
	}
	public String getInwonTiny() {
		return inwonTiny;
	}
	public void setInwonTiny(String inwonTiny) {
		this.inwonTiny = inwonTiny;
	}
	public String getChargeNormal() {
		return chargeNormal;
	}
	public void setChargeNormal(String chargeNormal) {
		this.chargeNormal = chargeNormal;
	}
	public String getCharge() {
		return charge;
	}
	public void setCharge(String charge) {
		this.charge = charge;
	}
	public String getYeyakNo() {
		return yeyakNo;
	}
	public void setYeyakNo(String yeyakNo) {
		this.yeyakNo = yeyakNo;
	}
	public String getCancelCharge() {
		return cancelCharge;
	}
	public void setCancelCharge(String cancelCharge) {
		this.cancelCharge = cancelCharge;
	}
	public String getCancelAutoYn() {
		return cancelAutoYn;
	}
	public void setCancelAutoYn(String cancelAutoYn) {
		this.cancelAutoYn = cancelAutoYn;
	}
	public String getCancelReslYn() {
		return CancelReslYn;
	}
	public void setCancelReslYn(String cancelReslYn) {
		CancelReslYn = cancelReslYn;
	}

	
}
