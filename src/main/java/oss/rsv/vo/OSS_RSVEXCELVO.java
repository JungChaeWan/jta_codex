package oss.rsv.vo;

public class OSS_RSVEXCELVO {
    /** 시퀀스 번호 */
    private Integer seq;
    /** 그룹번호 */
    private Integer groupNo;
    /** 예약자 명 */
    private String rsvNm;
    /** 예약자 전화번호 */
    private String rsvTelnum;
    /** 사용자 명 */
    private String useNm;
    /** 사용자 전화번호 */
    private String useTelnum;
    /** 우편번호 */
    private String postNum;
    /** 도로명 주소 */
    private String roadNmAddr;
    /** 상세주소 */
    private String dtlAddr;
    /**상품코드 */
    private String prdtNum;
    /** 옵션 구분 코드 */
    private String divSn;
    /** 옵션 코드 */
    private String optSn;
    /** 추가옵션 코드 */
    private String addOptSn;
    /** 구매 수량 */
    private String buyNum;
    /** 배송요청정보 */
    private String dlvRequestInf;
    /** 업체코드 */
    private String corpId;
    /** 결제구분 */
    private String payDiv;
    /** 직접 수령 여부 */
    private String directRecvYn;
    /** 배송구분 */
    private String dlvAmtDiv;
    /** 네이버 상품명*/
    private String sPrdtNm;
    /** 네이버 옵션명*/
    private String sOptNm;
    /** 네이버 상품 + 옵션명*/
    private String sPrdtOptNm;
    /** 예약(업체)구분 */
    private String corpDiv;
    /** 예약 완료 상태 */
    private String rsvCompleteYn;

    /** 엑셀업로드 후 리스트에서 보여주는 명칭들*/
    private String corpNm;
    private String prdtNm;
    private String prdtDivNm;
    private String optNm;
    private String addOptNm;

    /** 엑셀업로드 후 리스트에서 보여주는 가격*/
    private String saleAmt;
    private String addOptAmt;
    private String  dlvAmt;

    /** 소셜상품 Select시 */
    private String prdtDiv;
    private String exprDaynumYn;
    private Integer exprDaynum;
    private String exprEndDt;
    private String exprStartDt;
    private Integer useAbleTm;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getRsvNm() {
        return rsvNm;
    }

    public void setRsvNm(String rsvNm) {
        this.rsvNm = rsvNm;
    }

    public String getRsvTelnum() {
        return rsvTelnum;
    }

    public void setRsvTelnum(String rsvTelnum) {
        this.rsvTelnum = rsvTelnum;
    }

    public String getUseNm() {
        return useNm;
    }

    public void setUseNm(String useNm) {
        this.useNm = useNm;
    }

    public String getUseTelnum() {
        return useTelnum;
    }

    public void setUseTelnum(String useTelnum) {
        this.useTelnum = useTelnum;
    }

    public String getPostNum() {
        return postNum;
    }

    public void setPostNum(String postNum) {
        this.postNum = postNum;
    }

    public String getRoadNmAddr() {
        return roadNmAddr;
    }

    public void setRoadNmAddr(String roadNmAddr) {
        this.roadNmAddr = roadNmAddr;
    }

    public String getDtlAddr() {
        return dtlAddr;
    }

    public void setDtlAddr(String dtlAddr) {
        this.dtlAddr = dtlAddr;
    }

    public String getPrdtNum() {
        return prdtNum;
    }

    public void setPrdtNum(String prdtNum) {
        this.prdtNum = prdtNum;
    }

    public String getDivSn() {
        return divSn;
    }

    public void setDivSn(String divSn) {
        this.divSn = divSn;
    }

    public String getOptSn() {
        return optSn;
    }

    public void setOptSn(String optSn) {
        this.optSn = optSn;
    }

    public String getAddOptSn() {
        return addOptSn;
    }

    public void setAddOptSn(String addOptSn) {
        this.addOptSn = addOptSn;
    }

    public String getAddOptNm() {
        return addOptNm;
    }

    public void setAddOptNm(String addOptNm) {
        this.addOptNm = addOptNm;
    }

    public String getBuyNum() {
        return buyNum;
    }

    public void setBuyNum(String buyNum) {
        this.buyNum = buyNum;
    }

