package mas.rsv.web;


import api.service.*;
import api.vo.*;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovWebUtil;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.cmmn.service.impl.ScheduleService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.AD_PRDTINFVO;
import mas.corp.vo.DLVCORPVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rsv.service.MasRsvService;
import mas.rsv.vo.SP_RSVHISTVO;
import modules.easypay.NmcLiteApprovalCancel;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpService;
import oss.corp.service.impl.CorpDAO;
import oss.corp.vo.CORPVO;
import oss.point.service.OssPointService;
import oss.point.vo.POINTVO;
import oss.user.vo.USERVO;
import web.mypage.service.WebMypageService;
import web.mypage.vo.RSVFILEVO;
import web.order.service.WebOrderService;
import web.order.vo.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 최영철
 * @since  2015. 9. 16.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 */
@Controller
public class MasRsvController {

    @Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

    @Resource(name="ossCmmService")
    private OssCmmService ossCmmService;

    @Resource(name="masRsvService")
    private MasRsvService masRsvService;

    @Resource(name="masRcPrdtService")
    private MasRcPrdtService masRcPrdtService;

    @Resource(name="webOrderService")
    private WebOrderService webOrderService;

    @Resource(name="masAdPrdtService")
    private MasAdPrdtService masAdPrdtService;

    @Resource(name="apiAdService")
    private APIAdService apiAdService;

    @Resource(name = "corpDAO")
	private CorpDAO corpDAO;

    @Resource(name="ossCorpService")
    private OssCorpService ossCorpService;

    @Resource(name = "apiService")
    private APIService apiService;

    @Resource(name = "apiLsService")
	private APILsService apiLsService;

	@Resource(name = "apiVpService")
	private APIVpService apiVpService;

	@Resource(name = "apiYjService")
	private APIYjService apiYjService;

    @Resource(name = "ScheduleService")
    private ScheduleService scheduleService;

	@Resource(name="apiGoodsFlowService")
	private APIGoodsFlowService apiGoodsFlowService;

	@Autowired APITLBookingService apitlBookingService;
	@Autowired WebMypageService webMypageService;

	@Resource(name="apiInsService")
	private APIInsService apiInsService;

	@Resource(name="apiRibbonService")
	private APIRibbonService apiRibbonService;

	@Resource(name="ossPointService")
	private OssPointService ossPointService;

	@Resource(name="apiOrcService")
	private APIOrcService apiOrcService;

    Logger log = (Logger) LogManager.getLogger(this.getClass());

    /**
     * 렌터카 예약내역 리스트
     * 파일명 : rcRsvList
     * 작성일 : 2015. 12. 9. 오후 7:04:23
     * 작성자 : 최영철
     * @param rsvSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/rsvList.do")
    public String rcRsvList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsCorpId(corpInfo.getCorpId());

    	rsvSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	rsvSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(rsvSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(rsvSVO.getPageUnit());
		paginationInfo.setPageSize(rsvSVO.getPageSize());

		rsvSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		rsvSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		rsvSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = masRsvService.selectRcRsvList(rsvSVO);

		@SuppressWarnings("unchecked")
		List<RC_RSVVO> resultList = (List<RC_RSVVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

    	RC_PRDTINFSVO prdtInfSVO = new RC_PRDTINFSVO();
    	prdtInfSVO.setsCorpId(corpInfo.getCorpId());
    	List<RC_PRDTINFVO> prdtList = masRcPrdtService.selectCarNmList(prdtInfSVO);

    	// 보험구분코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_ISR_DIV_CD);
    	model.addAttribute("isrDivCd", cdList);

		model.addAttribute("resultList", resultList);
		model.addAttribute("prdtList", prdtList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

    	return "/mas/rsv/rcRsvList";
    }

    /**
     * 렌터카 예약 리스트 Excel 출력
     * 파일명 : rsvExcelDown
     * 작성일 : 2017. 8. 7. 오전 9:15:14
     * 작성자 : 정동수
     * @param rsvSVO
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/mas/rc/rsvExcelDown.do")
    public void rcRsvExcelDown(@ModelAttribute("searchVO") RSVSVO rsvSVO,
							   HttpServletRequest request,
							   HttpServletResponse response){
    	log.info("/mas/rc/rsvExcelDown.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsCorpId(corpInfo.getCorpId());

    	List<RC_RSVVO> resultList = masRsvService.selectRcRsvListAll(rsvSVO);

		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상
        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("렌터카 예약내역");
        // 컬럼 너비 설정
        sheet1.setColumnWidth(0, 5000);
        sheet1.setColumnWidth(1, 3000);
        sheet1.setColumnWidth(2, 7000);
        sheet1.setColumnWidth(3, 6000);
        sheet1.setColumnWidth(4, 6000);
        sheet1.setColumnWidth(5, 5000);
        sheet1.setColumnWidth(6, 5000);
        sheet1.setColumnWidth(7, 5000);
        sheet1.setColumnWidth(8, 2500);
        sheet1.setColumnWidth(9, 2500);
        sheet1.setColumnWidth(10, 3000);
        sheet1.setColumnWidth(11, 2500);
		sheet1.setColumnWidth(12, 2500);
        // ----------------------------------------------------------
        CellStyle cellStyle = xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;
        // 첫 번째 줄
        row = sheet1.createRow(0);
        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("예약번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(1);
        cell.setCellValue("상품상태");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(2);
        cell.setCellValue("상품명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(3);
        cell.setCellValue("예약자");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(4);
        cell.setCellValue("사용자");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(5);
        cell.setCellValue("대여일시");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(6);
        cell.setCellValue("반납일시");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(7);
        cell.setCellValue("보험구분");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(8);
        cell.setCellValue("판매금액");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(9);
        cell.setCellValue("취소수수료");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(10);
        cell.setCellValue("예상정산액");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(11);
        cell.setCellValue("예약확인");
        cell.setCellStyle(cellStyle);

		cell = row.createCell(12);
		cell.setCellValue("결제수단");
		cell.setCellStyle(cellStyle);
        //---------------------------------
		for (int i = 0; i < resultList.size(); i++) {
			RC_RSVVO orderVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(orderVO.getRsvNum());

			String statusCdStr = "";
			if (Constant.RSV_STATUS_CD_READY.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "예약대기";
			} else if (Constant.RSV_STATUS_CD_EXP.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "예약불가";
			} else if (Constant.RSV_STATUS_CD_COM.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "예약";
			} else if (Constant.RSV_STATUS_CD_CREQ.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "고객취소요청";
			} else if (Constant.RSV_STATUS_CD_CREQ2.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "환불요청";
			} else if (Constant.RSV_STATUS_CD_CCOM.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "취소";
			} else if (Constant.RSV_STATUS_CD_UCOM.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "사용완료";
			} else if (Constant.RSV_STATUS_CD_ECOM.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "기간만료";
			} else if (Constant.RSV_STATUS_CD_ACC.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "자동취소";
			}
			cell = row.createCell(1);
			cell.setCellValue(statusCdStr);

			cell = row.createCell(2);
			cell.setCellValue(orderVO.getPrdtNm());

			cell = row.createCell(3);
			cell.setCellValue(orderVO.getRsvNm() + " / " + orderVO.getRsvTelnum());

			cell = row.createCell(4);
			cell.setCellValue(orderVO.getUseNm() + " / " + orderVO.getUseTelnum());

			cell = row.createCell(5);
			cell.setCellValue(orderVO.getRentStartDt().substring(0, 4) + "-" + orderVO.getRentStartDt().substring(4, 6) + "-" + orderVO.getRentStartDt().substring(6, 8) + " " + orderVO.getRentStartTm().substring(0, 2) + ":" + orderVO.getRentStartTm().substring(2, 4));

			cell = row.createCell(6);
			cell.setCellValue(orderVO.getRentEndDt().substring(0, 4) + "-" + orderVO.getRentEndDt().substring(4, 6) + "-" + orderVO.getRentEndDt().substring(6, 8) + " " + orderVO.getRentEndTm().substring(0, 2) + ":" + orderVO.getRentEndTm().substring(2, 4));

			// 보험구분코드
			String isrStr = "";
	    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_ISR_DIV_CD);

	    	for (CDVO cd : cdList) {
	    		if (cd.getCdNum().equals(orderVO.getIsrDiv())) {
	    			isrStr = cd.getCdNm();
	    			break;
	    		}
	    	}
	    	if ("ID10".equals(orderVO.getIsrDiv())) {
	    		if (Constant.RC_ISR_TYPE_GEN.equals(orderVO.getIsrTypeDiv())) {
	    			isrStr += ("(일반자차)");
	    		} else if (Constant.RC_ISR_TYPE_LUX.equals(orderVO.getIsrTypeDiv())) {
	    			isrStr += ("(고급자차)");
	    		}
	    	}
			cell = row.createCell(7);
			cell.setCellValue(isrStr);

			cell = row.createCell(8);
			cell.setCellValue(orderVO.getNmlAmt());

			cell = row.createCell(9);
			cell.setCellValue(orderVO.getCmssAmt());

			cell = row.createCell(10);
			cell.setCellValue(orderVO.getAdjAmt());

			String checkStr = Constant.FLAG_Y.equals(orderVO.getRsvIdtYn()) ? "O" : "";
			cell = row.createCell(11);
			cell.setCellValue(checkStr);

			cell = row.createCell(12);
			for ( Constant.PAY_DIV payDiv : Constant.PAY_DIV.values() ) {
				if(orderVO.getPayDiv().equals(payDiv.getCode())){
					cell.setCellValue(payDiv.getName());
				}
			}
		}
        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "렌터카 예약.xlsx";

    		String userAgent = request.getHeader("User-Agent");

    		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
    			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("MSIE") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("Trident") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("Android") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") );
    		} else if(userAgent.indexOf("Swing") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8")  + ";");
    		} else if(userAgent.indexOf("Mozilla/5.0") >= 0) {			// 크롬, 파폭
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
    		} else {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		ServletOutputStream fileOutput = response.getOutputStream();

            xlsxWb.write(fileOutput);
			fileOutput.flush();
            fileOutput.close();

        } catch (FileNotFoundException e) {
			e.printStackTrace();
			log.error(e);
        } catch (IOException e) {
			e.printStackTrace();
			log.error(e);
        }
    }

    /**
     * 렌터카 예약 상세
     * 파일명 : rcDetailRsv
     * 작성일 : 2015. 12. 14. 오후 1:03:14
     * 작성자 : 최영철
     * @param rsvSVO
     * @param rcRsvVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/rc/detailRsv.do")
    public String rcDetailRsv(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		@ModelAttribute("RCRSVVO") RC_RSVVO rcRsvVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rcRsvVO.setsCorpId(corpInfo.getCorpId());

    	RC_RSVVO resultVO = masRsvService.selectRcDetailRsv(rcRsvVO);
    	model.addAttribute("resultVO", resultVO);

		List<CDVO> cdRfac = ossCmmService.selectCode("RFAC");
		model.addAttribute("cdRfac", cdRfac);

    	//영수증 관련 처리
    	setRecPnt(resultVO.getRsvNum(), model);

		//취소 증빙자료
		RSVFILEVO rsvFileVO = new RSVFILEVO();
		rsvFileVO.setDtlRsvNum(rcRsvVO.getRcRsvNum());
		rsvFileVO.setCategory("PROVE");
		List<RSVFILEVO> rsvFileList = webMypageService.selectDtlRsvFileList(rsvFileVO);
		model.addAttribute("rsvFileList", rsvFileList);

		//취소 증빙자료
		rsvFileVO.setCategory("PROVE_OSS");
		List<RSVFILEVO> rsvFileList_OSS = webMypageService.selectDtlRsvFileList(rsvFileVO);
		model.addAttribute("rsvFileList_OSS", rsvFileList_OSS);


		return "/mas/rsv/rcDetailRsv";
    }

    @RequestMapping("/mas/ad/rsvList.do")
    public String adRsvList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsCorpId(corpInfo.getCorpId());

    	rsvSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	rsvSVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** paging setting */
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(rsvSVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(rsvSVO.getPageUnit());
    	paginationInfo.setPageSize(rsvSVO.getPageSize());

    	rsvSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	rsvSVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	rsvSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    	Map<String, Object> resultMap = masRsvService.selectAdRsvList(rsvSVO);

    	@SuppressWarnings("unchecked")
    	List<AD_RSVVO> resultList = (List<AD_RSVVO>) resultMap.get("resultList");

    	// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

    	model.addAttribute("resultList", resultList);
    	model.addAttribute("totalCnt", resultMap.get("totalCnt"));
    	model.addAttribute("paginationInfo", paginationInfo);


    	//객실 목록
    	AD_PRDTINFVO ad_PRDINFSVO = new AD_PRDTINFVO();
    	ad_PRDINFSVO.setCorpId(corpInfo.getCorpId());
    	List<AD_PRDTINFVO> adPrdtList = masAdPrdtService.selectAdPrdinfListOfRT(ad_PRDINFSVO);
    	model.addAttribute("prdtList", adPrdtList );

    	return "/mas/rsv/adRsvList";
    }

    /**
     * 숙박 예약 리스트 Excel 출력
     * 파일명 : rsvExcelDown
     * 작성일 : 2017. 8. 2. 오후 5:50:14
     * 작성자 : 정동수
     * @param rsvSVO
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/mas/ad/rsvExcelDown.do")
    public void adRsvExcelDown(@ModelAttribute("searchVO") RSVSVO rsvSVO,
							   HttpServletRequest request,
							   HttpServletResponse response){
    	log.info("/mas/ad/rsvExcelDown.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsCorpId(corpInfo.getCorpId());

    	List<AD_RSVVO> resultList = masRsvService.selectAdRsvListAll(rsvSVO);

		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상
        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("숙박 예약내역");
        // 컬럼 너비 설정
        sheet1.setColumnWidth(0, 5000);
        sheet1.setColumnWidth(1, 3000);
        sheet1.setColumnWidth(2, 7000);
        sheet1.setColumnWidth(3, 5000);
        sheet1.setColumnWidth(4, 2500);
        sheet1.setColumnWidth(5, 2500);
        sheet1.setColumnWidth(6, 2500);
        sheet1.setColumnWidth(7, 6000);
        sheet1.setColumnWidth(8, 6000);
        sheet1.setColumnWidth(9, 2500);
        sheet1.setColumnWidth(10, 2500);
        sheet1.setColumnWidth(11, 3000);
        sheet1.setColumnWidth(12, 2500);
		sheet1.setColumnWidth(13, 2500);
        // ----------------------------------------------------------
        CellStyle cellStyle = xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;
        // 첫 번째 줄
        row = sheet1.createRow(0);
        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("예약번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(1);
        cell.setCellValue("상품상태");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(2);
        cell.setCellValue("상품명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(3);
        cell.setCellValue("이용일자");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(4);
        cell.setCellValue("성인인원");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(5);
        cell.setCellValue("소인인원");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(6);
        cell.setCellValue("유아인원");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(7);
        cell.setCellValue("예약자");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(8);
        cell.setCellValue("사용자");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(9);
        cell.setCellValue("판매금액");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(10);
        cell.setCellValue("취소수수료");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(11);
        cell.setCellValue("예상정산액");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(12);
        cell.setCellValue("예약확인");
        cell.setCellStyle(cellStyle);

		cell = row.createCell(13);
		cell.setCellValue("결제내역");
		cell.setCellStyle(cellStyle);
        //---------------------------------
		for (int i = 0; i < resultList.size(); i++) {
			AD_RSVVO orderVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			// 개행 처리
			CellStyle cs = xlsxWb.createCellStyle();
		    cs.setWrapText(true);

			cell = row.createCell(0);
			cell.setCellStyle(cs);
			cell.setCellValue(orderVO.getRsvNum() + "\n(" + orderVO.getAdRsvNum() + ")");

			String statusCdStr = "";
			if (Constant.RSV_STATUS_CD_READY.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "예약대기";
			} else if (Constant.RSV_STATUS_CD_EXP.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "예약불가";
			} else if (Constant.RSV_STATUS_CD_COM.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "예약";
			} else if (Constant.RSV_STATUS_CD_CREQ.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "고객취소요청";
			} else if (Constant.RSV_STATUS_CD_CREQ2.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "환불요청";
			} else if (Constant.RSV_STATUS_CD_CCOM.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "취소";
			} else if (Constant.RSV_STATUS_CD_UCOM.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "사용완료";
			} else if (Constant.RSV_STATUS_CD_ECOM.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "기간만료";
			} else if (Constant.RSV_STATUS_CD_ACC.equals(orderVO.getRsvStatusCd())) {
				statusCdStr = "자동취소";
			}
			cell = row.createCell(1);
			cell.setCellValue(statusCdStr);

			cell = row.createCell(2);
			cell.setCellValue(orderVO.getPrdtNm());

			cell = row.createCell(3);
			cell.setCellValue(orderVO.getUseDt().substring(0, 4) + "-" + orderVO.getUseDt().substring(4, 6) + "-" + orderVO.getUseDt().substring(6, 8) + " ~ " + orderVO.getUseNight() + "박" );

			cell = row.createCell(4);
			cell.setCellValue(orderVO.getAdultNum());

			cell = row.createCell(5);
			cell.setCellValue(orderVO.getJuniorNum());

			cell = row.createCell(6);
			cell.setCellValue(orderVO.getChildNum());

			cell = row.createCell(7);
			cell.setCellValue(orderVO.getRsvNm() + " / " + orderVO.getRsvTelnum());

			cell = row.createCell(8);
			cell.setCellValue(orderVO.getUseNm() + " / " + orderVO.getUseTelnum());

			cell = row.createCell(9);
			cell.setCellValue(orderVO.getNmlAmt());

			cell = row.createCell(10);
			cell.setCellValue(orderVO.getCmssAmt());

			cell = row.createCell(11);
			cell.setCellValue(orderVO.getAdjAmt());

			String checkStr = Constant.FLAG_Y.equals(orderVO.getRsvIdtYn()) ? "O" : "";
			cell = row.createCell(12);
			cell.setCellValue(checkStr);

			cell = row.createCell(13);
			for ( Constant.PAY_DIV payDiv : Constant.PAY_DIV.values() ) {
				if(orderVO.getPayDiv().equals(payDiv.getCode())){
					cell.setCellValue(payDiv.getName());
				}
			}
		}
        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "숙박 예약.xlsx";

    		String userAgent = request.getHeader("User-Agent");

    		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
    			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("MSIE") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("Trident") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("Android") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") );
    		} else if(userAgent.indexOf("Swing") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8")  + ";");
    		} else if(userAgent.indexOf("Mozilla/5.0") >= 0){			// 크롬, 파폭
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
    		} else {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
    		ServletOutputStream fileOutput = response.getOutputStream();

            xlsxWb.write(fileOutput);
			fileOutput.flush();
            fileOutput.close();

        } catch (FileNotFoundException e) {
        	log.error(e);
            e.printStackTrace();
        } catch (IOException e) {
        	log.error(e);
            e.printStackTrace();
        }
    }


    @RequestMapping("/mas/ad/detailRsv.do")
    public String adDetailRsv(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		@ModelAttribute("ADRSVVO") AD_RSVVO adRsvVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	adRsvVO.setsCorpId(corpInfo.getCorpId());

    	AD_RSVVO resultVO = masRsvService.selectAdDetailRsv(adRsvVO);
    	model.addAttribute("resultVO", resultVO);

    	List<CDVO> cdRfac = ossCmmService.selectCode("RFAC");
		model.addAttribute("cdRfac", cdRfac);

    	//영수증 관련 처리
    	setRecPnt(resultVO.getRsvNum(), model);

		//취소 증빙자료
		RSVFILEVO rsvFileVO = new RSVFILEVO();
		rsvFileVO.setDtlRsvNum(adRsvVO.getAdRsvNum());
		rsvFileVO.setCategory("PROVE");
		List<RSVFILEVO> rsvFileList = webMypageService.selectDtlRsvFileList(rsvFileVO);
		model.addAttribute("rsvFileList", rsvFileList);

		//OSS 취소 증빙자료
		rsvFileVO.setCategory("PROVE_OSS");
		List<RSVFILEVO> rsvFileList_OSS = webMypageService.selectDtlRsvFileList(rsvFileVO);
		model.addAttribute("rsvFileList_OSS", rsvFileList_OSS);

    	return "/mas/rsv/adDetailRsv";
    }

    @RequestMapping("/mas/sp/rsvList.do")
    public String spRsvList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsCorpId(corpInfo.getCorpId());

    	rsvSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	rsvSVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** paging setting */
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(rsvSVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(rsvSVO.getPageUnit());
    	paginationInfo.setPageSize(rsvSVO.getPageSize());

    	rsvSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	rsvSVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	rsvSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    	Map<String, Object> resultMap = masRsvService.selectSpRsvList(rsvSVO);

    	@SuppressWarnings("unchecked")
    	List<SP_RSVVO> resultList = (List<SP_RSVVO>) resultMap.get("resultList");

    	// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

    	model.addAttribute("resultList", resultList);
    	model.addAttribute("totalCnt", resultMap.get("totalCnt"));
    	model.addAttribute("paginationInfo", paginationInfo);



    	return "/mas/rsv/spRsvList";
    }

