package mas.prmt.service;

import java.util.List;
import java.util.Map;

import mas.prmt.vo.MAINPRMTVO;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import oss.etc.vo.FILESVO;
import oss.marketing.vo.EVNTINFSVO;
import oss.marketing.vo.EVNTINFVO;
import oss.prmt.vo.PRMTFILEVO;

public interface MasPrmtService {

	Map<String, Object> selectPrmtList(PRMTVO prmtVO);

	Map<String, Object> selectPrmtListOss(PRMTVO prmtVO);

	Map<String, Object> selectPrmtListFind(PRMTVO prmtVO);

	Integer getCntPrmtMain(PRMTVO prmtVO);

	Integer getCntPrmtOssMain(PRMTVO prmtVO);

	String insertPromotion(PRMTVO prmtVO, MultipartHttpServletRequest multiRequest, String type) throws Exception;

//	String insertPromotionOss(PRMTVO prmtVO, MultipartHttpServletRequest multiRequest) throws Exception;

	void insertPrmtPrdt(PRMTVO prmtVO);

	void insertPrmtPrdtOne(PRMTVO prmtVO);

	void insertPrmtPrdt(PRMTPRDTVO prmtPrdtVO);


	/**
	 * 프로모션 상품의 출력 순서 수정
	 * Function : updatePrmtPrdtSort
	 * 작성일 : 2017. 7. 7. 오후 5:37:22
	 * 작성자 : 정동수
	 * @param prmtPrdtVO
	 */
	void updatePrmtPrdtSort(PRMTPRDTVO prmtPrdtVO);

	PRMTVO selectByPrmt(PRMTVO prmtVO);

	List<PRMTPRDTVO> selectPrmtPrdtList(PRMTVO prmtVO);
	List<PRMTPRDTVO> selectPrmtPrdtListOss(PRMTVO prmtVO);

	void updatePromotion(PRMTVO prmtVO, MultipartHttpServletRequest multiRequest, String type) throws Exception ;

	void deletePrmtPrdt(String prmtNum);

	void updatePrmtStatusCd(PRMTVO prmtVO);

	void deletePromotion(PRMTVO prmtVO);


	List<MAINPRMTVO> selectMainPrmtFromPrmtNum(MAINPRMTVO mainPrmtVO);

	List<MAINPRMTVO> selectMainPrmt(MAINPRMTVO mainPrmtVO);

	List<MAINPRMTVO> selectMainPrmtMain(MAINPRMTVO mainPrmtVO);
	
	MAINPRMTVO selectMainPrmtInfo(MAINPRMTVO mainPrmtVO);

	void addPrintSn(MAINPRMTVO mainPrmtVO);

	void minusPrintSn(MAINPRMTVO mainPrmtVO);

	void updateDtlPrintSn(MAINPRMTVO mainPrmtVO);

	void insertMainPrmt(MAINPRMTVO mainPrmtVO);

	void deleteMainPrmt(MAINPRMTVO mainPrmtVO);

	/**
	 * 기념품 프로모션
	 * 파일명 : selectSvPrmt
	 * 작성일 : 2017. 2. 16. 오후 1:39:50
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 * @return
	 */
	List<MAINPRMTVO> selectSvPrmt(MAINPRMTVO mainPrmtVO);
	
	/**
	 * 기념품 프로모션 웹 출력
	 * Function : selectSvPrmtWeb
	 * 작성일 : 2018. 1. 8. 오전 10:14:22
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	List<MAINPRMTVO> selectSvPrmtWeb(MAINPRMTVO mainPrmtVO);
	
	/**
	 * 기념품 프로모션 정보
	 * Function : selectSvPrmtInfo
	 * 작성일 : 2018. 1. 11. 오전 10:14:20
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	MAINPRMTVO selectSvPrmtInfo(MAINPRMTVO mainPrmtVO);

	/**
	 * 기념품 프로모션 삭제
	 * 파일명 : deleteSvPrmt
	 * 작성일 : 2017. 2. 16. 오후 1:55:13
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	void deleteSvPrmt(MAINPRMTVO mainPrmtVO);

	/**
	 * 기념품 프로모션 조회
	 * 파일명 : selectSvPrmtFromPrmtNum
	 * 작성일 : 2017. 2. 16. 오후 2:05:37
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 * @return
	 */
	List<MAINPRMTVO> selectSvPrmtFromPrmtNum(MAINPRMTVO mainPrmtVO);

