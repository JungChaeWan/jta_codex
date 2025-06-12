package mas.otoinq.web;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.rc.service.MasRcPrdtService;
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
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.otoinq.service.OssOtoinqService;
import oss.otoinq.vo.OTOINQSVO;
import oss.otoinq.vo.OTOINQVO;
import oss.user.service.OssUserService;
import oss.user.vo.USERVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class MasOtoinqController {
	
	@Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;  

	@Resource(name="ossOtoinqService")
	private OssOtoinqService ossOtoinqService;
	
	
	@Resource(name="masRcPrdtService")
    private MasRcPrdtService masRcPrdtService;
	
	@Resource(name="masSpService")
    private MasSpService masSpService;
	
	@Resource(name="masSvService")
	private MasSvService masSvService;
	
	@Resource(name="ossUserService")
	private OssUserService ossUserService;
	

    
    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    
    @RequestMapping("/mas/otoinq/otoinqList.do")
    public String useepilList(@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
    							@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							ModelMap model){
    	//log.info("/mas/otoinq/otoinqList.do 호출");

    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	otoinqVO.setCorpId(corpInfo.getCorpId());
    	otoinqSVO.setsCorpId(corpInfo.getCorpId());
    	otoinqSVO.setCorpCd(corpInfo.getCorpCd() );
    	model.addAttribute("corpCdUp", corpInfo.getCorpCd() );
    	model.addAttribute("corpCd", corpInfo.getCorpCd().toLowerCase() );
    	
    	//log.info("/mas/otoinq/otoinqList.do 호출>>"+ otoinqVO.getCorpId() + ":" + otoinqSVO.getCorpCd());
    	
    	otoinqSVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	otoinqSVO.setPageSize(propertiesService.getInt("pageSize"));
		

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(otoinqSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(otoinqSVO.getPageUnit());
		paginationInfo.setPageSize(otoinqSVO.getPageSize());

		otoinqSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		otoinqSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		otoinqSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		//상품평 조회
		//Map<String, Object> resultMap = ossUesepliService.selectUseepilList(otoinqSVO);	
		Map<String, Object> resultMap = ossOtoinqService.selectOtoinqList(otoinqSVO);
		@SuppressWarnings("unchecked")
		List<OTOINQVO> resultList = (List<OTOINQVO>) resultMap.get("resultList");
		
		for (OTOINQVO data : resultList) {
			//상품명 얻기
			data.setPrdtNm("");
			if(data.getPrdtNum() != null || "".equals(data.getPrdtNum()) ){ 
				if(corpInfo.getCorpCd().equals(Constant.RENTCAR) ){
					RC_PRDTINFVO rcPrftVO = new RC_PRDTINFVO();
					rcPrftVO.setPrdtNum(data.getPrdtNum());
					RC_PRDTINFVO rcPrftRes =  masRcPrdtService.selectByPrdt(rcPrftVO);
					if(rcPrftRes != null){
						data.setPrdtNm(rcPrftRes.getPrdtNm());
					}
				}else if(corpInfo.getCorpCd().equals(Constant.SOCIAL) ){
					SP_PRDTINFVO spPrdtVO = new SP_PRDTINFVO();
					spPrdtVO.setPrdtNum(data.getPrdtNum());
					SP_PRDTINFVO spPrdtRes = masSpService.selectBySpPrdtInf(spPrdtVO);
					if(spPrdtRes != null){
						data.setPrdtNm(spPrdtRes.getPrdtNm());
					}
				}else if(corpInfo.getCorpCd().equals(Constant.SV) ){
					SV_PRDTINFVO svPrdtVO = new SV_PRDTINFVO();
					svPrdtVO.setPrdtNum(data.getPrdtNum());
					svPrdtVO = masSvService.selectBySvPrdtInf(svPrdtVO);
					if(svPrdtVO != null){
						data.setPrdtNm(svPrdtVO.getPrdtNm());
					}
				}
			}	
		}
	
		// 총 건수 셋팅
    	paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));
    	
	
		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);


    	return "/mas/otoinq/otoinqList";
    }
 

    @RequestMapping("/mas/otoinq/detailOtoinq.do")
    public String detailUseepil(@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							ModelMap model){
    	//log.info("/mas/otoinq/detailOtoinq.do 호출");
    	
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	otoinqVO.setCorpId(corpInfo.getCorpId());
    	otoinqSVO.setsCorpId(corpInfo.getCorpId());
    	otoinqSVO.setCorpCd(corpInfo.getCorpCd() );
    	model.addAttribute("corpCdUp", corpInfo.getCorpCd() );
    	model.addAttribute("corpCd", corpInfo.getCorpCd().toLowerCase() );
    	
    	//상품평 정보 읽기
    	OTOINQVO otoinqVORes = ossOtoinqService.selectByOtoinq(otoinqVO);
    	model.addAttribute("data", otoinqVORes);
    	
    	//otoinqVORes.setContents(EgovWebUtil.clearXSSMinimum(otoinqVORes.getContents()) );
    	//otoinqVORes.setContents( otoinqVORes.getContents().replaceAll("\n", "<br/>\n") );
    	otoinqVORes.setContents(EgovStringUtil.checkHtmlView(otoinqVORes.getContents()) );
    	
    	//상품명 얻기
    	otoinqVORes.setPrdtNm("");
    	if(corpInfo.getCorpCd().equals(Constant.RENTCAR) ){
	    	RC_PRDTINFVO rcPrftVO = new RC_PRDTINFVO();
			rcPrftVO.setPrdtNum(otoinqVORes.getPrdtNum());
			RC_PRDTINFVO rcPrftRes =  masRcPrdtService.selectByPrdt(rcPrftVO);
			if(rcPrftRes != null){
				otoinqVORes.setPrdtNm(rcPrftRes.getPrdtNm());
			}
    	}else if(corpInfo.getCorpCd().equals(Constant.SOCIAL) ){
    		SP_PRDTINFVO spPrftVO = new SP_PRDTINFVO();
			spPrftVO.setPrdtNum(otoinqVORes.getPrdtNum());
			SP_PRDTINFVO spPrftRes = masSpService.selectBySpPrdtInf(spPrftVO);
			if(spPrftRes != null){
				otoinqVORes.setPrdtNm(spPrftRes.getPrdtNm());
			}
    	}else if(corpInfo.getCorpCd().equals(Constant.SV) ){
			SV_PRDTINFVO svPrdtVO = new SV_PRDTINFVO();
			svPrdtVO.setPrdtNum(otoinqVORes.getPrdtNum());
			svPrdtVO = masSvService.selectBySvPrdtInf(svPrdtVO);
			if(svPrdtVO != null){
				otoinqVORes.setPrdtNm(svPrdtVO.getPrdtNm());
			}
		}
    	
    	USERVO userSVO = new USERVO();
		userSVO.setUserId( otoinqVORes.getWriter() );
		USERVO userVO = ossUserService.selectByUser(userSVO);
		model.addAttribute("userVO", userVO);
			
    	
    	return "/mas/otoinq/detailOtoinq";
    }
    
    
    @RequestMapping("/mas/otoinq/updateOtoinq.do")
    public String updateOtoinq(@ModelAttribute("OTOINQVO") OTOINQVO otoinqVO,
								@ModelAttribute("searchVO") OTOINQSVO otoinqSVO,
    							ModelMap model){
    	//log.info("/mas/otoinq/updateOtoinq.do 호출> " + otoinqVO.getOtoinqNum() );
    	
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	otoinqVO.setCorpId(corpInfo.getCorpId());
    	otoinqSVO.setsCorpId(corpInfo.getCorpId());
    	otoinqSVO.setCorpCd(corpInfo.getCorpCd() );
    	
    	otoinqVO.setAnsWriter(corpInfo.getUserId());
    	otoinqVO.setAnsEmail(corpInfo.getEmail() );
    	otoinqVO.setAnsFrstRegIp(corpInfo.getLastLoginIp());
    	
    	//model.addAttribute("corpCdUp", corpInfo.getCorpCd() );
    	//model.addAttribute("corpCd", corpInfo.getCorpCd().toLowerCase() );
    	
    	ossOtoinqService.updateOtoinqByAnsFrst(otoinqVO);
    	
    	
    	return "redirect:/mas/" + corpInfo.getCorpCd().toLowerCase() + "/detailOtoinq.do?otoinqNum=" + otoinqVO.getOtoinqNum();
    }
    


}
