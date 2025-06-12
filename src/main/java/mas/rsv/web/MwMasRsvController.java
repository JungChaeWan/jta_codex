package mas.rsv.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import api.service.APIAdService;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.AD_PRDTINFVO;
import mas.corp.vo.DLVCORPVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rsv.service.MasRsvService;
import mas.rsv.vo.SP_RSVHISTVO;
import oss.cmm.service.OssCmmService;
import oss.corp.service.OssCorpService;
import oss.corp.service.impl.CorpDAO;
import oss.corp.vo.CORPVO;
import oss.user.vo.USERVO;
import web.order.service.WebOrderService;
import web.order.vo.AD_RSVVO;
import web.order.vo.RC_RSVVO;
import web.order.vo.RSVSVO;
import web.order.vo.SP_RSVVO;
import web.order.vo.SV_RSVVO;

@Controller
public class MwMasRsvController {

	@Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
    
    @Resource(name="ossCmmService")
    private OssCmmService ossCmmService;
    
    @Resource(name="masRsvService")
    private MasRsvService masRsvService;
    
    @Resource(name="masRcPrdtService")
    private MasRcPrdtService masRcPrdtService;
    
    @Resource(name="webOrderService")
    private WebOrderService webOrderService;
    
    @Resource(name="masAdPrdtService")
    private MasAdPrdtService masAdPrdtService;
    
    @Resource(name="apiAdService")
    private APIAdService apiAdService;
    
    @Resource(name = "corpDAO")
	private CorpDAO corpDAO;
    
    @Resource(name="ossCorpService")
    private OssCorpService ossCorpService;
    
    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	/**
     * 렌터카 예약내역 리스트
     * @param rsvSVO
     * @param model
     * @return
     */
    @RequestMapping("/mw/mas/rc/rsvList.do")
    public String rcRsvList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsCorpId(corpInfo.getCorpId());
    	
