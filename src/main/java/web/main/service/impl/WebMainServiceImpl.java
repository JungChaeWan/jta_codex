package web.main.service.impl;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;

import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import oss.site.vo.MAINAREAPRDTVO;
import oss.site.vo.MAINCTGRRCMDVO;
import oss.site.vo.MAINHOTPRDTVO;
import oss.user.vo.USERVO;
import web.main.service.WebMainService;
import web.main.vo.MAINPRDTSVO;
import web.main.vo.MAINPRDTVO;
import web.product.service.WebAdProductService;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;
import web.product.service.WebSvProductService;
import web.product.vo.CARTVO;

import common.Constant;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("webMainService")
public class WebMainServiceImpl extends EgovAbstractServiceImpl implements WebMainService {

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;
	
	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpProductService;
	
	@Resource(name = "webSvService")
	protected WebSvProductService webSvProductService;
	
	@Resource(name = "webMainDAO")
	private WebMainDAO webMainDAO;
	
	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(WebMainServiceImpl.class);

	@Override
	public List<CARTVO> prdtAbleChk(List<CARTVO> cartList){
		for(int i=0;i<cartList.size();i++){
			CARTVO cartVO = cartList.get(i);
			// 렌터카 가능여부
			if(Constant.RENTCAR.equals(cartVO.getPrdtNum().substring(0, 2).toUpperCase())){
				RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
				prdtSVO.setsPrdtNum(cartVO.getPrdtNum());
				prdtSVO.setsFromDt(cartVO.getFromDt());
				prdtSVO.setsFromTm(cartVO.getFromTm());
				prdtSVO.setsToDt(cartVO.getToDt());
				prdtSVO.setsToTm(cartVO.getToTm());
				
	   			// 예약가능여부 확인
	   	    	RC_PRDTINFVO ableVO = webRcProductService.selectRcPrdt(prdtSVO);
	   	    	
	   	    	cartVO.setAbleYn(ableVO.getAbleYn());
	   	    	// cartVO.setAbleYn("N");
	   	    	
			}
			// 숙소 가능여부
			else if(Constant.ACCOMMODATION.equals(cartVO.getPrdtNum().substring(0, 2).toUpperCase())){
				if(webAdProductService.getTotalPrice(cartVO.getPrdtNum(), cartVO.getStartDt(), cartVO.getNight(), cartVO.getAdultCnt(), cartVO.getJuniorCnt(), cartVO.getChildCnt()) > 0){
					cartVO.setAbleYn(Constant.FLAG_Y);
				}else{
					cartVO.setAbleYn(Constant.FLAG_N);
				}
			}
			// 소셜상품 가능여부
			else if(Constant.SOCIAL.equals(cartVO.getPrdtNum().substring(0, 2).toUpperCase())){
				cartVO.setAbleYn(webSpProductService.saleProductYn(cartVO.getPrdtNum(), cartVO.getSpDivSn(), cartVO.getSpOptSn(), Integer.parseInt(cartVO.getQty())));
			}
			// 관광 기념품 가능여부
			else if(Constant.SV.equals(cartVO.getPrdtNum().substring(0, 2).toUpperCase())){
				cartVO.setAbleYn(webSvProductService.saleProductYn(cartVO.getPrdtNum(), cartVO.getSvDivSn(), cartVO.getSvOptSn(), Integer.parseInt(cartVO.getQty())));
			}
			cartList.set(i, cartVO);
		}
		
		return cartList;
	}
	
