package web.order.vo;

public class SV_RSVVO extends RSVSVO{

	/** 관광기념품 예약 번호 */
	private String svRsvNum;
	/** 예약 번호 */
	private String rsvNum;
	/** 예약 상태 코드 */
	private String rsvStatusCd;
	/** 예약 상태 명 */
	private String rsvStatusNm;
	/** 업체 아이디 */
	private String corpId;
	/** 업체명 */
	private String corpNm;
	/** 상품 번호 */
	private String prdtNum;
	/** 기념품 구분 순번 */
	private String svDivSn;
	/** 기념품 옵션 순번 */
	private String svOptSn;
	/** 상품 정보 */
	private String prdtInf;
	/** 구매 수 */
	private String buyNum;
	/** 정상 금액 */
	private String nmlAmt;
	/** 판매 금액 */
	private String saleAmt;
	/** 할인 금액 */
	private String disAmt;
	/** 취소 금액 */
	private String cancelAmt;
	/** 수수료 금액 */
	private String cmssAmt;
	/** 할인 취소 금액 */
	private String disCancelAmt;
	/** 추가옵션금액 */
	private String addOptAmt;
	/** 배송업체코드 */
	private String dlvCorpCd;
	/** 배송업체 명 */
	private String dlvCorpNm;
	/** 배송번호 */
	private String dlvNum;
	/** 배송일시 */
	private String dlvDttm;
	/** 수정 일시 */
	private String modDttm;
	/** 정산 적용 비율 */
	private String adjAplPct;
	/** 정산 여부 */
	private String adjYn;
	/** 정산 일자 */
	private String adjDt;
	/** 상품 명 */
	private String prdtNm;
	/** 구분 명 */
	private String divNm;
	/** 옵션 명 */
	private String optNm;
	/** 추가옵션명 */
	private String addOptNm;
	/** 이용후기 등록여부 */
	private String useepilRegYn;
	/** 관리자 메모 */
	private String admMemo;
	/** 환불 금액 */
	private String refundAmt;
	/** 취소정보 */
	private String cancelInf;
	/** 취소 요청 일시*/
	private String cancelRequestDttm;
	/** 환불 요청 일시 */
	private String refundRequestDttm;
	/** 취소 완료 일시 */
	private String cancelCmplDttm;
	/** 예약 확인 여부 */
	private String rsvIdtYn;
	/** 구매 확정 여부 */
	private String buyFixYn;
	/** 구매 확정 일시 */
	private String buyFixDttm;
	/** 취소 사유 */
	private String cancelRsn;
	
	/** 예약 명  */
	private String rsvNm;
	/** 예약 전화번호  */
	private String rsvTelnum;
	/** 예약 이메일  */
	private String rsvEmail;
	/** 사용 명  */
	private String useNm;
	/** 사용 전화번호  */
	private String useTelnum;
	/** 사용 이메일  */
	private String useEmail;
	/** 결제구분  */
	private String payDiv;
	
	/** 등록 일시 */
	private String regDttm;
	
	private String postNum;
	private String roadNmAddr;
	private String dtlAddr;
	private String dlvRequestInf;
	
	/** 배송비 */
	private String dlvAmt;
	/** 배송비 구분 */
	private String dlvAmtDiv;
	/** 직접 수령 여부 */
	private String directRecvYn;
	
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
	/** 대기시간 */
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

	/** 생산자 (묶음배송 로직 변경에 쓰임)*/
	private String prdc;

	/** 앱구분(예약구분)  -  (관리자 직접 예약 시 구분자값으로 쓰임.)*/
	private String appDiv;
	/** Point 사용 포인트 */
	private String usePoint;
	/** 업체할인부담금 */
	private String corpDisAmt;

