package oss.prdt.vo;

public class PRDTVO extends PRDTSVO{

	/*************************************************
	 * 상품 기본 정보(공통)
	 *************************************************/
	/** 상품 번호 */
	private String prdtNum;
	/** 상품 명 */
	private String prdtNm;
	/** 상품 코드 */
	private String prdtCd;
	/** 업체 아이디 */
	private String corpId;
	/** 업체 명 */
	private String corpNm;
	/** 업체 코드 */
	private String corpCd;
	/** 거래 상태 */
	private String tradeStatus;
	/** 거래 상태명 */
	private String tradeStatusNm;
	/** 승인 요청 일시 */
	private String confRequestDttm;
	/** 승인 일시 */
	private String confDttm;
	/** 정상가 */
	private String nmlAmt;
	/** 판매가 */
	private String saleAmt;
	/** 할인율 */
	private String disPer;
	/** 대표 이미지 저장경로 */
	private String savePath;
	/** 대표 이미지 파일명 */
	private String saveFileNm;
	/**업체 담당자 이메일**/
	private String corpAdmEmail;
	
	
	/*************************************************
	 * 렌터카 정보
	 *************************************************/
	/** 선택시간 */
	private String rsvTm;
	/** 계산된 기준시간 */
	private String saleTm;
	
	
	/*************************************************
	 * 연계관련
	 */
	private String corpLinkYn;
	private String mappingNum;
	private String tamnacardPrdtYn;

	/*****상품수량체크*****/
	/*만료예정상품개수*/
	private String confCnt;
	/*수량만료일*/
	private String cntAplDt;
	/*금액만료일*/
	private String amtAplDt;
	
	/*숙박 승인업체수*/
	private String adTotCnt;
	/*숙박 판매업체수*/
	private String adSaleCnt;
	/*렌터카 승인업체수*/
	private String rcTotCnt;
	/*렌터카 판매업체수*/
	private String rcSaleCnt;	
	/*숙박 판매가능업체수*/
	private String adSaleCnt2;
	/*예약번호*/
	private String rsvTelNum;
	/*관리자번호*/
	private String admMobile;

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
	public String getTradeStatus() {
		return tradeStatus;
	}
	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
	}
	public String getTradeStatusNm() {
		return tradeStatusNm;
	}
	public void setTradeStatusNm(String tradeStatusNm) {
		this.tradeStatusNm = tradeStatusNm;
	}
	public String getConfRequestDttm() {
		return confRequestDttm;
	}
	public void setConfRequestDttm(String confRequestDttm) {
		this.confRequestDttm = confRequestDttm;
	}
	public String getConfDttm() {
		return confDttm;
	}
	public void setConfDttm(String confDttm) {
		this.confDttm = confDttm;
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
	public String getDisPer() {
		return disPer;
	}
	public void setDisPer(String disPer) {
		this.disPer = disPer;
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
	public String getCorpLinkYn() {
		return corpLinkYn;
	}
	public void setCorpLinkYn(String corpLinkYn) {
		this.corpLinkYn = corpLinkYn;
	}
	public String getMappingNum() {
		return mappingNum;
	}
	public void setMappingNum(String mappingNum) {
		this.mappingNum = mappingNum;
	}
	public String getPrdtCd() {
		return prdtCd;
	}
	public void setPrdtCd(String prdtCd) {
		this.prdtCd = prdtCd;
	}
	public String getConfCnt() {
		return confCnt;
	}
	public void setConfCnt(String confCnt) {
		this.confCnt = confCnt;
	}
	public String getAmtAplDt() {
		return amtAplDt;
	}
	public void setAmtAplDt(String amtAplDt) {
		this.amtAplDt = amtAplDt;
	}
	public String getCntAplDt() {
		return cntAplDt;
	}
	public void setCntAplDt(String cntAplDt) {
		this.cntAplDt = cntAplDt;
	}
	public String getAdTotCnt() {
		return adTotCnt;
	}
	public void setAdTotCnt(String adTotCnt) {
		this.adTotCnt = adTotCnt;
	}
	public String getAdSaleCnt() {
		return adSaleCnt;
	}
	public void setAdSaleCnt(String adSaleCnt) {
		this.adSaleCnt = adSaleCnt;
	}
	public String getRcTotCnt() {
		return rcTotCnt;
	}
	public void setRcTotCnt(String rcTotCnt) {
		this.rcTotCnt = rcTotCnt;
	}
	public String getRcSaleCnt() {
		return rcSaleCnt;
	}
	public void setRcSaleCnt(String rcSaleCnt) {
		this.rcSaleCnt = rcSaleCnt;
	}
	public String getAdSaleCnt2() {
		return adSaleCnt2;
	}
	public void setAdSaleCnt2(String adSaleCnt2) {
		this.adSaleCnt2 = adSaleCnt2;
	}

	public String getRsvTelNum() {
		return rsvTelNum;
	}

	public void setRsvTelNum(String rsvTelNum) {
		this.rsvTelNum = rsvTelNum;
	}

	public String getAdmMobile() {
		return admMobile;
	}

	public void setAdmMobile(String admMobile) {
		this.admMobile = admMobile;
	}

	public String getCorpAdmEmail() {
		return corpAdmEmail;
	}

	public void setCorpAdmEmail(String corpAdmEmail) {
		this.corpAdmEmail = corpAdmEmail;
	}

	public String getTamnacardPrdtYn() {
		return tamnacardPrdtYn;
	}

	public void setTamnacardPrdtYn(String tamnacardPrdtYn) {
		this.tamnacardPrdtYn = tamnacardPrdtYn;
	}

	public String getCorpCd() {
		return corpCd;
	}

	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
}
