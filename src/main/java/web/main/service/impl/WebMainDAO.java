package web.main.service.impl;

import java.util.List;

import common.Constant;
import org.springframework.stereotype.Repository;

import oss.site.vo.MAINAREAPRDTVO;
import oss.site.vo.MAINCTGRRCMDVO;
import oss.site.vo.MAINHOTPRDTVO;
import oss.user.vo.USERVO;
import web.main.vo.MAINPRDTSVO;
import web.main.vo.MAINPRDTVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


/**
 * <pre>
 * 파일명 : WebMainDAO.java
 * 작성일 : 2015. 12. 17. 오후 9:24:44
 * 작성자 : 최영철
 */
@Repository("webMainDAO")
public class WebMainDAO extends EgovAbstractDAO {

	/**
	 * 당일특가 - 숙박
	 * 파일명 : selectMain01
	 * 작성일 : 2015. 12. 17. 오후 5:21:19
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain01() {
		return (List<MAINPRDTVO>) list("MAIN_S_01", "");
	}

	/**
	 * 패키지 새로운 상품
	 * 파일명 : selectMain02
	 * 작성일 : 2015. 12. 17. 오후 8:30:29
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain02() {
		return (List<MAINPRDTVO>) list("MAIN_S_02", "");
	}

	/**
	 * 패키지 랜덤
	 * 파일명 : selectMain03
	 * 작성일 : 2015. 12. 17. 오후 9:24:49
	 * 작성자 : 최영철
	 * @param mainPrdtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain03(MAINPRDTSVO mainPrdtSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_03", mainPrdtSVO);
	}

	/**
	 * 할인쿠폰 랜덤
	 * 파일명 : selectMain04
	 * 작성일 : 2015. 12. 18. 오전 9:56:37
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain04() {
		return (List<MAINPRDTVO>) list("MAIN_S_04","");
	}

	/**
	 * 렌터카 랜덤
	 * 파일명 : selectMain05
	 * 작성일 : 2015. 12. 18. 오전 10:44:31
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain05() {
		return (List<MAINPRDTVO>) list("MAIN_S_05", "");
	}

	/**
	 * 관광지 입장권 랜덤
	 * 파일명 : selectMain06
	 * 작성일 : 2015. 12. 18. 오전 11:16:51
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain06() {
		return (List<MAINPRDTVO>) list("MAIN_S_06", "");
	}

	/**
	 * 숙박 랜덤
	 * 파일명 : selectMain07
	 * 작성일 : 2015. 12. 18. 오후 4:18:17
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain07() {
		return (List<MAINPRDTVO>) list("MAIN_S_07","");
	}

	/**
	 * 모바일 패키지 랜덤
	 * 파일명 : selectMwMain01
	 * 작성일 : 2015. 12. 22. 오후 2:48:50
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain01() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_01", "");
	}

	/**
	 * 모바일 관광지 + 할인쿠폰
	 * 파일명 : selectMwMain02
	 * 작성일 : 2015. 12. 22. 오후 3:04:26
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain02() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_02", "");
	}

	/**
	 * 모바일 당일예약
	 * 파일명 : selectMwMain03
	 * 작성일 : 2015. 12. 22. 오후 4:35:19
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain03() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_03", "");
	}


	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain10(MAINPRDTSVO mainSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_10", mainSVO);
	}
	/**
	 * 숙박예약랭킹
	 * 파일명 : selectMain11
	 * 작성일 : 2016. 3. 8. 오후 3:28:13
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain11(MAINPRDTSVO mainSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_11", mainSVO);
	}

	/**
	 * 할인렌터카
	 * 파일명 : selectMain12
	 * 작성일 : 2016. 3. 8. 오후 4:40:08
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain12(MAINPRDTSVO mainSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_12", mainSVO);
	}

	/**
	 * 패키지 랜덤 3개
	 * 파일명 : selectMain13
	 * 작성일 : 2016. 3. 8. 오후 5:22:37
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain13(MAINPRDTSVO mainSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_13", mainSVO);
	}

	/**
	 * 관광지 입장권 랜덤 8개
	 * 파일명 : selectMain14
	 * 작성일 : 2016. 3. 8. 오후 6:05:13
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain14(MAINPRDTSVO mainSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_14", mainSVO);
	}

	/**
	 * 레저 랜덤 4개
	 * 파일명 : selectMain15
	 * 작성일 : 2016. 3. 9. 오전 9:54:37
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain15() {
		return (List<MAINPRDTVO>) list("MAIN_S_15", "");
	}

	/**
	 * 음식뷰티기타 랜덤 8개
	 * 파일명 : selectMain16
	 * 작성일 : 2016. 3. 9. 오전 10:17:56
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain16(MAINPRDTSVO mainSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_16", mainSVO);
	}

	/**
	 * 패키지 할인 상품
	 * 파일명 : selectMain17
	 * 작성일 : 2016. 3. 9. 오후 5:33:49
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain17(MAINPRDTSVO mainSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_17", mainSVO);
	}

	/**
	 * 골프패키지
	 * 파일명 : selectMain18
	 * 작성일 : 2016. 3. 10. 오전 10:07:44
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain18() {
		return (List<MAINPRDTVO>) list("MAIN_S_18", "");
	}

	/**
	 * 버스관광
	 * 파일명 : selectMain19
	 * 작성일 : 2016. 3. 10. 오전 10:09:18
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain19() {
		return (List<MAINPRDTVO>) list("MAIN_S_19", "");
	}

	/**
	 * 모바일 메인 숙박 랜덤
	 * 파일명 : selectMwMain04
	 * 작성일 : 2016. 6. 17. 오전 10:59:47
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain04() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_04", "");
	}

	/**
	 * 모바일 메인 렌터카 조회
	 * 파일명 : selectMwMain05
	 * 작성일 : 2016. 6. 17. 오전 11:42:09
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain05() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_05", "");
	}

	/**
	 * 모바일 메인 음식 조회
	 * 파일명 : selectMwMain06
	 * 작성일 : 2016. 6. 17. 오후 1:54:46
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain06() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_06", "");
	}

	/**
	 * 모바일 메인 뷰티 조회
	 * 파일명 : selectMwMain07
	 * 작성일 : 2016. 6. 17. 오후 2:01:30
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain07() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_07", "");
	}

	/**
	 * 모바일 메인 관광지/레저
	 * 파일명 : selectMwMain08
	 * 작성일 : 2016. 9. 5. 오후 4:05:24
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain08() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_08", "");
	}

	/**
	 * 렌터카 메인 조회
	 * 파일명 : selectMain20
	 * 작성일 : 2016. 10. 18. 오전 10:46:27
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain20(MAINPRDTSVO mainSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_20", mainSVO);
	}

	/**
	 * 관광기념품 메인 조회
	 * 파일명 : selectMain21
	 * 작성일 : 2016. 10. 18. 오후 2:03:48
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain21(MAINPRDTSVO mainSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_21", mainSVO);
	}

	/**
	 * 모바일 숙박 추천순
	 * 파일명 : selectMwMain09
	 * 작성일 : 2016. 10. 19. 오전 10:47:41
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain09() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_09", "");
	}
	
	/**
	 * 모바일 렌터카 추천순
	 * 파일명 : selectMwMain10
	 * 작성일 : 2016. 10. 19. 오전 10:48:34
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain10() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_10", "");
	}

	/**
	 * 관광지/레저 추천순
	 * 파일명 : selectMwMain11
	 * 작성일 : 2016. 10. 19. 오전 11:57:11
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain11() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_11", "");
	}

	/**
	 * 음식/뷰티 추천순
	 * 파일명 : selectMwMain12
	 * 작성일 : 2016. 10. 19. 오후 2:19:53
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain12() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_12", "");
	}

	/**
	 * 패키지 추천순
	 * 파일명 : selectMwMain13
	 * 작성일 : 2016. 10. 19. 오후 2:26:35
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain13() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_13", "");
	}
	
	/**
	 * 특가전 상품 리스트
	 * Function : selectMwMain14
	 * 작성일 : 2017. 12. 14. 오후 2:35:20
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMwMain14() {
		return (List<MAINPRDTVO>) list("MW_MAIN_S_14", "");
	}

	/**
	 * 관광기념품
	 * 파일명 : selectMain22
	 * 작성일 : 2016. 10. 26. 오전 10:56:05
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain22(MAINPRDTSVO mainSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_22", mainSVO);
	}

	/**
	 * '인기있수다' 선택 상품 리스트
	 * Function : selectMainHotList
	 * 작성일 : 2017. 11. 23. 오후 2:01:50
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINHOTPRDTVO> selectMainHotList() {
		return (List<MAINHOTPRDTVO>) list("MAIN_S_23");
	}
	
	/**
	 * '인기있수다'의 판매순 상품 리스트
	 * Function : selectMainRsvList
	 * 작성일 : 2017. 11. 23. 오후 2:04:57
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINHOTPRDTVO> selectMainRsvList() {
		return (List<MAINHOTPRDTVO>) list("MAIN_S_24");
	}
	
	/**
	 * '즐거움 폭발' 상품 리스트
	 * Function : selectMainUrlList
	 * 작성일 : 2017. 11. 23. 오후 2:02:07
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINHOTPRDTVO> selectMainUrlList() {
		return (List<MAINHOTPRDTVO>) list("MAIN_S_25");
	}
	
	/**
	 * 지역별 핫 플레이스 상품 리스트
	 * Function : selectMainAreaList
	 * 작성일 : 2017. 11. 23. 오후 2:02:22
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINAREAPRDTVO> selectMainAreaList() {
		return (List<MAINAREAPRDTVO>) list("MAIN_S_26");
	}
	
	/**
	 * 카테고리별 추천 상품 리스트
	 * Function : selectMainCtgrRcmdList
	 * 작성일 : 2018. 1. 5. 오후 3:28:46
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINCTGRRCMDVO> selectMainCtgrRcmdList() {
		return (List<MAINCTGRRCMDVO>) list("MAIN_S_27");
	}
	
	/**
	 * 방문예정 메일의 추천상품 리스트
	 * Function : selectPrevMailCtgrRcmdList
	 * 작성일 : 2018. 3. 9. 오전 9:14:07
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINCTGRRCMDVO> selectPrevMailCtgrRcmdList() {
		return (List<MAINCTGRRCMDVO>) list("MAIN_S_28");
	}


	/**
	 * 카테고리 추천 상품 리스트
	 */
	@SuppressWarnings("unchecked")
	public List<MAINCTGRRCMDVO> selectMainCtgrRcmdList(MAINCTGRRCMDVO mainctgrrcmdVO) {
		String prdtDiv = mainctgrrcmdVO.getPrdtDiv();

		if(Constant.ACCOMMODATION.equals(prdtDiv)) {
			return (List<MAINCTGRRCMDVO>) list("MAIN_S_29");		// 숙박
		} else if(Constant.RENTCAR.equals(prdtDiv)) {
			return (List<MAINCTGRRCMDVO>) list("MAIN_S_30");
		} else if(Constant.SV.equals(prdtDiv)) {
			return (List<MAINCTGRRCMDVO>) list("MAIN_S_32");
		} else {
			return (List<MAINCTGRRCMDVO>) list("MAIN_S_31", mainctgrrcmdVO);
		}
	}


