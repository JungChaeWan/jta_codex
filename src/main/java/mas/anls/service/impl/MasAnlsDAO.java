package mas.anls.service.impl;

import java.util.List;

import mas.anls.vo.ANLSOPTVO;
import mas.anls.vo.ANLSSVO;
import mas.anls.vo.ANLSVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


@Repository("masAnlsDAO")
public class MasAnlsDAO extends EgovAbstractDAO {

	/**
	 * 숙박 상품별 누적 통계
	 * 파일명 : selectAdAnls01
	 * 작성일 : 2015. 12. 14. 오후 8:38:13
	 * 작성자 : 최영철
	 * @param adAnlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSVO> selectAdAnls01(ANLSSVO adAnlsSVO) {
		return (List<ANLSVO>) list("AD_ANLS_S_00", adAnlsSVO);
	}

	/**
	 * 렌터카 상품별 누적 통계
	 * 파일명 : selectRcAnls01
	 * 작성일 : 2015. 12. 14. 오후 10:09:56
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSVO> selectRcAnls01(ANLSSVO anlsSVO) {
		return (List<ANLSVO>) list("RC_ANLS_S_00", anlsSVO);
	}

	/**
	 * 소셜상품 상품별 누적 통계
	 * 파일명 : seelctSpAnls01
	 * 작성일 : 2015. 12. 14. 오후 11:00:53
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSVO> seelctSpAnls01(ANLSSVO anlsSVO) {
		return (List<ANLSVO>) list("SP_ANLS_S_00", anlsSVO);
	}

	/**
	 * 숙박 연도별 통계 - 예약일자별
	 * 파일명 : selectAdAnls02
	 * 작성일 : 2015. 12. 16. 오후 1:21:03
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSVO> selectAdAnls02(ANLSSVO anlsSVO) {
		return (List<ANLSVO>) list("AD_ANLS_S_03", anlsSVO);
	}
	
	/**
	 * 렌터카 연도별 통계 - 예약일자별
	 * 파일명 : selectRcAnls02
	 * 작성일 : 2015. 12. 16. 오후 1:21:03
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSVO> selectRcAnls02(ANLSSVO anlsSVO) {
		return (List<ANLSVO>) list("RC_ANLS_S_03", anlsSVO);
	}

	/**
	 * 소셜 연도별 통계 - 예약일자별
	 * 파일명 : selectSpAnls02
	 * 작성일 : 2015. 12. 16. 오후 1:21:03
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSVO> selectSpAnls02(ANLSSVO anlsSVO) {
		return (List<ANLSVO>) list("SP_ANLS_S_03", anlsSVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<ANLSVO> selectSvAnls02(ANLSSVO anlsSVO) {
		return (List<ANLSVO>) list("SV_ANLS_S_06", anlsSVO);
	}
	
	/**
	 * 숙박 월별 통계 - 예약일자별
	 * 파일명 : selectAdAnls02Dtl
	 * 작성일 : 2015. 12. 16. 오후 4:25:33
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSVO> selectAdAnls02Dtl(ANLSSVO anlsSVO) {
		return (List<ANLSVO>) list("AD_ANLS_S_04", anlsSVO);
	}
	
	/**
	 * 렌터카 월별 통계 - 예약일자별
	 * 파일명 : selectRcAnls02Dtl
	 * 작성일 : 2015. 12. 16. 오후 4:25:33
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSVO> selectRcAnls02Dtl(ANLSSVO anlsSVO) {
		return (List<ANLSVO>) list("RC_ANLS_S_04", anlsSVO);
	}

	/**
	 * 소셜 월별 통계 - 예약일자별
	 * 파일명 : selectSpAnls02Dtl
	 * 작성일 : 2015. 12. 16. 오후 4:25:33
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSVO> selectSpAnls02Dtl(ANLSSVO anlsSVO) {
		return (List<ANLSVO>) list("SP_ANLS_S_04", anlsSVO);
	}
	/**
	 * 소셜 옵션 월별 통계 - 예약일자 옵션별
	 * 파일명 : selectSpAnls02Dtl
	 * 작성일 : 2015. 12. 16. 오후 4:25:33
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ANLSOPTVO> selectSpAnls02Opt(ANLSSVO anlsSVO) {
		return (List<ANLSOPTVO>) list("SP_ANLS_S_05", anlsSVO);
	}


}
