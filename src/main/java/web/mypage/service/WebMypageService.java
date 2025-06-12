package web.mypage.service;

import java.util.List;
import java.util.Map;

import mas.corp.vo.DLVCORPVO;
import oss.useepil.vo.USEEPILIMGVO;
import oss.useepil.vo.USEEPILVO;
import oss.user.vo.USERVO;
import web.mypage.vo.ITR_PRDTVO;
import web.mypage.vo.POCKETVO;
import web.mypage.vo.RSVFILEVO;
import web.mypage.vo.USER_SURVEYVO;

public interface WebMypageService {

	void insertItrPrdt(ITR_PRDTVO itr_PRDTVO);

	int selectByItrPrdt(ITR_PRDTVO itr_PRDTVO);

	Map<String, Object> selectItrFreeProductList(String userId);

	void deleteItrFreeProduct(ITR_PRDTVO itr_PRDTVO);
	
	void insertPocket(POCKETVO pocket);
	
	List<POCKETVO> selectPocketList(String userId);

	int selectCoupontCnt(String userId);

	Map<String, POCKETVO> selectPocketList(POCKETVO pocket);

	void deletePockets(String[] arr_pocketSn);

	DLVCORPVO dlvTrace(String rsvNum);
	
	/**
	 * 이벤트 시 예약된 상품 카테고리 갯수 산출
	 * Function : selectRsvCategoryNum
	 * 작성일 : 2017. 3. 28. 오후 4:40:34
	 * 작성자 : 정동수
	 * @param userVO
	 * @return
	 */
	int selectRsvCategoryNum(USERVO userVO);
	
	/**
	 * 이벤트 상품의 수령 여부 산출
	 * Function : selectEvntPrdtRcvNum
	 * 작성일 : 2017. 3. 29. 오후 12:09:56
	 * 작성자 : 정동수
	 * @param userVO
	 * @return
	 */
	boolean selectEvntPrdtRcvNum(USERVO userVO);
	
	/**
	 * 이벤트 상품의 수령 정보 등록
	 * Function : insertEvntPrdtRcv
	 * 작성일 : 2017. 3. 29. 오후 12:10:20
	 * 작성자 : 정동수
	 * @param userVO
	 */
	void insertEvntPrdtRcv(USERVO userVO);

	List<USER_SURVEYVO> selectSurveyList ();

	/**
	* 설명 : 증빙자료 File List (사용자페이지 - RSV_NUM 기준)
	* 파일명 :
	* 작성일 : 2022-04-11 오후 4:27
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	List<RSVFILEVO> selectRsvFileList(RSVFILEVO rsvFileVO);

	/**
	* 설명 : 증빙자료 File List (MAS - DTL_RSV_NUM 기준)
	* 파일명 :
	* 작성일 : 2022-04-13 오전 10:39
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	List<RSVFILEVO> selectDtlRsvFileList(RSVFILEVO rsvFileVO);
}
