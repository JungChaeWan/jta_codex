package web.mypage.vo;

import java.util.List;

public class RSVFILEVO {
    private int seq;
    private String category;
    private String rsvNum;
    private String dtlRsvNum;
    private String savePath;
    private String realFileNm;
    private String saveFileNm;
    private List<RSVFILEVO> rsvFileList;

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
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

    public String getSavePath() {
        return savePath;
    }

    public void setSavePath(String savePath) {
        this.savePath = savePath;
    }

    public String getRealFileNm() {
        return realFileNm;
    }

    public void setRealFileNm(String realFileNm) {
        this.realFileNm = realFileNm;
    }

    public String getSaveFileNm() {
        return saveFileNm;
    }

    public void setSaveFileNm(String saveFileNm) {
        this.saveFileNm = saveFileNm;
    }

    public List<RSVFILEVO> getRsvFileList() {
        return rsvFileList;
    }

    public void setRsvFileList(List<RSVFILEVO> rsvFileList) {
        this.rsvFileList = rsvFileList;
    }
}
