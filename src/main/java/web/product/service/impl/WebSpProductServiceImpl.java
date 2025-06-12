package web.product.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.sp.vo.SP_DIVINFVO;
import mas.sp.vo.SP_OPTINFVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import web.order.vo.MRTNVO;
import web.product.service.WebSpProductService;
import web.product.vo.WEB_DTLPRDTVO;
import web.product.vo.WEB_SPPRDTVO;
import web.product.vo.WEB_SPSVO;
import common.Constant;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("webSpService")
public class WebSpProductServiceImpl extends EgovAbstractServiceImpl implements WebSpProductService{


	@SuppressWarnings("unused")
	private static final Logger log = LoggerFactory.getLogger(WebSpProductServiceImpl.class);

	/** webSpDAO */
	@Resource(name = "webSpDAO")
	private WebSpDAO webSpDAO;

	@Override
	public Map<String, Object> selectProductList(WEB_SPSVO searchVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<WEB_SPPRDTVO> resultList = webSpDAO.selectProductList(searchVO);
		/*Integer totalCnt = webSpDAO.getCntProductList(searchVO);*/

		resultMap.put("resultList", resultList);
		/*resultMap.put("totalCnt", totalCnt);*/

		return resultMap;
	}

	@Override
	public List<WEB_SPPRDTVO> selectSpPrdtCntList(WEB_SPSVO searchVO) {
		return webSpDAO.selectSpPrdtCntList(searchVO);
	}

	@Override
	public List<WEB_SPPRDTVO> selectBestProductListMng(String ctgr) {
		WEB_SPSVO searchVO = new WEB_SPSVO();
		searchVO.setsCtgr(ctgr);

		return webSpDAO.selectBestPackListMng(searchVO);
	}

	@Override
	public List<WEB_SPPRDTVO> selectBestProductList(String ctgr, String depth) {
		return selectBestProductList(ctgr, depth, null);
	}

	/**
	 * 쿠폰 & 뷰티 추천 상품 리스트 (rsvPrdtNumList 추가)
	 * 파일명 : WebSpProductServiceImpl.java
	 * 작성일 : 2016. 8. 16. 오후 4:42:01
	 * 작성자 : 정동수
	 * Note : rsvPrdtNumList 가 null 이 아니면 예약된 상품 제외해서 추천 상품 리스트 출력
	 */
	@Override
	public List<WEB_SPPRDTVO> selectBestProductList(String ctgr, String depth, List<String> rsvPrdtNumList) {
		// 5개만 뽑기.
		WEB_SPSVO searchVO = new WEB_SPSVO();

		if(Constant.CATEGORY_PACKAGE.equals(ctgr)) {
			searchVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE);

			return webSpDAO.selectBestPackList(searchVO);
		} else if(!Constant.CATEGORY_PACKAGE.equals(ctgr) && "1".equals(depth)) {
			searchVO.setsPrdtDiv(Constant.SP_PRDT_DIV_COUP);
		}
		searchVO.setsCtgr(ctgr);
		searchVO.setsCtgrDepth(depth);
		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(5);
		searchVO.setOrderCd(Constant.ORDER_RANDOM);

		if (rsvPrdtNumList != null) {
			searchVO.setRsvPrdtNumList(rsvPrdtNumList);
		}

