package oss.point.service;

import oss.corp.vo.CORPSVO;
import oss.corp.vo.CORPVO;
import oss.point.vo.*;

import java.util.List;
import java.util.Map;

public interface OssPointService {
    void insertPointCpNum(POINT_CPNUMVO pointCpnumVO);
    void insertPointCp(POINT_CPVO pointCp);
    Map<String, Object> selectPointCpList(POINT_CPSVO pointCpSVO);
    Map<String, Object> selectPointCpPublishingList(POINT_CPNUMVO cpPublishingVO);
    void pointCpReg(POINTVO pointVO);
    void pointCpUse(POINTVO pointVO);
    String chkPointCpRegAble(POINTVO pointVO);
    POINTVO selectAblePoint(POINTVO pointVO);
    POINT_CPVO selectPointCpDetail(String ssPartnerCode);
    List<POINT_CP_RSVVO> selectRsvPointCp(POINTVO pointVO);
    POINTVO selectUsePoint(POINTVO pointVO);
    void insertPointCpSave(POINTVO pointVO);
    void mergePointCorp(POINT_CORPVO pointCorpVO);
    Map<String, Object> selectPointCorpList(CORPSVO corpSVO);
    void mergePointLimit(POINT_CORPVO pointCorpVO);
    int selectPartnerCodeDuplChk(POINT_CPVO pointCp);
    void updatePointCp(POINT_CPVO pointCp);
    int selectPointCpGroupCnt(String partnerCode);
    String chkPointBuyAble(POINT_CORPVO pointCorpVO);
    List<POINTVO> selectAblePointList(POINTVO pointVO);
    void insertUserPoint(POINTVO pointVO);
    List<POINTVO> selectPointHistoryList(POINTVO pointVO);
    void mergeAllCorpReg(POINT_CORPVO pointCorpVO);
}
