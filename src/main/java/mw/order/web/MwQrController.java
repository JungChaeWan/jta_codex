package mw.order.web;

import common.QrCodeUtil;
import egovframework.cmmn.service.EgovStringUtil;
import mas.rsv.service.MasRsvService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;
import web.order.vo.SP_RSVVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Calendar;

@Controller
public class MwQrController {
	@Autowired
    private DefaultBeanValidator beanValidator;
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@Resource(name="masRsvService")
	protected MasRsvService masRsvService;
	
	@RequestMapping("/mw/qr.do")
    public String qrCode(HttpServletRequest request,
						 ModelMap model) {

		String rsvNum = request.getParameter("rsvNum");
		String telNum = request.getParameter("telNum");

		if(EgovStringUtil.isEmpty(rsvNum) || EgovStringUtil.isEmpty(telNum)) {
			log.error("rsvNum or telNum is null");
			return "redirect:/mw/main.do";
		}

		SP_RSVVO spRsvVO = new SP_RSVVO();
		spRsvVO.setRsvNum(rsvNum);
		
		String fileName = QrCodeUtil.qrCodeWriterByRsvNum(rsvNum);
		
		model.addAttribute("rsvNum", rsvNum);
		model.addAttribute("telNum", telNum);
		model.addAttribute("fileName", fileName);
		model.addAttribute("qrRsvMap", masRsvService.selectSpRsvQrList(spRsvVO));
		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()));
		
		return "/mw/qr/qrCode";
	}
	
	@RequestMapping("/mw/adv1.do")
	public String adv1(){
		return "/mw/qr/adv1";
	}
}
