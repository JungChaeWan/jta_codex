package oss.rsv.web;


import api.service.*;
import api.vo.APILSVO;
import api.vo.APITLBookingLogVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import common.LowerHashMap;
import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.rsv.service.MasRsvService;
import mas.sv.service.MasSvService;
import mas.sv.vo.SV_ADDOPTINFVO;
import mas.sv.vo.SV_OPTINFVO;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssExcelService;
import oss.cmm.service.OssMailService;
import oss.cmm.vo.CDVO;
import oss.rsv.service.OssRsvService;
import oss.rsv.vo.OSS_RSVEXCELVO;
import oss.user.vo.REFUNDACCINFVO;
import oss.user.vo.USERVO;
import web.bbs.service.WebBbsService;
import web.bbs.vo.NOTICEVO;
import web.mypage.service.WebMypageService;
import web.mypage.service.WebUserCpService;
import web.mypage.vo.RSVFILEVO;
import web.mypage.vo.USER_CPVO;
import web.order.service.WebOrderService;
import web.order.vo.*;
import web.product.service.WebSvProductService;
import web.product.vo.WEB_DTLPRDTVO;
import web.product.vo.WEB_SV_DTLPRDTVO;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 최영철
 * @since 2015. 9. 16.
 * << 개정이력(Modification Information) >>
 * <p>
 * 수정일		수정자		수정내용
 * -------    	--------    ---------------------------
 * 2016.08.30	정동수		항공 예약 관련 내용 추가
 */
@Controller
public class OssRsvController {

