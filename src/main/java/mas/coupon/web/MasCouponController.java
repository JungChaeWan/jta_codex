package mas.coupon.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPPRDTVO;
import oss.coupon.vo.CPSVO;
import oss.coupon.vo.CPVO;
import oss.coupon.web.OssCouponController;
import oss.env.service.OssSiteManageService;
import oss.env.vo.DFTINFVO;
import oss.user.vo.USERVO;

@Controller
public class MasCouponController {
	Logger log = (Logger) LogManager.getLogger(OssCouponController.class);
	
	@Autowired
    private DefaultBeanValidator beanValidator;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name="ossCouponService")
    private OssCouponService ossCouponService;
	
	@Resource(name="ossCmmService")
    private OssCmmService ossCmmService;
    
    @Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;
    
    @Resource(name="ossSiteManageService")
	private OssSiteManageService ossSiteManageService;
	
	/**
     * 쿠폰 리스트
     * @param cpsVO
     * @param cpVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/couponList.do")
    public String socialProductList(@ModelAttribute("searchVO") CPSVO cpsVO,
    			@ModelAttribute("CPVO")  CPVO cpVO,
							ModelMap model){
		log.info("/mas/couponList.do 호출");
		
		cpsVO.setPageUnit(propertiesService.getInt("pageUnit"));
		cpsVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(cpsVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cpsVO.getPageUnit());
		paginationInfo.setPageSize(cpsVO.getPageSize());

		cpsVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cpsVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cpsVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 업체 정보
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		cpsVO.setCorpId(corpInfo.getCorpId());
				
		Map<String, Object> resultMap = ossCouponService.selectCouponList(cpsVO);
		
		@SuppressWarnings("unchecked")
		List<CPVO> resultList = (List<CPVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
				
		return "mas/coupon/couponList";
	}
    
    /**
     *쿠폰 등록 화면
     * @param cpVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/viewInsertCoupon.do")
    public String viewInsertCoupon(@ModelAttribute("CPVO")  CPVO cpVO, 
							ModelMap model) throws Exception{
    	log.info("/mas/viewInsertCoupon.do 호출");
    	
		List<CDVO> prdtCtgrList = ossCmmService.selectCode(Constant.CORP_CD);
		model.addAttribute("prdtCtgrList", prdtCtgrList);
		
		DFTINFVO dftInfoVO = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);
		model.addAttribute("dftInfoVO", dftInfoVO);
		
		// 업체 정보
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		cpVO.setCorpId(corpInfo.getCorpId());
		model.addAttribute("corpCd", corpInfo.getCorpCd());
		
    	return "mas/coupon/insertCoupon";
    }
    
    /**
     * 쿠폰 등록
     * @param cpVO
     * @param bindingResult
     * @param multiRequest
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/insertCoupon.do")
    public String insertCoupon(@ModelAttribute("CPVO") CPVO cpVO, BindingResult bindingResult,
    						final MultipartHttpServletRequest multiRequest,
							ModelMap model) throws Exception{
    	log.info("/mas/insertCoupon.do 호출");
    	
    	// validation 체크
		beanValidator.validate(cpVO, bindingResult);

		if (bindingResult.hasErrors()) {
			log.info("error");
			log.info(bindingResult.toString());
			List<CDVO> prdtCtgrList = ossCmmService.selectCode(Constant.CORP_CD);
			model.addAttribute("prdtCtgrList", prdtCtgrList);
			return "mas/coupon/insertCoupon";
		}
    	
		Map<String, Object> imgValidateMap = ossFileUtilService.validateImgFile(multiRequest);

		if (!(Boolean) imgValidateMap.get("validateChk")) {
			log.info("이미지 파일 에러");
			model.addAttribute("fileError", imgValidateMap.get("message"));
			return "mas/coupon/insertCoupon";
		}
		
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		cpVO.setRegId(corpInfo.getUserId());
		cpVO.setRegIp(corpInfo.getLastLoginIp());
		cpVO.setModId(corpInfo.getUserId());
		cpVO.setModIp(corpInfo.getLastLoginIp());
		
		String cpId = ossCouponService.insertCoupon(cpVO, multiRequest);
					
		if (cpVO.getPrdtNum() != null) {
			CPPRDTVO cpPrdtVO = new CPPRDTVO();
			for (int i=0; i<cpVO.getPrdtNum().size(); i++) {
				cpPrdtVO.setCpId(cpId);
				cpPrdtVO.setPrdtNum(cpVO.getPrdtNum().get(i));
				
				if (Constant.CP_DIS_DIV_FREE.equals(cpVO.getDisDiv())) {
					cpPrdtVO.setPrdtUseNum(cpVO.getPrdtUseNum().get(i));
					cpPrdtVO.setOptSn(cpVO.getOptSn().get(i));
					cpPrdtVO.setOptDivSn(cpVO.getOptDivSn().get(i));
				}
				
				ossCouponService.insertCouponPrdt(cpPrdtVO);
			}
		}
		
    	return "redirect:/mas/couponList.do";
    }
    
    /**
     * 쿠폰 수정 화면
     * @param cpVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/viewUpdateCoupon.do")
    public String viewUpdateCoupon(@ModelAttribute("CPVO")  CPVO cpVO, 
			ModelMap model) throws Exception{
		log.info("/mas/viewUpdateCoupon.do 호출");
		
		List<CDVO> prdtCtgrList = ossCmmService.selectCode(Constant.CORP_CD);
		model.addAttribute("prdtCtgrList", prdtCtgrList);
		
		CPVO resultVO = ossCouponService.selectByCoupon(cpVO);
		model.addAttribute("cpVO", resultVO);
		
		DFTINFVO dftInfoVO = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);
		model.addAttribute("dftInfoVO", dftInfoVO);
		
		List<USERVO> userList = ossCouponService.selectCouponUserList(resultVO.getCpId());
		model.addAttribute("userList", userList);
		
		// 쿠폰 매핑 상품 정보 가져오기.
		List<CPPRDTVO> cpPrdtList = ossCouponService.selectCouponPrdtList(resultVO);
		model.addAttribute("cpPrdtList", cpPrdtList);
		
		// 업체 정보
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		cpVO.setCorpId(corpInfo.getCorpId());
		model.addAttribute("corpCd", corpInfo.getCorpCd());
		
		return "mas/coupon/updateCoupon";
	}
    
    /**
     * 쿠폰 수정
     * @param cpVO
     * @param bindingResult
     * @param multiRequest
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/updateCoupon.do")
    public String updateCoupon(@ModelAttribute("CPVO")  CPVO cpVO, BindingResult bindingResult,
    						final MultipartHttpServletRequest multiRequest,
							ModelMap model) throws Exception{
    	log.info("/mas/updateCoupon.do 호출");
    	// validation 체크
		beanValidator.validate(cpVO, bindingResult);

		if (bindingResult.hasErrors()) {
			log.info("error");
			log.info(bindingResult.toString());
			List<CDVO> prdtCtgrList = ossCmmService.selectCode(Constant.CORP_CD);
			model.addAttribute("prdtCtgrList", prdtCtgrList);
			model.addAttribute("cpVO", cpVO);
			return "mas/coupon/insertCoupon";
		}
    	
		Map<String, Object> imgValidateMap = ossFileUtilService.validateImgFile(multiRequest);

		if (!(Boolean) imgValidateMap.get("validateChk")) {
			log.info("이미지 파일 에러");
			model.addAttribute("fileError", imgValidateMap.get("message"));
			return "mas/coupon/updateCoupon";
		}
		
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		cpVO.setModId(corpInfo.getUserId());
		cpVO.setModIp(corpInfo.getLastLoginIp());
		
		ossCouponService.updateCoupon(cpVO, multiRequest);
		
		// 쿠폰 관련 상품 삭제 후 등록
		ossCouponService.deleteCouponPrdtList(cpVO.getCpId());
		if (cpVO.getPrdtNum() != null) {
			CPPRDTVO cpPrdtVO = new CPPRDTVO();
			for (int i=0; i<cpVO.getPrdtNum().size(); i++) {
				cpPrdtVO.setCpId(cpVO.getCpId());
				cpPrdtVO.setPrdtNum(cpVO.getPrdtNum().get(i));
				
				if (Constant.CP_DIS_DIV_FREE.equals(cpVO.getDisDiv())) {
					cpPrdtVO.setPrdtUseNum(cpVO.getPrdtUseNum().get(i));
					cpPrdtVO.setOptSn(cpVO.getOptSn().get(i));
					cpPrdtVO.setOptDivSn(cpVO.getOptDivSn().get(i));
				}
				
				ossCouponService.insertCouponPrdt(cpPrdtVO);
			}
		}
		
    	return "redirect:/mas/couponList.do";
    }
    
    /**
     * 쿠폰 삭제
     * @param cpVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/deleteCoupon.ajax")
    public ModelAndView deleteCoupon(@ModelAttribute("CPVO") CPVO cpVO, ModelMap model) {
    	log.info("/mas/deleteCoupon.ajax call");
    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	CPVO resultVO = ossCouponService.selectByCoupon(cpVO);
    	
    	if(resultVO == null || resultVO.getUseNum() > 0) {
    		resultMap.put("resultCode", Constant.JSON_FAIL);
			ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
			return modelAndView;
    	}
    	
    	// 쿠폰 관련 상품 삭제
    	ossCouponService.deleteCouponPrdtList(cpVO.getCpId());
    	
    	ossCouponService.deleteCoupon(cpVO);
    				
    	resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
    	
		return modelAndView;
    }
    
    @RequestMapping("/mas/detailCoupon.do")
    public String viewCoupon(@ModelAttribute("CPVO")  CPVO cpVO, 
			ModelMap model) throws Exception{
		log.info("/mas/detailCoupon.do 호출");
		
		List<CDVO> prdtCtgrList = ossCmmService.selectCode(Constant.CORP_CD);
		model.addAttribute("prdtCtgrList", prdtCtgrList);
		
		CPVO resultVO = ossCouponService.selectByCoupon(cpVO);
		resultVO.setSimpleExp(EgovStringUtil.checkHtmlView(resultVO.getSimpleExp()));
		model.addAttribute("cpVO", resultVO);
		
		List<USERVO> userList = ossCouponService.selectCouponUserList(resultVO.getCpId());
		model.addAttribute("userList", userList);
		
		// 쿠폰 매핑 상품 정보 가져오기.
		List<CPPRDTVO> cpPrdtList = ossCouponService.selectCouponPrdtList(resultVO);
		model.addAttribute("cpPrdtList", cpPrdtList);
		
		return "mas/coupon/detailCoupon";
	}
    
    @RequestMapping("/mas/cancelCoupon.do")
    public String cancelCoupon(@ModelAttribute("CPVO")  CPVO cpVO, 
			ModelMap model) throws Exception{
		log.info("/mas/cancelCoupon.do 호출");
		
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		cpVO.setModId(corpInfo.getUserId());
		cpVO.setModIp(corpInfo.getLastLoginIp());
		
		cpVO.setStatusCd(Constant.STATUS_CD_CANCEL);
		ossCouponService.updateStatusByCoupon(cpVO);
		
		return "redirect:/mas/couponList.do";
	}
    
    @RequestMapping("/mas/completeCoupon.do")
    public String complateCoupon(@ModelAttribute("CPVO")  CPVO cpVO, 
			ModelMap model) throws Exception{
		log.info("/mas/completeCoupon.do 호출");
		
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		cpVO.setModId(corpInfo.getUserId());
		cpVO.setModIp(corpInfo.getLastLoginIp());
		
		cpVO.setStatusCd(Constant.STATUS_CD_COMPLETE);
		ossCouponService.updateStatusByCoupon(cpVO);
		
		return "redirect:/mas/couponList.do";
	}
}
