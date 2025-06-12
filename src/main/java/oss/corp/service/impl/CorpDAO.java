package oss.corp.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import mas.corp.vo.DLVCORPVO;
import oss.bis.vo.BISSVO;
import oss.corp.vo.*;


/**
 * <pre>
 * 파 일 명 : CorpDAO.java
 * 작 성 일 : 2015. 9. 17. 오전 10:38:15
 * 작 성 자 : 최영철
 */
/**
 * <pre>
 * 파일명 : CorpDAO.java
 * 작성일 : 2015. 10. 22. 오후 4:38:32
 * 작성자 : 최영철
 */
@Repository("corpDAO")
public class CorpDAO extends EgovAbstractDAO {

	/**
	 * 업체정보 등록
	 * 파일명 : insertCorp
	 * 작성일 : 2015. 9. 17. 오전 11:33:21
	 * 작성자 : 최영철
	 * @param corpVO
	 */
	public String insertCorp(CORPVO corpVO) {
		return (String) insert("CORP_I_00", corpVO);
	}

	@SuppressWarnings("unchecked")
	public List<CORPVO> selectCorpList(CORPSVO corpSVO) {
		return (List<CORPVO>) list("CORP_S_01", corpSVO);
	}

	public Integer getCntCorpList(CORPSVO corpSVO) {
		return (Integer) select("CORP_S_02", corpSVO);
	}

