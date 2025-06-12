package oss.cmm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.cmm.vo.pageDefaultVO;
import oss.corp.vo.CMSSVO;
import oss.corp.vo.CMSSPGVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;



@Repository("cmssDAO")
public class CmssDAO extends EgovAbstractDAO {

	/**
	 * 수수료 리스트 조회
	 * 파일명 : selectCmssList
	 * 작성일 : 2016. 8. 10. 오후 5:34:18
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CMSSVO> selectCmssList(pageDefaultVO searchVO) {
		return (List<CMSSVO>) list("CMSS_S_01", searchVO);
	}

	/**
	 * 수수료 리스트 카운트
	 * 파일명 : getCntCmssList
	 * 작성일 : 2016. 8. 10. 오후 5:35:07
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	public Integer getCntCmssList(pageDefaultVO searchVO) {
		return (Integer) select("CMSS_S_02", searchVO);
	}

	/**
	 * 수수료 등록
	 * 파일명 : insertCmss
	 * 작성일 : 2016. 8. 11. 오후 1:42:11
	 * 작성자 : 최영철
	 * @param cmssVO
	 */
	public void insertCmss(CMSSVO cmssVO) {
		insert("CMSS_I_00", cmssVO);
	}

	/**
	 * 수수료 단건 조회
	 * 파일명 : selectByCmss
	 * 작성일 : 2016. 8. 11. 오후 2:56:57
	 * 작성자 : 최영철
	 * @param cmssVO
	 * @return
	 */
	public CMSSVO selectByCmss(CMSSVO cmssVO) {
		return (CMSSVO) select("CMSS_S_00", cmssVO);
	}

	/**
	 * 수수료 수정
	 * 파일명 : updateCmss
	 * 작성일 : 2016. 8. 11. 오후 3:07:05
	 * 작성자 : 최영철
	 * @param cmssVO
	 */
	public void updateCmss(CMSSVO cmssVO) {
		update("CMSS_U_00", cmssVO);
		insert("CMSSCONFHIST_I_02", cmssVO);
	}

	/**
	 * B2C 수수료 전체 조회
	 * 파일명 : selectCmssList
	 * 작성일 : 2016. 8. 12. 오전 10:42:13
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CMSSVO> selectCmssList() {
		return (List<CMSSVO>) list("CMSS_S_03", "");
	}

	/**
	 * 수수료 이력 등록
	 * 파일명 : insertCmssConfHist
	 * 작성일 : 2016. 8. 16. 오전 10:10:28
	 * 작성자 : 최영철
	 * @param cmssVO
	 */
	public void insertCmssConfHist(CMSSVO cmssVO) {
		insert("CMSSCONFHIST_I_01", cmssVO);
	}

	/**
	 * 해당 수수료를 사용하고 있는 업체 카운트
	 * 파일명 : deleteChkCmss
	 * 작성일 : 2016. 8. 18. 오후 1:15:08
	 * 작성자 : 최영철
	 * @param cmssVO
	 * @return
	 */
	public Integer deleteChkCmss(CMSSVO cmssVO) {
		return (Integer) select("CMSS_S_04", cmssVO);
	}

	/**
	 * 수수료 삭제
	 * 파일명 : deleteCmss
	 * 작성일 : 2016. 8. 18. 오후 1:23:52
	 * 작성자 : 최영철
	 * @param cmssVO
	 */
	public void deleteCmss(CMSSVO cmssVO) {
		delete("CMSS_D_00", cmssVO);
	}
	
	/**
	 * B2B 수수료 전체 조회
	 * 파일명 : selectB2BCmssList
	 * 작성일 : 2016. 9. 19. 오전 11:39:38
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CMSSVO> selectB2bCmssList() {
		return (List<CMSSVO>) list("CMSS_S_05", "");
	}
	
	/**
	 * PG사 수수료 리스트 조회
	 * 파일명 : selectCmssPgList
	 * 작성일 : 2020.10.30
	 * 작성자 : 김지연
	 * @param searchVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CMSSPGVO> selectCmssPgList(pageDefaultVO searchVO) {
		return (List<CMSSPGVO>) list("CMSS_PG_S_01", searchVO);
	}
	
	/**
	 * PG사 수수료 리스트 카운트
	 * 파일명 : getCntCmssPgList
	 * 작성일 : 2020.10.30
	 * 작성자 : 김지연
	 * @param searchVO
	 * @return
	 */
	public Integer getCntCmssPgList(pageDefaultVO searchVO) {
		return (Integer) select("CMSS_PG_S_02", searchVO);
	}
	
	/**
	 * PG사 수수료 등록
	 * 파일명 : insertCmssPg
	 * 작성일 : 2020.11.02
	 * 작성자 : 김지연
	 * @param cmssVO
	 */
	public void insertCmssPg(CMSSPGVO cmssPgVO) {
		insert("CMSS_PG_I_00", cmssPgVO);
	}	

	/**
	 * PG사 수수료 삭제
	 * 파일명 : deleteCmssPg
	 * 작성일 : 2020.11.02
	 * 작성자 : 김지연
	 * @param cmssVO
	 */
	public void deleteCmssPg(CMSSPGVO cmssPgVO) {
		delete("CMSS_PG_D_00", cmssPgVO);
	}
	
	/**
	 * PG사 수수료 단건 조회
	 * 파일명 : selectByCmssPg
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 * @return
	 */
	public CMSSPGVO selectByCmssPg(CMSSPGVO cmssPgVO) {
		return (CMSSPGVO) select("CMSS_PG_S_00", cmssPgVO);
	}	
	
	/**
	 * PG사 수수료 수정
	 * 파일명 : updateCmssPg
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 */
	public void updateCmssPg(CMSSPGVO cmssPgVO) {
		update("CMSS_PG_U_00", cmssPgVO);
	}	
	
	/**
	 * PG사 수수료 날짜 중복 체크
	 * 파일명 : checkAplDt
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 * @return
	 */
	public Integer checkAplDt(CMSSPGVO cmssPgVO) {
		return  (Integer) select("CMSS_PG_S_03", cmssPgVO);
	}		
}
