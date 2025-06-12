package oss.prmt.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import oss.ad.vo.AD_WEBLISTSVO;
import oss.ad.vo.AD_WEBLISTVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CM_CONFHISTVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.prmt.service.OssPrmtService;
import oss.prmt.vo.PRMTSVO;
import oss.user.vo.USERVO;
import web.mypage.service.WebMypageService;
import web.mypage.vo.POCKETVO;
import web.product.service.WebAdProductService;
import web.product.service.WebPrmtService;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;
import web.product.vo.WEB_SPPRDTVO;
import web.product.vo.WEB_SPSVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class OssPrmtController {
	 Logger log = (Logger) LogManager.getLogger(OssPrmtController.class);
	 
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name="ossPrmtService")
	private OssPrmtService ossPrmtService;
	
	@Resource(name="ossCmmService")
    private OssCmmService ossCmmService;
	
	@Resource(name="webPrmtService")
    private WebPrmtService webPrmtService;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;
	
	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;
	
	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;
	
	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;
	
	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;
	 
	@RequestMapping("/oss/promotionList.do")
	public String promotionList(@ModelAttribute("searchVO") PRMTSVO prmtSVO,
								@ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,
								ModelMap model) {
		log.info("/oss/promotionList.do call");
		
		prmtSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		prmtSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtSVO.getPageUnit());
		paginationInfo.setPageSize(prmtSVO.getPageSize());

		prmtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossPrmtService.selectOssPrmtList(prmtSVO);
		
		@SuppressWarnings("unchecked")
		List<PRMTVO> resultList = (List<PRMTVO>) resultMap.get("resultList");

		model.addAttribute("resultList", resultList);

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("totalCnt", resultMap.get("totalCnt"));

		model.addAttribute("paginationInfo", paginationInfo);

		return "oss/prmt/promotionList";
	}
	
	@RequestMapping("/oss/viewPrmtAppr.ajax")
	public ModelAndView viewPrmtAppr(@RequestParam("prmtNum")String prmtNum) {
		log.info("/oss/viewPrmtAppr.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		log.info("prmt :: " + prmtNum);
		String msg = ossCmmService.selectConhistByMsg(prmtNum);
		
		resultMap.put("msg", msg);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		
		return modelAndView;
	}
	
	@RequestMapping("/oss/promotionAppr.do")
	public String promotionAppr(@ModelAttribute("searchVO") PRMTSVO prmtSVO, 
			@ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,
			ModelMap model) {
		log.info("/oss/promotionAppr.do call");
		
		PRMTVO prmtVO = new PRMTVO();
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		prmtVO.setLastModId(corpInfo.getUserId());
		prmtVO.setLastModIp(corpInfo.getLastLoginIp());
		
		prmtVO.setPrmtNum(cm_CONFHISTVO.getLinkNum());
		prmtVO.setStatusCd(cm_CONFHISTVO.getTradeStatus());
		ossPrmtService.updatePrmtAppr(prmtVO);
		
		cm_CONFHISTVO.setRegId(corpInfo.getUserId());
		cm_CONFHISTVO.setRegIp(corpInfo.getLastLoginIp());
		ossCmmService.insertCmConfhist(cm_CONFHISTVO);
		
		return "redirect:/oss/promotionList.do";
	}
    
    @RequestMapping("/oss/preview/detailPromotion.do")
    public String detailProduct(@ModelAttribute("prmtVO") PRMTVO prmtVO,
    		ModelMap model) throws ParseException {

    	prmtVO.setFirstIndex(0);
		prmtVO.setLastIndex(2);
		
		if(prmtVO.getFinishYn() == null){
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		
		if(prmtVO.getWinsYn() == null){
			prmtVO.setWinsYn(Constant.FLAG_N);
		}
				
		List<PRMTVO> otherPromotionList = new ArrayList<PRMTVO>();
		model.addAttribute("otherPromotionList", otherPromotionList);
		
		PRMTVO resultVO = webPrmtService.selectByPrmt(prmtVO);
		resultVO.setWinsYn(prmtVO.getWinsYn());
		resultVO.setFinishYn(prmtVO.getFinishYn());
				
		if(StringUtils.isNotEmpty(resultVO.getCorpId())) {
			CORPVO corpSVO = new CORPVO();
			corpSVO.setCorpId(resultVO.getCorpId());
			CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
			
			prmtVO.setCorpCd(corpVO.getCorpCd());
			List<PRMTPRDTVO> prmtPrdtList = webPrmtService.selectPrmtPrdtList(prmtVO);
			List<String> prdtNumList = new ArrayList<String>();
			for(PRMTPRDTVO prmt : prmtPrdtList ) {
				log.info("prdtNum :: " + prmt.getPrdtNum());
				prdtNumList.add(prmt.getPrdtNum());
			}
			// 이벤트 상품 목록 - 골프와 숙소만.(한개만 나오니까)
			if(prmtPrdtList.size() > 0) {
				if(Constant.ACCOMMODATION.equals(corpVO.getCorpCd())) {
					 AD_WEBLISTSVO prdtSVO = new AD_WEBLISTSVO();
					 prdtSVO.setsCorpId(resultVO.getCorpId());
					 prdtSVO.setsNights("1");
					 prdtSVO.setsFromDt(new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()));
					 prdtSVO.setFirstIndex(0);
					 prdtSVO.setLastIndex(10);
					 prdtSVO.setsSearchYn(Constant.FLAG_N);
					 @SuppressWarnings("unchecked")
					List<AD_WEBLISTVO> resultList = (List<AD_WEBLISTVO>)webAdProductService.selectAdPrdtList(prdtSVO).get("resultList");
					 model.addAttribute("product", resultList);
				} else if(Constant.RENTCAR.equals(corpVO.getCorpCd())) {
					RC_PRDTINFSVO prdtSVO = new RC_PRDTINFSVO();
					prdtSVO.setFirstIndex(0);
					prdtSVO.setLastIndex(100);
					Calendar calNow = Calendar.getInstance();
		    		calNow.add(Calendar.DAY_OF_MONTH, 1);
		    		prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
		    		prdtSVO.setsFromTm("0900");
		    		
		    		calNow.add(Calendar.DAY_OF_MONTH, 1);
		    		prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
		    		prdtSVO.setsToTm("0900");
		    		prdtSVO.setsCorpId(corpVO.getCorpId());
		    		
		    		prdtSVO.setOrderCd(Constant.ORDER_SALE);
		    		prdtSVO.setOrderAsc(Constant.ORDER_DESC);
		    		prdtSVO.setPrdtNumList(prdtNumList);
		    		List<RC_PRDTINFVO> resultList = (List<RC_PRDTINFVO>) webRcProductService.selectRcPrdtList2(prdtSVO);
		    		
		    		/*for(int i = 0;i < resultList.size();i++){
		    			RC_PRDTINFVO prdtInfVO = resultList.get(i);
		    			RC_PRDTINFSVO chkVO = prdtSVO;
		    			chkVO.setsPrdtNum(prdtInfVO.getPrdtNum());
		    			
		    			// 예약가능여부 확인
		    	    	RC_PRDTINFVO ableVO = webRcProductService.selectRcAble(chkVO);
		    	    	prdtInfVO.setAbleYn(ableVO.getAbleYn());
		    	    	
		    	    	resultList.set(i, prdtInfVO);
		    		}*/
		    		model.addAttribute("product", resultList);
				} else if(Constant.SOCIAL.equals(corpVO.getCorpCd())) {
					WEB_SPSVO searchVO = new WEB_SPSVO();
					if(Constant.SOCIAL_TOUR.equals(corpVO.getCorpSubCd())) {
						searchVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE);
					} 
					searchVO.setPrdtNumList(prdtNumList);
					searchVO.setFirstIndex(0);
					searchVO.setLastIndex(100);
					
					Map<String, Object> productMap = webSpService.selectProductList(searchVO);
					
					@SuppressWarnings("unchecked")
					List<WEB_SPPRDTVO> resultList = (List<WEB_SPPRDTVO>)productMap.get("resultList");
					model.addAttribute("product", resultList);
				}
			}
		
			model.addAttribute("corpCd", corpVO.getCorpCd());
		}		
		model.addAttribute("prmtVO", resultVO);
		
		// 찜하기 정보 (2017-11-24, By JDongS)    	
    	POCKETVO pocket = new POCKETVO();
    	Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();
    	USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	if (userVO != null) {
    		pocket.setUserId(userVO.getUserId());
        	pocketMap = webMypageService.selectPocketList(pocket);
    	}   
    	model.addAttribute("pocketMap", pocketMap);	
    	
    	return "web/evnt/detailPromotion";
	}
}
