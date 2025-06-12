package oss.adj.vo;

public class ADJTAMNACARDVO {
    /**탐나는전 승인번호**/
    private String approvalCode;
    /**거래일시**/
    private String tradeDttm;
    /**탐나오 거래상태**/
    private String rsvStatusCd;
    /**탐나는전 거래상태**/
    private String paySn;
    private String rsvNum;
    private String dtlRsvNum;
    private String rsvNm;
    /**총상품금액**/
    private Integer totalNmlAmt;
    /**결제금액**/
    private Integer totalSaleAmt;
    /**지원할인금액**/
    private Integer supportDisAmt;
    /**미지원할인금액**/
    private Integer unsupportedDisAmt;
    /**탐나오수수료**/
    private Integer cmssAmt;
    /**탐는는전 수수료**/
    private Integer tcCmss;
    private String corpId;
    private String corpNm;
    private String prdtNum;
    private String prdtNm;
    private String prdtInf;
    private String prdtDiv;
    private String appDiv;
    /**정산 적용 비율**/
    private String adjAplPct;
    /**정산일**/
    private String adjItdDt;
    /**정산상태**/
    private String adjStatus;

    /**탐나는전 결제된 금액**/
    private Integer paidAmount;
    /**탐나는전 자체 할인금액**/
    private Integer discountAmount;

    /**예약검증대상**/
    private String suspiciousRsv;

    public String getApprovalCode() {
        return approvalCode;
    }

    public void setApprovalCode(String approvalCode) {
        this.approvalCode = approvalCode;
    }

    public String getTradeDttm() {
        return tradeDttm;
    }

    public void setTradeDttm(String tradeDttm) {
        this.tradeDttm = tradeDttm;
    }

    public String getRsvStatusCd() {
        return rsvStatusCd;
    }

    public void setRsvStatusCd(String rsvStatusCd) {
        this.rsvStatusCd = rsvStatusCd;
    }

    public String getPaySn() {
        return paySn;
    }

    public void setPaySn(String paySn) {
        this.paySn = paySn;
    }

    public String getRsvNum() {
        return rsvNum;
    }

    public void setRsvNum(String rsvNum) {
        this.rsvNum = rsvNum;
    }

    public String getDtlRsvNum() {
        return dtlRsvNum;
    }

    public void setDtlRsvNum(String dtlRsvNum) {
        this.dtlRsvNum = dtlRsvNum;
    }

    public String getRsvNm() {
        return rsvNm;
    }

    public void setRsvNm(String rsvNm) {
        this.rsvNm = rsvNm;
    }

    public Integer getTotalNmlAmt() {
        return totalNmlAmt;
    }

    public void setTotalNmlAmt(Integer totalNmlAmt) {
        this.totalNmlAmt = totalNmlAmt;
    }

    public Integer getTotalSaleAmt() {
        return totalSaleAmt;
    }

    public void setTotalSaleAmt(Integer totalSaleAmt) {
        this.totalSaleAmt = totalSaleAmt;
    }

    public Integer getSupportDisAmt() {
        return supportDisAmt;
    }

    public void setSupportDisAmt(Integer supportDisAmt) {
        this.supportDisAmt = supportDisAmt;
    }

    public Integer getUnsupportedDisAmt() {
        return unsupportedDisAmt;
    }

    public void setUnsupportedDisAmt(Integer unsupportedDisAmt) {
        this.unsupportedDisAmt = unsupportedDisAmt;
    }

    public Integer getCmssAmt() {
        return cmssAmt;
    }

    public void setCmssAmt(Integer cmssAmt) {
        this.cmssAmt = cmssAmt;
    }

    public Integer getTcCmss() {
        return tcCmss;
    }

    public void setTcCmss(Integer tcCmss) {
        this.tcCmss = tcCmss;
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

    public String getPrdtNm() {
        return prdtNm;
    }

    public void setPrdtNm(String prdtNm) {
        this.prdtNm = prdtNm;
    }

    public String getPrdtInf() {
        return prdtInf;
    }

    public void setPrdtInf(String prdtInf) {
        this.prdtInf = prdtInf;
    }

    public String getPrdtDiv() {
        return prdtDiv;
    }

    public void setPrdtDiv(String prdtDiv) {
        this.prdtDiv = prdtDiv;
    }

    public String getAppDiv() {
        return appDiv;
    }

    public void setAppDiv(String appDiv) {
        this.appDiv = appDiv;
    }

    public String getAdjAplPct() {
        return adjAplPct;
    }

    public void setAdjAplPct(String adjAplPct) {
        this.adjAplPct = adjAplPct;
    }

    public String getAdjItdDt() {
        return adjItdDt;
    }

    public void setAdjItdDt(String adjItdDt) {
        this.adjItdDt = adjItdDt;
    }

    public String getAdjStatus() {
        return adjStatus;
    }

    public void setAdjStatus(String adjStatus) {
        this.adjStatus = adjStatus;
    }

    public String getCorpNm() {
        return corpNm;
    }

    public void setCorpNm(String corpNm) {
        this.corpNm = corpNm;
    }

    public Integer getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(Integer discountAmount) {
        this.discountAmount = discountAmount;
    }

    public String getSuspiciousRsv() {
        return suspiciousRsv;
    }

    public void setSuspiciousRsv(String suspiciousRsv) {
        this.suspiciousRsv = suspiciousRsv;
    }

    public Integer getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(Integer paidAmount) {
        this.paidAmount = paidAmount;
    }
}