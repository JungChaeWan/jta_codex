package web.mypage.service;

import java.util.List;

import common.LowerHashMap;
import web.mypage.vo.USER_CPVO;
import web.order.vo.ORDERVO;
import web.order.vo.RSVVO;

public interface WebUserCpService {

	/**
	 *  발행
	 * @param userId
	 */
	public void epilCpPublish(String userId);

	/**
	 * 이용후기 쿠폰 발행
	 * @param userId
	 */
	public void uepiCpPublish(String userId);
	
	/**
	 * 앱 처음 로그인 쿠폰 발행
	 * @param userId
	 */
	public void appFirstLoginPublish(String userId);
	
	/**
	 * 10개월 후 재방문 로그인 시 쿠폰 발행
	 * @param userId
	 */
	public void vimoCpPublish(String userId);
	
	/**
	 * 실시간 상품 자동취소 시 쿠폰 발행
	 * @param userId
	 */
	public void acnrCpPublish(String userId);

	/**
	 * 제주특산/기념품 상품 자동취소 시 쿠폰 발행
	 * @param userId
	 */
	public void acnvCpPublish(String userId);
	
	/**
	 * 쿠폰 사용처리
	 */
	public void useUserCp(String cpNum);
	
	List<USER_CPVO> selectCouponList(String userId);
	
	
	/**
	 * 앱 로그인 쿠폰 수 얻기
	 * 파일명 : getCntCpAppFirstLogin
	 * 작성일 : 2016. 1. 18. 오후 6:54:48
	 * 작성자 : 신우섭
	 * @param cpVO
	 * @return
	 */
	int getCntCpAppFirstLogin(USER_CPVO cpVO);
	
	/**
	 * 사용자 쿠폰 수령
	 * 파일명 : cpPublish
	 * 작성일 : 2018. 8. 27. 오후 4:50:23
	 * 작성자 : 최영철
	 * @param userId
	 * @param cpId
	 */
	void cpPublish(String userId, String cpId);

	// 사용자 쿠폰 수정
	void updateUserCp(USER_CPVO userCpVO);

	// 사용자 아이디, 쿠폰 아이디로 조회
	USER_CPVO selectUserCpByCpIdUserId(USER_CPVO userCpVO);
	
	// 사용자 아이디, 쿠폰 아이디로 발급갯수
	int selectUserCpByCpIdUserIdCnt(USER_CPVO userCpVO);
	
	Integer selectUseCpNum(USER_CPVO userCpVO);
	
	/**
	 *  구매자동쿠폰발행
	 * @param rsvVO
	 */
	public void baapCpPublish(RSVVO rsvInfo);

	USER_CPVO selectCpInfoValidate(USER_CPVO userCpVO);

	List<LowerHashMap> selectUsedRCpList(USER_CPVO userCpVO);
}