package oss.prmt.vo;

public class GOVAVO {
    private Long seq;
    private String userId;
    private String orgName;
    private String govaType;
    private String folderName;
    private String isConfirmed;
    private String delYn;
    private String memo;
    private String prmtNum;

    public Long getSeq() {
        return seq;
    }

    public void setSeq(Long seq) {
        this.seq = seq;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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

    public String getFolderName() {
        return folderName;
    }

    public void setFolderName(String folderName) {
        this.folderName = folderName;
    }

    public String getIsConfirmed() {
        return isConfirmed;
    }

    public void setIsConfirmed(String isConfirmed) {
        this.isConfirmed = isConfirmed;
    }

    public String getDelYn() {
        return delYn;
    }

    public void setDelYn(String delYn) {
        this.delYn = delYn;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getPrmtNum() {
        return prmtNum;
    }

    public void setPrmtNum(String prmtNum) {
        this.prmtNum = prmtNum;
    }
}