	/**
	 * 당일특가 - 숙박
	 * 파일명 : selectMain01
	 * 작성일 : 2015. 12. 17. 오후 5:19:28
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain01(){
		return webMainDAO.selectMain01();
	}
	
	/**
	 * 패키지 새로운 상품
	 * 파일명 : selectMain02
	 * 작성일 : 2015. 12. 17. 오후 8:29:36
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain02(){
		return webMainDAO.selectMain02();
	}
	
	/**
	 * 패키지 랜덤
	 * 파일명 : selectMain03
	 * 작성일 : 2015. 12. 17. 오후 9:23:32
	 * 작성자 : 최영철
	 * @param mainPrdtSVO
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain03(MAINPRDTSVO mainPrdtSVO){
		return webMainDAO.selectMain03(mainPrdtSVO);
	}
	
	/**
	 * 할인쿠폰
	 * 파일명 : selectMain04
	 * 작성일 : 2015. 12. 18. 오전 9:55:41
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain04(){
		return webMainDAO.selectMain04();
	}
	
	/**
	 * 랜터카 랜덤
	 * 파일명 : selectMain05
	 * 작성일 : 2015. 12. 18. 오전 10:43:47
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain05(){
		return webMainDAO.selectMain05();
	}
	
	/**
	 * 관광지 입장권
	 * 파일명 : selectMain06
	 * 작성일 : 2015. 12. 18. 오전 11:15:28
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain06(){
		return webMainDAO.selectMain06();
	}
	
	/**
	 * 숙박 랜덤
	 * 파일명 : selectMain07
	 * 작성일 : 2015. 12. 18. 오후 4:17:24
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain07(){
		return webMainDAO.selectMain07();
	}
	
	/**
	 * 모바일 패키지 랜덤
	 * 파일명 : selectMwMain01
	 * 작성일 : 2015. 12. 22. 오후 2:48:13
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain01(){
		return webMainDAO.selectMwMain01();
	}
	
	/**
	 * 모바일 관광지 + 할인쿠폰
	 * 파일명 : selectMwMain02
	 * 작성일 : 2015. 12. 22. 오후 3:03:47
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain02(){
		return webMainDAO.selectMwMain02();
	}
	
	/**
	 * 모바일 당일예약
	 * 파일명 : selectMwMain03
	 * 작성일 : 2015. 12. 22. 오후 4:34:19
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain03(){
		return webMainDAO.selectMwMain03();
	}

	@Override
	@Cacheable(value = "mainRecommandCache3", key = "'main'")
	public List<MAINPRDTVO> selectMain10(MAINPRDTSVO mainSVO){
		List<MAINPRDTVO> resultList = webMainDAO.selectMain10(mainSVO);
		return resultList;
	}
	
	/**
	 * 숙박예약랭킹
	 * 파일명 : selectMain11
	 * 작성일 : 2016. 3. 8. 오후 3:27:18
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */	
	@Override
	@Cacheable(value = "mainRecommandCache2", key = "'main'")
	public List<MAINPRDTVO> selectMain11(MAINPRDTSVO mainSVO){
		List<MAINPRDTVO> resultList = webMainDAO.selectMain11(mainSVO);
		return resultList;
	}
	
