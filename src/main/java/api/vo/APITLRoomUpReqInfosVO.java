package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLRoomUpReqInfosVO {
    //RoomUpdateRequestInfos Element
    /*Room Code*/
    private String scAgtRoomCode;

    /*지정일*/
    private String appointedDate;

    /*판매상태 0:판매, 1:중지*/
    private String stopStartDivision;

    /*빈 방 수*/
    private int agtStockQuantity;

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

    public String getStopStartDivision() {
        return stopStartDivision;
    }

    @XmlElement(name = "StopStartDivision", required = true)
    public void setStopStartDivision(String stopStartDivision) {
        this.stopStartDivision = stopStartDivision;
    }

    public int getAgtStockQuantity() {
        return agtStockQuantity;
    }

    @XmlElement(name = "AgtStockQuantity", required = true)
    public void setAgtStockQuantity(int agtStockQuantity) {
        this.agtStockQuantity = agtStockQuantity;
    }
}
