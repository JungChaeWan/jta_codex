package oss.corp.web;


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

import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.user.vo.USERVO;

import common.Constant;
import common.EgovUserDetailsHelper;

import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class OssB2bCorpController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
    
    @Resource(name="ossCorpService")
    private OssCorpService ossCorpService;
    
    @Resource(name="masB2bService")
    private MasB2bService masB2bService;
    
    @Resource(name="masB2bCtrtService")
    private MasB2bCtrtService masB2bCtrtService;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    		
	/**
	 * B2B 승인 내역 리스트 조회
	 * 파일명 : b2bReqList
	 * 작성일 : 2016. 9. 6. 오후 4:52:03
	 * 작성자 : 최영철
	 * @param corpConfSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/b2bReqList.do")
	public String b2bReqList(@ModelAttribute("searchVO") B2B_CORPCONFSVO corpConfSVO,
							ModelMap model){
		log.info("/oss/b2bReqList.do 호출");
		
		corpConfSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		corpConfSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(corpConfSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(corpConfSVO.getPageUnit());
		paginationInfo.setPageSize(corpConfSVO.getPageSize());

		corpConfSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		corpConfSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		corpConfSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossCorpService.selectB2bCorpList(corpConfSVO);
		
		@SuppressWarnings("unchecked")
		List<B2B_CORPCONFVO> resultList = (List<B2B_CORPCONFVO>) resultMap.get("resultList");
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "oss/b2b/corpList";
	}
	
	/**
	 * 업체 승인 요청 정보 조회
	 * 파일명 : selectB2bReqInfo
	 * 작성일 : 2016. 9. 9. 오후 1:25:24
	 * 작성자 : 최영철
	 * @param corpConfSVO
	 * @return
	 */
	@RequestMapping("/oss/selectB2bReqInfo.ajax")
	public ModelAndView selectB2bReqInfo(@ModelAttribute("B2B_CORPCONFSVO") B2B_CORPCONFSVO corpConfSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		B2B_CORPCONFVO corpConfVO = masB2bService.selectByB2bInfo(corpConfSVO);
		
		resultMap.put("corpConfVO", corpConfVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	/**
	 * 반려처리
	 * 파일명 : rstrB2bReq
	 * 작성일 : 2016. 9. 9. 오후 1:25:37
	 * 작성자 : 최영철
	 * @param corpConfVO
	 * @return
	 */
	@RequestMapping("/oss/rstrB2bReq.ajax")
	public ModelAndView rstrB2bReq(@ModelAttribute("B2B_CORPCONFVO") B2B_CORPCONFVO corpConfVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		B2B_CORPCONFSVO corpConfSVO = new B2B_CORPCONFSVO();
		corpConfSVO.setsCorpId(corpConfVO.getCorpId());
		
		B2B_CORPCONFVO corpConfVO2 = masB2bService.selectByB2bInfo(corpConfSVO);
		
		if(corpConfVO2 == null){
			resultMap.put("success", Constant.FLAG_N);
			resultMap.put("errorMsg", "B2B 사용을 요청한 업체가 아닙니다");
		}
		else if(!Constant.TRADE_STATUS_APPR_REQ.equals(corpConfVO2.getStatusCd())){
			resultMap.put("success", Constant.FLAG_N);
			resultMap.put("errorMsg", "반려 가능한 상태가 아닙니다.");
		}else{
			USERVO userInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
			corpConfVO.setLastModId(userInfo.getUserId());
			corpConfVO.setStatusCd(Constant.TRADE_STATUS_APPR_REJECT);
			masB2bService.rstrB2bReq(corpConfVO);
			resultMap.put("success", Constant.FLAG_Y);
		}
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	/**
	 * 업체 승인 처리
	 * 파일명 : b2bConf
	 * 작성일 : 2016. 9. 9. 오후 1:31:43
	 * 작성자 : 최영철
	 * @param corpConfVO
	 * @return
	 */
	@RequestMapping("/oss/b2bConf.ajax")
	public ModelAndView b2bConf(@ModelAttribute("B2B_CORPCONFVO") B2B_CORPCONFVO corpConfVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		B2B_CORPCONFSVO corpConfSVO = new B2B_CORPCONFSVO();
		corpConfSVO.setsCorpId(corpConfVO.getCorpId());
		
		B2B_CORPCONFVO corpConfVO2 = masB2bService.selectByB2bInfo(corpConfSVO);
		
		if(corpConfVO2 == null){
			resultMap.put("success", Constant.FLAG_N);
			resultMap.put("errorMsg", "B2B 사용을 요청한 업체가 아닙니다");
		}
		// 승인요청중인 상태에서 승인 가능
		else if(!Constant.TRADE_STATUS_APPR_REQ.equals(corpConfVO2.getStatusCd())){
			resultMap.put("success", Constant.FLAG_N);
			resultMap.put("errorMsg", "승인 가능한 상태가 아닙니다.");
		}else{
			USERVO userInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
			corpConfVO.setLastModId(userInfo.getUserId());
			// TRADE_STATUS_APPR(TS03, 승인)
			corpConfVO.setStatusCd(Constant.TRADE_STATUS_APPR);
			masB2bService.confB2bReq(corpConfVO);
			
			// B2B 사용여부 승인 처리
        	CORPVO corpVO = new CORPVO();
        	corpVO.setCorpId(corpConfVO.getCorpId());
        	corpVO.setB2bUseYn(Constant.FLAG_Y);
        	
        	masB2bService.updateB2bUseCorp(corpVO);
        	
			resultMap.put("success", Constant.FLAG_Y);
		}
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	@RequestMapping("/oss/b2bCtrtList.do")
	public String b2bctrtList(@ModelAttribute("searchVO") B2B_CTRTSVO ctrtSVO,
    		ModelMap model){
		
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
		
		Map<String, Object> resultMap = ossCorpService.selectCtrtCorpList(ctrtSVO);
		
		@SuppressWarnings("unchecked")
		List<B2B_CTRTVO> resultList = (List<B2B_CTRTVO>) resultMap.get("resultList");
		
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "oss/b2b/ctrtCorpList";
	}
	
	@RequestMapping("/oss/b2b/selectCtrtInfo.ajax")
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
	
}
