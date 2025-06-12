package api.web;

import api.service.APIInsService;
import mas.rc.vo.RC_PRDTINFVO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

@Controller
public class APIInsController {
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name="apiInsService")
    private APIInsService apiInsService;

	@RequestMapping("/apiIns/inslist.ajax")
	public ModelAndView apiInsCarlist(@ModelAttribute("searchVO") RC_PRDTINFVO webParam) throws ParseException, IOException {
		HashMap<String,Object> resultData = apiInsService.inslist(webParam);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}

	@RequestMapping("/apiIns/carlist_r.ajax")
	public ModelAndView carlist_r(@ModelAttribute("searchVO") RC_PRDTINFVO webParam) throws ParseException, IOException {
		HashMap<String,Object> resultData = apiInsService.carlist_r(webParam);
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}

	@RequestMapping("/apiIns/updateCarSaleStart.ajax")
	public ModelAndView carlistSaleStart(@ModelAttribute("searchVO") RC_PRDTINFVO webParam) throws ParseException, IOException {
		apiInsService.updateCarSaleStart(webParam);
		HashMap<String,Object> resultData = new HashMap<>();
		ModelAndView mav = new ModelAndView("jsonView", resultData);
		return mav;
	}
}

