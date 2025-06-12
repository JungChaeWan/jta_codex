package oss.monitoring.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;
import oss.monitoring.vo.TLCORPVO;
import web.order.vo.ORDERVO;

import java.util.List;

@Repository("mntrDAO")
public class MntrDAO extends EgovAbstractDAO {
    public List<ORDERVO> selectCancelErrList(){
        return (List<ORDERVO>) list("MNTRTL_S_00");
    }

    public List<TLCORPVO> selectTlCorpList(){
        return  (List<TLCORPVO>) list("MNTRTL_S_01");
    }

    public void updateTlChildType(TLCORPVO tlCorpVO){
        update("MNTRTL_U_00", tlCorpVO);
    }

    public Integer getCntTLRsvErr(){
        return (Integer) select("MNTRTL_S_02");
    }

    public void updateTlPriceLink(TLCORPVO tlCorpVO){
        update("MNTRTL_U_01", tlCorpVO);
    }

    public List<ORDERVO> selectPointRsvErrList() {
        return (List<ORDERVO>) list("MNTRTL_S_03");
    }
}
