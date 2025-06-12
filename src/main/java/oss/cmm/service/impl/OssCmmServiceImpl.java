package oss.cmm.service.impl;

import java.io.File;
import java.util.*;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mas.rc.service.impl.RcDAO;
import mas.rc.vo.RC_DFTINFVO;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.*;
import oss.corp.service.impl.CorpDAO;
import oss.corp.vo.CMSSPGVO;
import oss.corp.vo.CMSSVO;
import oss.corp.vo.CORPVO;
import oss.etc.vo.FILESVO;
import oss.prdt.service.impl.PrdtDAO;
import oss.prdt.vo.PRDTVO;
import oss.user.vo.USERVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("ossCmmService")
public class OssCmmServiceImpl extends EgovAbstractServiceImpl implements OssCmmService {

	private static final Logger LOGGER = LoggerFactory.getLogger(OssCmmServiceImpl.class);

	/** CorpDAO */
	@Resource(name = "corpDAO")
	private CorpDAO corpDAO;

	/** RcDAO */
	@Resource(name = "rcDAO")
	private RcDAO rcDAO;


	/** CdDAO */
	@Resource(name = "cdDAO")
	private CdDAO cdDAO;

	@Resource(name = "cmmImgDAO")
	private CmmImgDAO cmmImgDAO;

	@Resource(name = "cmmDtlImgDAO")
	private CmmDtlImgDAO cmmDtlImgDAO;

	@Resource(name="cmmConfhistDAO")
	private CmmConfhistDAO cmmConfhistDAO;

	@Resource(name="cmmIconinfDAO")
	private CmmIconinfDAO cmmIconinfDAO;

