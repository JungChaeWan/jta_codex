package oss.useepil.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.etc.vo.FILESVO;
import oss.useepil.vo.*;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;



/**
 * 상품평
 * 파일명 : UseepliDAO.java
 * 작성일 : 2015. 10. 22. 오전 8:43:04
 * 작성자 : 신우섭
 */
@Repository("useepliDAO")
public class UseepliDAO extends EgovAbstractDAO {

	/**
	 * 상품평 단건조회
	 * 파일명 : selectByUseepil
	 * 작성일 : 2015. 10. 22. 오전 8:52:35
	 * 작성자 : 신우섭
	 * @param useepilVO
	 * @return
	 */
	public USEEPILVO selectByUseepil(USEEPILVO useepilVO) {
		return (USEEPILVO) select("UEEPIL_S_00", useepilVO);
	}

	/**
	 * 상품평 목록
	 * 파일명 : selectUseepilList
	 * 작성일 : 2015. 10. 22. 오전 8:55:43
	 * 작성자 : 신우섭
	 * @param useepilSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USEEPILVO> selectUseepilList(USEEPILSVO useepilSVO) {
		return (List<USEEPILVO>) list("UEEPIL_S_01", useepilSVO);
	}

	/**
	 * 상품평 목록 전체 카운트
	 * 파일명 : getCntUseepilList
	 * 작성일 : 2015. 10. 22. 오전 8:55:52
	 * 작성자 : 신우섭
	 * @param useepilSVO
	 * @return
	 */
	public Integer getCntUseepilList(USEEPILSVO useepilSVO) {
		return (Integer) select("UEEPIL_S_02", useepilSVO);
	}


	/**
	 * 상품평 목록 사용자 페이지
	 * 파일명 : selectUseepilListWeb
	 * 작성일 : 2015. 10. 26. 오전 9:57:49
	 * 작성자 : 신우섭
	 * @param useepilSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USEEPILVO> selectUseepilListWeb(USEEPILSVO useepilSVO) {
		return (List<USEEPILVO>) list("UEEPIL_S_03", useepilSVO);
	}

	/**
	 * 상품평 목록 사용자 페이지 - 수
	 * 파일명 : getCntUseepilListWeb
	 * 작성일 : 2015. 10. 26. 오전 9:58:01
	 * 작성자 : 신우섭
	 * @param useepilSVO
	 * @return
	 */
	public Integer getCntUseepilListWeb(USEEPILSVO useepilSVO) {
		return (Integer) select("UEEPIL_S_04", useepilSVO);
	}


	public Integer getCntUseepiAll(USEEPILVO useepilVO) {
		return (Integer) select("UEEPIL_S_05", useepilVO);
	}


	/**
	 * 상품평 목록 엑셀 저장용
	 * 파일명 : selectUseepilListNopage
	 * 작성일 : 2017. 7. 26. 오전 10:56:38
	 * 작성자 : 신우섭
	 * @param useepilSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USEEPILVO> selectUseepilListNopage(USEEPILSVO useepilSVO) {
		return (List<USEEPILVO>) list("UEEPIL_S_06", useepilSVO);
	}



	/**
	 * 상품평 추가
	 * 파일명 : insertUseepil
	 * 작성일 : 2015. 10. 26. 오후 3:34:16
	 * 작성자 : 신우섭
	 * @param useepilVO
	 */
	public String insertUseepil(USEEPILVO useepilVO) {
		return (String) insert("UEEPIL_I_00", useepilVO);
	}

	/**
	 * 상품평 수정
	 * 파일명 : updateUseepil
	 * 작성일 : 2015. 10. 26. 오전 9:58:45
	 * 작성자 : 신우섭
	 * @param useepilVO
	 */
	public void updateUseepil(USEEPILVO useepilVO) {
		update("UEEPIL_U_00", useepilVO);
	}

