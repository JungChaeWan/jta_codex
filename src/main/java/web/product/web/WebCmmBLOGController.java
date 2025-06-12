package web.product.web;


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

import oss.useepil.vo.USEEPILVO;
import oss.user.vo.USERVO;
import web.product.service.WebBloglinkService;
import web.product.vo.BLOGLINKSVO;
import web.product.vo.BLOGLINKVO;
import common.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * <pre>
 * 파일명 : WebCmmSNSController.java
 * 작성일 : 2017. 9. 18. 오전 11:47:53
 * 작성자 : 신우섭
 */
@Controller
public class WebCmmBLOGController {

    @Autowired
    private DefaultBeanValidator beanValidator;

    @Resource(name = "webBloglinkService")
	private WebBloglinkService webBloglinkService;

    Logger log = (Logger) LogManager.getLogger(this.getClass());


    private String formtblogDate(String orgDate){


    	String rtnDate = orgDate;
    	//log.info("--------------Date:"+ rtnDate);


    	if( !(orgDate==null || orgDate.isEmpty() || "".equals(orgDate) ) ){
    		rtnDate = rtnDate.replace(".", "");//log.info("--------------Date:"+ rtnDate);
	    	rtnDate = rtnDate.replace(" ", "");//log.info("--------------Date:"+ rtnDate);
	    	rtnDate = rtnDate.replace("-", "");//log.info("--------------Date:"+ rtnDate);
	    	rtnDate = rtnDate.replace("/", "");//log.info("--------------Date:"+ rtnDate);
	    	rtnDate = rtnDate.replace(":", "");

	    	//날짜만 남기기
	    	if(rtnDate.length() > 8){
	    		rtnDate = rtnDate.substring(0, 8);
	    	}

	    	//log.info("--------------Date:"+ rtnDate);


    	}

    	return rtnDate;
    }


    private boolean getSNSMate_General(String blogsUrl, ModelMap model, String site) {
    	log.info("---Call getSNSMate_General()");

    	String blogUrl ="";
    	String blogImage ="";
    	String blogSitename ="";
    	String blogTitle ="";
    	String blogDescription ="";
    	String blogDate ="";


    	//Connection.Response req = Jsoup.connect("http://lifeinjejuu.tistory.com/14").method(Connection.Method.GET).execute();
    	Connection.Response req = null;
		try {
			req = Jsoup.connect(blogsUrl).method(Connection.Method.GET).execute();
		} catch (IOException e) {

			//e.printStackTrace();
			log.info("Error URL");

			return false;
		}

    	Document doc=null;
		try {
			doc = req.parse();
		} catch (IOException e) {
			//e.printStackTrace();
			log.info("Error req.pars");

			return false;
		}

    	//log.info("\n==================================================================================================================================================================\n"
    	//		+doc.html()
    	//		+"\n============================================================================================================\n"
    	//		);

    	//log.info("\n==================================================================================================================================================================\n"
    	//		+doc.text()
    	//		+"\n============================================================================================================\n"
    	//		);


    	//네이버 블로그 검사
    	Elements ogTagsC = doc.select("frame[name$=screenFrame]"); //프레임 안에 소스가 있어서...
    	for (int i = 0; i < ogTagsC.size(); i++) {
            Element tag = ogTagsC.get(i);

            String frameUrl = tag.attr("src");
            String strPerUrl = "http";

            //log.info("--------------re: "+ frameUrl );


            if( frameUrl.startsWith("https:")){
            	strPerUrl = "https";
            }

            return getSNSMate_Naver(frameUrl, model, strPerUrl);
    	}



    	Elements ogTags = doc.select("meta[property^=og:]");
    	for (int i = 0; i < ogTags.size(); i++) {
            Element tag = ogTags.get(i);

            String text = tag.attr("property");
            if ("og:url".equals(text)) {
            	blogUrl = tag.attr("content");

            } else if ("og:image".equals(text)) {
            	blogImage = tag.attr("content");

            } else if ("og:description".equals(text)) {
                blogDescription = tag.attr("content");

            } else if ("og:title".equals(text)) {
            	blogTitle = tag.attr("content");

            } else if ("og:site_name".equals(text)) {
            	blogSitename = tag.attr("content");

            } else if ("og:regDate".equals(text)) {
            	blogDate = tag.attr("content");
            	blogDate = formtblogDate(blogDate);
            }
        }

    	Elements ogTags2;

    	//네이버일 경우 추가 작업
    	if("naver".equals(site)){

    		//블로그 명

    		////ID로 가저오기
    		//Elements ogTagsN = doc.select("#blogTitleName");
        	//for (int i = 0; i < ogTagsN.size(); i++) {
        	//	Element tag = ogTagsN.get(i);
        	//	//log.info("--------------Text:"+ tag.text());
        	//	blogSitename = tag.text();
        	//}
    		//blogSitename 문자열 바꾸기
    		blogSitename = blogSitename.substring(10, blogSitename.length());

    		//날짜 얻기
    		ogTags2 = doc.select("._postAddDate");
        	for (int i = 0; i < ogTags2.size(); i++) {
                Element tag = ogTags2.get(i);
                //log.info("--------------Date:"+ tag.text());
                blogDate = tag.text();
                blogDate = formtblogDate(blogDate);
                break;
        	}

        	if("".equals(blogDate) ){
        		ogTags2 = doc.select(".se_publishDate");
        		for (int i = 0; i < ogTags2.size(); i++) {
                    Element tag = ogTags2.get(i);
                    //log.info("--------------Date:"+ tag.text());
                    blogDate = tag.text();
                    blogDate = formtblogDate(blogDate);
                    break;
            	}

        	}
    	}

    	//다음일 경우 추가 작업
    	if("daum".equals(site)){

    		//블로그 이름
    		ogTags2 = doc.select("meta[name$=author]");
        	for (int i = 0; i < ogTags2.size(); i++) {
                Element tag = ogTags2.get(i);
                //log.info("--------------blogSitename:"+ tag.attr("content"));
                blogSitename = tag.attr("content");
                break;
        	}

        	//날짜 얻기
    		ogTags2 = doc.select(".cB_Tdate");
        	for (int i = 0; i < ogTags2.size(); i++) {
                Element tag = ogTags2.get(i);
                //log.info("--------------Date:"+ tag.text());
                blogDate = tag.text();
                blogDate = formtblogDate(blogDate);
                break;
        	}


    	}


    	model.addAttribute("blogUrl", blogUrl);
    	model.addAttribute("blogImage", blogImage);
    	model.addAttribute("blogSitename", blogSitename);
    	model.addAttribute("blogTitle", blogTitle);
    	model.addAttribute("blogDescription", blogDescription);
    	model.addAttribute("blogDate", blogDate);

    	return true;


	}

