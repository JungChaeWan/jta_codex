package mw.order.web;

import api.service.*;
import api.vo.APILSRESULTVO;
import api.vo.APILSVO;
import api.vo.APITLBookingLogVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import lgdacom.XPayClient.XPayClient;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.AD_ADDAMTVO;
import mas.ad.vo.AD_PRDTINFVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.sp.service.MasSpService;
import mas.sp.vo.SP_ADDOPTINFVO;
import mas.sv.service.MasSvService;
import mas.sv.vo.SV_ADDOPTINFVO;
import mas.sv.vo.SV_CORPDLVAMTVO;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.ad.vo.AD_WEBDTLSVO;
import oss.ad.vo.AD_WEBDTLVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPPRDTVO;
import oss.coupon.vo.CPVO;
import oss.env.service.OssSiteManageService;
import oss.env.vo.DFTINFVO;
import oss.point.service.OssPointService;
import oss.point.vo.POINTVO;
import oss.point.vo.POINT_CORPVO;
import oss.point.vo.POINT_CPVO;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;
import web.cs.web.CartComparator;
import web.main.service.WebMainService;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.USER_CPVO;
import web.order.service.WebCartService;
import web.order.service.WebOrderService;
import web.order.vo.*;
import web.order.web.WebOrderController;
import web.product.service.*;
import web.product.vo.ADTOTALPRICEVO;
import web.product.vo.CARTVO;
import web.product.vo.WEB_DTLPRDTVO;
import web.product.vo.WEB_SV_DTLPRDTVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

import static java.lang.System.out;

