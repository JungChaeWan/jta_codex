package mw.customer.web;

import api.service.APIService;
import api.vo.ApiNextezPrcAdd;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovWebUtil;
import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.AD_PRDTINFVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.sp.service.MasSpService;
import mas.sp.vo.SP_PRDTINFVO;
import mas.sv.service.MasSvService;
import mas.sv.vo.SV_PRDTINFVO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.env.service.OssSiteManageService;
import oss.otoinq.service.OssOtoinqService;
import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.*;
import oss.user.vo.USERVO;
import web.mypage.service.WebMypageService;
import web.mypage.service.WebUserCpService;
import web.order.service.WebOrderService;
import web.order.vo.RSVEPILVO;
import web.product.service.WebRcProductService;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class MwCoustomerController {
	 Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name="webMypageService")
	protected WebMypageService webMypageService;

	@Resource(name="ossOtoinqService")
	private OssOtoinqService ossOtoinqService;

	@Resource(name="ossUesepliService")
	private OssUesepliService ossUesepliService;

	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;

	@Resource(name = "masAdPrdtService")
	protected MasAdPrdtService masAdPrdtService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "masSpService")
	private MasSpService masSpService;

	@Resource(name = "masSvService")
	private MasSvService masSvService;

	@Resource(name = "webUserCpService")
	private WebUserCpService webUserCpService;

	@Resource(name = "webOrderService")
	private WebOrderService webOrderService;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name="apiService")
	private APIService apiService;

	@Resource(name="ossSiteManageService")
	private OssSiteManageService ossSiteManageService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@RequestMapping("/mw/coustomer/qaList.do")
	public String qaList(	ModelMap model) {
		USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (userVO != null && !userVO.equals("")) {
			model.addAttribute("email", userVO.getEmail());
			model.addAttribute("userId", userVO.getUserId());
			model.addAttribute("userNm", userVO.getUserNm());
			model.addAttribute("mobileNumber", userVO.getTelNum());
		}

		//상담 불가일 설정
		Date nowDate = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
		String strYYYYMMDD = simpleDateFormat.format(nowDate);
		Integer outDay = ossSiteManageService.channelTalkOutDayCnt(strYYYYMMDD);
		model.addAttribute("channelTalkOutDayCnt", outDay);

		return "mw/coustomer/qaList";
	}


	@RequestMapping("/mw/coustomer/cancelRule.do")
	public String cancelRule(	ModelMap model) {

		return "mw/coustomer/cancelRule";
	}

	@RequestMapping("/mw/coustomer/alliance.do")
	public String alliance(	ModelMap model) {

		return "mw/coustomer/alliance";
	}

	@RequestMapping("/mw/coustomer/useepilList.do")
	public String useepilList(	@ModelAttribute("searchVO") USEEPILSVO useepilSVO,
								ModelMap model) {

		//log.info("/web/coustomer/useepilList.do 호출");

		//로그인 정보 얻기
		USERVO userVO = null;
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/mw/restSign.do";
			} else 	{
				model.addAttribute("userInfo", userVO);
			}
    	}else{
    		model.addAttribute("userInfo", null);
    		//return "redirect:/web/viewLogin.do?rtnUrl=/web/mypage/useepilList.do";
    	}

    	//페이징 관련 설정
    	useepilSVO.setPageUnit(propertiesService.getInt("mwPageUnit"));
    	useepilSVO.setPageSize(propertiesService.getInt("mwPageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(useepilSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(useepilSVO.getPageUnit());
		paginationInfo.setPageSize(useepilSVO.getPageSize());

		useepilSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		useepilSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		useepilSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());


		//검색조건 조합
		//useepilSVO.setsUserId(userVO.getUserId());
		useepilSVO.setsPrintYn("Y");

		//상품평 얻기
		Map<String, Object> resultMap = ossUesepliService.selectUseepilListWeb(useepilSVO);
		@SuppressWarnings("unchecked")
		List<USEEPILVO> resultList = (List<USEEPILVO>) resultMap.get("resultList");

		//상품평 이미지 얻기
		List<USEEPILIMGVO> resultImgList = ossUesepliService.selectUseepilImgListWeb(useepilSVO);

		//상품평 댓글 얻기
		List<USEEPILCMTVO> resultCmtList = ossUesepliService.selectUseepCmtilListWeb(useepilSVO);

		//데이터 가공
		for(USEEPILVO data: resultList){
			//log.info("/web/cmm/useepilList.do 호출:"+data.getSubject());

			//내용
			data.setContentsOrg(data.getContents());
			data.setContents(EgovWebUtil.clearXSSMinimum(data.getContents()) );
			data.setContents( data.getContents().replaceAll("\n", "<br/>\n") );

			//아이디
			String strEmail = data.getEmail();
			if(strEmail.length() < 3){
				strEmail = "***";
			}else{
				strEmail = strEmail.substring(0,3)+"*****";
			}
			data.setEmail(strEmail);

			//앞에 표시될꺼 조합
			setUseepilSubjectHeder(data);


			//답글 조합
			List<USEEPILCMTVO> listCmt = new ArrayList<USEEPILCMTVO>();
			for(USEEPILCMTVO dataCmt: resultCmtList){
				if( "Y".equals(dataCmt.getPrintYn()) ){
					if( data.getUseEpilNum().equals(dataCmt.getUseEpilNum()) ){
						//log.info("/web/cmm/useepilList.do 호출:"+data.getUseEpilNum()+":"+dataCmt.getUseEpilNum()+":"+dataCmt.getContents());

						dataCmt.setContentsOrg(dataCmt.getContents());
						dataCmt.setContents(EgovWebUtil.clearXSSMinimum(dataCmt.getContents()) );
						dataCmt.setContents( dataCmt.getContents().replaceAll("\n", "<br/>\n") );
						listCmt.add(dataCmt);
					}
				}
			}
			data.setCmtList(listCmt);

			// 이미지 조합
			List<USEEPILIMGVO> listImg = new ArrayList<USEEPILIMGVO>();
			for (USEEPILIMGVO dataImg : resultImgList) {
				if (data.getUseEpilNum().equals(dataImg.getUseEpilNum())) {
					listImg.add(dataImg);
				}
			}
			data.setImgList(listImg);

		}


		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("useepilList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "mw/coustomer/useepilList";
	}


	@RequestMapping("/mw/coustomer/viewInsertUseepil.do")
	public String viewInsertUseepil(@ModelAttribute("USEEPILVO") USEEPILVO useepilVO
									,@ModelAttribute("searchVO") USEEPILSVO useepilSVO
									,ModelMap model) {
		//log.info("/web/coustomer/viewInsertUseepil.do 호출");

		//로그인 정보 얻기
		USERVO userVO = null;
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/mw/restSign.do";
			} else 	{
				model.addAttribute("userInfo", userVO);
			}
    	}else{
    		//model.addAttribute("userInfo", null);
    		return "redirect:/mw/viewLogin.do?rtnUrl=/mw/coustomer/useepilList.do";
    	}


    	//구매상품 정보 얻기...
    	RSVEPILVO reVO = new RSVEPILVO();
    	reVO.setUserId(userVO.getUserId());
    	List<RSVEPILVO> reList = webOrderService.selectRsvEpilList(reVO);
    	boolean bFind = false;
    	for (RSVEPILVO rsvepilvo : reList) {
    		rsvepilvo.setDpNm( setUseepilSubjectHeder(rsvepilvo.getPrdtNum(), rsvepilvo.getCorpNm(), rsvepilvo.getPrdtNm()) );

    		if(bFind == false){
	    		String strCoCd =  rsvepilvo.getPrdtNum().substring(0, 2);
	    		if(Constant.ACCOMMODATION.equals( strCoCd )){
	    			if(rsvepilvo.getCorpId().equals(useepilVO.getCorpId())){
	    				bFind = true;
	    				rsvepilvo.setSelectYn("Y");
	    			}
	    		}else{
	    			if(rsvepilvo.getCorpId().equals(useepilVO.getCorpId()) && rsvepilvo.getPrdtNum().equals(useepilVO.getPrdtnum())){
	    				bFind = true;
	    				rsvepilvo.setSelectYn("Y");
	    			}

	    		}
    		}
		}

    	model.addAttribute("rsvepilList", reList);
		return "mw/coustomer/insertUseepil";
	}

	@RequestMapping("/mw/coustomer/insertUseepil.do")
	public String insertUseepil(final MultipartHttpServletRequest multiRequest,
								@ModelAttribute("USEEPILVO") USEEPILVO useepilVO,
								ModelMap model) throws Exception {
		//log.info("/web/coustomer/insertUseepil.do 호출");

		//로그인 정보 얻기
		USERVO userVO = null;
    	//model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/mw/restSign.do";
			} else 	{
	    		useepilVO.setUserId(userVO.getUserId());
	    		useepilVO.setEmail(userVO.getEmail());
	    		useepilVO.setFrstRegIp(userVO.getLastLoginIp());
			}
    		//model.addAttribute("userInfo", userVO);
    	}else{
    		//model.addAttribute("userInfo", null);
    		return "redirect:/mw/viewLogin.do?rtnUrl=/mw/coustomer/useepilList.do";
    	}

		//log.info(">>>>>[" + useepilVO.getPrdtInf()
		//		  + "][" +   useepilVO.getGpa()
		//		  + "][" +   useepilVO.getSubject()
		//		  + "][" +   useepilVO.getContents() );


    	String[] aParam = useepilVO.getPrdtInf().split(",");
		String strCorpId 		= aParam[0];
		String strPrdtNum 		= aParam[1];
		String strPrdtRvsNum 	= aParam[2];
		//log.info(">>>>>["+strCorpId+"]["+strPrdtNum);
		useepilVO.setCorpId(strCorpId);
		useepilVO.setPrdtnum(strPrdtNum);


		CORPVO corpVO = new CORPVO();
   		corpVO.setCorpId(useepilVO.getCorpId());
   		CORPVO corpRes = ossCorpService.selectByCorp(corpVO);
   		useepilVO.setCorpNm(corpRes.getCorpNm());
   		//log.info("/web/cmm/useepilInsert.do 호출>>>>>1:"+ useepilVO.getCorpNm());


   		//제품명 검색
   		String strCoCd =  strPrdtNum.substring(0, 2);
		if(Constant.ACCOMMODATION.equals( strCoCd )){
			AD_PRDTINFVO adPrdt = new AD_PRDTINFVO();
    		adPrdt.setPrdtNum( useepilVO.getPrdtnum() );
    		AD_PRDTINFVO adPrdtRes = masAdPrdtService.selectByAdPrdinf(adPrdt);
    		useepilVO.setPrdtNm( adPrdtRes.getPrdtNm() );

		}else if(Constant.RENTCAR.equals( strCoCd )){
			RC_PRDTINFVO rcPrdt = new RC_PRDTINFVO();
			rcPrdt.setPrdtNum( useepilVO.getPrdtnum() );
			RC_PRDTINFVO rcPrdtRes = webRcProductService.selectByPrdt(rcPrdt);
    		useepilVO.setPrdtNm( rcPrdtRes.getPrdtNm() );

		}else if(Constant.SOCIAL.equals( strCoCd )){
			SP_PRDTINFVO spPrdt = new SP_PRDTINFVO();
			spPrdt.setPrdtNum( useepilVO.getPrdtnum() );
			SP_PRDTINFVO spPrdtRes = masSpService.selectBySpPrdtInf(spPrdt);
			useepilVO.setPrdtNm( spPrdtRes.getPrdtNm() );
		}else if(Constant.SV.equals( strCoCd )){
			SV_PRDTINFVO svPrdt = new SV_PRDTINFVO();
			svPrdt.setPrdtNum( useepilVO.getPrdtnum() );
			SV_PRDTINFVO svPrdtRes = masSvService.selectBySvPrdtInf(svPrdt);
			useepilVO.setPrdtNm( svPrdtRes.getPrdtNm() );
		}


		useepilVO = ossUesepliService.insertUseepil(useepilVO);

   		// 첨부이미지 등록
		String strSaveFilePath = EgovProperties.getProperty("USEEPIL.SAVEDFILE")+useepilVO.getUseEpilNum()+"/";
		ossFileUtilService.uploadUseepilImage(multiRequest, strSaveFilePath, useepilVO);

    	//평점 평균 및 후기 수 다시 계산
    	GPAANLSVO gpaVO = new GPAANLSVO();
    	if(Constant.ACCOMMODATION.equals( strCoCd )){
    		//숙소만 업체명 입력
        	gpaVO.setsCorpId(useepilVO.getCorpId());
        	gpaVO.setLinkNum(useepilVO.getCorpId());
    	}else{
    		gpaVO.setsPrdtNum(useepilVO.getPrdtnum());
        	gpaVO.setLinkNum(useepilVO.getPrdtnum());
    	}
    	ossUesepliService.mergeGpaanls(gpaVO);


    	//상품평 표시
    	RSVEPILVO epVO = new RSVEPILVO();
    	epVO.setPrdtCd(strCoCd);
    	epVO.setPrdtRsvNum(strPrdtRvsNum);
    	epVO.setUseepilRegYn("Y");
    	webOrderService.updateRsvEpil(epVO);

		// 쿠폰 발행
    	webUserCpService.uepiCpPublish(userVO.getUserId());

		/** 데이터제공 조회정보 수집*/
        ApiNextezPrcAdd apiNextezPrcAdd = new ApiNextezPrcAdd();
        apiNextezPrcAdd.setvConectDeviceNm("MOBILE");
        apiNextezPrcAdd.setvCtgr(strCoCd);
        if(Constant.ACCOMMODATION.equals( strCoCd )){
			apiNextezPrcAdd.setvPrdtNum(useepilVO.getCorpId());
		}else{
			apiNextezPrcAdd.setvPrdtNum(useepilVO.getPrdtnum());
		}
        apiNextezPrcAdd.setvType("point");
        apiNextezPrcAdd.setvVal1(useepilVO.getGpa());
		apiService.insertNexezData(apiNextezPrcAdd);

		return "redirect:/mw/coustomer/useepilList.do";
	}


	@RequestMapping("/mw/coustomer/viewUdateUseepil.do")
	public String viewUdateUseepil(@ModelAttribute("USEEPILVO") USEEPILVO useepilVO
									,@ModelAttribute("searchVO") USEEPILSVO useepilSVO
									,ModelMap model) {
		log.info("/web/coustomer/viewUdateUseepil.do 호출");

		//로그인 정보 얻기
		USERVO userVO = null;
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/mw/restSign.do";
			} else 	{
				model.addAttribute("userInfo", userVO);
			}
    	}else{
    		//model.addAttribute("userInfo", null);
    		return "redirect:/mw/viewLogin.do?rtnUrl=/mw/coustomer/useepilList.do";
    	}

    	//구매상품 정보 얻기...
    	USEEPILVO useepilRes = ossUesepliService.selectByUseepil(useepilVO);

    	if(!(userVO.getUserId().equals(useepilRes.getUserId()))){
    		//권한 없음
    		return "redirect:/mw/coustomer/useepilList.do";
    	}

    	//앞에 표시될꺼 조합
    	setUseepilSubjectHeder(useepilRes);

		//코드 정보 얻기
		List<CDVO> cdRvtp = ossCmmService.selectCode(useepilRes.getPrdtnum().substring(0,2) + "RV");
		model.addAttribute("cdRvtp", cdRvtp);


		//이미지 리스트
    	model.addAttribute("imgList", ossUesepliService.selectUseepilImgListDiv(useepilVO));

    	model.addAttribute("useepil", useepilRes);


		return "mw/coustomer/updateUseepil";
	}

	@RequestMapping("/mw/coustomer/udateUseepil.do")
	public String udateUseepil(final MultipartHttpServletRequest multiRequest
									,@ModelAttribute("USEEPILVO") USEEPILVO useepilVO
									,@ModelAttribute("searchVO") USEEPILSVO useepilSVO
									,ModelMap model) throws Exception {
		log.info("/web/coustomer/udateUseepil.do 호출");

		//로그인 정보 얻기
		USERVO userVO = null;
    	model.addAttribute("isLogin", EgovUserDetailsHelper.isAuthenticated()?"Y":"N");
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedUser();
    		if ("Y".equals(userVO.getRestYn())) {	// 휴면계정이면..
				return "redirect:/mw/restSign.do";
			} else 	{
				model.addAttribute("userInfo", userVO);
			}
    	}else{
    		//model.addAttribute("userInfo", null);
    		return "redirect:/mw/viewLogin.do?rtnUrl=/mw/coustomer/useepilList.do";
    	}


    	//구매상품 정보 얻기...
    	ossUesepliService.selectByUseepil(useepilVO);

    	//DB에 넣기
    	useepilVO.setLastModId(userVO.getUserId());
    	useepilVO.setLastModIp(userVO.getLastLoginIp());
    	ossUesepliService.updateUsespilByCont(useepilVO);

    	// 첨부이미지 등록
		String strSaveFilePath = EgovProperties.getProperty("USEEPIL.SAVEDFILE")+useepilVO.getUseEpilNum()+"/";
		ossFileUtilService.uploadUseepilImage(multiRequest, strSaveFilePath, useepilVO);


    	//평점 평균 및 후기 수 다시 계산
    	GPAANLSVO gpaVO = new GPAANLSVO();
    	String strCoCd =  useepilVO.getPrdtnum().substring(0, 2);
    	if(Constant.ACCOMMODATION.equals( strCoCd )){
    		//숙소만 업체명 입력
        	gpaVO.setsCorpId(useepilVO.getCorpId());
        	gpaVO.setLinkNum(useepilVO.getCorpId());
    	}else{
    		gpaVO.setsPrdtNum(useepilVO.getPrdtnum());
        	gpaVO.setLinkNum(useepilVO.getPrdtnum());
    	}
    	ossUesepliService.mergeGpaanls(gpaVO);


		return "redirect:/mw/coustomer/useepilList.do?pageIndex="+useepilSVO.getPageIndex();
	}


	/**
	 * 표시될꺼 조합
	 * 파일명 : setUseepilSubjectHeder
	 * 작성일 : 2015. 11. 24. 오후 12:27:08
	 * 작성자 : 신우섭
	 * @param useepil
	 */
	private void setUseepilSubjectHeder(USEEPILVO useepil){

		useepil.setSubjectHeder( setUseepilSubjectHeder(useepil.getPrdtnum(), useepil.getCorpNm(), useepil.getPrdtNm()) );

	}


	private String setUseepilSubjectHeder(String strPrdtnum, String strCorpNm, String strPrdtNm){
		String strRtn="";

		String strCoCd =  strPrdtnum.substring(0, 2);
		if(Constant.ACCOMMODATION.equals(strCoCd)){
			strRtn = strCorpNm + "-" + strPrdtNm;
		}else if(Constant.RENTCAR.equals(strCoCd)){
			strRtn = strCorpNm + "-" + strPrdtNm;
		}else if(Constant.SOCIAL.equals(strCoCd)){
			strRtn = strPrdtNm;
		}else if(Constant.SV.equals(strCoCd)){
			strRtn = strPrdtNm;
		}

		return strRtn;
	}

}
