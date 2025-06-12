package api.service;


import api.vo.APIOrcCarlistVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import web.order.vo.RC_RSVVO;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

public interface APIOrcService {
    HashMap<String,Object> vehicleModels(RC_PRDTINFVO webParam);

    RC_PRDTINFVO vehicleModelDetail(RC_PRDTINFVO webParam);

    List<APIOrcCarlistVO> vehicleAvailList(RC_PRDTINFSVO webParam) throws UnsupportedEncodingException;

    RC_PRDTINFVO vehicleAvailDetail(RC_PRDTINFSVO webParam, RC_PRDTINFVO prdtVO);

    String vehicleReservation(String dtlRsvNum);

    Boolean vehicleCancel(RC_RSVVO rsvDtlVO);
}
