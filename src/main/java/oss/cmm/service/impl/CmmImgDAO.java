package oss.cmm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.cmm.vo.CM_IMGVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import oss.etc.vo.FILESVO;


@Repository("cmmImgDAO")
public class CmmImgDAO extends EgovAbstractDAO {

	public void insertImg(CM_IMGVO imgVO) {
		insert("CM_IMG_I_00", imgVO);
	}

	/**
	 * 이미지 번호 구하기
	 * 파일명 : selectImgNum
	 * 작성일 : 2015. 10. 7. 오후 2:14:44
	 * 작성자 : 최영철
	 * @param linkNum
	 * @return
	 */
	public String selectImgNum(String linkNum) {
		return (String) select("CM_IMG_S_01", linkNum);
	}

	@SuppressWarnings("unchecked")
	public List<CM_IMGVO> selectImgList(CM_IMGVO imgVO) {
		return (List<CM_IMGVO>) list("CM_IMG_S_02", imgVO);
	}

	public void addImgSn(CM_IMGVO imgVO) {
		update("CM_IMG_U_01", imgVO);
	}

	public void minusImgSn(CM_IMGVO imgVO) {
		update("CM_IMG_U_02", imgVO);
	}

	public void updateImgSn(CM_IMGVO imgVO) {
		update("CM_IMG_U_03", imgVO);
	}

	public CM_IMGVO selectByPrdtImg(CM_IMGVO imgVO) {
		return (CM_IMGVO) select("CM_IMG_S_00", imgVO);
	}

	public void deletePrdtImg(CM_IMGVO imgVO) {
		delete("CM_IMG_D_00", imgVO);
	}

	/**
	 * 이미지 순번이 존재하는 등록
	 * 파일명 : insertImg2
	 * 작성일 : 2015. 10. 8. 오후 5:21:21
	 * 작성자 : 최영철
	 * @param imgVO
	 */
	public void insertImg2(CM_IMGVO imgVO) {
		insert("CM_IMG_I_01", imgVO);
	}


	public List<FILESVO> selectFileList(FILESVO fileSVO) {
		return (List<FILESVO>) list("CM_IMG_S_03", fileSVO);
	}

	public Integer selectFileListCnt(FILESVO fileSVO) {
		return (Integer) select("CM_IMG_S_04", fileSVO);
	}

	public List<CM_IMGVO> selectSvImgList(CM_IMGVO imgVO) {
		return (List<CM_IMGVO>) list("CM_IMG_S_05", imgVO);
	}
}
