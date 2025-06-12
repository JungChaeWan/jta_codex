package mas.b2b.web;


import java.security.MessageDigest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lgdacom.XPayClient.XPayClient;
import mas.b2b.service.MasB2bAdService;
import mas.b2b.service.MasB2bRcService;
import mas.b2b.vo.B2B_AD_PRDTSVO;
import mas.b2b.vo.B2B_AD_PRDTVO;
import mas.b2b.vo.B2B_RC_PRDTSVO;
import mas.b2b.vo.B2B_RC_PRDTVO;

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

import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpService;
import oss.rsv.service.OssRsvService;
import oss.user.vo.USERVO;
import web.order.service.WebOrderService;
import web.order.vo.AD_RSVVO;
import web.order.vo.LGPAYINFVO;
import web.order.vo.ORDERVO;
import web.order.vo.RC_RSVVO;
import web.order.vo.RSVSVO;
import web.order.vo.RSVVO;
import web.product.vo.CARTLISTVO;
import web.product.vo.CARTVO;
import api.service.APIAdService;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class MasB2bSpController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "masB2bAdService")
	private MasB2bAdService masB2bAdService;
	
	@Resource(name = "masB2bRcService")
	private MasB2bRcService masB2bRcService;
	
	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;
	
	@Resource(name = "ossCorpService")
	private OssCorpService ossCorpService;
	
	@Resource(name = "webOrderService")
	private WebOrderService webOrderService;
	
	@Resource(name = "apiAdService")
	private APIAdService apiAdService;
	
	@Resource(name= "ossRsvService")
	private OssRsvService ossRsvService; 
		
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    

    /**
     * 실시간 숙박 상품
     * 파일명 : adList
     * 작성일 : 2016. 10. 11. 오후 2:58:36
     * 작성자 : 최영철
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/sp/adList.do")
    public String adList(ModelMap model){
    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
    	model.addAttribute("cdAdar", cdAdar);
    	model.addAttribute("cdAddv", cdAddv);
    	// 주요정보
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.ICON_CD_ADAT);
    	model.addAttribute("iconCd", cdList);
    	
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
    	
    	return "mas/b2b/sp/adList";
    }
    
    /**
     * 실시간 숙박 상품 조회
     * 파일명 : adPrdtList
     * 작성일 : 2016. 10. 11. 오후 2:58:48
     * 작성자 : 최영철
     * @param searchVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/sp/adPrdtList.ajax")
    public String adPrdtList(@ModelAttribute("searchVO") B2B_AD_PRDTSVO searchVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	searchVO.setsSaleAgcCorpId(corpInfo.getCorpId());
    	
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = masB2bAdService.selectAdPrdtList(searchVO);
		
		@SuppressWarnings("unchecked")
		List<B2B_AD_PRDTVO> resultList = (List<B2B_AD_PRDTVO>) resultMap.get("resultList");
		
    	model.addAttribute("totalCnt", resultMap.get("totalCnt"));
    	model.addAttribute("resultList", resultList);
    	paginationInfo.setTotalRecordCount((Integer)resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
    	
    	return "mas/b2b/sp/adPrdtList";
    }

    /**
     * 실시간 렌터카 상품
     * 파일명 : rcList
     * 작성일 : 2016. 10. 11. 오후 2:58:59
     * 작성자 : 최영철
     * @param prdtSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/sp/rcList.do")
    public String rcList(@ModelAttribute("searchVO") B2B_RC_PRDTSVO prdtSVO
    		,ModelMap model){
    	// 차량구분코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);
    	// 주요정보
    	List<CDVO> iconCdList = ossCmmService.selectCode(Constant.ICON_CD_RCAT);
    	model.addAttribute("iconCd", iconCdList);
    	// 차량코드
    	List<CDVO> carCdList = ossCmmService.selectCode(Constant.RC_CAR_CD);
    	model.addAttribute("carCdList", carCdList);
    	
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
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
    	
    	return "mas/b2b/sp/rcList";
    }
    
    /**
     * 실시간 렌터카 상품 조회
     * 파일명 : rcPrdtList
     * 작성일 : 2016. 10. 11. 오후 2:59:10
     * 작성자 : 최영철
     * @param prdtSVO
     * @return
     * @throws ParseException
     */
    @RequestMapping("/mas/b2b/sp/rcPrdtList.ajax")
    public ModelAndView rcPrdtList(@ModelAttribute("searchVO") B2B_RC_PRDTSVO prdtSVO) throws ParseException{
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	prdtSVO.setsSaleAgcCorpId(corpInfo.getCorpId());
    	
    	if(!EgovStringUtil.isEmpty(prdtSVO.getsCarCd())){
			String [] carCd = prdtSVO.getsCarCd().split(",");
	    	
	    	List<String> carCdList = new ArrayList<String>();
	    	for(String sCarCd:carCd){
	    		carCdList.add(sCarCd);
	    	}
	    	prdtSVO.setsCarCds(carCdList);
		}
    	
    	List<B2B_RC_PRDTVO> resultList = masB2bRcService.selectAdPrdtList(prdtSVO);
    	
    	resultMap.put("resultList", resultList);
    	
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date fromDate = sdf.parse(prdtSVO.getsFromDt() + prdtSVO.getsFromTm());
		Date toDate = sdf.parse(prdtSVO.getsToDt() + prdtSVO.getsToTm());
		
		String difTm = OssCmmUtil.getDifTime(fromDate, toDate);
		
		resultMap.put("difTm", difTm);
		
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    	
    }
    
    /**
     * 예약하기
     * 파일명 : instantBuy
     * 작성일 : 2016. 10. 11. 오후 2:59:21
     * 작성자 : 최영철
     * @param cartListVO
     * @param request
     * @param response
     * @return
     * @throws ParseException 
     */
    @RequestMapping("/mas/b2b/instantBuy.ajax")
	public ModelAndView instantBuy(@RequestBody CARTLISTVO cartListVO,
			HttpServletRequest request, 
    		HttpServletResponse response) throws ParseException{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		
		List<CARTVO> sessionCartList = new ArrayList<CARTVO>();
//    	log.info(cartList.size());
    	
    	List<CARTVO> cartList = cartListVO.getCartList(); 
    	
    	Integer cartSn = 1;
    	
    	for(CARTVO cart:cartList){
    		cart.setCartSn(cartSn);
    		cartSn++;
    		
    		if(Constant.RENTCAR.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())){
    			B2B_RC_PRDTSVO prdtSVO = new B2B_RC_PRDTSVO();
//				BeanUtils.copyProperties(cart, prdtSVO);
				prdtSVO.setFirstIndex(0);
				prdtSVO.setLastIndex(1);
				prdtSVO.setsFromDt(cart.getFromDt());
				prdtSVO.setsToDt(cart.getToDt());
				prdtSVO.setsFromTm(cart.getFromTm());
				prdtSVO.setsToTm(cart.getToTm());
				prdtSVO.setsPrdtNum(cart.getPrdtNum());
				prdtSVO.setsSaleAgcCorpId(corpInfo.getCorpId());
				
				// 단건에 대한 렌터카 정보 조회
		    	List<B2B_RC_PRDTVO> resultList = masB2bRcService.selectAdPrdtList(prdtSVO);
		    	B2B_RC_PRDTVO prdtInfo = resultList.get(0);
		    	
		    	cart.setPrdtNm(prdtInfo.getPrdtNm());
		    	cart.setCorpId(prdtInfo.getCorpId());
		    	cart.setCorpNm(prdtInfo.getCorpNm());
		    	cart.setNmlAmt(prdtInfo.getNmlAmt());
		    	cart.setSaleAmt(prdtInfo.getSaleAmt());
		    	cart.setTotalAmt(prdtInfo.getSaleAmt());
			} else if(Constant.ACCOMMODATION.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {
				B2B_AD_PRDTSVO searchVO = new B2B_AD_PRDTSVO();
				searchVO.setFirstIndex(0);
				searchVO.setLastIndex(1);
				searchVO.setsSaleAgcCorpId(corpInfo.getCorpId());
				searchVO.setsPrdtNum(cart.getPrdtNum());
				searchVO.setsAdultMem(cart.getAdultCnt());
				searchVO.setsJuniorMem(cart.getJuniorCnt());
				searchVO.setsChildMem(cart.getChildCnt());
				searchVO.setsStartDt(cart.getFromDt());
				searchVO.setsEndDt(cart.getToDt());
				
				Map<String, Object> adResultMap = masB2bAdService.selectAdPrdtList(searchVO);
				
				@SuppressWarnings("unchecked")
				List<B2B_AD_PRDTVO> resultList = (List<B2B_AD_PRDTVO>) adResultMap.get("resultList");
				
				B2B_AD_PRDTVO prdtInfo = resultList.get(0);
				
				cart.setPrdtNm(prdtInfo.getPrdtNm());
				cart.setCorpId(prdtInfo.getCorpId());
				cart.setCorpNm(prdtInfo.getAdNm());
				cart.setNmlAmt(prdtInfo.getSaleAmt());
				cart.setSaleAmt(prdtInfo.getSaleAmt());
				cart.setTotalAmt(prdtInfo.getSaleAmt());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				cart.setNight(String.valueOf(OssCmmUtil.getDifDay(sdf.parse(cart.getFromDt()), sdf.parse((cart.getToDt())))+1));
				
			}
    		
    		sessionCartList.add(cart);
    	}
    	
    	request.getSession().setAttribute("instantB2b", sessionCartList);
    	
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
			
		return mav;
	}
    
    @SuppressWarnings("unchecked")
	@RequestMapping("/mas/b2b/order01.do")
	public String order01(@RequestParam Map<String, String> params, 
							HttpServletRequest request, 
							HttpServletResponse response,
							ModelMap model){
		
//		List<CARTVO> cartList = new ArrayList<CARTVO>();
		List<CARTVO> orderList = new ArrayList<CARTVO>();
		
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
		orderList = (List<CARTVO>) request.getSession().getAttribute("instantB2b");
		// 주문 리스트가 존재하지 않을경우 장바구니로 리턴
		if(orderList == null || orderList.size() == 0){
    		return "redirect:/mas/b2b/sp/adList.do";
    	}
		
    	model.addAttribute("orderList", orderList);
    	model.addAttribute("userVO", userVO);
    	
		return "/mas/b2b/sp/order01";
	}
    
    @SuppressWarnings("unchecked")
	@RequestMapping("/mas/b2b/order02.do")
	public String order02(@ModelAttribute("RSVVO") RSVVO rsvVO,
							HttpServletRequest request, 
							HttpServletResponse response,
							ModelMap model) throws Exception{
		String cartSn[] = rsvVO.getCartSn();
		
		// 로그인 정보
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		rsvVO.setRsvCorpId(userVO.getCorpId());
		
		// 접속 IP
    	String userIp = EgovClntInfo.getClntIP(request);
		
		rsvVO.setUserId(userVO.getUserId());	// 사용자 아이디 셋팅
		rsvVO.setRegIp(userIp);					// IP
		rsvVO.setModIp(userIp);					// IP
		
		List<CARTVO> cartList = new ArrayList<CARTVO>();
				
		cartList = (List<CARTVO>) request.getSession().getAttribute("instantB2b");
		// 카트에 담긴 상품이 없는 경우 OR 선택된 상품이 없는 경우 장바구니로 리턴
		if(cartList == null || cartList.size() == 0){
			return "redirect:/mas/b2b/sp/adList.do";
		}
		
		// 선택된 상품이 카트 세션에 존재 하는지를 체크
		boolean cartChk = true;
		for(int i=0;i<cartSn.length;i++){
			for(int index = 0; index<cartList.size();index++){
				CARTVO cart = cartList.get(index);
				if(Integer.parseInt(cartSn[i]) == cart.getCartSn()){
					cartChk = false;
				}
			}
		}
		
		// 선택된 상품이 카트 세션에 존재하지 않을경우 상품 조회 화면으로 리턴
		if(cartChk){
			return "redirect:/mas/b2b/sp/adList.do";
		}
		
    	// 예약 기본 등록 및 예약번호 구하기
    	String rsvNum = webOrderService.insertRsv(rsvVO);
    	rsvVO.setRsvNum(rsvNum);
    	
    	log.fatal("[ORDER INFO] RSV NUMBER : " + rsvNum);
    	log.fatal("[ORDER INFO] ORDER COUNT : " + cartSn.length + "건");
    	
		for(int i=0;i<cartSn.length;i++){
			for(int index = 0; index<cartList.size();index++){
				log.fatal("[ORDER INFO] (CART SN : " + cartSn[i] + ") CART GET");
				CARTVO cart = cartList.get(index);
				
    			if(Integer.parseInt(cartSn[i]) == cart.getCartSn()){
    				log.fatal("[ORDER INFO] PRDT_NUM : " + cart.getPrdtNum());
    				// 렌트카 예약 처리
    				if(Constant.RENTCAR.equals(cart.getPrdtNum().substring(0,2).toUpperCase())){
    					log.fatal("[ORDER INFO] RC Reservation");
    					
    					RC_RSVVO rcRsvVO = new RC_RSVVO();
    		   	    	// 예약번호
    		   	    	rcRsvVO.setRsvNum(rsvNum);
    		   	    	
    					B2B_RC_PRDTSVO prdtSVO = new B2B_RC_PRDTSVO();
//    					BeanUtils.copyProperties(cart, prdtSVO);
    					prdtSVO.setFirstIndex(0);
    					prdtSVO.setLastIndex(1);
    					prdtSVO.setsFromDt(cart.getFromDt());
    					prdtSVO.setsToDt(cart.getToDt());
    					prdtSVO.setsFromTm(cart.getFromTm());
    					prdtSVO.setsToTm(cart.getToTm());
    					prdtSVO.setsPrdtNum(cart.getPrdtNum());
    					prdtSVO.setsSaleAgcCorpId(userVO.getCorpId());
    					
    					// 단건에 대한 렌터카 정보 조회
    			    	List<B2B_RC_PRDTVO> resultList = masB2bRcService.selectAdPrdtList(prdtSVO);
    			    	B2B_RC_PRDTVO prdtInfo = resultList.get(0);
				    	// 상품명
				    	rcRsvVO.setPrdtNm(prdtInfo.getPrdtNm());
				    	
    		   	    	// 예약상태코드
    		   	    	if(Constant.FLAG_Y.equals(prdtInfo.getAbleYn())){
    				    	
    		   	    		rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_READY);
    		   	    		// 정상금액 - 판매금액
        		   	    	rcRsvVO.setNmlAmt(prdtInfo.getSaleAmt());
        		   	    	// 판매금액 - 결제되는 금액
        		   	    	rcRsvVO.setSaleAmt(prdtInfo.getSaleAmt());
        		   	    	// 할인금액
        		   	    	rcRsvVO.setDisAmt("0");
        		   	    	
    		   	    	}else{
    		   	    		rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
    		   	    		// 정상금액 - 판매금액
        		   	    	rcRsvVO.setNmlAmt("0");
        		   	    	// 판매금액 - 결제되는 금액
        		   	    	rcRsvVO.setSaleAmt("0");
        		   	    	rcRsvVO.setDisAmt("0");
        		   	    	
    		   	    	}
    		   	    	// 업체번호
    		   	    	rcRsvVO.setCorpId(cart.getCorpId());
    		   	    	// 상품번호
    		   	    	rcRsvVO.setPrdtNum(cart.getPrdtNum());
    		   	    	// 렌트 시작 일자
    		   	    	rcRsvVO.setRentStartDt(EgovStringUtil.removeMinusChar(cart.getFromDt()));
    		   	    	// 렌트 시작 시간
    		   	    	rcRsvVO.setRentStartTm(cart.getFromTm());
    		   	    	// 렌트 종료 일자
    		   	    	rcRsvVO.setRentEndDt(EgovStringUtil.removeMinusChar(cart.getToDt()));
    		   	    	// 렌트 종료 시간
    		   	    	rcRsvVO.setRentEndTm(cart.getToTm());
    		   	    	// 할인 취소 금액
    		   	    	rcRsvVO.setDisCancelAmt("0");
    		   	    	
    		   	    	// 상품 정보
    		   	    	String prdtInf = EgovStringUtil.getDateFormatDash(cart.getFromDt()) + " " + EgovStringUtil.getTimeFormatCol(cart.getFromTm())
    		   	    			+ "부터 " + EgovStringUtil.getDateFormatDash(cart.getToDt()) + " " + EgovStringUtil.getTimeFormatCol(cart.getToTm())
    		   	    			+ "까지 " + prdtInfo.getRsvTm() + "시간";
    		   	    	rcRsvVO.setPrdtInf(prdtInf);
    		   	    	
    		   	    	// 렌터카 상품예약등록
    		   	    	String rcRsvNum = webOrderService.insertRcRsv(rcRsvVO);

    		   	    	if(Constant.FLAG_Y.equals(prdtInfo.getAbleYn())){
    		   	    		// 렌터카 예약번호
        		   	    	rcRsvVO.setRcRsvNum(rcRsvNum);
        		   	    	rcRsvVO.setMappingRsvNum("");
        		   	    	
        		   	    	webOrderService.insertRcHist(rcRsvVO);
        		   	    	// 판매 통계 MERGE
        		   	    	webOrderService.mergeSaleAnls(rcRsvVO.getPrdtNum());
        		   	    	
    		   	    	}
    		   	    	
    		   	    	// cartVO.setAbleYn(ableVO.getAbleYn());
    				}
    				// 숙박 예약 처리
    				else if(Constant.ACCOMMODATION.equals(cart.getPrdtNum().substring(0,2).toUpperCase())){
    					log.fatal("[ORDER INFO] AD Reservation");
    					// 예약 가능여부 확인 - DB 상품 처리
    					//int nPrice = webAdProductService.getTotalPrice(  cart.getPrdtNum()
						//												, cart.getStartDt()
						//												, cart.getNight()
						//												, cart.getAdultCnt()
						//												, cart.getJuniorCnt()
						//												, cart.getChildCnt());
    					
    					B2B_AD_PRDTSVO searchVO = new B2B_AD_PRDTSVO();
    					searchVO.setFirstIndex(0);
    					searchVO.setLastIndex(1);
    					searchVO.setsSaleAgcCorpId(userVO.getCorpId());
    					searchVO.setsPrdtNum(cart.getPrdtNum());
    					searchVO.setsAdultMem(cart.getAdultCnt());
    					searchVO.setsJuniorMem(cart.getJuniorCnt());
    					searchVO.setsChildMem(cart.getChildCnt());
    					searchVO.setsStartDt(cart.getFromDt());
    					searchVO.setsEndDt(cart.getToDt());
    					
    					Map<String, Object> adResultMap = masB2bAdService.selectAdPrdtList(searchVO);
    					
    					List<B2B_AD_PRDTVO> resultList = (List<B2B_AD_PRDTVO>) adResultMap.get("resultList");
    					
    					B2B_AD_PRDTVO prdtInfo = new B2B_AD_PRDTVO();
    					
    					if(resultList.size() > 0){
    						prdtInfo = resultList.get(0);
    					}else{
    						prdtInfo = null;
    					}

    					AD_RSVVO adRsvVO = new AD_RSVVO();
    					// 상품명
    					adRsvVO.setPrdtNm(cart.getPrdtNm());
    					
    					// 상품 정보
    		   	    	String prdtInf = EgovStringUtil.getDateFormatDash(cart.getStartDt()) + "부터 " + cart.getNight() + "박|"
    		   	    			+ "성인 " + cart.getAdultCnt() + "명, "
    		   	    			+ "소인 " + cart.getJuniorCnt() + "명, "
    		   	    			+ "유아 " + cart.getChildCnt() + "명";
    		   	    	adRsvVO.setPrdtInf(prdtInf);
    		   	    	
    					if(prdtInfo == null){
    						adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
    						adRsvVO.setNmlAmt("0");
        					adRsvVO.setSaleAmt("0");
        					adRsvVO.setDisAmt("0");
        					
    					}else{
    						adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_READY);
    						adRsvVO.setNmlAmt(prdtInfo.getSaleAmt());
    						// 판매금액 - 결제되는 금액
    						adRsvVO.setSaleAmt(prdtInfo.getSaleAmt());
        		   	    	// 할인금액
    						adRsvVO.setDisAmt("0");
    					}
    					adRsvVO.setRsvNum(rsvNum);
    					adRsvVO.setCorpId(cart.getCorpId());
    					adRsvVO.setPrdtNum(cart.getPrdtNum());
    					adRsvVO.setUseDt(EgovStringUtil.removeMinusChar(cart.getStartDt()));
    					adRsvVO.setUseNight(cart.getNight());
    					adRsvVO.setAdultNum(cart.getAdultCnt());
    					adRsvVO.setJuniorNum(cart.getJuniorCnt());
    					adRsvVO.setChildNum(cart.getChildCnt());
    					// 할인 취소 금액
    					adRsvVO.setDisCancelAmt("0");

    					
    					//숙소 API 호출------------------------------------------
    					/*String strApiErr = apiAdService.insertResInfo(rsvVO, adRsvVO);
    			    	if( Constant.SUKSO_OK.equals(strApiErr)==false ){
    			    		//오류 처리......
    			    		log.info("/mas/b2b/order02.do API Call Error");
    			    	}*/
    					
    					// 숙박예약처리
    					String adRsvNum = webOrderService.insertAdRsv(adRsvVO);
    					// 판매 통계 MERGE
    		   	    	webOrderService.mergeSaleAnls(adRsvVO.getPrdtNum());
    					
    				}
    				log.fatal("[ORDER INFO] Reservation End..");
    				
    				// 장바구니에서 제외
    				cartList.remove(index);
    			}
    		}
    	}
		
    	// 예약건 금액 총합계 업데이트
    	webOrderService.updateTotalAmt(rsvVO);
	    
		return "redirect:/mas/b2b/order03.do?rsvNum=" + rsvNum;
	}
    
    /**
     * 결제 요청
     * 파일명 : order03
     * 작성일 : 2016. 10. 13. 오후 9:06:09
     * 작성자 : 최영철
     * @param rsvVO
     * @param request
     * @param response
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/b2b/order03.do")
	public String order03(@ModelAttribute("RSVVO") RSVVO rsvVO,
							HttpServletRequest request, 
							HttpServletResponse response,
							ModelMap model) throws Exception{
		// 예약기본정보
		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);
		
		// 예약건이 존재하지 않거나 자동 취소된 경우 처리
		if(rsvInfo == null){
			return "redirect:/mas/b2b/sp/adList.do";
		}else{
			// Constant.RSV_STATUS_CD_ACC(자동취소 : RS99)인 경우
			if(Constant.RSV_STATUS_CD_ACC.equals(rsvInfo.getRsvStatusCd())){
				return "redirect:/mas/b2b/sp/adList.do";
			}
		}
		
    	model.addAttribute("rsvInfo", rsvInfo);
    	// 예약 상품 리스트
    	List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);
    	
    	model.addAttribute("orderList", orderList);
    	// 예약 사용 쿠폰 리스트
//    	List<USER_CPVO> useCpList = webOrderService.selectUseCpList(rsvVO);
//    	model.addAttribute("useCpList", useCpList);
    	
    	/******************************************
		 * LG U+ 결제
		 ******************************************/
		String CST_PLATFORM        = EgovProperties.getOptionalProp("CST_PLATFORM");     	//LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
	    String CST_MID             = EgovProperties.getProperty("Globals.LgdID.PRE");           	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
	    
	    String LGD_MID             = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
