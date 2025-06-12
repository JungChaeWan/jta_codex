package mw.product.web;


import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.service.OssCmmService;
import oss.corp.service.OssCorpService;
import oss.otoinq.service.OssOtoinqService;
import oss.otoinq.vo.OTOINQSVO;
import oss.otoinq.vo.OTOINQVO;
import oss.user.vo.USERVO;

import common.Constant;
import common.EgovUserDetailsHelper;

import egovframework.cmmn.EgovWebUtil;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 사용자 이용후기 공용 컨트털
 * 파일명 : WebCmmUseepilController.java
 * 작성일 : 2015. 10. 26. 오전 9:27:33
 * 작성자 : 신우섭
 */
@Controller
public class MwCmmOtoinqController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;
	
	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;
	
	
	@Resource(name="ossOtoinqService")
	private OssOtoinqService ossOtoinqService;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    @RequestMapping("/mw/cmm/otpinqList.ajax")
    public String otpinqList(	@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
    							@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    		   					ModelMap model){
    	

    	//log.info("/web/cmm/otpinqList.ajax 호출");
    	
    	//로그인 정보 얻기
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		model.addAttribute("userInfo", userVO);
    	}else{
    		model.addAttribute("userInfo", null);
    	}

    	
    	//페이징 관련 설정
    	otoinqSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	otoinqSVO.setPageSize(propertiesService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(otoinqSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(otoinqSVO.getPageUnit());
		paginationInfo.setPageSize(otoinqSVO.getPageSize());

		otoinqSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		otoinqSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		otoinqSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		

		//검색조건 조합
		if(Constant.ACCOMMODATION.equals( otoinqVO.getCorpCd() )){
			//숙소인 경우 검색 조건 다르게...
			otoinqSVO.setsCorpId(otoinqVO.getCorpId());
		}else{
			otoinqSVO.setsPrdtNum(otoinqVO.getPrdtNum());
		}
		
		//log.info("/web/cmm/useepilList.do 호출:" + useepilSVO.getsCorpId() + ":" + useepilSVO.getsPrdtNum() + ":"+ useepilSVO.getCorpCd());
		
		//글얻기
		Map<String, Object> resultMap = ossOtoinqService.selectOtoinqListWeb(otoinqSVO);
		@SuppressWarnings("unchecked")
		List<OTOINQVO> resultList = (List<OTOINQVO>) resultMap.get("resultList");
			
		//데이터 가공
		for(OTOINQVO data: resultList){
			//log.info("/web/cmm/useepilList.do 호출:"+data.getSubject());
			
			//내용
			data.setContentsOrg(data.getContents());
			data.setContents(EgovWebUtil.clearXSSMinimum(data.getContents()) );
			data.setContents( data.getContents().replaceAll("\n", "<br/>\n") );
			
			//data.setAnsContentsOrg(data.getAnsContents());
			data.setAnsContents(EgovWebUtil.clearXSSMinimum(data.getAnsContents()) );
			data.setAnsContents( data.getAnsContents().replaceAll("\n", "<br/>\n") );
			
			//아이디
			String strEmail = data.getEmail();
			if(strEmail.length() < 3){
				strEmail = "***";
			}else{
				strEmail = strEmail.substring(0,3)+"*****";
			}
			data.setEmail(strEmail);
						
		}
	
		
		
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
		
		model.addAttribute("otoinqList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		//log.info("/web/cmm/otpinqList.ajax 호출>>>>>end:");
		
    	return "/mw/cmm/otoinqList";
    }
    
    
    @RequestMapping("/mw/cmm/otoinqInsert.ajax")
    public void useepilInsert(	@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	//log.info("/web/cmm/useepilInsert.do 호출");
    	
    	     	
    	//otoinqVO.setWriter("U000000004");
    	//otoinqVO.setEmail("arisa@naver.com");
    	//otoinqVO.setFrstRegIp("127.0.0.1");
    	
    	//로그인 정보 얻기
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		//model.addAttribute("userInfo", userVO);
    		otoinqVO.setWriter(userVO.getUserId());
    		otoinqVO.setEmail(userVO.getEmail());
    		
    		//userVO.getLastLoginIp() 이 없는 경우가 있음
    		if((userVO.getLastLoginIp() == null) || (userVO.getLastLoginIp() == "")) {
    			otoinqVO.setFrstRegIp(EgovClntInfo.getClntIP(request));
    		} else {
    			otoinqVO.setFrstRegIp(userVO.getLastLoginIp());
    		}
    	}else{
    		return;
    	}
    	
    	//추가
    	ossOtoinqService.insertOtoinq(otoinqVO);

		// 담당자에게 SMS & 메일 발송
		ossOtoinqService.otoinqSnedSMSAll(otoinqVO, request);

    	//검색조건 조합
		if(Constant.ACCOMMODATION.equals( otoinqVO.getCorpCd() )){
			//숙소인 경우 검색 조건 다르게...
			otoinqSVO.setsCorpId(otoinqVO.getCorpId());
		}else{
			otoinqSVO.setsPrdtNum(otoinqVO.getPrdtNum());
		}
    	int nCnt = ossOtoinqService.getCntOtoinqCnt(otoinqSVO);
    	//log.info(">>>>>>>>>>>>>>>"+nCnt);
    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
    	
    	//숫자
    	jsnObj.put("OtoCnt", ""+nCnt);
    	
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    }
   
    @RequestMapping("/mw/cmm/otoinqUpdate.ajax")
    public void otoinqUpdate(	@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	//log.info("/web/cmm/otoinqUpdate.do 호출");
    	
    	//otoinqVO.setWriter("U000000004");
    	//otoinqVO.setEmail("arisa@naver.com");
    	//otoinqVO.setLastModIp("127.0.0.1");
    	
    	//로그인 정보 얻기
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		//model.addAttribute("userInfo", userVO);
    		otoinqVO.setWriter(userVO.getUserId());
    		otoinqVO.setEmail(userVO.getEmail());
    		otoinqVO.setLastModIp(userVO.getLastLoginIp());
    	}else{
    		return;
    	}
    	
    	
    	ossOtoinqService.updateOtoinq(otoinqVO);
    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    	    	
    }
    
    @RequestMapping("/mw/cmm/otoinqDelete.ajax")
    public void otoinqDelete(	@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	//log.info("/web/cmm/otoinqDelete.do 호출");
    	
    	//추가
    	//ossOtoinqService.insertOtoinq(otoinqVO);
    	
    	ossOtoinqService.deleteOtoinqByOtoinqNum(otoinqVO);
    	
    	
    	//검색조건 조합
		if(Constant.ACCOMMODATION.equals( otoinqVO.getCorpCd() )){
			//숙소인 경우 검색 조건 다르게...
			otoinqSVO.setsCorpId(otoinqVO.getCorpId());
		}else{
			otoinqSVO.setsPrdtNum(otoinqVO.getPrdtNum());
		}
    	int nCnt = ossOtoinqService.getCntOtoinqCnt(otoinqSVO);
    	//log.info(">>>>>>>>>>>>>>>"+nCnt);

    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
    	
    	//숫자
    	jsnObj.put("OtoCnt", ""+nCnt);
    	
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    }
    
    
    @RequestMapping("/mw/cmm/otoinqIntiUI.ajax")
    public void IntiUI(@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	//log.info("/web/cmm/otoinqDelete.do 호출");
    	
   	
    	//검색조건 조합
		if(Constant.ACCOMMODATION.equals( otoinqVO.getCorpCd() )){
			//숙소인 경우 검색 조건 다르게...
			otoinqSVO.setsCorpId(otoinqVO.getCorpId());
		}else{
			otoinqSVO.setsPrdtNum(otoinqVO.getPrdtNum());
		}
    	int nCnt = ossOtoinqService.getCntOtoinqCnt(otoinqSVO);
    	//log.info(">>>>>>>>>>>>>>>"+nCnt);

    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
    	
    	//숫자
    	jsnObj.put("OtoCnt", ""+nCnt);
    	
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    	    	
    }
    
   
}
