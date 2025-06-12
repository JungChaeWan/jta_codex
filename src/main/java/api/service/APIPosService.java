package api.service;

import java.util.List;

import web.order.vo.RSVSVO;
import web.order.vo.SP_RSVVO;
import api.vo.POSVO;

public interface APIPosService {
	/**
	 * 예약 리스트 검색
	 * Function : selectByRsvList
	 * 작성일 : 2016. 10. 12. 오후 2:37:44
	 * 작성자 : 정동수
	 * @param rsvSVO
	 * @return
	 */
	List<POSVO> selectByRsvList(RSVSVO rsvSVO);
	
	/**
	 * 예약 상세의 정보 검색
	 * Function : selectByRsvInfo
	 * 작성일 : 2016. 10. 13. 오전 9:58:13
	 * 작성자 : 정동수
	 * @param rsvSVO
	 * @return
	 */
	POSVO selectByRsvInfo(POSVO posVO);
	
	/**
	 * 예약 상세의 예약 리스트 검색
	 * Function : selectByPrdtList
	 * 작성일 : 2016. 10. 13. 오전 9:58:15
	 * 작성자 : 정동수
	 * @param rsvSVO
	 * @return
	 */
	List<POSVO> selectByPrdtList(POSVO posVO);
	
	/**
	 * 소셜(관광지) 예약 정보 검색
	 * Function : selectSpRsv
	 * 작성일 : 2016. 10. 13. 오후 2:19:18
	 * 작성자 : 정동수
	 * @param spRsvVO
	 * @return
	 */
	SP_RSVVO selectSpRsv(SP_RSVVO spRsvVO);
	
	/**
	 * 당일 사용 변경 조회
	 * Function : selectByUsedPrdtList
	 * 작성일 : 2016. 10. 14. 오후 1:15:53
	 * 작성자 : 정동수
	 * @param posVO
	 * @return
	 */
	List<POSVO> selectByUsedPrdtList(POSVO posVO);
	
	/**
	 * 사용현황
	 * Function : selectBydayStat
	 * 작성일 : 2016. 10. 14. 오후 1:45:18
	 * 작성자 : 정동수
	 * @param posVO
	 * @return
	 */
	POSVO selectByDayStat(POSVO posVO);
	
	/**
	 * 사용 처리
	 * Function : updateSpUseDttm
	 * 작성일 : 2016. 10. 21. 오전 10:58:52
	 * 작성자 : 정동수
	 * @param spRsvVO
	 */
	void updateSpUseDttm(SP_RSVVO spRsvVO);
}
