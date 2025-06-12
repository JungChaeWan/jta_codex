package web.order.vo;

public class TAMNACARD_VO {
    private String rsvNum;
    private String approvalCode;
    private String paidAmount;
    private String status;
    private String trAmount;
    private String trDateTime;
    private String nrNumber;
    private String paySn;
    private String remainAmount;
    private String userInfo;
    private String maskCardNo;
    private String cardBalance;
    private String pgNm;

    private String discountAmount;
    private String reason;
    private String message;

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getRsvNum() {
        return rsvNum;
    }

    public void setRsvNum(String rsvNum) {
        this.rsvNum = rsvNum;
    }

    public String getPaySn() {
        return paySn;
    }

    public void setPaySn(String paySn) {
        this.paySn = paySn;
    }

    public String getApprovalCode() {
        return approvalCode;
    }

    public void setApprovalCode(String approvalCode) {
        this.approvalCode = approvalCode;
    }

    public String getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(String paidAmount) {
        this.paidAmount = paidAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTrAmount() {
        return trAmount;
    }

    public void setTrAmount(String trAmount) {
        this.trAmount = trAmount;
    }

    public String getTrDateTime() {
        return trDateTime;
    }

    public void setTrDateTime(String trDateTime) {
        this.trDateTime = trDateTime;
    }

    public String getNrNumber() {
        return nrNumber;
    }

    public void setNrNumber(String nrNumber) {
        this.nrNumber = nrNumber;
    }

    public String getRemainAmount() {
        return remainAmount;
    }

    public void setRemainAmount(String remainAmount) {
        this.remainAmount = remainAmount;
    }

    public String getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(String userInfo) {
        this.userInfo = userInfo;
    }

    public String getMaskCardNo() {
        return maskCardNo;
    }

    public void setMaskCardNo(String maskCardNo) {
        this.maskCardNo = maskCardNo;
    }

    public String getCardBalance() {
        return cardBalance;
    }

    public void setCardBalance(String cardBalance) {
        this.cardBalance = cardBalance;
    }

    public String getPgNm() {
        return pgNm;
    }

    public void setPgNm(String pgNm) {
        this.pgNm = pgNm;
    }

    public String getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(String discountAmount) {
        this.discountAmount = discountAmount;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