@Controller
public class MwOrderController {
	 Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "masAdPrdtService")
	protected MasAdPrdtService masAdPrdtService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name = "ossSiteManageService")
	protected OssSiteManageService ossSiteManageService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "webOrderService")
	protected WebOrderService webOrderService;

	@Resource(name="apiAdService")
    private APIAdService apiAdService;

	@Resource(name = "masSpService")
	private MasSpService masSpService;

	@Resource(name = "webSvService")
	private WebSvProductService webSvService;

	@Resource(name = "masSvService")
	private MasSvService masSvService;

	@Resource(name="ossCorpService")
	private OssCorpService ossCorpService;
	
	@Resource(name = "apiService")
	private APIService apiService;

	@Resource(name = "apiLsService")
	private APILsService apiLsService;

	@Resource(name="apiHijejuService")
	APIHijejuService apiHijejuService;

	@Resource(name = "webCartService")
	private WebCartService webCartService;

	@Resource(name = "webUserCpService")
	private WebUserCpService webUserCpService;

	@Resource(name = "ossCouponService")
	private OssCouponService ossCouponService;

	@Autowired
	private APITLBookingService apitlBookingService;

	@Resource(name = "webMainService")
	private WebMainService webMainService;

	@Resource(name="apiInsService")
	private APIInsService apiInsService;

	@Autowired
	private OssUserService ossUserService;

	@Autowired
	private OssPointService ossPointService;

	@SuppressWarnings("unchecked")
	@RequestMapping("/mw/cart.do")
    public String mwCart(HttpServletRequest request,
						 ModelMap model) {
    	List<CARTVO> cartList = new ArrayList<CARTVO>();

    	if(request.getSession().getAttribute("cartList") != null){
    		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
		}
		for(int i = 0; i <cartList.size(); i++){
			CARTVO cart = cartList.get(i);

			String category = cart.getPrdtNum().substring(0, 2).toUpperCase();

			if(Constant.RENTCAR.equals(category)){
				RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
				prdtSVO.setFirstIndex(0);
				prdtSVO.setLastIndex(1);
				prdtSVO.setsFromDt(cart.getFromDt());
				prdtSVO.setsToDt(cart.getToDt());
				prdtSVO.setsFromTm(cart.getFromTm());
				prdtSVO.setsToTm(cart.getToTm());
				prdtSVO.setsPrdtNum(cart.getPrdtNum());
				prdtSVO.setsInfo("Y");
				// 단건에 대한 렌터카 정보 조회

				RC_PRDTINFVO prdtInfo = webRcProductService.selectRcPrdt(prdtSVO);
		    	cart.setSaleAmt(prdtInfo.getSaleAmt());
		    	cart.setTotalAmt(String.valueOf(Integer.valueOf(prdtInfo.getSaleAmt()) + Integer.valueOf(cart.getAddAmt())));
		    	cart.setImgPath(prdtInfo.getSaveFileNm());
		    	cart.setCtgr("RC");

			} else if(Constant.ACCOMMODATION.equals(category)) {
				int nPrice = webAdProductService.getTotalPrice(cart.getPrdtNum()
																, cart.getStartDt()
																, cart.getNight()
																, cart.getAdultCnt()
																, cart.getJuniorCnt()
																, cart.getChildCnt());

		    	cart.setSaleAmt(nPrice + "");
		    	cart.setTotalAmt(nPrice + "");

				//숙소 이미지
				CM_IMGVO imgVO = new CM_IMGVO();
				imgVO.setLinkNum(cart.getPrdtNum().toUpperCase());
				List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
				if(imgList.size() > 0 ){
					cart.setImgPath(imgList.get(0).getSavePath() + "thumb/" + imgList.get(0).getSaveFileNm());
				}
				cart.setCtgr("AD");


			} else if(Constant.SOCIAL.equals(category)) {
				WEB_DTLPRDTVO searchVO = new WEB_DTLPRDTVO();

				searchVO.setPrdtNum(cart.getPrdtNum());
				searchVO.setSpDivSn(cart.getSpDivSn());
				searchVO.setSpOptSn(cart.getSpOptSn());

				WEB_DTLPRDTVO spProduct = webSpService.selectByCartPrdt(searchVO);

				if(spProduct == null) {
					log.info("spProduct null");
					// 품절이 되거나 판매기간이 끝난경우. 세션에서 지운다.
					cartList.remove(i);
				} else {
					cart.setPrdtNm(spProduct.getPrdtNm());
					cart.setSaleAmt(spProduct.getSaleAmt());
					cart.setPrdtDivNm(spProduct.getPrdtDivNm());
					cart.setOptNm(spProduct.getOptNm());
					cart.setCtgrNm(spProduct.getCtgrNm());
					cart.setNmlAmt(spProduct.getNmlAmt());
					cart.setAplDt(spProduct.getAplDt());
					cart.setCorpId(spProduct.getCorpId());
					if(spProduct.getSaveFileNm() != null) {
						cart.setImgPath(spProduct.getSavePath() + "thumb/" + spProduct.getSaveFileNm());
					} else {
						cart.setImgPath(spProduct.getApiImgThumb());
					}
					
					int addOptAmt;
					if(StringUtils.isNotEmpty(cart.getAddOptAmt())) {
						addOptAmt = Integer.valueOf(cart.getAddOptAmt());
					} else {
						addOptAmt = 0;
					}
					cart.setTotalAmt(String.valueOf(Integer.valueOf(cart.getQty()) * (Integer.valueOf(spProduct.getSaleAmt()) + addOptAmt)));
					cart.setCtgr(spProduct.getCtgr());

					cartList.set(i, cart);
				}
			} else if(Constant.SV.equals(category)) {
				WEB_SV_DTLPRDTVO searchVO = new WEB_SV_DTLPRDTVO();

				searchVO.setPrdtNum(cart.getPrdtNum());
				searchVO.setSvDivSn(cart.getSvDivSn());
				searchVO.setSvOptSn(cart.getSvOptSn());

				WEB_SV_DTLPRDTVO svProduct = webSvService.selectByCartPrdt(searchVO);

				if(svProduct == null) {
					log.info("spProduct null");
					// 품절이 되거나 판매기간이 끝난경우. 세션에서 지운다.
					cartList.remove(i);
				} else {
					cart.setPrdtNm(svProduct.getPrdtNm());
					cart.setSaleAmt(svProduct.getSaleAmt());
					cart.setPrdtDivNm(svProduct.getPrdtDivNm());
					cart.setOptNm(svProduct.getOptNm());
					cart.setCtgrNm(svProduct.getCtgrNm());
					cart.setNmlAmt(svProduct.getNmlAmt());
					cart.setCorpId(svProduct.getCorpId());
					cart.setDlvAmtDiv(svProduct.getDlvAmtDiv());
					cart.setAplAmt(svProduct.getAplAmt());
					cart.setMaxiBuyNum(svProduct.getMaxiBuyNum());
					cart.setPrdc(svProduct.getPrdc());
					cart.setImgPath(svProduct.getSavePath() + "thumb/" + svProduct.getSaveFileNm());

					//개별 배송비 로직 추가 2021.05.21 chaewan.jung
					//도내/도외 배송비와 관련 없이 ceil(구매수량/개별배송수량)
					if (svProduct.getDlvAmtDiv().equals(Constant.DLV_AMT_DIV_MAXI)){
						int DlvCnt =  (int) Math.ceil(Double.valueOf(cart.getQty()) / Double.valueOf(svProduct.getMaxiBuyNum()));
						cart.setDlvAmt(String.valueOf(Integer.valueOf(svProduct.getDlvAmt()) * DlvCnt));
						cart.setOutDlvAmt(String.valueOf(Integer.valueOf(svProduct.getDlvAmt()) * DlvCnt));
						cart.setInDlvAmt(String.valueOf(Integer.valueOf(svProduct.getDlvAmt()) * DlvCnt));
					}else {
						cart.setDlvAmt(svProduct.getDlvAmt());
						cart.setOutDlvAmt(svProduct.getDlvAmt());
						cart.setInDlvAmt(svProduct.getInDlvAmt());
					}

					int addOptAmt;
					if(StringUtils.isNotEmpty(cart.getAddOptAmt())) {
						addOptAmt = Integer.valueOf(cart.getAddOptAmt());
					} else {
						addOptAmt = 0;
					}
					cart.setTotalAmt(String.valueOf(Integer.valueOf(cart.getQty()) * (Integer.valueOf(svProduct.getSaleAmt()) + addOptAmt)));
					cart.setCtgr("SV");

					cartList.set(i, cart);
				}
			}
		}
		// 장바구니 정렬(corpId-prdc-dlvAmtDiv-directRecvYn)
		// 생산자별 묶음배송을 위해 prdc 정렬 추가 2021.06.03 chaewan.jung
		CartComparator cartCom = new CartComparator();
    	Collections.sort(cartList, cartCom);

    	model.addAttribute("cartList", cartList);
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

    	return "/mw/order/cart";
    }


	/**
   	 * 장바구니 옵션 중복 체크.
   	 * @param cartVO
   	 * @param request
   	 * @param response
   	 * @return
   	 */
   	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mw/checkDupOptionCart.ajax")
   	public ModelAndView checkDupOption(@ModelAttribute("cartVO") CARTVO cartVO,
   			HttpServletRequest request,
       		HttpServletResponse response ) {
   		log.info("/mw/checkDupOptionCart.ajax call");
   		Map<String, Object> resultMap = new HashMap<String, Object>();

   		List<CARTVO> cartList = new ArrayList<CARTVO>();

   		if(request.getSession().getAttribute("cartList") != null){
       		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
       		log.info("cartVO :: " + cartVO.toString());
       		// 소셜 상품일 경우 중복 된 상품 장바구니에 못담음.
            if(Constant.SOCIAL.equals(cartVO.getPrdtNum().substring(0, 2).toUpperCase())) {
        		for(int i=0;i<cartList.size();i++){
        			log.info("sesstion cart :: " + cartList.get(i).toString());
        			if(cartList.get(i).getPrdtNum().equals(cartVO.getPrdtNum()) &&
        				cartList.get(i).getSpDivSn().equals(cartVO.getSpDivSn()) &&
        					cartList.get(i).getSpOptSn().equals(cartVO.getSpOptSn())) {
        						log.info("same");
        						cartList.remove(i);
        						resultMap.put("resultCode", Constant.JSON_FAIL);
        							break;
        			}
            	}
            }
   		} else {
   			resultMap.put("resultCode", Constant.JSON_SUCCESS);
   		}
   		ModelAndView mav = new ModelAndView("jsonView", resultMap);

   		return mav;
   	}

   	@SuppressWarnings("unchecked")
	@RequestMapping("/mw/cartOptionLayer.ajax")
    public String cartOptionLay(@ModelAttribute("cartSn") CARTVO cartVO,
    		HttpServletRequest request,
    		HttpServletResponse response,
    		ModelMap model){

    	List<CARTVO> cartList = new ArrayList<CARTVO>();

    	if(request.getSession().getAttribute("cartList") != null){
    		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
		}
    	for(CARTVO cart:cartList){
			if(cartVO.getCartSn() == cart.getCartSn()){
				if(Constant.RENTCAR.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())){
					RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
//					BeanUtils.copyProperties(cart, prdtSVO);
					prdtSVO.setFirstIndex(0);
					prdtSVO.setLastIndex(1);
					prdtSVO.setsFromDt(cart.getFromDt());
					prdtSVO.setsToDt(cart.getToDt());
					prdtSVO.setsFromTm(cart.getFromTm());
					prdtSVO.setsToTm(cart.getToTm());
					prdtSVO.setsPrdtNum(cart.getPrdtNum());

					// 단건에 대한 렌터카 정보 조회
			    	List<RC_PRDTINFVO> resultList = webRcProductService.selectRcPrdtList2(prdtSVO);
			    	RC_PRDTINFVO prdtInfo = resultList.get(0);

			    	RC_PRDTINFVO prdtVO = new RC_PRDTINFVO();
			    	prdtVO.setPrdtNum(prdtSVO.getsPrdtNum());
			    	prdtVO = webRcProductService.selectByPrdt(prdtVO);
			    	prdtInfo.setIsrCmGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrCmGuide()));
			    	prdtInfo.setIsrAmtGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrAmtGuide()));

			    	model.addAttribute("prdtInfo", prdtInfo);
			    	model.addAttribute("cartInfo", cart);
			    	return "/mw/order/rcOptionLayer";
				} else if(Constant.SOCIAL.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {
					WEB_DTLPRDTVO searchVO = new WEB_DTLPRDTVO();
					searchVO.setPrdtNum(cart.getPrdtNum());
					searchVO.setSpDivSn(cart.getSpDivSn());
					searchVO.setSpOptSn(cart.getSpOptSn());
					WEB_DTLPRDTVO prdtInfo = webSpService.selectByCartPrdt(searchVO);

					// 상품 추가 옵션 가져오기.
					SP_ADDOPTINFVO sp_ADDOPTINFVO = new SP_ADDOPTINFVO();
					sp_ADDOPTINFVO.setPrdtNum(cart.getPrdtNum());
					List<SP_ADDOPTINFVO> addOptList = masSpService.selectPrdtAddOptionList(sp_ADDOPTINFVO);

					model.addAttribute("prdtInfo", prdtInfo);
			    	model.addAttribute("cartInfo", cart);
			    	model.addAttribute("cartList", cartList);
			    	model.addAttribute("addOptList", addOptList);

			    	return "/mw/order/spOptionLayer";
				} else if(Constant.ACCOMMODATION.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {

					AD_WEBDTLSVO prdtSVO = new AD_WEBDTLSVO();
					prdtSVO.setsPrdtNum( cart.getPrdtNum() );
					prdtSVO.setsFromDt( cart.getStartDt() );
			    	prdtSVO.setsNights( cart.getNight() );
			    	AD_WEBDTLVO ad_WEBDTLVO = webAdProductService.selectWebdtlByPrdt(prdtSVO);
					model.addAttribute("webdtl", ad_WEBDTLVO);


					//객실 정보읽기
			    	AD_PRDTINFVO adPrdtVO = new AD_PRDTINFVO();
			    	adPrdtVO.setPrdtNum( cart.getPrdtNum() );
			    	AD_PRDTINFVO adPrdtRes = masAdPrdtService.selectByAdPrdinf(adPrdtVO);
			    	model.addAttribute("prdtVO", adPrdtRes);

//			    	//숙소 정보
//			    	/*
//			    	CORPVO corpSVO = new CORPVO();
//			    	corpSVO.setCorpId(ad_WEBDTLVO.getCorpId());
//			    	CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
//			    	model.addAttribute("corpVO", corpVO);
//			    	*/


			    	model.addAttribute("searchVO", prdtSVO);

			    	model.addAttribute("cart", cart);

			    	/*
			    	//추가 요금 구하기
					AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
					ad_ADDAMTVO.setCorpId( ad_WEBDTLVO.getCorpId() );
					ad_ADDAMTVO.setAplStartDt( prdtSVO.getsFromDt() );
					AD_ADDAMTVO adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
					if(adAddAmt == null){
						adAddAmt = new AD_ADDAMTVO();
						adAddAmt.setAdultAddAmt("0");
						adAddAmt.setJuniorAddAmt("0");
						adAddAmt.setChildAddAmt("0");
					}
					model.addAttribute("adAddAmt", adAddAmt );
					*/

					//객실 추가 요금 얻기
					AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
					ad_ADDAMTVO.setAplStartDt( prdtSVO.getsFromDt() );
					ad_ADDAMTVO.setCorpId( prdtSVO.getsPrdtNum() );
					AD_ADDAMTVO adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
					if(adAddAmt == null){
						//숙소 추가 요금 얻기
			    		ad_ADDAMTVO.setCorpId( ad_WEBDTLVO.getCorpId() );
						adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
						if(adAddAmt == null){
							adAddAmt = new AD_ADDAMTVO();
							adAddAmt.setAdultAddAmt("0");
							adAddAmt.setJuniorAddAmt("0");
							adAddAmt.setChildAddAmt("0");
						}
					}
					model.addAttribute("adAddAmt", adAddAmt );


			    	// 이미지
			    	CM_IMGVO imgVO = new CM_IMGVO();
			    	imgVO.setLinkNum(cart.getPrdtNum().toUpperCase());
			    	List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
			    	model.addAttribute("imgList", imgList);

					return "/mw/order/adOptionLayer";
				} else if(Constant.SV.equals(cart.getPrdtNum().substring(0, 2).toUpperCase())) {
					WEB_SV_DTLPRDTVO searchVO = new WEB_SV_DTLPRDTVO();
					searchVO.setPrdtNum(cart.getPrdtNum());
					searchVO.setSvDivSn(cart.getSvDivSn());
					searchVO.setSvOptSn(cart.getSvOptSn());
					WEB_SV_DTLPRDTVO prdtInfo = webSvService.selectByCartPrdt(searchVO);

					// 상품 추가 옵션 가져오기.
					SV_ADDOPTINFVO sv_ADDOPTINFVO = new SV_ADDOPTINFVO();
					sv_ADDOPTINFVO.setPrdtNum(cart.getPrdtNum());
					List<SV_ADDOPTINFVO> addOptList = masSvService.selectPrdtAddOptionList(sv_ADDOPTINFVO);

					model.addAttribute("prdtInfo", prdtInfo);
			    	model.addAttribute("cartInfo", cart);
			    	model.addAttribute("cartList", cartList);
			    	model.addAttribute("addOptList", addOptList);

			    	return "/mw/order/svOptionLayer";
				}
			}
		}

    	return "/mw/order/rcOptionLayer";
    }

	/**
	 * 설명 : 상세페이지 - 룸 예약정보 설정
	 * 파일명 : adRoomOptionLay
	 * 작성일 : 2022-01-10 오후 5:07
	 * 작성자 : chaewan.jung
	 * @param : [prdtSVO, model]
	 * @return : java.lang.String
	 * @throws Exception
	 */
	@RequestMapping("/mw/adRoomOptionLayer.ajax")
	public String adRoomOptionLay(@ModelAttribute("prdtSVO") AD_WEBDTLSVO prdtSVO,
								  ModelMap model) {

		AD_WEBDTLVO ad_WEBDTLVO = webAdProductService.selectWebdtlByPrdt(prdtSVO);

		model.addAttribute("webdtl", ad_WEBDTLVO);

		//객실 정보읽기
		AD_PRDTINFVO adPrdtVO = new AD_PRDTINFVO();
		adPrdtVO.setPrdtNum(prdtSVO.getsPrdtNum());

		AD_PRDTINFVO adPrdtRes = masAdPrdtService.selectByAdPrdinf(adPrdtVO);

		model.addAttribute("prdtVO", adPrdtRes);
		model.addAttribute("searchVO", prdtSVO);

		//객실 추가 요금 얻기
		AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
		ad_ADDAMTVO.setAplStartDt(prdtSVO.getsFromDt());
		ad_ADDAMTVO.setCorpId(prdtSVO.getsPrdtNum());

		AD_ADDAMTVO adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
		if (adAddAmt == null) {
			//숙소 추가 요금 얻기
			ad_ADDAMTVO.setCorpId(ad_WEBDTLVO.getCorpId());

			adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
			if (adAddAmt == null) {
				adAddAmt = new AD_ADDAMTVO();
				adAddAmt.setAdultAddAmt("0");
				adAddAmt.setJuniorAddAmt("0");
				adAddAmt.setChildAddAmt("0");
			}
		}
		model.addAttribute("adAddAmt", adAddAmt);

		// 이미지
		CM_IMGVO imgVO = new CM_IMGVO();
		imgVO.setLinkNum(prdtSVO.getsPrdtNum().toUpperCase());

		List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
		model.addAttribute("imgList", imgList);

		return "/mw/order/adRoomOptionLayer";
	}

	/**
   	 * 장바구니 옵션 변경
   	 * 파일명 : changeCart
   	 * 작성일 : 2015. 11. 13. 오전 10:13:40
   	 * 작성자 : 최영철
   	 * @param cartVO
   	 * @param request
   	 * @param response
   	 * @return
   	 */
   	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mw/changeCart.ajax", method=RequestMethod.POST)
       public ModelAndView changeCart(@RequestBody CARTVO cartVO,
       		HttpServletRequest request,
       		HttpServletResponse response){
   		log.info("/web/changeCart.ajax call");
       	List<CARTVO> cartList = new ArrayList<CARTVO>();

       	if(request.getSession().getAttribute("cartList") != null){
       		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
   		}
       	// 소셜 상품일 경우 기존 상품의 옵션을 바꿈,
       if(Constant.SOCIAL.equals(cartVO.getPrdtNum().substring(0, 2).toUpperCase())) {
    		for(int i=0;i<cartList.size();i++){
    			if(cartVO.getCartSn() == cartList.get(i).getCartSn()){
					CARTVO cartOrg = cartList.get(i);

					cartOrg.setSpOptSn(cartVO.getSpOptSn());
					cartOrg.setSpDivSn(cartVO.getSpDivSn());
					cartOrg.setQty(cartVO.getQty());
					cartOrg.setAddOptAmt(cartVO.getAddOptAmt());
					cartOrg.setAddOptNm(cartVO.getAddOptNm());

					cartList.set(i, cartOrg);
    			}
        	}
        }else if(Constant.ACCOMMODATION.equals(cartVO.getPrdtNum().substring(0, 2).toUpperCase())) {
        	for(int i=0;i<cartList.size();i++){
    			if(cartVO.getCartSn() == cartList.get(i).getCartSn()){
    				CARTVO cartOrg = cartList.get(i);

    				cartOrg.setStartDt( cartVO.getStartDt() );
    				cartOrg.setNight( cartVO.getNight() );
    				cartOrg.setAdultCnt( cartVO.getAdultCnt() );
    				cartOrg.setJuniorCnt( cartVO.getJuniorCnt() );
    				cartOrg.setChildCnt( cartVO.getChildCnt() );

    				cartList.set(i, cartOrg);
    			}
        	}
        }
        // 렌터카 상품 옵션 변경
        else if(Constant.RENTCAR.equals(cartVO.getPrdtNum().substring(0, 2).toUpperCase())){
        	for(int i=0;i<cartList.size();i++){
    			if(cartVO.getCartSn() == cartList.get(i).getCartSn()){
    				CARTVO cartOrg = cartList.get(i);
    				cartOrg.setFromDt(cartVO.getFromDt());
    				cartOrg.setFromTm(cartVO.getFromTm());
    				cartOrg.setToDt(cartVO.getToDt());
    				cartOrg.setToTm(cartVO.getToTm());
    				cartOrg.setInsureDiv(cartVO.getInsureDiv());
    				cartOrg.setAddAmt(cartVO.getAddAmt());

    				cartList.set(i, cartOrg);
    			}
        	}
        }
        //관광기념품
        else if(Constant.SV.equals(cartVO.getPrdtNum().substring(0, 2).toUpperCase())) {
    		for(int i=0;i<cartList.size();i++){
    			if(cartVO.getCartSn() == cartList.get(i).getCartSn()){
    				cartList.set(i, cartVO);
    			}
        	}
        }

       	request.getSession().setAttribute("cartList", cartList);
       	
       	// 로그인된 사용자인 경우 DB 처리
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		webCartService.addCart(cartList);
    	}

       	Map<String, Object> resultMap = new HashMap<String, Object>();

   		ModelAndView mav = new ModelAndView("jsonView", resultMap);

   		return mav;
       }

   	@SuppressWarnings("unchecked")
	@RequestMapping("/mw/order01.do")
	public String order01(@RequestParam Map<String, String> params,
						  HttpServletRequest request,
						  ModelMap model) {
		log.info("/mw/order01.do Call !!");
		
		List<CARTVO> cartList = new ArrayList<CARTVO>();
		List<CARTVO> orderList = new ArrayList<CARTVO>();

		USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if(loginVO != null) {
			//회원 로그인
			if ("Y".equals(loginVO.getRestYn())) {
				return "redirect:/mw/restSign.do";
			} else {
				USERVO userVO = ossUserService.selectByUser(loginVO);
		     	model.addAttribute("userVO", userVO);
		     	model.addAttribute("isGuest", "N");
			}
		} else {
			//비회원 로그인인 경우
			loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();

			if(loginVO != null) {
				//log.info(">>>>>>>>>>>>"+userVO.getUserNm());
				model.addAttribute("userVO", loginVO);
				model.addAttribute("isGuest", "Y");
			}
		}

		if(Constant.RSV_DIV_C.equals(params.get("rsvDiv"))) {
			// 카트에 체크된 상품을 주문 리스트에 담기
			String cartSn[] = params.get("cartSn").split(",");

			if(request.getSession().getAttribute("cartList") != null) {
	    		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
			}
	    	for(CARTVO cart:cartList) {
	    		for(int i=0; i < cartSn.length; i++) {
	    			if(Integer.parseInt(cartSn[i]) == cart.getCartSn()) {
	    				orderList.add(cart);
	    			}
	    		}
	    	}
		} else {
			// 즉시 구매 세션을 주문 리스트에 담기
			orderList = (List<CARTVO>) request.getSession().getAttribute("instant");
		}
/*		// 주문 리스트가 존재하지 않을경우 장바구니로 리턴
		if(orderList == null || orderList.size() == 0){
    		return "redirect:/mw/cart.do";
    	}*/

		CartComparator cartCom = new CartComparator();
    	Collections.sort(orderList, cartCom);

		String orderDiv = null;
		for(CARTVO cart : orderList) {
			if(Constant.SV.equals(cart.getPrdtNum().substring(0,2).toUpperCase())) {
				orderDiv = Constant.SV;
				break;
			}
		}

		//직접수령 여부 체크
		String svDirRecv = "Y";
		for(CARTVO cart : orderList) {
			if(Constant.SV.equals(cart.getPrdtNum().substring(0,2).toUpperCase())) {
				if(!"Y".equals(cart.getDirectRecvYn())){
					svDirRecv = "N";
					break;
				}
			}
		}

		String tamnacardYn = "N";
		if(orderList.size() == 1){
			for(CARTVO cart : orderList) {
				String resultCorp = webOrderService.tamnacardCompanyUseYn(cart.getCorpId());
				if("C".equals(resultCorp)){
					tamnacardYn = "Y";
				}else if("P".equals(resultCorp)){
					tamnacardYn = webOrderService.tamnacardPrdtUseYn(cart.getPrdtNum());
				}
			}
		}

		//파트너(협력사) 가용 포인트 조회
		String ssPartnerCode = (String) request.getSession().getAttribute("ssPartnerCode");
		POINTVO pointVO = new POINTVO();
		pointVO.setUserId(loginVO.getUserId());
		pointVO.setPartnerCode(ssPartnerCode);
		POINTVO partnerPoint = ossPointService.selectAblePoint(pointVO);

		//파트너(협력사)
		POINT_CPVO pointCpVO =  ossPointService.selectPointCpDetail(ssPartnerCode);

		model.addAttribute("tamnacardYn", tamnacardYn);
		model.addAttribute("svDirRecv", svDirRecv);
    	model.addAttribute("rsvDiv", params.get("rsvDiv"));
    	model.addAttribute("orderList", orderList);
    	model.addAttribute("orderDiv", orderDiv);
		model.addAttribute("partnerPoint", partnerPoint);
		model.addAttribute("pointCpVO", pointCpVO);
		
		//----------마라톤 분기----------//
		String mrt_corpId = "";
		String mrt_prdtNum = "";
		MRTNVO mrtnSVO = new MRTNVO();
		for (CARTVO cart : orderList) {
			mrt_corpId = cart.getCorpId();
			mrt_prdtNum = cart.getPrdtNum();
		}
		
		String mrtCorpId = mrt_corpId;
		if(mrtCorpId != null) {
			if("CSPM".equals(mrtCorpId.substring(0, 4))) {
				
				mrtnSVO.setCorpId(mrt_corpId);
				mrtnSVO.setPrdtNum(mrt_prdtNum);
				MRTNVO tshirtsCntVO = webOrderService.selectTshirtsCntVO(mrtnSVO);
				
				model.addAttribute("tshirtsCntVO", tshirtsCntVO);
				return "/mw/order/orderMrt01";
			} 
		}
		//----------마라톤 분기----------//
		
		return "/mw/order/order01";
	}
   	
   	@SuppressWarnings("unchecked")
	@RequestMapping("/mw/order02.do")
	public String order02(@ModelAttribute("RSVVO") RSVVO rsvVO,
						  @ModelAttribute("USER_CPVO") USER_CPVO cpVO,
						  @ModelAttribute("MRTNVO") MRTNVO mrtnVO,
						  HttpServletRequest request) throws Exception {
   		log.info("/mw/order02.do Call !!");

   		/** 문화누리카드 */
		/*String mnuricardYn = request.getParameter("mnuricard");
		if(mnuricardYn == null){
			mnuricardYn = "N";
		}*/
		
		String cartSn[] = rsvVO.getCartSn();
		/** seq1-1 로그인 정보 userId set */
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if(userVO == null) {
			/** seq 1-2비회원 로그인인 경우 */
			userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedGuest();
			if(userVO != null){
				userVO.setUserId(Constant.RSV_GUSET_NAME); //ID Guest로 설정
			}
		}
		/** seq1-3 로그인 정보 접속IP set */
    	String userIp = EgovClntInfo.getClntIP(request);
		rsvVO.setUserId(userVO.getUserId());	// 사용자 아이디 셋팅
		rsvVO.setRegIp(userIp);					// IP
		rsvVO.setModIp(userIp);					// IP

		List<CARTVO> cartList = new ArrayList<CARTVO>();
		/** seq2-1 장바구니 구매 */
		if(Constant.RSV_DIV_C.equals(rsvVO.getRsvDiv())) {
			if(request.getSession().getAttribute("cartList") != null) {
	    		cartList = (List<CARTVO>) request.getSession().getAttribute("cartList");
			}
		/** seq2-2 바로 구매 */
		}else{
			log.info("Instant Reservation");
			cartList = (List<CARTVO>) request.getSession().getAttribute("instant");
		}
		/** seq2-3 구매내역 없을시 */
		if(cartList == null || cartList.size() == 0){
			return "redirect:/mw/cart.do";
		}

		/** seq3-1 cartList정렬(업체별)*/
		CartComparator cartCom = new CartComparator();
    	Collections.sort(cartList, cartCom);
		/** seq3-2 선택된 상품이 카트 세션에 존재 하는지를 체크 */
		boolean cartChk = true;
		for(int i=0; i < cartSn.length; i++) {
			for(int index = 0; index < cartList.size(); index++){
				CARTVO cart = cartList.get(index);

				if(Integer.parseInt(cartSn[i]) == cart.getCartSn()){
					cartChk = false;
				}
			}
		}
		/** seq3-3 선택된 상품이 카트 세션에 존재하지 않을경우 카트로 리턴 */
		if(cartChk) {
			return "redirect:/mw/cart.do";
		}

		/** seq4 파트너사 트래킹*/
		String partner = (String)request.getSession().getAttribute("partner");
        if(StringUtils.isNotEmpty(partner)){
        	userVO.setPartnerCd(partner);
			if(webMainService.selectTamnaoPartnersCnt(userVO) > 0){
				USERVO userTPVO =  webMainService.selectTamnaoPartner(userVO);
				rsvVO.setPartner(userTPVO.getPartnerNm());
			}
		}

		/** seq5-1 기초예약(구매)정보 insert 및 기초예약(구매)번호 get */
		rsvVO.setPartnerCode((String) request.getSession().getAttribute("ssPartnerCode"));
    	String rsvNum = webOrderService.insertRsv(rsvVO);
    	rsvVO.setRsvNum(rsvNum);
    	log.info("[MW ORDER INFO] RSV NUMBER : " + rsvNum);
    	log.info("[MW ORDER INFO] ORDER COUNT : " + cartSn.length + "건");
    	
    	String p_corpId = "";
    	String p_dlvAmtDiv = "";
		String p_prdc ="";
    	int totalSaleAmt = 0;
		int maxSaleAmt = 0;
		String maxSaleDtlRsvNum = "";
		String tamnacardYn = "N";

		/** seq5-2 카트정보 loop */
		for(int i=0; i < cartSn.length; i++){
			for(int index = 0; index < cartList.size(); index++) {
				/** seq5-3 카트정보 get*/
				CARTVO cart = cartList.get(index);
				/** seq5-4 쿠폰정보 set*/
				List<USER_CPVO> cpList = new ArrayList<USER_CPVO>();
				Integer cpAmt = 0;
				if(cpVO.getMapSn() != null) {
					String mapSn[] = cpVO.getMapSn().split(",");
					String useCpNum[] = cpVO.getUseCpNum().split(",");
					String cpDisAmt[] = cpVO.getCpDisAmt().split(",");
					for(int ix = 0; ix < mapSn.length; ix++) {
						if(cartSn[i].equals(mapSn[ix])) {
							USER_CPVO cpVO2 = new USER_CPVO();
							cpVO2.setCpNum(useCpNum[ix]);
							cpVO2.setDisAmt(Integer.parseInt(cpDisAmt[ix]));
							/** 쿠폰검증 */
							USER_CPVO cpVO3 = webUserCpService.selectCpInfoValidate(cpVO2);
							if(cpVO3 !=null){
								/** 금액할인 */
								if(Constant.CP_DIS_DIV_PRICE.equals(cpVO3.getDisDiv())){
									cpVO2.setDisAmt(cpVO3.getDisAmt());
								/** 퍼센트할인*/
								}else if(Constant.CP_DIS_DIV_RATE.equals(cpVO3.getDisDiv())){
									int totalAmt = Integer.parseInt(cart.getTotalAmt());
									int disDiv = Integer.parseInt(cpVO3.getDisPct());
									int limitAmt = cpVO3.getLimitAmt();
									int calAmt = (int)Math.round(totalAmt * ((double) disDiv / 100));
									int disAmt;

									/** 제한금액이 0이 아니고, 쿠폰금액이 제한금액보다 크면 */
									if(calAmt > limitAmt && 0 != limitAmt){
										disAmt = limitAmt;
									}else{
										disAmt = calAmt;
									}

									/** 승마전용 쿠폰 이용시 최대금액은 최대금액 X 구매 수 */
									if(cpVO3.getCpNm().contains("승마전용")){
										int tempLimitAmt = limitAmt * Integer.parseInt(cart.getQty());

										if(calAmt > tempLimitAmt){
											disAmt = tempLimitAmt;
										}else{
											disAmt = calAmt;
										}
									}

									cpVO2.setDisAmt(disAmt);
								}
							}else{
								log.fatal("rsvNum="+rsvNum+" ::: coupon validate error");
								return "redirect:/mw/cmm/error.do";
							}
							cpList.add(cpVO2);
							cpAmt += cpVO2.getDisAmt();
						}
					}
				} else {
					cpList = null;
				}

    			if(Integer.parseInt(cartSn[i]) == cart.getCartSn()) {
    				/** seq6-1 렌터카 예약처리 */
    				if(Constant.RENTCAR.equals(cart.getPrdtNum().substring(0,2).toUpperCase())) {
    					RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
    					prdtSVO.setsPrdtNum(cart.getPrdtNum());
    					prdtSVO.setsFromDt(cart.getFromDt());
    					prdtSVO.setsFromTm(cart.getFromTm());
    					prdtSVO.setsToDt(cart.getToDt());
    					prdtSVO.setsToTm(cart.getToTm());

    					/** seq6-2 예약가능 상태 확인 */
    					RC_PRDTINFVO prdtInfo = webRcProductService.selectRcPrdt(prdtSVO);
    		   	    	RC_RSVVO rcRsvVO = new RC_RSVVO();
    		   	    	rcRsvVO.setPrdtNm(prdtInfo.getPrdtNm());
    		   	    	rcRsvVO.setRsvNum(rsvNum);
						/** 탐나는전 가능여부*/
						tamnacardYn = prdtInfo.getTamnacardYn();

    		   	    	/** seq6-3 예약가능(코드,금액,할인금) set */
    		   	    	if (Constant.FLAG_Y.equals(prdtInfo.getAbleYn())) {
    		   	    		rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_READY);
        		   	    	rcRsvVO.setNmlAmt(prdtInfo.getSaleAmt());
        		   	    	rcRsvVO.setSaleAmt(String.valueOf(Integer.parseInt(prdtInfo.getSaleAmt()) - cpAmt));
        		   	    	rcRsvVO.setDisAmt(String.valueOf(cpAmt));
						/** seq6-3 예약불가(코드,금액,할인금) set */
    		   	    	} else {
    		   	    		rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
        		   	    	rcRsvVO.setNmlAmt("0");
        		   	    	rcRsvVO.setSaleAmt("0");
        		   	    	rcRsvVO.setDisAmt("0");
    		   	    		cpList = null;
    		   	    	}
						/** 업체번호 */
						rcRsvVO.setCorpId(cart.getCorpId());
						/** 상품번호 */
						rcRsvVO.setPrdtNum(cart.getPrdtNum());
						/** 렌트 시작 일자 */
						rcRsvVO.setRentStartDt(cart.getFromDt());
						/** 렌트 시작 시간 */
						rcRsvVO.setRentStartTm(cart.getFromTm());
						/** 렌트 종료 일자 */
						rcRsvVO.setRentEndDt(cart.getToDt());
						/** 렌트 종료 시간 */
						rcRsvVO.setRentEndTm(cart.getToTm());
						/** 할인 취소 금액 */
						rcRsvVO.setDisCancelAmt("0");
						/** 예약자명*/
						rcRsvVO.setRsvNm(rsvVO.getRsvNm());
						/** 예약자연락처*/
						rcRsvVO.setRsvTelnum(rsvVO.getRsvTelnum());
						/** 사용자명*/
						rcRsvVO.setUseNm(rsvVO.getUseNm());
						/** 사용자연락처*/
						rcRsvVO.setUseTelnum(rsvVO.getRsvTelnum());
						/** 상품 정보 */
    		   	    	String prdtInf = EgovStringUtil.getDateFormatDash(cart.getFromDt()) + " " + EgovStringUtil.getTimeFormatCol(cart.getFromTm())
    		   	    			+ "부터 " + EgovStringUtil.getDateFormatDash(cart.getToDt()) + " " + EgovStringUtil.getTimeFormatCol(cart.getToTm())
    		   	    			+ "까지 " + prdtInfo.getRsvTm() + "시간";
    		   	    	rcRsvVO.setPrdtInf(prdtInf);
						/** 보험 구분 (자차포함/미포함) */
    		   	    	rcRsvVO.setIsrDiv(prdtInfo.getIsrDiv());
    		   	    	/** 보험 구분 (일반/고급/미포함)*/
    		   	    	rcRsvVO.setIsrTypeDiv(prdtInfo.getIsrTypeDiv());
    		   	    	/** 결제금액 */
    		   	    	totalSaleAmt += Integer.parseInt(rcRsvVO.getSaleAmt()) - Integer.parseInt(rcRsvVO.getDisAmt());

    		   	    	/** seq6-4 상세예약번호 insert  */
    		   	    	String rcRsvNum = webOrderService.insertRcRsv(rcRsvVO);

						/** seq6-5 LPOINT 적용상품 선정 (최대금액일경우 적용)  */
						if(maxSaleAmt <= Integer.parseInt(rcRsvVO.getSaleAmt()) - Integer.parseInt(rcRsvVO.getDisAmt())){
							maxSaleAmt = Integer.parseInt(rcRsvVO.getSaleAmt()) - Integer.parseInt(rcRsvVO.getDisAmt());
							maxSaleDtlRsvNum = rcRsvNum;
						}
    		   	    	// 판매 통계 MERGE
    		   	    	webOrderService.mergeSaleAnls(rcRsvVO.getPrdtNum());

    		   	    	/** seq6-6 LPOINT 적립 */
    		   	    	if (Integer.parseInt(rsvVO.getLpointSavePoint()) > 0) {
    		   	    		LPOINTSAVEINFVO lpointSaveInfVO = new LPOINTSAVEINFVO();
    		   	    		lpointSaveInfVO.setPrdtRsvNum(rcRsvNum);
    		   	    		lpointSaveInfVO.setPayAmt(rcRsvVO.getSaleAmt());
    		   	    		lpointSaveInfVO.setCardNum(rsvVO.getLpointCardNo());

    		   	    		webOrderService.insertLpointCardNum(lpointSaveInfVO);
    		   	    	}
						/** 그림렌터카API 예약전송*/
						String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
						if("Y".equals(prdtInfo.getCorpLinkYn()) && !EgovStringUtil.isEmpty(prdtInfo.getLinkMappingNum()) && Constant.FLAG_Y.equals(prdtInfo.getAbleYn()) && "service".equals(CST_PLATFORM.trim())) {
						/*if("Y".equals(prdtInfo.getCorpLinkYn()) && !EgovStringUtil.isEmpty(prdtInfo.getLinkMappingNum()) && Constant.FLAG_Y.equals(prdtInfo.getAbleYn())) {*/
							Boolean apiResultYn = true;
							String linkMappingRsvnum = "";
							/** 인스API 예약전송 */
							/*if(Constant.RC_RENTCAR_COMPANY_INS.equals(prdtInfo.getApiRentDiv())){
								*//** 예약 *//*
								*//*linkMappingRsvnum = apiInsService.revadd(rcRsvVO,prdtInfo);*//*
								*//** 성공 *//*
								apiResultYn =  !EgovStringUtil.isEmpty(linkMappingRsvnum);
								*//** 그림API 예약전송*//*
							}else if(Constant.RC_RENTCAR_COMPANY_GRI.equals(prdtInfo.getApiRentDiv())){

								// 연계 예약 처리
								String carAmt = "0";
								String insuranceNum = "";
								String insuranceAmt = "0";

								insuranceAmt = prdtInfo.getIsrAmt();
								insuranceNum = prdtInfo.getLinkMappingIsrNum();
								*//*linkMappingRsvnum = apiService.insertGrimRcRsv(rcRsvNum);*//*
								*//*apiResultYn =  !EgovStringUtil.isEmpty(linkMappingRsvnum);*//*
								*//** 리본API 예약전송*//*
							}else if (Constant.RC_RENTCAR_COMPANY_RIB.equals(prdtInfo.getApiRentDiv())){

							}*/

							/** if 예약완료*/
							if (apiResultYn) {    // 예약 성공
								// 렌터카 예약번호
								/*rcRsvVO.setRcRsvNum(rcRsvNum);
								rcRsvVO.setMappingRsvNum(linkMappingRsvnum);*/

								webOrderService.insertRcHist(rcRsvVO);
								// 판매 통계 MERGE
								webOrderService.mergeSaleAnls(rcRsvVO.getPrdtNum());

								if (cpList != null) {
									// 쿠폰 사용예약번호 셋팅
									for (int cpi = 0; cpi < cpList.size(); cpi++) {
										USER_CPVO useCp = cpList.get(cpi);
										useCp.setUseRsvNum(rcRsvNum);
										cpList.set(cpi, useCp);
									}
								}
								/** if 예약실패*/
							} else {
								/** set 예약불가 Flag  */
								rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
								webOrderService.chgRsvStatus(rsvVO);
								// 예약실패건에 대해 사용쿠폰리스트 삭제
								cpList = null;
							}
							/** 비API 렌터카*/
						} else {
							rcRsvVO.setRcRsvNum(rcRsvNum);
							rcRsvVO.setMappingRsvNum("0");
							webOrderService.insertRcHist(rcRsvVO);

							if (cpList != null) {
								// 쿠폰 사용예약번호 셋팅
								for (int cpi = 0; cpi < cpList.size(); cpi++) {
									USER_CPVO useCp = cpList.get(cpi);
									useCp.setUseRsvNum(rcRsvNum);
									cpList.set(cpi, useCp);
								}
							}
						}
    				}
    				// 숙박 예약 처리
    				else if(Constant.ACCOMMODATION.equals(cart.getPrdtNum().substring(0,2).toUpperCase())) {
    					log.info("[ORDER INFO] AD Reservation");
    					// 예약 가능여부 확인 - DB 상품 처리
						// WEB과 똑같이 VO처리 2021.06.29 chaewan.jung
						ADTOTALPRICEVO adTotPrice = new ADTOTALPRICEVO();
						adTotPrice.setPrdtNum(cart.getPrdtNum());
						adTotPrice.setsFromDt( cart.getStartDt());
						adTotPrice.setiNight( Integer.parseInt(cart.getNight()) );
						adTotPrice.setiMenAdult( Integer.parseInt(cart.getAdultCnt()) );
						adTotPrice.setiMenJunior( Integer.parseInt(cart.getJuniorCnt()) );
						adTotPrice.setiMenChild( Integer.parseInt(cart.getChildCnt()) );
    					int nPrice = webAdProductService.getTotalPrice(  adTotPrice );

    					AD_RSVVO adRsvVO = new AD_RSVVO();
    					// 상품명
    					adRsvVO.setPrdtNm(cart.getPrdtNm());
    					// 상품 정보
    		   	    	String prdtInf = EgovStringUtil.getDateFormatDash(cart.getStartDt()) + "부터 " + cart.getNight() + "박|"
    		   	    			+ "성인 " + cart.getAdultCnt() + "명, "
    		   	    			+ "소인 " + cart.getJuniorCnt() + "명, "
    		   	    			+ "유아 " + cart.getChildCnt() + "명";
    		   	    	adRsvVO.setPrdtInf(prdtInf);

    					if(nPrice <= 0) {
    						adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
    						adRsvVO.setNmlAmt("0");
        					adRsvVO.setSaleAmt("0");
        					adRsvVO.setDisAmt("0");
        					// 예약불가능건에 대해 사용쿠폰리스트 삭제
    		   	    		cpList = null;
    					} else {
    						adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_READY);
    						adRsvVO.setNmlAmt(String.valueOf(nPrice));
    						// 판매금액 - 결제되는 금액
    						adRsvVO.setSaleAmt(String.valueOf(nPrice - cpAmt));
        		   	    	// 할인금액
    						adRsvVO.setDisAmt(String.valueOf(cpAmt));
    						
    						// 황금빛가을제주 포인트사용처리
        		   	    	if("Y".equals(rsvVO.getGsPointYn())) {
        		   	    		// 정상금액 - 판매금액
        		   	    		adRsvVO.setNmlAmt(String.valueOf(nPrice));
            		   	    	// 판매금액 - 결제되는 금액
        		   	    		adRsvVO.setSaleAmt("0");
            		   	    	// 할인금액
        		   	    		adRsvVO.setDisAmt(String.valueOf(nPrice));
        		   	    	}
    					}
    					adRsvVO.setRsvNum(rsvNum);
    					adRsvVO.setCorpId(cart.getCorpId());
    					adRsvVO.setPrdtNum(cart.getPrdtNum());
    					adRsvVO.setUseDt(cart.getStartDt());
    					adRsvVO.setUseNight(cart.getNight());
    					adRsvVO.setAdultNum(cart.getAdultCnt());
    					adRsvVO.setJuniorNum(cart.getJuniorCnt());
    					adRsvVO.setChildNum(cart.getChildCnt());
    					// 할인 취소 금액
    					adRsvVO.setDisCancelAmt("0");
    					adRsvVO.setMappingRsvNum("");
    					// 숙박예약처리
    					totalSaleAmt += Integer.parseInt(adRsvVO.getSaleAmt()) - Integer.parseInt(adRsvVO.getDisAmt());
						tamnacardYn = webAdProductService.selectTamnacardYn(cart.getPrdtNum());
    					String adRsvNum = webOrderService.insertAdRsv(adRsvVO);
						/** LPOINT 최대금액 선정*/
						if(maxSaleAmt <= Integer.parseInt(adRsvVO.getSaleAmt()) - Integer.parseInt(adRsvVO.getDisAmt())){
							maxSaleAmt = Integer.parseInt(adRsvVO.getSaleAmt()) - Integer.parseInt(adRsvVO.getDisAmt());
							maxSaleDtlRsvNum = adRsvNum;
						}

    					// 판매 통계 MERGE
    		   	    	webOrderService.mergeSaleAnls(adRsvVO.getPrdtNum());

						//일별 숙박요금 저장 2021.06.29 chaewan.jung
						webAdProductService.insertRsvDayPrice(rsvNum, adRsvNum, adTotPrice);

    		   	    	// 포인트 적립이면 DB 등록 (2017-09-07, By JDongS)
    		   	    	if(Integer.parseInt(rsvVO.getLpointSavePoint()) > 0) {	
    		   	    		LPOINTSAVEINFVO lpointSaveInfVO = new LPOINTSAVEINFVO();
    		   	    		lpointSaveInfVO.setPrdtRsvNum(adRsvNum);
    		   	    		lpointSaveInfVO.setPayAmt(adRsvVO.getSaleAmt());
    		   	    		lpointSaveInfVO.setCardNum(rsvVO.getLpointCardNo());
    		   	    		
    		   	    		webOrderService.insertLpointCardNum(lpointSaveInfVO);
    		   	    	}

    					if(nPrice > 0) {
    						if(cpList != null) {
	    						// 쿠폰 사용예약번호 셋팅
	        		   	    	for(int cpi=0; cpi < cpList.size(); cpi++) {
	        		   	    		USER_CPVO useCp = cpList.get(cpi);
	        		   	    		useCp.setUseRsvNum(adRsvNum);
	        		   	    		
	        		   	    		cpList.set(cpi, useCp);
	        		   	    	}
    						}
    					}
    				}
    				// 소셜상품 예약 처리
    				else if(Constant.SOCIAL.equals(cart.getPrdtNum().substring(0,2).toUpperCase())) {
    					log.info("[ORDER INFO] SP Reservation");
    					
    					WEB_DTLPRDTVO searchVO = new WEB_DTLPRDTVO();
    					searchVO.setPrdtNum(cart.getPrdtNum());
    					searchVO.setSpDivSn(cart.getSpDivSn());
    					searchVO.setSpOptSn(cart.getSpOptSn());
    					
    					WEB_DTLPRDTVO spProduct = webSpService.selectByCartPrdt(searchVO);
						tamnacardYn = spProduct.getTamnacardYn();

    					SP_RSVVO spRsvVO = new SP_RSVVO();
    					// 상품명
    					spRsvVO.setPrdtNm(cart.getPrdtNm());
    					// 구분명
    					spRsvVO.setDivNm(cart.getPrdtDivNm());
    					// 옵션명
    					spRsvVO.setOptNm(cart.getOptNm());

    					// 상품 정보
    		   	    	String prdtInf = cart.getPrdtDivNm() + " ";
    		   	    	log.info("cart.getAplDt() :: " + cart.getAplDt());
    		   	    	if(StringUtils.isNotEmpty(cart.getAplDt())) {
    		   	    		prdtInf += EgovStringUtil.getDateFormatDash(cart.getAplDt()) + "|";
    		   	    	}
    		   	    	prdtInf += cart.getOptNm();
    		   	    	if(StringUtils.isNoneEmpty(cart.getAddOptNm())) {
    		   	    		prdtInf += " | " + cart.getAddOptNm();
    		   	    	}
    		   	    	prdtInf += " | 수량 : " + cart.getQty();

    		   	    	//----------마라톤 분기----------//
						String mrtCorpId = spProduct.getCorpId();
						if(mrtCorpId != null) {
							if("CSPM".equals(mrtCorpId.substring(0, 4))) {
								int limit = mrtnVO.getApctNm().split(",").length;
								String[] apctNm = mrtnVO.getApctNm().split(",", limit);
								prdtInf += " | 참가자 : " + apctNm[i];
							}
						}

    		   	    	spRsvVO.setPrdtInf(prdtInf);

    		   	    	String salePrdtYn = webSpService.saleProductYn(cart.getPrdtNum(), cart.getSpDivSn(), cart.getSpOptSn(), Integer.parseInt(cart.getQty()));
    					// 예약가능여부 체크
    					if("Y".equals(salePrdtYn)){
    						spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_READY);if(StringUtils.isNotEmpty(cart.getAddOptAmt())) {
    							spRsvVO.setAddOptAmt(cart.getAddOptAmt());
    						} else {
    							spRsvVO.setAddOptAmt("0");
    						}
    						spRsvVO.setNmlAmt(String.valueOf((Integer.parseInt(spProduct.getSaleAmt()) +Integer.parseInt(spRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty())));
    						/** 문화누리카드 */
							/*if(mnuricardYn.equals("Y")){
								spRsvVO.setNmlAmt("100");
							}*/
    						// 판매금액 - 결제되는 금액
    						spRsvVO.setSaleAmt(String.valueOf((Integer.parseInt(spProduct.getSaleAmt())+Integer.parseInt(spRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty()) - cpAmt));
							/** 문화누리카드 */
							/*if(mnuricardYn.equals("Y")){
								spRsvVO.setSaleAmt("100");
							}*/
        		   	    	// 할인금액
    						spRsvVO.setDisAmt(String.valueOf(cpAmt));
							/** 문화누리카드 */
							/*if(mnuricardYn.equals("Y")){
								spRsvVO.setDisAmt("0");
							}*/
    						// 상품 구분
        					spRsvVO.setPrdtDiv(spProduct.getPrdtDiv());
        					// 적용 일자
        					spRsvVO.setAplDt(spProduct.getAplDt());

        					// 유효일 수로 할 경우.
        					if("Y".equals(spProduct.getExprDaynumYn())) {
        		   	    		spRsvVO.setExprStartDt(new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()));
        		   	    		Calendar now = Calendar.getInstance();
        		   	    		now.add(Calendar.DATE, spProduct.getExprDaynum());
        		   	    		spRsvVO.setExprEndDt(new SimpleDateFormat("yyyyMMdd").format(now.getTime()));
        		   	    	} else {
	    						// 유효 종료 일자
	        					spRsvVO.setExprEndDt(spProduct.getExprEndDt());
	        					// 유효시작일자.
	        					spRsvVO.setExprStartDt(spProduct.getExprStartDt());
        		   	    	}

        					if(spProduct.getUseAbleTm() != null && StringUtils.isNotEmpty(String.valueOf(spProduct.getUseAbleTm()))) {
        						Calendar now = Calendar.getInstance();
        						now.add(Calendar.HOUR, spProduct.getUseAbleTm());
        						spRsvVO.setUseAbleDttm(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(now.getTime()));
        					}
        					
        					// 황금빛가을제주 포인트사용처리
        		   	    	if("Y".equals(rsvVO.getGsPointYn())){
            		   	    	// 판매금액 - 결제되는 금액
        		   	    		spRsvVO.setSaleAmt("0");
            		   	    	// 할인금액
        		   	    		spRsvVO.setDisAmt(String.valueOf((Integer.parseInt(spProduct.getSaleAmt()) +Integer.parseInt(spRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty())));
        		   	    	}
        		   	    	/*if(mnuricardYn.equals("Y")){
								cpList = null;
							}*/
    					} else {
    						spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
    						spRsvVO.setNmlAmt("0");
    						spRsvVO.setSaleAmt("0");
    						spRsvVO.setDisAmt("0");

    						// 예약불가능건에 대해 사용쿠폰리스트 삭제
    		   	    		cpList = null;
    					}
    					spRsvVO.setRsvNum(rsvNum);
    					spRsvVO.setCorpId(spProduct.getCorpId());
    					spRsvVO.setPrdtNum(cart.getPrdtNum());
    					spRsvVO.setSpDivSn(cart.getSpDivSn());
    					spRsvVO.setSpOptSn(cart.getSpOptSn());
    					spRsvVO.setBuyNum(cart.getQty());
    					spRsvVO.setAddOptNm(cart.getAddOptNm());
    					// 할인 취소 금액
    					spRsvVO.setDisCancelAmt("0");

    					// 소셜상품예약처리
						totalSaleAmt += Integer.parseInt(spRsvVO.getSaleAmt()) - Integer.parseInt(spRsvVO.getDisAmt());
    					String spRsvNum = webOrderService.insertSpRsv(spRsvVO);
						/** LPOINT 최대금액 선정*/
						if(maxSaleAmt <= Integer.parseInt(spRsvVO.getSaleAmt()) - Integer.parseInt(spRsvVO.getDisAmt())){
							maxSaleAmt = Integer.parseInt(spRsvVO.getSaleAmt()) - Integer.parseInt(spRsvVO.getDisAmt());
							maxSaleDtlRsvNum = spRsvNum;
						}
    					// 판매 통계 MERGE
    		   	    	webOrderService.mergeSaleAnls(spRsvVO.getPrdtNum());

    		   	    	// 포인트 적립이면 DB 등록 (2017-09-07, By JDongS)
    		   	    	if (Integer.parseInt(rsvVO.getLpointSavePoint()) > 0) {	
    		   	    		LPOINTSAVEINFVO lpointSaveInfVO = new LPOINTSAVEINFVO();
    		   	    		lpointSaveInfVO.setPrdtRsvNum(spRsvNum);
							lpointSaveInfVO.setPayAmt(spRsvVO.getSaleAmt());
    		   	    		lpointSaveInfVO.setCardNum(rsvVO.getLpointCardNo());

    		   	    		webOrderService.insertLpointCardNum(lpointSaveInfVO);
    		   	    	}

    					if("Y".equals(salePrdtYn)) {
    						if(cpList != null){
	    						// 쿠폰 사용예약번호 셋팅
	        		   	    	for(int cpi=0; cpi < cpList.size(); cpi++) {
	        		   	    		USER_CPVO useCp = cpList.get(cpi);
	        		   	    		useCp.setUseRsvNum(spRsvNum);

	        		   	    		cpList.set(cpi, useCp);
	        		   	    	}
    						}
    					}
    					
    					//----------마라톤 분기----------//
						//마라톤 신청자, 티셔츠수량 사용 처리
						mrtCorpId = spProduct.getCorpId();
						if(mrtCorpId != null) {
							if("CSPM".equals(mrtCorpId.substring(0, 4))) {
								mrtnVO.setRsvNum(rsvNum);
								mrtnVO.setSpRsvNum(spRsvNum);
								mrtnVO.setCorpId(mrtCorpId);
								mrtnVO.setPrdtNum(spProduct.getPrdtNum());
								mrtnVO.setIndex(i);
								webOrderService.insertMrtnUser(mrtnVO);
							}
						}
						//----------마라톤 분기----------//
    				}
    				// 관광기념품 예약 처리
    				else if(Constant.SV.equals(cart.getPrdtNum().substring(0,2).toUpperCase())){
    					log.info("[ORDER INFO] SV Reservation");
    					WEB_SV_DTLPRDTVO searchVO = new WEB_SV_DTLPRDTVO();
    					searchVO.setPrdtNum(cart.getPrdtNum());
    					searchVO.setSvDivSn(cart.getSvDivSn());
    					searchVO.setSvOptSn(cart.getSvOptSn());

    					WEB_SV_DTLPRDTVO svProduct = webSvService.selectByCartPrdt(searchVO);
						tamnacardYn = svProduct.getTamnacardYn();

    					SV_RSVVO svRsvVO = new SV_RSVVO();
    					// 상품명
    					svRsvVO.setPrdtNm(cart.getPrdtNm());
    					// 구분명
    					svRsvVO.setDivNm(cart.getPrdtDivNm());
    					// 옵션명
    					svRsvVO.setOptNm(cart.getOptNm());
    					// 상품 정보
    		   	    	String prdtInf = cart.getPrdtDivNm() + " ";
    		   	    	// 직접 수령
    		   	    	svRsvVO.setDirectRecvYn(cart.getDirectRecvYn());

    		   	    	prdtInf += cart.getOptNm();
    		   	    	if(StringUtils.isNotEmpty(cart.getAddOptNm())) {
    		   	    		prdtInf += " | " + cart.getAddOptNm();
    		   	    	}
    		   	    	prdtInf += " | 수량 : " + cart.getQty();
    		   	    	svRsvVO.setPrdtInf(prdtInf);

    		   	    	String salePrdtYn = webSvService.saleProductYn(cart.getPrdtNum(), cart.getSvDivSn(), cart.getSvOptSn(), Integer.parseInt(cart.getQty()));
    					// 예약가능여부 체크
    					if("Y".equals(salePrdtYn)){
    						svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_READY);

    						if(StringUtils.isNotEmpty(cart.getAddOptAmt())) {
    							svRsvVO.setAddOptAmt(cart.getAddOptAmt());
    						} else {
    							svRsvVO.setAddOptAmt("0");
    						}
    						svRsvVO.setDlvAmtDiv(svProduct.getDlvAmtDiv());

    						Integer preSaleAmt = webSvService.getSvPreSaleAmt(rsvNum, svProduct.getCorpId());

    						svRsvVO.setDlvAmt(cart.getDlvAmt());

    						if("Y".equals(svRsvVO.getDirectRecvYn())) {
    							//직접수령
    							svRsvVO.setDlvAmt("0");
    						} else {
								// 묶음 배송인 경우
								// 사업자별 묶음배송비 추가 2021.06.03
	    						if(!svProduct.getCorpId().equals(p_corpId) || !svProduct.getDlvAmtDiv().equals(p_dlvAmtDiv) || !svProduct.getPrdc().equals(p_prdc)) {
									svRsvVO.setDlvAmt(svProduct.getDlvAmt());
								} else {
									svRsvVO.setDlvAmt("0");
								}
	    						// 조건부 무료인 경우
	    						if(Constant.DLV_AMT_DIV_APL.equals(svProduct.getDlvAmtDiv())){
	    							preSaleAmt += (Integer.parseInt(svProduct.getSaleAmt()) + Integer.parseInt(svRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty());

	    							SV_CORPDLVAMTVO corpDlvAmtVO = masSvService.selectCorpDlvAmt(svProduct.getCorpId());
	    							// update.
	    							if(preSaleAmt >= Integer.parseInt(corpDlvAmtVO.getAplAmt())) {
	    								svRsvVO.setRsvNum(rsvNum);
	    								svRsvVO.setCorpId(cart.getCorpId());

	    								webOrderService.updateSvRsvDlvAmt(svRsvVO);
										webOrderService.updateSvRsvDlvPoint(svRsvVO);

	    								svRsvVO.setDlvAmt("0");
	    							}
	    						}
								//개별 배송비 로직 변경 2021.05.21 chaewan.jung => ceil(구매수량/개별배송수량)
								if (svProduct.getDlvAmtDiv().equals(Constant.DLV_AMT_DIV_MAXI)){
									int DlvCnt =  (int) Math.ceil(Double.valueOf(cart.getQty()) / Double.valueOf(svProduct.getMaxiBuyNum()));
									svRsvVO.setDlvAmt(String.valueOf(Integer.valueOf(svProduct.getDlvAmt()) * DlvCnt));
								}
    						}

    						p_corpId = svProduct.getCorpId();
    						p_dlvAmtDiv = svProduct.getDlvAmtDiv();
							p_prdc = svProduct.getPrdc();

    						svRsvVO.setNmlAmt(String.valueOf((Integer.parseInt(svProduct.getSaleAmt()) + Integer.parseInt(svRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty()) + Integer.parseInt(svRsvVO.getDlvAmt())));
    						// 판매금액 - 결제되는 금액
    						svRsvVO.setSaleAmt(String.valueOf((Integer.parseInt(svProduct.getSaleAmt())+ Integer.parseInt(svRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty()) + Integer.parseInt(svRsvVO.getDlvAmt()) - cpAmt));
        		   	    	// 할인금액
    						svRsvVO.setDisAmt(String.valueOf(cpAmt));
    						
    						// 황금빛가을제주 포인트사용처리
        		   	    	if("Y".equals(rsvVO.getGsPointYn())) {
            		   	    	// 판매금액 - 결제되는 금액
        		   	    		svRsvVO.setSaleAmt("0");
            		   	    	// 할인금액
        		   	    		svRsvVO.setDisAmt(String.valueOf((Integer.parseInt(svProduct.getSaleAmt()) + Integer.parseInt(svRsvVO.getAddOptAmt())) * Integer.parseInt(cart.getQty()) + Integer.parseInt(svRsvVO.getDlvAmt())));
        		   	    	}
    					} else {
    						svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
    						svRsvVO.setNmlAmt("0");
    						svRsvVO.setSaleAmt("0");
    						svRsvVO.setDisAmt("0");
    						svRsvVO.setDlvAmt("0");
    						// 예약불가능건에 대해 사용쿠폰리스트 삭제
    		   	    		cpList = null;
    					}
    					svRsvVO.setRsvNum(rsvNum);
    					svRsvVO.setCorpId(cart.getCorpId());
    					svRsvVO.setPrdtNum(cart.getPrdtNum());
    					svRsvVO.setSvDivSn(cart.getSvDivSn());
    					svRsvVO.setSvOptSn(cart.getSvOptSn());
    					svRsvVO.setBuyNum(cart.getQty());
    					svRsvVO.setAddOptNm(cart.getAddOptNm());
    					// 할인 취소 금액
    					svRsvVO.setDisCancelAmt("0");

    					// 관광기념품 상품예약처리
    					totalSaleAmt += Integer.parseInt(svRsvVO.getSaleAmt()) - Integer.parseInt(svRsvVO.getDisAmt());
    					String svRsvNum = webOrderService.insertSvRsv(svRsvVO);
						/** LPOINT 최대금액 선정*/
						if(maxSaleAmt <= Integer.parseInt(svRsvVO.getSaleAmt()) - Integer.parseInt(svRsvVO.getDisAmt())){
							maxSaleAmt = Integer.parseInt(svRsvVO.getSaleAmt()) - Integer.parseInt(svRsvVO.getDisAmt());
							maxSaleDtlRsvNum = svRsvNum;
						}
    					// 판매 통계 MERGE
    		   	    	webOrderService.mergeSaleAnls(svRsvVO.getPrdtNum());

    		   	    	// 포인트 적립이면 DB 등록 (2017-09-07, By JDongS)
    		   	    	if (Integer.parseInt(rsvVO.getLpointSavePoint()) > 0) {	
    		   	    		LPOINTSAVEINFVO lpointSaveInfVO = new LPOINTSAVEINFVO();
    		   	    		lpointSaveInfVO.setPrdtRsvNum(svRsvNum);
    		   	    		lpointSaveInfVO.setPayAmt(svRsvVO.getSaleAmt());
    		   	    		lpointSaveInfVO.setCardNum(rsvVO.getLpointCardNo());

    		   	    		webOrderService.insertLpointCardNum(lpointSaveInfVO);
    		   	    	}

    					if("Y".equals(salePrdtYn)) {
    						if(cpList != null) {
	    						// 쿠폰 사용예약번호 셋팅
	        		   	    	for(int cpi=0; cpi < cpList.size(); cpi++) {
	        		   	    		USER_CPVO useCp = cpList.get(cpi);
	        		   	    		useCp.setUseRsvNum(svRsvNum);

	        		   	    		cpList.set(cpi, useCp);
	        		   	    	}
    						}
    					}
    				}
    				if(cpList != null && cpList.size() > 0){
    					// 쿠폰 사용 처리
    		   	    	for(USER_CPVO useCp:cpList) {
    		   	    		webOrderService.updateUseCp(useCp);
    		   	    	}
    				}
    				// 장바구니에서 제외
    				cartList.remove(index);
    			}
    		}
    	}
		// 장바구니 예약인 경우
		if(Constant.RSV_DIV_C.equals(rsvVO.getRsvDiv())) {
			request.getSession().setAttribute("cartList", cartList);
			// 로그인된 사용자인 경우 DB 처리
	    	if(EgovUserDetailsHelper.isAuthenticated()){
	    		webCartService.addCart(cartList);
	    	}
		}
		
		/***********************************************************************
    	* L.Point 사용 처리 (2017-09-04, By JDongS)
		***********************************************************************/
		log.info("L.Point CardNo ==> " + rsvVO.getLpointCardNo());
    	if (rsvVO.getLpointCardNo() != null && rsvVO.getLpointCardNo().length() == 16) {
			// 사용 포인트 체크
			LPOINTREQDATAVO reqVO = new LPOINTREQDATAVO();
			reqVO.setServiceID("O100");
			reqVO.cdno = rsvVO.getLpointCardNo();

			WebOrderController webOrder = new WebOrderController();
			ModelMap resultLpoint = webOrder.actionLPoint(reqVO).getModelMap();

	    	LPOINTRESPDATAVO lpointVO = (LPOINTRESPDATAVO)resultLpoint.get("lpoint");
	    	log.info("L.Point Check ==> " + lpointVO.msgCn2 + " :: avl Point ==> " + lpointVO.avlPt);
	    	
	    	Date today = new Date();
			SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyyMMddHHmmss");
			
			LPOINTUSEINFVO lpointUseInfVO = new LPOINTUSEINFVO();
			lpointUseInfVO.setRsvNum(rsvNum);
    		lpointUseInfVO.setCardNum(rsvVO.getLpointCardNo());
    		lpointUseInfVO.setPayAmt(totalSaleAmt + "");
    		lpointUseInfVO.setUsePoint(rsvVO.getLpointUsePoint());
			lpointUseInfVO.setMaxSaleDtlRsvNum(maxSaleDtlRsvNum);
	    	
	    	// L.Point 카드정보가 정상이면...
	    	if(lpointVO.msgCn2 == "") {
	    		if(Integer.parseInt(rsvVO.getLpointUsePoint()) > 0) {	// 포인트 사용이면..
		    		// L.Point 사용 포인트가 가용포인트 이하이면...
		    		if(Integer.parseInt(lpointVO.avlPt) >= Integer.parseInt(rsvVO.getLpointUsePoint())) {
			    		// L.Point 포인트 사용 처리
			    		reqVO.setServiceID("O730");
			    		reqVO.setPswd(rsvVO.getLpointCardPw());
			    		reqVO.setCcoAprno(rsvNum);
			    		reqVO.setSlAm(rsvVO.getTotalSaleAmt());
			    		reqVO.setTtnUPt(rsvVO.getLpointUsePoint());

			    		resultLpoint = webOrder.actionLPoint(reqVO).getModelMap();

			    		lpointVO = (LPOINTRESPDATAVO)resultLpoint.get("lpoint");
			        	log.info("L.Point Use agree No ==> " + lpointVO.aprno + " :: msg ==> " + lpointVO.msgCn1);

			        	if (lpointVO.aprno != "") {	// L.Point 사용 성공 시 DB 등록
			        		lpointUseInfVO.setPayAmt("" + totalSaleAmt);
			        		lpointUseInfVO.setTradeDttm(lpointVO.aprDt + lpointVO.aprHr);
			        		lpointUseInfVO.setTradeConfnum(lpointVO.aprno);
			        		lpointUseInfVO.setRequestNum(lpointVO.control.flwNo);
			        		lpointUseInfVO.setRespCd(lpointVO.control.rspC);
			        		lpointUseInfVO.setUseRst("사용 성공");

			        		webOrderService.insertLpointUsePoint(lpointUseInfVO);
			        	} else { // L.Point 포인트 사용 실패 시
			        		// 승인 망취소
				    		log.info("L.Point Cancel (60) ==> start");
				    		reqVO.setRspC("60");

				    		webOrder.actionLPoint(reqVO).getModelMap();
				    		log.info("L.Point Cancel (60) ==> end");
			        		// L.Point 사용 '0원' 처리
			        		rsvVO.setLpointUsePoint("0");

			        		webOrderService.updateLpointCancel(rsvVO);
			        		// 결과 DB 등록			        		
			        		lpointUseInfVO.setTradeDttm(sdfDateTime.format(today));
			        		lpointUseInfVO.setTradeConfnum("승인 실패");
			        		lpointUseInfVO.setRequestNum(lpointVO.control.flwNo);
			        		lpointUseInfVO.setRespCd(lpointVO.control.rspC);
			        		lpointUseInfVO.setCancelYn(Constant.FLAG_Y);
			        		lpointUseInfVO.setUseRst(lpointVO.msgCn1);

			        		webOrderService.insertLpointUsePoint(lpointUseInfVO);
			        	}
		    		} else {
		    			// L.Point 사용 '0원' 처리
		    			rsvVO.setLpointUsePoint("0");

		        		webOrderService.updateLpointCancel(rsvVO);
		        		// 결과 DB 등록			        		
		        		lpointUseInfVO.setTradeDttm(sdfDateTime.format(today));
		        		lpointUseInfVO.setTradeConfnum("사용 실패");
		        		lpointUseInfVO.setRequestNum(lpointVO.control.flwNo);
		        		lpointUseInfVO.setRespCd(lpointVO.control.rspC);
		        		lpointUseInfVO.setCancelYn(Constant.FLAG_Y);
		        		lpointUseInfVO.setUseRst("사용 포인트가 가용 포인트 보다 커서 사용할 수 없습니다.");

		        		webOrderService.insertLpointUsePoint(lpointUseInfVO);
		    		}
	    		}
	    	} else {
	    		// L.Point 사용 & 적립 '0원' 처리
	    		rsvVO.setLpointUsePoint("0");
	    		rsvVO.setLpointSavePoint("0");

	    		webOrderService.updateLpointCancel(rsvVO);
	    		// 결과 DB 등록			        		
        		lpointUseInfVO.setTradeDttm(lpointVO.aprDt + lpointVO.aprHr);
        		lpointUseInfVO.setTradeConfnum("카드 오류");
        		lpointUseInfVO.setRequestNum(lpointVO.control.flwNo);
        		lpointUseInfVO.setRespCd(lpointVO.control.rspC);
        		lpointUseInfVO.setCancelYn(Constant.FLAG_Y);
        		lpointUseInfVO.setUseRst(lpointVO.msgCn2);

        		webOrderService.insertLpointUsePoint(lpointUseInfVO);
	    	}    
    	} else {
    		// L.Point 사용 & 적립 '0원' 처리
    		rsvVO.setLpointUsePoint("0");
    		rsvVO.setLpointSavePoint("0");

    		webOrderService.updateLpointCancel(rsvVO);    		
    	}

		//point 사용액 세션 저장
		HttpSession cpPointSession = request.getSession();
		cpPointSession.setAttribute("ssUsePoint", rsvVO.getUsePoint());

    	// 예약건 금액 총합계 업데이트
    	webOrderService.updateTotalAmt(rsvVO);

		/** 탐나는전 가능 상품일경우 코드0000 입력, 결제페이지에서 null이 아닐경우 탐나는전 결제수단제공*/
		if(cartSn.length == 1 && "Y".equals(tamnacardYn)){
			rsvVO.setTamnacardLinkUrl("0000");
			webOrderService.updateRsvTamnacardRefInfo(rsvVO);
		}

		/*if(mnuricardYn.equals("Y")){
			return "redirect:/mw/order03.do?rsvNum=" + rsvNum + "&mnuricard=Y";
		}*/

		return "redirect:/mw/order03.do?rsvNum=" + rsvNum;
	}

   	/**
   	 * 쿠폰 레이어
   	 * 파일명 : cpOptionLay
   	 * 작성일 : 2015. 12. 21. 오전 10:02:13
   	 * 작성자 : 최영철
   	 * @param cartVO
   	 * @param model
   	 * @return
   	 */
   	@RequestMapping("/mw/cpOptionLayer.ajax")
    public String cpOptionLay(@ModelAttribute("CARTVO") CARTVO cartVO,
							  ModelMap model) {
		// 로그인 정보
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		// 쿠폰 목록
		List<USER_CPVO> cpList = webUserCpService.selectCouponList(userVO.getUserId());

		// 쿠폰 적용상품 목록
		String prdtNum = cartVO.getPrdtNum();
		String corpId = cartVO.getCorpId();
		String qty = cartVO.getQty();

		for (Iterator<USER_CPVO> it = cpList.iterator(); it.hasNext(); ) {
			boolean prdtCp = false;
			boolean corpCp = false;
			boolean isDelete = false;
			USER_CPVO userCpvo = it.next();
			/** 유형지정*/
			if(Constant.CP_APLPRDT_DIV_TYPE.equals(userCpvo.getAplprdtDiv())) {
				if(!userCpvo.getPrdtCtgrList().contains(cartVO.getCtgr())){
					isDelete = true;
				}
			}
			/** 상품지정*/
			if(Constant.CP_APLPRDT_DIV_PRDT.equals(userCpvo.getAplprdtDiv())) {
				CPVO cpvo = new CPVO();
				cpvo.setCpId(userCpvo.getCpId());

				List<CPPRDTVO> cpPrdtList = ossCouponService.selectCouponPrdtListWeb(cpvo);

				for(CPPRDTVO cpPrdt : cpPrdtList) {
					if(prdtNum.equals(cpPrdt.getPrdtNum())) {
						prdtCp = true;
						break;
					}
				}
				if(!prdtCp){
					isDelete = true;
				}
			}
			/** 업체지정 */
			if(Constant.CP_APLPRDT_DIV_CORP.equals(userCpvo.getAplprdtDiv())) {

				CPVO cpvo = new CPVO();
				cpvo.setCpId(userCpvo.getCpId());

				List<CPPRDTVO> cpCorpList = ossCouponService.selectCouponCorpListWeb(cpvo);

				for(CPPRDTVO cpPrdt : cpCorpList) {
					if(corpId.equals(cpPrdt.getCorpId())) {
						corpCp = true;
						break;
					}
				}
				if(!corpCp){
					isDelete = true;
				}
			}
			/** 승마전용 */
			if(userCpvo.getCpNm().contains("승마전용")){
				int tempLimitAmt = userCpvo.getLimitAmt();
				int tempQty = Integer.parseInt(qty);
				if(tempQty > 4){
					tempQty = 4;
				}
				userCpvo.setLimitAmt(tempLimitAmt * tempQty);
			}
			/** 소인,청소년 전용 */
			if(userCpvo.getCpNm().contains("청소년,소인")){
				if(cartVO.getOptNm() != null && !cartVO.getOptNm().equals("")){
					if(!cartVO.getOptNm().contains("소인") && !cartVO.getOptNm().contains("청소년") && !cartVO.getOptNm().contains("어린이") ){
						isDelete = true;
					}
				}
			}

			if(isDelete){
				it.remove();
			}
		}

		model.addAttribute("cpList", cpList);

		model.addAttribute("selectSn", cartVO.getCartSn());
		model.addAttribute("saleAmt", cartVO.getSaleAmt());

		return "/mw/order/cpLayer";
	}

   	/**
   	 * 결제페이지
   	 * 파일명 : order03
   	 * 작성일 : 2015. 12. 21. 오후 1:42:43
   	 * 작성자 : 최영철
   	 * @param rsvVO
   	 * @param request
   	 * @param model
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping("/mw/order03.do")
	public String order03(@ModelAttribute("RSVVO") RSVVO rsvVO,
						  HttpServletRequest request,
						  ModelMap model) throws Exception {
   		log.info("/mw/order03.do Call !!");

   		/** 문화누리카드 */
		/*String mnuricardYn = request.getParameter("mnuricard");
		if(mnuricardYn == null){
			mnuricardYn = "N";
		}*/

   		/** seq1 통합예약정보 select */
		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

		//파트너(협력사) 포인트 정보
		String ssPartnerCode = (String) request.getSession().getAttribute("ssPartnerCode");
		int usePoint = rsvInfo.getUsePoint();
		if (request.getSession().getAttribute("ssUsePoint") != null) {
			usePoint = (int) request.getSession().getAttribute("ssUsePoint");
		}

		//가용 포인트 보다 사용 포인트가 많을때 fail 처리
		if (usePoint > 0){
			POINTVO pointVO = new POINTVO();
			pointVO.setUserId(rsvInfo.getUserId());
			pointVO.setPartnerCode(ssPartnerCode);
			POINTVO partnerPoint = ossPointService.selectAblePoint(pointVO);

			if (usePoint > partnerPoint.getAblePoint()){
				return "redirect:/mw/orderFail2.do";
			}
		}
		model.addAttribute("ssPartnerCode", ssPartnerCode);
		model.addAttribute("usePoint", usePoint);

		/** seq2 예약건이 존재하지 않거나 자동 취소된 경우 처리 exception */
		if(rsvInfo == null) {
			return "redirect:/mw/orderFail2.do";
		} else {
			if(Constant.RSV_STATUS_CD_ACC.equals(rsvInfo.getRsvStatusCd())) {
				return "redirect:/mw/orderFail2.do";
			}
		}
    	model.addAttribute("rsvInfo", rsvInfo);

		/** 예약 초과시간 set */
		Date fromDate = Calendar.getInstance().getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date toDate = sdf.parse(rsvInfo.getRegDttm());
		long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) + (Constant.WAITING_TIME * 60);
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.SECOND, (int) difTime);
		SimpleDateFormat closeTime = new SimpleDateFormat("yyyyMMddHHmmss");
		model.addAttribute("closeTime", closeTime.format(cal.getTime()));
		model.addAttribute("difTime", difTime);

    	/** seq3 상세예약정보 selectList */
    	List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);

		/** seq4 대표상품명 set */
		String repPrdtNm = orderList.get(0).getCorpNm() + "-" + orderList.get(0).getPrdtNm();
		model.addAttribute("repPrdtNm", repPrdtNm);

		/** seq5 상품구분 set */
    	String orderDiv = null;
		for(ORDERVO order : orderList) {
			if(Constant.SV.equals(order.getPrdtNum().substring(0,2).toUpperCase())) {
				orderDiv = Constant.SV;
				break;
			}
		}

		for(ORDERVO order : orderList) {
			/** seq7 포인트 구매 가능 체크 */
			POINT_CORPVO pointCorpVO = new POINT_CORPVO();
			pointCorpVO.setCorpId(order.getCorpId());
			pointCorpVO.setPartnerCode(ssPartnerCode);
			pointCorpVO.setTotalProductAmt(Integer.valueOf(order.getSaleAmt()));
			if ( "N".equals(ossPointService.chkPointBuyAble(pointCorpVO)) ){
				order.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
			}
		}
		model.addAttribute("orderDiv", orderDiv);
    	model.addAttribute("orderList", orderList);

    	/** seq8 탐나는전 전용쿠폰인지 if */
		String onlyTamnacard = "N";
		for(ORDERVO order : orderList) {
			USER_CPVO useCp = webOrderService.selectUseCpList(order);
			if(!Objects.isNull(useCp) && EgovStringUtil.isEmpty(useCp.getCpNm()) == false && useCp.getCpNm().indexOf("탐나는전")!=-1) {
				onlyTamnacard = "Y";
				break;
			}
		}
		model.addAttribute("onlyTamnacard", onlyTamnacard);

    	/** seq9 토스결제 init(신용카드,계좌이체) */
		String CST_PLATFORM        = EgovProperties.getOptionalProp("CST_PLATFORM");     	//LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
	    String CST_MID             = EgovProperties.getProperty("Globals.LgdID.PRE");           	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
		/** 문화누리카드 */
		/*if(mnuricardYn.equals("Y")){
			CST_MID = EgovProperties.getProperty("Globals.LgdID.MNURICARD");
		}*/
	    String LGD_MID             = ("test".equals(CST_PLATFORM.trim())?"t":"") + CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
	    String MERT_KEY			   = EgovProperties.getProperty("Globals.LgdMertKey.PRE");
	    /** 문화누리카드 */
		/*if(mnuricardYn.equals("Y")){
			MERT_KEY = EgovProperties.getProperty("Globals.LgdMertKey.MNURICARD");
		}*/

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
	    for(int i=0 ; i < digest.length ; i++) {
	        int c = digest[i] & 0xff;
	        if(c <= 15) {
	            strBuf.append("0");
	        }
	        strBuf.append(Integer.toHexString(c));
	    }

	    String LGD_HASHDATA = strBuf.toString();
	    String LGD_RETURNURL = "local".equals(Constant.FLAG_INIT) ?
	    		"https://localhost:8443/mw/order04.do" :
	    		request.getScheme() + "://" + request.getServerName() + "/mw/order04.do";


	    String LGD_CASNOTEURL = "local".equals(Constant.FLAG_INIT) ?
	    		EgovProperties.getProperty("local.CYBER.RETURNURL") :
	    		request.getScheme() + "://" + request.getServerName() + EgovProperties.getProperty("Globals.CYBER.RETURNURL");

	    model.addAttribute("CST_PLATFORM"	, CST_PLATFORM);
		model.addAttribute("LGD_HASHDATA"	, LGD_HASHDATA);
		model.addAttribute("LGD_OID"		, LGD_OID);
		model.addAttribute("timeStamp"		, timeStamp);
		model.addAttribute("CST_MID"		, CST_MID);
		model.addAttribute("LGD_MID"		, LGD_MID);
		model.addAttribute("LGD_RETURNURL"	, LGD_RETURNURL);
		model.addAttribute("LGD_CASNOTEURL"	, LGD_CASNOTEURL);

		/** seq10 토스결제 init(휴대폰결제) */
	    String CST_MID_HP          = EgovProperties.getProperty("Globals.LgdID.HP");           	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
	    String LGD_MID_HP          = ("test".equals(CST_PLATFORM.trim())?"t":"") + CST_MID_HP;  //테스트 아이디는 't'를 제외하고 입력하세요.
	    String MERT_KEY_HP		   = EgovProperties.getProperty("Globals.LgdMertKey.HP");
	    StringBuffer sb2 = new StringBuffer();
	    sb2.append(LGD_MID_HP);
	    sb2.append(LGD_OID);
	    sb2.append(rsvInfo.getTotalSaleAmt());
	    sb2.append(timeStamp);
	    sb2.append(MERT_KEY_HP);

	    byte[] bNoti2 = sb2.toString().getBytes();
	    MessageDigest md2 = MessageDigest.getInstance("MD5");
	    byte[] digest2 = md2.digest(bNoti2);

	    StringBuffer strBuf2 = new StringBuffer();
	    for(int i=0 ; i < digest2.length; i++) {
	        int c = digest2[i] & 0xff;
	        if(c <= 15) {
	            strBuf2.append("0");
	        }
	        strBuf2.append(Integer.toHexString(c));
	    }

	    String LGD_HASHDATA_HP = strBuf2.toString();
	    String LGD_RETURNURL_HP = "local".equals(Constant.FLAG_INIT) ?
	    		"https://localhost:8443/mw/order04_HP.do" :
	    		request.getScheme() + "://" + request.getServerName() + "/mw/order04_HP.do";

		model.addAttribute("LGD_HASHDATA_HP"	, LGD_HASHDATA_HP);
		model.addAttribute("CST_MID_HP"			, CST_MID_HP);
		model.addAttribute("LGD_MID_HP"			, LGD_MID_HP);
		model.addAttribute("LGD_RETURNURL_HP"	, LGD_RETURNURL_HP);

		String connIp = EgovClntInfo.getClntIP(request);
		model.addAttribute("connIp", connIp);

		return "/mw/order/order02";
	}

   	/**
   	 * 모바일 결제 처리
   	 *  모바일에서는 이전 페이지를 가지고 있지 않으므로 바로 결제 처리를 실행하며
   	 *  그 결과에 따라 결제 완료 또는 결제 실패 페이지로 이동
   	 * 파일명 : order04
   	 * 작성일 : 2015. 12. 21. 오후 1:29:54
   	 * 작성자 : 최영철
   	 * @param rsvVO2
   	 * @param request
   	 * @param model
   	 * @return
   	 * @throws ParseException
   	 */
   	@RequestMapping("/mw/order04.do")
	public String order04(@ModelAttribute("RSVVO") RSVVO rsvVO2,
						  HttpServletRequest request,
						  ModelMap model) throws ParseException {
   		log.info("/mw/order04.do");
   		/** 예약정보*/
		RSVVO rsvInfo2 = webOrderService.selectByRsv(rsvVO2);

		/** 예약건 미존재, 자동취소*/
		if(rsvInfo2 == null){
			return "redirect:/mw/orderFail2.do";
		}else{
			/** 자동취소*/
			if(Constant.RSV_STATUS_CD_ACC.equals(rsvInfo2.getRsvStatusCd())){
				return "redirect:/mw/orderFail2.do";
			}
        }

		String chkPayMethod = request.getParameter("PayMethod");
		log.info("payMethod : " + chkPayMethod);
		/** 상품권,LPOINT 전액결제*/
		if("FREECP".equals(chkPayMethod) || "LPOINT".equals(chkPayMethod)|| "POINT".equals(chkPayMethod)){
			/** LS컴퍼니 연동 */
			boolean result = apiService.apiReservation(rsvInfo2.getRsvNum());
			if(!result){
				model.addAttribute("rtnCode", "상품수량만료");
				model.addAttribute("rtnMsg", "해당 상품을 이용할 수 없습니다. 불편을 드려죄송합니다.");
	   	     	return "/mw/order/orderFail";
			}

			// 무료쿠폰, L.Point, 파트너포인트 전체 결제
			switch(chkPayMethod){
				case "FREECP" : rsvInfo2.setPayDiv(Constant.PAY_DIV_LG_FI); break;
				case "LPOINT" : rsvInfo2.setPayDiv(Constant.PAY_DIV_LG_LI); break;
				case "POINT" : rsvInfo2.setPayDiv(Constant.PAY_DIV_TA_PI); break;
			}

			/** 결제처리*/
	    	webOrderService.updateRsvComplete3(rsvInfo2);
	    	/** 문자발송*/
	    	webOrderService.orderCompleteSnedSMSMail(rsvVO2,request);
	    	
	    	//자동쿠폰발행
			webUserCpService.baapCpPublish(rsvInfo2);
			
	    	return "redirect:/mw/orderComplete.do?rsvNum=" + rsvVO2.getRsvNum();
		}else{
			/** LG U+결제*/
			String configPath = EgovProperties.getProperty(Constant.FLAG_INIT + ".LgdFolder");
			/**
		     * 1.최종결제 요청 - BEGIN
		     *  (단, 최종 금액체크를 원하시는 경우 금액체크 부분 주석을 제거 하시면 됩니다.)
		     */
		    String CST_PLATFORM                 = EgovProperties.getOptionalProp("CST_PLATFORM");
		    String CST_MID                      = EgovProperties.getProperty("Globals.LgdID.PRE");
		    String LGD_MID                      = ("test".equals(CST_PLATFORM.trim())?"t":"") + CST_MID;
		    String LGD_PAYKEY                   = request.getParameter("LGD_PAYKEY");
		    log.info("LGD_PAYKEY :::" + LGD_PAYKEY);

		    LGPAYINFVO lGPAYINFO = new LGPAYINFVO();
		    String rtnMsg 	= "";
		    String rtnTitle = "";
		    String rtnCode 	= "";

		    /**해당 API를 사용하기 위해 WEB-INF/lib/XPayClient.jar 를 Classpath로 등록*/
		    XPayClient xpay = new XPayClient();
		   	boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);

		   	if(!isInitOK) {
		    	//API 초기화 실패 화면처리
		   		log.error("결제요청을 초기화 하는데 실패하였습니다.");
		        log.error("LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.");
		        log.error("mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.");
		        log.error("문의전화 LG유플러스 1544-7772");

		        rtnMsg   = "LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.";
		        rtnCode  = "-1";

		        model.addAttribute("rtnCode", rtnCode);
		        model.addAttribute("rtnMsg", rtnMsg);
	   	     	return "/mw/order/orderFail";
		   	}else{
		   		try{
		   			/** 1. 최종결제 요청(수정하지 마세요)*/
			    	xpay.Init_TX(LGD_MID);
			    	xpay.Set("LGD_TXNAME", "PaymentByKey");
			    	xpay.Set("LGD_PAYKEY", LGD_PAYKEY);
			    	/** 금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
			    	String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
			    	xpay.Set("LGD_AMOUNTCHECKYN", "Y");
			    	xpay.Set("LGD_AMOUNT", DB_AMOUNT);*/
		    	}catch(Exception e) {
		    		log.error("LG유플러스 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
		    		log.error("" + e.getMessage());
		    		rtnCode = "-1";
		    		rtnTitle =  "LG유플러스 제공 API를 사용할 수 없습니다. 고객센터에 문의하시기 바랍니다. ";
		    		rtnMsg   = e.getMessage();

			        model.addAttribute("rtnCode", rtnCode);
			        model.addAttribute("rtnTitle", rtnTitle);
			        model.addAttribute("rtnMsg", rtnMsg);

		   	     	return "/mw/order/orderFail";
		    	}
		   	}
		   	/** 2. 최종결제 요청 결과처리 (최종 결제요청 결과 리턴 파라미터는 연동메뉴얼을 참고)*/
		     if (xpay.TX()) {
		    	 rtnMsg   = xpay.m_szResMsg;
		    	 rtnCode  = xpay.m_szResCode;
		         /** 1) 결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)*/
		    	 log.info( "payment request has been completed");
		    	 log.info( "TX payment request response_code = " + xpay.m_szResCode);
		    	 log.info( "TX payment request response_msg = " + xpay.m_szResMsg);

		    	 log.info("거래번호 : " + xpay.Response("LGD_TID",0));
		    	 log.info("상점아이디 : " + xpay.Response("LGD_MID",0));
		    	 log.info("상점주문번호 : " + xpay.Response("LGD_OID",0));
		    	 log.info("결제금액 : " + xpay.Response("LGD_AMOUNT",0));
		    	 log.info("결과코드 : " + xpay.Response("LGD_RESPCODE",0));
		    	 log.info("결과메세지 : " + xpay.Response("LGD_RESPMSG",0));

		    	 /** 간편결제 타입초기화 */
		    	 lGPAYINFO.setLGD_EASYPAY_TRANTYPE("N");
		         for (int i = 0; i < xpay.ResponseNameCount(); i++){
		             for (int j = 0; j < xpay.ResponseCount(); j++){
		            	 log.info(xpay.ResponseName(i) + " = " + xpay.Response(xpay.ResponseName(i), j));
		            	 if(xpay.ResponseName(i).equals("LGD_EASYPAY_TRANTYPE")){
							if(xpay.Response(xpay.ResponseName(i), j).equals("KAKAOPAY")){
								lGPAYINFO.setLGD_EASYPAY_TRANTYPE("KAKAOPAY");
							}else if(xpay.Response(xpay.ResponseName(i), j).equals("APPLEPAY")){
								lGPAYINFO.setLGD_EASYPAY_TRANTYPE("APPLEPAY");
							}else if(xpay.Response(xpay.ResponseName(i), j).equals("NAVERPAY_CARD") || xpay.Response(xpay.ResponseName(i), j).equals("NAVERPAY_POINT")){
								lGPAYINFO.setLGD_EASYPAY_TRANTYPE("NAVERPAY");
							}else if(xpay.Response(xpay.ResponseName(i), j).equals("TOSSPAY")){
								lGPAYINFO.setLGD_EASYPAY_TRANTYPE("TOSSPAY");
							}
						 }
		             }
		         }
		         /** 결제 결과 저장*/
		         lGPAYINFO.setLGD_OID				(rsvVO2.getRsvNum());
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
		         lGPAYINFO.setLGD_CASFLAGY			(xpay.Response("LGD_CASFLAG",0));
		         lGPAYINFO.setLGD_ACCOUNTNUM		(xpay.Response("LGD_ACCOUNTNUM",0));
		         lGPAYINFO.setLGD_PAYER				(xpay.Response("LGD_PAYER",0));

		         if("0000".equals(xpay.m_szResCode)) {
		         	if(!"R".equals(lGPAYINFO.getLGD_CASFLAGY())){
		         		boolean result = apiService.apiReservation(xpay.Response("LGD_OID",0));
		         		if(!result){
							xpay.Rollback("API 연동 실패로 인한 Rollback 처리 [TID:" + xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
							log.info("fail : API order error");
							model.addAttribute("rtnCode", "상품수량만료");
							model.addAttribute("rtnMsg", "해당 상품을 이용할 수 없습니다. 불편을 드려죄송합니다.");
							return "/mw/order/orderFail2";
						}
					}

		        	/** 최종결제요청 결과 성공 DB처리 */
		        	 log.info(lGPAYINFO.getLGD_OID() + " 최종결제요청 결과 성공 DB처리하시기 바랍니다.");
		        	 RSVVO rsvVO = new RSVVO();
		        	 rsvVO.setRsvNum(request.getParameter("LGD_OID"));
		        	 // 예약기본정보
		        	 RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

		        	 // 예약기본정보가 존재하지 않을경우
		        	 if(rsvInfo == null){
		        		 log.error("예약기본정보가 자동취소[예약번호:" + request.getParameter("LGD_OID") + "]");
		        		 xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" + xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");

		        		 return "/mw/order/orderFail2";
		        	 }

		        	//최종결제요청 결과 성공 DB처리 실패시 Rollback 처리
//		         	boolean isDBOK = true; //DB처리 실패시 false로 변경해 주세요.

		         	try {
						//파트너 포인트 사용처리
						POINTVO pointVO = new POINTVO();
						if (rsvInfo.getPartnerCode() != null && rsvInfo.getUsePoint() > 0) {
							pointVO.setPartnerCode(rsvInfo.getPartnerCode());
							pointVO.setPoint(rsvInfo.getUsePoint());
							pointVO.setUserId(rsvInfo.getUserId());
							pointVO.setPlusMinus("M");
							pointVO.setTypes("USE");
							pointVO.setRsvNum(rsvInfo.getRsvNum());
							pointVO.setTotalSaleAmt(Integer.parseInt(rsvInfo.getTotalNmlAmt()) - Integer.parseInt(rsvInfo.getTotalDisAmt()));
							ossPointService.pointCpUse(pointVO);
						}

						//결제완료 처리
		         		webOrderService.updateRsvComplete(lGPAYINFO);
					} catch (Exception e) {
//						rtnCode = "-1";
						xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
						log.info( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0));
		         		log.info( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0));

		         		if("0000".equals(xpay.m_szResCode)) {
		         			log.info("자동취소가 정상적으로 완료됐습니다.");
		         		}else{
		         			log.info("자동취소가 정상적으로 처리되지 않았습니다.");
		         		}
					}
		         	rtnCode = xpay.m_szResCode;
		         }else{
		        	 //최종결제요청 결과 실패 DB처리
		        	 log.info("최종결제요청 결과 실패 DB처리하시기 바랍니다.");
		        	 webOrderService.insertLDGINFO(lGPAYINFO);
		         }
		     }else {
		         //2)API 요청실패 화면처리
		    	 log.info( "결제요청이 실패했습니다.");
		    	 log.info( "TX 결제요청 Response_code = " + xpay.m_szResCode);
		    	 log.info( "TX 결제요청 Response_msg = " + xpay.m_szResMsg);

		    	 rtnMsg = xpay.m_szResMsg;
		    	 //최종결제요청 결과 실패 DB처리
		    	 log.info("최종결제요청 결과 실패 DB처리하시기 바랍니다.");
		    	 //webOrderService.insertLDGINFO(lGPAYINFO);
		     }

		     if("0000".equals(rtnCode)){
		    	 /** 무통장입금 대기상태가 아니면*/
				if(!"R".equals(lGPAYINFO.getLGD_CASFLAGY())) {
					log.info("OK=====================================");
					//문자, SMS보내기
					webOrderService.orderCompleteSnedSMSMail(rsvVO2, request);
					
					//자동쿠폰발행
					webUserCpService.baapCpPublish(rsvInfo2);
					
					return "redirect:/mw/orderComplete.do?rsvNum=" + lGPAYINFO.getLGD_OID();
				}else{
					return "redirect:/mw/orderCompleteVaccount.do?rsvNum=" + lGPAYINFO.getLGD_OID();
				}

		     }else{
		    	 model.addAttribute("rsvNum", lGPAYINFO.getLGD_OID());
		    	 model.addAttribute("rtnCode", rtnCode);
		    	 model.addAttribute("rtnMsg", rtnMsg);

		    	 return "/mw/order/orderFail";
		     }
		}
	}

   	/**
   	 * 휴대폰 소액결제 완료 처리
   	 * 파일명 : order04_HP
   	 * 작성일 : 2016. 1. 15. 오후 3:42:21
   	 * 작성자 : 최영철
   	 * @param rsvVO2
   	 * @param request
   	 * @param response
   	 * @param model
   	 * @return
   	 * @throws UnsupportedEncodingException
   	 */
   	@RequestMapping("/mw/order04_HP.do")
	public String order04_HP(	@ModelAttribute("RSVVO") RSVVO rsvVO2,
							HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model) throws UnsupportedEncodingException, ParseException {

   		log.info("/mw/order04_HP.do Call !!");

   		// 예약기본정보
		RSVVO rsvInfo2 = webOrderService.selectByRsv(rsvVO2);

		// 예약건이 존재하지 않거나 자동 취소된 경우 처리
		if(rsvInfo2 == null){
			return "redirect:/mw/orderFail2.do";
		}else{
			// Constant.RSV_STATUS_CD_ACC(자동취소 : RS99)인 경우
			if(Constant.RSV_STATUS_CD_ACC.equals(rsvInfo2.getRsvStatusCd())){
				return "redirect:/mw/orderFail2.do";
			}
		}

		String chkPayMethod = request.getParameter("PayMethod");
		log.info("payMethod ::" + chkPayMethod);

		//LG유플러스에서 제공한 환경파일
		String configPath = EgovProperties.getProperty(Constant.FLAG_INIT + ".LgdFolder");

		/*
	     *************************************************
	     * 1.최종결제 요청 - BEGIN
	     *  (단, 최종 금액체크를 원하시는 경우 금액체크 부분 주석을 제거 하시면 됩니다.)
	     *************************************************
	     */

	    String CST_PLATFORM                 = EgovProperties.getOptionalProp("CST_PLATFORM");
	    String CST_MID                      = EgovProperties.getProperty("Globals.LgdID.HP");
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
   	     	return "/mw/order/orderFail";
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
	   	     	return "/mw/order/orderFail";
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
	         lGPAYINFO.setLGD_OID				(rsvVO2.getRsvNum());
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

	         if("0000".equals( xpay.m_szResCode ) ) {
	         	boolean result = apiService.apiReservation(xpay.Response("LGD_OID",0));
	         	if(!result){
					xpay.Rollback("API 연동 실패로 인한 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
					log.info("fail : API order error");
					model.addAttribute("rtnCode", "상품수량만료");
					model.addAttribute("rtnMsg", "해당 상품을 이용할 수 없습니다. 불편을 드려죄송합니다.");
					return "/mw/order/orderFail";
				}
	        	//최종결제요청 결과 성공 DB처리
	        	 log.info(lGPAYINFO.getLGD_OID() + " 최종결제요청 결과 성공 DB처리하시기 바랍니다.");

	        	 RSVVO rsvVO = new RSVVO();
	        	 rsvVO.setRsvNum(request.getParameter("LGD_OID"));
	        	 // 예약기본정보
	        	 RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

	        	 // 예약기본정보가 존재하지 않을경우
	        	 if(rsvInfo == null){
	        		 log.error("예약기본정보가 자동취소[예약번호:" + request.getParameter("LGD_OID") + "]");

	        		 xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
	        		 return "/mw/order/orderFail2";
	        	 }

	        	 //최종결제요청 결과 성공 DB처리 실패시 Rollback 처리
	        	 //boolean isDBOK = true; //DB처리 실패시 false로 변경해 주세요.

	        	 try {
					//파트너 포인트 사용처리
					POINTVO pointVO = new POINTVO();
					if (rsvInfo.getPartnerCode() != null && rsvInfo.getUsePoint() > 0) {
						pointVO.setPartnerCode(rsvInfo.getPartnerCode());
						pointVO.setPoint(rsvInfo.getUsePoint());
						pointVO.setUserId(rsvInfo.getUserId());
						pointVO.setPlusMinus("M");
						pointVO.setTypes("USE");
						pointVO.setRsvNum(rsvInfo.getRsvNum());
						pointVO.setTotalSaleAmt(Integer.parseInt(rsvInfo.getTotalNmlAmt()) - Integer.parseInt(rsvInfo.getTotalDisAmt()));
						ossPointService.pointCpUse(pointVO);
					}

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
	    	 //webOrderService.insertLDGINFO(lGPAYINFO);
	     }

	     if("0000".equals(rtnCode)){

	    	//문자, SMS보내기
	    	webOrderService.orderCompleteSnedSMSMail(rsvVO2,request);
	    	
	    	//자동쿠폰발행
			webUserCpService.baapCpPublish(rsvInfo2);
			
	    	return "redirect:/mw/orderComplete.do?rsvNum=" + lGPAYINFO.getLGD_OID();
	     }else{
	    	 model.addAttribute("rsvNum", lGPAYINFO.getLGD_OID());
	    	 model.addAttribute("rtnCode", rtnCode);
	    	 model.addAttribute("rtnMsg", rtnMsg);
	    	 return "/mw/order/orderFail";
	     }
	}

   	/**
	 * 주문완료
	 * 파일명 : orderComplete
	 * 작성일 : 2015. 12. 8. 오후 2:40:00
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @param model
	 * @return
	 */
   	@RequestMapping("/mw/orderComplete.do")
	public String orderComplete(@ModelAttribute("RSVVO") RSVVO rsvVO,
								ModelMap model) {
   		log.info("/mw/orderComplete.do Call !!");
   		
		// 예약기본정보
 		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);
     	model.addAttribute("rsvInfo", rsvInfo);
     	// 예약 상품 리스트
     	List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);
     	model.addAttribute("orderList", orderList);

		return "/mw/order/orderComplete";
	}

	@RequestMapping("/mw/orderCompleteVaccount.do")
	public String orderCompleteVaccount(@ModelAttribute("RSVVO") RSVVO rsvVO,
			ModelMap model) throws java.text.ParseException {
   		log.info("/mw/orderCompleteVaccount.do Call !!");

		rsvVO.setLGD_RESPCODE("8888");
		// 예약기본정보
 		RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);
     	model.addAttribute("rsvInfo", rsvInfo);
     	// 예약 상품 리스트
     	List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);
     	model.addAttribute("orderList", orderList);

     	LGPAYINFVO payInfo =  webOrderService.selectLGPAYINFO_V(rsvVO);
     	model.addAttribute("payInfo", payInfo);

     	Date fromDate = Calendar.getInstance().getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date toDate = sdf.parse(rsvInfo.getRegDttm());

		long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) + (Constant.WAITING_TIME * 60);

		model.addAttribute("difTime", difTime);

		return "/mw/order/orderCompleteVaccount";
	}
   	
	@RequestMapping("/mw/orderFail2.do")
	public String orderFail2(){
		return "/mw/order/orderFail2";
	}

	public String SHA256Salt(String strData, String salt) {
		  String SHA = "";

		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.reset();
			sh.update(salt.getBytes());
			byte byteData[] = sh.digest(strData.getBytes());

			//Hardening against the attacker's attack
			sh.reset();
			byteData = sh.digest(byteData);

			StringBuffer sb = new StringBuffer();
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));

			}

			SHA = sb.toString();
			byte[] raw = SHA.getBytes();
			byte[] encodedBytes = Base64.encodeBase64(raw);
			SHA = new String(encodedBytes);
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = null;
		}

		return SHA;
	}
}
