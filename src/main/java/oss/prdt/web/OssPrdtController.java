package oss.prdt.web;


import api.service.APIAdService;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovWebUtil;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.cmmn.service.SmsService;
import egovframework.cmmn.vo.MMSVO;
import egovframework.cmmn.vo.SMSVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.ad.service.impl.AdDAO;
import mas.ad.vo.AD_ADDAMTVO;
import mas.ad.vo.AD_AMTINFSVO;
import mas.ad.vo.AD_AMTINFVO;
import mas.ad.vo.AD_PRDTINFVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.*;
import org.apache.commons.io.FilenameUtils;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.ad.vo.AD_WEBDTLSVO;
import oss.ad.vo.AD_WEBDTLVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.*;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.prdt.service.OssPrdtService;
import oss.prdt.vo.PRDTSVO;
import oss.prdt.vo.PRDTVO;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;
import web.mypage.vo.POCKETVO;
import web.product.service.WebAdProductService;
import web.product.service.WebRcProductService;
import web.product.service.WebSpProductService;
import web.product.vo.WEB_SPPRDTVO;
import web.product.vo.WEB_SPSVO;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
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
public class OssPrdtController {

    @Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name="ossPrdtService")
	protected OssPrdtService ossPrdtService;

	@Resource(name="apiAdService")
    private APIAdService apiAdService;

	@Resource(name="ossUserService")
	private OssUserService ossUserService;

	@Resource(name="smsService")
	protected SmsService smsService;

	@Resource(name="adDAO")
	private AdDAO adDAO;

	@Resource(name="masRcPrdtService")
	private MasRcPrdtService masRcPrdtService;

	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	//private String m_strSuksoDomain = "pension.todayjeju.net";
	//private String m_strOK = "OK!";

    Logger log = (Logger) LogManager.getLogger(this.getClass());

    @RequestMapping("/oss/prdtList.do")
    public String prdtList(@ModelAttribute("searchVO") PRDTSVO prdtSVO,
				    		ModelMap model){
    	prdtSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	prdtSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prdtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prdtSVO.getPageUnit());
		paginationInfo.setPageSize(prdtSVO.getPageSize());

		prdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossPrdtService.selectPrdtList(prdtSVO);

		@SuppressWarnings("unchecked")
		List<PRDTVO> resultList = (List<PRDTVO>) resultMap.get("resultList");


		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

    	return "/oss/product/prdtList";
    }
    
    @RequestMapping("/oss/prdtListExcel.do")
    public void prdtListExcel(@ModelAttribute("searchVO") PRDTSVO prdtSVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ParseException{
    	/* 엑셀 레코드 MAX COUNT 999999개 */
		prdtSVO.setFirstIndex(0);
		prdtSVO.setLastIndex(999999);
		
		SimpleDateFormat df_in = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat df_output = new SimpleDateFormat("yyyy-MM-dd");
		Map<String, Object> resultMap = ossPrdtService.selectPrdtList(prdtSVO);
		
		@SuppressWarnings("unchecked")
		List<PRDTVO> resultList = (List<PRDTVO>) resultMap.get("resultList");

		//Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
        Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("입점업체내역");

        // 컬럼 너비 설정
        sheet1.setColumnWidth( 0, 2000);		//번호
        sheet1.setColumnWidth( 1, 3000); 		//상품번호
        sheet1.setColumnWidth( 2, 3000);		//상태
        sheet1.setColumnWidth( 3, 5000);		//업체명
        sheet1.setColumnWidth( 4, 5000);		//상품명
        sheet1.setColumnWidth( 5, 3000);		//요청일
        sheet1.setColumnWidth( 6, 3000);		//승인일

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
        cell.setCellValue("요청일");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(6);
        cell.setCellValue("승인일");
        cell.setCellStyle(cellStyle);

		for (int i = 0; i < resultList.size(); i++) {
			PRDTVO prdtVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(i + 1);

			cell = row.createCell(1);
			cell.setCellValue(prdtVO.getPrdtNum());
			
			cell = row.createCell(2);
			cell.setCellValue(prdtVO.getTradeStatusNm());
			
			cell = row.createCell(3);
			cell.setCellValue(prdtVO.getCorpNm());
			
			cell = row.createCell(4);
			cell.setCellValue(prdtVO.getPrdtNm());
			
			if(prdtVO.getConfRequestDttm() != null && !"".equals(prdtVO.getConfRequestDttm())){
				cell = row.createCell(5);
				//System.out.println(prdtVO.getConfRequestDttm());
				Date inDate = df_in.parse(prdtVO.getConfRequestDttm());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}
			
			if(prdtVO.getConfDttm() != null && !"".equals(prdtVO.getConfDttm())){
				cell = row.createCell(6);
				Date inDate = df_in.parse(prdtVO.getConfDttm());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}

		}

        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "상품관리.xlsx";

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
     * 협회에서 상점 관리자 로그인
     * 파일명 : masLogin
     * 작성일 : 2015. 12. 30. 오후 5:57:49
     * 작성자 : 최영철
     * @param params
     * @param request
     * @return
     */
    @RequestMapping("/oss/masLogin.ajax")
    public ModelAndView masLogin(@RequestParam Map<String, String> params, HttpServletRequest request){
    	Map<String, Object> resultMap = new HashMap<String,Object>();

    	USERVO userInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
    	userInfo.setCorpId(params.get("corpId"));
    	USERVO userVO = ossUserService.actionMasLogin2(userInfo);

    	if(userVO == null){
    		resultMap.put("success", "N");
    	}else{
    		resultMap.put("success", "Y");
    		request.getSession().setAttribute("masLoginVO", userVO);
    	}

    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
    }

    /**
     * 상품 승인 레이어 띄우기
     * @param cm_CONFHISTVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/viewPrdtAppr.ajax")
    public String viewProductAppr(@ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,
    								ModelMap model) {

    	CM_CONFHISTVO resultVO = ossPrdtService.selectPrdtApprInfo(cm_CONFHISTVO);
    	model.addAttribute("resultVO", resultVO);

    	String corpCd = ( "SV".equals(resultVO.getLinkNum().substring(0,2))) ? "SVCT" : "SPCT";
		List<CDVO> tsCdList = ossCmmService.selectCode(corpCd);
		model.addAttribute("tsCdList", tsCdList);

		return "/oss/product/prdtAppr";
    }


    @RequestMapping("/oss/productAppr.ajax")
    public ModelAndView productAppr(@ModelAttribute("searchVO") PRDTSVO prdtSVO,
									@ModelAttribute("CM_CONFHISTVO") CM_CONFHISTVO cm_CONFHISTVO,
									HttpServletRequest request) {

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();

    	cm_CONFHISTVO.setRegId(corpInfo.getUserId());
		cm_CONFHISTVO.setRegIp(corpInfo.getLastLoginIp());

    	ossPrdtService.productAppr(cm_CONFHISTVO);

    	//수정 요청일때
		if("Y".equals(cm_CONFHISTVO.getMsgSendYn())) {
			CORPVO corpVO = new CORPVO();
			corpVO.setCorpId(request.getParameter("corpId"));

			CORPVO corpRes = ossCorpService.selectByCorp(corpVO);
			SMSVO smsVO = new SMSVO();

			String CST_PLATFORM = EgovProperties.getOptionalProp("CST_PLATFORM");
			MMSVO mmsVO = new MMSVO();

			String tradeStatusStr = "";
			if(Constant.TRADE_STATUS_APPR.equals(cm_CONFHISTVO.getTradeStatus())){
				tradeStatusStr = "승인";
			}else if(Constant.TRADE_STATUS_APPR_REJECT.equals(cm_CONFHISTVO.getTradeStatus())){
				tradeStatusStr = "승인거절";
			}else if(Constant.TRADE_STATUS_STOP.equals(cm_CONFHISTVO.getTradeStatus())){
				tradeStatusStr = "판매중지";
			}else if(Constant.TRADE_STATUS_EDIT.equals(cm_CONFHISTVO.getTradeStatus())){
				tradeStatusStr = "수정요청";
			};

			mmsVO.setSubject("[탐나오상품 " + tradeStatusStr + "]");
			mmsVO.setMsg(cm_CONFHISTVO.getMsg());
			mmsVO.setStatus("0");
			mmsVO.setFileCnt("0");
			mmsVO.setType("0");
			/*담당자 MMS발송 - 테스트빌드시 결제 메시지 김재성*/
			if("test".equals(CST_PLATFORM.trim())) {
				mmsVO.setPhone(Constant.TAMNAO_TESTER1);
			}else{
				mmsVO.setPhone(corpRes.getAdmMobile());
			}
			mmsVO.setCallback(EgovProperties.getProperty("CS.PHONE"));

			try {
				smsService.sendMMS(mmsVO);
			} catch (Exception e) {
				log.info("MMS Error");
			}

			/* 담당자2 MMS 발송 */
			if(StringUtils.isNotEmpty(corpRes.getAdmMobile2())) {
				/*테스트빌드시 */
				if("test".equals(CST_PLATFORM.trim())) {
					mmsVO.setPhone(Constant.TAMNAO_TESTER2);
				}else{
					mmsVO.setPhone(corpRes.getAdmMobile2());
				}
				try {
					smsService.sendMMS(mmsVO);
				} catch (Exception e) {
					log.info("MMS Error");
				}
			}

			/* 담당자3 MMS 발송 */
			if(StringUtils.isNotEmpty(corpRes.getAdmMobile3())) {
				/*테스트빌드시 */
				if("test".equals(CST_PLATFORM.trim())) {
					mmsVO.setPhone(Constant.TAMNAO_TESTER3);
				}else{
					mmsVO.setPhone(corpRes.getAdmMobile3());
				}
				try {
					smsService.sendMMS(mmsVO);
				} catch (Exception e) {
					log.info("MMS Error");
				}
			}

			try {
				smsService.sendSMS(smsVO);
			} catch (Exception e) {
				log.error("SMS Error", e);
			}
		}
		Map<String, Object> resultMap = new HashMap<String,Object>();
		resultMap.put("FLAG", Constant.JSON_SUCCESS);

		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
    }

    //------------------------------------------------------

    @Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;

    @Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

    @Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

    @Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

    @RequestMapping("/oss/preview/adPrdt.do")
    public String previewAdPrdt(@ModelAttribute("searchVO") AD_WEBDTLSVO prdtSVO,
								ModelMap model) throws IOException{

		//객실 번호가 없으면 대표객실 번호 가저오기
		if(prdtSVO.getsPrdtNum()==null || "".equals(prdtSVO.getsPrdtNum() )){
			if(prdtSVO.getCorpId()==null || prdtSVO.getCorpId().isEmpty() ){
				return "redirect:/web/cmm/error.do";
			}

			AD_PRDTINFVO adPrdt = new AD_PRDTINFVO();
			adPrdt.setCorpId( prdtSVO.getCorpId() );
			AD_PRDTINFVO adPrdtRes = webAdProductService.selectPrdtInfByMaster(adPrdt);

			if(adPrdtRes==null){
				return "redirect:/web/cmm/error.do";
			}

			prdtSVO.setsPrdtNum( adPrdtRes.getPrdtNum() );
		}

		AD_WEBDTLVO ad_WEBDTLVO = webAdProductService.selectWebdtlByPrdt(prdtSVO);

		ad_WEBDTLVO.setTip(EgovStringUtil.checkHtmlView(ad_WEBDTLVO.getTip()) );
		ad_WEBDTLVO.setInfIntrolod(EgovStringUtil.checkHtmlView(ad_WEBDTLVO.getInfIntrolod()) );
		ad_WEBDTLVO.setInfEquinf(EgovStringUtil.checkHtmlView(ad_WEBDTLVO.getInfEquinf()) );
		ad_WEBDTLVO.setInfOpergud(EgovStringUtil.checkHtmlView(ad_WEBDTLVO.getInfOpergud()) );
		ad_WEBDTLVO.setInfNti(EgovStringUtil.checkHtmlView(ad_WEBDTLVO.getInfNti()) );

		model.addAttribute("webdtl", ad_WEBDTLVO);


		//날짜가 없으면 오늘날짜
		if(prdtSVO.getsFromDt()==null || "".equals(prdtSVO.getsFromDt() ) ){
			//prdtSVO.setsFromDt("20151101");
			Calendar calNow = Calendar.getInstance();
			prdtSVO.setsFromDt(String.format("%d%02d%02d"
					, calNow.get(Calendar.YEAR)
					, calNow.get(Calendar.MONTH)+1
					, calNow.get(Calendar.DATE) ) );
		}

		//박이 없으면 1박
		if(prdtSVO.getsNights()==null || "".equals(prdtSVO.getsNights() ) ){
			prdtSVO.setsNights("1");
		}
		model.addAttribute("searchVO", prdtSVO);

		CORPVO corpSVO = new CORPVO();
		corpSVO.setCorpId(ad_WEBDTLVO.getCorpId());
		CORPVO corpVO = ossCorpService.selectByCorp(corpSVO);
		model.addAttribute("corpVO", corpVO);

		//숙소 이미지
		CM_IMGVO imgVO = new CM_IMGVO();
		imgVO.setLinkNum(ad_WEBDTLVO.getCorpId().toUpperCase());
		List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
		model.addAttribute("adImgList", imgList);

		//객실 목록
		AD_PRDTINFVO ad_PRDTINFVO = new AD_PRDTINFVO();
		ad_PRDTINFVO.setCorpId(ad_WEBDTLVO.getCorpId());
		ad_PRDTINFVO.setOssMaster("Y");
		List<AD_PRDTINFVO> ad_prdtList = webAdProductService.selectAdPrdList(ad_PRDTINFVO);

		//초기값 지정을위해 최대 수용 인원 설정
		for (AD_PRDTINFVO adPrdt : ad_prdtList) {
			if(adPrdt.getPrdtNum().endsWith(prdtSVO.getsPrdtNum()) ){
				//추가 인원 허안 안할때 기준인원을 최대 인원으로
				if(adPrdt.getMemExcdAbleYn().equals("N") ){
					adPrdt.setMaxiMem(adPrdt.getStdMem());
				}
				model.addAttribute("adPtdt", adPrdt);
				break;
			}
		}


		//log.info(">>>>>>>>>>" +prdtSVO.getsFromDt() );

		//판매가격
		AD_AMTINFSVO ad_AMTINFSVO = new AD_AMTINFSVO();
		ad_AMTINFSVO.setsCorpId(ad_WEBDTLVO.getCorpId());
		ad_AMTINFSVO.setStartDt(prdtSVO.getsFromDt());
		ad_AMTINFSVO.setOssMaster("Y");
		List<AD_AMTINFVO> ad_amtList = webAdProductService.selectAdAmtListDtl(ad_AMTINFSVO);


		//객실 이미지 & 판매가격 조합
		for (AD_PRDTINFVO data : ad_prdtList) {
			CM_IMGVO imgPdtVO = new CM_IMGVO();
			imgPdtVO.setLinkNum(data.getPrdtNum());
			List<CM_IMGVO> prdtImgList = ossCmmService.selectImgList(imgPdtVO);
			data.setImgList(prdtImgList);

			for (AD_AMTINFVO amt : ad_amtList) {
				if( data.getPrdtNum().equals(amt.getPrdtNum()) ){
					data.setSaleAmt( amt.getSaleAmt() );
					data.setNmlAmt( amt.getNmlAmt() );
					//log.info(">>>>>>>>>>" +amt.getSaleAmt() );
				}
			}
		}
		model.addAttribute("prdtList", ad_prdtList);


		//객실 추가 요금 얻기
		AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
		ad_ADDAMTVO.setAplStartDt( prdtSVO.getsFromDt() );
		ad_ADDAMTVO.setCorpId( prdtSVO.getsPrdtNum() );
		AD_ADDAMTVO adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
		//System.out.println("---------------------1[[["+prdtSVO.getsFromDt() + " - " + prdtSVO.getsPrdtNum());
		if(adAddAmt == null){
			//숙소 추가 요금 얻기
			ad_ADDAMTVO.setCorpId( ad_WEBDTLVO.getCorpId() );
			adAddAmt = webAdProductService.selectAddamtByDt(ad_ADDAMTVO);
			//System.out.println("---------------------2[[["+prdtSVO.getsFromDt() + " - "+ad_WEBDTLVO.getCorpId() );
			if(adAddAmt == null){
				adAddAmt = new AD_ADDAMTVO();
				adAddAmt.setAdultAddAmt("0");
				adAddAmt.setJuniorAddAmt("0");
				adAddAmt.setChildAddAmt("0");
			}
		}
		model.addAttribute("adAddAmt", adAddAmt );

		// 주요정보 체크 리스트
		List<CM_ICONINFVO> iconCdList = ossCmmService.selectCmIconinf(ad_WEBDTLVO.getCorpId(), Constant.ICON_CD_ADAT);
		model.addAttribute("iconCdList", iconCdList);

		model.addAttribute("searchVO", prdtSVO );


		return "/web/ad/detailPrdt";

    }

    @RequestMapping("/oss/preview/rcPrdt.do")
    public String previewRcPrdt(@ModelAttribute("searchVO") RC_PRDTINFSVO prdtSVO,
					    		@ModelAttribute("prdtVO") RC_PRDTINFVO prdtVO,
					    		ModelMap model) {
    	log.info("/oss/preview/rcPrdt.do 호출");
		if(prdtSVO.getsFromDt() == null){
			Calendar calNow = Calendar.getInstance();
			calNow.add(Calendar.DAY_OF_MONTH, 1);
			prdtSVO.setsFromDt(EgovStringUtil.getDateFormat(calNow));
			prdtSVO.setsFromDtView(EgovStringUtil.getDateFormatDash(calNow));
			prdtSVO.setsFromTm("1200");

			calNow.add(Calendar.DAY_OF_MONTH, 1);
			prdtSVO.setsToDt(EgovStringUtil.getDateFormat(calNow));
			prdtSVO.setsToDtView(EgovStringUtil.getDateFormatDash(calNow));
			prdtSVO.setsToTm("1200");

			// 판매 많은 순
			prdtSVO.setOrderCd(Constant.ORDER_SALE);
			prdtSVO.setOrderAsc(Constant.ORDER_DESC);
		}
		// 상품 이미지 검색
		CM_IMGVO imgVO = new CM_IMGVO();
		imgVO.setLinkNum(prdtVO.getPrdtNum());
		List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);

		model.addAttribute("imgList", imgList);

		prdtVO = webRcProductService.selectByPrdt(prdtVO);

		// 상품정보가 존재하지 않으면 오류페이지로 리턴
		if(prdtVO == null){
			return "redirect:/web/cmm/error.do?errCord=PRDT01";
		}

		prdtVO.setRntStdInf(EgovStringUtil.checkHtmlView(prdtVO.getRntStdInf()));
		prdtVO.setCarTkovInf(EgovStringUtil.checkHtmlView(prdtVO.getCarTkovInf()));
		//prdtVO.setNti(EgovStringUtil.checkHtmlView(prdtVO.getNti()));
		prdtVO.setIsrCmGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrCmGuide()));
		prdtVO.setIsrAmtGuide(EgovStringUtil.checkHtmlView(prdtVO.getIsrAmtGuide()));

		prdtSVO.setSearchYn(Constant.FLAG_N);

		// 차량구분코드
		List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
		model.addAttribute("carDivCd", cdList);

		// 주요정보 체크 리스트
		List<CM_ICONINFVO> iconCdList = ossCmmService.selectCmIconinf(prdtVO.getPrdtNum(), Constant.ICON_CD_RCAT);
		model.addAttribute("iconCdList", iconCdList);

		// 자차필수 여부 (2016-12-9, By JDongS)
		/*model.addAttribute("chkIsrFlag", ossCmmService.selectCmIconfChkIsr(prdtVO.getPrdtNum()));*/

		model.addAttribute("prdtVO", prdtVO);
		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, 6);
		EgovStringUtil.getDateFormatDash(cal);
		model.addAttribute("AFTER_DAY", EgovStringUtil.getDateFormatDash(cal));

		//추가정보 얻기
		RC_DFTINFVO rc_DFTINFVO = new RC_DFTINFVO();
		rc_DFTINFVO.setCorpId(prdtVO.getCorpId());
		RC_DFTINFVO rcDftInfo = masRcPrdtService.selectByRcDftInfo(rc_DFTINFVO);
		model.addAttribute("rcDftInfo", rcDftInfo);

		// 유모차/카시트 목록
		WEB_SPSVO webSpSVO = new WEB_SPSVO();
		webSpSVO.setsCtgr(Constant.CATEGORY_BACS);
		webSpSVO.setsCtgrDiv(Constant.CATEGORY_ETC);
		webSpSVO.setsCtgrDepth("1");
		webSpSVO.setFirstIndex(0);
		webSpSVO.setLastIndex(4);
		Map<String, Object> bacsMap = webSpService.selectProductList(webSpSVO);
		@SuppressWarnings("unchecked")
		List<WEB_SPPRDTVO> bacsList = (List<WEB_SPPRDTVO>) bacsMap.get("resultList");
		model.addAttribute("bacsList", bacsList);

		// 찜하기 정보 (2017-11-24, By JDongS)
		int pocketCnt = 0;
		Map<String, POCKETVO> pocketMap = new HashMap<String, POCKETVO>();

		model.addAttribute("pocketMap", pocketMap);
		model.addAttribute("pocketCnt", pocketCnt);

		return "/web/rc/car-detail";

    }


    @RequestMapping("/oss/findPrdt.do")
    public String findPrdt(@ModelAttribute("searchVO") PRDTSVO prdtSVO,
				    		ModelMap model){
    	prdtSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	prdtSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prdtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prdtSVO.getPageUnit());
		paginationInfo.setPageSize(prdtSVO.getPageSize());

		prdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossPrdtService.selectPrdtList(prdtSVO);

		@SuppressWarnings("unchecked")
		List<PRDTVO> resultList = (List<PRDTVO>) resultMap.get("resultList");


		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

    	return "/oss/product/findPrdt";
    }

    private void setCarDivCode(ModelMap model) {
    	// 차량연료코드
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.RC_CARFUEL_DIV);
    	model.addAttribute("fuelCd", cdList);

    	// 차량구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_CAR_DIV);
    	model.addAttribute("carDivCd", cdList);

    	//// 변속기구분코드
    	//cdList = ossCmmService.selectCode(Constant.RC_TRANS_DIV);
    	//model.addAttribute("transDivCd", cdList);

    	// 제조사구분코드
    	cdList = ossCmmService.selectCode(Constant.RC_MAKER_DIV);
    	Collections.sort(cdList);		// 이름순 정렬
    	model.addAttribute("makerDivCd", cdList);

    	//// 차량코드
    	//cdList = ossCmmService.selectCode(Constant.RC_CAR_CD);
    	//model.addAttribute("carCd", cdList);
    }


    @RequestMapping("/oss/cardivList.do")
    public String cardivList(@ModelAttribute("searchVO") RC_CARDIVSVO rcCardivSVO,
							 ModelMap model) {

    	setCarDivCode(model);

    	rcCardivSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	rcCardivSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(rcCardivSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(rcCardivSVO.getPageUnit());
		paginationInfo.setPageSize(rcCardivSVO.getPageSize());

		rcCardivSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		rcCardivSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		rcCardivSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = masRcPrdtService.selectCardivList(rcCardivSVO);

		@SuppressWarnings("unchecked")
		List<PRDTVO> resultList = (List<PRDTVO>) resultMap.get("resultList");
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

    	return "/oss/product/cardivList";
    }


    @RequestMapping("/oss/cardivInsView.do")
	public String cardivInsView(@ModelAttribute("RC_CARDIVVO") RC_CARDIVVO rcCardivVO,
								ModelMap model) {
		log.info("/oss/cardivInsView.do 호출");

		setCarDivCode(model);

		return "oss/product/cardivIns";
	}


	@RequestMapping("/oss/cardivIns.do")
	public String cardivIns(@ModelAttribute("RC_CARDIVVO") RC_CARDIVVO rcCardivVO,
							final MultipartHttpServletRequest multiRequest,
							ModelMap model,
							RedirectAttributes attributes) throws Exception {
		log.info("/oss/cardivIns.do 호출");

		//앞에 RD붙이기
	//	String strOrg = rcCardivVO.getRcCardivNum();
	//	rcCardivVO.setRcCardivNum("RD"+rcCardivVO.getRcCardivNum());
		
		// 차종 코드 자동생성으로 변경 (2017-12-19, By JDongS)
		// RD + 제조사코드 뒷 2자리 + 차량구분 뒷 2자리 + 00001 (10자리)
		RC_CARDIVVO cntCardivVO = new RC_CARDIVVO();
		cntCardivVO.setsCarDiv(rcCardivVO.getCarDiv().substring(2, 4));
		cntCardivVO.setsMakerDiv(rcCardivVO.getMakerDiv().substring(2, 4));

		Integer autoIncrementNum = masRcPrdtService.selectCardivAutoIncrementNum(cntCardivVO);

		String cardivNum = "RD" + rcCardivVO.getMakerDiv().substring(2, 4) + rcCardivVO.getCarDiv().substring(2, 4) + String.format("%04d", autoIncrementNum);
		rcCardivVO.setRcCardivNum(cardivNum);

		//겹치는것이 있는지 검사
		RC_CARDIVVO rcCardivRes = masRcPrdtService.selectCardiv(rcCardivVO);

		if(rcCardivRes != null) {
			setCarDivCode(model);
	//		rcCardivVO.setRcCardivNum(strOrg);
			model.addAttribute("errCode", "Y");

			return "oss/product/cardivIns";
		}
		//파일 관련 처리
		String imgSavePath = EgovProperties.getProperty("CARDIV.SAVEDFILE");
		MultipartFile carImgFile = multiRequest.getFile("carImgFile");

		if(!carImgFile.isEmpty()) {
			String newFileName = rcCardivVO.getRcCardivNum() + "." + FilenameUtils.getExtension(multiRequest.getFile("carImgFile").getOriginalFilename());
			//log.info("========"+ imgSavePath + " / "+ newFileName);
			ossFileUtilService.uploadFile(carImgFile, newFileName, imgSavePath);

			rcCardivVO.setCarImg(imgSavePath + newFileName);
		}
		masRcPrdtService.insertCardiv(rcCardivVO);

		setSrchWord(rcCardivVO);

		attributes.addAttribute("sMakerDiv", rcCardivVO.getsMakerDiv());
		attributes.addAttribute("sCarDiv", rcCardivVO.getsCarDiv());
		attributes.addAttribute("sUseFuelDiv", rcCardivVO.getsUseFuelDiv());
		attributes.addAttribute("sPrdtNm", rcCardivVO.getsPrdtNm());
		attributes.addAttribute("sRcCardivNum", rcCardivVO.getsRcCardivNum());
		attributes.addAttribute("sUseYn", rcCardivVO.getsUseYn());
		attributes.addAttribute("pageIndex", rcCardivVO.getPageIndex());

		return "redirect:/oss/cardivList.do";
	}


	@RequestMapping("/oss/cardivUdtView.do")
	public String cardivUdtView(@ModelAttribute("RC_CARDIVVO") RC_CARDIVVO rcCardivVO,
								@ModelAttribute("searchVO") RC_CARDIVSVO rcCardivSVO,
								ModelMap model) {
		log.info("/oss/cardivEdtView.do 호출");

		setCarDivCode(model);

    	RC_CARDIVVO rcCardivRes = masRcPrdtService.selectCardiv(rcCardivVO);

    	if(rcCardivRes != null) {
			rcCardivRes.setSrchWord1(ossCmmService.getSrchWord(rcCardivRes.getRcCardivNum(), "1"));
			rcCardivRes.setSrchWord2(ossCmmService.getSrchWord(rcCardivRes.getRcCardivNum(), "2"));
			rcCardivRes.setSrchWord3(ossCmmService.getSrchWord(rcCardivRes.getRcCardivNum(), "3"));
			rcCardivRes.setSrchWord4(ossCmmService.getSrchWord(rcCardivRes.getRcCardivNum(), "4"));
			rcCardivRes.setSrchWord5(ossCmmService.getSrchWord(rcCardivRes.getRcCardivNum(), "5"));
			rcCardivRes.setSrchWord6(ossCmmService.getSrchWord(rcCardivRes.getRcCardivNum(), "6"));
			rcCardivRes.setSrchWord7(ossCmmService.getSrchWord(rcCardivRes.getRcCardivNum(), "7"));
			rcCardivRes.setSrchWord8(ossCmmService.getSrchWord(rcCardivRes.getRcCardivNum(), "8"));
			rcCardivRes.setSrchWord9(ossCmmService.getSrchWord(rcCardivRes.getRcCardivNum(), "9"));
			rcCardivRes.setSrchWord10(ossCmmService.getSrchWord(rcCardivRes.getRcCardivNum(), "10"));
		}
    	model.addAttribute("RC_CARDIVVO", rcCardivRes);
		model.addAttribute("searchVO", rcCardivSVO);

		return "oss/product/cardivUdt";
	}

	@RequestMapping("/oss/cardivUdt.do")
	public String cardivUdt(@ModelAttribute("RC_CARDIVVO") RC_CARDIVVO rcCardivVO,
							final MultipartHttpServletRequest multiRequest,
							RedirectAttributes attributes) throws Exception {
		log.info("/oss/cardivUdt.do 호출");
		
		//파일 관련 처리
		String imgSavePath = EgovProperties.getProperty("CARDIV.SAVEDFILE");
		MultipartFile carImgFile = multiRequest.getFile("carImgFile");

		if(!carImgFile.isEmpty()) {
			String newFileName = rcCardivVO.getRcCardivNum() + "." + FilenameUtils.getExtension(multiRequest.getFile("carImgFile").getOriginalFilename());
			//log.info("========"+ imgSavePath + " / "+ newFileName);
			ossFileUtilService.uploadFile(carImgFile, newFileName, imgSavePath);

			rcCardivVO.setCarImg(imgSavePath + newFileName);
		}
		masRcPrdtService.updateCardiv(rcCardivVO);

		setSrchWord(rcCardivVO);

		attributes.addAttribute("sMakerDiv", rcCardivVO.getsMakerDiv());
		attributes.addAttribute("sCarDiv", rcCardivVO.getsCarDiv());
		attributes.addAttribute("sUseFuelDiv", rcCardivVO.getsUseFuelDiv());
		attributes.addAttribute("sPrdtNm", rcCardivVO.getsPrdtNm());
		attributes.addAttribute("sRcCardivNum", rcCardivVO.getsRcCardivNum());
		attributes.addAttribute("sUseYn", rcCardivVO.getsUseYn());
		attributes.addAttribute("pageIndex", rcCardivVO.getPageIndex());

		return "redirect:/oss/cardivList.do";
	}
	
	@RequestMapping("/oss/checkCardiv.ajax")
	public ModelAndView checkCardiv(@ModelAttribute("RC_CARDIVVO") RC_CARDIVVO rcCardivVO) {
		log.info("/oss/checkCardiv.ajax 호출");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("carDivCnt", masRcPrdtService.selectCardivCnt(rcCardivVO));

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}
	
	@RequestMapping("/oss/chckPrdtExpireList.do")
    public String chckPrdtExpireList(@ModelAttribute("searchVO") PRDTSVO prdtSVO,
				    		ModelMap model){
    	prdtSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	prdtSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prdtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prdtSVO.getPageUnit());
		paginationInfo.setPageSize(prdtSVO.getPageSize());

		prdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/* 초기화값 숙박코드 AD */
		if(prdtSVO.getsPrdtCd() == null || "".equals(prdtSVO.getsPrdtCd())) {
			prdtSVO.setsPrdtCd("AD");
		}

		List<PRDTVO> resultList = ossPrdtService.chckPrdtExpireList(prdtSVO);
		Integer resultCnt = ossPrdtService.chckPrdtExpireListCnt(prdtSVO);
		
		/*숙박*/
		List<PRDTVO> stasticsCnt1 = ossPrdtService.chckPrdtStasticsCnt1(prdtSVO);
		/*렌터카*/
		List<PRDTVO> stasticsCnt2 = ossPrdtService.chckPrdtStasticsCnt2(prdtSVO);
		

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount(resultCnt);
		model.addAttribute("resultList", resultList);
		model.addAttribute("stasticsCnt1", stasticsCnt1);
		model.addAttribute("stasticsCnt2", stasticsCnt2);
		model.addAttribute("totalCnt", paginationInfo.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
			
		
    	return "/oss/product/chckPrdtExpireList";
    }
	
	@RequestMapping("/oss/chckPrdtExpireExcel.do")
	public void chckPrdtExpireExcel(@ModelAttribute("searchVO") PRDTSVO prdtSVO,
    		ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ParseException{
		
		
		/* 엑셀 레코드 MAX COUNT 999999개 */
		prdtSVO.setFirstIndex(0);
		prdtSVO.setLastIndex(999999);
		
		SimpleDateFormat df_in = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat df_output = new SimpleDateFormat("yyyy-MM-dd");
		
		/* 초기화값 숙박코드 AD */
		if(prdtSVO.getsPrdtCd() == null || "".equals(prdtSVO.getsPrdtCd())) {
			prdtSVO.setsPrdtCd("AD");
		}
		
		List<PRDTVO> resultList = ossPrdtService.chckPrdtExpireList(prdtSVO);

		//Workbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
        Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

        // *** Sheet-------------------------------------------------
        // Sheet 생성
        Sheet sheet1 = xlsxWb.createSheet("입점업체내역");

        // 컬럼 너비 설정
        sheet1.setColumnWidth( 0, 6000);		//업체아이디
        sheet1.setColumnWidth( 1, 3000); 		//업체명
        sheet1.setColumnWidth( 2, 3000);		//업체분류
        sheet1.setColumnWidth( 3, 3000);		//거래상태
        sheet1.setColumnWidth( 4, 3000);		//예약번호
        sheet1.setColumnWidth( 5, 3000);		//관리자번호

        CellStyle cellStyle = xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);


        Row row = null;
        Cell cell = null;

        // 첫 번째 줄
        row = sheet1.createRow(0);

        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("업체명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(1);
        cell.setCellValue("만료예정상품개수");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(2);
        cell.setCellValue("수량만료일");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(3);
		cell.setCellValue("금액만료일");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(4);
		cell.setCellValue("대표번호");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(5);
		cell.setCellValue("관리자번호");
		cell.setCellStyle(cellStyle);

		for (int i = 0; i < resultList.size(); i++) {
			PRDTVO prdtVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(prdtVO.getCorpNm());

			cell = row.createCell(1);
			cell.setCellValue(prdtVO.getConfCnt());
			
			if(prdtVO.getCntAplDt() != null && !"".equals(prdtVO.getCntAplDt())){
				cell = row.createCell(2);
				Date inDate = df_in.parse(prdtVO.getCntAplDt());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}
			
			if(prdtVO.getAmtAplDt() != null && !"".equals(prdtVO.getAmtAplDt())){
				cell = row.createCell(3);
				Date inDate = df_in.parse(prdtVO.getAmtAplDt());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}

			cell = row.createCell(4);
			cell.setCellValue(prdtVO.getRsvTelNum());

			cell = row.createCell(5);
			cell.setCellValue(prdtVO.getAdmMobile());
		}

        // excel 파일 저장
        try {
        	// 실제 저장될 파일 이름
    		String realName = "상품기한관리.xlsx";

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
	 * 설명 :
	 * 파일명 : chckPrdtEndExcel
	 * 작성일 : 2021-05-04 오전 10:07
	 * 작성자 : chaewan.jung
	 * @param : [prdtSVO, request, response]
	 * @return : void
	 * @throws Exception
	 */
	@RequestMapping("/oss/chckPrdtEndExcel.do")
	public void chckPrdtEndExcel(@ModelAttribute("searchVO") PRDTSVO prdtSVO,
									HttpServletRequest request, HttpServletResponse response) throws ParseException{

		/* 엑셀 레코드 MAX COUNT 999999개 */
		prdtSVO.setFirstIndex(0);
		prdtSVO.setLastIndex(999999);

		SimpleDateFormat df_in = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat df_output = new SimpleDateFormat("yyyy-MM-dd");

		/* 초기화값 숙박코드 AD */
		if(prdtSVO.getsPrdtCd() == null || "".equals(prdtSVO.getsPrdtCd())) {
			prdtSVO.setsPrdtCd("AD");
		}

		List<PRDTVO> resultList = ossPrdtService.chckPrdtEndList(prdtSVO);

		Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

		// *** Sheet-------------------------------------------------
		// Sheet 생성
		Sheet sheet1 = xlsxWb.createSheet("숙소기간만료상품");

		// 컬럼 너비 설정
		sheet1.setColumnWidth( 0, 6000);		//업체아이디
		sheet1.setColumnWidth( 1, 3000); 		//업체명
		sheet1.setColumnWidth( 2, 3000);		//업체분류
		sheet1.setColumnWidth( 3, 3000);		//거래상태
		sheet1.setColumnWidth( 4, 3000);		//예약번호
		sheet1.setColumnWidth( 5, 3000);		//관리자번호
		sheet1.setColumnWidth( 6, 6000);		//업체 담당자 이메일
		CellStyle cellStyle = xlsxWb.createCellStyle();
		cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);


		Row row = null;
		Cell cell = null;

		// 첫 번째 줄
		row = sheet1.createRow(0);

		// 첫 번째 줄에 Cell 설정하기-------------
		cell = row.createCell(0);
		cell.setCellValue("업체명");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(1);
		cell.setCellValue("만료상품개수");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(2);
		cell.setCellValue("수량만료일");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(3);
		cell.setCellValue("금액만료일");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(4);
		cell.setCellValue("대표번호");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(5);
		cell.setCellValue("관리자번호");
		cell.setCellStyle(cellStyle);

		cell = row.createCell(6);
		cell.setCellValue("업체 담당자 이메일");
		cell.setCellStyle(cellStyle);

		for (int i = 0; i < resultList.size(); i++) {
			PRDTVO prdtVO = resultList.get(i);
			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(prdtVO.getCorpNm());

			cell = row.createCell(1);
			cell.setCellValue(prdtVO.getConfCnt());

			if(prdtVO.getCntAplDt() != null && !"".equals(prdtVO.getCntAplDt())){
				cell = row.createCell(2);
				Date inDate = df_in.parse(prdtVO.getCntAplDt());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}

			if(prdtVO.getAmtAplDt() != null && !"".equals(prdtVO.getAmtAplDt())){
				cell = row.createCell(3);
				Date inDate = df_in.parse(prdtVO.getAmtAplDt());
				String outDate = df_output.format(inDate);
				cell.setCellValue(outDate);
			}

			cell = row.createCell(4);
			cell.setCellValue(prdtVO.getRsvTelNum());

			cell = row.createCell(5);
			cell.setCellValue(prdtVO.getAdmMobile());

			cell = row.createCell(6);
			cell.setCellValue(prdtVO.getCorpAdmEmail());
		}

		// excel 파일 저장
		try {
			// 실제 저장될 파일 이름
			String realName = "숙소기간만료상품.xlsx";

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
	private void setSrchWord(RC_CARDIVVO rcCardivVO){
		//기존꺼 삭제 후 저장.

		USERVO userInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();


		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(rcCardivVO.getRcCardivNum());
		srchWordVO.setFrstRegId(userInfo.getUserId() );
		srchWordVO.setLastModId(userInfo.getUserId());

		srchWordVO.setSrchWordSn("1");
		srchWordVO.setSrchWord(rcCardivVO.getSrchWord1());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("2");
		srchWordVO.setSrchWord(rcCardivVO.getSrchWord2());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("3");
		srchWordVO.setSrchWord(rcCardivVO.getSrchWord3());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("4");
		srchWordVO.setSrchWord(rcCardivVO.getSrchWord4());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("5");
		srchWordVO.setSrchWord(rcCardivVO.getSrchWord5());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("6");
		srchWordVO.setSrchWord(rcCardivVO.getSrchWord6());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("7");
		srchWordVO.setSrchWord(rcCardivVO.getSrchWord7());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("8");
		srchWordVO.setSrchWord(rcCardivVO.getSrchWord8());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("9");
		srchWordVO.setSrchWord(rcCardivVO.getSrchWord9());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("10");
		srchWordVO.setSrchWord(rcCardivVO.getSrchWord10());
		ossCmmService.insertSrchWord2(srchWordVO);
	}

	@RequestMapping("/oss/findAllPrdt.do")
	public String findAllPrdt(@ModelAttribute("searchVO") PRDTSVO prdtSVO,
						   ModelMap model){
		prdtSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		prdtSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prdtSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prdtSVO.getPageUnit());
		paginationInfo.setPageSize(prdtSVO.getPageSize());

		prdtSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prdtSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prdtSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossPrdtService.selectPrdtAllList(prdtSVO);

		@SuppressWarnings("unchecked")
		List<PRDTVO> resultList = (List<PRDTVO>) resultMap.get("resultList");


		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "/oss/product/findAllPrdt";
	}

	@RequestMapping("/oss/updateTamnacardPrdtYn.ajax")
	public ModelAndView updateTamnacardPrdtYn(@ModelAttribute("searchVO") PRDTSVO prdtSVO){
		Map<String, Object> resultMap = new HashMap<String,Object>();
		try{
			ossPrdtService.updateTamnacardPrdtYn(prdtSVO);
			resultMap.put("resultYn","Y");
		}catch(Exception e){
			resultMap.put("resultYn","N");
		}
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}
}
