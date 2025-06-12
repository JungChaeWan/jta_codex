package oss.sv.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.sv.service.impl.SvDAO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import oss.sv.service.OssSvService;
import oss.sv.vo.OSS_SV_PRDTINFSVO;
import oss.sv.vo.OSS_SV_PRDTINFVO;

@Service("ossSvService")
public class OssSvServiceImpl implements OssSvService {

	@SuppressWarnings("unused")
	private static final Logger log = LoggerFactory.getLogger(OssSvServiceImpl.class);

	/** SvDAO */
	@Resource(name = "svDAO")
	private SvDAO svDAO;
	
	@Override
	public Map<String, Object> selectOssSvPrdtInfList(OSS_SV_PRDTINFSVO oss_SV_PRDTINFSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<OSS_SV_PRDTINFSVO> resultList = svDAO.selectOssSvPrdtInfList(oss_SV_PRDTINFSVO);
		Integer totalCnt = svDAO.getCntOssSvPrdtInfList(oss_SV_PRDTINFSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	/**
	 * 통합운영 기념품 상품 엑셀 다운로드 용
	 * 파일명 : selectOssSvPrdtInfList2
	 * 작성일 : 2017. 1. 10. 오후 3:37:20
	 * 작성자 : 최영철
	 * @param oss_SV_PRDTINFSVO
	 * @return
	 */
	@Override
	public List<OSS_SV_PRDTINFVO> selectOssSvPrdtInfList2(OSS_SV_PRDTINFSVO oss_SV_PRDTINFSVO){
		return svDAO.selectOssSvPrdtInfList2(oss_SV_PRDTINFSVO);
	}

	/**
	 * 상품 리스트 갯수
	 * @param searchVO
	 * @return
	 */
	@Override
	public int getCntOssSvPrdtInfList(OSS_SV_PRDTINFSVO oss_SV_PRDTINFSVO) {
		return svDAO.getCntOssSvPrdtInfList(oss_SV_PRDTINFSVO);
	}

}
