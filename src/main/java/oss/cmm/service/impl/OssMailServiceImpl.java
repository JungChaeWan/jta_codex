package oss.cmm.service.impl;

import common.Constant;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rsv.service.impl.RsvDAO;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.tools.generic.DateTool;
import org.apache.velocity.tools.generic.NumberTool;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.vdurmont.emoji.EmojiParser;

import oss.ad.vo.AD_WEBLIST2VO;
import oss.ad.vo.AD_WEBLISTSVO;
import oss.ad.vo.AD_WEBLISTVO;
import oss.cmm.service.OssMailService;
import oss.cmm.vo.EMAILVO;
import oss.cmm.vo.MAILVO;
import oss.corp.service.impl.CorpDAO;
import oss.corp.vo.CORPVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.service.impl.CouponDAO;
import oss.coupon.vo.CPPRDTVO;
import oss.coupon.vo.CPVO;
import oss.otoinq.vo.OTOINQVO;
import oss.site.vo.MAINCTGRRCMDVO;
import oss.user.service.impl.UserDAO;
import oss.user.vo.USERVO;
import web.main.service.impl.WebMainDAO;
import web.order.service.WebOrderService;
import web.order.service.impl.WebOrderDAO;
import web.order.vo.ORDERVO;
import web.order.vo.RSVVO;
import web.order.vo.SV_RSVVO;
import web.product.service.*;
import web.product.vo.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Map.Entry;

@Service("ossMailService")
public class OssMailServiceImpl implements OssMailService{

	Logger log = LogManager.getLogger(this.getClass());

	@Resource(name="velocityEngine")
	private VelocityEngine velocityEngine;

	@Resource(name="mailDAO")
	private MailDAO mailDAO;
	
	@Resource(name="userDAO")
	private UserDAO userDAO;

	@Resource(name = "corpDAO")
	private CorpDAO corpDAO;

	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;
	
	@Resource(name = "webMainDAO")
	private WebMainDAO webMainDAO;

	@Resource(name="couponDAO")
	private CouponDAO couponDAO;

	@Resource(name="masRcPrdtService")
	private MasRcPrdtService masRcPrdtService;

