package web.cs.web;


import api.service.APIAligoService;
import api.vo.APIAligoVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.cmmn.service.SmsService;
import egovframework.cmmn.vo.KMAGRIBVO;
import egovframework.cmmn.vo.KMAMLWVO;
import egovframework.cmmn.vo.SMSVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.AD_ADDAMTVO;
import mas.ad.vo.AD_PRDTINFVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.sp.service.MasSpService;
import mas.sp.vo.SP_ADDOPTINFVO;
import mas.sv.service.MasSvService;
import mas.sv.vo.SV_ADDOPTINFVO;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;
import oss.ad.vo.AD_WEBDTLSVO;
import oss.ad.vo.AD_WEBDTLVO;
import oss.ad.vo.AD_WEBLIST2VO;
import oss.ad.vo.AD_WEBLISTSVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssMailService;
import oss.cmm.vo.CM_IMGVO;
import oss.cmm.web.SHA256;
import oss.marketing.serive.OssBestprdtService;
import oss.marketing.vo.BESTPRDTSVO;
import oss.marketing.vo.BESTPRDTVO;
import oss.user.service.OssUserService;
import oss.user.vo.LOGINLOGVO;
import oss.user.vo.USERSVO;
import oss.user.vo.USERVO;
import web.cs.service.WebKmaService;
import web.cs.service.WebUserSnsService;
import web.main.service.WebMainService;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.RSV_HISSVO;
import web.order.service.WebCartService;
import web.order.service.WebOrderService;
import web.order.vo.RSVVO;
import web.product.service.*;
import web.product.vo.CARTVO;
import web.product.vo.WEB_DTLPRDTVO;
import web.product.vo.WEB_SV_DTLPRDTVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
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
public class WebCsController {

    /*@Autowired
    private DefaultBeanValidator beanValidator;*/

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

	@Resource(name="smsService")
	protected SmsService smsService;

	@Resource(name = "ossMailService")
	protected OssMailService ossMailService;

	@Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	@Resource(name="webOrderService")
	private WebOrderService webOrderService;

	@Resource(name = "masSpService")
	private MasSpService masSpService;

	@Resource(name = "webSvService")
	private WebSvProductService webSvService;

	@Resource(name = "masSvService")
	private MasSvService masSvService;

	@Resource(name = "webKmaService")
	private WebKmaService webKmaService;
	
	@Resource(name="ossBestprdtService")
	private OssBestprdtService ossBestprdtService;

	@Resource(name = "webCartService")
	private WebCartService webCartService;
	
	@Resource(name = "webUserSnsService")
	private WebUserSnsService webUserSnsService;

	@Autowired
	private APIAligoService apiAligoService;
	
	/*@Resource(name="allimService")
	protected AllimService allimService;*/

    Logger log = LogManager.getLogger(this.getClass());


    // 회원가입
	@RequestMapping("/web/signUp00.do")
	public String signUp00(@ModelAttribute("USERVO") USERVO userVO,
						   HttpServletRequest request,
						   ModelMap model) {

		Map<String, ?> snsMap = RequestContextUtils.getInputFlashMap(request);

		if(snsMap != null) {
			model.addAttribute("snsMap", snsMap.get("snsInfo"));
		}
		return "/web/cs/signUp00";
	}

	/**
     * 회원가입 Step1. 휴대폰인증
     * 파일명 : signUp01
     * 작성일 : 2015. 10. 28. 오후 1:31:30
     * 작성자 : 최영철
     * @param userVO
     * @return
     */
    @RequestMapping("/web/signUp01.do")
    public String signUp01(@ModelAttribute("USERVO") USERVO userVO){

    	return "/web/cs/signUp01";
    }

    /**
     * 인증번호 받기
     * 파일명 : getAuthNum
     * 작성일 : 2015. 12. 21. 오후 4:17:07
     * 작성자 : 최영철
     * @param params
     * @param request
     * @return
     */
    @RequestMapping("/web/getAuthNum.ajax")
    public ModelAndView getAuthNum(@RequestParam Map<String, String> params,
								   	HttpServletRequest request) {

        String telNum = params.get("telNum");
        String snsDiv = params.get("snsDiv");

    	USERSVO userSVO = new USERSVO();
    	userSVO.setsTelNum(telNum);

    	List<USERVO> userListVO = ossUserService.selectByUserTelNum(userSVO);

        Map<String, Object> resultMap = new HashMap<String, Object>();

        if(userListVO.size() > 0) {
            if(snsDiv == null || "".equals(snsDiv)) {
                resultMap.put("success", "N");
                resultMap.put("failMsg", "이미 등록된 핸드폰번호입니다.");

                ModelAndView mav = new ModelAndView("jsonView", resultMap);

                return mav;
            } else {
                resultMap.put("userId", userListVO.get(0).getUserId());
            }
        }
        String nansu = smsService.nanSuInt(6);

		//알림톡 보내기
		apiAligoService.authCodeSend(telNum, nansu);
		
//		10001 인증번호 확인
		/*Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("param1", nansu);
		paramMap.put("telNum", params.get("telNum"));
		paramMap.put("callBackNo", EgovProperties.getProperty("CS.PHONE"));

		allimService.sendTemplet10001(paramMap);*/
		
//		 10003 발송완료(특산품)
		/*Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("param1", "헤보니 마유 바디워시");
		paramMap.put("param2", "CJ대한통운");
		paramMap.put("param3", "617795074394");
		paramMap.put("telNum", params.get("telNum"));
		paramMap.put("callBackNo", EgovProperties.getProperty("CS.PHONE"));

		allimService.sendTemplet10003(paramMap);*/

		request.getSession().setAttribute(params.get("telNum"), nansu);

		resultMap.put("success", "Y");

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }

    /**
     * 회원가입 인증번호 체크
     * 파일명 : checkAuthNum
     * 작성일 : 2015. 12. 21. 오후 5:43:21
     * 작성자 : 최영철
     * @param params
     * @param request
     * @return
     */
    @RequestMapping("/web/checkAuthNum.ajax")
    public ModelAndView checkAuthNum(@RequestParam Map<String, String> params,
									 HttpServletRequest request) {

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	String authNum = (String) request.getSession().getAttribute(params.get("telNum"));

    	if(params.get("authNum") == null || "".equals(params.get("authNum"))) {
    		resultMap.put("success", "N");
    		resultMap.put("failMsg", "인증번호를 입력해주세요.");
    	} else {
    		if(authNum == null || "".equals(authNum)) {
    			resultMap.put("success", "N");
        		resultMap.put("failMsg", "인증번호 전송을 다시해주세요.");
    		} else {
    			if(authNum.equals(params.get("authNum"))) {
    				resultMap.put("success", "Y");
    			} else {
    				resultMap.put("success", "N");
            		resultMap.put("failMsg", "인증번호가 틀렸습니다.");
    			}
    		}
    	}
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }

