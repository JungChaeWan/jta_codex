package web.mypage.vo;

public class USER_CPVO {

	/** 사용자 아이디 */
	private String userId;
	/** 쿠폰 번호 */
	private String cpNum;
	/** 쿠폰 구분 */
	private String cpDiv;
	/** 할인 금액 */
	private int disAmt;
	/** 등록 일시 */
	private String regDttm;
	/** 사용 일시 */
	private String useDttm;
	/** 유효 시작 일자 */
	private String exprStartDt;
	/** 유효 종료 일자 */
	private String exprEndDt;
	/** 사용 여부 */
	private String useYn;
	/** 쿠폰 아이디 */
	private String cpId;
	/** 구매 최소 금액 */
	private int buyMiniAmt;
	/** 사용 예약 번호 */
	private String useRsvNum;
	/** 쿠폰 명 */
	private String cpNm;
	/** 예약시 매핑할 변수 */
	private String mapSn;
	private String useCpNum;
	private String cpDisAmt;
	/** 사용자 아이디 배열 */
	private String[] userIds;
	
	private String prdtCtgrList;
	/** 할인 구분 */
	private String disDiv;
	/** 할인 비율 */
	private String disPct;
	/** 적용상품 구분 */
	private String aplprdtDiv;
	/** 상품 번호 */
	private String prdtNum;
	/** 상품 이용 수 */
	private String prdtUseNum;
	/** 옵션 순번 */
	private String optSn;
	/** 옵션 구분 순번 */
	private String optDivSn;
	/** 쿠폰 코드 */
	private String cpCode;
	/** 수량제한타입 */
	private String limitType;
	/** 제한수량 */
	private String limitCnt;
	/** 사용된 쿠폰수량*/
	private String useCnt;
	/** 발급된 쿠폰수량*/
	private String issueCnt;
	/** 할인최대금액 */
	private int limitAmt;

	private String corpId;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCpNum() {
		return cpNum;
	}

	public void setCpNum(String cpNum) {
		this.cpNum = cpNum;
	}

	public String getCpDiv() {
		return cpDiv;
	}

	public void setCpDiv(String cpDiv) {
		this.cpDiv = cpDiv;
	}

	public int getDisAmt() {
		return disAmt;
	}

	public void setDisAmt(int disAmt) {
		this.disAmt = disAmt;
	}

	public String getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}

	public String getUseDttm() {
		return useDttm;
	}

	public void setUseDttm(String useDttm) {
		this.useDttm = useDttm;
	}

	public String getExprStartDt() {
		return exprStartDt;
	}

	public void setExprStartDt(String exprStartDt) {
		this.exprStartDt = exprStartDt;
	}

	public String getExprEndDt() {
		return exprEndDt;
	}

	public void setExprEndDt(String exprEndDt) {
		this.exprEndDt = exprEndDt;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getCpId() {
		return cpId;
	}

	public void setCpId(String cpId) {
		this.cpId = cpId;
	}

	public int getBuyMiniAmt() {
		return buyMiniAmt;
	}

	public void setBuyMiniAmt(int buyMiniAmt) {
		this.buyMiniAmt = buyMiniAmt;
	}

	public String getUseRsvNum() {
		return useRsvNum;
	}

	public void setUseRsvNum(String useRsvNum) {
		this.useRsvNum = useRsvNum;
	}

	public String getCpNm() {
		return cpNm;
	}

	public void setCpNm(String cpNm) {
		this.cpNm = cpNm;
	}

	public String getMapSn() {
		return mapSn;
	}

	public void setMapSn(String mapSn) {
		this.mapSn = mapSn;
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

	public String[] getUserIds() {
		return userIds;
	}

	public void setUserIds(String[] userIds) {
		this.userIds = userIds;
	}

	public String getPrdtCtgrList() {
		return prdtCtgrList;
	}

	public void setPrdtCtgrList(String prdtCtgrList) {
		this.prdtCtgrList = prdtCtgrList;
	}

	public String getDisDiv() {
		return disDiv;
	}

	public void setDisDiv(String disDiv) {
		this.disDiv = disDiv;
	}

	public String getDisPct() {
		return disPct;
	}

	public void setDisPct(String disPct) {
		this.disPct = disPct;
	}

	public String getAplprdtDiv() {
		return aplprdtDiv;
	}

	public void setAplprdtDiv(String aplprdtDiv) {
		this.aplprdtDiv = aplprdtDiv;
	}

	public String getPrdtNum() {
		return prdtNum;
	}

	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}

	public String getPrdtUseNum() {
		return prdtUseNum;
	}

	public void setPrdtUseNum(String prdtUseNum) {
		this.prdtUseNum = prdtUseNum;
	}

	public String getOptSn() {
		return optSn;
	}

	public void setOptSn(String optSn) {
		this.optSn = optSn;
	}

	public String getOptDivSn() {
		return optDivSn;
	}

	public void setOptDivSn(String optDivSn) {
		this.optDivSn = optDivSn;
	}

	public String getCpCode() {
		return cpCode;
	}

	public void setCpCode(String cpCode) {
		this.cpCode = cpCode;
	}

	public String getLimitType() {
		return limitType;
	}

	public void setLimitType(String limitType) {
		this.limitType = limitType;
	}

	public String getLimitCnt() {
		return limitCnt;
	}

	public void setLimitCnt(String limitCnt) {
		this.limitCnt = limitCnt;
	}

    public String getUseCnt() {
        return useCnt;
    }

    public void setUseCnt(String useCnt) {
        this.useCnt = useCnt;
    }

    public String getIssueCnt() {
        return issueCnt;
    }

    public void setIssueCnt(String issueCnt) {
        this.issueCnt = issueCnt;
    }

	public int getLimitAmt() {
		return limitAmt;
	}

	public void setLimitAmt(int limitAmt) {
		this.limitAmt = limitAmt;
	}

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
}
