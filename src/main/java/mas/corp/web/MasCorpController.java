package mas.corp.web;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.corp.vo.DLVCORPVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.corp.service.OssCorpPnsReqService;
import oss.corp.service.OssCorpService;
import oss.corp.vo.*;
import oss.user.vo.USERVO;

import common.Constant;
import common.EgovUserDetailsHelper;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @author 최영철
 * @since  2015. 9. 16.
 * << 개정이력(Modification Information) >>
 *
 *  수정일		수정자		수정내용
 *  -------        --------    ---------------------------
 *  2015-12-11  함경태    업체정보 수정 추가
 */
/**
 * @author user
 *
 */
/**
 * @author user
 *
 */
@Controller
public class MasCorpController {
	
    @Autowired
    private DefaultBeanValidator beanValidator;
    
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
    
    @Resource(name="ossCorpService")
    private OssCorpService ossCorpService;
    
    @Resource(name="ossCmmService")
    private OssCmmService ossCmmService;

	@Resource(name="ossCorpPnsReqService")
	private OssCorpPnsReqService ossCorpPnsReqService;
    
    @Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;
    
    Logger log = LogManager.getLogger(this.getClass());
    
    @RequestMapping("/mas/detailCorp.do")
    public String detailCorp(ModelMap model) {
    	log.info("/mas/detailCorp.do 호출");
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());

