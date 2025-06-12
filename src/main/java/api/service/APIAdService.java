package api.service;

import web.order.vo.AD_RSVVO;
import web.order.vo.RSVVO;
import api.vo.ADSUKSOVO;

public interface APIAdService {

	/**
	 * 해당숙소에 기간의 방들의 남은/총 개수 얻고 DB에 넣기 - IFS-001
	 * (1.3.1. 실시간객실현황 조회 API)
	 * 파일명 : adCntInfoSetByAllRoom
	 * 작성일 : 2015. 12. 10. 오후 4:02:16
	 * 작성자 : 신우섭
	 * @param strUrl
	 * @param authkey
	 * @param corpId
	 * @param startDt
	 * @param endDt
	 * @return
	 */

	/**
	 * 1.3.3. 예약 취소 요청  API - IFS-003
	 * 파일명 : adResInf
	 * 작성일 : 2015. 12. 10. 오후 5:54:16
	 * 작성자 : 신우섭
	 */
	String cancelResInfo(ADSUKSOVO adSukso);
	String cancelResInfo(String adRsvNum, String CancelAutoYn, String CancelReslYn );

	/**
	 * 예약등록결제완료요청 API - IFS-008
	 * 파일명 : PayDoneResInfo
	 * 작성일 : 2015. 12. 28. 오후 8:44:55
	 * 작성자 : 신우섭
	 * @param adSukso
	 * @return
	 */
	String PayDoneResInfo(ADSUKSOVO adSukso);
	String PayDoneResInfo(RSVVO rsvInfo);

	
	/**
	 * 예약취소요청_요청 API - IFS-009
	 * 파일명 : requestCancelResInfo
	 * 작성일 : 2015. 12. 28. 오후 7:50:23
	 * 작성자 : 신우섭
	 * @param adSukso
	 * @return
	 */
	String requestCancelResInfo(ADSUKSOVO adSukso);
	String requestCancelResInfo(String adRsvNum);
}