    @Autowired
    private DefaultBeanValidator beanValidator;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name = "ossMailService")
    protected OssMailService ossMailService;

    @Resource(name = "ossRsvService")
    protected OssRsvService ossRsvService;

    @Resource(name = "ossExcelService")
    protected OssExcelService ossExcelService;

    @Resource(name = "webOrderService")
    protected WebOrderService webOrderService;

    @Resource(name = "apiAdService")
    private APIAdService apiAdService;

    @Resource(name = "ossCmmService")
    protected OssCmmService ossCmmService;

    @Resource(name = "webBbsService")
    protected WebBbsService webBbsService;

    /**
     * EgovMessageSource
     */
    @Resource(name = "egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "apiLsService")
    APILsService apiLsService;

    @Resource(name = "webSvService")
    WebSvProductService webSvService;

    @Resource(name = "masSvService")
    MasSvService masSvService;

    @Resource(name="webMypageService")
    protected WebMypageService webMypageService;

    @Autowired
    private APITLBookingService apitlBookingService;

    @Resource(name = "masRsvService")
	private MasRsvService masRsvService;

    @Resource(name = "apiService")
	private APIService apiService;

    @Resource(name="apiInsService")
	private APIInsService apiInsService;

    @Resource(name="apiRibbonService")
	private APIRibbonService apiRibbonService;

    @Resource(name="apiOrcService")
	private APIOrcService apiOrcService;

    @Resource(name="webUserCpService")
	private WebUserCpService webUserCpService;

    Logger log = LogManager.getLogger(this.getClass());


    /**
     * 예약내역 리스트
     * 파일명 : rsvList
     * 작성일 : 2015. 12. 9. 오후 7:04:23
     * 작성자 : 최영철
     *
     * @param rsvSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/rsvList.do")
    public String rsvList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
                          ModelMap model) {

        USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
        rsvSVO.setPartnerCode(loginVO.getPartnerCode());
        if (rsvSVO.getsAutoCancelViewYn() == null) {
            rsvSVO.setsAutoCancelViewYn("N");
        }
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

        Map<String, Object> resultMap = ossRsvService.selectRsvList(rsvSVO);

        @SuppressWarnings("unchecked")
        List<RSVVO> resultList = (List<RSVVO>) resultMap.get("resultList");

        @SuppressWarnings("unchecked")
        List<ORDERVO> orderList = (List<ORDERVO>) resultMap.get("orderList");

        // 총 건수 셋팅
        paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

        model.addAttribute("resultList", resultList);
        model.addAttribute("orderList", orderList);
        model.addAttribute("totalCnt", resultMap.get("totalCnt"));
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("ssPartnerCode", loginVO.getPartnerCode());

        return "/oss/rsv/rsvList";
    }

    /**
     * 예약 상세
     * 파일명 : detailRsv
     * 작성일 : 2015. 12. 29. 오전 9:53:10
     * 작성자 : 최영철
     *
     * @param rsvSVO
     * @param rsvVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/detailRsv.do")
    public String detailRsv(@ModelAttribute("searchVO") RSVSVO rsvSVO,
                            @ModelAttribute("rsvVO") RSVVO rsvVO,
                            ModelMap model) {

        USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
        rsvVO.setPartnerCode(loginVO.getPartnerCode());
        model.addAttribute("ssPartnerCode", loginVO.getPartnerCode());

        /** 예약 기본정보 */
        RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);
        model.addAttribute("rsvInfo", rsvInfo);

        /** 예약 상품리스트 */
        List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);

        /** LS컴퍼니 예약상품 Y/N */
        APILSVO apilsVO = new APILSVO();
        apilsVO.setRsvNum(rsvInfo.getRsvNum());

        apilsVO.setLsLinkYn("Y");
        if (apiLsService.checkSMSLsCompany(apilsVO) > 0) {
            model.addAttribute("lsSmsYn", "Y");
        } else {
            model.addAttribute("lsSmsYn", "N");
        }

        apilsVO.setLsLinkYn("H");
        if (apiLsService.checkSMSLsCompany(apilsVO) > 0) {
            model.addAttribute("hijejuSmsYn", "Y");
        } else {
            model.addAttribute("hijejuSmsYn", "N");
        }

        model.addAttribute("orderList", orderList);

        // 상담 정보
        NOTICEVO noticeVO = new NOTICEVO();
        noticeVO.setBbsNum("CALL");
        noticeVO.setSubject(rsvVO.getRsvNum());

        List<NOTICEVO> callList = webBbsService.selectNoticeList(noticeVO);

        model.addAttribute("callList", callList);

        //파일 리스트
        RSVFILEVO rsvFileVO = new RSVFILEVO();
        rsvFileVO.setRsvNum(rsvVO.getRsvNum());
        rsvFileVO.setCategory("PROVE_OSS");
        List<RSVFILEVO> fileList = webMypageService.selectRsvFileList(rsvFileVO);

        model.addAttribute("fileList", fileList);

        return "/oss/rsv/detailRsv";
    }

    @RequestMapping("/oss/selectRCpList.ajax")
    public ModelAndView selectRCpList(@ModelAttribute("USER_CPVO") USER_CPVO userCpVO,
                                       HttpServletRequest request) throws Exception {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        List<LowerHashMap> resultList = webUserCpService.selectUsedRCpList(userCpVO);

        resultMap.put("result", resultList);

        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /**
     * 협회 환불 완료 처리
     * 파일명 : refundComplete
     * 작성일 : 2015. 12. 29. 오전 9:53:00
     * 작성자 : 최영철
     *
     * @param orderVO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/refundComplete.ajax")
    public ModelAndView refundComplete(@ModelAttribute("ORDERVO") ORDERVO orderVO,
                                       HttpServletRequest request) throws Exception {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        String[] rsvNum = orderVO.getRsvNum().split(",");
        String[] prdtRsvNum = orderVO.getPrdtRsvNum().split(",");

        for (int i = 0; i < rsvNum.length; i++) {
            orderVO.setRsvNum(rsvNum[i]);
            orderVO.setPrdtRsvNum(prdtRsvNum[i]);
            webOrderService.refundComplete(orderVO, request);
        }

        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /**
     * 환불요청건 조회
     * 파일명 : refundRsvList
     * 작성일 : 2016. 1. 17. 오후 2:44:27
     * 작성자 : 최영철
     *
     * @param orderSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/refundRsvList.do")
    public String refundRsvList(@ModelAttribute("searchVO") ORDERSVO orderSVO, ModelMap model) {
        /** 은행코드 */
        List<CDVO> cdRfac = ossCmmService.selectCode("RFAC");
        model.addAttribute("cdRfac", cdRfac);

        if (!EgovStringUtil.isEmpty(orderSVO.getsPayDiv())) {
            String[] payDiv = orderSVO.getsPayDiv().split(",");
            List<String> carCdList = new ArrayList<String>();
            for (String sPayDiv : payDiv) {
                carCdList.add(sPayDiv);
            }
            orderSVO.setsPayDivs(carCdList);
        }

        if (StringUtils.isEmpty(orderSVO.getsRsvDiv())) {
            orderSVO.setsRsvDiv("sRsvDiv1");
        }

        orderSVO.setPageUnit(propertiesService.getInt("pageUnit"));
        orderSVO.setPageSize(propertiesService.getInt("pageSize"));

        /** paging setting */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(orderSVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(orderSVO.getPageUnit());
        paginationInfo.setPageSize(orderSVO.getPageSize());

        orderSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        orderSVO.setLastIndex(paginationInfo.getLastRecordIndex());
        orderSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> resultMap = ossRsvService.selectRefundList(orderSVO);

        @SuppressWarnings("unchecked")
        List<ORDERVO> orderList = (List<ORDERVO>) resultMap.get("orderList");

        // 총 건수 셋팅
        paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

        model.addAttribute("orderList", orderList);
        model.addAttribute("totalCnt", resultMap.get("totalCnt"));
        model.addAttribute("paginationInfo", paginationInfo);

        return "oss/rsv/refundRsvList";
    }

    /**
     * 예약정보 단건 조회
     * 파일명 : selectByPrdtRsvInfo
     * 작성일 : 2016. 1. 22. 오후 5:20:40
     * 작성자 : 최영철
     *
     * @param orderSVO
     * @return
     */
    @RequestMapping("/oss/selectByPrdtRsvInfo.ajax")
    public ModelAndView selectByPrdtRsvInfo(@ModelAttribute("searchVO") ORDERSVO orderSVO) {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        ORDERVO orderVO = ossRsvService.selectByPrdtRsvInfo(orderSVO);

        resultMap.put("orderVO", orderVO);

        REFUNDACCINFVO refundInfo = ossRsvService.selectByRefundAccInf(orderSVO);
        resultMap.put("refundInfo", refundInfo);


        ModelAndView mav = new ModelAndView("jsonView", resultMap);
        return mav;
    }

    /**
     * 환불정보 업데이트
     * 파일명 : updateRefundInfo
     * 작성일 : 2016. 1. 22. 오후 5:20:50
     * 작성자 : 최영철
     *
     * @param orderVO
     * @return
     */
    @RequestMapping("/oss/updateRefundInfo.ajax")
    public ModelAndView updateRefundInfo(@ModelAttribute("searchVO") ORDERVO orderVO) {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        ossRsvService.updateRefundInfo(orderVO);
        ModelAndView mav = new ModelAndView("jsonView", resultMap);
        return mav;
    }

    /**
     * 환불사유 수정
     */
    @RequestMapping("/oss/updateRefundRsn.ajax")
    public ModelAndView updateRefundRsn(@ModelAttribute("searchVO") ORDERVO orderVO) {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        ossRsvService.updateRefundRsn(orderVO);

        ModelAndView mav = new ModelAndView("jsonView", resultMap);
        return mav;
    }

    @RequestMapping("/oss/refundExcelDown1.do")
    public void refundExcelDown1(@ModelAttribute("searchVO") ORDERSVO orderSVO,
                                 HttpServletRequest request,
                                 HttpServletResponse response) {
        log.info("/oss/adjustExcelDown1.ajax 호출");
        if (!EgovStringUtil.isEmpty(orderSVO.getsPayDiv())) {
            String[] payDiv = orderSVO.getsPayDiv().split(",");

            List<String> carCdList = new ArrayList<String>();
            for (String sPayDiv : payDiv) {
                carCdList.add(sPayDiv);
            }
            orderSVO.setsPayDivs(carCdList);
        }

        orderSVO.setFirstIndex(0);
        orderSVO.setLastIndex(999999);

        Map<String, Object> resultMap = ossRsvService.selectRefundList(orderSVO);

        @SuppressWarnings("unchecked")
        List<ORDERVO> orderList = (List<ORDERVO>) resultMap.get("orderList");

        // Workbook 생성
        Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("환불요청내역");

        // 컬럼 너비 설정
        sheet1.setColumnWidth(0, 16 * 256);
        sheet1.setColumnWidth(1, 18 * 256);
        sheet1.setColumnWidth(2, 18 * 256);
        sheet1.setColumnWidth(3, 10 * 256);
        sheet1.setColumnWidth(4, 14 * 256);
        sheet1.setColumnWidth(5, 10 * 256);
        sheet1.setColumnWidth(6, 10 * 256);
        sheet1.setColumnWidth(7, 12 * 256);
        sheet1.setColumnWidth(8, 14 * 256);
        sheet1.setColumnWidth(9, 12 * 256);
        sheet1.setColumnWidth(10, 18 * 256);
        sheet1.setColumnWidth(11, 10 * 256);
        sheet1.setColumnWidth(12, 20 * 256);
        sheet1.setColumnWidth(13, 30 * 256);
        sheet1.setColumnWidth(14, 30 * 256);
        // ----------------------------------------------------------

        CellStyle headerStyle = xlsxWb.createCellStyle();
        headerStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        headerStyle.setAlignment(CellStyle.ALIGN_CENTER);

        CellStyle numericStyle = xlsxWb.createCellStyle();
        DataFormat df = xlsxWb.createDataFormat();
        numericStyle.setDataFormat(df.getFormat("#,##0"));
        numericStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

        CellStyle centerStyle = xlsxWb.createCellStyle();
        centerStyle.setAlignment(CellStyle.ALIGN_CENTER);
        centerStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        centerStyle.setWrapText(true);

        Row row;
        Cell cell;

        // 첫 번째 줄
        row = sheet1.createRow(0);

        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("예약번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(1);
        cell.setCellValue("예약일");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(2);
        cell.setCellValue("취소요청일");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(3);
        cell.setCellValue("예약자명");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(4);
        cell.setCellValue("전화번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(5);
        cell.setCellValue("판매금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(6);
        cell.setCellValue("환불금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(7);
        cell.setCellValue("결제수단");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(8);
        cell.setCellValue("비고");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(9);
        cell.setCellValue("은행");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(10);
        cell.setCellValue("계좌번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(11);
        cell.setCellValue("예금주");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(12);
        cell.setCellValue("업체명");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(13);
        cell.setCellValue("상품명");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(14);
        cell.setCellValue("상품정보");
        cell.setCellStyle(headerStyle);
        //---------------------------------

        String rsvStsCdNm = "";

        for (int i = 0; i < orderList.size(); i++) {
            ORDERVO orderVO = orderList.get(i);
            row = sheet1.createRow(i + 1);

            if (orderVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_CCOM)) {
                rsvStsCdNm = "환불완료";
            } else {
                rsvStsCdNm = "환불진행";
            }

            cell = row.createCell(0);
            cell.setCellStyle(centerStyle);
            cell.setCellValue(orderVO.getRsvNum() + "\r\n" + rsvStsCdNm);

            cell = row.createCell(1);
            cell.setCellStyle(centerStyle);
            cell.setCellValue(orderVO.getRegDttm());

            cell = row.createCell(2);
            cell.setCellStyle(centerStyle);
            cell.setCellValue(orderVO.getCancelRequestDttm());

            cell = row.createCell(3);
            cell.setCellStyle(centerStyle);
            cell.setCellValue(orderVO.getRsvNm());

            cell = row.createCell(4);
            cell.setCellStyle(centerStyle);
            cell.setCellValue(orderVO.getRsvTelnum());

            cell = row.createCell(5);
            cell.setCellStyle(numericStyle);
            cell.setCellValue(Integer.parseInt(orderVO.getNmlAmt()));

            cell = row.createCell(6);
            cell.setCellStyle(numericStyle);
            cell.setCellValue(Integer.parseInt(orderVO.getCancelAmt()));

            cell = row.createCell(7);
            cell.setCellStyle(centerStyle);
            String payDiv = "";
            if (Constant.PAY_DIV.PAY_DIV_LG_CI.getCode().equals(orderVO.getPayDiv())) {
                payDiv = Constant.PAY_DIV.PAY_DIV_LG_CI.getName();
            } else if (Constant.PAY_DIV.PAY_DIV_LG_HI.getCode().equals(orderVO.getPayDiv())) {
                payDiv = Constant.PAY_DIV.PAY_DIV_LG_HI.getName();
            } else if (Constant.PAY_DIV.PAY_DIV_LG_TI.getCode().equals(orderVO.getPayDiv())) {
                payDiv = Constant.PAY_DIV.PAY_DIV_LG_TI.getName();
            } else if (Constant.PAY_DIV.PAY_DIV_LG_ETI.getCode().equals(orderVO.getPayDiv())) {
                payDiv = Constant.PAY_DIV.PAY_DIV_LG_ETI.getName();
            } else if (Constant.PAY_DIV.PAY_DIV_LG_MI.getCode().equals(orderVO.getPayDiv())) {
                payDiv = Constant.PAY_DIV.PAY_DIV_LG_MI.getName();
            } else if (Constant.PAY_DIV.PAY_DIV_LG_EMI.getCode().equals(orderVO.getPayDiv())) {
                payDiv = Constant.PAY_DIV.PAY_DIV_LG_EMI.getName();
            } else if (Constant.PAY_DIV.PAY_DIV_LG_KI.getCode().equals(orderVO.getPayDiv())) {
                payDiv = Constant.PAY_DIV.PAY_DIV_LG_KI.getName();
            } else if (Constant.PAY_DIV.PAY_DIV_LG_LI.getCode().equals(orderVO.getPayDiv())) {
                payDiv = Constant.PAY_DIV.PAY_DIV_LG_LI.getName();
            } else if (Constant.PAY_DIV.PAY_DIV_TC_WC.getCode().equals(orderVO.getPayDiv())) {
                payDiv = Constant.PAY_DIV.PAY_DIV_TC_WC.getName();
            } else if (Constant.PAY_DIV.PAY_DIV_TC_MC.getCode().equals(orderVO.getPayDiv())) {
                payDiv = Constant.PAY_DIV.PAY_DIV_TC_MC.getName();
            }
            cell.setCellValue(payDiv);

            cell = row.createCell(8);
            cell.setCellValue(orderVO.getRefundRsn());

            cell = row.createCell(9);
            cell.setCellStyle(centerStyle);
            cell.setCellValue(orderVO.getRefundBankNm());

            cell = row.createCell(10);
            cell.setCellStyle(centerStyle);
            cell.setCellValue(orderVO.getRefundAccNum());

            cell = row.createCell(11);
            cell.setCellStyle(centerStyle);
            cell.setCellValue(orderVO.getRefundDepositor());

            cell = row.createCell(12);
            cell.setCellValue(orderVO.getCorpNm());

            cell = row.createCell(13);
            cell.setCellValue(orderVO.getPrdtNm());

            cell = row.createCell(14);
            cell.setCellValue(orderVO.getPrdtInf());
        }
        // excel 파일 저장
        try {
            // 실제 저장될 파일 이름
            Date today = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            String realName = "환불예약건_" + sdf.format(today) + ".xlsx";

            String userAgent = request.getHeader("User-Agent");
            if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
                response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("MSIE") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("Trident") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("Android") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8"));
            } else if (userAgent.indexOf("Swing") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("Mozilla/5.0") >= 0) { // 크롬, 파폭
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
            } else {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            }
            ServletOutputStream fileOutput = response.getOutputStream();

            xlsxWb.write(fileOutput);
            fileOutput.flush();
            fileOutput.close();

        } catch (FileNotFoundException e) {
            log.info(e);
        } catch (IOException e) {
            log.info(e);
        }
    }

    /**
     * 예약건의 예약상태 변경
     * Function : chgRsvStatus
     * 작성일 : 2018. 2. 2. 오후 2:28:44
     * 작성자 : 정동수
     *
     * @param rsvVO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/chgRsvStatus.ajax")
    public ModelAndView chgRsvStatus(@ModelAttribute("RSVVO") RSVVO rsvVO, HttpServletRequest request) throws Exception {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        //상품구분
        String prdtDiv = request.getParameter("prdtDiv");

        /** 숙소를 취소 상태로 변경 시 TLL 취소전송 보냄 */
        if ("AD".equals(prdtDiv) && "RS10".equals(rsvVO.getRsvStatusCd())){
            APITLBookingLogVO bookingCancel = apitlBookingService.bookingCancel(rsvVO.getPrdtRsvNum());
            //취소 전송이 성공 하면 로직 실행 후 실패 처리
            if ("N".equals(bookingCancel.getRsvResult())) {
                resultMap.put("success", "apiFail");
            }
        }

        /** 렌트카 API취소 */
		if ("RC".equals(prdtDiv) && "RS10".equals(rsvVO.getRsvStatusCd())) {
			/** 상품정보 get */
			RC_RSVVO rcRsvVO = new RC_RSVVO();
			rcRsvVO.setRcRsvNum(rsvVO.getPrdtRsvNum());
    		RC_RSVVO rsvDtlVO = masRsvService.selectRcDetailRsv(rcRsvVO);
    		/** 그림API취소*/
			if(Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && Constant.RC_RENTCAR_COMPANY_GRI.equals(rsvDtlVO.getApiRentDiv())) {
				String cancelResult = apiService.cancelGrimRcRsv(rsvDtlVO.getRcRsvNum());
				if(!cancelResult.equals("Y")){
				    resultMap.put("success", "apiFail");
                }
			}
			/** 인스API취소*/
			if(Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && Constant.RC_RENTCAR_COMPANY_INS.equals(rsvDtlVO.getApiRentDiv())) {
				Boolean resultCancel = apiInsService.revcancel(rsvDtlVO);
				if (!resultCancel) {
				    resultMap.put("success", "apiFail");
                }
			}
			/** 리본API취소*/
			if(Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && Constant.RC_RENTCAR_COMPANY_RIB.equals(rsvDtlVO.getApiRentDiv())) {
				Boolean resultCancel = apiRibbonService.carCancel(rsvDtlVO);
				if (!resultCancel) {
				    resultMap.put("success", "apiFail");
                }
			}
			/** 오르카API취소*/
			if(Constant.FLAG_Y.equals(rsvDtlVO.getLinkYn()) && Constant.RC_RENTCAR_COMPANY_ORC.equals(rsvDtlVO.getApiRentDiv())) {
				Boolean resultCancel = apiOrcService.vehicleCancel(rsvDtlVO);
				if (!resultCancel) {
				    resultMap.put("success", "apiFail");
                }
			}
		}

        webOrderService.chgRsvStatus(rsvVO);
        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /**
     * 예약건 예약 취소 문자/이메일 발송
     * Function : reqCancel
     * 작성일 : 2020.08.24
     * 작성자 : 김지연
     *
     * @param rsvVO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/reqCancel.ajax")
    public ModelAndView reqCancel(@ModelAttribute("RSVVO") RSVVO rsvVO, HttpServletRequest request) throws Exception {
        //문자
        webOrderService.reqCancelSnedSMS(rsvVO.getPrdtRsvNum());
        // Email 발송
        ossMailService.sendCancelRequestPrdt(rsvVO.getPrdtRsvNum(), request);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /**
     * 상품별예약관리
     * 파일명 : rsvAtPrdtList
     * 작성일 : 2016. 3. 2. 오후 3:29:23
     * 작성자 : 최영철
     *
     * @param rsvSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/rsvAtPrdtList.do")
    public String rsvAtPrdtList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
                                ModelMap model) {
        if (rsvSVO.getsAutoCancelViewYn() == null) {
            rsvSVO.setsAutoCancelViewYn("N");
        }
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

        Map<String, Object> resultMap = ossRsvService.selectRsvAtPrdtList(rsvSVO);

        @SuppressWarnings("unchecked")
        List<ORDERVO> resultList = (List<ORDERVO>) resultMap.get("resultList");

        // 총 건수 셋팅
        paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

        model.addAttribute("resultList", resultList);
        model.addAttribute("totalCnt", resultMap.get("totalCnt"));
        model.addAttribute("paginationInfo", paginationInfo);

        return "/oss/rsv/rsvAtPrdtList";
    }

    /**
     * 상품별예약관리 상세조회
     * 파일명 : detailRsvAtPrdt
     * 작성일 : 2016. 3. 2. 오후 3:36:34
     * 작성자 : 최영철
     *
     * @param rsvSVO
     * @param rsvVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/detailRsvAtPrdt.do")
    public String detailRsvAtPrdt(@ModelAttribute("searchVO") RSVSVO rsvSVO,
                                  @ModelAttribute("rsvVO") RSVVO rsvVO,
                                  ModelMap model) {

        // 예약기본정보
        RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

        model.addAttribute("rsvInfo", rsvInfo);

        // 예약 상품 리스트
        List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);

        model.addAttribute("orderList", orderList);

        return "/oss/rsv/detailRsvAtPrdt";
    }

    @RequestMapping("/oss/rsvExcelDown1.do")
    public void rsvExcelDown1(@ModelAttribute("searchVO") RSVSVO rsvSVO,
                              HttpServletRequest request,
                              HttpServletResponse response) {
        log.info("/oss/rsvExcelDown1.do 호출");

        List<ORDERVO> resultList = ossRsvService.selectRsvAtPrdtListAll(rsvSVO);

        // Workbook 생성
//        Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
        @SuppressWarnings("resource")
        SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100); // Excel 2007 이상, 대용량 Excel 처리에 적합
        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("예약내역");
        // 컬럼 너비 설정
        int i = 0;
        sheet1.setColumnWidth(i, 16 * 256);           // 예약번호
        sheet1.setColumnWidth(++i, 12 * 256);         // 상품구분
        sheet1.setColumnWidth(++i, 14 * 256);         // 상품번호
        sheet1.setColumnWidth(++i, 30 * 256);         // 상품명
        sheet1.setColumnWidth(++i, 40 * 256);         // 예약정보
        sheet1.setColumnWidth(++i, 40 * 256);         // 여행시작일
        sheet1.setColumnWidth(++i, 20 * 256);         // 업체명
        sheet1.setColumnWidth(++i, 10 * 256);         // 상품금액
        sheet1.setColumnWidth(++i, 10 * 256);         // 할인금액
        sheet1.setColumnWidth(++i, 10 * 256);         // 결제금액
        sheet1.setColumnWidth(++i, 10 * 256);         // 예약상태
        sheet1.setColumnWidth(++i, 20 * 256);         // 예약일시
        sheet1.setColumnWidth(++i, 10 * 256);         // 결제수단
        sheet1.setColumnWidth(++i, 12 * 256);         // 총상품금액
        sheet1.setColumnWidth(++i, 12 * 256);         // 총할인금액
        sheet1.setColumnWidth(++i, 12 * 256);         // 쿠폰명
        sheet1.setColumnWidth(++i, 12 * 256);         // L.POINT 사용
        sheet1.setColumnWidth(++i, 12 * 256);         // 파트너 코드
        sheet1.setColumnWidth(++i, 20 * 256);         // 파트너 POINT 사용
        sheet1.setColumnWidth(++i, 12 * 256);         // 총결제금액
        sheet1.setColumnWidth(++i, 12 * 256);         // L.POINT 적립
        sheet1.setColumnWidth(++i, 12 * 256);         // 예약ID
        sheet1.setColumnWidth(++i, 12 * 256);         // 이메일ID
        sheet1.setColumnWidth(++i, 8 * 256);          // 예약자
        sheet1.setColumnWidth(++i, 15 * 256);         // 예약자전화번호
        sheet1.setColumnWidth(++i, 8 * 256);          // 사용자
        sheet1.setColumnWidth(++i, 15 * 256);         // 사용자전화번호
        sheet1.setColumnWidth(++i, 10 * 256);         // 이벤트코드
        sheet1.setColumnWidth(++i, 8 * 256);          // 앱구분
        sheet1.setColumnWidth(++i, 8 * 256);          // 판매채널
        sheet1.setColumnWidth(++i, 20 * 256);         // 취소요청일시
        sheet1.setColumnWidth(++i, 20 * 256);         // 취소완료일시
        sheet1.setColumnWidth(++i, 40 * 256);          // 상담내역
        // ----------------------------------------------------------
        XSSFCellStyle headerStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        headerStyle.setFillForegroundColor(new XSSFColor(new java.awt.Color(234, 234, 234)));
        headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        headerStyle.setAlignment(CellStyle.ALIGN_CENTER);

        XSSFCellStyle numericStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        XSSFDataFormat df = (XSSFDataFormat) xlsxWb.createDataFormat();
        numericStyle.setDataFormat(df.getFormat("#,##0"));

        Row row;
        Cell cell;
        // 첫 번째 줄
        row = sheet1.createRow(0);
        // 첫 번째 줄에 Cell 설정하기-------------
        i = 0;
        cell = row.createCell(i);
        cell.setCellValue("예약번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("상품구분");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("상품번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("상품명");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("예약정보");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("여행시작일(사용일)");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("업체명");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("상품금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("할인금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("결제금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("예약상태");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("예약일시");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("결제수단");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("총상품금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("총할인금액");
        cell.setCellStyle(headerStyle);
        
        cell = row.createCell(++i);
        cell.setCellValue("쿠폰명");
        cell.setCellStyle(headerStyle);
        
        cell = row.createCell(++i);
        cell.setCellValue("L.Point 사용");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("파트너 코드");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("파트너 Point 사용");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("총결제금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("L.Point 적립");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("구매ID");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("이메일ID");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("예약자");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("예약자 전화번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("사용자");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("사용자 전화번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("이벤트 코드");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("앱 구분");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("판매채널");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("취소요청일시");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("취소완료일시");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("상담내용");
        cell.setCellStyle(headerStyle);

        String prevRsvNum;
        String rsvNum = "";

        for (int j = 0; j < resultList.size(); j++) {
            ORDERVO orderVO = resultList.get(j);

            prevRsvNum = rsvNum;
            rsvNum = orderVO.getRsvNum();

            row = sheet1.createRow(j + 1);

            i = 0;
            cell = row.createCell(i);
/*            if (!rsvNum.equals(prevRsvNum)) {*/
                cell.setCellValue(orderVO.getRsvNum());
/*            }*/
            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getPrdtCdNm());

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getPrdtNum());

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getPrdtNm());

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getPrdtInf());

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getStartDt());

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getCorpNm());

            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            cell.setCellValue(Integer.parseInt(orderVO.getNmlAmt()));

            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            cell.setCellValue(Integer.parseInt(orderVO.getDisAmt()));

            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            cell.setCellValue(Integer.parseInt(orderVO.getSaleAmt()));

            cell = row.createCell(++i);
            if (Constant.RSV_STATUS_CD_READY.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("예약처리중");
            } else if (Constant.RSV_STATUS_CD_COM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("예약");
            } else if (Constant.RSV_STATUS_CD_CREQ.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("취소요청");
            } else if (Constant.RSV_STATUS_CD_CREQ2.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("환불요청");
            } else if (Constant.RSV_STATUS_CD_CCOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("취소완료");
            } else if (Constant.RSV_STATUS_CD_SREQ.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("부분환불요청");
            } else if (Constant.RSV_STATUS_CD_SCOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("부분환불완료");
            } else if (Constant.RSV_STATUS_CD_ACC.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("자동취소");
            } else if (Constant.RSV_STATUS_CD_UCOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("사용완료");
            } else if (Constant.RSV_STATUS_CD_ECOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("기간만료");
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getRegDttm());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                for (Constant.PAY_DIV payDiv : Constant.PAY_DIV.values()) {
                    if (payDiv.getCode().equals(orderVO.getPayDiv())) {
                        cell.setCellValue(payDiv.getName());
                    }
                }
            }
            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(Integer.parseInt(orderVO.getTotalNmlAmt()));
            }
            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(Integer.parseInt(orderVO.getTotalDisAmt()));
            }
            
            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getCpNm());
            
            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(Integer.parseInt(orderVO.getLpointUsePoint()));
            }
            cell = row.createCell(++i);

            cell.setCellValue(orderVO.getPartnerCode());

            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);

                cell.setCellValue(orderVO.getUsePoint());

            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(Integer.parseInt(orderVO.getTotalSaleAmt()));
            }
            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(Integer.parseInt(orderVO.getLpointSavePoint()));
            }
            cell = row.createCell(++i);
