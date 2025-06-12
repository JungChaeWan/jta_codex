package web.mypage.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.util.StringUtil;
import org.springframework.stereotype.Service;

import oss.useepil.vo.USEEPILIMGVO;
import oss.user.vo.USERVO;
import common.Constant;
import web.mypage.service.WebMypageService;
import web.mypage.vo.*;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.corp.vo.DLVCORPVO;

@Service("webMypageService")
public class WebMypageServiceImpl extends EgovAbstractServiceImpl implements WebMypageService{

	@Resource(name="webMypageDAO")
	private WebMypageDAO webMypageDAO;
	
	@Override
	public void insertItrPrdt(ITR_PRDTVO itr_PRDTVO) {
		webMypageDAO.insertItrPrdt(itr_PRDTVO);
	}

	@Override
	public int selectByItrPrdt(ITR_PRDTVO itr_PRDTVO) {
		return webMypageDAO.selectByItrPrdt(itr_PRDTVO);
	}

	@Override
	public Map<String, Object> selectItrFreeProductList(String userId) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		ITR_PRDTSVO searchVO = new ITR_PRDTSVO();
		searchVO.setPrdtDiv(Constant.SP_PRDT_DIV_FREE);
		searchVO.setUserId(userId);
		List<ITR_PRDTSVO> resultList = webMypageDAO.selectItrFreeProductList(searchVO);
		Integer totalCnt = webMypageDAO.selectCntItrFreeProductList(searchVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}

	@Override
	public void deleteItrFreeProduct(ITR_PRDTVO itr_PRDTVO) {
		webMypageDAO.deleteItrPrdt(itr_PRDTVO);
	}

	@Override
	public void insertPocket(POCKETVO pocket) {
		webMypageDAO.insertPocket(pocket);
	}
	
	@Override
	public List<POCKETVO> selectPocketList(String userId) {
		return webMypageDAO.selectPocketList(userId);
	}

	@Override
	public int selectCoupontCnt(String userId) {
		return webMypageDAO.selectCoupontCnt(userId);
	}
	
	@Override
	public Map<String, POCKETVO> selectPocketList(POCKETVO pocket) {
		Map<String, POCKETVO> resultMap = new HashMap<String, POCKETVO>();
		
		List<POCKETVO> resultList = webMypageDAO.selectPocketList(pocket);
		for (POCKETVO info : resultList) {
			String mapKey = StringUtils.isEmpty(info.getPrdtNum().trim()) ? info.getCorpId() : info.getPrdtNum();
			resultMap.put(mapKey, info);
		}
		
		return resultMap;
	}

	@Override
	public void deletePockets(String[] arr_pocketSn) {
		webMypageDAO.deletePockets(arr_pocketSn);
	}

	@Override
	public DLVCORPVO dlvTrace(String rsvNum) {
		return webMypageDAO.dlvTrace(rsvNum);
	}

	/**
	 * 이벤트 시 예약된 상품 카테고리 갯수 산출
	 * Function : selectRsvCategoryNum
	 * 작성일 : 2017. 3. 28. 오후 4:40:34
	 * 작성자 : 정동수
	 * @param userVO
	 * @return
	 */
	@Override
	public int selectRsvCategoryNum(USERVO userVO) {
		RSV_PRDTCATESVO rsvPrdtCate = new RSV_PRDTCATESVO();
		
		rsvPrdtCate.setsUserId(userVO.getUserId());
		rsvPrdtCate.setsRsvNm(userVO.getUserNm());
		rsvPrdtCate.setsRsvTelnum(userVO.getTelNum());
		rsvPrdtCate.setsEvntStartDt("20170401");
		rsvPrdtCate.setsEvntEndDt("20170430");
		
		return webMypageDAO.selectRsvCategoryNum(rsvPrdtCate);
	}

	/**
	 * 이벤트 상품의 수령 여부 산출
	 * Function : selectEvntPrdtRcvNum
	 * 작성일 : 2017. 3. 29. 오후 12:09:56
	 * 작성자 : 정동수
	 * @param userVO
	 * @return
	 */
	@Override
	public boolean selectEvntPrdtRcvNum(USERVO userVO) {
		int rcvNum = webMypageDAO.selectEvntPrdtRcvNum(userVO);
		boolean resultFlag = rcvNum == 1 ? true : false;	
		
		return resultFlag;				
	}

	/**
	 * 이벤트 상품의 수령 정보 등록
	 * Function : insertEvntPrdtRcv
	 * 작성일 : 2017. 3. 29. 오후 12:10:20
	 * 작성자 : 정동수
	 * @param evntPrdtRcvVO
	 */
	@Override
	public void insertEvntPrdtRcv(USERVO userVO) {
		EVNTPRDTRCVVO evntPrdtRcvVO = new EVNTPRDTRCVVO();
		
		evntPrdtRcvVO.setUserId(userVO.getUserId());
		evntPrdtRcvVO.setUserNm(userVO.getUserNm());
		evntPrdtRcvVO.setTelnum(userVO.getTelNum());
		evntPrdtRcvVO.setEvntCd("EVT4");
		evntPrdtRcvVO.setEvntNum("" + selectRsvCategoryNum(userVO));
		
		webMypageDAO.insertEvntPrdtRcv(evntPrdtRcvVO);
	}

	@Override
	public List<USER_SURVEYVO> selectSurveyList() {
		return webMypageDAO.selectSurveyList();
	}

	/**
	 * 설명 : 증빙자료 File List (사용자페이지 - RSV_NUM 기준)
	 * 파일명 :
	 * 작성일 : 2022-04-11 오후 4:27
	 * 작성자 : chaewan.jung
	 * @param :
	 * @return :
	 * @throws Exception
	 */
	public List<RSVFILEVO> selectRsvFileList(RSVFILEVO rsvFileVO){
		return webMypageDAO.selectRsvFileList(rsvFileVO);
	}

	/**
	* 설명 : 증빙자료 File List (MAS - DTL_RSV_NUM 기준)
	* 파일명 :
	* 작성일 : 2022-04-13 오전 10:38
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public List<RSVFILEVO> selectDtlRsvFileList(RSVFILEVO rsvFileVO){
		return webMypageDAO.selectDtlRsvFileList(rsvFileVO);
	}

}
