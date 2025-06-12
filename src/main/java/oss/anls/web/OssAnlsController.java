package oss.anls.web;


import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mas.anls.vo.ANLS05VO;
import mas.anls.vo.ANLS06VO;
import mas.anls.vo.ANLSSVO;
import mas.anls.vo.ANLSVO;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.anls.service.OssAnlsService;
import oss.anls.vo.ANLS07VO;
import oss.anls.vo.ANLS08VO;
import oss.anls.vo.ANLS10VO;
import oss.anls.vo.ANLS11VO;
import oss.user.vo.USERVO;

import common.EgovUserDetailsHelper;

import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @author 최영철
 * @since  2015. 12. 14.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------        --------    ---------------------------
 */
@Controller
public class OssAnlsController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
    
	@Resource(name = "ossAnlsService")
	private OssAnlsService ossAnlsService;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    /**
     * 년도별 매출 통계
     * 파일명 : anls02
     * 작성일 : 2015. 12. 16. 오후 1:18:29
     * 작성자 : 최영철
     * @param anlsSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/anls02.do")
    public String anls02(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	
    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	if(anlsSVO.getsFromYear() == null){
    		anlsSVO.setsFromYear(sdf.format(now));
    	}
    	
    	List<ANLSVO> resultList = new ArrayList<ANLSVO>();
    	
   		resultList = ossAnlsService.selectAnls02(anlsSVO);
    	 
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("nowYear", sdf.format(now));
    	
    	return "oss/anls/anls02";
    }
    
    @RequestMapping("/oss/anls02Dtl.do")
    public String anls02Dtl(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	List<ANLSVO> resultList = new ArrayList<ANLSVO>();
    	
		resultList = ossAnlsService.selectSpAnls02Dtl(anlsSVO);
    	
    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	SimpleDateFormat sdfM = new SimpleDateFormat("MM");
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("nowYear", sdf.format(now));
    	model.addAttribute("nowMonth", sdfM.format(now));
    	return "oss/anls/anls02Dtl";
    }
    
    /**
     * 통계 - 일별현황
     * 파일명 : anls03
     * 작성일 : 2016. 8. 31. 오전 9:57:15
     * 작성자 : 최영철
     * @param anlsSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/anls03.do")
    public String anls03(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	
    	if(anlsSVO.getsFromDt() == null){
    		anlsSVO.setsFromDt(sdf.format(now));
    	}
    	
    	// 회원가입수 조회
    	ANLS05VO joinVO = ossAnlsService.selectJoinAnls(anlsSVO);
    	// 예약통계
    	List<ANLS06VO> rsvList = ossAnlsService.selectAnls06(anlsSVO);
    	
    	model.addAttribute("joinVO", joinVO);
    	model.addAttribute("rsvList", rsvList);
    	model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
    	
    	return "oss/anls/anls03";
    }
    
    @RequestMapping("/oss/anlsExcelDown1.do")
    public void anlsExcelDown1(@ModelAttribute("searchVO") ANLSSVO anlsSVO, HttpServletRequest request, HttpServletResponse response){
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		anlsSVO.setsCorpId(corpInfo.getCorpId());

		List<ANLSVO> resultList = new ArrayList<ANLSVO>();
    	
		resultList = ossAnlsService.selectAnls02(anlsSVO);

		Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

		Sheet sheet1 = xlsxWb.createSheet("매출통계");

		// 컬럼 너비 설정
		sheet1.setColumnWidth(0, 2000);
		sheet1.setColumnWidth(1, 2000);
		sheet1.setColumnWidth(2, 2000);
		sheet1.setColumnWidth(3, 2000);
		sheet1.setColumnWidth(4, 2000);
		sheet1.setColumnWidth(5, 2000);

		CellStyle cellStyle = xlsxWb.createCellStyle();
		cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

		Row row = null;
		Cell cell = null;

		// 첫 번째 줄
		row = sheet1.createRow(0);

		// 첫 번째 줄에 Cell 설정하기-------------
		cell = row.createCell(0);
		cell.setCellValue("연월");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(1);
		cell.setCellValue("예약건수");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(2);
		cell.setCellValue("판매금액");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(3);
		cell.setCellValue("취소건수");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(4);
		cell.setCellValue("취소수수료");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(5);
		cell.setCellValue("총 매출액");
		cell.setCellStyle(cellStyle);

		for (int i = 0; i < resultList.size(); i++) {
			ANLSVO adjVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(adjVO.getDt());

			cell = row.createCell(1);
			cell.setCellValue(adjVO.getRsvCnt());

			cell = row.createCell(2);
			cell.setCellValue(adjVO.getNmlAmt());

			cell = row.createCell(3);
			cell.setCellValue(adjVO.getCancelCnt());

			cell = row.createCell(4);
			cell.setCellValue(adjVO.getCmssAmt());

			cell = row.createCell(5);
			cell.setCellValue(Integer.parseInt(adjVO.getNmlAmt()) + Integer.parseInt(adjVO.getCmssAmt()));

		}

		// excel 파일 저장
		try {
			// 실제 저장될 파일 이름
			String realName = "매출통계.xlsx";

			String userAgent = request.getHeader("User-Agent");
			if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS
																			// IE
																			// 5.5
																			// 이하
				response.setHeader("Content-Disposition", "filename="
						+ URLEncoder.encode(realName, "UTF-8") + ";");
			} else if (userAgent.indexOf("MSIE") >= 0) {
				response.setHeader(
						"Content-Disposition",
						"attachment; filename="
								+ URLEncoder.encode(realName, "UTF-8") + ";");
			} else if (userAgent.indexOf("Trident") >= 0) {
				response.setHeader(
						"Content-Disposition",
						"attachment; filename="
								+ URLEncoder.encode(realName, "UTF-8") + ";");
			} else if (userAgent.indexOf("Android") >= 0) {
				response.setHeader(
						"Content-Disposition",
						"attachment; filename="
								+ URLEncoder.encode(realName, "UTF-8"));
			} else if (userAgent.indexOf("Swing") >= 0) {
				response.setHeader(
						"Content-Disposition",
						"attachment; filename="
								+ URLEncoder.encode(realName, "UTF-8") + ";");
			}
			// 크롬, 파폭
			else if (userAgent.indexOf("Mozilla/5.0") >= 0) {
				response.setHeader(
						"Content-Disposition",
						"attachment; filename="
								+ new String(realName.getBytes("UTF-8"),
										"ISO-8859-1") + ";");
			} else {
				response.setHeader(
						"Content-Disposition",
						"attachment; filename="
								+ URLEncoder.encode(realName, "UTF-8") + ";");
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
    
    @RequestMapping("/oss/anlsDtlExcelDown1.do")
    public void anlsDtlExcelDown1(@ModelAttribute("searchVO") ANLSSVO anlsSVO, HttpServletRequest request, HttpServletResponse response){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	anlsSVO.setsCorpId(corpInfo.getCorpId());
    	
    	List<ANLSVO> resultList = new ArrayList<ANLSVO>();
    	
    	resultList = ossAnlsService.selectSpAnls02Dtl(anlsSVO);
    	
    	Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상
    	
    	Sheet sheet1 = xlsxWb.createSheet("매출통계");
    	
    	// 컬럼 너비 설정
    	sheet1.setColumnWidth(0, 2000);
    	sheet1.setColumnWidth(1, 2000);
    	sheet1.setColumnWidth(2, 2000);
    	sheet1.setColumnWidth(3, 2000);
    	sheet1.setColumnWidth(4, 2000);
    	sheet1.setColumnWidth(5, 2000);
    	
    	CellStyle cellStyle = xlsxWb.createCellStyle();
    	cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
    	
    	Row row = null;
    	Cell cell = null;
    	
    	// 첫 번째 줄
    	row = sheet1.createRow(0);
    	
    	// 첫 번째 줄에 Cell 설정하기-------------
    	cell = row.createCell(0);
    	cell.setCellValue("일자");
    	cell.setCellStyle(cellStyle);
    	
    	cell = row.createCell(1);
    	cell.setCellValue("예약건수");
    	cell.setCellStyle(cellStyle);
    	
    	cell = row.createCell(2);
    	cell.setCellValue("판매금액");
    	cell.setCellStyle(cellStyle);
    	
    	cell = row.createCell(3);
    	cell.setCellValue("취소건수");
    	cell.setCellStyle(cellStyle);
    	
    	cell = row.createCell(4);
    	cell.setCellValue("취소수수료");
    	cell.setCellStyle(cellStyle);
    	
    	cell = row.createCell(5);
    	cell.setCellValue("매출액");
    	cell.setCellStyle(cellStyle);
    	
    	for (int i = 0; i < resultList.size(); i++) {
			ANLSVO adjVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(adjVO.getDt());

			cell = row.createCell(1);
			cell.setCellValue(adjVO.getRsvCnt());

			cell = row.createCell(2);
			cell.setCellValue(adjVO.getNmlAmt());

			cell = row.createCell(3);
			cell.setCellValue(adjVO.getCancelCnt());

			cell = row.createCell(4);
			cell.setCellValue(adjVO.getCmssAmt());

			cell = row.createCell(5);
			cell.setCellValue(Integer.parseInt(adjVO.getNmlAmt()) + Integer.parseInt(adjVO.getCmssAmt()));

		}
    	
    	// excel 파일 저장
    	try {
    		// 실제 저장될 파일 이름
    		String realName = "상세매출통계.xlsx";
    		
    		String userAgent = request.getHeader("User-Agent");
    		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS
    			// IE
    			// 5.5
    			// 이하
    			response.setHeader("Content-Disposition", "filename="
    					+ URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if (userAgent.indexOf("MSIE") >= 0) {
    			response.setHeader(
    					"Content-Disposition",
    					"attachment; filename="
    							+ URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if (userAgent.indexOf("Trident") >= 0) {
    			response.setHeader(
    					"Content-Disposition",
    					"attachment; filename="
    							+ URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if (userAgent.indexOf("Android") >= 0) {
    			response.setHeader(
    					"Content-Disposition",
    					"attachment; filename="
    							+ URLEncoder.encode(realName, "UTF-8"));
    		} else if (userAgent.indexOf("Swing") >= 0) {
    			response.setHeader(
    					"Content-Disposition",
    					"attachment; filename="
    							+ URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		// 크롬, 파폭
    		else if (userAgent.indexOf("Mozilla/5.0") >= 0) {
    			response.setHeader(
    					"Content-Disposition",
    					"attachment; filename="
    							+ new String(realName.getBytes("UTF-8"),
    									"ISO-8859-1") + ";");
    		} else {
    			response.setHeader(
    					"Content-Disposition",
    					"attachment; filename="
    							+ URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		
    		ServletOutputStream fileOutput = response.getOutputStream();
    		
    		// File xlsFile = new File("C:/tamnao_data/정산_" + adjSVO.getsAdjDt()
    		// + ".xlsx");
    		// FileOutputStream fileOut = new FileOutputStream(xlsFile);
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
    
    /**
     * 매출통계
     * 파일명 : anls04
     * 작성일 : 2016. 3. 18. 오전 10:41:02
     * 작성자 : 최영철
     * @param anlsSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/anls04.do")
    public String anls04(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	
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
    	return "oss/anls/anls04";
    }
    
    @RequestMapping("/oss/anls05.do")
    public String anls05(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	
    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	
    	if(EgovStringUtil.isEmpty(anlsSVO.getsFromYear())){
    		anlsSVO.setsFromYear(sdf.format(now));
    	}
    	
    	List<ANLS05VO> userList = ossAnlsService.selectAnls09(anlsSVO);
    	ANLS10VO userPer = ossAnlsService.selectAnls10();
    	
    	model.addAttribute("nowYear", sdf.format(now));
    	model.addAttribute("userList", userList);
    	model.addAttribute("userPer", userPer);
    	return "oss/anls/anls05";
    }
    
    @RequestMapping("/oss/anls06.do")
    public String anls06(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	
    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	
    	if(EgovStringUtil.isEmpty(anlsSVO.getsFromYear())){
    		anlsSVO.setsFromYear(sdf.format(now));
    	}
    	
    	List<ANLS11VO> anlsList = ossAnlsService.selectAnls11(anlsSVO);
    	
    	model.addAttribute("nowYear", sdf.format(now));
    	model.addAttribute("anlsList", anlsList);
    	return "oss/anls/anls06";
    }
    
}
