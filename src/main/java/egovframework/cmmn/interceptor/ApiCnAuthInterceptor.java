package egovframework.cmmn.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import oss.user.vo.USERVO;

import common.EgovUserDetailsHelper;

/**
 * 인증여부 체크 인터셉터
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성 
 *  2011.09.07  서준식          인증이 필요없는 URL을 패스하는 로직 추가
 *  </pre>
 */


public class ApiCnAuthInterceptor extends HandlerInterceptorAdapter {
	
	/*private Set<String> permittedURL;
	
	
	public void setPermittedURL(Set<String> permittedURL) {
		this.permittedURL = permittedURL;
	}*/
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {	
		
//		String requestURI = request.getRequestURI(); //요청 URI
//		boolean isPermittedURL = false; 
		
		USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedApiCn();
		
		if(loginVO != null){
			return true;
		}else{
			// ajax 호출인 경우
			if("true".equals((String) request.getHeader("ajax"))){
				response.sendError(500);
				return false;
			}else{
				ModelAndView modelAndView = new ModelAndView("redirect:/apiCn/intro.do");			
				throw new ModelAndViewDefiningException(modelAndView);
			}
		}
	}

}
