package oss.corp.web;


import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.cmmn.service.SmsService;
import egovframework.cmmn.vo.MMSVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.adj.web.OssAdjController;
import oss.bis.vo.BISSVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.service.OssMailService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpPnsReqService;
import oss.corp.service.OssCorpService;
import oss.corp.vo.*;
import oss.point.service.OssPointService;
import oss.point.vo.POINT_CORPVO;
import oss.point.vo.POINT_CPVO;
import oss.user.vo.USERVO;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 최영철
 * @since  2015. 9. 16.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@Controller
public class OssCorpController {

    @Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

    @Resource(name="ossCorpService")
    private OssCorpService ossCorpService;

    @Resource(name="ossCmmService")
    private OssCmmService ossCmmService;

    @Resource(name="ossCorpPnsReqService")
    private OssCorpPnsReqService ossCorpPnsReqService;

    @Resource(name = "ossFileUtilService")
    private OssFileUtilService ossFileUtilService;

    @Resource(name = "ossMailService")
	protected OssMailService ossMailService;

    @Resource(name="smsService")
    protected SmsService smsService;

    @Resource(name="ossAdjController")
	protected OssAdjController ossAdjController;

	@Autowired
	private OssPointService ossPointService;

    Logger log = LogManager.getLogger(this.getClass());

	/**
	 * 업체 리스트 조회
	 * 파일명 : corpList
	 * 작성일 : 2015. 9. 21. 오전 9:29:18
	 * 작성자 : 최영철
	 * @param corpSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/corpList.do")
	public String corpList(@ModelAttribute("searchVO") CORPSVO corpSVO,
							ModelMap model){
		log.info("/oss/corpList.do 호출");

		corpSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		corpSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(corpSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(corpSVO.getPageUnit());
		paginationInfo.setPageSize(corpSVO.getPageSize());

		corpSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		corpSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		corpSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossCorpService.selectCorpList(corpSVO);

		@SuppressWarnings("unchecked")
		List<CORPVO> resultList = (List<CORPVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

    	List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
    	List<CDVO> tsCdList = ossCmmService.selectCode(Constant.TRADE_STATUS);

    	// B2C 수수료
		List<CMSSVO> cmssList = ossCmmService.selectCmssList();
		model.addAttribute("cmssList", cmssList);
		// B2B 수수료
		List<CMSSVO> b2bCmssList = ossCmmService.selectB2bCmssList();
		model.addAttribute("b2bCmssList", b2bCmssList);

    	model.addAttribute("corpCdList", corpCdList);
    	model.addAttribute("tsCdList", tsCdList);
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "oss/corp/corpList";
	}



	@RequestMapping("/oss/corpSaveExcel.do")
    public void corpSaveExcel(@ModelAttribute("searchVO") CORPSVO corpSVO, HttpServletRequest request, HttpServletResponse response){
    	log.info("/oss/corpSaveExcel.ajax 호출");

    	List<CORPVO> resultList = ossCorpService.selectCorpListExcel(corpSVO);

    	List<CDVO> tsCdList = ossCmmService.selectCode(Constant.TRADE_STATUS);

		//Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

        // *** Sheet-------------------------------------------------
        // Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("입점업체내역");

        // 컬럼 너비 설정
        sheet1.setColumnWidth( 0, 3000);		//업체아이디
        sheet1.setColumnWidth( 1, 6000); 		//업체명
        sheet1.setColumnWidth( 2, 3000);		//업체분류
        sheet1.setColumnWidth( 3, 2000);		//거래상태
        sheet1.setColumnWidth( 4, 4000);		//사업자등록번호
        sheet1.setColumnWidth( 5, 4000);		//대표전화
        sheet1.setColumnWidth( 6, 4000);		//예약전화
		sheet1.setColumnWidth( 7, 4000);		//팩스번호
        sheet1.setColumnWidth( 8, 8000);		//이메일
        sheet1.setColumnWidth( 9, 8000);		//홈페이지
        sheet1.setColumnWidth( 10, 2000);		//대표자명
        sheet1.setColumnWidth(11, 4000);		//하이제주연개
        sheet1.setColumnWidth(12, 2000);		//회원사여부
        sheet1.setColumnWidth(13, 5000);		//분과명
        sheet1.setColumnWidth(14, 10000);		//주소
        sheet1.setColumnWidth(15, 10000);		//상세주소
        sheet1.setColumnWidth(16, 6000);		//등록 일시
        sheet1.setColumnWidth(17, 3000);		//은행명
        sheet1.setColumnWidth(18, 5000);		//계좌번호
        sheet1.setColumnWidth(19, 6000);		//예금주
        sheet1.setColumnWidth(20, 2000);		//관리자명
        sheet1.setColumnWidth(21, 4000);		//관리자휴대폰
        sheet1.setColumnWidth(22, 4000);		//관리자전화
        sheet1.setColumnWidth(23, 8000);		//관리자이메일
        sheet1.setColumnWidth(24, 2000);		//비짓제주매핑여부
		sheet1.setColumnWidth(25, 2000);		//탐나는전 가맹점여부
		sheet1.setColumnWidth(26, 2000);		//실시간업체

        // ----------------------------------------------------------

		XSSFCellStyle cellStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;

        // 첫 번째 줄
        row = sheet1.createRow(0);

        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("업체아이디");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(1);
        cell.setCellValue("업체명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(2);
        cell.setCellValue("업체분류");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(3);
        cell.setCellValue("거래상태");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(4);
        cell.setCellValue("사업자등록번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(5);
        cell.setCellValue("대표전화");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(6);
        cell.setCellValue("예약전화");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(7);
        cell.setCellValue("팩스번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(8);
        cell.setCellValue("이메일");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(9);
        cell.setCellValue("홈페이지");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(10);
        cell.setCellValue("대표자명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(11);
        cell.setCellValue("하이제주연개번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(12);
        cell.setCellValue("회원사여부");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(13);
        cell.setCellValue("분과명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(14);
        cell.setCellValue("주소");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(15);
        cell.setCellValue("상세주소");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(16);
        cell.setCellValue("등록 일시");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(17);
        cell.setCellValue("은행명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(18);
        cell.setCellValue("계좌번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(19);
        cell.setCellValue("예금주");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(20);
        cell.setCellValue("관리자명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(21);
        cell.setCellValue("관리자휴대폰");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(22);
        cell.setCellValue("관리자전화");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(23);
        cell.setCellValue("관리자이메일");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(24);
        cell.setCellValue("비짓제주매핑여부");
        cell.setCellStyle(cellStyle);

		cell = row.createCell(25);
		cell.setCellValue("탐나는전 가맹점여부");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(26);
		cell.setCellValue("실시간업체");
		cell.setCellStyle(cellStyle);
        //---------------------------------

		for (int i = 0; i < resultList.size(); i++) {
			CORPVO corpVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(corpVO.getCorpId());

			cell = row.createCell(1);
			cell.setCellValue(corpVO.getCorpNm());

			cell = row.createCell(2);
			String corpCd = corpVO.getCorpCdNm();
			/*if (Constant.SOCIAL.equals(corpVO.getCorpCd())) {
				if (Constant.SOCIAL_FOOD.equals(corpVO.getCorpSubCd()))
					corpCd += " - 레져/음식/뷰티";
				else if (Constant.SOCIAL_TICK.equals(corpVO.getCorpSubCd()))
					corpCd += " - 관광지입장권";
				else if (Constant.SOCIAL_TOUR.equals(corpVO.getCorpSubCd()))
					corpCd += " - 여행사";
			}*/
			cell.setCellValue(corpCd);

