package mas.useepil.web;


import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mas.rc.service.MasRcPrdtService;
import mas.sp.service.MasSpService;
import net.sf.json.JSONObject;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.USEEPILCMTVO;
import oss.useepil.vo.USEEPILSVO;
import oss.useepil.vo.USEEPILVO;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.EgovWebUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class MasUseepilController {
	
	@Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;  

	@Resource(name="ossUesepliService")
	private OssUesepliService ossUesepliService;

	@Resource(name="masRcPrdtService")
    private MasRcPrdtService masRcPrdtService;
	
	@Resource(name="masSpService")
    private MasSpService masSpService;
	
	@Resource(name="ossUserService")
	private OssUserService ossUserService;
    
    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    
    @RequestMapping("/mas/useepil/useepilList.do")
    public String useepilList(@ModelAttribute("USEEPILVO") USEEPILVO useepilVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    							ModelMap model){
    	//log.info("/mas/useepil/useepilList.do 호출");
    	    	
    	//USEEPILVO useepilVO = new USEEPILVO();
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	useepilVO.setCorpId(corpInfo.getCorpId());
    	useepilSVO.setsCorpId(corpInfo.getCorpId());
    	useepilSVO.setCorpCd(corpInfo.getCorpCd() );    	
    	model.addAttribute("corpCdUp", corpInfo.getCorpCd() );
    	model.addAttribute("corpCd", corpInfo.getCorpCd().toLowerCase() );
    	
    	log.info("/mas/useepil/useepilList.do 호출>>"+ useepilVO.getCorpId() + ":" + useepilSVO.getCorpCd());
    	
    	
    	
    	useepilSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	useepilSVO.setPageSize(propertiesService.getInt("pageSize"));
		

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(useepilSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(useepilSVO.getPageUnit());
		paginationInfo.setPageSize(useepilSVO.getPageSize());

		useepilSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		useepilSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		useepilSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		//상품평 조회
		Map<String, Object> resultMap = ossUesepliService.selectUseepilList(useepilSVO);	
		@SuppressWarnings("unchecked")
		List<USEEPILVO> resultList = (List<USEEPILVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);


    	return "/mas/useepil/useepilList";
    }
 

    @RequestMapping("/mas/useepil/detailUseepil.do")
    public String detailUseepil(@ModelAttribute("USEEPILVO") USEEPILVO useepilVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    							ModelMap model){
    	log.info("/mas/useepil/detailUseepil.do 호출");
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	useepilVO.setCorpId(corpInfo.getCorpId());
    	useepilSVO.setsCorpId(corpInfo.getCorpId());
    	useepilSVO.setCorpCd(corpInfo.getCorpCd() );
    	model.addAttribute("userId", corpInfo.getUserId() );
    	model.addAttribute("corpCdUp", corpInfo.getCorpCd() );
    	model.addAttribute("corpCd", corpInfo.getCorpCd().toLowerCase() );
    	
    	//상품평 정보 읽기
    	USEEPILVO useepilVORes = ossUesepliService.selectByUseepil(useepilVO);
    	model.addAttribute("data", useepilVORes);
    	
    	USERVO userSVO = new USERVO();
		userSVO.setUserId( useepilVORes.getUserId() );
		USERVO userVO = ossUserService.selectByUser(userSVO);
		model.addAttribute("userVO", userVO);
    	
    	useepilVORes.setContents(EgovWebUtil.clearXSSMinimum(useepilVORes.getContents()) );
    	useepilVORes.setContents( useepilVORes.getContents().replaceAll("\n", "<br/>\n") );
    	
    	//상품평 답글 읽기
    	USEEPILCMTVO uecVO = new USEEPILCMTVO();
    	uecVO.setUseEpilNum( useepilVO.getUseEpilNum() );
    	List<USEEPILCMTVO> cmtlist = ossUesepliService.selectUseepCmtilListOne(uecVO);
    	for(USEEPILCMTVO cmt: cmtlist){
    		cmt.setContents(EgovWebUtil.clearXSSMinimum(cmt.getContents()) );
    		cmt.setContents( cmt.getContents().replaceAll("\n", "<br/>\n") );    		
    	}
    	model.addAttribute("cmtlist", cmtlist);

    	
    	
    	return "/mas/useepil/detailUseepil";
    }
    
    /**
     * 상품평의 댓글 추가
     * Function : useepilCmtInsert
     * 작성일 : 2016. 7. 29. 오후 3:47:48
     * 작성자 : 정동수
     * @param useepilCmtVO
     * @param request
     * @param response
     * @param model
     * @throws Exception
     */
    @RequestMapping("/mas/useepil/useepilCmtInsert.ajax")
    public void useepilCmtInsert(@ModelAttribute("USEEPILCMTVO") USEEPILCMTVO useepilCmtVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	log.info("/mas/useepil/useepilCmtInsert.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
		useepilCmtVO.setUserId(corpInfo.getUserId());
		useepilCmtVO.setEmail(corpInfo.getEmail());
		useepilCmtVO.setFrstRegIp(corpInfo.getLastLoginIp());
    	
    	ossUesepliService.insertUseepilCmt(useepilCmtVO);
    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    	    	
    }
    
    @RequestMapping("/mas/useepil/useepilCmtUpdate.ajax")
    public void useepilCmtUpdate(@ModelAttribute("USEEPILCMTVO") USEEPILCMTVO useepilCmtVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	log.info("/mas/useepil/useepilCmtUpdate.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
		useepilCmtVO.setUserId(corpInfo.getUserId());
		useepilCmtVO.setEmail(corpInfo.getEmail());		
		useepilCmtVO.setLastModId(corpInfo.getUserId());		
		useepilCmtVO.setLastModIp(corpInfo.getLastLoginIp());
    	
    	ossUesepliService.updateUsespilCmt(useepilCmtVO);
    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    	    	
    }
    
    /**
     * 상품평의 댓글 삭제
     * Function : useepilCmtDelete
     * 작성일 : 2016. 8. 1. 오전 9:14:55
     * 작성자 : 정동수
     * @param useepilCmtVO
     * @param request
     * @param response
     * @param model
     * @throws Exception
     */
    @RequestMapping("/mas/useepil/useepilCmtDelete.ajax")
    public void useepilCmtDelete(	@ModelAttribute("USEEPILCMTVO") USEEPILCMTVO useepilCmtVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	log.info("/mas/useepil/useepilCmtDelete.do 호출");
    
    	ossUesepliService.deleteUsespilCmtByCmtSn(useepilCmtVO);
    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    	    	
    }

}
