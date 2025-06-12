package api.service.impl;

import javax.annotation.Resource;

import mas.rc.service.impl.RcDAO;
import mas.rc.vo.RC_PRDTINFSVO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import web.order.service.impl.WebOrderDAO;
import web.order.vo.RC_RSVVO;
import api.service.APIRcService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("apiRcService")
public class APIRcServiceImpl extends EgovAbstractServiceImpl implements APIRcService {

	Logger log = (Logger) LogManager.getLogger(this.getClass());
	
	@Resource(name = "rcDAO")
	private RcDAO rcDAO;
	
	@Resource(name = "apiDAO")
	private APIDAO apiDAO;
	
	@Resource(name = "webOrderDAO")
	private WebOrderDAO webOrderDAO;
	
	/**
	 * 연계번호에 대한 상품번호 구하기
	 * 파일명 : selectByPrdtNum
	 * 작성일 : 2016. 7. 19. 오후 1:34:42
	 * 작성자 : 최영철
	 * @param rcPrdtSVO
	 * @return
	 */
	@Override
	public String selectByPrdtNumAtLinkNum(RC_PRDTINFSVO rcPrdtSVO){
		return rcDAO.selectByPrdtNumAtLinkNum(rcPrdtSVO);
	}
	
	/**
	 * 연계 예약 번호에 대해 렌터카 이용내역 추가
	 * 파일명 : insertRcHist
	 * 작성일 : 2016. 7. 20. 오전 10:55:02
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	@Override
	public void insertRcHist(RC_RSVVO rcRsvVO){
		webOrderDAO.insertRcHist(rcRsvVO);
	}
	
	/**
	 * 연계 예약 번호에 대한 렌터카 이용내역 삭제
	 * 파일명 : deleteRcUseHist
	 * 작성일 : 2016. 7. 20. 오후 2:12:11
	 * 작성자 : 최영철
	 * @param rcRsvVO
	 */
	@Override
	public void deleteRcUseHist(RC_RSVVO rcRsvVO){
		apiDAO.deleteRcUseHist(rcRsvVO);
	}
}
