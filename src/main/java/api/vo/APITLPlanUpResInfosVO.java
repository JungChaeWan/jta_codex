package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLPlanUpResInfosVO {
    private String scAgtPlanCode;
    private String scAgtRoomCode;
    private String appointedDate;
    private String success;
    private String errorMsg;
    private String saleStopState;
    private int priceCode1;

    public String getScAgtPlanCode() {
        return scAgtPlanCode;
    }

    @XmlElement(name = "ScAgtPlanCode", required = true)
    public void setScAgtPlanCode(String scAgtPlanCode) {
        this.scAgtPlanCode = scAgtPlanCode;
    }

    public String getScAgtRoomCode() {
        return scAgtRoomCode;
    }

    @XmlElement(name = "ScAgtRoomCode", required = true)
    public void setScAgtRoomCode(String scAgtRoomCode) {
        this.scAgtRoomCode = scAgtRoomCode;
    }

    public String getAppointedDate() {
        return appointedDate;
    }

    @XmlElement(name = "AppointedDate", required = true)
    public void setAppointedDate(String appointedDate) {
        this.appointedDate = appointedDate;
    }

    public String getSuccess() {
        return success;
    }

    @XmlElement(name = "Success", required = true)
    public void setSuccess(String success) {
        this.success = success;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    @XmlElement(name = "ErrorMsg", required = true)
    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    public String getSaleStopState() {
        return saleStopState;
    }

    @XmlElement(name = "SaleStopState")
    public void setSaleStopState(String saleStopState) {
        this.saleStopState = saleStopState;
    }

    public int getPriceCode1() {
        return priceCode1;
    }

    @XmlElement(name = "PriceCode1")
    public void setPriceCode1(int priceCode1) {
        this.priceCode1 = priceCode1;
    }
}