    @RequestMapping("/mas/sp/detailRsv.do")
    public String spDetailRsv(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		@ModelAttribute("SPRSVVO") SP_RSVVO spRsvVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	spRsvVO.setsCorpId(corpInfo.getCorpId());

    	SP_RSVVO resultVO = masRsvService.selectSpDetailRsv(spRsvVO);

    	if(Constant.SP_PRDT_DIV_TOUR.equals(resultVO.getPrdtDiv()) || Constant.SP_PRDT_DIV_COUP.equals(resultVO.getPrdtDiv()))  {
    		List<SP_RSVHISTVO> spRsvhistList = masRsvService.selectSpRsvHistList(spRsvVO);
    		model.addAttribute("spRsvhistList", spRsvhistList);
    	}

    	model.addAttribute("resultVO", resultVO);

    	List<CDVO> cdRfac = ossCmmService.selectCode("RFAC");
		model.addAttribute("cdRfac", cdRfac);

    	//영수증 관련 처리
    	setRecPnt(resultVO.getRsvNum(), model);

    	//고객 취소 증빙자료
		RSVFILEVO rsvFileVO = new RSVFILEVO();
		rsvFileVO.setDtlRsvNum(spRsvVO.getSpRsvNum());
		rsvFileVO.setCategory("PROVE");
		List<RSVFILEVO> rsvFileList = webMypageService.selectDtlRsvFileList(rsvFileVO);
		model.addAttribute("rsvFileList", rsvFileList);

		//탐나오 취소 증빙자료
		rsvFileVO.setCategory("PROVE_OSS");
		List<RSVFILEVO> rsvFileList_OSS = webMypageService.selectDtlRsvFileList(rsvFileVO);
		model.addAttribute("rsvFileList_OSS", rsvFileList_OSS);

    	return "/mas/rsv/spDetailRsv";
    }

    /**
     * 렌터카 예약취소
     * 파일명 : rcCancelRsv
     * 작성일 : 2015. 12. 14. 오후 5:55:48
     * 작성자 : 최영철
     * @param rcRsvVO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/rc/cancelRsv.ajax")
    public ModelAndView rcCancelRsv(@ModelAttribute("RCRSVVO") RC_RSVVO rcRsvVO, HttpServletRequest request) throws Exception{
    	log.info("/mas/rc/cancelRsv.ajax Call : " + rcRsvVO.getRcRsvNum());

		/**
		 * 상품금액 : NML_AMT (업체가 판매한 금액),
		 * 구매금액 : SALE_AMT (고객이 결제한 금액),
		 * 취소수수료 : CMSS_AMT (취소발생시, 업체가 가져가는 금액)
		 * 취소금액 : CANCEL_AMT (취소발생시, 고객이 반환받는 금액)
		 * */

		/** 고객환불계좌 번호 set*/
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	String LGD_RFBANKCODE = request.getParameter("LGD_RFBANKCODE");
    	String LGD_RFACCOUNTNUM = request.getParameter("LGD_RFACCOUNTNUM");
    	String LGD_RFCUSTOMERNAME = request.getParameter("LGD_RFCUSTOMERNAME");

		/** 업체ID set*/
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rcRsvVO.setsCorpId(corpInfo.getCorpId());

		/** 상품정보 get */
    	RC_RSVVO rsvDtlVO = masRsvService.selectRcDetailRsv(rcRsvVO);

		/** 결과변수 init  */
    	PAYVO payResult = new PAYVO();
		String success = Constant.FLAG_N;
		String cancelDiv = "";
		String lpointCancelFlag = Constant.FLAG_N;
		String userIp = EgovClntInfo.getClntIP(request);

