package egovframework.cmmn.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import oss.user.vo.USERVO;
import egovframework.cmmn.service.EgovUserDetailsService;

/**
 * 
 * @author 공통서비스 개발팀 서준식
 * @since 2011. 6. 25.
 * @version 1.0
 * @see
 *
 * <pre>
 * 개정이력(Modification Information) 
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011. 8. 12.    서준식        최초생성
 *  
 *  </pre>
 */

public class EgovUserDetailsSessionServiceImpl implements EgovUserDetailsService {

	public Object getAuthenticatedUser() {

		return RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);

	}
	
	public Object getAuthenticatedGuest() {

		return RequestContextHolder.getRequestAttributes().getAttribute("guestLoginVO", RequestAttributes.SCOPE_SESSION);

	}
	
	public List<String> getAuthorities() {

		// 권한 설정을 리턴한다.
		List<String> listAuth = new ArrayList<String>();

		return listAuth;
	}

	public Boolean isAuthenticated() {
		// 인증된 유저인지 확인한다.

		if (RequestContextHolder.getRequestAttributes() == null) {
			return false;
		} else {

			if (RequestContextHolder.getRequestAttributes().getAttribute(
					"loginVO", RequestAttributes.SCOPE_SESSION) == null) {
				return false;
			} else {
				return true;
			}
		}

	}
	
	public Boolean isAuthenticatedGuest() {
		// 인증된 유저인지 확인한다.

		if (RequestContextHolder.getRequestAttributes() == null) {
			return false;
		} else {

			if (RequestContextHolder.getRequestAttributes().getAttribute(
					"guestLoginVO", RequestAttributes.SCOPE_SESSION) == null) {
				return false;
			} else {
				return true;
			}
		}

	}
	
	/**
	 * 협회 관리자 인증 체크
	 * 파일명 : isOssAuthenticated
	 * 작성일 : 2015. 10. 15. 오후 1:52:23
	 * 작성자 : 최영철
	 * @return
	 */
	public Boolean isOssAuthenticated() {
		// 협회 관리자 인증된 유저인지 확인한다.
		if (RequestContextHolder.getRequestAttributes() == null) {
			return false;
		} else {
			if (RequestContextHolder.getRequestAttributes().getAttribute(
					"ossLoginVO", RequestAttributes.SCOPE_SESSION) == null) {
				return false;
			} else {
				USERVO userVO = (USERVO) RequestContextHolder.getRequestAttributes().getAttribute("ossLoginVO", RequestAttributes.SCOPE_SESSION);
				if("ADMIN".equals(userVO.getAuthNm())){
					return true;
				}else{
					return false;
				}
			}
		}
	}
	
	public Object getAuthenticatedOss(){
		USERVO userVO = (USERVO) RequestContextHolder.getRequestAttributes().getAttribute("ossLoginVO", RequestAttributes.SCOPE_SESSION);
		if(userVO != null){
			if("ADMIN".equals(userVO.getAuthNm())){
				return RequestContextHolder.getRequestAttributes().getAttribute("ossLoginVO", RequestAttributes.SCOPE_SESSION);
			}else{
				return null;
			}
		}else{
			return null;
		}
	}
	
	/**
	 * 입점업체 관리자 인증 유무
	 * 파일명 : isMasAuthenticated
	 * 작성일 : 2015. 10. 15. 오후 3:39:23
	 * 작성자 : 최영철
	 * @return
	 */
	public Boolean isMasAuthenticated() {
		// 입점업체 관리자 인증된 유저인지 확인한다.
		if (RequestContextHolder.getRequestAttributes() == null) {
			return false;
		} else {
			if (RequestContextHolder.getRequestAttributes().getAttribute(
					"masLoginVO", RequestAttributes.SCOPE_SESSION) == null) {
				return false;
			} else {
				USERVO userVO = (USERVO) RequestContextHolder.getRequestAttributes().getAttribute("masLoginVO", RequestAttributes.SCOPE_SESSION);
				if("ADMIN".equals(userVO.getAuthNm())){
					return true;
				}else{
					return false;
				}
			}
		}
	}
	
	public Object getAuthenticatedMas(){
		USERVO userVO = (USERVO) RequestContextHolder.getRequestAttributes().getAttribute("masLoginVO", RequestAttributes.SCOPE_SESSION);
		if(userVO != null){
			return RequestContextHolder.getRequestAttributes().getAttribute("masLoginVO", RequestAttributes.SCOPE_SESSION);
		}else{
			return null;
		}
	}
	
	/**
	 * 관리자용 인증 확인
	 * 생성일시 : 2014. 10. 8.오후 1:50:37
	 * 생성자   : 최영철
	 * @return
	 */
	public Boolean isMngAuthenticated() {
		return true;
	}
	
	public Boolean isApiCnAuthenticated() {
		// 인증된 유저인지 확인한다.
		if (RequestContextHolder.getRequestAttributes() == null) {
			return false;
		} else {
			if (RequestContextHolder.getRequestAttributes().getAttribute(
					"apiCnLoginVO", RequestAttributes.SCOPE_SESSION) == null) {
				return false;
			} else {
				USERVO userVO = (USERVO) RequestContextHolder.getRequestAttributes().getAttribute("apiCnLoginVO", RequestAttributes.SCOPE_SESSION);
				if("ADMIN".equals(userVO.getAuthNm())){
					return true;
				}else{
					return false;
				}
			}
		}
	}
	
	public Object getAuthenticatedApiCn(){
		USERVO userVO = (USERVO) RequestContextHolder.getRequestAttributes().getAttribute("apiCnLoginVO", RequestAttributes.SCOPE_SESSION);
		if(userVO != null){
			return RequestContextHolder.getRequestAttributes().getAttribute("apiCnLoginVO", RequestAttributes.SCOPE_SESSION);
		}else{
			return null;
		}
	}
	
}
