package mas.ad.web;


import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.*;
import mas.sp.service.MasSpService;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.ad.vo.AD_WEBDTLSVO;
import oss.ad.vo.AD_WEBDTLVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.cmm.vo.CM_CONFHISTVO;
import oss.cmm.vo.CM_ICONINFVO;
import oss.cmm.vo.CM_IMGVO;
import oss.corp.service.OssCorpService;
import oss.corp.service.impl.CorpDAO;
import oss.corp.vo.CORPVO;
import oss.prdt.service.OssPrdtService;
import oss.user.vo.USERVO;
import web.order.vo.RSVSVO;
import web.product.service.WebAdProductService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 최영철
 * @since  2015. 9. 16.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------    	--------    ---------------------------
 *  2017.06.16	정동수		연박 요금 관리 추가
 */

@Controller
public class MasAdPrdtController {

    @Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

    @Resource(name="ossCorpService")
    private OssCorpService ossCorpService;

    @Resource(name="ossCmmService")
    private OssCmmService ossCmmService;

    @Resource(name="masAdPrdtService")
    private MasAdPrdtService masAdPrdtService;

    @Resource(name="ossFileUtilService")
    private OssFileUtilService ossFileUtilService;

    @Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

    @Resource(name = "corpDAO")
	private CorpDAO corpDAO;

    @Resource(name = "masSpService")
	private MasSpService masSpService;

    @Resource(name = "ossPrdtService")
    private OssPrdtService ossPrdtService;

    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;



    Logger log = (Logger) LogManager.getLogger(this.getClass());


    /**
     * 숙소기본정보 얻기
     * 파일명 : adInfo
     * 작성일 : 2015. 10. 8. 오후 2:13:59
     * 작성자 : 신우섭
     * @param ad_DFTINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/adInfo.do")
    public String adInfo(@ModelAttribute("AD_DFTINFVO") AD_DFTINFVO ad_DFTINFVO,
						 ModelMap model){
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	ad_DFTINFVO.setCorpId(corpInfo.getCorpId());

    	//코드 정보 얻기
    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");

    	String strInsert;
    	//기본 정보 얻기
    	AD_DFTINFVO adDftInf = masAdPrdtService.selectByAdDftinf(ad_DFTINFVO);

    	if(adDftInf == null) {
    		//log.info("adInfo 호출>>없음");
    		adDftInf = new AD_DFTINFVO();
    		adDftInf.setCorpId(corpInfo.getCorpId());

    		strInsert = "Y";
    	} else {
    		//지역
    		for(int i=0; i<cdAdar.size(); i++) {
   	    		CDVO data = cdAdar.get(i);

   	    		if(data.getCdNum().equals(adDftInf.getAdArea())) {
   	    			adDftInf.setAdAreaNm(data.getCdNm());
   	    		}
    		}
    		//구분
    		for(int i=0; i<cdAddv.size(); i++) {
   	    		CDVO data = cdAddv.get(i);

   	    		if(data.getCdNum().equals(adDftInf.getAdDiv())){
   	    			adDftInf.setAdDivNm(data.getCdNm());
   	    		}
    		}
    		// 주요정보 체크 리스트
        	List<CM_ICONINFVO> iconCdList = ossCmmService.selectCmIconinf(adDftInf.getCorpId(), Constant.ICON_CD_ADAT);

        	model.addAttribute("iconCdList", iconCdList);

    		strInsert = "N";
    	}

    	//adDftInf.setAdInf(EgovWebUtil.clearXSSMinimum(adDftInf.getAdInf()) );
    	//adDftInf.setAdInf( adDftInf.getAdInf().replaceAll("\n", "<br/>\n") );
    	adDftInf.setAdInf(EgovStringUtil.checkHtmlView(adDftInf.getAdInf()) );

    	//adDftInf.setTip(EgovWebUtil.clearXSSMinimum(adDftInf.getTip()) );
    	//adDftInf.setTip( adDftInf.getTip().replaceAll("\n", "<br/>\n") );
    	adDftInf.setTip(EgovStringUtil.checkHtmlView(adDftInf.getTip()) );

    	//adDftInf.setInfIntrolod(EgovWebUtil.clearXSSMinimum(adDftInf.getInfIntrolod()) );
    	//adDftInf.setInfIntrolod( adDftInf.getInfIntrolod().replaceAll("\n", "<br/>\n") );
    	adDftInf.setInfIntrolod(EgovStringUtil.checkHtmlView(adDftInf.getInfIntrolod()) );

    	//adDftInf.setInfEquif(EgovWebUtil.clearXSSMinimum(adDftInf.getInfEquif()) );
    	//adDftInf.setInfEquif( adDftInf.getInfEquif().replaceAll("\n", "<br/>\n") );
    	adDftInf.setInfEquif(EgovStringUtil.checkHtmlView(adDftInf.getInfEquif()) );

    	//adDftInf.setInfOpergud(EgovWebUtil.clearXSSMinimum(adDftInf.getInfOpergud()) );
    	//adDftInf.setInfOpergud( adDftInf.getInfOpergud().replaceAll("\n", "<br/>\n") );
    	adDftInf.setInfOpergud(EgovStringUtil.checkHtmlView(adDftInf.getInfOpergud()) );

    	//adDftInf.setInfNti(EgovWebUtil.clearXSSMinimum(adDftInf.getInfNti()) );
    	//adDftInf.setInfNti( adDftInf.getInfNti().replaceAll("\n", "<br/>\n") );
    	adDftInf.setInfNti(EgovStringUtil.checkHtmlView(adDftInf.getInfNti()) );

    	//adDftInf.setCancelGuide(EgovWebUtil.clearXSSMinimum(adDftInf.getCancelGuide()) );
    	//adDftInf.setCancelGuide( adDftInf.getCancelGuide().replaceAll("\n", "<br/>\n") );

    	model.addAttribute("adDftInf", adDftInf);
    	model.addAttribute("TypeInsYN", strInsert);
    	
    	/*인원추가 요금을 등록했는지 확인*/
    	/*AD_ADDAMTSVO ad_ADDAMTSVO = new AD_ADDAMTSVO();
    	ad_ADDAMTSVO.setsCorpId(ad_DFTINFVO.getCorpId());

    	Map<String, Object> resultMap = masAdPrdtService.selectAdAddamtList(ad_ADDAMTSVO);

		String adAddamtYn;

    	if((Integer) resultMap.get("totalCnt") > 0) {
    		adAddamtYn = "Y";
    	} else {
    		adAddamtYn = "N";
    	}
    	model.addAttribute("adAddamtYn", adAddamtYn);*/

