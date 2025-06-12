package mas.sv.web;

import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.ad.vo.AD_PRDTINFSVO;
import mas.ad.vo.AD_PRDTINFVO;
import mas.sv.service.MasSvService;
import mas.sv.vo.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_DTLIMGVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.user.vo.USERVO;
import web.order.vo.RSVSVO;
import web.product.service.WebSvProductService;
import web.product.vo.WEB_SVPRDTVO;
import web.product.vo.WEB_SV_DTLPRDTVO;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class MasSvPrdtController {

	@Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;

	@Resource(name = "masSvService")
	private MasSvService masSvService;

	@Resource(name = "webSvService")
	private WebSvProductService webSvService;

	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@RequestMapping("/mas/sv/productList.do")
	public String socialProductList(
			@ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
			ModelMap model) {
		log.info("/mas/sv/productList.do call");

		sv_PRDTINFSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		sv_PRDTINFSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(sv_PRDTINFSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(sv_PRDTINFSVO.getPageUnit());
		paginationInfo.setPageSize(sv_PRDTINFSVO.getPageSize());

		sv_PRDTINFSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		sv_PRDTINFSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		sv_PRDTINFSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// CORP_ID set
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sv_PRDTINFSVO.setsCorpId(corpInfo.getCorpId());

		Map<String, Object> resultMap = masSvService.selectPrdtList(sv_PRDTINFSVO);

		@SuppressWarnings("unchecked")
		List<SV_PRDTINFVO> resultList = (List<SV_PRDTINFVO>) resultMap.get("resultList");
		log.info(resultMap.get("totalCnt"));
		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		List<CDVO> cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCd", cdList);

    	// 업체 배송금액
    	SV_CORPDLVAMTVO corpDlvAmtVO = masSvService.selectCorpDlvAmt(corpInfo.getCorpId());
    	model.addAttribute("corpDlvAmtVO", corpDlvAmtVO);
    	model.addAttribute("corpInfo", corpInfo);

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "mas/sv/prdtList";
	}

	/**
	 * 상품 정보 insert View
	 * @param sv_PRDTINFVO
	 * @param sv_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sv/viewInsertPrdt.do")
	public String viewInsertPrdt(
			@ModelAttribute("SV_PRDTINFVO") SV_PRDTINFVO sv_PRDTINFVO,
			@ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
			ModelMap model) {
		log.info("/mas/sv/viewInsertPrdt.do call");

		List<CDVO> resultList = ossCmmService.selectCode(Constant.SV_DIV);
		model.addAttribute("categoryList", resultList);

		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		model.addAttribute("filePath", EgovProperties.getProperty("HOST.WEBROOT") + EgovProperties.getProperty("PRODUCT.SV.SAVEDFILE"));
		return "mas/sv/insertPrdt";
	}

	/**
	 * 상품정보 insert
	 * @param sv_PRDTINFVO
	 * @param bindingResult
	 * @param sv_PRDTINFSVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mas/sv/insertProductInfo.do")
	public String insertSv(@ModelAttribute("SV_PRDTINFVO") SV_PRDTINFVO sv_PRDTINFVO,
						   BindingResult bindingResult,
						   @ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
						   @Param("fileList") String fileList,
						   ModelMap model) throws Exception {
		log.info("/mas/sv/insertProductInfo.do call");

		// validation 체크
		/*beanValidator.validate(sv_PRDTINFVO, bindingResult);
		log.info("fileList :: " + fileList);

		if (bindingResult.hasErrors()) {
			log.info("error");
			model.addAttribute("svPrdtInf", sv_PRDTINFVO);
			log.info(bindingResult.toString());
			List<CDVO> resultList = ossCmmService.selectCode(Constant.CATEGORY_CD);
			model.addAttribute("categoryList", resultList);

			return "mas/sv/insertPrdt";
		}*/
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sv_PRDTINFVO.setFrstRegId(corpInfo.getUserId());
		sv_PRDTINFVO.setFrstRegIp(corpInfo.getLastLoginIp());
		sv_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sv_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		// 업체 기본정보 등록 처리
		String prdtNum = masSvService.insertSvPrdtInf(sv_PRDTINFVO, fileList);
		model.addAttribute("prdtNum", prdtNum);

		return "redirect:/mas/sv/viewUpdateSv.do";
	}

	/**
	 * 기본상품 정보 수정화면
	 *
	 * @param sv_PRDTINFVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sv/viewUpdateSv.do")
	public String viewUpdateSocial(@ModelAttribute("SV_PRDTINFVO") SV_PRDTINFVO sv_PRDTINFVO,
								   @ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
								   ModelMap model) {
		log.info("/mas/sv/viewUpdateSv.do call");

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());

		SV_PRDTINFVO resultVO = masSvService.selectBySvPrdtInf(sv_PRDTINFVO);

		if(resultVO == null) {
			log.error("prdt num is wrong");
		}
		model.addAttribute("svPrdtInf", resultVO);

		List<CDVO> resultList = ossCmmService.selectCode(Constant.SV_DIV);
		model.addAttribute("categoryList", resultList);

		List<CDVO> resultSubList = ossCmmService.selectCode(resultVO.getCtgr());
		model.addAttribute("subCategoryList", resultSubList);

		String apprMsg = masSvService.prdtApprMsg(resultVO.getPrdtNum());

		if(StringUtils.isNotEmpty(apprMsg)) {
			apprMsg = EgovStringUtil.checkHtmlView(apprMsg);
		}

		model.addAttribute("btnApproval", masSvService.btnApproval(resultVO));
		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		model.addAttribute("apprMsg", apprMsg);

		return "/mas/sv/updatePrdt";
	}

	/**
	 * 기본상품 수정,
	 *
	 * @param sv_PRDTINFVO
	 * @param bindingResult
	 * @param sv_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sv/updateSvProductInfo.do")
	public String updateSvProductInfo(@ModelAttribute("SV_PRDTINFVO") SV_PRDTINFVO sv_PRDTINFVO,
									  BindingResult bindingResult,
									  @ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
									  ModelMap model) {
		log.info("/mas/insertSocialProductInfo.do call");

		// validation 체크
		/*beanValidator.validate(sv_PRDTINFVO, bindingResult);

		if (bindingResult.hasErrors()) {
			log.info("error");
			List<CDVO> resultList = ossCmmService.selectCode(Constant.CATEGORY_CD);
			model.addAttribute("categoryList", resultList);
			model.addAttribute("svPrdtInf", sv_PRDTINFVO);
			log.info(bindingResult.toString());
			return "mas/sv/updatePrdt";
		}*/

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sv_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sv_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		// 상품 수정 처리
		masSvService.updateSvPrdtInfData(sv_PRDTINFVO);

		return "redirect:/mas/sv/viewUpdateSv.do?prdtNum=" + sv_PRDTINFVO.getPrdtNum();
	}

	/**
	 * 협회 관리자에 승인요청하기
	 *
	 * @param sv_PRDTINFVO
	 * @return
	 */
	@RequestMapping("/mas/sv/approvalReq.ajax")
	public ModelAndView approvalReq(@ModelAttribute("SV_PRDTINFVO") SV_PRDTINFVO sv_PRDTINFVO) {
		log.info("/mas/sv/approvalReq.do call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sv_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sv_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		sv_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_APPR_REQ);
		masSvService.updateSvTradeStatus(sv_PRDTINFVO);
    	resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
    	return modelAndView;
	}

	/**
	 * 상품 승인취소하기
	 *
	 * @param sv_PRDTINFVO
	 * @return
	 */
	@RequestMapping("/mas/sv/approvalCancel.ajax")
	public ModelAndView approvalCancel(@ModelAttribute("SV_PRDTINFVO") SV_PRDTINFVO sv_PRDTINFVO) {
		log.info("/mas/sv/approvalReq.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sv_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sv_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		sv_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_REG);
		sv_PRDTINFVO.setConfRequestDttm("");
		masSvService.updateSvTradeStatus(sv_PRDTINFVO);

		resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}

	/**
	 * 상품 판매중지 하기
	 *
	 * @param sv_PRDTINFVO
	 * @param sv_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sv/saleStop.ajax")
	public ModelAndView saleStopSocial(@ModelAttribute("SV_PRDTINFVO") SV_PRDTINFVO sv_PRDTINFVO,
			@ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
			ModelMap model) {
		log.info("/mas/sv/saleStop.ajax call");

		Map<String, Object> resultMap = new HashMap<String,Object>();

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sv_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sv_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		sv_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_STOP_REQ);
		masSvService.updateSvPrdtInf(sv_PRDTINFVO);
		resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	/**
	 * 상품 판매전환 하기
	 *
	 * @param sv_PRDTINFVO
	 * @param sv_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sv/saleStart.ajax")
	public ModelAndView saleStartSocial(@ModelAttribute("SV_PRDTINFVO") SV_PRDTINFVO sv_PRDTINFVO,
			@ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
			ModelMap model) {
		log.info("/mas/sv/saleStart.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sv_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sv_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		sv_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_APPR);
		masSvService.updateSvPrdtInf(sv_PRDTINFVO);

		resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

    /* 목록에서 히든처리 */
    @RequestMapping("/mas/sv/salePrintN.do")
    public String salePrintN(@ModelAttribute("SV_PRDTINFVO") SV_PRDTINFVO sv_PRDTINFVO,
			@ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
			ModelMap model) {
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	sv_PRDTINFVO.setLastModId(corpInfo.getUserId());
    	sv_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());
    	masSvService.salePrintN(sv_PRDTINFVO);
    	
    	return "redirect:/mas/sv/productList.do";
    }
    
	/**
	 * 이미지 관리 리스트.
	 * @param sv_PRDTINFVO
	 * @param sv_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sv/imgList.do")
    public String imgList(@ModelAttribute("svPrdtInf") SV_PRDTINFVO sv_PRDTINFVO,
    		@ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
    		ModelMap model){

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());

		SV_PRDTINFVO svPrdtInfVO = masSvService.selectBySvPrdtInf(sv_PRDTINFVO);

		if(svPrdtInfVO == null) {
			log.error("prdtNum is wrong");
		}
		// 등록중, 승인요청, 수정요청 상태가 아니라면 detail 페이지로 이동.
		/*if(!(Constant.TRADE_STATUS_REG.equals(svPrdtInfVO.getTradeStatus()) || Constant.TRADE_STATUS_APPR_REQ.equals(svPrdtInfVO.getTradeStatus())
				|| Constant.TRADE_STATUS_EDIT.equals(svPrdtInfVO.getTradeStatus()))) {
			return "redirect:/mas/sv/detailImgList.do?prdtNum="+svPrdtInfVO.getPrdtNum();
		}*/

		model.addAttribute("btnApproval", masSvService.btnApproval(svPrdtInfVO));

		model.addAttribute("prdtVO", svPrdtInfVO);
    	return "/mas/sv/imgList";
    }

	@RequestMapping("/mas/sv/deletePrdt.do")
	public String deleteSocial(@ModelAttribute("SV_PRDTINFVO") SV_PRDTINFVO sv_PRDTINFVO) throws Exception {

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());

		SV_PRDTINFVO resultVO = masSvService.selectBySvPrdtInf(sv_PRDTINFVO);

		if(resultVO == null) {
			log.error("prdtNum is wrong");
		}
		// 옵션 삭제
		SV_OPTINFVO sv_OPTINFVO = new SV_OPTINFVO();
		sv_OPTINFVO.setPrdtNum(sv_PRDTINFVO.getPrdtNum());

		masSvService.deleteSvOptInf(sv_OPTINFVO);
		// 추가 옵션 삭제
		SV_ADDOPTINFVO sv_addoptinfVO = new SV_ADDOPTINFVO();
		sv_addoptinfVO.setPrdtNum(sv_PRDTINFVO.getPrdtNum());

		masSvService.deleteAddOptInf(sv_addoptinfVO);
		// 구분자 삭제
		SV_DIVINFVO sv_DIVINFVO = new SV_DIVINFVO();
		sv_DIVINFVO.setPrdtNum(sv_PRDTINFVO.getPrdtNum());

		masSvService.deleteSvDivInf(sv_DIVINFVO);
		// 이미지 삭제
		CM_IMGVO imgVO = new CM_IMGVO();
		imgVO.setLinkNum(sv_PRDTINFVO.getPrdtNum());

		ossCmmService.deletePrdtImgList(imgVO);
		// 상세 이미지 삭제
		CM_DTLIMGVO imgDtlVO = new CM_DTLIMGVO();
		imgDtlVO.setLinkNum(sv_PRDTINFVO.getPrdtNum());

		ossCmmService.deletePrdtDtlImgList(imgDtlVO);

		//상품 삭제
		masSvService.deleteSvPrdtInf(sv_PRDTINFVO);

		return "redirect:/mas/sv/productList.do";
	}

	/**
	 * 상품 상세 이미지
	 * @param sv_PRDTINFSVO
	 * @param sv_PRDTINFVO
	 * @param model
	 * @return
	 */
	 @RequestMapping("/mas/sv/dtlImgList.do")
	 public String dtlImgList(@ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
					    		@ModelAttribute("svPrdtInf") SV_PRDTINFVO sv_PRDTINFVO,
					    		ModelMap model){
		 USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		 sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		 SV_PRDTINFVO svPrdtInfVO = masSvService.selectBySvPrdtInf(sv_PRDTINFVO);

		 if(svPrdtInfVO == null) {
			 log.error("prdtNum is wrong");
		 }

		 // 등록중, 승인요청, 수정요청 상태가 아니라면 detail 페이지로 이동.
		 /*if(!(Constant.TRADE_STATUS_REG.equals(spPrdtInfVO.getTradeStatus()) || Constant.TRADE_STATUS_APPR_REQ.equals(spPrdtInfVO.getTradeStatus())
			|| Constant.TRADE_STATUS_EDIT.equals(spPrdtInfVO.getTradeStatus()))) {
			return "redirect:/mas/sv/detailDtlImgList.do?prdtNum="+spPrdtInfVO.getPrdtNum()+"&pageIndex="+sv_PRDTINFSVO.getPageIndex();
		}*/

		model.addAttribute("btnApproval", masSvService.btnApproval(svPrdtInfVO));
		model.addAttribute("prdtVO", svPrdtInfVO);
    	return "/mas/sv/dtlImgList";
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
	@RequestMapping("/mas/sv/useepilList.do")
	public String useepilList(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
		log.info("/mas/sv/useepilList.do 호출");
		return "/mas/sv/useepilList";
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
    @RequestMapping("/mas/sv/detailUseepil.do")
    public String detailUseepil(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	return "/mas/sv/detailUseepil";
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
    @RequestMapping("/mas/sv/otoinqList.do")
    public String otoinqlList(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	//log.info("/mas/ad/otoinqList.do 호출");

    	return "/mas/sv/otoinqList";
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
    @RequestMapping("/mas/sv/detailOtoinq.do")
    public String detailOtoinq(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	//log.info("/mas/ad/detailUOtoinq.do 호출");

    	return "/mas/sv/detailOtoinq";
    }


    /**
	 * 옵션 View
	 * @param sv_OPTINFVO
	 * @param sv_DIVINFVO
	 * @param sv_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sv/viewOption.do")
	public String viewOption(
			@ModelAttribute("SV_OPTINFVO") SV_OPTINFVO sv_OPTINFVO,
			@ModelAttribute("SV_DIVINFVO") SV_DIVINFVO sv_DIVINFVO,
			@ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
			ModelMap model) {
		log.info("/mas/sv/viewOption.do call");
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		SV_PRDTINFVO sv_PRDTINFVO = new SV_PRDTINFVO();
		sv_PRDTINFVO.setPrdtNum(sv_OPTINFVO.getPrdtNum());
		SV_PRDTINFVO svPrdtInfVO = masSvService.selectBySvPrdtInf(sv_PRDTINFVO);

		List<SV_OPTINFVO> resultList = masSvService.selectPrdtOptionList(sv_OPTINFVO);
		model.addAttribute("resultList", resultList);

		model.addAttribute("svPrdtInf", svPrdtInfVO);
		model.addAttribute("btnApproval", masSvService.btnApproval(svPrdtInfVO));

		List<SV_OPTINFVO> svDivList = masSvService.selectDivList(sv_OPTINFVO);
		model.addAttribute("svDivList",svDivList);

		// 업체 배송금액
    	SV_CORPDLVAMTVO corpDlvAmtVO = masSvService.selectCorpDlvAmt(corpInfo.getCorpId());
    	model.addAttribute("corpDlvAmtVO",corpDlvAmtVO);

		return "mas/sv/manageOption";
	}

		/**
		 * 구분자 정보 INSERT
		 * @param sv_DIVINFVO
		 * @param bindingResult
		 * @param model
		 * @return
		 */
		@RequestMapping("/mas/sv/insertDivInf.do")
		public String insertDivInf(
				@ModelAttribute("SV_DIVINFVO") SV_DIVINFVO sv_DIVINFVO,
				BindingResult bindingResult,
				ModelMap model) {
			log.info("/mas/sv/insertDivInf.do call");
			// validation 체크
			beanValidator.validate(sv_DIVINFVO, bindingResult);

			if (bindingResult.hasErrors()) {
				log.info("error");
				model.addAttribute("spDivInf", sv_DIVINFVO);
				log.info(bindingResult.toString());
				return "mas/sv/manageOption";
			}

			Integer maxViewSn = masSvService.selectDivInfMaxViewSn(sv_DIVINFVO);
			sv_DIVINFVO.setOldSn(String.valueOf(maxViewSn + 1));
			sv_DIVINFVO.setNewSn(sv_DIVINFVO.getViewSn());

			if(maxViewSn + 1 > Integer.parseInt(sv_DIVINFVO.getViewSn())){
				// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
				masSvService.addDivViewSn(sv_DIVINFVO);
			}
			masSvService.insertSvDivInf(sv_DIVINFVO);

			return "redirect:/mas/sv/viewOption.do?prdtNum="+sv_DIVINFVO.getPrdtNum();
		}

		/**
		 * 옵션 정보 INSERT
		 * @param sv_OPTINFVO
		 * @param bindingResult
		 * @param sv_PRDTINFSVO
		 * @param model
		 * @return
		 */
		@RequestMapping("/mas/sv/insertOption.do")
		public String insertOption(
				@ModelAttribute("SV_OPTINFVO") SV_OPTINFVO sv_OPTINFVO,
				BindingResult bindingResult,
				@ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
				ModelMap model) {
			log.info("/mas/sv/insertOption.do call");

			// validation 체크
			beanValidator.validate(sv_OPTINFVO, bindingResult);

			if (bindingResult.hasErrors()) {
				log.info("error");
				model.addAttribute("svOptInfo", sv_OPTINFVO);
				log.info(bindingResult.toString());
				return "mas/sv/manageOption";
			}

			Integer maxViewSn = masSvService.selectOptInfMaxViewSn(sv_OPTINFVO);
			sv_OPTINFVO.setOldSn(String.valueOf(maxViewSn + 1));
			sv_OPTINFVO.setNewSn(sv_OPTINFVO.getViewSn());

			if(maxViewSn + 1 > Integer.parseInt(sv_OPTINFVO.getViewSn())){
				// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
				masSvService.addOptViewSn(sv_OPTINFVO);
			}

			sv_OPTINFVO.setDdlYn(Constant.FLAG_N);
			// 업체 옵션정보 등록 처리
			masSvService.insertOptInf(sv_OPTINFVO);

			return "redirect:/mas/sv/viewOption.do?prdtNum="+sv_OPTINFVO.getPrdtNum();
		}

		@RequestMapping("/mas/sv/updateDivInf.do")
		public String updateDivInf(@ModelAttribute("SV_DIVINFVO") SV_DIVINFVO sv_DIVINFVO,
				BindingResult bindingResult,
				ModelMap model) {
			log.info("/mas/sv/updateDivInf.do call");

			// validation 체크
			beanValidator.validate(sv_DIVINFVO, bindingResult);

			if (bindingResult.hasErrors()) {
				log.info("error");
				model.addAttribute("svDivInf", sv_DIVINFVO);
				log.info(bindingResult.toString());
				return "mas/sv/manageOption";
			}
			SV_DIVINFVO oldVO = masSvService.selectSvDivInf(sv_DIVINFVO);

			oldVO.setOldSn(oldVO.getViewSn());
			oldVO.setNewSn(sv_DIVINFVO.getViewSn());

			// 노출 순서가 변경되었을 경우에만 실행
			if(!oldVO.getNewSn().equals(oldVO.getOldSn())){
				if(Integer.parseInt(oldVO.getViewSn()) > Integer.parseInt(sv_DIVINFVO.getViewSn())){
					// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
					masSvService.addDivViewSn(oldVO);
				}else{
					masSvService.minusDivViewSn(oldVO);
				}
			}
			masSvService.updateSvDivInf(sv_DIVINFVO);

			return "redirect:/mas/sv/viewOption.do?prdtNum="+sv_DIVINFVO.getPrdtNum();
		}

		/**
		 * 옵션 수정하기
		 * @param sv_OPTINFVO
		 * @param bindingResult
		 * @param model
		 * @return
		 */
		@RequestMapping("/mas/sv/updateOptInf.do")
		public String updateOptInf(@ModelAttribute("SV_OPTINFVO") SV_OPTINFVO sv_OPTINFVO,
				BindingResult bindingResult,
				ModelMap model) {
			log.info("/mas/sv/updateOptInf.do call");

			// validation 체크
			beanValidator.validate(sv_OPTINFVO, bindingResult);

			if (bindingResult.hasErrors()) {
				log.info("error");
				model.addAttribute("svOptInf", sv_OPTINFVO);
				log.info(bindingResult.toString());
				return "mas/sv/manageOption";
			}
			SV_OPTINFVO oldVO = masSvService.selectSvOptInf(sv_OPTINFVO);

			oldVO.setOldSn(oldVO.getViewSn());
			oldVO.setNewSn(sv_OPTINFVO.getViewSn());

			// 노출 순서가 변경되었을 경우에만 실행
			if(!oldVO.getNewSn().equals(oldVO.getOldSn())){
				if(Integer.parseInt(oldVO.getViewSn()) > Integer.parseInt(sv_OPTINFVO.getViewSn())){
					// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
					masSvService.addOptViewSn(oldVO);
				}else{
					masSvService.minusOptViewSn(oldVO);
				}
			}
			masSvService.updateSvOptInf(sv_OPTINFVO);

			return "redirect:/mas/sv/viewOption.do?prdtNum="+sv_OPTINFVO.getPrdtNum();
		}

		/**
		 * 구분자 삭제
		 * @param sv_DIVINFVO
		 * @param model
		 * @return
		 */
		@RequestMapping("/mas/sv/deleteDivInf.do")
		public String deleteDivInf(@ModelAttribute("SV_DIVINFVO") SV_DIVINFVO sv_DIVINFVO,
				ModelMap model ) {
			log.info("/mas/sv/deleteDivInf.do call");
			SV_OPTINFVO sv_OPTINFVO = new SV_OPTINFVO();
			sv_OPTINFVO.setPrdtNum(sv_DIVINFVO.getPrdtNum());
			sv_OPTINFVO.setSvDivSn(sv_DIVINFVO.getSvDivSn());
			List<SV_OPTINFVO> optionList = masSvService.selectPrdtOptionList(sv_OPTINFVO);

			sv_DIVINFVO = masSvService.selectSvDivInf(sv_DIVINFVO);
			// 우선 순위 수정.
			sv_DIVINFVO.setOldSn(sv_DIVINFVO.getViewSn());
			masSvService.minusDivViewSn(sv_DIVINFVO);

			if(optionList != null) {
				masSvService.deleteSvOptInf(sv_OPTINFVO);
			}
			masSvService.deleteSvDivInf(sv_DIVINFVO);

			return "redirect:/mas/sv/viewOption.do?prdtNum="+sv_DIVINFVO.getPrdtNum();
		}

		/**
		 * 옵션 삭제.
		 * @param sv_OPTINFVO
		 * @param model
		 * @return
		 */
		@RequestMapping("/mas/sv/deleteOptInf.do")
		public String deleteOptInf(@ModelAttribute("SV_OPTINFVO") SV_OPTINFVO sv_OPTINFVO,
				ModelMap model ) {
			log.info("/mas/sv/deleteOptInf.do call");

			sv_OPTINFVO = masSvService.selectSvOptInf(sv_OPTINFVO);

			// 우선 순위 수정.
			sv_OPTINFVO.setOldSn(sv_OPTINFVO.getViewSn());
			masSvService.minusOptViewSn(sv_OPTINFVO);

			masSvService.deleteSvOptInf(sv_OPTINFVO);

			return "redirect:/mas/sv/viewOption.do?prdtNum="+sv_OPTINFVO.getPrdtNum();
		}

		/**
		 * 구분자 수정시 정보가져오기
		 * @param sv_DIVINFVO
		 * @return
		 */
		@RequestMapping("/mas/sv/viewUpdateDivinf.ajax")
		public ModelAndView viewUpdateDivinf(@ModelAttribute("SV_DIVINFVO") SV_DIVINFVO sv_DIVINFVO) {
	    	SV_DIVINFVO  spDivInfVO = masSvService.selectSvDivInf(sv_DIVINFVO);

	    	Integer maxViewSn = masSvService.selectDivInfMaxViewSn(sv_DIVINFVO);

	    	Map<String, Object> resultMap = new HashMap<String,Object>();
	    	resultMap.put("spDivInfVO", spDivInfVO);
	    	resultMap.put("maxViewSn", maxViewSn);

	    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

	    	return modelAndView;
		}

		/**
		 * 옵션 수정시 정보가져오기
		 * @param sv_OPTINFVO
		 * @return
		 */
		@RequestMapping("/mas/sv/viewUpdateOptinf.ajax")
		public ModelAndView viewUpdateOptinf(@ModelAttribute("SV_OPTINFVO") SV_OPTINFVO sv_OPTINFVO) {
	    	log.info("/mas/sv/viewUpdateOptinf.ajax call" + "|" + sv_OPTINFVO.getPrdtNum());

	    	SV_OPTINFVO  spOptInfVO = masSvService.selectSvOptInf(sv_OPTINFVO);
	    	Integer maxViewSn = masSvService.selectOptInfMaxViewSn(sv_OPTINFVO);

	    	Map<String, Object> resultMap = new HashMap<String,Object>();
	    	resultMap.put("svOptInfVO", spOptInfVO);
	    	resultMap.put("maxViewSn", maxViewSn);

	    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

	    	return modelAndView;
		}

		/**
		 * 구분자 정렬순서 max 값 가져오기
		 * @param sv_DIVINFVO
		 * @return
		 */
		@RequestMapping("/mas/sv/getDivMaxViewSn.ajax")
		public ModelAndView getDivMaxViewSn(@ModelAttribute("SV_DIVINFVO") SV_DIVINFVO sv_DIVINFVO) {

	    	Integer maxViewSn = masSvService.selectDivInfMaxViewSn(sv_DIVINFVO);

	    	Map<String, Object> resultMap = new HashMap<String,Object>();
	    	resultMap.put("maxViewSn", maxViewSn);

	    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

	    	return modelAndView;
		}

		/**
		 * 정렬순서 max 값 가져오기
		 * @param sv_OPTINFVO
		 * @return
		 */
		@RequestMapping("/mas/sv/getOptMaxViewSn.ajax")
		public ModelAndView getOptMaxViewSn(@ModelAttribute("SV_OPTINFVO") SV_OPTINFVO sv_OPTINFVO) {
	    	Integer maxViewSn = masSvService.selectOptInfMaxViewSn(sv_OPTINFVO);

	    	Map<String, Object> resultMap = new HashMap<String,Object>();
	    	resultMap.put("maxViewSn", maxViewSn);

	    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

	    	return modelAndView;
		}


		@RequestMapping("/mas/sv/viewAddOption.do")
		public String viewAddOption(
				@ModelAttribute("SV_ADDOPTINFVO") SV_ADDOPTINFVO sv_ADDOPTINFVO,
				@ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
				ModelMap model) {
			log.info("/mas/sv/viewAddOption.do call");
			SV_PRDTINFVO sv_PRDTINFVO = new SV_PRDTINFVO();
			sv_PRDTINFVO.setPrdtNum(sv_ADDOPTINFVO.getPrdtNum());
			SV_PRDTINFVO svPrdtInfVO = masSvService.selectBySvPrdtInf(sv_PRDTINFVO);

			List<SV_ADDOPTINFVO> resultList = masSvService.selectPrdtAddOptionList(sv_ADDOPTINFVO);
			model.addAttribute("resultList", resultList);

			model.addAttribute("svPrdtInf", svPrdtInfVO);
			model.addAttribute("btnApproval", masSvService.btnApproval(svPrdtInfVO));

			return "mas/sv/manageAddOption";
		}

		/**
		 * 추가옵션 정렬순서 max 값.
		 * @param sv_ADDOPTINFVO
		 * @return
		 */
		@RequestMapping("/mas/sv/getAddOptMaxViewSn.ajax")
		public ModelAndView getAddOptMaxViewSn(@ModelAttribute("SV_ADDOPTINFVO") SV_ADDOPTINFVO sv_ADDOPTINFVO) {

	    	Integer maxViewSn = masSvService.selectAddOptInfMaxViewSn(sv_ADDOPTINFVO);

	    	Map<String, Object> resultMap = new HashMap<String,Object>();
	    	resultMap.put("maxViewSn", maxViewSn);

	    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

	    	return modelAndView;
		}

		/**
		 * 추가 옵션 등록
		 * @param sv_ADDOPTINFVO
		 * @param bindingResult
		 * @param sp_OPTINFSVO
		 * @param model
		 * @return
		 */
		@RequestMapping("/mas/sv/insertAddOption.do")
		public String insertAddOption(
				@ModelAttribute("SV_ADDOPTINFVO") SV_ADDOPTINFVO sv_ADDOPTINFVO,
				BindingResult bindingResult,
				@ModelAttribute("searchVO") SV_OPTINFSVO sp_OPTINFSVO,
				ModelMap model) {
			log.info("/mas/sv/insertAddOption.do call");

			// validation 체크
			beanValidator.validate(sv_ADDOPTINFVO, bindingResult);

			if (bindingResult.hasErrors()) {
				log.info("error");
				model.addAttribute("svOptInfo", sv_ADDOPTINFVO);
				log.info(bindingResult.toString());
				return "mas/sv/manageAddOption";
			}

			USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
			sv_ADDOPTINFVO.setFrstRegId(corpInfo.getUserId());
			sv_ADDOPTINFVO.setLastModId(corpInfo.getUserId());

			Integer maxViewSn = masSvService.selectAddOptInfMaxViewSn(sv_ADDOPTINFVO);
			sv_ADDOPTINFVO.setOldSn(String.valueOf(maxViewSn + 1));
			sv_ADDOPTINFVO.setNewSn(sv_ADDOPTINFVO.getViewSn());

			if(maxViewSn + 1 > Integer.parseInt(sv_ADDOPTINFVO.getViewSn())){
				// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
				masSvService.addAddOptViewSn(sv_ADDOPTINFVO);
			}

			// 업체 추가옵션정보 등록 처리
			masSvService.insertSvAddOptInf(sv_ADDOPTINFVO);

			return "redirect:/mas/sv/viewAddOption.do?prdtNum="+sv_ADDOPTINFVO.getPrdtNum();
		}

		/**
		 * 추가옵션 수정화면
		 * @param sv_ADDOPTINFVO
		 * @return
		 */
		@RequestMapping("/mas/sv/viewUpdateAddOpt.ajax")
		public ModelAndView viewUpdateAddOpt(@ModelAttribute("SV_ADDOPTINFVO") SV_ADDOPTINFVO sv_ADDOPTINFVO) {
	    	log.info("/mas/sv/viewUpdateAddOpt.ajax call");
	    	log.info(sv_ADDOPTINFVO.getPrdtNum());

	    	SV_ADDOPTINFVO  svOptInfVO = masSvService.selectSvAddOptInf(sv_ADDOPTINFVO);

	    	Integer maxViewSn = masSvService.selectAddOptInfMaxViewSn(sv_ADDOPTINFVO);

	    	Map<String, Object> resultMap = new HashMap<String,Object>();
	    	resultMap.put("svOptInfVO", svOptInfVO);
	    	resultMap.put("maxViewSn", maxViewSn);

	    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

	    	return modelAndView;
		}

		/**
		 * 추가옵션 수정
		 * @param sv_ADDOPTINFVO
		 * @param bindingResult
		 * @param model
		 * @return
		 */
		@RequestMapping("/mas/sv/updateAddOption.do")
		public String updateAddOption(@ModelAttribute("SV_ADDOPTINFVO") SV_ADDOPTINFVO sv_ADDOPTINFVO,
				BindingResult bindingResult,
				ModelMap model) {
			log.info("/mas/sv/updateAddOption.do call");

			// validation 체크
			beanValidator.validate(sv_ADDOPTINFVO, bindingResult);

			USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
			sv_ADDOPTINFVO.setLastModId(corpInfo.getUserId());

			if (bindingResult.hasErrors()) {
				log.info("error");
				model.addAttribute("svOptInf", sv_ADDOPTINFVO);
				log.info(bindingResult.toString());
				return "mas/sv/manageAddOption";
			}
			SV_ADDOPTINFVO oldVO = masSvService.selectSvAddOptInf(sv_ADDOPTINFVO);

			oldVO.setOldSn(oldVO.getViewSn());
			oldVO.setNewSn(sv_ADDOPTINFVO.getViewSn());
			oldVO.setLastModId(corpInfo.getUserId());
			// 노출 순서가 변경되었을 경우에만 실행
			if(!oldVO.getNewSn().equals(oldVO.getOldSn())){
				if(Integer.parseInt(oldVO.getViewSn()) > Integer.parseInt(sv_ADDOPTINFVO.getViewSn())){
					// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
					masSvService.addAddOptViewSn(oldVO);
				}else{
					masSvService.minusAddOptViewSn(oldVO);
				}
			}
			masSvService.updateSvAddOptInf(sv_ADDOPTINFVO);

			return "redirect:/mas/sv/viewAddOption.do?prdtNum="+sv_ADDOPTINFVO.getPrdtNum();
		}

		/**
		 * 추가 옵션 삭제.
		 * @param sv_ADDOPTINFVO
		 * @param model
		 * @return
		 */
		@RequestMapping("/mas/sv/deleteAddOpt.do")
		public String deleteAddOpt(@ModelAttribute("SV_ADDOPTINFVO") SV_ADDOPTINFVO sv_ADDOPTINFVO,
				ModelMap model ) {
			log.info("/mas/sv/deleteAddOpt.do call");

			sv_ADDOPTINFVO = masSvService.selectSvAddOptInf(sv_ADDOPTINFVO);

			USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
			sv_ADDOPTINFVO.setLastModId(corpInfo.getUserId());

			// 우선 순위 수정.
			sv_ADDOPTINFVO.setOldSn(sv_ADDOPTINFVO.getViewSn());
			masSvService.minusAddOptViewSn(sv_ADDOPTINFVO);

			masSvService.deleteAddOptInf(sv_ADDOPTINFVO);

			return "redirect:/mas/sv/viewAddOption.do?prdtNum="+sv_ADDOPTINFVO.getPrdtNum();
		}

		/**
		 * 기념품 상품 재고관리
		 * @param sv_PRDTINFVO
		 * @param model
		 * @return
		 */
		@RequestMapping("/mas/sv/stockList.do")
		public String stockList(@ModelAttribute("searchVO") SV_PRDTINFVO sv_PRDTINFVO, ModelMap model) {
			log.info("/mas/sv/stockList.do call");

			USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
			sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());

			List<SV_PRDTINFVO> sPrdtList = masSvService.selectSvPrdtSaleList(sv_PRDTINFVO);

			if(sPrdtList.size() > 0) {
				if(StringUtils.isEmpty(sv_PRDTINFVO.getsPrdtNum()))
					sv_PRDTINFVO.setPrdtNum(sPrdtList.get(0).getPrdtNum());
				else
					sv_PRDTINFVO.setPrdtNum(sv_PRDTINFVO.getsPrdtNum());

				List<SV_OPTINFVO> stockList = masSvService.selectStockList(sv_PRDTINFVO);
				model.addAttribute("stockList", stockList);
			}
			model.addAttribute("sPrdtList", sPrdtList);

			return "mas/sv/stockList";
		}

		/**
		 * 재고 수량 관리 ajax
		 * @param sv_OPTINFVO
		 * @return
		 */
		@RequestMapping("/mas/sv/updateOptStock.ajax")
		public ModelAndView updateOptStock(@ModelAttribute("SV_OPTINFVO") SV_OPTINFVO sv_OPTINFVO){
			Map<String, Object> resultMap = new HashMap<String,Object>();
			log.info(" stockNum :: " + sv_OPTINFVO.getOptPrdtNum());

			SV_OPTINFVO resultVO = masSvService.selectSvOptInf(sv_OPTINFVO);
			sv_OPTINFVO.setOptPrdtNum(resultVO.getOptPrdtNum() + sv_OPTINFVO.getOptPrdtNum());

			masSvService.updateSvOptInf(sv_OPTINFVO);

			resultMap.put("resultCode", Constant.JSON_SUCCESS);
			ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

			return modelAndView;
		}

		@RequestMapping("/mas/sv/updateOptSoldOut.ajax")
		public ModelAndView updateOptSoldOut(@ModelAttribute("SV_OPTINFVO") SV_OPTINFVO sv_OPTINFVO){
			Map<String, Object> resultMap = new HashMap<String,Object>();

			sv_OPTINFVO.setDdlYn(Constant.FLAG_Y);
			masSvService.updateDdlYn(sv_OPTINFVO);

			resultMap.put("resultCode", Constant.JSON_SUCCESS);
			ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

			return modelAndView;
		}

		@RequestMapping("/mas/sv/updateOptSale.ajax")
		public ModelAndView updateOptSale(@ModelAttribute("SV_OPTINFVO") SV_OPTINFVO sv_OPTINFVO){
			Map<String, Object> resultMap = new HashMap<String,Object>();
			sv_OPTINFVO = masSvService.selectSvOptInf(sv_OPTINFVO);

			sv_OPTINFVO.setDdlYn(Constant.FLAG_N);
			masSvService.updateDdlYn(sv_OPTINFVO);

			resultMap.put("resultCode", Constant.JSON_SUCCESS);
			ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

			return modelAndView;
		}

		@RequestMapping("/mas/sv/copyProduct.do")
		public String copyProduct(@ModelAttribute("SV_PRDTINFVO") SV_PRDTINFVO sv_PRDTINFVO,
				ModelMap model) throws Exception {

	    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
	    	sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());
	    	sv_PRDTINFVO.setFrstRegId(corpInfo.getUserId());
	    	sv_PRDTINFVO.setFrstRegIp(corpInfo.getLastLoginIp());

	    	String newPrdtNum = masSvService.copyProduct(sv_PRDTINFVO);

	    	return "redirect:/mas/sv/viewUpdateSv.do?prdtNum="+newPrdtNum;
		}

		@RequestMapping("/mas/preview/svDetailProduct.do")
	    public String detailProduct(@ModelAttribute("prdtVO") WEB_SV_DTLPRDTVO prdtVO,
	    		ModelMap model) throws ParseException {
	    	String prdtNum = prdtVO.getPrdtNum();

	    	if(prdtNum == null) {
	    		log.error("prdtNum is null");
	    		return "redirect:/web/cmm/error.do?errCord=PRDT01";
	    	}

	    	// 상품 정보 가져오기.
	    	prdtVO.setPreviewYn(Constant.FLAG_Y);
	    	WEB_SV_DTLPRDTVO prdtInfo =  webSvService.selectByPrdt(prdtVO);

	    	if(prdtInfo == null ) {
	    		log.error("prdt is null");
	    		return "redirect:/web/cmm/error.do?errCord=PRDT02";
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

			// 판매처 다른 상품보기
			String corpId = prdtInfo.getCorpId();
			String prdc = prdtInfo.getPrdc();
			List<WEB_SVPRDTVO> otherProductList= webSvService.selectOtherProductList(corpId, prdc);

	    	// 상품 판매종료일 전 남은 시간 가져오기.(현재시간으로)
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
			Date fromDate = Calendar.getInstance().getTime();
			Date toDate = sdf.parse(prdtInfo.getSaleEndDt()+"2359");

			long difDay = OssCmmUtil.getDifDay(fromDate, toDate);
			long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) - (difDay*24 * 3600);

			// 상품 추가 옵션 가져오기.
			SV_ADDOPTINFVO sv_ADDOPTINFVO = new SV_ADDOPTINFVO();
			sv_ADDOPTINFVO.setPrdtNum(prdtNum);
			List<SV_ADDOPTINFVO> addOptList = masSvService.selectPrdtAddOptionList(sv_ADDOPTINFVO);

			// 배송 정보 가져오기.
			SV_CORPDLVAMTVO corpDlvAmtVO = masSvService.selectCorpDlvAmt(prdtInfo.getCorpId());

			// 업체정보 가져 오기.
			CORPVO corpVO = new CORPVO();
			corpVO.setCorpId(prdtInfo.getCorpId());
			CORPVO corpInfo = ossCorpService.selectCorpByCorpId(corpVO);

			if(StringUtils.isNotEmpty(prdtInfo.getHdlPrct())) {
				prdtInfo.setHdlPrct(EgovStringUtil.checkHtmlView(prdtInfo.getHdlPrct()));
			}
			if(StringUtils.isNotEmpty(prdtInfo.getDlvGuide())) {
				prdtInfo.setDlvGuide(EgovStringUtil.checkHtmlView(prdtInfo.getDlvGuide()));
			}

			if(StringUtils.isNotEmpty(prdtInfo.getCancelGuide())) {
				prdtInfo.setCancelGuide(EgovStringUtil.checkHtmlView(prdtInfo.getCancelGuide()));
			}
			if(StringUtils.isNotEmpty(prdtInfo.getTkbkGuide())) {
				prdtInfo.setTkbkGuide(EgovStringUtil.checkHtmlView(prdtInfo.getTkbkGuide()));
			}

			model.addAttribute("difTime", difTime);
			model.addAttribute("difDay", difDay);
			model.addAttribute("prdtInfo", prdtInfo);
			model.addAttribute("prdtImg", prdtImg);
			model.addAttribute("dtlImg", dtlImg);
			model.addAttribute("otherProductList", otherProductList);
			model.addAttribute("preview", Constant.FLAG_Y);
			model.addAttribute("addOptList", addOptList);
			model.addAttribute("corpDlvAmtVO", corpDlvAmtVO);
			model.addAttribute("corpInfo", corpInfo);

	    	return "web/sv/detailProduct";
	    }

		@RequestMapping("/mas/sv/saveCorpDlvAmt.ajax")
		public ModelAndView updateOptSale(@ModelAttribute("SV_CORPDLVAMT") SV_CORPDLVAMTVO sv_CORPDLVAMTVO){
			Map<String, Object> resultMap = new HashMap<String,Object>();

			masSvService.saveCorpDlvAmt(sv_CORPDLVAMTVO);

			resultMap.put("resultCode", Constant.JSON_SUCCESS);
			ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

			return modelAndView;
		}

		/**
		 * 해당 상품에 예약건이 존재하는지 확인
		 * 파일명 : checkExsistPrdt
		 * 작성일 : 2016. 11. 23. 오후 4:29:36
		 * 작성자 : 최영철
		 * @param rsvSVO
		 * @return
		 */
		@RequestMapping("/mas/sv/checkExsistPrdt.ajax")
		public ModelAndView checkExsistPrdt(@ModelAttribute("searchVO") RSVSVO rsvSVO){
	    	Map<String, Object> resultMap = new HashMap<String, Object>();

	    	Integer chkInt = masSvService.checkExsistPrdt(rsvSVO);
	    	resultMap.put("chkInt", chkInt);
	    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

	    	return mav;

		}


		@RequestMapping("/mas/sv/detailSvDftinf.do")
		public String detailSvDftinf(
				@ModelAttribute("SV_DFTINFVO") SV_DFTINFVO sv_DFTINFVO,
				//@ModelAttribute("searchVO") SV_PRDTINFSVO sv_PRDTINFSVO,
				ModelMap model) {
			log.info("/mas/sv/viewUpdateSv.do call");


			USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
			sv_DFTINFVO.setCorpId(corpInfo.getCorpId());

			SV_DFTINFVO resultVO = masSvService.selectBySvDftinf(sv_DFTINFVO);
			model.addAttribute("svDftinfo", resultVO);


			return "/mas/sv/detailSvDftinf";
		}


		@RequestMapping("/mas/sv/updateSvDftinf.do")
		public String updateSvDftinf(
				@ModelAttribute("SV_DFTINFVO") SV_DFTINFVO sv_DFTINFVO,
				BindingResult bindingResult,
				ModelMap model) throws Exception {
			log.info("/mas/updateSvDftinf.do call");

			USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
			sv_DFTINFVO.setCorpId(corpInfo.getCorpId());

			SV_DFTINFVO resultVO = masSvService.selectBySvDftinf(sv_DFTINFVO);
			if(resultVO == null){
				masSvService.insertSvDftinf(sv_DFTINFVO);
			}else{
				masSvService.updateSvDftinf(sv_DFTINFVO);
			}

			masSvService.updateSvDftinf(sv_DFTINFVO);

			return "redirect:/mas/sv/detailSvDftinf.do";

		}
}
