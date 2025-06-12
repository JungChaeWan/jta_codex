package oss.cmm.service.impl;

import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.prmt.service.impl.PrmtDAO;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import oss.benner.vo.BANNERVO;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CM_DTLIMGVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.impl.CorpPnsReqDAO;
import oss.corp.vo.CORP_PNSREQFILEVO;
import oss.etc.vo.FILEVO;
import oss.point.vo.POINT_CPVO;
import oss.prmt.vo.GOVAFILEVO;
import oss.prmt.vo.GOVAVO;
import oss.prmt.vo.PRMTFILEVO;
import oss.useepil.service.impl.UseepliDAO;
import oss.useepil.vo.USEEPILIMGVO;
import oss.useepil.vo.USEEPILVO;
import web.bbs.service.impl.WebBbsDAO;
import web.bbs.vo.NOTICEFILEVO;
import web.bbs.vo.NOTICEVO;
import web.mypage.service.impl.WebMypageDAO;
import web.mypage.vo.RSVFILEVO;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;
import java.util.Map.Entry;


@Service("ossFileUtilService")
public class OssFileUtilServiceImpl extends EgovAbstractServiceImpl implements OssFileUtilService {

	@Resource(name = "cmmImgDAO")
	private CmmImgDAO cmmImgDAO;

	@Resource(name = "webBbsDAO")
	private WebBbsDAO webBbsDAO;

	@Resource(name = "useepliDAO")
	private UseepliDAO useepliDAO;

	@Resource(name = "prmtDAO")
	private PrmtDAO prmtDAO;

	@Resource(name = "cmmDtlImgDAO")
	private CmmDtlImgDAO cmmDtlImgDAO;

	@Resource(name = "corpPnsReqDAO")
	private CorpPnsReqDAO corpPnsReqDAO;

	@Resource(name="webMypageDAO")
	private WebMypageDAO webMypageDAO;

	private static final Logger log = LoggerFactory.getLogger(OssFileUtilServiceImpl.class);

	public static final int BUFF_SIZE = 2048;


	/** 이미지관련 확장자 */
	//private static String EXT_PATTERN_IMG = "img|bmp|gif|jpeg|jpg|png|psd|ai";
	private static String EXT_PATTERN_IMG = "gif|jpeg|jpg|png";

	/** 엑셀관련 확장자 */
	private static String EXT_PATTERN_EXCEL = "xlsx|xls";

	/** 썸네일 경로 */
	private static String IMAGE_THUMB = "thumb";
	/** 리스트용도 썸네일 경로 */
	private static String IMAGE_THUMB_LIST = "thumb/list";

	private static String PATH_SRV = EgovProperties.getProperty("HOST.WEBROOT");

	private static int RATIO = 0;
	private static int SAME = -1;

	/**
	 * 확장자를 통해 이미지인지 체크
	 */
	public boolean imageCheck(String ext) {
		String extension = ext.toLowerCase();
		return extension.matches(EXT_PATTERN_IMG);
	}

	/**
	 * 확장자를 통해 엑셀파일인지 체크
	 */
	public boolean excelCheck(String ext) {
		String extension = ext.toLowerCase();
		return extension.matches(EXT_PATTERN_EXCEL);
	}

	public void uploadFile(MultipartFile file, String newFileNm, String path) throws Exception{
		log.info(PATH_SRV + path);
		writeUploadedFile(file, newFileNm, PATH_SRV + path);	//writeUploadedFile(file, newFileNm, path);
	}

	public void uploadImgFile(MultipartFile file, String newFileNm, String path) throws Exception{

		writeUploadedFile(file, newFileNm, PATH_SRV + path);
		writeUploadedFile(file, newFileNm, PATH_SRV + path + IMAGE_THUMB);
		uploadThumbImage(path, newFileNm, file);
	}

