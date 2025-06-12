package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLTariffReqVO extends APITLStockReqVO {
    private String scAgtPlanCode;

    public String getScAgtPlanCode() {
        return scAgtPlanCode;
    }

    @XmlElement(name = "ScAgtPlanCode")
    public void setScAgtPlanCode(String scAgtPlanCode) {
        this.scAgtPlanCode = scAgtPlanCode;
    }
}