	public CORPVO selectByCorp(CORPSVO corpSVO) {
		return (CORPVO) select("CORP_S_03", corpSVO);
	}
	public CORPVO selectByCorpVisitJeju(CORPSVO corpSVO) {
		return (CORPVO) select("CORP_S_11", corpSVO);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<CORPVO> selectCorpListSMSMail(CORPVO corpVO) {
		return (List<CORPVO>) list("CORP_S_07", corpVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<CORPVO> selectCorpListSMSMail(CORPSVO corpSVO) {
		return (List<CORPVO>) list("CORP_S_08", corpSVO);
	}

	public Integer getCntCorpListSMSMail(CORPSVO corpSVO) {
		return (Integer) select("CORP_S_09", corpSVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<CORPVO> selectCorpListExcel(CORPSVO corpSVO) {
		return (List<CORPVO>) list("CORP_S_10", corpSVO);
	}
	
	
	public CORPVO selectCorpByCorpId(CORPVO corpVO) {
		return (CORPVO) select("CORP_S_00", corpVO);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<CORPADMVO> selectCorpAdmList(CORPADMVO corpAdmVO) {
		return (List<CORPADMVO>) list("CORPADM_S_02", corpAdmVO);
	}
	

	/**
	 * 업체 기본정보 수정
	 * 파일명 : updateCorp
	 * 작성일 : 2015. 9. 21. 오후 4:37:24
	 * 작성자 : 최영철
	 * @param corpVO
	 */
	public void updateCorp(CORPVO corpVO) {
		update("CORP_U_01", corpVO);
	}

	public void updatePrdtInfo(CORPVO corpVO) {
		update("CORP_U_08", corpVO);
	}

	/**
	 * 업체관리자 등록
	 * 파일명 : insertCorpAdm
	 * 작성일 : 2015. 10. 1. 오후 8:53:15
	 * 작성자 : 최영철
	 * @param corpAdmVO
	 */
	public void insertCorpAdm(CORPADMVO corpAdmVO) {
		insert("CORPADM_I_00", corpAdmVO);
	}

	/**
	 * 업체관리자 MERGE
	 * 파일명 : mergeCorpAdm
	 * 작성일 : 2015. 10. 2. 오전 9:50:19
	 * 작성자 : 최영철
	 * @param corpAdmVO
	 */
	public void mergeCorpAdm(CORPADMVO corpAdmVO) {
		update("CORPADM_M_00", corpAdmVO);
	}

	/**
	 * 업체관리자 삭제
	 * 파일명 : deleteCorpAdm
	 * 작성일 : 2015. 10. 2. 오전 9:51:47
	 * 작성자 : 최영철
	 * @param corpAdmVO
	 */
	public void deleteCorpAdm(CORPADMVO corpAdmVO) {
		delete("CORPADM_D_00", corpAdmVO);
	}

	/**
	 * 렌터카 업체 전체 조회
	 * 파일명 : selectRcCorpList
	 * 작성일 : 2015. 10. 22. 오후 4:38:34
	 * 작성자 : 최영철
	 * @param corpVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CORPVO> selectRcCorpList(CORPVO corpVO) {
		return (List<CORPVO>) list("CORP_S_04", corpVO);
	}

	public CORPVO selectByCorpSpAddInfo(CORPVO corpVO) {
		return (CORPVO) select("CORP_S_05", corpVO);
	}

	public void updateCouponBySpAddInfo(CORPVO corpVO) {
		update("CORP_U_02", corpVO);
		
	}

	/**
	 * <pre>
	 * 파일명 : updateMasCorp
	 * 작성일 : 2015. 12. 14. 오후 9:56:08
	 * 작성자 : 함경태
	 * @param corpVO
	 */
	public void updateMasCorp(CORPVO corpVO) {
		update("CORP_U_03", corpVO);		
	}

	@SuppressWarnings("unchecked")
	public List<CORPVO> selectCorpDistList(CORPVO corpVO) {
		return (List<CORPVO>) list("CORP_S_06", corpVO);
	}

	/**
	 * 하이제주 매핑 해제
	 * 파일명 : updateNonMapping
	 * 작성일 : 2016. 9. 5. 오전 11:52:01
	 * 작성자 : 최영철
	 * @param corpVO
	 */
	/*public void updateNonMapping(CORPVO corpVO) {
		update("CORP_U_04", corpVO);
	}*/
	
	/**
	 * Visit제주 매핑 해제
	 * Function : updateNonVisitMapping
	 * 작성일 : 2018. 2. 2. 오전 12:10:43
	 * 작성자 : 정동수
	 * @param corpVO
	 */
	public void updateNonVisitMapping(CORPVO corpVO) {
		update("CORP_U_06", corpVO);
	}

	/**
	 * 배송업체 리스트
	 * @param corpVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<DLVCORPVO> selectDlvCorpList(CORPVO corpVO) {
		return (List<DLVCORPVO>) list("DLV_CORP_S_02", corpVO);
	}

	/**
	 * 기념품업체의 배송업체 리스트
	 * @param corpVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<DLVCORPVO> selectDlvCorpListByCorp(CORPVO corpVO) {
		return (List<DLVCORPVO>) list("DLV_CORP_S_00", corpVO);
	}

	public void deleteDlvCorpMng(DLVCORPVO dlvCorpVO) {
		delete("DLV_MNG_D_00", dlvCorpVO);
	}

	public void insertDlvCorpMng(DLVCORPVO dlvCorpVO) {
		insert("DLV_MNG_I_00", dlvCorpVO);
	}

	/**
	 * 업체 광고정보 조회
	 * 파일명 : selectCorpAdtmMng
	 * 작성일 : 2017. 2. 24. 오후 4:10:35
	 * 작성자 : 최영철
	 * @param corpVO
	 * @return
	 */
	public CORPADTMMNGVO selectCorpAdtmMng(CORPVO corpVO) {
		return (CORPADTMMNGVO) select("CORP_ADTMMNG_S_00", corpVO);
	}

	/**
	 * 업체 광고 정보 수정
	 * 파일명 : updateCorpAdtm
	 * 작성일 : 2017. 2. 28. 오전 11:06:31
	 * 작성자 : 최영철
	 * @param corpAdtmMngVO
	 */
	public void updateCorpAdtm(CORPADTMMNGVO corpAdtmMngVO) {
		update("CORP_ADTMMNG_M_00", corpAdtmMngVO);
	}
	
	/**
	 * 업체 지수 리스트 출력
	 * 파일명 : selectCorpLevel
	 * 작성일 : 2017. 9. 28. 오전 10:40:18
	 * 작성자 : 정동수
	 * @param bisSVO 
	 * @return 
	 */
	@SuppressWarnings("unchecked")
	public List<CORPLEVELVO> selectCorpLevel(BISSVO bisSVO) {
		return (List<CORPLEVELVO>) list("CORP_LEVEL_S_00", bisSVO);
	}
	
	/**
	 * 업체 지수 정보 출력
	 * 파일명 : selectCorpLevelInfo
	 * 작성일 : 2017. 10. 10. 오전 10:48:45
	 * 작성자 : 정동수
	 * @param corpId 
	 */
	public CORPLEVELVO selectCorpLevelInfo(String corpId) {
		return (CORPLEVELVO) select("CORP_LEVEL_S_01", corpId);
	}	
		
	/**
	 * 업체 지수 정보 수정
	 * 파일명 : selectCorpLevelInfo
	 * 작성일 : 2017. 10. 10. 오전 10:49:12
	 * 작성자 : 정동수
	 * @param corpId 
	 */
	public void updateLevelModInfo(CORPLEVELVO corpLevelVO) {
		update("CORP_LEVEL_U_00", corpLevelVO);
	}	
	
	/**
	 * 추천 여행사 상품 업체 리스트
	 * Function : selectCorpRcmdList
	 * 작성일 : 2017. 12. 31. 오후 4:18:55
	 * 작성자 : 정동수
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CORPRCMDVO> selectCorpRcmdList(CORPRCMDVO corpRcmdVO) {
		return (List<CORPRCMDVO>) list("CORP_RCMD_S_00", corpRcmdVO);
	}
	
	/**
	 * 추천 여행사 상품 업체 저장
	 * Function : insertCorpRcmd
	 * 작성일 : 2017. 12. 31. 오후 4:13:59
	 * 작성자 : 정동수
	 * @param corpRcmdVO
	 */
	public void insertCorpRcmd(CORPRCMDVO corpRcmdVO) {
		update("CORP_RCMD_I_00", corpRcmdVO);
	}
	
	/**
	 * 추천 여행사 상품 업체 삭제
	 * Function : deleteCorpRcmd
	 * 작성일 : 2017. 12. 31. 오후 4:14:02
	 * 작성자 : 정동수
	 */
	public void deleteCorpRcmd() {
		update("CORP_RCMD_D_00");
	}

	public void updateTamnacardMng(TAMNACARDSVO tamnacardsvo) {
		update("CORP_U_07",tamnacardsvo);
	}
}