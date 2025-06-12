package oss.marketing.serive.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import oss.marketing.vo.ADMRCMDVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("OssAdmRcmdDAO")
public class OssAdmRcmdDAO extends EgovAbstractDAO {
	/**
	 * MD's Pick 리스트
	 * Function : selectAdmRcmdList
	 * 작성일 : 2016. 10. 21. 오후 3:14:31
	 * 작성자 : 정동수
	 * @param admRcmdVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADMRCMDVO> selectAdmRcmdList(ADMRCMDVO admRcmdVO) {
		return (List<ADMRCMDVO>) list("RCMD_S_00", admRcmdVO);
	}
	
	/**
	 * MD's Pick 전체 건수
	 * Function : selectAdmRcmdTotalCnt
	 * 작성일 : 2016. 10. 21. 오후 3:29:40
	 * 작성자 : 정동수
	 * @return
	 */
	public int selectAdmRcmdTotalCnt(ADMRCMDVO admRcmdVO) {
		return (Integer) select("RCMD_S_01", admRcmdVO);
	}
	
	/**
	 * MD's Pick 추천 번호 산출
	 * Function : getAdmRcmdPk
	 * 작성일 : 2016. 10. 24. 오전 9:48:45
	 * 작성자 : 정동수
	 * @return
	 */
	public String getAdmRcmdPk() {
		return (String) select("RCMD_S_02");
	}
	
	/**
	 * MD's Pick 단일 정보
	 * Function : selectAdmRcmdInfo
	 * 작성일 : 2016. 10. 24. 오후 1:42:42
	 * 작성자 : 정동수
	 * @param admRcmdVO
	 * @return
	 */
	public ADMRCMDVO selectAdmRcmdInfo(ADMRCMDVO admRcmdVO) {
		return (ADMRCMDVO) select("RCMD_S_03", admRcmdVO);
	}
	
	/**
	 * MD's Pick Web 리스트
	 * Function : selectAdmRcmdWebList
	 * 작성일 : 2016. 10. 25. 오후 11:33:31
	 * 작성자 : 정동수
	 * @param admRcmdVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADMRCMDVO> selectAdmRcmdWebList(ADMRCMDVO admRcmdVO) {
		return (List<ADMRCMDVO>) list("RCMD_S_04", admRcmdVO);
	}
	
	/**
	 * MD's Pick Web 상세 업체 정보
	 * Function : selectAdmRcmdWebInfo
	 * 작성일 : 2016. 10. 26. 오전 10:30:07
	 * 작성자 : 정동수
	 * @param admRcmdVO
	 * @return
	 */
	public ADMRCMDVO selectAdmRcmdWebInfo(ADMRCMDVO admRcmdVO) {
		return (ADMRCMDVO) select("RCMD_S_05", admRcmdVO);
	}
	
	/**
	 * MD's Pick Web 상세 상품 리스트
	 * Function : selectAdmRcmdWebPrdt
	 * 작성일 : 2016. 10. 26. 오전 10:32:17
	 * 작성자 : 정동수
	 * @param admRcmdvo
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADMRCMDVO> selectAdmRcmdWebPrdtList(ADMRCMDVO admRcmdVO) {
		return (List<ADMRCMDVO>) list("RCMD_S_06", admRcmdVO);
	}
	
	/**
	 * MD's Pick Web 슬라이딩 리스트
	 * Function : selectAdmRcmdWebSlideList
	 * 작성일 : 2016. 10. 26. 오전 11:47:15
	 * 작성자 : 정동수
	 * @param admRcmdVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADMRCMDVO> selectAdmRcmdWebSlideList(ADMRCMDVO admRcmdVO) {
		return (List<ADMRCMDVO>) list("RCMD_S_07", admRcmdVO);
	}
	
	/**
	 * MD's Pick Web 랜덤 리스트 (4개)
	 * Function : selectAdmRcmdWebRandomList
	 * 작성일 : 2017. 11. 01. 오후 12:06:28
	 * 작성자 : 정동수
	 * @param admRcmdVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADMRCMDVO> selectAdmRcmdWebRandomList(ADMRCMDVO admRcmdVO) {
		return (List<ADMRCMDVO>) list("RCMD_S_09", admRcmdVO);
	}
	
	/**
	 * MD's Pick 리스트
	 * Function : selectAdmRcmdList
	 * 작성일 : 2016. 10. 21. 오후 3:14:31
	 * 작성자 : 정동수
	 * @param admRcmdVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ADMRCMDVO> selectAdmRcmdListFind(ADMRCMDVO admRcmdVO) {
		return (List<ADMRCMDVO>) list("RCMD_S_10", admRcmdVO);
	}
	
	/**
	 * MD's Pick 전체 건수
	 * Function : selectAdmRcmdTotalCnt
	 * 작성일 : 2016. 10. 21. 오후 3:29:40
	 * 작성자 : 정동수
	 * @return
	 */
	public int selectAdmRcmdTotalCntFind(ADMRCMDVO admRcmdVO) {
		return (Integer) select("RCMD_S_11", admRcmdVO);
	}
	
	/**
	 * MD's Pick 등록
	 * Function : insertAdmRcmd
	 * 작성일 : 2016. 10. 24. 오전 10:36:23
	 * 작성자 : 정동수
	 * @param admRcmdVO
	 */
	public void insertAdmRcmd(ADMRCMDVO admRcmdVO) {
		insert("RCMD_I_00", admRcmdVO);
	}
	
	/**
	 * MD's Pick 수정
	 * Function : updateAdmRcmd
	 * 작성일 : 2016. 10. 24. 오후 3:02:53
	 * 작성자 : 정동수
	 * @param admRcmdVO
	 */
	public void updateAdmRcmd(ADMRCMDVO admRcmdVO) {
		update("RCMD_U_00", admRcmdVO);
	}
	
	/**
	 * MD's Pick 삭제
	 * Function : delteAdmRcmd
	 * 작성일 : 2016. 10. 24. 오후 3:29:38
	 * 작성자 : 정동수
	 * @param admRcmdVO
	 */
	public void delteAdmRcmd(ADMRCMDVO admRcmdVO) {
		delete("RCMD_D_00", admRcmdVO);
	}

	/**
	 * MD's Pick 사용자 목록 카운트
	 * 파일명 : selectAdmRcmdWebCnt
	 * 작성일 : 2017. 2. 13. 오후 3:31:20
	 * 작성자 : 최영철
	 * @param admRcmdVO
	 * @return
	 */
	public Object selectAdmRcmdWebCnt(ADMRCMDVO admRcmdVO) {
		return select("RCMD_S_08", admRcmdVO);
	}
}
