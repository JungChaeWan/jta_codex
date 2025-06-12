package oss.coupon.web;

import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.service.OssMailService;
import oss.cmm.vo.CDVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPPRDTVO;
import oss.coupon.vo.CPSVO;
import oss.coupon.vo.CPVO;
import oss.env.service.OssSiteManageService;
import oss.env.vo.DFTINFVO;
import oss.user.vo.USERVO;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class OssCouponController {
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

    @Resource(name="ossMailService")
    private OssMailService ossMailService;

    /**
     * 쿠폰 리스트
     * @param cpsVO
     * @param cpVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/couponList.do")
    public String couponList(@ModelAttribute("searchVO") CPSVO cpsVO,
                             @ModelAttribute("CPVO") CPVO cpVO,
                             ModelMap model) {
    //			log.info("/oss/couponList.do 호출");
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

        cpsVO.setCpDiv(cpVO.getCpDiv());

        Map<String, Object> resultMap = ossCouponService.selectCouponList(cpsVO);

        List<CPVO> resultList = (List<CPVO>) resultMap.get("resultList");
        model.addAttribute("resultList", resultList);

        // 총 건수 셋팅
        model.addAttribute("totalCnt", resultMap.get("totalCnt"));

        paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
        model.addAttribute("paginationInfo", paginationInfo);

        // 수량 제한 타입
        List<CDVO> limitTypeList = ossCmmService.selectCode(Constant.CP_LIMIT_TYPE);
        Map<String, String> limitTypeMap = new HashMap<String, String>();
        for(CDVO limitType : limitTypeList) {
            limitTypeMap.put(limitType.getCdNum(), limitType.getCdNm());
        }
        model.addAttribute("limitTypeMap", limitTypeMap);

        return "oss/coupon/couponList";
    }

    /**
     *쿠폰 등록 화면
     * @param cpVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/viewInsertCoupon.do")
    public String viewInsertCoupon(@ModelAttribute("CPVO") CPVO cpVO,
                                   ModelMap model) {
//        log.info("/oss/viewInsertCoupon.do 호출");
        List<CDVO> prdtCtgrList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
        model.addAttribute("prdtCtgrList", prdtCtgrList);

        DFTINFVO dftInfoVO = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);
        model.addAttribute("dftInfoVO", dftInfoVO);

        // 수량 제한 타입
        List<CDVO> limitTypeList = ossCmmService.selectCode(Constant.CP_LIMIT_TYPE);
        model.addAttribute("limitTypeList", limitTypeList);

        CPSVO cpsVO = new CPSVO();
		cpsVO.setFirstIndex(0);
		cpsVO.setLastIndex(99999);
        Map<String, Object> resultMap = ossCouponService.selectCouponList(cpsVO);
		List<CPVO> resultList = (List<CPVO>) resultMap.get("resultList");
		model.addAttribute("resultList", resultList);

        return "oss/coupon/insertCoupon";
    }

    /**
     * 쿠폰 등록
     * @param cpVO
     * @param multiRequest
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/insertCoupon.do")
    public String insertCoupon(@ModelAttribute("CPVO") CPVO cpVO,
                                final MultipartHttpServletRequest multiRequest) throws Exception {
//        log.info("/oss/insertCoupon.do 호출");

        USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
        cpVO.setRegId(corpInfo.getUserId());
        cpVO.setRegIp(corpInfo.getLastLoginIp());
        cpVO.setModId(corpInfo.getUserId());
        cpVO.setModIp(corpInfo.getLastLoginIp());

        String cpId = ossCouponService.insertCoupon(cpVO, multiRequest);

        CPPRDTVO cpPrdtVO = new CPPRDTVO();
        cpPrdtVO.setCpId(cpId);
        if("AP02".equals(cpVO.getAplprdtDiv())) {
            for(int i = 0; i < cpVO.getPrdtNum().size(); i++) {
                cpPrdtVO.setPrdtNum(cpVO.getPrdtNum().get(i));

                if(Constant.CP_DIS_DIV_FREE.equals(cpVO.getDisDiv())) {
                    cpPrdtVO.setPrdtUseNum(cpVO.getPrdtUseNum().get(i));
                    cpPrdtVO.setOptSn(cpVO.getOptSn().get(i));
                    cpPrdtVO.setOptDivSn(cpVO.getOptDivSn().get(i));
                }
                ossCouponService.insertCouponPrdt(cpPrdtVO);
            }
        }

        if("AP03".equals(cpVO.getAplprdtDiv())) {
            for(int i = 0; i < cpVO.getCorpNum().size(); i++) {
                cpPrdtVO.setCorpId(cpVO.getCorpNum().get(i));
                ossCouponService.insertCouponCorp(cpPrdtVO);
            }
        }
        return "redirect:/oss/couponList.do?cpDiv=" + cpVO.getCpDiv();
    }

    /**
     * 쿠폰 수정 화면
     * @param cpVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/viewUpdateCoupon.do")
    public String viewUpdateCoupon(@ModelAttribute("CPVO") CPVO cpVO,
                                    ModelMap model) {
//        log.info("/oss/viewUpdateCoupon.do 호출");
        List<CDVO> prdtCtgrList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
        model.addAttribute("prdtCtgrList", prdtCtgrList);

        CPVO resultVO = ossCouponService.selectByCoupon(cpVO);
        model.addAttribute("cpVO", resultVO);

        DFTINFVO dftInfoVO = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);
        model.addAttribute("dftInfoVO", dftInfoVO);

        List<USERVO> userList = null;
        // 전체 대상 쿠폰은 사용자 목록 제외
        if(!"ALL".equals(resultVO.getTgtDiv())) {
            userList = ossCouponService.selectCouponUserList(resultVO.getCpId());
        }
        model.addAttribute("userList", userList);

        // 쿠폰 매핑 상품 정보 가져오기.
        List<CPPRDTVO> cpPrdtList = ossCouponService.selectCouponPrdtList(resultVO);
        model.addAttribute("cpPrdtList", cpPrdtList);

        // 쿠폰 매핑 업체 정보 가져오기.
        List<CPPRDTVO> cpCorpList = ossCouponService.selectCouponCorpListWeb(resultVO);
        model.addAttribute("cpCorpList", cpCorpList);

        // 수량 제한 타입
        List<CDVO> limitTypeList = ossCmmService.selectCode(Constant.CP_LIMIT_TYPE);
        model.addAttribute("limitTypeList", limitTypeList);

        CPSVO cpsVO = new CPSVO();
		cpsVO.setFirstIndex(0);
		cpsVO.setLastIndex(99999);
        Map<String, Object> resultMap = ossCouponService.selectCouponList(cpsVO);
		List<CPVO> resultList = (List<CPVO>) resultMap.get("resultList");
		model.addAttribute("resultList", resultList);

        return "oss/coupon/updateCoupon";
    }

    /**
     * 쿠폰 수정
     * @param cpVO
     * @param multiRequest
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/updateCoupon.do")
    public String updateCoupon(@ModelAttribute("CPVO") CPVO cpVO,
                               final MultipartHttpServletRequest multiRequest) throws Exception {
        log.info("/oss/updateCoupon.do 호출");
        USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
        cpVO.setModId(corpInfo.getUserId());
        cpVO.setModIp(corpInfo.getLastLoginIp());

        if(!Constant.STATUS_CD_COMPLETE.equals(cpVO.getStatusCd())) {
            ossCouponService.updateCoupon(cpVO, multiRequest);

            // 관련 상품/업체 삭제 후 등록
            ossCouponService.deleteCouponPrdtList(cpVO.getCpId());
            ossCouponService.deleteCouponCorpList(cpVO.getCpId());

            CPPRDTVO cpPrdtVO = new CPPRDTVO();
            cpPrdtVO.setCpId(cpVO.getCpId());
            if("AP02".equals(cpVO.getAplprdtDiv())) {
                for(int i = 0; i < cpVO.getPrdtNum().size(); i++) {
                    cpPrdtVO.setPrdtNum(cpVO.getPrdtNum().get(i));
                    if(Constant.CP_DIS_DIV_FREE.equals(cpVO.getDisDiv())) {
                        cpPrdtVO.setPrdtUseNum(cpVO.getPrdtUseNum().get(i));
                        cpPrdtVO.setOptSn(cpVO.getOptSn().get(i));
                        cpPrdtVO.setOptDivSn(cpVO.getOptDivSn().get(i));
                    }
                    ossCouponService.insertCouponPrdt(cpPrdtVO);
                }
            }

            if("AP03".equals(cpVO.getAplprdtDiv())) {
                for(int i = 0; i < cpVO.getCorpNum().size(); i++) {
                    cpPrdtVO.setCorpId(cpVO.getCorpNum().get(i));
                    ossCouponService.insertCouponCorp(cpPrdtVO);
                }
            }

        } else {
            ossCouponService.updateCoupon2(cpVO);       // 제한수량 수정
        }
        return "redirect:/oss/couponList.do?cpDiv=" + cpVO.getCpDiv();
    }

    @RequestMapping("/oss/addUserCp.do")
    public String addUserCp(@ModelAttribute("CPVO") CPVO cpVO
                               ) throws Exception {
        log.info("/oss/addUserCp.do 호출");
        ossCouponService.insertUserAddCouponByCpId(cpVO);
        return "redirect:/oss/detailCoupon.do?cpId=" + cpVO.getCpId();
    }

    /**
     * 쿠폰 삭제
     * @param cpVO
     * @return
     */
    @RequestMapping("/oss/deleteCoupon.ajax")
    public ModelAndView deleteCoupon(@ModelAttribute("CPVO") CPVO cpVO) {
//        log.info("/oss/deleteCoupon.ajax call");
        Map<String, Object> resultMap = new HashMap<String, Object>();

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

    @RequestMapping("/oss/detailCoupon.do")
    public String viewCoupon(@ModelAttribute("CPVO") CPVO cpVO,
                             ModelMap model) {
//        log.info("/oss/detailCoupon.do 호출");
        List<CDVO> prdtCtgrList = ossCmmService.selectCode(Constant.CORP_MOD_CD);

        model.addAttribute("prdtCtgrList", prdtCtgrList);

        CPVO resultVO = ossCouponService.selectByCoupon(cpVO);

        resultVO.setSimpleExp(EgovStringUtil.checkHtmlView(resultVO.getSimpleExp()));

        model.addAttribute("cpVO", resultVO);

        List<USERVO> userList = null;
        // 전체 대상 쿠폰은 사용자 목록 제외
        if(!"ALL".equals(resultVO.getTgtDiv())) {
            userList = ossCouponService.selectCouponUserList(resultVO.getCpId());
        }
        model.addAttribute("userList", userList);

        // 쿠폰 매핑 상품 정보 가져오기.
        List<CPPRDTVO> cpPrdtList = ossCouponService.selectCouponPrdtList(resultVO);
        model.addAttribute("cpPrdtList", cpPrdtList);

        // 쿠폰 매핑 업체 정보 가져오기.
        List<CPPRDTVO> cpCorpList = ossCouponService.selectCouponCorpListWeb(resultVO);
        model.addAttribute("cpCorpList", cpCorpList);

        // 수량 제한 타입
        List<CDVO> limitTypeList = ossCmmService.selectCode(Constant.CP_LIMIT_TYPE);
        model.addAttribute("limitTypeList", limitTypeList);
        
        //할인율 : 사용금액총합
        int PctSumAmt = ossCouponService.selectPctAmtByCoupon(cpVO.getCpId());
        model.addAttribute("PctSumAmt", PctSumAmt);
        
        return "oss/coupon/detailCoupon";
    }

    @RequestMapping("/oss/cancelCoupon.do")
    public String cancelCoupon(@ModelAttribute("CPVO") CPVO cpVO) {
//        log.info("/oss/cancelCoupon.do 호출");
        USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();

        cpVO.setModId(corpInfo.getUserId());
        cpVO.setModIp(corpInfo.getLastLoginIp());
        cpVO.setStatusCd(Constant.STATUS_CD_CANCEL);

        ossCouponService.updateStatusByCoupon(cpVO);

        return "redirect:/oss/couponList.do?cpDiv=" + cpVO.getCpDiv();
    }

    @RequestMapping("/oss/completeCoupon.do")
    public String complateCoupon(@ModelAttribute("CPVO") CPVO cpVO) {
//        log.info("/oss/completeCoupon.do 호출");
        USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();

        cpVO.setModId(corpInfo.getUserId());
        cpVO.setModIp(corpInfo.getLastLoginIp());
        cpVO.setStatusCd(Constant.STATUS_CD_COMPLETE);

        ossCouponService.updateStatusByCoupon(cpVO);

        return "redirect:/oss/couponList.do?cpDiv=" + cpVO.getCpDiv();
    }

    /**
     * 쿠폰 메일 발송
     * @param cpVO
     * @return
     * @throws ParseException
     */
    @RequestMapping("/oss/vipBestUserSendMail.ajax")
    public ModelAndView vipBestUserSendMail(@ModelAttribute("CPVO") CPVO cpVO) throws ParseException {
//        log.info("/oss/vipBestUserSendMail.ajax call");
        ossMailService.vipBestUserSendMail(cpVO);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("resultCode", Constant.JSON_SUCCESS);

        ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

        return modelAndView;
    }
}
