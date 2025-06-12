package oss.env.service.impl;

import javax.annotation.Resource;

import mas.ad.vo.AD_CNTINFVO;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.cmm.service.OssFileUtilService;
import oss.env.service.OssSiteManageService;
import oss.env.vo.DFTINFVO;

import common.Constant;

@Service("ossSiteManageService")
public class OssSiteManageServiceImpl implements OssSiteManageService {

	@Resource(name="siteManageDAO")
    private SiteManageDAO siteManageDAO;
	
	@Resource(name = "ossFileUtilService")
	private OssFileUtilService ossFileUtilService;
	
	@Override
	public DFTINFVO selectByTamnao(String dftInfTamnao) {
		DFTINFVO resultVO = (DFTINFVO) siteManageDAO.selectDftInf(dftInfTamnao);
		
		resultVO.setAdSortAsc(Constant.ORDER_DESC);
		resultVO.setRcSortAsc(Constant.ORDER_DESC);
		resultVO.setTickSortAsc(Constant.ORDER_DESC);
		resultVO.setFoodSortAsc(Constant.ORDER_DESC);
		resultVO.setPackSortAsc(Constant.ORDER_DESC);
		resultVO.setSvSortAsc(Constant.ORDER_DESC);
		
		// 숙박
		if(Constant.ORDER_PRICE.equals(resultVO.getAdSortStd())){
			resultVO.setAdSortAsc(Constant.ORDER_ASC);
		}
		// 렌터카
		if(Constant.ORDER_PRICE.equals(resultVO.getRcSortStd())){
			resultVO.setRcSortAsc(Constant.ORDER_ASC);
		}
		// 관광지
		if(Constant.ORDER_PRICE.equals(resultVO.getTickSortStd())){
			resultVO.setTickSortAsc(Constant.ORDER_ASC);
		}
		// 음식
		if(Constant.ORDER_PRICE.equals(resultVO.getFoodSortStd())){
			resultVO.setFoodSortAsc(Constant.ORDER_ASC);
		}
		// 패키지
		if(Constant.ORDER_PRICE.equals(resultVO.getPackSortStd())){
			resultVO.setPackSortAsc(Constant.ORDER_ASC);
		}
		// 기념품
		if(Constant.ORDER_PRICE.equals(resultVO.getSvSortStd())){
			resultVO.setSvSortAsc(Constant.ORDER_ASC);
		}
		
		return resultVO;
	}
	
	@Override
	public void updateDftInf(DFTINFVO dftinfvo) {
		siteManageDAO.updateDftInf(dftinfvo);
	}

	@Override
	public void insertDftInfTamnao(DFTINFVO dftinfvo) {
		dftinfvo.setInfId(Constant.DFT_INF_TAMNAO);
		siteManageDAO.insertDftInf(dftinfvo);
	}
	
	/**
	 * 로고 변경
	 * 파일명 : changeLogo
	 * 작성일 : 2016. 11. 30. 오전 11:24:31
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @throws Exception 
	 */
	@Override
	public void changeLogo(MultipartHttpServletRequest multiRequest) throws Exception{
		MultipartFile logoImgFile = multiRequest.getFile("logoImgFile");
		
		if(!logoImgFile.isEmpty()) {
			ossFileUtilService.uploadFile(logoImgFile, "logo.gif", "/data");
		}
	}
	
	/**
	 * 모바일 로고 변경
	 * 파일명 : changeMLogo
	 * 작성일 : 2016. 11. 30. 오전 11:24:31
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @throws Exception 
	 */
	@Override
	public void changeMLogo(MultipartHttpServletRequest multiRequest) throws Exception{
		MultipartFile logoImgFile = multiRequest.getFile("mlogoImgFile");
		
		if(!logoImgFile.isEmpty()) {
			ossFileUtilService.uploadFile(logoImgFile, "mlogo.gif", "/data");
		}
	}
	
	/**
	 * 상품 기본 정렬 변경
	 * 파일명 : updateSort
	 * 작성일 : 2017. 2. 1. 오후 5:10:29
	 * 작성자 : 최영철
	 * @param dftinfvo
	 */
	@Override
	public void updateSort(DFTINFVO dftinfvo){
		siteManageDAO.updateSort(dftinfvo);
	}

	// 앱 버전 수정
	@Override
	public void updateAppVer(DFTINFVO dftinfvo) {
		siteManageDAO.updateAppVer(dftinfvo);
	}

	/**
	* 설명 : 채널톡 상담예외일 설정
	* 파일명 :
	* 작성일 : 2022-07-12 오후 4:11
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void channelTalkSetCal(String strYYYYMMDD, Integer outDay){
		siteManageDAO.channelTalkSetCal(strYYYYMMDD, outDay);
	}

	public Integer channelTalkOutDayCnt(String strYYYYMMDD){
		return siteManageDAO.channelTalkOutDayCnt(strYYYYMMDD);
	}

	/**
	* 설명 : 채널톡 간편 입력기
	* 파일명 :
	* 작성일 : 2022-07-12 오후 5:35
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void channelTalkSimpleInsert(AD_CNTINFVO adCntinfVO){
		siteManageDAO.channelTalkSimpleInsert(adCntinfVO);
	}
}
