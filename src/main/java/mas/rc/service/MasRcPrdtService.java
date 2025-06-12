package mas.rc.service;

import java.util.List;
import java.util.Map;

import mas.rc.vo.RC_AMTINFVO;
import mas.rc.vo.RC_CARDIVSVO;
import mas.rc.vo.RC_CARDIVVO;
import mas.rc.vo.RC_CNTINFVO;
import mas.rc.vo.RC_DFTINFVO;
import mas.rc.vo.RC_DISPERINFVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;
import mas.rc.vo.RC_RSVCHARTSVO;
import mas.rc.vo.RC_RSVCHARTVO;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import web.order.vo.RC_RSVVO;
import web.order.vo.RSVSVO;



public interface MasRcPrdtService {

	/**
	 * 렌터카 기본설정 조회
	 * 파일명 : selectByRcDftInfo
	 * 작성일 : 2015. 10. 5. 오후 1:07:48
	 * 작성자 : 최영철
	 * @param rc_DFTINFVO
	 * @return
	 */
	RC_DFTINFVO selectByRcDftInfo(RC_DFTINFVO rc_DFTINFVO);

	/**
	 * 렌터카 기본설정 저장
	 * 파일명 : mergeRcDftInfo
	 * 작성일 : 2015. 10. 5. 오후 5:47:19
	 * 작성자 : 최영철
	 * @param dftInfFVO
	 */
	void mergeRcDftInfo(RC_DFTINFVO dftInfFVO);

	/**
	 * 렌터카 상품 리스트조회
	 * 파일명 : selectRcPrdtList
	 * 작성일 : 2015. 10. 5. 오후 7:40:20
	 * 작성자 : 최영철
	 * @param prdtInfSVO
	 * @return
	 */
	Map<String, Object> selectRcPrdtList(RC_PRDTINFSVO prdtInfSVO);

	/**
	 * 렌터카 상품 등록
	 * 파일명 : insertPrdt
	 * 작성일 : 2015. 10. 7. 오전 9:47:19
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 * @param multiRequest
	 * @throws Exception
	 */
	void insertPrdt(RC_PRDTINFVO prdtInfVO, MultipartHttpServletRequest multiRequest) throws Exception;

	/**
	 * 렌터카 상품 단건 조회
	 * 파일명 : selectByPrdt
	 * 작성일 : 2015. 10. 8. 오전 10:25:32
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 * @return
	 */
	RC_PRDTINFVO selectByPrdt(RC_PRDTINFVO prdtInfVO);

	/**
	 * 렌터카 상품 수정
	 * 파일명 : updatePrdt
	 * 작성일 : 2015. 10. 8. 오후 1:56:04
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	void updatePrdt(RC_PRDTINFVO prdtInfVO);

	/**
	 * 렌터카 요금정보 리스트 조회
	 * 파일명 : selectRcPrdtAmtList
	 * 작성일 : 2015. 10. 12. 오전 11:05:45
	 * 작성자 : 최영철
	 * @param amtInfVO
	 * @return
	 */
	List<RC_AMTINFVO> selectRcPrdtAmtList(RC_AMTINFVO amtInfVO);

	/**
	 * 렌터카 적용일자에 대한 금액 단건 조회
	 * 파일명 : selectByPrdtAmt
	 * 작성일 : 2015. 10. 12. 오후 6:30:24
	 * 작성자 : 최영철
	 * @param amtInfVO
	 * @return
	 */
	RC_AMTINFVO selectByPrdtAmt(RC_AMTINFVO amtInfVO);

	/**
	 * 렌터카 요금 추가
	 * 파일명 : insertPrdtAmt
	 * 작성일 : 2015. 10. 12. 오후 7:54:44
	 * 작성자 : 최영철
	 * @param amtInfVO
	 */
	void insertPrdtAmt(RC_AMTINFVO amtInfVO);

	/**
	 * 렌터카 요금 수정
	 * 파일명 : updatePrdtAmt
	 * 작성일 : 2015. 10. 12. 오후 9:17:27
	 * 작성자 : 최영철
	 * @param amtInfVO
	 */
	void updatePrdtAmt(RC_AMTINFVO amtInfVO);

	/**
	 * 렌터카 요금 삭제
	 * 파일명 : deletePrdtAmt
	 * 작성일 : 2015. 10. 12. 오후 9:21:38
	 * 작성자 : 최영철
	 * @param amtInfVO
	 */
	void deletePrdtAmt(RC_AMTINFVO amtInfVO);

