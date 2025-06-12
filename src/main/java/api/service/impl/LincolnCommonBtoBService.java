package api.service.impl;

import api.service.APITLService;
import api.vo.*;
import common.APITLMsg;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import javax.jws.WebService;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.namespace.QName;
import java.io.StringWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@WebService(endpointInterface = "api.service.APITLService", targetNamespace = "http://service.commonb2b.lincoln.seanuts.co.jp/", portName = "LincolnCommonBtoBServicePort")
public class LincolnCommonBtoBService implements APITLService {
    Logger log = LogManager.getLogger(this.getClass());

    @Resource(name = "APITLDAO")
    private APITLDAO apiTlDao;

    /**
     * 설명 : 1-1 RoomType List Result
     * 파일명 : AgtRoomTypeDownload
     * 작성일 : 2021-03-15 오후 3:26
     * 작성자 : chaewan.jung
     *
     * @param : [authVO]
     * @return : api.vo.APITLResultVO
     * @throws Exception
     */
    @Override
    public APITLResultVO AgtRoomTypeDownload(APITLAuthVO authVO) {

        //RootElement
        //APITLVO tlVo = new APITLVO();

        //Sucess, ErrorMsg Element
        APITLResultVO resultVo = new APITLResultVO();

        /* 숙소 유무 확인 process */
        if (apiTlDao.getAdChkYN(authVO) > 0) {
            String priceLink = apiTlDao.getPriceLink(authVO.getLoginId());

            /*Room Type List Element*/
            List<APITLRoomTypeVO> listRoomTypeVO = apiTlDao.getRoomType(authVO);

            //타이틀에 SELL, NET 표기 추가 //SELL(판매가), NET(입금가)
            for (APITLRoomTypeVO listRoomType : listRoomTypeVO){
                listRoomType.setAgtRoomIndicationName("("+priceLink +")"+ listRoomType.getAgtRoomIndicationName());
            }

            resultVo.setSuccess("True");
            resultVo.setErrorMsg("");

            resultVo.setAgtRoomInfos(listRoomTypeVO);
        } else {
            resultVo.setSuccess("False");
            resultVo.setErrorMsg(APITLMsg.AD_NONE.getMsg());
        }

        //BtoB log 저장
        insertBtoB("AgtRoomTypeDownload",authVO.getLoginId(), authVO, resultVo);
        return resultVo;
    }

    /**
     * 설명 : 1-2 Plan List Result
     * 파일명 : PlanDownload
     * 작성일 : 2021-03-16 오후 1:50
     * 작성자 : chaewan.jung
     *
     * @param : [authVO]
     * @return : api.vo.APITLResultVO
     * @throws Exception
     */
    @Override
    public APITLResultVO PlanDownload(APITLAuthVO authVO) {
        //Sucess, ErrorMsg Element
        APITLResultVO resultVo = new APITLResultVO();

        /* 숙소 유무 확인 process */
        if (apiTlDao.getAdChkYN(authVO) > 0) {
            /*Plan List Element*/
            List<APITLPlanVO> listPlan = apiTlDao.getPlan(authVO);
            /*Plan Price List Element*/
            int index = 0;
            for (APITLPlanVO planVO : listPlan) {
                listPlan.get(index).setPrices(apiTlDao.getPlanPrice(planVO.getScAgtRoomCode()));
                index++;
            }

            resultVo.setSuccess("True");
            resultVo.setErrorMsg("");
            resultVo.setAgtPlanRoomInfos(listPlan);
        } else {
            resultVo.setSuccess("False");
            resultVo.setErrorMsg(APITLMsg.AD_NONE.getMsg());
        }

        //BtoB log 저장
        insertBtoB("PlanDownload", authVO.getLoginId(), authVO, resultVo);
        return resultVo;
    }

    /**
    * 설명 : 1-3 Stock Check
    * 파일명 : StockDataDownload
    * 작성일 : 2021-03-17 오후 5:38
    * 작성자 : chaewan.jung
    * @param : [stockReqVO]
    * @return : api.vo.APITLResultVO
    * @throws Exception
    */
    @Override
    public APITLResultVO StockDataDownload(APITLStockReqVO stockReqVO) {

        //Sucess, ErrorMsg Element
        APITLResultVO resultVo = new APITLResultVO();

        /* 숙소 유무 확인 process */
        if (apiTlDao.getAdChkYN(stockReqVO) > 0) {
            resultVo.setSuccess("True");
            resultVo.setErrorMsg("");

            /*날짜 유효성 검사*/
            if (validationDate(stockReqVO.getAppointedDate()) == true) {
            /* RoomCode 유무 확인 process */
                if(apiTlDao.getAdRoomCodeChkYN(stockReqVO.getLoginId(), stockReqVO.getScAgtRoomCode()) > 0){
                    /*StockData List Element*/
                    List<APITLStockResVO> listStockData = apiTlDao.getStockData(stockReqVO);
                    resultVo.setStockDatas(listStockData);
                }else { //RoomCode err
                    resultVo.setSuccess("False");
                    resultVo.setErrorMsg(APITLMsg.ROOM_NONE.getMsg());
                }
            }else{ //date err
                resultVo.setSuccess("False");
                resultVo.setErrorMsg(APITLMsg.DATE_ERR.getMsg());
            }
        } else {
            resultVo.setSuccess("False");
            resultVo.setErrorMsg(APITLMsg.AD_NONE.getMsg());
        }

        //BtoB log 저장
        insertBtoB("StockDataDownload", stockReqVO.getLoginId(), stockReqVO, resultVo);
        return resultVo;
    }

