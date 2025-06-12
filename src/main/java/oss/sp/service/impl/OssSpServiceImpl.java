package oss.sp.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import oss.cmm.service.OssFileUtilService;
import oss.sp.service.OssSpService;
import oss.sp.vo.OSS_PRDTINFSVO;

@Service("ossSpService")
public class OssSpServiceImpl implements OssSpService {

	@SuppressWarnings("unused")
	private static final Logger log = LoggerFactory.getLogger(OssSpServiceImpl.class);

	/** SpDAO */
	@Resource(name = "spDAO")
	private SpDAO spDAO;
	
	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Override
	public Map<String, Object> selectOssSpPrdtInfList(OSS_PRDTINFSVO oss_PRDTINFSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<OSS_PRDTINFSVO> resultList = spDAO.selectOssSpPrdtInfList(oss_PRDTINFSVO);
		Integer totalCnt = spDAO.getCntOssSpPrdtInfList(oss_PRDTINFSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> selectOssSpPrdtInfList2(OSS_PRDTINFSVO oss_PRDTINFSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<OSS_PRDTINFSVO> resultList = spDAO.selectOssSpPrdtInfList2(oss_PRDTINFSVO);
		Integer totalCnt = spDAO.getCntOssSpPrdtInfList2(oss_PRDTINFSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}

	@Override
	public int getCntOssSpPrdtInfList(OSS_PRDTINFSVO searchVO) {
		return spDAO.getCntOssSpPrdtInfList(searchVO);
	}

	

}
