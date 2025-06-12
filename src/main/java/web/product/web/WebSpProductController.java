package web.product.web;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import api.service.APIService;
import api.vo.ApiNextezPrcAdd;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import mas.sp.service.MasSpService;
import mas.sp.vo.SP_ADDOPTINFVO;
import mas.sp.vo.SP_DIVINFVO;
import mas.sp.vo.SP_DTLINFVO;
import mas.sp.vo.SP_DTLINF_ITEMVO;
import mas.sp.vo.SP_GUIDINFOVO;
import mas.sp.vo.SP_OPTINFVO;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.ad.vo.AD_WEBLISTVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.service.OssMailService;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_DTLIMGVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPRCMDVO;
import oss.corp.vo.CORPVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPSVO;
import oss.coupon.vo.CPVO;
import oss.env.service.OssSiteManageService;
import oss.env.vo.DFTINFVO;
import oss.marketing.serive.OssAdmRcmdService;
import oss.marketing.serive.OssKwaService;
import oss.marketing.vo.ADMRCMDVO;
import oss.marketing.vo.KWASVO;
import oss.point.service.OssPointService;
import oss.point.vo.POINT_CORPVO;
import oss.point.vo.POINT_CPVO;
import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.GPAANLSVO;
import oss.user.vo.USERVO;
import web.mypage.service.WebMypageService;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.POCKETVO;
import web.mypage.vo.USER_CPVO;
import web.order.vo.MRTNVO;
import web.product.service.WebAdProductService;
import web.product.service.WebPrdtInqService;
import web.product.service.WebPrmtService;
import web.product.service.WebSpProductService;
import web.product.vo.WEB_DTLPRDTVO;
import web.product.vo.WEB_SPPRDTVO;
import web.product.vo.WEB_SPSVO;
import web.product.vo.WEB_SP_CALENDARVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @author 최영철
 * @since  2015. 9. 16.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@Controller
