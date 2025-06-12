package egovframework.cmmn.interceptor;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import oss.user.vo.USERVO;

import common.EgovUserDetailsHelper;

import egovframework.cmmn.service.EgovStringUtil;

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


public class MwAuthPayInterceptor extends HandlerInterceptorAdapter {
	
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
		String servletPath = request.getServletPath();
		String requestQS = request.getQueryString();
//		boolean isPermittedURL = false; 
		
		USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if(loginVO != null){
			return true;
		}
		
		loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();
		if(loginVO != null){
			return true;
		}else{
			// ajax 호출인 경우
			if("true".equals((String) request.getHeader("ajax"))){
				response.sendError(500);
				return false;
			}else{
				String rtnParameter = "";
				if(requestQS != null && !requestQS.isEmpty()){
					// 리턴URL 의 파라미터(&amp;amp > & 로 변환)
					String urlParam = EgovStringUtil.getHtmlStrCnvr(requestQS);
					
					// 실질적으로 리턴할 파라미터 선언
					rtnParameter = "&";
					// & 로 split
					String[] urlParam_s = urlParam.split("\\&");
					
					// 파라미터가 존재하는 만큼 for
					for(int i=0;i<urlParam_s.length;i++){
						// 첫번째 파라미터가 아니면 '&' 붙여줌 
						if(i >0){
							rtnParameter += "&";
						}
						// '=' 으로 split
						String[] s_param = urlParam_s[i].split("\\=");
						
						// 첫번째 파라미터명을 리턴 파라미터에 추가
						rtnParameter += s_param[0];
						// 파라미터가 존재할경우 '=' 붙여줌
						if(s_param[0] != null && !s_param[0].isEmpty()){
							rtnParameter += "=";
						}
						
						// 파라미터 매핑된 값을 리턴 파라미터에 추가(split 한 값이 없는경우 에러, 따라서 length 가 2인경우에 한에 추가)
						for(int j=0;j<s_param.length;j++){
							if(j == 1){
								// encoding
								rtnParameter += URLEncoder.encode(s_param[j], "UTF-8");
//								rtnParameter += s_param[j];
							}
						}
					}
				}
				
				String returnUrl = "redirect:/mw/viewLogin.do?mode=pay&rtnUrl=" + servletPath
				         	+ rtnParameter;
				
				ModelAndView modelAndView = new ModelAndView(returnUrl);			
				throw new ModelAndViewDefiningException(modelAndView);
			}
		}
	}

}
