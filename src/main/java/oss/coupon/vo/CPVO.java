package oss.coupon.vo;

import java.util.List;

public class CPVO extends CPSVO {
	private String cpNm;
	private String imgPath;
	private String statusCd;
	private String regDttm;
	private String simpleExp;
	private String modDttm;
	private String prdtCtgrList;
	private int useNum;
	private String cpId;
	private String regId;
	private String modId;
	private String regIp;
	private String modIp;
	private String aplStartDt;
	private String aplEndDt;
	private int disAmt;
	private int buyMiniAmt;


	/** 사용자 발급대상 */
	private String userId;
	/** 할인 방식 */
	private String disDiv;
	/** 할인 비율 */
	private String disPct;
	/** 적용상품 구분 */
	private String aplprdtDiv;
	/** 외부 지원 구분 */
	private String outsideSupportDiv;
	/** 상품 Num */
	private List<String> prdtNum;
	/** 상품 이용 갯수 */
	private List<String> prdtUseNum;
	/** 상품 옵션 sn */
	private List<String> optSn;
	/** 상품 옵션 상세 sn */
	private List<String> optDivSn;
	/** 업체 아이디 */
	private String corpId;
	/** 업체 아이디 리스트 - oss에서 사용*/
	private List<String> corpNum;
	/** 대상 구분 */
	private String tgtDiv;
	/** 쿠폰 코드 */
	private String cpCode;
	/** 쿠폰 구분 */
	private String cpDiv;
    /** 수량제한타입 */
    private String limitType;
    /** 제한수량 */
    private String limitCnt;
    /** 사용된 쿠폰수량*/
    private String useCnt;
    /** 발급된 쿠폰수량*/
    private String issueCnt;
    /** 쿠폰할인최대금액*/
    private int limitAmt;
    /** 구매연동카테고리*/
    private String buyCtgrList;
	/**업체할인부담금*/
    private String corpDisAmt;
	/**연계쿠폰ID(자동발급)*/
	private String rCpId;


	public String getCpNm() {
		return cpNm;
	}

	public void setCpNm(String cpNm) {
		this.cpNm = cpNm;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public String getStatusCd() {
		return statusCd;
	}

	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}

	public String getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}

	public String getSimpleExp() {
		return simpleExp;
	}

	public void setSimpleExp(String simpleExp) {
		this.simpleExp = simpleExp;
	}

	public String getModDttm() {
		return modDttm;
	}

	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}

	public String getPrdtCtgrList() {
		return prdtCtgrList;
	}

	public void setPrdtCtgrList(String prdtCtgrList) {
		this.prdtCtgrList = prdtCtgrList;
	}

	public int getUseNum() {
		return useNum;
	}

	public void setUseNum(int useNum) {
		this.useNum = useNum;
	}

	public String getCpId() {
		return cpId;
	}

	public void setCpId(String cpId) {
		this.cpId = cpId;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	public String getRegIp() {
		return regIp;
	}

	public void setRegIp(String regIp) {
		this.regIp = regIp;
	}

	public String getModIp() {
		return modIp;
	}

	public void setModIp(String modIp) {
		this.modIp = modIp;
	}

	public String getAplStartDt() {
		return aplStartDt;
	}

	public void setAplStartDt(String aplStartDt) {
		this.aplStartDt = aplStartDt;
	}

	public String getAplEndDt() {
		return aplEndDt;
	}

	public void setAplEndDt(String aplEndDt) {
		this.aplEndDt = aplEndDt;
	}

	public int getDisAmt() {
		return disAmt;
	}

	public void setDisAmt(int disAmt) {
		this.disAmt = disAmt;
	}

	public int getBuyMiniAmt() {
		return buyMiniAmt;
	}

	public void setBuyMiniAmt(int buyMiniAmt) {
		this.buyMiniAmt = buyMiniAmt;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public String getOutsideSupportDiv() {
		return outsideSupportDiv;
	}

	public void setOutsideSupportDiv(String outsideSupportDiv) {
		this.outsideSupportDiv = outsideSupportDiv;
	}

	public List<String> getPrdtNum() {
		return prdtNum;
	}

	public void setPrdtNum(List<String> prdtNum) {
		this.prdtNum = prdtNum;
	}

	public List<String> getPrdtUseNum() {
		return prdtUseNum;
	}

	public void setPrdtUseNum(List<String> prdtUseNum) {
		this.prdtUseNum = prdtUseNum;
	}

	public List<String> getOptSn() {
		return optSn;
	}

	public void setOptSn(List<String> optSn) {
		this.optSn = optSn;
	}

	public List<String> getOptDivSn() {
		return optDivSn;
	}

	public void setOptDivSn(List<String> optDivSn) {
		this.optDivSn = optDivSn;
	}

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}

	public String getTgtDiv() {
		return tgtDiv;
	}

	public void setTgtDiv(String tgtDiv) {
		this.tgtDiv = tgtDiv;
	}

	public String getCpCode() {
		return cpCode;
	}

	public void setCpCode(String cpCode) {
		this.cpCode = cpCode;
	}

	public String getCpDiv() {
		return cpDiv;
	}

	public void setCpDiv(String cpDiv) {
		this.cpDiv = cpDiv;
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

	public String getBuyCtgrList() {
		return buyCtgrList;
	}

	public void setBuyCtgrList(String buyCtgrList) {
		this.buyCtgrList = buyCtgrList;
	}

	public List<String> getCorpNum() {
		return corpNum;
	}

	public void setCorpNum(List<String> corpNum) {
		this.corpNum = corpNum;
	}

	public String getCorpDisAmt() {
		return corpDisAmt;
	}

	public void setCorpDisAmt(String corpDisAmt) {
		this.corpDisAmt = corpDisAmt;
	}

	public String getrCpId() {
		return rCpId;
	}

	public void setrCpId(String rCpId) {
		this.rCpId = rCpId;
	}
}
