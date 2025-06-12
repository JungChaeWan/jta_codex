package web.cs.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;
import oss.user.vo.USERVO;

@Repository("snsUserDAO")
public class UserSnsDAO extends EgovAbstractDAO{

    // SNS 유저 정보
    public USERVO selectUserSns(USERVO user){
        return (USERVO) select("USERSNS_S_01", user);
    }

	/**
	 * SNS 회원 정보 조회
	 * 파일명 : actionSnsLogin
	 * 작성일 : 2018. 10. 1. 오전 11:55:57
	 * 작성자 : 최영철
	 * @param loginVO
	 * @return
	 */
	public USERVO actionSnsLogin(USERVO loginVO) {
		return (USERVO) select("USERSNS_S_02", loginVO);
	}

	/**
	 * SNS 유저 등록
	 * 파일명 : insertSnsUser
	 * 작성일 : 2018. 9. 28. 오후 1:38:11
	 * 작성자 : 최영철
	 * @param user
	 */
	public void insertUserSns(USERVO user) {
		insert("USERSNS_I_01", user);
	}

	// SNS 회원정보 수정
	public void updateUserSns(USERVO user) {
		update("USERSNS_U_01", user);
	}

	// SNS 회원정보 삭제
	public void deleteUserSns(USERVO user) {
		delete("USERSNS_D_01", user);
	}

}
