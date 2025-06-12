package web.product.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import mas.ad.vo.*;
import org.springframework.stereotype.Repository;
import oss.ad.vo.*;
import web.order.vo.AD_RSV_DAYPRICEVO;

import java.util.List;
import java.util.Map;

@Repository("webAdDAO")
public class WebAdDAO extends EgovAbstractDAO {

	/*
	public AD_WEBLISTVO selectByPrdt(AD_WEBLISTVO prdtVO) {
		return (AD_WEBLISTVO) select("AD_WEBLIST_S_01", prdtVO);
	}
	*/

	@SuppressWarnings("unchecked")
	public List<AD_WEBLISTVO> selectAdList(AD_WEBLISTSVO prdtSVO) {
		return (List<AD_WEBLISTVO>) list("AD_WEBLIST_S_08", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public List<AD_WEBLISTVO> selectAdMapList(AD_WEBLISTSVO prdtSVO) {
		return (List<AD_WEBLISTVO>) list("AD_WEBLIST_S_13", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public List<AD_WEBLISTVO> selectAdListOssPrmt(AD_WEBLISTSVO prdtSVO) {
		return (List<AD_WEBLISTVO>) list("AD_WEBLIST_S_06", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public List<AD_WEBLIST4VO> selectAdListDist(AD_WEBDTLSVO prdtSVO) {
		return (List<AD_WEBLIST4VO>) list("AD_WEBLIST_S_04", prdtSVO);
	}

	public Integer getCntAdList(AD_WEBLISTSVO prdtSVO) {
		return (Integer) select("AD_WEBLIST_S_09", prdtSVO);
		//return 3;
	}

	@SuppressWarnings("unchecked")
	public List<AD_WEBLISTVO> selectAdListOssKwa(String kwaNum) {
		return (List<AD_WEBLISTVO>) list("AD_WEBLIST_S_10", kwaNum);
	}
	
	@SuppressWarnings("unchecked")
	public List<AD_WEBLISTVO> selectAdBestList() {
		return (List<AD_WEBLISTVO>) list("AD_WEBLIST_S_11");
	}

	@SuppressWarnings("unchecked")
	public List<AD_WEBLISTVO> selectAdNmList(AD_WEBLISTSVO prdtSVO) {
		return (List<AD_WEBLISTVO>) list("AD_WEBLIST_S_12", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public List<AD_PRDTCNTVO> selectAdPrdtCnt(AD_WEBLISTSVO prdtSVO) {
		return (List<AD_PRDTCNTVO>) list("AD_PRDTCNT_S_01", prdtSVO);
	}


	@SuppressWarnings("unchecked")
	public List<AD_WEBLIST2VO> selectBestAdList(AD_WEBLISTSVO prdtSVO) {
		return (List<AD_WEBLIST2VO>) list("AD_WEBLIST_S_03", prdtSVO);
	}


	public AD_WEBDTLVO selectWebdtlByPrdt(AD_WEBDTLSVO prdtVO) {
		return (AD_WEBDTLVO) select("AD_WEBDTL_S_00", prdtVO);
	}


	public Integer getAllEventCnt(AD_WEBLISTSVO prdtSVO) {
		return (Integer) select("AD_WEBDTL_S_01", prdtSVO);
	}

	/**
	 * 날짜,박수에 핫딜,당일 특가 있는지 검사
	 * 파일명 : getHotdeallAndDayPrice
	 * 작성일 : 2015. 12. 4. 오전 9:44:08
	 * 작성자 : 신우섭
	 * @param adWeb
	 * @return
	 */
	public AD_WEBLIST5VO getHotdeallAndDayPrice(AD_WEBLIST5VO adWeb) {
		return (AD_WEBLIST5VO) select("AD_WEBLIST_S_05", adWeb);
	}


	@SuppressWarnings("unchecked")
	public List<AD_PRDTINFVO> selectAdPrdList(AD_PRDTINFVO prdtSVO) {
		return (List<AD_PRDTINFVO>) list("AD_PRDTINF_S_04", prdtSVO);
	}

	@SuppressWarnings("unchecked")
	public List<AD_AMTINFVO> selectAdAmtListDtl(AD_AMTINFSVO prdtSVO) {
		return (List<AD_AMTINFVO>) list("AD_AMTINF_S_03", prdtSVO);
	}

	public AD_ADDAMTVO selectAddamtByDt(AD_ADDAMTVO prdtVO) {
		return (AD_ADDAMTVO) select("AD_ADDAMT_S_03", prdtVO);
	}

	public AD_ADDAMTVO selectAddamtDtTPrice(AD_ADDAMTVO prdtVO) {
		return (AD_ADDAMTVO) select("AD_ADDAMT_S_04", prdtVO);
	}


	public AD_PRDTINFVO selectPrdtInfByPrdtNum(AD_PRDTINFVO prdtVO) {
		return (AD_PRDTINFVO) select("AD_PRDTINF_S_00", prdtVO);
	}

	public AD_PRDTINFVO selectPrdtInfByMaster(AD_PRDTINFVO prdtVO) {
		return (AD_PRDTINFVO) select("AD_PRDTINF_S_05", prdtVO);
	}


	@SuppressWarnings("unchecked")
	public List<AD_CNTINFVO> selectAdCntinfListByTPrice(AD_CNTINFSVO ad_CNTINFSVO) {
		return (List<AD_CNTINFVO>) list("AD_CNTINF_S_10", ad_CNTINFSVO);
	}

	@SuppressWarnings("unchecked")
	public List<AD_AMTINFVO> selectAdAmtinfListByTPrice(AD_AMTINFSVO ad_AMTINFSVO) {
		return (List<AD_AMTINFVO>) list("AD_AMTINF_S_10", ad_AMTINFSVO);
	}

	/**
	 * 지도 현재 판매중인 숙소 리스트
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_WEBDTLVO> selectProductCorpMapList() {
		return (List<AD_WEBDTLVO>) list("AD_WEBLIST_S_07");
	}

	/**
	 * 여행경비산출 숙박검색
	 * 파일명 : selectTeAdList
	 * 작성일 : 2016. 10. 25. 오전 11:34:17
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_WEBLISTVO> selectTeAdList(AD_WEBLISTSVO prdtSVO) {
		return (List<AD_WEBLISTVO>) list("AD_WEBLIST_S_01", prdtSVO);
	}

	/**
	 * 여행경비산출 숙박검색 카운트
	 * 파일명 : getCntTeAdList
	 * 작성일 : 2016. 10. 25. 오전 11:34:58
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	public Integer getCntTeAdList(AD_WEBLISTSVO prdtSVO) {
		return (Integer) select("AD_WEBLIST_S_02", prdtSVO);
	}

	/**
	* 설명 : 일별 숙박요금 저장
	* 파일명 :
	* 작성일 : 2021-06-28 오후 2:33
	* 작성자 : chaewan.jung
	* @param : AD_RSV_DAYPRICEVO
	* @return :
	* @throws Exception
	*/
	public void insertAdRsvDayPrice(AD_RSV_DAYPRICEVO adRsvDaypriceVO){
		insert("AD_RSV_DAYPRICE_I_00", adRsvDaypriceVO);
	}

	@SuppressWarnings("unchecked")
	public String selectTamnacardYn(String sPrdtNum) {
		return (String) select("AD_TAMNACARD_S_00", sPrdtNum);
	}

	/**
	* 설명 : 당일예약 가능여부 체크
	* 파일명 :
	* 작성일 : 2022-01-06 오전 11:33
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public int getDayRsvCnt(Map<String, String> dayRsvCntMap) {
		return (Integer) select("AD_WEBDTL_S_02", dayRsvCntMap);
	}
}
