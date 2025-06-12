package oss.coupon.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.coupon.vo.CPPRDTVO;
import oss.coupon.vo.CPSVO;
import oss.coupon.vo.CPVO;
import oss.user.vo.USERVO;
import web.mypage.vo.USER_CPVO;

public interface OssCouponService {

	Map<String, Object> selectCouponList(CPSVO cpsVO);

	String insertCoupon(CPVO cpVO, MultipartHttpServletRequest multiRequest) throws Exception;
	
	void updateCoupon(CPVO cpVO, MultipartHttpServletRequest multiRequest) throws Exception;

	void updateCoupon2(CPVO cpVO);

	CPVO selectByCoupon(CPVO cpVO);

	void deleteCoupon(CPVO cpVO);

	List<USERVO> selectCouponUserList(String cpId);

	void updateStatusByCoupon(CPVO cpVO);
	
	/**
	 * 할인쿠폰의 상품 등록 
	 * Function : insertCouponPrdt
	 * 작성일 : 2017. 10. 17. 오후 1:40:08
	 * 작성자 : 정동수
	 * @param cpPrdtVO
	 */
	void insertCouponPrdt(CPPRDTVO cpPrdtVO);
	
	/**
	 * 할인쿠폰의 상품 리스트 출력
	 * Function : selectCouponPrdtList
	 * 작성일 : 2017. 10. 17. 오후 3:33:15
	 * 작성자 : 정동수
	 * @param cpVO
	 * @return
	 */
	List<CPPRDTVO> selectCouponPrdtList(CPVO cpVO);

	List<CPPRDTVO> selectCouponPrdtListWeb(CPVO cpVO);

	List<CPPRDTVO> selectCouponCorpListWeb(CPVO cpVO);
	
	/**
	 * 할인쿠폰과 관련된 상품 삭제
	 * Function : deleteCouponPrdtList
	 * 작성일 : 2017. 10. 17. 오후 4:56:57
	 * 작성자 : 정동수
	 * @param cpId
	 */
	void deleteCouponPrdtList(String cpId);

	/**
	 * 상품에 관련된 사용 가능한 쿠폰 리스트 출력
	 * Function : selectCouponListWeb
	 * 작성일 : 2017. 12. 25. 오후 10:34:29
	 * 작성자 : 정동수
	 * @param cpsVO
	 * @return
	 */
	List<CPVO> selectCouponListWeb(CPSVO cpsVO);

	Integer couponUseCnt(List<String> cpIds);

	/** 이벤트2021 */
	Integer event2021Cnt(String userId);
	/** 이벤트2021 */
	void event2021Donation(String userId);
	
	Integer selectPctAmtByCoupon(String cpId);

	void insertUserAddCouponByCpId(CPVO userCp);

	/**
	* 설명 : 할인쿠폰의 업체 등록
	* 파일명 :
	* 작성일 : 2024-10-31 오후 1:26
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	void insertCouponCorp(CPPRDTVO cpPrdtVO);

	/**
	* 설명 : 할인쿠폰과 관련된 업체 삭제
	* 파일명 :
	* 작성일 : 2024-11-01 오전 9:59
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	void deleteCouponCorpList(String cpId);
}