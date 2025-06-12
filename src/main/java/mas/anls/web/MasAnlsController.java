package mas.anls.web;


import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mas.anls.service.MasAnlsService;
import mas.anls.vo.ANLSOPTVO;
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

import oss.user.vo.USERVO;

import common.Constant;
import common.EgovUserDetailsHelper;

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
public class MasAnlsController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
    
	@Resource(name = "masAnlsService")
	private MasAnlsService masAnlsService;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    /**
     * 숙박 상품별 누적통계
     * 파일명 : adAnls01
     * 작성일 : 2015. 12. 14. 오후 10:07:50
     * 작성자 : 최영철
     * @param anlsSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/anls01.do")
    public String adAnls01(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	anlsSVO.setsCorpId(corpInfo.getCorpId());
    	
    	if(anlsSVO.getsFromDt() == null){
    		Date now = new Date();
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
        	SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd");
        	anlsSVO.setsFromDt(sdf.format(now) + "0101");
        	anlsSVO.setsFromDtView(sdf.format(now) + "-01-01");
        	anlsSVO.setsToDt(sdf2.format(now));
        	anlsSVO.setsToDtView(sdf3.format(now));
    	}
    	
    	List<ANLSVO> resultList = masAnlsService.selectAdAnls01(anlsSVO); 
    	model.addAttribute("resultList", resultList);
    	return "mas/anls/anls01";
    }
    
    /**
     * 렌터카 상품별 누적통계
     * 파일명 : adAnls01
     * 작성일 : 2015. 12. 14. 오후 10:07:50
     * 작성자 : 최영철
     * @param anlsSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/anls01.do")
    public String rcAnls01(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	anlsSVO.setsCorpId(corpInfo.getCorpId());
    	
    	if(anlsSVO.getsFromDt() == null){
    		Date now = new Date();
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
    		SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd");
    		anlsSVO.setsFromDt(sdf.format(now) + "0101");
    		anlsSVO.setsFromDtView(sdf.format(now) + "-01-01");
    		anlsSVO.setsToDt(sdf2.format(now));
    		anlsSVO.setsToDtView(sdf3.format(now));
    	}
    	
    	List<ANLSVO> resultList = masAnlsService.selectRcAnls01(anlsSVO); 
    	model.addAttribute("resultList", resultList);
    	return "mas/anls/anls01";
    }

    /**
     * 소셜상품 상품별 누적통계
     * 파일명 : spAnls01
     * 작성일 : 2015. 12. 14. 오후 10:07:50
     * 작성자 : 최영철
     * @param anlsSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/sp/anls01.do")
    public String spAnls01(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	anlsSVO.setsCorpId(corpInfo.getCorpId());
    	
    	if(anlsSVO.getsFromDt() == null){
    		Date now = new Date();
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
    		SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd");
    		anlsSVO.setsFromDt(sdf.format(now) + "0101");
    		anlsSVO.setsFromDtView(sdf.format(now) + "-01-01");
    		anlsSVO.setsToDt(sdf2.format(now));
    		anlsSVO.setsToDtView(sdf3.format(now));
    	}
    	
    	List<ANLSVO> resultList = masAnlsService.selectSpAnls01(anlsSVO); 
    	model.addAttribute("resultList", resultList);
    	return "mas/anls/anls01";
    }
    
    /**
     * 년도별 매출 통계
     * 파일명 : anls02
     * 작성일 : 2015. 12. 16. 오후 1:18:29
     * 작성자 : 최영철
     * @param anlsSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/anls02.do")
    public String anls02(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	anlsSVO.setsCorpId(corpInfo.getCorpId());
    	
    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	if(anlsSVO.getsFromYear() == null){
    		anlsSVO.setsFromYear(sdf.format(now));
    	}
    	
    	List<ANLSVO> resultList = new ArrayList<ANLSVO>();
    	
    	if(Constant.ACCOMMODATION.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectAdAnls02(anlsSVO);
    	}else if(Constant.RENTCAR.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectRcAnls02(anlsSVO);
    	}else if(Constant.SOCIAL.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectSpAnls02(anlsSVO);
    	}else if(Constant.SOCIAL.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectSpAnls02(anlsSVO);
    	}else if(Constant.SV.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectSvAnls02(anlsSVO);
    	}
    	
    	
    	 
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("nowYear", sdf.format(now));
    	
    	return "mas/anls/anls02";
    }
    
    @RequestMapping("/mas/anls02Dtl.do")
    public String anls02Dtl(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	anlsSVO.setsCorpId(corpInfo.getCorpId());
    	
    	List<ANLSVO> resultList = new ArrayList<ANLSVO>();
    	
    	if(Constant.ACCOMMODATION.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectAdAnls02Dtl(anlsSVO);
    	}else if(Constant.RENTCAR.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectRcAnls02Dtl(anlsSVO);
    	}else if(Constant.SOCIAL.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectSpAnls02Dtl(anlsSVO);
    	}
    	
    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	SimpleDateFormat sdfM = new SimpleDateFormat("MM");
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("nowYear", sdf.format(now));
    	model.addAttribute("nowMonth", sdfM.format(now));
    	return "mas/anls/anls02Dtl";
    }
    
    /**
     * 년도별 옵션별 매출 통계
     * 파일명 : anls02SP
     * 작성일 : 2015. 12. 16. 오후 1:18:29
     * 작성자 : 최영철
     * @param anlsSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/sp/anls02.do")
    public String anls02SP(@ModelAttribute("searchVO") ANLSSVO anlsSVO, ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	anlsSVO.setsCorpId(corpInfo.getCorpId());
    	
    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	if(anlsSVO.getsFromYear() == null){
    		anlsSVO.setsFromYear(sdf.format(now));
    	}
    	
    	List<ANLSOPTVO> resultList = masAnlsService.selectSpAnls02Opt(anlsSVO);
    	 
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("nowYear", sdf.format(now));
    	
    	return "mas/anls/anls02SP";
    }
    
    @RequestMapping("/mas/anlsExcelDown1.do")
    public void anlsExcelDown1(@ModelAttribute("searchVO") ANLSSVO anlsSVO, HttpServletRequest request, HttpServletResponse response){
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		anlsSVO.setsCorpId(corpInfo.getCorpId());

		List<ANLSVO> resultList = new ArrayList<ANLSVO>();
    	
    	if(Constant.ACCOMMODATION.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectAdAnls02(anlsSVO);
    	}else if(Constant.RENTCAR.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectRcAnls02(anlsSVO);
    	}else if(Constant.SOCIAL.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectSpAnls02(anlsSVO);
    	}else if(Constant.SV.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectSvAnls02(anlsSVO);
    	}

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
    
    
    @RequestMapping("/mas/anlsDtlExcelDown1.do")
    public void anlsDtlExcelDown1(@ModelAttribute("searchVO") ANLSSVO anlsSVO, HttpServletRequest request, HttpServletResponse response){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	anlsSVO.setsCorpId(corpInfo.getCorpId());
    	
    	List<ANLSVO> resultList = new ArrayList<ANLSVO>();
    	
    	if(Constant.ACCOMMODATION.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectAdAnls02Dtl(anlsSVO);
    	}else if(Constant.RENTCAR.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectRcAnls02Dtl(anlsSVO);
    	}else if(Constant.SOCIAL.equals(corpInfo.getCorpCd())){
    		resultList = masAnlsService.selectSpAnls02Dtl(anlsSVO);
    	}
    	
    	Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상
    	
    	Sheet sheet1 = xlsxWb.createSheet("매출통계");
    	
    	// 컬럼 너비 설정
    	sheet1.setColumnWidth(0, 2000);
    	sheet1.setColumnWidth(1, 2000);
    	sheet1.setColumnWidth(2, 2000);
    	sheet1.setColumnWidth(3, 2000);
    	sheet1.setColumnWidth(4, 2000);
    	sheet1.setColumnWidth(5, 2000);
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
    	cell.setCellValue("취소금액");
    	cell.setCellStyle(cellStyle);
    	
    	cell = row.createCell(5);
    	cell.setCellValue("취소수수료");
    	cell.setCellStyle(cellStyle);
    	
    	cell = row.createCell(6);
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
			cell.setCellValue(adjVO.getCancelAmt());

			cell = row.createCell(5);
			cell.setCellValue(adjVO.getCmssAmt());

			cell = row.createCell(6);
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
}
