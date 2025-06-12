package oss.site.service;

import org.springframework.web.multipart.MultipartFile;
import oss.site.vo.MAINAREAPRDTVO;
import oss.site.vo.MAINBRANDSETDVO;
import oss.site.vo.MAINCTGRRCMDVO;
import oss.site.vo.MAINHOTPRDTVO;

import java.util.List;
import java.util.Map;

/**
 * 메인 설정 관리
 * 파일명 : OssMainConfigService.java
 * 작성일 : 2017. 11. 21. 오전 10:30:37
 * 작성자 : 정동수
 */
public interface OssMainConfigService {
	/**
	 * 메인 설정 인기있수다 리스트
	 * Function : selectmainConfigList
	 * 작성일 : 2017. 11. 21. 오후 2:04:06
	 * 작성자 : 정동수
	 * @param : mainInfo
	 * @return
	 */
	List<MAINHOTPRDTVO> selectHotConfigList(String prdtDiv);

	/**
	 * 메인 설정 즐거운 폭발 리스트
	 * Function : selectUrlConfigList
	 * 작성일 : 2017. 11. 21. 오후 8:16:06
	 * 작성자 : 정동수
	 * @param prdtDiv
	 * @return
	 */
	List<MAINHOTPRDTVO> selectUrlConfigList(String prdtDiv);
		
	/**
	 * 메인 설정 인기있수다 등록
	 * Function : insertMainConfig
	 * 작성일 : 2017. 11. 21. 오전 10:32:21
	 * 작성자 : 정동수
	 * @param : mainInfo
	 */
	void insertMainHot(MAINHOTPRDTVO mainHot);
	
	/**
	 * 메인 설정 인기있수다 삭제
	 * Function : deleteMainConfig
	 * 작성일 : 2017. 11. 21. 오전 10:32:23
	 * 작성자 : 정동수
	 * @param printDiv
	 */
	void deleteMainHot(String printDiv);
	
	/**
	 * 메인 설정 지역별 핫 플레이스 상품 리스트
	 * Function : selectAreaConfigList
	 * 작성일 : 2017. 11. 22. 오전 11:42:43
	 * 작성자 : 정동수
	 * @return
	 */
	List<MAINAREAPRDTVO> selectAreaConfigList();
	
	/**
	 * 메인 설정 지역별 핫 플레이스 등록
	 * Function : insertMainArea
	 * 작성일 : 2017. 11. 22. 오전 10:58:00
	 * 작성자 : 정동수
	 * @param mainArea
	 */
	void insertMainArea(MAINAREAPRDTVO mainArea);
	
	/**
	 * 메인 설정 지역별 핫 플레이스 삭제
	 * Function : deleteMainArea
	 * 작성일 : 2017. 11. 22. 오전 10:58:04
	 * 작성자 : 정동수
	 */
	void deleteMainArea();
	
	/**
	 * 메인 설정 카테고리 추천 상품 리스트
	 * Function : selectCtgrRcmdList
	 * 작성일 : 2018. 1. 5. 오전 9:23:07
	 * 작성자 : 정동수
	 * @return
	 */
	Map<String, List<MAINCTGRRCMDVO>> selectCtgrRcmdList();
		
	/**
	 * 메인 설정 카테고리 추천 상품 등록
	 * Function : insertMainCtgrRcmd
	 * 작성일 : 2018. 1. 5. 오전 9:23:28
	 * 작성자 : 정동수
	 * @param mainCtgrRcmd
	 */
	void insertMainCtgrRcmd(MAINCTGRRCMDVO mainCtgrRcmd);
	
	/**
	 * 메인 설정 카테고리 추천 상품 삭제
	 * Function : deleteCtgrRcmd
	 * 작성일 : 2018. 1. 5. 오전 9:23:48
	 * 작성자 : 정동수
	 */
	void deleteCtgrRcmd();
	
	/**
	 * 메인 설정 특산기념품 브랜드 상품
	 * Function : selectCorpConfigList
	 * 작성일 : 2020.06.30
	 * 작성자 : 김지연
	 * @return
	 */
	List<MAINBRANDSETDVO> selectBrandSetList();
	
	/**
	 * 메인 설정 특산기념품 브랜드 상품 등록
	 * Function : insertMainBrand
	 * 작성일 : 2020.06.30
	 * 작성자 : 김지연
	 * @param mainBrandSet
	 */
	void insertMainBrand(MAINBRANDSETDVO mainBrandSet);

	/**
	 * 메인 설정 특산기념품 브랜드 상품 삭제
	 * Function : deleteMainBrand
	 * 작성일 : 2020.06.30
	 * 작성자 : 김지연
	 */
	void deleteMainBrand();

	/**
	* 설명 : 특산기념품 파일업로드
	* 파일명 : brandCardImg
	* 작성일 : 2021-08-13 오후 1:26
	* 작성자 : chaewan.jung
	* @param : cardImg, cardImgFileNm
	* @return : void
	* @throws Exception
	*/
	void brandCardImg(MultipartFile cardImg, String cardImgFileNm) throws Exception;
}
