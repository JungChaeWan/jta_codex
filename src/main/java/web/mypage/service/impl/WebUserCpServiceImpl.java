package web.mypage.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import common.LowerHashMap;
import org.springframework.stereotype.Service;

import oss.coupon.service.impl.CouponDAO;
import oss.coupon.vo.CPVO;
import oss.env.service.impl.SiteManageDAO;
import oss.env.vo.DFTINFVO;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.USER_CPVO;
import web.order.service.impl.WebOrderDAO;
import web.order.vo.ORDERVO;
import web.order.vo.RSVVO;
import common.Constant;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("webUserCpService")
public class WebUserCpServiceImpl extends EgovAbstractServiceImpl implements WebUserCpService {

	@Resource(name="siteManageDAO")
    private SiteManageDAO siteManageDAO;
	
	@Resource(name="userCpDAO")
	private UserCpDAO userCpDAO;
	
	@Resource(name="couponDAO")
	private CouponDAO couponDAO;
	
	
	@Resource(name = "webOrderDAO")
	private WebOrderDAO webOrderDAO;
	
	@Override
	public void epilCpPublish(String userId) {
		USER_CPVO userCpVO = setBaseCp(Constant.USER_CP_DIV_EPIL);

		userCpVO.setUserId(userId);

		List<CPVO> cpList = couponDAO.selectCouponListAuto(Constant.USER_CP_DIV_EPIL);

		for(CPVO cp : cpList) {
			userCpVO.setCpDiv(cp.getCpDiv());
			userCpVO.setCpId(cp.getCpId());
			userCpVO.setCpNm(cp.getCpNm());
			userCpVO.setDisAmt(cp.getDisAmt());
			userCpVO.setDisPct(cp.getDisPct());
			userCpVO.setDisDiv(cp.getDisDiv());
			userCpVO.setBuyMiniAmt(cp.getBuyMiniAmt());
			userCpVO.setAplprdtDiv(cp.getAplprdtDiv());

			userCpDAO.insertUserCoupon(userCpVO);
		}
	}
	
	@Override
	public void uepiCpPublish(String userId) {
		USER_CPVO userCpVO = setBaseCp(Constant.USER_CP_DIV_UEPI);

		userCpVO.setUserId(userId);

		List<CPVO> cpList = couponDAO.selectCouponListAuto(Constant.USER_CP_DIV_UEPI);

		for(CPVO cp : cpList) {
			userCpVO.setCpDiv(cp.getCpDiv());
			userCpVO.setCpId(cp.getCpId());
			userCpVO.setCpNm(cp.getCpNm());
			userCpVO.setDisAmt(cp.getDisAmt());
			userCpVO.setDisPct(cp.getDisPct());
			userCpVO.setDisDiv(cp.getDisDiv());
			userCpVO.setBuyMiniAmt(cp.getBuyMiniAmt());
			userCpVO.setAplprdtDiv(cp.getAplprdtDiv());

			userCpDAO.insertUserCoupon(userCpVO);
		}
	}
	
	@Override
	public void vimoCpPublish(String userId) {
		USER_CPVO userCpVO = setBaseCp(Constant.USER_CP_DIV_VIMO);

		userCpVO.setUserId(userId);

		List<CPVO> cpList = couponDAO.selectCouponListAuto(Constant.USER_CP_DIV_VIMO);

		for(CPVO cp : cpList) {
			userCpVO.setCpDiv(cp.getCpDiv());
			userCpVO.setCpId(cp.getCpId());
			userCpVO.setCpNm(cp.getCpNm());
			userCpVO.setDisAmt(cp.getDisAmt());
			userCpVO.setDisPct(cp.getDisPct());
			userCpVO.setDisDiv(cp.getDisDiv());
			userCpVO.setBuyMiniAmt(cp.getBuyMiniAmt());
			userCpVO.setAplprdtDiv(cp.getAplprdtDiv());

			userCpDAO.insertUserCoupon(userCpVO);
		}
	}
	
