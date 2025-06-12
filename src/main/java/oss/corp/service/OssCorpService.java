package oss.corp.service;

import java.util.List;
import java.util.Map;

import mas.b2b.vo.B2B_CORPCONFSVO;
import mas.b2b.vo.B2B_CTRTSVO;
import mas.corp.vo.DLVCORPVO;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.bis.vo.BISSVO;
import oss.corp.vo.*;


public interface OssCorpService {

	void insertCorp(CORPVO corpVO, MultipartHttpServletRequest multiRequest) throws Exception;

	Map<String, Object> selectCorpList(CORPSVO corpSVO);

	int getCountCorp(CORPSVO corpsvo);
	
	Map<String, Object> selectCorpListSMSMail(CORPSVO corpSVO);

	CORPVO selectByCorp(CORPVO corpSVO);

	CORPVO selectByCorpVisitJeju(CORPVO corpSVO);
	
	CORPVO selectCorpByCorpId(CORPVO corpVO);

	void updateCorp(CORPVO corpVO, MultipartHttpServletRequest multiRequest) throws Exception;

	/**
	 * 렌터카 업체 전체 조회
	 * 파일명 : selectRcCorpList
	 * 작성일 : 2015. 10. 22. 오후 4:37:46
	 * 작성자 : 최영철
	 * @param corpVO
	 * @return
	 */
	List<CORPVO> selectRcCorpList(CORPVO corpVO);
	
	List<CORPVO> selectCorpListSMSMail(CORPVO corpVO);

	CORPVO selectByCorpSpAddInfo(CORPVO corpVO);

	void updateCorpBySpAddInfo(CORPVO corpVO, MultipartHttpServletRequest multiRequest) throws Exception;

	/**
	 * <pre>
	 * 파일명 : updateMasCorp
	 * 작성일 : 2015. 12. 14. 오후 9:54:08
	 * 작성자 : 함경태
	 * @param corpVO
	 */
	void updateMasCorp(CORPVO corpVO, MultipartHttpServletRequest multiRequest) throws Exception;

	/**
	 * 거리순으로 업체 가져오기.
	 * @param corpVO
	 * @return
	 */
	List<CORPVO> selectCorpDistList(CORPVO corpVO);
	
	/**
	 * 사업자등록번호 중복여부
	 */
	boolean isDupCoRegNum(CORPSVO corpSVO);
	
	
	//회사에 사용자 정보 얻기
	List<CORPADMVO> selectCorpAdmList(CORPADMVO corpAdmVO);
	
	
	List<CORPVO> selectCorpListExcel(CORPSVO corpSVO);

	/**
	 * 하이제주 매핑 해제
	 * 파일명 : updateNonMapping
	 * 작성일 : 2016. 9. 5. 오전 11:48:30
	 * 작성자 : 최영철
	 * @param corpVO
	 */
	/*void updateNonMapping(CORPVO corpVO);*/
	
	/**
	 * Visit제주 매핑 해제
	 * Function : updateNonVisitMapping
	 * 작성일 : 2018. 2. 2. 오전 12:05:59
	 * 작성자 : 정동수
	 * @param corpVO
	 */
	void updateNonVisitMapping(CORPVO corpVO);

	/**
	 * B2B 승인 리스트 조회
	 * 파일명 : selectB2bCorpList
	 * 작성일 : 2016. 9. 6. 오후 4:47:36
	 * 작성자 : 최영철
	 * @param corpConfSVO
	 * @return
	 */
	Map<String, Object> selectB2bCorpList(B2B_CORPCONFSVO corpConfSVO);

	/**
	 * B2B 계약 리스트 조회
	 * 파일명 : selectCtrtCorpList
	 * 작성일 : 2016. 9. 23. 오후 3:07:44
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	Map<String, Object> selectCtrtCorpList(B2B_CTRTSVO ctrtSVO);
	
	/**
	 * 배송업체 정보 리스트
	 * @param corpVO
	 * @return
	 */
	List<DLVCORPVO> selectDlvCorpList(CORPVO corpVO);

	/**
	 * 기념품업체의 배송업체 리스트
	 * @param corpVO
	 * @return
	 */
	List<DLVCORPVO> selectDlvCorpListByCorp(CORPVO corpVO);

	/**
	 * 배송업체 매핑
	 * @param dlvCorpVO
	 */
	void updateDlvCorp(DLVCORPVO dlvCorpVO);

	/**
	 * LINK 상품 사용여부 리턴
	 * 파일명 : selectLinkPrdtUseYn
	 * 작성일 : 2016. 11. 24. 오후 4:51:03
	 * 작성자 : 최영철
	 * @return
	 */
	String selectLinkPrdtUseYn();

	/**
	 * 업체 광고 정보 조회
	 * 파일명 : selectCorpAdtmMng
	 * 작성일 : 2017. 2. 24. 오후 4:09:55
	 * 작성자 : 최영철
	 * @param corpVO
	 * @return
	 */
	CORPADTMMNGVO selectCorpAdtmMng(CORPVO corpVO);

	/**
	 * 업체 광고 정보 수정
	 * 파일명 : updateCorpAdtm
	 * 작성일 : 2017. 2. 28. 오전 10:55:59
	 * 작성자 : 최영철
	 * @param corpAdtmMngVO
	 * @param multiRequest
	 * @throws Exception 
	 */
	void updateCorpAdtm(CORPADTMMNGVO corpAdtmMngVO,
			MultipartHttpServletRequest multiRequest) throws Exception;
	
	/**
	 * 업체 지수 리스트 출력
	 * 파일명 : selectCorpLevel
	 * 작성일 : 2017. 9. 28. 오전 10:40:18
	 * 작성자 : 정동수
	 * @param bisSVO 
	 */
	List<CORPLEVELVO> selectCorpLevel(BISSVO bisSVO);	
	
	/**
	 * 업체 지수 정보 출력
	 * 파일명 : selectCorpInfo
	 * 작성일 : 2017. 10. 10. 오전 10:48:45
	 * 작성자 : 정동수
	 * @param corpId 
	 */
	public CORPLEVELVO selectCorpInfo(String corpId);
	
	/**
	 * 업체 지수 정보 수정
	 * 파일명 : updateLevelModInfo
	 * 작성일 : 2017. 10. 10. 오전 11:30:22
	 * 작성자 : 정동수
	 * @param corpLevelVO 
	 */
	public void updateLevelModInfo(CORPLEVELVO corpLevelVO);
		
	/**
	 * 추천 여행사 상품 업체 리스트
	 * Function : selectCorpRcmdList
	 * 작성일 : 2017. 12. 31. 오후 4:15:43
	 * 작성자 : 정동수
	 * @return
	 */
	public List<CORPRCMDVO> selectCorpRcmdList(CORPRCMDVO corpRcmdVO);
	
	/**
	 * 추천 여행사 상품 업체 저장
	 * Function : insertCorpRcmd
	 * 작성일 : 2017. 12. 31. 오후 4:07:28
	 * 작성자 : 정동수
	 * @param corpRcmdVO
	 */
	public void insertCorpRcmd(CORPRCMDVO corpRcmdVO);
	
	/**
	 * 추천 여행사 상품 업체 삭제
	 * Function : deleteCorpRcmd
	 * 작성일 : 2017. 12. 31. 오후 4:07:43
	 * 작성자 : 정동수
	 */
	public void deleteCorpRcmd();

	public void updateTamnacardMng(TAMNACARDSVO tamnacardsvo);
}