    /**
     * 설명 : 1-4 Price Check
     * 파일명 : TariffDataDownload
     * 작성일 : 2021-03-17 오전 9:26
     * 작성자 : chaewan.jung
     * @param : [tariffReqVO]
     * @return : api.vo.APITLResultVO
     * @throws Exception
     */
    @Override
    public APITLResultVO TariffDataDownload(APITLTariffReqVO tariffReqVO) {

        //Sucess, ErrorMsg Element
        APITLResultVO resultVo = new APITLResultVO();

        /* 숙소 유무 확인 process */
        if (apiTlDao.getAdChkYN(tariffReqVO) > 0) {
            resultVo.setSuccess("True");
            resultVo.setErrorMsg("");

            /*날짜 유효성 검사*/
            if (validationDate(tariffReqVO.getAppointedDate()) == true) {

                /* RoomCode 유무 확인 process */
                if (apiTlDao.getAdRoomCodeChkYN(tariffReqVO.getLoginId(), tariffReqVO.getScAgtRoomCode()) > 0) {
                    /*Plan Code가 P001이 아니면 오류 - 탐나오는 모든 상품의 PlanCode는 P001로 고정*/
                    if(tariffReqVO.getScAgtPlanCode().equals("P001")){
                        /*TariffData List Element*/
                        List<APITLTariffResVO> listTariffData = apiTlDao.getTariffData(tariffReqVO);
                        resultVo.setTariffDatas(listTariffData);
                    } else { //PlanCode err
                        resultVo.setSuccess("False");
                        resultVo.setErrorMsg(APITLMsg.PLAN_NONE.getMsg());
                    }
                } else { //RoomCode err
                    resultVo.setSuccess("False");
                    resultVo.setErrorMsg(APITLMsg.ROOM_NONE.getMsg());
                }
            }else{ //date err
                resultVo.setSuccess("False");
                resultVo.setErrorMsg(APITLMsg.DATE_ERR.getMsg());
            }
        } else { //Login err
            resultVo.setSuccess("False");
            resultVo.setErrorMsg(APITLMsg.AD_NONE.getMsg());
        }

        //BtoB log 저장
        insertBtoB("TariffDataDownload", tariffReqVO.getLoginId(), tariffReqVO, resultVo);
        return resultVo;
    }

