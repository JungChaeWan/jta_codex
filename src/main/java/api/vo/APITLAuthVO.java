package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLAuthVO {
    private String LoginId;
    private String LoginPwd;

    public String getLoginId() {
        return LoginId;
    }

    @XmlElement(name = "LoginId")
    public void setLoginId(String loginId) {
        LoginId = loginId;
    }

    public String getLoginPwd() {
        return LoginPwd;
    }

    @XmlElement(name = "LoginPwd")
    public void setLoginPwd(String loginPwd) {
        LoginPwd = loginPwd;
    }
}
