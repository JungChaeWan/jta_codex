package oss.rsv.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import org.springframework.stereotype.Repository;
import oss.rsv.vo.OSS_RSVEXCELVO;
import web.order.vo.RSVVO;

import java.util.List;

@Repository("ossRsvDAO")
public class OssRsvDAO extends EgovAbstractDAO {
    /**
    * 설명 : 관리자 직접 예약 시스템에서 [엑셀 상품 등록] Log(확인) Table에 저장
    * 파일명 :
    * 작성일 : 2021-11-11 오후 3:00
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public void insertRsvRegExcelUp(OSS_RSVEXCELVO data){
        insert("OSSRSV_I_00", data);
    }

    /**
    * 설명 : 관리자 직접 예약 시스템에서 [엑셀 상품 등록] Log(확인) Table 저장에 필요한 GROUP NO GET
    * 파일명 :
    * 작성일 : 2021-11-11 오후 3:02
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public Integer getRsvExcelUpGroupNo(){
        return (Integer) select("OSSRSV_S_00");
    }

    /**
    * 설명 : 관리자 직접 예약 시스템에서 [예약 리스트]
    * 파일명 :
    * 작성일 : 2021-11-15 오전 9:52
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public List<OSS_RSVEXCELVO> selectRsvRegExcel(OSS_RSVEXCELVO ossRsvExcelVO){
        return (List<OSS_RSVEXCELVO>) list("OSSRSV_S_01", ossRsvExcelVO);
    }

    /**
    * 설명 : 엑셀업로드한 Data와 검증된 Data 비교를 위해 조회
    * 파일명 :
    * 작성일 : 2021-11-16 오전 9:37
    * 작성자 : chaewan.jung
    * @param :
    * @return :
    * @throws Exception
    */
    public Integer selectExcelUpRsvCnt(OSS_RSVEXCELVO ossRsvExcelVO) {
        return (Integer) select("OSSRSV_S_02",ossRsvExcelVO);
    }

    public String getLastGroupNo(String corpDiv) {
        return (String) select("OSSRSV_S_03", corpDiv);
    }

    public List<OSS_RSVEXCELVO> selectSprdtOptNm(OSS_RSVEXCELVO ossRsvExcelVO) {
        return (List<OSS_RSVEXCELVO>) list("OSSRSV_S_04", ossRsvExcelVO);
    }

    public void updateRsvMatch(OSS_RSVEXCELVO ossRsvExcelVO) {
        update("OSSRSV_U_00", ossRsvExcelVO);
    }

    public Integer getVerifyCnt(OSS_RSVEXCELVO ossRsvExcelVO) {
        return (Integer) select("OSSRSV_S_05", ossRsvExcelVO);
    }

    public void updateRsvComplete(Integer seq) {
        update("OSSRSV_U_01", seq);
    }

    public void updateRsvInfo(RSVVO rsvVO) {
        update("OSSRSV_U_02", rsvVO);
    }
}
