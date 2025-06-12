package oss.sv.vo;


public class OSS_SV_PRDTINFVO {
	/** 소셜 상품 번호 */
	private String prdtNum;
	/** 업체 아이디 */
	private String corpId;
	/** 거래상태 */
	private String tradeStatus;
	/** 거래상태명 */
	private String tradeStatusNm;
	/** 상품 명 */
	private String prdtNm;
	/** 판매 시작 일자 */
	private String saleStartDt;
	/** 판매 종료 일자 */
	private String saleEndDt;
	/** 상품 구분 */
	private String prdtDiv;
	/** 승인 요청 일시 */
	private String confRequestDttm;
	/** 승인 일시 */
	private String confDttm;

	/** 카테고리 이름 */
	private String ctgrNm;
	/** 업체 명 */
	private String corpNm;
	
	/** 우수관광기념품 */
	private String superbSvYn;
	/** JQ인증 여부 */
	private String jqYn;
	/**업체 담당자 이메일**/
	private String corpAdmEmail;
	private String roadNmAddr;
	private String sixCertiCate;
	private String subCtgr;

	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getTradeStatus() {
		return tradeStatus;
	}
	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
	}
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getSaleStartDt() {
		return saleStartDt;
	}
	public void setSaleStartDt(String saleStartDt) {
		this.saleStartDt = saleStartDt;
	}
	public String getSaleEndDt() {
		return saleEndDt;
	}
	public void setSaleEndDt(String saleEndDt) {
		this.saleEndDt = saleEndDt;
	}
	public String getPrdtDiv() {
		return prdtDiv;
	}
	public void setPrdtDiv(String prdtDiv) {
		this.prdtDiv = prdtDiv;
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
	public String getCtgrNm() {
		return ctgrNm;
	}
	public void setCtgrNm(String ctgrNm) {
		this.ctgrNm = ctgrNm;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getSuperbSvYn() {
		return superbSvYn;
	}
	public void setSuperbSvYn(String superbSvYn) {
		this.superbSvYn = superbSvYn;
	}
	public String getTradeStatusNm() {
		return tradeStatusNm;
	}
	public void setTradeStatusNm(String tradeStatusNm) {
		this.tradeStatusNm = tradeStatusNm;
	}
	public String getJqYn() {
		return jqYn;
	}
	public void setJqYn(String jqYn) {
		this.jqYn = jqYn;
	}

	public String getCorpAdmEmail() {
		return corpAdmEmail;
	}

	public void setCorpAdmEmail(String corpAdmEmail) {
		this.corpAdmEmail = corpAdmEmail;
	}

	public String getRoadNmAddr() {
		return roadNmAddr;
	}

	public void setRoadNmAddr(String roadNmAddr) {
		this.roadNmAddr = roadNmAddr;
	}

	public String getSixCertiCate() {
		return sixCertiCate;
	}

	public void setSixCertiCate(String sixCertiCate) {
		this.sixCertiCate = sixCertiCate;
	}

	public String getSubCtgr() {
		return subCtgr;
	}

	public void setSubCtgr(String subCtgr) {
		this.subCtgr = subCtgr;
	}
}
