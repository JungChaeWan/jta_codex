package egovframework.cmmn.service.impl;

import api.vo.NAVERVO;
import common.LowerHashMap;
import egovframework.cmmn.vo.KMAGRIBVO;
import egovframework.cmmn.vo.KMAMLWVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import mas.rc.vo.RC_PRDTINFSVO;
import org.springframework.stereotype.Repository;
import oss.adj.vo.ADJSVO;
import oss.adj.vo.ADJVO;
import web.order.vo.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import static common.Constant.WAITING_TIME;


@Repository("scheduleDAO")
public class ScheduleDAO extends EgovAbstractDAO {

	public int waitingTime = WAITING_TIME;
	/**
	 * 렌터카 미결제건 자동취소 처리
	 * 파일명 : updateRc01
	 * 작성일 : 2015. 12. 24. 오후 3:05:44
	 * 작성자 : 최영철
	 */
	public void updateRcAutoCancel(RC_RSVVO rsvVO) {
		update("RC_RSV_U_03", rsvVO);
	}

	/**
	 * 사용자 쿠폰 반환 처리
	 * 파일명 : returnUserCp
	 * 작성일 : 2015. 12. 24. 오후 3:18:44
	 * 작성자 : 최영철
	 */
	public void returnUserCp() {
		update("USER_CP_U_02", waitingTime);
	}

	/**
	 * 숙박 자동 취소건 리스트 조회
	 * 파일명 : selectAutoCancelList
	 * 작성일 : 2015. 12. 24. 오후 5:56:21
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_RSVVO> selectAdAutoCancelList() {
		return (List<AD_RSVVO>) list("AD_RSV_S_04", waitingTime);
	}
	
	/**
	 * 렌터카 자동 취소건 리스트 조회
	 * 파일명 : selectRcAutoCancelList
	 * 작성일 : 2015. 12. 24. 오후 5:59:29
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<RC_RSVVO> selectRcAutoCancelList() {
		return (List<RC_RSVVO>) list("RC_RSV_S_04", waitingTime);
	}

	/**
	 * 예약불가건 자동 삭제
	 * 파일명 : deleteNotRsv
	 * 작성일 : 2015. 12. 24. 오후 6:04:12
	 * 작성자 : 최영철
	 */
	public void deleteNotRsv() {
		delete("RC_RSV_D_02", waitingTime);
		delete("AD_RSV_D_02", waitingTime);
		delete("SP_RSV_D_02", waitingTime);
	}

	/**
	 * 숙박 미결제건 자동취소 처리
	 * 파일명 : updateAdAutoCancel
	 * 작성일 : 2015. 12. 24. 오후 6:16:40
	 * 작성자 : 최영철
	 * @param rsvVO
	 */
	public void updateAdAutoCancel(AD_RSVVO rsvVO) {
		update("AD_RSV_U_03", rsvVO);
	}

	/**
	 * 소셜상품 자동 취소건 리스트 조회
	 * 파일명 : selectSpAutoCancelList
	 * 작성일 : 2015. 12. 24. 오후 6:19:40
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SP_RSVVO> selectSpAutoCancelList() {
		return (List<SP_RSVVO>) list("SP_RSV_S_04", waitingTime);
	}

	/**
	 * 소셜상품 미결제건 자동취소 처리
	 * 파일명 : updateSpAutoCancel
	 * 작성일 : 2015. 12. 24. 오후 6:20:47
	 * 작성자 : 최영철
	 * @param rsvVO
	 */
	public void updateSpAutoCancel(SP_RSVVO rsvVO) {
		update("SP_RSV_U_05", rsvVO);
	}

	/**
	 * 예약테이블 자동 취소 처리
	 * 파일명 : updateAutoCancel
	 * 작성일 : 2015. 12. 24. 오후 6:34:18
	 * 작성자 : 최영철
	 */
	public void updateAutoCancel() {
		update("RSV_U_06", waitingTime);
	}

	/**
	 * 소셜상품 사용완료 처리
	 * 파일명 : useCompleteSp
	 * 작성일 : 2015. 12. 26. 오후 3:45:57
	 * 작성자 : 최영철
	 */
	public void useCompleteSp() {
		update("SP_RSV_U_06", "");
	}

	/**
	 * 렌터카 사용완료 처리
	 * 파일명 : useCompleteRc
	 * 작성일 : 2015. 12. 26. 오후 3:50:54
	 * 작성자 : 최영철
	 */
	public void useCompleteRc() {
		update("RC_RSV_U_04", "");
	}

	/**
	 * 숙박 사용완료 처리
	 * 파일명 : useCompleteAd
	 * 작성일 : 2015. 12. 26. 오후 4:03:29
	 * 작성자 : 최영철
	 */
	public void useCompleteAd() {
		update("AD_RSV_U_04", "");
	}

