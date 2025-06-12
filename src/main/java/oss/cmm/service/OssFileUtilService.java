package oss.cmm.service;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import oss.benner.vo.BANNERVO;
import oss.cmm.vo.CM_DTLIMGVO;
import oss.cmm.vo.CM_IMGVO;
import oss.etc.vo.FILEVO;
import oss.point.vo.POINT_CPVO;
import oss.prmt.vo.GOVAVO;
import oss.useepil.vo.USEEPILIMGVO;
import oss.useepil.vo.USEEPILVO;
import web.bbs.vo.NOTICEVO;
import web.mypage.vo.RSVFILEVO;


public interface OssFileUtilService {

	boolean imageCheck(String ext);

	boolean excelCheck(String ext);

	void uploadFile(MultipartFile file, String string, String string2) throws Exception;

	void uploadImgFile(MultipartFile file, String string, String string2) throws Exception;

	void deleteSavedFile(String deleteFile) throws Exception;
	void deleteSavedFile(String fileName, String stordFilePath) throws Exception;

	void uploadImage(String path ,String name, CommonsMultipartFile data);

	boolean checkSavedFile(String fileName, String stordFilePath) throws Exception;

	/**
	 * 2단용 이미지 업로드
	 * 파일명 : uploadImgFile2
	 * 작성일 : 2015. 10. 6. 오후 8:17:16
	 * 작성자 : 최영철
	 * @param file
	 * @param newFileNm
	 * @param path
	 */
	void uploadImgFile2(MultipartFile file, String newFileNm, String path) throws Exception;

	/**
	 * 3단용 이미지 업로드
	 * 파일명 : uploadImgFile2
	 * 작성일 : 2015. 10. 6. 오후 8:17:16
	 * 작성자 : 최영철
	 * @param file
	 * @param newFileNm
	 * @param path
	 */
	void uploadImgFile3(MultipartFile file, String newFileNm, String path) throws Exception;

	/**
	 * 입력된 이미지 파일의 validate
	 * 파일명 : validateImgFile
	 * 작성일 : 2015. 10. 7. 오전 10:20:02
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @return
	 */
	Map<String, Object> validateImgFile(MultipartHttpServletRequest multiRequest);

	/**
	 * 입력된 엑셀 파일의 validate
	 * 파일명 : validateImgFile
	 * 작성일 : 2015. 10. 7. 오전 10:20:02
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @return
	 */
	Map<String, Object> validateExcelFile(MultipartHttpServletRequest multiRequest);

	/**
	 * 이미지 업로드
	 * 파일명 : uploadImgFile
	 * 작성일 : 2015. 10. 7. 오후 1:38:07
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @param path
	 * @param linkNum
	 * @throws Exception
	 */
	void uploadImgFile(MultipartHttpServletRequest multiRequest, String path, String linkNum) throws Exception;

	void uploadDtlImgFile(MultipartHttpServletRequest multiRequest, String path, String linkNum) throws Exception;

	/**
	 * 이미지 파일 삭제
	 * 파일명 : deleteImgFile
	 * 작성일 : 2015. 10. 7. 오후 8:56:41
	 * 작성자 : 최영철
	 * @param imgInfo
	 * @throws Exception
	 */
	void deleteImgFile(CM_IMGVO imgInfo) throws Exception;

	void deleteImgFile(CM_DTLIMGVO imgInfo) throws Exception;




	/**
	 * 게시글 추가
	 * 파일명 : uploadNoticeFile
	 * 작성일 : 2015. 11. 23. 오전 11:55:03
	 * 작성자 : 신우섭
	 * @param multiRequest
	 * @param path
	 * @param strFileExt
	 * @throws Exception
	 */
	void uploadNoticeFile(MultipartHttpServletRequest multiRequest, String path, String strFileExt, NOTICEVO notiVO) throws Exception;

	void deleteNoticeFile(String strBbsNum, String strNoticeNum)  throws Exception;

	void deleteNoticeFile(String strBbsNum, String strNoticeNum, String strFileNum)  throws Exception;

	void copyPrdtImgFile(String orifileName, String oriPath, String newIfleNm, String savePath) throws Exception;
	void copyImgFile(String orifileName, String newFileNm) throws Exception;



