package oss.prmt.vo;

public class GOVASVO {
    private String prmtNum;
    private String userNm;
    private String TelNum;
    private String isConfirmed;
    private String orgName;
    private String govaType;

    public String getPrmtNum() {
        return prmtNum;
    }

    public void setPrmtNum(String prmtNum) {
        this.prmtNum = prmtNum;
    }

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getTelNum() {
        return TelNum;
    }

    public void setTelNum(String telNum) {
        TelNum = telNum;
    }

    public String getIsConfirmed() {
        return isConfirmed;
    }

    public void setIsConfirmed(String isConfirmed) {
        this.isConfirmed = isConfirmed;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getGovaType() {
        return govaType;
    }

    public void setGovaType(String govaType) {
        this.govaType = govaType;
    }
}
