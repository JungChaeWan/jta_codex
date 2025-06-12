package mas.sp.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mas.rsv.service.MasRsvService;
import mas.sp.service.MasSpService;
import mas.sp.vo.SP_ADDOPTINFVO;
import mas.sp.vo.SP_DIVINFVO;
import mas.sp.vo.SP_OPTINFSVO;
import mas.sp.vo.SP_OPTINFVO;
import mas.sp.vo.SP_PRDTINFSVO;
import mas.sp.vo.SP_PRDTINFVO;

import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssExcelService;
import oss.cmm.service.OssFileUtilService;
import oss.user.vo.USERVO;
import web.order.vo.SP_RSVVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.EgovMessageSource;
import egovframework.cmmn.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping("/mas/sp")
public class MasSpPrdtOptionController {
	@Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "masSpService")
	private MasSpService masSpService;

	@Resource(name="masRsvService")
    private MasRsvService masRsvService;

	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name = "ossExcelService")
	private OssExcelService ossExcelService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	/**
	 * 옵션 View
	 * @param sp_OPTINFVO
	 * @param sp_DIVINFVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/viewOption.do")
	public String viewOption(
			@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO,
			@ModelAttribute("SP_DIVINFVO") SP_DIVINFVO sp_DIVINFVO,
			@ModelAttribute("searchVO") SP_OPTINFSVO sp_OPTINFSVO,
			ModelMap model) {
		log.info("/mas/sp/viewOption.do call");
		SP_PRDTINFVO sp_PRDTINFVO = new SP_PRDTINFVO();
		sp_PRDTINFVO.setPrdtNum(sp_OPTINFVO.getPrdtNum());
		SP_PRDTINFVO spPrdtInfVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);

		List<SP_OPTINFVO> resultList = masSpService.selectPrdtOptionList(sp_OPTINFVO);
		model.addAttribute("resultList", resultList);

		model.addAttribute("spPrdtInf", spPrdtInfVO);
		model.addAttribute("btnApproval", masSpService.btnApproval(spPrdtInfVO));

		List<SP_OPTINFVO> spTourDivList = masSpService.selectTourDivList(sp_OPTINFVO);
		model.addAttribute("spTourDivList",spTourDivList);

		return "mas/sp/manageOption";
	}

	/**
	 * 구분자 정보 INSERT
	 * @param sp_DIVINFVO
	 * @param bindingResult
	 * @param model
	 * @return
	 */
	@RequestMapping("/insertSocialDivInf.do")
	public String insertSocialDivInf(
			@ModelAttribute("SP_DIVINFVO") SP_DIVINFVO sp_DIVINFVO,
			BindingResult bindingResult,
			ModelMap model) {
		log.info("/mas/sp/insertSocialDivInf.do call");
		// validation 체크
		beanValidator.validate(sp_DIVINFVO, bindingResult);

		if (bindingResult.hasErrors()) {
			log.info("error");
			model.addAttribute("spDivInf", sp_DIVINFVO);
			log.info(bindingResult.toString());
			return "mas/sp/manageOption";
		}

		Integer maxViewSn = masSpService.selectDivInfMaxViewSn(sp_DIVINFVO);
		sp_DIVINFVO.setOldSn(String.valueOf(maxViewSn + 1));
		sp_DIVINFVO.setNewSn(sp_DIVINFVO.getViewSn());

		if(maxViewSn + 1 > Integer.parseInt(sp_DIVINFVO.getViewSn())){
			// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
			masSpService.addDivViewSn(sp_DIVINFVO);
		}
		masSpService.insertSpDivInf(sp_DIVINFVO);

		return "redirect:/mas/sp/viewOption.do?prdtNum="+sp_DIVINFVO.getPrdtNum() + "&pageIndex=" + sp_DIVINFVO.getPageIndex();
	}

	/**
	 * 옵션 정보 INSERT
	 * @param sp_OPTINFVO
	 * @param bindingResult
	 * @param sp_OPTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/insertSocialOption.do")
	public String insertSocialOption(
			@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO,
			BindingResult bindingResult,
			ModelMap model) {
		log.info("/mas/insertSocialOption.do call");

		// validation 체크
		beanValidator.validate(sp_OPTINFVO, bindingResult);

		if (bindingResult.hasErrors()) {
			log.info("error");
			model.addAttribute("spOptInfo", sp_OPTINFVO);
			log.info(bindingResult.toString());
			return "mas/sp/manageOption";
		}

		Integer maxViewSn = masSpService.selectOptInfMaxViewSn(sp_OPTINFVO);
		sp_OPTINFVO.setOldSn(String.valueOf(maxViewSn + 1));
		sp_OPTINFVO.setNewSn(sp_OPTINFVO.getViewSn());

		if(maxViewSn + 1 > Integer.parseInt(sp_OPTINFVO.getViewSn())){
			// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
			masSpService.addOptViewSn(sp_OPTINFVO);
		}

		if(EgovStringUtil.isEmpty(sp_OPTINFVO.getDdlYn())){
			sp_OPTINFVO.setDdlYn(Constant.FLAG_N);
		}
		// 업체 옵션정보 등록 처리
		masSpService.insertSpOptInf(sp_OPTINFVO);

		return "redirect:/mas/sp/viewOption.do?prdtNum="+sp_OPTINFVO.getPrdtNum() + "&pageIndex=" + sp_OPTINFVO.getPageIndex();
	}

	@RequestMapping("/updateSocialDivInf.do")
	public String updateSocialDivInf(@ModelAttribute("SP_DIVINFVO") SP_DIVINFVO sp_DIVINFVO,
			BindingResult bindingResult,
			ModelMap model) {
		log.info("/mas/sp/updateSocialDivInf.do call");

		// validation 체크
		beanValidator.validate(sp_DIVINFVO, bindingResult);

		if (bindingResult.hasErrors()) {
			log.info("error");
			model.addAttribute("spDivInf", sp_DIVINFVO);
			log.info(bindingResult.toString());
			return "mas/sp/manageOption";
		}
		SP_DIVINFVO oldVO = masSpService.selectSpDivInf(sp_DIVINFVO);

		oldVO.setOldSn(oldVO.getViewSn());
		oldVO.setNewSn(sp_DIVINFVO.getViewSn());

		// 노출 순서가 변경되었을 경우에만 실행
		if(!oldVO.getNewSn().equals(oldVO.getOldSn())){
			if(Integer.parseInt(oldVO.getViewSn()) > Integer.parseInt(sp_DIVINFVO.getViewSn())){
				// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
				masSpService.addDivViewSn(oldVO);
			}else{
				masSpService.minusDivViewSn(oldVO);
			}
		}
		masSpService.updateSpDivInf(sp_DIVINFVO);

		return "redirect:/mas/sp/viewOption.do?prdtNum="+sp_DIVINFVO.getPrdtNum() + "&pageIndex=" + sp_DIVINFVO.getPageIndex();
	}

	/**
	 * 옵션 수정하기
	 * @param sp_OPTINFVO
	 * @param bindingResult
	 * @param model
	 * @return
	 */
	@RequestMapping("/updateSocialOptInf.do")
	public String updateSocialOptInf(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO,
			BindingResult bindingResult,
			ModelMap model) {
		log.info("/mas/sp/updateSocialOptInf.do call");

		// validation 체크
		beanValidator.validate(sp_OPTINFVO, bindingResult);

		if (bindingResult.hasErrors()) {
			log.info("error");
			model.addAttribute("spOptInf", sp_OPTINFVO);
			log.info(bindingResult.toString());
			return "mas/sp/manageOption";
		}
		SP_OPTINFVO oldVO = masSpService.selectSpOptInf(sp_OPTINFVO);

		oldVO.setOldSn(oldVO.getViewSn());
		oldVO.setNewSn(sp_OPTINFVO.getViewSn());

		// 노출 순서가 변경되었을 경우에만 실행
		if(!oldVO.getNewSn().equals(oldVO.getOldSn())){
			if(Integer.parseInt(oldVO.getViewSn()) > Integer.parseInt(sp_OPTINFVO.getViewSn())){
				// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
				masSpService.addOptViewSn(oldVO);
			}else{
				masSpService.minusOptViewSn(oldVO);
			}
		}
		masSpService.updateSpOptInf(sp_OPTINFVO);

		return "redirect:/mas/sp/viewOption.do?prdtNum="+sp_OPTINFVO.getPrdtNum() + "&pageIndex=" + sp_OPTINFVO.getPageIndex();
	}

	/**
	 * 구분자 삭제
	 * @param sp_DIVINFVO
	 * @return
	 */
	@RequestMapping("/deleteSocialDivInf.do")
	public String deleteSocialDivInf(@ModelAttribute("SP_DIVINFVO") SP_DIVINFVO sp_DIVINFVO) {
		log.info("/mas/sp/deleteSocialDivInf.do call");
		SP_OPTINFVO sp_OPTINFVO = new SP_OPTINFVO();
		sp_OPTINFVO.setPrdtNum(sp_DIVINFVO.getPrdtNum());
		sp_OPTINFVO.setSpDivSn(sp_DIVINFVO.getSpDivSn());

		List<SP_OPTINFVO> optionList = masSpService.selectPrdtOptionList(sp_OPTINFVO);
		String pageIndex = sp_DIVINFVO.getPageIndex();
		
		if(optionList != null) {
			masSpService.deleteSpOptInf(sp_OPTINFVO);
		}
		sp_DIVINFVO = masSpService.selectSpDivInf(sp_DIVINFVO);
		// 우선 순위 수정.
		sp_DIVINFVO.setOldSn(sp_DIVINFVO.getViewSn());

		masSpService.minusDivViewSn(sp_DIVINFVO);

		masSpService.deleteSpDivInf(sp_DIVINFVO);

		return "redirect:/mas/sp/viewOption.do?prdtNum=" + sp_DIVINFVO.getPrdtNum() + "&pageIndex=" + pageIndex;
	}

	/**
	 * 옵션 삭제.
	 * @param sp_OPTINFVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/deleteSocialOptInf.do")
	public String deleteSocialOptInf(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO,
			@ModelAttribute("searchVO") SP_OPTINFSVO sp_OPTINFSVO,
			ModelMap model ) {
		log.info("/mas/sp/deleteSocialDivInf.do call");

		sp_OPTINFVO = masSpService.selectSpOptInf(sp_OPTINFVO);
		// 우선 순위 수정.
		sp_OPTINFVO.setOldSn(sp_OPTINFVO.getViewSn());

		masSpService.minusOptViewSn(sp_OPTINFVO);

		masSpService.deleteSpOptInf(sp_OPTINFVO);

		return "redirect:/mas/sp/viewOption.do?prdtNum=" + sp_OPTINFVO.getPrdtNum() + "&pageIndex=" + sp_OPTINFSVO.getPageIndex();
	}

	/**
	 * 선택된 옵션 삭제처리
	 * @param sp_OPTINFVO
	 * @return
	 */
	@RequestMapping("/selDeleteSocialOptInf.ajax")
	public ModelAndView selDeleteSocialOptInf(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO) {
    	log.info("/mas/sp/selDeleteSocialOptInf.ajax call");

    	Map<String, Object> resultMap = new HashMap<String,Object>();

    	String selOptList[] = sp_OPTINFVO.getSelOptList().get(0).split(",");
    	for (String selOpt : selOptList) {
    		String selOptArr[] = selOpt.split("_");

    		// 예약 건수 확인
    		SP_RSVVO spRsvVO = new SP_RSVVO();
    		spRsvVO.setPrdtNum(sp_OPTINFVO.getPrdtNum());
    		spRsvVO.setSpDivSn(selOptArr[0]);
    		spRsvVO.setSpOptSn(selOptArr[1]);
    		List<SP_RSVVO> resultList = masRsvService.selectSpRsvList2(spRsvVO);

        	if(resultList.size() > 0){	// 예약건이 있으면
        		resultMap.put("chkVal", "N");
        		break;
        	}else{
        		// 정보 확인
        		sp_OPTINFVO.setSpDivSn(Integer.parseInt(selOptArr[0]));
        		sp_OPTINFVO.setSpOptSn(Integer.parseInt(selOptArr[1]));

        		sp_OPTINFVO = masSpService.selectSpOptInf(sp_OPTINFVO);

        		// 우선 순위 수정.
        		sp_OPTINFVO.setOldSn(sp_OPTINFVO.getViewSn());
        		masSpService.minusOptViewSn(sp_OPTINFVO);

        		// 옵션 삭제
        		masSpService.deleteSpOptInf(sp_OPTINFVO);
        	}
    	}

    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

    	return modelAndView;
	}

	@RequestMapping("/selDeleteSocialAllOptInf.ajax")
	public ModelAndView selDeleteSocialAllOptInf(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO) {
    	log.info("/mas/sp/selDeleteSocialAllOptInf.ajax call");

    	Map<String, Object> resultMap = new HashMap<String,Object>();

    	masSpService.deleteSpAllOptInf(sp_OPTINFVO);

    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

    	return modelAndView;
	}

	/**
	 * 구분자 수정시 정보가져오기
	 * @param sp_DIVINFVO
	 * @return
	 */
	@RequestMapping("/viewUpdateSpDivinf.ajax")
	public ModelAndView viewUpdateSpDivinf(@ModelAttribute("SP_DIVINFVO") SP_DIVINFVO sp_DIVINFVO) {
    	SP_DIVINFVO  spDivInfVO = masSpService.selectSpDivInf(sp_DIVINFVO);

    	Integer maxViewSn = masSpService.selectDivInfMaxViewSn(sp_DIVINFVO);

    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	resultMap.put("spDivInfVO", spDivInfVO);
    	resultMap.put("maxViewSn", maxViewSn);

    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

    	return modelAndView;
	}

	/**
	 * 옵션 수정시 정보가져오기
	 * @param sp_OPTINFVO
	 * @return
	 */
	@RequestMapping("/viewUpdateSpOptinf.ajax")
	public ModelAndView viewUpdateSpOptinf(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO) {
    	log.info("/mas/sp/viewUpdateSpOptinf.ajax call");
    	log.info(sp_OPTINFVO.getPrdtNum());

    	SP_OPTINFVO  spOptInfVO = masSpService.selectSpOptInf(sp_OPTINFVO);

    	Integer maxViewSn = masSpService.selectOptInfMaxViewSn(sp_OPTINFVO);

    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	resultMap.put("spOptInfVO", spOptInfVO);
    	resultMap.put("maxViewSn", maxViewSn);

    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

    	return modelAndView;
	}

	/**
	 * 구분자 정렬순서 max 값 가져오기
	 * @param sp_DIVINFVO
	 * @return
	 */
	@RequestMapping("/getDivMaxViewSn.ajax")
	public ModelAndView getDivMaxViewSn(@ModelAttribute("SP_DIVINFVO") SP_DIVINFVO sp_DIVINFVO) {

    	Integer maxViewSn = masSpService.selectDivInfMaxViewSn(sp_DIVINFVO);

    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	resultMap.put("maxViewSn", maxViewSn);

    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

    	return modelAndView;
	}

	/**
	 * 정렬순서 max 값 가져오기
	 * @param sp_OPTINFVO
	 * @return
	 */
	@RequestMapping("/getOptMaxViewSn.ajax")
	public ModelAndView getOptMaxViewSn(@ModelAttribute("SP_OPTINFVO") SP_OPTINFVO sp_OPTINFVO) {
    	Integer maxViewSn = masSpService.selectOptInfMaxViewSn(sp_OPTINFVO);

    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	resultMap.put("maxViewSn", maxViewSn);

    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

    	return modelAndView;
	}


	/**
	 * 옵션 일괄등록
	 * @param sp_OPTINFVO
	 * @param bindingResult
	 * @param sp_OPTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/insertBatchSpOption.do")
	public String insertBatchSpOption(
			@ModelAttribute("SP_BatchOpt") SP_OPTINFVO sp_OPTINFVO,
			BindingResult bindingResult,
			@ModelAttribute("searchVO") SP_OPTINFSVO sp_OPTINFSVO,
			ModelMap model) {
		log.info("/mas/insertBatchSpOption.ajax call");

		// validation 체크
		beanValidator.validate(sp_OPTINFVO, bindingResult);

		if (bindingResult.hasErrors()) {
			log.info("error");
			model.addAttribute("spOptInfo", sp_OPTINFVO);
			log.info(bindingResult.toString());
			return "mas/sp/manageOption";
		}

		Integer maxViewSn = masSpService.selectOptInfMaxViewSn(sp_OPTINFVO);
		sp_OPTINFVO.setOldSn(String.valueOf(maxViewSn));

		if(EgovStringUtil.isEmpty(sp_OPTINFVO.getDdlYn())){
			sp_OPTINFVO.setDdlYn(Constant.FLAG_N);
		}
		// 업체 옵션정보 등록 처리
		masSpService.insertBatchSpOptInf(sp_OPTINFVO);

		return "redirect:/mas/sp/viewOption.do?prdtNum="+sp_OPTINFVO.getPrdtNum() + "&pageIndex=" + sp_OPTINFVO.getPageIndex();
	}

	/**
	 * 옵션 일괄수정
	 * @param sp_OPTINFVO
	 * @param sp_OPTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/updateBatchSpOption.ajax")
	public ModelAndView updateBatchSpOption(
			@ModelAttribute("SP_BatchOpt") SP_OPTINFVO sp_OPTINFVO,
			@ModelAttribute("searchVO") SP_OPTINFSVO sp_OPTINFSVO,
			ModelMap model) {
		log.info("/mas/insertBatchSpOption.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();
		// 업체 옵션정보 등록 처리
		int updateCnt = masSpService.updateBatchSpOptInf(sp_OPTINFVO);

		resultMap.put("updateCnt", updateCnt);

    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

    	return modelAndView;
		//return "redirect:/mas/sp/viewOption.do?prdtNum="+sp_OPTINFVO.getPrdtNum();
	}

	/**
	 * 엑셀 일괄등록
	 * @param sp_OPTINFVO
	 * @param deleteOpt
	 * @param multiRequest
	 * @return
	 */
