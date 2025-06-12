package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLRoomUpResInfosVO {
    private String scAgtRoomCode;
    private String appointedDate;
    private String success;
    private String errorMsg;
    private String saleStopState;
    private int agtStockQuantity;
    private String closingState;

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

    public int getAgtStockQuantity() {
        return agtStockQuantity;
    }

    @XmlElement(name = "AgtStockQuantity")
    public void setAgtStockQuantity(int agtStockQuantity) {
        this.agtStockQuantity = agtStockQuantity;
    }

    public String getClosingState() {
        return closingState;
    }

    @XmlElement(name = "ClosingState", required = true)
    public void setClosingState(String closingState) {
        this.closingState = closingState;
    }
}