    	List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);

    	// B2C 수수료
		List<CMSSVO> cmssList = ossCmmService.selectCmssList();

		// B2B 수수료
		List<CMSSVO> b2bCmssList = ossCmmService.selectB2bCmssList();

		// 업체 기본정보 조회
		CORPVO resultVO = ossCorpService.selectByCorp(corpVO);

		// 입점신청서류
		CORP_PNSREQFILEVO cprfVO = new CORP_PNSREQFILEVO();
		cprfVO.setRequestNum(resultVO.getCorpId());

		List<CORP_PNSREQFILEVO> cprfList = ossCorpPnsReqService.selectCorpPnsReqFileList(cprfVO);

		Map<String, CORP_PNSREQFILEVO> cprfMap = new HashMap<String, CORP_PNSREQFILEVO>();
		for(CORP_PNSREQFILEVO file : cprfList) {
			cprfMap.put(file.getFileNum(), file);
		}

		model.addAttribute("corpCd", corpCdList);
		model.addAttribute("cmssList", cmssList);
		model.addAttribute("b2bCmssList", b2bCmssList);
		model.addAttribute("corpInfo", resultVO);
		model.addAttribute("cprfMap", cprfMap);
		
    	return "/mas/corp/detailCorp";
    }
    
    @RequestMapping("/mas/corpAdtm.do")
    public String corpAdtm(@ModelAttribute("CORPADTMMNGVO") CORPADTMMNGVO corpAdtmMngVO,
						   ModelMap model) {
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	
    	corpAdtmMngVO = ossCorpService.selectCorpAdtmMng(corpVO);
    	
    	model.addAttribute("corpId", corpInfo.getCorpId());
    	model.addAttribute("corpAdtmMngVO", corpAdtmMngVO);
    	
    	return "mas/corp/corpAdtm";
    }
    
    @RequestMapping("/mas/updateCorpAdtm.do")
    public String updateCorpAdtm(@ModelAttribute("CORPADTMMNGVO") CORPADTMMNGVO corpAdtmMngVO,
								 final MultipartHttpServletRequest multiRequest,
								 ModelMap model) throws Exception {
    	log.info("/mas/updateCorpAdtm.do 호출");
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	corpAdtmMngVO.setCorpId(corpInfo.getCorpId());
    	
		Map<String, Object> imgValidateMap = ossFileUtilService.validateImgFile(multiRequest);

		if (!(Boolean) imgValidateMap.get("validateChk")) {
			log.info("이미지 파일 에러");
			model.addAttribute("fileError", imgValidateMap.get("message"));
			return "mas/corp/corpAdtm";
		}
		
		ossCorpService.updateCorpAdtm(corpAdtmMngVO, multiRequest);
		
		return "redirect:/mas/corpAdtm.do";
    }
    
    
    @RequestMapping("/mas/viewUpdateCorp.do")
    public String viewUpdateCorp(@ModelAttribute("MASCORPVO") MASCORPVO corpVO,
								 ModelMap model) {
    	log.info("/mas/viewUpdateCorp.do 호출");
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	
    	corpVO.setCorpId(corpInfo.getCorpId());
    	List<CDVO> corpCdList = ossCmmService.selectCode(Constant.CORP_MOD_CD);
		
		// B2C 수수료
		List<CMSSVO> cmssList = ossCmmService.selectCmssList();

		// B2B 수수료
		List<CMSSVO> b2bCmssList = ossCmmService.selectB2bCmssList();

		// 업체 기본정보 조회
		CORPVO resultVO = ossCorpService.selectByCorp(corpVO);

		// 입점신청서류
		CORP_PNSREQFILEVO cprfVO = new CORP_PNSREQFILEVO();
		cprfVO.setRequestNum(resultVO.getCorpId());

		List<CORP_PNSREQFILEVO> cprfList = ossCorpPnsReqService.selectCorpPnsReqFileList(cprfVO);

		Map<String, CORP_PNSREQFILEVO> cprfMap = new HashMap<String, CORP_PNSREQFILEVO>();
		for(CORP_PNSREQFILEVO file : cprfList) {
			cprfMap.put(file.getFileNum(), file);
		}

		model.addAttribute("corpCd", corpCdList);
		model.addAttribute("cmssList", cmssList);
		model.addAttribute("b2bCmssList", b2bCmssList);
		model.addAttribute("corpInfo", resultVO);
		model.addAttribute("cprfMap", cprfMap);
		
    	return "/mas/corp/updateCorp";
    }   
    	
	/**
	 * <pre>
	 * 파일명 : updateCorp
	 * 작성일 : 2015. 12. 14. 오후 8:44:53
	 * 작성자 : 함경태
	 * @param corpVO
	 * @param multiRequest
	 * @return
	 */
	@RequestMapping("/mas/updateCorp.do")
	public String updateCorp(@ModelAttribute("MASCORPVO") MASCORPVO corpVO,
							 MultipartHttpServletRequest multiRequest) throws Exception {
		log.info("/mas/updateCorp.do 호출");
		// 접속 업체 아이디로 셋팅
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();    	
    	corpVO.setCorpId(corpInfo.getCorpId());
		
		// 업체 기본정보 수정처리
		ossCorpService.updateMasCorp(corpVO, multiRequest);
		
		return "redirect:/mas/detailCorp.do";
	}
    
    @RequestMapping("/mas/detailSpAddInfo.do")
    public String detailSpAddInfo(ModelMap model) {
    	log.info("/mas/detailSpAddInfo.do 호출");
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	CORPVO corpVO = new CORPVO();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	
    	CORPVO resultVO = ossCorpService.selectByCorpSpAddInfo(corpVO);
    	
    	model.addAttribute("corpInfo", resultVO);
    	
    	return "mas/corp/detailSpAddInfo";
    }
    
    @RequestMapping("/mas/viewUpdateSpAddInfo.do")
    public String insertSpAddInfo(@ModelAttribute("CORPVO")  CORPVO corpVO,
    			ModelMap model) {
    	log.info("/oss/viewUpdateSpAddInfo.do 호출");
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	
    	// 업체 기본정보 조회
    	CORPVO resultVO = ossCorpService.selectByCorpSpAddInfo(corpVO);
    	
    	model.addAttribute("corpInfo", resultVO);
    	
    	return "mas/corp/updateSpAddInfo";
    }
    
    @RequestMapping("/mas/updateSpAddInfo.do")
    public String updateSpAddInfo(@ModelAttribute("CORPVO")  CORPVO corpVO,
    			final MultipartHttpServletRequest multiRequest,
    			ModelMap model) throws Exception{
    	log.info("/oss/updateSpAddInfo.do 호출");
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	
		Map<String, Object> imgValidateMap = ossFileUtilService.validateImgFile(multiRequest);

		if (!(Boolean) imgValidateMap.get("validateChk")) {
			log.info("이미지 파일 에러");
			model.addAttribute("fileError", imgValidateMap.get("message"));
			return "mas/corp/updateSpAddInfo";
		}
		
		ossCorpService.updateCorpBySpAddInfo(corpVO, multiRequest);
		
		return "redirect:/mas/detailSpAddInfo.do";
    }
    
    /** 
     * 배송업체 관리
     * @param corpVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/dlvCorpMng.do")
    public String dlvCorpMng(@ModelAttribute("CORPVO")  CORPVO corpVO,
    			ModelMap model) throws Exception{
    	log.info("/oss/dlvCorpMng.do 호출");
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	corpVO.setCorpId(corpInfo.getCorpId());
    	
    	// 배송업체 정보 조회
    	List<DLVCORPVO> dlvCorpList = ossCorpService.selectDlvCorpList(corpVO);
    	
    	model.addAttribute("dlvCorpList", dlvCorpList);
    	
		return "mas/corp/dlvCorpMng";
    }
    
    /** 
     * 배송업체 관리
     * @param corpVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mas/updateDlvCorp.do")
    public String updateDlvCorp(@ModelAttribute("DLVCORPVO")  DLVCORPVO dlvCorpVO,
    			ModelMap model) throws Exception{
    	log.info("/oss/dlvCorpMng.do 호출");
    	
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
    	dlvCorpVO.setCorpId(corpInfo.getCorpId());
    	
    	ossCorpService.updateDlvCorp(dlvCorpVO);
    	
    	
		return "redirect:/mas/dlvCorpMng.do";
    }
}
