package oss.point.vo;

import oss.corp.vo.CORPVO;

public class POINT_CORPVO extends CORPVO {
    private String partnerCode;
    private int limitPoint;
    private String regYn;
    private String regDttm;
    /** 구매하기 시 총 금액*/
    private int totalProductAmt;

    public String getPartnerCode() {
        return partnerCode;
    }

    public void setPartnerCode(String partnerCode) {
        this.partnerCode = partnerCode;
    }

    public int getLimitPoint() {
        return limitPoint;
    }

    public void setLimitPoint(int limitPoint) {
        this.limitPoint = limitPoint;
    }

    public String getRegYn() {
        return regYn;
    }

    public void setRegYn(String regYn) {
        this.regYn = regYn;
    }

    public String getRegDttm() {
        return regDttm;
    }

    public void setRegDttm(String regDttm) {
        this.regDttm = regDttm;
    }

    public int getTotalProductAmt() {
        return totalProductAmt;
    }

    public void setTotalProductAmt(int totalProductAmt) {
        this.totalProductAmt = totalProductAmt;
    }
}
