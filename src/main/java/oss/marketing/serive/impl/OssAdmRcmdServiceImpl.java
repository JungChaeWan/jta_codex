package oss.marketing.serive.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.prmt.service.impl.MasPrmtServiceImpl;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.cmm.service.OssFileUtilService;
import oss.marketing.serive.OssAdmRcmdService;
import oss.marketing.vo.ADMRCMDVO;
import egovframework.cmmn.service.EgovProperties;

@Service("OssAdmRcmdService")
public class OssAdmRcmdServiceImpl implements OssAdmRcmdService {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(MasPrmtServiceImpl.class);
		
	@Resource(name="OssAdmRcmdDAO")
	OssAdmRcmdDAO ossAdmRcmdDao;
	
	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;
	
	@Override
	public Map<String, Object> selectMdsPickList(ADMRCMDVO admRcmdVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("resultList", ossAdmRcmdDao.selectAdmRcmdList(admRcmdVO));
		resultMap.put("totalCnt", ossAdmRcmdDao.selectAdmRcmdTotalCnt(admRcmdVO));
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> selectMdsPickListFind(ADMRCMDVO admRcmdVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("resultList", ossAdmRcmdDao.selectAdmRcmdListFind(admRcmdVO));
		resultMap.put("totalCnt", ossAdmRcmdDao.selectAdmRcmdTotalCntFind(admRcmdVO));
		
		return resultMap;
	}	
	
	@Override
	public Map<String, Object> selectMdsPickWebList(ADMRCMDVO admRcmdVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("resultList", ossAdmRcmdDao.selectAdmRcmdWebList(admRcmdVO));
		resultMap.put("totalCnt", ossAdmRcmdDao.selectAdmRcmdWebCnt(admRcmdVO));
		
		return resultMap;
	}
	
	@Override
	public ADMRCMDVO selectMdsPickInfo(ADMRCMDVO admRcmdVO) {		
		return ossAdmRcmdDao.selectAdmRcmdInfo(admRcmdVO);
	}
	
	@Override
	public ADMRCMDVO selectMdsPickWebInfo(ADMRCMDVO admRcmdVO) {		
		return ossAdmRcmdDao.selectAdmRcmdWebInfo(admRcmdVO);
	}
	
	@Override
	public List<ADMRCMDVO> selectMdsPickWebPrdtList(ADMRCMDVO admRcmdVO) {		
		return ossAdmRcmdDao.selectAdmRcmdWebPrdtList(admRcmdVO);
	}
	
	@Override
	public List<ADMRCMDVO> selectAdmRcmdWebSlideList(ADMRCMDVO admRcmdVO) {		
		return ossAdmRcmdDao.selectAdmRcmdWebSlideList(admRcmdVO);
	}
	
	/**
	 * MD's Pick Web 랜덤 리스트 (4개)
	 * Function : selectAdmRcmdWebRandomList
	 * 작성일 : 2017. 11. 01. 오후 12:06:28
	 * 작성자 : 정동수
	 * @param admRcmdVO
	 * @return
	 */
	@Override
	public List<ADMRCMDVO> selectAdmRcmdWebRandomList(ADMRCMDVO admRcmdVO) {		
		return ossAdmRcmdDao.selectAdmRcmdWebRandomList(admRcmdVO);
	}

	@Override
	public void insertMdsPick(ADMRCMDVO admRcmdVO, MultipartHttpServletRequest multiRequest) throws Exception {
		String rcmdNum = ossAdmRcmdDao.getAdmRcmdPk();
		
		MultipartFile listImgFile = multiRequest.getFile("listImgFile");

		if(!listImgFile.isEmpty()) {
			String listSavePath = EgovProperties.getProperty("MDSPICK.LIST.SAVEDFILE");
			String newFileName = rcmdNum + "." + FilenameUtils.getExtension(multiRequest.getFile("listImgFile").getOriginalFilename());
			ossFileUtilService.uploadFile(listImgFile, newFileName, listSavePath);
			admRcmdVO.setListImgPath(listSavePath + newFileName);
			admRcmdVO.setListImgFileNm(multiRequest.getFile("listImgFile").getOriginalFilename());
		}
		
		MultipartFile detailImgFile = multiRequest.getFile("dtlImgFile");

		if(!detailImgFile.isEmpty()) {
			String detailSavePath = EgovProperties.getProperty("MDSPICK.DTL.SAVEDFILE");
			String newFileName = rcmdNum + "." + FilenameUtils.getExtension(multiRequest.getFile("dtlImgFile").getOriginalFilename());
			ossFileUtilService.uploadFile(detailImgFile, newFileName, detailSavePath);
			admRcmdVO.setDtlImgPath(detailSavePath + newFileName);
			admRcmdVO.setDtlImgFileNm(multiRequest.getFile("dtlImgFile").getOriginalFilename());
		}
				
		MultipartFile mobileImgFile = multiRequest.getFile("dtlMobileImgFile");

		if(!mobileImgFile.isEmpty()) {
			String mobileSavePath = EgovProperties.getProperty("MDSPICK.DTL.MOBILE.SAVEDFILE");
			String newFileName = rcmdNum + "." + FilenameUtils.getExtension(multiRequest.getFile("dtlMobileImgFile").getOriginalFilename());
			ossFileUtilService.uploadFile(mobileImgFile, newFileName, mobileSavePath);
			admRcmdVO.setDtlMobileImgPath(mobileSavePath + newFileName);
			admRcmdVO.setDtlMobileImgFileNm(multiRequest.getFile("dtlMobileImgFile").getOriginalFilename());
		}
		
		MultipartFile bannerImgFile = multiRequest.getFile("bannerImgFile");

		if(!bannerImgFile.isEmpty()) {
			String bannerSavePath = EgovProperties.getProperty("MDSPICK.BANNER.SAVEDFILE");
			String newFileName = rcmdNum + "." + FilenameUtils.getExtension(multiRequest.getFile("bannerImgFile").getOriginalFilename());
			ossFileUtilService.uploadFile(bannerImgFile, newFileName, bannerSavePath);
			admRcmdVO.setBannerImgPath(bannerSavePath + newFileName);
			admRcmdVO.setBannerImgFileNm(multiRequest.getFile("bannerImgFile").getOriginalFilename());
		}
		admRcmdVO.setRcmdNum(rcmdNum);

		ossAdmRcmdDao.insertAdmRcmd(admRcmdVO);
	}
	
	@Override
	public void updateMdsPick(ADMRCMDVO admRcmdVO, MultipartHttpServletRequest multiRequest) throws Exception {
		String rcmdNum = admRcmdVO.getRcmdNum();
		
		MultipartFile listImgFile = multiRequest.getFile("listImgFile") ;
		if(listImgFile != null && !listImgFile.isEmpty()) {
			String listSavePath = EgovProperties.getProperty("MDSPICK.LIST.SAVEDFILE");
			String newFileName = rcmdNum + "." + FilenameUtils.getExtension(multiRequest.getFile("listImgFile").getOriginalFilename());
			ossFileUtilService.uploadFile(listImgFile, newFileName, listSavePath);
			admRcmdVO.setListImgPath(listSavePath + newFileName);
			admRcmdVO.setListImgFileNm(multiRequest.getFile("listImgFile").getOriginalFilename());
		}
		
		MultipartFile detailImgFile = multiRequest.getFile("detailImgFile") ;
		if(detailImgFile != null && !detailImgFile.isEmpty()) {
			String detailSavePath = EgovProperties.getProperty("MDSPICK.DTL.SAVEDFILE");
			String newFileName = rcmdNum + "." + FilenameUtils.getExtension(multiRequest.getFile("detailImgFile").getOriginalFilename());
			ossFileUtilService.uploadFile(detailImgFile, newFileName, detailSavePath);
			admRcmdVO.setDtlImgPath(detailSavePath + newFileName);
			admRcmdVO.setDtlImgFileNm(multiRequest.getFile("detailImgFile").getOriginalFilename());
		}
				
		MultipartFile mobileImgFile = multiRequest.getFile("mobileImgFile") ;
		if(mobileImgFile != null && !mobileImgFile.isEmpty()) {
			String mobileSavePath = EgovProperties.getProperty("MDSPICK.DTL.MOBILE.SAVEDFILE");
			String newFileName = rcmdNum + "." + FilenameUtils.getExtension(multiRequest.getFile("mobileImgFile").getOriginalFilename());
			ossFileUtilService.uploadFile(mobileImgFile, newFileName, mobileSavePath);
			admRcmdVO.setDtlMobileImgPath(mobileSavePath + newFileName);
			admRcmdVO.setDtlMobileImgFileNm(multiRequest.getFile("mobileImgFile").getOriginalFilename());
		}
		
		MultipartFile bannerImgFile = multiRequest.getFile("bannerImgFile") ;
		if(!bannerImgFile.isEmpty()) {
			String bannerSavePath = EgovProperties.getProperty("MDSPICK.BANNER.SAVEDFILE");
			String newFileName = rcmdNum + "." + FilenameUtils.getExtension(multiRequest.getFile("bannerImgFile").getOriginalFilename());
			ossFileUtilService.uploadFile(bannerImgFile, newFileName, bannerSavePath);
			admRcmdVO.setBannerImgPath(bannerSavePath + newFileName);
			admRcmdVO.setBannerImgFileNm(multiRequest.getFile("bannerImgFile").getOriginalFilename());
		}
		
		ossAdmRcmdDao.updateAdmRcmd(admRcmdVO);
		
	}

	@Override
	public void deleteMdsPick(ADMRCMDVO admRcmdVO) {
		ossAdmRcmdDao.delteAdmRcmd(admRcmdVO);
		
	}

	
}
