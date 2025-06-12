package mas.adj.web;


import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.rte.fdl.property.EgovPropertyService;
import mas.adj.service.MasAdjService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.adj.service.OssAdjService;
import oss.adj.vo.ADJDTLINFVO;
import oss.adj.vo.ADJSVO;
import oss.adj.vo.ADJVO;
import oss.user.vo.USERVO;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;


@Controller
public class MasAdjController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name="ossAdjService")
	protected OssAdjService ossAdjService;
	
	@Resource(name="masAdjService")
	protected MasAdjService masAdjService;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    
    /**
     * 정산내역 리스트 조회
     * 파일명 : adjList
     * 작성일 : 2016. 1. 12. 오전 11:10:23
     * 작성자 : 최영철
     * @param adjSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/adjList.do")
    public String adjList(@ModelAttribute("searchVO") ADJSVO adjSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	adjSVO.setsCorpId(corpInfo.getCorpId());
    	/*Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    	SimpleDateFormat sdfM = new SimpleDateFormat("MM");
    	
    	if(adjSVO.getsFromYear() == null || adjSVO.getsFromMonth() == null){
    		adjSVO.setsFromYear(sdf.format(now));
    		adjSVO.setsFromMonth(sdfM.format(now));
    	}*/
    	
    	Calendar cal = Calendar.getInstance();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	
    	if(adjSVO.getsStartDt() == null || adjSVO.getsEndDt() == null){
    		adjSVO.setsEndDt(sdf.format(cal.getTime()));
    		cal.add(Calendar.MONTH, -1);
    		adjSVO.setsStartDt(sdf.format(cal.getTime()));
    	}
    	
    	List<ADJVO> adjList = masAdjService.selectCorpAdjListSearch(adjSVO);
    	
    	model.addAttribute("resultList", adjList);
