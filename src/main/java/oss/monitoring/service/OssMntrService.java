package oss.monitoring.service;

import oss.monitoring.vo.TLCORPVO;
import web.order.vo.ORDERVO;

import java.util.List;

public interface OssMntrService {
    /**
    * 설명 : TL린칸 예약 전송 후 Tamnao 취소(RS99) 인데 취소전송을 보내지 않은 리스트
    * 파일명 : tlCancelErrList
    * 작성일 : 2021-10-22 오후 2:33
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    List<ORDERVO> selectCancelErrList();

    /**
    * 설명 : TL린칸 연동 업체 List
    * 파일명 :
    * 작성일 : 2021-10-29 오후 2:12
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    List<TLCORPVO> selectTlCorpList();

    /**
    * 설명 : 어린이 Type Update
    * 파일명 :
    * 작성일 : 2021-10-29 오후 4:50
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    void updateTlChildType(TLCORPVO tlCorpVO);

    /**
    * 설명 : 대시보드 TL린칸 취소 오류건
    * 파일명 :
    * 작성일 : 2021-11-03 오전 9:51
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    Integer getCntTLRsvErr();

    /**
    * 설명 : TLL 금액 연동 기준 update
    * 파일명 :
    * 작성일 : 2022-03-11 오후 2:34
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    void updateTlPriceLink(TLCORPVO tlCorpVO);

    List<ORDERVO> selectPointRsvErrList();
}