	/**
	 * 이메일 첨부파일 업로드
	 * 파일명 : uploadEmailFile
	 * 작성일 : 2016. 1. 22. 오전 9:44:05
	 * 작성자 : 신우섭
	 * @param multiRequest
	 * @param path
	 * @throws Exception
	 */
	String uploadEmailFile(MultipartHttpServletRequest multiRequest, String path) throws Exception;

	/**
	 * dext5이용한 파일 업로드
	 * @param fileList
	 * @param savePath
	 * @param prdtNum
	 */
	void dextUploadImgFileList(String fileList, String savePath, String prdtNum) throws Exception;

	/**
	 * dext5이용한 파일 업로드
	 * @param file
	 * @param savePath
	 * @param newIfleNm
	 */
	void dextWriteImgFile(String file, String savePath, String newIfleNm) throws Exception;

	/**
	 * 이용후기의 첨부 이미지 업로드
	 * Function : uploadUseepilImage
	 * 작성일 : 2016. 8. 23. 오전 11:45:03
	 * 작성자 : 정동수
	 * @param multiRequest
	 * @param path
	 * @param useepilVO
	 * @throws Exception
	 */
	void uploadUseepilImage(MultipartHttpServletRequest multiRequest, String path, USEEPILVO useepilVO) throws Exception;

	/**
	 * 이용후기의 첨부 이미지 삭제
	 * Function : deleteUseepilImage
	 * 작성일 : 2016. 8. 24. 오전 10:44:27
	 * 작성자 : 정동수
	 * @param useepilImgVO
	 * @throws Exception
	 */
	void deleteUseepilImage(USEEPILIMGVO useepilImgVO) throws Exception;


	String uploadBannerFile(MultipartHttpServletRequest multiRequest, String path, BANNERVO bannerOrg, BANNERVO bannerVO) throws Exception;


	void uploadPrmtFile(MultipartHttpServletRequest multiRequest, String path, String prmtNum) throws Exception;


	void deletePrmtFile(String prmtNum, String prmtFileNum) throws Exception;

	void deleteCmImgFile(String linkNum, String imgNum) throws Exception;

	void deleteCmDtlImgFile(String linkNum, String imgNum) throws Exception;

	void uploadCorpPnsRequestFile(MultipartHttpServletRequest multiRequest, String path, String requestNum) throws Exception;

	void deleteCorpPnsRequestFile(String requestNum, String fileNum) throws Exception;

	/**
	* 설명 : 증빙자료 upload
	* 파일명 : uploadProveFile
	* 작성일 : 2022-04-11 오전 11:07
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	void uploadRsvFile(MultipartHttpServletRequest multiRequest, String path, RSVFILEVO rsvFileVO) throws Exception;

	/**
	* 설명 : 증빙자료 delete
	* 파일명 : 
	* 작성일 : 2022-04-12 오후 2:05
	* 작성자 : chaewan.jung
	* @param : 
	* @return : 
	* @throws Exception
	*/
	void deleteRsvFile(RSVFILEVO rsvFileVO) throws Exception;

	POINT_CPVO uploadPointCpFile( MultipartHttpServletRequest multiRequest,String savePath, String partnerCode) throws Exception;
	
	/**
	* 설명 : 고향사랑기부제 증빙자료 upload
	* 파일명 : uploadHometownFile
	* 작성일 : 2023-12-18 오전 11:07
	* @param :
	* @return :
	* @throws Exception
	*/
	void uploadHometownFile(MultipartHttpServletRequest multiRequest, String path, FILEVO fileVO) throws Exception;
	
	/**
	* 설명 : 이벤트 이미지 업로드
	* 파일명 : uploadPrmtFile
	* 작성일 : 2024-04-15 오전 09:55
	* @param : 
	* @return : 
	* @throws Exception
	*/
	void uploadPrmtFile(MultipartHttpServletRequest multiRequest, String path, FILEVO fileVO) throws Exception;


	/**
	* 설명 : 공고 신청 파일 업로드
	* 파일명 : uploadGovAnnouncementFile
	* 작성일 : 25. 5. 21. 오후 1:31
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	String uploadGovAnnouncementFile(String userId, MultipartHttpServletRequest multiRequest, GOVAVO gavaVO);
}
