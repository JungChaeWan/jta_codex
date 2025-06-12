package api.service;

import api.vo.APITLBookingLogVO;

import java.util.List;

public interface APITLBookingService {
    /** 예약 전송 **/
    List<APITLBookingLogVO> bookingSend(String rsvNum);

    /** 취소 전송 **/
    APITLBookingLogVO bookingCancel(String adRsvNum);

    /** 예약하기 시 TLL 연동 실패 하면 RS01로 update **/
    void chgAdRsvStatus(String adRsvNum);

    /** 자동 취소 , 마이페이지에서 취소 **/
//    void autoBookingCancel(String rsvNum, String adRsvNum);

    /** TLL 전송 실패 시 알림톡 발송 **/
    void failAligoSend(String errMsg);
}