	@Resource(name = "webOrderDAO")
	private WebOrderDAO webOrderDAO;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "webOrderService")
	protected WebOrderService webOrderService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name = "webSvService")
	protected WebSvProductService webSvService;
	
	@Resource(name="ossCouponService")
    private OssCouponService ossCouponService;
	
	@Resource(name = "webPrmtService")
	protected WebPrmtService webPrmtService;



	/**
	 * 회원가입
	 */
	@Override
	public void sendRegUser(USERVO user,
							String recipient,
							HttpServletRequest request) {
		log.info("sendRegUser call");

		String url = EgovProperties.getProperty("Globals.Web");

		MAILVO mailVO = new MAILVO();
		mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
		mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
		mailVO.setUserInfo(recipient);
		mailVO.setEmail(recipient);
		mailVO.setUserId(recipient);
		mailVO.setTitle("[탐나오] 회원가입을 축하드립니다.");
		mailVO.setEventId("3"); // 회원가입

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("numberTool", new NumberTool());
		model.put("dateTool", new DateTool());
        model.put("domain", url);
		model.put("user", user);

        String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/regUser.vm", "UTF-8", model);
        if(text != null) {
            mailVO.setContent(EmojiParser.removeAllEmojis(text));
            mailDAO.insertMail(mailVO);
        }
	}

	/**
	 * 휴면 예정 고객 자동 메일 발송 (휴면 처리 7일전)
	 * Function : restUserPrevSendMail
	 * 작성일 : 2018. 3. 9. 오후 1:54:24
	 * 작성자 : 정동수
	 */
	@Override
	public void restUserPrevSendMail() {
		log.info("restUserPrevSendMail call");

		String url = EgovProperties.getProperty("Globals.Web");

		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, 7);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		String restDate = sdf.format(calendar.getTime());

		// 휴면 예정 7일전 회원 리스트
		List<USERVO> restList = userDAO.selectRestUserPrevList();

		for(USERVO user : restList) {
			if(EgovStringUtil.isEmpty(user.getEmail())) {
				continue;
			}
			MAILVO mailVO = new MAILVO();
			mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
			mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
			mailVO.setUserInfo(user.getEmail());
			mailVO.setEmail(user.getEmail());
			mailVO.setUserId(user.getEmail());
			mailVO.setTitle("[탐나오] 계정 휴면전환 예정일 안내 입니다.");
			mailVO.setEventId("15");

			Map<String, Object> model = new HashMap<String, Object>();
			model.put("numberTool", new NumberTool());
			model.put("dateTool", new DateTool());
			model.put("domain", url);
			model.put("restDate", restDate);
			model.put("email", user.getEmail());

			String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/restUserPrevSendMail.vm", "UTF-8", model);
			if(text != null) {
				mailVO.setContent(EmojiParser.removeAllEmojis(text));
				mailDAO.insertMail(mailVO);
			}
		}
	}

	/**
	 * 휴면 대상 고객 자동 메일 발송
	 * Function : restUserTargetSendMail
	 * 작성일 : 2018. 3. 9. 오후 2:42:04
	 * 작성자 : 정동수
	 */
	@Override
	public void restUserTargetSendMail() {
		log.info("restUserTargetSendMail call");

		String url = EgovProperties.getProperty("Globals.Web");

		// 휴면 대상 회원 리스트
		List<USERVO> restList = userDAO.selectRestUserTargetList();

		for(USERVO user : restList) {
			if(EgovStringUtil.isEmpty(user.getEmail())) {
				continue;
			}
			MAILVO mailVO = new MAILVO();
			mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
			mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
			mailVO.setUserInfo(user.getEmail());
			mailVO.setEmail(user.getEmail());
			mailVO.setUserId(user.getEmail());
			mailVO.setTitle("[탐나오] 계정 휴면전환 안내 입니다.");
			mailVO.setEventId("15");

			Map<String, Object> model = new HashMap<String, Object>();
			model.put("numberTool", new NumberTool());
			model.put("dateTool", new DateTool());
			model.put("domain", url);
			model.put("email", user.getEmail());

			String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/restUserTargetSendMail.vm", "UTF-8", model);
			if(text != null) {
				mailVO.setContent(EmojiParser.removeAllEmojis(text));
				mailDAO.insertMail(mailVO);
			}
		}
		// 휴면 대상 회원의 휴면 처리
		userDAO.updateRestUserTarget();
	}

	/**
	 * 방문 10개월된 고객 자동 메일 발송
	 * Function : visit10MonthSendMail
	 * 작성일 : 2018. 3. 12. 오후 1:46:03
	 * 작성자 : 정동수
	 */
	@Override
	public void visit10MonthSendMail() {
		/* 미사용
		log.info("visit10MonthSendMail call");

		String url = EgovProperties.getProperty("Globals.Web");

		// 재방문 쿠폰
		List<CPVO> cpList = couponDAO.selectCouponListAuto(Constant.USER_CP_DIV_VIMO);

		// 방문 10개월된 고객 리스트
		List<USERVO> month10List = userDAO.visit10MonthSendMail();

		for(USERVO user : month10List) {
			if(EgovStringUtil.isEmpty(user.getEmail())) {
				continue;
			}
			MAILVO mailVO = new MAILVO();
			mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
			mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
			mailVO.setUserInfo(user.getEmail());
			mailVO.setEmail(user.getEmail());
			mailVO.setUserId(user.getEmail());
			mailVO.setTitle("[탐나오] 방문하신지 10개월이 됐습니다.");
			mailVO.setEventId("15");

			Map<String, Object> model = new HashMap<String, Object>();
			model.put("numberTool", new NumberTool());
			model.put("dateTool", new DateTool());
			model.put("domain", url);
			model.put("email", user.getEmail());
			model.put("cp", cpList.get(0));

			String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/visit10MonthSendMail.vm", "UTF-8", model);
			if(text != null) {
				mailVO.setContent(EmojiParser.removeAllEmojis(text));
				mailDAO.insertMail(mailVO);
			}
		}
		*/
	}

	/**
	 * 여행 7일전 자동 메일 발송
	 * Function : tourPrev7SendMail
	 * 작성일 : 2018. 3. 8. 오후 1:45:03
	 * 작성자 : 정동수
	 */
	@Override
	public void tourPrev7SendMail() {
		log.info("tourPrev7SendMail call");

		String url = EgovProperties.getProperty("Globals.Web");

		// 여행 7일전 추천 상품
		List<MAINCTGRRCMDVO> prev7CtgrRcmdList = webMainDAO.selectPrevMailCtgrRcmdList();

		// 여행 7일전 예약건의 메일 리스트
		List<ORDERVO> mailList = rsvDAO.selectTourPrev7MailList();

		// 여행 7일전 예약 리스트
		List<ORDERVO> rsvList = rsvDAO.selectTourPrev7RsvList();

		for(ORDERVO mail : mailList) {
			if(StringUtils.isEmpty(mail.getUseEmail())) {
				continue;
			}
			List<ORDERVO> selRsvList = new ArrayList<ORDERVO>();

			for(ORDERVO rsv : rsvList) {
				if(rsv.getUserId().equals(mail.getUserId())) {
					selRsvList.add(rsv);
				}
			}
			MAILVO mailVO = new MAILVO();
			mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
			mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
			mailVO.setUserInfo(mail.getUseEmail());
			mailVO.setEmail(mail.getUseEmail());
			mailVO.setUserId(mail.getUseEmail());
			mailVO.setTitle("[탐나오] 즐거운 제주여행 출발 7일 전입니다.");
			mailVO.setEventId("15");

			Map<String, Object> model = new HashMap<String, Object>();
			model.put("numberTool", new NumberTool());
			model.put("dateTool", new DateTool());
			model.put("domain", url);
			model.put("rsvList", selRsvList);
			model.put("ctgrRcmdList", prev7CtgrRcmdList);

			String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/tourPrev7SendMail.vm", "UTF-8", model);
			if(text != null) {
				mailVO.setContent(EmojiParser.removeAllEmojis(text));
				mailDAO.insertMail(mailVO);
			}
		}
	}

	/**
	 * 실시간/제주특산/기념품 상품 자동취소시 쿠폰발행에 대한 메일 발송
	 * Function : autoCancelCouponSendMail
	 * 작성일 : 2018. 3. 13. 오전 11:06:18
	 * 작성자 : 정동수
	 * @param email
	 * @param cpDiv
	 */
	@Override
	public void autoCancelCouponSendMail(String email,
										 String cpDiv) {
		log.info("autoCancelCouponSendMail call");

		String url = EgovProperties.getProperty("Globals.Web");

		String autoCancelVm;

		MAILVO mailVO = new MAILVO();
		mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
		mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
		mailVO.setUserInfo(email);
		mailVO.setEmail(email);
		mailVO.setUserId(email);

		if(Constant.USER_CP_DIV_ACNR.equals(cpDiv)) {
			autoCancelVm = "acnrCoupon";
			mailVO.setTitle("[탐나오] 제주 여행을 계획중이신가요?");
		} else {
			autoCancelVm = "acnvCoupon";
			mailVO.setTitle("[탐나오] 집에서 제주를 느껴보세요!");
		}
		mailVO.setEventId("15");

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("numberTool", new NumberTool());
		model.put("dateTool", new DateTool());
		model.put("domain", url);

		String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/" + autoCancelVm + "SendMail.vm", "UTF-8", model);
		if(text != null) {
			mailVO.setContent(EmojiParser.removeAllEmojis(text));
			mailDAO.insertMail(mailVO);
		}
	}

	/**
	 * 예약/구매 완료
	 */
	@Override
	public void sendOrderComplete(RSVVO rsvInfo,
								  List<ORDERVO> orderList,
								  HttpServletRequest request) {
		log.info("sendOrderComplete call");

		if(StringUtils.isEmpty(rsvInfo.getRsvEmail())) {
			return;
		}
		String url = EgovProperties.getProperty("Globals.Web");

		if(StringUtils.isEmpty(rsvInfo.getUseEmail())) {
			rsvInfo.setUseEmail(rsvInfo.getRsvEmail());
		}
		MAILVO mailVO = new MAILVO();
		mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
		mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
		mailVO.setUserInfo(rsvInfo.getRsvEmail());
		mailVO.setEmail(rsvInfo.getRsvEmail());
		mailVO.setUserId(rsvInfo.getRsvEmail());
		mailVO.setEventId("6"); // 판매

		List<String> prdtCdList = new ArrayList<String>();
		List<String> rsvPrdtNumList = new ArrayList<String>();
		Map<String, RC_PRDTINFVO> rcPrdtInfMap = new HashMap<String, RC_PRDTINFVO>();

		for(ORDERVO ordervo : orderList) {
			prdtCdList.add(ordervo.getPrdtCd());

			if(Constant.SP_PRDT_DIV_COUP.equals(ordervo.getPrdtDiv())) {
				rsvPrdtNumList.add(ordervo.getPrdtNum());
			}
			if(Constant.RENTCAR.equals(ordervo.getPrdtCd())) {
				// 예약 렌터카 상품 정보
				RC_PRDTINFVO prdtInfVO = new RC_PRDTINFVO();
				prdtInfVO.setPrdtNum(ordervo.getPrdtNum());

				RC_PRDTINFVO rcPrdt = masRcPrdtService.selectByPrdt(prdtInfVO);

				rcPrdtInfMap.put(ordervo.getPrdtNum(), rcPrdt);
			}
		}

		// 추천 상품
		String[] prdtCdArr = prdtCdList.toArray(new String[prdtCdList.size()]);
		/*String rcmdTitle;
		List<PRMTPRDTVO> rcmdPrdtList = new ArrayList<PRMTPRDTVO>();

		if(Arrays.asList(prdtCdArr).contains(Constant.RENTCAR) == true && Arrays.asList(prdtCdArr).contains(Constant.ACCOMMODATION) == false) {
			// 예약 상품에 '렌터카' 포함되고 '숙박' 상품이 포함되지 않으면...
			rcmdTitle = "숙박은 예약하셨나요?";
			List<AD_WEBLISTVO> bestList = webAdProductService.selectAdBestList();

			for(AD_WEBLISTVO data : bestList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("AD");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setData(data);

				rcmdPrdtList.add(prmt);
			}
		} else if(Arrays.asList(prdtCdArr).contains(Constant.ACCOMMODATION) == true && Arrays.asList(prdtCdArr).contains(Constant.RENTCAR) == false) {
			// 예약 상품에 '숙박' 포함되고 '렌터카' 상품이 포함되지 않으면...
			rcmdTitle = "렌터카는 예약하셨나요?";

			List<RC_PRDTINFVO> bestList = webRcProductService.selectRcBestPrdtList();

			for(RC_PRDTINFVO data : bestList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("RC");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setData(data);

				rcmdPrdtList.add(prmt);
			}
		} else {
			// 관광지/레저 맛집 뷰티 상품 추천
			rcmdTitle = "이런 곳은 어떠세요?";

			// 베스트 상품.
			List<WEB_SPPRDTVO> bestCouponList = webSpService.selectBestProductList("C200", "1", rsvPrdtNumList);
			List<WEB_SPPRDTVO> bestBeautyList = webSpService.selectBestProductList("C300", "1", rsvPrdtNumList);

			List<WEB_SPPRDTVO> bestList = new ArrayList<WEB_SPPRDTVO>();
			bestList.addAll(bestCouponList);
			bestList.addAll(bestBeautyList);

			Collections.shuffle(bestList);

			for(WEB_SPPRDTVO data : bestList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("SP");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setData(data);

				rcmdPrdtList.add(prmt);
			}
		}*/

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("numberTool", new NumberTool());
		model.put("dateTool", new DateTool());
		model.put("domain", url);
		model.put("rsvInfo", rsvInfo);
		model.put("orderList", orderList);
		model.put("rcPrdtInfMap", rcPrdtInfMap);
		/*model.put("rcmdTitle", rcmdTitle);
		model.put("rcmdPrdtList", rcmdPrdtList);*/

		String text;
		// 구매한 상품이 기념품일 경우 메일 title 변경
		if(Arrays.asList(prdtCdArr).contains(Constant.SV) == true) {
			mailVO.setTitle("[탐나오] 상품 구매 완료");
			text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/orderComplete2.vm", "UTF-8", model);
		} else {
			mailVO.setTitle("[탐나오] 상품 예약 완료");
			text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/orderComplete.vm", "UTF-8", model);
		}
		
		if(text != null) {
			mailVO.setContent(EmojiParser.removeAllEmojis(text));
			mailDAO.insertMail(mailVO);
		}
	}

	/**
	 * 예약/구매 취소요청
	 */
	@Override
	public void sendCancelRequest(RSVVO rsvInfo,
								  List<ORDERVO> orderList,
								  HttpServletRequest request) {
		log.info("sendCancelRequest call");

		if(StringUtils.isEmpty(rsvInfo.getRsvEmail())) {
			return;
		}
		String url = EgovProperties.getProperty("Globals.Web");

		MAILVO mailVO = new MAILVO();
		mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
		mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
		mailVO.setUserInfo(rsvInfo.getRsvEmail());
		mailVO.setEmail(rsvInfo.getRsvEmail());
		mailVO.setUserId(rsvInfo.getRsvEmail());
		mailVO.setEventId("11"); // 예약 취소요청

		List<String> prdtCdList = new ArrayList<String>();
		List<String> rsvPrdtNumList = new ArrayList<String>();

		for(ORDERVO ordervo : orderList) {
			prdtCdList.add(ordervo.getPrdtCd());

			if(Constant.SP_PRDT_DIV_COUP.equals(ordervo.getPrdtDiv())) {
				rsvPrdtNumList.add(ordervo.getPrdtNum());
			}
		}

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("numberTool", new NumberTool());
		model.put("dateTool", new DateTool());
		model.put("domain", url);
		model.put("rsvInfo", rsvInfo);
		model.put("orderList", orderList);

		String text;

		if(Constant.SV.equals(orderList.get(0).getRsvNum().substring(0, 2))) {
			mailVO.setTitle("[탐나오] 구매상품 취소요청");
			text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/cancelReq2.vm", "UTF-8", model);
		} else {
			mailVO.setTitle("[탐나오] 예약상품 취소요청");
			text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/cancelReq.vm", "UTF-8", model);
		}
		
		if(text != null) {
			mailVO.setContent(EmojiParser.removeAllEmojis(text));
			mailDAO.insertMail(mailVO);
		}

		// 업체에 Email 발송
		sendCancelRequestCorp(rsvInfo, orderList, request);
	}

	/**
	 * 취소처리 완료
	 */
	@Override
	public void sendCancelRsvAuto(RSVVO rsvInfo,
								  ORDERVO orderVO,
								  HttpServletRequest request) {
		log.info("sendCancelRsvAuto call");

		if(StringUtils.isEmpty(rsvInfo.getRsvEmail())) {
			return;
		}
		String url = EgovProperties.getProperty("Globals.Web");

		MAILVO mailVO = new MAILVO();
		mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
		mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
		mailVO.setUserInfo(rsvInfo.getRsvEmail());
		mailVO.setEmail(rsvInfo.getRsvEmail());
		mailVO.setUserId(rsvInfo.getRsvEmail());
		mailVO.setTitle("[탐나오] 상품의 취소처리 완료");
		mailVO.setEventId("12"); // 예약 결제취소(자동구매취소)

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("numberTool", new NumberTool());
		model.put("dateTool", new DateTool());
		model.put("domain", url);
		model.put("rsvInfo", rsvInfo);
		model.put("orderVO", orderVO);

		String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/cancelRsv.vm", "UTF-8", model);
		if(text != null) {
			mailVO.setContent(EmojiParser.removeAllEmojis(text));
			mailDAO.insertMail(mailVO);
		}
	}

	/**
	 * 환불처리 완료
	 */
	@Override
	public void sendRefundComplete(RSVVO rsvInfo,
								   ORDERVO orderVO,
								   HttpServletRequest request) {
		log.info("sendreFundComplete call");

		if(StringUtils.isEmpty(rsvInfo.getRsvEmail())) {
			return;
		}
		String url = EgovProperties.getProperty("Globals.Web");

		MAILVO mailVO = new MAILVO();
		mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
		mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
		mailVO.setUserInfo(rsvInfo.getRsvEmail());
		mailVO.setEmail(rsvInfo.getRsvEmail());
		mailVO.setUserId(rsvInfo.getRsvEmail());
		mailVO.setTitle("[탐나오] 상품의 환불처리 완료");
		mailVO.setEventId("13"); // 환불완료 (자동구매취소)

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("numberTool", new NumberTool());
		model.put("dateTool", new DateTool());
		model.put("domain", url);
		model.put("rsvInfo", rsvInfo);
		model.put("order", orderVO);

		String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/refundComplete.vm", "UTF-8", model);
		if(text != null) {
			mailVO.setContent(EmojiParser.removeAllEmojis(text));
			mailDAO.insertMail(mailVO);
		}
	}

	/**
	 * 사용 완료된 예약건에 자동 메일 발송
	 * Function : useCompleteSendMailAcc
	 * 작성일 : 2016. 11. 11. 오전 11:58:56
	 * 작성자 : 정동수
	 */
	@Override
	public void useCompleteSendMailAcc() {
		log.info("useCompleteSendMailAcc call");

		String url = EgovProperties.getProperty("Globals.Web");

		// 완료된 예약건의 메일 리스트
		List<ORDERVO> mailList = rsvDAO.selectUseCompleteMailList();

		// 추천 기념품 상품
		MAINCTGRRCMDVO mainctgrrcmdVO = new MAINCTGRRCMDVO();
		mainctgrrcmdVO.setPrdtDiv(Constant.SV);

		List<MAINCTGRRCMDVO> bestList = webMainDAO.selectMainCtgrRcmdList(mainctgrrcmdVO);

		for(ORDERVO mail : mailList) {
			if(StringUtils.isEmpty(mail.getUseEmail())) {
				continue;
			}
			MAILVO mailVO = new MAILVO();
			mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
			mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
			mailVO.setUserInfo(mail.getUseEmail());
			mailVO.setEmail(mail.getUseEmail());
			mailVO.setUserId(mail.getUseEmail());
			mailVO.setTitle("[탐나오] 즐거운 제주여행이 되셨습니까?");
			mailVO.setEventId("15");

			Map<String, Object> model = new HashMap<String, Object>();
			model.put("numberTool", new NumberTool());
			model.put("dateTool", new DateTool());
			model.put("domain", url);
			model.put("ctgrRcmdList", bestList);

			String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/useComplete.vm", "UTF-8", model);
			if(text != null) {
				mailVO.setContent(EmojiParser.removeAllEmojis(text));
				mailDAO.insertMail(mailVO);
			}
		}
	}

	/**
	 * 상품발송 완료
	 */
	@Override
	public void sendDeliveryComplete(SV_RSVVO rsvInfo,
									 ORDERVO orderVO,
									 HttpServletRequest request) {
		log.info("sendDeliveryComplete call");

		if(StringUtils.isEmpty(rsvInfo.getRsvEmail())) {
			return;
		}
		String url = EgovProperties.getProperty("Globals.Web");

		if(rsvInfo.getDlvRequestInf() == null) {
			rsvInfo.setDlvRequestInf("");
		}
		MAILVO mailVO = new MAILVO();
		mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
		mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));

		if("test".equals(EgovProperties.getProperty("CST_PLATFORM"))) {
			mailVO.setUserInfo("wotjdaka@naver.com");
			mailVO.setEmail("wotjdaka@naver.com");
			mailVO.setUserId("wotjdaka@naver.com");
		} else {
			mailVO.setUserInfo(rsvInfo.getRsvEmail());
			mailVO.setEmail(rsvInfo.getRsvEmail());
			mailVO.setUserId(rsvInfo.getRsvEmail());
		}

		mailVO.setTitle("[탐나오] 상품 발송 완료");
		mailVO.setEventId("18"); // 상품 발송 완료

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("numberTool", new NumberTool());
		model.put("dateTool", new DateTool());
		model.put("domain", url);
		model.put("rsvInfo", rsvInfo);
		model.put("order", orderVO);

		String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/deliveryComplete.vm", "UTF-8", model);
		if(text != null) {
			mailVO.setContent(EmojiParser.removeAllEmojis(text));
			mailDAO.insertMail(mailVO);
		}
	}

	/**
	 * 입점 승인
	 */
	@Override
	public void sendCorpAppro(CORPVO corpVO,
							  HttpServletRequest request) {
		log.info("sendCorpAppro call");

		if(StringUtils.isEmpty(corpVO.getAdmEmail())) {
			return;
		}
		String url = EgovProperties.getProperty("Globals.Web");

		MAILVO mailVO = new MAILVO();
		mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
		mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
		mailVO.setUserInfo(corpVO.getAdmEmail());
		mailVO.setEmail(corpVO.getAdmEmail());
		mailVO.setUserId(corpVO.getAdmEmail());
		mailVO.setTitle("[탐나오] 마켓 입점 승인을 축하드립니다.");
		mailVO.setEventId("4"); // 입점업체 승인

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("numberTool", new NumberTool());
		model.put("dateTool", new DateTool());
        model.put("domain", url);
		model.put("corpId", corpVO.getCorpId());

        String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/corpAppro.vm", "UTF-8", model);
        if(text != null) {
            mailVO.setContent(EmojiParser.removeAllEmojis(text));
            mailDAO.insertMail(mailVO);
        }
	}

	/**
	 * 예약/구매 완료(업체)
	 */
	@Override
	public void sendOrderCompleteCorp(RSVVO rsvInfo,
									  List<ORDERVO> orderList,
									  HttpServletRequest request) {
		log.info("sendOrderCompleteCorp call");

		if(StringUtils.isEmpty(rsvInfo.getRsvEmail())) {
			return;
		}
		String url = EgovProperties.getProperty("Globals.Web");

		if(StringUtils.isEmpty(rsvInfo.getUseEmail())) {
			rsvInfo.setUseEmail(rsvInfo.getRsvEmail());
		}

		List<ORDERVO> orderList2 = new ArrayList<ORDERVO>();
		List<String> compareCorpId = new ArrayList<String>();

		for(ORDERVO order : orderList) {
			CORPVO corpVO = new CORPVO();
			corpVO.setCorpId(order.getCorpId());
			/** 같은업체ID일 경우 첫번쨰 루프문만 통과 이후에는 continue */
			boolean sameWord = false;
			for(String tempCorp : compareCorpId  ){
				if(tempCorp.equals(order.getCorpId())){
					sameWord = true;
					break;
				}
			}
			if(sameWord){
				continue;
			}
			compareCorpId.add(order.getCorpId());

			/** 같은업체ID의 상품정보 List Up*/
			for(ORDERVO order2 : orderList){
				if(order2.getCorpId().equals(order.getCorpId())){
					orderList2.add(order2);
				}
			}

			CORPVO corpRes = corpDAO.selectByCorp(corpVO);

			if(StringUtils.isEmpty(corpRes.getAdmEmail())) {
				orderList2.clear();
				continue;
			}
			MAILVO mailVO = new MAILVO();
			mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
			mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
			
			if("test".equals(EgovProperties.getProperty("CST_PLATFORM"))) {
				mailVO.setUserInfo("wotjdaka@naver.com"); //jta8866@gmail.com
				mailVO.setEmail("wotjdaka@naver.com");
				mailVO.setUserId("wotjdaka@naver.com");
			} else {
				mailVO.setUserInfo(corpRes.getAdmEmail());
				mailVO.setEmail(corpRes.getAdmEmail());
				mailVO.setUserId(corpRes.getAdmEmail());
			}
			mailVO.setEventId("6"); // 판매

			Map<String, Object> model = new HashMap<String, Object>();
			model.put("numberTool", new NumberTool());
			model.put("dateTool", new DateTool());
	        model.put("domain", url);
			model.put("rsvInfo", rsvInfo);
			model.put("orderList2", orderList2);
			model.put("corpRes", corpRes);

	        // 구매한 상품이 기념품일 경우 메일 title 변경
	        String text;

	        if(Constant.SV.equals(corpRes.getCorpCd())) {
				mailVO.setTitle("[탐나오] 상품 구매 완료" + "-" + corpRes.getCorpNm());
	 			text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/orderCompleteCorp2.vm", "UTF-8", model);
	 		} else {
	 			mailVO.setTitle("[탐나오] 상품 예약 완료"  + "-" + corpRes.getCorpNm());
	 			text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/orderCompleteCorp.vm", "UTF-8", model);
	 		}
	        
	        if(text != null) {
		        mailVO.setContent(EmojiParser.removeAllEmojis(text));
		        mailDAO.insertMail(mailVO);
	        }

			/* 23.02.10 이메일2 메일전송 (정채완) */
	        if(corpRes.getAdmEmail2()!=null || StringUtils.isNotEmpty(corpRes.getAdmEmail2())) {
				if("test".equals(EgovProperties.getProperty("CST_PLATFORM"))) {
					mailVO.setUserInfo("2002worldcup@gmail.com");
					mailVO.setEmail("2002worldcup@gmail.com");
					mailVO.setUserId("2002worldcup@gmail.com");
				} else {
					mailVO.setUserInfo(corpRes.getAdmEmail2());
					mailVO.setEmail(corpRes.getAdmEmail2());
					mailVO.setUserId(corpRes.getAdmEmail2());
				}
				
		        mailDAO.insertMail(mailVO);
	        }
			orderList2.clear();
		}
	}

	/**
	 * 예약/구매 취소처리 요청(업체)
	 */
	@Override
	public void sendCancelRequestCorp(RSVVO rsvInfo,
									  List<ORDERVO> orderList,
									  HttpServletRequest request) {
		log.info("sendCancelRequestCorp call");

		if(StringUtils.isEmpty(rsvInfo.getRsvEmail())) {
			return;
		}
		String url = EgovProperties.getProperty("Globals.Web");

		MAILVO mailVO = new MAILVO();
		mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
		mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
		mailVO.setEventId("11"); // 예약 취소요청

		Map<String, ORDERVO> corpPrdtMap = new HashMap<String, ORDERVO>();
		Map<String, CORPVO> corpInfoMap = new HashMap<String, CORPVO>();

		for(ORDERVO order : orderList) {
			CORPVO corpVO = new CORPVO();
			corpVO.setCorpId(order.getCorpId());

			CORPVO corpRes = corpDAO.selectByCorp(corpVO);

			if(StringUtils.isEmpty(corpRes.getAdmEmail())) {
				continue;
			}
			corpInfoMap.put(corpRes.getCorpId(), corpRes);
			corpPrdtMap.put(corpRes.getCorpId(), order);
		}

		for(Entry<String, ORDERVO> corpPrdt : corpPrdtMap.entrySet()) {
			if("test".equals(EgovProperties.getProperty("CST_PLATFORM"))) {
				mailVO.setUserInfo("jta8866@gmail.com");
				mailVO.setEmail("jta8866@gmail.com");
				mailVO.setUserId("jta8866@gmail.com");
			} else {
				mailVO.setUserInfo(corpInfoMap.get(corpPrdt.getKey()).getAdmEmail());
				mailVO.setEmail(corpInfoMap.get(corpPrdt.getKey()).getAdmEmail());
				mailVO.setUserId(corpInfoMap.get(corpPrdt.getKey()).getAdmEmail());
			}

			Map<String, Object> model = new HashMap<String, Object>();
			model.put("numberTool", new NumberTool());
			model.put("dateTool", new DateTool());
			model.put("domain", url);
			model.put("order", corpPrdt.getValue());
			model.put("rsvInfo", rsvInfo);

			String text;

			if(Constant.SV.equals(corpInfoMap.get(corpPrdt.getKey()).getCorpCd())) {
				mailVO.setTitle("[탐나오] 구매상품의 취소처리 요청" + "-" + corpInfoMap.get(corpPrdt.getKey()).getCorpNm());
				text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/cancelReqCorp2.vm", "UTF-8", model);
			} else {
				mailVO.setTitle("[탐나오] 예약상품의 취소처리 요청" + "-" + corpInfoMap.get(corpPrdt.getKey()).getCorpNm());
				text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/cancelReqCorp.vm", "UTF-8", model);
			}
			
			if(text != null) {
				mailVO.setContent(EmojiParser.removeAllEmojis(text));
				mailDAO.insertMail(mailVO);
			}

			/* 23.02.10 이메일2 메일전송 (정채완) */
			if(corpInfoMap.get(corpPrdt.getKey()).getAdmEmail2()!=null || StringUtils.isNotEmpty(corpInfoMap.get(corpPrdt.getKey()).getAdmEmail2())) {
				if("test".equals(EgovProperties.getProperty("CST_PLATFORM"))) {
					mailVO.setUserInfo("2002worldcup@gmail.com");
					mailVO.setEmail("2002worldcup@gmail.com");
					mailVO.setUserId("2002worldcup@gmail.com");
				} else {
					mailVO.setUserInfo(corpInfoMap.get(corpPrdt.getKey()).getAdmEmail2());
					mailVO.setEmail(corpInfoMap.get(corpPrdt.getKey()).getAdmEmail2());
					mailVO.setUserId(corpInfoMap.get(corpPrdt.getKey()).getAdmEmail2());
				}
				
		        mailDAO.insertMail(mailVO);
	        }			
		}
	}

	/**
	 * 1:1문의(업체)
	 */
	@Override
	public void sendOtoinqCorp(OTOINQVO otoinqVO,
							   String admEmail,
							   HttpServletRequest request) {
		log.info("sendOtoinqCorp call");

		if(StringUtils.isEmpty(admEmail)) {
			return;
		}
		String url = EgovProperties.getProperty("Globals.Web");

		MAILVO mailVO = new MAILVO();
		mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
		mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));

		if("test".equals(EgovProperties.getProperty("CST_PLATFORM"))) {
			mailVO.setUserInfo("jta8866@gmail.com");
			mailVO.setEmail("jta8866@gmail.com");
			mailVO.setUserId("jta8866@gmail.com");
		} else {
			mailVO.setUserInfo(admEmail);
			mailVO.setEmail(admEmail);
			mailVO.setUserId(admEmail);
		}
		mailVO.setTitle("[탐나오] 1:1 문의가 등록됐습니다.");
		mailVO.setEventId("19"); // 1:1 문의 등록

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("numberTool", new NumberTool());
		model.put("dateTool", new DateTool());
		model.put("domain", url);
		model.put("corpId", otoinqVO.getCorpId());

		String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/otoinqCorp.vm", "UTF-8", model);
		if(text != null) {
			mailVO.setContent(EmojiParser.removeAllEmojis(text));
			mailDAO.insertMail(mailVO);
		}
	}


	/**
	 * 전체/VIP/우수고객에 대한 메일 발송
	 * Function : vipBestUserSendMail
	 * 작성일 : 2018. 3. 12. 오후 4:57:32
	 * 작성자 : 정동수
	 * @param cpVO
	 * @throws ParseException
	 */
	@Override
	public void vipBestUserSendMail(CPVO cpVO) {
		log.info("vipBestUserSendMail call");

		String url = EgovProperties.getProperty("Globals.Web");
		// 쿠폰 정보
		CPVO cp = ossCouponService.selectByCoupon(cpVO);
		// 발급대상
		String tgtDiv = cp.getTgtDiv().trim();
		String vipBestVm;

		if("ALL".equals(tgtDiv)) {
			vipBestVm = "allUser";
		} else if("VIP".equals(tgtDiv)) {
			vipBestVm = "vipUser";
		} else {
			vipBestVm = "bestUser";
		}
		// 쿠폰 매핑 상품 정보 가져오기.
		List<CPPRDTVO> cpPrdtList = null;

		if(!"AP01".equals(cp.getAplprdtDiv())) {
			cpPrdtList = ossCouponService.selectCouponPrdtListWeb(cp);
		}
		// 대상 고객 리스트
		List<USERVO> vipBestList;

		if("ALL".equals(tgtDiv)) {
			vipBestList = userDAO.allSendMail();
		} else {
			vipBestList = userDAO.vipBestSendMail(cp.getCpId());
		}
		for(USERVO user : vipBestList) {
			if(EgovStringUtil.isEmpty(user.getEmail())) {
				continue;
			}
			MAILVO mailVO = new MAILVO();
			mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
			mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
			mailVO.setUserInfo(user.getEmail());
			mailVO.setEmail(user.getEmail());
			mailVO.setUserId(user.getEmail());
			mailVO.setTitle("[탐나오] 이벤트 쿠폰");
			mailVO.setEventId("15");

			Map<String, Object> model = new HashMap<String, Object>();
			model.put("numberTool", new NumberTool());
			model.put("dateTool", new DateTool());
			model.put("domain", url);
			model.put("cp", cp);
			model.put("cpPrdtList", cpPrdtList);
			model.put("email", user.getEmail());

			String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/" + vipBestVm + "SendMail.vm", "UTF-8", model);
			if(text != null) {
				mailVO.setContent(EmojiParser.removeAllEmojis(text));
				mailDAO.insertMail(mailVO);
			}
		}
	}

	/**
	 * 무료쿠폰
	 */
	@Override
	public void sendFreeCoupon(WEB_DTLPRDTVO product,
							   String recipient,
							   HttpServletRequest request) {
		log.info("sendFreeCoupon call");

		String url = EgovProperties.getProperty("Globals.Web");

		MAILVO mailVO = new MAILVO();
		mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
		mailVO.setSender(EgovProperties.getProperty("MAIL.SENDER"));
		mailVO.setUserInfo(recipient);
		mailVO.setEmail(recipient);
		mailVO.setUserId(recipient);
		mailVO.setTitle("[탐나오] "+ product.getPrdtNm() + " 무료쿠폰");
		mailVO.setEventId("2"); // 할인쿠폰(무료쿠폰) 2

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("numberTool", new NumberTool());
		model.put("dateTool", new DateTool());
		model.put("domain", url);
		model.put("prdt", product);

		String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/freeCoupon.vm", "UTF-8", model);
		if(text != null) {
			mailVO.setContent(EmojiParser.removeAllEmojis(text));
			mailDAO.insertMail(mailVO);
		}
	}

	/**
	 * 마케팅
	 */
	@Override
	public void sendEamils(EMAILVO emailVO,
						   HttpServletRequest request) {
		log.info("sendEamils call");

		String url = EgovProperties.getProperty("Globals.Web");

		for(String strEamil : emailVO.getEmailList() ) {
			if(StringUtils.isEmpty(strEamil)) {
				continue;
			}
			MAILVO mailVO = new MAILVO();
			mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
			mailVO.setSender(emailVO.getCallback());
			mailVO.setUserInfo(strEamil);
			mailVO.setEmail(strEamil);
			mailVO.setUserId(strEamil);
			mailVO.setTitle(emailVO.getSubject());
			mailVO.setEventId("15");

			Map<String, Object> model = new HashMap<String, Object>();
			model.put("numberTool", new NumberTool());
			model.put("dateTool", new DateTool());
			model.put("domain", url);
			model.put("msg", emailVO.getMsg());
			model.put("saveImg", emailVO.getSaveFileName());

			String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/sendEmails.vm", "UTF-8", model);
			if(text != null) {
				mailVO.setContent(EmojiParser.removeAllEmojis(text));
				mailDAO.insertMail(mailVO);
			}
		}
	}

	/**
	 * 마케팅_이벤트/기획전
	 */
	@Override
	public void sendPrmtEamils(EMAILVO emailVO,
							   HttpServletRequest request) {
		log.info("sendPrmtEamils call");

		String url = EgovProperties.getProperty("Globals.Web");

		for(String strEamil : emailVO.getEmailList()) {
			if(StringUtils.isEmpty(strEamil)) {
				continue;
			}
			MAILVO mailVO = new MAILVO();
			mailVO.setSenderAlias(EgovProperties.getProperty("MAIL.SENDER.ALIAS"));
			mailVO.setSender(emailVO.getCallback());
			mailVO.setUserInfo(strEamil);
			mailVO.setEmail(strEamil);
			mailVO.setUserId(strEamil);
			mailVO.setTitle(emailVO.getSubject());
			mailVO.setEventId("15");

			// 이벤트&기획전 정보
			PRMTVO prmtVO = new PRMTVO();
			prmtVO.setPrmtNum(emailVO.getPrmtNum());

			PRMTVO prmtInfo = webPrmtService.selectByPrmt(prmtVO);

			// 상품 리스트
			List<PRMTPRDTVO> prmtPrdtList = new ArrayList<PRMTPRDTVO>();

			// 숙박
			AD_WEBLISTSVO adWebSVO = new AD_WEBLISTSVO();
			adWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<AD_WEBLISTVO> resultAdList = webAdProductService.selectAdListOssPrmt(adWebSVO);

			for(AD_WEBLISTVO data : resultAdList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("AD");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}
			// 렌터카
			RC_PRDTINFSVO rcWebSVO = new RC_PRDTINFSVO();
			rcWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<RC_PRDTINFVO> resultRcList = webRcProductService.selectWebRcPrdtListOssPrmt(rcWebSVO);

			for(RC_PRDTINFVO data : resultRcList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("RC");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}
			// 소셜
			WEB_SPSVO spWebSVO = new WEB_SPSVO();
			spWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<WEB_SPPRDTVO> resultSpList = webSpService.selectProductListOssPrmt(spWebSVO);

			for(WEB_SPPRDTVO data : resultSpList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("SP");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}
			// 관광기념품
			WEB_SVSVO svWebSVO = new WEB_SVSVO();
			svWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<WEB_SVPRDTVO> resultSvList = webSvService.selectProductListOssPrmt(svWebSVO);

			for(WEB_SVPRDTVO data : resultSvList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("SV");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}

			Map<String, Object> model = new HashMap<String, Object>();
			model.put("numberTool", new NumberTool());
			model.put("dateTool", new DateTool());
			model.put("domain", url);
			model.put("prmtInfo", prmtInfo);
			model.put("prmtPrdtList", prmtPrdtList);

			String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mailTemplate/send" + emailVO.getPrmtDiv() + "Emails.vm", "UTF-8", model);
			if(text != null) {
				mailVO.setContent(EmojiParser.removeAllEmojis(text));
				mailDAO.insertMail(mailVO);
			}
		}
	}

	@Override
	public void sendCancelRequestPrdt(String prdtRsvNum,
									  HttpServletRequest request) {
		log.info(">>>>reqCancelSnedSMS 호출:" + prdtRsvNum);

		// 예약 상품 정보
		ORDERVO orderVO = new ORDERVO();
		orderVO.setPrdtRsvNum(prdtRsvNum);

		ORDERVO orderRes = webOrderDAO.selectUserRsvFromPrdtRsvNum(orderVO);

		if(orderRes == null) {
			log.info("Not prdtRsvNum");
			return;
		}
		// 예약기본정보
		RSVVO rsvVO = new RSVVO();
		rsvVO.setRsvNum(orderRes.getRsvNum());

		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

		if(rsvInfo == null) {
			log.info("Not rsvNum");
			return;
		}
		// 상품 예약 목록
		List<ORDERVO> orderList = new ArrayList<ORDERVO>();
		orderList.add(orderRes);

		sendCancelRequest(rsvInfo, orderList, request);
	}

	@Override
	public void sendCancelRequestAll(String rsvNum,
									 HttpServletRequest request) {
		log.info(">>>>reqCancelSnedSMSAll 호출:" + rsvNum);

		// 예약기본정보
		RSVVO rsvVO = new RSVVO();
		rsvVO.setRsvNum(rsvNum);

		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

		if(rsvInfo == null) {
			log.info("Not rsvNum");
			return;
		}
		// 예약 상품 리스트
		ORDERVO orderVO = new ORDERVO();
		orderVO.setRsvNum(rsvNum);
		orderVO.setRsvStatusCd("RS10");

		List<ORDERVO> orderList =  webOrderDAO.selectUserRsvListFromRsvNum(orderVO);

		sendCancelRequest(rsvInfo, orderList, request);
	}
}
