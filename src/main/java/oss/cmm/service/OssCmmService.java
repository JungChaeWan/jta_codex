package oss.cmm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.cmm.vo.*;
import oss.corp.vo.CMSSPGVO;
import oss.corp.vo.CMSSVO;
import oss.corp.vo.CORPVO;
import oss.etc.vo.FILESVO;
import oss.prdt.vo.PRDTVO;


public interface OssCmmService {

	/**
	 * 업체 추가정보가 있는 확인(Y : 존재, N : 존재하지 않음)
	 * 파일명 : corpDtlInfoChk
	 * 작성일 : 2015. 9. 21. 오후 6:49:20
	 * 작성자 : 최영철
	 * @param corpSVO
	 * @return
	 */
	String corpDtlInfoChk(CORPVO corpVO);

	/**
	 * 코드 리스트 조회
	 * 파일명 : selectCodeList
	 * 작성일 : 2015. 9. 23. 오전 8:57:19
	 * 작성자 : 최영철
	 * @param cdSVO
	 * @return
	 */
	Map<String, Object> selectCodeList(CDSVO cdSVO);

	/**
	 * 코드 등록
	 * 파일명 : insertCode
	 * 작성일 : 2015. 9. 23. 오후 1:28:52
	 * 작성자 : 최영철
	 * @param cdVO
	 */
	void insertCode(CDVO cdVO);

	/**
	 * 최상위 코드 전체 조회(사용여부가 'Y' 인것만)
	 * 파일명 : selectHrkCodeList
	 * 작성일 : 2015. 9. 23. 오후 1:40:57
	 * 작성자 : 최영철
	 * @return
	 */
	List<CDVO> selectHrkCodeList();

	/**
	 * 코드 단건 조회
	 * 파일명 : selectByCd
	 * 작성일 : 2015. 9. 23. 오후 2:25:27
	 * 작성자 : 최영철
	 * @param cdVO
	 * @return
	 */
	CDVO selectByCd(CDVO cdVO);

	/**
	 * 코드 수정
	 * 파일명 : updateCode
	 * 작성일 : 2015. 9. 23. 오후 2:55:46
	 * 작성자 : 최영철
	 * @param cdVO
	 */
	void updateCode(CDVO cdVO);

	/**
	 * 노출 순번 최대 값 구하기
	 * 파일명 : selectByMaxViewSn
	 * 작성일 : 2015. 9. 23. 오후 4:51:15
	 * 작성자 : 최영철
	 * @param cdVO
	 * @return
	 */
	Integer selectByMaxViewSn(CDVO cdVO);

	/**
	 * 노출 순번 일괄 증가
	 * 파일명 : addViewSn
	 * 작성일 : 2015. 9. 23. 오후 5:03:04
	 * 작성자 : 최영철
	 * @param oldVO
	 */
	void addViewSn(CDVO oldVO);

	/**
	 * 노출 순번 일괄 감소
	 * 파일명 : minusViewSn
	 * 작성일 : 2015. 9. 23. 오후 5:11:43
	 * 작성자 : 최영철
	 * @param oldVO
	 */
	void minusViewSn(CDVO oldVO);

	/**
	 * 코드 삭제
	 * 파일명 : deleteCode
	 * 작성일 : 2015. 9. 25. 오후 1:46:03
	 * 작성자 : 최영철
	 * @param cdVO
	 */
	void deleteCode(CDVO cdVO);


	/**
	 * 상위 코드에 대한 하위 코드 조회
	 * 파일명 : selectCode
	 * 작성일 : 2015. 10. 1. 오후 7:48:49
	 * 작성자 : 최영철
	 * @param corpCd
	 * @return
	 */
	List<CDVO> selectCode(String corpCd);

	/**
	 * 연계 번호에 대한 이미지 리스트 조회
	 * 파일명 : selectImgList
	 * 작성일 : 2015. 10. 7. 오후 5:24:51
	 * 작성자 : 최영철
	 * @param imgVO
	 * @return
	 */
	List<CM_IMGVO> selectImgList(CM_IMGVO imgVO);

	/**
	 * 이미지 순번 증가
	 * 파일명 : addImgSn
	 * 작성일 : 2015. 10. 7. 오후 7:38:09
	 * 작성자 : 최영철
	 * @param imgVO
	 */
	void addImgSn(CM_IMGVO imgVO);

	/**
	 * 이미지 순번 감소
	 * 파일명 : minusImgSn
	 * 작성일 : 2015. 10. 7. 오후 7:44:06
	 * 작성자 : 최영철
	 * @param imgVO
	 */
	void minusImgSn(CM_IMGVO imgVO);

	/**
	 * 이미지 순번 변경
	 * 파일명 : updateImgSn
	 * 작성일 : 2015. 10. 7. 오후 7:47:27
	 * 작성자 : 최영철
	 * @param imgVO
	 */
	void updateImgSn(CM_IMGVO imgVO);

