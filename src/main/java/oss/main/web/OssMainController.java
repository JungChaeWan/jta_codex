package oss.main.web;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import common.Constant;
import common.CountManager;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import mas.prmt.service.MasPrmtService;
import mas.prmt.vo.PRMTVO;
import oss.bbs.service.OssBbsService;
import oss.corp.service.OssCorpPnsReqService;
import oss.corp.vo.CMSSVO;
import oss.corp.vo.CORP_PNSREQVO;
import oss.monitoring.service.OssMntrService;
import oss.prdt.service.OssPrdtService;
import oss.prdt.vo.PRDTVO;
import oss.rsv.service.OssRsvService;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;
import web.bbs.service.WebBbsService;
import web.bbs.vo.NOTICESVO;
import web.bbs.vo.NOTICEVO;
import web.main.service.WebMainService;
import web.order.vo.RSVSVO;
import web.order.vo.RSVVO;

/**
 * @author 최영철
 * @since  2015. 9. 16.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@Controller
public class OssMainController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
    
	@Resource(name="ossUserService")
	protected OssUserService ossUserService;
	
	@Resource(name="webBbsService")
    private WebBbsService webBbsService;
		
	@Resource(name="ossCorpPnsReqService")
    private OssCorpPnsReqService ossCorpPnsReqService;
	
	@Resource(name="ossPrdtService")
    private OssPrdtService ossPrdtService;
	
	@Resource(name="masPrmtService")
    private MasPrmtService masPrmtService;

	@Resource(name="ossBbsService")
    private OssBbsService ossBbsService;
	
	@Resource(name="ossRsvService")
    private OssRsvService ossRsvService;

	@Autowired
	private OssMntrService ossMntrService;

	@Autowired
	private WebMainService webMainService;
	
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    		
    @RequestMapping("/oss/head.do")
    public String ossHead(	@RequestParam Map<String, String> params,
    						ModelMap model, HttpServletRequest request){
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(60*60*2); // 3시간
    	model.addAttribute("menuNm", params.get("menu"));
		USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		model.addAttribute("userNm", loginVO.getUserNm());

		//파트너 관리자 init
		String rtnHead = "/oss/headPartner";
		//탐나오 관리자
		if ("tamnao".equals(loginVO.getPartnerCode())){
			rtnHead = "/oss/head";
		}
    	return rtnHead;
    }
    
    @RequestMapping("/oss/left.do")
    public String ossLeft(	@RequestParam Map<String, String> params,
				    		ModelMap model){
    	USERVO loginInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
    	model.addAttribute("menuNm", params.get("menu"));
    	model.addAttribute("subNm", params.get("sub"));
    	model.addAttribute("loginInfo", loginInfo);

		//탐나오 관리자
		USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		String rtnHead = "/oss/leftPartner";
		if ("tamnao".equals(loginVO.getPartnerCode())){
			rtnHead = "/oss/left";
		}
    	return rtnHead;
    }
    
    @RequestMapping("/oss/intro.do")
    public String intro(){
    	return "/oss/intro";
    }
    
    @RequestMapping("/oss/home.do")
    public String home(ModelMap model){

    	/** 업체공지사항 */
    	NOTICESVO notiSVO = new NOTICESVO();
    	notiSVO.setsBbsNum("MASNOTI");
    	notiSVO.setLastIndex(4);
		List<NOTICEVO> manotiList = webBbsService.selectListMain(notiSVO);
		model.addAttribute("masnotiList", manotiList);

		/** 업체QA */
    	notiSVO.setsBbsNum("MASQA");
    	notiSVO.setLastIndex(4);
		List<NOTICEVO> masqaList = webBbsService.selectListMain(notiSVO);
		model.addAttribute("masqaList", masqaList);
    	
    	/** 신청업체수 */
		CORP_PNSREQVO corpPnsReqVO = new CORP_PNSREQVO();
		int nCntCorpPns = ossCorpPnsReqService.getCntCorpPnsMain(corpPnsReqVO);
		model.addAttribute("cntCorpPns", nCntCorpPns);

		PRDTVO prdtVO = new PRDTVO();
		prdtVO.setTradeStatus(Constant.TRADE_STATUS_APPR_REQ);
		
		/** 실시간 상풍 신청 수 */
		int nCntRTPrdt = ossPrdtService.getCntRTPrdtMain(prdtVO);
		model.addAttribute("cntRTPrdt", nCntRTPrdt);
		
		/** 소셜 상품 신청 수 */
		int nCntSPPrdt = ossPrdtService.getCntSPPrdtMain(prdtVO);
		model.addAttribute("cntSPPrdt", nCntSPPrdt);
		
		/** 기념품 상품 신청 수 */
		int nCntSVPrdt = ossPrdtService.getCntSVPrdtMain(prdtVO);
		model.addAttribute("cntSVPrdt", nCntSVPrdt);

		prdtVO.setTradeStatus(Constant.TRADE_STATUS_STOP_REQ);

		/** 실시간 상풍 판매중지요청 수 */
		int nCntRTPrdtStop = ossPrdtService.getCntRTPrdtMain(prdtVO);
		model.addAttribute("nCntRTPrdtStop", nCntRTPrdtStop);

		/** 소셜 상품 판매중지요청 수 */
		int nCntSPPrdtStop = ossPrdtService.getCntSPPrdtMain(prdtVO);
		model.addAttribute("nCntSPPrdtStop", nCntSPPrdtStop);

		/** 기념품 상품 판매중지요청 수 */
		int nCntSVPrdtStop = ossPrdtService.getCntSVPrdtMain(prdtVO);
		model.addAttribute("nCntSVPrdtStop", nCntSVPrdtStop);
		
		/** 프로모션 신청 수 */
		PRMTVO prmtVO = new PRMTVO();
		prmtVO.setStatusCd(Constant.TRADE_STATUS_APPR_REQ);
		int nCntPrmt = masPrmtService.getCntPrmtOssMain(prmtVO);
		model.addAttribute("cntPrmt", nCntPrmt);

		/** 오늘 예약수 */
		RSVVO rsvVO = new RSVVO();
		rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_COM);
		int nCntRsv = ossRsvService.getRsvOssMain(rsvVO);
		model.addAttribute("cntRsv", nCntRsv);

		/** 무통장입금 환불 요청건 */
		int nCntRfAcc = ossPrdtService.getCntRfAcc(prdtVO);
		model.addAttribute("nCntRfAcc", nCntRfAcc);

		/** 디자인 요청건 */
		NOTICEVO notiSVO2 = new NOTICEVO();
		int nCntAdmCmtYn = webBbsService.getCntAdmCmtYn(notiSVO2);
		model.addAttribute("nCntAdmCmtYn", nCntAdmCmtYn);
		
		RSVSVO rsvSVO = new RSVSVO();
		
		/** 실시간 상품 취소요청건 */
		rsvSVO.setsRsvStatusCd("RS10"); //취소요청
		int nCntRsvCancel = ossRsvService.getCntRsvList(rsvSVO);
		model.addAttribute("nCntRsvCancel", nCntRsvCancel);
		
		/** 특산기념품 취소요청건 */
		rsvSVO.setsPrdtCd("SV");
		int nCntRsvSvCancel = ossRsvService.getCntRsvList(rsvSVO);
		model.addAttribute("nCntRsvSvCancel", nCntRsvSvCancel);

		/** 특산기념품 취소요청건 */
		rsvSVO.setsRsvStatusCd("RS02"); //결제완료
		int nCntRsvSvRS02 = ossRsvService.getCntRsvList(rsvSVO);
		model.addAttribute("nCntRsvSvRS02", nCntRsvSvRS02);

		/** TL린칸 취소 오류건 **/
		int nCntTLRsvErr = ossMntrService.getCntTLRsvErr();
		model.addAttribute("nCntTLRsvErr", nCntTLRsvErr);

		model.addAttribute("isConCnt", CountManager.getCount());

    	return "/oss/home";
    }
    
    /**
     * 협회 관리자 로그인
     * 파일명 : actionOssLogin
     * 작성일 : 2015. 10. 15. 오후 1:48:16
     * 작성자 : 최영철
     * @param loginVO
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/actionOssLogin.do")
    public String actionOssLogin(	@ModelAttribute("loginVO") USERVO loginVO, 
						            HttpServletRequest request,
						            ModelMap model) throws Exception{

    	//포인트관리 에서 파트너 관리자 바로가기 2023.07.20 chaewan.jung
		USERVO previousLoginVO  = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		boolean previousLoginCheck = false;
		if (previousLoginVO != null){
			if ("ADMIN".equals(previousLoginVO.getAuthNm())  && "tamnao".equals(previousLoginVO.getPartnerCode()) && request.getHeader("REFERER").contains("couponList.do")){
				previousLoginCheck = true;
			}
		}

		if (previousLoginCheck){
			previousLoginVO.setPartnerCode(loginVO.getPartnerCode());

			request.getSession().setAttribute("ossLoginVO", previousLoginVO);
			request.getSession().setAttribute("userVO", previousLoginVO);
			return "redirect:/oss/pointUsageInfo.do";
		}
		else {
			if (EgovStringUtil.isEmpty(loginVO.getEmail())) {
				model.addAttribute("failLogin", "1");
				return "/oss/intro";
			}
			if (EgovStringUtil.isEmpty(loginVO.getPwd())) {
				model.addAttribute("failLogin", "2");
				return "/oss/intro";
			}
			// 접속 IP
			String userIp = EgovClntInfo.getClntIP(request);
			loginVO.setLastLoginIp(userIp);

			if ("".equals(loginVO.getPartnerCode())) {
				loginVO.setPartnerCode("tamnao");
			}

			// 1. 관리자 로그인 처리
			USERVO resultVO = ossUserService.actionOssLogin(loginVO);

			if (resultVO != null && resultVO.getUserId() != null && !resultVO.getUserId().equals("")) {
				resultVO.setLastLoginIp(userIp);
				request.getSession().setAttribute("ossLoginVO", resultVO);
				request.getSession().setAttribute("userVO", resultVO);

				String rtnUrl = "/oss/pointUsageInfo.do";
				if ("tamnao".equals(loginVO.getPartnerCode()) || "".equals(loginVO.getPartnerCode()) || loginVO.getPartnerCode() == null) {
					rtnUrl = "/oss/home.do";
				}

				return "redirect:" + rtnUrl;
			} else {
				model.addAttribute("failLogin", "Y");
				model.addAttribute("email", loginVO.getEmail());
				return "/oss/intro";
			}
		}
    }
    
    /**
     * 협회 관리자 로그아웃
     * 파일명 : ossLogout
     * 작성일 : 2015. 10. 15. 오후 1:48:26
     * 작성자 : 최영철
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/oss/ossLogout.do")
	public String ossLogout(HttpServletRequest request, ModelMap model){
		
		request.getSession().setAttribute("ossLoginVO", null);
		request.getSession().setAttribute("userVO", null);
		
		return "oss/intro";
	}

	@RequestMapping("/oss/tamnaoPartners.do")
	public String tamnaoPartners(@ModelAttribute("searchVO") USERVO searchVO, ModelMap model){
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

		Map<String, Object> resultMap = webMainService.selectTamnaoPartners(searchVO);

		@SuppressWarnings("unchecked")
		List<USERVO> tamnaoPartnersList = (List<USERVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", tamnaoPartnersList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "oss/corp/tamnaoPartnersList";
	}

	@RequestMapping("/oss/selectTamnaoPartner.ajax")
	public ModelAndView selectTamnaoPartner(@ModelAttribute("searchVO") USERVO userVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		userVO = webMainService.selectTamnaoPartner(userVO);
		resultMap.put("result",userVO);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	@RequestMapping("/oss/insertTamnaoPartner.ajax")
	public ModelAndView insertTamnaoPartner(@ModelAttribute("searchVO") USERVO userVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		Map<String, Object> result = webMainService.selectTamnaoPartners(userVO);
		int resultCnt = (int) result.get("totalCnt");

		if(resultCnt > 0){
			resultMap.put("result", "N");
			resultMap.put("resultMsg", "동일한 코드가 존재합니다.");
		}else{
			webMainService.insertTamnaoPartner(userVO);
			resultMap.put("result", "Y");
			resultMap.put("resultMsg", "저장하였습니다.");
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	@RequestMapping("/oss/updateTamnaoPartner.ajax")
	public ModelAndView updateTamnaoPartner(@ModelAttribute("searchVO") USERVO userVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		webMainService.updateTamnaoPartner(userVO);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	@RequestMapping("/oss/deleteTamnaoPartner.ajax")
	public ModelAndView deleteTamnaoPartner(@ModelAttribute("searchVO") USERVO userVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		webMainService.deleteTamnaoPartner(userVO);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	@RequestMapping("/oss/partnerAnls.ajax")
	public ModelAndView partnerAnls(@ModelAttribute("searchVO") USERVO userVO){
		
		Map<String, Object> resultMap = webMainService.partnerAnls(userVO);
		
		@SuppressWarnings("unchecked")
		List<USERVO> tamnaoPartnersList = (List<USERVO>) resultMap.get("resultList");
		
		resultMap.put("resultList", tamnaoPartnersList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
}
