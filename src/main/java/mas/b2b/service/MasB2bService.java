package mas.b2b.service;

import mas.b2b.vo.B2B_CORPCONFSVO;
import mas.b2b.vo.B2B_CORPCONFVO;
import mas.b2b.vo.B2B_CTRTVO;
import oss.corp.vo.CORPVO;

public interface MasB2bService {

	/**
	 * 승인요청
	 * 파일명 : insertB2bReq
	 * 작성일 : 2016. 9. 6. 오전 11:41:28
	 * 작성자 : 최영철
	 * @param corpConfVO
	 */
	void insertB2bReq(B2B_CORPCONFVO corpConfVO);

	/**
	 * 업체 B2B 승인정보 조회
	 * 파일명 : selectByB2bInfo
	 * 작성일 : 2016. 9. 6. 오후 2:43:23
	 * 작성자 : 최영철
	 * @param corpConfSVO
	 * @return
	 */
	B2B_CORPCONFVO selectByB2bInfo(B2B_CORPCONFSVO corpConfSVO);

	/**
	 * B2B 사용 반려 처리
	 * 파일명 : rstrB2bReq
	 * 작성일 : 2016. 9. 7. 오전 10:17:54
	 * 작성자 : 최영철
	 * @param corpConfVO
	 */
	void rstrB2bReq(B2B_CORPCONFVO corpConfVO);

	/**
	 * 재승인 요청
	 * 파일명 : updateB2bReReq
	 * 작성일 : 2016. 9. 9. 오전 10:34:19
	 * 작성자 : 최영철
	 * @param corpConfVO
	 */
	void updateB2bReReq(B2B_CORPCONFVO corpConfVO);

	/**
	 * 업체 승인 처리
	 * 파일명 : confB2bReq
	 * 작성일 : 2016. 9. 9. 오후 1:27:16
	 * 작성자 : 최영철
	 * @param corpConfVO
	 */
	void confB2bReq(B2B_CORPCONFVO corpConfVO);

	/**
	 * B2B 사용여부 승인 처리
	 * 파일명 : updateB2bUseCorp
	 * 작성일 : 2016. 9. 20. 오후 3:37:10
	 * 작성자 : 최영철
	 * @param corpInfo
	 */
	void updateB2bUseCorp(CORPVO corpInfo);

}
