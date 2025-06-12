package api.vo;

public class APIAligoVO {

    private String rsvNum; //예약번호
    private String subject; //알림톡 제목
    private String msg; //알림톡 내용
    private String msgSMS; //알림톡 대체문자 내용
    private String tplCode; //템플릿 코드
    private String sender; //발신자 연락처
    private String[] receivers; //수신자 연락처
    private String[] recvNames; //수신자 이름
    private String failover; // 실패시 대체문자 전송기능; Y:대체문자전송
    private APIAligoButtonVO[] buttons; // 버튼 정보
    private String sendDept;

    public String getRsvNum() {
        return rsvNum;
    }

    public void setRsvNum(String rsvNum) {
        this.rsvNum = rsvNum;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getTplCode() {
        return tplCode;
    }

    public void setTplCode(String tplCode) {
        this.tplCode = tplCode;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String[] getReceivers() {
        return receivers;
    }

    public void setReceivers(String[] receivers) {
        this.receivers = receivers;
    }

    public String[] getRecvNames() {
        return recvNames;
    }

    public void setRecvNames(String[] recvNames) {
        this.recvNames = recvNames;
    }

    public String getFailover() {
        return failover;
    }

    public void setFailover(String failover) {
        this.failover = failover;
    }

    public String getMsgSMS() {
        return msgSMS;
    }

    public void setMsgSMS(String msgSMS) {
        this.msgSMS = msgSMS;
    }

    public APIAligoButtonVO[] getButtons() {
        return buttons;
    }

    public void setButtons(APIAligoButtonVO[] buttons) {
        this.buttons = buttons;
    }

    public String getSendDept() {
        return sendDept;
    }

    public void setSendDept(String sendDept) {
        this.sendDept = sendDept;
    }
}
