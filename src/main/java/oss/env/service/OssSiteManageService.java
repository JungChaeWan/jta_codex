package oss.env.service;

import mas.ad.vo.AD_CNTINFVO;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.env.vo.DFTINFVO;

public interface OssSiteManageService {

	DFTINFVO selectByTamnao(String dftInfTamnao);

	void insertDftInfTamnao(DFTINFVO dftinfvo);

	void updateDftInf(DFTINFVO dftinfvo);

	/**
	 * 로고 변경
	 * 파일명 : changeLogo
	 * 작성일 : 2016. 11. 30. 오전 11:24:31
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @throws Exception 
	 */
	void changeLogo(MultipartHttpServletRequest multiRequest) throws Exception;
	
	/**
	 * 모바일 로고 변경
	 * 파일명 : changeMLogo
	 * 작성일 : 2016. 11. 30. 오전 11:24:31
	 * 작성자 : 최영철
	 * @param multiRequest
	 * @throws Exception 
	 */
	void changeMLogo(MultipartHttpServletRequest multiRequest) throws Exception;

	/**
	 * 상품 기본 정렬 변경
	 * 파일명 : updateSort
	 * 작성일 : 2017. 2. 1. 오후 5:10:29
	 * 작성자 : 최영철
	 * @param dftinfvo
	 */
	void updateSort(DFTINFVO dftinfvo);

	// 앱 버전 수정
	void updateAppVer(DFTINFVO dftinfvo);

	/**
	* 설명 : 채널톡 상담예외일 설정
	* 파일명 :
	* 작성일 : 2022-07-12 오후 4:11
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	void channelTalkSetCal(String strYYYYMMDD, Integer outDay);

	Integer channelTalkOutDayCnt(String strYYYYMMDD);

	/**
	* 설명 : 채널톡 간편 입력기
	* 파일명 :
	* 작성일 : 2022-07-12 오후 5:35
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	void channelTalkSimpleInsert(AD_CNTINFVO adCntinfVO);
}
