package api.service.impl;

import api.vo.*;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("APITLDAO")
public class APITLDAO extends EgovAbstractDAO {

    /**
    * 설명 : 1-1 AgtRoomTypeDownload (Room Type LIST)
    * 파일명 :
    * 작성일 : 2021-03-09 오후 1:17
    * 작성자 : chaewan.jung
    * @param : APITLAuthVO
    * @return : List<APITLRoomTypeVO>
    */
    public List<APITLRoomTypeVO> getRoomType(APITLAuthVO authVO) {
        return (List<APITLRoomTypeVO>) list("APITL_S_00", authVO);
    }

    /**
    * 설명 : 1-2 PlanDownload
    * 파일명 :
    * 작성일 : 2021-03-16 오후 4:25
    * 작성자 : chaewan.jung
    * @param : authVO
    * @return :List<APITLPlanVO>
    */
    public List<APITLPlanVO> getPlan(APITLAuthVO authVO) {
        return (List<APITLPlanVO>) list("APITL_S_03", authVO);
    }

    /**
    * 설명 : 1-2 PlanDownload (PRDT_NUM에 따른 Price)
    * 파일명 :
    * 작성일 : 2021-03-16 오후 4:54
    * 작성자 : chaewan.jung
    * @param :List<APITLPlanPriceVO>
    * @return :List<APITLPlanPriceVO>
    */
    public List<APITLPlanPriceVO> getPlanPrice(String prdtNum) {
        return (List<APITLPlanPriceVO>) list("APITL_S_04", prdtNum);
    }

    /**
    * 설명 : 1-3 StockDataDownload (stock check)
    * 파일명 :
    * 작성일 : 2021-03-16 오전 10:47
    * 작성자 : chaewan.jung
    * @param : APITLStockReqVO
    * @return :List<APITLStockResVO>
    */
    public List<APITLStockResVO> getStockData(APITLStockReqVO stockReqVO){
        return (List<APITLStockResVO>) list("APITL_S_02", stockReqVO);
    }

    /**
    * 설명 : 1-5 AgtRoomStatusUpdateArray (stock update)
    * 파일명 :
    * 작성일 : 2021-03-15 오후 3:28
    * 작성자 : chaewan.jung
    * @param : APITLRoomUpReqInfosVO
    * @return : update count
    */
    public Integer mergeAgtRoomQty(APITLRoomUpReqInfosVO roomUpReqInfosVO){
        return update("APITL_M_00", roomUpReqInfosVO);
    }

    /**
    * 설명 : 1-4 TariffDatas (price check)
    * 파일명 :
    * 작성일 : 2021-03-17 오전 10:18
    * 작성자 : chaewan.jung
    * @param : APITLTariffReqVO
    * @return : List<APITLTariffResVO>
    */
    public List<APITLTariffResVO> getTariffData(APITLTariffReqVO tariffReqVO){
        //판매가 입금가 설정에 따라 쿼리 분기
        if ("NET".equals(getPriceLink(tariffReqVO.getLoginId()))) {
            return (List<APITLTariffResVO>) list("APITL_S_06", tariffReqVO);
        } else {
            return (List<APITLTariffResVO>) list("APITL_S_05", tariffReqVO);
        }
    }
    
    /**
    * 설명 : 1-6 PlanStatusUpdateArray (price update)
    * 파일명 :
    * 작성일 : 2022-03-17 오전 11:28
    * 작성자 : chaewan.jung
    * @param : APITLPlanUpReqInfosVO
    * @return : update count
    */
    public Integer mergeAgtRoomPrice(String corpId, APITLPlanUpReqInfosVO planUpReqInfosVO){

        Map  params = new HashMap();
        params.put("corpId", corpId);
        params.put("PriceCode1", planUpReqInfosVO.getPriceCode1());
        params.put("scAgtRoomCode", planUpReqInfosVO.getScAgtRoomCode());
        params.put("appointedDate", planUpReqInfosVO.getAppointedDate());

        //중지상태로 들어오면 price는 0
        if( "1".equals(planUpReqInfosVO.getStopStartDivision())){
            planUpReqInfosVO.setPriceCode1(0);
        }

        //판매가 입금가 설정에 따라 쿼리 분기
        if ("NET".equals(getPriceLink(corpId))) {
            return update("APITL_M_02", params);
        } else {
            return update("APITL_M_01", params);
        }
    }

    /**
     * 설명 : 1-7 LoginCorfirm
     * 파일명 :
     * 작성일 : 2021-03-09 오후 1:20
     * 작성자 : chaewan.jung
     * @param : APITLAuthVO
     * @return : count
     */
    public Integer getAdChkYN(APITLAuthVO authVO) {
        return (Integer) select("APITL_S_01",authVO);
    }

    /**
    * 설명 : RoomCode 존재여부
    * 파일명 :
    * 작성일 : 2021-05-26 오전 11:37
    * 작성자 : chaewan.jung
    * @param : String RoomCode
    * @return : count
    */
    public Integer getAdRoomCodeChkYN(String corpId, String roomCode) {
        Map  params = new HashMap();
        params.put("corpId", corpId);
        params.put("roomCode", roomCode);
        return (Integer) select("APITL_S_11",params);
    }

    /**
    * 설명 : BtoB log insert
    * 파일명 :
    * 작성일 : 2021-07-21 오전 11:12
    * 작성자 : chaewan.jung
    * @param : 
    * @return :
    */
    public void insertBtoB(Map<String, String> params){
        insert("APITL_I_01", params);
    }

    /**
    * 설명 : TLL 금액연동기준 get
    * 파일명 :
    * 작성일 : 2022-03-11 오후 4:04
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public String getPriceLink(String corpId){
        return (String) select("APITL_S_12", corpId);
    }
}


