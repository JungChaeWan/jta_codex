package oss.marketing.web;

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

import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.marketing.serive.OssAdmRcmdService;
import oss.marketing.vo.ADMRCMDVO;
import oss.user.vo.USERVO;

import common.Constant;
import common.EgovUserDetailsHelper;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * MD's Pick (관리자 추천) 관리
 * 파일명 : OssMdsPickController.java
 * 작성일 : 2016. 10. 21. 오후 2:05:06
 * 작성자 : 정동수
 */
@Controller
public class OssMdsPickController {
	@Autowired
    private DefaultBeanValidator beanValidator;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name="ossCmmService")
    private OssCmmService ossCmmService;
	
	@Resource(name = "OssAdmRcmdService")
	protected OssAdmRcmdService ossAdmRcmdService;
	
	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@RequestMapping("/oss/mdsPickList.do")
	public String mdsPickList(@ModelAttribute("searchVO") ADMRCMDVO admRcmdVO,
						ModelMap model) {
		log.info("/oss/mdsPickList.do call");

		admRcmdVO.setPageUnit(propertiesService.getInt("pageUnit"));
		admRcmdVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(admRcmdVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(admRcmdVO.getPageUnit());
		paginationInfo.setPageSize(admRcmdVO.getPageSize());

		admRcmdVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		admRcmdVO.setLastIndex(paginationInfo.getLastRecordIndex());
		admRcmdVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossAdmRcmdService.selectMdsPickList(admRcmdVO);		

		@SuppressWarnings("unchecked")
		List<SP_PRDTINFVO> resultList = (List<SP_PRDTINFVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
				
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "oss/maketing/mdsPickList";
	}
	
	@RequestMapping("/oss/mdsPickListFind.do")
	public String mdsPickListFind(@ModelAttribute("searchVO") ADMRCMDVO admRcmdVO,
						ModelMap model) {
		log.info("/oss/mdsPickListFind.do call");

		admRcmdVO.setPageUnit(propertiesService.getInt("pageUnit"));
		admRcmdVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(admRcmdVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(admRcmdVO.getPageUnit());
		paginationInfo.setPageSize(admRcmdVO.getPageSize());

		admRcmdVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		admRcmdVO.setLastIndex(paginationInfo.getLastRecordIndex());
		admRcmdVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossAdmRcmdService.selectMdsPickListFind(admRcmdVO);		

		@SuppressWarnings("unchecked")
		List<SP_PRDTINFVO> resultList = (List<SP_PRDTINFVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
				
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "oss/maketing/findMdsPickPop";
	}
	
	@RequestMapping("/oss/mdsPickRegView.do")
	public String mdsPickRegView(@ModelAttribute("ADMRCMDVO") ADMRCMDVO admRcmdVO,
								ModelMap model) {
		log.info("/oss/mdsPickRegView.do call");

		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
		
		model.addAttribute("corpCdList", corpCdList);
		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		
		return "oss/maketing/mdsPickReg";
	}
	
	@RequestMapping("/oss/mdsPickReg.do")
	public String mdsPickReg(@ModelAttribute("admRcmdVO") ADMRCMDVO admRcmdVO,
							 final MultipartHttpServletRequest multiRequest) throws Exception {
		log.info("/oss/mdsPickReg.do call");

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		admRcmdVO.setRegId(corpInfo.getUserId());

		ossAdmRcmdService.insertMdsPick(admRcmdVO, multiRequest);
		
		return "redirect:/oss/mdsPickList.do";
	}
	
	@RequestMapping("/oss/mdsPickDtl.do")
	public String mdsPickDtl(@ModelAttribute("admRcmdVO") ADMRCMDVO admRcmdVO,
							 ModelMap model) {
		log.info("/oss/mdsPickDtl.do call");
		
		admRcmdVO = ossAdmRcmdService.selectMdsPickInfo(admRcmdVO);
		
		model.addAttribute("admRcmdVO", admRcmdVO);
		
		return "/oss/maketing/mdsPickDtl";
	}	
	
	@RequestMapping("/oss/mdsPickModView.do")
	public String mdsPickModView(@ModelAttribute("ADMRCMDVO") ADMRCMDVO admRcmdVO,
								 ModelMap model) {
		log.info("/oss/mdsPickModView.do call");
		
		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);

		admRcmdVO = ossAdmRcmdService.selectMdsPickInfo(admRcmdVO);
		
		model.addAttribute("corpCdList", corpCdList);
		model.addAttribute("admRcmdVO", admRcmdVO);
		
		return "/oss/maketing/mdsPickMod";
	}
	
	@RequestMapping("/oss/mdsPickMod.do")
	public String mdsPickMod(@ModelAttribute("admRcmdVO") ADMRCMDVO admRcmdVO,
							 final MultipartHttpServletRequest multiRequest) throws Exception {
		log.info("/oss/mdsPickMod.do call");
		
		ossAdmRcmdService.updateMdsPick(admRcmdVO, multiRequest);
		
		return "redirect:/oss/mdsPickList.do";
	}
	
	
	@RequestMapping("/oss/mdsPickDel.ajax")
	public ModelAndView mdsPickDel(@ModelAttribute("admRcmdVO") ADMRCMDVO admRcmdVO) {
		log.info("/mas/mdsPickDel.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();
		    	
		ossAdmRcmdService.deleteMdsPick(admRcmdVO);
    	
    	resultMap.put("resultCode", Constant.JSON_SUCCESS);
    	
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		
		return modelAndView;
	}
}
