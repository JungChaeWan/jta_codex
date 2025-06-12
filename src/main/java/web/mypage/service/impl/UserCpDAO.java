package web.mypage.service.impl;

import java.util.List;

import common.LowerHashMap;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import oss.coupon.vo.CPVO;
import oss.user.vo.USERVO;
import web.mypage.vo.USER_CPVO;
import web.order.vo.ORDERVO;
import web.order.vo.RSVVO;

@Repository("userCpDAO")
public class UserCpDAO extends EgovAbstractDAO {

	// 사용자 쿠폰 등록
	public void insertUserCoupon(USER_CPVO userCpVO) {
		insert("USER_CP_I_00", userCpVO);
	}

	// 사용자 쿠폰 수정
	public void updateUserCoupon(USER_CPVO userCpVO) {
		update("USER_CP_U_03", userCpVO);
	}

	/**
	 * 사용자 사용가능 쿠폰 리스트 조회
	 * 파일명 : selectUserCpList
	 * 작성일 : 2015. 11. 23. 오후 2:52:15
	 * 작성자 : 최영철
	 * @param userCpVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<USER_CPVO> selectUserCpList(USER_CPVO userCpVO) {
		return (List<USER_CPVO>) list("USER_CP_S_01", userCpVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<USER_CPVO> selectCouponList(String userId) {
		return (List<USER_CPVO>) list("WEB_USER_CP_S_00", userId);
	}
	
	/**
	 * 쿠폰 예약 처리
	 * 파일명 : updateUseCp
	 * 작성일 : 2015. 12. 4. 오후 4:40:47
	 * 작성자 : 최영철
	 * @param useCp
	 */
	public void updateUseCp(USER_CPVO useCp) {
		update("USER_CP_U_00", useCp);
	}

	/**
	 * 예약시 사용한 쿠폰 리스트 조회
	 * 파일명 : selectUseCpList
	 * 작성일 : 2015. 12. 7. 오전 11:04:22
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public USER_CPVO selectUseCpList(ORDERVO orderVO) {
		return (USER_CPVO) select("USER_CP_S_02", orderVO);
	}
	
	
	public int getCntCpAppFirstLogin(USER_CPVO cpVO) {
		return (Integer) select("USER_CP_S_03", cpVO);
	}
	

	/**
	 * 예약 취소 시 사용자 쿠폰 반환
	 * 파일명 : cancelUserCp
	 * 작성일 : 2015. 12. 10. 오후 3:46:53
	 * 작성자 : 최영철
	 * @param cpVO
	 */
	public void cancelUserCp(USER_CPVO cpVO) {
		update("USER_CP_U_01", cpVO);
	}

	public void insertUserCouponByCpId(USER_CPVO userCp) {
		insert("USER_CP_I_01", userCp);
	}

	public void insertUserAddCouponByCpId(CPVO userCp) {
		insert("USER_CP_I_02", userCp);
	}

	@SuppressWarnings("unchecked")
	public List<USERVO> selectCouponUserList(String cpId) {
		return (List<USERVO>) list("USER_CP_S_04", cpId);
	}
	
	public int getCntAutoCancelCoupon(USER_CPVO userCpVO) {
		return (Integer) select("USER_CP_S_05", userCpVO);
	}

	public void deleteUserCouponByCpId(CPVO cpVO) {
		delete("USER_CP_D_00", cpVO);
	}

	public void deleteUserCouponByRelatedCpId(USER_CPVO cpVO) {
		delete("USER_CP_D_01", cpVO);
	}
	
	/**
	 * 사용자 아이디, 쿠폰 아이디로 조회
	 * 파일명 : selectUserCpByCpIdUserId
	 * 작성일 : 2018. 8. 28. 오전 11:12:29
	 * 작성자 : 최영철
	 * @param userCpVO
	 * @return
	 */
	public USER_CPVO selectUserCpByCpIdUserId(USER_CPVO userCpVO){
		return (USER_CPVO) select("USER_CP_S_06", userCpVO);
	}
	
	//사용자 아이디, 쿠폰 아이디로 발급갯수
	public int selectUserCpByCpIdUserIdCnt(USER_CPVO userCpVO){
		return (Integer) select("USER_CP_S_08", userCpVO);
	}

	public Integer selectUseCpNum(USER_CPVO userCpVO){
		return (Integer) select("USER_CP_S_07", userCpVO);
	}

	public USER_CPVO selectCpInfoValidate(USER_CPVO userCpVO){
		return (USER_CPVO) select("USER_CP_S_09", userCpVO);
	}

	public List<LowerHashMap> selectUsedRCpList(USER_CPVO userCpVO){
		return (List<LowerHashMap>) list("USER_CP_S_10", userCpVO);
	}

}
