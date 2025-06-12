package api.vo;

import javax.xml.bind.annotation.XmlElement;
import java.util.List;

public class APITLRoomUpReqVO extends APITLAuthVO{

    //1-5 AgtRoomStatusUpdateArray (Request)
    private List<APITLRoomUpReqInfosVO> agrRoomUpReqinfos;

    public List<APITLRoomUpReqInfosVO> getAgrRoomUpReqinfos() {
        return agrRoomUpReqinfos;
    }

    @XmlElement(name = "RoomUpdateRequestInfos")
    public void setAgrRoomUpReqinfos(List<APITLRoomUpReqInfosVO> agrRoomUpReqinfos) {
        this.agrRoomUpReqinfos = agrRoomUpReqinfos;
    }
}
