package oss.adj.web;


import common.Constant;
import common.LowerHashMap;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import org.apache.commons.lang3.StringUtils;
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
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.adj.service.OssAdjService;
import oss.adj.vo.ADJDTLINFVO;
import oss.adj.vo.ADJSVO;
import oss.adj.vo.ADJTAMNACARDVO;
import oss.adj.vo.ADJVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.coupon.service.OssCouponService;
import oss.coupon.vo.CPSVO;
import oss.coupon.vo.CPVO;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
public class OssAdjController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name="ossAdjService")
	protected OssAdjService ossAdjService;

	@Resource(name="ossCorpService")
	protected OssCorpService ossCorpService;

	@Autowired
	private OssCouponService ossCouponService;
    
    Logger log = LogManager.getLogger(this.getClass());
    
    
    /**
     * 정산내역 리스트 조회
     * 파일명 : adjList
     * 작성일 : 2016. 1. 12. 오전 11:10:23
     * 작성자 : 최영철
     * @param adjSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/adjList.do")
    public String adjList(@ModelAttribute("searchVO") ADJSVO adjSVO,
						  ModelMap model) {    	
    	log.info("/oss/adjList.do call");
    	if(StringUtils.isEmpty(adjSVO.getsStartDt()) || StringUtils.isEmpty(adjSVO.getsEndDt())) {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
    		adjSVO.setsEndDt(sdf.format(cal.getTime()));
    		cal.add(Calendar.MONTH, -1);
    		adjSVO.setsStartDt(sdf.format(cal.getTime()));
    	}
    	List<ADJVO> adjList = ossAdjService.selectAdjListSearch(adjSVO);

    	adjSVO.setsFromYear(adjSVO.getsEndDt().substring(0, 4));
		adjSVO.setsFromMonth(adjSVO.getsEndDt().substring(5, 7));

		List<ADJVO> adjList2 = ossAdjService.selectAdjListYM(adjSVO);
    	
    	model.addAttribute("resultList", adjList);
		model.addAttribute("resultList2", adjList2);
    	
    	return "oss/adj/adjList";
    }


	@RequestMapping("/oss/getAdjListYM.ajax")
	public ModelAndView getAdjList(@ModelAttribute("searchVO") ADJSVO adjSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<ADJVO> adjList = ossAdjService.selectAdjListYM(adjSVO);

		resultMap.put("list", adjList);

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}
    
    /**
     * 수동 정산건 추출
     * 파일명 : getAdjust
     * 작성일 : 2016. 1. 12. 오전 11:10:13
     * 작성자 : 최영철
     * @return
     */
    @RequestMapping("/oss/getAdjust.ajax")
    public ModelAndView getAdjust() {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	// 1. 정산일자(가장 가까운 목요일)를 구한다.
    	String adjDt = ossAdjService.getAdjDt();
    	
    	// 2. 해당 날짜에 대한 정산건이 존재하는지 체크
		ADJSVO adjSVO = new ADJSVO();
		adjSVO.setsAdjDt(adjDt);
		List<ADJVO> adjList = ossAdjService.selectAdjList(adjSVO);
		
		// 2-1. 해당 날짜에 대한 정산건이 존재하는경우
		if(adjList.size() > 0) {
			log.error(adjDt + " 날짜에 대한 정산건이 이미 존재 합니다.");
			resultMap.put("success", "N");
			resultMap.put("rtnMsg", adjDt + " 날짜에 대한 정산건이 이미 존재 합니다.");
		}else{
			ossAdjService.getAdjust(adjSVO);
			resultMap.put("success", "Y");
		}
    	
		ModelAndView mav = new ModelAndView("jsonView", resultMap);
			
   		return mav;
    }
    
    /**
     * 업체별 정산 보기
     * 파일명 : dtlAdjList
     * 작성일 : 2016. 1. 12. 오후 5:41:30
     * 작성자 : 최영철
     * @param adjSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/dtlAdjList.do")
    public String dtlAdjList(@ModelAttribute("searchVO") ADJSVO adjSVO,
							 ModelMap model) {
    	
    	adjSVO.setsAdjDt(adjSVO.getsAdjDt().replaceAll("-", ""));

    	List<ADJVO> adjList = ossAdjService.selectAdjList2(adjSVO);
    	
    	model.addAttribute("resultList", adjList);
    	
    	return "oss/adj/dtlAdjList";
    }
    
    /**
     * 정산완료 처리
     * 파일명 : adjustComplete
     * 작성일 : 2016. 1. 12. 오후 5:41:22
     * 작성자 : 최영철
     * @param adjSVO
     * @return
     */
    @RequestMapping("/oss/adjustComplete.ajax")
    public ModelAndView adjustComplete(@ModelAttribute("ADJSVO") ADJSVO adjSVO) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	adjSVO.setsAdjDt(adjSVO.getsAdjDt().replaceAll("-", ""));
    	String [] corpId = adjSVO.getCorpList().get(0).split(",");
    	
    	List<String> corpList = new ArrayList<String>();
    	for(String sCorpId:corpId) {
    		corpList.add(sCorpId);
    	}
    	adjSVO.setCorpList(corpList);
    	
    	ossAdjService.adjustComplete(adjSVO);
    	log.info(corpId.length);
    	log.info(corpList.size());
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
   		return mav;	
    }
    
    /**
     * 업체별 정산상세 보기
     * 파일명 : dtlAdjList
     * 작성일 : 2016. 1. 12. 오후 5:41:30
     * 작성자 : 최영철
     * @param adjSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/dtlAdjInfList.do")
    public String dtlAdjInfList(@ModelAttribute("searchVO") ADJSVO adjSVO,
								ModelMap model) {
    	
    	adjSVO.setsAdjDt(adjSVO.getsAdjDt().replaceAll("-", ""));

    	List<ADJDTLINFVO> adjList = ossAdjService.selectAdjInfList(adjSVO);

		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(adjSVO.getsCorpId());
		CORPVO corpInfo = ossCorpService.selectCorpByCorpId(corpVO);
    	
    	model.addAttribute("resultList", adjList);
		model.addAttribute("corpInfo", corpInfo);
    	
    	return "oss/adj/dtlAdjInfList";
    }

    // 업체별 정산
    @RequestMapping("/oss/adjustExcelDown1.do")
    public void adjustExcelDown1(@ModelAttribute("searchVO") ADJSVO adjSVO,
								 HttpServletRequest request,
								 HttpServletResponse response) {
    	log.info("/oss/adjustExcelDown1.ajax call");
    	List<ADJVO> adjList;

    	boolean tfMonthly = false;
    	if(StringUtils.isNotEmpty(adjSVO.getsFromYear()) && StringUtils.isNotEmpty(adjSVO.getsFromMonth())) {
			adjList = ossAdjService.selectAdjListYM2(adjSVO);	// 월간
			tfMonthly = true;
		} else {
			adjSVO.setsAdjDt(adjSVO.getsAdjDt().replaceAll("-", ""));

			adjList = ossAdjService.selectAdjList2(adjSVO);		// 주간
		}

    	// Workbook 생성
//        Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합
 
        // *** Sheet-------------------------------------------------
        // Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("업체별정산내역");
 
        // 컬럼 너비 설정
		int j = 0;
        sheet1.setColumnWidth(j++, 30*256);
        if(!tfMonthly) {
            sheet1.setColumnWidth(j++, 10*256);
        }
        sheet1.setColumnWidth(j++, 16*256);
        sheet1.setColumnWidth(j++, 14*256);
        sheet1.setColumnWidth(j++, 14*256);
        sheet1.setColumnWidth(j++, 14*256);
        sheet1.setColumnWidth(j++, 14*256);
        sheet1.setColumnWidth(j++, 14*256);
        sheet1.setColumnWidth(j++, 14*256);
        sheet1.setColumnWidth(j++, 14*256);
        sheet1.setColumnWidth(j++, 14*256);
        sheet1.setColumnWidth(j++, 14*256);
        sheet1.setColumnWidth(j++, 16*256);
        /*sheet1.setColumnWidth(j++, 14*256);*/
		sheet1.setColumnWidth(j++, 10*256);
        sheet1.setColumnWidth(j++, 16*256);
		sheet1.setColumnWidth(j++, 20*256);
        sheet1.setColumnWidth(j++, 30*256);

        if(tfMonthly) {
			sheet1.setColumnWidth(j++, 16*256);
			sheet1.setColumnWidth(j++, 14*256);
		}
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

        if(!tfMonthly) {
            cell = row.createCell(j++);
            cell.setCellValue("정산상태");
            cell.setCellStyle(headerStyle);
        }

        cell = row.createCell(j++);
        cell.setCellValue("판매금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(j++);
        cell.setCellValue("총 할인금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(j++);
        cell.setCellValue("지원 할인금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(j++);
        cell.setCellValue("미지원 할인금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(j++);
        cell.setCellValue("업체할인부담금");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(j++);
        cell.setCellValue("지원 포인트금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(j++);
        cell.setCellValue("미지원 포인트금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(j++);
        cell.setCellValue("취소수수료");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(j++);
        cell.setCellValue("판매수수료");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(j++);
        cell.setCellValue("정산대상금액");
        cell.setCellStyle(headerStyle);

		/*cell = row.createCell(j++);
		cell.setCellValue("PG사 수수료");
		cell.setCellStyle(headerStyle);*/

		cell = row.createCell(j++);
		cell.setCellValue("수수료율");
		cell.setCellStyle(headerStyle);

        cell = row.createCell(j++);
        cell.setCellValue("은행");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(j++);
        cell.setCellValue("계좌번호");
        cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("예금주");
		cell.setCellStyle(headerStyle);

		if(tfMonthly) {
			cell = row.createCell(j++);
			cell.setCellValue("사업자등록번호");
			cell.setCellStyle(headerStyle);

			cell = row.createCell(j++);
			cell.setCellValue("대표자명");
			cell.setCellStyle(headerStyle);
		}

		cell = row.createCell(j++);
		cell.setCellValue("상품구분");
		cell.setCellStyle(headerStyle);
        //---------------------------------

		for(int i = 0; i < adjList.size(); i++) {
			ADJVO adjVO = adjList.get(i);
			row = sheet1.createRow(i + 1);

			j = 0;
			cell = row.createCell(j++);
			cell.setCellValue(adjVO.getCorpNm());

            if(!tfMonthly) {
                String adjStatusNm = "";
                String adjStatusCd = adjVO.getAdjStatusCd();
                if(Constant.ADJ_STATUS_CD_READY.equals(adjStatusCd)) {
                    adjStatusNm = "정산대기";
                } else if(Constant.ADJ_STATUS_CD_COM.equals(adjStatusCd)) {
                    adjStatusNm = "정산완료";
                }
                cell = row.createCell(j++);
                cell.setCellStyle(centerStyle);
                cell.setCellValue(adjStatusNm);
            }

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getDisAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSupportDisAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getUnsupportedDisAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCorpDisAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSupportedPointAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getUnsupportedPointAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCmssAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleCmss()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getAdjAmt()));

			/*cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getPgCmss()));*/

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle2);
			cell.setCellValue(Double.parseDouble(adjVO.getAdjAplPct()));

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getBankNm());

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getAccNum());

			cell = row.createCell(j++);
			cell.setCellValue(adjVO.getDepositor());

			if(tfMonthly) {
				cell = row.createCell(j++);
				cell.setCellStyle(centerStyle);
				cell.setCellValue(adjVO.getCoRegNum());

				cell = row.createCell(j++);
				cell.setCellStyle(centerStyle);
				cell.setCellValue(adjVO.getCeoNm());
			}

			cell = row.createCell(j++);
			cell.setCellValue(adjVO.getPrdtDiv());
		}

        // excel 파일 저장
        try {
    		String fileName = "정산_";
    		if(StringUtils.isNotEmpty(adjSVO.getsAdjDt())) {
				fileName += adjSVO.getsAdjDt();			// 주간
			} else {
				fileName += adjSVO.getsFromYear() + "_" + adjSVO.getsFromMonth();		// 월간
			}
    		fileName += ".xlsx";

			response.setHeader("Content-Disposition", "attachment; filename=" + fileNameByBrowser(request, fileName));

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

    // 건별 정산 상세
    @RequestMapping("/oss/adjustExcelDown2.do")
    public void adjustExcelDown2(@ModelAttribute("searchVO") ADJSVO adjSVO,
								 HttpServletRequest request,
								 HttpServletResponse response) {
    	log.info("/oss/adjustExcelDown2.ajax call");

    	adjSVO.setsAdjDt(adjSVO.getsAdjDt().replaceAll("-", ""));

    	List<ADJDTLINFVO> adjList = ossAdjService.selectAdjInfList(adjSVO);

    	// Workbook 생성
//        Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

        // *** Sheet-------------------------------------------------
        // Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("건별정산상세내역");

        // 컬럼 너비 설정
        sheet1.setColumnWidth(0, 30*256);
        sheet1.setColumnWidth(1, 30*256);
        sheet1.setColumnWidth(2, 50*256);
        sheet1.setColumnWidth(3, 16*256);
        sheet1.setColumnWidth(4, 20*256);
        sheet1.setColumnWidth(5, 10*256);
        sheet1.setColumnWidth(6, 14*256);
        sheet1.setColumnWidth(7, 14*256);
        sheet1.setColumnWidth(8, 14*256);
        sheet1.setColumnWidth(9, 14*256);
		sheet1.setColumnWidth(10, 14*256);
		sheet1.setColumnWidth(11, 14*256);
        sheet1.setColumnWidth(12, 14*256);
        sheet1.setColumnWidth(13, 10*256);
        sheet1.setColumnWidth(14, 10*256);
        sheet1.setColumnWidth(15, 14*256);
        sheet1.setColumnWidth(16, 14*256);
        sheet1.setColumnWidth(17, 20*256);
        sheet1.setColumnWidth(18, 14*256);
        sheet1.setColumnWidth(19, 20*256);
		sheet1.setColumnWidth(20, 14*256);
        sheet1.setColumnWidth(21, 14*256);
        sheet1.setColumnWidth(22, 14*256);
        sheet1.setColumnWidth(23, 14*256);
		sheet1.setColumnWidth(24, 14*256);
		sheet1.setColumnWidth(25, 14*256);
		sheet1.setColumnWidth(26, 20*256);
		sheet1.setColumnWidth(27, 20*256);
		sheet1.setColumnWidth(28, 20*256);
		sheet1.setColumnWidth(29, 20*256);
		sheet1.setColumnWidth(30, 20*256);
		sheet1.setColumnWidth(31, 20*256);
		sheet1.setColumnWidth(32, 14*256);
		sheet1.setColumnWidth(33, 14*256);
		sheet1.setColumnWidth(34, 20*256);
		sheet1.setColumnWidth(35, 20*256);
		sheet1.setColumnWidth(36, 20*256);
		sheet1.setColumnWidth(37, 20*256);
		sheet1.setColumnWidth(38, 20*256);

        // ----------------------------------------------------------

		XSSFCellStyle headerStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		headerStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		headerStyle.setAlignment(CellStyle.ALIGN_CENTER);

		XSSFCellStyle numericStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		XSSFDataFormat df = (XSSFDataFormat) xlsxWb.createDataFormat();
		numericStyle.setDataFormat(df.getFormat("#,##0"));

		CellStyle numericStyle2 = xlsxWb.createCellStyle();
		numericStyle2.setDataFormat(df.getFormat("0.0"));

		CellStyle centerStyle = xlsxWb.createCellStyle();
		centerStyle.setAlignment(CellStyle.ALIGN_CENTER);

        Row row;
        Cell cell;

        // 첫 번째 줄
        row = sheet1.createRow(0);

        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("업체명");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(1);
        cell.setCellValue("상품명");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(2);
        cell.setCellValue("상품정보");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(3);
        cell.setCellValue("예약번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(4);
        cell.setCellValue("예약자");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(5);
        cell.setCellValue("예약결과");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(6);
        cell.setCellValue("판매금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(7);
        cell.setCellValue("총 할인금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(8);
        cell.setCellValue("사업비 지원 할인쿠폰");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(9);
        cell.setCellValue("사업비 지원 포인트");
        cell.setCellStyle(headerStyle);

		cell = row.createCell(10);
		cell.setCellValue("취소수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(11);
		cell.setCellValue("정산액");
		cell.setCellStyle(headerStyle);

        cell = row.createCell(12);
        cell.setCellValue("L.Point 사용");
        cell.setCellStyle(headerStyle);

		cell = row.createCell(13);
		cell.setCellValue("L.Point 취소");
		cell.setCellStyle(headerStyle);

        cell = row.createCell(14);
        cell.setCellValue("L.Point 사용금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(15);
        cell.setCellValue("L.Point 적립");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(16);
        cell.setCellValue("결제금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(17);
        cell.setCellValue("PG사▶협회 입금금액");
        cell.setCellStyle(headerStyle);

		cell = row.createCell(18);
		cell.setCellValue("판매수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(19);
        cell.setCellValue("업체 정산액");
        cell.setCellStyle(headerStyle);

		cell = row.createCell(20);
		cell.setCellValue("PG사 수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(21);
		cell.setCellValue("탐나오 지원 할인쿠폰");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(22);
		cell.setCellValue("탐나오 지원 포인트");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(23);
		cell.setCellValue("정산지출액");
		cell.setCellStyle(headerStyle);

        cell = row.createCell(24);
        cell.setCellValue("정산 수익");
        cell.setCellStyle(headerStyle);

		cell = row.createCell(25);
		cell.setCellValue("(구)협회 실수익");
		cell.setCellStyle(headerStyle);

        cell = row.createCell(26);
        cell.setCellValue("수수료율");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(27);
        cell.setCellValue("결제방식");
        cell.setCellStyle(headerStyle);

		cell = row.createCell(28);
		cell.setCellValue("쿠폰명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(29);
		cell.setCellValue("포인트명");
		cell.setCellStyle(headerStyle);

        cell = row.createCell(30);
        cell.setCellValue("수정여부");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(31);
        cell.setCellValue("수정사유");
        cell.setCellStyle(headerStyle);

		cell = row.createCell(32);
		cell.setCellValue("상품구분");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(33);
		cell.setCellValue("앱구분");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(34);
		cell.setCellValue("지원할인금액 수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(35);
		cell.setCellValue("지원할인금액 정산금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(36);
		cell.setCellValue("지원포인트 수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(37);
		cell.setCellValue("지원포인트 정산금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(38);
		cell.setCellValue("업체할인부담금");
		cell.setCellStyle(headerStyle);

        //---------------------------------

		for (int i = 0; i < adjList.size(); i++) {
			ADJDTLINFVO adjVO = adjList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(adjVO.getCorpNm());

			cell = row.createCell(1);
			cell.setCellValue(adjVO.getPrdtNm());

			cell = row.createCell(2);
			cell.setCellValue(adjVO.getPrdtInf());

			cell = row.createCell(3);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getRsvNum());

			cell = row.createCell(4);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getRsvNm());

			String rsvStatusCd = adjVO.getRsvStatusCd();
			String rsvStatus = "";
			if(Constant.RSV_STATUS_CD_CCOM.equals(rsvStatusCd)) {
				rsvStatus = "취소";
			}else if(Constant.RSV_STATUS_CD_UCOM.equals(rsvStatusCd)) {
				rsvStatus = "사용완료";
			}else if(Constant.RSV_STATUS_CD_ECOM.equals(rsvStatusCd)) {
				rsvStatus = "기간만료";
			}else if(Constant.RSV_STATUS_CD_SCOM.equals(rsvStatusCd)) {
				rsvStatus = "부분환불완료";
			}

			cell = row.createCell(5);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(rsvStatus);

			cell = row.createCell(6);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleAmt()));

			cell = row.createCell(7);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getDisAmt()));

			//지원 할인금액
			cell = row.createCell(8);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSupportDisAmt()));

			//지원 포인트금액
			cell = row.createCell(9);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSupportedPointAmt()));

			//취소수수료
			cell = row.createCell(10);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCmssAmt()));

			//정산액
			int calPrice = Integer.parseInt(adjVO.getSaleAmt()) - Integer.parseInt(adjVO.getSupportDisAmt()) - Integer.parseInt(adjVO.getSupportedPointAmt()) + Integer.parseInt(adjVO.getCmssAmt());
			cell = row.createCell(11);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(calPrice);

			//L.Point 사용
			cell = row.createCell(12);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getLpointUseFlag());

			//L.Point 취소
			cell = row.createCell(13);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getLpointUseCancelFlag());

			//L.Point 사용금액
			cell = row.createCell(14);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getLpointUsePoint()));

			//L.Point 적립
			cell = row.createCell(15);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getLpointSaveFlag());

			//결제금액
			cell = row.createCell(16);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getRealAmt()));

			//PG사▶협회 입금금액
			cell = row.createCell(17);
			cell.setCellStyle(numericStyle);
			if(StringUtils.isNotEmpty(adjVO.getPgDepositAmt())){
				cell.setCellValue(Integer.parseInt(adjVO.getPgDepositAmt()));
			}

			//판매수수료
			cell = row.createCell(18);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleCmss()));

			//업체정산 대상금액
			cell = row.createCell(19);
			cell.setCellStyle(numericStyle);
			if(StringUtils.isNotEmpty(adjVO.getMasJsYsAmt())){
				cell.setCellValue(Integer.parseInt(adjVO.getMasJsYsAmt()));
			}

			//pg사 수수료
			cell = row.createCell(20);
			cell.setCellStyle(numericStyle);
			if(StringUtils.isNotEmpty(adjVO.getPgCmssAmt())){
				cell.setCellValue(Integer.parseInt(adjVO.getPgCmssAmt()));
			}

			//미지원 할인금액
			cell = row.createCell(21);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getUnsupportedDisAmt()));

			//미지원 포인트
			cell = row.createCell(22);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getUnsupportedPointAmt()));

			//정산 지출액
			int expensePrice = Integer.parseInt(adjVO.getMasJsYsAmt()) + Integer.parseInt(adjVO.getPgCmssAmt()) + Integer.parseInt(adjVO.getUnsupportedDisAmt()) + Integer.parseInt(adjVO.getUnsupportedPointAmt());
			cell = row.createCell(23);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(expensePrice);

			//협회 실수익
			cell = row.createCell(24);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(calPrice - expensePrice);

			//(구)협회 실수익
			cell = row.createCell(25);
			cell.setCellStyle(numericStyle);
			if(StringUtils.isNotEmpty(adjVO.getRealProfit())){
				cell.setCellValue(Integer.parseInt(adjVO.getRealProfit()));
			}

			//수수료율
			cell = row.createCell(26);
			cell.setCellStyle(numericStyle2);
			cell.setCellValue(Double.parseDouble(adjVO.getAdjAplPct()));

			String payDiv = adjVO.getPayDiv();
			if(Constant.PAY_DIV_LG_CI.equals(payDiv)) {
				payDiv = "카드결제";
			}else if(Constant.PAY_DIV_LG_HI.equals(payDiv)) {
				payDiv = "휴대폰결제";
			}else if(Constant.PAY_DIV_LG_TI.equals(payDiv)) {
				payDiv = "계좌이체";
			}else if(Constant.PAY_DIV_LG_ETI.equals(payDiv)) {
				payDiv = "계좌이체(에스크로)";
			}else if(Constant.PAY_DIV_LG_KI.equals(payDiv)) {
				payDiv = "카카오페이";
			}else if(Constant.PAY_DIV_LG_FI.equals(payDiv)) {
				payDiv = "무료쿠폰결제";
			}else if(Constant.PAY_DIV_LG_LI.equals(payDiv)) {
				payDiv = "L.Point결제";
			}else if(Constant.PAY_DIV_LG_MI.equals(payDiv)) {
				payDiv = "무통장입금";
			}else if(Constant.PAY_DIV_NV_SI.equals(payDiv)) {
				payDiv = "스마트스토어";
			}else if(Constant.PAY_DIV_TC_WI.equals(payDiv)) {
				payDiv = "탐나는전 PC결제";
			}else if(Constant.PAY_DIV_TC_MI.equals(payDiv)) {
				payDiv = "탐나는전 모바일결제";
			}else if(Constant.PAY_DIV_NV_LI.equals(payDiv)) {
				payDiv = "라이브커머스";
			}else if(Constant.PAY_DIV_TA_PI.equals(payDiv)) {
				payDiv = "포인트결제";
			}else if(Constant.PAY_DIV_LG_NP.equals(payDiv)) {
				payDiv = "네이버페이";
			}else if(Constant.PAY_DIV_LG_KP.equals(payDiv)) {
				payDiv = "카카오페이";
			}else if(Constant.PAY_DIV_LG_AP.equals(payDiv)) {
				payDiv = "애플페이";
			}else if(Constant.PAY_DIV_LG_TP.equals(payDiv)) {
				payDiv = "토스페이";
			}

			cell = row.createCell(27);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(payDiv);

			cell = row.createCell(28);
			cell.setCellValue(adjVO.getCpNm());

			cell = row.createCell(29);
			cell.setCellValue(adjVO.getPartnerNm());

			cell = row.createCell(30);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getModYn());

			cell = row.createCell(31);
			cell.setCellValue(adjVO.getModRsn());

			cell = row.createCell(32);
			cell.setCellValue(adjVO.getPrdtDiv());

			cell = row.createCell(33);
			cell.setCellValue(adjVO.getAppDiv());

			cell = row.createCell(34);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getDisCmssAmt()));

			cell = row.createCell(35);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getDisJsYsAmt()));

			cell = row.createCell(36);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getPointCmssAmt()));

			cell = row.createCell(37);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getPointJsYsAmt()));

			cell = row.createCell(38);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCorpDisAmt()));
		}

        // excel 파일 저장
        try {
        	String fileName = "건별정산_";
        	if(EgovStringUtil.isEmpty(adjSVO.getsCorpId())) {
				fileName += adjSVO.getsAdjDt();
        	}else{
				fileName += adjSVO.getsAdjDt() + "_" + adjSVO.getsCorpId();
        	}
        	fileName += ".xlsx";

			response.setHeader("Content-Disposition", "attachment; filename=" + fileNameByBrowser(request, fileName));

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

	// 브라우저별 파일명
	public String fileNameByBrowser(HttpServletRequest request, String fileName) {
		String encodedFileName = fileName;
		String browser = request.getHeader("User-Agent");

		try {
			if(browser.contains("MSIE") || browser.contains("Trident")) {
				encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
			} else if(browser.contains("Edge")) {
				encodedFileName = "\"" + URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20") + "\"";
			} else if(browser.contains("Chrome")) {
				StringBuffer sb = new StringBuffer();
				for(int i = 0; i < fileName.length(); i++) {
					char c = fileName.charAt(i);
					if (c > '~') {
						sb.append(URLEncoder.encode("" + c, "UTF-8"));
					} else {
						sb.append(c);
					}
				}
				encodedFileName = sb.toString();
			} else if (browser.contains("Firefox")) {
				encodedFileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
				encodedFileName = URLDecoder.decode(encodedFileName, "UTF-8");
			} else if (browser.contains("Opera")) {
				encodedFileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
			} else if (browser.contains("Safari")){
				encodedFileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1")+ "\"";
				encodedFileName = URLDecoder.decode(encodedFileName, "UTF-8");
			} else {
				encodedFileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1")+ "\"";
			}
		} catch (UnsupportedEncodingException e) {
			log.error(e);
		}

		return encodedFileName;
	}

	@RequestMapping("/oss/adjModInfo.ajax")
    public ModelAndView adjModInfo(@ModelAttribute("ADJDTLINFVO") ADJDTLINFVO adjDtlInfVO) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	adjDtlInfVO = ossAdjService.selectByAdjDtlInf(adjDtlInfVO);
    	
    	resultMap.put("adjDtlInfVO", adjDtlInfVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
   		return mav;	
    }
    
    @RequestMapping("/oss/updateAdjModInfo.ajax")
    public ModelAndView updateAdjModInfo(@ModelAttribute("ADJDTLINFVO") ADJDTLINFVO adjDtlInfVO) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	ossAdjService.updateAdjDtlInf(adjDtlInfVO);
    	
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
		
   		return mav;	
    }

	/**
	 * 설명 : 쿠폰검색 후 쿠폰별 엑셀다운로드
	 * 파일명 : couponAdjExcelPop
	 * 작성일 : 2022-02-11 오후 3:46
	 * 작성자 : chaewan.jung
	 * @param : [adjSVO, model]
	 * @return : java.lang.String
	 * @throws Exception
	 */
	@RequestMapping("/oss/couponAdjExcelPop.do")
	public String couponAdjExcelPop(@ModelAttribute("searchVO") ADJSVO adjSVO, ModelMap model) {

		CPSVO cpsVO = new CPSVO();
		cpsVO.setFirstIndex(0);
		cpsVO.setLastIndex(99999);

		Map<String, Object> resultMap = ossCouponService.selectCouponList(cpsVO);

		List<CPVO> resultList = (List<CPVO>) resultMap.get("resultList");
		model.addAttribute("resultList", resultList);

		return "oss/adj/couponAdjExcelPop";
	}

	@RequestMapping("/oss/pointAdjExcelPop.do")
	public String pointAdjExcelPop(@ModelAttribute("searchVO") ADJSVO adjSVO, ModelMap model) {

		adjSVO.setFirstIndex(0);
		adjSVO.setLastIndex(99999);

		List<LowerHashMap> resultList = ossAdjService.selectPointList(adjSVO);
		model.addAttribute("resultList", resultList);

		return "oss/adj/pointAdjExcelPop";
	}

	// 업체별 정산
	@RequestMapping("/oss/adjustExcelDown3.do")
	public void adjustExcelDown3(@ModelAttribute("searchVO") ADJSVO adjSVO,
								 HttpServletRequest request,
								 HttpServletResponse response) {

		String[] arrCpInfo = request.getParameterValues("couponText");
		List<String> arrCpId = new ArrayList<>();

		if (arrCpInfo != null) {
			for (int i = 0; i < arrCpInfo.length; i++){
				arrCpId.add(arrCpInfo[i].split("\\|")[0]);
			}
			adjSVO.setArrCpId(arrCpId);
		}

		List<ADJVO> adjList;

		adjSVO.setsAdjDt(adjSVO.getsAdjDt().replaceAll("-", ""));
		adjList = ossAdjService.selectAdjList3(adjSVO);

		// Workbook 생성
//        Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

		// *** Sheet-------------------------------------------------
		// Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("업체별정산내역");

		// 컬럼 너비 설정
		int j = 0;
		sheet1.setColumnWidth(j++, 30*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 16*256);

		sheet1.setColumnWidth(j++, 16*256);
		sheet1.setColumnWidth(j++, 20*256);

		sheet1.setColumnWidth(j++, 16*256);
		sheet1.setColumnWidth(j++, 20*256);
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
		cell.setCellValue("판매금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("지원 할인금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("미지원 할인금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("업체할인부담금");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("취소수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("판매수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("지원할인금액 판매수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("지원할인금액 정산금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("은행");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("계좌번호");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("예금주");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("상품구분");
		cell.setCellStyle(headerStyle);

		//---------------------------------

		for(int i = 0; i < adjList.size(); i++) {
			ADJVO adjVO = adjList.get(i);
			row = sheet1.createRow(i + 1);

			j = 0;
			cell = row.createCell(j++);
			cell.setCellValue(adjVO.getCorpNm());

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSupportDisAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getUnsupportedDisAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCorpDisAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCmssAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleCmss()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getDisCmssAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getDisJsYsAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getBankNm());

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getAccNum());

			cell = row.createCell(j++);
			cell.setCellValue(adjVO.getDepositor());

			cell = row.createCell(j++);
			cell.setCellValue(adjVO.getPrdtDiv());
		}

		// excel 파일 저장
		try {
			String fileName = "정산_쿠폰_";
			if(StringUtils.isNotEmpty(adjSVO.getsAdjDt())) {
				fileName += adjSVO.getsAdjDt();			// 주간
			} else {
				fileName += adjSVO.getsFromYear() + "_" + adjSVO.getsFromMonth();		// 월간
			}
			fileName += ".xlsx";

			response.setHeader("Content-Disposition", "attachment; filename=" + fileNameByBrowser(request, fileName));

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
	* 설명 : 쿠폰 건별 정산 상세
	* 파일명 : adjustExcelDown4
	* 작성일 : 2022-02-14 오후 1:43
	* 작성자 : chaewan.jung
	* @param : [adjSVO, request, response]
	* @return : void
	* @throws Exception
	*/
	@RequestMapping("/oss/adjustExcelDown4.do")
	public void adjustExcelDown4(@ModelAttribute("searchVO") ADJSVO adjSVO,
								 HttpServletRequest request,
								 HttpServletResponse response) {

		String[] arrCpInfo = request.getParameterValues("couponText");
		List<String> arrCpId = new ArrayList<>();

		if (arrCpInfo != null) {
			for (int i = 0; i < arrCpInfo.length; i++){
				arrCpId.add(arrCpInfo[i].split("\\|")[0]);
			}
			adjSVO.setArrCpId(arrCpId);
		}

		adjSVO.setsAdjDt(adjSVO.getsAdjDt().replaceAll("-", ""));
		List<ADJDTLINFVO> adjList = ossAdjService.selectAdjInfList(adjSVO);

		// Workbook 생성
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

		// *** Sheet-------------------------------------------------
		// Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("건별정산상세내역");

		// 컬럼 너비 설정
		sheet1.setColumnWidth(0, 30 * 256);
		sheet1.setColumnWidth(1, 30 * 256);
		sheet1.setColumnWidth(2, 50 * 256);
		sheet1.setColumnWidth(3, 20 * 256);
		sheet1.setColumnWidth(4, 20 * 256);
		sheet1.setColumnWidth(5, 20 * 256);
		sheet1.setColumnWidth(6, 20 * 256);
		sheet1.setColumnWidth(7, 20 * 256);
		sheet1.setColumnWidth(8, 20 * 256);
		sheet1.setColumnWidth(9, 20 * 256);
		sheet1.setColumnWidth(10, 20 * 256);
		sheet1.setColumnWidth(11, 20 * 256);
		sheet1.setColumnWidth(12, 20 * 256);
		sheet1.setColumnWidth(13, 20 * 256);
		sheet1.setColumnWidth(14, 20 * 256);
		sheet1.setColumnWidth(15, 50 * 256);
		sheet1.setColumnWidth(16, 20 * 256);

		// ----------------------------------------------------------

		XSSFCellStyle headerStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		headerStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		headerStyle.setAlignment(CellStyle.ALIGN_CENTER);

		XSSFCellStyle numericStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		XSSFDataFormat df = (XSSFDataFormat) xlsxWb.createDataFormat();
		numericStyle.setDataFormat(df.getFormat("#,##0"));

		CellStyle numericStyle2 = xlsxWb.createCellStyle();
		numericStyle2.setDataFormat(df.getFormat("0.0"));

		CellStyle centerStyle = xlsxWb.createCellStyle();
		centerStyle.setAlignment(CellStyle.ALIGN_CENTER);

		Row row;
		Cell cell;

		// 첫 번째 줄
		row = sheet1.createRow(0);

		// 첫 번째 줄에 Cell 설정하기-------------
		cell = row.createCell(0);
		cell.setCellValue("업체명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(1);
		cell.setCellValue("상품명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(2);
		cell.setCellValue("상품정보");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(3);
		cell.setCellValue("예약번호");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(4);
		cell.setCellValue("예약자");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(5);
		cell.setCellValue("예약결과");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(6);
		cell.setCellValue("판매금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(7);
		cell.setCellValue("지원 할인금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(8);
		cell.setCellValue("미지원 할인금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(9);
		cell.setCellValue("업체할인부담금");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(10);
		cell.setCellValue("취소수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(11);
		cell.setCellValue("판매수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(12);
		cell.setCellValue("수수료율");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(13);
		cell.setCellValue("지원할인금액 수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(14);
		cell.setCellValue("지원할인금액 정산금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(15);
		cell.setCellValue("쿠폰명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(16);
		cell.setCellValue("상품구분");
		cell.setCellStyle(headerStyle);

		//---------------------------------
		for (int i = 0; i < adjList.size(); i++) {
			ADJDTLINFVO adjVO = adjList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(adjVO.getCorpNm());

			cell = row.createCell(1);
			cell.setCellValue(adjVO.getPrdtNm());

			cell = row.createCell(2);
			cell.setCellValue(adjVO.getPrdtInf());

			cell = row.createCell(3);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getRsvNum());

			cell = row.createCell(4);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getRsvNm());

			String rsvStatusCd = adjVO.getRsvStatusCd();
			String rsvStatus = "";
			if(Constant.RSV_STATUS_CD_CCOM.equals(rsvStatusCd)) {
				rsvStatus = "취소";
			}else if(Constant.RSV_STATUS_CD_UCOM.equals(rsvStatusCd)) {
				rsvStatus = "사용완료";
			}else if(Constant.RSV_STATUS_CD_ECOM.equals(rsvStatusCd)) {
				rsvStatus = "기간만료";
			}else if(Constant.RSV_STATUS_CD_SCOM.equals(rsvStatusCd)) {
				rsvStatus = "부분환불완료";
			}

			cell = row.createCell(5);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(rsvStatus);

			cell = row.createCell(6);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleAmt()));

			cell = row.createCell(7);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSupportDisAmt()));

			cell = row.createCell(8);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getUnsupportedDisAmt()));

			cell = row.createCell(9);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCorpDisAmt()));

			cell = row.createCell(10);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCmssAmt()));

			cell = row.createCell(11);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleCmss()));

			cell = row.createCell(12);
			cell.setCellStyle(numericStyle2);
			cell.setCellValue(Double.parseDouble(adjVO.getAdjAplPct()));

			cell = row.createCell(13);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getDisCmssAmt()));

			cell = row.createCell(14);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getDisJsYsAmt()));

			cell = row.createCell(15);
			cell.setCellValue(adjVO.getCpNm());

			cell = row.createCell(16);
			cell.setCellValue(adjVO.getPrdtDiv());

		}

		// excel 파일 저장
		try {
			String fileName = "건별정산_쿠폰_";
			if(EgovStringUtil.isEmpty(adjSVO.getsCorpId())) {
				fileName += adjSVO.getsAdjDt();
			}else{
				fileName += adjSVO.getsAdjDt() + "_" + adjSVO.getsCorpId();
			}
			fileName += ".xlsx";

			response.setHeader("Content-Disposition", "attachment; filename=" + fileNameByBrowser(request, fileName));

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

	@RequestMapping("/oss/adjustExcelDown5.do")
	public void adjustExcelDown5(@ModelAttribute("searchVO") ADJSVO adjSVO,
								 HttpServletRequest request,
								 HttpServletResponse response) {

		adjSVO.setsStartDt(adjSVO.getsStartDt().replaceAll("-",""));
		adjSVO.setsEndDt(adjSVO.getsEndDt().replaceAll("-",""));

		List<ADJTAMNACARDVO> adjTamnacardList = ossAdjService.selectAdjTamnacardList(adjSVO);

		// Workbook 생성
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

		// *** Sheet-------------------------------------------------
		// Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("탐나는전 정산");

		// 컬럼 너비 설정
		sheet1.setColumnWidth(0, 30 * 256);
		sheet1.setColumnWidth(1, 20 * 256);
		sheet1.setColumnWidth(2, 20 * 256);
		sheet1.setColumnWidth(3, 20 * 256);
		sheet1.setColumnWidth(4, 20 * 256);
		sheet1.setColumnWidth(5, 20 * 256);
		sheet1.setColumnWidth(6, 20 * 256);
		sheet1.setColumnWidth(7, 20 * 256);
		sheet1.setColumnWidth(8, 20 * 256);
		sheet1.setColumnWidth(9, 20 * 256);
		sheet1.setColumnWidth(10, 20 * 256);
		sheet1.setColumnWidth(11, 20 * 256);
		sheet1.setColumnWidth(12, 50 * 256);
		sheet1.setColumnWidth(13, 20 * 256);
		sheet1.setColumnWidth(14, 20 * 256);
		sheet1.setColumnWidth(15, 20 * 256);
		sheet1.setColumnWidth(16, 20 * 256);
		sheet1.setColumnWidth(17, 35 * 256);
		sheet1.setColumnWidth(18, 35 * 256);
		sheet1.setColumnWidth(19, 20 * 256);
		// ----------------------------------------------------------

		XSSFCellStyle headerStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		headerStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		headerStyle.setAlignment(CellStyle.ALIGN_CENTER);

		XSSFCellStyle numericStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		XSSFDataFormat df = (XSSFDataFormat) xlsxWb.createDataFormat();
		numericStyle.setDataFormat(df.getFormat("#,##0"));

		CellStyle numericStyle2 = xlsxWb.createCellStyle();
		numericStyle2.setDataFormat(df.getFormat("0.0"));

		CellStyle centerStyle = xlsxWb.createCellStyle();
		centerStyle.setAlignment(CellStyle.ALIGN_CENTER);

		Row row;
		Cell cell;

		// 첫 번째 시트
		row = sheet1.createRow(0);

		// 첫 번째 줄에 Cell 설정하기-------------
		cell = row.createCell(0);
		cell.setCellValue("수신일시");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(1);
		cell.setCellValue("탐나오 거래상태");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(2);
		cell.setCellValue("탐나는전 거래상태");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(3);
		cell.setCellValue("주문번호");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(4);
		cell.setCellValue("구매자명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(5);
		cell.setCellValue("총상품금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(6);
		cell.setCellValue("지원할인금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(7);
		cell.setCellValue("미지원할인금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(8);
		cell.setCellValue(" 탐나오취소수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(9);
		cell.setCellValue("결제금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(10);
		cell.setCellValue("탐나는전 수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(11);
		cell.setCellValue("업체명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(12);
		cell.setCellValue("상품명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(13);
		cell.setCellValue("상품구분");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(14);
		cell.setCellValue("앱구분");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(15);
		cell.setCellValue("정산예정일");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(16);
		cell.setCellValue("정산상태");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(17);
		cell.setCellValue("탐나는전 포인트 미사용금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(18);
		cell.setCellValue("탐나는전 포인트 사용금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(19);
		cell.setCellValue("부정사용 검증대상");
		cell.setCellStyle(headerStyle);

		//---------------------------------
		for (int i = 0; i < adjTamnacardList.size(); i++) {
			ADJTAMNACARDVO adjVO = adjTamnacardList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getTradeDttm());

			String rsvStatusCd = adjVO.getRsvStatusCd();
			String rsvStatus = "";
			if(Constant.RSV_STATUS_CD_CCOM.equals(rsvStatusCd)) {
				rsvStatus = "취소";
			}else if(Constant.RSV_STATUS_CD_UCOM.equals(rsvStatusCd)) {
				rsvStatus = "사용완료";
			}else if(Constant.RSV_STATUS_CD_ECOM.equals(rsvStatusCd)) {
				rsvStatus = "기간만료";
			}else if(Constant.RSV_STATUS_CD_SCOM.equals(rsvStatusCd)) {
				rsvStatus = "부분환불완료";
			}else if(Constant.RSV_STATUS_CD_CREQ2.equals(rsvStatusCd)) {
				rsvStatus = "환불요청";
			}else if(Constant.RSV_STATUS_CD_COM.equals(rsvStatusCd)) {
				rsvStatus = "예약";
			}else if(Constant.RSV_STATUS_CD_DLVE.equals(rsvStatusCd)) {
				rsvStatus = "배송완료";
			}else if(Constant.RSV_STATUS_CD_CREQ.equals(rsvStatusCd)) {
				rsvStatus = "고객취소요청";
			}else if(Constant.RSV_STATUS_CD_READY.equals(rsvStatusCd)) {
				rsvStatus = "예약대기";
			}else if(Constant.RSV_STATUS_CD_EXP.equals(rsvStatusCd)) {
				rsvStatus = "예약불가";
			}else if(Constant.RSV_STATUS_CD_DLV.equals(rsvStatusCd)) {
				rsvStatus = "배송중";
			}else if(Constant.RSV_STATUS_CD_SREQ.equals(rsvStatusCd)) {
				rsvStatus = "부분환불요청";
			}else if(Constant.RSV_STATUS_CD_CCOM2.equals(rsvStatusCd)) {
				rsvStatus = "환불완료";
			}else if(Constant.RSV_STATUS_CD_ACC.equals(rsvStatusCd)) {
				rsvStatus = "자동취소";
			}

			cell = row.createCell(1);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(rsvStatus);

			String payStatus = "승인";
			if("1".equals(adjVO.getPaySn())) {
				payStatus = "취소";
			}
			cell = row.createCell(2);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(payStatus);

			cell = row.createCell(3);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getRsvNum());

			cell = row.createCell(4);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getRsvNm());

			cell = row.createCell(5);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(adjVO.getTotalNmlAmt());

			cell = row.createCell(6);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(adjVO.getSupportDisAmt());

			cell = row.createCell(7);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(adjVO.getUnsupportedDisAmt());

			cell = row.createCell(8);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(adjVO.getCmssAmt());

			cell = row.createCell(9);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(adjVO.getTotalSaleAmt());

			cell = row.createCell(10);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(adjVO.getTcCmss());

			cell = row.createCell(11);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getCorpNm());

			cell = row.createCell(12);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getPrdtNm());

			String prdtDiv = adjVO.getPrdtDiv();
			String prdtNm = "";
			if(Constant.ACCOMMODATION.equals(prdtDiv)) {
				prdtNm = "숙박";
			}else if(Constant.RENTCAR.equals(prdtDiv)) {
				prdtNm = "렌터카";
			}else if(Constant.SOCIAL.equals(prdtDiv)) {
				prdtNm = "소셜";
			}else if(Constant.SV.equals(prdtDiv)) {
				prdtNm = "특산/기념품";
			}else{
				//소셜 구분 쿼리 변경 됨에 따라 처리
				prdtNm = String.valueOf(prdtDiv).replace("SP","소셜");
			}
			cell = row.createCell(13);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(prdtNm);

			String appDiv = adjVO.getAppDiv();
			String appDivNm = "";
			if("PC".equals(appDiv)) {
				appDivNm = "PC";
			}else if("AW".equals(appDiv)) {
				appDivNm = "Android Mobile Web";
			}else if("AA".equals(appDiv)) {
				appDivNm = "Android";
			}else if("IW".equals(appDiv)) {
				appDivNm = "IOS Mobile Web";
			}else if("IA".equals(appDiv)) {
				appDivNm = "IOS APP";
			}else if("AR".equals(appDiv)) {
				appDivNm = "Admin Register";
			}
			cell = row.createCell(14);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(appDivNm);

			cell = row.createCell(15);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getAdjItdDt());

			cell = row.createCell(16);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getAdjStatus());

			cell = row.createCell(17);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(adjVO.getPaidAmount());

			cell = row.createCell(18);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(adjVO.getDiscountAmount());

			cell = row.createCell(19);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getSuspiciousRsv());
		}

		// excel 파일 저장
		try {
			String fileName = "탐나는전 정산_" + adjSVO.getsStartDt() + "~" + adjSVO.getsEndDt() + ".xlsx";
			response.setHeader("Content-Disposition", "attachment; filename=" + fileNameByBrowser(request, fileName));
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

	// 업체별 정산
	@RequestMapping("/oss/adjustExcelDown6.do")
	public void adjustExcelDown6(@ModelAttribute("searchVO") ADJSVO adjSVO,
								 HttpServletRequest request,
								 HttpServletResponse response) {

		String[] arrCpInfo = request.getParameterValues("couponText");
		List<String> arrCpId = new ArrayList<>();

		if (arrCpInfo != null) {
			for (int i = 0; i < arrCpInfo.length; i++){
				arrCpId.add(arrCpInfo[i].split("\\|")[0]);
			}
			adjSVO.setArrPartnerCode(arrCpId);
		}

		List<ADJVO> adjList;

		adjSVO.setsAdjDt(adjSVO.getsAdjDt().replaceAll("-", ""));
		adjList = ossAdjService.selectAdjList3(adjSVO);

		// Workbook 생성
//        Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

		// *** Sheet-------------------------------------------------
		// Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("업체별정산내역");

		// 컬럼 너비 설정
		int j = 0;
		sheet1.setColumnWidth(j++, 30*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 14*256);
		sheet1.setColumnWidth(j++, 16*256);

		sheet1.setColumnWidth(j++, 16*256);
		sheet1.setColumnWidth(j++, 20*256);

		sheet1.setColumnWidth(j++, 16*256);
		sheet1.setColumnWidth(j++, 20*256);
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
		cell.setCellValue("판매금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("지원 포인트금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("미지원 포인트금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("취소수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("판매수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("지원포인트 판매수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("지원포인트 정산금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("은행");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("계좌번호");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("예금주");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(j++);
		cell.setCellValue("상품구분");
		cell.setCellStyle(headerStyle);
		//---------------------------------

		for(int i = 0; i < adjList.size(); i++) {
			ADJVO adjVO = adjList.get(i);
			row = sheet1.createRow(i + 1);

			j = 0;
			cell = row.createCell(j++);
			cell.setCellValue(adjVO.getCorpNm());

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSupportedPointAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getUnsupportedPointAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCmssAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleCmss()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getPointCmssAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getPointJsYsAmt()));

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getBankNm());

			cell = row.createCell(j++);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getAccNum());

			cell = row.createCell(j++);
			cell.setCellValue(adjVO.getDepositor());

			cell = row.createCell(j++);
			cell.setCellValue(adjVO.getPrdtDiv());
		}

		// excel 파일 저장
		try {
			String fileName = "정산_쿠폰_";
			if(StringUtils.isNotEmpty(adjSVO.getsAdjDt())) {
				fileName += adjSVO.getsAdjDt();			// 주간
			} else {
				fileName += adjSVO.getsFromYear() + "_" + adjSVO.getsFromMonth();		// 월간
			}
			fileName += ".xlsx";

			response.setHeader("Content-Disposition", "attachment; filename=" + fileNameByBrowser(request, fileName));

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

	@RequestMapping("/oss/adjustExcelDown7.do")
	public void adjustExcelDown7(@ModelAttribute("searchVO") ADJSVO adjSVO,
								 HttpServletRequest request,
								 HttpServletResponse response) {

		String[] arrPointInfo = request.getParameterValues("couponText");
		List<String> arrPartnerCode = new ArrayList<>();

		if (arrPointInfo != null) {
			for (int i = 0; i < arrPointInfo.length; i++){
				arrPartnerCode.add(arrPointInfo[i].split("\\|")[0]);
			}
			adjSVO.setArrPartnerCode(arrPartnerCode);
		}

		adjSVO.setsAdjDt(adjSVO.getsAdjDt().replaceAll("-", ""));
		List<ADJDTLINFVO> adjList = ossAdjService.selectAdjInfList(adjSVO);

		// Workbook 생성
		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

		// *** Sheet-------------------------------------------------
		// Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("건별정산상세내역");

		// 컬럼 너비 설정
		sheet1.setColumnWidth(0, 30 * 256);
		sheet1.setColumnWidth(1, 30 * 256);
		sheet1.setColumnWidth(2, 50 * 256);
		sheet1.setColumnWidth(3, 20 * 256);
		sheet1.setColumnWidth(4, 20 * 256);
		sheet1.setColumnWidth(5, 20 * 256);
		sheet1.setColumnWidth(6, 20 * 256);
		sheet1.setColumnWidth(7, 20 * 256);
		sheet1.setColumnWidth(8, 20 * 256);
		sheet1.setColumnWidth(9, 20 * 256);
		sheet1.setColumnWidth(10, 20 * 256);
		sheet1.setColumnWidth(11, 20 * 256);
		sheet1.setColumnWidth(12, 50 * 256);
		sheet1.setColumnWidth(13, 20 * 256);
		// ----------------------------------------------------------

		XSSFCellStyle headerStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		headerStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		headerStyle.setAlignment(CellStyle.ALIGN_CENTER);

		XSSFCellStyle numericStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		XSSFDataFormat df = (XSSFDataFormat) xlsxWb.createDataFormat();
		numericStyle.setDataFormat(df.getFormat("#,##0"));

		CellStyle numericStyle2 = xlsxWb.createCellStyle();
		numericStyle2.setDataFormat(df.getFormat("0.0"));

		CellStyle centerStyle = xlsxWb.createCellStyle();
		centerStyle.setAlignment(CellStyle.ALIGN_CENTER);

		Row row;
		Cell cell;

		// 첫 번째 줄
		row = sheet1.createRow(0);

		// 첫 번째 줄에 Cell 설정하기-------------
		cell = row.createCell(0);
		cell.setCellValue("업체명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(1);
		cell.setCellValue("상품명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(2);
		cell.setCellValue("상품정보");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(3);
		cell.setCellValue("예약번호");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(4);
		cell.setCellValue("예약자");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(5);
		cell.setCellValue("예약결과");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(6);
		cell.setCellValue("판매금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(7);
		cell.setCellValue("지원 포인트금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(8);
		cell.setCellValue("미지원 포인트금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(9);
		cell.setCellValue("취소수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(10);
		cell.setCellValue("판매수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(11);
		cell.setCellValue("수수료율");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(12);
		cell.setCellValue("포인트 수수료");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(13);
		cell.setCellValue("포인트 정산금액");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(14);
		cell.setCellValue("포인트명");
		cell.setCellStyle(headerStyle);

		cell = row.createCell(15);
		cell.setCellValue("상품구분");
		cell.setCellStyle(headerStyle);
		
		cell = row.createCell(16);
		cell.setCellValue("이메일");
		cell.setCellStyle(headerStyle);

		//---------------------------------
		for (int i = 0; i < adjList.size(); i++) {
			ADJDTLINFVO adjVO = adjList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(adjVO.getCorpNm());

			cell = row.createCell(1);
			cell.setCellValue(adjVO.getPrdtNm());

			cell = row.createCell(2);
			cell.setCellValue(adjVO.getPrdtInf());

			cell = row.createCell(3);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getRsvNum());

			cell = row.createCell(4);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(adjVO.getRsvNm());

			String rsvStatusCd = adjVO.getRsvStatusCd();
			String rsvStatus = "";
			if(Constant.RSV_STATUS_CD_CCOM.equals(rsvStatusCd)) {
				rsvStatus = "취소";
			}else if(Constant.RSV_STATUS_CD_UCOM.equals(rsvStatusCd)) {
				rsvStatus = "사용완료";
			}else if(Constant.RSV_STATUS_CD_ECOM.equals(rsvStatusCd)) {
				rsvStatus = "기간만료";
			}else if(Constant.RSV_STATUS_CD_SCOM.equals(rsvStatusCd)) {
				rsvStatus = "부분환불완료";
			}

			cell = row.createCell(5);
			cell.setCellStyle(centerStyle);
			cell.setCellValue(rsvStatus);

			cell = row.createCell(6);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleAmt()));

			cell = row.createCell(7);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSupportedPointAmt()));

			cell = row.createCell(8);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getUnsupportedPointAmt()));

			cell = row.createCell(9);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getCmssAmt()));

			cell = row.createCell(10);
			cell.setCellStyle(numericStyle);
			cell.setCellValue(Integer.parseInt(adjVO.getSaleCmss()));

			cell = row.createCell(11);
			cell.setCellStyle(numericStyle2);
			cell.setCellValue(Double.parseDouble(adjVO.getAdjAplPct()));

			cell = row.createCell(12);
			cell.setCellValue(adjVO.getPointCmssAmt());

			cell = row.createCell(13);
			cell.setCellValue(adjVO.getPointJsYsAmt());

			cell = row.createCell(14);
			cell.setCellValue(adjVO.getPartnerNm());

			cell = row.createCell(15);
			cell.setCellValue(adjVO.getPrdtDiv());

			cell = row.createCell(16);
			cell.setCellValue(adjVO.getRsvEmail());
		}

		// excel 파일 저장
		try {
			String fileName = "건별정산_쿠폰_";
			if(EgovStringUtil.isEmpty(adjSVO.getsCorpId())) {
				fileName += adjSVO.getsAdjDt();
			}else{
				fileName += adjSVO.getsAdjDt() + "_" + adjSVO.getsCorpId();
			}
			fileName += ".xlsx";

			response.setHeader("Content-Disposition", "attachment; filename=" + fileNameByBrowser(request, fileName));

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
