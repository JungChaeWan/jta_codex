package mw.product.web;


import api.service.APIService;
import api.vo.ApiNextezPrcAdd;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovWebUtil;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.*;
import mas.prmt.service.MasPrmtService;
import mas.prmt.vo.MAINPRMTVO;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.ad.vo.*;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_ICONINFVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPSVO;
import oss.corp.vo.CORPVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPSVO;
import oss.coupon.vo.CPVO;
import oss.env.service.OssSiteManageService;
import oss.env.vo.DFTINFVO;
import oss.marketing.serive.OssAdmRcmdService;
import oss.point.service.OssPointService;
import oss.point.vo.POINT_CORPVO;
import oss.user.vo.USERVO;
import web.main.service.WebMainService;
import web.main.vo.MAINPRDTVO;
import web.mypage.service.WebMypageService;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.POCKETVO;
import web.mypage.vo.USER_CPVO;
import web.product.service.WebAdProductService;
import web.product.service.WebPrdtInqService;
import web.product.service.WebPrmtService;
import web.product.vo.ADTOTALPRICEVO;
import web.product.vo.PRDTINQVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
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
public class MwADProductController {

	@Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "masAdPrdtService")
	protected MasAdPrdtService masAdPrdtService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;

	@Resource(name = "webPrdtInqService")
	protected WebPrdtInqService webPrdtInqService;

	@Resource(name = "OssAdmRcmdService")
	protected OssAdmRcmdService ossAdmRcmdService;

	@Resource(name = "ossSiteManageService")
	protected OssSiteManageService ossSiteManageService;
	
	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;
	
	@Resource(name = "ossCouponService")
	protected OssCouponService ossCouponService;
	
	@Resource(name = "webPrmtService")
	protected WebPrmtService webPrmtService;

	@Resource(name = "webUserCpService")
	protected WebUserCpService webUserCpService;

	@Resource(name="apiService")
	private APIService apiService;

	@Resource(name = "webMainService")
	private WebMainService webMainService;

	@Resource(name = "masPrmtService")
	private MasPrmtService masPrmtService;

	@Autowired
	private OssPointService ossPointService;

    Logger log = (Logger) LogManager.getLogger(this.getClass());

    @RequestMapping("/mw/ad/mainList.do")
    public String mainList(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO,
						   ModelMap model) {
    	
    	if(prdtSVO.getsFromDt() == null) {
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
    	if(StringUtils.isEmpty(prdtSVO.getsNights())) {
    		prdtSVO.setsNights("1");
    	}
    	
    	// 인원이 없으면 2명
    	if(StringUtils.isEmpty(prdtSVO.getsMen())) {
    		prdtSVO.setsMen("2");
    		prdtSVO.setsAdultCnt("2");
    		prdtSVO.setsChildCnt("0");
    		prdtSVO.setsBabyCnt("0");
    	}
    	
    	// 등록된 업체수
    	CORPSVO corpSVO = new CORPSVO();
    	corpSVO.setsCorpCd("CADO");
    	corpSVO.setsTradeStatusCd(Constant.TRADE_STATUS_APPR);

    	Integer corpCount = ossCorpService.getCountCorp(corpSVO);
    	corpCount = ((int) Math.floor(corpCount / 10)) * 10;

    	model.addAttribute("corpRegNum", corpCount);
    	if(prdtSVO.getsPrdtNum() != null) {
			AD_WEBDTLSVO adWebdtlsvo = new AD_WEBDTLSVO();
			adWebdtlsvo.setsPrdtNum(prdtSVO.getsPrdtNum());

			AD_WEBDTLVO ad_WEBDTLVO = webAdProductService.selectWebdtlByPrdt(adWebdtlsvo);

			model.addAttribute("webDtl", ad_WEBDTLVO);
		}
    	
    	//코드 정보 얻기
    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
    	model.addAttribute("cdAdar", cdAdar);
    	model.addAttribute("cdAddv", cdAddv);
    	
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));    	
    	
    	return "/mw/ad/mainList";
    }

    @RequestMapping("/mw/ad/productList.do")
    public String productList(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO,
							  ModelMap model) {
    	log.info("/mw/ad/productList.do 호출");

    	//코드 정보 얻기
    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
    	model.addAttribute("cdAdar", cdAdar);
    	model.addAttribute("cdAddv", cdAddv);
    	
    	// 주요정보
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.ICON_CD_ADAT);
    	model.addAttribute("iconCd", cdList);

    	if(prdtSVO.getsFromDt() == null) {
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
    	if(StringUtils.isEmpty(prdtSVO.getsNights())) {
    		prdtSVO.setsNights("1");
    	}
    	
    	// 인원이 없으면 1명
    	if(StringUtils.isEmpty(prdtSVO.getsMen())) {
    		prdtSVO.setsMen("2");
    		prdtSVO.setsAdultCnt("2");
    		prdtSVO.setsChildCnt("0");
    		prdtSVO.setsBabyCnt("0");
    	}
    	
    	if(StringUtils.isEmpty(prdtSVO.getsSearchYn())) {
    		prdtSVO.setsSearchYn(Constant.FLAG_N);
    	}

    	// 기본정보 조회
		DFTINFVO dftInf = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);

		if(StringUtils.isEmpty(prdtSVO.getOrderCd())) {
    		prdtSVO.setOrderCd(dftInf.getAdSortStd());
    	}

    	if(StringUtils.isEmpty(prdtSVO.getOrderAsc())) {
    		prdtSVO.setOrderAsc(dftInf.getAdSortAsc());
    	}

    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

    	return "/mw/ad/productList";
    }


    @RequestMapping("/mw/ad/adList.ajax")
    public String glList(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO,
    			HttpServletRequest request,
				ModelMap model){

    	log.info("/mw/ad/adList.ajax 호출");

    	if(prdtSVO.getsNights() == null){
    		prdtSVO.setsNights("1");
    	}

    	// 기본정보 조회
		DFTINFVO dftInf = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);

		if(prdtSVO.getOrderCd() == null){
    		prdtSVO.setOrderCd(dftInf.getAdSortStd());
    	}

    	if(prdtSVO.getOrderAsc() == null){
    		prdtSVO.setOrderAsc(dftInf.getAdSortAsc());
    	}

		//SQL Injection 대응. 체크인, 체크아웃 날짜가 잘 못 되었을 경우 처리. 2021.08.03 chaewan.jung
		Calendar calNow = Calendar.getInstance();
		if(!EgovStringUtil.checkDate(prdtSVO.getsFromDt())){
			calNow.add(Calendar.DAY_OF_MONTH, 1);
			prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
			prdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
			prdtSVO.setsFromDtMap(EgovStringUtil.getDateFormatDash(calNow));
		}
    	if(!EgovStringUtil.checkDate(prdtSVO.getsToDt())) {
			calNow.add(Calendar.DAY_OF_MONTH, 1);
			prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
			prdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
			prdtSVO.setsToDtMap(EgovStringUtil.getDateFormatDash(calNow));
		}

    	/*prdtSVO.setPageUnit(10);
    	prdtSVO.setPageSize(propertiesService.getInt("webPageSize"));*/

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prdtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prdtSVO.getPageUnit());
		paginationInfo.setPageSize(prdtSVO.getPageSize());
		if(prdtSVO.getIsBack() != null && !"".equals(prdtSVO.getIsBack()) && prdtSVO.getIsBack().equals("Y")) {
			prdtSVO.setFirstIndex(0);
		}else{
			prdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		}
		prdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//지역코드 문자열을 배열로 변환
		if (!"".equals(prdtSVO.getsAdAdar())) {
			String[] arrAdAdar = prdtSVO.getsAdAdar().split(",");
			ArrayList<String> adAdarList = new ArrayList<String>(Arrays.asList(arrAdAdar));
			prdtSVO.setArrAdAdar(adAdarList);
		}

		Map<String, Object> resultMap = webAdProductService.selectAdPrdtList(prdtSVO);

		@SuppressWarnings("unchecked")
		List<AD_WEBLISTVO> resultList = (List<AD_WEBLISTVO>) resultMap.get("resultList");

		model.addAttribute("resultList", resultList);
