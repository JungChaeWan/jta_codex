package mw.etc.web;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.vo.ERRPAGEVO;

@Controller
public class MwEtcController {
	 Logger log = LogManager.getLogger(this.getClass());
	 


	/**
	 * 개인정보
	 * 파일명 : personalData
	 * 작성일 : 2015. 12. 23. 오후 10:39:26
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/etc/personalData.do")
	public String personalData(ModelMap model) {
		
		return "mw/etc/personalData";
	}
	
	
	/**
	 * 구매이용약관
	 * 파일명 : bayToS
	 * 작성일 : 2015. 12. 23. 오후 10:41:56
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/etc/buyToS.do")
	public String buyToS(ModelMap model) {
		
		return "mw/etc/buyToS";
	}
	
	
	/**
	 * 판매이용약관
	 * 파일명 : saleToS
	 * 작성일 : 2015. 12. 23. 오후 10:42:13
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/etc/saleToS.do")
	public String saleToS(ModelMap model) {
		
		return "mw/etc/saleToS";
	}
	
	
	/**
	 * 전자금융거래 이용약관
	 * 파일명 : elBlank
	 * 작성일 : 2016. 1. 7. 오전 10:04:13
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/etc/elBlank.do")
	public String elBlank(ModelMap model) {
		
		return "mw/etc/elBlank";
	}
	
	
	/**
	 * 이메일 무단수집거부
	 * 파일명 : elBlank
	 * 작성일 : 2016. 1. 7. 오전 10:04:55
	 * 작성자 : 신우섭
	 * @param model
	 * @return
	 */
	@RequestMapping("/mw/etc/emailToS.do")
	public String emailToS(ModelMap model) {
		
		return "mw/etc/emailToS";
	}
	
	
	@RequestMapping("/mw/cmm/error.do")
	public String error(@ModelAttribute("errPage") ERRPAGEVO errPageVO,
						ModelMap model){
		log.info("/web/cmm/error.do call");
		
		if(StringUtils.isEmpty(errPageVO.getErrCord()) && StringUtils.isEmpty(errPageVO.getErrMsg())) {
			errPageVO.setErrMsg("오류입니다.");
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
		
		return "mw/cmm/error";
	}

	/**
	 * 관광지 CCTV
	 */
	@RequestMapping("/mw/cmm/cctvList.do")
	public String cctvList() {
		log.info("/mw/cmm/cctvList.do call");

		return "redirect:/mw/cmm/error.do?errCord=CCTV";
	}

	/**
	 * 회사소개
	 */
	@RequestMapping("/mw/etc/introduction.do")
	public String mwIntroduction() {
		log.info("/mw/etc/introduction.do");

		return "mw/etc/introduction";
	}

}