    /**
     * 회원가입 Step2. 약관동의
     * 파일명 : signUp02
     * 작성일 : 2015. 10. 28. 오후 1:31:47
     * 작성자 : 최영철
     * @param userVO
     * @return
     */
    @RequestMapping("/web/signUp02.do")
    public String signUp02(@ModelAttribute("USERVO") USERVO userVO){

    	return "/web/cs/signUp02";
    }

    /**
     * 회원가입 Step3. 정보등록
     * 파일명 : signUp03
     * 작성일 : 2015. 10. 28. 오후 1:32:01
     * 작성자 : 최영철
     * @param userVO
	 * @param model
     * @return
     */
    @RequestMapping("/web/signUp03.do")
	public String signUp03(@ModelAttribute("USERVO") USERVO userVO,
						   ModelMap model){

		model.addAttribute("user", userVO);

		return "/web/cs/signUp03";
	}

    /**
     * 사용자 회원가입
     * 파일명 : insertUser
     * 작성일 : 2015. 10. 28. 오후 1:32:17
     * 작성자 : 최영철
     * @param user
	 * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/web/insertUser.do")
    public String insertUser(@ModelAttribute("USERVO") USERVO user,
								HttpServletRequest request) throws Exception {

		String originPwd = user.getPwd();
        // 패스워드 암호화
        if(StringUtils.isEmpty(user.getSnsDiv())) {
			SHA256 sha256 = new SHA256();
			String pwd = sha256.getSHA256_pwd(originPwd);
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
		
		if(StringUtils.isNotEmpty(user.getSnsDiv())) {
			user.setUserId(userId);

			webUserSnsService.insertUserSns(user);

			// 로그인 처리
			USERVO resultVO = webUserSnsService.actionSnsLogin(user);
			request.getSession().setAttribute("loginVO", resultVO);
		} else {
			String userIp = EgovClntInfo.getClntIP(request);
			user.setLastLoginIp(userIp);

			// 로그인 처리
			/*user.setPwd(originPwd);*/
			USERVO resultVO = ossUserService.actionWebLogin(user);
			request.getSession().setAttribute("loginVO", resultVO);
		}
		// 쿠폰 발행.
		webUserCpService.epilCpPublish(userId);
		// 황금빛 제주 쿠폰 발행 처리
//		ossEventService.evntPublish(userId);
		// 메일 전송
		ossMailService.sendRegUser(user, user.getEmail(), request);

		return "redirect:/web/signUp04.do";
	}

    /**
     * 회원가입 Step4. 회원가입완료
     * 파일명 : signUp04
     * 작성일 : 2015. 10. 28. 오후 1:32:28
     * 작성자 : 최영철
     * @return
     */
    @RequestMapping("/web/signUp04.do")
    public String signUp04(){

    	return "/web/cs/signUp04";
    }


    @RequestMapping("/web/viewLogin.do")
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

    	// 베스트 상품.
    	BESTPRDTSVO bestprdtSVO = new BESTPRDTSVO();

    	List<BESTPRDTVO> bestPrdtList = ossBestprdtService.selectBestprdtWebList(bestprdtSVO);

    	model.addAttribute("bestProductList", bestPrdtList);
    	
    	String urlParam = "";
		// 파라미터 묶음
		@SuppressWarnings("rawtypes")
		Enumeration eNames = request.getParameterNames();
		// 파라미터 존재시에
		if(eNames.hasMoreElements()) {
			while (eNames.hasMoreElements()) {
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
						} else {
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
			model.addAttribute(model.addAttribute("failLogin","등록되지 않은 아이디이거나 비밀번호가 틀렸습니다."));
		} else if("2".equals(check)) {
			model.addAttribute(model.addAttribute("failLogin", egovMessageSource.getMessage("fail.common.logindel")));
		} else {
			model.addAttribute("failLogin","");
		}

    	if(StringUtils.isEmpty(loginVO.getMode())) {
    		loginVO.setMode("");
    	} else {
    		String[] modeArr = loginVO.getMode().split(",");
    		if(modeArr.length > 1) {
				loginVO.setMode(modeArr[0]);
			}
    	}
    	model.addAttribute("urlParam", urlParam);
    	model.addAttribute("mode", loginVO.getMode());

        Map<String, ?> snsMap = RequestContextUtils.getInputFlashMap(request);

        if(snsMap != null) {
            model.addAttribute("snsMap", snsMap.get("snsInfo"));
        }
    	return "/web/cs/login";
    }
    
    /**
     * 휴면계정의 휴대폰 인증 페이지
     * Function : restSign
     * 작성일 : 2018. 3. 12. 오전 10:36:42
     * 작성자 : 정동수
     * @return
     */
    @RequestMapping("/web/restSign.do")
    public String restSign(ModelMap model){

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if(userVO != null){
			model.addAttribute("userNm", userVO.getUserNm());			
		} else {
			String protocolUrl = "";
			return "redirect:" + protocolUrl + "/web/viewLogin.do";
		}
    	return "/web/cs/restSign";
    }

    /**
     * 휴면계정의인증번호 받기
     * 파일명 : getRestAuthNum
     * 작성일 : 2018. 3. 12. 오전 10:36:42
     * 작성자 : 정동수
     * @param params
     * @param request
     * @return
     */
    @RequestMapping("/web/getRestAuthNum.ajax")
    public ModelAndView getRestAuthNum(@RequestParam Map<String,
										String> params,
									   	HttpServletRequest request) {

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	if(params.get("telNum") == null) {
    		resultMap.put("success", "N");
    		resultMap.put("failMsg", "핸드폰번호가 입력되지 않았습니다.");

    		ModelAndView mav = new ModelAndView("jsonView", resultMap);

    		return mav;
    	}
    	USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	USERSVO userSVO = new USERSVO();
    	userSVO.setsUserId(userVO.getUserId());
    	userSVO.setsTelNum(params.get("telNum"));

    	List<USERVO> userListVO = ossUserService.selectByUserTelNum(userSVO);

    	if(userListVO.size() == 0) {
    		resultMap.put("success", "N");
    		resultMap.put("failMsg", "휴면계정에 등록된 핸드폰번호가 아닙니다. 다시 확인해 주세요.");

    		ModelAndView mav = new ModelAndView("jsonView", resultMap);

    		return mav;
    	}

    	String nansu = smsService.nanSuInt(6);

		//알림톡 보내기
		apiAligoService.authCodeSend(params.get("telNum"), nansu);

		request.getSession().setAttribute(params.get("telNum"), nansu);

		resultMap.put("success", "Y");
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }

    /**
     * 휴면계정 해제 시 인증번호 체크
     * 파일명 : checkRestAuthNum
     * 작성일 : 2018. 3. 12. 오전 10:36:42
     * 작성자 : 정동수
     * @param params
     * @param request
     * @return
     */
    @RequestMapping("/web/checkRestAuthNum.ajax")
    public ModelAndView checkRestAuthNum(@RequestParam Map<String,
											String> params,
										 	HttpServletRequest request) {

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	String authNum = (String) request.getSession().getAttribute(params.get("telNum"));

    	if(params.get("authNum") == null || params.get("authNum") == "") {
    		resultMap.put("success", "N");
    		resultMap.put("failMsg", "인증번호를 입력해주세요.");
    	} else {
    		if(authNum == null || authNum == "") {
    			resultMap.put("success", "N");
        		resultMap.put("failMsg", "인증번호전송을 다시해주세요.");
    		} else {
    			if(authNum.equals(params.get("authNum"))) {
    			//	resultMap.put("success", "Y");
    				
    				// 휴면계정 해제 처리
    				USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

    				if(userVO != null){
	    				USERSVO userSVO = new USERSVO();
	    				userSVO.setsUserId(userVO.getUserId());
	    				ossUserService.updateRestUserCancel(userSVO);
	    				
	    				resultMap.put("success", "Y");
                		resultMap.put("failMsg", "휴면계정이 해제 되었습니다.");
    				} else {
    					resultMap.put("success", "N");
                		resultMap.put("failMsg", "로그인 정보가 없습니다.");
    				}
    			}else{
    				resultMap.put("success", "N");
            		resultMap.put("failMsg", "인증번호가 틀렸습니다.");
    			}
    		}
    	}

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }


    @RequestMapping("/web/actionLogin.do")
	public String actionLogin(@ModelAttribute("loginVO") USERVO loginVO,
					            HttpServletRequest request,
					            ModelMap model) throws Exception{
//		log.info("/actionLogin.do 호출");

		// 중복 요청 방지 2024.11.13 chaewan.jung
		HttpSession session = request.getSession();
		String lastToken = (String) session.getAttribute("lastLoginToken");
		if (lastToken == null) {
			String newToken = UUID.randomUUID().toString();
			session.setAttribute("lastLoginToken", newToken);
		} else {
			return "redirect:/";
		}
		
		
		// 베스트 상품.
    	/*Random rd = new Random();
    	boolean b_rd = rd.nextBoolean();

    	if(b_rd) {
    		List<RC_PRDTINFVO> bestPrdtList = webRcProductService.selectRcBestPrdtList();
//        	List<AD_WEBLIST2VO> resultBestList = webAdProductService.selectBestAdList(prdtSVO);
        	model.addAttribute("bestProductList", bestPrdtList);
        	model.addAttribute("bestDiv", Constant.RENTCAR);
    	} else {
    		AD_WEBLISTSVO adPrdtSVO = new AD_WEBLISTSVO();
    		//베스트 상품
        	List<AD_WEBLIST2VO> bestList = webAdProductService.selectBestAdList(adPrdtSVO);
        	model.addAttribute("bestProductList", bestList);
        	model.addAttribute("bestDiv", Constant.ACCOMMODATION);
    	}*/

//		String protocolUrl = EgovProperties.getProperty("HOST.CHANNEL_HTTP") + request.getServerName() + EgovProperties.getProperty("HOST.PORT_HTTP") + request.getContextPath();
		String protocolUrl = "";
		// 리턴 URL
		String rtnUrl = request.getParameter("rtnUrl");

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
			if(s_param[0] != null && !s_param[0].isEmpty()) {
				rtnParameter += "=";
			}

			// 파라미터 매핑된 값을 리턴 파라미터에 추가(split 한 값이 없는경우 에러, 따라서 length 가 2인경우에 한에 추가)
			for(int j = 0; j < s_param.length; j++) {
				if(j == 1) {
					// encoding
					rtnParameter += URLEncoder.encode(s_param[j], "UTF-8");
					// rtnParameter += s_param[j];
				}
			}
		}
		// 접속 IP
    	String userIp = EgovClntInfo.getClntIP(request);
    	loginVO.setLastLoginIp(userIp);

