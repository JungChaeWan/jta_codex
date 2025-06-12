package web.order.vo;

import java.util.Date;

public class AD_RSV_DAYPRICEVO {
    /** 숙박 예약 번호 */
    private String adRsvNum;
    /** 예약 번호 */
    private String rsvNum;
    /** 이용 일자 */
    private String aplDt;
    /** 판매 금액 */
    private int saleAmt;
    private int saleAmtNet;
    /** 성인 추가 금액 */
    private int adultAddAmt;
    /** 소인 추가 금액 */
    private int juniorAddAmt;
    /** 유아 추가 금액 */
    private int childAddAmt;
    /** 연박 할인 금액 */
    private int ctnDisAmt;
    /** 총 금액 */
    private int totAmt;
    private int totAmtNet;
    /** 등록일 */
    private Date regDttm;
    /** 입금가 **/
    private String depositAmt;
    /** TLL 금액 연동 기준 (SELL:판매가, NET:입금가) **/
    private String tllPriceLink;

    public String getAdRsvNum() {
        return adRsvNum;
    }

    public void setAdRsvNum(String adRsvNum) {
        this.adRsvNum = adRsvNum;
    }

    public String getRsvNum() {
        return rsvNum;
    }

    public void setRsvNum(String rsvNum) {
        this.rsvNum = rsvNum;
    }

    public String getAplDt() {
        return aplDt;
    }

    public void setAplDt(String aplDt) {
        this.aplDt = aplDt;
    }

    public int getSaleAmt() {
        return saleAmt;
    }

    public void setSaleAmt(int saleAmt) {
        this.saleAmt = saleAmt;
    }

    public int getAdultAddAmt() {
        return adultAddAmt;
    }

    public void setAdultAddAmt(int adultAddAmt) {
        this.adultAddAmt = adultAddAmt;
    }

    public int getJuniorAddAmt() {
        return juniorAddAmt;
    }

    public void setJuniorAddAmt(int juniorAddAmt) {
        this.juniorAddAmt = juniorAddAmt;
    }

    public int getChildAddAmt() {
        return childAddAmt;
    }

    public void setChildAddAmt(int childAddAmt) {
        this.childAddAmt = childAddAmt;
    }

    public int getTotAmt() {
        return totAmt;
    }

    public void setTotAmt(int totAmt) {
        this.totAmt = totAmt;
    }

    public Date getRegDttm() {
        return regDttm;
    }

    public void setRegDttm(Date regDttm) {
        this.regDttm = regDttm;
    }

    public int getCtnDisAmt() {
        return ctnDisAmt;
    }

    public void setCtnDisAmt(int ctnDisAmt) {
        this.ctnDisAmt = ctnDisAmt;
    }

    public String getDepositAmt() {
        return depositAmt;
    }

    public void setDepositAmt(String depositAmt) {
        this.depositAmt = depositAmt;
    }

    public String getTllPriceLink() {
        return tllPriceLink;
    }

    public void setTllPriceLink(String tllPriceLink) {
        this.tllPriceLink = tllPriceLink;
    }

    public int getSaleAmtNet() {
        return saleAmtNet;
    }

    public void setSaleAmtNet(int saleAmtNet) {
        this.saleAmtNet = saleAmtNet;
    }

    public int getTotAmtNet() {
        return totAmtNet;
    }

    public void setTotAmtNet(int totAmtNet) {
        this.totAmtNet = totAmtNet;
    }
}