	@Resource(name="cmmSrchWordDAO")
	private CmmSrchWordDAO cmmSrchWordDAO;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name="cmssDAO")
	private CmssDAO cmssDAO;

	@Resource(name="prdtDAO")
	private PrdtDAO prdtDAO;

	@Override
	public String corpDtlInfoChk(CORPVO corpVO){
		CORPVO resultVO = corpDAO.selectByCorp(corpVO);

		String chkString = "N";
		// RC : 렌트카
		if("RC".equals(resultVO.getCorpCd())){
			RC_DFTINFVO rcSVO = new RC_DFTINFVO();
			rcSVO.setCorpId(resultVO.getCorpId());

			RC_DFTINFVO rcVO = rcDAO.selectByRcInfo(rcSVO);

			if(rcVO.getCorpId() != null){
				chkString = "Y";
			}
		}

		return chkString;
	}

	/**
	 * 코드 리스트 조회
	 * 파일명 : selectCodeList
	 * 작성일 : 2015. 9. 23. 오전 8:57:19
	 * 작성자 : 최영철
	 * @param cdSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectCodeList(CDSVO cdSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<CDVO> resultList = cdDAO.selectCodeList(cdSVO);
		Integer totalCnt = cdDAO.getCntCodeList(cdSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	/**
	 * 코드 등록
	 * 파일명 : insertCode
	 * 작성일 : 2015. 9. 23. 오후 1:28:52
	 * 작성자 : 최영철
	 * @param cdVO
	 */
	@Override
	public void insertCode(CDVO cdVO){
		cdDAO.insertCode(cdVO);
	}

	/**
	 * 최상위 코드 전체 조회(사용여부가 'Y' 인것만)
	 * 파일명 : selectHrkCodeList
	 * 작성일 : 2015. 9. 23. 오후 1:40:57
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<CDVO> selectHrkCodeList(){
		return cdDAO.selectHrkCodeList();
	}

	/**
	 * 코드 단건 조회
	 * 파일명 : selectByCd
	 * 작성일 : 2015. 9. 23. 오후 2:25:27
	 * 작성자 : 최영철
	 * @param cdVO
	 * @return
	 */
	@Override
	public CDVO selectByCd(CDVO cdVO){
		return cdDAO.selectByCd(cdVO);
	}

	/**
	 * 코드 수정
	 * 파일명 : updateCode
	 * 작성일 : 2015. 9. 23. 오후 2:55:46
	 * 작성자 : 최영철
	 * @param cdVO
	 */
	@Override
	public void updateCode(CDVO cdVO){
		cdDAO.updateCode(cdVO);
	}

	/**
	 * 노출 순번 최대 값 구하기
	 * 파일명 : selectByMaxViewSn
	 * 작성일 : 2015. 9. 23. 오후 4:51:15
	 * 작성자 : 최영철
	 * @param cdVO
	 * @return
	 */
	@Override
	public Integer selectByMaxViewSn(CDVO cdVO){
		return cdDAO.selectByMaxViewSn(cdVO);
	}

	/**
	 * 노출 순번 일괄 증가
	 * 파일명 : addViewSn
	 * 작성일 : 2015. 9. 23. 오후 5:03:04
	 * 작성자 : 최영철
	 * @param oldVO
	 */
	@Override
	public void addViewSn(CDVO oldVO){
		cdDAO.addViewSn(oldVO);
	}

	/**
	 * 노출 순번 일괄 감소
	 * 파일명 : minusViewSn
	 * 작성일 : 2015. 9. 23. 오후 5:11:43
	 * 작성자 : 최영철
	 * @param oldVO
	 */
	@Override
	public void minusViewSn(CDVO oldVO){
		cdDAO.minusViewSn(oldVO);
	}

	/**
	 * 코드 삭제
	 * 파일명 : deleteCode
	 * 작성일 : 2015. 9. 25. 오후 1:46:03
	 * 작성자 : 최영철
	 * @param cdVO
	 */
	@Override
	public void deleteCode(CDVO cdVO){
		cdDAO.deleteCode(cdVO);
	}

	/**
	 * 상위 코드에 대한 하위 코드 조회
	 * 파일명 : selectCode
	 * 작성일 : 2015. 10. 1. 오후 7:48:49
	 * 작성자 : 최영철
	 * @param corpCd
	 * @return
	 */
	@Override
	public List<CDVO> selectCode(String corpCd){
		CDSVO cdSVO = new CDSVO();
		cdSVO.setsHrkCdNum(corpCd);
		return cdDAO.selectCode(cdSVO);
	}

	/**
	 * 연계 번호에 대한 이미지 리스트 조회
	 * 파일명 : selectImgList
	 * 작성일 : 2015. 10. 7. 오후 5:24:51
	 * 작성자 : 최영철
	 * @param imgVO
	 * @return
	 */
	@Override
	public List<CM_IMGVO> selectImgList(CM_IMGVO imgVO){
		return cmmImgDAO.selectImgList(imgVO);
	}

	/**
	 * 이미지 순번 증가
	 * 파일명 : addImgSn
	 * 작성일 : 2015. 10. 7. 오후 7:38:09
	 * 작성자 : 최영철
	 * @param imgVO
	 */
	@Override
	public void addImgSn(CM_IMGVO imgVO){
		cmmImgDAO.addImgSn(imgVO);
	}

	/**
	 * 이미지 순번 감소
	 * 파일명 : minusImgSn
	 * 작성일 : 2015. 10. 7. 오후 7:44:06
	 * 작성자 : 최영철
	 * @param imgVO
	 */
	@Override
	public void minusImgSn(CM_IMGVO imgVO){
		cmmImgDAO.minusImgSn(imgVO);
	}

	/**
	 * 이미지 순번 변경
	 * 파일명 : updateImgSn
	 * 작성일 : 2015. 10. 7. 오후 7:47:27
	 * 작성자 : 최영철
	 * @param imgVO
	 */
	@Override
	public void updateImgSn(CM_IMGVO imgVO){
		if(imgVO.getOldSn() > imgVO.getNewSn()){
			// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
			addImgSn(imgVO);
		}else{
			minusImgSn(imgVO);
		}
		cmmImgDAO.updateImgSn(imgVO);
	}

	/**
	 * 이미지 정보 조회
	 * 파일명 : selectByPrdtImg
	 * 작성일 : 2015. 10. 7. 오후 8:53:05
	 * 작성자 : 최영철
	 * @param imgVO
	 * @return
	 */
	@Override
	public CM_IMGVO selectByPrdtImg(CM_IMGVO imgVO){
		return cmmImgDAO.selectByPrdtImg(imgVO);
	}

	/**
	 * 이미지 정보 삭제
	 * 파일명 : deletePrdtImg
	 * 작성일 : 2015. 10. 7. 오후 8:59:24
	 * 작성자 : 최영철
	 * @param imgVO
	 * @throws Exception
	 */
	@Override
	public void deletePrdtImg(CM_IMGVO imgVO) throws Exception{
		CM_IMGVO imgInfo = selectByPrdtImg(imgVO);

		// 이미지 파일 삭제
    	ossFileUtilService.deleteImgFile(imgInfo);

    	cmmImgDAO.deletePrdtImg(imgVO);

    	imgVO.setOldSn(Integer.parseInt(imgVO.getImgSn()));
    	minusImgSn(imgVO);
	}

	/**
	 * 이미지 정보 삭제
	 * 파일명 : deletePrdtImg
	 * 작성일 : 2015. 10. 7. 오후 8:59:24
	 * 작성자 : 최영철
	 * @param imgVO
	 * @throws Exception
	 */
	@Override
	public void deletePrdtImgList(CM_IMGVO imgVO) throws Exception{
		List<CM_IMGVO> imgInfoList = selectImgList(imgVO);

		// 이미지 파일 삭제
		for(CM_IMGVO imgInfo : imgInfoList)
			ossFileUtilService.deleteImgFile(imgInfo);

    	cmmImgDAO.deletePrdtImg(imgVO);
	}

	/**
	 * 이미지 정보 등록
	 * 파일명 : insertPrdtimg
	 * 작성일 : 2015. 10. 8. 오전 10:11:50
	 * 작성자 : 최영철
	 * @param imgVO
	 * @throws Exception
	 */
	@Override
	public void insertPrdtimg(CM_IMGVO imgVO, MultipartHttpServletRequest multiRequest) throws Exception{
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		String savePath = EgovProperties.getProperty("PRODUCT." + corpInfo.getCorpCd() + ".SAVEDFILE");

		Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				LOGGER.debug("entry.getKey() ::: " + entry.getKey());
				// 상품 상세 이미지가 아닌 갤러리형만 등록
				if(!"prdtDtlImgFile".equals(entry.getKey())){
					file = entry.getValue();
					String fileName = file.getOriginalFilename();

					// FileName 이 존재할때
					if(!"".equals(file.getOriginalFilename())){
						String ext = FilenameUtils.getExtension(fileName);
						// 이미지 확장자 체크
						if(!ossFileUtilService.imageCheck(ext)) {
							LOGGER.info("이미지 파일이 아닙니다.");

						}else{
							String imgNum = cmmImgDAO.selectImgNum(imgVO.getLinkNum());
							String newIfleNm = imgVO.getLinkNum() + "_" + imgNum + "." + ext;
							ossFileUtilService.uploadImgFile(file, newIfleNm, savePath);

							imgVO.setNewSn(Integer.parseInt(imgVO.getImgSn()));

							addImgSn(imgVO);

							imgVO.setImgNum(imgNum);
							imgVO.setSavePath(savePath);
							imgVO.setRealFileNm(fileName);
							imgVO.setSaveFileNm(newIfleNm);

							cmmImgDAO.insertImg2(imgVO);
						}

					}
				}
			}
		}
	}

	/**
	 * 이미지 정보 복사
	 * 파일명 : insertPrdtimg
	 * 작성일 : 2015. 10. 8. 오전 10:11:50
	 * 작성자 : 최영철
	 * @param imgVO
	 * @throws Exception
	 */
	@Override
	public void insertPrdtimgCopy(CM_IMGVO imgVO) throws Exception{
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		String savePath = EgovProperties.getProperty("PRODUCT." + corpInfo.getCorpCd() + ".SAVEDFILE");

		List<CM_IMGVO> cmmImgList = cmmImgDAO.selectImgList(imgVO);

			for (CM_IMGVO img : cmmImgList) {

				String orifileNm = img.getSavePath() + img.getSaveFileNm();
				String ext =  FilenameUtils.getExtension(orifileNm);
				String imgNum = cmmImgDAO.selectImgNum(imgVO.getNewLinkNum());
				String newFileNm = imgVO.getNewLinkNum() + "_" + imgNum + "." + ext;

				ossFileUtilService.copyPrdtImgFile(img.getSaveFileNm(), img.getSavePath(), newFileNm, savePath);

				imgVO.setLinkNum(imgVO.getNewLinkNum());
				imgVO.setImgNum(imgNum);

				imgVO.setSavePath(savePath);
				imgVO.setRealFileNm(img.getRealFileNm());
				imgVO.setSaveFileNm(newFileNm);

				cmmImgDAO.insertImg(imgVO);
			}
	}

	@Override
	public void insertCmConfhist(CM_CONFHISTVO confhistVO) {
		String histNum = cmmConfhistDAO.selectHistNum(confhistVO.getLinkNum());
		confhistVO.setHistNum(histNum);

		cmmConfhistDAO.insertConfhist(confhistVO);
	}



	/**
	 * 상세 이미지 목록
	 * 파일명 : selectDtlImgList
	 * 작성일 : 2015. 10. 20. 오후 5:46:39
	 * 작성자 : 신우섭
	 * @param imgVO
	 * @return
	 */
	@Override
	public List<CM_DTLIMGVO> selectDtlImgList(CM_DTLIMGVO imgVO){
		return cmmDtlImgDAO.selectImgList(imgVO);
	}

	@Override
	public CM_DTLIMGVO selectByPrdtDtlImg(CM_DTLIMGVO imgVO){
		return cmmDtlImgDAO.selectByPrdtImg(imgVO);
	}



	@Override
	public void insertPrdtDtlimg(CM_DTLIMGVO imgVO, MultipartHttpServletRequest multiRequest) throws Exception{
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		String savePath = EgovProperties.getProperty("PRODUCT." + corpInfo.getCorpCd() + ".SAVEDFILE");

		Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			// 파일이 존재함
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;

			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				LOGGER.debug("entry.getKey() ::: " + entry.getKey());

				// 상품 상세 이미지가 아닌 갤러리형만 등록
				if("dtlImgPC".equals(entry.getKey()) && "Y".equals( imgVO.getPcImgYn() ) ){
					savePath += "pc/";

					file = entry.getValue();
					String fileName = file.getOriginalFilename();
					//LOGGER.debug(">>>>>>>>>>>>>>>>>>>>>>Y::: "+savePath+":" + fileName + "]");

					// FileName 이 존재할때
					if(!"".equals(file.getOriginalFilename())){
						String ext = FilenameUtils.getExtension(fileName);
						// 이미지 확장자 체크
						if(!ossFileUtilService.imageCheck(ext)) {
							LOGGER.info("이미지 파일이 아닙니다.");

						}else{
							String imgNum = cmmDtlImgDAO.selectImgNum(imgVO.getLinkNum());
							String newIfleNm = imgVO.getLinkNum() + "_" + imgNum + "." + ext;
							ossFileUtilService.uploadImgFile(file, newIfleNm, savePath);

							imgVO.setNewSn(Integer.parseInt(imgVO.getImgSn()));

							addDtlImgSn(imgVO);

							imgVO.setImgNum(imgNum);
							imgVO.setSavePath(savePath);
							imgVO.setRealFileNm(fileName);
							imgVO.setSaveFileNm(newIfleNm);

							cmmDtlImgDAO.insertImg2(imgVO);

						}

					}

				}else if("dtlImgM".equals(entry.getKey()) && "N".equals( imgVO.getPcImgYn() )){
					savePath += "m/";

					file = entry.getValue();
					String fileName = file.getOriginalFilename();
					//LOGGER.debug(">>>>>>>>>>>>>>>>>>>>>>N::: "+savePath+":" + fileName + "]");

					// FileName 이 존재할때
					if(!"".equals(file.getOriginalFilename())){
						String ext = FilenameUtils.getExtension(fileName);
						// 이미지 확장자 체크
						if(!ossFileUtilService.imageCheck(ext)) {
							LOGGER.info("이미지 파일이 아닙니다.");

						}else{
							String imgNum = cmmDtlImgDAO.selectImgNum(imgVO.getLinkNum());
							String newIfleNm = imgVO.getLinkNum() + "_" + imgNum + "." + ext;
							ossFileUtilService.uploadImgFile(file, newIfleNm, savePath);

							imgVO.setNewSn(Integer.parseInt(imgVO.getImgSn()));

							addDtlImgSn(imgVO);

							imgVO.setImgNum(imgNum);
							imgVO.setSavePath(savePath);
							imgVO.setRealFileNm(fileName);
							imgVO.setSaveFileNm(newIfleNm);

							cmmDtlImgDAO.insertImg2(imgVO);
						}

					}
				}
			}
		}
	}

	@Override
	public void insertPrdtDtlimgCopy(CM_DTLIMGVO imgVO) throws Exception{
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		List<CM_DTLIMGVO> cmmImgList = cmmDtlImgDAO.selectImgList(imgVO);

			for (CM_DTLIMGVO img : cmmImgList) {

				String savePath = EgovProperties.getProperty("PRODUCT." + corpInfo.getCorpCd() + ".SAVEDFILE");
				if(Constant.FLAG_Y.equals(img.getPcImgYn())) {
					savePath += "pc/";
				}else {
					savePath += "m/";
				}

				String orifileNm = img.getSavePath() + img.getSaveFileNm();
				String ext =  FilenameUtils.getExtension(orifileNm);
				String imgNum = cmmDtlImgDAO.selectImgNum(imgVO.getNewLinkNum());
				String newFileNm = imgVO.getNewLinkNum() + "_" + imgNum + "." + ext;

				ossFileUtilService.copyPrdtImgFile(img.getSaveFileNm(), img.getSavePath(), newFileNm, savePath);

				imgVO.setLinkNum(imgVO.getNewLinkNum());
				imgVO.setImgNum(imgNum);

				imgVO.setSavePath(savePath);
				imgVO.setRealFileNm(img.getRealFileNm());
				imgVO.setSaveFileNm(newFileNm);
				imgVO.setPcImgYn(img.getPcImgYn());
				cmmDtlImgDAO.insertImg(imgVO);


			}
	}


	@Override
	public void addDtlImgSn(CM_DTLIMGVO imgVO){
		cmmDtlImgDAO.addImgSn(imgVO);
	}

	@Override
	public void minusDtlImgSn(CM_DTLIMGVO imgVO){
		cmmDtlImgDAO.minusImgSn(imgVO);
	}

	/**
	 * 이미지 순번 변경
	 * 파일명 : updateImgSn
	 * 작성일 : 2015. 10. 7. 오후 7:47:27
	 * 작성자 : 최영철
	 * @param imgVO
	 */
	@Override
	public void updateDtlImgSn(CM_DTLIMGVO imgVO){
		if(imgVO.getOldSn() > imgVO.getNewSn()){
			// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
			addDtlImgSn(imgVO);
		}else{
			minusDtlImgSn(imgVO);
		}
		cmmDtlImgDAO.updateImgSn(imgVO);
	}


	@Override
	public void deletePrdtDtlImg(CM_DTLIMGVO imgVO) throws Exception{
		CM_DTLIMGVO imgInfo = selectByPrdtDtlImg(imgVO);

		// 이미지 파일 삭제
    	ossFileUtilService.deleteImgFile(imgInfo);

    	cmmDtlImgDAO.deletePrdtImg(imgVO);

    	imgVO.setOldSn(Integer.parseInt(imgVO.getImgSn()));
    	minusDtlImgSn(imgVO);
	}

	@Override
	public void deletePrdtDtlImgList(CM_DTLIMGVO imgVO) throws Exception{

		List<CM_DTLIMGVO> imgInfoList = selectDtlImgList(imgVO);

		// 이미지 파일 삭제
		for(CM_DTLIMGVO imgInfo : imgInfoList)
			ossFileUtilService.deleteImgFile(imgInfo);

		cmmDtlImgDAO.deletePrdtImg(imgVO);

	}

	@Override
	public String selectConhistByMsg(String linkNum) {
		return cmmConfhistDAO.selectApprMsg(linkNum);
	}

	@Override
	public void insertPrdtimg(CM_IMGVO imgVO, String fileList) throws Exception {
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		String savePath = EgovProperties.getProperty("PRODUCT." + corpInfo.getCorpCd() + ".SAVEDFILE");

		String[] a_fileList = fileList.split(",");

		for(String file : a_fileList) {
			File tempFile = new File(file);
			String ext = FilenameUtils.getExtension(tempFile.getName());
			String imgNum = cmmImgDAO.selectImgNum(imgVO.getLinkNum());

			String newFileNm = imgVO.getLinkNum() + "_" + imgNum + "." + ext;
			// 파일 업로드
			ossFileUtilService.dextWriteImgFile(file, savePath, newFileNm);

			imgVO.setImgNum(imgNum);
			imgVO.setSavePath(savePath);
			imgVO.setRealFileNm(tempFile.getName());
			imgVO.setSaveFileNm(newFileNm);

			cmmImgDAO.insertImg(imgVO);

		}

	}

	@Override
	public void insertCmIconinf(CM_ICONINFVO icon) {
		if(icon.getIconCds() != null && icon.getIconCds().size() > 0) {
			cmmIconinfDAO.insertCmIconinf(icon);
		}
	}

	@Override
	public List<CM_ICONINFVO> selectCmIconinf(String prdtNum, String hrkCdNum) {
		CM_ICONINFVO icon = new CM_ICONINFVO();
		icon.setLinkNum(prdtNum);
		icon.setHrkCdNum(hrkCdNum);
		return cmmIconinfDAO.selectCmIconinf(icon);
	}

	@Override
	public int selectCmIconfChkIsr(String prdtNum) {
		CM_ICONINFVO icon = new CM_ICONINFVO();
		icon.setLinkNum(prdtNum);

		return cmmIconinfDAO.selectCmIconfChkIsr(icon);
	}

	@Override
	public void updateCmIconinf(CM_ICONINFVO icon) {
		cmmIconinfDAO.deleteCmIconinf(icon.getLinkNum());

		insertCmIconinf(icon);
	}

	@Override
	public void deleteCmIconinf(String prdtNum) {
		cmmIconinfDAO.deleteCmIconinf(prdtNum);

	}

	/**
	 * 검색어 등록
	 * 파일명 : insertSrchWord
	 * 작성일 : 2016. 7. 27. 오전 11:20:01
	 * 작성자 : 최영철
	 * @param srchWordList
	 */
	@Override
	public void insertSrchWord(List<CM_SRCHWORDVO> srchWordList){
		for(int i=0;i<srchWordList.size();i++){
			CM_SRCHWORDVO srchWordVO = srchWordList.get(i);
			if(EgovStringUtil.isEmpty(srchWordVO.getSrchWord())){
				cmmSrchWordDAO.deleteSrchWord(srchWordVO);
			}else{
				cmmSrchWordDAO.mergeSrchWord(srchWordVO);
			}
		}
	}

	/**
	 * 검색어 처리
	 * 파일명 : insertSrchWord2
	 * 작성일 : 2016. 7. 27. 오후 3:16:19
	 * 작성자 : 최영철
	 * @param srchWordVO
	 */
	@Override
	public void insertSrchWord2(CM_SRCHWORDVO srchWordVO){
		if(EgovStringUtil.isEmpty(srchWordVO.getSrchWord())){
			cmmSrchWordDAO.deleteSrchWord(srchWordVO);
		}else{
			cmmSrchWordDAO.mergeSrchWord(srchWordVO);
		}
	}

	/**
	 * 검색어 조회
	 * 파일명 : getSrchWord
	 * 작성일 : 2016. 7. 27. 오후 2:43:26
	 * 작성자 : 최영철
	 * @param corpId
	 * @param srchWordSn
	 * @return
	 */
	@Override
	public String getSrchWord(String corpId, String srchWordSn){
		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(corpId);
		srchWordVO.setSrchWordSn(srchWordSn);
		return cmmSrchWordDAO.getSrchWord(srchWordVO);
	}

	/**
	 * 검색어 다중 조회
	 * 파일명 : selectSrchWordList
	 * 작성일 : 2017. 9. 8. 오후 3:11:06
	 * 작성자 : 신우섭
	 * @param corpId
	 * @return
	 */
	@Override
	public List<CM_SRCHWORDVO> selectSrchWordList(String corpId){
		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(corpId);
		return cmmSrchWordDAO.selectSrchWordList(srchWordVO);
	}

	/**
	 * 검색어 통계 추가
	 * 파일명 : mergeSrchWordAnls
	 * 작성일 : 2016. 7. 29. 오후 5:03:11
	 * 작성자 : 최영철
	 * @param search
	 */
	@Override
	public void mergeSrchWordAnls(String search){
		if(!EgovStringUtil.isEmpty(search)){
			cmmSrchWordDAO.mergeSrchWordAnls(search);
		}
	}

    @Override
    public List<ISEARCHVO> selectIsearchWords(ISEARCHVO isearchvo){
        return cmmSrchWordDAO.selectIsearchWords(isearchvo);
    }

	@Override
	public void insertIsearchWords(ISEARCHVO isearchvo){
			cmmSrchWordDAO.insertIsearchWords(isearchvo);
	}

	@Override
	public void deleteIsearchWords(ISEARCHVO isearchvo){
			cmmSrchWordDAO.deleteIsearchWords(isearchvo);
	}

	/**
	 * 수수료 리스트 조회
	 * 파일명 : selectCmssList
	 * 작성일 : 2016. 8. 10. 오후 5:31:23
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectCmssList(pageDefaultVO searchVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<CMSSVO> resultList = cmssDAO.selectCmssList(searchVO);
		Integer totalCnt = cmssDAO.getCntCmssList(searchVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	/**
	 * 수수료 등록
	 * 파일명 : insertCmss
	 * 작성일 : 2016. 8. 11. 오후 1:41:30
	 * 작성자 : 최영철
	 * @param cmssVO
	 */
	@Override
	public void insertCmss(CMSSVO cmssVO){
		cmssDAO.insertCmss(cmssVO);
	}

	/**
	 * 수수료 단건 조회
	 * 파일명 : selectByCmss
	 * 작성일 : 2016. 8. 11. 오후 2:56:23
	 * 작성자 : 최영철
	 * @param cmssVO
	 * @return
	 */
	@Override
	public CMSSVO selectByCmss(CMSSVO cmssVO){
		return cmssDAO.selectByCmss(cmssVO);
	}

	/**
	 * 수수료 수정
	 * 파일명 : updateCmss
	 * 작성일 : 2016. 8. 11. 오후 3:06:32
	 * 작성자 : 최영철
	 * @param cmssVO
	 */
	@Override
	public void updateCmss(CMSSVO cmssVO){
		cmssDAO.updateCmss(cmssVO);
	}

	/**
	 * B2C 수수료 전체 조회
	 * 파일명 : selectCmssList
	 * 작성일 : 2016. 8. 12. 오전 10:41:19
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<CMSSVO> selectCmssList(){
		return cmssDAO.selectCmssList();
	}

	/**
	 * 해당 수수료를 사용하고 있는 업체 카운트
	 * 파일명 : deleteChkCmss
	 * 작성일 : 2016. 8. 18. 오후 1:14:23
	 * 작성자 : 최영철
	 * @param cmssVO
	 * @return
	 */
	@Override
	public Integer deleteChkCmss(CMSSVO cmssVO){
		return cmssDAO.deleteChkCmss(cmssVO);
	}

	/**
	 * 수수료 삭제
	 * 파일명 : deleteCmss
	 * 작성일 : 2016. 8. 18. 오후 1:22:20
	 * 작성자 : 최영철
	 * @param cmssVO
	 */
	@Override
	public void deleteCmss(CMSSVO cmssVO){
		cmssDAO.deleteCmss(cmssVO);
	}

	/**
	 * B2B 수수료 전체 조회
	 * 파일명 : selectB2bCmssList
	 * 작성일 : 2016. 9. 19. 오전 11:40:49
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public List<CMSSVO> selectB2bCmssList(){
		return cmssDAO.selectB2bCmssList();
	}

	/**
	 * 모바일 접속 시 접속 기기 확인
	 * Function : getClientType
	 * 작성일 : 2016. 6. 8. 오후 5:02:50
	 * 작성자 : 최영철
	 * @param request
	 * @return
	 */
	@Override
	public String getClientType(HttpServletRequest request) {
		String userAgent = request.getHeader("User-Agent");
    	final String mobile = "/iphone|iPhone|ipad|iPad|ipod|android|Android|windows phone|iemobile|blackberry|mobile safari|opera mobi/i";
    	Pattern pattern = Pattern.compile(mobile);

    	Matcher mathch = pattern.matcher(userAgent);

    	if(mathch.find() == true){
//    	if( userAgent.indexOf("iphone") >= 0
//    	  ||userAgent.indexOf("iphone") >= 0
//    	  ||userAgent.indexOf("ipod") >= 0
//    	  ||userAgent.indexOf("windows phone") >= 0
//    	  ||userAgent.indexOf("iemobile") >= 0
//    	  ||userAgent.indexOf("blackberry") >= 0
//    	  ||userAgent.indexOf("mobile safari|opera mobi") >= 0
//    			){
    		//log.info("-------------------Mobi");
    		if( userAgent.indexOf("android") >= 0 || userAgent.indexOf("Android") >= 0 ){
    			if( userAgent.indexOf("webview_android") >= 0){
    				return "AA";
    				//log.info("-------------------AA");
    			}
    			else{
    				// 안드로이드 웹
    				return "AW";
    				//log.info("-------------------AW");
    			}

    		}else if( userAgent.indexOf("iphone") >= 0 || userAgent.indexOf("iPhone") >= 0 || userAgent.indexOf("ipad") >= 0 || userAgent.indexOf("iPad") >= 0 ){
    			if(!( userAgent.indexOf("safari") >= 0) ){
    				return "IA";
    				//log.info("-------------------IA");
    			}else{
    				return "IW";
    				//log.info("-------------------IW");
    			}
    		}
    	}else{
    		//log.info("-------------------PC");
    		return "PC";
    	}

    	return "PC";
	}


	@Override
	public Map<String, Object> selectFileList(FILESVO fileSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<FILESVO> resultList;

		Integer totalCnt;

		if("cmDtl".equals(fileSVO.getCategory())) {
			resultList = cmmDtlImgDAO.selectFileList(fileSVO);

			totalCnt = cmmDtlImgDAO.selectFileListCnt(fileSVO);
		} else {
			resultList = cmmImgDAO.selectFileList(fileSVO);

			totalCnt = cmmImgDAO.selectFileListCnt(fileSVO);
		}

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}
	
	/**
	 * PG사 수수료 리스트 조회
	 * 파일명 : selectCmssPgList
	 * 작성일 : 2020.10.30
	 * 작성자 : 김지연
	 * @param searchVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectCmssPgList(pageDefaultVO searchVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<CMSSPGVO> resultList = cmssDAO.selectCmssPgList(searchVO);
		Integer totalCnt = cmssDAO.getCntCmssPgList(searchVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}	
	
	/**
	 * PG사 수수료 등록
	 * 파일명 : insertCmssPg
	 * 작성일 : 2020.11.02
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 */
	@Override
	public void insertCmssPg(CMSSPGVO cmssPgVO){
		cmssDAO.insertCmssPg(cmssPgVO);
	}	
	
	/**
	 * PG사 수수료 삭제
	 * 파일명 : deleteCmssPg
	 * 작성일 : 2020.11.02
	 * 작성자 : 김지연
	 * @param cmssVO
	 */
	@Override
	public void deleteCmssPg(CMSSPGVO cmssPgVO){
		cmssDAO.deleteCmssPg(cmssPgVO);
	}
	
	/**
	 * PG사 수수료 단건 조회
	 * 파일명 : selectByCmssPg
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 * @return
	 */
	@Override
	public CMSSPGVO selectByCmssPg(CMSSPGVO cmssPgVO){
		return cmssDAO.selectByCmssPg(cmssPgVO);
	}	
	
	/**
	 * PG사 수수료 수정
	 * 파일명 : updateCmssPg
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 */
	@Override
	public void updateCmssPg(CMSSPGVO cmssPgVO){
		cmssDAO.updateCmssPg(cmssPgVO);
	}	

	/**
	 * PG사 수수료 날짜 중복 체크
	 * 파일명 : checkAplDt
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 * @return
	 */
	@Override
	public Integer checkAplDt(CMSSPGVO cmssPgVO){
		Integer chkCnt = cmssDAO.checkAplDt(cmssPgVO);
		return chkCnt;
	}

	@Override
	public PRDTVO selectPrdtInfo(String prdtNum) {
		return  prdtDAO.selectPrdtInfo(prdtNum);
	}

	@Override
	public List<CM_IMGVO> selectSvImgList(CM_IMGVO imgVO) {
		return cmmImgDAO.selectSvImgList(imgVO);
	}

}
