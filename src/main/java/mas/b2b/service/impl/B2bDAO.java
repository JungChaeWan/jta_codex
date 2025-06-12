package mas.b2b.service.impl;

import java.util.List;

import mas.b2b.vo.B2B_CORPCONFSVO;
import mas.b2b.vo.B2B_CORPCONFVO;
import mas.b2b.vo.B2B_CTRTSVO;
import mas.b2b.vo.B2B_CTRTVO;

import org.springframework.stereotype.Repository;

import oss.corp.vo.CORPVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("b2bDAO")
public class B2bDAO extends EgovAbstractDAO {

	/**
	 * 승인요청
	 * 파일명 : insertB2bReq
	 * 작성일 : 2016. 9. 6. 오전 11:43:35
	 * 작성자 : 최영철
	 * @param corpConfVO
	 */
	public void insertB2bReq(B2B_CORPCONFVO corpConfVO) {
		insert("B2B_CORPCONF_I_00", corpConfVO);
	}

	
	/**
	 * 업체 B2B 승인정보 조회
	 * 파일명 : selectByB2bInfo
	 * 작성일 : 2016. 9. 6. 오후 2:44:15
	 * 작성자 : 최영철
	 * @param corpConfSVO
	 * @return
	 */
	public B2B_CORPCONFVO selectByB2bInfo(B2B_CORPCONFSVO corpConfSVO) {
		return (B2B_CORPCONFVO) select("B2B_CORPCONF_S_01", corpConfSVO);
	}


	/**
	 * B2B 업체 승인 리스트
	 * 파일명 : selectCorpConfList
	 * 작성일 : 2016. 9. 6. 오후 4:49:44
	 * 작성자 : 최영철
	 * @param corpConfSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_CORPCONFVO> selectCorpConfList(B2B_CORPCONFSVO corpConfSVO) {
		return (List<B2B_CORPCONFVO>) list("B2B_CORPCONF_S_02", corpConfSVO);
	}


	/**
	 * B2B 업체 승인 카운트
	 * 파일명 : getCntCorpConfList
	 * 작성일 : 2016. 9. 6. 오후 4:50:26
	 * 작성자 : 최영철
	 * @param corpConfSVO
	 * @return
	 */
	public Integer getCntCorpConfList(B2B_CORPCONFSVO corpConfSVO) {
		return (Integer) select("B2B_CORPCONF_S_03", corpConfSVO);
	}


	/**
	 * B2B 사용 반려
	 * 파일명 : rstrB2bReq
	 * 작성일 : 2016. 9. 7. 오전 10:18:39
	 * 작성자 : 최영철
	 * @param corpConfVO
	 */
	public void rstrB2bReq(B2B_CORPCONFVO corpConfVO) {
		update("B2B_CORPCONF_U_01", corpConfVO);
	}


	/**
	 * 재승인 요청
	 * 파일명 : updateB2bReReq
	 * 작성일 : 2016. 9. 9. 오전 10:34:56
	 * 작성자 : 최영철
	 * @param corpConfVO
	 */
	public void updateB2bReReq(B2B_CORPCONFVO corpConfVO) {
		update("B2B_CORPCONF_U_02", corpConfVO);
	}


	/**
	 * 업체 승인 처리
	 * 파일명 : confB2bReq
	 * 작성일 : 2016. 9. 9. 오후 1:27:57
	 * 작성자 : 최영철
	 * @param corpConfVO
	 */
	public void confB2bReq(B2B_CORPCONFVO corpConfVO) {
		update("B2B_CORPCONF_U_03", corpConfVO);
	}


	/**
	 * 여행사 계약 요청 가능 업체 조회
	 * 파일명 : selectCtrtCorpList
	 * 작성일 : 2016. 9. 20. 오전 11:18:22
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_CTRTVO> selectCtrtCorpList(B2B_CTRTSVO ctrtSVO) {
		return (List<B2B_CTRTVO>) list("B2B_CTRT_S_01", ctrtSVO);
	}


	/**
	 * 여행사 계약 요청 가능 업체 조회 카운트
	 * 파일명 : selectCtrtCorpListCnt
	 * 작성일 : 2016. 9. 20. 오전 11:19:20
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	public Integer selectCtrtCorpListCnt(B2B_CTRTSVO ctrtSVO) {
		return (Integer) select("B2B_CTRT_S_02", ctrtSVO);
	}


	/**
	 * B2B 사용여부 승인 처리
	 * 파일명 : updateB2bUseCorp
	 * 작성일 : 2016. 9. 20. 오후 3:38:06
	 * 작성자 : 최영철
	 * @param corpInfo
	 */
	public void updateB2bUseCorp(CORPVO corpInfo) {
		update("CORP_U_05", corpInfo);
	}


	/**
	 * 계약 요청
	 * 파일명 : ctrtB2bReq
	 * 작성일 : 2016. 9. 20. 오후 8:52:03
	 * 작성자 : 최영철
	 * @param ctrtVO
	 */
	public void ctrtB2bReq(B2B_CTRTVO ctrtVO) {
		insert("B2B_CTRT_I_01", ctrtVO);
	}


