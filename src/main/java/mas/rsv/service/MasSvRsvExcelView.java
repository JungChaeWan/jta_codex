package mas.rsv.service;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import common.Constant;
import web.order.vo.SV_RSVVO;
import egovframework.cmmn.AbstractPOIExcelView;
import egovframework.cmmn.service.EgovStringUtil;

public class MasSvRsvExcelView extends AbstractPOIExcelView{

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
		XSSFSheet sheet = wb.createSheet("구매리스트");
		if(StringUtils.equals(mode, "rsvList")) {
	        sheet.setDefaultColumnWidth(13);
	        
	        sheet.setColumnWidth(0, 4000);
	        setText(getCell(sheet, 0, 0), "구매번호");
	        
	        sheet.setColumnWidth(1, 3000);
	        setText(getCell(sheet, 0, 1), "구매상태");
	        
	        sheet.setColumnWidth(2, 6000);
	        setText(getCell(sheet, 0, 2), "상품명");
	        
	        sheet.setColumnWidth(3, 10000);
	        setText(getCell(sheet, 0, 3), "옵션명");
	        
	        sheet.setColumnWidth(4, 1000);
	        setText(getCell(sheet, 0, 4), "구매수");
	        
	        sheet.setColumnWidth(5, 4000);
	        setText(getCell(sheet, 0, 5), "구매자");
	        
	        sheet.setColumnWidth(6, 4000);
	        setText(getCell(sheet, 0, 6), "구매자 전화번호");
	        
	        sheet.setColumnWidth(7, 4000);
	        setText(getCell(sheet, 0, 7), "수령인");
	        
	        sheet.setColumnWidth(8, 4000);
	        setText(getCell(sheet, 0, 8), "수령인 전화번호");
	        
	        sheet.setColumnWidth(9, 4000);
	        setText(getCell(sheet, 0, 9), "판매금액");
	        
	        sheet.setColumnWidth(10, 4000);
	        setText(getCell(sheet, 0, 10), "취소수수료");
	        
	        sheet.setColumnWidth(11, 8000);
	        setText(getCell(sheet, 0, 11), "배송지 주소");
	        
	        sheet.setColumnWidth(12, 8000);
	        setText(getCell(sheet, 0, 12), "운송장정보");
	        
	        List<SV_RSVVO> resultList = (List<SV_RSVVO>) model.get("resultList"); 
	        
	        XSSFCell cell = getCell(sheet, 0, 0);
	        
	        for (int i = 0; i < resultList.size(); i++) {
	        	SV_RSVVO resultVO = (SV_RSVVO) resultList.get(i);
	        	
	        	// 번호
				cell = getCell(sheet, 1 + i, 0);
		        setText(cell, resultVO.getRsvNum());
		        
		        // 구매상태
		        cell = getCell(sheet, 1 + i, 1);
		        
		        String rsvStatusNm = "";
		        if(Constant.RSV_STATUS_CD_READY.equals(resultVO.getRsvStatusCd())){
		        	rsvStatusNm = "미결제";
				}else if(Constant.RSV_STATUS_CD_COM.equals(resultVO.getRsvStatusCd())){
					rsvStatusNm = "결제완료";
				}else if(Constant.RSV_STATUS_CD_CREQ.equals(resultVO.getRsvStatusCd())){
					rsvStatusNm = "취소요청";
				}else if(Constant.RSV_STATUS_CD_CREQ2.equals(resultVO.getRsvStatusCd())){
					rsvStatusNm = "환불요청";
				}else if(Constant.RSV_STATUS_CD_CCOM.equals(resultVO.getRsvStatusCd())){
					rsvStatusNm = "취소";
				}else if(Constant.RSV_STATUS_CD_ACC.equals(resultVO.getRsvStatusCd())){
					rsvStatusNm = "자동취소";
				}else if(Constant.RSV_STATUS_CD_UCOM.equals(resultVO.getRsvStatusCd())){
					rsvStatusNm = "구매확정";
				}else if(Constant.RSV_STATUS_CD_ECOM.equals(resultVO.getRsvStatusCd())){
					rsvStatusNm = "기간만료";
				}else if(Constant.RSV_STATUS_CD_DLV.equals(resultVO.getRsvStatusCd())){
					rsvStatusNm = "배송중";
				}else if(Constant.RSV_STATUS_CD_DLVE.equals(resultVO.getRsvStatusCd())){
					rsvStatusNm = "배송완료";
				}
		        
		        setText(cell, rsvStatusNm);
		        
		        // 상품명
		        cell = getCell(sheet, 1 + i, 2);
		        setText(cell, resultVO.getPrdtNm());
		        
		        // 옵션명
		        cell = getCell(sheet, 1 + i, 3);
		        setText(cell, resultVO.getDivNm() + " " + resultVO.getOptNm());
		        
		        // 구매수
		        cell = getCell(sheet, 1 + i, 4);
		        setText(cell, resultVO.getBuyNum());
		        
		        // 구매자
		        cell = getCell(sheet, 1 + i, 5);
		        setText(cell, resultVO.getRsvNm());
		        
		        // 구매자 전화번호
		        cell = getCell(sheet, 1 + i, 6);
		        setText(cell, resultVO.getRsvTelnum());
		        
		        // 수령인
		        cell = getCell(sheet, 1 + i, 7);
		        setText(cell, resultVO.getUseNm());
		        
		        // 수령인 전화번호
		        cell = getCell(sheet, 1 + i, 8);
		        setText(cell, resultVO.getUseTelnum());
		        
		        // 판매금액
		        cell = getCell(sheet, 1 + i, 9);
		        setText(cell, resultVO.getNmlAmt());
		        
		        // 취소수수료
		        cell = getCell(sheet, 1 + i, 10);
		        setText(cell, resultVO.getCmssAmt());
		        
		        // 배송지 주소
		        cell = getCell(sheet, 1 + i, 11);
		        String useAddr = "";
		        if(!EgovStringUtil.isEmpty(resultVO.getRoadNmAddr())){useAddr += resultVO.getRoadNmAddr();} 
		        if(!EgovStringUtil.isEmpty(resultVO.getDtlAddr())){useAddr += resultVO.getDtlAddr();} 
		        setText(cell, useAddr);
		        
		        // 운송장 정보
		        cell = getCell(sheet, 1 + i, 12);
		        String dlvInfo = "";
		        if(!EgovStringUtil.isEmpty(resultVO.getDlvCorpNm())){dlvInfo += resultVO.getDlvCorpNm();} 
		        if(!EgovStringUtil.isEmpty(resultVO.getDlvNum())){dlvInfo += resultVO.getDlvNum();} 
		        setText(cell, dlvInfo);
		        
	        }
		}
		
	}
	
	
}
