package egovframework.cmmn.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;

public class WebDefaultInterceptor extends HandlerInterceptorAdapter {
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	/*private Set<String> permittedURL;
	
	
	public void setPermittedURL(Set<String> permittedURL) {
		this.permittedURL = permittedURL;
	}*/
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {	
		
		// 서버 이전 시 허용된 IP 제외 접근 차단..!! (2018-01-16, By JDongS)
		/*String connIp = EgovClntInfo.getClntIP(request);
		// 218.149.175.204 (넥스트 이지), 218.149.183.185 (탐나오 사무실), 192.168 ~ (협회 사무실 => 내부 IP 접속)
		if (!("218.149.183.187".equals(connIp) || "218.157.128.119".equals(connIp) || "192.168".equals(connIp.substring(0, 7)) || "0:0:0:0:0:0:0:1".equals(connIp))) {
			ModelAndView modelAndView = new ModelAndView("redirect:/main_new.do");
			throw new ModelAndViewDefiningException(modelAndView);
		}*/
		
		// 판매처 처리
		String flowPath = request.getParameter("flowPath");
		
		if(!EgovStringUtil.isEmpty(flowPath)){
			request.getSession().setAttribute("flowPath", flowPath);
		}
		
		return true;
	}

}
