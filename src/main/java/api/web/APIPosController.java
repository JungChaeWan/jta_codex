package api.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mas.rsv.service.MasRsvService;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import web.order.service.WebOrderService;
import web.order.vo.RSVSVO;
import web.order.vo.RSVVO;
import web.order.vo.SP_RSVVO;
import api.service.APIPosService;
import api.vo.POSVO;

import common.Constant;

import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class APIPosController {
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@Autowired
	private DefaultBeanValidator beanValidator;
		
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "apiPosService")
	protected APIPosService apiPosService;
	
	@Resource(name="masRsvService")
    private MasRsvService masRsvService;
	
	@Resource(name="webOrderService")
	private WebOrderService webOrderService;
		
	/**
	 * POS 예약리스트 조회
	 * Function : rsvList
	 * 작성일 : 2016. 10. 12. 오후 12:54:12
	 * 작성자 : 정동수
	 * @param splyCorpDftId
	 * @param rsvNum
	 * @param telNum
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/api/rsvList.ajax")
    public ModelAndView rsvList(	@RequestParam("splyCorpDftId") String splyCorpDftId,
    		@RequestParam("rsvNum") String rsvNum,
    		@RequestParam("telNum") String telNum,
    		HttpServletRequest request, 
    		HttpServletResponse response) throws Exception{
    	
    	log.info("/api/rsvList.ajax 호출");
    	
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	RSVSVO rsvSVO = new RSVSVO();
    	rsvSVO.setsRsvNum(rsvNum);
    	rsvSVO.setsRsvTelnum(telNum);
    	rsvSVO.setsCorpId(splyCorpDftId);
    			
		List<POSVO> resultList = apiPosService.selectByRsvList(rsvSVO);
				
		resultMap.put("success", "Y");
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", resultList.size());
		
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	
    	return mav;
    }
	
	/**
	 * 사용가능 상품 조회
	 * Function : prdtList
	 * 작성일 : 2016. 10. 12. 오후 3:10:17
	 * 작성자 : 정동수
	 * @param splyCorpDftId
	 * @param saleCorpId
	 * @param agentCorpId
	 * @param rsvNum
	 * @return
	 */
	@RequestMapping("/api/prdtList.ajax")
    public ModelAndView prdtList(	@RequestParam("splyCorpDftId") String splyCorpDftId,
    								@RequestParam("cpDiv") String cpDiv,
    								@RequestParam("rsvNum") String rsvNum){
    	
    	log.info("/api/prdtList.ajax 호출");
    	
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	log.info(rsvNum);
    	if(EgovStringUtil.isEmpty(splyCorpDftId)){
    		resultMap.put("success", "N");
    		resultMap.put("rtnMsg", "업체아이디가 입력되지 않았습니다.");
    		
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
       		return mav;
    	}    	
    	if(EgovStringUtil.isEmpty(rsvNum)){
    		resultMap.put("success", "N");
    		resultMap.put("rtnMsg", "예약번호가 입력되지 않았습니다.");
    		
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}
    	POSVO posVO = new POSVO();
    	posVO.setCpDiv(cpDiv);
    	posVO.setRsvNum(rsvNum);
    	
    	List<POSVO> prdtList = apiPosService.selectByPrdtList(posVO);
    	
    	posVO = apiPosService.selectByRsvInfo(posVO);
		
		resultMap.put("success", "Y");
		resultMap.put("prdtList", prdtList);
		resultMap.put("prdtCnt", prdtList.size());
		resultMap.put("rsvInfo", posVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
   		return mav;
    }
	
	/**
	 * 사용처리
	 * Function : usePrdt
	 * 작성일 : 2016. 10. 13. 오전 10:53:05
	 * 작성자 : 정동수
	 * @param splyCorpDftId
	 * @param rsvNum
	 * @param useMem
	 * @param refundAmt
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/api/usePrdt.ajax")
	public ModelAndView usePrdt(@RequestParam("splyCorpDftId") String splyCorpDftId,
			@RequestParam("rsvNum") String rsvNum,
			@RequestParam("useMem") String useMem,
			@RequestParam("refundAmt") String refundAmt,
			HttpServletRequest request,
			ModelMap model) throws Exception{
    	
    	log.info("/api/usePrdt.ajax 호출");
    	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String success = Constant.FLAG_N;
		
		if(EgovStringUtil.isEmpty(splyCorpDftId)){
			resultMap.put("success", success);
			resultMap.put("rtnMsg", "관광지 업체 아이디가 입력되지 않았습니다.");
			
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
	    	
	   		return mav;
		}
		
		if(EgovStringUtil.isEmpty(rsvNum)){
			resultMap.put("success", success);
			resultMap.put("rtnMsg", "예약번호가 입력되지 않았습니다.");
			
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			
			return mav;
		}
		
		if(EgovStringUtil.isEmpty(useMem)){
			resultMap.put("success", success);
			resultMap.put("rtnMsg", "사용인원이 입력되지 않았습니다.");
			
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			
			return mav;
		}
		if(EgovStringUtil.isEmpty(refundAmt)){
			resultMap.put("success", success);
			resultMap.put("rtnMsg", "환불되는 금액이 입력되지 않았습니다.");
			
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			
			return mav;
		}
		// 1. 예약 정보 조회
		SP_RSVVO spRsvVO = new SP_RSVVO();		
		spRsvVO.setSpRsvNum(rsvNum);
		spRsvVO = apiPosService.selectSpRsv(spRsvVO);
		
		if (spRsvVO == null) {
			resultMap.put("success", success);
			resultMap.put("rtnMsg", "예약 정보가 없습니다.");
			
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			
			return mav;
		}
		
		// 2. 사용인원 가능 여부 체크
		if(Integer.parseInt(spRsvVO.getBuyNum()) < Integer.parseInt(useMem)){
			resultMap.put("success", success);
			resultMap.put("rtnMsg", "사용 가능인원이 초과하였습니다.");
			
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
	    	
	   		return mav;
		}
						
		if(Integer.parseInt(spRsvVO.getBuyNum()) == Integer.parseInt(useMem)){	// 인원이 동일 시 바로 사용 처리
			// 쿠폰상품일 경우 구매시간 - 이용시간 / 유효일 체크해서 처리.
	    	SP_RSVVO resultVO = masRsvService.selectSpDetailRsv(spRsvVO);
	    	
	    	String now = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());

	    	if(now.compareTo(resultVO.getExprStartDt()) < 0 || now.compareTo(resultVO.getExprEndDt()) > 0 ) {
	    		resultMap.put("success", success);
	    		resultMap.put("exprOut", Constant.FLAG_Y);
	    		resultMap.put("exprStartDt", resultVO.getExprStartDt());
	    		resultMap.put("exprEndDt", resultVO.getExprEndDt());
	    		resultMap.put("rtnMsg", "유효 기간 : " + resultVO.getExprEndDt() + " 까지" );
	    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
	    		return mav;
	    	}
	    	
	    	now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
	    	if(StringUtils.isNotEmpty(resultVO.getUseAbleDttm()) && now.compareTo(resultVO.getUseAbleDttm()) < 0) {
	    		resultMap.put("success", success);
	    		resultMap.put("useAbleOut", Constant.FLAG_Y);
	    		resultMap.put("useAbleDttm", resultVO.getUseAbleDttm());
	    		resultMap.put("rtnMsg", "사용 가능 시간 : " + resultVO.getUseAbleDttm() + " 이후 가능" );
	    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
	    		return mav;
	    	}
	    	
	    	// 사용완료.
	    	spRsvVO.setUseNum(useMem);
	    	spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_UCOM);
	    	masRsvService.updateSpUseDttm(spRsvVO);
	    	
	    	spRsvVO = apiPosService.selectSpRsv(spRsvVO);
	    	
	    	resultMap.put("success", Constant.FLAG_Y);
			resultMap.put("payTime", spRsvVO.getUseDttm());
			resultMap.put("agentCorpNm", "탐나오");
			resultMap.put("rtnMsg", "사용처리되었습니다.");	 
		} else {			// 인원이 상이하게 되면 환불 후 사용 처리
			spRsvVO.setUseNum(useMem);
			spRsvVO.setRefundAmt(refundAmt);
			
			// 쿠폰상품일 경우 구매시간 - 이용시간 / 유효일 체크해서 처리.
	    	SP_RSVVO rsvDtlVO = masRsvService.selectSpDetailRsv(spRsvVO);
	    	
	    	String now = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());

	    	if(now.compareTo(rsvDtlVO.getExprStartDt()) < 0 || now.compareTo(rsvDtlVO.getExprEndDt()) > 0 ) {
	    		resultMap.put("exprOut", Constant.FLAG_Y);
	    		resultMap.put("exprStartDt", rsvDtlVO.getExprStartDt());
	    		resultMap.put("exprEndDt", rsvDtlVO.getExprEndDt());
	    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
	    		return mav;
	    	}

	    	now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
	    	if(StringUtils.isNotEmpty(rsvDtlVO.getUseAbleDttm()) && now.compareTo(rsvDtlVO.getUseAbleDttm()) < 0) {
	    		resultMap.put("useAbleOut", Constant.FLAG_Y);
	    		resultMap.put("useAbleDttm", rsvDtlVO.getUseAbleDttm());
	    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
	    		return mav;
	    	}
	    	
	    	spRsvVO.setRsvNum(rsvDtlVO.getRsvNum());
	    	
	    	// 사용완료.
	    	spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_UCOM);
	    	apiPosService.updateSpUseDttm(spRsvVO);
	    	
	    	spRsvVO = apiPosService.selectSpRsv(spRsvVO);
			
			resultMap.put("success", Constant.FLAG_Y);
			resultMap.put("payTime", spRsvVO.getUseDttm());
			resultMap.put("agentCorpNm", "탐나오");
			resultMap.put("rtnMsg", "사용처리되었습니다.");	    	
	    	
	    	// 접속 IP
	    	String userIp = EgovClntInfo.getClntIP(request);
	    	
	    	// 환불금액이 상품금액과 동일한경우
	    	if(rsvDtlVO.getNmlAmt().equals(spRsvVO.getRefundAmt())){
	    		resultMap.put("refundAbleOut", Constant.FLAG_Y);
	    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
	    		return mav;
	    	}else{
	    		// LG 카드결제인경우 자동 취소 처리
	    		if(Constant.PAY_DIV_LG_CI.equals(rsvDtlVO.getPayDiv())|| Constant.PAY_DIV_LG_KI.equals(rsvDtlVO.getPayDiv())){	
	    			Map<String, Object> payResultMap = masRsvService.cancelPay(rsvDtlVO.getPayDiv(), rsvDtlVO.getRsvNum(), rsvDtlVO.getSpRsvNum(), spRsvVO.getRefundAmt(), userIp, "", "", "");

	    			success = (String) payResultMap.get("success");
	    			
	    			// 취소완료건에 대해 예약건 업데이트
	    			if(Constant.FLAG_Y.equals(success)){
	    				// RSV_STATUS_CD_SCOM(RS32 : 부분환불완료)
	    				spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_SCOM);
	    				
	    				// 취소금액
	    				spRsvVO.setCancelAmt(spRsvVO.getRefundAmt());
	    				spRsvVO.setCmssAmt(rsvDtlVO.getCmssAmt());
	    				// 환불금액
//	    				spRsvVO.setRefundAmt(spRsvVO.getRefundAmt());
	    				spRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
	    				webOrderService.updateSpCancelDtlRsv(spRsvVO);
	    				// 쿠폰 취소처리
	    				webOrderService.cancelUserCp(spRsvVO.getSpRsvNum());
	    				
	    				// 통합 예약건에 대한 처리
	    				RSVVO rsvVO = new RSVVO();
	    				rsvVO.setRsvNum(rsvDtlVO.getRsvNum());
	    				rsvVO.setTotalCancelAmt(spRsvVO.getRefundAmt());
	    				rsvVO.setTotalCmssAmt(rsvDtlVO.getCmssAmt());
	    				rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());
	    				
	    				rsvVO.setModIp(userIp);
	    				masRsvService.updateCancelRsv(rsvVO);
	    			}
	    		}
	    	}
	    	
	    	// 처리가 정상적이지 않은 경우 환불요청 처리
	    	if(Constant.FLAG_N.equals(success)){
	    		// RSV_STATUS_CD_SREQ(RS12 : 부분환불요청)
	    		spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_SREQ);    		
	    		
	    		// 취소금액
	    		spRsvVO.setCancelAmt(spRsvVO.getRefundAmt());
	    		spRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
	    		spRsvVO.setCmssAmt("0");
	    		webOrderService.updateSpCancelDtlRsv(spRsvVO);
	    		
	    		resultMap.put("success", Constant.FLAG_Y);
	    	}
		}		
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	
   		return mav;
	}
	
	/**
	 * 당일 사용 변경 조회
	 * Function : usedPrdtList
	 * 작성일 : 2016. 10. 14. 오전 10:53:30
	 * 작성자 : 정동수
	 * @param splyCorpDftId
	 * @param telNum
	 * @param userNm
	 * @return
	 */
	@RequestMapping("/api/usedPrdtList.ajax")
    public ModelAndView usedPrdtList(	@RequestParam("splyCorpDftId") String splyCorpDftId,
    									@RequestParam("telNum") String telNum,
    									@RequestParam("userNm") String userNm){
    	
    	log.info("/api/usedPrdtList.ajax 호출");
    	
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	POSVO posVO = new POSVO();
    	posVO.setAgentCorpId(splyCorpDftId);
    	posVO.setTelNum(telNum);
    	posVO.setUserNm(userNm);
    	
    	List<POSVO> resultList = apiPosService.selectByUsedPrdtList(posVO);
    	   	
    	resultMap.put("success", "Y");
    	resultMap.put("resultList", resultList);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	
   		return mav;
    }
	
	/**
	 * 사용현황
	 * Function : dayStat
	 * 작성일 : 2016. 10. 14. 오후 1:44:36
	 * 작성자 : 정동수
	 * @param splyCorpDftId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/api/dayStat.ajax")
    public ModelAndView dayStat(	@RequestParam("splyCorpDftId") String splyCorpDftId) throws Exception{
    	
    	log.info("/api/dayStat.ajax 호출");
    	
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	POSVO posVO = new POSVO();
    	posVO.setAgentCorpId(splyCorpDftId);
    
    	POSVO dayStatList = apiPosService.selectByDayStat(posVO);
    	List<POSVO> resultList = new ArrayList<POSVO>();
    	resultList.add(dayStatList);
    	
    	resultMap.put("dayStatList", resultList);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	
   		return mav;
    }
}
