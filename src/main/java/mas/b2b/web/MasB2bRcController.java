package mas.b2b.web;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.b2b.service.MasB2bRcService;
import mas.b2b.vo.B2B_RC_DISPERGRPSVO;
import mas.b2b.vo.B2B_RC_DISPERGRPVO;
import mas.b2b.vo.B2B_RC_DISPERVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.RC_DFTINFVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.user.vo.USERVO;

import common.Constant;
import common.EgovUserDetailsHelper;

import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class MasB2bRcController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "masB2bRcService")
	private MasB2bRcService masB2bRcService;
	
	@Resource(name = "masRcPrdtService")
	private MasRcPrdtService masRcPrdtService;
	
	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;
	
	@Resource(name = "ossCorpService")
	private OssCorpService ossCorpService;
	
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    /**
     * 렌터카 그룹 관리
     * 파일명 : corpGrpList
     * 작성일 : 2016. 9. 28. 오후 3:52:30
     * 작성자 : 최영철
     * @param disPerGrpSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/rc/corpGrpList.do")
    public String corpGrpList(@ModelAttribute("searchVO") B2B_RC_DISPERGRPSVO disPerGrpSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	disPerGrpSVO.setsCorpId(corpInfo.getCorpId());
    	List<B2B_RC_DISPERGRPVO> disPerGrpList = masB2bRcService.selectDisPerGrpList(disPerGrpSVO);
    	
    	disPerGrpSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	disPerGrpSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(disPerGrpSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(disPerGrpSVO.getPageUnit());
		paginationInfo.setPageSize(disPerGrpSVO.getPageSize());

		disPerGrpSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		disPerGrpSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		disPerGrpSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = masB2bRcService.selectB2bCorpGrpList(disPerGrpSVO);
		
		@SuppressWarnings("unchecked")
		List<B2B_RC_DISPERGRPVO> resultList = (List<B2B_RC_DISPERGRPVO>) resultMap.get("resultList");
    	
    	model.addAttribute("disPerGrpList", disPerGrpList);
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
    	return "mas/b2b/rc/b2bCorpGrp";
    }
    
    /**
     * 그룹 등록
     * 파일명 : insertDisPerGrp
     * 작성일 : 2016. 9. 28. 오후 4:23:19
     * 작성자 : 최영철
     * @param disPerGrpVO
     * @return
     */
    @RequestMapping("/mas/b2b/rc/insertDisPerGrp.ajax")
    public ModelAndView insertDisPerGrp(@ModelAttribute("B2B_RC_DISPERGRPVO") B2B_RC_DISPERGRPVO disPerGrpVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	disPerGrpVO.setCorpId(corpInfo.getCorpId());
    	disPerGrpVO.setRegId(corpInfo.getUserId());
    	
    	masB2bRcService.insertDisPerGrp(disPerGrpVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 그룹 수정
     * 파일명 : updateDisPerGrp
     * 작성일 : 2016. 9. 27. 오후 4:49:22
     * 작성자 : 최영철
     * @param disPerGrpVO
     * @return
     */
    @RequestMapping("/mas/b2b/rc/updateDisPerGrp.ajax")
    public ModelAndView updateDisPerGrp(@ModelAttribute("B2B_RC_DISPERGRPVO") B2B_RC_DISPERGRPVO disPerGrpVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	disPerGrpVO.setCorpId(corpInfo.getCorpId());
    	disPerGrpVO.setModId(corpInfo.getUserId());
    	
    	masB2bRcService.updateDisPerGrp(disPerGrpVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 업체 그룹 등록
     * 파일명 : updateCorpGrp
     * 작성일 : 2016. 9. 28. 오전 11:20:50
     * 작성자 : 최영철
     * @param disPerGrpVO
     * @return
     */
    @RequestMapping("/mas/b2b/rc/updateCorpGrp.ajax")
    public ModelAndView updateCorpGrp(@ModelAttribute("B2B_RC_DISPERGRPVO") B2B_RC_DISPERGRPVO disPerGrpVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	disPerGrpVO.setCorpId(corpInfo.getCorpId());
    	disPerGrpVO.setRegId(corpInfo.getUserId());
    	
    	if(EgovStringUtil.isEmpty(disPerGrpVO.getDisPerGrpNum())){
    		masB2bRcService.deleteCorpGrp(disPerGrpVO);
    	}else{
    		masB2bRcService.mergeCorpGrp(disPerGrpVO);
    	}
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 해당 요금 그룹 삭제
     * 파일명 : deleteChkDisPerGrp
     * 작성일 : 2016. 9. 28. 오후 1:56:29
     * 작성자 : 최영철
     * @param disPerGrpVO
     * @return
     */
    @RequestMapping("/mas/b2b/rc/deleteDisPerGrp.ajax")
    public ModelAndView deleteChkDisPerGrp(@ModelAttribute("B2B_RC_DISPERGRPVO") B2B_RC_DISPERGRPVO disPerGrpVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	disPerGrpVO.setCorpId(corpInfo.getCorpId());
    	disPerGrpVO.setRegId(corpInfo.getUserId());
    	
    	List<B2B_RC_DISPERGRPVO> resultList = masB2bRcService.selectCorpDisPerList(disPerGrpVO);
    	
    	if(resultList.size() > 0){
    		resultMap.put("success", Constant.FLAG_N);
    		resultMap.put("rtnMsg", "해당 할인율 그룹은 사용중입니다.");
    	}else{
    		masB2bRcService.deleteDisPerGrp(disPerGrpVO);
    		resultMap.put("success", Constant.FLAG_Y);
    	}
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    @RequestMapping("/mas/b2b/rc/corpGrpDisPerList.do")
    public String corpGrpDisPerList(@ModelAttribute("gisPerGrpSVO") B2B_RC_DISPERGRPSVO disPerGrpSVO,
    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	disPerGrpSVO.setsCorpId(corpInfo.getCorpId());
    	List<B2B_RC_DISPERGRPVO> disPerGrpList = masB2bRcService.selectDisPerGrpList(disPerGrpSVO);
    	
    	model.addAttribute("disPerGrpList", disPerGrpList);
    	
    	RC_DFTINFVO rc_DFTINFVO = new RC_DFTINFVO();
    	rc_DFTINFVO.setCorpId(corpInfo.getCorpId());
    	prdtInfSVO.setsCorpId(corpInfo.getCorpId());
    	
    	RC_DFTINFVO rentCarInfo = masRcPrdtService.selectByRcDftInfo(rc_DFTINFVO);
    	if(rentCarInfo == null){
//    		model.addAttribute("rentCarInfo", rc_DFTINFVO);
//    		model.addAttribute("message", egovMessageSource.getMessage("common.upperNotExist",new Object[]{new String("기본정보")}, Locale.KOREA));
    		return "redirect:/mas/rc/rentCarInfo.do";
    	}
    	
    	prdtInfSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	prdtInfSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prdtInfSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prdtInfSVO.getPageUnit());
		paginationInfo.setPageSize(prdtInfSVO.getPageSize());

		prdtInfSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prdtInfSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prdtInfSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = masRcPrdtService.selectRcPrdtList(prdtInfSVO);
		
		@SuppressWarnings("unchecked")
		List<CORPVO> resultList = (List<CORPVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		
		// 차량연료코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
    	model.addAttribute("fuelCd", cdList);
    	// 차량구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);
    	// 변속기구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_TRANS_DIV);
    	model.addAttribute("transDivCd", cdList);
    	// 제조사구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
    	model.addAttribute("makerDivCd", cdList);
    	
    	
    	// 거래상태코드
    	cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCd", cdList);
    	
    	return "mas/b2b/rc/b2bCorpGrpDisPerList";
    }
    
    @RequestMapping("/mas/b2b/rc/corpGrpDisPer.do")
    public String corpGrpDisPer(@ModelAttribute("disPerGrpVO") B2B_RC_DISPERGRPVO disPerGrpVO,
    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		@ModelAttribute("B2B_RC_DISPERVO") B2B_RC_DISPERVO disPerInfVO,
    		ModelMap model){
    
    	// 그룹 기본 정보
    	disPerGrpVO = masB2bRcService.selectByDisPerGrp(disPerGrpVO);
    	model.addAttribute("disPerGrpVO", disPerGrpVO);
    	
    	RC_PRDTINFVO prdtInfVO = new RC_PRDTINFVO();
    	prdtInfVO.setPrdtNum(disPerInfVO.getPrdtNum());
    	prdtInfVO = masRcPrdtService.selectByPrdt(prdtInfVO);
    	model.addAttribute("prdtInf", prdtInfVO);
    	
    	model.addAttribute("disPerInfVO", disPerInfVO);
    	
    	Map<String, Object> resultMap = masB2bRcService.selectDisPerList(disPerInfVO);
    	model.addAttribute("defDisPerVO", resultMap.get("defDisPerVO"));
    	model.addAttribute("disPerInfList", resultMap.get("disPerInfList"));
    	
    	return "mas/b2b/rc/rcDisPerList";
    }
    
    /**
     * 기본 할인율 등록
     * 파일명 : insertDefDisPer
     * 작성일 : 2016. 9. 30. 오후 2:43:42
     * 작성자 : 최영철
     * @param disPerGrpVO
     * @param prdtInfSVO
     * @param disPerInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/rc/insertDefDisPer.do")
    public String insertDefDisPer(@ModelAttribute("disPerGrpVO") B2B_RC_DISPERGRPVO disPerGrpVO,
    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		@ModelAttribute("B2B_RC_DISPERVO") B2B_RC_DISPERVO disPerInfVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	disPerInfVO.setCorpId(corpInfo.getCorpId());
    	disPerInfVO.setFrstRegId(corpInfo.getUserId());
    	masB2bRcService.insertDefDisPer(disPerInfVO);
    	return "redirect:/mas/b2b/rc/corpGrpDisPer.do?prdtNum=" + disPerInfVO.getPrdtNum()
    												+ "&disPerGrpNum=" + disPerInfVO.getDisPerGrpNum();
    }
    
    /**
     * 기본 할인율 수정
     * 파일명 : updateDefDisPer
     * 작성일 : 2016. 10. 4. 오전 9:41:06
     * 작성자 : 최영철
     * @param disPerGrpVO
     * @param prdtInfSVO
     * @param disPerInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/rc/updateDefDisPer.do")
    public String updateDefDisPer(	@ModelAttribute("disPerGrpVO") B2B_RC_DISPERGRPVO disPerGrpVO,
						    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
						    		@ModelAttribute("B2B_RC_DISPERVO") B2B_RC_DISPERVO disPerInfVO,
						    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	disPerInfVO.setLastModId(corpInfo.getUserId());
    	masB2bRcService.updateDefDisPer(disPerInfVO);
    	return "redirect:/mas/b2b/rc/corpGrpDisPer.do?prdtNum=" + disPerInfVO.getPrdtNum()
    			+ "&disPerGrpNum=" + disPerInfVO.getDisPerGrpNum();
    }
    
    /**
     * 기간 할인율 등록
     * 파일명 : insertRangeDisPer
     * 작성일 : 2016. 10. 4. 오전 10:03:50
     * 작성자 : 최영철
     * @param disPerGrpVO
     * @param prdtInfSVO
     * @param disPerInfVO
     * @return
     */
    @RequestMapping("/mas/b2b/rc/insertRangeDisPer.ajax")
    public ModelAndView insertRangeDisPer(@ModelAttribute("disPerGrpVO") B2B_RC_DISPERGRPVO disPerGrpVO,
						    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
						    		@ModelAttribute("B2B_RC_DISPERVO") B2B_RC_DISPERVO disPerInfVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	disPerInfVO.setCorpId(corpInfo.getCorpId());
    	
    	Integer chkInt = masB2bRcService.checkRangeAplDt(disPerInfVO);
    	
    	if(chkInt > 0){
    		resultMap.put("success", "N");
    		resultMap.put("rtnMsg", "중복되는 기간이 존재합니다.");
    	}else{
    		disPerInfVO.setFrstRegId(corpInfo.getUserId());
    		masB2bRcService.insertRangeDisPer(disPerInfVO);
    		
    		resultMap.put("success", "Y");
    	}
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 기간 할인율 수정
     * 파일명 : updateRangeDisPer
     * 작성일 : 2016. 10. 4. 오전 10:16:32
     * 작성자 : 최영철
     * @param disPerGrpVO
     * @param prdtInfSVO
     * @param disPerInfVO
     * @return
     */
    @RequestMapping("/mas/b2b/rc/updateRangeDisPer.ajax")
    public ModelAndView updateRangeDisPer(@ModelAttribute("disPerGrpVO") B2B_RC_DISPERGRPVO disPerGrpVO,
    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		@ModelAttribute("B2B_RC_DISPERVO") B2B_RC_DISPERVO disPerInfVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	disPerInfVO.setCorpId(corpInfo.getCorpId());
    	
    	Integer chkInt = masB2bRcService.checkRangeAplDt(disPerInfVO);
    	
    	if(chkInt > 0){
    		resultMap.put("success", "N");
    		resultMap.put("rtnMsg", "중복되는 기간이 존재합니다.");
    	}else{
    		disPerInfVO.setLastModId(corpInfo.getUserId());
    		masB2bRcService.updateRangeDisPer(disPerInfVO);
    		
    		resultMap.put("success", "Y");
    	}
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 기간 할인율 삭제
     * 파일명 : deleteRangeDisPer
     * 작성일 : 2016. 10. 4. 오전 10:20:31
     * 작성자 : 최영철
     * @param disPerGrpVO
     * @param prdtInfSVO
     * @param disPerInfVO
     * @return
     */
    @RequestMapping("/mas/b2b/rc/deleteRangeDisPer.do")
    public String deleteRangeDisPer(	@ModelAttribute("disPerGrpVO") B2B_RC_DISPERGRPVO disPerGrpVO,
    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		@ModelAttribute("B2B_RC_DISPERVO") B2B_RC_DISPERVO disPerInfVO){
    	masB2bRcService.deleteRangeDisPer(disPerInfVO);
    	return "redirect:/mas/b2b/rc/corpGrpDisPer.do?prdtNum=" + disPerInfVO.getPrdtNum() + "&disPerGrpNum=" + disPerGrpVO.getDisPerGrpNum();
    }
    
    @RequestMapping("/mas/b2b/rc/selectByDisPerInf.ajax")
    public ModelAndView selectByDisPerInf(@ModelAttribute("B2B_RC_DISPERVO") B2B_RC_DISPERVO disPerInfVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	disPerInfVO = masB2bRcService.selectByDisPerInf(disPerInfVO);
    	resultMap.put("disPerInfVO", disPerInfVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
}
