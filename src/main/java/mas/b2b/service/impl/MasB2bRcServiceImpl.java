package mas.b2b.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.b2b.service.MasB2bRcService;
import mas.b2b.vo.B2B_RC_DISPERGRPSVO;
import mas.b2b.vo.B2B_RC_DISPERGRPVO;
import mas.b2b.vo.B2B_RC_DISPERVO;
import mas.b2b.vo.B2B_RC_PRDTSVO;
import mas.b2b.vo.B2B_RC_PRDTVO;

import org.springframework.stereotype.Service;

@Service("masB2bRcService")
public class MasB2bRcServiceImpl implements MasB2bRcService{

	@Resource(name = "b2bRcDAO")
	private B2bRcDAO b2bRcDAO;
	
	/**
	 * 전체 그룹 리스트 조회
	 * 파일명 : selectDisPerGrpList
	 * 작성일 : 2016. 9. 27. 오후 1:39:30
	 * 작성자 : 최영철
	 * @param amtGrpSVO 
	 * @return
	 */
	@Override
	public List<B2B_RC_DISPERGRPVO> selectDisPerGrpList(B2B_RC_DISPERGRPSVO disPerGrpSVO){
		return b2bRcDAO.selectDisPerGrpList(disPerGrpSVO);
	}
	
	/**
	 * 그룹 등록
	 * 파일명 : insertDisPerGrp
	 * 작성일 : 2016. 9. 28. 오후 3:55:01
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 */
	@Override
	public void insertDisPerGrp(B2B_RC_DISPERGRPVO disPerGrpVO){
		b2bRcDAO.insertDisPerGrp(disPerGrpVO);
	}
	
	/**
	 * 그룹별 업체 리스트
	 * 파일명 : selectB2bCorpGrpList
	 * 작성일 : 2016. 9. 27. 오후 3:41:55
	 * 작성자 : 최영철
	 * @param amtGrpSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectB2bCorpGrpList(B2B_RC_DISPERGRPSVO disPerGrpSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<B2B_RC_DISPERGRPVO> resultList = b2bRcDAO.selectB2bCorpGrpList(disPerGrpSVO);
		Integer totalCnt = b2bRcDAO.selectB2bCorpGrpListCnt(disPerGrpSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	/**
	 * 그룹 수정
	 * 파일명 : updateDisPerGrp
	 * 작성일 : 2016. 9. 28. 오후 4:25:55
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 */
	@Override
	public void updateDisPerGrp(B2B_RC_DISPERGRPVO disPerGrpVO){
		b2bRcDAO.updateDisPerGrp(disPerGrpVO);
	}
	
	/**
	 * 업체 그룹 등록
	 * 파일명 : mergeCorpGrp
	 * 작성일 : 2016. 9. 28. 오후 4:28:32
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 */
	@Override
	public void mergeCorpGrp(B2B_RC_DISPERGRPVO disPerGrpVO){
		b2bRcDAO.mergeCorpGrp(disPerGrpVO);
	}
	
	/**
	 * 업체 그룹 삭제
	 * 파일명 : deleteCorpGrp
	 * 작성일 : 2016. 9. 28. 오전 11:31:08
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 */
	@Override
	public void deleteCorpGrp(B2B_RC_DISPERGRPVO disPerGrpVO){
		b2bRcDAO.deleteCorpGrp(disPerGrpVO);
	}
	
	/**
	 * 렌터카 업체 할인율 그룹 리스트 조회
	 * 파일명 : selectCorpDisPerList
	 * 작성일 : 2016. 9. 28. 오후 1:54:26
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 * @return
	 */
	@Override
	public List<B2B_RC_DISPERGRPVO> selectCorpDisPerList(B2B_RC_DISPERGRPVO disPerGrpVO){
		return b2bRcDAO.selectCorpDisPerList(disPerGrpVO);
	}
	
	/**
	 * 렌터카 업체 할인율 그룹 삭제
	 * 파일명 : deleteDisPerGrp
	 * 작성일 : 2016. 9. 28. 오후 1:59:37
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 */
	@Override
	public void deleteDisPerGrp(B2B_RC_DISPERGRPVO disPerGrpVO){
		b2bRcDAO.deleteDisPerGrp(disPerGrpVO);
	}
	