	/**
	 * 이미지 정보 조회
	 * 파일명 : selectByPrdtImg
	 * 작성일 : 2015. 10. 7. 오후 8:53:05
	 * 작성자 : 최영철
	 * @param imgVO
	 * @return
	 */
	CM_IMGVO selectByPrdtImg(CM_IMGVO imgVO);

	/**
	 * 이미지 정보 삭제
	 * 파일명 : deletePrdtImg
	 * 작성일 : 2015. 10. 7. 오후 8:59:24
	 * 작성자 : 최영철
	 * @param imgVO
	 * @throws Exception
	 */
	void deletePrdtImg(CM_IMGVO imgVO) throws Exception;

	/**
	 * 이미지 정보 삭제 - 상품번호기준 전체삭제.
	 * 파일명 : deletePrdtImg
	 * 작성일 : 2015. 10. 7. 오후 8:59:24
	 * 작성자 : 최영철
	 * @param imgVO
	 * @throws Exception
	 */
	void deletePrdtImgList(CM_IMGVO imgVO) throws Exception;

	/**
	 * 이미지 정보 등록
	 * 파일명 : insertPrdtimg
	 * 작성일 : 2015. 10. 8. 오전 10:13:18
	 * 작성자 : 최영철
	 * @param imgVO
	 * @param multiRequest
	 * @throws Exception
	 */
	void insertPrdtimg(CM_IMGVO imgVO, MultipartHttpServletRequest multiRequest) throws Exception;

	/**
	 * 공통 승인내역 INSERT
	 * @param confhistVO
	 */
	void insertCmConfhist(CM_CONFHISTVO confhistVO);

	/**
	 * 상세 이미지 목록
	 * 파일명 : selectDtlImgList
	 * 작성일 : 2015. 10. 20. 오후 5:45:56
	 * 작성자 : 신우섭
	 * @param imgVO
	 * @return
	 */
	List<CM_DTLIMGVO> selectDtlImgList(CM_DTLIMGVO imgVO);

	CM_DTLIMGVO selectByPrdtDtlImg(CM_DTLIMGVO imgVO);

	void insertPrdtDtlimg(CM_DTLIMGVO imgVO, MultipartHttpServletRequest multiRequest) throws Exception;

	void addDtlImgSn(CM_DTLIMGVO imgVO);

	void minusDtlImgSn(CM_DTLIMGVO imgVO);

	void updateDtlImgSn(CM_DTLIMGVO imgVO);

	void deletePrdtDtlImg(CM_DTLIMGVO imgVO) throws Exception;

	void deletePrdtDtlImgList(CM_DTLIMGVO imgVO) throws Exception;

	void insertPrdtimgCopy(CM_IMGVO imgVO) throws Exception;

	void  insertPrdtDtlimgCopy(CM_DTLIMGVO imgVO) throws Exception;

	String selectConhistByMsg(String prmtNum);

	/**
	 * dext를 이용한 이미지 등록.
	 * @param imgVO
	 * @param fileList
	 */
	void insertPrdtimg(CM_IMGVO imgVO, String fileList)  throws Exception ;

	/**
	 * 주요 정보 insert
	 * @param icon
	 */
	void insertCmIconinf(CM_ICONINFVO icon);

	/**
	 * 주요 정보 select List
	 * @param prdtNum
	 * @return
	 */
	List<CM_ICONINFVO> selectCmIconinf(String prdtNum, String hrkCdNum);

	/**
	 * 렌터카의 자차필수 체크
	 * Function : selectCmIconf
	 * 작성일 : 2016. 12. 8. 오전 11:51:50
	 * 작성자 : 정동수
	 * @param prdtNum
	 * @return
	 */
	int selectCmIconfChkIsr(String prdtNum);

	/**
	 * 주요정보 수정.
	 * @param icon
	 */
	void updateCmIconinf(CM_ICONINFVO icon);

	/**
	 * 주요정보 삭제
	 * @param prdtNum
	 */
	void deleteCmIconinf(String prdtNum);

	/**
	 * 검색어 등록
	 * 파일명 : insertSrchWord
	 * 작성일 : 2016. 7. 27. 오전 11:20:01
	 * 작성자 : 최영철
	 * @param srchWordList
	 */
	void insertSrchWord(List<CM_SRCHWORDVO> srchWordList);



	/**
	 * 검색어 조회
	 * 파일명 : getSrchWord
	 * 작성일 : 2016. 7. 27. 오후 2:43:26
	 * 작성자 : 최영철
	 * @param corpId
	 * @param string
	 * @return
	 */
	String getSrchWord(String corpId, String string);

	/**
	 * 검색어 다중 조회
	 * 파일명 : selectSrchWordList
	 * 작성일 : 2017. 9. 8. 오후 3:11:06
	 * 작성자 : 신우섭
	 * @param corpId
	 * @return
	 */
	List<CM_SRCHWORDVO> selectSrchWordList(String corpId);

	/**
	 * 검색어 처리
	 * 파일명 : insertSrchWord2
	 * 작성일 : 2016. 7. 27. 오후 3:16:19
	 * 작성자 : 최영철
	 * @param srchWordVO
	 */
	void insertSrchWord2(CM_SRCHWORDVO srchWordVO);