    private boolean getSNSMate_Naver(String blogsUrl, ModelMap model, String strPerUrl) {
    	log.info("---Call getSNSMate_Naver()");

    	//Connection.Response req = Jsoup.connect("http://lifeinjejuu.tistory.com/14").method(Connection.Method.GET).execute();
    	Connection.Response req = null;
		try {
			req = Jsoup.connect(blogsUrl).method(Connection.Method.GET).execute();
		} catch (IOException e) {

			e.printStackTrace();
			log.info("Error URL");

			return false;
		}

    	Document doc=null;
		try {
			doc = req.parse();
		} catch (IOException e) {
			e.printStackTrace();
			log.info("Error req.pars");

			return false;
		}

    	//log.info("\n==================================================================================================================================================================\n"
    	//		+doc.html()
    	//		+"\n============================================================================================================\n"
    	//		);

    	//log.info("\n==================================================================================================================================================================\n"
    	//		+doc.text()
    	//		+"\n============================================================================================================\n"
    	//		);

    	Elements ogTags = doc.select("frame[name$=mainFrame]"); //프레임 안에 소스가 있어서...
    	for (int i = 0; i < ogTags.size(); i++) {
            Element tag = ogTags.get(i);

            //log.info("--------------scr:"+ tag.attr("src"));

            String frameUrl = tag.attr("src");

            //blogDate = tag.attr("content");

           	//log.info("-------------- "+ strPerUrl+"://blog.naver.com" + tag.attr("src"));
           	getSNSMate_General(strPerUrl+"://blog.naver.com"+ frameUrl, model, "naver");



            break;


    	}

    	return true;
	}

    private boolean getSNSMate_Daum(String blogsUrl, ModelMap model, String strPerUrl) {
    	log.info("---Call getSNSMate_Daum()");

    	//Connection.Response req = Jsoup.connect("http://lifeinjejuu.tistory.com/14").method(Connection.Method.GET).execute();
    	Connection.Response req = null;
		try {
			req = Jsoup.connect(blogsUrl).method(Connection.Method.GET).execute();
		} catch (IOException e) {

			e.printStackTrace();
			log.info("Error URL");

			return false;
		}

    	Document doc=null;
		try {
			doc = req.parse();
		} catch (IOException e) {
			e.printStackTrace();
			log.info("Error req.pars");

			return false;
		}

    	//log.info("\n==================================================================================================================================================================\n"
    	//		+doc.html()
    	//		+"\n============================================================================================================\n"
    	//		);

    	//log.info("\n==================================================================================================================================================================\n"
    	//		+doc.text()
    	//		+"\n============================================================================================================\n"
    	//		);

    	Elements ogTags = doc.select("frame[name$=BlogMain]"); //프레임 안에 소스가 있어서...
    	for (int i = 0; i < ogTags.size(); i++) {
            Element tag = ogTags.get(i);

            //log.info("--------------"+ tag.attr("src"));

            String frameUrl = tag.attr("src");

            //blogDate = tag.attr("content");

            getSNSMate_General(strPerUrl+"://blog.daum.net"+ frameUrl, model, "daum");

            log.info("-------------- "+ strPerUrl+"://blog.daum.net" + tag.attr("src"));

            break;


    	}

    	return true;
	}