		/** 예약/취소요청 상태는 취소 불가 */
    	if(!(rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_COM) || rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_CREQ))){
    		payResult.setPayRstInf("취소가능한 예약 상태가 아닙니다.");
    		resultMap.put("success", "N");
        	resultMap.put("payResult", payResult);
        	ModelAndView mav = new ModelAndView("jsonView", resultMap);
        	return mav;
    	}

    	/** 그림API취소*/
		if(rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_COM) && Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && !Constant.FLAG_Y.equals(rcRsvVO.getForceCancel()) && Constant.RC_RENTCAR_COMPANY_GRI.equals(rsvDtlVO.getApiRentDiv())) {
			String cancelResult = apiService.cancelGrimRcRsv(rsvDtlVO.getRcRsvNum());
			if (!cancelResult.equals("Y")) {
				payResult.setPayRstInf(cancelResult);
				resultMap.put("success", "N");
				resultMap.put("apiError", "Y");
				resultMap.put("payResult", payResult);
				ModelAndView mav = new ModelAndView("jsonView", resultMap);
				return mav;
			}
		}

		/** 인스API취소*/
		if(rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_COM) && Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && !Constant.FLAG_Y.equals(rcRsvVO.getForceCancel()) && Constant.RC_RENTCAR_COMPANY_INS.equals(rsvDtlVO.getApiRentDiv())) {
			Boolean resultCancel = apiInsService.revcancel(rsvDtlVO);
			if (!resultCancel) {
				resultMap.put("success", "N");
				resultMap.put("apiError", "Y");
				resultMap.put("payResult", "API오류");
				ModelAndView mav = new ModelAndView("jsonView", resultMap);
				return mav;
			}
		}

		/** 리본API취소*/
		if(rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_COM) && Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && !Constant.FLAG_Y.equals(rcRsvVO.getForceCancel()) && Constant.RC_RENTCAR_COMPANY_RIB.equals(rsvDtlVO.getApiRentDiv())) {
			Boolean resultCancel = apiRibbonService.carCancel(rsvDtlVO);
			if (!resultCancel) {
				resultMap.put("success", "N");
				resultMap.put("apiError", "Y");
				resultMap.put("payResult", "API오류");
				ModelAndView mav = new ModelAndView("jsonView", resultMap);
				return mav;
			}
		}

		/** 오르카API취소*/
		if(rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_COM) && Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && !Constant.FLAG_Y.equals(rcRsvVO.getForceCancel()) && Constant.RC_RENTCAR_COMPANY_ORC.equals(rsvDtlVO.getApiRentDiv())) {
			Boolean resultCancel = apiOrcService.vehicleCancel(rsvDtlVO);
			if (!resultCancel) {
				resultMap.put("success", "N");
				resultMap.put("apiError", "Y");
				resultMap.put("payResult", "API오류");
				ModelAndView mav = new ModelAndView("jsonView", resultMap);
				return mav;
			}
		}

		/** 취소금액 : 상품금액 - (취소수수료 + 쿠폰금액)*/
    	String cancelAmt = String.valueOf(Integer.parseInt(rsvDtlVO.getNmlAmt()) - (Integer.parseInt(rcRsvVO.getCmssAmt()) + Integer.parseInt(rsvDtlVO.getDisAmt())));

		/** 취소수수료가 0원이면 구매금액이 취소 금액 */
		if("0".equals(rcRsvVO.getCmssAmt())){
			cancelAmt = rsvDtlVO.getSaleAmt();
		}

		/** L.Point 사용 금액 */
		LPOINTUSEINFVO lpointUseInfVO = new LPOINTUSEINFVO();
		lpointUseInfVO.setRsvNum(rcRsvVO.getRsvNum());
		lpointUseInfVO.setMaxSaleDtlRsvNum(rcRsvVO.getRcRsvNum());
		lpointUseInfVO.setCancelYn(Constant.FLAG_N);
		lpointUseInfVO.setRsvCancelYn(Constant.FLAG_N);
		lpointUseInfVO = webOrderService.selectLpointUsePoint(lpointUseInfVO);

		/** LPOINT 사용포인트 */
		if (lpointUseInfVO != null) {
			/** 취소금액이 LPOINT 이상 일 경우 LPOINT취소 */
			if((Integer.parseInt(cancelAmt) >= Integer.parseInt(lpointUseInfVO.getUsePoint()))){
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
				lpointCancelFlag = Constant.FLAG_Y;
			/** 취소금액이 LPOINT 미만이고, PG금액 초과면 환불 Case 4로 이동  */
			}else if((Integer.parseInt(cancelAmt) < Integer.parseInt(lpointUseInfVO.getUsePoint())) && Integer.parseInt(cancelAmt) > (Integer.parseInt(rsvDtlVO.getSaleAmt()) - Integer.parseInt(lpointUseInfVO.getUsePoint())) ){
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
			}
		}

		/** 파트너(협력사) 포인트 사용 금액 조회*/
		POINTVO pointVO = new POINTVO();
		pointVO.setTypes("USE");
		pointVO.setRsvNum(rcRsvVO.getRsvNum());
		pointVO.setDtlRsvNum(rcRsvVO.getRcRsvNum());
		POINTVO selPointVO = ossPointService.selectUsePoint(pointVO);

		String pointEx = Constant.FLAG_N;
		if (selPointVO != null) {
			if (selPointVO.getUsePoint() > 0) {
				//사용 포인트가 취소수수료보다 크면 포인트에서 먼저 차감.
				if (selPointVO.getUsePoint() >= Integer.parseInt(rcRsvVO.getCmssAmt())) {
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - (selPointVO.getUsePoint() - Integer.parseInt(rcRsvVO.getCmssAmt())));
				}

				//쿠폰이 있는상태에서 수수료 전체 취소 일 경우
//				if (Integer.parseInt(cancelAmt) < 0) {
//					pointEx = Constant.FLAG_Y;
//				}
			}
		}

		/** Case 1 : 취소수수료 0원 처리 */
		if("0".equals(rcRsvVO.getCmssAmt())){
			log.info("cmss = 0");
			/** 토스결제취소 */
			Map<String, Object> payResultMap = masRsvService.cancelPay(rcRsvVO.getPayDiv(), rcRsvVO.getRsvNum(), rcRsvVO.getRcRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);
			payResult = (PAYVO) payResultMap.get("payResult");
			success = (String) payResultMap.get("success");
			cancelDiv = "1";

			/** 탐나는전결제취소 */
			if(Constant.PAY_DIV_TC_WI.equals(rcRsvVO.getPayDiv()) || Constant.PAY_DIV_TC_MI.equals(rcRsvVO.getPayDiv())){
				success =  cancelTamnacard(rcRsvVO.getRsvNum(), cancelAmt);
			}

			/** 취소완료건에 대해 예약건 업데이트 */
			if(Constant.FLAG_Y.equals(success)){
				rcRsvVO.setCancelAmt(rsvDtlVO.getSaleAmt());
				// RSV_STATUS_CD_CCOM(RS20 : 취소)
				rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

				rcRsvVO.setCmssAmt("0");
				rcRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
				webOrderService.updateRcCancelDtlRsv(rcRsvVO);
				// 쿠폰 취소처리
				webOrderService.cancelUserCp(rcRsvVO.getRcRsvNum());

				// 통합 예약건에 대한 처리
				RSVVO rsvVO = new RSVVO();
				rsvVO.setRsvNum(rcRsvVO.getRsvNum());
				rsvVO.setTotalCancelAmt(rsvDtlVO.getSaleAmt());
				rsvVO.setTotalCmssAmt("0");
				rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());

				rsvVO.setModIp(userIp);
				masRsvService.updateCancelRsv(rsvVO);
			}

		}
		/** Case 2 : 취소수수료 100% 처리*/
		else if(rsvDtlVO.getNmlAmt().equals(rcRsvVO.getCmssAmt())){
			log.info("수수료 100% 처리");
			cancelDiv = "1";

			// 수수료가 100%인 경우에는 예약 상태만 취소 처리함.
			rcRsvVO.setCancelAmt("0");
			rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);
			rcRsvVO.setDisCancelAmt("0");
			webOrderService.updateRcCancelDtlRsv(rcRsvVO);

			// 통합 예약건에 대한 처리
			RSVVO rsvVO = new RSVVO();
			rsvVO.setRsvNum(rcRsvVO.getRsvNum());
			rsvVO.setTotalCancelAmt("0");
			rsvVO.setTotalCmssAmt(rcRsvVO.getCmssAmt());
			rsvVO.setTotalDisCancelAmt("0");

			rsvVO.setModIp(userIp);
			masRsvService.updateCancelRsv(rsvVO);

			success = Constant.FLAG_Y;
		}
		/** Case 3 : 취소수수료 100% 처리 (쿠폰 & L.Point가 포함되어있는경우 ) */
		else if(rsvDtlVO.getSaleAmt().equals(rcRsvVO.getCmssAmt())){
			log.info("saleAmt & cmss = 100%");
			cancelDiv = "1";
			/** 수수료가 100%인 경우에는 예약 상태만 취소 처리함. */
			rcRsvVO.setCancelAmt("0");
			rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);
			rcRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
			webOrderService.updateRcCancelDtlRsv(rcRsvVO);
			// 쿠폰 취소처리
			webOrderService.cancelUserCp(rcRsvVO.getRcRsvNum());

			// 통합 예약건에 대한 처리
			RSVVO rsvVO = new RSVVO();
			rsvVO.setRsvNum(rcRsvVO.getRsvNum());
			rsvVO.setTotalCancelAmt("0");
			rsvVO.setTotalCmssAmt(rcRsvVO.getCmssAmt());
			rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());

			rsvVO.setModIp(userIp);
			masRsvService.updateCancelRsv(rsvVO);

			success = Constant.FLAG_Y;
		}
		/** Case 4 : 취소금액이 마이너스 금액 처리(쿠폰 & L.Point가 포함되어있는경우)*/
		else if(Integer.parseInt(cancelAmt) < 0){
			log.info("cancelAmt < 0");
			cancelDiv = "1";
			/** 취소금액 = 상품금액 - 취소 수수료 */
			cancelAmt = String.valueOf(Integer.parseInt(rsvDtlVO.getNmlAmt()) - Integer.parseInt(rcRsvVO.getCmssAmt()));

			/** Case 4-1 : 취소금액이 쿠폰금액보다 크거나 같은 경우,쿠폰 취소 처리 */
			if (Integer.parseInt(cancelAmt) >= Integer.parseInt(rsvDtlVO.getDisAmt())) {
				log.info("Case 4-1");
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(rsvDtlVO.getDisAmt()));
				webOrderService.cancelUserCp(rsvDtlVO.getRcRsvNum());
			}

			/** Case 4-2 : 취소금액-쿠폰금액이 L.Point 사용금액보다 크거나 같은 경우, L.Point 취소 처리 */
			if (lpointUseInfVO != null) {
				/** 취소금액이 LPOINT 이상 일 경우 LPOINT취소 */
				if((Integer.parseInt(cancelAmt) >= Integer.parseInt(lpointUseInfVO.getUsePoint()))){
					log.info("Case 4-2-1");
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
					lpointCancelFlag = Constant.FLAG_Y;
				/** 취소금액이 LPOINT 미만이고, PG금액 초과면 환불 */
				}else if((Integer.parseInt(cancelAmt) < Integer.parseInt(lpointUseInfVO.getUsePoint())) && Integer.parseInt(cancelAmt) > (Integer.parseInt(rsvDtlVO.getSaleAmt()) - Integer.parseInt(lpointUseInfVO.getUsePoint())) ){
					log.info("Case 4-2-2");
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
				}
			}

			if (Integer.parseInt(cancelAmt) > 0) {
				log.info("Case 4-3");
				Map<String, Object> payResultMap = masRsvService.cancelPay(rcRsvVO.getPayDiv(), rcRsvVO.getRsvNum(), rcRsvVO.getRcRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);
				payResult = (PAYVO) payResultMap.get("payResult");
				success = (String) payResultMap.get("success");
			} else {
				success = Constant.FLAG_N;
			}
			/** 취소완료건에 대해 예약건 업데이트 */
			if(Constant.FLAG_Y.equals(success)){
				// RSV_STATUS_CD_CCOM(RS20 : 취소)
				rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

				// 취소금액
				rcRsvVO.setCancelAmt(cancelAmt);
				rcRsvVO.setDisCancelAmt("0");
				webOrderService.updateRcCancelDtlRsv(rcRsvVO);

				// 통합 예약건에 대한 처리
				RSVVO rsvVO = new RSVVO();
				rsvVO.setRsvNum(rcRsvVO.getRsvNum());
				rsvVO.setTotalCancelAmt(cancelAmt);
				rsvVO.setTotalCmssAmt(rcRsvVO.getCmssAmt());
				rsvVO.setTotalDisCancelAmt("0");

				rsvVO.setModIp(userIp);
				masRsvService.updateCancelRsv(rsvVO);
			}
		/** 부분취소 */
		}else{
			log.info("last case");
			/** 부분취소 처리가능한 결제만, 부분취소 불가능한 결제(탐나는전)은 환불로 떨어짐 */
			if(Constant.PAY_DIV_LG_CI.equals(rsvDtlVO.getPayDiv())|| Constant.PAY_DIV_LG_KI.equals(rsvDtlVO.getPayDiv())|| Constant.PAY_DIV_LG_TI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_MI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_TA_PI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_NP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_KP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_AP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_TP.equals(rsvDtlVO.getPayDiv())){
				/** 토스결제취소 */
				Map<String, Object> payResultMap = masRsvService.cancelPay(rcRsvVO.getPayDiv(), rcRsvVO.getRsvNum(), rcRsvVO.getRcRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);
				payResult = (PAYVO) payResultMap.get("payResult");
				success = (String) payResultMap.get("success");
				cancelDiv = "1";

				// 취소완료건에 대해 예약건 업데이트
				if(Constant.FLAG_Y.equals(success)){
					// RSV_STATUS_CD_CCOM(RS20 : 취소)
					rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

					// 취소금액
					rcRsvVO.setCancelAmt(cancelAmt);
					rcRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
					webOrderService.updateRcCancelDtlRsv(rcRsvVO);
					// 쿠폰 취소처리
					webOrderService.cancelUserCp(rcRsvVO.getRcRsvNum());

					// 통합 예약건에 대한 처리
					RSVVO rsvVO = new RSVVO();
					rsvVO.setRsvNum(rcRsvVO.getRsvNum());
					rsvVO.setTotalCancelAmt(cancelAmt);
					rsvVO.setTotalCmssAmt(rcRsvVO.getCmssAmt());
					rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());

					rsvVO.setModIp(userIp);
					masRsvService.updateCancelRsv(rsvVO);
				}
			/** 부분취소 불가능 처리(탐나는전,휴대폰)*/
			}else{
				resultMap.put("success", "Y");
				payResult.setPayRstInf("취소성공");
			}
		}

    	// 처리가 정상적이지 않은 경우 환불요청 처리
    	if(Constant.FLAG_N.equals(success)){
    		// RSV_STATUS_CD_CREQ2(RS11 : 환불요청)
    		rcRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CREQ2);
    		cancelDiv = "2";

    		// 취소금액
    		rcRsvVO.setCancelAmt(cancelAmt);
    		rcRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
    		webOrderService.updateRcCancelDtlRsv(rcRsvVO);

    		success = Constant.FLAG_Y;
    	}
    	// 취소 정상 처리건에 대해 렌터카 이용내역 테이블에서 삭제
    	else{
    		webOrderService.deleteRcUseHist(rcRsvVO);
    		// 판매 통계 감소 처리
    		webOrderService.downSaleAnlsByDtlRsv(rsvDtlVO.getRcRsvNum());
    	}

    	//문자/메일 전송
    	webOrderService.cancelRsvAutoSnedSMSEmail(rsvDtlVO.getRcRsvNum(), request);

    	// L.Point 포인트 사용 취소
    	if (Constant.FLAG_Y.equals(lpointCancelFlag)) {
    		scheduleService.lpointUseCancel(lpointUseInfVO);
    	}

		/** 파트너(협력사) 포인트 사용 취소 */
		if (selPointVO != null && Constant.FLAG_Y.equals(success)) {
			if (selPointVO.getUsePoint() > 0) {
				selPointVO.setTypes("CANCEL");
				selPointVO.setContents("ALL_CANCEL"); //전체취소
				selPointVO.setPlusMinus("P");
				selPointVO.setPoint(selPointVO.getUsePoint());
				selPointVO.setCorpId(corpInfo.getCorpId());

				//1. 포인트 사용 전체 취소 처리
				ossPointService.insertPointCpSave(selPointVO);

				//2. 포인트 부분취소일 경우 처리
				if (Integer.parseInt(rcRsvVO.getCmssAmt()) > 0 && Constant.FLAG_N.equals(pointEx)) {
					selPointVO.setTypes("USE");
					selPointVO.setContents("CMSS_AMT"); // 수수료 사용 처리
					selPointVO.setPlusMinus("M");

					if (Integer.parseInt(rcRsvVO.getCmssAmt()) <= selPointVO.getUsePoint()) { //포인트 사용액이 더 많으면 수수료 전체 차감
						selPointVO.setPoint(Integer.parseInt(rcRsvVO.getCmssAmt()));
					} else { //포인트 사용액이 더 적으면 사용한 포인트만큼 차감
						selPointVO.setPoint(selPointVO.getUsePoint());
					}
					ossPointService.insertPointCpSave(selPointVO);
				}
			}
		}

    	resultMap.put("cancelDiv", cancelDiv);
    	resultMap.put("success", success);
    	resultMap.put("payResult", payResult);

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

   		return mav;
    }

    /**
     * 소셜상품 예약취소
     * 파일명 : spCancelRsv
     * 작성일 : 2015. 12. 14. 오후 5:55:48
     * 작성자 : 최영철
     * @param spRsvVO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/sp/cancelRsv.ajax")
		public ModelAndView spCancelRsv(@ModelAttribute("SPRSVVO") SP_RSVVO spRsvVO, HttpServletRequest request) throws Exception{
			log.info("/mas/sp/cancelRsv.ajax Call : " + spRsvVO.getSpRsvNum());
    	
    	/** 
		 * 상품금액 : NML_AMT (업체가 판매한 금액),
		 * 구매금액 : SALE_AMT (고객이 결제한 금액),
		 * 취소수수료 : CMSS_AMT (취소발생시, 업체가 가져가는 금액)
		 * 취소금액 : CANCEL_AMT (취소발생시, 고객이 반환받는 금액)
		 * */

    	/** 고객환불계좌 번호 set*/
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	String LGD_RFBANKCODE = request.getParameter("LGD_RFBANKCODE");
    	String LGD_RFACCOUNTNUM = request.getParameter("LGD_RFACCOUNTNUM");
    	String LGD_RFCUSTOMERNAME = request.getParameter("LGD_RFCUSTOMERNAME");

    	/** 업체ID set*/
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	spRsvVO.setsCorpId(corpInfo.getCorpId());

    	/** 상품정보 get */
    	SP_RSVVO rsvDtlVO = masRsvService.selectSpDetailRsv(spRsvVO);

    	/** 결과변수 init  */
    	PAYVO payResult = new PAYVO();
    	String success = Constant.FLAG_N;
    	/** 취소(cancelDiv = 1), 환불(cancelDiv = 2)
		 *  PG사에서 정상적으로 처리가 불가능한 경우, 여기서는 환불이라고 한다. */
    	String cancelDiv = "";
    	String lpointCancelFlag = Constant.FLAG_N;
    	String userIp = EgovClntInfo.getClntIP(request);

    	/** LS컴퍼니 상품 취소 */
		if("Y".equals(rsvDtlVO.getLsLinkYn()) && rsvDtlVO.getLsLinkOptPincode() != null && !"".equals(rsvDtlVO.getLsLinkOptPincode())){
			log.info("lsCompany requst cancel : lsCompany requst cancel : " + "spRsvNum=" +rsvDtlVO.getSpRsvNum()  +  "pincode=" +rsvDtlVO.getLsLinkOptPincode());
			APILSVO apilsVO = new APILSVO();
			apilsVO.setSpRsvNum(spRsvVO.getSpRsvNum());
			int j = Integer.parseInt(rsvDtlVO.getBuyNum()) - Integer.parseInt(rsvDtlVO.getUseNum()) ;
			log.info("lsCompany requst cancel cnt : " + j );
			apilsVO.setTransactionId(rsvDtlVO.getLsLinkOptPincode());
			apilsVO.setBuyNum(Integer.parseInt(rsvDtlVO.getBuyNum()));
			APILSRECIEVEVO apilsResultVO = apiLsService.requestCancelLsCompany(apilsVO);

			if(!"0000".equals(apilsResultVO.getResultCode())){
				payResult.setPayRstInf(apilsResultVO.getResultMessage());
				resultMap.put("success", "N");
				resultMap.put("payResult", payResult);
				ModelAndView mav = new ModelAndView("jsonView", resultMap);
				return mav;
			}
		}

		/** 브이패스 상품 취소 */
		if("V".equals(rsvDtlVO.getLsLinkYn()) && rsvDtlVO.getLsLinkOptPincode() != null && !"".equals(rsvDtlVO.getLsLinkOptPincode())){
			log.info("vpass requst cancel : " + "spRsvNum=" +rsvDtlVO.getSpRsvNum()  +  "pincode=" +rsvDtlVO.getLsLinkOptPincode());
			APILSVO apilsVO = new APILSVO();
			apilsVO.setRsvNum(spRsvVO.getRsvNum());
			apilsVO.setSpRsvNum(spRsvVO.getSpRsvNum());
			int j = Integer.parseInt(rsvDtlVO.getBuyNum()) - Integer.parseInt(rsvDtlVO.getUseNum());
			log.info("vpass requst cancel cnt : " + j );
			apilsVO.setTransactionId(rsvDtlVO.getLsLinkOptPincode());
			apilsVO.setBuyNum(j);
			APILSRECIEVEVO apilsResultVO = apiVpService.requestCancelVpCompany(apilsVO);

			if(!"0000".equals(apilsResultVO.getResultCode())){
				payResult.setPayRstInf(apilsResultVO.getResultMessage());
				resultMap.put("success", "N");
				resultMap.put("payResult", payResult);
				ModelAndView mav = new ModelAndView("jsonView", resultMap);
				return mav;
			}
		}

		/** 야놀자 상품 취소 */
		if("J".equals(rsvDtlVO.getLsLinkYn())){
			log.info("yanolja requst cancel : " + "spRsvNum=" +rsvDtlVO.getSpRsvNum()  +  "pincode=" +rsvDtlVO.getLsLinkOptPincode());
			APILSVO apilsVO = new APILSVO();
			apilsVO.setRsvNum(spRsvVO.getRsvNum());
			apilsVO.setSpRsvNum(spRsvVO.getSpRsvNum());
			int j = Integer.parseInt(rsvDtlVO.getBuyNum()) - Integer.parseInt(rsvDtlVO.getUseNum()) ;
			log.info("yanolja requst cancel cnt : " + j );
			apilsVO.setTransactionId(rsvDtlVO.getLsLinkOptPincode());
			apilsVO.setBuyNum(j);
			APILSRECIEVEVO apilsResultVO = apiYjService.requestCancelYj(apilsVO);

			if(!"0000".equals(apilsResultVO.getResultCode())){
				payResult.setPayRstInf(apilsResultVO.getResultMessage());
				resultMap.put("success", "N");
				resultMap.put("payResult", payResult);
				ModelAndView mav = new ModelAndView("jsonView", resultMap);
				return mav;
			}
		}

    	/** 예약/취소요청 상태는 취소 불가 */
    	if(!(rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_COM) || rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_CREQ))){
    		payResult.setPayRstInf("취소가능한 예약 상태가 아닙니다.");
    		resultMap.put("success", "N");
        	resultMap.put("payResult", payResult);
        	ModelAndView mav = new ModelAndView("jsonView", resultMap);
        	return mav;
    	}

    	/** 취소금액 : 상품금액 - (취소수수료 + 쿠폰금액)*/
    	String cancelAmt = String.valueOf(Integer.parseInt(rsvDtlVO.getNmlAmt()) - (Integer.parseInt(spRsvVO.getCmssAmt()) + Integer.parseInt(rsvDtlVO.getDisAmt())));

		/** 취소수수료가 0원이면 구매금액이 취소 금액 */
		if("0".equals(spRsvVO.getCmssAmt())){
			cancelAmt = rsvDtlVO.getSaleAmt();
		}

		/** L.Point 사용 금액 */
		LPOINTUSEINFVO lpointUseInfVO = new LPOINTUSEINFVO();
		lpointUseInfVO.setRsvNum(spRsvVO.getRsvNum());
		lpointUseInfVO.setMaxSaleDtlRsvNum(spRsvVO.getSpRsvNum());
		lpointUseInfVO.setCancelYn(Constant.FLAG_N);
		lpointUseInfVO.setRsvCancelYn(Constant.FLAG_N);
		lpointUseInfVO = webOrderService.selectLpointUsePoint(lpointUseInfVO);

		if (lpointUseInfVO != null) {
			/** 취소금액이 LPOINT 이상 일 경우 LPOINT취소 */
			if((Integer.parseInt(cancelAmt) >= Integer.parseInt(lpointUseInfVO.getUsePoint()))){
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
				lpointCancelFlag = Constant.FLAG_Y;
			/** 취소금액이 LPOINT 미만이고, PG금액 초과면 환불 Case 4로 이동  */
			}else if((Integer.parseInt(cancelAmt) < Integer.parseInt(lpointUseInfVO.getUsePoint())) && Integer.parseInt(cancelAmt) > (Integer.parseInt(rsvDtlVO.getSaleAmt()) - Integer.parseInt(lpointUseInfVO.getUsePoint())) ){
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
			}
		}

		/** 파트너(협력사) 포인트 사용 금액 조회*/
		POINTVO pointVO = new POINTVO();
		pointVO.setTypes("USE");
		pointVO.setRsvNum(spRsvVO.getRsvNum());
		pointVO.setDtlRsvNum(spRsvVO.getSpRsvNum());
		POINTVO selPointVO = ossPointService.selectUsePoint(pointVO);

		String pointEx = Constant.FLAG_N;
		if (selPointVO != null) {
			System.out.println("cancelAmt1=" + cancelAmt);
			System.out.println(selPointVO.getUsePoint());
			System.out.println(spRsvVO.getCmssAmt());

			if (selPointVO.getUsePoint() > 0) {
				//사용 포인트가 취소수수료보다 크면 포인트에서 먼저 차감.
				if (selPointVO.getUsePoint() >= Integer.parseInt(spRsvVO.getCmssAmt())) {
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - (selPointVO.getUsePoint() - Integer.parseInt(spRsvVO.getCmssAmt())));
				}
				//쿠폰이 있는상태에서 수수료 전체 취소 일 경우
//				if (Integer.parseInt(cancelAmt) < 0) {
//					pointEx = Constant.FLAG_Y;
//				}
			}
		}

		/** Case 1 : 취소수수료 0원 처리 */
		if("0".equals(spRsvVO.getCmssAmt())){
			log.info("cmss = 0");
			/** 토스결제취소 */
			Map<String, Object> payResultMap = masRsvService.cancelPay(spRsvVO.getPayDiv(), spRsvVO.getRsvNum(), spRsvVO.getSpRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME );
			payResult = (PAYVO) payResultMap.get("payResult");
			success = (String) payResultMap.get("success");
			cancelDiv = "1";

			/** 탐나는전결제취소 */
			if(Constant.PAY_DIV_TC_WI.equals(spRsvVO.getPayDiv()) || Constant.PAY_DIV_TC_MI.equals(spRsvVO.getPayDiv())){
				success =  cancelTamnacard(spRsvVO.getRsvNum(), cancelAmt);
			}

			/** 취소완료건에 대해 예약건 업데이트 */
			if(Constant.FLAG_Y.equals(success)){
				spRsvVO.setCancelAmt(rsvDtlVO.getSaleAmt());
				spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

				spRsvVO.setCmssAmt("0");
				spRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
				webOrderService.updateSpCancelDtlRsv(spRsvVO);
				// 쿠폰 취소처리
				webOrderService.cancelUserCp(spRsvVO.getSpRsvNum());

				// 통합 예약건에 대한 처리
				RSVVO rsvVO = new RSVVO();
				rsvVO.setRsvNum(spRsvVO.getRsvNum());
				rsvVO.setTotalCancelAmt(rsvDtlVO.getSaleAmt());
				rsvVO.setTotalCmssAmt("0");
				rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());
				rsvVO.setModIp(userIp);
				masRsvService.updateCancelRsv(rsvVO);
			}
		}
		/** Case 2 : 취소수수료 100% 처리*/
		else if(rsvDtlVO.getNmlAmt().equals(spRsvVO.getCmssAmt())){
			log.info("nmlAmt & cmss = 100%");
			cancelDiv = "1";

			// 수수료가 100%인 경우에는 예약 상태만 취소 처리함.
			spRsvVO.setCancelAmt("0");
			spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);
			spRsvVO.setDisCancelAmt("0");
			webOrderService.updateSpCancelDtlRsv(spRsvVO);

			// 통합 예약건에 대한 처리
			RSVVO rsvVO = new RSVVO();
			rsvVO.setRsvNum(spRsvVO.getRsvNum());
			rsvVO.setTotalCancelAmt("0");
			rsvVO.setTotalCmssAmt(spRsvVO.getCmssAmt());
			rsvVO.setTotalDisCancelAmt("0");

			rsvVO.setModIp(userIp);
			masRsvService.updateCancelRsv(rsvVO);

			success = Constant.FLAG_Y;
		}
		/** Case 3 : 취소수수료 100% 처리 (쿠폰 & L.Point가 포함되어있는경우 ) */
		else if(rsvDtlVO.getSaleAmt().equals(spRsvVO.getCmssAmt())){
			log.info("saleAmt & cmss = 100%");
			cancelDiv = "1";
			/** 수수료가 100%인 경우에는 예약 상태만 취소 처리함. */
			spRsvVO.setCancelAmt("0");
			spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

			// 수수료 금액
			spRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
			webOrderService.updateSpCancelDtlRsv(spRsvVO);
			// 쿠폰 취소처리
			webOrderService.cancelUserCp(spRsvVO.getSpRsvNum());

			// 통합 예약건에 대한 처리
			RSVVO rsvVO = new RSVVO();
			rsvVO.setRsvNum(spRsvVO.getRsvNum());
			rsvVO.setTotalCancelAmt("0");
			rsvVO.setTotalCmssAmt(spRsvVO.getCmssAmt());
			rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());

			rsvVO.setModIp(userIp);
			masRsvService.updateCancelRsv(rsvVO);

			success = Constant.FLAG_Y;
		}
		/** Case 4 : 취소금액이 마이너스 금액 처리(쿠폰 & L.Point가 포함되어있는경우)*/
		else if(Integer.parseInt(cancelAmt) < 0){
			log.info("cancelAmt < 0");
			cancelDiv = "1";
			/** 취소금액 = 상품금액 - 취소 수수료 */
			cancelAmt = String.valueOf(Integer.parseInt(rsvDtlVO.getNmlAmt()) - Integer.parseInt(spRsvVO.getCmssAmt()));

			/** Case 4-1 : 취소금액이 쿠폰금액보다 크거나 같은 경우,쿠폰 취소 처리 */
			if (Integer.parseInt(cancelAmt) >= Integer.parseInt(rsvDtlVO.getDisAmt())) {
				log.info("Case 4-1");
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(rsvDtlVO.getDisAmt()));
				webOrderService.cancelUserCp(spRsvVO.getSpRsvNum());
			}

			/** Case 4-2 : 취소금액-쿠폰금액이 L.Point 사용금액보다 크거나 같은 경우, L.Point 취소 처리 */
			if (lpointUseInfVO != null) {
				/** 취소금액이 LPOINT 이상 일 경우 LPOINT취소 */
				if((Integer.parseInt(cancelAmt) >= Integer.parseInt(lpointUseInfVO.getUsePoint()))){
					log.info("Case 4-2-1");
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
					lpointCancelFlag = Constant.FLAG_Y;
				/** 취소금액이 LPOINT 미만이고, PG금액 초과면 환불 */
				}else if((Integer.parseInt(cancelAmt) < Integer.parseInt(lpointUseInfVO.getUsePoint())) && Integer.parseInt(cancelAmt) > (Integer.parseInt(rsvDtlVO.getSaleAmt()) - Integer.parseInt(lpointUseInfVO.getUsePoint())) ){
					log.info("Case 4-2-2");
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
				}
			}

			/** Case 4-3 : 취소금액-쿠폰금액-L.Point 사용금액) 반환 */
			if (Integer.parseInt(cancelAmt) > 0) {
				log.info("Case 4-3");
				Map<String, Object> payResultMap = masRsvService.cancelPay(spRsvVO.getPayDiv(), spRsvVO.getRsvNum(), spRsvVO.getSpRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);
				payResult = (PAYVO) payResultMap.get("payResult");
				success = (String) payResultMap.get("success");
			} else {
				success = Constant.FLAG_N;
			}

			/** 취소완료건에 대해 예약건 업데이트 */
			if(Constant.FLAG_Y.equals(success)){
				// RSV_STATUS_CD_CCOM(RS20 : 취소)
				spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

				// 취소금액
				spRsvVO.setCancelAmt(cancelAmt);
				spRsvVO.setCmssAmt(spRsvVO.getCmssAmt());
				spRsvVO.setDisCancelAmt("0");
				webOrderService.updateSpCancelDtlRsv(spRsvVO);

				// 통합 예약건에 대한 처리
				RSVVO rsvVO = new RSVVO();
				rsvVO.setRsvNum(spRsvVO.getRsvNum());
				rsvVO.setTotalCancelAmt(cancelAmt);
				rsvVO.setTotalCmssAmt(spRsvVO.getCmssAmt());
				rsvVO.setTotalDisCancelAmt("0");

				rsvVO.setModIp(userIp);
				masRsvService.updateCancelRsv(rsvVO);
			}

		/** 부분취소 */
		}else{
			log.info("last case");
			/** 부분취소 처리가능한 결제만, 부분취소 불가능한 결제(탐나는전)은 환불로 떨어짐 */
			if(Constant.PAY_DIV_LG_CI.equals(rsvDtlVO.getPayDiv())|| Constant.PAY_DIV_LG_KI.equals(rsvDtlVO.getPayDiv())|| Constant.PAY_DIV_LG_TI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_MI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_TA_PI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_NP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_KP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_AP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_TP.equals(rsvDtlVO.getPayDiv())){
				/** 토스결제취소
				 *  L610 (포인트 결제) 시 로직을 타지 않고 success = Y */
				Map<String, Object> payResultMap = masRsvService.cancelPay(spRsvVO.getPayDiv(), spRsvVO.getRsvNum(), spRsvVO.getSpRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);
				payResult = (PAYVO) payResultMap.get("payResult");
				success = (String) payResultMap.get("success");
				cancelDiv = "1";

				// 취소완료건에 대해 예약건 업데이트
				if(Constant.FLAG_Y.equals(success)){
					// RSV_STATUS_CD_CCOM(RS20 : 취소)
					spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

					// 취소금액
					spRsvVO.setCancelAmt(cancelAmt);
					spRsvVO.setCmssAmt(spRsvVO.getCmssAmt());
					spRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
					webOrderService.updateSpCancelDtlRsv(spRsvVO);
					// 쿠폰 취소처리
					webOrderService.cancelUserCp(spRsvVO.getSpRsvNum());

					// 통합 예약건에 대한 처리
					RSVVO rsvVO = new RSVVO();
					rsvVO.setRsvNum(spRsvVO.getRsvNum());
					rsvVO.setTotalCancelAmt(cancelAmt);
					rsvVO.setTotalCmssAmt(spRsvVO.getCmssAmt());
					rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());

					rsvVO.setModIp(userIp);
					masRsvService.updateCancelRsv(rsvVO);
				}
			/** 부분취소 불가능 처리(탐나는전,휴대폰)*/
			}else{
				resultMap.put("success", "Y");
				payResult.setPayRstInf("취소성공");
			}
		}

    	// 처리가 정상적이지 않은 경우 환불요청 처리
    	if(Constant.FLAG_N.equals(success)){
    		// RSV_STATUS_CD_CREQ2(RS11 : 환불요청)
    		spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CREQ2);
    		cancelDiv = "2";

    		// 취소금액
    		spRsvVO.setCancelAmt(cancelAmt);
    		spRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
    		webOrderService.updateSpCancelDtlRsv(spRsvVO);

    		success = Constant.FLAG_Y;
    	}

    	//문자/메일 전송
    	webOrderService.cancelRsvAutoSnedSMSEmail(rsvDtlVO.getSpRsvNum(), request);

		/** 취소 정상 처리건에 대해 구매 수량 제어 */
    	webOrderService.updateSpCntInfMin(rsvDtlVO);
    	/** 판매 통계 감소 처리 */
		webOrderService.downSaleAnlsByDtlRsv(rsvDtlVO.getSpRsvNum());
    	/** L.Point 포인트 사용 취소 */
    	if (Constant.FLAG_Y.equals(lpointCancelFlag)) {
    		scheduleService.lpointUseCancel(lpointUseInfVO);
    	}
		/** 파트너(협력사) 포인트 사용 취소 */
		if (selPointVO != null && Constant.FLAG_Y.equals(success)) {
			if (selPointVO.getUsePoint() > 0) {
				selPointVO.setTypes("CANCEL");
				selPointVO.setContents("ALL_CANCEL"); //전체취소
				selPointVO.setPlusMinus("P");
				selPointVO.setPoint(selPointVO.getUsePoint());
				selPointVO.setCorpId(corpInfo.getCorpId());

				//1. 포인트 사용 전체 취소 처리
				ossPointService.insertPointCpSave(selPointVO);

				System.out.println("======================");
				System.out.println(spRsvVO.getCmssAmt());
				System.out.println(pointEx);
				System.out.println("======================");
				//2. 포인트 부분취소일 경우 처리
				if (Integer.parseInt(spRsvVO.getCmssAmt()) > 0 && Constant.FLAG_N.equals(pointEx)) {
					selPointVO.setTypes("USE");
					selPointVO.setContents("CMSS_AMT"); // 수수료 사용 처리
					selPointVO.setPlusMinus("M");

					if (Integer.parseInt(spRsvVO.getCmssAmt()) <= selPointVO.getUsePoint()) { //포인트 사용액이 더 많으면 수수료 전체 차감
						selPointVO.setPoint(Integer.parseInt(spRsvVO.getCmssAmt()));
					} else { //포인트 사용액이 더 적으면 사용한 포인트만큼 차감
						selPointVO.setPoint(selPointVO.getUsePoint());
					}
					ossPointService.insertPointCpSave(selPointVO);
				}
			}
		}

		//마라톤 티셔츠수량 사용취소처리
		String mrtCorpId = rsvDtlVO.getCorpId();
		if(mrtCorpId != null) {
			if("CSPM".equals(mrtCorpId.substring(0, 4))) {
				MRTNVO mrtnVO = new MRTNVO();
				mrtnVO.setRsvNum(rsvDtlVO.getRsvNum());
				mrtnVO.setSpRsvNum(rsvDtlVO.getSpRsvNum());
				mrtnVO.setCorpId(mrtCorpId);
				mrtnVO.setPrdtNum(rsvDtlVO.getPrdtNum());
				webOrderService.updateReturnTshirtsCnt(mrtnVO);
			}
		}

    	resultMap.put("cancelDiv", cancelDiv);
    	resultMap.put("success", success);
    	resultMap.put("payResult", payResult);

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;
    }

    /**
     * 숙박 예약취소
     * 파일명 : adCancelRsv
     * 작성일 : 2015. 12. 14. 오후 5:55:48
     * 작성자 : 최영철
     * @param adRsvVO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/ad/cancelRsv.ajax")
	public ModelAndView adCancelRsv(@ModelAttribute("ADRSVVO") AD_RSVVO adRsvVO, HttpServletRequest request) throws Exception {
		log.info("/mas/ad/cancelRsv.ajax Call : " + adRsvVO.getAdRsvNum());

		/**
		 * 상품금액 : NML_AMT (업체가 판매한 금액),
		 * 구매금액 : SALE_AMT (고객이 결제한 금액),
		 * 취소수수료 : CMSS_AMT (취소발생시, 업체가 가져가는 금액)
		 * 취소금액 : CANCEL_AMT (취소발생시, 고객이 반환받는 금액)
		 * */
		Map<String, Object> resultMap = new HashMap<String, Object>();

		/** 고객환불계좌 번호 set*/
		String LGD_RFBANKCODE = request.getParameter("LGD_RFBANKCODE");
		String LGD_RFACCOUNTNUM = request.getParameter("LGD_RFACCOUNTNUM");
		String LGD_RFCUSTOMERNAME = request.getParameter("LGD_RFCUSTOMERNAME");

		/** 업체ID set*/
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		adRsvVO.setsCorpId(corpInfo.getCorpId());

		/** 상품정보 get */
		AD_RSVVO rsvDtlVO = masRsvService.selectAdDetailRsv(adRsvVO);

		/** 결과변수 init  */
		PAYVO payResult = new PAYVO();
		String success = Constant.FLAG_N;
		String cancelDiv = "";
		String lpointCancelFlag = Constant.FLAG_N;
		String userIp = EgovClntInfo.getClntIP(request);

		/** 예약/취소요청 상태는 취소 불가 */
		if (!(rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_COM) || rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_CREQ))) {
			payResult.setPayRstInf("취소가능한 예약 상태가 아닙니다.");
			resultMap.put("success", "N");
			resultMap.put("payResult", payResult);
			ModelAndView mav = new ModelAndView("jsonView", resultMap);
			return mav;
		}

		/** 예약 상태에서 취소 시 TLL 취소전송 2022.07.18 chaewan.jung */
		if (rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_COM)) {
			/** TL린칸 취소*/
			APITLBookingLogVO bookingCancel = apitlBookingService.bookingCancel(request.getParameter("adRsvNum"));
			//취소 전송이 성공 하면 로직 실행 후 실패 처리
			if ("N".equals(bookingCancel.getRsvResult())) {
				resultMap.put("cancelDiv", "99");
				resultMap.put("success", "apiFail");
				ModelAndView mav = new ModelAndView("jsonView", resultMap);
				return mav;
			}
		}

		/** 취소금액 : 상품금액 - (취소수수료 + 쿠폰금액)*/
		String cancelAmt = String.valueOf(Integer.parseInt(rsvDtlVO.getNmlAmt()) - (Integer.parseInt(adRsvVO.getCmssAmt()) + Integer.parseInt(rsvDtlVO.getDisAmt())));

		/** 취소수수료가 0원이면 구매금액이 취소 금액 */
		if ("0".equals(adRsvVO.getCmssAmt())) {
			cancelAmt = rsvDtlVO.getSaleAmt();
		}

		/** L.Point 사용 금액 */
		LPOINTUSEINFVO lpointUseInfVO = new LPOINTUSEINFVO();
		lpointUseInfVO.setRsvNum(adRsvVO.getRsvNum());
		lpointUseInfVO.setMaxSaleDtlRsvNum(adRsvVO.getAdRsvNum());
		lpointUseInfVO.setCancelYn(Constant.FLAG_N);
		lpointUseInfVO.setRsvCancelYn(Constant.FLAG_N);
		lpointUseInfVO = webOrderService.selectLpointUsePoint(lpointUseInfVO);

		if (lpointUseInfVO != null) {
			/** 취소금액이 LPOINT 이상 일 경우 LPOINT취소 */
			if((Integer.parseInt(cancelAmt) >= Integer.parseInt(lpointUseInfVO.getUsePoint()))){
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
				lpointCancelFlag = Constant.FLAG_Y;
			/** 취소금액이 LPOINT 미만이고, PG금액 초과면 환불 Case 4로 이동  */
			}else if((Integer.parseInt(cancelAmt) < Integer.parseInt(lpointUseInfVO.getUsePoint())) && Integer.parseInt(cancelAmt) > (Integer.parseInt(rsvDtlVO.getSaleAmt()) - Integer.parseInt(lpointUseInfVO.getUsePoint())) ){
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
			}
		}

		/** 파트너(협력사) 포인트 사용 금액 조회*/
		POINTVO pointVO = new POINTVO();
		pointVO.setTypes("USE");
		pointVO.setRsvNum(adRsvVO.getRsvNum());
		pointVO.setDtlRsvNum(adRsvVO.getAdRsvNum());
		POINTVO selPointVO = ossPointService.selectUsePoint(pointVO);

		String pointEx = Constant.FLAG_N;
		if (selPointVO != null) {
			if (selPointVO.getUsePoint() > 0) {
				//사용 포인트가 취소수수료보다 크면 포인트에서 먼저 차감.
				if (selPointVO.getUsePoint() >= Integer.parseInt(adRsvVO.getCmssAmt())) {
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - (selPointVO.getUsePoint() - Integer.parseInt(adRsvVO.getCmssAmt())));
				}

				//쿠폰이 있는상태에서 수수료 전체 취소 일 경우
//				if (Integer.parseInt(cancelAmt) < 0) {
//					pointEx = Constant.FLAG_Y;
//				}
			}
		}

		/** Case 1 : 취소수수료 0원 처리 */
		if ("0".equals(adRsvVO.getCmssAmt())) {
			log.info("cmss = 0");
			/** 토스결제취소 */
			Map<String, Object> payResultMap = masRsvService.cancelPay(adRsvVO.getPayDiv(), adRsvVO.getRsvNum(), adRsvVO.getAdRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);
			payResult = (PAYVO) payResultMap.get("payResult");
			success = (String) payResultMap.get("success");
			cancelDiv = "1";

			/** 탐나는전결제취소 */
			if (Constant.PAY_DIV_TC_WI.equals(adRsvVO.getPayDiv()) || Constant.PAY_DIV_TC_MI.equals(adRsvVO.getPayDiv())) {
				success = cancelTamnacard(adRsvVO.getRsvNum(), cancelAmt);
			}

			/** 취소완료건에 대해 예약건 업데이트 */
			if (Constant.FLAG_Y.equals(success)) {
				adRsvVO.setCancelAmt(rsvDtlVO.getSaleAmt());
				adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

				adRsvVO.setCmssAmt("0");
				adRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
				webOrderService.updateAdCancelDtlRsv(adRsvVO);
				// 쿠폰 취소처리
				webOrderService.cancelUserCp(adRsvVO.getAdRsvNum());

				// 통합 예약건에 대한 처리
				RSVVO rsvVO = new RSVVO();
				rsvVO.setRsvNum(adRsvVO.getRsvNum());
				rsvVO.setTotalCancelAmt(rsvDtlVO.getSaleAmt());
				rsvVO.setTotalCmssAmt("0");
				rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());
				rsvVO.setModIp(userIp);
				masRsvService.updateCancelRsv(rsvVO);
			}
		}
		/** Case 2 : 취소수수료 100% 처리*/
		else if (rsvDtlVO.getNmlAmt().equals(adRsvVO.getCmssAmt())) {
			log.info("nmlAmt & cmss = 100%");
			cancelDiv = "1";

			// 수수료가 100%인 경우에는 예약 상태만 취소 처리함.
			adRsvVO.setCancelAmt("0");
			adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);
			adRsvVO.setDisCancelAmt("0");
			webOrderService.updateAdCancelDtlRsv(adRsvVO);

			// 통합 예약건에 대한 처리
			RSVVO rsvVO = new RSVVO();
			rsvVO.setRsvNum(adRsvVO.getRsvNum());
			rsvVO.setTotalCancelAmt("0");
			rsvVO.setTotalCmssAmt(adRsvVO.getCmssAmt());
			rsvVO.setTotalDisCancelAmt("0");

			rsvVO.setModIp(userIp);
			masRsvService.updateCancelRsv(rsvVO);

			success = Constant.FLAG_Y;
		}
		/** Case 3 : 취소수수료 100% 처리 (쿠폰 & L.Point가 포함되어있는경우 ) */
		else if (rsvDtlVO.getSaleAmt().equals(adRsvVO.getCmssAmt())) {
			log.info("saleAmt & cmss = 100%");
			cancelDiv = "1";
			/** 수수료가 100%인 경우에는 예약 상태만 취소 처리함. */
			adRsvVO.setCancelAmt("0");
			adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

			// 수수료 금액
			adRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
			webOrderService.updateAdCancelDtlRsv(adRsvVO);
			// 쿠폰 취소처리
			webOrderService.cancelUserCp(adRsvVO.getAdRsvNum());

			// 통합 예약건에 대한 처리
			RSVVO rsvVO = new RSVVO();
			rsvVO.setRsvNum(adRsvVO.getRsvNum());
			rsvVO.setTotalCancelAmt("0");
			rsvVO.setTotalCmssAmt(adRsvVO.getCmssAmt());
			rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());

			rsvVO.setModIp(userIp);
			masRsvService.updateCancelRsv(rsvVO);

			success = Constant.FLAG_Y;
		}
		/** Case 4 : 취소금액이 마이너스 금액 처리(쿠폰 & L.Point가 포함되어있는경우)*/
		else if (Integer.parseInt(cancelAmt) < 0) {
			log.info("cancelAmt < 0");
			cancelDiv = "1";
			/** 취소금액 = 상품금액 - 취소 수수료 */
			cancelAmt = String.valueOf(Integer.parseInt(rsvDtlVO.getNmlAmt()) - Integer.parseInt(adRsvVO.getCmssAmt()));

			/** Case 4-1 : 취소금액이 쿠폰금액보다 크거나 같은 경우,쿠폰 취소 처리 */
			if (Integer.parseInt(cancelAmt) >= Integer.parseInt(rsvDtlVO.getDisAmt())) {
				log.info("Case 4-1");
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(rsvDtlVO.getDisAmt()));
				webOrderService.cancelUserCp(adRsvVO.getAdRsvNum());
			}

			/** Case 4-2 : 취소금액-쿠폰금액이 L.Point 사용금액보다 크거나 같은 경우, L.Point 취소 처리 */
			if (lpointUseInfVO != null) {
				/** 취소금액이 LPOINT 이상 일 경우 LPOINT취소 */
				if((Integer.parseInt(cancelAmt) >= Integer.parseInt(lpointUseInfVO.getUsePoint()))){
					log.info("Case 4-2-1");
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
					lpointCancelFlag = Constant.FLAG_Y;
				/** 취소금액이 LPOINT 미만이고, PG금액 초과면 환불 */
				}else if((Integer.parseInt(cancelAmt) < Integer.parseInt(lpointUseInfVO.getUsePoint())) && Integer.parseInt(cancelAmt) > (Integer.parseInt(rsvDtlVO.getSaleAmt()) - Integer.parseInt(lpointUseInfVO.getUsePoint())) ){
					log.info("Case 4-2-2");
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
				}
			}

			/** Case 4-3 : 취소금액-쿠폰금액-L.Point 사용금액) 반환 */
			if (Integer.parseInt(cancelAmt) > 0) {
				log.info("Case 4-3");
				Map<String, Object> payResultMap = masRsvService.cancelPay(adRsvVO.getPayDiv(), adRsvVO.getRsvNum(), adRsvVO.getAdRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);
				payResult = (PAYVO) payResultMap.get("payResult");
				success = (String) payResultMap.get("success");
			} else {
				success = Constant.FLAG_N;
			}
			/** 취소완료건에 대해 예약건 업데이트 */
			if (Constant.FLAG_Y.equals(success)) {
				// RSV_STATUS_CD_CCOM(RS20 : 취소)
				adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

				// 취소금액
				adRsvVO.setCancelAmt(cancelAmt);
				adRsvVO.setCmssAmt(adRsvVO.getCmssAmt());
				adRsvVO.setDisCancelAmt("0");
				webOrderService.updateAdCancelDtlRsv(adRsvVO);

				// 통합 예약건에 대한 처리
				RSVVO rsvVO = new RSVVO();
				rsvVO.setRsvNum(adRsvVO.getRsvNum());
				rsvVO.setTotalCancelAmt(cancelAmt);
				rsvVO.setTotalCmssAmt(adRsvVO.getCmssAmt());
				rsvVO.setTotalDisCancelAmt("0");

				rsvVO.setModIp(userIp);
				masRsvService.updateCancelRsv(rsvVO);
			}
		/** 부분취소 */
		} else {
			log.info("last case");
			/** 부분취소 처리가능한 결제만, 부분취소 불가능한 결제(탐나는전)은 환불로 떨어짐 */
			if(Constant.PAY_DIV_LG_CI.equals(rsvDtlVO.getPayDiv())|| Constant.PAY_DIV_LG_KI.equals(rsvDtlVO.getPayDiv())|| Constant.PAY_DIV_LG_TI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_MI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_TA_PI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_NP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_KP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_AP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_TP.equals(rsvDtlVO.getPayDiv())){
				cancelDiv = "1";
				Map<String, Object> payResultMap = masRsvService.cancelPay(adRsvVO.getPayDiv(), adRsvVO.getRsvNum(), adRsvVO.getAdRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);
				/** 토스결제취소 */
				payResult = (PAYVO) payResultMap.get("payResult");
				success = (String) payResultMap.get("success");

				// 취소완료건에 대해 예약건 업데이트
				if (Constant.FLAG_Y.equals(success)) {
					// RSV_STATUS_CD_CCOM(RS20 : 취소)
					adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

					// 취소금액
					adRsvVO.setCancelAmt(cancelAmt);
					adRsvVO.setCmssAmt(adRsvVO.getCmssAmt());
					adRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
					webOrderService.updateAdCancelDtlRsv(adRsvVO);
					// 쿠폰 취소처리
					webOrderService.cancelUserCp(adRsvVO.getAdRsvNum());

					// 통합 예약건에 대한 처리
					RSVVO rsvVO = new RSVVO();
					rsvVO.setRsvNum(adRsvVO.getRsvNum());
					rsvVO.setTotalCancelAmt(cancelAmt);
					rsvVO.setTotalCmssAmt(adRsvVO.getCmssAmt());
					rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());

					rsvVO.setModIp(userIp);
					masRsvService.updateCancelRsv(rsvVO);
				}
				/** 부분취소 불가능 처리(탐나는전,휴대폰)*/
			} else {
				resultMap.put("success", "Y");
				payResult.setPayRstInf("취소성공");
			}
		}

		// 처리가 정상적이지 않은 경우 환불요청 처리
		if (Constant.FLAG_N.equals(success)) {
			// RSV_STATUS_CD_CREQ2(RS11 : 환불요청)
			adRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CREQ2);
			cancelDiv = "2";

			// 취소금액
			adRsvVO.setCancelAmt(cancelAmt);
			adRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
			webOrderService.updateAdCancelDtlRsv(adRsvVO);

			//API호출------------------------------
			String strApiErr = "";

			//취소요청
			strApiErr = apiAdService.requestCancelResInfo(rsvDtlVO.getAdRsvNum());
			if (Constant.SUKSO_OK.equals(strApiErr) == false) {
				//오류 처리......
				log.info("/mas/ad/cancelRsv.ajax API(requestCancelResInfo Auto) Call Error");
			}
			success = Constant.FLAG_Y;
		}

		//문자/메일 전송
		webOrderService.cancelRsvAutoSnedSMSEmail(rsvDtlVO.getAdRsvNum(), request);

		/** 취소 정상 처리건에 대해 수량 테이블에서 감소 */
		webOrderService.updateAdCntInfMin(rsvDtlVO);
		/** 판매 통계 감소 처리 */
		webOrderService.downSaleAnlsByDtlRsv(rsvDtlVO.getAdRsvNum());
		/** L.Point 포인트 사용 취소 */
		if (Constant.FLAG_Y.equals(lpointCancelFlag)) {
			scheduleService.lpointUseCancel(lpointUseInfVO);
		}
		/** 파트너(협력사) 포인트 사용 취소 */
		if (selPointVO != null && Constant.FLAG_Y.equals(success)) {
			if (selPointVO.getUsePoint() > 0) {
				selPointVO.setTypes("CANCEL");
				selPointVO.setContents("ALL_CANCEL"); //전체취소
				selPointVO.setPlusMinus("P");
				selPointVO.setPoint(selPointVO.getUsePoint());
				selPointVO.setCorpId(corpInfo.getCorpId());

				//1. 포인트 사용 전체 취소 처리
				ossPointService.insertPointCpSave(selPointVO);

				//2. 포인트 부분취소일 경우 처리
				if (Integer.parseInt(adRsvVO.getCmssAmt()) > 0 && Constant.FLAG_N.equals(pointEx)) {
					selPointVO.setTypes("USE");
					selPointVO.setContents("CMSS_AMT"); // 수수료 사용 처리
					selPointVO.setPlusMinus("M");

					if (Integer.parseInt(adRsvVO.getCmssAmt()) <= selPointVO.getUsePoint()) { //포인트 사용액이 더 많으면 수수료 전체 차감
						selPointVO.setPoint(Integer.parseInt(adRsvVO.getCmssAmt()));
					} else { //포인트 사용액이 더 적으면 사용한 포인트만큼 차감
						selPointVO.setPoint(selPointVO.getUsePoint());
					}
					ossPointService.insertPointCpSave(selPointVO);
				}
			}
		}

		resultMap.put("cancelDiv", cancelDiv);
		resultMap.put("success", success);
		resultMap.put("payResult", payResult);
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

    /**
     * 소셜예약 관리자 메모 업데이트
     * @param spRsvVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/sp/updateRsvAdmMemo.ajax")
    public ModelAndView updateRsvAdmMemo( @ModelAttribute("SPRSVVO") SP_RSVVO spRsvVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	spRsvVO.setCorpId(corpInfo.getCorpId());

    	masRsvService.updateRsvAdmMemo(spRsvVO);
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	resultMap.put("success", Constant.JSON_SUCCESS);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;

    }

    @RequestMapping("/mas/sp/insertSpRsvhist.ajax")
    public ModelAndView insertSpRsvhist( @ModelAttribute("SP_RSVHISTVO") SP_RSVHISTVO sp_RSVHISTVO,
    		ModelMap model){
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	sp_RSVHISTVO.setRegId(corpInfo.getUserId());
    	sp_RSVHISTVO.setRegIp(corpInfo.getLastLoginIp());

    	masRsvService.insertSpRsvhist(sp_RSVHISTVO);

    	resultMap.put("success", Constant.JSON_SUCCESS);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;
    }

    @RequestMapping("/mas/sp/spUseAppr.ajax")
    public ModelAndView spUseAppr(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		@ModelAttribute("SPRSVVO") SP_RSVVO spRsvVO,
    		ModelMap model) throws ParseException {
    	log.info("/mas/sp/spUseAppr.ajax call");

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	spRsvVO.setCorpId(corpInfo.getCorpId());

    	// 쿠폰상품일 경우 구매시간 - 이용시간 / 유효일 체크해서 처리.
    	SP_RSVVO resultVO = masRsvService.selectSpDetailRsv(spRsvVO);

    	String now = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());

    	/*if(now.compareTo(resultVO.getExprStartDt()) < 0 || now.compareTo(resultVO.getExprEndDt()) > 0 ) {
    		resultMap.put("exprOut", Constant.FLAG_Y);
    		resultMap.put("exprStartDt", resultVO.getExprStartDt());
    		resultMap.put("exprEndDt", resultVO.getExprEndDt());
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}*/

    	now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
    	if(StringUtils.isNotEmpty(resultVO.getUseAbleDttm()) && now.compareTo(resultVO.getUseAbleDttm()) < 0) {
    		resultMap.put("useAbleOut", Constant.FLAG_Y);
    		resultMap.put("useAbleDttm", resultVO.getUseAbleDttm());
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}

    	// 완불완료.
    	spRsvVO.setUseNum(resultVO.getBuyNum());
   // 	spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM2);
    	spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_UCOM);
    	masRsvService.updateSpUseDttm(spRsvVO);

    	resultMap.put("success", Constant.JSON_SUCCESS);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }

    @RequestMapping("/mas/sp/selectBySpRsv.ajax")
    public ModelAndView selectBySpRsv(@ModelAttribute("SPRSVVO") SP_RSVVO spRsvVO,
    		ModelMap model){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	SP_RSVVO resultVO = masRsvService.selectSpDetailRsv(spRsvVO);

    	resultMap.put("resultVO", resultVO);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }

    /**
     * 환불 사용 처리
     * 파일명 : spUseRefund
     * 작성일 : 2016. 1. 18. 오전 10:27:46
     * 작성자 : 최영철
     * @param spRsvVO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/sp/spUseRefund.ajax")
    public ModelAndView spUseRefund(@ModelAttribute("SPRSVVO") SP_RSVVO spRsvVO, HttpServletRequest request) throws Exception{
    	String LGD_RFBANKCODE = request.getParameter("LGD_RFBANKCODE");
    	String LGD_RFACCOUNTNUM = request.getParameter("LGD_RFACCOUNTNUM");
    	String LGD_RFCUSTOMERNAME = request.getParameter("LGD_RFCUSTOMERNAME");

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	spRsvVO.setCorpId(corpInfo.getCorpId());

    	// 쿠폰상품일 경우 구매시간 - 이용시간 / 유효일 체크해서 처리.
    	SP_RSVVO rsvDtlVO = masRsvService.selectSpDetailRsv(spRsvVO);

    	String now = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());

    	if(now.compareTo(rsvDtlVO.getExprStartDt()) < 0 || now.compareTo(rsvDtlVO.getExprEndDt()) > 0 ) {
    		resultMap.put("exprOut", Constant.FLAG_Y);
    		resultMap.put("exprStartDt", rsvDtlVO.getExprStartDt());
    		resultMap.put("exprEndDt", rsvDtlVO.getExprEndDt());
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}

    	now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
    	if(StringUtils.isNotEmpty(rsvDtlVO.getUseAbleDttm()) && now.compareTo(rsvDtlVO.getUseAbleDttm()) < 0) {
    		resultMap.put("useAbleOut", Constant.FLAG_Y);
    		resultMap.put("useAbleDttm", rsvDtlVO.getUseAbleDttm());
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}

    	spRsvVO.setRsvNum(rsvDtlVO.getRsvNum());

    	// 사용완료.
    	spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_UCOM);
    	masRsvService.updateSpUseDttm(spRsvVO);

    	PAYVO payResult = new PAYVO();
    	String success = Constant.FLAG_N;
    	String cancelDiv = "";

    	// 접속 IP
    	String userIp = EgovClntInfo.getClntIP(request);

    	// 환불금액이 상품금액과 동일한경우
    	if(rsvDtlVO.getNmlAmt().equals(spRsvVO.getRefundAmt())){
    		resultMap.put("refundAbleOut", Constant.FLAG_Y);
    		ModelAndView mav = new ModelAndView("jsonView", resultMap);
    		return mav;
    	}else{
    		// LG 카드결제인경우 자동 취소 처리
    		if(Constant.PAY_DIV_LG_CI.equals(rsvDtlVO.getPayDiv())|| Constant.PAY_DIV_LG_KI.equals(rsvDtlVO.getPayDiv())){
    			cancelDiv = "1";

    			Map<String, Object> payResultMap = masRsvService.cancelPay(rsvDtlVO.getPayDiv(), rsvDtlVO.getRsvNum(), rsvDtlVO.getSpRsvNum(), spRsvVO.getRefundAmt(), userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);

    			payResult = (PAYVO) payResultMap.get("payResult");
    			success = (String) payResultMap.get("success");

    			// 취소완료건에 대해 예약건 업데이트
    			if(Constant.FLAG_Y.equals(success)){
    				// RSV_STATUS_CD_SCOM(RS32 : 부분환불완료)
    				spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_SCOM);

    				// 취소금액
    				spRsvVO.setCancelAmt(spRsvVO.getRefundAmt());
    				spRsvVO.setCmssAmt(rsvDtlVO.getCmssAmt());
    				// 환불금액
//    				spRsvVO.setRefundAmt(spRsvVO.getRefundAmt());
    				spRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
    				webOrderService.updateSpCancelDtlRsv(spRsvVO);
    				// 쿠폰 취소처리
    				webOrderService.cancelUserCp(spRsvVO.getSpRsvNum());

    				// 통합 예약건에 대한 처리
    				RSVVO rsvVO = new RSVVO();
    				rsvVO.setRsvNum(rsvDtlVO.getRsvNum());
    				rsvVO.setTotalCancelAmt(spRsvVO.getRefundAmt());
    				rsvVO.setTotalCmssAmt(rsvDtlVO.getCmssAmt());
    				rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());

    				rsvVO.setModIp(userIp);
    				masRsvService.updateCancelRsv(rsvVO);
    			}
    		}
    	}

    	// 처리가 정상적이지 않은 경우 환불요청 처리
    	if(Constant.FLAG_N.equals(success)){
    		// RSV_STATUS_CD_SREQ(RS12 : 부분환불요청)
    		spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_SREQ);
    		cancelDiv = "2";

    		// 취소금액
    		spRsvVO.setCancelAmt(spRsvVO.getRefundAmt());
    		spRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
    		spRsvVO.setCmssAmt("0");
    		webOrderService.updateSpCancelDtlRsv(spRsvVO);

    		success = Constant.FLAG_Y;
    	}

    	resultMap.put("cancelDiv", cancelDiv);
    	resultMap.put("success", success);
    	resultMap.put("payResult", payResult);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }

    @RequestMapping("/mas/rsvIdt.ajax")
    public ModelAndView rsvIdt(@ModelAttribute("ORDERVO") ORDERVO orderVO, HttpServletRequest request) throws Exception{
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	masRsvService.updateRsvIdt(orderVO);

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }

    @RequestMapping("/mas/sp/checkSpRsv.ajax")
    public ModelAndView checkSpRsv(@ModelAttribute("SP_RSVVO") SP_RSVVO spRsvVO, HttpServletRequest request) throws Exception{
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	List<SP_RSVVO> resultList = masRsvService.selectSpRsvList2(spRsvVO);
    	if(resultList.size() > 0){
    		resultMap.put("chkVal", "N");
    	}else{
    		resultMap.put("chkVal", "Y");
    	}

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }

    @RequestMapping("/mas/sv/checkSvRsv.ajax")
    public ModelAndView checkSvRsv(@ModelAttribute("SV_RSVVO") SV_RSVVO svRsvVO, HttpServletRequest request) throws Exception{
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	List<SV_RSVVO> resultList = masRsvService.selectSvRsvList2(svRsvVO);
    	if(resultList.size() > 0){
    		resultMap.put("chkVal", "N");
    	}else{
    		resultMap.put("chkVal", "Y");
    	}

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }

    /**
     * 입점업체 소셜예약 엑셀 다운로드
     * 파일명 : spRsvExcelDown
     * 작성일 : 2016. 5. 3. 오전 9:59:35
     * 작성자 : 최영철
     * @param rsvSVO
     * @param request
     * @param response
     */
    @RequestMapping("/mas/spRsvExcelDown.do")
    public void spRsvExcelDown(@ModelAttribute("searchVO") RSVSVO rsvSVO, HttpServletRequest request, HttpServletResponse response){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsCorpId(corpInfo.getCorpId());

    	List<SP_RSVVO> resultList = masRsvService.selectSpRsvExcelList(rsvSVO);

		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100);
        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("예약내역");
        // 컬럼 너비 설정
        sheet1.setColumnWidth(0, 4000);
        sheet1.setColumnWidth(1, 3000);
        sheet1.setColumnWidth(2, 10000);
        sheet1.setColumnWidth(3, 10000);
        sheet1.setColumnWidth(4, 2000);
        sheet1.setColumnWidth(5, 2000);
        sheet1.setColumnWidth(6, 4000);
        sheet1.setColumnWidth(7, 2000);
        sheet1.setColumnWidth(8, 4000);
        sheet1.setColumnWidth(9, 2000);
        sheet1.setColumnWidth(10, 2000);
        sheet1.setColumnWidth(11, 2000);
        // ----------------------------------------------------------
        CellStyle cellStyle = xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;
        // 첫 번째 줄
        row = sheet1.createRow(0);
        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("예약번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(1);
        cell.setCellValue("예약상태");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(2);
        cell.setCellValue("상품명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(3);
        cell.setCellValue("옵션명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(4);
        cell.setCellValue("구매수");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(5);
        cell.setCellValue("예약자");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(6);
        cell.setCellValue("예약자 전화번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(7);
        cell.setCellValue("사용자");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(8);
        cell.setCellValue("사용자 전화번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(9);
        cell.setCellValue("판매금액");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(10);
        cell.setCellValue("예약일자");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(11);
        cell.setCellValue("사용일자");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(12);
        cell.setCellValue("정산완료");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(13);
        cell.setCellValue("정산금액");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(14);
        cell.setCellValue("결제수단");
        cell.setCellStyle(cellStyle);

        //---------------------------------
		for (int i = 0; i < resultList.size(); i++) {
			SP_RSVVO orderVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(orderVO.getRsvNum());

			cell = row.createCell(1);
			if(Constant.RSV_STATUS_CD_READY.equals(orderVO.getRsvStatusCd())) {
				cell.setCellValue("예약대기");
			} else if(Constant.RSV_STATUS_CD_COM.equals(orderVO.getRsvStatusCd())) {
				cell.setCellValue("예약");
			} else if(Constant.RSV_STATUS_CD_CREQ.equals(orderVO.getRsvStatusCd())) {
				cell.setCellValue("취소요청");
			} else if(Constant.RSV_STATUS_CD_CREQ2.equals(orderVO.getRsvStatusCd())) {
				cell.setCellValue("환불요청");
			} else if(Constant.RSV_STATUS_CD_CCOM.equals(orderVO.getRsvStatusCd())) {
				cell.setCellValue("취소");
			} else if(Constant.RSV_STATUS_CD_SREQ.equals(orderVO.getRsvStatusCd())) {
				cell.setCellValue("부분환불요청");
			} else if(Constant.RSV_STATUS_CD_SCOM.equals(orderVO.getRsvStatusCd())) {
				cell.setCellValue("부분환불완료");
			} else if(Constant.RSV_STATUS_CD_ACC.equals(orderVO.getRsvStatusCd())) {
				cell.setCellValue("자동취소");
			} else if(Constant.RSV_STATUS_CD_UCOM.equals(orderVO.getRsvStatusCd())) {
				cell.setCellValue("사용완료");
			} else if(Constant.RSV_STATUS_CD_ECOM.equals(orderVO.getRsvStatusCd())) {
				cell.setCellValue("기간만료");
			}
			cell = row.createCell(2);
			cell.setCellValue(orderVO.getPrdtNm());

			cell = row.createCell(3);
			String cellVal3 = "";
			if(!EgovStringUtil.isEmpty(orderVO.getAplDt())) {
				cellVal3 = EgovStringUtil.addMinusChar(orderVO.getAplDt());
			}
			cellVal3 += orderVO.getDivNm() + " " + orderVO.getOptNm();
			cell.setCellValue(cellVal3);

			cell = row.createCell(4);
			cell.setCellValue(orderVO.getBuyNum());

			cell = row.createCell(5);
			cell.setCellValue(orderVO.getRsvNm());

			cell = row.createCell(6);
			cell.setCellValue(orderVO.getRsvTelnum());

			cell = row.createCell(7);
			cell.setCellValue(orderVO.getUseNm());

			cell = row.createCell(8);
			cell.setCellValue(orderVO.getUseTelnum());

			cell = row.createCell(9);
			cell.setCellValue(orderVO.getNmlAmt());

			cell = row.createCell(10);
			cell.setCellValue(orderVO.getRegDttm());

			cell = row.createCell(11);
			cell.setCellValue(orderVO.getUseDttm());

			cell = row.createCell(12);
			cell.setCellValue(orderVO.getAdjYn());

			cell = row.createCell(13);
			cell.setCellValue(orderVO.getRealAdjAmt());

			cell = row.createCell(14);
			for ( Constant.PAY_DIV payDiv : Constant.PAY_DIV.values() ) {
				if(orderVO.getPayDiv().equals(payDiv.getCode())){
					cell.setCellValue(payDiv.getName());
				}
			}
		}
        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "RSV.xlsx";

    		String userAgent = request.getHeader("User-Agent");
    		if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
    			response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("MSIE") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("Trident") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		} else if(userAgent.indexOf("Android") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") );
    		} else if(userAgent.indexOf("Swing") >= 0) {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8")  + ";");
    		} else if(userAgent.indexOf("Mozilla/5.0") >= 0) {		// 크롬, 파폭
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
    		} else {
    			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
    		}
			/*response.setContentType("application/vnd.ms-excel");*/
    		ServletOutputStream fileOutput = response.getOutputStream();

            xlsxWb.write(fileOutput);
			fileOutput.flush();
            fileOutput.close();

        } catch (FileNotFoundException e) {
        	log.error(e);
            e.printStackTrace();
        } catch (IOException e) {
        	log.error(e);
            e.printStackTrace();
        }
    }

    /**
     * 제주도 기념품 구매 리스트
     * @param rsvSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/sv/rsvList.do")
    public String svRsvList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	rsvSVO.setsCorpId(corpInfo.getCorpId());

    	rsvSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	rsvSVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** paging setting */
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(rsvSVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(rsvSVO.getPageUnit());
    	paginationInfo.setPageSize(rsvSVO.getPageSize());

    	rsvSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	rsvSVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	rsvSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    	Map<String, Object> resultMap = masRsvService.selectSvRsvList(rsvSVO);

    	@SuppressWarnings("unchecked")
    	List<SV_RSVVO> resultList = (List<SV_RSVVO>) resultMap.get("resultList");

    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	List<DLVCORPVO> dlvCorpList = ossCorpService.selectDlvCorpListByCorp(corpVO);

    	// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

    	model.addAttribute("resultList", resultList);
    	model.addAttribute("totalCnt", resultMap.get("totalCnt"));
    	model.addAttribute("paginationInfo", paginationInfo);
    	model.addAttribute("dlvCorpList", dlvCorpList);

    	return "/mas/rsv/svRsvList";
    }


    public void setRecPnt(String ID, ModelMap model){

    	LGPAYINFVO lgpayinfVO = webOrderService.selectLGPAYINFO(ID);

    	log.info("============= ID:" + ID);
    	String MERT_KEY = EgovProperties.getProperty("Globals.LgdMertKey.PRE");
    	//log.info("============= MERT_KEY:" + MERT_KEY);
    	//log.info("============= getRsvNum:" + resultVO.getRsvNum());

    	if(lgpayinfVO != null){

    		String CST_PLATFORM        = EgovProperties.getOptionalProp("CST_PLATFORM");     	//LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
    	    String CST_MID             = EgovProperties.getProperty("Globals.LgdID.PRE");           	//상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
    	    String LGD_MID             = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
    	    //log.info("============= lgpayinfVO:" + lgpayinfVO.getLGD_OID() + " | " + lgpayinfVO.getLGD_TID());

    	    model.addAttribute("recPntYn", "Y");
        	model.addAttribute("CST_PLATFORM", CST_PLATFORM);
        	model.addAttribute("LGD_MID", LGD_MID);
        	model.addAttribute("LGD_TID", lgpayinfVO.getLGD_TID());
        	model.addAttribute("MERT_KEY", MERT_KEY);
        	model.addAttribute("LGD_CASFLAGY", lgpayinfVO.getLGD_CASFLAGY());


    		if("SC0010".equals( lgpayinfVO.getLGD_PAYTYPE() ) ){
    			//카드 결제

	    	    String autKey = LGD_MID+lgpayinfVO.getLGD_TID()+MERT_KEY;
	    	    //log.info("============= autKey:" + autKey);
	        	String authdata="";
				try {
					authdata = EgovWebUtil.generateMD5encryption(autKey);
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				}
	        	//log.info("============= authdata:" + authdata);

	        	model.addAttribute("authdata", authdata);

	        	model.addAttribute("recPntType", "card");
    		}else if("SC0030".equals( lgpayinfVO.getLGD_PAYTYPE() ) || "SC0040".equals( lgpayinfVO.getLGD_PAYTYPE() ) ){
    			//현금 결제

    			if( !(lgpayinfVO.getLGD_CASHRECEIPTNUM()==null || lgpayinfVO.getLGD_CASHRECEIPTNUM().isEmpty() || "".equals(lgpayinfVO.getLGD_CASHRECEIPTNUM()) )){
    				//현금 영수증이 신청된 경우에만 보임

	    			model.addAttribute("LGD_OID", lgpayinfVO.getLGD_OID());

	    			String cashType = "";

	    			if("SC0030".equals( lgpayinfVO.getLGD_PAYTYPE() )){
	    				cashType = "BANK";
	    			}else if("SC0040".equals( lgpayinfVO.getLGD_PAYTYPE() )){
	    				cashType = "CAS";
	    			}

	    			model.addAttribute("cashType", cashType);

	    			model.addAttribute("recPntType", "cash");
    			}else{
    				model.addAttribute("recPntType", "Nocash");
    			}
    		}


    	}



    }

    /**
     * 제주도 기념품구매 상세
     * @param rsvSVO
     * @param svRsvVO
     * @param model
     * @return
     * @throws NoSuchAlgorithmException
     */
    @RequestMapping("/mas/sv/detailRsv.do")
    public String svDetailRsv(@ModelAttribute("searchVO") RSVSVO rsvSVO,
    		@ModelAttribute("SVRSVVO") SV_RSVVO svRsvVO,
    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	svRsvVO.setsCorpId(corpInfo.getCorpId());

    	SV_RSVVO resultVO = masRsvService.selectSvDetailRsv(svRsvVO);
    	model.addAttribute("resultVO", resultVO);

    	List<CDVO> cdRfac = ossCmmService.selectCode("RFAC");
		model.addAttribute("cdRfac", cdRfac);

    	//영수증 관련 처리
    	setRecPnt(resultVO.getRsvNum(), model);

		//취소 증빙자료
		RSVFILEVO rsvFileVO = new RSVFILEVO();
		rsvFileVO.setDtlRsvNum(svRsvVO.getSvRsvNum());
		rsvFileVO.setCategory("PROVE");
		List<RSVFILEVO> rsvFileList = webMypageService.selectDtlRsvFileList(rsvFileVO);
		model.addAttribute("rsvFileList", rsvFileList);

		//OSS 취소 증빙자료
		rsvFileVO.setCategory("PROVE_OSS");
		List<RSVFILEVO> rsvFileList_OSS = webMypageService.selectDtlRsvFileList(rsvFileVO);
		model.addAttribute("rsvFileList_OSS", rsvFileList_OSS);


		return "/mas/rsv/svDetailRsv";
    }

    /**
     * 운송장번호 입력
     * @param svRsvVO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/sv/insertDlvNum.ajax")
    public ModelAndView insertDlvNum(@ModelAttribute("SV_RSVVO") SV_RSVVO svRsvVO, HttpServletRequest request, APIGoodsFlowSendTraceRequestVO apiGoodsFlowSendTraceRequestVO) throws org.json.simple.parser.ParseException {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success",false);

		/**에스크로 프로그램 연동 2023.05.18 chaewan.jung**/
		boolean resp = webOrderService.escrowResp(request);
//		if (resp) {
			String resultStr = apiGoodsFlowService.sendTraceRequest(apiGoodsFlowSendTraceRequestVO);

			if ("Y".equals(resultStr)) {
				svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_DLV);
				masRsvService.updateDlvNum(svRsvVO);

				/** 문자/메일 전송*/
				webOrderService.dlvNumSnedSMSEmail(svRsvVO.getSvRsvNum(), request);
				resultMap.put("success", true);
			}
//		}

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);
    	return mav;
    }

	/**
	* 설명 : 운송장 번호 초기화
	* 파일명 : resetDlvNum
	* 작성일 : 2024-08-01 오전 9:54
	* 작성자 : chaewan.jung
	* @param : [svRsvNum]
	* @return : org.springframework.web.servlet.ModelAndView
	* @throws Exception
	*/
	@RequestMapping("/mas/sv/resetDlvNum.ajax")
	public ModelAndView resetDlvNum(@RequestParam("svRsvNum") String svRsvNum){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success",false);

		int updateRows = masRsvService.resetDlvNum(svRsvNum);
		if (updateRows == 1){
			resultMap.put("success",true);
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);
		return mav;
	}

    /**
     * 관광기념품 취소
     * 파일명 : svCancelRsv
     * 작성일 : 2016. 10. 14. 오후 3:56:32
     * 작성자 : 최영철
     * @param svRsvVO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/sv/cancelRsv.ajax")
    public ModelAndView svCancelRsv(@ModelAttribute("SVRSVVO") SV_RSVVO svRsvVO, HttpServletRequest request) throws Exception{
    	log.info("/mas/sv/cancelRsv.ajax Call" + svRsvVO.getSvRsvNum());

		/**
		 * 상품금액 : NML_AMT (업체가 판매한 금액),
		 * 구매금액 : SALE_AMT (고객이 결제한 금액),
		 * 취소수수료 : CMSS_AMT (취소발생시, 업체가 가져가는 금액)
		 * 취소금액 : CANCEL_AMT (취소발생시, 고객이 반환받는 금액)
		 * */

		/** 고객환불계좌 번호 set*/
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	String LGD_RFBANKCODE = request.getParameter("LGD_RFBANKCODE");
    	String LGD_RFACCOUNTNUM = request.getParameter("LGD_RFACCOUNTNUM");
    	String LGD_RFCUSTOMERNAME = request.getParameter("LGD_RFCUSTOMERNAME");

		/** 업체ID set*/
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	svRsvVO.setsCorpId(corpInfo.getCorpId());

		/** 상품정보 get */
    	SV_RSVVO rsvDtlVO = masRsvService.selectSvDetailRsv(svRsvVO);

		/** 결과변수 init  */
    	PAYVO payResult = new PAYVO();
    	String success = Constant.FLAG_N;
    	String cancelDiv = "";
    	String lpointCancelFlag = Constant.FLAG_N;
    	String userIp = EgovClntInfo.getClntIP(request);

		/** 예약/취소요청 상태는 취소 불가 */
    	if(!(rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_COM) || rsvDtlVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_CREQ))){
    		payResult.setPayRstInf("취소가능한 예약 상태가 아닙니다.");
    		resultMap.put("success", "N");
        	resultMap.put("payResult", payResult);
        	ModelAndView mav = new ModelAndView("jsonView", resultMap);
        	return mav;
    	}
		/** 취소금액 : 상품금액 - (취소수수료 + 쿠폰금액)*/
    	String cancelAmt = String.valueOf(Integer.parseInt(rsvDtlVO.getNmlAmt()) - (Integer.parseInt(svRsvVO.getCmssAmt()) + Integer.parseInt(rsvDtlVO.getDisAmt())));

		/** 취소수수료가 0원이면 구매금액이 취소 금액 */
		if("0".equals(svRsvVO.getCmssAmt())){
			cancelAmt = rsvDtlVO.getSaleAmt();
		}

		/** L.Point 사용 금액 */
		LPOINTUSEINFVO lpointUseInfVO = new LPOINTUSEINFVO();
		lpointUseInfVO.setRsvNum(svRsvVO.getRsvNum());
		lpointUseInfVO.setMaxSaleDtlRsvNum(svRsvVO.getSvRsvNum());
		lpointUseInfVO.setCancelYn(Constant.FLAG_N);
		lpointUseInfVO.setRsvCancelYn(Constant.FLAG_N);
		lpointUseInfVO = webOrderService.selectLpointUsePoint(lpointUseInfVO);

		if (lpointUseInfVO != null) {
			/** 취소금액이 LPOINT 이상 일 경우 LPOINT취소 */
			if((Integer.parseInt(cancelAmt) >= Integer.parseInt(lpointUseInfVO.getUsePoint()))){
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
				lpointCancelFlag = Constant.FLAG_Y;
			/** 취소금액이 LPOINT 미만이고, PG금액 초과면 환불 Case 4로 이동  */
			}else if((Integer.parseInt(cancelAmt) < Integer.parseInt(lpointUseInfVO.getUsePoint())) && Integer.parseInt(cancelAmt) > (Integer.parseInt(rsvDtlVO.getSaleAmt()) - Integer.parseInt(lpointUseInfVO.getUsePoint())) ){
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
			}
		}

		/** 파트너(협력사) 포인트 사용 금액 조회*/
		POINTVO pointVO = new POINTVO();
		pointVO.setTypes("USE");
		pointVO.setRsvNum(svRsvVO.getRsvNum());
		pointVO.setDtlRsvNum(svRsvVO.getSvRsvNum());
		POINTVO selPointVO = ossPointService.selectUsePoint(pointVO);

		String pointEx = Constant.FLAG_N;
		if (selPointVO != null) {
			if (selPointVO.getUsePoint() > 0) {
				//사용 포인트가 취소수수료보다 크면 포인트에서 먼저 차감.
				if (selPointVO.getUsePoint() >= Integer.parseInt(svRsvVO.getCmssAmt())) {
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - (selPointVO.getUsePoint() - Integer.parseInt(svRsvVO.getCmssAmt())));
				}

				//쿠폰이 있는상태에서 수수료 전체 취소 일 경우
//				if (Integer.parseInt(cancelAmt) < 0) {
//					pointEx = Constant.FLAG_Y;
//				}
			}
		}

		/** Case 1 : 취소수수료 0원 처리 */
		if("0".equals(svRsvVO.getCmssAmt())){
			log.info("cmss = 0");
			/** 토스결제취소 */
			Map<String, Object> payResultMap = masRsvService.cancelPay(svRsvVO.getPayDiv(), svRsvVO.getRsvNum(), svRsvVO.getSvRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);
			payResult = (PAYVO) payResultMap.get("payResult");
			success = (String) payResultMap.get("success");
			cancelDiv = "1";

			/** 탐나는전결제취소 */
			if(Constant.PAY_DIV_TC_WI.equals(svRsvVO.getPayDiv()) || Constant.PAY_DIV_TC_MI.equals(svRsvVO.getPayDiv())){
				success =  cancelTamnacard(svRsvVO.getRsvNum(), cancelAmt);
			}

			/** 취소완료건에 대해 예약건 업데이트 */
			if(Constant.FLAG_Y.equals(success)){
				svRsvVO.setCancelAmt(rsvDtlVO.getSaleAmt());
				svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

				svRsvVO.setCmssAmt("0");
				svRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
				webOrderService.updateSvCancelDtlRsv(svRsvVO);
				// 쿠폰 취소처리
				webOrderService.cancelUserCp(svRsvVO.getSvRsvNum());

				// 통합 예약건에 대한 처리
				RSVVO rsvVO = new RSVVO();
				rsvVO.setRsvNum(svRsvVO.getRsvNum());
				rsvVO.setTotalCancelAmt(rsvDtlVO.getSaleAmt());
				rsvVO.setTotalCmssAmt("0");
				rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());

				rsvVO.setModIp(userIp);
				masRsvService.updateCancelRsv(rsvVO);
			}

		}
		/** Case 2 : 취소수수료 100% 처리*/
		else if(rsvDtlVO.getNmlAmt().equals(svRsvVO.getCmssAmt())){
			log.info("수수료 100% 처리");
			cancelDiv = "1";

			// 수수료가 100%인 경우에는 예약 상태만 취소 처리함.

			svRsvVO.setCancelAmt("0");
			svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

			// 수수료 금액
//    		spRsvVO.setCmssAmt(String.valueOf(Integer.parseInt(rsvDtlVO.getNmlAmt()) - Integer.parseInt(rsvDtlVO.getDisAmt())));
			svRsvVO.setDisCancelAmt("0");
			webOrderService.updateSvCancelDtlRsv(svRsvVO);

			// 통합 예약건에 대한 처리
			RSVVO rsvVO = new RSVVO();
			rsvVO.setRsvNum(svRsvVO.getRsvNum());
			rsvVO.setTotalCancelAmt("0");
			rsvVO.setTotalCmssAmt(svRsvVO.getCmssAmt());
			rsvVO.setTotalDisCancelAmt("0");

			rsvVO.setModIp(userIp);
			masRsvService.updateCancelRsv(rsvVO);

			success = Constant.FLAG_Y;
		}
		/** Case 3 : 취소수수료 100% 처리 (쿠폰 & L.Point가 포함되어있는경우 ) */
		else if(rsvDtlVO.getSaleAmt().equals(svRsvVO.getCmssAmt())){
			log.info("saleAmt & cmss = 100%");
			cancelDiv = "1";
			/** 수수료가 100%인 경우에는 예약 상태만 취소 처리함. */
			svRsvVO.setCancelAmt("0");
			svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

			// 수수료 금액
//    		rcRsvVO.setCmssAmt(String.valueOf(Integer.parseInt(rsvDtlVO.getNmlAmt()) - Integer.parseInt(rsvDtlVO.getDisAmt())));
			svRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
			webOrderService.updateSvCancelDtlRsv(svRsvVO);
			// 쿠폰 취소처리
			webOrderService.cancelUserCp(svRsvVO.getSvRsvNum());

			// 통합 예약건에 대한 처리
			RSVVO rsvVO = new RSVVO();
			rsvVO.setRsvNum(svRsvVO.getRsvNum());
			rsvVO.setTotalCancelAmt("0");
			rsvVO.setTotalCmssAmt(svRsvVO.getCmssAmt());
			rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());

			rsvVO.setModIp(userIp);
			masRsvService.updateCancelRsv(rsvVO);

			success = Constant.FLAG_Y;
		}
		/** Case 4 : 취소금액이 마이너스 금액 처리(쿠폰 & L.Point가 포함되어있는경우)*/
		else if(Integer.parseInt(cancelAmt) < 0){
			cancelDiv = "1";
			/** 취소금액 = 상품금액 - 취소 수수료 */
			cancelAmt = String.valueOf(Integer.parseInt(rsvDtlVO.getNmlAmt()) - Integer.parseInt(svRsvVO.getCmssAmt()));

			/** Case 4-1 : 취소금액이 쿠폰금액보다 크거나 같은 경우,쿠폰 취소 처리 */
			if (Integer.parseInt(cancelAmt) >= Integer.parseInt(rsvDtlVO.getDisAmt())) {
				log.info("Case 4-1");
				cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(rsvDtlVO.getDisAmt()));
				webOrderService.cancelUserCp(svRsvVO.getSvRsvNum());
			}

			/** Case 4-2 : 취소금액-쿠폰금액이 L.Point 사용금액보다 크거나 같은 경우, L.Point 취소 처리 */
			if (lpointUseInfVO != null) {
				/** 취소금액이 LPOINT 이상 일 경우 LPOINT취소 */
				if((Integer.parseInt(cancelAmt) >= Integer.parseInt(lpointUseInfVO.getUsePoint()))){
					log.info("Case 4-2-1");
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
					lpointCancelFlag = Constant.FLAG_Y;
				/** 취소금액이 LPOINT 미만이고, PG금액 초과면 환불 */
				}else if((Integer.parseInt(cancelAmt) < Integer.parseInt(lpointUseInfVO.getUsePoint())) && Integer.parseInt(cancelAmt) > (Integer.parseInt(rsvDtlVO.getSaleAmt()) - Integer.parseInt(lpointUseInfVO.getUsePoint())) ){
					log.info("Case 4-2-2");
					cancelAmt = "" + (Integer.parseInt(cancelAmt) - Integer.parseInt(lpointUseInfVO.getUsePoint()));
				}
			}

			/** Case 4-3 : 취소금액-쿠폰금액-L.Point 사용금액) 반환 */
			if (Integer.parseInt(cancelAmt) > 0) {
				log.info("Case 4-3");
				Map<String, Object> payResultMap = masRsvService.cancelPay(svRsvVO.getPayDiv(), svRsvVO.getRsvNum(), svRsvVO.getSvRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);
				payResult = (PAYVO) payResultMap.get("payResult");
				success = (String) payResultMap.get("success");
			} else {
				success = Constant.FLAG_N;
			}
			/** 취소완료건에 대해 예약건 업데이트 */
			if(Constant.FLAG_Y.equals(success)){
				// RSV_STATUS_CD_CCOM(RS20 : 취소)
				svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

				// 취소금액
				svRsvVO.setCancelAmt(cancelAmt);
				svRsvVO.setCmssAmt(svRsvVO.getCmssAmt());
				svRsvVO.setDisCancelAmt("0");
				webOrderService.updateSvCancelDtlRsv(svRsvVO);

				// 통합 예약건에 대한 처리
				RSVVO rsvVO = new RSVVO();
				rsvVO.setRsvNum(svRsvVO.getRsvNum());
				rsvVO.setTotalCancelAmt(cancelAmt);
				rsvVO.setTotalCmssAmt(svRsvVO.getCmssAmt());
				rsvVO.setTotalDisCancelAmt("0");

				rsvVO.setModIp(userIp);
				masRsvService.updateCancelRsv(rsvVO);
			}
		/** 부분취소 */
		}else{
			log.info("last case");
			/** 부분취소 처리가능한 결제만, 부분취소 불가능한 결제(탐나는전)은 환불로 떨어짐 */
			if(Constant.PAY_DIV_LG_CI.equals(rsvDtlVO.getPayDiv())|| Constant.PAY_DIV_LG_KI.equals(rsvDtlVO.getPayDiv())|| Constant.PAY_DIV_LG_TI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_MI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_TA_PI.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_NP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_KP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_AP.equals(rsvDtlVO.getPayDiv()) || Constant.PAY_DIV_LG_TP.equals(rsvDtlVO.getPayDiv())){
				//관리자 직접 예약 일 경우에는 자동 취소 예외 처리 2021.06.22 chaewan.jung
				if (!"AR".equals(rsvDtlVO.getAppDiv())) {
					cancelDiv = "1";

					Map<String, Object> payResultMap = masRsvService.cancelPay(svRsvVO.getPayDiv(), svRsvVO.getRsvNum(), svRsvVO.getSvRsvNum(), cancelAmt, userIp, LGD_RFBANKCODE, LGD_RFACCOUNTNUM, LGD_RFCUSTOMERNAME);

					payResult = (PAYVO) payResultMap.get("payResult");
					success = (String) payResultMap.get("success");

					// 취소완료건에 대해 예약건 업데이트
					if (Constant.FLAG_Y.equals(success)) {
						// RSV_STATUS_CD_CCOM(RS20 : 취소)
						svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CCOM);

						// 취소금액
						svRsvVO.setCancelAmt(cancelAmt);
						svRsvVO.setCmssAmt(svRsvVO.getCmssAmt());
						svRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
						webOrderService.updateSvCancelDtlRsv(svRsvVO);
						// 쿠폰 취소처리
						webOrderService.cancelUserCp(svRsvVO.getSvRsvNum());

						// 통합 예약건에 대한 처리
						RSVVO rsvVO = new RSVVO();
						rsvVO.setRsvNum(svRsvVO.getRsvNum());
						rsvVO.setTotalCancelAmt(cancelAmt);
						rsvVO.setTotalCmssAmt(svRsvVO.getCmssAmt());
						rsvVO.setTotalDisCancelAmt(rsvDtlVO.getDisAmt());

						rsvVO.setModIp(userIp);
						masRsvService.updateCancelRsv(rsvVO);
					}
				}
			/** 부분취소 불가능 처리(탐나는전)*/
			}else{
				resultMap.put("success", "Y");
				payResult.setPayRstInf("취소성공");
			}
		}

    	// 처리가 정상적이지 않은 경우 환불요청 처리
    	if(Constant.FLAG_N.equals(success)){
    		// RSV_STATUS_CD_CREQ2(RS11 : 환불요청)
    		svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_CREQ2);
    		cancelDiv = "2";

    		// 취소금액
    		svRsvVO.setCancelAmt(cancelAmt);
    		svRsvVO.setDisCancelAmt(rsvDtlVO.getDisAmt());
    		webOrderService.updateSvCancelDtlRsv(svRsvVO);

    		success = Constant.FLAG_Y;
    	}

    	//문자/메일 전송
    	webOrderService.cancelRsvAutoSnedSMSEmail(rsvDtlVO.getSvRsvNum(), request);
    	
    	/** 취소 정상 처리건에 대해 구매 수량 제어 */
    	webOrderService.updateSvCntInfMin(rsvDtlVO);
    	/** 판매 통계 감소 처리 */
    	webOrderService.downSaleAnlsByDtlRsv(rsvDtlVO.getSvRsvNum());
    	/** L.Point 포인트 사용 취소 */
    	if (Constant.FLAG_Y.equals(lpointCancelFlag)) {
    		scheduleService.lpointUseCancel(lpointUseInfVO);
    	}

		/** 파트너(협력사) 포인트 사용 취소 */
		if (selPointVO != null && Constant.FLAG_Y.equals(success)) {
			if (selPointVO.getUsePoint() > 0) {
				selPointVO.setTypes("CANCEL");
				selPointVO.setContents("ALL_CANCEL"); //전체취소
				selPointVO.setPlusMinus("P");
				selPointVO.setPoint(selPointVO.getUsePoint());
				selPointVO.setCorpId(corpInfo.getCorpId());

				//1. 포인트 사용 전체 취소 처리
				ossPointService.insertPointCpSave(selPointVO);

				//2. 포인트 부분취소일 경우 처리
				if (Integer.parseInt(svRsvVO.getCmssAmt()) > 0 && Constant.FLAG_N.equals(pointEx)) {
					selPointVO.setTypes("USE");
					selPointVO.setContents("CMSS_AMT"); // 수수료 사용 처리
					selPointVO.setPlusMinus("M");

					if (Integer.parseInt(svRsvVO.getCmssAmt()) <= selPointVO.getUsePoint()) { //포인트 사용액이 더 많으면 수수료 전체 차감
						selPointVO.setPoint(Integer.parseInt(svRsvVO.getCmssAmt()));
					} else { //포인트 사용액이 더 적으면 사용한 포인트만큼 차감
						selPointVO.setPoint(selPointVO.getUsePoint());
					}
					ossPointService.insertPointCpSave(selPointVO);
				}
			}
		}

    	resultMap.put("cancelDiv", cancelDiv);
    	resultMap.put("success", success);
    	resultMap.put("payResult", payResult);

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;
    }

    @RequestMapping("/mas/sv/directRecvCompRsv.ajax")
    public ModelAndView directRecvCompRsv(@ModelAttribute("SVRSVVO") SV_RSVVO svRsvVO, HttpServletRequest request) throws Exception{
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	svRsvVO.setsCorpId(corpInfo.getCorpId());

    	SV_RSVVO rsvDtlVO = masRsvService.selectSvDetailRsv(svRsvVO);
    	if(rsvDtlVO == null){
    		resultMap.put("success", "N");

    	}else{
    		masRsvService.updateSVDirectRecvComp(rsvDtlVO);

    		resultMap.put("success", "Y");
    	}

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;
    }

    /**
     * 기념품 구매관리 엑셀 다운로드
     * 파일명 : svRsvListExcelDown
     * 작성일 : 2017. 1. 11. 오후 5:16:56
     * 작성자 : 최영철
     * @param rsvSVO
     * @return
     */
    @RequestMapping("/mas/svRsvListExcelDown.do")
    public void svRsvListExcelDown(@ModelAttribute("searchVO") RSVSVO rsvSVO, HttpServletRequest request, HttpServletResponse response) {
		log.info("/mas/svRsvListExcelDown.do 호출");
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		rsvSVO.setsCorpId(corpInfo.getCorpId());
		
		System.out.println("rsvSVO.getsStartDt()=" + rsvSVO.getsStartDt());
		System.out.println("rsvSVO.getsStartDt()=" + rsvSVO.getsEndDt());
		List<SV_RSVVO> resultList = masRsvService.selectSvRsvExcelList(rsvSVO);

		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100);
		// *** Sheet-------------------------------------------------
		// Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("구매내역");
		// 컬럼 너비 설정
		sheet1.setColumnWidth(0, 4000);
		sheet1.setColumnWidth(1, 3000);
		sheet1.setColumnWidth(2, 10000);
		sheet1.setColumnWidth(3, 6000);
		sheet1.setColumnWidth(4, 2000);
		sheet1.setColumnWidth(5, 6000);
		sheet1.setColumnWidth(6, 2000);
		sheet1.setColumnWidth(7, 2000);
		sheet1.setColumnWidth(8, 4000);
		sheet1.setColumnWidth(9, 2000);
		sheet1.setColumnWidth(10, 4000);
		sheet1.setColumnWidth(11, 10000);
		sheet1.setColumnWidth(12, 2000);
		sheet1.setColumnWidth(13, 2000);
		sheet1.setColumnWidth(14, 2000);
		// ----------------------------------------------------------
		CellStyle cellStyle = xlsxWb.createCellStyle();
		cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

		Row row = null;
		Cell cell = null;
		// 첫 번째 줄
		row = sheet1.createRow(0);
		// 첫 번째 줄에 Cell 설정하기-------------
		cell = row.createCell(0);
		cell.setCellValue("구매번호");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(1);
		cell.setCellValue("구매상태");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(2);
		cell.setCellValue("상품명");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(3);
		cell.setCellValue("옵션명");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(4);
		cell.setCellValue("구매수");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(5);
		cell.setCellValue("추가옵션명");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(6);
		cell.setCellValue("구매수");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(7);
		cell.setCellValue("구매자");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(8);
		cell.setCellValue("구매자 전화번호");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(9);
		cell.setCellValue("수령인");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(10);
		cell.setCellValue("수령인 전화번호");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(11);
		cell.setCellValue("수령인 주소");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(12);
		cell.setCellValue("배송시 요청사항");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(13);
		cell.setCellValue("판매금액");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(14);
		cell.setCellValue("결제수단");
		cell.setCellStyle(cellStyle);
		//---------------------------------
		for (int i = 0; i < resultList.size(); i++) {
			SV_RSVVO orderVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(orderVO.getRsvNum());

			cell = row.createCell(1);
            if(Constant.RSV_STATUS_CD_READY.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("구매처리중");
            } else if(Constant.RSV_STATUS_CD_COM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("구매완료");
            } else if(Constant.RSV_STATUS_CD_DLV.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("배송중");
            } else if(Constant.RSV_STATUS_CD_DLVE.equals(orderVO.getRsvStatusCd())) {
				cell.setCellValue("배송완료");
			} else if(Constant.RSV_STATUS_CD_CREQ.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("취소요청");
            } else if(Constant.RSV_STATUS_CD_CREQ2.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("환불요청");
            } else if(Constant.RSV_STATUS_CD_CCOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("취소완료");
            } else if(Constant.RSV_STATUS_CD_SREQ.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("부분환불요청");
            } else if(Constant.RSV_STATUS_CD_SCOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("부분환불완료");
            } else if(Constant.RSV_STATUS_CD_ACC.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("자동취소");
            } else if(Constant.RSV_STATUS_CD_UCOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("구매확정");
            } else if(Constant.RSV_STATUS_CD_ECOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("기간만료");
            }
			cell = row.createCell(2);
			cell.setCellValue(orderVO.getPrdtNm());

			cell = row.createCell(3);
			cell.setCellValue(orderVO.getDivNm() + " " + orderVO.getOptNm());

			cell = row.createCell(4);
			cell.setCellValue(orderVO.getBuyNum());

			cell = row.createCell(5);
			cell.setCellValue(orderVO.getAddOptNm());

			cell = row.createCell(6);
			if ("".equals(orderVO.getAddOptNm()) || orderVO.getAddOptNm() == null){
				cell.setCellValue("");
			}else{
				cell.setCellValue(orderVO.getBuyNum());
			}

			cell = row.createCell(7);
			cell.setCellValue(orderVO.getRsvNm());

			cell = row.createCell(8);
			cell.setCellValue(orderVO.getRsvTelnum());

			cell = row.createCell(9);
			cell.setCellValue(orderVO.getUseNm());

			cell = row.createCell(10);
			cell.setCellValue(orderVO.getUseTelnum());

			cell = row.createCell(11);
			cell.setCellValue(orderVO.getRoadNmAddr() + " " + orderVO.getDtlAddr());

			cell = row.createCell(12);
			cell.setCellValue(orderVO.getDlvRequestInf());

			cell = row.createCell(13);
			cell.setCellValue(orderVO.getNmlAmt());

			cell = row.createCell(14);
			for ( Constant.PAY_DIV payDiv : Constant.PAY_DIV.values() ) {
				if(orderVO.getPayDiv().equals(payDiv.getCode())){
					cell.setCellValue(payDiv.getName());
				}
			}
		}
		// excel 파일 저장
		try {
			// 실제 저장될 파일 이름
			String realName = "purchase.xlsx";

			String userAgent = request.getHeader("User-Agent");
			if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
				response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
			} else if(userAgent.indexOf("MSIE") >= 0) {
				response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
			} else if(userAgent.indexOf("Trident") >= 0) {
				response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
			} else if(userAgent.indexOf("Android") >= 0) {
				response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") );
			} else if(userAgent.indexOf("Swing") >= 0) {
				response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8")  + ";");
			} else if(userAgent.indexOf("Mozilla/5.0") >= 0) {		// 크롬, 파폭
				response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
			} else {
				response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
			}
			ServletOutputStream fileOutput = response.getOutputStream();

			xlsxWb.write(fileOutput);
			fileOutput.flush();
			fileOutput.close();

		} catch (FileNotFoundException e) {
			log.error(e);
			e.printStackTrace();
		} catch (IOException e) {
			log.error(e);
			e.printStackTrace();
		}
	}

	/** 탐나는전 결제취소(코나아이) */
	/*public String cancelTamnacard(String rsvNum, String cancelAmt) throws com.konasl.lib.remotepayment.json.simple.parser.ParseException, ExternalServiceException, IOException {
		String result;
		String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
		TAMNACARD_VO tamnacardVo = new TAMNACARD_VO();
		tamnacardVo.setRsvNum(rsvNum);
		tamnacardVo.setStatus("SUCCESS");
		tamnacardVo = webOrderService.selectTamnacardInfo(tamnacardVo);

		*//** 탐나는전 init*//*
		String KCOmercahntid = "";
		String KCOlicencekey = "";
		KCOnlinePaymentLib kcOnlinePaymentLib= new KCOnlinePaymentLib();
		if("test".equals(CST_PLATFORM.trim())) {
			KCOmercahntid = EgovProperties.getProperty("DEV.TAMNACARD.MERCHANTID");
			KCOlicencekey = EgovProperties.getProperty("DEV.TAMNACARD.LICENCEKEY");
			kcOnlinePaymentLib.init(KCOmercahntid, rsvNum, KCOlicencekey, EnvironmentType.DEV3);
		}else{
			KCOmercahntid = EgovProperties.getProperty("SERVICE.TAMNACARD.MERCHANTID");
			KCOlicencekey = EgovProperties.getProperty("SERVICE.TAMNACARD.LICENCEKEY");
			kcOnlinePaymentLib.init(KCOmercahntid, rsvNum, KCOlicencekey, EnvironmentType.PROD);
		}
		kcOnlinePaymentLib.merchantId(KCOmercahntid);
		kcOnlinePaymentLib.amount(tamnacardVo.getTrAmount());
		*//** yyMMddHHmmss*//*
		SimpleDateFormat sDate = new SimpleDateFormat("yyMMddHHmmss");
		sDate.format(new Date()).toString();
		kcOnlinePaymentLib.transactionDateTime(tamnacardVo.getTrDateTime());
		kcOnlinePaymentLib.approvalCode(tamnacardVo.getApprovalCode());
		kcOnlinePaymentLib.cancelAmount(tamnacardVo.getTrAmount());

		CancelTransactionResponse cancelTransactionResponse = kcOnlinePaymentLib.sendCancelTransactionRequest();

		*//** DB처리*//*
		ModelMapper modelMapper = new ModelMapper();
		TAMNACARD_VO dbVo  = modelMapper.map(cancelTransactionResponse, TAMNACARD_VO.class);
		dbVo.setRsvNum(rsvNum);
		dbVo.setPaySn("1");
		webOrderService.insertTamnacardInfo(dbVo);

		if("SUCCESS".equals(cancelTransactionResponse.getStatus())){
			result = Constant.FLAG_Y;
		}else{
			result = Constant.FLAG_N;
		}

		return result;
	}*/

	/** 탐나는전 결제취소(나이스정보) */
	public String cancelTamnacard(String rsvNum, String cancelAmt) throws IOException {

		String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");

		String mer_key = "";
		String symmKey = "";
		String symmIv = "";
		String mer_no = "";

		/** 탐나는전 개발계 */
		if("test".equals(CST_PLATFORM.trim())) {
			mer_key = "i1s8g528mw3o667v1s00w26ug88m3sj5gx1nj8wd";
			symmKey = "0q5u3qgg5521vky4h93u";
			symmIv  = "h203kcp0yjk1rq9lc874";
			mer_no  = "123020004701";
		/** 탐나는전 운영계 */
		}else{
			mer_key = "m6c0wm8sdqh2u0vo19z5a4meiiuizt2v9e9jm00g";
			symmKey = "f4v584x5m5ptv6jmymj8";
			symmIv  = "40562sai7vyl5b9yl8yv";
			mer_no  = "123010004171";
		}


		boolean testServer = true;				//나이스 테스트 서버 연결
		String result;

		TAMNACARD_VO tamnacardVo = new TAMNACARD_VO();
		tamnacardVo.setRsvNum(rsvNum);
		tamnacardVo.setStatus("SUCCESS");
		tamnacardVo = webOrderService.selectTamnacardInfo(tamnacardVo);

		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat tf = new SimpleDateFormat("HHmmss");

		Date today = new Date();
		String pos_date = df.format(today);
		String pos_time = tf.format(today);

		NmcLiteApprovalCancel nmcLite = new NmcLiteApprovalCancel(mer_key, symmKey, symmIv);

		/** 테스트 연동 (운영 변환시 주석 처리) */
		if("test".equals(CST_PLATFORM.trim())) {
			nmcLite.setTestServer(testServer);
		}

		nmcLite.setReqField("trace_no", System.currentTimeMillis() + "");		//요청 번호 (단순 로그 추적용)
		nmcLite.setReqField("mer_no", mer_no);										//가맹점번호
		nmcLite.setReqField("tid", tamnacardVo.getApprovalCode());      			 	//원거래 TID
		nmcLite.setReqField("goods_amt", cancelAmt); 								//취소 금액(전체금액)
		nmcLite.setReqField("cc_msg", "탐나오상점관리자취소"); 				//취소사유
		nmcLite.setReqField("net_cancel", "0"); 								//취소타입 0:일반 1:망취소
		nmcLite.setReqField("appr_req_dt", pos_date);								//요청일자
		nmcLite.setReqField("appr_req_tm", pos_time);								//요청시간

		// 승인 요청
		nmcLite.startAction();

		String result_code = nmcLite.getResValue("result_cd"); 						//응답코드 '0000' 경우 만 성공
		String result_msg = nmcLite.getResValue("result_msg");						//응답메시지

		String tid = nmcLite.getResValue("tid");             						//결제 고유번호
		//String param_mer_no = nmcLite.getResValue("mer_no");              				//가맹점번호
		String goods_amt = nmcLite.getResValue("goods_amt");              			//취소금액
		String appr_dt = nmcLite.getResValue("appr_dt");             				//취소일자
		String appr_tm = nmcLite.getResValue("appr_tm");              				//취소시간

		log.info("tamnacardCancelResultStatus : " + "{" + result_code + "," + result_msg + "," + tid + "," + goods_amt + "}");

		if(result_code.equals("0000")){
			/** DB처리*/
			TAMNACARD_VO dbVo  = new TAMNACARD_VO();
			dbVo.setRsvNum(rsvNum);
			dbVo.setApprovalCode(tid);
			dbVo.setTrDateTime(appr_dt+appr_tm);
			dbVo.setPaySn("1");
			dbVo.setPgNm("NICE");
			dbVo.setStatus("SUCCESS");
			webOrderService.insertTamnacardInfo(dbVo);
			result = Constant.FLAG_Y;
		}else{
			/** DB처리*/
			TAMNACARD_VO dbVo  = new TAMNACARD_VO();
			dbVo.setRsvNum(rsvNum);
			dbVo.setApprovalCode(tid);
			dbVo.setTrDateTime(appr_dt+appr_tm);
			dbVo.setPaySn("1");
			dbVo.setPgNm("NICE");
			dbVo.setStatus("FAILED");
			webOrderService.insertTamnacardInfo(dbVo);
			result = Constant.FLAG_N;
		}
		return result;
	}
}
