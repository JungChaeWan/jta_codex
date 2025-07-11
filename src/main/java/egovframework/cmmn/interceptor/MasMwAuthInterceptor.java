package egovframework.cmmn.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import common.Constant;
import common.EgovUserDetailsHelper;
import oss.user.vo.USERVO;

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


public class MasMwAuthInterceptor extends HandlerInterceptorAdapter {
	
	/*private Set<String> permittedURL;
	
	
	public void setPermittedURL(Set<String> permittedURL) {
		this.permittedURL = permittedURL;
	}*/
	
	/**
	 * 세션에 관광지업체정보(corpVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 관광지업체정보(corpVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {	
		
//		String requestURI = request.getRequestURI(); //요청 URI
//		boolean isPermittedURL = false; 
		
		
		USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		
		String url = getURL(request);
		if(loginVO != null){
			if(Constant.SOCIAL.equals(loginVO.getCorpCd()) && url.contains("/sp/")) {
				return true;
			} else if(Constant.SV.equals(loginVO.getCorpCd()) && url.contains("/sv/")) {
				return true;
			}else if(Constant.RENTCAR.equals(loginVO.getCorpCd()) && url.contains("/rc/")) {
				return true;
			}else if(Constant.ACCOMMODATION.equals(loginVO.getCorpCd()) && url.contains("/ad/")) {
				return true;
			}else {
				ModelAndView modelAndView = new ModelAndView("redirect:/mw/mas/" + loginVO.getCorpCd().toLowerCase() + "/rsvList.do");			
				throw new ModelAndViewDefiningException(modelAndView);
			}
		}else{
			// ajax 호출인 경우
			if("true".equals((String) request.getHeader("ajax"))){
				response.sendError(500);
				return false;
			}else{
				ModelAndView modelAndView = new ModelAndView("redirect:/mw/mas/intro.do");			
				throw new ModelAndViewDefiningException(modelAndView);
			}
		}
	}
	
	public static String getURL(HttpServletRequest request)
	  {
	    Enumeration<?> param = request.getParameterNames();

	    StringBuffer strParam = new StringBuffer();
	    StringBuffer strURL = new StringBuffer();

	    if (param.hasMoreElements())
	    {
	      strParam.append("?");
	    }

	    while (param.hasMoreElements())
	    {
	      String name = (String) param.nextElement();
	      String value = request.getParameter(name);

	      strParam.append(name + "=" + value);

	      if (param.hasMoreElements())
	      {
	        strParam.append("&");
	      }
	  }

	  strURL.append(request.getRequestURI());
	  strURL.append(strParam);

	  return strURL.toString();
	}

}
