package oss.sv.web;

import common.Constant;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.cmmn.service.SmsService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.sv.service.MasSvService;
import mas.sv.vo.SV_ADDOPTINFVO;
import mas.sv.vo.SV_CORPDLVAMTVO;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssCmmUtil;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_CONFHISTVO;
import oss.cmm.vo.CM_DTLIMGVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.sp.vo.OSS_PRDTINFVO;
import oss.sv.service.OssSvService;
import oss.sv.vo.OSS_SV_PRDTINFSVO;
import oss.sv.vo.OSS_SV_PRDTINFVO;
import web.product.service.WebAdProductService;
import web.product.service.WebSvProductService;
import web.product.vo.WEB_SVPRDTVO;
import web.product.vo.WEB_SVSVO;
import web.product.vo.WEB_SV_DTLPRDTVO;

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
public class OssSvController {

	Logger log = (Logger) LogManager.getLogger(OssSvController.class);
	 
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
    
    @Resource(name="ossSvService")
    private OssSvService ossSvService;
    
    @Resource(name="ossCmmService")
    private OssCmmService ossCmmService;
    
   /* @Resource(name = "webSvService")
	protected WebSvProductService webSvService;*/
    
    @Resource(name="webAdProductService")
	private WebAdProductService webAdService;
    
    @Resource(name="smsService")
    protected SmsService smsService;
    
    @Resource(name="ossCorpService")
    private OssCorpService ossCorpService;
    
    @Resource(name = "masSvService")
	private MasSvService masSvService;
	
