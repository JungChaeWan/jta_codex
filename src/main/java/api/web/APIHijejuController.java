
package api.web;

import api.service.APIHijejuService;
import api.vo.APILSRESULTVO;
import api.vo.APILSVO;
import common.Constant;
import mas.rc.service.MasRcPrdtService;
import mas.rsv.service.MasRsvService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.corp.service.OssCorpService;
import web.order.vo.SP_RSVVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@Controller
public class APIHijejuController {

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name="ossCorpService")
	private OssCorpService ossCorpService;

	@Resource(name="masRcPrdtService")
	private MasRcPrdtService masRcPrdtService;

	@Resource(name = "apiHijejuService")
	private APIHijejuService apiHijejuService;

	@Resource(name="masRsvService")
    private MasRsvService masRsvService;

	public static final String TAMNAO_AUTH = "HIHIJEJU";

	/** 사용처리 API */
	@RequestMapping(value="/hijeju/consume.do")
	public ModelAndView hijejuCompanyConsume( String orderItemId, HttpServletRequest request/*, @RequestHeader(value="Authorization") String Authorization*/){
		log.info("hijejuConsume : /consume/" + orderItemId);
		/*log.info("Authorization : " + Authorization);*/

		Enumeration params = request.getParameterNames();
		System.out.println("----------------------------");
		while (params.hasMoreElements()){
			String name = (String)params.nextElement();
			System.out.println(name + " : " +request.getParameter(name));
		}
		System.out.println("----------------------------");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		/*if(!TAMNAO_AUTH.equals(Authorization)){
			resultMap.put("code", "0003");
			resultMap.put("message", "벤더사 인증 토큰이 유효하지 않습니다");
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}*/

		SP_RSVVO spRsvVO = new SP_RSVVO();
		spRsvVO.setSpRsvNum(orderItemId);
		SP_RSVVO resultVO = masRsvService.selectSpDetailRsv(spRsvVO);
		if(resultVO != null && !"".equals(resultVO)) {
			if(Constant.RSV_STATUS_CD_UCOM.equals(resultVO.getRsvStatusCd())){
				resultMap.put("code", "402");
				resultMap.put("message", "사용처리된 주문입니다.");
			}else{
				int useNum = Integer.parseInt(resultVO.getUseNum()) + 1;
				resultVO.setUseNum(Integer.toString(useNum));
				if(resultVO.getBuyNum().equals(resultVO.getUseNum())){
					resultVO.setRsvStatusCd(Constant.RSV_STATUS_CD_UCOM);
				}else{
					resultVO.setRsvStatusCd(Constant.RSV_STATUS_CD_COM);
				}
				masRsvService.updateSpUseDttm(resultVO);
				resultMap.put("code", "200");
				resultMap.put("message", "정상");
			}
		}else{
			resultMap.put("code", "411");
			resultMap.put("message", "일치하는 아이템 번호를 찾을 수 없습니다.");
		}
		log.info("useProc result : "+resultMap);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	/** 미사용처리 API */
	@RequestMapping(value="/hijeju/restore.do")
	public ModelAndView lsCompanyRevoke(String orderItemId, HttpServletRequest request/*, @RequestHeader(value="Authorization") String Authorization*/){
		log.info("hijejuConsume : /restore/" + orderItemId);

		Map<String, Object> resultMap = new HashMap<String, Object>();

		/*if(!TAMNAO_AUTH.equals(Authorization)){
			resultMap.put("code", "0003");
			resultMap.put("message", "벤더사 인증 토큰이 유효하지 않습니다");
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}*/

		Enumeration params = request.getParameterNames();
		System.out.println("----------------------------");
		while (params.hasMoreElements()){
			String name = (String)params.nextElement();
			System.out.println(name + " : " +request.getParameter(name));
		}
		System.out.println("----------------------------");

		SP_RSVVO spRsvVO = new SP_RSVVO();
		spRsvVO.setSpRsvNum(orderItemId);
		SP_RSVVO resultVO = masRsvService.selectSpDetailRsv(spRsvVO);
		if(resultVO != null && !"".equals(resultVO)) {
			int useNum = Integer.parseInt(resultVO.getUseNum()) - 1;
			resultVO.setUseNum(Integer.toString(useNum));
			resultVO.setRsvStatusCd(Constant.RSV_STATUS_CD_COM);
			masRsvService.updateSpUseDttm(resultVO);
			resultMap.put("code", "200");
			resultMap.put("message", "정상");
		}else{
			resultMap.put("code", "411");
			resultMap.put("message", "일치하는 아이템 번호를 찾을 수 없습니다.");
		}
		log.info("useProc result : " + resultMap);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	/** 이용가능한 상품인지 확인API */
	@RequestMapping("/web/requestUseableHijejuProduct.ajax")
	public ModelAndView requestUseableHijejuProduct(	@ModelAttribute("APIHIJEJUVO") APILSVO apilsvo) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
		APILSRESULTVO resultVO =  apiHijejuService.requestUseableHijejuProduct(apilsvo);
		if(Constant.API_OK.equals(resultVO.getCode())){
			resultMap.put("success",resultVO.getMessage() + " " + resultVO.getPrNm() + " " + resultVO.getOtNm()  + " " +  resultVO.getOpNm()  );
		}else{
			resultMap.put("success",resultVO.getMessage());
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/** 카톡재전송 요청API*/
	@RequestMapping("/web/hijeju/sendHijejuMMSmsg.ajax")
	public ModelAndView sendMMSmsg(	@ModelAttribute("searchVO") APILSVO apilsvo) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
		APILSRESULTVO resultVO =  apiHijejuService.requestSMSHijeju(apilsvo);
		if(Constant.API_OK.equals(resultVO.getCode())){
			resultMap.put("success","전송이 완료 되었습니다.");
		}else{
			resultMap.put("success","전송실패");
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/** 예약확인 API */
	@RequestMapping("/web/hijeju/sendHijejuOrderChk.ajax")
	public ModelAndView sendLscompanyOrderChk(	@ModelAttribute("searchVO") APILSVO apilsvo) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
		APILSRESULTVO resultVO =  apiHijejuService.requestOrderChkHijeju(apilsvo);
		if(Constant.API_OK.equals(resultVO.getCode())){
			resultMap.put("success",resultVO.getMessage() + "/" + resultVO.getStatus() + "/" +  resultVO.getOrderItemId() + "/" + resultVO.getPinCode() + "/" +  resultVO.getUseDateTime() + "/" + resultVO.getCancelDateTime());
		}else{
			resultMap.put("success",resultVO.getMessage());
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}


}


