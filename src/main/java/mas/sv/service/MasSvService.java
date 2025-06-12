package mas.sv.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import web.order.vo.RSVSVO;
import mas.sp.vo.SP_DIVINFVO;
import mas.sv.vo.SV_ADDOPTINFVO;
import mas.sv.vo.SV_CORPDLVAMTVO;
import mas.sv.vo.SV_DFTINFVO;
import mas.sv.vo.SV_DIVINFVO;
import mas.sv.vo.SV_OPTINFVO;
import mas.sv.vo.SV_PRDTINFSVO;
import mas.sv.vo.SV_PRDTINFVO;

public interface MasSvService {

	/**
	 * 상품 리스트
	 * @param sv_PRDTINFSVO
	 * @return
	 */
	Map<String, Object> selectPrdtList(SV_PRDTINFSVO sv_PRDTINFSVO);

	/**
	 * 상품 등록
	 * @param sv_PRDTINFVO
	 * @param fileList
	 * @return
	 */
	String insertSvPrdtInf(SV_PRDTINFVO sv_PRDTINFVO, String fileList) throws Exception ;

	/**
	 * 상품 상세
	 * @param sv_PRDTINFVO
	 * @return
	 */
	SV_PRDTINFVO selectBySvPrdtInf(SV_PRDTINFVO sv_PRDTINFVO);

	/**
	 * 상품 승인전달사항
	 * @param prdtNum
	 * @return
	 */
	String prdtApprMsg(String prdtNum);

	/**
	 * 상품 거래상태
	 * @param resultVO
	 * @return
	 */
	Object btnApproval(SV_PRDTINFVO resultVO);

	/**
	 * 상품 수정
	 * @param sv_PRDTINFVO
	 * @param multiRequest
	 */
	void updateSvPrdtInf(SV_PRDTINFVO sv_PRDTINFVO);
	void updateSvPrdtInfData(SV_PRDTINFVO sv_PRDTINFVO);
	void salePrintN(SV_PRDTINFVO sv_PRDTINFVO);

	/**
	 * 옵션 삭제
	 * @param sp_OPTINFVO
	 */
	void deleteSvOptInf(SV_OPTINFVO sp_OPTINFVO);

	/**
	 * 구분자 삭제
	 * @param sp_DIVINFVO
	 */
	void deleteSvDivInf(SV_DIVINFVO sp_DIVINFVO);

	/**
	 * 상품 삭제
	 * @param sv_PRDTINFVO
	 */
	void deleteSvPrdtInf(SV_PRDTINFVO sv_PRDTINFVO);

	/**
	 * 상품 구분자별 옵션 전체 리스트
	 * @param sv_OPTINFVO
	 * @return
	 */
	List<SV_OPTINFVO> selectPrdtOptionList(SV_OPTINFVO sv_OPTINFVO);

	/**
	 * 구분자 리스트
	 * @param sv_OPTINFVO
	 * @return
	 */
	List<SV_OPTINFVO> selectDivList(SV_OPTINFVO sv_OPTINFVO);

	/**
	 * 구분자 정보 가져오기.
	 * @param sv_DIVINFVO
	 * @return
	 */
	SV_DIVINFVO selectSvDivInf(SV_DIVINFVO sv_DIVINFVO);

	/**
	 * 구분자 최대 정렬순서 가져오기
	 * @param sv_DIVINFVO
	 * @return
	 */
	Integer selectDivInfMaxViewSn(SV_DIVINFVO sv_DIVINFVO);

	/**
	 * 구분자 정렬순서 증가
	 * @param sv_DIVINFVO
	 */
	void addDivViewSn(SV_DIVINFVO sv_DIVINFVO);

	/**
	 * 구분자 정렬순서 감소
	 * @param oldVO
	 */
	void minusDivViewSn(SV_DIVINFVO oldVO);

	/**
	 * 구분자 등록
	 * @param sv_DIVINFVO
	 */
	void insertSvDivInf(SV_DIVINFVO sv_DIVINFVO);


	void insertSvDivInf2(SV_DIVINFVO sv_DIVINFVO);

	/**
	 * 구분자 수정
	 * @param sv_DIVINFVO
	 */
	void updateSvDivInf(SV_DIVINFVO sv_DIVINFVO);

	/**
	 * 옵션 최대 정렬순서 가져오기
	 * @param sv_OPTINFVO
	 * @return
	 */
	Integer selectOptInfMaxViewSn(SV_OPTINFVO sv_OPTINFVO);

	/**
	 * 옵션 순번 증가
	 * @param sv_OPTINFVO
	 */
	void addOptViewSn(SV_OPTINFVO sv_OPTINFVO);

