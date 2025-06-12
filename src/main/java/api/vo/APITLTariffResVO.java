package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLTariffResVO {
    private String tariffDate;
    private String saleStopState;
    private int PriceCode1;
    private String closingState;

    public String getTariffDate() {
        return tariffDate;
    }

    @XmlElement(name = "Date", required = true)
    public void setTariffDate(String tariffDate) {
        this.tariffDate = tariffDate;
    }

    public String getSaleStopState() {
        return saleStopState;
    }

    @XmlElement(name = "SaleStopState", required = true)
    public void setSaleStopState(String saleStopState) {
        this.saleStopState = saleStopState;
    }

    public int getPriceCode1() {
        return PriceCode1;
    }

    @XmlElement(name = "PriceCode1")
    public void setPriceCode1(int priceCode1) {
        PriceCode1 = priceCode1;
    }

    public String getClosingState() {
        return closingState;
    }

    @XmlElement(name = "ClosingState", required = true)
    public void setClosingState(String closingState) {
        this.closingState = closingState;
    }
}
