package api.vo;

import javax.xml.bind.annotation.XmlElement;

public class APITLRoomTypeVO {
    //AgtRoomInfos Element
    /** {room code} TB_AD_PRDTINF.PRDT_NUM */
    private String scAgtRoomCode;

    /** {room name} TB_AD_PRDTINF.PRDT_NM */
    private String agtRoomIndicationName;

    /** {Sales state "0":판매중 "1": 일시정지} TB_AD_PRDTINF.TRADE_STATUS 거래상태 */
    private String salesState;

    public String getScAgtRoomCode() {
        return scAgtRoomCode;
    }

    @XmlElement(name = "ScAgtRoomCode", required = true)
    public void setScAgtRoomCode(String scAgtRoomCode) {
        this.scAgtRoomCode = scAgtRoomCode;
    }

    public String getAgtRoomIndicationName() {
        return agtRoomIndicationName;
    }

    @XmlElement(name = "AgtRoomIndicationName", required = true)
    public void setAgtRoomIndicationName(String agtRoomIndicationName) {
        this.agtRoomIndicationName = agtRoomIndicationName;
    }

    public String getSalesState() {
        return salesState;
    }

    @XmlElement(name = "SalesState")
    public void setSalesState(String salesState) {
        this.salesState = salesState;
    }
}