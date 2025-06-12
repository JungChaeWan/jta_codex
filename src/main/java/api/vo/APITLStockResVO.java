package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLStockResVO {
    private String stockDate;
    private int agtRoomQuantity;
    private String saleStopState;
    private int saleQuantity;
    private int agtStockQuantity;
    private String closingState;

    public String getStockDate() {
        return stockDate;
    }

    @XmlElement(name = "Date", required = true)
    public void setStockDate(String stockDate) {
        this.stockDate = stockDate;
    }

    public int getAgtRoomQuantity() {
        return agtRoomQuantity;
    }

    @XmlElement(name = "AgtRoomQuantity", required = true)
    public void setAgtRoomQuantity(int agtRoomQuantity) {
        this.agtRoomQuantity = agtRoomQuantity;
    }

    public String getSaleStopState() {
        return saleStopState;
    }

    @XmlElement(name = "SaleStopState", required = true)
    public void setSaleStopState(String saleStopState) {
        this.saleStopState = saleStopState;
    }

    public int getSaleQuantity() {
        return saleQuantity;
    }

    @XmlElement(name = "SaleQuantity", required = true)
    public void setSaleQuantity(int saleQuantity) {
        this.saleQuantity = saleQuantity;
    }

    public int getAgtStockQuantity() {
        return agtStockQuantity;
    }

    @XmlElement(name = "AgtStockQuantity", required = true)
    public void setAgtStockQuantity(int agtStockQuantity) {
        this.agtStockQuantity = agtStockQuantity;
    }

    public String getClosingState() {
        return closingState;
    }

    @XmlElement(name = "ClosingState", required = true)
    public void setClosingState(String closingState) {
        this.closingState = closingState;
    }
}
