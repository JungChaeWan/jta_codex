package mas.b2b.service.impl;

import java.util.List;

import mas.b2b.vo.B2B_AD_AMTGRPSVO;
import mas.b2b.vo.B2B_AD_AMTGRPVO;
import mas.b2b.vo.B2B_AD_AMTSVO;
import mas.b2b.vo.B2B_AD_AMTVO;
import mas.b2b.vo.B2B_AD_PRDTSVO;
import mas.b2b.vo.B2B_AD_PRDTVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("b2bAdDAO")
public class B2bAdDAO extends EgovAbstractDAO {

	/**
	 * 전체 그룹 리스트 조회
	 * 파일명 : selectAmtGrpList
	 * 작성일 : 2016. 9. 27. 오후 1:41:27
	 * 작성자 : 최영철
	 * @param amtGrpSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_AD_AMTGRPVO> selectAmtGrpList(B2B_AD_AMTGRPSVO amtGrpSVO) {
		return (List<B2B_AD_AMTGRPVO>) list("B2B_AD_AMTGRP_S_03", amtGrpSVO);
	}

	/**
	 * 그룹 등록
	 * 파일명 : inserAmtGrp
	 * 작성일 : 2016. 9. 27. 오후 3:25:16
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	public void insertAmtGrp(B2B_AD_AMTGRPVO amtGrpVO) {
		insert("B2B_AD_AMTGRP_I_01", amtGrpVO);
	}

	/**
	 * 그룹별 업체 리스트
	 * 파일명 : selectB2bCorpGrpList
	 * 작성일 : 2016. 9. 27. 오후 3:43:05
	 * 작성자 : 최영철
	 * @param amtGrpSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_AD_AMTGRPVO> selectB2bCorpGrpList(B2B_AD_AMTGRPSVO amtGrpSVO) {
		return (List<B2B_AD_AMTGRPVO>) list("B2B_AD_AMTGRP_S_01", amtGrpSVO);
	}

	/**
	 * 그룹별 업체 리스트 카운트
	 * 파일명 : selectB2bCorpGrpListCnt
	 * 작성일 : 2016. 9. 27. 오후 3:43:35
	 * 작성자 : 최영철
	 * @param amtGrpSVO
	 * @return
	 */
	public Integer selectB2bCorpGrpListCnt(B2B_AD_AMTGRPSVO amtGrpSVO) {
		return (Integer) select("B2B_AD_AMTGRP_S_02", amtGrpSVO);
	}

	/**
	 * 그룹 수정
	 * 파일명 : updateAmtGrp
	 * 작성일 : 2016. 9. 27. 오후 4:48:05
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	public void updateAmtGrp(B2B_AD_AMTGRPVO amtGrpVO) {
		update("B2B_AD_AMTGRP_U_01", amtGrpVO);
	}

	/**
	 * 업체 그룹 MERGE
	 * 파일명 : mergeCorpGrp
	 * 작성일 : 2016. 9. 28. 오전 11:19:51
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	public void mergeCorpGrp(B2B_AD_AMTGRPVO amtGrpVO) {
		update("B2B_AD_CORPAMT_M_00", amtGrpVO);
	}

	/**
	 * 업체 그룹 삭제
	 * 파일명 : deleteCorpGrp
	 * 작성일 : 2016. 9. 28. 오전 11:31:53
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	public void deleteCorpGrp(B2B_AD_AMTGRPVO amtGrpVO) {
		delete("B2B_AD_CORPAMT_D_00", amtGrpVO);
	}

	/**
	 * 숙박 업체요금 그룹 리스트 조회
	 * 파일명 : selectCorpAmtList
	 * 작성일 : 2016. 9. 28. 오후 1:55:26
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_AD_AMTGRPVO> selectCorpAmtList(B2B_AD_AMTGRPVO amtGrpVO) {
		return (List<B2B_AD_AMTGRPVO>) list("B2B_AD_CORPAMT_S_01", amtGrpVO);
	}

	/**
	 * 숙박 업체요금 그룹 삭제
	 * 파일명 : deleteAmtGrp
	 * 작성일 : 2016. 9. 28. 오후 2:00:23
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 */
	public void deleteAmtGrp(B2B_AD_AMTGRPVO amtGrpVO) {
		delete("B2B_AD_AMTGRP_D_00", amtGrpVO);
	}

	/**
	 * 숙박 B2B 요금 조회
	 * 파일명 : selectAmtList
	 * 작성일 : 2016. 9. 29. 오전 9:55:25
	 * 작성자 : 최영철
	 * @param amtSVO
	 * @return 
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_AD_AMTVO> selectAmtList(B2B_AD_AMTSVO amtSVO) {
		return (List<B2B_AD_AMTVO>) list("B2B_AD_AMT_S_01", amtSVO);
	}

	/**
	 * 요금 그룹 단건 조회
	 * 파일명 : selectByAmtGrp
	 * 작성일 : 2016. 9. 29. 오전 10:28:03
	 * 작성자 : 최영철
	 * @param amtGrpVO
	 * @return
	 */
	public B2B_AD_AMTGRPVO selectByAmtGrp(B2B_AD_AMTGRPVO amtGrpVO) {
		return (B2B_AD_AMTGRPVO) select("B2B_AD_AMTGRP_S_00", amtGrpVO);
	}

	/**
	 * 일괄 수정
	 * 파일명 : updateAmtCalSmp
	 * 작성일 : 2016. 9. 29. 오후 1:35:09
	 * 작성자 : 최영철
	 * @param amtVO
	 */
	public void updateAmtCalSmp(B2B_AD_AMTVO amtVO) {
		update("B2B_AD_AMT_U_01", amtVO);
	}
	
	/**
	 * 일괄 수정
	 * 파일명 : updateAmtCalSmp
	 * 작성일 : 2016. 9. 29. 오후 1:35:09
	 * 작성자 : 최영철
	 * @param amtVO
	 */
	public void insertAmtCalSmp(B2B_AD_AMTVO amtVO) {
		update("B2B_AD_AMT_I_01", amtVO);
	}

	/**
	 * 요금 적용
	 * 파일명 : mergeAmtInf
	 * 작성일 : 2016. 9. 29. 오후 2:43:13
	 * 작성자 : 최영철
	 * @param amtVO
	 */
	public void mergeAmtInf(B2B_AD_AMTVO amtVO) {
		update("B2B_AD_AMT_M_01", amtVO);
	}

	/**
	 * 숙박 실시간 상품 조회
	 * 파일명 : selectAdPrdtList
	 * 작성일 : 2016. 10. 5. 오후 2:34:11
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<B2B_AD_PRDTVO> selectAdPrdtList(B2B_AD_PRDTSVO searchVO) {
		return (List<B2B_AD_PRDTVO>) list("B2B_AD_PRDT_S_00", searchVO);
	}

	/**
	 * 숙박 실시간 상품 조회 카운트
	 * 파일명 : selectAdPrdtListCnt
	 * 작성일 : 2016. 10. 6. 오전 10:34:52
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	public Integer selectAdPrdtListCnt(B2B_AD_PRDTSVO searchVO) {
		return (Integer) select("B2B_AD_PRDT_S_01", searchVO);
	}


}
