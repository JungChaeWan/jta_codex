package mw.main.web;


import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import mas.prmt.service.MasPrmtService;
import mas.prmt.vo.MAINPRMTVO;
import mas.rc.vo.RC_PRDTINFSVO;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.ad.vo.AD_WEBLISTSVO;
import oss.ad.vo.AD_WEBLISTVO;
import oss.benner.service.OssBannerService;
import oss.benner.vo.BANNERVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_IMGVO;
import oss.cmm.vo.CM_SRCHWORDVO;
import oss.cmm.vo.ISEARCHVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.marketing.serive.OssAdmRcmdService;
import oss.marketing.serive.OssKwaService;
import oss.point.service.OssPointService;
import oss.point.vo.POINT_CPVO;
import oss.site.service.OssCrtnService;
import oss.site.vo.MAINCTGRRCMDVO;
import oss.site.vo.MAINHOTPRDTVO;
import oss.user.vo.USERVO;
import web.main.service.WebMainService;
import web.main.vo.MAINPRDTVO;
import web.main.vo.SEOVO;
import web.mypage.service.WebMypageService;
import web.order.service.WebCartService;
import web.order.service.WebOrderService;
import web.order.vo.RSVVO;
import web.product.service.*;
import web.product.service.impl.WebAdDAO;
import web.product.vo.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * @author 최영철
 * @since 2015. 9. 16.
 * << 개정이력(Modification Information) >>
 * <p>
 * 수정일		수정자		수정내용
 * -------    	--------    ---------------------------
 */
@Controller
public class MwMainController {