//	    String LGD_MID             = "test".equals(CST_PLATFORM.trim())?CST_MID.substring(1):CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
	    String MERT_KEY			   = EgovProperties.getProperty("Globals.LgdMertKey.PRE");
	    
	    String LGD_OID = rsvInfo.getRsvNum();
	    
	    SimpleDateFormat frm = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String timeStamp = frm.format(new Date());
		
	    StringBuffer sb = new StringBuffer();
	    
	    sb.append(LGD_MID);
	    sb.append(LGD_OID);
	    sb.append(rsvInfo.getTotalSaleAmt());
	    sb.append(timeStamp);
	    sb.append(MERT_KEY);
	    
	    byte[] bNoti = sb.toString().getBytes();
	    MessageDigest md = MessageDigest.getInstance("MD5");
	    byte[] digest = md.digest(bNoti);

	    StringBuffer strBuf = new StringBuffer();
	    for (int i=0 ; i < digest.length ; i++) {
	        int c = digest[i] & 0xff;
	        if (c <= 15){
	            strBuf.append("0");
	        }
	        strBuf.append(Integer.toHexString(c));
	    }

	    String LGD_HASHDATA = strBuf.toString();
	    String LGD_RETURNURL = "local".equals(Constant.FLAG_INIT) ? 
	    		EgovProperties.getProperty(Constant.FLAG_INIT + ".LgdRtnUrl") :
	    		request.getScheme() + "://" + request.getServerName() + EgovProperties.getProperty(Constant.FLAG_INIT + ".LgdRtnUrl"); 
	    	
		model.addAttribute("CST_PLATFORM"	, CST_PLATFORM);
		model.addAttribute("LGD_HASHDATA"	, LGD_HASHDATA);
		model.addAttribute("LGD_OID"		, LGD_OID);
		model.addAttribute("timeStamp"		, timeStamp);
		model.addAttribute("CST_MID"		, CST_MID);
		model.addAttribute("LGD_MID"		, LGD_MID);
		model.addAttribute("LGD_RETURNURL"	, LGD_RETURNURL);
	    
		
		return "/mas/b2b/sp/order02";
	}
    
    /**
     * 주문 확인
     * 파일명 : orderChk
     * 작성일 : 2016. 10. 13. 오후 9:05:59
     * 작성자 : 최영철
     * @param rsvVO
     * @return
     */
    @RequestMapping("/mas/b2b/orderChk.ajax")
	public ModelAndView orderChk(@ModelAttribute("RSVVO") RSVVO rsvVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 예약기본정보
		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);
		
		// 예약건이 존재하지 않거나 자동 취소된 경우 처리
		if(rsvInfo == null){
			resultMap.put("success", "N");
		}else{
			// Constant.RSV_STATUS_CD_READY(예약대기 : RS00)인 경우
			if(Constant.RSV_STATUS_CD_READY.equals(rsvInfo.getRsvStatusCd())){
				resultMap.put("success", "Y");
			}else{
				resultMap.put("success", "N");
			}
		}
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
		return mav;
	}
    
    /**
     * 최종 결제 요청
     * 파일명 : order05
     * 작성일 : 2016. 10. 13. 오후 9:05:47
     * 작성자 : 최영철
     * @param rsvVO
     * @param request
     * @param response
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/b2b/order05.do")
	public String order05(	@ModelAttribute("RSVVO") RSVVO rsvVO,
							HttpServletRequest request, 
							HttpServletResponse response,
							ModelMap model) throws Exception{
		
		// 예약기본정보
		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);
		
		// 예약건이 존재하지 않거나 자동 취소된 경우 처리
		if(rsvInfo == null){
			return "redirect:/mas/b2b/sp/adList.do";
		}else{
			// Constant.RSV_STATUS_CD_ACC(자동취소 : RS99)인 경우
			if(Constant.RSV_STATUS_CD_ACC.equals(rsvInfo.getRsvStatusCd())){
				return "redirect:/mas/b2b/sp/adList.do";
			}
		}
		
		//LG유플러스에서 제공한 환경파일
		String configPath = EgovProperties.getProperty(Constant.FLAG_INIT + ".LgdFolder");
		
		/*
	     *************************************************
	     * 1.최종결제 요청 - BEGIN
	     *  (단, 최종 금액체크를 원하시는 경우 금액체크 부분 주석을 제거 하시면 됩니다.)
	     *************************************************
	     */
	    
	    String CST_PLATFORM                 = request.getParameter("CST_PLATFORM");
	    String CST_MID                      = request.getParameter("CST_MID");
	    String LGD_MID                      = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
	    String LGD_PAYKEY                   = request.getParameter("LGD_PAYKEY");
	    LGPAYINFVO lGPAYINFO = new LGPAYINFVO();
	    String rtnMsg 	= "";
	    String rtnTitle = "";
	    String rtnCode 	= "";
	    
	    //해당 API를 사용하기 위해 WEB-INF/lib/XPayClient.jar 를 Classpath 로 등록하셔야 합니다. 
	    XPayClient xpay = new XPayClient();
	   	boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);   	

	   	if( !isInitOK ) {
	    	//API 초기화 실패 화면처리
	   		log.error( "결제요청을 초기화 하는데 실패하였습니다.");
	        log.error( "LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.");        
	        log.error( "mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.");
	        log.error( "문의전화 LG유플러스 1544-7772");
	        
	        rtnTitle =  "결제요청을 초기화 하는데 실패하였습니다. 고객센터에 문의하시기 바랍니다.";
	        rtnMsg   = "LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.";
	        rtnCode  = "-1";
	        model.addAttribute("rtnCode", rtnCode);
	        model.addAttribute("rtnMsg", rtnMsg);
   	     	return "/mas/b2b/sp/orderFail";
	   	}else{  
	   		try{
	   			/*
	   	   	     *************************************************
	   	   	     * 1.최종결제 요청(수정하지 마세요) - END
	   	   	     *************************************************
	   	   	     */
		    	xpay.Init_TX(LGD_MID);
		    	xpay.Set("LGD_TXNAME", "PaymentByKey");
		    	xpay.Set("LGD_PAYKEY", LGD_PAYKEY);
		    
		    	//금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
		    	//String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
		    	//xpay.Set("LGD_AMOUNTCHECKYN", "Y");
		    	//xpay.Set("LGD_AMOUNT", DB_AMOUNT);
		    
	    	}catch(Exception e) {
	    		log.error("LG유플러스 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
	    		log.error(""+e.getMessage());  
	    		
	    		rtnCode = "-1";
	    		rtnTitle =  "LG유플러스 제공 API를 사용할 수 없습니다. 고객센터에 문의하시기 바랍니다. ";
	    		rtnMsg   = e.getMessage();
		        model.addAttribute("rtnCode", rtnCode);
		        model.addAttribute("rtnTitle", rtnTitle);
		        model.addAttribute("rtnMsg", rtnMsg);
	    		model.addAttribute("CSNUM", EgovProperties.getProperty("CS.PHONE"));
	   	     	return "/mas/b2b/sp/orderFail";
	    	}
	   	}
	   	/*
	     * 2. 최종결제 요청 결과처리
	     *
	     * 최종 결제요청 결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
	     */
	     if ( xpay.TX() ) {
	    	 rtnTitle = "결제요청이 완료되었습니다.";
	    	 rtnMsg   = xpay.m_szResMsg;
	    	 rtnCode  = xpay.m_szResCode;
	    	 
	         //1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
	    	 log.info( "결제요청이 완료되었습니다.");
	    	 log.info( "TX 결제요청 Response_code = " + xpay.m_szResCode);
	    	 log.info( "TX 결제요청 Response_msg = " + xpay.m_szResMsg);
	         
	    	 log.info("거래번호 : " + xpay.Response("LGD_TID",0));
	    	 log.info("상점아이디 : " + xpay.Response("LGD_MID",0));
	    	 log.info("상점주문번호 : " + xpay.Response("LGD_OID",0));
	    	 log.info("결제금액 : " + xpay.Response("LGD_AMOUNT",0));
	    	 log.info("결과코드 : " + xpay.Response("LGD_RESPCODE",0));
	    	 log.info("결과메세지 : " + xpay.Response("LGD_RESPMSG",0));
	         
	         for (int i = 0; i < xpay.ResponseNameCount(); i++){
	             for (int j = 0; j < xpay.ResponseCount(); j++){
	            	 log.info(xpay.ResponseName(i) + " = " + xpay.Response(xpay.ResponseName(i), j));
	             }
	         }
	         // 결제 결과 저장
	         lGPAYINFO.setLGD_OID				(xpay.Response("LGD_OID",0));
	         lGPAYINFO.setLGD_RESPCODE			(xpay.m_szResCode);
	         lGPAYINFO.setLGD_RESPMSG			(xpay.m_szResMsg);
	         lGPAYINFO.setLGD_AMOUNT			(xpay.Response("LGD_AMOUNT",0));
	         lGPAYINFO.setLGD_TID				(xpay.Response("LGD_TID",0));
	         lGPAYINFO.setLGD_PAYTYPE			(xpay.Response("LGD_PAYTYPE",0));
	         lGPAYINFO.setLGD_PAYDATE			(xpay.Response("LGD_PAYDATE",0));
	         lGPAYINFO.setLGD_FINANCECODE		(xpay.Response("LGD_FINANCECODE",0));
	         lGPAYINFO.setLGD_FINANCENAME		(xpay.Response("LGD_FINANCENAME",0));
	         lGPAYINFO.setLGD_ESCROWYN			(xpay.Response("LGD_ESCROWYN",0));
	         lGPAYINFO.setLGD_BUYER				(xpay.Response("LGD_BUYER",0));
	         lGPAYINFO.setLGD_BUYERID			(xpay.Response("LGD_BUYERID",0));
	         lGPAYINFO.setLGD_BUYERPHONE		(xpay.Response("LGD_BUYERPHONE",0));
	         lGPAYINFO.setLGD_BUYEREMAIL		(xpay.Response("LGD_BUYEREMAIL",0));
	         lGPAYINFO.setLGD_PRODUCTINFO		(xpay.Response("LGD_PRODUCTINFO",0));
	         lGPAYINFO.setLGD_CARDNUM			(xpay.Response("LGD_CARDNUM",0));
	         lGPAYINFO.setLGD_CARDINSTALLMONTH	(xpay.Response("LGD_CARDINSTALLMONTH",0));
	         lGPAYINFO.setLGD_CARDNOINTYN		(xpay.Response("LGD_CARDNOINTYN",0));
	         lGPAYINFO.setLGD_FINANCEAUTHNUM	(xpay.Response("LGD_FINANCEAUTHNUM",0));
	         lGPAYINFO.setLGD_CASHRECEIPTNUM	(xpay.Response("LGD_CASHRECEIPTNUM",0));
	         lGPAYINFO.setLGD_CASHRECEIPTSELFYN	(xpay.Response("LGD_CASHRECEIPTSELFYN",0));
	         lGPAYINFO.setLGD_CASHRECEIPTKIND	(xpay.Response("LGD_CASHRECEIPTKIND",0));
	         lGPAYINFO.setLGD_CUSTOM_USABLEPAY	(xpay.Response("LGD_CUSTOM_USABLEPAY",0));
	         
	         if( "0000".equals( xpay.m_szResCode ) ) {
	        	 //최종결제요청 결과 성공 DB처리
	        	 log.info(lGPAYINFO.getLGD_OID() + " 최종결제요청 결과 성공 DB처리하시기 바랍니다.");
	        	 
	        	//최종결제요청 결과 성공 DB처리 실패시 Rollback 처리
//		         	boolean isDBOK = true; //DB처리 실패시 false로 변경해 주세요.
	         	
	         	try {
	         		webOrderService.updateRsvComplete(lGPAYINFO);
	         		
				} catch (Exception e) {
					rtnCode = "-1";
					xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
					log.info( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0));
	         		log.info( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0));
	         		
	         		if( "0000".equals( xpay.m_szResCode ) ) {
	         			log.info("자동취소가 정상적으로 완료 되었습니다.");
	         		}else{
	         			log.info("자동취소가 정상적으로 처리되지 않았습니다.");
	         		}
				}
	         	
	         	rtnCode = xpay.m_szResCode;
	         }else{
	        	 //최종결제요청 결과 실패 DB처리
	        	 log.info("최종결제요청 결과 실패 DB처리하시기 바랍니다.");
	        	 rtnTitle = "최종결제요청 결과 실패";
	        	 webOrderService.insertLDGINFO(lGPAYINFO);
	         }
	     }else {
	    	 rtnTitle = "결제요청이 실패하였습니다.";
	         //2)API 요청실패 화면처리
	    	 log.info( "결제요청이 실패하였습니다.");
	    	 log.info( "TX 결제요청 Response_code = " + xpay.m_szResCode);
	    	 log.info( "TX 결제요청 Response_msg = " + xpay.m_szResMsg);
	         
	    	 
	    	 rtnMsg = xpay.m_szResMsg;
	     	//최종결제요청 결과 실패 DB처리
	    	 log.info("최종결제요청 결과 실패 DB처리하시기 바랍니다.");
	    	 webOrderService.insertLDGINFO(lGPAYINFO);
	     }
	     
	     if("0000".equals(rtnCode)){
	    	 
	    	 log.info("OK=====================================");
	    	//문자, SMS보내기
	    	webOrderService.orderCompleteSnedSMSMail(rsvVO,request);
	    	 
	    	//숙소 API
	    	String strApiErr = apiAdService.PayDoneResInfo(rsvInfo);
	     	if( Constant.SUKSO_OK.equals(strApiErr)==false ){
	     		//오류 처리......
	     		log.info("/mas/b2b/order05.do API Call Error");
	     	}
	    	 
	    	 
	    	 return "redirect:/mas/b2b/orderComplete.do?rsvNum=" + lGPAYINFO.getLGD_OID();
	     }else{
	    	 model.addAttribute("rtnCode", rtnCode);
	    	 model.addAttribute("rtnMsg", rtnMsg);
	    	 return "/mas/b2b/sp/orderFail";
	     }
	
	}
    
    /**
     * 주문완료
     * 파일명 : orderComplete
     * 작성일 : 2016. 10. 13. 오후 9:05:31
     * 작성자 : 최영철
     * @param rsvVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/orderComplete.do")
	public String orderComplete(@ModelAttribute("RSVVO") RSVVO rsvVO,
			ModelMap model){
		// 예약기본정보
 		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);
     	model.addAttribute("rsvInfo", rsvInfo);
     	// 예약 상품 리스트
     	List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);
     	model.addAttribute("orderList", orderList);
		
		return "/mas/b2b/sp/orderComplete";
	}
    
    @RequestMapping("/mas/b2b/rsvList.do")
    public String rsvList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		ModelMap model){
    	// 로그인 정보
    	USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsRsvCorpId(userVO.getCorpId());
    			
    	if(rsvSVO.getsAutoCancelViewYn() == null){
    		rsvSVO.setsAutoCancelViewYn("N");
    	}
    	rsvSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	rsvSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(rsvSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(rsvSVO.getPageUnit());
		paginationInfo.setPageSize(rsvSVO.getPageSize());

		rsvSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		rsvSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		rsvSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossRsvService.selectRsvAtPrdtList(rsvSVO);
		
		@SuppressWarnings("unchecked")
		List<ORDERVO> resultList = (List<ORDERVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
    	return "/mas/b2b/sp/rsvList";
    }
}
