package oss.prmt.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.prmt.service.impl.PrmtDAO;
import mas.prmt.vo.PRMTVO;

import org.springframework.stereotype.Service;

import oss.prmt.service.OssPrmtService;
import oss.prmt.vo.PRMTSVO;

@Service("ossPrmtService")
public class OssPrmtServiceImpl implements OssPrmtService {

	@Resource(name = "prmtDAO")
	private PrmtDAO prmtDAO;
	
	@Override
	public Map<String, Object> selectOssPrmtList(PRMTSVO prmtSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<PRMTVO> resultList = prmtDAO.selectOssPrmtList(prmtSVO);
		Integer totalCnt = prmtDAO.getCntOssPrmtList(prmtSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}

	@Override
	public void updatePrmtAppr(PRMTVO prmtVO) {
		prmtDAO.updatePrmtStatusCd(prmtVO);
	}

}
