package oss.point.service.impl;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import oss.corp.vo.CORPSVO;
import oss.corp.vo.CORPVO;
import oss.point.service.OssPointService;
import oss.point.vo.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("ossPointService")
public class OssPointServiceImpl extends EgovAbstractServiceImpl implements OssPointService{
    @Autowired
    private OssPointDAO ossPointDAO;

    public void insertPointCpNum(POINT_CPNUMVO pointCpnumVO) {
        ossPointDAO.insertPointCpNum(pointCpnumVO);
    }

    public void insertPointCp(POINT_CPVO pointCp) {
        ossPointDAO.insertPointCp(pointCp);
    }

    public Map<String, Object> selectPointCpList(POINT_CPSVO cpListSVO) {
        Map<String, Object> resultMap = new HashMap<>();
        List<POINT_CPVO> resultList = ossPointDAO.selectPointCpList(cpListSVO);
        Integer totalCnt = ossPointDAO.getCntCpList(cpListSVO);

        resultMap.put("resultList", resultList);
        resultMap.put("totalCnt", totalCnt);

        return resultMap;
    }

    @Override
    public Map<String, Object> selectPointCpPublishingList(POINT_CPNUMVO cpPublishingVO) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<POINT_CPNUMVO> resultList = ossPointDAO.selectPointCpPublishingList(cpPublishingVO);
        Integer totalCnt = ossPointDAO.getCntCpPublishingList(cpPublishingVO);
        resultMap.put("resultList", resultList);
        resultMap.put("totalCnt", totalCnt);
        return resultMap;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void pointCpReg(POINTVO pointVO) throws RuntimeException{
        //쿠폰등록처리
        ossPointDAO.updatePointCpUseProcess(pointVO);
        //포인트적립처리
        ossPointDAO.insertPointCpSave(pointVO);
    }

    /**
    * 설명 : 포인트 사용처리
    * 파일명 : pointCpUse
    * 작성일 : 2022-11-23 오후 5:01
    * 작성자 : chaewan.jung
    * @param : [pointVO, rsvVO]
    * @return : void
    * @throws Exception
    */
    @Override
    public void pointCpUse(POINTVO pointVO) {
        //포인트 사용처리 LIST
        List<POINT_CP_RSVVO> rsvCpList = selectRsvPointCp(pointVO);

        long usePoint = pointVO.getPoint();
        long calPoint;
        int totUsePoint =0;
        for (int i = 0; i < rsvCpList.size(); i++) {
            pointVO.setRsvNum(rsvCpList.get(i).getRsvNum());
            pointVO.setDtlRsvNum(rsvCpList.get(i).getDtlRsvNum());
            pointVO.setPayAmt(rsvCpList.get(i).getSaleAmt());
            pointVO.setCorpId(rsvCpList.get(i).getCorpId());

            if ("ALL_POINT".equals(pointVO.getContents())){ //포인트로 전체 사용 시
                pointVO.setPoint(rsvCpList.get(i).getSaleAmt());
            } else{ //복합 결제 시

                //포인트 계산을 위한 조건
                if (i < rsvCpList.size() - 1) {
                    //첫행~마지막 전 행(A) : 사용포인트 * 개별상품결제금액/총상품결제금액 후 1의 자리 반올림
                    calPoint = usePoint * rsvCpList.get(i).getSaleAmt() / pointVO.getTotalSaleAmt();
                    calPoint = (int) (Math.round(calPoint / 10.0) * 10);

                    pointVO.setPoint((int) calPoint);
                    totUsePoint += calPoint;
                } else {
                    //마지막 행 : 사용포인트 - A
                    pointVO.setPoint((int) (usePoint - totUsePoint));
                }
            }
            ossPointDAO.insertPointCpSave(pointVO);
        }
    }

    @Override
    public String chkPointCpRegAble(POINTVO pointVO) {
        return ossPointDAO.chkPointCpRegAble(pointVO);
    }

    @Override
    public POINTVO selectAblePoint(POINTVO pointVO) {
        return ossPointDAO.selectAblePoint(pointVO);
    }

    @Override
    public POINT_CPVO selectPointCpDetail(String ssPartnerCode) {
        return ossPointDAO.selectPointCpDetail(ssPartnerCode);
    }

    /**
     * 설명 : 구매상품별로 사용 포인트 분할을 위함.
     * 파일명 : selectRsvPointCp
     * 작성일 : 2022-11-23 오전 10:45
     * 작성자 : chaewan.jung
     * @param : [rsvVO]
     * @return : java.util.List<oss.point.vo.POINT_CP_RSVVO>
     * @throws Exception
     */
    @Override
    public List<POINT_CP_RSVVO> selectRsvPointCp(POINTVO pointVO) {
        return ossPointDAO.selectRsvPointCp(pointVO);
    }

    /**
    * 설명 : 취소처리를 위한 사용포인트 확인
    * 파일명 : selectUsePoint
    * 작성일 : 2022-12-07 오후 2:37
    * 작성자 : chaewan.jung
    * @param : [pointVO]
    * @return : int
    * @throws Exception
    */
    @Override
    public POINTVO selectUsePoint(POINTVO pointVO) {
        return ossPointDAO.selectUsePoint(pointVO);
    }

    @Override
    public void insertPointCpSave(POINTVO pointVO) {
        ossPointDAO.insertPointCpSave(pointVO);
    }

    /**
     * 설명 : 파트너관리자 - 업체관리 - 판매업체 등록
     * 파일명 : mergePointCorp
     * 작성일 : 2022-12-27 오후 4:41
     * 작성자 : chaewan.jung
     * @param : [pointCorpVO]
     * @return : void
     * @throws Exception
     */
    @Override
    public void mergePointCorp(POINT_CORPVO pointCorpVO) {
        ossPointDAO.mergePointCorp(pointCorpVO);
    }

