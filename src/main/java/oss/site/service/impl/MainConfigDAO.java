package oss.site.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import oss.site.vo.MAINAREAPRDTVO;
import oss.site.vo.MAINBRANDSETDVO;
import oss.site.vo.MAINCTGRRCMDVO;
import oss.site.vo.MAINHOTPRDTVO;

/**
 * 메인 설정 DAO 관리
 * 파일명 : MainConfigDAO.java
 * 작성일 : 2017. 11. 21. 오전 10:35:53
 * 작성자 : 정동수
 */
@Repository("mainConfigDAO")
public class MainConfigDAO extends EgovAbstractDAO {	
	/**
	 * 메인 설정 인기있수다 & 즐거움 폭발 리스트
	 * Function : selectMainHot
	 * 작성일 : 2017. 11. 21. 오후 2:04:06
	 * 작성자 : 정동수
	 * @param prdtDiv
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINHOTPRDTVO> selectMainHot(String prdtDiv) {
		return (List<MAINHOTPRDTVO>) list("MAIN_CONFIG_S_00", prdtDiv);
	}
		
	/**
	 * 메인 설정 지역별 핫 플레이스 상품 리스트
	 * Function : selectMainArea
	 * 작성일 : 2017. 11. 22. 오전 11:42:43
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINAREAPRDTVO> selectMainArea() {
		return (List<MAINAREAPRDTVO>) list("MAIN_CONFIG_S_01");
	}
		
	/**
	 * 메인 설정 카테고리 추천 상품 리스트
	 * Function : selectCtgrRcmd
	 * 작성일 : 2018. 1. 5. 오전 9:23:07
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINCTGRRCMDVO> selectMainCtgrRcmd() {
		return (List<MAINCTGRRCMDVO>) list("MAIN_CONFIG_S_02");
	}
	
	/**
	 * 메인 설정 인기있수다 & 즐거움 폭발 상품 등록
	 * Function : insertMainConfig
	 * 작성일 : 2017. 11. 21. 오전 10:32:21
	 * 작성자 : 정동수
	 * @param mainHot
	 */
	public void insertMainHot(MAINHOTPRDTVO mainHot) {
		insert("MAIN_CONFIG_I_00", mainHot);
	}
		
	/**
	 * 메인 지역별 핫 플레이스 상품 등록
	 * Function : insertMainArea
	 * 작성일 : 2017. 11. 22. 오전 10:58:00
	 * 작성자 : 정동수
	 * @param mainArea
	 */
	public void insertMainArea(MAINAREAPRDTVO mainArea) {
		insert("MAIN_CONFIG_I_01", mainArea);
	}
		
	/**
	 * 메인 설정 카테고리 추천 상품 등록
	 * Function : insertMainCtgrRcmd
	 * 작성일 : 2018. 1. 5. 오전 9:23:28
	 * 작성자 : 정동수
	 * @param mainCtgrRcmd
	 */
	public void insertMainCtgrRcmd(MAINCTGRRCMDVO mainCtgrRcmd) {
		insert("MAIN_CONFIG_I_02", mainCtgrRcmd);
	}
		
	/**
	 * 메인 인기있수다 & 즐거움 폭발 상품 삭제
	 * Function : deleteMainHot
	 * 작성일 : 2017. 11. 21. 오전 10:32:23
	 * 작성자 : 정동수
	 * @param printDiv
	 */
	public void deleteMainHot(String printDiv) {
		delete("MAIN_CONFIG_D_00", printDiv);
	}
		
	/**
	 * 메인 지역별 핫 플레이스 상품 삭제
	 * Function : deleteMainArea
	 * 작성일 : 2017. 11. 22. 오전 10:58:04
	 * 작성자 : 정동수
	 */
	public void deleteMainArea() {
		delete("MAIN_CONFIG_D_01");
	}
	
	/**
	 * 메인 설정 카테고리 추천 상품 삭제
	 * Function : deleteCtgrRcmd
	 * 작성일 : 2018. 1. 5. 오전 9:23:48
	 * 작성자 : 정동수
	 */
	public void mainCtgrRcmd() {
		delete("MAIN_CONFIG_D_02");
	}
	
	/**
	 * 메인 설정 특산기념품 브랜드 상품
	 * Function : selectMainBrand
	 * 작성일 : 2020.06.30
	 * 작성자 : 김지연
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINBRANDSETDVO> selectMainBrand() {
		return (List<MAINBRANDSETDVO>) list("MAIN_CONFIG_S_03");
	}	
	
	/**
	 * 메인 설정 특산기념품 브랜드 상품 등록
	 * Function : insertMainBrand
	 * 작성일 : 2020.06.30
	 * 작성자 : 김지연
	 * @return
	 */
	public void insertMainBrand(MAINBRANDSETDVO mainBrandSet) {
		insert("MAIN_CONFIG_I_03", mainBrandSet);
	}	
	
	/**
	 * 메인 설정 특산기념품 브랜드 상품
	 * Function : deleteMainBrand
	 * 작성일 : 2020.06.30
	 * 작성자 : 김지연
	 */
	public void deleteMainBrand() {
		delete("MAIN_CONFIG_D_03");
	}	
}
