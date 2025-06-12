package oss.bis.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mas.anls.vo.ANLS05VO;
import mas.anls.vo.ANLSSVO;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.adj.vo.ADJVO;
import oss.anls.service.OssAnlsService;
import oss.anls.vo.ANLS07VO;
import oss.anls.vo.ANLS08VO;
import oss.anls.vo.ANLS10VO;
import oss.anls.vo.ANLS11VO;
import oss.bis.service.OssBisService;
import oss.bis.service.impl.OssBisHiDAO;
import oss.bis.vo.BIS62VO;
import oss.bis.vo.BISSVO;
import oss.bis.vo.BISVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import web.order.vo.ORDERVO;
import web.order.vo.RSVSVO;
import common.Constant;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @author 정동수
 * @since  2016. 9. 6.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@Controller
public class OssBisController {
	@Autowired
    private DefaultBeanValidator beanValidator;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;
	
	@Resource(name = "ossAnlsService")
	private OssAnlsService ossAnlsService;
	
	@Resource(name="ossBisService")
    private OssBisService ossBisService;
	
	@Resource(name="ossCorpService")
	private OssCorpService ossCorpService;
	
	@Resource(name = "ossBisHiDAO")
	private OssBisHiDAO ossBisHiDAO;
		
	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@RequestMapping("/oss/bisCusUse.do")
    public String bisCusUse(@ModelAttribute("bisSVO") BISSVO bisSVO, HttpServletRequest request, ModelMap model){
		log.info("/oss/bisCusUse.do 호출");
				
		if (StringUtils.isEmpty(bisSVO.getsYear())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			bisSVO.setsYear(sdf.format(Calendar.getInstance().getTime()));
		}
		if (StringUtils.isEmpty(bisSVO.getsMonth())) {
			SimpleDateFormat sdf = new SimpleDateFormat("MM");
			bisSVO.setsMonth(sdf.format(Calendar.getInstance().getTime()));
		}
		
		// 보유하고 있는 회원 & 고객 총 인원
		Map<String, String> totalMap = ossBisService.getTotalMemCnt();
		
		// 검색 년도에 따른 회원의 가입 & 탈퇴 수
		ANLSSVO anlsSVO = new ANLSSVO();
		anlsSVO.setsFromYear(bisSVO.getsYear());
		List<ANLS05VO> memJoinOut = ossAnlsService.selectAnls09(anlsSVO);	
		
		// 검색 년월에 따른 누적 고객 통계
		ANLS10VO userPer = ossBisService.getUserPer(bisSVO);
		
		// 년월 검색에 따른 누적 매출 금액 & 건수
		ANLS11VO saleAmtCnt = ossBisService.getSaleAmtCnt(bisSVO);
		
		// 지역별 회원 & 고객 비율
		List<BISVO> areaMemCusPer = ossBisService.getAreaMemCusPer();
		
		model.addAttribute("totalMap", totalMap);
		model.addAttribute("memJoinOut", memJoinOut);
		model.addAttribute("userPer", userPer);
		model.addAttribute("saleAmtCnt", saleAmtCnt);
		model.addAttribute("areaMemCusPer", areaMemCusPer);
		
		return "/oss/bis/bisCusUse";    
	}
	
	@RequestMapping("/oss/bisCorp.do")
    public String bisCorp(@ModelAttribute("searchVO")  BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisCorp.do 호출");
		
		if(bisSVO.getsStartDt() == null){
			Date today = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			bisSVO.setsStartDt(df.format(today));
			bisSVO.setsEndDt(df.format(today));
    	}
		
		if(bisSVO.getsSortField() == null) {
			bisSVO.setsSortField("RSV_CNT");
			bisSVO.setsSortOption("DESC");
		}
		
		bisSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		bisSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bisSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bisSVO.getPageUnit());
		paginationInfo.setPageSize(bisSVO.getPageSize());

		bisSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bisSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bisSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		bisSVO.setsFlag("Y");
		
		// 입점업체 통계 리스트
		Map<String, Object> resultMap = ossBisService.getCorpAnlsList(bisSVO);
		
		if ("CADO".equals(bisSVO.getsCategory())) {
			List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
	    	model.addAttribute("categoryList", cdAddv);
		}
		
		if ("CSPU".equals(bisSVO.getsCategory())) {
			List<CDVO> categoryList = ossCmmService.selectCode("C200");
	    	model.addAttribute("categoryList", categoryList);
		}
		
		if ("CSPF".equals(bisSVO.getsCategory())) {
			List<CDVO> categoryList = ossCmmService.selectCode("C300");
	    	model.addAttribute("categoryList", categoryList);
		}
		
		if ("CSPT".equals(bisSVO.getsCategory())) {	    	
			List<CDVO> categoryList = ossCmmService.selectCode("C100");
	    	model.addAttribute("categoryList", categoryList);
		}
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	// 업체 코드 리스트
    	List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
    	model.addAttribute("corpCdList", corpCdList);
		
		model.addAttribute("sumCorpAnls", ossBisService.getSumCorpAnls(bisSVO));
		model.addAttribute("corpAnlsList", resultMap.get("corpAnlsList"));
		model.addAttribute("paginationInfo", paginationInfo);
				