    /**
    * 설명 : 파트너관리자 - 업체관리 리스트
    * 파일명 : selectPointCorpList
    * 작성일 : 2022-12-27 오후 1:57
    * 작성자 : chaewan.jung
    * @param : [corpSVO]
    * @return : java.util.Map<java.lang.String,java.lang.Object>
    * @throws Exception
    */
    @Override
    public Map<String, Object> selectPointCorpList(CORPSVO corpSVO){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        List<CORPVO> resultList = ossPointDAO.selectPointCorpList(corpSVO);
        Integer totalCnt = ossPointDAO.getCntPointCorpList(corpSVO);

        resultMap.put("resultList", resultList);
        resultMap.put("totalCnt", totalCnt);

        return resultMap;
    }

    /**
     * 설명 : 파트너관리자 - 업체관리 - 한도 Point 셋팅
     * 파일명 : updatePointLimit
     * 작성일 : 2022-12-27 오후 4:41
     * 작성자 : chaewan.jung
     * @param : [pointCorpVO]
     * @return : void
     * @throws Exception
     */
    @Override
    public void mergePointLimit(POINT_CORPVO pointCorpVO) {
        ossPointDAO.mergePointLimit(pointCorpVO);
    }

    /**
    * 설명 : 쿠폰 등록 시 파트너코드 중복체크
    * 파일명 : selectPartnerCodeDuplChk
    * 작성일 : 2022-12-28 오후 4:31
    * 작성자 : chaewan.jung
    * @param : [pointCp]
    * @return : void
    * @throws Exception
    */
    @Override
    public int selectPartnerCodeDuplChk(POINT_CPVO pointCp) {
        return ossPointDAO.selectPartnerCodeDuplChk(pointCp);
    }

    @Override
    public void updatePointCp(POINT_CPVO pointCp) {
        ossPointDAO.updatePointCp(pointCp);
    }

    /**
     * 설명 : 쿠폰 발급 시 쿠폰그룹 개수 get
     * 파일명 : selectPointCpGroupCnt
     * 작성일 : 2023-01-03 오후 2:48
     * 작성자 : chaewan.jung
     * @param : [partnerCode]
     * @return : int
     * @throws Exception
     */
    @Override
    public int selectPointCpGroupCnt(String partnerCode) {
       return ossPointDAO.selectPointCpGroupCnt(partnerCode);
    }

    /**
    * 설명 : 구매 가능 여부 체크 (Y:구매가능  / N: 구매불가)
    * 파일명 : chkPointBuyAble
    * 작성일 : 2023-01-04 오후 2:43
    * 작성자 : chaewan.jung
    * @param : [pointCorpVO]
    * @return : java.lang.String
    * @throws Exception
    */
    @Override
    public String chkPointBuyAble(POINT_CORPVO pointCorpVO) {
        String chkPointBuyAble = "Y";
        if (!"".equals(pointCorpVO.getPartnerCode())){
            //필터 대상 조회
            POINT_CPVO pointCpVO = selectPointCpDetail(pointCorpVO.getPartnerCode());
            if (pointCpVO != null) {

                // 쿠폰사용기간 체크
                LocalDate today = LocalDate.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
                LocalDate aplStartDt = LocalDate.parse(pointCpVO.getAplStartDt(), formatter);
                LocalDate aplEndDt = LocalDate.parse(pointCpVO.getAplEndDt(), formatter);
                if (today.isBefore(aplStartDt) || today.isAfter(aplEndDt)) {
                    return "N";
                }

                // 업체제한 체크
                if ("Y".equals(pointCpVO.getCorpFilterYn()) && "N".equals(chkPointBuyAbleCorp(pointCorpVO))) {
                    return "N";
                }

                // 업체별 포인트 사용한도설정 체크
                if ("Y".equals(pointCpVO.getCorpPointLimitYn()) && "N".equals(chkPointBuyAblePnt(pointCorpVO))) {
                    return "N";
                }

                // 예산액 체크
                if (pointCpVO.getPartnerBudget() != 0 && "N".equals(chkBudgetAblePnt(pointCorpVO))) {
                    return "N";
                }
            }
        }
        return chkPointBuyAble;
    }

    @Override
    public List<POINTVO> selectAblePointList(POINTVO pointVO) {
        return ossPointDAO.selectAblePointList(pointVO);
    }

    @Override
    public void insertUserPoint(POINTVO pointVO) {
        ossPointDAO.insertUserPoint(pointVO);
    }

    /**
    * 설명 : 포인트 발급/사용 이력
    * 파일명 : selectPointHistoryList
    * 작성일 : 2023-02-13 오후 5:01
    * 작성자 : chaewan.jung
    * @param : [pointVO]
    * @return : java.util.List<oss.point.vo.POINTVO>
    * @throws Exception
    */
    @Override
    public List<POINTVO> selectPointHistoryList(POINTVO pointVO) {
        return ossPointDAO.selectPointHistoryList(pointVO);
    }

    @Override
    public void mergeAllCorpReg(POINT_CORPVO pointCorpVO) {
        ossPointDAO.delAllCorpReg(pointCorpVO);
        ossPointDAO.insertAllCorpReg(pointCorpVO);
    }

    public String chkPointBuyAbleCorp(POINT_CORPVO pointCorpVO) {
        return ossPointDAO.chkPointBuyAbleCorp(pointCorpVO);
    }

    public String chkPointBuyAblePnt(POINT_CORPVO pointCorpVO) {
        return ossPointDAO.chkPointBuyAblePnt(pointCorpVO);
    }

    public String chkBudgetAblePnt(POINT_CORPVO pointCorpVO){
        return ossPointDAO.chkBudgetAblePnt(pointCorpVO);
    }
}
