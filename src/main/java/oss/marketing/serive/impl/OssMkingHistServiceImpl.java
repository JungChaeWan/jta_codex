package oss.marketing.serive.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import mas.ad.service.impl.MasAdPrdtServiceImpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import oss.marketing.serive.OssMkingHistService;
import oss.marketing.vo.MKINGHISTVO;

@Service("ossMkingHistService")
public class OssMkingHistServiceImpl implements OssMkingHistService {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(MasAdPrdtServiceImpl.class);

	@Resource(name = "mkingHistDAO")
	private MkingHistDAO mkingHistDAO;

	@Override
	public Map<String, Object> selectMkingHistList(MKINGHISTVO mkinghistVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultList", mkingHistDAO.selectMkingHistList(mkinghistVO));
		resultMap.put("totalCnt", mkingHistDAO.getMkingHistListCnt(mkinghistVO));

		return resultMap;
	}

	@Override
	public MKINGHISTVO selectMkingHist(MKINGHISTVO mkinghistVO) {
		return mkingHistDAO.selectMkingHist(mkinghistVO);
	}

	@Override
	public MKINGHISTVO getMkingHistSale(MKINGHISTVO mkinghistVO) {
		return mkingHistDAO.getMkingHistSale(mkinghistVO);
	}

	@Override
	public void insertMkingHist(MKINGHISTVO mkinghistVO) {
		mkingHistDAO.insertMkingHist(mkinghistVO);
	}

	@Override
	public void updateMkingHist(MKINGHISTVO mkinghistVO) {
		mkingHistDAO.updateMkingHist(mkinghistVO);
	}

	@Override
	public void deleteMkingHist(MKINGHISTVO deleteMkingHist) {
		mkingHistDAO.deleteMkingHist(deleteMkingHist);
	}






}
