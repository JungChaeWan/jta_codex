package oss.benner.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.benner.vo.BANNERVO;
import oss.env.vo.DFTINFVO;

public interface OssBannerService {

	List<BANNERVO> selectBannerList(BANNERVO bannerVO);
	List<BANNERVO> selectBannerListWeb(BANNERVO bannerVO);
	List<BANNERVO> selectBannerListWebCnt(BANNERVO bannerVO);
	List<BANNERVO> selectBannerListWebByPrintSn(BANNERVO bannerVO);
	
	BANNERVO selectByBanner(BANNERVO bannerVO);
	Integer getMaxCntBannerPos(BANNERVO bannerVO);

	String insertBanner(BANNERVO bannerVO);

	void updateBanner(BANNERVO bannerVO, String strImgPath);
	void addViewSn(BANNERVO bannerVO);
	void minusViewSn(BANNERVO bannerVO);

	void updateBanner(BANNERVO bannerVO);
	void updateBannerNoPic(BANNERVO bannerVO);
	void deleteBanner(BANNERVO bannerVO);
}
