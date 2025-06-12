package mas.b2b.service.impl;

import java.util.List;

import mas.b2b.vo.B2B_RC_DISPERGRPSVO;
import mas.b2b.vo.B2B_RC_DISPERGRPVO;
import mas.b2b.vo.B2B_RC_DISPERVO;
import mas.b2b.vo.B2B_RC_PRDTSVO;
import mas.b2b.vo.B2B_RC_PRDTVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("b2bRcDAO")
public class B2bRcDAO extends EgovAbstractDAO {

	/**
	 * 전체 그룹 리스트 조회
	 * 파일명 : selectAmtGrpList
	 * 작성일 : 2016. 9. 27. 오후 1:41:27
	 * 작성자 : 최영철
	 * @param disPerGrpSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_RC_DISPERGRPVO> selectDisPerGrpList(B2B_RC_DISPERGRPSVO disPerGrpSVO) {
		return (List<B2B_RC_DISPERGRPVO>) list("B2B_RC_DISPERGRP_S_03", disPerGrpSVO);
	}

	/**
	 * 그룹 등록
	 * 파일명 : insertDisPerGrp
	 * 작성일 : 2016. 9. 28. 오후 3:56:33
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 */
	public void insertDisPerGrp(B2B_RC_DISPERGRPVO disPerGrpVO) {
		insert("B2B_RC_DISPERGRP_I_01", disPerGrpVO);
	}

	/**
	 * 그룹별 업체 리스트
	 * 파일명 : selectB2bCorpGrpList
	 * 작성일 : 2016. 9. 27. 오후 3:43:05
	 * 작성자 : 최영철
	 * @param disPerGrpSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_RC_DISPERGRPVO> selectB2bCorpGrpList(B2B_RC_DISPERGRPSVO disPerGrpSVO) {
		return (List<B2B_RC_DISPERGRPVO>) list("B2B_RC_DISPERGRP_S_01", disPerGrpSVO);
	}

	/**
	 * 그룹별 업체 리스트 카운트
	 * 파일명 : selectB2bCorpGrpListCnt
	 * 작성일 : 2016. 9. 27. 오후 3:43:35
	 * 작성자 : 최영철
	 * @param disPerGrpSVO
	 * @return
	 */
	public Integer selectB2bCorpGrpListCnt(B2B_RC_DISPERGRPSVO disPerGrpSVO) {
		return (Integer) select("B2B_RC_DISPERGRP_S_02", disPerGrpSVO);
	}

	/**
	 * 그룹 수정
	 * 파일명 : updateDisPerGrp
	 * 작성일 : 2016. 9. 28. 오후 4:27:29
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 */
	public void updateDisPerGrp(B2B_RC_DISPERGRPVO disPerGrpVO) {
		update("B2B_RC_DISPERGRP_U_01", disPerGrpVO);
	}

	/**
	 * 업체 그룹 MERGE
	 * 파일명 : mergeCorpGrp
	 * 작성일 : 2016. 9. 28. 오후 4:29:37
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 */
	public void mergeCorpGrp(B2B_RC_DISPERGRPVO disPerGrpVO) {
		update("B2B_RC_CORPDISPER_M_00", disPerGrpVO);
	}

	/**
	 * 업체 그룹 삭제
	 * 파일명 : deleteCorpGrp
	 * 작성일 : 2016. 9. 28. 오후 4:34:04
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 */
	public void deleteCorpGrp(B2B_RC_DISPERGRPVO disPerGrpVO) {
		delete("B2B_RC_CORPDISPER_D_00", disPerGrpVO);
	}

	/**
	 * 렌터카 업체 할인율 그룹 리스트 조회
	 * 파일명 : selectCorpDisPerList
	 * 작성일 : 2016. 9. 28. 오후 4:34:50
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_RC_DISPERGRPVO> selectCorpDisPerList(B2B_RC_DISPERGRPVO disPerGrpVO) {
		return (List<B2B_RC_DISPERGRPVO>) list("B2B_RC_CORPDISPER_S_01", disPerGrpVO);
	}

	/**
	 * 렌터카 업체 할인율 그룹 삭제
	 * 파일명 : deleteDisPerGrp
	 * 작성일 : 2016. 9. 28. 오후 4:35:48
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 */
	public void deleteDisPerGrp(B2B_RC_DISPERGRPVO disPerGrpVO) {
		delete("B2B_RC_DISPERGRP_D_00", disPerGrpVO);
	}

