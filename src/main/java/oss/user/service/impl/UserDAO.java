package oss.user.service.impl;

import java.util.List;

import com.ibatis.sqlmap.client.event.RowHandler;
import org.springframework.stereotype.Repository;

import oss.marketing.vo.USERCATEVO;
import oss.point.vo.POINTVO;
import oss.user.vo.LOGINLOGVO;
import oss.user.vo.REFUNDACCINFVO;
import oss.user.vo.UPDATEUSERVO;
import oss.user.vo.USERSVO;
import oss.user.vo.USERVO;
import web.order.vo.ORDERSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


@Repository("userDAO")
public class UserDAO extends EgovAbstractDAO {

	public USERVO selectByUser(USERSVO userSVO) {
		return (USERVO) select("USER_S_01", userSVO);
	}

	public String insertUser(USERVO userVO) {
		return (String) insert("USER_I_01", userVO);
	}

	/**
	 * 사용자 리스트 조회 - 페이징
	 * 파일명 : selectUserList
	 * 작성일 : 2015. 9. 23. 오후 6:39:57
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USERVO> selectUserList(USERSVO userSVO) {
		return (List<USERVO>) list("USER_S_02", userSVO);
	}

	/**
	 * 사용자 리스트 카운트 조회
	 * 파일명 : getCntUserList
	 * 작성일 : 2015. 9. 23. 오후 6:40:30
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	public Integer getCntUserList(USERSVO userSVO) {
		return (Integer) select("USER_S_03", userSVO);
	}

	@SuppressWarnings("unchecked")
	public List<USERVO> selectUserListSMSEmail(USERVO userVO) {
		return (List<USERVO>) list("USER_S_10", userVO);
	}

	/**
	 * 사용자 정보 수정 - 패스워드 제외
	 * 파일명 : updateUser
	 * 작성일 : 2015. 9. 30. 오후 5:47:48
	 * 작성자 : 최영철
	 * @param user
	 */
	public void updateUser(UPDATEUSERVO user) {
		update("USER_U_01", user);
	}

	/**
	 * 사용자 탈퇴처리
	 * 파일명 : dropUser
	 * 작성일 : 2015. 9. 30. 오후 6:23:59
	 * 작성자 : 최영철
	 * @param user
	 */
	public void dropUser(USERVO user) {
		update("USER_U_02", user);
	}

	/**
	 * 탈퇴사용자 리스트 조회
	 * 파일명 : selectDropUserList
	 * 작성일 : 2015. 10. 1. 오전 10:29:57
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USERVO> selectDropUserList(USERSVO userSVO) {
		return (List<USERVO>) list("USER_S_04", userSVO);
	}

	public Integer getCntDropUserList(USERSVO userSVO) {
		return (Integer) select("USER_S_05", userSVO);
	}

	public USERVO actionOssLogin(USERVO loginVO) {
		return (USERVO) select("USER_S_06", loginVO);
	}

	public void setLoginTime(USERVO resultVO) {
		update("USER_U_03", resultVO);
	}

	public USERVO actionMasLogin(USERVO loginVO) {
		return (USERVO) select("USER_S_07", loginVO);
	}

	/**
	 * 사용자 패스워드 변경
	 * 파일명 : updatePwd
	 * 작성일 : 2015. 11. 25. 오전 11:18:19
	 * 작성자 : 최영철
	 * @param user
	 */
	public void updatePwd(USERVO user) {
		update("USER_U_04", user);
	}

	/**
	 * 인증 유저 확인
	 * 파일명 : selectAuthUser
	 * 작성일 : 2015. 12. 21. 오후 9:11:10
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USERVO> selectAuthUser(USERSVO userSVO) {
		return (List<USERVO>) list("USER_S_08", userSVO);
	}

	/**
	 * 인증번호 저장
	 * 파일명 : updateAuthNum
	 * 작성일 : 2015. 12. 22. 오전 10:21:40
	 * 작성자 : 최영철
	 * @param userVO
	 */
	public void updateAuthNum(USERVO userVO) {
		update("USER_U_05", userVO);
	}

	/**
	 * 협회에서 상점관리자 로그인
	 * 파일명 : actionMasLogin2
	 * 작성일 : 2015. 12. 30. 오후 5:53:21
	 * 작성자 : 최영철
	 * @param userInfo
	 * @return
	 */
	public USERVO actionMasLogin2(USERVO userInfo) {
		return (USERVO) select("USER_S_09", userInfo);
	}

