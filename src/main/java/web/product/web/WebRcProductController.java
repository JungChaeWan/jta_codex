package web.product.web;

import api.service.APIService;
import api.vo.ApiNextezPrcAdd;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;
import org.modelmapper.ModelMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
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
import web.mypage.vo.POCKETVO;
import web.mypage.vo.USER_CPVO;
import web.product.service.*;

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
 *  2017-10-30  정동수		렌터카 검색 페이지 추가
 */
@Controller
public class WebRcProductController {

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

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

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

	@Resource(name="apiService")
	private APIService apiService;

	@Resource(name = "webUserCpService")
	protected WebUserCpService webUserCpService;

	@Autowired
	private OssPointService ossPointService;

    Logger log = (Logger) LogManager.getLogger(this.getClass());


    @RequestMapping("/web/rc/intro.do")
	public void oldIntro1(HttpServletRequest request, HttpServletResponse response) {
		response.setStatus(301);
		response.setHeader("Location", request.getContextPath()+"/web/rentcar/jeju.do");
		response.setHeader("Connection","close");
	}

	@RequestMapping("/web/rc/mainList.do")
	public void oldIntro2(HttpServletRequest request, HttpServletResponse response) {
		response.setStatus(301);
		response.setHeader("Location", request.getContextPath()+"/web/rentcar/jeju.do");
		response.setHeader("Connection","close");
	}

	@RequestMapping("/web/rc/productList.do")
	public void oldIntro3(HttpServletRequest request, HttpServletResponse response) {
		response.setStatus(301);
		response.setHeader("Location", request.getContextPath()+"/web/rentcar/jeju.do");
		response.setHeader("Connection","close");
	}

