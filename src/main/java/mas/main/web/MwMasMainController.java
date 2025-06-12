package mas.main.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;

@Controller
public class MwMasMainController {
	
	@Resource(name="ossUserService")
	protected OssUserService ossUserService;

	@RequestMapping("/mw/mas/head.do")
    public String head(	@RequestParam Map<String, String> params,
    						ModelMap model){
    	// AD : 숙박, SP : 소셜상품, RC : 렌트카, GL : 골프
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	model.addAttribute("corpCd", corpInfo.getCorpCd());
    	model.addAttribute("menuNm", params.get("menu"));
    	return "/mas/headMw";
    }
	
	@RequestMapping("/mw/mas/intro.do")
    public String intro(){
    	return "/mas/introMw";
    }
	
	@RequestMapping("/mw/mas/actionMasLogin.do")
    public String actionMasLogin(	@ModelAttribute("loginVO") USERVO loginVO, 
						            HttpServletRequest request,
						            ModelMap model) throws Exception{
    	if(EgovStringUtil.isEmpty(loginVO.getCorpId())){
    		model.addAttribute("failLogin","1");
    		return "/mas/introMw";
    	}
    	if(EgovStringUtil.isEmpty(loginVO.getPwd())){
    		model.addAttribute("failLogin","2");
    		return "/mas/introMw";
    	}
    	// 접속 IP
    	String userIp = EgovClntInfo.getClntIP(request);
    	loginVO.setLastLoginIp(userIp);
    	// 1. 관리자 로그인 처리
    	USERVO resultVO = ossUserService.actionMasLogin(loginVO);
    	
    	if (resultVO != null && resultVO.getUserId() != null && !resultVO.getUserId().equals("")) {
        	resultVO.setLastLoginIp(userIp);
        	request.getSession().setAttribute("masLoginVO", resultVO);
        	request.getSession().setAttribute("userVO", resultVO);
        	
        	return "redirect:/mw/mas/"+ resultVO.getCorpCd().toLowerCase() + "/rsvList.do";
    	}else{
    		model.addAttribute("failLogin","Y");
    		model.addAttribute("email",loginVO.getEmail());
    		return "/mas/introMw";
    	}
    }
	
	/**
     * 협회 관리자 로그아웃
     * 파일명 : ossLogout
     * 작성일 : 2015. 10. 15. 오후 1:48:26
     * 작성자 : 최영철
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mw/mas/masLogout.do")
	public String masLogout(HttpServletRequest request, ModelMap model){
		
		request.getSession().setAttribute("masLoginVO", null);
		request.getSession().setAttribute("userVO", null);
		
		return "mas/introMw";
	}
    
}