	/**
	 * 전화번호로 사용자 정보 조회
	 * 파일명 : selectByUserTelNum
	 * 작성일 : 2016. 1. 15. 오후 6:12:17
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USERVO> selectByUserTelNum(USERSVO userSVO) {
		return (List<USERVO>) list("USER_S_11", userSVO);
	}

	/**
	 * 사용자 환불계좌정보 조회
	 * 파일명 : selectByRefundAccInf
	 * 작성일 : 2016. 1. 22. 오후 3:47:30
	 * 작성자 : 최영철
	 * @param orderSVO
	 * @return
	 */
	public REFUNDACCINFVO selectByRefundAccInf(ORDERSVO orderSVO) {
		return (REFUNDACCINFVO) select("REFUNDACCINF_S_00", orderSVO);
	}

	/**
	 * 통합운영 사용자 엑셀 다운로드 용
	 * 파일명 : selectExcelUserList
	 * 작성일 : 2016. 5. 30. 오후 4:52:20
	 * 작성자 : 최영철
	 * @param userSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USERVO> selectExcelUserList(USERSVO userSVO) {
		return (List<USERVO>) list("USER_S_12", userSVO);
	}

	public void selectExcelUserListHandler(USERSVO userSVO, RowHandler rowHandler) {
		getSqlMapClientTemplate().queryWithRowHandler("USER_S_12", userSVO, rowHandler);
	}


	@SuppressWarnings("unchecked")
	public List<USERVO> selectUserCateList(USERCATEVO usercateVO) {
		return (List<USERVO>) list("USER_S_13", usercateVO);
	}

	public Integer selectUserCateReBuyCnt(USERCATEVO usercateVO) {
		return (Integer) select("USER_S_14", usercateVO);
	}



	public String insertLoginLog(LOGINLOGVO loginLogVO) {
		return (String) insert("LOGINLOG_I_00", loginLogVO);
	}
	
	/**
	 * 휴면 예정 고객 자동 메일 발송 (휴면 처리 7일전)
	 * Function : selectRestUserPrevList
	 * 작성일 : 2018. 3. 9. 오후 1:54:24
	 * 작성자 : 정동수
	 */
	@SuppressWarnings("unchecked")
	public List<USERVO> selectRestUserPrevList() {
		return (List<USERVO>) list("USER_S_15");
	}
	
	/**
	 * 휴면 대상 고객 자동 메일 발송
	 * Function : selectRestUserTargetList
	 * 작성일 : 2018. 3. 9. 오후 2:40:24
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USERVO> selectRestUserTargetList() {
		return (List<USERVO>) list("USER_S_16");
	}
	
	/**
	 * 방문 10개월된 고객 자동 메일 발송
	 * Function : visit10MonthSendMail
	 * 작성일 : 2018. 3. 12. 오후 1:46:03
	 * 작성자 : 정동수
	 */
	@SuppressWarnings("unchecked")
	public List<USERVO> visit10MonthSendMail() {
		return (List<USERVO>) list("USER_S_17");
	}
	
	/**
	 * 방문 10개월된 고객 체크
	 * Function : selectChkVisit10Month
	 * 작성일 : 2018. 3. 12. 오후 2:54:15
	 * 작성자 : 정동수
	 * @param userVO
	 * @return
	 */
	public int selectChkVisit10Month(USERVO userVO) {
		return (Integer) select("USER_S_18", userVO);
	}
	
	/**
	 * VIP/우수고객에 대한 메일 발송
	 * Function : vipBestSendMail
	 * 작성일 : 2018. 3. 12. 오후 5:15:55
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USERVO> vipBestSendMail(String cpId) {
		return (List<USERVO>) list("USER_S_19", cpId);
	}

    /**
     * 전체 고객에 대한 메일 발송
     */
    @SuppressWarnings("unchecked")
    public List<USERVO> allSendMail() {
        return (List<USERVO>) list("USER_S_20");
    }
	
	/**
	 * 휴면 대상 고객의 휴면 처리
	 * Function : updateRestUserTarget
	 * 작성일 : 2018. 3. 9. 오후 2:52:07
	 * 작성자 : 정동수
	 */
	public void updateRestUserTarget() {
		update("USER_U_06");
	}
	
	/**
	 * 휴면 고객의 해제
	 * Function : updateRestUserCancel
	 * 작성일 : 2018. 3. 12. 오전 10:43:21
	 * 작성자 : 정동수
	 */
	public void updateRestUserCancel(USERSVO userSVO) {
		update("USER_U_07", userSVO);
	}

	public List<USERVO> selectPointUsageInfoList(USERSVO userSVO) {
		return (List<USERVO>) list("USER_S_21", userSVO);
	}

	public Integer getCntPointUsageInfoList(USERSVO userSVO) {
		return (Integer) select("USER_S_22", userSVO);
	}

	public POINTVO getPointInfo(String partnerCode) {
		return (POINTVO) select("USER_S_23", partnerCode);
	}
}
