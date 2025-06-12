package web.product.service.impl;

import java.util.List;

import common.LowerHashMap;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import oss.point.vo.POINT_CPVO;
import oss.prmt.vo.GOVASVO;
import oss.prmt.vo.GOVAVO;

@Repository("webPrmtDAO")
public class WebPrmtDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<PRMTVO> selectPromotionList(PRMTVO prmtVO) {
		return (List<PRMTVO>) list("PRMT_WEBLIST_S_00", prmtVO);
	}

	@SuppressWarnings("unchecked")
	public List<POINT_CPVO> selectPointList() {
		return (List<POINT_CPVO>) list("PRMT_WEBLIST_S_06");
	}

	public Integer getCntPromotionList(PRMTVO prmtVO) {
		return (Integer) select("PRMT_WEBLIST_S_01", prmtVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<PRMTVO> selectDeteilPromotionList(PRMTPRDTVO prmtPrdtVO) {
		return (List<PRMTVO>) list("PRMT_WEBLIST_S_03", prmtPrdtVO);
	}


	public PRMTVO getPromotionPrevNext(PRMTVO prmtVO) {
		return (PRMTVO) select("PRMT_WEBLIST_S_04", prmtVO);
	}

	public PRMTVO selectAdBanner() {
		return (PRMTVO) select("PRMT_WEBLIST_S_05");
	}

	public List<LowerHashMap> govaList(GOVASVO govaSVO) {
		return (List<LowerHashMap>) list("GOVA_LIST_S_01", govaSVO);
	}

	public void updateGovaMemo(GOVAVO govaVO) {
		update("GOVA_LIST_U_01", govaVO);
	}

	public void updateGovaConfirmed(GOVAVO govaVO) {
		update("GOVA_LIST_U_02", govaVO);
	}

    public List<LowerHashMap> selectAutoCompleteList() {
		return (List<LowerHashMap>) list("GOVA_LIST_S_02","");
    }
}