    @Autowired
    private DefaultBeanValidator beanValidator;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name = "webMainService")
    private WebMainService webMainService;

    @Resource(name = "ossCorpService")
    protected OssCorpService ossCorpService;

    @Resource(name = "webSpService")
    protected WebSpProductService webSpService;

    @Resource(name = "webSvService")
    protected WebSvProductService webSvService;

    @Resource(name = "webAdProductService")
    protected WebAdProductService webAdProductService;

    @Resource(name = "webRcProductService")
    protected WebRcProductService webRcProductService;

    @Resource(name = "masPrmtService")
    private MasPrmtService masPrmtService;

    @Resource(name = "ossCmmService")
    private OssCmmService ossCmmService;

    @Resource(name = "ossKwaService")
    private OssKwaService ossKwaService;

    @Resource(name = "OssAdmRcmdService")
    protected OssAdmRcmdService ossAdmRcmdService;

    @Resource(name = "webPrmtService")
    protected WebPrmtService webPrmtService;

    @Resource(name = "webMypageService")
    protected WebMypageService webMypageService;

    @Resource(name = "webCartService")
    private WebCartService webCartService;

    @Resource(name = "webOrderService")
    private WebOrderService webOrderService;

    @Resource(name = "ossBannerService")
    private OssBannerService ossBannerService;

    @Resource(name = "ossCrtnService")
    protected OssCrtnService ossCrtnService;

    @Autowired
    protected WebAdDAO webAdDAO;

    @Resource(name="ossPointService")
    private OssPointService ossPointService;

    Logger log = (Logger) LogManager.getLogger(this.getClass());

    @RequestMapping("/mw/main.do")
    public String mwMain2(@ModelAttribute("rcSearchVO") RC_PRDTINFSVO rcPrdtSVO,
                          @ModelAttribute("adSearchVO") AD_WEBLISTSVO adPrdtSVO,
                          ModelMap model) {

        /* 인기있수다 */
        List<MAINHOTPRDTVO> mainHotList = webMainService.selectMainHotList();
        model.addAttribute("mainHotList", mainHotList);

        /* 이벤트 */
        MAINPRMTVO mainPrmtVO = new MAINPRMTVO();
        List<MAINPRMTVO> mainPrmtList = masPrmtService.selectMainPrmtMain(mainPrmtVO);

        model.addAttribute("prmtList", mainPrmtList);

        /* (2021.10.28 WEB기준으로 맞춤. chaewan.jung)*/
        MAINCTGRRCMDVO mainctgrrcmdVO = new MAINCTGRRCMDVO();

        /*관광지/레저*/
        mainctgrrcmdVO.setPrdtDiv(Constant.CATEGORY_TOUR);
        List<MAINCTGRRCMDVO> mainCtgrRcmdTourList = webMainService.selectMainCtgrRcmdList(mainctgrrcmdVO);

        /*맛집*/
        mainctgrrcmdVO.setPrdtDiv(Constant.CATEGORY_ETC);
        List<MAINCTGRRCMDVO> mainCtgrRcmdEtcList = webMainService.selectMainCtgrRcmdList(mainctgrrcmdVO);

        /*제주특산/기념품*/
        mainctgrrcmdVO.setPrdtDiv(Constant.SV);
        List<MAINCTGRRCMDVO> mainCtgrRcmdSvList = webMainService.selectMainCtgrRcmdList(mainctgrrcmdVO);

        model.addAttribute("mainCtgrRcmdTourList", mainCtgrRcmdTourList);
        model.addAttribute("mainCtgrRcmdEtcList", mainCtgrRcmdEtcList);
        model.addAttribute("mainCtgrRcmdSvList", mainCtgrRcmdSvList);

        /** 모바일 메인팝업 */
        BANNERVO bannerVO = new BANNERVO();
        bannerVO.setLocation("BN04");

        List<BANNERVO> eventPopup = ossBannerService.selectBannerListWebByPrintSn(bannerVO);
        model.addAttribute("eventPopup", eventPopup);

        return "/mw/main";
    }

    @RequestMapping("/mw/includeJs.do")
    public String includeJs(@ModelAttribute("SEOVO") SEOVO seoVO,
                            HttpServletRequest request,
                            ModelMap model) {
        String strKeywrd = "";
        int nKeyLen = 0;
        //키워드 검색
        if (StringUtils.isNotEmpty(seoVO.getKeywordsLinkNum())) {
            List<CM_SRCHWORDVO> srchWordList = ossCmmService.selectSrchWordList(seoVO.getKeywordsLinkNum());

            for (CM_SRCHWORDVO data : srchWordList) {
                strKeywrd += data.getSrchWord() + ",";
                nKeyLen++;
            }
        }
        //추가 키워드
        if (StringUtils.isNotEmpty(seoVO.getKeywordAdd1())) {
            strKeywrd += seoVO.getKeywordAdd1() + ",";
            nKeyLen++;
        }
        if (StringUtils.isNotEmpty(seoVO.getKeywordAdd2())) {
            strKeywrd += seoVO.getKeywordAdd2() + ",";
            nKeyLen++;
        }
        if (StringUtils.isNotEmpty(seoVO.getKeywordAdd3())) {
            strKeywrd += seoVO.getKeywordAdd3() + ",";
            nKeyLen++;
        }
        if (StringUtils.isNotEmpty(seoVO.getKeywordAdd4())) {
            strKeywrd += seoVO.getKeywordAdd4() + ",";
            nKeyLen++;
        }
        if (nKeyLen > 0) {
            strKeywrd = strKeywrd.substring(0, strKeywrd.length() - 1);//끝에 ',' 지우기

            seoVO.setKeywords(strKeywrd);
        }
        //이미지패스
        if (StringUtils.isNotEmpty(seoVO.getImagePath())) {
            String serverName = request.getScheme() + "://" + request.getServerName();
            serverName += (request.getServerPort() == 80 ? "" : ":" + request.getServerPort());

            seoVO.setImage(serverName + seoVO.getImagePath());
        }
        model.addAttribute("seo", seoVO);

        return "/mw/includeJs";
    }

    @RequestMapping("/mw/head.do")
    public String mwHead(HttpServletRequest request,
                         @RequestParam Map<String, String> params,
                         ModelMap model) {

        if (StringUtils.isEmpty((String) request.getSession().getAttribute("partner")) && StringUtils.isNotEmpty(params.get("partner"))) {
            request.getSession().setAttribute("partner", params.get("partner"));
            USERVO userVO = new USERVO();
            userVO.setPartnerCd((String) request.getSession().getAttribute("partner"));
            webMainService.updateTamnaoPartnerAccessCnt(userVO);
        } else if ("visitjeju".equals((String) request.getSession().getAttribute("partner"))) {
            /** 파트서관리 비짓제주 예외처리*/
            model.addAttribute("partner", "visitjeju");
        }

        String menuNm = "";

        if (StringUtils.isNotEmpty(params.get("headTitle"))) {
            menuNm = params.get("headTitle");
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

        String strIsLogin = "N";

        USERVO userVO;
        RSVVO rsvVO = new RSVVO();
        rsvVO.setWaitingTime(Constant.WAITING_TIME);
        
        /*
        List<RSVVO> unpaidRsvList = new ArrayList<RSVVO>();

        if (EgovUserDetailsHelper.isAuthenticated()) {
            strIsLogin = "Y";
            // 미결제 조회
            userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
            rsvVO.setUserId(userVO.getUserId());

            unpaidRsvList = webOrderService.selectUnpaidRsvList(rsvVO);
        } else {
            if (EgovUserDetailsHelper.isAuthenticatedGuest()) {
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
        if (unpaidRsvList.size() > 0) {
            unpaidRsvNum = unpaidRsvList.get(0).getRsvNum();
        }
		*/
        
        /*//추가기능:: 키워드광고
        KWASVO kwaSVO = new KWASVO();
        kwaSVO.setCnt("3");
        kwaSVO.setSlocation("KW01");

        List<KWAVO> kwaList = ossKwaService.selectKwaWebList(kwaSVO);*/

        // Menu 명
        /*Map<String, String> naviMap = new HashMap<String, String>();
        naviMap.put("rc", "렌터카");
        naviMap.put("ad", "숙소");
        naviMap.put("av", "항공");
        naviMap.put("C190", "선박");
        naviMap.put("C200", "관광지/레저");
        naviMap.put("sv", "특산/기념품");
        naviMap.put("C270", "체험");
        naviMap.put("C300", "맛집");
        naviMap.put("C100", "여행사상품");
        naviMap.put("C500", "유모차/카시트");
        naviMap.put("plan", "기획전");
        naviMap.put("evnt", "이벤트");
        naviMap.put("bbs", "공지사항");
        naviMap.put("help", "고객센터");
        naviMap.put("mypage", "MY PAGE");
        naviMap.put("clause", "이용약관");
        naviMap.put("rsv", "나의예약/구매내역");
        naviMap.put("cart.do", "장바구니");
        naviMap.put("pocket", "찜한상품");
        naviMap.put("coupon", "탐나오쿠폰내역");
        naviMap.put("free", "할인쿠폰보관함");
        naviMap.put("otoinq", "1:1문의");
        naviMap.put("useepil", "이용후기");
        naviMap.put("update", "개인정보수정");
        naviMap.put("pw", "비밀번호변경");
        naviMap.put("refund", "환불계좌관리");
        naviMap.put("drop", "회원탈퇴");
        naviMap.put("order01.do", "주문");
        naviMap.put("order03.do", "결제");
        naviMap.put("introduction", "회사소개");
        naviMap.put("point.do", "탐나오포인트");

        String[] pathArr = request.getRequestURI().split("/");
        String menuNm = naviMap.get(pathArr[4]);

        if ("sp".equals(pathArr[4])) {
            menuNm = naviMap.get(request.getParameter("sCtgr"));
        } else if (request.getParameter("type") != null) {
            menuNm = naviMap.get(request.getParameter("type"));
        }*/

        //model.addAttribute("unpaidRsvNum", unpaidRsvNum);
        model.addAttribute("isLogin", strIsLogin);
        /*model.addAttribute("kwaList", kwaList);*/
        model.addAttribute("menuNm", menuNm);
        return "/mw/head";
    }

    @RequestMapping("/mw/mainHead.do")
    public String mwMainHead(ModelMap model,
                             HttpServletRequest request,
                             @RequestParam Map<String, String> params) {

        if (StringUtils.isEmpty((String) request.getSession().getAttribute("partner")) && StringUtils.isNotEmpty(params.get("partner"))) {
            request.getSession().setAttribute("partner", params.get("partner"));
            USERVO userVO = new USERVO();
            userVO.setPartnerCd((String) request.getSession().getAttribute("partner"));
            webMainService.updateTamnaoPartnerAccessCnt(userVO);
        } else if ("visitjeju".equals((String) request.getSession().getAttribute("partner"))) {
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
        String logoUrl = "/images/mw/main/main_logo_2.png";
        if (!("".equals(ssPartnerCode) || ssPartnerCode == null)) {
            POINT_CPVO pointCpVO =  ossPointService.selectPointCpDetail((String)ssPartnerCode);
            if (pointCpVO != null) {
                logoUrl = EgovProperties.getProperty("COUPON.SAVEDFILE") + pointCpVO.getPartnerLogom();
            }
        }
        model.addAttribute("logoUrl", logoUrl);

        String strIsLogin = "N";

        USERVO userVO;
        RSVVO rsvVO = new RSVVO();
        rsvVO.setWaitingTime(Constant.WAITING_TIME);
        
        /*
        List<RSVVO> unpaidRsvList = new ArrayList<RSVVO>();

        if (EgovUserDetailsHelper.isAuthenticated()) {
            strIsLogin = "Y";
            // 미결제 조회
            userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
            rsvVO.setUserId(userVO.getUserId());

            unpaidRsvList = webOrderService.selectUnpaidRsvList(rsvVO);
        } else {
            if (EgovUserDetailsHelper.isAuthenticatedGuest()) {
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
        if (unpaidRsvList.size() > 0) {
            unpaidRsvNum = unpaidRsvList.get(0).getRsvNum();
        }
        model.addAttribute("unpaidRsvNum", unpaidRsvNum);
        */
        
        model.addAttribute("isLogin", strIsLogin);
        return "/mw/mainHead";
    }

    @RequestMapping("/mw/foot.do")
    public String mwFoot(@RequestParam Map<String, String> params,
                         ModelMap model) {
        BANNERVO bannerVO = new BANNERVO();
        bannerVO.setLocation("BN01");
        List<BANNERVO> bannerListTop = ossBannerService.selectBannerListWeb(bannerVO);
        model.addAttribute("bannerListTop", bannerListTop);
        return "/mw/foot";
    }

    @RequestMapping("/mw/menu.do")
    public String mwMenu(@RequestParam Map<String, String> params,
                         ModelMap model) {
        return "/mw/menu";
    }

    @RequestMapping("/mw/newMenu.do")
    public String newMenu(@RequestParam Map<String, String> params,
                          ModelMap model, HttpServletRequest request) throws Exception {


        ISEARCHVO isearchvo = new ISEARCHVO();
        isearchvo.setIp(EgovClntInfo.getClntIP(request));

        String strIsLogin = "N";
        if (EgovUserDetailsHelper.isAuthenticated() == true) {
            strIsLogin = "Y";
            USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
            model.addAttribute("userNm", loginVO.getUserNm());
        } else {
            if (EgovUserDetailsHelper.isAuthenticatedGuest() == true) {
                strIsLogin = "G";
            }
        }

        model.addAttribute("isLogin", strIsLogin);
        model.addAttribute("menuNm", params.get("menu"));

        // 큐레이션 리스트
        /*List<SVCRTNVO> crtnList = ossCrtnService.selectCrtnWebList();
        model.addAttribute("crtnList", crtnList);*/

        //특산/기념품 카테고리 브랜드 조회
        /*WEB_SVSVO searchVO = new WEB_SVSVO();
        searchVO.setsCorpCd(Constant.SV);
        List<WEB_SVPRDTVO> brandPrdtList = webSvService.selectBrandPrdtList(searchVO);
        model.addAttribute("brandPrdtList", brandPrdtList);*/

        //로고 셋팅
        String ssPartnerCode = (String) request.getSession().getAttribute("ssPartnerCode");
        String logoUrl = "/images/mw/main/main_logo_2.png";
        if (!("".equals(ssPartnerCode) || ssPartnerCode == null)) {
            POINT_CPVO pointCpVO =  ossPointService.selectPointCpDetail((String)ssPartnerCode);
            if (pointCpVO != null) {
                logoUrl = EgovProperties.getProperty("COUPON.SAVEDFILE") + pointCpVO.getPartnerLogom();
            }
        }

        model.addAttribute("logoUrl", logoUrl);


        return "/mw/newMenu";
    }

    @RequestMapping("/mw/selSrchWords.ajax")
    public ModelAndView selSrchWords(@ModelAttribute("searchVO") ISEARCHVO isearchvo, HttpServletRequest request) throws Exception {
        isearchvo.setIp(EgovClntInfo.getClntIP(request));
        List<ISEARCHVO> isearchvoList = ossCmmService.selectIsearchWords(isearchvo);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("resultList", isearchvoList);
        ModelAndView mav = new ModelAndView("jsonView", resultMap);
        return mav;
    }

    @RequestMapping("/mw/delSrchWords.ajax")
    public ModelAndView delSrchWords(@ModelAttribute("searchVO") ISEARCHVO isearchvo, HttpServletRequest request) throws Exception {
        isearchvo.setIp(EgovClntInfo.getClntIP(request));
        ossCmmService.deleteIsearchWords(isearchvo);
        List<ISEARCHVO> isearchvoList = ossCmmService.selectIsearchWords(isearchvo);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("resultList", isearchvoList);
        ModelAndView mav = new ModelAndView("jsonView", resultMap);
        return mav;
    }

    @RequestMapping("/mw/logout.do")
    public String logout(HttpServletRequest request) throws Exception {
    	/*
        request.getSession().setAttribute("loginVO", null);
        request.getSession().setAttribute("guestLoginVO", null);
        request.getSession().setAttribute("cartList", null);
        */
    	HttpSession session = request.getSession(false);
        if(session != null) {
            session.invalidate();
        }
         
        return "redirect:/mw/main.do";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping("/mw/addCart.ajax")
    public ModelAndView addCart(
        @RequestBody CARTLISTVO cartListVO,
        HttpServletRequest request,
        HttpServletResponse response) {
        log.info("/mw/addCart.ajax 호출");

        List<CARTVO> sessionCartList = new ArrayList<CARTVO>();
        List<CARTVO> cartList = cartListVO.getCartList();

        Integer cartSn = 1;
        if (request.getSession().getAttribute("cartList") != null) {
            sessionCartList = (List<CARTVO>) request.getSession().getAttribute("cartList");

            Integer maxCartSn = 0;
            for (CARTVO cart : sessionCartList) {
                if (cart.getCartSn() > maxCartSn) {
                    maxCartSn = cart.getCartSn();
                }
            }
            cartSn = maxCartSn + 1;
        }

        for (CARTVO cart : cartList) {
            cart.setCartSn(cartSn);
            cartSn++;
            sessionCartList.add(cart);
        }

        request.getSession().setAttribute("cartList", sessionCartList);

        // 로그인된 사용자인 경우 DB 처리
        if (EgovUserDetailsHelper.isAuthenticated()) {
            webCartService.addCart(sessionCartList);
        }

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("cartCnt", sessionCartList.size());
        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /*@RequestMapping("/mw/meMap.do")
    public String meMap(ModelMap model,
                        HttpServletRequest request) {
        log.info("/mw/meMap.do call");

        String strGps = request.getParameter("gps");
        log.info("/mw/meMap.do call:" + strGps);

        model.addAttribute("gps", strGps);
        return "/mw/cmm/meMap";
    }*/

    /**
     * 설명 : 관광지/레저 MAP
     * 파일명 : mapSp
     * 작성일 : 2023-03-03 오후 1:59
     * 작성자 : chaewan.jung
     * @param : [prdtSVO, model]
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/mw/mapSp.do")
    public String mapSp(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO,
                      ModelMap model) {
        log.info("/mw/mapSp.do call");

        WEB_SPSVO searchVO = new WEB_SPSVO();
        searchVO.setsCtgrDepth("1"); // 1 depth
        searchVO.setsCtgr("C200"); // 1 depth category
        List<WEB_DTLPRDTVO> tourList = webSpService.selectProductCorpMapList(searchVO);
        model.addAttribute("tourList", tourList);

        return "/mw/cmm/mapSp";
    }

    /**
     * 설명 : 관광지/레져 맵에서 클릭시 상품 detail layer
     * 파일명 : mapSpPrdtList
     * 작성일 : 2023-03-03 오후 5:12
     * 작성자 : chaewan.jung
     * @param : [model, prdtSVO]
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/mw/mapSpPrdtList.ajax")
    public String mapSpPrdtList(ModelMap model, @ModelAttribute("searchVO") WEB_DTLPRDTVO prdtSVO) {
        // 상품 정보 가져오기.
        prdtSVO.setPreviewYn("Y");
        WEB_DTLPRDTVO prdtInfo =  webSpService.selectByPrdt(prdtSVO);
        model.addAttribute("prdtInfo", prdtInfo);

        // 상품 이미지 가져오기.
        CM_IMGVO imgVO = new CM_IMGVO();
        imgVO.setLinkNum(prdtSVO.getPrdtNum());
        List<CM_IMGVO> prdtImg = ossCmmService.selectSvImgList(imgVO);
        model.addAttribute("prdtImg", prdtImg);

        return "/mw/cmm/mapSpPrdtList";
    }

    /**
     * 설명 : 숙소 맵
     * 파일명 : mapPrdtList
     * 작성일 : 2023-02-07 오전 11:35
     * 작성자 : chaewan.jung
     * @param : [model, prdtSVO]
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/mw/map.do")
    public String map(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO,
                      ModelMap model) {
        log.info("/mw/map.do call");
        setAdBase(prdtSVO);
        prdtSVO.setFirstIndex(0);
        prdtSVO.setLastIndex(9999);
        prdtSVO.setRsvAbleYn("Y");

        List<AD_WEBLISTVO> resultList = webAdDAO.selectAdList(prdtSVO);
        model.addAttribute("adList", resultList);

        return "/mw/cmm/map";
    }

    /**
     * 설명 : 숙소 맵에서 숙소 클릭시 상품 detail layer
     * 파일명 : mapPrdtList
     * 작성일 : 2023-02-07 오전 11:35
     * 작성자 : chaewan.jung
     * @param : [model, prdtSVO]
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/mw/mapPrdtList.ajax")
    public String mapPrdtList(ModelMap model, @ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO) {

        setAdBase(prdtSVO);
        prdtSVO.setFirstIndex(0);
        prdtSVO.setLastIndex(1);

        List<AD_WEBLISTVO> resultList = webAdDAO.selectAdList(prdtSVO);
        model.addAttribute("product", resultList);

        return "/mw/cmm/mapPrdtList";
    }

    /**
    * 설명 : 기본 숙박 정보 setting
    * 파일명 : setAdBase
    * 작성일 : 2023-03-02 오후 5:18
    * 작성자 : chaewan.jung
    * @param : AD_WEBLISTSVO prdtSVO
    * @return :
    * @throws Exception
    */
    private void setAdBase(AD_WEBLISTSVO prdtSVO){
        if (prdtSVO.getsFromDt() == null) {
            //초기 날짜 지정
            Calendar calNow = Calendar.getInstance();
            calNow.add(Calendar.DAY_OF_MONTH, 1);
            prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
            prdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));

            calNow.add(Calendar.DAY_OF_MONTH, 1);
            prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
            prdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));

            prdtSVO.setsRoomNum("1");
        }

        //박이 없으면 1박
        if (StringUtils.isEmpty(prdtSVO.getsNights())) {
            prdtSVO.setsNights("1");
        }
        // 인원이 없으면 성인 2명
        if (StringUtils.isEmpty(prdtSVO.getsMen())) {
            prdtSVO.setsMen("2");
            prdtSVO.setsAdultCnt("2");
            prdtSVO.setsChildCnt("0");
            prdtSVO.setsBabyCnt("0");
        }

        if (StringUtils.isEmpty(prdtSVO.getsSearchYn())) {
            prdtSVO.setsSearchYn(Constant.FLAG_N);
        }
    }

    @RequestMapping("/mw/prdtMap.do")
    public String prdtMap(@Param("WEB_DTLPRDTVO") WEB_DTLPRDTVO prdtVO,
                          ModelMap model) {

        CORPVO corpVO = new CORPVO();
        if (!StringUtils.isEmpty(prdtVO.getCorpId())) {
            corpVO.setCorpId(prdtVO.getCorpId());
            CORPVO resultVO = ossCorpService.selectByCorp(corpVO);
            corpVO.setLat(resultVO.getLat());
            corpVO.setLon(resultVO.getLon());

            model.addAttribute("resultVO", resultVO);

        } else {
            WEB_DTLPRDTVO spPrdtVO = webSpService.selectByPrdt(prdtVO);
            CORPVO resultVO = new CORPVO();
            resultVO.setCorpNm(spPrdtVO.getPrdtNm());
            resultVO.setRoadNmAddr(spPrdtVO.getRoadNmAddr());
            resultVO.setDtlAddr(spPrdtVO.getDtlAddr());
            resultVO.setLat(spPrdtVO.getLat());
            resultVO.setLon(spPrdtVO.getLon());

            corpVO.setLat(spPrdtVO.getLat());
            corpVO.setLon(spPrdtVO.getLon());

            model.addAttribute("resultVO", resultVO);
        }

        corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
        corpVO.setsDist(5000);

        corpVO.setCorpCd(Constant.ACCOMMODATION);
        List<CORPVO> adList = ossCorpService.selectCorpDistList(corpVO);

        // 여행지
        corpVO.setCorpCd(Constant.SOCIAL);
        corpVO.setCorpSubCd(Constant.SOCIAL_TICK);
        List<CORPVO> tourList = ossCorpService.selectCorpDistList(corpVO);

        //음식 뷰티
        corpVO.setCorpCd(Constant.SOCIAL);
        corpVO.setCorpSubCd(Constant.SOCIAL_FOOD);
        List<CORPVO> etcList = ossCorpService.selectCorpDistList(corpVO);

        model.addAttribute("adList", adList);
        model.addAttribute("tourList", tourList);
        model.addAttribute("etcList", etcList);

        return "/mw/cmm/prdtMap";
    }

    @RequestMapping("/mw/getMapMarker.ajax")
    public ModelAndView getMapMarker(@RequestParam("lat") String lat, @RequestParam("lon") String lon) {
        Map<String, Object> resultMap = new HashMap<String, Object>();


        CORPVO corpVO = new CORPVO();

        corpVO.setLat(lat);
        corpVO.setLon(lon);
        corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
        corpVO.setsDist(5000);

        corpVO.setCorpCd(Constant.ACCOMMODATION);
        List<CORPVO> adList = ossCorpService.selectCorpDistList(corpVO);

        corpVO.setCorpCd(Constant.SOCIAL);
        corpVO.setCorpSubCd(Constant.SOCIAL_TICK);
        List<CORPVO> tourList = ossCorpService.selectCorpDistList(corpVO);

        corpVO.setCorpCd(Constant.SOCIAL);
        corpVO.setCorpSubCd(Constant.SOCIAL_FOOD);
        List<CORPVO> etcList = ossCorpService.selectCorpDistList(corpVO);

        resultMap.put("adList", adList);
        resultMap.put("tourList", tourList);
        resultMap.put("etcList", etcList);
        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    @RequestMapping("/mw/cerca.do")
    public String cerca(HttpServletRequest request,
                         ModelMap model) throws Exception {

        String search = request.getParameter("trova");

        if (search.length() >= 30) {
            model.addAttribute("search", "search");
            model.addAttribute("adCnt", 0);
            model.addAttribute("rcCnt", 0);
            model.addAttribute("packageCnt", 0);
            model.addAttribute("tourCnt", 0);
            model.addAttribute("foodCnt", 0);
            model.addAttribute("svCnt", 0);
            model.addAttribute("strollerCnt", 0);
            return "/web/cmm/cerca";  // 리뉴얼 TOBE
        }

        if (EgovStringUtil.isEmpty(search)) {
            log.error("search is null");
            return "redirect:/mw/main.do";
        }
        // 검색어 통계 처리
        ISEARCHVO isearchvo = new ISEARCHVO();

        isearchvo.setIp(EgovClntInfo.getClntIP(request));
        isearchvo.setSrchWord(search);
        ossCmmService.insertIsearchWords(isearchvo);

        AD_WEBLISTSVO adPrdtSVO = new AD_WEBLISTSVO();
        adPrdtSVO.setSearchWord(search);
        Calendar calNow = Calendar.getInstance();
        calNow.add(Calendar.DAY_OF_MONTH, 1);
        adPrdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
        calNow.add(Calendar.DAY_OF_MONTH, 1);
        adPrdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
        adPrdtSVO.setsNights("1");
        adPrdtSVO.setsSearchYn("N");
        Integer adCnt = webAdProductService.getCntAdList(adPrdtSVO);

        RC_PRDTINFSVO rcPrdtSVO = new RC_PRDTINFSVO();
        calNow = Calendar.getInstance();
        calNow.add(Calendar.DAY_OF_MONTH, 1);
        rcPrdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
        rcPrdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
        rcPrdtSVO.setsFromTm("1200");
        calNow.add(Calendar.DAY_OF_MONTH, 1);
        rcPrdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
        rcPrdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
        rcPrdtSVO.setsToTm("1200");
        rcPrdtSVO.setSearchWord(search);
        /*Integer rcCnt = webRcProductService.selectWebRcPrdtListCnt(rcPrdtSVO);*/

        WEB_SPSVO spPrdtSVO = new WEB_SPSVO();
        spPrdtSVO.setsCtgrDepth("1");
        spPrdtSVO.setsCtgr(Constant.CATEGORY_PACKAGE);
        spPrdtSVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE);
        spPrdtSVO.setsCtgrDepth("1");
        spPrdtSVO.setSearchWord(search);
        int packageCnt = webSpService.getCntProductList(spPrdtSVO);

        spPrdtSVO = new WEB_SPSVO();
        spPrdtSVO.setsCtgrDepth("1");
        spPrdtSVO.setsCtgr(Constant.CATEGORY_TOUR);
        spPrdtSVO.setsCtgrDiv(Constant.CATEGORY_TOUR);
        spPrdtSVO.setsCtgrDepth("1");
        spPrdtSVO.setSearchWord(search);
        int tourCnt = webSpService.getCntProductList(spPrdtSVO);

        spPrdtSVO = new WEB_SPSVO();
        spPrdtSVO.setsCtgrDepth("1");
        spPrdtSVO.setsCtgr(Constant.CATEGORY_ETC);
        spPrdtSVO.setsCtgrDiv(Constant.CATEGORY_ETC);
        spPrdtSVO.setsCtgrDepth("1");
        spPrdtSVO.setSearchWord(search);
        int foodCnt = webSpService.getCntProductList(spPrdtSVO);

        spPrdtSVO = new WEB_SPSVO();
        spPrdtSVO.setsCtgrDepth("1");
        spPrdtSVO.setsCtgr(Constant.CATEGORY_BABY_SHEET);
        spPrdtSVO.setsCtgrDiv(Constant.CATEGORY_BABY_SHEET);
        spPrdtSVO.setsCtgrDepth("1");
        spPrdtSVO.setSearchWord(search);
        int strollerCnt = webSpService.getCntProductList(spPrdtSVO);

        WEB_SVSVO svPrdtSVO = new WEB_SVSVO();
        svPrdtSVO.setSearchWord(search);
        int svCnt = webSvService.getCntProductList(svPrdtSVO);

        //코드 정보 얻기
        List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
        model.addAttribute("cdAdar", cdAdar);

        model.addAttribute("search", search);
        model.addAttribute("adCnt", adCnt);
        model.addAttribute("adSearch", adPrdtSVO);
        model.addAttribute("rcCnt", 0);
        model.addAttribute("rcSearch", rcPrdtSVO);
        model.addAttribute("packageCnt", packageCnt);
        model.addAttribute("tourCnt", tourCnt);
        model.addAttribute("foodCnt", foodCnt);
        model.addAttribute("svCnt", svCnt);
        model.addAttribute("strollerCnt", strollerCnt);

        model.addAttribute("nowDate", String.format("%d%02d%02d",
            calNow.get(Calendar.YEAR),
            calNow.get(Calendar.MONTH) + 1,
            calNow.get(Calendar.DAY_OF_MONTH) + 1));

        return "/mw/cmm/cerca";
    }

    /*@RequestMapping("/mw/kwaSearch.do")
    public String kwaSearch(HttpServletRequest request,
                            ModelMap model) {

        String kwaNum = request.getParameter("kwaNum");

        if (EgovStringUtil.isEmpty(kwaNum)) {
            log.error("kwaNum is null");
            return "redirect:/mw/main.do";
        }
        //키워드 정보
        KWAVO kwaVO = new KWAVO();
        kwaVO.setKwaNum(kwaNum);

        KWAVO kwaVORes = ossKwaService.selectKwa(kwaVO);

        model.addAttribute("KWAVO", kwaVORes);

        int nPrdtSum = 0;

        //숙소
        List<AD_WEBLISTVO> kwaprdtListAD = webAdProductService.selectAdListOssKwa(kwaNum);

        model.addAttribute("kwaprdtListAD", kwaprdtListAD);

        nPrdtSum += kwaprdtListAD.size();

        //랜트카
        List<RC_PRDTINFVO> resultRcList = webRcProductService.selectWebRcPrdtListOssKwa(kwaNum);

        RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
        Calendar calNow = Calendar.getInstance();
        calNow.add(Calendar.DAY_OF_MONTH, 1);
        prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
        prdtSVO.setsFromTm("0900");

        calNow.add(Calendar.DAY_OF_MONTH, 1);
        prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
        prdtSVO.setsToTm("0900");

        for (int i = 0; i < resultRcList.size(); i++) {
            RC_PRDTINFVO prdtInfVO = resultRcList.get(i);
            RC_PRDTINFSVO chkVO = prdtSVO;
            chkVO.setsPrdtNum(prdtInfVO.getPrdtNum());

            // 예약가능여부 확인
            RC_PRDTINFVO ableVO = webRcProductService.selectRcAble(chkVO);

            prdtInfVO.setAbleYn(ableVO.getAbleYn());

            resultRcList.set(i, prdtInfVO);
        }

        model.addAttribute("kwaprdtListRC", resultRcList);
        nPrdtSum += resultRcList.size();

        //소셜
        WEB_SPSVO spWebSVO = new WEB_SPSVO();
        spWebSVO.setKwaNum(kwaNum);

        spWebSVO.setCtgr("C100");
        List<WEB_SPPRDTVO> resultSpListC100 = webSpService.selectProductListOssKwa(spWebSVO);
        model.addAttribute("kwaprdtListSPC100", resultSpListC100);
        nPrdtSum += resultSpListC100.size();


        spWebSVO.setCtgr("C200");
        List<WEB_SPPRDTVO> resultSpListC200 = webSpService.selectProductListOssKwa(spWebSVO);
        model.addAttribute("kwaprdtListSPC200", resultSpListC200);
        nPrdtSum += resultSpListC200.size();

        spWebSVO.setCtgr("C300");
        List<WEB_SPPRDTVO> resultSpListC300 = webSpService.selectProductListOssKwa(spWebSVO);
        model.addAttribute("kwaprdtListSPC300", resultSpListC300);
        nPrdtSum += resultSpListC300.size();
        spWebSVO.setCtgr("C500");
        List<WEB_SPPRDTVO> resultSpListC500 = webSpService.selectProductListOssKwa(spWebSVO);
        model.addAttribute("kwaprdtListSPC500", resultSpListC500);
        nPrdtSum += resultSpListC500.size();

        // 관광기념품
        List<WEB_SVPRDTVO> resultSvList = webSvService.selectProductListOssKwa(kwaNum);
        model.addAttribute("kwaprdtListSV", resultSvList);
        nPrdtSum += resultSvList.size();


        model.addAttribute("prdtSum", nPrdtSum);

        return "/mw/cmm/kwaSearch";
    }*/

    /**
     * 모바일 메인 관광지 조회
     * 파일명 : mainCoup
     * 작성일 : 2016. 6. 17. 오후 1:34:43
     * 작성자 : 최영철
     *
     * @return
     */
    @RequestMapping("/mw/mainCoup.ajax")
    public ModelAndView mainCoup() {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<MAINPRDTVO> prdtList = new ArrayList<MAINPRDTVO>();
        // 관광지 입장권
        prdtList = webMainService.selectMwMain08();
        resultMap.put("dataList", prdtList);

        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /**
     * 모바일 메인 레져 조회
     * 파일명 : mainLei
     * 작성일 : 2016. 6. 17. 오후 1:44:54
     * 작성자 : 최영철
     *
     * @return
     */
    @RequestMapping("/mw/mainLei.ajax")
    public ModelAndView mainLei() {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<MAINPRDTVO> prdtList = new ArrayList<MAINPRDTVO>();
        // 레저
        prdtList = webMainService.selectMain15();
        resultMap.put("dataList", prdtList);

        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /**
     * 모바일 메인 음식 조회
     * 파일명 : mainFood
     * 작성일 : 2016. 6. 17. 오후 1:44:54
     * 작성자 : 최영철
     *
     * @return
     */
    @RequestMapping("/mw/mainFood.ajax")
    public ModelAndView mainFood() {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<MAINPRDTVO> prdtList = new ArrayList<MAINPRDTVO>();
        // 레저
        prdtList = webMainService.selectMwMain06();
        resultMap.put("dataList", prdtList);

        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /**
     * 모바일 메인 뷰티 조회
     * 파일명 : mainBeauty
     * 작성일 : 2016. 6. 17. 오후 1:44:54
     * 작성자 : 최영철
     *
     * @return
     */
    @RequestMapping("/mw/mainBeauty.ajax")
    public ModelAndView mainBeauty() {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<MAINPRDTVO> prdtList = new ArrayList<MAINPRDTVO>();
        // 레저
        prdtList = webMainService.selectMwMain07();
        resultMap.put("dataList", prdtList);

        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    @RequestMapping("/mw/order/orderTamnacard.do")
    public String orderTamnacard(HttpServletRequest request,
                                 ModelMap model) {
        String tamnacardLinkUrl = request.getParameter("tamnacardLinkUrl");
        model.addAttribute("tamnacardLinkUrl", tamnacardLinkUrl);
        return "/mw/order/orderTamnacard";
    }
}