	/**
	 * 기본 할인율 조회
	 * 파일명 : selectByDefDisPer
	 * 작성일 : 2016. 9. 30. 오후 1:35:43
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	public B2B_RC_DISPERVO selectByDefDisPer(B2B_RC_DISPERVO disPerInfVO) {
		return (B2B_RC_DISPERVO) select("B2B_RC_DISPER_S_02", disPerInfVO);
	}

	/**
	 * 기간 할인율 조회
	 * 파일명 : selectDisPerList
	 * 작성일 : 2016. 9. 30. 오후 1:37:32
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_RC_DISPERVO> selectDisPerList(B2B_RC_DISPERVO disPerInfVO) {
		return (List<B2B_RC_DISPERVO>) list("B2B_RC_DISPER_S_01", disPerInfVO);
	}

	/**
	 * 할인율 그룹 단건 조회
	 * 파일명 : selectByDisPerGrp
	 * 작성일 : 2016. 9. 30. 오후 1:47:23
	 * 작성자 : 최영철
	 * @param disPerGrpVO
	 * @return
	 */
	public B2B_RC_DISPERGRPVO selectByDisPerGrp(B2B_RC_DISPERGRPVO disPerGrpVO) {
		return (B2B_RC_DISPERGRPVO) select("B2B_RC_DISPERGRP_S_00", disPerGrpVO);
	}

	/**
	 * 기본 할인율 등록
	 * 파일명 : insertDefDisPer
	 * 작성일 : 2016. 9. 30. 오후 2:40:28
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	public void insertDefDisPer(B2B_RC_DISPERVO disPerInfVO) {
		insert("B2B_RC_DISPER_I_00", disPerInfVO);
	}

	/**
	 * 할인율 수정
	 * 파일명 : updateDisPer
	 * 작성일 : 2016. 9. 30. 오후 4:11:35
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	public void updateDisPer(B2B_RC_DISPERVO disPerInfVO) {
		update("B2B_RC_DISPER_U_00", disPerInfVO);
	}

	/**
	 * 할인율 범위 중복 체크
	 * 파일명 : checkRangeAplDt
	 * 작성일 : 2016. 10. 4. 오전 9:55:37
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	public Integer checkRangeAplDt(B2B_RC_DISPERVO disPerInfVO) {
		return (Integer) select("B2B_RC_DISPER_S_03", disPerInfVO);
	}

	/**
	 * 기간 할인율 등록
	 * 파일명 : insertRangeDisPer
	 * 작성일 : 2016. 10. 4. 오전 10:03:02
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	public void insertRangeDisPer(B2B_RC_DISPERVO disPerInfVO) {
		insert("B2B_RC_DISPER_I_01", disPerInfVO);
	}

	/**
	 * 기간 할인율 수정
	 * 파일명 : updateRangeDisPer
	 * 작성일 : 2016. 10. 4. 오전 10:15:34
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	public void updateRangeDisPer(B2B_RC_DISPERVO disPerInfVO) {
		update("B2B_RC_DISPER_U_00", disPerInfVO);
	}

	/**
	 * 기간 할인율 삭제
	 * 파일명 : deleteRangeDisPer
	 * 작성일 : 2016. 10. 4. 오전 10:19:23
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	public void deleteRangeDisPer(B2B_RC_DISPERVO disPerInfVO) {
		delete("B2B_RC_DISPER_D_00", disPerInfVO);
	}

	/**
	 * 기간 할인율 단건 조회
	 * 파일명 : selectByDisPerInf
	 * 작성일 : 2016. 10. 4. 오전 10:25:09
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	public B2B_RC_DISPERVO selectByDisPerInf(B2B_RC_DISPERVO disPerInfVO) {
		return (B2B_RC_DISPERVO) select("B2B_RC_DISPER_S_00", disPerInfVO);
	}

	/**
	 * 렌터카 실시간 상품 조회
	 * 파일명 : selectAdPrdtList
	 * 작성일 : 2016. 10. 7. 오후 1:56:15
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_RC_PRDTVO> selectAdPrdtList(B2B_RC_PRDTSVO prdtSVO) {
		return (List<B2B_RC_PRDTVO>) list("B2B_RC_PRDT_S_00", prdtSVO);
	}


}
