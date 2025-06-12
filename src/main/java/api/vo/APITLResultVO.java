package api.vo;

import javax.xml.bind.annotation.XmlElement;
import java.util.List;

public class APITLResultVO  {
    private String success;
    private String errorMsg;

    private List<APITLRoomTypeVO> agtRoomInfos; //1-1 agtRoomTypeDownload
    private List<APITLPlanVO> agtPlanRoomInfos; //1-2 PlanDownload
    private List<APITLStockResVO> stockDatas; //1-3 StockDataDownload
    private List<APITLTariffResVO> tariffDatas; // 1-4 tariffDatas (price check)
    private List<APITLRoomUpResInfosVO> roomUpdateResultInfos; //1-5 AgtRoomStatusUpdateArray (response)
    private List<APITLPlanUpResInfosVO> planUpdateResultInfos; //1-6 PlanStatusUpdateArray (response)

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

    public List<APITLRoomTypeVO> getAgtRoomInfos() {
        return agtRoomInfos;
    }

    @XmlElement(name = "AgtRoomInfos")
    public void setAgtRoomInfos(List<APITLRoomTypeVO> agtRoomInfos) {
        this.agtRoomInfos = agtRoomInfos;
    }

    public List<APITLPlanVO> getAgtPlanRoomInfos() {
        return agtPlanRoomInfos;
    }

    @XmlElement(name = "AgtPlanRoomInfos")
    public void setAgtPlanRoomInfos(List<APITLPlanVO> agtPlanRoomInfos) {
        this.agtPlanRoomInfos = agtPlanRoomInfos;
    }

    public List<APITLStockResVO> getStockDatas() {
        return stockDatas;
    }

    @XmlElement(name = "StockDatas")
    public void setStockDatas(List<APITLStockResVO> stockDatas) {
        this.stockDatas = stockDatas;
    }

    public List<APITLRoomUpResInfosVO> getRoomUpdateResultInfos() { return roomUpdateResultInfos; }

    @XmlElement(name = "RoomUpdateResultInfos")
    public void setRoomUpdateResultInfos(List<APITLRoomUpResInfosVO> roomUpdateResultInfos) {
        this.roomUpdateResultInfos = roomUpdateResultInfos;
    }

    public List<APITLTariffResVO> getTariffDatas() {
        return tariffDatas;
    }

    @XmlElement(name = "TariffDatas")
    public void setTariffDatas(List<APITLTariffResVO> tariffDatas) {
        this.tariffDatas = tariffDatas;
    }

    public List<APITLPlanUpResInfosVO> getPlanUpdateResultInfos() {
        return planUpdateResultInfos;
    }

    @XmlElement(name = "PlanUpdateResultInfos")
    public void setPlanUpdateResultInfos(List<APITLPlanUpResInfosVO> planUpdateResultInfos) {
        this.planUpdateResultInfos = planUpdateResultInfos;
    }
}
