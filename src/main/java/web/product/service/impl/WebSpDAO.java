package web.product.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import mas.sp.vo.SP_DIVINFVO;
import mas.sp.vo.SP_OPTINFVO;
import web.order.vo.MRTNVO;
import web.product.vo.WEB_DTLPRDTVO;
import web.product.vo.WEB_SPPRDTVO;
import web.product.vo.WEB_SPSVO;

@Repository("webSpDAO")
public class WebSpDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<WEB_SPPRDTVO> selectProductList(WEB_SPSVO searchVO) {
		return (List<WEB_SPPRDTVO>) list("WEB_SP_PRDTINF_S_00", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<WEB_SPPRDTVO> selectProductListOssPrmt(WEB_SPSVO searchVO) {
		return (List<WEB_SPPRDTVO>) list("WEB_SP_PRDTINF_S_08", searchVO);
	}

	public Integer getCntProductList(WEB_SPSVO searchVO) {
		return (Integer) select("WEB_SP_PRDTINF_S_01", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<WEB_SPPRDTVO> selectSpPrdtCntList(WEB_SPSVO searchVO) {
		return (List<WEB_SPPRDTVO>) list("WEB_SP_PRDTINF_S_02", searchVO);
	}

	public WEB_DTLPRDTVO selectByPrdt(WEB_DTLPRDTVO prdtVO) {
		return (WEB_DTLPRDTVO) select("WEB_SP_PRDTINF_S_03", prdtVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_OPTINFVO> selectOptionList(SP_OPTINFVO sp_OPTINFVO) {
		return (List<SP_OPTINFVO>) list("WEB_SP_OPTINF_S_00", sp_OPTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<SP_DIVINFVO> selectDivInfList(SP_DIVINFVO sp_DIVINFVO) {
		return (List<SP_DIVINFVO>) list("WEB_SP_DIVINF_S_00", sp_DIVINFVO);
	}

	public WEB_DTLPRDTVO selectByFreePrdt(WEB_DTLPRDTVO prdtVO) {
		return (WEB_DTLPRDTVO) select("WEB_SP_PRDTINF_S_04", prdtVO);
	}

	public WEB_DTLPRDTVO selectByCartPrdt(WEB_DTLPRDTVO prdtVO) {
		return (WEB_DTLPRDTVO) select("WEB_SP_PRDTINF_S_05", prdtVO);
	}

	public int saleProduct(WEB_SPPRDTVO prdtVO) {
		return (Integer) select("WEB_SP_PRDTINF_S_06", prdtVO);
	}


	/**
	 * 패키지 용 베스트 상품 조회
	 * 파일명 : selectBestPackList
	 * 작성일 : 2016. 6. 29. 오후 4:13:49
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<WEB_SPPRDTVO> selectBestPackList(WEB_SPSVO searchVO) {
		return (List<WEB_SPPRDTVO>) list("WEB_SP_PRDTINF_S_09", searchVO);
	}

	/**
	 * 패키지 용 베스트 상품 조회 - 관리자 설정
	 * 파일명 : selectBestPackListMng
	 * 작성일 : 2017. 8. 1. 오전 10:00:52
	 * 작성자 : 신우섭
	 * @param searchVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<WEB_SPPRDTVO> selectBestPackListMng(WEB_SPSVO searchVO) {
		return (List<WEB_SPPRDTVO>) list("WEB_SP_PRDTINF_S_11", searchVO);
	}

	/**
	 * 지도에 필요한 판매중인 상품 업체 리스트
	 * @param searchVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<WEB_DTLPRDTVO> selectProductCorpMapList(WEB_SPSVO searchVO) {
		return  (List<WEB_DTLPRDTVO>) list("WEB_SP_PRDTINF_S_10", searchVO);
	}


	@SuppressWarnings("unchecked")
	public List<WEB_SPPRDTVO> selectProductListOssKwa(WEB_SPSVO searchVO) {
		return (List<WEB_SPPRDTVO>) list("WEB_SP_PRDTINF_S_12", searchVO);
	}
	
	@SuppressWarnings("unchecked")
	public MRTNVO chkTshirts(MRTNVO mrntSVO) {
		return (MRTNVO) select("WEB_SP_PRDTINF_S_13", mrntSVO);
	}
	
	@SuppressWarnings("unchecked")
	public MRTNVO chkTshirtsAbleBySize(MRTNVO mrtnSVO) {
		return (MRTNVO) select("WEB_SP_PRDTINF_S_14", mrtnSVO);
	}
	
	public String chkMrtnUser(MRTNVO mrtnSVO) {
		return (String) select("WEB_SP_PRDTINF_S_15", mrtnSVO);
	}
}
