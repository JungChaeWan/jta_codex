package api.service.impl;

import api.vo.APIRibbonVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import mas.rc.vo.RC_PRDTINFVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("apiInsDAO")
public class APIInsDAO extends EgovAbstractDAO {

    /** 보험정보 */
    public int selectCntInsList(RC_PRDTINFVO apiRcPrdtVO) {
        return (int) select("APIINS_S_00", apiRcPrdtVO);
    }

    /** 차량정보 생성 */
    public void inserInsList(RC_PRDTINFVO apiRcPrdtVO) {
        insert("APIINS_I_00", apiRcPrdtVO);
    }
    /** 차량옵션 추가 */
    public void insertCarOptList(RC_PRDTINFVO apiRcPrdtVO) {
        insert("APIINS_I_01", apiRcPrdtVO);
    }

    /** 보험정보 */
    public void updateInsList(RC_PRDTINFVO apiRcPrdtVO) {
        update("APIINS_U_00", apiRcPrdtVO);
    }

    /** 보험정보 */
    public void updateInsList2(RC_PRDTINFVO apiRcPrdtVO) {
        update("APIINS_U_04", apiRcPrdtVO);
    }

    /** 차량정보  */
    public void updateCarList(RC_PRDTINFVO apiRcPrdtVO) {
        update("APIINS_U_01", apiRcPrdtVO);
    }
    /** 판매종료 */
    public void updateCarSaleEnd(RC_PRDTINFVO apiRcPrdtVO) {
        update("APIINS_U_02", apiRcPrdtVO);
    }
    /** 판매시작*/
    public void updateCarSaleStart(RC_PRDTINFVO apiRcPrdtVO) {
        update("APIINS_U_03", apiRcPrdtVO);
    }

    /** 차량옵션 */
    public void deleteCarOptList(RC_PRDTINFVO apiRcPrdtVO) {
        delete("APIINS_D_00", apiRcPrdtVO);
    }
}


