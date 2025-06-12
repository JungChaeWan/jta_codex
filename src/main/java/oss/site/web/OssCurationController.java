package oss.site.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.sp.vo.SP_PRDTINFVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.site.service.OssCrtnService;
import oss.site.vo.SVCRTNPRDTVO;
import oss.site.vo.SVCRTNVO;
import oss.user.vo.USERVO;

import common.Constant;
import common.EgovUserDetailsHelper;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 제주특산/기념품 큐레이션 관리
 * 파일명 : OssCurationController.java
 * 작성일 : 2017. 11. 13. 오후 1:31:15
 * 작성자 : 정동수
 */
@Controller
public class OssCurationController {
	@Autowired
    private DefaultBeanValidator beanValidator;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@Resource(name = "ossCrtnService")
	private OssCrtnService ossCrtnService;
	
	@RequestMapping("/oss/svCrtnList.do")
    public String svCrtnList(@ModelAttribute("searchVO") SVCRTNVO crtnVO,
    						ModelMap model){
    	log.info("/oss/svCrtnList.do 호출");
    	
    	crtnVO.setPageUnit(propertiesService.getInt("pageUnit"));
		crtnVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(crtnVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(crtnVO.getPageUnit());
		paginationInfo.setPageSize(crtnVO.getPageSize());

		crtnVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		crtnVO.setLastIndex(paginationInfo.getLastRecordIndex());
		crtnVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossCrtnService.selectCrtnList(crtnVO);

		@SuppressWarnings("unchecked")
		List<SP_PRDTINFVO> resultList = (List<SP_PRDTINFVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
    	
    	return "/oss/site/svCrtnList";
	}
	
	@RequestMapping("/oss/svCrtnRegView.do")
	public String svCrtnRegView(@ModelAttribute("SVCRTNVO") SVCRTNVO crtnVO,
								ModelMap model) {
		log.info("/oss/svCrtnRegView.do call");

		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		return "/oss/site/svCrtnReg";
	}
	
	@RequestMapping("/oss/svCrtnReg.do")
	public String svCrtnReg(@ModelAttribute("SVCRTNVO") SVCRTNVO crtnVO,
							BindingResult bindingResult,
							final MultipartHttpServletRequest multiRequest,
							ModelMap model) throws Exception {
		log.info("/oss/svCrtnReg.do call");

		// validation 체크
		beanValidator.validate(crtnVO, bindingResult);

		if (bindingResult.hasErrors()) {
			log.info("error");
			model.addAttribute("SVCRTNVO", crtnVO);
			log.info(bindingResult.toString());

			return "/oss/site/svCrtnReg";
		}
		
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		crtnVO.setFrstRegId(corpInfo.getUserId());

		String crtnNum = ossCrtnService.insertCrtn(crtnVO, multiRequest);


		List<String> prdtNumList = crtnVO.getPrdtNum();
		if (prdtNumList != null) {
			for (String prdtNumOne : prdtNumList) {
				crtnVO.setCrtnNum(crtnNum);
				crtnVO.setPrdtNumOne(prdtNumOne);
				ossCrtnService.insertCrtnPrdtOne(crtnVO);
			}
		}

		return "redirect:/oss/svCrtnList.do";
	}
	
	@RequestMapping("/oss/svCrtnDtl.do")
	public String svCrtnDtl(@ModelAttribute("SVCRTNVO") SVCRTNVO crtnVO,
									ModelMap model) throws Exception {
		log.info("/oss/eventDtl.do call");

		// 큐레이션 정보가져오기
		SVCRTNVO resultVO = ossCrtnService.selectByCrtn(crtnVO);
		List<SVCRTNPRDTVO> crtnPrdtVO = ossCrtnService.selectCrtnPrdtList(crtnVO);

		model.addAttribute("crtnVO", resultVO);
		model.addAttribute("crtnPrdtList", crtnPrdtVO);
		
		return "/oss/site/svCrtnDtl";
	}
	
	@RequestMapping("/oss/svCrtnModView.do")
	public String svCrtnModView(@ModelAttribute("SVCRTNVO") SVCRTNVO crtnVO,
			ModelMap model) {
		log.info("/oss/svCrtnModView.do call");
		// 큐레이션 정보가져오기
		SVCRTNVO resultVO = ossCrtnService.selectByCrtn(crtnVO);
		
		// 큐레이션 매핑 상품 정보 가져오기.
		List<SVCRTNPRDTVO> crtnPrdtList = ossCrtnService.selectCrtnPrdtList(crtnVO);

		model.addAttribute("crtnVO", resultVO);
		model.addAttribute("crtnPrdtList", crtnPrdtList);
		model.addAttribute("maxSortSn", crtnPrdtList.size());
		
		return "/oss/site/svCrtnMod";
	}

	@RequestMapping("/oss/svCrtnMod.do")
	public String svCrtnMod(@ModelAttribute("SVCRTNVO") SVCRTNVO crtnVO,
		BindingResult bindingResult,
		final MultipartHttpServletRequest multiRequest,
		ModelMap model) throws Exception {
		log.info("/oss/svCrtnMod.do call");

		// validation 체크
		/*
		 * beanValidator.validate(crtnVO, bindingResult);
		 * 
		 * if (bindingResult.hasErrors()) { log.info("error");
		 * model.addAttribute("crtnVO", crtnVO); log.info(bindingResult.toString());
		 * 
		 * return "mas/prmt/updatePromotion"; }
		 */

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		//crtnVO.setCorpId(corpInfo.getCorpId());
		crtnVO.setLastModId(corpInfo.getUserId());

		ossCrtnService.updateCrtn(crtnVO, multiRequest);

		ossCrtnService.deleteCrtnPrdt(crtnVO.getCrtnNum());
		List<String> prdtNumList = crtnVO.getPrdtNum();
		if(prdtNumList != null && prdtNumList.size() > 0) {
			for (String prdtNumOne : prdtNumList) {
				crtnVO.setPrdtNumOne(prdtNumOne);
				ossCrtnService.insertCrtnPrdtOne(crtnVO);
			}
		}

		return "redirect:/oss/svCrtnList.do";
	}
	
	@RequestMapping("/oss/svCrtnPrdtSortMod.ajax")
	public ModelAndView svCrtnPrdtSortMod(@ModelAttribute("SVCRTNVO") SVCRTNPRDTVO crtnPrdtVO) {
		log.info("/mas/svCrtnPrdtSortMod.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		// 정렬 수정
		ossCrtnService.updatePrmtPrdtSort(crtnPrdtVO);

		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}
	
	@RequestMapping("/oss/svCrtnDel.ajax")
	public ModelAndView svCrtnDel(@ModelAttribute("SVCRTNVO") SVCRTNVO crtnVO) {
		log.info("/oss/svCrtnDel.ajax call");
    	Map<String, Object> resultMap = new HashMap<String,Object>();

    	SVCRTNVO resultVO =ossCrtnService.selectByCrtn(crtnVO);

    	if(resultVO == null) {
    		resultMap.put("resultCode", Constant.JSON_FAIL);
			ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
			return modelAndView;
    	}

    	crtnVO.setOldSort(resultVO.getSort());
    	crtnVO.setSort(0);
    	ossCrtnService.deleteCrtnPrdt(crtnVO.getCrtnNum());
    	ossCrtnService.deleteCrtn(crtnVO);

    	resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}
}
