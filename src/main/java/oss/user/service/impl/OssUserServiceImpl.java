package oss.user.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.ibatis.sqlmap.client.event.RowHandler;
import org.springframework.stereotype.Service;

import oss.cmm.web.SHA256;
import oss.point.vo.POINTVO;
import oss.user.service.OssUserService;
import oss.user.vo.LOGINLOGVO;
import oss.user.vo.UPDATEUSERVO;
import oss.user.vo.USERSVO;
import oss.user.vo.USERVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import web.bbs.vo.NOTICEVO;


@Service("ossUserService")
public class OssUserServiceImpl extends EgovAbstractServiceImpl implements OssUserService {

//	private static final Logger LOGGER = LoggerFactory.getLogger(OssUserServiceImpl.class);

	/** UserDAO */
	@Resource(name = "userDAO")
	private UserDAO userDAO;

	@Override
	public USERVO selectByUser(USERSVO userSVO){
		return userDAO.selectByUser(userSVO);
	}

	@Override
	public String insertUser(USERVO userVO){
		return userDAO.insertUser(userVO);
	}

	/**
	 * 사용자 리스트 조회
	 * 파일명 : selectUserList
	 * 작성일 : 2015. 9. 23. 오후 6:36:04
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectUserList(USERSVO userSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<USERVO> resultList = userDAO.selectUserList(userSVO);
		Integer totalCnt = userDAO.getCntUserList(userSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	/**
	 * 사용자 정보 수정 - 패스워드 제외
	 * 파일명 : updateUser
	 * 작성일 : 2015. 9. 30. 오후 5:47:48
	 * 작성자 : 최영철
	 * @param user
	 */
	@Override
	public void updateUser(UPDATEUSERVO user){
		userDAO.updateUser(user);
	}

	/**
	 * 사용자 탈퇴처리
	 * 파일명 : dropUser
	 * 작성일 : 2015. 9. 30. 오후 6:23:08
	 * 작성자 : 최영철
	 * @param user
	 */
	@Override
	public void dropUser(USERVO user){
		userDAO.dropUser(user);
	}

