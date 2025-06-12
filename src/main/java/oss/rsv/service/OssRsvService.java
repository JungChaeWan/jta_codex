package oss.rsv.service;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.multipart.MultipartFile;
import oss.rsv.vo.OSS_RSVEXCELVO;
import oss.user.vo.REFUNDACCINFVO;
import web.order.vo.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface OssRsvService {

	/**
	 * 통합 예약 리스트 조회
	 * 파일명 : selectRsvList
	 * 작성일 : 2015. 12. 11. 오전 10:18:38
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	Map<String, Object> selectRsvList(RSVSVO rsvSVO);

	/**
	 * 환불 요청건 리스트 조회
	 * 파일명 : selectRefundList
	 * 작성일 : 2016. 1. 17. 오후 1:37:14
	 * 작성자 : 최영철
	 * @param orderSVO
	 * @return
	 */
	Map<String, Object> selectRefundList(ORDERSVO orderSVO);
	int getRsvOssMain(RSVVO rsvVO);

	/**
	 * 환불 요청건 단건 조회
	 * 파일명 : selectByPrdtRsvInfo
	 * 작성일 : 2016. 1. 22. 오후 3:14:49
	 * 작성자 : 최영철
	 * @param orderSVO
	 * @return
	 */
	ORDERVO selectByPrdtRsvInfo(ORDERSVO orderSVO);

	/**
	 * 사용자 환불 계좌 정보 조회
	 * 파일명 : selectByRefundAccInf
	 * 작성일 : 2016. 1. 22. 오후 3:46:22
	 * 작성자 : 최영철
	 * @param orderSVO
	 * @return
	 */
	REFUNDACCINFVO selectByRefundAccInf(ORDERSVO orderSVO);

	/**
	 * 예약 환불정보 등록
	 * 파일명 : insertRefundInfo
	 * 작성일 : 2016. 1. 22. 오후 4:45:24
	 * 작성자 : 최영철
	 * @param orderVO
	 */
	void updateRefundInfo(ORDERVO orderVO);

	/**
	 * 환불사유 등록
	 */
	void updateRefundRsn(ORDERVO orderVO);

	/**
	 * 환불정보 등록
	 * 파일명 : mergeAccNum
	 * 작성일 : 2016. 1. 28. 오전 11:05:53
	 * 작성자 : 최영철
	 * @param refundAccInfVO
	 */
	void mergeAccNum(REFUNDACCINFVO refundAccInfVO);

	/**
	 * 상품별 예약 리스트 조회
	 * 파일명 : selectRsvAtPrdtList
	 * 작성일 : 2016. 3. 2. 오후 2:39:37
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	Map<String, Object> selectRsvAtPrdtList(RSVSVO rsvSVO);

	/**
	 * 상품별 예약 리스트 전체 조회
	 * 파일명 : selectRsvAtPrdtListAll
	 * 작성일 : 2016. 3. 2. 오후 3:38:30
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	List<ORDERVO> selectRsvAtPrdtListAll(RSVSVO rsvSVO);
	
	/**
	 * 사용자 예약내역 조회
	 * 파일명 : selectUserRsvList
	 * 작성일 : 2016. 5. 27. 오전 9:52:56
	 * 작성자 : 최영철
	 * @param rsvVO
	 * @return
	 */
	Map<String, Object> selectUserRsvList(RSVVO rsvVO);
	
	/**
	 * 항공 예약 리스트
	 * Function : selectAvRsvList
	 * 작성일 : 2016. 9. 2. 오후 5:24:24
	 * 작성자 : 정동수
	 * @param avRsvSVO
	 * @return
	 */
	Map<String, Object> selectAvRsvList(AV_RSVSVO avRsvSVO);

	/**
	 * 기념품 상품별 예약 조회
	 * 파일명 : selectRsvAtSvPrdtList
	 * 작성일 : 2016. 12. 26. 오후 5:23:43
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	Map<String, Object> selectRsvAtSvPrdtList(RSVSVO rsvSVO);

	/**
	 * 기념품 상품별 예약 조회 엑셀 다운로드용
	 * 파일명 : selectRsvAtSvPrdtListAll
	 * 작성일 : 2016. 12. 27. 오전 11:18:44
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	List<ORDERVO> selectRsvAtSvPrdtListAll(RSVSVO rsvSVO);

	//대시보드 실시간 상품/특산기념품 취소요청
	Integer getCntRsvList(RSVSVO rsvSVO);

	/**
	* 설명 : 관리자 직접 예약 시 예약처리 후 금액 합계 처리
	* 파일명 : updateTotalAmt
	* 작성일 : 2021-06-21 오후 5:24
	* 작성자 : chaewan.jung
	* @param : rsvVO
	* @return : void
	* @throws Exception
	*/
	void updateTotalAmt(RSVVO rsvVO);

	/**
	* 설명 : 관리자 직접 예약 시스템에서 [엑셀 상품 등록] Log(확인) Table에 저장
	* 파일명 : insertRsvRegExcelUp
	* 작성일 : 2021-11-11 오전 10:42
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	Integer insertRsvRegExcelUp(Workbook workbook, MultipartFile excelUpFile, String corpDiv) throws IOException;

	/**
	* 설명 : 관리자 직접 예약 시스템에서 [예약 리스트]
	* 파일명 :
	* 작성일 : 2021-11-11 오후 4:59
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	List<OSS_RSVEXCELVO> selectRsvRegExcel(OSS_RSVEXCELVO ossRsvExcelVO);

	/**
	* 설명 : 엑셀업로드한 Data와 검증된 Data 비교를 위해 조회
	* 파일명 :
	* 작성일 : 2021-11-16 오전 9:34
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	Integer selectExcelUpRsvCnt(OSS_RSVEXCELVO ossRsvExcelVO);

	/**
	* 설명 : 기존 엑셀업로드 내역 불러오기에 필요
	* 파일명 :
	* 작성일 : 2023-03-27 오전 10:42
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	String getLastGroupNo(String corpDiv);

	List<OSS_RSVEXCELVO> selectSprdtOptNm(OSS_RSVEXCELVO ossRsvExcelVO);

	/**
	* 설명 : 관리자 직접 예약 upload 후 데이터 매칭 작업
	* 파일명 :
	* 작성일 : 2023-03-27 오후 5:14
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	void updateRsvMatch(OSS_RSVEXCELVO ossRsvExcelVO);

	/**
	* 설명 : 관리자 Excel 예약 시 검증 Data
	* 파일명 :
	* 작성일 : 2023-03-28 오후 3:47
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	Integer getVerifyCnt(OSS_RSVEXCELVO ossRsvExcelVO);

	/**
	* 설명 : 관리자 Excel 예약 완료 상태로 업데이트
	* 파일명 :
	* 작성일 : 2023-03-29 오후 2:24
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	void updateRsvComplete(Integer seq);

	/**
	* 설명 : OSS 예약관리 - 예약 기본 정보 수정
	* 파일명 :
	* 작성일 : 2024-08-27 오후 4:42
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	void updateRsvInfo(RSVVO rsvVO);

}
