package api.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import mas.rc.service.impl.RcDAO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.ad.vo.AD_WEBLISTSVO;
import oss.ad.vo.AD_WEBLISTVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import web.product.service.WebAdProductService;
import web.product.service.WebSpProductService;
import web.product.service.WebSvProductService;
import web.product.vo.WEB_SPPRDTVO;
import web.product.vo.WEB_SPSVO;
import web.product.vo.WEB_SVPRDTVO;
import web.product.vo.WEB_SVSVO;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class APIEpurlController {
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@Autowired
	private DefaultBeanValidator beanValidator;
		
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;
	
	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;
	
	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;
	
	@Resource(name = "webSvService")
	protected WebSvProductService webSvService;
	
	@Resource(name = "rcDAO")
	protected RcDAO rcDAO;
			
	/**
	 * epUrl을 위한 상품 리스트 출력
	 * Function : epurlList
	 * 작성일 : 2017. 4. 14. 오후 11:12:12
	 * 작성자 : 정동수
	 * @return
	 */
	@RequestMapping("/api/epurlList.do")
    public String epurlList(ModelMap model) {
    	
    	log.info("/api/epurlList.do 호출");
    	
    	// 숙소 리스트
    	Calendar calNow = Calendar.getInstance();
    	Map<String, String> adTypeMap = new HashMap<String, String>();
    	
    	for (CDVO code : ossCmmService.selectCode("ADDV")) {
    		adTypeMap.put(code.getCdNum(), code.getCdNm());
    	}
    	
    	AD_WEBLISTSVO prdtAdSVO = new AD_WEBLISTSVO();
    	prdtAdSVO.setsNights("1");
    	prdtAdSVO.setsFromDt( String.format("%d%02d%02d",
				calNow.get(Calendar.YEAR),
				calNow.get(Calendar.MONTH) + 1, 
				calNow.get(Calendar.DAY_OF_MONTH)  ) 
			);
    	prdtAdSVO.setsFromDtView( String.format("%d-%02d-%02d",
				calNow.get(Calendar.YEAR),
				calNow.get(Calendar.MONTH) + 1, 
				calNow.get(Calendar.DAY_OF_MONTH)  ) 
			);
    	prdtAdSVO.setFirstIndex(0);
    	prdtAdSVO.setLastIndex(1000);
    	
    	Map<String, Object> resultMap = webAdProductService.selectAdPrdtList(prdtAdSVO);
		
		@SuppressWarnings("unchecked")
		List<AD_WEBLISTVO> prdtAdList = (List<AD_WEBLISTVO>) resultMap.get("resultList");
		
		model.addAttribute("adTypeMap", adTypeMap);
		model.addAttribute("prdtAdSVO", prdtAdSVO);
		model.addAttribute("prdtAdList", prdtAdList);
		
		
		// 렌터카 리스트
		calNow = Calendar.getInstance();
		Map<String, String> rcFuelMap = new HashMap<String, String>();
    	
    	for (CDVO code : ossCmmService.selectCode("CFCD")) {
    		rcFuelMap.put(code.getCdNum(), code.getCdNm());
    	}
    	
		RC_PRDTINFSVO prdtRcSVO = new RC_PRDTINFSVO();
		
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		prdtRcSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
		prdtRcSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
		prdtRcSVO.setsFromTm("1200");
		
		calNow.add(Calendar.DAY_OF_MONTH, 1);
		prdtRcSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
		prdtRcSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
		prdtRcSVO.setsToTm("1200");
		
		prdtRcSVO.setFirstIndex(0);
		prdtRcSVO.setLastIndex(10000);
    	
		List<RC_PRDTINFVO> prdtRcList = rcDAO.selectWebRcPrdtList(prdtRcSVO);
    			
		model.addAttribute("rcFuelMap", rcFuelMap);
		model.addAttribute("prdtRcSVO", prdtRcSVO);
		model.addAttribute("prdtRcList", prdtRcList);
		
		
		// 관광지/레저 & 음식/뷰티
		WEB_SPSVO prdtSpSVO = new WEB_SPSVO();
		String[] spTypeArr = {"C200", "C300"};
		Map<String, String> spCodeMap = new HashMap<String, String>();
		Map<String, String> sp200Map = new HashMap<String, String>();
		Map<String, String> sp300Map = new HashMap<String, String>();
    	
    	for (CDVO code : ossCmmService.selectCode("C000")) {
    		spCodeMap.put(code.getCdNum(), code.getCdNm());
    	}
    	
    	for (CDVO code : ossCmmService.selectCode("C200")) {
    		sp200Map.put(code.getCdNum(), code.getCdNm());
    	}
    	
    	for (CDVO code : ossCmmService.selectCode("C300")) {
    		sp300Map.put(code.getCdNum(), code.getCdNm());
    	}
		
		prdtSpSVO.setsCtgrDepth("1");		
		prdtSpSVO.setFirstIndex(0);
		prdtSpSVO.setLastIndex(10000);
				
		List<WEB_SPPRDTVO> prdtSpList = new ArrayList<WEB_SPPRDTVO>();
		for (String spType : spTypeArr) {
			prdtSpSVO.setsCtgr(spType);
			
			resultMap = webSpService.selectProductList(prdtSpSVO);
			
			@SuppressWarnings("unchecked")
			List<WEB_SPPRDTVO> prdtList = (List<WEB_SPPRDTVO>) resultMap.get("resultList");  
			
			for (WEB_SPPRDTVO prdt : prdtList) {
				prdtSpList.add(prdt);
			}
		}		
		
		model.addAttribute("spCodeMap", spCodeMap);
		model.addAttribute("sp200Map", sp200Map);
		model.addAttribute("sp300Map", sp300Map);
		model.addAttribute("prdtSpList", prdtSpList);
		
		
		// 카텔 & 골프패키지 & 버스/택시관광 & 에어카텔
		prdtSpSVO = new WEB_SPSVO();
		Map<String, String> sp100Map = new HashMap<String, String>();
    	
    	for (CDVO code : ossCmmService.selectCode("C100")) {
    		sp100Map.put(code.getCdNum(), code.getCdNm());
    	}
		
    	prdtSpSVO.setsCtgr("C100");
		prdtSpSVO.setsCtgrDepth("1");		
		prdtSpSVO.setFirstIndex(0);
		prdtSpSVO.setLastIndex(10000);
		
		resultMap = webSpService.selectProductList(prdtSpSVO);
		
		@SuppressWarnings("unchecked")
		List<WEB_SPPRDTVO> prdtPkList = (List<WEB_SPPRDTVO>) resultMap.get("resultList");				
				
		model.addAttribute("sp100Map", sp100Map);
		model.addAttribute("prdtPkList", prdtPkList);
		
		
		// 제주특산/기념품
		WEB_SVSVO prdtSvSVO = new WEB_SVSVO();
		Map<String, String> svCodeMap = new HashMap<String, String>();		
		Map<String, Map<String, String>> svSubCodeMap = new HashMap<String, Map<String, String>>();
    	
    	for (CDVO code : ossCmmService.selectCode("SVDV")) {
    		svCodeMap.put(code.getCdNum(), code.getCdNm());
    	}
    	
    	for (Entry<String, String> code : svCodeMap.entrySet()) {
    		Map<String, String> tmpMap = new HashMap<String, String>();
    		for (CDVO subCode : ossCmmService.selectCode(code.getKey())) {
    			tmpMap.put(subCode.getCdNum(), subCode.getCdNm());
    		}
    		svSubCodeMap.put(code.getKey(), tmpMap);
    	}
				
    	prdtSvSVO.setFirstIndex(0);
    	prdtSvSVO.setLastIndex(10000);
		
		resultMap = webSvService.selectProductList(prdtSvSVO);
		
		@SuppressWarnings("unchecked")
		List<WEB_SVPRDTVO> prdtSvList = (List<WEB_SVPRDTVO>) resultMap.get("resultList");				
				
		model.addAttribute("svCodeMap", svCodeMap);
		model.addAttribute("svSubCodeMap", svSubCodeMap);
		model.addAttribute("prdtSvList", prdtSvList);
		
    	return "/apiCn/api/apiEpurlList";
    	
    }	
}
