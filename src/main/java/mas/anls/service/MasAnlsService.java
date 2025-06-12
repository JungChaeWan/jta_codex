package mas.anls.service;

import java.util.List;

import mas.anls.vo.ANLSOPTVO;
import mas.anls.vo.ANLSSVO;
import mas.anls.vo.ANLSVO;




public interface MasAnlsService {

	/**
	 * 숙박 상품별 누적 통계
	 * 파일명 : selectAdAnls01
	 * 작성일 : 2015. 12. 14. 오후 8:38:13
	 * 작성자 : 최영철
	 * @param adAnlsSVO
	 * @return
	 */
	List<ANLSVO> selectAdAnls01(ANLSSVO adAnlsSVO);

	/**
	 * 렌터카 상품별 누적 통계
	 * 파일명 : selectRcAnls01
	 * 작성일 : 2015. 12. 14. 오후 10:08:51
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSVO> selectRcAnls01(ANLSSVO anlsSVO);

	/**
	 * 소셜상품 상품별 누적 통계
	 * 파일명 : selectSpAnls01
	 * 작성일 : 2015. 12. 14. 오후 10:59:57
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSVO> selectSpAnls01(ANLSSVO anlsSVO);

	/**
	 * 숙박 연도별 매출 통계
	 * 파일명 : selectAdAnls02
	 * 작성일 : 2015. 12. 16. 오후 1:14:43
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSVO> selectAdAnls02(ANLSSVO anlsSVO);
	
	/**
	 * 렌터카 연도별 매출 통계
	 * 파일명 : selectRcAnls02
	 * 작성일 : 2015. 12. 16. 오후 1:14:43
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSVO> selectRcAnls02(ANLSSVO anlsSVO);

	/**
	 * 소셜 연도별 매출 통계
	 * 파일명 : selectSpAnls02
	 * 작성일 : 2015. 12. 16. 오후 1:14:43
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSVO> selectSpAnls02(ANLSSVO anlsSVO);
	
	/**
	 * 소셜 연도별 매출 통계
	 * 파일명 : selectSpAnls02
	 * 작성일 : 2015. 12. 16. 오후 1:14:43
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSVO> selectSvAnls02(ANLSSVO anlsSVO);

	/**
	 * 숙박 월별 매출 통계
	 * 파일명 : selectAdAnls02Dtl
	 * 작성일 : 2015. 12. 16. 오후 4:22:49
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSVO> selectAdAnls02Dtl(ANLSSVO anlsSVO);
	
	/**
	 * 렌터카 월별 매출 통계
	 * 파일명 : selectRcAnls02Dtl
	 * 작성일 : 2015. 12. 16. 오후 4:22:49
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSVO> selectRcAnls02Dtl(ANLSSVO anlsSVO);

	/**
	 * 소셜 월별 매출 통계
	 * 파일명 : selectSpAnls02Dtl
	 * 작성일 : 2015. 12. 16. 오후 4:22:49
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSVO> selectSpAnls02Dtl(ANLSSVO anlsSVO);

	/**
	 * 소셜 월별 옵션 매출 통계
	 * 파일명 : selectSpAnls02Opt
	 * 작성일 : 2015. 12. 16. 오후 4:22:49
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSOPTVO> selectSpAnls02Opt(ANLSSVO anlsSVO);

}
