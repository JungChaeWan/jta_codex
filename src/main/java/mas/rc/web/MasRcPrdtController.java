package mas.rc.web;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mas.ad.vo.AD_PRDTINFSVO;
import mas.ad.vo.AD_PRDTINFVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.*;
import mas.sp.service.MasSpService;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_CONFHISTVO;
import oss.cmm.vo.CM_ICONINFVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.env.service.OssSiteManageService;
import oss.prdt.service.OssPrdtService;
import oss.prdt.vo.PRDTVO;
import oss.user.vo.USERVO;
import web.mypage.vo.POCKETVO;
import web.order.vo.RC_RSVVO;
import web.order.vo.RSVSVO;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;
import web.product.vo.WEB_SPPRDTVO;
import web.product.vo.WEB_SPSVO;

import common.Constant;
import common.EgovUserDetailsHelper;

import egovframework.cmmn.EgovMessageSource;
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
public class MasRcPrdtController {

    @Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

    @Resource(name="ossCmmService")
    private OssCmmService ossCmmService;

    @Resource(name="masRcPrdtService")
    private MasRcPrdtService masRcPrdtService;

    @Resource(name="ossFileUtilService")
    private OssFileUtilService ossFileUtilService;

    @Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

    @Resource(name = "masSpService")
	private MasSpService masSpService;

    @Resource(name = "ossPrdtService")
    private OssPrdtService ossPrdtService;

    @Resource(name = "ossSiteManageService")
    private OssSiteManageService ossSiteManageService;
    
    @Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;
    
    @Resource(name = "webSpService")
	protected WebSpProductService webSpService;

    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    Logger log = (Logger) LogManager.getLogger(this.getClass());

