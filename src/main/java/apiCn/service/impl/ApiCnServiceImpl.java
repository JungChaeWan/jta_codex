package apiCn.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import apiCn.service.ApiCnService;
import apiCn.vo.APICNSVO;
import apiCn.vo.APICNVO;
import apiCn.vo.APIDTLVO;
import apiCn.vo.ILSDTLVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("apiCnService")
public class ApiCnServiceImpl extends EgovAbstractServiceImpl implements ApiCnService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(ApiCnServiceImpl.class);
	
	@Resource(name = "apiCnDAO")
	private ApiCnDAO apiCnDAO;

	/**
	 * 연계 업체 조회
	 * 파일명 : selectApiCnCorpList
	 * 작성일 : 2016. 7. 6. 오후 5:18:11
	 * 작성자 : 최영철
	 * @param apicnSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectApiCnCorpList(APICNSVO apicnSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<APICNVO> resultList = apiCnDAO.selectApiCnCorpList(apicnSVO);
		Integer totalCnt = apiCnDAO.getCntCorpList(apicnSVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
	
	/**
	 * 연계 업체 등록
	 * 파일명 : insertApiCorp
	 * 작성일 : 2016. 7. 11. 오후 5:19:56
	 * 작성자 : 최영철
	 * @param apicnVO
	 */
	@Override
	public void insertApiCorp(APICNVO apicnVO){
		// API 업체 등록
		String apiId = apiCnDAO.insertApiCorp(apicnVO);
		
		// 기본 API 등록
		APIDTLVO apiDtlVO = new APIDTLVO();
		// API ID
		apiDtlVO.setApiId(apiId);
		// 연계 구분 (I100 : Inbound1 예약 처리)
		apiDtlVO.setLinkDiv("I100");
		// 상태 코드(정의 없음)
		apiDtlVO.setStatusCd("0000");
		// 서비스 URL
		apiDtlVO.setSvcUrl("/api/rc/reservation.ajax");
		// 서비스 설명
		apiDtlVO.setSvcExp("예약 처리");
		// 등록자
		apiDtlVO.setFrstRegId(apicnVO.getFrstRegId());
		
		// API 상세 등록
		apiCnDAO.insertApiDtl(apiDtlVO);
		
		// 연계 구분 (I200 : Inbound2 예약 취소)
		apiDtlVO.setLinkDiv("I200");
		// 서비스 URL
		apiDtlVO.setSvcUrl("/api/rc/cancelRsv.ajax");
		// 서비스 설명
		apiDtlVO.setSvcExp("예약 취소");
		
		// API 상세 등록
		apiCnDAO.insertApiDtl(apiDtlVO);
	}
	
	/**
	 * 연계 업체 단건 조회
	 * 파일명 : selectByApiCorp
	 * 작성일 : 2016. 7. 12. 오전 10:52:40
	 * 작성자 : 최영철
	 * @param apicnVO
	 * @return
	 */
	@Override
	public APICNVO selectByApiCorp(APICNVO apicnVO){
		return apiCnDAO.selectByApiCorp(apicnVO);
	}
	
	/**
	 * 연계 업체 수정
	 * 파일명 : updateApiCorp
	 * 작성일 : 2016. 7. 12. 오후 1:59:01
	 * 작성자 : 최영철
	 * @param apicnVO
	 */
	@Override
	public void updateApiCorp(APICNVO apicnVO){
		apiCnDAO.updateApiCorp(apicnVO);
	}
	
	/**
	 * 연계 업체 카운트
	 * 파일명 : getCntCorpList
	 * 작성일 : 2016. 7. 12. 오후 5:56:43
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	@Override
	public Integer getCntCorpList(APICNSVO searchVO){
		return apiCnDAO.getCntCorpList(searchVO);
	}
	
	/**
	 * API 상세 리스트 조회
	 * 파일명 : selectApiDtlList
	 * 작성일 : 2016. 7. 13. 오후 1:57:50
	 * 작성자 : 최영철
	 * @param apicnVO
	 * @return
	 */
	@Override
	public List<APIDTLVO> selectApiDtlList(APICNVO apicnVO){
		return apiCnDAO.selectApiDtlList(apicnVO);
	}
	
	/**
	 * API 등록
	 * 파일명 : insertApi
	 * 작성일 : 2016. 7. 18. 오후 4:24:07
	 * 작성자 : 최영철
	 * @param apiDtlVO
	 */
	@Override
	public void insertApiDtl(APIDTLVO apiDtlVO){
		// 상태 코드(정의 없음)
		apiDtlVO.setStatusCd("0000");
		apiCnDAO.insertApiDtl(apiDtlVO);
	}
	
	/**
	 * API 단건 조회
	 * 파일명 : selectByApiDtl
	 * 작성일 : 2016. 7. 18. 오후 5:24:17
	 * 작성자 : 최영철
	 * @param apiDtlVO
	 * @return
	 */
	@Override
	public APIDTLVO selectByApiDtl(APIDTLVO apiDtlVO){
		return apiCnDAO.selectByApiDtl(apiDtlVO);
	}
	
	/**
	 * API 수정
	 * 파일명 : updateApiDtl
	 * 작성일 : 2016. 7. 19. 오전 9:09:36
	 * 작성자 : 최영철
	 * @param apiDtlVO
	 */
	@Override
	public void updateApiDtl(APIDTLVO apiDtlVO){
		// 상태 코드(정의 없음)
		apiDtlVO.setStatusCd("0000");
		apiCnDAO.updateApiDtl(apiDtlVO);
	}
	
	/**
	 * ILS 연계용
	 * 파일명 : selectIlsList
	 * 작성일 : 2016. 11. 10. 오후 4:32:40
	 * 작성자 : 최영철
	 * @param apiVO
	 * @return
	 */
	@Override
	public List<ILSDTLVO> selectIlsList(APICNVO apiVO){
		return apiCnDAO.selectIlsList(apiVO);
	}
}
