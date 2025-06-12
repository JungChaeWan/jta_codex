package mw.product.web;


import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovWebUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import oss.ad.vo.AD_WEBLISTSVO;
import oss.otoinq.vo.OTOINQSVO;
import oss.otoinq.vo.OTOINQVO;
import oss.user.vo.USERVO;
import web.product.service.WebBloglinkService;
import web.product.vo.BLOGLINKSVO;
import web.product.vo.BLOGLINKVO;


/**
 * <pre>
 * 파일명 : WebCmmSNSController.java
 * 작성일 : 2017. 9. 18. 오전 11:47:53
 * 작성자 : 신우섭
 */
@Controller
public class MwCmmBLOGController {

    @Autowired
    private DefaultBeanValidator beanValidator;

    @Resource(name = "webBloglinkService")
	private WebBloglinkService webBloglinkService;

    Logger log = (Logger) LogManager.getLogger(this.getClass());


    /*
    @RequestMapping("/mw/cmm/bloglistIntiUI.ajax")
    public ModelAndView bloglistIntiUI(@ModelAttribute("BLOGLINKVO") BLOGLINKVO bolglinkVO,
    							HttpServletRequest request,
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	//log.info("/web/cmm/otoinqDelete.do 호출");

    	log.info("/mw/cmm/blogListIntiUI.ajax call "
    			+"[Prdtnum:" + bolglinkVO.getPrdtNum() + "]"
    			+"[CorpCd:" + bolglinkVO.getCorpCd() + "]");



    	int nCnt = webBloglinkService.getBlogLinkCount(bolglinkVO);

    	resultMap.put("Status", "success");

    	//숫자
    	resultMap.put("BlCnt", ""+nCnt);

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;

    }
    */


    @RequestMapping("/mw/cmm/blogList.ajax")
    public String blogList(@ModelAttribute("BLOGLINKVO") BLOGLINKVO bolglinkVO
    					  ,@ModelAttribute("searchVO") BLOGLINKSVO bolglinkSVO
    					  ,HttpServletRequest request
    					  , HttpServletResponse response, ModelMap model){

		log.info("/mw/cmm/blogList.ajax call " + "[Prdtnum:" + bolglinkVO.getPrdtNum() + "]" + "[CorpCd:" + bolglinkVO.getCorpCd() + "]");

		// 로그인 정보 얻기
		model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated() ? "Y" : "N");
		if (EgovUserDetailsHelper.isAuthenticated()) {
			USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
			model.addAttribute("userInfo", userVO);

			// log.info("===========" + userVO.getAuthNum() + " : " +
			// userVO.getAuthNm());
		} else {
			model.addAttribute("userInfo", null);
		}

		// 페이징 관련 설정
		bolglinkSVO.setPageUnit(6);
		bolglinkSVO.setPageSize(10);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bolglinkSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bolglinkSVO.getPageUnit());
		paginationInfo.setPageSize(bolglinkSVO.getPageSize());

		bolglinkSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bolglinkSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bolglinkSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		bolglinkSVO.setsPrdtNum(bolglinkVO.getPrdtNum());

		Map<String, Object> resultMap = webBloglinkService.selectLinkListPage(bolglinkSVO);
		@SuppressWarnings("unchecked")
		List<BLOGLINKVO> resultList = (List<BLOGLINKVO>) resultMap.get("resultList");

		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
		model.addAttribute("blogList", resultList);
		model.addAttribute("blogListTotalCnt", resultMap.get("totalCnt"));
		model.addAttribute("blogPaginationInfo", paginationInfo);

		// List<BLOGLINKVO> resultList =
		// webBloglinkService.selectLinkList(bolglinkVO);
		// model.addAttribute("blogList", resultList);

    	return "/mw/cmm/blogList";
    }

}
