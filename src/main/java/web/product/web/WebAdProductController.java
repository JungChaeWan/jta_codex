package web.product.web;


import api.service.APIService;
import api.vo.ApiNextezPrcAdd;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovWebUtil;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.*;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import oss.ad.vo.*;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_ICONINFVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPSVO;
import oss.coupon.vo.CPVO;
import oss.env.service.OssSiteManageService;
import oss.env.vo.DFTINFVO;
import oss.marketing.serive.OssAdmRcmdService;
import oss.marketing.vo.ADMRCMDVO;
import oss.point.service.OssPointService;
import oss.point.vo.POINT_CORPVO;
import oss.user.vo.USERVO;
import web.main.service.WebMainService;
import web.main.vo.MAINPRDTVO;
import web.mypage.service.WebMypageService;
import web.mypage.vo.POCKETVO;
import web.product.service.WebAdProductService;
import web.product.service.WebPrdtInqService;
import web.product.service.WebPrmtService;
import web.product.service.WebRcProductService;
import web.product.vo.ADTOTALPRICEVO;
import web.product.vo.PRDTINQVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.*;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;


@Controller
public class WebAdProductController {

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name = "webAdProductService")
    protected WebAdProductService webAdProductService;

    @Resource(name = "webRcProductService")
    protected WebRcProductService webRcProductService;

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

    @Resource(name = "webMypageService")
    protected WebMypageService webMypageService;

    @Resource(name = "ossCouponService")
    protected OssCouponService ossCouponService;

    @Resource(name = "webPrmtService")
    protected WebPrmtService webPrmtService;

    @Resource(name = "webMainService")
    private WebMainService webMainService;

    @Resource(name = "apiService")
    private APIService apiService;

    @Autowired
    private OssPointService ossPointService;

    Logger log = (Logger) LogManager.getLogger(this.getClass());

    @RequestMapping("/web/ad/productList.do")
    public String productList(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO,
                              ModelMap model,
                              HttpServletRequest request) {
        return "redirect:/web/stay/jeju.do";
    }


    @RequestMapping("/web/ad/mainList.do")
	public String oldIntro() {
		return "redirect:/web/stay/jeju.do";
	}

    @RequestMapping("/web/stay/jeju.do")
    public String mainList(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO,
                           ModelMap model,
                           HttpServletRequest request) {
        try {
            if (EgovClntInfo.isMobile(request)) {
                return "forward:/mw/stay/jeju.do";
            }
        } catch (Exception e) {
            log.error(e.toString());
        }
        //초기 날짜 지정
        Calendar calNow = Calendar.getInstance();

        if (StringUtils.isEmpty(prdtSVO.getsFromDt())) {
            calNow.add(Calendar.DAY_OF_MONTH, 1);
            prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
            prdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
            prdtSVO.setsFromDtMap(EgovStringUtil.getDateFormatDash(calNow));
        }
        if (StringUtils.isEmpty(prdtSVO.getsToDt())) {
            calNow.add(Calendar.DAY_OF_MONTH, 1);
            prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
            prdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
            prdtSVO.setsToDtMap(EgovStringUtil.getDateFormatDash(calNow));
        }

        // 기본정보 조회
        DFTINFVO dftInf = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);

        if (StringUtils.isEmpty(prdtSVO.getOrderCd())) {
            prdtSVO.setOrderCd(dftInf.getAdSortStd());
        }
        if (StringUtils.isEmpty(prdtSVO.getOrderAsc())) {
            prdtSVO.setOrderAsc(dftInf.getAdSortAsc());
        }

        //박이 없으면 1박
        if (StringUtils.isEmpty(prdtSVO.getsNights())) {
            prdtSVO.setsNights("1");
        }

        // 인원이 없으면 2명
        if (StringUtils.isEmpty(prdtSVO.getsMen())) {
            prdtSVO.setsMen("2");
        }

        //코드 정보 얻기
        List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
        model.addAttribute("cdAdar", cdAdar);

        List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
        model.addAttribute("cdAddv", cdAddv);

        List<CDVO> cdAdat = ossCmmService.selectCode("ADAT");
        model.addAttribute("cdAdat", cdAdat);

        model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

        // 프로모션 상품
        List<AD_WEBLISTVO> prmtList = webAdProductService.selectAdBestList();
        List<MAINPRDTVO> bestList = webMainService.selectBestAd();
        model.addAttribute("prmtList", prmtList);
        model.addAttribute("bestList", bestList);
        model.addAttribute("adPrmt", webPrmtService.selectAdBanner());
        return "/web/ad/mainList";
    }

    @RequestMapping("/web/ad/adList.ajax")
    public String adList(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO,
                         HttpServletRequest request,
                         ModelMap model) {
        log.info("/web/ad/adList.ajax CALL");
        prdtSVO.setsAdAdar("");
        prdtSVO.setsAdDiv("");

        prdtSVO.setPageUnit(10000);
        prdtSVO.setPageSize(propertiesService.getInt("webPageSize"));

        //SQL Injection 대응. 체크인, 체크아웃 날짜가 잘 못 되었을 경우 처리. 2021.08.03 chaewan.jung
        Calendar calNow = Calendar.getInstance();
        if (!EgovStringUtil.checkDate(prdtSVO.getsFromDt())) {
            calNow.add(Calendar.DAY_OF_MONTH, 1);
            prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
            prdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
            prdtSVO.setsFromDtMap(EgovStringUtil.getDateFormatDash(calNow));
        }
        if (!EgovStringUtil.checkDate(prdtSVO.getsToDt())) {
            calNow.add(Calendar.DAY_OF_MONTH, 1);
            prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
            prdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
            prdtSVO.setsToDtMap(EgovStringUtil.getDateFormatDash(calNow));
        }

        /** pageing setting */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(prdtSVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(prdtSVO.getPageUnit());
        paginationInfo.setPageSize(prdtSVO.getPageSize());

        prdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        prdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
        prdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        @SuppressWarnings("unchecked")
        List<AD_WEBLISTVO> resultList = webAdProductService.selectAdList(prdtSVO);

        // MD's Pick Random 배너
        /*ADMRCMDVO admRcmdVO = new ADMRCMDVO();
        admRcmdVO.setCorpModCd("CADO");
        List<ADMRCMDVO> mdsPickList = ossAdmRcmdService.selectAdmRcmdWebRandomList(admRcmdVO);
        model.addAttribute("mdsPickList", mdsPickList);*/

        model.addAttribute("resultList", resultList);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("sNights", prdtSVO.getsNights());

        model.addAttribute("totSch", request.getParameter("totSch"));

        // 찜하기 정보 (2017-11-24, By JDongS)
        /*POCKETVO pocket = new POCKETVO();
        Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();
        USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (userVO != null) {
            pocket.setUserId(userVO.getUserId());
            pocket.setPrdtDiv(Constant.ACCOMMODATION);
            pocketMap = webMypageService.selectPocketList(pocket);
        }
        model.addAttribute("pocketMap", pocketMap);*/

        return "/web/ad/adList";
    }

    /**
     * 숙소 지도보기
     * 파일명 : mapAdList
     * 작성일 : 2020.09.04
     * 작성자 : 김지연
     *
     * @param : mainSVO
     * @return
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/web/mapAdList.ajax")
    public ModelAndView mapAdList(@ModelAttribute("searchVO") AD_WEBLISTSVO prdtSVO) {

        prdtSVO.setPageUnit(10000);
        prdtSVO.setPageSize(propertiesService.getInt("webPageSize"));

        /** pageing setting */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(prdtSVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(prdtSVO.getPageUnit());
        paginationInfo.setPageSize(prdtSVO.getPageSize());

        prdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        prdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
        prdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        //예약가능 리스트만
        prdtSVO.setRsvAbleYn("Y");

        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<AD_WEBLISTVO> mapAdList = new ArrayList<AD_WEBLISTVO>();

        mapAdList = (List<AD_WEBLISTVO>) webAdProductService.selectAdPrdtList(prdtSVO).get("resultList");
        resultMap.put("mapAdList", mapAdList);

        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }


    @RequestMapping("/web/ad/detailPrdt.do")
    public String detailPrdt(@ModelAttribute("searchVO") AD_WEBDTLSVO prdtSVO,
                             ModelMap model,
                             HttpServletRequest request) throws Exception {
        log.info("/web/ad/detailPrdt.do call");

        String prdtNum = prdtSVO.getsPrdtNum();
        String corpId = prdtSVO.getCorpId();

        if (EgovClntInfo.isMobile(request)) {
            if (corpId != null) {
                return "redirect:/mw/ad/detailPrdt.do?corpId=" + corpId;
            } else {
                return "redirect:/mw/ad/detailPrdt.do?sPrdtNum=" + prdtNum;
            }
        }
        //객실 번호가 없으면 대표객실 번호 가져오기
        if (EgovStringUtil.isEmpty(prdtNum)) {
        	log.error("WEB AD : prdtNum is null");
            if (EgovStringUtil.isEmpty(corpId)) {
                log.error("prdtNum, corpId is null");
                return "redirect:/web/stay/jeju.do";
            }
            AD_PRDTINFVO adPrdt = new AD_PRDTINFVO();
            adPrdt.setCorpId(corpId);

            AD_PRDTINFVO adPrdtRes = webAdProductService.selectPrdtInfByMaster(adPrdt);

            if (adPrdtRes == null) {
                log.error("adPrdtRes is null");
                return "redirect:/web/cmm/error.do?errCord=PRDT01";
            } else {
                prdtNum = adPrdtRes.getPrdtNum();
                prdtSVO.setsPrdtNum(prdtNum);
            }
        }

        if (prdtSVO.getsSearchYn() == null) {
            prdtSVO.setsSearchYn(Constant.FLAG_N);
        }

        AD_WEBDTLVO ad_WEBDTLVO = webAdProductService.selectWebdtlByPrdt(prdtSVO);

        ad_WEBDTLVO.setTip(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getTip()));
        ad_WEBDTLVO.setTip(ad_WEBDTLVO.getTip().replaceAll("\n", "<br/>\n"));

        ad_WEBDTLVO.setInfIntrolod(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfIntrolod()));
        ad_WEBDTLVO.setInfIntrolod(ad_WEBDTLVO.getInfIntrolod().replaceAll("\n", "<br/>\n"));

        ad_WEBDTLVO.setInfEquinf(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfEquinf()));
        ad_WEBDTLVO.setInfEquinf(ad_WEBDTLVO.getInfEquinf().replaceAll("\n", "<br/>\n"));

        ad_WEBDTLVO.setInfOpergud(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfOpergud()));
        ad_WEBDTLVO.setInfOpergud(ad_WEBDTLVO.getInfOpergud().replaceAll("\n", "<br/>\n"));

        ad_WEBDTLVO.setInfNti(EgovWebUtil.clearXSSMinimum(ad_WEBDTLVO.getInfNti()));
        ad_WEBDTLVO.setInfNti(ad_WEBDTLVO.getInfNti().replaceAll("\n", "<br/>\n"));

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

        //날짜가 없으면 익일날짜
        if (StringUtils.isEmpty(prdtSVO.getsFromDt())) {
            calNow.add(Calendar.DAY_OF_MONTH, 1);
            prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
            prdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
        }
        if (StringUtils.isEmpty(prdtSVO.getsToDt())) {
            calNow.add(Calendar.DAY_OF_MONTH, 1);
            prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
            prdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
        }
        //박이 없으면 1박
        if (StringUtils.isEmpty(prdtSVO.getsNights())) {
            prdtSVO.setsNights("1");
        }
        // 인원수가 없으면
        if (StringUtils.isEmpty(prdtSVO.getsAdultCnt())) {
            prdtSVO.setsAdultCnt("2");
            prdtSVO.setsChildCnt("0");
            prdtSVO.setsBabyCnt("0");
        }
        // 객실수가 없으면
        if (StringUtils.isEmpty(prdtSVO.getsRoomNum())) {
            prdtSVO.setsRoomNum("1");
        }
        model.addAttribute("searchVO", prdtSVO);

        //상품의 업체정보의 LAT, LON 정보를 가져와야 함. 명칭은 나중에 수정해 주세요.
        CORPVO corpSVO = new CORPVO();
        corpSVO.setCorpId(ad_WEBDTLVO.getCorpId());

        CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);

        model.addAttribute("corpVO", corpVO);

        //업체가 승인중이 아닐때 오류 페이지로
        if (!Constant.TRADE_STATUS_APPR.equals(corpVO.getTradeStatusCd())) {
            return "redirect:/web/cmm/error.do?errCord=PRDT01";
        }

        //숙소 이미지
        CM_IMGVO imgVO = new CM_IMGVO();
        imgVO.setLinkNum(ad_WEBDTLVO.getCorpId().toUpperCase());

        List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);

        model.addAttribute("adImgList", imgList);

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
            if (adPrdt.getPrdtNum().endsWith(prdtSVO.getsPrdtNum())) {
                //추가 인원 허안 안할때 기준인원을 최대 인원으로
                if ("N".equals(adPrdt.getMemExcdAbleYn())) {
                    adPrdt.setMaxiMem(adPrdt.getStdMem());
                }
                model.addAttribute("adPtdt", adPrdt);
                break;
            }
        }
        log.info(">>>>>>>>>>" + prdtSVO.getsFromDt());

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
        
        //객실 이미지 & 판매가격 조합s
        for (AD_PRDTINFVO data : ad_prdtList) {
            CM_IMGVO imgPdtVO = new CM_IMGVO();
            imgPdtVO.setLinkNum(data.getPrdtNum());

            List<CM_IMGVO> prdtImgList = ossCmmService.selectImgList(imgPdtVO);

            data.setImgList(prdtImgList);

            for (AD_AMTINFVO amt : ad_amtList) {
                if (data.getPrdtNum().equals(amt.getPrdtNum())) {
                    if ("Y".equals(prdtSVO.getsSearchYn())) {
                        // 예약 가능 여부 체크
                        int nPrice = webAdProductService.getTotalPrice(data.getPrdtNum()
                            , prdtSVO.getsFromDt()
                            , prdtSVO.getsNights()
                            , prdtSVO.getsAdultCnt()
                            , prdtSVO.getsChildCnt()
                            , prdtSVO.getsBabyCnt());

                        data.setSaleAmt(nPrice <= 0 ? "" : "" + nPrice);    // amt.getSaleAmt()

                        int nPrice2 = webAdProductService.getNmlAmt(data.getPrdtNum()
                            , prdtSVO.getsFromDt()
                            , prdtSVO.getsNights()
                            , prdtSVO.getsAdultCnt()
                            , prdtSVO.getsChildCnt()
                            , prdtSVO.getsBabyCnt());

                        data.setNmlAmt(nPrice2 <= 0 ? "" : "" + nPrice2);    // amt.getSaleAmt()
                    } else {
                        data.setSaleAmt(amt.getSaleAmt());
                        data.setNmlAmt(amt.getNmlAmt());
                    }
                    data.setHotdallYn(amt.getHotdallYn());
                    data.setDaypriceYn(amt.getDaypriceYn());
                    data.setDaypriceAmt(amt.getDaypriceAmt());
                    data.setDisDaypriceAmt(amt.getDisDaypriceAmt());
                    //log.info(">>>>>>>>>>" +amt.getSaleAmt() );
                }
            }
            //인원 추가요금
            if ("Y".equals(data.getAddamtYn())) {
                AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
                ad_ADDAMTVO.setAplStartDt(prdtSVO.getsFromDt());
                ad_ADDAMTVO.setCorpId(data.getPrdtNum());

                AD_ADDAMTVO adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);

                if (adAddAmt == null) {
                    ad_ADDAMTVO.setCorpId(ad_WEBDTLVO.getCorpId());

                    adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);

                    if (adAddAmt == null) {
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
            //log.info(">>>>>>>>>>HotdallYn:" +data.getHotdallYn() +" DaypriceYn:" +data.getDaypriceYn()+" DaypriceAmt:" + data.getDaypriceAmt());
        }
        model.addAttribute("prdtList", ad_prdtList);
        model.addAttribute("searchVO", prdtSVO);

        prdtSVO.setCorpId(corpVO.getCorpId());
        prdtSVO.setLon(corpVO.getLon());
        prdtSVO.setLat(corpVO.getLat());
        prdtSVO.setsRowCount("20");

        List<AD_WEBLIST4VO> listDist = webAdProductService.selectAdListDist(prdtSVO);

        model.addAttribute("listDist", listDist);

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

        //코드 정보 얻기
        List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");

        model.addAttribute("cdAdar", cdAdar);

        // 사용 가능 쿠폰 리스트
        CPSVO cpsVO = new CPSVO();
        cpsVO.setCorpId(ad_WEBDTLVO.getCorpId());

        List<CPVO> couponList = ossCouponService.selectCouponListWeb(cpsVO);

        model.addAttribute("couponList", couponList);

        // 관련 프로모션 정보
        PRMTPRDTVO prmtPrdtVO = new PRMTPRDTVO();
        prmtPrdtVO.setCorpId(ad_WEBDTLVO.getCorpId());

        List<PRMTVO> prmtList = webPrmtService.selectDeteilPromotionList(prmtPrdtVO);

        model.addAttribute("prmtList", prmtList);

        // 찜하기 정보 (2017-11-24, By JDongS)
        int pocketCnt = 0;
        POCKETVO pocket = new POCKETVO();
        Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();

        USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

        if (userVO != null) {
            pocket.setUserId(userVO.getUserId());

            pocketMap = webMypageService.selectPocketList(pocket);

            pocket.setPrdtDiv(Constant.ACCOMMODATION);
            pocket.setCorpId(corpVO.getCorpId());

            Map<String, POCKETVO> pocketMapCnt = webMypageService.selectPocketList(pocket);

            pocketCnt = pocketMapCnt.size();
        }

        model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

        /** 데이터제공 조회정보 수집*/
        ApiNextezPrcAdd apiNextezPrcAdd = new ApiNextezPrcAdd();
        apiNextezPrcAdd.setvConectDeviceNm("PC");
        apiNextezPrcAdd.setvCtgr("AD");
        apiNextezPrcAdd.setvPrdtNum(corpVO.getCorpId());
        apiNextezPrcAdd.setvType("view");
        /*apiNextezPrcAdd.setvVal1("");*/
        apiService.insertNexezData(apiNextezPrcAdd);

        model.addAttribute("pocketMap", pocketMap);
        model.addAttribute("pocketCnt", pocketCnt);

        /** 포인트 구매 필터 적용*/
        POINT_CORPVO pointCorpVO = new POINT_CORPVO();
        pointCorpVO.setCorpId(corpVO.getCorpId());
        pointCorpVO.setPartnerCode((String) request.getSession().getAttribute("ssPartnerCode"));
        String chkPointBuyAble = ossPointService.chkPointBuyAble(pointCorpVO);
        model.addAttribute("chkPointBuyAble", chkPointBuyAble);

        return "/web/ad/detailPrdt";
    }

    @RequestMapping("/web/ad/adDtlCalendar.ajax")
    public String adDtlCal(@ModelAttribute("ADDTLCALENDARVO") ADDTLCALENDARVO adCalendarVO,
                           ModelMap model,
                           HttpServletRequest request) {

        if (adCalendarVO.getPrdtNum() == null || adCalendarVO.getPrdtNum().isEmpty()) {
            log.info("ADError -PC- /web/ad/adDtlCalendar.ajax prdtNum is Null");
            model.addAttribute("adErr", 1);
            return "/web/ad/adDtlCalendar";
        }
        model.addAttribute("adErr", 0);

        //년월 설정
        Calendar calNow = Calendar.getInstance();
        if (adCalendarVO.getiYear() == 0 || adCalendarVO.getiMonth() == 0) {
            //초기에는 현재 달
            calNow.set(Calendar.DATE, 1);
            adCalendarVO.setiYear(calNow.get(Calendar.YEAR));
            adCalendarVO.setiMonth(calNow.get(Calendar.MONTH) + 1);
            adCalendarVO.setiDay(calNow.get(Calendar.DATE));
            adCalendarVO.setsFromDt(String.format("%d%02d%02d"
                , calNow.get(Calendar.YEAR)
                , calNow.get(Calendar.MONTH) + 1
                , calNow.get(Calendar.DATE)));

        } else {
            //날짜가 지정되면 그달

            int nY = adCalendarVO.getiYear();
            int nM = adCalendarVO.getiMonth();

            //년넘어가는건 Calendar에서 알아서 처리해줌... 따라서 13월, -1월로 와도 아무 문제 없음.
            if (adCalendarVO.getsPrevNext() != null) {
                if ("prev".equals(adCalendarVO.getsPrevNext().toLowerCase())) {
                    nM--;
                } else if ("next".equals(adCalendarVO.getsPrevNext().toLowerCase())) {
                    nM++;
                } else if ("prevyear".equals(adCalendarVO.getsPrevNext().toLowerCase())) {
                    nY--;
                } else if ("Nextyear".equals(adCalendarVO.getsPrevNext().toLowerCase())) {
                    nY++;
                }
            }
            calNow.set(nY, nM - 1, 1);
        }
        adCalendarVO.initValue(calNow);

        String strYYYYMM = String.format("%d%02d", adCalendarVO.getiYear(), adCalendarVO.getiMonth());

        //선택이 가능한 달
        Calendar calTempPN = Calendar.getInstance();
        String strPrevDt = String.format("%d%02d", calTempPN.get(Calendar.YEAR), calTempPN.get(Calendar.MONTH) + 1);
        calTempPN.add(Calendar.MONTH, 12);//1년 뒤
        String strNextDt = String.format("%d%02d", calTempPN.get(Calendar.YEAR), calTempPN.get(Calendar.MONTH) + 1);

        if (strPrevDt.compareTo(strYYYYMM) >= 0) {
            adCalendarVO.setPrevYn("N");

        } else {
            adCalendarVO.setPrevYn("Y");
        }

        if (strNextDt.compareTo(strYYYYMM) > 0) {
            adCalendarVO.setNextYn("Y");
        } else {
            adCalendarVO.setNextYn("N");
        }
        model.addAttribute("calendarVO", adCalendarVO);

        //DB에서 가격 읽어오기
        AD_AMTINFSVO ad_AMTINFSVO = new AD_AMTINFSVO();
        ad_AMTINFSVO.setsPrdtNum(adCalendarVO.getPrdtNum());
        ad_AMTINFSVO.setsAplDt(strYYYYMM);
        List<AD_AMTINFVO> resultAmtList = masAdPrdtService.selectAdAmtinfList(ad_AMTINFSVO);
        int nListAmtSize = resultAmtList.size();
        int nListAmtPos = 0;


        //DB에서 수량 읽어오기
        AD_CNTINFSVO ad_CNTINFSVO = new AD_CNTINFSVO();
        ad_CNTINFSVO.setsPrdtNum(adCalendarVO.getPrdtNum());
        ad_CNTINFSVO.setsAplDt(strYYYYMM);
        List<AD_CNTINFVO> resultCntList = masAdPrdtService.selectWebAdCntInfList(ad_CNTINFSVO);
        int nListCntSize = resultCntList.size();
        int nListCntPos = 0;

        //비교를 위해 오늘날짜 저장
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String strToday = sdf.format(now);

        //날짜 선택을 위한 리스트
        List<String> selCalList = new ArrayList<String>();
        Calendar calTemp = Calendar.getInstance();
        for (int i = 0; i < adCalendarVO.getiNight(); i++) {
            calTemp.set(Integer.parseInt(adCalendarVO.getsFromDt().substring(0, 4))
                , Integer.parseInt(adCalendarVO.getsFromDt().substring(4, 6)) - 1
                , Integer.parseInt(adCalendarVO.getsFromDt().substring(6, 8)) + i
            );

            String strTemp = String.format("%d%02d%02d"
                , calTemp.get(Calendar.YEAR)
                , calTemp.get(Calendar.MONTH) + 1
                , calTemp.get(Calendar.DATE));
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
        for (int i = 0; i < adCalendarVO.getiMonthLastDay(); i++) {
            ADDTLCALENDARVO adCal = new ADDTLCALENDARVO();
            adCal.setiYear(adCalendarVO.getiYear());
            adCal.setiMonth(adCalendarVO.getiMonth());
            adCal.setiDay(i + 1);
            if ((adCalendarVO.getiWeek() + i) % 7 == 0) {
                adCal.setiWeek(7);
            } else {
                adCal.setiWeek((adCalendarVO.getiWeek() + i) % 7);
            }

            adCal.setsHolidayYN("N");
            String strYYYYMMDD = String.format("%d%02d%02d", adCal.getiYear(), adCal.getiMonth(), adCal.getiDay());

            String strStAmt = "", strStCnt = "";

            //데이터 가격 넣기
            // D : 미정
            strStAmt = "D";
            if (nListAmtPos < nListAmtSize) {
                AD_AMTINFVO adAmt = resultAmtList.get(nListAmtPos);
                if (strYYYYMMDD.equals(adAmt.getAplDt())) {

                    if (adAmt.getSaleAmt() != null) {
                        adCal.setSaleAmt(df.format(Integer.parseInt(adAmt.getSaleAmt())));
                    } else {
                        adCal.setSaleAmt(adAmt.getSaleAmt());
                    }

                    adCal.setNmlAmt(adAmt.getNmlAmt());

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
            if (nListCntPos < nListCntSize) {
                AD_CNTINFVO adCnt = resultCntList.get(nListCntPos);
                //String strYYYYMMDD = String.format("%d%02d%02d", adCal.getiYear(), adCal.getiMonth(), adCal.getiDay() );
                if (strYYYYMMDD.equals(adCnt.getAplDt())) {
                    adCal.setTotalRoomNum(adCnt.getTotalRoomNum());
                    adCal.setUseRoomNum(adCnt.getUseRoomNum());
                    adCal.setDdlYn(adCnt.getDdlYn());

                    if ("Y".equals(adCnt.getDdlYn())) {
                        // M : 마감
                        strStCnt = "M";
                    } else {
                        if (adCnt.getTotalRoomNum() == null || adCnt.getUseRoomNum() == null) {
                            // M : 마감
                            strStCnt = "M";
                        } else {
                            if (Integer.parseInt(adCnt.getTotalRoomNum()) <= Integer.parseInt(adCnt.getUseRoomNum())) {
                                // M : 마감
                                strStCnt = "M";
                            } else {
                                // E : 예약
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

            //오늘 날짜 당일예약 불가 체크  2022.01.07 chaewan.jung 추가
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
                if (strSel.equals(strYYYYMMDD)) {
                    adCal.setSelDayYn("Y");
                }
            }

            if (checkOutDay.equals(strYYYYMMDD)){
                adCal.setSelDayYn("O");
            }

            adCal.setsFromDt(strYYYYMMDD);

            calList.add(adCal);

        }
        model.addAttribute("calList", calList);
        //----------------------------달력의 각 날들 설정 end


        //선택된방에 정보 구하기
        AD_PRDTINFVO ad_PRDINFVO = new AD_PRDTINFVO();
        ad_PRDINFVO.setPrdtNum(adCalendarVO.getPrdtNum());
        AD_PRDTINFVO adPrdtInf = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);

        if (adPrdtInf.getMemExcdAbleYn().equals("N")) {
            adPrdtInf.setMaxiMem(adPrdtInf.getStdMem());
        }
        model.addAttribute("adPrdtInf", adPrdtInf);

        //객실 추가 요금 얻기
        AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
        ad_ADDAMTVO.setAplStartDt(adCalendarVO.getsFromDt());
        ad_ADDAMTVO.setCorpId(adCalendarVO.getPrdtNum());
        AD_ADDAMTVO adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
        //System.out.println("---------------------1[[["+adCalendarVO.getsFromDt() + " - " + adCalendarVO.getPrdtNum());
        if (adAddAmt == null) {
            //숙소 추가 요금 얻기
            ad_ADDAMTVO.setCorpId(adCalendarVO.getCorpId());
            adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
            //System.out.println("---------------------2[[["+adCalendarVO.getsFromDt() + " - "+adCalendarVO.getCorpId() );
            if (adAddAmt == null) {
                adAddAmt = new AD_ADDAMTVO();
                adAddAmt.setAdultAddAmt("0");
                adAddAmt.setJuniorAddAmt("0");
                adAddAmt.setChildAddAmt("0");
            }
        }
        model.addAttribute("adAddAmtCal", adAddAmt);

        return "/web/ad/adDtlCalendar";
    }


    @RequestMapping("/web/ad/adDtlAddPrdt.ajax")
    public void adDtlAddPrdt(@ModelAttribute("ADDTLCALENDARVO") ADDTLCALENDARVO adCalendarVO,
                             HttpServletRequest request,
                             HttpServletResponse response,
                             ModelMap model) throws Exception {

        ADTOTALPRICEVO adTotPrice = new ADTOTALPRICEVO();
        adTotPrice.setPrdtNum(adCalendarVO.getPrdtNum());
        adTotPrice.setsFromDt(adCalendarVO.getsFromDt());
        adTotPrice.setiNight(adCalendarVO.getiNight());
        adTotPrice.setiMenAdult(adCalendarVO.getAdCalMen1());
        adTotPrice.setiMenJunior(adCalendarVO.getAdCalMen2());
        adTotPrice.setiMenChild(adCalendarVO.getAdCalMen3());

        ADTOTALPRICEVO adResultPrice = webAdProductService.getTotalPrice(adTotPrice.getPrdtNum(), adTotPrice);

        JSONObject jsnObj = new JSONObject();

        if (adResultPrice.getiTotalPrice() > 0) {
            jsnObj.put("Status", "1");
            jsnObj.put("Price", adResultPrice.getiTotalPrice());
            jsnObj.put("OverAmt", adResultPrice.getiTotalOverAmt());
            jsnObj.put("adultAddAmt", adResultPrice.getiAdultAddAmt());
            jsnObj.put("childAddAmt", adResultPrice.getiChildAddAmt());
            jsnObj.put("juniorAddAmt", adResultPrice.getiJuniorAddAmt());
            jsnObj.put("basePrice", adResultPrice.getiBasePrice());
        } else {
            jsnObj.put("Status", "" + adResultPrice.getiTotalPrice());
            jsnObj.put("Price", "0");
            jsnObj.put("OverAmt", "0");
        }

        // 연박의 요금 정보 리스트 (2017-06-29, By JDongS)
        AD_AMTINFSVO ad_AMTINFSVO = new AD_AMTINFSVO();
        Map<String, String> ctnMap = new HashMap<String, String>();
        ad_AMTINFSVO.setsPrdtNum(adCalendarVO.getPrdtNum());
        ad_AMTINFSVO.setStartDt(adCalendarVO.getsFromDt());
        List<AD_CTNAMTVO> ctnAmtList = webAdProductService.selectCtnAmtList(ad_AMTINFSVO);

        if (ctnAmtList != null) {
            for (AD_CTNAMTVO ctn : ctnAmtList) {
                if (ctn.getAplNight() != null)
                    ctnMap.put(ctn.getAplNight(), ctn.getDisAmt());
            }
            jsnObj.put("ctnMap", ctnMap);
        }

        // 예약 가능 최소/최대 인원 정보 (2017-08-07, By JDongS)
        AD_PRDTINFVO prdtVO = new AD_PRDTINFVO();
        prdtVO.setPrdtNum(adCalendarVO.getPrdtNum());
        prdtVO = webAdProductService.selectPrdtInfByPrdtNum(prdtVO);
        jsnObj.put("minRsvNight", prdtVO.getMinRsvNight());
        jsnObj.put("maxRsvNight", prdtVO.getMaxRsvNight());
        jsnObj.put("ctnAplYn", prdtVO.getCtnAplYn());

        response.setContentType("application/x-json; charset=UTF-8");
        PrintWriter printWriter = response.getWriter();
        printWriter.print(jsnObj.toString());
        printWriter.flush();
        printWriter.close();
    }

    // 주변관광지
    @RequestMapping("/web/api/tour.ajax")
    public ModelAndView tourAPI(@ModelAttribute("CORPVO") CORPVO corpVO) throws UnsupportedEncodingException {
        log.info("/web/api/tour.ajax");
        // 하이제주
        // String apiUrl = "http://www.hijeju.or.kr/api/tour/nears.json?x="+corpVO.getLon() +"&y="+ corpVO.getLat() +"&distance=1&category=TU";
        // 한국관광공사 API
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/KorService/locationBasedList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+Constant.TOUR_API_SERVICE_KEY); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("mapX","UTF-8") + "=" + URLEncoder.encode(corpVO.getLon(), "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("mapY","UTF-8") + "=" + URLEncoder.encode(corpVO.getLat(), "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("contentTypeId","UTF-8") + "=" + URLEncoder.encode(Constant.TOUR_API_CONTENT_TYPE_ID, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("radius","UTF-8") + "=" + URLEncoder.encode( Constant.TOUR_API_RADIUS, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("arrange","UTF-8") + "=" + URLEncoder.encode(Constant.TOUR_API_ARRANGE, "UTF-8"));
        urlBuilder.append("&MobileOS=ETC&MobileApp=tamnao&_type=json");

        StringBuilder sb = new StringBuilder();
        JSONObject result = null;
        try {
            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            BufferedReader rd;
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }

            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();

            result = (JSONObject) new JSONParser().parse(sb.toString());

        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (ProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return new ModelAndView("jsonView", result);
    }

}