    @RequestMapping("/web/cmm/insBLOG.do")
    public String insBLOG(HttpServletRequest request,
								HttpServletResponse response,
    		   					ModelMap model) {
    	log.info("/web/cmm/insBLOG.do call");

    	String prdtNum = request.getParameter("prdtNum");
    	String corpCd = request.getParameter("corpCd");
    	String blogsUrl = request.getParameter("blogsUrl");

    	model.addAttribute("prdtNum", prdtNum);
    	model.addAttribute("corpCd", corpCd);
    	model.addAttribute("blogsUrl", blogsUrl);

    	if(blogsUrl==null || blogsUrl.isEmpty()){
    		return "/web/cmm/insBLOG";
    	}

    	boolean bRtn;

    	if( blogsUrl.startsWith("http://blog.naver.com/PostView.nhn?") ||  blogsUrl.startsWith("https://blog.naver.com/PostView.nhn?")  ){
    		//네이버 프레임 소스이면
    		bRtn = getSNSMate_General(blogsUrl, model, "naver");
    	}else if(blogsUrl.startsWith("http://blog.naver.com") ){
    		bRtn = getSNSMate_Naver(blogsUrl, model, "http");
    	}else if(blogsUrl.startsWith("https://blog.naver.com")){
    		bRtn = getSNSMate_Naver(blogsUrl, model, "https");

    	}else if( blogsUrl.startsWith("http:blog.daum.net/_blog/BlogTypeView.do?") ||  blogsUrl.startsWith("https://blog.daum.net/_blog/BlogTypeView.do?")  ){
    		//다음 프레임 소스이면
    		bRtn = getSNSMate_General(blogsUrl, model, "duam");
    	}else if(blogsUrl.startsWith("http://blog.daum.net") ){
    		bRtn = getSNSMate_Daum(blogsUrl, model, "http");
    	}else if(blogsUrl.startsWith("https://blog.daum.net")){
    		bRtn = getSNSMate_Daum(blogsUrl, model, "https");

    	}else{

    		bRtn = getSNSMate_General(blogsUrl, model, "");
    	}



    	if(bRtn){
    		model.addAttribute("error", "N");
    	}else{
    		model.addAttribute("error", "Y");
    	}

    	return "/web/cmm/insBLOG";
    }


    @RequestMapping("/web/cmm/insBLOGproc.do")
    public String insBLOGproc(@ModelAttribute("BLOGLINKVO") BLOGLINKVO bolglinkVO,
    							HttpServletRequest request,
								HttpServletResponse response,
								final MultipartHttpServletRequest multiRequest,
    		   					ModelMap model) {
    	log.info("/web/cmm/insBLOGproc.do call");

    	String blogsUrl = request.getParameter("blogsUrl");
    	bolglinkVO.setBlogUrl(blogsUrl);



    	//DB에 넣기
    	webBloglinkService.insertBlogLink(bolglinkVO, multiRequest);

    	model.addAttribute("prdtNum", bolglinkVO.getPrdtNum());
    	model.addAttribute("corpCd", bolglinkVO.getCorpCd());


    	return "/web/cmm/insBLOGproc";

    }


