package mas.prmt.web;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.AD_PRDTINFVO;
import mas.prmt.service.MasPrmtService;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import mas.rc.service.MasRcPrdtService;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.sp.service.MasSpService;
import mas.sp.vo.SP_PRDTINFVO;
import mas.sv.service.MasSvService;
import mas.sv.vo.SV_PRDTINFVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.prmt.vo.PRMTFILEVO;
import oss.user.vo.USERVO;

@Controller
public class MasPrmtController {
	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name = "masPrmtService")
	private MasPrmtService masPrmtService;

	@Resource(name="masSpService")
	private MasSpService masSpService;

	@Resource(name="masRcPrdtService")
	private MasRcPrdtService masRcPrdtService;

	@Resource(name="masAdPrdtService")
	private MasAdPrdtService masAdPrdtService;

	@Resource(name="masSvService")
	private MasSvService masSvService;

	@Resource(name="ossCmmService")
	private OssCmmService ossCmmService;

	@RequestMapping("/mas/prmt/promotionList.do")
	public String prmtList(@ModelAttribute("searchVO") PRMTVO prmtVO,
			ModelMap model) {
		log.info("/mas/prmt/promotionList.do call");

		prmtVO.setPageUnit(propertiesService.getInt("pageUnit"));
		prmtVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(prmtVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(prmtVO.getPageUnit());
		paginationInfo.setPageSize(prmtVO.getPageSize());

		prmtVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		prmtVO.setLastIndex(paginationInfo.getLastRecordIndex());
		prmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// CORP_ID set
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		prmtVO.setCorpId(corpInfo.getCorpId());

		Map<String, Object> resultMap = masPrmtService.selectPrmtList(prmtVO);

		@SuppressWarnings("unchecked")
		List<SP_PRDTINFVO> resultList = (List<SP_PRDTINFVO>) resultMap.get("resultList");

		// 총 건수 셋팅
		paginationInfo.setTotalRecordCount((Integer) resultMap.get("totalCnt"));

		model.addAttribute("resultList", resultList);
		model.addAttribute("totalCnt", resultMap.get("totalCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "mas/prmt/promotionList";
	}

	/**
	 * 프로모션 등록 view
	 * @param prmtVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/mas/prmt/viewInsertPromotion.do")
	public String viewInsertPromotion(@ModelAttribute("PRMTVO") PRMTVO prmtVO,
									  ModelMap model) {
		log.info("/mas/prmt/viewInsertPromotion.do call");

		// 프로모션 구분 코드
		List<CDVO> cdList = ossCmmService.selectCode(Constant.PRMT_DIV_CD);

		model.addAttribute("prmtCdList", cdList);

		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

		return "mas/prmt/insertPromotion";
	}

	@RequestMapping("/mas/prmt/insertPromotion.do")
	public String insertPromotion(@ModelAttribute("prmtVO") PRMTVO prmtVO,
								  final MultipartHttpServletRequest multiRequest) throws Exception {
		log.info("/mas/prmt/insertPromotion.do call");

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		prmtVO.setCorpId(corpInfo.getCorpId());
		prmtVO.setFrstRegId(corpInfo.getUserId());
		prmtVO.setFrstRegIp(corpInfo.getLastLoginIp());
		prmtVO.setCorpCd(corpInfo.getCorpCd());

		String prmtNum = masPrmtService.insertPromotion(prmtVO, multiRequest, "mas");

		List<String> prdtNumList = prmtVO.getPrdtNum();

		if(prdtNumList != null && prdtNumList.size() > 0) {
			prmtVO.setPrmtNum(prmtNum);

			masPrmtService.insertPrmtPrdt(prmtVO);
		}
		return "redirect:/mas/prmt/promotionList.do";
	}

	@RequestMapping("/mas/prmt/viewSelectProduct.ajax")
	public String viewSelectProduct(ModelMap model) {
		log.info("/mas/prmt/viewSelectProduct.ajax call");
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		if(Constant.SOCIAL.equals(corpInfo.getCorpCd())) {
			SP_PRDTINFVO sp_PRDTINFVO = new SP_PRDTINFVO();
			sp_PRDTINFVO.setCorpId(corpInfo.getCorpId());
			List<SP_PRDTINFVO> resultList = masSpService.selectPrmtProductList(sp_PRDTINFVO);
			model.addAttribute("resultList", resultList);
			return "mas/prmt/spProductLayer";
		}else if(Constant.RENTCAR.equals(corpInfo.getCorpCd())){
			RC_PRDTINFSVO rcSVO = new RC_PRDTINFSVO();
			rcSVO.setsCorpId(corpInfo.getCorpId());
			rcSVO.setsTradeStatus("TS03");
			List<RC_PRDTINFVO> resultList = masRcPrdtService.selectPrdtList(rcSVO);
			model.addAttribute("resultList", resultList);
			return "mas/prmt/rcProductLayer";
		}else if(Constant.ACCOMMODATION.equals(corpInfo.getCorpCd())){
			AD_PRDTINFVO ad_PRDINFSVO = new AD_PRDTINFVO();
	    	ad_PRDINFSVO.setCorpId(corpInfo.getCorpId());
	    	List<AD_PRDTINFVO> adPrdtList = masAdPrdtService.selectAdPrdinfListOfRT(ad_PRDINFSVO);
	    	model.addAttribute("resultList", adPrdtList);
			return "mas/prmt/adProductLayer";

		} else if(Constant.SV.equals(corpInfo.getCorpCd())) {
			SV_PRDTINFVO sv_PRDTINFVO = new SV_PRDTINFVO();
			sv_PRDTINFVO.setCorpId(corpInfo.getCorpId());
			List<SV_PRDTINFVO> resultList = masSvService.selectPrmtProductList(sv_PRDTINFVO);
			model.addAttribute("resultList", resultList);
			return "mas/prmt/svProductLayer";
		}

		return "mas/prmt/spProductLayer";
	}

	@RequestMapping("/mas/prmt/viewUpdatePromotion.do")
	public String viewUpdatePromotion(@ModelAttribute("PRMTVO") PRMTVO prmtVO,
									  ModelMap model) {
		log.info("/mas/prmt/viewUpdatePromotion.ajax call");
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		prmtVO.setCorpCd(corpInfo.getCorpCd());
		prmtVO.setCorpId(corpInfo.getCorpId());
		// 프로모션 정보가져오기
		PRMTVO resultVO = masPrmtService.selectByPrmt(prmtVO);

		model.addAttribute("prmtVO", resultVO);

		//첨부파일 정보 가저오기
		PRMTFILEVO prmtfileVO = new PRMTFILEVO();
		prmtfileVO.setPrmtNum(prmtVO.getPrmtNum());
		List<PRMTFILEVO> prmtFileList = masPrmtService.selectPrmtFileList(prmtfileVO);
		model.addAttribute("prmtFileList", prmtFileList);

		// 등록중, 승인요청, 수정요청 ,(20.05.13 추가내용: 승인) 상태가 아니라면 detail 페이지로 이동. 
		if(!(Constant.TRADE_STATUS_REG.equals(resultVO.getStatusCd())
				|| Constant.TRADE_STATUS_APPR_REQ.equals(resultVO.getStatusCd())
				|| Constant.TRADE_STATUS_EDIT.equals(resultVO.getStatusCd())
				|| Constant.TRADE_STATUS_APPR.equals(resultVO.getStatusCd()))) {
			return "redirect:/mas/prmt/detailPromotion.do?prmtNum=" + resultVO.getPrmtNum();
		}

		// 프로모션 매핑 상품 정보 가져오기.
		List<PRMTPRDTVO> prmtPrdtVO = masPrmtService.selectPrmtPrdtList(prmtVO);

		model.addAttribute("prmtPrdtList", prmtPrdtVO);

		// 프로모션 구분 코드
		List<CDVO> cdList = ossCmmService.selectCode(Constant.PRMT_DIV_CD);

		model.addAttribute("prmtCdList", cdList);

		model.addAttribute("SVR_TODAY", new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

		return "mas/prmt/updatePromotion";
	}

	@RequestMapping("/mas/prmt/updatePromotion.do")
	public String updatePromotion(@ModelAttribute("prmtVO") PRMTVO prmtVO,
								  final MultipartHttpServletRequest multiRequest) throws Exception {
		log.info("/mas/prmt/updatePromotion.do call");

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		prmtVO.setCorpId(corpInfo.getCorpId());
		prmtVO.setLastModId(corpInfo.getUserId());
		prmtVO.setLastModIp(corpInfo.getLastLoginIp());
		prmtVO.setCorpCd(corpInfo.getCorpCd());

		masPrmtService.updatePromotion(prmtVO, multiRequest, "mas");

		List<String> prdtNumList = prmtVO.getPrdtNum();

		if(prdtNumList != null && prdtNumList.size() > 0) {
			masPrmtService.deletePrmtPrdt(prmtVO.getPrmtNum());
			masPrmtService.insertPrmtPrdt(prmtVO);
		}
		return "redirect:/mas/prmt/promotionList.do";
	}

	@RequestMapping("/mas/prmt/promotionFileDel.do")
   	public String promotionFileDel(@ModelAttribute("searchVO") PRMTVO prmtVO
   						, ModelMap model
   						, HttpServletRequest request)throws Exception{
   		log.info("/mas/prmt/promotionFileDel.do 호출");

   		String prmtFileNum = request.getParameter("prmtFileNum");

   		masPrmtService.deletePrmtFile(prmtFileNum);

   		//return "redirect:/oss/eventModView.do?prmtNum="+prmtVO.getPrmtNum()+"&noticeNum="+notiVO.getNoticeNum()+"&pageIndex="+notiSVO.getPageIndex()+"&sKeyOpt="+notiSVO.getsKeyOpt()+"&sKey="+notiSVO.getsKey();

   		return "redirect:/mas/prmt/viewUpdatePromotion.do?prmtNum="+prmtVO.getPrmtNum();

    }


	@RequestMapping("/mas/prmt/promotionFileDown.do")
   	public void promotionFileDown(@ModelAttribute("PRMTFILEVO") PRMTFILEVO prmtFileVO
   						, HttpServletRequest request
   						, HttpServletResponse response
   						, ModelMap model	)throws Exception{
    	log.info("/mas/prmt/promotionFileDown.do 호출");

    	PRMTFILEVO prmtRes = masPrmtService.selectPrmtFile(prmtFileVO);

    	String strRoot = EgovProperties.getProperty("HOST.WEBROOT");
    	String strRealFileName = prmtRes.getRealFileNm();
		String strSaveFilePath = strRoot + prmtRes.getSavePath() + prmtRes.getSaveFileNm();
		File fileSaveFile = new File(strSaveFilePath);

		if(fileSaveFile.exists() == false){
			log.info("file not exist!!");
			//오류처리
			return;
		}

		if (!fileSaveFile.isFile()) {
			log.info("file not isFile!!");
		    //throw new FileNotFoundException(downFileName);
			//오류처리
			return;
		}

		String userAgent = request.getHeader("User-Agent");

		int fSize = (int)fileSaveFile.length();
		if (fSize > 0) {
			BufferedInputStream in = null;

		    try {
				in = new BufferedInputStream(new FileInputStream(fileSaveFile));

				//String mimetype = fileDownloads.getMimeType(strRealFileName); //"application/x-msdownload"

		    	response.setBufferSize(fSize);
				//response.setContentType(mimetype);

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
	//			response.setHeader("Content-Transfer-Encoding","binary");
				//response.setHeader("Pragma","no-cache");
				//response.setHeader("Expires","0");
	//			FileCopyUtils.copy(in, response.getOutputStream());
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

	@RequestMapping("/mas/prmt/approvalPromotion.ajax")
	public ModelAndView approvalPromotion(@ModelAttribute("prmtVO") PRMTVO prmtVO, ModelMap model) {
		log.info("/mas/prmt/approvalPromotion.ajax call");
		Map<String, Object> resultMap = new HashMap<String,Object>();

		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		prmtVO.setCorpId(corpInfo.getCorpId());
		prmtVO.setLastModId(corpInfo.getUserId());
		prmtVO.setLastModIp(corpInfo.getLastLoginIp());
		prmtVO.setCorpCd(corpInfo.getCorpCd());

		masPrmtService.updatePrmtStatusCd(prmtVO);
		resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
		return modelAndView;
	}

	@RequestMapping("/mas/prmt/deletePromotion.ajax")
	public ModelAndView deletePromotion(@ModelAttribute("prmtVO") PRMTVO prmtVO) {
		log.info("/mas/prmt/deletePromotion.ajax call");
    	Map<String, Object> resultMap = new HashMap<String,Object>();
    	USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
		prmtVO.setCorpId(corpInfo.getCorpId());

    	PRMTVO resultVO =masPrmtService.selectByPrmt(prmtVO);

    	if(resultVO == null) {
    		resultMap.put("resultCode", Constant.JSON_FAIL);
			ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);
			return modelAndView;
    	}

    	masPrmtService.deletePrmtPrdt(prmtVO.getPrmtNum());
    	masPrmtService.deletePrmtFileAll(prmtVO.getPrmtNum());//첨부파일 삭제
    	masPrmtService.deletePromotion(prmtVO);

    	resultMap.put("resultCode", Constant.JSON_SUCCESS);
		ModelAndView modelAndView = new ModelAndView("jsonView", resultMap);

		return modelAndView;
	}

	@RequestMapping("/mas/prmt/detailPromotion.do")
	public String detailPromotion(@ModelAttribute("prmtVO") PRMTVO prmtVO,
								  ModelMap model) {
			log.info("/mas/prmt/detailPromotion.do call");

			USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();
			prmtVO.setCorpCd(corpInfo.getCorpCd());
			prmtVO.setCorpId(corpInfo.getCorpId());
			// 프로모션 정보가져오기
			PRMTVO resultVO = masPrmtService.selectByPrmt(prmtVO);

			model.addAttribute("prmtVO", resultVO);

			List<PRMTPRDTVO> prmtPrdtVO = masPrmtService.selectPrmtPrdtList(prmtVO);

			model.addAttribute("prmtPrdtList", prmtPrdtVO);
			//첨부파일 정보 가저오기
			PRMTFILEVO prmtfileVO = new PRMTFILEVO();
			prmtfileVO.setPrmtNum(prmtVO.getPrmtNum());

			List<PRMTFILEVO> prmtFileList = masPrmtService.selectPrmtFileList(prmtfileVO);

			model.addAttribute("prmtFileList", prmtFileList);

			String apprMsg = ossCmmService.selectConhistByMsg(resultVO.getPrmtNum());

			model.addAttribute("apprMsg", apprMsg);

			return "mas/prmt/detailPromotion";
		}
}
