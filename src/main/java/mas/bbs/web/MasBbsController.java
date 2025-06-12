package mas.bbs.web;



import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.bbs.service.OssBbsService;
import oss.bbs.vo.BBSSVO;
import oss.bbs.vo.BBSVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.user.vo.USERVO;
import web.bbs.service.WebBbsService;
import web.bbs.vo.NOTICECMTVO;
import web.bbs.vo.NOTICEFILEVO;
import web.bbs.vo.NOTICESVO;
import web.bbs.vo.NOTICEVO;

import common.EgovUserDetailsHelper;

import egovframework.cmmn.EgovWebUtil;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;



@Controller
public class MasBbsController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;
	
	@Resource(name="ossBbsService")
    private OssBbsService ossBbsService;
	
	@Resource(name="webBbsService")
    private WebBbsService webBbsService;
	
	@Resource(name="ossFileUtilService")
    private OssFileUtilService ossFileUtilService;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());

    
    @RequestMapping("/mas/bbs/bbsList.do")
	public String bbsList(@ModelAttribute("searchVO") NOTICESVO notiSVO
										, ModelMap model
										, HttpServletRequest request)throws Exception{
		log.info("/mas/bbs/bbsList.do 호출");
		
		log.info("/mas/bbs/bbsList.do 호출>>>"+notiSVO.getsKeyOpt() + ":" + notiSVO.getsKey() );
		
		if(notiSVO.getsBbsNum()==null || notiSVO.getsBbsNum().isEmpty() ){
			notiSVO.setsBbsNum(request.getParameter("bbsNum"));
		}
		
		if(notiSVO.getsBbsNum()==null || notiSVO.getsBbsNum().isEmpty() ){
			return "redirect:/web/cmm/error.do?errCord=BBS01";
		}
		
		//USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	//
		
		//로그인 정보 얻기
		int nLoginAuth = 0;
		USERVO userVO = null;
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	
    	userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		model.addAttribute("userInfo", userVO);
		log.info(">>>>>>>>>>>"+userVO.getAuthNm());
		//userVO.getAuthNm();//권한명 > "ADMIN"
		if("ADMIN".equals(userVO.getAuthNm())){
			nLoginAuth = 7;
		}else if("USER".equals(userVO.getAuthNm())){
			nLoginAuth = 1;
		}
    	
   	
		//게시판 정보 얻기
		BBSSVO bbsSVO = new BBSSVO();		
		bbsSVO.setsBbsNum(notiSVO.getsBbsNum());
		BBSVO bbsRes = ossBbsService.selectByBbs(bbsSVO);
		model.addAttribute("bbs", bbsRes);
		if(bbsRes==null){
		}

		
		//권한 설정
		int nBBSAuthList 	= Integer.parseInt( bbsRes.getListAuth() );
		int nBBSAuthDtl 	= Integer.parseInt( bbsRes.getDtlAuth() );
		int nBBSAuthReg 	= Integer.parseInt( bbsRes.getRegAuth() );;
		
		String strAuthListYn 	="N";
		String strAuthDtlYn		="N";
		String strAuthRegYn		="N";
		
		if(nBBSAuthList <= nLoginAuth){
			strAuthListYn 	="Y";
		}
		model.addAttribute("authListYn", strAuthListYn);
		
		if(nBBSAuthDtl <= nLoginAuth){
			strAuthDtlYn 	="Y";
		}
		model.addAttribute("authDtlYn", strAuthDtlYn);
		
		if(nBBSAuthReg <= nLoginAuth){
			strAuthRegYn 	="Y";
		}
		model.addAttribute("authRegYn", strAuthRegYn);
		
		//페이지 설정
		notiSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	notiSVO.setPageSize(propertiesService.getInt("pageSize"));
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(notiSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(notiSVO.getPageUnit());
		paginationInfo.setPageSize(notiSVO.getPageSize());
		notiSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		notiSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		notiSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 20.05.15 디자인요청 게시판 - 업체별 본인 글만 확인 가능하도록 userId  추가_김지연
		notiSVO.setsUserId(userVO.getUserId());
		notiSVO.setsAuthNm(userVO.getAuthNm());
		
		//게시글 읽기
		Map<String, Object> resultMap = webBbsService.selectList(notiSVO);
		@SuppressWarnings("unchecked")
		List<NOTICEVO> resultList = (List<NOTICEVO>) resultMap.get("resultList");
		
		//데이터 가공
		for(NOTICEVO data: resultList){
			
			//내용
			data.setContentsOrg(data.getContents());
			//data.setContents(EgovWebUtil.clearXSSMinimum(data.getContents()) );
			//data.setContents( data.getContents().replaceAll("\n", "<br/>\n") );
			data.setContents(EgovStringUtil.checkHtmlView(data.getContents()) );
			
			/*
			//이메일
			String strEmail = data.getEmail();
			if(strEmail.length() < 3){
				strEmail = "***";
			}else{
				strEmail = strEmail.substring(0,3)+"*****";
			}
			data.setEmail(strEmail);
			*/
					
		}

		
		model.addAttribute("resultList", resultList);
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		
		/*
		//뷰로
		if("MASQA".equals(notiSVO.getsBbsNum())){
			return "/web/coustmer/noticeList";
		}else if("QA".equals(notiSVO.getsBbsNum())){
			return "/web/coustmer/qaList";
		}else{
			return "/web/bbs/bbsList";
		}
		*/
		
		return "/mas/bbs/bbsList";
		
    }

    @RequestMapping("/mas/bbs/bbsDtl.do")
	public String bbsDtl(@ModelAttribute("NOTICEVO") NOTICEVO notiVO
						, @ModelAttribute("searchVO") NOTICESVO notiSVO
						, ModelMap model
						, HttpServletRequest request)throws Exception{
		log.info("/web/bbs/bbsDtl.do 호출");
		
		if(notiVO.getBbsNum()==null || notiVO.getBbsNum().isEmpty() ){
			return "redirect:/web/cmm/error.do?errCord=BBS01";
		}
		
		if(notiVO.getNoticeNum()==null || notiVO.getNoticeNum().isEmpty() ){
			return "redirect:/web/cmm/error.do?errCord=BBS02";
		}
		
		
		//로그인 정보 얻기
		int nLoginAuth = 0;
		USERVO userVO = null;
    	//model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	
		model.addAttribute("isLogin", "Y");
    	userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		model.addAttribute("userInfo", userVO);
		//userVO.getAuthNm();//권한명 > "ADMIN"
		if("ADMIN".equals(userVO.getAuthNm())){
			nLoginAuth = 7;
		}else if("USER".equals(userVO.getAuthNm())){
			nLoginAuth = 1;
		}
		
		/*
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		model.addAttribute("userInfo", userVO);
    		//log.info(">>>>>>>>>>>"+userVO.getAuthNm());
    		//userVO.getAuthNm();//권한명 > "ADMIN"
    		if("ADMIN".equals(userVO.getAuthNm())){
    			nLoginAuth = 7;
    		}else if("USER".equals(userVO.getAuthNm())){
    			nLoginAuth = 1;
    		}
    	
    	}else{
    		model.addAttribute("userInfo", null);
    				
    	}
    	*/
    	
    	
		//게시판 정보 얻기
		BBSSVO bbsSVO = new BBSSVO();		
		bbsSVO.setsBbsNum(notiVO.getBbsNum());
		BBSVO bbsRes = ossBbsService.selectByBbs(bbsSVO);
		model.addAttribute("bbs", bbsRes);
		if(bbsRes==null){
			log.info("/mas/bbs/bbsDtl.do 호출:게시판 오류");
			
			return "redirect:/web/cmm/error.do?errCord=BBS02";
		}

		
		//권한 설정
		int nBBSAuthDtl 	= Integer.parseInt( bbsRes.getDtlAuth() );
		int nBBSAuthMod 	= Integer.parseInt( bbsRes.getModAuth() );
		int nBBSAuthDel 	= Integer.parseInt( bbsRes.getDelAuth() );
		int nBBSAuthAns 	= Integer.parseInt( bbsRes.getAnsAuth() );
		
		String strAuthDtlYn		="N";
		String strAuthModYn		="N";
		String strAuthDelYn		="N";
		String strAuthAnsYn		="N";
		
		if(nBBSAuthDtl <= nLoginAuth){
			strAuthDtlYn 	="Y";
		}
		model.addAttribute("authDtlYn", strAuthDtlYn);
		
		if(nBBSAuthMod <= nLoginAuth){
			strAuthModYn 	="Y";
		}
		model.addAttribute("authModYn", strAuthModYn);
		
		if(nBBSAuthDel <= nLoginAuth){
			strAuthDelYn 	="Y";
		}
		model.addAttribute("authDelYn", strAuthDelYn);
		
		if(nBBSAuthAns <= nLoginAuth){
			strAuthAnsYn 	="Y";
		}
		model.addAttribute("authAnsYn", strAuthAnsYn);
		
		
		//게시글 읽기
		NOTICEVO notiRes = webBbsService.selectNotice(notiVO);		
		if(notiRes == null){
			log.info("/mas/bbs/bbsDtl.do 호출:게시글 오류");
		}
		
		
		//내용 가공
		notiRes.setContentsOrg(notiRes.getContents());
		if(notiRes.getHtmlYn().equals("N")){
			notiRes.setContents(EgovWebUtil.clearXSSMinimum(notiRes.getContents()) );
		}
		if(notiRes.getBrtagYn().equals("Y")){
			notiRes.setContents( notiRes.getContents().replaceAll("\n", "<br/>\n") );
		}	

		model.addAttribute("notice", notiRes);
		
		//첨부파일 읽기
		NOTICEFILEVO notiFileVO = new NOTICEFILEVO();
		notiFileVO.setBbsNum(notiRes.getBbsNum());
		notiFileVO.setNoticeNum(notiRes.getNoticeNum());
		List<NOTICEFILEVO> notiFileList = (List<NOTICEFILEVO>) webBbsService.selectNoticeFileList(notiFileVO);
		model.addAttribute("notiFileList", notiFileList);
		
		//이미지 파일 걸러내기
		List<NOTICEFILEVO> notiImgList = new ArrayList<NOTICEFILEVO>();
		for (NOTICEFILEVO noticefile : notiFileList) {
			String strExt = noticefile.getExt().toLowerCase();
			if("jpg".equals(strExt) || "jpeg".equals(strExt) || "gif".equals(strExt) ){
				notiImgList.add(noticefile);
			}
		}
		model.addAttribute("notiImgList", notiImgList);
		
		
		//물려있는 답글 얻기
		int nReCnt = webBbsService.getCnthrkNoticeNum(notiRes);
		model.addAttribute("reCnt", nReCnt);
		
		
		//댓글얻기
		NOTICECMTVO notiCmtVO = new NOTICECMTVO();
		notiCmtVO.setBbsNum(notiRes.getBbsNum() );
		notiCmtVO.setNoticeNum(notiRes.getNoticeNum() );
		List<NOTICECMTVO> notiCmtList =  (List<NOTICECMTVO>) webBbsService.selectCmtList(notiCmtVO);
		for (NOTICECMTVO cmtVO : notiCmtList) {
			cmtVO.setCmtContentsOrg(cmtVO.getCmtContents() );
			//cmtVO.setCmtContents(EgovWebUtil.clearXSSMinimum(cmtVO.getCmtContents()) );
			//cmtVO.setCmtContents( cmtVO.getCmtContents().replaceAll("\n", "<br/>\n") );
			cmtVO.setCmtContents(EgovStringUtil.checkHtmlView(cmtVO.getCmtContents()) );
		}
		
		model.addAttribute("cmtList", notiCmtList);
   
		return "/mas/bbs/bbsDtl";
		/*
		//뷰로
		if("NOTICE".equals(notiVO.getBbsNum())){
			return "/web/coustmer/noticeDtl";
		}else if("QA".equals(notiSVO.getsBbsNum())){
			return "/web/coustmer/qaDtl";
		}else{
			return "/web/bbs/bbsDtl";
		}
		*/
    }
    
    
    @RequestMapping("/mas/bbs/bbsFileDown.do")
   	public void bbsFileDown(@ModelAttribute("NOTICEFILEVO") NOTICEFILEVO notiFileVO
   						, HttpServletRequest request
   						, HttpServletResponse response
   						, ModelMap model	)throws Exception{
    	log.info("/mas/bbs/bbsFileDown.do 호출");
    	
    	NOTICEFILEVO notiFileRes = webBbsService.selectNoticeFile(notiFileVO);
    	
    	String strRoot = EgovProperties.getProperty("HOST.WEBROOT");
    	String strRealFileName = notiFileRes.getRealFileNm();
		String strSaveFilePath = strRoot + notiFileRes.getSavePath() + notiFileRes.getSaveFileNm() +"."+ notiFileRes.getExt();
		File fileSaveFile = new File(strSaveFilePath);
		
		if(fileSaveFile.exists() == false){
			log.info("file not exist!!");
			//오류처리
			return;
		}
				
		if (!fileSaveFile.isFile()) {
			log.info("file not isFile!!");
		    //throw new FileNotFoundException(downFileName);
			//오류처리
			return;
		}
		
		//카운트 증가
		webBbsService.updateNoticeDwldCntAdd(notiFileRes);
		
		
		String userAgent = request.getHeader("User-Agent");
		
		int fSize = (int)fileSaveFile.length();
		if (fSize > 0) {
			BufferedInputStream in = null;
			
		    try {
				in = new BufferedInputStream(new FileInputStream(fileSaveFile));
				
				//String mimetype = fileDownloads.getMimeType(strRealFileName); //"application/x-msdownload"
				
		    	response.setBufferSize(fSize);
				//response.setContentType(mimetype);
				
				// MS 익스플로어
				if(userAgent.indexOf("MSIE") >= 0){
					response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(strRealFileName, "UTF-8") + "\";");
				}
				else if(userAgent.indexOf("Trident") >= 0) {
					response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(strRealFileName, "UTF-8") + "\";");
				}
				// 크롬, 파폭
				else if(userAgent.indexOf("Mozilla/5.0") >= 0){
					response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(strRealFileName, "UTF-8") + ";charset=\"UTF-8\"");
				}else{
					response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(strRealFileName, "UTF-8") + "\";");
				}
				
				response.setContentLength(fSize);
	//			response.setHeader("Content-Transfer-Encoding","binary");
				//response.setHeader("Pragma","no-cache");
				//response.setHeader("Expires","0");
	//			FileCopyUtils.copy(in, response.getOutputStream());
				byte[] buff = new byte[2048];
				ServletOutputStream ouputStream = response.getOutputStream();
				FileInputStream inputStream = new FileInputStream(fileSaveFile);

				try{
					int size = -1;
					while((size = inputStream.read(buff)) > 0) {
						ouputStream.write(buff, 0, size);
						response.getOutputStream().flush();
					}
				}finally {
					try {
						in.close();
					}
					catch (IOException ex) {
					}
					try {
						ouputStream.close();
					}
					catch (IOException ex) {
					}
					inputStream.close();
				}
				
		    } finally {
				if (in != null) {
				    try {
				    	in.close();
				    } catch (Exception ignore) {
				    	log.info("IGNORED: " + ignore.getMessage());
				    }
				}
		    }
		    response.getOutputStream().close();

		}
		
    }
    
    
    @RequestMapping("/mas/bbs/bbsRegView.do")
	public String bbsInsView(@ModelAttribute("NOTICEVO") NOTICEVO notiVO
						, @ModelAttribute("searchVO") NOTICESVO notiSVO
						, ModelMap model
						, HttpServletRequest request)throws Exception{
		log.info("/mas/bbs/bbsRegView.do 호출");
		
		
		if(notiVO.getBbsNum()==null || notiVO.getBbsNum().isEmpty() ){
			return "redirect:/web/cmm/error.do?errCord=BBS01";
		}
		
		//로그인 정보 얻기
		int nLoginAuth = 0;
		USERVO userVO = null;
    	//model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	
		model.addAttribute("isLogin", "Y");
    	userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		model.addAttribute("userInfo", userVO);
		//userVO.getAuthNm();//권한명 > "ADMIN"
		if("ADMIN".equals(userVO.getAuthNm())){
			nLoginAuth = 7;
		}else if("USER".equals(userVO.getAuthNm())){
			nLoginAuth = 1;
		}
    	
		/*
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		model.addAttribute("userInfo", userVO);
    		//log.info(">>>>>>>>>>>"+userVO.getAuthNm());
    		//userVO.getAuthNm();//권한명 > "ADMIN"
    		if("ADMIN".equals(userVO.getAuthNm())){
    			nLoginAuth = 7;
    		}else if("USER".equals(userVO.getAuthNm())){
    			nLoginAuth = 1;
    		}
    	
    	}else{
    		model.addAttribute("userInfo", null);
    				
    	}
    	*/
    	
    	
		//게시판 정보 얻기
		BBSSVO bbsSVO = new BBSSVO();		
		bbsSVO.setsBbsNum(notiVO.getBbsNum());
		BBSVO bbsRes = ossBbsService.selectByBbs(bbsSVO);
		model.addAttribute("bbs", bbsRes);
		if(bbsRes==null){
			return "redirect:/web/cmm/error.do?errCord=BBS01";
			
		}

		
		//권한 설정
		int nBBSAuthReg 	= Integer.parseInt( bbsRes.getRegAuth() );
		String strAuthRegYn		="N";
		if(nBBSAuthReg <= nLoginAuth){
			strAuthRegYn 	="Y";
		}
		model.addAttribute("authRegYn", strAuthRegYn);
		
		if(userVO != null){
			//notiVO.setWriter(userVO.getUserNm());
			
			notiVO.setWriter(userVO.getCorpNm());
		}
		
		
		model.addAttribute("notice", notiVO);
		

		//글쓰기인지/ 답글인지 판단.
		if( notiVO.getNoticeNum()==null || notiVO.getNoticeNum().isEmpty()){
			//글쓰기
			//log.info("===[글쓰기]");
			model.addAttribute("isAnsWrite", "N");
			
		}else{
			//답글쓰기
			//log.info("===[답글]");
			model.addAttribute("isAnsWrite", "Y");
			
			//게시글 읽기
			NOTICEVO notiRes = webBbsService.selectNotice(notiVO);		
			if(notiRes != null){
				//내용 가공
				notiVO.setSubject("Re:"+ notiRes.getSubject());
				notiVO.setContents("\n\n\n\n\n\n"
						+ "---------------------------\n\n"
						+ ">>"+notiRes.getSubject()+"\n"
						+ "\n"
						+ notiRes.getContents());
			}
		}
		
		model.addAttribute("notice", notiVO);

		
		return "/mas/bbs/bbsReg";
		
		/*
		//뷰로
		if("NOTICE".equals(notiVO.getBbsNum())){
			return "/web/coustmer/noticeReg";
		}else if("QA".equals(notiSVO.getsBbsNum())){
			return "/web/coustmer/qaReg";
		}else{
			return "/web/bbs/bbaReg";
		}
		*/
		
    }
    
    
    @RequestMapping("/mas/bbs/bbsReg.do")
	public String bbsIns(final MultipartHttpServletRequest multiRequest
						, @ModelAttribute("NOTICEVO") NOTICEVO notiVO
						, @ModelAttribute("searchVO") NOTICESVO notiSVO
						, BindingResult bindingResult
						, ModelMap model)throws Exception{
		log.info("/mas/bbs/bbsReg.do 호출");
		
		if(StringUtils.isEmpty(notiVO.getBbsNum())){
			return "redirect:/web/cmm/error.do?errCord=BBS01";
		}
		//로그인 정보 얻기
		int nLoginAuth = 0;

    	model.addAttribute("isLogin", "Y");

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		model.addAttribute("userInfo", userVO);

		//userVO.getAuthNm();//권한명 > "ADMIN"
		if("ADMIN".equals(userVO.getAuthNm())){
			nLoginAuth = 7;
		}else if("USER".equals(userVO.getAuthNm())){
			nLoginAuth = 1;
		}
		/*
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		model.addAttribute("userInfo", userVO);
    		if("ADMIN".equals(userVO.getAuthNm())){
    			nLoginAuth = 7;
    		}else if("USER".equals(userVO.getAuthNm())){
    			nLoginAuth = 1;
    		}
    	}else{
    		model.addAttribute("userInfo", null);
    	}
    	*/
    	
		//게시판 정보 얻기
		BBSSVO bbsSVO = new BBSSVO();		
		bbsSVO.setsBbsNum(notiVO.getBbsNum());

		BBSVO bbsRes = ossBbsService.selectByBbs(bbsSVO);

		model.addAttribute("bbs", bbsRes);

		if(bbsRes==null){
			return "redirect:/web/cmm/error.do?errCord=BBS01";
		}

		//권한 설정
		int nBBSAuthReg = Integer.parseInt(bbsRes.getRegAuth());
		String strAuthRegYn = "N";
		if(nBBSAuthReg <= nLoginAuth){
			strAuthRegYn ="Y";
		}
		model.addAttribute("authRegYn", strAuthRegYn);

		// validation 체크
		beanValidator.validate(notiVO, bindingResult);
		
		if (bindingResult.hasErrors()){
			log.info("error");
			model.addAttribute("notiVO", notiVO);
			log.info(bindingResult.toString());

			return "/mas/bbs/bbaReg?bbsNum=" + notiVO.getBbsNum();
		}

		//첨부 파일 검사 
		String strChkExt = bbsRes.getAtcFileExt();
		if(strChkExt == null){
			strChkExt = "";
		}
		strChkExt = strChkExt.trim();
		strChkExt = strChkExt.toLowerCase();
		if("*".equals(strChkExt)){
			strChkExt = "";
		}
		
		//게시글 DB넣기
		notiVO.setUserId(userVO.getUserId());
		notiVO.setFrstRegId(userVO.getUserId());
		notiVO.setFrstRegIp(userVO.getLastLoginIp());

		String strNoticeNum;
		
		if(StringUtils.isEmpty(notiVO.getHrkNoticeNum())){
			//글쓰기
			strNoticeNum = webBbsService.insertNotice(notiVO);
		}else{
			//답글 쓰기
			
			/*
			//댑스 증가
			int nAnsSn = Integer.parseInt(notiVO.getAnsSn())+1;

			//답글관련 정보 얻기
			NOTICEVO tBLNotice1 = new NOTICEVO();
			tBLNotice1.setBbsNum(notiVO.getBbsNum());
			tBLNotice1.setHrkNoticeNum(notiVO.getHrkNoticeNum());
			tBLNotice1.setAnsNum(notiVO.getAnsNum());
			tBLNotice1.setAnsSn(""+nAnsSn);
			String strAnsNum = mngBBSService.selectNoticeAnsNum(tBLNotice1);
			
			//정보 수정해서 답글 넣기
			notiVO.setHrkNoticeNum(tBLNotice1.getHrkNoticeNum() );
			notiVO.setAnsNum(strAnsNum );
			notiVO.setAnsSn(""+nAnsSn );
			*/
			strNoticeNum = webBbsService.insertNoticeRe(notiVO);
		}
			
		//저장경로 /storage/bbs/[게시판번호]/[년-월]/
		String strDate = new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date());
		String strSaveFilePath = EgovProperties.getProperty("BBS.SAVEDFILE") + bbsRes.getBbsNum() + "/" + strDate + "/";

		notiVO.setNoticeNum(strNoticeNum);

		ossFileUtilService.uploadNoticeFile(multiRequest, strSaveFilePath, strChkExt, notiVO);

		return "redirect:/mas/bbs/bbsList.do?bbsNum=" + notiVO.getBbsNum();
    }
    
    
    @RequestMapping("/mas/bbs/bbsDel.do")
   	public String bbsDel(@ModelAttribute("NOTICEVO") NOTICEVO notiVO
   						, ModelMap model
   						, HttpServletRequest request)throws Exception{
   		log.info("/mas/bbs/bbsDel.do 호출");
   		
   		if(notiVO.getBbsNum()==null || notiVO.getBbsNum().isEmpty() ){
			return "redirect:/web/cmm/error.do?errCord=BBS01";
		}
   		
   		if(notiVO.getNoticeNum()==null || notiVO.getNoticeNum().isEmpty() ){
			return "redirect:/web/cmm/error.do?errCord=BBS02";
		}
   		
   		//로그인 정보 얻기
   		int nLoginAuth = 0;
   		USERVO userVO = null;
       	//model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
   		
   		model.addAttribute("isLogin", "Y");
       	userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		model.addAttribute("userInfo", userVO);
		//userVO.getAuthNm();//권한명 > "ADMIN"
		if("ADMIN".equals(userVO.getAuthNm())){
			nLoginAuth = 7;
		}else if("USER".equals(userVO.getAuthNm())){
			nLoginAuth = 1;
		}
		/*
       	if(EgovUserDetailsHelper.isAuthenticated()){
       		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
       		model.addAttribute("userInfo", userVO);
       		if("ADMIN".equals(userVO.getAuthNm())){
       			nLoginAuth = 7;
       		}else if("USER".equals(userVO.getAuthNm())){
       			nLoginAuth = 1;
       		}
       	
       	}else{
       		model.addAttribute("userInfo", null);
       				
       	}
       	*/
       	
       	
   		//게시판 정보 얻기
   		BBSSVO bbsSVO = new BBSSVO();		
   		bbsSVO.setsBbsNum(notiVO.getBbsNum());
   		BBSVO bbsRes = ossBbsService.selectByBbs(bbsSVO);
   		model.addAttribute("bbs", bbsRes);
   		if(bbsRes==null){
   			return "redirect:/web/cmm/error.do?errCord=BBS01";
   		}

   		//권한 설정
		int nBBSAuthDel 	= Integer.parseInt( bbsRes.getDelAuth() );
		String strAuthDelYn		="N";
		if(nBBSAuthDel <= nLoginAuth){
			strAuthDelYn 	="Y";
		}else{
			return "redirect:/web/cmm/error.do?errCord=BBS03";
		}
		model.addAttribute("authDelYn", strAuthDelYn);
		
		
		//답글삭제
		
		//파일삭제
		ossFileUtilService.deleteNoticeFile(notiVO.getBbsNum(), notiVO.getNoticeNum());
		
		//글 삭제
		webBbsService.deleteNotice(notiVO);
   		
   		return "redirect:/mas/bbs/bbsList.do?bbsNum="+notiVO.getBbsNum();
    }
    
    
    @RequestMapping("/mas/bbs/bbsModView.do")
	public String bbsModView(@ModelAttribute("NOTICEVO") NOTICEVO notiVO
						, @ModelAttribute("searchVO") NOTICESVO notiSVO
						, ModelMap model
						, HttpServletRequest request)throws Exception{
		log.info("/mas/bbs/bbsModView.do 호출");
		
		if(notiVO.getBbsNum()==null || notiVO.getBbsNum().isEmpty() ){
			return "redirect:/web/cmm/error.do?errCord=BBS01";
		}

		if(notiVO.getNoticeNum()==null || notiVO.getNoticeNum().isEmpty() ){
			return "redirect:/web/cmm/error.do?errCord=BBS02";
		}
		
		
		//로그인 정보 얻기
		int nLoginAuth = 0;
		USERVO userVO = null;
    	//model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
		
		model.addAttribute("isLogin", "Y");
    	userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		model.addAttribute("userInfo", userVO);
		//userVO.getAuthNm();//권한명 > "ADMIN"
		if("ADMIN".equals(userVO.getAuthNm())){
			nLoginAuth = 7;
		}else if("USER".equals(userVO.getAuthNm())){
			nLoginAuth = 1;
		}
		
		/*
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		model.addAttribute("userInfo", userVO);
    		//log.info(">>>>>>>>>>>"+userVO.getAuthNm());
    		//userVO.getAuthNm();//권한명 > "ADMIN"
    		if("ADMIN".equals(userVO.getAuthNm())){
    			nLoginAuth = 7;
    		}else if("USER".equals(userVO.getAuthNm())){
    			nLoginAuth = 1;
    		}
    	
    	}else{
    		model.addAttribute("userInfo", null);
    				
    	}
    	*/
    	
		//게시판 정보 얻기
		BBSSVO bbsSVO = new BBSSVO();		
		bbsSVO.setsBbsNum(notiVO.getBbsNum());
		BBSVO bbsRes = ossBbsService.selectByBbs(bbsSVO);
		model.addAttribute("bbs", bbsRes);
		if(bbsRes==null){
			log.info("/mas/bbs/bbsModView.do 호출:게시판 오류");
			return "redirect:/web/cmm/error.do?errCord=BBS01";
		}

		
		//권한 설정
		int nBBSAuthMod 	= Integer.parseInt( bbsRes.getModAuth() );
		String strAuthModYn		="N";
		if(nBBSAuthMod <= nLoginAuth){
			strAuthModYn 	="Y";
		}
		model.addAttribute("authModYn", strAuthModYn);
		//게시글 읽기

		NOTICEVO notiRes = webBbsService.selectNotice(notiVO);		
		if(notiRes == null){
			log.info("/mas/bbs/bbsModView.do 호출:게시글 오류");
			return "redirect:/web/cmm/error.do?errCord=BBS02";
		}
		
		
		model.addAttribute("notice", notiRes);
		
		//첨부파일 읽기
		NOTICEFILEVO notiFileVO = new NOTICEFILEVO();
		notiFileVO.setBbsNum(notiRes.getBbsNum());
		notiFileVO.setNoticeNum(notiRes.getNoticeNum());
		List<NOTICEFILEVO> notiFileList = (List<NOTICEFILEVO>) webBbsService.selectNoticeFileList(notiFileVO);
		model.addAttribute("notiFileList", notiFileList);
   
		return "/mas/bbs/bbsMod";
		
		/*
		//뷰로
		if("NOTICE".equals(notiVO.getBbsNum())){
			return "/web/coustmer/noticeMod";
		}else if("QA".equals(notiSVO.getsBbsNum())){
			return "/web/coustmer/qaMod";
		}else{
			return "/web/bbs/bbsMod";
		}
		*/
    }
    
    
    
    @RequestMapping("/mas/bbs/bbsMod.do")
   	public String bbsMod(final MultipartHttpServletRequest multiRequest
   						, @ModelAttribute("NOTICEVO") NOTICEVO notiVO
   						, @ModelAttribute("searchVO") NOTICESVO notiSVO
   						, ModelMap model
   						, HttpServletRequest request)throws Exception{
   		log.info("/mas/bbs/bbsMod.do 호출");
   		
   		if(notiVO.getBbsNum()==null || notiVO.getBbsNum().isEmpty() ){
			return "redirect:/web/cmm/error.do?errCord=BBS01";
		}

   		if(notiVO.getNoticeNum()==null || notiVO.getNoticeNum().isEmpty() ){
			return "redirect:/web/cmm/error.do?errCord=BBS02";
		}
   		
   		//로그인 정보 얻기
		int nLoginAuth = 0;
		USERVO userVO = null;
    	//model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
		model.addAttribute("isLogin", "Y");
    	userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		model.addAttribute("userInfo", userVO);
		//userVO.getAuthNm();//권한명 > "ADMIN"
		if("ADMIN".equals(userVO.getAuthNm())){
			nLoginAuth = 7;
		}else if("USER".equals(userVO.getAuthNm())){
			nLoginAuth = 1;
		}
		/*
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		model.addAttribute("userInfo", userVO);
    		//log.info(">>>>>>>>>>>"+userVO.getAuthNm());
    		//userVO.getAuthNm();//권한명 > "ADMIN"
    		if("ADMIN".equals(userVO.getAuthNm())){
    			nLoginAuth = 7;
    		}else if("USER".equals(userVO.getAuthNm())){
    			nLoginAuth = 1;
    		}
    	
    	}else{
    		model.addAttribute("userInfo", null);
    				
    	}
    	*/
    	
		//게시판 정보 얻기
		BBSSVO bbsSVO = new BBSSVO();		
		bbsSVO.setsBbsNum(notiVO.getBbsNum());
		BBSVO bbsRes = ossBbsService.selectByBbs(bbsSVO);
		model.addAttribute("bbs", bbsRes);
		if(bbsRes==null){
			log.info("/mas/bbs/bbsMod.do 호출:게시판 오류");
			return "redirect:/web/cmm/error.do?errCord=BBS01";
		}

		
		//권한 설정
		int nBBSAuthMod 	= Integer.parseInt( bbsRes.getModAuth() );
		String strAuthModYn		="N";
		if(nBBSAuthMod <= nLoginAuth){
			strAuthModYn 	="Y";
		}else{
			return "redirect:/web/cmm/error.do?errCord=BBS03";
		}
		//model.addAttribute("authModYn", strAuthModYn);


		//DB넣기
		notiVO.setLastModId(userVO.getUserId());
		notiVO.setLastModIp(userVO.getLastLoginIp());
		webBbsService.updateNotice(notiVO);
		
		
		//첨부 파일 검사 
		String strChkExt = bbsRes.getAtcFileExt();
		if(strChkExt == null){
			strChkExt = "";
		}
		strChkExt = strChkExt.trim();
		strChkExt = strChkExt.toLowerCase();
		if(strChkExt.equals("*")){
			strChkExt = "";
		}
		
		//파일 저장
		//저장경로 /storage/bbs/[게시판번호]/[년-월]/
		String strDate = new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date());
		String strSaveFilePath = EgovProperties.getProperty("BBS.SAVEDFILE")+bbsRes.getBbsNum()+"/"+strDate+"/";
		ossFileUtilService.uploadNoticeFile(multiRequest, strSaveFilePath, strChkExt, notiVO);
		

   		return "redirect:/mas/bbs/bbsDtl.do?bbsNum="+notiVO.getBbsNum()+"&noticeNum="+notiVO.getNoticeNum()+"&pageIndex="+notiSVO.getPageIndex()+"&sKeyOpt="+notiSVO.getsKeyOpt()+"&sKey="+notiSVO.getsKey();
    }
    
    
    @RequestMapping("/mas/bbs/bbsDelFile.do")
   	public String bbsDelFile(@ModelAttribute("NOTICEVO") NOTICEVO notiVO
   						, @ModelAttribute("searchVO") NOTICESVO notiSVO
   						, ModelMap model
   						, HttpServletRequest request)throws Exception{
   		log.info("/mas/bbs/bbsDelFile.do 호출");
   		
   		String strFileNum = request.getParameter("fileNum");
   		
   		ossFileUtilService.deleteNoticeFile(notiVO.getBbsNum(), notiVO.getNoticeNum(), strFileNum);
   		
   		return "redirect:/mas/bbs/bbsModView.do?bbsNum="+notiVO.getBbsNum()+"&noticeNum="+notiVO.getNoticeNum()+"&pageIndex="+notiSVO.getPageIndex()+"&sKeyOpt="+notiSVO.getsKeyOpt()+"&sKey="+notiSVO.getsKey();
   		
    }
    
    
    @RequestMapping("/mas/bbs/bbsRegCmt.do")
	public String bbsRegCmt(@ModelAttribute("NOTICECMTVO") NOTICECMTVO noticeCmtVO
							, BindingResult bindingResult
							, ModelMap model
							, HttpServletRequest request) throws Exception {
		log.info("/mas/bbs/bbsRegCmt.do 호출");

		//로그인 정보 얻기
		USERVO userVO = null;
    	//model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	
		model.addAttribute("isLogin", "Y");
    	userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		model.addAttribute("userInfo", userVO);
		
		noticeCmtVO.setRegId(userVO.getUserId());
		noticeCmtVO.setEmail(userVO.getEmail());

		//댓글 넣기
		webBbsService.inserCmt(noticeCmtVO);
		
		return "redirect:/mas/bbs/bbsDtl.do?bbsNum="+noticeCmtVO.getBbsNum()
						+"&noticeNum="+noticeCmtVO.getNoticeNum()
						+"&pageIndex="+noticeCmtVO.getPageIndex()
						+"&sKeyOpt="+noticeCmtVO.getsKeyOpt()
						+"&sKey="+noticeCmtVO.getsKey();
		
	}
    
    @RequestMapping("/mas/bbs/bbsModCmt.do")
	public String bbsModCmt(@ModelAttribute("NOTICECMTVO") NOTICECMTVO noticeCmtVO
							, BindingResult bindingResult
							, ModelMap model
							, HttpServletRequest request) throws Exception {
		log.info("/mas/bbs/bbsModCmt.do 호출");

		//로그인 정보 얻기
		USERVO userVO = null;
    	//model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	
		model.addAttribute("isLogin", "Y");
    	userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		model.addAttribute("userInfo", userVO);

		//댓글 수정
		webBbsService.updateCmt(noticeCmtVO);
		
		return "redirect:/mas/bbs/bbsDtl.do?bbsNum="+noticeCmtVO.getBbsNum()
						+"&noticeNum="+noticeCmtVO.getNoticeNum()
						+"&pageIndex="+noticeCmtVO.getPageIndex()
						+"&sKeyOpt="+noticeCmtVO.getsKeyOpt()
						+"&sKey="+noticeCmtVO.getsKey();
		
	}
    
    
    @RequestMapping("/mas/bbs/bbsDelCmt.do")
	public String bbsDelCmt(@ModelAttribute("NOTICECMTVO") NOTICECMTVO noticeCmtVO
							, BindingResult bindingResult
							, ModelMap model
							, HttpServletRequest request) throws Exception {
		log.info("/mas/bbs/bbsDelCmt.do 호출");
		
		//로그인 정보 얻기
		USERVO userVO = null;
    	//model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	
		model.addAttribute("isLogin", "Y");
    	userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		model.addAttribute("userInfo", userVO);

		//댓글 넣기
		webBbsService.deleteCmt(noticeCmtVO);
		
		return "redirect:/mas/bbs/bbsDtl.do?bbsNum="+noticeCmtVO.getBbsNum()
						+"&noticeNum="+noticeCmtVO.getNoticeNum()
						+"&pageIndex="+noticeCmtVO.getPageIndex()
						+"&sKeyOpt="+noticeCmtVO.getsKeyOpt()
						+"&sKey="+noticeCmtVO.getsKey();
		
	}
    
}