	/**
	 * 할인 렌터카
	 * 파일명 : selectMain12
	 * 작성일 : 2016. 3. 8. 오후 4:39:32
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain12(MAINPRDTSVO mainSVO){
		return webMainDAO.selectMain12(mainSVO);
	}
	
	/**
	 * 패키지 랜덤 3개
	 * 파일명 : selectMain13
	 * 작성일 : 2016. 3. 8. 오후 5:21:49
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain13(MAINPRDTSVO mainSVO){
		return webMainDAO.selectMain13(mainSVO);
	}
	
	/**
	 * 관광지 입장권 랜덤 4개
	 * 파일명 : selectMain14
	 * 작성일 : 2016. 3. 8. 오후 6:04:26
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain14(MAINPRDTSVO mainSVO){
		return webMainDAO.selectMain14(mainSVO);
	}
	
	/**
	 * 레저 랜덤 4개
	 * 파일명 : selectMain15
	 * 작성일 : 2016. 3. 9. 오전 9:53:46
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain15(){
		return webMainDAO.selectMain15();
	}
	
	/**
	 * 음식뷰티기타 8개
	 * 파일명 : selectMain16
	 * 작성일 : 2016. 3. 9. 오전 10:06:44
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain16(MAINPRDTSVO mainSVO){
		return webMainDAO.selectMain16(mainSVO);
	}

	/**
	 * 패키지 할인상품
	 * 파일명 : selectMain17
	 * 작성일 : 2016. 3. 9. 오후 5:33:01
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain17(MAINPRDTSVO mainSVO){
		return webMainDAO.selectMain17(mainSVO);
	}
	
	/**
	 * 골프패키지
	 * 파일명 : selectMain18
	 * 작성일 : 2016. 3. 10. 오전 10:06:54
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain18(){
		return webMainDAO.selectMain18();
	}
	
	/**
	 * 버스관광
	 * 파일명 : selectMain19
	 * 작성일 : 2016. 3. 10. 오전 10:08:37
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain19(){
		return webMainDAO.selectMain19();
	}
	
	/**
	 * 모바일 메인 추천 숙소
	 * 파일명 : selectMwMain04
	 * 작성일 : 2016. 6. 17. 오전 10:58:54
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain04(){
		List<MAINPRDTVO> resultList = new ArrayList<MAINPRDTVO>();
		
		List<MAINPRDTVO> searchList = webMainDAO.selectMwMain04();
		for (MAINPRDTVO main : searchList) {
			// 마감/미정 체크
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int nPrice = webAdProductService.getTotalPrice(main.getPrdtNum(), sdf.format(d), 1, 1, 0, 0);
			
			if (nPrice > 0) 
				resultList.add(main);
			
			// 상위 4개만 추출
			if (resultList != null && resultList.size() == 4)	
				break;
		}
		
		return resultList;
	}
	
	/**
	 * 모바일 메인 렌터카
	 * 파일명 : selectMwMain05
	 * 작성일 : 2016. 6. 17. 오전 11:40:02
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain05(){
		return webMainDAO.selectMwMain05();
	}
	
	/**
	 * 모바일 메인 음식 조회
	 * 파일명 : selectMwMain06
	 * 작성일 : 2016. 6. 17. 오후 1:53:56
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain06(){
		return webMainDAO.selectMwMain06();
	}
	
	/**
	 * 모바일 메인 뷰티 조회
	 * 파일명 : selectMwMain07
	 * 작성일 : 2016. 6. 17. 오후 2:00:57
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain07(){
		return webMainDAO.selectMwMain07();
	}
	
	/**
	 * 모바일 관광지/레져
	 * 파일명 : selectMwMain08
	 * 작성일 : 2016. 9. 5. 오후 4:04:43
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain08(){
		return webMainDAO.selectMwMain08();
	}
	
	/**
	 * 렌터카 메인 조회
	 * 파일명 : selectMain20
	 * 작성일 : 2016. 10. 18. 오전 10:45:39
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain20(MAINPRDTSVO mainSVO){
		return webMainDAO.selectMain20(mainSVO);
	}
	
	/**
	 * 관광기념품 메인 조회
	 * 파일명 : selectMain21
	 * 작성일 : 2016. 10. 18. 오후 2:03:03
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@Override
	@Cacheable(value = "mainRecommandCache4", key = "'main'")
	public List<MAINPRDTVO> selectMain21(MAINPRDTSVO mainSVO){
		return webMainDAO.selectMain21(mainSVO);
	}
	
	/**
	 * 모바일 숙박 추천 순
	 * 파일명 : selectMwMain09
	 * 작성일 : 2016. 10. 19. 오전 10:46:54
	 * 작성자 : 최영철
	 * note : 2017.08.18 마감/미정 제외 처리 (By JDongS)
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain09(){
		List<MAINPRDTVO> resultList = new ArrayList<MAINPRDTVO>();
		
		List<MAINPRDTVO> searchList = webMainDAO.selectMwMain09();
		for (MAINPRDTVO main : searchList) {
			// 마감/미정 체크
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int nPrice = webAdProductService.getTotalPrice(main.getPrdtNum(), sdf.format(d), 1, 1, 0, 0);
			
			if (nPrice > 0) 
				resultList.add(main);
			
			// 상위 4개만 추출
			if (resultList != null && resultList.size() == 5)	
				break;
		}
		
		return resultList;
	}
	
	/**
	 * 모바일 렌터카 추천 순
	 * 파일명 : selectMwMain10
	 * 작성일 : 2016. 10. 19. 오전 10:49:06
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain10(){
		return webMainDAO.selectMwMain10();
	}
	
	/**
	 * 관광지/레저 추천순
	 * 파일명 : selectMwMain11
	 * 작성일 : 2016. 10. 19. 오전 11:56:35
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain11(){
		return webMainDAO.selectMwMain11();
	}
	
	/**
	 * 음식/뷰티 추천순
	 * 파일명 : selectMwMain12
	 * 작성일 : 2016. 10. 19. 오후 2:18:54
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain12(){
		return webMainDAO.selectMwMain12();
	}
	
	/**
	 * 패키지 추천순
	 * 파일명 : selectMwMain13
	 * 작성일 : 2016. 10. 19. 오후 2:25:58
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain13(){
		return webMainDAO.selectMwMain13();
	}
	
	/**
	 * 특가전 상품 리스트
	 * Function : selectMwMain14
	 * 작성일 : 2017. 12. 14. 오후 2:42:26
	 * 작성자 : 정동수
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMwMain14(){
		return webMainDAO.selectMwMain14();
	}
	
	/**
	 * 관광기념품
	 * 파일명 : selectMain22
	 * 작성일 : 2016. 10. 26. 오전 10:55:22
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@Override
	public List<MAINPRDTVO> selectMain22(MAINPRDTSVO mainSVO){
		return webMainDAO.selectMain22(mainSVO);
	}

	/**
	 * '인기있수다' 선택 상품 리스트
	 * Function : selectMainHotList
	 * 작성일 : 2017. 11. 23. 오후 2:01:50
	 * 작성자 : 정동수
	 * @return
	 */
	@Override
	@Cacheable(value = "hotPrmtCache", key = "'main'")
	public List<MAINHOTPRDTVO> selectMainHotList() {
		return webMainDAO.selectMainHotList();
	}

