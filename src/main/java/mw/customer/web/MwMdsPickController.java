package mw.customer.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.prmt.vo.PRMTVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import oss.marketing.serive.OssAdmRcmdService;
import oss.marketing.vo.ADMRCMDVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MwMdsPickController {
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "OssAdmRcmdService")
	protected OssAdmRcmdService ossAdmRcmdService;
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@RequestMapping("/mw/coustomer/mdsPickList.do")
	public String mdsPickList(@ModelAttribute("searchVO") ADMRCMDVO admRcmdVO, ModelMap model) {
		log.info("/mw/coustomer/mdsPickList.do");
		
		admRcmdVO.setPageUnit(propertiesService.getInt("mwPageUnit"));
		admRcmdVO.setPageSize(propertiesService.getInt("mwPageSize"));
    	
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(admRcmdVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(admRcmdVO.getPageUnit());
		paginationInfo.setPageSize(admRcmdVO.getPageSize());

		admRcmdVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		admRcmdVO.setLastIndex(paginationInfo.getLastRecordIndex());
		admRcmdVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 상품 리스트
		Map<String, Object> resultMap = ossAdmRcmdService.selectMdsPickWebList(admRcmdVO);
		
		@SuppressWarnings("unchecked")
		List<PRMTVO> resultList = (List<PRMTVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
				
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/mw/coustomer/mdsPickList";
	}
	
	@RequestMapping("/mw/coustomer/mdsPickDtl.do")
	public String mdsPickDl(@ModelAttribute("searchVO") ADMRCMDVO admRcmdVO, ModelMap model) {
		log.info("/mw/coustomer/mdsPickDtl.do");
		
		admRcmdVO = ossAdmRcmdService.selectMdsPickWebInfo(admRcmdVO);
		
		if(admRcmdVO == null){
			return "redirect:/mw/coustmer/mdsPickList.do";
		}
		
		Calendar cal = new GregorianCalendar();
		cal.setTime(new Date());
		
		model.addAttribute("mdsInfo", admRcmdVO);
		/*model.addAttribute("prdtList", ossAdmRcmdService.selectMdsPickWebPrdtList(admRcmdVO));*/
		cal.add(Calendar.DAY_OF_YEAR, 1);
		model.addAttribute("SVR_START_DT", new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime()));
		cal.add(Calendar.DAY_OF_YEAR, 1);
		model.addAttribute("SVR_END_DT", new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime()));
		
		return "mw/coustomer/mdsPickDtl";
	}
}
