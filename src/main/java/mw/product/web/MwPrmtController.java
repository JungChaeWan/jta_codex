package mw.product.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mas.prmt.service.MasPrmtService;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.prmt.vo.PRMTCMTVO;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import oss.ad.vo.AD_WEBLISTSVO;
import oss.ad.vo.AD_WEBLISTVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpService;
import oss.prmt.vo.PRMTFILEVO;
import oss.user.vo.USERVO;
import web.mypage.service.WebMypageService;
import web.product.service.WebAdProductService;
import web.product.service.WebPrmtService;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;
import web.product.service.WebSvProductService;
import web.product.vo.WEB_SPPRDTVO;
import web.product.vo.WEB_SPSVO;
import web.product.vo.WEB_SVPRDTVO;
import web.product.vo.WEB_SVSVO;

@Controller
public class MwPrmtController {

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "webPrmtService")
	protected WebPrmtService webPrmtService;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name = "webSvService")
	protected WebSvProductService webSvService;
	
	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "masPrmtService")
	private MasPrmtService masPrmtService;

	Logger log = LogManager.getLogger(this.getClass());


	@RequestMapping("/mw/evnt/promotionList.do")
	public String promotionList(@ModelAttribute("searchVO") PRMTVO prmtVO,
								ModelMap model) {
		log.info("/mw/evnt/promotionList.do");

		prmtVO.setPageUnit(propertiesService.getInt("mwPageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("mwPageSize"));
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// 이벤트 형태
		prmtVO.setPrmtDiv(Constant.PRMT_DIV_EVNT);

		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}
		// 상품 리스트
		Map<String, Object> resultMap = webPrmtService.selectPromotionList(prmtVO);
		@SuppressWarnings("unchecked")
		List<PRMTVO> resultList = (List<PRMTVO>) resultMap.get("resultList");
		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/mw/evnt/promotionList";
	}

	@RequestMapping("/mw/evnt/promotionList.ajax")
	public ModelAndView promotionListAjax(@ModelAttribute("searchVO") PRMTVO prmtVO) {
		log.info("/mw/evnt/promotionList.ajax");

		prmtVO.setPageUnit(propertiesService.getInt("mwPageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("mwPageSize"));
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// 이벤트 형태
		prmtVO.setPrmtDiv(Constant.PRMT_DIV_EVNT);

		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}
		// 상품 리스트
		Map<String, Object> resultMap = webPrmtService.selectPromotionList(prmtVO);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}
	
	@RequestMapping("/mw/evnt/prmtPlanList.do")
	public String prmtPlanList(@ModelAttribute("searchVO") PRMTVO prmtVO,
							   ModelMap model) {
		log.info("/mw/evnt/prmtPlanList.do");
		
		prmtVO.setPageUnit(propertiesService.getInt("mwPageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("mwPageSize"));
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// 기획전 형태
		prmtVO.setPrmtDiv(Constant.PRMT_DIV_PLAN);

		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}

		// prmtDiv 기본값 설정
		if (StringUtils.isBlank(prmtVO.getPrmtDiv())) {
			prmtVO.setPrmtDiv(Constant.PRMT_DIV_PLAN);
		}

		// 파라미터값이 있을 경우 덮어쓰기
		if (StringUtils.isNotBlank(prmtVO.getsPrmtDiv())) {
			prmtVO.setPrmtDiv(prmtVO.getsPrmtDiv());
		}

		// 상품 리스트
		Map<String, Object> resultMap = webPrmtService.selectPromotionList(prmtVO);
		@SuppressWarnings("unchecked")
		List<PRMTVO> resultList = (List<PRMTVO>) resultMap.get("resultList");
		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		return "mw/evnt/prmtPlanList";
	}

	@RequestMapping("/mw/evnt/prmtPlanList.ajax")
	public ModelAndView prmtPlanListAjax(@ModelAttribute("searchVO") PRMTVO prmtVO) {
		log.info("/mw/evnt/prmtPlanList.ajax");

		prmtVO.setPageUnit(propertiesService.getInt("mwPageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("mwPageSize"));
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// 기획전 형태
		prmtVO.setPrmtDiv(Constant.PRMT_DIV_PLAN);

		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}
		// 상품 리스트
		Map<String, Object> resultMap = webPrmtService.selectPromotionList(prmtVO);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	@RequestMapping("/mw/evnt/detailPromotion.do")
	public String detailPromotion(@ModelAttribute("prmtVO") PRMTVO prmtVO,
								  ModelMap model,
								  HttpServletRequest request) throws Exception {
		log.info("/mw/evnt/detailPromotion.do call");

		String prmtNum = prmtVO.getPrmtNum();
		String connIp = EgovClntInfo.getClntIP(request);  
		
		//뷰 카운트
		String iFlag = "Y";
		for(Constant.INSIDE_IP insideIp : Constant.INSIDE_IP.values()) {
			if(connIp.substring(0,3).equals(insideIp.getValue())) {
				iFlag = "N";
				break;
			}
		}
		
		if("Y".equals(iFlag)) {
			webPrmtService.updateViewCnt(prmtNum);	
		}
		
		if(EgovStringUtil.isEmpty(prmtVO.getPrmtNum())) {
			log.error("prmtNum is null");
			return "redirect:/mw/main.do";
		}

		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}
		PRMTVO resultVO = webPrmtService.selectByPrmt(prmtVO);

		resultVO.setFinishYn(prmtVO.getFinishYn());
		resultVO.setWinsYn(prmtVO.getWinsYn());

		model.addAttribute("prmtVO", resultVO);

		if(Constant.FLAG_N.equals(prmtVO.getWinsYn())) {
			int nPrdtSum = 0;
			List<PRMTPRDTVO> prmtPrdtList = new ArrayList<PRMTPRDTVO>();

			//숙박
			AD_WEBLISTSVO adWebSVO = new AD_WEBLISTSVO();
			adWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<AD_WEBLISTVO> resultAdList = webAdProductService.selectAdListOssPrmt(adWebSVO);

			nPrdtSum += resultAdList.size();

			//정렬을위한 데이터 넣기
			for (AD_WEBLISTVO data : resultAdList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("AD");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setPrintSn(data.getPrintSn());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}

			//렌터카
			RC_PRDTINFSVO rcWebSVO = new RC_PRDTINFSVO();
			rcWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<RC_PRDTINFVO> resultRcList = webRcProductService.selectWebRcPrdtListOssPrmt(rcWebSVO);

			nPrdtSum += resultRcList.size();
			//정렬을위한 데이터 넣기
			for (RC_PRDTINFVO data : resultRcList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("RC");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setPrintSn(data.getPrintSn());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}

			//소셜
			WEB_SPSVO spWebSVO = new WEB_SPSVO();
			spWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<WEB_SPPRDTVO> resultSpList = webSpService.selectProductListOssPrmt(spWebSVO);

			nPrdtSum += resultSpList.size();
			//정렬을위한 데이터 넣기
			for (WEB_SPPRDTVO data : resultSpList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("SP");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setPrintSn(data.getPrintSn());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}

			// 기념품
			WEB_SVSVO svWebSVO = new WEB_SVSVO();
			svWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<WEB_SVPRDTVO> resultSvList = webSvService.selectProductListOssPrmt(svWebSVO);

			nPrdtSum += resultSvList.size();
			//정렬을위한 데이터 넣기
			for (WEB_SVPRDTVO data : resultSvList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("SV");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setPrintSn(data.getPrintSn());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}
			model.addAttribute("prdtSum", nPrdtSum);

			//정렬
			DescPrmt descPrmt = new DescPrmt();
			Collections.sort(prmtPrdtList, descPrmt);

			model.addAttribute("prmtPrdtList", prmtPrdtList);

			// 프로모션 상품 라벨/설명
			Map<String, PRMTPRDTVO> prmtPrdtMap = new HashMap<String, PRMTPRDTVO>();

			List<PRMTPRDTVO> prmtPrdtInfoList = webPrmtService.selectPrmtPrdtList(prmtVO.getPrmtNum());

			for (PRMTPRDTVO prmtPrdt : prmtPrdtInfoList) {
				prmtPrdtMap.put(prmtPrdt.getPrdtNum(), prmtPrdt);
			}
			model.addAttribute("prmtPrdtMap", prmtPrdtMap);

			// 라벨코드
			Map<String, String> labelMap = new HashMap<String, String>();

			List<CDVO> labelCdList = ossCmmService.selectCode(Constant.PRMT_LABEL_CD);

			for(CDVO cd : labelCdList) {
				labelMap.put(cd.getCdNum(), cd.getCdNm());
			}
			model.addAttribute("labelMap", labelMap);

			// 카테고리 코드(SV, SP)
			Map<String, String> categoryMap = new HashMap<String, String>();

			List<CDVO> spCdList = ossCmmService.selectCode(Constant.CATEGORY_CD);

			for(CDVO cd : spCdList) {
				List<CDVO> sp2CdList = ossCmmService.selectCode(cd.getCdNum());

				for(CDVO cd2 : sp2CdList) {
					categoryMap.put(cd2.getCdNum(), cd2.getCdNm());
				}
			}
			List<CDVO> svCdList = ossCmmService.selectCode(Constant.SV_DIV);

			for(CDVO cd : svCdList) {
				categoryMap.put(cd.getCdNum(), cd.getCdNm());
			}
			model.addAttribute("categoryMap", categoryMap);
		}
		//로그인 체크
		model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
		
		//회원정보
		model.addAttribute("userInfo", (USERVO) EgovUserDetailsHelper.getAuthenticatedUser());
				
		return "mw/evnt/detailPromotion";
	}

	@RequestMapping("/mw/evnt/detailGovAnnouncement.do")
	public String detailGovAnnouncement(@ModelAttribute("prmtVO") PRMTVO prmtVO,
								  ModelMap model,
								  HttpServletRequest request) throws Exception {
		log.info("/mw/evnt/detailGovAnnouncement.do call");

		String prmtNum = prmtVO.getPrmtNum();
		String connIp = EgovClntInfo.getClntIP(request);

		//뷰 카운트
		String iFlag = "Y";
		for(Constant.INSIDE_IP insideIp : Constant.INSIDE_IP.values()) {
			if(connIp.substring(0,3).equals(insideIp.getValue())) {
				iFlag = "N";
				break;
			}
		}

		if("Y".equals(iFlag)) {
			webPrmtService.updateViewCnt(prmtNum);
		}

		//첨부파일 정보 가저오기
		PRMTFILEVO prmtfileVO = new PRMTFILEVO();
		prmtfileVO.setPrmtNum(prmtVO.getPrmtNum());

		List<PRMTFILEVO> prmtFileList = masPrmtService.selectPrmtFileList(prmtfileVO);
		model.addAttribute("prmtFileList", prmtFileList);

		if(EgovStringUtil.isEmpty(prmtVO.getPrmtNum())) {
			log.error("prmtNum is null");
			return "redirect:/mw/main.do";
		}

		// 공고 상세정보
		PRMTVO resultVO = webPrmtService.selectByPrmt(prmtVO);
		model.addAttribute("prmtVO", resultVO);

		//로그인 체크
		model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");

		return "mw/evnt/detailGovAnnouncement";
	}
	// 정렬 내림차순
	class DescPrmt implements Comparator<PRMTPRDTVO> {

	    @Override
	    public int compare(PRMTPRDTVO o1, PRMTPRDTVO o2) {
	    	int nPrintSn1 = 0;
	    	int nPrintSn2 = 0;

	    	if( !(o1.getPrintSn() == null || o1.getPrintSn().isEmpty() || "".equals(o1.getPrintSn())) ){
	    		nPrintSn1 = Integer.parseInt(o1.getPrintSn());
	    	}

	    	if( !(o2.getPrintSn() == null || o2.getPrintSn().isEmpty() || "".equals(o2.getPrintSn())) ){
	    		nPrintSn2 = Integer.parseInt(o2.getPrintSn());
	    	}

	    	return nPrintSn1-nPrintSn2;
	        //return o2.getName().compareTo(o1.getName());
	    }

	}

	@RequestMapping("/mw/evnt/prmtCmtList.ajax")
	public String prmtCmtList(@ModelAttribute("prmtCmtVO") PRMTCMTVO prmtCmtVO, ModelMap model) {
		log.info("mw/evnt/prmtCmtList.ajax call");

		PaginationInfo paginationInfo = new PaginationInfo();
		List<PRMTCMTVO> rmtCmtList = new ArrayList<PRMTCMTVO>();

		//로그인 체크
		USERVO userVO = new USERVO();
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");

    	if (EgovUserDetailsHelper.isAuthenticated()) {
			userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		}

		prmtCmtVO.setPageUnit(propertiesService.getInt("mwPageSize"));
		prmtCmtVO.setPageSize(propertiesService.getInt("mwPageSize"));

		/** pageing setting */
		paginationInfo.setCurrentPageNo(prmtCmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtCmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtCmtVO.getPageSize());

		prmtCmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtCmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtCmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		prmtCmtVO.setPrmtNum(prmtCmtVO.getPrmtNum());
		prmtCmtVO.setPrintYn(Constant.FLAG_Y);

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount(webPrmtService.selectPrmtCmtTotalCnt(prmtCmtVO));

		rmtCmtList = webPrmtService.selectPrmtCmtList(prmtCmtVO);

		model.addAttribute("userId", userVO.getUserId());
		model.addAttribute("rmtCmtList", rmtCmtList);
		model.addAttribute("prmtCmtVO", prmtCmtVO);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/mw/evnt/promotionCmt";
	}
}
