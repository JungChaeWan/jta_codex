package mas.b2b.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.b2b.service.MasB2bAdService;
import mas.b2b.vo.B2B_AD_AMTGRPSVO;
import mas.b2b.vo.B2B_AD_AMTGRPVO;
import mas.b2b.vo.B2B_AD_AMTSVO;
import mas.b2b.vo.B2B_AD_AMTVO;
import mas.b2b.vo.B2B_AD_PRDTSVO;
import mas.b2b.vo.B2B_AD_PRDTVO;

import org.springframework.stereotype.Service;

@Service("masB2bAdService")
public class MasB2bAdServiceImpl implements MasB2bAdService{

	@Resource(name = "b2bAdDAO")
	private B2bAdDAO b2bAdDAO;
	
	/**
	 * 전체 그룹 리스트 조회
	 * 파일명 : selectAmtGrpList
	 * 작성일 : 2016. 9. 27. 오후 1:39:30
	 * 작성자 : 최영철
	 * @param amtGrpSVO 
	 * @return
	 */
	@Override
	public List<B2B_AD_AMTGRPVO> selectAmtGrpList(B2B_AD_AMTGRPSVO amtGrpSVO){
		return b2bAdDAO.selectAmtGrpList(amtGrpSVO);
	}
	
	/**
	 * 그룹 등록
	 * 파일명 : insertAmtGrp
	 * 작성일 : 2016. 9. 27. 오후 3:24:44
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	@Override
	public void insertAmtGrp(B2B_AD_AMTGRPVO amtGrpVO){
		b2bAdDAO.insertAmtGrp(amtGrpVO);
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
	public Map<String, Object> selectB2bCorpGrpList(B2B_AD_AMTGRPSVO amtGrpSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<B2B_AD_AMTGRPVO> resultList = b2bAdDAO.selectB2bCorpGrpList(amtGrpSVO);
		Integer totalCnt = b2bAdDAO.selectB2bCorpGrpListCnt(amtGrpSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	/**
	 * 그룹 수정
	 * 파일명 : updateAmtGrp
	 * 작성일 : 2016. 9. 27. 오후 4:47:22
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	@Override
	public void updateAmtGrp(B2B_AD_AMTGRPVO amtGrpVO){
		b2bAdDAO.updateAmtGrp(amtGrpVO);
	}
	
	/**
	 * 업체 그룹 등록
	 * 파일명 : mergeCorpGrp
	 * 작성일 : 2016. 9. 28. 오전 11:18:58
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	@Override
	public void mergeCorpGrp(B2B_AD_AMTGRPVO amtGrpVO){
		b2bAdDAO.mergeCorpGrp(amtGrpVO);
	}
	
	/**
	 * 업체 그룹 삭제
	 * 파일명 : deleteCorpGrp
	 * 작성일 : 2016. 9. 28. 오전 11:31:08
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	@Override
	public void deleteCorpGrp(B2B_AD_AMTGRPVO amtGrpVO){
		b2bAdDAO.deleteCorpGrp(amtGrpVO);
	}
	
	/**
	 * 숙박 업체요금 그룹 리스트 조회
	 * 파일명 : selectCorpAmtList
	 * 작성일 : 2016. 9. 28. 오후 1:54:26
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 * @return
	 */
	@Override
	public List<B2B_AD_AMTGRPVO> selectCorpAmtList(B2B_AD_AMTGRPVO amtGrpVO){
		return b2bAdDAO.selectCorpAmtList(amtGrpVO);
	}
	
	/**
	 * 숙박 업체요금 그룹 삭제
	 * 파일명 : deleteAmtGrp
	 * 작성일 : 2016. 9. 28. 오후 1:59:37
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	@Override
	public void deleteAmtGrp(B2B_AD_AMTGRPVO amtGrpVO){
		b2bAdDAO.deleteAmtGrp(amtGrpVO);
	}
	
	/**
	 * 숙박 B2B 요금 조회
	 * 파일명 : selectAmtList
	 * 작성일 : 2016. 9. 29. 오전 9:54:46
	 * 작성자 : 최영철
	 * @param amtSVO
	 * @return
	 */
	@Override
	public List<B2B_AD_AMTVO> selectAmtList(B2B_AD_AMTSVO amtSVO){
		return b2bAdDAO.selectAmtList(amtSVO);
	}
	
	/**
	 * 요금 그룹 단건 조회
	 * 파일명 : selectByAmtGrp
	 * 작성일 : 2016. 9. 29. 오전 10:26:28
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 * @return
	 */
	@Override
	public B2B_AD_AMTGRPVO selectByAmtGrp(B2B_AD_AMTGRPVO amtGrpVO){
		return b2bAdDAO.selectByAmtGrp(amtGrpVO);
	}
	
	/**
	 * 간편입력기를 이용한 요금 적용
	 * 파일명 : mergeAmtCalSmp
	 * 작성일 : 2016. 9. 29. 오전 11:09:00
	 * 작성자 : 최영철
	 * @param amtVO
	 */
	@Override
	public void mergeAmtCalSmp(B2B_AD_AMTVO amtVO){
		b2bAdDAO.updateAmtCalSmp(amtVO);
		b2bAdDAO.insertAmtCalSmp(amtVO);
		
	}
	
	/**
	 * 월 단위 요금 적용
	 * 파일명 : mergeAmtInf
	 * 작성일 : 2016. 9. 29. 오후 2:42:07
	 * 작성자 : 최영철
	 * @param amtList
	 */
	@Override
	public void mergeAmtInf(List<B2B_AD_AMTVO> amtList){
		for(B2B_AD_AMTVO amtVO:amtList){
			b2bAdDAO.mergeAmtInf(amtVO);
		}
	}
	
	/**
	 * 숙박 실시간 상품 조회
	 * 파일명 : selectAdPrdtList
	 * 작성일 : 2016. 10. 5. 오후 2:32:49
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectAdPrdtList(B2B_AD_PRDTSVO searchVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<B2B_AD_PRDTVO> resultList = b2bAdDAO.selectAdPrdtList(searchVO);
		Integer totalCnt = b2bAdDAO.selectAdPrdtListCnt(searchVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
}
