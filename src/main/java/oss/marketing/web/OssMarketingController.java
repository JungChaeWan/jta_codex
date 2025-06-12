package oss.marketing.web;


import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mas.prmt.service.MasPrmtService;
import mas.prmt.vo.MAINPRMTVO;
import mas.prmt.vo.PRMTCMTVO;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import mas.sp.vo.SP_PRDTINFVO;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.service.OssMailService;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.EMAILVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.marketing.serive.OssAdtmAmtService;
import oss.marketing.serive.OssBestprdtService;
import oss.marketing.serive.OssKwaService;
import oss.marketing.serive.OssMkingHistService;
import oss.marketing.serive.OssSmsEmailWordsService;
import oss.marketing.serive.OssUserCateService;
import oss.marketing.vo.ADTMAMTVO;
import oss.marketing.vo.BESTPRDTSVO;
import oss.marketing.vo.BESTPRDTVO;
import oss.marketing.vo.EVNTINFSVO;
import oss.marketing.vo.EVNTINFVO;
import oss.marketing.vo.KWAPRDTVO;
import oss.marketing.vo.KWASVO;
import oss.marketing.vo.KWAVO;
import oss.marketing.vo.MKINGHISTVO;
import oss.marketing.vo.SMSEMAILWORDSVO;
import oss.marketing.vo.SMSSENDVO;
import oss.marketing.vo.USERCATEVO;
import oss.prdt.vo.PRDTVO;
import oss.prmt.vo.PRMTFILEVO;
import oss.prmt.vo.PRMTSVO;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;
import web.product.service.WebPrmtService;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.cmmn.service.SmsService;
import egovframework.cmmn.vo.MMSVO;
import egovframework.cmmn.vo.SMSVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 사용자 관리
 * 파일명 : OssUserController.java
 * 작성일 : 2015. 9. 22. 오전 9:51:00
 * 작성자 : 최영철
 */
/**
 * <pre>
 * 파일명 : OssMarketingController.java
 * 작성일 : 2018. 2. 6. 오후 4:39:34
 * 작성자 : 정동수
 */
@Controller
public class OssMarketingController {

