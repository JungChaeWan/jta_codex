package oss.etc.vo;

import oss.cmm.vo.pageDefaultVO;

public class FILESVO extends pageDefaultVO {

    private String category;
    private String docDiv;
    private String docNm;

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDocDiv() {
        return docDiv;
    }

    public void setDocDiv(String docDiv) {
        this.docDiv = docDiv;
    }

    public String getDocNm() {
        return docNm;
    }

    public void setDocNm(String docNm) {
        this.docNm = docNm;
    }
}
