package oss.coupon.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.cmm.service.OssFileUtilService;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPPRDTVO;
import oss.coupon.vo.CPSVO;
import oss.coupon.vo.CPVO;
import oss.user.vo.USERVO;
import web.mypage.service.impl.UserCpDAO;
import web.mypage.vo.USER_CPVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("ossCouponService")
public class OssCouponServiceImpl extends EgovAbstractServiceImpl implements OssCouponService {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(OssCouponServiceImpl.class);

	/** Coupon DAO */
	@Resource(name = "couponDAO")
	private CouponDAO couponDAO;
	
	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;
	
	@Resource(name = "userCpDAO")
	private UserCpDAO userCpDAO;
	
	@Override
	public Map<String, Object> selectCouponList(CPSVO cpsVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<CPVO> resultList = couponDAO.selectCouponList(cpsVO);
		Integer totalCnt = couponDAO.getCntCouponList(cpsVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}

	@Override
	public String insertCoupon(CPVO cpVO, MultipartHttpServletRequest multiRequest) {
		/*String savePath = EgovProperties.getProperty("COUPON.SAVEDFILE");

		MultipartFile prdtDtlImgFile = multiRequest.getFile("imgPathFile") ;
		if(!prdtDtlImgFile.isEmpty()) {
			String newFileName = cpId + "." + FilenameUtils.getExtension(multiRequest.getFile("imgPathFile").getOriginalFilename());
			ossFileUtilService.uploadFile(prdtDtlImgFile, newFileName, savePath);
			cpVO.setImgPath(savePath + newFileName);
		}*/
        String cpId = couponDAO.insertCoupon(cpVO);

		if(!"ALL".equals(cpVO.getTgtDiv())) {
            String[] userIds = cpVO.getUserId().split(",");

            USER_CPVO userCp = new USER_CPVO();
            userCp.setUserIds(userIds);
            userCp.setCpDiv(Constant.USER_CP_DIV_AEVT);
            userCp.setCpNm(cpVO.getCpNm());
            userCp.setDisAmt(cpVO.getDisAmt());
            userCp.setBuyMiniAmt(cpVO.getBuyMiniAmt());
            userCp.setExprStartDt(cpVO.getAplStartDt());
            userCp.setExprEndDt(cpVO.getAplEndDt());
            userCp.setCpId(cpId);
            userCp.setDisDiv(cpVO.getDisDiv());
            userCp.setDisPct(cpVO.getDisPct());
            userCp.setAplprdtDiv(cpVO.getAplprdtDiv());
            userCp.setLimitAmt(cpVO.getLimitAmt());
			// 쿠폰코드 사용시 쿠폰은 발행되나 코드입력 전에는 사용불가(use_yn is null)
			if(StringUtils.isEmpty(cpVO.getCpCode())) {
				userCp.setUseYn("N");
			}
            userCpDAO.insertUserCouponByCpId(userCp);

            cpVO.setUseNum(userIds.length);
        }
		couponDAO.updateCoupon(cpVO);
		
		return cpId;
	}

	@Override
	public void updateCoupon(CPVO cpVO, MultipartHttpServletRequest multiRequest) {
		/*String savePath = EgovProperties.getProperty("COUPON.SAVEDFILE");
		MultipartFile imgPathFile = multiRequest.getFile("imgPathFile") ;

		if(!imgPathFile.isEmpty()) {
			String newFileName = cpVO.getCpId() + "." + FilenameUtils.getExtension(multiRequest.getFile("imgPathFile").getOriginalFilename());
			ossFileUtilService.uploadFile(imgPathFile, newFileName, savePath);
			cpVO.setImgPath(savePath + newFileName);
		}*/
		if("AEVT".equals(cpVO.getCpDiv())) {
			userCpDAO.deleteUserCouponByCpId(cpVO);
		}
        if(!"ALL".equals(cpVO.getTgtDiv())) {
            String[] userIds = cpVO.getUserId().split(",");

            USER_CPVO userCp = new USER_CPVO();
            userCp.setUserIds(userIds);
            userCp.setCpDiv(Constant.USER_CP_DIV_AEVT);
            userCp.setCpNm(cpVO.getCpNm());
            userCp.setDisAmt(cpVO.getDisAmt());
            userCp.setBuyMiniAmt(cpVO.getBuyMiniAmt());
            userCp.setExprStartDt(cpVO.getAplStartDt());
            userCp.setExprEndDt(cpVO.getAplEndDt());
            userCp.setCpId(cpVO.getCpId());
            userCp.setDisDiv(cpVO.getDisDiv());
            userCp.setDisPct(cpVO.getDisPct());
            userCp.setAplprdtDiv(cpVO.getAplprdtDiv());
			// 쿠폰코드 사용시 쿠폰은 발행되나 코드입력 전에는 사용불가(use_yn is null)
			if(StringUtils.isEmpty(cpVO.getCpCode())) {
				userCp.setUseYn("N");
			}
            userCpDAO.insertUserCouponByCpId(userCp);

            cpVO.setUseNum(userIds.length);
        }
		couponDAO.updateCoupon(cpVO);
	}

	// 제한수량 수정
	@Override
	public void updateCoupon2(CPVO cpVO) {
		couponDAO.updateCoupon(cpVO);
	}

	@Override
	public CPVO selectByCoupon(CPVO cpVO) {
		return couponDAO.selectByCoupon(cpVO);
	}

	@Override
	public void deleteCoupon(CPVO cpVO) {
        userCpDAO.deleteUserCouponByCpId(cpVO);

        couponDAO.deleteCoupon(cpVO);
	}

	@Override
	public List<USERVO> selectCouponUserList(String cpId) {
		return userCpDAO.selectCouponUserList(cpId);
	}

	@Override
	public void updateStatusByCoupon(CPVO cpVO) {
		couponDAO.updateCoupon(cpVO);
	}

	/**
	 * 할인쿠폰의 상품 등록 
	 * Function : insertCouponPrdt
	 * 작성일 : 2017. 10. 17. 오후 1:40:08
	 * 작성자 : 정동수
	 * @param cpPrdtVO
	 */
	@Override
	public void insertCouponPrdt(CPPRDTVO cpPrdtVO) {
		couponDAO.insertCouponPrdt(cpPrdtVO);
	}

	/**
	 * 할인쿠폰의 상품 리스트 출력
	 * Function : selectCouponPrdtList
	 * 작성일 : 2017. 10. 17. 오후 3:33:15
	 * 작성자 : 정동수
	 * @param cpVO
	 * @return
	 */
	@Override
	public List<CPPRDTVO> selectCouponPrdtList(CPVO cpVO) {		
		return couponDAO.selectCouponPrdtList(cpVO);
	}

	@Override
	public List<CPPRDTVO> selectCouponPrdtListWeb(CPVO cpVO) {
		return couponDAO.selectCouponPrdtListWeb(cpVO);
	}

	@Override
	public List<CPPRDTVO> selectCouponCorpListWeb(CPVO cpVO) {
		return couponDAO.selectCouponCorpListWeb(cpVO);
	}

	/**
	 * 할인쿠폰과 관련된 상품 삭제
	 * Function : deleteCouponPrdtList
	 * 작성일 : 2017. 10. 17. 오후 4:56:57
	 * 작성자 : 정동수
	 * @param cpId
	 */
	@Override
	public void deleteCouponPrdtList(String cpId) {
		couponDAO.deleteCouponPrdtList(cpId);
	}

	/**
	 * 상품에 관련된 사용 가능한 쿠폰 리스트 출력
	 * Function : selectCouponListWeb
	 * 작성일 : 2017. 12. 25. 오후 10:34:29
	 * 작성자 : 정동수
	 * @param cpsVO
	 * @return
	 */
	@Override
	public List<CPVO> selectCouponListWeb(CPSVO cpsVO) {
		// 로그인 정보
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (userVO != null) {
			cpsVO.setUserId(userVO.getUserId());
		}
		return couponDAO.selectCouponListWeb(cpsVO);
	}

	@Override
	public Integer couponUseCnt(List<String> cpIds) {

		return couponDAO.couponUseCnt(cpIds);
	}

	/** 이벤트2021 */
	@Override
	public Integer event2021Cnt(String userId) {
		return couponDAO.event2021Cnt(userId);
	}

	/** 이벤트2021 */
	@Override
	public void event2021Donation(String userId) {
		couponDAO.event2021Donation(userId);
	}
	
	@Override
	public Integer selectPctAmtByCoupon(String cpId) {
		return couponDAO.selectPctAmtByCoupon(cpId);
	}

	// 제한수량 수정
	@Override
	public void insertUserAddCouponByCpId(CPVO userCp) {
		userCpDAO.insertUserAddCouponByCpId(userCp);
	}

    @Override
    public void insertCouponCorp(CPPRDTVO cpPrdtVO) {
		couponDAO.insertCouponCorp(cpPrdtVO);
    }

	public void deleteCouponCorpList(String cpId) {
		couponDAO.deleteCouponCorpList(cpId);
	}
}
