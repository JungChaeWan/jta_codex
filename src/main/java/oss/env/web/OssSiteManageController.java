package oss.env.web;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import common.EgovUserDetailsHelper;
import mas.ad.vo.ADCNTCALENDARVO;
import mas.ad.vo.AD_CNTINFSVO;
import mas.ad.vo.AD_CNTINFVO;
import mas.ad.vo.AD_PRDTINFVO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPVO;
import oss.env.service.OssSiteManageService;
import oss.env.vo.DFTINFVO;
import common.Constant;
import oss.user.vo.USERVO;

@Controller
public class OssSiteManageController {
	Logger log = LogManager.getLogger(OssSiteManageController.class);

	@Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name="ossSiteManageService")
	private OssSiteManageService ossSiteManageService;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name = "ossCouponService")
	private OssCouponService ossCouponService;

	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;


	@RequestMapping("/oss/siteManage.do")
	public String siteManage(ModelMap model,
							 @ModelAttribute("DFTINFVO") DFTINFVO dftinfvo) {
		DFTINFVO resultVO = ossSiteManageService.selectByTamnao(Constant.DFT_INF_TAMNAO);

		model.addAttribute("resultVO", resultVO);

		return "oss/env/siteManage";
	}


	@RequestMapping("/oss/logoManage.do")
	public String logoManage(){
		 return "oss/env/logoManage";
	 }

	 /**
	 * 로고 변경
	 * 파일명 : changeLogo
	 * 작성일 : 2016. 11. 30. 오전 11:55:18
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/oss/changeLogo.do")
	public String changeLogo(final MultipartHttpServletRequest multiRequest,
							 ModelMap model) throws Exception {
		Map<String, Object> imgValidateMap = ossFileUtilService.validateImgFile(multiRequest);

		if (!(Boolean) imgValidateMap.get("validateChk")) {
			log.error("이미지 파일 에러");
			model.addAttribute("fileError", imgValidateMap.get("message"));
			return "oss/env/logoManage";
		}
		ossSiteManageService.changeLogo(multiRequest);

		return "redirect:/oss/logoManage.do";
	}

	/**
	 * 모바일 로고 변경
	 * 파일명 : changeMLogo
	 * 작성일 : 2016. 11. 30. 오전 11:55:18
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/oss/changeMLogo.do")
	public String changeMLogo(final MultipartHttpServletRequest multiRequest,
							  ModelMap model) throws Exception {
		Map<String, Object> imgValidateMap = ossFileUtilService.validateImgFile(multiRequest);

		if (!(Boolean) imgValidateMap.get("validateChk")) {
			log.error("이미지 파일 에러");
			model.addAttribute("fileError", imgValidateMap.get("message"));
			return "oss/env/logoManage";
		}
		ossSiteManageService.changeMLogo(multiRequest);

		return "redirect:/oss/logoManage.do";
	}

	// 탐나오 쿠폰 설정
	@RequestMapping("/oss/saveDftInf.do")
	public String saveDftInf(@ModelAttribute("DFTINFVO") DFTINFVO dftinfvo) {
		if(dftinfvo.getInfId().isEmpty()) {
			ossSiteManageService.insertDftInfTamnao(dftinfvo);
		} else {
			ossSiteManageService.updateDftInf(dftinfvo);
		}
		return "redirect:/oss/siteManage.do";
	}

	// 탐나오 정렬 설정
	@RequestMapping("/oss/saveSort.do")
	public String saveSort(@ModelAttribute("DFTINFVO") DFTINFVO dftinfvo) {
		ossSiteManageService.updateSort(dftinfvo);

		return "redirect:/oss/siteManage.do";
	}

	// 탐나오 앱 버전 설정
	@RequestMapping("/oss/saveAppVer.do")
	public String saveAppVer(@ModelAttribute("DFTINFVO") DFTINFVO dftinfvo) {
		ossSiteManageService.updateAppVer(dftinfvo);

		return "redirect:/oss/siteManage.do";
	}

	//채널톡 상당 예외일 관리
	@RequestMapping("/oss/channelTalkManage.do")
	public String channelTalkManage(ModelMap model,
									@ModelAttribute("ADCALENDARVO") ADCNTCALENDARVO adCntCalendarVO) {
		//년월 설정
		Calendar calNow = Calendar.getInstance();
		if( adCntCalendarVO.getiYear() == 0 || adCntCalendarVO.getiMonth()==0 ){
			//초기에는 현재 달
			calNow.set(Calendar.DATE, 1);
		}else{
			//날짜가 지정되면 그달
			int nY = adCntCalendarVO.getiYear();
			int nM = adCntCalendarVO.getiMonth();

			//년넘어가는건 Calendar에서 알아서 처리해줌... 따라서 13월, -1월로 와도 아무 문제 없음.
			if(adCntCalendarVO.getsPrevNext() != null){
				if("prev".equals(adCntCalendarVO.getsPrevNext().toLowerCase())){
					nM--;
				}else if ("next".equals(adCntCalendarVO.getsPrevNext().toLowerCase())){
					nM++;
				}else if("prevyear".equals(adCntCalendarVO.getsPrevNext().toLowerCase())){
					nY--;
				}else if("Nextyear".equals(adCntCalendarVO.getsPrevNext().toLowerCase())){
					nY++;
				}
			}
			calNow.set(nY, nM-1, 1);
		}
		adCntCalendarVO.initValue(calNow);
		model.addAttribute("calendarVO", adCntCalendarVO );

		//달력의 각 날들 설정
		List<ADCNTCALENDARVO> calList = new ArrayList<ADCNTCALENDARVO>();
		for(int i=0; i<adCntCalendarVO.getiMonthLastDay(); i++){
			ADCNTCALENDARVO adCal = new ADCNTCALENDARVO();
			adCal.setiYear( adCntCalendarVO.getiYear() );
			adCal.setiMonth( adCntCalendarVO.getiMonth() );
			adCal.setiDay( i+1 );
			if((adCntCalendarVO.getiWeek() + i)%7==0){
				adCal.setiWeek( 7 );
			}else{
				adCal.setiWeek( (adCntCalendarVO.getiWeek() + i)%7 );
			}
			adCal.setsHolidayYN("N");

			String strYYYYMMDD = String.format("%d%02d%02d", adCal.getiYear(), adCal.getiMonth(), adCal.getiDay() );
			System.out.println(strYYYYMMDD);
			Integer outDay = ossSiteManageService.channelTalkOutDayCnt(strYYYYMMDD);
			if (outDay > 0 ){
				adCal.setOutDay(strYYYYMMDD);
			}
			calList.add(adCal);
		}
		model.addAttribute("calList", calList );
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		model.addAttribute("today", sdf.format(now) );
		return "oss/env/channelTalkManage";
	}

	//채널톡 상담예외일 설정
	@RequestMapping("/oss/channelTalkSetCal.do")
	public String cntSetCal(@ModelAttribute("ADCNTCALENDARVO") ADCNTCALENDARVO adCntCalendarVO){
		String strYYYYMMDD = String.format("%d%02d%02d", adCntCalendarVO.getiYear(), adCntCalendarVO.getiMonth(), Integer.parseInt(adCntCalendarVO.getOutDay()));

		//DB에 넣기
		Integer outDay = ossSiteManageService.channelTalkOutDayCnt(strYYYYMMDD);
		ossSiteManageService.channelTalkSetCal(strYYYYMMDD, outDay);

		return "redirect:/oss/channelTalkManage.do?iYear=" + adCntCalendarVO.getiYear()
			+ "&iMonth="+ adCntCalendarVO.getiMonth()
			+ "&startDt="+adCntCalendarVO.getStartDt()
			+ "&endDt="+adCntCalendarVO.getEndDt()
			//+ "&wday="+changeWDayView(adCntCalendarVO.getWday())
			+ "&ioDiv=" + Constant.FLAG_Y;
	}

	//채널톡 간편 입력기
	@RequestMapping("/oss/channelTalkSetSimple.do")
	public String channelTalkSetSimple(@ModelAttribute("ADCNTCALENDARVO") ADCNTCALENDARVO adCntCalendarVO){

		//값넣기
		AD_CNTINFVO adCntinfVO = new AD_CNTINFVO();

		adCntinfVO.setStartDt(adCntCalendarVO.getStartDt());
		adCntinfVO.setEndDt(adCntCalendarVO.getEndDt());
		adCntinfVO.setWdayList(changeWDaySql(adCntCalendarVO.getWday()));

		//상담불가 간편 입력
		ossSiteManageService.channelTalkSimpleInsert(adCntinfVO);

		return "redirect:/oss/channelTalkManage.do?iYear=" + adCntCalendarVO.getiYear()
			+ "&iMonth="+ adCntCalendarVO.getiMonth()
			+ "&startDt="+adCntCalendarVO.getStartDt()
			+ "&endDt="+adCntCalendarVO.getEndDt()
			//+ "&wday="+changeWDayView(adCntCalendarVO.getWday())
			+ "&ioDiv=" + Constant.FLAG_Y;
	}

	//요일을 숫자로 표현
	private List<String> changeWDaySql(String strOrg){

		List<String> wdayList = new ArrayList<String>();

		for(int i=1; i<=7; i++){
			int nIdx = strOrg.indexOf(""+i);
			if(nIdx >= 0){
				String strData = ""+i;
				wdayList.add(strData);
			}
		}
		return wdayList;
	}
}
