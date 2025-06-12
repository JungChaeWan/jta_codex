package web.order.vo;

public class SP_RSVVO extends RSVSVO{

	/** 소셜상품 예약 번호 */
	private String spRsvNum;
	/** 예약 번호 */
	private String rsvNum;
	/** 예약 상태 코드 */
	private String rsvStatusCd;
	/** 업체 아이디 */
	private String corpId;
	/** 상품 번호 */
	private String prdtNum;
	/** 소셜상품 구분 순번 */
	private String spDivSn;
	/** 소셜상품 옵션 순번 */
	private String spOptSn;
	/** 상품 명 */
	private String prdtNm;
	/** 상품 정보 */
	private String prdtInf;
	/** 구매 수 */
	private String buyNum;
	/** 사용 수 */
	private String useNum;
	/** 정상 금액 */
	private String nmlAmt;
	/** 판매 금액 */
	private String saleAmt;
	/** 할인 금액 */
	private String disAmt;
	/** 취소 금액 */
	private String cancelAmt;
	/** 수정 일시 */
	private String modDttm;
	/** 정산 여부 */
	private String adjYn;
	/** 정산 일자 */
	private String adjDt;
	/** 수수료 금액 */
	private String cmssAmt;
	/** 사용 일시 */
	private String useDttm;
	/** 구분 명 */
	private String divNm;
	/** 상품 구분 */
	private String prdtDiv;
	/** 할인 취소 금액 */
	private String disCancelAmt;
	/** 옵션 명 */
	private String optNm;
	/** 적용 일자 */
	private String aplDt;
	/** 유효 종료 일자 */
	private String exprEndDt;
	/** 예약 확인 여부 */
	private String rsvIdtYn;
	
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
	/** 관리자 메모 */
	private String admMemo;
	
	private String exprStartDt;
	private String useAbleDttm;

	/** 실정산액 (예상정산액이랑 겹칠때 사용) */
	private String realAdjAmt;
	
	
	/** 연계번호 */
	private String mappingRsvNum;
	/** 등록 일시 */
	private String regDttm;
	
	/** 환불 금액 */
	private String refundAmt;
	
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
	
	/** 추가옵션명 */
	private String addOptNm;
	/** 추가옵션금액 */
	private String addOptAmt;
	
	/** 업체명 **/
	private String corpNm;
	/** POS 사용 여부 **/
	private String posUseYn;
	
	/** 예상정산액 **/
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
	/** LS컴퍼니 아이템 PINCODE */
	private String lsLinkOptPincode;
	/** LS컴퍼니 연동여부 */
	private String lsLinkYn;
	/** 환불 은행코드*/
	private String refundBankCode;
	/** 환불계좌번호*/
	private String refundAccNum;
	/** 환불 예금주명*/
	private String refundDepositor;
	/** 환불 사유 */
	private String refundRsn;
	/** 탐나는전 승인코드 */
	String tamnacardRefId;
	/** Point 사용 포인트 */
	private String usePoint;
	/** 업체할인부담금 */
	private String corpDisAmt;

	public String getSpRsvNum() {
		return spRsvNum;
	}
	public void setSpRsvNum(String spRsvNum) {
		this.spRsvNum = spRsvNum;
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
	public String getSpDivSn() {
		return spDivSn;
	}
	public void setSpDivSn(String spDivSn) {
		this.spDivSn = spDivSn;
	}
	public String getSpOptSn() {
		return spOptSn;
	}
	public void setSpOptSn(String spOptSn) {
		this.spOptSn = spOptSn;
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
	public String getUseNum() {
		return useNum;
	}
	public void setUseNum(String useNum) {
		this.useNum = useNum;
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
	public String getUseDttm() {
		return useDttm;
	}
	public void setUseDttm(String useDttm) {
		this.useDttm = useDttm;
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
	public String getPrdtDiv() {
		return prdtDiv;
	}
	public void setPrdtDiv(String prdtDiv) {
		this.prdtDiv = prdtDiv;
	}
	public String getDisCancelAmt() {
		return disCancelAmt;
	}
	public void setDisCancelAmt(String disCancelAmt) {
		this.disCancelAmt = disCancelAmt;
	}
	public String getAplDt() {
		return aplDt;
	}
	public void setAplDt(String aplDt) {
		this.aplDt = aplDt;
	}
	public String getExprEndDt() {
		return exprEndDt;
	}
	public void setExprEndDt(String exprEndDt) {
		this.exprEndDt = exprEndDt;
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
	public String getMappingRsvNum() {
		return mappingRsvNum;
	}
	public void setMappingRsvNum(String mappingRsvNum) {
		this.mappingRsvNum = mappingRsvNum;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getAdmMemo() {
		return admMemo;
	}
	public void setAdmMemo(String admMemo) {
		this.admMemo = admMemo;
	}
	public String getExprStartDt() {
		return exprStartDt;
	}
	public void setExprStartDt(String exprStartDt) {
		this.exprStartDt = exprStartDt;
	}
	public String getUseAbleDttm() {
		return useAbleDttm;
	}
	public void setUseAbleDttm(String useAbleDttm) {
		this.useAbleDttm = useAbleDttm;
	}
	public String getCancelInf() {
		return cancelInf;
	}
	public void setCancelInf(String cancelInf) {
		this.cancelInf = cancelInf;
	}
	public String getRefundAmt() {
		return refundAmt;
	}
	public void setRefundAmt(String refundAmt) {
		this.refundAmt = refundAmt;
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
	public String getAddOptNm() {
		return addOptNm;
	}
	public void setAddOptNm(String addOptNm) {
		this.addOptNm = addOptNm;
	}
	public String getAddOptAmt() {
		return addOptAmt;
	}
	public void setAddOptAmt(String addOptAmt) {
		this.addOptAmt = addOptAmt;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getPosUseYn() {
		return posUseYn;
	}
	public void setPosUseYn(String posUseYn) {
		this.posUseYn = posUseYn;
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
	public String getRealAdjAmt() {
		return realAdjAmt;
	}
	public void setRealAdjAmt(String realAdjAmt) {
		this.realAdjAmt = realAdjAmt;
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

	public String getLsLinkOptPincode() {
		return lsLinkOptPincode;
	}

	public void setLsLinkOptPincode(String lsLinkOptPincode) {
		this.lsLinkOptPincode = lsLinkOptPincode;
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

	public String getLsLinkYn() {
		return lsLinkYn;
	}

	public void setLsLinkYn(String lsLinkYn) {
		this.lsLinkYn = lsLinkYn;
	}

	public String getTamnacardRefId() {
		return tamnacardRefId;
	}

	public void setTamnacardRefId(String tamnacardRefId) {
		this.tamnacardRefId = tamnacardRefId;
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
