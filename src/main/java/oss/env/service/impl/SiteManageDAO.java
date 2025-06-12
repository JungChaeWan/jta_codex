package oss.env.service.impl;

import mas.ad.vo.AD_CNTINFVO;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import oss.env.vo.DFTINFVO;

@Repository("siteManageDAO")
public class SiteManageDAO extends EgovAbstractDAO { 

	public DFTINFVO selectDftInf(String dftInfTamnao) {
		return (DFTINFVO) select("DFT_INF_S_00", dftInfTamnao);
	}

	public void insertDftInf(DFTINFVO dftinfvo) {
		insert("DFT_INF_I_00", dftinfvo);
	}

	public void updateDftInf(DFTINFVO dftinfvo) {
		update("DFT_INF_U_00", dftinfvo);
	}

	/**
	 * 기본 정렬 변경
	 * 파일명 : updateSort
	 * 작성일 : 2017. 2. 1. 오후 5:11:21
	 * 작성자 : 최영철
	 * @param dftinfvo
	 */
	public void updateSort(DFTINFVO dftinfvo) {
		update("DFT_INF_U_01", dftinfvo);
	}

	// 앱 버전 수정
	public void updateAppVer(DFTINFVO dftinfvo) {
		update("DFT_INF_U_02", dftinfvo);
	}

	public Integer channelTalkOutDayCnt(String strYYYYMMDD){
		return (Integer) select("CT_OUTDAY_S_01", strYYYYMMDD);
	}

	public void channelTalkSetCal(String strYYYYMMDD, Integer outDayCnt){
		//예외일이 설정 되어 있으면 delete. 설정되어 있지 않으면 insert
		if( outDayCnt > 0){
			delete("CT_OUTDAY_D_01", strYYYYMMDD);
		}else{
			insert("CT_OUTDAY_I_01", strYYYYMMDD);
		}
	}

	/**
	* 설명 : 채널톡 간편 입력기
	* 파일명 :
	* 작성일 : 2022-07-12 오후 5:38
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void channelTalkSimpleInsert(AD_CNTINFVO adCntinfVO) {
		insert("CT_OUTDAY_I_02", adCntinfVO);
	}
}