    /**
     * 렌트카 기본정보
     * 파일명 : rentCarInfo
     * 작성일 : 2015. 10. 5. 오후 5:31:21
     * 작성자 : 최영철
     * @param rc_DFTINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/rentCarInfo.do")
    public String rentCarInfo(@ModelAttribute("RC_DFTINFVO") RC_DFTINFVO rc_DFTINFVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rc_DFTINFVO.setCorpId(corpInfo.getCorpId());

    	RC_DFTINFVO rentCarInfo = masRcPrdtService.selectByRcDftInfo(rc_DFTINFVO);
    	if(rentCarInfo == null){
    		model.addAttribute("rentCarInfo", rc_DFTINFVO);
    		model.addAttribute("existYn", "N");
    	}else{
    		model.addAttribute("rentCarInfo", rentCarInfo);
    		model.addAttribute("existYn", "Y");
    	}


    	//승인된 상품 수량 얻기
    	RC_PRDTINFVO prdtInfVO = new RC_PRDTINFVO();
    	prdtInfVO.setCorpId(corpInfo.getCorpId());
    	prdtInfVO.setTradeStatus(Constant.TRADE_STATUS_APPR);
    	int nPrdtCnt = masRcPrdtService.getCntRcPrdtFormCorp(prdtInfVO);
    	model.addAttribute("prdtCnt", nPrdtCnt);

    	return "/mas/rc/rentCarInfo";
    }

    /**
     * 렌트카 기본정보 등록
     * 파일명 : updateRentCarInfo
     * 작성일 : 2015. 10. 5. 오후 7:30:33
     * 작성자 : 최영철
     * @param dftInfFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/updateRentCarInfo.do")
    public String updateRentCarInfo(@ModelAttribute("RC_DFTINFVO") RC_DFTINFVO dftInfFVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	dftInfFVO.setFrstRegId(corpInfo.getUserId());
    	dftInfFVO.setLastModId(corpInfo.getUserId());
    	masRcPrdtService.mergeRcDftInfo(dftInfFVO);
    	return "redirect:/mas/rc/rentCarInfo.do";
    }

    /**
     * 렌트카 상품 리스트 조회
     * 파일명 : rcPrdtList
     * 작성일 : 2015. 10. 6. 오전 9:30:54
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/productList.do")
    public String rcPrdtList(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		ModelMap model){
    	RC_DFTINFVO rc_DFTINFVO = new RC_DFTINFVO();
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rc_DFTINFVO.setCorpId(corpInfo.getCorpId());
    	prdtInfSVO.setsCorpId(corpInfo.getCorpId());

    	RC_DFTINFVO rentCarInfo = masRcPrdtService.selectByRcDftInfo(rc_DFTINFVO);
    	if(rentCarInfo == null){
    		return "redirect:/mas/rc/rentCarInfo.do";
    	}

		// 업체정보 가져 오기.
		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(prdtInfSVO.getsCorpId());
		CORPVO corpResult = ossCorpService.selectCorpByCorpId(corpVO);

    	prdtInfSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	prdtInfSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prdtInfSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prdtInfSVO.getPageUnit());
		paginationInfo.setPageSize(prdtInfSVO.getPageSize());

		prdtInfSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prdtInfSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prdtInfSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = masRcPrdtService.selectRcPrdtList(prdtInfSVO);

		@SuppressWarnings("unchecked")
		List<CORPVO> resultList = (List<CORPVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("corpResult", corpResult);
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);


		// 차량연료코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
    	model.addAttribute("fuelCd", cdList);
    	// 차량구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);
    	// 변속기구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_TRANS_DIV);
    	model.addAttribute("transDivCd", cdList);
    	// 제조사구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
    	model.addAttribute("makerDivCd", cdList);
    	// 보험구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_ISR_DIV_CD);
    	model.addAttribute("isrDivCd", cdList);

    	// 거래상태코드
    	cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCd", cdList);

    	return "/mas/rc/rcPrdtList";
    }

    /**
     * 상품 등록 화면 호출
     * 파일명 : viewInsertPrdt
     * 작성일 : 2015. 10. 8. 오후 1:21:33
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param prdtInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/viewInsertPrdt.do")
    public String viewInsertPrdt(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    								@ModelAttribute("RC_PRDTINFVO") RC_PRDTINFVO prdtInfVO,
    								ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	// 차량연료코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
    	model.addAttribute("fuelCd", cdList);
    	// 차량구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);
    	// 변속기구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_TRANS_DIV);
    	model.addAttribute("transDivCd", cdList);
    	// 제조사구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
    	model.addAttribute("makerDivCd", cdList);
    	// 거래상태코드
    	cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCd", cdList);
    	// 차량코드
    	cdList = ossCmmService.selectCode(Constant.RC_CAR_CD);
    	model.addAttribute("carCd", cdList);
    	// 보험여부코드
    	cdList = ossCmmService.selectCode(Constant.RC_ISR_DIV_CD);
    	model.addAttribute("isrCd", cdList);
    	// 주요정보
    	cdList = ossCmmService.selectCode(Constant.ICON_CD_RCAT);
    	model.addAttribute("iconCd", cdList);
    	
    	// 업체정보
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	CORPVO corpInf = ossCorpService.selectByCorp(corpVO);
    	model.addAttribute("corpInf", corpInf);

    	RC_PRDTINFSVO cntChkVO = new RC_PRDTINFSVO();
    	cntChkVO.setsCorpId(corpInfo.getCorpId());
    	Integer totalCnt = masRcPrdtService.getCntRcPrdtList(cntChkVO);

    	model.addAttribute("totalCnt", totalCnt);
    	model.addAttribute("RC_PRDTINFVO", prdtInfVO);
    	return "/mas/rc/insertPrdt";
    }

    /**
     * 상품 등록
     * 파일명 : insertPrdt
     * 작성일 : 2015. 10. 8. 오후 1:21:44
     * 작성자 : 최영철
     * @param prdtInfVO
     * @param bindingResult
     * @param multiRequest
     * @param prdtInfSVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/rc/insertPrdt.do")
    public String insertPrdt(	@ModelAttribute("RC_PRDTINFVO") RC_PRDTINFVO prdtInfVO,
					    		BindingResult bindingResult,
					    		final MultipartHttpServletRequest multiRequest,
					    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
					    		ModelMap model) throws Exception{
    	log.info("/mas/rc/insertPrdt.do 호출");
    	// validation 체크
		beanValidator.validate(prdtInfVO, bindingResult);
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		if (bindingResult.hasErrors()){
			log.info("error");
			// 차량연료코드
	    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
	    	model.addAttribute("fuelCd", cdList);
	    	// 차량구분코드
	    	cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
	    	model.addAttribute("carDivCd", cdList);
	    	// 변속기구분코드
	    	cdList = ossCmmService.selectCode(Constant.RC_TRANS_DIV);
	    	model.addAttribute("transDivCd", cdList);
	    	// 제조사구분코드
	    	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
	    	model.addAttribute("makerDivCd", cdList);
	    	// 거래상태코드
	    	cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
	    	model.addAttribute("tsCd", cdList);
	    	// 주요정보
	    	cdList = ossCmmService.selectCode(Constant.ICON_CD_RCAT);
	    	model.addAttribute("iconCd", cdList);
	    	// 보험여부코드
	    	cdList = ossCmmService.selectCode(Constant.RC_ISR_DIV_CD);
	    	model.addAttribute("isrCd", cdList);

	    	// 차량코드
	    	cdList = ossCmmService.selectCode(Constant.RC_CAR_CD);
	    	model.addAttribute("carCd", cdList);

	    	RC_PRDTINFSVO cntChkVO = new RC_PRDTINFSVO();
	    	cntChkVO.setsCorpId(corpInfo.getCorpId());
	    	Integer totalCnt = masRcPrdtService.getCntRcPrdtList(cntChkVO);

	    	model.addAttribute("totalCnt", totalCnt);
			log.info(bindingResult.toString());
			model.addAttribute("RC_PRDTINFVO", prdtInfVO);
	    	return "/mas/rc/insertPrdt";
		}
		prdtInfVO.setFrstRegId(corpInfo.getUserId());
		prdtInfVO.setCorpId(corpInfo.getCorpId());
		masRcPrdtService.insertPrdt(prdtInfVO, multiRequest);

    	return "redirect:/mas/rc/productList.do";
    }

    /**
     * 렌터카 상품 상세 정보
     * 파일명 : detailPrdt
     * 작성일 : 2015. 10. 8. 오후 1:41:56
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param prdtInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/detailPrdt.do")
    public String detailPrdt(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
								@ModelAttribute("RC_PRDTINFVO") RC_PRDTINFVO prdtInfVO,
								ModelMap model){

    	// 업체에 해당하는 상품 체크
    	if (masRcPrdtService.checkCorpPrdt(prdtInfVO) == 0) {
    		model.addAttribute("errorCode", "1");
    	} else {
	    	// 차량연료코드
	    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
	    	model.addAttribute("fuelCd", cdList);
	    	// 차량구분코드
	    	cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
	    	model.addAttribute("carDivCd", cdList);
	    	// 변속기구분코드
	    	cdList = ossCmmService.selectCode(Constant.RC_TRANS_DIV);
	    	model.addAttribute("transDivCd", cdList);
	    	// 제조사구분코드
	    	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
	    	model.addAttribute("makerDivCd", cdList);
	    	// 거래상태코드
	    	cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
	    	model.addAttribute("tsCd", cdList);
	    	// 차량코드
	    	cdList = ossCmmService.selectCode(Constant.RC_CAR_CD);
	    	model.addAttribute("carCd", cdList);
	    	// 보험여부코드
	    	cdList = ossCmmService.selectCode(Constant.RC_ISR_DIV_CD);
	    	model.addAttribute("isrCd", cdList);
	    	// 주요정보 체크 리스트
	    	List<CM_ICONINFVO> iconCdList = ossCmmService.selectCmIconinf(prdtInfVO.getPrdtNum(), Constant.ICON_CD_RCAT);
	    	model.addAttribute("iconCdList", iconCdList);

	    	prdtInfVO = masRcPrdtService.selectByPrdt(prdtInfVO);

	    	prdtInfVO.setIsrAmtGuide(EgovStringUtil.checkHtmlView(prdtInfVO.getIsrAmtGuide()) );

	    	model.addAttribute("prdtInf", prdtInfVO);

			// 차종 정보
			RC_CARDIVVO cardivVO = new RC_CARDIVVO();
			cardivVO.setRcCardivNum(prdtInfVO.getRcCardivNum());

			cardivVO = masRcPrdtService.selectCardiv(cardivVO);
			model.addAttribute("cardiv", cardivVO);

	    	//전달사항
	   		String apprMsg = masSpService.prdtApprMsg(prdtInfVO.getPrdtNum());
			if(StringUtils.isNotEmpty(apprMsg)) {
				apprMsg = EgovStringUtil.checkHtmlView(apprMsg);
			}
			model.addAttribute("apprMsg", apprMsg);
    	}

    	return "/mas/rc/detailPrdt";
    }

    /**
     * 렌터카 상품 수정 화면
     * 파일명 : viewUpdatePrdt
     * 작성일 : 2015. 10. 8. 오후 3:58:02
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param prdtInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/viewUpdatePrdt.do")
    public String viewUpdatePrdt(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    								@ModelAttribute("RC_PRDTINFVO") RC_PRDTINFVO prdtInfVO,
    								ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

    	prdtInfVO = masRcPrdtService.selectByPrdt(prdtInfVO);

    	// 차량연료코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
    	model.addAttribute("fuelCd", cdList);
    	// 차량구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);
    	// 변속기구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_TRANS_DIV);
    	model.addAttribute("transDivCd", cdList);
    	// 제조사구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
    	model.addAttribute("makerDivCd", cdList);
    	// 거래상태코드
    	cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCd", cdList);
    	// 차량코드
    	cdList = ossCmmService.selectCode(Constant.RC_CAR_CD);
    	model.addAttribute("carCd", cdList);
    	// 보험여부코드
    	cdList = ossCmmService.selectCode(Constant.RC_ISR_DIV_CD);
    	model.addAttribute("isrCd", cdList);

    	// 주요정보 체크 리스트
    	List<CM_ICONINFVO> iconCdList = ossCmmService.selectCmIconinf(prdtInfVO.getPrdtNum(), Constant.ICON_CD_RCAT);
    	model.addAttribute("iconCdList", iconCdList);
    	
    	// 업체정보
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	CORPVO corpInf = ossCorpService.selectByCorp(corpVO);

    	model.addAttribute("corpInf", corpInf);

    	RC_PRDTINFSVO cntChkVO = new RC_PRDTINFSVO();
    	cntChkVO.setsCorpId(corpInfo.getCorpId());
    	Integer totalCnt = masRcPrdtService.getCntRcPrdtList(cntChkVO);

    	model.addAttribute("totalCnt", totalCnt);

    	// 차종 정보
		RC_CARDIVVO cardivVO = new RC_CARDIVVO();
		cardivVO.setRcCardivNum(prdtInfVO.getRcCardivNum());

		cardivVO = masRcPrdtService.selectCardiv(cardivVO);
		model.addAttribute("cardiv", cardivVO);

    	model.addAttribute("prdtInf", prdtInfVO);

    	return "/mas/rc/updatePrdt";

    }

    @RequestMapping("/mas/rc/updatePrdt.do")
    public String updatePrdt(	@ModelAttribute("RC_PRDTINFVO") RC_PRDTINFVO prdtInfVO,
    							BindingResult bindingResult,
    							@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    							ModelMap model,
								RedirectAttributes rttr
								){
    	// validation 체크
		beanValidator.validate(prdtInfVO, bindingResult);

		if (bindingResult.hasErrors()){
			log.info("error");
			// 차량연료코드
	    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
	    	model.addAttribute("fuelCd", cdList);
	    	// 차량구분코드
	    	cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
	    	model.addAttribute("carDivCd", cdList);
	    	// 변속기구분코드
	    	cdList = ossCmmService.selectCode(Constant.RC_TRANS_DIV);
	    	model.addAttribute("transDivCd", cdList);
	    	// 제조사구분코드
	    	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
	    	model.addAttribute("makerDivCd", cdList);
	    	// 거래상태코드
	    	cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
	    	model.addAttribute("tsCd", cdList);
	    	// 주요정보
	    	cdList = ossCmmService.selectCode(Constant.ICON_CD_RCAT);
	    	model.addAttribute("iconCd", cdList);
	    	// 보험여부코드
	    	cdList = ossCmmService.selectCode(Constant.RC_ISR_DIV_CD);
	    	model.addAttribute("isrCd", cdList);

	    	// 차량코드
	    	cdList = ossCmmService.selectCode(Constant.RC_CAR_CD);
	    	model.addAttribute("carCd", cdList);
			log.info(bindingResult.toString());
			model.addAttribute("RC_PRDTINFVO", prdtInfVO);
	    	return "/mas/rc/updatePrdt";
		}
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		prdtInfVO.setCorpId(corpInfo.getCorpId());
		prdtInfVO.setLastModId(corpInfo.getUserId());
    	masRcPrdtService.updatePrdt(prdtInfVO);

    	if( prdtInfVO.getOldSn() != prdtInfVO.getNewSn() ){
   			//log.info("/mas/ad/updatePrdt.do 호출:1");
    		masRcPrdtService.updateRcPrdtViewSn(prdtInfVO);
   		}

    	rttr.addFlashAttribute("searchVO", prdtInfSVO);
    	/*return "redirect:/mas/rc/detailPrdt.do?prdtNum=" + prdtInfVO.getPrdtNum();*/
    	return "redirect:/mas/rc/productList.do";
    }

	@RequestMapping("/mas/rc/apiRcTest.ajax")
	public ModelAndView apiRcTest(	HttpServletRequest request ) throws Exception{

		USERVO userVO = (USERVO) RequestContextHolder.getRequestAttributes().getAttribute("masLoginVO", RequestAttributes.SCOPE_SESSION);
		System.out.println("userVO.getCorpId() ::::: " + userVO.getCorpId());

		String grimLoginId = "xkaskdhrmfladusruf2018";
		String grimLoginPw = "qlqjs2018";

		String linkMappingNum = request.getParameter("linkMappingNum");
		String linkMappingIsrNum = request.getParameter("linkMappingIsrNum");
		String corpId =  userVO.getCorpId();

		Map<String, Object> resultMap = new HashMap<String, Object>();

		String rcAbleChkUrl = "http://tamnao.mygrim.com/carlist.php";
		String rcAbleChkParam = "tamnao_loginid=" + grimLoginId
		+ "&tamnao_loginpw=" + grimLoginPw
		+ "&st=" + request.getParameter("st")
		+ "&et=" + request.getParameter("et")
		+ "&tamnao_cid=" + corpId
		+ "&rentcar_mid=" + linkMappingNum;

		System.out.println("rcAbleChkParam :::: "+rcAbleChkParam);

		BufferedReader rd = null;
		URL url = new URL(rcAbleChkUrl);
		URLConnection conn = url.openConnection();

		conn.setDoOutput(true);
		OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
		wr.write(rcAbleChkParam);
		wr.flush();

		rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		/** API결과 */
		String rdStr = rd.readLine();
		JSONParser jsonParser = new JSONParser();
		/** obj는 업체ID를 담고 있음*/
		JSONObject obj = new JSONObject();

		JSONObject apiObj1 = new JSONObject();
		JSONObject apiObj2 = new JSONObject();
		JSONObject apiObj3 = new JSONObject();
		JSONObject apiObj4 = new JSONObject();

		System.out.println("rdStr" + rdStr);
		if("[]".equals(rdStr)){
			resultMap.put("result", "정보를 찾을 수 없습니다.");
		}else{
			apiObj1 = (JSONObject) jsonParser.parse(rdStr);
			if(apiObj1.get(corpId).equals("[]")){
				resultMap.put("result", "차량정보를 찾을 수 없습니다.");
			}else{
				apiObj2 = (JSONObject) jsonParser.parse(apiObj1.get(corpId).toString())   ;
				if(apiObj2.toString().contains("codemsg")){
					resultMap.put("result", apiObj2.get("codemsg"));
				}else{
					apiObj2 = (JSONObject) jsonParser.parse(apiObj2.get(linkMappingNum).toString());
					resultMap.put("result", "[통신성공]");
					resultMap.put("model_id", apiObj2.get("model_id"));
					resultMap.put("model_name", apiObj2.get("model_name"));
					resultMap.put("model_defaultfee", apiObj2.get("model_defaultfee"));
					resultMap.put("model_salefee", apiObj2.get("model_salefee"));
					resultMap.put("model_rate", apiObj2.get("model_rate"));

					if(StringUtils.isNotEmpty(linkMappingIsrNum)) {
						apiObj3 = (JSONObject) jsonParser.parse(apiObj2.get("insurance").toString());
						apiObj4 = (JSONObject) jsonParser.parse(apiObj3.get(linkMappingIsrNum).toString());
						resultMap.put("insurance_id",apiObj4.get("insurance_id"));
						resultMap.put("insurance_name",apiObj4.get("insurance_name"));
						resultMap.put("insurance_salefee",apiObj4.get("insurance_salefee"));
					}
					/** corpId 키값 세팅 */
					Set key = obj.keySet();
					Iterator<String> iter = key.iterator();
					/** corpId키값을 루프*/
					while (iter.hasNext()) {
						/** 키값 세팅*/
						String keyname = iter.next();
						/** 키값이 null이 아닐결우 또는 []문자열 예외처리 */
						if (obj.get(keyname) != null && obj.get(keyname).toString() != "" && !obj.get(keyname).toString().contains("[]")) {
							/** obj2는 linkMappingNum을 가지고 있음*/
							JSONObject obj2 = (JSONObject) jsonParser.parse(obj.get(keyname).toString());
							/** linkMappingNum 키값 세팅*/
							Set key2 = obj2.keySet();
							Iterator<String> iter2 = key2.iterator();
							/** linkMappingNum 키값을 루프*/
							while (iter2.hasNext()) {
								String keyname2 = iter2.next();
								/**예외처리*/
								if (keyname2.equals("resultcode")) {
									continue;
								}
								/** linkMappingNum이 있으면*/
								if (StringUtils.isNotEmpty(keyname2)) {
									RC_PRDTINFVO rcPrdtinfo = new RC_PRDTINFVO();
									/** 회사ID 셋*/
									rcPrdtinfo.setCorpId(keyname);
									/** linkMappingNum 셋 */
									rcPrdtinfo.setLinkMappingNum(keyname2);
									/** obj3는 대여료/보험정보를 가지고 있음*/
									JSONObject obj3 = (JSONObject) jsonParser.parse(obj2.get(keyname2).toString());
									/** 대여료가 있으면*/
									if (obj3.get("model_salefee") != null) {
										/** 대여료 셋 */
										rcPrdtinfo.setLinkMappingSaleAmt(obj3.get("model_salefee").toString());
									}
									/** 보험정보가 있으면*/
									if (obj3.get("insurance") != null) {
										JSONObject obj4 = (JSONObject) jsonParser.parse(obj3.get("insurance").toString());
										/** 보험ID 키값 세팅*/
										Set key3 = obj4.keySet();
										Iterator<String> iter3 = key3.iterator();
										/** 보험ID 키값을 루프*/
										while (iter3.hasNext()) {
											String keyname3 = iter3.next();
											if (org.apache.commons.lang.StringUtils.isNotEmpty(keyname3)) {
												JSONObject obj5 = (JSONObject) jsonParser.parse(obj4.get(keyname3).toString());
												if (obj5.get("insurance_salefee") != null) {
													RC_PRDTINFVO apiResultVo = new RC_PRDTINFVO();
													apiResultVo.setCorpId(rcPrdtinfo.getCorpId());
													apiResultVo.setLinkMappingNum(rcPrdtinfo.getLinkMappingNum());
													apiResultVo.setLinkMappingSaleAmt(rcPrdtinfo.getLinkMappingSaleAmt());
													apiResultVo.setLinkMappingIsrNum(obj5.get("insurance_id").toString());
													apiResultVo.setLinkMappingIsrAmt(obj5.get("insurance_salefee").toString());

												}
											}
										}
										/** 보험정보가 없다면*/
									} else {

									}
								}
							}
						} else {
							resultMap.put("result", "차량정보를 찾을 수 없습니다.");
							break;
						}
					}
				}
			}
		}
		rd.close();
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

    /**
     * 이미지 관리 리스트
     * 파일명 : imgList
     * 작성일 : 2015. 10. 7. 오후 8:50:47
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param prdtInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/imgList.do")
    public String imgList(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		@ModelAttribute("prdtInf") RC_PRDTINFVO prdtInfVO,
    		ModelMap model){
    	// 업체에 해당하는 상품 체크
    	if (masRcPrdtService.checkCorpPrdt(prdtInfVO) == 0) {
    		model.addAttribute("errorCode", "1");
    	} else {
	    	prdtInfVO = masRcPrdtService.selectByPrdt(prdtInfVO);
	    	model.addAttribute("prdtInf", prdtInfVO);
    	}
    	return "/mas/rc/imgList";
    }

    /**
     * 요금 관리 리스트
     * 파일명 : amtList
     * 작성일 : 2015. 10. 12. 오후 8:00:17
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param amtInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/amtList.do")
    public String amtList(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
							@ModelAttribute("RC_AMTINFVO") RC_AMTINFVO amtInfVO,
							ModelMap model){
    	RC_PRDTINFVO prdtInfVO = new RC_PRDTINFVO();
    	prdtInfVO.setPrdtNum(amtInfVO.getPrdtNum());
    	// 업체에 해당하는 상품 체크
    	if (masRcPrdtService.checkCorpPrdt(prdtInfVO) == 0) {
    		model.addAttribute("errorCode", "1");
    	} else {
	    	prdtInfVO = masRcPrdtService.selectByPrdt(prdtInfVO);
	    	model.addAttribute("prdtInf", prdtInfVO);

			List<RC_AMTINFVO> resultList = (List<RC_AMTINFVO>) masRcPrdtService.selectRcPrdtAmtList(amtInfVO);

			model.addAttribute("resultList", resultList);
			model.addAttribute("amtInfVO", amtInfVO);
    	}

    	return "/mas/rc/rcAmtList";
    }


    /**
     * 요금 추가
     * 파일명 : insertPrdtdAmt
     * 작성일 : 2015. 10. 12. 오후 8:00:26
     * 작성자 : 최영철
     * @param amtInfVO
     * @param bindingResult
     * @param prdtInfSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/insertPrdtAmt.do")
    public String insertPrdtdAmt(	@ModelAttribute("RC_AMTINFVO") RC_AMTINFVO amtInfVO,
    								BindingResult bindingResult,
    								@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
									ModelMap model){
    	// validation 체크
    	beanValidator.validate(amtInfVO, bindingResult);

    	if (bindingResult.hasErrors()){
			log.info("error");
			List<RC_AMTINFVO> resultList = (List<RC_AMTINFVO>) masRcPrdtService.selectRcPrdtAmtList(amtInfVO);
			log.info(bindingResult.toString());
			model.addAttribute("resultList", resultList);
    		model.addAttribute("amtInfVO", amtInfVO);
    		model.addAttribute("error", "Y");
			return "/mas/rc/rcAmtList";
		}

    	// 동일한 적용일자의 데이터가 있는지 체크
    	RC_AMTINFVO chkVO = masRcPrdtService.selectByPrdtAmt(amtInfVO);

    	if(chkVO != null){
    		bindingResult.rejectValue("viewAplDt", "errors.range2", new Object[]{"적용일자"},"");
    		List<RC_AMTINFVO> resultList = (List<RC_AMTINFVO>) masRcPrdtService.selectRcPrdtAmtList(amtInfVO);

    		model.addAttribute("resultList", resultList);
    		model.addAttribute("amtInfVO", amtInfVO);
    		model.addAttribute("error", "Y");
			return "/mas/rc/rcAmtList";
    	}

    	masRcPrdtService.insertPrdtAmt(amtInfVO);

    	return "redirect:/mas/rc/amtList.do?prdtNum=" + amtInfVO.getPrdtNum();
    }

    /**
     * 렌터카 요금 수정을 위해 요금 단건 조회
     * 파일명 : selectByPrdtAmt
     * 작성일 : 2015. 10. 13. 오후 1:23:35
     * 작성자 : 최영철
     * @param amtInfVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/rc/selectByPrdtAmt.ajax")
	public ModelAndView selectByPrdtAmt(	@ModelAttribute("RC_AMTINFVO") RC_AMTINFVO amtInfVO,
											ModelMap model) throws Exception{
    	RC_AMTINFVO amtInf = masRcPrdtService.selectByPrdtAmt(amtInfVO);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("amtInf", amtInf);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

    /**
     * 렌터카 요금 수정
     * 파일명 : updatePrdtdAmt
     * 작성일 : 2015. 10. 13. 오후 1:23:21
     * 작성자 : 최영철
     * @param amtInfVO
     * @param bindingResult
     * @param prdtInfSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/updatePrdtAmt.do")
    public String updatePrdtdAmt(	@ModelAttribute("RC_AMTINFVO") RC_AMTINFVO amtInfVO,
    								BindingResult bindingResult,
    								@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
									ModelMap model){
    	// validation 체크
    	beanValidator.validate(amtInfVO, bindingResult);

    	if (bindingResult.hasErrors()){
			log.info("error");
			List<RC_AMTINFVO> resultList = (List<RC_AMTINFVO>) masRcPrdtService.selectRcPrdtAmtList(amtInfVO);
			log.info(bindingResult.toString());
			model.addAttribute("resultList", resultList);
    		model.addAttribute("amtInfVO", amtInfVO);
    		model.addAttribute("error", "Y");
			return "/mas/rc/rcAmtList";
		}

    	masRcPrdtService.updatePrdtAmt(amtInfVO);

    	return "redirect:/mas/rc/amtList.do?prdtNum=" + amtInfVO.getPrdtNum();
    }

    /**
     * 렌터카 요금 삭제
     * 파일명 : deletePrdtAmt
     * 작성일 : 2015. 10. 13. 오후 1:23:51
     * 작성자 : 최영철
     * @param amtInfVO
     * @param prdtInfSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/deletePrdtAmt.do")
    public String deletePrdtAmt(	@ModelAttribute("RC_AMTINFVO") RC_AMTINFVO amtInfVO,
    								@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
									ModelMap model){
    	masRcPrdtService.deletePrdtAmt(amtInfVO);

    	return "redirect:/mas/rc/amtList.do?prdtNum=" + amtInfVO.getPrdtNum();
    }

    /**
     * 렌터카 할인율 조회
     * 파일명 : disPerList
     * 작성일 : 2015. 10. 13. 오후 6:07:46
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param disPerInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/disPerList.do")
    public String disPerList(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    							@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO,
								ModelMap model){
    	RC_PRDTINFVO prdtInfVO = new RC_PRDTINFVO();
    	prdtInfVO.setPrdtNum(disPerInfVO.getPrdtNum());
    	// 업체에 해당하는 상품 체크
    	if (masRcPrdtService.checkCorpPrdt(prdtInfVO) == 0) {
    		model.addAttribute("errorCode", "1");
    	} else {
	    	prdtInfVO = masRcPrdtService.selectByPrdt(prdtInfVO);
	    	model.addAttribute("prdtInf", prdtInfVO);

	    	model.addAttribute("disPerInfVO", disPerInfVO);

	    	Map<String, Object> resultMap = masRcPrdtService.selectDisPerList(disPerInfVO);
	    	model.addAttribute("defDisPerVO", resultMap.get("defDisPerVO"));
	    	model.addAttribute("disPerInfList", resultMap.get("disPerInfList"));
    	}
    	return "/mas/rc/rcDisPerList";
    }

    /**
     * 렌터카 기본 할인율 등록
     * 파일명 : insertDefDisPer
     * 작성일 : 2015. 10. 13. 오후 6:07:57
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param disPerInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/insertDefDisPer.do")
    public String insertDefDisPer(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
									@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO,
									ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	disPerInfVO.setFrstRegId(corpInfo.getUserId());
    	masRcPrdtService.insertDefDisPer(disPerInfVO);
    	return "redirect:/mas/rc/disPerList.do?prdtNum=" + disPerInfVO.getPrdtNum();
    }

    /**
     * 기본 할인율 일괄 등록
     * 파일명 : insertDefDisPerAjax
     * 작성일 : 2016. 8. 4. 오후 1:30:16
     * 작성자 : 최영철
     * @param disPerInfVO
     * @return
     */
    @RequestMapping("/mas/rc/insertDefDisPer.ajax")
    public ModelAndView insertDefDisPerAjax(@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	disPerInfVO.setFrstRegId(corpInfo.getUserId());

    	if(EgovStringUtil.isEmpty(disPerInfVO.getPrdtNum())){
			resultMap.put("error", "Y");
    		resultMap.put("errorMsg", "선택된 상품이 없습니다.");

    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
		}

    	masRcPrdtService.insertDefDisPer2(disPerInfVO);

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }

    /**
     * 렌터카 기본 할인율 수정
     * 파일명 : updateDefDisPer
     * 작성일 : 2015. 10. 13. 오후 8:21:56
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param disPerInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/updateDefDisPer.do")
    public String updateDefDisPer(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
									@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO,
									ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	disPerInfVO.setLastModId(corpInfo.getUserId());
    	masRcPrdtService.updateDefDisPer(disPerInfVO);
    	return "redirect:/mas/rc/disPerList.do?prdtNum=" + disPerInfVO.getPrdtNum();
    }

    /**
     * 렌터카 기본 할인율 수정 AJAX
     * 파일명 : updateDefDisPerAjax
     * 작성일 : 2016. 8. 2. 오후 4:35:09
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param disPerInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/updateDefDisPer.ajax")
    public ModelAndView updateDefDisPerAjax(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO,
    		ModelMap model){
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	disPerInfVO.setLastModId(corpInfo.getUserId());
    	masRcPrdtService.updateDefDisPer(disPerInfVO);

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }

    /**
     * 렌터카 기간할인율 등록
     * 파일명 : insertRangeDisPer
     * 작성일 : 2015. 10. 14. 오후 7:35:41
     * 작성자 : 최영철
     * @param disPerInfVO
     * @param bindingResult
     * @param prdtInfSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/insertRangeDisPer.do")
    public String insertRangeDisPer(	@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO,
										BindingResult bindingResult,
										@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
										ModelMap model){
    	// validation 체크
    	beanValidator.validate(disPerInfVO, bindingResult);

    	if (bindingResult.hasErrors()){
			log.info("error");
			model.addAttribute("disPerInfVO", disPerInfVO);

	    	Map<String, Object> resultMap = masRcPrdtService.selectDisPerList(disPerInfVO);
	    	model.addAttribute("defDisPerVO", resultMap.get("defDisPerVO"));
	    	model.addAttribute("disPerInfList", resultMap.get("disPerInfList"));
    		model.addAttribute("error", "Y");
			return "/mas/rc/rcDisPerList";
		}

    	Integer chkInt = masRcPrdtService.checkRangeAplDt(disPerInfVO);

    	if(chkInt > 0){
    		bindingResult.rejectValue("viewAplStartDt", "errors.range2", new Object[]{"요금기간"}, "errors.common.notExist");
    		model.addAttribute("disPerInfVO", disPerInfVO);

	    	Map<String, Object> resultMap = masRcPrdtService.selectDisPerList(disPerInfVO);
	    	model.addAttribute("defDisPerVO", resultMap.get("defDisPerVO"));
	    	model.addAttribute("disPerInfList", resultMap.get("disPerInfList"));
    		model.addAttribute("error", "Y");
			return "/mas/rc/rcDisPerList";
    	}
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	disPerInfVO.setFrstRegId(corpInfo.getUserId());

    	masRcPrdtService.insertRangeDisPer(disPerInfVO);
    	return "redirect:/mas/rc/disPerList.do?prdtNum=" + disPerInfVO.getPrdtNum();
    }

    /**
     * 선택된 상품의 할인율 변경
     * 파일명 : updateChkDisPer
     * 작성일 : 2016. 8. 3. 오후 2:51:19
     * 작성자 : 최영철
     * @param disPerInfVO
     * @return
     */
    @RequestMapping("/mas/rc/updateChkDisPer.ajax")
    public ModelAndView updateChkDisPer(@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	disPerInfVO.setLastModId(corpInfo.getUserId());

    	if(EgovStringUtil.isEmpty(disPerInfVO.getPrdtNum())){
			resultMap.put("error", "Y");
    		resultMap.put("errorMsg", "선택된 상품이 없습니다.");

    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
		}

    	masRcPrdtService.updateChkDisPer(disPerInfVO);

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
    }

	@RequestMapping("/mas/rc/deleteChkDisPer.ajax")
	public ModelAndView deleteChkDisPer(@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		disPerInfVO.setLastModId(corpInfo.getUserId());

		if(EgovStringUtil.isEmpty(disPerInfVO.getPrdtNum())){
			resultMap.put("error", "Y");
			resultMap.put("errorMsg", "선택된 상품이 없습니다.");

			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}

		masRcPrdtService.deleteChkDisPer(disPerInfVO);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

    /**
     * 기간할인율 일괄 등록 처리
     * 파일명 : insertRangeDisPerAjax
     * 작성일 : 2016. 8. 2. 오후 2:04:17
     * 작성자 : 최영철
     * @param disPerInfVO
     * @param bindingResult
     * @param prdtInfSVO
     * @return
     */
    @RequestMapping("/mas/rc/insertRangeDisPer.ajax")
    public ModelAndView insertRangeDisPerAjax(	@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO,
    		BindingResult bindingResult,
    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO){

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	// validation 체크
    	beanValidator.validate(disPerInfVO, bindingResult);

    	if (bindingResult.hasErrors()){
    		resultMap.put("error", "Y");
    		resultMap.put("errorMsg", "데이터가 올바르지 않습니다.");

    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}

    	String [] prdtNum;

    	if(!EgovStringUtil.isEmpty(disPerInfVO.getPrdtNum())){
			prdtNum = disPerInfVO.getPrdtNum().split(",");
		}else{
			resultMap.put("error", "Y");
    		resultMap.put("errorMsg", "선택된 상품이 없습니다.");

    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
		}

    	boolean chkb = true;
    	// 각 상품별로 기간 할인율 적용이 가능한지 체크 한다.
    	for(int i=0;i<prdtNum.length;i++){
    		RC_PRDTINFVO prdtInfVO = new RC_PRDTINFVO();
			prdtInfVO.setPrdtNum(prdtNum[i]);
			prdtInfVO = masRcPrdtService.selectByPrdt(prdtInfVO);

    		disPerInfVO.setPrdtNum(prdtNum[i]);
    		Integer chkInt = masRcPrdtService.checkRangeAplDt(disPerInfVO);

    		Map<String, Object> chkMap = masRcPrdtService.selectDisPerList(disPerInfVO);
    		RC_DISPERINFVO chkVO = (RC_DISPERINFVO) chkMap.get("defDisPerVO");

    		if(chkVO == null){
    			chkb = false;
    			resultMap.put("error", "Y");
    			resultMap.put("errorMsg", prdtInfVO.getPrdtNm() + "(" + disPerInfVO.getPrdtNum() + ") 해당 상품에 대해 기본 할인율을 먼저 등록해주세요.");

    			ModelAndView mav = new ModelAndView("jsonView", resultMap);
        		return mav;
    		}

    		if(chkInt > 0){
    			chkb = false;
    			resultMap.put("error", "Y");
    			resultMap.put("errorMsg", prdtInfVO.getPrdtNm() + "(" + disPerInfVO.getPrdtNum() + ") 해당 상품에 중복된 기간이 존재합니다.");

    			ModelAndView mav = new ModelAndView("jsonView", resultMap);
        		return mav;
    		}
    	}

    	if(chkb){
    		for(int i=0;i<prdtNum.length;i++){
    			disPerInfVO.setPrdtNum(prdtNum[i]);
    			USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	    	disPerInfVO.setFrstRegId(corpInfo.getUserId());
    			masRcPrdtService.insertRangeDisPer(disPerInfVO);
    		}
    	}
    	resultMap.put("error", "N");
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
    }

    /**
     * 기간할인율 단건 정보 조회
     * 파일명 : selectByDisPerInf
     * 작성일 : 2015. 10. 14. 오후 7:35:30
     * 작성자 : 최영철
     * @param disPerInfVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/rc/selectByDisPerInf.ajax")
    public ModelAndView selectByDisPerInf(	@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO,
											ModelMap model) throws Exception{
    	RC_DISPERINFVO resultVO = masRcPrdtService.selectByDisPerInf(disPerInfVO);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("disPerInfVO", resultVO);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}



    /**
     * 렌터카 기간할인율 수정
     * 파일명 : updateRangeDisPer
     * 작성일 : 2015. 10. 14. 오후 7:35:18
     * 작성자 : 최영철
     * @param disPerInfVO
     * @param bindingResult
     * @param prdtInfSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/updateRangeDisPer.do")
    public String updateRangeDisPer(	@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO,
										BindingResult bindingResult,
										@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
										ModelMap model){
    	// validation 체크
    	beanValidator.validate(disPerInfVO, bindingResult);

    	if (bindingResult.hasErrors()){
			log.info("error");
			model.addAttribute("disPerInfVO", disPerInfVO);

	    	Map<String, Object> resultMap = masRcPrdtService.selectDisPerList(disPerInfVO);
	    	model.addAttribute("defDisPerVO", resultMap.get("defDisPerVO"));
	    	model.addAttribute("disPerInfList", resultMap.get("disPerInfList"));
    		model.addAttribute("error", "Y");
			return "/mas/rc/rcDisPerList";
		}

    	Integer chkInt = masRcPrdtService.checkRangeAplDt(disPerInfVO);

    	if(chkInt > 0){
    		bindingResult.rejectValue("viewAplStartDt", "errors.range2", new Object[]{"할인율기간"}, "errors.common.notExist");
    		model.addAttribute("disPerInfVO", disPerInfVO);

	    	Map<String, Object> resultMap = masRcPrdtService.selectDisPerList(disPerInfVO);
	    	model.addAttribute("defDisPerVO", resultMap.get("defDisPerVO"));
	    	model.addAttribute("disPerInfList", resultMap.get("disPerInfList"));
    		model.addAttribute("error", "Y");
			return "/mas/rc/rcDisPerList";
    	}
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	disPerInfVO.setLastModId(corpInfo.getUserId());
    	masRcPrdtService.updateRangeDisPer(disPerInfVO);
    	return "redirect:/mas/rc/disPerList.do?prdtNum=" + disPerInfVO.getPrdtNum();
    }

    /**
     * 기본 할인율이 등록되지 않은 상품 조회
     * 파일명 : selectDefDisPerPrdt
     * 작성일 : 2016. 8. 3. 오후 2:50:37
     * 작성자 : 최영철
     * @return
     */
    @RequestMapping("/mas/rc/selectDefDisPerPrdt.ajax")
    public ModelAndView selectDefDisPerPrdt(){
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	RC_PRDTINFSVO searchVO = new RC_PRDTINFSVO();
    	searchVO.setsCorpId(corpInfo.getCorpId());
    	List<RC_DISPERINFVO> prdtList = masRcPrdtService.selectDefDisPerPrdt(searchVO);

    	resultMap.put("prdtList", prdtList);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }

    /**
     * 렌터카 기간할인율 삭제
     * 파일명 : deleteRangeDisPer
     * 작성일 : 2015. 10. 14. 오후 7:35:04
     * 작성자 : 최영철
     * @param disPerInfVO
     * @param prdtInfSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/deleteRangeDisPer.do")
    public String deleteRangeDisPer(	@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO,
										@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
										ModelMap model){
    	masRcPrdtService.deleteRangeDisPer(disPerInfVO);
    	return "redirect:/mas/rc/disPerList.do?prdtNum=" + disPerInfVO.getPrdtNum();
    }

    /**
     * 렌터카 기간할인율 삭제 AJAX
     * 파일명 : deleteRangeDisPerAjax
     * 작성일 : 2016. 8. 2. 오후 3:26:52
     * 작성자 : 최영철
     * @param disPerInfVO
     * @return
     */
    @RequestMapping("/mas/rc/deleteRangeDisPer.ajax")
    public ModelAndView deleteRangeDisPerAjax(	@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	masRcPrdtService.deleteRangeDisPer(disPerInfVO);

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }

    /**
     * 렌터카 상품 승인 요청
     * 파일명 : approvalPrdt
     * 작성일 : 2015. 10. 14. 오후 7:34:54
     * 작성자 : 최영철
     * @param prdtInfVO
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/rc/approvalPrdt.ajax")
    public ModelAndView approvalPrdt(@ModelAttribute("RC_PRDTINFVO") RC_PRDTINFVO prdtInfVO) throws Exception{
    	// TS02 : 승인요청
    	prdtInfVO.setTradeStatus(Constant.TRADE_STATUS_APPR_REQ);
    	masRcPrdtService.approvalPrdt(prdtInfVO);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }

    /**
     * 렌터카 상품 승인 취소 요청
     * 파일명 : cancelApproval
     * 작성일 : 2015. 10. 14. 오후 8:47:39
     * 작성자 : 최영철
     * @param prdtInfVO
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/rc/cancelApproval.ajax")
    public ModelAndView cancelApproval(@ModelAttribute("RC_PRDTINFVO") RC_PRDTINFVO prdtInfVO) throws Exception{
    	// TS01 : 등록중
    	prdtInfVO.setTradeStatus(Constant.TRADE_STATUS_REG);
    	masRcPrdtService.approvalCancelPrdt(prdtInfVO);
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;
    }

    /**
     * 렌터카 상품 삭제
     * 파일명 : deletePrdt
     * 작성일 : 2015. 10. 20. 오후 8:20:59
     * 작성자 : 최영철
     * @param prdtInfVO
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/rc/deletePrdt.do")
    public String deletePrdt(@ModelAttribute("RC_PRDTINFVO") RC_PRDTINFVO prdtInfVO) throws Exception{
    	Integer pageIndexStr = prdtInfVO.getPageIndex();
    	prdtInfVO = masRcPrdtService.selectByPrdt(prdtInfVO);
    	masRcPrdtService.deletePrdt(prdtInfVO);
    	return "redirect:/mas/rc/productList.do?pageIndex="+pageIndexStr;
    }

    /**
     * RealTime 관리
     * 파일명 : rcCntList
     * 작성일 : 2015. 10. 20. 오후 8:21:09
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param cntInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/realTimeList.do")
    public String rcCntList(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		@ModelAttribute("RC_CNTINFVO") RC_CNTINFVO cntInfVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	prdtInfSVO.setsCorpId(corpInfo.getCorpId());
    	// 차량연료코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
    	model.addAttribute("fuelCd", cdList);
    	// 차량구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);
    	// 변속기구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_TRANS_DIV);
    	model.addAttribute("transDivCd", cdList);
    	// 제조사구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
    	model.addAttribute("makerDivCd", cdList);
    	// 거래상태코드
    	cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCd", cdList);
    	
    	// 업체 기본정보 조회
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());    	
    	corpVO = ossCorpService.selectByCorp(corpVO);
    	model.addAttribute("corpVO", corpVO);

    	List<RC_PRDTINFVO> resultList = masRcPrdtService.selectPrdtList(prdtInfSVO);
    	model.addAttribute("prdtList", resultList);
    	model.addAttribute("cntInfVO", cntInfVO);
    	return "/mas/rc/realTimeList";
    }

    /**
     * 렌터카 상품에 대한 상품 수량 리스트 조회
     * 파일명 : selectCntList
     * 작성일 : 2015. 10. 20. 오후 8:20:44
     * 작성자 : 최영철
     * @param cntInfVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/rc/selectCntList.ajax")
	public ModelAndView selectCntList(	@ModelAttribute("RC_CNTINFVO") RC_CNTINFVO cntInfVO,
											ModelMap model) throws Exception{
    	List<RC_CNTINFVO> cntInfList = masRcPrdtService.selectCntList(cntInfVO);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cntInfList", cntInfList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	/**
	 * 설명 : 렌터카 상품 수량 등록
	 * 파일명 : insertPrdtCnt
	 * 작성일 : 2024-08-30 오후 2:28
	 * 작성자 : chaewan.jung
	 * @param : [cntInfVO, bindingResult, prdtInfSVO]
	 * @return : org.springframework.web.servlet.ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/mas/rc/insertPrdtCnt.ajax")
	public ModelAndView insertPrdtCnt(@ModelAttribute("RC_CNTINFVO") RC_CNTINFVO cntInfVO
		, BindingResult bindingResult){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("error", "N");

		// validation 체크
		beanValidator.validate(cntInfVO, bindingResult);
		if (bindingResult.hasErrors()){
			resultMap.put("error", "Y");
		} else {
			// 동일한 적용일자의 데이터가 있는지 체크
			RC_CNTINFVO chkVO = masRcPrdtService.selectByPrdtCnt(cntInfVO);
			if (chkVO != null) {
				resultMap.put("error", "dupl");
			} else {
				try {
					masRcPrdtService.insertPrdtCnt(cntInfVO);
				} catch (Exception e) {
					resultMap.put("error", e.getMessage());
				}
			}
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

    /**
     * 렌터카 상품 수량 수정
     * 파일명 : updatePrdtCnt
     * 작성일 : 2015. 10. 20. 오후 8:25:40
     * 작성자 : 최영철
     * @param cntInfVO
     * @param bindingResult
     * @param prdtInfSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/updatePrdtCnt.do")
    public String updatePrdtCnt(@ModelAttribute("RC_CNTINFVO") RC_CNTINFVO cntInfVO,
    		BindingResult bindingResult,
    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		ModelMap model){
    	// validation 체크
    	beanValidator.validate(cntInfVO, bindingResult);

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	prdtInfSVO.setsCorpId(corpInfo.getCorpId());

    	if (bindingResult.hasErrors()){
    		// 차량연료코드
    		List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
    		model.addAttribute("fuelCd", cdList);
    		// 차량구분코드
    		cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    		model.addAttribute("carDivCd", cdList);
    		// 변속기구분코드
        	cdList = ossCmmService.selectCode(Constant.RC_TRANS_DIV);
        	model.addAttribute("transDivCd", cdList);
        	// 제조사구분코드
        	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
        	model.addAttribute("makerDivCd", cdList);
    		// 거래상태코드
    		cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    		model.addAttribute("tsCd", cdList);

    		List<RC_PRDTINFVO> resultList = masRcPrdtService.selectPrdtList(prdtInfSVO);
    		model.addAttribute("prdtList", resultList);
    		model.addAttribute("cntInfVO", cntInfVO);
    		model.addAttribute("error", "Y");
    		return "/mas/rc/realTimeList";

    	}

    	masRcPrdtService.updatePrdtCnt(cntInfVO);

		return "redirect:/mas/rc/realTimeList.do?sPrdtNum=" + cntInfVO.getPrdtNum() + "&sCarDivCd=" + prdtInfSVO.getsCarDivCd() + "&sPrdtNm=" + prdtInfSVO.getsPrdtNm() + "&sTradeStatus=" + prdtInfSVO.getsTradeStatus() ;
    }


    @RequestMapping("/mas/rc/updatePrdtCntAll.do")
    public String updatePrdtCntAll(@ModelAttribute("RC_CNTINFVO") RC_CNTINFVO cntInfVO,
    		BindingResult bindingResult,
    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		HttpServletRequest request,
    		ModelMap model){
    	// validation 체크
    	beanValidator.validate(cntInfVO, bindingResult);

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	prdtInfSVO.setsCorpId(corpInfo.getCorpId());

    	//log.info("------"+request.getParameter("allPrdts"));
    	String strAllPardts = request.getParameter("allPrdts");
    	String[] allParts =  strAllPardts.split(",");

    	for (String strPrdt : allParts) {
    		//log.info("------Part:"+strPrdt);

    		cntInfVO.setPrdtNum(strPrdt);

    		// 동일한 적용일자의 데이터가 있는지 체크
        	RC_CNTINFVO chkVO = masRcPrdtService.selectByPrdtCnt(cntInfVO);

        	if(chkVO == null){
        		//log.info("------Part ins:"+strPrdt);
        		//없으면 insert
        		masRcPrdtService.insertPrdtCnt(cntInfVO);
        	}else{
        		//log.info("------Part udt:"+strPrdt);
        		//있으면 update
        		masRcPrdtService.updatePrdtCnt(cntInfVO);
        	}

		}

		return "redirect:/mas/rc/realTimeList.do?sPrdtNum=" + cntInfVO.getPrdtNum() + "&sCarDivCd=" + prdtInfSVO.getsCarDivCd() + "&sPrdtNm=" + prdtInfSVO.getsPrdtNm() + "&sTradeStatus=" + prdtInfSVO.getsTradeStatus() ;
    }



    @RequestMapping("/mas/rc/deletePrdtCnt.do")
    public String deletePrdtCnt(@ModelAttribute("RC_CNTINFVO") RC_CNTINFVO cntInfVO,
    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		ModelMap model){
    	masRcPrdtService.deletePrdtCnt(cntInfVO);

		return "redirect:/mas/rc/realTimeList.do?sPrdtNum=" + cntInfVO.getPrdtNum() + "&sCarDivCd=" + prdtInfSVO.getsCarDivCd() + "&sPrdtNm=" + prdtInfSVO.getsPrdtNm() + "&sTradeStatus=" + prdtInfSVO.getsTradeStatus() ;
    }


    /**
     * 상품평 리스트
     * 파일명 : useepilList
     * 작성일 : 2015. 10. 23. 오전 9:43:17
     * 작성자 : 신우섭
     * @param ad_PRDINFSVO
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/useepilList.do")
    public String useepilList(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	return "/mas/ad/useepilList";
    }


    /**
     * 상품평 상세
     * 파일명 : detailUseepil
     * 작성일 : 2015. 10. 23. 오전 9:43:21
     * 작성자 : 신우섭
     * @param ad_PRDINFSVO
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/detailUseepil.do")
    public String detailUseepil(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	return "/mas/rc/detailUseepil";
    }


    /**
     * 1:1문의 목록
     * 파일명 : otoinqlList
     * 작성일 : 2015. 10. 28. 오전 11:51:57
     * 작성자 : 신우섭
     * @param ad_PRDINFSVO
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/otoinqList.do")
    public String otoinqlList(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	//log.info("/mas/ad/otoinqList.do 호출");

    	return "/mas/rc/otoinqList";
    }

    /**
     * 1:1문의 상세
     * 파일명 : detailOtoinq
     * 작성일 : 2015. 10. 28. 오전 11:52:01
     * 작성자 : 신우섭
     * @param ad_PRDINFSVO
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/detailOtoinq.do")
    public String detailOtoinq(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	//log.info("/mas/ad/detailUOtoinq.do 호출");

    	return "/mas/rc/detailOtoinq";
    }


    @RequestMapping("/mas/rc/previewRcPrdt.do")
    public String previewRcPrdt(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
					    		@ModelAttribute("prdtVO") RC_PRDTINFVO prdtVO,
					    		ModelMap model) {
    	log.info("/mas/rc/previewRcPrdt.do 호출");
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
    	// 상품 이미지 검색
    	CM_IMGVO imgVO = new CM_IMGVO();
    	imgVO.setLinkNum(prdtVO.getPrdtNum());
    	List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);

    	model.addAttribute("imgList", imgList);

    	prdtVO = webRcProductService.selectByPrdt(prdtVO);

    	// 상품정보가 존재하지 않으면 오류페이지로 리턴
    	if(prdtVO == null){
    		return "redirect:/web/cmm/error.do?errCord=PRDT01";
    	}

    	prdtVO.setRntStdInf(EgovStringUtil.checkHtmlView(prdtVO.getRntStdInf()));
    	prdtVO.setCarTkovInf(EgovStringUtil.checkHtmlView(prdtVO.getCarTkovInf()));
    	prdtVO.setIsrCmGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrCmGuide()));
    	prdtVO.setIsrAmtGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrAmtGuide()));

    	prdtSVO.setSearchYn(Constant.FLAG_N);
    	
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

		// 유모차/카시트 목록
		WEB_SPSVO webSpSVO = new WEB_SPSVO();
		webSpSVO.setsCtgr(Constant.CATEGORY_BACS);
		webSpSVO.setsCtgrDiv(Constant.CATEGORY_ETC);
		webSpSVO.setsCtgrDepth("1");
		webSpSVO.setFirstIndex(0);
		webSpSVO.setLastIndex(4);
		Map<String, Object> bacsMap = webSpService.selectProductList(webSpSVO);
		@SuppressWarnings("unchecked")
		List<WEB_SPPRDTVO> bacsList = (List<WEB_SPPRDTVO>) bacsMap.get("resultList");
		model.addAttribute("bacsList", bacsList);		
		
		// 찜하기 정보 (2017-11-24, By JDongS)
    	int pocketCnt = 0;    	
    	Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();
    	
    	model.addAttribute("pocketMap", pocketMap);
    	model.addAttribute("pocketCnt", pocketCnt);

    	return "/web/rc/car-detail";
    }

    /**
     * 판매중지 처리
     * 파일명 : saleStopPrdt
     * 작성일 : 2016. 2. 4. 오전 11:45:17
     * 작성자 : 최영철
     * @param prdtInfVO
     * @param prdtInfSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/saleStopPrdt.do")
    public String saleStopPrdt(@ModelAttribute("RC_PRDTINFVO") RC_PRDTINFVO prdtInfVO,
								@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
								ModelMap model){

    	// 2016.04.25 업체에서 판매중지시 이력 남김
    	CM_CONFHISTVO cm_CONFHISTVO = new CM_CONFHISTVO();
    	cm_CONFHISTVO.setLinkNum(prdtInfVO.getPrdtNum());
    	cm_CONFHISTVO.setTradeStatus(Constant.TRADE_STATUS_STOP_REQ);

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

    	cm_CONFHISTVO.setRegId(corpInfo.getUserId());
		cm_CONFHISTVO.setRegIp(corpInfo.getLastLoginIp());

    	ossPrdtService.productAppr(cm_CONFHISTVO);

    	prdtInfVO.setTradeStatus(Constant.TRADE_STATUS_STOP_REQ);
    	prdtInfVO.setLastModId(corpInfo.getUserId());
    	masRcPrdtService.saleStopPrdt(prdtInfVO);
    	return "redirect:/mas/rc/detailPrdt.do?prdtNum=" + prdtInfVO.getPrdtNum();
    }

    /**
     * 재 판매 처리
     * 파일명 : saleStartPrdt
     * 작성일 : 2016. 2. 4. 오전 11:45:25
     * 작성자 : 최영철
     * @param prdtInfVO
     * @param prdtInfSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/saleStartPrdt.do")
    public String saleStartPrdt(@ModelAttribute("RC_PRDTINFVO") RC_PRDTINFVO prdtInfVO,
						    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
						    		ModelMap model){

    	// 2016.04.25 업체에서 판매시작시 이력 남김
    	CM_CONFHISTVO cm_CONFHISTVO = new CM_CONFHISTVO();
    	cm_CONFHISTVO.setLinkNum(prdtInfVO.getPrdtNum());
    	cm_CONFHISTVO.setTradeStatus(Constant.TRADE_STATUS_APPR);

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

    	cm_CONFHISTVO.setRegId(corpInfo.getUserId());
		cm_CONFHISTVO.setRegIp(corpInfo.getLastLoginIp());

    	ossPrdtService.productAppr(cm_CONFHISTVO);

    	prdtInfVO.setTradeStatus(Constant.TRADE_STATUS_APPR);
    	prdtInfVO.setLastModId(corpInfo.getUserId());
    	masRcPrdtService.saleStopPrdt(prdtInfVO);
    	return "redirect:/mas/rc/detailPrdt.do?prdtNum=" + prdtInfVO.getPrdtNum();
    }
    
    /* 목록에서 히든처리 */
    @RequestMapping("/mas/rc/salePrintN.do")
    public String salePrintN(@ModelAttribute("RC_PRDTINFVO") RC_PRDTINFVO prdtInfVO,
    		@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		ModelMap model){
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	prdtInfVO.setLastModId(corpInfo.getUserId());
    	masRcPrdtService.salePrintN(prdtInfVO);
    	
    	return "redirect:/mas/rc/productList.do";
    }

    /**
     * 할인율 일괄관리
     * 파일명 : disPerPackList
     * 작성일 : 2016. 8. 3. 오전 11:24:46
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param disPerInfVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/disPerPackList.do")
    public String disPerPackList(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
    		@ModelAttribute("RC_DISPERINFVO") RC_DISPERINFVO disPerInfVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

    	prdtInfSVO.setsCorpId(corpInfo.getCorpId());
    	List<RC_DISPERINFVO> disPerInfList = masRcPrdtService.selectDisperPackList(prdtInfSVO);

    	List<RC_PRDTINFVO> prdtList = masRcPrdtService.selectPrdtList(prdtInfSVO);

		model.addAttribute("prdtList", prdtList);

		// 거래상태코드
		List<CDVO> cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
		model.addAttribute("tsCd", cdList);

		// 보험구분코드
		cdList = ossCmmService.selectCode(Constant.RC_ISR_DIV_CD);
		model.addAttribute("isrDivCd", cdList);


    	model.addAttribute("disPerInfList", disPerInfList);
    	return "/mas/rc/rcDisPerPackList";
    }

    @RequestMapping("/mas/rc/rsvChart.do")
    public String rsvChart(@ModelAttribute("searchVO") RC_RSVCHARTSVO searchVO,
    		ModelMap model){

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	searchVO.setsCorpId(corpInfo.getCorpId());

		// 업체 기본정보 조회
		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(corpInfo.getCorpId());
		corpVO = ossCorpService.selectByCorp(corpVO);
		model.addAttribute("corpVO", corpVO);

		if ("Y".equals(corpVO.getCorpLinkYn())){
			return "/mas/rc/rcRsvChart";
		}

    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	SimpleDateFormat sdfM = new SimpleDateFormat("MM");

    	if(searchVO.getsFromYear() == null || searchVO.getsFromMonth() == null){
    		searchVO.setsFromYear(sdf.format(now));
    		searchVO.setsFromMonth(sdfM.format(now));
    	}
    	if(searchVO.getsFromYear() != sdf.format(now)){
    		model.addAttribute("nowMonth", "12");
    	}else{
    		model.addAttribute("nowMonth", sdfM.format(now));
    	}

    	//월의 마지막 날짜 구하기
		int lastDay = 0;
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(searchVO.getsFromYear()), Integer.parseInt(searchVO.getsFromMonth())-1,1);
		lastDay = cal.getActualMaximum(Calendar.DATE);
		model.addAttribute("lastDay", lastDay);

		//일별 예약현황
		List<RC_RSVCHARTVO> chartListVO = new ArrayList<>();
		for (int i=1; i<=lastDay; i++ ) {
			searchVO.setsDay(searchVO.getsFromYear() + searchVO.getsFromMonth() + String.format("%02d", i));
			chartListVO.addAll(masRcPrdtService.selectRsvChart(searchVO));
		}

		//ViewSn 기준으로 정렬
		Collections.sort( chartListVO, (o1,o2) -> Integer.parseInt(o1.getViewSn()) - Integer.parseInt(o2.getViewSn()) );

    	// 거래상태코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCd", cdList);
    	
    	// 차량연료코드
    	cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
    	model.addAttribute("fuelCd", cdList);

    	model.addAttribute("chartListVO", chartListVO);
    	model.addAttribute("nowYear", sdf.format(now));

    	
    	return "/mas/rc/rcRsvChart";
    }

    @RequestMapping("/mas/rc/rsvChartDtl.ajax")
    public String rsvChartDtl(@ModelAttribute("searchVO") RSVSVO rsvSVO, ModelMap model){

    	List<RC_RSVVO> resultList =  masRcPrdtService.selectRsvChartDtl(rsvSVO);
    	model.addAttribute("resultList", resultList);

    	return "/mas/rc/chartRsv";
    }

    /**
     * 해당 상품에 대해 예약건이 존재하는지 확인
     * 파일명 : checkExsistPrdt
     * 작성일 : 2016. 11. 23. 오전 10:35:01
     * 작성자 : 최영철
     * @param rsvSVO
     * @return
     */
    @RequestMapping("/mas/rc/checkExsistPrdt.ajax")
    public ModelAndView checkExsistPrdt(@ModelAttribute("searchVO") RSVSVO rsvSVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	Integer chkInt = masRcPrdtService.checkExsistPrdt(rsvSVO);
    	resultMap.put("chkInt", chkInt);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;
    }

    @RequestMapping("/mas/rc/findCardiv.do")
    public String findCardiv(@ModelAttribute("searchVO") RC_CARDIVSVO rcCardivSVO,
							 ModelMap model) {

    	// 차량연료코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
    	model.addAttribute("fuelCd", cdList);

    	// 차량구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);

    	//// 변속기구분코드
    	//cdList = ossCmmService.selectCode(Constant.RC_TRANS_DIV);
    	//model.addAttribute("transDivCd", cdList);

    	// 제조사구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
		Collections.sort(cdList);
    	model.addAttribute("makerDivCd", cdList);

    	//// 차량코드
    	//cdList = ossCmmService.selectCode(Constant.RC_CAR_CD);
    	//model.addAttribute("carCd", cdList);

    	rcCardivSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	rcCardivSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(rcCardivSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(rcCardivSVO.getPageUnit());
		paginationInfo.setPageSize(rcCardivSVO.getPageSize());

		rcCardivSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		rcCardivSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		rcCardivSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		rcCardivSVO.setsUseYn("Y");

		Map<String, Object> resultMap = masRcPrdtService.selectCardivList(rcCardivSVO);

		@SuppressWarnings("unchecked")
		List<PRDTVO> resultList = (List<PRDTVO>) resultMap.get("resultList");
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

    	return "/mas/rc/findCardivPop";
    }


}