    @RequestMapping("/web/cmm/edtBLOG.do")
    public String edtBLOG(@ModelAttribute("BLOGLINKVO") BLOGLINKVO bolglinkVO,
    							HttpServletRequest request,
								HttpServletResponse response,
    		   					ModelMap model) {
    	log.info("/web/cmm/edtBLOG.do call");

    	//String prdtNum = request.getParameter("prdtNum");
    	//String corpCd = request.getParameter("corpCd");
    	//String blogsUrl = request.getParameter("blogsUrl");

    	bolglinkVO = webBloglinkService.selectByBlogLink(bolglinkVO.getBlogLinkNum() );

    	log.info("/web/cmm/edtBLOG.do call : " + bolglinkVO.getBlogLinkNum() );


    	model.addAttribute("blogLinkNum", bolglinkVO.getBlogLinkNum());
    	model.addAttribute("prdtNum", bolglinkVO.getPrdtNum());
    	model.addAttribute("corpCd", bolglinkVO.getCorpCd());
    	model.addAttribute("blogUrl", bolglinkVO.getBlogUrl());
    	model.addAttribute("blogImage", bolglinkVO.getBlogImage());
    	model.addAttribute("blogImageLinkYn", bolglinkVO.getBlogImageLinkYn());
    	model.addAttribute("blogSitename", bolglinkVO.getBlogSitename());
    	model.addAttribute("blogTitle", bolglinkVO.getBlogTitle());
    	model.addAttribute("blogDescription", bolglinkVO.getBlogDescription());
    	model.addAttribute("blogDate", bolglinkVO.getBlogDate());

       	return "/web/cmm/edtBLOG";
    }


    @RequestMapping("/web/cmm/edtBLOGproc.do")
    public String edtBLOGproc(@ModelAttribute("BLOGLINKVO") BLOGLINKVO bolglinkVO,
    							HttpServletRequest request,
								HttpServletResponse response,
								final MultipartHttpServletRequest multiRequest,
    		   					ModelMap model) {
    	log.info("/web/cmm/edtBLOGproc.do call");

    	String blogsUrl = request.getParameter("blogsUrl");
    	bolglinkVO.setBlogUrl(blogsUrl);



    	//DB에 넣기
    	webBloglinkService.updateBlogLink(bolglinkVO, multiRequest);

    	model.addAttribute("prdtNum", bolglinkVO.getPrdtNum());
    	model.addAttribute("corpCd", bolglinkVO.getCorpCd());


    	return "/web/cmm/insBLOGproc";

    }





    @RequestMapping("/web/cmm/bloglistIntiUI.ajax")
    public ModelAndView bloglistIntiUI(@ModelAttribute("BLOGLINKVO") BLOGLINKVO bolglinkVO,
    							HttpServletRequest request,
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	//log.info("/web/cmm/otoinqDelete.do 호출");

    	log.info("/web/cmm/blogListIntiUI.ajax call "
    			+"[Prdtnum:" + bolglinkVO.getPrdtNum() + "]"
    			+"[CorpCd:" + bolglinkVO.getCorpCd() + "]");


    	//로그인 정보 얻기
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		//model.addAttribute("userInfo", userVO);

    		//log.info("===========" + userVO.getAuthNum() + " : " + userVO.getAuthNm());

    		resultMap.put("authNm", ""+userVO.getAuthNm());
    	}else{
    		//model.addAttribute("userInfo", null);
    	}



    	int nCnt = webBloglinkService.getBlogLinkCount(bolglinkVO);

    	resultMap.put("Status", "success");

    	//숫자
    	resultMap.put("BlCnt", ""+nCnt);

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;

    }


    @RequestMapping("/web/cmm/blogList.ajax")
    public String blogList(@ModelAttribute("BLOGLINKVO") BLOGLINKVO bolglinkVO,
    						@ModelAttribute("searchVO") BLOGLINKSVO bolglinkSVO,
								HttpServletRequest request,
								HttpServletResponse response,
    		   					ModelMap model){


    	log.info("/web/cmm/blogList.ajax call "
    			+"[Prdtnum:" + bolglinkVO.getPrdtNum() + "]"
    			+"[CorpCd:" + bolglinkVO.getCorpCd() + "]");


    	//로그인 정보 얻기
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		model.addAttribute("userInfo", userVO);

    		//log.info("===========" + userVO.getAuthNum() + " : " + userVO.getAuthNm());
    	}else{
    		model.addAttribute("userInfo", null);
    	}

    	//페이징 관련 설정
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



    	//List<BLOGLINKVO> resultList = webBloglinkService.selectLinkList(bolglinkVO);
    	//model.addAttribute("blogList", resultList);

    	return "/web/cmm/blogList";
    }

    @RequestMapping("/web/cmm/blogLinkDel.ajax")
    public ModelAndView blogLinkDel(@ModelAttribute("BLOGLINKVO") BLOGLINKVO bolglinkVO,
    							HttpServletRequest request,
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	//log.info("/web/cmm/otoinqDelete.do 호출");

    	log.info("/web/cmm/blogLinkDel.ajax call "
    			+"[BlogLinkNum:" + bolglinkVO.getBlogLinkNum() + "]");



    	webBloglinkService.deleteBlogLink(bolglinkVO);


    	resultMap.put("prdtNum", bolglinkVO.getPrdtNum());
    	resultMap.put("corpCd", bolglinkVO.getCorpCd());

    	resultMap.put("Status", "success");


    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;

    }


}
