package web.order.vo;

public class AD_RSVVO extends RSVSVO{

	/** 숙박 예약 번호 */
	private String adRsvNum;
	/** 예약 번호 */
	private String rsvNum;
	/** 예약 상태 코드 */
	private String rsvStatusCd;
	/** 업체 아이디 */
	private String corpId;
	/** 상품 번호 */
	private String prdtNum;
	/** 상품 명 */
	private String prdtNm;
	/** 상품 정보 */
	private String prdtInf;
	/** 이용 일자 */
	private String useDt;
	/** 이용 박수 */
	private String useNight;
	/** 성인 수 */
	private String adultNum;
	/** 소인 수 */
	private String juniorNum;
	/** 유아 수 */
	private String childNum;
	/** 정상 금액 */
	private String nmlAmt;
	/** 판매 금액 */
	private String saleAmt;
	/** 할인 금액 */
	private String disAmt;
	/** 취소 금액 */
	private String cancelAmt;
	/** 할인 취소 금액 */
	private String disCancelAmt;
	/** 수정 일시 */
	private String modDttm;
	/** 정산 여부 */
	private String adjYn;
	/** 정산 일자 */
	private String adjDt;
	/** 수수료 금액 */
	private String cmssAmt;
	/** 매핑 예약 번호 */
	private String mappingRsvNum;
	/** 예약 확인 여부 */
	private String rsvIdtYn;
	
	/** 예약 명  */
	private String rsvNm;
	/** 예약 전화번호  */
	private String rsvTelnum;
	/** 사용 명  */
	private String useNm;
	/** 사용 이메일  */
	private String useTelnum;
	
	
	private String rsvEmail;
	private String useEmail;
	private String payDiv;
	private String regDttm;
	
	private String useepilRegYn;
	
	/** 취소사유 */
	private String cancelInf;
	/** 취소 요청 일시*/
	private String cancelRequestDttm;
	/** 환불 요청 일시 */
	private String refundRequestDttm;
	/** 취소 완료 일시 */
	private String cancelCmplDttm;
	/** 취소 사유 */
	private String cancelRsn;
	
	/** 예상정산액 */
	private String adjAmt;
	/** 정산 상태 코드 */
	private String adjStatusCd;
	/** 정산 예정 일자 */
	private String adjItdDt;
	/** 정산 완료 일자 */
	private String adjCmplDt;	
	
	/** L.Point 사용 포인트 */
	private String lpointUsePoint;
	/** L.Point 적립 포인트 */
	private String lpointSavePoint;
	
	private String userId;
	private String emailRcvAgrYn;
	/**대기시간*/
	private int waitingTime;
	/** 예약취소가능시간 */
	private String cancelAbltimeYn;
	/** 환불 은행코드*/
	private String refundBankCode;
	/** 환불계좌번호*/
	private String refundAccNum;
	/** 환불 예금주명*/
	private String refundDepositor;
	/** 환불 사유 */
	private String refundRsn;
	/** Point 사용 포인트 */
	private String usePoint;
	/** 업체할인부담금 */
	private int corpDisAmt;

