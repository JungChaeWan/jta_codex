package api.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import mas.rc.vo.RC_PRDTINFSVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.corp.service.OssCorpService;
import web.order.vo.RC_RSVVO;
import api.service.APIRcService;
import api.service.APIService;
import common.Constant;
import egovframework.cmmn.service.EgovStringUtil;

@Controller
public class APIRcController {
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Autowired
	private DefaultBeanValidator beanValidator;
	
	@Resource(name="ossCorpService")
	private OssCorpService ossCorpService;
	
	@Resource(name="apiService")
	private APIService apiService;
	
	@Resource(name="apiRcService")
	private APIRcService apiRcService;

	@RequestMapping("/api/rc/reservation.ajax")
	public ModelAndView reservation(@RequestParam Map<String,String> params){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		/*******************************************************
		 * Validation Check
		 * 1. 파라미터 존재여부 체크
		 * 2. 날짜형식 체크
		 * 3. 시분 형식 체크
		 *******************************************************/
		boolean vChk = false;
		String chkParam = "";
		
		// 연계 아이디 존재 여부 확인
		if(EgovStringUtil.isEmpty(params.get("linkId"))){
			vChk = true;
			chkParam = "linkId";
		}
		// 연계 예약 아이디 존재 여부 확인
		if(EgovStringUtil.isEmpty(params.get("linkRsvNum"))){
			vChk = true;
			chkParam = "linkRsvNum";
		}
		// 예약 시작일자 존재 여부 확인
		if(EgovStringUtil.isEmpty(params.get("rentStartDt"))){
			vChk = true;
			chkParam = "rentStartDt";
		}
		// 예약 종료일자 존재 여부 확인
		if(EgovStringUtil.isEmpty(params.get("rentEndDt"))){
			vChk = true;
			chkParam = "rentEndDt";
		}
		// 예약 시작시간 존재 여부 확인
		if(EgovStringUtil.isEmpty(params.get("rentStartTm"))){
			vChk = true;
			chkParam = "rentStartTm";
		}
		// 예약 종료시간 존재 여부 확인
		if(EgovStringUtil.isEmpty(params.get("rentEndTm"))){
			vChk = true;
			chkParam = "rentEndTm";
		}
		// 수정 구분값 존재 여부 확인
		if(EgovStringUtil.isEmpty(params.get("modYn"))){
			vChk = true;
			chkParam = "modYn";
		}
		
		if(vChk){
			resultMap.put("rtnCode", "ERR");
			resultMap.put("errorCode", "1000");
			resultMap.put("errorMsg", "(" + chkParam + ") 파라미터가 존재하지 않습니다.");
			
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}
		// END.. Validation1...
		
		// 예약시작일자 날짜형식 체크
		if(!EgovStringUtil.checkDate(params.get("rentStartDt"))){
			vChk = true;
			chkParam = "rentStartDt";
		}
		// 예약종료일자 날짜형식 체크
		if(!EgovStringUtil.checkDate(params.get("rentEndDt"))){
			vChk = true;
			chkParam = "rentEndDt";
		}
		// 예약시작시간 시간형식 체크
		if(!EgovStringUtil.checkTime(params.get("rentStartTm"))){
			vChk = true;
			chkParam = "rentStartTm";
		}
		// 예약종료시간 시간형식 체크
		if(!EgovStringUtil.checkTime(params.get("rentEndTm"))){
			vChk = true;
			chkParam = "rentEndTm";
		}
		
		if(vChk){
			resultMap.put("rtnCode", "ERR");
			resultMap.put("errorCode", "1001");
			resultMap.put("errorMsg", "(" + chkParam + ") 파라미터 형식이 올바르지 않습니다.");
			
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}
		
		// 1. 연계 아이디를 통한 상품번호 구하기
		RC_PRDTINFSVO rcPrdtSVO = new RC_PRDTINFSVO();
		
		String prdtNum = apiRcService.selectByPrdtNumAtLinkNum(rcPrdtSVO);
		
		// 2. 상품번호가 존재하지 않으면 존재하지 않는 상품이라고 리턴
		if(EgovStringUtil.isEmpty(prdtNum)){
			resultMap.put("rtnCode", "ERR");
			resultMap.put("errorCode", "1002");
			resultMap.put("errorMsg", "연계된 상품이 존재하지 않습니다.");
			
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}
		
		// 3. 존재하는 상품번호라면 수정여부에 따른 분기
		if(Constant.FLAG_Y.equals(params.get("modYn"))){
			// 4. TODO 예약 수정건이라면 기 존재하는 예약건을 삭제(해당 연계예약번호가 없는 경우엔?)
			
		}
		
		// 5. 이용내역 테이블에 예약 정보 등록
		RC_RSVVO rcRsvVO = new RC_RSVVO();
		rcRsvVO.setPrdtNum(prdtNum);
		rcRsvVO.setRentStartDt(params.get("rentStartDt"));
		rcRsvVO.setRentEndDt(params.get("rentEndDt"));
		rcRsvVO.setRentStartTm(params.get("rentStartTm"));
		rcRsvVO.setRentEndTm(params.get("rentEndTm"));
		rcRsvVO.setMappingRsvNum(params.get("linkRsvNum"));
		
		apiRcService.insertRcHist(rcRsvVO);
		
		resultMap.put("rtnCode", "OK");
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	/**
	 * 예약 취소 처리
	 * 연계 예약번호에 대한 사용 내역을 삭제한다.
	 * 파일명 : cancelRsv
	 * 작성일 : 2016. 7. 20. 오후 2:14:13
	 * 작성자 : 최영철
	 * @param params
	 * @return
	 */
	@RequestMapping("/api/rc/cancelRsv.ajax")
	public ModelAndView cancelRsv(@RequestParam Map<String,String> params){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		/*******************************************************
		 * Validation Check
		 * 1. 파라미터 존재여부 체크
		 *******************************************************/
		
		boolean vChk = false;
		String chkParam = "";
		
		// 연계 아이디 존재 여부 확인
		if(EgovStringUtil.isEmpty(params.get("linkId"))){
			vChk = true;
			chkParam = "linkId";
		}
		// 연계 예약 아이디 존재 여부 확인
		if(EgovStringUtil.isEmpty(params.get("linkRsvNum"))){
			vChk = true;
			chkParam = "linkRsvNum";
		}
		
		if(vChk){
			resultMap.put("rtnCode", "ERR");
			resultMap.put("errorCode", "1000");
			resultMap.put("errorMsg", "(" + chkParam + ") 파라미터가 존재하지 않습니다.");
			
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}
		// END.. Validation1...
		
		RC_RSVVO rcRsvVO = new RC_RSVVO();
		rcRsvVO.setMappingRsvNum(params.get("linkRsvNum"));
		apiRcService.deleteRcUseHist(rcRsvVO);
		resultMap.put("rtnCode", "OK");
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
}