	/**
	 * 소셜상품 기간만료 처리
	 * 파일명 : exprCompleteSp
	 * 작성일 : 2015. 12. 26. 오후 4:06:57
	 * 작성자 : 최영철
	 */
	public void exprCompleteSp() {
		update("SP_RSV_U_07", "");
	}

	/**
	 * 정산일자 구하기
	 * 파일명 : getAdjDt
	 * 작성일 : 2016. 1. 8. 오후 2:42:07
	 * 작성자 : 최영철
	 * @return
	 */
	public String getAdjDt() {
		return (String) select("ADJ_S_01", "");
	}

	/**
	 * 정산일자에 대한 정산 리스트 조회
	 * 파일명 : selectAdjList
	 * 작성일 : 2016. 1. 8. 오후 3:17:24
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADJVO> selectAdjList(ADJSVO adjSVO) {
		return (List<ADJVO>) list("ADJ_S_00", adjSVO);
	}

	/**
	 * 정산일자에 대한 정산대상 예약건 추출
	 * 파일명 : insertAdjDtlList
	 * 작성일 : 2016. 1. 8. 오후 4:21:14
	 * 작성자 : 최영철
	 * @param adjSVO
	 */
	public void insertAdjDtlList(ADJSVO adjSVO) {
		insert("ADJDTLINF_I_01", adjSVO);
	}

	public void insertAdjDtlListCityTour(ADJSVO adjSVO) {
		insert("ADJDTLINF_I_02", adjSVO);
	}

	/**
	 * 정산 마스터 데이터 추출
	 * 파일명 : insertAdj
	 * 작성일 : 2016. 1. 8. 오후 4:39:51
	 * 작성자 : 최영철
	 * @param adjSVO
	 */
	public void insertAdj(ADJSVO adjSVO) {
		insert("ADJ_I_01", adjSVO);
	}

	/**
	 * 숙박예약건 정산여부, 정산일자 업데이트
	 * 파일명 : updateAdAdj
	 * 작성일 : 2016. 1. 8. 오후 4:51:03
	 * 작성자 : 최영철
	 * @param adjSVO
	 */
	public void updateAdAdj(ADJSVO adjSVO) {
		update("AD_RSV_U_05", adjSVO);
	}

	/**
	 * 렌터카 예약건 정산여부, 정산일자 업데이트
	 * 파일명 : updateRcAdj
	 * 작성일 : 2016. 1. 8. 오후 4:55:07
	 * 작성자 : 최영철
	 * @param adjSVO
	 */
	public void updateRcAdj(ADJSVO adjSVO) {
		update("RC_RSV_U_05", adjSVO);
	}

	/**
	 * 소셜상품 예약건 정산여부, 정산일자 업데이트
	 * 파일명 : updateSpAdj
	 * 작성일 : 2016. 1. 8. 오후 6:32:14
	 * 작성자 : 최영철
	 * @param adjSVO
	 */
	public void updateSpAdj(ADJSVO adjSVO) {
		update("SP_RSV_U_08", adjSVO);
	}

	/**
	 * 관광기념품 자동취소건 조회
	 * 파일명 : selectSvAutoCancelList
	 * 작성일 : 2016. 10. 17. 오후 1:46:40
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SV_RSVVO> selectSvAutoCancelList() {
		return (List<SV_RSVVO>) list("SV_RSV_S_04", waitingTime);
	}

	/**
	 * 관광기념품 미결제건 자동취소처리
	 * 파일명 : updateSvAutoCancel
	 * 작성일 : 2016. 10. 17. 오후 1:48:55
	 * 작성자 : 최영철
	 * @param rsvVO
	 */
	public void updateSvAutoCancel(SV_RSVVO rsvVO) {
		update("SV_RSV_U_05", rsvVO);		
	}

	/**
	 * 관광기념품 자동 구매확정 처리
	 * 파일명 : useCompleteSv
	 * 작성일 : 2016. 10. 17. 오후 2:02:13
	 * 작성자 : 최영철
	 */
	public void useCompleteSv() {
		update("SV_RSV_U_06", "");
	}

	/**
	 * 관광기념품 예약건 정산여부, 정산일자 업데이트
	 * 파일명 : updateSvAdj
	 * 작성일 : 2016. 10. 17. 오후 3:05:15
	 * 작성자 : 최영철
	 * @param adjSVO
	 */
	public void updateSvAdj(ADJSVO adjSVO) {
		update("SV_RSV_U_08", adjSVO);
	}

