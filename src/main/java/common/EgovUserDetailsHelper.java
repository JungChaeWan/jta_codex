package common;

import java.util.List;

import egovframework.cmmn.service.EgovUserDetailsService;

/**
 * EgovUserDetails Helper 클래스
 * 
 * @author sjyoon
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  sjyoon         최초 생성
 *   2011.07.01	 서준식          interface 생성후 상세 로직의 분리
 * </pre>
 */

public class EgovUserDetailsHelper {
	
		static EgovUserDetailsService egovUserDetailsService;
	
		public EgovUserDetailsService getEgovUserDetailsService() {
			return egovUserDetailsService;
		}

		@SuppressWarnings("static-access")
		public void setEgovUserDetailsService(
				EgovUserDetailsService egovUserDetailsService) {
			this.egovUserDetailsService = egovUserDetailsService;
		}

		/**
		 * 인증된 사용자객체를 VO형식으로 가져온다.
		 * @return Object - 사용자 ValueObject
		 */
		public static Object getAuthenticatedUser() {
			return egovUserDetailsService.getAuthenticatedUser();
		}
		
		public static Object getAuthenticatedGuest() {
			return egovUserDetailsService.getAuthenticatedGuest();
		}
		
		/**
		 * 인증된 사용자의 권한 정보를 가져온다.
		 * 
		 * @return List - 사용자 권한정보 목록
		 */
		public static List<String> getAuthorities() {
			

			return egovUserDetailsService.getAuthorities();
		}
		
		/**
		 * 인증된 사용자 여부를 체크한다.
		 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)	
		 */
		public static Boolean isAuthenticated() {
			
			return egovUserDetailsService.isAuthenticated();
		}
		
		public static Boolean isAuthenticatedGuest() {
			
			return egovUserDetailsService.isAuthenticatedGuest();
		}
		
		/**
		 * 인증된 관리자 여부를 체크한다.
		 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)	
		 */
		public static Boolean isMngAuthenticated() {
			
			return egovUserDetailsService.isMngAuthenticated();
		}
		
		/**
		 * 협회 관리자 인증 체크
		 * 파일명 : isOssAuthenticated
		 * 작성일 : 2015. 10. 15. 오후 1:52:23
		 * 작성자 : 최영철
		 * @return
		 */
		public static Boolean isOssAuthenticated(){
			return egovUserDetailsService.isOssAuthenticated();
		}
		
		/**
		 * 관리자 정보 VO
		 * 파일명 : getAuthenticatedOss
		 * 작성일 : 2015. 10. 15. 오후 1:56:28
		 * 작성자 : 최영철
		 * @return
		 */
		public static Object getAuthenticatedOss(){
			return egovUserDetailsService.getAuthenticatedOss();
		}

		public static Object getAuthenticatedMas() {
			return egovUserDetailsService.getAuthenticatedMas();
		}
		
		public static Object getAuthenticatedApiCn() {
			return egovUserDetailsService.getAuthenticatedApiCn();
		}
		
		public static Boolean isApiCnAuthenticated() {
			return egovUserDetailsService.isApiCnAuthenticated();
		}
}
