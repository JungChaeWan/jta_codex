package web.etc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import oss.etc.service.impl.OssEtcDAO;
import web.etc.service.WebEtcService;
import web.etc.vo.SCCSVO;
import web.etc.vo.SCCVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("webEtcService")
public class WebEtcServiceImpl extends EgovAbstractServiceImpl implements WebEtcService {

	@Resource(name = "ossEtcDAO")
	private OssEtcDAO ossEtcDAO;
	
	/**
	 * 홍보영상 리스트
	 * 파일명 : selectSccList
	 * 작성일 : 2017. 3. 3. 오후 2:58:41
	 * 작성자 : 최영철
	 * @param sccSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectSccList(SCCSVO sccSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<SCCVO> resultList = ossEtcDAO.selectWebSccList(sccSVO);
		Integer totalCnt = ossEtcDAO.selectWebSccListCnt(sccSVO);
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
}
