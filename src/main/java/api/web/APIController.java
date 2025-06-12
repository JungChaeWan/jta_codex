package api.web;

import api.service.APILsService;
import api.service.APIService;
import api.vo.*;
import common.Constant;
import common.LowerHashMap;
import mas.prmt.vo.PRMTVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rsv.service.MasRsvService;
import mas.sv.service.MasSvService;
import mas.sv.vo.SV_DIVINFVO;
import mas.sv.vo.SV_OPTINFVO;
import mas.sv.vo.SV_PRDTINFVO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import web.order.service.WebOrderService;
import web.order.vo.RSVVO;
import web.order.vo.SP_RSVVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class APIController {
	
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Autowired
	private DefaultBeanValidator beanValidator;
	
	@Resource(name="ossCorpService")
	private OssCorpService ossCorpService;
	
	@Resource(name="masRcPrdtService")
	private MasRcPrdtService masRcPrdtService;
	
	@Resource(name="apiService")
	private APIService apiService;

	@Resource(name = "apiLsService")
	private APILsService apiLsService;

	@Resource(name="masRsvService")
    private MasRsvService masRsvService;

	@Resource(name="webOrderService")
    private WebOrderService webOrderService;

	@Resource(name = "masSvService")
	private MasSvService masSvService;

	/** 통합몰 업체인증*/
	@ResponseBody
	@RequestMapping("/api/mall/corpCert.do")
    public Map<String,Object> corpCert(@RequestBody HashMap<String, Object> map){
		Map<String,Object> reulstMap = new HashMap<>();
		reulstMap.put("resultCode",200);

		if(map.get("corpId") != null ? true :false){
			String apiKey =  apiService.corpCert(map);
			if(!"0".equals(apiKey)){
				reulstMap.put("resultCode",200);
				reulstMap.put("apiKey",apiKey);
			}else{
				reulstMap.put("resultCode",400);
			}
		}else{
			reulstMap.put("resultCode",400);
		}

		return reulstMap;
	}

	/** 통합몰 주문날짜확인*/
	@ResponseBody
	@RequestMapping("/api/mall/rsvList.do")
    public Map<String,Object> rsvList(@RequestBody HashMap<String, Object> map) throws Exception {
		Map<String,Object> reulstMap = new HashMap<>();
		reulstMap.put("resultCode",200);
		if(map.get("apiKey") != null ? true :false){
			String corpId =  apiService.selectCorpId(map);
			if(!"0".equals(corpId)){
				map.put("corpId",corpId);
				List<HashMap<String,Object>> items = apiService.selectMallRsvList(map);
				if(items.size() > 0){
					reulstMap.put("items",items);
					reulstMap.put("resultCode",200);
				}else{
					reulstMap.put("resultCode",204);
				}
			}else{
				reulstMap.put("resultCode",400);
			}
		}else{
			reulstMap.put("resultCode",400);
		}
		return reulstMap;
	}

	/** 통합몰 주문상세확인*/
	@ResponseBody
	@RequestMapping("/api/mall/rsvDetail.do")
    public Map<String,Object> rsvDetail(@RequestBody HashMap<String, Object> map) throws Exception {
		Map<String,Object> reulstMap = new HashMap<>();
		reulstMap.put("resultCode",200);
		if(map.get("apiKey") != null ? true :false){
			String corpId =  apiService.selectCorpId(map);
			if(!"0".equals(corpId)){
				map.put("corpId",corpId);
				List<HashMap<String,Object>> items = apiService.selectMallRsvDetail(map);
				if(items.size() > 0){
					reulstMap.put("items",items);
					reulstMap.put("resultCode",200);
				}else{
					reulstMap.put("resultCode",204);
				}
			}else{
				reulstMap.put("resultCode",400);
			}
		}else{
			reulstMap.put("resultCode",400);
		}
		return reulstMap;
	}

	/** 통합몰 상품업데이트*/
	@ResponseBody
	@RequestMapping("/api/mall/uptProduct.do")
    public Map<String,Object> uptProduct(@RequestBody HashMap<String, Object> map) throws Exception {
		Map<String,Object> reulstMap = new HashMap<>();
		reulstMap.put("resultCode",200);
		String corpId = "";

		if(map.get("apiKey") != null ? true :false){
			corpId =  apiService.selectCorpId(map);
			map.put("corpId",corpId);
			if("0".equals(corpId)){
				reulstMap.put("resultCode",401);
				return reulstMap;
			}
		}else{
			reulstMap.put("resultCode",400);
			return reulstMap;
		}

		if(map.get("prdtNum") != null ? true :false){
			apiService.updatePrdt(map);
		}else{
			reulstMap.put("resultCode",400);
			return reulstMap;
		}

		if(map.get("items") != null ? true :false){
			List<HashMap<String,Object>> list = new ArrayList<>();
			list = (List<HashMap<String,Object>>)map.get("items");
			for (HashMap<String,Object> temp : list){
				temp.put("prdtNum",map.get("prdtNum"));
				if(temp.get("svDivSn") != null ? true :false && temp.get("svDivNm") != null ? true :false){
					apiService.updateDiv(temp);
					apiService.updateOpt(temp);
				}
			}
		}


		return reulstMap;
	}

	/** 통합몰 상품등록*/
	@ResponseBody
	@RequestMapping("/api/mall/regProduct.do")
    public Map<String,Object> totalmall(@RequestBody HashMap<String, Object> map) throws Exception {
		Map<String,Object> reulstMap = new HashMap<>();
		reulstMap.put("resultCode",200);

        SV_PRDTINFVO requestInfo = new SV_PRDTINFVO() ;
        List<Integer> arraySpDivSn = new ArrayList<Integer>();

		if(map.get("apiKey") != null ? true :false){
			String corpId =  apiService.selectCorpId(map);
			if(!"0".equals(corpId)){
				requestInfo.setCorpId(corpId);
			}else{
				reulstMap.put("resultCode",401);
				return reulstMap;
			}
		}else{
			reulstMap.put("resultCode",400);
		}

		if(map.get("prdtNm") != null ? true :false){
			requestInfo.setPrdtNm(map.get("prdtNm").toString());
		}else{
			reulstMap.put("resultCode",400);
		}

		if(map.get("tradeStatus") != null ? true :false){
			requestInfo.setTradeStatus(map.get("tradeStatus").toString());
		}else{
			reulstMap.put("resultCode",400);
		}

		if(map.get("ctgr") != null ? true :false){
			requestInfo.setCtgr(map.get("ctgr").toString());
		}else{
			reulstMap.put("resultCode",400);
		}

		if(map.get("subCtgr") != null ? true :false){
			requestInfo.setSubCtgr(map.get("subCtgr").toString());
		}else{
			reulstMap.put("resultCode",400);
		}

        if(map.get("saleStartDt") != null ? true :false){
			requestInfo.setSaleStartDt(map.get("saleStartDt").toString());
		}else{
			reulstMap.put("resultCode",400);
		}

        if(map.get("saleEndDt") != null ? true :false){
			requestInfo.setSaleEndDt(map.get("saleEndDt").toString());
		}else{
			reulstMap.put("resultCode",400);
		}

        if(map.get("prdtInf") != null ? true :false){
			requestInfo.setPrdtInf(map.get("prdtInf").toString());
		}

        if(map.get("dlvGuide") != null ? true :false){
			requestInfo.setDlvGuide(map.get("dlvGuide").toString());
		}

        if(map.get("cancelGuide") != null ? true :false){
			requestInfo.setCancelGuide(map.get("cancelGuide").toString());
		}

        if(map.get("tkbkGuide") != null ? true :false){
			requestInfo.setTkbkGuide(map.get("tkbkGuide").toString());
		}

        if(map.get("hdlPrct") != null ? true :false){
			requestInfo.setHdlPrct(map.get("hdlPrct").toString());
		}

        if(map.get("apiImgThumb") != null ? true :false){
			requestInfo.setApiImgThumb(map.get("apiImgThumb").toString());
		}

        if(map.get("apiImgDetail") != null ? true :false){
			requestInfo.setApiImgDetail(map.get("apiImgDetail").toString());
		}

        requestInfo.setFrstRegId("admin");
		requestInfo.setFrstRegIp("0.0.0.0");
		requestInfo.setLastModId("admin");
		requestInfo.setLastModIp("0.0.0.0");

        String fileList = "";
        String prdtNum = masSvService.insertSvPrdtInf(requestInfo, fileList);
        reulstMap.put("prdtNum", prdtNum);

        if(map.get("items") != null ? true :false){
        	List<HashMap<String,Object>> list = new ArrayList<>();
        	list = (List<HashMap<String,Object>>)map.get("items");
        	for (HashMap<String,Object> temp : list){
				SV_DIVINFVO svDivinfo = new SV_DIVINFVO();
				SV_OPTINFVO svOptinfo = new SV_OPTINFVO();
				if(temp.get("svDivSn") != null ? true :false && temp.get("svDivNm") != null ? true :false){
					svDivinfo.setPrdtNum(prdtNum);
					svDivinfo.setSvDivSn((Integer)temp.get("svDivSn"));
					svDivinfo.setPrdtDivNm(temp.get("svDivNm").toString());
					svDivinfo.setViewSn(temp.get("svDivSn").toString());
					svDivinfo.setPrintYn("Y");

					svOptinfo.setPrdtNum(prdtNum);
					svOptinfo.setSvDivSn((Integer)temp.get("svDivSn"));
					svOptinfo.setPrdtDivNm(temp.get("svDivNm").toString());

					/** 상품구분 없으면 추가 */
					if(!arraySpDivSn.contains((Integer)temp.get("svDivSn"))){
						/** 추가로직*/
						masSvService.insertSvDivInf2(svDivinfo);
						/** 옵션구분 */
						arraySpDivSn.add((Integer)temp.get("svDivSn"));
					}
				}else{
					reulstMap.put("resultCode",400);
					break;
				}

				if(temp.get("svOptSn") != null ? true :false){
					svOptinfo.setSvOptSn((Integer)temp.get("svOptSn"));
				}else{
					reulstMap.put("resultCode",400);
					break;
				}

				if(temp.get("optNm") != null ? true :false){
					svOptinfo.setOptNm(temp.get("optNm").toString());
				}else{
					reulstMap.put("resultCode",400);
					break;
				}

				if(temp.get("nmlAmt") != null ? true :false){
					svOptinfo.setNmlAmt((Integer) temp.get("nmlAmt"));
				}else{
					reulstMap.put("resultCode",400);
					break;
				}

				if(temp.get("saleAmt") != null ? true :false){
					svOptinfo.setSaleAmt((Integer) temp.get("saleAmt"));
				}else{
					reulstMap.put("resultCode",400);
					break;
				}

				if(temp.get("optPrdtNum") != null ? true :false){
					svOptinfo.setOptPrdtNum((Integer) temp.get("optPrdtNum"));
				}else{
					reulstMap.put("resultCode",400);
					break;
				}

				if(temp.get("dlvAmtDiv") != null ? true :false){
					svOptinfo.setDlvAmtDiv(temp.get("dlvAmtDiv").toString());
				}else{
					reulstMap.put("resultCode",400);
				}

				if(temp.get("dlvAmt") != null ? true :false){
					svOptinfo.setDlvAmt(temp.get("dlvAmt").toString());
				}

				if(temp.get("inDlvAmt") != null ? true :false){
					svOptinfo.setInDlvAmt(temp.get("inDlvAmt").toString());
				}

				svOptinfo.setPrintYn("Y");
				svOptinfo.setDdlYn("N");
				svOptinfo.setViewSn(temp.get("svOptSn").toString());
				masSvService.insertOptInf(svOptinfo);
			}
		}
        return reulstMap;
    }

	/** 문자발송 임시개발*/
	@RequestMapping("/email.do")
    public String vpIssue(String rsvNum, HttpServletRequest request){
		RSVVO rsvVO = new RSVVO();
		rsvVO.setRsvNum(rsvNum);
		webOrderService.orderCompleteSnedSMSMailResend(rsvVO,request);
        return "";
    }
    
    /** 수량막기 임시개발*/
    @RequestMapping("/web/daehongPreventSaleNum.ajax")
	public ModelAndView daehongPreventSaleNum(	HttpServletRequest request) {
    	String telNum = "";
    	if(request.getParameter("telNum") != null){
    		telNum = request.getParameter("telNum");
		};
    	Map<String, Object> resultMap = new HashMap<String, Object>();
		int resultCnt =  apiService.daehongPreventSaleNum(telNum);
		resultMap.put("resultCnt",resultCnt);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
    
    

	@RequestMapping(value="/consume/{orderId}")
	public ModelAndView lsCompanyConsume(@PathVariable("orderId") String orderId){
		log.info("lsCompanyConsume : /consume/" + orderId);

		Map<String, Object> resultMap = new HashMap<String, Object>();

		SP_RSVVO spRsvVO = new SP_RSVVO();
		spRsvVO.setSpRsvNum(orderId);
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

	@RequestMapping(value="/restore/{orderId}")
	public ModelAndView lsCompanyRevoke(@PathVariable("orderId") String orderId){
		log.info("lsCompanyConsume : /restore/" + orderId);

		Map<String, Object> resultMap = new HashMap<String, Object>();

		SP_RSVVO spRsvVO = new SP_RSVVO();
		spRsvVO.setSpRsvNum(orderId);
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

	@RequestMapping("/web/requestUseableLsCompanyProduct.ajax")
	public ModelAndView requestUseableLsCompanyProduct(	@ModelAttribute("APILSVO") APILSVO apilsVO) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
		APILSRESULTVO resultVO =  apiLsService.requestUseableLsCompanyProduct(apilsVO);
		if(Constant.API_OK.equals(resultVO.getCode())){
			resultMap.put("success",resultVO.getMessage() + " " + resultVO.getPrNm() + " " + resultVO.getOtNm()  );
		}else{
			resultMap.put("success",resultVO.getMessage());
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/**
	 * 실시계 예약 URL 조회 API
	 * 
	 * @return
	 */
	@RequestMapping(value="/api/detailProductByCorp.do", produces = "application/json; charset=utf8")
	public @ResponseBody Map<String, Object> detailProductByCorp(@ModelAttribute("API_REALURL")ParamVO paramVO, 
			HttpServletRequest request){
		log.info("/api/detailProductByCorp.do call");
   		Map<String, Object> resultMap = new HashMap<String, Object>();
   		try {
	   		//validation 체크
	   		ERRORVO errorVO = APIValidation.isEmptyOrWhitespace(paramVO, new String[]{"corpId"});
	   		if(errorVO != null) {
	   			resultMap.put("error", errorVO);
	   			return resultMap;
	   		}
	   		CORPVO corpSVO = new CORPVO();
	   		corpSVO.setCorpId(paramVO.getCorpId());
	   		CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
	   		// corpVO 가 null 일 경우.
	   		errorVO = APIValidation.isWrongCorp("corpId", corpVO);
	   		if(errorVO != null) {
	   			resultMap.put("error", errorVO);
	   			return resultMap;
	   		}
	   		// 업체 상품 체크
	   		errorVO = apiService.checkPrdtByCorp(corpVO);
	   		if(errorVO != null) {
	   			resultMap.put("error", errorVO);
	   			return resultMap;
	   		}
	   		
	   		DtlPrdtVO resultVO = apiService.detailProductByCorp(corpVO, request);
			resultMap.put("results", resultVO);
		return resultMap;
   		} catch(Exception ex) {
   			ERRORVO errorVO = APIValidation.isExcepton();
   			resultMap.put("error", errorVO);
   			return resultMap;
   		}
	}
	
	/**
	 * 비짓제주 연계 API
	 * 
	 * @return
	 */
	@RequestMapping(value="/api/detailProductByVisitjeju.do", produces = "application/json; charset=utf8")
	public @ResponseBody Map<String, Object> detailProductByVisitjeju(@ModelAttribute("API_REALURL")ParamVO paramVO, 
			HttpServletRequest request){
		log.info("/api/detailProductByVisitjeju.do call");
   		Map<String, Object> resultMap = new HashMap<String, Object>();
   		try {
	   		//validation 체크
	   		ERRORVO errorVO = APIValidation.isEmptyOrWhitespace(paramVO, new String[]{"conId"});
	   		if(errorVO != null) {
	   			resultMap.put("error", errorVO);
	   			return resultMap;
	   		}
	   		CORPVO corpSVO = new CORPVO();
	   		corpSVO.setVisitMappingId(paramVO.getConId());
	   		CORPVO corpVO = ossCorpService.selectByCorpVisitJeju(corpSVO);
	   		// corpVO 가 null 일 경우.
	   		errorVO = APIValidation.isWrongCorp("conId", corpVO);
	   		if(errorVO != null) {
	   			resultMap.put("error", errorVO);
	   			return resultMap;
	   		}
	   		// 업체 상품 체크
	   		errorVO = apiService.checkPrdtByCorp(corpVO);
	   		if(errorVO != null) {
	   			resultMap.put("error", errorVO);
	   			return resultMap;
	   		}
	   		
	   		DtlPrdtVO resultVO = apiService.detailProductByVisitjeju(corpVO, request);
			resultMap.put("results", resultVO);
		return resultMap;
   		} catch(Exception ex) {
   			ERRORVO errorVO = APIValidation.isExcepton();
   			resultMap.put("error", errorVO);
   			return resultMap;
   		}
	}
	
	/**
	 * 소셜상품 목록 조회 API
	 * @return
	 */
	@RequestMapping(value="/api/spProductList.do", produces = "application/json; charset=utf8")
	public @ResponseBody Map<String, Object> spProductList(@ModelAttribute("API_SPRPDTS")ParamVO paramVO, 
			HttpServletRequest request) {
		log.info("/api/spProductList.do call");
   		Map<String, Object> resultMap = new HashMap<String, Object>();
   		try {
	   		ERRORVO errorVO = APIValidation.isEmptyOrWhitespace(paramVO,new String[] {"ctgr"});
	   		if(errorVO != null) {
	   			resultMap.put("error", errorVO);
	   			return resultMap;
	   		}
	   		
	   		List<SPPRDTSVO> resultVO = apiService.spProductList(paramVO, request);
	   		resultMap.put("results", resultVO);
	   		return resultMap;
   		} catch(Exception ex) {
   			ERRORVO errorVO = APIValidation.isExcepton();
   			resultMap.put("error", errorVO);
   			return resultMap;
   		}
	}
	
	@RequestMapping(value="/api/rentacarList.do", produces = "application/json; charset=utf8")
	public @ResponseBody Map<String, Object> rentacarList(HttpServletRequest request) {
		log.info("/api/rentacarList.do call");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			
			List<RCSVO> resultVO = apiService.rcList(request);
			resultMap.put("results", resultVO);
			return resultMap;
		} catch(Exception ex) {
			ERRORVO errorVO = APIValidation.isExcepton();
   			resultMap.put("error", errorVO);
   			return resultMap;
		}
	}
	
	/**
	 * 연계 설정/해제
	 * 파일명 : changeLinkPrdt
	 * 작성일 : 2016. 12. 5. 오전 10:35:37
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 * @return
	 */
	@RequestMapping("/apiCn/rc/changeLinkPrdt.ajax")
	public ModelAndView changeLinkPrdt(RC_PRDTINFVO prdtInfVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			URL url = new URL("http://220.124.212.99:4567/Xml/Tam/saveCar.aspx?car_code" + prdtInfVO.getPrdtNum() + "&use=" + prdtInfVO.getPrdtLinkYn());
			
		} catch (Exception e) {
			 
		}
		
		masRcPrdtService.updatePrdtLinkYn(prdtInfVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
		return mav;
	}

	/** 비짓제주API */
	@RequestMapping("/api/visitjejuList.do")
	public ModelAndView visitjejuList(HttpServletRequest request){
		String visitjejuKey = "tamnao1!";

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultCode",200);
		resultMap.put("resultMessage","OK");

		/** 권한 미획득 */
		if(!visitjejuKey.equals(request.getHeader("Authorization"))){
			resultMap.put("resultCode",401);
			resultMap.put("resultMessage","Unauthorized");
		}else{
			List<LowerHashMap> resultList = apiService.visitjejuList();

			/** 리스트 없음 */
			if(resultList.size() < 1){
				resultMap.put("resultCode",204);
				resultMap.put("resultMessage","No Content");
			}else{
				resultMap.put("list", resultList);
			}
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
		return mav;
	}

	/** 현대카드 신청건수API  */
	@RequestMapping("/api/hdcReqCnt.do")
	public String hdcReqCnt(ModelMap model, HttpServletRequest request){

		String key = request.getParameter("key");
		if(key != null && key.equals("tamnao")){
			List<LowerHashMap> resultList = apiService.hdcReqCnt();
			model.addAttribute("resultCd", "200");
			model.addAttribute("resultMsg", "OK");
			model.addAttribute("resultList", resultList);
		}else{
			model.addAttribute("resultCd", "401");
			model.addAttribute("resultMsg", "Unauthorized");
		}
		return "/apiCn/hdcReqCnt";
	}
	
	/** 프로모션 인증 리스트  http://localhost:8080/api/prmtAuthList.do?prmtNum=PM00001545 */
	@RequestMapping("/api/prmtAuthList.do")
	public String prmtAuthList(ModelMap model, HttpServletRequest request){

		String prmtNum = request.getParameter("prmtNum");
		PRMTVO prmtVO = new PRMTVO();
		prmtVO.setPrmtNum(prmtNum);
		if(prmtNum != null){
			List<LowerHashMap> resultList = apiService.prmtAuthList(prmtVO);
			model.addAttribute("resultCd", "200");
			model.addAttribute("resultMsg", "OK");
			model.addAttribute("resultList", resultList);
		}else{
			model.addAttribute("resultCd", "401");
			model.addAttribute("resultMsg", "Unauthorized");
		}
		return "/apiCn/prmtAuthList";
	}
}

