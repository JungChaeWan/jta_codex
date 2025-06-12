package api.vo;

public class APITLBookingVO {
    /**고유번호**/
    private String dataId;
    private String rsvNum;
    private String adRsvNum;

    /**숙소(시설사) 정보**/
    private String corpTelNum;
    private String corpNm;
    private String corpId;

    /**예약자 정보**/
    private String rsvNm;
    private String rsvTelnum;
    private String rsvEmail;

    /**사용일(CheckIn Date) **/
    private String useDt;

    /**숙박자 정보**/
    private String useNm;
    private String useTelnum;
    private String useEmail;

    /**숙박일수**/
    private int useNight;

    /**성.소.유 합계**/
    private int adNum;
    /**성.소.유 인원**/
    private int adultNum;
    private int juniorNum;
    private int childNum;

    /**일별 숙박요금  (숙박요금)**/
    private int nmlAmt;
    private int nmlAmtNet;
    /**일별 숙박요금 청구액 (숙박요금 + 인원추가요금)**/
    private int saleAmt;
    private int saleAmtNet;

    /**룸 타입 코드**/
    private String prdtNum;
    private String prdtNm;

    /**LPOINT 사용 내역**/
    private int usePoint;

    /**소아, 유아 매핑코드**/
    private String juniorAgeStdApicode;
    private String childAgeStdApicode;

    /**예약전송기준**/
    private String tllRsvLink;

    public String getDataId() {
        return dataId;
    }

    public void setDataId(String dataId) {
        this.dataId = dataId;
    }

    public String getRsvNum() {
        return rsvNum;
    }

    public void setRsvNum(String rsvNum) {
        this.rsvNum = rsvNum;
    }

    public String getAdRsvNum() {
        return adRsvNum;
    }

    public void setAdRsvNum(String adRsvNum) {
        this.adRsvNum = adRsvNum;
    }

    public String getCorpTelNum() {
        return corpTelNum;
    }

    public void setCorpTelNum(String corpTelNum) {
        this.corpTelNum = corpTelNum;
    }

    public String getCorpNm() {
        return corpNm;
    }

    public void setCorpNm(String corpNm) {
        this.corpNm = corpNm;
    }

    public String getCorpId() {
        return corpId;
    }

    public void setCorpId(String corpId) {
        this.corpId = corpId;
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

    public String getRsvEmail() {
        return rsvEmail;
    }

    public void setRsvEmail(String rsvEmail) {
        this.rsvEmail = rsvEmail;
    }

    public String getUseDt() {
        return useDt;
    }

    public void setUseDt(String useDt) {
        this.useDt = useDt;
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

    public String getUseEmail() {
        return useEmail;
    }

    public void setUseEmail(String useEmail) {
        this.useEmail = useEmail;
    }

    public String getPrdtNum() {
        return prdtNum;
    }

    public void setPrdtNum(String prdtNum) {
        this.prdtNum = prdtNum;
    }

    public String getPrdtNm() {
        return prdtNm;
    }

    public void setPrdtNm(String prdtNm) {
        this.prdtNm = prdtNm;
    }

    public int getUsePoint() {
        return usePoint;
    }

    public void setUsePoint(int usePoint) {
        this.usePoint = usePoint;
    }

    public int getUseNight() {
        return useNight;
    }

    public void setUseNight(int useNight) {
        this.useNight = useNight;
    }

    public int getAdNum() {
        return adNum;
    }

    public void setAdNum(int adNum) {
        this.adNum = adNum;
    }

    public int getAdultNum() {
        return adultNum;
    }

    public void setAdultNum(int adultNum) {
        this.adultNum = adultNum;
    }

    public int getJuniorNum() {
        return juniorNum;
    }

    public void setJuniorNum(int juniorNum) {
        this.juniorNum = juniorNum;
    }

    public int getChildNum() {
        return childNum;
    }

    public void setChildNum(int childNum) {
        this.childNum = childNum;
    }

    public int getNmlAmt() {
        return nmlAmt;
    }

    public void setNmlAmt(int nmlAmt) {
        this.nmlAmt = nmlAmt;
    }

    public int getSaleAmt() {
        return saleAmt;
    }

    public void setSaleAmt(int saleAmt) {
        this.saleAmt = saleAmt;
    }

    public String getJuniorAgeStdApicode() {
        return juniorAgeStdApicode;
    }

    public void setJuniorAgeStdApicode(String juniorAgeStdApicode) {
        this.juniorAgeStdApicode = juniorAgeStdApicode;
    }

    public String getChildAgeStdApicode() {
        return childAgeStdApicode;
    }

    public void setChildAgeStdApicode(String childAgeStdApicode) {
        this.childAgeStdApicode = childAgeStdApicode;
    }

    public String getTllRsvLink() {
        return tllRsvLink;
    }

    public void setTllRsvLink(String tllRsvLink) {
        this.tllRsvLink = tllRsvLink;
    }

    public int getNmlAmtNet() {
        return nmlAmtNet;
    }

    public void setNmlAmtNet(int nmlAmtNet) {
        this.nmlAmtNet = nmlAmtNet;
    }

    public int getSaleAmtNet() {
        return saleAmtNet;
    }

    public void setSaleAmtNet(int saleAmtNet) {
        this.saleAmtNet = saleAmtNet;
    }
}
