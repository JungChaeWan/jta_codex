package oss.etc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import oss.etc.service.OssEtcService;
import web.etc.vo.SCCSVO;
import web.etc.vo.SCCVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("ossEtcService")
public class OssEtcServiceImpl extends EgovAbstractServiceImpl implements OssEtcService {

	@Resource(name = "ossEtcDAO")
	private OssEtcDAO ossEtcDAO;
	
	/**
	 * 홍보영상 리스트 조회
	 * 파일명 : selectSccList
	 * 작성일 : 2017. 3. 3. 오후 3:46:08
	 * 작성자 : 최영철
	 * @param sccSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectSccList(SCCSVO sccSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<SCCVO> resultList = ossEtcDAO.selectSccList(sccSVO);
		Integer totalCnt = ossEtcDAO.selectSccListCnt(sccSVO);
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	/**
	 * 홍보영상 등록
	 * 파일명 : insertScc
	 * 작성일 : 2017. 3. 6. 오전 11:30:25
	 * 작성자 : 최영철
	 * @param sccVO
	 */
	@Override
	public void insertScc(SCCVO sccVO){
		ossEtcDAO.insertScc(sccVO);
	}
	
	/**
	 * 홍보영상 단건 조회
	 * 파일명 : selectByScc
	 * 작성일 : 2017. 3. 6. 오후 3:55:23
	 * 작성자 : 최영철
	 * @param sccVO
	 * @return
	 */
	@Override
	public SCCVO selectByScc(SCCVO sccVO){
		return ossEtcDAO.selectByScc(sccVO);
	}
	
	/**
	 * 홍보영상 삭제
	 * 파일명 : deleteScc
	 * 작성일 : 2017. 3. 6. 오후 4:39:05
	 * 작성자 : 최영철
	 * @param sccVO
	 */
	@Override
	public void deleteScc(SCCVO sccVO){
		ossEtcDAO.deleteScc(sccVO);
	}
	
	/**
	 * 홍보영상 수정
	 * 파일명 : updateScc
	 * 작성일 : 2017. 3. 6. 오후 5:39:16
	 * 작성자 : 최영철
	 * @param sccVO
	 */
	@Override
	public void updateScc(SCCVO sccVO){
		ossEtcDAO.updateScc(sccVO);
	}
}
