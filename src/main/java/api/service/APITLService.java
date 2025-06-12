package api.service;

import api.vo.*;

import javax.jws.WebService;

@WebService(targetNamespace = "http://service.commonb2b.lincoln.seanuts.co.jp/")
public interface APITLService {
    APITLResultVO AgtRoomTypeDownload(APITLAuthVO authVO);
    APITLResultVO PlanDownload(APITLAuthVO authVO);
    APITLResultVO StockDataDownload(APITLStockReqVO stockReqVO);
    APITLResultVO TariffDataDownload(APITLTariffReqVO tariffReqVO);
    APITLResultVO AgtRoomStatusUpdateArray(APITLRoomUpReqVO roomUpReqVO);
    APITLResultVO PlanStatusUpdateArray(APITLPlanUpReqVO planUpReqVO);
    APITLResultVO LoginConfirm(APITLAuthVO authVO);
}