    /**
     * 설명 : 1-5 Stock Update
     * 파일명 : AgtRoomStatusUpdateArray
     * 작성일 : 2021-03-15 오후 5:05
     * 작성자 : chaewan.jung
     * @param : [roomUpReq]
     * @return : api.vo.APITLResultVO
     * @throws Exception
     */
    @Override
    public APITLResultVO AgtRoomStatusUpdateArray(APITLRoomUpReqVO roomUpReqVO) {

        //Sucess, ErrorMsg Element
        APITLResultVO resultVo = new APITLResultVO();

        /* 숙소 유무 확인 process */
        if (apiTlDao.getAdChkYN(roomUpReqVO) > 0) {
            resultVo.setSuccess("True");
            resultVo.setErrorMsg("");

            //Stock Update List (AgtRoomStatusUpdateArrayResult Element)
            List<APITLRoomUpResInfosVO> listRoomUpResInfosVO = new ArrayList<APITLRoomUpResInfosVO>();

            for (APITLRoomUpReqInfosVO roomUpReqInfosVO : roomUpReqVO.getAgrRoomUpReqinfos()) {
                APITLRoomUpResInfosVO roomUpResInfosVO = new APITLRoomUpResInfosVO();

                /*날짜 유효성 검사*/
                if (validationDate(roomUpReqInfosVO.getAppointedDate()) == true) {
                    roomUpResInfosVO.setAppointedDate(roomUpReqInfosVO.getAppointedDate());
                    /* RoomCode 유무 확인 process */
                    if (apiTlDao.getAdRoomCodeChkYN(roomUpReqVO.getLoginId(), roomUpReqInfosVO.getScAgtRoomCode()) > 0) {

                        /*객실 유효 수량 체크*/
                        if(roomUpReqInfosVO.getAgtStockQuantity() >= 0) {
                            if (apiTlDao.mergeAgtRoomQty(roomUpReqInfosVO) > 0) { //정상 실행 시
                                //ResponseVO Set
                                roomUpResInfosVO.setSuccess("True");
                                roomUpResInfosVO.setErrorMsg("");
                                roomUpResInfosVO.setScAgtRoomCode(roomUpReqInfosVO.getScAgtRoomCode());

                                roomUpResInfosVO.setSaleStopState(roomUpReqInfosVO.getStopStartDivision());
                                roomUpResInfosVO.setAgtStockQuantity(roomUpReqInfosVO.getAgtStockQuantity());
                                roomUpResInfosVO.setClosingState("0"); //탐나오는 판매날짜로 컨트롤 하는게 아니므로 0을 반환
                            }
                        }else{
                            roomUpResInfosVO.setSuccess("False");
                            roomUpResInfosVO.setErrorMsg(APITLMsg.STOCK_ERR.getMsg());
                        }
                    } else { //RoomCode err
                        resultVo.setSuccess("False");
                        resultVo.setErrorMsg(APITLMsg.ROOM_NONE.getMsg());
                    }

                }else{ //date err
                    roomUpResInfosVO.setSuccess("False");
                    roomUpResInfosVO.setErrorMsg(APITLMsg.DATE_ERR.getMsg());
                }
                listRoomUpResInfosVO.add(roomUpResInfosVO);
            }
            resultVo.setRoomUpdateResultInfos(listRoomUpResInfosVO);
        } else {//Login err
            resultVo.setSuccess("False");
            resultVo.setErrorMsg(APITLMsg.AD_NONE.getMsg());
        }

        //BtoB log 저장
        insertBtoB("AgtRoomStatusUpdateArray", roomUpReqVO.getLoginId(), roomUpReqVO, resultVo);
        return resultVo;
    }

    /**
     * 설명 : 1-6 Price Update
     * 파일명 : PlanStatusUpdateArray
     * 작성일 : 2021-03-17 오전 11:17
     * 작성자 : chaewan.jung
     * @param : [planUpReqVO]
     * @return : api.vo.APITLResultVO
     * @throws Exception
     */
    @Override
    public APITLResultVO PlanStatusUpdateArray(APITLPlanUpReqVO planUpReqVO) {
        //Sucess, ErrorMsg Element
        APITLResultVO resultVo = new APITLResultVO();

        /* 숙소 유무 확인 process */
        if (apiTlDao.getAdChkYN(planUpReqVO) > 0) {
            resultVo.setSuccess("True");
            resultVo.setErrorMsg("");

            //Price Update List (PlanStatusUpdateArray Element)
            List<APITLPlanUpResInfosVO> listPlanUpResInfosVO = new ArrayList<APITLPlanUpResInfosVO>();

            for (APITLPlanUpReqInfosVO planUpReqInfosVO : planUpReqVO.getPlanUpdateRequestInfos()) {
                APITLPlanUpResInfosVO planUpResInfosVO = new APITLPlanUpResInfosVO();

                //날짜 유효성 검사
                if (validationDate(planUpReqInfosVO.getAppointedDate()) == true) {
                    planUpResInfosVO.setAppointedDate(planUpReqInfosVO.getAppointedDate());
                    /*객실 가격 체크*/
                    if (planUpReqInfosVO.getPriceCode1() >= 0) {
                        /* RoomCode 유무 확인 process */
                        if (apiTlDao.getAdRoomCodeChkYN(planUpReqVO.getLoginId(), planUpReqInfosVO.getScAgtRoomCode()) > 0) {
                            if (apiTlDao.mergeAgtRoomPrice(planUpReqVO.getLoginId(), planUpReqInfosVO) > 0) { //정상 실행 시
                                /*Plan Code가 P001이 아니면 오류 - 탐나오는 모든 상품의 PlanCode는 P001로 고정*/
                                if (planUpReqInfosVO.getScAgtPlanCode().equals("P001")) {
                                    //ResponseVO Set
                                    planUpResInfosVO.setSuccess("True");
                                    planUpResInfosVO.setErrorMsg("");
                                    planUpResInfosVO.setScAgtPlanCode(planUpReqInfosVO.getScAgtPlanCode());
                                    planUpResInfosVO.setScAgtRoomCode(planUpReqInfosVO.getScAgtRoomCode());
                                    //판매중지 판매재개 지정을 [1: 판매중지]로 갱신하면
                                    if (planUpReqInfosVO.getStopStartDivision().equals("1")) {
                                        planUpResInfosVO.setSaleStopState("1");
                                        planUpResInfosVO.setPriceCode1(0);
                                    } else {
                                        planUpResInfosVO.setSaleStopState(planUpReqInfosVO.getStopStartDivision());
                                        planUpResInfosVO.setPriceCode1(planUpReqInfosVO.getPriceCode1());
                                    }
                                } else { //PlanCode err
                                    planUpResInfosVO.setSuccess("False");
                                    planUpResInfosVO.setErrorMsg(APITLMsg.PLAN_NONE.getMsg());
                                }
                            }
                        } else { //RoomCode err
                            planUpResInfosVO.setSuccess("False");
                            planUpResInfosVO.setErrorMsg(APITLMsg.ROOM_NONE.getMsg());
                        }
                    } else { //price err
                        planUpResInfosVO.setSuccess("False");
                        planUpResInfosVO.setErrorMsg(APITLMsg.PRICE_ERR.getMsg());
                    }

                }else{ //date err
                    planUpResInfosVO.setSuccess("False");
                    planUpResInfosVO.setErrorMsg(APITLMsg.DATE_ERR.getMsg());
                }

                listPlanUpResInfosVO.add(planUpResInfosVO);
            }
            resultVo.setPlanUpdateResultInfos(listPlanUpResInfosVO);
        } else {//Login err
            resultVo.setSuccess("False");
            resultVo.setErrorMsg(APITLMsg.AD_NONE.getMsg());
        }

        //BtoB log 저장
        insertBtoB("PlanStatusUpdateArray", planUpReqVO.getLoginId(), planUpReqVO, resultVo);
        return resultVo;
    }

