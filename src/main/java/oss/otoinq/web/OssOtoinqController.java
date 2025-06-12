package oss.otoinq.web;


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

import oss.otoinq.service.OssOtoinqService;
import oss.otoinq.vo.OTOINQ5VO;
import oss.otoinq.vo.OTOINQSVO;
import oss.otoinq.vo.OTOINQVO;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;
import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.EgovWebUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class OssOtoinqController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;  

	@Resource(name="ossOtoinqService")
	private OssOtoinqService ossOtoinqService;
	
	@Resource(name="ossUserService")
	private OssUserService ossUserService;
    
    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    
    @RequestMapping("/oss/otoinqList.do")
    public String otoinqList(@ModelAttribute("searchVO")OTOINQSVO otoinqSVO,
    						ModelMap model){
    	//log.info("/oss/otoinqList.do 호출");
    	

    	//USEEPILVO useepilVO = new USEEPILVO();
    	//USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	//useepilVO.setCorpId(corpInfo.getCorpId());
    	//useepilSVO.setsCorpId(corpInfo.getCorpId());

    	otoinqSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	otoinqSVO.setPageSize(propertiesService.getInt("pageSize"));
		

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(otoinqSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(otoinqSVO.getPageUnit());
		paginationInfo.setPageSize(otoinqSVO.getPageSize());

		otoinqSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		otoinqSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		otoinqSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		//상품평 조회
		Map<String, Object> resultMap = ossOtoinqService.selectOtoinqListMas(otoinqSVO);	
		@SuppressWarnings("unchecked")
		List<OTOINQVO> resultList = (List<OTOINQVO>) resultMap.get("resultList");
	
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);


    	return "/oss/otoinq/otoinqList";
    }
 

    @RequestMapping("/oss/detailOtoinq.do")
    public String detailUseepil(@ModelAttribute("OTOINQVO") OTOINQVO otoinqlVO,
    							@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							ModelMap model){
    	//log.info("/oss/detailUseepil.do 호출");
    	
    	//상품평 정보 읽기
    	OTOINQVO otoinqVORes = ossOtoinqService.selectByOtoinq(otoinqlVO);
    	
    	otoinqVORes.setContents(EgovWebUtil.clearXSSMinimum(otoinqVORes.getContents()) );
    	otoinqVORes.setContents( otoinqVORes.getContents().replaceAll("\n", "<br/>\n") );
    	
    	otoinqVORes.setAnsContents(EgovWebUtil.clearXSSMinimum(otoinqVORes.getAnsContents()) );
    	otoinqVORes.setAnsContents( otoinqVORes.getAnsContents().replaceAll("\n", "<br/>\n") );
    	
    	OTOINQ5VO oto5VO = new OTOINQ5VO();
		oto5VO.setsCorpId(otoinqVORes.getCorpId());
		oto5VO.setsPrdtNum(otoinqVORes.getPrdtNum());
		OTOINQ5VO oto5Res = ossOtoinqService.geteOtoinqByCPName(oto5VO);
		otoinqVORes.setCorpNm2( oto5Res.getCorpNm() );
		otoinqVORes.setPrdtNm( oto5Res.getPrdtNm() );
		
		model.addAttribute("data", otoinqVORes);
		
		
		USERVO userSVO = new USERVO();
		userSVO.setUserId( otoinqVORes.getWriter() );
		USERVO userVO = ossUserService.selectByUser(userSVO);
		model.addAttribute("userVO", userVO);
    	
    	
    	return "/oss/otoinq/detailOtoinq";
    }
    

    @RequestMapping("/oss/otoinqUpdatePrint.do")
    public String useepiUpdatePrint(@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
    							@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							ModelMap model){
    	//log.info("/oss/detailUseepil.do 호출");
    	//log.info("/oss/detailUseepil.do 호출:" + useepilVO.getUseEpilNum() + ":" + useepilVO.getPrintYn() );
    	
    	ossOtoinqService.updateOtoinqByPrint(otoinqVO);
    	
    	
    	return "redirect:/oss/detailOtoinq.do?otoinqNum=" + otoinqVO.getOtoinqNum() +"&pageIndex="+otoinqSVO.getPageIndex();
    }

}