	/**
	 * 옵션 순번 감소
	 * @param oldVO
	 */
	void minusOptViewSn(SV_OPTINFVO oldVO);

	/**
	 * 옵션 등록
	 * @param sv_OPTINFVO
	 */
	void insertOptInf(SV_OPTINFVO sv_OPTINFVO);

	/**
	 * 옵션 정보 가져오기
	 * @param sv_OPTINFVO
	 * @return
	 */

	SV_OPTINFVO selectSvOptInf(SV_OPTINFVO sv_OPTINFVO);

	/**
	 * 옵션 정보 수정
	 * @param sv_OPTINFVO
	 */
	void updateSvOptInf(SV_OPTINFVO sv_OPTINFVO);

	/**
	 * 추가옵션 최대 정렬순서
	 * @param sv_ADDOPTINFVO
	 * @return
	 */
	Integer selectAddOptInfMaxViewSn(SV_ADDOPTINFVO sv_ADDOPTINFVO);


	/**
	 * 추가옵션 리스트
	 * @param sv_ADDOPTINFVO
	 * @return
	 */
	List<SV_ADDOPTINFVO> selectPrdtAddOptionList(SV_ADDOPTINFVO sv_ADDOPTINFVO);

	/**
	 * 추가옵션 순번 증가
	 * @param sv_ADDOPTINFVO
	 */
	void addAddOptViewSn(SV_ADDOPTINFVO sv_ADDOPTINFVO);

	/**
	 * 추가옵션 등록
	 * @param sv_ADDOPTINFVO
	 */
	void insertSvAddOptInf(SV_ADDOPTINFVO sv_ADDOPTINFVO);

	/**
	 * 추가옵션 정보 가져오기.
	 * @param sv_ADDOPTINFVO
	 * @return
	 */
	SV_ADDOPTINFVO selectSvAddOptInf(SV_ADDOPTINFVO sv_ADDOPTINFVO);

	/**
	 * 추가옵션 순번 감소
	 * @param oldVO
	 */
	void minusAddOptViewSn(SV_ADDOPTINFVO oldVO);

	/**
	 * 추가 옵션 수정
	 * @param sv_ADDOPTINFVO
	 */
	void updateSvAddOptInf(SV_ADDOPTINFVO sv_ADDOPTINFVO);

	/**
	 * 추가옵션 삭제
	 * @param sv_ADDOPTINFVO
	 */
	void deleteAddOptInf(SV_ADDOPTINFVO sv_ADDOPTINFVO);

	/**
	 * 현재 판매중인 상품 리스트
	 * @param sv_PRDTINFVO
	 * @return
	 */
	List<SV_PRDTINFVO> selectSvPrdtSaleList(SV_PRDTINFVO sv_PRDTINFVO);

	/**
	 * 재고관리 리스트
	 * @param sv_PRDTINFVO
	 * @return
	 */
	List<SV_OPTINFVO> selectStockList(SV_PRDTINFVO sv_PRDTINFVO);

	/**
	 * 판매 종료
	 * @param sv_OPTINFVO
	 */
	void updateDdlYn(SV_OPTINFVO sv_OPTINFVO);

	/**
	 * 프로모션 상품 리스트
	 * @param sv_PRDTINFVO
	 * @return
	 */
	List<SV_PRDTINFVO> selectPrmtProductList(SV_PRDTINFVO sv_PRDTINFVO);

	/**
	 * 상품 복제
	 * @param sv_PRDTINFVO
	 * @return
	 */
	String copyProduct(SV_PRDTINFVO sv_PRDTINFVO) throws Exception;

	/**
	 * 업체 배송금액
	 * @param corpId
	 * @return
	 */
	SV_CORPDLVAMTVO selectCorpDlvAmt(String corpId);

	/**
	 * 업체 배송비 설정 저장.
	 * @param sv_CORPDLVAMTVO
	 */
	void saveCorpDlvAmt(SV_CORPDLVAMTVO sv_CORPDLVAMTVO);

	/**
	 * 상품 승인(취소)처리
	 * @param sv_PRDTINFVO
	 */
	void updateSvTradeStatus(SV_PRDTINFVO sv_PRDTINFVO);

	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오후 4:27:09
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	Integer checkExsistPrdt(RSVSVO rsvSVO);


	SV_DFTINFVO selectBySvDftinf(SV_DFTINFVO spVO);
	String insertSvDftinf(SV_DFTINFVO spVO);
	void updateSvDftinf(SV_DFTINFVO spVO);

}
