package web.product.service.impl;

import common.LowerHashMap;
import egovframework.rte.fdl.property.EgovPropertyService;
import mas.prmt.service.impl.PrmtDAO;
import mas.prmt.vo.PRMTCMTVO;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;
import org.springframework.stereotype.Service;
import oss.corp.service.OssCorpService;
import oss.point.vo.POINT_CPVO;
import oss.prmt.vo.GOVASVO;
import oss.prmt.vo.GOVAVO;
import web.product.service.*;

import javax.annotation.Resource;
import java.util.*;

@Service("webPrmtService")
public class WebPrmtServiceImpl implements WebPrmtService {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "webPrmtDAO")
	private WebPrmtDAO webPrmtDAO;

	@Resource(name = "prmtDAO")
	private PrmtDAO prmtDAO;
	
	@Resource(name = "ossCorpService")
	protected OssCorpService ossCorpService;
	
	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "webRcProductService")
	protected WebRcProductService webRcProductService;

	@Resource(name = "webSpService")
	protected WebSpProductService webSpService;

	@Resource(name = "webSvService")
	protected WebSvProductService webSvService;

	@Override
	public Map<String, Object> selectPromotionList(PRMTVO prmtVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<PRMTVO> resultList = webPrmtDAO.selectPromotionList(prmtVO);
		Integer totalCnt = webPrmtDAO.getCntPromotionList(prmtVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public Map<String, Object> selectPointList() {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<POINT_CPVO> resultList = webPrmtDAO.selectPointList();
		Integer totalCnt = resultList.size();

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public PRMTVO selectByPrmt(PRMTVO prmtVO) {
		return prmtDAO.selectByPrmt(prmtVO);
	}

	@Override
	public List<PRMTPRDTVO> selectPrmtPrdtList(PRMTVO prmtVO) {
		return prmtDAO.selectPrmtPrdtList(prmtVO);
	}

	@Override
	public List<PRMTPRDTVO> selectPrmtPrdtListOss(PRMTVO prmtVO) {
		return prmtDAO.selectPrmtPrdtListOss(prmtVO);
	}

	@Override
	public List<PRMTPRDTVO> selectPrmtPrdtList(String prmtNum) {
		return prmtDAO.selectPrmtPrdtList(prmtNum);
	}
		
	@Override
	public List<PRMTCMTVO> selectPrmtCmtList(PRMTCMTVO prmtCmtVO) {
		return prmtDAO.selectPrmtCmtList(prmtCmtVO);
	}

	@Override
	public List<PRMTCMTVO> selectPrmtCmtListNopage(PRMTCMTVO prmtCmtVO) {
		return prmtDAO.selectPrmtCmtListNopage(prmtCmtVO);
	}

	@Override
	public int selectPrmtCmtTotalCnt(PRMTCMTVO prmtCmtVO) {
		return prmtDAO.selectPrmtCmtTotalCnt(prmtCmtVO);
	}

	@Override
	public void insertPrmtCmt(PRMTCMTVO prmtCmtVO) {
		prmtDAO.insertPrmtCmt(prmtCmtVO);
	}

	@Override
	public void updatePrmtCmt(PRMTCMTVO prmtCmtVO) {
		prmtDAO.updatePrmtCmt(prmtCmtVO);
	}

	@Override
	public void deletePrmtCmt(PRMTCMTVO prmtCmtVO) {
		prmtDAO.deletePrmtCmt(prmtCmtVO);

	}
	
	// 정렬 내림차순
	class DescPrmt implements Comparator<PRMTPRDTVO> {
	    @Override
	    public int compare(PRMTPRDTVO o1, PRMTPRDTVO o2) {
	    	int nPrintSn1 = 0;
	    	int nPrintSn2 = 0;

	    	if( !(o1.getPrintSn() == null || o1.getPrintSn().isEmpty() || "".equals(o1.getPrintSn())) ){
	    		nPrintSn1 = Integer.parseInt(o1.getPrintSn());
	    	}

	    	if( !(o2.getPrintSn() == null || o2.getPrintSn().isEmpty() || "".equals(o2.getPrintSn())) ){
	    		nPrintSn2 = Integer.parseInt(o2.getPrintSn());
	    	}

	    	return nPrintSn1-nPrintSn2;
	        //return o2.getName().compareTo(o1.getName());
	    }

	}

	/**
	 * 각 카테고리 상품 상세의 프로모션 출력
	 * Function : selectDeteilPromotionList
	 * 작성일 : 2018. 1. 9. 오후 2:30:23
	 * 작성자 : 정동수
	 * @param prmtPrdtVO
	 * @return
	 */
	@Override
	public List<PRMTVO> selectDeteilPromotionList(PRMTPRDTVO prmtPrdtVO) {
		return webPrmtDAO.selectDeteilPromotionList(prmtPrdtVO);
	}

	@Override
	public PRMTVO getPromotionPrevNext(PRMTVO prmtVO) {
		return webPrmtDAO.getPromotionPrevNext(prmtVO);
	}

	@Override
	public void updateViewCnt(String  prmtNum) {
		prmtDAO.updateViewCnt(prmtNum);
	}

	@Override
	public PRMTVO selectAdBanner(){
		return webPrmtDAO.selectAdBanner();
	}

    @Override
    public List<LowerHashMap> govaList(GOVASVO govaSVO) {
		return webPrmtDAO.govaList(govaSVO);
    }

	@Override
	public void updateGovaMemo(GOVAVO govaVO) {
		webPrmtDAO.updateGovaMemo(govaVO);
	}

	@Override
	public void updateGovaConfirmed(GOVAVO govaVO) {
		webPrmtDAO.updateGovaConfirmed(govaVO);
	}

	@Override
	public List<LowerHashMap> selectAutoCompleteList() {
		return webPrmtDAO.selectAutoCompleteList();
	}
}