	/**
	 * 탈퇴 사용자 조회
	 * 파일명 : selectDropUserList
	 * 작성일 : 2015. 10. 1. 오전 10:17:42
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectDropUserList(USERSVO userSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<USERVO> resultList = userDAO.selectDropUserList(userSVO);
		Integer totalCnt = userDAO.getCntDropUserList(userSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	/**
	 * 협회 관리자 로그인 처리
	 * 파일명 : actionOssLogin
	 * 작성일 : 2015. 10. 15. 오전 10:58:23
	 * 작성자 : 최영철
	 * @param loginVO
	 * @return
	 * @throws Exception
	 */
	public USERVO actionOssLogin(USERVO loginVO) throws Exception{
		loginVO.setAuthNm("ADMIN");
		SHA256 sha256 = new SHA256();
    	String enpassword = sha256.getSHA256_pwd(loginVO.getPwd());
    	loginVO.setPwd(enpassword);

    	// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.
    	USERVO resultVO = userDAO.actionOssLogin(loginVO);

    	// 3. 결과를 리턴한다.
    	if (resultVO != null && !resultVO.getUserId().equals("")) {
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
	 * 입점업체 관리자 로그인 처리
	 * 파일명 : actionMasLogin
	 * 작성일 : 2015. 10. 15. 오후 3:44:28
	 * 작성자 : 최영철
	 * @param loginVO
	 * @return
	 * @throws Exception
	 */
	public USERVO actionMasLogin(USERVO loginVO) throws Exception{
		SHA256 sha256 = new SHA256();
    	String enpassword = sha256.getSHA256_pwd(loginVO.getPwd());
    	loginVO.setPwd(enpassword);

    	// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.
    	USERVO resultVO = userDAO.actionMasLogin(loginVO);

    	// 3. 결과를 리턴한다.
    	if (resultVO != null && !resultVO.getUserId().equals("")) {
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
	 * 사용자 로그인 처리
	 * 파일명 : actionWebLogin
	 * 작성일 : 2015. 10. 28. 오후 3:40:05
	 * 작성자 : 최영철
	 * @param loginVO
	 * @return
	 * @throws Exception
	 */
	public USERVO actionWebLogin(USERVO loginVO) throws Exception{
		/*SHA256 sha256 = new SHA256();
    	String enpassword = sha256.getSHA256_pwd(loginVO.getPwd());*/
		String enpassword = loginVO.getPwd().toUpperCase();

    	loginVO.setPwd(enpassword);

    	// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.
    	USERVO resultVO = userDAO.actionOssLogin(loginVO);

    	// 3. 결과를 리턴한다.
    	if (resultVO != null && !resultVO.getUserId().equals("")) {
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
	 * 앱에서 이메일을 이용한 재 로그인 처리
	 * Function : actionMwReLogin
	 * 작성일 : 2017. 6. 8. 오전 11:26:54
	 * 작성자 : 정동수
	 * @param loginVO
	 * @return
	 * @throws Exception
	 */
	@Override
	public USERVO actionMwReLogin(USERVO loginVO) throws Exception {
    	// 2. 아이디가 DB와 일치하는지 확인한다.
    	USERVO resultVO = userDAO.selectByUser(loginVO);

    	// 3. 결과를 리턴한다.
    	if (resultVO != null && !resultVO.getUserId().equals("")) {
    		// 재 로그인 시 최종로그인 시간 업데이트 제외
    		//resultVO.setLastLoginIp(loginVO.getLastLoginIp());
    		// 최종로그인 시간 업데이트
    		//userDAO.setLoginTime(resultVO);
    		return resultVO;
    	} else {
    		resultVO = new USERVO();
    	}

    	return resultVO;
	}

	/**
	 * 패스워드 일치 여부 확인
	 * 파일명 : isEqualPw
	 * 작성일 : 2015. 11. 25. 오전 10:18:11
	 * 작성자 : 최영철
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@Override
	public USERVO isEqualPw(USERVO user) throws Exception{
		SHA256 sha256 = new SHA256();
    	String enpassword = sha256.getSHA256_pwd(user.getPwd());
    	user.setPwd(enpassword);
    	return userDAO.actionOssLogin(user);
	}

	/**
	 * 사용자 패스워드 변경
	 * 파일명 : updatePwd
	 * 작성일 : 2015. 11. 25. 오전 11:17:37
	 * 작성자 : 최영철
	 * @param user
	 * @throws Exception
	 */
	@Override
	public void updatePwd(USERVO user) throws Exception{
		SHA256 sha256 = new SHA256();
    	String enpassword = sha256.getSHA256_pwd(user.getNewPwd());
    	user.setNewPwd(enpassword);
		userDAO.updatePwd(user);
	}

	/**
	 * 인증 유저 확인
	 * 파일명 : selectAuthUser
	 * 작성일 : 2015. 12. 21. 오후 9:10:26
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	@Override
	public List<USERVO> selectAuthUser(USERSVO userSVO){
		return userDAO.selectAuthUser(userSVO);
	}

	/**
	 * 인증번호 디비 저장
	 * 파일명 : updateAuthNum
	 * 작성일 : 2015. 12. 22. 오전 10:20:58
	 * 작성자 : 최영철
	 * @param userVO
	 */
	@Override
	public void updateAuthNum(USERVO userVO){
		userDAO.updateAuthNum(userVO);
	}

	/**
	 * 협회에서 입점업체 로그인
	 * 파일명 : actionMasLogin2
	 * 작성일 : 2015. 12. 30. 오후 5:51:22
	 * 작성자 : 최영철
	 * @param userInfo
	 * @return
	 */
	@Override
	public USERVO actionMasLogin2(USERVO userInfo){
		return userDAO.actionMasLogin2(userInfo);
	}

	@Override
	public List<USERVO> selectUserListSMSEmail(USERVO userVO) {
		return userDAO.selectUserListSMSEmail(userVO);
	}

	/**
	 * 전화번호로 사용자 정보 조회
	 * 파일명 : selectByUserTelNum
	 * 작성일 : 2016. 1. 15. 오후 6:11:29
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	@Override
	public List<USERVO> selectByUserTelNum(USERSVO userSVO){
		return userDAO.selectByUserTelNum(userSVO);
	}

	/**
	 * 통합운영 엑셀 다운로드용 조회
	 * 파일명 : selectExcelUserList
	 * 작성일 : 2016. 5. 30. 오후 4:51:23
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	@Override
	public List<USERVO> selectExcelUserList(USERSVO userSVO){
		return userDAO.selectExcelUserList(userSVO);
	}

	@Override
	public List<USERVO> selectExcelUserListHandler(USERSVO userSVO){
		List<USERVO> returnList = new ArrayList<>();
		userDAO.selectExcelUserListHandler(userSVO, new UserListHandler(returnList));
		return returnList;
	}

	public class UserListHandler implements RowHandler{
		public List<USERVO> handlerList = null;

		public UserListHandler(List<USERVO> returnList){
			this.handlerList = returnList;
		}

		@Override
		public void handleRow(Object row){
			USERVO uservo = (USERVO) row;
			handlerList.add(uservo);
		}
	}
	
	/**
	 * 방문 10개월된 고객 체크
	 * Function : selectChkVisit10Month
	 * 작성일 : 2018. 3. 12. 오후 2:57:28
	 * 작성자 : 정동수
	 * @param userVO
	 * @return
	 */
	@Override
	public int selectChkVisit10Month(USERVO userVO) {
		return userDAO.selectChkVisit10Month(userVO);
	}

	@Override
	public String insertLoginLog(LOGINLOGVO loginLogVO) {
		return userDAO.insertLoginLog(loginLogVO);
	}

	@Override
	public void updateRestUserCancel(USERSVO userSVO) {
		userDAO.updateRestUserCancel(userSVO);		
	}

	@Override
	public Map<String, Object> selectPointUsageInfoList(USERSVO userSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<USERVO> resultList = userDAO.selectPointUsageInfoList(userSVO);
		Integer totalCnt = userDAO.getCntPointUsageInfoList(userSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public POINTVO getPointInfo(String partnerCode) {
		return userDAO.getPointInfo(partnerCode);
	}
}
