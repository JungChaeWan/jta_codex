package oss.visitjeju.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import common.LowerHashMap;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import common.Constant;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpPnsReqService;
import oss.corp.vo.VISIT_JEJU;
import oss.prdt.service.OssPrdtService;
import oss.prdt.vo.PRDTSVO;
import oss.prdt.vo.PRDTVO;
import oss.visitjeju.service.VisitjejuService;
import oss.visitjeju.vo.VISITJEJUSVO;
import oss.visitjeju.vo.VISITJEJUVO;

@Controller
public class VisitjejuController {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name="visitjejuService")
    private VisitjejuService visitjejuService;
	
	@Resource(name="ossPrdtService")
    private OssPrdtService ossPrdtService;
	
	@Resource(name="ossCorpPnsReqService")
    private OssCorpPnsReqService ossCorpPnsReqService;
	
	@Resource(name="ossCmmService")
    private OssCmmService ossCmmService;
	
	Logger log = LogManager.getLogger(this.getClass());
	
	/**
	 * 비짓제주 연동 조회
	 * 파일명 : visitjejuList
	 * 작성일 : 2021. 10. 4. 오후 13:17:22
	 * 작성자 : 송호연
	 * @param visitjejuSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/visitjejuList.do")
	public String corpList(@ModelAttribute("searchVO") VISITJEJUSVO visitjejuSVO,
							ModelMap model){
		log.info("/oss/visitjejuList.do 호출");

		visitjejuSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		visitjejuSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(visitjejuSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(visitjejuSVO.getPageUnit());
		paginationInfo.setPageSize(visitjejuSVO.getPageSize());

		visitjejuSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		visitjejuSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		visitjejuSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
 
		Map<String, Object> resultMap = visitjejuService.selectVisitjejuList(visitjejuSVO);
		
		@SuppressWarnings("unchecked")
		List<VISITJEJUVO> resultList = (List<VISITJEJUVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	List<CDVO> tsCdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	
    	//코드읽기
		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
		model.addAttribute("corpCdList", corpCdList);

		LowerHashMap resultTypeCnt =  visitjejuService.selectVisitjejuTypeCnt();
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("tsCdList", tsCdList);
		model.addAttribute("resultTypeCnt", resultTypeCnt);

		model.addAttribute("paginationInfo", paginationInfo);

		return "oss/visitjeju/visitjejuList";
	}
	
	/**
	 * 상품팝업 비짓제주연동 리스트
	 * 파일명 : visitjejuList
	 * 작성일 : 2021. 10. 4. 오후 13:17:22
	 * 작성자 : 송호연
	 * @param visitjejuSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/findVisitjejuPrdt.do")
	public String findAllPrdt(@ModelAttribute("searchVO")VISITJEJUSVO visitjejuSVO,
						   ModelMap model){
		visitjejuSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		visitjejuSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(visitjejuSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(visitjejuSVO.getPageUnit());
		paginationInfo.setPageSize(visitjejuSVO.getPageSize());

		visitjejuSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		visitjejuSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		visitjejuSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//Map<String, Object> resultMap = ossPrdtService.selectPrdtAllList(prdtSVO);
		Map<String, Object> resultMap = visitjejuService.selectPrdtVisitjejuList(visitjejuSVO);

		@SuppressWarnings("unchecked")
		List<VISITJEJUVO> resultList = (List<VISITJEJUVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		//return "/oss/product/findAllPrdt";
		return "/oss/visitjeju/findVisitjejuPrdt";
	}
	
	/**
	 * 비짓제주 연동
	 * 파일명 : visitjejuList
	 * 작성일 : 2021. 10. 4. 오후 13:17:22
	 * 작성자 : 송호연
	 * @param visitjejuSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/insertVisitjeju.ajax")
	public ModelAndView updateVisitjeju(VISITJEJUVO visitjejuVO){
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		try{
			
			visitjejuService.deleteVisitjeju(visitjejuVO);
			 
			if(visitjejuVO.getApiCorpYn().equals("Y")) {	//업체
				visitjejuService.deleteApiCorpY(visitjejuVO);
			} else {										//상품
				visitjejuService.deleteApiCorpN(visitjejuVO);
			}
			
			visitjejuService.insertVisitjeju(visitjejuVO);
			resultMap.put("resultYn","Y");
		}catch(Exception e){
			resultMap.put("resultYn","N");
		}
		
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}
	
	/**
	 * 비짓제주 해제
	 * 파일명 : visitjejuList
	 * 작성일 : 2021. 10. 4. 오후 13:17:22
	 * 작성자 : 송호연
	 * @param visitjejuSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/deleteVisitjeju.ajax")
	public ModelAndView deleteVisitjeju(VISITJEJUVO visitjejuVO){
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		try{ 
			
			visitjejuService.deleteVisitjeju(visitjejuVO);
			resultMap.put("resultYn","Y");
		}catch(Exception e){
			resultMap.put("resultYn","N");
		}
		
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}
}