    @RequestMapping("/web/rentcar/jeju.do")
    public String intro(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
    		   					ModelMap model, HttpServletResponse response, HttpServletRequest request) throws ParseException{
    	log.info("call /web/rentcar/jeju.do");

		try {
			if(EgovClntInfo.isMobile(request)) {
				return "forward:/mw/rentcar/jeju.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		/** 누적예약수 */
		HashMap<String, Integer> cntList = webRcProductService.selectIntroCount();
		model.addAttribute("cntList", cntList);

		/** 검색날짜 검색시간 기본값 설정 */
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

    	return "/web/rc/jeju";
    }

	/** 렌터카 목록*/
    @RequestMapping("/web/rentcar/car-list.do")
    public String mainList(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
    		   					ModelMap model, HttpServletResponse response, HttpServletRequest request) throws ParseException{
    	log.info("/web/rentcar/car-list.do 호출");

		try {
			if(EgovClntInfo.isMobile(request)) {
				return "forward:/mw/rentcar/car-list.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		/*검색날짜 검색시간 기본값 설정*/
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

    	// 차량구분코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpCd(Constant.RENTCAR);
    	corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    	
    	// 차량연료코드
    	cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
    	model.addAttribute("fuelCd", cdList);
    	
    	// 렌터카 주요정보
    	List<CDVO> carOptList = ossCmmService.selectCode(Constant.ICON_CD_RCAT);
    	model.addAttribute("carOptList", carOptList);
    	
    	// 업체
    	List<CORPVO> corpList = ossCorpService.selectRcCorpList(corpVO);
    	model.addAttribute("corpList", corpList);

    	return "/web/rc/car-list";
    }

    @Mapper
	public interface ProductMapper {
		ProductMapper INSTANCE = Mappers.getMapper(ProductMapper.class);
		// 매핑 메서드: VO -> DTO
		RC_PRDTINFDTO toDto(RC_PRDTINFVO vo);
	}

    /**
     * 렌터카 리스트 조회
     * 파일명 : rcList
     * 작성일 : 2015. 10. 30. 오후 2:20:08
     * 작성자 : 최영철
     * @param prdtSVO
     * @param model
     * @return
     * @throws IOException
     */
    @RequestMapping("/web/rc/rcList.ajax")
    public ModelAndView rcList2(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
				ModelMap model) throws ParseException, IOException, org.json.simple.parser.ParseException, ExecutionException, InterruptedException {
    	Map<String, Object> resultVue = new HashMap<>();

    	long beforeTime = System.currentTimeMillis();
    	prdtSVO.setsCarDivCd(null);
    	prdtSVO.setsIsrTypeDiv(null);
    	prdtSVO.setsRntQlfctAge(null);
    	prdtSVO.setsUseFuelDiv(null);
    	prdtSVO.setsModelYear(null);
		prdtSVO.setsCorpId(null);
		prdtSVO.setsIconCd(null);
		prdtSVO.setsRntQlfctCareer(null);

		//SQL Injection 대응. 체크인, 체크아웃 날짜가 잘 못 되었을 경우 처리. 2021.08.03 chaewan.jung
		Calendar calNow = Calendar.getInstance();
		if(!EgovStringUtil.checkDate(prdtSVO.getsFromDt())){
			calNow.add(Calendar.DAY_OF_MONTH, 1);
			prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
			prdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
			prdtSVO.setsFromTm("0800");
		}
		if(!EgovStringUtil.checkDate(prdtSVO.getsToDt())) {
			calNow.add(Calendar.DAY_OF_MONTH, 1);
			prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
			prdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
			prdtSVO.setsToTm("0800");
		}
		prdtSVO.setsMainViewYn(Constant.FLAG_N);
		// 사용 시간
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date fromDate = sdf.parse(prdtSVO.getsFromDt() + prdtSVO.getsFromTm());
		Date toDate = sdf.parse(prdtSVO.getsToDt() + prdtSVO.getsToTm());

		String difTm = OssCmmUtil.getDifTime(fromDate, toDate);
		model.addAttribute("difTm", difTm);

		// 차종 리스트
		RC_CARDIVSVO rcCardivSVO = new RC_CARDIVSVO();
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

		ProductMapper productMapper = ProductMapper.INSTANCE;

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
		ModelAndView modelAndView = new ModelAndView("jsonView", resultVue);
		long afterTime = System.currentTimeMillis();
		long secDiffTime = (afterTime - beforeTime);
		log.info("pcTimeDiff : "+secDiffTime);
    	return modelAndView;
    }
    
    /**
     * 통합검색 렌터카 리스트 조회
     * 파일명 : rcListTotSch
     * 작성일 : 2020.06.19
     * 작성자 : 김지연
     * @param prdtSVO
     * @param model
     * @return
     * @throws IOException
     */
    @RequestMapping("/web/rc/rcListTotSch.ajax")
    public String rcListTotSch(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
    			HttpServletRequest request,
				ModelMap model) {

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
		
		prdtSVO.setsMainViewYn("N");
		
		List<RC_PRDTINFVO> resultList = webRcProductService.selectTotSchRcPrdtList(prdtSVO);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totSch", request.getParameter("totSch"));
		
		// 찜하기 정보 (2017-11-24, By JDongS)
    	POCKETVO pocket = new POCKETVO();
    	Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();
    	USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	if (userVO != null) {
    		pocket.setUserId(userVO.getUserId());
        	pocket.setPrdtDiv(Constant.RENTCAR);
        	pocketMap = webMypageService.selectPocketList(pocket);
    	}
    	model.addAttribute("pocketMap", pocketMap);
		 
    	return "/web/rc/rcList";
    }    

    @RequestMapping("/web/rc/rcPackList.ajax")
    public String rcPackList(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
			ModelMap model){
    	log.info("/web/rc/rcPackList.ajax 호출");
    	prdtSVO.setPageUnit(propertiesService.getInt("webPageUnit"));
    	prdtSVO.setPageSize(propertiesService.getInt("webPageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prdtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prdtSVO.getPageUnit());
		paginationInfo.setPageSize(prdtSVO.getPageSize());

		prdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<RC_PRDTINFVO> resultList = webRcProductService.selectRcPackList(prdtSVO);

		// 여행사 렌터카 단품 카운트 조회
		Integer totalCnt = webRcProductService.selectRcPackCnt(prdtSVO);

		paginationInfo.setTotalRecordCount(totalCnt);

		model.addAttribute("resultList", resultList);
		model.addAttribute("mYn", Constant.FLAG_Y);
		model.addAttribute("paginationInfo", paginationInfo);

    	return "/web/rc/rcPackList";
    }

    /**
     * 렌터카 상세 페이지
     * 파일명 : detailPrdt
     * 작성일 : 2015. 12. 15. 오전 12:35:48
     * 작성자 : 최영철
     * @param prdtSVO
     * @param prdtVO
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping("/web/rentcar/car-detail.do")
    public String detailPrdt(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
    		@ModelAttribute("prdtVO") RC_PRDTINFVO prdtVO,
    		ModelMap model,HttpServletRequest request) throws Exception{
    	
    	log.info("/web/rentcar/car-detail.do call");
    	
    	/** 차명검색조건삭제 */
    	prdtSVO.setsPrdtNm("");
    	/** 모바일로 접속시 url전환*/
    	if(EgovStringUtil.isEmpty(prdtVO.getPrdtNum())){
    		log.error("WEB RC : prdtNum is null");
    		return "redirect:/web/rentcar/car-list.do";
    	}
    	if(EgovClntInfo.isMobile(request)) {
    		return "forward:/mw/rentcar/car-detail.do";
    	}
    	/** 기본날짜가 선택되어 있지 않으면*/
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

    		// 판매 많은 순
    		prdtSVO.setOrderCd(Constant.ORDER_SALE);
    		prdtSVO.setOrderAsc(Constant.ORDER_DESC);
    	}
    	if(prdtVO.getsFromDt() == null){
    		prdtVO.setsFromDt(prdtSVO.getsFromDt());
    		prdtVO.setsToDt(prdtSVO.getsToDt());
    	}

    	if(EgovStringUtil.isEmpty(prdtSVO.getSearchYn())){
    		prdtSVO.setSearchYn(Constant.FLAG_N);
    	}

    	prdtVO = webRcProductService.selectByPrdt(prdtVO);

    	/** 상품정보가 존재하지 않으면 오류페이지로 리턴 */
    	if(prdtVO == null){
    		return "redirect:/web/rentcar/car-list.do";
    	}

    	prdtVO.setRntStdInf(EgovStringUtil.checkHtmlView(prdtVO.getRntStdInf()));
    	prdtVO.setCarTkovInf(EgovStringUtil.checkHtmlView(prdtVO.getCarTkovInf()));
    	prdtVO.setIsrCmGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrCmGuide()));
    	prdtVO.setIsrAmtGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrAmtGuide()));

    	/** 상품의 업체정보의 LAT, LON 정보를 가져와야 함. 명칭은 나중에 수정해 주세요. */
    	CORPVO corpSVO = new CORPVO();
    	corpSVO.setCorpId(prdtVO.getCorpId());
    	CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
    	/** 업체가 승인중이 아닐때 오류 페이지로 */
    	if( Constant.TRADE_STATUS_APPR.equals(corpVO.getTradeStatusCd()) == false ){
    		return "redirect:/web/cmm/error.do?errCord=PRDT01";
    	}

    	//상품이 승인이 아니면 오류 페이지로
    	if( Constant.TRADE_STATUS_APPR.equals(prdtVO.getTradeStatus()) == false ){
    		return "redirect:/web/rentcar/car-list.do";
    	}

    	// 차량구분코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);
    	
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

		//추가정보 얻기
		RC_DFTINFVO rc_DFTINFVO = new RC_DFTINFVO();
		rc_DFTINFVO.setCorpId(prdtVO.getCorpId());
		RC_DFTINFVO rcDftInfo = masRcPrdtService.selectByRcDftInfo(rc_DFTINFVO);
		model.addAttribute("rcDftInfo", rcDftInfo);
		
		/** 사용 가능 쿠폰 리스트 */
		CPSVO cpsVO = new CPSVO();
		cpsVO.setsPrdtNum(prdtVO.getPrdtNum());
		cpsVO.setsFromDt(prdtSVO.getsFromDt());
		cpsVO.setsToDt(prdtSVO.getsToDt());
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
		model.addAttribute("bacsList", bacsList);		*/
		
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
        apiNextezPrcAdd.setvConectDeviceNm("PC");
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

    	return "/web/rc/car-detail";
    }