	@Override
	public void appFirstLoginPublish(String userId) {
		USER_CPVO  userCpVO = setBaseCp(Constant.USER_CP_DIV_UAPP);

		userCpVO.setUserId(userId);

		List<CPVO> cpList = couponDAO.selectCouponListAuto(Constant.USER_CP_DIV_UAPP);

		for(CPVO cp : cpList) {
			userCpVO.setCpDiv(cp.getCpDiv());
			userCpVO.setCpId(cp.getCpId());
			userCpVO.setCpNm(cp.getCpNm());
			userCpVO.setDisAmt(cp.getDisAmt());
			userCpVO.setDisPct(cp.getDisPct());
			userCpVO.setDisDiv(cp.getDisDiv());
			userCpVO.setBuyMiniAmt(cp.getBuyMiniAmt());
			userCpVO.setAplprdtDiv(cp.getAplprdtDiv());

			userCpDAO.insertUserCoupon(userCpVO);
		}
	}
	
	@Override
	public void acnrCpPublish(String userId) {
		USER_CPVO userCpVO = setBaseCp(Constant.USER_CP_DIV_ACNR);

		userCpVO.setUserId(userId);

		List<CPVO> cpList = couponDAO.selectCouponListAuto(Constant.USER_CP_DIV_ACNR);

		for(CPVO cp : cpList) {
			userCpVO.setCpDiv(cp.getCpDiv());
			userCpVO.setCpId(cp.getCpId());
			userCpVO.setCpNm(cp.getCpNm());
			userCpVO.setDisAmt(cp.getDisAmt());
			userCpVO.setDisPct(cp.getDisPct());
			userCpVO.setDisDiv(cp.getDisDiv());
			userCpVO.setBuyMiniAmt(cp.getBuyMiniAmt());
			userCpVO.setAplprdtDiv(cp.getAplprdtDiv());
			userCpVO.setLimitAmt(cp.getLimitAmt());
			
			userCpDAO.insertUserCoupon(userCpVO);
		}
	}

	@Override
	public void acnvCpPublish(String userId) {
		USER_CPVO userCpVO = setBaseCp(Constant.USER_CP_DIV_ACNV);

		userCpVO.setUserId(userId);

		List<CPVO> cpList = couponDAO.selectCouponListAuto(Constant.USER_CP_DIV_ACNV);

		for(CPVO cp : cpList) {
			userCpVO.setCpDiv(cp.getCpDiv());
			userCpVO.setCpId(cp.getCpId());
			userCpVO.setCpNm(cp.getCpNm());
			userCpVO.setDisAmt(cp.getDisAmt());
			userCpVO.setDisPct(cp.getDisPct());
			userCpVO.setDisDiv(cp.getDisDiv());
			userCpVO.setBuyMiniAmt(cp.getBuyMiniAmt());
			userCpVO.setAplprdtDiv(cp.getAplprdtDiv());

			userCpDAO.insertUserCoupon(userCpVO);
		}
	}
	
	@Override
	public void useUserCp(String cpNum) {
		// USER_CP_U_00 <- 사용하면 됨.
		
	}
	
	public USER_CPVO setBaseCp(String cpDiv) {
		DFTINFVO dftInfVO = siteManageDAO.selectDftInf(Constant.DFT_INF_TAMNAO);

		USER_CPVO  userCpVO = new USER_CPVO();

		/*if(Constant.USER_CP_DIV_EPIL.equals(cpDiv)) { // 회원가입
			userCpVO.setDisAmt(dftInfVO.getUserRegCpAmt());
		} else if(Constant.USER_CP_DIV_UEPI.equals(cpDiv)) { // 이용후기
			userCpVO.setDisAmt(dftInfVO.getUseEpilCpAmt());
		} else if(Constant.USER_CP_DIV_UAPP.equals(cpDiv)) { // App 다운로드
			userCpVO.setDisAmt(dftInfVO.getAppRegCpAmt());
		} else if(Constant.USER_CP_DIV_VIMO.equals(cpDiv)) { // 재방문
			userCpVO.setDisAmt(2000);
		} else if(Constant.USER_CP_DIV_ACNR.equals(cpDiv)) { // 실시간 상품 자동 취소
			userCpVO.setDisPct("2");
		} else if(Constant.USER_CP_DIV_ACNV.equals(cpDiv)) { // 제주특산/기념품 상품 자동 취소
			userCpVO.setDisPct("3");
		}   
		userCpVO.setBuyMiniAmt(getBuyMiniAmt(userCpVO.getDisAmt(), dftInfVO.getDisMaxiPct()));
		userCpVO.setUseYn(Constant.FLAG_N);*/
		// 쿠폰 유효일
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar calendar = Calendar.getInstance();
		userCpVO.setExprStartDt(sdf.format(calendar.getTime()));
		
		if(Constant.USER_CP_DIV_ACNR.equals(cpDiv) || Constant.USER_CP_DIV_ACNV.equals(cpDiv)) {
			calendar.add(Calendar.DATE, 1);
		} else {
			calendar.add(Calendar.DATE, dftInfVO.getCpExprDayNum() - 1);
		}
		userCpVO.setExprEndDt(sdf.format(calendar.getTime()));

		return userCpVO;
	}

