package web.product.service;

import java.util.List;
import java.util.Map;

import mas.sp.vo.SP_DIVINFVO;
import mas.sp.vo.SP_OPTINFVO;
import web.order.vo.MRTNVO;
import web.product.vo.WEB_DTLPRDTVO;
import web.product.vo.WEB_SPPRDTVO;
import web.product.vo.WEB_SPSVO;

public interface WebSpProductService {

	Map<String, Object> selectProductList(WEB_SPSVO searchVO);

	 List<WEB_SPPRDTVO> selectSpPrdtCntList(WEB_SPSVO searchVO);

	List<WEB_SPPRDTVO> selectBestProductList(String ctgr, String depth);

	/**
	 * 쿠폰 & 뷰티 추천 상품 출력 시 예약된 상품 제외 리스트
	 * Function : selectBestProductList
	 * 작성일 : 2016. 8. 16. 오후 4:40:13
	 * 작성자 : 정동수
	 * @param ctgr
	 * @param depth
	 * @param rsvPrdtNumList
	 * @return
	 */
	List<WEB_SPPRDTVO> selectBestProductList(String ctgr, String depth, List<String> rsvPrdtNumList);

	List<WEB_SPPRDTVO> selectBestProductListMng(String ctgr);

	WEB_DTLPRDTVO selectByPrdt(WEB_DTLPRDTVO prdtVO);

	/**
	 * 구분자 정보에 따른 옵션리스트
	 * @param sp_OPTINFVO
	 * @return
	 */
	List<SP_OPTINFVO> selectOptionList(SP_OPTINFVO sp_OPTINFVO);

	/**
	 * 상품 구분자 정보 리스트.
	 * @param sp_DIVINFVO
	 * @return
	 */
	List<SP_DIVINFVO> selectDivInfList(SP_DIVINFVO sp_DIVINFVO);

	/**
	 * 판매자의 다른 상품 가져오기.
	 * @param corpId
	 * @return
	 */
	List<WEB_SPPRDTVO> selectOtherProductList(String corpId);
	
	/**
	 * 관광지의 주변 관광지 가져오기.
	 * @param corpId
	 * @return
	 */
	List<WEB_SPPRDTVO> selectOtherTourList(String corpId);

	WEB_DTLPRDTVO selectByCartPrdt(WEB_DTLPRDTVO prdtVO);

	String saleProductYn(String prdtNum, String divSn, String optSn, int qty);

	int getCntProductList(WEB_SPSVO searchVO);

	List<WEB_SPPRDTVO> selectProductListOssPrmt(WEB_SPSVO searchVO);

	/**
	 * 지도에 필요한 판매중인 상품 업체 리스트
	 * @param searchVO
	 * @return
	 */
	List<WEB_DTLPRDTVO> selectProductCorpMapList(WEB_SPSVO searchVO);

	List<WEB_SPPRDTVO> selectProductListOssKwa(WEB_SPSVO searchVO);
	
	/**
	 * 마라톤 티셔츠 총수량 체크
	 * @param mrtnVO
	 * @return
	 */
	MRTNVO chkTshirts(MRTNVO mrtnSVO);
	
	/**
	 * 마라톤 티셔츠 사이즈별 체크
	 * @param mrtnVO
	 * @return
	 */
	MRTNVO chkTshirtsAbleBySize(MRTNVO mrtnSVO);
	
	/**
	 * 마라톤 중복 신청자 확인
	 * @param mrtnVO
	 * @return
	 */
	String chkMrtnUser(MRTNVO mrtnSVO);
}
