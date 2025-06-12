package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLPlanPriceVO {
    private String priceCode;
    private String priceName;

    public String getPriceCode() {
        return priceCode;
    }

    @XmlElement(name = "PriceCode", required = true)
    public void setPriceCode(String priceCode) {
        this.priceCode = priceCode;
    }

    public String getPriceName() {
        return priceName;
    }

    @XmlElement(name = "PriceName", required = true)
    public void setPriceName(String priceName) {
        this.priceName = priceName;
    }
}
