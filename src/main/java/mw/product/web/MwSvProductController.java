package mw.product.web;

import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.prmt.service.MasPrmtService;
import mas.prmt.vo.MAINPRMTVO;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.sv.service.MasSvService;
import mas.sv.vo.*;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import oss.ad.vo.AD_WEBLISTSVO;
import oss.ad.vo.AD_WEBLISTVO;
import oss.benner.service.OssBannerService;
import oss.benner.vo.BANNERVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.service.OssMailService;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_DTLIMGVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPSVO;
import oss.coupon.vo.CPVO;
import oss.env.service.OssSiteManageService;
import oss.env.vo.DFTINFVO;
import oss.marketing.serive.OssAdmRcmdService;
import oss.marketing.serive.OssKwaService;
import oss.marketing.vo.KWASVO;
import oss.point.service.OssPointService;
import oss.point.vo.POINT_CORPVO;
import oss.site.service.OssCrtnService;
import oss.site.service.OssMainConfigService;
import oss.site.vo.MAINBRANDSETDVO;
import oss.site.vo.MAINCTGRRCMDVO;
import oss.site.vo.SVCRTNPRDTVO;
import oss.site.vo.SVCRTNVO;
import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.GPAANLSVO;
import oss.user.vo.USERVO;
import web.main.service.WebMainService;
import web.main.vo.MAINPRDTVO;
import web.mypage.service.WebMypageService;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.POCKETVO;
import web.mypage.vo.USER_CPVO;
import web.product.service.WebPrdtInqService;
import web.product.service.WebPrmtService;
import web.product.service.WebRcProductService;
import web.product.service.WebSvProductService;
import web.product.vo.PRDTINQVO;
import web.product.vo.WEB_SVPRDTVO;
import web.product.vo.WEB_SVSVO;
import web.product.vo.WEB_SV_DTLPRDTVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class MwSvProductController {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "webSvService")
	protected WebSvProductService webSvService;

	@Resource(name = "ossMailService")
	protected OssMailService ossMailService;

	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;

	@Resource(name = "masSvService")
	private MasSvService masSvService;

	@Resource(name = "OssAdmRcmdService")
	protected OssAdmRcmdService ossAdmRcmdService;

	@Resource(name = "ossSiteManageService")
	protected OssSiteManageService ossSiteManageService;

	@Resource(name = "webPrdtInqService")
	protected WebPrdtInqService webPrdtInqService;
	
	@Resource(name = "masPrmtService")
	private MasPrmtService masPrmtService;
	
	@Resource(name = "ossCrtnService")
	protected OssCrtnService ossCrtnService;
	
	@Resource(name="ossKwaService")
	private OssKwaService ossKwaService;
	
	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;
	
	@Resource(name = "ossCouponService")
	protected OssCouponService ossCouponService;
	
	@Resource(name = "webPrmtService")
	protected WebPrmtService webPrmtService;

	@Resource(name = "webUserCpService")
	protected WebUserCpService webUserCpService;

	@Resource(name = "webMainService")
    private WebMainService webMainService;

	@Resource(name="ossMainConfigService")
	private OssMainConfigService ossMainConfigService;

	@Resource(name="ossBannerService")
	private OssBannerService ossBannerService;

	@Autowired
	private OssPointService ossPointService;
	
	@Resource(name="ossUesepliService")
	private OssUesepliService ossUesepliService;	
	
	/**
     * 관광기념품 메인
     * @param searchVO
     * @param model
     * @return
     */
    @RequestMapping("/mw/sv/mainList.do")
    public String mainList(@ModelAttribute("searchVO") WEB_SVSVO searchVO,
						   ModelMap model) {
    	log.info("/mw/sv/mainList.do");
    	
    	// 카테고리별 추천상품 SV
    	MAINCTGRRCMDVO mainctgrrcmdVO = new MAINCTGRRCMDVO();
		mainctgrrcmdVO.setPrdtDiv("SV");
		List<MAINCTGRRCMDVO> mainCtgrRcmdList = webMainService.selectMainCtgrRcmdList(mainctgrrcmdVO);		
		model.addAttribute("mainCtgrRcmdList", mainCtgrRcmdList);
		
    	// 카테고리 탭 상품 갯수 설정.
    	searchVO.setsCtgrDiv(Constant.SV_DIV);

		List<WEB_SVPRDTVO> cntCtgrPrdtList = webSvService.selectSvPrdtCntList(searchVO);
		model.addAttribute("cntCtgrPrdtList", cntCtgrPrdtList);
		
		// 서브 카테고리
		Map<String, List<CDVO>> subCtgrMap = webSvService.getSvSubCategory(searchVO);
		model.addAttribute("subCtgrMap", subCtgrMap);
    	
    	// 이벤트 
    	MAINPRMTVO mainPrmtVO = new MAINPRMTVO();

    	List<MAINPRMTVO> mainPrmtList = masPrmtService.selectSvPrmtWeb(mainPrmtVO);
    	model.addAttribute("prmtList", mainPrmtList);
    	
    	// 큐레이션 리스트
    	List<SVCRTNVO> crtnList = ossCrtnService.selectCrtnWebList();
    	model.addAttribute("crtnList", crtnList);
    	
    	// 큐페이션별 상품 리스트
    	Map<String, List<SVCRTNPRDTVO>> crtnPrdtMap = ossCrtnService.selectCrtnPrdtWebList();
    	model.addAttribute("crtnPrdtMap", crtnPrdtMap);    	
    	
    	// 해쉬태그
		//2023.07.10 주석처리 chaewan.jung
//    	KWASVO kwaSVO = new KWASVO();
//    	kwaSVO.setsCorpCd("SV");
//		kwaSVO.setSlocation("KW07");
//		kwaSVO.setCnt("10");
//		model.addAttribute("kwaList", ossKwaService.selectKwaWebPrdtList(kwaSVO));
    	
    	// 찜하기 정보 (2017-11-24, By JDongS)    	
    	POCKETVO pocket = new POCKETVO();
    	Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();
    	USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

    	if(userVO != null) {
    		pocket.setUserId(userVO.getUserId());
        	pocket.setPrdtDiv(Constant.SV);

        	pocketMap = webMypageService.selectPocketList(pocket);
    	}   
    	model.addAttribute("pocketMap", pocketMap);
    	
    	//특산/기념품 카테고리 브랜드 조회
    	searchVO.setsCorpCd(Constant.SV);
    	List<WEB_SVPRDTVO> brandPrdtList = webSvService.selectBrandPrdtList(searchVO);
    	model.addAttribute("brandPrdtList", brandPrdtList);
    	
    	return "mw/sv/mainList";
    }
    
    /**
     * 관광기념품 큐레이션 상세
     * @param searchVO
     * @param model
     * @return
     */
    @RequestMapping("/mw/sv/crtnList.do")
    public String crtnList(@ModelAttribute("searchVO") SVCRTNVO searchVO, ModelMap model) {
    	log.info("/web/sv/crtnList.do");
    	
    	// 큐레이션 정보
    	SVCRTNVO crtnInfo = ossCrtnService.selectByCrtn(searchVO);
    	model.addAttribute("crtnInfo", crtnInfo);
    	
    	// 큐레이션 리스트
    	List<SVCRTNVO> crtnList = ossCrtnService.selectCrtnWebList();
    	model.addAttribute("crtnList", crtnList);
    	
    	//카테고리 리스트
    	WEB_SVSVO searchVO_2 = new WEB_SVSVO();
    	searchVO_2.setsCtgrDiv(Constant.SV_DIV);
    	List<WEB_SVPRDTVO> cntCtgrPrdtList = webSvService.selectSvPrdtCntList(searchVO_2);
    	model.addAttribute("cntCtgrPrdtList", cntCtgrPrdtList);
    	
    	//특산/기념품 카테고리 브랜드 조회
    	searchVO_2.setsCorpCd(Constant.SV);
    	List<WEB_SVPRDTVO> brandPrdtList = webSvService.selectBrandPrdtList(searchVO_2);
    	model.addAttribute("brandPrdtList", brandPrdtList);    	
    	
    	return "mw/sv/crtnList";
    }

    /**
     * 관광기념품 상품 리스트
     * @param searchVO
     * @param model
     * @return
     */
    @RequestMapping("/mw/sv/productList.do")
    public String productList(@ModelAttribute("searchVO") WEB_SVSVO searchVO,
							  ModelMap model) {
    	log.info("/mw/sv/productList.do");

    	// 카테고리 탭 상품 갯수 설정.
    	searchVO.setsCtgrDiv(Constant.SV_DIV);

		List<WEB_SVPRDTVO> cntCtgrPrdtList = webSvService.selectSvPrdtCntList(searchVO);

		int totalCnt = 0;
		for(WEB_SVPRDTVO prdt : cntCtgrPrdtList) {
			totalCnt += Integer.parseInt(prdt.getPrdtCount());
		}
		// 서브 카테고리
		Map<String, List<CDVO>> subCtgrMap = webSvService.getSvSubCategory(searchVO);

		if(EgovStringUtil.isEmpty(searchVO.getOrderCd())){
			// 기본정보 조회
    		DFTINFVO dftInf = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);

    		searchVO.setOrderCd(dftInf.getSvSortStd());
		}
    	// 베스트 상품.
    //	List<WEB_SVPRDTVO> bestProductList = webSvService.selectBestProductList();

    	//**이벤트 *******************************************
    	MAINPRMTVO mainPrmtVO = new MAINPRMTVO();

    	List<MAINPRMTVO> mainPrmtList = masPrmtService.selectSvPrmt(mainPrmtVO);
    	model.addAttribute("prmtList", mainPrmtList);

    	model.addAttribute("subCtgrMap", subCtgrMap);
    	model.addAttribute("cntCtgrPrdtList", cntCtgrPrdtList);
    	model.addAttribute("totalCnt", totalCnt);
    //	model.addAttribute("bestProductList", bestProductList);

    	// 큐레이션 리스트
    	List<SVCRTNVO> crtnList = ossCrtnService.selectCrtnWebList();
    	model.addAttribute("crtnList", crtnList);
    	
    	//특산/기념품 카테고리 브랜드 조회
    	searchVO.setsCorpCd(Constant.SV);
    	List<WEB_SVPRDTVO> brandPrdtList = webSvService.selectBrandPrdtList(searchVO);
    	model.addAttribute("brandPrdtList", brandPrdtList);
    	
    	return "mw/sv/productList";
    }
    /**
     * 기념품 리스트(ajax)
     * @param searchVO
     * @param model
     * @return
     */
    @RequestMapping("/mw/sv/productList.ajax")
    public String productListAjax(@ModelAttribute("searchVO") WEB_SVSVO searchVO,
    		HttpServletRequest request,
    		ModelMap model) {
    	log.info("/mw/sv/productList.ajax");

    	//searchVO.setPageUnit(propertiesService.getInt("webPageUnit"));
    	searchVO.setPageUnit(12);
    	searchVO.setPageSize(propertiesService.getInt("webPageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// 상품 리스트
		Map<String, Object> resultMap = webSvService.selectProductList(searchVO);

		@SuppressWarnings("unchecked")
		List<WEB_SVPRDTVO> resultList = (List<WEB_SVPRDTVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("totSch", request.getParameter("totSch"));
		
		// 찜하기 정보 (2017-11-24, By JDongS)    	
    	POCKETVO pocket = new POCKETVO();
    	Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();
    	USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	if (userVO != null) {
    		pocket.setUserId(userVO.getUserId());
        	pocket.setPrdtDiv(Constant.SV);
        	pocketMap = webMypageService.selectPocketList(pocket);
    	}   
    	model.addAttribute("pocketMap", pocketMap);
 
   		return "mw/sv/productAjax";
    }

	@RequestMapping("/mw/sv/detailPrdt.do")
	public String detailPrdt(@ModelAttribute("searchVO")WEB_SVSVO searchVO,
							 @ModelAttribute("prdtVO") WEB_SV_DTLPRDTVO prdtVO,
							 HttpServletRequest request,
							 ModelMap model) throws ParseException {
		log.info("/mw/sv/detailPrdt.do call");

		String prdtNum = prdtVO.getPrdtNum();

		if(EgovStringUtil.isEmpty(prdtNum)) {
    		log.error("MW SV : prdtNum is null");
    		return "redirect:/mw/sv/productList.do";
    	}

    	// 상품 정보 가져오기.
    	WEB_SV_DTLPRDTVO prdtInfo =  webSvService.selectByPrdt(prdtVO);

    	if(prdtInfo == null ) {
    		log.error("prdtInfo is null");
			return "redirect:/mw/sv/productList.do";
    	}

    	// 상품 이미지 가져오기.
    	CM_IMGVO imgVO = new CM_IMGVO();
    	imgVO.setLinkNum(prdtNum);

    	List<CM_IMGVO> prdtImg = ossCmmService.selectImgList(imgVO);

    	// 상세 이미지 가져오기.
    	CM_DTLIMGVO dtlImgVO = new CM_DTLIMGVO();
    	dtlImgVO.setLinkNum(prdtNum);
    	dtlImgVO.setPcImgYn("N");

    	List<CM_DTLIMGVO> dtlImg = ossCmmService.selectDtlImgList(dtlImgVO);
    	
    	// 판매처 다른 상품보기
    	String corpId = prdtInfo.getCorpId();
		String prdc = prdtInfo.getPrdc();
    	List<WEB_SVPRDTVO> otherProductList = webSvService.selectOtherProductList(corpId, prdc);
    	model.addAttribute("otherProductList", otherProductList);

    	// 모바일 이미지 없으면 PC 이미지로 가져오기.
    	if(dtlImg == null || dtlImg.size() == 0) {
    		dtlImgVO = new CM_DTLIMGVO();
	    	dtlImgVO.setLinkNum(prdtNum);
	    	dtlImgVO.setPcImgYn("Y");

	    	dtlImg = ossCmmService.selectDtlImgList(dtlImgVO);
    	}

    	// 상품 판매종료일 전 남은 시간 가져오기.(현재시간으로)
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date fromDate = Calendar.getInstance().getTime();
		Date toDate = sdf.parse(prdtInfo.getSaleEndDt() + "2359");

		long difDay = OssCmmUtil.getDifDay(fromDate, toDate);
		long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) - (difDay * 24 * 3600);

		// 상품 추가 옵션 가져오기.
		SV_ADDOPTINFVO sv_ADDOPTINFVO = new SV_ADDOPTINFVO();
		sv_ADDOPTINFVO.setPrdtNum(prdtNum);
		List<SV_ADDOPTINFVO> addOptList = masSvService.selectPrdtAddOptionList(sv_ADDOPTINFVO);

		// 배송 정보 가져오기.
		SV_CORPDLVAMTVO corpDlvAmtVO = masSvService.selectCorpDlvAmt(prdtInfo.getCorpId());

		// 업체정보 가져오기.
		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(prdtInfo.getCorpId());

		CORPVO corpInfo = ossCorpService.selectCorpByCorpId(corpVO);

		if(StringUtils.isNotEmpty(prdtInfo.getOrg())) {
			prdtInfo.setOrg(EgovStringUtil.checkHtmlView(prdtInfo.getOrg()));
		}
		if(StringUtils.isNotEmpty(prdtInfo.getHdlPrct())) {
			prdtInfo.setHdlPrct(EgovStringUtil.checkHtmlView(prdtInfo.getHdlPrct()));
		}
		if(StringUtils.isNotEmpty(prdtInfo.getDlvGuide())) {
			prdtInfo.setDlvGuide(EgovStringUtil.checkHtmlView(prdtInfo.getDlvGuide()));
		}
		if(StringUtils.isNotEmpty(prdtInfo.getCancelGuide())) {
			prdtInfo.setCancelGuide(EgovStringUtil.checkHtmlView(prdtInfo.getCancelGuide()));
		}
		if(StringUtils.isNotEmpty(prdtInfo.getTkbkGuide())) {
			prdtInfo.setTkbkGuide(EgovStringUtil.checkHtmlView(prdtInfo.getTkbkGuide()));
		}

		if("Y".equals( prdtInfo.getDirectRecvYn())) {
			//직접수령 위치 가지고오기
			SV_DFTINFVO sv_DFTINFVO = new SV_DFTINFVO();
			sv_DFTINFVO.setCorpId(prdtInfo.getCorpId());

			SV_DFTINFVO resultVO = masSvService.selectBySvDftinf(sv_DFTINFVO);
			model.addAttribute("svDftinfo", resultVO);
		}


		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	// 사용 가능 쿠폰 리스트
		CPSVO cpsVO = new CPSVO();
		cpsVO.setsPrdtNum(prdtVO.getPrdtNum());

		List<CPVO> couponList = ossCouponService.selectCouponListWeb(cpsVO);

		model.addAttribute("couponList", couponList);

		// 사용자 쿠폰 정보
		Map<String, USER_CPVO> userCpMap = new HashMap<String, USER_CPVO>();

		if(userVO != null) {
			String userId = userVO.getUserId();

			for(CPVO cpVO : couponList) {
				String cpId = cpVO.getCpId();

				USER_CPVO userCpVO = new USER_CPVO();
				userCpVO.setCpId(cpId);
				userCpVO.setUserId(userId);

				USER_CPVO resultUserCpVO = webUserCpService.selectUserCpByCpIdUserId(userCpVO);

				userCpMap.put(cpId, resultUserCpVO);
			}
		}
		model.addAttribute("userCpMap", userCpMap);
		
		// 관련 프로모션 정보
		PRMTPRDTVO prmtPrdtVO = new PRMTPRDTVO();
		prmtPrdtVO.setCorpId(prdtInfo.getCorpId());
		prmtPrdtVO.setPrdtNum(prdtVO.getPrdtNum());

		List<PRMTVO> prmtList = webPrmtService.selectDeteilPromotionList(prmtPrdtVO);
		model.addAttribute("prmtList", prmtList);
    	
    	// 찜하기 정보 (2017-11-24, By JDongS)
    	int pocketCnt = 0;
    	POCKETVO pocket = new POCKETVO();
    	Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();
    	Map<String, POCKETVO> pocketMapCnt = new HashMap<String, POCKETVO>();

    	if (userVO != null) {
    		pocket.setUserId(userVO.getUserId());

    		pocketMap = webMypageService.selectPocketList(pocket);
    		
        	pocket.setPrdtDiv(Constant.SV);
        	pocket.setCorpId(prdtInfo.getCorpId());
        	pocket.setPrdtNum(prdtInfo.getPrdtNum());

        	pocketMapCnt = webMypageService.selectPocketList(pocket);
        	
        	pocketCnt = pocketMapCnt.size();
    	}   
    	model.addAttribute("pocketMap", pocketMap);
    	model.addAttribute("pocketCnt", pocketCnt);

		model.addAttribute("difTime", difTime);
		model.addAttribute("difDay", difDay);
		model.addAttribute("prdtInfo", prdtInfo);
		model.addAttribute("prdtImg", prdtImg);
		model.addAttribute("dtlImg", dtlImg);
		model.addAttribute("addOptList", addOptList);
		model.addAttribute("corpDlvAmtVO", corpDlvAmtVO);
		model.addAttribute("corpInfo", corpInfo);
		
		//구조화된 리뷰 스니펫
		GPAANLSVO gpaVO = new GPAANLSVO();
		gpaVO.setsPrdtNum(prdtNum);
		gpaVO.setLinkNum(prdtNum);
		GPAANLSVO gpaVORes = ossUesepliService.selectByGpaanls(gpaVO);
		model.addAttribute("gpaVO", gpaVORes);
				
		/** 포인트 구매 필터 적용*/
		POINT_CORPVO pointCorpVO = new POINT_CORPVO();
		pointCorpVO.setCorpId(corpId);
		pointCorpVO.setPartnerCode((String) request.getSession().getAttribute("ssPartnerCode"));
		String chkPointBuyAble = ossPointService.chkPointBuyAble(pointCorpVO);
		model.addAttribute("chkPointBuyAble", chkPointBuyAble);

		return "/mw/sv/detailPrdt";
	}

		/**
	     * 상품 구분자 정보가져오기
	     * @param sv_DIVINFVO
	     * @return
	     */
	    @RequestMapping("/mw/sv/getDivInfList.ajax")
	    public ModelAndView getDivInfList(@ModelAttribute("SV_DIVINFVO") SV_DIVINFVO sv_DIVINFVO) {
	    	log.info("/mw/sv/getDivInfList.ajax:");

	    	Map<String, Object> resultMap = new HashMap<String,Object>();
	    	List<SV_DIVINFVO> spDivInfList = webSvService.selectDivInfList(sv_DIVINFVO);

	    	resultMap.put("list", spDivInfList);
			ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

			return modelAndView;
	    }

		@RequestMapping("/mw/sv/getOptionList.ajax")
		public ModelAndView getOptionList(@ModelAttribute("SV_OPTINFVO") SV_OPTINFVO sv_OPTINFVO) {
	    	log.info("/mw/sv/getOptionList.ajax:");

	    	Map<String, Object> resultMap = new HashMap<String,Object>();
	    	List<SV_OPTINFVO> optionList = webSvService.selectOptionList(sv_OPTINFVO);

	    	resultMap.put("list", optionList);
			ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

			return modelAndView;
	    }
		
	    /**
	     * 제주특산/기념품 업체 페이지
	     * Function : corpPrdt
	     * 작성일 : 2017. 12. 4. 오후 10:19:15
	     * 작성자 : 정동수
	     * @param searchVO
	     * @param prdtVO
	     * @param model
	     * @return
	     */
	    @RequestMapping("/mw/sv/corpPrdt.do")
	    public String corpPrdt(@ModelAttribute("searchVO") WEB_SVSVO searchVO,
							   @ModelAttribute("prdtVO") RC_PRDTINFVO prdtVO,
							   ModelMap model) {

	    	if(EgovStringUtil.isEmpty(searchVO.getsCorpId())){
	    		return "redirect:/mw/sv/productList.do";
	    	}
	    	// 추천순 정렬
	    	searchVO.setOrderCd(Constant.ORDER_GPA);
	    	
	    	// 업체 정보
	    	CORPVO corpSVO = new CORPVO();
	    	corpSVO.setCorpId(searchVO.getsCorpId());

	    	CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
	    	//업체가 승인중이 아닐때 오류 페이지로
	    	if(Constant.TRADE_STATUS_APPR.equals(corpVO.getTradeStatusCd()) == false){
	    		return "redirect:/mw/cmm/error.do?errCord=PRDT01";
	    	}
	    	model.addAttribute("corpVO", corpVO);
	    	
	    	// 업체 추가 정보
	    	SV_DFTINFVO sv_DFTINFVO = new SV_DFTINFVO();
	    	sv_DFTINFVO.setCorpId(searchVO.getsCorpId());

	    	SV_DFTINFVO svDftInfo = masSvService.selectBySvDftinf(sv_DFTINFVO);
	    	model.addAttribute("svDftInfo", svDftInfo);
	    	
	    	return "/mw/sv/corpPrdt";
	    }


	@RequestMapping("/mw/sv/intro.do")
	public String oldIntro() {
    	return "forward:/mw/goods/jeju.do";
	}

	@RequestMapping("/mw/goods/jeju.do")
	public String svIntro(ModelMap model) {
		//메인배너
		BANNERVO bannerVO = new BANNERVO();
		bannerVO.setLocation("BN08");
		//List<BANNERVO> bannerTop = ossBannerService.selectBannerList(bannerVO);
		List<BANNERVO> bannerTop = ossBannerService.selectBannerListWebByPrintSn(bannerVO);
		model.addAttribute("bannerTop", bannerTop);

		//띠배너
		bannerVO.setLocation("BN09");
		List<BANNERVO> bannerLine = ossBannerService.selectBannerList(bannerVO);
		model.addAttribute("bannerLine", bannerLine);

		// HOT! 카테고리별 추천상품
		MAINCTGRRCMDVO mainctgrrcmdVO = new MAINCTGRRCMDVO();
		mainctgrrcmdVO.setPrdtDiv("SV");
		List<MAINCTGRRCMDVO> mainCtgrRcmdList = webMainService.selectMainCtgrRcmdList(mainctgrrcmdVO);
		model.addAttribute("mainCtgrRcmdList", mainCtgrRcmdList);

		// 테마 추천 상품 Title
		List<SVCRTNVO> crtnList = ossCrtnService.selectCrtnWebList();
		Collections.shuffle(crtnList);
		model.addAttribute("crtnNum", crtnList.get(0).getCrtnNum());
		model.addAttribute("crtnList", crtnList);

		//브랜드관
		List<MAINBRANDSETDVO> mainBrandList = ossMainConfigService.selectBrandSetList();
		model.addAttribute("mainBrandList", mainBrandList);

		//브랜드관 브랜드 이름만 추출
		List<String> arrBrandNm = new ArrayList<>();

		//브랜드관 상품리스트
		Map<String, List<WEB_SVPRDTVO>> arrBrandGoodsList = new HashMap<String, List<WEB_SVPRDTVO>>();
		for (MAINBRANDSETDVO brandInfo: mainBrandList) {
			WEB_SVSVO searchVO = new WEB_SVSVO();
			searchVO.setsCorpId(brandInfo.getCorpId());
			searchVO.setFirstIndex(0);
			searchVO.setLastIndex(4);
			Map<String, Object> resultMap = webSvService.selectProductList(searchVO);
			List<WEB_SVPRDTVO> resultList = (List<WEB_SVPRDTVO>) resultMap.get("resultList");
			arrBrandGoodsList.put(searchVO.getsCorpId(),resultList);

			arrBrandNm.add(brandInfo.getCorpAliasNm());
		}
		model.addAttribute("arrBrandNm", arrBrandNm);
		model.addAttribute("arrBrandGoodsList", arrBrandGoodsList);

		return "mw/sv/intro";
	}

	@RequestMapping("/mw/sv/sixIntro.do")
	public String sixIntro(ModelMap model){

		// 추천 상품 리스트 탑 10개
		MAINCTGRRCMDVO mainctgrrcmdVO = new MAINCTGRRCMDVO();
		List<MAINCTGRRCMDVO> mainCtgrRcmdList = webMainService.selectSixIntroCtgrRcmdList(mainctgrrcmdVO);
		Collections.shuffle(mainCtgrRcmdList);
		model.addAttribute("mainCtgrRcmdList", mainCtgrRcmdList);

		// 테마 추천 상품 Title
		List<CDVO> tsCdList = ossCmmService.selectCode("SVCT");
		Collections.shuffle(tsCdList);
		model.addAttribute("cdNum", tsCdList.get(0).getCdNum());
		model.addAttribute("tsCdList", tsCdList);

		return "/mw/sv/sixIntro";
	}

	@RequestMapping("/mw/sv/sixProductList.ajax")
	public String sixProductListAjax(@ModelAttribute("searchVO") WEB_SVSVO searchVO,
								  HttpServletRequest request,
								  ModelMap model) {
    	log.info("/mw/sv/sixProductList.ajax");

		//Y : 검색 , SV: 특산/기념품 intro, other: productList
		String totSch = request.getParameter("totSch");
		if("Y".equals(totSch)){
			searchVO.setPageUnit(9999);
		}else if ("SV".equals(totSch)){
			searchVO.setPageUnit(8);
		}else{
			searchVO.setPageUnit(20);
		}

		searchVO.setPageSize(propertiesService.getInt("webPageSize"));
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//default value setting
		if ("".equals(searchVO.getsCtgr())){
			searchVO.setsCtgr("SVC1");
		}

		// 상품 리스트
		Map<String, Object> resultMap = webSvService.selectSixProductList(searchVO);
		List<WEB_SVPRDTVO> resultList = (List<WEB_SVPRDTVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("totSch", request.getParameter("totSch"));
		model.addAttribute("prdtDiv", searchVO.getsCtgr().substring(0,2).toLowerCase());

		return "mw/sv/sixProductAjax";
	}

	@RequestMapping("/mw/sv/sixProductList.do")
    public String sixProductList(@ModelAttribute("searchVO") WEB_SVSVO searchVO,
							  ModelMap model) {
//    	log.info("/web/sv/productList.do");
		// 카테고리 탭 상품 갯수 설정.
		searchVO.setsCtgrDiv(Constant.SV_DIV);

		List<WEB_SVPRDTVO> cntCtgrPrdtList = webSvService.selectSvPrdtCntList(searchVO);

		int totalCnt = 0;

		List<CDVO> tsCdList = ossCmmService.selectCode("SVCT");
		List<CDVO> spCdList = ossCmmService.selectCode("SPCT");
		tsCdList.addAll(spCdList);

		model.addAttribute("tsCdList", tsCdList);

		if(EgovStringUtil.isEmpty(searchVO.getOrderCd())) {
			// 기본정보 조회
			DFTINFVO dftInf = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);

			searchVO.setOrderCd(dftInf.getSvSortStd());
		}
		// 베스트 상품.
		List<WEB_SVPRDTVO> bestProductList = webSvService.selectBestProductList();
		//**이벤트 *******************************************
		MAINPRMTVO mainPrmtVO = new MAINPRMTVO();

		List<MAINPRMTVO> mainPrmtList = masPrmtService.selectSvPrmt(mainPrmtVO);
		model.addAttribute("prmtList", mainPrmtList);

		//model.addAttribute("subCtgrMap", subCtgrMap);
		model.addAttribute("cntCtgrPrdtList", cntCtgrPrdtList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("bestProductList", bestProductList);

		// 큐레이션 리스트
		List<SVCRTNVO> crtnList = ossCrtnService.selectCrtnWebList();
		model.addAttribute("crtnList", crtnList);

		//특산/기념품 카테고리 브랜드 조회
		searchVO.setsCorpCd(Constant.SV);
		List<WEB_SVPRDTVO> brandPrdtList = webSvService.selectBrandPrdtList(searchVO);
		model.addAttribute("brandPrdtList", brandPrdtList);

    	return "mw/sv/sixProductList";
    }

}
