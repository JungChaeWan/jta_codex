package oss.marketing.serive.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.ad.service.impl.MasAdPrdtServiceImpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import oss.marketing.serive.OssBestprdtService;
import oss.marketing.vo.BESTPRDTSVO;
import oss.marketing.vo.BESTPRDTVO;

@Service("ossBestprdtService")
public class OssBestprdtServiceImpl implements OssBestprdtService {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(MasAdPrdtServiceImpl.class);

	@Resource(name = "bestPrdtDAO")
	private BestPrdtDAO bestprdtDAO;



	@Override
	public Map<String, Object> selectBestprdtList(BESTPRDTSVO bestprdtSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultList", bestprdtDAO.selectBestprdtList(bestprdtSVO));
		resultMap.put("totalCnt", bestprdtDAO.selectBestprdtListCnt(bestprdtSVO));

		return resultMap;
	}

	@Override
	public BESTPRDTVO selectBestprdt(BESTPRDTVO bestprdtVO) {
		return bestprdtDAO.selectBestprdt(bestprdtVO);
	}

	@Override
	public void insertBestprdt(BESTPRDTVO bestprdtVO) {
		bestprdtDAO.insertBestprdt(bestprdtVO);

	}

	@Override
	public void updateBestprdt(BESTPRDTVO bestprdtVO) {
		bestprdtDAO.updateBestprdt(bestprdtVO);

	}

	@Override
	public void deleteBestprdt(BESTPRDTVO bestprdtVO) {
		bestprdtDAO.deleteBestprdt(bestprdtVO);

	}

	@Override
	public Integer getMaxCntBestprdtPos(BESTPRDTVO bestprdtVO) {
		return bestprdtDAO.getMaxCntBestprdtPos(bestprdtVO);
	}

	@Override
	public void addViewSn(BESTPRDTVO bestprdtVO) {
		bestprdtDAO.addViewSn(bestprdtVO);

	}

	@Override
	public void minusViewSn(BESTPRDTVO bestprdtVO) {
		bestprdtDAO.minusViewSn(bestprdtVO);

	}
	
	@Override
	public List<BESTPRDTVO> selectBestprdtWebList(BESTPRDTSVO bestprdtSVO) {
		return bestprdtDAO.selectBestprdtWebList(bestprdtSVO);
	}

}
