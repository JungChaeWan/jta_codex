package mas.sp.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.ad.vo.AD_PRDTINFSVO;
import mas.ad.vo.AD_PRDTINFVO;
import mas.sp.service.MasSpService;
import mas.sp.vo.SP_ADDOPTINFVO;
import mas.sp.vo.SP_DIVINFVO;
import mas.sp.vo.SP_DTLINFVO;
import mas.sp.vo.SP_DTLINF_ITEMVO;
import mas.sp.vo.SP_GUIDINFOVO;
import mas.sp.vo.SP_OPTINFVO;
import mas.sp.vo.SP_PRDTINFSVO;
import mas.sp.vo.SP_PRDTINFVO;
import oss.ad.vo.AD_WEBLISTVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_DTLIMGVO;
import oss.cmm.vo.CM_ICONINFVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.user.vo.USERVO;
import web.order.vo.AD_RSVVO;
import web.order.vo.MRTNVO;
import web.order.vo.RSVSVO;
import web.product.service.WebAdProductService;
import web.product.service.WebSpProductService;
import web.product.vo.WEB_DTLPRDTVO;
import web.product.vo.WEB_SPPRDTVO;

@Controller
public class MasSpPrdtController {

	@Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "masSpService")
	private MasSpService masSpService;

	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name="webAdProductService")
	private WebAdProductService webAdService;

	@Resource(name="ossCorpService")
	private OssCorpService ossCorpService;

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	/**
	 * 소셜상품 조회
	 *
	 * @param sp_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sp/productList.do")
	public String socialProductList(
			@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
			ModelMap model) {
		log.info("/mas/sp/productList.do call");

		sp_PRDTINFSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		sp_PRDTINFSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(sp_PRDTINFSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(sp_PRDTINFSVO.getPageUnit());
		paginationInfo.setPageSize(sp_PRDTINFSVO.getPageSize());

		sp_PRDTINFSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		sp_PRDTINFSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		sp_PRDTINFSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// CORP_ID set
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFSVO.setsCorpId(corpInfo.getCorpId());

		Map<String, Object> resultMap = masSpService.selectSpPrdtInfList(sp_PRDTINFSVO);

		@SuppressWarnings("unchecked")
		List<SP_PRDTINFVO> resultList = (List<SP_PRDTINFVO>) resultMap
				.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		List<CDVO> cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCd", cdList);

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "mas/sp/productList";
	}

	/**
	 * 상품 정보 insert View
	 * @param sp_PRDTINFVO
	 * @param sp_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sp/viewInsertSocial.do")
	public String viewInsertSocial(
			@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO,
			@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
			ModelMap model) {
		log.info("/mas/sp/viewInsertSocial.do call");

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(corpInfo.getCorpId());

		model.addAttribute("linkPrdtUseYn", ossCorpService.selectLinkPrdtUseYn());
		model.addAttribute("lsLinkYn", ossCorpService.selectByCorp(corpVO).getLsLinkYn());

		List<CDVO> resultList = ossCmmService.selectCode(Constant.CATEGORY_CD);
		model.addAttribute("categoryList", resultList);

		//코드 정보 얻기
    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");

    	model.addAttribute("cdAdar", cdAdar);
    	model.addAttribute("cdAddv", cdAddv);

    	// 주요정보
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.ICON_CD_ADAT);
    	model.addAttribute("iconCd", cdList);

		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		model.addAttribute("filePath", EgovProperties.getProperty("HOST.WEBROOT") + EgovProperties.getProperty("PRODUCT.SP.SAVEDFILE"));
		return "mas/sp/insertProduct";
	}

	/**
	 * 상품정보 insert
	 * @param sp_PRDTINFVO
	 * @param bindingResult
	 * @param sp_PRDTINFSVO
	 * @param fileList
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mas/sp/insertSocialProductInfo.do")
	public String insertSocial(@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO,
							   BindingResult bindingResult,
							   @ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
							   @Param("fileList") String fileList,
							   ModelMap model) throws Exception {
		log.info("/mas/insertSocialProductInfo.do call");

		// validation 체크
		beanValidator.validate(sp_PRDTINFVO, bindingResult);
		log.info("fileList :: " + fileList);

		if (bindingResult.hasErrors()) {
			log.info("error");
			model.addAttribute("linkPrdtUseYn", ossCorpService.selectLinkPrdtUseYn());
			model.addAttribute("spPrdtInf", sp_PRDTINFVO);
			log.info(bindingResult.toString());
			List<CDVO> resultList = ossCmmService.selectCode(Constant.CATEGORY_CD);
			model.addAttribute("categoryList", resultList);

			//코드 정보 얻기
	    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
	    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");

	    	model.addAttribute("cdAdar", cdAdar);
	    	model.addAttribute("cdAddv", cdAddv);

	    	// 주요정보
	    	List<CDVO> cdList = ossCmmService.selectCode(Constant.ICON_CD_ADAT);
	    	model.addAttribute("iconCd", cdList);

			return "mas/sp/insertProduct";
		}

		// 이미지 파일 validate 체크
		/*Map<String, Object> imgValidateMap = ossFileUtilService.validateImgFile(multiRequest);

		if (!(Boolean) imgValidateMap.get("validateChk")) {
			log.info("이미지 파일 에러");
			model.addAttribute("spPrdtInfo", sp_PRDTINFVO);
			List<CDVO> resultList = ossCmmService.selectCode(Constant.CATEGORY_CD);
			model.addAttribute("categoryList", resultList);
			return "/mas/sp/insertProduct";
		}*/

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sp_PRDTINFVO.setFrstRegId(corpInfo.getUserId());
		sp_PRDTINFVO.setFrstRegIp(corpInfo.getLastLoginIp());
		sp_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sp_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		// 업체 기본정보 등록 처리
		String prdtNum = masSpService.insertSpPrdtInf(sp_PRDTINFVO, fileList);
		model.addAttribute("prdtNum", prdtNum);
		return "redirect:/mas/sp/viewUpdateSocial.do";

	}

	/**
	 * 기본상품 정보 수정화면
	 *
	 * @param sp_PRDTINFVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sp/viewUpdateSocial.do")
	public String viewUpdateSocial(
			@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO,
			@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
			ModelMap model) {
		log.info("/mas/sp/viewUpdateSocial.do call");

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());

		SP_PRDTINFVO resultVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);

		if(resultVO == null) {
			log.error("prdt num is wrong");
		}
		model.addAttribute("spPrdtInf", resultVO);

		//코드 정보 얻기
    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");

    	model.addAttribute("cdAdar", cdAdar);
    	model.addAttribute("cdAddv", cdAddv);

    	// 주요정보 체크 리스트
    	List<CM_ICONINFVO> iconCdList = ossCmmService.selectCmIconinf(sp_PRDTINFVO.getPrdtNum(), Constant.ICON_CD_ADAT);
    	model.addAttribute("iconCdList", iconCdList);

		// 등록중, 승인요청, 수정요청 상태가 아니라면 detail 페이지로 이동.
		/*if(!(Constant.TRADE_STATUS_REG.equals(resultVO.getTradeStatus()) || Constant.TRADE_STATUS_APPR_REQ.equals(resultVO.getTradeStatus())
				 || Constant.TRADE_STATUS_EDIT.equals(resultVO.getTradeStatus()))) {
			return "redirect:/mas/sp/detailSocial.do?prdtNum=" + resultVO.getPrdtNum();
		}*/

		List<CDVO> resultList = ossCmmService.selectCode(Constant.CATEGORY_CD);
		model.addAttribute("categoryList", resultList);

		String apprMsg = masSpService.prdtApprMsg(resultVO.getPrdtNum());

		if(StringUtils.isNotEmpty(apprMsg)) {
			apprMsg = EgovStringUtil.checkHtmlView(apprMsg);
		}

		model.addAttribute("linkPrdtUseYn", ossCorpService.selectLinkPrdtUseYn());
		model.addAttribute("btnApproval", masSpService.btnApproval(resultVO));
		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		model.addAttribute("apprMsg", apprMsg);

		return "/mas/sp/updateProduct";
	}

	/**
	 * 기본상품 수정,
	 *
	 * @param sp_PRDTINFVO
	 * @param bindingResult
	 * @param sp_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sp/updateSocialProductInfo.do")
	public String updateSocialProductInfo(
			@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO,
			BindingResult bindingResult,
			final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
			ModelMap model) throws Exception {
		log.info("/mas/updateSocialProductInfo.do call");

		// validation 체크
		beanValidator.validate(sp_PRDTINFVO, bindingResult);

		if (bindingResult.hasErrors()) {
			log.info("error");
			List<CDVO> resultList = ossCmmService.selectCode(Constant.CATEGORY_CD);
			model.addAttribute("categoryList", resultList);
			model.addAttribute("spPrdtInf", sp_PRDTINFVO);
			log.info(bindingResult.toString());

			//코드 정보 얻기
	    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
	    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");

	    	model.addAttribute("cdAdar", cdAdar);
	    	model.addAttribute("cdAddv", cdAddv);

			// 주요정보 체크 리스트
	    	List<CM_ICONINFVO> iconCdList = ossCmmService.selectCmIconinf(sp_PRDTINFVO.getPrdtNum(), Constant.ICON_CD_ADAT);
	    	model.addAttribute("iconCdList", iconCdList);
	    	model.addAttribute("linkPrdtUseYn", ossCorpService.selectLinkPrdtUseYn());
			return "mas/sp/updateProduct";
		}

		// 이미지 파일 validate 체크
		Map<String, Object> imgValidateMap = ossFileUtilService.validateImgFile(multiRequest);

		if (!(Boolean) imgValidateMap.get("validateChk")) {
			log.info("이미지 파일 에러");
			model.addAttribute("spPrdtInf", sp_PRDTINFVO);
			List<CDVO> resultList = ossCmmService.selectCode(Constant.CATEGORY_CD);
			model.addAttribute("categoryList", resultList);

			//코드 정보 얻기
	    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
	    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");

	    	model.addAttribute("cdAdar", cdAdar);
	    	model.addAttribute("cdAddv", cdAddv);

			// 주요정보 체크 리스트
	    	List<CM_ICONINFVO> iconCdList = ossCmmService.selectCmIconinf(sp_PRDTINFVO.getPrdtNum(), Constant.ICON_CD_ADAT);
	    	model.addAttribute("iconCdList", iconCdList);

			return "/mas/sp/updateProduct";
		}

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sp_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sp_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		// 소셜상품 수정 처리
		masSpService.updateSpPrdtInf(sp_PRDTINFVO, multiRequest);

		return "redirect:/mas/sp/viewUpdateSocial.do?prdtNum="+sp_PRDTINFVO.getPrdtNum() + "&pageIndex=" + sp_PRDTINFVO.getPageIndex();

	}

	/**
	 * 협회 관리자에 승인요청하기
	 *
	 * @param sp_PRDTINFVO
	 * @return
	 */
	@RequestMapping("/mas/sp/approvalReqSocial.ajax")
	public ModelAndView approvalReqSocial(@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO) {
		log.info("/mas/sp/approvalReqSocial.do call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sp_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sp_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		sp_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_APPR_REQ);
		masSpService.updateSpTradeStatus(sp_PRDTINFVO);
    	resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
    	return modelAndView;
	}

	/**
	 * 상품 승인취소하기
	 *
	 * @param sp_PRDTINFVO
	 * @return
	 */
	@RequestMapping("/mas/sp/approvalCancelSocial.ajax")
	public ModelAndView approvalCancelSocial(@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO) {
		log.info("/mas/sp/approvalReqSocial.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sp_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sp_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		sp_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_REG);
		sp_PRDTINFVO.setConfRequestDttm("");
		masSpService.updateSpTradeStatus(sp_PRDTINFVO);

		resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}

	/**
	 * 상품 판매중지 하기
	 *
	 * @param sp_PRDTINFVO
	 * @param sp_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sp/saleStopSocial.ajax")
	public ModelAndView saleStopSocial(@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO,
			@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
			ModelMap model) {
		log.info("/mas/sp/saleStopSocial.ajax call");

		Map<String, Object> resultMap = new HashMap<String,Object>();

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sp_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sp_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		sp_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_STOP_REQ);
		masSpService.updateSpPrdtInf(sp_PRDTINFVO);
		resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	/**
	 * 상품 판매전환 하기
	 *
	 * @param sp_PRDTINFVO
	 * @param sp_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sp/saleStartSocial.ajax")
	public ModelAndView saleStartSocial(@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO,
			@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
			ModelMap model) {
		log.info("/mas/sp/saleStartSocial.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		sp_PRDTINFVO.setLastModId(corpInfo.getUserId());
		sp_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());

		sp_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_APPR);
		masSpService.updateSpPrdtInf(sp_PRDTINFVO);

		resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}
	
    /* 목록에서 히든처리 */
    @RequestMapping("/mas/sp/salePrintN.do")
    public String salePrintN(@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO,
			@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
			ModelMap model) {
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	sp_PRDTINFVO.setLastModId(corpInfo.getUserId());
    	sp_PRDTINFVO.setLastModIp(corpInfo.getLastLoginIp());
    	masSpService.salePrintN(sp_PRDTINFVO);
    	
    	return "redirect:/mas/sp/productList.do";
    }	

	/**
	 * 상품정보 상세보기
	 * @param sp_PRDTINFVO
	 * @param sp_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sp/detailSocial.do")
	public String detailSocial(
			@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO,
			@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
			ModelMap model) {
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());

		SP_PRDTINFVO resultVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);

		if(resultVO == null) {
			log.error("prdtNum is wrong");
		}

		String apprMsg = masSpService.prdtApprMsg(resultVO.getPrdtNum());

		if(StringUtils.isNotEmpty(apprMsg)) {
			apprMsg = EgovStringUtil.checkHtmlView(apprMsg);
		}

		model.put("spPrdtInf", resultVO);
		model.put("apprMsg", apprMsg);

		return "/mas/sp/detailSocial";
	}
	/**
	 * 이미지 관리 리스트.
	 * @param sp_PRDTINFVO
	 * @param sp_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sp/imgList.do")
    public String imgList(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
						  @ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
						  ModelMap model) {

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());

		SP_PRDTINFVO spPrdtInfVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);

		if(spPrdtInfVO == null) {
			log.error("prdtNum is wrong");
		}
		// 등록중, 승인요청, 수정요청 상태가 아니라면 detail 페이지로 이동.
		/*if(!(Constant.TRADE_STATUS_REG.equals(spPrdtInfVO.getTradeStatus()) || Constant.TRADE_STATUS_APPR_REQ.equals(spPrdtInfVO.getTradeStatus())
				|| Constant.TRADE_STATUS_EDIT.equals(spPrdtInfVO.getTradeStatus()))) {
			return "redirect:/mas/sp/detailImgList.do?prdtNum="+spPrdtInfVO.getPrdtNum();
		}*/

		model.addAttribute("prdtDiv", spPrdtInfVO.getPrdtDiv());
		model.addAttribute("btnApproval", masSpService.btnApproval(spPrdtInfVO));

		model.addAttribute("prdtVO", spPrdtInfVO);
    	return "/mas/sp/imgList";
    }

	/**
	 * 이미지 관리 리스트. detail
	 * @param sp_PRDTINFVO
	 * @param sp_PRDTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/sp/detailImgList.do")
   public String detailImgList(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
							   @ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
							   ModelMap model) {
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());

		SP_PRDTINFVO spPrdtInfVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);

		if(spPrdtInfVO == null) {
			log.error("prdtNum is wrong");
		}

		model.addAttribute("prdtDiv", spPrdtInfVO.getPrdtDiv());
		model.addAttribute("spPrdtInf", sp_PRDTINFVO);

		model.addAttribute("prdtVO", spPrdtInfVO);
   	return "/mas/sp/detailImgList";
   }

	@RequestMapping("/mas/sp/deleteSocial.do")
	public String deleteSocial(@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO) throws Exception {

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());

		SP_PRDTINFVO resultVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);
		if(resultVO == null) {
			log.error("prdtNum is wrong");
		}
		String prdtNum = sp_PRDTINFVO.getPrdtNum();

		// 옵션 삭제
		SP_OPTINFVO sp_OPTINFVO = new SP_OPTINFVO();
		sp_OPTINFVO.setPrdtNum(prdtNum);

		masSpService.deleteSpOptInf(sp_OPTINFVO);

		// 추가 옵션 삭제
		SP_ADDOPTINFVO sp_addoptinfVO = new SP_ADDOPTINFVO();
		sp_addoptinfVO.setPrdtNum(prdtNum);

		masSpService.deleteAddOptInf(sp_addoptinfVO);

		// 구분자 삭제
		SP_DIVINFVO sp_DIVINFVO = new SP_DIVINFVO();
		sp_DIVINFVO.setPrdtNum(prdtNum);

		masSpService.deleteSpDivInf(sp_DIVINFVO);

		// 이미지 삭제
		CM_IMGVO imgVO = new CM_IMGVO();
		imgVO.setLinkNum(prdtNum);

		ossCmmService.deletePrdtImgList(imgVO);

		// 상세 이미지 삭제
		CM_DTLIMGVO imgDtlVO = new CM_DTLIMGVO();
		imgDtlVO.setLinkNum(prdtNum);

		ossCmmService.deletePrdtDtlImgList(imgDtlVO);

		//상품 삭제
		masSpService.deleteSpPrdtInf(sp_PRDTINFVO);

		return "redirect:/mas/sp/productList.do";
	}

	/**
	 * 상품 상세 이미지
	 * @param sp_PRDTINFSVO
	 * @param sp_PRDTINFVO
	 * @param model
	 * @return
	 */
	  @RequestMapping("/mas/sp/dtlImgList.do")
	    public String dtlImgList(@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
					    		@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
					    		ModelMap model){
		  USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		  sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		  SP_PRDTINFVO spPrdtInfVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);

		  if(spPrdtInfVO == null) {
			  log.error("prdtNum is wrong");
		  }
			// 등록중, 승인요청, 수정요청 상태가 아니라면 detail 페이지로 이동.
			/*if(!(Constant.TRADE_STATUS_REG.equals(spPrdtInfVO.getTradeStatus()) || Constant.TRADE_STATUS_APPR_REQ.equals(spPrdtInfVO.getTradeStatus())
	  			|| Constant.TRADE_STATUS_EDIT.equals(spPrdtInfVO.getTradeStatus()))) {
				return "redirect:/mas/sp/detailDtlImgList.do?prdtNum="+spPrdtInfVO.getPrdtNum()+"&pageIndex="+sp_PRDTINFSVO.getPageIndex();
			}*/

			model.addAttribute("prdtDiv", spPrdtInfVO.getPrdtDiv());
			model.addAttribute("btnApproval", masSpService.btnApproval(spPrdtInfVO));
			model.addAttribute("prdtVO", spPrdtInfVO);
	    	return "/mas/sp/dtlImgList";
	    }

	  /**
		 * 상품 상세 이미지 detail
		 * @param sp_PRDTINFSVO
		 * @param sp_PRDTINFVO
		 * @param model
		 * @return
		 */
	  @RequestMapping("/mas/sp/detailDtlImgList.do")
	    public String detailDtlImgList(@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
					    		@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
					    		ModelMap model){
	  		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
	  		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());

	  		SP_PRDTINFVO spPrdtInfVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);

	  		if(spPrdtInfVO == null) {
				  log.error("prdtNum is wrong");
			  }

			model.addAttribute("prdtDiv", spPrdtInfVO.getPrdtDiv());
			model.addAttribute("prdtVO", spPrdtInfVO);
	    	return "/mas/sp/detailDtlImgList";
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
	    @RequestMapping("/mas/sp/useepilList.do")
	    public String useepilList(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
					    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
					    		ModelMap model){
	    	log.info("/mas/sp/useepilList.do 호출");
	    	return "/mas/sp/useepilList";
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
	    @RequestMapping("/mas/sp/detailUseepil.do")
	    public String detailUseepil(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
					    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
					    		ModelMap model){
	    	return "/mas/sp/detailUseepil";
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
	    @RequestMapping("/mas/sp/otoinqList.do")
	    public String otoinqlList(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
					    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
					    		ModelMap model){
	    	//log.info("/mas/ad/otoinqList.do 호출");

	    	return "/mas/sp/otoinqList";
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
	    @RequestMapping("/mas/sp/detailOtoinq.do")
	    public String detailOtoinq(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
					    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
					    		ModelMap model){
	    	//log.info("/mas/ad/detailUOtoinq.do 호출");

	    	return "/mas/sp/detailOtoinq";
	    }


	    @RequestMapping("/mas/sp/copyProduct.do")
		public String copyProduct(@ModelAttribute("SP_PRDTINFVO") SP_PRDTINFVO sp_PRDTINFVO,
				ModelMap model) throws Exception {

	    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
			sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
			sp_PRDTINFVO.setFrstRegId(corpInfo.getUserId());
			sp_PRDTINFVO.setFrstRegIp(corpInfo.getLastLoginIp());

	    	String newPrdtNum = masSpService.copyProduct(sp_PRDTINFVO);

	    	return "redirect:/mas/sp/viewUpdateSocial.do?prdtNum="+newPrdtNum;
		}

	    @RequestMapping("/mas/preview/spDetailProduct.do")
	    public String detailProduct(@ModelAttribute("prdtVO") WEB_DTLPRDTVO prdtVO,
	    		ModelMap model) throws ParseException {
	    	String prdtNum = prdtVO.getPrdtNum();

	    	if(prdtNum == null) {
	    		log.error("prdtNum is null");
				return "redirect:/web/cmm/error.do?errCord=PRDT01";
	    	}

	    	// 상품 정보 가져오기.
	    	prdtVO.setPreviewYn(Constant.FLAG_Y);
	    	WEB_DTLPRDTVO prdtInfo =  webSpService.selectByPrdt(prdtVO);

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


	    	//추가사항:: 상세 정보 가져오기
	    	SP_DTLINFVO sp_DTLINFVO = new SP_DTLINFVO();
	    	sp_DTLINFVO.setPrdtNum(prdtVO.getPrdtNum());
	    	sp_DTLINFVO.setPrintYn("Y");
	    	List<SP_DTLINFVO> dtlInfList = masSpService.selectDtlInfList(sp_DTLINFVO);
	    	for (SP_DTLINFVO data : dtlInfList) {
	    		data.setDtlinfExp(EgovStringUtil.checkHtmlView(data.getDtlinfExp()));

	    		SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO = new SP_DTLINF_ITEMVO();
	    		sp_DTLINF_ITEMVO.setPrdtNum(prdtVO.getPrdtNum());
	    		sp_DTLINF_ITEMVO.setSpDtlinfNum(data.getSpDtlinfNum());
	    		List<SP_DTLINF_ITEMVO> dtlInfItemList = masSpService.selectDtlInfItemList(sp_DTLINF_ITEMVO);

	    		for (SP_DTLINF_ITEMVO dataItem : dtlInfItemList) {
	    			if(dataItem.getItemEtc() == null || dataItem.getItemEtc().isEmpty() || "".equals(dataItem.getItemEtc()) ){

	    			}else{
	    				//하나라도 뿌릴게 있으면 뿌린다.
	    				data.setItmeEtcViewYn("Y");

	    				//변환
	    				dataItem.setItemEtc(EgovStringUtil.checkHtmlView( dataItem.getItemEtc() ) );
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
				if("Y".equals(sp_GUIDINFOVORes.getPrintYn())){
					sp_GUIDINFOVORes.setPrdtExp(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getPrdtExp() ) );
					sp_GUIDINFOVORes.setUseQlfct(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getUseQlfct() ) );
					sp_GUIDINFOVORes.setUseGuide(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getUseGuide() ) );
					sp_GUIDINFOVORes.setCancelRefundGuide(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getCancelRefundGuide() ) );
				}

				//배경색 얻기
				if(!(sp_GUIDINFOVORes.getBgColor()==null || sp_GUIDINFOVORes.getBgColor().isEmpty() || "".equals(sp_GUIDINFOVORes.getBgColor()) ) ){
					model.addAttribute("infoBgColor", sp_GUIDINFOVORes.getBgColor());
				}
			}
			model.addAttribute("SP_GUIDINFOVO", sp_GUIDINFOVORes);


	    	String corpId = prdtInfo.getCorpId();
	    	List<WEB_SPPRDTVO> otherProductList = null;
	    	List<AD_WEBLISTVO> otherAdList = null;
	    	// 판매처 다른 상품보기 (쿠폰상품 일 경우 처리 안함)
	    	if(Constant.SP_PRDT_DIV_TOUR.equals(prdtInfo.getPrdtDiv()) || Constant.SP_PRDT_DIV_COUP.equals(prdtInfo.getPrdtDiv())) {
	    		otherProductList= webSpService.selectOtherProductList(corpId);
	    	} else { // 주변숙소 보기
	    		otherAdList = webAdService.selectAdPrdtListDist(prdtInfo.getLat(), prdtInfo.getLon(), 5);
	    	}

	    	// 상품 판매종료일 전 남은 시간 가져오기.(현재시간으로)
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
			Date fromDate = Calendar.getInstance().getTime();
			Date toDate = sdf.parse(prdtInfo.getSaleEndDt()+"2359");

			long difDay = OssCmmUtil.getDifDay(fromDate, toDate);
			long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) - (difDay*24 * 3600);

			/*if(StringUtils.isNotEmpty(prdtInfo.getCancelGuide()) && StringUtils.indexOf(prdtInfo.getCancelGuide(), "id=\"dext_body\"") == -1) {
				//prdtInfo.setCancelGuide(EgovStringUtil.checkHtmlView(prdtInfo.getCancelGuide()));
			}
			if(StringUtils.isNotEmpty(prdtInfo.getUseQlfct()) && StringUtils.indexOf(prdtInfo.getUseQlfct(), "id=\"dext_body\"") == -1 ) {
				//prdtInfo.setUseQlfct(EgovStringUtil.checkHtmlView(prdtInfo.getUseQlfct()));
			}*/

			// 상품 추가 옵션 가져오기.
			SP_ADDOPTINFVO sp_ADDOPTINFVO = new SP_ADDOPTINFVO();
			sp_ADDOPTINFVO.setPrdtNum(prdtNum);
			List<SP_ADDOPTINFVO> addOptList = masSpService.selectPrdtAddOptionList(sp_ADDOPTINFVO);

			model.addAttribute("difTime", difTime);
			model.addAttribute("difDay", difDay);
			model.addAttribute("prdtInfo", prdtInfo);
			model.addAttribute("prdtImg", prdtImg);
			model.addAttribute("dtlImg", dtlImg);
			model.addAttribute("otherProductList", otherProductList);
			model.addAttribute("otherAdList", otherAdList);
			model.addAttribute("preview", Constant.FLAG_Y);
			model.addAttribute("addOptList", addOptList);

			if(Constant.SP_PRDT_DIV_FREE.equals(prdtInfo.getPrdtDiv())) {
				return "web/sp/detailFreeProduct";
			}
	    	return "web/sp/detailProduct";
	    }

	    /**
	     * 해당 상품에 예약건이 존재하는지 확인
	     * 파일명 : checkExsistPrdt
	     * 작성일 : 2016. 11. 23. 오후 4:22:42
	     * 작성자 : 최영철
	     * @param rsvSVO
	     * @return
	     */
	    @RequestMapping("/mas/sp/checkExsistPrdt.ajax")
	    public ModelAndView checkExsistPrdt(@ModelAttribute("searchVO") RSVSVO rsvSVO){
	    	Map<String, Object> resultMap = new HashMap<String, Object>();

	    	Integer chkInt = masSpService.checkExsistPrdt(rsvSVO);
	    	resultMap.put("chkInt", chkInt);
	    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

	    	return mav;

	    }



    @RequestMapping("/mas/sp/dtlinfList.do")
    public String dtlinfList(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
    						@ModelAttribute("SP_DTLINFVO") SP_DTLINFVO sp_DTLINFVO,
    						@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
				    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		SP_PRDTINFVO spPrdtInfVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);
		model.addAttribute("spPrdtInf", spPrdtInfVO);


		List<SP_DTLINFVO> dtlInfList = masSpService.selectDtlInfList(sp_DTLINFVO);
		model.addAttribute("dtlInfList", dtlInfList);


		//안내사항
		SP_GUIDINFOVO sp_GUIDINFOVO = new SP_GUIDINFOVO();
		sp_GUIDINFOVO.setPrdtNum(sp_DTLINFVO.getPrdtNum());
		SP_GUIDINFOVO sp_GUIDINFOVORes = masSpService.selectGuidinfo(sp_GUIDINFOVO);
		if(sp_GUIDINFOVORes != null){
			sp_GUIDINFOVORes.setPrdtExp(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getPrdtExp() ) );
			sp_GUIDINFOVORes.setUseQlfct(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getUseQlfct() ) );
			sp_GUIDINFOVORes.setUseGuide(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getUseGuide() ) );
			sp_GUIDINFOVORes.setCancelRefundGuide(EgovStringUtil.checkHtmlView( sp_GUIDINFOVORes.getCancelRefundGuide() ) );
		}
		model.addAttribute("SP_GUIDINFOVO", sp_GUIDINFOVORes);

		model.addAttribute("prdtDiv", spPrdtInfVO.getPrdtDiv());

		model.addAttribute("SP_DTLINFVO", sp_DTLINFVO);
		return "/mas/sp/dtlinfList";
    }

    @RequestMapping("/mas/sp/dtlinfInsView.do")
    public String dtlinfInsView(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
							@ModelAttribute("SP_DTLINFVO") SP_DTLINFVO sp_DTLINFVO,
							@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
							ModelMap model){
    	log.info("/mas/sp/dtlinfInsView.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		SP_PRDTINFVO spPrdtInfVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);
		model.addAttribute("spPrdtInf", spPrdtInfVO);

		//List<SP_DTLINF_ITEMVO> dtlInfItemList = new ArrayList();
		//for(int i=1; i<=8; i++){
		//	SP_DTLINF_ITEMVO data = new SP_DTLINF_ITEMVO();
		//	dtlInfItemList.add(data);
		//}
		//model.addAttribute("dtlInfItemList", dtlInfItemList);


       return "/mas/sp/dtlinfIns";

	 }


    @RequestMapping("/mas/sp/dtlinfIns.do")
    public String dtlinfIns(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
							@ModelAttribute("SP_DTLINFVO") SP_DTLINFVO sp_DTLINFVO,
							HttpServletRequest request,
							ModelMap model){
    	log.info("/mas/sp/dtlinfIns.do 호출");


    	//상세정보 넣기
    	String spDtlinfNum = masSpService.insertDtlInf(sp_DTLINFVO);

    	//상세정보 아이템 넣기
    	//List<SP_DTLINF_ITEMVO> dtlInfItemList = new ArrayList();
    	for(int i=1; i<=8; i++){
    		SP_DTLINF_ITEMVO data = new SP_DTLINF_ITEMVO();
    		String itemNm = request.getParameter("itemNm"+i);

    		//항목명이 비어있으면 넣지 않는다.
    		if( !(itemNm==null || itemNm.isEmpty() || itemNm.equals("")) ){
	    		data.setSpDtlinfNum(spDtlinfNum);
	    		data.setPrdtNum(sp_PRDTINFVO.getPrdtNum());
	    		data.setItemNm( request.getParameter("itemNm"+i) );
	    		data.setItemAmt( request.getParameter("itemAmt"+i) );
	    		data.setItemDisAmt( request.getParameter("itemDisAmt"+i) );
	    		data.setItemEtc( request.getParameter("itemEtc"+i) );
	    		masSpService.insetDtlInfItem(data);
    		}
    	}


    	return "redirect:/mas/sp/dtlinfList.do?prdtNum="+sp_PRDTINFVO.getPrdtNum() + "&pageIndex=" + sp_PRDTINFVO.getPageIndex();
    }


    @RequestMapping("/mas/sp/dtlinfUdtView.do")
    public String dtlinfUdtView(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
							@ModelAttribute("SP_DTLINFVO") SP_DTLINFVO sp_DTLINFVO,
							@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
							ModelMap model){
    	log.info("/mas/sp/dtlinfUdtView.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		SP_PRDTINFVO spPrdtInfVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);
		model.addAttribute("spPrdtInf", spPrdtInfVO);

		SP_DTLINFVO sp_DTLINFRes = masSpService.selectDtlInf(sp_DTLINFVO);

		model.addAttribute("SP_DTLINFVO", sp_DTLINFRes);

		int nMaxSn = masSpService.getDtlInfMaxSN(sp_DTLINFVO);
		model.addAttribute("maxPos", nMaxSn);


		SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO = new SP_DTLINF_ITEMVO();
		sp_DTLINF_ITEMVO.setPrdtNum(sp_PRDTINFVO.getPrdtNum());
		sp_DTLINF_ITEMVO.setSpDtlinfNum(sp_DTLINFVO.getSpDtlinfNum());
		List<SP_DTLINF_ITEMVO> dtlInfItemList = masSpService.selectDtlInfItemList(sp_DTLINF_ITEMVO);
		model.addAttribute("dtlInfItemList", dtlInfItemList);


       return "/mas/sp/dtlinfUdt";

	 }


    @RequestMapping("/mas/sp/dtlinfUdt.do")
    public String dtlinfUdt(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
							@ModelAttribute("SP_DTLINFVO") SP_DTLINFVO sp_DTLINFVO,
							HttpServletRequest request,
							ModelMap model){
    	log.info("/mas/sp/dtlinfUdt.do 호출");

    	SP_DTLINFVO dlTest = new SP_DTLINFVO();
    	dlTest.setSpDtlinfNum(sp_DTLINFVO.getSpDtlinfNum());
    	SP_DTLINFVO dtlInfOrg = masSpService.selectDtlInf(dlTest);
		dtlInfOrg.setOldSn(dtlInfOrg.getPrintSn());
		dtlInfOrg.setNewSn(sp_DTLINFVO.getPrintSn());

		// 순번 관련 작업
		if (!dtlInfOrg.getNewSn().equals(dtlInfOrg.getOldSn())) {
			if (Integer.parseInt(dtlInfOrg.getPrintSn()) > Integer.parseInt(sp_DTLINFVO.getPrintSn())) {
				// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
				masSpService.addViewSnDtlInf(dtlInfOrg);
			} else {
				masSpService.minusViewSnDtlInf(dtlInfOrg);
			}
		}


    	//상세정보 업데이트
    	masSpService.updateDtlInf(sp_DTLINFVO);


    	//상세정보 아이템 삭제
    	SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO = new SP_DTLINF_ITEMVO();
    	sp_DTLINF_ITEMVO.setPrdtNum(sp_PRDTINFVO.getPrdtNum());
    	sp_DTLINF_ITEMVO.setSpDtlinfNum(sp_DTLINFVO.getSpDtlinfNum());
    	masSpService.deleteDtlInfItem(sp_DTLINF_ITEMVO);

    	//상세정보 아이템 넣기
    	for(int i=1; i<=8; i++){
    		SP_DTLINF_ITEMVO data = new SP_DTLINF_ITEMVO();
    		String itemNm = request.getParameter("itemNm"+i);

    		//항목명이 비어있으면 넣지 않는다.
    		if( !(itemNm==null || itemNm.isEmpty() || itemNm.equals("")) ){
	    		data.setSpDtlinfNum(sp_DTLINFVO.getSpDtlinfNum());
	    		data.setPrdtNum(sp_PRDTINFVO.getPrdtNum());
	    		data.setItemNm( request.getParameter("itemNm"+i) );
	    		data.setItemAmt( request.getParameter("itemAmt"+i) );
	    		data.setItemDisAmt( request.getParameter("itemDisAmt"+i) );
	    		data.setItemEtc( request.getParameter("itemEtc"+i) );
	    		masSpService.insetDtlInfItem(data);
    		}
    	}


    	return "redirect:/mas/sp/dtlinfList.do?prdtNum="+sp_PRDTINFVO.getPrdtNum() + "&pageIndex=" + sp_PRDTINFVO.getPageIndex();
    }

    @RequestMapping("/mas/sp/dtlinfDel.do")
    public String dtlinfDel(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
							@ModelAttribute("SP_DTLINFVO") SP_DTLINFVO sp_DTLINFVO,
							HttpServletRequest request,
							ModelMap model){

    	//상세 아이템 삭제
    	SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO = new SP_DTLINF_ITEMVO();
    	sp_DTLINF_ITEMVO.setPrdtNum(sp_PRDTINFVO.getPrdtNum());
    	sp_DTLINF_ITEMVO.setSpDtlinfNum(sp_DTLINFVO.getSpDtlinfNum());
    	masSpService.deleteDtlInfItem(sp_DTLINF_ITEMVO);


    	//순번관련
    	SP_DTLINFVO dtlInfOrg = masSpService.selectDtlInf(sp_DTLINFVO);
    	dtlInfOrg.setOldSn(dtlInfOrg.getPrintSn());
    	masSpService.minusViewSnDtlInf(dtlInfOrg);

    	//삭제
    	masSpService.deleteDtlInf(sp_DTLINFVO);

    	return "redirect:/mas/sp/dtlinfList.do?prdtNum="+sp_PRDTINFVO.getPrdtNum() + "&pageIndex=" + sp_PRDTINFVO.getPageIndex();
    }



    @RequestMapping("/mas/sp/guidinfUdtView.do")
    public String guidinfUdtView(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
							@ModelAttribute("sp_GUIDINFOVO") SP_GUIDINFOVO sp_GUIDINFOVO,
							@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
							ModelMap model){
    	log.info("/mas/sp/guidinfUdtView.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		SP_PRDTINFVO spPrdtInfVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);
		model.addAttribute("spPrdtInf", spPrdtInfVO);

		SP_GUIDINFOVO sp_GUIDINFOVORes = masSpService.selectGuidinfo(sp_GUIDINFOVO);
		if(sp_GUIDINFOVORes != null){
			model.addAttribute("SP_GUIDINFO", sp_GUIDINFOVORes);
		}

		return "/mas/sp/guidinfoUdt";

	 }

    @RequestMapping("/mas/sp/guidinfUdt.do")
    public String guidinfUdt(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
			@ModelAttribute("sp_GUIDINFOVO") SP_GUIDINFOVO sp_GUIDINFOVO,
							HttpServletRequest request,
							ModelMap model){
    	log.info("/mas/sp/guidinfUdt.do 호출");

    	//상세정보 업데이트
    	masSpService.updateGuidinfo(sp_GUIDINFOVO);

    	return "redirect:/mas/sp/dtlinfList.do?prdtNum="+sp_PRDTINFVO.getPrdtNum() + "&pageIndex=" + sp_PRDTINFVO.getPageIndex();
    }


    @RequestMapping("/mas/sp/guidinfUdtBgColorView.do")
    public String guidinfUdtBgColorView(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
							@ModelAttribute("sp_GUIDINFOVO") SP_GUIDINFOVO sp_GUIDINFOVO,
							@ModelAttribute("searchVO") SP_PRDTINFSVO sp_PRDTINFSVO,
							ModelMap model){
    	log.info("/mas/sp/guidinfUdtBgColorView.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		SP_PRDTINFVO spPrdtInfVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);
		model.addAttribute("spPrdtInf", spPrdtInfVO);

		SP_GUIDINFOVO sp_GUIDINFOVORes = masSpService.selectGuidinfo(sp_GUIDINFOVO);
		if(sp_GUIDINFOVORes != null){
			model.addAttribute("SP_GUIDINFO", sp_GUIDINFOVORes);
		}

		return "/mas/sp/guidinfoUdtBgColor";

	 }

    @RequestMapping("/mas/sp/guidinfUdtBgColor.do")
    public String guidinfUdtBgColor(@ModelAttribute("spPrdtInf") SP_PRDTINFVO sp_PRDTINFVO,
			@ModelAttribute("sp_GUIDINFOVO") SP_GUIDINFOVO sp_GUIDINFOVO,
							HttpServletRequest request,
							ModelMap model){
    	log.info("/mas/sp/guidinfUdtBgColor.do 호출");

    	//상세정보 업데이트
    	masSpService.updateGuidinfoBgColor(sp_GUIDINFOVO);

    	return "redirect:/mas/sp/dtlinfList.do?prdtNum="+sp_PRDTINFVO.getPrdtNum() + "&pageIndex=" + sp_PRDTINFVO.getPageIndex();
    }

    //마라톤 신청자 리스트
    @RequestMapping("/mas/sp/mrtnUserList.do")
    public String mrtnUserList(@ModelAttribute("MRTNVO") MRTNVO mrtnSVO,
							ModelMap model){
    	log.info("/mas/sp/mrtnUserList.do 호출");
    	
		List<MRTNVO> selectMrtnUserList = masSpService.selectMrtnUserList(mrtnSVO);
		model.addAttribute("resultList", selectMrtnUserList);
		model.addAttribute("resultCnt", selectMrtnUserList.size());
		model.addAttribute("corpId", mrtnSVO.getCorpId());
		model.addAttribute("prdtNum", mrtnSVO.getPrdtNum());
		model.addAttribute("sApctNm", mrtnSVO.getsApctNm());
		model.addAttribute("sApctTelnum", mrtnSVO.getsApctTelnum());
		
		MRTNVO mrtnTshirts = masSpService.selectMrtnTshirts(mrtnSVO);
		model.addAttribute("mrtnTshirts", mrtnTshirts);
		
		return "/mas/sp/mrtnUserListPop";
	 }
    
    //마라톤 신청자 정보수정
    @RequestMapping("/mas/sp/mrtnUserUpdate.ajax")
	public ModelAndView mrtnUserUpdate(@ModelAttribute("MRTNVO") MRTNVO mrtnVO) {
		log.info("/mas/sp/mrtnUserUpdate.do call");
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		masSpService.mrtnUserUpdate(mrtnVO);
    	resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
    	return modelAndView;
	}
    
    //마라톤 티셔츠 수량 생성
    @RequestMapping("/mas/sp/insertTshirts.ajax")
	public ModelAndView insertTshirts(@ModelAttribute("MRTNVO") MRTNVO mrtnVO) {
		log.info("/mas/sp/insertTshirts.do call");
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		masSpService.insertTshirts(mrtnVO);
    	resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
    	return modelAndView;
	}
    
    //마라톤 티셔츠 수량 수정
    @RequestMapping("/mas/sp/mrtnTshirtsUpdate.ajax")
	public ModelAndView mrtnTshirtsUpdate(@ModelAttribute("MRTNVO") MRTNVO mrtnVO) {
		log.info("/mas/sp/mrtnTshirtsUpdate.do call");
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		masSpService.mrtnTshirtsUpdate(mrtnVO);
    	resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
    	return modelAndView;
	}
    
    //마라톤 신청자 excel(취소 제외)
    @RequestMapping("/mas/sp/mrtnUserExcelDown.do")
    public void mrtnUserExcelDown(@ModelAttribute("MRTNVO") MRTNVO mrtnSVO,
							   HttpServletRequest request,
							   HttpServletResponse response){
    	log.info("/mas/sp/mrtnUserExcelDown.do 호출");

    	List<MRTNVO> resultList = masSpService.selectMrtnUserList(mrtnSVO);

		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상
        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("신청 예약내역");
        // 컬럼 너비 설정
        sheet1.setColumnWidth(0, 4000);
        sheet1.setColumnWidth(1, 3000);
        sheet1.setColumnWidth(2, 4000);
        sheet1.setColumnWidth(3, 5000);
        sheet1.setColumnWidth(4, 2500);
        sheet1.setColumnWidth(5, 2500);
        sheet1.setColumnWidth(6, 2500);
        sheet1.setColumnWidth(7, 6000);
        sheet1.setColumnWidth(8, 15000);
        sheet1.setColumnWidth(9, 7000);
        sheet1.setColumnWidth(10, 2500);
        sheet1.setColumnWidth(11, 3000);
        sheet1.setColumnWidth(12, 6000);
        // ----------------------------------------------------------
        CellStyle cellStyle = xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;
        // 첫 번째 줄
        row = sheet1.createRow(0);
        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("이름");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(1);
        cell.setCellValue("생년월일");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(2);
        cell.setCellValue("주민등록번호 뒷7자리");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(3);
        cell.setCellValue("전화번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(4);
        cell.setCellValue("나이대");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(5);
        cell.setCellValue("성별");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(6);
        cell.setCellValue("혈액형");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(7);
        cell.setCellValue("거주지역");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(8);
        cell.setCellValue("전체주소");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(9);
        cell.setCellValue("이메일");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(10);
        cell.setCellValue("코스");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(11);
        cell.setCellValue("티셔츠");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(12);
        cell.setCellValue("결제시간");
        cell.setCellStyle(cellStyle);
        
        //---------------------------------
		for (int i = 0; i < resultList.size(); i++) {
			MRTNVO mrtnVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			// 개행 처리
			CellStyle cs = xlsxWb.createCellStyle();
		    cs.setWrapText(true);
		    
		    //이름
			cell = row.createCell(0);
			cell.setCellStyle(cs);
			cell.setCellValue(mrtnVO.getApctNm());

			//생년월일
			cell = row.createCell(1);
			cell.setCellValue(mrtnVO.getBirth());
			
			//주민등록번호 뒷7자리
			cell = row.createCell(2);
			cell.setCellValue(mrtnVO.getLrrn());

			//전화번호
			cell = row.createCell(3);
			cell.setCellValue(mrtnVO.getApctTelnum().replaceAll("-", ""));

			//나이대
			cell = row.createCell(4);
			String ageRange = "";
			if(mrtnVO.getAgeRange().equals("10D")) {
				ageRange = "10대미만";
			} else if(mrtnVO.getAgeRange().equals("10R")) {
				ageRange = "10대";
			} else if(mrtnVO.getAgeRange().equals("20R")) {
				ageRange = "20대";
			} else if(mrtnVO.getAgeRange().equals("30R")) {
				ageRange = "30대";
			} else if(mrtnVO.getAgeRange().equals("40R")) {
				ageRange = "40대";
			} else if(mrtnVO.getAgeRange().equals("50R")) {
				ageRange = "50대";
			} else if(mrtnVO.getAgeRange().equals("60R")) {
				ageRange = "60대";
			} else if(mrtnVO.getAgeRange().equals("70U")) {
				ageRange = "70대이상";
			}
			cell.setCellValue(ageRange);
			
			//성별
			cell = row.createCell(5);
			cell.setCellValue(mrtnVO.getGender());
			
			//혈액형
			cell = row.createCell(6);
			String bloodType = "";
			if(mrtnVO.getBloodType().trim().equals("AP")) {
				bloodType = "A+";
			} else if(mrtnVO.getBloodType().trim().equals("BP")) {
				bloodType = "B+";
			} else if(mrtnVO.getBloodType().trim().equals("OP")) {
				bloodType = "O+";
			} else if(mrtnVO.getBloodType().trim().equals("ABP")) {
				bloodType = "AB+";
			} else if(mrtnVO.getBloodType().trim().equals("AM")) {
				bloodType = "A-";
			} else if(mrtnVO.getBloodType().trim().equals("BM")) {
				bloodType = "B-";
			} else if(mrtnVO.getBloodType().trim().equals("OM")) {
				bloodType = "O-";
			} else if(mrtnVO.getBloodType().trim().equals("ABM")) {
				bloodType = "AB-";
			}
			cell.setCellValue(bloodType);
			
			//거주지역
			cell = row.createCell(7);
			String region = "";
			if(mrtnVO.getRegion().equals("GW")) {
				region = "강원도";
			} else if(mrtnVO.getRegion().equals("GG")) {
				region = "경기도";
			} else if(mrtnVO.getRegion().equals("GN")) {
				region = "경상남도";
			} else if(mrtnVO.getRegion().equals("GB")) {
				region = "경상북도";
			} else if(mrtnVO.getRegion().equals("GJ")) {
				region = "광주광역시";
			} else if(mrtnVO.getRegion().equals("DG")) {
				region = "대구광역시";
			} else if(mrtnVO.getRegion().equals("DJ")) {
				region = "대전광역시";
			} else if(mrtnVO.getRegion().equals("BS")) {
				region = "부산광역시";
			} else if(mrtnVO.getRegion().equals("SU")) {
				region = "서울특별시";
			} else if(mrtnVO.getRegion().equals("SJ")) {
				region = "세종특별자치시";
			} else if(mrtnVO.getRegion().equals("US")) {
				region = "울산광역시";
			} else if(mrtnVO.getRegion().equals("IC")) {
				region = "인천광역시";
			} else if(mrtnVO.getRegion().equals("JN")) {
				region = "전라남도";
			} else if(mrtnVO.getRegion().equals("JB")) {
				region = "전라북도";
			} else if(mrtnVO.getRegion().equals("JJ")) {
				region = "제주특별자치도";
			} else if(mrtnVO.getRegion().equals("CN")) {
				region = "충청남도";
			} else if(mrtnVO.getRegion().equals("CB")) {
				region = "충청북도";
			}
			cell.setCellValue(region);

			cell = row.createCell(8);
			cell.setCellValue(mrtnVO.getFullAddr());

			cell = row.createCell(9);
			cell.setCellValue(mrtnVO.getApctEmail());

			cell = row.createCell(10);
			cell.setCellValue(mrtnVO.getCourse());

			cell = row.createCell(11);
			cell.setCellValue(mrtnVO.getTshirts().trim());
			
			cell = row.createCell(12);
			cell.setCellValue(mrtnVO.getRegDttm());
		}
        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "신청자 예약.xlsx";

    		String userAgent = request.getHeader("User-Agent");

    		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
    			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("MSIE") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("Trident") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("Android") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") );
    		} else if(userAgent.indexOf("Swing") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8")  + ";");
    		} else if(userAgent.indexOf("Mozilla/5.0") >= 0){			// 크롬, 파폭
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
    		} else {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		ServletOutputStream fileOutput = response.getOutputStream();

            xlsxWb.write(fileOutput);
			fileOutput.flush();
            fileOutput.close();

        } catch (FileNotFoundException e) {
        	log.error(e);
            e.printStackTrace();
        } catch (IOException e) {
        	log.error(e);
            e.printStackTrace();
        }
    }
}
