package web.main.service;

import java.util.List;
import java.util.Map;

import oss.site.vo.MAINAREAPRDTVO;
import oss.site.vo.MAINCTGRRCMDVO;
import oss.site.vo.MAINHOTPRDTVO;
import oss.user.vo.USERVO;
import web.main.vo.MAINPRDTSVO;
import web.main.vo.MAINPRDTVO;
import web.product.vo.CARTVO;

public interface WebMainService {

	List<CARTVO> prdtAbleChk(List<CARTVO> cartList);

	/**
	 * 당일특가 - 숙박
	 * 파일명 : selectMain01
	 * 작성일 : 2015. 12. 17. 오후 5:19:28
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMain01();

	/**
	 * 패키지 새로운 상품
	 * 파일명 : selectMain02
	 * 작성일 : 2015. 12. 17. 오후 8:29:36
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMain02();

	/**
	 * 패키지 랜덤
	 * 파일명 : selectMain03
	 * 작성일 : 2015. 12. 17. 오후 9:23:32
	 * 작성자 : 최영철
	 * @param mainPrdtSVO
	 * @return
	 */
	List<MAINPRDTVO> selectMain03(MAINPRDTSVO mainPrdtSVO);

	/**
	 * 할인쿠폰
	 * 파일명 : selectMain04
	 * 작성일 : 2015. 12. 18. 오전 9:55:41
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMain04();

	/**
	 * 랜터카 랜덤
	 * 파일명 : selectMain05
	 * 작성일 : 2015. 12. 18. 오전 10:43:47
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMain05();

	/**
	 * 관광지 입장권
	 * 파일명 : selectMain06
	 * 작성일 : 2015. 12. 18. 오전 11:15:28
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMain06();

	/**
	 * 숙박 랜덤
	 * 파일명 : selectMain07
	 * 작성일 : 2015. 12. 18. 오후 4:17:24
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMain07();

	/**
	 * 모바일 패키지 랜덤
	 * 파일명 : selectMwMain01
	 * 작성일 : 2015. 12. 22. 오후 2:48:13
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain01();

	/**
	 * 모바일 관광지 + 할인쿠폰
	 * 파일명 : selectMwMain02
	 * 작성일 : 2015. 12. 22. 오후 3:03:47
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain02();

	/**
	 * 모바일 당일예약
	 * 파일명 : selectMwMain03
	 * 작성일 : 2015. 12. 22. 오후 4:34:19
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain03();

	List<MAINPRDTVO> selectMain10(MAINPRDTSVO mainSVO);
	/**
	 * 숙박예약랭킹
	 * 파일명 : selectMain11
	 * 작성일 : 2016. 3. 8. 오후 3:27:18
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	List<MAINPRDTVO> selectMain11(MAINPRDTSVO mainSVO);

	/**
	 * 할인 렌터카
	 * 파일명 : selectMain12
	 * 작성일 : 2016. 3. 8. 오후 4:39:32
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	List<MAINPRDTVO> selectMain12(MAINPRDTSVO mainSVO);

	/**
	 * 패키지 랜덤 3개
	 * 파일명 : selectMain13
	 * 작성일 : 2016. 3. 8. 오후 5:21:49
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	List<MAINPRDTVO> selectMain13(MAINPRDTSVO mainSVO);

	/**
	 * 관광지 입장권 랜덤 4개
	 * 파일명 : selectMain14
	 * 작성일 : 2016. 3. 8. 오후 6:04:26
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMain14(MAINPRDTSVO mainSVO);

	/**
	 * 레저 랜덤 4개
	 * 파일명 : selectMain15
	 * 작성일 : 2016. 3. 9. 오전 9:53:46
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMain15();

	/**
	 * 음식뷰티기타 8개
	 * 파일명 : selectMain16
	 * 작성일 : 2016. 3. 9. 오전 10:06:44
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMain16(MAINPRDTSVO mainSVO);

	/**
	 * 항공패키지
	 * 파일명 : selectMain17
	 * 작성일 : 2016. 3. 9. 오후 5:33:01
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	List<MAINPRDTVO> selectMain17(MAINPRDTSVO mainSVO);

	/**
	 * 골프패키지
	 * 파일명 : selectMain18
	 * 작성일 : 2016. 3. 10. 오전 10:06:54
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMain18();

	/**
	 * 버스관광
	 * 파일명 : selectMain19
	 * 작성일 : 2016. 3. 10. 오전 10:08:37
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMain19();

	/**
	 * 모바일 메인 추천 숙소
	 * 파일명 : selectMwMain04
	 * 작성일 : 2016. 6. 17. 오전 10:58:54
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain04();

	/**
	 * 모바일 메인 렌터카
	 * 파일명 : selectMwMain05
	 * 작성일 : 2016. 6. 17. 오전 11:40:02
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain05();

	/**
	 * 모바일 메인 음식 조회
	 * 파일명 : selectMwMain06
	 * 작성일 : 2016. 6. 17. 오후 1:53:56
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain06();

	/**
	 * 모바일 메인 뷰티 조회
	 * 파일명 : selectMwMain07
	 * 작성일 : 2016. 6. 17. 오후 2:00:57
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain07();

	/**
	 * 모바일 관광지/레져
	 * 파일명 : selectMwMain08
	 * 작성일 : 2016. 9. 5. 오후 4:04:43
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain08();

	/**
	 * 렌터카 메인 조회
	 * 파일명 : selectMain20
	 * 작성일 : 2016. 10. 18. 오전 10:45:39
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	List<MAINPRDTVO> selectMain20(MAINPRDTSVO mainSVO);

	/**
	 * 관광기념품 메인 조회
	 * 파일명 : selectMain21
	 * 작성일 : 2016. 10. 18. 오후 2:03:03
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	List<MAINPRDTVO> selectMain21(MAINPRDTSVO mainSVO);

	/**
	 * 모바일 숙박 추천 순
	 * 파일명 : selectMwMain09
	 * 작성일 : 2016. 10. 19. 오전 10:46:54
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain09();

	/**
	 * 모바일 렌터카 추천 순
	 * 파일명 : selectMwMain10
	 * 작성일 : 2016. 10. 19. 오전 10:49:06
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain10();

	/**
	 * 관광지/레저 추천순
	 * 파일명 : selectMwMain11
	 * 작성일 : 2016. 10. 19. 오전 11:56:35
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain11();

	/**
	 * 음식/뷰티 추천순
	 * 파일명 : selectMwMain12
	 * 작성일 : 2016. 10. 19. 오후 2:18:54
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain12();

	/**
	 * 패키지 추천순
	 * 파일명 : selectMwMain13
	 * 작성일 : 2016. 10. 19. 오후 2:25:58
	 * 작성자 : 최영철
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain13();
	
	/**
	 * 특가전 상품 리스트
	 * Function : selectMwMain14
	 * 작성일 : 2017. 12. 14. 오후 2:42:26
	 * 작성자 : 정동수
	 * @return
	 */
	List<MAINPRDTVO> selectMwMain14();