	/**
	 * 렌터카 할인율 조회
	 * 파일명 : selectDisPerList
	 * 작성일 : 2015. 10. 13. 오후 1:36:53
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	Map<String, Object> selectDisPerList(RC_DISPERINFVO disPerInfVO);

	/**
	 * 렌터카 기본할인율 등록
	 * 파일명 : insertDefDisPer
	 * 작성일 : 2015. 10. 13. 오후 5:59:53
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	void insertDefDisPer(RC_DISPERINFVO disPerInfVO);

	/**
	 * 렌터카 기본 할인율 수정
	 * 파일명 : updateDefDisPer
	 * 작성일 : 2015. 10. 13. 오후 8:18:17
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	void updateDefDisPer(RC_DISPERINFVO disPerInfVO);

	/**
	 * 렌터카 기간할인율 등록
	 * 파일명 : insertRangeDisPer
	 * 작성일 : 2015. 10. 14. 오전 10:09:51
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	void insertRangeDisPer(RC_DISPERINFVO disPerInfVO);

	/**
	 * 적용일자 중복 체크
	 * 파일명 : checkRangeAplDt
	 * 작성일 : 2015. 10. 14. 오전 11:36:49
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	Integer checkRangeAplDt(RC_DISPERINFVO disPerInfVO);

	/**
	 * 렌터카 기간할인율 단건 조회
	 * 파일명 : selectByDisPerInf
	 * 작성일 : 2015. 10. 14. 오후 2:47:12
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	RC_DISPERINFVO selectByDisPerInf(RC_DISPERINFVO disPerInfVO);

	/**
	 * 렌터카 기간할인율 수정
	 * 파일명 : updateRangeDisPer
	 * 작성일 : 2015. 10. 14. 오후 3:21:00
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	void updateRangeDisPer(RC_DISPERINFVO disPerInfVO);

	/**
	 * 렌터카 기간할인율 삭제
	 * 파일명 : deleteRangeDisPer
	 * 작성일 : 2015. 10. 14. 오후 3:41:24
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	void deleteRangeDisPer(RC_DISPERINFVO disPerInfVO);

	/**
	 * 렌터카 상품 승인요청
	 * 파일명 : approvalPrdt
	 * 작성일 : 2015. 10. 14. 오후 7:29:17
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 * @throws Exception
	 */
	void approvalPrdt(RC_PRDTINFVO prdtInfVO) throws Exception;

	/**
	 * 상품 삭제 처리
	 * 파일명 : deletePrdt
	 * 작성일 : 2015. 10. 16. 오전 11:56:35
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 * @throws Exception
	 */
	void deletePrdt(RC_PRDTINFVO prdtInfVO) throws Exception;

	/**
	 * 상품 승인 취소 요청
	 * 파일명 : approvalCancelPrdt
	 * 작성일 : 2015. 10. 19. 오전 11:36:22
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	void approvalCancelPrdt(RC_PRDTINFVO prdtInfVO);

	/**
	 * 렌터카 상품 전체 리스트 조회
	 * 파일명 : selectPrdtList
	 * 작성일 : 2015. 10. 20. 오후 2:23:34
	 * 작성자 : 최영철
	 * @param prdtInfSVO
	 * @return
	 */
	List<RC_PRDTINFVO> selectPrdtList(RC_PRDTINFSVO prdtInfSVO);

	List<RC_PRDTINFVO> selectCarNmList(RC_PRDTINFSVO prdtInfSVO);

	/**
	 * 렌터카 상품 수량 리스트 조회
	 * 파일명 : selectCntList
	 * 작성일 : 2015. 10. 20. 오후 3:52:08
	 * 작성자 : 최영철
	 * @param cntInfVO
	 * @return
	 */
	List<RC_CNTINFVO> selectCntList(RC_CNTINFVO cntInfVO);

	/**
	 * 렌터카 상품 수량 단건 조회
	 * 파일명 : selectByPrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 5:35:00
	 * 작성자 : 최영철
	 * @param cntInfVO
	 * @return
	 */
	RC_CNTINFVO selectByPrdtCnt(RC_CNTINFVO cntInfVO);

	/**
	 * 렌터카 상품 수량 등록
	 * 파일명 : insertPrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 5:49:01
	 * 작성자 : 최영철
	 * @param cntInfVO
	 */
	void insertPrdtCnt(RC_CNTINFVO cntInfVO);

	/**
	 * 렌터카 상품 수량 수정
	 * 파일명 : updatePrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 8:23:15
	 * 작성자 : 최영철
	 * @param cntInfVO
	 */
	void updatePrdtCnt(RC_CNTINFVO cntInfVO);

	/**
	 * 렌터카 상품 수량 삭제
	 * 파일명 : deletePrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 8:28:34
	 * 작성자 : 최영철
	 * @param cntInfVO
	 */
	void deletePrdtCnt(RC_CNTINFVO cntInfVO);


