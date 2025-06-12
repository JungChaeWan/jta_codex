package api.service.impl;

import api.vo.APIRibbonVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import mas.rc.vo.RC_PRDTINFVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("apiRibbonDAO")
public class APIRibbonDAO extends EgovAbstractDAO {

    /** API서버 */
    public List<APIRibbonVO> selectListRibbonTamnaoCarType() {
        return (List<APIRibbonVO>) list("APIRIBBON_S_00");
    }

    /** 보험정보 */
    public int selectCntRibList(RC_PRDTINFVO apiRcPrdtVO) {
        return (int) select("APIRIBBON_S_01",apiRcPrdtVO);
    }

    /** 차량정보 생성 */
    public void insertRibList(RC_PRDTINFVO apiRcPrdtVO) {
        insert("APIRIBBON_I_00", apiRcPrdtVO);
    }

     /** 판매종료 */
    public void updateCarSaleEnd(RC_PRDTINFVO apiRcPrdtVO) {
        update("APIRIBBON_U_00", apiRcPrdtVO);
    }

    public void updateRibList(RC_PRDTINFVO apiRcPrdtVO) {
        update("APIRIBBON_U_01", apiRcPrdtVO);
    }

    public void deleteCarOptList(RC_PRDTINFVO apiRcPrdtVO) {
        update("APIRIBBON_D_00", apiRcPrdtVO);
    }

    /** 차량옵션 추가 */
    public void insertCarOptList(RC_PRDTINFVO apiRcPrdtVO) {
        insert("APIRIBBON_I_01", apiRcPrdtVO);
    }

}