	/**
	 * 관광기념품
	 * 파일명 : selectMain22
	 * 작성일 : 2016. 10. 26. 오전 10:55:22
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	List<MAINPRDTVO> selectMain22(MAINPRDTSVO mainSVO);
	
	/**
	 * '인기있수다' 선택 상품 리스트
	 * Function : selectMainHotList
	 * 작성일 : 2017. 11. 23. 오후 2:01:50
	 * 작성자 : 정동수
	 * @return
	 */
	List<MAINHOTPRDTVO> selectMainHotList();
	
	/**
	 * '인기있수다'의 판매순 상품 리스트
	 * Function : selectMainRsvList
	 * 작성일 : 2017. 11. 23. 오후 2:04:57
	 * 작성자 : 정동수
	 * @return
	 */
	List<MAINHOTPRDTVO> selectMainRsvList();
	
	/**
	 * '즐거움 폭발' 상품 리스트
	 * Function : selectMainUrlList
	 * 작성일 : 2017. 11. 23. 오후 2:02:07
	 * 작성자 : 정동수
	 * @return
	 */
	List<MAINHOTPRDTVO> selectMainUrlList();
	
	/**
	 * 지역별 핫 플레이스 상품 리스트
	 * Function : selectMainAreaList
	 * 작성일 : 2017. 11. 23. 오후 2:02:22
	 * 작성자 : 정동수
	 * @return
	 */
	List<MAINAREAPRDTVO> selectMainAreaList();
	
	/**
	 * 카테고리별 추천 상품 리스트
	 * Function : selectMainCtgrRcmdList
	 * 작성일 : 2018. 1. 5. 오후 3:28:46
	 * 작성자 : 정동수
	 * @return
	 */
	List<MAINCTGRRCMDVO> selectMainCtgrRcmdList();

	/**
	 * 카테고리 추천 상품 리스트
	 */
	List<MAINCTGRRCMDVO> selectMainCtgrRcmdList(MAINCTGRRCMDVO mainctgrrcmdVO);

	/**
	 * 카테고리 추천 제외 소셜 상품 리스트
	 */
	List<MAINPRDTVO> selectMain33(MAINPRDTSVO mainSVO);

	List<MAINPRDTVO> selectBestAd();

	void insertTamnaoPartner(USERVO userVO);

	Map<String, Object> selectTamnaoPartners(USERVO userVO);

	USERVO selectTamnaoPartner(USERVO userVO);

	void updateTamnaoPartner(USERVO userVO);

	void updateTamnaoPartnerAccessCnt(USERVO userVO);

	void deleteTamnaoPartner(USERVO userVO);

	int selectTamnaoPartnersCnt(USERVO userVO);

	/**
	 * 6차산업인증 추천 상품 리스트
	 */
	List<MAINCTGRRCMDVO> selectSixIntroCtgrRcmdList(MAINCTGRRCMDVO mainctgrrcmdVO);
	
	Map<String, Object> partnerAnls(USERVO userVO);
}
