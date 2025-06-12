package mw.product.web;

import api.service.APIService;
import api.vo.ApiNextezPrcAdd;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import mas.sp.service.MasSpService;
import mas.sp.vo.*;
import org.apache.commons.lang3.StringUtils;
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
import oss.point.service.OssPointService;
import oss.point.vo.POINT_CORPVO;
import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.GPAANLSVO;
import oss.user.vo.USERVO;
import web.mypage.service.WebMypageService;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.POCKETVO;
import web.mypage.vo.USER_CPVO;
import web.order.vo.MRTNVO;
import web.product.service.*;
import web.product.vo.*;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class MwSpProductController {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name = "ossMailService")
	protected OssMailService ossMailService;

	@Resource(name = "masSpService")
	private MasSpService masSpService;

	@Resource(name = "webPrdtInqService")
	protected WebPrdtInqService webPrdtInqService;

	@Resource(name = "OssAdmRcmdService")
	protected OssAdmRcmdService ossAdmRcmdService;

	@Resource(name = "ossSiteManageService")
	protected OssSiteManageService ossSiteManageService;
	
	@Resource(name="webAdProductService")
	private WebAdProductService webAdService;
	
	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;
	
	@Resource(name = "ossCouponService")
	protected OssCouponService ossCouponService;
	
	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;
	
	@Resource(name = "webPrmtService")
	protected WebPrmtService webPrmtService;

	@Resource(name = "webUserCpService")
	protected WebUserCpService webUserCpService;

	@Resource(name="apiService")
	private APIService apiService;

	@Autowired
	private OssPointService ossPointService;

	@Resource(name="ossUesepliService")
	private OssUesepliService ossUesepliService;	
	
	@RequestMapping("/mw/sp/spPackageSearch.do")
	public String spPackageSearch(@ModelAttribute("searchVO") WEB_SPSVO searchVO,
												ModelMap model) {
		log.info("/mw/sp/spPackageSearch.do");
    	String codeNum = Constant.CATEGORY_PACKAGE;
    	searchVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE);
    	// 카테고리가 없을 경우 최상위 패키지 상품 코드 셋팅.
    	if(searchVO.getsCtgr() == null) {
    		codeNum = Constant.CATEGORY_PACKAGE;
    		searchVO.setsCtgrDepth("1");
    		searchVO.setsCtgr(codeNum);
    	}
    	// 카테고리 뎁스
    	if(codeNum.equals(searchVO.getsCtgr())) {
    		searchVO.setsCtgrDepth("1");
    	} else {
    		searchVO.setsCtgrDepth("2");
    	}

		// 검색조건 카테고리 리스트
		List<CDVO> categoryList = ossCmmService.selectCode(codeNum);

		// 베스트 상품.
		List<WEB_SPPRDTVO> bestProductList = webSpService.selectBestProductList(codeNum, "1");

		model.addAttribute("categoryList", categoryList);
		model.addAttribute("bestProductList", bestProductList);
		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		return "/mw/sp/spPackageSearch";
	}
	
	/**
     * 패키지 상품 리스트
     * @param searchVO
     * @param model
     * @return
     */
    @RequestMapping("/mw/sp/packageList.do")
    public String packageList(@ModelAttribute("searchVO") WEB_SPSVO searchVO, ModelMap model) {
    	log.info("/mw/sp/packageList.do");
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
    	bestProductList = webSpService.selectBestProductListMng(codeNum);
    	if(bestProductList == null || bestProductList.size() == 0){
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

    	return "mw/sp/productList";
    }

    @RequestMapping("/mw/sp/productList.do")
	public String oldIntro() {
    	return "redirect:/mw/tour/jeju.do";
	}


	@RequestMapping("/mw/tour/jeju.do")
	public String productList(@ModelAttribute("searchVO") WEB_SPSVO searchVO,
			ModelMap model) {
		log.info("/mw/tour/jeju.do");

		// 카테고리가 없을 경우 최상위 패키지 상품 코드 셋팅.
		String codeNum = searchVO.getsCtgr();
		if(codeNum == null) {
    		codeNum = Constant.CATEGORY_TOUR;
    		searchVO.setsCtgrDepth("1");
    		searchVO.setsCtgr(codeNum);
    	} else {
			codeNum = codeNum.substring(0,2) + "00";
		}

		// 검색조건 카테고리 리스트
		List<CDVO> categoryList = ossCmmService.selectCode(codeNum);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

    	// 카테고리 설정.
    	if(Constant.CATEGORY_TOUR.equals(codeNum)) {
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
    	} else if(Constant.CATEGORY_PACKAGE.equals(codeNum)) {
    		searchVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE);

    		if(EgovStringUtil.isEmpty(searchVO.getOrderCd())){
    			// 기본정보 조회
        		DFTINFVO dftInf = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);

        		searchVO.setOrderCd(dftInf.getPackSortStd());
    		}
    	}

    	// 카테고리 뎁스 설정.
    	// 카테고리 뎁스
    	if(codeNum.equals(searchVO.getsCtgr())) {
    		searchVO.setsCtgrDepth("1");
    	} else {
    		searchVO.setsCtgrDepth("2");
    	}

		// 리스트 탭 카테고리 상품 카운트
		List<WEB_SPPRDTVO> cntCtgrPrdtList = webSpService.selectSpPrdtCntList(searchVO);

		Integer totalCnt = 0;
		for(WEB_SPPRDTVO cntVO:cntCtgrPrdtList){
			totalCnt += Integer.parseInt(cntVO.getPrdtCount());
		}

		List<WEB_SPPRDTVO> bestProductList = webSpService.selectBestProductListMng(codeNum);
		model.addAttribute("bestProductList", bestProductList);

		//코드 정보 얻기
    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
    	model.addAttribute("cdAdar", cdAdar);

		model.addAttribute("cntCtgrPrdtList", cntCtgrPrdtList);
		model.addAttribute("ctgrTotalCnt", totalCnt);
		return "/mw/sp/productList";
	}

	@RequestMapping("/mw/sp/productList.ajax")
	public String productListAjax(@ModelAttribute("searchVO") WEB_SPSVO searchVO,
								HttpServletRequest request,
								ModelMap model) {
		log.info("/mw/sp/productList.ajax");
		String codeNum = "";
		if(searchVO.getsCtgr() != null && !"".equals(searchVO.getsCtgr())) {
			codeNum = searchVO.getsCtgr().substring(0,2) + "00";
			if(codeNum.equals(searchVO.getsCtgr())) {
	    		searchVO.setsCtgrDepth("1");
	    	} else {
	    		searchVO.setsCtgrDepth("2");
	    	}
		}
    	
    	if(Constant.CATEGORY_TOUR.equals(codeNum)) {
    		searchVO.setsCtgrDiv(Constant.CATEGORY_TOUR);
    	} else if (Constant.CATEGORY_ETC.equals(codeNum)) {
    		searchVO.setsCtgrDiv(Constant.CATEGORY_ETC);
    	} else if(Constant.CATEGORY_PACKAGE.equals(codeNum)) {
    		searchVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE);
    	}
    	// 카테고리 뎁스
    	
		//searchVO.setPageUnit(propertiesService.getInt("mwPageUnit"));
    	searchVO.setPageUnit(12);
		searchVO.setPageSize(propertiesService.getInt("mwPageSize"));

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

		// 총 건수 셋팅
		/*paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));*/

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("totSch", request.getParameter("totSch"));

		return "/mw/sp/productAjax";
	}

	@RequestMapping("/mw/sp/vesselList.do")
	public String vesselList(@ModelAttribute("searchVO") WEB_SPSVO searchVO, ModelMap model) {
		log.info("/web/sp/vesselList.do");
		List<WEB_SPPRDTVO> cntCtgrPrdtList = webSpService.selectSpPrdtCntList(searchVO);
		model.addAttribute("cntCtgrPrdtList", cntCtgrPrdtList);
		searchVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE_VESSEL);
		return "mw/sp/vesselList";
	}

	
	@RequestMapping("/mw/sp/corpPrdt.do")
    public String corpPrdt(@ModelAttribute("searchVO") WEB_SPSVO searchVO,
    		ModelMap model){
    	if(EgovStringUtil.isEmpty(searchVO.getsCorpId())){
    		return "redirect:/mw/tour/jeju.do";
    	}
    	
    	// 추천순 정렬
    	searchVO.setOrderCd(Constant.ORDER_GPA);
    	
    	// 업체 정보
    	CORPVO corpSVO = new CORPVO();
    	corpSVO.setCorpId(searchVO.getsCorpId());
    	CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
    	//업체가 승인중이 아닐때 오류 페이지로
    	if( Constant.TRADE_STATUS_APPR.equals(corpVO.getTradeStatusCd()) == false ){
    		return "redirect:/mw/cmm/error.do?errCord=PRDT01";
    	}
    	model.addAttribute("corpVO", corpVO);
    	
    	// 업체 추가 정보
    	/*SP_DFTINFVO sp_DFTINFVO = new SP_DFTINFVO();
    	sp_DFTINFVO.setCorpId(searchVO.getsCorpId());
    	SP_DFTINFVO spDftInfo = masSpService.selectBySpDftinf(sp_DFTINFVO);
    	model.addAttribute("spDftInfo", spDftInfo);*/
    	
    	return "/mw/sp/corpPrdt";
    }

	@RequestMapping("/mw/sp/detailPrdt.do")
	public String detailPrdt(@ModelAttribute("searchVO")WEB_SPSVO searchVO,
							 @ModelAttribute("prdtVO") WEB_DTLPRDTVO prdtVO,
							 HttpServletRequest request,
							 ModelMap model) throws ParseException {
		log.info("/mw/sp/detailPrdt.do call");

		String prdtNum = prdtVO.getPrdtNum();

		if(EgovStringUtil.isEmpty(prdtNum)) {
    		log.error("MW SP : prdtNum is null");
    		return "redirect:/mw/tour/jeju.do";
    	}
    	// 상품 정보 가져오기.
    	WEB_DTLPRDTVO prdtInfo =  webSpService.selectByPrdt(prdtVO);

		if(prdtInfo == null ) {
			log.error("prdtInfo is null");
			return "redirect:/mw/cmm/error.do?errCord=PRDT01";
		}

    	// 상품 이미지 가져오기.
    	CM_IMGVO imgVO = new CM_IMGVO();
    	imgVO.setLinkNum(prdtNum);

    	List<CM_IMGVO> prdtImg = ossCmmService.selectImgList(imgVO);

    	// 상세 이미지 가져오기.
    	CM_DTLIMGVO dtlImgVO = new CM_DTLIMGVO();
    	dtlImgVO.setLinkNum(prdtNum);
    	dtlImgVO.setPcImgYn(Constant.FLAG_N);

    	List<CM_DTLIMGVO> dtlImg = ossCmmService.selectDtlImgList(dtlImgVO);

    	//추가사항:: 상세 정보 가져오기
    	SP_DTLINFVO sp_DTLINFVO = new SP_DTLINFVO();
    	sp_DTLINFVO.setPrdtNum(prdtVO.getPrdtNum());
    	sp_DTLINFVO.setPrintYn("Y");

    	List<SP_DTLINFVO> dtlInfList = masSpService.selectDtlInfList(sp_DTLINFVO);

    	for(SP_DTLINFVO data : dtlInfList) {
    		data.setDtlinfExp(EgovStringUtil.checkHtmlView(data.getDtlinfExp()));
    		data.setItmeEtcViewYn("N");

    		SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO = new SP_DTLINF_ITEMVO();
    		sp_DTLINF_ITEMVO.setPrdtNum(prdtVO.getPrdtNum());
    		sp_DTLINF_ITEMVO.setSpDtlinfNum(data.getSpDtlinfNum());

    		List<SP_DTLINF_ITEMVO> dtlInfItemList = masSpService.selectDtlInfItemList(sp_DTLINF_ITEMVO);

    		for(SP_DTLINF_ITEMVO dataItem : dtlInfItemList) {
    			if(StringUtils.isNotEmpty(dataItem.getItemEtc())) {
    				//하나라도 뿌릴게 있으면 뿌린다.
    				data.setItmeEtcViewYn("Y");
    				//변환
    				dataItem.setItemEtc(EgovStringUtil.checkHtmlView(dataItem.getItemEtc()));
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
			if("Y".equals(sp_GUIDINFOVORes.getPrintYn())) {
				sp_GUIDINFOVORes.setPrdtExp(EgovStringUtil.checkHtmlView(sp_GUIDINFOVORes.getPrdtExp()));
				sp_GUIDINFOVORes.setUseQlfct(EgovStringUtil.checkHtmlView(sp_GUIDINFOVORes.getUseQlfct()));
				sp_GUIDINFOVORes.setUseGuide(EgovStringUtil.checkHtmlView(sp_GUIDINFOVORes.getUseGuide()));
				sp_GUIDINFOVORes.setCancelRefundGuide(EgovStringUtil.checkHtmlView(sp_GUIDINFOVORes.getCancelRefundGuide()));
			}
			//배경색 얻기
			if(StringUtils.isNotEmpty(sp_GUIDINFOVORes.getBgColor())) {
				model.addAttribute("infoBgColor", sp_GUIDINFOVORes.getBgColor());
			}
		}
		model.addAttribute("SP_GUIDINFOVO", sp_GUIDINFOVORes);


    	// 모바일 이미지 없으면 PC 이미지로 가져오기.
    	if(dtlImg == null || dtlImg.size() == 0) {
    		dtlImgVO = new CM_DTLIMGVO();
	    	dtlImgVO.setLinkNum(prdtNum);
	    	dtlImgVO.setPcImgYn(Constant.FLAG_Y);

	    	dtlImg = ossCmmService.selectDtlImgList(dtlImgVO);
    	}
    	
    	// 판매처 다른 상품보기 ( 여행상품일경우)
    	String corpId = prdtInfo.getCorpId();
    	/*List<WEB_SPPRDTVO> otherProductList = null;
    	List<AD_WEBLISTVO> otherAdList = null;
    	
    	if(Constant.SP_PRDT_DIV_TOUR.equals(prdtInfo.getPrdtDiv())) {
    		otherProductList= webSpService.selectOtherProductList(corpId);
    	} else if ("C2".equals(prdtInfo.getCtgr().substring(0, 2))) {
    		otherProductList= webSpService.selectOtherTourList(corpId);
    	} */
    	/*else { // 주변숙소 보기 ( 쿠폰상품 일 경우)
    		otherAdList = webAdService.selectAdPrdtListDist(prdtInfo.getLat(), prdtInfo.getLon(), 5);
    	}*/
    	/*model.addAttribute("otherProductList", otherProductList);
		model.addAttribute("otherAdList", otherAdList);*/
		
    	// 상품 판매종료일 전 남은 시간 가져오기.(현재시간으로)
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date fromDate = Calendar.getInstance().getTime();
		Date toDate = sdf.parse(prdtInfo.getSaleEndDt() + "2359");

		long difDay = OssCmmUtil.getDifDay(fromDate, toDate);
		long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) - (difDay * 24 * 3600);

		/*if(StringUtils.isNotEmpty(prdtInfo.getCancelGuide())) {
			prdtInfo.setCancelGuide(EgovStringUtil.checkHtmlView(prdtInfo.getCancelGuide()));
		}
		if(StringUtils.isNotEmpty(prdtInfo.getUseQlfct())) {
			prdtInfo.setUseQlfct(EgovStringUtil.checkHtmlView(prdtInfo.getUseQlfct()));
		}*/

		// 상품 추가 옵션 가져오기.
		SP_ADDOPTINFVO sp_ADDOPTINFVO = new SP_ADDOPTINFVO();
		sp_ADDOPTINFVO.setPrdtNum(prdtNum);
		List<SP_ADDOPTINFVO> addOptList = masSpService.selectPrdtAddOptionList(sp_ADDOPTINFVO);

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
        	        	
        	pocket.setPrdtDiv(Constant.SOCIAL);
        	pocket.setCorpId(prdtVO.getCorpId());
        	pocket.setPrdtNum(prdtVO.getPrdtNum());

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

		/** 데이터제공 조회정보 수집*/
        ApiNextezPrcAdd apiNextezPrcAdd = new ApiNextezPrcAdd();
        apiNextezPrcAdd.setvConectDeviceNm("MOBILE");
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
				
		if(Constant.SP_PRDT_DIV_FREE.equals(prdtInfo.getPrdtDiv())) {
			return "/mw/sp/detailFreePrdt";
		}
		
		/** 마라톤 분기, 티셔츠 수량 체크*/
		String mrtCorpId = prdtInfo.getCorpId();
		if(mrtCorpId != null) {
			if("CSPM".equals(mrtCorpId.substring(0, 4))) {
				MRTNVO mrtnSVO = new MRTNVO();
				mrtnSVO.setCorpId(prdtInfo.getCorpId());
				mrtnSVO.setPrdtNum(prdtInfo.getPrdtNum());
				MRTNVO chkTshirts = webSpService.chkTshirts(mrtnSVO);
				model.addAttribute("chkTshirts", chkTshirts);
				
				return "/mw/sp/detailMrtPrdt";	
			}
		}
		
		return "/mw/sp/detailPrdt";
	}

		/**
	     * 상품 구분자 정보가져오기
	     * @param sp_DIVINFVO
	     * @return
	     */
	    @RequestMapping("/mw/sp/getDivInfList.ajax")
	    public ModelAndView getDivInfList(@ModelAttribute("SP_DIVINFVO") SP_DIVINFVO sp_DIVINFVO) {
	    	log.info("/mw/sp/getDivInfList.ajax:");

	    	Map<String, Object> resultMap = new HashMap<String,Object>();
	    	List<SP_DIVINFVO> spDivInfList = webSpService.selectDivInfList(sp_DIVINFVO);

	    	resultMap.put("list", spDivInfList);
			ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

			return modelAndView;
	    }

		@RequestMapping("/mw/sp/getCalOptionList.ajax")
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

	    	return "/mw/sp/calendar_package";
	    }

		@RequestMapping("/mw/sp/getOptionList.ajax")
		public ModelAndView getOptionList(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO) {
	    	log.info("/mw/sp/getOptionList.ajax:");

	    	Map<String, Object> resultMap = new HashMap<String,Object>();
	    	List<SP_OPTINFVO> optionList = webSpService.selectOptionList(sp_OPTINFVO);

	    	resultMap.put("list", optionList);
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
	    @RequestMapping("/mw/sp/freeCouponMail.ajax")
	    public ModelAndView freeCouponMail(@ModelAttribute("WEB_DTLPRDTVO") WEB_DTLPRDTVO product,
	    		@Param("email") String email,
	    		HttpServletRequest request
	    		) throws MessagingException {
	    	log.info("/mw/sp/freeCouponMail.ajax:");

	    	product.setPrdtDiv(Constant.SP_PRDT_DIV_FREE);
	    	product = webSpService.selectByPrdt(product);
	    	// 메일 발송.
	    	ossMailService.sendFreeCoupon(product, email, request);

	    	Map<String, Object> resultMap = new HashMap<String,Object>();
	    	resultMap.put("FLAG", Constant.JSON_SUCCESS);
	    	return new ModelAndView("jsonView", resultMap);
	    }

}
