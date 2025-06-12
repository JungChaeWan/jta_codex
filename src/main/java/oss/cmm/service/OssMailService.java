package oss.cmm.service;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import oss.cmm.vo.EMAILVO;
import oss.corp.vo.CORPVO;
import oss.coupon.vo.CPVO;
import oss.otoinq.vo.OTOINQVO;
import oss.user.vo.USERVO;
import web.order.vo.ORDERVO;
import web.order.vo.RSVVO;
import web.order.vo.SV_RSVVO;
import web.product.vo.WEB_DTLPRDTVO;


public interface OssMailService {
	
	void sendFreeCoupon(WEB_DTLPRDTVO product, String reciver, HttpServletRequest request);
	
	
	/**
	 * 가입 완료
	 * 파일명 : sendRegUser
	 * 작성일 : 2015. 12. 30. 오후 2:00:55
	 * 작성자 : 신우섭
	 * @param user
	 * @param reciver
	 * @param request
	 */
	void sendRegUser(USERVO user, String reciver, HttpServletRequest request);
	
	/**
	 * 업체 승인 완료
	 * 파일명 : sendCorpAppro
	 * 작성일 : 2015. 12. 30. 오후 2:02:49
	 * 작성자 : 신우섭
	 * @param corpVO
	 * @param request
	 */
	void sendCorpAppro(CORPVO corpVO, HttpServletRequest request);
	
	
	/**
	 * 예약완료
	 * 파일명 : sendOrderComplete
	 * 작성일 : 2015. 12. 30. 오후 5:33:11
	 * 작성자 : 신우섭
	 * @param rsvInfo
	 * @param orderList
	 * @param request
	 */
	void sendOrderComplete(RSVVO rsvInfo, List<ORDERVO> orderList, HttpServletRequest request);
	
	/**
	 * 예약 완료시 업체에게 메일 전송
	 * 파일명 : sendOrderCompleteCorp
	 * 작성일 : 2016. 1. 22. 오후 4:15:07
	 * 작성자 : 신우섭
	 * @param rsvInfo
	 * @param orderList
	 * @param request
	 */
	void sendOrderCompleteCorp(RSVVO rsvInfo, List<ORDERVO> orderList, HttpServletRequest request);
	
	/**
	 * 예약 취소 요청 확인 메일 전송 (단품)
	 * Function : sendCancelRequestPrdt
	 * 작성일 : 2016. 8. 17. 오전 11:08:14
	 * 작성자 : 정동수
	 * @param prdtRsvNum
	 * @param request
	 */
	void sendCancelRequestPrdt(String prdtRsvNum, HttpServletRequest request);
	
	/**
	 * 예약 취소 요청 확인 메일 전송 (전체)
	 * Function : sendCancelRequestAll
	 * 작성일 : 2016. 8. 17. 오후 12:03:43
	 * 작성자 : 정동수
	 * @param rsvNum
	 * @param request
	 */
	void sendCancelRequestAll(String rsvNum, HttpServletRequest request);
	
	/**
	 * 예약 취소 요청 확인 메일 전송
	 * Function : sendCancelRequest
	 * 작성일 : 2016. 8. 16. 오후 5:24:24
	 * 작성자 : 정동수
	 * @param rsvInfo
	 * @param orderList
	 * @param request
	 */
	void sendCancelRequest(RSVVO rsvInfo, List<ORDERVO> orderList, HttpServletRequest request);
	
	/**
	 * 예약 취소 요청 시 업체에게 메일 발송
	 * Function : sendCancelRequestCorp
	 * 작성일 : 2016. 8. 16. 오후 5:24:44
	 * 작성자 : 정동수
	 * @param rsvInfo
	 * @param orderList
	 * @param request
	 */
	void sendCancelRequestCorp(RSVVO rsvInfo, List<ORDERVO> orderList, HttpServletRequest request);
	
