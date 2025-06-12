package web.product.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import mas.sv.vo.SV_DIVINFVO;
import mas.sv.vo.SV_OPTINFVO;
import org.springframework.stereotype.Repository;
import web.product.vo.WEB_SVPRDTVO;
import web.product.vo.WEB_SVSVO;
import web.product.vo.WEB_SV_DTLPRDTVO;

import java.util.List;

@Repository("webSvDAO")
public class WebSvDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<WEB_SVPRDTVO> selectProductList(WEB_SVSVO searchVO) {
		return (List<WEB_SVPRDTVO>) list("WEB_SV_PRDTINF_S_00", searchVO);
	}

	public Integer getCntProductList(WEB_SVSVO searchVO) {
		return (Integer) select("WEB_SV_PRDTINF_S_01", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<WEB_SVPRDTVO> selectSvPrdtCntList(WEB_SVSVO searchVO) {
		return (List<WEB_SVPRDTVO>) list("WEB_SV_PRDTINF_S_02", searchVO);
	}

	public WEB_SV_DTLPRDTVO selectByPrdt(WEB_SV_DTLPRDTVO prdtVO) {
		return (WEB_SV_DTLPRDTVO) select("WEB_SV_PRDTINF_S_03", prdtVO);
	}

	@SuppressWarnings("unchecked")
	public List<SV_OPTINFVO> selectOptionList(SV_OPTINFVO sv_OPTINFVO) {
		return (List<SV_OPTINFVO>) list("WEB_SV_OPTINF_S_00", sv_OPTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SV_DIVINFVO> selectDivInfList(SV_DIVINFVO sv_DIVINFVO) {
		return (List<SV_DIVINFVO>) list("WEB_SV_DIVINF_S_00", sv_DIVINFVO);
	}

	public WEB_SV_DTLPRDTVO selectByCartPrdt(WEB_SV_DTLPRDTVO prdtVO) {
		return (WEB_SV_DTLPRDTVO) select("WEB_SV_PRDTINF_S_05", prdtVO);
	}

	public int saleProduct(WEB_SVPRDTVO prdtVO) {
		return (Integer) select("WEB_SV_PRDTINF_S_06", prdtVO);
	}

	@SuppressWarnings("unchecked")
	public List<WEB_SVPRDTVO> selectProductListOssPrmt(WEB_SVSVO searchVO) {
		return (List<WEB_SVPRDTVO>) list("WEB_SV_PRDTINF_S_08", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<WEB_SVPRDTVO> selectProductListOssKwa(String kwaNum) {
		return (List<WEB_SVPRDTVO>) list("WEB_SV_PRDTINF_S_11", kwaNum);
	}
	
	@SuppressWarnings("unchecked")
	public List<WEB_SVPRDTVO> selectBrandPrdtList(WEB_SVSVO searchVO) {
		return (List<WEB_SVPRDTVO>) list("WEB_SV_BRAND_S_00", searchVO);
	}

	public List<WEB_SVPRDTVO> selectSixProductList(WEB_SVSVO searchVO) {
		return (List<WEB_SVPRDTVO>) list("WEB_SV_PRDTINF_S_12", searchVO);
	}

	public Integer getCntSixProductList(WEB_SVSVO searchVO) {
		return (Integer) select("WEB_SV_PRDTINF_S_13", searchVO);
	}

}
