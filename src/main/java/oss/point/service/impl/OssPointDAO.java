package oss.point.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;
import oss.corp.vo.CORPSVO;
import oss.corp.vo.CORPVO;
import oss.point.vo.*;

import java.util.List;

@Repository("ossPointDAO")
public class OssPointDAO extends EgovAbstractDAO {

    public void insertPointCpNum(POINT_CPNUMVO pointCpnumVO) {
        insert("POINT_CP_I_00", pointCpnumVO);
    }

    public void insertPointCp(POINT_CPVO pointCp) {
        insert("POINT_CP_I_01", pointCp);
    }

    public List<POINT_CPVO> selectPointCpList(POINT_CPSVO cpListSVO) {
        return (List<POINT_CPVO>) list("POINT_CP_S_00",cpListSVO);
    }

    public Integer getCntCpList(POINT_CPSVO cpListSVO) {
        return (Integer) select("POINT_CP_S_01", cpListSVO);
    }

    public List<POINT_CPNUMVO> selectPointCpPublishingList(POINT_CPNUMVO pointCpnumVO) {
        return (List<POINT_CPNUMVO>) list("POINT_CP_S_02",pointCpnumVO);
    }

    public Integer getCntCpPublishingList(POINT_CPNUMVO pointCpnumVO) {
        return (Integer) select("POINT_CP_S_03", pointCpnumVO);
    }

    public String chkPointCpRegAble(POINTVO pointVO) {
        return (String) select("POINT_CP_S_04", pointVO);
    }

    public POINTVO selectAblePoint(POINTVO pointVO) {
        return (POINTVO) select("POINT_CP_S_05",pointVO);
    }

    public void updatePointCpUseProcess(POINTVO pointVO) {
        update("POINT_CP_U_01", pointVO);
    }

    public void insertPointCpSave(POINTVO pointVO) {
        insert("POINT_CP_I_02", pointVO);
    }

    public POINT_CPVO selectPointCpDetail(String ssPartnerCode) {
        return (POINT_CPVO) select("POINT_CP_S_06",ssPartnerCode);
    }

//    public void updateRsvPointCp(POINTVO pointVO) {
//        update("POINT_CP_U_02", pointVO);
//    }

    public List<POINT_CP_RSVVO> selectRsvPointCp(POINTVO pointVO) {
        return (List<POINT_CP_RSVVO>) list("POINT_CP_S_07",pointVO);
    }

    public POINTVO selectUsePoint(POINTVO pointVO) {
        return (POINTVO) select("POINT_CP_S_08",pointVO);
    }
//
//    public void pointUseCancel(POINTVO pointVO) {
//        //insert("POINT_CP_I_00", pointVO);
//    }

    public void mergePointCorp(POINT_CORPVO pointCorpVO) {
        update("POINT_CP_M_00", pointCorpVO);
    }

    public List<CORPVO> selectPointCorpList(CORPSVO corpSVO) {
        return (List<CORPVO>) list("POINT_CP_S_09", corpSVO);
    }

    public Integer getCntPointCorpList(CORPSVO corpSVO) {
        return (Integer) select("POINT_CP_S_10", corpSVO);
    }

    public void mergePointLimit(POINT_CORPVO pointCorpVO) {
        update("POINT_CP_M_01", pointCorpVO);
    }

    public int selectPartnerCodeDuplChk(POINT_CPVO pointCp) {
        return (Integer) select("POINT_CP_S_11", pointCp);
    }

    public void updatePointCp(POINT_CPVO pointCp) {
        update("POINT_CP_U_04", pointCp);
    }

    public int selectPointCpGroupCnt(String partnerCode) {
        return (Integer) select("POINT_CP_S_12", partnerCode);
    }

    public String chkPointBuyAbleCorp(POINT_CORPVO pointCorpVO) {
        return (String) select("POINT_CP_S_13", pointCorpVO);
    }

    public String chkPointBuyAblePnt(POINT_CORPVO pointCorpVO) {
        return (String) select("POINT_CP_S_14", pointCorpVO);
    }

    public String chkBudgetAblePnt(POINT_CORPVO pointCorpVO) {
        return (String) select("POINT_CP_S_18", pointCorpVO);
    }

    public List<POINTVO> selectAblePointList(POINTVO pointVO) {
        return (List<POINTVO>) list("POINT_CP_S_15",pointVO);
    }

    public void insertUserPoint(POINTVO pointVO) {
        insert("POINT_CP_I_02", pointVO);
    }

    public List<POINTVO> selectPointHistoryList(POINTVO pointVO) {
        return (List<POINTVO>) list("POINT_CP_S_16",pointVO);
    }

    public void delAllCorpReg(POINT_CORPVO pointCorpVO) {
        delete("POINT_CP_D_00", pointCorpVO);
    }

    public void insertAllCorpReg(POINT_CORPVO pointCorpVO) {
        insert("POINT_CP_I_03", pointCorpVO);
    }

}
