package oss.coupon.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.coupon.vo.CPPRDTVO;
import oss.coupon.vo.CPSVO;
import oss.coupon.vo.CPVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("couponDAO")
public class CouponDAO extends EgovAbstractDAO { 

	@SuppressWarnings("unchecked")
	public List<CPVO> selectCouponList(CPSVO cpsVO) {
		return (List<CPVO>) list("CP_S_00", cpsVO);
	}

	public Integer getCntCouponList(CPSVO cpsVO) {
		return  (Integer) select("CP_S_01", cpsVO);
	}

	public String insertCoupon(CPVO cpVO) {
		return (String) insert("CP_I_00", cpVO);
	}

	public void updateCoupon(CPVO cpVO) {
		update("CP_U_00", cpVO);
	}

	public void updateCouponUseNum(CPVO cpVO) {
		update("CP_U_01", cpVO);
	}

	public CPVO selectByCoupon(CPVO cpVO) {
		return (CPVO) select("CP_S_02", cpVO);
	}

	public void deleteCoupon(CPVO cpVO) {
		delete("CP_D_00", cpVO);
	}
	
	/**
	 * 할인쿠폰의 상품 등록 
	 * Function : insertCouponPrdt
	 * 작성일 : 2017. 10. 17. 오후 1:40:08
	 * 작성자 : 정동수
	 * @param cpPrdtVO
	 */
	public void insertCouponPrdt(CPPRDTVO cpPrdtVO) {
		insert("CP_PRDT_I_00", cpPrdtVO);
	}
	
	/**
	 * 할인쿠폰의 상품 리스트 출력
	 * Function : selectCouponPrdtList
	 * 작성일 : 2017. 10. 17. 오후 3:33:15
	 * 작성자 : 정동수
	 * @param cpVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CPPRDTVO> selectCouponPrdtList(CPVO cpVO) {
		return (List<CPPRDTVO>) list("CP_PRDT_S_00", cpVO);
	}


	public List<CPPRDTVO> selectCouponPrdtListWeb(CPVO cpVO) {
		return (List<CPPRDTVO>) list("CP_PRDT_S_01", cpVO);
	}

	public List<CPPRDTVO> selectCouponCorpListWeb(CPVO cpVO) {
		return (List<CPPRDTVO>) list("CP_CORP_S_01", cpVO);
	}
	
	/**
	 * 할인쿠폰과 관련된 상품 삭제
	 * Function : deleteCouponPrdtList
	 * 작성일 : 2017. 10. 17. 오후 4:56:57
	 * 작성자 : 정동수
	 * @param cpId
	 */
	public void deleteCouponPrdtList(String cpId) {
		insert("CP_PRDT_D_00", cpId);
	}
	
	@SuppressWarnings("unchecked")
	public List<CPVO> selectCouponListWeb(CPSVO cpsVO) {
		return (List<CPVO>) list("CP_S_03", cpsVO);
	}

	/*자동발행 쿠폰*/
	public List<CPVO> selectCouponListAuto(String cpDiv) {
		return (List<CPVO>) list("CP_S_04", cpDiv);
	}

	public Integer couponUseCnt(List<String> cpIds) {
		return (Integer) select("CP_S_05", cpIds);
	}

	/** 이벤트2021 */
	public Integer event2021Cnt(String userId) {
		return (Integer) select("CP_S_06",userId);
	}

	/** 이벤트2021 */
	public void event2021Donation(String userId) {
		insert("CP_I_02",userId);
	}
	
	public Integer selectPctAmtByCoupon(String cpId) {
		return (Integer) select("CP_S_07", cpId);
	}

    public void insertCouponCorp(CPPRDTVO cpPrdtVO) {
		insert("CP_CORP_I_00", cpPrdtVO);
    }

	public void deleteCouponCorpList(String cpId) {
		insert("CP_CORP_D_00", cpId);
	}
}
