package web.coustmer.web;

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
public class WebMdsPickController {
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "OssAdmRcmdService")
	protected OssAdmRcmdService ossAdmRcmdService;

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	/**
	 * 사용자 고객센터 MD's Pick 리스트 조회
	 * 파일명 : mdsPickList
	 * 작성일 : 2017. 1. 17. 오후 1:56:59
	 * 작성자 : 최영철
	 * @param admRcmdVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/coustmer/mdsPickList.do")
	public String mdsPickList(@ModelAttribute("searchVO") ADMRCMDVO admRcmdVO,
							  ModelMap model) {
		log.info("/web/coustmer/mdsPickList.do");

		admRcmdVO.setPageUnit(propertiesService.getInt("webEvntPageUnit"));
		admRcmdVO.setPageSize(propertiesService.getInt("webEvntPageSize"));

		/** paging setting */
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

		return "web/coustmer/mdsPickList";
	}

	@RequestMapping("/web/coustmer/mdsPickDtl.do")
	public String mdsPickDl(@ModelAttribute("searchVO") ADMRCMDVO admRcmdVO, ModelMap model) {
		log.info("/web/coustmer/mdsPickDtl.do");

		admRcmdVO = ossAdmRcmdService.selectMdsPickWebInfo(admRcmdVO);

		if(admRcmdVO == null){
			return "redirect:/web/coustmer/mdsPickList.do";
		}

		Calendar cal = new GregorianCalendar();
		cal.setTime(new Date());

		model.addAttribute("mdsInfo", admRcmdVO);
		/*model.addAttribute("prdtList", ossAdmRcmdService.selectMdsPickWebPrdtList(admRcmdVO));*/
		cal.add(Calendar.DAY_OF_YEAR, 1);
		model.addAttribute("SVR_START_DT", new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime()));
		cal.add(Calendar.DAY_OF_YEAR, 1);
		model.addAttribute("SVR_END_DT", new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime()));

		return "web/coustmer/mdsPickDtl";
	}
}
