package mas.prmt.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.prmt.service.MasPrmtService;
import mas.prmt.vo.MAINPRMTVO;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.cmm.service.OssFileUtilService;
import oss.cmm.service.impl.OssFileUtilServiceImpl;
import oss.etc.vo.FILESVO;
import oss.marketing.vo.EVNTINFSVO;
import oss.marketing.vo.EVNTINFVO;
import oss.prmt.vo.PRMTFILEVO;

import common.Constant;

import egovframework.cmmn.service.EgovProperties;

@Service("masPrmtService")
public class MasPrmtServiceImpl implements MasPrmtService {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(MasPrmtServiceImpl.class);

	@Resource(name = "prmtDAO")
	private PrmtDAO prmtDAO;

	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	private static final Logger log = LoggerFactory.getLogger(OssFileUtilServiceImpl.class);

	@Override
	public Map<String, Object> selectPrmtList(PRMTVO prmtVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<PRMTVO> resultList = prmtDAO.selectPrmtList(prmtVO);
		Integer totalCnt = prmtDAO.getCntPrmtList(prmtVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public Map<String, Object> selectPrmtListOss(PRMTVO prmtVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<PRMTVO> resultList = prmtDAO.selectPrmtListOss(prmtVO);
		Integer totalCnt = prmtDAO.getCntPrmtListOss(prmtVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public Map<String, Object> selectPrmtListFind(PRMTVO prmtVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<PRMTVO> resultList = prmtDAO.selectPrmtListFind(prmtVO);
		Integer totalCnt = prmtDAO.getCntPrmtListFind(prmtVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public String insertPromotion(PRMTVO prmtVO,
								  MultipartHttpServletRequest multiRequest,
								  String type) throws Exception {
		String prmtNum = prmtDAO.getPromotionPk(prmtVO);
		prmtVO.setPrmtNum(prmtNum);

		if("mas".equals(type)) {
			prmtVO.setStatusCd(Constant.TRADE_STATUS_REG);

			prmtDAO.insertPromotion(prmtVO);
		} else {
			// 메인 배너
			MultipartFile mainImgFile = multiRequest.getFile("mainImgFile");

			if(mainImgFile != null && !mainImgFile.isEmpty()) {
				String mainSavePath = EgovProperties.getProperty("PROMOTION.MAIN.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("mainImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(mainImgFile, newFileName, mainSavePath);

				prmtVO.setMainImg(mainSavePath + newFileName);
			}
			// 모바일 메인 배너
			MultipartFile mobileMainImgFile = multiRequest.getFile("mobileMainImgFile");

			if(mobileMainImgFile != null && !mobileMainImgFile.isEmpty()) {
				String mobileMainSavePath = EgovProperties.getProperty("PROMOTION.MOBILE.MAIN.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("mobileMainImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(mobileMainImgFile, newFileName, mobileMainSavePath);

				prmtVO.setMobileMainImg(mobileMainSavePath + newFileName);
			}
			// 목록 이미지
			MultipartFile listImgFile = multiRequest.getFile("listImgFile");

			if(listImgFile != null && !listImgFile.isEmpty()) {
				String listSavePath = EgovProperties.getProperty("PROMOTION.LIST.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("listImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(listImgFile, newFileName, listSavePath);

				prmtVO.setListImg(listSavePath + newFileName);
			}
			// 상세 이미지
			MultipartFile detailImgFile = multiRequest.getFile("detailImgFile");

			if(detailImgFile!= null && !detailImgFile.isEmpty()) {
				String detailSavePath = EgovProperties.getProperty("PROMOTION.DTL.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("detailImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(detailImgFile, newFileName, detailSavePath);

				prmtVO.setDtlImg(detailSavePath + newFileName);
			}
			// 모바일 상세 이미지
			MultipartFile mobileDtlImgFile = multiRequest.getFile("mobileDtlImgFile");

			if(mobileDtlImgFile != null && !mobileDtlImgFile.isEmpty()) {
				String mobileDtlSavePath = EgovProperties.getProperty("PROMOTION.MOBILE.DTL.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("mobileDtlImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(mobileDtlImgFile, newFileName, mobileDtlSavePath);

				prmtVO.setMobileDtlImg(mobileDtlSavePath + newFileName);
			}
			// 상세 배경 이미지
			MultipartFile dtlBgImgFile = multiRequest.getFile("dtlBgImgFile");

			if(dtlBgImgFile != null && !dtlBgImgFile.isEmpty()) {
				String dtlBgSavePath = EgovProperties.getProperty("PROMOTION.DTL.SAVEDFILE");
				String newFileName = prmtNum + "_bg." + FilenameUtils.getExtension(multiRequest.getFile("dtlBgImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(dtlBgImgFile, newFileName, dtlBgSavePath);

				prmtVO.setDtlBgImg(dtlBgSavePath + newFileName);
			}
			// 모바일 상세 배경 이미지
			MultipartFile mobileDtlBgImgFile = multiRequest.getFile("mobileDtlBgImgFile");

			if(mobileDtlBgImgFile != null && !mobileDtlBgImgFile.isEmpty()) {
				String mobileDtlBgSavePath = EgovProperties.getProperty("PROMOTION.MOBILE.DTL.SAVEDFILE");
				String newFileName = prmtNum + "_bg." + FilenameUtils.getExtension(multiRequest.getFile("mobileDtlBgImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(mobileDtlBgImgFile, newFileName, mobileDtlBgSavePath);

				prmtVO.setMobileDtlBgImg(mobileDtlBgSavePath + newFileName);
			}
			// 당첨자 이미지
			MultipartFile winsImgFile = multiRequest.getFile("winsImgFile");

			if(winsImgFile != null && !winsImgFile.isEmpty()) {
				String winsSavePath = EgovProperties.getProperty("PROMOTION.WINS.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("winsImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(winsImgFile, newFileName, winsSavePath);

				prmtVO.setWinsImg(winsSavePath + newFileName);
			}
			//첨부파일 올리기
			ossFileUtilService.uploadPrmtFile(multiRequest, EgovProperties.getProperty("PROMOTION.FILE.SAVEDFILE"), prmtNum);

			prmtVO.setStatusCd(Constant.TRADE_STATUS_APPR);

			prmtDAO.insertPromotionOss(prmtVO);
		}
		return prmtNum;
	}

	@Override
	public void insertPrmtPrdt(PRMTVO prmtVO) {
		prmtDAO.insertPrmtPrdt(prmtVO);
	}

	@Override
	public void insertPrmtPrdtOne(PRMTVO prmtVO) {
		prmtDAO.insertPrmtPrdtOne(prmtVO);
	}


	@Override
	public void insertPrmtPrdt(PRMTPRDTVO prmtPrdtVO) {
		prmtDAO.insertPrmtPrdt(prmtPrdtVO);
	}

	/**
	 * 프로모션 상품의 출력 순서 수정
	 * Function : updatePrmtPrdtSort
	 * 작성일 : 2017. 7. 7. 오후 5:37:22
	 * 작성자 : 정동수
	 * @param prmtPrdtVO
	 */
	@Override
	public void updatePrmtPrdtSort(PRMTPRDTVO prmtPrdtVO) {
		// 증가
		if (prmtPrdtVO.getOldSn() > prmtPrdtVO.getNewSn())
			prmtDAO.incremntPrmtPrintSn(prmtPrdtVO);
		// 감소
		if (prmtPrdtVO.getOldSn() < prmtPrdtVO.getNewSn())
			prmtDAO.downPrmtPrintSn(prmtPrdtVO);

		prmtDAO.updatePrmtPrintSn(prmtPrdtVO);
	}

	@Override
	public PRMTVO selectByPrmt(PRMTVO prmtVO) {
		return prmtDAO.selectByPrmt(prmtVO);
	}

	@Override
	public List<PRMTPRDTVO> selectPrmtPrdtList(PRMTVO prmtVO) {
		return prmtDAO.selectPrmtPrdtList(prmtVO);
	}

	@Override
	public List<PRMTPRDTVO> selectPrmtPrdtListOss(PRMTVO prmtVO) {
		return prmtDAO.selectPrmtPrdtListOss(prmtVO);
	}

	@Override
	public void updatePromotion(PRMTVO prmtVO,
								MultipartHttpServletRequest multiRequest,
								String type) throws Exception {
		String prmtNum = prmtVO.getPrmtNum();
		prmtVO.setPrmtNum(prmtNum);

		if("mas".equals(type)) {
			prmtDAO.updatePromotion(prmtVO);
		} else {
			// 메인 배너
			MultipartFile mainImgFile = multiRequest.getFile("mainImgFile") ;

			if(!mainImgFile.isEmpty()) {
				String mainSavePath = EgovProperties.getProperty("PROMOTION.MAIN.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("mainImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(mainImgFile, newFileName, mainSavePath);

				prmtVO.setMainImg(mainSavePath + newFileName);
			}
			// 모바일 메인 배너
			MultipartFile mobileMainImgFile = multiRequest.getFile("mobileMainImgFile") ;

			if(!mobileMainImgFile.isEmpty()) {
				String mobileMainSavePath = EgovProperties.getProperty("PROMOTION.MOBILE.MAIN.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("mobileMainImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(mobileMainImgFile, newFileName, mobileMainSavePath);

				prmtVO.setMobileMainImg(mobileMainSavePath + newFileName);
			}
			// 목록 이미지
			MultipartFile listImgFile = multiRequest.getFile("listImgFile") ;

			if(!listImgFile.isEmpty()) {
				String listSavePath = EgovProperties.getProperty("PROMOTION.LIST.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("listImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(listImgFile, newFileName, listSavePath);

				prmtVO.setListImg(listSavePath + newFileName);
			}
			// 상세 이미지
			MultipartFile detailImgFile = multiRequest.getFile("dtlImgFile") ;

			if(!detailImgFile.isEmpty()) {
				String detailSavePath = EgovProperties.getProperty("PROMOTION.DTL.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("dtlImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(detailImgFile, newFileName, detailSavePath);

				prmtVO.setDtlImg(detailSavePath + newFileName);
			}
			// 모바일 상세 이미지
			MultipartFile mobileDtlImgFile = multiRequest.getFile("mobileDtlImgFile") ;

			if(!mobileDtlImgFile.isEmpty()) {
				String mobileDtlSavePath = EgovProperties.getProperty("PROMOTION.MOBILE.DTL.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("mobileDtlImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(mobileDtlImgFile, newFileName, mobileDtlSavePath);

				prmtVO.setMobileDtlImg(mobileDtlSavePath + newFileName);
			}
			// 상세 배경 이미지
			MultipartFile dtlBgImgFile = multiRequest.getFile("dtlBgImgFile");

			if(dtlBgImgFile != null && !dtlBgImgFile.isEmpty()) {
				String dtlBgSavePath = EgovProperties.getProperty("PROMOTION.DTL.SAVEDFILE");
				String newFileName = prmtNum + "_bg." + FilenameUtils.getExtension(multiRequest.getFile("dtlBgImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(dtlBgImgFile, newFileName, dtlBgSavePath);

				prmtVO.setDtlBgImg(dtlBgSavePath + newFileName);
			}
			// 모바일 상세 배경 이미지
			MultipartFile mobileDtlBgImgFile = multiRequest.getFile("mobileDtlBgImgFile");

			if(mobileDtlBgImgFile != null && !mobileDtlBgImgFile.isEmpty()) {
				String mobileDtlBgSavePath = EgovProperties.getProperty("PROMOTION.MOBILE.DTL.SAVEDFILE");
				String newFileName = prmtNum + "_bg." + FilenameUtils.getExtension(multiRequest.getFile("mobileDtlBgImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(mobileDtlBgImgFile, newFileName, mobileDtlBgSavePath);

				prmtVO.setMobileDtlBgImg(mobileDtlBgSavePath + newFileName);
			}
			// 당첨자 이미지
			MultipartFile winsImgFile = multiRequest.getFile("winsImgFile") ;

			if(!winsImgFile.isEmpty()) {
				String winsSavePath = EgovProperties.getProperty("PROMOTION.WINS.SAVEDFILE");
				String newFileName = prmtNum + "." + FilenameUtils.getExtension(multiRequest.getFile("winsImgFile").getOriginalFilename());

				ossFileUtilService.uploadFile(winsImgFile, newFileName, winsSavePath);

				prmtVO.setWinsImg(winsSavePath + newFileName);
			}
			//첨부파일 올리기
			ossFileUtilService.uploadPrmtFile(multiRequest, EgovProperties.getProperty("PROMOTION.FILE.SAVEDFILE"), prmtNum);

			prmtDAO.updatePromotionOss(prmtVO);
		}
	}

	@Override
	public void deletePrmtPrdt(String prmtNum) {
		prmtDAO.deletePrmtPrdt(prmtNum);

	}

	@Override
	public void updatePrmtStatusCd(PRMTVO prmtVO) {
		prmtDAO.updatePrmtStatusCd(prmtVO);

	}

	@Override
	public void deletePromotion(PRMTVO prmtVO) {
		prmtDAO.deletePromotion(prmtVO);
	}

	@Override
	public List<MAINPRMTVO> selectMainPrmtFromPrmtNum(MAINPRMTVO mainPrmtVO) {
		return prmtDAO.selectMainPrmtFromPrmtNum(mainPrmtVO);
	}

	@Override
	public List<MAINPRMTVO> selectMainPrmt(MAINPRMTVO mainPrmtVO) {
		return prmtDAO.selectMainPrmt(mainPrmtVO);
	}

	@Override
	@Cacheable(value = "mainPrmtCache", key = "'main'")
	public List<MAINPRMTVO> selectMainPrmtMain(MAINPRMTVO mainPrmtVO) {
		return prmtDAO.selectMainPrmtMain(mainPrmtVO);
	}
	
	@Override
	public MAINPRMTVO selectMainPrmtInfo(MAINPRMTVO mainPrmtVO) {
		return prmtDAO.selectMainPrmtInfo(mainPrmtVO);
	}

	@Override
	public void addPrintSn(MAINPRMTVO mainPrmtVO) {
		prmtDAO.addPrintSn(mainPrmtVO);

	}

	@Override
	public void minusPrintSn(MAINPRMTVO mainPrmtVO) {
		prmtDAO.minusPrintSn(mainPrmtVO);
	}

	@Override
	public void updateDtlPrintSn(MAINPRMTVO mainPrmtVO) {
		if(mainPrmtVO.getOldSn() > mainPrmtVO.getNewSn()){
			// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
			addPrintSn(mainPrmtVO);
		}else{
			minusPrintSn(mainPrmtVO);
		}
		prmtDAO.updatePrintSn(mainPrmtVO);
	}

	@Override
	public void insertMainPrmt(MAINPRMTVO mainPrmtVO) {
		mainPrmtVO.setNewSn( Integer.parseInt(mainPrmtVO.getPrintSn()) );

		addPrintSn(mainPrmtVO);

		prmtDAO.insertMainPrmt(mainPrmtVO);

	}

	@Override
	public void deleteMainPrmt(MAINPRMTVO mainPrmtVO) {
		prmtDAO.deleteMainPrmt(mainPrmtVO);

		mainPrmtVO.setOldSn(Integer.parseInt(mainPrmtVO.getPrintSn()));
		minusPrintSn(mainPrmtVO);
	}

	@Override
	public Integer getCntPrmtMain(PRMTVO prmtVO) {
		return prmtDAO.getCntPrmtMain(prmtVO);
	}

	@Override
	public Integer getCntPrmtOssMain(PRMTVO prmtVO) {
		return prmtDAO.getCntPrmtOssMain(prmtVO);
	}

	/**
	 * 기념품 프로모션
	 * 파일명 : selectSvPrmt
	 * 작성일 : 2017. 2. 16. 오후 1:39:50
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 * @return
	 */
	@Override
	public List<MAINPRMTVO> selectSvPrmt(MAINPRMTVO mainPrmtVO){
		return prmtDAO.selectSvPrmt(mainPrmtVO);
	}
	
	/**
	 * 기념품 프로모션 웹 출력
	 * Function : selectSvPrmtWeb
	 * 작성일 : 2018. 1. 8. 오전 10:14:22
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	@Override
	public List<MAINPRMTVO> selectSvPrmtWeb(MAINPRMTVO mainPrmtVO){
		return prmtDAO.selectSvPrmtWeb(mainPrmtVO);
	}
	
	/**
	 * 기념품 프로모션 정보
	 * Function : selectSvPrmtInfo
	 * 작성일 : 2018. 1. 11. 오전 10:14:20
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	@Override
	public MAINPRMTVO selectSvPrmtInfo(MAINPRMTVO mainPrmtVO){
		return prmtDAO.selectSvPrmtInfo(mainPrmtVO);
	}

	/**
	 * 기념품 프로모션 삭제
	 * 파일명 : deleteSvPrmt
	 * 작성일 : 2017. 2. 16. 오후 1:55:13
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	@Override
	public void deleteSvPrmt(MAINPRMTVO mainPrmtVO){
		prmtDAO.deleteSvPrmt(mainPrmtVO);
		
		mainPrmtVO.setOldSn(Integer.parseInt(mainPrmtVO.getPrintSn()));
		minusPrintSv(mainPrmtVO);
	}

	/**
	 * 기념품 프로모션 조회
	 * 파일명 : selectSvPrmtFromPrmtNum
	 * 작성일 : 2017. 2. 16. 오후 2:05:37
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 * @return
	 */
	@Override
	public List<MAINPRMTVO> selectSvPrmtFromPrmtNum(MAINPRMTVO mainPrmtVO){
		return prmtDAO.selectSvPrmtFromPrmtNum(mainPrmtVO);
	}

	/**
	 * 기념품 프로모션 등록
	 * 파일명 : insertSvPrmt
	 * 작성일 : 2017. 2. 16. 오후 2:09:46
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	@Override
	public void insertSvPrmt(MAINPRMTVO mainPrmtVO){
		mainPrmtVO.setNewSn( Integer.parseInt(mainPrmtVO.getPrintSn()) );

		addPrintSn(mainPrmtVO);

		prmtDAO.insertSvPrmt(mainPrmtVO);
	}

	/**
	 * 기념품 프로모션 순번 변경
	 * 파일명 : updateSvDtlPrintSn
	 * 작성일 : 2017. 2. 16. 오후 2:17:18
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	@Override
	public void updateDtlPrintSv(MAINPRMTVO mainPrmtVO) {
		if(mainPrmtVO.getOldSn() > mainPrmtVO.getNewSn()){
			// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
			addPrintSv(mainPrmtVO);
		}else{
			minusPrintSv(mainPrmtVO);
		}
		prmtDAO.updatePrintSv(mainPrmtVO);
	}
	
	/**
	 * 순번 증가
	 * 파일명 : addPrintSv
	 * 작성일 : 2017. 2. 16. 오후 2:34:36
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	@Override
	public void addPrintSv(MAINPRMTVO mainPrmtVO) {
		prmtDAO.addPrintSv(mainPrmtVO);

	}

	/**
	 * 순번 감소
	 * 파일명 : minusPrintSv
	 * 작성일 : 2017. 2. 16. 오후 2:35:22
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	@Override
	public void minusPrintSv(MAINPRMTVO mainPrmtVO) {
		prmtDAO.minusPrintSv(mainPrmtVO);
	}
	
	/**
	 * 모바일 프로모션
	 * 파일명 : selectMwPrmt
	 * 작성일 : 2017. 12. 22. 오후 1:39:50
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	@Override
	public List<MAINPRMTVO> selectMwPrmt(MAINPRMTVO mainPrmtVO){
		return prmtDAO.selectMwPrmt(mainPrmtVO);
	}
	
	/**
	 * 모바일 프로모션 정보
	 * Function : selectMwPrmtInfo
	 * 작성일 : 2018. 1. 11. 오전 10:19:21
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	@Override
	public MAINPRMTVO selectMwPrmtInfo(MAINPRMTVO mainPrmtVO){
		return prmtDAO.selectMwPrmtInfo(mainPrmtVO);
	}

	/**
	 * 모바일 프로모션 삭제
	 * 파일명 : deleteMwPrmt
	 * 작성일 : 2017. 12. 22. 오후 1:55:13
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	@Override
	public void deleteMwPrmt(MAINPRMTVO mainPrmtVO){
		prmtDAO.deleteMwPrmt(mainPrmtVO);
		
		mainPrmtVO.setOldSn(Integer.parseInt(mainPrmtVO.getPrintSn()));
		minusPrintMw(mainPrmtVO);
	}

	/**
	 * 모바일 프로모션 조회
	 * 파일명 : selectMwPrmtFromPrmtNum
	 * 작성일 : 2017. 12. 22. 오후 2:05:37
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	@Override
	public List<MAINPRMTVO> selectMwPrmtFromPrmtNum(MAINPRMTVO mainPrmtVO){
		return prmtDAO.selectMwPrmtFromPrmtNum(mainPrmtVO);
	}

	/**
	 * 모바일 프로모션 등록
	 * 파일명 : insertMwPrmt
	 * 작성일 : 2017. 12. 22. 오후 2:09:46
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	@Override
	public void insertMwPrmt(MAINPRMTVO mainPrmtVO){
		mainPrmtVO.setNewSn( Integer.parseInt(mainPrmtVO.getPrintSn()) );

		addPrintSn(mainPrmtVO);

		prmtDAO.insertMwPrmt(mainPrmtVO);
	}

	/**
	 * 모바일 프로모션 순번 변경
	 * 파일명 : updateDtlPrintMw
	 * 작성일 : 2017. 12. 22. 오후 2:17:18
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	@Override
	public void updateDtlPrintMw(MAINPRMTVO mainPrmtVO) {
		if(mainPrmtVO.getOldSn() > mainPrmtVO.getNewSn()){
			// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
			addPrintMw(mainPrmtVO);
		}else{
			minusPrintMw(mainPrmtVO);
		}
		prmtDAO.updatePrintMw(mainPrmtVO);
	}

	/**
	 * 모바일 프로모션 순번 증가
	 * 파일명 : addPrintMw
	 * 작성일 : 2017. 12. 22. 오후 2:34:36
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	@Override
	public void addPrintMw(MAINPRMTVO mainPrmtVO) {
		prmtDAO.addPrintMw(mainPrmtVO);

	}

	/**
	 * 모바일 프로모션 순번 감소
	 * 파일명 : minusPrintMw
	 * 작성일 : 2017. 12. 22. 오후 2:35:22
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	@Override
	public void minusPrintMw(MAINPRMTVO mainPrmtVO) {
		prmtDAO.minusPrintMw(mainPrmtVO);
	}

	/**
	 * 이벤트 정보 리스트 조회
	 * 파일명 : selectEvntInfListOss
	 * 작성일 : 2017. 3. 9. 오후 3:30:57
	 * 작성자 : 최영철
	 * @param evntInfSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectEvntInfListOss(EVNTINFSVO evntInfSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<EVNTINFVO> resultList = prmtDAO.selectEvntInfListOss(evntInfSVO);
		Integer totalCnt = prmtDAO.selectEvntInfListCnt(evntInfSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;

	}

	/**
	 * 이벤트 정보 등록
	 * 파일명 : insertEvntInf
	 * 작성일 : 2017. 3. 10. 오후 2:42:05
	 * 작성자 : 최영철
	 * @param evntInfVO
	 */
	@Override
	public void insertEvntInf(EVNTINFVO evntInfVO){
		prmtDAO.insertEvntInf(evntInfVO);
	}

	/**
	 * 이벤트 정보 단건 조회
	 * 파일명 : selectByEvntInf
	 * 작성일 : 2017. 3. 10. 오후 3:33:21
	 * 작성자 : 최영철
	 * @param evntInfVO
	 * @return
	 */
	@Override
	public EVNTINFVO selectByEvntInf(EVNTINFVO evntInfVO){
		return prmtDAO.selectByEvntInf(evntInfVO);
	}

	@Override
	public void updateEvntInf(EVNTINFVO evntInfVO){
		prmtDAO.updateEvntInf(evntInfVO);
	}

	/**
	 * 이벤트 정보 삭제
	 * 파일명 : deleteEvntInf
	 * 작성일 : 2017. 3. 10. 오후 5:34:01
	 * 작성자 : 최영철
	 * @param evntInfVO
	 */
	@Override
	public void deleteEvntInf(EVNTINFVO evntInfVO){
		prmtDAO.deleteEvntInf(evntInfVO);
	}

	@Override
	public void deletePrmtFile(String prmtFileNum) {
		prmtDAO.deletePrmtFile(prmtFileNum);

	}

	@Override
	public void deletePrmtFileAll(String prmtNum) {
		prmtDAO.deletePrmtFileAll(prmtNum);

	}

	@Override
	public List<PRMTFILEVO> selectPrmtFileList(PRMTFILEVO prmtfileVO) {
		return prmtDAO.selectPrmtFileList(prmtfileVO);
	}

	@Override
	public PRMTFILEVO selectPrmtFile(PRMTFILEVO prmtfileVO) {
		return prmtDAO.selectPrmtFile(prmtfileVO);
	}

	@Override
	public void deletePrmtCmtAll(String prmtNum) {
		prmtDAO.deletePrmtCmtAll(prmtNum);
	}


	@Override
	public Map<String, Object> selectFileList(FILESVO fileSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<FILESVO> resultList = prmtDAO.selectFileList(fileSVO);

		Integer totalCnt = prmtDAO.selectFileListCnt(fileSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	/**
	* 설명 : 메인 프로모션 순번을 랜덤으로 변경
	* 파일명 : updatePrmtSnRandom
	* 작성일 : 2022-03-31 오후 5:45
	* 작성자 : chaewan.jung
	* @param : MAINPRMTVO
	* @return : void
	* @throws Exception
	*/
	public void updatePrmtSnRandom(MAINPRMTVO mainPrmtVO){
		prmtDAO.updatePrmtSnRandom(mainPrmtVO);
	}
}
