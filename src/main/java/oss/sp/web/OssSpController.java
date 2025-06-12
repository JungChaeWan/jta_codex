package oss.sp.web;

import common.Constant;
import egovframework.cmmn.service.SmsService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.sp.service.MasSpService;
import mas.sp.vo.SP_ADDOPTINFVO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.ad.vo.AD_WEBLISTVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_CONFHISTVO;
import oss.cmm.vo.CM_DTLIMGVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.sp.service.OssSpService;
import oss.sp.vo.OSS_PRDTINFSVO;
import oss.sp.vo.OSS_PRDTINFVO;
import web.product.service.WebAdProductService;
import web.product.service.WebSpProductService;
import web.product.vo.WEB_DTLPRDTVO;
import web.product.vo.WEB_SPPRDTVO;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class OssSpController {

	 Logger log = (Logger) LogManager.getLogger(OssSpController.class);
	 
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
    
    @Resource(name="ossSpService")
    private OssSpService ossSpService;
    
    @Resource(name="ossCmmService")
    private OssCmmService ossCmmService;
    
    @Resource(name = "webSpService")
	protected WebSpProductService webSpService;
    
    @Resource(name="webAdProductService")
	private WebAdProductService webAdService;
    
    @Resource(name="smsService")
    protected SmsService smsService;
    
    @Resource(name="ossCorpService")
    private OssCorpService ossCorpService;

    @Resource(name = "masSpService")
	private MasSpService masSpService;
    
    /**
     * 소셜상품 조회(승인을 위한)
     * @return
     */
    @RequestMapping("/oss/socialProductList.do")
    public String socialProductList(@ModelAttribute("searchVO") OSS_PRDTINFSVO oss_PRDTINFSVO,
    			@ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,
							ModelMap model){
		log.info("/oss/socialProductList.do 호출");
		
		oss_PRDTINFSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		oss_PRDTINFSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(oss_PRDTINFSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(oss_PRDTINFSVO.getPageUnit());
		paginationInfo.setPageSize(oss_PRDTINFSVO.getPageSize());

		oss_PRDTINFSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		oss_PRDTINFSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		oss_PRDTINFSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossSpService.selectOssSpPrdtInfList(oss_PRDTINFSVO);
		
		@SuppressWarnings("unchecked")
		List<OSS_PRDTINFVO> resultList = (List<OSS_PRDTINFVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	OSS_PRDTINFSVO searchVO = new OSS_PRDTINFSVO();
    	searchVO.setsExprYn(Constant.FLAG_Y);
    	searchVO.setsTradeStatus(Constant.TRADE_STATUS_APPR);
    	int exprCnt = ossSpService.getCntOssSpPrdtInfList(searchVO);

		searchVO.setsExprYn(Constant.FLAG_N);
		searchVO.setsExprEndYn(Constant.FLAG_Y);
		int exprEndYn = ossSpService.getCntOssSpPrdtInfList(searchVO);
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("exprCnt", exprCnt);
		model.addAttribute("exprEndYn", exprEndYn);
		
		List<CDVO> cdList = ossCmmService.selectCode(Constant.CATEGORY_CD);
    	model.addAttribute("spCtgrList", cdList);
    	
		return "oss/product/socialList";
	}
    
    /* 소셜상품 엑셀 */
    @RequestMapping("/oss/socialProductListExcel.do")
    public void socialProductListExcel(@ModelAttribute("searchVO") OSS_PRDTINFSVO oss_PRDTINFSVO,
    			@ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,HttpServletRequest request, HttpServletResponse response,
							ModelMap model) throws ParseException{
    	/* 엑셀 레코드 MAX COUNT 999999개 */
    	oss_PRDTINFSVO.setFirstIndex(0);
    	oss_PRDTINFSVO.setLastIndex(999999);
		
		SimpleDateFormat df_in = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat df_output = new SimpleDateFormat("yyyy-MM-dd");
		
		SimpleDateFormat df_in2 = new SimpleDateFormat("yyyyMMdd");
		
		Map<String, Object> resultMap = ossSpService.selectOssSpPrdtInfList(oss_PRDTINFSVO);
		
		@SuppressWarnings("unchecked")
		List<OSS_PRDTINFVO> resultList = (List<OSS_PRDTINFVO>) resultMap.get("resultList");

		//Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

        // *** Sheet-------------------------------------------------
        // Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("입점업체내역");

        // 컬럼 너비 설정
        sheet1.setColumnWidth( 0, 2000);		//번호
        sheet1.setColumnWidth( 1, 3000); 		//상품번호
        sheet1.setColumnWidth( 2, 3000);		//상태
        sheet1.setColumnWidth( 3, 3000);		//형태
        sheet1.setColumnWidth( 4, 6000);		//업체명
        sheet1.setColumnWidth( 5, 6000);		//상품명
        sheet1.setColumnWidth( 6, 6000);		//판매기간
        sheet1.setColumnWidth( 7, 5000);		//요청일
        sheet1.setColumnWidth( 8, 5000);		//승인일
		sheet1.setColumnWidth( 9, 5000);		//6차산업여부

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
        cell.setCellValue("상품번호");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(2);
        cell.setCellValue("상태");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(3);
        cell.setCellValue("형태");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(4);
        cell.setCellValue("업체명");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(5);
        cell.setCellValue("상품명");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(6);
        cell.setCellValue("판매기간");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(7);
        cell.setCellValue("요청일");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(8);
        cell.setCellValue("승인일");
        cell.setCellStyle(cellStyle);

		cell = row.createCell(9);
		cell.setCellValue("6차산업 여부");
		cell.setCellStyle(cellStyle);

		for (int i = 0; i < resultList.size(); i++) {
			OSS_PRDTINFVO oss_PRDTINFVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(i + 1);

			cell = row.createCell(1);
			cell.setCellValue(oss_PRDTINFVO.getPrdtNum());
			
			cell = row.createCell(2);
			cell.setCellValue(oss_PRDTINFVO.getTradeStatusNm());
			
			cell = row.createCell(3);
			if(oss_PRDTINFVO.getPrdtDiv().equals(Constant.SP_PRDT_DIV_TOUR)) {
				cell.setCellValue("여행상품");
			}else if(oss_PRDTINFVO.getPrdtDiv().equals(Constant.SP_PRDT_DIV_COUP)){
				cell.setCellValue("쿠폰상품");
			}else if(oss_PRDTINFVO.getPrdtDiv().equals(Constant.SP_PRDT_DIV_FREE)){
				cell.setCellValue("무료쿠폰");
			}else if(oss_PRDTINFVO.getPrdtDiv().equals(Constant.SP_PRDT_DIV_SHOP)){
				cell.setCellValue("쇼핑상품");
			}else{
				cell.setCellValue("");
			}
			
			cell = row.createCell(4);
			cell.setCellValue(oss_PRDTINFVO.getCorpNm());
			
			cell = row.createCell(5);
			cell.setCellValue(oss_PRDTINFVO.getPrdtNm());
			
			if(!"".equals(oss_PRDTINFVO.getSaleStartDt()) && !"".equals(oss_PRDTINFVO.getSaleEndDt())){
				cell = row.createCell(6);
				Date inDate = df_in2.parse(oss_PRDTINFVO.getSaleStartDt());
				Date inDate2 = df_in2.parse(oss_PRDTINFVO.getSaleEndDt());
				String outDate = df_output.format(inDate);
				String outDate2 = df_output.format(inDate2);
				cell.setCellValue(outDate+"~"+outDate2);
			}
			
			if(oss_PRDTINFVO.getConfRequestDttm() != null && !"".equals(oss_PRDTINFVO.getConfRequestDttm())){
				cell = row.createCell(7);
				Date inDate = df_in.parse(oss_PRDTINFVO.getConfRequestDttm());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}
			
			if(oss_PRDTINFVO.getConfDttm() != null && !"".equals(oss_PRDTINFVO.getConfDttm())){
				cell = row.createCell(8);
				Date inDate = df_in.parse(oss_PRDTINFVO.getConfDttm());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}

			cell = row.createCell(9);
			cell.setCellValue(oss_PRDTINFVO.getSixCertiYn());
		}

        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "소셜상품관리.xlsx";

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

    @RequestMapping("/oss/preview/spDetailProduct.do")
    public String detailProduct(@ModelAttribute("prdtVO") WEB_DTLPRDTVO prdtVO,
								ModelMap model) throws ParseException {

    	String prdtNum = prdtVO.getPrdtNum();
    	
    	if(prdtNum == null) {
    		log.error("prdtNum is null");
			return "redirect:/web/cmm/error.do?errCord=PRDT01";
    	}
    	
    	// 상품 정보 가져오기.
    	prdtVO.setPreviewYn(Constant.FLAG_Y);
    	WEB_DTLPRDTVO prdtInfo =  webSpService.selectByPrdt(prdtVO);
    	
    	if(prdtInfo == null ) {
    		log.error("prdt is null");
			return "redirect:/web/cmm/error.do?errCord=PRDT02";
    	}
    	
    	// 상품 이미지 가져오기.
    	CM_IMGVO imgVO = new CM_IMGVO();
    	imgVO.setLinkNum(prdtNum);

    	List<CM_IMGVO> prdtImg = ossCmmService.selectImgList(imgVO);
    	
    	// 상세 이미지 가져오기.
    	CM_DTLIMGVO dtlImgVO = new CM_DTLIMGVO();
    	dtlImgVO.setLinkNum(prdtNum);
    	dtlImgVO.setPcImgYn(Constant.FLAG_Y);

    	List<CM_DTLIMGVO> dtlImg = ossCmmService.selectDtlImgList(dtlImgVO);
    	
    	String corpId = prdtInfo.getCorpId();

    	List<WEB_SPPRDTVO> otherProductList = null;
    	List<AD_WEBLISTVO> otherAdList = null;
    	// 판매처 다른 상품보기 (쿠폰상품 일 경우 처리 안함)
    	if(Constant.SP_PRDT_DIV_TOUR.equals(prdtInfo.getPrdtDiv()) || Constant.SP_PRDT_DIV_COUP.equals(prdtInfo.getPrdtDiv())) {
    		otherProductList= webSpService.selectOtherProductList(corpId);
    	} else { // 주변숙소 보기
    		otherAdList = webAdService.selectAdPrdtListDist(prdtInfo.getLat(), prdtInfo.getLon(), 5);
    	}
    	
    	// 상품 판매종료일 전 남은 시간 가져오기.(현재시간으로)
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date fromDate = Calendar.getInstance().getTime();
		Date toDate = sdf.parse(prdtInfo.getSaleEndDt()+"2359");
		
		long difDay = OssCmmUtil.getDifDay(fromDate, toDate);
		long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) - (difDay*24 * 3600);
		
		// 상품 추가 옵션 가져오기.
		SP_ADDOPTINFVO sp_ADDOPTINFVO = new SP_ADDOPTINFVO();
		sp_ADDOPTINFVO.setPrdtNum(prdtNum);

		List<SP_ADDOPTINFVO> addOptList = masSpService.selectPrdtAddOptionList(sp_ADDOPTINFVO); 
					
		model.addAttribute("difTime", difTime);
		model.addAttribute("difDay", difDay);
		model.addAttribute("prdtInfo", prdtInfo);
		model.addAttribute("prdtImg", prdtImg);
		model.addAttribute("dtlImg", dtlImg);
		model.addAttribute("otherProductList", otherProductList);
		model.addAttribute("otherAdList", otherAdList);
		model.addAttribute("preview", Constant.FLAG_Y);
		model.addAttribute("addOptList", addOptList);
		
		if(Constant.SP_PRDT_DIV_FREE.equals(prdtInfo.getPrdtDiv())) {
			return "web/sp/detailFreeProduct";
		}
    	return "web/sp/detailProduct";
    }
    
    
    @RequestMapping("/oss/findSpPrdt.do")
    public String findSpPrdt(@ModelAttribute("searchVO") OSS_PRDTINFSVO oss_PRDTINFSVO,
                             @ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,
                             ModelMap model){
//		log.info("/oss/findSpPrdt.do 호출");
		
		oss_PRDTINFSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		oss_PRDTINFSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(oss_PRDTINFSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(oss_PRDTINFSVO.getPageUnit());
		paginationInfo.setPageSize(oss_PRDTINFSVO.getPageSize());

		oss_PRDTINFSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		oss_PRDTINFSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		oss_PRDTINFSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossSpService.selectOssSpPrdtInfList2(oss_PRDTINFSVO);
		
		@SuppressWarnings("unchecked")
		List<OSS_PRDTINFVO> resultList = (List<OSS_PRDTINFVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "oss/product/findSpPrdt";
	}
    /**
     * 기간만료 상품 리스트
     * @param oss_PRDTINFSVO
     * @param cm_CONFHISTVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/socialExprProductList.do")
    public String socialExprProductList(@ModelAttribute("searchVO") OSS_PRDTINFSVO oss_PRDTINFSVO,
    			@ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,
							ModelMap model){
		log.info("/oss/socialProductList.do 호출");
		oss_PRDTINFSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		oss_PRDTINFSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(oss_PRDTINFSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(oss_PRDTINFSVO.getPageUnit());
		paginationInfo.setPageSize(oss_PRDTINFSVO.getPageSize());

		oss_PRDTINFSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		oss_PRDTINFSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		oss_PRDTINFSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		//searchVO.setsExprYn(Constant.FLAG_Y);
		oss_PRDTINFSVO.setsTradeStatus(Constant.TRADE_STATUS_APPR);
		oss_PRDTINFSVO.setsOrderCd("saleEndDt");
		Map<String, Object> resultMap = ossSpService.selectOssSpPrdtInfList(oss_PRDTINFSVO);
		
		@SuppressWarnings("unchecked")
		List<OSS_PRDTINFVO> resultList = (List<OSS_PRDTINFVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("spListSearchVO", oss_PRDTINFSVO);
		
		return "oss/product/socialExprList";
	}

	/**
	 * 설명 : 소셜 기간만료예정상품 엑셀
	 * 파일명 :
	 * 작성일 : 2021-05-04 오후 4:28
	 * 작성자 : chaewan.jung
	 * @param :
	 * @return :
	 * @throws ParseException
	 */
	@RequestMapping("/oss/socialExprProductListExcel.do")
	public void socialExprProductListExcel(@ModelAttribute("searchVO") OSS_PRDTINFSVO oss_PRDTINFSVO,
										   @ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,HttpServletRequest request, HttpServletResponse response) throws ParseException{

		/* 엑셀 레코드 MAX COUNT 999999개 */
		oss_PRDTINFSVO.setFirstIndex(0);
		oss_PRDTINFSVO.setLastIndex(999999);

		SimpleDateFormat df_in = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat df_output = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat df_in2 = new SimpleDateFormat("yyyyMMdd");

		oss_PRDTINFSVO.setRecordCountPerPage(1);
		//oss_PRDTINFSVO.setsExprYn(Constant.FLAG_Y);
		oss_PRDTINFSVO.setsTradeStatus(Constant.TRADE_STATUS_APPR);
		oss_PRDTINFSVO.setsOrderCd("saleEndDt");

		Map<String, Object> resultMap = ossSpService.selectOssSpPrdtInfList(oss_PRDTINFSVO);

		@SuppressWarnings("unchecked")
		List<OSS_PRDTINFVO> resultList = (List<OSS_PRDTINFVO>) resultMap.get("resultList");

		//Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

		// *** Sheet-------------------------------------------------
		// Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("소셜 기간만료 예정상품");

		// 컬럼 너비 설정
		sheet1.setColumnWidth( 0, 2000);		//번호
		sheet1.setColumnWidth( 1, 3000); 		//상품번호
		sheet1.setColumnWidth( 2, 3000);		//상태
		sheet1.setColumnWidth( 3, 3000);		//형태
		sheet1.setColumnWidth( 4, 6000);		//업체명
		sheet1.setColumnWidth( 5, 6000);		//상품명
		sheet1.setColumnWidth( 6, 6000);		//판매기간
		sheet1.setColumnWidth( 7, 5000);		//요청일
		sheet1.setColumnWidth( 8, 5000);		//승인일
		sheet1.setColumnWidth( 9, 6000);		//업체 이메일

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
		cell.setCellValue("상품번호");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(2);
		cell.setCellValue("상태");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(3);
		cell.setCellValue("형태");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(4);
		cell.setCellValue("업체명");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(5);
		cell.setCellValue("상품명");
		cell.setCellStyle(cellStyle);


		cell = row.createCell(6);
		if ("Y".equals(oss_PRDTINFSVO.getsExprYn()) ) {
			cell.setCellValue("판매기간");
		}
		if ("Y".equals(oss_PRDTINFSVO.getsExprEndYn()) ) {
			cell.setCellValue("유효기간");
		}
		cell.setCellStyle(cellStyle);


		cell = row.createCell(7);
		cell.setCellValue("요청일");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(8);
		cell.setCellValue("승인일");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(9);
		cell.setCellValue("업체 담당자 이메일");
		cell.setCellStyle(cellStyle);

		for (int i = 0; i < resultList.size(); i++) {
			OSS_PRDTINFVO oss_PRDTINFVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(i + 1);

			cell = row.createCell(1);
			cell.setCellValue(oss_PRDTINFVO.getPrdtNum());

			cell = row.createCell(2);
			cell.setCellValue(oss_PRDTINFVO.getTradeStatusNm());

			cell = row.createCell(3);
			if(oss_PRDTINFVO.getPrdtDiv().equals(Constant.SP_PRDT_DIV_TOUR)) {
				cell.setCellValue("여행상품");
			}else if(oss_PRDTINFVO.getPrdtDiv().equals(Constant.SP_PRDT_DIV_COUP)){
				cell.setCellValue("쿠폰상품");
			}else if(oss_PRDTINFVO.getPrdtDiv().equals(Constant.SP_PRDT_DIV_FREE)){
				cell.setCellValue("무료쿠폰");
			}else if(oss_PRDTINFVO.getPrdtDiv().equals(Constant.SP_PRDT_DIV_SHOP)){
				cell.setCellValue("쇼핑상품");
			}else{
				cell.setCellValue("");
			}

			cell = row.createCell(4);
			cell.setCellValue(oss_PRDTINFVO.getCorpNm());

			cell = row.createCell(5);
			cell.setCellValue(oss_PRDTINFVO.getPrdtNm());

			String startDate = "";
			String endDate = "";
			cell = row.createCell(6);
			if("Y".equals(oss_PRDTINFSVO.getsExprYn())) {
				if (oss_PRDTINFVO.getSaleStartDt() != null) {
					Date inDate = df_in2.parse(oss_PRDTINFVO.getSaleStartDt());
					startDate = df_output.format(inDate);
				}
				if (oss_PRDTINFVO.getSaleEndDt() != null) {
					Date inDate2 = df_in2.parse(oss_PRDTINFVO.getSaleEndDt());
					endDate = df_output.format(inDate2);
				}
			}

			if("Y".equals(oss_PRDTINFSVO.getsExprEndYn()) ){
				if (oss_PRDTINFVO.getExprStartDt() != null) {
					Date inDate = df_in2.parse(oss_PRDTINFVO.getExprStartDt());
					startDate = df_output.format(inDate);
				}
				if (oss_PRDTINFVO.getExprEndDt() != null) {
					Date inDate2 = df_in2.parse(oss_PRDTINFVO.getExprEndDt());
					endDate = df_output.format(inDate2);
				}
			}

			cell.setCellValue(startDate+"~"+endDate);

			if(oss_PRDTINFVO.getConfRequestDttm() != null && !"".equals(oss_PRDTINFVO.getConfRequestDttm())){
				cell = row.createCell(7);
				Date inDate = df_in.parse(oss_PRDTINFVO.getConfRequestDttm());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}

			if(oss_PRDTINFVO.getConfDttm() != null && !"".equals(oss_PRDTINFVO.getConfDttm())){
				cell = row.createCell(8);
				Date inDate = df_in.parse(oss_PRDTINFVO.getConfDttm());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}

			cell = row.createCell(9);
			cell.setCellValue(oss_PRDTINFVO.getCorpAdmEmail());
		}

		// excel 파일 저장
		try {
			// 실제 저장될 파일 이름
			String realName = "소셜상품 기간만료 예정상품.xlsx";
			if ("Y".equals(oss_PRDTINFSVO.getsExprEndYn())){
				realName = "소셜상품 유효기간만료 예정상품.xlsx";
			}

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
}
