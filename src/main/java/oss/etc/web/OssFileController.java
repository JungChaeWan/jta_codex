package oss.etc.web;


import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.prmt.service.MasPrmtService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.corp.service.OssCorpPnsReqService;
import oss.etc.vo.FILESVO;
import oss.etc.vo.FILEVO;
import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.USEEPILIMGVO;
import oss.useepil.vo.USEEPILVO;
import web.bbs.service.WebBbsService;
import web.bbs.vo.NOTICEVO;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Controller
public class OssFileController {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name="webBbsService")
	private WebBbsService webBbsService;

	@Resource(name = "masPrmtService")
	private MasPrmtService masPrmtService;

	@Resource(name="ossCorpPnsReqService")
	private OssCorpPnsReqService ossCorpPnsReqService;

	@Resource(name="ossUesepliService")
	private OssUesepliService ossUesepliService;

	@Resource(name="ossCmmService")
	private OssCmmService ossCmmService;

	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;
    
    
    Logger log = LogManager.getLogger(this.getClass());
    		
    /**
     * 파일 리스트 조회
     */
    @RequestMapping("/oss/fileList.do")
    public String fileList(@ModelAttribute("searchVO") FILESVO fileSVO,
						   ModelMap model) {
    	log.info("/oss/fileList.do");
    	fileSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		fileSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(fileSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(fileSVO.getPageUnit());
		paginationInfo.setPageSize(fileSVO.getPageSize());

		fileSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		fileSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		fileSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		String category = fileSVO.getCategory();

		Map<String, Object> resultMap;

		if("prmt".equals(category)) {									// 프로모션 첨부파일
			resultMap = masPrmtService.selectFileList(fileSVO);
		} else if("cm".equals(category)) {								// 상품목록 이미지
			resultMap = ossCmmService.selectFileList(fileSVO);
		} else if("cmDtl".equals(category)) {							// 상품상세 이미지
			resultMap = ossCmmService.selectFileList(fileSVO);
		} else if("uepi".equals(category)) {							// 이용후기 첨부파일
            resultMap = ossUesepliService.selectFileList(fileSVO);
        } else if("cpr".equals(category)) {								// 입점신청 서류
            resultMap = ossCorpPnsReqService.selectFileList(fileSVO);
        } else {														// 게시판 첨부파일
			resultMap = webBbsService.selectFileList(fileSVO);
		}
		List<FILESVO> resultList = (List<FILESVO>) resultMap.get("resultList");

		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "oss/etc/fileList";
    }

	/**
	 * 파일 수정
	 */
	@RequestMapping("/oss/updateFile.do")
	public String updateFile(@ModelAttribute("searchVO") FILESVO fileSVO,
                             @ModelAttribute("FILEVO") FILEVO fileVO,
                             final MultipartHttpServletRequest multiRequest) {
		log.info("/oss/updateFile.do");

        String category = fileSVO.getCategory();
        String docId = fileVO.getDocId();
        String fileNum = fileVO.getFileNum();
        String docDiv = fileVO.getDocDiv();
		String savePath = fileVO.getSavePath();

        try {
            if("prmt".equals(category)) {									// 프로모션 첨부파일
                ossFileUtilService.deletePrmtFile(docId, fileNum);

                ossFileUtilService.uploadPrmtFile(multiRequest, savePath, docId);
            } else if("cm".equals(category)) {								// 상품목록 이미지
                ossFileUtilService.deleteCmImgFile(docId, fileNum);

                ossFileUtilService.uploadImgFile(multiRequest, savePath, docId);
            } else if("cmDtl".equals(category)) {							// 상품상세 이미지
                ossFileUtilService.deleteCmDtlImgFile(docId, fileNum);

				ossFileUtilService.uploadDtlImgFile(multiRequest, savePath, docId);
            } else if("uepi".equals(category)) {							// 이용후기 첨부파일
                USEEPILIMGVO useepilimgVO = new USEEPILIMGVO();
                useepilimgVO.setUseEpilNum(docId);
                useepilimgVO.setImgNum(fileNum);

                ossFileUtilService.deleteUseepilImage(useepilimgVO);

                USEEPILVO useepilVO = new USEEPILVO();
                useepilVO.setUseEpilNum(docId);

                ossFileUtilService.uploadUseepilImage(multiRequest, savePath, useepilVO);
            } else if("cpr".equals(category)) {								// 입점신청서류
                ossFileUtilService.deleteCorpPnsRequestFile(docId, fileNum);

                ossFileUtilService.uploadCorpPnsRequestFile(multiRequest, savePath, docId);
            } else {                                                        // 게시판 첨부파일
                ossFileUtilService.deleteNoticeFile(docDiv, docId, fileNum);

                String ext = "";
				NOTICEVO noticeVO = new NOTICEVO();
				noticeVO.setNoticeNum(docId);
				noticeVO.setBbsNum(docDiv);

				ossFileUtilService.uploadNoticeFile(multiRequest, savePath, ext, noticeVO);
            }
        } catch (Exception e) {
            log.error(e.toString());
        }
        return "redirect:/oss/fileList.do?category=" + category + "&docDiv=" + fileSVO.getDocDiv() + "&docNm=" + fileSVO.getDocNm();
	}

	/**
	 * 파일 삭제
	 */
	@RequestMapping("/oss/deleteFile.do")
	public String deleteFile(@ModelAttribute("searchVO") FILESVO fileSVO,
							 @ModelAttribute("FILEVO") FILEVO fileVO) {
		log.info("/oss/deleteFile.do");

		String category = fileSVO.getCategory();
		String docId = fileVO.getDocId();
		String fileNum = fileVO.getFileNum();
		String docDiv = fileVO.getDocDiv();

		try {
			if("prmt".equals(category)) {									// 프로모션
				ossFileUtilService.deletePrmtFile(docId, fileNum);
			} else if("cm".equals(category)) {								// 상품 이미지
				ossFileUtilService.deleteCmImgFile(docId, fileNum);
			} else if("cmDtl".equals(category)) {							// 상품 상세이미지
				ossFileUtilService.deleteCmDtlImgFile(docId, fileNum);
            } else if("uepi".equals(category)) {							// 이용후기
                USEEPILIMGVO useepilimgVO = new USEEPILIMGVO();
                useepilimgVO.setUseEpilNum(docId);
                useepilimgVO.setImgNum(fileNum);

                ossFileUtilService.deleteUseepilImage(useepilimgVO);
			} else if("cpr".equals(category)) {								// 입점신청
				ossFileUtilService.deleteCorpPnsRequestFile(docId, fileNum);
			} else {                                                        // 게시판
				ossFileUtilService.deleteNoticeFile(docDiv, docId, fileNum);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}
		return "redirect:/oss/fileList.do?category=" + category + "&docDiv=" + fileSVO.getDocDiv() + "&docNm=" + fileSVO.getDocNm();
	}
    

}
