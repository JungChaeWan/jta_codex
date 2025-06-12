package oss.benner.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
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

import oss.benner.service.OssBannerService;
import oss.benner.vo.BANNERVO;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CDVO;
import oss.user.vo.USERVO;
import common.Constant;
import common.EgovUserDetailsHelper;
import egovframework.cmmn.service.EgovProperties;

@Controller
public class OssBannerController {
	 Logger log = (Logger) LogManager.getLogger(OssBannerController.class);

	 @Autowired
	 private DefaultBeanValidator beanValidator;

	@Resource(name="ossBannerService")
	private OssBannerService ossBannerService;

	@Resource(name="ossCmmService")
    private OssCmmService ossCmmService;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;


	 @RequestMapping("/oss/bannerList.do")
	 public String bannerList(ModelMap model,
							  @ModelAttribute("BANNERVO") BANNERVO bannerVO) {
			log.info("/oss/bannerList.do call");

			//코드읽기
			List<CDVO> bnCdList = ossCmmService.selectCode(Constant.BN_CD);
			model.addAttribute("bnCdList", bnCdList);

			if(StringUtils.isEmpty(bannerVO.getLocation())) {
				bannerVO.setLocation("BN01");
			}

			//배너읽기
			List<BANNERVO> bannerList = ossBannerService.selectBannerList(bannerVO);

			model.addAttribute("resultList", bannerList);
			model.addAttribute("BANNERVO", bannerVO);

			return "oss/banner/bannerList";
	 }

	 @RequestMapping("/oss/bannerInsView.do")
	 public String bannerInsView(@ModelAttribute("BANNERVO") BANNERVO bannerVO,
							ModelMap model){
    	log.info("/oss/bannerInsView.do 호출");

		CDVO cdVO = new CDVO();
		cdVO.setCdNum(bannerVO.getLocation());
		CDVO cdVORes = ossCmmService.selectByCd(cdVO);

		model.addAttribute("cdVO", cdVORes);

        return "oss/banner/bannerIns";

	 }

	 @RequestMapping("/oss/bannerIns.do")
	 public String bannerIns(final MultipartHttpServletRequest multiRequest,
						@ModelAttribute("BANNERVO") BANNERVO bannerVO,
						HttpServletRequest request,
						ModelMap model) throws Exception{
		log.info("/oss/bannerIns.do 호출");

		//첨부파일 올리기고 경로들 넣기
		//저장경로 /storage/banner/[년-월]/
		String strDate = new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date());
		String strSaveFilePath = EgovProperties.getProperty("BANNER.SAVEDFILE")+strDate+"/";
		ossFileUtilService.uploadBannerFile(multiRequest, strSaveFilePath, null, bannerVO);

		////로그인 정보 얻기
		//USERVO loginInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedOss();
		//bannerVO.setRegId(loginInfo.getUserId());

		ossBannerService.insertBanner(bannerVO);


		return "redirect:/oss/bannerList.do?location="+ bannerVO.getLocation();

	 }


	@RequestMapping("/oss/bannerUdtView.do")
	public String bannerUdtView(@ModelAttribute("BANNERVO") BANNERVO bannerVO, ModelMap model) {
		log.info("/oss/bannerUdtView.do 호출");

		// log.info("----"+bannerVO.getBannerPos() + " :: " +
		// bannerVO.getBannerNum());

		CDVO cdVO = new CDVO();
		cdVO.setCdNum(bannerVO.getLocation());
		CDVO cdVORes = ossCmmService.selectByCd(cdVO);
		model.addAttribute("cdVO", cdVORes);

		int nMaxPos = ossBannerService.getMaxCntBannerPos(bannerVO);
		model.addAttribute("maxPos", nMaxPos);

		BANNERVO bannerRes = ossBannerService.selectByBanner(bannerVO);
		model.addAttribute("BANNERVO", bannerRes);

		return "oss/banner/bannerUdt";

	}

	@RequestMapping("/oss/bannerUdt.do")
	public String bannerUdt(final MultipartHttpServletRequest multiRequest, @ModelAttribute("BANNERVO") BANNERVO bannerVO, HttpServletRequest request, ModelMap model) throws Exception {
		log.info("/oss/bannerUdt.do 호출");

		BANNERVO bannerS = new BANNERVO();
		bannerS.setBannerNum(bannerVO.getBannerNum());
		BANNERVO bannerOrg = ossBannerService.selectByBanner(bannerS);
		bannerOrg.setOldSn(bannerOrg.getPrintSn());
		bannerOrg.setNewSn(bannerVO.getPrintSn());

		//log.info("----1 : old:" + bannerOrg.getPrintSn() + " new:" + bannerVO.getPrintSn() );


		// 첨부파일 올리기고 경로들 넣기
		// 저장경로 /storage/banner/[년-월]/
		String strDate = new java.text.SimpleDateFormat("yyyy-MM").format(new java.util.Date());
		String strSaveFilePath = EgovProperties.getProperty("BANNER.SAVEDFILE") + strDate + "/";
		String strRealFileName = ossFileUtilService.uploadBannerFile(multiRequest, strSaveFilePath, bannerOrg, bannerVO);

		//log.info("----2");


		// 순번 관련 작업
		if (!bannerOrg.getNewSn().equals(bannerOrg.getOldSn())) {
			//log.info("----2-1");
			if (Integer.parseInt(bannerOrg.getPrintSn()) > Integer.parseInt(bannerVO.getPrintSn())) {
				//log.info("----2-2");
				// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
				ossBannerService.addViewSn(bannerOrg);
			} else {
				//log.info("----2-3");
				ossBannerService.minusViewSn(bannerOrg);
			}
		}


		//log.info("----3 : ["+ strRealFileName +"]");

		// 수정
		ossBannerService.updateBanner(bannerVO, strRealFileName);

		//log.info("----4");

		return "redirect:/oss/bannerList.do?location="+ bannerVO.getLocation();
	}

	@RequestMapping("/oss/bannerDel.do")
	public String bannerDel(@ModelAttribute("BANNERVO") BANNERVO bannerVO, HttpServletRequest request, ModelMap model) throws Exception {
		log.info("/oss/bannerDel.do 호출");

		BANNERVO bannerS = new BANNERVO();
		bannerS.setBannerNum(bannerVO.getBannerNum());
		BANNERVO bannerOrg = ossBannerService.selectByBanner(bannerS);

		// 파일 삭제
		ossFileUtilService.deleteSavedFile(bannerOrg.getImgFileNm(), bannerOrg.getImgPath());

		// 순번관련
		bannerOrg.setOldSn(bannerOrg.getPrintSn());
		ossBannerService.minusViewSn(bannerOrg);

		// 삭제
		ossBannerService.deleteBanner(bannerVO);

		return "redirect:/oss/bannerList.do?location="+ bannerVO.getLocation();

	}


}