	public String getSvRsvNum() {
		return svRsvNum;
	}
	public void setSvRsvNum(String svRsvNum) {
		this.svRsvNum = svRsvNum;
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

	public String getCorpNm() {
		return corpNm;
	}

	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}

	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getSvDivSn() {
		return svDivSn;
	}
	public void setSvDivSn(String svDivSn) {
		this.svDivSn = svDivSn;
	}
	public String getSvOptSn() {
		return svOptSn;
	}
	public void setSvOptSn(String svOptSn) {
		this.svOptSn = svOptSn;
	}
	public String getPrdtInf() {
		return prdtInf;
	}
	public void setPrdtInf(String prdtInf) {
		this.prdtInf = prdtInf;
	}
	public String getBuyNum() {
		return buyNum;
	}
	public void setBuyNum(String buyNum) {
		this.buyNum = buyNum;
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
	public String getCmssAmt() {
		return cmssAmt;
	}
	public void setCmssAmt(String cmssAmt) {
		this.cmssAmt = cmssAmt;
	}
	public String getDisCancelAmt() {
		return disCancelAmt;
	}
	public void setDisCancelAmt(String disCancelAmt) {
		this.disCancelAmt = disCancelAmt;
	}
	public String getAddOptAmt() {
		return addOptAmt;
	}
	public void setAddOptAmt(String addOptAmt) {
		this.addOptAmt = addOptAmt;
	}
	public String getDlvCorpCd() {
		return dlvCorpCd;
	}
	public void setDlvCorpCd(String dlvCorpCd) {
		this.dlvCorpCd = dlvCorpCd;
	}
	public String getDlvCorpNm() {
		return dlvCorpNm;
	}
	public void setDlvCorpNm(String dlvCorpNm) {
		this.dlvCorpNm = dlvCorpNm;
	}
	public String getDlvNum() {
		return dlvNum;
	}
	public void setDlvNum(String dlvNum) {
		this.dlvNum = dlvNum;
	}
	public String getDlvDttm() {
		return dlvDttm;
	}
	public void setDlvDttm(String dlvDttm) {
		this.dlvDttm = dlvDttm;
	}
	public String getModDttm() {
		return modDttm;
	}
	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}
	public String getAdjAplPct() {
		return adjAplPct;
	}
	public void setAdjAplPct(String adjAplPct) {
		this.adjAplPct = adjAplPct;
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
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getDivNm() {
		return divNm;
	}
	public void setDivNm(String divNm) {
		this.divNm = divNm;
	}
	public String getOptNm() {
		return optNm;
	}
	public void setOptNm(String optNm) {
		this.optNm = optNm;
	}
	public String getAddOptNm() {
		return addOptNm;
	}
	public void setAddOptNm(String addOptNm) {
		this.addOptNm = addOptNm;
	}
	public String getUseepilRegYn() {
		return useepilRegYn;
	}
	public void setUseepilRegYn(String useepilRegYn) {
		this.useepilRegYn = useepilRegYn;
	}
	public String getAdmMemo() {
		return admMemo;
	}
	public void setAdmMemo(String admMemo) {
		this.admMemo = admMemo;
	}
	public String getRefundAmt() {
		return refundAmt;
	}
	public void setRefundAmt(String refundAmt) {
		this.refundAmt = refundAmt;
	}
	public String getCancelInf() {
		return cancelInf;
	}
	public void setCancelInf(String cancelInf) {
		this.cancelInf = cancelInf;
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
	public String getRsvIdtYn() {
		return rsvIdtYn;
	}
	public void setRsvIdtYn(String rsvIdtYn) {
		this.rsvIdtYn = rsvIdtYn;
	}
	public String getBuyFixYn() {
		return buyFixYn;
	}
	public void setBuyFixYn(String buyFixYn) {
		this.buyFixYn = buyFixYn;
	}
	public String getBuyFixDttm() {
		return buyFixDttm;
	}
	public void setBuyFixDttm(String buyFixDttm) {
		this.buyFixDttm = buyFixDttm;
	}
	public String getCancelRsn() {
		return cancelRsn;
	}
	public void setCancelRsn(String cancelRsn) {
		this.cancelRsn = cancelRsn;
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
	public String getRsvEmail() {
		return rsvEmail;
	}
	public void setRsvEmail(String rsvEmail) {
		this.rsvEmail = rsvEmail;
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
	public String getDlvAmt() {
		return dlvAmt;
	}
	public void setDlvAmt(String dlvAmt) {
		this.dlvAmt = dlvAmt;
	}
	public String getDlvAmtDiv() {
		return dlvAmtDiv;
	}
	public void setDlvAmtDiv(String dlvAmtDiv) {
		this.dlvAmtDiv = dlvAmtDiv;
	}
	public String getDirectRecvYn() {
		return directRecvYn;
	}
	public void setDirectRecvYn(String directRecvYn) {
		this.directRecvYn = directRecvYn;
	}
	public String getRsvStatusNm() {
		return rsvStatusNm;
	}
	public void setRsvStatusNm(String rsvStatusNm) {
		this.rsvStatusNm = rsvStatusNm;
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

	public String getPrdc() {
		return prdc;
	}

	public void setPrdc(String prdc) {
		this.prdc = prdc;
	}

	public String getAppDiv() {
		return appDiv;
	}

	public void setAppDiv(String appDiv) {
		this.appDiv = appDiv;
	}

	public String getUsePoint() {
		return usePoint;
	}

	public void setUsePoint(String usePoint) {
		this.usePoint = usePoint;
	}

	public String getCorpDisAmt() {
		return corpDisAmt;
	}

	public void setCorpDisAmt(String corpDisAmt) {
		this.corpDisAmt = corpDisAmt;
	}
}
