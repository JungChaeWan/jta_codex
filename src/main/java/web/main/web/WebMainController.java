package web.main.web;


import api.service.APIService;
import api.vo.ApiNextezPrcAdd;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import mas.prmt.service.MasPrmtService;
import mas.prmt.vo.MAINPRMTVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.sp.vo.SP_OPTINFVO;
import net.sf.ehcache.Cache;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.ad.vo.AD_WEBDTLVO;
import oss.ad.vo.AD_WEBLISTSVO;
import oss.ad.vo.AD_WEBLISTVO;
import oss.benner.service.OssBannerService;
import oss.benner.vo.BANNERVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_SRCHWORDVO;
import oss.corp.service.OssCorpService;
import oss.coupon.service.OssCouponService;
import oss.marketing.serive.OssAdmRcmdService;
import oss.marketing.serive.OssKwaService;
import oss.marketing.vo.KWASVO;
import oss.marketing.vo.KWAVO;
import oss.point.service.OssPointService;
import oss.point.vo.POINT_CPVO;
import oss.site.vo.MAINCTGRRCMDVO;
import oss.site.vo.MAINHOTPRDTVO;
import oss.user.vo.USERVO;
import web.bbs.service.WebBbsService;
import web.cs.service.WebKmaService;
import web.main.service.WebMainService;
import web.main.vo.MAINPRDTSVO;
import web.main.vo.MAINPRDTVO;
import web.main.vo.SEOVO;
import web.mypage.service.WebMypageService;
import web.order.service.WebCartService;
import web.order.service.WebOrderService;
import web.order.vo.RSVVO;
import web.product.service.WebAdProductService;
import web.product.service.WebPrdtInqService;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;
import web.product.vo.*;

import javax.annotation.Resource;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.*;

