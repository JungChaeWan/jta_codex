package web.mypage.vo;

import oss.cmm.vo.pageDefaultVO;

public class RSV_HISSVO extends pageDefaultVO {

    /** 자동취소여부*/
    private String autoCancelYn = "N";

    /** 대기시간 */
    private int waitingTime;

    /** 사용자 아이디 */
    private String userId;

    /** 예약 명 */
    private String rsvNm;
    /** 예약 이메일 */
    private String rsvEmail;
    /** 예약 전화번호 */
    private String rsvTelnum;

    private String sPrdtCd;
    private String sPrdtNm;
    private String sFromDt;
    private String sToDt;
    private String month;

    // lastIndex의 값을 2로 재설정
    public RSV_HISSVO() {
        super();
        setLastIndex(2);
    }

    public String getAutoCancelYn() {
        return autoCancelYn;
    }

    public void setAutoCancelYn(String autoCancelYn) {
        this.autoCancelYn = autoCancelYn;
    }

    public int getWaitingTime() {
        return waitingTime;
    }

    public void setWaitingTime(int waitingTime) {
        this.waitingTime = waitingTime;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRsvNm() {
        return rsvNm;
    }

    public void setRsvNm(String rsvNm) {
        this.rsvNm = rsvNm;
    }

    public String getRsvEmail() {
        return rsvEmail;
    }

    public void setRsvEmail(String rsvEmail) {
        this.rsvEmail = rsvEmail;
    }

    public String getRsvTelnum() {
        return rsvTelnum;
    }

    public void setRsvTelnum(String rsvTelnum) {
        this.rsvTelnum = rsvTelnum;
    }

    public String getsFromDt() {
        return sFromDt;
    }

    public void setsFromDt(String sFromDt) {
        this.sFromDt = sFromDt;
    }

    public String getsToDt() {
        return sToDt;
    }

    public void setsToDt(String sToDt) {
        this.sToDt = sToDt;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getsPrdtNm() {
        return sPrdtNm;
    }

    public void setsPrdtNm(String sPrdtNm) {
        this.sPrdtNm = sPrdtNm;
    }

    public String getsPrdtCd() {
        return sPrdtCd;
    }

    public void setsPrdtCd(String sPrdtCd) {
        this.sPrdtCd = sPrdtCd;
    }

}
