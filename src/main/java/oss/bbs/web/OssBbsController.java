package oss.bbs.web;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import common.EgovUserDetailsHelper;

import oss.bbs.service.OssBbsService;
import oss.bbs.vo.BBSGRPINFSVO;
import oss.bbs.vo.BBSGRPINFVO;
import oss.bbs.vo.BBSGRPSVO;
import oss.bbs.vo.BBSGRPVO;
import oss.bbs.vo.BBSSVO;
import oss.bbs.vo.BBSVO;
import oss.user.vo.USERVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 관리자- 게시판
 * 파일명 : OssBbsController.java
 * 작성일 : 2015. 10. 1. 오후 2:55:45
 * 작성자 : 신우섭
 */
@Controller
public class OssBbsController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
    
    
//    @Resource(name="ossCmmService")
//    private OssCmmService ossCmmService;
    
    @Resource(name="ossBbsService")
    private OssBbsService ossBbsService;

    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    		
	/**
	 * 업체 리스트 조회
	 * 파일명 : corpList
	 * 작성일 : 2015. 9. 21. 오전 9:29:18
	 * 작성자 : 최영철
	 * @param corpSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/bbsList.do")
	public String bbsList(@ModelAttribute("searchVO") BBSSVO bbsSVO,
							ModelMap model){
		log.info("/oss/bbsList.do 호출");
		//log.info("/oss/bbsList.do 호출:" + bbsSVO.getsKey() + ":" + bbsSVO.getsKeyOpt() );
		
		bbsSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		bbsSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bbsSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bbsSVO.getPageUnit());
		paginationInfo.setPageSize(bbsSVO.getPageSize());

		bbsSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bbsSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bbsSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		if("1".equals(bbsSVO.getsKeyOpt()) ){
			bbsSVO.setsKey(bbsSVO.getsKey().toUpperCase());
		}
		
		Map<String, Object> resultMap = ossBbsService.selectBbsList(bbsSVO);
		
		@SuppressWarnings("unchecked")
		List<BBSVO> resultList = (List<BBSVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "oss/bbs/bbsList";
	}
	
	
	/**
	 * 게시판 등록 뷰
	 * 파일명 : viewInsertBbs
	 * 작성일 : 2015. 10. 2. 오후 1:07:30
	 * 작성자 : 신우섭
	 * @param bbsVO
	 * @param bbsSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/viewInsertBbs.do")
	public String viewInsertBbs(@ModelAttribute("BBSVO") BBSVO bbsVO,
								  	@ModelAttribute("searchVO") BBSSVO bbsSVO,
									ModelMap model)
	{
		log.info("/oss/viewInsertBbs.do 호출");
		model.addAttribute("bbs", bbsVO);
		return "oss/bbs/insertBbs";
	}
	

	/**
	 * 게시판 등록
	 * 파일명 : insertBbs
	 * 작성일 : 2015. 10. 2. 오전 11:40:16
	 * 작성자 : 신우섭
	 * @param bbsVO
	 * @param bindingResult
	 * @param searchVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/insertBbs.do")
	public String insertBbs(@ModelAttribute("BBSVO") BBSVO bbsVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") BBSSVO searchVO,
					    		ModelMap model)
	{
		log.info("/oss/insertBbs.do 호출");
		
		bbsVO.setBbsNum(bbsVO.getBbsNum().toUpperCase());
			
		// validation 체크
		beanValidator.validate(bbsVO, bindingResult);
		if (bindingResult.hasErrors()){
			log.info("error");
			model.addAttribute("bbs",bbsVO);
			log.info(bindingResult.toString());
			return "oss/bbs/insertBbs";
		}
		
		
		//같은 게시판 번호가 있는지 검사
		BBSSVO bbsSVO = new BBSSVO();		
		bbsSVO.setsBbsNum(bbsVO.getBbsNum());
		BBSVO chkVO = ossBbsService.selectByBbs(bbsSVO);
		if(chkVO != null){
			bindingResult.rejectValue("bbsNum", "errors.exist", new Object[]{"게시판 ID"},"");
			model.addAttribute("bbs", bbsVO);
			return "oss/bbs/insertBbs";
		}
		
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		bbsVO.setFrstRegId(userVO.getUserId());
		ossBbsService.insertBbs(bbsVO);
		
		return "redirect:/oss/bbsList.do";
	}
	
	
	/**
	 * 게시판 수정 뷰
	 * 파일명 : viewUpdateBbs
	 * 작성일 : 2015. 10. 2. 오후 1:07:10
	 * 작성자 : 신우섭
	 * @param bbsVO
	 * @param searchVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/viewUpdateBbs.do")
	public String viewUpdateBbs(	@ModelAttribute("BBSVO") BBSVO bbsVO,
									@ModelAttribute("searchVO") BBSSVO searchVO,
									ModelMap model){
		log.info("/oss/viewUpdateBbs.do 호출");
		
		BBSSVO bbsSVO = new BBSSVO();		
		bbsSVO.setsBbsNum(bbsVO.getBbsNum());
		BBSVO chkVO = ossBbsService.selectByBbs(bbsSVO);
		model.addAttribute("bbs", chkVO);
		
		return "oss/bbs/updateBbs";
	}

	
	/**
	 * 게시판 수정
	 * 파일명 : updateBbs
	 * 작성일 : 2015. 10. 2. 오후 1:09:41
	 * 작성자 : 신우섭
	 * @param bbsVO
	 * @param bindingResult
	 * @param searchVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/updateBbs.do")
	public String updateBbs(	@ModelAttribute("BBSVO") BBSVO bbsVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") BBSSVO searchVO,
					    		ModelMap model){
		//log.info("/oss/updateBbs.do 호출");
		
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		bbsVO.setLastModId(userVO.getUserId() );
		
		ossBbsService.updateBbs(bbsVO);
		
		return "redirect:/oss/bbsList.do";
	}
	
	
	@RequestMapping("/oss/deleteBbs.do")
	public String deleteBbs(	@ModelAttribute("BBSVO") BBSVO bbsVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") BBSSVO searchVO,
    							ModelMap model){

		ossBbsService.deleteBbs(bbsVO);
		
		return "redirect:/oss/bbsList.do";
	}
	
	
	/**
	 * 게시판 그룹 목록
	 * 파일명 : bbsGrpList
	 * 작성일 : 2015. 10. 2. 오후 3:19:06
	 * 작성자 : 신우섭
	 * @param bbsGrpInfSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/bbsGrpList.do")
	public String bbsGrpList(@ModelAttribute("searchVO") BBSGRPINFSVO bbsGrpInfSVO,
							ModelMap model){
		log.info("/oss/bbsGrpList.do 호출");
		//log.info("/oss/bbsList.do 호출:" + bbsSVO.getsKey() + ":" + bbsSVO.getsKeyOpt() );
		
		bbsGrpInfSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		bbsGrpInfSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bbsGrpInfSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bbsGrpInfSVO.getPageUnit());
		paginationInfo.setPageSize(bbsGrpInfSVO.getPageSize());

		bbsGrpInfSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bbsGrpInfSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bbsGrpInfSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
		Map<String, Object> resultMap = ossBbsService.selectBbsGrpInfList(bbsGrpInfSVO);
		
		@SuppressWarnings("unchecked")
		List<BBSGRPINFVO> resultList = (List<BBSGRPINFVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "oss/bbs/bbsGrpList";
	}
	
	
	@RequestMapping("/oss/viewInsertBbsGrp.do")
	public String viewInsertBbsGrp(@ModelAttribute("BBSGRPINFVO") BBSGRPINFVO bbsGrpInfVO,
								  	@ModelAttribute("searchVO") BBSGRPINFSVO bbsGrpInfSVO,
									ModelMap model)
	{
		log.info("/oss/viewInsertBbsGrp.do 호출");
		model.addAttribute("bbsGrp", bbsGrpInfVO);
		return "oss/bbs/insertBbsGrp";
	}
	
	@RequestMapping("/oss/insertBbsGrp.do")
	public String insertBbsGrp(@ModelAttribute("BBSGRPINFVO") BBSGRPINFVO bbsGrpInfVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") BBSGRPINFSVO bbsGrpInfSVO,
					    		ModelMap model)
	{
		log.info("/oss/insertBbsGrp.do 호출");
		
		// validation 체크
		beanValidator.validate(bbsGrpInfVO, bindingResult);
		if (bindingResult.hasErrors()){
			log.info("error");
			model.addAttribute("bbsGrp",bbsGrpInfVO);
			log.info(bindingResult.toString());
			return "oss/bbs/insertBbsGrp";
		}
		
		ossBbsService.insertBbsGrpInf(bbsGrpInfVO);
		
		return "redirect:/oss/bbsGrpList.do";
	}
	
	
	@RequestMapping("/oss/viewUpdateBbsGrp.do")
	public String viewUpdateBbsGrp(	@ModelAttribute("BBSGRPINFVO") BBSGRPINFVO bbsGrpInfVO,
									@ModelAttribute("searchVO") BBSGRPINFSVO bbsGrpInfSVO,
									ModelMap model){
		log.info("/oss/viewUpdateBbsGrp.do 호출");
		
		//기본정보 얻기
		bbsGrpInfSVO.setsBbsGrpNum(bbsGrpInfVO.getBbsGrpNum());
		
		BBSGRPINFVO resVO = ossBbsService.selectByBbsGrpInf(bbsGrpInfSVO);
		model.addAttribute("bbsGrp", resVO);
		
		
		//BBSGRP 목록 얻기
		BBSGRPSVO bbsGrpSVO = new BBSGRPSVO();
		bbsGrpSVO.setsBbsGrpNum(bbsGrpInfVO.getBbsGrpNum());
		Map<String, Object> resultMap = ossBbsService.selectBbsGrpList(bbsGrpSVO);

		@SuppressWarnings("unchecked")
		List<BBSGRPVO> resultList = (List<BBSGRPVO>) resultMap.get("resultList");
		model.addAttribute("resultList", resultList);
		
		return "oss/bbs/updateBbsGrp";
	}
	
	@RequestMapping("/oss/updateBbsGrp.do")
	public String updateBbsGrp(	@ModelAttribute("BBSGRPINFVO") BBSGRPINFVO bbsGrpInfVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") BBSGRPINFSVO bbsGrpInfSVO,
					    		ModelMap model){
		log.info("/oss/updateBbsGrp.do 호출");
		
		ossBbsService.updateBbsGrpInf(bbsGrpInfVO);
		
		return "redirect:/oss/bbsGrpList.do";
	}
	
	@RequestMapping("/oss/deleteBbsGrp.do")
	public String deleteBbsGrp(	@ModelAttribute("BBSGRPINFVO") BBSGRPINFVO bbsGrpInfVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") BBSGRPINFSVO bbsGrpInfSVO,
					    		ModelMap model){
		log.info("/oss/deleteBbsGrp.do 호출");


		//BBSGRP 에꺼 부터 삭제
		BBSGRPVO bbsGrpVO = new BBSGRPVO();
		bbsGrpVO.setBbsGrpNum(bbsGrpInfVO.getBbsGrpNum());
		ossBbsService.deleteBbsGrpAll(bbsGrpVO);

		
		ossBbsService.deleteBbsGrpInf(bbsGrpInfVO);
		
		return "redirect:/oss/bbsGrpList.do";
	}
	
	
	@RequestMapping("/oss/viewInsertBbsGrpRel.do")
	public String viewInsertBbsGrpRel(@ModelAttribute("BBSGRPVO") BBSGRPVO bbsGrpVO,
								  	@ModelAttribute("searchVO") BBSGRPSVO bbsGrpSVO,
									ModelMap model)
	{
		log.info("/oss/viewInsertBbsGrpRel.do 호출");
		
		BBSGRPINFSVO bbsGrpInfSVO = new BBSGRPINFSVO();
		bbsGrpInfSVO.setsBbsGrpNum(bbsGrpVO.getBbsGrpNum());
		BBSGRPINFVO resVO = ossBbsService.selectByBbsGrpInf(bbsGrpInfSVO);
		model.addAttribute("bbsGrp", resVO);
		
		model.addAttribute("bbsGrpRel", bbsGrpVO);
				
		return "oss/bbs/insertBbsGrpRel";
	}
	
	@RequestMapping("/oss/insertBbsGrpRel.do")
	public String insertBbsGrpRel(@ModelAttribute("BBSGRPVO") BBSGRPVO bbsGrpVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") BBSGRPSVO bbsGrpSVO,
					    		ModelMap model)
	{
		log.info("/oss/insertBbsGrpRel.do 호출");
		
		// validation 체크
		beanValidator.validate(bbsGrpVO, bindingResult);
		if (bindingResult.hasErrors()){
			log.info("error");
			model.addAttribute("bbsGrpRel",bbsGrpVO);
			log.info(bindingResult.toString());
			return "oss/bbs/insertBbsGrpRel";
		}
		
		
		//같은 게시판 번호가 있는지 검사
		int nChkBbsGrpCnt = ossBbsService.getCntByBbsInf(bbsGrpVO);
		if(nChkBbsGrpCnt != 0){
			bindingResult.rejectValue("bbsNum", "errors.exist", new Object[]{"게시판 ID"},"");
			
			BBSGRPINFSVO bbsGrpInfSVO = new BBSGRPINFSVO();
			bbsGrpInfSVO.setsBbsGrpNum(bbsGrpVO.getBbsGrpNum());
			BBSGRPINFVO resVO = ossBbsService.selectByBbsGrpInf(bbsGrpInfSVO);
			model.addAttribute("bbsGrp", resVO);
			
			model.addAttribute("bbsGrpRel", bbsGrpVO);
			return "oss/bbs/insertBbsGrpRel";
		}
		
		//게시판이 있는지검사
		BBSVO bbsSVO = new BBSVO();		
		bbsSVO.setsBbsNum(bbsGrpVO.getBbsNum());
		BBSVO chkVO = ossBbsService.selectByBbs(bbsSVO);
		if(chkVO == null){
			bindingResult.rejectValue("bbsNum", "errors.notExsist", new Object[]{"게시판 ID"},"");
			
			BBSGRPINFSVO bbsGrpInfSVO = new BBSGRPINFSVO();
			bbsGrpInfSVO.setsBbsGrpNum(bbsGrpVO.getBbsGrpNum());
			BBSGRPINFVO resVO = ossBbsService.selectByBbsGrpInf(bbsGrpInfSVO);
			model.addAttribute("bbsGrp", resVO);
			
			model.addAttribute("bbsGrpRel", bbsGrpVO);
			return "oss/bbs/insertBbsGrpRel";
		}
		
		ossBbsService.insertBbsGrp(bbsGrpVO);
		
		return "redirect:/oss/viewUpdateBbsGrp.do?bbsGrpNum="+bbsGrpVO.getBbsGrpNum();
	}
	
	@RequestMapping("/oss/deleteBbsGrpRel.do")
	public String deleteBbsGrpRe(	@ModelAttribute("BBSGRPVO") BBSGRPVO bbsGrpVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") BBSGRPSVO bbsGrpSVO,
					    		ModelMap model){
		log.info("/oss/deleteBbsGrpRe.do 호출");

		//log.info("/oss/deleteBbsGrpRe.do 호출>"+bbsGrpVO.getBbsGrpNum() + "><" + bbsGrpVO.getBbsNum());

		ossBbsService.deleteBbsGrp(bbsGrpVO);
		
		return "redirect:/oss/viewUpdateBbsGrp.do?bbsGrpNum="+bbsGrpVO.getBbsGrpNum();
	}
	
}