	/**
	 * 검색어 통계 추가
	 * 파일명 : mergeSrchWordAnls
	 * 작성일 : 2016. 7. 29. 오후 5:03:11
	 * 작성자 : 최영철
	 * @param search
	 */
	void mergeSrchWordAnls(String search);

    List<ISEARCHVO> selectIsearchWords(ISEARCHVO isearchvo);

	void insertIsearchWords(ISEARCHVO isearchvo);

	void deleteIsearchWords(ISEARCHVO isearchvo);

	/**
	 * 수수료 리스트 조회
	 * 파일명 : selectCmssList
	 * 작성일 : 2016. 8. 10. 오후 5:31:23
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	Map<String, Object> selectCmssList(pageDefaultVO searchVO);

	/**
	 * 수수료 등록
	 * 파일명 : insertCmss
	 * 작성일 : 2016. 8. 11. 오후 1:41:30
	 * 작성자 : 최영철
	 * @param cmssVO
	 */
	void insertCmss(CMSSVO cmssVO);

	/**
	 * 수수료 단건 조회
	 * 파일명 : selectByCmss
	 * 작성일 : 2016. 8. 11. 오후 2:56:23
	 * 작성자 : 최영철
	 * @param cmssVO
	 * @return
	 */
	CMSSVO selectByCmss(CMSSVO cmssVO);

	/**
	 * 수수료 수정
	 * 파일명 : updateCmss
	 * 작성일 : 2016. 8. 11. 오후 3:06:32
	 * 작성자 : 최영철
	 * @param cmssVO
	 */
	void updateCmss(CMSSVO cmssVO);

	/**
	 * B2C 수수료 전체 조회
	 * 파일명 : selectCmssList
	 * 작성일 : 2016. 8. 12. 오전 10:41:19
	 * 작성자 : 최영철
	 * @return
	 */
	List<CMSSVO> selectCmssList();

	/**
	 * 해당 수수료를 사용하고 있는 업체 카운트
	 * 파일명 : deleteChkCmss
	 * 작성일 : 2016. 8. 18. 오후 1:14:23
	 * 작성자 : 최영철
	 * @param cmssVO
	 * @return
	 */
	Integer deleteChkCmss(CMSSVO cmssVO);

	/**
	 * 수수료 삭제
	 * 파일명 : deleteCmss
	 * 작성일 : 2016. 8. 18. 오후 1:22:20
	 * 작성자 : 최영철
	 * @param cmssVO
	 */
	void deleteCmss(CMSSVO cmssVO);

	/**
	 * B2B 수수료 전체 조회
	 * 파일명 : selectB2bCmssList
	 * 작성일 : 2016. 9. 19. 오전 11:40:49
	 * 작성자 : 최영철
	 * @return
	 */
	List<CMSSVO> selectB2bCmssList();

	/**
	 * 모바일 접속 시 접속 기기 확인
	 * Function : getClientType
	 * 작성일 : 2016. 6. 8. 오후 5:02:50
	 * 작성자 : 최영철
	 * @param request
	 * @return
	 */
	String getClientType(HttpServletRequest request);


	Map<String, Object> selectFileList(FILESVO fileSVO);
	
	/**
	 * PG사 수수료 리스트 조회
	 * 파일명 : selectCmssPgList
	 * 작성일 : 2020.10.30
	 * 작성자 : 김지연
	 * @param searchVO
	 * @return
	 */
	Map<String, Object> selectCmssPgList(pageDefaultVO searchVO);
	
	/**
	 * PG사 수수료 등록
	 * 파일명 : insertCmssPg
	 * 작성일 : 2020.11.02
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 */
	void insertCmssPg(CMSSPGVO cmssPgVO);	
	
	/**
	 * PG사 수수료 삭제
	 * 파일명 : deleteCmssPg
	 * 작성일 : 2020.11.02
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 */
	void deleteCmssPg(CMSSPGVO cmssPgVO);	
	
	/**
	 * PG사 수수료 단건 조회
	 * 파일명 : selectByCmssPg
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 * @return
	 */
	CMSSPGVO selectByCmssPg(CMSSPGVO cmssPgVO);	
	
	/**
	 * PG사 수수료 수정
	 * 파일명 : updateCmssPg
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param cmssVO
	 */
	void updateCmssPg(CMSSPGVO cmssPgVO);	
	
	/**
	 * PG사 수수료 날짜 중복 체크
	 * 파일명 : checkAplDt
	 * 작성일 : 2020.11.05
	 * 작성자 : 김지연
	 * @param cmssPgVO
	 * @return
	 */
	Integer checkAplDt(CMSSPGVO cmssPgVO);

	/**
	* 설명 : 상품정보 자동완성기능
	* 파일명 :
	* 작성일 : 2024-10-17 오후 2:10
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	PRDTVO selectPrdtInfo(String prdtNum);

	List<CM_IMGVO> selectSvImgList(CM_IMGVO imgVO);
}
