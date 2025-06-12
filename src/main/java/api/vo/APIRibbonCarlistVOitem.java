package api.vo;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "item")
public class APIRibbonCarlistVOitem {
    /** 업체코드 */
    @XmlElement(name = "clientCode")

    private String clientCode;
    /** 업체명 */
    @XmlElement(name = "clientNm")
    private String clientNm;

    /** 차량코드 */
    @XmlElement(name = "vhctyCode")
    private String vhctyCode;

    /** 차량명 */
    @XmlElement(name = "vhctyNm")
    private String vhctyNm;

    /** 연료명 */
    @XmlElement(name = "fuelNm")
    private String fuelNm;

    /** 차량옵션(안전) */
    @XmlElement(name = "optionSafeNm")
    private String optionSafeNm;

    /** 차량옵션(편의) */
    @XmlElement(name = "optionCnvncNm")
    private String optionCnvncNm;

    /** 차량옵션(음향) */
    @XmlElement(name = "optionSondNm")
    private String optionSondNm;

    /** 차량연식 */
    @XmlElement(name = "yemodel")
    private String yemodel;

    /** 면허종류 */
    @XmlElement(name = "license")
    private String license;

    /** 예약가능수량 */
    @XmlElement(name = "possibleCount")
    private String possibleCount;

    /** 차량-자차미포함 판매여부*/
    @XmlElement(name = "stdSaleYn")
    private String stdSaleYn;

    /** 차량 정요금 */
    @XmlElement(name = "stdPrice")
    private String stdPrice;

    /** 차량 할인율 */
    @XmlElement(name = "stdDiscount")
    private String stdDiscount;

    /** 차량 판매요금 */
    @XmlElement(name = "stdSalePrice")
    private String stdSalePrice;

    /** 차량 대여제한 나이 */
    @XmlElement(name = "stdAge")
    private String stdAge;

    /** 차량 대여제한 경력 */
    @XmlElement(name = "stdCareer")
    private String stdCareer;

    /** 일반보험 판매여부*/
    @XmlElement(name = "insuGnrlSaleYn")
    private String insuGnrlSaleYn;

    /** 일반보험 정요금 */
    @XmlElement(name = "insuGnrlPrice")
    private String insuGnrlPrice;

    /** 일반보험 할인율 */
    @XmlElement(name = "insuGnrlDiscount")
    private String insuGnrlDiscount;

    /** 일반보험 판매금액 */
    @XmlElement(name = "insuGnrlSalePrice")
    private String insuGnrlSalePrice;

    /** 일반보험포함 차량 판매금액 */
    @XmlElement(name = "insuGnrlSaleAdupPrice")
    private String insuGnrlSaleAdupPrice;

    /** 일반보험 제한나이 */
    @XmlElement(name = "insuGnrlApplcLmttAge")
    private String insuGnrlApplcLmttAge;

    /** 일반보험 제한경력 */
    @XmlElement(name = "insuGnrlApplcDrverLmttCareer")
    private String insuGnrlApplcDrverLmttCareer;

    /** 일반보험 보상한도 금액 */
    @XmlElement(name = "insuGnrlRewardLmtAmount")
    private String insuGnrlRewardLmtAmount;

    /** 일반보험 면책금 금액 */
    @XmlElement(name = "insuGnrlAcdntNoresponsAmount")
    private String insuGnrlAcdntNoresponsAmount;

    /** 일반보험 보상한도 내용 */
    @XmlElement(name = "insuGnrlRewardLmtContents")
    private String insuGnrlRewardLmtContents;

    /** 고급보험 판매여부*/
    @XmlElement(name = "insuPrfectSaleYn")
    private String insuPrfectSaleYn;

    /** 고급보험 정요금 */
    @XmlElement(name = "insuPrfectPrice")
    private String insuPrfectPrice;

    /** 고급보험 할인율 */
    @XmlElement(name = "insuPrfectDiscount")
    private String insuPrfectDiscount;

