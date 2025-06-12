package oss.marketing.serive.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.ad.service.impl.MasAdPrdtServiceImpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import oss.marketing.serive.OssKwaService;
import oss.marketing.vo.KWAPRDTVO;
import oss.marketing.vo.KWASVO;
import oss.marketing.vo.KWAVO;

@Service("ossKwaService")
public class OssKwaServiceImpl implements OssKwaService {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(MasAdPrdtServiceImpl.class);

	@Resource(name = "kwaDAO")
	private KwaDAO kwaDAO;


	//@Override
	//public List<KWAVO> selectKawList(KWAVO kwaVO) {
	//	return kawDAO.selectKawList(kwaVO);
	//}

	@Override
	public Map<String, Object> selectKwaList(KWASVO kwaSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultList", kwaDAO.selectKawList(kwaSVO));
		resultMap.put("totalCnt", kwaDAO.selectKawListCnt(kwaSVO));

		return resultMap;
	}

	@Override
	public Map<String, Object> selectKwaListFind(KWASVO kwaSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultList", kwaDAO.selectKawListFind(kwaSVO));
		resultMap.put("totalCnt", kwaDAO.selectKawListCntFind(kwaSVO));

		return resultMap;
	}

	//@Override
	//public int selectKawListCnt(KWAVO kwaVO) {
	//	return kawDAO.selectKawListCnt(kwaVO);
	//}

	@Override
	public KWAVO selectKwa(KWAVO kwaVO) {
		return kwaDAO.selectKaw(kwaVO);
	}

	@Override
	public String insertKwa(KWAVO kwaVO) {
		String strPk = kwaDAO.selectKawListNewPk();
		kwaVO.setKwaNum(strPk);
		kwaDAO.insertKaw(kwaVO);
		return strPk;

	}

	@Override
	public void updateKwa(KWAVO kwaVO) {
		kwaDAO.updateKaw(kwaVO);

	}

	@Override
	public void deleteKwa(KWAVO kwaVO) {
		kwaDAO.deleteKawPrdtAll(kwaVO.getKwaNum());
		kwaDAO.deleteKaw(kwaVO);

	}

	@Override
	public List<KWAVO> selectKwaWebList(KWASVO kwaSVO) {
		List<KWAVO> list = kwaDAO.selectKawWebList(kwaSVO);
		for (KWAVO data : list) {
			data.setKwaNm("#"+data.getKwaNm());
		}

		return list;
	}

	@Override
	public List<KWAVO> selectKwaWebPrdtList(KWASVO kwaSVO) {
		List<KWAVO> list = kwaDAO.selectKawWebPrdtList(kwaSVO);
		for (KWAVO data : list) {
			data.setKwaNm("#"+data.getKwaNm());
		}
		return list;
	}


	@Override
	public void insertKawPrdt(KWAPRDTVO kwaprdtVO) {
		kwaDAO.insertKawPrdt(kwaprdtVO);

	}

	@Override
	public void deleteKawPrdtAll(String kwaNum) {
		kwaDAO.deleteKawPrdtAll(kwaNum);

	}

	@Override
	public List<KWAPRDTVO> selectKawPrdtList(KWAPRDTVO kwaprdtVO) {
		return kwaDAO.selectKawPrdtList(kwaprdtVO);
	}

	@Override
	public void updateKawPrdtSort(KWAPRDTVO kwaprdtVO) {
		// 증가
		if (kwaprdtVO.getOldSn() > kwaprdtVO.getNewSn()){
			kwaDAO.incremntKawPrdtPrintSn(kwaprdtVO);
		}
		// 감소
		if (kwaprdtVO.getOldSn() < kwaprdtVO.getNewSn()){
			kwaDAO.downKawPrdtPrintSn(kwaprdtVO);
		}

		kwaDAO.updateKawPrdtPrintSn(kwaprdtVO);

	}





}
