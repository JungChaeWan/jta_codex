package api.vo;

import javax.xml.bind.annotation.XmlElement;
import java.util.List;

public class APITLPlanUpReqVO extends APITLAuthVO{

    //1-6 PlanStatusUpdateArray (Request)
    private List<APITLPlanUpReqInfosVO> planUpdateRequestInfos;

    public List<APITLPlanUpReqInfosVO> getPlanUpdateRequestInfos() {
        return planUpdateRequestInfos;
    }

    @XmlElement(name = "PlanUpdateRequestInfos")
    public void setPlanUpdateRequestInfos(List<APITLPlanUpReqInfosVO> planUpdateRequestInfos) {
        this.planUpdateRequestInfos = planUpdateRequestInfos;
    }
}
