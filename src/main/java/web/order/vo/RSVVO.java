package web.order.vo;

public class RSVVO {
	private String rn;

	private String [] cartSn;

	/** 예약 구분(c : 장바구니, i : 즉시예약) */
	private String rsvDiv;

	/** 예약 정보 */
	private String rsvInf;

	/** 예약 번호 */
	private String rsvNum;
	/** 예약 상태 코드 */
	private String rsvStatusCd;
	/** 사용자 아이디 */
	private String userId;
	/** 예약 명 */
	private String rsvNm;
	/** 예약 이메일 */
	private String rsvEmail;
	/** 예약 전화번호 */
	private String rsvTelnum;
	/** 사용 명 */
	private String useNm;
	/** 사용 이메일 */
	private String useEmail;
	/** 사용 전화번호 */
	private String useTelnum;
	/** 결제 구분 */
	private String payDiv;
	/** 총 정상 금액 */
	private String totalNmlAmt;
	/** 총 판매 금액 */
	private String totalSaleAmt;
	/** 총 결제 금액 */
	private String totalPayAmt;
	/** 총 할인 금액 */
	private String totalDisAmt;
	/** 총 취소 금액 */
	private String totalCancelAmt;
	/** 등록 일시 */
	private String regDttm;
	/** 등록 아이피 */
	private String regIp;
	/** 수정 일시 */
	private String modDttm;
	/** 수정 아이피 */
	private String modIp;
	/** 총 수수료 금액 */
	private String totalCmssAmt;
	/** 총 할인 취소 금액 */
	private String totalDisCancelAmt;

	/** 사용쿠폰번호 */
	private String useCpNum;
	/** 쿠폰 할인 금액 */
	private String cpDisAmt;

	private String prdtRsvNum;

	private String guestYn;
	/** 자동취소여부*/
	private String autoCancelYn;

	/** 우편번호 */
	private String postNum;
	/** 도로명 주소 */
	private String roadNmAddr;
	/** 상세주소 */
	private String dtlAddr;
	/** 배송요청정보 */
	private String dlvRequestInf;
	/** 예약업체 아이디 */
	private String rsvCorpId;
	/** 앱 구분 */
	private String appDiv;
	/** 유입 경로 */
	private String flowPath;
	/** 이벤트 코드 */
	private String evntCd;

	/** L.Point 카드번호 */
	private String lpointCardNo;
	/** L.Point 카드 비밀번호 */
	private String lpointCardPw;
	/** L.Point 사용 포인트 */
	private String lpointUsePoint;
	/** L.Point 적용 포인트 */
	private String lpointSavePoint;

	private String userSmsYn;

	/** 취소 사유*/
	private String cancelRsn;
	
	/** 황금빛가을제주 포인트 사용여부*/
	private String gsPointYn;
	private String vcCd;
	/** 대기시간 */
	private int waitingTime;

	/**탐나는전 referenceId*/
	private String tamnacardRefId;
	/**탐나는전 referenceHashid*/
	private String tamnacardRefHashid;
	/**탐나는전 linkUrl*/
	private String tamnacardLinkUrl;

	/** 은행명*/
	private String LGD_FINANCENAME;
	/** 가상계좌번호*/
	private String LGD_ACCOUNTNUM;
	/** 입금자명*/
	private String LGD_PAYER;
	/** 입금상태*/
	private String LGD_CASFLAGY;
	/** 응답코드*/
	private String LGD_RESPCODE;
	/** 파트너사*/
	private String partner;
	/** 대표상품명*/
	private String repPrdtNm;

	/** 파트너(협력사) 코드 */
	private String partnerCode;
	/** 파트너(협력사) 이름 */
	private String partnerNm;
	/** 파트너(협력사) 적용포인트*/
	private int usePoint;

	/** 예약(업체)구분 */
	private String corpDiv;
	
	/** 현대캐피탈ONECARD URL TYPE */
	private String urlType;
	private String prdtNum;

	private String firstIndex = "1";
	private String lastIndex = "2";
	