/*	@RequestMapping(value="/insertExcelSpOption.ajax",produces = MediaType.TEXT_PLAIN_VALUE)
	public @ResponseBody Map<String, Object> insertExcelSpOption(@ModelAttribute("SP_OTPINFVO") SP_OPTINFVO sp_OPTINFVO,
																 @RequestParam("deleteOpt") String deleteOpt,
																 final MultipartHttpServletRequest multiRequest) {
		log.info("/mas/insertExcelSpOption.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		try {
			resultMap = masSpService.insertExcelSpOption(sp_OPTINFVO, multiRequest, deleteOpt);
		} catch (Exception e) {
			resultMap.put("RESULT", Constant.JSON_FAIL);
			log.error(e.getMessage());
		}
		return resultMap;
	}*/

	/**
	 * 설명 : 옵션 엑셀 일괄등록.
	 * 파일명 : insertExcelSpOption
	 * 작성일 : 2024-07-08 오후 3:20
	 * 작성자 : chaewan.jung
	 * @param : [excelUpFile, deleteOpt, prdtNum]
	 * @return : java.util.Map<java.lang.String,java.lang.Object>
	 * @throws Exception
	 */
	@RequestMapping(value="/insertExcelSpOption.ajax",produces = MediaType.TEXT_PLAIN_VALUE)
	public @ResponseBody Map<String, Object> insertExcelSpOption(@RequestParam("excelFile") MultipartFile excelUpFile,
																 @RequestParam("deleteOpt") String deleteOpt,
																 SP_OPTINFVO sp_OPTINFVO) {
		log.info("/mas/insertExcelSpOption.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		try {
			//확장자에 따라 분리
			String extension = FilenameUtils.getExtension(excelUpFile.getOriginalFilename());
			Workbook workbook = null;
			if (extension.equals("xlsx")) {
				workbook = new XSSFWorkbook(excelUpFile.getInputStream());
			} else if (extension.equals("xls")) {
				workbook = new HSSFWorkbook(excelUpFile.getInputStream());
			}

			resultMap = masSpService.insertExcelSpOption(workbook, excelUpFile, deleteOpt, sp_OPTINFVO);
		} catch (Exception e) {
			resultMap.put("RESULT", Constant.JSON_FAIL);
			log.error(e.getMessage());
		}
		return resultMap;
	}

	@RequestMapping("/viewAddOption.do")
	public String viewAddOption(
			@ModelAttribute("SP_ADDOPTINFVO") SP_ADDOPTINFVO sp_ADDOPTINFVO,
			@ModelAttribute("searchVO") SP_OPTINFSVO sp_OPTINFSVO,
			ModelMap model) {
		log.info("/mas/sp/viewAddOption.do call");
		SP_PRDTINFVO sp_PRDTINFVO = new SP_PRDTINFVO();
		sp_PRDTINFVO.setPrdtNum(sp_ADDOPTINFVO.getPrdtNum());
		SP_PRDTINFVO spPrdtInfVO = masSpService.selectBySpPrdtInf(sp_PRDTINFVO);

		List<SP_ADDOPTINFVO> resultList = masSpService.selectPrdtAddOptionList(sp_ADDOPTINFVO);
		model.addAttribute("resultList", resultList);

		model.addAttribute("spPrdtInf", spPrdtInfVO);
		model.addAttribute("btnApproval", masSpService.btnApproval(spPrdtInfVO));

		return "mas/sp/manageAddOption";
	}

	/**
	 * 추가옵션 정렬순서 max 값.
	 * @param sp_ADDOPTINFVO
	 * @return
	 */
	@RequestMapping("/getAddOptMaxViewSn.ajax")
	public ModelAndView getAddOptMaxViewSn(@ModelAttribute("SP_ADDOPTINFVO") SP_ADDOPTINFVO sp_ADDOPTINFVO) {

    	Integer maxViewSn = masSpService.selectAddOptInfMaxViewSn(sp_ADDOPTINFVO);

    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	resultMap.put("maxViewSn", maxViewSn);

    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

    	return modelAndView;
	}

	/**
	 * 추가 옵션 등록
	 * @param sp_ADDOPTINFVO
	 * @param bindingResult
	 * @param sp_OPTINFSVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/insertAddOption.do")
	public String insertAddOption(
			@ModelAttribute("SP_ADDOPTINFVO") SP_ADDOPTINFVO sp_ADDOPTINFVO,
			BindingResult bindingResult,
			ModelMap model) {
		log.info("/mas/insertAddOption.do call");

		// validation 체크
		beanValidator.validate(sp_ADDOPTINFVO, bindingResult);

		if (bindingResult.hasErrors()) {
			log.info("error");
			model.addAttribute("spOptInfo", sp_ADDOPTINFVO);
			log.info(bindingResult.toString());
			return "mas/sp/manageAddOption";
		}

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_ADDOPTINFVO.setFrstRegId(corpInfo.getUserId());
		sp_ADDOPTINFVO.setLastModId(corpInfo.getUserId());

		Integer maxViewSn = masSpService.selectAddOptInfMaxViewSn(sp_ADDOPTINFVO);
		sp_ADDOPTINFVO.setOldSn(String.valueOf(maxViewSn + 1));
		sp_ADDOPTINFVO.setNewSn(sp_ADDOPTINFVO.getViewSn());

		if(maxViewSn + 1 > Integer.parseInt(sp_ADDOPTINFVO.getViewSn())){
			// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
			masSpService.addAddOptViewSn(sp_ADDOPTINFVO);
		}

		// 업체 추가옵션정보 등록 처리
		masSpService.insertSpAddOptInf(sp_ADDOPTINFVO);

		return "redirect:/mas/sp/viewAddOption.do?prdtNum="+sp_ADDOPTINFVO.getPrdtNum() + "&pageIndex=" + sp_ADDOPTINFVO.getPageIndex();
	}

	/**
	 * 추가옵션 수정화면
	 * @param sp_ADDOPTINFVO
	 * @return
	 */
	@RequestMapping("/viewUpdateAddOpt.ajax")
	public ModelAndView viewUpdateAddOpt(@ModelAttribute("SP_ADDOPTINFVO") SP_ADDOPTINFVO sp_ADDOPTINFVO) {
    	log.info(" viewUpdateAddOpt.ajax call");
    	log.info(sp_ADDOPTINFVO.getPrdtNum());

    	SP_ADDOPTINFVO  spOptInfVO = masSpService.selectSpAddOptInf(sp_ADDOPTINFVO);

    	Integer maxViewSn = masSpService.selectAddOptInfMaxViewSn(sp_ADDOPTINFVO);

    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	resultMap.put("spOptInfVO", spOptInfVO);
    	resultMap.put("maxViewSn", maxViewSn);

    	ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

    	return modelAndView;
	}

	/**
	 * 추가옵션 수정
	 * @param sp_ADDOPTINFVO
	 * @param bindingResult
	 * @param model
	 * @return
	 */
	@RequestMapping("/updateAddOption.do")
	public String updateAddOption(@ModelAttribute("SP_ADDOPTINFVO") SP_ADDOPTINFVO sp_ADDOPTINFVO,
			BindingResult bindingResult,
			ModelMap model) {
		log.info("/mas/sp/updateAddOption.do call");

		// validation 체크
		beanValidator.validate(sp_ADDOPTINFVO, bindingResult);

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_ADDOPTINFVO.setLastModId(corpInfo.getUserId());

		if (bindingResult.hasErrors()) {
			log.info("error");
			model.addAttribute("spOptInf", sp_ADDOPTINFVO);
			log.info(bindingResult.toString());
			return "mas/sp/manageAddOption";
		}
		SP_ADDOPTINFVO oldVO = masSpService.selectSpAddOptInf(sp_ADDOPTINFVO);

		oldVO.setOldSn(oldVO.getViewSn());
		oldVO.setNewSn(sp_ADDOPTINFVO.getViewSn());
		oldVO.setLastModId(corpInfo.getUserId());
		// 노출 순서가 변경되었을 경우에만 실행
		if(!oldVO.getNewSn().equals(oldVO.getOldSn())){
			if(Integer.parseInt(oldVO.getViewSn()) > Integer.parseInt(sp_ADDOPTINFVO.getViewSn())){
				// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
				masSpService.addAddOptViewSn(oldVO);
			}else{
				masSpService.minusAddOptViewSn(oldVO);
			}
		}
		masSpService.updateSpAddOptInf(sp_ADDOPTINFVO);

		return "redirect:/mas/sp/viewAddOption.do?prdtNum="+sp_ADDOPTINFVO.getPrdtNum() + "&pageIndex=" + sp_ADDOPTINFVO.getPageIndex();
	}

	/**
	 * 추가 옵션 삭제.
	 * @param sp_ADDOPTINFVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/deleteAddOpt.do")
	public String deleteAddOpt(@ModelAttribute("SP_ADDOPTINFVO") SP_ADDOPTINFVO sp_ADDOPTINFVO,
			ModelMap model ) {
		log.info("/mas/sp/deleteAddOpt.do call");

		String pageIndex = sp_ADDOPTINFVO.getPageIndex();
		sp_ADDOPTINFVO = masSpService.selectSpAddOptInf(sp_ADDOPTINFVO);

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		sp_ADDOPTINFVO.setLastModId(corpInfo.getUserId());

		// 우선 순위 수정.
		sp_ADDOPTINFVO.setOldSn(sp_ADDOPTINFVO.getViewSn());
		masSpService.minusAddOptViewSn(sp_ADDOPTINFVO);

		masSpService.deleteAddOptInf(sp_ADDOPTINFVO);

		return "redirect:/mas/sp/viewAddOption.do?prdtNum="+sp_ADDOPTINFVO.getPrdtNum() + "&pageIndex=" + pageIndex;
	}
}
