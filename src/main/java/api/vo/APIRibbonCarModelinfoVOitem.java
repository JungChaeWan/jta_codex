package api.vo;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="item")
public class APIRibbonCarModelinfoVOitem {
    /** 업체코드(탐나오) */
    @XmlElement(name = "clientId")
    private String clientId;

    /** 차량명(탐나오) */
    @XmlElement(name = "vhctyNm")
    private String vhctyNm;

    /** 차량명(업체차량명) */
    @XmlElement(name = "bcncVhctyNm")
    private String bcncVhctyNm;

    /** 차량코드 */
    @XmlElement(name = "vhctyCode")
    private String vhctyCode;

    /** 차량코드(탐나오) */
    @XmlElement(name = "bcncVhctyCode")
    private String bcncVhctyCode;

    /** 연료타입 */
    @XmlElement(name = "fuelNm")
    private String fuelNm;

    /** 기어 */
    @XmlElement(name = "gearNm")
    private String gearNm;

    /** 안전옵션명 */
    @XmlElement(name = "optionSafeNm")
    private String optionSafeNm;

    /** 편의옵션명 */
    @XmlElement(name = "optionCnvncNm")
    private String optionCnvncNm;

    /** 음향옵션명 */
    @XmlElement(name = "optionSondNm")
    private String optionSondNm;

    /** 차량연식 */
    @XmlElement(name = "yemodel")
    private String yemodel;

    /** 면허종류 */
    @XmlElement(name = "license")
    private String license;

    /** 연령 */
    @XmlElement(name = "licenseLmttAge")
    private String licenseLmttAge;

    /** 경력 */
    @XmlElement(name = "licenseLmttCareer")
    private String licenseLmttCareer;

    public String getClientId() {
        return clientId;
    }

    public String getVhctyNm() {
        return vhctyNm;
    }

    public String getBcncVhctyCode() {
        return bcncVhctyCode;
    }

    public String getFuelNm() {
        return fuelNm;
    }

    public String getGearNm() {
        return gearNm;
    }

    public String getOptionSafeNm() {
        return optionSafeNm;
    }

    public String getOptionCnvncNm() {
        return optionCnvncNm;
    }

    public String getOptionSondNm() {
        return optionSondNm;
    }

    public String getYemodel() {
        return yemodel;
    }

    public String getLicense() {
        return license;
    }

    public String getLicenseLmttAge() {
        return licenseLmttAge;
    }

    public String getLicenseLmttCareer() {
        return licenseLmttCareer;
    }

    public String getVhctyCode() {
        return vhctyCode;
    }

    public String getBcncVhctyNm() {
        return bcncVhctyNm;
    }
}
