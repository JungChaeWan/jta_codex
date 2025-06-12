package oss.anls.service;

import java.util.List;

import mas.anls.vo.ANLS05VO;
import mas.anls.vo.ANLS06VO;
import mas.anls.vo.ANLSSVO;
import mas.anls.vo.ANLSVO;
import oss.anls.vo.ANLS07VO;
import oss.anls.vo.ANLS08VO;
import oss.anls.vo.ANLS10VO;
import oss.anls.vo.ANLS11VO;





public interface OssAnlsService {

	/**
	 * 월별 매출 통계
	 * 파일명 : selectAnls02
	 * 작성일 : 2016. 1. 13. 오후 4:06:57
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSVO> selectAnls02(ANLSSVO anlsSVO);

	/**
	 * 일별 매출 통계
	 * 파일명 : selectSpAnls02Dtl
	 * 작성일 : 2016. 1. 13. 오후 4:23:39
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLSVO> selectSpAnls02Dtl(ANLSSVO anlsSVO);

	/**
	 * 사용자 일별 유입 현황
	 * 파일명 : selectJoinAnls
	 * 작성일 : 2016. 1. 18. 오후 2:46:45
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	ANLS05VO selectJoinAnls(ANLSSVO anlsSVO);

	/**
	 * 예약 일별 현황
	 * 파일명 : selectAnls06
	 * 작성일 : 2016. 1. 18. 오후 3:40:17
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLS06VO> selectAnls06(ANLSSVO anlsSVO);

	/**
	 * 매출통계
	 * 파일명 : selectAnls04
	 * 작성일 : 2016. 3. 17. 오후 6:36:00
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	ANLS07VO selectAnls04(ANLSSVO anlsSVO);

	/**
	 * 취소통계
	 * 파일명 : selectCancelAnls04
	 * 작성일 : 2016. 3. 17. 오후 6:39:36
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	ANLS08VO selectCancelAnls04(ANLSSVO anlsSVO);

	/**
	 * 고객 통계 1
	 * 파일명 : selectAnls09
	 * 작성일 : 2016. 3. 18. 오전 10:42:17
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLS05VO> selectAnls09(ANLSSVO anlsSVO);

	/**
	 * 고객 효율성
	 * 파일명 : selectAnls10
	 * 작성일 : 2016. 3. 18. 오후 2:36:43
	 * 작성자 : 최영철
	 * @return
	 */
	ANLS10VO selectAnls10();

	/**
	 * 년월별 매출
	 * 파일명 : selectAnls11
	 * 작성일 : 2016. 3. 18. 오후 4:26:10
	 * 작성자 : 최영철
	 * @param anlsSVO
	 * @return
	 */
	List<ANLS11VO> selectAnls11(ANLSSVO anlsSVO);



}
