package mas.sp.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.sp.service.MasSpService;
import mas.sp.vo.SP_OPTINFVO;
import mas.sp.vo.SP_PRDTINFVO;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.user.vo.USERVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping("/mas/sp")
public class MasSpStockController {
	@Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "masSpService")
	private MasSpService masSpService;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	/**
	 * 쇼셜 상품 재고관리
	 * @param sp_PRDTINFVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/stockList.do")
	public String stockList(@ModelAttribute("searchVO") SP_PRDTINFVO sp_PRDTINFVO, ModelMap model) {
		log.info("/mas/sp/stockList.do call");

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
		
		List<SP_PRDTINFVO> sPrdtList = masSpService.selectSpPrdtSaleList(sp_PRDTINFVO);
		if(sPrdtList.size() > 0) {
			if(StringUtils.isEmpty(sp_PRDTINFVO.getsPrdtNum()))
				sp_PRDTINFVO.setPrdtNum(sPrdtList.get(0).getPrdtNum());
			else
				sp_PRDTINFVO.setPrdtNum(sp_PRDTINFVO.getsPrdtNum());
			List<SP_OPTINFVO> stockList = masSpService.selectStockList(sp_PRDTINFVO);
			model.addAttribute("stockList", stockList);
		}
		model.addAttribute("sPrdtList", sPrdtList);
		
		return "mas/sp/stockList";
	}
	
	/**
	 * 재고 수량 관리 ajax
	 * @param sp_OPTINFVO
	 * @return
	 */
	@RequestMapping("/updateOptStock.ajax")
	public ModelAndView updateOptStock(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO){
		Map<String, Object> resultMap = new HashMap<String,Object>();
		log.info(" stockNum :: " + sp_OPTINFVO.getOptPrdtNum());
		SP_OPTINFVO resultVO = masSpService.selectSpOptInf(sp_OPTINFVO);
		sp_OPTINFVO.setOptPrdtNum(resultVO.getOptPrdtNum() + sp_OPTINFVO.getOptPrdtNum());
		masSpService.updateSpOptInf(sp_OPTINFVO);
		resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		
		return modelAndView;
	}
	
	@RequestMapping("/updateOptSoldOut.ajax")
	public ModelAndView updateOptSoldOut(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO){
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		sp_OPTINFVO.setDdlYn(Constant.FLAG_Y);
		masSpService.updateDdlYn(sp_OPTINFVO);
		resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		
		return modelAndView;
	}
	
	@RequestMapping("/updateOptSale.ajax")
	public ModelAndView updateOptSale(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO){
		Map<String, Object> resultMap = new HashMap<String,Object>();
		sp_OPTINFVO = masSpService.selectSpOptInf(sp_OPTINFVO);
		
		sp_OPTINFVO.setDdlYn(Constant.FLAG_N);
		masSpService.updateDdlYn(sp_OPTINFVO);
		resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		
		return modelAndView;
	}
}
