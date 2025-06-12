package apiCn.web;


import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPSVO;
import oss.corp.vo.CORPVO;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;
import apiCn.service.ApiCnService;
import apiCn.vo.APICNSVO;
import apiCn.vo.APICNVO;
import apiCn.vo.APIDTLVO;
import apiCn.vo.ILSDTLVO;
import apiCn.vo.ILSVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class ApiCnController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    @Resource(name = "ossUserService")
    private OssUserService ossUserService;
    
    @Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
    
    @Resource(name = "apiCnService")
    private ApiCnService apiCnService;
    
    @Resource(name = "ossCorpService")
    private OssCorpService ossCorpService;
    
    @Resource(name = "masRcPrdtService")
    private MasRcPrdtService masRcPrdtService;
    
    @Resource(name = "ossCmmService")
    private OssCmmService ossCmmService;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    /**
     * API Center 로그인 View
     * 파일명 : intro
     * 작성일 : 2016. 7. 5. 오전 10:11:21
     * 작성자 : 최영철
     * @return
     */
    @RequestMapping("/apiCn/intro.do")
    public String intro(){
    	return "/apiCn/intro";
    }
    
    /**
     * API Center 로그인
     * 파일명 : actionApiCnLogin
     * 작성일 : 2016. 7. 5. 오전 10:11:05
     * 작성자 : 최영철
     * @param loginVO
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/apiCn/actionApiCnLogin.do")
    public String actionApiCnLogin(	@ModelAttribute("loginVO") USERVO loginVO, 
						            HttpServletRequest request,
						            ModelMap model) throws Exception{
    	if(EgovStringUtil.isEmpty(loginVO.getEmail())){
    		model.addAttribute("failLogin","1");
    		return "/apiCn/intro";
    	}
    	if(EgovStringUtil.isEmpty(loginVO.getPwd())){
    		model.addAttribute("failLogin","2");
    		return "/apiCn/intro";
    	}
    	// 접속 IP
    	String userIp = EgovClntInfo.getClntIP(request);
    	loginVO.setLastLoginIp(userIp);
    	// 1. 관리자 로그인 처리
    	USERVO resultVO = ossUserService.actionOssLogin(loginVO);
    	
    	log.info(resultVO.getUserId());
    	if (resultVO != null && resultVO.getUserId() != null && !resultVO.getUserId().equals("")) {
        	resultVO.setLastLoginIp(userIp);
        	request.getSession().setAttribute("apiCnLoginVO", resultVO);
        	
        	return "redirect:/apiCn/apiCnCorpList.do";
    	}else{
    		model.addAttribute("failLogin","Y");
    		model.addAttribute("email",loginVO.getEmail());
    		return "/apiCn/intro";
    	}
    }
    
    /**
     * API Center 로그아웃
     * 파일명 : apiCnLogout
     * 작성일 : 2016. 7. 5. 오전 10:11:38
     * 작성자 : 최영철
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/apiCn/apiCnLogout.do")
	public String apiCnLogout(HttpServletRequest request, ModelMap model){
		
		request.getSession().setAttribute("apiCnLoginVO", null);
		
		return "apiCn/intro";
	}
    
    @RequestMapping("/apiCn/head.do")
    public String apiCnHead(	@RequestParam Map<String, String> params,
    						ModelMap model){
    	model.addAttribute("menuNm", params.get("menu"));
    	return "/apiCn/head";
    }
    
    @RequestMapping("/apiCn/home.do")
    public String apiCnHome(	@RequestParam Map<String, String> params,
    		ModelMap model){
    	return "/apiCn/home";
    }
    
    /**
     * 업체 연계 리스트 조회
     * 파일명 : apiCnCorpList
     * 작성일 : 2016. 7. 6. 오후 5:25:27
     * 작성자 : 최영철
     * @param apicnSVO
     * @param model
     * @return
     */
    @RequestMapping("/apiCn/apiCnCorpList.do")
    public String apiCnCorpList(@ModelAttribute("searchVO") APICNSVO apicnSVO,
    		ModelMap model){
    	
    	apicnSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	apicnSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(apicnSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(apicnSVO.getPageUnit());
		paginationInfo.setPageSize(apicnSVO.getPageSize());

		apicnSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		apicnSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		apicnSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = apiCnService.selectApiCnCorpList(apicnSVO);
		
		@SuppressWarnings("unchecked")
		List<APICNVO> resultList = (List<APICNVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
    	return "/apiCn/corp/apiCorpList";
    	
    }
    
    /**
     * 업체 검색
     * 파일명 : findCorp
     * 작성일 : 2016. 7. 12. 오전 10:26:53
     * 작성자 : 최영철
     * @param corpSVO
     * @param model
     * @return
     */
    @RequestMapping("/apiCn/findCorp.do")
    public String findCorp(@ModelAttribute("searchVO") CORPSVO corpSVO,
			ModelMap model){
    	corpSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		corpSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(corpSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(corpSVO.getPageUnit());
		paginationInfo.setPageSize(corpSVO.getPageSize());

		corpSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		corpSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		corpSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossCorpService.selectCorpList(corpSVO);
		
		@SuppressWarnings("unchecked")
		List<CORPVO> resultList = (List<CORPVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
    	List<CDVO> tsCdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	
    	model.addAttribute("corpCdList", corpCdList);
    	model.addAttribute("tsCdList", tsCdList);
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "apiCn/corp/findCorpPop";
    }
    
    /**
     * 인증키 리턴
     * 파일명 : authKey
     * 작성일 : 2016. 7. 11. 오후 4:49:45
     * 작성자 : 최영철
     * @return
     */
    @RequestMapping("/apiCn/authKey.ajax")
    public ModelAndView authKey(){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	Random rnd = new Random();
    	StringBuffer buf = new StringBuffer();
    	 
    	for(int i=0;i<10;i++){
    	    if(rnd.nextBoolean()){
    	        buf.append((char)((int)(rnd.nextInt(26))+97));
    	    }else{
    	        buf.append((rnd.nextInt(10))); 
    	    }
    	}
    	resultMap.put("authKey", buf.toString());
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
		return mav;
    }
    
    /**
     * 연계 업체 등록
     * 파일명 : InsertApiCorp
     * 작성일 : 2016. 7. 12. 오전 10:26:38
     * 작성자 : 최영철
     * @param apicnVO
     * @return
     */
    @RequestMapping("/apiCn/insertApiCorp.ajax")
    public ModelAndView insertApiCorp(@ModelAttribute("APICNVO") APICNVO apicnVO){
    	log.info("/apiCn/InsertApiCorp.ajax 호출");
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	APICNSVO searchVO = new APICNSVO();
    	searchVO.setsCorpId(apicnVO.getCorpId());
    	Integer cnt = apiCnService.getCntCorpList(searchVO);
    	
    	if(cnt > 0){
    		resultMap.put("success", "N");
    		resultMap.put("rtnMsg", "이미 등록된 업체입니다.");
    	}else{
	    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedApiCn();
	    	apicnVO.setFrstRegId(corpInfo.getUserId());
	    	apiCnService.insertApiCorp(apicnVO);
	    	
	    	resultMap.put("success", "Y");
    	}
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
		return mav;
    }
    
    /**
     * 연계 업체 단건 조회
     * 파일명 : selectApiCorp
     * 작성일 : 2016. 7. 12. 오후 1:42:35
     * 작성자 : 최영철
     * @param apicnVO
     * @return
     */
    @RequestMapping("/apiCn/selectApiCorp.ajax")
    public ModelAndView selectApiCorp(@ModelAttribute("APICNVO") APICNVO apicnVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	apicnVO = apiCnService.selectByApiCorp(apicnVO);
    	resultMap.put("apicnVO", apicnVO);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 연계 업체 수정
     * 파일명 : updateApiCorp
     * 작성일 : 2016. 7. 12. 오후 3:50:53
     * 작성자 : 최영철
     * @param apicnVO
     * @return
     */
    @RequestMapping("/apiCn/updateApiCorp.ajax")
    public ModelAndView updateApiCorp(@ModelAttribute("APICNVO") APICNVO apicnVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedApiCn();
    	apicnVO.setLastModId(corpInfo.getUserId());
    	apiCnService.updateApiCorp(apicnVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
		return mav;
    }
    
    @RequestMapping("/apiCn/apiContents.do")
    public String apiContents(@ModelAttribute("APICNVO") APICNVO apicnVO,
    		ModelMap model){
    	apicnVO = apiCnService.selectByApiCorp(apicnVO);
    	model.addAttribute("apicnVO", apicnVO);
    	
    	List<APIDTLVO> apiList = apiCnService.selectApiDtlList(apicnVO);
    	model.addAttribute("apiList", apiList);
    	return "/apiCn/api/apiContents";
    }
    
    /**
     * API 상세 등록
     * 파일명 : insertApiDtl
     * 작성일 : 2016. 7. 19. 오전 9:16:24
     * 작성자 : 최영철
     * @param apiDtlVO
     * @return
     */
    @RequestMapping("/apiCn/insertApiDtl.ajax")
    public ModelAndView insertApiDtl(@ModelAttribute("APIDTLVO") APIDTLVO apiDtlVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedApiCn();
    	apiDtlVO.setFrstRegId(corpInfo.getUserId());
    	
    	apiCnService.insertApiDtl(apiDtlVO);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	
    	return mav;
    }
    
    /**
     * API 상세 단건 조회
     * 파일명 : selectByApiDtl
     * 작성일 : 2016. 7. 19. 오전 9:16:14
     * 작성자 : 최영철
     * @param apiDtlVO
     * @return
     */
    @RequestMapping("/apiCn/selectByApiDtl.ajax")
    public ModelAndView selectByApiDtl(@ModelAttribute("APIDTLVO") APIDTLVO apiDtlVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	apiDtlVO = apiCnService.selectByApiDtl(apiDtlVO);
    	resultMap.put("apiDtlVO", apiDtlVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * API 상세 수정
     * 파일명 : updateApiDtl
     * 작성일 : 2016. 7. 19. 오전 9:16:35
     * 작성자 : 최영철
     * @param apiDtlVO
     * @return
     */
    @RequestMapping("/apiCn/updateApiDtl.ajax")
    public ModelAndView updateApiDtl(@ModelAttribute("APIDTLVO") APIDTLVO apiDtlVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedApiCn();
    	apiDtlVO.setLastModId(corpInfo.getUserId());
    	
    	apiCnService.updateApiDtl(apiDtlVO);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	
    	return mav;
    }
    
    /**
     * 렌터카 상품 리스트 xml 리턴
     * 파일명 : prdtList
     * 작성일 : 2016. 12. 1. 오후 4:17:04
     * 작성자 : 최영철
     * @param apiVO
     * @return
     * @throws IOException
     */
    @RequestMapping("/rc/api/prdtList.xm")
    public ModelAndView prdtList(@ModelAttribute("APICNVO") APICNVO apiVO) throws IOException{
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	ILSVO ilsVO = new ILSVO();
    	
    	List<ILSDTLVO> ilsList = apiCnService.selectIlsList(apiVO);
    	ilsVO.setIlsDtlVOList(ilsList);
    	
    	resultMap.put("ilsVO", ilsVO);
    	
    	ModelAndView mav = new ModelAndView("xmlView", resultMap);
    	return mav;
    }
    
    
    public static String convert(String str, String encoding) throws IOException {
		ByteArrayOutputStream requestOutputStream = new ByteArrayOutputStream();
		requestOutputStream.write(str.getBytes(encoding));
		return requestOutputStream.toString(encoding);
	}
}