	public String getAdRsvNum() {
		return adRsvNum;
	}
	public void setAdRsvNum(String adRsvNum) {
		this.adRsvNum = adRsvNum;
	}
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
	public String getPrdtInf() {
		return prdtInf;
	}
	public void setPrdtInf(String prdtInf) {
		this.prdtInf = prdtInf;
	}
	public String getUseDt() {
		return useDt;
	}
	public void setUseDt(String useDt) {
		this.useDt = useDt;
	}
	public String getUseNight() {
		return useNight;
	}
	public void setUseNight(String useNight) {
		this.useNight = useNight;
	}
	public String getAdultNum() {
		return adultNum;
	}
	public void setAdultNum(String adultNum) {
		this.adultNum = adultNum;
	}
	public String getJuniorNum() {
		return juniorNum;
	}
	public void setJuniorNum(String juniorNum) {
		this.juniorNum = juniorNum;
	}
	public String getChildNum() {
		return childNum;
	}
	public void setChildNum(String childNum) {
		this.childNum = childNum;
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
	public String getDisAmt() {
		return disAmt;
	}
	public void setDisAmt(String disAmt) {
		this.disAmt = disAmt;
	}
	public String getCancelAmt() {
		return cancelAmt;
	}
	public void setCancelAmt(String cancelAmt) {
		this.cancelAmt = cancelAmt;
	}
	public String getModDttm() {
		return modDttm;
	}
	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}
	public String getAdjYn() {
		return adjYn;
	}
	public void setAdjYn(String adjYn) {
		this.adjYn = adjYn;
	}
	public String getAdjDt() {
		return adjDt;
	}
	public void setAdjDt(String adjDt) {
		this.adjDt = adjDt;
	}
	public String getCmssAmt() {
		return cmssAmt;
	}
	public void setCmssAmt(String cmssAmt) {
		this.cmssAmt = cmssAmt;
	}
	public String getMappingRsvNum() {
		return mappingRsvNum;
	}
	public void setMappingRsvNum(String mappingRsvNum) {
		this.mappingRsvNum = mappingRsvNum;
	}
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getRsvNm() {
		return rsvNm;
	}
	public void setRsvNm(String rsvNm) {
		this.rsvNm = rsvNm;
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
	public String getUseTelnum() {
		return useTelnum;
	}
	public void setUseTelnum(String useTelnum) {
		this.useTelnum = useTelnum;
	}
	public String getDisCancelAmt() {
		return disCancelAmt;
	}
	public void setDisCancelAmt(String disCancelAmt) {
		this.disCancelAmt = disCancelAmt;
	}
	public String getRsvEmail() {
		return rsvEmail;
	}
	public void setRsvEmail(String rsvEmail) {
		this.rsvEmail = rsvEmail;
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
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getUseepilRegYn() {
		return useepilRegYn;
	}
	public void setUseepilRegYn(String useepilRegYn) {
		this.useepilRegYn = useepilRegYn;
	}
	public String getCancelInf() {
		return cancelInf;
	}
	public void setCancelInf(String cancelInf) {
		this.cancelInf = cancelInf;
	}
	public String getRsvIdtYn() {
		return rsvIdtYn;
	}
	public void setRsvIdtYn(String rsvIdtYn) {
		this.rsvIdtYn = rsvIdtYn;
	}
	public String getCancelRequestDttm() {
		return cancelRequestDttm;
	}
	public void setCancelRequestDttm(String cancelRequestDttm) {
		this.cancelRequestDttm = cancelRequestDttm;
	}
	public String getRefundRequestDttm() {
		return refundRequestDttm;
	}
	public void setRefundRequestDttm(String refundRequestDttm) {
		this.refundRequestDttm = refundRequestDttm;
	}
	public String getCancelCmplDttm() {
		return cancelCmplDttm;
	}
	public void setCancelCmplDttm(String cancelCmplDttm) {
		this.cancelCmplDttm = cancelCmplDttm;
	}
	public String getCancelRsn() {
		return cancelRsn;
	}
	public void setCancelRsn(String cancelRsn) {
		this.cancelRsn = cancelRsn;
	}
	public String getAdjAmt() {
		return adjAmt;
	}
	public void setAdjAmt(String adjAmt) {
		this.adjAmt = adjAmt;
	}
	public String getAdjStatusCd() {
		return adjStatusCd;
	}
	public void setAdjStatusCd(String adjStatusCd) {
		this.adjStatusCd = adjStatusCd;
	}
	public String getAdjItdDt() {
		return adjItdDt;
	}
	public void setAdjItdDt(String adjItdDt) {
		this.adjItdDt = adjItdDt;
	}
	public String getAdjCmplDt() {
		return adjCmplDt;
	}
	public void setAdjCmplDt(String adjCmplDt) {
		this.adjCmplDt = adjCmplDt;
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getEmailRcvAgrYn() {
		return emailRcvAgrYn;
	}
	public void setEmailRcvAgrYn(String emailRcvAgrYn) {
		this.emailRcvAgrYn = emailRcvAgrYn;
	}
	public int getWaitingTime() {
		return waitingTime;
	}
	public void setWaitingTime(int waitingTime) {
		this.waitingTime = waitingTime;
	}

	public String getCancelAbltimeYn() {
		return cancelAbltimeYn;
	}

	public void setCancelAbltimeYn(String cancelAbltimeYn) {
		this.cancelAbltimeYn = cancelAbltimeYn;
	}

	public String getRefundBankCode() {
		return refundBankCode;
	}

	public void setRefundBankCode(String refundBankCode) {
		this.refundBankCode = refundBankCode;
	}

	public String getRefundAccNum() {
		return refundAccNum;
	}

	public void setRefundAccNum(String refundAccNum) {
		this.refundAccNum = refundAccNum;
	}

	public String getRefundDepositor() {
		return refundDepositor;
	}

	public void setRefundDepositor(String refundDepositor) {
		this.refundDepositor = refundDepositor;
	}

	public String getRefundRsn() {
		return refundRsn;
	}

	public void setRefundRsn(String refundRsn) {
		this.refundRsn = refundRsn;
	}

	public String getUsePoint() {
		return usePoint;
	}

	public void setUsePoint(String usePoint) {
		this.usePoint = usePoint;
	}

	public int getCorpDisAmt() {
		return corpDisAmt;
	}

	public void setCorpDisAmt(int corpDisAmt) {
		this.corpDisAmt = corpDisAmt;
	}
}
