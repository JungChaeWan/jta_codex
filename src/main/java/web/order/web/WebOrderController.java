package web.order.web;

import api.service.*;
import api.vo.APILSVO;
import com.jcraft.jsch.*;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovWebUtil;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.cmmn.service.SmsService;
import egovframework.cmmn.vo.MMSVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import lgdacom.XPayClient.XPayClient;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rsv.service.MasRsvService;
import mas.sv.service.MasSvService;
import mas.sv.vo.SV_CORPDLVAMTVO;
import modules.easypay.NmcLiteApproval;
import modules.easypay.NmcLiteApprovalCancel;
import modules.easypay.NmcLiteOrder;
import openpoint.aria.lib.ARIACipher;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.service.OssMailService;
import oss.corp.service.OssCorpService;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPPRDTVO;
import oss.coupon.vo.CPVO;
import oss.env.service.OssSiteManageService;
import oss.marketing.vo.EVNTINFVO;
import oss.point.service.OssPointService;
import oss.point.vo.POINTVO;
import oss.point.vo.POINT_CORPVO;
import oss.point.vo.POINT_CPVO;
import oss.rsv.service.OssRsvService;
import oss.user.service.OssUserService;
import oss.user.vo.REFUNDACCINFVO;
import oss.user.vo.USERVO;
import web.cs.web.CartComparator;
import web.main.service.WebMainService;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.USER_CPVO;
import web.order.service.WebCartService;
import web.order.service.WebOrderService;
import web.order.vo.*;
import web.product.service.*;
import web.product.vo.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static java.lang.System.out;

