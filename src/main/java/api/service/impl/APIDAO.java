package api.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import api.vo.*;
import common.LowerHashMap;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Repository;

import oss.corp.vo.CORPVO;
import web.order.vo.RC_RSVVO;
import web.order.vo.RSVSVO;
import web.order.vo.SP_RSVVO;
import apiCn.vo.APICNVO;
import apiCn.vo.APILOGVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import mas.prmt.vo.PRMTVO;

@Repository("apiDAO")
public class APIDAO  extends EgovAbstractDAO {

	public List<APIReservationVO> selectApiReservationCorpCdList(String rsvNum) {
		return (List<APIReservationVO>) list("APIR_S_00", rsvNum);
	}


	public List<APIReservationVO> selectApiCancelList(String rsvNum) {
		return (List<APIReservationVO>) list("APIR_S_01", rsvNum);
	}

	public Integer selectApiRcCancelItem(String dtlRsvNum) {
		return (Integer) select("APIR_S_02", dtlRsvNum);
	}

	public List<APIReservationVO> selectApiReservationDtlRsvNumList(String rsvNum) {
		return (List<APIReservationVO>) list("APIR_S_03", rsvNum);
	}

	public String selectSpProductByCorp(String corpId) {
		return (String) select("API_S_00", corpId);
	}

	@SuppressWarnings("unchecked")
	public List<SPPRDTSVO> selectSpProductList(ParamVO paramVO) {
		return (List<SPPRDTSVO>) list("API_S_01", paramVO);
	}

	@SuppressWarnings("unchecked")
	public List<RCSVO> selectRcCorpList(CORPVO corpVO) {
		return (List<RCSVO>) list("API_S_02", corpVO);
	}
	
	public String selectSvProductByCorp(String corpId) {
		return (String) select("API_S_04", corpId);
	}

	/**
	 * 연계 예약 번호에 대한 렌터카 이용내역 삭제
	 * 파일명 : deleteRcUseHist
	 * 작성일 : 2016. 7. 20. 오후 2:13:25
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	public void deleteRcUseHist(RC_RSVVO rcRsvVO) {
		delete("RC_USEHIST_D_01", rcRsvVO);
	}
	
	/**
	 * 메인 예약 리스트 검색
	 * Function : selectByRsvList
	 * 작성일 : 2016. 10. 12. 오후 2:41:22
	 * 작성자 : 정동수
	 * @param rsvSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<POSVO> selectByRsvList(RSVSVO rsvSVO) {
		return (List<POSVO>) list("APIPOS_S_00", rsvSVO);
	}
	
	/** 예약 상세의 정보 검색 */
	public POSVO selectByRsvInfo(POSVO posVO) {
		return (POSVO) select("APIPOS_S_01", posVO);
	}
	
	/** 예약 상세의 예약 리스트 검색 */
	@SuppressWarnings("unchecked")
	public List<POSVO> selectByPrdtList(POSVO posVO) {
		return (List<POSVO>) list("APIPOS_S_02", posVO);
	}
	
	/** 당일 사용 변경 조회	 */
	@SuppressWarnings("unchecked")
	public List<POSVO> selectByUsedPrdtList(POSVO posVO) {
		return (List<POSVO>) list("APIPOS_S_03", posVO);
	}

	/**
	 * 사용현황
	 * Function : selectBydayStat
	 * 작성일 : 2016. 10. 14. 오후 1:44:21
	 * 작성자 : 정동수
	 * @param posVO
	 * @return
	 */
	public POSVO selectByDayStat(POSVO posVO) {
		return (POSVO) select("APIPOS_S_04", posVO);
	}
	
	/**
	 * 사용 처리
	 * Function : updateSpUseDttm
	 * 작성일 : 2016. 10. 21. 오전 10:57:20
	 * 작성자 : 정동수
	 * @param spRsvVO
	 */
	public void updateSpUseDttm(SP_RSVVO spRsvVO) {
		update("APIPOS_U_00", spRsvVO);
	}

