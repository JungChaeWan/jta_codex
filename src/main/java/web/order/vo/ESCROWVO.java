package web.order.vo;

public class ESCROWVO {
    String mid;
    String oid;
    String dlvType;
    String dlvDate;
    String dlvCompCode;
    String dlvNo;
    String dlvWorker;
    String dlvWorkertel;
    String hashdata;
    String productid;
    String rcvDate;
    String rcvName;
    String rcvRelation;
    String corpCd; //업체 유형 코드
    String payDiv; //결제 구분

    /** 발송 log 추가 **/
    String resp; //성공여부
    String sendMsg;
    String respMsg;
    String svRsvNum;

    /** 처리결과 수신 추가 **/
    String tid;
    String txtype;
    String hashdata2;
    String hashCheckYn;
    String resdate;

    public String getMid() {
        return mid;
    }

    public void setMid(String mid) {
        this.mid = mid;
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public String getDlvType() {
        return dlvType;
    }

    public void setDlvType(String dlvType) {
        this.dlvType = dlvType;
    }

    public String getDlvDate() {
        return dlvDate;
    }

    public void setDlvDate(String dlvDate) {
        this.dlvDate = dlvDate;
    }

    public String getDlvCompCode() {
        return dlvCompCode;
    }

    public void setDlvCompCode(String dlvCompCode) {
        this.dlvCompCode = dlvCompCode;
    }

    public String getDlvNo() {
        return dlvNo;
    }

    public void setDlvNo(String dlvNo) {
        this.dlvNo = dlvNo;
    }

    public String getDlvWorker() {
        return dlvWorker;
    }

    public void setDlvWorker(String dlvWorker) {
        this.dlvWorker = dlvWorker;
    }

    public String getDlvWorkertel() {
        return dlvWorkertel;
    }

    public void setDlvWorkertel(String dlvWorkertel) {
        this.dlvWorkertel = dlvWorkertel;
    }

    public String getHashdata() {
        return hashdata;
    }

    public void setHashdata(String hashdata) {
        this.hashdata = hashdata;
    }

    public String getProductid() {
        return productid;
    }

    public void setProductid(String productid) {
        this.productid = productid;
    }

    public String getRcvDate() {
        return rcvDate;
    }

    public void setRcvDate(String rcvDate) {
        this.rcvDate = rcvDate;
    }

    public String getRcvName() {
        return rcvName;
    }

    public void setRcvName(String rcvName) {
        this.rcvName = rcvName;
    }

    public String getRcvRelation() {
        return rcvRelation;
    }

    public void setRcvRelation(String rcvRelation) {
        this.rcvRelation = rcvRelation;
    }

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public String getTxtype() {
        return txtype;
    }

    public void setTxtype(String txtype) {
        this.txtype = txtype;
    }

    public String getHashdata2() {
        return hashdata2;
    }

    public void setHashdata2(String hashdata2) {
        this.hashdata2 = hashdata2;
    }

    public String getHashCheckYn() {
        return hashCheckYn;
    }

    public void setHashCheckYn(String hashCheckYn) {
        this.hashCheckYn = hashCheckYn;
    }

    public String getResdate() {
        return resdate;
    }

    public void setResdate(String resdate) {
        this.resdate = resdate;
    }

    public String getCorpCd() {
        return corpCd;
    }

    public void setCorpCd(String corpCd) {
        this.corpCd = corpCd;
    }

    public String getPayDiv() {
        return payDiv;
    }

    public void setPayDiv(String payDiv) {
        this.payDiv = payDiv;
    }

    public String getSendMsg() {
        return sendMsg;
    }

    public void setSendMsg(String sendMsg) {
        this.sendMsg = sendMsg;
    }

    public String getRespMsg() {
        return respMsg;
    }

    public void setRespMsg(String respMsg) {
        this.respMsg = respMsg;
    }

    public String getResp() {
        return resp;
    }

    public void setResp(String resp) {
        this.resp = resp;
    }

    public String getSvRsvNum() {
        return svRsvNum;
    }

    public void setSvRsvNum(String svRsvNum) {
        this.svRsvNum = svRsvNum;
    }
}
