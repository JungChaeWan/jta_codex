package web.product.service;

import mas.sv.vo.SV_DIVINFVO;
import mas.sv.vo.SV_OPTINFVO;
import oss.cmm.vo.CDVO;
import web.product.vo.WEB_SVPRDTVO;
import web.product.vo.WEB_SVSVO;
import web.product.vo.WEB_SV_DTLPRDTVO;

import java.util.List;
import java.util.Map;

public interface WebSvProductService {

	WEB_SV_DTLPRDTVO selectByPrdt(WEB_SV_DTLPRDTVO prdtVO) ;

	List<WEB_SVPRDTVO> selectSvPrdtCntList(WEB_SVSVO searchVO);

	List<WEB_SVPRDTVO> selectBestProductList();

	Map<String, Object> selectProductList(WEB_SVSVO searchVO);

	List<WEB_SVPRDTVO> selectOtherProductList(String corpId, String prdc);

	List<SV_OPTINFVO> selectOptionList(SV_OPTINFVO sv_OPTINFVO);

	List<SV_DIVINFVO> selectDivInfList(SV_DIVINFVO sv_DIVINFVO);

	WEB_SV_DTLPRDTVO selectByCartPrdt(WEB_SV_DTLPRDTVO searchVO);

	String saleProductYn(String prdtNum, String svDivSn, String svOptSn, int parseInt);

	int getCntProductList(WEB_SVSVO searchVO);

	List<WEB_SVPRDTVO> selectProductListOssPrmt(WEB_SVSVO svWebSVO);

	List<WEB_SVPRDTVO> selectBrandPrdtList(WEB_SVSVO searchVO);

	/**
	 * 기념품 예약 업체에 대한 이전 등록 예약 총금액 구하기
	 * 파일명 : getSvPreSaleAmt
	 * 작성일 : 2017. 1. 24. 오후 4:54:27
	 * 작성자 : 최영철
	 * @param rsvNum
	 * @param corpId
	 * @return
	 */
	Integer getSvPreSaleAmt(String rsvNum, String corpId);

	/**
	 * 기념품의 하위 (depth2) 분류
	 * Function : getSvSubCategory
	 * 작성일 : 2017. 3. 17. 오후 12:19:39
	 * 작성자 : 정동수
	 * @param searchVO
	 * @return
	 */
	Map<String, List<CDVO>> getSvSubCategory(WEB_SVSVO searchVO);


	/**
	 * 키워드 광고 관련 상품 조회
	 * 파일명 : selectProductListOssKwa
	 * 작성일 : 2017. 8. 8. 오후 4:26:54
	 * 작성자 : 신우섭
	 * @param kwaNum
	 * @return
	 */
	List<WEB_SVPRDTVO> selectProductListOssKwa(String kwaNum);

	/**
	* 설명 : 6차산업인증 상품 리스트
	* 파일명 :
	* 작성일 : 2023-05-30 오후 3:49
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	Map<String, Object> selectSixProductList(WEB_SVSVO searchVO);
}
