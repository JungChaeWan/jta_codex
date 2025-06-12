package web.mypage.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mas.corp.vo.DLVCORPVO;

import org.springframework.stereotype.Repository;

import oss.useepil.vo.USEEPILIMGVO;
import oss.user.vo.USERVO;
import web.mypage.vo.*;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("webMypageDAO")
public class WebMypageDAO extends EgovAbstractDAO {

	public void insertItrPrdt(ITR_PRDTVO itr_PRDTVO) {
		insert("WEB_ITR_PRDT_I_00", itr_PRDTVO);
	}

	public int selectByItrPrdt(ITR_PRDTVO itr_PRDTVO) {
		return (Integer) select("WEB_ITR_PRDT_S_00", itr_PRDTVO);
	}

	@SuppressWarnings("unchecked")
	public List<ITR_PRDTSVO> selectItrFreeProductList(ITR_PRDTSVO itr_PRDTSVO) {
		return (List<ITR_PRDTSVO>) list("WEB_ITR_PRDT_S_01", itr_PRDTSVO);
	}

	public int selectCntItrFreeProductList(ITR_PRDTSVO itr_PRDTSVO) {
		return (Integer) select("WEB_ITR_PRDT_S_02", itr_PRDTSVO);
	}

	public void deleteItrPrdt(ITR_PRDTVO itr_PRDTVO) {
		delete("WEB_ITR_PRDT_D_00", itr_PRDTVO);
	}

	public void insertPocket(POCKETVO pocket) {
		insert("POCKET_I_00", pocket);
	}

	@SuppressWarnings("unchecked")
	public List<POCKETVO> selectPocketList(String userId) {
		return (List<POCKETVO>) list("POCKET_S_00", userId);
	}

	@SuppressWarnings("unchecked")
	public int selectCoupontCnt(String userId) {
		return (Integer) select("COUPON_S_00", userId);
	}
	
	@SuppressWarnings("unchecked")
	public List<POCKETVO> selectPocketList(POCKETVO pocket) {
		return (List<POCKETVO>) list("POCKET_S_01", pocket);
	}

	public void deletePockets(String[] arr_pocketSn) {
		delete("POCKET_D_00", arr_pocketSn);
	}

	public DLVCORPVO dlvTrace(String rsvNum) {
		return (DLVCORPVO) select("DLV_CORP_S_01", rsvNum);
	}
	
	public int selectRsvCategoryNum(RSV_PRDTCATESVO rsvPrdtCate) {
		return (Integer) select("RSV_S_27", rsvPrdtCate);
	}
	
	public int selectEvntPrdtRcvNum(USERVO userVO) {
		return (Integer) select("EVNT_PRDT_RCV_S_00", userVO);
	}
	
	public void insertEvntPrdtRcv(EVNTPRDTRCVVO evntPrdtRcvVO) {
		insert("EVNT_PRDT_RCV_I_00", evntPrdtRcvVO);
	}

	public List<USER_SURVEYVO> selectSurveyList()	{
		return (List<USER_SURVEYVO>) list("SURVEY_S_00");
	}

	/**
	* 설명 : 증빙자료 upload
	* 파일명 : uploadProveFile
	* 작성일 : 2022-04-11 오후 1:33
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void insertRsvFile(RSVFILEVO rsvFileVO){
		insert("RSVFILE_I_00", rsvFileVO);
	}

	/**
	* 설명 : 증빙자료 File List (사용자페이지 - RSV_NUM 기준)
	* 파일명 :
	* 작성일 : 2022-04-12 오후 2:42
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public List<RSVFILEVO> selectRsvFileList(RSVFILEVO rsvFileVO){
		return (List<RSVFILEVO>) list("RSVFILE_S_00", rsvFileVO);
	}

	/**
	* 설명 : 증빙자료 File List (MAS - DTL_RSV_NUM 기준)
	* 파일명 :
	* 작성일 : 2022-04-13 오전 10:36
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public List<RSVFILEVO> selectDtlRsvFileList(RSVFILEVO rsvFileVO){
		return (List<RSVFILEVO>) list("RSVFILE_S_01", rsvFileVO);
	}

	/**
	* 설명 : 증빙자료 delete
	* 파일명 :
	* 작성일 : 2022-04-12 오후 2:44
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void deleteRsvFile(RSVFILEVO rsvFileVO) {
		delete("RSVFILE_D_00", rsvFileVO);
	}

}