	@Resource(name = "webSvService")
	private WebSvProductService webSvService;

    
    /**
     * 기념품 조회(승인을 위한)
     * @param oss_SV_PRDTINFSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/svPrdtList.do")
    public String svProductList(@ModelAttribute("searchVO") OSS_SV_PRDTINFSVO oss_SV_PRDTINFSVO,
    							@ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,
								ModelMap model) {
//		log.info("/oss/svProductList.do 호출");
		oss_SV_PRDTINFSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		oss_SV_PRDTINFSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(oss_SV_PRDTINFSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(oss_SV_PRDTINFSVO.getPageUnit());
		paginationInfo.setPageSize(oss_SV_PRDTINFSVO.getPageSize());

		oss_SV_PRDTINFSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		oss_SV_PRDTINFSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		oss_SV_PRDTINFSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossSvService.selectOssSvPrdtInfList(oss_SV_PRDTINFSVO);
		
		List<OSS_SV_PRDTINFVO> resultList = (List<OSS_SV_PRDTINFVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	// 기간만료 건수
    	OSS_SV_PRDTINFSVO searchVO = new OSS_SV_PRDTINFSVO();
    	searchVO.setsExprYn(Constant.FLAG_Y);
    	searchVO.setsTradeStatus(Constant.TRADE_STATUS_APPR);

    	int exprCnt = ossSvService.getCntOssSvPrdtInfList(searchVO);
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("exprCnt", exprCnt);
		
		List<CDVO> cdList = ossCmmService.selectCode(Constant.SV_DIV);

    	model.addAttribute("ctgrList", cdList);
    	
		return "oss/product/svPrdtList";
	}
    
    @RequestMapping("/oss/preview/svDetailProduct.do")
    public String detailProduct(@ModelAttribute("prdtVO") WEB_SV_DTLPRDTVO prdtVO,
    		ModelMap model) throws ParseException {
    	String prdtNum = prdtVO.getPrdtNum();
    	
    	if(prdtNum == null) {
    		log.error("prdtNum is null");
			return "redirect:/web/cmm/error.do?errCord=PRDT01";
    	}
    	
    	// 상품 정보 가져오기.
    	prdtVO.setPreviewYn(Constant.FLAG_Y);
    	WEB_SV_DTLPRDTVO prdtInfo =  webSvService.selectByPrdt(prdtVO);
    	
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

    	// 판매처 다른 상품보기
		String corpId = prdtInfo.getCorpId();
		String prdc = prdtInfo.getPrdc();
    	List<WEB_SVPRDTVO> otherProductList= webSvService.selectOtherProductList(corpId, prdc);
    	
    	
    	// 상품 판매종료일 전 남은 시간 가져오기.(현재시간으로)
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date fromDate = Calendar.getInstance().getTime();
		Date toDate = sdf.parse(prdtInfo.getSaleEndDt()+"2359");
		
		long difDay = OssCmmUtil.getDifDay(fromDate, toDate);
		long difTime = OssCmmUtil.getDifTimeSec(fromDate, toDate) - (difDay*24 * 3600);
		
		// 상품 추가 옵션 가져오기.
		SV_ADDOPTINFVO sv_ADDOPTINFVO = new SV_ADDOPTINFVO();
		sv_ADDOPTINFVO.setPrdtNum(prdtNum);
		List<SV_ADDOPTINFVO> addOptList = masSvService.selectPrdtAddOptionList(sv_ADDOPTINFVO); 
		
		// 배송 정보 가져오기.
		SV_CORPDLVAMTVO corpDlvAmtVO = masSvService.selectCorpDlvAmt(prdtInfo.getCorpId());
		
		// 업체정보 가져 오기.
		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(prdtInfo.getCorpId());
		CORPVO corpInfo = ossCorpService.selectCorpByCorpId(corpVO);
		
		if(StringUtils.isNotEmpty(prdtInfo.getHdlPrct())) {
			prdtInfo.setHdlPrct(EgovStringUtil.checkHtmlView(prdtInfo.getHdlPrct()));
		}
		if(StringUtils.isNotEmpty(prdtInfo.getDlvGuide())) {
			prdtInfo.setDlvGuide(EgovStringUtil.checkHtmlView(prdtInfo.getDlvGuide()));
		}
		
		if(StringUtils.isNotEmpty(prdtInfo.getCancelGuide())) {
			prdtInfo.setCancelGuide(EgovStringUtil.checkHtmlView(prdtInfo.getCancelGuide()));
		}
		if(StringUtils.isNotEmpty(prdtInfo.getTkbkGuide())) {
			prdtInfo.setTkbkGuide(EgovStringUtil.checkHtmlView(prdtInfo.getTkbkGuide()));
		}
		
		model.addAttribute("difTime", difTime);
		model.addAttribute("difDay", difDay);
		model.addAttribute("prdtInfo", prdtInfo);
		model.addAttribute("prdtImg", prdtImg);
		model.addAttribute("dtlImg", dtlImg);
		model.addAttribute("otherProductList", otherProductList);
		model.addAttribute("preview", Constant.FLAG_Y);
		model.addAttribute("addOptList", addOptList);
		model.addAttribute("corpDlvAmtVO", corpDlvAmtVO);
		model.addAttribute("corpInfo", corpInfo);
		
    	return "web/sv/detailProduct";
    }
    
    
    @RequestMapping("/oss/findSvPrdt.do")
    public String findSoPrdt(@ModelAttribute("searchVO") OSS_SV_PRDTINFSVO oss_SV_PRDTINFSVO,
    			@ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,
							ModelMap model){
		log.info("/oss/findSvPrdt.do 호출");
		
		oss_SV_PRDTINFSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		oss_SV_PRDTINFSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(oss_SV_PRDTINFSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(oss_SV_PRDTINFSVO.getPageUnit());
		paginationInfo.setPageSize(oss_SV_PRDTINFSVO.getPageSize());

		oss_SV_PRDTINFSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		oss_SV_PRDTINFSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		oss_SV_PRDTINFSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> resultMap = ossSvService.selectOssSvPrdtInfList(oss_SV_PRDTINFSVO);
		
		@SuppressWarnings("unchecked")
		List<OSS_SV_PRDTINFVO> resultList = (List<OSS_SV_PRDTINFVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	// 카테고리 설정
    	WEB_SVSVO webSvSVO = new WEB_SVSVO();
    	webSvSVO.setsCtgrDiv(Constant.SV_DIV);
		List<WEB_SVPRDTVO> cntCtgrPrdtList = webSvService.selectSvPrdtCntList(webSvSVO);
		model.addAttribute("cntCtgrPrdtList", cntCtgrPrdtList);
		
		// 서브 카테고리
		Map<String, List<CDVO>> subCtgrMap = webSvService.getSvSubCategory(webSvSVO);
		model.addAttribute("subCtgrMap", subCtgrMap);
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "oss/product/findSvPrdt";
	}
    
    @RequestMapping("/oss/svPrdtListExcelDown.do")
    public ModelAndView svPrdtListExcelDown(@ModelAttribute("searchVO") OSS_SV_PRDTINFSVO oss_SV_PRDTINFSVO,
    			@ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,
							ModelMap model){
		log.info("/oss/svPrdtListExcelDown.do 호출");
		ModelAndView mav = new ModelAndView();
		
		List<OSS_SV_PRDTINFVO> resultList = ossSvService.selectOssSvPrdtInfList2(oss_SV_PRDTINFSVO);
		
		mav.addObject("resultList", resultList);
		mav.addObject("mode", "prdtList");
		mav.setViewName("ossSvPrdtExcelView");
	
		return mav;
	}
    
    @RequestMapping("/oss/svExprProductList.do")
    public String svExprProductList(@ModelAttribute("searchVO") OSS_SV_PRDTINFSVO oss_SV_PRDTINFSVO,
    			@ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,
							ModelMap model){
		log.info("/oss/svProductList.do 호출");
		OSS_SV_PRDTINFSVO searchVO = new OSS_SV_PRDTINFSVO();
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(oss_SV_PRDTINFSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(oss_SV_PRDTINFSVO.getPageUnit());
		paginationInfo.setPageSize(oss_SV_PRDTINFSVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setsExprYn(Constant.FLAG_Y);
		searchVO.setsTradeStatus(Constant.TRADE_STATUS_APPR);
		searchVO.setsOrderCd("saleEndDt");
		Map<String, Object> resultMap = ossSvService.selectOssSvPrdtInfList(searchVO);
		
		@SuppressWarnings("unchecked")
		List<OSS_PRDTINFVO> resultList = (List<OSS_PRDTINFVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("svListSearchVO", oss_SV_PRDTINFSVO);
		
		return "oss/product/svExprList";
	}

	@RequestMapping("/oss/svExprListExcel.do")
	public void svExprListExcel(HttpServletRequest request, HttpServletResponse response) {

		OSS_SV_PRDTINFSVO searchVO = new OSS_SV_PRDTINFSVO();

		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(999999);
		searchVO.setsExprYn(Constant.FLAG_Y);
		searchVO.setsTradeStatus(Constant.TRADE_STATUS_APPR);
		searchVO.setsOrderCd("saleEndDt");

		Map<String, Object> resultMap = ossSvService.selectOssSvPrdtInfList(searchVO);

		@SuppressWarnings("unchecked")
		List<OSS_SV_PRDTINFVO> resultList = (List<OSS_SV_PRDTINFVO>) resultMap.get("resultList");

		Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

		// *** Sheet-------------------------------------------------
		// Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("특산_기념품 기간만료 예정상품");

		// 컬럼 너비 설정
		sheet1.setColumnWidth( 0, 2000);		//번호
		sheet1.setColumnWidth( 1, 3000); 		//상품번호
		sheet1.setColumnWidth( 2, 3000);		//형태
		sheet1.setColumnWidth( 3, 6000);		//업체명
		sheet1.setColumnWidth( 4, 6000);		//상품명
		sheet1.setColumnWidth( 5, 6000);		//판매기간
		sheet1.setColumnWidth( 6, 5000);		//요청일
		sheet1.setColumnWidth( 7, 5000);		//승인일
		sheet1.setColumnWidth( 8, 6000);		//업체 이메일

		CellStyle cellStyle = xlsxWb.createCellStyle();
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
		cell.setCellValue("업체명");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(4);
		cell.setCellValue("상품명");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(5);
		cell.setCellValue("판매기간");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(6);
		cell.setCellValue("요청일");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(7);
		cell.setCellValue("승인일");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(8);
		cell.setCellValue("업체 담당자 이메일");
		cell.setCellStyle(cellStyle);

		for (int i = 0; i < resultList.size(); i++) {
			OSS_SV_PRDTINFVO resultVO = (OSS_SV_PRDTINFVO) resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(i + 1);

			cell = row.createCell(1);
			cell.setCellValue(resultVO.getPrdtNum());

			cell = row.createCell(2);
			cell.setCellValue(resultVO.getTradeStatusNm());

			cell = row.createCell(3);
			cell.setCellValue(resultVO.getCorpNm());

			cell = row.createCell(4);
			cell.setCellValue(resultVO.getPrdtNm());

			cell = row.createCell(5);
			cell.setCellValue(resultVO.getSaleStartDt() + " ~ " + resultVO.getSaleEndDt());

			cell = row.createCell(6);
			cell.setCellValue(resultVO.getConfRequestDttm());

			cell = row.createCell(7);
			cell.setCellValue(resultVO.getConfDttm());

			cell = row.createCell(8);
			cell.setCellValue(resultVO.getCorpAdmEmail());
		}

		// excel 파일 저장
		try {
			// 실제 저장될 파일 이름
			String realName = "특산_기념품 기간만료 예정상품.xlsx";

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
