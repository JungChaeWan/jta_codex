package web.product.web;


import java.io.PrintWriter;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import api.vo.APILSRESULTVO;
import api.vo.APILSVO;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.AD_PRDTINFVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.sp.service.MasSpService;
import mas.sp.vo.SP_PRDTINFVO;
import net.sf.json.JSONObject;

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
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.prdt.vo.PRDTVO;
import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.*;
import oss.user.vo.USERVO;
import web.product.service.WebRcProductService;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovWebUtil;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 사용자 이용후기 공용 컨트털
 * 파일명 : WebCmmUseepilController.java
 * 작성일 : 2015. 10. 26. 오전 9:27:33
 * 작성자 : 신우섭
 */
@Controller
public class WebCmmUseepilController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;
	
	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;
	
	@Resource(name="ossUesepliService")
	private OssUesepliService ossUesepliService;	
	
	@Resource(name = "masAdPrdtService")
	protected MasAdPrdtService masAdPrdtService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;
	
	@Resource(name = "masSpService")
	private MasSpService masSpService;
	
	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;
	
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    @RequestMapping("/web/cmm/useepilList.ajax")
    public String useepilList(	@ModelAttribute("USEEPILVO") USEEPILVO useepilVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    		   					ModelMap model){
    	
    	log.info("/web/cmm/useepilList.ajax call "
    			+"[corpId:" + useepilVO.getCorpId() + "]"
    			+"[Prdtnum:" + useepilVO.getPrdtnum() + "]"
    			+"[CorpCd:" + useepilVO.getCorpCd() + "]"
    			+"[PageIndex:" + useepilVO.getPageIndex() + "]");
    	
    	//로그인 정보 얻기
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		model.addAttribute("userInfo", userVO);
    	}else{
    		model.addAttribute("userInfo", null);
    	}
    	
    	log.info("/web/cmm/useepilList.ajax call 1");


    	//페이징 관련 설정
    	useepilSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	useepilSVO.setPageSize(propertiesService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(useepilSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(useepilSVO.getPageUnit());
		paginationInfo.setPageSize(useepilSVO.getPageSize());

		useepilSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		useepilSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		useepilSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		log.info("/web/cmm/useepilList.ajax call 2");
		
		
		//검색조건 조합
		if(Constant.ACCOMMODATION.equals( useepilVO.getCorpCd() ) || Constant.RENTCAR.equals( useepilVO.getCorpCd() )){
				//숙소인 경우 검색 조건 다르게...
				useepilSVO.setsCorpId(useepilVO.getCorpId());
		}else{
			//상품평 추가(통합)
			List<USEEPILADDVO> useepilAddList = ossUesepliService.selectUseepilAddList(useepilVO.getPrdtnum());
			if (useepilAddList == null || useepilAddList.isEmpty()) {
				useepilSVO.setsPrdtNum(useepilVO.getPrdtnum());
			}else{
				List<String> cPrdtNumList = new ArrayList<>();
				cPrdtNumList.add(useepilVO.getPrdtnum());
				for (USEEPILADDVO vo : useepilAddList){
					cPrdtNumList.add(vo.getcPrdtNum());
				}
				useepilSVO.setUseepilPrdtList(cPrdtNumList);
			}
		}
		useepilSVO.setsPrintYn("Y");
		log.info("/web/cmm/useepilList.ajax call 3");
		
		//상품평 얻기
		Map<String, Object> resultMap = ossUesepliService.selectUseepilListWeb(useepilSVO);
		@SuppressWarnings("unchecked")
		List<USEEPILVO> resultList = (List<USEEPILVO>) resultMap.get("resultList");
		
		
		log.info("/web/cmm/useepilList.ajax call 4");
			
		//상품평 댓글 얻기
		List<USEEPILCMTVO> resultCmtList = ossUesepliService.selectUseepCmtilListWeb(useepilSVO);
		
		//상품평 이미지 얻기
		List<USEEPILIMGVO> resultImgList = ossUesepliService.selectUseepilImgListWeb(useepilSVO); 
		
		log.info("/web/cmm/useepilList.ajax call 5");
		
		//데이터 가공
		for(USEEPILVO data: resultList){
			//log.info("/web/cmm/useepilList.do 호출:"+data.getSubject());
			
			//내용
			data.setContentsOrg(data.getContents());
			data.setContents(EgovWebUtil.clearXSSMinimum(data.getContents()) );
			data.setContents( data.getContents().replaceAll("\n", "<br/>\n") );
			
			//아이디
			String strEmail = data.getEmail();
			if(strEmail.length() < 3){
				strEmail = "***";
			}else{
				strEmail = strEmail.substring(0,3)+"*****";
			}
			data.setEmail(strEmail);
			
			
			//답글 조합
			List<USEEPILCMTVO> listCmt = new ArrayList<USEEPILCMTVO>(); 
			for(USEEPILCMTVO dataCmt: resultCmtList){
				if( "Y".equals(dataCmt.getPrintYn()) ){
					if( data.getUseEpilNum().equals(dataCmt.getUseEpilNum()) ){
						//log.info("/web/cmm/useepilList.do 호출:"+data.getUseEpilNum()+":"+dataCmt.getUseEpilNum()+":"+dataCmt.getContents());
						
						dataCmt.setContentsOrg(dataCmt.getContents());
						dataCmt.setContents(EgovWebUtil.clearXSSMinimum(dataCmt.getContents()) );
						dataCmt.setContents( dataCmt.getContents().replaceAll("\n", "<br/>\n") );
						listCmt.add(dataCmt);
					}
				}
			}
			data.setCmtList(listCmt);
			
			// 이미지 조합
			List<USEEPILIMGVO> listImg = new ArrayList<USEEPILIMGVO>();
			for (USEEPILIMGVO dataImg : resultImgList) {
				if (data.getUseEpilNum().equals(dataImg.getUseEpilNum())) {
					listImg.add(dataImg);
				}
			}
			data.setImgList(listImg);
			
		}
		
		log.info("/web/cmm/useepilList.ajax call 6");
		
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
		
		model.addAttribute("useepilList", resultList);
		//model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("useepilPaginationInfo", paginationInfo);
	
		log.info("/web/cmm/useepilList.ajax call 7");
		
    	return "/web/cmm/useepilList";
    }
    
    
    @RequestMapping("/web/cmm/useepilInsert.ajax")
    public void useepilInsert(	@ModelAttribute("USEEPILVO") USEEPILVO useepilVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	//log.info("/web/cmm/useepilInsert.do 호출");
    	
    	//로그인 정보 얻기
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		//model.addAttribute("userInfo", userVO);
    		useepilVO.setUserId(userVO.getUserId());
    		useepilVO.setEmail(userVO.getEmail());
    		useepilVO.setFrstRegIp(userVO.getLastLoginIp());
    		//log.info("/web/cmm/useepilInsert.do 호출["+useepilVO.getUserId() );
    	}else{
    		return;
    	}
    	
    	//log.info("/web/cmm/useepilInsert.do 호출>>>>>"+useepilVO.getCorpId()+ ":::" + useepilVO.getPrdtnum() + ":"+ useepilVO.getCorpCd() );
    	
    	
    	CORPVO corpVO = new CORPVO();
   		corpVO.setCorpId(useepilVO.getCorpId());
   		CORPVO corpRes = ossCorpService.selectByCorp(corpVO);
   		useepilVO.setCorpNm(corpRes.getCorpNm());
   		//log.info("/web/cmm/useepilInsert.do 호출>>>>>1:"+ useepilVO.getCorpNm());
    	
    	//제품명 검색
		if(Constant.ACCOMMODATION.equals( useepilVO.getCorpCd() )){
			AD_PRDTINFVO adPrdt = new AD_PRDTINFVO();
    		adPrdt.setPrdtNum( useepilVO.getPrdtnum() ); 
    		AD_PRDTINFVO adPrdtRes = masAdPrdtService.selectByAdPrdinf(adPrdt);
    		useepilVO.setPrdtNm( adPrdtRes.getPrdtNm() );
			
		}else if(Constant.RENTCAR.equals( useepilVO.getCorpCd() )){
			RC_PRDTINFVO rcPrdt = new RC_PRDTINFVO();
			rcPrdt.setPrdtNum( useepilVO.getPrdtnum() );
			RC_PRDTINFVO rcPrdtRes = webRcProductService.selectByPrdt(rcPrdt);
    		useepilVO.setPrdtNm( rcPrdtRes.getPrdtNm() );

		}else if(Constant.SOCIAL.equals( useepilVO.getCorpCd() )){
			SP_PRDTINFVO spPrdt = new SP_PRDTINFVO();
			spPrdt.setPrdtNum( useepilVO.getPrdtnum() );
			SP_PRDTINFVO spPrdtRes = masSpService.selectBySpPrdtInf(spPrdt);
			useepilVO.setPrdtNm( spPrdtRes.getPrdtNm() );
		}
		
		//log.info("/web/cmm/useepilInsert.do 호출>>>>>"+useepilVO.getCorpNm()+ ":::" + useepilVO.getPrdtNm() );
    	
    	ossUesepliService.insertUseepil(useepilVO);
    	
    	//평점 평균 및 후기 수 다시 계산
    	GPAANLSVO gpaVO = new GPAANLSVO();
    	if(Constant.ACCOMMODATION.equals( useepilVO.getCorpCd() )){
    		//숙소만 업체명 입력
        	gpaVO.setsCorpId(useepilVO.getCorpId());
        	gpaVO.setLinkNum(useepilVO.getCorpId());
    	}else{
    		gpaVO.setsPrdtNum(useepilVO.getPrdtnum());
        	gpaVO.setLinkNum(useepilVO.getPrdtnum());
    	}
    	GPAANLSVO gpaVORes = ossUesepliService.mergeGpaanls(gpaVO);
    	//log.info("/web/cmm/useepilInsert.do 호출>"+ gpaVORes.getGpaAvg() + ":" + gpaVORes.getGpaCnt() );

    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
    	
    	//댓글 숫자 및 평점 리턴
    	jsnObj.put("GpaAvg", gpaVORes.getGpaAvg());
    	jsnObj.put("GpaCnt", gpaVORes.getGpaCnt());
    	
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    	    	
    }
    
    
    @RequestMapping("/web/cmm/useepilUpdate.ajax")
    public void useepilUpdate(	@ModelAttribute("USEEPILVO") USEEPILVO useepilVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	//log.info("/web/cmm/useepilUpdate.do 호출");
    	
    	//로그인 정보 얻기
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		//model.addAttribute("userInfo", userVO);
    		useepilVO.setLastModId(userVO.getUserId());
    		useepilVO.setLastModIp(userVO.getLastLoginIp());
    		
    		//log.info("/web/cmm/useepilUpdate.do 호출"+ useepilVO.getUserId() );
    	}else{
    		return;
    	}
    	
    	CORPVO corpVO = new CORPVO();
   		corpVO.setCorpId(useepilVO.getCorpId());
   		CORPVO corpRes = ossCorpService.selectByCorp(corpVO);
   		useepilVO.setCorpNm(corpRes.getCorpNm());
   		//log.info("/web/cmm/useepilInsert.do 호출>>>>>1:"+ useepilVO.getCorpNm());
    	
    	//제품명 검색
		if(Constant.ACCOMMODATION.equals( useepilVO.getCorpCd() )){
			AD_PRDTINFVO adPrdt = new AD_PRDTINFVO();
    		adPrdt.setPrdtNum( useepilVO.getPrdtnum() ); 
    		AD_PRDTINFVO adPrdtRes = masAdPrdtService.selectByAdPrdinf(adPrdt);
    		useepilVO.setPrdtNm( adPrdtRes.getPrdtNm() );
			
		}else if(Constant.RENTCAR.equals( useepilVO.getCorpCd() )){
			RC_PRDTINFVO rcPrdt = new RC_PRDTINFVO();
			rcPrdt.setPrdtNum( useepilVO.getPrdtnum() );
			RC_PRDTINFVO rcPrdtRes = webRcProductService.selectByPrdt(rcPrdt);
    		useepilVO.setPrdtNm( rcPrdtRes.getPrdtNm() );

		}else if(Constant.SOCIAL.equals( useepilVO.getCorpCd() )){
			SP_PRDTINFVO spPrdt = new SP_PRDTINFVO();
			spPrdt.setPrdtNum( useepilVO.getPrdtnum() );
			SP_PRDTINFVO spPrdtRes = masSpService.selectBySpPrdtInf(spPrdt);
			useepilVO.setPrdtNm( spPrdtRes.getPrdtNm() );
		}
    	
    	ossUesepliService.updateUsespilByCont(useepilVO);
    	
    	//평점 평균 및 후기 수 다시 계산
    	GPAANLSVO gpaVO = new GPAANLSVO();
    	if(Constant.ACCOMMODATION.equals( useepilVO.getCorpCd() )){
    		//숙소만 업체명 입력
        	gpaVO.setsCorpId(useepilVO.getCorpId());
        	gpaVO.setLinkNum(useepilVO.getCorpId());
    	}else{
    		gpaVO.setsPrdtNum(useepilVO.getPrdtnum());
        	gpaVO.setLinkNum(useepilVO.getPrdtnum());
    	}
    	GPAANLSVO gpaVORes = ossUesepliService.mergeGpaanls(gpaVO);
    	//log.info("/web/cmm/useepilUpdate.do 호출>"+ gpaVORes.getGpaAvg() + ":" + gpaVORes.getGpaCnt() );
    	
    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
    	
    	//댓글 숫자 및 평점 리턴
    	jsnObj.put("GpaAvg", gpaVORes.getGpaAvg());
    	jsnObj.put("GpaCnt", gpaVORes.getGpaCnt());
    	
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    	    	
    }
    
    
    @RequestMapping("/web/cmm/useepilCmtInsert.ajax")
    public void useepilCmtInsert(	@ModelAttribute("USEEPILCMTVO") USEEPILCMTVO useepilCmtVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	//log.info("/web/cmm/useepilCmtInsert.do 호출");

    	//로그인 정보 얻기
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		//model.addAttribute("userInfo", userVO);
    		useepilCmtVO.setUserId(userVO.getUserId());
    		useepilCmtVO.setEmail(userVO.getEmail());
    		useepilCmtVO.setFrstRegIp(userVO.getLastLoginIp());
    	}else{
    		return;
    	}
    	
    	ossUesepliService.insertUseepilCmt(useepilCmtVO);
    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    	    	
    }
    
    @RequestMapping("/web/cmm/useepilCmtUpdate.ajax")
    public void useepilCmtUpdate(	@ModelAttribute("USEEPILCMTVO") USEEPILCMTVO useepilCmtVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	//log.info("/web/cmm/useepilCmtUpdate.do 호출");
    	
    	//로그인 정보 얻기
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		//model.addAttribute("userInfo", userVO);
    		useepilCmtVO.setLastModId(userVO.getUserId());
    		useepilCmtVO.setLastModIp(userVO.getLastLoginIp());
    	}else{
    		return;
    	}
    	
    	ossUesepliService.updateUsespilCmtByCont(useepilCmtVO);
    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    	    	
    }
    
    
    @RequestMapping("/web/cmm/useepilCmtDelete.ajax")
    public void useepilCmtDelete(	@ModelAttribute("USEEPILCMTVO") USEEPILCMTVO useepilCmtVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	//log.info("/web/cmm/useepilCmtDelete.do 호출");
    	
   	
    	//ossUesepliService. insertUseepilCmt(useepilCmtVO);
    	ossUesepliService.deleteUsespilCmtByCmtSn(useepilCmtVO);
    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    	    	
    }
    
    @RequestMapping("/web/cmm/useepilInitUI.ajax")
    public void useepilInitUI(	@ModelAttribute("USEEPILVO") USEEPILVO useepilVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	
    	log.info("/web/cmm/useepilInitUI.ajax call "
    			+"[corpId:" + useepilVO.getCorpId() + "]"
    			+"[Prdtnum:" + useepilVO.getPrdtnum() + "]"
    			+"[CorpCd:" + useepilVO.getCorpCd() + "]"
    			+"[PageIndex:" + useepilVO.getPageIndex() + "]");
    	
    	JSONObject jsnObj = new JSONObject();
		if(EgovStringUtil.isEmpty(useepilVO.getCorpId()) || EgovStringUtil.isEmpty(useepilVO.getPrdtnum())) {
			jsnObj.put("GpaAvg", "0");
        	jsnObj.put("GpaCnt", "0");
        	jsnObj.put("Status", "success");
		} else {
			
			//평점 평균 및 후기 수 다시 계산
	    	GPAANLSVO gpaVO = new GPAANLSVO();
			if(Constant.ACCOMMODATION.equals(useepilVO.getCorpCd())){
	    		//숙소만 업체명 입력
	        	gpaVO.setLinkNum(useepilVO.getCorpId());
	    	} else {
	        	gpaVO.setLinkNum(useepilVO.getPrdtnum());
	    	}
			
			GPAANLSVO gpaVORes = ossUesepliService.selectByGpaanls(gpaVO);
	    	if(gpaVORes == null){
	    		jsnObj.put("GpaAvg", "0");
	        	jsnObj.put("GpaCnt", "0");
	    	}else{
	    		jsnObj.put("GpaAvg", gpaVORes.getGpaAvg());
	        	jsnObj.put("GpaCnt", gpaVORes.getGpaCnt());    		
	    	}
	    	jsnObj.put("Status", "success");
		}
    	
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    }
    
    /**
     * 이용후기에 해당하는 상품평의 이미지 리스트 출력
     * Function : useepilImgList
     * 작성일 : 2016. 8. 23. 오후 5:52:38
     * 작성자 : 정동수
     * @param
     * @param request
     * @param response
     * @param model
     * @throws Exception
     */
    @RequestMapping("/web/cmm/useepilImgListDiv.ajax")
    public void useepilImgListDiv(	@ModelAttribute("USEEPILVO") USEEPILVO useepilVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	log.info("/web/cmm/useepilImgListDiv.do 호출");
    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("imgList", ossUesepliService.selectUseepilImgListDiv(useepilVO));
    	
    	response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    }
    
    @RequestMapping("/web/cmm/useepilImgDelete.ajax")
    public void useepilImgDelete(@ModelAttribute("USEEPILIMGVO") USEEPILIMGVO useepilImgVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	log.info("/web/cmm/useepilImgDelete.do 호출");
    	
    	ossFileUtilService.deleteUseepilImage(useepilImgVO);
    	
    	JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
    	
    	response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter(); 
		printWriter.print(jsnObj.toString()); 
		printWriter.flush(); 
		printWriter.close();
    }

	/**
	* 설명 : 상품선택에 따른 후기유형 get
	* 파일명 : getReviewType
	* 작성일 : 2024-10-15 오후 2:04
	* 작성자 : chaewan.jung
	* @param : [apilsvo]
	* @return : org.springframework.web.servlet.ModelAndView
	* @throws Exception
	*/
	@RequestMapping("/web/cmm/getReviewType.ajax")
	public ModelAndView getReviewType(String hrkCode) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		//코드 정보 얻기
		List<CDVO> cdAdar = ossCmmService.selectCode(hrkCode);

		resultMap.put("reviewTypeList",cdAdar);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/**
	* 설명 : 상품정보 자동완성기능
	* 파일명 : getPrdtInfo
	* 작성일 : 2024-10-17 오전 11:30
	* 작성자 : chaewan.jung
	* @param : [hrkCode]
	* @return : org.springframework.web.servlet.ModelAndView
	* @throws Exception
	*/
	@RequestMapping("/web/cmm/getPrdtInfo.ajax")
	public ModelAndView getPrdtInfo(String prdtNum) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		//상품 정보
		PRDTVO prdtInfo = ossCmmService.selectPrdtInfo(prdtNum);

		resultMap.put("prdtNum",prdtInfo.getPrdtNum());
		resultMap.put("prdtNm",prdtInfo.getPrdtNm());
		resultMap.put("confDttm",prdtInfo.getConfDttm());

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/**
	* 설명 : 추가 된 상품평 리스트
	* 파일명 : getUseepilAddList
	* 작성일 : 2024-10-17 오후 5:23
	* 작성자 : chaewan.jung
	* @param : [prdtNum]
	* @return : org.springframework.web.servlet.ModelAndView
	* @throws Exception
	*/
	@RequestMapping("/web/cmm/getUseepilAddList.ajax")
	public ModelAndView getUseepilAddList(String prdtNum) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		//추가 상품평 리스트
		List<USEEPILADDVO> useepilAddList = ossUesepliService.selectUseepilAddList(prdtNum);
		resultMap.put("useepilAddList", useepilAddList);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/**
	 * 설명 : 기 상품평에 새로운 상품평 추가
	 * 파일명 : insertUseepilAdd
	 * 작성일 : 2024-10-18 오전 11:07
	 * 작성자 : chaewan.jung
	 * @param : [useepilAddVO]
	 * @return : org.springframework.web.servlet.ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/web/cmm/insertUseepilAdd.ajax")
	public ModelAndView insertUseepilAdd(@ModelAttribute("USEEPILADDVO") USEEPILADDVO useepilAddVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success","Y");

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		useepilAddVO.setRegId(corpInfo.getUserId());

		//상품평 유무체크 및 정보 get
		PRDTVO oDataChk = ossCmmService.selectPrdtInfo(useepilAddVO.getoPrdtNumSend());
		PRDTVO cDataChk = ossCmmService.selectPrdtInfo(useepilAddVO.getcPrdtNumSend());

		if(oDataChk == null){
			resultMap.put("success","OX");
		} else if(cDataChk == null){
			resultMap.put("success","CX");
		} else {
			useepilAddVO.setcConfDttm(cDataChk.getConfDttm());
			useepilAddVO.setcPrdtNm(cDataChk.getPrdtNm());

			//상품평 추가
			ossUesepliService.insertUseepilAdd(useepilAddVO);
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/**
	* 설명 : 추가 된 상품평 삭제
	* 파일명 : deleteUseepilAdd
	* 작성일 : 2024-10-18 오후 2:15
	* 작성자 : chaewan.jung
	* @param : [useepilAddVO]
	* @return : org.springframework.web.servlet.ModelAndView
	* @throws Exception
	*/
	@RequestMapping("/web/cmm/deleteUseepilAdd.ajax")
	public ModelAndView deleteUseepilAdd(int seq) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success","Y");
		//상품평 삭제
		ossUesepliService.deleteUseepilAdd(seq);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
}
