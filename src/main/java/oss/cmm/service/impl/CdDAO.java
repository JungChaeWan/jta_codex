package oss.cmm.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.cmm.vo.CDSVO;
import oss.cmm.vo.CDVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


/**
 * <pre>
 * 파 일 명 : CdDAO.java
 * 작 성 일 : 2015. 9. 17. 오전 10:38:15
 * 작 성 자 : 최영철
 */
@Repository("cdDAO")
public class CdDAO extends EgovAbstractDAO {

	/**
	 * 코드 리스트 조회(페이징)
	 * 파일명 : selectCodeList
	 * 작성일 : 2015. 9. 23. 오전 9:30:43
	 * 작성자 : 최영철
	 * @param cdSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CDVO> selectCodeList(CDSVO cdSVO) {
		return (List<CDVO>) list("CD_S_01", cdSVO);
	}

	/**
	 * 코드 전체 카운트
	 * 파일명 : getCntCodeList
	 * 작성일 : 2015. 9. 23. 오전 9:30:54
	 * 작성자 : 최영철
	 * @param cdSVO
	 * @return
	 */
	public Integer getCntCodeList(CDSVO cdSVO) {
		return (Integer) select("CD_S_02", cdSVO);
	}

	/**
	 * 코드 등록
	 * 파일명 : insertCode
	 * 작성일 : 2015. 9. 23. 오후 1:30:39
	 * 작성자 : 최영철
	 * @param cdVO
	 */
	public void insertCode(CDVO cdVO) {
		insert("CD_I_00", cdVO);
	}

	/**
	 * 상위 코드 전체 조회
	 * 파일명 : selectHrkCodeList
	 * 작성일 : 2015. 9. 23. 오후 1:43:22
	 * 작성자 : 최영철
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CDVO> selectHrkCodeList() {
		return (List<CDVO>) list("CD_S_03", "");
	}

	/**
	 * 코드 단건 조회
	 * 파일명 : selectByCd
	 * 작성일 : 2015. 9. 23. 오후 2:27:10
	 * 작성자 : 최영철
	 * @param cdVO
	 * @return
	 */
	public CDVO selectByCd(CDVO cdVO) {
		return (CDVO) select("CD_S_00", cdVO);
	}

	/**
	 * 코드 수정
	 * 파일명 : updateCode
	 * 작성일 : 2015. 9. 23. 오후 2:56:56
	 * 작성자 : 최영철
	 * @param cdVO
	 */
	public void updateCode(CDVO cdVO) {
		update("CD_U_00", cdVO);
	}

	/**
	 * 노출 순번 최대값 구하기
	 * 파일명 : selectByMaxViewSn
	 * 작성일 : 2015. 9. 23. 오후 4:53:32
	 * 작성자 : 최영철
	 * @param cdVO
	 * @return
	 */
	public Integer selectByMaxViewSn(CDVO cdVO) {
		return (Integer) select("CD_S_04", cdVO);
	}

	/**
	 * 노출 순번 증가
	 * 파일명 : addViewSn
	 * 작성일 : 2015. 9. 23. 오후 5:11:27
	 * 작성자 : 최영철
	 * @param oldVO
	 */
	public void addViewSn(CDVO oldVO) {
		update("CD_U_01", oldVO);
	}

	/**
	 * 노출 순번 감소
	 * 파일명 : minusViewSn
	 * 작성일 : 2015. 9. 23. 오후 5:12:51
	 * 작성자 : 최영철
	 * @param oldVO
	 */
	public void minusViewSn(CDVO oldVO) {
		update("CD_U_02", oldVO);
	}

	/**
	 * 코드 삭제
	 * 파일명 : deleteCode
	 * 작성일 : 2015. 9. 25. 오후 1:49:29
	 * 작성자 : 최영철
	 * @param cdVO
	 */
	public void deleteCode(CDVO cdVO) {
		delete("CD_D_00", cdVO);
	}

	/**
	 * 상위 코드에 대한 하위 코드 조회
	 * 파일명 : selectCode
	 * 작성일 : 2015. 10. 1. 오후 6:35:29
	 * 작성자 : 최영철
	 * @param cdSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CDVO> selectCode(CDSVO cdSVO) {
		return (List<CDVO>) list("CD_S_05", cdSVO);
	}


}
