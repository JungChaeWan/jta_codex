package api.service.impl;

import api.vo.APITLBookingLogVO;
import api.vo.APITLBookingRoomInfoVO;
import api.vo.APITLBookingVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;
import web.mypage.vo.USER_CPVO;
import web.order.vo.AD_RSV_DAYPRICEVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("APITLBookingDAO")
public class APITLBookingDAO  extends EgovAbstractDAO {

    /**
    * 설명 : 예약 발송 시 필요한 통합 예약 내역
    * 파일명 :
    * 작성일 : 2021-06-10 오후 5:25
    * 작성자 : chaewan.jung
    * @param : String rsvNum
    * @return : APITLBookingVO
    * @throws Exception
    */
    public List<APITLBookingVO> selectByBooking(String rsvNum) {
        return (List<APITLBookingVO>) list("APITLBooking_S_00", rsvNum);
    }

    /**
    * 설명 : 예약발송 시 필요한 각각의 객실정보 목록
    * 파일명 :
    * 작성일 : 2021-06-11 오후 5:24
    * 작성자 : chaewan.jung
    * @param : String rsvNum
    * @return : List<APITLBookingRoomInfoVO>
    * @throws Exception
    */
    public List<APITLBookingRoomInfoVO> selectByRoomInfo(String rsvNum, String corpId) {
        Map<String, String> params = new HashMap<String, String>();
        params.put("rsvNum", rsvNum);
        params.put("corpId", corpId);
        return (List<APITLBookingRoomInfoVO>) list("APITLBooking_S_01", params);
    }

    public String insertBookingLog(APITLBookingLogVO apitlBookingLogVO) {
        return (String) insert("APITLBooking_I_00", apitlBookingLogVO);
    }

    /**
    * 설명 : 숙박 요금 일별 select
    * 파일명 :
    * 작성일 : 2021-06-28 오후 5:03
    * 작성자 : chaewan.jung
    * @param :
    * @param aplDt
     * @return : AD_RSV_DAYPRICEVO
    * @throws Exception
    */
    public AD_RSV_DAYPRICEVO selectByDayPrice(String adRsvNum, String aplDt){
        Map<String, String> params = new HashMap<String, String>();
        params.put("adRsvNum", adRsvNum);
        params.put("aplDt", aplDt);

        return (AD_RSV_DAYPRICEVO) select("APITLBooking_S_02", params);
    }

    /**
     * 설명 : 쿠폰 사용 내역 select
     * 파일명 :
     * 작성일 : 2021-06-29 오후 4:03
     * 작성자 : chaewan.jung
     * @param : rsvNum
     * @return : List<USER_CPVO>
     * @throws Exception
     */
    public List<USER_CPVO> selectByPoint(String adRsvNum) {
        return (List<USER_CPVO>) list("APITLBooking_S_03", adRsvNum);
    }

    /**
    * 설명 : API연동 유무 select (rsvNum)
    * 파일명 :
    * 작성일 : 2021-06-30 오후 4:47
    * 작성자 : chaewan.jung
    * @param : RSVVO
    * @return : String
    * @throws Exception
    */
//    public String getAdApiLinkNm(String rsvNum){
//        return (String) select("APITLBooking_S_04", rsvNum);
//    }

    /**
    * 설명 : LPOINT 사용 금액 get
    * 파일명 :
    * 작성일 : 2021-07-02 오후 5:03
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public int getUseLpoint(String adRsvNum){
        return (Integer) select("APITLBooking_S_05", adRsvNum);
    }

    /**
    * 설명 : 취소 전송
    * 파일명 :
    * 작성일 : 2021-07-05 오후 6:09
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public APITLBookingLogVO bookingCancel(String adRsvNum){
        return (APITLBookingLogVO) select("APITLBooking_S_06", adRsvNum);
    }

    /**
    * 설명 : 취소 시 DataId 설정 YYYYMMDD + 100000000 부터 일련번호
    * 파일명 :
    * 작성일 : 2021-07-07 오전 11:05
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public String getDataId(){
        return (String) select("APITLBooking_S_07");
    }
    
    /**
    * 설명 : 예약 처리
    * 파일명 : 
    * 작성일 : 2021-07-08 오후 2:20
    * 작성자 : chaewan.jung
    * @param : 
    * @return : 
    * @throws Exception
    */
    public void rsvProc(String rsvNum, String adRsvNum){
        update("APITLBooking_U_00", rsvNum);
        update("APITLBooking_U_01", adRsvNum);
    }

    /**
    * 설명 : 취소 처리
    * 파일명 :
    * 작성일 : 2021-07-08 오후 2:57
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public void cancelProc(String rsvNum, String adRsvNum){
        //update RS02
        update("APITLBooking_U_02", rsvNum);
        update("APITLBooking_U_03", adRsvNum);
    }

    public void chgAdRsvStatus(String adRsvNum) {
        update("APITLBooking_U_04", adRsvNum);
    }

    /**
    * 설명 : API연동 유무 select
    * 파일명 : getAdApiLinkNm
    * 작성일 : 2021-07-19 오후 1:55
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public String getAdApiLinkNm(String adRsvNum){
        return (String) select("APITLBooking_S_08", adRsvNum);
    }

}
