package mas.ad.service.impl;

import java.util.List;

import mas.ad.vo.AD_ADDAMTSVO;
import mas.ad.vo.AD_ADDAMTVO;
import mas.ad.vo.AD_AMTINFSVO;
import mas.ad.vo.AD_AMTINFVO;
import mas.ad.vo.AD_BREAKFASTAMTVO;
import mas.ad.vo.AD_CNTINFSVO;
import mas.ad.vo.AD_CNTINFVO;
import mas.ad.vo.AD_CTNAMTVO;
import mas.ad.vo.AD_CTNINFVO;
import mas.ad.vo.AD_DFTINFVO;
import mas.ad.vo.AD_PRDTINFSVO;
import mas.ad.vo.AD_PRDTINFVO;

import org.springframework.stereotype.Repository;

import oss.ad.vo.AD_SYNCINFVO;
import web.order.vo.AD_RSVVO;
import web.order.vo.RSVSVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;



@Repository("adDAO")
public class AdDAO extends EgovAbstractDAO {



//	@SuppressWarnings("unchecked")
//	public List<BBSVO> selectBbsList(BBSSVO bbsSVO) {
//		return (List<BBSVO>) list("BBS_S_01", bbsSVO);
//	}

//	public Integer getCntBbsList(BBSSVO bbsSVO) {
//		return (Integer) select("BBS_S_02", bbsSVO);
//	}

	/**
	 * 숙소 기본 정보 얻기
	 * 파일명 : selectByAdDftinf
	 * 작성일 : 2015. 10. 7. 오후 4:47:18
	 * 작성자 : 신우섭
	 * @param adDftinfVO
	 * @return
	 */
	public AD_DFTINFVO selectByAdDftinf(AD_DFTINFVO adDftinfVO) {
		return (AD_DFTINFVO) select("AD_DFTINF_S_00", adDftinfVO);
	}


	/**
	 * 숙소 기본 정보 추가
	 * 파일명 : insertAdDftinf
	 * 작성일 : 2015. 10. 7. 오후 4:47:54
	 * 작성자 : 신우섭
	 * @param adDftinfVO
	 */
	public void insertAdDftinf(AD_DFTINFVO adDftinfVO) {
		insert("AD_DFTINF_I_00", adDftinfVO);
	}

	/**
	 * 숙소 기본 정보 수정
	 * 파일명 : updateAdDftinf
	 * 작성일 : 2015. 10. 7. 오후 4:48:05
	 * 작성자 : 신우섭
	 * @param adDftinfVO
	 */
	public void updateAdDftinf(AD_DFTINFVO adDftinfVO) {
		update("AD_DFTINF_U_00", adDftinfVO);
	}


	/**
	 * 숙소 기본 정보 중 총판매 숫자만 수정
	 * 파일명 : updateAdDftinfByTotNum
	 * 작성일 : 2015. 10. 7. 오후 4:48:18
	 * 작성자 : 신우섭
	 * @param adDftinfVO
	 */
	public void updateAdDftinfByTotNum(AD_DFTINFVO adDftinfVO) {
		update("AD_DFTINF_U_01", adDftinfVO);
	}

//	public void deleteBbs(BBSVO bbsVO) {
//		delete("BBS_D_00", bbsVO);
//	}


	/**
	 * 숙박 추가 요금 단건 검색
	 * 파일명 : selectByAdAddamt
	 * 작성일 : 2015. 10. 7. 오후 4:48:51
	 * 작성자 : 신우섭
	 * @param ad_ADDAMTVO
	 * @return
	 */
	public AD_ADDAMTVO selectByAdAddamt(AD_ADDAMTVO ad_ADDAMTVO) {
		return (AD_ADDAMTVO) select("AD_ADDAMT_S_00", ad_ADDAMTVO);
	}

	/**
	 * 숙박 추가 요금 목록
	 * 파일명 : selectAdAddamtList
	 * 작성일 : 2015. 10. 7. 오후 4:49:04
	 * 작성자 : 신우섭
	 * @param ad_ADDAMTSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_ADDAMTVO> selectAdAddamtList(AD_ADDAMTSVO ad_ADDAMTSVO) {
		return (List<AD_ADDAMTVO>) list("AD_ADDAMT_S_01", ad_ADDAMTSVO);
	}

	/**
	 * 숙박 추가 요금 목록 카운터
	 * 파일명 : getCntAdAddamtList
	 * 작성일 : 2015. 10. 7. 오후 4:49:16
	 * 작성자 : 신우섭
	 * @param ad_ADDAMTSVO
	 * @return
	 */
	public Integer getCntAdAddamtList(AD_ADDAMTSVO ad_ADDAMTSVO) {
		return (Integer) select("AD_ADDAMT_S_02", ad_ADDAMTSVO);
	}

