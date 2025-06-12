package oss.useepil.service.impl;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import oss.etc.vo.FILESVO;
import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service("ossUesepliService")
public class OssUseepliServiceImpl extends EgovAbstractServiceImpl implements OssUesepliService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(OssUseepliServiceImpl.class);

	/** UseepliDAO */
	@Resource(name = "useepliDAO")
	private UseepliDAO useepliDAO;

	@Resource(name = "gpaanlsDAO")
	private GpaanlsDAO gpaanlsDAO;



	@Override
	public Map<String, Object> selectUseepilList(USEEPILSVO useepilSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<USEEPILVO> resultList = useepliDAO.selectUseepilList(useepilSVO);
		Integer totalCnt = useepliDAO.getCntUseepilList(useepilSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}



	@Override
	public Map<String, Object> selectUseepilListWeb(USEEPILSVO useepilSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<USEEPILVO> resultList = useepliDAO.selectUseepilListWeb(useepilSVO);
		Integer totalCnt = useepliDAO.getCntUseepilListWeb(useepilSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public USEEPILVO selectByUseepil(USEEPILVO useepilVO) {
		return useepliDAO.selectByUseepil( useepilVO );
	}

	@Override
	public USEEPILVO insertUseepil(USEEPILVO useepilVO) {
		//글올림
		useepilVO.setUseEpilNum(useepliDAO.insertUseepil(useepilVO));
		return useepilVO;
	}

	@Override
	public void updateUsespil(USEEPILVO useepilVO) {
		useepliDAO.updateUseepil(useepilVO);
	}

	@Override
	public void updateUsespilByPrint(USEEPILVO useepilVO) {
		useepliDAO.updateUseepilByPrint(useepilVO);

	}

	@Override
	public void updateUsespilByCmtCnt(USEEPILVO useepilVO) {
		useepliDAO.updateUseepilByCmtCnt(useepilVO);
	}

	@Override
	public	void updateUsespilByCont(USEEPILVO useepilVO){
		useepliDAO.updateUseepilByCont(useepilVO);
	}




	@Override
	public List<USEEPILCMTVO> selectUseepCmtilListWeb(USEEPILSVO useepilSVO) {
		//Map<String, Object> resultMap = new HashMap<String, Object>();

		List<USEEPILCMTVO> resultList = useepliDAO.selectUseepilCmtListPage(useepilSVO);
		//Integer totalCnt = useepliDAO.getCntUseepilList(useepilSVO);

		//resultMap.put("resultList", resultList);
		//resultMap.put("totalCnt", totalCnt);

		//return resultMap;
		return resultList;
	}

	@Override
	public USEEPILCMTVO selectByUseepilCmt(USEEPILCMTVO useepilVCmtO) {
		return useepliDAO.selectByUseepilCmt(useepilVCmtO);
	}

	@Override
	public List<USEEPILCMTVO> selectUseepCmtilListOne(USEEPILCMTVO useepilVCmtO) {
		List<USEEPILCMTVO> resultList = useepliDAO.selectUseepilCmtListOne(useepilVCmtO);
		return resultList;
	}

	@Override
	public void insertUseepilCmt(USEEPILCMTVO useepilVCmtO) {
		//글올림
		useepliDAO.insertUseepilCmt(useepilVCmtO);

		//댓글 수 조정
		USEEPILVO useepilVO = new USEEPILVO();
		useepilVO.setUseEpilNum(useepilVCmtO.getUseEpilNum());
		updateUsespilByCmtCnt(useepilVO);
	}


	@Override
	public void updateUsespilCmt(USEEPILCMTVO useepilCmtVO) {
		useepliDAO.updateUseepilCmt(useepilCmtVO);

	}

	@Override
	public void updateUsespilCmtByPrint(USEEPILCMTVO useepilVCmtO) {
		useepliDAO.updateUseepilCmtByPrint(useepilVCmtO);

		//댓글 수 조정
		USEEPILVO useepilVO = new USEEPILVO();
		useepilVO.setUseEpilNum(useepilVCmtO.getUseEpilNum());
		updateUsespilByCmtCnt(useepilVO);

	}

	@Override
	public void updateUsespilCmtByCont(USEEPILCMTVO useepilVCmtO) {
		useepliDAO.updateUseepilCmtByCont(useepilVCmtO);

	}

	@Override
	public void deleteUsespilCmtByCmtSn(USEEPILCMTVO useepilVCmtO) {
		useepliDAO.deleteUseepilCmtByCmtSn(useepilVCmtO);

		//댓글 수 조정
		USEEPILVO useepilVO = new USEEPILVO();
		useepilVO.setUseEpilNum(useepilVCmtO.getUseEpilNum());
		updateUsespilByCmtCnt(useepilVO);
	}



	@Override
	public GPAANLSVO selectByGpaanls(GPAANLSVO gpaanlsVO) {
		return gpaanlsDAO.selectByGpaanls(gpaanlsVO);
	}



	@Override
	public GPAANLSVO mergeGpaanls(GPAANLSVO gpaanlsVO) {

		GPAANLSSVO gpaSVO = new GPAANLSSVO();
		gpaSVO.setsCorpId(gpaanlsVO.getsCorpId());
		gpaSVO.setsPrdtNum(gpaanlsVO.getsPrdtNum());
		GPAANLSVO gpaRes = gpaanlsDAO.GetGpaanls(gpaSVO);

		gpaRes.setLinkNum( gpaanlsVO.getLinkNum() );
		gpaanlsDAO.mergeGpaanls(gpaRes);

		return gpaRes;
	}

	@Override
	public GPAANLSVO GetGpaanls(GPAANLSVO gpaanlsVO) {

		GPAANLSSVO gpaSVO = new GPAANLSSVO();
		gpaSVO.setsCorpId(gpaanlsVO.getsCorpId());
		gpaSVO.setsPrdtNum(gpaanlsVO.getsPrdtNum());
		GPAANLSVO gpaRes = gpaanlsDAO.GetGpaanls(gpaSVO);

		return gpaRes;
	}



	@Override
	public int getCntUseepiAll(USEEPILVO useepilVO) {
		return useepliDAO.getCntUseepiAll(useepilVO);
	}



	@Override
	public List<USEEPILIMGVO> selectUseepilImgListWeb(USEEPILSVO useepilSVO) {
		return useepliDAO.selectUseepilImageList(useepilSVO);
	}

	@Override
	public List<USEEPILIMGVO> selectUseepilImgListDiv(USEEPILVO useepilVO) {
		return useepliDAO.selectUseepilImageListDiv(useepilVO);
	}



	@Override
	public List<USEEPILVO> selectUseepilListNopage(USEEPILSVO useepilSVO) {
		return useepliDAO.selectUseepilListNopage(useepilSVO);
	}


	@Override
	public Map<String, Object> selectFileList(FILESVO fileSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<FILESVO> resultList = useepliDAO.selectFileList(fileSVO);

		Integer totalCnt = useepliDAO.selectFileListCnt(fileSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}
	
	@Override
	public void deleteUseepilCmtByUseEpilNum(USEEPILCMTVO useepilCmtVO) {
		useepliDAO.deleteUseepilCmtByUseEpilNum(useepilCmtVO);
	}
	
	@Override
	public void deleteUseepil(USEEPILVO useepilVO) {
		useepliDAO.deleteUseepil(useepilVO);
	}
	
	@Override
	public void deleteUseepilImage2(USEEPILIMGVO useepilImgVO) {
		useepliDAO.deleteUseepilImage2(useepilImgVO);
	}	

	public void insertUseepilAdd(USEEPILADDVO useepilAddVO){useepliDAO.insertUseepilAdd(useepilAddVO);};

	public List<USEEPILADDVO> selectUseepilAddList(String prdtNum){
		return useepliDAO.selectUseepilAddList(prdtNum);
	}

	public void deleteUseepilAdd(int seq){
		useepliDAO.deleteUseepilAdd(seq);
	}
}