public class WebSpProductController {
	@Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name="webAdProductService")
	private WebAdProductService webAdService;

	@Resource(name="ossMailService")
	private OssMailService ossMailService;

	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;

	@Resource(name = "masSpService")
	private MasSpService masSpService;

	@Resource(name = "webPrdtInqService")
	protected WebPrdtInqService webPrdtInqService;

	@Resource(name = "OssAdmRcmdService")
	protected OssAdmRcmdService ossAdmRcmdService;

	@Resource(name = "ossSiteManageService")
	protected OssSiteManageService ossSiteManageService;
	
	@Resource(name="ossKwaService")
	private OssKwaService ossKwaService;
	
	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;
	
	@Resource(name = "ossCouponService")
	protected OssCouponService ossCouponService;
	
	@Resource(name = "webPrmtService")
	protected WebPrmtService webPrmtService;

	@Resource(name="apiService")
	private APIService apiService;

	@Resource(name = "webUserCpService")
	protected WebUserCpService webUserCpService;

	@Autowired
	private OssPointService ossPointService;
	
	@Resource(name="ossUesepliService")
	private OssUesepliService ossUesepliService;	
	
    Logger log = (Logger) LogManager.getLogger(this.getClass());

    /**
     * 패키지 상품 리스트
     * @param searchVO
     * @param model
     * @return
     */
    @RequestMapping("/web/sp/packageList.do")
    public String packageList(@ModelAttribute("searchVO") WEB_SPSVO searchVO, ModelMap model) {
    	log.info("/web/sp/packageList.do");
    	String codeNum ;
    	searchVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE);

    	// 카테고리가 없을 경우 최상위 패키지 상품 코드 셋팅.
    	if(searchVO.getsCtgr() == null) {
    		codeNum = Constant.CATEGORY_PACKAGE;
    		searchVO.setsCtgrDepth("1");
    		searchVO.setsCtgr(codeNum);
    	}

    	if(EgovStringUtil.isEmpty(searchVO.getOrderCd())){
			// 기본정보 조회
    		DFTINFVO dftInf = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);

    		searchVO.setOrderCd(dftInf.getPackSortStd());
		}

    	// 패키지 카테고리 최상위 값 셋팅.
    	codeNum = searchVO.getsCtgr().substring(0,2) + "00";

    	// 카테고리 뎁스
    	if(codeNum.equals(searchVO.getsCtgr())) {
    		searchVO.setsCtgrDepth("1");
    	} else {
    		searchVO.setsCtgrDepth("2");
    	}

		// 검색조건 카테고리 리스트
		/*List<CDVO> categoryList = ossCmmService.selectCode(codeNum);
		if(Constant.CATEGORY_PACKAGE.equals(searchVO.getsCtgr())) {	// 최상위 일 경우 여행사 숙박, 렌터카 추가
			categoryList.addAll(ossCmmService.selectCode("C400"));
		}*/

		// 리스트 탭 카테고리 상품 카운트
		/*List<WEB_SPPRDTVO> cntCtgrPrdtList = webSpService.selectSpPrdtCntList(searchVO);
		int totalCnt = 0;
		for(WEB_SPPRDTVO sp : cntCtgrPrdtList) {
			totalCnt += Integer.parseInt(sp.getPrdtCount());
		}*/

		// 베스트 상품.
		/*List<WEB_SPPRDTVO> bestProductList = null;
    	bestProductList = webSpService.selectBestProductListMng(codeNum);*/
    	/*if(bestProductList == null || bestProductList.size() == 0){
    		//등록된 베스트 상품이 없으면 예전처럼 랜덤하게
    		bestProductList = webSpService.selectBestProductList(codeNum, "1");
    	}*/
    	
    	// 추천 업체
    	/*CORPRCMDVO corpRcmdVO = new CORPRCMDVO();
    	List<CORPRCMDVO> corpRcmdList = ossCorpService.selectCorpRcmdList(corpRcmdVO);
    	model.addAttribute("corpRcmdList", corpRcmdList);*/
    	
    	/*model.addAttribute("categoryList", categoryList);*/
    	/*model.addAttribute("cntCtgrPrdtList", cntCtgrPrdtList);*/
    	/*model.addAttribute("bestProductList", bestProductList);*/
    	/*model.addAttribute("totalCnt", totalCnt);*/
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

    	return "web/sp/packageList";

    }
    
    /**
     * 패키지 상품 리스트(ajax)
     * @param searchVO
     * @param model
     * @return
     */
    @RequestMapping("/web/sp/packageList.ajax")
    public String packageListAjax(@ModelAttribute("searchVO") WEB_SPSVO searchVO,
    			HttpServletRequest request,
    			ModelMap model) {
    	log.info("/web/sp/packageList.ajax");
    	String codeNum ;
    	searchVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE);
    	// 검색조건이 없을 경우 최상위.
    	if(searchVO.getsCtgr() == null || "".equals(searchVO.getsCtgr())) {
    		codeNum = Constant.CATEGORY_PACKAGE;
    		searchVO.setsCtgrDepth("1");
    		searchVO.setsCtgr(codeNum);
    	}

    	codeNum = searchVO.getsCtgr().substring(0,2) + "00";

    	// 카테고리 뎁스 설정.
    	if(codeNum.equals(searchVO.getsCtgr())) {
    		searchVO.setsCtgrDepth("1");
    	} else {
    		searchVO.setsCtgrDepth("2");
    	}

    	//searchVO.setPageUnit(propertiesService.getInt("webPageUnit"));
		String totSch = request.getParameter("totSch");
		if(!"Y".equals(totSch)){
			searchVO.setPageUnit(16);	// 리뉴얼 시 변경
		}else{
			searchVO.setPageUnit(9999);
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

		// 상품 리스트
		Map<String, Object> resultMap = webSpService.selectProductList(searchVO);

		@SuppressWarnings("unchecked")
		List<WEB_SPPRDTVO> resultList = (List<WEB_SPPRDTVO>) resultMap.get("resultList");
		
		// MD's Pick Random 배너
    	ADMRCMDVO admRcmdVO = new ADMRCMDVO();
    	admRcmdVO.setCorpModCd("CSPT");
    //	admRcmdVO.setCorpGubun(Constant.SOCIAL_TOUR);
    	/*List<ADMRCMDVO> mdsPickList = ossAdmRcmdService.selectAdmRcmdWebRandomList(admRcmdVO);
    	model.addAttribute("mdsPickList", mdsPickList);*/

		// 총 건수 셋팅
		/*paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));*/

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("totSch", request.getParameter("totSch"));
		
		// 찜하기 정보 (2017-11-24, By JDongS)    	
    	/*POCKETVO pocket = new POCKETVO();
    	Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();
    	USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	if (userVO != null) {
    		pocket.setUserId(userVO.getUserId());
        	pocket.setPrdtDiv(Constant.SOCIAL);
        	pocketMap = webMypageService.selectPocketList(pocket);
    	}   
    	model.addAttribute("pocketMap", pocketMap);*/

    	return "web/sp/productAjax";
    }

	@RequestMapping("/web/sp/vesselList.do")
	public String vesselList(@ModelAttribute("searchVO") WEB_SPSVO searchVO, 
										HttpServletRequest request,
										ModelMap model) {
		log.info("/web/sp/vesselList.do");
		
    	try {
			if(EgovClntInfo.isMobile(request)) {
				return "redirect:/mw/sp/vesselList.do?sCtgr=C190";
			}
		} catch (Exception e) {
			log.error(e.toString());
		}
    	
		searchVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE_VESSEL);
		return "web/sp/vesselList";
	}

	@RequestMapping("/web/sp/vesselList.ajax")
	public String vesselListListAjax(@ModelAttribute("searchVO") WEB_SPSVO searchVO,
								  HttpServletRequest request,
								  ModelMap model) {
		log.info("/web/sp/vesselList.ajax");
		String codeNum ;
		searchVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE_VESSEL);
		// 검색조건이 없을 경우 최상위.
		if(searchVO.getsCtgr() == null || "".equals(searchVO.getsCtgr())) {
			codeNum = Constant.CATEGORY_PACKAGE_VESSEL;
			searchVO.setsCtgrDepth("1");
			searchVO.setsCtgr(codeNum);
		}

		codeNum = searchVO.getsCtgr().substring(0,2) + "00";

		// 카테고리 뎁스 설정.
		if(codeNum.equals(searchVO.getsCtgr())) {
			searchVO.setsCtgrDepth("1");
		} else {
			searchVO.setsCtgrDepth("2");
		}

		//searchVO.setPageUnit(propertiesService.getInt("webPageUnit"));
		searchVO.setPageUnit(16);	// 리뉴얼 시 변경
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
		Map<String, Object> resultMap = webSpService.selectProductList(searchVO);

		@SuppressWarnings("unchecked")
		List<WEB_SPPRDTVO> resultList = (List<WEB_SPPRDTVO>) resultMap.get("resultList");

		// MD's Pick Random 배너
		ADMRCMDVO admRcmdVO = new ADMRCMDVO();
		admRcmdVO.setCorpModCd("CSPT");
		//	admRcmdVO.setCorpGubun(Constant.SOCIAL_TOUR);
		List<ADMRCMDVO> mdsPickList = ossAdmRcmdService.selectAdmRcmdWebRandomList(admRcmdVO);
		model.addAttribute("mdsPickList", mdsPickList);

		// 총 건수 셋팅
		/*paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));*/

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("totSch", request.getParameter("totSch"));

		// 찜하기 정보 (2017-11-24, By JDongS)
		POCKETVO pocket = new POCKETVO();
		Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (userVO != null) {
			pocket.setUserId(userVO.getUserId());
			pocket.setPrdtDiv(Constant.SOCIAL);
			pocketMap = webMypageService.selectPocketList(pocket);
		}
		model.addAttribute("pocketMap", pocketMap);

		return "web/sp/productAjax";
	}
    
    /**
     * 여행사 상품 업체 페이지
     * Function : corpPrdt
     * 작성일 : 2018. 1. 1. 오전 12:26:49
     * 작성자 : 정동수
     * @param searchVO
     * @param model
     * @return
     */
    @RequestMapping("/web/sp/corpPrdt.do")
    public String corpPrdt(@ModelAttribute("searchVO") WEB_SPSVO searchVO,
    		ModelMap model){
    	if(EgovStringUtil.isEmpty(searchVO.getsCorpId())){
    		return "redirect:/web/sp/corpPrdt.do";
    	}
    	
    	// 추천순 정렬
    	searchVO.setOrderCd(Constant.ORDER_GPA);
    	
    	// 업체 정보
    	CORPVO corpSVO = new CORPVO();
    	corpSVO.setCorpId(searchVO.getsCorpId());
    	CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
    	//업체가 승인중이 아닐때 오류 페이지로
    	if( Constant.TRADE_STATUS_APPR.equals(corpVO.getTradeStatusCd()) == false ){
    		return "redirect:/web/cmm/error.do?errCord=PRDT01";
    	}
    	model.addAttribute("corpVO", corpVO);
    	
    	// 업체 추가 정보
    	/*SP_DFTINFVO sp_DFTINFVO = new SP_DFTINFVO();
    	sp_DFTINFVO.setCorpId(searchVO.getsCorpId());
    	SP_DFTINFVO spDftInfo = masSpService.selectBySpDftinf(sp_DFTINFVO);
    	model.addAttribute("spDftInfo", spDftInfo);*/
    	
    	return "/web/sp/corpPrdt";
    }


	@RequestMapping("/web/sp/productList.do")
	public String oldIntro() {
    	return "redirect:/web/tour/jeju.do";
	}

    @RequestMapping("/web/tour/jeju.do")
    public String spProductList(@ModelAttribute("searchVO") WEB_SPSVO searchVO, ModelMap model, HttpServletRequest request) {
    	log.info("/web/tour/jeju.do");

    	try {
			if(EgovClntInfo.isMobile(request)) {
				return "forward:/mw/tour/jeju.do";
			}
		} catch (Exception e) {
			log.error(e.toString());
		}
    	
		// 카테고리가 없을 경우 최상위 패키지 상품 코드 셋팅.
		String codeNum = searchVO.getsCtgr();
		if(codeNum == null) {
			codeNum = Constant.CATEGORY_TOUR;
			searchVO.setsCtgrDepth("1");
			searchVO.setsCtgr(codeNum);
		} else {
			codeNum = codeNum.substring(0,2) + "00";
		}
    	// 카테고리 설정.
    	if(Constant.CATEGORY_TOUR.equals(codeNum) || Constant.CATEGORY_BACS.equals(codeNum)) {
    		searchVO.setsCtgrDiv(Constant.CATEGORY_TOUR);

    		if(EgovStringUtil.isEmpty(searchVO.getOrderCd())){
    			// 기본정보 조회
        		DFTINFVO dftInf = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);

        		searchVO.setOrderCd(dftInf.getTickSortStd());
    		}
    	} else if (Constant.CATEGORY_ETC.equals(codeNum)) {
    		searchVO.setsCtgrDiv(Constant.CATEGORY_ETC);

    		if(EgovStringUtil.isEmpty(searchVO.getOrderCd())){
    			// 기본정보 조회
        		DFTINFVO dftInf = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);

        		searchVO.setOrderCd(dftInf.getFoodSortStd());
    		}
    	}
    	// 카테고리 뎁스 설정.
    	searchVO.setsCtgrDepth("1");

    	log.info("========" + searchVO.getsCtgrDiv() );

    	// 카테고리 탭 상품 갯수 설정.
		List<WEB_SPPRDTVO> cntCtgrPrdtList = webSpService.selectSpPrdtCntList(searchVO);

    	// 베스트 상품
    	List<WEB_SPPRDTVO> bestProductList = webSpService.selectBestProductListMng(codeNum);

    	if (Constant.CATEGORY_TOUR.equals(searchVO.getsCtgr()) || Constant.CATEGORY_ETC.equals(searchVO.getsCtgr())) {
    		// MD's Pick 리스트
        	ADMRCMDVO admRcmdVO = new ADMRCMDVO();
        	if (Constant.CATEGORY_TOUR.equals(searchVO.getsCtgr())) {
        		admRcmdVO.setCorpModCd("CSPU");
        	} else if (Constant.CATEGORY_ETC.equals(searchVO.getsCtgr())) {
        		admRcmdVO.setCorpModCd("CSPF");
        	}
    	}
    	
    	//코드 정보 얻기
    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
    	model.addAttribute("cdAdar", cdAdar);
    	model.addAttribute("cntCtgrPrdtList", cntCtgrPrdtList);
    	model.addAttribute("bestProductList", bestProductList);    	

    	return "web/sp/productList";
    }
    /**
     * 관광지 입장권 / 레저/음식뷰티 상품 리스트(ajax)
     * @param searchVO
     * @param model
     * @return
     */
    @RequestMapping("/web/sp/productList.ajax")
    public String spProductListAjax(@ModelAttribute("searchVO") WEB_SPSVO searchVO,
    								HttpServletRequest request,
    								ModelMap model) {
    	log.info("/web/sp/productList.ajax");
    	String codeNum = searchVO.getsCtgr();
    	if(Constant.CATEGORY_TOUR.equals(codeNum)) {
    		searchVO.setsCtgrDiv(Constant.CATEGORY_TOUR);
    		searchVO.setCorpSubCd(Constant.SOCIAL_TICK);
    	} else if (Constant.CATEGORY_ETC.equals(codeNum) || Constant.CATEGORY_BACS.equals(codeNum)) {
    		searchVO.setsCtgrDiv(Constant.CATEGORY_ETC);
    		searchVO.setCorpSubCd(Constant.SOCIAL_FOOD);
    	}
		searchVO.setsCtgrDepth("1");


    	//searchVO.setPageUnit(propertiesService.getInt("webPageUnit"));
		if (Constant.CATEGORY_ETC.equals(searchVO.getsCtgr())) {
			searchVO.setPageUnit(32);	// 리뉴얼 시 변경
		}
		else {
			searchVO.setPageUnit(16);	// 리뉴얼 시 변경
		}

		String totSch = request.getParameter("totSch");
		if("Y".equals(totSch)){
			searchVO.setPageUnit(9999);
		}
    	/*searchVO.setPageSize(propertiesService.getInt("webPageSize"));*/

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// 제주지역 다중선택
		if(StringUtils.isNotEmpty(searchVO.getsSpAdar())) {
			String [] spAdar = searchVO.getsSpAdar().split(",");
			
			List<String> spAdarList = new ArrayList<String>();
			for(String sSpAdar:spAdar){				
				spAdarList.add(sSpAdar);
	          }
			searchVO.setSpAdarList(spAdarList);
			searchVO.setsSpAdar("");
		}

		// 상품 리스트
		Map<String, Object> resultMap = webSpService.selectProductList(searchVO);

		@SuppressWarnings("unchecked")
		List<WEB_SPPRDTVO> resultList = (List<WEB_SPPRDTVO>) resultMap.get("resultList");

		/*// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));*/
		
		// MD's Pick Random 배너
    	ADMRCMDVO admRcmdVO = new ADMRCMDVO();
    	
    	if (Constant.CATEGORY_TOUR.equals(searchVO.getsCtgr()))
    		admRcmdVO.setCorpModCd("CSPU");
    	else if (Constant.CATEGORY_ETC.equals(searchVO.getsCtgr()))
    		admRcmdVO.setCorpModCd("CSPF");    	
    	
    //	admRcmdVO.setCorpGubun(searchVO.getCtgr());
    	/*List<ADMRCMDVO> mdsPickList = ossAdmRcmdService.selectAdmRcmdWebRandomList(admRcmdVO);
    	model.addAttribute("mdsPickList", mdsPickList);*/

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("totSch", request.getParameter("totSch"));
		
		// 찜하기 정보 (2017-11-24, By JDongS)    	
    	POCKETVO pocket = new POCKETVO();
    	Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();
    	USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	if (userVO != null) {
    		pocket.setUserId(userVO.getUserId());
        	pocket.setPrdtDiv(Constant.SOCIAL);
        	pocketMap = webMypageService.selectPocketList(pocket);
    	}   
    	model.addAttribute("pocketMap", pocketMap);

		return "web/sp/productAjax";
    }

    /**
     * 상품 상세.
     * @param searchVO
     * @param prdtVO
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping("/web/sp/detailPrdt.do")
    public String detailProduct(@ModelAttribute("searchVO") WEB_SPSVO searchVO,
    		@ModelAttribute("prdtVO") WEB_DTLPRDTVO prdtVO,HttpServletRequest request,
    		ModelMap model) throws Exception {
		log.info("/web/sp/detailPrdt.do call");

    	String prdtNum = prdtVO.getPrdtNum();

		if(EgovClntInfo.isMobile(request)) {
			return "forward:/mw/sp/detailPrdt.do?";
		}
		if(EgovStringUtil.isEmpty(prdtNum)) {
    		log.error("WEB SP : prdtNum is null");
    		return "redirect:/web/tour/jeju.do";
    	}
		// 상품 정보 가져오기.
    	WEB_DTLPRDTVO prdtInfo = webSpService.selectByPrdt(prdtVO);

    	if(prdtInfo == null ) {
    		log.error("prdt is null");
			return "redirect:/web/cmm/error.do?errCord=PRDT01";
    	}

    	// 상품 이미지 가져오기.
    	CM_IMGVO imgVO = new CM_IMGVO();
    	imgVO.setLinkNum(prdtNum);
    	List<CM_IMGVO> prdtImg = ossCmmService.selectImgList(imgVO);

    	// 상세 이미지 가져오기.
    	CM_DTLIMGVO dtlImgVO = new CM_DTLIMGVO();
    	dtlImgVO.setLinkNum(prdtNum);
    	dtlImgVO.setPcImgYn(Constant.FLAG_Y);
    	List<CM_DTLIMGVO> dtlImg = ossCmmService.selectDtlImgList(dtlImgVO);

    	//추가사항:: 상세 정보 가져오기
    	SP_DTLINFVO sp_DTLINFVO = new SP_DTLINFVO();
    	sp_DTLINFVO.setPrdtNum(prdtVO.getPrdtNum());
    	sp_DTLINFVO.setPrintYn("Y");
    	List<SP_DTLINFVO> dtlInfList = masSpService.selectDtlInfList(sp_DTLINFVO);
    	for (SP_DTLINFVO data : dtlInfList) {
    		data.setDtlinfExp(EgovStringUtil.checkHtmlView(data.getDtlinfExp()));
    		data.setItmeEtcViewYn("N");

    		SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO = new SP_DTLINF_ITEMVO();
    		sp_DTLINF_ITEMVO.setPrdtNum(prdtVO.getPrdtNum());
    		sp_DTLINF_ITEMVO.setSpDtlinfNum(data.getSpDtlinfNum());
    		List<SP_DTLINF_ITEMVO> dtlInfItemList = masSpService.selectDtlInfItemList(sp_DTLINF_ITEMVO);

    		for (SP_DTLINF_ITEMVO dataItem : dtlInfItemList) {
    			if(dataItem.getItemEtc() == null || dataItem.getItemEtc().isEmpty() || "".equals(dataItem.getItemEtc()) ){

    			}else{
    				//하나라도 뿌릴게 있으면 뿌린다.
    				data.setItmeEtcViewYn("Y");

    				//변환
    				dataItem.setItemEtc(EgovStringUtil.checkHtmlView( dataItem.getItemEtc() ) );
    			}
			}

    		data.setSpDtlinfItem(dtlInfItemList);

    	}
    	model.addAttribute("dtlInfList", dtlInfList);


		//추가사항:: 안내사항 가져오기
		SP_GUIDINFOVO sp_GUIDINFOVO = new SP_GUIDINFOVO();
		sp_GUIDINFOVO.setPrdtNum(sp_DTLINFVO.getPrdtNum());
		//sp_GUIDINFOVO.setPrintYn("Y");
		SP_GUIDINFOVO sp_GUIDINFOVORes = masSpService.selectGuidinfo(sp_GUIDINFOVO);
		if(sp_GUIDINFOVORes != null){
			if("Y".equals(sp_GUIDINFOVORes.getPrintYn())){
				sp_GUIDINFOVORes.setPrdtExp(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getPrdtExp() ) );
				sp_GUIDINFOVORes.setUseQlfct(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getUseQlfct() ) );
				sp_GUIDINFOVORes.setUseGuide(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getUseGuide() ) );
				sp_GUIDINFOVORes.setCancelRefundGuide(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getCancelRefundGuide() ) );
			}

			//배경색 얻기
			if(!(sp_GUIDINFOVORes.getBgColor()==null || sp_GUIDINFOVORes.getBgColor().isEmpty() || "".equals(sp_GUIDINFOVORes.getBgColor()) ) ){
				model.addAttribute("infoBgColor", sp_GUIDINFOVORes.getBgColor());
			}

		}
		model.addAttribute("SP_GUIDINFOVO", sp_GUIDINFOVORes);


    	// 판매처 다른 상품보기 ( 여행상품일경우)
    	String corpId = prdtInfo.getCorpId();
    	/*List<WEB_SPPRDTVO> otherProductList = null;
    	List<AD_WEBLISTVO> otherAdList = null;
    	if(Constant.SP_PRDT_DIV_TOUR.equals(prdtInfo.getPrdtDiv())) {
    		otherProductList= webSpService.selectOtherProductList(corpId);
    	} else if ("C2".equals(prdtInfo.getCtgr().substring(0, 2))) {
    		otherProductList= webSpService.selectOtherTourList(corpId);
    	} else { // 주변숙소 보기 ( 쿠폰상품 일 경우)
    //		otherAdList = webAdService.selectAdPrdtListDist(prdtInfo.getLat(), prdtInfo.getLon(), 4);
    	}*/

    	// 상품 판매종료일 전 남은 시간 가져오기.(현재시간으로)
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date fromDate = Calendar.getInstance().getTime();
		Date toDate = sdf.parse(prdtInfo.getSaleEndDt()+"2359");

		long difDay = OssCmmUtil.getDifDay(fromDate, toDate);
		long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) - (difDay*24 * 3600);

		// 상품 추가 옵션 가져오기.
		SP_ADDOPTINFVO sp_ADDOPTINFVO = new SP_ADDOPTINFVO();
		sp_ADDOPTINFVO.setPrdtNum(prdtNum);
		List<SP_ADDOPTINFVO> addOptList = masSpService.selectPrdtAddOptionList(sp_ADDOPTINFVO);

		/*log.info(" useQlfct :: " + prdtInfo.getUseQlfct());
		System.out.println(prdtInfo.getSaleAmt());*/
		model.addAttribute("difTime", difTime);
		model.addAttribute("difDay", difDay);
		model.addAttribute("prdtInfo", prdtInfo);
		model.addAttribute("prdtImg", prdtImg);
		model.addAttribute("dtlImg", dtlImg);
		/*model.addAttribute("otherProductList", otherProductList);
		model.addAttribute("otherAdList", otherAdList);*/
		model.addAttribute("addOptList", addOptList);
		
		// 사용 가능 쿠폰 리스트
		CPSVO cpsVO = new CPSVO();
		cpsVO.setsPrdtNum(prdtVO.getPrdtNum());
		List<CPVO> couponList = ossCouponService.selectCouponListWeb(cpsVO);
		model.addAttribute("couponList", couponList);

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
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
        	        	
        	pocket.setPrdtDiv(Constant.SOCIAL);
        	pocket.setCorpId(prdtVO.getCorpId());
        	pocket.setPrdtNum(prdtVO.getPrdtNum());
        	pocketMapCnt = webMypageService.selectPocketList(pocket);
        	
        	pocketCnt = pocketMapCnt.size();
    	}   
    	model.addAttribute("pocketMap", pocketMap);
    	model.addAttribute("pocketCnt", pocketCnt);

    	/** 데이터제공 조회정보 수집*/
        ApiNextezPrcAdd apiNextezPrcAdd = new ApiNextezPrcAdd();
        apiNextezPrcAdd.setvConectDeviceNm("PC");
        apiNextezPrcAdd.setvCtgr("SP");
        apiNextezPrcAdd.setvPrdtNum(prdtVO.getPrdtNum());
        apiNextezPrcAdd.setvType("view");
		apiService.insertNexezData(apiNextezPrcAdd);

		/** 포인트 구매 필터 적용*/
		POINT_CORPVO pointCorpVO = new POINT_CORPVO();
		pointCorpVO.setCorpId(corpId);
		pointCorpVO.setPartnerCode((String) request.getSession().getAttribute("ssPartnerCode"));
		String chkPointBuyAble = ossPointService.chkPointBuyAble(pointCorpVO);
		model.addAttribute("chkPointBuyAble", chkPointBuyAble);
		
		//구조화된 리뷰 스니펫
		GPAANLSVO gpaVO = new GPAANLSVO();
		gpaVO.setsPrdtNum(prdtNum);
		gpaVO.setLinkNum(prdtNum);
		GPAANLSVO gpaVORes = ossUesepliService.selectByGpaanls(gpaVO);
		model.addAttribute("gpaVO", gpaVORes);
				
		/** 마라톤 분기, 티셔츠 수량 체크*/
		String mrtCorpId = prdtInfo.getCorpId();
		if(mrtCorpId != null) {
			if("CSPM".equals(mrtCorpId.substring(0, 4))) {
				MRTNVO mrtnSVO = new MRTNVO();
				mrtnSVO.setCorpId(prdtInfo.getCorpId());
				mrtnSVO.setPrdtNum(prdtInfo.getPrdtNum());
				MRTNVO chkTshirts = webSpService.chkTshirts(mrtnSVO);
				model.addAttribute("chkTshirts", chkTshirts);
				
				return "web/sp/detailMrtProduct";	
			}
		}
		
    	return "web/sp/detailProduct";
    }

    /**
     * 상품 옵션 가져오기
     * @param sp_OPTINFVO
     * @return
     */
    @RequestMapping("/web/sp/getOptionList.ajax")
    public ModelAndView getOptionList(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO) {
    	log.info("/web/sp/getOptionList.ajax:");

    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	List<SP_OPTINFVO> optionList = webSpService.selectOptionList(sp_OPTINFVO);

    	resultMap.put("list", optionList);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
    }

    /**
     * 상품 구분자 정보가져오기
     * @param sp_DIVINFVO
     * @return
     */
    @RequestMapping("/web/sp/getDivInfList.ajax")
    public ModelAndView getDivInfList(@ModelAttribute("SP_DIVINFVO") SP_DIVINFVO sp_DIVINFVO) {
    	log.info("/web/sp/getDivInfList.ajax:");

    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	List<SP_DIVINFVO> spDivInfList = webSpService.selectDivInfList(sp_DIVINFVO);

    	resultMap.put("list", spDivInfList);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
    }

    /**
     * 상품 추가 옵션 가져오기
     * @param sp_ADDOPTINFVO
     * @return
     */
    @RequestMapping("/web/sp/getAddOptList.ajax")
    public ModelAndView getAddOptList(@ModelAttribute("SP_ADDOPTINFVO") SP_ADDOPTINFVO sp_ADDOPTINFVO) {
    	log.info("/web/sp/getAddOptList.ajax:");

    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	List<SP_ADDOPTINFVO> addOptList = masSpService.selectPrdtAddOptionList(sp_ADDOPTINFVO);

    	resultMap.put("list", addOptList);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
    }

    /**
     * 할인쿠폰 메일보내기
     * @param product
     * @param email
     * @return
     * @throws MessagingException
     */
    @RequestMapping("/web/sp/freeCouponMail.ajax")
    public ModelAndView freeCouponMail(@ModelAttribute("WEB_DTLPRDTVO") WEB_DTLPRDTVO product,
    		@Param("email") String email,
    		HttpServletRequest request
    		) throws MessagingException {
    	log.info("/web/sp/freeCouponMail.ajax:");

    	product.setPrdtDiv(Constant.SP_PRDT_DIV_FREE);
    	product = webSpService.selectByPrdt(product);
    	// 메일 발송.
    	ossMailService.sendFreeCoupon(product, email, request);

    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	resultMap.put("FLAG", Constant.JSON_SUCCESS);
    	return new ModelAndView("jsonView", resultMap);
    }

    /**
     * 패키지 상품 달력 옵션
     * @param sp_OPTINFVO
     * @param model
     * @return
     */
    @RequestMapping("/web/sp/getCalOptionList.ajax")
    public String getCalOptionList(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO,
    		@ModelAttribute("SPCALENDAR") WEB_SP_CALENDARVO spCalendar,
    		ModelMap model) {
    	log.info("/web/sp/getCalOptionList.ajax call");

    	Calendar now = Calendar.getInstance();

    	if(spCalendar.getsPrevNext().isEmpty()){
    		log.info("prevNext null");
    		now.set(Calendar.DATE, 1);
    	} else {
    		if("prev".equals(spCalendar.getsPrevNext().toLowerCase())){
   				now.set(spCalendar.getiYear(), spCalendar.getiMonth() -2, 1);
   			}else if ("next".equals(spCalendar.getsPrevNext().toLowerCase())){
   				now.set(spCalendar.getiYear(), spCalendar.getiMonth(), 1);
   			}
    	}
    	spCalendar.initValue(now);

    	String strYYYYMM = String.format("%d%02d", spCalendar.getiYear(), spCalendar.getiMonth() );

    	//선택이 가능한 달
    	String strPrevDt = spCalendar.getSaleStartDt().substring(0,6);
    	String strNextDt = spCalendar.getSaleEndDt().substring(0,6);

    	if( strPrevDt.compareTo(strYYYYMM) >= 0){
    		spCalendar.setPrevYn("N");
    	}else{
    		spCalendar.setPrevYn("Y");
    	}

    	if( strNextDt.compareTo(strYYYYMM) > 0){
    		spCalendar.setNextYn("Y");
    	}else{
    		spCalendar.setNextYn("N");
    	}

    	model.addAttribute("spCalendar", spCalendar);

    	// 옵션 정보 가져오기.
    	List<SP_OPTINFVO> optionList = webSpService.selectOptionList(sp_OPTINFVO);
    	// 달력 설정.
    	List<WEB_SP_CALENDARVO> calendarList = new ArrayList<WEB_SP_CALENDARVO>();
    	for(int i=0; i<spCalendar.getiMonthLastDay(); i++ ) {
    		WEB_SP_CALENDARVO spCal = new WEB_SP_CALENDARVO();
    		BeanUtils.copyProperties(spCalendar, spCal);

    		spCal.setiDay( i+1 );
    		if((spCalendar.getiWeek() + i)%7==0){
    			spCal.setiWeek( 7 );
    		}else{
    			spCal.setiWeek( (spCalendar.getiWeek() + i)%7 );
    		}

    		spCal.setsHolidayYN(Constant.FLAG_N);
    		// 달력에 aplDt 있는 날짜 나오기.
    		final String toDay = OssCmmUtil.getFullDay(spCal.getiYear(), spCal.getiMonth(), spCal.getiDay());
    		for(SP_OPTINFVO spOptinfovo : optionList){
				if(toDay.equals(spOptinfovo.getAplDt())){
					if("N".equals(spOptinfovo.getDdlYn()) && Integer.parseInt(spOptinfovo.getStockNum()) > 0  ){
						spCal.setDdlYn(Constant.FLAG_N);
						spCal.setSaleYn(Constant.FLAG_Y);
						break;
					}else{
						spCal.setDdlYn(Constant.FLAG_Y);
						spCal.setSaleYn(Constant.FLAG_Y);
					}
				}
			}

    		calendarList.add(spCal);
    	}

    	model.addAttribute("calendarList", calendarList);

    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	model.addAttribute("today", sdf.format(Calendar.getInstance().getTime()));

    	return "web/sp/calendar_package";
    }
    
    /**
     * 마라톤 티셔츠 사이즈별 체크
     * @param MRTNVO
     * @return
     */
    @RequestMapping("/web/sp/chkTshirtsBySize.ajax")
    public ModelAndView chkTshirtsBySize(@ModelAttribute("MRTNVO") MRTNVO mrtnSVO) {
    	log.info("/web/sp/chkTshirtsBySize.ajax:");
    	
    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	MRTNVO chkTshirtsAbleBySize = webSpService.chkTshirtsAbleBySize(mrtnSVO);
    	
    	if(chkTshirtsAbleBySize.getChkTshirtsAble().equals("Y")) {
    		resultMap.put("FLAG", Constant.JSON_SUCCESS);
    	} else {
    		resultMap.put("FLAG", Constant.JSON_FAIL);
    	}
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
    	 
		return modelAndView;
    }
    
    /**
     * 마라톤 중복 신청자 확인
     * @param MRTNVO
     * @return
     */
    @RequestMapping("/web/sp/chkMrtnUser.ajax")
    public ModelAndView chkMrtnUser(@ModelAttribute("MRTNVO") MRTNVO mrtnSVO) {
    	log.info("/web/sp/chkMrtnUser.ajax:");
    	
    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	
    	String[] birthArray = mrtnSVO.getBirth().split(",");
    	String[] lrrnArray = mrtnSVO.getLrrn().split(",");
    	String[] sRrnList = new String[birthArray.length];
    	
    	for(int i=0;i < birthArray.length;i++) {
    		sRrnList[i] = birthArray[i] + lrrnArray[i];
    	}
    	
    	String[] cartPrdtNum = mrtnSVO.getCartPrdtNum().split(",");
    	mrtnSVO.setPrdtNum(cartPrdtNum[0]);
    	mrtnSVO.setsRrnList(sRrnList);
    	String mrtnUserNm = webSpService.chkMrtnUser(mrtnSVO);
    	if(EgovStringUtil.isEmpty(mrtnUserNm)){
    		resultMap.put("FLAG", Constant.JSON_SUCCESS);
    	} else {
    		resultMap.put("FLAG", Constant.JSON_FAIL);
    		resultMap.put("RESULT", mrtnUserNm);
    	}

		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
    	 
		return modelAndView;
    }
    
    /**
     * 내손안에지도 - 관광지
     * @param
     * @return
     */
    @RequestMapping("/mustsee.do")
    public String mustsee(ModelMap model, HttpServletRequest request) {
    	log.info("/mustsee.do");
    	return "web/sp/mustsee";
    }
    
    /**
     * 내손안에지도 - 맛집
     * @param
     * @return
     */
    @RequestMapping("/musteat.do")
    public String musteat(ModelMap model, HttpServletRequest request) {
    	return "web/sp/musteat";
    }
}