package mw.member.web;


import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import mas.ad.service.MasAdPrdtService;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssMailService;
import oss.cmm.web.AES256;
import oss.cmm.web.SHA256;
import oss.user.service.OssUserService;
import oss.user.vo.LOGINLOGVO;
import oss.user.vo.USERSVO;
import oss.user.vo.USERVO;
import web.cs.service.WebUserSnsService;
import web.main.service.WebMainService;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.USER_CPVO;
import web.order.service.WebCartService;
import web.product.service.WebAdProductService;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;

/**
 * @author 최영철
 * @since  2015. 9. 16.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@Controller
public class MwMemberController {

    @Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "ossUserService")
	protected OssUserService ossUserService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "masAdPrdtService")
	protected MasAdPrdtService masAdPrdtService;

	@Resource(name = "webMainService")
	private WebMainService webMainService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name="webUserCpService")
	protected WebUserCpService webUserCpService;

	@Resource(name = "ossMailService")
	protected OssMailService ossMailService;

	@Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Resource(name = "webCartService")
	private WebCartService webCartService;
	
	@Resource(name = "webUserSnsService")
	private WebUserSnsService webUserSnsService;

    Logger log = LogManager.getLogger(this.getClass());


    @RequestMapping("/mw/signUp00.do")
    public String signUp00(@ModelAttribute("USERVO") USERVO userVO,
						   HttpServletRequest request,
						   ModelMap model) {

		Map<String, ?> snsMap = RequestContextUtils.getInputFlashMap(request);

		if(snsMap != null) {
			model.addAttribute("snsMap", snsMap.get("snsInfo"));
		}
        return "/mw/member/signUp00";
    }

    @RequestMapping("/mw/signUp.do")
    public String signUp(@ModelAttribute("USERVO") USERVO userVO) {

    	return "/mw/member/signUp01";
    }
    
    @RequestMapping("/mw/restSign.do")
    public String restSign(@ModelAttribute("USERVO") USERVO userVO,
						   ModelMap model) {
    	userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if(userVO != null){
			model.addAttribute("userNm", userVO.getUserNm());			
		} else {
			String protocolUrl = "";
			return "redirect:" + protocolUrl + "/mw/viewLogin.do";
		}
    	return "/mw/member/restSign";
    }

    /**
     * 회원가입완료
     * 파일명 : signUp02
     * 작성일 : 2015. 10. 28. 오후 1:31:47
     * 작성자 : 최영철
     * @param userVO
     * @return
     */
    @RequestMapping("/mw/signUp02.do")
    public String signUp02(@ModelAttribute("USERVO") USERVO userVO) {

    	return "/mw/member/signUp02";
    }


    /**
     * 사용자 회원가입
     * 파일명 : insertUser
     * 작성일 : 2015. 10. 28. 오후 1:32:17
     * 작성자 : 최영철
     * @param user
     * @return
     * @throws Exception
     */
    @RequestMapping("/mw/insertUser.do")
    public String insertUser(@ModelAttribute("USERVO") USERVO user,
							 HttpServletRequest request) throws Exception {

		if(EgovStringUtil.isEmpty(user.getSnsDiv())) {
			SHA256 sha256 = new SHA256();
			String pwd = sha256.getSHA256_pwd(user.getPwd());
			user.setPwd(pwd);
		}
		user.setAuthNm("USER");
		user.setPartnerCode((String) request.getSession().getAttribute("ssPartnerCode"));

		String partner = (String)request.getSession().getAttribute("partner");
		if(StringUtils.isNotEmpty(partner)){
			USERVO userTPVO = new USERVO();
			userTPVO.setPartnerCd(partner);
			if(webMainService.selectTamnaoPartnersCnt(userTPVO) > 0){
				userTPVO =  webMainService.selectTamnaoPartner(userTPVO);
				user.setPartnerCd(userTPVO.getPartnerNm());
			}
		}

		String userId = ossUserService.insertUser(user);

        // 접속 IP
        String userIp = EgovClntInfo.getClntIP(request);
        user.setLastLoginIp(userIp);

		if(StringUtils.isNotEmpty(user.getSnsDiv())) {
			user.setUserId(userId);

			webUserSnsService.insertUserSns(user);
			
			USERVO resultVO = webUserSnsService.actionSnsLogin(user);
			request.getSession().setAttribute("loginVO", resultVO);
		} else {
	    	// 로그인 처리
	    	USERVO resultVO = ossUserService.actionWebLogin(user);
	    	request.getSession().setAttribute("loginVO", resultVO);
		}
		// 쿠폰 발행.
		webUserCpService.epilCpPublish(userId);
		// 황금빛 제주 쿠폰 발행 처리
//		ossEventService.evntPublish(userId);
		// 메일 전송
		ossMailService.sendRegUser(user, user.getEmail(), request);

		return "redirect:/mw/signUp02.do";
	}

    @RequestMapping("/mw/viewLogin.do")
    public String viewLogin(@ModelAttribute("loginVO") USERVO loginVO,
                            HttpServletRequest request,
                            HttpServletResponse response,
                            ModelMap model) {
		// http -> https 변환
		String url = request.getRequestURL().toString();

		if(url.startsWith("http://")) {
			String ip = request.getRemoteAddr();

			if(url.indexOf("localhost") < 0 && url.indexOf("dev") < 0 && url.indexOf("tamnao.iptime.org") < 0 && ip.indexOf("192.168.0.1") < 0 && ip.indexOf("218.157.128.119") < 0) {
				url = url.replaceAll("http://", "https://");
				//http, https 포트 번호 제거
				int port = request.getServerPort();

				if(port == 80 || port == 443) {
					url = url.replace(":" + port, "");
				}
				String query = request.getQueryString();

				if(StringUtils.isNotEmpty(query)) {
					url += "?" + query;
				}
				try {
					response.sendRedirect(url);
				} catch (IOException e) {
					log.error(e.toString());
				}
			}
		}
		//게스트 로그인 날리기
    	request.getSession().setAttribute("guestLoginVO", null);

    	String urlParam = "";
		// 파라미터 묶음
		@SuppressWarnings("rawtypes")
		Enumeration eNames = request.getParameterNames();
		// 파라미터 존재시에
		if(eNames.hasMoreElements()) {
			while(eNames.hasMoreElements()) {
				String name = (String) eNames.nextElement();
				String[] values = request.getParameterValues(name);

				if(values.length > 0) {
					String value = values[0];

					for(int i = 1; i < values.length; i++) {
						value += "," + values[i];
					}
					// rtnUrl 이 존재하면 리턴
					if("rtnUrl".equals(name)) {
						model.addAttribute("rtnUrl", value);
					} else {
						// UrlParam 파라미터가 존재하면 그대로 리턴
						if("urlParam".equals(name)) {
							urlParam = value;
						}
						// 나머지 파라미터에 대해 A=1&B=2 형식으로 조립해서 리턴
						else{
							if("".equals(urlParam)) {
								urlParam += name + "=";

								if(StringUtils.isNotEmpty(value)) {
									urlParam += value;
								}
							} else {
								urlParam += "&" + name + "=";
								if(StringUtils.isNotEmpty(value)) {
									urlParam += value;
								}
							}
						}
					}
				}
			}
		}
		//로그인 실패시 실패 메시지를 넘겨준다.
    	String check = request.getParameter("cmmLoginCheck") == null ? "" : request.getParameter("cmmLoginCheck");

    	if("1".equals(check)) {
			model.addAttribute(model.addAttribute("failLogin","등록되지 않은 아이디 또는 패스워드가 틀렸습니다."));
		} else if("2".equals(check)) {
			model.addAttribute(model.addAttribute("failLogin", egovMessageSource.getMessage("fail.common.logindel")));
		} else {
			model.addAttribute("failLogin","");
		}
    	if(StringUtils.isEmpty(loginVO.getMode())) {
    		loginVO.setMode("");
    	}
    	//log.info(">>>>>"+loginVO.getMode()+"<<<<");

    	model.addAttribute("urlParam", urlParam);
    	model.addAttribute("mode", loginVO.getMode());

    	Map<String, ?> snsMap = RequestContextUtils.getInputFlashMap(request);

    	if(snsMap != null) {
            model.addAttribute("snsMap", snsMap.get("snsInfo"));
        }
    	return "/mw/member/login";
    }

    @RequestMapping("/mw/actionLogin.do")
	public String actionLogin(@ModelAttribute("loginVO") USERVO loginVO,
							  HttpServletRequest request,
							  ModelMap model) throws Exception{
//		log.info("/mw/actionLogin.do 호출");

		// 중복 요청 방지 2024.11.13 chaewan.jung
		HttpSession session = request.getSession();
		String lastToken = (String) session.getAttribute("lastLoginToken");
		if (lastToken == null) {
			String newToken = UUID.randomUUID().toString();
			session.setAttribute("lastLoginToken", newToken);
		} else {
			return "redirect:/mw";
		}

//		String protocolUrl = EgovProperties.getProperty("HOST.CHANNEL_HTTP") + request.getServerName() + EgovProperties.getProperty("HOST.PORT_HTTP") + request.getContextPath();
		String protocolUrl = "";
		// 리턴 URL
		String rtnUrl = request.getParameter("rtnUrl");
		model.addAttribute("mode",loginVO.getMode());

		if(EgovStringUtil.isEmpty(loginVO.getEmail())) {
			model.addAttribute("rtnUrl",rtnUrl);
    		model.addAttribute("failLogin","이메일을 입력하세요.");
    		model.addAttribute("urlParam","");

    		return "/mw/member/login";
		}
		if(EgovStringUtil.isEmpty(loginVO.getPwd())){
			model.addAttribute("rtnUrl",rtnUrl);
			model.addAttribute("failLogin","비밀번호를 입력하세요.");
			model.addAttribute("urlParam","");

			return "/mw/member/login";
		}
		// 리턴URL 의 파라미터(&amp;amp > & 로 변환)
		String urlParam = EgovStringUtil.getHtmlStrCnvr(request.getParameter("urlParam"));
		// 실질적으로 리턴할 파라미터 선언
		String rtnParameter = "";
		// & 로 split
		String[] urlParam_s = urlParam.split("\\&");

		// 파라미터가 존재하는 만큼 for
		for(int i = 0; i < urlParam_s.length; i++) {
			// 첫번째 파라미터가 아니면 '&' 붙여줌
			if(i > 0) {
				rtnParameter += "&";
			}
			// '=' 으로 split
			String[] s_param = urlParam_s[i].split("\\=");
			// 첫번째 파라미터명을 리턴 파라미터에 추가
			rtnParameter += s_param[0];
			// 파라미터가 존재할경우 '=' 붙여줌
			if(StringUtils.isNotEmpty(s_param[0])) {
				rtnParameter += "=";
			}
			// 파라미터 매핑된 값을 리턴 파라미터에 추가(split 한 값이 없는경우 에러, 따라서 length 가 2인경우에 한에 추가)
			for(int j = 0; j < s_param.length; j++) {
				if(j == 1) {
					// encoding
					rtnParameter += URLEncoder.encode(s_param[j], "UTF-8");
//					rtnParameter += s_param[j];
				}
			}
		}
		// 접속 IP
    	String userIp = EgovClntInfo.getClntIP(request);
    	loginVO.setLastLoginIp(userIp);
    	// 1. 일반 로그인 처리
    	USERVO resultVO = ossUserService.actionWebLogin(loginVO);

    	if(resultVO != null && StringUtils.isNotEmpty(resultVO.getUserId())) {
//        	log.info("resultVO 존재");
        	// 탈퇴사용자
        	if("Y".equals(resultVO.getQutYn())) {
        		return "redirect:" + protocolUrl + "/mw/viewLogin.do?check=2&rtnUrl=" + rtnUrl + "&" + rtnParameter;
        	} else {
        		request.getSession().setAttribute("guestLoginVO", null);//게스트 로그인 날리기
	        	request.getSession().setAttribute("loginVO", resultVO);

	        	//로그 남기기
	        	LOGINLOGVO loginLogVO = new LOGINLOGVO();
	        	loginLogVO.setId( resultVO.getUserId() );
	        	loginLogVO.setPcYn("N");
	        	loginLogVO.setIp(userIp);
	        	loginLogVO.setTelnum(resultVO.getTelNum());

	        	ossUserService.insertLoginLog(loginLogVO);

	        	String strClientType = ossCmmService.getClientType(request);

	        	if("AA".equals(strClientType) || "IA".equals(strClientType)) {
	        		//앱으로 들어온 경우
	        		//log.info("-------/mw/actionLogin.do--App Login :" + strClientType );

	        		USER_CPVO cpVO = new USER_CPVO();
	        		cpVO.setUserId(resultVO.getUserId());

	        		int nCpAppFL = webUserCpService.getCntCpAppFirstLogin(cpVO);
	        		//log.info("-------/mw/actionLogin.do--App Login :" + nCpAppFL );

	        		//쿠폰이 발행 안되었으면
	        		if(nCpAppFL == 0) {
	        			//쿠폰 발행
	        			//log.info("-------/mw/actionLogin.do--App Login : Send CP" );
	        			webUserCpService.appFirstLoginPublish(resultVO.getUserId());
	        		}
	        		// 앱에서 로그인 유지를 위해 파라미터(app_id_add) 추가 (2017-06-08, by JDongS)
	        		if(StringUtils.isNotEmpty(rtnParameter)) {
	        			rtnParameter += "&";
	        		}
	        		// 이메일 암호화
	        		AES256 aes256 = new AES256("tamnao_app_!@#$%_key");
	        		String email = aes256.encrypt(loginVO.getEmail());
	        		rtnParameter += "app_id_add=" + email.replace("+", "@");
	        	//log.info("값 확인 :: " + strClientType + " ==> " + loginVO.getEmail() + ", name => " + email);
	        	}
//	        	log.info("-------/mw/actionLogin.do--App Login :" + strClientType + " => " + rtnParameter );
	        	// 장바구니 DB 동기화
        		webCartService.syncCart(request);

	        	if(StringUtils.isEmpty(rtnUrl)) {
	        		return "redirect:" + protocolUrl + "/mw/main.do";
	        	}
	        	// 파라미터가 존재하지 않으면 그냥 url 만 리턴
	        	if(StringUtils.isNotEmpty(rtnParameter)) {
	        		return "redirect:" + protocolUrl + rtnUrl + "?" + rtnParameter;
	        	} else {
	        		return "redirect:" + protocolUrl + rtnUrl;
	        	}
        	}
    	}else{
    		model.addAttribute("rtnUrl", rtnUrl);
    		model.addAttribute("failLogin","등록되지 않은 아이디 또는 패스워드가 틀렸습니다.");
    		model.addAttribute("urlParam", urlParam);

    		return "/mw/member/login";
    		// 로그인 실패시 이전 화면 url, 파라미터를 화면에 리턴
    		//log.info(rtnUrl);
//    		return "redirect:" + protocolUrl + "/viewLogin.do?check=1&rtnUrl=" + rtnUrl + "&" + rtnParameter;
    	}
	}
    
    /**
     * SNS 로그인
     * 파일명 : actionSnsLogin
     * 작성일 : 2018. 10. 1. 오후 12:01:33
     * 작성자 : 최영철
     * @param loginVO
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mw/actionSnsLogin.do")
    public String actionSnsLogin(@ModelAttribute("loginVO") USERVO loginVO,
								 HttpServletRequest request,
								 ModelMap model) throws Exception {

		// 중복 요청 방지 2024.11.13 chaewan.jung
		HttpSession session = request.getSession();
		String lastToken = (String) session.getAttribute("lastLoginToken");

		if (lastToken == null) {
			String newToken = UUID.randomUUID().toString();
			session.setAttribute("lastLoginToken", newToken);
		} else {
			return "redirect:/mw";
		}

		String rtnUrl = request.getParameter("rtnUrl");
        String urlParam = request.getParameter("urlParam");

        String protocolUrl = "";
        String rtnParameter = "";
		// & 로 split
		String[] urlParam_s = urlParam.split("\\&");
		// 파라미터가 존재하는 만큼 for
		for(int i = 0; i < urlParam_s.length; i++) {
			// 첫번째 파라미터가 아니면 '&' 붙여줌
			if(i > 0) {
				rtnParameter += "&";
			}
			// '=' 으로 split
			String[] s_param = urlParam_s[i].split("\\=");

			// 첫번째 파라미터명을 리턴 파라미터에 추가
			rtnParameter += s_param[0];
			// 파라미터가 존재할경우 '=' 붙여줌
			if(StringUtils.isNotEmpty(s_param[0])) {
				rtnParameter += "=";
			}
			// 파라미터 매핑된 값을 리턴 파라미터에 추가(split 한 값이 없는경우 에러, 따라서 length 가 2인경우에 한에 추가)
			for(int j = 0;j < s_param.length; j++) {
				if(j == 1) {
					// encoding
					rtnParameter += URLEncoder.encode(s_param[j], "UTF-8");
//							rtnParameter += s_param[j];
				}
			}
		}
		// 접속 IP
    	String userIp = EgovClntInfo.getClntIP(request);
    	loginVO.setLastLoginIp(userIp);

    	USERVO resultVO = webUserSnsService.actionSnsLogin(loginVO);
    	
    	if(resultVO != null && StringUtils.isNotEmpty(resultVO.getUserId())) {
        	// 탈퇴사용자
        	if("Y".equals(resultVO.getQutYn())) {
        		return "redirect:" + protocolUrl + "/mw/viewLogin.do?check=2&rtnUrl=" + rtnUrl + "&" + rtnParameter;
        	} else {
        		request.getSession().setAttribute("guestLoginVO", null);//게스트 로그인 날리기
	        	request.getSession().setAttribute("loginVO", resultVO);

	        	//로그 남기기
	        	LOGINLOGVO loginLogVO = new LOGINLOGVO();
	        	loginLogVO.setId( resultVO.getUserId() );
	        	loginLogVO.setPcYn("Y");
	        	loginLogVO.setIp(userIp);
	        	loginLogVO.setTelnum(resultVO.getTelNum());

	        	ossUserService.insertLoginLog(loginLogVO);

	        	if("Y".equals(resultVO.getRestYn())) {	// 휴면 계정
	        		return "redirect:" + protocolUrl + "/mw/restSign.do";
	        	} else {
	        		// 10개월 재방문 쿠폰 발행.
	        		/*if(ossUserService.selectChkVisit10Month(resultVO) > 0) {
	        			webUserCpService.vimoCpPublish(resultVO.getUserId());
	        		}*/
	        		// 장바구니 DB 동기화
	        		webCartService.syncCart(request);
	        		
		        	if(StringUtils.isEmpty(rtnUrl) || "//index.jsp".equals(rtnUrl)) {
		        		return "redirect:" + protocolUrl + "/mw/main.do";
		        	}
		        	// 파라미터가 존재하지 않으면 그냥 url 만 리턴
		        	if(StringUtils.isNotEmpty(rtnParameter)) {
		        		return "redirect:" + protocolUrl + rtnUrl + "?" + rtnParameter;
		        	} else {
		        		return "redirect:" + protocolUrl + rtnUrl;
		        	}
	        	}
        	}
    	} else {
    		model.addAttribute("rtnUrl", rtnUrl);
            model.addAttribute("failLogin","간편로그인 연동 정보가 없습니다.");
    		model.addAttribute("urlParam", urlParam);

    		if(StringUtils.isEmpty(loginVO.getMode())) {
        		loginVO.setMode("");
        	}
    		model.addAttribute("mode",loginVO.getMode());
    		
    		return "/mw/member/login";
    	}
    }

    @RequestMapping("/mw/actionReLogin.ajax")
	public ModelAndView actionReLogin(@ModelAttribute("loginVO") USERVO loginVO,
									  HttpServletRequest request,
									  ModelMap model) throws Exception{
		log.info("/mw/actionReLogin.ajax 호출");

		Map<String, Object> resultMap = new HashMap<String, Object>();

		model.addAttribute("mode", "user");

		if(EgovStringUtil.isEmpty(loginVO.getEmail())){
			resultMap.put("loginMode", "N");
			resultMap.put("loginMsg", "이메일 정보가 없습니다.");
			ModelAndView mav = new ModelAndView("jsonView", resultMap);

			return mav;
		}

		String strClientType = ossCmmService.getClientType(request);
		//log.info("값 확인1 :: " + strClientType + " ==> " + loginVO.getEmail() + ", name => " + loginVO.getsUserNm());
    	if("AA".equals(strClientType) || "IA".equals(strClientType)){ //앱으로 들어온 경우
			// 접속 IP
	    	String userIp = EgovClntInfo.getClntIP(request);
	    	loginVO.setLastLoginIp(userIp);

	    	// 이메일 복호화
    		AES256 aes256 = new AES256("tamnao_app_!@#$%_key");
    		String emailStr = aes256.decrypt(loginVO.getEmail().replace("@", "+"));
    		loginVO.setEmail(emailStr);
	    	// 1. 앱 재 로그인 처리
	    	USERVO resultVO = ossUserService.actionMwReLogin(loginVO);

	    	if (resultVO != null && StringUtils.isNotEmpty(resultVO.getUserId())) {
	        	log.info("resultVO 존재");

	        	// 탈퇴사용자
	        	if("Y".equals(resultVO.getQutYn())){
	        		resultMap.put("loginMode", "N");
	        		resultMap.put("loginMsg", "탈퇴 사용자 입니다.");
	        	}else{
	        		request.getSession().setAttribute("guestLoginVO", null);//게스트 로그인 날리기
		        	request.getSession().setAttribute("loginVO", resultVO);

	        		//log.info("-------/mw/actionLogin.do--App Login :" + resultVO.getUserId() );

	        		/*USER_CPVO cpVO = new USER_CPVO();
	        		cpVO.setUserId(resultVO.getUserId());
	        		int nCpAppFL = webUserCpService.getCntCpAppFirstLogin(cpVO);*/

	        		resultMap.put("loginMode", "Y");
	        		resultMap.put("loginMsg", "");
	        	}
	    	}else{
	    		resultMap.put("loginMode", "N");
	    		resultMap.put("loginMsg", "등록되지 않은 아이디 또는 패스워드가 틀렸습니다.");
	    	}
    	}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

    @RequestMapping("/mw/viewFindIdPwd.do")
   	public String viewFindIdPwd(HttpServletRequest request,
								   ModelMap model) {
    	String showTab = request.getParameter("showTab");

    	if(StringUtils.isEmpty(showTab)) {
    		showTab = "1";
    	}
    	model.addAttribute("showTab", showTab);

   		return "mw/member/findIdPwd";
   	}

    @RequestMapping("/mw/findId.do")
   	public String findId(@ModelAttribute("USERSVO") USERSVO userSVO,
							ModelMap model) {
   		List<USERVO> userVOList = ossUserService.selectAuthUser(userSVO);

   		model.addAttribute("userVOList", userVOList);

   		return "mw/member/findId";
   	}

    @RequestMapping("/mw/findPwd.do")
   	public String findPw(@ModelAttribute("USERSVO") USERSVO userSVO,
							ModelMap model) {
   		List<USERVO> userVOList = ossUserService.selectAuthUser(userSVO);

   		model.addAttribute("userVO", userVOList.get(0));

   		return "mw/member/findPwd";
   	}

    @RequestMapping("/mw/guestPay01.do")
    public String guestPay01(@ModelAttribute("USERVO") USERVO userVO){
    	return "/mw/member/guestPay01";
    }

	//기존 가입자의 간편 가입 연동
	@RequestMapping("/mw/insertUserSns.do")
	public String insertUserSns(@ModelAttribute("USERVO") USERVO user,
                                HttpServletRequest request) throws Exception {

		webUserSnsService.insertUserSns(user);

        String userIp = EgovClntInfo.getClntIP(request);
        user.setLastLoginIp(userIp);

        USERVO resultVO = webUserSnsService.actionSnsLogin(user);
        request.getSession().setAttribute("loginVO", resultVO);

		return "redirect:/mw/main.do";
	}

}