@Controller
public class WebOrderController {
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "webOrderService")
	protected WebOrderService webOrderService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpProductService;

	@Resource(name = "webSvService")
	protected WebSvProductService webSvProductService;

	@Resource(name = "ossSiteManageService")
	protected OssSiteManageService ossSiteManageService;

	@Resource(name = "masRsvService")
	private MasRsvService masRsvService;

	@Resource(name = "smsService")
	protected SmsService smsService;

	@Resource(name = "ossMailService")
	protected OssMailService ossMailService;

	@Resource(name = "masSvService")
	private MasSvService masSvService;

	@Resource(name = "apiService")
	private APIService apiService;

	@Resource(name = "webCartService")
	private WebCartService webCartService;

	@Resource(name = "apiLsService")
	APILsService apiLsService;

	@Resource(name = "apiVpService")
	APIVpService apiVpService;

	@Resource(name = "ossRsvService")
	private OssRsvService ossRsvService;

	@Resource(name = "webUserCpService")
	private WebUserCpService webUserCpService;

	@Resource(name = "ossCouponService")
	private OssCouponService ossCouponService;

	@Autowired
	private APITLBookingService apitlBookingService;

	@Resource(name = "webMainService")
	private WebMainService webMainService;

	@Resource(name="apiInsService")
	private APIInsService apiInsService;

	@Resource(name="apiRibbonService")
	private APIRibbonService apiRibbonService;
	@Autowired
	private OssPointService ossPointService;

	@Autowired
	private OssUserService ossUserService;

	@Resource(name="apiOrcService")
	private APIOrcService apiOrcService;


	/** 예약확인 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/web/order01.do")
	public String order01(@RequestParam Map<String, String> params,
						  HttpServletRequest request,
						  ModelMap model) {
		log.info("/web/order01.do Call !!");

		List<CARTVO> cartList = new ArrayList<CARTVO>();
		List<CARTVO> orderList = new ArrayList<CARTVO>();

		USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if (loginVO != null) {
			//회원 로그인
			if ("Y".equals(loginVO.getRestYn())) {    // 휴면계정이면..
				return "redirect:/web/restSign.do";
			} else {
				USERVO userVO = ossUserService.selectByUser(loginVO);

				model.addAttribute("userVO", userVO);
				model.addAttribute("isGuest", "N");
			}
		} else {
			//비회원 로그인인 경우
			loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();

			if (loginVO != null) {
				model.addAttribute("userVO", loginVO);
				model.addAttribute("isGuest", "Y");
			}
		}

		if (Constant.RSV_DIV_C.equals(params.get("rsvDiv"))) {
			// 카트에 체크된 상품을 주문 리스트에 담기
			String cartSn[] = params.get("cartSn").split(",");

			if (request.getSession().getAttribute("cartList") != null) {
				cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
			}
			for (CARTVO cart : cartList) {
				for (int i = 0; i < cartSn.length; i++) {
					if (Integer.parseInt(cartSn[i]) == cart.getCartSn()) {
						orderList.add(cart);
					}
				}
			}
		} else {
			// 즉시 구매 세션을 주문 리스트에 담기
			orderList = (List<CARTVO>) request.getSession().getAttribute("instant");
		}
		// 주문 리스트가 존재하지 않을경우 장바구니로 리턴
		if (orderList == null || orderList.size() == 0) {
			return "redirect:/web/cart.do";
		}

		// 장바구니 정렬
		CartComparator cartCom = new CartComparator();
		Collections.sort(orderList, cartCom);

		// SV 여부
		String orderDiv = null;

		for (CARTVO cart : orderList) {
			if (Constant.SV.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {
				orderDiv = Constant.SV;
				break;
			}
		}

		//직접수령 여부 체크
		String svDirRecv = "Y";
		for (CARTVO cart : orderList) {
			if (Constant.SV.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {
				if (!"Y".equals(cart.getDirectRecvYn())) {
					svDirRecv = "N";
					break;
				}
			}
		}

		String tamnacardYn = "N";
		if(orderList.size() == 1){
			for(CARTVO cart : orderList) {
				String resultCorp = webOrderService.tamnacardCompanyUseYn(cart.getCorpId());
				if("C".equals(resultCorp)){
					tamnacardYn = "Y";
				}else if("P".equals(resultCorp)){
					tamnacardYn = webOrderService.tamnacardPrdtUseYn(cart.getPrdtNum());
				}
			}
		}

		//파트너(협력사) 가용 포인트 조회
		String ssPartnerCode = (String) request.getSession().getAttribute("ssPartnerCode");
		POINTVO pointVO = new POINTVO();
		pointVO.setUserId(loginVO.getUserId());
		pointVO.setPartnerCode(ssPartnerCode);
		POINTVO partnerPoint = ossPointService.selectAblePoint(pointVO);

		//파트너(협력사)
		POINT_CPVO pointCpVO =  ossPointService.selectPointCpDetail(ssPartnerCode);

		model.addAttribute("tamnacardYn", tamnacardYn);
		model.addAttribute("svDirRecv", svDirRecv);
		model.addAttribute("rsvDiv", params.get("rsvDiv"));
		model.addAttribute("orderList", orderList);
		model.addAttribute("orderDiv", orderDiv);
		model.addAttribute("partnerPoint", partnerPoint);
		model.addAttribute("pointCpVO", pointCpVO);

		//----------마라톤 분기----------//
		String mrt_corpId = "";
		String mrt_prdtNum = "";
		MRTNVO mrtnSVO = new MRTNVO();
		for (CARTVO cart : orderList) {
			mrt_corpId = cart.getCorpId();
			mrt_prdtNum = cart.getPrdtNum();
		}

		String mrtCorpId = mrt_corpId;
		if(mrtCorpId != null) {
			if("CSPM".equals(mrtCorpId.substring(0, 4))) {

				mrtnSVO.setCorpId(mrt_corpId);
				mrtnSVO.setPrdtNum(mrt_prdtNum);
				MRTNVO tshirtsCntVO = webOrderService.selectTshirtsCntVO(mrtnSVO);

				model.addAttribute("tshirtsCntVO", tshirtsCntVO);
				return "/web/order/orderMrt01";
			}
		}
		//----------마라톤 분기----------//

		return "/web/order/order01";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/web/order02.do")
	public String order02(@ModelAttribute("RSVVO") RSVVO rsvVO,
						  @ModelAttribute("USER_CPVO") USER_CPVO cpVO,
						  @ModelAttribute("MRTNVO") MRTNVO mrtnVO,
						  HttpServletRequest request,
						  HttpServletResponse response,
						  ModelMap model) throws Exception {
		log.info("/web/order02.do Call !!");

		/** 문화누리카드 */
		/*String mnuricardYn = request.getParameter("mnuricard");
		if(mnuricardYn == null){
			mnuricardYn = "N";
		}*/

		String cartSn[] = rsvVO.getCartSn();
		/** seq1-1 로그인 정보 userId set */
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (userVO == null) {
			/** seq 1-2비회원 로그인인 경우 */
			userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();
			if (userVO != null) {
				userVO.setUserId(Constant.RSV_GUSET_NAME); //ID Guest로 설정
			}
		}
		/** seq1-3 로그인 정보 접속IP set */
		String userIp = EgovClntInfo.getClntIP(request);
		rsvVO.setUserId(userVO.getUserId());
		rsvVO.setRegIp(userIp);
		rsvVO.setModIp(userIp);

		List<CARTVO> cartList = new ArrayList<CARTVO>();
		/** seq2-1 장바구니 얘약(구매) */
		if (Constant.RSV_DIV_C.equals(rsvVO.getRsvDiv())) {
			if (request.getSession().getAttribute("cartList") != null) {
				cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
			}
		/** seq2-2 바로 예약(구매) */
		} else {
			cartList = (List<CARTVO>) request.getSession().getAttribute("instant");
		}
		/** seq2-3 예약(구매)내역 없을시 */
		if (cartList == null || cartList.size() == 0) {
			return "redirect:/web/cart.do";
		}

		/** seq3-1 cartList정렬(업체별)*/
		CartComparator cartCom = new CartComparator();
		Collections.sort(cartList, cartCom);
		/** seq3-2 선택된 상품이 카트 세션에 존재 하는지를 체크 */
		boolean cartChk = true;
		for (int i = 0; i < cartSn.length; i++) {
			for (int index = 0; index < cartList.size(); index++) {
				CARTVO cart = cartList.get(index);
				if (Integer.parseInt(cartSn[i]) == cart.getCartSn()) {
					cartChk = false;
				}
			}
		}
		/** seq3-3 선택된 상품이 카트 세션에 존재하지 않을경우 카트로 리턴 */
		if (cartChk) {
			return "redirect:/web/cart.do";
		}

		/** seq4 파트너사 트래킹*/
		String partner = (String)request.getSession().getAttribute("partner");
		if(StringUtils.isNotEmpty(partner)){
			userVO.setPartnerCd(partner);
			if(webMainService.selectTamnaoPartnersCnt(userVO) > 0){
				USERVO userTPVO =  webMainService.selectTamnaoPartner(userVO);
				rsvVO.setPartner(userTPVO.getPartnerNm());
			}
		}

		/** seq5-1 기초예약(구매)정보 insert 및 기초예약(구매)번호 get */
		rsvVO.setPartnerCode((String) request.getSession().getAttribute("ssPartnerCode"));
		String rsvNum = webOrderService.insertRsv(rsvVO);
		rsvVO.setRsvNum(rsvNum);
		log.info("[PC ORDER INFO] RSV NUMBER : " + rsvNum);
		log.info("[PC ORDER INFO] ORDER COUNT : " + cartSn.length + "건");

		String p_corpId = "";
		String p_dlvAmtDiv = "";
		String p_prdc = "";
		int totalSaleAmt = 0;
		int maxSaleAmt = 0;
		String maxSaleDtlRsvNum = "";
		String tamnacardYn = "N";

		/** seq5-2 카트정보 loop */
		for (int i = 0; i < cartSn.length; i++) {
			for (int index = 0; index < cartList.size(); index++) {
				/** seq5-3 카트정보 get*/
				CARTVO cart = cartList.get(index);
				/** seq5-4 쿠폰정보 set*/
				List<USER_CPVO> cpList = new ArrayList<USER_CPVO>();
				Integer cpAmt = 0;
				if (cpVO.getMapSn() != null) {
					String mapSn[] = cpVO.getMapSn().split(",");
					String useCpNum[] = cpVO.getUseCpNum().split(",");
					String cpDisAmt[] = cpVO.getCpDisAmt().split(",");
					for(int ix = 0; ix < mapSn.length; ix++) {
						if (cartSn[i].equals(mapSn[ix])) {
							USER_CPVO cpVO2 = new USER_CPVO();
							cpVO2.setCpNum(useCpNum[ix]);
							cpVO2.setDisAmt(Integer.parseInt(cpDisAmt[ix]));
							/** 쿠폰검증 */
							USER_CPVO cpVO3 = webUserCpService.selectCpInfoValidate(cpVO2);
							if(cpVO3 !=null){
								/** 금액할인 */
								if(Constant.CP_DIS_DIV_PRICE.equals(cpVO3.getDisDiv())){
									cpVO2.setDisAmt(cpVO3.getDisAmt());
								/** 퍼센트할인*/
								}else if(Constant.CP_DIS_DIV_RATE.equals(cpVO3.getDisDiv())){
									int totalAmt = Integer.parseInt(cart.getTotalAmt());
									int disDiv = Integer.parseInt(cpVO3.getDisPct());
									int limitAmt = cpVO3.getLimitAmt();
									int calAmt = (int)Math.round(totalAmt * ((double) disDiv / 100));
									int disAmt;

									/** 제한금액이 0이 아니고, 쿠폰금액이 제한금액보다 크면 */
									if(calAmt > limitAmt && 0 != limitAmt){
										disAmt = limitAmt;
									}else{
										disAmt = calAmt;
									}

									/** 승마전용 쿠폰 이용시 최대금액은 최대금액 X 구매 수 */
									if(cpVO3.getCpNm().contains("승마전용")){
										int tempLimitAmt = limitAmt * Integer.parseInt(cart.getQty());

										if(calAmt > tempLimitAmt){
											disAmt = tempLimitAmt;
										}else{
											disAmt = calAmt;
										}
									}

									cpVO2.setDisAmt(disAmt);
								}
							}else{
								log.fatal("rsvNum="+rsvNum+" ::: coupon validate error");
								return "redirect:/web/cmm/error.do";
							}
							cpList.add(cpVO2);
							cpAmt += cpVO2.getDisAmt();
						}
					}
				} else {
					cpList = null;
				}

				if (Integer.parseInt(cartSn[i]) == cart.getCartSn()) {
					/** seq6-1 렌터카 예약처리 */
					if (Constant.RENTCAR.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {
						RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
						prdtSVO.setsPrdtNum(cart.getPrdtNum());
						prdtSVO.setsFromDt(cart.getFromDt());
						prdtSVO.setsFromTm(cart.getFromTm());
						prdtSVO.setsToDt(cart.getToDt());
						prdtSVO.setsToTm(cart.getToTm());

						/** seq6-2 예약가능 상태 확인 */
						RC_PRDTINFVO prdtInfo = webRcProductService.selectRcPrdt(prdtSVO);
						RC_RSVVO rcRsvVO = new RC_RSVVO();
						rcRsvVO.setPrdtNm(prdtInfo.getPrdtNm());
						rcRsvVO.setRsvNum(rsvNum);
						/** 탐나는전 가능여부*/
						tamnacardYn = prdtInfo.getTamnacardYn();

						/** seq6-3 예약가능(코드,금액,할인금) set */
						if (Constant.FLAG_Y.equals(prdtInfo.getAbleYn())) {
							rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_READY);
							rcRsvVO.setNmlAmt(prdtInfo.getSaleAmt());
							rcRsvVO.setSaleAmt(String.valueOf(Integer.parseInt(prdtInfo.getSaleAmt()) - cpAmt));
							rcRsvVO.setDisAmt(String.valueOf(cpAmt));
						/** seq6-3 예약불가(코드,금액,할인금) set */
						} else {
							rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
							rcRsvVO.setNmlAmt("0");
							rcRsvVO.setSaleAmt("0");
							rcRsvVO.setDisAmt("0");
							cpList = null;
						}
						/** 업체번호 */
						rcRsvVO.setCorpId(cart.getCorpId());
						/** 상품번호 */
						rcRsvVO.setPrdtNum(cart.getPrdtNum());
						/** 렌트 시작 일자 */
						rcRsvVO.setRentStartDt(cart.getFromDt());
						/** 렌트 시작 시간 */
						rcRsvVO.setRentStartTm(cart.getFromTm());
						/** 렌트 종료 일자 */
						rcRsvVO.setRentEndDt(cart.getToDt());
						/** 렌트 종료 시간 */
						rcRsvVO.setRentEndTm(cart.getToTm());
						/** 할인 취소 금액 */
						rcRsvVO.setDisCancelAmt("0");
						/** 예약자명*/
						rcRsvVO.setRsvNm(rsvVO.getRsvNm());
						/** 예약자연락처*/
						rcRsvVO.setRsvTelnum(rsvVO.getRsvTelnum());
						/** 사용자명*/
						rcRsvVO.setUseNm(rsvVO.getUseNm());
						/** 사용자연락처*/
						rcRsvVO.setUseTelnum(rsvVO.getRsvTelnum());
						/** 상품 정보 */
						String prdtInf = EgovStringUtil.getDateFormatDash(cart.getFromDt()) + " " + EgovStringUtil.getTimeFormatCol(cart.getFromTm())
								+ "부터 " + EgovStringUtil.getDateFormatDash(cart.getToDt()) + " " + EgovStringUtil.getTimeFormatCol(cart.getToTm())
								+ "까지 " + prdtInfo.getRsvTm() + "시간";
						rcRsvVO.setPrdtInf(prdtInf);
						/** 보험 구분 (자차포함/미포함) */
						rcRsvVO.setIsrDiv(prdtInfo.getIsrDiv());
						/** 보험 구분 (일반/고급/미포함)*/
						rcRsvVO.setIsrTypeDiv(prdtInfo.getIsrTypeDiv());
						/** 결제금액 */
						totalSaleAmt += Integer.parseInt(rcRsvVO.getSaleAmt()) - Integer.parseInt(rcRsvVO.getDisAmt());

						/** seq6-4 상세예약번호 insert  */
						String rcRsvNum = webOrderService.insertRcRsv(rcRsvVO);
						rcRsvVO.setRcRsvNum(rcRsvNum);

						/** seq6-5 LPOINT 적용상품 선정 (최대금액일경우 적용)  */
						if (maxSaleAmt <= Integer.parseInt(rcRsvVO.getSaleAmt()) - Integer.parseInt(rcRsvVO.getDisAmt())) {
							maxSaleAmt = Integer.parseInt(rcRsvVO.getSaleAmt()) - Integer.parseInt(rcRsvVO.getDisAmt());
							maxSaleDtlRsvNum = rcRsvNum;
						}
						/** seq6-6 LPOINT 적립 */
						if (Integer.parseInt(rsvVO.getLpointSavePoint()) > 0) {
							LPOINTSAVEINFVO lpointSaveInfVO = new LPOINTSAVEINFVO();
							lpointSaveInfVO.setPrdtRsvNum(rcRsvNum);
							lpointSaveInfVO.setPayAmt(rcRsvVO.getSaleAmt());
							lpointSaveInfVO.setCardNum(rsvVO.getLpointCardNo());
							webOrderService.insertLpointCardNum(lpointSaveInfVO);
						}
						String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
						/** 렌터카API 예약전송*/
						if (Constant.FLAG_Y.equals(prdtInfo.getCorpLinkYn())  && !EgovStringUtil.isEmpty(prdtInfo.getLinkMappingNum()) && Constant.FLAG_Y.equals(prdtInfo.getAbleYn()) && "service".equals(CST_PLATFORM.trim())) {
							Boolean apiResultYn = true;
							/*String linkMappingRsvnum = "";
							*//** 인스API 예약전송 *//*
							if(Constant.RC_RENTCAR_COMPANY_INS.equals(prdtInfo.getApiRentDiv())){
								*//** 예약 *//*
								*//*linkMappingRsvnum = apiInsService.revadd(rcRsvVO,prdtInfo);*//*
								*//** 성공 *//*
								apiResultYn =  !EgovStringUtil.isEmpty(linkMappingRsvnum);
							*//** 그림API 예약전송*//*
							}else if(Constant.RC_RENTCAR_COMPANY_GRI.equals(prdtInfo.getApiRentDiv())){
								String carAmt = "0";
								String insuranceNum = "";
								String insuranceAmt = "0";

								insuranceAmt = prdtInfo.getIsrAmt();
								insuranceNum = prdtInfo.getLinkMappingIsrNum();
								linkMappingRsvnum = apiService.insertGrimRcRsv(rcRsvNum);
								apiResultYn =  !EgovStringUtil.isEmpty(linkMappingRsvnum);
							*//** 리본API 예약전송*//*
							}else if (Constant.RC_RENTCAR_COMPANY_RIB.equals(prdtInfo.getApiRentDiv())){

							}*/

							/** if 예약완료*/
							if (apiResultYn) {    // 예약 성공
								// 렌터카 예약번호
								/*rcRsvVO.setRcRsvNum(rcRsvNum);
								rcRsvVO.setMappingRsvNum(linkMappingRsvnum);*/

								webOrderService.insertRcHist(rcRsvVO);
								// 판매 통계 MERGE
								webOrderService.mergeSaleAnls(rcRsvVO.getPrdtNum());

								if (cpList != null) {
									// 쿠폰 사용예약번호 셋팅
									for (int cpi = 0; cpi < cpList.size(); cpi++) {
										USER_CPVO useCp = cpList.get(cpi);
										useCp.setUseRsvNum(rcRsvNum);
										cpList.set(cpi, useCp);
									}
								}
							/** if 예약실패*/
							} else {
								/** set 예약불가 Flag  */
								rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
								webOrderService.chgRsvStatus(rsvVO);
								// 예약실패건에 대해 사용쿠폰리스트 삭제
								cpList = null;
							}
						/** 비API 렌터카*/
						} else {

							rcRsvVO.setRcRsvNum(rcRsvNum);
							rcRsvVO.setMappingRsvNum("0");
							webOrderService.insertRcHist(rcRsvVO);

							if (cpList != null) {
								// 쿠폰 사용예약번호 셋팅
								for (int cpi = 0; cpi < cpList.size(); cpi++) {
									USER_CPVO useCp = cpList.get(cpi);
									useCp.setUseRsvNum(rcRsvNum);
									cpList.set(cpi, useCp);
								}
							}
						}
					}
					// 숙박 예약 처리
					else if (Constant.ACCOMMODATION.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {
						log.fatal("[ORDER INFO] AD Reservation");
						// 예약 가능여부 확인 - DB 상품 처리
						ADTOTALPRICEVO adTotPrice = new ADTOTALPRICEVO();
						adTotPrice.setPrdtNum(cart.getPrdtNum());
						adTotPrice.setsFromDt(cart.getStartDt());
						adTotPrice.setiNight(Integer.parseInt(cart.getNight()));
						adTotPrice.setiMenAdult(Integer.parseInt(cart.getAdultCnt()));
						adTotPrice.setiMenJunior(Integer.parseInt(cart.getJuniorCnt()));
						adTotPrice.setiMenChild(Integer.parseInt(cart.getChildCnt()));
						int nPrice = webAdProductService.getTotalPrice(adTotPrice);

						AD_RSVVO adRsvVO = new AD_RSVVO();
						// 상품명
						adRsvVO.setPrdtNm(cart.getPrdtNm());

						// 상품 정보
						String prdtInf = EgovStringUtil.getDateFormatDash(cart.getStartDt()) + "부터 " + cart.getNight() + "박|";
						prdtInf += "성인 " + cart.getAdultCnt() + "명, ";
						prdtInf += "소인 " + cart.getJuniorCnt() + "명, ";
						prdtInf += "유아 " + cart.getChildCnt() + "명 ";
						adRsvVO.setPrdtInf(prdtInf);

						if (nPrice <= 0) {
							adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
							adRsvVO.setNmlAmt("0");
							adRsvVO.setSaleAmt("0");
							adRsvVO.setDisAmt("0");

							// 예약불가능건에 대해 사용쿠폰리스트 삭제
							cpList = null;
						} else {
							adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_READY);
							adRsvVO.setNmlAmt(String.valueOf(nPrice));
							// 판매금액 - 결제되는 금액
							adRsvVO.setSaleAmt(String.valueOf(nPrice - cpAmt));
							// 할인금액
							adRsvVO.setDisAmt(String.valueOf(cpAmt));

							// 황금빛가을제주 포인트사용처리
							if (Constant.FLAG_Y.equals(rsvVO.getGsPointYn())) {
								// 정상금액 - 판매금액
								adRsvVO.setNmlAmt(String.valueOf(nPrice));
								// 판매금액 - 결제되는 금액
								adRsvVO.setSaleAmt("0");
								// 할인금액
								adRsvVO.setDisAmt(String.valueOf(nPrice));
							}
						}
						adRsvVO.setRsvNum(rsvNum);
						adRsvVO.setCorpId(cart.getCorpId());
						adRsvVO.setPrdtNum(cart.getPrdtNum());
						adRsvVO.setUseDt(cart.getStartDt());
						adRsvVO.setUseNight(cart.getNight());
						adRsvVO.setAdultNum(cart.getAdultCnt());
						adRsvVO.setJuniorNum(cart.getJuniorCnt());
						adRsvVO.setChildNum(cart.getChildCnt());
						// 할인 취소 금액
						adRsvVO.setDisCancelAmt("0");
						// 숙박예약처리
						totalSaleAmt += Integer.parseInt(adRsvVO.getSaleAmt()) - Integer.parseInt(adRsvVO.getDisAmt());
						tamnacardYn = webAdProductService.selectTamnacardYn(cart.getPrdtNum());
						String adRsvNum = webOrderService.insertAdRsv(adRsvVO);
						/** LPOINT 최대금액 선정*/

						if (maxSaleAmt <= Integer.parseInt(adRsvVO.getSaleAmt()) - Integer.parseInt(adRsvVO.getDisAmt())) {

							maxSaleAmt = Integer.parseInt(adRsvVO.getSaleAmt()) - Integer.parseInt(adRsvVO.getDisAmt());
							maxSaleDtlRsvNum = adRsvNum;
						}

						// 포인트 적립이면 DB 등록 (2017-09-07, By JDongS)
						if (Integer.parseInt(rsvVO.getLpointSavePoint()) > 0) {
							LPOINTSAVEINFVO lpointSaveInfVO = new LPOINTSAVEINFVO();
							lpointSaveInfVO.setPrdtRsvNum(adRsvNum);
							lpointSaveInfVO.setPayAmt(adRsvVO.getSaleAmt());
							lpointSaveInfVO.setCardNum(rsvVO.getLpointCardNo());
							webOrderService.insertLpointCardNum(lpointSaveInfVO);
						}

						if (nPrice > 0) {
							if (cpList != null) {
								// 쿠폰 사용예약번호 셋팅
								for (int cpi = 0; cpi < cpList.size(); cpi++) {
									USER_CPVO useCp = cpList.get(cpi);
									useCp.setUseRsvNum(adRsvNum);
									cpList.set(cpi, useCp);
								}
							}
						}

						//일별 숙박요금 저장 2021.06.28 chaewan.jung
						webAdProductService.insertRsvDayPrice(rsvNum, adRsvNum, adTotPrice);

						// 판매 통계 MERGE
						webOrderService.mergeSaleAnls(adRsvVO.getPrdtNum());

					}
					// 소셜상품 예약 처리
					else if (Constant.SOCIAL.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {
						log.fatal("[ORDER INFO] SP Reservation");
						WEB_DTLPRDTVO searchVO = new WEB_DTLPRDTVO();
						searchVO.setPrdtNum(cart.getPrdtNum());
						searchVO.setSpDivSn(cart.getSpDivSn());
						searchVO.setSpOptSn(cart.getSpOptSn());

						WEB_DTLPRDTVO spProduct = webSpProductService.selectByCartPrdt(searchVO);
						tamnacardYn = spProduct.getTamnacardYn();

						SP_RSVVO spRsvVO = new SP_RSVVO();
						// 상품명
						spRsvVO.setPrdtNm(cart.getPrdtNm());
						// 구분명
						spRsvVO.setDivNm(cart.getPrdtDivNm());
						// 옵션명
						spRsvVO.setOptNm(cart.getOptNm());

						// 상품 정보
						String prdtInf = cart.getPrdtDivNm() + " ";
						log.info("cart.getAplDt() :: " + cart.getAplDt());
						if (cart.getAplDt() != null && !cart.getAplDt().isEmpty()) {
							prdtInf += EgovStringUtil.getDateFormatDash(cart.getAplDt()) + "|";
						}

						prdtInf += cart.getOptNm();
						if (StringUtils.isNoneEmpty(cart.getAddOptNm())) {
							prdtInf += " | " + cart.getAddOptNm();
						}
						prdtInf += " | 수량 : " + cart.getQty();

						//----------마라톤 분기----------//
						String mrtCorpId = spProduct.getCorpId();
						if(mrtCorpId != null) {
							if("CSPM".equals(mrtCorpId.substring(0, 4))) {
								int limit = mrtnVO.getApctNm().split(",").length;
								String[] apctNm = mrtnVO.getApctNm().split(",", limit);
								prdtInf += " | 참가자 : " + apctNm[i];
							}
						}

						spRsvVO.setPrdtInf(prdtInf);
						String salePrdtYn = webSpProductService.saleProductYn(cart.getPrdtNum(), cart.getSpDivSn(), cart.getSpOptSn(), Integer.parseInt(cart.getQty()));
						// 예약가능여부 체크
						if (Constant.FLAG_Y.equals(salePrdtYn)) {
							spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_READY);

							if (StringUtils.isNotEmpty(cart.getAddOptAmt())) {
								spRsvVO.setAddOptAmt(cart.getAddOptAmt());
							} else {
								spRsvVO.setAddOptAmt("0");
							}

							spRsvVO.setNmlAmt(String.valueOf((Integer.parseInt(spProduct.getSaleAmt()) + Integer.parseInt(spRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty())));
							/** 문화누리카드 */
							/*if(mnuricardYn.equals("Y")){
								spRsvVO.setNmlAmt("100");
							}*/
							// 판매금액 - 결제되는 금액
							spRsvVO.setSaleAmt(String.valueOf((Integer.parseInt(spProduct.getSaleAmt()) + Integer.parseInt(spRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty()) - cpAmt));
							/** 문화누리카드 */
							/*if(mnuricardYn.equals("Y")){
								spRsvVO.setSaleAmt("100");
							}*/
							// 할인금액
							spRsvVO.setDisAmt(String.valueOf(cpAmt));
							/** 문화누리카드 */
							/*if(mnuricardYn.equals("Y")){
								spRsvVO.setDisAmt("0");
							}*/
							// 상품 구분
							spRsvVO.setPrdtDiv(spProduct.getPrdtDiv());
							// 적용 일자
							spRsvVO.setAplDt(spProduct.getAplDt());
							// 유효일 수로 할 경우.
							if (Constant.FLAG_Y.equals(spProduct.getExprDaynumYn())) {
								spRsvVO.setExprStartDt(new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()));
								Calendar now = Calendar.getInstance();
								now.add(Calendar.DATE, spProduct.getExprDaynum());
								spRsvVO.setExprEndDt(new SimpleDateFormat("yyyyMMdd").format(now.getTime()));
							} else {
								// 유효 종료 일자
								spRsvVO.setExprEndDt(spProduct.getExprEndDt());
								// 유효시작일자.
								spRsvVO.setExprStartDt(spProduct.getExprStartDt());
							}
							if (spProduct.getUseAbleTm() != null && !StringUtils.isEmpty(String.valueOf(spProduct.getUseAbleTm()))) {
								Calendar now = Calendar.getInstance();
								now.add(Calendar.HOUR, spProduct.getUseAbleTm());
								spRsvVO.setUseAbleDttm(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(now.getTime()));
							}

							/*if(mnuricardYn.equals("Y")){
								cpList = null;
							}*/
						} else {
							spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
							spRsvVO.setNmlAmt("0");
							spRsvVO.setSaleAmt("0");
							spRsvVO.setDisAmt("0");

							// 예약불가능건에 대해 사용쿠폰리스트 삭제
							cpList = null;
						}
						spRsvVO.setRsvNum(rsvNum);
						spRsvVO.setCorpId(spProduct.getCorpId());
						spRsvVO.setPrdtNum(cart.getPrdtNum());
						spRsvVO.setSpDivSn(cart.getSpDivSn());
						spRsvVO.setSpOptSn(cart.getSpOptSn());
						spRsvVO.setBuyNum(cart.getQty());

						spRsvVO.setAddOptNm(cart.getAddOptNm());
						// 할인 취소 금액
						spRsvVO.setDisCancelAmt("0");

						// 소셜상품예약처리
						totalSaleAmt += Integer.parseInt(spRsvVO.getSaleAmt()) - Integer.parseInt(spRsvVO.getDisAmt());
						String spRsvNum = webOrderService.insertSpRsv(spRsvVO);
						/** LPOINT 최대금액 선정*/
						if (maxSaleAmt <= Integer.parseInt(spRsvVO.getSaleAmt()) - Integer.parseInt(spRsvVO.getDisAmt())) {
							maxSaleAmt = Integer.parseInt(spRsvVO.getSaleAmt()) - Integer.parseInt(spRsvVO.getDisAmt());
							maxSaleDtlRsvNum = spRsvNum;
						}
						// 판매 통계 MERGE
						webOrderService.mergeSaleAnls(spRsvVO.getPrdtNum());

						// 포인트 적립이면 DB 등록 (2017-09-07, By JDongS)
						if (Integer.parseInt(rsvVO.getLpointSavePoint()) > 0) {
							LPOINTSAVEINFVO lpointSaveInfVO = new LPOINTSAVEINFVO();
							lpointSaveInfVO.setPrdtRsvNum(spRsvNum);
							lpointSaveInfVO.setPayAmt(spRsvVO.getSaleAmt());
							lpointSaveInfVO.setCardNum(rsvVO.getLpointCardNo());
							webOrderService.insertLpointCardNum(lpointSaveInfVO);
						}

						if (Constant.FLAG_Y.equals(salePrdtYn)) {
							if (cpList != null) {
								// 쿠폰 사용예약번호 셋팅
								for (int cpi = 0; cpi < cpList.size(); cpi++) {
									USER_CPVO useCp = cpList.get(cpi);
									useCp.setUseRsvNum(spRsvNum);
									cpList.set(cpi, useCp);
								}
							}
						}

						//----------마라톤 분기----------//
						//마라톤 신청자, 티셔츠수량 사용 처리
						mrtCorpId = spProduct.getCorpId();
						if(mrtCorpId != null) {
							if("CSPM".equals(mrtCorpId.substring(0, 4))) {
								mrtnVO.setRsvNum(rsvNum);
								mrtnVO.setSpRsvNum(spRsvNum);
								mrtnVO.setCorpId(mrtCorpId);
								mrtnVO.setPrdtNum(spProduct.getPrdtNum());
								mrtnVO.setIndex(i);
								webOrderService.insertMrtnUser(mrtnVO);
							}
						}
						//----------마라톤 분기----------//
					}
					// 관광기념품 예약 처리
					else if (Constant.SV.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {
						log.fatal("[ORDER INFO] SV Reservation");
						WEB_SV_DTLPRDTVO searchVO = new WEB_SV_DTLPRDTVO();
						searchVO.setPrdtNum(cart.getPrdtNum());
						searchVO.setSvDivSn(cart.getSvDivSn());
						searchVO.setSvOptSn(cart.getSvOptSn());

						WEB_SV_DTLPRDTVO svProduct = webSvProductService.selectByCartPrdt(searchVO);
						tamnacardYn = svProduct.getTamnacardYn();

						SV_RSVVO svRsvVO = new SV_RSVVO();
						// 상품명
						svRsvVO.setPrdtNm(cart.getPrdtNm());
						// 구분명
						svRsvVO.setDivNm(cart.getPrdtDivNm());
						// 옵션명
						svRsvVO.setOptNm(cart.getOptNm());
						// 상품 정보
						String prdtInf = cart.getPrdtDivNm() + " ";
						// 직접 수령
						svRsvVO.setDirectRecvYn(cart.getDirectRecvYn());

						prdtInf += cart.getOptNm();
						if (StringUtils.isNoneEmpty(cart.getAddOptNm())) {
							prdtInf += " | " + cart.getAddOptNm();
						}
						prdtInf += " | 수량 : " + cart.getQty();
						svRsvVO.setPrdtInf(prdtInf);

						// 예약가능여부 조회
						String salePrdtYn = webSvProductService.saleProductYn(cart.getPrdtNum(), cart.getSvDivSn(), cart.getSvOptSn(), Integer.parseInt(cart.getQty()));

						// 예약가능여부 체크
						if (Constant.FLAG_Y.equals(salePrdtYn)) {
							svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_READY);

							if (StringUtils.isNotEmpty(cart.getAddOptAmt())) {
								svRsvVO.setAddOptAmt(cart.getAddOptAmt());
							} else {
								svRsvVO.setAddOptAmt("0");
							}

							svRsvVO.setDlvAmtDiv(svProduct.getDlvAmtDiv());

							Integer preSaleAmt = webSvProductService.getSvPreSaleAmt(rsvNum, svProduct.getCorpId());
							svRsvVO.setDlvAmt(cart.getDlvAmt());
							// if 직접수령
							if ("Y".equals(svRsvVO.getDirectRecvYn())) {
								svRsvVO.setDlvAmt("0");
							} else {
								// 묶음 배송인 경우
								// 사업자별 묶음배송비 추가 2021.06.03
								if (!svProduct.getCorpId().equals(p_corpId) || !svProduct.getDlvAmtDiv().equals(p_dlvAmtDiv) || !svProduct.getPrdc().equals(p_prdc)) {
									svRsvVO.setDlvAmt(cart.getDlvAmt());
								} else {
									svRsvVO.setDlvAmt("0");
								}

								// 조건부 무료인 경우
								if (Constant.DLV_AMT_DIV_APL.equals(svProduct.getDlvAmtDiv())) {
									preSaleAmt += (Integer.parseInt(svProduct.getSaleAmt()) + Integer.parseInt(svRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty());

									SV_CORPDLVAMTVO corpDlvAmtVO = masSvService.selectCorpDlvAmt(svProduct.getCorpId());
									// update.
									if (preSaleAmt >= Integer.parseInt(corpDlvAmtVO.getAplAmt())) {
										svRsvVO.setRsvNum(rsvNum);
										svRsvVO.setCorpId(cart.getCorpId());
										webOrderService.updateSvRsvDlvAmt(svRsvVO);
										webOrderService.updateSvRsvDlvPoint(svRsvVO);
										svRsvVO.setDlvAmt("0");
									}
								}

								//개별 배송비인 경우 (배송비가 각각 추가되도록) 2023.03.22
								if(Constant.DLV_AMT_DIV_MAXI.equals(svProduct.getDlvAmtDiv())){
									svRsvVO.setDlvAmt(cart.getDlvAmt());
								}
							}

							p_corpId = svProduct.getCorpId();
							p_dlvAmtDiv = svProduct.getDlvAmtDiv();
							p_prdc = svProduct.getPrdc();

							svRsvVO.setNmlAmt(String.valueOf((Integer.parseInt(svProduct.getSaleAmt()) + Integer.parseInt(svRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty()) + Integer.parseInt(svRsvVO.getDlvAmt())));        //  :: 정산 시 처리위해 상품 금액에 배송비 포함
							// 판매금액 - 결제되는 금액
							svRsvVO.setSaleAmt(String.valueOf((Integer.parseInt(svProduct.getSaleAmt()) + Integer.parseInt(svRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty()) + Integer.parseInt(svRsvVO.getDlvAmt()) - cpAmt));

							// 할인금액
							svRsvVO.setDisAmt(String.valueOf(cpAmt));

						} else {
							svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
							svRsvVO.setNmlAmt("0");
							svRsvVO.setSaleAmt("0");
							svRsvVO.setDisAmt("0");
							svRsvVO.setDlvAmt("0");
							// 예약불가능건에 대해 사용쿠폰리스트 삭제
							cpList = null;
						}
						svRsvVO.setRsvNum(rsvNum);
						svRsvVO.setCorpId(cart.getCorpId());
						svRsvVO.setPrdtNum(cart.getPrdtNum());
						svRsvVO.setSvDivSn(cart.getSvDivSn());
						svRsvVO.setSvOptSn(cart.getSvOptSn());
						svRsvVO.setBuyNum(cart.getQty());

						svRsvVO.setAddOptNm(cart.getAddOptNm());
						// 할인 취소 금액
						svRsvVO.setDisCancelAmt("0");

						// 기념품상품예약처리
						totalSaleAmt += Integer.parseInt(svRsvVO.getSaleAmt()) - Integer.parseInt(svRsvVO.getDisAmt());
						String svRsvNum = webOrderService.insertSvRsv(svRsvVO);
						/** LPOINT 최대금액 선정*/
						if (maxSaleAmt <= Integer.parseInt(svRsvVO.getSaleAmt()) - Integer.parseInt(svRsvVO.getDisAmt())) {
							maxSaleAmt = Integer.parseInt(svRsvVO.getSaleAmt()) - Integer.parseInt(svRsvVO.getDisAmt());
							maxSaleDtlRsvNum = svRsvNum;
						}
						// 판매 통계 MERGE
						webOrderService.mergeSaleAnls(svRsvVO.getPrdtNum());

						// 포인트 적립이면 DB 등록 (2017-09-07, By JDongS)
						if (Integer.parseInt(rsvVO.getLpointSavePoint()) > 0) {
							LPOINTSAVEINFVO lpointSaveInfVO = new LPOINTSAVEINFVO();
							lpointSaveInfVO.setPrdtRsvNum(svRsvNum);
							lpointSaveInfVO.setPayAmt(svRsvVO.getSaleAmt());
							lpointSaveInfVO.setCardNum(rsvVO.getLpointCardNo());
							webOrderService.insertLpointCardNum(lpointSaveInfVO);
						}

						if (Constant.FLAG_Y.equals(salePrdtYn)) {
							if (cpList != null) {
								// 쿠폰 사용예약번호 셋팅
								for (int cpi = 0; cpi < cpList.size(); cpi++) {
									USER_CPVO useCp = cpList.get(cpi);
									useCp.setUseRsvNum(svRsvNum);
									cpList.set(cpi, useCp);
								}
							}
						}
					}
					log.fatal("[ORDER INFO] Reservation End..");

					if (cpList != null && cpList.size() > 0) {
						// 쿠폰 사용 처리
						for (USER_CPVO useCp : cpList) {
							webOrderService.updateUseCp(useCp);
						}
					}

					// 장바구니에서 제외
					cartList.remove(index);
				}
			}
		}
		// 장바구니 예약인 경우
		if (Constant.RSV_DIV_C.equals(rsvVO.getRsvDiv())) {
			request.getSession().setAttribute("cartList", cartList);

			// 로그인된 사용자인 경우 DB 처리
			if (EgovUserDetailsHelper.isAuthenticated()) {
				webCartService.addCart(cartList);
			}
		}

		/***********************************************************************
		 * L.Point 사용 처리 (2017-09-04, By JDongS)
		 ***********************************************************************/
		log.info("L.Point CardNo ==> " + rsvVO.getLpointCardNo());
		if (rsvVO.getLpointCardNo() != null && rsvVO.getLpointCardNo().length() <= 16 && rsvVO.getLpointCardNo().length() >= 15) {
			// 사용 포인트 체크
			LPOINTREQDATAVO reqVO = new LPOINTREQDATAVO();
			reqVO.setServiceID("O100");
			reqVO.cdno = rsvVO.getLpointCardNo();
			ModelMap resultLpoint = actionLPoint(reqVO).getModelMap();
			LPOINTRESPDATAVO lpointVO = (LPOINTRESPDATAVO) resultLpoint.get("lpoint");

			log.info("L.Point Check ==> " + lpointVO.msgCn2 + " :: avl Point ==> " + lpointVO.avlPt);

			Date today = new Date();
			SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyyMMddHHmmss");

			LPOINTUSEINFVO lpointUseInfVO = new LPOINTUSEINFVO();
			lpointUseInfVO.setRsvNum(rsvNum);
			lpointUseInfVO.setCardNum(rsvVO.getLpointCardNo());
			lpointUseInfVO.setPayAmt("" + totalSaleAmt);
			lpointUseInfVO.setUsePoint(rsvVO.getLpointUsePoint());
			lpointUseInfVO.setMaxSaleDtlRsvNum(maxSaleDtlRsvNum);

			// L.Point 카드정보가 정상이면...
			if (lpointVO.msgCn2 == "") {
				if (Integer.parseInt(rsvVO.getLpointUsePoint()) > 0) {    // 포인트 사용이면..
					// L.Point 사용 포인트가 가용포인트 이하이면...
					if (Integer.parseInt(lpointVO.avlPt) >= Integer.parseInt(rsvVO.getLpointUsePoint())) {
						// L.Point 포인트 사용 처리
						reqVO.setServiceID("O730");
						reqVO.setPswd(rsvVO.getLpointCardPw());
						reqVO.setCcoAprno(rsvNum);
						reqVO.setSlAm("" + totalSaleAmt);
						reqVO.setTtnUPt(rsvVO.getLpointUsePoint());
						resultLpoint = actionLPoint(reqVO).getModelMap();
						lpointVO = (LPOINTRESPDATAVO) resultLpoint.get("lpoint");

						log.info("L.Point Use agree No ==> " + lpointVO.aprno + " :: msg ==> " + lpointVO.msgCn1);
						if (lpointVO.aprno != "") {    // L.Point 사용 성공 시 DB 등록
							lpointUseInfVO.setPayAmt("" + totalSaleAmt);
							lpointUseInfVO.setTradeDttm(lpointVO.aprDt + lpointVO.aprHr);
							lpointUseInfVO.setTradeConfnum(lpointVO.aprno);
							lpointUseInfVO.setRequestNum(lpointVO.control.flwNo);
							lpointUseInfVO.setRespCd(lpointVO.control.rspC);
							lpointUseInfVO.setUseRst("사용 성공");
							webOrderService.insertLpointUsePoint(lpointUseInfVO);
						} else { // L.Point 포인트 사용 실패 시
							// 승인 망취소
							log.info("L.Point Cancel (60) ==> start");
							reqVO.setRspC("60");
							resultLpoint = actionLPoint(reqVO).getModelMap();
							log.info("L.Point Cancel (60) ==> end");

							// L.Point 사용 '0원' 처리
							rsvVO.setLpointUsePoint("0");
							webOrderService.updateLpointCancel(rsvVO);

							// 결과 DB 등록
							lpointUseInfVO.setTradeDttm(sdfDateTime.format(today));
							lpointUseInfVO.setTradeConfnum("승인 실패");
							lpointUseInfVO.setRequestNum(lpointVO.control.flwNo);
							lpointUseInfVO.setRespCd(lpointVO.control.rspC);
							lpointUseInfVO.setCancelYn(Constant.FLAG_Y);
							lpointUseInfVO.setUseRst(lpointVO.msgCn1);
							webOrderService.insertLpointUsePoint(lpointUseInfVO);
						}
					} else {
						// L.Point 사용 '0원' 처리
						rsvVO.setLpointUsePoint("0");
						webOrderService.updateLpointCancel(rsvVO);
						// 결과 DB 등록
						lpointUseInfVO.setTradeDttm(sdfDateTime.format(today));
						lpointUseInfVO.setTradeConfnum("사용 오류");
						lpointUseInfVO.setRequestNum(lpointVO.control.flwNo);
						lpointUseInfVO.setRespCd(lpointVO.control.rspC);
						lpointUseInfVO.setCancelYn(Constant.FLAG_Y);
						lpointUseInfVO.setUseRst("사용 포인트가 가용 포인트 보다 커서 사용할 수 없습니다.");
						webOrderService.insertLpointUsePoint(lpointUseInfVO);
					}
				}
			} else {
				// L.Point 사용 & 적립 '0원' 처리
				rsvVO.setLpointUsePoint("0");
				rsvVO.setLpointSavePoint("0");
				webOrderService.updateLpointCancel(rsvVO);
				// 결과 DB 등록
				lpointUseInfVO.setTradeDttm(lpointVO.aprDt + lpointVO.aprHr);
				lpointUseInfVO.setTradeConfnum("카드 오류");
				lpointUseInfVO.setRequestNum(lpointVO.control.flwNo);
				lpointUseInfVO.setRespCd(lpointVO.control.rspC);
				lpointUseInfVO.setCancelYn(Constant.FLAG_Y);
				lpointUseInfVO.setUseRst(lpointVO.msgCn2);
				webOrderService.insertLpointUsePoint(lpointUseInfVO);
			}
		} else {
			// L.Point 사용 & 적립 '0원' 처리
			rsvVO.setLpointUsePoint("0");
			rsvVO.setLpointSavePoint("0");
			webOrderService.updateLpointCancel(rsvVO);
		}

		//point 사용액 세션 저장
		HttpSession cpPointSession = request.getSession();
		cpPointSession.setAttribute("ssUsePoint", rsvVO.getUsePoint());

		// 예약건 금액 총합계 업데이트
		webOrderService.updateTotalAmt(rsvVO);

		/** 탐나는전 가능 상품일경우 코드0000 입력, 결제페이지에서 null이 아닐경우 탐나는전 결제수단제공*/
		if(cartSn.length == 1 && "Y".equals(tamnacardYn)){
			rsvVO.setTamnacardLinkUrl("0000");
			webOrderService.updateRsvTamnacardRefInfo(rsvVO);
		}
		/*if(mnuricardYn.equals("Y")){
			request.getSession().setAttribute("mnuricard", "Y");
			return "redirect:/web/order03.do?rsvNum=" + rsvNum + "&mnuricard=Y";
		}*/
		return "redirect:/web/order03.do?rsvNum=" + rsvNum;
	}

	/**
	 * 결제하기 페이지
	 * 파일명 : order03
	 * 작성일 : 2015. 12. 7. 오전 11:01:34
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/web/order03.do")
	public String order03(@ModelAttribute("RSVVO") RSVVO rsvVO,
						  HttpServletRequest request,
						  HttpServletResponse response,
						  ModelMap model) throws Exception{
		log.info("/web/order03.do Call !!");

		/** 문화누리카드 */
		/*String mnuricardYn = request.getParameter("mnuricard");
		if(mnuricardYn == null){
			mnuricardYn = "N";
		}*/

		/** seq1 통합예약정보 select */
		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

		//파트너(협력사) 포인트 정보
		String ssPartnerCode = (String) request.getSession().getAttribute("ssPartnerCode");
		int usePoint = rsvInfo.getUsePoint();
		if (request.getSession().getAttribute("ssUsePoint") != null) {
			usePoint = (int) request.getSession().getAttribute("ssUsePoint");
		}

		//가용 포인트 보다 사용 포인트가 많을때 fail 처리
		if (usePoint > 0){
			POINTVO pointVO = new POINTVO();
			pointVO.setUserId(rsvInfo.getUserId());
			pointVO.setPartnerCode(ssPartnerCode);
			POINTVO partnerPoint = ossPointService.selectAblePoint(pointVO);

			if (usePoint > partnerPoint.getAblePoint()){
				return "redirect:/web/orderFail2.do";
			}
		}

		model.addAttribute("ssPartnerCode", ssPartnerCode);
		model.addAttribute("usePoint", usePoint);

		/** seq2 예약건이 존재하지 않거나 자동 취소된 경우 처리 exception */
		if(rsvInfo == null){
			return "redirect:/web/orderFail2.do";
		}else{
			if(Constant.RSV_STATUS_CD_ACC.equals(rsvInfo.getRsvStatusCd())){
				return "redirect:/web/orderFail2.do";
			}
		}
		model.addAttribute("rsvInfo", rsvInfo);

		/** 예약 초과시간 set */
		Date fromDate = Calendar.getInstance().getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date toDate = sdf.parse(rsvInfo.getRegDttm());
		long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) + (Constant.WAITING_TIME * 60);
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.SECOND, (int) difTime);
		SimpleDateFormat closeTime = new SimpleDateFormat("yyyyMMddHHmmss");
		model.addAttribute("closeTime", closeTime.format(cal.getTime()));
		model.addAttribute("difTime", difTime);

		/** seq3 상세예약정보 selectList */
		List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);

		/** seq4 대표상품명 set */
		String repPrdtNm = orderList.get(0).getCorpNm() + "-" + orderList.get(0).getPrdtNm();
		model.addAttribute("repPrdtNm", repPrdtNm);

		/** seq5 상품구분 set */
		String orderDiv = null;
		for(ORDERVO order : orderList) {
			if(Constant.SV.equals(order.getPrdtNum().substring(0,2).toUpperCase())) {
				orderDiv = Constant.SV;
				break;
			}
		}

		for(ORDERVO order : orderList) {
			/** seq7 포인트 구매 가능 체크 */
			POINT_CORPVO pointCorpVO = new POINT_CORPVO();
			pointCorpVO.setCorpId(order.getCorpId());
			pointCorpVO.setPartnerCode(ssPartnerCode);
			pointCorpVO.setTotalProductAmt(Integer.valueOf(order.getSaleAmt()));
			if ( "N".equals(ossPointService.chkPointBuyAble(pointCorpVO)) ){
				order.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
			}
		}

		model.addAttribute("orderDiv", orderDiv);
		model.addAttribute("orderList", orderList);

		/** seq8 탐나는전 전용쿠폰인지 if */
		String onlyTamnacard = "N";
		for(ORDERVO order : orderList) {
			USER_CPVO useCp = webOrderService.selectUseCpList(order);
			if(!Objects.isNull(useCp) && EgovStringUtil.isEmpty(useCp.getCpNm()) == false && useCp.getCpNm().indexOf("탐나는전")!=-1) {
				onlyTamnacard = "Y";
				break;
			}
		}
		model.addAttribute("onlyTamnacard", onlyTamnacard);

		/** seq9 토스결제 init(신용카드,계좌이체) */
		String CST_PLATFORM        = EgovProperties.getOptionalProp("CST_PLATFORM");     	//LG유플러스 결제 서비스 선택(test:테스트, service:서비스)

		String CST_MID             = EgovProperties.getProperty("Globals.LgdID.PRE");           	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
		/** 문화누리카드 */
		/*if(mnuricardYn.equals("Y")){
			CST_MID = EgovProperties.getProperty("Globals.LgdID.MNURICARD");
		}*/
		String LGD_MID             = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
		/*String LGD_MID             = CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.*/
		String MERT_KEY			   = EgovProperties.getProperty("Globals.LgdMertKey.PRE");
		/** 문화누리카드 */
		/*if(mnuricardYn.equals("Y")){
			MERT_KEY = EgovProperties.getProperty("Globals.LgdMertKey.MNURICARD");
		}*/
		String LGD_OID = rsvInfo.getRsvNum();
		SimpleDateFormat frm = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String timeStamp = frm.format(new Date());
		StringBuffer sb = new StringBuffer();
		sb.append(LGD_MID);
		sb.append(LGD_OID);
		sb.append(rsvInfo.getTotalSaleAmt());
		sb.append(timeStamp);
		sb.append(MERT_KEY);

		byte[] bNoti = sb.toString().getBytes();
		MessageDigest md = MessageDigest.getInstance("MD5");
		byte[] digest = md.digest(bNoti);

		StringBuffer strBuf = new StringBuffer();
		for (int i=0 ; i < digest.length ; i++) {
			int c = digest[i] & 0xff;
			if (c <= 15){
				strBuf.append("0");
			}
			strBuf.append(Integer.toHexString(c));
		}

		String LGD_HASHDATA = strBuf.toString();
		String LGD_RETURNURL = "local".equals(Constant.FLAG_INIT) ?
				"https://localhost:8443/web/order04.do" :
				request.getScheme() + "://" + request.getServerName() + "/web/order04.do";

		String LGD_CASNOTEURL = "local".equals(Constant.FLAG_INIT) ?
				request.getScheme() + "://" + request.getServerName() + EgovProperties.getProperty("local.CYBER.RETURNURL") :
				request.getScheme() + "://" + request.getServerName() + EgovProperties.getProperty("Globals.CYBER.RETURNURL");

		model.addAttribute("CST_PLATFORM"	, CST_PLATFORM);
		model.addAttribute("LGD_HASHDATA"	, LGD_HASHDATA);
		model.addAttribute("LGD_OID"		, LGD_OID);
		model.addAttribute("timeStamp"		, timeStamp);
		model.addAttribute("CST_MID"		, CST_MID);
		model.addAttribute("LGD_MID"		, LGD_MID);
		model.addAttribute("LGD_RETURNURL"	, LGD_RETURNURL);
		model.addAttribute("LGD_CASNOTEURL"	, LGD_CASNOTEURL);


		/** seq10 토스결제 init(휴대폰결제) */
		String CST_MID_HP          = EgovProperties.getProperty("Globals.LgdID.HP");           	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
		String LGD_MID_HP          = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID_HP;  //테스트 아이디는 't'를 제외하고 입력하세요.
		String MERT_KEY_HP		   = EgovProperties.getProperty("Globals.LgdMertKey.HP");
		StringBuffer sb2 = new StringBuffer();
		sb2.append(LGD_MID_HP);
		sb2.append(LGD_OID);
		sb2.append(rsvInfo.getTotalSaleAmt());
		sb2.append(timeStamp);
		sb2.append(MERT_KEY_HP);

		byte[] bNoti2 = sb2.toString().getBytes();
		MessageDigest md2 = MessageDigest.getInstance("MD5");
		byte[] digest2 = md2.digest(bNoti2);

		StringBuffer strBuf2 = new StringBuffer();
		for (int i=0 ; i < digest2.length ; i++) {
			int c = digest2[i] & 0xff;
			if (c <= 15){
				strBuf2.append("0");
			}
			strBuf2.append(Integer.toHexString(c));
		}

		String LGD_HASHDATA_HP = strBuf2.toString();
		String LGD_RETURNURL_HP = "local".equals(Constant.FLAG_INIT) ?
				"https://localhost:8443/mw/order04_HP.do" :
				request.getScheme() + "://" + request.getServerName() + "/mw/order04_HP.do";

		model.addAttribute("LGD_HASHDATA_HP"	, LGD_HASHDATA_HP);
		model.addAttribute("CST_MID_HP"			, CST_MID_HP);
		model.addAttribute("LGD_MID_HP"			, LGD_MID_HP);
		model.addAttribute("LGD_RETURNURL_HP"	, LGD_RETURNURL_HP);

		String connIp = EgovClntInfo.getClntIP(request);
		model.addAttribute("connIp", connIp);

		return "/web/order/order02";
	}

	@RequestMapping("/web/openTamnacard2.ajax")
	public ModelAndView openTamnacard2(@ModelAttribute RSVVO rsvVO,
									  HttpServletRequest request) throws IOException {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		request.setCharacterEncoding("EUC-KR");

		String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");

		String mer_key = "";
		String symmKey = "";
		String symmIv = "";
		String mer_no = "";

		/** 탐나는전 개발계 */
		if("test".equals(CST_PLATFORM.trim())) {
			mer_key = "i1s8g528mw3o667v1s00w26ug88m3sj5gx1nj8wd";
			symmKey = "0q5u3qgg5521vky4h93u";
			symmIv  = "h203kcp0yjk1rq9lc874";
			mer_no  = "123020004701";
		/** 탐나는전 운영계 */
		}else{
			mer_key = "m6c0wm8sdqh2u0vo19z5a4meiiuizt2v9e9jm00g";
			symmKey = "f4v584x5m5ptv6jmymj8";
			symmIv  = "40562sai7vyl5b9yl8yv";
			mer_no  = "123010004171";
		}

		boolean testServer = true;				//나이스 테스트 서버 연결

		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat tf = new SimpleDateFormat("HHmmss");
		SimpleDateFormat trdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String res_url = "";

		Date today = new Date();
		String pos_date = df.format(today);
		String pos_time = tf.format(today);
		String tr_id = trdf.format(today);

		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

		NmcLiteOrder nmcLite = new NmcLiteOrder(mer_key, symmKey, symmIv);

		/** 테스트 연동 (운영 변환시 주석 처리) */
		if("test".equals(CST_PLATFORM.trim())) {
			nmcLite.setTestServer(testServer);
		}

		nmcLite.setReqField("trace_no", System.currentTimeMillis() + "");		//요청 번호 (단순 로그 추적용)
		nmcLite.setReqField("mer_no", mer_no);	//가맹점번호
		nmcLite.setReqField("goods_amt", rsvInfo.getTotalSaleAmt());		//상품금액
		nmcLite.setReqField("goods_name", rsvVO.getRepPrdtNm());	//상품명
		nmcLite.setReqField("cust_id", rsvInfo.getRsvEmail()); //회원ID
		//nmcLite.setReqField("p_callback_url", "http://tamnao.iptime.org/ext/tamnacardCallback"); //콜백URL
		nmcLite.setReqField("p_callback_url", request.getScheme() + "://" + request.getServerName() + "/ext/tamnacardCallback"); //콜백URL
		nmcLite.setReqField("tax_free_amt", "0"); //비과세금액
		nmcLite.setReqField("moid", rsvInfo.getRsvNum()); //주문번호(선택)
		nmcLite.setReqField("card_goods_id", request.getParameter("card_goods_id")); //카드상품ID(선택)
		nmcLite.setReqField("goods_code", request.getParameter("goods_code")); //상품코드(선택)
		nmcLite.setReqField("vat_amt", request.getParameter("vat_amt")); //상품 부과세(선택)

		nmcLite.setReqField("order_req_dt", pos_date);								//요청일자
		nmcLite.setReqField("order_req_tm", pos_time);								//요청시간

		// 승인 요청
		nmcLite.startAction();
		String result_code = nmcLite.getResValue("result_cd"); 			//응답코드 '0000' 경우 만 성공
		String result_msg = nmcLite.getResValue("result_msg");				//응답메시지

		String tid = nmcLite.getResValue("tid");             //거래ID
		String hash_tid = nmcLite.getResValue("hash_tid");             //주문거래 HID
		String order_dt = nmcLite.getResValue("order_dt");             //응답일자
		String order_tm = nmcLite.getResValue("order_tm");             //응답시간
		String next_mobile_url = nmcLite.getResValue("next_mobile_url");             //Mobile 결제 페이지
		String next_pc_url = nmcLite.getResValue("next_pc_url");             //PC 결제 페이지

		log.info("tamnacardOrderResultStatus : " + "{" + result_code + "," + result_msg + "," + tid + "," + hash_tid +"}");
		log.info(request.getScheme() + "://" + request.getServerName() + "/ext/tamnacardCallback");

		if(result_code.equals("0000")){

			if(!rsvVO.getAppDiv().equals("PC")){
				resultMap.put("tamnacardLinkUrl",nmcLite.getResValue("next_mobile_url"));
			}else{
				resultMap.put("tamnacardLinkUrl",nmcLite.getResValue("next_pc_url"));
			}

			//주문 정보를 디비에 저장
			Map<String,String> param = new HashMap<String,String>();
			param.put("tid", nmcLite.getResValue("tid"));
			param.put("goods_amt", request.getParameter("goods_amt"));
			param.put("cust_id", request.getParameter("cust_id"));
			param.put("moid", request.getParameter("moid"));

			/** DB정보저장 */
			rsvVO.setTamnacardRefId(nmcLite.getResValue("tid"));
			rsvVO.setTamnacardRefHashid(nmcLite.getResValue("hash_tid"));
			rsvVO.setTamnacardLinkUrl((String)resultMap.get("tamnacardLinkUrl"));
			webOrderService.updateRsvTamnacardRefInfo(rsvVO);
			HttpSession session = request.getSession();
			session.setAttribute(nmcLite.getResValue("hash_tid"),param);
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}



	/**
	 * 주문취소
	 * 파일명 : orderCancel
	 * 작성일 : 2016. 11. 8. 오전 10:29:10
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws NoSuchAlgorithmException
	 * @throws InvalidKeyException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping("/web/orderCancel.ajax")
	public ModelAndView orderCancel(@ModelAttribute("RSVVO") RSVVO rsvVO,
									HttpServletRequest request,
									HttpServletResponse response) throws JsonParseException, JsonMappingException, InvalidKeyException, NoSuchAlgorithmException, IOException{
		Map<String, Object> resultMap = new HashMap<String,Object>();

		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

		if(rsvInfo == null){
			resultMap.put("success", Constant.FLAG_N);
			resultMap.put("rtnMsg", "예약정보가 존재하지 않습니다.");
		}else{
			// RSV_STATUS_CD_ACC(RS99, 자동취소)
			if(Constant.RSV_STATUS_CD_ACC.equals(rsvInfo.getRsvStatusCd())){
				resultMap.put("success", Constant.FLAG_N);
				resultMap.put("rtnMsg", "이미 취소된 예약건입니다.");
			}
			// RSV_STATUS_CD_READY(RS00, 예약대기)
			else if(!Constant.RSV_STATUS_CD_READY.equals(rsvInfo.getRsvStatusCd())){
				resultMap.put("success", Constant.FLAG_N);
				resultMap.put("rtnMsg", "취소가 불가능한 예약건입니다.");
			}
			// RSV_STATUS_CD_READY(RS00, 예약대기)
			else if(Constant.RSV_STATUS_CD_READY.equals(rsvInfo.getRsvStatusCd())){
				// 예약 상품 리스트
				List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);

				// L.Point 사용 금액 취소 처리
				LPOINTUSEINFVO lpointUseInfVO = new LPOINTUSEINFVO();
				lpointUseInfVO.setRsvNum(rsvVO.getRsvNum());
				lpointUseInfVO.setCancelYn(Constant.FLAG_N);
				lpointUseInfVO.setRsvCancelYn(Constant.FLAG_N);
				lpointUseInfVO = webOrderService.selectLpointUsePoint(lpointUseInfVO);
				if (lpointUseInfVO != null) {
					log.info("L.Point delete action!");

					WebOrderController webOrder = new WebOrderController();

					LPOINTREQDATAVO reqVO = new LPOINTREQDATAVO();
					reqVO.setServiceID("O740");
					reqVO.setCdno(lpointUseInfVO.getCardNum());
					reqVO.setCcoAprno(lpointUseInfVO.getRsvNum());
					reqVO.setTtnUPt(lpointUseInfVO.getUsePoint());
					reqVO.setOtAprno(lpointUseInfVO.getTradeConfnum());
					reqVO.setOtDt(lpointUseInfVO.getTradeDttm().substring(0, 10).replaceAll("-", ""));
					ModelMap resultLpoint = webOrder.actionLPoint(reqVO).getModelMap();
					LPOINTRESPDATAVO lpointVO = (LPOINTRESPDATAVO) resultLpoint.get("lpoint");

					log.info("L.Point Cancel agree No ==> " + lpointVO.aprno + " :: msg ==> " + lpointVO.msgCn1);
					if (lpointVO.aprno != "") {	// L.Point 취소 성공 시 DB 등록
						lpointUseInfVO.setTradeDttm(lpointVO.aprDt + lpointVO.aprHr);
						lpointUseInfVO.setTradeConfnum(lpointVO.aprno);
						lpointUseInfVO.setRequestNum(lpointVO.control.flwNo);
						lpointUseInfVO.setRespCd(lpointVO.control.rspC);
						lpointUseInfVO.setUseRst("취소 성공");
						lpointUseInfVO.setRsvCancelYn(Constant.FLAG_Y);
						lpointUseInfVO.setCancelYn(Constant.FLAG_Y);

						webOrderService.cancelLpointUsePoint(lpointUseInfVO);
						log.info("L.Point lpointUseCancel End ==> ");
					} else { // L.Point 포인트 취소 실패 시
						String useRst = lpointVO.msgCn1;
						// L.Point 망취소 전송
						log.info("L.Point Cancel (60) ==> start");
						reqVO.setRspC("60");
						// 		resultLpoint = webOrder.actionLPoint(reqVO).getModelMap();
						log.info("L.Point Cancel (60) ==> end");

						// 결과 DB 등록
						Date today = new Date();
						SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyyMMddHHmmss");

						lpointUseInfVO.setTradeDttm(sdfDateTime.format(today));
						lpointUseInfVO.setTradeConfnum(lpointVO.aprno);
						lpointUseInfVO.setRsvCancelYn(Constant.FLAG_Y);
						lpointUseInfVO.setUseRst("취소 실패 (" + useRst + ")");
						webOrderService.cancelLpointUsePoint(lpointUseInfVO);
					}

					log.info("L.Point delete end!");
				}

				for(ORDERVO order : orderList) {
					// 쿠폰 취소처리
					webOrderService.cancelUserCp(order.getPrdtRsvNum());

					// 숙박
					if(Constant.ACCOMMODATION.equals(order.getPrdtCd())){

						AD_RSVVO adRsvVO = new AD_RSVVO();
						adRsvVO.setAdRsvNum(order.getPrdtRsvNum());
						adRsvVO = masRsvService.selectAdDetailRsv(adRsvVO);

						webOrderService.updateAdAcc(adRsvVO);
					}
					// 렌터카
					else if(Constant.RENTCAR.equals(order.getPrdtCd())){
						RC_RSVVO rcRsvVO = new RC_RSVVO();
						rcRsvVO.setRcRsvNum(order.getPrdtRsvNum());
						rcRsvVO = masRsvService.selectRcDetailRsv(rcRsvVO);

						webOrderService.updateRcAcc(rcRsvVO);
					}
					// 기념품
					else if(Constant.SV.equals(order.getPrdtCd())){
						SV_RSVVO svRsvVO = new SV_RSVVO();

						svRsvVO.setSvRsvNum(order.getPrdtRsvNum());
						svRsvVO = masRsvService.selectSvDetailRsv(svRsvVO);

						webOrderService.updateSvAcc(svRsvVO);
					}
					// 소셜
					else{
						SP_RSVVO spRsvVO = new SP_RSVVO();

						spRsvVO.setSpRsvNum(order.getPrdtRsvNum());
						spRsvVO = masRsvService.selectSpDetailRsv(spRsvVO);

						webOrderService.updateSpAcc(spRsvVO);
					}
				}
				rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_ACC);
				webOrderService.updateAcc(rsvVO);

				resultMap.put("success", Constant.FLAG_Y);
			}
		}

		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	@RequestMapping("/web/order04.do")
	public String order04(	HttpServletRequest request,
							  HttpServletResponse response,
							  ModelMap model) throws UnsupportedEncodingException{
		log.info("/web/order04.do Call !!");

		String LGD_RESPCODE = request.getParameter("LGD_RESPCODE");
		String LGD_RESPMSG 	= request.getParameter("LGD_RESPMSG");
		String LGD_PAYKEY 	= request.getParameter("LGD_PAYKEY");

		model.addAttribute("LGD_RESPCODE", LGD_RESPCODE);
		model.addAttribute("LGD_RESPMSG", LGD_RESPMSG);
		model.addAttribute("LGD_PAYKEY", LGD_PAYKEY);
		return "/web/order/lgdReturn";
	}

	@RequestMapping("/web/order05.do")
	public String order05(	@ModelAttribute("RSVVO") RSVVO rsvVO,
							  HttpServletRequest request,
							  HttpServletResponse response,
							  RedirectAttributes redirect,
							  ModelMap model) throws Exception{

		log.info("/web/order05.do Call !!");

		// 예약기본정보
		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

		// 예약건이 존재하지 않거나 자동 취소된 경우 처리
		if(rsvInfo == null){
			return "redirect:/web/orderFail2.do";
		}else{
			// Constant.RSV_STATUS_CD_ACC(자동취소 : RS99)인 경우
			if(Constant.RSV_STATUS_CD_ACC.equals(rsvInfo.getRsvStatusCd())){
				return "redirect:/web/orderFail2.do";
			}
		}

		// 파트너(협력사) 포인트 set
		String ssPartnerCode = (String) request.getSession().getAttribute("ssPartnerCode");
		int ssUsePoint = (int) request.getSession().getAttribute("ssUsePoint");
		POINTVO pointVO = new POINTVO();
		pointVO.setPartnerCode(ssPartnerCode);
		pointVO.setPoint(ssUsePoint);
		pointVO.setUserId(rsvInfo.getUserId());

		//가용포인트보다 사용포인트가 많을경우에는 예외 처리
		POINTVO partnerPoint = ossPointService.selectAblePoint(pointVO);
		if( partnerPoint.getAblePoint() < ssUsePoint){
			return "redirect:/web/orderFail4.do";
		}

		String payMehtod = request.getParameter("PayMethod");

		if("LG".equals(payMehtod)){
			//LG유플러스에서 제공한 환경파일
			String configPath = EgovProperties.getProperty(Constant.FLAG_INIT + ".LgdFolder");

			/*
			 *************************************************
			 * 1.최종결제 요청 - BEGIN
			 *  (단, 최종 금액체크를 원하시는 경우 금액체크 부분 주석을 제거 하시면 됩니다.)
			 *************************************************
			 */

			String CST_PLATFORM                 = request.getParameter("CST_PLATFORM");
			String CST_MID                      = request.getParameter("CST_MID");
			String LGD_MID                      = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
			String LGD_PAYKEY                   = request.getParameter("LGD_PAYKEY");
			LGPAYINFVO lGPAYINFO = new LGPAYINFVO();
			String rtnMsg 	= "";
			String rtnTitle = "";
			String rtnCode 	= "";

			//해당 API를 사용하기 위해 WEB-INF/lib/XPayClient.jar 를 Classpath 로 등록하셔야 합니다.
			XPayClient xpay = new XPayClient();
			boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);

			if( !isInitOK ) {
				//API 초기화 실패 화면처리
				log.error( "결제요청을 초기화 하는데 실패하였습니다.");
				log.error( "LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.");
				log.error( "mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.");
				log.error( "문의전화 LG유플러스 1544-7772");

				rtnTitle =  "결제요청을 초기화 하는데 실패하였습니다. 고객센터에 문의하시기 바랍니다.";
				rtnMsg   = "LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.";

				model.addAttribute("rtnCode", rtnCode);
				model.addAttribute("rtnMsg", rtnMsg);
				return "/web/order/orderFail";
			}else{
				try{
					/*
					 *************************************************
					 * 1.최종결제 요청(수정하지 마세요) - END
					 *************************************************
					 */
					if(!"".equals(LGD_PAYKEY)){
						xpay.Init_TX(LGD_MID);
						xpay.Set("LGD_TXNAME", "PaymentByKey");
						xpay.Set("LGD_PAYKEY", LGD_PAYKEY);
					}else{

					}

					//금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
					//String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
					//xpay.Set("LGD_AMOUNTCHECKYN", "Y");
					//xpay.Set("LGD_AMOUNT", DB_AMOUNT);

				}catch(Exception e) {
					log.error("LG유플러스 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
					log.error(""+e.getMessage());

					rtnCode = "-1";
					rtnTitle =  "LG유플러스 제공 API를 사용할 수 없습니다. 고객센터에 문의하시기 바랍니다. ";
					rtnMsg   = e.getMessage();
					model.addAttribute("rtnCode", rtnCode);
					model.addAttribute("rtnTitle", rtnTitle);
					model.addAttribute("rtnMsg", rtnMsg);
					model.addAttribute("CSNUM", EgovProperties.getProperty("CS.PHONE"));
					return "/web/order/orderFail";
				}
			}
			/*
			 * 2. 최종결제 요청 결과처리
			 *
			 * 최종 결제요청 결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
			 */
			if ( xpay.TX() ) {
				rtnTitle = "결제요청이 완료되었습니다.";
				rtnMsg   = xpay.m_szResMsg;
				rtnCode  = xpay.m_szResCode;

				//1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
				log.info( "결제요청이 완료되었습니다.");
				log.info( "TX 결제요청 Response_code = " + xpay.m_szResCode);
				log.info( "TX 결제요청 Response_msg = " + xpay.m_szResMsg);

				log.info("거래번호 : " + xpay.Response("LGD_TID",0));
				log.info("상점아이디 : " + xpay.Response("LGD_MID",0));
				log.info("상점주문번호 : " + xpay.Response("LGD_OID",0));
				log.info("결제금액 : " + xpay.Response("LGD_AMOUNT",0));
				log.info("결과코드 : " + xpay.Response("LGD_RESPCODE",0));
				log.info("결과메세지 : " + xpay.Response("LGD_RESPMSG",0));

				/** 간편결제 타입초기화 */
		    	lGPAYINFO.setLGD_EASYPAY_TRANTYPE("N");
				for (int i = 0; i < xpay.ResponseNameCount(); i++){
					for (int j = 0; j < xpay.ResponseCount(); j++){
						log.info(xpay.ResponseName(i) + " = " + xpay.Response(xpay.ResponseName(i), j));
						if(xpay.ResponseName(i).equals("LGD_EASYPAY_TRANTYPE")){
							if(xpay.Response(xpay.ResponseName(i), j).equals("KAKAOPAY")){
								lGPAYINFO.setLGD_EASYPAY_TRANTYPE("KAKAOPAY");
							}else if(xpay.Response(xpay.ResponseName(i), j).equals("APPLEPAY")){
								lGPAYINFO.setLGD_EASYPAY_TRANTYPE("APPLEPAY");
							}else if(xpay.Response(xpay.ResponseName(i), j).equals("NAVERPAY_CARD") || xpay.Response(xpay.ResponseName(i), j).equals("NAVERPAY_POINT")){
								lGPAYINFO.setLGD_EASYPAY_TRANTYPE("NAVERPAY");
							}else if(xpay.Response(xpay.ResponseName(i), j).equals("TOSSPAY")){
								lGPAYINFO.setLGD_EASYPAY_TRANTYPE("TOSSPAY");
							}
						}
					}
				}
				// 결제 결과 저장
				lGPAYINFO.setLGD_OID				(xpay.Response("LGD_OID",0));
				lGPAYINFO.setLGD_RESPCODE			(xpay.m_szResCode);
				lGPAYINFO.setLGD_RESPMSG			(xpay.m_szResMsg);
				lGPAYINFO.setLGD_AMOUNT			(xpay.Response("LGD_AMOUNT",0));
				lGPAYINFO.setLGD_TID				(xpay.Response("LGD_TID",0));
				lGPAYINFO.setLGD_PAYTYPE			(xpay.Response("LGD_PAYTYPE",0));
				lGPAYINFO.setLGD_PAYDATE			(xpay.Response("LGD_PAYDATE",0));
				lGPAYINFO.setLGD_FINANCECODE		(xpay.Response("LGD_FINANCECODE",0));
				lGPAYINFO.setLGD_FINANCENAME		(xpay.Response("LGD_FINANCENAME",0));
				lGPAYINFO.setLGD_ESCROWYN			(xpay.Response("LGD_ESCROWYN",0));
				lGPAYINFO.setLGD_BUYER				(xpay.Response("LGD_BUYER",0));
				lGPAYINFO.setLGD_BUYERID			(xpay.Response("LGD_BUYERID",0));
				lGPAYINFO.setLGD_BUYERPHONE		(xpay.Response("LGD_BUYERPHONE",0));
				lGPAYINFO.setLGD_BUYEREMAIL		(xpay.Response("LGD_BUYEREMAIL",0));
				lGPAYINFO.setLGD_PRODUCTINFO		(xpay.Response("LGD_PRODUCTINFO",0));
				lGPAYINFO.setLGD_CARDNUM			(xpay.Response("LGD_CARDNUM",0));
				lGPAYINFO.setLGD_CARDINSTALLMONTH	(xpay.Response("LGD_CARDINSTALLMONTH",0));
				lGPAYINFO.setLGD_CARDNOINTYN		(xpay.Response("LGD_CARDNOINTYN",0));
				lGPAYINFO.setLGD_FINANCEAUTHNUM	(xpay.Response("LGD_FINANCEAUTHNUM",0));
				lGPAYINFO.setLGD_CASHRECEIPTNUM	(xpay.Response("LGD_CASHRECEIPTNUM",0));
				lGPAYINFO.setLGD_CASHRECEIPTSELFYN	(xpay.Response("LGD_CASHRECEIPTSELFYN",0));
				lGPAYINFO.setLGD_CASHRECEIPTKIND	(xpay.Response("LGD_CASHRECEIPTKIND",0));
				lGPAYINFO.setLGD_CUSTOM_USABLEPAY	(xpay.Response("LGD_CUSTOM_USABLEPAY",0));
				lGPAYINFO.setLGD_CASFLAGY			(xpay.Response("LGD_CASFLAG",0));
				lGPAYINFO.setLGD_ACCOUNTNUM			(xpay.Response("LGD_ACCOUNTNUM",0));
				lGPAYINFO.setLGD_PAYER			(xpay.Response("LGD_PAYER",0));

				if( "0000".equals( xpay.m_szResCode ) ) {
					boolean result = apiService.apiReservation(xpay.Response("LGD_OID",0));
					if(!result){
						xpay.Rollback("API 연동 실패로 인한 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
						log.info("fail : API order error");
						model.addAttribute("rtnCode", "상품수량만료");
						model.addAttribute("rtnMsg", "해당 상품을 이용할 수 없습니다. 불편을 드려죄송합니다.");
						return "/web/order/orderFail";
					}

					//최종결제요청 결과 성공 DB처리
					log.info(lGPAYINFO.getLGD_OID() + " 최종결제요청 결과 성공 DB처리하시기 바랍니다.");

					//최종결제요청 결과 성공 DB처리 실패시 Rollback 처리
					//boolean isDBOK = true; //DB처리 실패시 false로 변경해 주세요.

					try {
						//파트너 포인트 사용처리
						if (ssPartnerCode.length() > 0 && ssUsePoint > 0) {
							pointVO.setPlusMinus("M");
							pointVO.setTypes("USE");
							pointVO.setRsvNum(rsvInfo.getRsvNum());
							pointVO.setTotalSaleAmt(Integer.parseInt(rsvInfo.getTotalNmlAmt()) - Integer.parseInt(rsvInfo.getTotalDisAmt()));
							ossPointService.pointCpUse(pointVO);
						}

						//결제완료 처리
						webOrderService.updateRsvComplete(lGPAYINFO);

					} catch (Exception e) {
						rtnCode = "-1";
						xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
						log.info( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0));
						log.info( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0));

						if( "0000".equals( xpay.m_szResCode ) ) {
							log.info("자동취소가 정상적으로 완료 되었습니다.");
						}else{
							log.info("자동취소가 정상적으로 처리되지 않았습니다.");
						}
					}

					rtnCode = xpay.m_szResCode;
				}else{
					//최종결제요청 결과 실패 DB처리
					log.info("최종결제요청 결과 실패 DB처리하시기 바랍니다.");
					rtnTitle = "최종결제요청 결과 실패";
					webOrderService.insertLDGINFO(lGPAYINFO);
				}
			}else {
				rtnTitle = "결제요청이 실패하였습니다.";
				//2)API 요청실패 화면처리
				log.info( "결제요청이 실패하였습니다.");
				log.info( "TX 결제요청 Response_code = " + xpay.m_szResCode);
				log.info( "TX 결제요청 Response_msg = " + xpay.m_szResMsg);


				rtnMsg = xpay.m_szResMsg;
				//최종결제요청 결과 실패 DB처리
				log.info("최종결제요청 결과 실패 DB처리하시기 바랍니다.");
				webOrderService.insertLDGINFO(lGPAYINFO);
			}

			if("0000".equals(rtnCode)){
				/** 무통장입금 대기상태가 아니면*/
				if(!"R".equals(lGPAYINFO.getLGD_CASFLAGY())) {
					log.info("OK=====================================");
					//문자, SMS보내기
					webOrderService.orderCompleteSnedSMSMail(rsvVO, request);

					//자동쿠폰발행
					webUserCpService.baapCpPublish(rsvInfo);

					return "redirect:/web/orderComplete.do?rsvNum=" + lGPAYINFO.getLGD_OID();
				}else{
					return "redirect:/web/orderCompleteVaccount.do?rsvNum=" + lGPAYINFO.getLGD_OID();
				}

			}else{
				model.addAttribute("rtnCode", rtnCode);
				model.addAttribute("rtnMsg", rtnMsg);
				return "/web/order/orderFail";
			}
		}else if("FREECP".equals(payMehtod) || "LPOINT".equals(payMehtod) || "POINT".equals(payMehtod)){
			boolean result = apiService.apiReservation(rsvInfo.getRsvNum());
			if(!result){
				model.addAttribute("rtnCode", "상품수량만료");
				model.addAttribute("rtnMsg", "해당 상품을 이용할 수 없습니다. 불편을 드려죄송합니다.");
				return "/web/order/orderFail";
			}

			// 무료쿠폰, L.Point, 파트너포인트 전체 결제
			switch(payMehtod){
				case "FREECP" : rsvInfo.setPayDiv(Constant.PAY_DIV_LG_FI); break;
				case "LPOINT" : rsvInfo.setPayDiv(Constant.PAY_DIV_LG_LI); break;
				case "POINT" : rsvInfo.setPayDiv(Constant.PAY_DIV_TA_PI); break;
			}

			// 결제 성공
			webOrderService.updateRsvComplete3(rsvInfo);
			//문자, SMS보내기
			webOrderService.orderCompleteSnedSMSMail(rsvVO,request);

			//자동쿠폰발행
			webUserCpService.baapCpPublish(rsvInfo);

			return "redirect:/web/orderComplete.do?rsvNum=" + rsvVO.getRsvNum();
		}else{
			model.addAttribute("rtnCode", "9999");
			model.addAttribute("rtnMsg", "결제정보가 올바르지 않습니다.");
			return "/web/order/orderFail";
		}
	}

	/**
	 * 주문완료
	 * 파일명 : orderComplete
	 * 작성일 : 2015. 12. 8. 오후 2:40:00
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/orderComplete.do")
	public String orderComplete(@ModelAttribute("RSVVO") RSVVO rsvVO,
								ModelMap model){
		log.info("/web/orderComplete.do Call !!");

		// 예약기본정보
		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);
		model.addAttribute("rsvInfo", rsvInfo);
		// 예약 상품 리스트
		List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);
		model.addAttribute("orderList", orderList);

		return "/web/order/orderComplete";
	}

	@RequestMapping("/web/orderCompleteVaccount.do")
	public String orderCompleteVaccount(@ModelAttribute("RSVVO") RSVVO rsvVO,
										ModelMap model) throws ParseException {
		log.info("/web/orderCompleteVaccount.do Call !!");

		// 예약기본정보
		rsvVO.setLGD_RESPCODE("8888");
		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);
		model.addAttribute("rsvInfo", rsvInfo);
		// 예약 상품 리스트
		List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);
		model.addAttribute("orderList", orderList);

		LGPAYINFVO payInfo = webOrderService.selectLGPAYINFO_V(rsvVO);
		model.addAttribute("payInfo", payInfo);

		Date fromDate = Calendar.getInstance().getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date toDate = sdf.parse(rsvInfo.getRegDttm());

		long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) + (Constant.WAITING_TIME * 60);

		model.addAttribute("difTime", difTime);

		return "/web/order/orderCompleteVaccount";
	}

	/**
	 * 즉시구매
	 * 파일명 : instantBuy
	 * 작성일 : 2015. 11. 19. 오후 3:37:36
	 * 작성자 : 최영철
	 * @param cartListVO
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/web/instantBuy.ajax")
	public ModelAndView instantBuy(@RequestBody CARTLISTVO cartListVO,
								   HttpServletRequest request,
								   HttpServletResponse response){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<CARTVO> sessionCartList = new ArrayList<CARTVO>();
		List<CARTVO> cartList = cartListVO.getCartList();

		Integer cartSn = 1;
		int totalProductAmt = 0;

		for(CARTVO cart:cartList){
			cart.setCartSn(cartSn);
			cartSn++;

			if(Constant.RENTCAR.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())){
				RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
//				BeanUtils.copyProperties(cart, prdtSVO);
				prdtSVO.setFirstIndex(0);
				prdtSVO.setLastIndex(1);
				prdtSVO.setsFromDt(cart.getFromDt());
				prdtSVO.setsToDt(cart.getToDt());
				prdtSVO.setsFromTm(cart.getFromTm());
				prdtSVO.setsToTm(cart.getToTm());
				prdtSVO.setsPrdtNum(cart.getPrdtNum());

				// 단건에 대한 렌터카 정보 조회
				RC_PRDTINFVO prdtInfo = webRcProductService.selectRcPrdt(prdtSVO);

				cart.setSaleAmt(prdtInfo.getSaleAmt());
				cart.setTotalAmt(String.valueOf(Integer.valueOf(prdtInfo.getSaleAmt()) + Integer.valueOf(cart.getAddAmt())));
				cart.setCtgr("RC");

			} else if(Constant.ACCOMMODATION.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {

				int nPrice = webAdProductService.getTotalPrice(  cart.getPrdtNum()
						, cart.getStartDt()
						, cart.getNight()
						, cart.getAdultCnt()
						, cart.getJuniorCnt()
						, cart.getChildCnt());

				if(nPrice <= 0){

				}

				cart.setSaleAmt(""+nPrice);
				cart.setTotalAmt(""+nPrice);
				cart.setCtgr("AD");

			} else if(Constant.SOCIAL.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {
				WEB_DTLPRDTVO searchVO = new WEB_DTLPRDTVO();
				searchVO.setPrdtNum(cart.getPrdtNum());
				searchVO.setSpDivSn(cart.getSpDivSn());
				searchVO.setSpOptSn(cart.getSpOptSn());
				WEB_DTLPRDTVO spProduct = webSpProductService.selectByCartPrdt(searchVO);
				int addOptAmt = 0;
				if(spProduct == null) {
					log.info("spProduct null");
					resultMap.put("result", Constant.FLAG_N);
				} else {
					cart.setPrdtNm(spProduct.getPrdtNm());
					cart.setSaleAmt(spProduct.getSaleAmt());
					cart.setPrdtDivNm(spProduct.getPrdtDivNm());
					cart.setOptNm(spProduct.getOptNm());
					cart.setCtgrNm(spProduct.getCtgrNm());
					cart.setNmlAmt(spProduct.getNmlAmt());
					cart.setAplDt(spProduct.getAplDt());
					if(StringUtils.isNotEmpty(cart.getAddOptAmt())) {
						addOptAmt = Integer.valueOf(cart.getAddOptAmt());
					} else {
						addOptAmt = 0;
					}
					cart.setTotalAmt(String.valueOf(Integer.valueOf(cart.getQty()) * (Integer.valueOf(spProduct.getSaleAmt()) + addOptAmt)));
					cart.setCtgr(spProduct.getCtgr());

				}
			} else if(Constant.SV.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {
				WEB_SV_DTLPRDTVO searchVO = new WEB_SV_DTLPRDTVO();
				searchVO.setPrdtNum(cart.getPrdtNum());
				searchVO.setSvDivSn(cart.getSvDivSn());
				searchVO.setSvOptSn(cart.getSvOptSn());
				WEB_SV_DTLPRDTVO svProduct = webSvProductService.selectByCartPrdt(searchVO);
				int addOptAmt = 0;
				if(svProduct == null) {
					log.info("svProduct null");
					resultMap.put("result", Constant.FLAG_N);
				} else {
					cart.setPrdtNm(svProduct.getPrdtNm());
					cart.setSaleAmt(svProduct.getSaleAmt());
					cart.setPrdtDivNm(svProduct.getPrdtDivNm());
					cart.setOptNm(svProduct.getOptNm());
					cart.setCtgrNm(svProduct.getCtgrNm());
					cart.setNmlAmt(svProduct.getNmlAmt());
					cart.setCorpId(svProduct.getCorpId());

					cart.setDlvAmtDiv(svProduct.getDlvAmtDiv());

					//개별 배송비 로직 추가 2021.05.21 chaewan.jung
					//개당 배송비 기준으로 변경 => ceil(구매수량/개별배송수량)
					if (svProduct.getDlvAmtDiv().equals(Constant.DLV_AMT_DIV_MAXI)){
						int DlvCnt =  (int) Math.ceil(Double.valueOf(cart.getQty()) / Double.valueOf(svProduct.getMaxiBuyNum()));
						cart.setDlvAmt(String.valueOf(Integer.valueOf(svProduct.getDlvAmt()) * DlvCnt));
						cart.setOutDlvAmt(String.valueOf(Integer.valueOf(svProduct.getDlvAmt()) * DlvCnt));
						cart.setInDlvAmt(String.valueOf(Integer.valueOf(svProduct.getDlvAmt()) * DlvCnt));
					}else {
						cart.setDlvAmt(svProduct.getDlvAmt());
						cart.setOutDlvAmt(svProduct.getDlvAmt());
						cart.setInDlvAmt(svProduct.getInDlvAmt());
					}

					cart.setAplAmt(svProduct.getAplAmt());
					cart.setMaxiBuyNum(svProduct.getMaxiBuyNum());

					if(StringUtils.isNotEmpty(cart.getAddOptAmt())) {
						addOptAmt = Integer.valueOf(cart.getAddOptAmt());
					} else {
						addOptAmt = 0;
					}
					cart.setTotalAmt(String.valueOf(Integer.valueOf(cart.getQty()) * (Integer.valueOf(svProduct.getSaleAmt()) + addOptAmt)));
					cart.setCtgr("SV");
				}
			}
			totalProductAmt += Integer.valueOf(cart.getTotalAmt());
			sessionCartList.add(cart);
		}

		/** 포인트 구매 가능 체크*/
		POINT_CORPVO pointCorpVO = new POINT_CORPVO();
		pointCorpVO.setCorpId(sessionCartList.get(0).getCorpId());
		pointCorpVO.setPartnerCode((String) request.getSession().getAttribute("ssPartnerCode"));
		pointCorpVO.setTotalProductAmt(totalProductAmt);
		String chkPointBuyAble = ossPointService.chkPointBuyAble(pointCorpVO);
		resultMap.put("chkPointBuyAble", chkPointBuyAble);

		request.getSession().setAttribute("instant", sessionCartList);

		/* 현대캐피탈 one-card */
		request.getSession().setAttribute("hcOneCardYnList", cartList);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	@RequestMapping("/web/changeDlvArea.ajax")
	public ModelAndView changeDlvArea(@ModelAttribute CARTLISTVO cartListVO,
									  HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<CARTVO> sessionList = new ArrayList<CARTVO>() ;
		List<CARTVO> cartList = new ArrayList<CARTVO>() ;

		if(request.getSession().getAttribute("instant") != null){
			sessionList = (List<CARTVO>) request.getSession().getAttribute("instant");
			for( CARTVO sessionVo : sessionList ){
				if("Y".equals(cartListVO.getLocalAreaYn())){
					sessionVo.setDlvAmt(sessionVo.getInDlvAmt());
				}else{
					sessionVo.setDlvAmt(sessionVo.getOutDlvAmt());
				}
			}
		}
		if(request.getSession().getAttribute("cartList") != null){
			cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
			for( CARTVO sessionVo : cartList ){
				if("Y".equals(cartListVO.getLocalAreaYn())){
					sessionVo.setDlvAmt(sessionVo.getInDlvAmt());
				}else{
					sessionVo.setDlvAmt(sessionVo.getOutDlvAmt());
				}
			}
		}

		request.getSession().setAttribute("instant", sessionList);
		request.getSession().setAttribute("cartList", cartList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	/**
	 * 쿠폰 조회 레이어
	 * 파일명 : cpOptionLay
	 * 작성일 : 2015. 12. 4. 오후 12:08:56
	 * 작성자 : 최영철
	 * @param cartVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/cpOptionLayer.ajax")
	public String cpOptionLay(@ModelAttribute("CARTVO") CARTVO cartVO,
							  ModelMap model) {
		// 로그인 정보
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		// 쿠폰 목록
		List<USER_CPVO> cpList = webUserCpService.selectCouponList(userVO.getUserId());

		// 쿠폰 적용상품 목록
		String prdtNum = cartVO.getPrdtNum();
		String corpId = cartVO.getCorpId();
		String qty = cartVO.getQty();

		for (Iterator<USER_CPVO> it = cpList.iterator(); it.hasNext(); ) {
			boolean prdtCp = false;
			boolean corpCp = false;
			boolean isDelete = false;
			USER_CPVO userCpvo = it.next();
			/** 유형지정*/
			if(Constant.CP_APLPRDT_DIV_TYPE.equals(userCpvo.getAplprdtDiv())) {
				if(!userCpvo.getPrdtCtgrList().contains(cartVO.getCtgr())){
					isDelete = true;
				}
			}
			/** 상품지정*/
			if(Constant.CP_APLPRDT_DIV_PRDT.equals(userCpvo.getAplprdtDiv())) {
				CPVO cpvo = new CPVO();
				cpvo.setCpId(userCpvo.getCpId());

				List<CPPRDTVO> cpPrdtList = ossCouponService.selectCouponPrdtListWeb(cpvo);

				for(CPPRDTVO cpPrdt : cpPrdtList) {
					if(prdtNum.equals(cpPrdt.getPrdtNum())) {
						prdtCp = true;
						break;
					}
				}
				if(!prdtCp){
					isDelete = true;
				}
			}
			/** 업체지정 */
			if(Constant.CP_APLPRDT_DIV_CORP.equals(userCpvo.getAplprdtDiv())) {

				CPVO cpvo = new CPVO();
				cpvo.setCpId(userCpvo.getCpId());

				List<CPPRDTVO> cpCorpList = ossCouponService.selectCouponCorpListWeb(cpvo);

				for(CPPRDTVO cpPrdt : cpCorpList) {
					if(corpId.equals(cpPrdt.getCorpId())) {
						corpCp = true;
						break;
					}
				}
				if(!corpCp){
					isDelete = true;
				}
			}
			/** 승마전용 */
			if(userCpvo.getCpNm().contains("승마전용")){
				int tempLimitAmt = userCpvo.getLimitAmt();
				int tempQty = Integer.parseInt(qty);
				if(tempQty > 4){
					tempQty = 4;
				}
				userCpvo.setLimitAmt(tempLimitAmt * tempQty);
			}
			/** 소인,청소년 전용 */
			if(userCpvo.getCpNm().contains("청소년,소인")){
				if(cartVO.getOptNm() != null && !cartVO.getOptNm().equals("")){
					if(!cartVO.getOptNm().contains("소인") && !cartVO.getOptNm().contains("청소년") && !cartVO.getOptNm().contains("어린이") ){
						isDelete = true;
					}
				}
			}

			if(isDelete){
				it.remove();
			}
		}

		model.addAttribute("cpList", cpList);

		model.addAttribute("selectSn", cartVO.getCartSn());
		model.addAttribute("saleAmt", cartVO.getSaleAmt());

		return "/web/order/cpLayer";
	}

	/**
	 * 사용자 취소요청
	 * 파일명 : reqCancel
	 * 작성일 : 2015. 12. 9. 오후 6:41:27
	 * 작성자 : 최영철
	 * @param orderVO
	 * @return
	 * Note : 메일 발송 기능 추가 (2016. 08. 17 By JDongS)
	 */
	@RequestMapping("/web/reqCancel.ajax")
	public ModelAndView reqCancel(@ModelAttribute("ORDERVO") ORDERVO orderVO,
								  HttpServletRequest request) throws IOException {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		//상품구분
		String prdtDiv = StringUtils.left(orderVO.getPrdtRsvNum(),2);
		/** 숙소를 취소 상태로 변경 시 TLL 취소전송 보냄 */
		if ("AD".equals(prdtDiv)) {
			apitlBookingService.bookingCancel(orderVO.getPrdtRsvNum());
		}

		/** 렌트카 API취소 */
		if ("RC".equals(prdtDiv)) {
			/** 상품정보 get */
			RC_RSVVO rcRsvVO = new RC_RSVVO();
			rcRsvVO.setRcRsvNum(orderVO.getPrdtRsvNum());
    		RC_RSVVO rsvDtlVO = masRsvService.selectRcDetailRsv(rcRsvVO);
    		/** 그림API취소*/
			if(Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && Constant.RC_RENTCAR_COMPANY_GRI.equals(rsvDtlVO.getApiRentDiv())) {
				apiService.cancelGrimRcRsv(rsvDtlVO.getRcRsvNum());
			}
			/** 인스API취소*/
			if(Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && Constant.RC_RENTCAR_COMPANY_INS.equals(rsvDtlVO.getApiRentDiv())) {
				apiInsService.revcancel(rsvDtlVO);
			}
			/** 리본API취소*/
			if(Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && Constant.RC_RENTCAR_COMPANY_RIB.equals(rsvDtlVO.getApiRentDiv())) {
				apiRibbonService.carCancel(rsvDtlVO);
			}
			/** 오르카API취소*/
			if(Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && Constant.RC_RENTCAR_COMPANY_ORC.equals(rsvDtlVO.getApiRentDiv())) {
				apiOrcService.vehicleCancel(rsvDtlVO);
			}
		}

		/** 회원은 환불계좌등록 및 업데이트*/
		if (!"GUEST".equals(orderVO.getUserId()) && "I".equals(orderVO.getLGD_CASFLAGY())) {
			REFUNDACCINFVO refundAccInfVO = new REFUNDACCINFVO();
			refundAccInfVO.setUserId(orderVO.getUserId());
			refundAccInfVO.setBankCode(orderVO.getRefundBankCode());
			refundAccInfVO.setAccNum(orderVO.getRefundAccNum());
			refundAccInfVO.setDepositorNm(orderVO.getRefundDepositor());
			ossRsvService.mergeAccNum(refundAccInfVO);
		}

		if ("I".equals(orderVO.getLGD_CASFLAGY()) || Constant.PAY_DIV_TC_WI.equals(orderVO.getPayDiv()) || Constant.PAY_DIV_TC_MI.equals(orderVO.getPayDiv())) {
			webOrderService.updateRefundAcc(orderVO);
		}
		/** 취소요청상태로 변경 */
		orderVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CREQ);
		webOrderService.updateDtlRsvStatus(orderVO);

		//단건 취소 요청
		//문자
		webOrderService.reqCancelSnedSMS(orderVO.getPrdtRsvNum());
		// Email 발송
		ossMailService.sendCancelRequestPrdt(orderVO.getPrdtRsvNum(), request);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	@RequestMapping("/web/reqCancelAll.ajax")
	public ModelAndView reqCancelAll(@ModelAttribute("ORDERVO") ORDERVO orderVO,
									 HttpServletRequest request){

		/** 회원은 환불계좌등록 및 업데이트*/
		if(!"GUEST".equals(orderVO.getUserId()) && "I".equals(orderVO.getLGD_CASFLAGY())){
			REFUNDACCINFVO refundAccInfVO =  new REFUNDACCINFVO();
			refundAccInfVO.setUserId(orderVO.getUserId());
			refundAccInfVO.setBankCode(orderVO.getRefundBankCode());
			refundAccInfVO.setAccNum(orderVO.getRefundAccNum());
			refundAccInfVO.setDepositorNm(orderVO.getRefundDepositor());
			ossRsvService.mergeAccNum(refundAccInfVO);
		}
		if("I".equals(orderVO.getLGD_CASFLAGY())){
			webOrderService.updateRefundAcc(orderVO);
		}
		/** 취소요청상태로 변경 */
		orderVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CREQ);
		webOrderService.updateDtlRsvStatus(orderVO);
		/** 전체 취소 */
		/** 문자 */
		webOrderService.reqCancelSnedSMSAll(orderVO.getRsvNum());
		/** Email 발송 */
		ossMailService.sendCancelRequestAll(orderVO.getRsvNum(), request);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	@RequestMapping("/web/orderFail2.do")
	public String orderFail2(){
		return "/web/order/orderFail2";
	}

	/**
	 * 설명 : TL 링칸 API 연동 실패 시 실패 페이지 호출
	 * 파일명 : orderFail3
	 * 작성일 : 2021-06-30 오후 1:43
	 * 작성자 : chaewan.jung
	 * @param : [faultReason, model]
	 * @return : java.lang.String
	 * @throws Exception
	 */
	@RequestMapping("/web/orderFail3.do")
	public String orderFail3(@RequestParam("faultReason") String faultReason, ModelMap model){
		//TODO falutReason(실패코드)별 실패사유 값 설정
		String faultText = "";
		faultText ="재고가 없습니다.";
		model.addAttribute("faultReason", faultReason);
		model.addAttribute("faultText", faultText);
		return "/web/order/orderFail3";
	}

	@RequestMapping("/web/orderFail4.do")
	public String orderFail4(){
		return "/web/order/orderFail4";
	}

	@RequestMapping("/web/orderChk.ajax")
	public ModelAndView orderChk(@ModelAttribute("RSVVO") RSVVO rsvVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 예약기본정보
		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

		// Constant.RSV_STATUS_CD_READY(예약대기 : RS00)인 경우
		if(Constant.RSV_STATUS_CD_READY.equals(rsvInfo.getRsvStatusCd())){
			resultMap.put("success", "Y");
		}else{
			resultMap.put("success", "N");
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	public String SHA256Salt(String strData, String salt) {
		String SHA = "";

		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.reset();
			sh.update(salt.getBytes());
			byte byteData[] = sh.digest(strData.getBytes());

			//Hardening against the attacker's attack
			sh.reset();
			byteData = sh.digest(byteData);

			StringBuffer sb = new StringBuffer();
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));

			}

			SHA = sb.toString();
			byte[] raw = SHA.getBytes();
			byte[] encodedBytes = Base64.encodeBase64(raw);
			SHA = new String(encodedBytes);
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = null;
		}

		return SHA;
	}

	/**
	 * 예약 단품 상품 정보 조회
	 * 파일명 : selectByOrder
	 * 작성일 : 2016. 5. 31. 오후 5:49:52
	 * 작성자 : 최영철
	 * @param orderVO
	 * @return
	 */
	@RequestMapping("/web/selectByOrder.ajax")
	public ModelAndView selectByOrder(@ModelAttribute("ORDERVO") ORDERVO orderVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		orderVO = webOrderService.selectUserRsvFromPrdtRsvNum(orderVO);
//		orderVO.setCancelGuide(EgovStringUtil.checkHtmlView(orderVO.getCancelGuide()));
		resultMap.put("orderVO", orderVO);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	@RequestMapping("/web/changeDlv.ajax")
	public ModelAndView changeDlv(@ModelAttribute("RSVVO") RSVVO rsvVO) {

		webOrderService.changeDlv(rsvVO);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	/**
	 * 최근 주문 배송지 조회
	 * @param rsvVO
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/web/orderRecentDlv.ajax")
	public ModelAndView orderRecentDlv(@ModelAttribute("RSVVO") RSVVO rsvVO,
									   HttpServletRequest request,
									   HttpServletResponse response ) {
		log.info("/web/orderRecentDlv.ajax call");
		Map<String, Object> resultMap = new HashMap<String, Object>();

		RSVVO resultVO = webOrderService.orderRecentDlv(rsvVO);

		resultMap.put("dlv", resultVO);

		resultMap.put("resultCode", Constant.JSON_SUCCESS);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	/**
	 * 구매확정
	 * @param svRsvNum
	 * @return
	 */
	@RequestMapping("/web/confirmOrder.ajax")
	public ModelAndView confirmOrder(@RequestParam(value="svRsvNum") String svRsvNum) {

		webOrderService.confirmOrder(svRsvNum);

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("result", Constant.JSON_SUCCESS);
		resultMap.put("mid", EgovProperties.getProperty("Globals.LgdMertKey.PRE"));

		ModelAndView mav = new ModelAndView("jsonView", resultMap);


		return mav;
	}

	@RequestMapping("/web/evntCdConfirm.ajax")
	public ModelAndView evntCdConfirm(@ModelAttribute("EVNTINFVO") EVNTINFVO evntInfVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String result = webOrderService.evntCdConfirm(evntInfVO);

		resultMap.put("result", result);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/**
	 * L.Point 로직 처리
	 * Function : WebOrderController.java
	 * 작성일 : 2017. 8. 25. 오후 5:50:35
	 * 작성자 : 정동수
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 * @throws InvalidKeyException
	 * @throws NoSuchAlgorithmException
	 */
	@RequestMapping("/web/actionLPoint.ajax")
	public ModelAndView actionLPoint(@ModelAttribute("LPOINTREQDATAVO") LPOINTREQDATAVO reqVO) throws JsonParseException, JsonMappingException, IOException, InvalidKeyException, NoSuchAlgorithmException{
		log.info("/web/actionLPoint.ajax call");
		Map<String, Object> resultMap = new HashMap<String, Object>();

		/*
		 * JSON 데이터 변환 객체
		 */
		ObjectMapper mapper = new ObjectMapper();

		/*
		 * 요청 데이터 생성
		 *  - 요청VO 생성 및 데이터 설정
		 */
		//	String pswd = "lotte123";		// 비밀번호
		//	reqVO.cdno = "8710407700010031";	// 카드 번호 저장

		Date today = new Date();
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdfTime = new SimpleDateFormat("HHmmss");

		if (Constant.LPOINT_SERVICE_720.equals(reqVO.serviceID)) {	// 비밀번호 인증
			reqVO.pswd = EgovWebUtil.generateMD5encryption(reqVO.pswd);	// 비밀번호
		} else if (Constant.LPOINT_SERVICE_730.equals(reqVO.serviceID)) {	// 포인트 사용 승인
			reqVO.mbPtUPswd = EgovWebUtil.generateMD5encryption(reqVO.pswd);	// 멤버스 포인트 사용 비밀번호
			//	reqVO.ccoAprno = "RC160125000002";	// 제휴사 승인번호
			reqVO.deDt = sdfDate.format(today);	// 거래일자
			reqVO.deHr = sdfTime.format(today);	// 거래시간
			reqVO.deDc = "20";	// 거래구분코드
			//		if ("20".equals(reqVO.deDc)) {
			reqVO.deRsc = "200";// 거래사유 코드
			//		}
			reqVO.uDc = "1"; 	// 사용 구분 코드
			reqVO.ptUDc = "1";	// 포인트 사용 구분 코드
			//		if ("1".equals(reqVO.ptUDc) || "2".equals(reqVO.ptUDc)) {
			//			reqVO.ttnUPt = "100";	// 금회 사용 포인트
			//		} else {
			//			reqVO.ttnUPt = "0";
			//		}
			//	reqVO.slAm = "14000";	// 매출금액
		} else if (Constant.LPOINT_SERVICE_740.equals(reqVO.serviceID)) { // 포인트 사용 취소
			//	reqVO.ccoAprno = "RC160125000002";	// 제휴사 승인번호
			reqVO.deDt = sdfDate.format(today);	// 거래일자
			reqVO.deHr = sdfTime.format(today);	// 거래시간
			reqVO.deDc = "20";	// 거래구분코드
			reqVO.deRsc = "200";// 거래사유 코드
			reqVO.uDc = "2"; 	// 사용 구분 코드
			reqVO.ptUDc = "1";	// 포인트 사용 구분 코드
			//	reqVO.ttnUPt = "100";	// 금회 사용 포인트
			reqVO.otInfYnDc = "1"; 	// 원거래 정보 유무 구분 코드
			reqVO.otInfDc = "1"; 	// 원거래 정보 구분 코드
			//	reqVO.otAprno = "030837808";// 원거래 승인번호
			//	reqVO.otDt = "20170830";	// 원거래 일자

		}

		/*
		 * 요청 데이터 JSON 생성
		 *  - 요청VO를 JSON 데이터 변환
		 */
		String sReqData = "";
		sReqData =  mapper.writeValueAsString(reqVO);
		log.info("req data(JSON) : " + sReqData);

		/*
		 * 서비스 호출 설정
		 *  - timeout 설정 : 5초
		 *  - 서비스 URL 설정
		 *  - 서비스 요청 데이터 적재
		 */
		int timeout = 10;
		RequestConfig config = RequestConfig.custom().setConnectTimeout(timeout * 1000)
				.setConnectionRequestTimeout(timeout * 1000)
				.setSocketTimeout(timeout * 1000).build();
		CloseableHttpClient httpClient = HttpClientBuilder.create().setDefaultRequestConfig(config).build();

		HttpPost httpPost = new HttpPost("https://" + EgovProperties.getProperty("L.POINT.httpPost"));

		/* 암호화 처리 적용시 주석 제거 */
		httpPost.addHeader("X-Openpoint" , "burC=" + EgovProperties.getProperty("L.POINT.corpCode") + "|encYn=Y");	//암호화 전송 설정
		byte[] keys = ARIACipher.readKeyFile(EgovProperties.getProperty("L.POINT.Folder") + EgovProperties.getProperty("L.POINT.corpCode") + ".dat");	// 암호화 키 정보 추출
		ARIACipher cipher = new ARIACipher(keys);	//암호화 객체 생성
		sReqData = cipher.encryptString(sReqData, "UTF-8");    //암호화 처리
		log.info("req data(encryption) : " + sReqData);

		StringEntity reqEntity = new StringEntity(sReqData, ContentType.create("application/json", "UTF-8"));
		httpPost.setEntity(reqEntity);

		/*
		 * 서비스 호출
		 */
		String sRespData ="";
		HttpResponse response = httpClient.execute(httpPost);
		HttpEntity respEntity = response.getEntity();

		if (respEntity != null) {
			// 응답 데이터
			sRespData =  EntityUtils.toString(respEntity);
			log.info("resp data 1(JSON) : " + sRespData);
		}

		/* 복호화 처리 적용시 주석 제거*/
		sRespData = cipher.decryptString(sRespData, "UTF-8");	//복호화 처리
		log.info("resp data 2(JSON) : " + sRespData);

		/*
		 * 서비스 응답 데이터 파싱
		 */
		LPOINTRESPDATAVO respPhoneVO = mapper.readValue(sRespData, LPOINTRESPDATAVO.class);
		log.info("resp data (VO) ### aprno ==> " + respPhoneVO.aprno);
		log.info("resp data (VO) ### ctfCno ==> " + respPhoneVO.ctfCno);
		log.info("resp data (VO) ### avlPt ==> " + respPhoneVO.avlPt);
		log.info("resp data (VO) ### resPt ==> " + respPhoneVO.resPt);
		log.info("resp data (VO) ### Time ==> " + respPhoneVO.aprDt + " " + respPhoneVO.aprHr);

		log.info("service end :::::");

		resultMap.put("lpoint", respPhoneVO);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	@RequestMapping("/web/lpointBatch.ajax")
	public void lpointBatch(String service) throws IOException {
		log.info("/web/lpointBatch.ajax call");

		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.setTime(new Date());
		cal.add(Calendar.DAY_OF_YEAR, -1); // 전일 산출
		String prevDate = sdfDate.format(cal.getTime());

		String serviceID = "O920";
		int batchCnt = 0;

		// 배치 파일 생성
		String batchStr = "";
		batchStr += "BH" + prevDate + serviceID + EgovProperties.getProperty("L.POINT.corpCode") + StringUtils.rightPad(" ", 1077) + "\n";		// 배치 파일 시작

		// 적립 자료
		List<LPOINTSAVEINFVO> lpointSaveList = webOrderService.selectLpointSaveList();

		// 적립 건수
		batchCnt += lpointSaveList.size();

		// 적립 시
		for (LPOINTSAVEINFVO saveVO : lpointSaveList) {
			batchStr += "BD" + "3" + "1" + StringUtils.rightPad(saveVO.getCardNum(), 37) + StringUtils.rightPad(" ", 20) + EgovProperties.getProperty("L.POINT.copMcno") + StringUtils.rightPad(saveVO.getPrdtRsvNum(), 19) + saveVO.getTradeDttm().substring(0, 10).replaceAll("-", "") + saveVO.getTradeDttm().substring(11, 19).replaceAll(":", "") + "10" + "100" + "1" + "0" + "1" + String.format("%012d", saveVO.getPayAmt()) + String.format("%012d", saveVO.getPayAmt()) + String.format("%048d", 0) + String.format("%012d", saveVO.getPayAmt()) + String.format("%054d", 0) + StringUtils.rightPad(" ", 845) + "\n";

			/*batchStr += "BD" + "3" + "1" + StringUtils.rightPad("8710407700010031", 37) + StringUtils.rightPad(" ", 20) + EgovProperties.getProperty("L.POINT.copMcno") + StringUtils.rightPad("RC17082500000" + i, 19) + "2017082" + i + "091524" + "10" + "100" + "1" + "0" + "1" + String.format("%012d", 18500) + String.format("%012d", 17500) + String.format("%048d", 0) + String.format("%012d", 18500) + String.format("%054d", 0) + StringUtils.rightPad(" ", 845) + "\n";*/
		}

		// 적립 취소 자료
		String line = null;

        /*BufferedReader fi = new BufferedReader(new FileReader(new File(EgovProperties.getProperty("L.POINT.Folder.batch") + "L-PointBatch_decryption_20170904.txt")));
        while ((line = fi.readLine()) != null) {
        	if (line.substring(929, 931).trim().equals("00")) {
	        	batchStr += "BD" + "3" + "1"
		        	+ StringUtils.rightPad(line.substring(4, 41).trim(), 37)
		        	+ StringUtils.rightPad(" ", 20) + EgovProperties.getProperty("L.POINT.copMcno")
		        	+ StringUtils.rightPad(line.substring(71, 90).trim(), 19)
		        	+ line.substring(90, 98).trim()
		        	+ line.substring(98, 104).trim()
		        	+ "10" + "100" + "2" + "0" + "1" + String.format("%012d", Integer.parseInt(line.substring(112, 124)))
		        	+ String.format("%012d", Integer.parseInt(line.substring(112, 124)))
		        	+ String.format("%048d", 0) + String.format("%012d", Integer.parseInt(line.substring(112, 124)))
		        	+ String.format("%054d", 0) + StringUtils.rightPad(" ", 4) + "0" + "1" + "1" + StringUtils.rightPad(line.substring(888, 897).trim(), 19)
		        	+ line.substring(897, 905).trim() + StringUtils.rightPad(" ", 811) + "\n";

	        	batchCnt += 1;
        	}
        }
        fi.close();*/

		// 취소 시
		/*for (LPOINTUSEINFVO cancelVO : lpointCancelList) {
			batchStr += "BD" + "3" + "1" + StringUtils.rightPad(cancelVO.getCardNum(), 37) + StringUtils.rightPad(" ", 20) + EgovProperties.getProperty("L.POINT.copMcno") + StringUtils.rightPad(cancelVO.getRsvNum(), 19) + cancelVO.getTradeDttm().substring(0, 10).replaceAll("-", "") + cancelVO.getTradeDttm().substring(11, 19).replaceAll(":", "") + "10" + "100" + "2" + "0" + "1" + String.format("%012d", cancelVO.getPayAmt()) + String.format("%012d", cancelVO.getPayAmt()) + String.format("%048d", 0) + String.format("%012d", cancelVO.getPayAmt()) + String.format("%054d", 0) + StringUtils.rightPad(" ", 4) + "0" + "1" + "1" + StringUtils.rightPad(cancelVO.getTradeConfnum(), 19) + cancelVO.getTradeDttm().substring(0, 10).replaceAll("-", "") + StringUtils.rightPad(" ", 811) + "\n";
		}	*/

		/*batchStr += "BD" + "3" + "1" + StringUtils.rightPad("8710407700010031", 37) + StringUtils.rightPad(" ", 20) + EgovProperties.getProperty("L.POINT.copMcno") + StringUtils.rightPad("RV170908000006", 19) + "20170908" + "115925" + "10" + "100" + "2" + "0" + "1" + String.format("%012d", 40000) + String.format("%012d", 30000) + String.format("%048d", 0) + String.format("%012d", 40000) + String.format("%054d", 0) + StringUtils.rightPad(" ", 4) + "0" + "1" + "1" + StringUtils.rightPad("030841247", 19) + "20170908" + StringUtils.rightPad(" ", 811) + "\n"; */

		batchStr += "BT" + String.format("%09d", batchCnt) + StringUtils.rightPad(" ", 1084);				// 배치 파일 종료

		String batchFile = "L-PointBatch_" + prevDate + ".txt";
		BufferedWriter fw = new BufferedWriter(new FileWriter(EgovProperties.getProperty("L.POINT.Folder.batch") + batchFile, true));

		fw.write(batchStr);
		fw.flush();
		fw.close();
		log.info(batchFile + " file created!");

		// 배치 암호화 파일 생성
		String[] batch = new String[] {"java", "-jar", EgovProperties.getProperty("L.POINT.Folder") + "AFE.jar", EgovProperties.getProperty("L.POINT.Folder") + EgovProperties.getProperty("L.POINT.Key.batch"), EgovProperties.getProperty("L.POINT.Folder.batch") + batchFile, EgovProperties.getProperty("L.POINT.Folder.batch") + EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01"};
		Process process = new ProcessBuilder(batch).start();
		SequenceInputStream seqIn = new SequenceInputStream(process.getInputStream(), process.getErrorStream());
		Scanner s = new Scanner(seqIn);
		while (s.hasNextLine() == true) {
			log.info("batch file encryption => " + s.nextLine());
		}
		// FIN 파일 생성 (배치 파일 종료를 위해 빈 파일(.FIN) 생성)
		fw = new BufferedWriter(new FileWriter(EgovProperties.getProperty("L.POINT.Folder.batch") + EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01.FIN", true));
		fw.flush();
		fw.close();
		log.info("batch encryption file created!");

		// SFTP 전송
		JSch jsch = new JSch();
		ChannelSftp channelSftp = null;
		Session session = null;
		Channel channel = null;
		try {
			session = jsch.getSession(EgovProperties.getProperty("L.POINT.Batch.user"), EgovProperties.getProperty("L.POINT.Batch.ip"), Integer.parseInt(EgovProperties.getProperty("L.POINT.Batch.port")));
			session.setPassword(EgovProperties.getProperty("L.POINT.Batch.pass"));

			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			session.connect();

			channel = session.openChannel("sftp");
			channel.connect();
			log.info("SFTP connect success!");
		} catch (JSchException e) {
			e.printStackTrace();
			log.info("SFTP connect fail!!");
		}
		channelSftp = (ChannelSftp) channel;

		FileInputStream in = null;
		File file = new File(EgovProperties.getProperty("L.POINT.Folder.batch") + EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01");
		try { //파일을 가져와서 inputStream에 넣고 저장경로를 찾아 put
			in = new FileInputStream(file);
//		    channelSftp.cd(dir);
			channelSftp.put(in,file.getName());
			log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01 => upload success!");
		}catch(SftpException se){
			se.printStackTrace();
			log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01 => upload fail!!");
		}catch(FileNotFoundException fe){
			fe.printStackTrace();
			log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01 => file not found!!");
		}finally{
			try{
				in.close();
			} catch(IOException ioe){
				ioe.printStackTrace();
			}
		}

		file = new File(EgovProperties.getProperty("L.POINT.Folder.batch") + EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01.FIN");
		try { //파일을 가져와서 inputStream에 넣고 저장경로를 찾아 put
			in = new FileInputStream(file);
//	        channelSftp.cd(dir);
			channelSftp.put(in,file.getName());
			log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01.FIN => upload success!");
		}catch(SftpException se){
			se.printStackTrace();
			log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01.FIN => upload fail!!");
		}catch(FileNotFoundException fe){
			fe.printStackTrace();
			log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01.FIN => file not found!!");
		}finally{
			try{
				in.close();
			} catch(IOException ioe){
				ioe.printStackTrace();
			}
		}

		channelSftp.quit();
		channel.disconnect();
		session.disconnect();

		log.info(EgovProperties.getProperty("L.POINT.Batch.upload") + prevDate + ".01" + " file upload end!");
	}

	@RequestMapping("/web/lpointBatchDownload.ajax")
	public void lpointBatchDownload() throws IOException {
		log.info("/web/lpointBatchDownload.ajax call");

		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.setTime(new Date());
		cal.add(Calendar.DAY_OF_YEAR, -1); // 전일 산출
		String prevDate = sdfDate.format(cal.getTime());

		// SFTP file download
		JSch jsch = new JSch();
		ChannelSftp channelSftp = null;
		Session session = null;
		Channel channel = null;
		String batchFile = EgovProperties.getProperty("L.POINT.Batch.download") + prevDate + ".01";
		String batchDecryptionFile = "L-PointBatch_decryption_" + prevDate + ".txt";
		try {
			session = jsch.getSession(EgovProperties.getProperty("L.POINT.Batch.user"), EgovProperties.getProperty("L.POINT.Batch.ip"), Integer.parseInt(EgovProperties.getProperty("L.POINT.Batch.port")));
			session.setPassword(EgovProperties.getProperty("L.POINT.Batch.pass"));

			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			session.connect();

			channel = session.openChannel("sftp");
			channel.connect();
			log.info("SFTP connect success!");
		} catch (JSchException e) {
			e.printStackTrace();
			log.info("SFTP connect fail!!");
		}
		channelSftp = (ChannelSftp) channel;

		InputStream in = null;
		FileOutputStream out = null;
		try { //파일을 inputStream에 get
			channelSftp.cd("send");
			in = channelSftp.get(batchFile);
			log.info(batchFile + " => download success!");
		}catch(SftpException se){
			se.printStackTrace();
			log.info(batchFile + " => download fail!!");
		}

		try {
			int i;
			out = new FileOutputStream(new File(EgovProperties.getProperty("L.POINT.Folder.batch") + batchFile));
			while ((i = in.read()) != -1) {
				out.write(i);
			}
		} catch (IOException  e) {
			e.printStackTrace();
			log.info(batchFile + " => create fail!!");
		} finally{
			out.close();
			in.close();

			// 배치 복호화 파일 생성
			String[] batch = new String[] {"java", "-jar", EgovProperties.getProperty("L.POINT.Folder") + "AFD.jar", EgovProperties.getProperty("L.POINT.Folder") + EgovProperties.getProperty("L.POINT.Key.batch"), EgovProperties.getProperty("L.POINT.Folder.batch") + batchFile, EgovProperties.getProperty("L.POINT.Folder.batch") + batchDecryptionFile };
			Process process = new ProcessBuilder(batch).start();
			SequenceInputStream seqIn = new SequenceInputStream(process.getInputStream(), process.getErrorStream());
			Scanner s = new Scanner(seqIn);
			while (s.hasNextLine() == true) {
				log.info("batch file decryption => " + s.nextLine());
			}
			log.info("batch decryption file created!");
		}

		channelSftp.quit();
		channel.disconnect();
		session.disconnect();

		log.info(batchFile + " file download end!");

		log.info(batchFile + " file parse Start !!");
		String line = null;
		LPOINTSAVEINFVO lpointSaveInfVO = new LPOINTSAVEINFVO();
		BufferedReader fi = new BufferedReader(new FileReader(new File(EgovProperties.getProperty("L.POINT.Folder.batch") + batchDecryptionFile)));
		while ((line = fi.readLine()) != null) {
			if ("BD".equals(line.substring(0, 2))) {
				int savePoint = "00".equals(line.substring(929, 931)) ? Integer.parseInt(line.substring(911, 920)) : 0;
				int evntPoint = "00".equals(line.substring(929, 931)) ? Integer.parseInt(line.substring(920, 929)) : 0;
				lpointSaveInfVO.setSaveYn(Constant.FLAG_Y);
				lpointSaveInfVO.setPrdtRsvNum(line.substring(71, 90).trim());
				lpointSaveInfVO.setCardNum(line.substring(4, 41).trim());
				lpointSaveInfVO.setConfNum(line.substring(888, 897).trim());
				if (line.substring(897, 905).trim() != "")
					lpointSaveInfVO.setConfDttm(line.substring(897, 905).trim() + line.substring(905, 911).trim());
				lpointSaveInfVO.setRespCd(line.substring(929, 931));
				lpointSaveInfVO.setSavePoint("" + savePoint);
				lpointSaveInfVO.setEvntPoint("" + evntPoint);
				lpointSaveInfVO.setSaveRst(new String(line.substring(931, 995).trim()));

				webOrderService.updateLpointSave(lpointSaveInfVO);
			}
		}
		fi.close();
		log.info(batchFile + " file parse End !");
	}

	/**************************************************************
	 * L.Point 테스트를 위한 임시 진행
	 **************************************************************
	 */

	/** 예약문자전송 ajax*/
	@RequestMapping("/web/sendMMSmsg.ajax")
	public ModelAndView sendMMSmsg(	@ModelAttribute("searchVO") ORDERVO orderVO) {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		MMSVO mmsVO = new MMSVO();
		mmsVO.setRsvNum(orderVO.getRsvNum());

		List<MMSVO> resultList = webOrderService.selectListMMSmsg(mmsVO);

		for(MMSVO resultVO: resultList){
			mmsVO.setSubject(resultVO.getSubject());
			mmsVO.setMsg(resultVO.getMsg());
			mmsVO.setStatus("0");
			mmsVO.setFileCnt("0");
			mmsVO.setType("0");

			/** 예약자 연락처 */
			if("0".equals(orderVO.getTelnumType())){
				mmsVO.setPhone(orderVO.getRsvTelnum());
				/** 사용자 연락처 */
			}else if("1".equals(orderVO.getTelnumType())){
				mmsVO.setPhone(orderVO.getUseTelnum());
				/** 직접입력 연락처 */
			}else{
				mmsVO.setPhone(orderVO.getDirectInput());
			}
			mmsVO.setCallback(EgovProperties.getProperty("CS.PHONE"));
			smsService.sendMMS(mmsVO);
		}
		resultMap.put("success","전송이 완료 되었습니다.");

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	/** 무통장입금(가상계좌) 결과처리 페이지 ajax*/
	@RequestMapping("/web/casNoteUrl.do")
	public void casNoteUrl(	@ModelAttribute("searchVO") ORDERVO orderVO, HttpServletRequest request, HttpServletResponse response) throws NoSuchAlgorithmException, org.json.simple.parser.ParseException, IOException {
		/*
		 * [상점 결제결과처리(DB) 페이지]
		 *
		 * 1) 위변조 방지를 위한 hashdata값 검증은 반드시 적용하셔야 합니다.
		 *
		 */

		String LGD_RESPCODE = "";           // 응답코드: 0000(성공) 그외 실패
		String LGD_RESPMSG = "";            // 응답메세지
		String LGD_MID = "";                // 상점아이디
		String LGD_OID = "";                // 주문번호
		String LGD_AMOUNT = "";             // 거래금액
		String LGD_TID = "";                // LG유플러스에서 부여한 거래번호
		String LGD_PAYTYPE = "";            // 결제수단코드
		String LGD_PAYDATE = "";            // 거래일시(승인일시/이체일시)
		String LGD_HASHDATA = "";           // 해쉬값
		String LGD_FINANCECODE = "";        // 결제기관코드(은행코드)
		String LGD_FINANCENAME = "";        // 결제기관이름(은행이름)
		String LGD_ESCROWYN = "";           // 에스크로 적용여부
		String LGD_TIMESTAMP = "";          // 타임스탬프
		String LGD_ACCOUNTNUM = "";         // 계좌번호(무통장입금)
		String LGD_CASTAMOUNT = "";         // 입금총액(무통장입금)
		String LGD_CASCAMOUNT = "";         // 현입금액(무통장입금)
		String LGD_CASFLAG = "";            // 무통장입금 플래그(무통장입금) - 'R':계좌할당, 'I':입금, 'C':입금취소
		String LGD_CASSEQNO = "";           // 입금순서(무통장입금)
		String LGD_CASHRECEIPTNUM = "";     // 현금영수증 승인번호
		String LGD_CASHRECEIPTSELFYN = "";  // 현금영수증자진발급제유무 Y: 자진발급제 적용, 그외 : 미적용
		String LGD_CASHRECEIPTKIND = "";    // 현금영수증 종류 0: 소득공제용 , 1: 지출증빙용
		String LGD_PAYER = "";    			// 임금자명

		/*
		 * 구매정보
		 */
		String LGD_BUYER = "";              // 구매자
		String LGD_PRODUCTINFO = "";        // 상품명
		String LGD_BUYERID = "";            // 구매자 ID
		String LGD_BUYERADDRESS = "";       // 구매자 주소
		String LGD_BUYERPHONE = "";         // 구매자 전화번호
		String LGD_BUYEREMAIL = "";         // 구매자 이메일
		String LGD_BUYERSSN = "";           // 구매자 주민번호
		String LGD_PRODUCTCODE = "";        // 상품코드
		String LGD_RECEIVER = "";           // 수취인
		String LGD_RECEIVERPHONE = "";      // 수취인 전화번호
		String LGD_DELIVERYINFO = "";       // 배송지

		LGD_RESPCODE            = request.getParameter("LGD_RESPCODE");
		LGD_RESPMSG             = request.getParameter("LGD_RESPMSG");
		LGD_MID                 = request.getParameter("LGD_MID");
		LGD_OID                 = request.getParameter("LGD_OID");
		LGD_AMOUNT              = request.getParameter("LGD_AMOUNT");
		LGD_TID                 = request.getParameter("LGD_TID");
		LGD_PAYTYPE             = request.getParameter("LGD_PAYTYPE");
		LGD_PAYDATE             = request.getParameter("LGD_PAYDATE");
		LGD_HASHDATA            = request.getParameter("LGD_HASHDATA");
		LGD_FINANCECODE         = request.getParameter("LGD_FINANCECODE");
		LGD_FINANCENAME         = request.getParameter("LGD_FINANCENAME");
		LGD_ESCROWYN            = request.getParameter("LGD_ESCROWYN");
		LGD_TIMESTAMP           = request.getParameter("LGD_TIMESTAMP");
		LGD_ACCOUNTNUM          = request.getParameter("LGD_ACCOUNTNUM");
		LGD_CASTAMOUNT          = request.getParameter("LGD_CASTAMOUNT");
		LGD_CASCAMOUNT          = request.getParameter("LGD_CASCAMOUNT");
		LGD_CASFLAG             = request.getParameter("LGD_CASFLAG");
		LGD_CASSEQNO            = request.getParameter("LGD_CASSEQNO");
		LGD_CASHRECEIPTNUM      = request.getParameter("LGD_CASHRECEIPTNUM");
		LGD_CASHRECEIPTSELFYN   = request.getParameter("LGD_CASHRECEIPTSELFYN");
		LGD_CASHRECEIPTKIND     = request.getParameter("LGD_CASHRECEIPTKIND");
		LGD_PAYER     			= request.getParameter("LGD_PAYER");

		LGD_BUYER               = request.getParameter("LGD_BUYER");
		LGD_PRODUCTINFO         = request.getParameter("LGD_PRODUCTINFO");
		LGD_BUYERID             = request.getParameter("LGD_BUYERID");
		LGD_BUYERADDRESS        = request.getParameter("LGD_BUYERADDRESS");
		LGD_BUYERPHONE          = request.getParameter("LGD_BUYERPHONE");
		LGD_BUYEREMAIL          = request.getParameter("LGD_BUYEREMAIL");
		LGD_BUYERSSN            = request.getParameter("LGD_BUYERSSN");
		LGD_PRODUCTCODE         = request.getParameter("LGD_PRODUCTCODE");
		LGD_RECEIVER            = request.getParameter("LGD_RECEIVER");
		LGD_RECEIVERPHONE       = request.getParameter("LGD_RECEIVERPHONE");
		LGD_DELIVERYINFO        = request.getParameter("LGD_DELIVERYINFO");

		LGPAYINFVO lGPAYINFO = new LGPAYINFVO();
		lGPAYINFO.setLGD_OID				(LGD_OID);
		lGPAYINFO.setLGD_RESPCODE			(LGD_RESPCODE);
		lGPAYINFO.setLGD_RESPMSG			(LGD_RESPMSG);
		lGPAYINFO.setLGD_AMOUNT				(LGD_AMOUNT);
		lGPAYINFO.setLGD_TID				(LGD_TID);
		lGPAYINFO.setLGD_PAYTYPE			(LGD_PAYTYPE);
		lGPAYINFO.setLGD_CASFLAGY			(LGD_CASFLAG);
		lGPAYINFO.setLGD_CASHRECEIPTNUM		(LGD_CASHRECEIPTNUM);
		lGPAYINFO.setLGD_CASHRECEIPTSELFYN	(LGD_CASHRECEIPTSELFYN);
		lGPAYINFO.setLGD_CASHRECEIPTKIND	(LGD_CASHRECEIPTKIND);

		/*
		 * hashdata 검증을 위한 mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다.
		 * LG유플러스에서 발급한 상점키로 반드시변경해 주시기 바랍니다.
		 */
		String LGD_MERTKEY = EgovProperties.getProperty("Globals.LgdMertKey.PRE");

		StringBuffer sb = new StringBuffer();
		sb.append(LGD_MID);
		sb.append(LGD_OID);
		sb.append(LGD_AMOUNT);
		sb.append(LGD_RESPCODE);
		sb.append(LGD_TIMESTAMP);
		sb.append(LGD_MERTKEY);

		byte[] bNoti = sb.toString().getBytes();
		MessageDigest md = MessageDigest.getInstance("MD5");
		byte[] digest = md.digest(bNoti);

		StringBuffer strBuf = new StringBuffer();
		for (int i=0 ; i < digest.length ; i++) {
			int c = digest[i] & 0xff;
			if (c <= 15){
				strBuf.append("0");
			}
			strBuf.append(Integer.toHexString(c));
		}

		String LGD_HASHDATA2 = strBuf.toString();  //상점검증 해쉬값

		/*
		 * 상점 처리결과 리턴메세지
		 *
		 * OK  : 상점 처리결과 성공
		 * 그외 : 상점 처리결과 실패
		 *
		 * ※ 주의사항 : 성공시 'OK' 문자이외의 다른문자열이 포함되면 실패처리 되오니 주의하시기 바랍니다.
		 */
		String resultMSG = "결제결과 상점 DB처리(LGD_CASNOTEURL) 결과값을 입력해 주시기 바랍니다.";

		if (LGD_HASHDATA2.trim().equals(LGD_HASHDATA)) { //해쉬값 검증이 성공이면
			if ( ("0000".equals(LGD_RESPCODE.trim())) ){ //결제가 성공이면
				if( "R".equals( LGD_CASFLAG.trim() ) ) {
					/*
					 * 무통장 할당 성공 결과 상점 처리(DB) 부분
					 * 상점 결과 처리가 정상이면 "OK"
					 */
					//if( 무통장 할당 성공 상점처리결과 성공 )
					resultMSG = "OK";

				}else if( "I".equals( LGD_CASFLAG.trim() ) ) {
					/*
					 * 무통장 입금 성공 결과 상점 처리(DB) 부분
					 * 상점 결과 처리가 정상이면 "OK"
					 */
					/** LS컴퍼니 연동 */
					APILSVO apilsVO = new APILSVO();
					apilsVO.setRsvNum(lGPAYINFO.getLGD_OID());
					if(!"Y".equals(apiLsService.requestOrderLsCompany(apilsVO))){
						log.info("fail : not available lsCompany order");
						out.println("NO");
					};
					/** 브이패스 연동 */
					if(!"Y".equals(apiVpService.requestOrderVpCompany(apilsVO))){
						log.info("fail : not available vpass order");
						out.println("NO");
					};

					webOrderService.updateRsvCompleteCyberAccount(lGPAYINFO);
					RSVVO rsvVO = new RSVVO();
					rsvVO.setRsvNum(lGPAYINFO.getLGD_OID());
					webOrderService.orderCompleteSnedSMSMail(rsvVO, request);
					resultMSG = "OK";
				}else if( "C".equals( LGD_CASFLAG.trim() ) ) {
					/*
					 * 무통장 입금취소 성공 결과 상점 처리(DB) 부분
					 * 상점 결과 처리가 정상이면 "OK"
					 */
					//if( 무통장 입금취소 성공 상점처리결과 성공 )
					resultMSG = "OK";
				}
			} else { //결제가 실패이면
				/*
				 * 거래실패 결과 상점 처리(DB) 부분
				 * 상점결과 처리가 정상이면 "OK"
				 */
				//if( 결제실패 상점처리결과 성공 )
				resultMSG = "OK";
			}
		} else { //해쉬값이 검증이 실패이면
			/*
			 * hashdata검증 실패 로그를 처리하시기 바랍니다.
			 */
			resultMSG = "결제결과 상점 DB처리(LGD_CASNOTEURL) 해쉬값 검증이 실패하였습니다.";
		}

		PrintWriter out = response.getWriter();
		out.println(resultMSG);

	}

	/**
	 * 설명 : 에스크로 처리결과 수신 페이지
	 * 작성일 : 2021-09-03 오전 9:41
	 * 작성자 : chaewan.jung
	 * @param :
	 * @return :
	 * @throws Exception
	 */
	@RequestMapping("/web/escrowReceive.do")
	public void escrowReceive(HttpServletRequest request) throws NoSuchAlgorithmException {
		// ## 수정하지 마십시요. ##

		// hash데이타값이 맞는 지 확인 하는 루틴은 LG유플러스에서 받은 데이타가 맞는지 확인하는 것이므로 꼭 사용하셔야 합니다
		// 정상적인 결제 건임에도 불구하고 노티 페이지의 오류나 네트웍 문제 등으로 인한 hash 값의 오류가 발생할 수도 있습니다.
		// 그러므로 hash 오류건에 대해서는 오류 발생시 원인을 파악하여 즉시 수정 및 대처해 주셔야 합니다.
		// 그리고 정상적으로 data를 처리한 경우에도 LG유플러스에서 응답을 받지 못한 경우는 결제결과가 중복해서 나갈 수 있으므로 관련한 처리도 고려되어야 합니다.

		/*************************    변수선언    ******************************/
		String txtype = "";                	// 결과구분(C=수령확인결과, R=구매취소요청, D=구매취소결과, N=NC처리결과 )
		String mid = "";                    // 상점아이디
		String tid = "";                    // LG유플러스에서 부여한 거래번호
		String oid = "";                    // 상품 거래 번호
		String ssn = "";                	// 구매자주민번호
		String ip = "";                    	// 구매자IP
		String mac = "";                	// 구매자 mac
		String hashdata = "";            	// LG유플러스 인증 암호키
		String productid = "";            	// 상품정보키
		String resdate = "";            	// 구매확인 일시

		txtype = request.getParameter("txtype");
		mid = request.getParameter("mid");
		tid = request.getParameter("tid");
		oid = request.getParameter("oid");
		ssn = request.getParameter("ssn");
		ip = request.getParameter("ip");
		mac = request.getParameter("mac");
		hashdata = request.getParameter("hashdata");
		productid = request.getParameter("productid");
		resdate = request.getParameter("resdate");

		String mertkey = EgovProperties.getProperty("Globals.LgdMertKey.PRE");    // LG유플러스에서 발급한 상점키로 변경해 주시기 바랍니다.

		String hashdata2 = null;
		/*************************************/
		StringBuffer sb = new StringBuffer();
		sb.append(mid);
		sb.append(oid);
		sb.append(tid);
		sb.append(txtype);
		sb.append(productid);
		sb.append(ssn);
		sb.append(ip);
		sb.append(mac);
		sb.append(resdate);
		sb.append(mertkey);

		byte[] bNoti = sb.toString().getBytes();

		MessageDigest md = MessageDigest.getInstance("MD5");
		byte[] digest = md.digest(bNoti);

		StringBuffer strBuf = new StringBuffer();

		for (int i = 0; i < digest.length; i++) {
			int c = digest[i] & 0xff;
			if (c <= 15) {
				strBuf.append("0");
			}
			strBuf.append(Integer.toHexString(c));
		}

		hashdata2 = strBuf.toString();

		String hashCheckYn = "N";
		// 2023. 07. 05 chaewan.jung 처리결과수신이 되는지 확인 후 처리 예정
//		if (hashdata2.trim().equals(hashdata)){	//해쉬값 검증이 성공이면
//			hashCheckYn = "Y";
//
//			//완료 처리
//			if("C".equals(txtype) || "N".equals(txtype)){
//				webOrderService.confirmOrder(productid);
//			}
//
//			if("R".equals(txtype)){
//				webOrderService.updateSvRsvCancelReq(productid);
//			}
//		}

		out.println("결과구분 : "			+ txtype +		"\r\n");
		out.println("상점ID : "				+ mid +			"\r\n");
		out.println("LG유플러스 거래번호 : "	+ tid +			"\r\n");
		out.println("상점주문번호 : "		+ oid +			"\r\n");
		out.println("처리일시 : "			+ resdate +		"\r\n");
		out.println("LG유플러스 인증키 : "	+ hashdata +	"\r\n");
		out.println("자체 인증키 : "			+ hashdata2 +	"\r\n");
		out.println("인증키 비교 : "			+ hashCheckYn +	"\r\n");
		out.println("상품ID : "				+ productid +	"\r\n");


		/************************ log Data insert ****************************/
		ESCROWVO escrowVO = new ESCROWVO();
		escrowVO.setTxtype(txtype);
		escrowVO.setMid(mid);
		escrowVO.setTid(tid);
		escrowVO.setOid(oid);
		escrowVO.setHashdata(hashdata);
		escrowVO.setHashdata2(hashdata2);
		escrowVO.setHashCheckYn(hashCheckYn);
		escrowVO.setProductid(productid);
		escrowVO.setResdate(resdate);

		webOrderService.insertEscrowReceive(escrowVO);
	}

	/*@RequestMapping(value= "/ext/tamnacardOrder/{referenceId}/{resultCode}")
	public String tamnaCardOrderComplete(ModelMap model, HttpServletRequest request, @PathVariable("referenceId") String referenceId, @PathVariable("resultCode") String resultCode) throws com.konasl.lib.remotepayment.json.simple.parser.ParseException, ExternalServiceException, IOException, org.json.simple.parser.ParseException {
		log.info("tamnacardOrderComplete : " + referenceId);

		String userAgent = request.getHeader("User-Agent").toUpperCase();

		RSVVO rsvVO = new RSVVO();
		rsvVO.setTamnacardRefId(referenceId);
		*//** 예약기본정보 *//*
		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);
		*//** 예약건이 존재하지 않거나 자동 취소된 경우 처리 *//*
		if(rsvInfo == null){
			if(Constant.FLAG_INIT == "local"){
				if(userAgent.indexOf("MOBI") > -1) {
					return "redirect:http://localhost:8080/mw/orderFail2.do";
				}else{
					return "redirect:http://localhost:8080/web/orderFail4.do?closeWin=Y";
				}
			}else{
				if(userAgent.indexOf("MOBI") > -1) {
					return "redirect:/mw/orderFail2.do";
				}else{
					return "redirect:/web/orderFail4.do?closeWin=Y";
				}
			}
		}else{
			if(Constant.RSV_STATUS_CD_ACC.equals(rsvInfo.getRsvStatusCd())){
				if(Constant.FLAG_INIT == "local"){
					if(userAgent.indexOf("MOBI") > -1) {
						return "redirect:http://localhost:8080/mw/orderFail2.do";
					}else{
						return "redirect:http://localhost:8080/web/orderFail4.do?closeWin=Y";
					}
				}else{
					if(userAgent.indexOf("MOBI") > -1) {
						return "redirect:/mw/orderFail2.do";
					}else{
						return "redirect:/web/orderFail4.do?closeWin=Y";
					}
				}
			}
		}

		*//** 최종승인 아님 pathParam을 success로 언제든지 변조가능*//*
		if("success".equals(resultCode)){
			final String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");

			String KCOmercahntid = "";
			String KCOlicencekey = "";

			KCOnlinePaymentLib kcOnlinePaymentLib = new KCOnlinePaymentLib();
			if("test".equals(CST_PLATFORM.trim())) {
				KCOmercahntid = EgovProperties.getProperty("DEV.TAMNACARD.MERCHANTID");
				KCOlicencekey = EgovProperties.getProperty("DEV.TAMNACARD.LICENCEKEY");
				kcOnlinePaymentLib.init(KCOmercahntid, rsvInfo.getRsvNum(), KCOlicencekey, EnvironmentType.DEV3);
			}else{
				KCOmercahntid = EgovProperties.getProperty("SERVICE.TAMNACARD.MERCHANTID");
				KCOlicencekey = EgovProperties.getProperty("SERVICE.TAMNACARD.LICENCEKEY");
				kcOnlinePaymentLib.init(KCOmercahntid, rsvInfo.getRsvNum(), KCOlicencekey, EnvironmentType.PROD);
			}
			kcOnlinePaymentLib.merchantId(KCOmercahntid);
			kcOnlinePaymentLib.orderId(rsvInfo.getRsvNum());

			try {
				*//**API 예약 *//*
				boolean result = apiService.apiReservation(rsvInfo.getRsvNum());
				if(!result){
					if(Constant.FLAG_INIT == "local"){
						if(userAgent.indexOf("MOBI") > -1) {
							return "redirect:http://localhost:8080/mw/orderFail2.do";
						}else{
							return "redirect:http://localhost:8080/web/orderFail4.do?closeWin=Y";
						}
					}else{
						if(userAgent.indexOf("MOBI") > -1) {
							return "redirect:/web/orderFail2.do";
						}else{
							return "redirect:/web/orderFail4.do?closeWin=Y";
						}
					}
				}

				ConfirmTransactionResponse responseVo = kcOnlinePaymentLib.sendConfirmTransactionRequest();
				ModelMapper modelMapper = new ModelMapper();
				TAMNACARD_VO tamnacardVo  = modelMapper.map(responseVo, TAMNACARD_VO.class);

				*//** 최종승인 확인 *//*
				if("SUCCESS".equals(responseVo.getStatus())){
					tamnacardVo.setRsvNum(rsvInfo.getRsvNum());
					tamnacardVo.setPaySn("0");
					webOrderService.insertTamnacardInfo(tamnacardVo);

					*//** 탐나는전 PC코드 *//*
					if(userAgent.indexOf("MOBI") > -1) {
						rsvInfo.setPayDiv(Constant.PAY_DIV_TC_MI);
					*//** 탐나는전 모바일코드 *//*
					}else{
						rsvInfo.setPayDiv(Constant.PAY_DIV_TC_WI);
					}

					*//** 전체예약 테이블 update *//*
					webOrderService.updateRsvComplete4(rsvInfo);
					*//** 이메일발송 *//*
					webOrderService.orderCompleteSnedSMSMail(rsvInfo,request);
					if(Constant.FLAG_INIT == "local"){
						if(userAgent.indexOf("MOBI") > -1) {
							return "redirect:"+ request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()
									+"/mw/orderComplete.do?rsvNum="+rsvInfo.getRsvNum();
						}else{
							return "redirect:"+ request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()
									+"/web/orderComplete.do?rsvNum="+rsvInfo.getRsvNum()+"&closeWin=Y";
						}
					}else{
						if(userAgent.indexOf("MOBI") > -1){
							return "redirect:/mw/orderComplete.do?rsvNum="+rsvInfo.getRsvNum();
						}else{
							return "redirect:/web/orderComplete.do?rsvNum="+rsvInfo.getRsvNum()+"&closeWin=Y";
						}
					}
				}else{
					apiService.apiCancellation(rsvInfo.getRsvNum());
				};
			} catch (ExternalServiceException e) {
				apiService.apiCancellation(rsvInfo.getRsvNum());
				e.printStackTrace();

				if(Constant.FLAG_INIT == "local"){
					if(userAgent.indexOf("MOBI") > -1) {
						return "redirect:http://localhost:8080/web/orderFail2.do";
					}else{
						return "redirect:http://localhost:8080/web/orderFail4.do?closeWin=Y";
					}
				}else{
					if(userAgent.indexOf("MOBI") > -1) {
						return "redirect:/mw/orderFail2.do";
					}else{
						return "redirect:/web/orderFail4.do?closeWin=Y";
					}
				}
			}
		}

		if(Constant.FLAG_INIT == "local"){
			if(userAgent.indexOf("MOBI") > -1) {
				return "redirect:http://localhost:8080/mw/orderFail2.do";
			}else{
				return "redirect:http://localhost:8080/web/orderFail4.do?closeWin=Y";
			}
		}else{
			if(userAgent.indexOf("MOBI") > -1) {
				return "redirect:/web/orderFail2.do";
			}else{
				return "redirect:/web/orderFail4.do?closeWin=Y";
			}
		}
	}*/

	@RequestMapping(value= "/ext/tamnacardCallback")
	public String tamnacardCallback(ModelMap model, HttpServletRequest request) throws IOException{
		log.info("tamnacardCallback");

		String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
		String userAgent = request.getHeader("User-Agent").toUpperCase();

		String mer_key = "";
		String symmKey = "";
		String symmIv = "";
		String mer_no = "";

		/** 탐나는전 개발계 */
		if("test".equals(CST_PLATFORM.trim())) {
			mer_key = "i1s8g528mw3o667v1s00w26ug88m3sj5gx1nj8wd";
			symmKey = "0q5u3qgg5521vky4h93u";
			symmIv  = "h203kcp0yjk1rq9lc874";
			mer_no  = "123020004701";
		/** 탐나는전 운영계 */
		}else{
			mer_key = "m6c0wm8sdqh2u0vo19z5a4meiiuizt2v9e9jm00g";
			symmKey = "f4v584x5m5ptv6jmymj8";
			symmIv  = "40562sai7vyl5b9yl8yv";
			mer_no  = "123010004171";
		}

		boolean testServer = true;											//나이스 테스트 서버 연결

		request.setCharacterEncoding("EUC-KR");

		String result_code = "";          //응답코드 '0000' 경우 만 성공
		String result_msg = "";              //응답메시지
		String tid = "";              //결제 고유번호(취소시사용)
		String param_mer_no = "";              //가맹점번호
		String moid = "";              //가맹점 주문번호
		String cust_id = "";              //구매자ID
		String goods_amt = "";              //상품액
		String mask_card_no = "";              //마스킹 카드번호
		String appr_no = "";              //승인번호
		String card_balance = "";              //카드잔액
		String appr_dt = "";              //승인일자
		String appr_tm = "";              //승인시간
		String tax_free_amt = "";         //비과세
		String vat_amt = "";              //상품 부과세

		log.info("tamnacardApprovedStatus : " + "{" + request.getParameter("result_cd") + "," + request.getParameter("result_msg") + "," + request.getParameter("tid") + "," + request.getParameter("goods_amt") + "," + request.getParameter("moid") + "," + request.getParameter("cust_id") + "," + request.getParameter("mask_card_no") +  "}");

		if(request.getParameter("result_cd").equals("1000")){
			/** 예약정보 select*/
			RSVVO rsvVO = new RSVVO();
			rsvVO.setTamnacardRefHashid(request.getParameter("hash_tid"));
			RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

			// 파트너(협력사) 포인트 set
			String ssPartnerCode = rsvInfo.getPartnerCode();
			int ssUsePoint = rsvInfo.getUsePoint();
			POINTVO pointVO = new POINTVO();
			pointVO.setPartnerCode(ssPartnerCode);
			pointVO.setPoint(ssUsePoint);
			pointVO.setUserId(rsvInfo.getUserId());

			//가용포인트보다 사용포인트가 많을경우에는 예외 처리
			POINTVO partnerPoint = ossPointService.selectAblePoint(pointVO);
			if( partnerPoint.getAblePoint() < ssUsePoint){
				if ("local".equals(Constant.FLAG_INIT)) {
					if (userAgent.indexOf("MOBI") > -1) {
						return "redirect:http://localhost:8080/mw/orderFail2.do";
					} else {
						return "redirect:http://localhost:8080/web/orderFail4.do?closeWin=Y";
					}
				} else {
					if (userAgent.indexOf("MOBI") > -1) {
						return "redirect:/web/orderFail2.do";
					} else {
						return "redirect:/web/orderFail4.do?closeWin=Y";
					}
				}
			}

			SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat tf = new SimpleDateFormat("HHmmss");

			Date today = new Date();
			String pos_date = df.format(today);
			String pos_time = tf.format(today);

			NmcLiteApproval nmcLite = new NmcLiteApproval(mer_key, symmKey, symmIv);

			/** 테스트 연동 (운영 변환시 주석 처리) */
			if("test".equals(CST_PLATFORM.trim())){
				nmcLite.setTestServer(testServer);
			}

			/** 디비에서 주문 정보를 검색 */
			nmcLite.setReqField("trace_no", System.currentTimeMillis() + "");		//요청 번호 (단순 로그 추적용)
			nmcLite.setReqField("mer_no", mer_no);										//가맹점번호
			nmcLite.setReqField("tid", rsvInfo.getTamnacardRefId());      				//주문시 요청한 금액
			nmcLite.setReqField("goods_amt", rsvInfo.getTotalSaleAmt());					//주문시 요청한 금액
			nmcLite.setReqField("cust_id", rsvInfo.getRsvEmail()); 						//주문시 요청한 ID
			nmcLite.setReqField("auth_token", request.getParameter("auth_token")); 	//콜백URL
			nmcLite.setReqField("appr_req_dt", pos_date);								//요청일자
			nmcLite.setReqField("appr_req_tm", pos_time);								//요청시간
			nmcLite.setReqField("moid", rsvInfo.getRsvNum());                            //주문번호

			/** 승인 요청 */
			nmcLite.startAction();

			result_code = nmcLite.getResValue("result_cd"); 								//응답코드 '0000' 경우 만 성공
			result_msg = nmcLite.getResValue("result_msg");								//응답메시지
			tid = nmcLite.getResValue("tid");              								//결제 고유번호(취소시사용)
			moid = nmcLite.getResValue("moid");              							//가맹점 주문번호
			cust_id = nmcLite.getResValue("cust_id");             						//구매자ID
			goods_amt = nmcLite.getResValue("goods_amt");              					//상품액
			mask_card_no = nmcLite.getResValue("mask_card_no");              			//마스킹 카드번호
			appr_no = nmcLite.getResValue("appr_no");              						//승인번호
			card_balance = nmcLite.getResValue("card_balance");              			//카드잔액
			appr_dt = nmcLite.getResValue("appr_dt");              						//승인일자
			appr_tm = nmcLite.getResValue("appr_tm");             						//승인시간

			log.info("tamnacardApprovedStatusFinalCall : " + "{" + result_code + "," + result_msg + "," + tid + "," + goods_amt + "," + moid + "," + cust_id + "," + mask_card_no + "," + appr_no +  "}");

			if(result_code.equals("0000")){
				try {
					/**API 예약 */
					boolean result = apiService.apiReservation(rsvInfo.getRsvNum());
					if (!result) {
						/** 트랜잭션 취소 */
						cancelTamnacard(tid, goods_amt, moid);
						if ("local".equals(Constant.FLAG_INIT)) {
							if (userAgent.indexOf("MOBI") > -1) {

								return "redirect:http://localhost:8080/mw/orderFail2.do";
							} else {
								return "redirect:http://localhost:8080/web/orderFail4.do?closeWin=Y";
							}
						} else {
							if (userAgent.indexOf("MOBI") > -1) {
								return "redirect:/web/orderFail2.do";
							} else {
								return "redirect:/web/orderFail4.do?closeWin=Y";
							}
						}
					}
				} catch (Exception e){
					cancelTamnacard(tid, goods_amt, moid);
				}

				/** DB처리 */
				TAMNACARD_VO tamnacardVo = new TAMNACARD_VO();
				tamnacardVo.setRsvNum(moid);
				tamnacardVo.setApprovalCode(tid);
				tamnacardVo.setTrAmount(goods_amt);
				tamnacardVo.setRemainAmount(goods_amt);
				tamnacardVo.setStatus("SUCCESS");
				tamnacardVo.setTrDateTime(appr_dt+appr_tm);
				tamnacardVo.setNrNumber(appr_no);
				tamnacardVo.setPaySn("0");
				tamnacardVo.setUserInfo(cust_id);
				tamnacardVo.setMaskCardNo(mask_card_no);
				tamnacardVo.setCardBalance(card_balance);
				tamnacardVo.setPgNm("NICE");

				webOrderService.insertTamnacardInfo(tamnacardVo);

				/** 탐나는전 PC코드 */
				if(userAgent.indexOf("MOBI") > -1) {
					rsvInfo.setPayDiv(Constant.PAY_DIV_TC_MI);
				/** 탐나는전 모바일코드 */
				}else{
					rsvInfo.setPayDiv(Constant.PAY_DIV_TC_WI);
				}

				/** 전체예약 테이블 update */
				webOrderService.updateRsvComplete4(rsvInfo);
				/** 이메일발송 */
				webOrderService.orderCompleteSnedSMSMail(rsvInfo,request);

				log.info("tamnacard email paseed");
				//자동쿠폰발행
				webUserCpService.baapCpPublish(rsvInfo);
				log.info("tamnacard cp paseed");

				//파트너 포인트 사용처리
				if (ssPartnerCode != null && ssPartnerCode.length() > 0 && ssUsePoint > 0) {
					pointVO.setPlusMinus("M");
					pointVO.setTypes("USE");
					pointVO.setRsvNum(rsvInfo.getRsvNum());
					pointVO.setTotalSaleAmt(Integer.parseInt(rsvInfo.getTotalNmlAmt()) - Integer.parseInt(rsvInfo.getTotalDisAmt()));
					ossPointService.pointCpUse(pointVO);
				}
				log.info("tamnacard point passed");

				if("local".equals(Constant.FLAG_INIT)){
					if(userAgent.indexOf("MOBI") > -1) {
						log.info("tamnacard mw local passed");
						return "redirect:"+ request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()
								+"/mw/orderComplete.do?rsvNum="+rsvInfo.getRsvNum();
					}else{
						log.info("tamnacard web local passed");
						return "redirect:"+ request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()
								+"/web/orderComplete.do?rsvNum="+rsvInfo.getRsvNum()+"&closeWin=Y";
					}
				}else{
					if(userAgent.indexOf("MOBI") > -1) {
						log.info("tamnacard mw passed");
						return "redirect:/mw/orderComplete.do?rsvNum="+rsvInfo.getRsvNum();
					}else{
						log.info("tamnacard web passed");
						return "redirect:/web/orderComplete.do?rsvNum="+rsvInfo.getRsvNum()+"&closeWin=Y";
					}
				}
			}
		}else if(request.getParameter("result_cd").equals("1002")){
			if("local".equals(Constant.FLAG_INIT)){
				if(userAgent.indexOf("MOBI") > -1) {
					return "redirect:http://localhost:8080/mw/orderFail2.do";
				}else{
					return "redirect:http://localhost:8080/web/orderFail4.do?closeWin=Y";
				}
			}else{
				if(userAgent.indexOf("MOBI") > -1) {
					return "redirect:/web/orderFail2.do";
				}else{
					return "redirect:/web/orderFail4.do?closeWin=Y";
				}
			}
		}else if(request.getParameter("result_cd").equals("1003")){
			if("local".equals(Constant.FLAG_INIT)){
				if(userAgent.indexOf("MOBI") > -1) {
					return "redirect:http://localhost:8080/mw/orderFail2.do";
				}else{
					return "redirect:http://localhost:8080/web/orderFail4.do?closeWin=Y";
				}
			}else{
				if(userAgent.indexOf("MOBI") > -1) {
					return "redirect:/web/orderFail2.do";
				}else{
					return "redirect:/web/orderFail4.do?closeWin=Y";
				}
			}
		}
		if("local".equals(Constant.FLAG_INIT)){
			if(userAgent.indexOf("MOBI") > -1) {
				return "redirect:http://localhost:8080/mw/orderFail2.do";
			}else{
				return "redirect:http://localhost:8080/web/orderFail4.do?closeWin=Y";
			}
		}else{
			if(userAgent.indexOf("MOBI") > -1) {
				return "redirect:/web/orderFail2.do";
			}else{
				return "redirect:/web/orderFail4.do?closeWin=Y";
			}
		}
	}

	/** 탐나는전 결제취소(나이스정보) */
	public String cancelTamnacard(String tidb, String cancelAmt, String rsvNum) {

		String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");

		String mer_key = "";
		String symmKey = "";
		String symmIv = "";
		String mer_no = "";

		/** 탐나는전 개발계 */
		if("test".equals(CST_PLATFORM.trim())) {
			mer_key = "i1s8g528mw3o667v1s00w26ug88m3sj5gx1nj8wd";
			symmKey = "0q5u3qgg5521vky4h93u";
			symmIv  = "h203kcp0yjk1rq9lc874";
			mer_no  = "123020004701";
		/** 탐나는전 운영계 */
		}else{
			mer_key = "m6c0wm8sdqh2u0vo19z5a4meiiuizt2v9e9jm00g";
			symmKey = "f4v584x5m5ptv6jmymj8";
			symmIv  = "40562sai7vyl5b9yl8yv";
			mer_no  = "123010004171";
		}


		boolean testServer = true;				//나이스 테스트 서버 연결
		String result;

		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat tf = new SimpleDateFormat("HHmmss");

		Date today = new Date();
		String pos_date = df.format(today);
		String pos_time = tf.format(today);

		NmcLiteApprovalCancel nmcLite = new NmcLiteApprovalCancel(mer_key, symmKey, symmIv);

		/** 테스트 연동 (운영 변환시 주석 처리) */
		if("test".equals(CST_PLATFORM.trim())) {
			nmcLite.setTestServer(testServer);
		}

		nmcLite.setReqField("trace_no", System.currentTimeMillis() + "");		//요청 번호 (단순 로그 추적용)
		nmcLite.setReqField("mer_no", mer_no);										//가맹점번호
		nmcLite.setReqField("tid", tidb);      			 	//원거래 TID
		nmcLite.setReqField("goods_amt", cancelAmt); 								//취소 금액(전체금액)
		nmcLite.setReqField("cc_msg", "탐나오최종처리오류"); 				//취소사유
		nmcLite.setReqField("net_cancel", "0"); 								//취소타입 0:일반 1:망취소
		nmcLite.setReqField("appr_req_dt", pos_date);								//요청일자
		nmcLite.setReqField("appr_req_tm", pos_time);								//요청시간

		// 승인 요청
		nmcLite.startAction();

		String result_code = nmcLite.getResValue("result_cd"); 						//응답코드 '0000' 경우 만 성공
		String result_msg = nmcLite.getResValue("result_msg");						//응답메시지

		String tid = nmcLite.getResValue("tid");             						//결제 고유번호
		//String param_mer_no = nmcLite.getResValue("mer_no");              				//가맹점번호
		String goods_amt = nmcLite.getResValue("goods_amt");              			//취소금액
		String appr_dt = nmcLite.getResValue("appr_dt");             				//취소일자
		String appr_tm = nmcLite.getResValue("appr_tm");              				//취소시간

		log.info("tamnacardCancelResultStatus : " + "{" + result_code + "," + result_msg + "," + tid + "," + goods_amt + "}");

		if(result_code.equals("0000")){
			/** DB처리*/
			TAMNACARD_VO dbVo  = new TAMNACARD_VO();
			dbVo.setRsvNum(rsvNum);
			dbVo.setApprovalCode(tid);
			dbVo.setTrDateTime(appr_dt+appr_tm);
			dbVo.setPaySn("1");
			dbVo.setPgNm("NICE");
			dbVo.setStatus("SUCCESS");
			webOrderService.insertTamnacardInfo(dbVo);
			result = Constant.FLAG_Y;
		}else{
			/** DB처리*/
			TAMNACARD_VO dbVo  = new TAMNACARD_VO();
			dbVo.setRsvNum(rsvNum);
			dbVo.setApprovalCode(tid);
			dbVo.setTrDateTime(appr_dt+appr_tm);
			dbVo.setPaySn("1");
			dbVo.setPgNm("NICE");
			dbVo.setStatus("FAILED");
			webOrderService.insertTamnacardInfo(dbVo);
			result = Constant.FLAG_N;
		}
		return result;
	}

}
