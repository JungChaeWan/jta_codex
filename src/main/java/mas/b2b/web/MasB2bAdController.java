package mas.b2b.web;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.ADCALENDARVO;
import mas.ad.vo.AD_PRDTINFSVO;
import mas.ad.vo.AD_PRDTINFVO;
import mas.b2b.service.MasB2bAdService;
import mas.b2b.vo.B2B_AD_AMTGRPSVO;
import mas.b2b.vo.B2B_AD_AMTGRPVO;
import mas.b2b.vo.B2B_AD_AMTSVO;
import mas.b2b.vo.B2B_AD_AMTVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpService;
import oss.user.vo.USERVO;

import common.Constant;
import common.EgovUserDetailsHelper;

import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class MasB2bAdController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "masB2bAdService")
	private MasB2bAdService masB2bAdService;
	
	@Resource(name = "masAdPrdtService")
	private MasAdPrdtService masAdPrdtService;
	
	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;
	
	@Resource(name = "ossCorpService")
	private OssCorpService ossCorpService;
	
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    @RequestMapping("/mas/b2b/ad/corpGrpList.do")
    public String corpGrpList(@ModelAttribute("searchVO") B2B_AD_AMTGRPSVO amtGrpSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	amtGrpSVO.setsCorpId(corpInfo.getCorpId());
    	List<B2B_AD_AMTGRPVO> amtGrpList = masB2bAdService.selectAmtGrpList(amtGrpSVO);
    	
    	amtGrpSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	amtGrpSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(amtGrpSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(amtGrpSVO.getPageUnit());
		paginationInfo.setPageSize(amtGrpSVO.getPageSize());

		amtGrpSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		amtGrpSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		amtGrpSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = masB2bAdService.selectB2bCorpGrpList(amtGrpSVO);
		
		@SuppressWarnings("unchecked")
		List<B2B_AD_AMTGRPVO> resultList = (List<B2B_AD_AMTGRPVO>) resultMap.get("resultList");
    	
    	model.addAttribute("amtGrpList", amtGrpList);
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
    	return "mas/b2b/ad/b2bCorpGrp";
    }
    
    /**
     * 그룹 등록
     * 파일명 : insertAmtGrp
     * 작성일 : 2016. 9. 27. 오후 3:25:51
     * 작성자 : 최영철
     * @param amtGrpVO
     * @return
     */
    @RequestMapping("/mas/b2b/ad/insertAmtGrp.ajax")
    public ModelAndView insertAmtGrp(@ModelAttribute("B2B_AD_AMTGRPVO") B2B_AD_AMTGRPVO amtGrpVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	amtGrpVO.setCorpId(corpInfo.getCorpId());
    	amtGrpVO.setRegId(corpInfo.getUserId());
    	
    	masB2bAdService.insertAmtGrp(amtGrpVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 그룹 수정
     * 파일명 : updateAmtGrp
     * 작성일 : 2016. 9. 27. 오후 4:49:22
     * 작성자 : 최영철
     * @param amtGrpVO
     * @return
     */
    @RequestMapping("/mas/b2b/ad/updateAmtGrp.ajax")
    public ModelAndView updateAmtGrp(@ModelAttribute("B2B_AD_AMTGRPVO") B2B_AD_AMTGRPVO amtGrpVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	amtGrpVO.setCorpId(corpInfo.getCorpId());
    	amtGrpVO.setModId(corpInfo.getUserId());
    	
    	masB2bAdService.updateAmtGrp(amtGrpVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 업체 그룹 등록
     * 파일명 : updateCorpGrp
     * 작성일 : 2016. 9. 28. 오전 11:20:50
     * 작성자 : 최영철
     * @param amtGrpVO
     * @return
     */
    @RequestMapping("/mas/b2b/ad/updateCorpGrp.ajax")
    public ModelAndView updateCorpGrp(@ModelAttribute("B2B_AD_AMTGRPVO") B2B_AD_AMTGRPVO amtGrpVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	amtGrpVO.setCorpId(corpInfo.getCorpId());
    	amtGrpVO.setRegId(corpInfo.getUserId());
    	
    	if(EgovStringUtil.isEmpty(amtGrpVO.getAmtGrpNum())){
    		masB2bAdService.deleteCorpGrp(amtGrpVO);
    	}else{
    		masB2bAdService.mergeCorpGrp(amtGrpVO);
    	}
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 해당 요금 그룹 삭제
     * 파일명 : deleteChkAmtGrp
     * 작성일 : 2016. 9. 28. 오후 1:56:29
     * 작성자 : 최영철
     * @param amtGrpVO
     * @return
     */
    @RequestMapping("/mas/b2b/ad/deleteAmtGrp.ajax")
    public ModelAndView deleteChkAmtGrp(@ModelAttribute("B2B_AD_AMTGRPVO") B2B_AD_AMTGRPVO amtGrpVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	amtGrpVO.setCorpId(corpInfo.getCorpId());
    	amtGrpVO.setRegId(corpInfo.getUserId());
    	
    	List<B2B_AD_AMTGRPVO> resultList = masB2bAdService.selectCorpAmtList(amtGrpVO);
    	
    	if(resultList.size() > 0){
    		resultMap.put("success", Constant.FLAG_N);
    		resultMap.put("rtnMsg", "해당 요금 그룹은 사용중입니다.");
    	}else{
    		masB2bAdService.deleteAmtGrp(amtGrpVO);
    		resultMap.put("success", Constant.FLAG_Y);
    	}
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }
    
    /**
     * 그룹요금관리
     * 파일명 : corpGrpAmtList
     * 작성일 : 2016. 9. 29. 오후 3:36:35
     * 작성자 : 최영철
     * @param amtGrpSVO
     * @param ad_PRDINFSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/ad/corpGrpAmtList.do")
    public String corpGrpAmtList(@ModelAttribute("amtGrpSVO") B2B_AD_AMTGRPSVO amtGrpSVO,
    		@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	amtGrpSVO.setsCorpId(corpInfo.getCorpId());
    	List<B2B_AD_AMTGRPVO> amtGrpList = masB2bAdService.selectAmtGrpList(amtGrpSVO);
    	
    	ad_PRDINFSVO.setsCorpId(corpInfo.getCorpId());
    	
    	ad_PRDINFSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	ad_PRDINFSVO.setPageSize(propertiesService.getInt("pageSize"));
		

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(ad_PRDINFSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(ad_PRDINFSVO.getPageUnit());
		paginationInfo.setPageSize(ad_PRDINFSVO.getPageSize());

		ad_PRDINFSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		ad_PRDINFSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		ad_PRDINFSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> resultMap = masAdPrdtService.selectAdPrdinfList(ad_PRDINFSVO);
		
		@SuppressWarnings("unchecked")
		List<AD_PRDTINFVO> resultList = (List<AD_PRDTINFVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	model.addAttribute("corpId", corpInfo.getCorpId());
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 거래상태코드
		List<CDVO> cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCd", cdList);
    	
    	model.addAttribute("amtGrpList", amtGrpList);
    	
    	return "mas/b2b/ad/b2bCorpGrpAmtList";
    }
    
    /**
     * 그룹별 요금 관리
     * 파일명 : corpGrpAmt
     * 작성일 : 2016. 9. 29. 오후 3:36:51
     * 작성자 : 최영철
     * @param amtGrpVO
     * @param adCalendarVO
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/b2b/ad/corpGrpAmt.do")
    public String corpGrpAmt(@ModelAttribute("amtGrpVO") B2B_AD_AMTGRPVO amtGrpVO,
    		@ModelAttribute("ADCALENDARVO") ADCALENDARVO adCalendarVO,
			@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
			ModelMap model){
    	//객실 기본정보
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());  	
   		
   		AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);
   		model.addAttribute("adPrdinf", ad_PRDINFVORes);
   		
   		amtGrpVO = masB2bAdService.selectByAmtGrp(amtGrpVO);
   		
    	model.addAttribute("amtGrpVO", amtGrpVO);
   		
   	//년월 설정
   		Calendar calNow = Calendar.getInstance();
   		if( adCalendarVO.getiYear() == 0 || adCalendarVO.getiMonth()==0 ){
   			//초기에는 현재 달
   			calNow.set(Calendar.DATE, 1);
   		}else{
   			//날짜가 지정되면 그달
   			
   			int nY = adCalendarVO.getiYear();
   			int nM = adCalendarVO.getiMonth();
   			
   			//년넘어가는건 Calendar에서 알아서 처리해줌... 따라서 13월, -1월로 와도 아무 문제 없음.
   			if(adCalendarVO.getsPrevNext() != null){
	   			if("prev".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nM--;	   				
	   			}else if ("next".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nM++;
	   			}else if("prevyear".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nY--;
	   			}else if("Nextyear".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nY++;
	   			}
   			}
   			calNow.set(nY, nM-1, 1);
   		}
    	adCalendarVO.initValue(calNow);
    	
    	log.info(adCalendarVO.getWday());
    	
    	
    	adCalendarVO.setWday(changeWDayView(adCalendarVO.getWday()));
    	model.addAttribute("calendarVO", adCalendarVO );
   		
    	B2B_AD_AMTSVO amtSVO = new B2B_AD_AMTSVO();
    	amtSVO.setsAmtGrpNum(amtGrpVO.getAmtGrpNum());
    	amtSVO.setsCorpId(corpInfo.getCorpId());
    	amtSVO.setsPrdtNum(ad_PRDINFVORes.getPrdtNum());
    	String strYYYYMM = String.format("%d%02d", adCalendarVO.getiYear(), adCalendarVO.getiMonth() );
    	amtSVO.setsAplDt( strYYYYMM );
    	
    	List<B2B_AD_AMTVO> resultList = masB2bAdService.selectAmtList(amtSVO);
    	
    	int nListSize = resultList.size();
		int nListPos = 0;
		
		//달력의 각 날들 설정
    	List<ADCALENDARVO> calList = new ArrayList<ADCALENDARVO>();
    	for(int i=0; i<adCalendarVO.getiMonthLastDay(); i++){
    		ADCALENDARVO adCal = new ADCALENDARVO();
    		adCal.setiYear( adCalendarVO.getiYear() );
    		adCal.setiMonth( adCalendarVO.getiMonth() );
    		adCal.setiDay( i+1 );
    		if((adCalendarVO.getiWeek() + i)%7==0){
    			adCal.setiWeek( 7 );
    		}else{
    			adCal.setiWeek( (adCalendarVO.getiWeek() + i)%7 );
    		}
    		adCal.setsHolidayYN("N");

    		//데이터 넣기
    		if(nListPos < nListSize){
    			B2B_AD_AMTVO adAmt = resultList.get(nListPos);
	    		String strYYYYMMDD = String.format("%d%02d%02d", adCal.getiYear(), adCal.getiMonth(), adCal.getiDay() );
	    		//log.info(">>>:---------------"+strYYYYMMDD + ":" + adAmt.getAplDt());
	    		if(strYYYYMMDD.equals(adAmt.getAplDt()) ){
	    			//log.info(">>>:----------------C"+strYYYYMMDD + ":"+adAmt.getSaleAmt()+":"+adAmt.getNmlAmt() +":"+ adAmt.getHotdallYn());
	    			
	    			adCal.setSaleAmt( adAmt.getSaleAmt() );
	    			nListPos++;
	    		}
    		}

    		calList.add(adCal);
    		
    		//log.info(">>>:"+ adCal.getiDay()+" ("+adCal.getiWeek() );
    	}
    	model.addAttribute("calList", calList );
    	
    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	model.addAttribute("today", sdf.format(now) );
    	
   		return "mas/b2b/ad/amtList";
    }
    
    /**
     * 간편 입력기 적용
     * 파일명 : amtSetSimple
     * 작성일 : 2016. 9. 29. 오후 3:37:12
     * 작성자 : 최영철
     * @param amtGrpVO
     * @param adCalendarVO
     * @param ad_PRDINFVO
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/mas/b2b/ad/amtSetSimple.do")
    public String amtSetSimple(@ModelAttribute("amtGrpVO") B2B_AD_AMTGRPVO amtGrpVO,
    							@ModelAttribute("ADCALENDARVO") ADCALENDARVO adCalendarVO,
    							@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
		    					ModelMap model,
		    					HttpServletRequest request){
    	log.info("/mas/b2b/ad/amtSetSimple.do 호출");
    	
    	//객실 기본정보
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	//값넣기
    	B2B_AD_AMTVO amtVO = new B2B_AD_AMTVO();
    	amtVO.setCorpId(corpInfo.getCorpId());
    	amtVO.setAmtGrpNum(amtGrpVO.getAmtGrpNum());
    	amtVO.setPrdtNum(	ad_PRDINFVO.getPrdtNum() );
    	amtVO.setSaleAmt(	adCalendarVO.getSaleAmtSmp() );
    	
    	amtVO.setStartDt(	adCalendarVO.getStartDt() );
    	amtVO.setEndDt(	adCalendarVO.getEndDt() );
    	amtVO.setWdayList( changeWDaySql(adCalendarVO.getWday()) );
    	   	
    	masB2bAdService.mergeAmtCalSmp(amtVO);

    	return "redirect:/mas/b2b/ad/corpGrpAmt.do?prdtNum=" + ad_PRDINFVO.getPrdtNum() 
	    										+ "&iYear=" + adCalendarVO.getiYear() 
	    										+ "&iMonth="+ adCalendarVO.getiMonth() 
	    										+ "&startDt="+adCalendarVO.getStartDt() 
	    										+ "&endDt="+adCalendarVO.getEndDt() 
	    										+ "&wday="+adCalendarVO.getWday()
	    										+ "&amtGrpNum=" + amtGrpVO.getAmtGrpNum();
    }
    
    /**
     * 요금 변경
     * 파일명 : amtSetCal
     * 작성일 : 2016. 9. 29. 오후 3:37:25
     * 작성자 : 최영철
     * @param amtGrpVO
     * @param adCalendarVO
     * @param ad_PRDINFVO
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/mas/b2b/ad/amtSetCal.do")
    public String amtSetCal(@ModelAttribute("amtGrpVO") B2B_AD_AMTGRPVO amtGrpVO,
    						@ModelAttribute("ADCALENDARVO") ADCALENDARVO adCalendarVO,
    						@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
				    					ModelMap model,
				    					HttpServletRequest request){
    	//log.info("/mas/ad/amtSetCal.do 호출");
    	
    	//객실 기본정보
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());
   		
   		//받은 값 파싱
   		String[] strSaleAmts = adCalendarVO.getSaleAmt().split(",");

   		//DB에 넣을 데어터 조합
   		List<B2B_AD_AMTVO> amtList = new ArrayList<B2B_AD_AMTVO>();
   		for(int i=0; i<adCalendarVO.getiMonthLastDay(); i++){
   			String strSaleAmt = "";

   			//받은값 파싱된 데이터 넣기
   			if( strSaleAmts.length > i ){
   				strSaleAmt = strSaleAmts[i];
   			}
   			
   			//하나라도 값이 있으면 리스트에 넣기
   			if(!EgovStringUtil.isEmpty(strSaleAmt) ){
   				B2B_AD_AMTVO amtVO = new B2B_AD_AMTVO();
	   			String strYYYYMMDD = String.format("%d%02d%02d", adCalendarVO.getiYear(), adCalendarVO.getiMonth(), i+1 );
	   			
	   			amtVO.setPrdtNum( ad_PRDINFVO.getPrdtNum() );
	   			amtVO.setAplDt(strYYYYMMDD);
	   			amtVO.setSaleAmt(strSaleAmt);
	   			amtVO.setCorpId(corpInfo.getCorpId());
	   			amtVO.setAmtGrpNum(amtGrpVO.getAmtGrpNum());
	   			
	   			amtList.add(amtVO);
   			}
   		}
   		
   		//DB에 넣기
   		masB2bAdService.mergeAmtInf(amtList);   		
   		
    	
   		//return amtList(calendarVO, ad_PRDINFVO, model, request);
   		return "redirect:/mas/b2b/ad/corpGrpAmt.do?prdtNum=" + ad_PRDINFVO.getPrdtNum() 
   											+ "&iYear=" + adCalendarVO.getiYear() 
   											+ "&iMonth="+ adCalendarVO.getiMonth()
   											+ "&startDt="+adCalendarVO.getStartDt() 
    										+ "&endDt="+adCalendarVO.getEndDt() 
    										+ "&wday="+changeWDayView(adCalendarVO.getWday())
    										+ "&amtGrpNum=" + amtGrpVO.getAmtGrpNum();
    }
    
    /**
     * 요일 "1,2,5" 형태를 "1100100"형태로 변경 jsp에서 뿌리기 전용
     * 파일명 : changeWDayView
     * 작성일 : 2015. 10. 14. 오후 4:19:52
     * 작성자 : 신우섭
     * @param strOrg
     * @return
     */
    private String changeWDayView(String strOrg){
    	
    	if(strOrg == null || "".equals(strOrg) ){
    		return "00000000";
    	}
    	String strRtn="";
    	
    	for(int i=1; i<=7; i++){
    		 int nIdx = strOrg.indexOf(""+i);
    		 if(nIdx >= 0){
    			 strRtn += "1";
    		 }else{
    			 strRtn += "0";
    		 }
    	}
    	
    	return strRtn; 
    }
    
    /**
     * 요일 "1,2,5" 형태를 리스트에 넣기
     * 파일명 : changeWDaySql
     * 작성일 : 2015. 10. 15. 오전 10:15:29
     * 작성자 : 신우섭
     * @param strOrg
     * @return
     */
    private List<String> changeWDaySql(String strOrg){
    	
    	List<String> wdayList = new ArrayList<String>();
    	   	
    	for(int i=1; i<=7; i++){
    		 int nIdx = strOrg.indexOf(""+i);
    		 if(nIdx >= 0){
    			 String strData = ""+i;
    			 wdayList.add(strData);
    		 }else{
    			
    		 }
    	}
    	
    	return wdayList; 
    }
    
}
