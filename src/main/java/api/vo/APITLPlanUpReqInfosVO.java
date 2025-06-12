package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLPlanUpReqInfosVO {
    private String ScAgtPlanCode;
    private String ScAgtRoomCode;
    private String AppointedDate;
    private String StopStartDivision;
    private int PriceCode1;

    public String getScAgtPlanCode() {
        return ScAgtPlanCode;
    }

    @XmlElement(name = "ScAgtPlanCode", required = true)
    public void setScAgtPlanCode(String scAgtPlanCode) {
        ScAgtPlanCode = scAgtPlanCode;
    }

    public String getScAgtRoomCode() {
        return ScAgtRoomCode;
    }

    @XmlElement(name = "ScAgtRoomCode", required = true)
    public void setScAgtRoomCode(String scAgtRoomCode) {
        ScAgtRoomCode = scAgtRoomCode;
    }

    public String getAppointedDate() {
        return AppointedDate;
    }

    @XmlElement(name = "AppointedDate", required = true)
    public void setAppointedDate(String appointedDate) {
        AppointedDate = appointedDate;
    }

    public String getStopStartDivision() {
        return StopStartDivision;
    }

    @XmlElement(name = "StopStartDivision", required = true)
    public void setStopStartDivision(String stopStartDivision) {
        StopStartDivision = stopStartDivision;
    }

    public int getPriceCode1() {
        return PriceCode1;
    }

    @XmlElement(name = "PriceCode1")
    public void setPriceCode1(int priceCode1) {
        PriceCode1 = priceCode1;
    }
}
