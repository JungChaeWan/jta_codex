package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLVO {
    private APITLResultVO agtRoomTypeDownloadResult;
    private APITLResultVO planDownloadResult;

    public APITLResultVO getPlanDownloadResult() {
        return planDownloadResult;
    }

    @XmlElement(name = "PlanDownloadResult", required = true)
    public void setPlanDownloadResult(APITLResultVO planDownloadResult) {
        this.planDownloadResult = planDownloadResult;
    }

    public APITLResultVO getAgtRoomTypeDownloadResult() {
        return agtRoomTypeDownloadResult;
    }

    @XmlElement(name = "AgtRoomTypeDownloadResult", required = true)
    public void setAgtRoomTypeDownloadResult(APITLResultVO agtRoomTypeDownloadResult) {
        this.agtRoomTypeDownloadResult = agtRoomTypeDownloadResult;
    }
}
