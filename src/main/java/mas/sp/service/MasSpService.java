package mas.sp.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import mas.sp.vo.SP_ADDOPTINFVO;
import mas.sp.vo.SP_DIVINFVO;
import mas.sp.vo.SP_DTLINFVO;
import mas.sp.vo.SP_DTLINF_ITEMVO;
import mas.sp.vo.SP_GUIDINFOVO;
import mas.sp.vo.SP_OPTINFVO;
import mas.sp.vo.SP_PRDTINFSVO;
import mas.sp.vo.SP_PRDTINFVO;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import web.order.vo.MRTNVO;
import web.order.vo.RSVSVO;

public interface MasSpService {
	/**
	 * 상품 리스트
	 * @param sp_prdtinfSVO
	 * @return
	 */
	Map<String, Object> selectSpPrdtInfList(SP_PRDTINFSVO sp_prdtinfSVO);
	/**
	 * 상품 재고 리스트.
	 * @param sp_PRDTINFVO
	 * @return
	 */
	List<SP_PRDTINFVO> selectSpPrdtSaleList(SP_PRDTINFVO sp_PRDTINFVO);

	/**
	 * 상품 상세
	 * @param sp_PRDTINFVO
	 * @return
	 */
	SP_PRDTINFVO selectBySpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO);

	/**
	 * 상품 등록
	 * @param sp_PRDTINFVO
	 * @param fileList
	 * @return
	 * @throws Exception
	 */
	String insertSpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO, String fileList) throws Exception;

	/**
	 * 옵션 등록
	 * @param sp_OPTINFVO
	 */
	void insertSpOptInf(SP_OPTINFVO sp_OPTINFVO);

	/**
	 * 상품기본 정보 수정
	 * @param sp_PRDTINFVO
	 */
	void updateSpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO);
	
	/**
	 * 상품 판매종료
	 * @param sp_PRDTINFVO
	 */	
	void salePrintN(SP_PRDTINFVO sp_PRDTINFVO);
	
	/**
	 * 상품 기본정보 수정(상세이미지와 함께)
	 * @param sp_PRDTINFVO
	 * @param multiRequest
	 * @throws Exception
	 */
	void updateSpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO, MultipartHttpServletRequest multiRequest) throws Exception;

	/**
	 * 옵션 구분자 정보 등록
	 * @param sp_DIVINFVO
	 */
	void insertSpDivInf(SP_DIVINFVO sp_DIVINFVO);

	/**
	 * 상품 구분자별 옵션 전체 리스트.,
	 * @param sp_OPTINFVO
	 * @return
	 */
	List<SP_OPTINFVO> selectPrdtOptionList(SP_OPTINFVO sp_OPTINFVO);

	/**
	 * 구분자 정보 가져오기
	 * @param sp_DIVINFVO
	 * @return
	 */
	SP_DIVINFVO selectSpDivInf(SP_DIVINFVO sp_DIVINFVO);

	/**
	 * 구분자 최대 정렬순서 가져오기.
	 * @param sp_DIVINFVO
	 * @return
	 */
	Integer selectDivInfMaxViewSn(SP_DIVINFVO sp_DIVINFVO);

	/**
	 * 구분자 정렬순서 증가.
	 * @param oldVO
	 */
	void addDivViewSn(SP_DIVINFVO oldVO);

	/**
	 * 구분자 정렬 순서 감소.
	 * @param oldVO
	 */
	void minusDivViewSn(SP_DIVINFVO oldVO);

	/**
	 * 구분자 정보 수정
	 * @param sp_DIVINFVO
	 */
	void updateSpDivInf(SP_DIVINFVO sp_DIVINFVO);

	/**
	 * 구분자 삭제
	 * @param sp_DIVINFVO
	 */
	void deleteSpDivInf(SP_DIVINFVO sp_DIVINFVO);

	/**
	 * 옵션 삭제
	 * @param sp_OPTINFVO
	 */
	void deleteSpOptInf(SP_OPTINFVO sp_OPTINFVO);

	void deleteSpAllOptInf(SP_OPTINFVO sp_OPTINFVO);

	/**
	 * 옵션 노출 순번 최대값
	 * @param sp_OPTINFVO
	 * @return
	 */
	Integer selectOptInfMaxViewSn(SP_OPTINFVO sp_OPTINFVO);

	/**
	 * 옵션 순번 증가.
	 * @param oldVO
	 */
	void addOptViewSn(SP_OPTINFVO oldVO);

	/**
	 * 옵션 순번 감소
	 * @param oldVO
	 */
	void minusOptViewSn(SP_OPTINFVO oldVO);

	/**
	 * 옵션 정보 가져오기
	 * @param sp_OPTINFVO
	 * @return
	 */
	SP_OPTINFVO selectSpOptInf(SP_OPTINFVO sp_OPTINFVO);

	/**
	 * 옵션 정보 수정
	 * @param sp_OPTINFVO
	 */
	void updateSpOptInf(SP_OPTINFVO sp_OPTINFVO);

	/**
	 * 옵션 정보 수정
	 * @param sp_PRDTINFVO
	 */
	void deleteSpPrdtInf(SP_PRDTINFVO sp_PRDTINFVO);

	/**
	 * 품절 처리를 위한 마감여부(ddlYn) update
	 * @param sp_OPTINFVO
	 */
	void updateDdlYn(SP_OPTINFVO sp_OPTINFVO);

	/**
	 * 협회 관리자 재고 관리 리스트
	 * @param sp_PRDTINFVO
	 * @return
	 */
	List<SP_OPTINFVO> selectStockList(SP_PRDTINFVO sp_PRDTINFVO);

	/**
	 * 거래 상태 업데이트 - 승인
	 * @param sp_PRDTINFVO
	 * @return
	 */
	String btnApproval(SP_PRDTINFVO sp_PRDTINFVO);
	/**
	 * 프로모션에서 상품 선택 레이어.
	 * @param sp_PRDTINFVO
	 * @return
	 */
	List<SP_PRDTINFVO> selectPrmtProductList(SP_PRDTINFVO sp_PRDTINFVO);
	/**
	 * 옵션 일괄등록
	 * @param sp_OPTINFVO
	 */
	void insertBatchSpOptInf(SP_OPTINFVO sp_OPTINFVO);
	/**
	 * 상품 복제
	 * @param sp_PRDTINFVO
	 */
	String copyProduct(SP_PRDTINFVO sp_PRDTINFVO) throws Exception;

	/**
	 * 상품 승인 전달사항
	 * @param prdtNum
	 * @return
	 */
	String prdtApprMsg(String prdtNum);

	/**
	* 설명 : 옵션 엑셀 일괄등록.
	* 파일명 :
	* 작성일 : 2024-07-08 오후 3:20
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	Map<String, Object> insertExcelSpOption(Workbook workbook, MultipartFile excelUpFile, String deleteOpt, SP_OPTINFVO sp_OPTINFVO) throws IOException;

	/**
	 * 옵션 일괄 수정
	 * @param sp_OPTINFVO
	 * @return
	 */
	int updateBatchSpOptInf(SP_OPTINFVO sp_OPTINFVO);

	/**
	 * 여행사 구분자 리스트
	 * @param sp_OPTINFVO
	 * @return
	 */
	List<SP_OPTINFVO> selectTourDivList(SP_OPTINFVO sp_OPTINFVO);

	/**
	 * 추가옵션 리스트
	 * @param sp_ADDOPTINFVO
	 * @return
	 */
	List<SP_ADDOPTINFVO> selectPrdtAddOptionList(SP_ADDOPTINFVO sp_ADDOPTINFVO);

	/**
	 * 추가옵션 정렬순서 max
	 *
	 * @param sp_ADDOPTINFVO
	 * @return
	 */
	Integer selectAddOptInfMaxViewSn(SP_ADDOPTINFVO sp_ADDOPTINFVO);
	/**
	 * 추가옵션 노출순번 증가
	 * @param sp_ADDOPTINFVO
	 */
	void addAddOptViewSn(SP_ADDOPTINFVO sp_ADDOPTINFVO);

	/**
	 * 추가옵션 등록
	 * @param sp_ADDOPTINFVO
	 */
	void insertSpAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO);

	/**
	 * 추가옵션 정보
	 * @param sp_ADDOPTINFVO
	 * @return
	 */
	SP_ADDOPTINFVO selectSpAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO);

	/**
	 * 추가옵션 노출순번 감소
	 * @param oldVO
	 */
	void minusAddOptViewSn(SP_ADDOPTINFVO oldVO);

	/**
	 * 추가옵션 수정
	 * @param sp_ADDOPTINFVO
	 */
	void updateSpAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO);

	/**
	 * 추가옵션 삭제
	 * @param sp_ADDOPTINFVO
	 */
	void deleteAddOptInf(SP_ADDOPTINFVO sp_ADDOPTINFVO);

	/**
	 * 상품 승인 관리
	 * @param sp_PRDTINFVO
	 */
	void updateSpTradeStatus(SP_PRDTINFVO sp_PRDTINFVO);

	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오후 4:19:21
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	Integer checkExsistPrdt(RSVSVO rsvSVO);


	/**
	 * 상품 상세정보 단건 조회
	 * 파일명 : selectDtlInf
	 * 작성일 : 2017. 8. 10. 오후 2:19:30
	 * 작성자 : 신우섭
	 * @param sp_DTLINFVO
	 * @return
	 */
	SP_DTLINFVO selectDtlInf(SP_DTLINFVO sp_DTLINFVO);


	/**
	 * 상품 상세정보 조회
	 * 파일명 : selectDtlInfList
	 * 작성일 : 2017. 8. 10. 오후 2:19:57
	 * 작성자 : 신우섭
	 * @param sp_DTLINFVO
	 * @return
	 */
	List<SP_DTLINFVO> selectDtlInfList(SP_DTLINFVO sp_DTLINFVO);

	String insertDtlInf(SP_DTLINFVO sp_DTLINFVO);
	Integer getDtlInfMaxSN(SP_DTLINFVO sp_DTLINFVO);

	void updateDtlInf(SP_DTLINFVO sp_DTLINFVO);
	void addViewSnDtlInf(SP_DTLINFVO sp_DTLINFVO);
	void minusViewSnDtlInf(SP_DTLINFVO sp_DTLINFVO);

	void deleteDtlInf(SP_DTLINFVO sp_DTLINFVO);



	/**
	 * 상품 상세정보 아이템 조회
	 * 파일명 : selectDtlInfItemList
	 * 작성일 : 2017. 8. 10. 오후 2:20:27
	 * 작성자 : 신우섭
	 * @param sp_DTLINF_ITEMVO
	 * @return
	 */
	List<SP_DTLINF_ITEMVO> selectDtlInfItemList(SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO);

	void insetDtlInfItem(SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO);

	void deleteDtlInfItem(SP_DTLINF_ITEMVO sp_DTLINF_ITEMVO);


	/**
	 * 상품 안내사항
	 * 파일명 : selectGuidinfo
	 * 작성일 : 2017. 8. 11. 오전 10:43:05
	 * 작성자 : 신우섭
	 * @param sp_GUIDINFOVO
	 * @return
	 */
	SP_GUIDINFOVO selectGuidinfo(SP_GUIDINFOVO sp_GUIDINFOVO);
	void updateGuidinfo(SP_GUIDINFOVO sp_GUIDINFOVO);
	void updateGuidinfoBgColor(SP_GUIDINFOVO sp_GUIDINFOVO);
	
	/**
	 * 마라톤 신청인원 리스트
	 * 파일명 : selectMrtnUserList
	 * 작성일 : 2023. 12. 04. 오후 14:17:15
	 * 작성자 : 
	 * @param MRTNVO
	 * @return
	 */
	List<MRTNVO> selectMrtnUserList(MRTNVO mrtnSVO);
	
	/**
	 * 마라톤 신청인원 정보수정
	 * 파일명 : mrtnUserUpdate
	 * 작성일 : 2023. 12. 04. 오후 16:36:15
	 * 작성자 : 
	 * @param MRTNVO
	 * @return
	 */
	void mrtnUserUpdate(MRTNVO mrtnVO);
	
	/**
	 * 마라톤 티셔츠정보
	 * 파일명 : selectMrtnTshirts
	 * 작성일 : 2024. 2. 13. 오후 14:26:15
	 * 작성자 : 
	 * @param MRTNVO
	 * @return
	 */
	MRTNVO selectMrtnTshirts(MRTNVO mrtnSVO);
	
	/**
	 * 마라톤 수량생성
	 * 파일명 : insertTshirts
	 * 작성일 : 2024. 2. 13. 오후 14:26:15
	 * 작성자 : 
	 * @param MRTNVO
	 * @return
	 */
	void insertTshirts(MRTNVO mrtnVO);
	
	/**
	 * 마라톤 수량수정
	 * 파일명 : mrtnTshirtsUpdate
	 * 작성일 : 2024. 2. 13. 오후 14:26:15
	 * 작성자 : 
	 * @param MRTNVO
	 * @return
	 */
	void mrtnTshirtsUpdate(MRTNVO mrtnVO);
}