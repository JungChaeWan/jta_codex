package oss.monitoring.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import oss.monitoring.service.OssMntrService;
import oss.monitoring.vo.TLCORPVO;
import web.order.vo.ORDERVO;

import java.util.List;

@Service("ossMntrService")
public class OssMntrServiceImpl implements OssMntrService {
    @Autowired MntrDAO mntrDAO;

    /**
    * 설명 : TL린칸 예약 전송 후 Tamnao 취소(RS99) 인데 취소전송을 보내지 않은 리스트
    * 파일명 : tlCancelErrList
    * 작성일 : 2021-10-22 오후 2:34
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public List<ORDERVO> selectCancelErrList(){
        return mntrDAO.selectCancelErrList();
    }

    /**
    * 설명 : TL린칸 연동 업체 List
    * 파일명 :
    * 작성일 : 2021-10-29 오후 2:29
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public List<TLCORPVO> selectTlCorpList(){
        return mntrDAO.selectTlCorpList();
    }

    /**
    * 설명 : 어린이 타입 update
    * 파일명 :
    * 작성일 : 2021-10-29 오후 3:50
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public void updateTlChildType(TLCORPVO tlCorpVO){
        mntrDAO.updateTlChildType(tlCorpVO);
    }


    /**
    * 설명 : 대시보드 TL린칸 취소 오류건
    * 파일명 :
    * 작성일 : 2021-11-03 오전 9:55
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public Integer getCntTLRsvErr(){
        return mntrDAO.getCntTLRsvErr();
    }

    /**
    * 설명 : TLL 금액 연동 기준 update
    * 파일명 :
    * 작성일 : 2022-03-11 오후 2:36
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public void updateTlPriceLink(TLCORPVO tlCorpVO){
        mntrDAO.updateTlPriceLink(tlCorpVO);
    }

    @Override
    public List<ORDERVO> selectPointRsvErrList() {
        return mntrDAO.selectPointRsvErrList();
    }
}