	int getCntRcPrdtFormCorp(RC_PRDTINFVO prdtInfVO);

	/**
	 * 상품 판매 중지
	 * 파일명 : saleStopPrdt
	 * 작성일 : 2016. 2. 4. 오전 11:37:23
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	void saleStopPrdt(RC_PRDTINFVO prdtInfVO);
	
	void salePrintN(RC_PRDTINFVO prdtInfVO);

	/**
	 * 업체 차량 수 구하기
	 * 파일명 : getCntRcPrdtList
	 * 작성일 : 2016. 6. 8. 오전 10:37:40
	 * 작성자 : 최영철
	 * @param cntChkVO
	 * @return
	 */
	Integer getCntRcPrdtList(RC_PRDTINFSVO cntChkVO);

	/**
	 * 노출 순번 변경
	 * 파일명 : updateRcPrdtViewSn
	 * 작성일 : 2016. 6. 8. 오전 11:18:55
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	void updateRcPrdtViewSn(RC_PRDTINFVO prdtInfVO);

	/**
	 * 할인율 일괄 조회
	 * 파일명 : selectDisperPackList
	 * 작성일 : 2016. 8. 2. 오전 10:11:52
	 * 작성자 : 최영철
	 * @param prdtInfSVO
	 * @return
	 */
	List<RC_DISPERINFVO> selectDisperPackList(RC_PRDTINFSVO prdtInfSVO);

	/**
	 * 할인율 일괄 수정
	 * 파일명 : updateChkDisPer
	 * 작성일 : 2016. 8. 3. 오전 11:31:26
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	void updateChkDisPer(RC_DISPERINFVO disPerInfVO);

	void deleteChkDisPer(RC_DISPERINFVO disPerInfVO);

	/**
	 * 기본 할인율이 등록안된 상품 조회
	 * 파일명 : selectDefDisPerPrdt
	 * 작성일 : 2016. 8. 3. 오후 2:48:56
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	List<RC_DISPERINFVO> selectDefDisPerPrdt(RC_PRDTINFSVO searchVO);

	/**
	 * 기본 할인율 일괄 등록
	 * 파일명 : insertDefDisPer2
	 * 작성일 : 2016. 8. 3. 오후 5:23:44
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	void insertDefDisPer2(RC_DISPERINFVO disPerInfVO);

	/**
	* 설명 : 렌터카 예약현황 조회
	* 파일명 : selectRsvChart
	* 작성일 : 2023-02-28 오후 3:23
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	List<RC_RSVCHARTVO> selectRsvChart(RC_RSVCHARTSVO searchVO);

	/**
	 * 예약현황 상세
	 * 파일명 : selectRsvChartDtl
	 * 작성일 : 2016. 8. 9. 오전 9:44:47
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	List<RC_RSVVO> selectRsvChartDtl(RSVSVO rsvSVO);

	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오전 10:33:13
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	Integer checkExsistPrdt(RSVSVO rsvSVO);

	/**
	 * 연계 설정/해제
	 * 파일명 : updatePrdtLinkYn
	 * 작성일 : 2016. 12. 5. 오전 10:31:23
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	void updatePrdtLinkYn(RC_PRDTINFVO prdtInfVO);

	/**
	 * 업체에 해당하는 상품인지 체크
	 * Function : checkCorpPrdt
	 * 작성일 : 2017. 5. 2. 오전 10:16:06
	 * 작성자 : 정동수
	 * @param prdtInfVO
	 * @return
	 */
	Integer checkCorpPrdt(RC_PRDTINFVO prdtInfVO);



	RC_CARDIVVO selectCardiv(RC_CARDIVVO rcCardivVO);
	Map<String, Object> selectCardivList(RC_CARDIVSVO rcCardivSVO);
	
	List<RC_CARDIVVO> selectCardivTotalList(RC_CARDIVSVO rcCardivSVO);
	
	/**
	 * 차종의 개수 체크
	 * Function : selectCardivCnt
	 * 작성일 : 2017. 12. 21. 오전 9:54:43
	 * 작성자 : 정동수
	 * @param rcCardivVO
	 * @return
	 */
	int selectCardivCnt(RC_CARDIVVO rcCardivVO);
	void insertCardiv(RC_CARDIVVO rcCardivVO);
	void updateCardiv(RC_CARDIVVO rcCardivVO);
	void deleteCardiv(RC_CARDIVVO rcCardivVO);	
	
	/*차종코드 자동증가값*/
	Integer selectCardivAutoIncrementNum(RC_CARDIVVO rcCardivVo);

	List<RC_CARDIVVO> selectCarNmList(RC_CARDIVSVO rcCardivSVO);
}