    /** 고급보험 판매금액 */
    @XmlElement(name = "insuPrfectSalePrice")
    private String insuPrfectSalePrice;

    /** 고급보험포함 차량 판매금액 */
    @XmlElement(name = "insuPrfectSaleAdupPrice")
    private String insuPrfectSaleAdupPrice;

    /** 고급보험 제한나이 */
    @XmlElement(name = "insuPrfectApplcLmttAge")
    private String insuPrfectApplcLmttAge;

    /** 고급보험 제한경력 */
    @XmlElement(name = "insuPrfectApplcDrverLmttCareer")
    private String insuPrfectApplcDrverLmttCareer;

    /** 고급보험 보상한도 금액 */
    @XmlElement(name = "insuPrfectRewardLmtAmount")
    private String insuPrfectRewardLmtAmount;

    /** 고급보험 면책금 금액 */
    @XmlElement(name = "insuPrfectAcdntNoresponsAmount")
    private String insuPrfectAcdntNoresponsAmount;

    /** 고급보험 보상한도 내용 */
    @XmlElement(name = "insuPrfectRewardLmtContents")
    private String insuPrfectRewardLmtContents;

    public String getClientCode() {
        return clientCode;
    }

    public String getClientNm() {
        return clientNm;
    }

    public String getVhctyCode() {
        return vhctyCode;
    }

    public String getVhctyNm() {
        return vhctyNm;
    }

    public String getFuelNm() {
        return fuelNm;
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

    public String getPossibleCount() {
        return possibleCount;
    }

    public String getStdSaleYn() {
        return stdSaleYn;
    }

    public String getStdPrice() {
        return stdPrice;
    }

    public String getStdDiscount() {
        return stdDiscount;
    }

    public String getStdSalePrice() {
        return stdSalePrice;
    }

    public String getStdAge() {
        return stdAge;
    }

    public String getStdCareer() {
        return stdCareer;
    }

    public String getInsuGnrlSaleYn() {
        return insuGnrlSaleYn;
    }

    public String getInsuGnrlPrice() {
        return insuGnrlPrice;
    }

    public String getInsuGnrlDiscount() {
        return insuGnrlDiscount;
    }

    public String getInsuGnrlSalePrice() {
        return insuGnrlSalePrice;
    }

    public String getInsuGnrlSaleAdupPrice() {
        return insuGnrlSaleAdupPrice;
    }

    public String getInsuGnrlApplcLmttAge() {
        return insuGnrlApplcLmttAge;
    }

    public String getInsuGnrlApplcDrverLmttCareer() {
        return insuGnrlApplcDrverLmttCareer;
    }

    public String getInsuGnrlRewardLmtAmount() {
        return insuGnrlRewardLmtAmount;
    }

    public String getInsuGnrlRewardLmtContents() {
        return insuGnrlRewardLmtContents;
    }

    public String getInsuPrfectSaleYn() {
        return insuPrfectSaleYn;
    }

    public String getInsuPrfectPrice() {
        return insuPrfectPrice;
    }

    public String getInsuPrfectDiscount() {
        return insuPrfectDiscount;
    }

    public String getInsuPrfectSalePrice() {
        return insuPrfectSalePrice;
    }

    public String getInsuPrfectSaleAdupPrice() {
        return insuPrfectSaleAdupPrice;
    }

    public String getInsuPrfectApplcLmttAge() {
        return insuPrfectApplcLmttAge;
    }

    public String getInsuPrfectApplcDrverLmttCareer() {
        return insuPrfectApplcDrverLmttCareer;
    }

    public String getInsuPrfectRewardLmtAmount() {
        return insuPrfectRewardLmtAmount;
    }

    public String getInsuPrfectRewardLmtContents() {
        return insuPrfectRewardLmtContents;
    }

    public String getInsuGnrlAcdntNoresponsAmount() {
        return insuGnrlAcdntNoresponsAmount;
    }

    public String getInsuPrfectAcdntNoresponsAmount() {
        return insuPrfectAcdntNoresponsAmount;
    }
}
