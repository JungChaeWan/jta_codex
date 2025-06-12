package oss.site.service.impl;

import egovframework.cmmn.service.EgovProperties;
import mas.prmt.service.impl.MasPrmtServiceImpl;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import oss.cmm.service.OssFileUtilService;
import oss.site.service.OssCrtnService;
import oss.site.vo.SVCRTNPRDTVO;
import oss.site.vo.SVCRTNVO;

import javax.annotation.Resource;
import java.util.*;

@Service("ossCrtnService")
public class OssCrtnServiceImpl implements OssCrtnService {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(MasPrmtServiceImpl.class);

	@Resource(name = "crtnDAO")
	private CrtnDAO crtnDAO;

	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;
	
	/**
	 * 제주특산/기념품 큐레이션 리스트
	 * Function : selectCrtnList
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectCrtnList(SVCRTNVO crtnVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<SVCRTNVO> resultList = crtnDAO.selectCrtnList(crtnVO);
		Integer totalCnt = crtnDAO.getCntCrtnList(crtnVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}
	
	/**
	 * 제주특산/기념품 큐레이션 메인 리스트
	 * Function : selectCrtnWebList
	 * 작성일 : 2017. 11. 14. 오전 11:57:19
	 * 작성자 : 정동수
	 * @return
	 */
	@Override
	public List<SVCRTNVO> selectCrtnWebList() {		
		return crtnDAO.selectCrtnWebList();
	}
	
	/**
	 * 제주특산/기념품 큐레이션 단건 정보
	 * Function : selectByCrtn
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 * @return
	 */
	@Override
	public SVCRTNVO selectByCrtn(SVCRTNVO crtnVO) {
		return crtnDAO.selectByCrtn(crtnVO);
	}
	
	/**
	 * 제주특산/기념품 큐레이션의 포함 상품 리스트
	 * Function : selectCrtnPrdtList
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 * @return
	 */
	@Override
	public List<SVCRTNPRDTVO> selectCrtnPrdtList(SVCRTNVO crtnVO) {
		return crtnDAO.selectCrtnPrdtList(crtnVO);
	}

	/**
	 * 제주특산/기념품 큐레이션 등록
	 * Function : insertCrtn
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 * @param multiRequest
	 * @return
	 * @throws Exception
	 */
	@Override
	public String insertCrtn(SVCRTNVO crtnVO, MultipartHttpServletRequest multiRequest) throws Exception {
		String crtnNum = (String) crtnDAO.getCrtnPk(crtnVO);
		
		String listSavePath = EgovProperties.getProperty("SV.CURATION.SAVEDFILE");

		MultipartFile listImgFile = multiRequest.getFile("listImgFile") ;
		if(!listImgFile.isEmpty()) {
			String newFileName = crtnNum + "." + FilenameUtils.getExtension(multiRequest.getFile("listImgFile").getOriginalFilename());
			ossFileUtilService.uploadFile(listImgFile, newFileName, listSavePath);
			crtnVO.setListImgPath(listSavePath + newFileName);
		}
		
		//첨부파일 올리기
		ossFileUtilService.uploadPrmtFile(multiRequest, EgovProperties.getProperty("PROMOTION.FILE.SAVEDFILE"), crtnNum);


		crtnVO.setCrtnNum(crtnNum);
		crtnDAO.insertCrtn(crtnVO);

		return crtnNum;
	}
	
	/**
	 * 제주특산/기념품 큐레이션 수정
	 * Function : updateCrtn
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 * @param multiRequest
	 * @throws Exception
	 */
	@Override
	public void updateCrtn(SVCRTNVO crtnVO,
			MultipartHttpServletRequest multiRequest) throws Exception {
		String prmtNum = crtnVO.getCrtnNum();
		/*
		 * String listSavePath = EgovProperties.getProperty("SV.CURATION.SAVEDFILE");
		 * 
		 * MultipartFile listImgFile = multiRequest.getFile("listImgFile") ;
		 * if(!listImgFile.isEmpty()) { String newFileName = prmtNum + "." +
		 * FilenameUtils.getExtension(multiRequest.getFile("listImgFile").
		 * getOriginalFilename()); ossFileUtilService.uploadFile(listImgFile,
		 * newFileName, listSavePath); crtnVO.setListImgPath(listSavePath +
		 * newFileName); }
		 */

		crtnVO.setCrtnNum(prmtNum);
		
		// 출력 순번 증가
		if (crtnVO.getOldSort() > crtnVO.getSort())
			crtnDAO.incremntCrtnPrintSn(crtnVO);
		// 출력 순번 감소
		if (crtnVO.getOldSort() < crtnVO.getSort())
			crtnDAO.downCrtnPrintSn(crtnVO);
		
		crtnDAO.updateCrtn(crtnVO);
	}
	