	/**
	 * 숙박 추가 요금 추가
	 * 파일명 : insertAdAddamt
	 * 작성일 : 2015. 10. 8. 오후 5:03:21
	 * 작성자 : 신우섭
	 * @param ad_ADDAMTVO
	 */
	public void insertAdAddamt(AD_ADDAMTVO ad_ADDAMTVO) {
		insert("AD_ADDAMT_I_00", ad_ADDAMTVO);
	}

	/**
	 * 숙박 추가 요금 수정
	 * 파일명 : updateAdAddamt
	 * 작성일 : 2015. 10. 8. 오후 5:03:30
	 * 작성자 : 신우섭
	 * @param ad_ADDAMTVO
	 */
	public void updateAdAddamt(AD_ADDAMTVO ad_ADDAMTVO) {
		update("AD_ADDAMT_U_00", ad_ADDAMTVO);
	}

	/**
	 * 숙박 추가 요금 삭제
	 * 파일명 : deleteAdAddamt
	 * 작성일 : 2015. 10. 8. 오후 5:03:49
	 * 작성자 : 신우섭
	 * @param ad_ADDAMTVO
	 */
	public void deleteAdAddamt(AD_ADDAMTVO ad_ADDAMTVO) {
		delete("AD_ADDAMT_D_00", ad_ADDAMTVO);
	}



	/**
	 * 객실 단건 조회
	 * 파일명 : selectByAdPrdinf
	 * 작성일 : 2015. 10. 8. 오후 5:46:47
	 * 작성자 : 신우섭
	 * @param ad_PRDINFVO
	 * @return
	 */
	public AD_PRDTINFVO selectByAdPrdinf(AD_PRDTINFVO ad_PRDINFVO) {
		return (AD_PRDTINFVO) select("AD_PRDTINF_S_00", ad_PRDINFVO);
	}

	/**
	 * 객실 목록
	 * 파일명 : selectAdPrdinfList
	 * 작성일 : 2015. 10. 8. 오후 5:47:06
	 * 작성자 : 신우섭
	 * @param ad_PRDINFSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_PRDTINFVO> selectAdPrdinfList(AD_PRDTINFSVO ad_PRDINFSVO) {
		return (List<AD_PRDTINFVO>) list("AD_PRDTINF_S_01", ad_PRDINFSVO);
	}

	/**
	 * 객실 목록 카운터
	 * 파일명 : getCntAdPrdinfList
	 * 작성일 : 2015. 10. 8. 오후 5:47:25
	 * 작성자 : 신우섭
	 * @param
	 * @return
	 */
	public Integer getCntAdPrdinfList(AD_PRDTINFSVO ad_PRDINFSVO) {
		return (Integer) select("AD_PRDTINF_S_02", ad_PRDINFSVO);
	}

	/**
	 * 리얼타임에서 객실 목록
	 * 파일명 : selectAdPrdinfList3
	 * 작성일 : 2015. 12. 2. 오후 4:22:30
	 * 작성자 : 신우섭
	 * @param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_PRDTINFVO> selectAdPrdinfList3(AD_PRDTINFVO ad_PRDTINFVO) {
		return (List<AD_PRDTINFVO>) list("AD_PRDTINF_S_03", ad_PRDTINFVO);
	}


	public AD_PRDTINFVO selectByAdPrdinfTopViewSn(AD_PRDTINFVO ad_PRDINFVO) {
		return (AD_PRDTINFVO) select("AD_PRDTINF_S_06", ad_PRDINFVO);
	}

	/**
	 * 요금 설정 시 객실 정보 조회
	 * 파일명 : selectByAdAmtInf
	 * 작성일 : 2017. 7. 24. 오후 4:23:27
	 * 작성자 : 정동수
	 * @param ad_PRDINFVO
	 * @return
	 */
	public AD_PRDTINFVO selectByAdAmtInf(AD_PRDTINFVO ad_PRDINFVO) {
		return (AD_PRDTINFVO) select("AD_PRDTINF_S_07", ad_PRDINFVO);
	}

	/**
	 * 객실 추가
	 * 파일명 : insertAdAddamt
	 * 작성일 : 2015. 10. 8. 오후 5:47:34
	 * 작성자 : 신우섭
	 * @param ad_PRDINFSVO
	 */
	public void insertAdPrdinf(AD_PRDTINFSVO ad_PRDINFSVO) {
		insert("AD_PRDTINF_I_00", ad_PRDINFSVO);
	}

