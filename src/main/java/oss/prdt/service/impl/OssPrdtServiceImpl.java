package oss.prdt.service.impl;

import common.Constant;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.ad.service.impl.AdDAO;
import mas.ad.vo.AD_PRDTINFVO;
import mas.rc.service.impl.RcDAO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.sp.vo.SP_PRDTINFVO;
import mas.sv.service.impl.SvDAO;
import mas.sv.vo.SV_PRDTINFVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import oss.cmm.service.impl.CmmConfhistDAO;
import oss.cmm.vo.CM_CONFHISTVO;
import oss.prdt.service.OssPrdtService;
import oss.prdt.vo.PRDTSVO;
import oss.prdt.vo.PRDTVO;
import oss.sp.service.impl.SpDAO;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service("ossPrdtService")
public class OssPrdtServiceImpl extends EgovAbstractServiceImpl implements OssPrdtService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(OssPrdtServiceImpl.class);

	@Resource(name = "prdtDAO")
	private PrdtDAO prdtDAO;
	
	@Resource(name = "rcDAO")
	private RcDAO rcDAO;

	@Resource(name = "adDAO")
	private AdDAO adDAO;
	
	@Resource(name = "svDAO")
	private SvDAO svDAO;
	
	@Resource(name = "cmmConfhistDAO")
	private CmmConfhistDAO cmmConfhistDAO;
	
	/** SpDAO */
	@Resource(name = "spDAO")
	private SpDAO spDAO;
	
	/**
	 * 협회관리자 상품 리스트 조회
	 * 파일명 : selectPrdtList
	 * 작성일 : 2015. 10. 19. 오전 9:43:13
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectPrdtList(PRDTSVO prdtSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<PRDTVO> resultList = prdtDAO.selectPrdtList(prdtSVO);
		Integer totalCnt = prdtDAO.getCntPrdtList(prdtSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	/**
	 * 상품 승인 관리
	 * 파일명 : productAppr
	 * 작성일 : 2015. 10. 19. 오후 1:14:20
	 * 작성자 : 최영철
	 * @param cm_CONFHISTVO
	 */
	@Override
	public void productAppr(CM_CONFHISTVO cm_CONFHISTVO){
		String prdtNum = cm_CONFHISTVO.getLinkNum();
		String prdtCd = prdtNum.substring(0,2);
		
		PRDTVO prdtVO = new PRDTVO();
		prdtVO.setPrdtNum(prdtNum);
		/** 렌터카 승인 */
		if(Constant.RENTCAR.equals(prdtCd)) {
			RC_PRDTINFVO prdtInfVO = new RC_PRDTINFVO();
			prdtInfVO.setPrdtNum(prdtNum);
			prdtInfVO.setTradeStatus(cm_CONFHISTVO.getTradeStatus());
			rcDAO.approvalPrdt(prdtInfVO);
		/** 숙박 승인 */
		} else if(Constant.ACCOMMODATION.equals(prdtCd)) {
			AD_PRDTINFVO prdtInfVO = new AD_PRDTINFVO();
			prdtInfVO.setPrdtNum(prdtNum);
			prdtInfVO.setTradeStatus(cm_CONFHISTVO.getTradeStatus());
			adDAO.approvalPrdt(prdtInfVO);
		/** 소셜 승인 */
		} else if(Constant.SOCIAL.equals(prdtCd)) {
			SP_PRDTINFVO sp_PRDTINFVO = new SP_PRDTINFVO();
			sp_PRDTINFVO.setPrdtNum(prdtNum);
			sp_PRDTINFVO.setTradeStatus(cm_CONFHISTVO.getTradeStatus());	
			sp_PRDTINFVO.setLastModId(cm_CONFHISTVO.getRegId());
			sp_PRDTINFVO.setLastModIp(cm_CONFHISTVO.getRegIp());
			sp_PRDTINFVO.setSixCertiCate(cm_CONFHISTVO.getSixCertiCate());
			spDAO.approvalPrdt(sp_PRDTINFVO);
		/** 특산/기념품 승인 */
		} else if(Constant.SV.equals(prdtCd)) {
			SV_PRDTINFVO sv_PRDTINFVO = new SV_PRDTINFVO();
			sv_PRDTINFVO.setPrdtNum(prdtNum);
			sv_PRDTINFVO.setTradeStatus(cm_CONFHISTVO.getTradeStatus());	
			sv_PRDTINFVO.setLastModId(cm_CONFHISTVO.getRegId());
			sv_PRDTINFVO.setLastModIp(cm_CONFHISTVO.getRegIp());
			sv_PRDTINFVO.setSixCertiCate(cm_CONFHISTVO.getSixCertiCate());
			if(Constant.FLAG_Y.equals(cm_CONFHISTVO.getSuperbSvYn())) {
				sv_PRDTINFVO.setSuperbSvYn(Constant.FLAG_Y);
			} else {
				sv_PRDTINFVO.setSuperbSvYn(Constant.FLAG_N);
			}
			if(Constant.FLAG_Y.equals(cm_CONFHISTVO.getJqYn())) {
				sv_PRDTINFVO.setJqYn(Constant.FLAG_Y);
			} else {
				sv_PRDTINFVO.setJqYn(Constant.FLAG_N);
			}
			svDAO.approvalPrdt(sv_PRDTINFVO);
		}
		String histNum = cmmConfhistDAO.selectHistNum(cm_CONFHISTVO.getLinkNum());
		cm_CONFHISTVO.setHistNum(histNum);
		cmmConfhistDAO.insertConfhist(cm_CONFHISTVO);
	}

	@Override
	public  CM_CONFHISTVO selectPrdtApprInfo(CM_CONFHISTVO cm_CONFHISTVO) {
		String prdtCd =  cm_CONFHISTVO.getLinkNum().substring(0,2);

		cm_CONFHISTVO.setPrdtCd(prdtCd);
		
		return cmmConfhistDAO.selectPrdtApprInfo(cm_CONFHISTVO) ;
	}

	@Override
	public Integer getCntRTPrdtMain(PRDTVO prdtVO) {
		return prdtDAO.getCntRTPrdtMain(prdtVO);
	}

	@Override
	public Integer getCntSPPrdtMain(PRDTVO prdtVO) {
		return prdtDAO.getCntSPPrdtMain(prdtVO);
	}
	
	@Override
	public Integer getCntSVPrdtMain(PRDTVO prdtVO) {
		return prdtDAO.getCntSVPrdtMain(prdtVO);
	}

	@Override
	public Integer getCntRfAcc(PRDTVO prdtVO) {
		return prdtDAO.getCntRfAcc(prdtVO);
	}

	@Override
	public List<PRDTVO> chckPrdtExpireList(PRDTSVO prdtSVO) {
		
		return prdtDAO.chckPrdtExpireList(prdtSVO);
	}

	@Override
	public List<PRDTVO> chckPrdtEndList(PRDTSVO prdtSVO) {

		return prdtDAO.chckPrdtEndList(prdtSVO);
	}

	@Override
	public Integer chckPrdtExpireListCnt(PRDTSVO prdtSVO) {
		
		return prdtDAO.chckPrdtExpireListCnt(prdtSVO);
	}
	
	@Override
	public List<PRDTVO> chckPrdtStasticsCnt1(PRDTSVO prdtSVO) {
		
		return prdtDAO.chckPrdtStasticsCnt1(prdtSVO);
	}
	
	@Override
	public List<PRDTVO> chckPrdtStasticsCnt2(PRDTSVO prdtSVO) {
		
		return prdtDAO.chckPrdtStasticsCnt2(prdtSVO);
	}

	@Override
	public Map<String, Object> selectPrdtAllList(PRDTSVO prdtSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<PRDTVO> resultList = prdtDAO.selectPrdtAllList(prdtSVO);
		Integer totalCnt = prdtDAO.selectPrdtAllCnt(prdtSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public void updateTamnacardPrdtYn(PRDTSVO prdtSVO){
		prdtDAO.updateTamnacardPrdtYn(prdtSVO);
	}	
}
