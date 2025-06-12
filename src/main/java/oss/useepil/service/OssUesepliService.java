package oss.useepil.service;

import oss.etc.vo.FILESVO;
import oss.useepil.vo.*;

import java.util.List;
import java.util.Map;



public interface OssUesepliService {

	Map<String, Object> selectUseepilList(USEEPILSVO useepilSVO);
	Map<String, Object> selectUseepilListWeb(USEEPILSVO useepilSVO);
	List<USEEPILVO> selectUseepilListNopage(USEEPILSVO useepilSVO);
	USEEPILVO selectByUseepil(USEEPILVO useepilVO);
	USEEPILVO insertUseepil(USEEPILVO useepilVO);
	void updateUsespil(USEEPILVO useepilVO);
	void updateUsespilByPrint(USEEPILVO useepilVO);
	void updateUsespilByCmtCnt(USEEPILVO useepilVO);
	void updateUsespilByCont(USEEPILVO useepilVO);
//	void deleteAdAddamt(AD_ADDAMTVO ad_ADDAMTVO);
	int getCntUseepiAll(USEEPILVO useepilVO);
	void deleteUseepil(USEEPILVO useepilVO);
	void deleteUseepilCmtByUseEpilNum(USEEPILCMTVO useepilCmtVO);
	void deleteUseepilImage2(USEEPILIMGVO useepilImgVO);
	
	List<USEEPILCMTVO> selectUseepCmtilListWeb(USEEPILSVO useepilSVO);
	List<USEEPILCMTVO> selectUseepCmtilListOne(USEEPILCMTVO useepilVCmtO);
	USEEPILCMTVO selectByUseepilCmt(USEEPILCMTVO useepilVCmtO);
	void insertUseepilCmt(USEEPILCMTVO useepilVCmtO);
	void updateUsespilCmt(USEEPILCMTVO useepilVCmtO);
	void updateUsespilCmtByPrint(USEEPILCMTVO useepilVCmtO);
	void updateUsespilCmtByCont(USEEPILCMTVO useepilVCmtO);
	void deleteUsespilCmtByCmtSn(USEEPILCMTVO useepilVCmtO);


	GPAANLSVO selectByGpaanls(GPAANLSVO gpaanlsVO);
	GPAANLSVO mergeGpaanls(GPAANLSVO gpaanlsVO);
	GPAANLSVO GetGpaanls(GPAANLSVO gpaanlsVO);

	/**
	 * 상품평의 첨부이미지 리스트 출력
	 * Function : selectUseepilImgListWeb
	 * 작성일 : 2016. 8. 23. 오후 4:53:28
	 * 작성자 : 정동수
	 * @param useepilSVO
	 * @return
	 */
	List<USEEPILIMGVO> selectUseepilImgListWeb(USEEPILSVO useepilSVO);

	/**
	 * 이용후기에 해당하는 상품평의 첨부이미지 리스트 출력
	 * Function : selectUseepilImgListDiv
	 * 작성일 : 2016. 8. 23. 오후 5:49:59
	 * 작성자 : 정동수
	 * @param useepilVO
	 * @return
	 */
	List<USEEPILIMGVO> selectUseepilImgListDiv(USEEPILVO useepilVO);


	Map<String, Object> selectFileList(FILESVO fileSVO);


	void insertUseepilAdd(USEEPILADDVO useepilAddVO);

	List<USEEPILADDVO> selectUseepilAddList(String prdtNum);

	void deleteUseepilAdd(int seq);
}
