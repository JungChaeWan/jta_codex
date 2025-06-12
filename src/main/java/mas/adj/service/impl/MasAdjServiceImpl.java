package mas.adj.service.impl;

import java.util.List;

import javax.annotation.Resource;

import mas.adj.service.MasAdjService;

import org.springframework.stereotype.Service;

import oss.adj.service.impl.AdjDAO;
import oss.adj.vo.ADJSVO;
import oss.adj.vo.ADJVO;
import egovframework.cmmn.service.impl.ScheduleDAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("masAdjService")
public class MasAdjServiceImpl extends EgovAbstractServiceImpl implements MasAdjService{
	
	@Resource(name="scheduleDAO")
	private ScheduleDAO scheduleDAO;
	
	@Resource(name="adjDAO")
	private AdjDAO adjDAO;
	
	/**
	 * 업체 정산 조회
	 * 파일명 : selectCorpAdjListYM
	 * 작성일 : 2016. 1. 13. 오전 11:52:22
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	@Override
	public List<ADJVO> selectCorpAdjListYM(ADJSVO adjSVO){
		return adjDAO.selectCorpAdjListYM(adjSVO);
	}

	/**
	 * 검색 기간에 해당하는 업체 정상 리스트
	 * Function : selectAdjListSearch
	 * 작성일 : 2017. 5. 23. 오전 10:21:47
	 * 작성자 : 정동수
	 * @param adjSVO
	 * @return
	 */
	@Override
	public List<ADJVO> selectCorpAdjListSearch(ADJSVO adjSVO) {
		return adjDAO.selectCorpAdjListSearch(adjSVO);
	}

	/**
	 * 정산 총 누적 금액 산출
	 * Function : selectCorpAdjTotal
	 * 작성일 : 2017. 5. 23. 오전 11:55:37
	 * 작성자 : 정동수
	 * @param adjSVO
	 * @return
	 */
	@Override
	public int selectCorpAdjTotal(ADJSVO adjSVO) {		
		return adjDAO.selectCorpAdjTotal(adjSVO);
	}
	
}