    public String getDlvRequestInf() {
        return dlvRequestInf;
    }

    public void setDlvRequestInf(String dlvRequestInf) {
        this.dlvRequestInf = dlvRequestInf;
    }

    public String getCorpId() {
        return corpId;
    }

    public void setCorpId(String corpId) {
        this.corpId = corpId;
    }

    public Integer getGroupNo() {
        return groupNo;
    }

    public void setGroupNo(Integer groupNo) {
        this.groupNo = groupNo;
    }

    public String getCorpNm() {
        return corpNm;
    }

    public void setCorpNm(String corpNm) {
        this.corpNm = corpNm;
    }

    public String getPrdtNm() {
        return prdtNm;
    }

    public void setPrdtNm(String prdtNm) {
        this.prdtNm = prdtNm;
    }

    public String getPrdtDivNm() {
        return prdtDivNm;
    }

    public void setPrdtDivNm(String prdtDivNm) {
        this.prdtDivNm = prdtDivNm;
    }

    public String getOptNm() {
        return optNm;
    }

    public void setOptNm(String optNm) {
        this.optNm = optNm;
    }

    public String getSaleAmt() {
        return saleAmt;
    }

    public void setSaleAmt(String saleAmt) {
        this.saleAmt = saleAmt;
    }

    public String getAddOptAmt() {
        return addOptAmt;
    }

    public void setAddOptAmt(String addOptAmt) {
        this.addOptAmt = addOptAmt;
    }

    public String getDlvAmt() {
        return dlvAmt;
    }

    public void setDlvAmt(String dlvAmt) {
        this.dlvAmt = dlvAmt;
    }

    public String getPayDiv() {
        return payDiv;
    }

    public void setPayDiv(String payDiv) {
        this.payDiv = payDiv;
    }

    public String getDirectRecvYn() {
        return directRecvYn;
    }

    public void setDirectRecvYn(String directRecvYn) {
        this.directRecvYn = directRecvYn;
    }

    public String getDlvAmtDiv() {
        return dlvAmtDiv;
    }

    public void setDlvAmtDiv(String dlvAmtDiv) {
        this.dlvAmtDiv = dlvAmtDiv;
    }

    public String getsPrdtNm() {
        return sPrdtNm;
    }

    public void setsPrdtNm(String sPrdtNm) {
        this.sPrdtNm = sPrdtNm;
    }

    public String getsOptNm() {
        return sOptNm;
    }

    public void setsOptNm(String sOptNm) {
        this.sOptNm = sOptNm;
    }

    public String getsPrdtOptNm() {
        return sPrdtOptNm;
    }

    public void setsPrdtOptNm(String sPrdtOptNm) {
        this.sPrdtOptNm = sPrdtOptNm;
    }

    public String getCorpDiv() {
        return corpDiv;
    }

    public void setCorpDiv(String corpDiv) {
        this.corpDiv = corpDiv;
    }

    public String getRsvCompleteYn() {
        return rsvCompleteYn;
    }

    public void setRsvCompleteYn(String rsvCompleteYn) {
        this.rsvCompleteYn = rsvCompleteYn;
    }

    public String getPrdtDiv() {
        return prdtDiv;
    }

    public void setPrdtDiv(String prdtDiv) {
        this.prdtDiv = prdtDiv;
    }

    public String getExprDaynumYn() {
        return exprDaynumYn;
    }

    public void setExprDaynumYn(String exprDaynumYn) {
        this.exprDaynumYn = exprDaynumYn;
    }

     public String getExprEndDt() {
        return exprEndDt;
    }

    public void setExprEndDt(String exprEndDt) {
        this.exprEndDt = exprEndDt;
    }

    public String getExprStartDt() {
        return exprStartDt;
    }

    public void setExprStartDt(String exprStartDt) {
        this.exprStartDt = exprStartDt;
    }

    public Integer getExprDaynum() {
        return exprDaynum;
    }

    public void setExprDaynum(Integer exprDaynum) {
        this.exprDaynum = exprDaynum;
    }

    public Integer getUseAbleTm() {
        return useAbleTm;
    }

    public void setUseAbleTm(Integer useAbleTm) {
        this.useAbleTm = useAbleTm;
    }
}