	/**
	 * 객실 수정
	 * 파일명 : updateAdPrdinf
	 * 작성일 : 2015. 10. 8. 오후 5:47:43
	 * 작성자 : 신우섭
	 * @param ad_PRDINFSVO
	 */
	public void updateAdPrdinf(AD_PRDTINFSVO ad_PRDINFSVO) {
		update("AD_PRDTINF_U_00", ad_PRDINFSVO);
	}

	public void addViewSnAdPrdinf(AD_PRDTINFSVO ad_PRDINFSVO) {
		update("AD_PRDTINF_U_01", ad_PRDINFSVO);
	}

	public void minusViewSnAdPrdinf(AD_PRDTINFSVO ad_PRDINFSVO) {
		update("AD_PRDTINF_U_02", ad_PRDINFSVO);
	}

	public void updateViewSnAdPrdinf(AD_PRDTINFSVO ad_PRDINFSVO) {
		update("AD_PRDTINF_U_03", ad_PRDINFSVO);
	}


	/**
	 * 객실 삭제
	 * 파일명 : deleteAdPrdinf
	 * 작성일 : 2015. 10. 8. 오후 5:47:51
	 * 작성자 : 신우섭
	 * @param ad_PRDINFSVO
	 */
	public void deleteAdPrdinf(AD_PRDTINFSVO ad_PRDINFSVO) {
		delete("AD_PRDTINF_D_00", ad_PRDINFSVO);
	}


	/**
	 * 상품 승인요청
	 * 파일명 : approvalPrdt
	 * 작성일 : 2015. 10. 20. 오전 10:53:09
	 * 작성자 : 신우섭
	 * @param
	 */
	public void approvalPrdt(AD_PRDTINFVO ad_PRDTINFVO) {
		update("AD_PRDTINF_U_04", ad_PRDTINFVO);
	}

	public void approvalCancelPrdt(AD_PRDTINFVO ad_PRDTINFVO) {
		update("AD_PRDTINF_U_05", ad_PRDTINFVO);
	}

	public void salePrintN(AD_PRDTINFVO ad_PRDTINFVO) {
		update("AD_PRDTINF_U_09", ad_PRDTINFVO);
	}
	
	/**
	 * 상품의 연박 사용 여부 수정
	 * Function : updateCtnAplYn
	 * 작성일 : 2017. 6. 19. 오후 4:57:23
	 * 작성자 : 정동수
	 * @param ad_PRDTINFVO
	 */
	public void updateCtnAplYn(AD_PRDTINFVO ad_PRDTINFVO) {
		update("AD_PRDTINF_U_08", ad_PRDTINFVO);
	}



	/**
	 * 객실 요금 단건 조회
	 * 파일명 : selectByAdAmtinf
	 * 작성일 : 2015. 10. 13. 오후 4:16:52
	 * 작성자 : 신우섭
	 * @param ad_AMTINFVO
	 * @return
	 */
	public AD_AMTINFVO selectByAdAmtinf(AD_AMTINFVO ad_AMTINFVO) {
		return (AD_AMTINFVO) select("AD_AMTINF_S_00", ad_AMTINFVO);
	}

	/**
	 * 객실 요금 여러건 조회
	 * 파일명 : selectAdAmtinfList
	 * 작성일 : 2015. 10. 15. 오전 10:49:17
	 * 작성자 : 신우섭
	 * @param ad_AMTINFSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_AMTINFVO> selectAdAmtinfList(AD_AMTINFSVO ad_AMTINFSVO) {
		return (List<AD_AMTINFVO>) list("AD_AMTINF_S_01", ad_AMTINFSVO);
	}

	/**
	 * 객실 요금 여러건 조회 - 업체용
	 * 파일명 : selectAdAmtinfListMas
	 * 작성일 : 2015. 12. 3. 오후 5:30:13
	 * 작성자 : 신우섭
	 * @param ad_AMTINFSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_AMTINFVO> selectAdAmtinfListMas(AD_AMTINFSVO ad_AMTINFSVO) {
		return (List<AD_AMTINFVO>) list("AD_AMTINF_S_02", ad_AMTINFSVO);
	}

	/**
	 * 숙소 가격 - 간단 입력용 삽입
	 * 파일명 : insertAdAmtinfCalSmp
	 * 작성일 : 2015. 10. 14. 오후 5:49:04
	 * 작성자 : 신우섭
	 * @param
	 */
	public void insertAdAmtinfCalSmp(AD_AMTINFVO ad_AMTINFVO) {
		insert("AD_AMTINF_I_01", ad_AMTINFVO);
	}

