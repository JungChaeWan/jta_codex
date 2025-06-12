package api.web;

import api.service.APIOrcService;
import api.vo.APIOrcCarlistVO;
import mas.rc.vo.RC_PRDTINFVO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class APIOrcController {
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name="apiOrcService")
    private APIOrcService apiOrcService;

	@RequestMapping("/apiOrc/vehicleModels.ajax")
	public ModelAndView apiOrcCarlist(@ModelAttribute("searchVO") RC_PRDTINFVO webParam){
		log.info("call /apiOrc/vehicleModels.ajax");
		HashMap<String,Object> resultData = apiOrcService.vehicleModels(webParam);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}

	@RequestMapping("/apiOrc/vehicleModelDetail.ajax")
	public ModelAndView apiOrcCarDetail(@ModelAttribute("searchVO") RC_PRDTINFVO webParam){
		Map<String, Object> resultData = new HashMap<>();
		log.info("call /apiOrc/vehicleModelDetail.ajax");
		RC_PRDTINFVO resultMap = apiOrcService.vehicleModelDetail(webParam);
		resultData.put("resultData",resultMap);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}

	@RequestMapping("/apiOrc/vehicleModelList.ajax")
	public ModelAndView vehicleModelList(@ModelAttribute("searchVO") RC_PRDTINFVO webParam) throws UnsupportedEncodingException {
		Map<String, Object> resultData = new HashMap<>();
		log.info("call /apiOrc/vehicleModelList.ajax");
		List<APIOrcCarlistVO> resultMap = apiOrcService.vehicleAvailList(webParam);
		resultData.put("resultData",resultMap);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}
}