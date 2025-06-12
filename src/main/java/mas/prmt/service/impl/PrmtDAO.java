package mas.prmt.service.impl;

import java.util.List;

import mas.prmt.vo.MAINPRMTVO;
import mas.prmt.vo.PRMTCMTVO;
import mas.prmt.vo.PRMTPRDTVO;
import mas.prmt.vo.PRMTVO;

import org.springframework.stereotype.Repository;

import oss.etc.vo.FILESVO;
import oss.etc.vo.FILEVO;
import oss.marketing.vo.EVNTINFSVO;
import oss.marketing.vo.EVNTINFVO;
import oss.prmt.vo.GOVAFILEVO;
import oss.prmt.vo.GOVAVO;
import oss.prmt.vo.PRMTFILEVO;
import oss.prmt.vo.PRMTSVO;
import web.mypage.vo.RSVFILEVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("prmtDAO")
public class PrmtDAO  extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<PRMTVO> selectPrmtList(PRMTVO prmtVO) {
		return (List<PRMTVO>) list("PRMT_S_00", prmtVO);
	}

	public Integer getCntPrmtList(PRMTVO prmtVO) {
		return (Integer) select("PRMT_S_01", prmtVO);
	}

	public PRMTVO selectByPrmt(PRMTVO prmtVO) {
		return (PRMTVO) select("PRMT_S_03", prmtVO);
	}

	@SuppressWarnings("unchecked")
	public List<PRMTVO> selectPrmtListFind(PRMTVO prmtVO) {
		return (List<PRMTVO>) list("PRMT_S_08", prmtVO);
	}

	public Integer getCntPrmtListFind(PRMTVO prmtVO) {
		return (Integer) select("PRMT_S_09", prmtVO);
	}


	public Integer getCntPrmtMain(PRMTVO prmtVO) {
		return (Integer) select("PRMT_S_10", prmtVO);
	}

	public Integer getCntPrmtOssMain(PRMTVO prmtVO) {
		return (Integer) select("PRMT_S_11", prmtVO);
	}


	@SuppressWarnings("unchecked")
	public List<PRMTVO> selectPrmtListOss(PRMTVO prmtVO) {
		return (List<PRMTVO>) list("PRMT_S_06", prmtVO);
	}

	public Integer getCntPrmtListOss(PRMTVO prmtVO) {
		return (Integer) select("PRMT_S_07", prmtVO);
	}


	public String insertPromotion(PRMTVO prmtVO) {
		return (String) insert("PRMT_I_00", prmtVO);
	}

	public String insertPromotionOss(PRMTVO prmtVO) {
		return (String) insert("PRMT_I_01", prmtVO);
	}

	public void updatePromotion(PRMTVO prmtVO) {
		update("PRMT_U_00", prmtVO);
	}

	public void updatePromotionOss(PRMTVO prmtVO) {
		update("PRMT_U_02", prmtVO);
	}
	
	public void updateViewCnt(String prmtNum) {
		update("PRMT_U_03", prmtNum);
	}		

	public String getPromotionPk(PRMTVO prmtVO) {
		return (String) select("PRMT_S_02", prmtVO);
	}

	public void insertPrmtPrdt(PRMTVO prmtVO) {
		insert("PRMT_PRDT_I_00", prmtVO);
	}

	public void insertPrmtPrdtOne(PRMTVO prmtVO) {
		insert("PRMT_PRDT_I_01", prmtVO);
	}

	public void insertPrmtPrdt(PRMTPRDTVO prmtPrdtVO) {
		insert("PRMT_PRDT_I_02", prmtPrdtVO);
	}

	/**
	 * 프로모션 상품의 출력 순서 증가
	 * Function : incremntPrmtPrintSn
	 * 작성일 : 2017. 7. 21. 오후 12:16:15
	 * 작성자 : 정동수
	 * @param prmtPrdtVO
	 */
	public void incremntPrmtPrintSn(PRMTPRDTVO prmtPrdtVO) {
		update("PRMT_PRDT_U_00", prmtPrdtVO);
	}

	/**
	 * 프로모션 상품의 출력 순서 감소
	 * Function : downPrmtPrintSn
	 * 작성일 : 2017. 7. 21. 오후 12:16:18
	 * 작성자 : 정동수
	 * @param prmtPrdtVO
	 */
	public void downPrmtPrintSn(PRMTPRDTVO prmtPrdtVO) {
		update("PRMT_PRDT_U_01", prmtPrdtVO);
	}

	/**
	 * 프로모션 상품의 출력 순서 변경
	 * Function : updatePrmtPrintSn
	 * 작성일 : 2017. 7. 21. 오후 12:17:25
	 * 작성자 : 정동수
	 * @param prmtPrdtVO
	 */
	public void updatePrmtPrintSn(PRMTPRDTVO prmtPrdtVO) {
		update("PRMT_PRDT_U_02", prmtPrdtVO);
	}

	@SuppressWarnings("unchecked")
	public List<PRMTPRDTVO> selectPrmtPrdtList(PRMTVO prmtVO) {
		return (List<PRMTPRDTVO>) list("PRMT_PRDT_S_00", prmtVO);
	}

	@SuppressWarnings("unchecked")
	public List<PRMTPRDTVO> selectPrmtPrdtListOss(PRMTVO prmtVO) {
		return (List<PRMTPRDTVO>) list("PRMT_PRDT_S_01", prmtVO);
	}

	public List<PRMTPRDTVO> selectPrmtPrdtList(String prmtNum) {
		return (List<PRMTPRDTVO>) list("PRMT_PRDT_S_02", prmtNum);
	}

	public void deletePrmtPrdt(String prmtNum) {
		delete("PRMT_PRDT_D_00", prmtNum);
	}

	public void updatePrmtStatusCd(PRMTVO prmtVO) {
		update("PRMT_U_01", prmtVO);
	}

	public void deletePromotion(PRMTVO prmtVO) {
		delete("PRMT_D_00", prmtVO);
	}

	@SuppressWarnings("unchecked")
	public List<PRMTVO> selectOssPrmtList(PRMTSVO prmtSVO) {
		return (List<PRMTVO>) list("PRMT_S_04", prmtSVO);
	}

	public Integer getCntOssPrmtList(PRMTSVO prmtSVO) {
		return (Integer) select("PRMT_S_05", prmtSVO);
	}

	@SuppressWarnings("unchecked")
	public List<MAINPRMTVO> selectMainPrmtFromPrmtNum(MAINPRMTVO mainPrmtVO) {
		return (List<MAINPRMTVO>) list("MAIN_PRMT_S_00", mainPrmtVO);
	}

	@SuppressWarnings("unchecked")
	public List<MAINPRMTVO> selectMainPrmt(MAINPRMTVO mainPrmtVO) {
		return (List<MAINPRMTVO>) list("MAIN_PRMT_S_01", mainPrmtVO);
	}

	@SuppressWarnings("unchecked")
	public List<MAINPRMTVO> selectMainPrmtMain(MAINPRMTVO mainPrmtVO) {
		return (List<MAINPRMTVO>) list("MAIN_PRMT_S_02", mainPrmtVO);
	}
	
	public MAINPRMTVO selectMainPrmtInfo(MAINPRMTVO mainPrmtVO) {
		return (MAINPRMTVO) select("MAIN_PRMT_S_03", mainPrmtVO);
	}

	public void insertMainPrmt(MAINPRMTVO mainPrmtVO) {
		insert("MAIN_PRMT_I_01", mainPrmtVO);
	}


	public void addPrintSn(MAINPRMTVO mainPrmtVO) {
		update("MAIN_PRMT_U_01", mainPrmtVO);
	}

	public void minusPrintSn(MAINPRMTVO mainPrmtVO) {
		update("MAIN_PRMT_U_02", mainPrmtVO);
	}

	public void updatePrintSn(MAINPRMTVO mainPrmtVO) {
		update("MAIN_PRMT_U_03", mainPrmtVO);
	}

	public void deleteMainPrmt(MAINPRMTVO mainPrmtVO) {
		delete("MAIN_PRMT_D_00", mainPrmtVO);
	}

	@SuppressWarnings("unchecked")
	public List<PRMTCMTVO> selectPrmtCmtList(PRMTCMTVO prmtCmtVO) {
		return (List<PRMTCMTVO>) list("PRMT_CMT_S_00", prmtCmtVO);
	}

	public int selectPrmtCmtTotalCnt(PRMTCMTVO prmtCmtVO) {
		return (Integer) select("PRMT_CMT_S_01", prmtCmtVO);
	}

	@SuppressWarnings("unchecked")
	public List<PRMTCMTVO> selectPrmtCmtListNopage(PRMTCMTVO prmtCmtVO) {
		return (List<PRMTCMTVO>) list("PRMT_CMT_S_02", prmtCmtVO);
	}

	public void insertPrmtCmt(PRMTCMTVO prmtCmtVO) {
		update("PRMT_CMT_I_00", prmtCmtVO);
	}

	public void updatePrmtCmt(PRMTCMTVO prmtCmtVO) {
		update("PRMT_CMT_U_00", prmtCmtVO);
	}

	public void deletePrmtCmt(PRMTCMTVO prmtCmtVO) {
		delete("PRMT_CMT_D_00", prmtCmtVO);
	}
	
	public void deletePrmtCmtAll(String prmtNum) {
		delete("PRMT_CMT_D_01", prmtNum);
	}

	/**
	 * 기념품 프로모션
	 * 파일명 : selectSvPrmt
	 * 작성일 : 2017. 2. 16. 오후 1:41:14
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRMTVO> selectSvPrmt(MAINPRMTVO mainPrmtVO) {
		return (List<MAINPRMTVO>) list("PRMT_SV_S_01", mainPrmtVO);
	}
	
	/**
	 * 기념품 프로모션 웹
	 * Function : selectSvPrmt
	 * 작성일 : 2018. 1. 8. 오전 10:10:00
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRMTVO> selectSvPrmtWeb(MAINPRMTVO mainPrmtVO) {
		return (List<MAINPRMTVO>) list("PRMT_SV_S_02", mainPrmtVO);
	}
		
	/**
	 * 기념품 프로모션 정보
	 * Function : selectSvPrmtInfo
	 * 작성일 : 2018. 1. 11. 오전 10:14:20
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	public MAINPRMTVO selectSvPrmtInfo(MAINPRMTVO mainPrmtVO) {
		return (MAINPRMTVO) select("PRMT_SV_S_03", mainPrmtVO);
	}

	/**
	 * 기념품 프로모션 삭제
	 * 파일명 : deleteSvPrmt
	 * 작성일 : 2017. 2. 16. 오후 1:55:55
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	public void deleteSvPrmt(MAINPRMTVO mainPrmtVO) {
		delete("PRMT_SV_D_00", mainPrmtVO);
	}

	/**
	 * 기념품 프로모션 조회
	 * 파일명 : selectSvPrmtFromPrmtNum
	 * 작성일 : 2017. 2. 16. 오후 2:06:51
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRMTVO> selectSvPrmtFromPrmtNum(MAINPRMTVO mainPrmtVO) {
		return (List<MAINPRMTVO>) list("PRMT_SV_S_00", mainPrmtVO);
	}

	/**
	 * 기념품 프로모션 등록
	 * 파일명 : insertSvPrmt
	 * 작성일 : 2017. 2. 16. 오후 2:10:30
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	public void insertSvPrmt(MAINPRMTVO mainPrmtVO) {
		insert("PRMT_SV_I_01", mainPrmtVO);
	}

	/**
	 * 기념품 프로모션 순번 변경
	 * 파일명 : updateSvPrintSn
	 * 작성일 : 2017. 2. 16. 오후 2:17:58
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	public void updatePrintSv(MAINPRMTVO mainPrmtVO) {
		update("PRMT_SV_U_03", mainPrmtVO);
	}

	/**
	 * 기념품 프로모션 순번 증가
	 * 파일명 : addPrintSv
	 * 작성일 : 2017. 2. 16. 오후 2:36:03
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	public void addPrintSv(MAINPRMTVO mainPrmtVO) {
		update("PRMT_SV_U_01", mainPrmtVO);
	}

	/**
	 * 기념품 프로모션 순번 감소
	 * 파일명 : minusPrintSv
	 * 작성일 : 2017. 2. 16. 오후 2:36:47
	 * 작성자 : 최영철
	 * @param mainPrmtVO
	 */
	public void minusPrintSv(MAINPRMTVO mainPrmtVO) {
		update("PRMT_SV_U_02", mainPrmtVO);
	}
	
	/**
	 * 모바일 프로모션
	 * 파일명 : selectMwPrmt
	 * 작성일 : 2017. 12. 22. 오후 1:41:14
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRMTVO> selectMwPrmt(MAINPRMTVO mainPrmtVO) {
		return (List<MAINPRMTVO>) list("PRMT_MW_S_01", mainPrmtVO);
	}
	
	/**
	 * 모바일 프로모션 정보
	 * Function : selectMwPrmtInfo
	 * 작성일 : 2018. 1. 11. 오전 10:19:21
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	public MAINPRMTVO selectMwPrmtInfo(MAINPRMTVO mainPrmtVO) {
		return (MAINPRMTVO) select("PRMT_MW_S_03", mainPrmtVO);
	}

	/**
	 * 모바일 프로모션 삭제
	 * 파일명 : deleteMwPrmt
	 * 작성일 : 2017. 12. 22. 오후 1:55:55
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	public void deleteMwPrmt(MAINPRMTVO mainPrmtVO) {
		delete("PRMT_MW_D_00", mainPrmtVO);
	}

	/**
	 * 모바일 프로모션 조회
	 * 파일명 : selectMwPrmtFromPrmtNum
	 * 작성일 : 2017. 12. 22. 오후 2:06:51
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MAINPRMTVO> selectMwPrmtFromPrmtNum(MAINPRMTVO mainPrmtVO) {
		return (List<MAINPRMTVO>) list("PRMT_MW_S_00", mainPrmtVO);
	}

	/**
	 * 모바일 프로모션 등록
	 * 파일명 : insertMwPrmt
	 * 작성일 : 2017. 12. 22. 오후 2:10:30
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	public void insertMwPrmt(MAINPRMTVO mainPrmtVO) {
		insert("PRMT_MW_I_01", mainPrmtVO);
	}

	/**
	 * 모바일 프로모션 순번 변경
	 * 파일명 : updateMwPrintSn
	 * 작성일 : 2017. 12. 22. 오후 2:17:58
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	public void updatePrintMw(MAINPRMTVO mainPrmtVO) {
		update("PRMT_MW_U_03", mainPrmtVO);
	}
	
	/**
	 * 모바일 프로모션 순번 증가
	 * 파일명 : addPrintMw
	 * 작성일 : 2017. 12. 22. 오후 2:36:03
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	public void addPrintMw(MAINPRMTVO mainPrmtVO) {
		update("PRMT_MW_U_01", mainPrmtVO);
	}

	/**
	 * 모바일 프로모션 순번 감소
	 * 파일명 : minusPrintMw
	 * 작성일 : 2017. 12. 22. 오후 2:36:47
	 * 작성자 : 정동수
	 * @param mainPrmtVO
	 */
	public void minusPrintMw(MAINPRMTVO mainPrmtVO) {
		update("PRMT_MW_U_02", mainPrmtVO);
	}

	/**
	 * 이벤트 정보 리스트 조회
	 * 파일명 : selectEvntInfListOss
	 * 작성일 : 2017. 3. 9. 오후 3:31:45
	 * 작성자 : 최영철
	 * @param evntInfSVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<EVNTINFVO> selectEvntInfListOss(EVNTINFSVO evntInfSVO) {
		return (List<EVNTINFVO>) list("EVNTINF_S_01", evntInfSVO);
	}

	/**
	 * 이벤트 정보 카운트
	 * 파일명 : selectEvntInfListCnt
	 * 작성일 : 2017. 3. 9. 오후 3:33:17
	 * 작성자 : 최영철
	 * @param evntInfSVO
	 * @return
	 */
	public Integer selectEvntInfListCnt(EVNTINFSVO evntInfSVO) {
		return (Integer) select("EVNTINF_S_02", evntInfSVO);
	}

	/**
	 * 이벤트 정보 등록
	 * 파일명 : insertEvntInf
	 * 작성일 : 2017. 3. 10. 오후 2:42:54
	 * 작성자 : 최영철
	 * @param evntInfVO
	 */
	public void insertEvntInf(EVNTINFVO evntInfVO) {
		insert("EVNTINF_I_00", evntInfVO);
	}

	/**
	 * 이벤트 정보 단건 조회
	 * 파일명 : selectByEvntInf
	 * 작성일 : 2017. 3. 10. 오후 3:34:04
	 * 작성자 : 최영철
	 * @param evntInfVO
	 * @return
	 */
	public EVNTINFVO selectByEvntInf(EVNTINFVO evntInfVO) {
		return (EVNTINFVO) select("EVNTINF_S_00", evntInfVO);
	}

	/**
	 * 이벤트 정보 삭제
	 * 파일명 : deleteEvntInf
	 * 작성일 : 2017. 3. 10. 오후 5:34:40
	 * 작성자 : 최영철
	 * @param evntInfVO
	 */
	public void deleteEvntInf(EVNTINFVO evntInfVO) {
		delete("EVNTINF_D_00", evntInfVO);
	}

	public void updateEvntInf(EVNTINFVO evntInfVO) {
		delete("EVNTINF_U_00", evntInfVO);
	}

	/**
	 * 이벤트 코드 확인
	 * 파일명 : evntCdConfirm
	 * 작성일 : 2017. 3. 13. 오전 10:25:01
	 * 작성자 : 최영철
	 * @param evntInfVO
	 * @return
	 */
	public EVNTINFVO evntCdConfirm(EVNTINFVO evntInfVO) {
		return (EVNTINFVO) select("EVNTINF_S_03", evntInfVO);
	}



	/**
	 * 프로모션 첨부 파일 목록
	 * 파일명 : selectPrmtFileList
	 * 작성일 : 2017. 8. 3. 오전 11:17:57
	 * 작성자 : 신우섭
	 * @param prmtfileVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<PRMTFILEVO> selectPrmtFileList(PRMTFILEVO prmtfileVO) {
		return (List<PRMTFILEVO>) list("PRMT_FILE_S_00", prmtfileVO);
	}

	/**
	 * 프로모션 첨부파일 단일 조회
	 * 파일명 : selectPrmtFile
	 * 작성일 : 2017. 8. 3. 오전 11:18:02
	 * 작성자 : 신우섭
	 * @param prmtfileVO
	 * @return
	 */
	public PRMTFILEVO selectPrmtFile(PRMTFILEVO prmtfileVO) {
		return (PRMTFILEVO) select("PRMT_FILE_S_00", prmtfileVO);
	}

	/**
	 * 첨부파일 추가
	 * 파일명 : insertPrmtFile
	 * 작성일 : 2017. 8. 3. 오전 11:26:45
	 * 작성자 : 신우섭
	 * @param prmtfileVO
	 */
	public void insertPrmtFile(PRMTFILEVO prmtfileVO) {
		insert("PRMT_FILE_I_00", prmtfileVO);
	}


	public void deletePrmtFile(String prmtFileNum) {
		delete("PRMT_FILE_D_00", prmtFileNum);
	}

	public void deletePrmtFileAll(String prmtNum) {
		delete("PRMT_FILE_D_01", prmtNum);
	}

	public List<FILESVO> selectFileList(FILESVO fileSVO) {
		return (List<FILESVO>) list("PRMT_FILE_S_01", fileSVO);
	}

	public Integer selectFileListCnt(FILESVO fileSVO) {
		return (Integer) select("PRMT_FILE_S_02", fileSVO);
	}

	/**
	* 설명 : 메인 프로모션 순번을 랜덤으로 변경
	* 파일명 : updatePrmtSnRandom
	* 작성일 : 2022-03-31 오후 5:45
	* 작성자 : chaewan.jung
	* @param : MAINPRMTVO
	* @return : void
	* @throws Exception
	*/
	public void  updatePrmtSnRandom(MAINPRMTVO mainPrmtVO){
		update("PRMT_U_04", mainPrmtVO);
	}
	
	/**
	* 설명 : 고향사랑기부제 증빙자료 upload
	* 파일명 : insertHometownFile
	* 작성일 : 2023-12-18 오후 1:33
	* @param :
	* @return :
	* @throws Exception
	*/
	public void insertHometownFile(FILEVO fileVO){
		insert("PRMT_FILE_I_01", fileVO);
	}
	
	public void insertPrmtFile(FILEVO fileVO){
		insert("PRMT_FILE_I_02", fileVO);
	}

	/**
	* 설명 : 공고 신청
	* 파일명 : insertGova
	* 작성일 : 25. 5. 21. 오후 3:23
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void insertGova(GOVAVO govaVO) {
		insert("GOVA_I_01", govaVO);
	}

	/**
	* 설명 : 공고 신청 파일
	* 파일명 : insertGovaFile
	* 작성일 : 25. 5. 21. 오후 3:24
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public void insertGovaFile(GOVAFILEVO fileVO) {
		insert("GOVA_FILE_I_01", fileVO);
	}
}