	/**
	 * 기상청실황
	 * 파일명 : selectKmaGribList
	 * 작성일 : 2016. 11. 17. 오전 11:21:17
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<KMAGRIBVO> selectKmaGribList() {
		return (List<KMAGRIBVO>) list("KMAGRIB_S_00", "");
	}

	/**
	 * 기상청실황 업데이트
	 * 파일명 : updateKmaGrib
	 * 작성일 : 2016. 11. 17. 오후 2:21:16
	 * 작성자 : 최영철
	 * @param newKmaVO
	 */
	public void updateKmaGrib(KMAGRIBVO newKmaVO) {
		update("KMAGRIB_U_00", newKmaVO);
	}

	/**
	 * 기상청 중기예보 등록
	 * 파일명 : insertKmaMlw
	 * 작성일 : 2016. 11. 18. 오후 2:39:40
	 * 작성자 : 최영철
	 * @param mlwVO
	 */
	public void insertKmaMlw(KMAMLWVO mlwVO) {
		insert("KMAMLW_I_00", mlwVO);
	}

	/**
	 * 기사청 중기예보 해당날짜 데이터 삭제
	 * 파일명 : deleteKmaMlw
	 * 작성일 : 2016. 11. 18. 오후 2:41:09
	 * 작성자 : 최영철
	 * @param mlwVO
	 */
	public void deleteKmaMlw(KMAMLWVO mlwVO) {
		delete("KMAMLW_D_00", mlwVO);
	}

	public void insertKmaMlw(String baseDt, String timeDiv, String wfNm, String taMax, String taMin) {
		KMAMLWVO mlwVO = new KMAMLWVO();
		mlwVO.setBaseDt(baseDt);
 	    mlwVO.setTimeDiv(timeDiv);
 	    mlwVO.setWfNm(wfNm);
 	    mlwVO.setTaMax(taMax);
 	    mlwVO.setTaMin(taMin);
 	    
 	   insertKmaMlw(mlwVO);
	}

	/**
	 * 중기예보 날씨
	 * 파일명 : selectKmaMlwWfList
	 * 작성일 : 2016. 11. 22. 오전 10:19:09
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<KMAMLWVO> selectKmaMlwWfList() {
		return (List<KMAMLWVO>) list("KMAMLW_S_01", "");
	}

	/**
	 * 중기예보 온도
	 * 파일명 : selectKmaMlwTaList
	 * 작성일 : 2016. 11. 22. 오전 10:23:48
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<KMAMLWVO> selectKmaMlwTaList() {
		return (List<KMAMLWVO>) list("KMAMLW_S_02", "");
	}

	/**
	 * 입점업체 현황
	 * 파일명 : corpAnls
	 * 작성일 : 2017. 2. 13. 오후 2:53:37
	 * 작성자 : 최영철
	 */
	public void corpAnls() {
		insert("CORP_ANLS_I_00", "");
		
		//상품통계 생성에러 확인 및 미사용 처리 2023.11.09
		//insert("PRDT_ANLS_I_00", "");
	}
		
	/**
	 * 업체 지수 일별 등록
	 * 파일명 : updateCorpLevel
	 * 작성일 : 2017. 9. 29. 오후 3:29:28
	 * 작성자 : 정동수
	 */
	public void updateCorpLevel() {
		update("CORP_LEVEL_M_00");
	}

	public void updateSVBuyFix() {
		update("SV_RSV_U_16");
	}

	public void insertTamnacardAdj(){
		insert("ADJ_I_02", "");
	}

	public Integer checkPointErrAlarm() {
		return (Integer) select("POINT_CP_S_17");
	}

	public List<LowerHashMap> event1Userlist() { return (List<LowerHashMap>) list("USER_S_24");}


    /**
     * 설명 : 7일전 사용완료된 사용자 중 7일 이내 발송 이력이 없는 사용자
     * 파일명 : selectKakaoSendAfter7Days
     * 작성일 : 25. 4. 7. 오후 3:36
     * 작성자 : chaewan.jung
     *
     * @param :
     * @return :
     * @throws Exception
     */
    List<Map<String, Object>> selectKakaoSendAfter7Days() {
        return (List<Map<String, Object>>) list("KAKAO_S_01");
    }

	/**
	* 설명 :알림톡 유효기간(숙박, 렌트카) 알림 7일 전 발송
	* 파일명 : kakaoSendRcAdBefore7Days
	* 작성일 : 25. 4. 8. 오후 4:21
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	List<Map<String, Object>> kakaoSendRcAdBefore7Days() {
		return (List<Map<String, Object>>) list("KAKAO_S_02");
	}

	/**
	* 설명 : 알림톡 유효기간(관광지, 맛집) 알림 3일 전 발송
	* 파일명 : kakaoSendSpBefore3Days
	* 작성일 : 25. 4. 9. 오후 3:40
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	List<Map<String, Object>> kakaoSendSpBefore3Days() {
		return (List<Map<String, Object>>) list("KAKAO_S_03");
	}

	public void insertKakaoConfirmAfterLog(Map<String, Object> user) {
		insert("KAKAO_I_01", user);
	}
}
