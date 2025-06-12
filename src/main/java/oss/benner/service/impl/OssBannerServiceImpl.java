package oss.benner.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import oss.benner.service.OssBannerService;
import oss.benner.vo.BANNERVO;
import oss.cmm.service.OssFileUtilService;

@Service("ossBannerService")
public class OssBannerServiceImpl implements OssBannerService {

	@Resource(name="bannerDAO")
    private BannerDAO bannerDAO;

	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Override
	public List<BANNERVO> selectBannerList(BANNERVO bannerVO) {
		return bannerDAO.selectBannerList(bannerVO);
	}

	@Override
	@Cacheable(value = "bannerCache1", key = "#bannerVO.location")
	public List<BANNERVO> selectBannerListWeb(BANNERVO bannerVO) {
		return bannerDAO.selectBannerListWeb(bannerVO);
	}

	@Override
	public List<BANNERVO> selectBannerListWebCnt(BANNERVO bannerVO) {
		return bannerDAO.selectBannerListWebCnt(bannerVO);
	}
	
	@Override
	@Cacheable(value = "bannerCache2", key = "#bannerVO.location")
	public List<BANNERVO> selectBannerListWebByPrintSn(BANNERVO bannerVO) {
		return bannerDAO.selectBannerListWebByPrintSn(bannerVO);
	}
	
	@Override
	public BANNERVO selectByBanner(BANNERVO bannerVO) {
		return bannerDAO.selectByBanner(bannerVO);
	}

	@Override
	public String insertBanner(BANNERVO bannerVO) {
		return bannerDAO.insertBanner(bannerVO);
	}

	@Override
	public	void updateBanner(BANNERVO bannerVO, String strImgPath){
		if(strImgPath.isEmpty() || "".equals(strImgPath)){
			updateBannerNoPic(bannerVO);
		}else{
			updateBanner(bannerVO);
		}
	}

	@Override
	public void updateBanner(BANNERVO bannerVO) {
		bannerDAO.updateBanner(bannerVO);
	}

	@Override
	public void updateBannerNoPic(BANNERVO bannerVO) {
		bannerDAO.updateBannerNoPic(bannerVO);
	}

	@Override
	public void deleteBanner(BANNERVO bannerVO) {
		bannerDAO.deleteBanner(bannerVO);

	}

	@Override
	public Integer getMaxCntBannerPos(BANNERVO bannerVO) {
		return bannerDAO.getMaxCntBannerPos(bannerVO);
	}

	@Override
	public void addViewSn(BANNERVO bannerVO) {
		bannerDAO.addViewSn(bannerVO);

	}

	@Override
	public void minusViewSn(BANNERVO bannerVO) {
		bannerDAO.minusViewSn(bannerVO);

	}





}
