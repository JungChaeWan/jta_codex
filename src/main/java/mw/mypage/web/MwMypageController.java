package mw.mypage.web;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ResponseBody;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPPRDTVO;
import oss.coupon.vo.CPVO;
import oss.point.service.OssPointService;
import oss.point.vo.POINTVO;
import web.cs.web.KakaoLogin;
import web.cs.web.NaverLogin;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.codehaus.jackson.JsonNode;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import oss.cmm.service.OssCmmUtil;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.otoinq.service.OssOtoinqService;
import oss.otoinq.vo.OTOINQSVO;
import oss.otoinq.vo.OTOINQVO;
import oss.rsv.service.OssRsvService;
import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.USEEPILCMTVO;
import oss.useepil.vo.USEEPILSVO;
import oss.useepil.vo.USEEPILVO;
import oss.user.service.OssUserService;
import oss.user.vo.REFUNDACCINFVO;
import oss.user.vo.UPDATEUSERVO;
import oss.user.vo.USERVO;
import web.cs.service.WebUserSnsService;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class MwMypageController {
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "webMypageService")
	protected WebMypageService webMypageService;

	@Resource(name = "ossOtoinqService")
	private OssOtoinqService ossOtoinqService;

	@Resource(name = "ossUesepliService")
	private OssUesepliService ossUesepliService;

	@Resource(name = "webOrderService")
	private WebOrderService webOrderService;

	@Resource(name = "ossUserService")
	private OssUserService ossUserService;

	@Resource(name = "webUserCpService")
	private WebUserCpService webUserCpService;
	
	@Resource(name = "ossCorpService")
	private OssCorpService ossCorpService;
	
	@Resource(name="masRsvService")
	private MasRsvService masRsvService;
	
	@Resource(name="ossRsvService")
	private OssRsvService ossRsvService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;
	
	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "webUserSnsService")
	private WebUserSnsService webUserSnsService;

    @Resource(name = "ossCouponService")
    private OssCouponService ossCouponService;

    @Resource(name = "ossCmmService")
    private OssCmmService ossCmmService;

	@Autowired
	private OssPointService ossPointService;

	/**
	 * 메뉴 리스트
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/mypage/mainList.do")
	public String mainList(ModelMap model, HttpServletRequest request) {
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if(userVO != null) {

			//개인별 파트너포인트 조회
			String ssPartnerCode = (String) request.getSession().getAttribute("ssPartnerCode");
			if (!"".equals(ssPartnerCode)) {
				POINTVO pointVO = new POINTVO();
				pointVO.setPartnerCode(ssPartnerCode);
				pointVO.setUserId(userVO.getUserId());
				POINTVO myPoint = ossPointService.selectAblePoint(pointVO);
				model.addAttribute("myPoint", myPoint);
			}

			model.addAttribute("isLogin","Y");
			model.addAttribute("snsDiv", userVO.getSnsDiv());
            model.addAttribute("pwd", userVO.getPwd());
            model.addAttribute("userNm", userVO.getUserNm());
		}
		return "/mw/mypage/mainList";
	}
	
	/**
	 * 할인쿠폰 마이페이지 저장.
	 * @param itr_PRDTVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/mw/mypage/saveInterestProduct.ajax")
	public ModelAndView saveInterestProduct(@ModelAttribute("ITR_PRDTVO") ITR_PRDTVO itr_PRDTVO, ModelMap model) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (EgovUserDetailsHelper.isAuthenticated()) {
			USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
			itr_PRDTVO.setUserId(userVO.getUserId());
		}
		// 중복 체크
		int cnt = webMypageService.selectByItrPrdt(itr_PRDTVO);

		if (cnt == 0) {
			webMypageService.insertItrPrdt(itr_PRDTVO);
		}

		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}
	
	/**
	 * 할인 쿠폰 보관함.
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/mypage/freeCouponList.do")
	public String freeCouponList(ModelMap model) {
		
		String userId = null;
		if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/mw/restSign.do";
			} else 	{
				userId = userVO.getUserId();
			}
    	}
		
		Map<String, Object> resultMap = webMypageService.selectItrFreeProductList(userId);
		
		model.addAttribute("resultList", resultMap.get("resultList"));
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		
		return "/mw/mypage/freeCouponList";
	}
	
	
	/**
	 * 마이페이지 - 1:1문의
	 * 파일명 : otoinqList
	 * 작성일 : 2015. 11. 16. 오후 12:08:52
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/mypage/otoinqList.do")
	public String otoinqList(@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
							ModelMap model) {
				
		//로그인 정보 얻기
		USERVO userVO = null;
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/mw/restSign.do";
			} else 	{
				model.addAttribute("userInfo", userVO);
			}
    	}else{
    		return "redirect:/mw/viewLogin.do?rtnUrl=/mw/mypage/otoinqList.do";
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
		for(OTOINQVO data: resultList){
			//log.info("/web/cmm/useepilList.do 호출:"+data.getSubject());
			
			//내용
			data.setContentsOrg(data.getContents());
			data.setContents(EgovWebUtil.clearXSSMinimum(data.getContents()) );
			data.setContents( data.getContents().replaceAll("\n", "<br/>\n") );
			
			//data.setAnsContentsOrg(data.getAnsContents());
			data.setAnsContents(EgovWebUtil.clearXSSMinimum(data.getAnsContents()) );
			data.setAnsContents( data.getAnsContents().replaceAll("\n", "<br/>\n") );
			
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
	
		return "mw/mypage/otoinqList";
	}
	
	
	/**
	 * 마이페이지 - 이용후기
	 * 파일명 : useepilList
	 * 작성일 : 2015. 11. 16. 오후 12:09:07
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/mypage/useepilList.do")
	public String useepilList(	@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
								ModelMap model) {
		
		//로그인 정보 얻기
		USERVO userVO = null;
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/mw/restSign.do";
			} else 	{
				model.addAttribute("userInfo", userVO);
			}
    	}else{
    		return "redirect:/mw/viewLogin.do?rtnUrl=/mw/mypage/useepilList.do";
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
		for(USEEPILVO data: resultList){
			//log.info("/web/cmm/useepilList.do 호출:"+data.getSubject());
			
			//내용
			data.setContentsOrg(data.getContents());
			data.setContents(EgovWebUtil.clearXSSMinimum(data.getContents()) );
			data.setContents( data.getContents().replaceAll("\n", "<br/>\n") );
			
			//아이디
			String strEmail = data.getEmail();
			if(strEmail.length() < 3){
				strEmail = "***";
			}else{
				strEmail = strEmail.substring(0,3)+"*****";
			}
			data.setEmail(strEmail);
			
			//앞에 표시될꺼 조합
			String strCoCd =  data.getPrdtnum().substring(0, 2);
			if(Constant.ACCOMMODATION.equals(strCoCd)){
				data.setSubjectHeder( data.getCorpNm() );
			}else if(Constant.RENTCAR.equals(strCoCd)){
				data.setSubjectHeder( data.getCorpNm() + "-" + data.getPrdtNm() );
			}else if(Constant.SOCIAL.equals(strCoCd)){
				data.setSubjectHeder( data.getPrdtNm() );
			}
					
			
			//data.setSubjectHeder(subjectHeder);
			
			
			//답글 조합
			List<USEEPILCMTVO> listCmt = new ArrayList<USEEPILCMTVO>(); 
			for(USEEPILCMTVO dataCmt: resultCmtList){
				if( "Y".equals(dataCmt.getPrintYn()) ){
					if( data.getUseEpilNum().equals(dataCmt.getUseEpilNum()) ){
						//log.info("/web/cmm/useepilList.do 호출:"+data.getUseEpilNum()+":"+dataCmt.getUseEpilNum()+":"+dataCmt.getContents());
						
						dataCmt.setContentsOrg(dataCmt.getContents());
						dataCmt.setContents(EgovWebUtil.clearXSSMinimum(dataCmt.getContents()) );
						dataCmt.setContents( dataCmt.getContents().replaceAll("\n", "<br/>\n") );
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
		
	
		return "mw/mypage/useepilList";
	}
	
	
	/**
	 * 마이페이지 > 개인정보수정
	 * 파일명 : viewUpdateUser
	 * 작성일 : 2015. 12. 17. 오후 4:44:47
	 * 작성자 : 신우섭
	 * @param user
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/mypage/viewUpdateUser.do")
	public String viewUpdateUser(@ModelAttribute("UPDATEUSERVO") UPDATEUSERVO user,
								ModelMap model) {
		//로그인 검사
		if(EgovUserDetailsHelper.isAuthenticated()==false) {
			return "redirect:/mw/viewLogin.do?rtnUrl=/mw/mypage/viewUpdateUser.do";
		}
		
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
			return "redirect:/mw/restSign.do";
		} else 	{		
			user.setUserId(userVO.getUserId());
			USERVO resultVO = ossUserService.selectByUser(user);
			
			model.addAttribute("user", resultVO);
	    	return "/mw/mypage/updateUser";
		}
	}
	
	
	/**
	 * 개인정보 수정
	 * 파일명 : updateUser
	 * 작성일 : 2015. 12. 17. 오후 4:45:09
	 * 작성자 : 신우섭
	 * @param user
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping("/mw/mypage/updateUser.do")
	public String updateUser(@ModelAttribute("UPDATEUSERVO") UPDATEUSERVO user,
							 RedirectAttributes redirectAttributes) {
		
		try {
			ossUserService.updateUser(user);
			redirectAttributes.addFlashAttribute("resultCd", "Y");
		} catch (NullPointerException e) {
			log.error(e.getMessage());
			redirectAttributes.addFlashAttribute("resultCd", "N");
		}
		return "redirect:/mw/mypage/viewUpdateUser.do";
	}
	
	/**
	 * 패스워드 변경
	 * 파일명 : viewChangePw
	 * 작성일 : 2015. 12. 17. 오후 7:53:34
	 * 작성자 : 신우섭
	 * @param user
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/mypage/viewChangePw.do")
	public String viewChangePw(@ModelAttribute("UPDATEUSERVO") UPDATEUSERVO user,
			ModelMap model){
		
		//로그인 검사
		if(EgovUserDetailsHelper.isAuthenticated()==false){
			return "redirect:/mw/viewLogin.do?rtnUrl=/mw/mypage/viewChangePw.do";
		}
		
		return "/mw/mypage/changePw";
	}
	
	/*
	//Ajax로 호출 하니까. /web/mypage/changePw.ajax 직접 호출
	@RequestMapping("/mw/mypage/changePw.ajax")
	public ModelAndView changePw(@ModelAttribute("USERVO") USERVO user,
			ModelMap model) throws Exception{
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		user.setEmail(userVO.getEmail());
		user.setUserId(userVO.getUserId());
		// 1. 패스워드 일치 여부 확인
    	USERVO resultVO = ossUserService.isEqualPw(user);
    	
    	if(resultVO == null){
    		resultMap.put("rtnVal", "1");
    	}else{
    		ossUserService.updatePwd(user);
    		resultMap.put("rtnVal", "0");
    	}
    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		
		return modelAndView;
	}
	*/
	
	/**
	 * 회원탈퇴
	 * 파일명 : viewDropUser
	 * 작성일 : 2015. 12. 17. 오후 10:13:27
	 * 작성자 : 신우섭
	 * @param user
	 * @return
	 */
	@RequestMapping("/mw/mypage/viewDropUser.do")
	public String viewDropUser(@ModelAttribute("UPDATEUSERVO") UPDATEUSERVO user,
                               ModelMap model) {

        USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
        user.setUserId(userVO.getUserId());
        USERVO resultVO = ossUserService.selectByUser(user);

        model.addAttribute("user", resultVO);

		return "/mw/mypage/dropUser";
	}
	
	@RequestMapping("/mw/mypage/changePwComplet.do")
	public String changePwComplet(@ModelAttribute("UPDATEUSERVO") UPDATEUSERVO user) {

		return "/mw/mypage/changePwComplet";
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
	@RequestMapping("/mw/mypage/rsvList.do")
	public String rsvList(@ModelAttribute("RSV_HISSVO") RSV_HISSVO rsvHisSVO,
						  ModelMap model) {

		//로그인 검사
		if(EgovUserDetailsHelper.isAuthenticated() == false){
			if(EgovUserDetailsHelper.isAuthenticatedGuest() == false){
				return "redirect:/mw/viewLogin.do?rtnUrl=/mw/mypage/rsvList.do";
			}
		}
		if(EgovStringUtil.isEmpty(rsvHisSVO.getAutoCancelYn())){
			rsvHisSVO.setAutoCancelYn("N");
		}
		// 대기시간
		rsvHisSVO.setWaitingTime(Constant.WAITING_TIME);

		//기본 날짜 설정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate today = LocalDate.now();
		LocalDate monthsAgo = today.minusMonths(3);
		if (rsvHisSVO.getsFromDt() == null) {
			rsvHisSVO.setsFromDt(monthsAgo.format(formatter));
			rsvHisSVO.setsToDt(today.format(formatter));
		}

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if(userVO != null && !"".equals(userVO.getUserId()) ){
			//회원 로그인인 경우
			if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/mw/restSign.do";
			} else 	{
				rsvHisSVO.setUserId(userVO.getUserId());

				// 예약 상품 리스트
		     	List<ORDERVO> orderList = webOrderService.selectOrderList2(rsvHisSVO);
		     	model.addAttribute("orderList", orderList);
			}
		} else {
			//비회원 로그인인 경우
			userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();

			rsvHisSVO.setUserId(Constant.RSV_GUSET_NAME);//비회원의 경우 ID가 공백
			rsvHisSVO.setRsvNm(userVO.getUserNm().trim());
			rsvHisSVO.setRsvTelnum(userVO.getTelNum());

			// 예약 상품 리스트
	     	List<ORDERVO> orderList = webOrderService.selectOrderList2Guest(rsvHisSVO);

	     	model.addAttribute("orderList", orderList);

		}
		// 이벤트를 위한 예약 상품 카테고리 갯수 (2017-03-28, By JDongS)
		/*model.addAttribute("rsvPrdtNum", webMypageService.selectRsvCategoryNum(userVO));*/
		model.addAttribute("CST_PLATFORM", EgovProperties.getOptionalProp("CST_PLATFORM"));
		model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
		model.addAttribute("userEmail", userVO.getEmail());

		return "/mw/mypage/rsvList";
	}

	/**
	 * 설명 : 예약 내역 - 더보기
	 * 파일명 : rsvListLoadMore
	 * 작성일 : 25. 1. 7. 오후 5:08
	 * 작성자 : chaewan.jung
	 * @param : [rsvVO]
	 * @return : java.util.List<web.order.vo.ORDERVO>
	 * @throws Exception
	 */
	@RequestMapping(value = "/mw/mypage/rsvListLoadMore.ajax")
	@ResponseBody
	public List<ORDERVO> rsvListLoadMore(@ModelAttribute("RSV_HISSVO") RSV_HISSVO rsvHisSVO) {

		// 로그인 검사
		if (!EgovUserDetailsHelper.isAuthenticated() && !EgovUserDetailsHelper.isAuthenticatedGuest()) {
			return Collections.emptyList(); // 인증되지 않은 경우 빈 리스트 반환
		}

		if (EgovStringUtil.isEmpty(rsvHisSVO.getAutoCancelYn())) {
			rsvHisSVO.setAutoCancelYn("N");
		}

		// 대기시간 설정
		rsvHisSVO.setWaitingTime(Constant.WAITING_TIME);

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		List<ORDERVO> orderList;

		if (userVO != null && !"".equals(userVO.getUserId())) {
			// 회원 로그인 처리
			if ("Y".equals(userVO.getRestYn())) {
				return Collections.emptyList(); // 휴면 계정은 빈 리스트 반환
			}
			rsvHisSVO.setUserId(userVO.getUserId());
			orderList = webOrderService.selectOrderList2(rsvHisSVO);
		} else {
			// 비회원 로그인 처리
			userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();
			rsvHisSVO.setUserId(Constant.RSV_GUSET_NAME);
			rsvHisSVO.setRsvNm(userVO.getUserNm().trim());
			rsvHisSVO.setRsvTelnum(userVO.getTelNum());
			orderList = webOrderService.selectOrderList2Guest(rsvHisSVO);
		}

		return orderList; // JSON 형식으로 반환
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
	@RequestMapping("/mw/mypage/detailRsv.do")
	public String detailRsv(@ModelAttribute("RSVVO") RSVVO rsvVO,
							ModelMap model) throws ParseException {
		Boolean isUser = EgovUserDetailsHelper.isAuthenticated();
		Boolean isGuest = EgovUserDetailsHelper.isAuthenticatedGuest();
		/** 환불계좌관리 레코드 유무 (비회원은 모두 Y처리) */
		REFUNDACCINFVO refundAccInf = new REFUNDACCINFVO();

		if(isUser == false){
			if(isGuest == false){
				return "redirect:/mw/viewLogin.do?rtnUrl=/mw/mypage/rsvList.do";
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
			return "redirect:/mw/mypage/rsvList.do";
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
		
		Map<String, List<SP_RSVHISTVO>> spRsvHistMap = new HashMap<String, List<SP_RSVHISTVO>>();
		
		String orderDiv = null;

		for(ORDERVO order : orderList) {
			if(Constant.SP_PRDT_DIV_TOUR.equals(order.getPrdtDiv()) || Constant.SP_PRDT_DIV_COUP.equals(order.getPrdtDiv())) {
				SP_RSVVO spRsvVO = new SP_RSVVO();
				spRsvVO.setSpRsvNum(order.getPrdtRsvNum());

				List<SP_RSVHISTVO> spRsvhistList = masRsvService.selectSpRsvHistList(spRsvVO);
				
				spRsvHistMap.put(order.getPrdtRsvNum(), spRsvhistList);
			}
			if(Constant.SV.equals(order.getPrdtNum().substring(0,2).toUpperCase())) {
				orderDiv = Constant.SV;
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
		model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
		return "/mw/mypage/detailRsv";
	}
	
	/**
	 * 탐라오쿠폰 목록
	 * 파일명 : couponList
	 * 작성일 : 2015. 12. 18. 오전 11:16:49
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/mypage/couponList.do")
	public String couponList(ModelMap model) {
		//로그인 검사
		if(!EgovUserDetailsHelper.isAuthenticated()) {
			return "redirect:/mw/viewLogin.do?rtnUrl=/mw/mypage/couponList.do";
		}
        USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

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
					product += "<p>" + "[" + cpPrdt.getCorpNm() + "]";
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
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	model.addAttribute("today", sdf.format(Calendar.getInstance().getTime()));
		
		return "mw/mypage/couponList";
	}
	
	@RequestMapping("/mw/mypage/spUseAppr.ajax")
    public ModelAndView spUseAppr(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		@ModelAttribute("SPRSVVO") SP_RSVVO spRsvVO,
    		@Param("prdtRsvNum") String prdtRsvNum,
    		@Param("usePwd") String usePwd, 
    		ModelMap model) throws ParseException {
    	log.info("/mw/mypage/spUseAppr.ajax call");
    	
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	spRsvVO.setSpRsvNum(prdtRsvNum);
    	// 쿠폰상품일 경우 구매시간 - 이용시간 / 유효일 체크해서 처리.
    	SP_RSVVO resultVO = masRsvService.selectSpDetailRsv(spRsvVO);
    	CORPVO corpSVO = new CORPVO();
    	corpSVO.setCorpId(resultVO.getCorpId());
    	CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
    	log.info(" rsvTelNum " + corpVO.getRsvTelNum().substring(corpVO.getRsvTelNum().length() - 4));
    	
    	
    	String pwd = corpVO.getRsvTelNum().substring(corpVO.getRsvTelNum().length() - 4);
    	if(!StringUtils.equals(usePwd, pwd)) {
    		resultMap.put("password", Constant.FLAG_Y);
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}
    	
    	String now = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());

    	if(now.compareTo(resultVO.getExprStartDt()) < 0 || now.compareTo(resultVO.getExprEndDt()) > 0 ) {
    		resultMap.put("exprOut", Constant.FLAG_Y);
    		resultMap.put("exprStartDt", resultVO.getExprStartDt());
    		resultMap.put("exprEndDt", resultVO.getExprEndDt());
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}
    	
    	now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
    	if(StringUtils.isNotEmpty(resultVO.getUseAbleDttm()) && now.compareTo(resultVO.getUseAbleDttm()) < 0) {
    		resultMap.put("useAbleOut", Constant.FLAG_Y);
    		resultMap.put("useAbleDttm", resultVO.getUseAbleDttm());
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}
    	
    	// 사용완료.
    	spRsvVO.setUseNum(resultVO.getBuyNum());
    	spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_UCOM);
    	spRsvVO.setCorpId(resultVO.getCorpId());
    	masRsvService.updateSpUseDttm(spRsvVO);
    	
    	resultMap.put("success", Constant.JSON_SUCCESS);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
	
	/*@RequestMapping("/mw/viewUseAppr.do")
    public String smsView(@Param("prdtRsvNum") String prdtRsvNum, ModelMap model) throws ParseException {
    	log.info("/mw/viewUseAppr.do call");
    	
    	ORDERVO orderVO = new ORDERVO();
    	orderVO.setPrdtRsvNum(prdtRsvNum);
    	ORDERVO resultVO = webOrderService.selectUserRsvFromPrdtRsvNum(orderVO);
    	
    	model.addAttribute("resultVO", resultVO);
    	return "mw/mypage/useAppr";
    }*/
	
	
	@RequestMapping("/mw/mypage/validateUseAbleDttm.ajax")
    public ModelAndView validateUseAbleDttm(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		@ModelAttribute("SPRSVVO") SP_RSVVO spRsvVO,
    		@Param("prdtRsvNum") String prdtRsvNum,
    		ModelMap model) throws ParseException {
    	log.info("/mw/mypage/spUseAppr.ajax call");
    	
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	spRsvVO.setSpRsvNum(prdtRsvNum);
    	// 쿠폰상품일 경우 구매시간 - 이용시간 / 유효일 체크해서 처리.
    	SP_RSVVO resultVO = masRsvService.selectSpDetailRsv(spRsvVO);
    	
    	String now = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());

    	if(now.compareTo(resultVO.getExprStartDt()) < 0 || now.compareTo(resultVO.getExprEndDt()) > 0 ) {
    		resultMap.put("exprOut", Constant.FLAG_Y);
    		resultMap.put("exprStartDt", resultVO.getExprStartDt());
    		resultMap.put("exprEndDt", resultVO.getExprEndDt());
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}
    	
    	now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
    	if(StringUtils.isNotEmpty(resultVO.getUseAbleDttm()) && now.compareTo(resultVO.getUseAbleDttm()) < 0) {
    		resultMap.put("useAbleOut", Constant.FLAG_Y);
    		resultMap.put("useAbleDttm", resultVO.getUseAbleDttm());
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}
    	
    	resultMap.put("success", Constant.JSON_SUCCESS);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
	
	@RequestMapping("/mw/mypage/otoinqUpdateView.do")
    public String otoinqUpdateView(	@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
		log.info("/mw/mypage/otoinqUpdateView.do 호출");
		
		OTOINQVO otoinqRes = ossOtoinqService.selectByOtoinq(otoinqVO);
		
		model.addAttribute("otoinq", otoinqRes);
		
		return "mw/mypage/otoinqUpdate";
    
	}
	
	@RequestMapping("/mw/mypage/otoinqUpdate.do")
    public String otoinqUpdate(	@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	//log.info("/mw/cmm/otoinqUpdate.do 호출");
    	
    	//otoinqVO.setWriter("U000000004");
    	//otoinqVO.setEmail("arisa@naver.com");
    	//otoinqVO.setLastModIp("127.0.0.1");
    	
    	//로그인 정보 얻기
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/mw/restSign.do";
			} else 	{
	    		//model.addAttribute("userInfo", userVO);
	    		otoinqVO.setWriter(userVO.getUserId());
	    		otoinqVO.setEmail(userVO.getEmail());
	    		//otoinqVO.setFrstRegIp(userVO.getLastLoginIp());
	    		
	    		if((userVO.getLastLoginIp() == null) || (userVO.getLastLoginIp() == "")) {
	    			otoinqVO.setLastModIp(EgovClntInfo.getClntIP(request));
	    		} else {
	    			otoinqVO.setLastModIp(userVO.getLastLoginIp());
	    		}
			}
    	}else{
    		return "redirect:/mw/mypage/otoinqList.do?pageIndex="+otoinqSVO.getPageIndex();
    	}

    	ossOtoinqService.updateOtoinq(otoinqVO);

    	return "redirect:/mw/mypage/otoinqList.do?pageIndex="+otoinqSVO.getPageIndex();    	    	
    }
	
	@RequestMapping("/mw/mypage/otoinqDelete.do")
    public String otoinqDelete(	@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							HttpServletRequest request, 
								HttpServletResponse response,
    		   					ModelMap model)  throws Exception{
    	log.info("/web/mypage/otoinqDelete.do 호출");
    	
    	ossOtoinqService.deleteOtoinqByOtoinqNum(otoinqVO);
    	    	
    	return "redirect:/mw/mypage/otoinqList.do?pageIndex="+otoinqSVO.getPageIndex();
    }
	
	/**
	 * 환불 계좌 관리
	 * 파일명 : viewRefundAccNum
	 * 작성일 : 2016. 1. 28. 오후 2:36:04
	 * 작성자 : 최영철
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/mypage/viewRefundAccNum.do")
	public String viewRefundAccNum(ModelMap model){
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
			return "redirect:/mw/restSign.do";
		} else 	{
			ORDERSVO orderSVO = new ORDERSVO();
			orderSVO.setsUserId(userVO.getUserId());
			
			REFUNDACCINFVO refundAccInf = ossRsvService.selectByRefundAccInf(orderSVO);
			model.addAttribute("refundAccInf", refundAccInf);

			List<CDVO> cdRfac = ossCmmService.selectCode("RFAC");
			model.addAttribute("cdRfac", cdRfac);
			
			return "mw/mypage/refundAccNum";
		}
	}
	

	/**
	 * 찜한 상품 리스트
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/mypage/pocketList.do")
	public String pocketList(ModelMap model){
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
			return "redirect:/mw/restSign.do";
		}
		
		List<POCKETVO> pocketList = webMypageService.selectPocketList(userVO.getUserId());
		
		for(POCKETVO pocket : pocketList) {
			if(Constant.ACCOMMODATION.equals(pocket.getPrdtDiv())) {
				ADTOTALPRICEVO adTotPrice = new ADTOTALPRICEVO();
				adTotPrice.setPrdtNum(pocket.getPrdtNum());
				
				if(pocket.getAdUseDt() == null){
		    		//초기 날짜 지정
		    		Calendar calNow = Calendar.getInstance();

		    		adTotPrice.setsFromDt( String.format("%d%02d%02d",
											calNow.get(Calendar.YEAR),
											calNow.get(Calendar.MONTH) + 1,
											calNow.get(Calendar.DAY_OF_MONTH)  )
										);
				}
			//	adTotPrice.setsFromDt( pocket.getAdUseDt());
				adTotPrice.setiNight( 1 );
				adTotPrice.setiMenAdult( 2 );
				adTotPrice.setiMenJunior( 0 );
				adTotPrice.setiMenChild( 0 );
				int nPrice = webAdProductService.getTotalPrice(  adTotPrice );
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
				
				if(prdtSVO.getsFromDt() == null){
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
				
				// 단건에 대한 렌터카 정보 조회
		    	List<RC_PRDTINFVO> resultList = webRcProductService.selectRcPrdtList2(prdtSVO);
		    	RC_PRDTINFVO prdtInfo = resultList.get(0);
		    	
		    	pocket.setPrdtAmt(prdtInfo.getSaleAmt());
		    	pocket.setRsvAbleYn(prdtInfo.getAbleYn());
			}
		}
		model.addAttribute("pocketList", pocketList);
		return "/mw/mypage/pocketList";
		
	}
	
	/**
	 * 배송추적
	 * @param rsvNum
	 * @return
	 */
	@RequestMapping("/mw/dlvTrace.ajax")
	public ModelAndView dlvTrace(@RequestParam(value="rsvNum") String rsvNum) {
		
		DLVCORPVO dlvCorpVO =  webMypageService.dlvTrace(rsvNum);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("url", dlvCorpVO.getMobileUrl());
		
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
	@RequestMapping("/mw/mypage/insertEventReceive.ajax")
	public ModelAndView insertEventReceive(@RequestParam(value="receiveAdminPw") String receiveAdminPw) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 입력한 비번이 동일 하면.. (WebMypageController 확인)
		if ("8861".equals(receiveAdminPw)) {
			USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			if(userVO == null){			
				//비회원 로그인인 경우
				userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();				
			}
			
			// 이벤트 상품 수령 여부 체크
			if (webMypageService.selectEvntPrdtRcvNum(userVO) == false) {
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
    @RequestMapping("/mw/naverUnlink.do")
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

        return "redirect:/mw/deleteUserSns.do";
    }

	// 카카오 로그인 연동 해제
    @RequestMapping("/mw/kakaoUnlink.do")
    public String kakaoUnlink(@ModelAttribute("UPDATEUSERVO") USERVO user,
                              HttpServletRequest request) {
        USERVO userSns = webUserSnsService.selectUserSns(user);

        JsonNode unlink = KakaoLogin.getKakaoUnlink(userSns.getLoginKey());
        log.info("kakao unlink", unlink.get("id").asText());

        FlashMap fm = RequestContextUtils.getOutputFlashMap(request);
        fm.put("userInfo", user);

        return "redirect:/mw/deleteUserSns.do";
    }

    //간편 로그인 DB 삭제
	@RequestMapping("/mw/deleteUserSns.do")
	public String deleteUserSns(HttpServletRequest request) {
	    USERVO user = null;

        Map<String, ?> snsMap = RequestContextUtils.getInputFlashMap(request);
        if(snsMap != null) {
            user = (USERVO) snsMap.get("userInfo");
        }
		if(user != null) {
			webUserSnsService.deleteUserSns(user);
		}
		return "redirect:/mw/mypage/viewUpdateUser.do";
	}

    // 쿠폰받기
	@RequestMapping("/mw/couponDownload.ajax")
	public ModelAndView couponDownloadAjax(@RequestParam(value="cpId") String cpId) {
		
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
	@RequestMapping("/mw/couponCodeCheck.ajax")
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
	@RequestMapping("/mw/couponCode.do")
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
		return "redirect:/mw/mypage/couponList.do";
	}
}