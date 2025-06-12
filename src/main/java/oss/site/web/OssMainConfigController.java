package oss.site.web;

import egovframework.rte.fdl.property.EgovPropertyService;
import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;
import oss.site.service.OssMainConfigService;
import oss.site.vo.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 메인 설정 관리
 * 파일명 : OssMainConfigController.java
 * 작성일 : 2017. 11. 20. 오후 8:02:35
 * 작성자 : 정동수
 */
@Controller
public class OssMainConfigController {
	@Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	Logger log = (Logger) LogManager.getLogger(this.getClass());

	@Resource(name="ossMainConfigService")
	private OssMainConfigService ossMainConfigService;

	@RequestMapping("/oss/mainConfig.do")
    public String mainConfig(@ModelAttribute("searchVO") SVCRTNVO crtnVO,
    						ModelMap model){
    	log.info("/oss/mainConfig.do 호출");

		List<MAINHOTPRDTVO> mainHotList = ossMainConfigService.selectHotConfigList("HOT");

    	model.addAttribute("mainHotList", mainHotList);

    	List<MAINHOTPRDTVO> mainUrlList = ossMainConfigService.selectUrlConfigList("URL");
    	model.addAttribute("mainUrlList", mainUrlList);

    	List<MAINAREAPRDTVO> mainAreaList = ossMainConfigService.selectAreaConfigList();
    	model.addAttribute("mainAreaList", mainAreaList);
    	
    	Map<String, List<MAINCTGRRCMDVO>> mainCtgrRcmdList = ossMainConfigService.selectCtgrRcmdList();
    	model.addAttribute("mainCtgrRcmdList", mainCtgrRcmdList);
    	
    	List<MAINBRANDSETDVO> mainBrandList = ossMainConfigService.selectBrandSetList();
    	model.addAttribute("mainBrandList", mainBrandList);    	

    	return "/oss/site/mainConfig";
	}

	@RequestMapping("/oss/actionMainHot.do")
    public String actionMainHot(@ModelAttribute("MAINHOTPRDTVO") MAINHOTPRDTVO mainHotPrdtVO,
    				@ModelAttribute("mainHotPrdt") MAINHOTPRDTVOLIST mainList,
    				ModelMap model){
    	log.info("/oss/actionMainHot.do 호출");

    	// 상품 삭제
    	ossMainConfigService.deleteMainHot(mainHotPrdtVO.getPrintDiv());
    	
    	if (mainList.getMainHotPrdt() != null) {
    		int nCnt = 0;
	    	for(MAINHOTPRDTVO mainHot : mainList.getMainHotPrdt()) {
	    		if (mainHot.getPrdtNum() != null) {
	    			if (mainHot.getPrintSn() != null) {
	    				nCnt = Integer.parseInt(mainHot.getPrintSn());	    				
	    			} else {
	    				nCnt++;
	    				mainHot.setPrintSn(""+nCnt);
	    			}
	    			mainHot.setPrintDiv(mainHotPrdtVO.getPrintDiv());
		    		ossMainConfigService.insertMainHot(mainHot);
	    		}
			}
    	}

    	return "redirect:/oss/mainConfig.do";
	}

	@RequestMapping("/oss/actionMainArea.do")
    public String actionMainArea(	@ModelAttribute("mainAreaPrdt") MAINAREAPRDTVOLIST mainList,
    				ModelMap model){
    	log.info("/oss/actionMainArea.do 호출");

    	// 상품 삭제
    	ossMainConfigService.deleteMainArea();

    	if (mainList.getMainAreaPrdt() != null) {
	    	for(MAINAREAPRDTVO mainArea : mainList.getMainAreaPrdt()) {
	    		if (mainArea.getPrdtNum() != null) {
		    		ossMainConfigService.insertMainArea(mainArea);
	    		}
			}
    	}

    	return "redirect:/oss/mainConfig.do";
	}
	
	@RequestMapping("/oss/actionCtgrRcmd.do")
    public String actionCtgrRcmd(	@ModelAttribute("mainCtgrRcmd") MAINCTGRRCMDVOLIST mainList,
    				ModelMap model){
    	log.info("/oss/actionCtgrRcmd.do 호출");

    	// 상품 삭제
    	ossMainConfigService.deleteCtgrRcmd();

    	if (mainList.getMainCtgrRcmd() != null) {    		
	    	for(MAINCTGRRCMDVO mainCtgrRcmd : mainList.getMainCtgrRcmd()) {
	    		if (mainCtgrRcmd.getPrdtNum() != null) {	    			
		    		ossMainConfigService.insertMainCtgrRcmd(mainCtgrRcmd);
	    		}
			}
    	}

    	return "redirect:/oss/mainConfig.do";
	}
	
	@RequestMapping("/oss/actionBrandSet.do") 
    public String actionBrandSet(final MultipartHttpServletRequest multiRequest, @ModelAttribute("mainBrandSet") MAINBRANDSETDVOLIST mainList) throws Exception {
    	log.info("/oss/actionBrandSet.do 호출");
    	
    	// 상품 전체 삭제
    	ossMainConfigService.deleteMainBrand();

    	if (mainList.getMainBrandSet() != null) {

    		int i = 0;
	    	for(MAINBRANDSETDVO mainBrandSet : mainList.getMainBrandSet()) {
	    		if (mainBrandSet.getCorpId() != null) {

					//logo img upload
					MultipartFile logoImg = multiRequest.getFile("mainBrandSet["+i+"].logoImg");
					if(!logoImg.isEmpty()) {
						String logoImgFileNm = "L_" + mainBrandSet.getCorpId()+"."+FilenameUtils.getExtension(logoImg.getOriginalFilename());
						ossMainConfigService.brandCardImg(logoImg, logoImgFileNm);
						mainBrandSet.setLogoImgFileNm(logoImgFileNm);
					}else{
						mainBrandSet.setLogoImgFileNm(mainBrandSet.getOldLogoImg());
					}

					//card img upload
					MultipartFile cardImg = multiRequest.getFile("mainBrandSet["+i+"].cardImg");
					if(!cardImg.isEmpty()) {
						String cardImgFileNm = "C_" + mainBrandSet.getCorpId()+"."+FilenameUtils.getExtension(cardImg.getOriginalFilename());
						ossMainConfigService.brandCardImg(cardImg, cardImgFileNm);
						mainBrandSet.setCardImgFileNm(cardImgFileNm);
					}else{
						mainBrandSet.setCardImgFileNm(mainBrandSet.getOldCardImg());
					}

	    			//insert table
	    			ossMainConfigService.insertMainBrand(mainBrandSet);
	    		}
	    		i++;
			}
    	}

    	return "redirect:/oss/brandShopConfig.do";
	}

	@RequestMapping("/oss/brandShopConfig.do")
	public String brandShopConfig(ModelMap model){
		List<MAINBRANDSETDVO> mainBrandList = ossMainConfigService.selectBrandSetList();
		model.addAttribute("mainBrandList", mainBrandList);
		return "/oss/site/brandShopConfig";
	}

}
