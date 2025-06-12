package web.mypage.web;

import api.service.APIService;
import api.vo.ApiNextezPrcAdd;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovWebUtil;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.corp.vo.DLVCORPVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rsv.service.MasRsvService;
import mas.rsv.vo.SP_RSVHISTVO;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPPRDTVO;
import oss.coupon.vo.CPVO;
import oss.otoinq.service.OssOtoinqService;
import oss.otoinq.vo.OTOINQSVO;
import oss.otoinq.vo.OTOINQVO;
import oss.point.service.OssPointService;
import oss.point.vo.POINTVO;
import oss.rsv.service.OssRsvService;
import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.USEEPILCMTVO;
import oss.useepil.vo.USEEPILSVO;
import oss.useepil.vo.USEEPILVO;
import oss.user.service.OssUserService;
import oss.user.vo.REFUNDACCINFVO;
import oss.user.vo.UPDATEUSERVO;
import oss.user.vo.USERVO;
import tamnao.crm.common.cipher.CrmAes256;
import web.cs.service.WebUserSnsService;
import web.cs.web.KakaoLogin;
import web.cs.web.NaverLogin;
import web.mypage.service.WebMypageService;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.*;
import web.order.service.WebOrderService;
import web.order.vo.*;
import web.product.service.WebAdProductService;
import web.product.service.WebRcProductService;
import web.product.vo.ADTOTALPRICEVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class WebMypageController {
	 Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;

	@Resource(name="ossOtoinqService")
	private OssOtoinqService ossOtoinqService;

	@Resource(name="ossUesepliService")
	private OssUesepliService ossUesepliService;

	@Resource(name="webOrderService")
	private WebOrderService webOrderService;

	@Resource(name="ossUserService")
	private OssUserService ossUserService;

	@Resource(name="webUserSnsService")
	private WebUserSnsService webUserSnsService;

	@Resource(name="webUserCpService")
	private WebUserCpService webUserCpService;

	@Resource(name="masRsvService")
	private MasRsvService masRsvService;

	@Resource(name="ossRsvService")
	private OssRsvService ossRsvService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "ossCouponService")
	private OssCouponService ossCouponService;

	@Resource(name = "ossCmmService")
    private OssCmmService ossCmmService;

	@Resource(name="apiService")
	private APIService apiService;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Autowired
	private OssPointService ossPointService;

	@RequestMapping("/web/mypage/left.do")
	public String left(@RequestParam Map<String, String> params,
                       ModelMap model) {

		model.addAttribute("menu", params.get("menu"));

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if(userVO != null) {
			//log.info("====>"+userVO.getUserNm());
			if("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/web/restSign.do";
			} else {
				model.addAttribute("userNm", userVO.getUserNm());
                model.addAttribute("pwd", userVO.getPwd());
				model.addAttribute("snsDiv", userVO.getSnsDiv());
			}
		} else {
			//비회원 로그인인 경우
			userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();

			if(userVO != null) {
				//log.info("====>>"+userVO.getUserNm());
				model.addAttribute("userNm", userVO.getUserNm());
			}
		}
		return "web/mypage/left";
	}


	/**
	 * 마이페이지 - 1:1문의
	 * 파일명 : otoinqList
	 * 작성일 : 2015. 11. 16. 오후 12:08:52
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/mypage/otoinqList.do")
	public String otoinqList(@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
							ModelMap model) {

		//로그인 정보 얻기
		USERVO userVO;

    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");

    	if(EgovUserDetailsHelper.isAuthenticated()) {
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/web/restSign.do";
			} else {
				model.addAttribute("userInfo", userVO);
			}
    	}else{
    		return "redirect:/web/viewLogin.do?rtnUrl=/web/mypage/otoinqList.do";
    	}

    	//페이징 관련 설정
    	otoinqSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	otoinqSVO.setPageSize(propertiesService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(otoinqSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(otoinqSVO.getPageUnit());
		paginationInfo.setPageSize(otoinqSVO.getPageSize());

		otoinqSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		otoinqSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		otoinqSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//검색조건 조합
		otoinqSVO.setsWriter(userVO.getUserId());
		otoinqSVO.setsPrintYn("Y");

		//글얻기
		Map<String, Object> resultMap = ossOtoinqService.selectOtoinqListWeb(otoinqSVO);
		@SuppressWarnings("unchecked")
		List<OTOINQVO> resultList = (List<OTOINQVO>) resultMap.get("resultList");

		//데이터 가공
		for(OTOINQVO data: resultList) {
			//log.info("/web/cmm/useepilList.do 호출:"+data.getSubject());

			//내용
			data.setContentsOrg(data.getContents());
			data.setContents(EgovWebUtil.clearXSSMinimum(data.getContents()));
			data.setContents(data.getContents().replaceAll("\n", "<br/>\n"));

			//data.setAnsContentsOrg(data.getAnsContents());
			data.setAnsContents(EgovWebUtil.clearXSSMinimum(data.getAnsContents()));
			data.setAnsContents(data.getAnsContents().replaceAll("\n", "<br/>\n"));

//			//아이디
//			String strEmail = data.getEmail();
//			if(strEmail.length() < 3){
//				strEmail = "***";
//			}else{
//				strEmail = strEmail.substring(0,3)+"*****";
//			}
//			data.setEmail(strEmail);
		}
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("otoinqList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		return "web/mypage/otoinqList";
	}


	@RequestMapping("/web/mypage/otoinqUpdateView.do")
    public String otoinqUpdateView(	@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    		   					ModelMap model) {
//		log.info("/web/cmm/otoinqUpdateView.do 호출");

		OTOINQVO otoinqRes = ossOtoinqService.selectByOtoinq(otoinqVO);

		model.addAttribute("otoinq", otoinqRes);

		return "web/mypage/otoinqUpdate";
	}

	@RequestMapping("/web/mypage/otoinqUpdate.do")
    public String otoinqUpdate(	@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
								HttpServletRequest request,
								HttpServletResponse response) throws Exception {
    	//log.info("/web/cmm/otoinqUpdate.do 호출");

    	//otoinqVO.setWriter("U000000004");
    	//otoinqVO.setEmail("arisa@naver.com");
    	//otoinqVO.setLastModIp("127.0.0.1");

    	//로그인 정보 얻기
    	if(EgovUserDetailsHelper.isAuthenticated()) {
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/web/restSign.do";
			} else {
	    		//model.addAttribute("userInfo", userVO);
	    		otoinqVO.setWriter(userVO.getUserId());
	    		otoinqVO.setEmail(userVO.getEmail());
	    		//otoinqVO.setLastModIp(userVO.getLastLoginIp());
	    		
	    		if((userVO.getLastLoginIp() == null) || (userVO.getLastLoginIp() == "")) {
	    			otoinqVO.setLastModIp(EgovClntInfo.getClntIP(request));
	    		} else {
	    			otoinqVO.setLastModIp(userVO.getLastLoginIp());
	    		}
			}
    	} else {
    		return "redirect:/web/mypage/otoinqList.do?pageIndex="+otoinqSVO.getPageIndex();
    	}
    	
    	ossOtoinqService.updateOtoinq(otoinqVO);

    	return "redirect:/web/mypage/otoinqList.do?pageIndex="+otoinqSVO.getPageIndex();
    }
	
	@RequestMapping("/web/mypage/otoinqDelete.do")
    public String otoinqDelete(	@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO) {
//    	log.info("/web/mypage/otoinqDelete.do 호출");

    	ossOtoinqService.deleteOtoinqByOtoinqNum(otoinqVO);

    	return "redirect:/web/mypage/otoinqList.do?pageIndex="+otoinqSVO.getPageIndex();
    }


	/**
	 * 마이페이지 - 이용후기
	 * 파일명 : useepilList
	 * 작성일 : 2015. 11. 16. 오후 12:09:07
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/mypage/useepilList.do")
	public String useepilList(@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
							  ModelMap model) {

		//로그인 정보 얻기
		USERVO userVO;

    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");

    	if(EgovUserDetailsHelper.isAuthenticated()) {
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/web/restSign.do";
			} else {
				model.addAttribute("userInfo", userVO);
			}
    	} else {
    		return "redirect:/web/viewLogin.do?rtnUrl=/web/mypage/useepilList.do";
    	}

    	//페이징 관련 설정
    	useepilSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	useepilSVO.setPageSize(propertiesService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(useepilSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(useepilSVO.getPageUnit());
		paginationInfo.setPageSize(useepilSVO.getPageSize());

		useepilSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		useepilSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		useepilSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//검색조건 조합
		useepilSVO.setsUserId(userVO.getUserId());
		useepilSVO.setsPrintYn("Y");

		//상품평 얻기
		Map<String, Object> resultMap = ossUesepliService.selectUseepilListWeb(useepilSVO);
		@SuppressWarnings("unchecked")
		List<USEEPILVO> resultList = (List<USEEPILVO>) resultMap.get("resultList");

		//상품평 댓글 얻기
		List<USEEPILCMTVO> resultCmtList = ossUesepliService.selectUseepCmtilListWeb(useepilSVO);

		//데이터 가공
		for(USEEPILVO data: resultList) {
			//log.info("/web/cmm/useepilList.do 호출:"+data.getSubject());

			//내용
			data.setContentsOrg(data.getContents());
			data.setContents(EgovWebUtil.clearXSSMinimum(data.getContents()) );
			data.setContents( data.getContents().replaceAll("\n", "<br/>\n") );

			//아이디
			String strEmail = data.getEmail();
			if(strEmail.length() < 3) {
				strEmail = "***";
			} else {
				strEmail = strEmail.substring(0,3) + "*****";
			}
			data.setEmail(strEmail);

			//앞에 표시될꺼 조합
			String strCoCd =  data.getPrdtnum().substring(0, 2);

			data.setCoCd(strCoCd);
			
			if(Constant.ACCOMMODATION.equals(strCoCd)) {
				data.setSubjectHeder(data.getCorpNm());
			} else if(Constant.RENTCAR.equals(strCoCd)) {
				data.setSubjectHeder(data.getCorpNm() + "-" + data.getPrdtNm());
			} else {
				data.setSubjectHeder(data.getPrdtNm());
			}

			//data.setSubjectHeder(subjectHeder);

			//답글 조합
			List<USEEPILCMTVO> listCmt = new ArrayList<USEEPILCMTVO>();

			for(USEEPILCMTVO dataCmt: resultCmtList) {
				if("Y".equals(dataCmt.getPrintYn())) {
					if(data.getUseEpilNum().equals(dataCmt.getUseEpilNum())) {
						//log.info("/web/cmm/useepilList.do 호출:"+data.getUseEpilNum()+":"+dataCmt.getUseEpilNum()+":"+dataCmt.getContents());

						dataCmt.setContentsOrg(dataCmt.getContents());
						dataCmt.setContents(EgovWebUtil.clearXSSMinimum(dataCmt.getContents()) );
						dataCmt.setContents(dataCmt.getContents().replaceAll("\n", "<br/>\n"));
						listCmt.add(dataCmt);
					}
				}
			}
			data.setCmtList(listCmt);
		}
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("useepilList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "web/mypage/useepilList";
	}


	@RequestMapping(value="/web/mypage/saveInterestProduct.ajax")
	public ModelAndView saveInterestProduct(@ModelAttribute("ITR_PRDTVO")ITR_PRDTVO itr_PRDTVO) {

		if(EgovUserDetailsHelper.isAuthenticated()) {
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		itr_PRDTVO.setUserId(userVO.getUserId());
    	}
		// 중복 체크
		int cnt = webMypageService.selectByItrPrdt(itr_PRDTVO);

		if(cnt == 0) {
			webMypageService.insertItrPrdt(itr_PRDTVO);
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}
	/**
	 * 할인쿠폰 보관함
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/mypage/freeCouponList.do")
	public String freeCouponList(ModelMap model) {

		String userId = null;

		if(EgovUserDetailsHelper.isAuthenticated()) {
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		userId = userVO.getUserId();
    	}

		Map<String, Object> resultMap = webMypageService.selectItrFreeProductList(userId);

		model.addAttribute("resultList", resultMap.get("resultList"));
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));

		return "web/mypage/freeCouponList";
	}

	@RequestMapping("/web/mypage/deleteFreeCoupon.ajax")
	public ModelAndView deleteFreeCoupon(@ModelAttribute("ITR_PRDTVO")ITR_PRDTVO itr_PRDTVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		if(EgovUserDetailsHelper.isAuthenticated()) {
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		itr_PRDTVO.setUserId(userVO.getUserId());
    	}
		webMypageService.deleteItrFreeProduct(itr_PRDTVO);

		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	/**
	 * 예약 내역
	 * 파일명 : rsvList
	 * 작성일 : 2015. 11. 24. 오전 11:13:31
	 * 작성자 : 최영철
	 * @param rsvHisSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/mypage/rsvList.do")
	public String rsvList(@ModelAttribute("RSV_HISSVO") RSV_HISSVO rsvHisSVO,
						  HttpServletRequest request,
						  ModelMap model) {

		//페이징 관련 설정
		rsvHisSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		rsvHisSVO.setPageSize(propertiesService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(rsvHisSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(rsvHisSVO.getPageUnit());
		paginationInfo.setPageSize(rsvHisSVO.getPageSize());

		rsvHisSVO.setFirstIndex(paginationInfo.getFirstRecordIndex()+1);
		rsvHisSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		rsvHisSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//기본 날짜 설정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate today = LocalDate.now();
		LocalDate monthsAgo = today.minusMonths(3);
		if (rsvHisSVO.getsFromDt() == null) {
			rsvHisSVO.setsFromDt(monthsAgo.format(formatter));
			rsvHisSVO.setsToDt(today.format(formatter));
		}

		//로그인 검사
		if(EgovUserDetailsHelper.isAuthenticated() == false){
			if(EgovUserDetailsHelper.isAuthenticatedGuest() == false){
				return "redirect:/web/viewLogin.do?rtnUrl=/web/mypage/rsvList.do";
			}
		}
		if(EgovStringUtil.isEmpty(rsvHisSVO.getAutoCancelYn())) {
			rsvHisSVO.setAutoCancelYn("N");
		}
		// 대기시간
		rsvHisSVO.setWaitingTime(Constant.WAITING_TIME);

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if(userVO != null) {

			if("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/web/restSign.do";
			} else {
				rsvHisSVO.setUserId(userVO.getUserId());

				// 예약 상품 리스트
		     	List<ORDERVO> orderList = webOrderService.selectOrderList2(rsvHisSVO);
				Integer totalCnt = webOrderService.selectOrderList2Cnt(rsvHisSVO);
		     	for(int i=0; i<orderList.size(); i++) {
		     		if(Constant.ACCOMMODATION.equals(orderList.get(i).getPrdtCd())) {
		     			orderList.get(i).setPrdtUrlDiv("sPrdtNum="+orderList.get(i).getPrdtNum());
		     		}else {
		     			orderList.get(i).setPrdtUrlDiv("prdtNum="+orderList.get(i).getPrdtNum());
		     		}
		     		
		     		//마이페이지 상품 리스트 클릭시 상세페이지로 이동하기 위함
		     		if("C".equals(orderList.get(i).getPrdtCd().substring(0, 1))) {
		     			orderList.get(i).setPrdtCd("sp");
		     		}
		     	}
				paginationInfo.setTotalRecordCount(totalCnt);

				model.addAttribute("isGuest", "N");
		     	model.addAttribute("orderList", orderList);

				//개인별 파트너포인트 조회
				String ssPartnerCode = (String) request.getSession().getAttribute("ssPartnerCode");
				if (!"".equals(ssPartnerCode)) {
					POINTVO pointVO = new POINTVO();
					pointVO.setPartnerCode(ssPartnerCode);
					pointVO.setUserId(userVO.getUserId());
					POINTVO myPoint = ossPointService.selectAblePoint(pointVO);
					model.addAttribute("myPoint", myPoint);
				}

			}
		} else {
			//비회원 로그인인 경우
			userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();

			rsvHisSVO.setUserId(Constant.RSV_GUSET_NAME);//비회원의 경우 ID가 공백
			rsvHisSVO.setRsvNm(userVO.getUserNm().trim());
			rsvHisSVO.setRsvTelnum(userVO.getTelNum());

			List<RSVVO> rsvList = webOrderService.selectUserRsvListGuest(rsvHisSVO);

			model.addAttribute("rsvList", rsvList);

			// 예약 상품 리스트
	     	List<ORDERVO> orderList = webOrderService.selectOrderList2Guest(rsvHisSVO);
			Integer totalCnt = webOrderService.selectOrderList2GuestCnt(rsvHisSVO);

	     	for(int i=0; i<orderList.size(); i++) {
	     		if(Constant.ACCOMMODATION.equals(orderList.get(i).getPrdtCd())) {
	     			orderList.get(i).setPrdtUrlDiv("sPrdtNum="+orderList.get(i).getPrdtNum());
	     		}else {
	     			orderList.get(i).setPrdtUrlDiv("prdtNum="+orderList.get(i).getPrdtNum());
	     		}
	     		
	     		//마이페이지 상품 리스트 클릭시 상세페이지로 이동하기 위함
	     		if("C".equals(orderList.get(i).getPrdtCd().substring(0, 1))) {
	     			orderList.get(i).setPrdtCd("sp");
	     		}
	     	}
			paginationInfo.setTotalRecordCount(totalCnt);
			model.addAttribute("isGuest", "Y");
	     	model.addAttribute("orderList", orderList);
		}

		model.addAttribute("CST_PLATFORM", EgovProperties.getOptionalProp("CST_PLATFORM"));
		model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
		model.addAttribute("paginationInfo", paginationInfo);
		return "/web/mypage/rsvList";
	}

	/**
	 * 예약 내역 상세
	 * 파일명 : detailRsv
	 * 작성일 : 2015. 11. 24. 오전 11:13:46
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @param model
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/web/mypage/detailRsv.do")
	public String detailRsv(@ModelAttribute("RSVVO") RSVVO rsvVO,
							ModelMap model) throws ParseException {
		Boolean isUser = EgovUserDetailsHelper.isAuthenticated();
		Boolean isGuest = EgovUserDetailsHelper.isAuthenticatedGuest();
		/** 환불계좌관리 레코드 유무 (비회원은 모두 Y처리) */
		REFUNDACCINFVO refundAccInf = new REFUNDACCINFVO();

		if(isUser == false){
			if(isGuest == false){
				return "redirect:/web/viewLogin.do?rtnUrl=/web/mypage/rsvList.do";
			}
		}else{
			USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
			ORDERSVO orderSVO = new ORDERSVO();
			orderSVO.setsUserId(loginVO.getUserId());
			refundAccInf = ossRsvService.selectByRefundAccInf(orderSVO);
		}
		model.addAttribute("isUser", isUser);
		model.addAttribute("refundAccInf", refundAccInf);

		/** 은행코드 */
		List<CDVO> cdRfac = ossCmmService.selectCode("RFAC");
		model.addAttribute("cdRfac", cdRfac);

		if(EgovStringUtil.isEmpty(rsvVO.getRsvNum())) {
			log.error("rsvNum is null");
			return "redirect:/web/mypage/rsvList.do";
		}
		rsvVO.setLGD_RESPCODE("8888");
		rsvVO.setPartnerCode("");
		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

		Date fromDate = Calendar.getInstance().getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date toDate = sdf.parse(rsvInfo.getRegDttm());

		long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) + (Constant.WAITING_TIME * 60);

    	model.addAttribute("difTime", difTime);
    	model.addAttribute("rsvInfo", rsvInfo);

		List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);

		OrderComparator orderCom = new OrderComparator();
    	Collections.sort(orderList, orderCom);

		Map<String, List<SP_RSVHISTVO>> spRsvHistMap = new HashMap<String, List<SP_RSVHISTVO>>();

		String orderDiv = null;
		/** 사용완료일 경우에만 이용후기 작성 가능하도록 설정 하기 위한 변수*/
		String useepilRegYn = Constant.FLAG_N;

		for(ORDERVO order : orderList) {
			if(Constant.SP_PRDT_DIV_TOUR.equals(order.getPrdtDiv())|| Constant.SP_PRDT_DIV_COUP.equals(order.getPrdtDiv())) {
				SP_RSVVO spRsvVO = new SP_RSVVO();
				spRsvVO.setSpRsvNum(order.getPrdtRsvNum());
				List<SP_RSVHISTVO> spRsvhistList = masRsvService.selectSpRsvHistList(spRsvVO);

				spRsvHistMap.put(order.getPrdtRsvNum(), spRsvhistList);
			}
			if(Constant.SV.equals(order.getPrdtNum().substring(0,2).toUpperCase())) {
				orderDiv = Constant.SV;
			}
			
			if(Constant.RSV_STATUS_CD_UCOM.equals(order.getRsvStatusCd()) || Constant.RSV_STATUS_CD_SCOM.equals(order.getRsvStatusCd())){
				useepilRegYn = Constant.FLAG_Y;
			}
		}

		//파일 리스트
		RSVFILEVO rsvFileVO = new RSVFILEVO();
		rsvFileVO.setRsvNum(rsvVO.getRsvNum());
		rsvFileVO.setCategory("PROVE");
		List<RSVFILEVO> fileList = webMypageService.selectRsvFileList(rsvFileVO);

		model.addAttribute("fileList", fileList);
		model.addAttribute("spRsvHistMap", spRsvHistMap);
    	model.addAttribute("orderList", orderList);
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()));
    	model.addAttribute("orderDiv", orderDiv);
    	model.addAttribute("useepilRegYn", useepilRegYn);

    	//영수증 관련 처리
    	setRecPnt(rsvInfo.getRsvNum(), model);

		return "/web/mypage/detailRsv";
	}


	public void setRecPnt(String ID, ModelMap model) {

    	LGPAYINFVO lgpayinfVO = webOrderService.selectLGPAYINFO(ID);

    	//log.info("============= ID:" + ID);
    	String MERT_KEY = EgovProperties.getProperty("Globals.LgdMertKey.PRE");
    	//log.info("============= MERT_KEY:" + MERT_KEY);
    	//log.info("============= getRsvNum:" + resultVO.getRsvNum());

    	if(lgpayinfVO != null) {
    		String CST_PLATFORM	= EgovProperties.getOptionalProp("CST_PLATFORM");     	//LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
    	    String CST_MID      = EgovProperties.getProperty("Globals.LgdID.PRE");           	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
    	    String LGD_MID      = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
    	    //log.info("============= lgpayinfVO:" + lgpayinfVO.getLGD_OID() + " | " + lgpayinfVO.getLGD_TID());

    	    model.addAttribute("recPntYn", "Y");
        	model.addAttribute("CST_PLATFORM", CST_PLATFORM);
        	model.addAttribute("LGD_MID", LGD_MID);
        	model.addAttribute("LGD_TID", lgpayinfVO.getLGD_TID());
        	model.addAttribute("MERT_KEY", MERT_KEY);

    		if("SC0010".equals(lgpayinfVO.getLGD_PAYTYPE())) {
    			//카드 결제
	    	    String autKey = LGD_MID+lgpayinfVO.getLGD_TID()+MERT_KEY;
	    	    //log.info("============= autKey:" + autKey);
	        	String authdata = "";

				try {
					authdata = EgovWebUtil.generateMD5encryption(autKey);
				} catch(NoSuchAlgorithmException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	//log.info("============= authdata:" + authdata);
	        	model.addAttribute("authdata", authdata);
	        	model.addAttribute("recPntType", "card");
    		} else if("SC0030".equals(lgpayinfVO.getLGD_PAYTYPE()) || "SC0040".equals(lgpayinfVO.getLGD_PAYTYPE())) {
    			//현금 결제
    			if(!(lgpayinfVO.getLGD_CASHRECEIPTNUM() == null || lgpayinfVO.getLGD_CASHRECEIPTNUM().isEmpty() || "".equals(lgpayinfVO.getLGD_CASHRECEIPTNUM()))) {
    				//현금 영수증이 신청된 경우에만 보임
	    			model.addAttribute("LGD_OID", lgpayinfVO.getLGD_OID());

	    			String cashType = "";

	    			if("SC0030".equals(lgpayinfVO.getLGD_PAYTYPE())) {
	    				cashType = "BANK";
	    			} else if("SC0040".equals(lgpayinfVO.getLGD_PAYTYPE())) {
	    				cashType = "CAS";
	    			}
	    			model.addAttribute("cashType", cashType);
	    			model.addAttribute("recPntType", "cash");
    			} else {
    				model.addAttribute("recPntType", "Nocash");
    			}
    		}
    	}
    }

	/**
	 * 마이페이지 > 개인정보수정
	 * 파일명 : viewUpdateUser
	 * 작성일 : 2015. 11. 24. 오후 5:09:04
	 * 작성자 : 최영철
	 * @param user
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/mypage/viewUpdateUser.do")
	public String viewUpdateUser(@ModelAttribute("UPDATEUSERVO") UPDATEUSERVO user,
								 ModelMap model) {

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		user.setUserId(userVO.getUserId());

		USERVO resultVO = ossUserService.selectByUser(user);

		model.addAttribute("user", resultVO);

    	return "/web/mypage/updateUser";
	}

	/**
	 * 개인정보 수정
	 * 파일명 : updateUser
	 * 작성일 : 2015. 11. 24. 오후 5:08:55
	 * 작성자 : 최영철
	 * @param user
	 * @return
	 */
	@RequestMapping("/web/mypage/updateUser.do")
	public String updateUser(@ModelAttribute("user") UPDATEUSERVO user,
							RedirectAttributes redirectAttributes) throws NullPointerException {
		try {
			ossUserService.updateUser(user);

			redirectAttributes.addFlashAttribute("resultCd", "Y");
		} catch (NullPointerException e) {
			log.error(e.getMessage());

			redirectAttributes.addFlashAttribute("resultCd", "N");
		}
		return "redirect:/web/mypage/viewUpdateUser.do";
	}

	/**
	 * 비밀번호 변경 View
	 * 파일명 : viewChangePw
	 * 작성일 : 2015. 11. 25. 오전 11:44:28
	 * 작성자 : 최영철
	 * @param user
	 * @return
	 */
	@RequestMapping("/web/mypage/viewChangePw.do")
	public String viewChangePw(@ModelAttribute("UPDATEUSERVO") UPDATEUSERVO user) {

		return "/web/mypage/changePw";
	}

	/**
	 * 사용자 비밀번호 변경
	 * 파일명 : changePw
	 * 작성일 : 2015. 11. 25. 오전 11:44:40
	 * 작성자 : 최영철
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/web/mypage/changePw.ajax")
	public ModelAndView changePw(@ModelAttribute("USERVO") USERVO user) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		user.setEmail(userVO.getEmail());

		USERVO resultVO;

		if(StringUtils.isEmpty(user.getPwd())) {
			resultVO = new USERVO();
		} else {
			// 1. 패스워드 일치 여부 확인
			resultVO = ossUserService.isEqualPw(user);
		}

    	if(resultVO == null) {
    		resultMap.put("rtnVal", "1");
    	} else {
			user.setUserId(userVO.getUserId());

    		ossUserService.updatePwd(user);
    		resultMap.put("rtnVal", "0");
    	}
    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	@RequestMapping("/web/mypage/changePwComplet.do")
	public String changePwComplet(@ModelAttribute("UPDATEUSERVO") UPDATEUSERVO user) {

		return "/web/mypage/changePwComplet";
	}

	/**
	 * 회원탈퇴 View
	 * 파일명 : viewDropUser
	 * 작성일 : 2015. 11. 25. 오후 2:02:12
	 * 작성자 : 최영철
	 * @param user
	 * @return
	 */
	@RequestMapping("/web/mypage/viewDropUser.do")
	public String viewDropUser(@ModelAttribute("UPDATEUSERVO") UPDATEUSERVO user,
                               ModelMap model){

        USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
        user.setUserId(userVO.getUserId());

        USERVO resultVO = ossUserService.selectByUser(user);

        model.addAttribute("user", resultVO);

		return "/web/mypage/dropUser";
	}

	/**
	 * 회원탈퇴
	 * 파일명 : dropUser
	 * 작성일 : 2015. 11. 25. 오후 2:02:25
	 * 작성자 : 최영철
	 * @param qutRsn
	 * @return
	 */
	@RequestMapping("/web/mypage/dropUser.ajax")
	public ModelAndView dropUser(@RequestParam("qutRsn") String qutRsn,
                                 @RequestParam("snsDiv") String snsDiv) {
        USERVO user = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

        user.setQutRsn(qutRsn);

        //간편로그인 연동 해제
        if(snsDiv != null && !"".equals(snsDiv)) {
			String snsDivs[] = snsDiv.split(",");
            for(int i=0; i < snsDivs.length; i++) {
                if("N".equals(snsDivs[i])) {
					user.setSnsDiv("N");
					USERVO userSns = webUserSnsService.selectUserSns(user);
					String refreshToken = userSns.getToken();
                    if(StringUtils.isNotEmpty(refreshToken)) {
                        JsonNode token = NaverLogin.getRefreshToken(refreshToken);
                    }
                    webUserSnsService.deleteUserSns(user);
                } else if("K".equals(snsDivs[i])) {
                    user.setSnsDiv("K");
                    USERVO userSns = webUserSnsService.selectUserSns(user);
                    JsonNode unlink = KakaoLogin.getKakaoUnlink(userSns.getLoginKey());
                    webUserSnsService.deleteUserSns(user);
                } else if("A".equals(snsDivs[i])){
                	user.setSnsDiv("A");
                    webUserSnsService.deleteUserSns(user);
				}
            }
		}
        /** API통신 실패라도 DB상에서 삭제*/
		user.setSnsDiv("");
			webUserSnsService.deleteUserSns(user);
	        Map<String, Object> resultMap = new HashMap<String, Object>();
	        try {
            ossUserService.dropUser(user);
            resultMap.put("result", "success");
        } catch (Exception e) {
            log.error("dropUser Exception", e);
            resultMap.put("result", "fail");
        }
    	ModelAndView mv = new ModelAndView("jsonView", resultMap);

		return mv;
	}

	@RequestMapping("/web/mypage/couponList.do")
	public String couponList(ModelMap model) {

		if(!EgovUserDetailsHelper.isAuthenticated()) {
			return "redirect:/web/viewLogin.do?rtnUrl=/web/mypage/couponList.do";
		}
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	// 쿠폰 목록
		List<USER_CPVO> couponList = webUserCpService.selectCouponList(userVO.getUserId());

        // 쿠폰 적용상품 목록
        Map<String, Object> productMap = new HashMap<String, Object>();

        for(USER_CPVO userCpvo : couponList) {
        	// 상품 지정
            if(Constant.CP_APLPRDT_DIV_PRDT.equals(userCpvo.getAplprdtDiv())) {
                CPVO cpvo = new CPVO();
                cpvo.setCpId(userCpvo.getCpId());

                List<CPPRDTVO> cpPrdtList = ossCouponService.selectCouponPrdtListWeb(cpvo);

				String product = "";

				for(CPPRDTVO cpPrdt : cpPrdtList) {
					product += "<p>[" + cpPrdt.getCorpNm() + "]";
					product += cpPrdt.getPrdtNm();
					if(StringUtils.isNotEmpty(cpPrdt.getDivNm())) {
						product += " - " + cpPrdt.getDivNm();
					}
                    if(StringUtils.isNotEmpty(cpPrdt.getOptNm())) {
						product += " - " + cpPrdt.getOptNm();
					}
                    // 할인방식이 무료인 경우 상품이용수 표시
                    if(Constant.CP_DIS_DIV_FREE.equals(userCpvo.getDisDiv())) {
						String prdtCd = cpPrdt.getPrdtNum().substring(0, 2);
						String unit;
						if(Constant.ACCOMMODATION.equals(prdtCd)) {
							unit = "박";
						} else if(Constant.RENTCAR.equals(prdtCd)) {
							unit = "시간";
						} else {
							unit = "개";
						}
						product += " (" + cpPrdt.getPrdtUseNum() + unit + ")";
					}
                    product += "</p>";
                }
                productMap.put(userCpvo.getCpId(), product.substring(0, product.length() - 4));
            }
            if(Constant.CP_APLPRDT_DIV_CORP.equals(userCpvo.getAplprdtDiv())) {
                CPVO cpvo = new CPVO();
                cpvo.setCpId(userCpvo.getCpId());

                List<CPPRDTVO> cpPrdtList = ossCouponService.selectCouponCorpListWeb(cpvo);

				String product = "";

				for(CPPRDTVO cpPrdt : cpPrdtList) {
					product += "<p>[" + cpPrdt.getCorpNm() + "]";
                    product += "</p>";
                }
                productMap.put(userCpvo.getCpId(), product.substring(0, product.length() - 4));
            }
        }
		model.addAttribute("resultList", couponList);
        model.addAttribute("productMap", productMap);

		return "web/mypage/couponList";
	}

	/**
	 * 환불 계좌 관리 화면
	 * 파일명 : viewRefundAccNum
	 * 작성일 : 2016. 1. 28. 오후 2:28:26
	 * 작성자 : 최영철
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/mypage/viewRefundAccNum.do")
	public String viewRefundAccNum(ModelMap model) {

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		ORDERSVO orderSVO = new ORDERSVO();
		orderSVO.setsUserId(userVO.getUserId());

		REFUNDACCINFVO refundAccInf = ossRsvService.selectByRefundAccInf(orderSVO);
		model.addAttribute("refundAccInf", refundAccInf);

		List<CDVO> cdRfac = ossCmmService.selectCode("RFAC");
		model.addAttribute("cdRfac", cdRfac);

		return "web/mypage/refundAccNum";
	}

	/**
	 * 사용자 환불계좌 정보 조회
	 * 파일명 : selectAccNum
	 * 작성일 : 2016. 1. 28. 오전 10:48:15
	 * 작성자 : 최영철
	 * @return
	 */
	@RequestMapping("/web/mypage/selectAccNum.ajax")
	public ModelAndView selectAccNum() {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		ORDERSVO orderSVO = new ORDERSVO();
		orderSVO.setsUserId(userVO.getUserId());

		REFUNDACCINFVO refundAccInf = ossRsvService.selectByRefundAccInf(orderSVO);

		resultMap.put("refundAccInf", refundAccInf);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	/**
	 * 환불계좌 업데이트
	 * 파일명 : mergeAccNum
	 * 작성일 : 2016. 1. 28. 오전 11:08:46
	 * 작성자 : 최영철
	 * @param refundAccInfVO
	 * @return
	 */
	@RequestMapping("/web/mypage/mergeAccNum.ajax")
	public ModelAndView mergeAccNum(@ModelAttribute("REFUNDACCINFVO") REFUNDACCINFVO refundAccInfVO) {

		Map<String, Object> resultMap = new HashMap<String,Object>();

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		refundAccInfVO.setUserId(userVO.getUserId());

		ossRsvService.mergeAccNum(refundAccInfVO);

		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	/**
	 * 찜한 상품 리스트
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/mypage/pocketList.do")
	public String pocketList(ModelMap model) {

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		List<POCKETVO> pocketList = webMypageService.selectPocketList(userVO.getUserId());

		for(POCKETVO pocket : pocketList) {
			if(Constant.ACCOMMODATION.equals(pocket.getPrdtDiv())) {
				ADTOTALPRICEVO adTotPrice = new ADTOTALPRICEVO();
				adTotPrice.setPrdtNum(pocket.getPrdtNum());
				
				if(pocket.getAdUseDt() == null) {
		    		//초기 날짜 지정
		    		Calendar calNow = Calendar.getInstance();

		    		adTotPrice.setsFromDt(String.format("%d%02d%02d",
										calNow.get(Calendar.YEAR),
										calNow.get(Calendar.MONTH) + 1,
										calNow.get(Calendar.DAY_OF_MONTH))
										);
				}
			//	adTotPrice.setsFromDt( pocket.getAdUseDt());
				adTotPrice.setiNight(1);
				adTotPrice.setiMenAdult(2);
				adTotPrice.setiMenJunior(0);
				adTotPrice.setiMenChild(0);
				int nPrice = webAdProductService.getTotalPrice(adTotPrice);
				if(nPrice <= 0) {
					pocket.setPrdtAmt("0");
					pocket.setRsvAbleYn(Constant.FLAG_N);
				} else {
					pocket.setPrdtAmt(String.valueOf(nPrice));
					pocket.setRsvAbleYn(Constant.FLAG_Y);
				}
			} else if(Constant.RENTCAR.equals(pocket.getPrdtDiv())) {
				RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
//				BeanUtils.copyProperties(cart, prdtSVO);
				prdtSVO.setFirstIndex(0);
				prdtSVO.setLastIndex(1);
				
				if(prdtSVO.getsFromDt() == null) {
		    		Calendar calNow = Calendar.getInstance();
		    		calNow.add(Calendar.DAY_OF_MONTH, 1);
		    		prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
		    		prdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
		    		prdtSVO.setsFromTm("1200");

		    		calNow.add(Calendar.DAY_OF_MONTH, 1);
		    		prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
		    		prdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
		    		prdtSVO.setsToTm("1200");
		    	}


				prdtSVO.setsPrdtNum(pocket.getPrdtNum());
				
				// 판매 많은 순
	    		prdtSVO.setOrderCd(Constant.ORDER_PRICE);
	    		prdtSVO.setOrderAsc(Constant.ORDER_DESC);

				// 단건에 대한 렌터카 정보 조회
		    	List<RC_PRDTINFVO> resultList = webRcProductService.selectRcPrdtList2(prdtSVO);
		    	RC_PRDTINFVO prdtInfo = resultList.get(0);

		    	pocket.setPrdtAmt(prdtInfo.getSaleAmt());
		    	pocket.setRsvAbleYn(prdtInfo.getAbleYn());
			}
		}
		model.addAttribute("pocketList", pocketList);
		return "/web/mypage/pocketList";
	}

	/**
	 * 상품 찜하기.
	 * @return
	 */
	@RequestMapping("/web/mypage/addPocket.ajax")
	public ModelAndView savePocketList(@RequestBody POCKETLISTVO pocketListVO, HttpServletRequest request) throws Exception {
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		List<POCKETVO> pocketList = pocketListVO.getPocketList();
		for(POCKETVO pocket : pocketList) {
			/** 데이터제공 좋아요정보 수집*/
			ApiNextezPrcAdd apiNextezPrcAdd = new ApiNextezPrcAdd();
			apiNextezPrcAdd.setvCtgr(pocket.getPrdtDiv());
			if(EgovClntInfo.isMobile(request)){
				apiNextezPrcAdd.setvConectDeviceNm("MOBILE");
			}else{
				apiNextezPrcAdd.setvConectDeviceNm("PC");
			}
			if("AD".equals(pocket.getPrdtDiv())){
				apiNextezPrcAdd.setvPrdtNum(pocket.getCorpId());
			}else{
				apiNextezPrcAdd.setvPrdtNum(pocket.getPrdtNum());
			}
			apiNextezPrcAdd.setvType("like");
			if(!"SV".equals(apiNextezPrcAdd.getvCtgr())){
				apiService.insertNexezData(apiNextezPrcAdd);
			}
			/** 좋아요 데이터 저장 */
			pocket.setUserId(userVO.getUserId());
			webMypageService.insertPocket(pocket);
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}

	@RequestMapping("/web/mypage/deletePocket.ajax")
	public ModelAndView deletePocket(@RequestParam(value="pocketSn") String pocketSn) {

		String [] arr_pocketSn = pocketSn.split(",");

		webMypageService.deletePockets(arr_pocketSn);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}
	
	/**
	 * 상품 찜하기 개수 산출
	 * Function : pocketCnt
	 * 작성일 : 2017. 11. 24. 오후 2:09:59
	 * 작성자 : 정동수
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/web/mypage/pocketCnt.ajax")
    public ModelAndView pocketCnt(HttpServletRequest request,
    							HttpServletResponse response) {
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		List<POCKETVO> pocketList = new ArrayList<POCKETVO>();

		if(userVO != null && !"".equals((userVO.getUserId()))) {
			pocketList = webMypageService.selectPocketList(userVO.getUserId());
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap.put("pocketCnt", pocketList.size());

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }

	@RequestMapping("/web/mypage/couponCnt.ajax")
	    public ModelAndView couponCnt(HttpServletRequest request,
	    							HttpServletResponse response) {
			USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

			Integer couponCnt = 0;

			if(userVO != null && !"".equals((userVO.getUserId()))) {
                couponCnt = webMypageService.selectCoupontCnt(userVO.getUserId());
			}
			Map<String, Object> resultMap = new HashMap<String, Object>();
	    	resultMap.put("pocketCnt", couponCnt);

			ModelAndView mav = new ModelAndView("jsonView", resultMap);

			return mav;
	    }

	/**
	 * 배송추적
	 * @return
	 */
	@RequestMapping("/web/dlvTrace.ajax")
	public ModelAndView dlvTrace(@RequestParam(value="rsvNum") String rsvNum) {

		DLVCORPVO dlvCorpVO =  webMypageService.dlvTrace(rsvNum);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("url", dlvCorpVO.getWebUrl());

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	/**
	 * 이벤트 상품 수령 시 등록 처리
	 * Function : insertEventReceive
	 * 작성일 : 2017. 3. 29. 오전 11:20:37
	 * 작성자 : 정동수
	 * @param receiveAdminPw
	 * @return
	 */
	@RequestMapping("/web/mypage/insertEventReceive.ajax")
	public ModelAndView insertEventReceive(@RequestParam(value="receiveAdminPw") String receiveAdminPw) {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 입력한 비번이 동일 하면.. (MwMypageController 확인)
		if("8861".equals(receiveAdminPw)) {
			USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

			if(userVO == null) {
				//비회원 로그인인 경우
				userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();
			}

			// 이벤트 상품 수령 여부 체크
			if(webMypageService.selectEvntPrdtRcvNum(userVO) == false) {
				// 이벤트 상품 수령 정보 등록
				webMypageService.insertEvntPrdtRcv(userVO);
				resultMap.put("processKey", "success");
			} else {
				resultMap.put("processKey", "duplicateFail");
			}
		} else {
			resultMap.put("processKey", "passFail");
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

    // 네이버 로그인 연동 해제
    @RequestMapping("/web/naverUnlink.do")
    public String naverUnlink(@ModelAttribute("UPDATEUSERVO") USERVO user,
                              HttpServletRequest request) {
		USERVO userSns = webUserSnsService.selectUserSns(user);

		String refreshToken = userSns.getToken();

		if(StringUtils.isNotEmpty(refreshToken)) {
			JsonNode token = NaverLogin.getRefreshToken(refreshToken);

            JsonNode unlink = NaverLogin.getNaverUnlink(token.path("access_token").asText());
            log.info("naver unlink", unlink.get("access_token").asText());
        }
        FlashMap fm = RequestContextUtils.getOutputFlashMap(request);
        fm.put("userInfo", user);

        return "redirect:/web/deleteUserSns.do";
    }

    // 카카오 로그인 연동 해제
    @RequestMapping("/web/kakaoUnlink.do")
    public String kakaoUnlink(@ModelAttribute("UPDATEUSERVO") USERVO user,
                              HttpServletRequest request) {
        USERVO userSns = webUserSnsService.selectUserSns(user);

        JsonNode unlink = KakaoLogin.getKakaoUnlink(userSns.getLoginKey());
        log.info("kakao unlink", unlink.get("id").asText());

        FlashMap fm = RequestContextUtils.getOutputFlashMap(request);
        fm.put("userInfo", user);

        return "redirect:/web/deleteUserSns.do";
    }

	// 쿠폰 받기
	@RequestMapping("/web/couponDownload.ajax")
	public ModelAndView couponDownloadAjax(@RequestParam String cpId) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 로그인 정보
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		/*
		if(userVO != null) {
			webUserCpService.cpPublish(userVO.getUserId(), cpId);

			USER_CPVO userCpvo = new USER_CPVO();
			userCpvo.setUserId(userVO.getUserId());
			userCpvo.setCpId(cpId);

			USER_CPVO result =  webUserCpService.selectUserCpByCpIdUserId(userCpvo);
			resultMap.put("cpNum", result.getCpNum());

			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}		
		*/
		
		if(userVO != null) {
			
			USER_CPVO userCpvo = new USER_CPVO();
			userCpvo.setUserId(userVO.getUserId());
			userCpvo.setCpId(cpId);
			int cnt =  webUserCpService.selectUserCpByCpIdUserIdCnt(userCpvo);
			if(cnt > 0) {
				resultMap.put("result", "duplication");
			} else {
				webUserCpService.cpPublish(userVO.getUserId(), cpId);
				
				USER_CPVO result =  webUserCpService.selectUserCpByCpIdUserId(userCpvo);
				resultMap.put("cpNum", result.getCpNum());
				
				resultMap.put("result", "success");
			}
		} else {
			resultMap.put("result", "fail");
		}
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	// 쿠폰코드 체크
	@RequestMapping("/web/couponCodeCheck.ajax")
	public ModelAndView couponCodeAjax(@RequestParam Map<String, String> params) {
		String cpId = params.get("cpId");
		String code = params.get("code");

		Map<String, Object> resultMap = new HashMap<String, Object>();

		CPVO cpVO = new CPVO();
		cpVO.setCpId(cpId);

		CPVO coupon = ossCouponService.selectByCoupon(cpVO);

		if(code.equals(coupon.getCpCode())) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	// 쿠폰코드 등록
	@RequestMapping("/web/couponCode.do")
	public String couponCode(@ModelAttribute("USER_CPVO") USER_CPVO userCp) {
		// 로그인 정보
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if(userVO != null) {
			if("ALL".equals(userCp.getCpNum())) {
				webUserCpService.cpPublish(userVO.getUserId(), userCp.getCpId());
			} else {
				USER_CPVO userCpVO = new USER_CPVO();
				userCpVO.setCpNum(userCp.getCpNum());
				userCpVO.setUseYn("N");			// null -> "N"

				webUserCpService.updateUserCp(userCpVO);
			}
		}
		return "redirect:/web/mypage/couponList.do";
	}

	/** 설문조사 코드생성*/
	@RequestMapping("/web/mypage/surveryCheck.ajax")
	public ModelAndView surveryCheck() throws Exception {
		// 로그인 정보
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<USER_SURVEYVO> userSurveyVoList =  webMypageService.selectSurveyList();

		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		Calendar time = Calendar.getInstance();
		String curTime = format1.format(time.getTime());

		if(userSurveyVoList.size() > 0) {
			resultMap.put("result", "success");
			resultMap.put("data", userSurveyVoList);
			resultMap.put("userId", userVO.getUserId());

			for(USER_SURVEYVO tempSurveyVO : userSurveyVoList){
				System.out.println(userVO.getUserId() + "|" + tempSurveyVO.getId() + "|" + curTime);
				String encrypted = CrmAes256.encrypt(userVO.getUserId() + "|" + tempSurveyVO.getId() + "|" + curTime );
				tempSurveyVO.setToken(URLEncoder.encode(encrypted, "UTF-8"));
				System.out.println("decrypt");
			}
		} else {
			resultMap.put("result", "fail");
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/**
	 * 설명 : 증빙자료 upload
	 * 파일명 : uploadProveFile
	 * 작성일 : 2022-04-11 오전 10:16
	 * 작성자 : chaewan.jung
	 * @param : [multiRequest]
	 * @return : java.lang.String
	 * @throws Exception
	 */
	@RequestMapping("/web/mypage/uploadRsvFile.ajax")
	public ModelAndView uploadRsvFile(MultipartHttpServletRequest multiRequest, RSVFILEVO rsvFileVO, HttpServletRequest request) throws Exception {

		// 첨부파일 등록
		String strSaveFilePath = EgovProperties.getProperty("MYPAGE.PROVE.SAVEDFILE");
		ossFileUtilService.uploadRsvFile(multiRequest, strSaveFilePath, rsvFileVO);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("Status", "success");
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}

	/**
	 * 설명 : 증빙자료 delete
	 * 파일명 : deleteRsvFile
	 * 작성일 : 2022-04-12 오후 2:05
	 * 작성자 : chaewan.jung
	 * @param : [request]
	 * @return : void
	 * @throws Exception
	 */
	@RequestMapping("/web/mypage/deleteRsvFile.ajax")
	public ModelAndView deleteRsvFile(RSVFILEVO rsvFileVO,  HttpServletResponse response)  throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		ossFileUtilService.deleteRsvFile(rsvFileVO);
		resultMap.put("Status", "success");
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}
}
