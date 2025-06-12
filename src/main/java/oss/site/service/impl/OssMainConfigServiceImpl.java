package oss.site.service.impl;

import common.Constant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import oss.cmm.service.OssFileUtilService;
import oss.site.service.OssMainConfigService;
import oss.site.vo.MAINAREAPRDTVO;
import oss.site.vo.MAINBRANDSETDVO;
import oss.site.vo.MAINCTGRRCMDVO;
import oss.site.vo.MAINHOTPRDTVO;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("ossMainConfigService")
public class OssMainConfigServiceImpl implements OssMainConfigService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(OssMainConfigServiceImpl.class);

	@Autowired
	private OssFileUtilService ossFileUtilService;

	@Resource(name = "mainConfigDAO")
	private MainConfigDAO mainConfigDAO;
	
	@Override
	public List<MAINHOTPRDTVO> selectHotConfigList(String prdtDiv) {
		Map<String, MAINHOTPRDTVO> resultMap = new HashMap<String, MAINHOTPRDTVO>();
		List<MAINHOTPRDTVO> mainList = mainConfigDAO.selectMainHot(prdtDiv);
		
		
		
		return mainList;
	}
	
	@Override
	public List<MAINHOTPRDTVO> selectUrlConfigList(String prdtDiv) {		
		return mainConfigDAO.selectMainHot(prdtDiv);
	}	
	
	@Override
	public void insertMainHot(MAINHOTPRDTVO mainHot) {
		mainConfigDAO.insertMainHot(mainHot);
	}
	
	@Override
	public List<MAINAREAPRDTVO> selectAreaConfigList() {
		return mainConfigDAO.selectMainArea();
	}

	@Override
	public void deleteMainHot(String printDiv) {
		mainConfigDAO.deleteMainHot(printDiv);
	}

	@Override
	public void insertMainArea(MAINAREAPRDTVO mainArea) {
		mainConfigDAO.insertMainArea(mainArea);
	}

	@Override
	public void deleteMainArea() {
		mainConfigDAO.deleteMainArea();
	}

	@Override
	public Map<String, List<MAINCTGRRCMDVO>> selectCtgrRcmdList() {
		List<MAINCTGRRCMDVO> rcmdADList = new ArrayList<MAINCTGRRCMDVO>();
		List<MAINCTGRRCMDVO> rcmdRCList = new ArrayList<MAINCTGRRCMDVO>();
		List<MAINCTGRRCMDVO> rcmdC200List = new ArrayList<MAINCTGRRCMDVO>();
		List<MAINCTGRRCMDVO> rcmdC300List = new ArrayList<MAINCTGRRCMDVO>();
		List<MAINCTGRRCMDVO> rcmdC100List = new ArrayList<MAINCTGRRCMDVO>();
		List<MAINCTGRRCMDVO> rcmdSVList = new ArrayList<MAINCTGRRCMDVO>();
		Map<String, List<MAINCTGRRCMDVO>> resultMap = new HashMap<String, List<MAINCTGRRCMDVO>>();
		List<MAINCTGRRCMDVO> mainList = mainConfigDAO.selectMainCtgrRcmd();
		
		for (MAINCTGRRCMDVO mainInfo : mainList) {
			if (Constant.ACCOMMODATION.equals(mainInfo.getPrdtDiv())) {
				rcmdADList.add(mainInfo);
			}			
			if (Constant.RENTCAR.equals(mainInfo.getPrdtDiv())) {
				rcmdRCList.add(mainInfo);
			}
			if (Constant.CATEGORY_TOUR.equals(mainInfo.getPrdtDiv())) {
				rcmdC200List.add(mainInfo);
			}
			if (Constant.CATEGORY_ETC.equals(mainInfo.getPrdtDiv())) {
				rcmdC300List.add(mainInfo);
			}
			if (Constant.CATEGORY_PACKAGE.equals(mainInfo.getPrdtDiv())) {
				rcmdC100List.add(mainInfo);
			}
			if (Constant.SV.equals(mainInfo.getPrdtDiv())) {
				rcmdSVList.add(mainInfo);
			}
		}
		resultMap.put(Constant.ACCOMMODATION, rcmdADList);
		resultMap.put(Constant.RENTCAR, rcmdRCList);
		resultMap.put(Constant.CATEGORY_TOUR, rcmdC200List);
		resultMap.put(Constant.CATEGORY_ETC, rcmdC300List);
		resultMap.put(Constant.CATEGORY_PACKAGE, rcmdC100List);
		resultMap.put(Constant.SV, rcmdSVList);
		
		return resultMap;
	}

	@Override
	public void insertMainCtgrRcmd(MAINCTGRRCMDVO mainCtgrRcmd) {
		mainConfigDAO.insertMainCtgrRcmd(mainCtgrRcmd);
		
	}

	@Override
	public void deleteCtgrRcmd() {
		mainConfigDAO.mainCtgrRcmd();
	}
	
	@Override
	public List<MAINBRANDSETDVO> selectBrandSetList() {		
		return mainConfigDAO.selectMainBrand();
	}	
	
	@Override
	public void insertMainBrand(MAINBRANDSETDVO mainBrandSet) {		
		mainConfigDAO.insertMainBrand(mainBrandSet);
	}	
	
	@Override
	public void deleteMainBrand() {
		mainConfigDAO.deleteMainBrand();
	}

	@Override
	public void brandCardImg(MultipartFile cardImg, String cardImgFileNm) throws Exception{
		ossFileUtilService.uploadFile(cardImg, cardImgFileNm, "/data/brand");

	}
}
