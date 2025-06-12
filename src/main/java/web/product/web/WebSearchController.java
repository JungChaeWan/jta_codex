package web.product.web;

import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import api.web.APIRecaptchaController;
import egovframework.cmmn.service.EgovClntInfo;
import mas.rc.vo.RC_PRDTINFSVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import oss.ad.vo.AD_WEBLISTSVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.marketing.serive.OssKwaService;
import web.product.service.WebAdProductService;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;
import web.product.service.WebSvProductService;
import web.product.vo.WEB_SPSVO;
import web.product.vo.WEB_SVSVO;
import common.Constant;
import egovframework.cmmn.service.EgovStringUtil;

@Controller
public class WebSearchController {

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name = "webSvService")
	protected WebSvProductService webSvService;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "ossKwaService")
	protected OssKwaService ossKwaService;


	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@RequestMapping("/web/cerca.do")
	public String cerca(HttpServletRequest request, HttpServletResponse response,
						 ModelMap model) throws Exception {

		HttpSession session = request.getSession();
		String clientKey = request.getParameter("tamnaoKey"); // 클라이언트가 보낸 키
		String storedKey = (String) session.getAttribute("tamnaoKey"); // 세션에 저장된 키

		// 세션 값과 클라이언트 값 비교
		if (storedKey == null || clientKey == null || !storedKey.equals(clientKey)) {
			System.out.println("탐나오 키 검증 실패: " + clientKey);
			response.sendError(HttpServletResponse.SC_FORBIDDEN, "인증이 필요합니다.");
			return null;
		}

		String search = request.getParameter("trova");

		if(search.length() >= 30){
			model.addAttribute("search", "search");
			model.addAttribute("adCnt", 0);
			model.addAttribute("rcCnt", 0);
			model.addAttribute("packageCnt", 0);
			model.addAttribute("tourCnt", 0);
			model.addAttribute("foodCnt", 0);
			model.addAttribute("svCnt", 0);
			model.addAttribute("strollerCnt", 0);
			return "/web/cmm/cerca";  // 리뉴얼 TOBE
		}

		if(EgovClntInfo.isMobile(request)) {
    		return "redirect:/mw/cerca.do?trova=" + search;
    	}
		if(EgovStringUtil.isEmpty(search)) {
			log.error("search is null");
			return "redirect:/main.do";
		}

		AD_WEBLISTSVO adPrdtSVO = new AD_WEBLISTSVO();
		adPrdtSVO.setSearchWord(search);
		Calendar calNow = Calendar.getInstance();
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		adPrdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		adPrdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
		adPrdtSVO.setsNights("1");
		adPrdtSVO.setsSearchYn(Constant.FLAG_N);
		Integer adCnt = webAdProductService.getCntAdList(adPrdtSVO);

		RC_PRDTINFSVO rcPrdtSVO = new RC_PRDTINFSVO();
		calNow =  Calendar.getInstance();
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		rcPrdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
		rcPrdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
		rcPrdtSVO.setsFromTm("1200");
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		rcPrdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
		rcPrdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
		rcPrdtSVO.setsToTm("1200");
		rcPrdtSVO.setSearchWord(search);
		rcPrdtSVO.setsMainViewYn("N");
		rcPrdtSVO.setSearchYn("Y");

		/*Integer rcCnt = webRcProductService.selectWebRcPrdtListCnt(rcPrdtSVO);*/

		WEB_SPSVO spPrdtSVO = new WEB_SPSVO();
		spPrdtSVO.setsCtgrDepth("1");
		spPrdtSVO.setsCtgr(Constant.CATEGORY_PACKAGE);
		spPrdtSVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE);
		spPrdtSVO.setsCtgrDepth("1");
		spPrdtSVO.setSearchWord(search);
		int packageCnt = webSpService.getCntProductList(spPrdtSVO);

		spPrdtSVO = new WEB_SPSVO();
		spPrdtSVO.setsCtgrDepth("1");
		spPrdtSVO.setsCtgr(Constant.CATEGORY_TOUR);
		spPrdtSVO.setsCtgrDiv(Constant.CATEGORY_TOUR);
		spPrdtSVO.setsCtgrDepth("1");
		spPrdtSVO.setSearchWord(search);
		int tourCnt = webSpService.getCntProductList(spPrdtSVO);

		spPrdtSVO = new WEB_SPSVO();
		spPrdtSVO.setsCtgrDepth("1");
		spPrdtSVO.setsCtgr(Constant.CATEGORY_ETC);
		spPrdtSVO.setsCtgrDiv(Constant.CATEGORY_ETC);
		spPrdtSVO.setsCtgrDepth("1");
		spPrdtSVO.setSearchWord(search);
		int foodCnt = webSpService.getCntProductList(spPrdtSVO);
		
		spPrdtSVO = new WEB_SPSVO();
		spPrdtSVO.setsCtgrDepth("1");
		spPrdtSVO.setsCtgr(Constant.CATEGORY_BABY_SHEET);
		spPrdtSVO.setsCtgrDiv(Constant.CATEGORY_BABY_SHEET);
		spPrdtSVO.setsCtgrDepth("1");
		spPrdtSVO.setSearchWord(search);
		int strollerCnt = webSpService.getCntProductList(spPrdtSVO);

		WEB_SVSVO svPrdtSVO = new WEB_SVSVO();
		svPrdtSVO.setSearchWord(search);
		int svCnt = webSvService.getCntProductList(svPrdtSVO);
		
		//코드 정보 얻기
    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
    	model.addAttribute("cdAdar", cdAdar);

		model.addAttribute("search", search);
		model.addAttribute("adCnt", adCnt);
		model.addAttribute("adSearch", adPrdtSVO);
		model.addAttribute("rcCnt", 0);
		model.addAttribute("rcSearch", rcPrdtSVO);
		model.addAttribute("packageCnt", packageCnt);
		model.addAttribute("tourCnt", tourCnt);
		model.addAttribute("foodCnt", foodCnt);
		model.addAttribute("svCnt", svCnt);
		model.addAttribute("strollerCnt", strollerCnt);

		//return "/web/cmm/search_old"; 리뉴얼 ASIS
		return "/web/cmm/cerca";  // 리뉴얼 TOBE
	}


	/*@RequestMapping("/web/kwaSearch.do")
	public String kwaSearch(HttpServletRequest request,
							ModelMap model) throws Exception {

		String kwaNum = request.getParameter("kwaNum");

		if(EgovClntInfo.isMobile(request)) {
			return "redirect:/mw/kwaSearch.do?kwaNum=" + kwaNum;
		}
		if(EgovStringUtil.isEmpty(kwaNum)) {
			log.error("kwaNum is null");
			return "redirect:/main.do";
		}
		//키워드 정보
		KWAVO kwaVO = new KWAVO();
		kwaVO.setKwaNum(kwaNum);

		KWAVO kwaVORes = ossKwaService.selectKwa(kwaVO);

		model.addAttribute("KWAVO", kwaVORes);

		int nPrdtSum = 0;

		//숙소
		List<AD_WEBLISTVO> kwaprdtListAD = webAdProductService.selectAdListOssKwa(kwaNum);

		model.addAttribute("kwaprdtListAD", kwaprdtListAD);

		nPrdtSum += kwaprdtListAD.size();

		//랜트카
		List<RC_PRDTINFVO> resultRcList = webRcProductService.selectWebRcPrdtListOssKwa(kwaNum);

		RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
		Calendar calNow = Calendar.getInstance();
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
		prdtSVO.setsFromTm("0900");

		calNow.add(Calendar.DAY_OF_MONTH, 1);
		prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
		prdtSVO.setsToTm("0900");
		
		// 판매 많은 순
		prdtSVO.setOrderCd(Constant.ORDER_SALE);
		prdtSVO.setOrderAsc(Constant.ORDER_DESC);		

		for(int i = 0; i < resultRcList.size(); i++) {
			RC_PRDTINFVO prdtInfVO = resultRcList.get(i);
			RC_PRDTINFSVO chkVO = prdtSVO;
			chkVO.setsPrdtNum(prdtInfVO.getPrdtNum());
			chkVO.setSearchYn("N");

			// 예약가능여부 확인
	    	RC_PRDTINFVO ableVO = webRcProductService.selectRcPrdt(chkVO);

	    	prdtInfVO.setAbleYn(ableVO.getAbleYn());

	    	resultRcList.set(i, prdtInfVO);
		}
		model.addAttribute("kwaprdtListRC", resultRcList);

		nPrdtSum += resultRcList.size();

		//소셜
		WEB_SPSVO spWebSVO = new WEB_SPSVO();
		spWebSVO.setKwaNum(kwaNum);

		spWebSVO.setCtgr("C100");

		List<WEB_SPPRDTVO> resultSpListC100 = webSpService.selectProductListOssKwa(spWebSVO);

		model.addAttribute("kwaprdtListSPC100", resultSpListC100);

		nPrdtSum += resultSpListC100.size();

		spWebSVO.setCtgr("C200");

		List<WEB_SPPRDTVO> resultSpListC200 = webSpService.selectProductListOssKwa(spWebSVO);

		model.addAttribute("kwaprdtListSPC200", resultSpListC200);

		nPrdtSum += resultSpListC200.size();

		spWebSVO.setCtgr("C300");

		List<WEB_SPPRDTVO> resultSpListC300 = webSpService.selectProductListOssKwa(spWebSVO);

		model.addAttribute("kwaprdtListSPC300", resultSpListC300);

		nPrdtSum += resultSpListC300.size();

		spWebSVO.setCtgr("C500");

		List<WEB_SPPRDTVO> resultSpListC500 = webSpService.selectProductListOssKwa(spWebSVO);

		model.addAttribute("kwaprdtListSPC500", resultSpListC500);

		nPrdtSum += resultSpListC500.size();

		// 관광기념품
		List<WEB_SVPRDTVO> resultSvList = webSvService.selectProductListOssKwa(kwaNum);

		model.addAttribute("kwaprdtListSV", resultSvList);

		nPrdtSum += resultSvList.size();

		model.addAttribute("prdtSum", nPrdtSum);

		return "/web/cmm/kwaSearch";
	}*/
}
