package oss.benner.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import oss.benner.vo.BANNERVO;
import oss.corp.vo.CORPVO;
import oss.env.vo.DFTINFVO;

@Repository("bannerDAO")
public class BannerDAO extends EgovAbstractDAO {

	/**
	 * 배너 조회
	 * 파일명 : selectBanner
	 * 작성일 : 2017. 7. 19. 오후 2:02:42
	 * 작성자 : 신우섭
	 * @param bannerVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BANNERVO>  selectBannerList(BANNERVO bannerVO) {
		return (List<BANNERVO>) list("BANNER_S_00", bannerVO);
	}

	public BANNERVO selectByBanner(BANNERVO bannerVO) {
		return (BANNERVO) select("BANNER_S_00", bannerVO);
	}

	public Integer getMaxCntBannerPos(BANNERVO bannerVO) {
		return (Integer) select("BANNER_S_01", bannerVO);
	}

	@SuppressWarnings("unchecked")
	public List<BANNERVO>  selectBannerListWeb(BANNERVO bannerVO) {
		return (List<BANNERVO>) list("BANNER_S_02", bannerVO);
	}

	@SuppressWarnings("unchecked")
	public List<BANNERVO>  selectBannerListWebCnt(BANNERVO bannerVO) {
		return (List<BANNERVO>) list("BANNER_S_03", bannerVO);
	}

	@SuppressWarnings("unchecked")
	public List<BANNERVO>  selectBannerListWebByPrintSn(BANNERVO bannerVO) {
		return (List<BANNERVO>) list("BANNER_S_04", bannerVO);
	}
	
	public String insertBanner(BANNERVO bannerVO) {
		return (String) insert("BANNER_I_00", bannerVO);
	}

	public void updateBanner(BANNERVO bannerVO) {
		update("BANNER_U_00", bannerVO);
	}

	public void updateBannerNoPic(BANNERVO bannerVO) {
		update("BANNER_U_03", bannerVO);
	}

	public void addViewSn(BANNERVO bannerVO) {
		update("BANNER_U_01", bannerVO);
	}

	public void minusViewSn(BANNERVO bannerVO) {
		update("BANNER_U_02", bannerVO);
	}

	public void deleteBanner(BANNERVO bannerVO) {
		delete("BANNER_D_00", bannerVO);
	}
}