    @RequestMapping("/web/rentcar/calRent.ajax")
    public ModelAndView calRent(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
								ModelMap model) throws IOException{
    	/** 리스트쿼리와 함께 쓰는쿼리라서 인덱스1만 SET */
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
     * 작성일 : 2017. 11. 03. 오전 11:24:22
     * 작성자 : 정동수
     * @param prdtSVO
     * @param prdtVO
     * @param model
     * @return
     */
    @RequestMapping("/web/rc/corpPrdt.do")
    public String corpPrdt(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
    		@ModelAttribute("prdtVO") RC_PRDTINFVO prdtVO,
    		ModelMap model){
    	if(EgovStringUtil.isEmpty(prdtSVO.getsCorpId())){
    		return "redirect:/web/rentcar/car-list.do";
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
    		return "redirect:/web/cmm/error.do?errCord=PRDT01";
    	}
    	model.addAttribute("corpVO", corpVO);
    	
    	// 업체 추가 정보
    	RC_DFTINFVO rc_DFTINFVO = new RC_DFTINFVO();
		rc_DFTINFVO.setCorpId(prdtSVO.getsCorpId());
		RC_DFTINFVO rcDftInfo = masRcPrdtService.selectByRcDftInfo(rc_DFTINFVO);
    	model.addAttribute("rcDftInfo", rcDftInfo);
    	
    	return "/web/rc/corpPrdt";
    }
    
    /**
     * 보험 Q&A 페이지
     * Function : isrQna
     * 작성일 : 2018. 1. 12. 오후 1:40:55
     * 작성자 : 정동수
     * @param model
     * @return
     */
    @RequestMapping("/web/rc/isrQna.do")
    public String isrQna(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
    		ModelMap model) { 
    	log.info("/web/rc/isrQna.do 호출");
    	
    	if(EgovStringUtil.isEmpty(prdtSVO.getSearchYn())){
    		prdtSVO.setSearchYn(Constant.FLAG_N);
    	}
    	
    	if(EgovStringUtil.isEmpty(prdtSVO.getsFromDt())){
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
    	
    	return "/web/rc/isrQna";
    }

}