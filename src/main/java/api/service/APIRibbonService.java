package api.service;

import api.vo.APIRibbonVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import web.order.vo.RC_RSVVO;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public interface APIRibbonService {
    List<APIRibbonVO> selectListRibbonTamnaoCarType();

    HashMap<String,Object> carModelInfo(RC_PRDTINFVO webParam);

    List<RC_PRDTINFVO> riblist(RC_PRDTINFSVO webParam);

    public RC_PRDTINFVO ribDetail(RC_PRDTINFSVO prdtSVO, RC_PRDTINFVO prdtVO);

    public RC_PRDTINFVO ribDetailInfo(RC_PRDTINFVO webParam);

    String carResv(String rcRsvNum);

    Boolean carCancel(RC_RSVVO rcRsvVO);
}
