package api.vo;

import javax.xml.bind.annotation.XmlElement;
import java.util.List;

public class APITLPlanVO {
    //agtPlanRoomInfos
    private String scAgtPlanCode;
    private String scAgtRoomCode;
    private String planIndicationName;
    private String salesState;
    private String roomRateOrPersonalRate;
    private List<APITLPlanPriceVO> prices;

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

    public String getPlanIndicationName() {
        return planIndicationName;
    }

    @XmlElement(name = "PlanIndicationName", required = true)
    public void setPlanIndicationName(String planIndicationName) {
        this.planIndicationName = planIndicationName;
    }

    public String getSalesState() {
        return salesState;
    }

    @XmlElement(name = "SalesState", required = true)
    public void setSalesState(String salesState) {
        this.salesState = salesState;
    }

    public String getRoomRateOrPersonalRate() {
        return roomRateOrPersonalRate;
    }

    @XmlElement(name = "RoomRateOrPersonalRate", required = true)
    public void setRoomRateOrPersonalRate(String roomRateOrPersonalRate) {
        this.roomRateOrPersonalRate = roomRateOrPersonalRate;
    }

    public List<APITLPlanPriceVO> getPrices() {
        return prices;
    }

    @XmlElement(name = "Prices")
    public void setPrices(List<APITLPlanPriceVO> prices) {
        this.prices = prices;
    }
}