	public int getBuyMiniAmt(int disAmt , int disMaxiPct) {
		return disAmt * ( 100 / disMaxiPct);
	}

	@Override
	public List<USER_CPVO> selectCouponList(String userId) {
		return userCpDAO.selectCouponList(userId);
	}

	@Override
	public int getCntCpAppFirstLogin(USER_CPVO cpVO) {
		return userCpDAO.getCntCpAppFirstLogin(cpVO);
	}

	
	/**
	 * 사용자 쿠폰 발급
	 * 파일명 : cpPublish
	 * 작성일 : 2018. 8. 27. 오후 4:53:31
	 * 작성자 : 최영철
	 * @param userId	사용자 아이디
	 * @param cpId		쿠폰 아이디
	 */
	@Override
	public void cpPublish(String userId, String cpId) {
		
		CPVO cpVO = new CPVO();
		cpVO.setCpId(cpId);
		
		// 쿠폰 정보 조회
		cpVO = couponDAO.selectByCoupon(cpVO);
		
		if(cpVO != null){
			USER_CPVO userCpVO = new USER_CPVO();

			userCpVO.setUserId(userId);
			userCpVO.setCpDiv(Constant.USER_CP_DIV_AEVT);		// AEVT : 탐나오 쿠폰 - 관리자가 직접 생성한 쿠폰)
			userCpVO.setCpNm(cpVO.getCpNm());
			userCpVO.setDisAmt(cpVO.getDisAmt());
			userCpVO.setBuyMiniAmt(cpVO.getBuyMiniAmt());
			userCpVO.setExprStartDt(cpVO.getAplStartDt());
			userCpVO.setExprEndDt(cpVO.getAplEndDt());
			userCpVO.setCpId(cpVO.getCpId());
			userCpVO.setDisDiv(cpVO.getDisDiv());
			userCpVO.setDisPct(cpVO.getDisPct());
			userCpVO.setAplprdtDiv(cpVO.getAplprdtDiv());
			userCpVO.setLimitAmt(cpVO.getLimitAmt());
			userCpVO.setUseYn(Constant.FLAG_N);
			
			userCpDAO.insertUserCoupon(userCpVO);

			// 쿠폰 발급 수 + 1
			couponDAO.updateCouponUseNum(cpVO);
		}
	}

	// 사용자 쿠폰 수정
	@Override
	public void updateUserCp(USER_CPVO userCpVO) {
		userCpDAO.updateUserCoupon(userCpVO);
	}

	// 사용자 아이디, 쿠폰 아이디로 조회
	public USER_CPVO selectUserCpByCpIdUserId(USER_CPVO userCpVO) {
		return userCpDAO.selectUserCpByCpIdUserId(userCpVO);
	}

	// 사용자 아이디, 쿠폰 아이디로 조회
	public Integer selectUseCpNum(USER_CPVO userCpVO) {
		return userCpDAO.selectUseCpNum(userCpVO);
	}
	
	// 사용자 아이디, 쿠폰 아이디로 발급갯수
	public int selectUserCpByCpIdUserIdCnt(USER_CPVO userCpVO) {
		return userCpDAO.selectUserCpByCpIdUserIdCnt(userCpVO);
	}
	