//    	model.addAttribute("nowYear", sdf.format(now));
//    	model.addAttribute("nowMonth", sdfM.format(now));
    	
    	return "mas/adj/adjList";
    }
    
    @RequestMapping("/mas/dtlAdjList.do")
    public String dtlAdjList(@ModelAttribute("searchVO") ADJSVO adjSVO,
							 ModelMap model) {
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	adjSVO.setsCorpId(corpInfo.getCorpId());
    	
    	adjSVO.setsAdjDt(adjSVO.getsAdjDt().replaceAll("-", ""));
    	List<ADJDTLINFVO> adjList = ossAdjService.selectAdjInfList(adjSVO);
    	
    	model.addAttribute("resultList", adjList);
		model.addAttribute("corpInfo", corpInfo);
    	
    	return "mas/adj/dtlAdjList";
    }
    
    @RequestMapping("/mas/adjustExcelDown1.do")
    public void adjustExcelDown1(@ModelAttribute("searchVO") ADJSVO adjSVO,
								 HttpServletRequest request,
								 HttpServletResponse response){
		/*USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		adjSVO.setsCorpId(corpInfo.getCorpId());*/

		adjSVO.setsAdjDt(adjSVO.getsAdjDt().replaceAll("-", ""));

		List<ADJDTLINFVO> adjList = ossAdjService.selectAdjInfList(adjSVO);

		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

		Sheet sheet1 = xlsxWb.createSheet("정산내역");

		// 컬럼 너비 설정
		sheet1.setColumnWidth(0, 16*256);
		sheet1.setColumnWidth(1, 30*256);
		sheet1.setColumnWidth(2, 50*256);
		sheet1.setColumnWidth(3, 20*256);
		sheet1.setColumnWidth(4, 10*256);
		sheet1.setColumnWidth(5, 14*256);
		sheet1.setColumnWidth(6, 12*256);
		sheet1.setColumnWidth(7, 14*256);
		sheet1.setColumnWidth(8, 14*256);
		sheet1.setColumnWidth(9, 14*256);
		sheet1.setColumnWidth(10, 14*256);
		sheet1.setColumnWidth(11, 10*256);

		XSSFCellStyle headerStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		headerStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		headerStyle.setAlignment(CellStyle.ALIGN_CENTER);

		XSSFCellStyle numericStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		XSSFDataFormat df = (XSSFDataFormat) xlsxWb.createDataFormat();
		numericStyle.setDataFormat(df.getFormat("#,##0"));

		XSSFCellStyle numericStyle2 = (XSSFCellStyle) xlsxWb.createCellStyle();
		numericStyle2.setDataFormat(df.getFormat("0.0"));

		XSSFCellStyle centerStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		centerStyle.setAlignment(CellStyle.ALIGN_CENTER);

		Row row;
		Cell cell;

		// 첫 번째 줄
		row = sheet1.createRow(0);

		// 첫 번째 줄에 Cell 설정하기-------------
		cell = row.createCell(0);
		cell.setCellValue("예약번호");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(1);
		cell.setCellValue("상품명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(2);
		cell.setCellValue("상품정보");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(3);
		cell.setCellValue("예약자");
		cell.setCellStyle(headerStyle);
		
		cell = row.createCell(4);
		cell.setCellValue("예약결과");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(5);
		cell.setCellValue("판매금액");
		cell.setCellStyle(headerStyle);
		
		cell = row.createCell(6);
		cell.setCellValue("L.Point 사용");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(7);
		cell.setCellValue("취소수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(8);
		cell.setCellValue("판매수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(9);
		cell.setCellValue("정산 금액");
		cell.setCellStyle(headerStyle);
		
		cell = row.createCell(10);
		cell.setCellValue("업체지원할인금");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(11);
		cell.setCellValue("수수료율");
		cell.setCellStyle(headerStyle);

		for(int i = 0; i < adjList.size(); i++) {
			ADJDTLINFVO adjVO = adjList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(adjVO.getRsvNum());

			cell = row.createCell(1);
			cell.setCellValue(adjVO.getPrdtNm());

			cell = row.createCell(2);
			cell.setCellValue(adjVO.getPrdtInf());
			
			cell = row.createCell(3);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getRsvNm());

			String rsvStatusCd = adjVO.getRsvStatusCd();
			String rsvStatus = "";
			if(Constant.RSV_STATUS_CD_UCOM.equals(rsvStatusCd)) {
				rsvStatus = "사용완료";
			} else if(Constant.RSV_STATUS_CD_ECOM.equals(rsvStatusCd)) {
				rsvStatus = "기간만료";
			} else if(Constant.RSV_STATUS_CD_SCOM.equals(rsvStatusCd)) {
				rsvStatus = "부분환불완료";
			} else if(Constant.RSV_STATUS_CD_CCOM.equals(rsvStatusCd)) {
				rsvStatus = "취소";
			}
			cell = row.createCell(4);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(rsvStatus);

			cell = row.createCell(5);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleAmt()));

			cell = row.createCell(6);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getLpointUseFlag());
			
			cell = row.createCell(7);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCmssAmt()));

			int supportDisCmss = (int) (Integer.parseInt(adjVO.getDisCmssAmt()));
			int pointCmss = (int) (Integer.parseInt(adjVO.getPointCmssAmt()));

			int saleCmss = Integer.parseInt(adjVO.getSaleCmss());

			cell = row.createCell(8);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(saleCmss + supportDisCmss + pointCmss);

			int adjAmt = 0;
			if(Constant.RSV_STATUS_CD_CCOM.equals(rsvStatusCd) || Constant.RSV_STATUS_CD_SCOM.equals(rsvStatusCd)) {
				adjAmt = Integer.parseInt(adjVO.getCmssAmt()) - saleCmss - supportDisCmss - pointCmss ;
			} else if(Constant.RSV_STATUS_CD_UCOM.equals(rsvStatusCd) || Constant.RSV_STATUS_CD_ECOM.equals(rsvStatusCd)) {
				adjAmt = Integer.parseInt(adjVO.getSaleAmt()) - saleCmss - supportDisCmss - pointCmss;
			}
			cell = row.createCell(9);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(adjAmt);

			cell = row.createCell(10);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCorpDisAmt()));

			cell = row.createCell(11);
			cell.setCellStyle(numericStyle2);
			cell.setCellValue(Double.parseDouble(adjVO.getAdjAplPct()));
		}

		// excel 파일 저장
		try {
			String fileName = "정산상세_" + adjSVO.getsAdjDt() + ".xlsx";
			String userAgent = request.getHeader("User-Agent");

			if(userAgent.contains("Edge")) {
				fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
				response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
			} else if(userAgent.contains("MSIE") || userAgent.contains("Trident")) { // IE 11버전부터 Trident로 변경되었기때문에 추가해준다.
				fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
				response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
			} else if(userAgent.contains("Chrome")) {
				fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
				response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
			} else if(userAgent.contains("Opera")) {
				fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
				response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
			} else if(userAgent.contains("Firefox")) {
				fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
				response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
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
    
}