	/**
	 * 상품평 표시/비표시
	 * 파일명 : updateUseepilByPrint
	 * 작성일 : 2015. 10. 26. 오전 9:59:00
	 * 작성자 : 신우섭
	 * @param useepilVO
	 */
	public void updateUseepilByPrint(USEEPILVO useepilVO) {
		update("UEEPIL_U_01", useepilVO);
	}

	/**
	 * 상품평 댓글 수 업데이트
	 * 파일명 : updateUseepilByCmtCnt
	 * 작성일 : 2015. 10. 26. 오전 9:59:11
	 * 작성자 : 신우섭
	 * @param useepilVO
	 */
	public void updateUseepilByCmtCnt(USEEPILVO useepilVO) {
		update("UEEPIL_U_02", useepilVO);
	}


	public void updateUseepilByCont(USEEPILVO useepilVO) {
		update("UEEPIL_U_03", useepilVO);
	}

//	public void deleteAdAddamt(AD_ADDAMTVO ad_ADDAMTVO) {
//		delete("AD_ADDAMT_D_00", ad_ADDAMTVO);
//	}


	/**
	 * 상품평 답글 단건
	 * 파일명 : selectByUseepilCmt
	 * 작성일 : 2015. 10. 22. 오전 8:56:08
	 * 작성자 : 신우섭
	 * @param useepilCmtVO
	 * @return
	 */
	public USEEPILCMTVO selectByUseepilCmt(USEEPILCMTVO useepilCmtVO) {
		return (USEEPILCMTVO) select("UEEPILCMT_S_00", useepilCmtVO);
	}

	/**
	 * 상품평 답글 조회 - 전체 검색
	 * 파일명 : selectUseepilCmtList
	 * 작성일 : 2015. 10. 22. 오전 8:56:21
	 * 작성자 : 신우섭
	 * @param useepilSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USEEPILCMTVO> selectUseepilCmtListPage(USEEPILSVO useepilSVO) {
		return (List<USEEPILCMTVO>) list("USEEPILCMT_S_01", useepilSVO);
	}


	/**
	 * 상품평 답글 조회 - 상세
	 * 파일명 : selectUseepilCmtList
	 * 작성일 : 2015. 10. 22. 오전 8:56:21
	 * 작성자 : 신우섭
	 * @param useepilSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USEEPILCMTVO> selectUseepilCmtListOne(USEEPILSVO useepilSVO) {
		return (List<USEEPILCMTVO>) list("USEEPILCMT_S_03", useepilSVO);
	}

	/**
	 * 상품평 답글글 추가
	 * 파일명 : insertUseepilCmt
	 * 작성일 : 2015. 10. 26. 오후 4:22:10
	 * 작성자 : 신우섭
	 * @param useepilCmtVO
	 */
	public void insertUseepilCmt(USEEPILCMTVO useepilCmtVO) {
		insert("USEEPILCMT_I_00", useepilCmtVO);
	}

	/**
	 * 상품평 답글 수정
	 * 파일명 : updateUseepilCmt
	 * 작성일 : 2015. 10. 26. 오후 4:21:55
	 * 작성자 : 신우섭
	 * @param useepilCmtVO
	 */
	public void updateUseepilCmt(USEEPILCMTVO useepilCmtVO) {
		update("USEEPILCMT_U_00", useepilCmtVO);
	}

	/**
	 * 상품평 답글 표시/숨김
	 * 파일명 : updateUseepilCmtByPrint
	 * 작성일 : 2015. 10. 26. 오후 4:21:42
	 * 작성자 : 신우섭
	 * @param useepilCmtVO
	 */
	public void updateUseepilCmtByPrint(USEEPILCMTVO useepilCmtVO) {
		update("USEEPILCMT_U_01", useepilCmtVO);
	}

	public void updateUseepilCmtByCont(USEEPILCMTVO useepilCmtVO) {
		update("USEEPILCMT_U_02", useepilCmtVO);
	}

