package web.cs.web;

import Raonwiz.Dext5.Codec.Binary.Base64;
import common.Constant;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;
import oss.marketing.serive.OssBestprdtService;
import oss.marketing.vo.BESTPRDTSVO;
import oss.marketing.vo.BESTPRDTVO;
import oss.user.service.OssUserService;
import oss.user.vo.LOGINLOGVO;
import oss.user.vo.USERVO;
import web.cs.service.WebUserSnsService;
import web.mypage.service.WebUserCpService;
import web.order.service.WebCartService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.security.spec.InvalidKeySpecException;
import java.util.*;

@Controller
public class WebUserSnsController {
	
	Logger log = LogManager.getLogger(this.getClass());

	@Resource(name = "webUserSnsService")
	private WebUserSnsService webUserSnsService;
	
	@Resource(name = "ossUserService")
	private OssUserService ossUserService;
	
	@Resource(name="webUserCpService")
	private WebUserCpService webUserCpService;
	
	@Resource(name = "webCartService")
	private WebCartService webCartService;
	
	@Resource(name="ossBestprdtService")
	private OssBestprdtService ossBestprdtService;
	
	/**
	 * 가입된 SNS 사용자인지 체크
	 * 파일명 : checkSns
	 * 작성일 : 2018. 9. 28. 오전 11:04:52
	 * 작성자 : 최영철
	 * @param user
	 * @return
	 */
	@RequestMapping("/web/checkSns.ajax")
    public ModelAndView checkSns(@ModelAttribute("USERVO") USERVO user) {

        USERVO uservo = webUserSnsService.selectUserSns(user);

        Map<String, Object> resultMap = new HashMap<String, Object>();

        if(uservo == null) {
			resultMap.put("result", "N");
		} else {
        	// 네이버 가입자 토큰 업데이트
        	if("N".equals(uservo.getSnsDiv()) && StringUtils.isEmpty(uservo.getToken())) {
        		webUserSnsService.updateUserSns(user);
			}
			resultMap.put("result", "Y");
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
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
    @RequestMapping("/web/actionSnsLogin.do")
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
			return "redirect:/";
		}

		String rtnUrl = request.getParameter("rtnUrl");
        String urlParam = request.getParameter("urlParam");

        String protocolUrl = "";
        String rtnParameter = "";

        if(StringUtils.isNotEmpty(urlParam)) {
            urlParam = EgovStringUtil.getHtmlStrCnvr(request.getParameter("urlParam"));
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
                        // rtnParameter += s_param[j];
                    }
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
        		return "redirect:" + protocolUrl + "/viewLogin.do?check=2&rtnUrl=" + rtnUrl + "&" + rtnParameter;
        	} else {
        		request.getSession().setAttribute("guestLoginVO", null);    //게스트 로그인 날리기
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
	        		
		        	if(StringUtils.isEmpty(rtnUrl) || "//index.jsp".equals(rtnUrl)) {
		        		return "redirect:" + protocolUrl + "/main.do";
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
    		model.addAttribute("mode", loginVO.getMode());
    		// 베스트 상품.
        	BESTPRDTSVO bestprdtSVO = new BESTPRDTSVO();

        	List<BESTPRDTVO> bestPrdtList = ossBestprdtService.selectBestprdtWebList(bestprdtSVO);

        	model.addAttribute("bestProductList", bestPrdtList);

    		return "/web/cs/login";
    	}
    }

    @RequestMapping(value = "/naverLogin.do", produces = "application/json", method = {RequestMethod.GET, RequestMethod.POST})
    public String naverLogin(@RequestParam("state") String state,
                             @RequestParam("code") String code,
                             HttpServletRequest request) {

        JsonNode token = NaverLogin.getAccessToken(state, code);

        JsonNode profile = NaverLogin.getNaverUserInfo(token.path("access_token").asText());

        Map<String, Object> profileMap = NaverLogin.changeData(profile);
        profileMap.put("snsDiv", "N");
        profileMap.put("token", token.path("refresh_token").asText());

        FlashMap fm = RequestContextUtils.getOutputFlashMap(request);
        fm.put("snsInfo", profileMap);

        if("mw_login".equals(state)) {
            return "redirect:/mw/viewLogin.do";
        } else if("mw".equals(state)) {
        	return "redirect:/mw/signUp00.do";
		} else if("web_login".equals(state)) {
			return "redirect:/web/viewLogin.do";
		} else {
			return "redirect:/web/signUp00.do";
		}
    }


