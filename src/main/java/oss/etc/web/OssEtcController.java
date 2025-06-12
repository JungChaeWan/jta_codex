package oss.etc.web;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import common.EgovUserDetailsHelper;
import oss.etc.service.OssEtcService;
import oss.user.vo.USERVO;
import web.etc.vo.SCCSVO;
import web.etc.vo.SCCVO;
import web.order.vo.RSVVO;
import egovframework.cmmn.EgovWebUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class OssEtcController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "ossEtcService")
	private OssEtcService ossEtcService;
    
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    		
    /**
     * 홍보영상 리스트 조회
     * 파일명 : sccList
     * 작성일 : 2017. 3. 3. 오후 5:12:54
     * 작성자 : 최영철
     * @param sccSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/etc/sccList.do")
    public String sccList(	@ModelAttribute("searchVO") SCCSVO sccSVO,
    						ModelMap model){
    	sccSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		sccSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(sccSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(sccSVO.getPageUnit());
		paginationInfo.setPageSize(sccSVO.getPageSize());

		sccSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		sccSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		sccSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossEtcService.selectSccList(sccSVO);
		
		@SuppressWarnings("unchecked")
		List<RSVVO> resultList = (List<RSVVO>) resultMap.get("resultList");

		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "oss/etc/sccList";
    }
    
    /**
     * 홍보영상 등록 화면 VIEW
     * 파일명 : viewInsertScc
     * 작성일 : 2017. 3. 6. 오후 2:30:33
     * 작성자 : 최영철
     * @param sccSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/etc/viewInsertScc.do")
    public String viewInsertScc(@ModelAttribute("searchVO") SCCSVO sccSVO,
			ModelMap model){
    	return "oss/etc/insertScc";
    }
    
    /**
     * 홍영상 등록
     * 파일명 : insertScc
     * 작성일 : 2017. 3. 6. 오후 2:30:44
     * 작성자 : 최영철
     * @param sccSVO
     * @param sccVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/etc/insertScc.do")
    public String insertScc(@ModelAttribute("searchVO") SCCSVO sccSVO
    		, @ModelAttribute("sccVO") SCCVO sccVO
			, ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
    	sccVO.setFrstRegId(corpInfo.getUserId());
    	ossEtcService.insertScc(sccVO);
    	
    	return "redirect:/oss/etc/sccList.do";
    }
    
    /**
     * 홍보영상 상세
     * 파일명 : detailScc
     * 작성일 : 2017. 3. 6. 오후 3:57:25
     * 작성자 : 최영철
     * @param sccSVO
     * @param sccVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/etc/detailScc.do")
    public String detailScc(@ModelAttribute("searchVO") SCCSVO sccSVO
    		, @ModelAttribute("sccVO") SCCVO sccVO
			, ModelMap model){
    
    	sccVO = ossEtcService.selectByScc(sccVO);
    	
    	sccVO.setContents(EgovWebUtil.clearXSSMinimum(sccVO.getContents()) );
    	sccVO.setContents(sccVO.getContents().replaceAll("\n", "<br/>\n") );
    	
    	model.addAttribute("sccVO", sccVO);
    	
    	return "oss/etc/detailScc";
    }
    
    /**
     * 홍보영상 삭제
     * 파일명 : deleteScc
     * 작성일 : 2017. 3. 6. 오후 4:43:50
     * 작성자 : 최영철
     * @param sccSVO
     * @param sccVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/etc/deleteScc.do")
    public String deleteScc(@ModelAttribute("searchVO") SCCSVO sccSVO
    		, @ModelAttribute("sccVO") SCCVO sccVO
			, ModelMap model){
    	
    	ossEtcService.deleteScc(sccVO);
    	return "redirect:/oss/etc/sccList.do";
    }
    
    /**
     * 홍보영상 수정 화면 VIEW
     * 파일명 : viewUpdateScc
     * 작성일 : 2017. 3. 6. 오후 5:40:38
     * 작성자 : 최영철
     * @param sccSVO
     * @param sccVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/etc/viewUpdateScc.do")
    public String viewUpdateScc(@ModelAttribute("searchVO") SCCSVO sccSVO
    		, @ModelAttribute("sccVO") SCCVO sccVO
			, ModelMap model){
    	sccVO = ossEtcService.selectByScc(sccVO);
    	model.addAttribute("sccVO", sccVO);
    	return "oss/etc/updateScc";
    }
    
    /**
     * 홍보영상 수정
     * 파일명 : updateScc
     * 작성일 : 2017. 3. 6. 오후 5:40:51
     * 작성자 : 최영철
     * @param sccSVO
     * @param sccVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/etc/updateScc.do")
    public String updateScc(@ModelAttribute("searchVO") SCCSVO sccSVO
    		, @ModelAttribute("sccVO") SCCVO sccVO
			, ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
    	sccVO.setLastModId(corpInfo.getUserId());
    	ossEtcService.updateScc(sccVO);
    	
    	return "redirect:/oss/etc/sccList.do";
    }
}
