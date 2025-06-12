package api.vo;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

@XmlRootElement(name="response")
public class APIRibbonCarlistVO {

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
        @XmlElement(name = "items")
        private List<APIRibbonCarlistVOitems> items;
        public List<APIRibbonCarlistVOitems> getItems() {
            return items;
        }

        private String resveNo;

        public String getResveNo() {
            return resveNo;
        }

        public void setResveNo(String resveNo) {
            this.resveNo = resveNo;
        }
    }

    public Head getHead() {
        return head;
    }

    public Body getBody() {
        return body;
    }
}