	public String getRsvNum() {
		return rsvNum;
	}
	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}
	public String getRsvStatusCd() {
		return rsvStatusCd;
	}
	public void setRsvStatusCd(String rsvStatusCd) {
		this.rsvStatusCd = rsvStatusCd;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRsvNm() {
		return rsvNm;
	}
	public void setRsvNm(String rsvNm) {
		this.rsvNm = rsvNm;
	}
	public String getRsvEmail() {
		return rsvEmail;
	}
	public void setRsvEmail(String rsvEmail) {
		this.rsvEmail = rsvEmail;
	}
	public String getRsvTelnum() {
		return rsvTelnum;
	}
	public void setRsvTelnum(String rsvTelnum) {
		this.rsvTelnum = rsvTelnum;
	}
	public String getUseNm() {
		return useNm;
	}
	public void setUseNm(String useNm) {
		this.useNm = useNm;
	}
	public String getUseEmail() {
		return useEmail;
	}
	public void setUseEmail(String useEmail) {
		this.useEmail = useEmail;
	}
	public String getPayDiv() {
		return payDiv;
	}
	public void setPayDiv(String payDiv) {
		this.payDiv = payDiv;
	}
	public String getTotalNmlAmt() {
		return totalNmlAmt;
	}
	public void setTotalNmlAmt(String totalNmlAmt) {
		this.totalNmlAmt = totalNmlAmt;
	}
	public String getTotalSaleAmt() {
		return totalSaleAmt;
	}
	public void setTotalSaleAmt(String totalSaleAmt) {
		this.totalSaleAmt = totalSaleAmt;
	}
	public String getTotalPayAmt() {
		return totalPayAmt;
	}
	public void setTotalPayAmt(String totalPayAmt) {
		this.totalPayAmt = totalPayAmt;
	}
	public String getTotalDisAmt() {
		return totalDisAmt;
	}
	public void setTotalDisAmt(String totalDisAmt) {
		this.totalDisAmt = totalDisAmt;
	}
	public String getTotalCancelAmt() {
		return totalCancelAmt;
	}
	public void setTotalCancelAmt(String totalCancelAmt) {
		this.totalCancelAmt = totalCancelAmt;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getRegIp() {
		return regIp;
	}
	public void setRegIp(String regIp) {
		this.regIp = regIp;
	}
	public String getModDttm() {
		return modDttm;
	}
	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}
	public String getModIp() {
		return modIp;
	}
	public void setModIp(String modIp) {
		this.modIp = modIp;
	}
	public String [] getCartSn() {
		return cartSn;
	}
	public void setCartSn(String [] cartSn) {
		this.cartSn = cartSn;
	}
	public String getTotalCmssAmt() {
		return totalCmssAmt;
	}
	public void setTotalCmssAmt(String totalCmssAmt) {
		this.totalCmssAmt = totalCmssAmt;
	}
	public String getUseTelnum() {
		return useTelnum;
	}
	public void setUseTelnum(String useTelnum) {
		this.useTelnum = useTelnum;
	}
	public String getRsvDiv() {
		return rsvDiv;
	}
	public void setRsvDiv(String rsvDiv) {
		this.rsvDiv = rsvDiv;
	}
	public String getRsvInf() {
		return rsvInf;
	}
	public void setRsvInf(String rsvInf) {
		this.rsvInf = rsvInf;
	}
	public String getUseCpNum() {
		return useCpNum;
	}
	public void setUseCpNum(String useCpNum) {
		this.useCpNum = useCpNum;
	}
	public String getCpDisAmt() {
		return cpDisAmt;
	}
	public void setCpDisAmt(String cpDisAmt) {
		this.cpDisAmt = cpDisAmt;
	}
	public String getTotalDisCancelAmt() {
		return totalDisCancelAmt;
	}
	public void setTotalDisCancelAmt(String totalDisCancelAmt) {
		this.totalDisCancelAmt = totalDisCancelAmt;
	}
	public String getPrdtRsvNum() {
		return prdtRsvNum;
	}
	public void setPrdtRsvNum(String prdtRsvNum) {
		this.prdtRsvNum = prdtRsvNum;
	}
	public String getGuestYn() {
		return guestYn;
	}
	public void setGuestYn(String guestYn) {
		this.guestYn = guestYn;
	}
	public String getAutoCancelYn() {
		return autoCancelYn;
	}
	public void setAutoCancelYn(String autoCancelYn) {
		this.autoCancelYn = autoCancelYn;
	}
	public String getPostNum() {
		return postNum;
	}
	public void setPostNum(String postNum) {
		this.postNum = postNum;
	}
	public String getRoadNmAddr() {
		return roadNmAddr;
	}
	public void setRoadNmAddr(String roadNmAddr) {
		this.roadNmAddr = roadNmAddr;
	}
	public String getDtlAddr() {
		return dtlAddr;
	}
	public void setDtlAddr(String dtlAddr) {
		this.dtlAddr = dtlAddr;
	}
	public String getDlvRequestInf() {
		return dlvRequestInf;
	}
	public void setDlvRequestInf(String dlvRequestInf) {
		this.dlvRequestInf = dlvRequestInf;
	}
	public String getRsvCorpId() {
		return rsvCorpId;
	}
	public void setRsvCorpId(String rsvCorpId) {
		this.rsvCorpId = rsvCorpId;
	}
	public String getAppDiv() {
		return appDiv;
	}
	public void setAppDiv(String appDiv) {
		this.appDiv = appDiv;
	}
	public String getFlowPath() {
		return flowPath;
	}
	public void setFlowPath(String flowPath) {
		this.flowPath = flowPath;
	}
	public String getEvntCd() {
		return evntCd;
	}
	public void setEvntCd(String evntCd) {
		this.evntCd = evntCd;
	}

	public String getUserSmsYn() {
		return userSmsYn;
	}
	public void setUserSmsYn(String userSmsYn) {
		this.userSmsYn = userSmsYn;
	}

	public String getLpointCardNo() {
		return lpointCardNo;
	}
	public void setLpointCardNo(String lpointCardNo) {
		this.lpointCardNo = lpointCardNo;
	}
	public String getLpointCardPw() {
		return lpointCardPw;
	}
	public void setLpointCardPw(String lpointCardPw) {
		this.lpointCardPw = lpointCardPw;
	}
	public String getLpointUsePoint() {
		return lpointUsePoint;
	}
	public void setLpointUsePoint(String lpointUsePoint) {
		this.lpointUsePoint = lpointUsePoint;
	}
	public String getLpointSavePoint() {
		return lpointSavePoint;
	}
	public void setLpointSavePoint(String lpointSavePoint) {
		this.lpointSavePoint = lpointSavePoint;
	}
	public String getGsPointYn() {
		return gsPointYn;
	}
	public void setGsPointYn(String gsPointYn) {
		this.gsPointYn = gsPointYn;
	}
	public String getVcCd() {
		return vcCd;
	}
	public void setVcCd(String vcCd) {
		this.vcCd = vcCd;
	}
	public int getWaitingTime() {
		return waitingTime;
	}
	public void setWaitingTime(int waitingTime) {
		this.waitingTime = waitingTime;
	}

	public String getCancelRsn() {
		return cancelRsn;
	}

	public void setCancelRsn(String cancelRsn) {
		this.cancelRsn = cancelRsn;
	}

	public String getLGD_ACCOUNTNUM() {
		return LGD_ACCOUNTNUM;
	}

	public void setLGD_ACCOUNTNUM(String LGD_ACCOUNTNUM) {
		this.LGD_ACCOUNTNUM = LGD_ACCOUNTNUM;
	}

	public String getLGD_FINANCENAME() {
		return LGD_FINANCENAME;
	}

	public void setLGD_FINANCENAME(String LGD_FINANCENAME) {
		this.LGD_FINANCENAME = LGD_FINANCENAME;
	}

	public String getLGD_PAYER() {
		return LGD_PAYER;
	}

	public void setLGD_PAYER(String LGD_PAYER) {
		this.LGD_PAYER = LGD_PAYER;
	}

	public String getLGD_CASFLAGY() {
		return LGD_CASFLAGY;
	}

	public void setLGD_CASFLAGY(String LGD_CASFLAGY) {
		this.LGD_CASFLAGY = LGD_CASFLAGY;
	}

	public String getLGD_RESPCODE() {
		return LGD_RESPCODE;
	}

	public void setLGD_RESPCODE(String LGD_RESPCODE) {
		this.LGD_RESPCODE = LGD_RESPCODE;
	}

	public String getRn() {
		return rn;
	}

	public void setRn(String rn) {
		this.rn = rn;
	}

	public String getPartner() {
		return partner;
	}

	public void setPartner(String partner) {
		this.partner = partner;
	}

	public String getTamnacardRefId() {
		return tamnacardRefId;
	}

	public void setTamnacardRefId(String tamnacardRefId) {
		this.tamnacardRefId = tamnacardRefId;
	}

	public String getTamnacardLinkUrl() {
		return tamnacardLinkUrl;
	}

	public void setTamnacardLinkUrl(String tamnacardLinkUrl) {
		this.tamnacardLinkUrl = tamnacardLinkUrl;
	}

	public String getRepPrdtNm() {
		return repPrdtNm;
	}

	public void setRepPrdtNm(String repPrdtNm) {
		this.repPrdtNm = repPrdtNm;
	}

	public String getPartnerCode() {
		return partnerCode;
	}

	public void setPartnerCode(String partnerCode) {
		this.partnerCode = partnerCode;
	}

	public String getPartnerNm() {
		return partnerNm;
	}

	public void setPartnerNm(String partnerNm) {
		this.partnerNm = partnerNm;
	}

	public int getUsePoint() {
		return usePoint;
	}

	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}

	public String getTamnacardRefHashid() {
		return tamnacardRefHashid;
	}

	public void setTamnacardRefHashid(String tamnacardRefHashid) {
		this.tamnacardRefHashid = tamnacardRefHashid;
	}

	public String getCorpDiv() {
		return corpDiv;
	}

	public void setCorpDiv(String corpDiv) {
		this.corpDiv = corpDiv;
	}
	public String getUrlType() {
		return urlType;
	}
	public void setUrlType(String urlType) {
		this.urlType = urlType;
	}
	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}

	public String getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(String firstIndex) {
		this.firstIndex = firstIndex;
	}

	public String getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(String lastIndex) {
		this.lastIndex = lastIndex;
	}
}