	/**
	 * 제주특산/기념품 큐레이션 삭제
	 * Function : deleteCrtn
	 * 작성일 : 2017. 11. 13. 오후 8:55:19
	 * 작성자 : 정동수
	 * @param crtnVO
	 */
	@Override
	public void deleteCrtn(SVCRTNVO crtnVO) {		
		// 출력 순번 감소
		crtnDAO.downCrtnPrintSn(crtnVO);
				
		crtnDAO.deleteCrtn(crtnVO);
	}

	/**
	 * 제주특산/기념품 큐레이션 메인의 큐레이션별 상품 리스트
	 * Function : selectCrtnPrdtWebList
	 * 작성일 : 2017. 11. 14. 오전 11:56:53
	 * 작성자 : 정동수
	 * @return
	 */
	@Override
	public Map<String, List<SVCRTNPRDTVO>> selectCrtnPrdtWebList() {
		Map<String, List<SVCRTNPRDTVO>> resultMap = new HashMap<String, List<SVCRTNPRDTVO>>();
		
		List<SVCRTNPRDTVO> tmpList = new ArrayList<SVCRTNPRDTVO>();
		List<SVCRTNPRDTVO> resultList = crtnDAO.selectCrtnPrdtWebList();

		String crtnNum = resultList.size() > 0 ? resultList.get(0).getCrtnNum() : null;
		for (SVCRTNPRDTVO prdt : resultList) {
			if (crtnNum.equals(prdt.getCrtnNum()) == false) {
				resultMap.put(crtnNum, tmpList);
				crtnNum = prdt.getCrtnNum();				
				tmpList = new ArrayList<SVCRTNPRDTVO>();
			}
			tmpList.add(prdt);
		}
		Collections.shuffle(tmpList);
		resultMap.put(crtnNum, tmpList);
		
		return resultMap;
	}
	
	/**
	 * 제주특산/기념품 큐레이션별 상품 등록
	 * Function : insertCrtnPrdtOne
	 * 작성일 : 2017. 11. 14. 오전 11:56:43
	 * 작성자 : 정동수
	 * @param crtnVO
	 */
	@Override
	public void insertCrtnPrdtOne(SVCRTNVO crtnVO) {
		crtnDAO.insertCrtnPrdtOne(crtnVO);
	}
	
	/**
	 * 제주특산/기념품 큐레이션별 상품 출력 순번 수정
	 * Function : updatePrmtPrdtSort
	 * 작성일 : 2017. 11. 14. 오전 11:56:59
	 * 작성자 : 정동수
	 * @param crtnPrdtVO
	 */
	@Override
	public void updatePrmtPrdtSort(SVCRTNPRDTVO crtnPrdtVO) {
		// 출력 순번 증가
		if (crtnPrdtVO.getOldSn() > crtnPrdtVO.getNewSn())
			crtnDAO.incremntCrtnPrdtPrintSn(crtnPrdtVO);
		// 출력 순번 감소
		if (crtnPrdtVO.getOldSn() < crtnPrdtVO.getNewSn())
			crtnDAO.downCrtnPrdtPrintSn(crtnPrdtVO);

		crtnDAO.updateCrtnPrintSn(crtnPrdtVO);
	}
	
	/**
	 * 제주특산/기념품 큐레이션별 상품 삭제
	 * Function : deleteCrtnPrdt
	 * 작성일 : 2017. 11. 14. 오전 11:57:02
	 * 작성자 : 정동수
	 * @param prmtNum
	 */
	@Override
	public void deleteCrtnPrdt(String crtnNum) {
		crtnDAO.deleteCrtnPrdt(crtnNum);
	}
}
