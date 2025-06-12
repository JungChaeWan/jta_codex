package egovframework.cmmn.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import oss.user.vo.USERVO;

import common.EgovUserDetailsHelper;

public class OssAjaxAuthInterceptor extends HandlerInterceptorAdapter {
	
//	private Set<String> permittedURL;
	
	
	/*public void setPermittedURL(Set<String> permittedURL) {
		this.permittedURL = permittedURL;
	}*/
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {	
		
//		String requestURI = request.getRequestURI(); //요청 URI
//		boolean isPermittedURL = false; 
		
		USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		
		if(loginVO != null){
			return true;
		}else{
			response.sendError(500);
			return false;
		}
	}

}