//		System.out.println("프로토콜"+protocolUrl);
    	
    	// 1. 일반 로그인 처리
    	USERVO resultVO = ossUserService.actionWebLogin(loginVO);

    	if(resultVO != null && StringUtils.isNotEmpty(resultVO.getUserId())) {
//        	log.info("resultVO 존재");

        	// 탈퇴사용자
        	if("Y".equals(resultVO.getQutYn())) {
        		return "redirect:" + protocolUrl + "/viewLogin.do?check=2&rtnUrl=" + rtnUrl + "&" + rtnParameter;
        	} else {
        		request.getSession().setAttribute("guestLoginVO", null);		//게스트 로그인 날리기
	        	request.getSession().setAttribute("loginVO", resultVO);

	        	//로그 남기기
	        	LOGINLOGVO loginLogVO = new LOGINLOGVO();
	        	loginLogVO.setId(resultVO.getUserId());
	        	loginLogVO.setPcYn("Y");
	        	loginLogVO.setIp(userIp);
	        	loginLogVO.setTelnum(resultVO.getTelNum());

	        	ossUserService.insertLoginLog(loginLogVO);

	        	if("Y".equals(resultVO.getRestYn())) {	// 휴면 계정
	        		return "redirect:" + protocolUrl + "/web/restSign.do";
	        	} else {
	        		// 10개월 재방문 쿠폰 발행.
	        		/*if(ossUserService.selectChkVisit10Month(resultVO) > 0) {
	        			webUserCpService.vimoCpPublish(resultVO.getUserId());
	        		}*/
	        		// 장바구니 DB 동기화
	        		webCartService.syncCart(request);
	        		
		        	if(rtnUrl == null || rtnUrl.isEmpty() || "//index.jsp".equals(rtnUrl)) {
		        		return "redirect:" + protocolUrl + "/main.do";
		        	}
		        	// 파라미터가 존재하지 않으면 그냥 url 만 리턴
		        	if(rtnParameter != null && !rtnParameter.isEmpty()) {
		        		return "redirect:" + protocolUrl + rtnUrl + "?" + rtnParameter;
		        	} else {
		        		return "redirect:" + protocolUrl + rtnUrl;
		        	}
	        	}
        	}
    	} else {
    		model.addAttribute("rtnUrl", rtnUrl);
    		model.addAttribute("failLogin","등록되지 않은 아이디이거나 비밀번호가 틀렸습니다.");
    		model.addAttribute("urlParam", urlParam);

    		if(loginVO.getMode() == null || loginVO.getMode().isEmpty()) {
        		loginVO.setMode("");
        	}
    		model.addAttribute("mode", loginVO.getMode());
    		
    		// 베스트 상품.
        	/*BESTPRDTSVO bestprdtSVO = new BESTPRDTSVO();
        	List<BESTPRDTVO> bestPrdtList = ossBestprdtService.selectBestprdtWebList(bestprdtSVO);
        	model.addAttribute("bestProductList", bestPrdtList);*/

    		return "/web/cs/login";

    		// 로그인 실패시 이전 화면 url, 파라미터를 화면에 리턴
    		//log.info(rtnUrl);
//    		return "redirect:" + protocolUrl + "/viewLogin.do?check=1&rtnUrl=" + rtnUrl + "&" + rtnParameter;
    	}
	}

    /**
     * 장바구니
     * 파일명 : cart
     * 작성일 : 2015. 11. 4. 오전 9:59:34
     * 작성자 : 최영철
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/web/cart.do")
    public String cart(HttpServletRequest request,
			    		ModelMap model){
		log.info("/web/cart.do call");
    	List<CARTVO> cartList = new ArrayList<CARTVO>();

    	if(request.getSession().getAttribute("cartList") != null) {
    		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
		}
		for(int i = 0; i <cartList.size(); i++) {
			CARTVO cart = cartList.get(i);

			String category = cart.getPrdtNum().substring(0, 2).toUpperCase();

			if(Constant.RENTCAR.equals(category)) {
				RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
//				BeanUtils.copyProperties(cart, prdtSVO);
				prdtSVO.setFirstIndex(0);
				prdtSVO.setLastIndex(1);
				prdtSVO.setsFromDt(cart.getFromDt());
				prdtSVO.setsToDt(cart.getToDt());
				prdtSVO.setsFromTm(cart.getFromTm());
				prdtSVO.setsToTm(cart.getToTm());
				prdtSVO.setsPrdtNum(cart.getPrdtNum());
				prdtSVO.setsInfo("Y");
				RC_PRDTINFVO prdtInfo = webRcProductService.selectRcPrdt(prdtSVO);
		    	cart.setSaleAmt(prdtInfo.getSaleAmt());
		    	cart.setTotalAmt(String.valueOf(Integer.valueOf(prdtInfo.getSaleAmt()) + Integer.valueOf(cart.getAddAmt())));
		    	cart.setCtgr("RC");

			} else if(Constant.ACCOMMODATION.equals(category)) {

				int nPrice = webAdProductService.getTotalPrice(cart.getPrdtNum(), cart.getStartDt(), cart.getNight(), cart.getAdultCnt(), cart.getJuniorCnt(), cart.getChildCnt());

		    	cart.setSaleAmt("" + nPrice);
		    	cart.setTotalAmt("" + nPrice);
		    	cart.setCtgr("AD");

			} else if(Constant.SOCIAL.equals(category)) {

				WEB_DTLPRDTVO searchVO = new WEB_DTLPRDTVO();

				searchVO.setPrdtNum(cart.getPrdtNum());
				searchVO.setSpDivSn(cart.getSpDivSn());
				searchVO.setSpOptSn(cart.getSpOptSn());

				WEB_DTLPRDTVO spProduct = webSpService.selectByCartPrdt(searchVO);

				int addOptAmt;

				if(spProduct == null) {
					log.info("spProduct null");
					// 품절이 되거나 판매기간이 끝난경우. 세션에서 지운다.
					cartList.remove(i);

				} else {
					cart.setPrdtNm(spProduct.getPrdtNm());
					cart.setSaleAmt(spProduct.getSaleAmt());
					cart.setPrdtDivNm(spProduct.getPrdtDivNm());
					cart.setOptNm(spProduct.getOptNm());
					cart.setCtgrNm(spProduct.getCtgrNm());
					cart.setNmlAmt(spProduct.getNmlAmt());
					cart.setAplDt(spProduct.getAplDt());
					cart.setCorpId(spProduct.getCorpId());
					if(spProduct.getSaveFileNm() != null) {
						cart.setImgPath(spProduct.getSavePath() + "thumb/" + spProduct.getSaveFileNm());
					} else {
						cart.setImgPath(spProduct.getApiImgThumb());
					}
					
					if(StringUtils.isNotEmpty(cart.getAddOptAmt())) {
						addOptAmt = Integer.valueOf(cart.getAddOptAmt());
					} else {
						addOptAmt = 0;
					}
					cart.setTotalAmt(String.valueOf(Integer.valueOf(cart.getQty()) * (Integer.valueOf(spProduct.getSaleAmt()) + addOptAmt)));
					cart.setCtgr(spProduct.getCtgr());

					cartList.set(i, cart);
				}
			} else if(Constant.SV.equals(category)) {

				WEB_SV_DTLPRDTVO searchVO = new WEB_SV_DTLPRDTVO();

				searchVO.setPrdtNum(cart.getPrdtNum());
				searchVO.setSvDivSn(cart.getSvDivSn());
				searchVO.setSvOptSn(cart.getSvOptSn());

				WEB_SV_DTLPRDTVO svProduct = webSvService.selectByCartPrdt(searchVO);

				int addOptAmt;

				if(svProduct == null) {
					log.info("svProduct null");
					// 품절이 되거나 판매기간이 끝난경우. 세션에서 지운다.
					cartList.remove(i);
				} else {
					cart.setPrdtNm(svProduct.getPrdtNm());
					cart.setSaleAmt(svProduct.getSaleAmt());
					cart.setPrdtDivNm(svProduct.getPrdtDivNm());
					cart.setOptNm(svProduct.getOptNm());
					cart.setCtgrNm(svProduct.getCtgrNm());
					cart.setNmlAmt(svProduct.getNmlAmt());
					cart.setCorpId(svProduct.getCorpId());
					cart.setDlvAmtDiv(svProduct.getDlvAmtDiv());
					cart.setMaxiBuyNum(svProduct.getMaxiBuyNum());
					cart.setPrdc(svProduct.getPrdc());

					/*
						개별 배송비 로직 추가 2021.05.21 chaewan.jung
						개당 배송비 기준으로 변경 => ceil(구매수량/개별배송수량)
						ex) 3개당 4,000원  4개 구매시 8,000원
					 */
					if (svProduct.getDlvAmtDiv().equals(Constant.DLV_AMT_DIV_MAXI)){
						int DlvCnt =  (int) Math.ceil(Double.valueOf(cart.getQty()) / Double.valueOf(svProduct.getMaxiBuyNum()));
						cart.setDlvAmt(String.valueOf(Integer.valueOf(svProduct.getDlvAmt()) * DlvCnt));
						cart.setOutDlvAmt(String.valueOf(Integer.valueOf(svProduct.getDlvAmt()) * DlvCnt));
						cart.setInDlvAmt(String.valueOf(Integer.valueOf(svProduct.getDlvAmt()) * DlvCnt));
					}else {
						cart.setDlvAmt(svProduct.getDlvAmt());
						cart.setOutDlvAmt(svProduct.getDlvAmt());
						cart.setInDlvAmt(svProduct.getInDlvAmt());
					}

					cart.setAplAmt(svProduct.getAplAmt());
					if(StringUtils.isNotEmpty(cart.getAddOptAmt())) {
						addOptAmt = Integer.valueOf(cart.getAddOptAmt());
					} else {
						addOptAmt = 0;
					}
					cart.setTotalAmt(String.valueOf(Integer.valueOf(cart.getQty()) * (Integer.valueOf(svProduct.getSaleAmt()) + addOptAmt)));
					cart.setCtgr("SV");

					cartList.set(i, cart);
				}
			}
		}
		// 장바구니 정렬(corpId-prdc-dlvAmtDiv-directRecvYn)
		// 생산자별 묶음배송을 위해 prdc 정렬 추가 2021.06.03 chaewan.jung
    	CartComparator cartCom = new CartComparator();
    	Collections.sort(cartList, cartCom);

    	model.addAttribute("cartList", cartList);
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

    	return "/web/cs/cart";
    }

    @SuppressWarnings("unchecked")
	@RequestMapping("/web/cartOptionLayer.ajax")
    public String cartOptionLay(@ModelAttribute("cartSn") CARTVO cartVO,
								HttpServletRequest request,
								ModelMap model){

    	List<CARTVO> cartList = new ArrayList<CARTVO>();

    	if(request.getSession().getAttribute("cartList") != null) {
    		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
		}
    	for(CARTVO cart:cartList) {
			if(cartVO.getCartSn() == cart.getCartSn()) {
				String category = cart.getPrdtNum().substring(0, 2).toUpperCase();

				if(Constant.RENTCAR.equals(category)) {
					RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
//					BeanUtils.copyProperties(cart, prdtSVO);
					prdtSVO.setFirstIndex(0);
					prdtSVO.setLastIndex(1);
					prdtSVO.setsFromDt(cart.getFromDt());
					prdtSVO.setsToDt(cart.getToDt());
					prdtSVO.setsFromTm(cart.getFromTm());
					prdtSVO.setsToTm(cart.getToTm());
					prdtSVO.setsPrdtNum(cart.getPrdtNum());

					// 단건에 대한 렌터카 정보 조회
			    	List<RC_PRDTINFVO> resultList = webRcProductService.selectRcPrdtList2(prdtSVO);

			    	RC_PRDTINFVO prdtInfo = resultList.get(0);

			    	RC_PRDTINFVO prdtVO = new RC_PRDTINFVO();
			    	prdtVO.setPrdtNum(prdtSVO.getsPrdtNum());

			    	prdtVO = webRcProductService.selectByPrdt(prdtVO);

			    	prdtInfo.setIsrCmGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrCmGuide()));
			    	prdtInfo.setIsrAmtGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrAmtGuide()));

			    	model.addAttribute("prdtInfo", prdtInfo);
			    	model.addAttribute("cartInfo", cart);

			    	return "/web/cs/rcOptionLayer";

				} else if(Constant.SOCIAL.equals(category)) {

					WEB_DTLPRDTVO searchVO = new WEB_DTLPRDTVO();
					searchVO.setPrdtNum(cart.getPrdtNum());
					searchVO.setSpDivSn(cart.getSpDivSn());
					searchVO.setSpOptSn(cart.getSpOptSn());

					WEB_DTLPRDTVO prdtInfo = webSpService.selectByCartPrdt(searchVO);

					// 상품 추가 옵션 가져오기.
					SP_ADDOPTINFVO sp_ADDOPTINFVO = new SP_ADDOPTINFVO();
					sp_ADDOPTINFVO.setPrdtNum(cart.getPrdtNum());

					List<SP_ADDOPTINFVO> addOptList = masSpService.selectPrdtAddOptionList(sp_ADDOPTINFVO);

					model.addAttribute("prdtInfo", prdtInfo);
			    	model.addAttribute("cartInfo", cart);
			    	model.addAttribute("cartList", cartList);
			    	model.addAttribute("addOptList", addOptList);

			    	return "/web/cs/spOptionLayer";

				} else if(Constant.ACCOMMODATION.equals(category)) {

					AD_WEBDTLSVO prdtSVO = new AD_WEBDTLSVO();
					prdtSVO.setsPrdtNum( cart.getPrdtNum() );
					prdtSVO.setsFromDt( cart.getStartDt() );
			    	prdtSVO.setsNights( cart.getNight() );

			    	AD_WEBDTLVO ad_WEBDTLVO = webAdProductService.selectWebdtlByPrdt(prdtSVO);

					model.addAttribute("webdtl", ad_WEBDTLVO);

					//객실 정보읽기
			    	AD_PRDTINFVO adPrdtVO = new AD_PRDTINFVO();
			    	adPrdtVO.setPrdtNum( cart.getPrdtNum() );

			    	AD_PRDTINFVO adPrdtRes = masAdPrdtService.selectByAdPrdinf(adPrdtVO);

			    	model.addAttribute("prdtVO", adPrdtRes);
			    	model.addAttribute("searchVO", prdtSVO);
			    	model.addAttribute("cart", cart);

			    	//객실 추가 요금 얻기
					AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
					ad_ADDAMTVO.setAplStartDt(prdtSVO.getsFromDt());
					ad_ADDAMTVO.setCorpId(prdtSVO.getsPrdtNum());

					AD_ADDAMTVO adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
					//System.out.println("---------------------1[[["+prdtSVO.getsFromDt() + " - " + prdtSVO.getsPrdtNum());
					if(adAddAmt == null) {
						//숙소 추가 요금 얻기
			    		ad_ADDAMTVO.setCorpId(ad_WEBDTLVO.getCorpId());

						adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
						//System.out.println("---------------------2[[["+prdtSVO.getsFromDt() + " - "+ad_WEBDTLVO.getCorpId() );
						if(adAddAmt == null) {
							adAddAmt = new AD_ADDAMTVO();
							adAddAmt.setAdultAddAmt("0");
							adAddAmt.setJuniorAddAmt("0");
							adAddAmt.setChildAddAmt("0");
						}
					}
					model.addAttribute("adAddAmt", adAddAmt );

			    	// 이미지
			    	CM_IMGVO imgVO = new CM_IMGVO();
			    	imgVO.setLinkNum(cart.getPrdtNum().toUpperCase());

			    	List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);

			    	model.addAttribute("imgList", imgList);

					return "/web/cs/adOptionLayer";

				} else if(Constant.SV.equals(category)) {

					WEB_SV_DTLPRDTVO searchVO = new WEB_SV_DTLPRDTVO();
					searchVO.setPrdtNum(cart.getPrdtNum());
					searchVO.setSvDivSn(cart.getSvDivSn());
					searchVO.setSvOptSn(cart.getSvOptSn());

					WEB_SV_DTLPRDTVO prdtInfo = webSvService.selectByCartPrdt(searchVO);

					// 상품 추가 옵션 가져오기.
					SV_ADDOPTINFVO sv_ADDOPTINFVO = new SV_ADDOPTINFVO();
					sv_ADDOPTINFVO.setPrdtNum(cart.getPrdtNum());

					List<SV_ADDOPTINFVO> addOptList = masSvService.selectPrdtAddOptionList(sv_ADDOPTINFVO);

					model.addAttribute("prdtInfo", prdtInfo);
			    	model.addAttribute("cartInfo", cart);
			    	model.addAttribute("cartList", cartList);
			    	model.addAttribute("addOptList", addOptList);

			    	return "/web/cs/svOptionLayer";
				}
			}
		}
    	return "/web/cs/rcOptionLayer";
    }

	/**
	* 설명 : 상세페이지 - 룸 예약정보 설정
	* 파일명 : adRoomOptionLay
	* 작성일 : 2021-12-28 오후 4:12
	* 작성자 : chaewan.jung
	* @param : [cartVO, request, model]
	* @return : java.lang.String
	* @throws Exception
	*/
	@RequestMapping("/web/adRoomOptionLayer.ajax")
	public String adRoomOptionLay(@ModelAttribute("prdtSVO") AD_WEBDTLSVO prdtSVO,
								  ModelMap model) {

		AD_WEBDTLVO ad_WEBDTLVO = webAdProductService.selectWebdtlByPrdt(prdtSVO);

		model.addAttribute("webdtl", ad_WEBDTLVO);

		//객실 정보읽기
		AD_PRDTINFVO adPrdtVO = new AD_PRDTINFVO();
		adPrdtVO.setPrdtNum(prdtSVO.getsPrdtNum());

		AD_PRDTINFVO adPrdtRes = masAdPrdtService.selectByAdPrdinf(adPrdtVO);

		model.addAttribute("prdtVO", adPrdtRes);
		model.addAttribute("searchVO", prdtSVO);

		//객실 추가 요금 얻기
		AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
		ad_ADDAMTVO.setAplStartDt(prdtSVO.getsFromDt());
		ad_ADDAMTVO.setCorpId(prdtSVO.getsPrdtNum());

		AD_ADDAMTVO adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
		if (adAddAmt == null) {
			//숙소 추가 요금 얻기
			ad_ADDAMTVO.setCorpId(ad_WEBDTLVO.getCorpId());

			adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
			if (adAddAmt == null) {
				adAddAmt = new AD_ADDAMTVO();
				adAddAmt.setAdultAddAmt("0");
				adAddAmt.setJuniorAddAmt("0");
				adAddAmt.setChildAddAmt("0");
			}
		}
		model.addAttribute("adAddAmt", adAddAmt);

		// 이미지
		CM_IMGVO imgVO = new CM_IMGVO();
		imgVO.setLinkNum(prdtSVO.getsPrdtNum().toUpperCase());

		List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
		model.addAttribute("imgList", imgList);

		return "/web/cs/adRoomOptionLayer";
	}

    /**
     * 장바구니 카운트
     * 파일명 : cartCnt
     * 작성일 : 2015. 11. 18. 오후 2:57:22
     * 작성자 : 최영철
     * @param request
     * @return
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/web/cartCnt.ajax")
    public ModelAndView cartCnt(HttpServletRequest request){

    	List<CARTVO> cartList = new ArrayList<CARTVO>();

    	if(request.getSession().getAttribute("cartList") != null) {
    		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
		}

    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap.put("cartCnt", cartList.size());

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }

    /**
     * 장바구니 삭제
     * 파일명 : deleteCart
     * 작성일 : 2015. 11. 13. 오전 10:13:25
     * 작성자 : 최영철
     * @param cartSn
     * @param request
     * @return
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/web/deleteCart.ajax")
    public ModelAndView deleteCart(@RequestParam(value="cartSn") String cartSn,
    								HttpServletRequest request){

    	String [] cartSn1 = cartSn.split(",");
    	List<CARTVO> cartList = new ArrayList<CARTVO>();

    	if(request.getSession().getAttribute("cartList") != null) {
    		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
		}

    	for(String cartSn2:cartSn1) {
    		for(int i=0; i < cartList.size(); i++) {
    			if(cartSn2.equals(String.valueOf(cartList.get(i).getCartSn()))) {
    				cartList.remove(i);
    			}
    		}
    	}
    	request.getSession().setAttribute("cartList", cartList);
    	
    	// 로그인된 사용자인 경우 DB 처리
    	if(EgovUserDetailsHelper.isAuthenticated()) {
    		webCartService.addCart(cartList);
    	}

    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap.put("cartCnt", cartList.size());

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }

   	/**
   	 * 장바구니 옵션 변경
   	 * 파일명 : changeCart
   	 * 작성일 : 2015. 11. 13. 오전 10:13:40
   	 * 작성자 : 최영철
   	 * @param cartVO
   	 * @param request
   	 * @return
   	 */
	@RequestMapping(value="/web/changeCart.ajax", method=RequestMethod.POST)
	public ModelAndView changeCart(@RequestBody CARTVO cartVO,
								   HttpServletRequest request){
   		log.info("/web/changeCart.ajax call");
       	List<CARTVO> cartList = new ArrayList<CARTVO>();

       	if(request.getSession().getAttribute("cartList") != null){
       		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
   		}
       	String category = cartVO.getPrdtNum().substring(0, 2).toUpperCase();
       	// 기존 상품의 옵션을 바꿈,
        if(Constant.SOCIAL.equals(category)) {
    		for(int i=0; i < cartList.size(); i++){
    			if(cartVO.getCartSn() == cartList.get(i).getCartSn()) {
					CARTVO cartOrg = cartList.get(i);

					cartOrg.setSpOptSn(cartVO.getSpOptSn());
					cartOrg.setSpDivSn(cartVO.getSpDivSn());
					cartOrg.setQty(cartVO.getQty());
					cartOrg.setAddOptAmt(cartVO.getAddOptAmt());
					cartOrg.setAddOptNm(cartVO.getAddOptNm());

    				cartList.set(i, cartOrg);
					break;
    			}
        	}
        }else if(Constant.ACCOMMODATION.equals(category)) {
        	for(int i=0; i < cartList.size(); i++) {
    			if(cartVO.getCartSn() == cartList.get(i).getCartSn()) {
    				CARTVO cartOrg = cartList.get(i);

    				cartOrg.setStartDt(cartVO.getStartDt());
    				cartOrg.setNight(cartVO.getNight());
    				cartOrg.setAdultCnt(cartVO.getAdultCnt());
    				cartOrg.setJuniorCnt(cartVO.getJuniorCnt());
    				cartOrg.setChildCnt(cartVO.getChildCnt());

    				cartList.set(i, cartOrg);
					break;
    			}
        	}
        }else if(Constant.RENTCAR.equals(category)) {
        	for(int i=0; i < cartList.size(); i++) {
    			if(cartVO.getCartSn() == cartList.get(i).getCartSn()) {
    				CARTVO cartOrg = cartList.get(i);

    				cartOrg.setFromDt(cartVO.getFromDt());
    				cartOrg.setFromTm(cartVO.getFromTm());
    				cartOrg.setToDt(cartVO.getToDt());
    				cartOrg.setToTm(cartVO.getToTm());
    				cartOrg.setInsureDiv(cartVO.getInsureDiv());
    				cartOrg.setAddAmt(cartVO.getAddAmt());

    				cartList.set(i, cartOrg);
					break;
    			}
        	}
        }else if(Constant.SV.equals(category)) {
    		for(int i=0; i < cartList.size(); i++){
    			if(cartVO.getCartSn() == cartList.get(i).getCartSn()) {
    				CARTVO cartOrg = cartList.get(i);

					cartOrg.setSvOptSn(cartVO.getSvOptSn());
					cartOrg.setSvDivSn(cartVO.getSvDivSn());
					cartOrg.setQty(cartVO.getQty());
					cartOrg.setAddOptAmt(cartVO.getAddOptAmt());
					cartOrg.setAddOptNm(cartVO.getAddOptNm());
					cartOrg.setDirectRecvYn(cartVO.getDirectRecvYn());

    				cartList.set(i, cartOrg);
    				break;
    			}
        	}
        }
       	request.getSession().setAttribute("cartList", cartList);
       	
       	// 로그인된 사용자인 경우 DB 처리
    	if(EgovUserDetailsHelper.isAuthenticated()) {
    		webCartService.addCart(cartList);
    	}

       	Map<String, Object> resultMap = new HashMap<String, Object>();
   		ModelAndView mav = new ModelAndView("jsonView", resultMap);

   		return mav;
	}

   	/**
   	 * 장바구니 옵션 중복 체크.
   	 * @param cartVO
   	 * @param request
   	 * @return
   	 */
   	@SuppressWarnings("unchecked")
	@RequestMapping(value="/web/checkDupOptionCart.ajax")
   	public ModelAndView checkDupOption(@ModelAttribute("cartVO") CARTVO cartVO,
										HttpServletRequest request) {

   		log.info("/web/checkDupOptionCart.ajax call");
   		Map<String, Object> resultMap = new HashMap<String, Object>();

   		List<CARTVO> cartList;

   		if(request.getSession().getAttribute("cartList") != null) {
       		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");

       		log.info("cartVO :: " + cartVO.toString());
       		// 소셜 상품일 경우 중복 된 상품 장바구니에서 삭제.
            if(Constant.SOCIAL.equals(cartVO.getPrdtNum().substring(0, 2).toUpperCase())) {
        		for(int i=0; i < cartList.size(); i++){
        			log.info("sesstion cart :: " + cartList.get(i).toString());

        			if(cartList.get(i).getPrdtNum().equals(cartVO.getPrdtNum())
						&& cartList.get(i).getSpDivSn().equals(cartVO.getSpDivSn())
						&& cartList.get(i).getSpOptSn().equals(cartVO.getSpOptSn())) {

        					log.info("same");
        					cartList.remove(i);

        					resultMap.put("resultCode", Constant.JSON_FAIL);
        					break;
        			}
            	}
            }
   		} else {
   			resultMap.put("resultCode", Constant.JSON_SUCCESS);
   		}
   		ModelAndView mav = new ModelAndView("jsonView", resultMap);
   		return mav;
   	}

   	@SuppressWarnings("unchecked")
	@RequestMapping("/web/reservationChk.ajax")
   	public ModelAndView reservationChk(HttpServletRequest request) {

   		List<CARTVO> cartList = new ArrayList<CARTVO>();

   		if(request.getSession().getAttribute("cartList") != null) {
   			cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");

   			cartList = webMainService.prdtAbleChk(cartList);
   		}
   		Map<String, Object> resultMap = new HashMap<String, Object>();

   		resultMap.put("cartList", cartList);

   		ModelAndView mav = new ModelAndView("jsonView", resultMap);

   		return mav;
   	}


   	/**
   	 * 아이디 비밀번호 찾기
   	 * 파일명 : viewFindIdPwd
   	 * 작성일 : 2015. 12. 21. 오후 9:07:15
   	 * 작성자 : 최영철
   	 * @return
   	 */
   	@RequestMapping("/web/viewFindIdPwd.do")
   	public String viewFindIdPwd(){
   		return "web/cs/findIdPwd";
   	}

   	/**
   	 * 아이디 찾기 인증번호 요청
   	 * 파일명 : getAuthNumId
   	 * 작성일 : 2015. 12. 21. 오후 9:07:23
   	 * 작성자 : 최영철
   	 * @param userSVO
   	 * @param request
   	 * @return
   	 */
   	@RequestMapping("/web/getAuthNumId.ajax")
    public ModelAndView getAuthNumId(@ModelAttribute("USERSVO") USERSVO userSVO,
									 HttpServletRequest request){

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	List<USERVO> userVOList = ossUserService.selectAuthUser(userSVO);

    	if(userVOList == null || userVOList.size() == 0) {
    		resultMap.put("success", "N");
    		resultMap.put("failMsg", "가입된 정보가 없습니다.");

    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}

    	String nansu = smsService.nanSuInt(6);

    	//알림톡 보내기
		apiAligoService.authCodeSend(userSVO.getsTelNum(), nansu);

		request.getSession().setAttribute(userSVO.getsTelNum(), nansu);

		resultMap.put("success", "Y");
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }

   	@RequestMapping("/web/findId.do")
   	public String findId(@ModelAttribute("USERSVO") USERSVO userSVO,
							ModelMap model){

   		List<USERVO> userVOList = ossUserService.selectAuthUser(userSVO);

   		model.addAttribute("userVOList", userVOList);

   		return "web/cs/findId";
   	}

   	/**
   	 * 비밀번호 찾기 인증번호 부여
   	 * 파일명 : getAuthNumPw
   	 * 작성일 : 2015. 12. 22. 오전 10:27:00
   	 * 작성자 : 최영철
   	 * @param userSVO
   	 * @return
   	 */
   	@RequestMapping("/web/getAuthNumPw.ajax")
    public ModelAndView getAuthNumPw(@ModelAttribute("USERSVO") USERSVO userSVO){

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	List<USERVO> userVOList = ossUserService.selectAuthUser(userSVO);

    	if(userVOList == null || userVOList.size() == 0) {
    		resultMap.put("success", "N");
    		resultMap.put("failMsg", "가입된 정보가 없습니다.");

    		ModelAndView mav = new ModelAndView("jsonView", resultMap);

    		return mav;
    	}
    	USERVO userVO = userVOList.get(0);

    	String nansu = smsService.nanSuInt(6);

		//알림톡 보내기
		apiAligoService.authCodeSend(userSVO.getsTelNum(), nansu);

		userVO.setSmsAuthNum(nansu);

		ossUserService.updateAuthNum(userVO);

		resultMap.put("success", "Y");
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }

   	/**
   	 * 비밀번호 인증 번호 체크
   	 * 파일명 : checkAuthNumPw
   	 * 작성일 : 2015. 12. 22. 오전 11:37:57
   	 * 작성자 : 최영철
   	 * @param userSVO
   	 * @return
   	 */
   	@RequestMapping("/web/checkAuthNumPw.ajax")
   	public ModelAndView checkAuthNumPw(@ModelAttribute("USERSVO") USERSVO userSVO) {

   		log.info("/web/checkAuthNumPw.ajax 호출");
   		Map<String, Object> resultMap = new HashMap<String, Object>();

   		List<USERVO> userVOList = ossUserService.selectAuthUser(userSVO);

   		if(userVOList == null || userVOList.size() == 0) {
   			log.info("가입된 정보가 없습니다.");
    		resultMap.put("success", "N");
    		resultMap.put("failMsg", "가입된 정보가 없습니다.");

    		ModelAndView mav = new ModelAndView("jsonView", resultMap);

    		return mav;
    	}
   		USERVO userVO = userVOList.get(0);

   		if(userSVO.getAuthNum() == null || userSVO.getAuthNum() == "") {
   			log.info("인증번호가 입력되지 않았습니다.");
   			resultMap.put("success", "N");
    		resultMap.put("failMsg", "인증번호가 입력되지 않았습니다.");

    		ModelAndView mav = new ModelAndView("jsonView", resultMap);

    		return mav;
   		}else{
   			if(userVO.getSmsAuthNum() == null || "".equals(userVO.getSmsAuthNum())){
   				log.info("인증번호전송을 다시 해주세요.");
   				resultMap.put("success", "N");
   	    		resultMap.put("failMsg", "인증번호전송을 다시해주세요.");

   	    		ModelAndView mav = new ModelAndView("jsonView", resultMap);

   	    		return mav;
   	   		}else{
   	   			if(userVO.getSmsAuthNum().equals(userSVO.getAuthNum())) {
   	   				log.info("인증성공.");
   	   				resultMap.put("success", "Y");
   	   			}else{
   	   				log.info("인증번호 틀림.");
	   	   			resultMap.put("success", "N");
	   	    		resultMap.put("failMsg", "인증번호가 틀렸습니다.");
   	   			}
   	   		}
   		}
   		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
   	}

   	@RequestMapping("/web/findPwd.do")
   	public String findPw(@ModelAttribute("USERSVO") USERSVO userSVO,
							ModelMap model){

   		List<USERVO> userVOList = ossUserService.selectAuthUser(userSVO);

   		model.addAttribute("userVO", userVOList.get(0));

   		return "web/cs/findPwd";
   	}

   	@RequestMapping("/web/changePwd.ajax")
   	public ModelAndView changePw(@ModelAttribute("USERVO") USERVO user,
								ModelMap model) throws Exception {

   		log.info("/web/changePwd.ajax 호출");
   		Map<String, Object> resultMap = new HashMap<String, Object>();

   		USERVO userVO = ossUserService.selectByUser(user);

   		userVO.setNewPwd(user.getNewPwd());
   		log.info("비밀번호 변경 처리");

   		ossUserService.updatePwd(userVO);

   		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
   	}

    /**
     * 비회원 인증번호 받기
     * 파일명 : getAuthNumGuest
     * 작성일 : 2016. 5. 9. 오후 5:53:45
     * 작성자 : 신우섭
     * @param params
     * @param request
     * @return
     */
    @RequestMapping("/web/getAuthNumGuest.ajax")
    public ModelAndView getAuthNumGuest(@RequestParam Map<String, String> params,
										HttpServletRequest request) {

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	request.getSession().setAttribute("guestLoginVO", null);//게스트 로그인 날리기

    	//비회원 구매 중에 예약되어 있는지 확인 - 예약 확인시에만 사용
    	if("Y".equals(params.get("isMypage"))) {

			RSV_HISSVO rsvHisSVO = new RSV_HISSVO();
			rsvHisSVO.setUserId(Constant.RSV_GUSET_NAME);//비회원의 경우
			rsvHisSVO.setRsvNm(params.get("userNm").trim());
			rsvHisSVO.setRsvTelnum(params.get("telNum"));

			List<RSVVO> rsvList = webOrderService.selectUserRsvListGuest(rsvHisSVO);

			if(rsvList.size() == 0) {
				resultMap.put("success", "N");
	    		resultMap.put("failMsg", "해당 이름과 전화번호로 비회원 구매된 내용이 없습니다.");

	    		ModelAndView mav = new ModelAndView("jsonView", resultMap);

	    		return mav;
			}
    	}
    	String nansu = smsService.nanSuInt(6);

		//알림톡 보내기
		apiAligoService.authCodeSend(params.get("telNum"), nansu);

		request.getSession().setAttribute(params.get("telNum"), nansu);

		resultMap.put("success", "Y");

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }


    /**
     * 비회원 인증 확인
     * 파일명 : checkAuthNumGuest
     * 작성일 : 2016. 5. 9. 오후 5:54:08
     * 작성자 : 신우섭
     * @param params
     * @param request
     * @return
     */
    @RequestMapping("/web/checkAuthNumGuest.ajax")
    public ModelAndView checkAuthNumGuest(@RequestParam Map<String, String> params,
										  HttpServletRequest request) {

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	String authNum = (String) request.getSession().getAttribute(params.get("telNum"));

    	if(params.get("authNum") == null || "".equals(params.get("authNum"))){
    		resultMap.put("success", "N");
    		resultMap.put("failMsg", "인증번호를 입력해주세요.");
    	}else{
    		if(authNum == null || "".equals(authNum)) {
    			resultMap.put("success", "N");
        		resultMap.put("failMsg", "인증번호전송을 다시해주세요.");
    		}else{
    			if(authNum.equals(params.get("authNum"))){
    				resultMap.put("success", "Y");
    			}else{
    				resultMap.put("success", "N");
            		resultMap.put("failMsg", "인증번호가 틀렸습니다.");
    			}
    		}
    	}
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	//log.info(">>>>"+params.get("telNum") +"<<<>>>>" + params.get("userNm"));
    	//인증완료에 따른 세션에 값넣기
    	request.getSession().setAttribute("loginVO", null);

    	if("Y".equals(resultMap.get("success"))){
            USERVO resultVO = new USERVO();
            resultVO.setTelNum(params.get("telNum"));
            resultVO.setUserNm(params.get("userNm"));

            request.getSession().setAttribute("guestLoginVO", resultVO);
        }

		return mav;
    }

    @RequestMapping("/web/guestPay01.do")
    public String guestPay01(@ModelAttribute("USERVO") USERVO userVO){
    	return "/web/cs/guestPay01";
    }

    @RequestMapping("/web/guestPay02.do")
    public String guestPay02(@ModelAttribute("USERVO") USERVO userVO){
    	return "/web/cs/guestPay02";
    }

    @RequestMapping("/web/weather.do")
    public String weather(ModelMap model) {

    	List<KMAGRIBVO> gribList = webKmaService.selectKmaGribList();
    	List<KMAMLWVO> mlwWfList = webKmaService.selectKmaMlwWfList();
    	List<KMAMLWVO> mlwTaList = webKmaService.selectKmaMlwTaList();

    	model.addAttribute("gribList", gribList);
    	model.addAttribute("mlwWfList", mlwWfList);
    	model.addAttribute("mlwTaList", mlwTaList);

    	return "/web/cs/weather";
    }
}
