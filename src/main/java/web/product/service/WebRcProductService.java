package web.product.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import org.json.simple.parser.ParseException;

import mas.rc.vo.RC_PRDTCNTVO;
import mas.rc.vo.RC_PRDTINFSVO;
import mas.rc.vo.RC_PRDTINFVO;




public interface WebRcProductService {

	/**
	 * 사용자 실시간 렌터카 리스트 조회
	 * 파일명 : selectRcPrdtList
	 * 작성일 : 2015. 10. 21. 오후 7:14:39
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */

	RC_PRDTINFVO selectRcPrdt(RC_PRDTINFSVO prdtSVO);
	Map<String, Object> selectRcPrdtList(RC_PRDTINFSVO prdtSVO) throws IOException, ParseException, InterruptedException, ExecutionException;
	List<RC_PRDTINFVO>  selectTotSchRcPrdtList(RC_PRDTINFSVO prdtSVO); //통합검색 렌터카 리스트 조회 
	
	Integer selectWebRcPrdtListCnt(RC_PRDTINFSVO prdtSVO);

	/**
	 * 사용자 차량유형별 카운트 조회
	 * 파일명 : selectRcPrdtCntList
	 * 작성일 : 2015. 10. 22. 오후 9:07:13
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	List<RC_PRDTCNTVO> selectRcPrdtCntList(RC_PRDTINFSVO prdtSVO);

	/**
	 * 사용자 렌터카 기본정보 조회
	 * 파일명 : selectByPrdt
	 * 작성일 : 2015. 10. 26. 오후 5:43:58
	 * 작성자 : 최영철
	 * @param prdtVO
	 * @return
	 */
	RC_PRDTINFVO selectByPrdt(RC_PRDTINFVO prdtVO);

	List<RC_PRDTINFVO> selectRcPrdtList2(RC_PRDTINFSVO prdtSVO);

	/**
	 * 단건 가능여부 확인
	 * 파일명 : selectRcAble
	 * 작성일 : 2015. 10. 30. 오전 9:43:19
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	RC_PRDTINFVO selectRcAble(RC_PRDTINFSVO prdtSVO);

	/**
	 * 베스트 상품
	 * 파일명 : selectRcBestPrdtList
	 * 작성일 : 2015. 11. 4. 오후 5:59:57
	 * 작성자 : 최영철
	 * @return
	 */
	List<RC_PRDTINFVO> selectRcBestPrdtList();


	List<RC_PRDTINFVO> selectWebRcPrdtListOssPrmt(RC_PRDTINFSVO prdtSVO);

	/**
	 * 여행사 렌터카 단품 카운트
	 * 파일명 : selectRcPackCnt
	 * 작성일 : 2016. 10. 25. 오후 3:32:12
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	Integer selectRcPackCnt(RC_PRDTINFSVO prdtSVO);

	/**
	 * 여행사 렌터카 단품 리스트
	 * 파일명 : selectRcPackList
	 * 작성일 : 2016. 10. 25. 오후 3:41:22
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	List<RC_PRDTINFVO> selectRcPackList(RC_PRDTINFSVO prdtSVO);

	/**
	 * 키워드 광고 상품 조회
	 * 파일명 : selectWebRcPrdtListOssKwa
	 * 작성일 : 2017. 8. 8. 오후 3:53:58
	 * 작성자 : 신우섭
	 * @param prdtSVO
	 * @return
	 */
	List<RC_PRDTINFVO> selectWebRcPrdtListOssKwa(String kwaNum);

	RC_PRDTINFVO apiRcData(RC_PRDTINFSVO prdtSVO, RC_PRDTINFVO data) throws IOException, ParseException;

	/**
	* 설명 : 누적예약, 예약가능 차량, 입점업체 수
	* 파일명 :
	* 작성일 : 2022-06-22 오후 2:38
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	HashMap<String, Integer> selectIntroCount();
}
