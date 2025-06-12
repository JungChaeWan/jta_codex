package web.product.service.impl;

import common.Constant;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.rsv.service.impl.RsvDAO;
import mas.sv.vo.SV_DIVINFVO;
import mas.sv.vo.SV_OPTINFVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import web.order.vo.SV_RSVVO;
import web.product.service.WebSvProductService;
import web.product.vo.WEB_SVPRDTVO;
import web.product.vo.WEB_SVSVO;
import web.product.vo.WEB_SV_DTLPRDTVO;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("webSvService")
public class WebSvProductServiceImpl extends EgovAbstractServiceImpl implements WebSvProductService{

	@SuppressWarnings("unused")
	private static final Logger log = LoggerFactory.getLogger(WebSvProductServiceImpl.class);

	/** webSvDAO */
	@Resource(name = "webSvDAO")
	private WebSvDAO webSvDAO;

	@Resource(name = "rsvDAO")
	private RsvDAO rsvDAO;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Override
	public WEB_SV_DTLPRDTVO selectByPrdt(WEB_SV_DTLPRDTVO prdtVO) {
		return webSvDAO.selectByPrdt(prdtVO);
	}

	@Override
	public List<WEB_SVPRDTVO> selectSvPrdtCntList(WEB_SVSVO searchVO) {
		return webSvDAO.selectSvPrdtCntList(searchVO);
	}

	@Override
	public List<WEB_SVPRDTVO> selectBestProductList() {
		return selectBestProductList(null, null);
	}

	public List<WEB_SVPRDTVO> selectBestProductList(String ctgr, List<String> rsvPrdtNumList) {
		// 5개만 뽑기.
		WEB_SVSVO searchVO = new WEB_SVSVO();

		searchVO.setsCtgr(ctgr);
		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(5);
		searchVO.setOrderCd(Constant.ORDER_RANDOM);

		/*if (rsvPrdtNumList != null) {
			searchVO.setRsvPrdtNumList(rsvPrdtNumList);
		}*/

		return webSvDAO.selectProductList(searchVO);
	}


	@Override
	public Map<String, Object> selectProductList(WEB_SVSVO searchVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<WEB_SVPRDTVO> resultList = webSvDAO.selectProductList(searchVO);
		Integer totalCnt = webSvDAO.getCntProductList(searchVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public List<WEB_SVPRDTVO> selectOtherProductList(String corpId, String prdc) {
		// 4개만 뽑기.
		WEB_SVSVO searchVO = new WEB_SVSVO();
		searchVO.setsCorpId(corpId);
		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(4);
		searchVO.setsPrdc(prdc);
		searchVO.setOrderCd(Constant.ORDER_SALE);

		return webSvDAO.selectProductList(searchVO);
	}

	@Override
	public List<SV_OPTINFVO> selectOptionList(SV_OPTINFVO sv_OPTINFVO) {
		return (List<SV_OPTINFVO>) webSvDAO.selectOptionList(sv_OPTINFVO);
	}

	@Override
	public List<SV_DIVINFVO> selectDivInfList(SV_DIVINFVO sv_DIVINFVO) {
		return (List<SV_DIVINFVO>) webSvDAO.selectDivInfList(sv_DIVINFVO);
	}

	@Override
	public WEB_SV_DTLPRDTVO selectByCartPrdt(WEB_SV_DTLPRDTVO prdtVO) {
		return webSvDAO.selectByCartPrdt(prdtVO);
	}

	@Override
	public String saleProductYn(String prdtNum, String svDivSn, String svOptSn, int qty) {
		WEB_SVPRDTVO prdt = new WEB_SVPRDTVO();
		prdt.setPrdtNum(prdtNum);
		prdt.setSvDivSn(svDivSn);
		prdt.setSvOptSn(svOptSn);
		prdt.setQty(qty);
		int productCnt = webSvDAO.saleProduct(prdt);
		if(productCnt > 0 ) {
			return Constant.FLAG_Y;
		} else {
				return Constant.FLAG_N;
		}
	}

	@Override
	public int getCntProductList(WEB_SVSVO searchVO) {
		return webSvDAO.getCntProductList(searchVO);
	}

	@Override
	public List<WEB_SVPRDTVO> selectProductListOssPrmt(WEB_SVSVO searchVO){
		return webSvDAO.selectProductListOssPrmt(searchVO);
	}

	/**
	 * 기념품 예약 업체에 대한 이전 등록 예약 총금액 구하기
	 * 파일명 : getSvPreSaleAmt
	 * 작성일 : 2017. 1. 24. 오후 4:54:27
	 * 작성자 : 최영철
	 * @param rsvNum
	 * @param corpId
	 * @return
	 */
	@Override
	public Integer getSvPreSaleAmt(String rsvNum, String corpId){
		SV_RSVVO svRsvVO = new SV_RSVVO();
		svRsvVO.setRsvNum(rsvNum);
		svRsvVO.setCorpId(corpId);

		// 같은 예약 건중 같은 업체인 예약건 전체 조회
		List<SV_RSVVO> resultList = rsvDAO.selectSvRsvList2(svRsvVO);

		Integer saleAmt = 0;

		String p_prdc = "";
		for(int i = 0; i < resultList.size(); i++){
			SV_RSVVO resultVO = resultList.get(i);
			// 조건부 무료인예약건이 있는 경우
			// 생산자별 묶음배송 처리 2021.06.07
			p_prdc = resultVO.getPrdc();
			if(Constant.DLV_AMT_DIV_APL.equals(resultVO.getDlvAmtDiv()) && (resultVO.getPrdc().equals(p_prdc)) ){
				saleAmt += Integer.parseInt(resultVO.getNmlAmt()) - Integer.parseInt(resultVO.getDlvAmt());
			}
		}
		return saleAmt;
	}

	/**
	 * 기념품의 하위 (depth2) 분류
	 * Function : getSvSubCategory
	 * 작성일 : 2017. 3. 17. 오후 12:19:39
	 * 작성자 : 정동수
	 * @param searchVO
	 * @return
	 */
	@Override
	public Map<String, List<CDVO>> getSvSubCategory(WEB_SVSVO searchVO) {
		Map<String, List<CDVO>> resultMap = new HashMap<String, List<CDVO>>();

		List<WEB_SVPRDTVO> depth1List = selectSvPrdtCntList(searchVO);

		for (WEB_SVPRDTVO result : depth1List) {
			resultMap.put(result.getCtgr(), ossCmmService.selectCode(result.getCtgr()));
		}

		return resultMap;
	}

	@Override
	public List<WEB_SVPRDTVO> selectProductListOssKwa(String kwaNum) {
		return webSvDAO.selectProductListOssKwa(kwaNum);
	}

	@Override
	public List<WEB_SVPRDTVO> selectBrandPrdtList(WEB_SVSVO searchVO) {
		return webSvDAO.selectBrandPrdtList(searchVO);
	}


	@Override
	public Map<String, Object> selectSixProductList(WEB_SVSVO searchVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		//ctgrDiv를 SV와 SP를 나누는 변수로 활용
		searchVO.setsCtgrDiv(searchVO.getsCtgr().substring(0,2));
		List<WEB_SVPRDTVO> resultList = webSvDAO.selectSixProductList(searchVO);
		Integer totalCnt = webSvDAO.getCntSixProductList(searchVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

}