	/**
	 * 업체아이디로 API 조회
	 * 파일명 : selectApiCn
	 * 작성일 : 2016. 12. 14. 오후 1:14:43
	 * 작성자 : 최영철
	 * @param apiVO
	 * @return
	 */
	public APICNVO selectApiCn(APICNVO apiVO) {
		return (APICNVO) select("APICN_S_04", apiVO);
	}

	/**
	 * 로그 등록
	 * 파일명 : insertApiLog
	 * 작성일 : 2016. 12. 14. 오후 1:30:44
	 * 작성자 : 최영철
	 * @param apiLogVO
	 */
	public void insertApiLog(APILOGVO apiLogVO) {
		insert("APILOG_I_01", apiLogVO);
	}

	/**
	 * 콕콕114 업체 리스트
	 * 파일명 : selectCokCokList
	 * 작성일 : 2017. 2. 28. 오후 5:50:40
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<LowerHashMap> visitjejuList() {return (List<LowerHashMap>) list("VISITJEJU_S_04", "");}

	public void insertNexezData(ApiNextezPrcAdd apiNextezPrcAdd){ insert("API_NEXTEZ_I_00", apiNextezPrcAdd);};

	public List<LowerHashMap> selectlistAdViewNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_AD_S_00", apiNextezSVO);};
	public List<LowerHashMap> selectlistAdLikeNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_AD_S_01", apiNextezSVO);};
	public List<LowerHashMap> selectlistAdShareNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_AD_S_02", apiNextezSVO);};
	public List<LowerHashMap> selectlistAdPointNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_AD_S_03", apiNextezSVO);};
	public List<LowerHashMap> selectlistAdOrderNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_AD_S_04", apiNextezSVO);};
	public List<LowerHashMap> selectlistAdCancelNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_AD_S_05", apiNextezSVO);};

	public List<LowerHashMap> selectlistRcViewNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_RC_S_00", apiNextezSVO);};
	public List<LowerHashMap> selectlistRcLikeNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_RC_S_01", apiNextezSVO);};
	public List<LowerHashMap> selectlistRcShareNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_RC_S_02", apiNextezSVO);};
	public List<LowerHashMap> selectlistRcPointNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_RC_S_03", apiNextezSVO);};
	public List<LowerHashMap> selectlistRcOrderNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_RC_S_04", apiNextezSVO);};
	public List<LowerHashMap> selectlistRcCancelNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_RC_S_05", apiNextezSVO);};

	public List<LowerHashMap> selectlistSpViewNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_SP_S_00", apiNextezSVO);};
	public List<LowerHashMap> selectlistSpLikeNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_SP_S_01", apiNextezSVO);};
	public List<LowerHashMap> selectlistSpShareNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_SP_S_02", apiNextezSVO);};
	public List<LowerHashMap> selectlistSpPointNextez(ApiNextezSVO apiNextezSVO){return (List<LowerHashMap>) list("API_NEXTEZ_SP_S_03", apiNextezSVO);};

	public void insertRcApiLog(APIRCLOGVO apiRcLogVO) {
		insert("APIRC_LOG_I_00", apiRcLogVO);
	}

	public int daehongPreventSaleNum(String telNum) {
		return (int)select("DAEHONGEVENT_S_00", telNum);
	}
	public List<LowerHashMap> hdcReqCnt(){return (List<LowerHashMap>) list("API_HDC_S00");};
	public String corpCert(Map<String,Object> map){return (String) select("API_MALL_S01", map);};
	public String selectCorpId(Map<String,Object> map){return (String) select("API_MALL_S00", map);};
	public List<HashMap<String,Object>> selectMallRsvList(Map<String,Object> map){return (List<HashMap<String,Object>>) list("API_MALL_S02", map);};
	public List<HashMap<String,Object>> selectMallRsvDetail(Map<String,Object> map){return (List<HashMap<String,Object>>) list("API_MALL_S03", map);};
	public void updatePrdt(Map<String,Object> map){update("API_MALL_U00", map);};
	public void updateDiv(Map<String,Object> map){update("API_MALL_U01", map);};
	public void updateOpt(Map<String,Object> map){update("API_MALL_U02", map);};
	
	public List<LowerHashMap> prmtAuthList(PRMTVO prmtVO){return (List<LowerHashMap>) list("API_PRMT_S00", prmtVO);};
}
