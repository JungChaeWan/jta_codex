package mas.b2b.service;

import java.util.Map;

import mas.b2b.vo.B2B_CTRTSVO;
import mas.b2b.vo.B2B_CTRTVO;


public interface MasB2bCtrtService {

	/**
	 * 계약 요청 업체 리스트
	 * 파일명 : selectB2bCorpList
	 * 작성일 : 2016. 9. 19. 오후 5:34:28
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	Map<String, Object> selectB2bCorpList(B2B_CTRTSVO ctrtSVO);

	/**
	 * 계약 요청
	 * 파일명 : ctrtB2bReq
	 * 작성일 : 2016. 9. 20. 오후 8:51:11
	 * 작성자 : 최영철
	 * @param ctrtVO
	 */
	void ctrtB2bReq(B2B_CTRTVO ctrtVO);

	/**
	 * 보낸 업체 정보 리스트
	 * 파일명 : selectB2bSendCorpList
	 * 작성일 : 2016. 9. 21. 오전 10:07:26
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	Map<String, Object> selectB2bSendCorpList(B2B_CTRTSVO ctrtSVO);

	/**
	 * 계약 정보 단건 조회
	 * 파일명 : selectCtrtInfo
	 * 작성일 : 2016. 9. 21. 오전 11:10:05
	 * 작성자 : 최영철
	 * @param ctrtVO
	 * @return
	 */
	B2B_CTRTVO selectCtrtInfo(B2B_CTRTVO ctrtVO);

	/**
	 * 계약 요청 취소
	 * 파일명 : cancelCtrtB2bReq
	 * 작성일 : 2016. 9. 21. 오후 2:05:14
	 * 작성자 : 최영철
	 * @param ctrtVO
	 */
	void cancelCtrtB2bReq(B2B_CTRTVO ctrtVO);

	/**
	 * 받은 업체 정보 리스트
	 * 파일명 : selectB2bTgtCorpList
	 * 작성일 : 2016. 9. 21. 오후 3:29:30
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	Map<String, Object> selectB2bTgtCorpList(B2B_CTRTSVO ctrtSVO);

	/**
	 * 계약 승인 처리
	 * 파일명 : ctrtConf
	 * 작성일 : 2016. 9. 21. 오후 5:43:39
	 * 작성자 : 최영철
	 * @param ctrtVO
	 */
	void ctrtConf(B2B_CTRTVO ctrtVO);

	/**
	 * 계약 반려 처리
	 * 파일명 : ctrtRstr
	 * 작성일 : 2016. 9. 21. 오후 7:16:31
	 * 작성자 : 최영철
	 * @param ctrtVO
	 */
	void ctrtRstr(B2B_CTRTVO ctrtVO);

	/**
	 * 계약 중인 업체 리스트
	 * 파일명 : selectCtrtCorpList
	 * 작성일 : 2016. 9. 22. 오전 10:54:39
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	Map<String, Object> selectCtrtCorpList(B2B_CTRTSVO ctrtSVO);

	/**
	 * 계약 취소 요청
	 * 파일명 : ctrtCancelReq
	 * 작성일 : 2016. 9. 23. 오전 11:32:37
	 * 작성자 : 최영철
	 * @param ctrtVO2
	 */
	void ctrtCancelReq(B2B_CTRTVO ctrtVO2);


}
