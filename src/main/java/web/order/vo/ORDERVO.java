package web.order.vo;

public class ORDERVO extends ORDERSVO{

	/** 상품 코드 */
	private String prdtCd;
	/** 상품 코드명 */
	private String prdtCdNm;
	/** 상품 예약 번호 */
	private String prdtRsvNum;
	/** 예약 번호 */
	private String rsvNum;
	/** 예약 상태 코드 */
	private String rsvStatusCd;
	/** 업체 아이디 */
	private String corpId;
	/** 사용자 아이디 */
	private String userId;
	/** 상품 번호 */
	private String prdtNum;
	/** 상품 명 */
	private String prdtNm;
	/** 상품 정보 */
	private String prdtInf;
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
	/** 업체명 */
	private String corpNm;
	/** 도로명 주소 (상세주소 포함) */
	private String roadNmAddr;
	/** 연계번호 */
	private String mappingRsvNum;
	/** 상품 개수 */
	private String prdtCnt;
	/** 사용일시 */
	private String useDttm;
	/** 상품 구분(SP) */
	private String prdtDiv;
	
	private String imgPath;
	/** 이용가능시간(SP-COUP) */
	private String useAbleDttm;
	/** 이용시작일*/
	private String startDt;
	/** 유효종료일 */
	private String exprEndDt;
	/** 유효시작일 */
	private String exprStartDt;
	/** 예약자명 */
	private String rsvNm;
	/** 예약자 전화번호 */
	private String rsvTelnum;
	/** 환불은행명 */
	private String refundBankNm;
	/** 환불은행코드 */
	private String refundBankCode;
	/** 환불예금주 */
	private String refundDepositor;
	/** 환불계좌번호 */
	private String refundAccNum;
	/** 환불 사유 */
	private String refundRsn;

	private String spDivSn;

	private String spOptSn;
	/** 예약자 이메일 */
	private String rsvEmail;
	/** 사용자 명 */
	private String useNm;
	/** 사용자 이메일 */
	private String useEmail;
	/** 사용자 전화번호 */
	private String useTelnum;
	/** 결제 구분 */
	private String payDiv;
	/** 등록 일시 */
	private String regDttm;
	/** 취소 안내 */
	private String cancelGuide;
	/** 취소 사유 */
	private String cancelRsn;
	/** 취소요청일시 */
	private String cancelRequestDttm;
	/** 환불요청일시 */
	private String refundRequestDttm;
	/** 취소완료일시 */
	private String cancelCmplDttm;
	/** 배송업체 명 */
	private String dlvCorpNm;
	/** 송장 번호 */
	private String dlvNum;
	/** 배송비 */
	private String dlvAmt;
	/** 배송 일시 */
	private String dlvDttm;
	/** 배송비 유형 */
	private String dlvAmtDiv;
	/** 구매 확정 여부*/
	private String buyFixYn;
	/** 구매 확정 일시 */
	private String buyFixDttm;
	/** 카테고리명 */
	private String ctgrNm;
	/** 이벤트 코드 */
	private String evntCd;

	private String directRecvYn;
	
	private String lpointUsePoint;
	
	private String lpointSavePoint;

	private String evntId;

	private String postNum;
	/*앱 구분*/
	private String appDiv;

	/** 직접입력 input*/
	private String directInput;

	private String telnumType;

	/** LS컴퍼니 상품번호 */
	private String lsLinkPrdtNum;

	/** LS컴퍼니 옵션번호 */
	private String lsLinkOptNum;

	/** 하이제주,LS컴퍼니 구분*/
	private String lsLinkYn;

	private String totalNmlAmt;
	private String totalDisAmt;
	private String totalSaleAmt;
	private String partner;

	/**예상 정산금*/
	private String preAdjAmt;

	/** 무통장 입금상태 */
	private String LGD_CASFLAGY;
	
	private String savePath;
	private String saveFileNm;
	
	/** 상품 URL 구분 */
	private String prdtUrlDiv;
	/** 이용후기 등록 여부 */
	private String useepilRegYn;
	/**굿스플로 배송코드*/
	private String goodsflowDlvCd;

	/**사업자별 묶음배송비 추가 2021.06.03 **/
	private  String prdc;

	private String notice;
	private String rnCorp;
	private String corpMaxCount;

	/**숙박예약번호 추가 2021.10.22 **/
	private  String adRsvNum;

	/** 파트너 코드 */
	private String partnerCode;

	/** 파트너(협력사) 사용 포인트  - 일부에서 수수료포인트로 쓰임*/
	private int usePoint;

	/** 결제 포인트 */
	private int payPoint;