    @Override
    /**
    * 설명 : 1-7 LoginConfirm
    * 파일명 : LoginConfirm
    * 작성일 : 2021-03-17 오후 1:55
    * 작성자 : chaewan.jung
    * @param : [authVO]
    * @return : api.vo.APITLResultVO
    * @throws Exception
    */
    public APITLResultVO LoginConfirm(APITLAuthVO authVO) {
        //Sucess, ErrorMsg Element
        APITLResultVO resultVo = new APITLResultVO();    
    
        if (apiTlDao.getAdChkYN(authVO) > 0) {
            resultVo.setSuccess("True");
            resultVo.setErrorMsg("");
        } else {
            resultVo.setSuccess("False");
            resultVo.setErrorMsg(APITLMsg.AD_NONE.getMsg());
        }

        //BtoB log 저장
        insertBtoB("LoginConfirm", authVO.getLoginId(), authVO, resultVo);
        return resultVo;
    }

    /**
    * 설명 : 유효날짜 체크 (date : 날짜, yyyyMMdd 형식) ; date.length 8자 체크
    * 파일명 :
    * 작성일 : 2021-03-17 오후 3:07
    * 작성자 : chaewan.jung
    * @param :
    * @return : boolean
    * @throws ParseException
    */
    public static boolean validationDate(String date) {
        SimpleDateFormat dateFormatParser = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
        dateFormatParser.setLenient(false);
        try {
            if (date.length() == 8) {
                dateFormatParser.parse(date);
                return true;
            }else{
                return false;
            }
        } catch (Exception Ex) {
            return false;
        }
    }

    /**
    * 설명 : BtoB 호출되면 저장
    * 파일명 :
    * 작성일 : 2021-07-20 오후 5:00
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    private void insertBtoB(String apiNm, String loginId, Object reqVO, APITLResultVO resultVO)  {
        try {

            Map<String, String> params = new HashMap<String, String>();
            params.put("apiNm", apiNm);
            params.put("corpId", loginId);
            params.put("reqXml", jaxbVOtoXML(reqVO));
            params.put("returnXml", jaxbVOtoXML(resultVO));
            params.put("success", resultVO.getSuccess());
            params.put("faultReason", resultVO.getErrorMsg());

            apiTlDao.insertBtoB(params);

        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
    * 설명 : SendVO 및 ResultVo Marshalling
    * 파일명 :
    * 작성일 : 2021-07-20 오후 5:00
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    private String jaxbVOtoXML(Object obj){
        JAXBContext jaxbContext;
        StringWriter sw = new StringWriter();
        try {
            jaxbContext = JAXBContext.newInstance(obj.getClass());
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();

            jaxbMarshaller.setProperty(Marshaller.JAXB_ENCODING, "UTF-8");
            jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);

            jaxbMarshaller.marshal(new JAXBElement(
                new QName("", obj.getClass().getSimpleName()), obj.getClass(), obj), sw);

        } catch (JAXBException e) {
            System.out.println(e);
        }

        return sw.toString();
    }

}