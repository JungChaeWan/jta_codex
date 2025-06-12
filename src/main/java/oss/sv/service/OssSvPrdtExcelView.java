package oss.sv.service;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import oss.sv.vo.OSS_SV_PRDTINFVO;
import egovframework.cmmn.AbstractPOIExcelView;

public class OssSvPrdtExcelView extends AbstractPOIExcelView{

//	private static final Logger LOGGER  = LoggerFactory.getLogger(AdjExcelView.class);
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, XSSFWorkbook wb, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String fileName = "관광기념품.xlsx";
		
		String userAgent = request.getHeader("User-Agent");
		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { 
			response.setHeader("Content-Disposition", "filename="+ URLEncoder.encode(fileName, "UTF-8") + ";");
		} else if (userAgent.indexOf("MSIE") >= 0) {
			response.setHeader("Content-Disposition","attachment; filename="+ URLEncoder.encode(fileName, "UTF-8") + ";");
		} else if (userAgent.indexOf("Trident") >= 0) {
			response.setHeader("Content-Disposition","attachment; filename="+ URLEncoder.encode(fileName, "UTF-8") + ";");
		} else if (userAgent.indexOf("Android") >= 0) {
			response.setHeader("Content-Disposition","attachment; filename="+ URLEncoder.encode(fileName, "UTF-8"));
		} else if (userAgent.indexOf("Swing") >= 0) {
			response.setHeader("Content-Disposition","attachment; filename="+ URLEncoder.encode(fileName, "UTF-8") + ";");
		}
		// 크롬, 파폭
		else if (userAgent.indexOf("Mozilla/5.0") >= 0) {
			response.setHeader("Content-Disposition","attachment; filename="+ URLEncoder.encode(fileName,"UTF-8") + ";charset=\"UTF-8\"");
		} else {
			response.setHeader("Content-Disposition","attachment; filename="+ URLEncoder.encode(fileName, "UTF-8") + ";");
		}
		
		String mode = (String) model.get("mode");
		logger.debug("mode :: " + mode);
		makeExcelFile(wb, model, mode);
	}
	
	@SuppressWarnings("unchecked")
	private void makeExcelFile(XSSFWorkbook wb, Map<String, Object> model, String mode)
			throws Exception {

		// 시트 생성( 시트명, 인덱스 )
		XSSFSheet sheet = wb.createSheet("상품리스트");
		if(StringUtils.equals(mode, "prdtList")) {
	        sheet.setDefaultColumnWidth(8);
	        
	        sheet.setColumnWidth(0, 2000);
	        setText(getCell(sheet, 0, 0), "번호");
	        
	        sheet.setColumnWidth(1, 4000);
	        setText(getCell(sheet, 0, 1), "상품번호");
	        
	        sheet.setColumnWidth(2, 3000);
	        setText(getCell(sheet, 0, 2), "상태");
	        
	        sheet.setColumnWidth(3, 6000);
	        setText(getCell(sheet, 0, 3), "업체명");
	        
	        sheet.setColumnWidth(4, 10000);
	        setText(getCell(sheet, 0, 4), "상품명");
	        
	        sheet.setColumnWidth(5, 5000);
	        setText(getCell(sheet, 0, 5), "판매기간");
	        
	        sheet.setColumnWidth(6, 8000);
	        setText(getCell(sheet, 0, 6), "요청일");
	        
	        sheet.setColumnWidth(7, 8000);
	        setText(getCell(sheet, 0, 7), "승인일");

	        sheet.setColumnWidth(8, 8000);
	        setText(getCell(sheet, 0, 8), "주소");

	        sheet.setColumnWidth(9, 8000);
	        setText(getCell(sheet, 0, 9), "카테고리");

	        sheet.setColumnWidth(10, 8000);
	        setText(getCell(sheet, 0, 10), "6차산업여부");
	        
	        List<OSS_SV_PRDTINFVO> resultList = (List<OSS_SV_PRDTINFVO>) model.get("resultList"); 
	        
	        XSSFCell cell = getCell(sheet, 0, 0);
	        
	        for (int i = 0; i < resultList.size(); i++) {
	        	OSS_SV_PRDTINFVO resultVO = (OSS_SV_PRDTINFVO) resultList.get(i);
	        	
	        	// 번호
				cell = getCell(sheet, 1 + i, 0);
		        setText(cell, String.valueOf(i+1));
		        
		        // 상품번호
		        cell = getCell(sheet, 1 + i, 1);
		        setText(cell, resultVO.getPrdtNum());
		        
		        // 상태
		        cell = getCell(sheet, 1 + i, 2);
		        setText(cell, resultVO.getTradeStatusNm());
		        
		        // 업체명
		        cell = getCell(sheet, 1 + i, 3);
		        setText(cell, resultVO.getCorpNm());
		        
		        // 상품명
		        cell = getCell(sheet, 1 + i, 4);
		        setText(cell, resultVO.getPrdtNm());
		        
		        // 판매기간
		        cell = getCell(sheet, 1 + i, 5);
		        setText(cell, resultVO.getSaleStartDt() + " ~ " + resultVO.getSaleEndDt());
		        
		        // 요청일
		        cell = getCell(sheet, 1 + i, 6);
		        setText(cell, resultVO.getConfRequestDttm());
		        
		        // 승인일
		        cell = getCell(sheet, 1 + i, 7);
		        setText(cell, resultVO.getConfDttm());

		        // 주소
		        cell = getCell(sheet, 1 + i, 8);
		        setText(cell, resultVO.getRoadNmAddr());

		        // 카테고리
		        cell = getCell(sheet, 1 + i, 9);
		        setText(cell, resultVO.getSubCtgr());

		        // 6차산업여부
		        cell = getCell(sheet, 1 + i, 10);
		        setText(cell, resultVO.getSixCertiCate());
	        }
		}
		
	}
	
	
}