	/** (할인) 쿠폰 명*/
	private String cpNm;

	private String cpId;

	private String email;

	public String getEvntId() {
		return evntId;
	}

	public void setEvntId(String evntId) {
		this.evntId = evntId;
	}

	public String getPrdtRsvNum() {
		return prdtRsvNum;
	}

	public void setPrdtRsvNum(String prdtRsvNum) {
		this.prdtRsvNum = prdtRsvNum;
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

	public String getPrdtCd() {
		return prdtCd;
	}

	public void setPrdtCd(String prdtCd) {
		this.prdtCd = prdtCd;
	}

	public String getPrdtNm() {
		return prdtNm;
	}

	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}

	public String getPrdtCdNm() {
		return prdtCdNm;
	}

	public void setPrdtCdNm(String prdtCdNm) {
		this.prdtCdNm = prdtCdNm;
	}

	public String getPrdtCnt() {
		return prdtCnt;
	}

	public void setPrdtCnt(String prdtCnt) {
		this.prdtCnt = prdtCnt;
	}

	public String getCorpNm() {
		return corpNm;
	}

	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}

	public String getRoadNmAddr() {
		return roadNmAddr;
	}

	public void setRoadNmAddr(String roadNmAddr) {
		this.roadNmAddr = roadNmAddr;
	}

	public String getDisCancelAmt() {
		return disCancelAmt;
	}

	public void setDisCancelAmt(String disCancelAmt) {
		this.disCancelAmt = disCancelAmt;
	}

	public String getUseDttm() {
		return useDttm;
	}

	public void setUseDttm(String useDttm) {
		this.useDttm = useDttm;
	}

	public String getPrdtDiv() {
		return prdtDiv;
	}

	public void setPrdtDiv(String prdtDiv) {
		this.prdtDiv = prdtDiv;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public String getUseAbleDttm() {
		return useAbleDttm;
	}

	public void setUseAbleDttm(String useAbleDttm) {
		this.useAbleDttm = useAbleDttm;
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

	public String getExprStartDt() {
		return exprStartDt;
	}

	public void setExprStartDt(String exprStartDt) {
		this.exprStartDt = exprStartDt;
	}

	public String getRefundBankNm() {
		return refundBankNm;
	}

	public void setRefundBankNm(String refundBankNm) {
		this.refundBankNm = refundBankNm;
	}

	public String getRefundDepositor() {
		return refundDepositor;
	}

	public void setRefundDepositor(String refundDepositor) {
		this.refundDepositor = refundDepositor;
	}

	public String getRefundAccNum() {
		return refundAccNum;
	}

	public void setRefundAccNum(String refundAccNum) {
		this.refundAccNum = refundAccNum;
	}

	public String getRefundRsn() {
		return refundRsn;
	}

	public void setRefundRsn(String refundRsn) {
		this.refundRsn = refundRsn;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public String getRsvEmail() {
		return rsvEmail;
	}

	public void setRsvEmail(String rsvEmail) {
		this.rsvEmail = rsvEmail;
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

	public String getUseNm() {
		return useNm;
	}

	public void setUseNm(String useNm) {
		this.useNm = useNm;
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

	public String getCancelGuide() {
		return cancelGuide;
	}

	public void setCancelGuide(String cancelGuide) {
		this.cancelGuide = cancelGuide;
	}

	public String getCancelRsn() {
		return cancelRsn;
	}

	public void setCancelRsn(String cancelRsn) {
		this.cancelRsn = cancelRsn;
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

	public String getBuyFixDttm() {
		return buyFixDttm;
	}

	public void setBuyFixDttm(String buyFixDttm) {
		this.buyFixDttm = buyFixDttm;
	}

	public String getBuyFixYn() {
		return buyFixYn;
	}

	public void setBuyFixYn(String buyFixYn) {
		this.buyFixYn = buyFixYn;
	}

	public String getDlvDttm() {
		return dlvDttm;
	}

	public void setDlvDttm(String dlvDttm) {
		this.dlvDttm = dlvDttm;
	}

	public String getCtgrNm() {
		return ctgrNm;
	}

	public void setCtgrNm(String ctgrNm) {
		this.ctgrNm = ctgrNm;
	}

	public String getEvntCd() {
		return evntCd;
	}

	public void setEvntCd(String evntCd) {
		this.evntCd = evntCd;
	}

	public String getDirectRecvYn() {
		return directRecvYn;
	}

	public void setDirectRecvYn(String directRecvYn) {
		this.directRecvYn = directRecvYn;
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

	public String getPostNum() {
		return postNum;
	}

	public void setPostNum(String postNum) {
		this.postNum = postNum;
	}

	public String getAppDiv() {
		return appDiv;
	}

	public void setAppDiv(String appDiv) {
		this.appDiv = appDiv;
	}

	public String getDirectInput() {
		return directInput;
	}

	public void setDirectInput(String directInput) {
		this.directInput = directInput;
	}

	public String getTelnumType() {
		return telnumType;
	}

	public void setTelnumType(String telnumType) {
		this.telnumType = telnumType;
	}

	public String getLsLinkPrdtNum() {
		return lsLinkPrdtNum;
	}

	public void setLsLinkPrdtNum(String lsLinkPrdtNum) {
		this.lsLinkPrdtNum = lsLinkPrdtNum;
	}

	public String getLsLinkOptNum() {
		return lsLinkOptNum;
	}

	public void setLsLinkOptNum(String lsLinkOptNum) {
		this.lsLinkOptNum = lsLinkOptNum;
	}

	public String getTotalNmlAmt() {
		return totalNmlAmt;
	}

	public void setTotalNmlAmt(String totalNmlAmt) {
		this.totalNmlAmt = totalNmlAmt;
	}

	public String getTotalDisAmt() {
		return totalDisAmt;
	}

	public void setTotalDisAmt(String totalDisAmt) {
		this.totalDisAmt = totalDisAmt;
	}

	public String getTotalSaleAmt() {
		return totalSaleAmt;
	}

	public void setTotalSaleAmt(String totalSaleAmt) {
		this.totalSaleAmt = totalSaleAmt;
	}

	public String getRefundBankCode() {
		return refundBankCode;
	}

	public void setRefundBankCode(String refundBankCode) {
		this.refundBankCode = refundBankCode;
	}

	public String getLGD_CASFLAGY() {
		return LGD_CASFLAGY;
	}

	public void setLGD_CASFLAGY(String LGD_CASFLAGY) {
		this.LGD_CASFLAGY = LGD_CASFLAGY;
	}

	public String getLsLinkYn() {
		return lsLinkYn;
	}

	public void setLsLinkYn(String lsLinkYn) {
		this.lsLinkYn = lsLinkYn;
	}

	public String getStartDt() {
		return startDt;
	}

	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}

	public String getPartner() {
		return partner;
	}

	public void setPartner(String partner) {
		this.partner = partner;
	}

	public String getPreAdjAmt() {
		return preAdjAmt;
	}

	public void setPreAdjAmt(String preAdjAmt) {
		this.preAdjAmt = preAdjAmt;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String getSaveFileNm() {
		return saveFileNm;
	}

	public void setSaveFileNm(String saveFileNm) {
		this.saveFileNm = saveFileNm;
	}

	public String getPrdtUrlDiv() {
		return prdtUrlDiv;
	}

	public void setPrdtUrlDiv(String prdtUrlDiv) {
		this.prdtUrlDiv = prdtUrlDiv;
	}

	public String getUseepilRegYn() {
		return useepilRegYn;
	}

	public void setUseepilRegYn(String useepilRegYn) {
		this.useepilRegYn = useepilRegYn;
	}

	public String getGoodsflowDlvCd() {
		return goodsflowDlvCd;
	}

	public void setGoodsflowDlvCd(String goodsflowDlvCd) {
		this.goodsflowDlvCd = goodsflowDlvCd;
	}

	public String getPrdc() {
		return prdc;
	}

	public void setPrdc(String prdc) {
		this.prdc = prdc;
	}

	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public String getRnCorp() {
		return rnCorp;
	}

	public void setRnCorp(String rnCorp) {
		this.rnCorp = rnCorp;
	}

	public String getCorpMaxCount() {
		return corpMaxCount;
	}

	public void setCorpMaxCount(String corpMaxCount) {
		this.corpMaxCount = corpMaxCount;
	}

	public String getAdRsvNum() {
		return adRsvNum;
	}

	public void setAdRsvNum(String adRsvNum) {
		this.adRsvNum = adRsvNum;
	}

	public int getUsePoint() {
		return usePoint;
	}

	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}

	public String getPartnerCode() {
		return partnerCode;
	}

	public void setPartnerCode(String partnerCode) {
		this.partnerCode = partnerCode;
	}

	public int getPayPoint() {
		return payPoint;
	}

	public void setPayPoint(int payPoint) {
		this.payPoint = payPoint;
	}

	public String getCpNm() {
		return cpNm;
	}

	public void setCpNm(String cpNm) {
		this.cpNm = cpNm;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCpId() {
		return cpId;
	}

	public void setCpId(String cpId) {
		this.cpId = cpId;
	}
}