/*            if (!rsvNum.equals(prevRsvNum)) {*/
                if (Constant.RSV_GUSET_NAME.equals(orderVO.getUserId())) {
                    cell.setCellValue("비회원");
                } else {
                    cell.setCellValue(orderVO.getUserId());
                }
/*            }*/
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getEmail());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getRsvNm());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getRsvTelnum());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getUseNm());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getUseTelnum());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getEvntCd());
            }

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getAppDiv());

            cell = row.createCell(++i);
            if ("AR".equals(orderVO.getAppDiv())){
                cell.setCellValue("NAVER");
            }else {
                cell.setCellValue(orderVO.getPartner());
            }

            cell = row.createCell(++i);
            String canCelReqDttm = orderVO.getCancelRequestDttm();
            if (orderVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_CREQ) ||
                orderVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_CREQ2) ||
                orderVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_CCOM)){
                if(canCelReqDttm == null){
                    canCelReqDttm = "DB취소";
                }else{
                    if (canCelReqDttm.equals(orderVO.getCancelCmplDttm())) {
                        canCelReqDttm = "업체취소";
                    }
                }
            }
            cell.setCellValue(canCelReqDttm);

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getCancelCmplDttm());

            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getNotice());
            }
        }
        // excel 파일 저장
        try {
            String realName = "예약_" + rsvSVO.getsStartDt() + "_" + rsvSVO.getsEndDt() + ".xlsx";

            String userAgent = request.getHeader("User-Agent");

            if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
                response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("MSIE") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("Trident") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("Android") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8"));
            } else if (userAgent.indexOf("Swing") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("Mozilla/5.0") >= 0) {        // 크롬, 파폭
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";charset=\"UTF-8\"");
            } else {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            }
            ServletOutputStream fileOutput = response.getOutputStream();

            xlsxWb.write(fileOutput);
            fileOutput.flush();
            fileOutput.close();
            //

        } catch (FileNotFoundException e) {
            log.info(e);
            e.printStackTrace();
        } catch (IOException e) {
            log.info(e);
            e.printStackTrace();
        }
    }

    @RequestMapping("/oss/rsvAvList.do")
    public String rsvAvList(@ModelAttribute("searchVO") AV_RSVSVO avRsvSVO,
                            ModelMap model) {
        avRsvSVO.setPageUnit(propertiesService.getInt("pageUnit"));
        avRsvSVO.setPageSize(propertiesService.getInt("pageSize"));

        /** paging setting */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(avRsvSVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(avRsvSVO.getPageUnit());
        paginationInfo.setPageSize(avRsvSVO.getPageSize());

        avRsvSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        avRsvSVO.setLastIndex(paginationInfo.getLastRecordIndex());
        avRsvSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        if (EgovStringUtil.isEmpty(avRsvSVO.getsSaleCorp())) {
            avRsvSVO.setsSaleCorp("ALL");
        }
        if (EgovStringUtil.isEmpty(avRsvSVO.getsRsvStatus())) {
            avRsvSVO.setsRsvStatus("ALL");
        }

        Map<String, Object> resultMap = ossRsvService.selectAvRsvList(avRsvSVO);

        @SuppressWarnings("unchecked")
        List<RSVVO> resultList = (List<RSVVO>) resultMap.get("resultList");

        // 총 건수 셋팅
        paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

        // 항공사 노선 리스트
        Map<String, String> airLineMap = new HashMap<String, String>();
        List<CDVO> airLineArr = ossCmmService.selectCode("AVLN");
        for (CDVO cd : airLineArr) {
            airLineMap.put(cd.getCdNum(), cd.getCdNm());
        }

        // 항공사 리스트
        Map<String, String> airCorpMap = new HashMap<String, String>();
        List<CDVO> airCorpArr = ossCmmService.selectCode("AVCP");
        for (CDVO cd : airCorpArr) {
            airCorpMap.put(cd.getCdNum(), cd.getCdNm());
        }

        model.addAttribute("airLineMap", airLineMap);
        model.addAttribute("airCorpMap", airCorpMap);
        model.addAttribute("resultList", resultList);
        model.addAttribute("totalCnt", resultMap.get("totalCnt"));
        model.addAttribute("paginationInfo", paginationInfo);

        return "/oss/rsv/rsvAvList";
    }

    /**
     * 항공 예약의 Excel 파일 업로드
     * Function : rsvAvExcelUpload
     * 작성일 : 2016. 8. 30. 오전 11:21:04
     * 작성자 : 정동수
     *
     * @param multiRequest
     * @param avRsvVO
     * @return
     * @throws Exception
     */
    @RequestMapping("/oss/rsvAvExcelUpload.do")
    public String rsvAvExcelUpload(final MultipartHttpServletRequest multiRequest,
                                   @ModelAttribute("AV_RSVVO") AV_RSVVO avRsvVO) throws Exception {
        log.info("/oss/rsvAvExcelUpload.do 호출");

        ossExcelService.uploadAvRsvExcel(avRsvVO, multiRequest);

        return "redirect:/oss/rsvAvList.do";
    }

    /**
     * 제주 특산/기념품 구매관리
     *
     * @param rsvSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/rsvSvList.do")
    public String rsvSvList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
                            ModelMap model) {
        if (rsvSVO.getsAutoCancelViewYn() == null) {
            rsvSVO.setsAutoCancelViewYn("N");
        }
        USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
        rsvSVO.setPartnerCode(loginVO.getPartnerCode());

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

        rsvSVO.setsPrdtCd(Constant.SV);
        Map<String, Object> resultMap = ossRsvService.selectRsvList(rsvSVO);

        @SuppressWarnings("unchecked")
        List<RSVVO> resultList = (List<RSVVO>) resultMap.get("resultList");

        @SuppressWarnings("unchecked")
        List<ORDERVO> orderList = (List<ORDERVO>) resultMap.get("orderList");

        // 총 건수 셋팅
        paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

        model.addAttribute("resultList", resultList);
        model.addAttribute("orderList", orderList);
        model.addAttribute("totalCnt", resultMap.get("totalCnt"));
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("ssPartnerCode", loginVO.getPartnerCode());

        return "/oss/rsv/rsvSvList";
    }

    /**
     * 제주 특산/기념품 구매 상세
     *
     * @param rsvSVO
     * @param rsvVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/detailRsvSv.do")
    public String detailSvRsv(@ModelAttribute("searchVO") RSVSVO rsvSVO,
                              @ModelAttribute("rsvVO") RSVVO rsvVO,
                              ModelMap model) {

        USERVO loginVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
        rsvSVO.setPartnerCode(loginVO.getPartnerCode());
        model.addAttribute("ssPartnerCode", loginVO.getPartnerCode());

        // 예약기본정보
        RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);
        model.addAttribute("rsvInfo", rsvInfo);

        // 예약 상품 리스트
        List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);
        model.addAttribute("orderList", orderList);

        // 상담 정보
        NOTICEVO noticeVO = new NOTICEVO();
        noticeVO.setBbsNum("CALL");
        noticeVO.setSubject(rsvVO.getRsvNum());

        List<NOTICEVO> callList = webBbsService.selectNoticeList(noticeVO);
        model.addAttribute("callList", callList);

        //파일 리스트
        RSVFILEVO rsvFileVO = new RSVFILEVO();
        rsvFileVO.setRsvNum(rsvVO.getRsvNum());
        rsvFileVO.setCategory("PROVE_OSS");
        List<RSVFILEVO> fileList = webMypageService.selectRsvFileList(rsvFileVO);
        model.addAttribute("fileList", fileList);

        return "/oss/rsv/detailRsvSv";
    }

    /**
     * 상품별 예약관리 특산/기념품 리스트
     * 파일명 : rsvAtSvPrdtList
     * 작성일 : 2016. 12. 27. 오전 11:16:28
     * 작성자 : 최영철
     *
     * @param rsvSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/rsvAtSvPrdtList.do")
    public String rsvAtSvPrdtList(@ModelAttribute("searchVO") RSVSVO rsvSVO,
                                  ModelMap model) {
        if (rsvSVO.getsAutoCancelViewYn() == null) {
            rsvSVO.setsAutoCancelViewYn("N");
        }
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

        Map<String, Object> resultMap = ossRsvService.selectRsvAtSvPrdtList(rsvSVO);

        @SuppressWarnings("unchecked")
        List<ORDERVO> resultList = (List<ORDERVO>) resultMap.get("resultList");

        // 총 건수 셋팅
        paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

        List<CDVO> cdList = ossCmmService.selectCode(Constant.SV_DIV);
        model.addAttribute("ctgrList", cdList);

        model.addAttribute("resultList", resultList);
        model.addAttribute("totalCnt", resultMap.get("totalCnt"));
        model.addAttribute("paginationInfo", paginationInfo);

        return "/oss/rsv/rsvAtSvPrdtList";
    }

    /**
     * 제주 특산/기념품 구매 상세
     *
     * @param rsvSVO
     * @param rsvVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/detailRsvAtSvPrdt.do")
    public String detailRsvAtSvPrdt(@ModelAttribute("searchVO") RSVSVO rsvSVO,
                                    @ModelAttribute("rsvVO") RSVVO rsvVO,
                                    ModelMap model) {

        // 예약기본정보
        RSVVO rsvInfo = webOrderService.selectByRsv(rsvVO);

        model.addAttribute("rsvInfo", rsvInfo);

        // 예약 상품 리스트
        List<ORDERVO> orderList = webOrderService.selectOrderList(rsvVO);

        model.addAttribute("orderList", orderList);

        return "/oss/rsv/detailRsvAtSvPrdt";
    }

    // 특산기념품 예약내역 엑셀 저장장
    @RequestMapping("/oss/rsvExcelDown2.do")
    public void rsvExcelDown2(@ModelAttribute("searchVO") RSVSVO rsvSVO,
                              HttpServletRequest request,
                              HttpServletResponse response) {
        log.info("/oss/rsvExcelDown2.do 호출");

        List<ORDERVO> resultList = ossRsvService.selectRsvAtSvPrdtListAll(rsvSVO);

        SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100);
        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("구매내역");
        // 컬럼 너비 설정
        int i = 0;
        sheet1.setColumnWidth(i, 16 * 256);       // 구매번호
        sheet1.setColumnWidth(++i, 14 * 256);       // 상품구분
        sheet1.setColumnWidth(++i, 14 * 256);       // 상품번호
        sheet1.setColumnWidth(++i, 30 * 256);       // 상품명
        sheet1.setColumnWidth(++i, 40 * 256);       // 구매정보
        sheet1.setColumnWidth(++i, 20 * 256);       // 업체명
        sheet1.setColumnWidth(++i, 40 * 256);       // 쿠폰명
        sheet1.setColumnWidth(++i, 10 * 256);      // 상품금액
        sheet1.setColumnWidth(++i, 10 * 256);      // 할인금액
        sheet1.setColumnWidth(++i, 10 * 256);      // 결제금액
        sheet1.setColumnWidth(++i, 10 * 256);      // 구매상태
        sheet1.setColumnWidth(++i, 20 * 256);      // 구매일시
        sheet1.setColumnWidth(++i, 10 * 256);      // 결제수단
        sheet1.setColumnWidth(++i, 12 * 256);       // 총상품금액
        sheet1.setColumnWidth(++i, 12 * 256);       // 총할인금액
        sheet1.setColumnWidth(++i, 12 * 256);       // L.POINT 사용
        sheet1.setColumnWidth(++i, 12 * 256);       // 파트너 코드
        sheet1.setColumnWidth(++i, 20 * 256);       // 파트너 POINT 사용
        sheet1.setColumnWidth(++i, 12 * 256);       // 총결제금액
        sheet1.setColumnWidth(++i, 12 * 256);       // L.POINT 적립
        sheet1.setColumnWidth(++i, 12 * 256);      // 구매ID
        sheet1.setColumnWidth(++i, 12 * 256);      // 구매ID
        sheet1.setColumnWidth(++i, 8 * 256);       // 구매자
        sheet1.setColumnWidth(++i, 15 * 256);      // 구매자전화번호
        sheet1.setColumnWidth(++i, 8 * 256);       // 수령인
        sheet1.setColumnWidth(++i, 15 * 256);      // 수령인전화번호
        sheet1.setColumnWidth(++i, 40 * 256);      // 주소
        sheet1.setColumnWidth(++i, 8 * 256);       // 우편번호
        sheet1.setColumnWidth(++i, 10 * 256);      // 이벤트코드
        sheet1.setColumnWidth(++i, 8 * 256);       // 앱구분
        sheet1.setColumnWidth(++i, 8 * 256);       // 판매채널
        sheet1.setColumnWidth(++i, 20 * 256);         // 취소요청일시
        sheet1.setColumnWidth(++i, 20 * 256);         // 취소완료일시
        sheet1.setColumnWidth(++i, 50 * 256);       // 상담내역
        // ----------------------------------------------------------
        XSSFCellStyle headerStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        headerStyle.setFillForegroundColor(new XSSFColor(new java.awt.Color(234, 234, 234)));
        headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        headerStyle.setAlignment(CellStyle.ALIGN_CENTER);

        XSSFCellStyle numericStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        XSSFDataFormat df = (XSSFDataFormat) xlsxWb.createDataFormat();
        numericStyle.setDataFormat(df.getFormat("#,##0"));

        Row row;
        Cell cell;
        // 첫 번째 줄
        row = sheet1.createRow(0);
        // 첫 번째 줄에 Cell 설정하기-------------
        i = 0;
        cell = row.createCell(i);
        cell.setCellValue("구매번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("상품구분");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("상품번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("상품명");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("구매정보");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("업체명");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("쿠폰명");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("상품금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("할인금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("결제금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("구매상태");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("구매일시");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("결제수단");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("총상품금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("총할인금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("L.Point 사용");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("파트너 코드");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("파트너 Point 사용");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("총결제금액");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("L.Point 적립");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("구매ID");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("이메일아이디");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("구매자");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("구매자 전화번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("수령인");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("수령인 전화번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("주소");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("우편번호");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("이벤트 코드");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("앱 구분");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("판매채널");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("취소요청일시");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("취소완료일시");
        cell.setCellStyle(headerStyle);

        cell = row.createCell(++i);
        cell.setCellValue("상담내역");
        cell.setCellStyle(headerStyle);

        String prevRsvNum;
        String rsvNum = "";

        for (int j = 0; j < resultList.size(); j++) {
            ORDERVO orderVO = resultList.get(j);

            prevRsvNum = rsvNum;
            rsvNum = orderVO.getRsvNum();

            row = sheet1.createRow(j + 1);

            i = 0;
            cell = row.createCell(i);
/*            if (!rsvNum.equals(prevRsvNum)) {*/
                cell.setCellValue(orderVO.getRsvNum());
/*            }*/
            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getPrdtCdNm());

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getPrdtNum());

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getPrdtNm());

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getPrdtInf());

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getCorpNm());

            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getCpNm());

            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            cell.setCellValue(Integer.parseInt(orderVO.getNmlAmt()));

            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            cell.setCellValue(Integer.parseInt(orderVO.getDisAmt()));

            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            cell.setCellValue(Integer.parseInt(orderVO.getSaleAmt()));

            cell = row.createCell(++i);
            if (Constant.RSV_STATUS_CD_READY.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("구매처리중");
            } else if (Constant.RSV_STATUS_CD_COM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("구매완료");
            } else if (Constant.RSV_STATUS_CD_DLV.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("배송중");
            } else if (Constant.RSV_STATUS_CD_DLVE.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("배송완료");
            } else if (Constant.RSV_STATUS_CD_CREQ.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("취소요청");
            } else if (Constant.RSV_STATUS_CD_CREQ2.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("환불요청");
            } else if (Constant.RSV_STATUS_CD_CCOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("취소완료");
            } else if (Constant.RSV_STATUS_CD_SREQ.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("부분환불요청");
            } else if (Constant.RSV_STATUS_CD_SCOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("부분환불완료");
            } else if (Constant.RSV_STATUS_CD_ACC.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("자동취소");
            } else if (Constant.RSV_STATUS_CD_UCOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("구매확정");
            } else if (Constant.RSV_STATUS_CD_ECOM.equals(orderVO.getRsvStatusCd())) {
                cell.setCellValue("기간만료");
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getRegDttm());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                for (Constant.PAY_DIV payDiv : Constant.PAY_DIV.values()) {
                    if (payDiv.getCode().equals(orderVO.getPayDiv())) {
                        cell.setCellValue(payDiv.getName());
                    }
                }
            }
            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(Integer.parseInt(orderVO.getTotalNmlAmt()));
            }
            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(Integer.parseInt(orderVO.getTotalDisAmt()));
            }
            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(Integer.parseInt(orderVO.getLpointUsePoint()));
            }
            cell = row.createCell(++i);

                cell.setCellValue(orderVO.getPartnerCode());

            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);

                cell.setCellValue(orderVO.getUsePoint());

            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(Integer.parseInt(orderVO.getTotalSaleAmt()));
            }
            cell = row.createCell(++i);
            cell.setCellStyle(numericStyle);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(Integer.parseInt(orderVO.getLpointSavePoint()));
            }
            cell = row.createCell(++i);
