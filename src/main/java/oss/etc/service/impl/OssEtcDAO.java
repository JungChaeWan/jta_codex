package oss.etc.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import web.etc.vo.SCCSVO;
import web.etc.vo.SCCVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("ossEtcDAO")
public class OssEtcDAO extends EgovAbstractDAO {

	/**
	 * 홍보영상 리스트 조회
	 * 파일명 : selectSccList
	 * 작성일 : 2017. 3. 3. 오후 5:07:14
	 * 작성자 : 최영철
	 * @param sccSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SCCVO> selectSccList(SCCSVO sccSVO) {
		return (List<SCCVO>) list("SCC_S_01", sccSVO);
	}

	/**
	 * 홍보영상 리스트 카운트
	 * 파일명 : selectSccListCnt
	 * 작성일 : 2017. 3. 3. 오후 5:09:18
	 * 작성자 : 최영철
	 * @param sccSVO
	 * @return
	 */
	public Integer selectSccListCnt(SCCSVO sccSVO) {
		return (Integer) select("SCC_S_02", sccSVO);
	}

	/**
	 * 홍보영상 등록
	 * 파일명 : insertScc
	 * 작성일 : 2017. 3. 6. 오후 2:21:57
	 * 작성자 : 최영철
	 * @param sccVO
	 */
	public void insertScc(SCCVO sccVO) {
		insert("SCC_I_01", sccVO);
	}

	/**
	 * 홍보영상 단건 조회
	 * 파일명 : selectByScc
	 * 작성일 : 2017. 3. 6. 오후 3:55:59
	 * 작성자 : 최영철
	 * @param sccVO
	 * @return 
	 */
	public SCCVO selectByScc(SCCVO sccVO) {
		return (SCCVO) select("SCC_S_00", sccVO);
	}

	/**
	 * 홍보영상 삭제
	 * 파일명 : deleteScc
	 * 작성일 : 2017. 3. 6. 오후 4:39:46
	 * 작성자 : 최영철
	 * @param sccVO
	 */
	public void deleteScc(SCCVO sccVO) {
		delete("SCC_D_00", sccVO);
	}

	/**
	 * 홍보영상 수정
	 * 파일명 : updateScc
	 * 작성일 : 2017. 3. 6. 오후 5:39:59
	 * 작성자 : 최영철
	 * @param sccVO
	 */
	public void updateScc(SCCVO sccVO) {
		update("SCC_U_00", sccVO);
	}

	/**
	 * 사용자 홍보영상 리스트 조회
	 * 파일명 : selectWebSccList
	 * 작성일 : 2017. 3. 7. 오전 9:48:15
	 * 작성자 : 최영철
	 * @param sccSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SCCVO> selectWebSccList(SCCSVO sccSVO) {
		return (List<SCCVO>) list("SCC_S_03", sccSVO);
	}

	/**
	 * 사용자 홍보영상 리스트 카운트
	 * 파일명 : selectWebSccListCnt
	 * 작성일 : 2017. 3. 7. 오전 9:48:56
	 * 작성자 : 최영철
	 * @param sccSVO
	 * @return
	 */
	public Integer selectWebSccListCnt(SCCSVO sccSVO) {
		return (Integer) select("SCC_S_04", sccSVO);
	}

}
