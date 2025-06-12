package oss.anls.service.impl;

import java.util.List;

import mas.anls.vo.ANLS05VO;
import mas.anls.vo.ANLS06VO;
import mas.anls.vo.ANLSSVO;
import mas.anls.vo.ANLSVO;

import org.springframework.stereotype.Repository;

import oss.anls.vo.ANLS07VO;
import oss.anls.vo.ANLS08VO;
import oss.anls.vo.ANLS10VO;
import oss.anls.vo.ANLS11VO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


@Repository("ossAnlsDAO")
public class OssAnlsDAO extends EgovAbstractDAO {

	/**
	 * 예약일별 월별 매출 통계
	 * 파일명 : selectAnls02
	 * 작성일 : 2016. 1. 13. 오후 4:08:22
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSVO> selectAnls02(ANLSSVO anlsSVO) {
		return (List<ANLSVO>) list("ANLS_S_03", anlsSVO);
	}

	/**
	 * 예약일별 매출 통계
	 * 파일명 : selectSpAnls02Dtl
	 * 작성일 : 2016. 1. 13. 오후 4:24:15
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSVO> selectSpAnls02Dtl(ANLSSVO anlsSVO) {
		return (List<ANLSVO>) list("ANLS_S_04", anlsSVO);
	}

	/**
	 * 사용자 일별 유입 현황
	 * 파일명 : selectJoinAnls
	 * 작성일 : 2016. 1. 18. 오후 2:47:34
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	public ANLS05VO selectJoinAnls(ANLSSVO anlsSVO) {
		return (ANLS05VO) select("ANLS_S_05", anlsSVO);
	}

	/**
	 * 예약 일별 현황
	 * 파일명 : selectAnls06
	 * 작성일 : 2016. 1. 18. 오후 3:41:03
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLS06VO> selectAnls06(ANLSSVO anlsSVO) {
		return (List<ANLS06VO>) list("ANLS_S_06", anlsSVO);
	}

	/**
	 * 매출통계
	 * 파일명 : selectAnls04
	 * 작성일 : 2016. 3. 17. 오후 6:36:51
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	public ANLS07VO selectAnls04(ANLSSVO anlsSVO) {
		return (ANLS07VO) select("ANLS_S_07", anlsSVO);
	}

	/**
	 * 취소통계
	 * 파일명 : selectCancelAnls04
	 * 작성일 : 2016. 3. 17. 오후 6:40:36
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	public ANLS08VO selectCancelAnls04(ANLSSVO anlsSVO) {
		return (ANLS08VO) select("ANLS_S_08", anlsSVO);
	}

	/**
	 * 고객통계1
	 * 파일명 : selectAnls09
	 * 작성일 : 2016. 3. 18. 오전 10:43:21
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLS05VO> selectAnls09(ANLSSVO anlsSVO) {
		return (List<ANLS05VO>) list("ANLS_S_09", anlsSVO);
	}

	/**
	 * 고객 효율성
	 * 파일명 : selectAnls10
	 * 작성일 : 2016. 3. 18. 오후 2:37:15
	 * 작성자 : 최영철
	 * @return
	 */
	public ANLS10VO selectAnls10() {
		return (ANLS10VO) select("ANLS_S_10", "");
	}

	/**
	 * 년월별 매출 통계
	 * 파일명 : selectAnls11
	 * 작성일 : 2016. 3. 18. 오후 4:27:47
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLS11VO> selectAnls11(ANLSSVO anlsSVO) {
		return (List<ANLS11VO>) list("ANLS_S_11", anlsSVO);
	}



}
