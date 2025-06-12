package web.cs.service.impl;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import oss.user.service.impl.UserDAO;
import oss.user.vo.USERVO;
import web.cs.service.WebUserSnsService;

@Service("webUserSnsService")
public class WebUserSnsServiceImpl implements WebUserSnsService {

	@Resource(name = "snsUserDAO")
	private UserSnsDAO userSnsDAO;
	
	@Resource(name = "userDAO")
	private UserDAO userDAO;


    // SNS 유저 정보
    @Override
    public USERVO selectUserSns(USERVO user){

        return userSnsDAO.selectUserSns(user);
    }

	/**
	 * SNS 회원 정보 조회
	 * 파일명 : actionSnsLogin
	 * 작성일 : 2018. 10. 1. 오전 11:55:21
	 * 작성자 : 최영철
	 * @param loginVO
	 * @return
	 */
	@Override
	public USERVO actionSnsLogin(USERVO loginVO) {
		USERVO resultVO = userSnsDAO.actionSnsLogin(loginVO);

		if(resultVO != null && StringUtils.isNotEmpty(resultVO.getUserId())) {
			resultVO.setLastLoginIp(loginVO.getLastLoginIp());
			// 최종로그인 시간 업데이트
			userDAO.setLoginTime(resultVO);

			return resultVO;
		} else {
			resultVO = new USERVO();
		}
		return resultVO;
	}

	/**
	 * SNS 유저 등록
	 * 파일명 : insertSnsUser
	 * 작성일 : 2018. 9. 28. 오후 1:37:06
	 * 작성자 : 최영철
	 * @param user
	 */
	@Override
	public void insertUserSns(USERVO user) {
		// 기존 data 삭제 후 등록
		userSnsDAO.deleteUserSns(user);
		userSnsDAO.insertUserSns(user);
	}

	// SNS 회원정보 수정
	@Override
	public void updateUserSns(USERVO user) {

		userSnsDAO.updateUserSns(user);
	}

	// SNS 회원정보 삭제
	@Override
	public void deleteUserSns(USERVO user) {

		userSnsDAO.deleteUserSns(user);
	}
}