    @Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name="ossUserService")
	protected OssUserService ossUserService;

	@Resource(name="ossCorpService")
	protected OssCorpService ossCorpService;

	@Resource(name="smsService")
	protected SmsService smsService;

	@Resource(name = "masPrmtService")
	private MasPrmtService masPrmtService;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name = "ossMailService")
	protected OssMailService ossMailService;

	@Resource(name = "webPrmtService")
	protected WebPrmtService webPrmtService;

	@Resource(name = "ossAdtmAmtService")
	protected OssAdtmAmtService ossAdtmAmtService;

	@Resource(name = "ossKwaService")
	protected OssKwaService ossKwaService;

	@Resource(name = "ossMkingHistService")
	protected OssMkingHistService ossMkingHistService;

	@Resource(name="ossCmmService")
    private OssCmmService ossCmmService;

	@Resource(name = "ossBestprdtService")
	protected OssBestprdtService ossBestprdtService;

	@Resource(name = "ossUserCateService")
	protected OssUserCateService ossUserCateService;
	
	@Resource(name = "ossSmsEmailWordsService")
	protected OssSmsEmailWordsService ossSmsEmailWordsService;

    Logger log = (Logger) LogManager.getLogger(this.getClass());


    @RequestMapping("/oss/smsForm.do")
    public String smsForm(@ModelAttribute("smsSendVO") SMSSENDVO smsSendVO,
    		@ModelAttribute("USERCATEVO") USERCATEVO usercateVO,
    						ModelMap model){
    	log.info("/oss/smsForm.do 호출");


    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	model.addAttribute("today", sdf.format(now) );

    	model.addAttribute("fromTel",EgovProperties.getProperty("CS.PHONE"));

    	List<CDVO> tsCdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCdList", tsCdList);
    	
    	// 문자 문구 리스트
    	SMSEMAILWORDSVO smsEmailWordsVO = new SMSEMAILWORDSVO();		
		smsEmailWordsVO.setFirstIndex(0);
		smsEmailWordsVO.setLastIndex(50);
		smsEmailWordsVO.setWordsDiv("SMS");
		
		Map<String, Object> resultMap = ossSmsEmailWordsService.selectWordsList(smsEmailWordsVO);    	
    	model.addAttribute("wordsList", resultMap.get("resultList"));

    	return "/oss/maketing/smsForm";
    }




    @RequestMapping("/oss/smsSend.do")
    public String smsSend(@ModelAttribute("smsSendVO") SMSSENDVO smsSendVO,
    						@ModelAttribute("USERCATEVO") USERCATEVO usercateVO,
    						HttpServletRequest request,
    						ModelMap model){
    	log.info("/oss/smsSend.do 호출");

    	String sTradeStatusCd = request.getParameter("sTradeStatusCd");

    	log.info("/oss/smsSend.do 호출>>"
    			+ "[SendTels:"+smsSendVO.getSendTels() + "]\n"
    			+ "[SendType:"+smsSendVO.getSendType() + "]\n"
    			+ "[callbak:"+smsSendVO.getCallbak() + "]\n"
    			+ "[Subject:"+smsSendVO.getSubject() + "]\n"
    			+ "[resSend:"+smsSendVO.getResSend() + "]\n"
    			+ "[reqdate:"+smsSendVO.getReqdate() + "]\n"
    			+ "[msg:"+smsSendVO.getMsg() + "]\n"
    			+ "[sTradeStatusCd:" + sTradeStatusCd +"]\n"
    			);


    	//받는사람 파싱
    	String[] strTels = smsSendVO.getSendTels().split(",");
    	List<String> telList = new ArrayList<String>();

    	String[] strNames = smsSendVO.getSendNames().split(",");

    	for (String sTel : strTels) {
    		if(sTel == null || sTel.isEmpty()){

    		}else if("ALLUSER".equals(sTel)){
    			//모든 유저
    			USERVO userVO = new USERVO();
    			userVO.setMarketingRcvAgrYn("Y");
    			List<USERVO> userList = ossUserService.selectUserListSMSEmail(userVO);
    			for (USERVO user : userList) {
    				if(!(user.getTelNum() == null || user.getTelNum().isEmpty()) ){
    					telList.add(user.getTelNum());
    				}
				}

    		}else if("ALLCORP".equals(sTel)){
    			//모든 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}
    		}else if("CADOCORP".equals(sTel)){
    			//숙박 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CADO");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}

    		}else if("CRCOCORP".equals(sTel)){
    			//랜트카 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CRCO");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}

    		}else if("CAVOCORP".equals(sTel)){
    			//항공 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CAVO");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}

    		}else if("CGLOCORP".equals(sTel)){
    			//골프 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CGLO");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}

    		}else if("CSPCCORP".equals(sTel)){
    			//소셜-카시트 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPC");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}

    		}else if("CSPTCORP".equals(sTel)){
    			//소셜-여행사 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPT");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}

    		}else if("CSPUCORP".equals(sTel)){
    			//소셜-관광지 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPU");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}

    		}else if("CSPLCORP".equals(sTel)){
    			//소셜-레저 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPL");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}

    		}else if("CSPFCORP".equals(sTel)){
    			//소셜-맛집 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPF");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}

    		}else if("CSPBCORP".equals(sTel)){
    			//소셜-뷰티 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPB");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}

    		}else if("CSPECORP".equals(sTel)){
    			//소셜-체험 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPE");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!(corp.getAdmMobile() == null || corp.getAdmMobile().isEmpty()) ){
						telList.add(corp.getAdmMobile());
					}
				}

    		}else if("CSVSCORP".equals(sTel)){
    			// 제주특산품 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSVS");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						telList.add(corp.getAdmMobile());
					}
				}
    		}else if("CSVMCORP".equals(sTel)){
    			// 제주기념품 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSVM");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						telList.add(corp.getAdmMobile());
					}
				}
    		}else if("USERCATE".equals(sTel)){
    			//검색 사용자

    			usercateVO.setsMarketingRcvAgrYn("Y");
    			List<USERVO> userList = ossUserCateService.selectUserCate(usercateVO);
    			for (USERVO user : userList) {
    				if(!(user.getTelNum() == null || user.getTelNum().isEmpty()) ){
    					telList.add(user.getTelNum());
    				}
				}
    		}else{
    			//일반 추가 번호
    			telList.add(sTel);
    		}
    	}



    	for (String strTel : telList) {
    		log.info(">>>>sms Send : "+strTel);

			if("SMS".equals(smsSendVO.getSendType()) ){

	    		SMSVO smsVO = new SMSVO();
				smsVO.setTrMsg(smsSendVO.getMsg());
				smsVO.setTrPhone(strTel);
				smsVO.setTrCallback(smsSendVO.getCallbak());
				try {
					if("Y".equals(smsSendVO.getResSend())){
						//예약 발송
						smsVO.setTrSenddate(smsSendVO.getReqdate());
						smsService.sendSMSDate(smsVO);
					}else{
						smsService.sendSMS(smsVO);
					}


				} catch (Exception e) {
					log.info("SMS Error");
				}

	    	}else{

	    		MMSVO mmsVO = new MMSVO();
				mmsVO.setSubject(smsSendVO.getSubject());
				mmsVO.setMsg(smsSendVO.getMsg());
				mmsVO.setStatus("0");
				mmsVO.setFileCnt("0");
				mmsVO.setType("0");
				mmsVO.setPhone(strTel);
				mmsVO.setCallback(smsSendVO.getCallbak());
				try {
					if("Y".equals(smsSendVO.getResSend())){
						//예약 발송
						mmsVO.setReqdate(smsSendVO.getReqdate());
						smsService.sendMMSDate(mmsVO);
					}else{
						smsService.sendMMS(mmsVO);
					}
				} catch (Exception e) {
					log.info("MMS Error");
				}
	    	}
		}

    	model.addAttribute("sendName",strNames[0]);
    	model.addAttribute("sendCnt",telList.size());


    	return "/oss/maketing/smsResult";

    }

    @RequestMapping("/oss/eventList.do")
	public String event(@ModelAttribute("searchVO") PRMTVO prmtVO,
						ModelMap model) {
		log.info("/oss/eventList.do call");

		prmtVO.setPageUnit(propertiesService.getInt("pageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = masPrmtService.selectPrmtListOss(prmtVO);

		@SuppressWarnings("unchecked")
		List<SP_PRDTINFVO> resultList = (List<SP_PRDTINFVO>) resultMap.get("resultList");
		model.addAttribute("resultList", resultList);

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		List<CDVO> cdList = ossCmmService.selectCode(Constant.PRMT_DIV_CD);

		model.addAttribute("prmtCdList", cdList);
		model.addAttribute("paginationInfo", paginationInfo);

		return "oss/maketing/eventList";
	}
    
    @RequestMapping("/oss/eventListExcel.do")
	public void eventListExcel(@ModelAttribute("searchVO") PRMTVO prmtVO,
							   HttpServletRequest request,
							   HttpServletResponse response) throws ParseException {
		log.info("/oss/eventListExcel.do call");
		/* 엑셀 레코드 MAX COUNT 999999개 */
		prmtVO.setFirstIndex(0);
		prmtVO.setLastIndex(999999);
		
		SimpleDateFormat df_in = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat df_in2 = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat df_output = new SimpleDateFormat("yyyy-MM-dd");

		Map<String, Object> resultMap = masPrmtService.selectPrmtListOss(prmtVO);

		@SuppressWarnings("unchecked")
		List<PRMTVO> resultList = (List<PRMTVO>) resultMap.get("resultList");
		
		//Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
        Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("입점업체내역");

     // 컬럼 너비 설정
        sheet1.setColumnWidth( 0, 6000);		//프로모션번호
        sheet1.setColumnWidth( 1, 3000); 		//프로모션명
        sheet1.setColumnWidth( 2, 3000);		//형태
        sheet1.setColumnWidth( 3, 3000);		//시작일
        sheet1.setColumnWidth( 4, 3000);		//종료일
        sheet1.setColumnWidth( 5, 3000);		//댓글사용
        sheet1.setColumnWidth( 6, 3000);		//Dday출력
        sheet1.setColumnWidth( 7, 3000);		//거래상태
        sheet1.setColumnWidth( 8, 3000);		//등록일
        sheet1.setColumnWidth( 9, 5000);		//페이지링크

        CellStyle cellStyle = xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row;
        Cell cell;

        // 첫 번째 줄
        row = sheet1.createRow(0);

        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("번호");
        cell.setCellStyle(cellStyle);

		cell = row.createCell(1);
		cell.setCellValue("구분");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(2);
        cell.setCellValue("프로모션명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(3);
        cell.setCellValue("시작일");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(4);
        cell.setCellValue("종료일");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(5);
        cell.setCellValue("댓글사용");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(6);
        cell.setCellValue("Dday출력");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(7);
        cell.setCellValue("상태");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(8);
        cell.setCellValue("등록일");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(9);
        cell.setCellValue("페이지링크");
        cell.setCellStyle(cellStyle);

		for (int i = 0; i < resultList.size(); i++) {
			PRMTVO prmtvo = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(prmtvo.getPrmtNum());

			cell = row.createCell(1);
			cell.setCellValue(prmtvo.getPrmtDivNm());

			cell = row.createCell(2);
			cell.setCellValue(prmtvo.getPrmtNm());

			cell = row.createCell(3);

			if(StringUtils.isNotEmpty(prmtvo.getStartDt())) {
				Date inDate = df_in.parse(prmtvo.getStartDt());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}
			cell = row.createCell(4);

			if(StringUtils.isNotEmpty(prmtvo.getEndDt())) {
				Date inDate = df_in.parse(prmtvo.getEndDt());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}
			cell = row.createCell(5);
			cell.setCellValue(prmtvo.getCmtYn());
			
			cell = row.createCell(6);
			cell.setCellValue(prmtvo.getDdayViewYn());
			
			cell = row.createCell(7);

			if(Constant.TRADE_STATUS_REG.equals(prmtvo.getStatusCd())) {
				cell.setCellValue("등록중");
			} else if(Constant.TRADE_STATUS_APPR_REQ.equals(prmtvo.getStatusCd())) {
				cell.setCellValue("승인요청");
			} else if(Constant.TRADE_STATUS_APPR.equals(prmtvo.getStatusCd())) {
				cell.setCellValue("승인");
			} else if(Constant.TRADE_STATUS_APPR_REJECT.equals(prmtvo.getStatusCd())) {
				cell.setCellValue("승인거절");
			} else if(Constant.TRADE_STATUS_STOP.equals(prmtvo.getStatusCd())) {
				cell.setCellValue("판매중지");
			} else {
				cell.setCellValue("");
			}
			cell = row.createCell(8);

			if(StringUtils.isNotEmpty(prmtvo.getFrstRegDttm())){
				Date inDate = df_in2.parse(prmtvo.getFrstRegDttm());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}
			cell = row.createCell(9);
			String domain = EgovProperties.getProperty("Globals.Web");
			cell.setCellValue(domain + "/web/evnt/detailPromotion.do?prmtNum=" + prmtvo.getPrmtNum());
		}

        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "프로모션.xlsx";

    		String userAgent = request.getHeader("User-Agent");
    		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
    			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("MSIE") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("Trident") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("Android") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") );
    		} else if(userAgent.indexOf("Swing") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8")  + ";");
    		} else if(userAgent.indexOf("Mozilla/5.0") >= 0) {		// 크롬, 파폭
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
    		} else {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		ServletOutputStream fileOutput = response.getOutputStream();

            xlsxWb.write(fileOutput);
			fileOutput.flush();
            fileOutput.close();

        } catch (FileNotFoundException e) {
        	log.error(e);
        } catch (IOException e) {
        	log.error(e);
        }

	}

    @RequestMapping("/oss/eventRegView.do")
	public String eventRegView(@ModelAttribute("PRMTVO") PRMTVO prmtVO,
							   ModelMap model) {
		log.info("/oss/eventRegView.do call");

		// 프로모션 상품 라벨 코드
		List<CDVO> cdList = ossCmmService.selectCode(Constant.PRMT_LABEL_CD);

		model.addAttribute("plblCdList", cdList);

		// 프로모션 구분 코드
		cdList = ossCmmService.selectCode(Constant.PRMT_DIV_CD);

		model.addAttribute("prmtCdList", cdList);

		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

		return "oss/maketing/eventReg";
	}

	@RequestMapping("/oss/eventReg.do")
	public String eventReg(@ModelAttribute("prmtVO") PRMTVO prmtVO,
						   @ModelAttribute("prmtPrdtVO") PRMTPRDTVO prmtPrdtVO,
						   final MultipartHttpServletRequest multiRequest) throws Exception {
		log.info("/oss/eventReg.do call");

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		prmtVO.setFrstRegId(corpInfo.getUserId());
		prmtVO.setFrstRegIp(corpInfo.getLastLoginIp());

		String prmtNum = masPrmtService.insertPromotion(prmtVO, multiRequest, "oss");

		List<String> prdtNumList = prmtVO.getPrdtNum();

		if(prdtNumList != null && !prdtNumList.isEmpty()) {
			int i = 0;
			String[] label1 = prmtPrdtVO.getLabel1().split(",", prdtNumList.size());
			String[] label2 = prmtPrdtVO.getLabel2().split(",", prdtNumList.size());
			String[] label3 = prmtPrdtVO.getLabel3().split(",", prdtNumList.size());
			List<String> notes = prmtPrdtVO.getNotes();

			for(String prdtNumOne : prdtNumList) {
				PRMTPRDTVO prdtVO = new PRMTPRDTVO();
				prdtVO.setPrmtNum(prmtNum);
				prdtVO.setPrdtNum(prdtNumOne);
				prdtVO.setLabel1(label1[i]);
				prdtVO.setLabel2(label2[i]);
				prdtVO.setLabel3(label3[i]);
				prdtVO.setNote(notes.get(i));

				masPrmtService.insertPrmtPrdt(prdtVO);
				i++;
			}
		}
		return "redirect:/oss/eventList.do";
	}

	@RequestMapping("/oss/eventDtl.do")
	public String eventDtl(@ModelAttribute("prmtVO") PRMTVO prmtVO,
						   ModelMap model) {
		log.info("/oss/eventDtl.do call");
		
		if(prmtVO.getFinishYn() == null){
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null){
			prmtVO.setWinsYn(Constant.FLAG_N);
		}

		// 프로모션 정보
		PRMTVO resultVO = masPrmtService.selectByPrmt(prmtVO);

		model.addAttribute("prmtVO", resultVO);

		// 프로모션 상품
		List<PRMTPRDTVO> prmtPrdtVO = masPrmtService.selectPrmtPrdtListOss(prmtVO);

		model.addAttribute("prmtPrdtList", prmtPrdtVO);

		// 프로모션 상품 라벨
		List<CDVO> cdList = ossCmmService.selectCode(Constant.PRMT_LABEL_CD);

		Map<String, String> plblMap = new HashMap<String, String>();
		for(CDVO plbl : cdList) {
			plblMap.put(plbl.getCdNum(), plbl.getCdNm());
		}
		model.addAttribute("plblMap", plblMap);

		//첨부파일 정보 가저오기
		PRMTFILEVO prmtfileVO = new PRMTFILEVO();
		prmtfileVO.setPrmtNum(prmtVO.getPrmtNum());

		List<PRMTFILEVO> prmtFileList = masPrmtService.selectPrmtFileList(prmtfileVO);

		model.addAttribute("prmtFileList", prmtFileList);

		// 댓글 리스트
		PRMTCMTVO prmtCmtVO = new PRMTCMTVO();
		PaginationInfo paginationInfo = new PaginationInfo();
		prmtCmtVO.setPageUnit(10);
		prmtCmtVO.setPageSize(propertiesService.getInt("webEvntPageSize"));

		/** pageing setting */
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtCmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtCmtVO.getPageSize());

		prmtCmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtCmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtCmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		prmtCmtVO.setPrmtNum(prmtVO.getPrmtNum());

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount(webPrmtService.selectPrmtCmtTotalCnt(prmtCmtVO));

		List<PRMTCMTVO> rmtCmtList = webPrmtService.selectPrmtCmtList(prmtCmtVO);

		model.addAttribute("rmtCmtList", rmtCmtList);

		model.addAttribute("paginationInfo", paginationInfo);

		return "/oss/maketing/eventDtl";
	}

	@RequestMapping("/oss/eventDtlFileDown.do")
   	public void eventDtlFileDown(@ModelAttribute("PRMTFILEVO") PRMTFILEVO prmtFileVO
   						, HttpServletRequest request
   						, HttpServletResponse response
   						, ModelMap model	)throws Exception{
    	log.info("/oss/eventDtlFileDown.do 호출");

    	PRMTFILEVO prmtRes = masPrmtService.selectPrmtFile(prmtFileVO);

    	String strRoot = EgovProperties.getProperty("HOST.WEBROOT");
    	String strRealFileName = prmtRes.getRealFileNm();
		String strSaveFilePath = strRoot + prmtRes.getSavePath() + prmtRes.getSaveFileNm();
		File fileSaveFile = new File(strSaveFilePath);

		if(fileSaveFile.exists() == false){
			log.info("file not exist!!");
			//오류처리
			return;
		}

		if (!fileSaveFile.isFile()) {
			log.info("file not isFile!!");
		    //throw new FileNotFoundException(downFileName);
			//오류처리
			return;
		}

		String userAgent = request.getHeader("User-Agent");

		int fSize = (int)fileSaveFile.length();
		if (fSize > 0) {
			BufferedInputStream in = null;

		    try {
				in = new BufferedInputStream(new FileInputStream(fileSaveFile));

				//String mimetype = fileDownloads.getMimeType(strRealFileName); //"application/x-msdownload"

		    	response.setBufferSize(fSize);
				//response.setContentType(mimetype);

				// MS 익스플로어
				if(userAgent.indexOf("MSIE") >= 0){
					response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(strRealFileName, "UTF-8") + "\";");
				}
				else if(userAgent.indexOf("Trident") >= 0) {
					response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(strRealFileName, "UTF-8") + "\";");
				}
				// 크롬, 파폭
				else if(userAgent.indexOf("Mozilla/5.0") >= 0){
					response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(strRealFileName, "UTF-8") + ";charset=\"UTF-8\"");
				}else{
					response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(strRealFileName, "UTF-8") + "\";");
				}

				response.setContentLength(fSize);
	//			response.setHeader("Content-Transfer-Encoding","binary");
				//response.setHeader("Pragma","no-cache");
				//response.setHeader("Expires","0");
	//			FileCopyUtils.copy(in, response.getOutputStream());
				byte[] buff = new byte[2048];
				ServletOutputStream ouputStream = response.getOutputStream();
				FileInputStream inputStream = new FileInputStream(fileSaveFile);

			try{
				int size = -1;
				while((size = inputStream.read(buff)) > 0) {
					ouputStream.write(buff, 0, size);
					response.getOutputStream().flush();
				}
			}finally {
				try {
					in.close();
				}
				catch (IOException ex) {
				}
				try {
					ouputStream.close();
				}
				catch (IOException ex) {
				}
				inputStream.close();
			}

		    } finally {
				if (in != null) {
				    try {
				    	in.close();
				    } catch (Exception ignore) {
				    	log.info("IGNORED: " + ignore.getMessage());
				    }
				}
		    }
		    response.getOutputStream().close();

		}

    }




	@RequestMapping("/oss/eventCmtSaveExcel.do")
    public void eventCmtSaveExcel(@ModelAttribute("prmtVO") PRMTVO prmtVO
    							, HttpServletRequest request
    							, HttpServletResponse response){
    	log.info("/oss/eventCmtSaveExcel.do 호출");


    	// 프로모션 정보가져오기
    	PRMTVO resultVO = masPrmtService.selectByPrmt(prmtVO);

    	PRMTCMTVO prmtCmtVO = new PRMTCMTVO();
    	prmtCmtVO.setPrmtNum(prmtVO.getPrmtNum());
    	List<PRMTCMTVO> rmtCmtList = webPrmtService.selectPrmtCmtListNopage(prmtCmtVO);

		//Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
        Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("프로모션댓글목록");

        // 컬럼 너비 설정
        sheet1.setColumnWidth( 0, 3000);		//userid
        sheet1.setColumnWidth( 1, 3000);		//이름
        sheet1.setColumnWidth( 2, 4000);		//전화번호
        sheet1.setColumnWidth( 3, 8000); 		//email
        sheet1.setColumnWidth( 4, 15000);		//내용
        // ----------------------------------------------------------

        CellStyle cellStyle = xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;


        //// 첫 번째 줄
        //row = sheet1.createRow(0);
        //cell = row.createCell(0);
        //cell.setCellValue(resultVO.getPrmtNm()+" 프로모션 댓글");
        //cell.setCellStyle(cellStyle);


        // 첫 번째 줄
        row = sheet1.createRow(0);

        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("유저ID");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(1);
        cell.setCellValue("이름");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(2);
        cell.setCellValue("전화번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(3);
        cell.setCellValue("이메일");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(4);
        cell.setCellValue("내용");
        cell.setCellStyle(cellStyle);

        //---------------------------------
		for (int i = 0; i < rmtCmtList.size(); i++) {
			PRMTCMTVO data = rmtCmtList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(data.getUserId());

			cell = row.createCell(1);
			cell.setCellValue(data.getUserNm());

			cell = row.createCell(2);
			cell.setCellValue(data.getTelNum());

			cell = row.createCell(3);
			cell.setCellValue(data.getEmail());

			cell = row.createCell(4);
			CellStyle cs = xlsxWb.createCellStyle();
			cs.setWrapText(true);
			cell.setCellStyle(cs);
			cell.setCellValue(data.getContents());

			//cell = row.createCell(3);
			//cell.setCellValue(data.getPrintYn());

			//cell = row.createCell(4);
			//cell.setCellValue(data.getFrstRegDttm());

			//cell = row.createCell(5);
			//cell.setCellValue(data.getLastModDttm());


		}


        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "프로모션댓글목록.xlsx";

    		String userAgent = request.getHeader("User-Agent");
    		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
    			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		else if(userAgent.indexOf("MSIE") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		else if(userAgent.indexOf("Trident") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		else if(userAgent.indexOf("Android") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") );
    		}
    		else if(userAgent.indexOf("Swing") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8")  + ";");
    		}
    		// 크롬, 파폭
    		else if(userAgent.indexOf("Mozilla/5.0") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
    		}else{
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}

    		ServletOutputStream fileOutput = response.getOutputStream();

            xlsxWb.write(fileOutput);
			fileOutput.flush();
            fileOutput.close();

        } catch (FileNotFoundException e) {
        	log.info(e);
            e.printStackTrace();
        } catch (IOException e) {
        	log.info(e);
            e.printStackTrace();
        }
    }


	@RequestMapping("/oss/eventModView.do")
	public String eventModView(@ModelAttribute("PRMTVO") PRMTVO prmtVO,
							   ModelMap model) {
		log.info("/oss/eventModView.do call");
		// 프로모션 정보가져오기
		PRMTVO resultVO = masPrmtService.selectByPrmt(prmtVO);

		model.addAttribute("prmtVO", resultVO);

		//첨부파일 정보 가저오기
		PRMTFILEVO prmtfileVO = new PRMTFILEVO();
		prmtfileVO.setPrmtNum(prmtVO.getPrmtNum());

		List<PRMTFILEVO> prmtFileList = masPrmtService.selectPrmtFileList(prmtfileVO);

		model.addAttribute("prmtFileList", prmtFileList);

		// 프로모션 매핑 상품 정보 가져오기.
		List<PRMTPRDTVO> prmtPrdtVO = masPrmtService.selectPrmtPrdtListOss(prmtVO);

		model.addAttribute("prmtPrdtList", prmtPrdtVO);
		model.addAttribute("maxSortSn", prmtPrdtVO.size());

		// 프로모션 상품 라벨 코드
		List<CDVO> cdList = ossCmmService.selectCode(Constant.PRMT_LABEL_CD);

		model.addAttribute("plblCdList", cdList);

		// 프로모션 구분 코드
		cdList = ossCmmService.selectCode(Constant.PRMT_DIV_CD);

		model.addAttribute("prmtCdList", cdList);

		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

		return "/oss/maketing/eventMod";
	}

	@RequestMapping("/oss/eventMod.do")
	public String eventMod(@ModelAttribute("prmtVO") PRMTVO prmtVO,
						   @ModelAttribute("prmtPrdtVO") PRMTPRDTVO prmtPrdtVO,
						   final MultipartHttpServletRequest multiRequest) throws Exception {
		log.info("/oss/eventMod.do call");

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		prmtVO.setLastModId(corpInfo.getUserId());
		prmtVO.setLastModIp(corpInfo.getLastLoginIp());

		masPrmtService.updatePromotion(prmtVO, multiRequest, "oss");

		masPrmtService.deletePrmtPrdt(prmtVO.getPrmtNum());

		List<String> prdtNumList = prmtVO.getPrdtNum();

		if(prdtNumList != null && !prdtNumList.isEmpty()) {
			int i = 0;
			String[] label1 = prmtPrdtVO.getLabel1().split(",", prdtNumList.size());
			String[] label2 = prmtPrdtVO.getLabel2().split(",", prdtNumList.size());
			String[] label3 = prmtPrdtVO.getLabel3().split(",", prdtNumList.size());
			List<String> notes = prmtPrdtVO.getNotes();

			for(String prdtNumOne : prdtNumList) {
				PRMTPRDTVO prdtVO = new PRMTPRDTVO();
				prdtVO.setPrmtNum(prmtVO.getPrmtNum());
				prdtVO.setPrdtNum(prdtNumOne);
				prdtVO.setLabel1(label1[i]);
				prdtVO.setLabel2(label2[i]);
				prdtVO.setLabel3(label3[i]);
				prdtVO.setNote(notes.get(i));

				masPrmtService.insertPrmtPrdt(prdtVO);
				i++;
			}
		}
		return "redirect:/oss/eventList.do";
	}

	@RequestMapping("/oss/eventDelFile.do")
   	public String eventDelFile(@ModelAttribute("searchVO") PRMTVO prmtVO,
								  HttpServletRequest request) {
   		log.info("/oss/eventDelFile.do 호출");

   		String prmtFileNum = request.getParameter("prmtFileNum");

   		masPrmtService.deletePrmtFile(prmtFileNum);

   		//return "redirect:/oss/eventModView.do?prmtNum="+prmtVO.getPrmtNum()+"&noticeNum="+notiVO.getNoticeNum()+"&pageIndex="+notiSVO.getPageIndex()+"&sKeyOpt="+notiSVO.getsKeyOpt()+"&sKey="+notiSVO.getsKey();

   		return "redirect:/oss/eventModView.do?prmtNum="+prmtVO.getPrmtNum()+"&pageIndex="+prmtVO.getPageIndex();

    }

	@RequestMapping("/oss/eventModSort.ajax")
	public ModelAndView eventModSort(@ModelAttribute("prmtVO") PRMTPRDTVO prmtPrdtVO) {
		log.info("/mas/eventModSort.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		// 정렬 수정
		masPrmtService.updatePrmtPrdtSort(prmtPrdtVO);

		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	@RequestMapping("/oss/eventDel.ajax")
	public ModelAndView eventDel(@ModelAttribute("prmtVO") PRMTVO prmtVO) {
		log.info("/mas/eventDel.ajax call");
    	Map<String, Object> resultMap = new HashMap<String,Object>();

    	PRMTVO resultVO =masPrmtService.selectByPrmt(prmtVO);

    	if(resultVO == null) {
    		resultMap.put("resultCode", Constant.JSON_FAIL);
			ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
			return modelAndView;
    	}

    	MAINPRMTVO mainPrmtVO = new MAINPRMTVO();    	
    	
    	masPrmtService.deletePrmtPrdt(prmtVO.getPrmtNum());		// 프로모션 상품 삭제
    	masPrmtService.deletePrmtFileAll(prmtVO.getPrmtNum());	// 첨부파일 삭제
    	masPrmtService.deletePrmtCmtAll(prmtVO.getPrmtNum()); 	// 댓글 삭제
    	
    	// 메인 프로모션 삭제
    	mainPrmtVO.setPrmtNum(prmtVO.getPrmtNum());
    	mainPrmtVO = masPrmtService.selectMainPrmtInfo(mainPrmtVO);
    	if (mainPrmtVO != null) {
    		masPrmtService.deleteMainPrmt(mainPrmtVO);
    	}
    	
    	// 기념품 프로모션 삭제
    	mainPrmtVO = new MAINPRMTVO();  
    	mainPrmtVO.setPrmtNum(prmtVO.getPrmtNum());
    	mainPrmtVO = masPrmtService.selectSvPrmtInfo(mainPrmtVO);
    	if (mainPrmtVO != null) {
    		masPrmtService.deleteSvPrmt(mainPrmtVO);
    	}
    	
    	// 모바일 프로모션 삭제
    	mainPrmtVO = new MAINPRMTVO();  
    	mainPrmtVO.setPrmtNum(prmtVO.getPrmtNum());
    	mainPrmtVO = masPrmtService.selectMwPrmtInfo(mainPrmtVO);
    	if (mainPrmtVO != null) {
    		masPrmtService.deleteMwPrmt(mainPrmtVO);
    	}
    	
    	masPrmtService.deletePromotion(prmtVO);

    	resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}


	@RequestMapping("/oss/eventApproval.ajax")
	public ModelAndView eventApproval(@ModelAttribute("prmtVO") PRMTVO prmtVO, ModelMap model) {
		log.info("/oss/eventApproval.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		//prmtVO.setCorpId(corpInfo.getCorpId());
		prmtVO.setLastModId(corpInfo.getUserId());
		prmtVO.setLastModIp(corpInfo.getLastLoginIp());
		//prmtVO.setCorpCd(corpInfo.getCorpCd());

		masPrmtService.updatePrmtStatusCd(prmtVO);
		resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}



	@RequestMapping("/oss/eventSNList.do")
	public String eventSNList(@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
							  ModelMap model) {
		log.info("/oss/eventSNList.do call");

		List<MAINPRMTVO> resultList = masPrmtService.selectMainPrmt(mainPrmtVO);

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultList.size());

		return "/oss/maketing/eventSNList";
	}

	@RequestMapping("/oss/eventCmtUpdateCPrint.do")
    public String eventCmtUpdateCPrint(@ModelAttribute("PRMTCMTVO") PRMTCMTVO prmtCmtVO,
    							@ModelAttribute("PRMTSVO") PRMTSVO prmtSVO,
    							ModelMap model){
    	log.info("/oss/eventCmtUpdateCPrint.do 호출:" + prmtCmtVO.getCmtSn() + ":" + prmtCmtVO.getPrintYn()  + ":" + prmtCmtVO.getPrmtNum() );
    	webPrmtService.updatePrmtCmt(prmtCmtVO);

    	return "redirect:/oss/eventDtl.do?prmtNum=" + prmtCmtVO.getPrmtNum() +"&pageIndex="+prmtSVO.getPageIndex();
    }


	@RequestMapping("/oss/mainPrmtMod.do")
    public String mainPrmtMod(	@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
									ModelMap model) throws Exception{
    	log.info("/oss/mainPrmtMod.do 호출");
    	//USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		//ossCmmService.updateDtlImgSn(imgVO);
    	masPrmtService.updateDtlPrintSn(mainPrmtVO);

		return "redirect:/oss/eventSNList.do";
    }


	@RequestMapping("/oss/mainPrmtReg.do")
    public String mainPrmtReg(	@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
    							ModelMap model) throws Exception{

		//같은거 있는지 검사
		List<MAINPRMTVO> mainPrmtList = masPrmtService.selectMainPrmtFromPrmtNum(mainPrmtVO);
		if( !(mainPrmtList == null || mainPrmtList.size()==0) ){
			return "redirect:/oss/eventSNList.do?err=1";
		}

		masPrmtService.insertMainPrmt(mainPrmtVO);

		return "redirect:/oss/eventSNList.do";
		//return "redirect:/mas/" + corpInfo.getCorpCd().toLowerCase() + "/imgList.do?prdtNum=" + imgVO.getLinkNum();
    }


	@RequestMapping("/oss/findPrmt.do")
	public String findPrmt(@ModelAttribute("searchVO") PRMTVO prmtVO,
						   ModelMap model) {
		prmtVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	prmtVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = masPrmtService.selectPrmtListFind(prmtVO);

		@SuppressWarnings("unchecked")
		List<CORPVO> resultList = (List<CORPVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "/oss/maketing/findPrmtPop";
	}

	@RequestMapping("/oss/mainPrmtDel.do")
    public String mainPrmtDel(	@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
									ModelMap model) throws Exception{
    	//USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		masPrmtService.deleteMainPrmt(mainPrmtVO);

    	return "redirect:/oss/eventSNList.do";
    	//return "redirect:/mas/" + corpInfo.getCorpCd().toLowerCase() + "/dtlImgList.do?prdtNum=" + imgVO.getLinkNum();
    }


	@RequestMapping("/oss/emailForm.do")
    public String emailForm(@ModelAttribute("emailVO") EMAILVO emailVO,
    						@ModelAttribute("USERCATEVO") USERCATEVO usercateVO,
    						ModelMap model){
    	log.info("/oss/emailForm.do 호출");

    	/*
    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	model.addAttribute("today", sdf.format(now) );

    	model.addAttribute("fromTel",EgovProperties.getProperty("CS.PHONE"));
    	*/

    	model.addAttribute("fromEmail",EgovProperties.getProperty("MAIL.SENDER"));

    	List<CDVO> tsCdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCdList", tsCdList);
    	
    	// 문자 문구 리스트
    	SMSEMAILWORDSVO smsEmailWordsVO = new SMSEMAILWORDSVO();		
		smsEmailWordsVO.setFirstIndex(0);
		smsEmailWordsVO.setLastIndex(50);
		smsEmailWordsVO.setWordsDiv("EMAL");
				
		Map<String, Object> resultMap = ossSmsEmailWordsService.selectWordsList(smsEmailWordsVO);    	
    	model.addAttribute("wordsList", resultMap.get("resultList"));
    	
    	// 진행중인 이벤트 리스트
    	PRMTVO prmtVO = new PRMTVO();
		prmtVO.setFirstIndex(0);
		prmtVO.setLastIndex(20);
		prmtVO.setFinishYn(Constant.FLAG_N);
		prmtVO.setWinsYn(Constant.FLAG_N);
		prmtVO.setPrmtDiv(Constant.PRMT_DIV_EVNT);
		resultMap = webPrmtService.selectPromotionList(prmtVO);
		@SuppressWarnings("unchecked")
		List<PRMTVO> evntList = (List<PRMTVO>) resultMap.get("resultList");
		model.addAttribute("evntList", evntList);
		
    	// 진행중인 기획전 리스트
		prmtVO.setPrmtDiv(Constant.PRMT_DIV_PLAN);
		resultMap = webPrmtService.selectPromotionList(prmtVO);
		@SuppressWarnings("unchecked")
		List<PRMTVO> planList = (List<PRMTVO>) resultMap.get("resultList");
		model.addAttribute("planList", planList);

    	return "/oss/maketing/emailForm";
    }

    @RequestMapping("/oss/emailSend.do")
    public String emailSend(final MultipartHttpServletRequest multiRequest,
    						@ModelAttribute("emailVO") EMAILVO emailVO,
    						@ModelAttribute("USERCATEVO") USERCATEVO usercateVO,
    						HttpServletRequest request,
    						ModelMap model) throws Exception{
    	log.info("call /oss/emailSend.do");

    	String sTradeStatusCd = request.getParameter("sTradeStatusCd");

    	if (EgovStringUtil.isEmpty(emailVO.getPrmtDiv())) {
	    	//첨부파일 올리기
	    	//저장경로 /storage/email/[년-월]/
			String strDate = new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date());
			String strSaveFilePath = EgovProperties.getProperty("EMAIL.SAVEDFILE") + strDate + "/";
			String strSaveFileName = ossFileUtilService.uploadEmailFile(multiRequest, strSaveFilePath);
			log.info(">>>>uploadEmailFile:"+strSaveFileName);
	
			emailVO.setSaveFilePath(strSaveFilePath);
			emailVO.setSaveFileName(strSaveFileName);
    	}

    	//받는사람 파싱
    	String[] strEmails = emailVO.getSendEmails().split(",");
    	List<String> emailList = new ArrayList<String>();

    	String[] strNames = emailVO.getSendNames().split(",");
    	//List<String> nameList = new ArrayList<String>();

    	for (String sEmail : strEmails) {
    		if("ALLUSER".equals(sEmail)){
    			//모든 유저
    			USERVO userVO = new USERVO();
    			userVO.setMarketingRcvAgrYn("Y");
    			List<USERVO> userList = ossUserService.selectUserListSMSEmail(userVO);
    			for (USERVO user : userList) {
    				if(!EgovStringUtil.isEmpty(user.getEmail())){
    					emailList.add(user.getEmail());
    					//nameList.add(user.getUserNm());
    				}
				}

    		}else if("ALLCORP".equals(sEmail)){
    			//모든 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail())){
						emailList.add(corp.getAdmEmail());
					}
				}
    		}else if("CADOCORP".equals(sEmail)){
    			//숙박 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CADO");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}

    		}else if("CRCOCORP".equals(sEmail)){
    			//랜트카 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CRCO");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}

    		}else if("CAVOCORP".equals(sEmail)){
    			//항공 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CAVO");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}

    		}else if("CGLOCORP".equals(sEmail)){
    			//골프 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CGLO");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}

    		}else if("CSPCCORP".equals(sEmail)){
    			//소셜-카시트 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPC");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}

    		}else if("CSPTCORP".equals(sEmail)){
    			//소셜-여행사 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPT");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}

    		}else if("CSPUCORP".equals(sEmail)){
    			//소셜-관광지 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPU");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}

    		}else if("CSPLCORP".equals(sEmail)){
    			//소셜-레저 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPL");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}

    		}else if("CSPFCORP".equals(sEmail)){
    			//소셜-맛집 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPF");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}

    		}else if("CSPBCORP".equals(sEmail)){
    			//소셜-뷰티 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPB");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}

    		}else if("CSPECORP".equals(sEmail)){
    			//소셜-체험 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSPE");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}

    		}else if("CSVSCORP".equals(sEmail)){
    			// 제주특산품 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSVS");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}
    		}else if("CSVMCORP".equals(sEmail)){
    			// 제주기념품 업체
    			CORPVO corpVO = new CORPVO();
    			//corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
    			corpVO.setTradeStatusCd(sTradeStatusCd);
    			corpVO.setCorpModCd("CSVM");
    			List<CORPVO> corpList = ossCorpService.selectCorpListSMSMail(corpVO);
    			for (CORPVO corp : corpList) {
					if(!EgovStringUtil.isEmpty(corp.getAdmEmail()) ){
						emailList.add(corp.getAdmEmail());
					}
				}
    		}else if("USERCATE".equals(sEmail)){
    			//검색 사용자

				usercateVO.setsMarketingRcvAgrYn("Y");
    			List<USERVO> userList = ossUserCateService.selectUserCate(usercateVO);
    			for (USERVO user : userList) {
    				if(!(user.getTelNum() == null || user.getTelNum().isEmpty()) ){
    					emailList.add(user.getEmail());
    				}
    			}
    		}else{
    			//일반 추가 번호
    			emailList.add(sEmail);
    		}
    	}
    	emailVO.setEmailList(emailList);

    	if (EgovStringUtil.isEmpty(emailVO.getPrmtDiv())) {
	    	//메일보내기
	    	ossMailService.sendEamils(emailVO, request);
	    	
	    	model.addAttribute("sendName", strNames[0]);
	    	model.addAttribute("sendCnt", emailList.size());
	
	    	return "/oss/maketing/emailResult";
    	} else {
    		//메일보내기
	    	ossMailService.sendPrmtEamils(emailVO, request);
	    	
    		return "redirect:/oss/emailForm.do";
    	}

    }

    @RequestMapping("/oss/pushForm.do")
    public String pushForm(){
    	return "oss/maketing/pushForm";
    }

    @RequestMapping("/oss/adtmAmtForm.do")
    public String adtmAmtForm(@ModelAttribute("ADTMAMTVO") ADTMAMTVO adtmAmtVO, ModelMap model){
    	//년월 설정
   		Calendar calNow = Calendar.getInstance();
   		if( adtmAmtVO.getiYear() == 0 || adtmAmtVO.getiMonth()==0 ){
   			//초기에는 현재 달
   			calNow.set(Calendar.DATE, 1);
   		}else{
   			//날짜가 지정되면 그달

   			int nY = adtmAmtVO.getiYear();
   			int nM = adtmAmtVO.getiMonth();

   			//년넘어가는건 Calendar에서 알아서 처리해줌... 따라서 13월, -1월로 와도 아무 문제 없음.
   			if(adtmAmtVO.getsPrevNext() != null){
	   			if("prev".equals(adtmAmtVO.getsPrevNext().toLowerCase())){
	   				nM--;
	   			}else if ("next".equals(adtmAmtVO.getsPrevNext().toLowerCase())){
	   				nM++;
	   			}else if("prevyear".equals(adtmAmtVO.getsPrevNext().toLowerCase())){
	   				nY--;
	   			}else if("Nextyear".equals(adtmAmtVO.getsPrevNext().toLowerCase())){
	   				nY++;
	   			}
   			}
   			calNow.set(nY, nM-1, 1);
   		}
   		adtmAmtVO.initValue(calNow);

   		adtmAmtVO.setWday(changeWDayView(adtmAmtVO.getWday()));
    	model.addAttribute("calendarVO", adtmAmtVO );

    	//DB에서 읽어오기
    	String strYYYYMM = String.format("%d%02d", adtmAmtVO.getiYear(), adtmAmtVO.getiMonth() );
    	adtmAmtVO.setsAplDt(strYYYYMM);

    	// 매출액
    	Map<String, String> saleAmtMap = ossAdtmAmtService.selectSaleAmtList(adtmAmtVO);

    	List<ADTMAMTVO> resultList = ossAdtmAmtService.selectAdtmAmtList(adtmAmtVO);
		int nListSize = resultList.size();
		int nListPos = 0;

    	//달력의 각 날들 설정
    	List<ADTMAMTVO> calList = new ArrayList<ADTMAMTVO>();
    	for(int i=0; i<adtmAmtVO.getiMonthLastDay(); i++){
    		ADTMAMTVO adtmCal = new ADTMAMTVO();
    		adtmCal.setiYear( adtmAmtVO.getiYear() );
    		adtmCal.setiMonth( adtmAmtVO.getiMonth() );
    		adtmCal.setiDay( i+1 );
    		if((adtmAmtVO.getiWeek() + i)%7==0){
    			adtmCal.setiWeek( 7 );
    		}else{
    			adtmCal.setiWeek( (adtmAmtVO.getiWeek() + i)%7 );
    		}
    		adtmCal.setsHolidayYN("N");

    		//데이터 넣기
    		String strYYYYMMDD = String.format("%d%02d%02d", adtmCal.getiYear(), adtmCal.getiMonth(), adtmCal.getiDay() );
    		adtmCal.setSaleAmt(saleAmtMap.get(strYYYYMMDD));	// 매출액
    		if(nListPos < nListSize){
    			ADTMAMTVO adtmAmt = resultList.get(nListPos);
	    		//log.info(">>>:---------------"+strYYYYMMDD + ":" + adAmt.getAplDt());
	    		if(strYYYYMMDD.equals(adtmAmt.getAplDt()) ){
	    			//log.info(">>>:----------------C"+strYYYYMMDD + ":"+adAmt.getSaleAmt()+":"+adAmt.getNmlAmt() +":"+ adAmt.getHotdallYn());
	    			adtmCal.setAdtmAmt( adtmAmt.getAdtmAmt() );			// 광고비
	    			adtmCal.setAdtmAmtAdd1( adtmAmt.getAdtmAmtAdd1() );
	    			adtmCal.setAdtmAmtAdd2( adtmAmt.getAdtmAmtAdd2() );
	    			adtmCal.setAdtmAmtAdd3( adtmAmt.getAdtmAmtAdd3() );
	    			adtmCal.setAdtmAmtAdd4( adtmAmt.getAdtmAmtAdd4() );
	    			adtmCal.setAdtmAmtAdd5( adtmAmt.getAdtmAmtAdd5() );
	    			nListPos++;
	    		}
    		}
    		calList.add(adtmCal);
    	}
    	model.addAttribute("calList", calList );

    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	model.addAttribute("today", sdf.format(now) );

    	return "oss/maketing/adtmAmtForm";
    }

    @RequestMapping("/oss/adtmAmtSetCal.do")
    public String adtmAmtSetCal(@ModelAttribute("ADTMAMTVO") ADTMAMTVO adtmAmtVO, ModelMap model){
    	log.info("/oss/adtmAmtSetCal.do 호출");

   		//받은 값 파싱
   		String[] strAdtmAmts = adtmAmtVO.getAdtmAmt().split(",");
   		String[] strAdtmAmtAdd1s = adtmAmtVO.getAdtmAmtAdd1().split(",");
   		String[] strAdtmAmtAdd2s = adtmAmtVO.getAdtmAmtAdd2().split(",");
   		String[] strAdtmAmtAdd3s = adtmAmtVO.getAdtmAmtAdd3().split(",");
   		String[] strAdtmAmtAdd4s = adtmAmtVO.getAdtmAmtAdd4().split(",");
   		String[] strAdtmAmtAdd5s = adtmAmtVO.getAdtmAmtAdd5().split(",");
   		//for(int i=0; i<strAdtmAmts.length; i++){
   		//	log.info("/oss/adtmAmtSetCal.do 호출>>>>>>SaleAmt["+(i+1)+"]" + strAdtmAmts[i]);
   		//}

   		//DB에 넣을 데어터 조합
   		List<ADTMAMTVO> amtList = new ArrayList<ADTMAMTVO>();
   		for(int i=0; i<adtmAmtVO.getiMonthLastDay(); i++){
   			String strAdtmAmt = "";

   			String strAdtmAmtAdd1 = "";
   			String strAdtmAmtAdd2 = "";
   			String strAdtmAmtAdd3 = "";
   			String strAdtmAmtAdd4 = "";
   			String strAdtmAmtAdd5 = "";

   			//받은값 파싱된 데이터 넣기
   			if( strAdtmAmts.length > i ){
   				strAdtmAmt = strAdtmAmts[i];
   			}

   			if( strAdtmAmtAdd1s.length > i ){
   				strAdtmAmtAdd1 = strAdtmAmtAdd1s[i];
   			}
   			if( strAdtmAmtAdd2s.length > i ){
   				strAdtmAmtAdd2 = strAdtmAmtAdd2s[i];
   			}
   			if( strAdtmAmtAdd3s.length > i ){
   				strAdtmAmtAdd3 = strAdtmAmtAdd3s[i];
   			}
   			if( strAdtmAmtAdd4s.length > i ){
   				strAdtmAmtAdd4 = strAdtmAmtAdd4s[i];
   			}
   			if( strAdtmAmtAdd5s.length > i ){
   				strAdtmAmtAdd5 = strAdtmAmtAdd5s[i];
   			}





   			//하나라도 값이 있으면 리스트에 넣기
   			if(!("".equals(strAdtmAmt)
   				&& "".equals(strAdtmAmtAdd1)
   				&& "".equals(strAdtmAmtAdd2)
   				&& "".equals(strAdtmAmtAdd3)
   				&& "".equals(strAdtmAmtAdd4)
   				&& "".equals(strAdtmAmtAdd5))
   				){
   				ADTMAMTVO adAmt = new ADTMAMTVO();
	   			String strYYYYMMDD = String.format("%d%02d%02d", adtmAmtVO.getiYear(), adtmAmtVO.getiMonth(), i+1 );

	   			//log.info("/mas/ad/adtmAmtSetCal.do 호출>>>>>>["+strYYYYMMDD
	   			//		+"]["+strAdtmAmt
	   			//		+"]["+strAdtmAmtAdd1
	   			//		+"]["+strAdtmAmtAdd2
	   			//		+"]["+strAdtmAmtAdd3
	   			//		+"]["+strAdtmAmtAdd4
	   			//		+"]["+strAdtmAmtAdd5
	   			//		+"]");

	   			adAmt.setAplDt(strYYYYMMDD);
	   			adAmt.setAdtmAmt(strAdtmAmt);
	   			adAmt.setAdtmAmtAdd1(strAdtmAmtAdd1);
	   			adAmt.setAdtmAmtAdd2(strAdtmAmtAdd2);
	   			adAmt.setAdtmAmtAdd3(strAdtmAmtAdd3);
	   			adAmt.setAdtmAmtAdd4(strAdtmAmtAdd4);
	   			adAmt.setAdtmAmtAdd5(strAdtmAmtAdd5);

	   			amtList.add(adAmt);
   			}
   		}

   		//DB에 넣기
   		ossAdtmAmtService.mergeAdtmAmtList(amtList);


   		//return amtList(calendarVO, ad_PRDINFVO, model, request);
   		return "redirect:/oss/adtmAmtForm.do?iYear=" + adtmAmtVO.getiYear()
   											+ "&iMonth="+ adtmAmtVO.getiMonth()
   											+ "&startDt="+adtmAmtVO.getStartDt()
    										+ "&endDt="+adtmAmtVO.getEndDt()
    										+ "&wday="+changeWDayView(adtmAmtVO.getWday());
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
     * 기념품 프로모션
     * 파일명 : eventSvList
     * 작성일 : 2017. 2. 16. 오후 1:44:02
     * 작성자 : 최영철
     * @param mainPrmtVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/eventSvList.do")
	public String eventSvList(@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
							  ModelMap model) {
		log.info("/oss/eventSvList.do call");

		List<MAINPRMTVO> resultList = masPrmtService.selectSvPrmt(mainPrmtVO);

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultList.size());

		return "/oss/maketing/eventSvList";
	}

    /**
     * 기념품 프로모션 삭제
     * 파일명 : svPrmtDel
     * 작성일 : 2017. 2. 16. 오후 2:01:09
     * 작성자 : 최영철
     * @param mainPrmtVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/svPrmtDel.do")
    public String svPrmtDel(	@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
									ModelMap model) throws Exception{
		masPrmtService.deleteSvPrmt(mainPrmtVO);

    	return "redirect:/oss/eventSvList.do";
    }

    /**
     * 기념품 프로모션 순번 변경
     * 파일명 : svPrmtMod
     * 작성일 : 2017. 2. 16. 오후 2:16:35
     * 작성자 : 최영철
     * @param mainPrmtVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/svPrmtMod.do")
    public String svPrmtMod(	@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
									ModelMap model) throws Exception{
    	log.info("/oss/svPrmtMod.do 호출");
    	masPrmtService.updateDtlPrintSv(mainPrmtVO);

		return "redirect:/oss/eventSvList.do";
    }


	/**
	 * 기념품 프로모션 등록
	 * 파일명 : svPrmtReg
	 * 작성일 : 2017. 2. 16. 오후 2:09:33
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/oss/svPrmtReg.do")
    public String svPrmtReg(	@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
    							ModelMap model) throws Exception{

		//같은거 있는지 검사
		List<MAINPRMTVO> mainPrmtList = masPrmtService.selectSvPrmtFromPrmtNum(mainPrmtVO);
		if( !(mainPrmtList == null || mainPrmtList.size()==0) ){
			return "redirect:/oss/eventSvList.do?err=1";
		}

		masPrmtService.insertSvPrmt(mainPrmtVO);

		return "redirect:/oss/eventSvList.do";
    }

    /**
     * 모바일 프로모션
     * Function : eventMwList
     * 작성일 : 2017. 12. 21. 오후 1:41:08
     * 작성자 : 정동수
     * @param mainPrmtVO
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/oss/eventMwList.do")
	public String eventMwList(@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
								HttpServletRequest request,
								ModelMap model) {
		log.info("/oss/eventSvList.do call");

		List<MAINPRMTVO> resultList = masPrmtService.selectMwPrmt(mainPrmtVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultList.size());

		return "/oss/maketing/eventMwList";
	}
    
    /**
     * 모바일 프로모션 삭제
     * Function : mwPrmtDel
     * 작성일 : 2017. 12. 21. 오후 1:41:48
     * 작성자 : 정동수
     * @param mainPrmtVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/mwPrmtDel.do")
    public String mwPrmtDel(	@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
									ModelMap model) throws Exception{
		masPrmtService.deleteMwPrmt(mainPrmtVO);

    	return "redirect:/oss/eventMwList.do";
    }
  
    /**
     * 모바일 프로모션 순번 변경
     * Function : mwPrmtMod
     * 작성일 : 2017. 12. 21. 오후 1:42:40
     * 작성자 : 정동수
     * @param mainPrmtVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/mwPrmtMod.do")
    public String mwPrmtMod(	@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
									ModelMap model) throws Exception{
    	log.info("/oss/mwPrmtMod.do 호출");
    	masPrmtService.updateDtlPrintMw(mainPrmtVO);

		return "redirect:/oss/eventMwList.do";
    }


	/**
	 * 기념품 프로모션 등록
	 * 파일명 : svPrmtReg
	 * 작성일 : 2017. 12. 22. 오후 4:17:33
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/oss/mwPrmtReg.do")
    public String mwPrmtReg(	@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO,
    							ModelMap model) throws Exception{

		//같은거 있는지 검사
		List<MAINPRMTVO> mainPrmtList = masPrmtService.selectMwPrmtFromPrmtNum(mainPrmtVO);
		if( !(mainPrmtList == null || mainPrmtList.size()==0) ){
			return "redirect:/oss/eventMwList.do?err=1";
		}

		masPrmtService.insertMwPrmt(mainPrmtVO);

		return "redirect:/oss/eventMwList.do";
    }

	@RequestMapping("/oss/evntInfList.do")
	public String evntInfList(@ModelAttribute("searchVO") EVNTINFSVO evntInfSVO
			, ModelMap model){

		log.info("/oss/eventList.do call");

		evntInfSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		evntInfSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(evntInfSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(evntInfSVO.getPageUnit());
		paginationInfo.setPageSize(evntInfSVO.getPageSize());

		evntInfSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		evntInfSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		evntInfSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = masPrmtService.selectEvntInfListOss(evntInfSVO);

		@SuppressWarnings("unchecked")
		List<EVNTINFVO> resultList = (List<EVNTINFVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "oss/maketing/evntInfList";
	}

	@RequestMapping("/oss/insertEvntView.do")
	public String inseretEvntView(@ModelAttribute("searchVO") EVNTINFSVO evntInfSVO
			, @ModelAttribute("evntInfVO") EVNTINFVO evntInfVO
			, ModelMap model){
		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		return "oss/maketing/insertEvntInf";
	}

	@RequestMapping("/oss/insertEvntInf.do")
	public String insertEvntInf(@ModelAttribute("searchVO") EVNTINFSVO evntInfSVO
			, @ModelAttribute("evntInfVO") EVNTINFVO evntInfVO
			, ModelMap model){
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();

		evntInfVO.setRegId(corpInfo.getUserId());
		masPrmtService.insertEvntInf(evntInfVO);

		return "redirect:/oss/evntInfList.do";
	}

	@RequestMapping("/oss/updateEvntInfView.do")
	public String updateEvntInfView(@ModelAttribute("searchVO") EVNTINFSVO evntInfSVO
			, @ModelAttribute("evntInfVO") EVNTINFVO evntInfVO
			, ModelMap model){
		evntInfVO = masPrmtService.selectByEvntInf(evntInfVO);

		model.addAttribute("evntInfVO", evntInfVO);

		return "oss/maketing/updateEvntInf";
	}

	@RequestMapping("/oss/updateEvntInf.do")
	public String updateEvntInf(@ModelAttribute("searchVO") EVNTINFSVO evntInfSVO
			, @ModelAttribute("evntInfVO") EVNTINFVO evntInfVO
			, ModelMap model){
		masPrmtService.updateEvntInf(evntInfVO);

		model.addAttribute("evntInfVO", evntInfVO);

		return "oss/maketing/updateEvntInf";
	}

	@RequestMapping("/oss/deleteEvntInf.do")
	public String deleteEvntInf(@ModelAttribute("searchVO") EVNTINFSVO evntInfSVO
			, @ModelAttribute("evntInfVO") EVNTINFVO evntInfVO
			, ModelMap model){
		masPrmtService.deleteEvntInf(evntInfVO);

		return "redirect:/oss/evntInfList.do";
	}


	@RequestMapping("/oss/kwaList.do")
	public String kwaList(@ModelAttribute("searchVO") KWASVO kwaSVO
			, ModelMap model){

		log.info("/oss/kwaList.do call");

		//검색 기본값 설정
		if(kwaSVO.getSlocation() == null || kwaSVO.getSlocation().isEmpty() || "".equals(kwaSVO.getSlocation()) ){
			//bestprdtSVO.setsCorpCd(Constant.ACCOMMODATION);
			kwaSVO.setSlocation("KW01");
		}


		kwaSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		kwaSVO.setPageSize(propertiesService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(kwaSVO.getPageIndex());
		//paginationInfo.setRecordCountPerPage(kwaSVO.getPageUnit());
		paginationInfo.setRecordCountPerPage(50);
		paginationInfo.setPageSize(kwaSVO.getPageSize());

		kwaSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		kwaSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		//kwaSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		kwaSVO.setRecordCountPerPage(50);

		Map<String, Object> resultMap = ossKwaService.selectKwaList(kwaSVO);

		@SuppressWarnings("unchecked")
		List<KWAVO> resultList = (List<KWAVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		//코드읽기
		List<CDVO> bnCdList = ossCmmService.selectCode("KW");
		model.addAttribute("bnCdList", bnCdList);

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);


		Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String nowDate = sdf.format(d);

        model.addAttribute("nowDate", nowDate);

		return "oss/maketing/kwaList";
	}
	
	@RequestMapping("/oss/kwaListExcel.do")
	public void kwaListExcel(@ModelAttribute("searchVO") KWASVO kwaSVO,HttpServletRequest request, HttpServletResponse response
			, ModelMap model) throws ParseException{
		/* 엑셀 레코드 MAX COUNT 999999개 */
		kwaSVO.setFirstIndex(0);
		kwaSVO.setLastIndex(999999);
		
		SimpleDateFormat df_in = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat df_in2 = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat df_output = new SimpleDateFormat("yyyy-MM-dd");

		Map<String, Object> resultMap = ossKwaService.selectKwaList(kwaSVO);

		@SuppressWarnings("unchecked")
		List<KWAVO> resultList = (List<KWAVO>) resultMap.get("resultList");
		
		//Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
        Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("해시태그");

     // 컬럼 너비 설정
        sheet1.setColumnWidth( 0, 6000);		//해시태그명
        sheet1.setColumnWidth( 1, 5000); 		//시작일
        sheet1.setColumnWidth( 2, 5000);		//종료일
        sheet1.setColumnWidth( 3, 5000);		//등록일
        sheet1.setColumnWidth( 3, 10000);		//링크페이지

        CellStyle cellStyle = xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;

        // 첫 번째 줄
        row = sheet1.createRow(0);

        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("해시태그명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(1);
        cell.setCellValue("시작일");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(2);
        cell.setCellValue("종료일");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(3);
        cell.setCellValue("등록일");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(4);
        cell.setCellValue("링크페이지");
        cell.setCellStyle(cellStyle);

        
		for (int i = 0; i < resultList.size(); i++) {
			KWAVO kwaVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(kwaVO.getKwaNm());

			if(kwaVO.getStartDttm() != null && !"".equals(kwaVO.getStartDttm())){
				cell = row.createCell(1);
				Date inDate = df_in.parse(kwaVO.getStartDttm());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}
			
			if(kwaVO.getEndDttm() != null && !"".equals(kwaVO.getEndDttm())){
				cell = row.createCell(2);
				Date inDate = df_in.parse(kwaVO.getEndDttm());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}
			
			if(kwaVO.getRegDttm() != null && !"".equals(kwaVO.getRegDttm())){
				cell = row.createCell(3);
				Date inDate = df_in2.parse(kwaVO.getRegDttm());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}
			
			cell = row.createCell(4);
			if(kwaVO.getPcUrl() != null && !"".equals(kwaVO.getPcUrl())){
				cell.setCellValue(kwaVO.getPcUrl());
			}else{
				cell.setCellValue("http://www.tamnao.com/web/kwaSearch.do?kwaNum="+kwaVO.getKwaNum());
			}
			

		}

        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "해시태그.xlsx";

    		String userAgent = request.getHeader("User-Agent");
    		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
    			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		else if(userAgent.indexOf("MSIE") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		else if(userAgent.indexOf("Trident") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		else if(userAgent.indexOf("Android") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") );
    		}
    		else if(userAgent.indexOf("Swing") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8")  + ";");
    		}
    		// 크롬, 파폭
    		else if(userAgent.indexOf("Mozilla/5.0") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
    		}else{
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}

    		ServletOutputStream fileOutput = response.getOutputStream();

            xlsxWb.write(fileOutput);
			fileOutput.flush();
            fileOutput.close();

        } catch (FileNotFoundException e) {
        	log.info(e);
            e.printStackTrace();
        } catch (IOException e) {
        	log.info(e);
            e.printStackTrace();
        }

	}

	@RequestMapping("/oss/findKwa.do")
	public String findKwa(@ModelAttribute("searchVO") KWASVO kwaSVO,
									HttpServletRequest request,
									ModelMap model){
		kwaSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		kwaSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(kwaSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(kwaSVO.getPageUnit());
		paginationInfo.setPageSize(kwaSVO.getPageSize());

		kwaSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		kwaSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		kwaSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//코드읽기
		List<CDVO> bnCdList = ossCmmService.selectCode("KW");
		model.addAttribute("bnCdList", bnCdList);

		Map<String, Object> resultMap = ossKwaService.selectKwaListFind(kwaSVO);

		@SuppressWarnings("unchecked")
		List<CORPVO> resultList = (List<CORPVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "/oss/maketing/findKwaPop";
	}

	@RequestMapping("/oss/kwaInsView.do")
	 public String kwaInsView(@ModelAttribute("KWAVO") KWAVO kwaVO,
							ModelMap model){
   	log.info("/oss/kwaInsView.do 호출");


       return "oss/maketing/kwaIns";

	 }

	 @RequestMapping("/oss/kwaIns.do")
	 public String kwaIns(final MultipartHttpServletRequest multiRequest,
						@ModelAttribute("KWAVO") KWAVO kwaVO,
						HttpServletRequest request,
						ModelMap model) throws Exception{
		log.info("/oss/kwaIns.do 호출");

		////로그인 정보 얻기
		//USERVO loginInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		//bannerVO.setRegId(loginInfo.getUserId());

		String kwaNum = ossKwaService.insertKwa(kwaVO);


		List<String> prdtNumListAD = kwaVO.getPrdtNumAD();
		if (prdtNumListAD != null) {
			for (String data : prdtNumListAD) {
				//log.info("AD===" + data);

				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("AD");
				kwaPrdt.setCtgr("");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		List<String> prdtNumListRC = kwaVO.getPrdtNumRC();
		if (prdtNumListRC != null) {
			for (String data : prdtNumListRC) {
				//log.info("AD===" + data);

				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("RC");
				kwaPrdt.setCtgr("");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		List<String> prdtNumListSPC100 = kwaVO.getPrdtNumSPC100();
		if (prdtNumListSPC100 != null) {
			for (String data : prdtNumListSPC100) {
				//log.info("AD===" + data);

				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("SP");
				kwaPrdt.setCtgr("C100");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		List<String> prdtNumListSPC200 = kwaVO.getPrdtNumSPC200();
		if (prdtNumListSPC200 != null) {
			for (String data : prdtNumListSPC200) {
				//log.info("AD===" + data);

				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("SP");
				kwaPrdt.setCtgr("C200");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		List<String> prdtNumListSPC300 = kwaVO.getPrdtNumSPC300();
		if (prdtNumListSPC300 != null) {
			for (String data : prdtNumListSPC300) {
				//log.info("AD===" + data);

				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("SP");
				kwaPrdt.setCtgr("C300");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		 List<String> prdtNumListSPC500 = kwaVO.getPrdtNumSPC500();
		 if (prdtNumListSPC500 != null) {
			 for (String data : prdtNumListSPC500) {
				 //log.info("AD===" + data);

				 KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				 kwaPrdt.setKwaNum(kwaNum);
				 kwaPrdt.setPrdtNum(data);
				 kwaPrdt.setCorpCd("SP");
				 kwaPrdt.setCtgr("C500");
				 ossKwaService.insertKawPrdt(kwaPrdt);
			 }
		 }

		List<String> prdtNumListSV = kwaVO.getPrdtNumSV();
		if (prdtNumListSV != null) {
			for (String data : prdtNumListSV) {
				//log.info("AD===" + data);

				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("SV");
				kwaPrdt.setCtgr("");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}


		return "redirect:/oss/kwaList.do?slocation="+kwaVO.getLocation();

	 }

	@RequestMapping("/oss/kwaUdtView.do")
	public String kwaUdtView(@ModelAttribute("KWAVO") KWAVO kwaVO
							, @ModelAttribute("searchVO") KWASVO kwaSVO
							, ModelMap model) {
		log.info("/oss/kwaUdtView.do 호출");

		// log.info("----"+bannerVO.getBannerPos() + " :: " +
		// bannerVO.getBannerNum());


		//키워드 정보
		KWAVO kwaVORes = ossKwaService.selectKwa(kwaVO);
		model.addAttribute("KWAVO", kwaVORes);


		//키워드 관련 상품 정보
		KWAPRDTVO kwaprdtVO = new KWAPRDTVO();
		kwaprdtVO.setKwaNum(kwaVORes.getKwaNum());

		kwaprdtVO.setCorpCd("AD");
		List<KWAPRDTVO> kwaprdtListAD = ossKwaService.selectKawPrdtList(kwaprdtVO);
		model.addAttribute("kwaprdtListAD", kwaprdtListAD);

		kwaprdtVO.setCorpCd("RC");
		List<KWAPRDTVO> kwaprdtListRC = ossKwaService.selectKawPrdtList(kwaprdtVO);
		model.addAttribute("kwaprdtListRC", kwaprdtListRC);

		kwaprdtVO.setCorpCd("SP");
		kwaprdtVO.setCtgr("C100");
		List<KWAPRDTVO> kwaprdtListSPC100 = ossKwaService.selectKawPrdtList(kwaprdtVO);
		model.addAttribute("kwaprdtListSPC100", kwaprdtListSPC100);

		kwaprdtVO.setCorpCd("SP");
		kwaprdtVO.setCtgr("C200");
		List<KWAPRDTVO> kwaprdtListSPC200 = ossKwaService.selectKawPrdtList(kwaprdtVO);
		model.addAttribute("kwaprdtListSPC200", kwaprdtListSPC200);

		kwaprdtVO.setCorpCd("SP");
		kwaprdtVO.setCtgr("C300");
		List<KWAPRDTVO> kwaprdtListSPC300 = ossKwaService.selectKawPrdtList(kwaprdtVO);
		model.addAttribute("kwaprdtListSPC300", kwaprdtListSPC300);

		kwaprdtVO.setCorpCd("SP");
		kwaprdtVO.setCtgr("C500");
		List<KWAPRDTVO> kwaprdtListSPC500 = ossKwaService.selectKawPrdtList(kwaprdtVO);
		model.addAttribute("kwaprdtListSPC500", kwaprdtListSPC500);

		kwaprdtVO.setCorpCd("SV");
		kwaprdtVO.setCtgr("");
		List<KWAPRDTVO> kwaprdtListSV = ossKwaService.selectKawPrdtList(kwaprdtVO);
		model.addAttribute("kwaprdtListSV", kwaprdtListSV);

		return "oss/maketing/kwaUdt";

	}

	@RequestMapping("/oss/kwaUdt.do")
	public String kwaUdt(@ModelAttribute("KWAVO") KWAVO kwaVO
				, @ModelAttribute("searchVO") KWASVO kwaSVO
				,HttpServletRequest request, ModelMap model) throws Exception {
		log.info("/oss/kwaUdt.do 호출");

		//KWAVO kwaVOOrg = ossKwaService.selectKaw(kwaVO);

		// 수정
		ossKwaService.updateKwa(kwaVO);

		//관련 상품 전부삭제
		ossKwaService.deleteKawPrdtAll(kwaVO.getKwaNum());

		String kwaNum = kwaVO.getKwaNum();
		//상품 다시 넣기
		List<String> prdtNumListAD = kwaVO.getPrdtNumAD();
		if (prdtNumListAD != null) {
			for (String data : prdtNumListAD) {
				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("AD");
				kwaPrdt.setCtgr("");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		List<String> prdtNumListRC = kwaVO.getPrdtNumRC();
		if (prdtNumListRC != null) {
			for (String data : prdtNumListRC) {
				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("RC");
				kwaPrdt.setCtgr("");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		List<String> prdtNumListSPC100 = kwaVO.getPrdtNumSPC100();
		if (prdtNumListSPC100 != null) {
			for (String data : prdtNumListSPC100) {
				//log.info("AD===" + data);

				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("SP");
				kwaPrdt.setCtgr("C100");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		List<String> prdtNumListSPC200 = kwaVO.getPrdtNumSPC200();
		if (prdtNumListSPC200 != null) {
			for (String data : prdtNumListSPC200) {
				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("SP");
				kwaPrdt.setCtgr("C200");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		List<String> prdtNumListSPC300 = kwaVO.getPrdtNumSPC300();
		if (prdtNumListSPC300 != null) {
			for (String data : prdtNumListSPC300) {
				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("SP");
				kwaPrdt.setCtgr("C300");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		List<String> prdtNumListSPC500 = kwaVO.getPrdtNumSPC500();
		if (prdtNumListSPC500 != null) {
			for (String data : prdtNumListSPC500) {
				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("SP");
				kwaPrdt.setCtgr("C500");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		List<String> prdtNumListSV = kwaVO.getPrdtNumSV();
		if (prdtNumListSV != null) {
			for (String data : prdtNumListSV) {
				KWAPRDTVO kwaPrdt = new KWAPRDTVO();
				kwaPrdt.setKwaNum(kwaNum);
				kwaPrdt.setPrdtNum(data);
				kwaPrdt.setCorpCd("SV");
				kwaPrdt.setCtgr("");
				ossKwaService.insertKawPrdt(kwaPrdt);
			}
		}

		return "redirect:/oss/kwaList.do?pageIndex=" + kwaSVO.getPageIndex()+"&slocation="+kwaVO.getLocation();
	}

	@RequestMapping("/oss/kwaUdtSort.ajax")
	public ModelAndView kwaUdtSort(@ModelAttribute("prmtVO") KWAPRDTVO kwaprdtVO) {
		log.info("/mas/kwaUdtSort.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		// 정렬 수정
		ossKwaService.updateKawPrdtSort(kwaprdtVO);

		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}


	@RequestMapping("/oss/kwaDel.do")
	public String kwaDel(@ModelAttribute("KWAVO") KWAVO kwaVO,
						HttpServletRequest request, ModelMap model) throws Exception {
		log.info("/oss/kwaDel.do 호출");

		// 삭제
		ossKwaService.deleteKwa(kwaVO);

		return "redirect:/oss/kwaList.do";

	}


	@RequestMapping("/oss/bestprdtList.do")
	public String bestprdtList(@ModelAttribute("searchVO") BESTPRDTSVO bestprdtSVO
			,  @ModelAttribute("BESTPRDTVO") BESTPRDTVO bestprdtVO
			, ModelMap model){

		log.info("/oss/bestprdtList.do call");


		//코드읽기
		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_CD);
		model.addAttribute("corpCdList", corpCdList);

		//소셜 카테고리 읽기
		List<CDVO> cateCdList = ossCmmService.selectCode(Constant.CATEGORY_CD);
		model.addAttribute("cateCdList", cateCdList);

		//검색 기본값 설정
		if(bestprdtSVO.getsCorpCd() == null || bestprdtSVO.getsCorpCd().isEmpty() || "".equals(bestprdtSVO.getsCorpCd()) ){
			//bestprdtSVO.setsCorpCd(Constant.ACCOMMODATION);
			bestprdtSVO.setsCorpCd(Constant.SOCIAL);
		}
		if(Constant.SOCIAL.equals(bestprdtSVO.getsCorpCd())){
			//소셜일때만 초기값 설정
			if(bestprdtSVO.getsCorpSubCd() == null || bestprdtSVO.getsCorpSubCd().isEmpty() || "".equals(bestprdtSVO.getsCorpSubCd()) ){
				bestprdtSVO.setsCorpSubCd("C200");
			}
		}


		bestprdtSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		bestprdtSVO.setPageSize(propertiesService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bestprdtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bestprdtSVO.getPageUnit());
		paginationInfo.setPageSize(bestprdtSVO.getPageSize());

		bestprdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bestprdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bestprdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossBestprdtService.selectBestprdtList(bestprdtSVO);

		@SuppressWarnings("unchecked")
		List<BESTPRDTVO> resultList = (List<BESTPRDTVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);


		return "oss/maketing/bestprdtList";
	}


	@RequestMapping("/oss/bestprdtInsView.do")
	public String bestprdInsView(@ModelAttribute("searchVO") BESTPRDTSVO bestprdtSVO
								, @ModelAttribute("BESTPRDTVO") BESTPRDTVO bestprdtVO
								, ModelMap model) {
		log.info("/oss/bestprdtInsView.do 호출");

		CDVO cdVO = new CDVO();
		cdVO.setCdNum(bestprdtSVO.getsCorpCd());
		CDVO cdRes = ossCmmService.selectByCd(cdVO);
		model.addAttribute("cdCorp", cdRes);

		if (Constant.SOCIAL.equals(bestprdtSVO.getsCorpCd())) {
			cdVO.setCdNum(bestprdtSVO.getsCorpSubCd());
			cdRes = ossCmmService.selectByCd(cdVO);
			model.addAttribute("cdCorpSub", cdRes);
		}

		return "oss/maketing/bestprdtIns";

	}

	@RequestMapping("/oss/bestprdIns.do")
	public String bestprdIns(@ModelAttribute("searchVO") BESTPRDTSVO bestprdtSVO
							, @ModelAttribute("BESTPRDTVO") BESTPRDTVO bestprdtVO, HttpServletRequest request
							, ModelMap model) throws Exception {
		log.info("/oss/bestprdIns.do 호출");

		ossBestprdtService.insertBestprdt(bestprdtVO);

		return "redirect:/oss/bestprdtList.do?sCorpCd=" + bestprdtSVO.getsCorpCd() + "&sCorpSubCd=" + bestprdtSVO.getsCorpSubCd();

	}

	@RequestMapping("/oss/bestprdtUdtView.do")
	public String bestprdtUdtView(@ModelAttribute("BESTPRDTVO") BESTPRDTVO bestprdtVO
								, @ModelAttribute("searchVO") BESTPRDTSVO bestprdtSVO
								, ModelMap model) {
		log.info("/oss/bestprdtUdtView.do 호출");

		// log.info("----"+bannerVO.getBannerPos() + " :: " +
		// bannerVO.getBannerNum());

		CDVO cdVO = new CDVO();
		cdVO.setCdNum(bestprdtSVO.getsCorpCd());
		CDVO cdRes = ossCmmService.selectByCd(cdVO);
		model.addAttribute("cdCorp", cdRes);

		if (Constant.SOCIAL.equals(bestprdtSVO.getsCorpCd())) {
			cdVO.setCdNum(bestprdtSVO.getsCorpSubCd());
			cdRes = ossCmmService.selectByCd(cdVO);
			model.addAttribute("cdCorpSub", cdRes);
		}

		int nMaxPos = ossBestprdtService.getMaxCntBestprdtPos(bestprdtVO);
		model.addAttribute("maxPos", nMaxPos);

		BESTPRDTVO bestprdtVORes = ossBestprdtService.selectBestprdt(bestprdtVO);
		model.addAttribute("BESTPRDTVO", bestprdtVORes);

		return "oss/maketing/bestprdtUdt";

	}

	@RequestMapping("/oss/bestprdtUdt.do")
	public String bannerUdt(@ModelAttribute("BESTPRDTVO") BESTPRDTVO bestprdtVO
							, @ModelAttribute("searchVO") BESTPRDTSVO bestprdtSVO
							, HttpServletRequest request
							, ModelMap model) throws Exception {
		log.info("/oss/bestprdtUdt.do 호출");

		BESTPRDTVO bpS = new BESTPRDTVO();
		bpS.setBestprdtNum(bestprdtVO.getBestprdtNum());
		BESTPRDTVO bpOrg = ossBestprdtService.selectBestprdt(bpS);
		bpOrg.setOldSn(bpOrg.getPrintSn());
		bpOrg.setNewSn(bestprdtVO.getPrintSn());

		// 순번 관련 작업
		if (!bpOrg.getNewSn().equals(bpOrg.getOldSn())) {
			if (Integer.parseInt(bpOrg.getPrintSn()) > Integer.parseInt(bestprdtVO.getPrintSn())) {
				// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
				ossBestprdtService.addViewSn(bpOrg);
			} else {
				ossBestprdtService.minusViewSn(bpOrg);
			}
		}

		// 수정
		ossBestprdtService.updateBestprdt(bestprdtVO);

		return "redirect:/oss/bestprdtList.do?pageIndex=" + bestprdtSVO.getPageIndex()+"&sCorpCd=" + bestprdtSVO.getsCorpCd() + "&sCorpSubCd=" + bestprdtSVO.getsCorpSubCd();
	}

	@RequestMapping("/oss/bestprdtDel.do")
	public String bestprdtDel( @ModelAttribute("BESTPRDTVO") BESTPRDTVO bestprdtVO
							, @ModelAttribute("searchVO") BESTPRDTSVO bestprdtSVO
							, HttpServletRequest request, ModelMap model) throws Exception {
		log.info("/oss/bestprdtDel.do 호출");

		BESTPRDTVO bpS = new BESTPRDTVO();
		bpS.setBestprdtNum(bestprdtVO.getBestprdtNum());
		BESTPRDTVO bpOrg = ossBestprdtService.selectBestprdt(bpS);

		// 순번관련
		bpOrg.setOldSn(bpOrg.getPrintSn());
		ossBestprdtService.minusViewSn(bpOrg);

		// 삭제
		ossBestprdtService.deleteBestprdt(bestprdtVO);

		return "redirect:/oss/bestprdtList.do?sCorpCd=" + bestprdtSVO.getsCorpCd() + "&sCorpSubCd=" + bestprdtSVO.getsCorpSubCd();

	}



	@RequestMapping("/oss/mkingHistList.do")
	public String mkingHistList(@ModelAttribute("searchVO") MKINGHISTVO mkinghistVO
			, ModelMap model) throws ParseException{

		log.info("/oss/mkingHistList.do call");


		Calendar calNow = Calendar.getInstance();
		String maxYear = ""+calNow.get(Calendar.YEAR);
		model.addAttribute("maxYear", maxYear);

		//기본 검색 조건
		if(mkinghistVO.getsYYYYMM() == null || mkinghistVO.getsYYYYMM().isEmpty() || "".equals(mkinghistVO.getsYYYYMM()) ){
			mkinghistVO.setsYYYYMM( String.format("%d%02d"
									, calNow.get(Calendar.YEAR)
									, calNow.get(Calendar.MONTH)+1) );
		}


		mkinghistVO.setsYYYY( mkinghistVO.getsYYYYMM().substring(0, 4) );
		mkinghistVO.setsMM( mkinghistVO.getsYYYYMM().substring(4, 6) );

		//log.info("========" + mkinghistVO.getsYYYY() + " : " + mkinghistVO.getsMM());
		model.addAttribute("MKINGHISTVO", mkinghistVO);


		//mkinghistVO.setPageUnit(propertiesService.getInt("pageUnit"));
		//mkinghistVO.setPageSize(propertiesService.getInt("pageSize"));
		//PaginationInfo paginationInfo = new PaginationInfo();
		//paginationInfo.setCurrentPageNo(mkinghistVO.getPageIndex());
		//paginationInfo.setRecordCountPerPage(mkinghistVO.getPageUnit());
		//paginationInfo.setPageSize(mkinghistVO.getPageSize());
		//mkinghistVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		//mkinghistVO.setLastIndex(paginationInfo.getLastRecordIndex());
		//mkinghistVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossMkingHistService.selectMkingHistList(mkinghistVO);

		@SuppressWarnings("unchecked")
		List<MKINGHISTVO> resultList = (List<MKINGHISTVO>) resultMap.get("resultList");

		int adtmPay = 0;
		int sealesBf = 0;
		int seales = 0;
		int sealesCnt = 0;


		for (MKINGHISTVO data : resultList) {
			MKINGHISTVO mkVo = new MKINGHISTVO();

			if(data.getPrdtNum() == null || data.getPrdtNum().isEmpty() || "".equals(data.getPrdtNum()) ){
				mkVo.setCorpId(data.getCorpId());
			}else{
				mkVo.setPrdtNum(data.getPrdtNum());
			}
			mkVo.setStdStartDttm(data.getStdStartDttm());
			mkVo.setStdEndDttm(data.getStdEndDttm());

			adtmPay += Integer.parseInt( data.getAdtmPay() );

			//매출액, 카운트 가저오기
			MKINGHISTVO mkRes = ossMkingHistService.getMkingHistSale(mkVo);
			if(mkRes != null){
				data.setSeales(mkRes.getSeales());
				data.setSealesCnt(mkRes.getSealesCnt());

				seales += Integer.parseInt( mkRes.getSeales() );
				sealesCnt += Integer.parseInt( mkRes.getSealesCnt() );
			}

			//날짜 차이 구하기 - //기준일얻어서 이전 매출 날짜 얻기
			int oneDay = 24 * 60 * 60 * 1000;
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		    Date beginDate = formatter.parse(data.getStdStartDttm());
		    Date endDate = formatter.parse(data.getStdEndDttm());
		    long diff = endDate.getTime() - beginDate.getTime();
		    int diffDays = (int)(diff / oneDay)+1;
		    //log.info("=======diffDays:" + diffDays);

		    Calendar calMkingDt = Calendar.getInstance();
		    int nYYYY = Integer.parseInt( data.getMkingDt().substring(0,4) );
		    int nMM = Integer.parseInt( data.getMkingDt().substring(4,6) );
		    int nDD = Integer.parseInt( data.getMkingDt().substring(6,8) );
		    calMkingDt.set(nYYYY, nMM-1, nDD);
		    //log.info("----------calMkingDt:" + formatter.format(calMkingDt.getTime()));

		    Calendar calStart = Calendar.getInstance();
		    Calendar calEnd = Calendar.getInstance();

		    calStart.set(nYYYY, nMM-1, nDD);
		    calStart.add(Calendar.DAY_OF_YEAR, -1);
		    //log.info("----------calStart:" + formatter.format(calStart.getTime()));

		    calEnd.set(nYYYY, nMM-1, nDD);
		    calEnd.add(Calendar.DAY_OF_YEAR, -1*diffDays);
		    //log.info("----------calEnd:" + formatter.format(calEnd.getTime()));


		    mkVo.setStdStartDttm(formatter.format(calEnd.getTime()));
			mkVo.setStdEndDttm(formatter.format(calStart.getTime()));
			//이전 매출액, 카운트 가저오기
			MKINGHISTVO mkRes2 = ossMkingHistService.getMkingHistSale(mkVo);
			if(mkRes != null){
				data.setSealesBf(mkRes2.getSeales());

				sealesBf += Integer.parseInt( mkRes2.getSeales() );
			}
		}

		MKINGHISTVO mkSum = new MKINGHISTVO();
		mkSum.setAdtmPay(""+adtmPay);
		mkSum.setSealesBf(""+sealesBf);
		mkSum.setSeales(""+seales);
		mkSum.setSealesCnt(""+sealesCnt);
		model.addAttribute("mkSum", mkSum);


		// 총 건수 셋팅
		//paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		//코드읽기
		//List<CDVO> bnCdList = ossCmmService.selectCode("KW");
		//model.addAttribute("bnCdList", bnCdList);

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		//model.addAttribute("paginationInfo", paginationInfo);


		return "oss/maketing/mkingHistList";
	}

	@RequestMapping("/oss/mkingHistInsView.do")
	public String mkingHistInsView( @ModelAttribute("MKINGHISTVO") MKINGHISTVO mkinghistVO
								, ModelMap model) {
		log.info("/oss/mkingHistInsView.do 호출");


		return "oss/maketing/mkingHistIns";

	}

	@RequestMapping("/oss/mkingHistIns.do")
	public String mkingHistIns(@ModelAttribute("MKINGHISTVO") MKINGHISTVO mkinghistVO
							, ModelMap model) throws Exception {
		log.info("/oss/mkingHistIns.do 호출");

		ossMkingHistService.insertMkingHist(mkinghistVO);

		mkinghistVO.setsYYYYMM( mkinghistVO.getMkingDt().substring(0,6) );

		return "redirect:/oss/mkingHistList.do?sYYYYMM=" + mkinghistVO.getsYYYYMM();

	}

	@RequestMapping("/oss/mkingHistUdtView.do")
	public String mkingHisttUdtView(@ModelAttribute("MKINGHISTVO") MKINGHISTVO mkinghistVO
								, ModelMap model) {
		log.info("/oss/mkingHistUdtView.do 호출");


		MKINGHISTVO mkinghistVORes = ossMkingHistService.selectMkingHist(mkinghistVO);
		model.addAttribute("MKINGHISTVO", mkinghistVORes);

		return "oss/maketing/mkingHistUdt";

	}

	@RequestMapping("/oss/mkingHistUdt.do")
	public String mkingHistUdt(@ModelAttribute("MKINGHISTVO") MKINGHISTVO mkinghistVO
							, HttpServletRequest request
							, ModelMap model) throws Exception {
		log.info("/oss/mkingHistUdt.do 호출");


		ossMkingHistService.updateMkingHist(mkinghistVO);
		mkinghistVO.setsYYYYMM( mkinghistVO.getMkingDt().substring(0,6) );

		return "redirect:/oss/mkingHistList.do?sYYYYMM=" + mkinghistVO.getsYYYYMM();
	}

	@RequestMapping("/oss/mkingHistDel.do")
	public String mkingHistDel( @ModelAttribute("MKINGHISTVO") MKINGHISTVO mkinghistVO
							, HttpServletRequest request
							, ModelMap model) throws Exception {
		log.info("/oss/mkingHistDel.do 호출");


		// 삭제
		ossMkingHistService.deleteMkingHist(mkinghistVO);

		return "redirect:/oss/mkingHistList.do?sYYYYMM=" + mkinghistVO.getsYYYYMM();

	}



	@RequestMapping("/oss/mkingHistExcel.do")
    public void mkingHistExcel(@ModelAttribute("MKINGHISTVO") MKINGHISTVO mkinghistVO
    										, HttpServletRequest request
    										, HttpServletResponse response) throws ParseException{
    	log.info("/oss/mkingHistExcel.ajax 호출");

    	Calendar calNow = Calendar.getInstance();
		String maxYear = ""+calNow.get(Calendar.YEAR);

		//기본 검색 조건
		if(mkinghistVO.getsYYYYMM() == null || mkinghistVO.getsYYYYMM().isEmpty() || "".equals(mkinghistVO.getsYYYYMM()) ){
			mkinghistVO.setsYYYYMM( String.format("%d%02d"
									, calNow.get(Calendar.YEAR)
									, calNow.get(Calendar.MONTH)+1) );
		}


		mkinghistVO.setsYYYY( mkinghistVO.getsYYYYMM().substring(0, 4) );
		mkinghistVO.setsMM( mkinghistVO.getsYYYYMM().substring(4, 6) );

		Map<String, Object> resultMap = ossMkingHistService.selectMkingHistList(mkinghistVO);

		@SuppressWarnings("unchecked")
		List<MKINGHISTVO> resultList = (List<MKINGHISTVO>) resultMap.get("resultList");

		int adtmPay = 0;
		int sealesBf = 0;
		int seales = 0;
		int sealesCnt = 0;


		for (MKINGHISTVO data : resultList) {
			MKINGHISTVO mkVo = new MKINGHISTVO();

			if(data.getPrdtNum() == null || data.getPrdtNum().isEmpty() || "".equals(data.getPrdtNum()) ){
				mkVo.setCorpId(data.getCorpId());
			}else{
				mkVo.setPrdtNum(data.getPrdtNum());
			}
			mkVo.setStdStartDttm(data.getStdStartDttm());
			mkVo.setStdEndDttm(data.getStdEndDttm());

			adtmPay += Integer.parseInt( data.getAdtmPay() );

			//매출액, 카운트 가저오기
			MKINGHISTVO mkRes = ossMkingHistService.getMkingHistSale(mkVo);
			if(mkRes != null){
				data.setSeales(mkRes.getSeales());
				data.setSealesCnt(mkRes.getSealesCnt());

				seales += Integer.parseInt( mkRes.getSeales() );
				sealesCnt += Integer.parseInt( mkRes.getSealesCnt() );
			}

			//날짜 차이 구하기 - //기준일얻어서 이전 매출 날짜 얻기
			int oneDay = 24 * 60 * 60 * 1000;
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		    Date beginDate = formatter.parse(data.getStdStartDttm());
		    Date endDate = formatter.parse(data.getStdEndDttm());
		    long diff = endDate.getTime() - beginDate.getTime();
		    int diffDays = (int)(diff / oneDay)+1;
		    //log.info("=======diffDays:" + diffDays);

		    Calendar calMkingDt = Calendar.getInstance();
		    int nYYYY = Integer.parseInt( data.getMkingDt().substring(0,4) );
		    int nMM = Integer.parseInt( data.getMkingDt().substring(4,6) );
		    int nDD = Integer.parseInt( data.getMkingDt().substring(6,8) );
		    calMkingDt.set(nYYYY, nMM-1, nDD);
		    //log.info("----------calMkingDt:" + formatter.format(calMkingDt.getTime()));

		    Calendar calStart = Calendar.getInstance();
		    Calendar calEnd = Calendar.getInstance();

		    calStart.set(nYYYY, nMM-1, nDD);
		    calStart.add(Calendar.DAY_OF_YEAR, -1);
		    //log.info("----------calStart:" + formatter.format(calStart.getTime()));

		    calEnd.set(nYYYY, nMM-1, nDD);
		    calEnd.add(Calendar.DAY_OF_YEAR, -1*diffDays);
		    //log.info("----------calEnd:" + formatter.format(calEnd.getTime()));


		    mkVo.setStdStartDttm(formatter.format(calEnd.getTime()));
			mkVo.setStdEndDttm(formatter.format(calStart.getTime()));
			//이전 매출액, 카운트 가저오기
			MKINGHISTVO mkRes2 = ossMkingHistService.getMkingHistSale(mkVo);
			if(mkRes != null){
				data.setSealesBf(mkRes2.getSeales());

				sealesBf += Integer.parseInt( mkRes2.getSeales() );
			}
		}

		MKINGHISTVO mkSum = new MKINGHISTVO();
		mkSum.setAdtmPay(""+adtmPay);
		mkSum.setSealesBf(""+sealesBf);
		mkSum.setSeales(""+seales);
		mkSum.setSealesCnt(""+sealesCnt);



		//model.addAttribute("mkSum", mkSum);



		//Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
        Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("마케팅 이력");

        // 컬럼 너비 설정
        sheet1.setColumnWidth( 0, 8000);		//업체명
        sheet1.setColumnWidth( 1, 8000); 		//상품명
        sheet1.setColumnWidth( 2, 3000);		//홍보일자
        sheet1.setColumnWidth( 3, 3000);		//진행매체
        sheet1.setColumnWidth( 4, 3000);		//홍보비
        sheet1.setColumnWidth( 5, 3000);		//판매기준 시작
        sheet1.setColumnWidth( 6, 3000);		//판매기준 끝
        sheet1.setColumnWidth( 7, 3000);		//이전매출액
        sheet1.setColumnWidth( 8, 3000);		//판매금액
        sheet1.setColumnWidth( 9, 3000);		//찬판매횟수
        sheet1.setColumnWidth(10, 3000);		//수익률
        sheet1.setColumnWidth(11, 10000);		//비고
        // ----------------------------------------------------------

        CellStyle cellStyle = xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;

        // 첫 번째 줄
        row = sheet1.createRow(0);

        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("업체명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(1);
        cell.setCellValue("상품명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(2);
        cell.setCellValue("홍보일자");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(3);
        cell.setCellValue("진행매체");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(4);
        cell.setCellValue("홍보비");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(5);
        cell.setCellValue("판매기준 시작");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(6);
        cell.setCellValue("판매기준 끝");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(7);
        cell.setCellValue("이전매출액");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(8);
        cell.setCellValue("판매금액");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(9);
        cell.setCellValue("찬판매횟수");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(10);
        cell.setCellValue("수익률");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(11);
        cell.setCellValue("비고");
        cell.setCellStyle(cellStyle);


        //---------------------------------
        int nRow = 0;
		for (int i = 0; i < resultList.size(); i++) {
			MKINGHISTVO data = resultList.get(i);
			row = sheet1.createRow(i + 1);
			nRow = i + 2;

			cell = row.createCell(0);
			cell.setCellValue(data.getCorpNm());

			cell = row.createCell(1);
			cell.setCellValue(data.getPrdtNm());

			cell = row.createCell(2);
			cell.setCellValue(EgovStringUtil.getDateFormatDash( data.getMkingDt() ) );

			cell = row.createCell(3);
			String strMedia = "";
			if("1".equals(data.getMedia())){
				strMedia = "키워드";
			}else if("2".equals(data.getMedia())){
				strMedia = "DA";
			}else if("3".equals(data.getMedia())){
				strMedia = "(탐)블로그";
			}else if("4".equals(data.getMedia())){
				strMedia = "(탐)페이스북";
			}else if("5".equals(data.getMedia())){
				strMedia = "(탐)인스타";
			}else if("6".equals(data.getMedia())){
				strMedia = "(외)블로그";
			}else if("7".equals(data.getMedia())){
				strMedia = "(외)SNS";
			}else if("8".equals(data.getMedia())){
				strMedia = "기획전";
			}else if("9".equals(data.getMedia())){
				strMedia = "이벤트";
			}else if("10".equals(data.getMedia())){
				strMedia = "기타";
			}
			cell.setCellValue(strMedia);

			cell = row.createCell(4);
			cell.setCellValue(data.getAdtmPay() );

			cell = row.createCell(5);
			cell.setCellValue(EgovStringUtil.getDateFormatDash( data.getStdStartDttm() ) );

			cell = row.createCell(6);
			cell.setCellValue(EgovStringUtil.getDateFormatDash( data.getStdEndDttm() ) );

			cell = row.createCell(7);
			cell.setCellValue(data.getSealesBf() );

			cell = row.createCell(8);
			cell.setCellValue(data.getSeales() );

			cell = row.createCell(9);
			cell.setCellValue(data.getSealesCnt() );

			cell = row.createCell(10);
			if( !("0".equals(data.getAdtmPay())) ){
				cell.setCellFormula("I"+nRow + "/" + "E"+nRow + "*100" );
			}

			cell = row.createCell(11);
			cell.setCellValue(data.getMemo() );
		}


		nRow = resultList.size()+2;
		row = sheet1.createRow(resultList.size()+1);
		cell = row.createCell(0);
		cell.setCellValue("합계");

		cell = row.createCell(4);
		cell.setCellValue(adtmPay );

		cell = row.createCell(7);
		cell.setCellValue( sealesBf );

		cell = row.createCell(8);
		cell.setCellValue( seales );

		cell = row.createCell(9);
		cell.setCellValue(sealesCnt );

		cell = row.createCell(10);
		if( adtmPay != 0 ){
			cell.setCellFormula("I"+nRow + "/" + "E"+nRow + "*100" );
		}

        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "마케팅이력.xlsx";

    		String userAgent = request.getHeader("User-Agent");
    		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
    			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		else if(userAgent.indexOf("MSIE") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		else if(userAgent.indexOf("Trident") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		else if(userAgent.indexOf("Android") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") );
    		}
    		else if(userAgent.indexOf("Swing") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8")  + ";");
    		}
    		// 크롬, 파폭
    		else if(userAgent.indexOf("Mozilla/5.0") >= 0){
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
    		}else{
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}

    		ServletOutputStream fileOutput = response.getOutputStream();

            xlsxWb.write(fileOutput);
			fileOutput.flush();
            fileOutput.close();

        } catch (FileNotFoundException e) {
        	log.info(e);
            e.printStackTrace();
        } catch (IOException e) {
        	log.info(e);
            e.printStackTrace();
        }

    }


	@RequestMapping("/oss/userCate.do")
    public String userCate(@ModelAttribute("USERCATEVO") USERCATEVO usercateVO,
    						ModelMap model){
    	log.info("/oss/userCate.do 호출");

    	//검색 전
    	if(usercateVO.getsFindYn() == null || usercateVO.getsFindYn().isEmpty() || "".equals(usercateVO.getsFindYn())){
    		usercateVO.setsFindYn("N");
    		usercateVO.setsCate("AD,RC,SPC200,SPC300,SPC500,SPC130,SPC170,SPC160,SV");
    	}

    	Calendar calNow = Calendar.getInstance();
		String sProcStdS = String.format("%d%02d%02d"
    							, calNow.get(Calendar.YEAR)-2
    							, calNow.get(Calendar.MONTH)+1
    							, calNow.get(Calendar.DATE) );

		String sProcStdE = String.format("%d%02d%02d"
								, calNow.get(Calendar.YEAR)
								, calNow.get(Calendar.MONTH)+1
								, calNow.get(Calendar.DATE) );

		//분석 기준 없을때
    	if(usercateVO.getsProcStdS() == null || usercateVO.getsProcStdS().isEmpty() || "".equals(usercateVO.getsProcStdS())){
    		usercateVO.setsProcStdS(sProcStdS);
    	}
    	if(usercateVO.getsProcStdE() == null || usercateVO.getsProcStdE().isEmpty() || "".equals(usercateVO.getsProcStdE())){
    		usercateVO.setsProcStdE(sProcStdE);
    	}

    	//log.info("=========="+usercateVO.getsCate());

    	/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(usercateVO.getPageIndex());
		//paginationInfo.setRecordCountPerPage(usercateVO.getPageUnit());
		paginationInfo.setRecordCountPerPage(20);
		paginationInfo.setPageSize(usercateVO.getPageSize());

		usercateVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		usercateVO.setLastIndex(paginationInfo.getLastRecordIndex());
		usercateVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<USERVO> resultList = new ArrayList<USERVO>();
		Integer totalCnt = 0;


    	if("Y".equals(usercateVO.getsFindYn() ) ){

    		usercateVO.setPageUnit(propertiesService.getInt("webPageUnit"));
    		usercateVO.setPageSize(propertiesService.getInt("webPageSize"));


    		//검색
    		resultList = ossUserCateService.selectUserCate(usercateVO);

    		//for (USERVO data : resultList) {
    			//log.info("1====="+ data.getUserId());
			//}


    		totalCnt = resultList.size();

    		if (totalCnt > 0) {
				int firstIndex = usercateVO.getFirstIndex();
				int endIndex = usercateVO.getLastIndex() > totalCnt ? totalCnt : usercateVO.getLastIndex();
				resultList = resultList.subList(firstIndex, endIndex);
			}

    		//for (USERVO data : resultList) {
    			//log.info("2====="+ data.getUserId());
			//}

    		paginationInfo.setTotalRecordCount(totalCnt);


    	}else{

    	}

    	model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", totalCnt);
    	model.addAttribute("paginationInfo", paginationInfo);

    	return "/oss/maketing/userCateList";
    }

	/**
	 * 문자/이메일 문구 관리 리스트
	 * Function : userCate
	 * 작성일 : 2018. 2. 6. 오후 4:36:04
	 * 작성자 : 정동수
	 * @param smsEmailWordsVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/smsEmailWords.do")
    public String userCate(@ModelAttribute("SMSEMAILWORDSVO") SMSEMAILWORDSVO smsEmailWordsVO,
    						ModelMap model){
    	log.info("/oss/smsEmailWords.do 호출");
    	
    	smsEmailWordsVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	smsEmailWordsVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(smsEmailWordsVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(smsEmailWordsVO.getPageUnit());
		paginationInfo.setPageSize(smsEmailWordsVO.getPageSize());

		smsEmailWordsVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		smsEmailWordsVO.setLastIndex(paginationInfo.getLastRecordIndex());
		smsEmailWordsVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossSmsEmailWordsService.selectWordsList(smsEmailWordsVO);
		
		@SuppressWarnings("unchecked")
		List<SMSEMAILWORDSVO> wordsList = (List<SMSEMAILWORDSVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", wordsList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
    	
    	return "/oss/maketing/smsEmailWords";
    }
	
	/**
	 * 문자/이메일 문구 등록
	 * Function : inseertWords
	 * 작성일 : 2018. 2. 6. 오후 4:38:47
	 * 작성자 : 정동수
	 * @param smsEmailWordsVO
	 * @return
	 */
	@RequestMapping("/oss/insertWords.ajax")
	public ModelAndView inseertWords(@ModelAttribute("SMSEMAILWORDSVO") SMSEMAILWORDSVO smsEmailWordsVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ossSmsEmailWordsService.insertWords(smsEmailWordsVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	/**
	 * 문자/이메일 문구 단건 조회
	 * Function : selectByWords
	 * 작성일 : 2018. 2. 6. 오후 4:39:04
	 * 작성자 : 정동수
	 * @param smsEmailWordsVO
	 * @return
	 */
	@RequestMapping("/oss/selectByWords.ajax")
	public ModelAndView selectByWords(@ModelAttribute("smsEmailWordsVO") SMSEMAILWORDSVO smsEmailWordsVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		smsEmailWordsVO = ossSmsEmailWordsService.selectByWords(smsEmailWordsVO);
		
		resultMap.put("smsEmailWordsVO", smsEmailWordsVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	/**
	 * 문자/이메일 문구 수정
	 * Function : updateWords
	 * 작성일 : 2018. 2. 6. 오후 4:39:16
	 * 작성자 : 정동수
	 * @param smsEmailWordsVO
	 * @return
	 */
	@RequestMapping("/oss/updateWords.ajax")
	public ModelAndView updateWords(@ModelAttribute("SMSEMAILWORDSVO") SMSEMAILWORDSVO smsEmailWordsVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ossSmsEmailWordsService.updateWords(smsEmailWordsVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
	
	/**
	 * 문자/이메일 문구 삭제
	 * Function : deleteWords
	 * 작성일 : 2018. 2. 6. 오후 4:39:40
	 * 작성자 : 정동수
	 * @param smsEmailWordsVO
	 * @return
	 */
	@RequestMapping("/oss/deleteWords.ajax")
	public ModelAndView deleteWords(@ModelAttribute("SMSEMAILWORDSVO") SMSEMAILWORDSVO smsEmailWordsVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ossSmsEmailWordsService.deleteWords(smsEmailWordsVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/**
	* 설명 : 메인 프로모션 순번을 랜덤으로 변경
	* 파일명 : mainPrmtSnRandom
	* 작성일 : 2022-03-31 오후 5:42
	* 작성자 : chaewan.jung
	* @param : [mainPrmtVO]
	* @return : org.springframework.web.servlet.ModelAndView
	* @throws Exception
	*/
	@RequestMapping("/oss/mainPrmtSnRandom.ajax")
	public ModelAndView mainPrmtSnRandom(@ModelAttribute("MAINPRMTVO") MAINPRMTVO mainPrmtVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		masPrmtService.updatePrmtSnRandom(mainPrmtVO);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
}