/*            if (!rsvNum.equals(prevRsvNum)) {*/
                if (Constant.RSV_GUSET_NAME.equals(orderVO.getUserId())) {
                    cell.setCellValue("비회원");
                } else {
                    cell.setCellValue(orderVO.getUserId());
                }
/*            }*/
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getEmail());
            }

            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getRsvNm());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getRsvTelnum());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getUseNm());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getUseTelnum());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getRoadNmAddr());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getPostNum());
            }
            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getEvntCd());
            }
            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getAppDiv());

            cell = row.createCell(++i);
            if ("AR".equals(orderVO.getAppDiv())){
                cell.setCellValue("NAVER");
            }else {
                cell.setCellValue(orderVO.getPartner());
            }

            cell = row.createCell(++i);
            String canCelReqDttm = orderVO.getCancelRequestDttm();
            if (orderVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_CREQ) ||
                orderVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_CREQ2) ||
                orderVO.getRsvStatusCd().equals(Constant.RSV_STATUS_CD_CCOM)){
                if(canCelReqDttm == null){
                    canCelReqDttm = "DB취소";
                }else{
                    if (canCelReqDttm.equals(orderVO.getCancelCmplDttm())) {
                        canCelReqDttm = "업체취소";
                    }
                }
            }
            cell.setCellValue(canCelReqDttm);


            cell = row.createCell(++i);
            cell.setCellValue(orderVO.getCancelCmplDttm());

            cell = row.createCell(++i);
            if (!rsvNum.equals(prevRsvNum)) {
                cell.setCellValue(orderVO.getNotice());
            }
        }
        // excel 파일 저장
        try {
            String realName = "구매" + rsvSVO.getsStartDt() + "_" + rsvSVO.getsEndDt() + ".xlsx";

            String userAgent = request.getHeader("User-Agent");

            if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) {  // MS IE 5.5 이하
                response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("MSIE") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("Trident") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("Android") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8"));
            } else if (userAgent.indexOf("Swing") >= 0) {
                response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
            } else if (userAgent.indexOf("Mozilla/5.0") >= 0) {       // 크롬, 파폭
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
     * 설명 : 관리자 예약 - 단건 페이지
     * 파일명 : adminRsvReg
     * 작성일 :
     * 작성자 : chaewan.jung
     * @param : []
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/adminRsvReg.do")
    public String adminRsvReg() {
        return "/oss/rsv/adminRsvReg";
    }

    /**
     * 설명 : 관리자 직접 예약 시스템에서 [상품 등록]
     * 파일명 : adminRsvRegAjax
     * 작성일 : 2021-06-17 오후 1:56
     * 작성자 : chaewan.jung
     *
     * @param : [request, model]
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/adminRsvReg.ajax")
    public String adminRsvRegAjax(HttpServletRequest request, ModelMap model) {
        String prdtNum = request.getParameter("prdtNum");

        //상품정보
        WEB_SV_DTLPRDTVO prdtVO = new WEB_SV_DTLPRDTVO();
        prdtVO.setPrdtNum(prdtNum);
        /** 상품이 보이지 않는상태 printYn="N" 이라도 상품이 구매가능하도록 변경 */
        prdtVO.setPreviewYn("Y");
        WEB_SV_DTLPRDTVO prdtInfo = webSvService.selectByPrdt(prdtVO);

        //옵션 정보
        SV_OPTINFVO sv_OPTINFVO = new SV_OPTINFVO();
        sv_OPTINFVO.setPrdtNum(prdtNum);
        List<SV_OPTINFVO> optionList = masSvService.selectPrdtOptionList(sv_OPTINFVO);

        //추가 옵션정보
        SV_ADDOPTINFVO sv_ADDOPTINFVO = new SV_ADDOPTINFVO();
        sv_ADDOPTINFVO.setPrdtNum(prdtNum);
        List<SV_ADDOPTINFVO> addOptList = masSvService.selectPrdtAddOptionList(sv_ADDOPTINFVO);

        model.addAttribute("prdtInfo", prdtInfo);
        model.addAttribute("optionList", optionList);
        model.addAttribute("addOptList", addOptList);

        return "/oss/rsv/adminRsvRegAjax";
    }

    /**
     * 설명 : 관리자 단건 예약 하기 실행
     * 파일명 : adminRsvRegOrder
     * 작성일 :
     * 작성자 : chaewan.jung
     * @param : [rsvVO, request]
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/adminRsvRegOrder.do")
    public String adminRsvRegOrder(@ModelAttribute("RSVVO") RSVVO rsvVO, HttpServletRequest request) throws Exception {
        String[] prdtNum = request.getParameterValues("prdtNum");
        String[] svDivSn = request.getParameterValues("svDivSn");
        String[] svOptSn = request.getParameterValues("selOptList");
        String[] addOptSn = request.getParameterValues("selAddOptList");
        String[] qty = request.getParameterValues("cnt");
        String[] dlvAmt = request.getParameterValues("dlvAmt");

        String directRecvYn = request.getParameter("directRecvYn");

        // 로그인 정보
        USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();

        // 접속 IP
        String userIp = EgovClntInfo.getClntIP(request);

        rsvVO.setUserId(userVO.getUserId());    // 사용자 아이디 셋팅
        rsvVO.setRegIp(userIp);                 // IP
        rsvVO.setModIp(userIp);                 // IP
        //rsvVO.setPayDiv(payDiv);              // 결제방법
        rsvVO.setAppDiv("AR");
        rsvVO.setLpointUsePoint("0");
        rsvVO.setLpointSavePoint("0");


        // 예약 기본 등록 및 예약번호 구하기
        String rsvNum = webOrderService.insertRsv(rsvVO);
        rsvVO.setRsvNum(rsvNum);

        //관광기념품 예약 처리
        WEB_SV_DTLPRDTVO searchVO = new WEB_SV_DTLPRDTVO();
        for(int i=0; i < prdtNum.length; i++){
            searchVO.setPrdtNum(prdtNum[i]);
            searchVO.setSvDivSn(svDivSn[i]);
            searchVO.setSvOptSn(svOptSn[i]);
            WEB_SV_DTLPRDTVO svProduct = webSvService.selectByCartPrdt(searchVO);
            SV_RSVVO svRsvVO = new SV_RSVVO();
            svRsvVO.setPrdtNm(svProduct.getPrdtNm()); // 상품명
            svRsvVO.setDivNm(svProduct.getPrdtDivNm()); // 구분명
            svRsvVO.setOptNm(svProduct.getOptNm()); // 옵션명
            svRsvVO.setDirectRecvYn(directRecvYn); // 직접 수령
            svRsvVO.setRsvNum(rsvNum);
            svRsvVO.setCorpId(svProduct.getCorpId());
            svRsvVO.setPrdtNum(svProduct.getPrdtNum());
            svRsvVO.setSvDivSn(svDivSn[i]);
            svRsvVO.setSvOptSn(svOptSn[i]);
            svRsvVO.setBuyNum(qty[i]);

            // 상품 정보
            String prdtInf = svProduct.getPrdtDivNm() + " " + svProduct.getOptNm();

            if(StringUtils.isNoneEmpty(addOptSn[i])) {
                SV_ADDOPTINFVO sv_ADDOPTINFVO = new SV_ADDOPTINFVO();
                sv_ADDOPTINFVO.setPrdtNum(prdtNum[i]);
                sv_ADDOPTINFVO.setAddOptSn(addOptSn[i]);
                SV_ADDOPTINFVO  svOptInfVO = masSvService.selectSvAddOptInf(sv_ADDOPTINFVO);
                prdtInf += " | " + svOptInfVO.getAddOptNm();

                svRsvVO.setAddOptNm(svOptInfVO.getAddOptNm()); //추가 옵션 명
                svRsvVO.setAddOptAmt(svOptInfVO.getAddOptAmt()); //추가 옵션 금액
            }else{
                svRsvVO.setAddOptAmt("0");
            }

            prdtInf += " | 수량 : " + qty[i];
            svRsvVO.setPrdtInf(prdtInf);

            // 예약가능여부 조회
            String salePrdtYn = webSvService.saleProductYn(prdtNum[i], svDivSn[i], svOptSn[i], Integer.parseInt(qty[i]));

            // 할인금액 설정
            svRsvVO.setDisAmt("0");

            // 예약가능여부 체크 후 가능이면 예약 상태로 변경
            if(Constant.FLAG_Y.equals(salePrdtYn)){
                svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_COM);
                svRsvVO.setDlvAmtDiv(svProduct.getDlvAmtDiv());
                svRsvVO.setDlvAmt(dlvAmt[i]);
                // 정산 시 처리위해 상품 금액에 배송비 포함
                svRsvVO.setNmlAmt(String.valueOf((Integer.parseInt(svProduct.getSaleAmt()) +Integer.parseInt(svRsvVO.getAddOptAmt())) * Integer.parseInt(qty[i]) + Integer.parseInt(dlvAmt[i])));
                // 판매금액  (할인금액이 없기 때문에 정산 금액 = 판매금액)
                svRsvVO.setSaleAmt(svRsvVO.getNmlAmt());

            }else{
                svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_EXP);
                svRsvVO.setNmlAmt("0");
                svRsvVO.setSaleAmt("0");
                svRsvVO.setDlvAmt("0");
            }

            // 할인 취소 금액
            svRsvVO.setDisCancelAmt("0");

            // 특산/기념품 상품예약처리
            webOrderService.insertSvAdminRsv(svRsvVO);

            // 판매 통계 MERGE
            webOrderService.mergeSaleAnls(svRsvVO.getPrdtNum());
        }

        // 예약처리 후 금액 합계 처리
        ossRsvService.updateTotalAmt(rsvVO);

        // SMS, 메일 발송
        //webOrderService.orderCompleteSnedSMSMail(rsvVO, request);

        return "redirect:/oss/adminRsvReg.do";
    }

    @RequestMapping("/oss/adminRsvRegExcel.do")
    public String adminRsvRegExcel(HttpServletRequest req, Model model) {
        String groupNo = (req.getParameter("groupNo") == null || "".equals(req.getParameter("groupNo"))) ? "0" : req.getParameter("groupNo");
        String corpDiv = (req.getParameter("corpDiv") == null || "".equals(req.getParameter("corpDiv"))) ? "SV" : req.getParameter("corpDiv"); //예약(업체) 구분
        String lastGroupNo = ossRsvService.getLastGroupNo(corpDiv); // 최근 엑셀 업로드 순번

        OSS_RSVEXCELVO ossRsvExcelVO = new OSS_RSVEXCELVO();
        ossRsvExcelVO.setGroupNo(Integer.valueOf(groupNo));
        ossRsvExcelVO.setCorpDiv(corpDiv);

        List<OSS_RSVEXCELVO> resultList = null;
        //네이버 상품+옵션명 List
        List<OSS_RSVEXCELVO> sPrdtOptNmList = null;
        int allCnt = 0; //엑셀 업로드한 Data 전체 갯수
        int verifyCnt = 0; //검증된 Data 추출갯수

        if(!"0".equals(groupNo)){
            allCnt = ossRsvService.selectExcelUpRsvCnt(ossRsvExcelVO);
            resultList = ossRsvService.selectRsvRegExcel(ossRsvExcelVO);
            verifyCnt = ossRsvService.getVerifyCnt(ossRsvExcelVO);
            sPrdtOptNmList = ossRsvService.selectSprdtOptNm(ossRsvExcelVO);
        }

        model.addAttribute("resultList", resultList);
        model.addAttribute("allCnt", allCnt);
        model.addAttribute("verifyCnt", verifyCnt);
        model.addAttribute("groupNo", groupNo);
        model.addAttribute("lastGroupNo", lastGroupNo);
        model.addAttribute("sPrdtOptNmList", sPrdtOptNmList);
        model.addAttribute("corpDiv",corpDiv);
        return "/oss/rsv/adminRsvRegExcel";
    }

    /**
     * 설명 : 관리자 직접 예약 시스템에서 [엑셀 상품 등록]
     * 파일명 : adminRsvRegExcelUp
     * 작성일 : 2021-11-10 오후 4:49
     * 작성자 : chaewan.jung
     * @param : [excelUpFile, model]
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/adminRsvRegExcelUp.do")
    public String adminRsvRegExcelUp(@RequestParam("excelUpFile") MultipartFile excelUpFile, ModelMap model, HttpServletRequest req) throws IOException {
        String corpDiv = (req.getParameter("corpDiv") == null || "".equals(req.getParameter("corpDiv"))) ? "SV" : req.getParameter("corpDiv"); //예약(업체) 구분

        //validate
        String extension = FilenameUtils.getExtension(excelUpFile.getOriginalFilename());
        if (!extension.equals("xlsx") && !extension.equals("xls")) {
            throw new IOException("엑셀파일만 업로드 해주세요.");
        }

        //확장자에 따라 분리
        Workbook workbook = null;
        if (extension.equals("xlsx")) {
            workbook = new XSSFWorkbook(excelUpFile.getInputStream());
        } else if (extension.equals("xls")) {
            workbook = new HSSFWorkbook(excelUpFile.getInputStream());
        }

        //Log(확인) Table에 저장
        Integer groupNo = ossRsvService.insertRsvRegExcelUp(workbook, excelUpFile, corpDiv);

        //저장된 구매 list 호출
       model.addAttribute("groupNo", groupNo);
        return "redirect:/oss/adminRsvRegExcel.do?corpDiv="+corpDiv;
    }

    /**
     * 설명 : 관리자 직접 예약 시스템에서 [예약]
     * 파일명 : adminRsvRegExcelOrder
     * 작성일 : 2021-11-15 오후 3:22
     * 작성자 : chaewan.jung
     * @param : [req]
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/adminRsvRegExcelOrder.do")
    public String adminRsvRegExcelOrder(HttpServletRequest req) throws Exception {
        // 로그인 정보
        USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
        String userIp = EgovClntInfo.getClntIP(req); // 접속 IP
        String groupNo = (req.getParameter("groupNo") == null || "".equals(req.getParameter("groupNo"))) ? "0" : req.getParameter("groupNo");
        String corpDiv = (req.getParameter("corpDiv") == null || "".equals(req.getParameter("corpDiv"))) ? "SV" : req.getParameter("corpDiv"); //예약(업체) 구분

        // 예약 List
        OSS_RSVEXCELVO ossRsvExcelVO = new OSS_RSVEXCELVO();
        ossRsvExcelVO.setGroupNo(Integer.valueOf(groupNo));
        ossRsvExcelVO.setCorpDiv(corpDiv);
        List<OSS_RSVEXCELVO> resultList = ossRsvService.selectRsvRegExcel(ossRsvExcelVO);

        for(OSS_RSVEXCELVO item: resultList){
            //예약 완료 상태가 아닌 Data만 처리
            if(!"Y".equals(item.getRsvCompleteYn())) {
                RSVVO rsvVO = new RSVVO();
                rsvVO.setUserId(userVO.getUserId());                // 사용자 아이디 셋팅
                rsvVO.setRegIp(userIp);                             // IP
                rsvVO.setModIp(userIp);                             // IP
                rsvVO.setAppDiv("AR");
                rsvVO.setLpointUsePoint("0");
                rsvVO.setLpointSavePoint("0");
                rsvVO.setRsvNm(item.getRsvNm());
                rsvVO.setRsvTelnum(item.getRsvTelnum());
                rsvVO.setUseNm(item.getUseNm());
                rsvVO.setUseTelnum(item.getUseTelnum());
                rsvVO.setPayDiv(item.getPayDiv());                  // 결제방법
                rsvVO.setPostNum(item.getPostNum());
                rsvVO.setRoadNmAddr(item.getRoadNmAddr());
                rsvVO.setDtlAddr(item.getDtlAddr());
                rsvVO.setDlvRequestInf(item.getDlvRequestInf());    //배송요청사항
                rsvVO.setCorpDiv(corpDiv);

                // 예약 기본 등록 및 예약번호 구하기
                String rsvNum = webOrderService.insertRsv(rsvVO);
                rsvVO.setRsvNum(rsvNum);

                //특산/기념품
                if ("SV".equals(corpDiv)) {
                    SV_RSVVO svRsvVO = new SV_RSVVO();
                    svRsvVO.setPrdtNm(item.getPrdtNm()); // 상품명
                    svRsvVO.setDivNm(item.getPrdtDivNm()); // 구분명
                    svRsvVO.setOptNm(item.getOptNm()); // 옵션명
                    svRsvVO.setDirectRecvYn(item.getDirectRecvYn()); // 직접 수령

                    svRsvVO.setRsvNum(rsvNum);
                    svRsvVO.setCorpId(item.getCorpId());
                    svRsvVO.setPrdtNum(item.getPrdtNum());
                    svRsvVO.setSvDivSn(item.getDivSn());
                    svRsvVO.setSvOptSn(item.getOptSn());
                    svRsvVO.setBuyNum(item.getBuyNum());

                    // 상품 정보
                    String prdtInf = item.getPrdtDivNm() + " " + item.getOptNm();

                    if (StringUtils.isNoneEmpty(item.getAddOptSn())) {
                        SV_ADDOPTINFVO sv_ADDOPTINFVO = new SV_ADDOPTINFVO();
                        sv_ADDOPTINFVO.setPrdtNum(item.getPrdtNum());
                        sv_ADDOPTINFVO.setAddOptSn(item.getAddOptSn());
                        SV_ADDOPTINFVO svOptInfVO = masSvService.selectSvAddOptInf(sv_ADDOPTINFVO);
                        prdtInf += " | " + svOptInfVO.getAddOptNm();

                        svRsvVO.setAddOptNm(svOptInfVO.getAddOptNm()); //추가 옵션 명
                        svRsvVO.setAddOptAmt(svOptInfVO.getAddOptAmt()); //추가 옵션 금액
                    } else {
                        svRsvVO.setAddOptAmt("0");
                    }

                    prdtInf += " | 수량 : " + item.getBuyNum();
                    svRsvVO.setPrdtInf(prdtInf);
                    svRsvVO.setDisAmt("0"); // 할인금액 설정
                    svRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_COM); // 예약 상태로 변경
                    svRsvVO.setDlvAmtDiv(item.getDlvAmtDiv());
                    svRsvVO.setDlvAmt(item.getDlvAmt());
                    svRsvVO.setNmlAmt(String.valueOf((Integer.parseInt(item.getSaleAmt()) + Integer.parseInt(svRsvVO.getAddOptAmt())) * Integer.parseInt(item.getBuyNum()) + Integer.parseInt(item.getDlvAmt()))); // 정산 시 처리위해 상품 금액에 배송비 포함
                    svRsvVO.setSaleAmt(svRsvVO.getNmlAmt()); // 판매금액  (할인금액이 없기 때문에 정산 금액 = 판매금액)
                    svRsvVO.setDisCancelAmt("0"); // 할인 취소 금액

                    // 특산/기념품 상품예약처리
                    webOrderService.insertSvAdminRsv(svRsvVO);

                    // 판매 통계 MERGE
                    webOrderService.mergeSaleAnls(svRsvVO.getPrdtNum());

                    // 예약처리 후 금액 합계 처리
                    ossRsvService.updateTotalAmt(rsvVO);

                    //예약 완료 상태로 업데이트
                    ossRsvService.updateRsvComplete(item.getSeq());

                }

                //소셜
                if ("SP".equals(corpDiv)) {
                    SP_RSVVO spRsvVO = new SP_RSVVO();
                    spRsvVO.setPrdtNm(item.getPrdtNm()); // 상품명
                    spRsvVO.setDivNm(item.getPrdtDivNm()); // 구분명
                    spRsvVO.setOptNm(item.getOptNm()); // 옵션명

                    // 상품 정보
                    String prdtInf = item.getPrdtDivNm() + " ";

                    prdtInf += item.getOptNm();
                    if (StringUtils.isNoneEmpty(item.getAddOptNm())) {
                        prdtInf += " | " + item.getAddOptNm();
                    }
                    prdtInf += " | 수량 : " + item.getBuyNum();
                    spRsvVO.setPrdtInf(prdtInf);

                    spRsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_COM); // 예약 상태로 변경

                    if (StringUtils.isNotEmpty(item.getAddOptAmt())) {
                        spRsvVO.setAddOptAmt(item.getAddOptAmt());
                    } else {
                        spRsvVO.setAddOptAmt("0");
                    }

                    spRsvVO.setNmlAmt(String.valueOf((Integer.parseInt(item.getSaleAmt()) + Integer.parseInt(spRsvVO.getAddOptAmt())) * Integer.parseInt(item.getBuyNum())));
                    spRsvVO.setSaleAmt(spRsvVO.getNmlAmt()); // 판매금액  (할인금액이 없기 때문에 정산 금액 = 판매금액)
                    spRsvVO.setDisAmt("0"); // 할인금액 설정
                    spRsvVO.setPrdtDiv(item.getPrdtDiv()); // 상품 구분
                    // 적용 일자
                    //spRsvVO.setAplDt(spProduct.getAplDt());
                    // 유효일 수로 할 경우.
                    if (Constant.FLAG_Y.equals(item.getExprDaynumYn())) {
                        spRsvVO.setExprStartDt(new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()));
                        Calendar now = Calendar.getInstance();
                        now.add(Calendar.DATE, item.getExprDaynum());
                        spRsvVO.setExprEndDt(new SimpleDateFormat("yyyyMMdd").format(now.getTime()));
                    } else {
                        // 유효 종료 일자
                        spRsvVO.setExprEndDt(item.getExprEndDt());
                        // 유효시작일자.
                        spRsvVO.setExprStartDt(item.getExprStartDt());
                    }
                    if (item.getUseAbleTm() != null && !StringUtils.isEmpty(String.valueOf(item.getUseAbleTm()))) {
                        Calendar now = Calendar.getInstance();
                        now.add(Calendar.HOUR, item.getUseAbleTm());
                        spRsvVO.setUseAbleDttm(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(now.getTime()));
                    }

                    spRsvVO.setRsvNum(rsvNum);
                    spRsvVO.setCorpId(item.getCorpId());
                    spRsvVO.setPrdtNum(item.getPrdtNum());
                    spRsvVO.setSpDivSn(item.getDivSn());
                    spRsvVO.setSpOptSn(item.getOptSn());
                    spRsvVO.setBuyNum(item.getBuyNum());
                    spRsvVO.setAddOptNm(item.getAddOptNm());
                    // 할인 취소 금액
                    spRsvVO.setDisCancelAmt("0");

                    // 소셜상품예약처리
                    String spRsvNum = webOrderService.insertSpRsv(spRsvVO);
                    boolean result = apiService.apiReservation(rsvNum);

                    if(!result){
                        rsvVO.setRsvStatusCd(Constant.RSV_STATUS_CD_ACC); // 자동취소 상태로 변경
                        webOrderService.updateAcc(rsvVO);
                        break;
                    }

                    // 판매 통계 MERGE
                    webOrderService.mergeSaleAnls(spRsvVO.getPrdtNum());

                    // 예약처리 후 금액 합계 처리
                    ossRsvService.updateTotalAmt(rsvVO);

                    //예약 완료 상태로 업데이트
                    ossRsvService.updateRsvComplete(item.getSeq());
                }
            }
        }

        return "/oss/rsv/adminRsvRegExcel";
    }

    /**
    * 설명 : 관리자 직접 예약 upload 후 데이터 매칭 작업
    * 파일명 : adminRsvMatch
    * 작성일 : 2023-03-27 오후 5:12
    * 작성자 : chaewan.jung
    * @param : [ossRsvexcelVO]
    * @return : org.springframework.web.servlet.ModelAndView
    * @throws Exception
    */
    @RequestMapping("/oss/adminRsvMatch.ajax")
    public ModelAndView adminRsvMatch(@ModelAttribute("OSS_RSVEXCELVO") OSS_RSVEXCELVO ossRsvexcelVO) {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        ossRsvexcelVO.setsPrdtOptNm(ossRsvexcelVO.getsPrdtOptNm().replace(" ",""));
        ossRsvService.updateRsvMatch(ossRsvexcelVO);
        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

    /**
    * 설명 : OSS 예약관리 - 예약 기본 정보 수정
    * 파일명 : updateRsvInfo
    * 작성일 : 2024-08-27 오후 4:25
    * 작성자 : chaewan.jung
    * @param : [ossRsvexcelVO]
    * @return : org.springframework.web.servlet.ModelAndView
    * @throws Exception
    */
    @RequestMapping("/oss/updateRsvInfo.ajax")
    public ModelAndView updateRsvInfo(@ModelAttribute("RSVVO") RSVVO rsvVO) {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        ossRsvService.updateRsvInfo(rsvVO);
        ModelAndView mav = new ModelAndView("jsonView", resultMap);

        return mav;
    }

}
