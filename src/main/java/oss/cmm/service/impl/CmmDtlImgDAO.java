package oss.cmm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.cmm.vo.CM_DTLIMGVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import oss.etc.vo.FILESVO;


@Repository("cmmDtlImgDAO")
public class CmmDtlImgDAO extends EgovAbstractDAO {

	public void insertImg(CM_DTLIMGVO imgVO) {
		insert("CM_DTL_IMG_I_00", imgVO);
	}


	/**
	 * 이미지 번호 구하기
	 * 파일명 : selectImgNum
	 * 작성일 : 2015. 10. 20. 오후 3:54:09
	 * 작성자 : 신우섭
	 * @param linkNum
	 * @return
	 */
	public String selectImgNum(String linkNum) {
		return (String) select("CM_DTL_IMG_S_01", linkNum);
	}

	@SuppressWarnings("unchecked")
	public List<CM_DTLIMGVO> selectImgList(CM_DTLIMGVO imgVO) {
		return (List<CM_DTLIMGVO>) list("CM_DTL_IMG_S_02", imgVO);
	}

	public void addImgSn(CM_DTLIMGVO imgVO) {
		update("CM_DTL_IMG_U_01", imgVO);
	}

	public void minusImgSn(CM_DTLIMGVO imgVO) {
		update("CM_DTL_IMG_U_02", imgVO);
	}

	public void updateImgSn(CM_DTLIMGVO imgVO) {
		update("CM_DTL_IMG_U_03", imgVO);
	}


	public CM_DTLIMGVO selectByPrdtImg(CM_DTLIMGVO imgVO) {
		return (CM_DTLIMGVO) select("CM_DTL_IMG_S_00", imgVO);
	}

	public void deletePrdtImg(CM_DTLIMGVO imgVO) {
		delete("CM_DTL_IMG_D_00", imgVO);
	}


	/**
	 * 이미지 순번이 존재하는 등록
	 * 파일명 : insertImg2
	 * 작성일 : 2015. 10. 20. 오후 3:54:21
	 * 작성자 : 신우섭
	 * @param imgVO
	 */
	public void insertImg2(CM_DTLIMGVO imgVO) {
		insert("CM_DTL_IMG_I_01", imgVO);
	}

	public List<FILESVO> selectFileList(FILESVO fileSVO) {
		return (List<FILESVO>) list("CM_DTL_IMG_S_03", fileSVO);
	}

	public Integer selectFileListCnt(FILESVO fileSVO) {
		return (Integer) select("CM_DTL_IMG_S_04", fileSVO);
	}

}
