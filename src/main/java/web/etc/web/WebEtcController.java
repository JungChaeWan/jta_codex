package web.etc.web;

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

import egovframework.cmmn.EgovWebUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import oss.cmm.vo.ERRPAGEVO;
import oss.etc.service.OssEtcService;
import web.etc.service.WebEtcService;
import web.etc.vo.SCCSVO;
import web.etc.vo.SCCVO;
import web.order.vo.RSVVO;

@Controller
public class WebEtcController {
	 Logger log = (Logger) LogManager.getLogger(this.getClass());
	 
	@Autowired
    private DefaultBeanValidator beanValidator;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "webEtcService")
	private WebEtcService webEtcService;
	
	@Resource(name = "ossEtcService")
	private OssEtcService ossEtcService;
    

	@RequestMapping("/web/etc/introduction.do")
	public String introduction(){
		return "web/etc/introduction";
	}

	@RequestMapping("/web/etc/socialContribution.do")
	public String socialContribution(){
		return "web/etc/socialContribution";
	}

	/**
	 * 개인정보
	 * 파일명 : personalData
	 * 작성일 : 2015. 12. 23. 오후 10:39:26
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/etc/personalData.do")
	public String personalData(	ModelMap model) {
		
		return "web/etc/personalData";
	}
	
	
	/**
	 * 구매이용약관
	 * 파일명 : bayToS
	 * 작성일 : 2015. 12. 23. 오후 10:41:56
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/etc/buyToS.do")
	public String buyToS(	ModelMap model) {
		
		return "web/etc/buyToS";
	}
	
	
	/**
	 * 판매이용약관
	 * 파일명 : saleToS
	 * 작성일 : 2015. 12. 23. 오후 10:42:13
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/etc/saleToS.do")
	public String saleToS(	ModelMap model) {
		
		return "web/etc/saleToS";
	}
	
	/**
	 * 전자금융거래 이용약관
	 * 파일명 : elBlank
	 * 작성일 : 2016. 1. 7. 오전 10:04:13
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/etc/elBlank.do")
	public String elBlank(	ModelMap model) {
		
		return "web/etc/elBlank";
	}
	
	
	/**
	 * 이메일 무단수집거부
	 * 파일명 : elBlank
	 * 작성일 : 2016. 1. 7. 오전 10:04:55
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/etc/emailToS.do")
	public String emailToS(	ModelMap model) {
		
		return "web/etc/emailToS";
	}

	
	/**
	 * 에러 페이지 표시
	 * 파일명 : error
	 * 작성일 : 2016. 1. 8. 오후 12:07:50
	 * 작성자 : 신우섭
	 * @param errPageVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/cmm/error.do")
	public String error(@ModelAttribute("errPage") ERRPAGEVO errPageVO,
    							ModelMap model){
		log.info("/web/cmm/error.do 호출");
		
		if( (errPageVO.getErrCord() == null || errPageVO.getErrCord().isEmpty()) 
			&& (errPageVO.getErrMsg() == null || errPageVO.getErrMsg().isEmpty()) ){
			errPageVO.setErrMsg("오류 입니다.");
		}
		
		/*
		if( errPageVO.getButtonText() == null || errPageVO.getButtonText().isEmpty() ){
			errPageVO.setButtonText("이전페이지로 이동");
		}
		
		if( errPageVO.getRtnUrl() == null || errPageVO.getRtnUrl().isEmpty() ){
			errPageVO.setRtnUrl("javascript:history.back();");
			//errPageVO.setRtnUrl("javascript:history.go(-2);");
		}
		*/
		
		model.addAttribute("errPage", errPageVO );
		
		return "web/cmm/error";
	}
	
	/**
	 * 사용자 홍보영상 리스트
	 * 파일명 : sccList
	 * 작성일 : 2017. 3. 7. 오전 10:05:30
	 * 작성자 : 최영철
	 * @param sccSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/etc/sccList.do")
	public String sccList(@ModelAttribute("searchVO") SCCSVO sccSVO
			, ModelMap model){
		
		sccSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		sccSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(sccSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(9);
		paginationInfo.setPageSize(sccSVO.getPageSize());

		sccSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		sccSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		sccSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = webEtcService.selectSccList(sccSVO);
		
		@SuppressWarnings("unchecked")
		List<RSVVO> resultList = (List<RSVVO>) resultMap.get("resultList");

		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "web/etc/sccList";
	}
	
	@RequestMapping("/web/etc/detailScc.do")
	public String detailScc(@ModelAttribute("searchVO") SCCSVO sccSVO
			, @ModelAttribute("SCCVO") SCCVO sccVO
			, ModelMap model){
		
		sccVO = ossEtcService.selectByScc(sccVO);
		
		if(sccVO == null){
			return "redirect:/web/etc/sccList.do";
		}
    	
    	sccVO.setContents(EgovWebUtil.clearXSSMinimum(sccVO.getContents()) );
    	sccVO.setContents(sccVO.getContents().replaceAll("\n", "<br/>\n") );
    	
    	model.addAttribute("sccVO", sccVO);
    	
    	return "web/etc/detailScc";
	}

}