    	rsvSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	rsvSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(rsvSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(rsvSVO.getPageUnit());
		paginationInfo.setPageSize(rsvSVO.getPageSize());

		rsvSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		rsvSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		rsvSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = masRsvService.selectRcRsvList(rsvSVO);
		
		@SuppressWarnings("unchecked")
		List<RC_RSVVO> resultList = (List<RC_RSVVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	RC_PRDTINFSVO prdtInfSVO = new RC_PRDTINFSVO();
    	prdtInfSVO.setsCorpId(corpInfo.getCorpId());
    	List<RC_PRDTINFVO> prdtList = masRcPrdtService.selectPrdtList(prdtInfSVO);
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("prdtList", prdtList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
    	
    	return "/mas/rsv/rcRsvListMw";
    }
    
    /**
     * 렌터카 예약 상세
     * @param rsvSVO
     * @param rcRsvVO
     * @param model
     * @return
     */
    @RequestMapping("/mw/mas/rc/detailRsv.do")
    public String rcDetailRsv(@ModelAttribute("searchVO") RSVSVO rsvSVO, 
    		@ModelAttribute("RCRSVVO") RC_RSVVO rcRsvVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rcRsvVO.setsCorpId(corpInfo.getCorpId());
    	
    	RC_RSVVO resultVO = masRsvService.selectRcDetailRsv(rcRsvVO);
    	model.addAttribute("resultVO", resultVO);
    	
    	return "/mas/rsv/rcDetailRsvMw";
    }
    
    @RequestMapping("/mw/mas/ad/rsvList.do")
    public String adRsvList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsCorpId(corpInfo.getCorpId());
    	
    	rsvSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	rsvSVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** paging setting */
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(rsvSVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(rsvSVO.getPageUnit());
    	paginationInfo.setPageSize(rsvSVO.getPageSize());
    	
    	rsvSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	rsvSVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	rsvSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    	
    	Map<String, Object> resultMap = masRsvService.selectAdRsvList(rsvSVO);
    	
    	@SuppressWarnings("unchecked")
    	List<AD_RSVVO> resultList = (List<AD_RSVVO>) resultMap.get("resultList");
    	
    	// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("totalCnt", resultMap.get("totalCnt"));
    	model.addAttribute("paginationInfo", paginationInfo);
    	
    	
    	//객실 목록
    	AD_PRDTINFVO ad_PRDINFSVO = new AD_PRDTINFVO();
    	ad_PRDINFSVO.setCorpId(corpInfo.getCorpId());
    	List<AD_PRDTINFVO> adPrdtList = masAdPrdtService.selectAdPrdinfListOfRT(ad_PRDINFSVO);
    	model.addAttribute("prdtList", adPrdtList );
    	
    	return "/mas/rsv/adRsvListMw";
    }
    
    @RequestMapping("/mw/mas/ad/detailRsv.do")
    public String adDetailRsv(@ModelAttribute("searchVO") RSVSVO rsvSVO, 
    		@ModelAttribute("ADRSVVO") AD_RSVVO adRsvVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	adRsvVO.setsCorpId(corpInfo.getCorpId());
    	
    	AD_RSVVO resultVO = masRsvService.selectAdDetailRsv(adRsvVO);
    	model.addAttribute("resultVO", resultVO);
    	
    	return "/mas/rsv/adDetailRsvMw";
    }
    
    @RequestMapping("/mw/mas/sp/rsvList.do")
    public String spRsvList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsCorpId(corpInfo.getCorpId());
    	
    	rsvSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	rsvSVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** paging setting */
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(rsvSVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(rsvSVO.getPageUnit());
    	paginationInfo.setPageSize(rsvSVO.getPageSize());
    	
    	rsvSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	rsvSVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	rsvSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    	
    	Map<String, Object> resultMap = masRsvService.selectSpRsvList(rsvSVO);
    	
    	@SuppressWarnings("unchecked")
    	List<SP_RSVVO> resultList = (List<SP_RSVVO>) resultMap.get("resultList");
    	
    	// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("totalCnt", resultMap.get("totalCnt"));
    	model.addAttribute("paginationInfo", paginationInfo);
    	
    	return "/mas/rsv/spRsvListMw";
    }
    
    @RequestMapping("/mw/mas/sp/detailRsv.do")
    public String spDetailRsv(@ModelAttribute("searchVO") RSVSVO rsvSVO, 
    		@ModelAttribute("SPRSVVO") SP_RSVVO spRsvVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	spRsvVO.setsCorpId(corpInfo.getCorpId());
    	
    	SP_RSVVO resultVO = masRsvService.selectSpDetailRsv(spRsvVO);
    	
    	if(Constant.SP_PRDT_DIV_TOUR.equals(resultVO.getPrdtDiv()))  {
    		List<SP_RSVHISTVO> spRsvhistList = masRsvService.selectSpRsvHistList(spRsvVO);
    		model.addAttribute("spRsvhistList", spRsvhistList);
    	}
    	
    	model.addAttribute("resultVO", resultVO);
    	
    	
    	return "/mas/rsv/spDetailRsvMw";
    }
    
    /**
     * 제주도 기념품 구매 리스트
     * @param rsvSVO
     * @param model
     * @return
     */
    @RequestMapping("/mw/mas/sv/rsvList.do")
    public String svRsvList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsCorpId(corpInfo.getCorpId());
    	
    	rsvSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	rsvSVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** paging setting */
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(rsvSVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(rsvSVO.getPageUnit());
    	paginationInfo.setPageSize(rsvSVO.getPageSize());
    	
    	rsvSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	rsvSVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	rsvSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    	
    	Map<String, Object> resultMap = masRsvService.selectSvRsvList(rsvSVO);
    	
    	@SuppressWarnings("unchecked")
    	List<SV_RSVVO> resultList = (List<SV_RSVVO>) resultMap.get("resultList");
    	
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	List<DLVCORPVO> dlvCorpList = ossCorpService.selectDlvCorpListByCorp(corpVO);
    	
    	// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("totalCnt", resultMap.get("totalCnt"));
    	model.addAttribute("paginationInfo", paginationInfo);
    	model.addAttribute("dlvCorpList", dlvCorpList);
    	
    	return "/mas/rsv/svRsvListMw";
    }
    
    /**
     * 제주도 기념품구매 상세
     * @param rsvSVO
     * @param svRsvVO
     * @param model
     * @return
     */
    @RequestMapping("/mw/mas/sv/detailRsv.do")
    public String rcDetailRsv(@ModelAttribute("searchVO") RSVSVO rsvSVO, 
    		@ModelAttribute("SVRSVVO") SV_RSVVO svRsvVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	svRsvVO.setsCorpId(corpInfo.getCorpId());
    	
    	SV_RSVVO resultVO = masRsvService.selectSvDetailRsv(svRsvVO);
    	model.addAttribute("resultVO", resultVO);
    	
    	return "/mas/rsv/svDetailRsvMw";
    }
}