	public void deleteUseepilCmtByCmtSn(USEEPILCMTVO useepilCmtVO) {
		delete("USEEPILCMT_D_00", useepilCmtVO);
	}

	public void deleteUseepilCmtByUseEpilNum(USEEPILCMTVO useepilCmtVO) {
		delete("USEEPILCMT_D_01", useepilCmtVO);
	}


	/**
	 * 상품평의 첨부이미지 목록
	 * Function : selectUseepilImageList
	 * 작성일 : 2016. 8. 23. 오후 4:50:55
	 * 작성자 : 정동수
	 * @param useepilSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USEEPILIMGVO> selectUseepilImageList(USEEPILSVO useepilSVO) {
		return (List<USEEPILIMGVO>) list("USEEPILIMG_S_00", useepilSVO);
	}

	/**
	 * 이용후기에 해당하는 상품평의 첨부이미지 목록
	 * Function : selectUseepilImageListDiv
	 * 작성일 : 2016. 8. 23. 오후 5:48:11
	 * 작성자 : 정동수
	 * @param useepilVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USEEPILIMGVO> selectUseepilImageListDiv(USEEPILVO useepilVO) {
		return (List<USEEPILIMGVO>) list("USEEPILIMG_S_01", useepilVO);
	}

	/**
	 * 상품평의 첨부이미지 정보 산출
	 * Function : selectUseepilImageInfo
	 * 작성일 : 2016. 8. 24. 오전 10:50:28
	 * 작성자 : 정동수
	 * @param useepilImgVO
	 * @return
	 */
	public USEEPILIMGVO selectUseepilImageInfo(USEEPILIMGVO useepilImgVO) {
		return (USEEPILIMGVO) select("USEEPILIMG_S_02", useepilImgVO);
	}

	/**
	 * 상품평의 첨부이미지 등록
	 * Function : insertUseepilImage
	 * 작성일 : 2016. 8. 23. 오후 1:18:47
	 * 작성자 : 정동수
	 * @param useepilImgVO
	 */
	public void insertUseepilImage(USEEPILIMGVO useepilImgVO) {
		insert("USEEPILIMG_I_00", useepilImgVO);
	}

	/**
	 * 상품평의 첨부이미지 삭제
	 * Function : deleteUseepilImage
	 * 작성일 : 2016. 8. 24. 오전 10:42:52
	 * 작성자 : 정동수
	 * @param useepilImgVO
	 */
	public void deleteUseepilImage(USEEPILIMGVO useepilImgVO) {
		delete("USEEPILIMG_D_00", useepilImgVO);
	}

	public List<FILESVO> selectFileList(FILESVO fileSVO) {
		return (List<FILESVO>) list("USEEPILIMG_S_03", fileSVO);
	}

	public Integer selectFileListCnt(FILESVO fileSVO) {
		return (Integer) select("USEEPILIMG_S_04", fileSVO);
	}
	
	public void deleteUseepil(USEEPILVO useepilVO) {
		delete("USEEPIL_D_00", useepilVO);
	}
	
	public void deleteUseepilImage2(USEEPILIMGVO useepilImgVO) {
		delete("USEEPILIMG_D_01", useepilImgVO);
	}

	/**
	* 설명 : 기 상품평에 새로운 상품평 추가
	* 파일명 :
	* 작성일 : 2024-10-18 오전 11:07
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void insertUseepilAdd(USEEPILADDVO useepilAddVO) {
		insert("UEEPIL_I_01", useepilAddVO);
	}
	/**
	* 설명 : 추가 된 상품평 리스트
	* 파일명 :
	* 작성일 : 2024-10-18 오전 11:07
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public List<USEEPILADDVO> selectUseepilAddList(String prdtNum) {
		return (List<USEEPILADDVO>) list("UEEPIL_S_07", prdtNum);
	}

	public void deleteUseepilAdd(int seq) {
		delete("USEEPIL_D_02", seq);
	}
}

