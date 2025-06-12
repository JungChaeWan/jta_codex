package web.product.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mas.ad.vo.AD_ADDAMTVO;
import mas.ad.vo.AD_AMTINFSVO;
import mas.ad.vo.AD_AMTINFVO;
import mas.ad.vo.AD_PRDTINFVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.sp.service.MasSpService;
import mas.sp.vo.SP_ADDOPTINFVO;

import org.apache.ibatis.annotations.Param;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.ad.vo.AD_WEBDTLSVO;
import oss.ad.vo.AD_WEBDTLVO;
import oss.ad.vo.AD_WEBLIST5VO;
import oss.ad.vo.AD_WEBLISTSVO;
import oss.ad.vo.AD_WEBLISTVO;
import oss.cmm.service.OssCmmService;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import web.product.service.WebAdProductService;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;
import web.product.vo.CARTVO;
import web.product.vo.WEB_DTLPRDTVO;
import web.product.vo.WEB_SPPRDTVO;
import web.product.vo.WEB_SPSVO;

import common.Constant;

import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class WebTravelExpenseController {

	@Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name = "masSpService")
	private MasSpService masSpService;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;


	Logger log = (Logger) LogManager.getLogger(this.getClass());


	@RequestMapping("/web/te/teMain.do")
	public String teMain(ModelMap model) {
		log.info("/web/te/teMain.do call");


		Calendar calNow = Calendar.getInstance();
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		model.addAttribute("SVR_NEXTDAY",EgovStringUtil.getDateFormatDash(calNow));

		calNow.add(Calendar.DAY_OF_MONTH, 1);
		model.addAttribute("SVR_NEXTNEXTDAY",EgovStringUtil.getDateFormatDash(calNow));


		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, 6);
		EgovStringUtil.getDateFormatDash(cal);
		model.addAttribute("AFTER_DAY", EgovStringUtil.getDateFormatDash(cal));

		return "/web/te/teMain";
	}

	@RequestMapping("/web/te/spProductList.ajax")
	public String spProductList(@ModelAttribute("searchVO") WEB_SPSVO searchVO,
			ModelMap model) {
		String codeNum = searchVO.getsCtgr();
    	if(Constant.CATEGORY_TOUR.equals(codeNum)) {
    		searchVO.setsCtgrDiv(Constant.CATEGORY_TOUR);
    	} else if (Constant.CATEGORY_ETC.equals(codeNum)) {
    		searchVO.setsCtgrDiv(Constant.CATEGORY_ETC);
    	}
		searchVO.setsCtgrDepth("1");
		searchVO.setsTeMainYn(Constant.FLAG_Y);

		searchVO.setPageUnit(propertiesService.getInt("webPageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("webPageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setsPrdtDiv(Constant.SP_PRDT_DIV_COUP);
		// 상품 리스트
		Map<String, Object> resultMap = webSpService.selectProductList(searchVO);

		@SuppressWarnings("unchecked")
		List<WEB_SPPRDTVO> resultList = (List<WEB_SPPRDTVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));


		// 카테고리 탭 상품 갯수 설정.
		List<WEB_SPPRDTVO> cntCtgrPrdtList = webSpService.selectSpPrdtCntList(searchVO);

		model.addAttribute("resultList", resultList);
		model.addAttribute("cntCtgrPrdtList", cntCtgrPrdtList);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/web/te/spProductList";
	}


	/**
	 * 숙소 리스트
	 * 파일명 : adProductList
	 * 작성일 : 2015. 12. 23. 오전 11:25:01
	 * 작성자 : 신우섭
	 * @param prdtSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/te/adProductList.ajax")
	public String adProductList(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO,
			ModelMap model) {
		log.info(">>>>>>>>>>>>>>>/web/te/adProductList.ajax호출");

		prdtSVO.setPageUnit(propertiesService.getInt("webPageUnit"));
    	prdtSVO.setPageSize(propertiesService.getInt("webPageSize"));
    	//prdtSVO.setPageUnit(3);
    	//prdtSVO.setPageSize(10);

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prdtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prdtSVO.getPageUnit());
		paginationInfo.setPageSize(prdtSVO.getPageSize());

		prdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//log.info(">>>>>>>>>>>>>>"+prdtSVO.getOrderCd() );


		Map<String, Object> resultMap = webAdProductService.selectTeAdPrdtList(prdtSVO);

		@SuppressWarnings("unchecked")
		List<AD_WEBLISTVO> resultList = (List<AD_WEBLISTVO>) resultMap.get("resultList");

		for(AD_WEBLISTVO data : resultList){
			if( data.getGpaAvg() == null ){
				data.setGpaAvg("0");
			}

			//핫딜, 당일 특가가 포함 되었는지 얻기
			//log.info(">>>>>>>>>>>>>>"+data.getCorpId() + " :" + prdtSVO.getsFromDt() + " :" + prdtSVO.getsNights() );
	    	AD_WEBLIST5VO adWeb5VO = new AD_WEBLIST5VO();
	    	adWeb5VO.setCorpId(data.getCorpId());
	    	adWeb5VO.setFromDt(prdtSVO.getsFromDt());
	    	adWeb5VO.setNights(prdtSVO.getsNights());
	    	AD_WEBLIST5VO adWeb5Res = webAdProductService.getHotdeallAndDayPrice(adWeb5VO);
	    	data.setHotdallYn( adWeb5Res.getHotdeallYn() );
	    	data.setDaypriceYn( adWeb5Res.getDaypriceYn() );

		}

		model.addAttribute("resultList", resultList);
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "/web/te/adProductList";
	}


	//@RequestMapping("/web/te/adProductDtl.ajax")
    public String adProductDtl(@ModelAttribute("searchVO") AD_WEBDTLSVO prdtSVO,
    		   					ModelMap model){

    	//객실 번호가 없으면 대표객실 번호 가저오기
    	if(prdtSVO.getsPrdtNum()==null || "".equals(prdtSVO.getsPrdtNum() )){

    		if(prdtSVO.getCorpId()==null || prdtSVO.getCorpId().isEmpty() ){
    			return "redirect:/web/cmm/error.do";
    		}

    		AD_PRDTINFVO adPrdt = new AD_PRDTINFVO();
    		adPrdt.setCorpId( prdtSVO.getCorpId() );
    		AD_PRDTINFVO adPrdtRes = webAdProductService.selectPrdtInfByMaster(adPrdt);

    		if(adPrdtRes==null){
    			return "redirect:/web/cmm/error.do";
    		}

    		prdtSVO.setsPrdtNum( adPrdtRes.getPrdtNum() );
    	}


    	AD_WEBDTLVO ad_WEBDTLVO = webAdProductService.selectWebdtlByPrdt(prdtSVO);

//    	ad_WEBDTLVO.setTip(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getTip()) );
//    	ad_WEBDTLVO.setTip( ad_WEBDTLVO.getTip().replaceAll("\n", "<br/>\n") );
//
//    	ad_WEBDTLVO.setInfIntrolod(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfIntrolod()) );
//    	ad_WEBDTLVO.setInfIntrolod( ad_WEBDTLVO.getInfIntrolod().replaceAll("\n", "<br/>\n") );
//
//    	ad_WEBDTLVO.setInfEquinf(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfEquinf()) );
//    	ad_WEBDTLVO.setInfEquinf( ad_WEBDTLVO.getInfEquinf().replaceAll("\n", "<br/>\n") );
//
//    	ad_WEBDTLVO.setInfOpergud(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfOpergud()) );
//    	ad_WEBDTLVO.setInfOpergud( ad_WEBDTLVO.getInfOpergud().replaceAll("\n", "<br/>\n") );
//
//    	ad_WEBDTLVO.setInfNti(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfNti()) );
//    	ad_WEBDTLVO.setInfNti( ad_WEBDTLVO.getInfNti().replaceAll("\n", "<br/>\n") );
//
//    	ad_WEBDTLVO.setCancelGuide(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getCancelGuide()) );
//    	ad_WEBDTLVO.setCancelGuide( ad_WEBDTLVO.getCancelGuide().replaceAll("\n", "<br/>\n") );


    	model.addAttribute("webdtl", ad_WEBDTLVO);


    	//날짜가 없으면 오늘날짜
    	if(prdtSVO.getsFromDt()==null || "".equals(prdtSVO.getsFromDt() ) ){
    		//prdtSVO.setsFromDt("20151101");
    		Calendar calNow = Calendar.getInstance();
    		prdtSVO.setsFromDt(String.format("%d%02d%02d"
        							, calNow.get(Calendar.YEAR)
        							, calNow.get(Calendar.MONTH)+1
        							, calNow.get(Calendar.DATE) ) );
    	}

    	//박이 없으면 1박
    	if(prdtSVO.getsNights()==null || "".equals(prdtSVO.getsNights() ) ){
    		prdtSVO.setsNights("1");
    	}
    	model.addAttribute("searchVO", prdtSVO);


    	//상품의 업체정보의 LAT, LON 정보를 가져와야 함. 명칭은 나중에 수정해 주세요.
    	CORPVO corpSVO = new CORPVO();
    	corpSVO.setCorpId(ad_WEBDTLVO.getCorpId());
    	CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
    	model.addAttribute("corpVO", corpVO);


//    	//숙소 이미지
//    	CM_IMGVO imgVO = new CM_IMGVO();
//    	imgVO.setLinkNum(ad_WEBDTLVO.getCorpId().toUpperCase());
//    	List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
//    	model.addAttribute("adImgList", imgList);

    	//핫딜, 당일 특가가 포함 되었는지 얻기
    	AD_WEBLIST5VO adWeb5VO = new AD_WEBLIST5VO();
    	adWeb5VO.setCorpId(ad_WEBDTLVO.getCorpId());
    	adWeb5VO.setFromDt(prdtSVO.getsFromDt());
    	adWeb5VO.setNights(prdtSVO.getsNights());
    	AD_WEBLIST5VO adWeb5Res = webAdProductService.getHotdeallAndDayPrice(adWeb5VO);
    	model.addAttribute("adHotDay", adWeb5Res);
    	//log.info(">>>>>>>>>>" + adWeb5Res.getDaypriceYn() + ":" + adWeb5Res.getHotdeallYn() );


    	//객실 목록
    	AD_PRDTINFVO ad_PRDTINFVO = new AD_PRDTINFVO();
    	ad_PRDTINFVO.setCorpId(ad_WEBDTLVO.getCorpId());
    	ad_PRDTINFVO.setFromDt(prdtSVO.getsFromDt());
    	List<AD_PRDTINFVO> ad_prdtList = webAdProductService.selectAdPrdList(ad_PRDTINFVO);

    	int nEventCnt = 0;
    	for (AD_PRDTINFVO adPrdt : ad_prdtList) {
    		//log.info(">>>>>>>>>>" +adPrdt.getEventCnt() );
    		nEventCnt += Integer.parseInt(adPrdt.getEventCnt());
    	}
    	model.addAttribute("eventCnt", nEventCnt);


    	//초기값 지정을위해 최대 수용 인원 설정
    	for (AD_PRDTINFVO adPrdt : ad_prdtList) {
    		if(adPrdt.getPrdtNum().endsWith(prdtSVO.getsPrdtNum()) ){
    			//추가 인원 허안 안할때 기준인원을 최대 인원으로
    			if(adPrdt.getMemExcdAbleYn().equals("N") ){
    				adPrdt.setMaxiMem(adPrdt.getStdMem());
    			}
    			model.addAttribute("adPtdt", adPrdt);
    			break;
    		}
		}


    	//log.info(">>>>>>>>>>" +prdtSVO.getsFromDt() );

    	//판매가격
    	AD_AMTINFSVO ad_AMTINFSVO = new AD_AMTINFSVO();
    	ad_AMTINFSVO.setsCorpId(ad_WEBDTLVO.getCorpId());
    	ad_AMTINFSVO.setStartDt(prdtSVO.getsFromDt());
    	List<AD_AMTINFVO> ad_amtList = webAdProductService.selectAdAmtListDtl(ad_AMTINFSVO);
    	/*
    	for (AD_AMTINFVO data : ad_amtList) {
    		log.info(">>>>>>>>>>HotdallYn:" +data.getHotdallYn() +" DaypriceYn:" +data.getDaypriceYn()+" DaypriceAmt:" + data.getDaypriceAmt());
		}
		*/



    	//객실 이미지 & 판매가격 조합s
    	for (AD_PRDTINFVO data : ad_prdtList) {
    		//CM_IMGVO imgPdtVO = new CM_IMGVO();
    		//imgPdtVO.setLinkNum(data.getPrdtNum());
        	//List<CM_IMGVO> prdtImgList = ossCmmService.selectImgList(imgPdtVO);
        	//data.setImgList(prdtImgList);

        	for (AD_AMTINFVO amt : ad_amtList) {
        		if( data.getPrdtNum().equals(amt.getPrdtNum()) ){
        			data.setSaleAmt( amt.getSaleAmt() );
        			data.setNmlAmt( amt.getNmlAmt() );

        			data.setHotdallYn( amt.getHotdallYn() );
        			data.setDaypriceYn( amt.getDaypriceYn() );
        			data.setDaypriceAmt( amt.getDaypriceAmt() );
        			//log.info(">>>>>>>>>>" +amt.getSaleAmt() );
        		}
			}

        	//log.info(">>>>>>>>>>HotdallYn:" +data.getHotdallYn() +" DaypriceYn:" +data.getDaypriceYn()+" DaypriceAmt:" + data.getDaypriceAmt());

		}
    	model.addAttribute("prdtList", ad_prdtList);

    	//객실 추가 요금 얻기
		AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
		ad_ADDAMTVO.setAplStartDt( prdtSVO.getsFromDt() );
		ad_ADDAMTVO.setCorpId( prdtSVO.getsPrdtNum() );
		AD_ADDAMTVO adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
		//System.out.println("---------------------1[[["+prdtSVO.getsFromDt() + " - " + prdtSVO.getsPrdtNum());
		if(adAddAmt == null){
			//숙소 추가 요금 얻기
    		ad_ADDAMTVO.setCorpId( ad_WEBDTLVO.getCorpId() );
			adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
			//System.out.println("---------------------2[[["+prdtSVO.getsFromDt() + " - "+ad_WEBDTLVO.getCorpId() );
			if(adAddAmt == null){
				adAddAmt = new AD_ADDAMTVO();
				adAddAmt.setAdultAddAmt("0");
				adAddAmt.setJuniorAddAmt("0");
				adAddAmt.setChildAddAmt("0");
			}
		}
		model.addAttribute("adAddAmt", adAddAmt );


		model.addAttribute("searchVO", prdtSVO );


//		//주변숙소 검색
//		AD_WEBLIST4VO webDist = new AD_WEBLIST4VO();
//		webDist.setCorpId(corpVO.getCorpId());
//		webDist.setLon(corpVO.getLon() );
//		webDist.setLat(corpVO.getLat() );
//		webDist.setsRowCount("10");
//		List<AD_WEBLIST4VO> listDist = webAdProductService.selectAdListDist(webDist);
//		model.addAttribute("listDist", listDist );


    	return "/web/te/adOptionLayer";
    }

	/**
	 * 여행경비 산출 옵션 레이어.
	 * @param prdtNum
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/te/optionLayer.ajax")
	public String optionLayer(@Param("prdtNum") String prdtNum,
			ModelMap model,
			HttpServletRequest request) {

		// 각자 맞춰서 옵션 레이어 리턴.
		if(Constant.SOCIAL.equals(prdtNum.substring(0,2).toUpperCase())) {
			WEB_DTLPRDTVO searchVO = new WEB_DTLPRDTVO();
			searchVO.setPrdtNum(prdtNum);
			WEB_DTLPRDTVO prdtInfo = webSpService.selectByPrdt(searchVO);

			model.addAttribute("prdtInfo", prdtInfo);

			// 상품 추가 옵션 가져오기.
			SP_ADDOPTINFVO sp_ADDOPTINFVO = new SP_ADDOPTINFVO();
			sp_ADDOPTINFVO.setPrdtNum(prdtNum);
			List<SP_ADDOPTINFVO> addOptList = masSpService.selectPrdtAddOptionList(sp_ADDOPTINFVO);

			model.addAttribute("addOptList", addOptList);

			return "/web/te/spOptionLayer";
		}else if(Constant.ACCOMMODATION.equals(prdtNum.substring(0,2).toUpperCase())) {
			//log.info("aaaaaaaaaaaaaaaaaa:" + request.getParameter("sFromDt") + " : " + request.getParameter("sNights"));

			AD_WEBDTLSVO adPrdtSVO = new AD_WEBDTLSVO();
			adPrdtSVO.setsPrdtNum(prdtNum);
			adPrdtSVO.setsFromDt(request.getParameter("sFromDt"));
			adPrdtSVO.setsNights(request.getParameter("sNights"));

			return adProductDtl(adPrdtSVO, model);

		}else if(Constant.RENTCAR.equals(prdtNum.substring(0,2).toUpperCase())) {
			//log.info("aaaaaaaaaaaaaaaaaa:");

			RC_PRDTINFSVO rcPrdtSVO = new RC_PRDTINFSVO();
			rcPrdtSVO.setsPrdtNum(prdtNum);
			rcPrdtSVO.setsFromDt(request.getParameter("sFromDt"));
			rcPrdtSVO.setsFromTm(request.getParameter("sFromTm"));
			rcPrdtSVO.setsToDt(request.getParameter("sToDt"));
			rcPrdtSVO.setsToTm(request.getParameter("sToTm"));
			rcPrdtSVO.setFirstIndex(0);
			rcPrdtSVO.setLastIndex(1);

			CARTVO cart = new CARTVO();
			cart.setFromDt(request.getParameter("sFromDt"));
			cart.setFromTm(request.getParameter("sFromTm"));
			cart.setToDt(request.getParameter("sToDt"));
			cart.setToTm(request.getParameter("sToTm"));
			cart.setInsureDiv("0");
			cart.setAddAmt("0");
			cart.setCartSn(1);


			// 단건에 대한 렌터카 정보 조회
	    	List<RC_PRDTINFVO> resultList = webRcProductService.selectRcPrdtList2(rcPrdtSVO);
	    	RC_PRDTINFVO prdtInfo = resultList.get(0);

	    	RC_PRDTINFVO prdtVO = new RC_PRDTINFVO();
	    	prdtVO.setPrdtNum(prdtNum);
	    	prdtVO = webRcProductService.selectByPrdt(prdtVO);
	    	prdtInfo.setIsrCmGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrCmGuide()));
	    	prdtInfo.setIsrAmtGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrAmtGuide()));


	    	model.addAttribute("prdtInfo", prdtInfo);
	    	model.addAttribute("cartInfo", cart);
	    	return "/web/te/rcOptionLayer";
		}




		return "/web/te/rcOptionLayer";
	}
}


