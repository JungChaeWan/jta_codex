package web.cs.service;

import oss.user.vo.USERVO;

public interface WebUserSnsService {

	// SNS 유저 정보
    USERVO selectUserSns(USERVO user);

	/**
	 * SNS 회원 정보 조회
	 * 파일명 : actionSnsLogin
	 * 작성일 : 2018. 10. 1. 오전 11:55:21
	 * 작성자 : 최영철
	 * @param loginVO
	 * @return
	 */
	USERVO actionSnsLogin(USERVO loginVO);

	/**
	 * SNS 유저 등록
	 * 파일명 : insertSnsUser
	 * 작성일 : 2018. 9. 28. 오후 1:37:06
	 * 작성자 : 최영철
	 * @param user
	 */
	void insertUserSns(USERVO user);

	// SNS 회원정보 수정
	void updateUserSns(USERVO user);

	// SNS 회원정보 삭제
	void deleteUserSns(USERVO user);

}