/*		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));*/
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("sNights", prdtSVO.getsNights());

		model.addAttribute("totSch", request.getParameter("totSch"));

    	return "/mw/ad/adList";
    }

    @RequestMapping("/mw/ad/detailPrdt.do")
    public String detailPrdt(@ModelAttribute("searchVO") AD_WEBDTLSVO prdtSVO,
							 HttpServletRequest request,
    						ModelMap model){
		log.info("/mw/ad/detailPrdt.do call");

    	//객실 번호가 없으면 대표객실 번호 가저오기
    	if(EgovStringUtil.isEmpty(prdtSVO.getsPrdtNum())) {
    		log.error("MW AD : prdtNum is null");
    		if(EgovStringUtil.isEmpty(prdtSVO.getCorpId())){
				log.error("prdtNum, corpId is null");
				return "forward:/mw/ad/productList.do";
    		}
    		AD_PRDTINFVO adPrdt = new AD_PRDTINFVO();
    		adPrdt.setCorpId(prdtSVO.getCorpId());

    		AD_PRDTINFVO adPrdtRes = webAdProductService.selectPrdtInfByMaster(adPrdt);

    		if(adPrdtRes == null) {
				log.error("adPrdtRes is null");
				return "forward:/mw/cmm/error.do?errCord=PRDT01";
    		}
    		prdtSVO.setsPrdtNum(adPrdtRes.getPrdtNum());
    	}
    	
    	if(EgovStringUtil.isEmpty(prdtSVO.getsSearchYn())){
    		prdtSVO.setsSearchYn(Constant.FLAG_N);
    	}

    	AD_WEBDTLVO ad_WEBDTLVO = webAdProductService.selectWebdtlByPrdt(prdtSVO);

    	ad_WEBDTLVO.setTip(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getTip()) );
    	ad_WEBDTLVO.setTip( ad_WEBDTLVO.getTip().replaceAll("\n", "<br/>\n") );

    	ad_WEBDTLVO.setInfIntrolod(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfIntrolod()) );
    	ad_WEBDTLVO.setInfIntrolod( ad_WEBDTLVO.getInfIntrolod().replaceAll("\n", "<br/>\n") );

    	ad_WEBDTLVO.setInfEquinf(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfEquinf()) );
    	ad_WEBDTLVO.setInfEquinf( ad_WEBDTLVO.getInfEquinf().replaceAll("\n", "<br/>\n") );

    	ad_WEBDTLVO.setInfOpergud(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfOpergud()) );
    	ad_WEBDTLVO.setInfOpergud( ad_WEBDTLVO.getInfOpergud().replaceAll("\n", "<br/>\n") );

    	ad_WEBDTLVO.setInfNti(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfNti()) );
    	ad_WEBDTLVO.setInfNti( ad_WEBDTLVO.getInfNti().replaceAll("\n", "<br/>\n") );
    	model.addAttribute("webdtl", ad_WEBDTLVO);
    	
    	if (ad_WEBDTLVO.getInfIntrolod() != null && !"".equals(ad_WEBDTLVO.getInfIntrolod())) {
            model.addAttribute("seoInfo", ad_WEBDTLVO.getInfIntrolod().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "").replaceAll("(\r\n|\r|\n|\n\r)", ""));
        } else {
            model.addAttribute("seoInfo", "");
        }
    	
    	Calendar calNow = Calendar.getInstance();

		//당일예약 불가 체크 2022.01.06 chaewan.jung 추가
		int dayRsvCnt = 1; //1=가능
		Map<String, String> dayRsvCntMap = new HashMap<String, String>();
		dayRsvCntMap.put("corpId", ad_WEBDTLVO.getCorpId());
		dayRsvCntMap.put("sFromDt", prdtSVO.getsFromDt());

		if (EgovStringUtil.getDateFormat(calNow).equals(prdtSVO.getsFromDt()) ) {
			dayRsvCnt = webAdProductService.getDayRsvCnt(dayRsvCntMap);
		}
		model.addAttribute("dayRsvCnt", dayRsvCnt);

		//날짜가 없으면 오늘날짜
    	if(StringUtils.isEmpty(prdtSVO.getsFromDt())) {
    		prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
    		prdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
    	}
    	if(StringUtils.isEmpty(prdtSVO.getsToDt())) {
    		calNow.add(Calendar.DAY_OF_MONTH, 1);
    		prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
    		prdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
    	}

    	//박이 없으면 1박
    	if(StringUtils.isEmpty(prdtSVO.getsNights())) {
    		prdtSVO.setsNights("1");
    	}
    	
    	// 인원수가 없으면
    	if(StringUtils.isEmpty(prdtSVO.getsAdultCnt())) {
    		prdtSVO.setsAdultCnt("2");
    		prdtSVO.setsChildCnt("0");
    		prdtSVO.setsBabyCnt("0");
    	}
    	
    	model.addAttribute("searchVO", prdtSVO);

    	//상품의 업체정보의 LAT, LON 정보를 가져와야 함. 명칭은 나중에 수정해 주세요.
    	CORPVO corpSVO = new CORPVO();
    	corpSVO.setCorpId(ad_WEBDTLVO.getCorpId());
    	CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
    	model.addAttribute("corpVO", corpVO);

    	//업체가 승인중이 아닐때 오류 페이지로
    	if( Constant.TRADE_STATUS_APPR.equals(corpVO.getTradeStatusCd()) == false ){
    		return "forward:/mw/cmm/error.do?errCord=PRDT01";
    	}

    	//숙소 이미지
    	CM_IMGVO imgVO = new CM_IMGVO();
    	imgVO.setLinkNum(ad_WEBDTLVO.getCorpId().toUpperCase());
    	List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
    	model.addAttribute("imgList", imgList);

    	//핫딜, 당일 특가가 포함 되었는지 얻기
    	AD_WEBLIST5VO adWeb5VO = new AD_WEBLIST5VO();
    	adWeb5VO.setCorpId(ad_WEBDTLVO.getCorpId());
    	adWeb5VO.setFromDt(prdtSVO.getsFromDt());
    	adWeb5VO.setToDt(prdtSVO.getsToDt());
    	adWeb5VO.setNights(prdtSVO.getsNights());
    	AD_WEBLIST5VO adWeb5Res = webAdProductService.getHotdeallAndDayPrice(adWeb5VO);
    	model.addAttribute("adHotDay", adWeb5Res);

    	//객실 목록
    	AD_PRDTINFVO ad_PRDTINFVO = new AD_PRDTINFVO();
    	ad_PRDTINFVO.setCorpId(ad_WEBDTLVO.getCorpId());
    	ad_PRDTINFVO.setFromDt(prdtSVO.getsFromDt());
    	ad_PRDTINFVO.setToDt(prdtSVO.getsToDt());
    	ad_PRDTINFVO.setNights(prdtSVO.getsNights());
    	ad_PRDTINFVO.setSearchYn(prdtSVO.getsSearchYn());
    	ad_PRDTINFVO.setRoomNum(prdtSVO.getsRoomNum());
    	List<AD_PRDTINFVO> ad_prdtList = webAdProductService.selectAdPrdList(ad_PRDTINFVO);

    	int nEventCnt = 0;
    	for (AD_PRDTINFVO adPrdt : ad_prdtList) {
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

    	//판매가격
    	AD_AMTINFSVO ad_AMTINFSVO = new AD_AMTINFSVO();
    	ad_AMTINFSVO.setsCorpId(ad_WEBDTLVO.getCorpId());
    	ad_AMTINFSVO.setStartDt(prdtSVO.getsFromDt());
    	List<AD_AMTINFVO> ad_amtList = webAdProductService.selectAdAmtListDtl(ad_AMTINFSVO);
    	
    	//구조화된 제품 스니펫
        List<Integer> saleAmtList = new ArrayList<>();
        for(AD_AMTINFVO amtInfVO : ad_amtList) {
        	if(amtInfVO.getSaleAmt() != null) {
        		saleAmtList.add(Integer.parseInt(amtInfVO.getSaleAmt()));
        	}
        }
        if(!saleAmtList.isEmpty()) {
        	int saleMaxAmt = Collections.max(saleAmtList);
            int saleMinAmt = Collections.min(saleAmtList);
            model.addAttribute("saleMaxAmt", saleMaxAmt);
            model.addAttribute("saleMinAmt", saleMinAmt);
        }
        
    	//객실 이미지 & 판매가격 조합
    	for (AD_PRDTINFVO data : ad_prdtList) {
    		CM_IMGVO imgPdtVO = new CM_IMGVO();
    		imgPdtVO.setLinkNum(data.getPrdtNum());
        	List<CM_IMGVO> prdtImgList = ossCmmService.selectImgList(imgPdtVO);
        	data.setImgList(prdtImgList);

        	for (AD_AMTINFVO amt : ad_amtList) {
        		if( data.getPrdtNum().equals(amt.getPrdtNum()) ){
        			if (Constant.FLAG_Y.equals(prdtSVO.getsSearchYn())) {
	        			// 예약 가능 여부 체크
	        			int nPrice = webAdProductService.getTotalPrice(data.getPrdtNum()
								, prdtSVO.getsFromDt()
								, prdtSVO.getsNights()
								, prdtSVO.getsAdultCnt()
								, prdtSVO.getsChildCnt()
								, prdtSVO.getsBabyCnt());
	        			
	        			data.setSaleAmt(nPrice <= 0 ? "" : "" + nPrice);

	        			int nPrice2 = webAdProductService.getNmlAmt(data.getPrdtNum()
								, prdtSVO.getsFromDt()
								, prdtSVO.getsNights()
								, prdtSVO.getsAdultCnt()
								, prdtSVO.getsChildCnt()
								, prdtSVO.getsBabyCnt());

	        			data.setNmlAmt(nPrice2 <= 0 ? "" : "" + nPrice2);
        			} else {
        				data.setSaleAmt(amt.getSaleAmt());
        				data.setNmlAmt(amt.getNmlAmt());
        			}
        			data.setHotdallYn(amt.getHotdallYn());
        			data.setDaypriceYn(amt.getDaypriceYn());
        			data.setDaypriceAmt(amt.getDaypriceAmt());
        			data.setDisDaypriceAmt(amt.getDisDaypriceAmt());
        		}
			}
			//인원 추가요금
			if("Y".equals(data.getAddamtYn())) {
				AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
				ad_ADDAMTVO.setAplStartDt(prdtSVO.getsFromDt());
				ad_ADDAMTVO.setCorpId(data.getPrdtNum());

				AD_ADDAMTVO adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);

				if(adAddAmt == null) {
					ad_ADDAMTVO.setCorpId(ad_WEBDTLVO.getCorpId());

					adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);

					if(adAddAmt == null) {
						adAddAmt = new AD_ADDAMTVO();
						adAddAmt.setAdultAddAmt("0");
						adAddAmt.setJuniorAddAmt("0");
						adAddAmt.setChildAddAmt("0");
					}
				}
				data.setAdultAddAmt(adAddAmt.getAdultAddAmt());
				data.setJuniorAddAmt(adAddAmt.getJuniorAddAmt());
				data.setChildAddAmt(adAddAmt.getChildAddAmt());
			}
		}
    	model.addAttribute("prdtList", ad_prdtList);
		model.addAttribute("searchVO", prdtSVO );

		prdtSVO.setCorpId(corpVO.getCorpId());
		prdtSVO.setLon(corpVO.getLon());
		prdtSVO.setLat(corpVO.getLat());
		prdtSVO.setsRowCount("20");
		List<AD_WEBLIST4VO> listDist = webAdProductService.selectAdListDist(prdtSVO);
		model.addAttribute("listDist", listDist );

		// 주요정보 체크 리스트
    	List<CM_ICONINFVO> iconCdList = ossCmmService.selectCmIconinf(ad_WEBDTLVO.getCorpId(), Constant.ICON_CD_ADAT);
    	model.addAttribute("iconCdList", iconCdList);

    	// 연박의 요금 정보 리스트 (2017-06-29, By JDongS)
    	Map<String, String> ctnMap = new HashMap<String, String>();
    	ad_AMTINFSVO.setsPrdtNum(prdtSVO.getsPrdtNum());
    	List<AD_CTNAMTVO> ctnAmtList = webAdProductService.selectCtnAmtList(ad_AMTINFSVO);
    	for (AD_CTNAMTVO ctn : ctnAmtList) {
    		ctnMap.put(ctn.getAplNight(), ctn.getDisAmt());
    	}
    	model.addAttribute("ctnMap", ctnMap);

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

    	// 사용 가능 쿠폰 리스트
		CPSVO cpsVO = new CPSVO();
		cpsVO.setCorpId(ad_WEBDTLVO.getCorpId());

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
		prmtPrdtVO.setCorpId(ad_WEBDTLVO.getCorpId());
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
        	        	
        	pocket.setPrdtDiv(Constant.ACCOMMODATION);
        	pocket.setCorpId(corpVO.getCorpId());
        	pocketMapCnt = webMypageService.selectPocketList(pocket);
        	
        	pocketCnt = pocketMapCnt.size();
    	}   
    	model.addAttribute("pocketMap", pocketMap);
    	model.addAttribute("pocketCnt", pocketCnt);

    	/** 데이터제공 조회정보 수집*/
        ApiNextezPrcAdd apiNextezPrcAdd = new ApiNextezPrcAdd();
        apiNextezPrcAdd.setvConectDeviceNm("MOBILE");
        apiNextezPrcAdd.setvCtgr("AD");
        apiNextezPrcAdd.setvPrdtNum(corpVO.getCorpId());
        apiNextezPrcAdd.setvType("view");
		apiService.insertNexezData(apiNextezPrcAdd);

		/** 포인트 구매 필터 적용*/
		POINT_CORPVO pointCorpVO = new POINT_CORPVO();
		pointCorpVO.setCorpId(corpVO.getCorpId());
		pointCorpVO.setPartnerCode((String) request.getSession().getAttribute("ssPartnerCode"));
		String chkPointBuyAble = ossPointService.chkPointBuyAble(pointCorpVO);
		model.addAttribute("chkPointBuyAble", chkPointBuyAble);

		return "/mw/ad/detailPrdt";
    }

    @RequestMapping("/mw/ad/adDtlCalendar.ajax")
    public String adDtlCal(@ModelAttribute("ADDTLCALENDARVO") ADDTLCALENDARVO adCalendarVO,
							ModelMap model,
							HttpServletRequest request){

    	if(adCalendarVO.getPrdtNum() == null || adCalendarVO.getPrdtNum().isEmpty()){
    		log.info("ADError -MW- /mw/ad/adDtlCalendar.ajax prdtNum is Null");
    		model.addAttribute("adErr", 1 );
    		return "/mw/ad/adDtlCalendar";
    	}
    	model.addAttribute("adErr", 0 );

    	//년월 설정
   		Calendar calNow = Calendar.getInstance();
   		if( adCalendarVO.getiYear() == 0 || adCalendarVO.getiMonth()==0 ){


   			//초기에는 현재 달
   			calNow.set(Calendar.DATE, 1);
   			adCalendarVO.setiYear(calNow.get(Calendar.YEAR));
   			adCalendarVO.setiMonth(calNow.get(Calendar.MONTH)+1);
   			adCalendarVO.setiDay(calNow.get(Calendar.DATE));
   			adCalendarVO.setsFromDt(String.format("%d%02d%02d"
    									, calNow.get(Calendar.YEAR)
    									, calNow.get(Calendar.MONTH)+1
    									, calNow.get(Calendar.DATE) ) );

   		}else{
   			//날짜가 지정되면 그달

   			int nY = adCalendarVO.getiYear();
   			int nM = adCalendarVO.getiMonth();

   			//년넘어가는건 Calendar에서 알아서 처리해줌... 따라서 13월, -1월로 와도 아무 문제 없음.
   			if(adCalendarVO.getsPrevNext() != null){
	   			if("prev".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nM--;
	   			}else if ("next".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nM++;
	   			}else if("prevyear".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nY--;
	   			}else if("Nextyear".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nY++;
	   			}
   			}
   			calNow.set(nY, nM-1, 1);
   		}
    	adCalendarVO.initValue(calNow);

    	String strYYYYMM = String.format("%d%02d", adCalendarVO.getiYear(), adCalendarVO.getiMonth() );

    	//선택이 가능한 달
    	Calendar calTempPN = Calendar.getInstance();
    	String strPrevDt = String.format("%d%02d", calTempPN.get(Calendar.YEAR), calTempPN.get(Calendar.MONTH)+1 );
    	//calTempPN.add(Calendar.MONTH, 3);//3달 뒤
    	calTempPN.add(Calendar.MONTH, 12);//1년 뒤
    	String strNextDt = String.format("%d%02d", calTempPN.get(Calendar.YEAR), calTempPN.get(Calendar.MONTH)+1 );
    	//log.info(">>>>>>>>>>>>>>["+strPrevDt+"]["+strNextDt);


    	if( strPrevDt.compareTo(strYYYYMM) >= 0){
    		//log.info(">>>>>>>>>>>>>>["+strPrevDt+"]["+strYYYYMM+"]-x");
    		adCalendarVO.setPrevYn("N");

    	}else{
    		//log.info(">>>>>>>>>>>>>>["+strPrevDt+"]["+strYYYYMM+"]-o");
    		adCalendarVO.setPrevYn("Y");
    	}

    	if( strNextDt.compareTo(strYYYYMM) > 0){
    		//log.info(">>>>>>>>>>>>>>["+strNextDt+"]["+strYYYYMM+"]-o");
    		adCalendarVO.setNextYn("Y");
    	}else{
    		//log.info(">>>>>>>>>>>>>>["+strNextDt+"]["+strYYYYMM+"]-x");
    		adCalendarVO.setNextYn("N");
    	}

       	model.addAttribute("calendarVO", adCalendarVO );

       	//DB에서 가격 읽어오기
    	AD_AMTINFSVO ad_AMTINFSVO = new AD_AMTINFSVO();
    	ad_AMTINFSVO.setsPrdtNum( adCalendarVO.getPrdtNum() );
    	ad_AMTINFSVO.setsAplDt( strYYYYMM );
    	List<AD_AMTINFVO> resultAmtList = masAdPrdtService.selectAdAmtinfList(ad_AMTINFSVO);
		int nListAmtSize = resultAmtList.size();
		int nListAmtPos = 0;

		//DB에서 수량 읽어오기
    	AD_CNTINFSVO ad_CNTINFSVO = new AD_CNTINFSVO();
    	ad_CNTINFSVO.setsPrdtNum( adCalendarVO.getPrdtNum() );
    	ad_CNTINFSVO.setsAplDt( strYYYYMM );
    	List<AD_CNTINFVO> resultCntList = masAdPrdtService.selectAdCntinfList(ad_CNTINFSVO);
		int nListCntSize = resultCntList.size();
		int nListCntPos = 0;

       	//비교를 위해 오늘날짜 저장
       	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	String  strToday = sdf.format(now);

    	//날짜 선택을 위한 리스트
    	List<String> selCalList = new ArrayList<String>();
    	Calendar calTemp = Calendar.getInstance();
    	for(int i=0; i< adCalendarVO.getiNight(); i++){
    		calTemp.set( Integer.parseInt(adCalendarVO.getsFromDt().substring(0,4))
    					,Integer.parseInt(adCalendarVO.getsFromDt().substring(4,6))-1
    					,Integer.parseInt(adCalendarVO.getsFromDt().substring(6,8))+i
        				);

    		String strTemp = String.format("%d%02d%02d"
    									, calTemp.get(Calendar.YEAR)
    									, calTemp.get(Calendar.MONTH)+1
    									,calTemp.get(Calendar.DATE) );
    		selCalList.add(strTemp);
    	}

		//체크아웃날짜
		calTemp.set(Integer.parseInt(adCalendarVO.getsFromDt().substring(0, 4))
			, Integer.parseInt(adCalendarVO.getsFromDt().substring(4, 6)) - 1
			, Integer.parseInt(adCalendarVO.getsFromDt().substring(6, 8)) + adCalendarVO.getiNight());
		String checkOutDay = String.format("%d%02d%02d"
			, calTemp.get(Calendar.YEAR)
			, calTemp.get(Calendar.MONTH) + 1
			, calTemp.get(Calendar.DATE));

    	DecimalFormat df = new DecimalFormat("#,##0");

    	//---------------------------------
       	//달력의 각 날들 설정
    	List<ADDTLCALENDARVO> calList = new ArrayList<ADDTLCALENDARVO>();
    	for(int i=0; i<adCalendarVO.getiMonthLastDay(); i++){
    		ADDTLCALENDARVO adCal = new ADDTLCALENDARVO();
    		adCal.setiYear( adCalendarVO.getiYear() );
    		adCal.setiMonth( adCalendarVO.getiMonth() );
    		adCal.setiDay( i+1 );
    		if((adCalendarVO.getiWeek() + i)%7==0){
    			adCal.setiWeek( 7 );
    		}else{
    			adCal.setiWeek( (adCalendarVO.getiWeek() + i)%7 );
    		}
    		adCal.setsHolidayYN("N");
    		String strYYYYMMDD = String.format("%d%02d%02d", adCal.getiYear(), adCal.getiMonth(), adCal.getiDay() );

    		String strStAmt="", strStCnt="";

    		//데이터 가격 넣기
    		strStAmt = "D";
    		if(nListAmtPos < nListAmtSize){
	    		AD_AMTINFVO adAmt = resultAmtList.get(nListAmtPos);
	    		if(strYYYYMMDD.equals(adAmt.getAplDt()) ){
	    			//log.info(">>>:----------------C"+strYYYYMMDD + ":"+adAmt.getSaleAmt()+":"+adAmt.getNmlAmt() );

	    			if( adAmt.getSaleAmt() != null){
	    				adCal.setSaleAmt( df.format(Integer.parseInt( adAmt.getSaleAmt())));
	    			}else{
	    				adCal.setSaleAmt( adAmt.getSaleAmt());
	    			}

	    			adCal.setNmlAmt( adAmt.getNmlAmt());

					try {
						if (adAmt.getSaleAmt() != null && adAmt.getNmlAmt() != null && Integer.parseInt(adAmt.getSaleAmt()) != 0 && Integer.parseInt(adAmt.getNmlAmt()) != 0) {
							strStAmt = "E"; //예약
						} else {
							strStAmt = "M"; //마감
						}
					} catch (NumberFormatException e) {
						strStAmt = "M"; // 마감
					}

	    			nListAmtPos++;
	    		}
    		}

    		//데이터 수량 넣기
    		strStCnt = "D";
    		if(nListCntPos < nListCntSize){
	    		AD_CNTINFVO adCnt = resultCntList.get(nListCntPos);
	    		//String strYYYYMMDD = String.format("%d%02d%02d", adCal.getiYear(), adCal.getiMonth(), adCal.getiDay() );
	    		if(strYYYYMMDD.equals(adCnt.getAplDt()) ){
	    			adCal.setTotalRoomNum( adCnt.getTotalRoomNum() );
	    			adCal.setUseRoomNum( adCnt.getUseRoomNum() );
	    			adCal.setDdlYn( adCnt.getDdlYn() );

	    			if( "Y".equals(adCnt.getDdlYn()) ){
		    			//adCal.setStatus("M");
	    				strStCnt = "M";
	    			}else{
	    				if(adCnt.getTotalRoomNum()==null || adCnt.getUseRoomNum()==null){
	    					//adCal.setStatus("M");
	    					strStCnt = "M";
	    				}else{
			    			if( Integer.parseInt(adCnt.getTotalRoomNum()) <= Integer.parseInt(adCnt.getUseRoomNum()) ){
			    				//adCal.setStatus("M");
			    				strStCnt = "M";
			    			}else{
			    				strStCnt = "E";
			    			}
	    				}
	    			}
	    			nListCntPos++;
	    		}
    		}

			//오늘날짜 이전 날짜는 무조건 마감 처리
			if (strToday.compareTo(strYYYYMMDD) > 0) {
				// M : 마감
				adCal.setStatus("M");

			//오늘 날짜 당일예약 불가 체크  2022.01.20 chaewan.jung 추가
			}else if(strToday.compareTo(strYYYYMMDD) == 0){
				Map<String, String> dayRsvCntMap = new HashMap<String, String>();
				dayRsvCntMap.put("corpId", adCalendarVO.getCorpId());
				dayRsvCntMap.put("sFromDt", strToday);

				if (webAdProductService.getDayRsvCnt(dayRsvCntMap) == 0){
					adCal.setStatus("M");
				}else{
					if ("E".equals(strStCnt)) {
						if ("E".equals(strStAmt)) {
							adCal.setStatus("E");
						} else {
							adCal.setStatus(strStAmt);
						}
					} else {
						adCal.setStatus(strStCnt);
					}
				}

			}else {
				if ("E".equals(strStCnt)) {
					if ("E".equals(strStAmt)) {
						adCal.setStatus("E");
					} else {
						adCal.setStatus(strStAmt);
					}
				} else {
					adCal.setStatus(strStCnt);
				}
			}

    		//선택된거 색칠하기
    		adCal.setSelDayYn("N");
    		for (String strSel : selCalList) {
    			if(strSel.equals(strYYYYMMDD)){
        			adCal.setSelDayYn("Y");
        		}
			}
			if (checkOutDay.equals(strYYYYMMDD)){
				adCal.setSelDayYn("O");
			}

    		adCal.setsFromDt(strYYYYMMDD);

    		//log.info(">>>:"+ strYYYYMMDD+" - "+adCalendarVO.getsFromDt());
    		//if(strYYYYMMDD.equals(adCalendarVO.getsFromDt())){
    		//	adCal.setSelDayYn("Y");
    		//}else{
    		//	adCal.setSelDayYn("N");
    		//}

    		////공휴일 test
    		//if(i==7){
    		//	adCal.setsHolidayYN("Y");
    		//	adCal.setsHolidayNm("한글날");
    		//}

    		calList.add(adCal);

    		//log.info(">>>:"+ adCal.getiDay()+" ("+adCal.getiWeek() );
    	}
    	model.addAttribute("calList", calList );
    	//----------------------------달력의 각 날들 설정 end


    	//선택된방에 정보 구하기
    	AD_PRDTINFVO ad_PRDINFVO = new AD_PRDTINFVO();
    	ad_PRDINFVO.setPrdtNum(adCalendarVO.getPrdtNum());
    	AD_PRDTINFVO adPrdtInf = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);

    	if(adPrdtInf.getMemExcdAbleYn().equals("N") ){
    		adPrdtInf.setMaxiMem(adPrdtInf.getStdMem());
		}
    	model.addAttribute("adPrdtInf", adPrdtInf );

    	//Ajax실행 후 스크립트 실행 할때 필요한 정보 읽기
    	//if( "CR".equals(adCalendarVO.getScriptVal()) ){
    		/*
    		//선택된방에 정보 구하기
	    	AD_PRDTINFVO ad_PRDINFVO = new AD_PRDTINFVO();
	    	ad_PRDINFVO.setPrdtNum(adCalendarVO.getPrdtNum());
	    	AD_PRDTINFVO adPrdtInf = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);

	    	if(adPrdtInf.getMemExcdAbleYn().equals("N") ){
	    		adPrdtInf.setMaxiMem(adPrdtInf.getStdMem());
			}
	    	model.addAttribute("adPrdtInf", adPrdtInf );
	    	*/

    	//}

    	//객실 추가 요금 얻기
		AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
		ad_ADDAMTVO.setAplStartDt( adCalendarVO.getsFromDt() );
		ad_ADDAMTVO.setCorpId( adCalendarVO.getPrdtNum() );
		AD_ADDAMTVO adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
		//System.out.println("---------------------1[[["+adCalendarVO.getsFromDt() + " - " + adCalendarVO.getPrdtNum());
		if(adAddAmt == null){
			//숙소 추가 요금 얻기
    		ad_ADDAMTVO.setCorpId( adCalendarVO.getCorpId() );
			adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
			//System.out.println("---------------------2[[["+adCalendarVO.getsFromDt() + " - "+adCalendarVO.getCorpId() );
			if(adAddAmt == null){
				adAddAmt = new AD_ADDAMTVO();
				adAddAmt.setAdultAddAmt("0");
				adAddAmt.setJuniorAddAmt("0");
				adAddAmt.setChildAddAmt("0");
			}
		}
		model.addAttribute("adAddAmtCal", adAddAmt );
    	return "/mw/ad/adDtlCalendar";
    }


    @RequestMapping("/web/mw/adDtlAddPrdt.ajax")
    public void adDtlAddPrdt(@ModelAttribute("ADDTLCALENDARVO") ADDTLCALENDARVO adCalendarVO,
				    		HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model) throws Exception{

    	//log.info(">>>>>>>>>/web/ad/adDtlAddPrdt.ajax>["
    	//		+ adCalendarVO.getPrdtNum() + "]["
    	//		+ adCalendarVO.getsFromDt() + "]["
    	//		+ adCalendarVO.getiNight() + "]["
    	//		+ adCalendarVO.getAdCalMen1() + "]["
    	//		+ adCalendarVO.getAdCalMen2() + "]["
    	//		+ adCalendarVO.getAdCalMen3() + "]["
    	//		);


    //	int nPrice = webAdProductService.getTotalPrice(  adCalendarVO.getPrdtNum()
	//													, adCalendarVO.getsFromDt()
	//													, adCalendarVO.getiNight()
	//													, adCalendarVO.getAdCalMen1()
	//													, adCalendarVO.getAdCalMen2()
	//													, adCalendarVO.getAdCalMen3());    	
    	
    	ADTOTALPRICEVO adTotPrice = new ADTOTALPRICEVO();
		adTotPrice.setPrdtNum(adCalendarVO.getPrdtNum());
		adTotPrice.setsFromDt(adCalendarVO.getsFromDt());
		adTotPrice.setiNight(adCalendarVO.getiNight());
		adTotPrice.setiMenAdult(adCalendarVO.getAdCalMen1());
		adTotPrice.setiMenJunior(adCalendarVO.getAdCalMen2());
		adTotPrice.setiMenChild(adCalendarVO.getAdCalMen3());
		
		ADTOTALPRICEVO adResultPrice = webAdProductService.getTotalPrice(adTotPrice.getPrdtNum(), adTotPrice);


    	JSONObject jsnObj = new JSONObject();

    	if(adResultPrice.getiTotalPrice() > 0){
    		jsnObj.put("Status", "1");
    		jsnObj.put("Price", adResultPrice.getiTotalPrice());
    		jsnObj.put("OverAmt", adResultPrice.getiTotalOverAmt());
    	}else{
    		jsnObj.put("Status", ""+adResultPrice.getiTotalPrice());
    		jsnObj.put("Price", "0");
    		jsnObj.put("OverAmt", "0");
    	}

		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.print(jsnObj.toString());
		printWriter.flush();
		printWriter.close();
    }

	@RequestMapping("/mw/selectAdNmList.ajax")
	public ModelAndView selectAdNmList(@ModelAttribute("USERVO") AD_WEBLISTSVO adWebdtlsvo) {


		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<AD_WEBLISTVO> listArray = webAdProductService.selectAdNmList(adWebdtlsvo);

		resultMap.put("data", listArray);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	@RequestMapping("/mw/ad/intro.do")
	public String oldIntro() {
		return "redirect:/mw/stay/jeju.do";
	}

	@RequestMapping("/mw/stay/jeju.do")
	public String intro(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO,
						   ModelMap model) {

		//진행중인 프로모션
		MAINPRMTVO mainPrmtVO = new MAINPRMTVO();
		List<MAINPRMTVO> mainPrmtList = masPrmtService.selectMainPrmtMain(mainPrmtVO);
		model.addAttribute("prmtIngList", mainPrmtList);

		// 프로모션 상품
		List<AD_WEBLISTVO> prmtList = webAdProductService.selectAdBestList();
		List<MAINPRDTVO> bestList = webMainService.selectBestAd();
		model.addAttribute("adPrmt", webPrmtService.selectAdBanner());
		model.addAttribute("prmtList", prmtList);
		model.addAttribute("bestList", bestList);

		return "/mw/ad/intro";
	}
}