	/**
	 * 숙소 가격 - 간단 입력용 수정
	 * 파일명 : updateAdAmtinfCalSmp
	 * 작성일 : 2015. 10. 14. 오후 5:49:16
	 * 작성자 : 신우섭
	 * @param
	 */
	public void updateAdAmtinfCalSmp(AD_AMTINFVO ad_AMTINFVO) {
		update("AD_AMTINF_U_01", ad_AMTINFVO);
	}

	/**
	 * 숙소 가격 - 간단 입력용 삽입
	 * 파일명 : mergeAdAmtinf
	 * 작성일 : 2015. 10. 15. 오전 10:48:58
	 * 작성자 : 신우섭
	 * @param ad_AMTINFVO
	 */
	public void mergeAdAmtinf(AD_AMTINFVO ad_AMTINFVO) {
		update("AD_AMTINF_M_00", ad_AMTINFVO);
	}

	public void deleteAdAmtinf(AD_AMTINFVO ad_AMTINFVO) {
		delete("AD_AMTINF_D_00", ad_AMTINFVO);
	}
	
	public void deleteAdAmtinfOne(AD_AMTINFVO ad_AMTINFVO) {
		delete("AD_AMTINF_D_01", ad_AMTINFVO);
	}

	public AD_CNTINFVO selectByAdCntinf(AD_CNTINFVO ad_CNTINFVO) {
		return (AD_CNTINFVO) select("AD_CNTINF_S_00", ad_CNTINFVO);
	}

	@SuppressWarnings("unchecked")
	public List<AD_CNTINFVO> selectAdCntinfList(AD_CNTINFSVO ad_CNTINFSVO) {
		return (List<AD_CNTINFVO>) list("AD_CNTINF_S_01", ad_CNTINFSVO);
	}

	public void insertAdCntinfCalSmp(AD_CNTINFVO ad_CNTINFVO) {
		insert("AD_CNTINF_I_01", ad_CNTINFVO);
	}

	public void updateAdCntinfCalSmp(AD_CNTINFVO ad_CNTINFVO) {
		update("AD_CNTINF_U_01", ad_CNTINFVO);
	}

	public void updateAdCntInfAddFromAPI(AD_RSVVO adRsvVO) {
		update("AD_CNTINF_U_04", adRsvVO);
	}

	public void updateAdCntInfMinFromAPI(AD_RSVVO adRsvVO) {
		update("AD_CNTINF_U_05", adRsvVO);
	}


	public void mergeAdCntinf(AD_CNTINFVO ad_CNTINFVO) {
		update("AD_CNTINF_M_00", ad_CNTINFVO);
	}

	public void mergeAdCntinfNoDdl(AD_CNTINFVO ad_CNTINFVO) {
		update("AD_CNTINF_M_01", ad_CNTINFVO);
	}

	public void deleteAdCntinf(AD_CNTINFVO ad_CNTINFVO) {
		delete("AD_CNTINF_D_00", ad_CNTINFVO);
	}

	public void addAdCnt(AD_CNTINFVO ad_CNTINFVO){
		update("AD_CNTINF_U_02", ad_CNTINFVO);
	}

	/**
	 * 당일 예약불가 여부를 체크한 수량 리스트
	 * 파일명 : selectWebAdCntInfList
	 * 작성일 : 2016. 9. 26. 오후 7:49:38
	 * 작성자 : 최영철
	 * @param ad_CNTINFSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_CNTINFVO> selectWebAdCntInfList(AD_CNTINFSVO ad_CNTINFSVO) {
		return (List<AD_CNTINFVO>) list("AD_CNTINF_S_02", ad_CNTINFSVO);
	}


	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오후 4:11:39
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	public Integer checkExsistPrdt(RSVSVO rsvSVO) {
		return (Integer) select("AD_RSV_S_05", rsvSVO);
	}

	/**
	 * 해당 상품에 해당하는 연박 정보 리스트
	 * Function : selectAdCtnInfList
	 * 작성일 : 2017. 6. 19. 오후 4:13:00
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_CTNINFVO> selectAdCtnInfList(AD_CTNINFVO ad_CtnInf) {
		return (List<AD_CTNINFVO>) list("AD_CTNINF_S_00", ad_CtnInf);
	}

	/**
	 * 해당 상품에 해당하는 연박 정보 산출
	 * Function : selectAdCtnInfoInfo
	 * 작성일 : 2017. 6. 21. 오후 5:53:07
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 * @return
	 */
	public AD_CTNINFVO selectAdCtnInfoInfo(AD_CTNINFVO ad_CtnInf) {
		return (AD_CTNINFVO) select("AD_CTNINF_S_01", ad_CtnInf);
	}

