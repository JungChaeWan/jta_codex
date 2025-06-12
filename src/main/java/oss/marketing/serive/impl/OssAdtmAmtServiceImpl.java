package oss.marketing.serive.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.ad.service.impl.MasAdPrdtServiceImpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import oss.marketing.serive.OssAdtmAmtService;
import oss.marketing.vo.ADTMAMTVO;

@Service("ossAdtmAmtService")
public class OssAdtmAmtServiceImpl implements OssAdtmAmtService {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(MasAdPrdtServiceImpl.class);

	@Resource(name = "OssAdtmAmtDAO")
	private OssAdtmAmtDAO ossAdtmAmtDAO;
	
	@Override
	public List<ADTMAMTVO> selectAdtmAmtList(ADTMAMTVO adtmAmtVO) {		
		return ossAdtmAmtDAO.selectAdtmAmtList(adtmAmtVO);
	}
	
	@Override
	public Map<String, String> selectSaleAmtList(ADTMAMTVO adtmAmtVO) {		
		Map<String, String> resultMap = new HashMap<String, String>(); 
		List<ADTMAMTVO> adtmList = ossAdtmAmtDAO.selectSaleAmtList(adtmAmtVO);
		
		for (ADTMAMTVO info : adtmList) {
			resultMap.put(info.getAplDt(), info.getSaleAmt());
		}
		
		return resultMap;
	}

	@Override
	public void mergeAdtmAmtList(List<ADTMAMTVO> amtList) {
		for (ADTMAMTVO adtmAmtVO : amtList) {
			ossAdtmAmtDAO.mergeAdtmAmt(adtmAmtVO);
		}
	}
}
