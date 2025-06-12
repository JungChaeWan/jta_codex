package mw.product.web;


import api.service.APIService;
import api.vo.ApiNextezPrcAdd;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.prmt.service.MasPrmtService;
import mas.prmt.vo.MAINPRMTVO;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_ICONINFVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPSVO;
import oss.coupon.vo.CPVO;
import oss.env.service.OssSiteManageService;
import oss.marketing.serive.OssAdmRcmdService;
import oss.point.service.OssPointService;
import oss.point.vo.POINT_CORPVO;
import oss.user.vo.USERVO;
import web.mypage.service.WebMypageService;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.USER_CPVO;
import web.product.service.WebPrdtInqService;
import web.product.service.WebPrmtService;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;
import web.product.web.WebRcProductController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ExecutionException;

/**
 * @author 최영철
 * @since  2015. 9. 16.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@Controller
public class MwRcProductController {

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;

	@Resource(name = "masRcPrdtService")
	protected MasRcPrdtService masRcPrdtService;

	@Resource(name = "webPrdtInqService")
	protected WebPrdtInqService webPrdtInqService;

	@Resource(name = "OssAdmRcmdService")
	protected OssAdmRcmdService ossAdmRcmdService;

	@Resource(name = "ossSiteManageService")
	protected OssSiteManageService ossSiteManageService;
	
	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;
	
	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;
	
	@Resource(name = "ossCouponService")
	protected OssCouponService ossCouponService;
	
	@Resource(name = "webPrmtService")
	protected WebPrmtService webPrmtService;

	@Resource(name = "webUserCpService")
	protected WebUserCpService webUserCpService;

	@Resource(name="apiService")
	private APIService apiService;

	@Resource(name = "masPrmtService")
	private MasPrmtService masPrmtService;

	@Autowired
	private OssPointService ossPointService;

    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    /**
     * 렌터카 검색 페이지 뷰
     * Function : mainList
     * 작성일 : 2017. 12. 7. 오후 7:49:08
     * 작성자 : 정동수
     * @param prdtSVO
     * @param model
     * @return
     * @throws ParseException
     */
    @RequestMapping("/mw/rentcar/mainList.do")
    public String mainList(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
    		   					ModelMap model) throws ParseException{ 
    	log.info("/mw/rentcar/mainList.do 호출");
    	
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
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date fromDate = sdf.parse(prdtSVO.getsFromDt() + prdtSVO.getsFromTm());
		Date toDate = sdf.parse(prdtSVO.getsToDt() + prdtSVO.getsToTm());

		String difTm = OssCmmUtil.getDifTime(fromDate, toDate);
		
		model.addAttribute("difTm", difTm);
		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, 10);
		EgovStringUtil.getDateFormatDash(cal);
		model.addAttribute("AFTER_DAY", EgovStringUtil.getDateFormatDash(cal));
		
    	
    	/* 차량구분코드 */
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);

    	/**/
    	List<CDVO> isrCdList = ossCmmService.selectCode(Constant.RC_ISR_DIV_CD);
    	model.addAttribute("isrCdList", isrCdList);
    	
    	return "/mw/rc/mainList";
    }

    @RequestMapping("/mw/rentcar/car-list.do")
    public String rcList(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
			ModelMap model) throws ParseException{
    	if(!EgovStringUtil.isEmpty(prdtSVO.getsCarCd())){
			String [] carCd = prdtSVO.getsCarCd().split(",");

	    	List<String> carCdList = new ArrayList<String>();
	    	for(String sCarCd:carCd){
	    		carCdList.add(sCarCd);
	    	}
	    	prdtSVO.setsCarCds(carCdList);
		}
    	
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

    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date fromDate = sdf.parse(prdtSVO.getsFromDt() + prdtSVO.getsFromTm());
		Date toDate = sdf.parse(prdtSVO.getsToDt() + prdtSVO.getsToTm());

		String difTm = OssCmmUtil.getDifTime(fromDate, toDate);

		// 차량구분코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);
    	
    	// 차량연료코드
    	cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
    	model.addAttribute("fuelCd", cdList);
    	
    	// 제조사구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
    	model.addAttribute("makerDivCd", cdList);
    	
    	// 주요정보
    	List<CDVO> iconCdList = ossCmmService.selectCode(Constant.ICON_CD_RCAT);
    	model.addAttribute("iconCd", iconCdList);
    	model.addAttribute("difTm", difTm);
    	return "/mw/rc/car-list";
    }

    @Mapper
	public interface ProductMapper {
		WebRcProductController.ProductMapper INSTANCE = Mappers.getMapper(WebRcProductController.ProductMapper.class);
		// 매핑 메서드: VO -> DTO
		RC_PRDTINFDTO toDto(RC_PRDTINFVO vo);
	}
    
    /** 렌터카 리스트 조회*/
    @RequestMapping("/mw/rc/rcList.ajax")
    public ModelAndView rcList2(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
				ModelMap model) throws ParseException, IOException, org.json.simple.parser.ParseException, ExecutionException, InterruptedException {
    	Map<String, Object> resultVue = new HashMap<>();

    	long beforeTime = System.currentTimeMillis();
    	prdtSVO.setsCarDivCd(null);
    	prdtSVO.setsIsrTypeDiv(null);

    	//PC소스 가지고옴
    	prdtSVO.setPageUnit(propertiesService.getInt("webPageUnit"));
    	prdtSVO.setPageUnit(9999999);

		//SQL Injection 대응. 체크인, 체크아웃 날짜가 잘 못 되었을 경우 처리. 2021.08.03 chaewan.jung
		Calendar calNow = Calendar.getInstance();
		if(!EgovStringUtil.checkDate(prdtSVO.getsFromDt())){
			calNow.add(Calendar.DAY_OF_MONTH, 1);
			prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
			prdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
			prdtSVO.setsFromTm("1200");
		}
		if(!EgovStringUtil.checkDate(prdtSVO.getsToDt())) {
			calNow.add(Calendar.DAY_OF_MONTH, 1);
			prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
			prdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
			prdtSVO.setsToTm("1200");
		}

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prdtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prdtSVO.getPageUnit());
		paginationInfo.setPageSize(prdtSVO.getPageSize());

		prdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		prdtSVO.setsMainViewYn(Constant.FLAG_N);

		if(!EgovStringUtil.isEmpty(prdtSVO.getsCarCd())){
			String [] carCd = prdtSVO.getsCarCd().split(",");
	    	List<String> carCdList = new ArrayList<>();
	    	for(String sCarCd:carCd){
	    		carCdList.add(sCarCd);
	    	}
	    	prdtSVO.setsCarCds(carCdList);
		}

		// 사용 시간
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date fromDate = sdf.parse(prdtSVO.getsFromDt() + prdtSVO.getsFromTm());
		Date toDate = sdf.parse(prdtSVO.getsToDt() + prdtSVO.getsToTm());

		String difTm = OssCmmUtil.getDifTime(fromDate, toDate);
		model.addAttribute("difTm", difTm);

		// 차종 리스트
		RC_CARDIVSVO rcCardivSVO = new RC_CARDIVSVO();
		rcCardivSVO.setPageUnit(5);
		rcCardivSVO.setPageSize(propertiesService.getInt("webPageSize"));

		paginationInfo.setRecordCountPerPage(rcCardivSVO.getPageUnit());
		paginationInfo.setPageSize(rcCardivSVO.getPageSize());

		rcCardivSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		rcCardivSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		rcCardivSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		rcCardivSVO.setsPrdtNm(prdtSVO.getsPrdtNm());
		rcCardivSVO.setsCarDiv(prdtSVO.getsCarDivCd());
		rcCardivSVO.setsMakerDiv(prdtSVO.getsMakerDivCd());
		rcCardivSVO.setsUseFuelDiv(prdtSVO.getsUseFuelDiv());
		rcCardivSVO.setsUseYn(Constant.FLAG_Y);

		List<RC_CARDIVDTO> carDivList = new ArrayList<>();
		List<RC_CARDIVVO> tempCarDivArray = masRcPrdtService.selectCardivTotalList(rcCardivSVO);

		List<RC_CARDIVDTO> carDivArray = new ArrayList<>();

		/** 차종리스트 DTO변환*/
		for (RC_CARDIVVO vo : tempCarDivArray) {
            RC_CARDIVDTO dto = new RC_CARDIVDTO();
            BeanUtils.copyProperties(vo, dto);
            carDivArray.add(dto);
        }

		BeanUtils.copyProperties(tempCarDivArray, carDivArray);

		// 차량 리스트 Map 생성
		LinkedHashMap<String, RC_PRDTINFDTO> prdtCorpMap = new LinkedHashMap<String,RC_PRDTINFDTO>();
		Map<String, LinkedHashMap<String, RC_PRDTINFDTO>> prdtMap = new HashMap<String, LinkedHashMap<String,RC_PRDTINFDTO>>();

		// 차량 리스트는 항상 처음부터 출력..
		prdtSVO.setFirstIndex(0);
		Map<String, Object> resultMap = webRcProductService.selectRcPrdtList(prdtSVO);

		@SuppressWarnings("unchecked")
		List<RC_PRDTINFVO> tempResultList = (List<RC_PRDTINFVO>) resultMap.get("resultList");

		List<RC_PRDTINFDTO> resultList =  new ArrayList<>();

		WebRcProductController.ProductMapper productMapper = WebRcProductController.ProductMapper.INSTANCE;

		for (RC_PRDTINFVO vo : tempResultList) {
            // VO -> DTO 매핑
            RC_PRDTINFDTO dto = productMapper.toDto(vo);
            resultList.add(dto);
        }

		/** API변경된 금액을 다시 금액으로 sort */
		Collections.sort(resultList, (s1, s2) -> {
			if (Integer.parseInt(s1.getSaleAmt()) < Integer.parseInt((s2.getSaleAmt()))) {
				return -1;
			} else if (Integer.parseInt(s1.getSaleAmt()) > Integer.parseInt(s2.getSaleAmt())) {
				return 1;
			}
			return 0;
		});

		if (resultList.size() > 0) {
			for (RC_CARDIVDTO carDiv : carDivArray) {
				prdtCorpMap = new LinkedHashMap<>();
				for(RC_PRDTINFDTO prdtInfVO : resultList){
					if (carDiv.getPrdtAllNm().equals(prdtInfVO.getPrdtNm())) {
						prdtCorpMap.put(prdtInfVO.getPrdtNum(), prdtInfVO);
					}
				}
				if (prdtCorpMap.size() > 0) {
					/** 차량명 중복제거 */
					boolean duplicatedObj = true;
					for(RC_CARDIVDTO tempVo : carDivList){
						if(tempVo.getPrdtAllNm().equals(carDiv.getPrdtAllNm())){
							duplicatedObj = false;
							break;
						}
					}
					if(duplicatedObj){
						carDivList.add(carDiv);
						prdtMap.put(carDiv.getPrdtAllNm(), prdtCorpMap);
					}
				}
			}
		}

		resultVue.put("prdtMap", prdtMap);
		resultVue.put("carDivList", carDivList);

		Map<String, String> rcCodeMap = new LinkedHashMap<>();
		Map<String, String> codeMap = new HashMap<>();

		List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
		for(CDVO cdvo : cdList) {
			codeMap.put(cdvo.getCdNum(), cdvo.getCdNm());
		}
		cdList = ossCmmService.selectCode(Constant.ICON_CD_RCAT);

		int cdListCnt = 0;
		for(CDVO cdvo : cdList) {
			rcCodeMap.put(cdvo.getCdNum(), cdvo.getCdNm());
			cdListCnt++;
			if(cdListCnt == 9){
				break;
			}
		}
		resultVue.put("rcCodeMap", rcCodeMap);

    	long afterTime = System.currentTimeMillis();
		long secDiffTime = (afterTime - beforeTime);
		log.info("mTimeDiff : "+secDiffTime);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultVue);
    	return modelAndView;
    }



    @RequestMapping("/mw/rentcar/car-detail.do")
    public String detailPrdt(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
    		@ModelAttribute("prdtVO") RC_PRDTINFVO prdtVO,
			HttpServletRequest request,
    		ModelMap model){
		log.info("/mw/rentcar/car-detail.do call");

		if(EgovStringUtil.isEmpty(prdtVO.getPrdtNum())) {
			log.error("MW RC : prdtNum is null");
			return "redirect:/mw/rentcar/car-list.do";
		}

    	Calendar calNow = Calendar.getInstance();
    	if(prdtSVO.getsFromDt() == null){
    		calNow.add(Calendar.DAY_OF_MONTH, 1);
    		prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
    		prdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
    		prdtSVO.setsFromTm("1200");

    		calNow.add(Calendar.DAY_OF_MONTH, 1);
    		prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
    		prdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
    		prdtSVO.setsToTm("1200");

    		// 판매 많은 순
    		prdtSVO.setOrderCd(Constant.ORDER_SALE);
    		prdtSVO.setOrderAsc(Constant.ORDER_DESC);
    	}

    	prdtVO = webRcProductService.selectByPrdt(prdtVO);

    	prdtVO.setRntStdInf(EgovStringUtil.checkHtmlView(prdtVO.getRntStdInf()));
    	prdtVO.setCarTkovInf(EgovStringUtil.checkHtmlView(prdtVO.getCarTkovInf()));
    	prdtVO.setIsrCmGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrCmGuide()));
    	prdtVO.setIsrAmtGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrAmtGuide()));

    	//상품의 업체정보의 LAT, LON 정보를 가져와야 함. 명칭은 나중에 수정해 주세요.
    	CORPVO corpSVO = new CORPVO();
    	corpSVO.setCorpId(prdtVO.getCorpId());
    	CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
    	model.addAttribute("corpVO", corpVO);

    	//업체가 승인중이 아닐때 오류 페이지로
    	if( Constant.TRADE_STATUS_APPR.equals(corpVO.getTradeStatusCd()) == false ){
    		return "redirect:/mw/cmm/error.do?errCord=PRDT01";
    	}

    	//상품이 승인이 아니면 오류 페이지로
    	if( Constant.TRADE_STATUS_APPR.equals(prdtVO.getTradeStatus()) == false ){
    		return "redirect:/mw/cmm/error.do?errCord=PRDT01";
    	}

    	// 주요정보 체크 리스트
    	List<CM_ICONINFVO> iconCdList = ossCmmService.selectCmIconinf(prdtVO.getPrdtNum(), Constant.ICON_CD_RCAT);
    	model.addAttribute("iconCdList", iconCdList);

    	// 자차필수 여부 (2016-12-9, By JDongS)
    	/*model.addAttribute("chkIsrFlag", ossCmmService.selectCmIconfChkIsr(prdtVO.getPrdtNum()));*/

    	model.addAttribute("prdtVO", prdtVO);
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
    	Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, 10);
		EgovStringUtil.getDateFormatDash(cal);
		model.addAttribute("AFTER_DAY", EgovStringUtil.getDateFormatDash(cal));

		// 현재일자 24시간 기준 요금 산출
		calNow = Calendar.getInstance();
		RC_PRDTINFSVO nowPrdtSVO = new RC_PRDTINFSVO();
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		nowPrdtSVO.setsPrdtNum(prdtVO.getPrdtNum());
		nowPrdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
		nowPrdtSVO.setsFromTm("1200");

		calNow.add(Calendar.DAY_OF_MONTH, 1);
		nowPrdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
		nowPrdtSVO.setsToTm("1200");
		nowPrdtSVO.setFirstIndex(0);
		nowPrdtSVO.setLastIndex(1);

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	// 사용 가능 쿠폰 리스트
		CPSVO cpsVO = new CPSVO();
		cpsVO.setsPrdtNum(prdtVO.getPrdtNum());
		cpsVO.setsFromDt(prdtSVO.getsFromDt());
		cpsVO.setsToDt(prdtSVO.getsToDt());

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

    	//추가기능::랜트카인수장소
		//추가정보 얻기
		RC_DFTINFVO rc_DFTINFVO = new RC_DFTINFVO();
		rc_DFTINFVO.setCorpId(prdtVO.getCorpId());
		RC_DFTINFVO rcDftInfo = masRcPrdtService.selectByRcDftInfo(rc_DFTINFVO);
		model.addAttribute("rcDftInfo", rcDftInfo);

		// 유모차/카시트 목록
		/*WEB_SPSVO webSpSVO = new WEB_SPSVO();
		webSpSVO.setsCtgr(Constant.CATEGORY_BACS);
		webSpSVO.setsCtgrDiv(Constant.CATEGORY_ETC);
		webSpSVO.setsCtgrDepth("1");
		webSpSVO.setFirstIndex(0);
		webSpSVO.setLastIndex(4);
		Map<String, Object> bacsMap = webSpService.selectProductList(webSpSVO);
		@SuppressWarnings("unchecked")
		List<WEB_SPPRDTVO> bacsList = (List<WEB_SPPRDTVO>) bacsMap.get("resultList");
		model.addAttribute("bacsList", bacsList);*/
		
		// 관련 프로모션 정보
		PRMTPRDTVO prmtPrdtVO = new PRMTPRDTVO();
		prmtPrdtVO.setPrdtNum(prdtVO.getPrdtNum());
		prmtPrdtVO.setCorpId(prdtVO.getCorpId());
		List<PRMTVO> prmtList = webPrmtService.selectDeteilPromotionList(prmtPrdtVO);
		model.addAttribute("prmtList", prmtList);

		// 찜하기 정보 (2017-11-24, By JDongS)
		/*int pocketCnt = 0;
    	POCKETVO pocket = new POCKETVO();
    	Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();
    	Map<String, POCKETVO> pocketMapCnt = new HashMap<String, POCKETVO>();

    	if (userVO != null) {
    		pocket.setUserId(userVO.getUserId());
    		pocketMap = webMypageService.selectPocketList(pocket);
    		
        	pocket.setPrdtDiv(Constant.RENTCAR);
        	pocket.setCorpId(prdtVO.getCorpId());
        	pocket.setPrdtNum(prdtVO.getPrdtNum());
        	pocketMapCnt = webMypageService.selectPocketList(pocket);
        	
        	pocketCnt = pocketMapCnt.size();
    	}   
    	model.addAttribute("pocketMap", pocketMap);
    	model.addAttribute("pocketCnt", pocketCnt);*/

		/** 데이터제공 조회정보 수집*/
        ApiNextezPrcAdd apiNextezPrcAdd = new ApiNextezPrcAdd();
        apiNextezPrcAdd.setvConectDeviceNm("MOBILE");
        apiNextezPrcAdd.setvCtgr("RC");
        apiNextezPrcAdd.setvPrdtNum(prdtVO.getPrdtNum());
        apiNextezPrcAdd.setvType("view");
		apiService.insertNexezData(apiNextezPrcAdd);

		/** 포인트 구매 필터 적용*/
		POINT_CORPVO pointCorpVO = new POINT_CORPVO();
		pointCorpVO.setCorpId(prdtVO.getCorpId());
		pointCorpVO.setPartnerCode((String) request.getSession().getAttribute("ssPartnerCode"));
		String chkPointBuyAble = ossPointService.chkPointBuyAble(pointCorpVO);
		model.addAttribute("chkPointBuyAble", chkPointBuyAble);

    	return "/mw/rc/car-detail";
    }

    @RequestMapping("/mw/rc/calRent.ajax")
    public ModelAndView calRent(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
								ModelMap model) {
    	prdtSVO.setFirstIndex(0);
		prdtSVO.setLastIndex(1);
		prdtSVO.setsMainViewYn(Constant.FLAG_N);

    	// 단건에 대한 렌터카 정보 조회
		RC_PRDTINFVO prdtInfo = webRcProductService.selectRcPrdt(prdtSVO);

    	Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("prdtInfo", prdtInfo);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }
   
    /**
     * 렌터카 업체 페이지
     * Function : corpPrdt
     * 작성일 : 2017. 12. 12. 오전 11:54:02
     * 작성자 : 정동수
     * @param prdtSVO
     * @param prdtVO
     * @param model
     * @return
     */
    @RequestMapping("/mw/rc/corpPrdt.do")
    public String corpPrdt(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
    		@ModelAttribute("prdtVO") RC_PRDTINFVO prdtVO,
    		ModelMap model){
    	if(EgovStringUtil.isEmpty(prdtSVO.getsCorpId())){
    		return "redirect:/mw/rentcar/car-list.do";
    	}
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
    	// 판매 많은 순
		prdtSVO.setOrderCd(Constant.ORDER_SALE);
		prdtSVO.setOrderAsc(Constant.ORDER_DESC);
    	
    	// 업체 정보
    	CORPVO corpSVO = new CORPVO();
    	corpSVO.setCorpId(prdtSVO.getsCorpId());
    	CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
    	//업체가 승인중이 아닐때 오류 페이지로
    	if( Constant.TRADE_STATUS_APPR.equals(corpVO.getTradeStatusCd()) == false ){
    		return "redirect:/mw/cmm/error.do?errCord=PRDT01";
    	}
    	model.addAttribute("corpVO", corpVO);
    	
    	// 업체 추가 정보
    	RC_DFTINFVO rc_DFTINFVO = new RC_DFTINFVO();
		rc_DFTINFVO.setCorpId(prdtSVO.getsCorpId());
		RC_DFTINFVO rcDftInfo = masRcPrdtService.selectByRcDftInfo(rc_DFTINFVO);
    	model.addAttribute("rcDftInfo", rcDftInfo);
    	
    	return "/mw/rc/corpPrdt";
    }


	@RequestMapping("/mw/rc/selectCardivTotalList.ajax")
	public String selectCardivTotalList(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
						  HttpServletRequest request,
						  ModelMap model) throws ParseException, IOException, org.json.simple.parser.ParseException {

		//PC소스 가지고옴
		prdtSVO.setPageUnit(propertiesService.getInt("webPageUnit"));
		prdtSVO.setPageUnit(1000);
		//prdtSVO.setPageSize(propertiesService.getInt("webPageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prdtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prdtSVO.getPageUnit());
		paginationInfo.setPageSize(prdtSVO.getPageSize());

		prdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		prdtSVO.setsMainViewYn(Constant.FLAG_N);

		if(!EgovStringUtil.isEmpty(prdtSVO.getsCarCd())){
			String [] carCd = prdtSVO.getsCarCd().split(",");

			List<String> carCdList = new ArrayList<String>();
			for(String sCarCd:carCd){
				carCdList.add(sCarCd);
			}
			prdtSVO.setsCarCds(carCdList);
		}

		// 사용 시간
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date fromDate = sdf.parse(prdtSVO.getsFromDt() + prdtSVO.getsFromTm());
		Date toDate = sdf.parse(prdtSVO.getsToDt() + prdtSVO.getsToTm());

		String difTm = OssCmmUtil.getDifTime(fromDate, toDate);
		model.addAttribute("difTm", difTm);

		// 차종 리스트
		RC_CARDIVSVO rcCardivSVO = new RC_CARDIVSVO();
		//	rcCardivSVO.setPageUnit(10);
		rcCardivSVO.setPageUnit(5);
		rcCardivSVO.setPageSize(propertiesService.getInt("webPageSize"));

		paginationInfo.setRecordCountPerPage(rcCardivSVO.getPageUnit());
		paginationInfo.setPageSize(rcCardivSVO.getPageSize());

		rcCardivSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		rcCardivSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		rcCardivSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		rcCardivSVO.setsPrdtNm(prdtSVO.getsPrdtNm());
		rcCardivSVO.setsCarDiv(prdtSVO.getsCarDivCd());
		rcCardivSVO.setsMakerDiv(prdtSVO.getsMakerDivCd());
		rcCardivSVO.setsUseFuelDiv(prdtSVO.getsUseFuelDiv());
		rcCardivSVO.setsUseYn(Constant.FLAG_Y);
		//	Map<String, Object> carDivMap = masRcPrdtService.selectCardivList(rcCardivSVO);

		//	@SuppressWarnings("unchecked")
		//	List<RC_CARDIVVO> carDivList = (List<RC_CARDIVVO>) carDivMap.get("resultList");

		List<RC_CARDIVVO> carDivList = new ArrayList<RC_CARDIVVO>();
		List<RC_CARDIVVO> carDivArray = masRcPrdtService.selectCardivTotalList(rcCardivSVO);


		return "/mw/rc/rcList";
	}

	@RequestMapping("/mw/selectCarNmList.ajax")
	public ModelAndView selectCardivTotalList(@ModelAttribute("USERVO") RC_CARDIVSVO rcCardivSVO) {


		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<RC_CARDIVVO> carDivArray = masRcPrdtService.selectCarNmList(rcCardivSVO);

		resultMap.put("data", carDivArray);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}


	/**
	* 설명 : 렌터카 메인
	* 파일명 : rcIntro
	* 작성일 : 2022-06-17 오전 10:35
	* 작성자 : chaewan.jung
	* @param : []
	* @return : java.lang.String
	* @throws Exception
	*/
	@RequestMapping("/mw/rc/intro.do")
	public void oldIntro1(HttpServletRequest request, HttpServletResponse response) {
		response.setStatus(301);
		response.setHeader("Location", request.getContextPath()+"/web/rentcar/jeju.do");
		response.setHeader("Connection","close");
	}

	@RequestMapping("/mw/rc/mainList.do")
	public void oldIntro2(HttpServletRequest request, HttpServletResponse response) {
		response.setStatus(301);
		response.setHeader("Location", request.getContextPath()+"/web/rentcar/jeju.do");
		response.setHeader("Connection","close");
	}

	@RequestMapping("/mw/rc/productList.do")
	public void oldIntro3(HttpServletRequest request, HttpServletResponse response) {
		response.setStatus(301);
		response.setHeader("Location", request.getContextPath()+"/web/rentcar/jeju.do");
		response.setHeader("Connection","close");
	}

	@RequestMapping("/mw/rentcar/jeju.do")
	public String rcIntro(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO, ModelMap model) {

		//진행중인 프로모션
		MAINPRMTVO mainPrmtVO = new MAINPRMTVO();
		List<MAINPRMTVO> mainPrmtList = masPrmtService.selectMainPrmtMain(mainPrmtVO);
		model.addAttribute("prmtList", mainPrmtList);

		// 차량구분코드
		List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
		model.addAttribute("carDivCd", cdList);

		// 누적예약, 예약가능 차량, 입점업체 수
		//Map<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Integer> cntList = webRcProductService.selectIntroCount();
		model.addAttribute("cntList", cntList);

		return "/mw/rc/jeju";
	}

}