/**
 * @author 최영철
 * @since  2015. 9. 16.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@Controller
public class WebMainController {

    @Autowired
    private DefaultBeanValidator beanValidator;

    @Resource(name = "ossCmmService")
    private OssCmmService ossCmmService;

    @Resource(name = "ossCorpService")
    private OssCorpService ossCorpService;

    @Resource(name = "webMainService")
    private WebMainService webMainService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name="webBbsService")
    private WebBbsService webBbsService;

	@Resource(name = "masPrmtService")
	private MasPrmtService masPrmtService;

	@Resource(name = "webSpService")
	private WebSpProductService webSpService;

	@Resource(name = "webAdProductService")
	private WebAdProductService webAdProductService;

	@Resource(name = "webPrdtInqService")
	protected WebPrdtInqService webPrdtInqService;

	@Resource(name = "webKmaService")
	protected WebKmaService webKmaService;

	@Resource(name="ossBannerService")
	private OssBannerService ossBannerService;

	@Resource(name="ossKwaService")
	private OssKwaService ossKwaService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;
	
	@Resource(name = "OssAdmRcmdService")
	protected OssAdmRcmdService ossAdmRcmdService;
	
	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;
	
	@Resource(name = "webCartService")
	private WebCartService webCartService;

	@Resource(name = "webOrderService")
	private WebOrderService webOrderService;

	@Resource(name = "ossCouponService")
	protected OssCouponService ossCouponService;

	@Resource(name="apiService")
	private APIService apiService;

	@Resource(name="ossPointService")
	private OssPointService ossPointService;

	@Autowired
	private net.sf.ehcache.CacheManager nativeEhCacheManager;

    Logger log = (Logger) LogManager.getLogger(this.getClass());

    
    @RequestMapping("/main_new.do")
    public void mainNew(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	response.setStatus(301);
		response.setHeader("Location", request.getContextPath()+"/web/rentcar/jeju.do");
		response.setHeader("Connection","close");
    }

    @RequestMapping("/main.do")
    public String webMain2(@ModelAttribute("rcSearchVO") RC_PRDTINFSVO rcPrdtSVO,
                           @ModelAttribute("adSearchVO") AD_WEBLISTSVO adPrdtSVO,
                           @RequestParam Map<String, String> params,
                           ModelMap model,
                           HttpServletRequest request, HttpServletResponse response) throws Exception {

    	if(EgovClntInfo.isMobile(request)) {
			return "forward:/mw/main.do";
		}
		
		/** 메인 프로모션*/
		MAINPRMTVO mainPrmtVO = new MAINPRMTVO();
		List<MAINPRMTVO> mainPrmtList = masPrmtService.selectMainPrmtMain(mainPrmtVO);
		model.addAttribute("prmtList", mainPrmtList);

		/** 날짜선택*/
		Calendar calNow = Calendar.getInstance();
		model.addAttribute("SVR_TODAY", EgovStringUtil.getDateFormatDash(calNow));
		/** 숙소시작일 기본선택*/
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		adPrdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
		adPrdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
		/** 숙소퇴실일_기본선택*/
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		adPrdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
		adPrdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
		/** 렌터카_대여시작일*/
		calNow = Calendar.getInstance();
		calNow.add(Calendar.DAY_OF_MONTH, 1);
    	rcPrdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
    	rcPrdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
    	rcPrdtSVO.setsFromTm("1200");
		/** 렌터카_대여종료일*/
    	calNow.add(Calendar.DAY_OF_MONTH, 1);
    	rcPrdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
    	rcPrdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
    	rcPrdtSVO.setsToTm("1200");
    	/** 항공_가는날 오는날*/
		calNow = Calendar.getInstance();

		model.addAttribute("START_DATE", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		calNow.add(Calendar.DAY_OF_MONTH, 3);
		model.addAttribute("END_DATE", String.format("%d-%02d-%02d",calNow.get(Calendar.YEAR),calNow.get(Calendar.MONTH) + 1,calNow.get(Calendar.DAY_OF_MONTH)));

    	/** 추가기능:: 하단배너 */
    	BANNERVO bannerVO = new BANNERVO();
    	bannerVO.setLocation("BN02");

    	List<BANNERVO> bannerListBottom = ossBannerService.selectBannerListWeb(bannerVO);
    	model.addAttribute("bannerListBottom", bannerListBottom);

		// 이벤트 팝업
		bannerVO.setLocation("BN05");
		List<BANNERVO> eventPopup = ossBannerService.selectBannerListWebByPrintSn(bannerVO);
		model.addAttribute("eventPopup", eventPopup);

    	return "/web/main";
    }

	/** 해시태그 */
	@RequestMapping("/web/getHashTag.ajax")
	public ModelAndView getHashTag(@ModelAttribute("KWASVO") KWASVO kwaSVO) {
		/** 해시태그 */
		List<KWAVO> kwaList = ossKwaService.selectKwaWebPrdtList(kwaSVO);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", kwaList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

    /** 메인 카테고리 추천 상품 */
	@RequestMapping("/web/getMainCategoryRecommend.ajax")
	public ModelAndView getMainCategoryRecommend(@RequestParam("prdtDiv") String prdtDiv) {
		log.info("/web/getMainCategoryRecommend.ajax call");
		Map<String, Object> resultMap = new HashMap<String, Object>();

		MAINCTGRRCMDVO mainctgrrcmdVO = new MAINCTGRRCMDVO();
		mainctgrrcmdVO.setPrdtDiv(prdtDiv);

		List<MAINCTGRRCMDVO> mainCtgrRcmdList = webMainService.selectMainCtgrRcmdList(mainctgrrcmdVO);

		if(mainCtgrRcmdList.size() < 10) {
			List<MAINPRDTVO> prdtList;

			MAINPRDTSVO mainSVO = new MAINPRDTSVO();
			mainSVO.setsNum("10");
			mainSVO.setsCtgr(prdtDiv);

			if(Constant.ACCOMMODATION.equals(prdtDiv)) {
				prdtList = webMainService.selectMain11(mainSVO);
			} else if(Constant.RENTCAR.equals(prdtDiv)) {
				prdtList = webMainService.selectMain10(mainSVO);
			} else if(Constant.SV.equals(prdtDiv)) {
				prdtList = webMainService.selectMain21(mainSVO);
			} else {
				prdtList = webMainService.selectMain33(mainSVO);
			}

			if(prdtList != null) {
				for(MAINPRDTVO prdt : prdtList) {
					MAINCTGRRCMDVO mcrVO = new MAINCTGRRCMDVO();
					mcrVO.setPrdtNum(prdt.getPrdtNum());
					mcrVO.setCorpId(prdt.getCorpId());
					mcrVO.setNmlAmt(prdt.getNmlAmt());
					mcrVO.setSaleAmt(prdt.getSaleAmt());
					mcrVO.setEventCnt("0");
					mcrVO.setCouponCnt("0");

					if(Constant.ACCOMMODATION.equals(prdtDiv)) {
						mcrVO.setPrdtNm(prdt.getCorpNm());
						mcrVO.setPrdtExp(prdt.getSimpleExp());
						mcrVO.setEtcExp(prdt.getAdAreaNm());
						mcrVO.setImgPath(prdt.getSavePath() + "thumb/" + prdt.getSaveFileNm());
						mcrVO.setDaypriceYn(prdt.getDaypriceYn());
					} else if(Constant.RENTCAR.equals(prdtDiv)) {
						String prdtNm = prdt.getPrdtNm();
						// 차량명_연료타입 분리
						if(prdtNm.indexOf("/") < 0) {
							mcrVO.setPrdtNm(prdtNm);
						} else {
							mcrVO.setPrdtNm(prdtNm.substring(0, prdtNm.indexOf("/") - 1));
							mcrVO.setPrdtExp(prdtNm.substring(prdtNm.indexOf("/") + 2));
						}
						mcrVO.setEtcExp(prdt.getCorpNm());
						mcrVO.setImgPath(prdt.getSaveFileNm());
					} else {
						mcrVO.setPrdtNm(prdt.getPrdtNm());
						mcrVO.setPrdtExp(prdt.getSimpleExp());
						mcrVO.setEtcExp(prdt.getCorpNm());
						mcrVO.setImgPath(prdt.getSavePath() + "thumb/" + prdt.getSaveFileNm());
					}
					mainCtgrRcmdList.add(mcrVO);

					if(mainCtgrRcmdList.size() == 10) {
						break;
					}
				}
			}
		}
		resultMap.put("result", mainCtgrRcmdList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/** 인기있수다 */
	/*@CrossOrigin*/
	@RequestMapping("/web/getMainHotList.ajax")
	public ModelAndView getMainHotList(ServletResponse res, HttpServletRequest request) {
		HttpServletResponse response = (HttpServletResponse) res;


		/** 인기있수다(지금 제일 잘나가는 상품) */
		List<MAINHOTPRDTVO> mainHotList = webMainService.selectMainHotList();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", mainHotList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		response.setHeader("Access-Control-Allow-Origin", "*"); //허용대상 도메인
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, DELETE, PUT");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with, origin, content-type, accept");
		return mav;
	}

	/** 프로모션(숙박) 상품 */
	@RequestMapping("/web/getPrmtAdList.ajax")
	public ModelAndView getPrmtAdList() {
		/** 숙박프로모션상품 */
		List<AD_WEBLISTVO> prmtAdList = webAdProductService.selectAdBestList();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", prmtAdList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}


    @RequestMapping("/web/includeJs.do")
    public String includeJs(@ModelAttribute("SEOVO") SEOVO seoVO,
					    		HttpServletRequest request,
								ModelMap model){

    	String strKeywrd = "";
    	int nKeyLen = 0;

    	//키워드 검색
    	if(!(seoVO.getKeywordsLinkNum()==null || seoVO.getKeywordsLinkNum().isEmpty() || "".equals(seoVO.getKeywordsLinkNum()) ) ){
    		List<CM_SRCHWORDVO> srchWordList = ossCmmService.selectSrchWordList(seoVO.getKeywordsLinkNum());

    		for (CM_SRCHWORDVO data : srchWordList) {
    			strKeywrd += data.getSrchWord()+",";
    			nKeyLen++;
			}
    	}

    	//추가 키워드
		if(!(seoVO.getKeywordAdd1()==null || seoVO.getKeywordAdd1().isEmpty() || "".equals(seoVO.getKeywordAdd1()) )){
			strKeywrd += seoVO.getKeywordAdd1()+",";
			nKeyLen++;
		}
		if(!(seoVO.getKeywordAdd2()==null || seoVO.getKeywordAdd2().isEmpty() || "".equals(seoVO.getKeywordAdd2()) )){
			strKeywrd += seoVO.getKeywordAdd2()+",";
			nKeyLen++;
		}
		if(!(seoVO.getKeywordAdd3()==null || seoVO.getKeywordAdd3().isEmpty() || "".equals(seoVO.getKeywordAdd3()) )){
			strKeywrd += seoVO.getKeywordAdd3()+",";
			nKeyLen++;
		}
		if(!(seoVO.getKeywordAdd4()==null || seoVO.getKeywordAdd4().isEmpty() || "".equals(seoVO.getKeywordAdd4()) )){
			strKeywrd += seoVO.getKeywordAdd4()+",";
			nKeyLen++;
		}

		if(nKeyLen > 0){
			strKeywrd = strKeywrd.substring(0, strKeywrd.length()-1);//끝에 ',' 지우기

			seoVO.setKeywords(strKeywrd);
		}





    	//이미지패스
    	if(!(seoVO.getImagePath()==null || seoVO.getImagePath().isEmpty() || "".equals(seoVO.getImagePath()) ) ){
    		String serverName = request.getScheme() + "://" + request.getServerName();
    		serverName += (request.getServerPort()==80?"":":"+request.getServerPort());

    		seoVO.setImage(serverName+seoVO.getImagePath());
    	}




    	//log.info("===============getTitle:"+seoVO.getTitle());

    	model.addAttribute("seo", seoVO);

    	return "/web/includeJs";
    }

	@RequestMapping("/web/head.do")
    public String webHead(	@RequestParam Map<String, String> params,
				    		HttpServletRequest request,
				    		HttpServletResponse response,
    						ModelMap model) throws UnsupportedEncodingException {


		if(StringUtils.isEmpty((String)request.getSession().getAttribute("partner")) && StringUtils.isNotEmpty(params.get("partner"))) {
			request.getSession().setAttribute("partner", params.get("partner"));
			USERVO userVO = new USERVO();
			userVO.setPartnerCd((String) request.getSession().getAttribute("partner"));
			webMainService.updateTamnaoPartnerAccessCnt(userVO);
		}else if("visitjeju".equals((String)request.getSession().getAttribute("partner"))){
			/** 파트서관리 비짓제주 예외처리*/
				model.addAttribute("partner", "visitjeju");
		}

		/** 쿠폰 파트너 세션 생성*/
		HttpSession cpSession = request.getSession();
		String pPartnerCode = request.getParameter("partnerCode");
		Object ssPartnerCode = "";

		if (pPartnerCode == null) {
			if (cpSession.getAttribute("ssPartnerCode") != null) {
				ssPartnerCode = cpSession.getAttribute("ssPartnerCode");
			}
		} else{
			ssPartnerCode = pPartnerCode;
		}
		cpSession.setAttribute("ssPartnerCode", ssPartnerCode);

		//로고 셋팅
		String logoUrl = "/images/web/r_main/nao_logo2.png";
		if (!("".equals(ssPartnerCode) || ssPartnerCode == null)) {
			POINT_CPVO pointCpVO =  ossPointService.selectPointCpDetail((String)ssPartnerCode);
			if (pointCpVO != null) {
				logoUrl = EgovProperties.getProperty("COUPON.SAVEDFILE") + pointCpVO.getPartnerLogow();
			}
		}
		model.addAttribute("logoUrl", logoUrl);

		String strIsLogin = "N";
		USERVO userVO;
		RSVVO rsvVO = new RSVVO();
		rsvVO.setWaitingTime(Constant.WAITING_TIME);

		List<RSVVO> unpaidRsvList = new ArrayList<RSVVO>();
		// 회원 로그인
		if(EgovUserDetailsHelper.isAuthenticated()) {
			strIsLogin = "Y";
			// 미결제 조회
			userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
			rsvVO.setUserId(userVO.getUserId());

			unpaidRsvList = webOrderService.selectUnpaidRsvList(rsvVO);
			model.addAttribute("userNm", userVO.getUserNm());
		} else {
			// 비회원 로그인
			if(EgovUserDetailsHelper.isAuthenticatedGuest()) {
				strIsLogin = "G";
				// 미결제 조회
				userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();
				rsvVO.setUserId(Constant.RSV_GUSET_NAME);//비회원의 경우 ID가 공백
				rsvVO.setRsvNm(userVO.getUserNm().trim());
				rsvVO.setRsvTelnum(userVO.getTelNum());

				unpaidRsvList = webOrderService.selectUnpaidRsvList(rsvVO);
			}
		}
		String unpaidRsvNum = "";
		if(unpaidRsvList.size() > 0) {
			unpaidRsvNum = unpaidRsvList.get(0).getRsvNum();
		}
		model.addAttribute("unpaidRsvNum", unpaidRsvNum);

		model.addAttribute("isLogin", strIsLogin);
    	model.addAttribute("menuNm", params.get("menu"));
    	model.addAttribute("search", params.get("search"));

    	//추가기능:: 상단배너
    	BANNERVO bannerVO = new BANNERVO();
    	bannerVO.setLocation("BN01");
    	List<BANNERVO> bannerListTop = ossBannerService.selectBannerListWeb(bannerVO);
    	model.addAttribute("bannerListTop", bannerListTop);
    	
    	/*//추가기능:: 오른쪽 배너
    	bannerVO.setLocation("BN03");
    	List<BANNERVO> bannerListRight = ossBannerService.selectBannerListWeb(bannerVO);
    	model.addAttribute("bannerListRight", bannerListRight);*/

    	//추가기능:: 키워드광고
    	/*KWASVO kwaSVO = new KWASVO();
    	kwaSVO.setSlocation("KW01");
    	kwaSVO.setCnt("3");
    	List<KWAVO> kwaList = ossKwaService.selectKwaWebList(kwaSVO);
    	model.addAttribute("kwaList", kwaList);*/
    	return "/web/head";
    }

    @RequestMapping("/web/left.do")
    public String webLeft(	@RequestParam Map<String, String> params,
				    		ModelMap model){

    	//추가기능:: 왼쪽배너
    	BANNERVO bannerVO = new BANNERVO();
    	bannerVO.setLocation("BN03");
    	List<BANNERVO> bannerList = ossBannerService.selectBannerListWeb(bannerVO);
    	model.addAttribute("bannerListLeft", bannerList);

    	return "/web/left";
    }

	@RequestMapping("/web/introLeft.do")
	public String introLeft(){ return "/web/etc/introLeft"; }

	@RequestMapping("/web/right.do")
    public String webRight(	@RequestParam Map<String, String> params,
    		HttpServletRequest request,
    		HttpServletResponse response,
    		ModelMap model){
    	return "/web/right";
    }

    @RequestMapping("/web/foot.do")
    public String webFoot(	@RequestParam Map<String, String> params,
    		ModelMap model){
    	return "/web/foot";
    }

    @RequestMapping("/web/couponUseCnt.ajax")
    public ModelAndView couponUseCnt(@ModelAttribute("CPSVO") @RequestParam(value="cpIds[]") List<String> cpIds){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	Integer cnt = ossCouponService.couponUseCnt(cpIds);
		resultMap.put("success", "Y");
		resultMap.put("cnt", cnt);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
    }

    /** 이벤트2021 */
	@RequestMapping("/web/event2021AllCnt.ajax")
	public ModelAndView event2021AllCnt(String userId){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Integer cnt = ossCouponService.event2021Cnt(userId);
		resultMap.put("success", "Y");
		resultMap.put("cnt", cnt);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	/** 이벤트2021 */
	@RequestMapping("/web/event2021Donation.ajax")
	public ModelAndView event2021Donation(){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Integer cnt = ossCouponService.event2021Cnt(userVO.getUserId());
		if(cnt > 0){
			/** 기부된 ID*/
			resultMap.put("success", "N");
		}else{
			/** 기부 성공*/
			ossCouponService.event2021Donation(userVO.getUserId());
			resultMap.put("success", "Y");
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

    @RequestMapping("/web/logout.do")
	public String logout(HttpServletRequest request) throws Exception{
    	/*
		request.getSession().setAttribute("loginVO", null);
		request.getSession().setAttribute("guestLoginVO", null);
		request.getSession().setAttribute("cartList", null);
		*/
    	HttpSession session = request.getSession(false);
        if(session != null) {
            session.invalidate();
        }
		 
		return "redirect:/main.do";
	}

	@RequestMapping("/web/addCart.ajax")
    public ModelAndView addCart(@RequestBody CARTLISTVO cartListVO,
								HttpServletRequest request) {
    	log.info("/web/addCart.ajax call");

		List<CARTVO> cartList = cartListVO.getCartList();

    	List<CARTVO> sessionCartList = new ArrayList<CARTVO>();
		Integer cartSn = 1;

    	if(request.getSession().getAttribute("cartList") != null){
    		sessionCartList = (List<CARTVO>) request.getSession().getAttribute("cartList");

    		Integer maxCartSn = 0;
    		for(CARTVO cart:sessionCartList) {
				if(cart.getCartSn() > maxCartSn) {
					maxCartSn = cart.getCartSn();
				}
    		}
    		cartSn = maxCartSn + 1;
		}

    	for(CARTVO cart : cartList) {
    		String prdtNum = cart.getPrdtNum();
			String divSn = "";
			String optSn = "";
			String category = prdtNum.substring(0, 2).toUpperCase();

			// 중복 상품 제거
			/*for(CARTVO sessionCart : sessionCartList) {
				String sessionPrdtNum = sessionCart.getPrdtNum();
				String sessionDivSn = "";
				String sessionOptSn = "";

				if(prdtNum.equals(sessionPrdtNum)) {
					if(Constant.SOCIAL.equals(category)) {
						divSn = cart.getSpDivSn();
						optSn = cart.getSpOptSn();
						sessionDivSn = sessionCart.getSpDivSn();
						sessionOptSn = sessionCart.getSpOptSn();
					} else if(Constant.SV.equals(category)) {
						divSn = cart.getSvDivSn();
						optSn = cart.getSvOptSn();
						sessionDivSn = sessionCart.getSvDivSn();
						sessionOptSn = sessionCart.getSvOptSn();
					}
					if(divSn.equals(sessionDivSn) && optSn.equals(sessionOptSn)) {
						sessionCartList.remove(sessionCart);
						break;
					}
				}
			}*/
    		cart.setCartSn(cartSn);
    		sessionCartList.add(cart);
			cartSn++;
		}
    	
    	request.getSession().setAttribute("cartList", sessionCartList);
    	
    	/* 현대캐피탈 one-card */
    	request.getSession().setAttribute("hcOneCardYnList", cartList);
    	
    	// 로그인된 사용자인 경우 DB 처리
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		webCartService.addCart(sessionCartList);
    	}

    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap.put("cartCnt", sessionCartList.size());

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
    }

	@RequestMapping("/index.do")
	public String index(HttpServletRequest request, @RequestParam Map<String, String> params){

		String userAgent = request.getHeader("User-Agent").toLowerCase();
		String queryString = request.getQueryString();

		String[] mobileos = { "iphone", "ipad", "ipod"
							, "android", "windows phone", "iemobile"
							, "blackberry", "mobile safari", "opera mobi"
							, "nokia", "webos", "windows ce", "opera mini"};

		boolean isMobile = false;

		if(userAgent != null && !userAgent.isEmpty()){
			for(int i = 0;i<mobileos.length; i++){
				int chk = userAgent.indexOf(mobileos[i]);
				if(chk > -1){
					isMobile = true;
				}
			}
		}
		
		if(isMobile){
			if(EgovStringUtil.isEmpty(queryString)){
				//return "redirect:https://www.tamnao.com/mw/";
				return "forward:/mw/main.do";
			}else{
				//return "redirect:https://www.tamnao.com/mw/?" + queryString;
				return "redirect:/mw/main.do?" + queryString;
			}
		}else{
			return "forward:/main.do";
		}
	}

	/**
	 * 숙박랭킹 AJAX
	 * 파일명 : mainAdRank
	 * 작성일 : 2016. 3. 8. 오후 4:40:53
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@RequestMapping("/web/mainAdRank.ajax")
	public ModelAndView mainAdRank(@ModelAttribute("MAINSVO") MAINPRDTSVO mainSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<MAINPRDTVO> prdtList = new ArrayList<MAINPRDTVO>();

    	prdtList = webMainService.selectMain11(mainSVO);
    	resultMap.put("adRankList", prdtList);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;

	}

	/**
	 * 항공패키지
	 * 파일명 : mainAirPack
	 * 작성일 : 2016. 3. 8. 오후 4:41:15
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@RequestMapping("/web/mainAirPack.ajax")
	public ModelAndView mainAirPack(@ModelAttribute("MAINSVO") MAINPRDTSVO mainSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<MAINPRDTVO> prdtList = new ArrayList<MAINPRDTVO>();

		// 항공패키지
    	prdtList = webMainService.selectMain17(mainSVO);
    	resultMap.put("airPack", prdtList);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;

	}

	/**
	 * 관광기념품
	 * 파일명 : mainSv
	 * 작성일 : 2016. 10. 18. 오후 3:28:52
	 * 작성자 : 최영철
	 * @param mainSVO
	 * @return
	 */
	@RequestMapping("/web/mainSv.ajax")
	public ModelAndView mainSv(@ModelAttribute("MAINSVO") MAINPRDTSVO mainSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<MAINPRDTVO> prdtList = new ArrayList<MAINPRDTVO>();

		// 관광기념품

		prdtList = webMainService.selectMain21(mainSVO);

		resultMap.put("sv", prdtList);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;

	}

	@RequestMapping("/web/map.do")
	public String map(ModelMap model, @RequestParam String typeCd) {		
		// 카테고리 타입		
		model.addAttribute("typeCd", typeCd);
		
		//숙박 유형
		List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
		model.addAttribute("cdAddv", cdAddv);
		// 숙소
		List<AD_WEBDTLVO> adList = webAdProductService.selectProductCorpMapList();

		// 관광지.
		WEB_SPSVO searchVO = new WEB_SPSVO();
		searchVO.setsCtgrDepth("1");
		searchVO.setsCtgr(Constant.CATEGORY_TOUR);
		searchVO.setsCtgrDiv(Constant.CATEGORY_TOUR);
		List<WEB_DTLPRDTVO> tourList = webSpService.selectProductCorpMapList(searchVO);

		// 레져 -
		/*searchVO = new WEB_SPSVO();
		List<String> ctgrList = new ArrayList<String>();
		ctgrList.add(Constant.CATEGORY_ETC_SPORT);
		ctgrList.add(Constant.CATEGORY_ETC_SHIP);
//		ctgrList.add(Constant.CATEGORY_ETC_HORSE);
		searchVO.setCtgrList(ctgrList);
		searchVO.setsCtgrDiv(Constant.CATEGORY_ETC);
		List<WEB_DTLPRDTVO> sportList = webSpService.selectProductCorpMapList(searchVO);*/

		//음식
		searchVO = new WEB_SPSVO();
		searchVO.setsCtgrDepth("2");
		searchVO.setsCtgr(Constant.CATEGORY_ETC_FOOD);
		searchVO.setsCtgrDiv(Constant.CATEGORY_ETC);
		List<WEB_DTLPRDTVO> foodList = webSpService.selectProductCorpMapList(searchVO);

		//뷰티
		searchVO = new WEB_SPSVO();
		searchVO.setsCtgrDepth("2");
		searchVO.setsCtgr(Constant.CATEGORY_ETC_MASSAGE);
		searchVO.setsCtgrDiv(Constant.CATEGORY_ETC);
		List<WEB_DTLPRDTVO> beautyList = webSpService.selectProductCorpMapList(searchVO);

		model.addAttribute("adList", adList);
		model.addAttribute("tourList", tourList);
//		model.addAttribute("sportList", sportList);
		model.addAttribute("foodList", foodList);
		model.addAttribute("beautyList", beautyList);

		return "/web/cmm/map";
	}

	/**
	 * 지도 상세 상품
	 * 파일명 : mapPrdtList
	 * 작성일 : 2016. 12. 21. 오전 9:22:48
	 * 작성자 : 최영철
	 * @param model
	 * @param corpCd
	 * @param corpId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/web/mapPrdtList.ajax")
	public ModelAndView mapPrdtList(ModelMap model, @RequestParam String corpCd, @RequestParam String corpId) {
		ModelAndView mav = new ModelAndView();
		
		if(Constant.ACCOMMODATION.equals(corpCd)) {
			AD_WEBLISTSVO prdtSVO = new AD_WEBLISTSVO();
			 prdtSVO.setsCorpId(corpId);
			 //prdtSVO.setsNights("1");
			 prdtSVO.setsFromDt(new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()));
			 prdtSVO.setFirstIndex(0);
			 prdtSVO.setLastIndex(1000);
			 prdtSVO.setsSearchYn(Constant.FLAG_N);
			 
			Map<String, Object> resultMap = new HashMap<String, Object>();
			List<AD_WEBLISTVO> resultList = new ArrayList<AD_WEBLISTVO>();
			
			resultList = (List<AD_WEBLISTVO>)webAdProductService.selectAdPrdtList(prdtSVO).get("resultList");
			
			resultMap.put("mapAdPoint", resultList);
			mav = new ModelAndView("jsonView", resultMap);
			
			//model.addAttribute("product", resultList);

		} else if(Constant.SOCIAL.equals(corpCd)) {
			WEB_SPSVO searchVO = new WEB_SPSVO();

			List<String> prdtNumList = new ArrayList<String>();
			prdtNumList.add(corpId);

			searchVO.setPrdtNumList(prdtNumList);

			searchVO.setFirstIndex(0);
			searchVO.setLastIndex(100);

			Map<String, Object> productMap = webSpService.selectProductList(searchVO);

			List<WEB_SPPRDTVO> resultList = (List<WEB_SPPRDTVO>)productMap.get("resultList");
			model.addAttribute("product", resultList);
		}
		//model.addAttribute("corpCd", corpCd);
		//return "/web/cmm/mapPrdtList";
		return mav;
	}

	/**
	 * SNS 공유 시 건수 증가
	 * Function : snsCount
	 * 작성일 : 2016. 9. 13. 오후 3:43:46
	 * 작성자 : 정동수
	 * @param prdtInqVO
	 * @return
	 */
	@RequestMapping("/web/snsCount.ajax")
	public ModelAndView snsCount(@ModelAttribute("PRDTINQVO") PRDTINQVO prdtInqVO) {
		prdtInqVO.setSnsPublicNum(1);

    	/** 데이터제공 조회정보 수집*/
        ApiNextezPrcAdd apiNextezPrcAdd = new ApiNextezPrcAdd();
        if("PC".equals(prdtInqVO.getInqDiv())){
			apiNextezPrcAdd.setvConectDeviceNm("PC");
		}else{
        	apiNextezPrcAdd.setvConectDeviceNm("MOBILE");
		}
		if(prdtInqVO.getLinkNum().contains("AD")){
			apiNextezPrcAdd.setvCtgr("AD");
		}else{
        	apiNextezPrcAdd.setvCtgr(prdtInqVO.getLinkNum().substring(0, 2));
		}
        apiNextezPrcAdd.setvPrdtNum(prdtInqVO.getLinkNum());
        apiNextezPrcAdd.setvType("share");
        apiNextezPrcAdd.setvVal1(prdtInqVO.getSnsDiv());
		apiService.insertNexezData(apiNextezPrcAdd);
    	Map<String, Object> resultMap = new HashMap<String, Object>();
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	@RequestMapping("/ifrmSearch.do")
	public String ifrmSearch(@ModelAttribute("rcSearchVO") RC_PRDTINFSVO rcPrdtSVO,
						   @ModelAttribute("adSearchVO") AD_WEBLISTSVO adPrdtSVO,
						   ModelMap model) {

		/** 날짜선택*/
		Calendar calNow = Calendar.getInstance();
		model.addAttribute("SVR_TODAY", EgovStringUtil.getDateFormatDash(calNow));
		/** 숙소시작일 기본선택*/
		adPrdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
		adPrdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
		/** 숙소퇴실일_기본선택*/
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		adPrdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
		adPrdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
		/** 렌터카_대여시작일*/
		rcPrdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
		rcPrdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
		rcPrdtSVO.setsFromTm("1200");
		/** 렌터카_대여종료일*/
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		rcPrdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
		rcPrdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
		rcPrdtSVO.setsToTm("1200");

		/** 숙소지역코드 */
		List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
		model.addAttribute("cdAdar", cdAdar);

		/** 차량구분코드*/
		List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
		model.addAttribute("carDivCd", cdList);

		return "/web/iframe/ifrmSearch";
	}

	@RequestMapping("/clear.ajax")
	public ModelAndView cacheClear() {
		log.info("cache clear");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		nativeEhCacheManager.clearAll();  // 모든 캐시 초기화

    	resultMap.put("result", "cache clear");
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}
}