    @RequestMapping(value = "/kakaoLogin.do", produces = "application/json", method = {RequestMethod.GET, RequestMethod.POST})
    public String kakaoLogin(@RequestParam("code") String code,
                             @RequestParam("state") String state,
                             HttpServletRequest request) {

        String redirectUri = request.getRequestURL().toString().replace(request.getRequestURI(), "");
        //http, https 포트 번호 제거
        int port = request.getServerPort();
        if(port == 80 || port == 443) {
            redirectUri = redirectUri.replace(":" + port, "");
        }
        redirectUri += Constant.KAKAO_REDIRECT_PATH;

        JsonNode token = KakaoLogin.getAccessToken(code, redirectUri);

        JsonNode profile = KakaoLogin.getKakaoUserInfo(token.path("access_token").asText());

        Map<String, Object> profileMap = KakaoLogin.changeData(profile);
        profileMap.put("snsDiv", "K");

        FlashMap fm = RequestContextUtils.getOutputFlashMap(request);
        fm.put("snsInfo", profileMap);

		if("mw_login".equals(state)) {
			return "redirect:/mw/viewLogin.do";
		} else if("mw".equals(state)) {
			return "redirect:/mw/signUp00.do";
		} else if("web_login".equals(state)) {
			return "redirect:/web/viewLogin.do";
		} else {
			return "redirect:/web/signUp00.do";
		}
    }

    @RequestMapping(value = "/appleLogin.do", produces = "application/json", method = {RequestMethod.GET, RequestMethod.POST})
    public String appleLogin(@RequestParam(value = "code", required = false) String code,
                             @RequestParam(value = "id_token", required = false) String id_token,
                             @RequestParam(value = "state", required = false) String state,
                             @RequestParam(value = "user", required = false) String user,
                             HttpServletRequest request) throws UnsupportedEncodingException, ParseException {

    	if(code == null || "".equals(code) ){
    		return "redirect:/mw/viewLogin.do";
		}

    	Map<String, Object> profileMap = new HashMap<String, Object>();
		Enumeration params = request.getParameterNames();
		while (params.hasMoreElements()){
			String name = (String)params.nextElement();
			System.out.println(name + " : " +request.getParameter(name));
		}
    	/** 계정연동이 안되어있을 경우 최초 1회만 user정보가 존재함.*/
    	if(user != null && !"".equals(user) && !"{}".equals(user)) {
			/** 회원가입시 이메일,이름 획득 */
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(user);
			JSONObject jsonObj = (JSONObject) obj;
			JSONObject nameObj = (JSONObject) jsonObj.get("name");

			/** 회원가입시 고정키값 획득 */
			String[] pieces = id_token.split("\\.");
			String b64payload = pieces[1];
			String jsonString = new String(Base64.decodeBase64(b64payload), "UTF-8");
			JSONParser parser2 = new JSONParser();
			Object obj2 = parser2.parse(jsonString);
			JSONObject jsonObj2 = (JSONObject) obj2;
			profileMap.put("userNm", nameObj.get("lastName").toString() + nameObj.get("firstName").toString());
			profileMap.put("email", jsonObj.get("email"));
			profileMap.put("loginKey", jsonObj2.get("sub"));
			state = "mw_join";
		}else{
			/** 로그인에도 고정키값 획득 */
			String[] pieces = id_token.split("\\.");
			String b64payload = pieces[1];
			String jsonString = new String(Base64.decodeBase64(b64payload), "UTF-8");
			JSONParser parser2 = new JSONParser();
			Object obj2 = parser2.parse(jsonString);
			JSONObject jsonObj2 = (JSONObject) obj2;
			profileMap.put("email", jsonObj2.get("email"));
			profileMap.put("loginKey", jsonObj2.get("sub"));
		}

		/*AppleLogin.getAccessToken(state, code, id_token);*/

        profileMap.put("snsDiv", "A");
        FlashMap fm = RequestContextUtils.getOutputFlashMap(request);
        fm.put("snsInfo", profileMap);

        if("mw_login".equals(state)) {
            return "redirect:/mw/viewLogin.do";
		} else {
			return "redirect:/mw/signUp00.do";
		}
    }

    //기존 가입자의 간편 가입 연동
	@RequestMapping("/web/insertUserSns.do")
	public String insertUserSns(@ModelAttribute("USERVO") USERVO user,
								HttpServletRequest request) {

		webUserSnsService.insertUserSns(user);

		// 로그인 처리
		USERVO resultVO = webUserSnsService.actionSnsLogin(user);
		request.getSession().setAttribute("loginVO", resultVO);

		return "redirect:/main.do";
	}

	//간편 로그인 연동 해제
	@RequestMapping("/web/deleteUserSns.do")
	public String deleteUserSns(HttpServletRequest request) {
        USERVO user = null;

        Map<String, ?> snsMap = RequestContextUtils.getInputFlashMap(request);
        if(snsMap != null) {
            user = (USERVO) snsMap.get("userInfo");
        }
        if(user != null) {
            webUserSnsService.deleteUserSns(user);
        }
		return "redirect:/web/mypage/viewUpdateUser.do";
	}

}