	//자동쿠폰발행
	@Override
	public void baapCpPublish(RSVVO rsvInfo) {
		/** 쿠폰리스트 */
		List<CPVO> cpList = couponDAO.selectCouponListAuto(Constant.USER_CP_DIV_BAAP);
		
		/** 쿠폰리스트가 있는 경우*/
		if(cpList != null) {
			/** 회원가입일 경우*/
			String userId = rsvInfo.getUserId();
			if(userId != "GUEST" && userId != "") {
				/** 구매리스트 */
				List<ORDERVO> orderList = webOrderDAO.selectOrderList(rsvInfo);
				for(CPVO cp : cpList) {
					for(ORDERVO order : orderList) {
						boolean isPublish = false;

						/** 사용한 쿠폰아이디와 연계쿠폰아이디가 동일하면 발급*/
						if (cp.getrCpId() !=null && order.getCpId() !=null && cp.getrCpId().equals(order.getCpId())) {
							isPublish = true;
						/** 자동발급 쿠폰  */
						}else if(cp.getBuyCtgrList() != null && order.getPrdtCd() !=null && cp.getBuyCtgrList().contains(order.getPrdtCd())){
							isPublish = true;
						}
						if(isPublish){

							USER_CPVO userCpVO = new USER_CPVO();
							userCpVO.setUserId(userId);
							userCpVO.setCpDiv(cp.getCpDiv());
							userCpVO.setExprStartDt(cp.getAplStartDt());
							userCpVO.setExprEndDt(cp.getAplEndDt());
							userCpVO.setCpId(cp.getCpId());
							userCpVO.setCpNm(cp.getCpNm());
							userCpVO.setDisAmt(cp.getDisAmt());
							userCpVO.setDisPct(cp.getDisPct());
							userCpVO.setDisDiv(cp.getDisDiv());
							userCpVO.setBuyMiniAmt(cp.getBuyMiniAmt());
							userCpVO.setAplprdtDiv(cp.getAplprdtDiv());
							userCpVO.setLimitAmt(cp.getLimitAmt());

							/** 승마전용 사용 시 특수쿠폰 처리 (숙소,관광지) */
							if(order.getCpNm().contains("승마전용")){
								
								/** 숙소 쿠폰은 한도변경*/
								if(cp.getPrdtCtgrList().equals("AD")){
									userCpVO.setLimitAmt(cp.getLimitAmt());
									int tempLimitAmt = userCpVO.getLimitAmt();
									int tempQty = Integer.parseInt(order.getPrdtCnt());
									if(tempQty > 4){
										tempQty = 4;
									}
									userCpVO.setLimitAmt(tempLimitAmt * tempQty);
								/** 관광지 쿠폰은 갯수만큼 쿠폰발급*/
								}else if(cp.getPrdtCtgrList().equals("C200")){
									int tempQty = Integer.parseInt(order.getPrdtCnt());
									if(tempQty > 4){
										tempQty = 4;
									}

									for(int i=0; i < tempQty; ++i ){
										userCpDAO.insertUserCoupon(userCpVO);
									}
								}
							}


							/** 가입이력 기준, 쿠폰별 한번만 발급 */
							int cpPublishCnt = userCpDAO.selectUserCpByCpIdUserIdCnt(userCpVO);
							if (cpPublishCnt == 0) {
								userCpDAO.insertUserCoupon(userCpVO);
								continue;
							}

							/** 쿠폰한번 체크 시 break */
							break;
						}
					}
				}
			}
		}
	}

	@Override
	public USER_CPVO selectCpInfoValidate(USER_CPVO userCpVO) {
		USER_CPVO userCpvo = userCpDAO.selectCpInfoValidate(userCpVO);
		return userCpvo;
	}

	@Override
	public List<LowerHashMap> selectUsedRCpList(USER_CPVO userCpVO) {
		List<LowerHashMap> userCpvo = userCpDAO.selectUsedRCpList(userCpVO);
		return userCpvo;
	}
}