	/**
	 * '인기있수다'의 판매순 상품 리스트
	 * Function : selectMainRsvList
	 * 작성일 : 2017. 11. 23. 오후 2:04:57
	 * 작성자 : 정동수
	 * @return
	 */
	@Override
	public List<MAINHOTPRDTVO> selectMainRsvList() {
		return webMainDAO.selectMainRsvList();
	}

	/**
	 * '즐거움 폭발' 상품 리스트
	 * Function : selectMainUrlList
	 * 작성일 : 2017. 11. 23. 오후 2:02:07
	 * 작성자 : 정동수
	 * @return
	 */
	@Override
	public List<MAINHOTPRDTVO> selectMainUrlList() {
		return webMainDAO.selectMainUrlList();
	}

	/**
	 * 지역별 핫 플레이스 상품 리스트
	 * Function : selectMainAreaList
	 * 작성일 : 2017. 11. 23. 오후 2:02:22
	 * 작성자 : 정동수
	 * @return
	 */
	@Override
	public List<MAINAREAPRDTVO> selectMainAreaList() {
		return webMainDAO.selectMainAreaList();
	}

	/**
	 * 카테고리별 추천 상품 리스트
	 * Function : selectMainCtgrRcmdList
	 * 작성일 : 2018. 1. 5. 오후 3:28:46
	 * 작성자 : 정동수
	 * @return
	 */
	@Override
	public List<MAINCTGRRCMDVO> selectMainCtgrRcmdList() {
		return webMainDAO.selectMainCtgrRcmdList();
	}

	/**
	 * 카테고리 추천 상품 리스트
	 */
	@Override
	@Cacheable(value = "mainRecommandCache1", key = "#mainctgrrcmdVO.prdtDiv")
	public List<MAINCTGRRCMDVO> selectMainCtgrRcmdList(MAINCTGRRCMDVO mainctgrrcmdVO) {
		return webMainDAO.selectMainCtgrRcmdList(mainctgrrcmdVO);
	}

	/**
	 * 카테고리 추천 제외 소셜 상품 랭킹 리스트
	 */
	@Override
	@Cacheable(value = "mainRecommandCache5", key = "'main'")
	public List<MAINPRDTVO> selectMain33(MAINPRDTSVO mainSVO){
		return webMainDAO.selectMain33(mainSVO);
	}

	@Override
	@Cacheable(value = "subMainAdBest", key = "'main'")
	public List<MAINPRDTVO> selectBestAd(){
		return webMainDAO.selectBestAd();
	}

	@Override
	public USERVO selectTamnaoPartner(USERVO userVO){
		return webMainDAO.selectTamnaoPartner(userVO);
	}

	@Override
	public void insertTamnaoPartner(USERVO userVO){
		webMainDAO.insertTamnaoPartner(userVO);
	}

	@Override
	public Map<String, Object> selectTamnaoPartners(USERVO userVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<USERVO> resultList = webMainDAO.selectTamnaoPartners(userVO);
		Integer totalCnt = webMainDAO.selectTamnaoPartnersCnt(userVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		return resultMap;
	}

	@Override
	public int selectTamnaoPartnersCnt(USERVO userVO){
		return webMainDAO.selectTamnaoPartnersCnt(userVO);
	}

	@Override
	public void updateTamnaoPartner(USERVO userVO){
		webMainDAO.updateTamnaoPartner(userVO);
	}

	@Override
	public void updateTamnaoPartnerAccessCnt(USERVO userVO){
		webMainDAO.updateTamnaoPartnerAccessCnt(userVO);
	}

	@Override
	public void deleteTamnaoPartner(USERVO userVO){
		webMainDAO.deleteTamnaoPartner(userVO);
	}

	@Override
	public List<MAINCTGRRCMDVO> selectSixIntroCtgrRcmdList(MAINCTGRRCMDVO mainctgrrcmdVO) {
		return webMainDAO.selectSixIntroCtgrRcmdList(mainctgrrcmdVO);
	}
	
	@Override
	public Map<String, Object> partnerAnls(USERVO userVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<USERVO> resultList = webMainDAO.partnerAnls(userVO);

		resultMap.put("resultList", resultList);
		//resultMap.put("totalCnt", totalCnt);
		return resultMap;
	}
	
}
