package mas.b2b.web;


import java.util.List;

import javax.annotation.Resource;

import mas.b2b.service.MasB2bService;
import mas.b2b.vo.B2B_CORPCONFSVO;
import mas.b2b.vo.B2B_CORPCONFVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpService;
import oss.corp.vo.CORPVO;
import oss.user.vo.USERVO;

import common.Constant;
import common.EgovUserDetailsHelper;

import egovframework.rte.fdl.property.EgovPropertyService;


@Controller
public class MasB2bController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "masB2bService")
	private MasB2bService masB2bService;
	
	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;
	
	@Resource(name = "ossCorpService")
	private OssCorpService ossCorpService;
	
    Logger log = (Logger) LogManager.getLogger(this.getClass());
    
    @RequestMapping("/mas/b2b/intro.do")
    public String b2bIntro(	ModelMap model){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	B2B_CORPCONFSVO corpConfSVO = new B2B_CORPCONFSVO();
    	corpConfSVO.setsCorpId(corpInfo.getCorpId());
    	
    	B2B_CORPCONFVO corpConfVO = masB2bService.selectByB2bInfo(corpConfSVO);
    	
    	if(corpConfVO != null){
    		// 승인인 경우
        	if(Constant.TRADE_STATUS_APPR.equals(corpConfVO.getStatusCd())){
        		return "redirect:/mas/b2b/ctrtCorpList.do";
        	}
    	}
    	
    	model.addAttribute("corpConfVO", corpConfVO);
    	
    	return "mas/b2b/b2bIntro";
    }
    
    @RequestMapping("/mas/b2b/term.do")
    public String b2bTerm(){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	if(Constant.SOCIAL.equals(corpInfo.getCorpCd())){
    		return "mas/b2b/b2bTerm02";
    	}else{
    		return "mas/b2b/b2bTerm01";
    	}
    }
    
    /**
     * B2B 등록
     * 파일명 : b2bReq
     * 작성일 : 2016. 9. 6. 오전 11:44:31
     * 작성자 : 최영철
     * @return
     */
    @RequestMapping("/mas/b2b/b2bReq.do")
    public String b2bReq(){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	B2B_CORPCONFVO corpConfVO = new B2B_CORPCONFVO();
    	corpConfVO.setCorpId(corpInfo.getCorpId());
    	corpConfVO.setFrstRegId(corpInfo.getUserId());
    	
    	if(Constant.SOCIAL.equals(corpInfo.getCorpCd())){
        	// TRADE_STATUS_APPR_REQ(TS02, 승인요청)
        	corpConfVO.setStatusCd(Constant.TRADE_STATUS_APPR_REQ);
        	masB2bService.insertB2bReq(corpConfVO);
        	
        	return "redirect:/mas/b2b/intro.do";
    	}
    	// 개별 업체인경우 즉시 승인
    	else{
    		// TRADE_STATUS_APPR(TS03, 승인)
        	corpConfVO.setStatusCd(Constant.TRADE_STATUS_APPR);
        	masB2bService.insertB2bReq(corpConfVO);
        	
        	// B2B 사용여부 승인 처리
        	CORPVO corpVO = new CORPVO();
        	corpVO.setCorpId(corpInfo.getCorpId());
        	corpVO.setB2bUseYn(Constant.FLAG_Y);
        	
        	masB2bService.updateB2bUseCorp(corpVO);
    	}
    	
    	return "redirect:/mas/b2b/intro.do";
    }
    
    /**
     * B2B 재승인 요청
     * 파일명 : b2bReReq
     * 작성일 : 2016. 9. 9. 오전 10:35:34
     * 작성자 : 최영철
     * @return
     */
    @RequestMapping("/mas/b2b/b2bReReq.do")
    public String b2bReReq(){
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	B2B_CORPCONFVO corpConfVO = new B2B_CORPCONFVO();
    	corpConfVO.setCorpId(corpInfo.getCorpId());
    	corpConfVO.setLastModId(corpInfo.getUserId());
    	// TRADE_STATUS_APPR_REQ(TS02, 승인요청)
    	corpConfVO.setStatusCd(Constant.TRADE_STATUS_APPR_REQ);
    	
    	masB2bService.updateB2bReReq(corpConfVO);
    	
    	return "redirect:/mas/b2b/intro.do";
    }
    
    @RequestMapping("/mas/b2b/detailCorp.do")
	public String dtlCorp(	@ModelAttribute("CORPVO") CORPVO corpVO,
							ModelMap model){
		
		// 업체 계약상태 코드 목록
		List<CDVO> tradeStateCdList = ossCmmService.selectCode(Constant.TRADE_STATUS);
		model.addAttribute("tradeStateCd", tradeStateCdList);
		
		// 업체구분 코드 목록
		List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);		
		model.addAttribute("corpCd", corpCdList);
		
		// 업체 기본정보 조회
		CORPVO resultVO = ossCorpService.selectByCorp(corpVO);
		
		model.addAttribute("corpInfo", resultVO);
		return "mas/b2b/detailCorp";
	}
}
