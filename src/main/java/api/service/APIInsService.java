package api.service;


import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import web.order.vo.RC_RSVVO;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public interface APIInsService {
    HashMap<String,Object> inslist(RC_PRDTINFVO webParam) throws IOException;

    List<RC_PRDTINFVO> carsearch(RC_PRDTINFSVO webParam) throws IOException;

    HashMap<String,Object> carlist_r(RC_PRDTINFVO webParam) throws IOException;

    void updateCarSaleStart(RC_PRDTINFVO webParam) throws IOException;

    RC_PRDTINFVO carsearchbymodelcodes(RC_PRDTINFSVO prdtSVO, RC_PRDTINFVO prdtVO) throws IOException;

    String revadd(String rcRsvNum) throws IOException;

    Boolean revcancel(RC_RSVVO rcRsvVO) throws IOException;
}