			cell = row.createCell(3);
			for (CDVO cdVo : tsCdList) {
				if(cdVo.getCdNum().equals( corpVO.getTradeStatusCd() )){
					cell.setCellValue( cdVo.getCdNm() );
					break;
				}
			}

			cell = row.createCell(4);
			cell.setCellValue(corpVO.getCoRegNum());

			cell = row.createCell(5);
			cell.setCellValue(corpVO.getCeoTelNum());

			cell = row.createCell(6);
			cell.setCellValue(corpVO.getRsvTelNum());

			cell = row.createCell(7);
			cell.setCellValue(corpVO.getFaxNum());

			cell = row.createCell(8);
			cell.setCellValue(corpVO.getCorpEmail());

			cell = row.createCell(9);
			cell.setCellValue(corpVO.getHmpgAddr());

			cell = row.createCell(10);
			cell.setCellValue(corpVO.getCeoNm());

			cell = row.createCell(11);
			if(corpVO.getHijejuMappingNum() != null){
				cell.setCellValue(corpVO.getHijejuMappingNum());
			}else{
				cell.setCellValue("연계안함");
			}

			if( "Y".equals(corpVO.getAsctMemYn()) ){
				cell = row.createCell(12);
				cell.setCellValue("회원사");

				cell = row.createCell(13);
				cell.setCellValue(corpVO.getBranchNm());

			}else{
				cell = row.createCell(12);
				cell.setCellValue("비회원사");

				cell = row.createCell(13);
				cell.setCellValue("-");
			}

			cell = row.createCell(14);
			cell.setCellValue(corpVO.getRoadNmAddr());
			cell = row.createCell(15);
			cell.setCellValue(corpVO.getDtlAddr());

			cell = row.createCell(16);
			cell.setCellValue(corpVO.getFrstRegDttm());

			cell = row.createCell(17);
			cell.setCellValue(corpVO.getBankNm());

			cell = row.createCell(18);
			cell.setCellValue(corpVO.getAccNum());

			cell = row.createCell(19);
			cell.setCellValue(corpVO.getDepositor());

			cell = row.createCell(20);
			cell.setCellValue(corpVO.getAdmNm());

			cell = row.createCell(21);
			cell.setCellValue(corpVO.getAdmMobile());

			cell = row.createCell(22);
			cell.setCellValue(corpVO.getAdmTelnum());

			cell = row.createCell(23);
			cell.setCellValue(corpVO.getAdmEmail());

			cell = row.createCell(24);
			cell.setCellValue(corpVO.getVisitMappingYn());

			cell = row.createCell(25);
			cell.setCellValue(corpVO.getTamnacardMngYn());

