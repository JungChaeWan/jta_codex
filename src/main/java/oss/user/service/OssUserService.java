package oss.user.service;

import java.util.List;
import java.util.Map;

import oss.point.vo.POINTVO;
import oss.user.vo.LOGINLOGVO;
import oss.user.vo.UPDATEUSERVO;
import oss.user.vo.USERSVO;
import oss.user.vo.USERVO;
import web.bbs.vo.NOTICEVO;


public interface OssUserService {

	USERVO selectByUser(USERSVO userSVO);

	String insertUser(USERVO userVO);

	/**
	 * 사용자 리스트 조회
	 * 파일명 : selectUserList
	 * 작성일 : 2015. 9. 23. 오후 6:36:04
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	Map<String, Object> selectUserList(USERSVO userSVO);

	/**
	 * 사용자 정보 수정 - 패스워드 제외
	 * 파일명 : updateUser
	 * 작성일 : 2015. 9. 30. 오후 5:47:48
	 * 작성자 : 최영철
	 * @param user
	 */
	void updateUser(UPDATEUSERVO user);

	/**
	 * 사용자 탈퇴처리
	 * 파일명 : dropUser
	 * 작성일 : 2015. 9. 30. 오후 6:23:08
	 * 작성자 : 최영철
	 * @param user
	 */
	void dropUser(USERVO user);

	/**
	 * 탈퇴 사용자 조회
	 * 파일명 : selectDropUserList
	 * 작성일 : 2015. 10. 1. 오전 10:17:42
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	Map<String, Object> selectDropUserList(USERSVO userSVO);

	/**
	 * 협회 관리자 로그인 처리
	 * 파일명 : actionOssLogin
	 * 작성일 : 2015. 10. 15. 오전 10:58:23
	 * 작성자 : 최영철
	 * @param loginVO
	 * @return
	 * @throws Exception
	 */
	USERVO actionOssLogin(USERVO loginVO) throws Exception;

	/**
	 * 입점업체 관리자 로그인 처리
	 * 파일명 : actionMasLogin
	 * 작성일 : 2015. 10. 15. 오후 3:44:28
	 * 작성자 : 최영철
	 * @param loginVO
	 * @return
	 * @throws Exception
	 */
	USERVO actionMasLogin(USERVO loginVO) throws Exception;

	/**
	 * 사용자 로그인 처리
	 * 파일명 : actionWebLogin
	 * 작성일 : 2015. 10. 28. 오후 3:40:05
	 * 작성자 : 최영철
	 * @param loginVO
	 * @return
	 * @throws Exception
	 */
	USERVO actionWebLogin(USERVO loginVO) throws Exception;

	/**
	 * 앱에서 이메일을 이용한 재 로그인 처리
	 * Function : actionMwReLogin
	 * 작성일 : 2017. 6. 8. 오전 11:26:54
	 * 작성자 : 정동수
	 * @param loginVO
	 * @return
	 * @throws Exception
	 */
	USERVO actionMwReLogin(USERVO loginVO) throws Exception;

	/**
	 * 패스워드 일치 여부 확인
	 * 파일명 : isEqualPw
	 * 작성일 : 2015. 11. 25. 오전 10:18:11
	 * 작성자 : 최영철
	 * @param user
	 * @return
	 * @throws Exception
	 */
	USERVO isEqualPw(USERVO user) throws Exception;

	/**
	 * 사용자 패스워드 변경
	 * 파일명 : updatePwd
	 * 작성일 : 2015. 11. 25. 오전 11:17:37
	 * 작성자 : 최영철
	 * @param user
	 * @throws Exception
	 */
	void updatePwd(USERVO user) throws Exception;

	/**
	 * 인증 유저 확인
	 * 파일명 : selectAuthUser
	 * 작성일 : 2015. 12. 21. 오후 9:10:26
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	List<USERVO> selectAuthUser(USERSVO userSVO);

	/**
	 * 인증번호 디비 저장
	 * 파일명 : updateAuthNum
	 * 작성일 : 2015. 12. 22. 오전 10:20:58
	 * 작성자 : 최영철
	 * @param userVO
	 */
	void updateAuthNum(USERVO userVO);

	/**
	 * 협회에서 입점업체 로그인
	 * 파일명 : actionMasLogin2
	 * 작성일 : 2015. 12. 30. 오후 5:51:22
	 * 작성자 : 최영철
	 * @param userInfo
	 * @return
	 */
	USERVO actionMasLogin2(USERVO userInfo);



	List<USERVO> selectUserListSMSEmail(USERVO userVO);

	/**
	 * 전화번호로 사용자 정보 조회
	 * 파일명 : selectByUserTelNum
	 * 작성일 : 2016. 1. 15. 오후 6:11:29
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	List<USERVO> selectByUserTelNum(USERSVO userSVO);

	/**
	 * 통합운영 엑셀 다운로드용 조회
	 * 파일명 : selectExcelUserList
	 * 작성일 : 2016. 5. 30. 오후 4:51:23
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	List<USERVO> selectExcelUserList(USERSVO userSVO);

	List<USERVO> selectExcelUserListHandler(USERSVO userSVO);


	/**
	 * 방문 10개월된 고객 체크
	 * Function : selectChkVisit10Month
	 * 작성일 : 2018. 3. 12. 오후 2:57:28
	 * 작성자 : 정동수
	 * @param userVO
	 * @return
	 */
	int selectChkVisit10Month(USERVO userVO);

	String insertLoginLog(LOGINLOGVO loginLogVO);
	
	/**
	 * 휴면 고객의 해제
	 * Function : updateRestUserCancel
	 * 작성일 : 2018. 3. 12. 오전 10:45:22
	 * 작성자 : 정동수
	 */
	void updateRestUserCancel(USERSVO userSVO);

	/**
	* 설명 : 파트너관리자 - 사용현황 리스트
	* 파일명 :
	* 작성일 : 2023-07-27 오전 11:32
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	Map<String, Object> selectPointUsageInfoList(USERSVO userSVO);

	/**
	* 설명 : 파트너관리자 - 사용현황 리스트 -  총 발급/사용 포인트 현황
	* 파일명 :
	* 작성일 : 2023-07-28 오전 10:17
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	POINTVO getPointInfo(String partnerCode);
}