	/**
	 * 보낸 업체 정보 리스트
	 * 파일명 : selectB2bSendCorpList
	 * 작성일 : 2016. 9. 21. 오전 10:08:07
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_CTRTVO> selectB2bSendCorpList(B2B_CTRTSVO ctrtSVO) {
		return (List<B2B_CTRTVO>) list("B2B_CTRT_S_03", ctrtSVO);
	}


	/**
	 * 보낸 업체 정보 카운트
	 * 파일명 : selectB2bSendCorpListCnt
	 * 작성일 : 2016. 9. 21. 오전 10:09:58
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	public Integer selectB2bSendCorpListCnt(B2B_CTRTSVO ctrtSVO) {
		return (Integer) select("B2B_CTRT_S_04", ctrtSVO);
	}


	/**
	 * 계약 정보 단건 조회
	 * 파일명 : selectCtrtInfo
	 * 작성일 : 2016. 9. 21. 오전 11:12:17
	 * 작성자 : 최영철
	 * @param ctrtVO
	 * @return
	 */
	public B2B_CTRTVO selectCtrtInfo(B2B_CTRTVO ctrtVO) {
		return (B2B_CTRTVO) select("B2B_CTRT_S_05", ctrtVO);
	}


	/**
	 * 계약 요청 취소
	 * 파일명 : cancelCtrtB2bReq
	 * 작성일 : 2016. 9. 21. 오후 2:06:07
	 * 작성자 : 최영철
	 * @param ctrtVO
	 */
	public void cancelCtrtB2bReq(B2B_CTRTVO ctrtVO) {
		delete("B2B_CTRT_D_00", ctrtVO);
	}


	/**
	 * 받은 업체 정보 리스트
	 * 파일명 : selectB2bTgtCorpList
	 * 작성일 : 2016. 9. 21. 오후 3:30:37
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_CTRTVO> selectB2bTgtCorpList(B2B_CTRTSVO ctrtSVO) {
		return (List<B2B_CTRTVO>) list("B2B_CTRT_S_06", ctrtSVO);
	}


	/**
	 * 받은 업체 정보 카운트
	 * 파일명 : selectB2bTgtCorpListCnt
	 * 작성일 : 2016. 9. 21. 오후 3:31:19
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	public Integer selectB2bTgtCorpListCnt(B2B_CTRTSVO ctrtSVO) {
		return (Integer) select("B2B_CTRT_S_07", ctrtSVO);
	}


	/**
	 * 계약 승인 처리
	 * 파일명 : ctrtConf
	 * 작성일 : 2016. 9. 21. 오후 5:44:32
	 * 작성자 : 최영철
	 * @param ctrtVO
	 */
	public void ctrtConf(B2B_CTRTVO ctrtVO) {
		update("B2B_CTRT_U_01", ctrtVO);
	}


	/**
	 * 계약 반려 처리
	 * 파일명 : ctrtRstr
	 * 작성일 : 2016. 9. 21. 오후 7:17:08
	 * 작성자 : 최영철
	 * @param ctrtVO
	 */
	public void ctrtRstr(B2B_CTRTVO ctrtVO) {
		update("B2B_CTRT_U_02", ctrtVO);
	}


	/**
	 * 계약 중인 업체 리스트
	 * 파일명 : selectCtrtCorpList2
	 * 작성일 : 2016. 9. 22. 오전 10:56:13
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_CTRTVO> selectCtrtCorpList2(B2B_CTRTSVO ctrtSVO) {
		return (List<B2B_CTRTVO>) list("B2B_CTRT_S_08", ctrtSVO);
	}


	/**
	 * 계약 중인 업체 리스트 카운트
	 * 파일명 : selectCtrtCorpListCnt2
	 * 작성일 : 2016. 9. 22. 오전 10:56:46
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	public Integer selectCtrtCorpListCnt2(B2B_CTRTSVO ctrtSVO) {
		return (Integer) select("B2B_CTRT_S_09", ctrtSVO);
	}


	/**
	 * 계약 취소 요청
	 * 파일명 : ctrtCancelReq
	 * 작성일 : 2016. 9. 23. 오전 11:33:54
	 * 작성자 : 최영철
	 * @param ctrtVO2
	 */
	public void ctrtCancelReq(B2B_CTRTVO ctrtVO2) {
		update("B2B_CTRT_U_03", ctrtVO2);
	}


	/**
	 * 업체 계약 리스트 조회
	 * 파일명 : selectOssCtrtCorpList
	 * 작성일 : 2016. 9. 23. 오후 3:09:01
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_CTRTVO> selectOssCtrtCorpList(B2B_CTRTSVO ctrtSVO) {
		return (List<B2B_CTRTVO>) list("B2B_CTRT_S_10", ctrtSVO);
	}


	/**
	 * 업체 계약 리스트 카운트
	 * 파일명 : selectOssCtrtCorpListCnt
	 * 작성일 : 2016. 9. 23. 오후 3:10:31
	 * 작성자 : 최영철
	 * @param ctrtSVO
	 * @return
	 */
	public Integer selectOssCtrtCorpListCnt(B2B_CTRTSVO ctrtSVO) {
		return (Integer) select("B2B_CTRT_S_11", ctrtSVO);
	}

}
