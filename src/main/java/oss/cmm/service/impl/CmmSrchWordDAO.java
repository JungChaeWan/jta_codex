package oss.cmm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.cmm.vo.CM_SRCHWORDVO;
import oss.cmm.vo.ISEARCHVO;
import oss.cmm.vo.pageDefaultVO;
import oss.corp.vo.CMSSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("cmmSrchWordDAO")
public class CmmSrchWordDAO extends EgovAbstractDAO {

	/**
	 * 검색어 삭제
	 * 파일명 : deleteSrchWord
	 * 작성일 : 2016. 7. 27. 오전 11:31:39
	 * 작성자 : 최영철
	 * @param srchWordVO
	 */
	public void deleteSrchWord(CM_SRCHWORDVO srchWordVO) {
		delete("CM_SRCHWORD_D_00", srchWordVO);
	}

	/**
	 * 검색어 등록
	 * 파일명 : mergeSrchWord
	 * 작성일 : 2016. 7. 27. 오전 11:33:57
	 * 작성자 : 최영철
	 * @param srchWordVO
	 */
	public void mergeSrchWord(CM_SRCHWORDVO srchWordVO) {
		update("CM_SRCHWORD_M_00", srchWordVO);
	}

	/**
	 * 검색어 조회
	 * 파일명 : getSrchWord
	 * 작성일 : 2016. 7. 27. 오후 2:45:31
	 * 작성자 : 최영철
	 * @param srchWordVO
	 * @return
	 */
	public String getSrchWord(CM_SRCHWORDVO srchWordVO) {
		return (String) select("CM_SRCHWORD_S_01", srchWordVO);
	}

	/**
	 * 검색어 통계 추가
	 * 파일명 : mergeSrchWordAnls
	 * 작성일 : 2016. 7. 29. 오후 5:03:51
	 * 작성자 : 최영철
	 * @param search
	 */
	public void mergeSrchWordAnls(String search) {
		update("CM_SRCHWORDANLS_M_00", search);
	}

	@SuppressWarnings("unchecked")
	public List<CM_SRCHWORDVO> selectSrchWordList(CM_SRCHWORDVO srchWordVO) {
		return (List<CM_SRCHWORDVO>) list("CM_SRCHWORD_S_02", srchWordVO);
	}

	@SuppressWarnings("unchecked")
	public List<ISEARCHVO> selectIsearchWords(ISEARCHVO isearchvo){
        return (List<ISEARCHVO>) list("ISEARCH_WORDS_S_00", isearchvo);
    }

	public void insertIsearchWords(ISEARCHVO isearchvo) {
		update("ISEARCH_WORDS_I_00", isearchvo);
	}

	public void deleteIsearchWords(ISEARCHVO isearchvo) {
		update("ISEARCH_WORDS_D_00", isearchvo);
	}

}
