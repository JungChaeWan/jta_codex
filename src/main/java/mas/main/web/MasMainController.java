package mas.main.web;


import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovClntInfo;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.AD_PRDTINFSVO;
import mas.adj.service.MasAdjService;
import mas.prmt.service.MasPrmtService;
import mas.prmt.vo.PRMTVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rsv.service.MasRsvService;
import mas.sp.service.MasSpService;
import mas.sp.vo.SP_PRDTINFSVO;
import mas.sv.service.MasSvService;
import mas.sv.vo.SV_PRDTINFSVO;
import org.apache.ibatis.annotations.Param;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.adj.vo.ADJSVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CM_DTLIMGVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.otoinq.service.OssOtoinqService;
import oss.otoinq.vo.OTOINQVO;
import oss.useepil.service.OssUesepliService;
import oss.useepil.vo.USEEPILVO;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;
import web.bbs.service.WebBbsService;
import web.bbs.vo.NOTICESVO;
import web.bbs.vo.NOTICEVO;
import web.order.vo.RSVSVO;
import web.order.vo.SP_RSVVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
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
public class MasMainController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
    
    @Resource(name="ossCorpService")
    private OssCorpService ossCorpService;
    
    @Resource(name="ossCmmService")
    private OssCmmService ossCmmService;
    
    @Resource(name="ossFileUtilService")
    private OssFileUtilService ossFileUtilService;
    
    @Resource(name="ossUserService")
	protected OssUserService ossUserService;
    
    @Resource(name="webBbsService")
    private WebBbsService webBbsService;
    
    @Resource(name="ossOtoinqService")
	private OssOtoinqService ossOtoinqService;
    
    @Resource(name="ossUesepliService")
	private OssUesepliService ossUesepliService;
    
    @Resource(name="masPrmtService")
	private MasPrmtService masPrmtService;
    
    @Resource(name="masRsvService")
	private MasRsvService masRsvService;
    
    @Resource(name="masAdjService")
    private MasAdjService masAdjService;

	@Resource(name="masAdPrdtService")
	private MasAdPrdtService masAdPrdtService;

	@Resource(name="masRcPrdtService")
	private MasRcPrdtService masRcPrdtService;

	@Resource(name = "masSpService")
	private MasSpService masSpService;

	@Resource(name = "masSvService")
	private MasSvService masSvService;


    Logger log = LogManager.getLogger(this.getClass());
    		
    @RequestMapping("/mas/head.do")
    public String ossHead(	@RequestParam Map<String, String> params,
    						ModelMap model){
    	// AD : 숙박, SP : 소셜상품, RC : 렌트카, GL : 골프
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	model.addAttribute("corpCd", corpInfo.getCorpCd());
    	model.addAttribute("topCorpNm", corpInfo.getCorpNm());
    	model.addAttribute("menuNm", params.get("menu"));
    	return "/mas/head";
    }
    
    @RequestMapping("/mas/home.do")
    public String home(ModelMap model){
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	
    	//**업체공지사항 *******************************************
    	NOTICESVO notiSVO = new NOTICESVO();
    	notiSVO.setsBbsNum("MASNOTI");
    	notiSVO.setLastIndex(4);
		List<NOTICEVO> manotiList = webBbsService.selectListMain(notiSVO);
		model.addAttribute("masnotiList", manotiList);
		
		
		//**업체QA *******************************************
    	//NOTICESVO notiSVO = new NOTICESVO();
		OTOINQVO otoinqVO2 = new OTOINQVO();
		otoinqVO2.setsCorpId(corpInfo.getCorpId());
		otoinqVO2.setFirstIndex(0);
		otoinqVO2.setLastIndex(4);
		model.addAttribute("masqaList",ossOtoinqService.selectOtoinqList(otoinqVO2).get("resultList"));

		String corpCd = corpInfo.getCorpCd();
		
		model.addAttribute("corpCd", corpCd.toLowerCase());
    	
		//1:1문의 숫자
		OTOINQVO otoinqVO = new OTOINQVO();
		otoinqVO.setCorpId(corpInfo.getCorpId());
		int otoinqCnt = ossOtoinqService.getCntOtoinqNotCmt(otoinqVO);
		model.addAttribute("otoinqCnt", otoinqCnt);
		
		//상품평 숫자
		USEEPILVO useepilVO = new USEEPILVO();
		useepilVO.setCorpId(corpInfo.getCorpId());
		int useepilCnt =ossUesepliService.getCntUseepiAll(useepilVO);
		model.addAttribute("useepilCnt", useepilCnt);
		
		
		RSVSVO rsvSVO;

		//취소요청건
		rsvSVO = new SP_RSVVO();
		rsvSVO.setsCorpId(corpInfo.getCorpId());
		rsvSVO.setsRsvStatusCd("RS10");
		int rsvCalCnt = masRsvService.getCntRsvMainCalPay(rsvSVO);
		model.addAttribute("rsvCalCnt", rsvCalCnt);

		// 수정요청건
		Map<String, Object> resultMap;
		Integer editCnt = 0;

		if(Constant.ACCOMMODATION.equals(corpCd)) {
			AD_PRDTINFSVO prdtinfsvo = new AD_PRDTINFSVO();
			prdtinfsvo.setsCorpId(corpInfo.getCorpId());
			prdtinfsvo.setsTradeStatus(Constant.TRADE_STATUS_EDIT);

			resultMap = masAdPrdtService.selectAdPrdinfList(prdtinfsvo);

			editCnt = (Integer) resultMap.get("totalCnt");
		} else if(Constant.RENTCAR.equals(corpCd)) {
			RC_PRDTINFSVO prdtinfsvo = new RC_PRDTINFSVO();
			prdtinfsvo.setsCorpId(corpInfo.getCorpId());
			prdtinfsvo.setsTradeStatus(Constant.TRADE_STATUS_EDIT);

			resultMap = masRcPrdtService.selectRcPrdtList(prdtinfsvo);

			editCnt = (Integer) resultMap.get("totalCnt");
		} else if(Constant.SOCIAL.equals(corpCd)) {
			SP_PRDTINFSVO prdtinfsvo = new SP_PRDTINFSVO();
			prdtinfsvo.setsCorpId(corpInfo.getCorpId());
			prdtinfsvo.setsTradeStatus(Constant.TRADE_STATUS_EDIT);

			resultMap = masSpService.selectSpPrdtInfList(prdtinfsvo);

			editCnt = (Integer) resultMap.get("totalCnt");
		} else if(Constant.SV.equals(corpCd)) {
			SV_PRDTINFSVO prdtinfsvo = new SV_PRDTINFSVO();
			prdtinfsvo.setsCorpId(corpInfo.getCorpId());
			prdtinfsvo.setsTradeStatus(Constant.TRADE_STATUS_EDIT);

			resultMap = masSvService.selectPrdtList(prdtinfsvo);

			editCnt = (Integer) resultMap.get("totalCnt");
		}
		model.addAttribute("editCnt", editCnt);
		
		//이벤트 숫자
		rsvSVO = new SP_RSVVO();
		rsvSVO.setsCorpId(corpInfo.getCorpId());
		int rsvTodyaCnt = masRsvService.getCntRsvMainToday(rsvSVO);
		model.addAttribute("rsvTodyaCnt", rsvTodyaCnt);
		
		
		//이벤트 숫자
		PRMTVO prmtVO = new PRMTVO();
		prmtVO.setCorpId(corpInfo.getCorpId());
		int prmtCnt = masPrmtService.getCntPrmtMain(prmtVO);
		model.addAttribute("prmtCnt", prmtCnt);
		
		
		/*//총 누적판매수량(취소건 포함)
		rsvSVO = new SP_RSVVO();
		rsvSVO.setsCorpId(corpInfo.getCorpId());
		int rsvTotal = masRsvService.getCntRsvMainTotPay(rsvSVO);
		model.addAttribute("rsvTotal", rsvTotal);
		
		//총 판매금액
		rsvSVO = new SP_RSVVO();
		rsvSVO.setsCorpId(corpInfo.getCorpId());
		long amtTotal = masRsvService.getAmtRsvMainTot(rsvSVO);
		model.addAttribute("amtTotal", amtTotal);
		
		//총 취소수량
		rsvSVO = new SP_RSVVO();
		rsvSVO.setsCorpId(corpInfo.getCorpId());
		rsvSVO.setsRsvStatusCd("RS20");
		int rsvTotCalCnt = masRsvService.getCntRsvMainCalPay(rsvSVO);
		model.addAttribute("rsvTotCalCnt", rsvTotCalCnt);
		
		//총 환불금액 
		rsvSVO = new SP_RSVVO();
		rsvSVO.setsCorpId(corpInfo.getCorpId());
		long amtTotCal = masRsvService.getAmtRsvMainTotCal(rsvSVO);
		model.addAttribute("amtTotCal", amtTotCal);
		
		// 총 정산금액		
		ADJSVO adjSVO = new ADJSVO();
		adjSVO.setsCorpId(corpInfo.getCorpId());
		int adjTotal = masAdjService.selectCorpAdjTotal(adjSVO);
		model.addAttribute("adjTotal", adjTotal);*/
    	
    	return "mas/home";
    }
    
    /**********************************************
     * 공통 이미지 관리
     **********************************************/
    /**
     * 이미지 관리 리스트
     * 파일명 : imgList
     * 작성일 : 2015. 10. 7. 오후 8:50:47
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param imgVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/cmm/imgList.do")
    public String imgList(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
				    		@ModelAttribute("CM_IMGVO") CM_IMGVO imgVO,
				    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	model.addAttribute("corpCd", corpInfo.getCorpCd().toLowerCase());
    	
    	List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
    	model.addAttribute("resultList", imgList);
    	return "/mas/cmm/imgList";
    }
    
    /**
     * 이미지 순번 변경
     * 파일명 : updatePrdtImg
     * 작성일 : 2015. 10. 7. 오후 8:50:57
     * 작성자 : 최영철
     * @param imgVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/cmm/updatePrdtImg.do")
    public String updatePrdtImg(	@ModelAttribute("CM_IMGVO") CM_IMGVO imgVO,
									ModelMap model) throws Exception{
    	log.info("/mas/cmm/updatePrdtImg.do 호출");
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		ossCmmService.updateImgSn(imgVO);
		return "redirect:/mas/" + corpInfo.getCorpCd().toLowerCase() + "/imgList.do?prdtNum=" + imgVO.getLinkNum();
    }
    
    /**
     * 이미지 삭제
     * 파일명 : deletePrdtImg
     * 작성일 : 2015. 10. 7. 오후 9:02:25
     * 작성자 : 최영철
     * @param imgVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/cmm/deletePrdtImg.do")
    public String deletePrdtImg(	@ModelAttribute("CM_IMGVO") CM_IMGVO imgVO,
									ModelMap model) throws Exception{
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	ossCmmService.deletePrdtImg(imgVO);
		
    	return "redirect:/mas/" + corpInfo.getCorpCd().toLowerCase() + "/imgList.do?prdtNum=" + imgVO.getLinkNum() + "&pageIndex=" + imgVO.getPageIndex();
    }
    
    /**
     * 상품 이미지 등록
     * 파일명 : inserPrdtImg
     * 작성일 : 2015. 10. 8. 오후 12:02:28
     * 작성자 : 최영철
     * @param imgVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/cmm/insertPrdtImg.do")
    public String inserPrdtImg(@ModelAttribute("CM_IMGVO") CM_IMGVO imgVO,
    							@Param("fileList") String fileList,
    							ModelMap model) throws Exception{
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	// 이미지 파일 validate 체크
		//Map<String, Object> imgValidateMap = ossFileUtilService.validateImgFile(fileList);
		
		/*if(!(Boolean) imgValidateMap.get("validateChk")){
			log.info("이미지 파일 에러");
			model.addAttribute("fileError", imgValidateMap.get("message"));
			List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
	    	model.addAttribute("resultList", imgList);
	    	return "/mas/" + corpInfo.getCorpCd().toLowerCase() + "/imgList";
		}*/
		ossCmmService.insertPrdtimg(imgVO, fileList);
		return "redirect:/mas/" + corpInfo.getCorpCd().toLowerCase() + "/imgList.do?prdtNum=" + imgVO.getLinkNum();
    }
    
    /**
     * 이미지 관리 리스트 detail
     * 파일명 : imgList
     * 작성일 : 2015. 10. 7. 오후 8:50:47
     * 작성자 : 최영철
     * @param prdtInfSVO
     * @param imgVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/cmm/detailImgList.do")
    public String detailImgList(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
				    		@ModelAttribute("CM_IMGVO") CM_IMGVO imgVO,
				    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	model.addAttribute("corpCd", corpInfo.getCorpCd().toLowerCase());
    	
    	List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
    	model.addAttribute("resultList", imgList);
    	return "/mas/cmm/detailImgList";
    }
    
    
    
    @RequestMapping("/mas/intro.do")
    public String intro(){
    	return "/mas/intro";
    }
    
    @RequestMapping("/mas/actionMasLogin.do")
    public String actionMasLogin(	@ModelAttribute("loginVO") USERVO loginVO, 
						            HttpServletRequest request,
						            ModelMap model) throws Exception{
    	if(EgovStringUtil.isEmpty(loginVO.getCorpId())){
    		model.addAttribute("failLogin","1");
    		return "/mas/intro";
    	}
    	if(EgovStringUtil.isEmpty(loginVO.getPwd())){
    		model.addAttribute("failLogin","2");
    		return "/mas/intro";
    	}
    	// 접속 IP
    	String userIp = EgovClntInfo.getClntIP(request);
    	loginVO.setLastLoginIp(userIp);
    	// 1. 관리자 로그인 처리
    	USERVO resultVO = ossUserService.actionMasLogin(loginVO);
    	
    	if (resultVO != null && resultVO.getUserId() != null && !resultVO.getUserId().equals("")) {
        	resultVO.setLastLoginIp(userIp);
        	request.getSession().setAttribute("masLoginVO", resultVO);
        	request.getSession().setAttribute("userVO", resultVO);
        	
        	return "redirect:/mas/home.do";
    	}else{
    		model.addAttribute("failLogin","Y");
    		model.addAttribute("email",loginVO.getEmail());
    		return "/mas/intro";
    	}
    }
    
    /**
     * 협회 관리자 로그아웃
     * 파일명 : ossLogout
     * 작성일 : 2015. 10. 15. 오후 1:48:26
     * 작성자 : 최영철
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mas/masLogout.do")
	public String masLogout(HttpServletRequest request, ModelMap model){
		
		request.getSession().setAttribute("masLoginVO", null);
		request.getSession().setAttribute("userVO", null);
		
		return "mas/intro";
	}
    
    
    
    /**
     * 상세 이미지 목록
     * 파일명 : dtlImgList
     * 작성일 : 2015. 10. 20. 오후 5:43:19
     * 작성자 : 신우섭
     * @param prdtInfSVO
     * @param imgVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/cmm/dtlImgList.do")
    public String dtlImgList(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
				    		@ModelAttribute("CM_DTLIMGVO") CM_DTLIMGVO imgVO,
				    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	model.addAttribute("corpCd", corpInfo.getCorpCd().toLowerCase());
    	
    	
    	List<CM_DTLIMGVO> imgList = ossCmmService.selectDtlImgList(imgVO);
    	
    	List<CM_DTLIMGVO> imgListPC = new ArrayList<CM_DTLIMGVO>();
    	List<CM_DTLIMGVO> imgListM  = new ArrayList<CM_DTLIMGVO>();
    	
    	for(Object object :imgList){
    		CM_DTLIMGVO data = (CM_DTLIMGVO)object;
    		if("Y".equals( data.getPcImgYn() ) ){
    			imgListPC.add(data);
    		}else{
    			imgListM.add(data);
    		}
    	}
    	
    	model.addAttribute("imgListPC", imgListPC);
    	model.addAttribute("imgListM", imgListM);
    	
    	//model.addAttribute("resultList", imgList);
    	return "/mas/cmm/dtlImgList";
    }
    
    
    /**
     * 상세 이미지 등록
     * 파일명 : inserPrdtDtlImg
     * 작성일 : 2015. 10. 20. 오후 5:43:30
     * 작성자 : 신우섭
     * @param multiRequest
     * @param imgVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/cmm/insertPrdtDtlImg.do")
    public String inserPrdtDtlImg(	final MultipartHttpServletRequest multiRequest,
    							@ModelAttribute("CM_DTLIMGVO") CM_DTLIMGVO imgVO,
    							ModelMap model) throws Exception{
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	// 이미지 파일 validate 체크
		Map<String, Object> imgValidateMap = ossFileUtilService.validateImgFile(multiRequest);
		
		if(!(Boolean) imgValidateMap.get("validateChk")){
			log.info("이미지 파일 에러");

			if("Y".equals( imgVO.getPcImgYn() ) ){
				model.addAttribute("fileErrorPC", imgValidateMap.get("message"));
			}else{
				model.addAttribute("fileErrorM", imgValidateMap.get("message"));
			}
			
			List<CM_DTLIMGVO> imgList = ossCmmService.selectDtlImgList(imgVO);
	    	
	    	List<CM_DTLIMGVO> imgListPC = new ArrayList<CM_DTLIMGVO>();
	    	List<CM_DTLIMGVO> imgListM  = new ArrayList<CM_DTLIMGVO>();
	    	
	    	for(Object object :imgList){
	    		CM_DTLIMGVO data = (CM_DTLIMGVO)object;
	    		if("Y".equals( data.getPcImgYn() ) ){
	    			imgListPC.add(data);
	    		}else{
	    			imgListM.add(data);
	    		}
	    	}
	    	
	    	model.addAttribute("imgListPC", imgListPC);
	    	model.addAttribute("imgListM", imgListM);
			
	    	return "/mas/" + corpInfo.getCorpCd().toLowerCase() + "/dtlImgList";
		}
		
		ossCmmService.insertPrdtDtlimg(imgVO, multiRequest);
		return "redirect:/mas/" + corpInfo.getCorpCd().toLowerCase() + "/dtlImgList.do?prdtNum=" + imgVO.getLinkNum() + "&pageIndex=" + imgVO.getPageIndex();
    }
    
    
    /**
     * 상세이미지 순번 변경
     * 파일명 : updatePrdtDtlImg
     * 작성일 : 2015. 10. 21. 오전 9:23:44
     * 작성자 : 신우섭
     * @param imgVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/cmm/updatePrdtDtlImg.do")
    public String updatePrdtDtlImg(	@ModelAttribute("CM_DTLIMGVO") CM_DTLIMGVO imgVO,
									ModelMap model) throws Exception{
    	//log.info("/mas/cmm/updatePrdtDtlImg.do 호출");
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		ossCmmService.updateDtlImgSn(imgVO);
		return "redirect:/mas/" + corpInfo.getCorpCd().toLowerCase() + "/dtlImgList.do?prdtNum=" + imgVO.getLinkNum() + "&pageIndex=" + imgVO.getPageIndex();
    }
    
    /**
     * 상세이미지 파일 삭제
     * 파일명 : deletePrdtDtlImg
     * 작성일 : 2015. 10. 21. 오전 9:24:04
     * 작성자 : 신우섭
     * @param imgVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/cmm/deletePrdtDtlImg.do")
    public String deletePrdtDtlImg(	@ModelAttribute("CM_DTLIMGVO") CM_DTLIMGVO imgVO,
									ModelMap model) throws Exception{
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	ossCmmService.deletePrdtDtlImg(imgVO);
		
    	return "redirect:/mas/" + corpInfo.getCorpCd().toLowerCase() + "/dtlImgList.do?prdtNum=" + imgVO.getLinkNum() + "&pageIndex=" + imgVO.getPageIndex() ;
    }
    

    /**
     * 상세 이미지 목록 detail
     * 파일명 : dtlImgList
     * 작성일 : 2015. 10. 20. 오후 5:43:19
     * 작성자 : 신우섭
     * @param prdtInfSVO
     * @param imgVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/cmm/detailDtlImgList.do")
    public String detailDtlImgList(	@ModelAttribute("searchVO") RC_PRDTINFSVO prdtInfSVO,
				    		@ModelAttribute("CM_DTLIMGVO") CM_DTLIMGVO imgVO,
				    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	model.addAttribute("corpCd", corpInfo.getCorpCd().toLowerCase());
    	
    	
    	List<CM_DTLIMGVO> imgList = ossCmmService.selectDtlImgList(imgVO);
    	
    	List<CM_DTLIMGVO> imgListPC = new ArrayList<CM_DTLIMGVO>();
    	List<CM_DTLIMGVO> imgListM  = new ArrayList<CM_DTLIMGVO>();
    	
    	for(Object object :imgList){
    		CM_DTLIMGVO data = (CM_DTLIMGVO)object;
    		if("Y".equals( data.getPcImgYn() ) ){
    			imgListPC.add(data);
    		}else{
    			imgListM.add(data);
    		}
    	}
    	
    	model.addAttribute("imgListPC", imgListPC);
    	model.addAttribute("imgListM", imgListM);
    	
    	return "/mas/cmm/detailDtlImgList";
    }
}
