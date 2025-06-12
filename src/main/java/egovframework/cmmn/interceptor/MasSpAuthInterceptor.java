package egovframework.cmmn.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import oss.user.vo.USERVO;

import common.Constant;
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


public class MasSpAuthInterceptor extends HandlerInterceptorAdapter {
	
	/*private Set<String> permittedURL;
	
	
	public void setPermittedURL(Set<String> permittedURL) {
		this.permittedURL = permittedURL;
	}*/
	
	/**
	 * 로그인 업체가 소셜상품(SP) 업체인지를 체크하는 인터셉터
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {	
		
		USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		
		if(loginVO != null){
			if(Constant.SOCIAL.equals(loginVO.getCorpCd())){
				return true;
			}else{
				// 숙박 업체가 아닌경우 업체 상세 페이지로 이동
				ModelAndView modelAndView = new ModelAndView("redirect:/mas/detailCorp.do");			
				throw new ModelAndViewDefiningException(modelAndView);
			}
			
		}else{
			// 로그인 정보 자체가 없는 경우에는 로그인 창으로
			ModelAndView modelAndView = new ModelAndView("redirect:/mas/intro.do");			
			throw new ModelAndViewDefiningException(modelAndView);
		}
	}

}