    	return "mas/ad/adInfo";
    }

    /**
     * 숙소기본정보 추가 뷰
     * 파일명 : viewInsertAdInfo
     * 작성일 : 2015. 10. 8. 오후 2:14:03
     * 작성자 : 신우섭
     * @param ad_DFTINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/viewInsertAdInfo.do")
	public String viewInsertAdInfo(@ModelAttribute("AD_DFTINFVO") AD_DFTINFVO ad_DFTINFVO,
									ModelMap model)
	{
		//log.info("/mas/ad/viewInsertBbsGrp.do 호출");

		//코드 정보 얻기
    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
    	model.addAttribute("cdAdar", cdAdar);
    	model.addAttribute("cdAddv", cdAddv);

		System.out.println(ad_DFTINFVO.getCorpId());

		//숙소 연동 확인 2021.07.02 chaewan.jung
		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(ad_DFTINFVO.getCorpId());
		CORPVO corpInfo = ossCorpService.selectByCorp(corpVO);

    	// 주요정보
    	List<CDVO> cdList = ossCmmService.selectCode(Constant.ICON_CD_ADAT);
    	model.addAttribute("iconCd", cdList);
		model.addAttribute("adDftInf", ad_DFTINFVO);
		model.addAttribute("corpInfo", corpInfo);
		return "mas/ad/insertAdInfo";
	}


    /**
     * 숙소기본정보 추가
     * 파일명 : insertAdInfo
     * 작성일 : 2015. 10. 8. 오후 2:14:28
     * 작성자 : 신우섭
     * @param ad_DFTINFVO
     * @param bindingResult
     * @param ad_DFTINFSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/insertAdInfo.do")
	public String insertAdInfo(@ModelAttribute("AD_DFTINFVO") AD_DFTINFVO ad_DFTINFVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") AD_DFTINFSVO ad_DFTINFSVO,
					    		ModelMap model)
	{
		//log.info("/mas/ad/insertAdInfo 호출");

		// validation 체크
		beanValidator.validate(ad_DFTINFVO, bindingResult);
		if (bindingResult.hasErrors()){
			log.info("error");

			//코드 정보 얻기
	    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
	    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
	    	model.addAttribute("cdAdar", cdAdar);
	    	model.addAttribute("cdAddv", cdAddv);

			model.addAttribute("adDftInf",ad_DFTINFVO);
			log.info(bindingResult.toString());
			return "mas/ad/insertAdInfo";
		}


		AD_DFTINFVO adDftInf = masAdPrdtService.selectByAdDftinf(ad_DFTINFVO);
		if(adDftInf != null){
			bindingResult.rejectValue("adNm", "errors.exist", new Object[]{"업체아이디로 숙소 정보가"},"");

			List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
	    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
	    	model.addAttribute("cdAdar", cdAdar);
	    	model.addAttribute("cdAddv", cdAddv);

			model.addAttribute("adDftInf",ad_DFTINFVO);
			return "mas/ad/insertAdInfo";
		}

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		ad_DFTINFVO.setFrstRegId(corpInfo.getUserId());
		ad_DFTINFVO.setLastModId(corpInfo.getUserId());
		ad_DFTINFVO.setAdultAgeStdApicode("ADULTA"); //성인 매핑 타입코드 :   현재 TL린칸 밖에 없어서 성인 AType으로 고정. 2021.07.02 chaewan.jung
		masAdPrdtService.insertAdDftinf(ad_DFTINFVO);

		return "redirect:/mas/ad/adInfo.do";
	}



    /**
     * 숙소기본정보 수정 뷰
     * 파일명 : viewUpdateAdInfo
     * 작성일 : 2015. 10. 8. 오후 2:14:54
     * 작성자 : 신우섭
     * @param ad_DFTINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/viewUpdateAdInfo.do")
    public String viewUpdateAdInfo(@ModelAttribute("AD_DFTINFVO") AD_DFTINFVO ad_DFTINFVO,
    								ModelMap model){
    	//log.info("/mas/ad/viewUpdateAdInfo.do 호출:"+ ad_DFTINFVO.getCorpId() );
    	USERVO userVO = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	//코드 정보 얻기
    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
    	model.addAttribute("cdAdar", cdAdar);
    	model.addAttribute("cdAddv", cdAddv);

    	//기본 정보 얻기
    	AD_DFTINFVO adDftInf = masAdPrdtService.selectByAdDftinf(ad_DFTINFVO);

    	model.addAttribute("adDftInf", adDftInf);

    	//승인된 수 얻기
    	AD_PRDTINFSVO ad_PRDINFSVO = new AD_PRDTINFSVO();
   		ad_PRDINFSVO.setsCorpId(adDftInf.getCorpId());
   		ad_PRDINFSVO.setsTradeStatus(Constant.TRADE_STATUS_APPR);
   		int nTotCnt = masAdPrdtService.getCntAdPrdinf(ad_PRDINFSVO);
   		model.addAttribute("prdtCnt", nTotCnt);

		//숙소 연동 확인 2021.07.09 chaewan.jung
		CORPVO corpVO = new CORPVO();
		corpVO.setCorpId(ad_DFTINFVO.getCorpId());
		CORPVO corpInfo = ossCorpService.selectByCorp(corpVO);

		// 주요정보 체크 리스트
    	List<CM_ICONINFVO> iconCdList = ossCmmService.selectCmIconinf(adDftInf.getCorpId(), Constant.ICON_CD_ADAT);
    	System.out.println(userVO.getAuthNm());
    	model.addAttribute("iconCdList", iconCdList);
		model.addAttribute("authNm", userVO.getAuthNm());
		model.addAttribute("corpInfo", corpInfo);
    	return "mas/ad/updateAdInfo";
    }


    /**
     * 숙소기본정보 수정
     * 파일명 : updateAdInfo
     * 작성일 : 2015. 10. 8. 오후 2:15:04
     * 작성자 : 신우섭
     * @param ad_DFTINFVO
     * @param bindingResult
     * @param ad_DFTINFSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/updateAdInfo.do")
	public String updateAdInfo(@ModelAttribute("AD_DFTINFVO") AD_DFTINFVO ad_DFTINFVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") AD_DFTINFSVO ad_DFTINFSVO,
					    		ModelMap model)
	{
		//log.info("/mas/ad/updateAdInfo.do 호출");

		// validation 체크
		beanValidator.validate(ad_DFTINFVO, bindingResult);
		if (bindingResult.hasErrors()){
			log.info("error");

			//코드 정보 얻기
	    	List<CDVO> cdAdar = ossCmmService.selectCode("ADAR");
	    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
	    	model.addAttribute("cdAdar", cdAdar);
	    	model.addAttribute("cdAddv", cdAddv);

	    	// 주요정보
	    	List<CDVO> cdList = ossCmmService.selectCode(Constant.ICON_CD_ADAT);
	    	model.addAttribute("iconCd", cdList);

			model.addAttribute("adDftInf",ad_DFTINFVO);
			log.info(bindingResult.toString());
			return "/mas/ad/updateAdInfo";
		}

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		ad_DFTINFVO.setLastModId(corpInfo.getUserId());
		masAdPrdtService.updateAdDftinf(ad_DFTINFVO);


		return "redirect:/mas/ad/adInfo.do";
	}


    /**
     * 숙소 추가요금 목록
     * 파일명 : adAddamtList
     * 작성일 : 2015. 10. 8. 오후 2:15:14
     * 작성자 : 신우섭
     * @param ad_ADDAMTSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/adAddamtList.do")
	public String adAddamtList(@ModelAttribute("searchVO") AD_ADDAMTSVO ad_ADDAMTSVO,
							ModelMap model){
		//log.info("/mas/ad/adAddamtList 호출");
		//log.info("/oss/bbsList.do 호출:" + bbsSVO.getsKey() + ":" + bbsSVO.getsKeyOpt() );

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		ad_ADDAMTSVO.setsCorpId(corpInfo.getCorpId());

		String strErrorCode = "0";
		AD_DFTINFVO ad_DFTINFVO = new AD_DFTINFVO();
		ad_DFTINFVO.setCorpId(corpInfo.getCorpId());
		AD_DFTINFVO adDftinf = masAdPrdtService.selectByAdDftinf(ad_DFTINFVO);
    	if(adDftinf == null){
    		strErrorCode = "1";
    	}


		ad_ADDAMTSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		ad_ADDAMTSVO.setPageSize(propertiesService.getInt("pageSize"));


		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(ad_ADDAMTSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(ad_ADDAMTSVO.getPageUnit());
		paginationInfo.setPageSize(ad_ADDAMTSVO.getPageSize());

		ad_ADDAMTSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		ad_ADDAMTSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		ad_ADDAMTSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());



		Map<String, Object> resultMap = masAdPrdtService.selectAdAddamtList(ad_ADDAMTSVO);


		@SuppressWarnings("unchecked")
		List<AD_ADDAMTVO> resultList = (List<AD_ADDAMTVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

    	model.addAttribute("corpId", corpInfo.getCorpId());
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("errorCode", strErrorCode);



		AD_BREAKFASTAMTVO ad_breakfastamtVO = masAdPrdtService.selectByAdBreakfastAmt(corpInfo.getCorpId());
		model.addAttribute("breakfastamt", ad_breakfastamtVO);


		return "/mas/ad/adAddamtList";
	}


    /**
     * 숙소 추가요금 추가 뷰
     * 파일명 : viewInsertAdAddamt
     * 작성일 : 2015. 10. 8. 오후 2:15:27
     * 작성자 : 신우섭
     * @param ad_ADDAMTVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/viewInsertAdAddamt.do")
   	public String viewInsertAdAddamt(@ModelAttribute("AD_ADDAMTVO") AD_ADDAMTVO ad_ADDAMTVO,
   									ModelMap model)
   	{
   		//log.info("/mas/ad/viewInsertAdAddamt.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_ADDAMTVO.setCorpId(corpInfo.getCorpId());

   		model.addAttribute("adAddamt", ad_ADDAMTVO);

   		Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	model.addAttribute("today", sdf.format(now) );

   		return "mas/ad/insertAdAddamt";
   	}

    /**
     * 숙소 추가요금 추가
     * 파일명 : insertAdAddamt
     * 작성일 : 2015. 10. 8. 오후 2:15:36
     * 작성자 : 신우섭
     * @param ad_ADDAMTVO
     * @param bindingResult
     * @param ad_ADDAMTSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/insertAdAddamt.do")
   	public String insertAdAddamt(@ModelAttribute("AD_ADDAMTVO") AD_ADDAMTVO ad_ADDAMTVO,
   								BindingResult bindingResult,
   								@ModelAttribute("searchVO") AD_ADDAMTSVO ad_ADDAMTSVO,
   					    		ModelMap model)
   	{
   		//log.info("/mas/ad/insertAdAddamt 호출");

   		// validation 체크
   		beanValidator.validate(ad_ADDAMTVO, bindingResult);
   		if (bindingResult.hasErrors()){
   			log.info("error");

   			model.addAttribute("adAddamt",ad_ADDAMTVO);
   			log.info(bindingResult.toString());
   			return "mas/ad/insertAdAddamt";
   		}

   		AD_ADDAMTVO adAddamt = masAdPrdtService.selectByAdAddamt(ad_ADDAMTVO);
   		if(adAddamt != null){
   			model.addAttribute("errmsg", "이미 같은 적용 시작 일자가 있습니다.");
   			model.addAttribute("adAddamt", ad_ADDAMTVO);
   			return "mas/ad/insertAdAddamt";
   		}


   		//log.info("/mas/ad/insertAdAddamt 호출:" + ad_ADDAMTVO.getCorpId() + ":" + ad_ADDAMTVO.getAplStartDt() + ":" + ad_ADDAMTVO.getAdultAddAmt() );

   		masAdPrdtService.insertAdAddamt(ad_ADDAMTVO);

   		return "redirect:/mas/ad/adAddamtList.do";
   	}


    /**
     * 숙소 추가요금 수정 뷰
     * 파일명 : viewUpdateAdAddamt
     * 작성일 : 2015. 10. 8. 오후 2:15:44
     * 작성자 : 신우섭
     * @param ad_ADDAMTVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/viewUpdateAdAddamt.do")
    public String viewUpdateAdAddamt(@ModelAttribute("AD_ADDAMTVO") AD_ADDAMTVO ad_ADDAMTVO,
    								ModelMap model){
    	//log.info("/mas/ad/viewUpdateAdAddamt.do 호출:");

    	AD_ADDAMTVO adAddamt = masAdPrdtService.selectByAdAddamt(ad_ADDAMTVO);
    	model.addAttribute("adAddamt", adAddamt);

    	return "mas/ad/updateAdAddamt";
    }

    /**
     * 숙소 추가요금 수정
     * 파일명 : updateAdAddamt
     * 작성일 : 2015. 10. 8. 오후 2:15:55
     * 작성자 : 신우섭
     * @param ad_ADDAMTVO
     * @param bindingResult
     * @param AD_ADDAMTSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/updateAdAddamt.do")
   	public String updateAdAddamt(@ModelAttribute("AD_ADDAMTVO") AD_ADDAMTVO ad_ADDAMTVO,
   								BindingResult bindingResult,
   								@ModelAttribute("searchVO") AD_ADDAMTSVO AD_ADDAMTSVO,
   					    		ModelMap model)
   	{
   		//log.info("/mas/ad/updateAdAddamt.do 호출");

   		// validation 체크
   		beanValidator.validate(ad_ADDAMTVO, bindingResult);
   		if (bindingResult.hasErrors()){
   			log.info("error");

   			model.addAttribute("adAddamt",ad_ADDAMTVO);
   			log.info(bindingResult.toString());
   			return "mas/ad/updateAdAddamt";
   		}

   		masAdPrdtService.updateAdAddamt(ad_ADDAMTVO);

   		return "redirect:/mas/ad/adAddamtList.do";
   	}



    /**
     * 숙소 추가요금 삭제
     * 파일명 : deleteAdAddamt
     * 작성일 : 2015. 10. 8. 오후 2:16:08
     * 작성자 : 신우섭
     * @param ad_ADDAMTVO
     * @param bindingResult
     * @param AD_ADDAMTSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/deleteAdAddamt.do")
	public String deleteAdAddamt(	@ModelAttribute("AD_ADDAMTVO") AD_ADDAMTVO ad_ADDAMTVO,
								BindingResult bindingResult,
								@ModelAttribute("searchVO") AD_ADDAMTSVO AD_ADDAMTSVO,
    							ModelMap model){

    	masAdPrdtService.deleteAdAddamt(ad_ADDAMTVO);

		return "redirect:/mas/ad/adAddamtList.do";
	}





    @RequestMapping("/mas/ad/updateAdBreakfastAmt.do")
   	public String updateAdBreakfastAmt(@ModelAttribute("AD_ADDAMTVO") AD_ADDAMTVO ad_ADDAMTVO,
   								@ModelAttribute("AD_BREAKFASTAMTVO") AD_BREAKFASTAMTVO ad_BREAKFASTAMTVO,
   								BindingResult bindingResult,
   								@ModelAttribute("searchVO") AD_ADDAMTSVO AD_ADDAMTSVO,
   					    		ModelMap model)
   	{
   		//log.info("/mas/ad/updateAdAddamt.do 호출");

    	/*
   		// validation 체크
   		beanValidator.validate(ad_ADDAMTVO, bindingResult);
   		if (bindingResult.hasErrors()){
   			log.info("error");

   			model.addAttribute("adAddamt",ad_ADDAMTVO);
   			log.info(bindingResult.toString());
   			return "mas/ad/updateAdAddamt";
   		}
   		*/

   		masAdPrdtService.updateAdBreakfastAmt(ad_BREAKFASTAMTVO);

   		return "redirect:/mas/ad/adAddamtList.do";
   	}




    /**
     * 숙소 이미지 리스트
     * 파일명 : imgList
     * 작성일 : 2015. 10. 12. 오전 8:55:53
     * 작성자 : 신우섭
     * @param ad_ADDAMTSVO
     * @param imgVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/adInfoImgList.do")
    public String adInfoImgList(	@ModelAttribute("searchVO") AD_ADDAMTSVO ad_ADDAMTSVO,
				    		@ModelAttribute("CM_IMGVO") CM_IMGVO imgVO,
				    		ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

    	String strErrorCode = "0";
    	AD_DFTINFVO ad_DFTINFVO = new AD_DFTINFVO();
    	ad_DFTINFVO.setCorpId(corpInfo.getCorpId());
    	AD_DFTINFVO adDftinf = masAdPrdtService.selectByAdDftinf(ad_DFTINFVO);
    	if(adDftinf == null){
    		strErrorCode = "1";
    	}
    	model.addAttribute("errorCode", strErrorCode);

    	model.addAttribute("linkNum", corpInfo.getCorpId().toUpperCase());

    	imgVO.setLinkNum(corpInfo.getCorpId().toUpperCase());

    	List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
    	model.addAttribute("resultList", imgList);

    	return "/mas/ad/adInfoImgList";
    }


    /**
     * 숙소 이미지 순서 수정
     * 파일명 : updateAdInfoImg
     * 작성일 : 2015. 10. 12. 오전 8:56:10
     * 작성자 : 신우섭
     * @param imgVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/ad/updateAdInfoImg.do")
    public String updateAdInfoImg(	@ModelAttribute("CM_IMGVO") CM_IMGVO imgVO,
									ModelMap model) throws Exception{
    	log.info("/mas/ad/updateAdInfoImg.do 호출");
		ossCmmService.updateImgSn(imgVO);
		return "redirect:/mas/ad/adInfoImgList.do";
    }


    /**
     * 숙소 이미지 삭제
     * 파일명 : deletePrdtImg
     * 작성일 : 2015. 10. 12. 오전 8:56:26
     * 작성자 : 신우섭
     * @param imgVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/ad/deleteAdInfoImg.do")
    public String deletePrdtImg(	@ModelAttribute("CM_IMGVO") CM_IMGVO imgVO,
									ModelMap model) throws Exception{
    	ossCmmService.deletePrdtImg(imgVO);

    	return "redirect:/mas/ad/adInfoImgList.do";
    }

    /**
     * 숙소 이미지 추가
     * 파일명 : insertAdInfoImg
     * 작성일 : 2015. 10. 12. 오전 8:56:34
     * 작성자 : 신우섭
     * @param fileList
     * @param imgVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/ad/insertAdInfoImg.do")
    public String insertAdInfoImg(@Param("fileList") String fileList,
    							@ModelAttribute("CM_IMGVO") CM_IMGVO imgVO,
    							ModelMap model) throws Exception{
    	//log.info("/mas/ad/insertAdInfoImg.do 호출"  + imgVO.getLinkNum());


    	// 이미지 파일 validate 체크
		/*Map<String, Object> imgValidateMap = ossFileUtilService.validateImgFile(multiRequest);

		if(!(Boolean) imgValidateMap.get("validateChk")){
			log.info("이미지 파일 에러");
			model.addAttribute("fileError", imgValidateMap.get("message"));
			List<CM_IMGVO> imgList = ossCmmService.selectImgList(imgVO);
	    	model.addAttribute("resultList", imgList);
	    	return "/mas/ad/adInfoImgList";
		}*/

		ossCmmService.insertPrdtimg(imgVO, fileList);

		return "redirect:/mas/ad/adInfoImgList.do";
    }


    /**
     * 객실리스트
     * 파일명 : acPrdtList
     * 작성일 : 2015. 10. 15. 오전 10:11:12
     * 작성자 : 신우섭
     * @param ad_PRDINFSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/productList.do")
    public String adPrdtList(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
    		ModelMap model){
    	//log.info("/mas/ad/productList.do 호출");

    	AD_DFTINFVO ad_DFTINFVO = new AD_DFTINFVO();
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	ad_DFTINFVO.setCorpId(corpInfo.getCorpId());
    	ad_PRDINFSVO.setsCorpId(corpInfo.getCorpId());

    	String strErrorCode = "0";

    	//기본정보가 없을때
    	AD_DFTINFVO adDftinf = masAdPrdtService.selectByAdDftinf(ad_DFTINFVO);
    	if(adDftinf == null){
//    		model.addAttribute("rentCarInfo", rc_DFTINFVO);
//    		model.addAttribute("message", egovMessageSource.getMessage("common.upperNotExist",new Object[]{new String("기본정보")}, Locale.KOREA));
    		//return "redirect:/mas/detailCorp.do";

    		//model.addAttribute("error", "1");
    		//return "/mas/ad/adPrdtList";
    		strErrorCode = "1";
    	}
    	ad_PRDINFSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	ad_PRDINFSVO.setPageSize(propertiesService.getInt("pageSize"));


		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(ad_PRDINFSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(ad_PRDINFSVO.getPageUnit());
		paginationInfo.setPageSize(ad_PRDINFSVO.getPageSize());

		ad_PRDINFSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		ad_PRDINFSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		ad_PRDINFSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = masAdPrdtService.selectAdPrdinfList(ad_PRDINFSVO);

		@SuppressWarnings("unchecked")
		List<AD_PRDTINFVO> resultList = (List<AD_PRDTINFVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

    	model.addAttribute("corpId", corpInfo.getCorpId());

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		// 거래상태코드
		List<CDVO> cdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
    	model.addAttribute("tsCd", cdList);

		model.addAttribute("errorCode", strErrorCode);

    	return "/mas/ad/adPrdtList";
    }



    /**
     * 객실 추가 뷰
     * 파일명 : viewInsertPrdt
     * 작성일 : 2015. 10. 15. 오전 10:11:39
     * 작성자 : 신우섭
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/viewInsertPrdt.do")
   	public String viewInsertPrdt(@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
   									ModelMap model)
   	{
   		//log.info("/mas/ad/viewInsertPrdt.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());

   		// 업체 기본정보 조회
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	CORPVO resultVO = ossCorpService.selectByCorp(corpVO);
    	model.addAttribute("corpInfo", resultVO);

   		AD_PRDTINFSVO ad_PRDINFSVO = new AD_PRDTINFSVO();
   		ad_PRDINFSVO.setsCorpId(corpInfo.getCorpId());
   		int nTotCnt = masAdPrdtService.getCntAdPrdinf(ad_PRDINFSVO);
   		model.addAttribute("totCnt", nTotCnt);


   		model.addAttribute("adPrdinf", ad_PRDINFVO);
   		return "mas/ad/insertAdPrdt";
   	}


    /**
     * 객실 추가
     * 파일명 : insertAdAddamt
     * 작성일 : 2015. 10. 15. 오전 10:11:54
     * 작성자 : 신우섭
     * @param ad_PRDINFVO
     * @param bindingResult
     * @param ad_PRDINFSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/insertPrdt.do")
   	public String insertAdAddamt(@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
   								BindingResult bindingResult,
   								@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
   					    		ModelMap model)
   	{
   		//log.info("/mas/ad/insertPrdt 호출");
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());

   		// validation 체크
   		beanValidator.validate(ad_PRDINFVO, bindingResult);
   		if (bindingResult.hasErrors()){
   			log.info("error");

   	   		ad_PRDINFSVO.setsCorpId(corpInfo.getCorpId());
   	   		int nTotCnt = masAdPrdtService.getCntAdPrdinf(ad_PRDINFSVO);
   	   		model.addAttribute("totCnt", nTotCnt);

   			model.addAttribute("adPrdinf", ad_PRDINFVO);
   			log.info(bindingResult.toString());
   			return "mas/ad/insertAdPrdt";
   		}


   		//수용인원 최대인원 검사
   		int nStdMem, nMaxiMem;
   		nStdMem 	= Integer.parseInt(ad_PRDINFVO.getStdMem());
   		nMaxiMem 	= Integer.parseInt(ad_PRDINFVO.getMaxiMem());
   		if( nStdMem > nMaxiMem ){
   			bindingResult.rejectValue("stdMem", "errors.msg", new Object[]{"기준인원이 최대 인원 보다 큽니다."},"");
   			bindingResult.rejectValue("maxiMem", "errors.msg", new Object[]{"기준인원이 최대 인원 보다 큽니다."},"");

   			ad_PRDINFSVO.setsCorpId(corpInfo.getCorpId());
   	   		int nTotCnt = masAdPrdtService.getCntAdPrdinf(ad_PRDINFSVO);
   	   		model.addAttribute("totCnt", nTotCnt);

   	   		model.addAttribute("adPrdinf", ad_PRDINFVO);
   			log.info(bindingResult.toString());
   			return "mas/ad/insertAdPrdt";
   		}

   		ad_PRDINFVO.setFrstRegId(corpInfo.getUserId());

   		masAdPrdtService.insertAdPrdinf(ad_PRDINFVO);

   		return "redirect:/mas/ad/productList.do";
   	}


    /**
     * 객실 상세
     * 파일명 : detailPrdt
     * 작성일 : 2015. 10. 15. 오전 10:12:03
     * 작성자 : 신우섭
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/detailPrdt.do")
   	public String detailPrdt(@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
								ModelMap model)	{
   		//log.info("/mas/ad/detailPrdt.do 호출");
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());

    	// 업체 기본정보 조회
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());

    	CORPVO resultVO = ossCorpService.selectByCorp(corpVO);

    	model.addAttribute("corpInfo", resultVO);

    	//상품 정보
   		AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);

   		model.addAttribute("adPrdinf", ad_PRDINFVORes);

   		// 인원추가요금 체크
		Integer addAmtListCount = -1;

		if("Y".equals(ad_PRDINFVORes.getAddamtYn())) {
			AD_ADDAMTSVO ad_ADDAMTSVO = new AD_ADDAMTSVO();
			ad_ADDAMTSVO.setsCorpId(ad_PRDINFVORes.getPrdtNum());

			addAmtListCount = masAdPrdtService.getAddAmtListCount(ad_ADDAMTSVO);
		}
		model.addAttribute("addAmtListCount", addAmtListCount);

   		//전달사항
   		String apprMsg = masSpService.prdtApprMsg(ad_PRDINFVO.getPrdtNum());

		if(StringUtils.isNotEmpty(apprMsg)) {
			apprMsg = EgovStringUtil.checkHtmlView(apprMsg);
		}
		model.addAttribute("apprMsg", apprMsg);

   		return "mas/ad/detailAdPrdt";
   	}


    /**
     * 객실 수정 뷰
     * 파일명 : viewUpdatePrdt
     * 작성일 : 2015. 10. 15. 오전 10:12:14
     * 작성자 : 신우섭
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/viewUpdatePrdt.do")
    public String viewUpdatePrdt(@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
    								ModelMap model){
    	//log.info("/mas/ad/viewUpdatePrdt.do 호출:");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());

   		// 업체 기본정보 조회
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	CORPVO resultVO = ossCorpService.selectByCorp(corpVO);
    	model.addAttribute("corpInfo", resultVO);

   		AD_PRDTINFSVO ad_PRDINFSVO = new AD_PRDTINFSVO();
   		ad_PRDINFSVO.setsCorpId(corpInfo.getCorpId());
   		int nTotCnt = masAdPrdtService.getCntAdPrdinf(ad_PRDINFSVO);
   		model.addAttribute("totCnt", nTotCnt);

   		AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);
   		model.addAttribute("adPrdinf", ad_PRDINFVORes);


    	return "mas/ad/updateAdPrdt";
    }


    /**
     * 객실 수정
     * 파일명 : updatePrdt
     * 작성일 : 2015. 10. 15. 오전 10:12:23
     * 작성자 : 신우섭
     * @param ad_PRDINFVO
     * @param bindingResult
     * @param ad_PRDINFSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/updatePrdt.do")
   	public String updatePrdt(@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
   								BindingResult bindingResult,
   								@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
   					    		ModelMap model)
   	{
   		//log.info("/mas/ad/updatePrdt.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

   		// validation 체크
   		beanValidator.validate(ad_PRDINFVO, bindingResult);
   		if (bindingResult.hasErrors()){
   			log.info("error");

   			ad_PRDINFSVO.setsCorpId(corpInfo.getCorpId());
   	   		int nTotCnt = masAdPrdtService.getCntAdPrdinf(ad_PRDINFSVO);
   	   		model.addAttribute("totCnt", nTotCnt);

   	   		model.addAttribute("adPrdinf", ad_PRDINFVO);
   			log.info(bindingResult.toString());
   			return "mas/ad/updateAdPrdt";
   		}

   		//수용인원 최대인원 검사
   		int nStdMem, nMaxiMem;
   		nStdMem 	= Integer.parseInt(ad_PRDINFVO.getStdMem());
   		nMaxiMem 	= Integer.parseInt(ad_PRDINFVO.getMaxiMem());
   		if( nStdMem > nMaxiMem ){
   			bindingResult.rejectValue("stdMem", "errors.msg", new Object[]{"기준인원이 최대 인원 보다 큽니다."},"");
   			bindingResult.rejectValue("maxiMem", "errors.msg", new Object[]{"기준인원이 최대 인원 보다 큽니다."},"");

   			ad_PRDINFSVO.setsCorpId(corpInfo.getCorpId());
   	   		int nTotCnt = masAdPrdtService.getCntAdPrdinf(ad_PRDINFSVO);
   	   		model.addAttribute("totCnt", nTotCnt);

   	   		model.addAttribute("adPrdinf", ad_PRDINFVO);
   			log.info(bindingResult.toString());
   			return "mas/ad/updateAdPrdt";
   		}


   		ad_PRDINFVO.setLastModId(corpInfo.getUserId());
   		masAdPrdtService.updateAdPrdinf(ad_PRDINFVO);

   		//log.info("/mas/ad/updatePrdt.do 호출:" + ad_PRDINFVO.getOldSn() + ":" + ad_PRDINFVO.getNewSn());
   		//순번 이전값과 변경값이 다르면
   		if( ad_PRDINFVO.getOldSn() != ad_PRDINFVO.getNewSn() ){
   			//log.info("/mas/ad/updatePrdt.do 호출:1");
   			masAdPrdtService.updateAdPrdinfViewSn(ad_PRDINFVO);
   		}

   		return "redirect:/mas/ad/detailPrdt.do?prdtNum=" + ad_PRDINFVO.getPrdtNum();
   	}


    @RequestMapping("/mas/ad/approvalPrdt.ajax")
    public ModelAndView approvalPrdt(@ModelAttribute("AD_PRDTINFVO") AD_PRDTINFVO ad_PRDTINFVO) throws Exception{
    	// TS02 : 승인요청
    	ad_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_APPR_REQ);
    	masAdPrdtService.approvalPrdt(ad_PRDTINFVO);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		ModelAndView mav = new ModelAndView("jsonView", resultMap);

		return mav;
    }


    @RequestMapping("/mas/ad/cancelApproval.ajax")
    public ModelAndView cancelApproval(@ModelAttribute("AD_PRDTINFVO") AD_PRDTINFVO ad_PRDTINFVO) throws Exception{
    	// TS01 : 등록중
    	ad_PRDTINFVO.setTradeStatus(Constant.TRADE_STATUS_REG);
    	masAdPrdtService.approvalCancelPrdt(ad_PRDTINFVO);
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;
    }


    /**
     * 객실 삭제
     * 파일명 : deletePrdt
     * 작성일 : 2015. 10. 15. 오전 10:12:34
     * 작성자 : 신우섭
     * @param ad_PRDINFVO
     * @param bindingResult
     * @param ad_PRDINFSVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/ad/deletePrdt.do")
	public String deletePrdt(	@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
							BindingResult bindingResult,
							@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		ModelMap model) throws Exception{
    	//객실 이미지 삭제
		CM_IMGVO imgVO = new CM_IMGVO();
		imgVO.setLinkNum(ad_PRDINFVO.getPrdtNum());
		ossCmmService.deletePrdtImgList(imgVO);

		//log.info(">>>>>>"+ad_PRDINFVO.getViewSn());

    	masAdPrdtService.deleteAdPrdinf(ad_PRDINFVO);

		return "redirect:/mas/ad/productList.do";
	}


    /**
     * 이미지 목록
     * 파일명 : imgList
     * 작성일 : 2015. 10. 15. 오전 10:13:36
     * 작성자 : 신우섭
     * @param ad_PRDINFSVO
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/imgList.do")
    public String imgList(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("adPrdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());

   		AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);

   		model.addAttribute("adPrdinf", ad_PRDINFVORes);

    	return "/mas/ad/imgList";
    }


    /**
     * 객실 가격 목록(달력)
     * 파일명 : amtList
     * 작성일 : 2015. 10. 15. 오전 10:13:53
     * 작성자 : 신우섭
     * @param adCalendarVO
     * @param ad_PRDINFVO
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/mas/ad/amtList.do")
    public String amtList(@ModelAttribute("ADCALENDARVO") ADCALENDARVO adCalendarVO,
    						@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
				    					ModelMap model,
				    					HttpServletRequest request){

    	//객실 기본정보
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());

   		AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdAmtInf(ad_PRDINFVO);
   		model.addAttribute("adPrdinf", ad_PRDINFVORes);


   		//log.info(">>>:"+ calendarVO.getiYear()+"-"+calendarVO.getiMonth() + " : " + calendarVO.getsPrevNext() );

   		//년월 설정
   		Calendar calNow = Calendar.getInstance();
   		if( adCalendarVO.getiYear() == 0 || adCalendarVO.getiMonth()==0 ){
   			//초기에는 현재 달
   			calNow.set(Calendar.DATE, 1);
   		}else{
   			//날짜가 지정되면 그달

   			int nY = adCalendarVO.getiYear();
   			int nM = adCalendarVO.getiMonth();

   			//년넘어가는건 Calendar에서 알아서 처리해줌... 따라서 13월, -1월로 와도 아무 문제 없음.
   			if(adCalendarVO.getsPrevNext() != null){
	   			if("prev".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nM--;
	   			}else if ("next".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nM++;
	   			}else if("prevyear".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nY--;
	   			}else if("Nextyear".equals(adCalendarVO.getsPrevNext().toLowerCase())){
	   				nY++;
	   			}
   			}
   			calNow.set(nY, nM-1, 1);
   		}
    	adCalendarVO.initValue(calNow);

    	adCalendarVO.setWday(changeWDayView(adCalendarVO.getWday()));
    	model.addAttribute("calendarVO", adCalendarVO );

    	//DB에서 읽어오기
    	AD_AMTINFSVO ad_AMTINFSVO = new AD_AMTINFSVO();
    	ad_AMTINFSVO.setsPrdtNum( ad_PRDINFVO.getPrdtNum() );
    	String strYYYYMM = String.format("%d%02d", adCalendarVO.getiYear(), adCalendarVO.getiMonth() );
    	ad_AMTINFSVO.setsAplDt( strYYYYMM );
    	List<AD_AMTINFVO> resultList = masAdPrdtService.selectAdAmtinfListMas(ad_AMTINFSVO);
		int nListSize = resultList.size();
		int nListPos = 0;


    	//달력의 각 날들 설정
    	List<ADCALENDARVO> calList = new ArrayList<ADCALENDARVO>();
    	for(int i=0; i<adCalendarVO.getiMonthLastDay(); i++){
    		ADCALENDARVO adCal = new ADCALENDARVO();
    		adCal.setiYear( adCalendarVO.getiYear() );
    		adCal.setiMonth( adCalendarVO.getiMonth() );
    		adCal.setiDay( i+1 );
    		if((adCalendarVO.getiWeek() + i)%7==0){
    			adCal.setiWeek( 7 );
    		}else{
    			adCal.setiWeek( (adCalendarVO.getiWeek() + i)%7 );
    		}
    		adCal.setsHolidayYN("N");

    		//데이터 넣기
    		if(nListPos < nListSize){
	    		AD_AMTINFVO adAmt = resultList.get(nListPos);
	    		String strYYYYMMDD = String.format("%d%02d%02d", adCal.getiYear(), adCal.getiMonth(), adCal.getiDay() );
	    		//log.info(">>>:---------------"+strYYYYMMDD + ":" + adAmt.getAplDt());
	    		if(strYYYYMMDD.equals(adAmt.getAplDt()) ){
	    			//log.info(">>>:----------------C"+strYYYYMMDD + ":"+adAmt.getSaleAmt()+":"+adAmt.getNmlAmt() +":"+ adAmt.getHotdallYn());

	    			adCal.setSaleAmt( adAmt.getSaleAmt() );
	    			adCal.setNmlAmt( adAmt.getNmlAmt() );
	    			adCal.setHotdallYn( adAmt.getHotdallYn() );
	    			adCal.setDaypriceYn( adAmt.getDaypriceYn() );
	    			adCal.setDaypriceAmt( adAmt.getDaypriceAmt() );
	    			nListPos++;
	    		}
    		}


    		////공휴일 test
    		//if(i==7){
    		//	adCal.setsHolidayYN("Y");
    		//	adCal.setsHolidayNm("한글날");
    		//}

    		calList.add(adCal);

    		//log.info(">>>:"+ adCal.getiDay()+" ("+adCal.getiWeek() );
    	}
    	model.addAttribute("calList", calList );

    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	model.addAttribute("today", sdf.format(now) );

    	return "/mas/ad/amtList";
    }


    /**
     * 객실 요금 달단위로 수정/추가
     * 파일명 : amtSetCal
     * 작성일 : 2015. 10. 15. 오전 10:14:52
     * 작성자 : 신우섭
     * @param adCalendarVO
     * @param ad_PRDINFVO
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/mas/ad/delDay.do")
    public String delDay(@ModelAttribute("ADCALENDARVO") ADCALENDARVO adCalendarVO,
    					 @ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
    					 @ModelAttribute("AD_AMTINFVO") AD_AMTINFVO ad_AMTINFVO,
				    					ModelMap model,
				    					HttpServletRequest request){
    	
   		masAdPrdtService.deleteAdAmtinfAplDt(ad_AMTINFVO);

   		return "redirect:/mas/ad/amtList.do?prdtNum=" + ad_PRDINFVO.getPrdtNum()
   											+ "&iYear=" + adCalendarVO.getiYear()
   											+ "&iMonth="+ adCalendarVO.getiMonth()
   											+ "&startDt="+adCalendarVO.getStartDt()
    										+ "&endDt="+adCalendarVO.getEndDt()
    										+ "&wday="+changeWDayView(adCalendarVO.getWday())
    										+ "&ioDiv=" + Constant.FLAG_Y;
    }

	/**
	* 설명 :  수정값 변경 적용 click시 월별 객실요금 edit / insert
	* 파일명 : amtSetCal
    * 수정내용 : TB_AD_AMTINF테이블에 입금가 (DEPOSIT_AMT) 저장 로직 추가
	* 수정일 : 2022-03-17 오후 2:50
	* 수정자 : chaewan.jung
	* @param : [adCalendarVO, ad_PRDINFVO, model, request]
	* @return : java.lang.String
	* @throws Exception
	*/
	@RequestMapping("/mas/ad/amtSetCal.do")
    public String amtSetCal(@ModelAttribute("ADCALENDARVO") ADCALENDARVO adCalendarVO,
    						@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
				    					ModelMap model,
				    					HttpServletRequest request){
    	//객실 기본정보
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());

   		//받은 값 파싱
   		String[] strSaleAmts = adCalendarVO.getSaleAmt().split(",");
   		String[] strNmlAmts  = adCalendarVO.getNmlAmt().split(",");
   		String[] strDepAmts = adCalendarVO.getDepositAmt().split(",");
   		//String[] strHotdallYns  = adCalendarVO.getHotdallYn().split(",");
   		String[] strDaypriceYns  = adCalendarVO.getDaypriceYn().split(",");
   		String[] strDaypriceAmts  = adCalendarVO.getDaypriceAmt().split(",");
   		for(int i=0; i<strSaleAmts.length; i++){
   			//log.info("/mas/ad/amtSetCal.do 호출>>>>>>SaleAmt["+(i+1)+"]"+strSaleAmts[i]);
   			//log.info("/mas/ad/amtSetCal.do 호출>>>>>>NmlAmt ["+(i+1)+"]"+strNmlAmts[i]);
   			//log.info("/mas/ad/amtSetCal.do 호출>>>>>>DaypriceAmt ["+(i+1)+"]"+strDaypriceAmts[i]);
   		}

   		//DB에 넣을 데어터 조합
   		List<AD_AMTINFVO> amtList = new ArrayList<AD_AMTINFVO>();
   		for(int i=0; i<adCalendarVO.getiMonthLastDay(); i++){
   			String strSaleAmt = "";
   			String strNmlAmt = "";
   			String strDepAmt = "";
   			//String strHotdallYn = "";
   			String strDaypriceYn = "";
   			String strDaypriceAmt = "";

   			//받은값 파싱된 데이터 넣기
   			if( strSaleAmts.length > i ){
   				strSaleAmt = strSaleAmts[i];
   			}
   			if( strNmlAmts.length > i ){
   				strNmlAmt = strNmlAmts[i];
   			}
			if( strDepAmts.length > i ){
				strDepAmt = strDepAmts[i];
			}
   			/*if( strHotdallYns.length > i ){
   				strHotdallYn = strHotdallYns[i];
   			}*/
   			if( strDaypriceYns.length > i ){
   				strDaypriceYn = strDaypriceYns[i];
   			}
   			if( strDaypriceAmts.length > i ){
   				strDaypriceAmt = strDaypriceAmts[i];
   			}

   			//하나라도 값이 있으면 리스트에 넣기
   			if(!( "".equals(strSaleAmt) && "".equals(strNmlAmt) ) ){
   				AD_AMTINFVO adAmt = new AD_AMTINFVO();
	   			String strYYYYMMDD = String.format("%d%02d%02d", adCalendarVO.getiYear(), adCalendarVO.getiMonth(), i+1 );

	   			adAmt.setPrdtNum( ad_PRDINFVO.getPrdtNum() );
	   			adAmt.setAplDt(strYYYYMMDD);
	   			adAmt.setSaleAmt(strSaleAmt);
	   			adAmt.setNmlAmt(strNmlAmt);
	   			adAmt.setDepositAmt(strDepAmt);
	   			//adAmt.setHotdallYn(strHotdallYn);
	   			adAmt.setDaypriceYn(strDaypriceYn);
	   			adAmt.setDaypriceAmt(strDaypriceAmt);

	   			amtList.add(adAmt);
   			}
   		}

   		//DB에 넣기
   		masAdPrdtService.mergeAmtinf(amtList);

   		return "redirect:/mas/ad/amtList.do?prdtNum=" + ad_PRDINFVO.getPrdtNum()
   											+ "&iYear=" + adCalendarVO.getiYear()
   											+ "&iMonth="+ adCalendarVO.getiMonth()
   											+ "&startDt="+adCalendarVO.getStartDt()
    										+ "&endDt="+adCalendarVO.getEndDt()
    										+ "&wday="+changeWDayView(adCalendarVO.getWday())
    										+ "&ioDiv=" + Constant.FLAG_Y;
    }

    /**
     * 요일 "1,2,5" 형태를 "1100100"형태로 변경 jsp에서 뿌리기 전용
     * 파일명 : changeWDayView
     * 작성일 : 2015. 10. 14. 오후 4:19:52
     * 작성자 : 신우섭
     * @param strOrg
     * @return
     */
    private String changeWDayView(String strOrg){

    	if(strOrg == null || "".equals(strOrg) ){
    		return "00000000";
    	}
    	String strRtn="";

    	for(int i=1; i<=7; i++){
    		 int nIdx = strOrg.indexOf(""+i);
    		 if(nIdx >= 0){
    			 strRtn += "1";
    		 }else{
    			 strRtn += "0";
    		 }
    	}

    	return strRtn;
    }


    /**
     * 요일 "1,2,5" 형태를 리스트에 넣기
     * 파일명 : changeWDaySql
     * 작성일 : 2015. 10. 15. 오전 10:15:29
     * 작성자 : 신우섭
     * @param strOrg
     * @return
     */
    private List<String> changeWDaySql(String strOrg){

    	List<String> wdayList = new ArrayList<String>();

    	for(int i=1; i<=7; i++){
    		 int nIdx = strOrg.indexOf(""+i);
    		 if(nIdx >= 0){
    			 String strData = ""+i;
    			 wdayList.add(strData);
    		 }else{

    		 }
    	}

    	return wdayList;
    }

    /**
     * 객실요금 간단 입력기에서 수정/삽입
     * 파일명 : amtSetSimple
     * 작성일 : 2015. 10. 15. 오전 10:15:49
     * 작성자 : 신우섭
     * @param adCalendarVO
     * @param ad_PRDINFVO
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/mas/ad/amtSetSimple.do")
    public String amtSetSimple(@ModelAttribute("ADCALENDARVO") ADCALENDARVO adCalendarVO,
    							@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
		    					ModelMap model,
		    					HttpServletRequest request){
    	log.info("/mas/ad/amtSetSimple.do 호출");

    	//값넣기
    	AD_AMTINFVO adAmtinfVO = new AD_AMTINFVO();
    	adAmtinfVO.setPrdtNum(ad_PRDINFVO.getPrdtNum());
    	adAmtinfVO.setSaleAmt(adCalendarVO.getSaleAmtSmp());
    	adAmtinfVO.setNmlAmt(adCalendarVO.getNmlAmtSmp());
    	adAmtinfVO.setDepositAmt(adCalendarVO.getDepositAmtSmp());
    	adAmtinfVO.setHotdallYn(adCalendarVO.getHotdallYnSmp());
    	adAmtinfVO.setDaypriceYn(adCalendarVO.getDaypriceYnSmp());
    	if("Y".equals(adAmtinfVO.getDaypriceYn())){
    		adAmtinfVO.setDaypriceAmt(adCalendarVO.getDaypriceAmtSmp());
    	}else{
    		adAmtinfVO.setDaypriceAmt("");
    	}
    	adAmtinfVO.setStartDt(adCalendarVO.getStartDt());
    	adAmtinfVO.setEndDt(adCalendarVO.getEndDt());
    	adAmtinfVO.setWdayList( changeWDaySql(adCalendarVO.getWday()));

    	masAdPrdtService.mergeAmtinfCalSmp(adAmtinfVO);

    	return "redirect:/mas/ad/amtList.do?prdtNum=" + ad_PRDINFVO.getPrdtNum()
    										+ "&iYear=" + adCalendarVO.getiYear()
    										+ "&iMonth="+ adCalendarVO.getiMonth()
    										+ "&startDt="+adCalendarVO.getStartDt()
    										+ "&endDt="+adCalendarVO.getEndDt()
    										+ "&wday="+adCalendarVO.getWday()
    										+ "&ioDiv=" + Constant.FLAG_Y;
    }

    @RequestMapping("/mas/ad/realTimeList.do")
    public String realTimeList(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
    		ModelMap model){
    	log.info("/mas/ad/realTimeList.do 호출");

    	AD_DFTINFVO ad_DFTINFVO = new AD_DFTINFVO();
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	ad_DFTINFVO.setCorpId(corpInfo.getCorpId());
    	ad_PRDINFSVO.setsCorpId(corpInfo.getCorpId());

    	AD_PRDTINFVO ad_PRDTINFVO = new AD_PRDTINFVO();
    	ad_PRDTINFVO.setCorpId(corpInfo.getCorpId());
    	ad_PRDTINFVO.setsTradeStatus("TS05");
    	AD_PRDTINFVO adPrdt = masAdPrdtService.selectByAdPrdinfTopViewSn(ad_PRDTINFVO);

    	if(adPrdt == null){
    		return "redirect:/mas/ad/productList.do";
    	}

    	String strPrdtNum = adPrdt.getPrdtNum();
    	//?prdtNum=AD00000004
    	return "redirect:/mas/ad/cntList.do?prdtNum=" + strPrdtNum;
    }

    /**
     * 객실 수량 목록(달력)
     * 파일명 : cntList
     * 작성일 : 2015. 10. 15. 오전 10:17:29
     * 작성자 : 신우섭
     * @param adCntCalendarVO
     * @param ad_PRDINFVO
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/mas/ad/cntList.do")
    public String cntList(@ModelAttribute("ADCALENDARVO") ADCNTCALENDARVO adCntCalendarVO,
    						@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
				    					ModelMap model,
				    					HttpServletRequest request){

    	//객실 기본정보
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());

   		AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);
   		model.addAttribute("adPrdinf", ad_PRDINFVORes);

   		//년월 설정
   		Calendar calNow = Calendar.getInstance();
   		if( adCntCalendarVO.getiYear() == 0 || adCntCalendarVO.getiMonth()==0 ){
   			//초기에는 현재 달
   			calNow.set(Calendar.DATE, 1);
   		}else{
   			//날짜가 지정되면 그달

   			int nY = adCntCalendarVO.getiYear();
   			int nM = adCntCalendarVO.getiMonth();

   			//년넘어가는건 Calendar에서 알아서 처리해줌... 따라서 13월, -1월로 와도 아무 문제 없음.
   			if(adCntCalendarVO.getsPrevNext() != null){
	   			if("prev".equals(adCntCalendarVO.getsPrevNext().toLowerCase())){
	   				nM--;
	   			}else if ("next".equals(adCntCalendarVO.getsPrevNext().toLowerCase())){
	   				nM++;
	   			}else if("prevyear".equals(adCntCalendarVO.getsPrevNext().toLowerCase())){
	   				nY--;
	   			}else if("Nextyear".equals(adCntCalendarVO.getsPrevNext().toLowerCase())){
	   				nY++;
	   			}
   			}
   			calNow.set(nY, nM-1, 1);
   		}
    	adCntCalendarVO.initValue(calNow);

    	adCntCalendarVO.setWday(changeWDayView(adCntCalendarVO.getWday()));
    	model.addAttribute("calendarVO", adCntCalendarVO );

    	//DB에서 읽어오기
    	AD_CNTINFSVO ad_CNTINFSVO = new AD_CNTINFSVO();
    	ad_CNTINFSVO.setsPrdtNum( ad_PRDINFVO.getPrdtNum() );
    	String strYYYYMM = String.format("%d%02d", adCntCalendarVO.getiYear(), adCntCalendarVO.getiMonth() );
    	ad_CNTINFSVO.setsAplDt( strYYYYMM );
    	List<AD_CNTINFVO> resultList = masAdPrdtService.selectAdCntinfList(ad_CNTINFSVO);
		int nListSize = resultList.size();
		int nListPos = 0;


    	//달력의 각 날들 설정
    	List<ADCNTCALENDARVO> calList = new ArrayList<ADCNTCALENDARVO>();
    	for(int i=0; i<adCntCalendarVO.getiMonthLastDay(); i++){
    		ADCNTCALENDARVO adCal = new ADCNTCALENDARVO();
    		adCal.setiYear( adCntCalendarVO.getiYear() );
    		adCal.setiMonth( adCntCalendarVO.getiMonth() );
    		adCal.setiDay( i+1 );
    		if((adCntCalendarVO.getiWeek() + i)%7==0){
    			adCal.setiWeek( 7 );
    		}else{
    			adCal.setiWeek( (adCntCalendarVO.getiWeek() + i)%7 );
    		}
    		adCal.setsHolidayYN("N");

    		//데이터 넣기
    		if(nListPos < nListSize){
	    		AD_CNTINFVO adCnt = resultList.get(nListPos);
	    		String strYYYYMMDD = String.format("%d%02d%02d", adCal.getiYear(), adCal.getiMonth(), adCal.getiDay() );
	    		if(strYYYYMMDD.equals(adCnt.getAplDt()) ){
	    			adCal.setTotalRoomNum( adCnt.getTotalRoomNum() );
	    			adCal.setUseRoomNum( adCnt.getUseRoomNum() );
	    			adCal.setDdlYn( adCnt.getDdlYn() );

	    			nListPos++;
	    		}
    		}


    		////공휴일 test
    		//if(i==7){
    		//	adCal.setsHolidayYN("Y");
    		//	adCal.setsHolidayNm("한글날");
    		//}

    		calList.add(adCal);

    	}
    	model.addAttribute("calList", calList );


    	//객실 목록
    	AD_PRDTINFVO ad_PRDINFSVO = new AD_PRDTINFVO();
    	ad_PRDINFSVO.setCorpId(corpInfo.getCorpId());
    	ad_PRDINFSVO.setsTradeStatus("TS05");
    	List<AD_PRDTINFVO> adPrdtList = masAdPrdtService.selectAdPrdinfListOfRT(ad_PRDINFSVO);
    	model.addAttribute("prdtList", adPrdtList );

    	//업체 정보 얻기
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	CORPVO corpRes = corpDAO.selectCorpByCorpId(corpVO);



    	Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	model.addAttribute("today", sdf.format(now) );
    	if( "Y".equals(corpRes.getCorpLinkYn()) ){
    		return "/mas/ad/cntListLink";
    	}else{
    		return "/mas/ad/cntList";
    	}

    }


    /**
     * 객실 수량 달단위로 수정/추가
     * 파일명 : cntSetCal
     * 작성일 : 2015. 10. 15. 오전 11:47:06
     * 작성자 : 신우섭
     * @param adCntCalendarVO
     * @param ad_PRDINFVO
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/mas/ad/cntSetCal.do")
    public String cntSetCal(@ModelAttribute("ADCNTCALENDARVO") ADCNTCALENDARVO adCntCalendarVO,
    						@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
				    					ModelMap model,
				    					HttpServletRequest request){
    	//log.info("/mas/ad/amtSetCal.do 호출");

    	//객실 기본정보
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());

   		//받은 값 파싱
   		String[] strTotalRoomNums	= adCntCalendarVO.getTotalRoomNum().split(",");
   		String[] strUseRoomNums  	= adCntCalendarVO.getUseRoomNum().split(",");
   		String[] strDdlYns  		= adCntCalendarVO.getDdlYn().split(",");

   		//DB에 넣을 데어터 조합
   		List<AD_CNTINFVO> cntList = new ArrayList<AD_CNTINFVO>();
   		for(int i=0; i<adCntCalendarVO.getiMonthLastDay(); i++){
   			String strTotalRoomNum = "";
   			String strUseRoomNum = "";
   			String strDdlYn = "";

   			//받은값 파싱된 데이터 넣기
   			if( strTotalRoomNums.length > i ){
   				strTotalRoomNum = strTotalRoomNums[i];
   			}
   			if( strUseRoomNums.length > i ){
   				strUseRoomNum = strUseRoomNums[i];
   			}
   			if( strDdlYns.length > i ){
   				strDdlYn = strDdlYns[i];
   			}

   			//하나라도 값이 있으면 리스트에 넣기
   			if(!( "".equals(strTotalRoomNum) && "".equals(strUseRoomNum) ) ){
   				AD_CNTINFVO adCnt = new AD_CNTINFVO();
	   			String strYYYYMMDD = String.format("%d%02d%02d", adCntCalendarVO.getiYear(), adCntCalendarVO.getiMonth(), i+1 );

	   			//log.info("/mas/ad/amtSetCal.do 호출>>>>>>["+ad_PRDINFVO.getPrdtNum()+"]["+strYYYYMMDD+"]["+strSaleAmt+"]["+strNmlAmt+"]");

	   			adCnt.setPrdtNum( ad_PRDINFVO.getPrdtNum() );
	   			adCnt.setAplDt(strYYYYMMDD);
	   			adCnt.setTotalRoomNum(strTotalRoomNum);
	   			if(strUseRoomNum.isEmpty()){
	   				adCnt.setUseRoomNum("0");
	   			}else{
	   				adCnt.setUseRoomNum(strUseRoomNum);
	   			}
	   			adCnt.setDdlYn(strDdlYn);

	   			cntList.add(adCnt);
   			}
   		}

   		//DB에 넣기
   		masAdPrdtService.mergeCntinf(cntList);


   		//return amtList(calendarVO, ad_PRDINFVO, model, request);
   		return "redirect:/mas/ad/cntList.do?prdtNum=" + ad_PRDINFVO.getPrdtNum()
   											+ "&iYear=" + adCntCalendarVO.getiYear()
   											+ "&iMonth="+ adCntCalendarVO.getiMonth()
   											+ "&startDt="+adCntCalendarVO.getStartDt()
    										+ "&endDt="+adCntCalendarVO.getEndDt()
    										+ "&wday="+changeWDayView(adCntCalendarVO.getWday())
    										+ "&ioDiv=" + Constant.FLAG_Y;
    }


    /**
     * 객실 수 간단 입력기에서 수정/삽입
     * 파일명 : cntSetSimple
     * 작성일 : 2015. 10. 15. 오후 2:01:31
     * 작성자 : 신우섭
     * @param adCntCalendarVO
     * @param ad_PRDINFVO
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/mas/ad/cntSetSimple.do")
    public String cntSetSimple(@ModelAttribute("ADCNTCALENDARVO") ADCNTCALENDARVO adCntCalendarVO,
    							@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
		    					ModelMap model,
		    					HttpServletRequest request){
    	//log.info("/mas/ad/cntSetSimple.do 호출");

    	//log.info("/mas/ad/amtSetSimple.do 호출:" + adCalendarVO.getWday() );

    	//값넣기
    	AD_CNTINFVO adCntinfVO = new AD_CNTINFVO();
    	adCntinfVO.setPrdtNum(	ad_PRDINFVO.getPrdtNum() );

    	adCntinfVO.setTotalRoomNum( adCntCalendarVO.getTotalRoomNumSmp() );
    	adCntinfVO.setUseRoomNum(adCntCalendarVO.getUseRoomNumSmp());
    	//adCntinfVO.setUseRoomNum( adCntCalendarVO.getUseRoomNumSmp() );
    	adCntinfVO.setDdlYn( adCntCalendarVO.getDdlYnSmp() );

    	adCntinfVO.setStartDt(	adCntCalendarVO.getStartDt() );
    	adCntinfVO.setEndDt(	adCntCalendarVO.getEndDt() );
    	adCntinfVO.setWdayList( changeWDaySql(adCntCalendarVO.getWday()) );

    	masAdPrdtService.mergeCntinfCalSmp(adCntinfVO);

    	return "redirect:/mas/ad/cntList.do?prdtNum=" + ad_PRDINFVO.getPrdtNum()
    										+ "&iYear=" + adCntCalendarVO.getiYear()
    										+ "&iMonth="+ adCntCalendarVO.getiMonth()
    										+ "&startDt="+adCntCalendarVO.getStartDt()
    										+ "&endDt="+adCntCalendarVO.getEndDt()
    										+ "&wday="+adCntCalendarVO.getWday()
    										+ "&ioDiv=" + Constant.FLAG_Y;
    }


    /**
     * 상품평 리스트
     * 파일명 : useepilList
     * 작성일 : 2015. 10. 23. 오전 9:43:17
     * 작성자 : 신우섭
     * @param ad_PRDINFSVO
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/useepilList.do")
    public String useepilList(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	//log.info("/mas/ad/useepilList.do 호출");

    	return "/mas/ad/useepilList";
    }

    /**
     * 상품평 상세
     * 파일명 : detailUseepil
     * 작성일 : 2015. 10. 23. 오전 9:43:21
     * 작성자 : 신우섭
     * @param ad_PRDINFSVO
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/detailUseepil.do")
    public String detailUseepil(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	//log.info("/mas/ad/detailUseepil.do 호출");

    	return "/mas/ad/detailUseepil";
    }

    /**
     * 1:1문의 목록
     * 파일명 : otoinqlList
     * 작성일 : 2015. 10. 28. 오전 11:51:57
     * 작성자 : 신우섭
     * @param ad_PRDINFSVO
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/otoinqList.do")
    public String otoinqlList(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	//log.info("/mas/ad/otoinqList.do 호출");

    	return "/mas/ad/otoinqList";
    }

    /**
     * 1:1문의 상세
     * 파일명 : detailOtoinq
     * 작성일 : 2015. 10. 28. 오전 11:52:01
     * 작성자 : 신우섭
     * @param ad_PRDINFSVO
     * @param ad_PRDINFVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/detailOtoinq.do")
    public String detailOtoinq(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
				    		@ModelAttribute("prdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	//log.info("/mas/ad/detailUOtoinq.do 호출");

    	return "/mas/ad/detailOtoinq";
    }


    @RequestMapping("/mas/preview/adPrdt.do")
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

    @RequestMapping("/mas/ad/saleStopPrdt.do")
    public String saleStopPrdt(@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
    								ModelMap model){
    	// 2016.04.25 업체에서 판매중지시 이력 남김
    	CM_CONFHISTVO cm_CONFHISTVO = new CM_CONFHISTVO();
    	cm_CONFHISTVO.setLinkNum(ad_PRDINFVO.getPrdtNum());
    	cm_CONFHISTVO.setTradeStatus(Constant.TRADE_STATUS_STOP_REQ);

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

    	cm_CONFHISTVO.setRegId(corpInfo.getUserId());
		cm_CONFHISTVO.setRegIp(corpInfo.getLastLoginIp());

    	ossPrdtService.productAppr(cm_CONFHISTVO);

    	ad_PRDINFVO.setTradeStatus(Constant.TRADE_STATUS_STOP_REQ);
    	masAdPrdtService.approvalCancelPrdt(ad_PRDINFVO);

    	return "redirect:/mas/ad/detailPrdt.do?prdtNum=" + ad_PRDINFVO.getPrdtNum() ;
    }

    @RequestMapping("/mas/ad/saleStartPrdt.do")
    public String saleStartPrdt(@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
    								ModelMap model){
    	// 2016.04.25 업체에서 승인 시 이력 남김
    	CM_CONFHISTVO cm_CONFHISTVO = new CM_CONFHISTVO();
    	cm_CONFHISTVO.setLinkNum(ad_PRDINFVO.getPrdtNum());
    	cm_CONFHISTVO.setTradeStatus(Constant.TRADE_STATUS_APPR);

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

    	cm_CONFHISTVO.setRegId(corpInfo.getUserId());
		cm_CONFHISTVO.setRegIp(corpInfo.getLastLoginIp());

    	ossPrdtService.productAppr(cm_CONFHISTVO);

    	ad_PRDINFVO.setTradeStatus(Constant.TRADE_STATUS_APPR);
    	masAdPrdtService.approvalCancelPrdt(ad_PRDINFVO);

    	return "redirect:/mas/ad/detailPrdt.do?prdtNum=" + ad_PRDINFVO.getPrdtNum() ;
    }
    
    /* 목록에서 히든처리 */
    @RequestMapping("/mas/ad/salePrintN.do")
    public String salePrintN(@ModelAttribute("AD_PRDINFVO") AD_PRDTINFVO ad_PRDINFVO,
			ModelMap model){
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	ad_PRDINFVO.setLastModId(corpInfo.getUserId());
    	masAdPrdtService.salePrintN(ad_PRDINFVO);
    	
    	return "redirect:/mas/ad/productList.do";
    }    

    /**
     * 해당 상품에 예약건이 존재하는지 확인
     * 파일명 : checkExsistPrdt
     * 작성일 : 2016. 11. 23. 오후 4:13:25
     * 작성자 : 최영철
     * @param rsvSVO
     * @return
     */
    @RequestMapping("/mas/ad/checkExsistPrdt.ajax")
    public ModelAndView checkExsistPrdt(@ModelAttribute("searchVO") RSVSVO rsvSVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	Integer chkInt = masAdPrdtService.checkExsistPrdt(rsvSVO);
    	resultMap.put("chkInt", chkInt);
    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;

    }

    /**
     * 객실의 연박 관리 리스트
     * Function : continueNight
     * 작성일 : 2017. 6. 16. 오전 10:47:00
     * 작성자 : 정동수
     * @param ad_PRDINFSVO
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/continueNight.do")
    public String continueNight(@ModelAttribute("searchVO") AD_PRDTINFSVO ad_PRDINFSVO,
    								@ModelAttribute("adPrdinf") AD_PRDTINFVO ad_PRDINFVO,
				    		ModelMap model){
    	log.info("/mas/ad/continueNight.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_PRDINFVO.setCorpId(corpInfo.getCorpId());

   		AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);
   		model.addAttribute("adPrdinf", ad_PRDINFVORes);

   		// 연박 정보 리스트
   		AD_CTNINFVO ad_CtnInf = new AD_CTNINFVO();
   		ad_CtnInf.setPrdtNum(ad_PRDINFVO.getPrdtNum());
   		List<AD_CTNINFVO> ctnInfoList = masAdPrdtService.selectAdCtnInfList(ad_CtnInf);
   		model.addAttribute("ctnInfoList", ctnInfoList);

   		Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	model.addAttribute("today", sdf.format(now) );

    	return "/mas/ad/continueNight";
    }

    /**
     * 연박 기관관리 수정 폼
     * Function : updateCtnAplYn
     * 작성일 : 2017. 6. 21. 오후 4:02:31
     * 작성자 : 정동수
     * @param ad_CtnInf
     * @return
     */
    @RequestMapping("/mas/ad/ctnInfModify.ajax")
    public ModelAndView ctnInfModify(@ModelAttribute("adCtnInf") AD_CTNINFVO ad_CtnInf){
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	mav.addObject("ctnInf", masAdPrdtService.selectAdCtnInfoInfo(ad_CtnInf));

    	return mav;

    }

    /**
     * 연박 요금관리 적용여부 수정 처리
     * Function : updateCtnAplYn
     * 작성일 : 2017. 6. 16. 오후 4:02:31
     * 작성자 : 정동수
     * @param ad_PRDTINFVO
     * @return
     */
    @RequestMapping("/mas/ad/updateCtnAplYn.ajax")
    public ModelAndView updateCtnAplYn(@ModelAttribute("adPrdInf") AD_PRDTINFVO ad_PRDTINFVO){
    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	masAdPrdtService.updateCtnAplYn(ad_PRDTINFVO);

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;

    }

    /**
     * 연박 관리의 기간관리 등록/수정
     * Function : actionCtnInf
     * 작성일 : 2017. 6. 19. 오후 4:03:46
     * 작성자 : 정동수
     * @param ad_CTNINFVO
     * @param redirect
     * @return
     */
    @RequestMapping("/mas/ad/actionCtnInf.do")
    public String actionCtnInf(@ModelAttribute("adCtnInf") AD_CTNINFVO ad_CTNINFVO,
    		RedirectAttributes redirect){
    	log.info("/mas/ad/actionctnInf.do 호출");

    	if (ad_CTNINFVO.getCtnInfSn() == null || "".equals(ad_CTNINFVO.getCtnInfSn())) {
    		// 등록
    		masAdPrdtService.insertAdCtnInf(ad_CTNINFVO);
    	} else {
    		// 수정
    		masAdPrdtService.updateAdCtnInf(ad_CTNINFVO);
    	}

    	redirect.addAttribute("prdtNum", ad_CTNINFVO.getPrdtNum());
    	return "redirect:/mas/ad/continueNight.do";
    }
    
    /**
     * 연박 관리의 기간관리 삭제
     * Function : deleteCtnInf
     * 작성일 : 2018. 1. 12. 오전 11:17:43
     * 작성자 : 정동수
     * @param ad_CTNINFVO
     * @param redirect
     * @return
     */
    @RequestMapping("/mas/ad/deleteCtnInf.do")
    public String deleteCtnInf(@ModelAttribute("adCtnInf") AD_CTNINFVO ad_CTNINFVO,
    		RedirectAttributes redirect){
    	log.info("/mas/ad/deleteCtnInf.do 호출");

    	if (ad_CTNINFVO.getCtnInfSn() != null && "".equals(ad_CTNINFVO.getCtnInfSn()) == false) {
    		// 삭제 처리
    		masAdPrdtService.deleteAdCtnInf(ad_CTNINFVO);
    	}

    	redirect.addAttribute("prdtNum", ad_CTNINFVO.getPrdtNum());
    	return "redirect:/mas/ad/continueNight.do";
    }

    /**
     * 기간에 해당하는 요금 정보 산출
     * Function : selectCtnAmt
     * 작성일 : 2017. 6. 27. 오전 10:31:37
     * 작성자 : 정동수
     * @param ctnAmt
     * @return
     */
    @RequestMapping("/mas/ad/selectCtnAmt.ajax")
    public ModelAndView selectCtnAmt(@ModelAttribute("adCtnAmt") AD_CTNAMTVO ctnAmt){
    	log.info("/mas/ad/selectCtnAmt.ajax 호출");

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	List<AD_CTNAMTVO> amtList = masAdPrdtService.selectAdCtnAmt(ctnAmt);

    	for (AD_CTNAMTVO amt : amtList) {
    		resultMap.put(amt.getAplNight(), amt);
    	}

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;

    }

    /**
     * 연박 관리의 요금관리 저장
     * Function : actionCtnAmt
     * 작성일 : 2017. 6. 21. 오후 4:23:29
     * 작성자 : 정동수
     * @param ctnAmtList
     * @return
     */
    @RequestMapping("/mas/ad/actionCtnAmt.ajax")
    public ModelAndView actionCtnAmt(@ModelAttribute("ctnAmt") AD_CTNAMTVOLIST ctnAmtList){
    	log.info("/mas/ad/actionCtnAmt.ajax 호출");

    	Map<String, Object> resultMap = new HashMap<String, Object>();

    	AD_CTNAMTVO ctnAmt = new AD_CTNAMTVO();
    	for(AD_CTNAMTVO ad_CtnAmt : ctnAmtList.getCtnAmt()) {
    		ctnAmt = ad_CtnAmt;
    		masAdPrdtService.updateAdCtnAmt(ad_CtnAmt);
		}

    	resultMap.put("ctnAmt", ctnAmt);
    	resultMap.put("amtStr", masAdPrdtService.selectCtnAmtStr(ctnAmt).getAmtDiv());

    	ModelAndView mav = new ModelAndView("jsonView", resultMap);

    	return mav;

    }


    /**
     * 객실별 인원추가요금
     * 파일명 : adAddamtPrdtList
     * 작성일 : 2017. 8. 25. 오전 10:04:15
     * 작성자 : 신우섭
     * @param ad_ADDAMTSVO
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mas/ad/adAddamtPrdtList.do")
	public String adAddamtPrdtList(@ModelAttribute("searchVO") AD_ADDAMTSVO ad_ADDAMTSVO,
								   HttpServletRequest request,
								   ModelMap model) {
		//log.info("/mas/ad/adAddamtList 호출");
		//log.info("/oss/bbsList.do 호출:" + bbsSVO.getsKey() + ":" + bbsSVO.getsKeyOpt() );

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		//ad_ADDAMTSVO.setsCorpId(corpInfo.getCorpId());
    	ad_ADDAMTSVO.setsCorpId( request.getParameter("prdtNum"));


    	AD_PRDTINFVO ad_PRDINFVO = new AD_PRDTINFVO();
    	ad_PRDINFVO.setPrdtNum(request.getParameter("prdtNum"));
    	AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);
   		model.addAttribute("adPrdinf", ad_PRDINFVORes);


		String strErrorCode = "0";
		AD_DFTINFVO ad_DFTINFVO = new AD_DFTINFVO();
		ad_DFTINFVO.setCorpId(corpInfo.getCorpId());
		AD_DFTINFVO adDftinf = masAdPrdtService.selectByAdDftinf(ad_DFTINFVO);
    	if(adDftinf == null){
    		strErrorCode = "1";
    	}

		ad_ADDAMTSVO.setPageUnit(propertiesService.getInt("pageUnit"));
		ad_ADDAMTSVO.setPageSize(propertiesService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(ad_ADDAMTSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(ad_ADDAMTSVO.getPageUnit());
		paginationInfo.setPageSize(ad_ADDAMTSVO.getPageSize());

		ad_ADDAMTSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		ad_ADDAMTSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		ad_ADDAMTSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = masAdPrdtService.selectAdAddamtList(ad_ADDAMTSVO);

		@SuppressWarnings("unchecked")
		List<AD_ADDAMTVO> resultList = (List<AD_ADDAMTVO>) resultMap.get("resultList");

		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

    	model.addAttribute("corpId", corpInfo.getCorpId());
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("errorCode", strErrorCode);

		return "/mas/ad/adAddamtPrdtList";
	}

    @RequestMapping("/mas/ad/viewInsertAdAddamtPrdt.do")
   	public String viewInsertAdAddamtPrdt(@ModelAttribute("AD_ADDAMTVO") AD_ADDAMTVO ad_ADDAMTVO,
   									HttpServletRequest request,
   									ModelMap model)
   	{
   		//log.info("/mas/ad/viewInsertAdAddamt.do 호출");

    //	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
   		ad_ADDAMTVO.setCorpId(request.getParameter("prdtNum"));

   		AD_PRDTINFVO ad_PRDINFVO = new AD_PRDTINFVO();
    	ad_PRDINFVO.setPrdtNum(request.getParameter("prdtNum"));
    	AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);
   		model.addAttribute("adPrdinf", ad_PRDINFVORes);

   		model.addAttribute("adAddamt", ad_ADDAMTVO);

   		Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	model.addAttribute("today", sdf.format(now) );

   		return "mas/ad/insertAdAddamtPrdt";
   	}

    @RequestMapping("/mas/ad/insertAdAddamtPrdt.do")
   	public String insertAdAddamtPrdt(@ModelAttribute("AD_ADDAMTVO") AD_ADDAMTVO ad_ADDAMTVO,
   								@ModelAttribute("searchVO") AD_ADDAMTSVO ad_ADDAMTSVO,
   								BindingResult bindingResult,
   								HttpServletRequest request,
   					    		ModelMap model)
   	{
   		//log.info("/mas/ad/insertAdAddamt 호출");

    	AD_PRDTINFVO ad_PRDINFVO = new AD_PRDTINFVO();
    	ad_PRDINFVO.setPrdtNum(request.getParameter("prdtNum"));
    	AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);
   		model.addAttribute("adPrdinf", ad_PRDINFVORes);

   		// validation 체크
   		beanValidator.validate(ad_ADDAMTVO, bindingResult);
   		if (bindingResult.hasErrors()){
   			log.info("error");

   			model.addAttribute("adAddamt",ad_ADDAMTVO);
   			log.info(bindingResult.toString());
   			return "mas/ad/insertAdAddamtPrdt";
   		}

   		AD_ADDAMTVO adAddamt = masAdPrdtService.selectByAdAddamt(ad_ADDAMTVO);
   		if(adAddamt != null){
   			model.addAttribute("errmsg", "이미 같은 적용 시작 일자가 있습니다.");
   			model.addAttribute("adAddamt", ad_ADDAMTVO);
   			return "mas/ad/insertAdAddamtPrdt";
   		}
   		//log.info("/mas/ad/insertAdAddamt 호출:" + ad_ADDAMTVO.getCorpId() + ":" + ad_ADDAMTVO.getAplStartDt() + ":" + ad_ADDAMTVO.getAdultAddAmt() );

   		masAdPrdtService.insertAdAddamt(ad_ADDAMTVO);

   		return "redirect:/mas/ad/adAddamtPrdtList.do?prdtNum="+request.getParameter("prdtNum");
   	}

    @RequestMapping("/mas/ad/viewUpdateAdAddamtPrdt.do")
    public String viewUpdateAdAddamtPrdt(@ModelAttribute("AD_ADDAMTVO") AD_ADDAMTVO ad_ADDAMTVO,
    								HttpServletRequest request,
    								ModelMap model){
    	//log.info("/mas/ad/viewUpdateAdAddamt.do 호출:");

    	ad_ADDAMTVO.setCorpId(request.getParameter("prdtNum"));

   		AD_PRDTINFVO ad_PRDINFVO = new AD_PRDTINFVO();
    	ad_PRDINFVO.setPrdtNum(request.getParameter("prdtNum"));
    	AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);
   		model.addAttribute("adPrdinf", ad_PRDINFVORes);


    	AD_ADDAMTVO adAddamt = masAdPrdtService.selectByAdAddamt(ad_ADDAMTVO);
    	model.addAttribute("adAddamt", adAddamt);

    	return "mas/ad/updateAdAddamtPrdt";
    }

    @RequestMapping("/mas/ad/updateAdAddamtPrdt.do")
   	public String updateAdAddamtPrdt(@ModelAttribute("AD_ADDAMTVO") AD_ADDAMTVO ad_ADDAMTVO,
   								@ModelAttribute("searchVO") AD_ADDAMTSVO AD_ADDAMTSVO,
   								BindingResult bindingResult,
   								HttpServletRequest request,
   					    		ModelMap model)
   	{
   		//log.info("/mas/ad/updateAdAddamt.do 호출");

    	AD_PRDTINFVO ad_PRDINFVO = new AD_PRDTINFVO();
    	ad_PRDINFVO.setPrdtNum(request.getParameter("prdtNum"));
    	AD_PRDTINFVO ad_PRDINFVORes = masAdPrdtService.selectByAdPrdinf(ad_PRDINFVO);
   		model.addAttribute("adPrdinf", ad_PRDINFVORes);

   		// validation 체크
   		beanValidator.validate(ad_ADDAMTVO, bindingResult);
   		if (bindingResult.hasErrors()){
   			log.info("error");

   			model.addAttribute("adAddamt",ad_ADDAMTVO);
   			log.info(bindingResult.toString());
   			return "mas/ad/updateAdAddamtPrdt";
   		}

   		masAdPrdtService.updateAdAddamt(ad_ADDAMTVO);

   		return "redirect:/mas/ad/adAddamtPrdtList.do?prdtNum="+request.getParameter(	"prdtNum");
   	}

    @RequestMapping("/mas/ad/deleteAdAddamtPrdt.do")
	public String deleteAdAddamtPrdt(	@ModelAttribute("AD_ADDAMTVO") AD_ADDAMTVO ad_ADDAMTVO,
								@ModelAttribute("searchVO") AD_ADDAMTSVO AD_ADDAMTSVO,
								BindingResult bindingResult,
								HttpServletRequest request,
    							ModelMap model){

    	masAdPrdtService.deleteAdAddamt(ad_ADDAMTVO);

		return "redirect:/mas/ad/adAddamtPrdtList.do?prdtNum="+request.getParameter("prdtNum");
	}

}
