package oss.adj.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import common.LowerHashMap;
import org.springframework.stereotype.Service;

import oss.adj.service.OssAdjService;
import oss.adj.vo.ADJDTLINFVO;
import oss.adj.vo.ADJSVO;
import oss.adj.vo.ADJTAMNACARDVO;
import oss.adj.vo.ADJVO;

import common.Constant;

import egovframework.cmmn.service.impl.ScheduleDAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import oss.point.vo.POINTVO;

@Service("ossAdjService")
public class OssAdjServiceImpl extends EgovAbstractServiceImpl implements OssAdjService{
	
	@Resource(name="scheduleDAO")
	private ScheduleDAO scheduleDAO;
	
	@Resource(name="adjDAO")
	private AdjDAO adjDAO;
	/**
	 * 정산일자 구하기
	 * 파일명 : getAdjDt
	 * 작성일 : 2016. 1. 11. 오후 4:29:42
	 * 작성자 : 최영철
	 * @return
	 */
	@Override
	public String getAdjDt(){
		return scheduleDAO.getAdjDt();
	}
	
	/**
	 * 해당 날짜에 대한 정산건 조회
	 * 파일명 : selectAdjList
	 * 작성일 : 2016. 1. 11. 오후 4:33:46
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	@Override
	public List<ADJVO> selectAdjList(ADJSVO adjSVO){
		return scheduleDAO.selectAdjList(adjSVO);
	}
	
	/**
	 * 정산건 추출 처리
	 * 파일명 : getAdjust
	 * 작성일 : 2016. 1. 11. 오후 5:38:51
	 * 작성자 : 최영철
	 * @param adjSVO
	 */
	@Override
	public void getAdjust(ADJSVO adjSVO){
		// 3. 정산 대상 예약건 추출
		scheduleDAO.insertAdjDtlList(adjSVO);
		
		// 4. 정산 마스터 테이블 데이터 추출
		scheduleDAO.insertAdj(adjSVO);
		// 5-1. 숙박 정산 대상건에 정산여부, 정산일자 업데이트
		scheduleDAO.updateAdAdj(adjSVO);
		// 5-2. 렌터카 정산 대상건에 정산여부, 정산일자 업데이트
		scheduleDAO.updateRcAdj(adjSVO);
		// 5-3. 골프 정산 대상건에 정산여부, 정산일자 업데이트
		scheduleDAO.updateSpAdj(adjSVO);
		// 5-5. 관광기념품 정산 대상건에 정산여부, 정산일자 업데이트
		scheduleDAO.updateSvAdj(adjSVO);
	}
	
	/**
	 * 정산 년월에 대한 정산건 리스트 조회
	 * 파일명 : selectAdjListYM
	 * 작성일 : 2016. 1. 12. 오전 10:14:14
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	@Override
	public List<ADJVO> selectAdjListYM(ADJSVO adjSVO){
		return adjDAO.selectAdjListYM(adjSVO);
	}

	@Override
	public List<ADJVO> selectAdjListYM2(ADJSVO adjSVO){
		return adjDAO.selectAdjListYM2(adjSVO);
	}
	
	/**
	 * 날짜에 대한 정산 리스트 조회
	 * 파일명 : selectAdjList2
	 * 작성일 : 2016. 1. 12. 오후 1:44:46
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	@Override
	public List<ADJVO> selectAdjList2(ADJSVO adjSVO){
		return adjDAO.selectAdjList2(adjSVO);
	}
	
	/**
	 * 정산완료 처리
	 * 파일명 : adjustComplete
	 * 작성일 : 2016. 1. 12. 오후 4:44:04
	 * 작성자 : 최영철
	 * @param adjSVO
	 */
	@Override
	public void adjustComplete(ADJSVO adjSVO){
		adjDAO.adjustComplete(adjSVO);
	}
	
	/**
	 * 업체별 정산상세 리스트
	 * 파일명 : selectAdjInfList
	 * 작성일 : 2016. 1. 12. 오후 5:43:12
	 * 작성자 : 최영철
	 * @param adjSVO
	 * @return
	 */
	@Override
	public List<ADJDTLINFVO> selectAdjInfList(ADJSVO adjSVO){
		return adjDAO.selectAdjInfList(adjSVO);
	}
	
	/**
	 * 정산 상세 단건 조회
	 * 파일명 : selectByAdjDtlInf
	 * 작성일 : 2016. 5. 31. 오후 1:36:24
	 * 작성자 : 최영철
	 * @param adjDtlInfVO
	 * @return
	 */
	@Override
	public ADJDTLINFVO selectByAdjDtlInf(ADJDTLINFVO adjDtlInfVO){
		return adjDAO.selectByAdjDtlInf(adjDtlInfVO);
	}
	
	/**
	 * 검색 기간에 해당하는 정산 리스트
	 * Function : selectAdjListSearch
	 * 작성일 : 2017. 5. 22. 오후 12:29:47
	 * 작성자 : 정동수
	 * @param adjSVO
	 * @return
	 */
	@Override
	public List<ADJVO> selectAdjListSearch(ADJSVO adjSVO) {		
		return adjDAO.selectAdjListSearch(adjSVO);
	}
	
	/**
	 * 정산 상세 수정
	 * 파일명 : updateAdjDtlInf
	 * 작성일 : 2016. 5. 31. 오후 1:43:42
	 * 수정일 : 2017. 5. 19 By JDongS
	 * 작성자 : 최영철
	 * @param adjDtlInfVO
	 */
	@Override
	public void updateAdjDtlInf(ADJDTLINFVO adjDtlInfVO){
		ADJDTLINFVO adjInfo = adjDAO.selectByAdjDtlInf(adjDtlInfVO);
				
		int saleCmss = 0;
		
		// 취소인 경우 수수료 금액에서 판매 수수료 산출함
		if (Constant.RSV_STATUS_CD_CCOM.equals(adjInfo.getRsvStatusCd()))	
			saleCmss = (int) Math.floor(Double.parseDouble(adjInfo.getCmssAmt()) * (Double.parseDouble(adjDtlInfVO.getAdjAplPct()) / 100) / 10) * 10;
		else {
			// 판매 금액에서 판매 수수료 산출
			saleCmss = (int) Math.floor(Double.parseDouble(adjInfo.getSaleAmt()) * (Double.parseDouble(adjDtlInfVO.getAdjAplPct()) / 100) / 10) * 10;
		}
		
		adjDtlInfVO.setSaleCmss("" + saleCmss);
		
		// 정산 상세 수정
		adjDAO.updateAdjDtlInf(adjDtlInfVO);
		
		// 정산의 총 판매 수수료 수정
		adjDAO.adjustUpdate(adjDtlInfVO);
	}

	/**
	* 설명 : 쿠폰 정산(업체별) 엑셀다운로드
	* 파일명 :
	* 작성일 : 2022-02-14 오후 5:24
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public List<ADJVO> selectAdjList3(ADJSVO adjSVO){
		return adjDAO.selectAdjList3(adjSVO);
	}

	/**
	* 설명 : 탐나는전 정산 엑셀다운로드
	* 파일명 :
	* 작성일 : 2022-05-26 오후 3:02
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public 	List<ADJTAMNACARDVO> selectAdjTamnacardList(ADJSVO adjSVO){
		return adjDAO.selectAdjTamnacardList(adjSVO);
	}

	public List<LowerHashMap> selectPointList(ADJSVO adjSVO){
		return adjDAO.selectPointList(adjSVO);
	}


}
