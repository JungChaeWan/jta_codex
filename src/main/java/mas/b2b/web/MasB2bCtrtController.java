package mas.b2b.web;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.b2b.service.MasB2bCtrtService;
import mas.b2b.service.MasB2bService;
import mas.b2b.vo.B2B_CORPCONFSVO;
import mas.b2b.vo.B2B_CORPCONFVO;
import mas.b2b.vo.B2B_CTRTSVO;
import mas.b2b.vo.B2B_CTRTVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.corp.vo.CORPVO;
import oss.user.vo.USERVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class MasB2bCtrtController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "masB2bService")
	private MasB2bService masB2bService;
	
	@Resource(name = "masB2bCtrtService")
	private MasB2bCtrtService masB2bCtrtService;
	
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
   
    /**
     * 보낸 계약 리스트 페이지
     * 파일명 : sendCtrtRequestList
     * 작성일 : 2016. 9. 21. 오전 10:06:14
     * 작성자 : 최영철
     * @param ctrtSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/sendCtrtRequestList.do")
    public String sendCtrtRequestList(@ModelAttribute("searchVO") B2B_CTRTSVO ctrtSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	ctrtSVO.setsOwnCorpId(corpInfo.getCorpId());
    	
    	ctrtSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	ctrtSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(ctrtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(ctrtSVO.getPageUnit());
		paginationInfo.setPageSize(ctrtSVO.getPageSize());

		ctrtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		ctrtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		ctrtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = masB2bCtrtService.selectB2bSendCorpList(ctrtSVO);
		
		@SuppressWarnings("unchecked")
		List<B2B_CTRTVO> resultList = (List<B2B_CTRTVO>) resultMap.get("resultList");
		
		B2B_CORPCONFSVO corpConfSVO = new B2B_CORPCONFSVO();
    	corpConfSVO.setsCorpId(corpInfo.getCorpId());
    	
    	B2B_CORPCONFVO corpConfVO = masB2bService.selectByB2bInfo(corpConfSVO);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("corpConfVO", corpConfVO);
		
    	return "/mas/b2b/sendCtrtRequest";
    	
    }
    
    /**
     * 받은 계약 리스트 페이지
     * 파일명 : tgtCtrtRequestList
     * 작성일 : 2016. 9. 21. 오전 10:06:14
     * 작성자 : 최영철
     * @param ctrtSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/tgtCtrtRequestList.do")
    public String tgtCtrtRequestList(@ModelAttribute("searchVO") B2B_CTRTSVO ctrtSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	ctrtSVO.setsOwnCorpId(corpInfo.getCorpId());
    	
    	ctrtSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	ctrtSVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** paging setting */
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(ctrtSVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(ctrtSVO.getPageUnit());
    	paginationInfo.setPageSize(ctrtSVO.getPageSize());
    	
    	ctrtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	ctrtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	ctrtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    	
    	Map<String, Object> resultMap = masB2bCtrtService.selectB2bTgtCorpList(ctrtSVO);
    	
    	@SuppressWarnings("unchecked")
    	List<B2B_CTRTVO> resultList = (List<B2B_CTRTVO>) resultMap.get("resultList");
    	
    	B2B_CORPCONFSVO corpConfSVO = new B2B_CORPCONFSVO();
    	corpConfSVO.setsCorpId(corpInfo.getCorpId());
    	
    	B2B_CORPCONFVO corpConfVO = masB2bService.selectByB2bInfo(corpConfSVO);
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("totalCnt", resultMap.get("totalCnt"));
    	model.addAttribute("paginationInfo", paginationInfo);
    	model.addAttribute("corpConfVO", corpConfVO);
    	
    	return "/mas/b2b/tgtCtrtRequest";
    	
    }
    
    /**
     * B2B 검색 허용/비허용 처리
     * 파일명 : updateB2bUseCorp
     * 작성일 : 2016. 9. 20. 오후 4:02:31
     * 작성자 : 최영철
     * @param corpVO
     * @return
     */
    @RequestMapping("/mas/b2b/updateB2bUseCorp.ajax")
    public ModelAndView updateB2bUseCorp(@ModelAttribute("corpVO") CORPVO corpVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	corpVO.setCorpId(corpInfo.getCorpId());
    	masB2bService.updateB2bUseCorp(corpVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    	
    }
    
    @RequestMapping("/mas/b2b/ctrtB2bReq.ajax")
	public ModelAndView ctrtB2bReq(@ModelAttribute("B2B_CTRTVO") B2B_CTRTVO ctrtVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		
		B2B_CORPCONFSVO corpConfSVO = new B2B_CORPCONFSVO();
    	corpConfSVO.setsCorpId(corpInfo.getCorpId());
    	
    	B2B_CORPCONFVO corpConfVO = masB2bService.selectByB2bInfo(corpConfSVO);
    	
		ctrtVO.setRequestCorpId(corpInfo.getCorpId());
		ctrtVO.setFrstRegId(corpInfo.getUserId());
		// CTRT_STATUS_CD_REQ(CT02, 계약요청)
		ctrtVO.setStatusCd(Constant.CTRT_STATUS_CD_REQ);
		
		if(Constant.SOCIAL.equals(corpConfVO.getCorpCd())){
			ctrtVO.setSaleAgcCorpId(corpInfo.getCorpId());
			ctrtVO.setSaleCorpId(ctrtVO.getTgtCorpId());
		}else{
			ctrtVO.setSaleAgcCorpId(ctrtVO.getTgtCorpId());
			ctrtVO.setSaleCorpId(corpInfo.getCorpId());
		}
		
		masB2bCtrtService.ctrtB2bReq(ctrtVO);
		
		resultMap.put("success", Constant.FLAG_Y);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
    
    @RequestMapping("/mas/b2b/ctrtRequestList.do")
    public String ctrtRequestList(@ModelAttribute("searchVO") B2B_CTRTSVO ctrtSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	ctrtSVO.setsOwnCorpId(corpInfo.getCorpId());
    	ctrtSVO.setsOwnCorpCd(corpInfo.getCorpCd());
    	
    	ctrtSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	ctrtSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(ctrtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(ctrtSVO.getPageUnit());
		paginationInfo.setPageSize(ctrtSVO.getPageSize());

		ctrtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		ctrtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		ctrtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = masB2bCtrtService.selectB2bCorpList(ctrtSVO);
		
		@SuppressWarnings("unchecked")
		List<B2B_CTRTVO> resultList = (List<B2B_CTRTVO>) resultMap.get("resultList");
		
    	B2B_CORPCONFSVO corpConfSVO = new B2B_CORPCONFSVO();
    	corpConfSVO.setsCorpId(corpInfo.getCorpId());
    	
    	B2B_CORPCONFVO corpConfVO = masB2bService.selectByB2bInfo(corpConfSVO);
    	
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("corpConfVO", corpConfVO);
		
    	return "/mas/b2b/ctrtRequest";
    	
    }
    
    @RequestMapping("/mas/b2b/selectCtrtInfo.ajax")
    public ModelAndView selectCtrtInfo(@ModelAttribute("B2B_CTRTVO") B2B_CTRTVO ctrtVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	ctrtVO = masB2bCtrtService.selectCtrtInfo(ctrtVO);
    	// 요청사유 엔터 반환
    	ctrtVO.setRequestRsn(EgovStringUtil.checkHtmlView(ctrtVO.getRequestRsn()));
    	// 반려사유 엔터 반환
    	ctrtVO.setRstrRsn(EgovStringUtil.checkHtmlView(ctrtVO.getRstrRsn()));
    	// 취소사유 엔터 반환
    	ctrtVO.setCancelRsn(EgovStringUtil.checkHtmlView(ctrtVO.getCancelRsn()));
    	
    	resultMap.put("ctrtVO", ctrtVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 계약 요청 취소
     * 파일명 : cancelCtrtB2bReq
     * 작성일 : 2016. 9. 21. 오후 2:10:34
     * 작성자 : 최영철
     * @param ctrtVO
     * @return
     */
    @RequestMapping("/mas/b2b/cancelCtrtB2bReq.ajax")
    public ModelAndView cancelCtrtB2bReq(@ModelAttribute("B2B_CTRTVO") B2B_CTRTVO ctrtVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	masB2bCtrtService.cancelCtrtB2bReq(ctrtVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 계약 승인 처리
     * 파일명 : ctrtConf
     * 작성일 : 2016. 9. 21. 오후 5:45:20
     * 작성자 : 최영철
     * @param ctrtVO
     * @return
     */
    @RequestMapping("/mas/b2b/ctrtConf.ajax")
    public ModelAndView ctrtConf(@ModelAttribute("B2B_CTRTVO") B2B_CTRTVO ctrtVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	// 계약정보 조회
    	ctrtVO = masB2bCtrtService.selectCtrtInfo(ctrtVO);
    	
    	if(ctrtVO == null){
    		resultMap.put("success", Constant.FLAG_N);
    		resultMap.put("errorMsg", "계약정보가 존재하지 않습니다.");
    	}else{
    		if(!Constant.CTRT_STATUS_CD_REQ.equals(ctrtVO.getStatusCd())){
    			resultMap.put("success", Constant.FLAG_N);
        		resultMap.put("errorMsg", "승인 가능한 상태가 아닙니다.");
        	}else{
        		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
        		ctrtVO.setLastModId(corpInfo.getUserId());
        		// CTRT_STATUS_CD_APPR(CT03, 계약승인)
        		ctrtVO.setStatusCd(Constant.CTRT_STATUS_CD_APPR);
        		masB2bCtrtService.ctrtConf(ctrtVO);
        		
        		resultMap.put("success", Constant.FLAG_Y);
        	}
    	}
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 계약 요청 반려 처리
     * 파일명 : ctrtRstr
     * 작성일 : 2016. 9. 22. 오후 3:53:52
     * 작성자 : 최영철
     * @param ctrtVO
     * @return
     */
    @RequestMapping("/mas/b2b/ctrtRstr.ajax")
    public ModelAndView ctrtRstr(@ModelAttribute("B2B_CTRTVO") B2B_CTRTVO ctrtVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	// 계약정보 조회
    	B2B_CTRTVO ctrtVO2 = masB2bCtrtService.selectCtrtInfo(ctrtVO);
    	
    	if(ctrtVO2 == null){
    		resultMap.put("success", Constant.FLAG_N);
    		resultMap.put("errorMsg", "계약정보가 존재하지 않습니다.");
    	}else{
    		if(!Constant.CTRT_STATUS_CD_REQ.equals(ctrtVO2.getStatusCd())){
    			resultMap.put("success", Constant.FLAG_N);
        		resultMap.put("errorMsg", "반려 가능한 상태가 아닙니다.");
        	}else{
        		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
        		ctrtVO2.setLastModId(corpInfo.getUserId());
        		// CTRT_STATUS_CD_REJECT(CT04, 계약반려)
        		ctrtVO2.setStatusCd(Constant.CTRT_STATUS_CD_REJECT);
        		ctrtVO2.setRstrRsn(ctrtVO.getRstrRsn());
        		masB2bCtrtService.ctrtRstr(ctrtVO2);
        		
        		resultMap.put("success", Constant.FLAG_Y);
        	}
    	}
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 계약중인 업체 조회
     * 파일명 : ctrtCorpList
     * 작성일 : 2016. 9. 22. 오후 3:54:12
     * 작성자 : 최영철
     * @param ctrtSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/ctrtCorpList.do")
    public String ctrtCorpList(@ModelAttribute("searchVO") B2B_CTRTSVO ctrtSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	ctrtSVO.setsOwnCorpId(corpInfo.getCorpId());
    	ctrtSVO.setsOwnCorpCd(corpInfo.getCorpCd());
    	
    	ctrtSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	ctrtSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(ctrtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(ctrtSVO.getPageUnit());
		paginationInfo.setPageSize(ctrtSVO.getPageSize());

		ctrtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		ctrtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		ctrtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = masB2bCtrtService.selectCtrtCorpList(ctrtSVO);
		
		@SuppressWarnings("unchecked")
		List<B2B_CTRTVO> resultList = (List<B2B_CTRTVO>) resultMap.get("resultList");
		
    	B2B_CORPCONFSVO corpConfSVO = new B2B_CORPCONFSVO();
    	corpConfSVO.setsCorpId(corpInfo.getCorpId());
    	
    	B2B_CORPCONFVO corpConfVO = masB2bService.selectByB2bInfo(corpConfSVO);
    	
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("corpConfVO", corpConfVO);
		
    	return "/mas/b2b/ctrtCorpList";
    }
    
    /**
     * 계약취소요청
     * 파일명 : ctrtCancelReq
     * 작성일 : 2016. 9. 23. 오전 11:36:15
     * 작성자 : 최영철
     * @param ctrtVO
     * @return
     */
    @RequestMapping("/mas/b2b/ctrtCancelReq.ajax")
    public ModelAndView ctrtCancelReq(@ModelAttribute("B2B_CTRTVO") B2B_CTRTVO ctrtVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	// 계약정보 조회
    	B2B_CTRTVO ctrtVO2 = masB2bCtrtService.selectCtrtInfo(ctrtVO);
    	
    	if(ctrtVO2 == null){
    		resultMap.put("success", Constant.FLAG_N);
    		resultMap.put("errorMsg", "계약정보가 존재하지 않습니다.");
    	}else{
    		if(!Constant.CTRT_STATUS_CD_APPR.equals(ctrtVO2.getStatusCd())){
    			resultMap.put("success", Constant.FLAG_N);
        		resultMap.put("errorMsg", "계약 취소가 가능한 상태가 아닙니다.");
        	}else{
        		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
        		ctrtVO2.setLastModId(corpInfo.getUserId());
        		// CTRT_STATUS_CD_CANCEL_REQ(CT05, 계약취소요청)
        		ctrtVO2.setStatusCd(Constant.CTRT_STATUS_CD_CANCEL_REQ);
        		ctrtVO2.setCancelRsn(ctrtVO.getCancelRsn());
        		masB2bCtrtService.ctrtCancelReq(ctrtVO2);
        		
        		resultMap.put("success", Constant.FLAG_Y);
        	}
    	}
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
}