	/**
     * 첨부파일을 서버에 저장한다.
     *
     * @param file				파일
     * @param newName			저장 이름
     * @param stordFilePath		저장 경로
     * @throws Exception
     */
    protected void writeUploadedFile(MultipartFile file, String newName, String stordFilePath) throws Exception {

    	InputStream stream = null;
    	OutputStream bos = null;
		try {
		    stream = file.getInputStream();
		    File cFile = new File(stordFilePath);
		    log.info("stordFilePath::" + stordFilePath);
		    // 디렉토리가 존재하지 않으면 디렉토리 생성
		    if (!cFile.isDirectory()) {
		    	boolean _flag = cFile.mkdirs();
				if (!_flag) {
				    throw new IOException("Directory creation Failed ");
				}
		    }

		    bos = new FileOutputStream(stordFilePath + File.separator + newName);

		    int bytesRead = 0;
		    byte[] buffer = new byte[BUFF_SIZE];

		    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
		    	bos.write(buffer, 0, bytesRead);
		    }
		} catch (Exception e) {
		    //e.printStackTrace();
		    log.error("IGNORE:", e);	// 2011.10.10 보안점검 후속조치
		} finally {
		    if (bos != null) {
		    	try {
		    		bos.close();
		    	} catch (Exception ignore) {
		    		log.info("IGNORED: " + ignore.getMessage());
		    	}
		    }
		    if (stream != null) {
				try {
				    stream.close();
				} catch (Exception ignore) {
				    log.info("IGNORED: " + ignore.getMessage());
				}
		    }
		}
    }

    /**
	 * 해당 경로에 썸네일 이미지를 생성합니다.
	 * @note 이미지 사이즈 수정 (490x326 => 1200x1200, 2018-01-17 By JDongS)
	 */
	public static void uploadThumbImage(String path ,String name, MultipartFile data) {
		String basePath = concat(PATH_SRV, path);
		File file = new File(concat(basePath, name));

		File thumbSize = new File(concat(concat(basePath, IMAGE_THUMB), name));
		try {
			resizeImage(file, thumbSize, 1200, 1200);
		}
		catch (IOException e) {
			throw new IllegalStateException("썸네일이미지 생성에 실패하였습니다.", e);
		}
	}

	/**
	 * 해당 경로에 썸네일 이미지를 생성합니다.
	 * @note 이미지 사이즈 수정 (490x326 => 1200x1200, 2018-01-17 By JDongS)
	 */
	public static void uploadThumbImage(String path ,String name) {
		String basePath = concat(PATH_SRV, path);
		File file = new File(concat(basePath, name));

		File thumbSize = new File(concat(concat(basePath, IMAGE_THUMB), name));
		try {
			resizeImage(file, thumbSize, 1200, 1200);
		}
		catch (IOException e) {
			throw new IllegalStateException("썸네일이미지 생성에 실패하였습니다.", e);
		}
	}

	/**
	 * 2단용 리스트 섬네일 크기변경
	 * 파일명 : uploadThumbImageList2
	 * 작성일 : 2015. 10. 6. 오후 8:30:10
	 * 작성자 : 최영철
	 * @param path
	 * @param name
	 * @param data
	 * @note 이미지 사이즈 수정 (480x320 => 1200x1200, 2017-11-23 By JDongS)
	 */
	public static void uploadThumbImageList2(String path ,String name, MultipartFile data) {
		String basePath = concat(PATH_SRV, path);
		File file = new File(concat(basePath, name));

		File thumbSize = new File(concat(concat(basePath, IMAGE_THUMB_LIST), name));
		try {
			resizeImage(file, thumbSize, 1200, 1200);
		}
		catch (IOException e) {
			throw new IllegalStateException("썸네일이미지 생성에 실패하였습니다.", e);
		}
	}

	/**
	 * 3단용 리스트 섬네일 크기변경
	 * 파일명 : uploadThumbImageList2
	 * 작성일 : 2015. 10. 6. 오후 8:30:10
	 * 작성자 : 최영철
	 * @param path
	 * @param name
	 * @param data
	 * @note 이미지 사이즈 수정 (315x210 => 1200x1200, 2017-11-23 By JDongS)
	 */
	public static void uploadThumbImageList3(String path ,String name, MultipartFile data) {
		String basePath = concat(PATH_SRV, path);
		File file = new File(concat(basePath, name));

		File thumbSize = new File(concat(concat(basePath, IMAGE_THUMB_LIST), name));
		try {
			resizeImage(file, thumbSize, 1200, 1200);
		}
		catch (IOException e) {
			throw new IllegalStateException("썸네일이미지 생성에 실패하였습니다.", e);
		}
	}

	/**
	 * 경로 구분자 유무를 무시하고 경로를 조합합니다.
	 */
	public static String concat(String path1, String path2) {
		if(FilenameUtils.getPrefixLength(path2) > 0) return FilenameUtils.normalize(path1 + path2);
		else return FilenameUtils.concat(path1, path2);
	}

	/**
	 * 파일 크기를 변경합니다.<br>
	 * 높이와 넓이값에 맞도록 파일 크기를 변경합니다.
	 */
	public static void resizeImage(File src, File dest, int width, int height) throws IOException {
		Image srcImg = setImage(src);

		int srcWidth = srcImg.getWidth(null);
		int srcHeight = srcImg.getHeight(null);
		int destWidth = -1;
		int destHeight = -1;

		if(width == SAME) destWidth = srcWidth;
		else if(width > 0) destWidth = width;

		if(height == SAME) destHeight = srcHeight;
		else if(height > 0) destHeight = height;

		if(width == RATIO && height == RATIO) {
			destWidth = srcWidth;
			destHeight = srcHeight;
		}
		else if(width == RATIO) {
			double ratio = ((double) destHeight)/((double) srcHeight);
			destWidth = (int) ((double) srcWidth*ratio)-1;
		}
		else if(height == RATIO) {
			double ratio = ((double) destWidth)/((double) srcWidth);
			destHeight = (int) ((double) srcHeight*ratio)-1;
		}

		Image imgTarget = srcImg.getScaledInstance(destWidth,destHeight, Image.SCALE_SMOOTH);
		int pixels[] = new int[destWidth*destHeight];
		PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, destWidth, destHeight, pixels, 0, destWidth);

		try {
			pg.grabPixels();
		} catch(InterruptedException e) {
			throw new IOException(e.getMessage());
		}

		BufferedImage destImg = new BufferedImage(destWidth, destHeight, BufferedImage.TYPE_INT_RGB);
		destImg.setRGB(0, 0, destWidth, destHeight, pixels, 0, destWidth);
		ImageIO.write(destImg, "jpg", dest);
	}

	private static Image setImage(File src) throws IOException {
		Image srcImg = null;
		String suffix = src.getName().substring(src.getName().lastIndexOf('.')+1).toLowerCase();
		if(suffix.equals("bmp")) srcImg = ImageIO.read(src);
		else srcImg = new ImageIcon(src.toURI().toURL()).getImage();
		return srcImg;
	}

	/**
	 * 파일 크기를 변경합니다.<br>
	 * 넓이값 기준으로 이미지를 변경
	 */
	public static void editorResizeImage(File src, File dest, int width) throws IOException {
		Image srcImg = setImage(src);

		int srcWidth = srcImg.getWidth(null);
		int srcHeight = srcImg.getHeight(null);
		int destWidth = 0;
		int destHeight = 0;

		if(srcWidth > width) {
			destWidth = width;
			destHeight = (int)((double)srcHeight * ((double)destWidth / (double)srcWidth));
		} else {
			destWidth = srcWidth;
			destHeight = srcHeight;
		}

		Image imgTarget = srcImg.getScaledInstance(destWidth, destHeight, Image.SCALE_SMOOTH);
		int pixels[] = new int[destWidth*destHeight];
		PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, destWidth, destHeight, pixels, 0, destWidth);

		try {
			pg.grabPixels();
		} catch(InterruptedException e) {
			throw new IOException(e.getMessage());
		}

		BufferedImage destImg = new BufferedImage(destWidth, destHeight, BufferedImage.TYPE_INT_RGB);
		destImg.setRGB(0, 0, destWidth, destHeight, pixels, 0, destWidth);
		ImageIO.write(destImg, "jpg", dest);
	}

	public void deleteSavedFile(String deleteFile) throws Exception{
    	try{
    		log.info("파일삭제실행");
    		File file = new File(PATH_SRV + deleteFile);
    		file.delete();
    	}catch(Exception e){
    		log.error("IGNORE:", e);
    	}
    }

	public void deleteSavedFile(String fileName, String stordFilePath) throws Exception{
    	try{
    		log.info("파일삭제실행");
    		log.info("stordFilePath : " + PATH_SRV + stordFilePath);
    		log.info("fileName : " + fileName);
    		File file = new File(PATH_SRV + stordFilePath + File.separator + fileName);
    		file.delete();
    	}catch(Exception e){
    		log.error("IGNORE:", e);
    	}
    }

	public void deleteSavedFullFile(String deleteFile) throws Exception{
    	try{
    		log.info("파일삭제실행");
    		File file = new File(deleteFile);
    		file.delete();
    	}catch(Exception e){
    		log.error("IGNORE:", e);
    	}
    }

	/**
	 * 해당 파일이 존재하는지를 체크한다.
	 * 생성일시 : 2015. 2. 6.오전 11:39:03
	 * 생성자   : 최영철
	 * @param fileName
	 * @param stordFilePath
	 * @return
	 * @throws Exception
	 */
	public boolean checkSavedFile(String fileName, String stordFilePath) throws Exception{
		try {
			File file = new File(PATH_SRV + stordFilePath + File.separator + fileName);
			if(file.isFile()){
				log.info("해당 파일 존재!");
				return true;
			}else{
				log.info("해당 파일 존재하지 않음!");
				return false;
			}
		} catch (Exception e) {
			throw e;
		}
	}

	/**
	 * 해당 경로에 이미지 파일을 저장합니다.
	 */
	public void uploadImage(String path ,String name, CommonsMultipartFile data) {

		//원본저장
		upload(path, name, data);
	}

	/**
	 * 해당 경로에 파일을 저장한다.
	 */
	protected void upload(String path , String name, CommonsMultipartFile data) {
		String destPath = concat(path, name);
		try {
			data.transferTo(new File(destPath));
		}
		catch (IOException e) {
			throw new IllegalStateException("파일저장에 실패하였습니다.", e);
		}
	}

	/**
	 * 2단용 이미지 업로드
	 * 파일명 : uploadImgFile2
	 * 작성일 : 2015. 10. 6. 오후 8:17:16
	 * 작성자 : 최영철
	 * @param file
	 * @param newFileNm		저장할 새로운 이름
	 * @param path			이미지 저장경로
	 * @throws Exception
	 */
	@Override
	public void uploadImgFile2(MultipartFile file, String newFileNm, String path) throws Exception{
		// 원본 업로드
		writeUploadedFile(file, newFileNm, PATH_SRV + path);
		// 리스트용 섬네일 업로드(1200 * 1200)
		writeUploadedFile(file, newFileNm, PATH_SRV + path + IMAGE_THUMB_LIST);
		// 이미지 크기 변환
		uploadThumbImageList2(path, newFileNm, file);
	}

	/**
	 * 3단용 이미지 업로드
	 * 파일명 : uploadImgFile2
	 * 작성일 : 2015. 10. 6. 오후 8:17:16
	 * 작성자 : 최영철
	 * @param file
	 * @param newFileNm		저장할 새로운 이름
	 * @param path			이미지 저장경로
	 * @throws Exception
	 */
	@Override
	public void uploadImgFile3(MultipartFile file, String newFileNm, String path) throws Exception{
		// 원본 업로드
		writeUploadedFile(file, newFileNm, PATH_SRV + path);
		// 리스트용 섬네일 업로드(1200 * 1200)
		writeUploadedFile(file, newFileNm, PATH_SRV + path + IMAGE_THUMB_LIST);
		// 이미지 크기 변환
		uploadThumbImageList3(path, newFileNm, file);
	}

	/**
	 * 입력된 이미지 파일의 validate
	 * 파일명 : validateImgFile
	 * 작성일 : 2015. 10. 7. 오전 10:20:02
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @return
	 */
	@Override
	public Map<String, Object> validateImgFile(MultipartHttpServletRequest multiRequest){
		boolean validateChk = true;
		String message = "성공";

		Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {

				Entry<String, MultipartFile> entry = itr.next();
				file = entry.getValue();
				String fileName = file.getOriginalFilename();

				if(fileName.length() > 50){
					validateChk = false;
					message = "원본 파일명이 너무 깁니다. 50자 이하로 변경해주세요.";
				}

				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())){
					String ext = FilenameUtils.getExtension(fileName);

					// 이미지 확장자 체크
					if(!imageCheck(ext)) {
						validateChk = false;
						message = "이미지 파일이 아닙니다.";
					}
				}
			}
		}
		/*else{
			validateChk = false;
			message = "파일이 존재하지 않습니다.";
		}*/

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("validateChk", validateChk);
		resultMap.put("message", message);

		return resultMap;
	}

	/**
	 * 입력된 이미지 파일의 validate
	 * 파일명 : validateImgFile
	 * 작성일 : 2015. 10. 7. 오전 10:20:02
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @return
	 */
	@Override
	public Map<String, Object> validateExcelFile(MultipartHttpServletRequest multiRequest){
		boolean validateChk = true;
		String message = "성공";

		Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {

				Entry<String, MultipartFile> entry = itr.next();
				file = entry.getValue();
				String fileName = file.getOriginalFilename();

				if(fileName.length() > 50){
					validateChk = false;
					message = "원본 파일명이 너무 깁니다. 50자 이하로 변경해주세요.";
				}

				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())){
					String ext = FilenameUtils.getExtension(fileName);

					// 이미지 확장자 체크
					if(!excelCheck(ext)) {
						validateChk = false;
						message = "엑셀 파일이 아닙니다.";
					}
				}
			}
		}
		/*else{
			validateChk = false;
			message = "파일이 존재하지 않습니다.";
		}*/

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("validateChk", validateChk);
		resultMap.put("message", message);

		return resultMap;
	}

	/**
	 * 이미지 업로드
	 * 파일명 : uploadImgFile
	 * 작성일 : 2015. 10. 7. 오후 1:30:56
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @throws Exception
	 */
	@Override
	public void uploadImgFile(MultipartHttpServletRequest multiRequest,
							  String path,
							  String linkNum) throws Exception{

		Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while(itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				//log.info("entry.getKey() ::: " + entry.getKey());
				file = entry.getValue();
				String fileName = file.getOriginalFilename();
				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())) {
					String ext = FilenameUtils.getExtension(fileName);
					// 이미지 확장자 체크
					if(!imageCheck(ext)) {
						log.info("이미지 파일이 아닙니다.");
					} else {
						String imgNum = cmmImgDAO.selectImgNum(linkNum);
						String newIfleNm = linkNum + "_" + imgNum + "." + ext;
						uploadImgFile(file, newIfleNm, path);

						CM_IMGVO imgVO = new CM_IMGVO();
						imgVO.setImgNum(imgNum);
						imgVO.setLinkNum(linkNum);
						imgVO.setSavePath(path);
						imgVO.setRealFileNm(fileName);
						imgVO.setSaveFileNm(newIfleNm);

						cmmImgDAO.insertImg(imgVO);
					}
				}
			}
		}
	}

	@Override
	public void uploadDtlImgFile(MultipartHttpServletRequest multiRequest,
								 String savePath,
								 String linkNum) throws Exception {

		Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			CM_DTLIMGVO dtlImgVO = new CM_DTLIMGVO();

			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
//				log.info("entry.getKey() ::: " + entry.getKey());
				file = entry.getValue();
				String fileName = file.getOriginalFilename();

				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())){
					String ext = FilenameUtils.getExtension(fileName);
					// 이미지 확장자 체크
					if(!imageCheck(ext)) {
						log.info("이미지 파일이 아닙니다.");
					} else {
						String imgNum = cmmDtlImgDAO.selectImgNum(dtlImgVO.getLinkNum());
						String newIfleNm = dtlImgVO.getLinkNum() + "_" + imgNum + "." + ext;
						uploadImgFile(file, newIfleNm, savePath);

						dtlImgVO.setNewSn(Integer.parseInt(dtlImgVO.getImgSn()));
						dtlImgVO.setImgNum(imgNum);
						dtlImgVO.setSavePath(savePath);
						dtlImgVO.setRealFileNm(fileName);
						dtlImgVO.setSaveFileNm(newIfleNm);

						cmmDtlImgDAO.insertImg2(dtlImgVO);
					}
				}
			}
		}
	}

	/**
	 * 이미지 파일 삭제
	 * 파일명 : deleteImgFile
	 * 작성일 : 2015. 10. 7. 오후 8:56:41
	 * 작성자 : 최영철
	 * @param imgInfo
	 * @throws Exception
	 */
	@Override
	public void deleteImgFile(CM_IMGVO imgInfo) throws Exception{
		deleteSavedFile(imgInfo.getSavePath() + imgInfo.getSaveFileNm());
		deleteSavedFile(imgInfo.getSavePath() + IMAGE_THUMB + File.separator + imgInfo.getSaveFileNm());
	}

	@Override
	public void deleteImgFile(CM_DTLIMGVO imgInfo) throws Exception{
		log.info(">>>>>>>>" + imgInfo.getSavePath() + ":" + imgInfo.getSaveFileNm());
		deleteSavedFile(imgInfo.getSavePath() + imgInfo.getSaveFileNm());
		deleteSavedFile(imgInfo.getSavePath() + IMAGE_THUMB + File.separator + imgInfo.getSaveFileNm());
	}

	/**
	 * 게시글 첨부파일 추가
	 * 파일명 : uploadNoticeFile
	 * 작성일 : 2015. 11. 23. 오전 11:55:26
	 * 작성자 : 신우섭
	 * @param multiRequest
	 * @param path
	 * @param strFileExt
	 * @throws Exception
	 */
	@Override
	public void uploadNoticeFile(MultipartHttpServletRequest multiRequest
								, String path
								, String strFileExt
								, NOTICEVO notiVO) throws Exception {

		Map<String, MultipartFile> files = multiRequest.getFileMap();

		int nCnt = 0;

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				log.info("entry.getKey() ::: " + entry.getKey());

				file = entry.getValue();
				String fileName = file.getOriginalFilename();
				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())){
					String ext = FilenameUtils.getExtension(fileName);
					//확장자 검사
					String newFileNm =  notiVO.getNoticeNum() + "_" + (new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date())) + "_" + nCnt;
					// 이미지 확장자 체크
					if(!imageCheck(ext)) {
						//log.info(">>>>>> ::: " + file.getOriginalFilename() );
						//log.info(">>>>>> ::: " + newFileNm );
						uploadFile(file, newFileNm + "." + ext, path);

					} else {
						//이미지 파일이면 썸네일도 같이 생성
						//uploadFile(file, newFileNm+"."+ext, path);
						uploadImgFile(file, newFileNm + "." + ext, path);
					}
					String strRoot = EgovProperties.getProperty("HOST.WEBROOT");
					File fileTag = new File(strRoot + path + newFileNm);
					long nfileSize = fileTag.length(); //크기 얻기
					//DB넣기
					NOTICEFILEVO notiFileVO = new NOTICEFILEVO();
					notiFileVO.setBbsNum(notiVO.getBbsNum());
					notiFileVO.setNoticeNum(notiVO.getNoticeNum());
					notiFileVO.setSavePath(path);
					notiFileVO.setFileSize(""+nfileSize);
					notiFileVO.setContentsIcdYn("Y");
					notiFileVO.setExt(ext);
					notiFileVO.setRealFileNm(file.getOriginalFilename());
					notiFileVO.setSaveFileNm(newFileNm);

					webBbsDAO.inserNoticeFile(notiFileVO);

					nCnt++;
				}
			}
		}
	}

	@Override
	public void deleteNoticeFile(String strBbsNum, String strNoticeNum) throws Exception {

		NOTICEFILEVO notiFileVO = new NOTICEFILEVO();
		notiFileVO.setBbsNum(strBbsNum);
		notiFileVO.setNoticeNum(strNoticeNum);
		List<NOTICEFILEVO> notiFileList = (List<NOTICEFILEVO>) webBbsDAO.selectNoticeFileList(notiFileVO);
		for (NOTICEFILEVO noticefile : notiFileList) {

			//파일 삭제
			deleteSavedFile(noticefile.getSavePath() + noticefile.getRealFileNm()+"."+noticefile.getExt());

			//썸내일 파일 삭제
			if(imageCheck(noticefile.getExt() )) {
				deleteSavedFile(noticefile.getSavePath() + IMAGE_THUMB + File.separator + noticefile.getRealFileNm()+"."+noticefile.getExt());
			}

			//DB삭제
			webBbsDAO.deleteNoticeFileOne(noticefile);
		}
	}

	@Override
	public void deleteNoticeFile(String strBbsNum,
								 String strNoticeNum,
								 String strFileNum) throws Exception {

		NOTICEFILEVO notiFileVO = new NOTICEFILEVO();
		notiFileVO.setBbsNum(strBbsNum);
		notiFileVO.setNoticeNum(strNoticeNum);
		notiFileVO.setFileNum(strFileNum);

		NOTICEFILEVO notiFileRes = webBbsDAO.selectNoticeFile(notiFileVO);
		//파일 삭제
		deleteSavedFile(notiFileRes.getSavePath() + notiFileRes.getRealFileNm() + "." + notiFileRes.getExt());
		//썸내일 파일 삭제
		if(imageCheck(notiFileRes.getExt())) {
			deleteSavedFile(notiFileRes.getSavePath() + IMAGE_THUMB + File.separator + notiFileRes.getRealFileNm() + "." + notiFileRes.getExt());
		}
		//DB삭제
		webBbsDAO.deleteNoticeFileOne(notiFileVO);
	}

	@Override
	public void copyPrdtImgFile(String oriFileNm, String oriPath, String newFileNm, String savePath) throws Exception {
		copyImgFile(PATH_SRV+oriPath + oriFileNm, PATH_SRV+savePath + newFileNm);
		copyImgFile(PATH_SRV+oriPath + IMAGE_THUMB + File.separator + oriFileNm, PATH_SRV +savePath + IMAGE_THUMB + File.separator + newFileNm);
	}

	@Override
	public void copyImgFile(String oriFileNm, String newFileNm) throws Exception {

		File oriFile = new File(oriFileNm);
		File newFile = new File(newFileNm);

		if(StringUtils.isEmpty(oriFileNm) || StringUtils.isEmpty(newFileNm)) {
			log.error("file path error");
		}

		if(!oriFile.exists()) {
			log.error("original file is not exist  :: " + oriFileNm);
		}

		// 디렉토리일 경우
		if(oriFile.isDirectory()) {
			log.info("copyImgFile is Dirtory");
			if(!newFile.exists()) {
				newFile.mkdir();
			}

			String[] children = oriFile.list();
			for(int i=0;i<children.length;i++) {
				copyImgFile(oriFileNm + children[i], newFileNm + children[i]);
			}
		}
		// 파일일 경우
		else {
			try {
				String path = StringUtils.substringBeforeLast(newFile.getPath(), File.separator);
				File newPathFile = new File(path);
				// 디렉토리가 존재하지 않으면 디렉토리 생성
				if(!newPathFile.exists()) {
					boolean _flag = newPathFile.mkdirs();
					if (!_flag) {
					    throw new IOException("Directory creation Failed ");
					}
				}
				newFile.createNewFile();
				FileCopyUtils.copy(oriFile, newFile);
			} catch(Exception e) {
				log.error(e.getMessage());
				e.printStackTrace();
			}
		}

	}


	@Override
	public String uploadEmailFile(MultipartHttpServletRequest multiRequest, String path) throws Exception{
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		int nCnt = 0;
		String newFileNm = "";
		String ext ="";

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				log.info("entry.getKey() ::: " + entry.getKey());

				file = entry.getValue();
				String fileName = file.getOriginalFilename();

				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())){
					ext = FilenameUtils.getExtension(fileName);
					//확장자 검사


					newFileNm =  "email"+"_"+(new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date()))+"_"+nCnt;

					// 이미지 확장자 체크
					if(!imageCheck(ext)) {
						//log.info(">>>>>> ::: " + file.getOriginalFilename() );
						//log.info(">>>>>> ::: " + newFileNm );
						//uploadFile(file, newFileNm+"."+ext, path);
						log.info("이미지 파일이 아닙니다.");

					}else{
						uploadFile(file, newFileNm+"."+ext, path);
					}

					//String strRoot = EgovProperties.getProperty("HOST.WEBROOT");
					//File fileTag = new File(strRoot+path+newFileNm);

					nCnt++;
				}

			}
		}

		//return path.substring(1) +newFileNm+"."+ext;
		return path + newFileNm + "."+ext;
	}

	@Override
	public void dextUploadImgFileList(String fileList, String savePath, String prdtNum) throws Exception {
		if(!StringUtils.isEmpty(fileList)) {
			String[] a_fileList = fileList.split(",");
			File cFile = new File(PATH_SRV + savePath);
			 // 디렉토리가 존재하지 않으면 디렉토리 생성
		    if (!cFile.isDirectory()) {
		    	boolean _flag = cFile.mkdirs();
				if (!_flag) {
				    throw new IOException("Directory creation Failed ");
				}
		    }
			for(String file : a_fileList) {
				File tempFile = new File(file);
				log.info("tempFile " + tempFile.toString());
				String ext = FilenameUtils.getExtension(tempFile.getName());
				String imgNum = cmmImgDAO.selectImgNum(prdtNum);

				String newFileNm = prdtNum + "_" + imgNum + "." + ext;

				dextWriteImgFile(file, savePath, newFileNm);

				// DB insert
				CM_IMGVO imgVO = new CM_IMGVO();
				imgVO.setImgNum(imgNum);
				imgVO.setLinkNum(prdtNum);
				imgVO.setSavePath(savePath);
				imgVO.setRealFileNm(tempFile.getName());
				imgVO.setSaveFileNm(newFileNm);

				cmmImgDAO.insertImg(imgVO);
			}
		}

	}

	@Override
	public void dextWriteImgFile(String file, String savePath, String newFileNm) throws Exception {
		// 임시 파일 복사.
		copyImgFile(file, PATH_SRV + savePath + newFileNm);
		// 썸네일 만들기.
		copyImgFile(file, PATH_SRV + savePath + IMAGE_THUMB + File.separator + newFileNm);
		uploadThumbImage(savePath, newFileNm);

		// 임시 파일 삭제
		//deleteSavedFullFile(file);
	}

	@Override
	public void uploadUseepilImage(MultipartHttpServletRequest multiRequest,
								   String path,
								   USEEPILVO useepilVO) throws Exception {
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		int nCnt = 0;

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				log.info("entry.getKey() ::: " + entry.getKey());

				file = entry.getValue();
				String fileName = file.getOriginalFilename();

				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())){
					String ext = FilenameUtils.getExtension(fileName);

					String newFileNm = useepilVO.getUseEpilNum() + "_" + (new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date())) + "_" + nCnt;

					// 이미지 확장자 체크
					if(imageCheck(ext)) {
						String saveFileNm = newFileNm + "." + ext;
						//이미지 파일이면 썸네일도 같이 생성
						uploadImgFile(file, saveFileNm, path);
						//DB넣기
						USEEPILIMGVO useepilImgVO = new USEEPILIMGVO();
						useepilImgVO.setUseEpilNum(useepilVO.getUseEpilNum());
						useepilImgVO.setSavePath(path);
						useepilImgVO.setRealFileNm(file.getOriginalFilename());
						useepilImgVO.setSaveFileNm(saveFileNm);

						useepliDAO.insertUseepilImage(useepilImgVO);

						nCnt++;
					}
				}
			}
		}
	}

	@Override
	public void deleteUseepilImage(USEEPILIMGVO useepilImgVO) throws Exception {
		useepilImgVO = useepliDAO.selectUseepilImageInfo(useepilImgVO);
		//파일 삭제
		deleteSavedFile(useepilImgVO.getSavePath() + useepilImgVO.getSaveFileNm());
		//썸내일 파일 삭제
		deleteSavedFile(useepilImgVO.getSavePath() + IMAGE_THUMB + File.separator + useepilImgVO.getSaveFileNm());
		//DB삭제
		useepliDAO.deleteUseepilImage(useepilImgVO);
	}

	@Override
	public String uploadBannerFile(MultipartHttpServletRequest multiRequest,
								   String path,
								   BANNERVO bannerOrg,
								   BANNERVO bannerVO) throws Exception {
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		int nCnt = 0;
		String newFileNm = "";
		String ext ="";

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				//log.info("----entry.getKey() ::: " + entry.getKey());
				file = entry.getValue();
				String fileName = file.getOriginalFilename();
				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())){
					ext = FilenameUtils.getExtension(fileName);
					//확장자 검사
					newFileNm =  "ban"+"_"+(new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date()))+"_"+nCnt;
					// 이미지 확장자 체크
					if(!imageCheck(ext)) {
						//log.info(">>>>>> ::: " + file.getOriginalFilename() );
						//log.info(">>>>>> ::: " + newFileNm );
						//uploadFile(file, newFileNm+"."+ext, path);
						log.info("이미지 파일이 아닙니다.");
					}else{
						uploadFile(file, newFileNm+"."+ext, path);
					}
					//String strRoot = EgovProperties.getProperty("HOST.WEBROOT");
					//File fileTag = new File(strRoot+path+newFileNm);

					//bannerVO.setRealFileName(fileName);
					bannerVO.setImgFileNm(newFileNm + "."+ext);
					bannerVO.setImgPath(path);

					log.info("----fileName ::: " + fileName);
					log.info("----newFileNm ::: " + newFileNm + "."+ext);
					log.info("----path ::: " + path);

					nCnt++;
				}
			}
		}
		//이미지 등록된게 있으면
		if( !(newFileNm.isEmpty() || "".equals(newFileNm)) ){
			//이전께 있으면 삭제
			if(bannerOrg != null){
				deleteSavedFile(bannerOrg.getImgFileNm(), bannerOrg.getImgPath());
			}
		}
		//return path.substring(1) +newFileNm+"."+ext;
		return newFileNm;
	}

	@Override
	public void uploadPrmtFile(MultipartHttpServletRequest multiRequest,
							   String path,
							   String prmtNum) throws Exception {

		Map<String, MultipartFile> files = multiRequest.getFileMap();

		int nCnt = 0;

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while(itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				//log.info("entry.getKey() ::: " + entry.getKey());
				String strKey = entry.getKey();
				//file_로 시작하는 경우만
				if(strKey.startsWith("file_")) {
					//log.info("entry.getKey() ::: " + entry.getKey());
					file = entry.getValue();
					String fileName = file.getOriginalFilename();

					if(!"".equals(file.getOriginalFilename())) {
						//log.info("file ::: " + fileName);
						String ext = FilenameUtils.getExtension(fileName);
						String newFileNm = prmtNum+"_"+(new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date()))+"_"+nCnt;
						//log.info("file save::: " + newFileNm);
						log.info(">>>>>> ::: " + file.getOriginalFilename()+"."+ext );
						log.info(">>>>>> ::: " + newFileNm+"."+ext );
						// 이미지 확장자 체크
						if(!imageCheck(ext)) {
							log.info(">>>>>> ::: save file" );
							uploadFile(file, newFileNm+"."+ext, path);
						} else {
							log.info(">>>>>> ::: save img" );
							//이미지 파일이면 썸네일도 같이 생성
							uploadFile(file, newFileNm+"."+ext, path);
							uploadImgFile(file, newFileNm+"."+ext, path);
						}
						//DB추가
						String strRoot = EgovProperties.getProperty("HOST.WEBROOT");
						File fileTag = new File(strRoot+path+newFileNm);
						//long nfileSize = fileTag.length(); //크기 얻기
						//DB넣기
						PRMTFILEVO prmtFile = new PRMTFILEVO();
						prmtFile.setPrmtNum(prmtNum);
						prmtFile.setSavePath(path);
						prmtFile.setSaveFileNm(newFileNm+"."+ext);
						prmtFile.setRealFileNm(file.getOriginalFilename());
						prmtDAO.insertPrmtFile(prmtFile);

						nCnt++;
					}
				}
			}
		}
	}

	@Override
	public void deletePrmtFile(String prmtNum, String prmtFileNum) throws Exception {
		PRMTFILEVO prmtFile = new PRMTFILEVO();
		prmtFile.setPrmtNum(prmtNum);
		prmtFile.setPrmtFileNum(prmtFileNum);

		PRMTFILEVO resultFile = prmtDAO.selectPrmtFile(prmtFile);
		//파일 삭제
		deleteSavedFile(resultFile.getSavePath() + resultFile.getRealFileNm());
		//썸네일 파일 삭제
		String fileNm = resultFile.getSaveFileNm();
		String ext = fileNm.substring(fileNm.lastIndexOf(".") + 1);

		if(imageCheck(ext)) {
			deleteSavedFile(resultFile.getSavePath() + IMAGE_THUMB + File.separator + resultFile.getRealFileNm());
		}
		//DB삭제
		prmtDAO.deletePrmtFile(prmtFileNum);
	}

	@Override
	public void deleteCmImgFile(String linkNum, String imgNum) throws Exception {
		CM_IMGVO cmImgVO = new CM_IMGVO();
		cmImgVO.setLinkNum(linkNum);
		cmImgVO.setImgNum(imgNum);

		CM_IMGVO resultFile = cmmImgDAO.selectByPrdtImg(cmImgVO);
		//파일 삭제
		deleteSavedFile(resultFile.getSavePath() + resultFile.getRealFileNm());
		//썸네일 파일 삭제
		String fileNm = resultFile.getSaveFileNm();
		String ext = fileNm.substring(fileNm.lastIndexOf(".") + 1);

		if(imageCheck(ext)) {
			deleteSavedFile(resultFile.getSavePath() + IMAGE_THUMB + File.separator + resultFile.getRealFileNm());
		}
		//DB삭제
		cmmImgDAO.deletePrdtImg(cmImgVO);
	}

	@Override
	public void deleteCmDtlImgFile(String linkNum, String imgNum) throws Exception {
		CM_DTLIMGVO cmDtlImgVO = new CM_DTLIMGVO();
		cmDtlImgVO.setLinkNum(linkNum);
		cmDtlImgVO.setImgNum(imgNum);

		CM_DTLIMGVO resultFile = cmmDtlImgDAO.selectByPrdtImg(cmDtlImgVO);
		//파일 삭제
		deleteSavedFile(resultFile.getSavePath() + resultFile.getRealFileNm());
		//썸네일 파일 삭제
		String fileNm = resultFile.getSaveFileNm();
		String ext = fileNm.substring(fileNm.lastIndexOf(".") + 1);

		if(imageCheck(ext)) {
			deleteSavedFile(resultFile.getSavePath() + IMAGE_THUMB + File.separator + resultFile.getRealFileNm());
		}
		//DB삭제
		cmmDtlImgDAO.deletePrdtImg(cmDtlImgVO);
	}

	@Override
	public void uploadCorpPnsRequestFile(MultipartHttpServletRequest multiRequest, String savePath, String requestNum) throws Exception {
		Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			String strKey;
			MultipartFile file;

			String fileNum = "";
			String realFileNm;
			String saveFileNm;

			CORP_PNSREQFILEVO corpPnsReqFileVO = new CORP_PNSREQFILEVO();
			corpPnsReqFileVO.setRequestNum(requestNum);
			corpPnsReqFileVO.setSavePath(savePath);

			Iterator<Map.Entry<String, MultipartFile>> itr = files.entrySet().iterator();

			while(itr.hasNext()) {
				Map.Entry<String, MultipartFile> entry = itr.next();

				file = entry.getValue();

				if(!file.isEmpty()) {
					strKey = entry.getKey();

					if("businessLicense".equals(strKey)) {		// 사업자등록증/
						fileNum = "1";
					} else if("passbook".equals(strKey)) {		// 통장
						fileNum = "2";
					} else if("businessCard".equals(strKey)) {	// 영업신고증
						fileNum = "3";
					} else if("salesCard".equals(strKey)) {		// 통신판매업신고증
						fileNum = "4";
					} else if("contract1".equals(strKey)) { 		// 계약서1 2021.08.06 chaewan.jung
						fileNum = "5";
					} else if("contract2".equals(strKey)) { 		// 계약서2 2021.08.31 chaewan.jung
						fileNum = "6";
					}
					realFileNm = file.getOriginalFilename();
					saveFileNm = requestNum + "_" + fileNum +  "." + FilenameUtils.getExtension(realFileNm);

					uploadFile(file, saveFileNm, savePath);
//					log.info("insertCorpPnsReq : " + savePath + saveFileNm);

					corpPnsReqFileVO.setFileNum(fileNum);
					corpPnsReqFileVO.setRealFileNm(realFileNm);
					corpPnsReqFileVO.setSaveFileNm(saveFileNm);

					corpPnsReqDAO.insertCorpPnsReqFile(corpPnsReqFileVO);
				}
			}
		}
	}

	@Override
	public void deleteCorpPnsRequestFile(String requestNum, String fileNum) throws Exception {
		CORP_PNSREQFILEVO cprfVO = new CORP_PNSREQFILEVO();
		cprfVO.setRequestNum(requestNum);
		cprfVO.setFileNum(fileNum);

		CORP_PNSREQFILEVO resultFile = corpPnsReqDAO.selectCorpPnsReqFile(cprfVO);
		//파일 삭제
		deleteSavedFile(resultFile.getSavePath() + resultFile.getRealFileNm());
		//DB삭제
		corpPnsReqDAO.deleteCorpPnsReqFile(cprfVO);
	}

	/**
	* 설명 : 증빙자료 upload
	* 파일명 : uploadProveFile
	* 작성일 : 2022-04-11 오전 11:07
	* 작성자 : chaewan.jung
	* @param : 
	* @return : 
	* @throws Exception
	*/
	public void uploadRsvFile(MultipartHttpServletRequest multiRequest, String path, RSVFILEVO rsvFileVO) throws Exception {
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		int nCnt = 0;

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				log.info("entry.getKey() ::: " + entry.getKey());

				file = entry.getValue();
				String fileName = file.getOriginalFilename();

				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())){
					String ext = FilenameUtils.getExtension(fileName);
					String newFileNm = rsvFileVO.getDtlRsvNum() + "_" + (new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date())) + "_" + nCnt;
					String saveFileNm = newFileNm + "." + ext;

					uploadFile(file, saveFileNm, path);

					//DB insert
					rsvFileVO.setSavePath(path);
					rsvFileVO.setRealFileNm(file.getOriginalFilename());
					rsvFileVO.setSaveFileNm(saveFileNm);

					webMypageDAO.insertRsvFile(rsvFileVO);

					nCnt++;

				}
			}
		}
	}

	/**
	* 설명 : 증빙자료 delete
	* 파일명 :
	* 작성일 : 2022-04-12 오후 2:11
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void deleteRsvFile(RSVFILEVO rsvFileVO) throws Exception{
		//파일 삭제
		deleteSavedFile(rsvFileVO.getSavePath() + rsvFileVO.getSaveFileNm());

		//DB삭제
		webMypageDAO.deleteRsvFile(rsvFileVO);
	}

	/**
	 * 설명 : 쿠폰생성 시 파일 업로드
	 * 파일명 : uploadPointCpFile
	 * 작성일 : 2023-04-18 오전 11:40
	 * 작성자 : chaewan.jung
	 * @param : [multiRequest, savePath, partnerCode]
	 * @return : POINT_CPVO
	 * @throws Exception
	 */
	@Override
	public POINT_CPVO uploadPointCpFile(MultipartHttpServletRequest multiRequest, String savePath, String partnerCode) throws Exception{
		System.out.println("OssFileUtilServiceImpl.uploadPointCpFile");
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		POINT_CPVO pointCpVO = new POINT_CPVO();

		if (!files.isEmpty()) {
			String strKey;
			MultipartFile file;
			String saveFileNm;
			int randomNum = (int)(Math.random()*1000);

			Iterator<Map.Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			while (itr.hasNext()) {
				Map.Entry<String, MultipartFile> entry = itr.next();
				file = entry.getValue();
				if (!file.isEmpty()) {
					strKey = entry.getKey();
					saveFileNm = randomNum + "_" + partnerCode + "_" + file.getOriginalFilename();

					if ("file_PartnerLogow".equals(strKey)) {	// 파트너사 PC 로고
						pointCpVO.setPartnerLogow(saveFileNm);
					} else if ("file_PartnerLogom".equals(strKey)) {	// 파트너사 모바일 로고
						pointCpVO.setPartnerLogom(saveFileNm);
					} else if ("file_BannerThumb".equals(strKey)) {	// 배너이미지
						pointCpVO.setBannerThumb(saveFileNm);
					}
					try {
						uploadFile(file, saveFileNm, savePath);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		return pointCpVO;
	}

	/**
	* 설명 : 고향사랑기부제 증빙자료 upload
	* 파일명 : uploadHometownFile
	* 작성일 : 2023-12-18 오전 11:07
	* @param : 
	* @return : 
	* @throws Exception
	*/
	public void uploadHometownFile(MultipartHttpServletRequest multiRequest, String path, FILEVO fileVO) throws Exception {
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		int nCnt = 0;

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				log.info("entry.getKey() ::: " + entry.getKey());
				
				file = entry.getValue();
				String fileName = file.getOriginalFilename();

				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())){
					String ext = FilenameUtils.getExtension(fileName);
					//String newFileNm = fileVO.getPrmtNum() + "_" + (new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date())) + "_" + nCnt;
					String newFileNm = fileVO.getUserId();
					String saveFileNm = newFileNm + "." + ext;

					uploadFile(file, saveFileNm, path);

					//DB insert
					fileVO.setSavePath(path);
					fileVO.setRealFileNm(file.getOriginalFilename());
					fileVO.setSaveFileNm(saveFileNm);

					prmtDAO.insertHometownFile(fileVO);
					
					nCnt++;
				}
			}
		}
	}
	
	/**
	* 설명 : 이벤트 이미지 업로드
	* 파일명 : uploadPrmtFile
	* 작성일 : 2024-04-15 오전 09:55
	* @param : 
	* @return : 
	* @throws Exception
	*/
	public void uploadPrmtFile(MultipartHttpServletRequest multiRequest, String path, FILEVO fileVO) throws Exception {
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		//int nCnt = 0;

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				log.info("entry.getKey() ::: " + entry.getKey());
				
				file = entry.getValue();
				String fileName = file.getOriginalFilename();

				// FileName 이 존재할때
				if(!"".equals(file.getOriginalFilename())){
					String ext = FilenameUtils.getExtension(fileName);
					//String newFileNm = fileVO.getPrmtNum() + "_" + (new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date())) + "_" + nCnt;
					String newFileNm = fileVO.getUserId();
					String saveFileNm = newFileNm + "." + ext;

					uploadFile(file, saveFileNm, path);
					
					//DB insert
					fileVO.setSavePath(path);
					fileVO.setRealFileNm(file.getOriginalFilename());
					fileVO.setSaveFileNm(saveFileNm);

					prmtDAO.insertPrmtFile(fileVO);
					
					//nCnt++;
				}
			}
		}
	}

	/**
	* 설명 : 공고 신청 파일 업로드
	* 파일명 : uploadGovAnnouncementFile
	* 작성일 : 25. 5. 21. 오후 1:32
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public String uploadGovAnnouncementFile(String userId, MultipartHttpServletRequest multiRequest, GOVAVO govaVO) {
		String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String folderName = userId + "_" + timestamp;
		String savePath = EgovProperties.getProperty("HOST.WEBROOT") + "/data/prmt/gova" + File.separator + folderName;

		File dir = new File(savePath);
		if (!dir.exists()) dir.mkdirs();

		// 1. TB_GOVA insert
		govaVO.setUserId(userId);
		govaVO.setFolderName(folderName);
		prmtDAO.insertGova(govaVO);

		// 2. 파일 저장 + TB_GOVA_FILE insert
		//  다운로드 시 zip으로 압축하여 제공 해야 하므로 저장 할때는 원 파일 이름대로 저장 처리함.
		List<MultipartFile> fileList = multiRequest.getFiles("files");
		StringBuilder uploadedList = new StringBuilder();

		for (MultipartFile file : fileList) {
			String originalFilename = file.getOriginalFilename();
			if (originalFilename == null || originalFilename.trim().isEmpty()) continue;

			// 확장자 추출
			String extension = "";
			int dotIndex = originalFilename.lastIndexOf(".");
			if (dotIndex != -1 && dotIndex < originalFilename.length() - 1) {
				extension = originalFilename.substring(dotIndex);
			}

			String saveFileName = UUID.randomUUID().toString() + extension;
			File dest = new File(savePath, originalFilename);

			try {
				file.transferTo(dest);
			} catch (IOException e) {
				throw new RuntimeException("파일 저장 실패", e);
			}

			GOVAFILEVO fileVO = new GOVAFILEVO();
			fileVO.setSavePath(savePath);
			fileVO.setFolderName(folderName);
			fileVO.setRealFileNm(originalFilename);
			fileVO.setSaveFileNm(saveFileName);
			fileVO.setPrmtNum(govaVO.getPrmtNum());

			prmtDAO.insertGovaFile(fileVO);
			uploadedList.append(originalFilename).append(" 업로드 완료\n");
		}

		return uploadedList.toString();
	}
}