	/**
	 * 할인율 리스트 조회
	 * 파일명 : selectDisPerList
	 * 작성일 : 2016. 9. 30. 오후 1:34:40
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectDisPerList(B2B_RC_DISPERVO disPerInfVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 기본 할인율 조회
		B2B_RC_DISPERVO defDisPerVO = b2bRcDAO.selectByDefDisPer(disPerInfVO);
		// 기간 할인율 조회
		List<B2B_RC_DISPERVO> disPerInfList = b2bRcDAO.selectDisPerList(disPerInfVO);
		
		resultMap.put("defDisPerVO", defDisPerVO);
		resultMap.put("disPerInfList", disPerInfList);
		return resultMap;
	}
	
	/**
	 * 할인율 그룹 단건 조회
	 * 파일명 : selectByDisPerGrp
	 * 작성일 : 2016. 9. 30. 오후 1:46:41
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 * @return
	 */
	@Override
	public B2B_RC_DISPERGRPVO selectByDisPerGrp(B2B_RC_DISPERGRPVO disPerGrpVO){
		return b2bRcDAO.selectByDisPerGrp(disPerGrpVO);
	}
	
	/**
	 * 기본 할인율 등록
	 * 파일명 : insertDefDisPer
	 * 작성일 : 2016. 9. 30. 오후 2:39:48
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override
	public void insertDefDisPer(B2B_RC_DISPERVO disPerInfVO){
		disPerInfVO.setDisPerNum("1");
		disPerInfVO.setAplStartDt("00000101");
		disPerInfVO.setAplEndDt("99991231");
		b2bRcDAO.insertDefDisPer(disPerInfVO);
	}
	
	/**
	 * 기본 할인율 수정
	 * 파일명 : updateDefDisPer
	 * 작성일 : 2016. 9. 30. 오후 4:10:31
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override 
	public void updateDefDisPer(B2B_RC_DISPERVO disPerInfVO){
		disPerInfVO.setDisPerNum("1");
		disPerInfVO.setAplStartDt("00000101");
		disPerInfVO.setAplEndDt("99991231");
		b2bRcDAO.updateDisPer(disPerInfVO);
	}
	
	/**
	 * 할인율 범위 중복 체크
	 * 파일명 : checkRangeAplDt
	 * 작성일 : 2016. 10. 4. 오전 9:54:31
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	@Override
	public Integer checkRangeAplDt(B2B_RC_DISPERVO disPerInfVO){
		return b2bRcDAO.checkRangeAplDt(disPerInfVO);
	}
	
	/**
	 * 기간 할인율 등록
	 * 파일명 : insertRangeDisPer
	 * 작성일 : 2016. 10. 4. 오전 10:01:38
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override
	public void insertRangeDisPer(B2B_RC_DISPERVO disPerInfVO){
		b2bRcDAO.insertRangeDisPer(disPerInfVO);
	}
	
	/**
	 * 기간 할인율 수정
	 * 파일명 : updateRangeDisPer
	 * 작성일 : 2016. 10. 4. 오전 10:15:02
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override
	public void updateRangeDisPer(B2B_RC_DISPERVO disPerInfVO){
		b2bRcDAO.updateRangeDisPer(disPerInfVO);
	}
	
	/**
	 * 기간 할인율 삭제
	 * 파일명 : deleteRangeDisPer
	 * 작성일 : 2016. 10. 4. 오전 10:18:41
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override
	public void deleteRangeDisPer(B2B_RC_DISPERVO disPerInfVO){
		b2bRcDAO.deleteRangeDisPer(disPerInfVO);
	}
	
	/**
	 * 기간 할인율 단건 조회
	 * 파일명 : selectByDisPerInf
	 * 작성일 : 2016. 10. 4. 오전 10:24:28
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	@Override
	public B2B_RC_DISPERVO selectByDisPerInf(B2B_RC_DISPERVO disPerInfVO){
		return b2bRcDAO.selectByDisPerInf(disPerInfVO);
	}
	
	/**
	 * 렌터카 실시간 상품 조회
	 * 파일명 : selectAdPrdtList
	 * 작성일 : 2016. 10. 7. 오후 1:55:28
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@Override
	public List<B2B_RC_PRDTVO> selectAdPrdtList(B2B_RC_PRDTSVO prdtSVO){
		return b2bRcDAO.selectAdPrdtList(prdtSVO);
	}
}