	/**
	 * 해당 상품에 해당하는 연박 정보 등록
	 * Function : insertAdCtnInf
	 * 작성일 : 2017. 6. 19. 오후 5:42:12
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 */
	public void insertAdCtnInf(AD_CTNINFVO ad_CtnInf) {
		insert("AD_CTNINF_I_00", ad_CtnInf);
	}

	/**
	 * 해당 상품에 해당하는 연박 정보 수정
	 * Function : updateAdCtnInf
	 * 작성일 : 2017. 6. 19. 오후 5:42:34
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 */
	public void updateAdCtnInf(AD_CTNINFVO ad_CtnInf) {
		update("AD_CTNINF_U_00", ad_CtnInf);
	}
	
	/**
	 * 해당 상품에 해당하는 연박 기간 삭제
	 * Function : deleteAdCtnInf
	 * 작성일 : 2018. 1. 12. 오전 11:19:14
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 */
	public void deleteAdCtnInf(AD_CTNINFVO ad_CtnInf) {
		update("AD_CTNINF_D_00", ad_CtnInf);
	}

	/**
	 * 기간 정보에 해당하는 연박 요금 정보 리스트 출력
	 * Function : selectAdCtnAmt
	 * 작성일 : 2017. 6. 27. 오전 10:33:36
	 * 작성자 : 정동수
	 * @param
	 * @return AD_CTNAMTVO
	 */
	@SuppressWarnings("unchecked")
	public List<AD_CTNAMTVO> selectAdCtnAmt(AD_CTNAMTVO ad_CtnAmt) {
		return (List<AD_CTNAMTVO>) list("AD_CTN_AMT_S_00", ad_CtnAmt);
	}

	/**
	 * 숙박일에 해당하는 연박 적용 요금 출력
	 * Function : selectCtnAmtInfo
	 * 작성일 : 2017. 6. 28. 오전 11:27:24
	 * 작성자 : 정동수
	 * @param adAmtSVO
	 * @return
	 */
	public AD_CTNAMTVO selectCtnAmtInfo(AD_AMTINFSVO adAmtSVO) {
		return (AD_CTNAMTVO) select("AD_CTN_AMT_S_01", adAmtSVO);
	}

	/**
	 * 숙박일에 해당하는 연박 적용 요금 리스트 출력
	 * Function : selectCtnAmtList
	 * 작성일 : 2017. 6. 29. 오전 10:30:57
	 * 작성자 : 정동수
	 * @param adAmtSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AD_CTNAMTVO> selectCtnAmtList(AD_AMTINFSVO adAmtSVO) {
		return (List<AD_CTNAMTVO>) list("AD_CTN_AMT_S_02", adAmtSVO);
	}

	/**
	 * 적용된 요금 정보 산출
	 * Function : selectCtnAmtStr
	 * 작성일 : 2017. 6. 30. 오후 2:11:49
	 * 작성자 : 정동수
	 * @param adAmtSVO
	 * @return
	 */
	public AD_CTNAMTVO selectCtnAmtStr(AD_CTNAMTVO ad_CtnAmt) {
		return (AD_CTNAMTVO) select("AD_CTN_AMT_S_03", ad_CtnAmt);
	}

	/**
	 * 해당 상품에 해당하는 연박 요금 정보 저장
	 * Function : updateAdCtnAmt
	 * 작성일 : 2017. 6. 21. 오후 4:12:30
	 * 작성자 : 정동수
	 * @param ad_CtnAmt
	 */
	public void updateAdCtnAmt(AD_CTNAMTVO ad_CtnAmt) {
		update("AD_CTNINF_M_00", ad_CtnAmt);
	}
	
	/**
	 * 해당 상품에 해당하는 연박 요금 삭제
	 * Function : deleteAdCtnAmt
	 * 작성일 : 2018. 1. 12. 오전 11:19:14
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 */
	public void deleteAdCtnAmt(AD_CTNINFVO ad_CtnInf) {
		update("AD_CTN_AMT_D_00", ad_CtnInf);
	}


	public AD_BREAKFASTAMTVO selectByAdBreakfastAmt(String corpId) {
		return (AD_BREAKFASTAMTVO) select("AD_BREAKFAST_AMT_S_00", corpId);
	}

	public void updateAdBreakfastAmt(AD_BREAKFASTAMTVO ad_breakfastamtVO) {
		update("AD_BREAKFAST_AMT_M_00", ad_breakfastamtVO);
	}


}