		return "/oss/bis/bisCorp";   
	}
	
	@RequestMapping("/oss/bisSaleYear.do")
    public String bisSaleYear(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
		log.info("/oss/bisSaleYear.do 호출");
		
		Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	
    	if(EgovStringUtil.isEmpty(anlsSVO.getsFromYear())){
    		anlsSVO.setsFromYear(sdf.format(now));
    	}
    	
    	List<ANLS11VO> anlsList = ossBisService.selectSaleMonth(anlsSVO);
    	
   // 	List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
    	
    	model.addAttribute("nowYear", sdf.format(now));
    	model.addAttribute("anlsList", anlsList);
   // 	model.addAttribute("corpCdList", corpCdList);
		
		return "/oss/bis/bisSaleYear";
	}
	
	@RequestMapping("/oss/bisSaleMonth.do")
    public String bisSaleMonth(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
		log.info("/oss/bisSaleMonth.do 호출");
		
		Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	SimpleDateFormat sdfM = new SimpleDateFormat("MM");
    	
    	if(EgovStringUtil.isEmpty(anlsSVO.getsFromYear())){
    		anlsSVO.setsFromYear(sdf.format(now));
    	}
    	if(EgovStringUtil.isEmpty(anlsSVO.getsFromMonth())){
    		anlsSVO.setsFromMonth(sdfM.format(now));
    	}
    	
		ANLS07VO rsvAnls = ossAnlsService.selectAnls04(anlsSVO);
		ANLS08VO cancelRsvAnls = ossAnlsService.selectCancelAnls04(anlsSVO);

		model.addAttribute("nowYear", sdf.format(now));
    	model.addAttribute("nowMonth", sdfM.format(now));
    	model.addAttribute("rsvAnls", rsvAnls);
    	model.addAttribute("cancelRsvAnls", cancelRsvAnls);
		
		return "/oss/bis/bisSaleMonth";
	}
	
	@RequestMapping("/oss/bisSaleCancelDft.do")
    public String bisSaleCancelDft(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
		log.info("/oss/bisSaleCancelDft.do 호출");
		
		List<BISVO> cancelDftList = null;
		
		if ("CUR".equals(anlsSVO.getsCorpId())) {
			cancelDftList = ossBisService.selectCancelDftCur(anlsSVO);
		} else if ("PREV".equals(anlsSVO.getsCorpId())) {
			cancelDftList = ossBisService.selectCancelDftPrev(anlsSVO);
		}
		
		model.addAttribute("searchVO", anlsSVO);
		model.addAttribute("cancelDftList", cancelDftList);
		
		return "/oss/bis/bisSaleCancelDft";
	}
	
	@RequestMapping("/oss/bisSaleCancelDftExcel.do")
    public void bisSaleCancelDftExcel(@ModelAttribute("searchVO") ANLSSVO anlsSVO,
    		HttpServletRequest request, 
			HttpServletResponse response,
    		ModelMap model){
		log.info("/oss/bisSaleCancelDftExcel.do 호출");
				
		List<BISVO> cancelDftList = null;
		if ("CUR".equals(anlsSVO.getsCorpId())) {
			cancelDftList = ossBisService.selectCancelDftCur(anlsSVO);
		} else if ("PREV".equals(anlsSVO.getsCorpId())) {
			cancelDftList = ossBisService.selectCancelDftPrev(anlsSVO);
		}

		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합
		Sheet sheet1 = xlsxWb.createSheet("BI시스템 취소 통계 상세");
		
		// 컬럼 너비 설정
        sheet1.setColumnWidth(0, 5000);
        sheet1.setColumnWidth(1, 4000);
        sheet1.setColumnWidth(2, 4000);
        sheet1.setColumnWidth(3, 15000);
        sheet1.setColumnWidth(4, 3000);
        sheet1.setColumnWidth(5, 3000);
        sheet1.setColumnWidth(6, 12000);
		
        CellStyle cellStyle = xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        
        Row row = null;
        Cell cell = null;        
         
        // 첫 번째 줄
        row = sheet1.createRow(0);	
        
        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("예약번호");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(1);
        cell.setCellValue("예약일자");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(2);
        cell.setCellValue("취소일자");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(3);
        cell.setCellValue("예약정보");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(4);
        cell.setCellValue("취소금액");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(5);
        cell.setCellValue("취소수수료");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(6);
        cell.setCellValue("취소사유");
        cell.setCellStyle(cellStyle);
		
        for (int i = 0; i < cancelDftList.size(); i++) {
        	BISVO resultVO = cancelDftList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(resultVO.getRsvNum());

			cell = row.createCell(1);
			cell.setCellValue(resultVO.getRsvDt());
			
			cell = row.createCell(2);
			cell.setCellValue(resultVO.getCancelRequestDttm());
			
			cell = row.createCell(3);
			cell.setCellValue("[" + resultVO.getPrdtCateNm() + "] " + resultVO.getCorpNm() + " " + resultVO.getPrdtNm() + " " + resultVO.getPrdtInf() );
			
			cell = row.createCell(4);
			cell.setCellValue(resultVO.getCancelAmt());
			
			cell = row.createCell(5);
			cell.setCellValue(resultVO.getCmssAmt());
			
			cell = row.createCell(6);
			cell.setCellValue(resultVO.getCancelRsn());
		}
        
        // 실제 저장될 파일 이름
 		String realName = "bisSaleCancelList.xls";
 		try {
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
	
	@RequestMapping("/oss/bisSalePdfAll.do")
    public String bisSalePdfAll(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisSalePdfAll.do 호출");		
		
		// 매출 통계 공통 부분
		Map<String, Object> resultMap = saleAmtInfo("ALL", bisSVO, model);		
		bisSVO = (BISSVO) resultMap.get("bisSVO");
		model = (ModelMap) resultMap.get("model");
    			
		return "/oss/bis/bisSalePdfAll";
	}
	
	@RequestMapping("/oss/bisSalePdfAv.do")
    public String bisSalePdfAv(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisSalePdfAv.do 호출");
		
		// 매출 통계 공통 부분
		Map<String, Object> resultMap = saleAmtInfo("AV", bisSVO, model);		
		bisSVO = (BISSVO) resultMap.get("bisSVO");
		model = (ModelMap) resultMap.get("model");
		
    	// 출발 시간 건수 통계 (요일 & 시간별)
    	LinkedHashMap<String, LinkedHashMap<String, String>> avFromTimeCnt = ossBisService.selectAvFromTimeCnt(bisSVO);
    	// 예약 시기 통계 (그래프)
    	List<BISVO> avRsvPeriodPer = ossBisService.selectAvRsvPeriodPer(bisSVO);
    	// 항공권 유형 통계 (그래프)
    	List<BISVO> avTypePer = ossBisService.selectAvTypePer(bisSVO);
    	// 항공사 통계 (그래프)
    	List<BISVO> avCompanyPer = ossBisService.selectAvCompanyPer(bisSVO);
    	// 항공사 통계 (그래프)
    	List<BISVO> avFromCityPer = ossBisService.selectAvFromCityPer(bisSVO);
    	// 여행기간 통계 (그래프)
    	List<BISVO> avTourPeriodPer = ossBisService.selectAvTourPeriodPer(bisSVO);
    	
    	model.addAttribute("avFromTimeCnt", avFromTimeCnt);
    	model.addAttribute("avRsvPeriodPer", avRsvPeriodPer);
    	model.addAttribute("avTypePer", avTypePer);
    	model.addAttribute("avCompanyPer", avCompanyPer);
    	model.addAttribute("avFromCityPer", avFromCityPer);
    	model.addAttribute("avTourPeriodPer", avTourPeriodPer);
    	
    	return "/oss/bis/bisSalePdfAv";
	}
	
	@RequestMapping("/oss/bisSalePdfAd.do")
    public String bisSalePdfAd(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisSalePdfAd.do 호출");
		
		// 매출 통계 공통 부분
		Map<String, Object> resultMap = saleAmtInfo("CADO", bisSVO, model);		
		bisSVO = (BISSVO) resultMap.get("bisSVO");
		model = (ModelMap) resultMap.get("model");
    	
    	// 숙소 유형
    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
    	// 입실 건수
    	List<BISVO> adCheckInCnt = ossBisService.selectAdCheckInCnt(bisSVO);
    	// 퇴실 건수
    	List<BISVO> adCheckOutCnt = ossBisService.selectAdCheckOutCnt(bisSVO);
    	// 숙박 유형 통계 (그래프)
    	List<BISVO> adTypePer = ossBisService.selectAdTypePer(bisSVO);
    	// 숙박 기간 통계 (그래프)
    	List<BISVO> adPeriodPer = ossBisService.selectAdPeriodPer(bisSVO);
    	// 숙박 가격 통계 (그래프)
    	List<BISVO> adPricePer = ossBisService.selectAdPricePer(bisSVO);
    	// 숙박 지역 통계 (그래프)
    	List<BISVO> adAreaPer = ossBisService.selectAdAreaPer(bisSVO);
    	// 숙박 당일 예약 통계 (그래프)
    	BISVO adCurRsvPer = ossBisService.selectAdCurRsvPer(bisSVO);
    	// 숙박 예약 취소 주기 통계 (예약일 기준 - 그래프)
    	List<BISVO> adCancelRsvPer = ossBisService.selectAdCancelRsvPer(bisSVO);
    	// 숙박 예약 취소 주기 통계 (사용일 기준 - 그래프)
    	List<BISVO> adCancelUsePer = ossBisService.selectAdCancelUsePer(bisSVO);
    	
    	model.addAttribute("categoryList", cdAddv); 
    	model.addAttribute("adCheckInCnt", adCheckInCnt);
    	model.addAttribute("adCheckOutCnt", adCheckOutCnt);
    	model.addAttribute("adTypePer", adTypePer);
    	model.addAttribute("adPeriodPer", adPeriodPer);
    	model.addAttribute("adPricePer", adPricePer);
    	model.addAttribute("adAreaPer", adAreaPer);
    	model.addAttribute("adCurRsvPer", adCurRsvPer);
    	model.addAttribute("adCancelRsvPer", adCancelRsvPer);
    	model.addAttribute("adCancelUsePer", adCancelUsePer);
		
		return "/oss/bis/bisSalePdfAd";
	}
	
	@RequestMapping("/oss/bisSalePdfRc.do")
    public String bisSalePdfRc(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisSalePdfRc.do 호출");		
		
		// 매출 통계 공통 부분
		Map<String, Object> resultMap = saleAmtInfo("RC", bisSVO, model);		
		bisSVO = (BISSVO) resultMap.get("bisSVO");
		model = (ModelMap) resultMap.get("model");
		    	
    	// 렌터카 유형
    	List<CDVO> cdRcdv = ossCmmService.selectCode("CDIV");    	
    	// 인수 건수
    	List<BISVO> rcStartCnt = ossBisService.selectRcStartCnt(bisSVO);
    	// 렌터카 유형 통계 (그래프)
    	List<BISVO> rcTypePer = ossBisService.selectRcTypePer(bisSVO);
    	// 렌터카 기간 통계 (그래프)
    	List<BISVO> rcPeriodPer = ossBisService.selectRcPeriodPer(bisSVO);
    	// 렌터카 연료 통계 (그래프)
    	List<BISVO> rcFuelPer = ossBisService.selectRcFuelPer(bisSVO);
    	// 렌터카 예약 취소 주기 통계 (예약일 기준 - 그래프)
    	List<BISVO> rcCancelRsvPer = ossBisService.selectRcCancelRsvPer(bisSVO);
    	// 렌터카 예약 취소 주기 통계 (사용일 기준 - 그래프)
    	List<BISVO> rcCancelUsePer = ossBisService.selectRcCancelUsePer(bisSVO);
    	
    	// 각 유형에 따른 예약 통계 (그래프)
    	if(EgovStringUtil.isEmpty(bisSVO.getsType())){
    		BISSVO typeSVO = new BISSVO();
    		typeSVO.setsStartDt(bisSVO.getsStartDt());
    		typeSVO.setsEndDt(bisSVO.getsEndDt());
    		for (CDVO cd : cdRcdv) {
    			typeSVO.setsType(cd.getCdNum());
    			model.addAttribute("rcType" + cd.getCdNum() + "Per", ossBisService.selectRcTypeCntPer(typeSVO));
    		}
    	} else {
    		model.addAttribute("rcType" + bisSVO.getsType() + "Per", ossBisService.selectRcTypeCntPer(bisSVO));
    	}
    	
    	model.addAttribute("categoryList", cdRcdv);
    	model.addAttribute("rcStartCnt", rcStartCnt);
    	model.addAttribute("rcTypePer", rcTypePer);
    	model.addAttribute("rcPeriodPer", rcPeriodPer);
    	model.addAttribute("rcFuelPer", rcFuelPer);
    	model.addAttribute("rcCancelRsvPer", rcCancelRsvPer);    	
    	model.addAttribute("rcCancelUsePer", rcCancelUsePer);
    	
    	return "/oss/bis/bisSalePdfRc";
	}
	
	@RequestMapping("/oss/bisSalePdfSpc.do")
    public String bisSalePdfSpc(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisSalePdfSpc.do 호출");		
		
		bisSVO.setsCategory("SPC");
		
		// 매출 통계 공통 부분
		//Map<String, Object> resultMap = saleAmtInfo("COUP", bisSVO, model);		
		Map<String, Object> resultMap = saleAmtInfo("SPC", bisSVO, model);
		bisSVO = (BISSVO) resultMap.get("bisSVO");
		model = (ModelMap) resultMap.get("model");
		
		
    	
    	// 관광지 유형
    	List<CDVO> cdRcdv = ossCmmService.selectCode("C200");	
    	// 요일별 구매건수
    	List<BISVO> spcUseCnt = ossBisService.selectSpcUseCnt(bisSVO);
    	// 유형 통계 (그래프)
    	List<BISVO> spcTypePer = ossBisService.selectSpcTypePer(bisSVO);
    	// 구매 개수 통계 (그래프)
    	List<BISVO> spcBuyCntPer = ossBisService.selectSpcBuyCntPer(bisSVO);
    	// 구매 시기 통계 (그래프)
    	List<BISVO> spcBuyTimePer = ossBisService.selectSpcBuyTimePer(bisSVO);
    	// 예약 취소 주기 통계 (예약일 기준 - 그래프)
    	List<BISVO> spcCancelRsvPer = ossBisService.selectSpcCancelRsvPer(bisSVO);
    	
    	model.addAttribute("categoryList", cdRcdv);
    	model.addAttribute("spcUseCnt", spcUseCnt);
    	model.addAttribute("spcTypePer", spcTypePer);
    	model.addAttribute("spcBuyCntPer", spcBuyCntPer);
    	model.addAttribute("spcBuyTimePer", spcBuyTimePer);
    	model.addAttribute("spcCancelRsvPer", spcCancelRsvPer);
    	
    	return "/oss/bis/bisSalePdfSpc";
	}
	
	@RequestMapping("/oss/bisSalePdfSpf.do")
    public String bisSalePdfSpf(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisSalePdfSpf.do 호출");
		
		bisSVO.setsCategory("SPF");
		
		// 매출 통계 공통 부분
		//Map<String, Object> resultMap = saleAmtInfo("COUP", bisSVO, model);		
		Map<String, Object> resultMap = saleAmtInfo("SPF", bisSVO, model);
		bisSVO = (BISSVO) resultMap.get("bisSVO");
		model = (ModelMap) resultMap.get("model");
    	
    	// 관광지 유형
    	List<CDVO> cdRcdv = ossCmmService.selectCode("C300");	
    	// 요일별 구매건수
    	List<BISVO> spfUseCnt = ossBisService.selectSpcUseCnt(bisSVO);
    	// 유형 통계 (그래프)
    	List<BISVO> spfTypePer = ossBisService.selectSpcTypePer(bisSVO);
    	// 구매 개수 통계 (그래프)
    	List<BISVO> spfBuyCntPer = ossBisService.selectSpcBuyCntPer(bisSVO);
    	// 구매 시기 통계 (그래프)
    	List<BISVO> spfBuyTimePer = ossBisService.selectSpcBuyTimePer(bisSVO);
    	// 예약 취소 주기 통계 (예약일 기준 - 그래프)
    	List<BISVO> spfCancelRsvPer = ossBisService.selectSpcCancelRsvPer(bisSVO);
    	
    	model.addAttribute("categoryList", cdRcdv);
    	model.addAttribute("spfUseCnt", spfUseCnt);
    	model.addAttribute("spfTypePer", spfTypePer);
    	model.addAttribute("spfBuyCntPer", spfBuyCntPer);
    	model.addAttribute("spfBuyTimePer", spfBuyTimePer);
    	model.addAttribute("spfCancelRsvPer", spfCancelRsvPer);
    	
    	return "/oss/bis/bisSalePdfSpf";
	}
		
	@RequestMapping("/oss/bisSalePdfSpt.do")
    public String bisSalePdfSpt(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisSalePdfSpt.do 호출");		
		
		bisSVO.setsCategory("SPT");
		
		// 매출 통계 공통 부분
	//	Map<String, Object> resultMap = saleAmtInfo("TOUR", bisSVO, model);		
		Map<String, Object> resultMap = saleAmtInfo("SPT", bisSVO, model);
		bisSVO = (BISSVO) resultMap.get("bisSVO");
		model = (ModelMap) resultMap.get("model");
		    	
    	// 패키지 유형
    	List<CDVO> cdRcdv = ossCmmService.selectCode("C100");
    //	cdRcdv.addAll(ossCmmService.selectCode("C400"));
    	
    	// 유형 통계 (그래프)
    	List<BISVO> sptTypePer = ossBisService.selectSptTypePer(bisSVO);
    	// 가격 통계 (그래프)
    	List<BISVO> sptPricePer = ossBisService.selectSptPricePer(bisSVO);
    	// 예약 취소 주기 통계 (예약일 기준 - 그래프)
    	List<BISVO> sptCancelRsvPer = ossBisService.selectSptCancelRsvPer(bisSVO);
    	// 예약 취소 주기 통계 (사용일 기준 - 그래프)
    	List<BISVO> sptCancelUsePer = ossBisService.selectSptCancelUsePer(bisSVO);
    	
    	model.addAttribute("categoryList", cdRcdv);
    	model.addAttribute("sptTypePer", sptTypePer);
    	model.addAttribute("sptPricePer", sptPricePer);
    	model.addAttribute("sptCancelRsvPer", sptCancelRsvPer);
    	model.addAttribute("sptCancelUsePer", sptCancelUsePer);
    	
    	return "/oss/bis/bisSalePdfSpt";
	}
	
	@RequestMapping("/oss/bisSalePdfSpb.do")
    public String bisSalePdfSpb(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisSalePdfSpb.do 호출");
		
		bisSVO.setsCategory("SPB");
		
		// 매출 통계 공통 부분		
		Map<String, Object> resultMap = saleAmtInfo("SPB", bisSVO, model);
		bisSVO = (BISSVO) resultMap.get("bisSVO");
		model = (ModelMap) resultMap.get("model");
    	    	
    	// 구매 개수 통계 (그래프)
    	List<BISVO> spbBuyCntPer = ossBisService.selectSpcBuyCntPer(bisSVO);
    	// 구매 시기 통계 (그래프)
    	List<BISVO> spbBuyTimePer = ossBisService.selectSpcBuyTimePer(bisSVO);
    	// 예약 취소 주기 통계 (예약일 기준 - 그래프)
    	List<BISVO> spbCancelRsvPer = ossBisService.selectSpcCancelRsvPer(bisSVO);
    	
    	model.addAttribute("spbBuyCntPer", spbBuyCntPer);
    	model.addAttribute("spbBuyTimePer", spbBuyTimePer);
    	model.addAttribute("spbCancelRsvPer", spbCancelRsvPer);
    	
    	return "/oss/bis/bisSalePdfSpb";
	}
	
	@RequestMapping("/oss/bisSalePdfSv.do")
    public String bisSalePdfSv(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisSalePdfSv.do 호출");
		
		// 매출 통계 공통 부분
		Map<String, Object> resultMap = saleAmtInfo("SV", bisSVO, model);		
		bisSVO = (BISSVO) resultMap.get("bisSVO");
		model = (ModelMap) resultMap.get("model");
    	
    	// 기념품 유형
    	List<CDVO> cdSvdv = ossCmmService.selectCode("SVDV");
    	// 유형 통계 (그래프)
    	List<BISVO> svTypePer = ossBisService.selectSvTypePer(bisSVO);
    	// 구매 개수 통계 (그래프)
    	List<BISVO> svBuyCntPer = ossBisService.selectSvBuyCntPer(bisSVO);    	
    	// 예약 취소 주기 통계 (예약일 기준 - 그래프)
    	List<BISVO> svCancelRsvPer = ossBisService.selectSvCancelRsvPer(bisSVO);
    	
    	model.addAttribute("categoryList", cdSvdv);
    	model.addAttribute("svTypePer", svTypePer);
    	model.addAttribute("svBuyCntPer", svBuyCntPer);
    	model.addAttribute("svCancelRsvPer", svCancelRsvPer);
    	
    	return "/oss/bis/bisSalePdfSv";
	}
	
	@RequestMapping("/oss/bisSalePdfCp.do")
    public String bisSalePdfCp(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisSalePdfCp.do 호출");		
				
		Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");    	
    	if(EgovStringUtil.isEmpty(bisSVO.getsStartDt())){
    		Calendar cal = Calendar.getInstance();
    		cal.setTime(now);
    		cal.add(Calendar.DATE, -30);
    		
    		bisSVO.setsStartDt(sdf.format(cal.getTime()));
    	}
    	if(EgovStringUtil.isEmpty(bisSVO.getsEndDt())){
    		bisSVO.setsEndDt(sdf.format(now));
    	}
		
		// 관광지 입장권 매출 통계
		/*BISVO prdtRsvAmt = ossBisService.selectCouponRsvAmt(bisSVO);*/
    	
		// 관광지 입장권 예약 시간 건수 통계 (요일 & 시간별)
    	LinkedHashMap<String, LinkedHashMap<String, String>> prdtRsvTimeCnt = ossBisService.selectCouponRsvTimeCnt(bisSVO);
    	    	    	    	
    	// 구매 개수 통계 (그래프)
    	List<BISVO> couponBuyCntPer = ossBisService.selectCouponBuyCntPer(bisSVO);
		
		model.addAttribute("searchVO", bisSVO);
		/*model.addAttribute("prdtRsvAmt", prdtRsvAmt);*/
		model.addAttribute("prdtRsvTimeCnt", prdtRsvTimeCnt);
		model.addAttribute("couponBuyCntPer", couponBuyCntPer);
    	
    	return "/oss/bis/bisSalePdfCp";
	}
	
	// 매출 통계 공통 부분 <총 매출액 & 총 취소금액 || 예약 시간 통계 || 차트별 통계> 
	private Map<String, Object> saleAmtInfo(String category, BISSVO bisSVO, ModelMap model) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(EgovStringUtil.isEmpty(bisSVO.getsCategory())){
    		bisSVO.setsCategory(category);
    	}
		
		if(EgovStringUtil.isEmpty(bisSVO.getsGubun())){
    		bisSVO.setsGubun("RSV");
    	}
		
		Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");    	
    	if(EgovStringUtil.isEmpty(bisSVO.getsStartDt())){
    		Calendar cal = Calendar.getInstance();
    		cal.setTime(now);
    		cal.add(Calendar.DATE, -30);
    		
    		bisSVO.setsStartDt(sdf.format(cal.getTime()));
    	}
    	if(EgovStringUtil.isEmpty(bisSVO.getsEndDt())){
    		bisSVO.setsEndDt(sdf.format(now));
    	}
    	
    	// 예약 매출 금액 및 취소 금액
    	BISVO prdtRsvCancelAmt = ossBisService.selectPrdtRsvCancelAmt(bisSVO);
    	model.addAttribute("prdtRsvCancelAmt", prdtRsvCancelAmt);
    	
    	// 예약 시간 건수 통계 (요일 & 시간별)
    	LinkedHashMap<String, LinkedHashMap<String, String>> prdtRsvTimeCnt = ossBisService.selectPrdtRsvTimeCnt(bisSVO);
    	model.addAttribute("prdtRsvTimeCnt", prdtRsvTimeCnt);
    	
    	// 예약 취소 건수 (요일별)
    	List<BISVO> prdtCancelCnt = ossBisService.selectPrdtCancelCnt(bisSVO);
    	model.addAttribute("prdtCancelCnt", prdtCancelCnt);
		
		resultMap.put("model", model);
		resultMap.put("bisSVO", bisSVO);
		
		return resultMap;
	}
	
	@RequestMapping("/oss/bisAdtmEarningRate.do")
    public String bisAdtmEarningRate(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisAdtmEarningRate.do 호출");
		
		Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	 
    	if(EgovStringUtil.isEmpty(bisSVO.getsCategory())){
    		bisSVO.setsCategory("YEAR");
    	}
    	if(EgovStringUtil.isEmpty(bisSVO.getsYear())){
    		bisSVO.setsYear(sdf.format(now));
    	}
    	
    	List<BISVO> adtmList = null;
    	if ("YEAR".equals(bisSVO.getsCategory())) {
    		adtmList = ossBisService.selectAdtmYear(bisSVO);
    	}
    	else {
    		SimpleDateFormat sdfM = new SimpleDateFormat("MM");    	
        	if(EgovStringUtil.isEmpty(bisSVO.getsMonth())){
        		bisSVO.setsMonth(sdfM.format(now));
        	}
        	adtmList = ossBisService.selectAdtmMonth(bisSVO);
        	
        	model.addAttribute("nowMonth", sdfM.format(now));
    	}
    	
    	model.addAttribute("nowYear", sdf.format(now));
    	model.addAttribute("adtmList", adtmList);
		
		return "/oss/bis/bisAdtmEarningRate";
	}
	
	@RequestMapping("/oss/bisAdj.do")
    public String bisAdj(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisAdj.do 호출");
		
		Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	if(EgovStringUtil.isEmpty(bisSVO.getsCategory())){
    		bisSVO.setsCategory("ALL");
    	}
    	if(EgovStringUtil.isEmpty(bisSVO.getsStartDt())){
    		Calendar cal = Calendar.getInstance();
    		cal.setTime(now);
    		cal.add(Calendar.DATE, -30);
    		
    		bisSVO.setsStartDt(sdf.format(cal.getTime()));
    	}
    	if(EgovStringUtil.isEmpty(bisSVO.getsEndDt())){
    		bisSVO.setsEndDt(sdf.format(now));
    	}
    	
    	bisSVO.setPageUnit(propertiesService.getInt("pageUnit"));    	
		bisSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bisSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bisSVO.getPageUnit());
		paginationInfo.setPageSize(bisSVO.getPageSize());

		bisSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bisSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bisSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossBisService.selectAdjList(bisSVO);
		
		// 업체 코드 리스트
    	List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
    	model.addAttribute("corpCdList", corpCdList);
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("adjTotalCnt"));
    	    	
    	// 정산 통계 (총 판매액 & 총 판매수수료액 & 총 정산대상금액)
    	BISVO totalAdj = ossBisService.selectTotalAdj(bisSVO);
    	
    	// 결제방법 (그래프)
    	List<BISVO> payDivPer = ossBisService.selectPayDivPer(bisSVO);
    	
    	// 회원/비회원 결제비율 통계 (그래프)
    	BISVO rsvMemberPer = ossBisService.selectRsvMemberPer(bisSVO);
    	    	
    	model.addAttribute("totalAdj", totalAdj);
    	model.addAttribute("adjList", resultMap.get("adjList"));
    	model.addAttribute("payDivPer", payDivPer);
    	model.addAttribute("rsvMemberPer", rsvMemberPer);
    	model.addAttribute("paginationInfo", paginationInfo);
		
		return "/oss/bis/bisAdj";
		
	}
	
	@RequestMapping("/oss/bisAdjExcel.do")
    public void bisAdjExcel(@ModelAttribute("searchVO") BISSVO bisSVO, HttpServletRequest request, HttpServletResponse response){
		log.info("/oss/bisAdjExcel.do 호출");
		
		List<BISVO> resultList = ossBisService.selectAdjListExcel(bisSVO);
    	
		//Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합
        
        // *** Sheet-------------------------------------------------
        // Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("정산 통계 리스트");
 
        // 컬럼 너비 설정
        sheet1.setColumnWidth( 0, 2500);		//번호
        sheet1.setColumnWidth( 1, 6000); 		//업체명
        sheet1.setColumnWidth( 2, 4000);		//총 판매금액
        sheet1.setColumnWidth( 3, 4000);		//할인금액
        sheet1.setColumnWidth( 4, 4000);		//취소 수수료
        sheet1.setColumnWidth( 5, 4000);		//판매 수수료
        sheet1.setColumnWidth( 6, 4000);		//정산대상금액
        // ----------------------------------------------------------

		XSSFCellStyle cellStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;
         
        // 첫 번째 줄
        row = sheet1.createRow(0);
         
        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("번호");
        cell.setCellStyle(cellStyle);
         
        cell = row.createCell(1);
        cell.setCellValue("업체명");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(2);
        cell.setCellValue("총 판매금액");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(3);
        cell.setCellValue("할인금액");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(4);
        cell.setCellValue("취소 수수료");
        cell.setCellStyle(cellStyle);
         
        cell = row.createCell(5);
        cell.setCellValue("판매 수수료");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(6);
        cell.setCellValue("정산대상금액");
        cell.setCellStyle(cellStyle);
        //---------------------------------

        DecimalFormat fmt = new DecimalFormat("#,##0");
		for (int i = 0; i < resultList.size(); i++) {
			BISVO bisVO = resultList.get(i);
			row = sheet1.createRow(i + 1);
			
			cell = row.createCell(0);
			cell.setCellValue(i+1);
			
			cell = row.createCell(1);
			cell.setCellValue(bisVO.getCorpNm());
			
			cell = row.createCell(2);
			cell.setCellValue(fmt.format(Integer.parseInt(bisVO.getSaleAmt())));
			
			cell = row.createCell(3);
			cell.setCellValue(fmt.format(Integer.parseInt(bisVO.getCmssAmt())));
			
			cell = row.createCell(4);
			cell.setCellValue(fmt.format(Integer.parseInt(bisVO.getDisAmt())));
			
			cell = row.createCell(5);
			cell.setCellValue(fmt.format(Integer.parseInt(bisVO.getSaleCmssAmt())));
			
			cell = row.createCell(6);
			cell.setCellValue(fmt.format(Integer.parseInt(bisVO.getAdjAmt())));			
		}
 
        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "정산통계 리스트.xlsx";

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
	
	@RequestMapping("/oss/bisAdjDtl.do")
    public String bisAdjDtl(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisAdjDtl.do 호출");
		
		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(bisSVO.getsCorpId());
		
		model.addAttribute("corpInfo", ossCorpService.selectCorpByCorpId(corpVO));
		model.addAttribute("adjList", ossBisService.selectCorpAdjList(bisSVO));
		
		return "/oss/bis/bisAdjDtl";
	}
	
	@RequestMapping("/oss/bisAdjDtlExcel.do")
    public void bisAdjDtlExcel(@ModelAttribute("searchVO") BISSVO bisSVO, HttpServletRequest request, HttpServletResponse response){
		log.info("/oss/bisAdjDtlExcel.do 호출");
		
		List<ADJVO> resultList = ossBisService.selectCorpAdjList(bisSVO);
    	
		//Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합
        
        // *** Sheet-------------------------------------------------
        // Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("정산 상세 통계 리스트");
 
        // 컬럼 너비 설정
        sheet1.setColumnWidth( 0, 3500);		//정산지금일자
        sheet1.setColumnWidth( 1, 4000);		//총 판매금액        
        sheet1.setColumnWidth( 2, 4000);		//취소 수수료
        sheet1.setColumnWidth( 3, 4000);		//판매 수수료
        sheet1.setColumnWidth( 4, 4000);		//총 할인금액
        sheet1.setColumnWidth( 5, 4000);		//정산대상금액
        // ----------------------------------------------------------

		XSSFCellStyle cellStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;
         
        // 첫 번째 줄
        row = sheet1.createRow(0);
         
        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("정산지금일자");
        cell.setCellStyle(cellStyle);
                 
        cell = row.createCell(1);
        cell.setCellValue("총 판매금액");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(2);
        cell.setCellValue("취소 수수료");
        cell.setCellStyle(cellStyle);
         
        cell = row.createCell(3);
        cell.setCellValue("판매 수수료");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(4);
        cell.setCellValue("총 할인금액");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(5);
        cell.setCellValue("정산대상금액");
        cell.setCellStyle(cellStyle);
        //---------------------------------

        DecimalFormat fmt = new DecimalFormat("#,##0");
        int totalSaleAmt = 0;	int totalDisAmt = 0;	int totalSaleCmss = 0;
        int totalCmssAmt = 0;	int totalAdjAmt = 0;
        
		for (int i = 0; i < resultList.size(); i++) {
			ADJVO adjVO = resultList.get(i);
			row = sheet1.createRow(i + 1);
			
			cell = row.createCell(0);
			cell.setCellValue(adjVO.getAdjItdDt());
						
			cell = row.createCell(1);
			cell.setCellValue(fmt.format(Integer.parseInt(adjVO.getSaleAmt())));
			totalSaleAmt += Integer.parseInt(adjVO.getSaleAmt());
						
			cell = row.createCell(2);
			cell.setCellValue(fmt.format(Integer.parseInt(adjVO.getDisAmt())));
			totalDisAmt += Integer.parseInt(adjVO.getDisAmt());
			
			cell = row.createCell(3);
			cell.setCellValue(fmt.format(Integer.parseInt(adjVO.getSaleCmss())));
			totalSaleCmss += Integer.parseInt(adjVO.getSaleCmss());
			
			cell = row.createCell(4);
			cell.setCellValue(fmt.format(Integer.parseInt(adjVO.getCmssAmt())));	
			totalCmssAmt += Integer.parseInt(adjVO.getCmssAmt());
			
			cell = row.createCell(5);
			cell.setCellValue(fmt.format(Integer.parseInt(adjVO.getAdjAmt())));		
			totalAdjAmt += Integer.parseInt(adjVO.getAdjAmt());
		}
		
		// 합계 line
		row = sheet1.createRow(resultList.size() + 1);
		
		cell = row.createCell(0);
		cell.setCellValue("합 계");
					
		cell = row.createCell(1);
		cell.setCellValue(fmt.format(totalSaleAmt));
					
		cell = row.createCell(2);
		cell.setCellValue(fmt.format(totalDisAmt));
		
		cell = row.createCell(3);
		cell.setCellValue(fmt.format(totalSaleCmss));
		
		cell = row.createCell(4);
		cell.setCellValue(fmt.format(totalCmssAmt));			
		
		cell = row.createCell(5);
		cell.setCellValue(fmt.format(totalAdjAmt));	
 
        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "정산통계 상세 리스트.xlsx";

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
	
	@RequestMapping("/oss/bisDayPresentCondition.do")
    public String bisDayPresentCondition(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisDayPresentCondition.do 호출");
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");    	
    	if(EgovStringUtil.isEmpty(bisSVO.getsStartDt())){
    		bisSVO.setsStartDt(sdf.format(now));
    	}
    	
    	List<BISVO> dayConditionList = ossBisService.selectDayCondition(bisSVO);
    	BISVO dayMember = ossBisService.selectDayMember(bisSVO);
    	
    	// 하이제주의 할인쿠폰 일일현황
    	/*BISVO hijejuBis = ossBisHiDAO.selectCouponDayPresentCondition(bisSVO);*/
    	
    	model.addAttribute("dayConditionList", dayConditionList);
    	model.addAttribute("dayMember", dayMember);    	
    	/*model.addAttribute("hijejuBis", hijejuBis);*/
		
		return "/oss/bis/bisDayPresentCondition";
		
	}
	
	/**
	 * 매출현황 일일 보고
	 * Function : bisDayDayAnls
	 * 작성일 : 2018. 2. 21. 오후 3:50:17
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/bisDayDayAnls.do")
    public String bisDayDayAnls(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		log.info("/oss/bisDayDayAnls.do 호출");
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");    	
		SimpleDateFormat formatMonth = new SimpleDateFormat("M");
    	if(EgovStringUtil.isEmpty(bisSVO.getsStartDt())){
    		bisSVO.setsStartDt(sdf.format(now));
    	}
    	
    	// 현재 날짜 구하기
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDate = bisSVO.getsStartDt();
    	cal.set(Integer.parseInt(searchDate.substring(0, 4)), Integer.parseInt(searchDate.substring(5, 7)), Integer.parseInt(searchDate.substring(7, 9)));
    	
    	cal.add(Calendar.MONTH, -1);
    	model.addAttribute("prev1Month", formatMonth.format(cal.getTime()));
    	cal.add(Calendar.MONTH, -1);
    	model.addAttribute("prev2Month", formatMonth.format(cal.getTime()));
    	cal.add(Calendar.MONTH, -1);
    	model.addAttribute("prev3Month", formatMonth.format(cal.getTime()));
    	
    	// 일일현황 정보
    	BISVO dayAnls = ossBisService.selectDaydayAnls(bisSVO);
    	if (dayAnls == null) {
    		dayAnls = new BISVO();
    		dayAnls.setAvJlCnt("0");
    		dayAnls.setAvJlSaleamt("0");
    		dayAnls.setAvJcCnt("0");
    		dayAnls.setAvJcSaleamt("0");
    		dayAnls.setVisitorNum("0");
    	}
    	model.addAttribute("dayAnls", dayAnls);
    	
    	// 항공 정보
    	BISVO dayAvInfo = ossBisService.selectDayAvInfo(bisSVO);
    	model.addAttribute("dayAvInfo", dayAvInfo);
    	
    	// 예약 정보
    	Map<String, BISVO> rsvInfo = ossBisService.selectDayRsvInfo(bisSVO);
    	model.addAttribute("rsvInfo", rsvInfo);
    	
    	// 전년도 동월 매출
    	BISVO dayPrevInfo = ossBisService.selectDayPrevInfo(bisSVO);
    	model.addAttribute("dayPrevInfo", dayPrevInfo);
    	
    	// 회원 정보
    	BISVO dayMember = ossBisService.selectDayMember(bisSVO);
    	model.addAttribute("dayMember", dayMember);
    	
    	// 방문자수 정보
    	BISVO visitorInfo = ossBisService.selectVisitorInfo(bisSVO);
    	model.addAttribute("visitorInfo", visitorInfo);
    	
    	// 광고금액 정보
    	model.addAttribute("adtmAmt", ossBisService.selectAdtmAmt(bisSVO));
    	
    	/*List<BISVO> dayConditionList = ossBisService.selectDayCondition(bisSVO);
    	
    	
    	
    	
    	model.addAttribute("dayConditionList", dayConditionList);
    	    	
    	model.addAttribute("hijejuBis", hijejuBis);*/
		
		return "/oss/bis/bisDayDayAnls";
		
	}
	
	/**
	 * 매출현황 일일 보고 수정
	 * Function : updateDayDayAnls
	 * 작성일 : 2018. 2. 22. 오전 11:53:40
	 * 작성자 : 정동수
	 * @param bisVO
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping("/oss/updateDayDayAnls.do")
    public String updateDayDayAnls(@ModelAttribute("bisVO") BISVO bisVO, RedirectAttributes redirectAttributes){
		log.info("/oss/updateDayDayAnls.do 호출");
		
		ossBisService.updateDaydayAnls(bisVO);
		
		redirectAttributes.addAttribute("sStartDt", bisVO.getAnlsDt());
		return "redirect:/oss/bisDayDayAnls.do";
	}
	
	@RequestMapping("/oss/getMemCnt.ajax")
	public ModelAndView getMemCnt(@ModelAttribute("bisSVO") BISSVO bisSVO) {
		log.info("/oss/getMemCnt.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();
				
		// 검색 년도에 따른 회원의 가입 & 탈퇴 수
		ANLSSVO anlsSVO = new ANLSSVO();
		anlsSVO.setsFromYear(bisSVO.getsYear());
		List<ANLS05VO> memJoinOut = ossAnlsService.selectAnls09(anlsSVO);	
		
		resultMap.put("memCnt", memJoinOut);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		
		return modelAndView;
	}
	
	@RequestMapping("/oss/getSaveAnls.ajax")
	public ModelAndView getSaveAnls(@ModelAttribute("bisSVO") BISSVO bisSVO) {
		log.info("/oss/getMemCnt.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();
				
		// 검색 년월에 따른 누적 고객 통계
		ANLS10VO userPer = ossBisService.getUserPer(bisSVO);
		
		// 년월 검색에 따른 누적 매출 금액 & 건수
		ANLS11VO saleAmtCnt = ossBisService.getSaleAmtCnt(bisSVO);	
		
		resultMap.put("userPer", userPer);
		resultMap.put("saleAmtCnt", saleAmtCnt);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		
		return modelAndView;
	}
	
	@RequestMapping("/oss/getAdjList.ajax")
	public String getAdjList(@ModelAttribute("bisSVO") BISSVO bisSVO, ModelMap model) {
		log.info("/oss/getAdjList.ajax call");
		
		bisSVO.setPageUnit(propertiesService.getInt("pageUnit"));		
		bisSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bisSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bisSVO.getPageUnit());
		paginationInfo.setPageSize(bisSVO.getPageSize());

		bisSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bisSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bisSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossBisService.selectAdjList(bisSVO);
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("adjTotalCnt"));
    	    	
    	model.addAttribute("adjList", resultMap.get("adjList"));
    	model.addAttribute("paginationInfo", paginationInfo);
		
		return "/oss/bis/adjList";
	}
	
	@RequestMapping("/oss/getSearchCorpTool.ajax")
	public String getSearchCorpTool(@ModelAttribute("bisSVO") BISSVO bisSVO, ModelMap model) {
		log.info("/oss/getSearchCorpTool.ajax call");
		
		bisSVO.setPageUnit(propertiesService.getInt("pageUnit"));		
		bisSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bisSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bisSVO.getPageUnit());
		paginationInfo.setPageSize(bisSVO.getPageSize());

		bisSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bisSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bisSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossBisService.selectCorpNmList(bisSVO);
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("corpTotalCnt"));
    	
    	model.addAttribute("corpTotalCnt", resultMap.get("corpTotalCnt"));
		model.addAttribute("corpList", resultMap.get("corpList"));
    	model.addAttribute("paginationInfo", paginationInfo);
		
		return "/oss/bis/searchCorpTool";
	}
	
	/**
	 * 입점업체현황
	 * 파일명 : bisDayCorpAnls
	 * 작성일 : 2017. 2. 14. 오전 10:49:25
	 * 작성자 : 최영철
	 * @param bisSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/bisDayCorpAnls.do")
	public String bisDayCorpAnls(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		Date now = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(now);
		cal.add(Calendar.DATE, -1);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");    	
    	if(EgovStringUtil.isEmpty(bisSVO.getsStartDt())){
    		bisSVO.setsStartDt(sdf.format(cal.getTime()));
    	}
    	
    	List<BIS62VO> dayCorpList = ossBisService.selectDayCorpList(bisSVO);
    	
    	model.addAttribute("dayCorpList", dayCorpList);
    	model.addAttribute("SVR_TODAY", sdf.format(cal.getTime()));
    	
		return "/oss/bis/bisDayCorpAnls";
	}
	
	/**
	 * 업체구분별 상품 현황
	 * 파일명 : visDayPrdtAnls
	 * 작성일 : 2017. 2. 14. 오후 3:37:09
	 * 작성자 : 최영철
	 * @param bisSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/bisDayPrdtAnls.ajax")
	public String visDayPrdtAnls(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){
		List<BIS62VO> dayPrdtList = ossBisService.selectDayPrdtList(bisSVO);
		
		model.addAttribute("dayCorpList", dayPrdtList);
    	
		return "/oss/bis/bisDayPrdtAnls";
	}

	@RequestMapping("/oss/bisProductAnls.do")
	public String bisProductAnls(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){

		log.info("/oss/bisProductAnls.ajax call");

		bisSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		bisSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bisSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bisSVO.getPageUnit());
		paginationInfo.setPageSize(bisSVO.getPageSize());

		bisSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bisSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bisSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossBisService.selectPrdtSaleList(bisSVO);

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("resultCnt"));

		model.addAttribute("resultCnt", resultMap.get("resultCnt"));
		model.addAttribute("resultList", resultMap.get("resultList"));
		model.addAttribute("paginationInfo", paginationInfo);

		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
		model.addAttribute("corpCdList", corpCdList);

		return "/oss/bis/bisProductAnls";
	}

	@RequestMapping("/oss/bisProductAnlsExcel.do")
	public void bisProductAnlsExcel(@ModelAttribute("searchVO") BISSVO bisSVO, HttpServletRequest request, HttpServletResponse response,ModelMap model){
		log.info("/oss/bisProductAnlsExcel.do 호출");

		bisSVO.setFirstIndex(0);
		bisSVO.setLastIndex(99999999);
		Map<String, Object> resultMap = ossBisService.selectPrdtSaleList(bisSVO);
		List<BISVO> resultList = (List<BISVO>) resultMap.get("resultList");

		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합
		Sheet sheet1 = xlsxWb.createSheet("상품별 판매 통계");

		// 컬럼 너비 설정
		sheet1.setColumnWidth(0, 1000);
		sheet1.setColumnWidth(1, 3000);
		sheet1.setColumnWidth(2, 5000);
		sheet1.setColumnWidth(3, 5000);
		sheet1.setColumnWidth(4, 3000);
		sheet1.setColumnWidth(5, 4000);
		sheet1.setColumnWidth(6, 3000);
		sheet1.setColumnWidth(7, 4000);
		sheet1.setColumnWidth(8, 3000);
		sheet1.setColumnWidth(9, 4000);

		XSSFCellStyle cellStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

		Row row = null;
		Cell cell = null;

		// 첫 번째 줄
		row = sheet1.createRow(0);

		// 첫 번째 줄에 Cell 설정하기-------------
		cell = row.createCell(0);
		cell.setCellValue("순번");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(1);
		cell.setCellValue("카테고리");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(2);
		cell.setCellValue("업체명");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(3);
		cell.setCellValue("상품명");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(4);
		cell.setCellValue("순매출건수");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(5);
		cell.setCellValue("순매출액");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(6);
		cell.setCellValue("매출건수");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(7);
		cell.setCellValue("매출액");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(8);
		cell.setCellValue("취소건수");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(9);
		cell.setCellValue("취소금");
		cell.setCellStyle(cellStyle);

		for (int i = 0; i < resultList.size(); i++) {
			BISVO resultVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			/** 순번*/
			cell = row.createCell(0);
			cell.setCellValue(resultVO.getRn());

			/** 카테고리 */
			cell = row.createCell(1);
			cell.setCellValue(resultVO.getCdNm());

			/** 업체명 */
			cell = row.createCell(2);
			cell.setCellValue(resultVO.getCorpNm());

			/** 상품명 */
			cell = row.createCell(3);
			cell.setCellValue(resultVO.getPrdtNm());

			/** 순매출건수 */
			cell = row.createCell(4);
			cell.setCellValue(resultVO.getrSaleCnt());

			/** 순매출액 */
			cell = row.createCell(5);
			cell.setCellValue(resultVO.getrSaleAmt());

			/** 매출건수 */
			cell = row.createCell(6);
			cell.setCellValue(resultVO.getSaleCnt());

			/** 매출액 */
			cell = row.createCell(7);
			cell.setCellValue(resultVO.getSaleAmt());

			/**  취소건수 */
			cell = row.createCell(8);
			cell.setCellValue(resultVO.getCancelCnt());

			/** 취소금 */
			cell = row.createCell(9);
			cell.setCellValue(resultVO.getCancelAmt());
		}

		// 실제 저장될 파일 이름
		String realName = "bisSaleCancelList.xls";
		try {
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
	@RequestMapping("/oss/bisProductAnlsDtl.do")
	public String bisProductAnlsDtl(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model){

		log.info("/oss/bisProductAnlsDtl.ajax call");

		bisSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		bisSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bisSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bisSVO.getPageUnit());
		paginationInfo.setPageSize(bisSVO.getPageSize());

		bisSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bisSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bisSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossBisService.selectPrdtSaleDtl(bisSVO);

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("resultCnt"));

		model.addAttribute("resultCnt", resultMap.get("resultCnt"));
		model.addAttribute("resultList", resultMap.get("resultList"));
		model.addAttribute("paginationInfo", paginationInfo);

		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
		model.addAttribute("corpCdList", corpCdList);

		return "/oss/bis/bisProductAnls";
	}
	
	//엑셀 다운로드 기능 추가 20.06.09 김지연
    @RequestMapping("/oss/bisCorpExcelDown.do")
    public void bisCorpExcelDown(@ModelAttribute("searchVO") BISSVO bisSVO,
                              HttpServletRequest request,
                              HttpServletResponse response) {
    	log.info("/oss/bisCorpExcelDown.do 호출");
    	
    	bisSVO.setsFlag("N"); //엑셀 페이징 Flag
    	
    	// 카테고리별 조회
    	Map<String, Object> resultMap = ossBisService.getCorpAnlsList(bisSVO); 
		@SuppressWarnings("unchecked")
		List<BISVO> resultList = (List<BISVO>) resultMap.get("corpAnlsList");
		
    	// 업체 코드 리스트
    	List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
    	
    	// Workbook 생성
    	@SuppressWarnings("resource")
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합
        // *** Sheet-------------------------------------------------
        // Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("입점업체 통계");
        // 컬럼 너비 설정
        int i = 0;
        sheet1.setColumnWidth(i, 6*256);          // No
        sheet1.setColumnWidth(++i, 30*256);        // 업체명
        sheet1.setColumnWidth(++i, 15*256);        // 예약
        sheet1.setColumnWidth(++i, 15*256);        // 매출
        sheet1.setColumnWidth(++i, 15*256);        // 예약취소
        sheet1.setColumnWidth(++i, 15*256);        // 평점
        sheet1.setColumnWidth(++i, 15*256);        // 이용후기
        sheet1.setColumnWidth(++i, 15*256);        // 1:1문의
        sheet1.setColumnWidth(++i, 15*256);        // SNS공유
        sheet1.setColumnWidth(++i, 15*256);        // View
        sheet1.setColumnWidth(++i, 15*256);        // 재구매
        
        // ----------------------------------------------------------
        XSSFCellStyle headerStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        XSSFCellStyle cellStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        XSSFCellStyle cellStyle2 = (XSSFCellStyle) xlsxWb.createCellStyle();
        headerStyle.setFillForegroundColor(new XSSFColor(new java.awt.Color(234, 234, 234)));
        headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        headerStyle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyle2.setAlignment(CellStyle.ALIGN_RIGHT);

        XSSFCellStyle numericStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        XSSFDataFormat df = (XSSFDataFormat) xlsxWb.createDataFormat();
        numericStyle.setDataFormat(df.getFormat("#,##0"));

        Row row;
        Cell cell;
        
        row = sheet1.createRow(0);
        // Cell 설정
        i = 0;
        cell = row.createCell(i);
        cell.setCellValue("No");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("업체명");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("예약");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("매출");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("예약 취소");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("평점");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("이용후기");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("1:1 문의");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("SNS 공유");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("View");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("재구매");
        cell.setCellStyle(headerStyle);
        
        for(int j = 0; j < resultList.size(); j++) {
            String TsCdNm = "";
            
        	BISVO resultVO = resultList.get(j);
            row = sheet1.createRow(j + 1);

            i = 0;
            cell = row.createCell(i);
            cell.setCellValue(resultVO.getRn());
            cell.setCellStyle(cellStyle);

            cell = row.createCell(++i);
            cell.setCellStyle(cellStyle);
            if(resultVO.getTradeStatusCd().equals("TS05")) {
            	TsCdNm = "판매중지";
            } else if(resultVO.getTradeStatusCd().equals("TS07")) {
            	TsCdNm = "거래중지";
            }
            
            if(StringUtils.isNotEmpty(TsCdNm)) {
            	cell.setCellValue(resultVO.getCorpNm() + "(" + TsCdNm + ")");            	
            }else {
            	cell.setCellValue(resultVO.getCorpNm());
            }
            
            cell = row.createCell(++i);
            cell.setCellValue(resultVO.getRsvCnt() + " 건");
            cell.setCellStyle(cellStyle2);

            cell = row.createCell(++i);
            cell.setCellValue(resultVO.getNmlAmt() + "원");
            cell.setCellStyle(cellStyle2);
            
            cell = row.createCell(++i);
            cell.setCellValue(resultVO.getCancelCnt() + " 건");
            cell.setCellStyle(cellStyle2);
            
            cell = row.createCell(++i);
            cell.setCellValue(resultVO.getGpaAvg() + " 점");
            cell.setCellStyle(cellStyle2);
            
            cell = row.createCell(++i);
            cell.setCellValue(resultVO.getUseepilCnt() + " 건");
            cell.setCellStyle(cellStyle2);
            
            cell = row.createCell(++i);
            cell.setCellValue(resultVO.getOtoinqCnt() + " 건");
            cell.setCellStyle(cellStyle2);
            
            cell = row.createCell(++i);
            cell.setCellValue(resultVO.getSnsCnt() + " 건");   
            cell.setCellStyle(cellStyle2);
            
            cell = row.createCell(++i);
            cell.setCellValue(resultVO.getViewCnt() + " 건");
            cell.setCellStyle(cellStyle2);
            
            cell = row.createCell(++i);
            cell.setCellValue(resultVO.getDuplCnt() + " 건");
            cell.setCellStyle(cellStyle2);
            
        }
        // excel 파일 저장
        try {
        	String cdNm = "";
        	for(int k=0; k<corpCdList.size(); k++) {
        		if(request.getParameter("sCategory").equals(corpCdList.get(k).getCdNum())) {
        			cdNm = corpCdList.get(k).getCdNm();
        		}
        	}
            String realName = "입점업체통계_" + cdNm + ".xlsx";

            String userAgent = request.getHeader("User-Agent");

            if(userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
                response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if(userAgent.indexOf("MSIE") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if(userAgent.indexOf("Trident") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if(userAgent.indexOf("Android") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") );
            } else if(userAgent.indexOf("Swing") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8")  + ";");
            } else if(userAgent.indexOf("Mozilla/5.0") >= 0) {        // 크롬, 파폭
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
            } else {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            }
            ServletOutputStream fileOutput = response.getOutputStream();

            xlsxWb.write(fileOutput);
			fileOutput.flush();
            fileOutput.close();
            //

        } catch (FileNotFoundException e) {
            log.info(e);
            e.printStackTrace();
        } catch (IOException e) {
            log.info(e);
            e.printStackTrace();
        }
    }	
    
}
