package api.vo;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

@XmlRootElement(name="response")
public class APIRibbonCarModelinfoVO {

    @XmlElement(name = "head")
    private Head head;

    @XmlElement(name = "body")
    private Body body;

    @XmlRootElement(name = "head")
    public static class Head {

        private String resultCode;
        private String resultMsg;

        public String getResultCode() {
            return resultCode;
        }

        public void setResultCode(String resultCode) {
            this.resultCode = resultCode;
        }

        public String getResultMsg() {
            return resultMsg;
        }

        public void setResultMsg(String resultMsg) {
            this.resultMsg = resultMsg;
        }
    }

    @XmlRootElement(name = "body")
    public static class Body {
        @XmlElement(name = "item")
        private List<APIRibbonCarModelinfoVOitem> item;

        public List<APIRibbonCarModelinfoVOitem> getItem() {
            return item;
        }
    }

    public Head getHead() {
        return head;
    }

    public Body getBody() {
        return body;
    }
}
