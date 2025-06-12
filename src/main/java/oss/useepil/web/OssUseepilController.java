package oss.useepil.web;


import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mas.prmt.vo.PRMTCMTVO;
import mas.prmt.vo.PRMTVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.GPAANLSVO;
import oss.useepil.vo.USEEPILCMTVO;
import oss.useepil.vo.USEEPILIMGVO;
import oss.useepil.vo.USEEPILSVO;
import oss.useepil.vo.USEEPILVO;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;
import common.Constant;
import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.EgovWebUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class OssUseepilController {

    @Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name="ossUesepliService")
	private OssUesepliService ossUesepliService;

	@Resource(name="ossUserService")
	private OssUserService ossUserService;

    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

    Logger log = (Logger) LogManager.getLogger(this.getClass());

    @RequestMapping("/oss/useepilList.do")
    public String useepilList(@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    		ModelMap model){

    	useepilSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	useepilSVO.setPageSize(propertiesService.getInt("pageSize"));


		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(useepilSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(useepilSVO.getPageUnit());
		paginationInfo.setPageSize(useepilSVO.getPageSize());

		useepilSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		useepilSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		useepilSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//상품평 조회
		Map<String, Object> resultMap = ossUesepliService.selectUseepilList(useepilSVO);
		@SuppressWarnings("unchecked")
		List<USEEPILVO> resultList = (List<USEEPILVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

    	if (useepilSVO.getsCate() != null && !"".equals(useepilSVO.getsCate())){
			//코드 정보 얻기
			List<CDVO> cdRvtp = ossCmmService.selectCode(useepilSVO.getsCate().substring(0,2) + "RV");
			model.addAttribute("cdRvtp", cdRvtp);
		}
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

    	return "/oss/useepil/useepilList";
    }


    @RequestMapping("/oss/detailUseepil.do")
    public String detailUseepil(@ModelAttribute("USEEPILVO") USEEPILVO useepilVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    							ModelMap model){
    	//log.info("/oss/detailUseepil.do 호출");

    	//상품평 정보 읽기
    	USEEPILVO useepilVORes = ossUesepliService.selectByUseepil(useepilVO);

    	useepilVORes.setContents(EgovWebUtil.clearXSSMinimum(useepilVORes.getContents()) );
    	useepilVORes.setContents( useepilVORes.getContents().replaceAll("\n", "<br/>\n") );

    	model.addAttribute("data", useepilVORes);

    	USERVO userSVO = new USERVO();
		userSVO.setUserId( useepilVORes.getUserId() );
		USERVO userVO = ossUserService.selectByUser(userSVO);
		model.addAttribute("userVO", userVO);

		//상품평 이미지 얻기
		List<USEEPILIMGVO> imgList = ossUesepliService.selectUseepilImgListDiv(useepilVORes);
		model.addAttribute("imgList", imgList);

    	//상품평 답글 읽기
    	USEEPILCMTVO uecVO = new USEEPILCMTVO();
    	uecVO.setUseEpilNum( useepilVO.getUseEpilNum() );
    	List<USEEPILCMTVO> cmtlist = ossUesepliService.selectUseepCmtilListOne(uecVO);
    	for(USEEPILCMTVO cmt: cmtlist){
    		cmt.setContents(EgovWebUtil.clearXSSMinimum(cmt.getContents()) );
    		cmt.setContents( cmt.getContents().replaceAll("\n", "<br/>\n") );
    	}
    	model.addAttribute("cmtlist", cmtlist);

		//코드 정보 얻기
		List<CDVO> cdRvtp = ossCmmService.selectCode(useepilVORes.getPrdtnum().substring(0,2) + "RV");
		model.addAttribute("cdRvtp", cdRvtp);

    	return "/oss/useepil/detailUseepil";
    }


    @RequestMapping("/oss/useepilSaveExcel.do")
    public void useepilSaveExcel(@ModelAttribute("USEEPILVO") USEEPILVO useepilVO
								, @ModelAttribute("searchVO") USEEPILSVO useepilSVO
    							, HttpServletRequest request
    							, HttpServletResponse response){
    	log.info("/oss/useepilSaveExcel.do 호출");

    	@SuppressWarnings("unchecked")
    	List<USEEPILVO> resultList = ossUesepliService.selectUseepilListNopage(useepilSVO);

		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합

        // *** Sheet-------------------------------------------------
        // Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("상품평");

        // 컬럼 너비 설정
        sheet1.setColumnWidth( 0, 5000);		//업체ID
        sheet1.setColumnWidth( 1, 6000); 		//업체이름
		sheet1.setColumnWidth( 2, 5000);		//카테고리
		sheet1.setColumnWidth( 3, 4000);		//서브카테고리
        sheet1.setColumnWidth( 4, 4000);		//상품번호
        sheet1.setColumnWidth( 5, 6000);		//상품이름
        sheet1.setColumnWidth( 6, 5000);		//사용자ID
        sheet1.setColumnWidth( 7, 6000);		//이름
        sheet1.setColumnWidth( 8, 6000);		//전화번호
        sheet1.setColumnWidth( 9, 8000);		//이메일
		sheet1.setColumnWidth( 10, 5000);		//유형
        sheet1.setColumnWidth( 11, 8000);		//제목
        sheet1.setColumnWidth( 12, 18000);	//내용
        sheet1.setColumnWidth( 13, 6000);		//작성날짜
		sheet1.setColumnWidth( 14, 6000);		//수정날짜
        sheet1.setColumnWidth( 15, 3000);		//표시여부
        sheet1.setColumnWidth( 16, 3000);		//평점
        sheet1.setColumnWidth( 17, 3000);		//댓글
        sheet1.setColumnWidth( 18, 3000);		//이미지
        // ----------------------------------------------------------

		XSSFCellStyle cellStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;


        // 첫 번째 줄
        row = sheet1.createRow(0);

        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("업체ID");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(1);
        cell.setCellValue("업체명");
        cell.setCellStyle(cellStyle);

		cell = row.createCell(2);
		cell.setCellValue("카테고리");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(3);
		cell.setCellValue("sub 카테고리");
		cell.setCellStyle(cellStyle);

        cell = row.createCell(4);
        cell.setCellValue("상품ID");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(5);
        cell.setCellValue("상품명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(6);
        cell.setCellValue("사용자ID");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(7);
        cell.setCellValue("이름");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(8);
        cell.setCellValue("전화번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(9);
        cell.setCellValue("이메일");
        cell.setCellStyle(cellStyle);

		cell = row.createCell(10);
		cell.setCellValue("유형");
		cell.setCellStyle(cellStyle);

        cell = row.createCell(11);
        cell.setCellValue("제목");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(12);
        cell.setCellValue("내용");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(13);
        cell.setCellValue("작성날짜");
        cell.setCellStyle(cellStyle);

		cell = row.createCell(14);
		cell.setCellValue("수정날짜");
		cell.setCellStyle(cellStyle);

        cell = row.createCell(15);
        cell.setCellValue("표시여부");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(16);
        cell.setCellValue("평점");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(17);
        cell.setCellValue("댓글수");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(18);
        cell.setCellValue("이미지수");
        cell.setCellStyle(cellStyle);

        //---------------------------------
		for (int i = 0; i < resultList.size(); i++) {
			USEEPILVO data = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(data.getCorpId());

			cell = row.createCell(1);
			cell.setCellValue(data.getCorpNm());

			//카테고리
			cell = row.createCell(2);
			cell.setCellValue(data.getCate());

			cell = row.createCell(3);
			cell.setCellValue(data.getSubCate());

			cell = row.createCell(4);
			cell.setCellValue(data.getPrdtnum());

			cell = row.createCell(5);
			cell.setCellValue(data.getPrdtNm());

			cell = row.createCell(6);
			cell.setCellValue(data.getUserId());

			cell = row.createCell(7);
			cell.setCellValue(data.getUserNm());

			cell = row.createCell(8);
			cell.setCellValue(data.getTelNum());

			cell = row.createCell(9);
			cell.setCellValue(data.getEmail());

			//유형
			cell = row.createCell(10);
			cell.setCellValue(data.getReviewType());

			cell = row.createCell(11);
			cell.setCellValue(data.getSubject());

			cell = row.createCell(12);
			CellStyle cs = xlsxWb.createCellStyle();
			cs.setWrapText(true);
			cell.setCellStyle(cs);
			cell.setCellValue(data.getContents());

			cell = row.createCell(13);
			cell.setCellValue(data.getFrstRegDttm());

			cell = row.createCell(14);
			cell.setCellValue(data.getLastModDttm());

			cell = row.createCell(15);
			cell.setCellValue(data.getPrintYn());

			cell = row.createCell(16);
			cell.setCellValue(data.getGpa());

			cell = row.createCell(17);
			cell.setCellValue(data.getCmtCnt());

			cell = row.createCell(18);
			cell.setCellValue(data.getImgCnt());

		}


        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "상품평.xlsx";

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

    @RequestMapping("/oss/useepiUpdatePrint.do")
    public String useepiUpdatePrint(@ModelAttribute("USEEPILVO") USEEPILVO useepilVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    							ModelMap model){
    	//log.info("/oss/detailUseepil.do 호출");
    	//log.info("/oss/detailUseepil.do 호출:" + useepilVO.getUseEpilNum() + ":" + useepilVO.getPrintYn() );
    	ossUesepliService.updateUsespilByPrint(useepilVO);

    	//평점 평균 및 후기 수 다시 계산
    	GPAANLSVO gpaVO = new GPAANLSVO();
    	//log.info("============>"+ useepilVO.getPrdtnum().substring(0,2) );

    	if(Constant.ACCOMMODATION.equals( useepilVO.getPrdtnum().substring(0,2) )){
    		//숙소만 업체명 입력
        	gpaVO.setsCorpId(useepilVO.getCorpId());
        	gpaVO.setLinkNum(useepilVO.getCorpId());
    	}else{
    		gpaVO.setsPrdtNum(useepilVO.getPrdtnum());
        	gpaVO.setLinkNum(useepilVO.getPrdtnum());
    	}
    	ossUesepliService.mergeGpaanls(gpaVO);


    	return "redirect:/oss/detailUseepil.do?useEpilNum=" + useepilVO.getUseEpilNum() +"&pageIndex="+useepilSVO.getPageIndex();
    }


   	@RequestMapping("/oss/useepiCmtUpdateCPrint.do")
    public String useepiCmtUpdateCPrint(@ModelAttribute("USEEPILCMTVO") USEEPILCMTVO useepilCmtVO,
    							@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
    							ModelMap model){
    	//log.info("/oss/useepiCmtUpdateCPrint.do 호출");
    	log.info("/oss/useepiCmtUpdateCPrint.do 호출:" + useepilCmtVO.getCmtSn() + ":" + useepilCmtVO.getPrintYn()  + ":" + useepilCmtVO.getUseEpilNum() );
    	ossUesepliService.updateUsespilCmtByPrint(useepilCmtVO);

    	return "redirect:/oss/detailUseepil.do?useEpilNum=" + useepilCmtVO.getUseEpilNum() +"&pageIndex="+useepilSVO.getPageIndex();
    }


	@RequestMapping("/oss/useepilAdd.do")
	public String useepilAdd(ModelMap model){


/*
		//상품평 조회
		Map<String, Object> resultMap = ossUesepliService.selectUseepilList(useepilSVO);
		@SuppressWarnings("unchecked")
		List<USEEPILVO> resultList = (List<USEEPILVO>) resultMap.get("resultList");


		if (useepilSVO.getsCate() != null && !"".equals(useepilSVO.getsCate())){
			//코드 정보 얻기
			List<CDVO> cdRvtp = ossCmmService.selectCode(useepilSVO.getsCate().substring(0,2) + "RV");
			model.addAttribute("cdRvtp", cdRvtp);
		}
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
*/


		return "/oss/useepil/useepilAdd";
	}
}
