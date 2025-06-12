package oss.point.web;

import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import oss.cmm.service.OssFileUtilService;
import oss.point.service.OssPointService;
import oss.point.vo.*;
import oss.user.vo.USERVO;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Controller
public class OssPointController {

    @Autowired
    private OssPointService ossPointService;
    @Autowired
    private OssFileUtilService ossFileUtilService;

    /**
     * 설명 : 쿠폰번호 랜덤 생성 process
     * 파일명 : couponRandomCreate
     * 작성일 : 2022-10-25 오전 10:44
     * 작성자 : chaewan.jung
     * @param : []
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/point/couponRandomCreate.ajax")
    public ModelAndView couponRandomCreate(@ModelAttribute("POINT_CPNUMVO") POINT_CPNUMVO pointCpnumVO) {

        List<String> cpPointList = pointCpnumVO.getCpPointList();
        List<String> cpCntList  = pointCpnumVO.getCpCntList();

        //group code증가
        int groupCnt  = ossPointService.selectPointCpGroupCnt(pointCpnumVO.getPartnerCode());

        for (int j= 0; j < cpPointList.size(); j++){
            int couponSize = Integer.parseInt(cpCntList.get(j)); //쿠폰 생성 개수
            final char[] possibleCharacters = { //헷갈리는 1, I, O, 0 문자열 제외
                '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
            };

            final int possibleCharacterCount = possibleCharacters.length;
            String[] arr = new String[couponSize];
            Random rnd = new Random();
            int currentIndex = 0;
            int i = 0;
            while (currentIndex < couponSize) {
                StringBuffer buf = new StringBuffer(16);
                //12자리의 랜덤값으로 설정
                for (i = 12; i > 0; i--) {
                    buf.append(possibleCharacters[rnd.nextInt(possibleCharacterCount)]);
                }
                String cpNum = buf.toString();
                arr[currentIndex] = cpNum;
                currentIndex++;

                pointCpnumVO.setCpNum(cpNum); //쿠폰번호
                pointCpnumVO.setCpPoint(Integer.parseInt(cpPointList.get(j))); //쿠폰포인트
                pointCpnumVO.setGroupCode(""+(j+groupCnt));

                ossPointService.insertPointCpNum(pointCpnumVO);
            }
        }

        Map<String, Object> resultMap = new HashMap<String,Object>();
        resultMap.put("success", "Y");
        ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

        return modelAndView;
    }

    /**
    * 설명 : 쿠폰 발급 리스트
    * 파일명 : couponList
    * 작성일 : 2022-10-25 오전 10:45
    * 작성자 : chaewan.jung
    * @param : []
    * @return : java.lang.String
    * @throws Exception
    */
    @RequestMapping("/oss/point/couponPublishingList.do")
    public String couponList(POINT_CPNUMVO cpPublishingVO, ModelMap model) {
        /** pageing setting */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(cpPublishingVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(cpPublishingVO.getPageUnit());
        paginationInfo.setPageSize(cpPublishingVO.getPageSize());

        cpPublishingVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        cpPublishingVO.setLastIndex(paginationInfo.getLastRecordIndex());
        cpPublishingVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> resultMap = ossPointService.selectPointCpPublishingList(cpPublishingVO);
        List<POINT_CPNUMVO> cpPublishingList = (List<POINT_CPNUMVO>) resultMap.get("resultList");
        // 총 건수 셋팅
        paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
        model.addAttribute("totalCnt", resultMap.get("totalCnt"));
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("cpPublishingList", cpPublishingList);

        model.addAttribute("partnerCode", cpPublishingVO.getPartnerCode());
        return "/oss/point/couponPublishingList";
    }

    /**
    * 설명 : 자체발급 팝업창
    * 파일명 : selfPublishingPop
    * 작성일 : 2022-10-25 오전 10:45
    * 작성자 : chaewan.jung
    * @param :
    * @return : java.lang.String
    * @throws Exception
    */
    @RequestMapping("/oss/point/selfPublishing.ajax")
    public String selfPublishingPop(POINT_CPNUMVO cpPublishingVO, ModelMap model) {

        model.addAttribute("partnerCode", cpPublishingVO.getPartnerCode());
        return "/oss/point/selfPublishingPop";
    }

    /**
     * 설명 : 쿠폰 리스트
     * 파일명 : pointList
     * 작성일 : 2022-10-26 오후 16:20
     * 작성자 : chaewan.jung
     * @param : []
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/point/couponList.do")
    public String pointList(@ModelAttribute("searchVO") POINT_CPSVO pointCpSVO,
                            ModelMap model) {
        /** pageing setting */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(pointCpSVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(pointCpSVO.getPageUnit());
        paginationInfo.setPageSize(pointCpSVO.getPageSize());

        pointCpSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        pointCpSVO.setLastIndex(paginationInfo.getLastRecordIndex());
        pointCpSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> resultMap = ossPointService.selectPointCpList(pointCpSVO);
        List<POINT_CPVO> pointCpList = (List<POINT_CPVO>) resultMap.get("resultList");

        // 총 건수 셋팅
        paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
        model.addAttribute("totalCnt", resultMap.get("totalCnt"));
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("pointCpList", pointCpList);

        return "/oss/point/couponList";
    }

    /**
     * 설명 : 쿠폰 생성 팝업창
     * 파일명 : couponCreatePop
     * 작성일 : 2022-10-27 오전 11:31
     * 작성자 : chaewan.jung
     * @param : []
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/point/couponCreatePop.ajax")
    public String couponCreatePop(HttpServletRequest request, ModelMap model) {
        String partnerCode = request.getParameter("partnerCode");
        if (!"".equals(partnerCode)) {
            POINT_CPVO pointCpDetail = ossPointService.selectPointCpDetail(partnerCode);
            model.addAttribute("pointCpDetail", pointCpDetail);
        }

        model.addAttribute("partnerCode", partnerCode);
        return "/oss/point/couponCreatePop";
    }

    /**
     * 설명 : 쿠폰 생성 process
     * 파일명 : couponCreate
     * 작성일 : 2022-10-27 오전 11:32
     * 작성자 : chaewan.jung
     * @param : []
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/point/couponEdit.ajax")
    public ModelAndView couponEdit(@ModelAttribute("POINT_CP") POINT_CPVO pointCp, MultipartHttpServletRequest multiRequest) throws Exception{

        USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
        pointCp.setRegId(userVO.getUserId());

        // 첨부 파일 업로드
        String savePath = EgovProperties.getProperty("COUPON.SAVEDFILE");
        POINT_CPVO filePathVO = ossFileUtilService.uploadPointCpFile(multiRequest, savePath, pointCp.getPartnerCode());
        pointCp.setPartnerLogow(filePathVO.getPartnerLogow());
        pointCp.setPartnerLogom(filePathVO.getPartnerLogom());
        pointCp.setBannerThumb(filePathVO.getBannerThumb());

        if ("I".equals(pointCp.getEditType())) {
            ossPointService.insertPointCp(pointCp);
        }else{
            ossPointService.updatePointCp(pointCp);
        }

        Map<String, Object> resultMap = new HashMap<String,Object>();
        resultMap.put("success", "Y");
        ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
        return modelAndView;
    }
    @RequestMapping("/oss/point/pcDuplication.ajax")
    public ModelAndView pcDuplication(@ModelAttribute("POINT_CP") POINT_CPVO pointCp) {
        int partnerCnt  = ossPointService.selectPartnerCodeDuplChk(pointCp);
        Map<String, Object> resultMap = new HashMap<String,Object>();
        resultMap.put("partnerCnt", partnerCnt);
        ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

        return modelAndView;
    }

    /**
     * 설명 : 쿠폰 등록 팝업 창
     * 파일명 : couponRegPop
     * 작성일 : 2023-02-13 오후 3:06
     * 작성자 : chaewan.jung
     * @param : []
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/web/point/couponRegPop.do")
    public String couponRegPop(HttpServletRequest request, ModelMap model) {
        model.addAttribute("cssView", request.getParameter("cssView"));
        model.addAttribute("divView", request.getParameter("divView"));
        if ("Y".equals(request.getParameter("isMobile"))){
            return "/mw/point/couponRegPop";
        } else{
            return "/web/point/couponRegPop";
        }
    }

    /**
     * 설명 : 포인트 발급 / 사용 이력 팝업
     * 파일명 : pointHistoryPop
     * 작성일 : 2023-02-13 오후 3:06
     * 작성자 : chaewan.jung
     * @param : []
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/web/point/pointHistoryPop.do")
    public String pointHistoryPop(HttpServletRequest request, ModelMap model) {
        USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
        POINTVO pointVO = new POINTVO();

        String cssView = request.getParameter("cssView");
        System.out.println("request.getParameter(\"cssView\")=" + request.getParameter("cssView"));
        if("oss".equals(cssView)) {//관리자에서 접속
            pointVO.setPartnerCode(request.getParameter("partnerCode"));
            pointVO.setUserId(request.getParameter("userId"));

        }else{ //사용자에서 접속
            pointVO.setPartnerCode((String) request.getSession().getAttribute("ssPartnerCode"));
            pointVO.setUserId(userVO.getUserId());
       }

        List<POINTVO>  pointHistoryList = ossPointService.selectPointHistoryList(pointVO);
        model.addAttribute("pointHistoryList", pointHistoryList);
        model.addAttribute("cssView", cssView);
        model.addAttribute("divView", request.getParameter("divView"));
        System.out.println("request.getParameter(\"divView\")=" + request.getParameter("divView"));
        if ("Y".equals(request.getParameter("isMobile"))){
            return "/mw/point/pointHistoryPop";
        } else{
            return "/web/point/pointHistoryPop";
        }
    }

    @RequestMapping("/web/point/couponReg.ajax")
    public ModelAndView couponReg(@ModelAttribute("POINTVO") POINTVO pointVO) {

        USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
        pointVO.setUserId(userVO.getUserId());
        pointVO.setTypes("COUPON");

        Map<String, Object> resultMap = new HashMap<String,Object>();
        resultMap.put("success", "Y");

        String rtnStrng = ossPointService.chkPointCpRegAble(pointVO);

        if ("Y".equals(rtnStrng)){
            try {
                ossPointService.pointCpReg(pointVO);
            }catch (Exception e){
                resultMap.put("success", "E");
            }
        }else{
            resultMap.put("success", rtnStrng);
        }

        ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

        return modelAndView;
    }

    /**
     * 설명 : OSS(PTN) 관리자 포인트 발급/회수 POP
     * 파일명 : userPointCreatePop
     * 작성일 : 2023-01-31 오후 1:33
     * 작성자 : chaewan.jung
     * @param : [request, model]
     * @return : java.lang.String
     * @throws Exception
     */
    @RequestMapping("/oss/point/userPointCreatePop.ajax")
    public String userPointCreatePop(HttpServletRequest request, ModelMap model) {
        POINT_CPVO pointCpDetail =  ossPointService.selectPointCpDetail(request.getParameter("partnerCode"));
        model.addAttribute("pointCpDetail", pointCpDetail);
        model.addAttribute("userId", request.getParameter("userId"));
        return "/oss/point/userPointCreatePop";
    }

    /**
    * 설명 : OSS(PTN) 관리자 포인트 발급/회수 process
    * 파일명 : insertUserPoint
    * 작성일 : 2023-01-31 오후 1:33
    * 작성자 : chaewan.jung
    * @param : [pointVO]
    * @return : org.springframework.web.servlet.ModelAndView
    * @throws Exception
    */
    @RequestMapping("/oss/point/insertUserPoint.ajax")
    public ModelAndView insertUserPoint(@ModelAttribute("POINT") POINTVO pointVO) {
        POINTVO partnerPoint = ossPointService.selectAblePoint(pointVO);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("success", "N");
        if ("M".equals(pointVO.getPlusMinus()) && partnerPoint.getAblePoint() < pointVO.getPoint()){
            resultMap.put("success", "X");
        }else {
            USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
            pointVO.setAdmPointRegId(userVO.getUserId());
            ossPointService.insertUserPoint(pointVO);
            resultMap.put("success", "Y");
        }
        ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

        return modelAndView;
    }
}