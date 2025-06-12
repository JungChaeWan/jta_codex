package oss.user.web;


import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.cmm.web.SHA256;
import oss.point.service.OssPointService;
import oss.point.vo.POINTVO;
import oss.rsv.service.OssRsvService;
import oss.useepil.vo.USEEPILVO;
import oss.user.service.OssUserService;
import oss.user.vo.UPDATEUSERVO;
import oss.user.vo.USERSVO;
import oss.user.vo.USERVO;
import web.bbs.service.WebBbsService;
import web.bbs.vo.NOTICEVO;
import web.order.vo.ORDERVO;
import web.order.vo.RSVVO;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 사용자 관리
 * 파일명 : OssUserController.java
 * 작성일 : 2015. 9. 22. 오전 9:51:00
 * 작성자 : 최영철
 */
@Controller
public class OssUserController {

    @Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name="ossUserService")
	protected OssUserService ossUserService;

	@Resource(name="ossRsvService")
	protected OssRsvService ossRsvService;

	@Resource(name = "webBbsService")
	protected WebBbsService webBbsService;

	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Autowired
	private OssPointService ossPointService;

    Logger log = LogManager.getLogger(this.getClass());

    /**
     * 사용자 리스트 조회
     * 파일명 : userList
     * 작성일 : 2015. 9. 25. 오후 5:06:56
     * 작성자 : 최영철
     * @param userSVO
     * @param model
     * @return
     */
    @RequestMapping("/oss/userList.do")
    public String userList(@ModelAttribute("searchVO") USERSVO userSVO,
    						ModelMap model){
    	log.info("/oss/userList.do 호출");

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		String ssPartnerCode = userVO.getPartnerCode();

		userSVO.setPartnerCode(ssPartnerCode);
    	userSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	userSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userSVO.getPageUnit());
		paginationInfo.setPageSize(userSVO.getPageSize());

		userSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossUserService.selectUserList(userSVO);

		@SuppressWarnings("unchecked")
		List<USERVO> resultList = (List<USERVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("ssPartnerCode", ssPartnerCode);
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

    	return "/oss/user/userList";
    }

	// 사용자 목록 엑셀 저장
    @RequestMapping("/oss/userSaveExcel.do")
	public void userSaveExcel(@ModelAttribute("searchVO") USERSVO userSVO,
							  HttpServletRequest request,
							  HttpServletResponse response) {
		log.info("/oss/userSaveExcel.do 호출");

		List<USERVO> resultList = ossUserService.selectExcelUserListHandler(userSVO);

		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100);


		Sheet sheet1 = xlsxWb.createSheet("사용자 목록");

		// 컬럼 너비 설정
        sheet1.setColumnWidth(0, 4000);
        sheet1.setColumnWidth(1, 4000);
        sheet1.setColumnWidth(2, 3000);
        sheet1.setColumnWidth(3, 3000);
        sheet1.setColumnWidth(4, 8000);
        sheet1.setColumnWidth(5, 5000);
        sheet1.setColumnWidth(6, 2000);
        sheet1.setColumnWidth(7, 5000);
        sheet1.setColumnWidth(8, 2000);
        sheet1.setColumnWidth(9, 2000);

		XSSFCellStyle cellStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
        cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

        Row row = null;
        Cell cell = null;

        // 첫 번째 줄
        row = sheet1.createRow(0);

        // 첫 번째 줄에 Cell 설정하기-------------
        cell = row.createCell(0);
        cell.setCellValue("사용자아이디");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(1);
        cell.setCellValue("고객명");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(2);
        cell.setCellValue("권한");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(3);
        cell.setCellValue("업체관리자여부");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(4);
        cell.setCellValue("이메일");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(5);
        cell.setCellValue("전화번호");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(6);
        cell.setCellValue("마케팅수신여부");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(7);
        cell.setCellValue("가입일시");
        cell.setCellStyle(cellStyle);

        cell = row.createCell(8);
        cell.setCellValue("불량고객");
        cell.setCellStyle(cellStyle);
        
        cell = row.createCell(9);
        cell.setCellValue("파트너코드");
        cell.setCellStyle(cellStyle);        

        for (int i = 0; i < resultList.size(); i++) {
        	USERVO resultVO = resultList.get(i);

			row = sheet1.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue(resultVO.getUserId());

			cell = row.createCell(1);
			cell.setCellValue(resultVO.getUserNm());

			cell = row.createCell(2);
			if("ADMIN".equals(resultVO.getAuthNm())){
				cell.setCellValue("관리자");
			}else{
				cell.setCellValue("일반사용자");
			}
			cell = row.createCell(3);
			cell.setCellValue(resultVO.getCorpAdmYn());

			cell = row.createCell(4);
			cell.setCellValue(resultVO.getEmail());

			cell = row.createCell(5);
			cell.setCellValue(resultVO.getTelNum());

			cell = row.createCell(6);
			cell.setCellValue(resultVO.getMarketingRcvAgrYn());

			cell = row.createCell(7);
			cell.setCellValue(resultVO.getFrstRegDttm());

			String strTmp = "";
			if("Y".equals(resultVO.getBadUserYn())) {
				strTmp = "불량고객";
			}
			cell = row.createCell(8);
			cell.setCellValue(strTmp);
			
			cell = row.createCell(9);
			cell.setCellValue(resultVO.getPartnerCd());			
		}

		// 실제 저장될 파일 이름
		String realName = "userList.xlsx";

		try {
			String userAgent = request.getHeader("User-Agent");

			if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) {		// MS IE 5.5 이하
				response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(realName, "UTF-8") + ";");
			} else if(userAgent.indexOf("MSIE") >= 0){
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
			e.printStackTrace();
			log.error(e);
        } catch (IOException e) {
			e.printStackTrace();
			log.error(e);
        }
		//return "ezadm/Entry/mngEntryList";
	}

	/**
	* 설명 : User ID 값 유무로 insert / update page
	* 파일명 : viewInsertUser
	* 작성일 : 2021-02-18 오전 11:44
	* 작성자 : 정채완
	* @param  userVO, userSVO, model
	* @return java.lang.String
	* @throws Exception
	*/
	@RequestMapping("/oss/viewInsertUser.do")
    public String viewInsertUser(	@ModelAttribute("USERVO") USERVO userVO,
    								@ModelAttribute("searchVO") USERSVO userSVO,
    								ModelMap model){

    	if("".equals(userVO.getUserId()) || userVO.getUserId() == null) {
			model.addAttribute("user", userVO);
		}else{
			//유저정보 get/set
			USERVO resultVO = ossUserService.selectByUser(userVO);
			//이메일 문자열 나누기
			if(resultVO.getEmail() != null && resultVO.getEmail() != ""){
				String[] email = resultVO.getEmail().split("@");

				if(email.length == 0){
					resultVO.setEmail("");
					resultVO.setEmail_host("");
				}else if(email.length == 2){
					resultVO.setEmail(email[0]);
					resultVO.setEmail_host(email[1]);
				}
			}
			model.addAttribute("user", resultVO);
		}
		return "/oss/user/insertUser";
    }

	/**
	 * 설명 : User ID 값 유무로 insert / update proc
	 * 파일명 : insertUser
	 * 작성일 : 2021-02-18 오전 11:41
	 * 작성자 : 정채완
	 * @param  user
	 * @return java.lang.String
	 * @throws Exception
	 */
	@RequestMapping("/oss/insertUser.do")
	public String insertUser(	@ModelAttribute("USERVO") UPDATEUSERVO user ) throws Exception{

		user.setEmail(user.getEmail() + "@" + user.getEmail_host());

		if("".equals(user.getUserId()) || user.getUserId() == null) {
			//insert
			// 패스워드 암호화
			SHA256 sha256 = new SHA256();
			String pwd = sha256.getSHA256_pwd(user.getPwd());
			user.setPwd(pwd);
			ossUserService.insertUser(user);
		}else{
			//update
			ossUserService.updateUser(user);
		}
		return "redirect:/oss/userList.do";
	}

	/**
	 * 이메일 중복 체크
	 * 파일명 : eamilDuplication
	 * 작성일 : 2015. 10. 2. 오전 11:08:40
	 * 작성자 : 최영철
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/emailDuplication.ajax")
	public ModelAndView emailDuplication(@RequestParam Map<String, String> params) {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		USERVO userVO = new USERVO();
		userVO.setEmail(params.get("email"));
		if(!"".equals(params.get("email")) && params.get("email") != null ){
			USERVO chkVO = ossUserService.selectByUser(userVO);

			if(chkVO != null) {
				if(params.get("userId") != null) {
					if(params.get("userId").equals(chkVO.getUserId())) {
						resultMap.put("chk", "Y");
					} else {
						resultMap.put("chk", "N");
					}
				} else {
					resultMap.put("chk", "Y");
					resultMap.put("userId", chkVO.getUserId());
				}
			} else {
				resultMap.put("chk", "N");
			}
		}else{
			resultMap.put("chk", "N");
		}

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}

	/**
	* 설명
	* 파일명 : telDuplication
	* 작성일 : 2021-02-15 오후 6:11
	* 작성자 : 정채완
	* @param  telNum
	* @return int
	* @throws
	*/
	@RequestMapping("/telDuplication.ajax")
	public @ResponseBody int telDuplication(@RequestParam("telNum") String telNum) {

		USERSVO userSVO = new USERSVO();
		userSVO.setsTelNum(telNum);
		List<USERVO> userListVO = ossUserService.selectByUserTelNum(userSVO);

		if (userListVO.size() > 0) {
			return 0;
		} else {
			return 1;
		}
	}

	@RequestMapping("/oss/findUser.do")
	public String findUser(@ModelAttribute("searchVO") USERSVO userSVO,
							ModelMap model){
		userSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	userSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userSVO.getPageUnit());
		paginationInfo.setPageSize(userSVO.getPageSize());

		userSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossUserService.selectUserList(userSVO);

		@SuppressWarnings("unchecked")
		List<USERVO> resultList = (List<USERVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "/oss/user/findUserPop";
	}

	/**
	 * 사용자 상세
	 * 파일명 : detailUser
	 * 작성일 : 2015. 9. 30. 오후 3:49:11
	 * 작성자 : 최영철
	 * @param userSVO
	 * @param user
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/detailUser.do")
	public String detailUser(@ModelAttribute("searchVO") USERSVO userSVO,
							 @ModelAttribute("USERVO") USERVO user,
							 ModelMap model) {
		// 사용자 정보
		USERVO resultVO = ossUserService.selectByUser(user);

		if(resultVO == null) {
			return "redirect:/web/cmm/error.do?errCord=USER01";
		}

		//발급 포인트/사용 포인트
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		POINTVO pointVO = new POINTVO();
		pointVO.setPartnerCode(userVO.getPartnerCode());
		pointVO.setUserId(user.getUserId());

		//리스트형 파트너 포인트 조회 (group by PARTNER_CODE)
		List<POINTVO> partnerPointList = ossPointService.selectAblePointList(pointVO);
		//개인별 파트너포인트 조회
		POINTVO partnerPoint = ossPointService.selectAblePoint(pointVO);

		// 상담 정보
		NOTICEVO noticeVO = new NOTICEVO();
		noticeVO.setBbsNum("CALL");
		noticeVO.setUserId(user.getUserId());

		List<NOTICEVO> callList = webBbsService.selectNoticeList(noticeVO);

		model.addAttribute("user", resultVO);
		model.addAttribute("callList", callList);
		model.addAttribute("partnerPoint", partnerPoint);
		model.addAttribute("partnerPointList", partnerPointList);
		model.addAttribute("partnerCode", userVO.getPartnerCode());

		return "/oss/user/detailUser";
	}

	/**
	 * 상담 목록
	 */
	@RequestMapping("/oss/noticeList.ajax")
	public ModelAndView noticeList(@RequestParam Map<String, String> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		NOTICEVO noticeVO = new NOTICEVO();
		noticeVO.setBbsNum(params.get("bbsNum"));
		noticeVO.setUserId(params.get("userId"));
		noticeVO.setSubject(params.get("subject"));

		List<NOTICEVO> callList = webBbsService.selectNoticeList(noticeVO);

		resultMap.put("result", callList);

		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	/**
	 * 상담 정보
	 */
	@RequestMapping("/oss/noticeDetail.ajax")
	public ModelAndView noticeDetail(@RequestParam Map<String, String> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		NOTICEVO noticeVO = new NOTICEVO();
		noticeVO.setBbsNum(params.get("bbsNum"));
		noticeVO.setUserId(params.get("userId"));
		noticeVO.setSubject(params.get("subject"));

		List<NOTICEVO> callList = webBbsService.selectNoticeList(noticeVO);

		resultMap.put("result", callList);

		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	/**
	 * 상담 등록
	 */
	@RequestMapping("/oss/saveCall.ajax")
	public ModelAndView saveCall(@ModelAttribute("NOTICEVO") NOTICEVO noticeVO) {
		log.info("/oss/saveCall.ajax call");
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 관리자 정보
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		noticeVO.setWriter(userVO.getUserNm());
		noticeVO.setLastModId(userVO.getUserId());
		noticeVO.setLastModIp(userVO.getLastLoginIp());

		noticeVO.setBbsNum("CALL");

		if(StringUtils.isNotEmpty(noticeVO.getNoticeNum())) {
			webBbsService.updateNotice(noticeVO);

			resultMap.put("resultMsg", egovMessageSource.getMessage("success.common.update"));
		} else {
			noticeVO.setFrstRegId(userVO.getUserId());
			noticeVO.setFrstRegIp(userVO.getLastLoginIp());

			if(StringUtils.isEmpty(noticeVO.getHrkNoticeNum())) {
				webBbsService.insertNotice(noticeVO);
			} else {
				noticeVO.setNoticeNum(noticeVO.getHrkNoticeNum());

				int ansSn = webBbsService.getCnthrkNoticeNum(noticeVO);

				noticeVO.setAnsSn(ansSn + "");

				webBbsService.insertNoticeRe(noticeVO);
			}
			resultMap.put("resultMsg", egovMessageSource.getMessage("success.common.insert"));
		}
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	/**
	 * 사용자 탈퇴 처리
	 * 파일명 : dropUser
	 * 작성일 : 2015. 9. 30. 오후 6:25:11
	 * 작성자 : 최영철
	 * @param user
	 * @param userSVO
	 * @return
	 */
	@RequestMapping("/oss/dropUser.do")
	public String dropUser(@ModelAttribute("user") USERVO user,
						   @ModelAttribute("searchVO") USERSVO userSVO){

		ossUserService.dropUser(user);

		return "redirect:/oss/userList.do";
	}

	/**
	 * 탈퇴 사용자 조회
	 * 파일명 : dropUserList
	 * 작성일 : 2015. 10. 1. 오전 10:40:35
	 * 작성자 : 최영철
	 * @param userSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/oss/dropUserList.do")
	public String dropUserList(@ModelAttribute("searchVO") USERSVO userSVO,
								ModelMap model){
		userSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	userSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userSVO.getPageUnit());
		paginationInfo.setPageSize(userSVO.getPageSize());

		userSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossUserService.selectDropUserList(userSVO);

		@SuppressWarnings("unchecked")
		List<USERVO> resultList = (List<USERVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

    	return "/oss/user/dropUserList";
	}


	@RequestMapping("/oss/findUserSMSMail.do")
	public String findUserSMSMail(@ModelAttribute("searchVO") USERSVO userSVO,
									HttpServletRequest request,
									ModelMap model) {

		userSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	userSVO.setPageSize(propertiesService.getInt("pageSize"));
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userSVO.getPageUnit());
		paginationInfo.setPageSize(userSVO.getPageSize());

		userSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossUserService.selectUserList(userSVO);

		@SuppressWarnings("unchecked")
		List<USERVO> resultList = (List<USERVO>) resultMap.get("resultList");
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("type", request.getParameter("type"));

		return "/oss/user/findUserPopSMSMail";
	}

	/**
	* 설명 : 관리자 휴면계정 해제
	* 파일명 : checkRestAuthNum
	* 작성일 : 2021-12-09 오전 9:42
	* 작성자 : chaewan.jung
	* @param : [params, request]
	* @return : org.springframework.web.servlet.ModelAndView
	* @throws Exception
	*/
	@RequestMapping("/oss/adminRestUserCancel.ajax")
	public ModelAndView adminRestUserCancel(HttpServletRequest request) {

		String userId = request.getParameter("userId");
		Map<String, Object> resultMap = new HashMap<String, Object>();

		if("".equals(userId)){
			resultMap.put("success", "N");
			resultMap.put("msg", "로그인 정보가 없습니다.");
		} else {
			USERSVO userSVO = new USERSVO();
			userSVO.setsUserId(userId);
			ossUserService.updateRestUserCancel(userSVO);

			resultMap.put("success", "Y");
			resultMap.put("msg", "휴면계정이 해제 되었습니다.");
		}
		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
	}


	@RequestMapping("/oss/pointUsageInfo.do")
	public String pointUsageInfo(@ModelAttribute("searchVO") USERSVO userSVO,
						   ModelMap model){
		log.info("/oss/userList.do 호출");

		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		String ssPartnerCode = userVO.getPartnerCode();

		userSVO.setPartnerCode(ssPartnerCode);
		userSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		userSVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userSVO.getPageUnit());
		paginationInfo.setPageSize(userSVO.getPageSize());

		userSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = ossUserService.selectPointUsageInfoList(userSVO);

		@SuppressWarnings("unchecked")
		List<USERVO> resultList = (List<USERVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		//예산액, 총발급포인트, 총사용포인트
		POINTVO pointInfo = ossUserService.getPointInfo(userSVO.getPartnerCode());

		model.addAttribute("ssPartnerCode", ssPartnerCode);
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pointInfo", pointInfo);

		return "/oss/user/pointUsageInfo";
	}

	@RequestMapping("/oss/pointUsageInfoExcel.do")
	public void pointUsageInfoExcel(@ModelAttribute("searchVO") USERSVO userSVO, HttpServletRequest request, HttpServletResponse response) {
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		String ssPartnerCode = userVO.getPartnerCode();

		userSVO.setPartnerCode(ssPartnerCode);
		userSVO.setLastIndex(0);
		Map<String, Object> resultMap = ossUserService.selectPointUsageInfoList(userSVO);

		@SuppressWarnings("unchecked")
		List<USERVO> resultList = (List<USERVO>) resultMap.get("resultList");

		SXSSFWorkbook xlsxWb = new SXSSFWorkbook(100);
		Sheet sheet1 = xlsxWb.createSheet("사용현황");

		// 컬럼 너비 및 스타일 설정
		sheet1.setColumnWidth(0, 5000); // 고객명
		sheet1.setColumnWidth(1, 6000); // 연락처
		sheet1.setColumnWidth(2, 5000); // 발급포인트
		sheet1.setColumnWidth(3, 5000); // 사용포인트
		sheet1.setColumnWidth(4, 5000); // 잔여포인트

		XSSFCellStyle cellStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

		XSSFCellStyle numberStyle = (XSSFCellStyle) xlsxWb.createCellStyle();
		numberStyle.setDataFormat(xlsxWb.createDataFormat().getFormat("#,##0"));

		Row row = sheet1.createRow(0);
		String[] headers = {"고객명", "연락처", "이메일", "발급포인트", "사용포인트", "잔여포인트"};

		for (int i = 0; i < headers.length; i++) {
			Cell cell = row.createCell(i);
			cell.setCellValue(headers[i]);
			cell.setCellStyle(cellStyle);
		}

		for (int i = 0; i < resultList.size(); i++) {
			USERVO data = resultList.get(i);
			row = sheet1.createRow(i + 1);

			row.createCell(0).setCellValue(data.getUserNm());
			row.createCell(1).setCellValue(data.getTelNum());
			row.createCell(2).setCellValue(data.getEmail());

			Cell plusPointCell = row.createCell(3);
			plusPointCell.setCellValue(data.getPlusPoint());
			plusPointCell.setCellStyle(numberStyle);

			Cell minusPointCell = row.createCell(4);
			minusPointCell.setCellValue(data.getMinusPoint());
			minusPointCell.setCellStyle(numberStyle);

			Cell remainPointCell = row.createCell(5);
			remainPointCell.setCellValue(data.getPlusPoint() - data.getMinusPoint());
			remainPointCell.setCellStyle(numberStyle);
		}

		try {
			String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
			String realName = "사용현황_" + timestamp + ".xlsx";
			String encodedFileName = URLEncoder.encode(realName, "UTF-8").replaceAll("\\+", "%20");

			// Content Type 설정
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

			// 브라우저별 분기 처리
			String userAgent = request.getHeader("User-Agent");
			if (userAgent != null && userAgent.contains("MSIE")) {
				// IE 10 이하
				response.setHeader("Content-Disposition", "attachment; filename=" + encodedFileName + ";");
			} else if (userAgent != null && userAgent.contains("Trident")) {
				// IE 11
				response.setHeader("Content-Disposition", "attachment; filename=" + encodedFileName + ";");
			} else if (userAgent != null && userAgent.contains("Edge")) {
				// Edge
				response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\";");
			} else if (userAgent != null && userAgent.contains("Chrome")) {
				// Chrome
				response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\";");
			} else if (userAgent != null && userAgent.contains("Firefox")) {
				// Firefox
				response.setHeader("Content-Disposition", "attachment; filename=\"" + realName + "\";");
			} else if (userAgent != null && userAgent.contains("Safari")) {
				// Safari
				response.setHeader("Content-Disposition", "attachment; filename=\"" + realName + "\";");
			} else {
				// 기타 브라우저
				response.setHeader("Content-Disposition", "attachment; filename=\"" + realName + "\";");
			}

			// 캐싱 방지 설정
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", 0);

			// 엑셀 파일 출력
			try (ServletOutputStream fileOutput = response.getOutputStream()) {
				xlsxWb.write(fileOutput);
				response.flushBuffer();
			}
		} catch (Exception e) {
			log.error("엑셀 다운로드 중 오류 발생: ", e);
		}
	}


}
