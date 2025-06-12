package api.service;

import web.order.vo.RC_RSVVO;
import mas.rc.vo.RC_PRDTINFSVO;


public interface APIRcService {

	/**
	 * 연계번호에 대한 상품번호 구하기
	 * 파일명 : selectByPrdtNumLinkNum
	 * 작성일 : 2016. 7. 19. 오후 1:34:42
	 * 작성자 : 최영철
	 * @param rcPrdtSVO
	 * @return
	 */
	String selectByPrdtNumAtLinkNum(RC_PRDTINFSVO rcPrdtSVO);

	/**
	 * 연계 예약 번호에 대해 렌터카 이용내역 추가
	 * 파일명 : insertRcHist
	 * 작성일 : 2016. 7. 20. 오전 10:55:02
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	void insertRcHist(RC_RSVVO rcRsvVO);

	/**
	 * 연계 예약 번호에 대한 렌터카 이용내역 삭제
	 * 파일명 : deleteRcUseHist
	 * 작성일 : 2016. 7. 20. 오후 2:12:11
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	void deleteRcUseHist(RC_RSVVO rcRsvVO);
	
}