	/**
	 * 자동 취소
	 * 파일명 : sendCancelRsvAuto
	 * 작성일 : 2016. 1. 4. 오후 4:10:52
	 * 작성자 : 신우섭
	 * @param rsvInfo
	 * @param orderVO
	 * @param request
	 */
	void sendCancelRsvAuto(RSVVO rsvInfo, ORDERVO orderVO, HttpServletRequest request);
	
	
	/**
	 * <pre>
	 * 파일명 : sendreFundComplete
	 * 작성일 : 2016. 1. 6. 오전 9:04:11
	 * 작성자 : 신우섭
	 * @param rsvInfo
	 * @param orderVO
	 * @param request
	 */
	void sendRefundComplete(RSVVO rsvInfo, ORDERVO orderVO, HttpServletRequest request);
	
	void sendEamils(EMAILVO emailVO, HttpServletRequest request);
	
	void sendPrmtEamils(EMAILVO emailVO, HttpServletRequest request) throws ParseException;
	
	/**
	 * 배송 처리 메일 발송
	 * Function : sendDeliveryComplete
	 * 작성일 : 2016. 10. 28. 오후 11:14:38
	 * 작성자 : 정동수
	 * @param rsvInfo
	 * @param orderVO
	 * @param request
	 */
	void sendDeliveryComplete(SV_RSVVO rsvInfo, ORDERVO orderVO, HttpServletRequest request);
	
	/**
	 * 1:1 문의 작성 시 업체 확인 메일 발송
	 * Function : sendOtoinqCorp
	 * 작성일 : 2016. 11. 8. 오전 10:48:54
	 * 작성자 : 정동수
	 * @param otoinqVO
	 * @param admEmail
	 * @param request
	 */
	void sendOtoinqCorp(OTOINQVO otoinqVO, String admEmail, HttpServletRequest request);
	
	/**
	 * 사용 완료된 예약건에 자동 메일 발송
	 * Function : useCompleteSendMailAcc
	 * 작성일 : 2016. 11. 11. 오전 11:58:56
	 * 작성자 : 정동수
	 */
	void useCompleteSendMailAcc();
	
	/**
	 * 방문 7일전 자동 메일 발송
	 * Function : tourPrev7SendMail
	 * 작성일 : 2018. 3. 8. 오후 1:45:03
	 * 작성자 : 정동수
	 */
	void tourPrev7SendMail();
	
	/**
	 * 휴면 예정 고객 자동 메일 발송 (휴면 처리 7일전)
	 * Function : restUserPrevSendMail
	 * 작성일 : 2018. 3. 9. 오후 1:54:24
	 * 작성자 : 정동수
	 */
	void restUserPrevSendMail();
	
	/**
	 * 휴면 대상 고객 자동 메일 발송
	 * Function : restUserTargetSendMail
	 * 작성일 : 2018. 3. 9. 오후 2:42:04
	 * 작성자 : 정동수
	 */
	void restUserTargetSendMail();
	
	/**
	 * 방문 10개월된 고객 자동 메일 발송
	 * Function : visit10MonthSendMail
	 * 작성일 : 2018. 3. 12. 오후 1:46:03
	 * 작성자 : 정동수
	 */
	void visit10MonthSendMail();
	
	/**
	 * VIP/우수고객에 대한 메일 발송
	 * Function : vipBestUserSendMail
	 * 작성일 : 2018. 3. 12. 오후 4:57:32
	 * 작성자 : 정동수
	 * @param cpVO
	 */
	void vipBestUserSendMail(CPVO cpVO) throws ParseException;
	
	/**
	 * 실시간/제주특산/기념품 상품 취소 시 쿠폰발행에 대한 메일 발송
	 * Function : autoCancelCouponSendMail
	 * 작성일 : 2018. 3. 13. 오전 11:06:18
	 * 작성자 : 정동수
	 * @param email
	 * @param cpDiv
	 */
	void autoCancelCouponSendMail(String email, String cpDiv);
}