			cell = row.createCell(26);
			cell.setCellValue(corpVO.getCorpLinkYn());

		}

        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "입점업체.xlsx";

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

	/**
	 * 입점신청관리
	 * 파일명 : corpPnsReqList
	 * 작성일 : 2015. 11. 11. 오후 6:38:59
	 * 작성자 : 신우섭
	 * @param corpPnsReqSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/corpPnsReqList.do")
	public String corpAppList(@ModelAttribute("searchVO") CORP_PNSREQSVO corpPnsReqSVO,
							  ModelMap model) {
		log.info("/oss/corpPnsReqList.do 호출");

		corpPnsReqSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		corpPnsReqSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(corpPnsReqSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(corpPnsReqSVO.getPageUnit());
		paginationInfo.setPageSize(corpPnsReqSVO.getPageSize());

		corpPnsReqSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		corpPnsReqSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		corpPnsReqSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossCorpPnsReqService.selectCorpPnsReqList(corpPnsReqSVO);

		List<CORP_PNSREQVO> resultList = (List<CORP_PNSREQVO>) resultMap.get("resultList");

		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("corpCdList", corpCdList);

		return "oss/corp/corpPnsReqList";
	}

	@RequestMapping("/oss/corpPnsReqExcelDown.do")
	public void corpPnsReqExcelDown(@ModelAttribute("searchVO") CORP_PNSREQSVO corpPnsReqSVO,
									  HttpServletRequest request,
									  HttpServletResponse response) {
		log.info("/oss/corpPnsReqExcelDown.do call");

		corpPnsReqSVO.setFirstIndex(-1);
		Map<String, Object> resultMap = ossCorpPnsReqService.selectCorpPnsReqList(corpPnsReqSVO);

		List<CORP_PNSREQVO> resultList = (List<CORP_PNSREQVO>) resultMap.get("resultList");

		// Workbook 생성
//        Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

		// *** Sheet-------------------------------------------------
		// Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("입점신청내역");

		// 컬럼 너비 설정
		int j = 0;
		sheet1.setColumnWidth(j++, 50*256);
		sheet1.setColumnWidth(j++, 12*256);
		sheet1.setColumnWidth(j++, 30*256);
		sheet1.setColumnWidth(j++, 30*256);
		sheet1.setColumnWidth(j++, 16*256);
		sheet1.setColumnWidth(j++, 16*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 14*256);
		// ----------------------------------------------------------

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
		j = 0;
		cell = row.createCell(j++);
		cell.setCellValue("업체명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("상태");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("대표자명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("담당자명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("전화번호");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("휴대전화");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("요청일");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("처리일");
		cell.setCellStyle(headerStyle);
		//---------------------------------

		for(int i = 0; i < resultList.size(); i++) {
			CORP_PNSREQVO corpPnsReqVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			j = 0;
			cell = row.createCell(j++);
			cell.setCellValue(corpPnsReqVO.getCorpNm());

			String statusNm = "";
			String statusCd = corpPnsReqVO.getStatusCd();
			if(Constant.CORP_STATUS_CD_01.equals(statusCd)) {
				statusNm = "신청중";
			} else if(Constant.CORP_STATUS_CD_02.equals(statusCd)) {
				statusNm = "승인검토중";
			} else if(Constant.CORP_STATUS_CD_03.equals(statusCd)) {
				statusNm = "승인완료";
			} else if(Constant.CORP_STATUS_CD_04.equals(statusCd)) {
				statusNm = "입점불가";
			} else if(Constant.CORP_STATUS_CD_05.equals(statusCd)) {
				statusNm = "입점취소";
			}
			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(statusNm);

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(corpPnsReqVO.getCeoNm());

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(corpPnsReqVO.getAdmNm());

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(corpPnsReqVO.getAdmTelnum());

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(corpPnsReqVO.getAdmMobile());

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(corpPnsReqVO.getFrstRegDttm().substring(0, 10));

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(corpPnsReqVO.getLastModDttm().substring(0, 10));
		}

		// excel 파일 저장
		try {
			String fileName = "입점신청내역.xlsx";

			response.setHeader("Content-Disposition", "attachment; filename=" + ossAdjController.fileNameByBrowser(request, fileName));

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

	/**
	 * 입점신청 상세보기
	 * @param corpPnsReqVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/detailCorpPnsReq.do")
	public String viewCorpPnsReq(@ModelAttribute("searchVO") CORP_PNSREQVO corpPnsReqVO,
								 @ModelAttribute("CORP_PNSREQVO") CORP_PNSREQVO corp_PnsReqVO,
								 @ModelAttribute("CORPVO") CORPVO corpVO,
								 ModelMap model) {
		log.info("/oss/detailCorpPnsReq.do 호출");

		CORP_PNSREQVO resultVO = ossCorpPnsReqService.selectCorpPnsReq(corpPnsReqVO);

		// 입점신청서류
		CORP_PNSREQFILEVO cprfVO = new CORP_PNSREQFILEVO();
		if(resultVO.getConfCorpId() == null) {
			cprfVO.setRequestNum(resultVO.getRequestNum());
		} else {
			cprfVO.setRequestNum(resultVO.getConfCorpId());
		}
		List<CORP_PNSREQFILEVO> cprfList = ossCorpPnsReqService.selectCorpPnsReqFileList(cprfVO);

		Map<String, CORP_PNSREQFILEVO> cprfMap = new HashMap<String, CORP_PNSREQFILEVO>();
		for(CORP_PNSREQFILEVO file : cprfList) {
            cprfMap.put(file.getFileNum(), file);
        }

		// 업체구분 수정 코드 목록
		List<CDVO> corpModCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);

		// B2C 수수료
		List<CMSSVO> cmssList = ossCmmService.selectCmssList();

		// B2B 수수료
		List<CMSSVO> b2bCmssList = ossCmmService.selectB2bCmssList();

		model.addAttribute("result", resultVO);
		model.addAttribute("cprfMap", cprfMap);
		model.addAttribute("corpModCd", corpModCdList);
		model.addAttribute("cmssList", cmssList);
		model.addAttribute("b2bCmssList", b2bCmssList);

		return "oss/corp/detailCorpPnsReq";
	}

	// 입점신청 수정 화면
	@RequestMapping("/oss/viewUpdateCorpPnsRequest.do")
	public String viewUpdateCorpPnsRequest(@ModelAttribute("searchVO") CORP_PNSREQVO corpPnsReqVO,
										   @ModelAttribute("CORP_PNSREQVO") CORP_PNSREQVO corp_PnsReqVO,
										   ModelMap model) {
		log.info("/oss/viewUpdateCorpPnsRequest.do 호출");

		CORP_PNSREQVO resultVO = ossCorpPnsReqService.selectCorpPnsReq(corpPnsReqVO);

		// 입점신청서류
		CORP_PNSREQFILEVO cprfVO = new CORP_PNSREQFILEVO();
		cprfVO.setRequestNum(resultVO.getRequestNum());

		List<CORP_PNSREQFILEVO> cprfList = ossCorpPnsReqService.selectCorpPnsReqFileList(cprfVO);

		Map<String, CORP_PNSREQFILEVO> cprfMap = new HashMap<String, CORP_PNSREQFILEVO>();
		for(CORP_PNSREQFILEVO file : cprfList) {
			cprfMap.put(file.getFileNum(), file);
		}

		model.addAttribute("result", resultVO);
		model.addAttribute("cprfMap", cprfMap);

		return "oss/corp/updateCorpPnsReq";
	}

	// 입점신청 수정
	@RequestMapping("/oss/updateCorpPnsRequest.do")
	public String updateCorpPnsRequest(@ModelAttribute("CORP_PNSREQVO") CORP_PNSREQVO corpPnsReqVO,
									   MultipartHttpServletRequest multiRequest) throws Exception {
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		corpPnsReqVO.setLastModId(corpInfo.getUserId());
		corpPnsReqVO.setLastModIp(corpInfo.getLastLoginIp());

		ossCorpPnsReqService.updateCorpPnsReq(corpPnsReqVO, multiRequest);

		return "redirect:/oss/detailCorpPnsReq.do?requestNum=" + corpPnsReqVO.getRequestNum();
	}

	/**
	 * 입점업체 승인관리
	 * @param corpPnsReqVO
	 * @return
	 */
	@RequestMapping("/oss/apprCorpPnsReq.do")
	public String apprCorpPnsReq(@ModelAttribute("CORP_PNSREQVO") CORP_PNSREQVO corpPnsReqVO) {

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		corpPnsReqVO.setLastModId(corpInfo.getUserId());
		corpPnsReqVO.setLastModIp(corpInfo.getLastLoginIp());

		ossCorpPnsReqService.apprCorpPnsReq(corpPnsReqVO);

		return "redirect:/oss/detailCorpPnsReq.do?requestNum=" + corpPnsReqVO.getRequestNum();
	}

	// 입점신청 서류 삭제
	@RequestMapping("/oss/deleteCorpPnsRequestFile.ajax")
	public ModelAndView deleteCorpPnsRequestFile(@RequestParam("docId") String docId,
												 @RequestParam("fileNum") String fileNum) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			ossFileUtilService.deleteCorpPnsRequestFile(docId, fileNum);
			resultMap.put("result", "success");
		} catch (Exception e) {
			log.error(e.toString());
			resultMap.put("result", "fail");
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	/**
	 * 입점 업체 신청 계정 발급&하이제주연동
	 * @param corpvo
	 * @param request
	 * @return
	 */
	@RequestMapping("/oss/saveCorpAccount.do")
	public String saveCorpAccount(@ModelAttribute("CORPVO") CORPVO corpvo,
                                  HttpServletRequest request) {

        String corpId = ossCorpPnsReqService.saveCorpAccount(corpvo);

        CORPVO corpVO = new CORPVO();
        corpVO.setCorpId(corpId);

        CORPVO corpRes = ossCorpService.selectByCorp(corpVO);

        //메일보내기
        ossMailService.sendCorpAppro(corpRes, request);

        //문자보내기
        String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
        
		String strSubject = "[탐나오] 입점승인이 완료되었습니다.";
		String strMsg = "";
        strMsg += "귀사의 탐나오 입점을 환영합니다.\n" +
			"\n" +
			"입점업체 관리자 페이지 : http://www.tamnao.com/mas\n" +
			"업체 아이디 : "+corpRes.getCorpId()+"\n" +
			"비밀번호 : 탐나오 홈페이지 가입 시 설정한 비밀번호와 동일\n" +
			"* 비밀번호 잊으셨을 경우\n" +
			"탐나오 홈페이지(https://www.tamnao.com/)에서 비밀번호 찾기\n" +
			"\n" +
			"업체 정보와 상품 기본 정보를 등록하여 주시고,\n" +
			"등록에 어려움이 있으시거나, 상세페이지 제작 지원이 필요하시면 탐나오에 연락 주시기 바랍니다. (064-741-8762)\n" +
			"\n" +
			"tamnao@tamnao.com\n" +
			"\n" +
			"제주도 내 사업체의 발전을 위해 함께 하겠습니다\n" +
			"감사합니다.";
        MMSVO mmsVO = new MMSVO();
		mmsVO.setSubject(strSubject);
		mmsVO.setMsg(strMsg);
		mmsVO.setStatus("0");
		mmsVO.setFileCnt("0");
		mmsVO.setType("0");
		/*담당자 MMS 발송 - 테스트빌드시 결제 메시지 김재성*/
		if("test".equals(CST_PLATFORM.trim())) {
			mmsVO.setPhone(Constant.TAMNAO_TESTER1);
		}else{
			mmsVO.setPhone(corpRes.getAdmMobile());
		}	        
        mmsVO.setCallback(EgovProperties.getProperty("CS.PHONE"));
        try {
            smsService.sendMMS(mmsVO);
        } catch (Exception e) {
            log.error(e.toString());
        }

		/* 담당자2 MMS 발송 */
		if(StringUtils.isNotEmpty(corpRes.getAdmMobile2())) {
			/*테스트빌드시*/
			if("test".equals(CST_PLATFORM.trim())) {
				mmsVO.setPhone(Constant.TAMNAO_TESTER2);
			}else{
				mmsVO.setPhone(corpRes.getAdmMobile2());
			}
			try {
				smsService.sendMMS(mmsVO);
			} catch (Exception e) {
				log.error(e.toString());
			}
		}

		/* 담당자3 MMS 발송 */
		if(StringUtils.isNotEmpty(corpRes.getAdmMobile3())) {
			/*테스트빌드시*/
			if("test".equals(CST_PLATFORM.trim())) {
				mmsVO.setPhone(Constant.TAMNAO_TESTER3);
			}else{
				mmsVO.setPhone(corpRes.getAdmMobile3());
			}
			try {
				smsService.sendMMS(mmsVO);
			} catch (Exception e) {
				log.error(e.toString());
			}
		}

		return  "redirect:/oss/detailCorpPnsReq.do?requestNum="+corpvo.getRequestNum();
	}

	/**
	 * 업체 정보 등록 VIEW
	 * 파일명 : viewInsCorp
	 * 작성일 : 2015. 9. 21. 오전 9:29:31
	 * 작성자 : 최영철
	 * @return
	 */
	@RequestMapping("/oss/viewInsertCorp.do")
	public String viewInsertCorp(	@ModelAttribute("CORPVO") CORPVO corpVO,
									@ModelAttribute("searchVO") CORPSVO corpSVO,
									ModelMap model){

		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
		model.addAttribute("corpCd", corpCdList);
		
		List<CDVO> corpModCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
		model.addAttribute("corpModCd", corpModCdList);
		
		// B2C 수수료
		List<CMSSVO> cmssList = ossCmmService.selectCmssList();
		model.addAttribute("cmssList", cmssList);
		// B2B 수수료
		List<CMSSVO> b2bCmssList = ossCmmService.selectB2bCmssList();
		model.addAttribute("b2bCmssList", b2bCmssList);

		
		model.addAttribute("corpInfo", corpVO);
		return "oss/corp/insertCorp";
	}

	/**
	 * 업체 정보 등록
	 * 파일명 : insertCorp
	 * 작성일 : 2015. 9. 21. 오전 9:29:47
	 * 작성자 : 최영철
	 * @param corpVO
	 * @return
	 */
	@RequestMapping("/oss/insertCorp.do")
	public String insertCorp(@ModelAttribute("CORPVO") CORPVO corpVO,
							 @ModelAttribute("searchVO") CORPSVO corpSVO,
							 MultipartHttpServletRequest multiRequest) throws Exception {
		log.info("/oss/insertCorp.do 호출");

		// Constant.TRADE_STATUS_APPR(승인 : TS03)
		corpVO.setTradeStatusCd(Constant.TRADE_STATUS_APPR);
		// 업체 기본정보 등록 처리
		ossCorpService.insertCorp(corpVO, multiRequest);

		return "redirect:/oss/corpList.do";
	}

	/**
	 * 업체 기본정보 - 상세정보
	 * 파일명 : dtlCorp
	 * 작성일 : 2015. 9. 21. 오전 9:29:56
	 * 작성자 : 최영철
	 * @param corpSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/detailCorp.do")
	public String dtlCorp(@ModelAttribute("CORPVO") CORPVO corpVO,
						  @ModelAttribute("searchVO") CORPSVO corpSVO,
						  ModelMap model) {
		// 업체 계약상태 코드 목록
		List<CDVO> tradeStateCdList = ossCmmService.selectCode(Constant.TRADE_STATUS);

		// 업체구분 코드 목록
		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);

		// 업체구분 수정 코드 목록
		List<CDVO> corpModCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);

		// B2C 수수료
		List<CMSSVO> cmssList = ossCmmService.selectCmssList();

		// B2B 수수료
		List<CMSSVO> b2bCmssList = ossCmmService.selectB2bCmssList();

		// 업체 기본정보 조회
		CORPVO resultVO = ossCorpService.selectByCorp(corpVO);

		// 입점신청서류
		CORP_PNSREQFILEVO cprfVO = new CORP_PNSREQFILEVO();
		cprfVO.setRequestNum(resultVO.getCorpId());

		List<CORP_PNSREQFILEVO> cprfList = ossCorpPnsReqService.selectCorpPnsReqFileList(cprfVO);

		Map<String, CORP_PNSREQFILEVO> cprfMap = new HashMap<String, CORP_PNSREQFILEVO>();
		for(CORP_PNSREQFILEVO file : cprfList) {
			cprfMap.put(file.getFileNum(), file);
		}

		model.addAttribute("tradeStateCd", tradeStateCdList);
		model.addAttribute("corpCd", corpCdList);
		model.addAttribute("corpModCd", corpModCdList);
		model.addAttribute("cmssList", cmssList);
		model.addAttribute("b2bCmssList", b2bCmssList);
		model.addAttribute("corpInfo", resultVO);
		model.addAttribute("cprfMap", cprfMap);

		return "oss/corp/detailCorp";
	}

	/**
	 * 업체 추가 정보 보기
	 * 파일명 : corpDtlInfo
	 * 작성일 : 2015. 9. 21. 오전 9:30:48
	 * 작성자 : 최영철
	 * @param corpSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/corpDtlInfo.do")
	public String corpDtlInfo(@ModelAttribute("searchVO") CORPSVO corpSVO,
							  ModelMap model) {

		return "oss/corp/corpDtlInfo";
	}

	/**
	 * 업체 수정화면 VIEW
	 * 파일명 : viewUdtCorp
	 * 작성일 : 2015. 9. 21. 오전 9:31:26
	 * 작성자 : 최영철
	 * @param corpSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/viewUpdateCorp.do")
	public String viewUdtCorp(@ModelAttribute("CORPVO") CORPVO corpVO,
							  @ModelAttribute("searchVO") CORPSVO corpSVO,
							  ModelMap model) {
		// 업체 기본정보 조회
		CORPVO resultVO = ossCorpService.selectByCorp(corpVO);

		// 입점신청서류
		CORP_PNSREQFILEVO cprfVO = new CORP_PNSREQFILEVO();
		cprfVO.setRequestNum(resultVO.getCorpId());

		List<CORP_PNSREQFILEVO> cprfList = ossCorpPnsReqService.selectCorpPnsReqFileList(cprfVO);

		Map<String, CORP_PNSREQFILEVO> cprfMap = new HashMap<String, CORP_PNSREQFILEVO>();
		for(CORP_PNSREQFILEVO file : cprfList) {
			cprfMap.put(file.getFileNum(), file);
		}

		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);

		// 업체구분 수정 코드 목록
		List<CDVO> corpModCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);

		// B2C 수수료
		List<CMSSVO> cmssList = ossCmmService.selectCmssList();
		// B2B 수수료
		List<CMSSVO> b2bCmssList = ossCmmService.selectB2bCmssList();

		model.addAttribute("corpInfo", resultVO);
		model.addAttribute("cprfMap", cprfMap);
		model.addAttribute("corpCd", corpCdList);
		model.addAttribute("corpModCd", corpModCdList);
		model.addAttribute("cmssList", cmssList);
		model.addAttribute("b2bCmssList", b2bCmssList);

		return "oss/corp/updateCorp";
	}

	/**
	 * 업체 기본정보 수정
	 * 파일명 : updateCorp
	 * 작성일 : 2015. 9. 21. 오후 6:42:26
	 * 작성자 : 최영철
	 * @param corpVO
	 * @param corpSVO
	 * @return
	 */
	@RequestMapping("/oss/updateCorp.do")
	public String updateCorp(@ModelAttribute("CORPVO") CORPVO corpVO,
							 @ModelAttribute("searchVO") CORPSVO corpSVO,
							 MultipartHttpServletRequest multiRequest) throws Exception {

		// 업체 기본정보 수정처리
		ossCorpService.updateCorp(corpVO, multiRequest);

		return "redirect:/oss/detailCorp.do?corpId=" + corpVO.getCorpId();
	}

	/*@RequestMapping("/oss/hijejuNonMapping.ajax")
	public ModelAndView hijejuNonMapping(@ModelAttribute("CORPVO") CORPVO corpVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 업체 기본정보 조회
		corpVO = ossCorpService.selectByCorp(corpVO);

		// 업체 하이제주 매핑 해제
		ossCorpService.updateNonMapping(corpVO);

		resultMap.put("success", "Y");

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}*/
	
	@RequestMapping("/oss/visitjejuNonMapping.ajax")
	public ModelAndView visitjejuNonMapping(@ModelAttribute("CORPVO") CORPVO corpVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 업체 Visit제주 매핑 해제
		ossCorpService.updateNonVisitMapping(corpVO);

		resultMap.put("success", "Y");

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/**
	 * 업체 기본정보 삭제
	 * 파일명 : deleteCorp
	 * 작성일 : 2015. 9. 21. 오후 6:42:37
	 * 작성자 : 최영철
	 * @param corpVO
	 * @param corpSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/deleteCorp.do")
	public String deleteCorp(	@ModelAttribute("CORPVO") CORPVO corpVO,
								@ModelAttribute("searchVO") CORPSVO corpSVO,
								ModelMap model){
		return "redirect:/oss/corpList.do";
	}

	/**
	 * 업체 추가정보가 있는 확인
	 * 파일명 : corpDtlInfoChk
	 * 작성일 : 2015. 9. 21. 오후 6:42:47
	 * 작성자 : 최영철
	 * @param corpVO
	 * @throws Exception
	 */
	@RequestMapping("/oss/corpDtlInfoChk.do")
	public ModelAndView corpDtlInfoChk(	@ModelAttribute("searchVO") CORPVO corpVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		// 업체 추가정보가 있는 확인(Y : 존재, N : 존재하지 않음)
		String chk = ossCmmService.corpDtlInfoChk(corpVO);
		resultMap.put("resultChk", chk);

		return mav;
	}

	/**
	 * 업체 기본정보 - 상세정보
	 * 파일명 : dtlCorp
	 * 작성일 : 2015. 9. 21. 오전 9:29:56
	 * 작성자 : 최영철
	 * @param corpSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/detailCorp.ajax")
	public String dtlCorpAjax(	@ModelAttribute("CORPVO") CORPVO corpVO,
							@ModelAttribute("searchVO") CORPSVO corpSVO,
							ModelMap model){
		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);

		model.addAttribute("corpCd", corpCdList);

		// 업체 기본정보 조회
		CORPVO resultVO = ossCorpService.selectByCorp(corpVO);

		model.addAttribute("corpInfo", resultVO);
		return "oss/cmm/detailCorpAjax";
	}

	@RequestMapping("/oss/updateTamnacardMng.ajax")
	public ModelAndView getHiTour( @ModelAttribute("TAMNCARDSVO") TAMNACARDSVO tamnacardsvo	) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		/** 탐나는전 타입 update */
		try{
			ossCorpService.updateTamnacardMng(tamnacardsvo);
			resultMap.put("resultYn", "Y");
		}catch (Exception e){
			resultMap.put("resultYn", "N");
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/*@RequestMapping("/oss/getHiTour.ajax")
	public ModelAndView getHiTour(	@RequestParam("corpCd") String corpCd,
								ModelMap model) throws Exception{


		// 사용가능 상위 코드 전체 조회
		List<HI_TOUR> hiTourList = ossCorpPnsReqService.selectHiTour(corpCd);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("hiTourList", hiTourList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}*/
	
	@RequestMapping("/oss/getVisitJeju.ajax")
	public ModelAndView getVisitJeju(	@ModelAttribute("VISIT_JEJU") VISIT_JEJU visitVO,
								ModelMap model) throws Exception{
		// 사용가능 상위 코드 전체 조회
		List<VISIT_JEJU> visitJejuList = ossCorpPnsReqService.selectVisitJeju(visitVO);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("visitJejuList", visitJejuList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}
	
	@RequestMapping("/oss/getVisitJejuList.do")
	public String getVisitJejuList(	@ModelAttribute("visitVO") VISIT_JEJU visitVO,
								ModelMap model) throws Exception{
		int pageSize = 0;
		int pageCount = 0;		
		int totalCount = 0;
		int currentPage = 0;
		// 사용가능 상위 코드 전체 조회
		List<VISIT_JEJU> visitJejuList = ossCorpPnsReqService.selectVisitJeju(visitVO);
		
		if (visitJejuList.size() != 0) {
			pageSize = Integer.parseInt(visitJejuList.get(0).getPageSize());
			pageCount = Integer.parseInt(visitJejuList.get(0).getPageCount());
			totalCount = Integer.parseInt(visitJejuList.get(0).getTotalCount());		
			currentPage = Integer.parseInt(visitJejuList.get(0).getCurrentPage());	
		}

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPage);
		paginationInfo.setRecordCountPerPage(pageSize);
		paginationInfo.setPageSize(pageCount);

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount(totalCount);
		
    	model.addAttribute("pageSize", pageSize);
		model.addAttribute("visitJejuList", visitJejuList);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/oss/corp/visitJejuLayer";
	}


	@RequestMapping("/oss/findCorpSMSMail.do")
	public String findCorpSMSMail(@ModelAttribute("searchVO") CORPSVO corpSVO,
									HttpServletRequest request,
									ModelMap model){
		corpSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	corpSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(corpSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(corpSVO.getPageUnit());
		paginationInfo.setPageSize(corpSVO.getPageSize());

		corpSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		corpSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		corpSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossCorpService.selectCorpListSMSMail(corpSVO);

		@SuppressWarnings("unchecked")
		List<CORPVO> resultList = (List<CORPVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("type", request.getParameter("type"));

		return "/oss/corp/findCorpPopSMSMail";
	}

	@RequestMapping("/oss/getCorpList.ajax")
	public ModelAndView getCorpList(@ModelAttribute("corpVO") CORPVO corpVO,
								ModelMap model) throws Exception{
		// 업체 카테고리에 해당하는 리스트
	//	CORPVO corpVO = new CORPVO();
	//	corpVO.setCorpCd(corpCd);
		corpVO.setTradeStatusCd("TS03");
		List<CORPVO> corpList = ossCorpService.selectRcCorpList(corpVO);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("corpList", corpList);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	/**
	 * 업체 지수 확인
	 * 파일명 : corpLevel
	 * 작성일 : 2017. 9. 28. 오전 9:28:15
	 * 작성자 : 정동수
	 * @param bisSVO
	 * @param model
	 */
	@RequestMapping("/oss/corpLevel.do")
	public String corpLevel(@ModelAttribute("searchVO") BISSVO bisSVO, ModelMap model) {
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(bisSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bisSVO.getPageUnit());
		paginationInfo.setPageSize(bisSVO.getPageSize());		

		bisSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bisSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bisSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		if(EgovStringUtil.isEmpty(bisSVO.getsCategory())){
			bisSVO.setsCategory(Constant.ACCOMMODATION);
    	}
		
		// 입점업체 지수 리스트
		List<CORPLEVELVO> resultList = ossCorpService.selectCorpLevel(bisSVO);
		
		if ("AD".equals(bisSVO.getsCategory())) {
			List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
	    	model.addAttribute("categoryList", cdAddv);
		}
		
		if ("SPC".equals(bisSVO.getsCategory())) {
			List<CDVO> categoryList = ossCmmService.selectCode("C200");
	    	model.addAttribute("categoryList", categoryList);
		}
		
		if ("SPF".equals(bisSVO.getsCategory())) {
			List<CDVO> categoryList = ossCmmService.selectCode("C300");
	    	model.addAttribute("categoryList", categoryList);
		}
		
		if ("SPT".equals(bisSVO.getsCategory())) {	    	
			List<CDVO> categoryList = ossCmmService.selectCode("C100");
	    	model.addAttribute("categoryList", categoryList);
		}
		
		if ("SV".equals(bisSVO.getsCategory())) {	    	
			List<CDVO> categoryList = ossCmmService.selectCode("SVDV");
	    	model.addAttribute("categoryList", categoryList);
		}
		
		// 총 건수 셋팅
		int totalCnt = resultList != null && resultList.size() != 0 ? Integer.parseInt(resultList.get(0).getTotalCnt()) : 0;
    	paginationInfo.setTotalRecordCount(totalCnt);

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
				
		return "/oss/corp/corpLevel";   
	}
	
	/**
	 * 업체 지수 정보
	 * 파일명 : getCorpLevel
	 * 작성일 : 2017. 10. 10. 오전 10:40:26
	 * 작성자 : 정동수
	 * @param corpId
	 * @param model
	 */
	@RequestMapping("/oss/getCorpLevel.ajax")
	public ModelAndView getCorpLevel(	@RequestParam("corpId") String corpId,
								ModelMap model){
		// 업체 ID에 해당하는 지수 정보
		CORPLEVELVO levelVO = new CORPLEVELVO();
		levelVO.setCorpId(corpId);
		CORPLEVELVO levelInfo = ossCorpService.selectCorpInfo(corpId);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("levelInfo", levelInfo);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}
	
	/**
	 * 업체 지수 정보 수정
	 * 파일명 : getCorpLevel
	 * 작성일 : 2017. 10. 10. 오전 10:40:26
	 * 작성자 : 정동수
	 * @param corpLevelVO
	 * @param model
	 */
	@RequestMapping("/oss/updateLevelModInfo.ajax")
	public ModelAndView updateLevelModInfo(@ModelAttribute("CORPLEVELVO") CORPLEVELVO corpLevelVO,
								ModelMap model){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ossCorpService.updateLevelModInfo(corpLevelVO);
		
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}
	
	/**
	 * 추천 여행사 상품 업체
	 * Function : corpRcmd
	 * 작성일 : 2017. 12. 31. 오후 3:15:11
	 * 작성자 : 정동수
	 * @param corpRcmdVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/corpRcmd.do")
	public String corpRcmd(@ModelAttribute("corpRcmdVO") CORPRCMDVO corpRcmdVO, ModelMap model) {		
		List<CORPRCMDVO> corpRcmdList = ossCorpService.selectCorpRcmdList(corpRcmdVO);
    	model.addAttribute("corpRcmdList", corpRcmdList);
    	
    	corpRcmdVO.setRcmdDiv("C160");
    	corpRcmdList = ossCorpService.selectCorpRcmdList(corpRcmdVO);
    	model.addAttribute("corpRcmdC160List", corpRcmdList);
    	
    	corpRcmdVO.setRcmdDiv("C170");
    	corpRcmdList = ossCorpService.selectCorpRcmdList(corpRcmdVO);
    	model.addAttribute("corpRcmdC170List", corpRcmdList);
    	
		return "/oss/corp/corpRcmd"; 
	}
	
	/**
	 * 추천 여행사 상품 업체 등록
	 * Function : actionCorpRcmd
	 * 작성일 : 2017. 12. 31. 오후 4:34:40
	 * 작성자 : 정동수
	 * @param corpRcmdList
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/actionCorpRcmd.do")
    public String actionCorpRcmd(	@ModelAttribute("mainAreaPrdt") CORPRCMDVOLIST corpRcmdList,
    				ModelMap model){
    	log.info("/oss/actionCorpRcmd.do 호출");

    	// 추천 업체 삭제
    	ossCorpService.deleteCorpRcmd();

    	if (corpRcmdList.getCorpRcmd() != null) {
	    	for(CORPRCMDVO corpRcmdVO : corpRcmdList.getCorpRcmd()) {
	    		if (corpRcmdVO.getCorpId() != null) {
	    			ossCorpService.insertCorpRcmd(corpRcmdVO);
	    		}
			}
    	}

    	return "redirect:/oss/corpRcmd.do";
	}
	
	/**
	 * 업체 검색
	 * Function : findCorp
	 * 작성일 : 2017. 12. 31. 오후 3:15:57
	 * 작성자 : 정동수
	 * @param corpSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/findCorp.do")
    public String findCorp(@ModelAttribute("searchVO") CORPSVO corpSVO,
			ModelMap model){
    	corpSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		corpSVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(corpSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(corpSVO.getPageUnit());
		paginationInfo.setPageSize(corpSVO.getPageSize());

		corpSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		corpSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		corpSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		corpSVO.setsTradeStatusCd(Constant.TRADE_STATUS_APPR);
		
		Map<String, Object> resultMap = ossCorpService.selectCorpList(corpSVO);
		
		@SuppressWarnings("unchecked")
		List<CORPVO> resultList = (List<CORPVO>) resultMap.get("resultList");
		
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
    	List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
    	List<CDVO> tsCdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	
    	model.addAttribute("corpCdList", corpCdList);
    	model.addAttribute("tsCdList", tsCdList);
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "oss/corp/findCorpPop";
    }

	@RequestMapping("/oss/corpPartnerList.do")
	public String corpPartnerList(@ModelAttribute("searchVO") CORPSVO corpSVO,
						   ModelMap model){
		log.info("/oss/corpList.do 호출");
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		corpSVO.setPartnerCode(userVO.getPartnerCode());

		corpSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		corpSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(corpSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(corpSVO.getPageUnit());
		paginationInfo.setPageSize(corpSVO.getPageSize());

		corpSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		corpSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		corpSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossPointService.selectPointCorpList(corpSVO);

		@SuppressWarnings("unchecked")
		List<CORPVO> resultList = (List<CORPVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
		List<CDVO> tsCdList = ossCmmService.selectCode(Constant.TRADE_STATUS);

		// B2C 수수료
		List<CMSSVO> cmssList = ossCmmService.selectCmssList();
		model.addAttribute("cmssList", cmssList);
		// B2B 수수료
		List<CMSSVO> b2bCmssList = ossCmmService.selectB2bCmssList();
		model.addAttribute("b2bCmssList", b2bCmssList);

		//파트너(협력사)
		POINT_CPVO pointCpVO =  ossPointService.selectPointCpDetail(userVO.getPartnerCode());

		model.addAttribute("corpCdList", corpCdList);
		model.addAttribute("tsCdList", tsCdList);
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pointCpVO", pointCpVO);

		return "oss/corp/corpPartnerList";
	}

	@RequestMapping("/oss/corpPartnerReg.ajax")
	public ModelAndView corpPartnerReg(@ModelAttribute("POINT_CORPVO") POINT_CORPVO pointCorpVO){

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		pointCorpVO.setPartnerCode(userVO.getPartnerCode());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("regYn", pointCorpVO.getRegYn());
		resultMap.put("corpId", pointCorpVO.getCorpId());

		//toggle 등록/해제
		try {
			ossPointService.mergePointCorp(pointCorpVO);
			resultMap.put("success", "Y");
		}catch (Exception e){
			resultMap.put("success", e);
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	/**
	* 설명 : 카테고리별 판매업체 등록
	* 파일명 : corpPartnerRegAllPop
	* 작성일 : 2023-04-17 오후 2:28
	* 작성자 : chaewan.jung
	* @param : []
	* @return : java.lang.String
	* @throws Exception
	*/
	@RequestMapping("/oss/corpPartnerRegAllPop.ajax")
	public String corpPartnerRegAllPop() {
		return "/oss/point/corpPartnerRegAllPop";
	}

	/**
	* 설명 :
	* 파일명 : corpPartnerRegAll
	* 작성일 : 2023-04-17 오후 2:40
	* 작성자 : chaewan.jung
	* @param : [pointCorpVO]
	* @return : org.springframework.web.servlet.ModelAndView
	* @throws Exception
	*/
	@RequestMapping("/oss/corpPartnerRegAll.ajax")
	public ModelAndView corpPartnerRegAll(@ModelAttribute("POINT_CORPVO") POINT_CORPVO pointCorpVO){

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		pointCorpVO.setPartnerCode(userVO.getPartnerCode());
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			ossPointService.mergeAllCorpReg(pointCorpVO);
			resultMap.put("success", "Y");
		}catch (Exception e){
			resultMap.put("success", e);
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

	@RequestMapping("/oss/corpPointLimitSet.ajax")
	public ModelAndView corpPointLimitSet(@ModelAttribute("POINT_CORPVO") POINT_CORPVO pointCorpVO){

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		pointCorpVO.setPartnerCode(userVO.getPartnerCode());
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			ossPointService.mergePointLimit(pointCorpVO);
			resultMap.put("success", "Y");
		}catch (Exception e){
			resultMap.put("success", e);
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}
}
