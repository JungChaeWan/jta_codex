package web.product.web;

import common.Constant;
import common.EgovUserDetailsHelper;
import common.LowerHashMap;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovProperties;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.prmt.service.MasPrmtService;
import mas.prmt.vo.PRMTCMTVO;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import oss.ad.vo.AD_WEBLISTSVO;
import oss.ad.vo.AD_WEBLISTVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpService;
import oss.etc.vo.FILEVO;
import oss.prmt.vo.GOVASVO;
import oss.prmt.vo.GOVAVO;
import oss.prmt.vo.PRMTFILEVO;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;
import web.mypage.service.WebMypageService;
import web.product.service.*;
import web.product.vo.WEB_SPPRDTVO;
import web.product.vo.WEB_SPSVO;
import web.product.vo.WEB_SVPRDTVO;
import web.product.vo.WEB_SVSVO;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Controller
public class WebPrmtController {
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "webPrmtService")
	protected WebPrmtService webPrmtService;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name = "webSvService")
	protected WebSvProductService webSvService;
	
	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name = "masPrmtService")
	private MasPrmtService masPrmtService;

	@Resource(name="ossUserService")
	protected OssUserService ossUserService;

	Logger log = LogManager.getLogger(this.getClass());

	// 이벤트 리스트
	@RequestMapping("/web/evnt/promotionList.do")
	public String promotionList(@ModelAttribute("searchVO") PRMTVO prmtVO,
								ModelMap model,
								HttpServletRequest request) {
		log.info("/web/evnt/promotionList.do");

		try {
			if(EgovClntInfo.isMobile(request)) {
				return "forward:/mw/evnt/promotionList.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		prmtVO.setPageUnit(propertiesService.getInt("webEvntPageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("webEvntPageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}
		// 이벤트 형태
		prmtVO.setPrmtDiv(Constant.PRMT_DIV_EVNT);

		// 상품 리스트
		Map<String, Object> resultMap = webPrmtService.selectPromotionList(prmtVO);

		@SuppressWarnings("unchecked")
		List<PRMTVO> resultList = (List<PRMTVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		return "web/evnt/promotionList";
	}
	
	/**
	 * 기획전 리스트
	 * Function : promotionList
	 * 작성일 : 2017. 11. 15. 오후 4:28:53
	 * 작성자 : 정동수
	 * @param prmtVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/web/evnt/prmtPlanList.do")
	public String prmtPlanList(@ModelAttribute("searchVO") PRMTVO prmtVO,
							   ModelMap model,
							   HttpServletRequest request) {
		log.info("/web/evnt/prmtPlanList.do");

		try {
			if(EgovClntInfo.isMobile(request)) {
				return "forward:/mw/evnt/prmtPlanList.do";
			}
		} catch (Exception e) {
			log.error(e.toString());
		}
		prmtVO.setPageUnit(propertiesService.getInt("webEvntPageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("webEvntPageSize"));
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}

		// prmtDiv 기본값 설정
		if (StringUtils.isBlank(prmtVO.getPrmtDiv())) {
			prmtVO.setPrmtDiv(Constant.PRMT_DIV_PLAN);
		}

		// 파라미터값이 있을 경우 덮어쓰기
		if (StringUtils.isNotBlank(prmtVO.getsPrmtDiv())) {
			prmtVO.setPrmtDiv(prmtVO.getsPrmtDiv());
		}

		// 상품 리스트
		Map<String, Object> resultMap = webPrmtService.selectPromotionList(prmtVO);
		@SuppressWarnings("unchecked")
		List<PRMTVO> resultList = (List<PRMTVO>) resultMap.get("resultList");
		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		return "web/evnt/prmtPlanList";
	}

	@RequestMapping("/web/evnt/detailPromotion.do")
	public String detailPromotion(@ModelAttribute("prmtVO") PRMTVO prmtVO,
								  ModelMap model,
								  HttpServletRequest request) throws Exception {
		log.info("/web/evnt/detailPromotion.do call");

		String prmtNum = prmtVO.getPrmtNum();
		String connIp = EgovClntInfo.getClntIP(request);  
		
		//뷰 카운트
		String iFlag = "Y";
		for(Constant.INSIDE_IP insideIp : Constant.INSIDE_IP.values()) {
			if(connIp.substring(0,3).equals(insideIp.getValue())) {
				iFlag = "N";
				break;
			}
		}
		
		if("Y".equals(iFlag)) {
			webPrmtService.updateViewCnt(prmtNum);	
		}

		String param = "&prmtDiv=" + prmtVO.getPrmtDiv() + "&prmtNum=" + prmtNum;
		if(EgovClntInfo.isMobile(request)) {
			if(Constant.PRMT_DIV_PLAN.equals(prmtVO.getPrmtDiv())) {
				param += "&type=plan";
			}
			return "redirect:/mw/evnt/detailPromotion.do?" + param;
		}
		
		if(EgovStringUtil.isEmpty(prmtNum)) {
			log.error("prmtNum is null");
			return "redirect:/main.do";
		}

		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}
		// 기획전 상세정보
		PRMTVO resultVO = webPrmtService.selectByPrmt(prmtVO);

		resultVO.setFinishYn(prmtVO.getFinishYn());
		resultVO.setWinsYn(prmtVO.getWinsYn());
		resultVO.setPageIndex(prmtVO.getPageIndex());

		model.addAttribute("prmtVO", resultVO);

		// 프로모션 이전글 다음글
		PRMTVO prmtPrevNext =  webPrmtService.getPromotionPrevNext(prmtVO);

		model.addAttribute("prmtPrevNext", prmtPrevNext);
		// 당첨자 페이지 여부
		if(Constant.FLAG_N.equals(prmtVO.getWinsYn())) {
			int nPrdtSum = 0;
			List<PRMTPRDTVO> prmtPrdtList = new ArrayList<PRMTPRDTVO>();

			// 숙박
			AD_WEBLISTSVO adWebSVO = new AD_WEBLISTSVO();
			adWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<AD_WEBLISTVO> resultAdList = webAdProductService.selectAdListOssPrmt(adWebSVO);

			nPrdtSum += resultAdList.size();
			// 정렬을위한 데이터 넣기
			for(AD_WEBLISTVO data : resultAdList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("AD");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setPrintSn(data.getPrintSn());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}
			// 렌터카
			RC_PRDTINFSVO rcWebSVO = new RC_PRDTINFSVO();
			rcWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<RC_PRDTINFVO> resultRcList = webRcProductService.selectWebRcPrdtListOssPrmt(rcWebSVO);

			nPrdtSum += resultRcList.size();
			// 정렬을위한 데이터 넣기
			for(RC_PRDTINFVO data : resultRcList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("RC");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setPrintSn(data.getPrintSn());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}
			// 소셜
			WEB_SPSVO spWebSVO = new WEB_SPSVO();
			spWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<WEB_SPPRDTVO> resultSpList = webSpService.selectProductListOssPrmt(spWebSVO);

			nPrdtSum += resultSpList.size();
			// 정렬을위한 데이터 넣기
			for(WEB_SPPRDTVO data : resultSpList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("SP");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setPrintSn(data.getPrintSn());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}
			// 관광기념품
			WEB_SVSVO svWebSVO = new WEB_SVSVO();
			svWebSVO.setsPrmtNum(prmtVO.getPrmtNum());

			List<WEB_SVPRDTVO> resultSvList = webSvService.selectProductListOssPrmt(svWebSVO);

			nPrdtSum += resultSvList.size();
			// 정렬을위한 데이터 넣기
			for(WEB_SVPRDTVO data : resultSvList) {
				PRMTPRDTVO prmt = new PRMTPRDTVO();
				prmt.setCorpCd("SV");
				prmt.setPrdtNum(data.getPrdtNum());
				prmt.setPrintSn(data.getPrintSn());
				prmt.setData(data);

				prmtPrdtList.add(prmt);
			}
			model.addAttribute("prdtSum", nPrdtSum);
			// 정렬
			DescPrmt descPrmt = new DescPrmt();
			Collections.sort(prmtPrdtList, descPrmt);

			model.addAttribute("prmtPrdtList", prmtPrdtList);
			// 프로모션 상품 라벨/설명
			Map<String, PRMTPRDTVO> prmtPrdtMap = new HashMap<String, PRMTPRDTVO>();

			List<PRMTPRDTVO> prmtPrdtInfoList = webPrmtService.selectPrmtPrdtList(prmtVO.getPrmtNum());

			for(PRMTPRDTVO prmtPrdt : prmtPrdtInfoList) {
				prmtPrdtMap.put(prmtPrdt.getPrdtNum(), prmtPrdt);
			}
			model.addAttribute("prmtPrdtMap", prmtPrdtMap);
			// 라벨코드
			List<CDVO> labelCdList = ossCmmService.selectCode(Constant.PRMT_LABEL_CD);

			Map<String, String> labelMap = new HashMap<String, String>();
			for(CDVO cd : labelCdList) {
				labelMap.put(cd.getCdNum(), cd.getCdNm());
			}
			model.addAttribute("labelMap", labelMap);
		}
		//로그인 체크
		model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated() ? "Y" : "N");
		
		//회원정보
		model.addAttribute("userInfo", (USERVO) EgovUserDetailsHelper.getAuthenticatedUser());
		
		if("EVNT".equals(resultVO.getPrmtDiv())) {
			return "web/evnt/detailPromotion";
		} else {
			return "web/evnt/detailPromotionPlan";
		}
	}

	@RequestMapping("/web/evnt/detailGovAnnouncement.do")
	public String detailGovAnnouncement(@ModelAttribute("prmtVO") PRMTVO prmtVO,
								  ModelMap model,
								  HttpServletRequest request) throws Exception {
		log.info("/web/evnt/detailGovAnnouncement.do call");

		String prmtNum = prmtVO.getPrmtNum();
		String connIp = EgovClntInfo.getClntIP(request);

		//뷰 카운트
		String iFlag = "Y";
		for(Constant.INSIDE_IP insideIp : Constant.INSIDE_IP.values()) {
			if(connIp.substring(0,3).equals(insideIp.getValue())) {
				iFlag = "N";
				break;
			}
		}

		if("Y".equals(iFlag)) {
			webPrmtService.updateViewCnt(prmtNum);
		}

		//첨부파일 정보 가저오기
		PRMTFILEVO prmtfileVO = new PRMTFILEVO();
		prmtfileVO.setPrmtNum(prmtVO.getPrmtNum());

		List<PRMTFILEVO> prmtFileList = masPrmtService.selectPrmtFileList(prmtfileVO);
		model.addAttribute("prmtFileList", prmtFileList);


		String param = "&prmtDiv=" + prmtVO.getPrmtDiv() + "&prmtNum=" + prmtNum;

		if(EgovClntInfo.isMobile(request)) {
			if(Constant.PRMT_DIV_PLAN.equals(prmtVO.getPrmtDiv())) {
				param += "&type=gova";
			}
			return "redirect:/mw/evnt/detailPromotion.do?" + param;
		}

		if(EgovStringUtil.isEmpty(prmtNum)) {
			log.error("prmtNum is null");
			return "redirect:/main.do";
		}

		// 공고 상세정보
		PRMTVO resultVO = webPrmtService.selectByPrmt(prmtVO);
		resultVO.setPageIndex(prmtVO.getPageIndex());
		model.addAttribute("prmtVO", resultVO);

		//로그인 체크
		model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated() ? "Y" : "N");

		return "web/evnt/detailGovAnnouncement";

	}

	@RequestMapping("/web/evnt/DtlFileDown.do")
	public void eventDtlFileDown(@ModelAttribute("PRMTFILEVO") PRMTFILEVO prmtFileVO
		, HttpServletRequest request
		, HttpServletResponse response
		, ModelMap model	)throws Exception{
		log.info("/web/evnt/DtlFileDown.do 호출");

		PRMTFILEVO prmtRes = masPrmtService.selectPrmtFile(prmtFileVO);

		String strRoot = EgovProperties.getProperty("HOST.WEBROOT");
		String strRealFileName = prmtRes.getRealFileNm();
		String strSaveFilePath = strRoot + prmtRes.getSavePath() + prmtRes.getSaveFileNm();
		File fileSaveFile = new File(strSaveFilePath);

		if(fileSaveFile.exists() == false){
			log.info("file not exist!!");
			return;
		}

		if (!fileSaveFile.isFile()) {
			log.info("file not isFile!!");
			return;
		}

		String userAgent = request.getHeader("User-Agent");

		int fSize = (int)fileSaveFile.length();
		if (fSize > 0) {
			BufferedInputStream in = null;

			try {
				in = new BufferedInputStream(new FileInputStream(fileSaveFile));
				response.setBufferSize(fSize);

				// MS 익스플로어
				if(userAgent.indexOf("MSIE") >= 0){
					response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(strRealFileName, "UTF-8") + "\";");
				}
				else if(userAgent.indexOf("Trident") >= 0) {
					response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(strRealFileName, "UTF-8") + "\";");
				}
				// 크롬, 파폭
				else if(userAgent.indexOf("Mozilla/5.0") >= 0){
					response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(strRealFileName, "UTF-8") + ";charset=\"UTF-8\"");
				}else{
					response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(strRealFileName, "UTF-8") + "\";");
				}

				response.setContentLength(fSize);

				byte[] buff = new byte[2048];
				ServletOutputStream ouputStream = response.getOutputStream();
				FileInputStream inputStream = new FileInputStream(fileSaveFile);

				try{
					int size = -1;
					while((size = inputStream.read(buff)) > 0) {
						ouputStream.write(buff, 0, size);
						response.getOutputStream().flush();
					}
				}finally {
					try {
						in.close();
					}
					catch (IOException ex) {
					}
					try {
						ouputStream.close();
					}
					catch (IOException ex) {
					}
					inputStream.close();
				}

			} finally {
				if (in != null) {
					try {
						in.close();
					} catch (Exception ignore) {
						log.info("IGNORED: " + ignore.getMessage());
					}
				}
			}
			response.getOutputStream().close();
		}
	}

	@RequestMapping("/web/evnt/uploadGovAnnouncementFile.ajax")
	public ModelAndView uploadGovAnnouncementFile(MultipartHttpServletRequest multiRequest,
										   GOVAVO govaVO,
										   HttpServletRequest request) throws Exception {

		log.info("/web/evnt/uploadGovAnnouncementFile.ajax call...공고 신청 업로드...");
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String userId = userVO.getUserId();

		if (userId == null || userId.trim().isEmpty()) {
			Map<String, Object> errorMap = new HashMap<>();
			errorMap.put("Status", "fail");
			errorMap.put("Message", "로그인이 필요합니다.");
			return new ModelAndView("jsonView", errorMap);
		}

		String uploadedList = ossFileUtilService.uploadGovAnnouncementFile(userId, multiRequest, govaVO);


		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("Status", "success");
		resultMap.put("Uploaded", uploadedList.toString().trim());

		return new ModelAndView("jsonView", resultMap);
	}

	@RequestMapping("/wmn/govAnnouncementList.do")
	public String govAnnouncementList(ModelMap model, HttpServletRequest request, GOVASVO govaSVO){

		// 세션 체크
		USERVO loginVO = (USERVO) request.getSession().getAttribute("wmnLoginVO");
		if (loginVO == null) {
			return "redirect:/wmn/intro.do"; // 로그인 페이지로 리다이렉트
		}

		if(govaSVO.getPrmtNum() != null){
			//공고 신청 리스트
			List<LowerHashMap> resultList  = webPrmtService.govaList(govaSVO);

			model.addAttribute("resultCd", "200");
			model.addAttribute("resultMsg", "OK");
			model.addAttribute("resultList", resultList);
		}else{
			model.addAttribute("resultCd", "401");
			model.addAttribute("resultMsg", "Unauthorized");
		}

		return "wmn/govAnnouncementList";
	}

	@RequestMapping("/wmn/govAnnouncementDownload.do")
	public void govAnnouncementDownload(@RequestParam String folderName,@RequestParam String orgName, HttpServletResponse response) throws IOException {
		String basePath = EgovProperties.getProperty("HOST.WEBROOT") + "/data/prmt/gova";
		File folder = new File(basePath, folderName);

		if (!folder.exists() || !folder.isDirectory()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "폴더를 찾을 수 없습니다.");
			return;
		}

		// 파일명 인코딩
		String encodedFileName = URLEncoder.encode(orgName, "UTF-8").replaceAll("\\+", "%20");
		String contentDisposition = "attachment; filename*=UTF-8''" + encodedFileName + ".zip";

		response.setContentType("application/zip");
		response.setHeader("Content-Disposition", contentDisposition);
		try (ZipOutputStream zos = new ZipOutputStream(response.getOutputStream())) {
			zipFolderContents(folder, zos);
		}
	}

	private void zipFolderContents(File folder, ZipOutputStream zos) throws IOException {
		File[] files = folder.listFiles();
		if (files == null || files.length == 0) return;

		for (File file : files) {
			try (FileInputStream fis = new FileInputStream(file)) {
				ZipEntry zipEntry = new ZipEntry(file.getName());
				zos.putNextEntry(zipEntry);

				byte[] buffer = new byte[4096];
				int len;
				while ((len = fis.read(buffer)) > 0) {
					zos.write(buffer, 0, len);
				}

				zos.closeEntry();
			}
		}
	}

	@RequestMapping("/web/evnt/uploadHometownFile.ajax")
	public ModelAndView uploadHometownFile(MultipartHttpServletRequest multiRequest, FILEVO fileVO, HttpServletRequest request) throws Exception {

		// 첨부파일 등록
		String strSaveFilePath = "/data/prmt/hometown"; // /data/prmt/hometown, D:/data/prmt/hometown
		ossFileUtilService.uploadHometownFile(multiRequest, strSaveFilePath, fileVO);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("Status", "success");
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}

	@RequestMapping("/wmn/updateGovaMemo.ajax")
	public ModelAndView updateGovaMemo(GOVAVO govaVO) throws Exception {

		webPrmtService.updateGovaMemo(govaVO);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("Status", "success");
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}

	@RequestMapping("/wmn/updateGovaConfirmed.ajax")
	public ModelAndView updateGovaConfirmed(GOVAVO govaVO) throws Exception {

		webPrmtService.updateGovaConfirmed(govaVO);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("Status", "success");
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}

	@RequestMapping("/wmn/intro.do")
	public String login(){
		return "/wmn/intro";
	}

	@RequestMapping("/wmn/actionWmnLogin.ajax")
	public ModelAndView actionWmnLogin(@ModelAttribute("loginVO") USERVO loginVO,
										   HttpServletRequest request) throws Exception {

		Map<String, Object> resultMap = new HashMap<>();

		if (EgovStringUtil.isEmpty(loginVO.getEmail())) {
			resultMap.put("status", "fail");
			resultMap.put("reason", "email");
			return new ModelAndView("jsonView", resultMap);
		}

		if (EgovStringUtil.isEmpty(loginVO.getPwd())) {
			resultMap.put("status", "fail");
			resultMap.put("reason", "pwd");
			return new ModelAndView("jsonView", resultMap);
		}

		String userIp = EgovClntInfo.getClntIP(request);
		loginVO.setLastLoginIp(userIp);

		USERVO resultVO = ossUserService.actionOssLogin(loginVO);

		if (resultVO != null && resultVO.getUserId() != null && !resultVO.getUserId().isEmpty()) {
			resultVO.setLastLoginIp(userIp);
			request.getSession().setAttribute("wmnLoginVO", resultVO);
			resultMap.put("status", "success");
		} else {
			resultMap.put("status", "fail");
			resultMap.put("reason", "invalid");
		}

		return new ModelAndView("jsonView", resultMap);
	}

	@RequestMapping("/wmn/getPrmtAutoList.ajax")
	public ModelAndView getPrmtAutoList(@RequestParam(value = "term", required = false) String term) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();

		List<LowerHashMap> allList = webPrmtService.selectAutoCompleteList();
		List<Map<String, String>> filtered = allList.stream()
			.filter(map -> term == null || map.get("prmtNm").toString().toLowerCase().contains(term.toLowerCase()))
			.map(map -> {
				Map<String, String> m = new HashMap<>();
				m.put("prmtNum", map.get("prmtNum").toString());
				m.put("prmtNm", map.get("prmtNm").toString());
				return m;
			}).collect(Collectors.toList());

		resultMap.put("list", filtered);
		return new ModelAndView("jsonView", resultMap);
	}

	//이벤트 이미지 업로드
	@RequestMapping("/web/evnt/uploadPrmtFile.ajax")
	public ModelAndView uploadPrmtFile(MultipartHttpServletRequest multiRequest, FILEVO fileVO, HttpServletRequest request) throws Exception {

		// "/data/prmt/"+fileVO.getPrmtNum();, "D:/data/prmt/"+fileVO.getPrmtNum();
		String strSaveFilePath = "/data/prmt/"+fileVO.getPrmtNum();
		ossFileUtilService.uploadPrmtFile(multiRequest, strSaveFilePath, fileVO);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("Status", "success");
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}
	
	// 정렬 내림차순
	public class DescPrmt implements Comparator<PRMTPRDTVO> {

	    @Override
	    public int compare(PRMTPRDTVO o1, PRMTPRDTVO o2) {
	    	int nPrintSn1 = 0;
	    	int nPrintSn2 = 0;

	    	if(!(o1.getPrintSn() == null || o1.getPrintSn().isEmpty() || "".equals(o1.getPrintSn()))) {
	    		nPrintSn1 = Integer.parseInt(o1.getPrintSn());
	    	}

	    	if(!(o2.getPrintSn() == null || o2.getPrintSn().isEmpty() || "".equals(o2.getPrintSn()))) {
	    		nPrintSn2 = Integer.parseInt(o2.getPrintSn());
	    	}

	    	return nPrintSn1-nPrintSn2;
	        //return o2.getName().compareTo(o1.getName());
	    }

	}

	/**
	 * 이벤트 댓글 등록
	 * Function : prmtCmtInsert
	 * 작성일 : 2016. 8. 19. 오후 2:34:36
	 * 작성자 : 정동수
	 * @param prmtCmtVO
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/web/evnt/prmtCmtInsert.ajax")
	public void prmtCmtInsert(@ModelAttribute("prmtCmtVO") PRMTCMTVO prmtCmtVO,
							  HttpServletResponse response) throws IOException {
		log.info("/web/evnt/prmtCmtInsert.do call");

		//로그인 정보 얻기
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();

		prmtCmtVO.setUserId(userVO.getUserId());
		prmtCmtVO.setEmail(userVO.getEmail());
		prmtCmtVO.setFrstRegIp(userVO.getLastLoginIp());

		// 댓글 등록
		webPrmtService.insertPrmtCmt(prmtCmtVO);

		JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.print(jsnObj.toString());
		printWriter.flush();
		printWriter.close();
	}

	@RequestMapping("/web/evnt/prmtCmtDelete.ajax")
	public void prmtCmtDelete(@ModelAttribute("prmtCmtVO") PRMTCMTVO prmtCmtVO, HttpServletResponse response, ModelMap model) throws IOException {
		log.info("/web/evnt/prmtCmtDelete.do call");

		webPrmtService.deletePrmtCmt(prmtCmtVO);

		JSONObject jsnObj = new JSONObject();
    	jsnObj.put("Status", "success");
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter printWriter = response.getWriter();
		printWriter.print(jsnObj.toString());
		printWriter.flush();
		printWriter.close();
	}

	/**
	 * 프로모션의 댓글 리스트
	 * Function : getPrmtCmtList
	 * 작성일 : 2016. 8. 31. 오전 9:09:21
	 * 작성자 : 정동수
	 * @param prmtCmtVO
	 * @return
	 */
	@RequestMapping("/web/evnt/prmtCmtList.ajax")
	public String prmtCmtList(@ModelAttribute("prmtCmtVO") PRMTCMTVO prmtCmtVO, ModelMap model) {
		log.info("web/evnt/prmtCmtList.ajax call");

		PaginationInfo paginationInfo = new PaginationInfo();
		List<PRMTCMTVO> rmtCmtList = new ArrayList<PRMTCMTVO>();

		//로그인 체크
		USERVO userVO = new USERVO();
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");

    	if (EgovUserDetailsHelper.isAuthenticated()) {
			userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		}

		prmtCmtVO.setPageUnit(propertiesService.getInt("webPageSize"));
		prmtCmtVO.setPageSize(propertiesService.getInt("webEvntPageSize"));

		/** pageing setting */
		paginationInfo.setCurrentPageNo(prmtCmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtCmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtCmtVO.getPageSize());

		prmtCmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtCmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtCmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		prmtCmtVO.setPrmtNum(prmtCmtVO.getPrmtNum());
		prmtCmtVO.setPrintYn(Constant.FLAG_Y);

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount(webPrmtService.selectPrmtCmtTotalCnt(prmtCmtVO));

		rmtCmtList = webPrmtService.selectPrmtCmtList(prmtCmtVO);

		model.addAttribute("userId", userVO.getUserId());
		model.addAttribute("rmtCmtList", rmtCmtList);
		model.addAttribute("prmtCmtVO", prmtCmtVO);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/web/evnt/promotionCmt";
	}

	@RequestMapping("/web/point.do")
	public String pointEventList(@ModelAttribute("searchVO") PRMTVO prmtVO,
							   ModelMap model,
							   HttpServletRequest request) {
		log.info("/web/point.do");

		try {
			if(EgovClntInfo.isMobile(request)) {
				return "forward:/mw/point.do";
			}
		} catch (Exception e) {
			log.error(e.toString());
		}
		prmtVO.setPageUnit(propertiesService.getInt("webEvntPageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("webEvntPageSize"));
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}
		// 기획전 형태
		prmtVO.setPrmtDiv(Constant.PRMT_DIV_PLAN);
		// 상품 리스트
		Map<String, Object> resultMap = webPrmtService.selectPointList();
		@SuppressWarnings("unchecked")
		List<PRMTVO> resultList = (List<PRMTVO>) resultMap.get("resultList");
		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pointImgPath", EgovProperties.getProperty("COUPON.SAVEDFILE"));
		return "web/evnt/pointList";
	}

	@RequestMapping("/web/hdc.do")
	public String pointHdc(@ModelAttribute("searchVO") PRMTVO prmtVO,
							   ModelMap model,
							   HttpServletRequest request) {
		log.info("/web/hdc.do");

		try {
			if(EgovClntInfo.isMobile(request)) {
				return "forward:/mw/hdc.do";
			}
		} catch (Exception e) {
			log.error(e.toString());
		}
		prmtVO.setPageUnit(propertiesService.getInt("webEvntPageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("webEvntPageSize"));
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}
		// 기획전 형태
		prmtVO.setPrmtDiv(Constant.PRMT_DIV_PLAN);
		// 상품 리스트
		Map<String, Object> resultMap = webPrmtService.selectPointList();
		@SuppressWarnings("unchecked")
		List<PRMTVO> resultList = (List<PRMTVO>) resultMap.get("resultList");
		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pointImgPath", EgovProperties.getProperty("COUPON.SAVEDFILE"));
		return "web/evnt/pointHdcList";
	}

	@RequestMapping("/mw/point.do")
	public String mwPointEventList(@ModelAttribute("searchVO") PRMTVO prmtVO,
							   ModelMap model,
							   HttpServletRequest request) {
		log.info("/mw/point.do");

		prmtVO.setPageUnit(propertiesService.getInt("webEvntPageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("webEvntPageSize"));
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}
		// 기획전 형태
		prmtVO.setPrmtDiv(Constant.PRMT_DIV_PLAN);
		// 상품 리스트
		Map<String, Object> resultMap = webPrmtService.selectPointList();
		@SuppressWarnings("unchecked")
		List<PRMTVO> resultList = (List<PRMTVO>) resultMap.get("resultList");
		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pointImgPath", EgovProperties.getProperty("COUPON.SAVEDFILE"));

		return "mw/evnt/pointList";
	}

	@RequestMapping("/mw/hdc.do")
	public String mwPointHdcList(@ModelAttribute("searchVO") PRMTVO prmtVO,
							   ModelMap model,
							   HttpServletRequest request) {
		log.info("/mw/hdc.do");

		prmtVO.setPageUnit(propertiesService.getInt("webEvntPageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("webEvntPageSize"));
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		if(prmtVO.getFinishYn() == null) {
			prmtVO.setFinishYn(Constant.FLAG_N);
		}
		if(prmtVO.getWinsYn() == null) {
			prmtVO.setWinsYn(Constant.FLAG_N);
		}
		// 기획전 형태
		prmtVO.setPrmtDiv(Constant.PRMT_DIV_PLAN);
		// 상품 리스트
		Map<String, Object> resultMap = webPrmtService.selectPointList();
		@SuppressWarnings("unchecked")
		List<PRMTVO> resultList = (List<PRMTVO>) resultMap.get("resultList");
		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pointImgPath", EgovProperties.getProperty("COUPON.SAVEDFILE"));

		return "mw/evnt/pointHdcList";
	}
}