		return webSpDAO.selectProductList(searchVO);
	}

	@Override
	public WEB_DTLPRDTVO selectByPrdt(WEB_DTLPRDTVO prdtVO) {
		if(Constant.SP_PRDT_DIV_FREE.equals(prdtVO.getPrdtDiv())) {
			return webSpDAO.selectByFreePrdt(prdtVO);
		} else {
			return webSpDAO.selectByPrdt(prdtVO);
		}

	}

	@Override
	public List<SP_OPTINFVO> selectOptionList(SP_OPTINFVO sp_OPTINFVO) {
		return (List<SP_OPTINFVO>) webSpDAO.selectOptionList(sp_OPTINFVO);
	}

	@Override
	public List<SP_DIVINFVO> selectDivInfList(SP_DIVINFVO sp_DIVINFVO) {
		return (List<SP_DIVINFVO>) webSpDAO.selectDivInfList(sp_DIVINFVO);
	}

	@Override
	public List<WEB_SPPRDTVO> selectOtherProductList(String corpId) {
		// 4개만 뽑기.
		WEB_SPSVO searchVO = new WEB_SPSVO();
		searchVO.setsCorpId(corpId);
		searchVO.setsPrdtDiv(Constant.SP_PRDT_DIV_TOUR);
		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(4);
		searchVO.setsCtgrDiv(Constant.CATEGORY_PACKAGE);
		searchVO.setOrderCd(Constant.ORDER_SALE);
		return webSpDAO.selectProductList(searchVO);
	}
	
	@Override
	public List<WEB_SPPRDTVO> selectOtherTourList(String corpId) {
		// 4개만 뽑기.
		WEB_SPSVO searchVO = new WEB_SPSVO();
	//	searchVO.setsCorpId(corpId);
		searchVO.setsPrdtDiv(Constant.SP_PRDT_DIV_COUP);
		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(4);
		searchVO.setsCtgrDiv(Constant.CATEGORY_TOUR);
		searchVO.setOrderCd(Constant.ORDER_DIST);
		return webSpDAO.selectProductList(searchVO);
	}

	@Override
	public WEB_DTLPRDTVO selectByCartPrdt(WEB_DTLPRDTVO prdtVO) {
		return webSpDAO.selectByCartPrdt(prdtVO);
	}

	@Override
	public String saleProductYn(String prdtNum, String divSn, String optSn, int qty) {
		WEB_SPPRDTVO prdt = new WEB_SPPRDTVO();
		prdt.setPrdtNum(prdtNum);
		prdt.setSpDivSn(divSn);
		prdt.setSpOptSn(optSn);
		prdt.setQty(qty);
		int productCnt = webSpDAO.saleProduct(prdt);
		if(productCnt > 0 ) {
			return Constant.FLAG_Y;
		} else {
				return Constant.FLAG_N;
		}
	}

	@Override
	public int getCntProductList(WEB_SPSVO searchVO) {
		return webSpDAO.getCntProductList(searchVO);
	}


	@Override
	public List<WEB_SPPRDTVO> selectProductListOssPrmt(WEB_SPSVO searchVO) {
		return webSpDAO.selectProductListOssPrmt(searchVO);
	}

	@Override
	public List<WEB_DTLPRDTVO> selectProductCorpMapList(WEB_SPSVO searchVO) {
		return webSpDAO.selectProductCorpMapList(searchVO);
	}

	@Override
	public List<WEB_SPPRDTVO> selectProductListOssKwa(WEB_SPSVO searchVO) {
		return webSpDAO.selectProductListOssKwa(searchVO);
	}
	
	@Override
	public MRTNVO chkTshirts(MRTNVO mrtnSVO) {
		return webSpDAO.chkTshirts(mrtnSVO);
	}
	
	@Override
	public MRTNVO chkTshirtsAbleBySize(MRTNVO mrtnSVO) {
		
		int limit = mrtnSVO.getApctNm().split(",").length;
		String[] tshirts = mrtnSVO.getTshirts().split(",", limit);
		
		String[] corpId = mrtnSVO.getCartCorpId().split(",");
		String[] prdtNum = mrtnSVO.getCartPrdtNum().split(",");
		mrtnSVO.setCorpId(corpId[0]);
		mrtnSVO.setPrdtNum(prdtNum[0]);
		
		int txsUseCnt = 0;int tsUseCnt = 0;int tmUseCnt = 0;int tlUseCnt = 0;int txlUseCnt = 0;int t2xlUseCnt = 0;int t3xlUseCnt = 0;
		for(int i=0; i < tshirts.length; i++) {

			if("XS".equals(tshirts[i])) {
				txsUseCnt++;
			} else if ("S".equals(tshirts[i])) {
				tsUseCnt++;
			} else if ("M".equals(tshirts[i])) {
				tmUseCnt++;
			} else if ("L".equals(tshirts[i])) {
				tlUseCnt++;
			} else if ("XL".equals(tshirts[i])) {
				txlUseCnt++;
			} else if ("2XL".equals(tshirts[i])) {
				t2xlUseCnt++;
			} else if ("3XL".equals(tshirts[i])) {
				t3xlUseCnt++;
			}
		}
		
		mrtnSVO.setTxsUseCnt(Integer.toString(txsUseCnt));
		mrtnSVO.setTsUseCnt(Integer.toString(tsUseCnt));
		mrtnSVO.setTmUseCnt(Integer.toString(tmUseCnt));
		mrtnSVO.setTlUseCnt(Integer.toString(tlUseCnt));
		mrtnSVO.setTxlUseCnt(Integer.toString(txlUseCnt));
		mrtnSVO.setT2xlUseCnt(Integer.toString(t2xlUseCnt));
		mrtnSVO.setT3xlUseCnt(Integer.toString(t3xlUseCnt));
		
		return webSpDAO.chkTshirtsAbleBySize(mrtnSVO);
	}
	
	@Override
	public String chkMrtnUser(MRTNVO mrtnSVO) {
		return webSpDAO.chkMrtnUser(mrtnSVO);
	}	
}