	/**
	 * 카테고리 추천 제외 소셜상품 랭킹 리스트
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRDTVO> selectMain33(MAINPRDTSVO mainSVO) {
		return (List<MAINPRDTVO>) list("MAIN_S_33", mainSVO);
	}

	public List<MAINPRDTVO> selectBestAd() {
		return (List<MAINPRDTVO>) list("BEST_AD_S_01");
	}


	@SuppressWarnings("unchecked")
	public void insertTamnaoPartner(USERVO userVO){
		insert("TAMNAO_PARTNER_I_01" , userVO);
	}

	@SuppressWarnings("unchecked")
	public List<USERVO> selectTamnaoPartners(USERVO userVO){
		return (List<USERVO>) list("TAMNAO_PARTNER_S_01" , userVO);
	}

	@SuppressWarnings("unchecked")
	public int selectTamnaoPartnersCnt(USERVO userVO){
		return (int) select("TAMNAO_PARTNER_S_02" , userVO);
	}

	@SuppressWarnings("unchecked")
	public USERVO selectTamnaoPartner(USERVO userVO){
		return (USERVO) select("TAMNAO_PARTNER_S_03" , userVO);
	}

	@SuppressWarnings("unchecked")
	public void updateTamnaoPartner(USERVO userVO){
		update("TAMNAO_PARTNER_U_01" , userVO);
	}

	@SuppressWarnings("unchecked")
	public void updateTamnaoPartnerAccessCnt(USERVO userVO){
		update("TAMNAO_PARTNER_U_02" , userVO);
	}

	@SuppressWarnings("unchecked")
	public void deleteTamnaoPartner(USERVO userVO){
		delete("TAMNAO_PARTNER_D_01" , userVO);
	}

	public List<MAINCTGRRCMDVO> selectSixIntroCtgrRcmdList(MAINCTGRRCMDVO mainctgrrcmdVO) {
		return (List<MAINCTGRRCMDVO>) list("MAIN_S_34");
	}
	
	@SuppressWarnings("unchecked")
	public List<USERVO> partnerAnls(USERVO userVO){
		return (List<USERVO>) list("TAMNAO_PARTNER_S_04" , userVO);
	}
}