	/**
	 * 기념품 프로모션 등록
	 * 파일명 : insertSvPrmt
	 * 작성일 : 2017. 2. 16. 오후 2:09:46
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	void insertSvPrmt(MAINPRMTVO mainPrmtVO);

	/**
	 * 기념품 프로모션 순번 변경
	 * 파일명 : updateDtlPrintSv
	 * 작성일 : 2017. 2. 16. 오후 2:17:18
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	void updateDtlPrintSv(MAINPRMTVO mainPrmtVO);
	
	/**
	 * 순번 증가
	 * 파일명 : addPrintMw
	 * 작성일 : 2017. 2. 16. 오후 2:34:36
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	void addPrintSv(MAINPRMTVO mainPrmtVO);

	/**
	 * 순번 감소
	 * 파일명 : minusPrintSv
	 * 작성일 : 2017. 2. 16. 오후 2:35:22
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	void minusPrintSv(MAINPRMTVO mainPrmtVO);
	
	/**
	 * 모바일 프로모션
	 * 파일명 : selectMwPrmt
	 * 작성일 : 2017. 12. 21. 오후 1:39:50
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	List<MAINPRMTVO> selectMwPrmt(MAINPRMTVO mainPrmtVO);
	
	/**
	 * 모바일 프로모션 정보
	 * Function : selectMwPrmtInfo
	 * 작성일 : 2018. 1. 11. 오전 10:19:21
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	MAINPRMTVO selectMwPrmtInfo(MAINPRMTVO mainPrmtVO);

	/**
	 * 모바일 프로모션 삭제
	 * 파일명 : deleteMwPrmt
	 * 작성일 : 2017. 12. 21. 오후 1:55:13
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	void deleteMwPrmt(MAINPRMTVO mainPrmtVO);

	/**
	 * 모바일 프로모션 조회
	 * 파일명 : selectMwPrmtFromPrmtNum
	 * 작성일 : 2017. 12. 21. 오후 2:05:37
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	List<MAINPRMTVO> selectMwPrmtFromPrmtNum(MAINPRMTVO mainPrmtVO);

	/**
	 * 모바일 프로모션 등록
	 * 파일명 : insertMwPrmt
	 * 작성일 : 2017. 12. 21. 오후 2:09:46
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	void insertMwPrmt(MAINPRMTVO mainPrmtVO);

	/**
	 * 모바일 프로모션 순번 변경
	 * 파일명 : updateDtlPrintMw
	 * 작성일 : 2017. 12. 21. 오후 2:17:18
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	void updateDtlPrintMw(MAINPRMTVO mainPrmtVO);

	/**
	 * 모바일 프로모션 순번 증가
	 * 파일명 : addPrintMw
	 * 작성일 : 2017. 12. 22. 오후 2:34:36
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	void addPrintMw(MAINPRMTVO mainPrmtVO);

	/**
	 * 모바일 프로모션 순번 감소
	 * 파일명 : minusPrintSv
	 * 작성일 : 2017. 12. 22. 오후 2:35:22
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	void minusPrintMw(MAINPRMTVO mainPrmtVO);

	/**
	 * 이벤트 정보 리스트 조회
	 * 파일명 : selectEvntInfListOss
	 * 작성일 : 2017. 3. 9. 오후 3:30:57
	 * 작성자 : 최영철
	 * @param evntInfSVO
	 * @return
	 */
	Map<String, Object> selectEvntInfListOss(EVNTINFSVO evntInfSVO);

	/**
	 * 이벤트 정보 등록
	 * 파일명 : insertEvntInf
	 * 작성일 : 2017. 3. 10. 오후 2:42:05
	 * 작성자 : 최영철
	 * @param evntInfVO
	 */
	void insertEvntInf(EVNTINFVO evntInfVO);

	/**
	 * 이벤트 정보 단건 조회
	 * 파일명 : selectByEvntInf
	 * 작성일 : 2017. 3. 10. 오후 3:33:21
	 * 작성자 : 최영철
	 * @param evntInfVO
	 * @return
	 */
	EVNTINFVO selectByEvntInf(EVNTINFVO evntInfVO);

	void updateEvntInf(EVNTINFVO evntInfVO);


	/**
	 * 이벤트 정보 삭제
	 * 파일명 : deleteEvntInf
	 * 작성일 : 2017. 3. 10. 오후 5:34:01
	 * 작성자 : 최영철
	 * @param evntInfVO
	 */
	void deleteEvntInf(EVNTINFVO evntInfVO);


	List<PRMTFILEVO> selectPrmtFileList(PRMTFILEVO prmtfileVO);
	PRMTFILEVO selectPrmtFile(PRMTFILEVO prmtfileVO);
	void deletePrmtFile(String prmtFileNum);
	void deletePrmtFileAll(String prmtNum);
	
	void deletePrmtCmtAll(String prmtNum);

	Map<String, Object> selectFileList(FILESVO fileSVO);

	/**
	* 설명 : 메인 프로모션 순번을 랜덤으로 변경
	* 파일명 : updatePrmtSnRandom
	* 작성일 : 2022-03-31 오후 5:44
	* 작성자 : chaewan.jung
	* @param : MAINPRMTVO
	* @return : void
	* @throws Exception
	*/
	void updatePrmtSnRandom(MAINPRMTVO mainPrmtVO);
}