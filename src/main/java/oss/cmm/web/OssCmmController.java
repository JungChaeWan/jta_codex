package oss.cmm.web;


import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDSVO;
import oss.cmm.vo.CDVO;
import oss.corp.vo.CMSSPGSVO;
import oss.corp.vo.CMSSPGVO;
import oss.corp.vo.CMSSSVO;
import oss.corp.vo.CMSSVO;
import oss.user.vo.USERVO;

/**
 * @author 최영철
 * @since  2015. 9. 16.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@Controller
public class OssCmmController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name="ossCmmService")
	protected OssCmmService ossCmmService;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    		
	/**
	 * 코드 리스트 조회
	 * 파일명 : codeList
	 * 작성일 : 2015. 9. 23. 오후 1:32:02
	 * 작성자 : 최영철
	 * @param cdSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/codeList.do")
	public String codeList(@ModelAttribute("searchVO") CDSVO cdSVO,
							ModelMap model){
		log.info("/oss/codeList.do 호출");
		
		cdSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		cdSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(cdSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cdSVO.getPageUnit());
		paginationInfo.setPageSize(cdSVO.getPageSize());

		cdSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cdSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cdSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossCmmService.selectCodeList(cdSVO);
		
		@SuppressWarnings("unchecked")
		List<CDVO> resultList = (List<CDVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "oss/code/codeList";
	}
	
	/**
	 * 코드 등록 View
	 * 파일명 : viewInsCode
	 * 작성일 : 2015. 9. 23. 오후 1:32:11
	 * 작성자 : 최영철
	 * @param cdVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/viewInsertCode.do")
	public String viewInsCode(	@ModelAttribute("code") CDVO cdVO,
								@ModelAttribute("searchVO") CDSVO cdSVO,
    							ModelMap model){
		log.info("/oss/viewInsertCode.do 호출");
		model.addAttribute("code", cdVO);
		return "oss/code/insertCode";
	}
	
	/**
	 * 코드 등록
	 * 파일명 : insertCode
	 * 작성일 : 2015. 9. 23. 오후 1:31:53
	 * 작성자 : 최영철
	 * @param cdVO
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/oss/insertCode.do")
	public String insertCode(	@ModelAttribute("code") CDVO cdVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") CDSVO searchVO,
			            		ModelMap model) throws Exception{
		cdVO.setCdNum(cdVO.getCdNum().toUpperCase());
		cdVO.setHrkCdNum(cdVO.getHrkCdNum().toUpperCase());
		CDSVO cdSVO = new CDSVO();
		cdSVO.setsCdNum(cdVO.getCdNum());

		//코드명 유의어
		cdVO.setCdNmLike(cdVO.getCdNmLike().replace(",","||"));
		
		// validation 체크
		beanValidator.validate(cdVO, bindingResult);
			
		if (bindingResult.hasErrors()){
			log.info("error");
			model.addAttribute("code",cdVO);
			log.info(bindingResult.toString());
			return "oss/code/insertCode";
		}
		
		Map<String, Object> resultMap = ossCmmService.selectCodeList(cdSVO);
		
		Integer chkInt = (Integer) resultMap.get("totalCnt");
		
		// 등록하고자 하는 코드가 존재할 경우
		if(chkInt > 0){
			bindingResult.rejectValue("cdNum", "errors.exist", new Object[]{"코드"},"");
			model.addAttribute("code", cdVO);
			return "oss/code/insertCode";
		}
		
		// 등록하고자 하는 상위 코드가 존재하는지 판단
		cdSVO.setsCdNum(cdVO.getHrkCdNum());
		resultMap = ossCmmService.selectCodeList(cdSVO);
		chkInt = (Integer) resultMap.get("totalCnt");
		
		if(chkInt == 0){
			bindingResult.rejectValue("hrkCdNum", "errors.notExsist", new Object[]{"상위코드"},"");
			model.addAttribute("code", cdVO);
			return "oss/code/insertCode";
		}
		
		// 코드 등록
		ossCmmService.insertCode(cdVO);
		
		return "redirect:/oss/codeList.do?sCdNm=" + URLEncoder.encode(searchVO.getsCdNm(), "UTF-8") 
									+ "&sHrkCdNum=" + URLEncoder.encode(searchVO.getsHrkCdNum(), "UTF-8");
	}
	
	/**
	 * 코드 수정화면 View
	 * 파일명 : viewUdtCode
	 * 작성일 : 2015. 9. 23. 오후 2:27:48
	 * 작성자 : 최영철
	 * @param cdVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/viewUpdateCode.do")
	public String viewUpdateCode(	@ModelAttribute("code") CDVO cdVO,
									@ModelAttribute("searchVO") CDSVO searchVO,
									ModelMap model){
		log.info("/oss/viewUdtCode.do 호출");
		// 코드 단건 조회
		CDVO codeVO = ossCmmService.selectByCd(cdVO);
		model.addAttribute("code", codeVO);
		
		if(codeVO.getHrkCdNum() != null && !codeVO.getHrkCdNum().isEmpty()){
			Integer maxViewSn = ossCmmService.selectByMaxViewSn(codeVO);
			model.addAttribute("maxViewSn", maxViewSn);
		}
		
		return "oss/code/updateCode";
	}
	
	/**
	 * 코드 수정
	 * 파일명 : updateCode
	 * 작성일 : 2015. 9. 23. 오후 3:05:21
	 * 작성자 : 최영철
	 * @param cdVO
	 * @param bindingResult
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/oss/updateCode.do")
	public String updateCode(	@ModelAttribute("code") CDVO cdVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") CDSVO searchVO,
					    		ModelMap model) throws Exception{
		// 코드 변경전 데이터 조회
		CDVO oldVO = ossCmmService.selectByCd(cdVO);

		//코드명 유의어
		cdVO.setCdNmLike(cdVO.getCdNmLike().replace(",","||"));

		oldVO.setOldSn(oldVO.getViewSn());
		oldVO.setNewSn(cdVO.getViewSn());
		CDSVO cdSVO = new CDSVO();
		// 등록하고자 하는 상위 코드가 존재하는지 판단
		cdSVO.setsCdNum(cdVO.getHrkCdNum());
		Map<String, Object> resultMap = ossCmmService.selectCodeList(cdSVO);
		Integer chkInt = (Integer) resultMap.get("totalCnt");
		
		if(chkInt == 0){
			bindingResult.rejectValue("hrkCdNum", "errors.notExsist", new Object[]{"상위코드"},"");
			model.addAttribute("code", cdVO);
			return "oss/code/insCode";
		}
		
		// 상위 코드가 존재하는 경우
		if(oldVO.getHrkCdNum() != null && !oldVO.getHrkCdNum().isEmpty()){
			// 노출 순서가 변경되었을 경우에만 실행
			if(!oldVO.getNewSn().equals(oldVO.getOldSn())){
				if(Integer.parseInt(oldVO.getViewSn()) > Integer.parseInt(cdVO.getViewSn())){
					// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
					ossCmmService.addViewSn(oldVO);
				}else{
					ossCmmService.minusViewSn(oldVO);
				}
			}
		}
		
		// 코드 수정
		ossCmmService.updateCode(cdVO);
		return "redirect:/oss/codeList.do?sCdNm=" + URLEncoder.encode(searchVO.getsCdNm(), "UTF-8") 
									+ "&sHrkCdNum=" + URLEncoder.encode(searchVO.getsHrkCdNum(), "UTF-8");
	}
	
	/**
	 * 코드 삭제
	 * 파일명 : deleteCode
	 * 작성일 : 2015. 9. 23. 오후 3:05:04
	 * 작성자 : 최영철
	 * @param cdVO
	 * @param bindingResult
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/oss/deleteCode.do")
	public String deleteCode(	@ModelAttribute("code") CDVO cdVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") CDSVO searchVO,
    							ModelMap model) throws Exception{
		CDSVO cdSVO = new CDSVO();
		
		// 코드 변경전 데이터 조회
		CDVO oldVO = ossCmmService.selectByCd(cdVO);
				
		// 삭제할 코드가 하위 코드를 가지고 있는지 판단
		cdSVO.setsHrkCdNum(oldVO.getCdNum());
		Map<String, Object> resultMap = ossCmmService.selectCodeList(cdSVO);
		Integer chkInt = (Integer) resultMap.get("totalCnt");
		
		if(chkInt > 0){
			bindingResult.rejectValue("cdNum", "fail.common.delete.exist", new Object[]{"하위코드"},"");
			model.addAttribute("code", cdVO);
			return "oss/code/updateCode";
		}
		
		// 상위 코드가 존재하는 경우
		if(oldVO.getHrkCdNum() != null && !oldVO.getHrkCdNum().isEmpty()){
			cdVO.setOldSn(cdVO.getViewSn());
			ossCmmService.minusViewSn(cdVO);
		}
		
		ossCmmService.deleteCode(cdVO);
		
		return "redirect:/oss/codeList.do?sCdNm=" + URLEncoder.encode(searchVO.getsCdNm(), "UTF-8") 
									+ "&sHrkCdNum=" + URLEncoder.encode(searchVO.getsHrkCdNum(), "UTF-8");
	}
	
	@RequestMapping("/validator.do")
	public String validate(){
		return "common/validator";
	}
	
	/**
	 * 상위 코드 조회
	 * 파일명 : getHrkCode
	 * 작성일 : 2015. 9. 23. 오후 1:49:37
	 * 작성자 : 최영철
	 * @param params
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getHrkCode.ajax")
	public ModelAndView getHrkCode(	@RequestParam Map<String, String> params,
								ModelMap model) throws Exception{
		// 사용가능 상위 코드 전체 조회
		List<CDVO> cdList = ossCmmService.selectHrkCodeList();
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cdList", cdList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
			
		return mav;
	}
	
	/**
	 * 상위 코드로 하위코드 조회
	 * 파일명 : ajax
	 * 작성일 : 2015. 9. 23. 오후 1:49:37
	 * 작성자 : 최영철
	 * @param cdNum
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getCodeList.ajax")
	public ModelAndView getCodeListAjax(	@RequestParam String cdNum,
								ModelMap model) throws Exception{
		// 사용가능 코드 조회
		List<CDVO> cdList = ossCmmService.selectCode(cdNum);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cdList", cdList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
			
		return mav;
	}

	/**
	 * 수수료 리스트
	 * 파일명 : cmssList
	 * 작성일 : 2016. 8. 11. 오후 1:36:59
	 * 작성자 : 최영철
	 * @param searchVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/cmssList.do")
	public String cmssList(@ModelAttribute("searchVO") CMSSSVO searchVO, ModelMap model){
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossCmmService.selectCmssList(searchVO);
		
		@SuppressWarnings("unchecked")
		List<CMSSVO> cmssList = (List<CMSSVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", cmssList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "oss/env/cmssList";
	}
	
	/**
	 * 수수료 등록
	 * 파일명 : inseertCmss
	 * 작성일 : 2016. 8. 11. 오후 2:57:50
	 * 작성자 : 최영철
	 * @param cmssVO
	 * @return
	 */
	@RequestMapping("/oss/insertCmss.ajax")
	public ModelAndView inseertCmss(@ModelAttribute("CMSSVO") CMSSVO cmssVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		cmssVO.setRegId(corpInfo.getUserId());
		cmssVO.setModId(corpInfo.getUserId());
		
		ossCmmService.insertCmss(cmssVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	/**
	 * 수수료 단건 조회
	 * 파일명 : selectByCmss
	 * 작성일 : 2016. 8. 11. 오후 2:57:42
	 * 작성자 : 최영철
	 * @param cmssVO
	 * @return
	 */
	@RequestMapping("/oss/selectByCmss.ajax")
	public ModelAndView selectByCmss(@ModelAttribute("CMSSVO") CMSSVO cmssVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		cmssVO = ossCmmService.selectByCmss(cmssVO);
		
		resultMap.put("cmssVO", cmssVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	/**
	 * 수수료 수정
	 * 파일명 : updateCmss
	 * 작성일 : 2016. 8. 11. 오후 3:08:26
	 * 작성자 : 최영철
	 * @param cmssVO
	 * @return
	 */
	@RequestMapping("/oss/updateCmss.ajax")
	public ModelAndView updateCmss(@ModelAttribute("CMSSVO") CMSSVO cmssVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		cmssVO.setRegId(corpInfo.getUserId());
		cmssVO.setModId(corpInfo.getUserId());
		cmssVO.setConfDiv("UDT");
		ossCmmService.updateCmss(cmssVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	/**
	 * 해당 수수료 사용 업체 카운트
	 * 파일명 : deleteChkCmss
	 * 작성일 : 2016. 8. 18. 오후 1:17:57
	 * 작성자 : 최영철
	 * @param cmssVO
	 * @return
	 */
	@RequestMapping("/oss/deleteChkCmss.ajax")
	public ModelAndView deleteChkCmss(@ModelAttribute("CMSSVO") CMSSVO cmssVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Integer chkVal = ossCmmService.deleteChkCmss(cmssVO);
		
		resultMap.put("chkVal", chkVal);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	/**
	 * 수수료 삭제
	 * 파일명 : deleteCmss
	 * 작성일 : 2016. 8. 18. 오후 1:27:14
	 * 작성자 : 최영철
	 * @param cmssVO
	 * @return
	 */
	@RequestMapping("/oss/deleteCmss.ajax")
	public ModelAndView deleteCmss(@ModelAttribute("CMSSVO") CMSSVO cmssVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ossCmmService.deleteCmss(cmssVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	/**
	 * PG사 수수료 리스트
	 * 파일명 : cmssPgList
	 * 작성일 : 2020.10.30
	 * 작성자 : 김지연
	 * @param searchVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/cmssPgList.do")
	public String cmssPgList(@ModelAttribute("searchVO") CMSSPGSVO searchVO, ModelMap model){
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossCmmService.selectCmssPgList(searchVO);
		
		@SuppressWarnings("unchecked")
		List<CMSSPGSVO> cmssPgList = (List<CMSSPGSVO>) resultMap.get("resultList");
		List<CDVO> comCdList = ossCmmService.selectCode(Constant.PG_CMSS_DIV);
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", cmssPgList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("comCdList", comCdList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "oss/env/cmssPgList";
	}	
	
	/**
	 * PG사 수수료 등록
	 * 파일명 : insertCmssPg
	 * 작성일 : 2020.11.02
	 * 작성자 : 김지연
	 * @param cmssVO
	 * @return
	 */
	@RequestMapping("/oss/insertCmssPg.ajax")
	public ModelAndView insertCmssPg(@ModelAttribute("CMSSPGVO") CMSSPGVO cmssPgVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ossCmmService.insertCmssPg(cmssPgVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}	
	
	/**
	 * PG사 수수료 삭제
	 * 파일명 : deleteCmssPg
	 * 작성일 : 2020.11.02
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 * @return
	 */
	@RequestMapping("/oss/deleteCmssPg.ajax")
	public ModelAndView deleteCmssPg(@ModelAttribute("CMSSPGVO") CMSSPGVO cmssPgVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ossCmmService.deleteCmssPg(cmssPgVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}	
	
	/**
	 * PG사 수수료 단건 조회
	 * 파일명 : selectByCmssPg
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param CMSSPGVO
	 * @return
	 */
	@RequestMapping("/oss/selectByCmssPg.ajax")
	public ModelAndView selectByCmssPg(@ModelAttribute("CMSSPGVO") CMSSPGVO cmssPgVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		cmssPgVO = ossCmmService.selectByCmssPg(cmssPgVO);
		
		resultMap.put("cmssPgVO", cmssPgVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}	
	
	/**
	 * PG사 수수료 수정
	 * 파일명 : updateCmssPg
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 * @return
	 */
	@RequestMapping("/oss/updateCmssPg.ajax")
	public ModelAndView updateCmssPg(@ModelAttribute("CMSSPGVO") CMSSPGVO cmssPgVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ossCmmService.updateCmssPg(cmssPgVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}	
	
	/**
	 * PG사 수수료 날짜 중복 체크
	 * 파일명 : checkAplDt
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param CMSSPGVO
	 * @return
	 */
	@RequestMapping("/oss/checkAplDt.do")
	public ModelAndView checkAplDt(@ModelAttribute("CMSSPGVO") CMSSPGVO cmssPgVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Integer chkVal = ossCmmService.checkAplDt(cmssPgVO);
		
		resultMap.put("chkVal", chkVal);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}	
	
}
