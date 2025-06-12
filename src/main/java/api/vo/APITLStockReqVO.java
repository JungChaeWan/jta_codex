package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLStockReqVO extends APITLAuthVO{
    private String scAgtRoomCode;
    private String appointedDate;
    private int acquireDayNums;

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

    public int getAcquireDayNums() {
        return acquireDayNums;
    }

    @XmlElement(name = "AcquireDayNums", required = true)
    public void setAcquireDayNums(int acquireDayNums) {
        this.acquireDayNums = acquireDayNums;
    }
}
