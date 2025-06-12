package mas.rc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.rc.service.MasRcPrdtService;
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

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import common.EgovUserDetailsHelper;
import oss.cmm.service.OssCmmService;
import oss.cmm.service.OssFileUtilService;
import oss.cmm.vo.CM_ICONINFVO;
import oss.cmm.vo.CM_IMGVO;
import oss.cmm.vo.CM_SRCHWORDVO;
import oss.user.vo.USERVO;
import web.order.vo.RC_RSVVO;
import web.order.vo.RSVSVO;
import egovframework.cmmn.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("masRcPrdtService")
public class MasRcPrdtServiceImpl extends EgovAbstractServiceImpl implements MasRcPrdtService {

//	private static final Logger LOGGER = LoggerFactory.getLogger(MasRcPrdtServiceImpl.class);

	/** RcDAO */
	@Resource(name = "rcDAO")
	private RcDAO rcDAO;

	@Resource(name="ossFileUtilService")
	private OssFileUtilService ossFileUtilService;

	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;

	/**
	 * 렌트카 기본설정 조회
	 * 파일명 : selectByRcDftInfo
	 * 작성일 : 2015. 10. 5. 오후 1:07:48
	 * 작성자 : 최영철
	 * @param rc_DFTINFVO
	 * @return
	 */
	@Override
	public RC_DFTINFVO selectByRcDftInfo(RC_DFTINFVO rc_DFTINFVO){
		return rcDAO.selectByRcInfo(rc_DFTINFVO);
	}

	/**
	 * 렌트카 기본설정 저장
	 * 파일명 : mergeRcDftInfo
	 * 작성일 : 2015. 10. 5. 오후 5:47:19
	 * 작성자 : 최영철
	 * @param dftInfFVO
	 */
	@Override
	public void mergeRcDftInfo(RC_DFTINFVO dftInfFVO){
		rcDAO.mergeRcDftInfo(dftInfFVO);
	}

	/**
	 * 렌트카 상품 리스트조회
	 * 파일명 : selectRcPrdtList
	 * 작성일 : 2015. 10. 5. 오후 7:40:20
	 * 작성자 : 최영철
	 * @param prdtInfSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectRcPrdtList(RC_PRDTINFSVO prdtInfSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<RC_PRDTINFVO> resultList = rcDAO.selectRcPrdtList(prdtInfSVO);
		Integer totalCnt = rcDAO.getCntRcPrdtList(prdtInfSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	/**
	 * 렌터카 상품 등록
	 * 파일명 : insertPrdt
	 * 작성일 : 2015. 10. 7. 오전 9:47:19
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 * @param multiRequest
	 * @throws Exception
	 */
	@Override
	public void insertPrdt(RC_PRDTINFVO prdtInfVO, MultipartHttpServletRequest multiRequest) throws Exception{
		prdtInfVO.setOldSn(0);
		prdtInfVO.setNewSn(Integer.parseInt(prdtInfVO.getViewSn()));

		addRcPrdtViewSn(prdtInfVO);

		String prdtNum = rcDAO.insertPrdt(prdtInfVO);
		String savePath = EgovProperties.getProperty("PRODUCT.RC.SAVEDFILE");

		ossFileUtilService.uploadImgFile(multiRequest, savePath, prdtNum);

		// 주요정보.
		CM_ICONINFVO icon = new CM_ICONINFVO();
		icon.setLinkNum(prdtNum);
		icon.setIconCds(prdtInfVO.getIconCd());
		icon.setFrstRegId(prdtInfVO.getFrstRegId());
		ossCmmService.insertCmIconinf(icon);

		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(prdtInfVO.getPrdtNum());
		srchWordVO.setFrstRegId(prdtInfVO.getFrstRegId());
		srchWordVO.setLastModId(prdtInfVO.getFrstRegId());
		srchWordVO.setSrchWordSn("1");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord1());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("2");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord2());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("3");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord3());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("4");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord4());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("5");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord5());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("6");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord6());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("7");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord7());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("8");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord8());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("9");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord9());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("10");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord10());
		ossCmmService.insertSrchWord2(srchWordVO);
	}

	/**
	 * 노출 순번 변경
	 * 파일명 : updateRcPrdtViewSn
	 * 작성일 : 2016. 6. 8. 오전 11:18:55
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	@Override
	public void updateRcPrdtViewSn(RC_PRDTINFVO prdtInfVO){
		if(prdtInfVO.getOldSn() > prdtInfVO.getNewSn()){
			// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
			addRcPrdtViewSn(prdtInfVO);
		}else{
			minusRcPrdtViewSn(prdtInfVO);
		}
		rcDAO.updateRcPrdtViewSn(prdtInfVO);
	}

	/**
	 * 노출 순번 감소
	 * 파일명 : minusRcPrdtViewSn
	 * 작성일 : 2016. 6. 8. 오전 11:21:01
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	private void minusRcPrdtViewSn(RC_PRDTINFVO prdtInfVO) {
		rcDAO.minusRcPrdtViewSn(prdtInfVO);
	}

	/**
	 * 노출 순번 증가
	 * 파일명 : addRcPrdtViewSn
	 * 작성일 : 2016. 6. 8. 오전 11:21:08
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	public void addRcPrdtViewSn(RC_PRDTINFVO prdtInfVO) {
		rcDAO.addRcPrdtViewSn(prdtInfVO);
	}

	/**
	 * 렌터카 상품 단건 조회
	 * 파일명 : selectByPrdt
	 * 작성일 : 2015. 10. 8. 오전 10:25:32
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 * @return
	 */
	@Override
	public RC_PRDTINFVO selectByPrdt(RC_PRDTINFVO prdtInfVO){
		RC_PRDTINFVO resultVO = rcDAO.selectByPrdt(prdtInfVO);

		if(resultVO != null){
			resultVO.setSrchWord1(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "1"));
			resultVO.setSrchWord2(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "2"));
			resultVO.setSrchWord3(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "3"));
			resultVO.setSrchWord4(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "4"));
			resultVO.setSrchWord5(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "5"));
			resultVO.setSrchWord6(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "6"));
			resultVO.setSrchWord7(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "7"));
			resultVO.setSrchWord8(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "8"));
			resultVO.setSrchWord9(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "9"));
			resultVO.setSrchWord10(ossCmmService.getSrchWord(resultVO.getPrdtNum(), "10"));
		}

		return resultVO;
	}

	/**
	 * 렌터카 상품 수정
	 * 파일명 : updatePrdt
	 * 작성일 : 2015. 10. 8. 오후 1:56:04
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	@Override
	public void updatePrdt(RC_PRDTINFVO prdtInfVO){
		rcDAO.updatePrdt(prdtInfVO);

		//주요정보 수정 - 기존꺼 삭제 후 저장.
		CM_ICONINFVO icon = new CM_ICONINFVO();
		icon.setLinkNum(prdtInfVO.getPrdtNum());
		icon.setIconCds(prdtInfVO.getIconCd());
		icon.setFrstRegId(prdtInfVO.getLastModId());
		ossCmmService.updateCmIconinf(icon);

		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(prdtInfVO.getPrdtNum());
		srchWordVO.setFrstRegId(prdtInfVO.getLastModId());
		srchWordVO.setLastModId(prdtInfVO.getLastModId());
		srchWordVO.setSrchWordSn("1");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord1());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("2");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord2());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("3");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord3());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("4");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord4());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("5");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord5());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("6");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord6());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("7");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord7());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("8");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord8());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("9");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord9());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("10");
		srchWordVO.setSrchWord(prdtInfVO.getSrchWord10());
		ossCmmService.insertSrchWord2(srchWordVO);
	}

	/**
	 * 렌터카 요금정보 리스트 조회
	 * 파일명 : selectRcPrdtAmtList
	 * 작성일 : 2015. 10. 12. 오전 11:05:45
	 * 작성자 : 최영철
	 * @param amtInfVO
	 * @return
	 */
	@Override
	public List<RC_AMTINFVO> selectRcPrdtAmtList(RC_AMTINFVO amtInfVO){
		return rcDAO.selectRcPrdtAmtList(amtInfVO);
	}

	/**
	 * 렌터카 적용일자에 대한 금액 단건 조회
	 * 파일명 : selectByPrdtAmt
	 * 작성일 : 2015. 10. 12. 오후 6:30:24
	 * 작성자 : 최영철
	 * @param amtInfVO
	 * @return
	 */
	@Override
	public RC_AMTINFVO selectByPrdtAmt(RC_AMTINFVO amtInfVO){
		return rcDAO.selectByPrdtAmt(amtInfVO);
	}

	/**
	 * 렌터카 요금 추가
	 * 파일명 : insertPrdtAmt
	 * 작성일 : 2015. 10. 12. 오후 7:54:44
	 * 작성자 : 최영철
	 * @param amtInfVO
	 */
	@Override
	public void insertPrdtAmt(RC_AMTINFVO amtInfVO){
		rcDAO.insertPrdtAmt(amtInfVO);
	}

	/**
	 * 렌터카 요금 수정
	 * 파일명 : updatePrdtAmt
	 * 작성일 : 2015. 10. 12. 오후 9:17:27
	 * 작성자 : 최영철
	 * @param amtInfVO
	 */
	@Override
	public void updatePrdtAmt(RC_AMTINFVO amtInfVO){
		rcDAO.updatePrdtAmt(amtInfVO);
	}

	/**
	 * 렌터카 요금 삭제
	 * 파일명 : deletePrdtAmt
	 * 작성일 : 2015. 10. 12. 오후 9:21:38
	 * 작성자 : 최영철
	 * @param amtInfVO
	 */
	@Override
	public void deletePrdtAmt(RC_AMTINFVO amtInfVO){
		rcDAO.deletePrdtAmt(amtInfVO);
	}

	/**
	 * 렌터카 할인율 조회
	 * 파일명 : selectDisPerList
	 * 작성일 : 2015. 10. 13. 오후 1:36:53
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectDisPerList(RC_DISPERINFVO disPerInfVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		RC_DISPERINFVO defDisPerVO = rcDAO.selectByDefDisPer(disPerInfVO);
		List<RC_DISPERINFVO> disPerInfList = rcDAO.selectDisPerList(disPerInfVO);

		resultMap.put("defDisPerVO", defDisPerVO);
		resultMap.put("disPerInfList", disPerInfList);
		return resultMap;
	}

	/**
	 * 렌터카 기본할인율 등록
	 * 파일명 : insertDefDisPer
	 * 작성일 : 2015. 10. 13. 오후 5:59:53
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override
	public void insertDefDisPer(RC_DISPERINFVO disPerInfVO){
		disPerInfVO.setDisPerNum("1");
		disPerInfVO.setAplStartDt("00000101");
		disPerInfVO.setAplEndDt("99991231");
		rcDAO.insertDisPerInf(disPerInfVO);
	}

	/**
	 * 렌터카 기본 할인율 수정
	 * 파일명 : updateDefDisPer
	 * 작성일 : 2015. 10. 13. 오후 8:18:17
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override
	public void updateDefDisPer(RC_DISPERINFVO disPerInfVO){
		disPerInfVO.setDisPerNum("1");
		disPerInfVO.setAplStartDt("00000101");
		disPerInfVO.setAplEndDt("99991231");
		rcDAO.updateDisPerInf(disPerInfVO);
	}

	/**
	 * 렌터카 기간할인율 등록
	 * 파일명 : insertRangeDisPer
	 * 작성일 : 2015. 10. 14. 오전 10:09:51
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override
	public void insertRangeDisPer(RC_DISPERINFVO disPerInfVO){
		rcDAO.insertRangeDisPer(disPerInfVO);
	}

	/**
	 * 적용일자 중복 체크
	 * 파일명 : checkRangeAplDt
	 * 작성일 : 2015. 10. 14. 오전 11:36:49
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	@Override
	public Integer checkRangeAplDt(RC_DISPERINFVO disPerInfVO){
		return rcDAO.checkRangeAplDt(disPerInfVO);
	}

	/**
	 * 렌터카 기간할인율 단건 조회
	 * 파일명 : selectByDisPerInf
	 * 작성일 : 2015. 10. 14. 오후 2:47:12
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 * @return
	 */
	@Override
	public RC_DISPERINFVO selectByDisPerInf(RC_DISPERINFVO disPerInfVO){
		return rcDAO.selectByDisPerInf(disPerInfVO);
	}

	/**
	 * 렌터카 기간할인율 수정
	 * 파일명 : updateRangeDisPer
	 * 작성일 : 2015. 10. 14. 오후 3:21:00
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override
	public void updateRangeDisPer(RC_DISPERINFVO disPerInfVO){
		rcDAO.updateRangeDisPer(disPerInfVO);
	}

	/**
	 * 렌터카 기간할인율 삭제
	 * 파일명 : deleteRangeDisPer
	 * 작성일 : 2015. 10. 14. 오후 3:41:24
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override
	public void deleteRangeDisPer(RC_DISPERINFVO disPerInfVO){
		rcDAO.deleteRangeDisPer(disPerInfVO);
	}

	/**
	 * 렌터카 상품 승인요청
	 * 파일명 : approvalPrdt
	 * 작성일 : 2015. 10. 14. 오후 7:29:17
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 * @throws Exception
	 */
	@Override
	public void approvalPrdt(RC_PRDTINFVO prdtInfVO) throws Exception{
		rcDAO.approvalPrdt(prdtInfVO);
	}

	/**
	 * 상품 삭제 처리
	 * 파일명 : deletePrdt
	 * 작성일 : 2015. 10. 16. 오전 11:56:35
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 * @throws Exception
	 */
	@Override
	public void deletePrdt(RC_PRDTINFVO prdtInfVO) throws Exception{
		// 보험정책 개발시 보험 정책도 삭제 여부

		// 1. 할인율 삭제
		rcDAO.deleteDisPerInf(prdtInfVO);
		// 2. 요금 삭제
		rcDAO.deleteAmt(prdtInfVO);
		// 3. 수량 삭제
		rcDAO.deleteCntInf(prdtInfVO);
		// 4. 이미지 삭제
		CM_IMGVO imgVO = new CM_IMGVO();
		imgVO.setLinkNum(prdtInfVO.getPrdtNum());
		ossCmmService.deletePrdtImgList(imgVO);

		// 주요정보 삭제.
		ossCmmService.deleteCmIconinf(prdtInfVO.getPrdtNum());
		// 5. 상품정보 삭제
		rcDAO.deletePrdt(prdtInfVO);

		/*prdtInfVO.setNewSn(0);
		prdtInfVO.setOldSn(Integer.parseInt(prdtInfVO.getViewSn()));
    	minusRcPrdtViewSn(prdtInfVO);*/

	}

	/**
	 * 상품 승인 취소 요청
	 * 파일명 : approvalCancelPrdt
	 * 작성일 : 2015. 10. 19. 오전 11:36:22
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	@Override
	public void approvalCancelPrdt(RC_PRDTINFVO prdtInfVO){
		rcDAO.approvalCancelPrdt(prdtInfVO);
	}

	/**
	 * 렌터카 상품 전체 리스트 조회
	 * 파일명 : selectPrdtList
	 * 작성일 : 2015. 10. 20. 오후 2:23:34
	 * 작성자 : 최영철
	 * @param prdtInfSVO
	 * @return
	 */
	@Override
	public List<RC_PRDTINFVO> selectPrdtList(RC_PRDTINFSVO prdtInfSVO){
		return rcDAO.selectPrdtList(prdtInfSVO);
	}

		@Override
	public List<RC_PRDTINFVO> selectCarNmList(RC_PRDTINFSVO prdtInfSVO){
		return rcDAO.selectCarNmList(prdtInfSVO);
	}

	/**
	 * 렌터카 상품 수량 리스트 조회
	 * 파일명 : selectCntList
	 * 작성일 : 2015. 10. 20. 오후 3:52:08
	 * 작성자 : 최영철
	 * @param cntInfVO
	 * @return
	 */
	@Override
	public List<RC_CNTINFVO> selectCntList(RC_CNTINFVO cntInfVO){
		return rcDAO.selectCntList(cntInfVO);
	}

	/**
	 * 렌터카 상품 수량 단건 조회
	 * 파일명 : selectByPrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 5:35:00
	 * 작성자 : 최영철
	 * @param cntInfVO
	 * @return
	 */
	@Override
	public RC_CNTINFVO selectByPrdtCnt(RC_CNTINFVO cntInfVO){
		return rcDAO.selectByPrdtCnt(cntInfVO);
	}

	/**
	 * 렌터카 상품 수량 등록
	 * 파일명 : insertPrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 5:49:01
	 * 작성자 : 최영철
	 * @param cntInfVO
	 */
	@Override
	public void insertPrdtCnt(RC_CNTINFVO cntInfVO){
		rcDAO.insertPrdtCnt(cntInfVO);
	}

	/**
	 * 렌터카 상품 수량 수정
	 * 파일명 : updatePrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 8:23:15
	 * 작성자 : 최영철
	 * @param cntInfVO
	 */
	@Override
	public void updatePrdtCnt(RC_CNTINFVO cntInfVO){
		rcDAO.updatePrdtCnt(cntInfVO);
	}

	/**
	 * 렌터카 상품 수량 삭제
	 * 파일명 : deletePrdtCnt
	 * 작성일 : 2015. 10. 20. 오후 8:28:34
	 * 작성자 : 최영철
	 * @param cntInfVO
	 */
	@Override
	public void deletePrdtCnt(RC_CNTINFVO cntInfVO){
		rcDAO.deletePrdtCnt(cntInfVO);
	}


	@Override
	public int getCntRcPrdtFormCorp(RC_PRDTINFVO prdtInfVO) {
		return rcDAO.getCntRcPrdtFormCorp(prdtInfVO);
	}

	/**
	 * 상품 판매 중지
	 * 파일명 : saleStopPrdt
	 * 작성일 : 2016. 2. 4. 오전 11:37:23
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	@Override
	public void saleStopPrdt(RC_PRDTINFVO prdtInfVO){
		rcDAO.saleStopPrdt(prdtInfVO);
	}
	
	@Override
	public void salePrintN(RC_PRDTINFVO prdtInfVO){
		rcDAO.salePrintN(prdtInfVO);
	}
	

	/**
	 * 업체 차량 수 구하기
	 * 파일명 : getCntRcPrdtList
	 * 작성일 : 2016. 6. 8. 오전 10:37:40
	 * 작성자 : 최영철
	 * @param cntChkVO
	 * @return
	 */
	@Override
	public Integer getCntRcPrdtList(RC_PRDTINFSVO cntChkVO){
		return rcDAO.getCntRcPrdtList(cntChkVO);
	}

	/**
	 * 할인율 일괄 조회
	 * 파일명 : selectDisperPackList
	 * 작성일 : 2016. 8. 2. 오전 10:11:52
	 * 작성자 : 최영철
	 * @param prdtInfSVO
	 * @return
	 */
	@Override
	public List<RC_DISPERINFVO> selectDisperPackList(RC_PRDTINFSVO prdtInfSVO){
		return rcDAO.selectDisperPackList(prdtInfSVO);
	}

	/**
	 * 할인율 일괄 수정
	 * 파일명 : updateChkDisPer
	 * 작성일 : 2016. 8. 3. 오전 11:31:26
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override
	public void updateChkDisPer(RC_DISPERINFVO disPerInfVO){
		String [] prdtNum;
    	String [] disPerNum;

		prdtNum = disPerInfVO.getPrdtNum().split(",");
		disPerNum = disPerInfVO.getDisPerNum().split(",");

		for(int i=0;i<prdtNum.length;i++){
			disPerInfVO.setPrdtNum(prdtNum[i]);
			disPerInfVO.setDisPerNum(disPerNum[i]);
			RC_DISPERINFVO oldVO = rcDAO.selectByDisPerInf(disPerInfVO);

			oldVO.setWdayDisPer(disPerInfVO.getWdayDisPer());
			oldVO.setWkdDisPer(disPerInfVO.getWkdDisPer());
			oldVO.setLastModId(disPerInfVO.getLastModId());

			rcDAO.updateRangeDisPer(oldVO);
		}
	}

	@Override
	public void deleteChkDisPer(RC_DISPERINFVO disPerInfVO){
		String [] prdtNum;
		String [] disPerNum;

		prdtNum = disPerInfVO.getPrdtNum().split(",");
		disPerNum = disPerInfVO.getDisPerNum().split(",");

		for(int i=0;i<prdtNum.length;i++){
			disPerInfVO.setPrdtNum(prdtNum[i]);
			disPerInfVO.setDisPerNum(disPerNum[i]);
			RC_DISPERINFVO oldVO = rcDAO.selectByDisPerInf(disPerInfVO);

			oldVO.setWdayDisPer(disPerInfVO.getWdayDisPer());
			oldVO.setWkdDisPer(disPerInfVO.getWkdDisPer());
			oldVO.setLastModId(disPerInfVO.getLastModId());

			rcDAO.deleteRangeDisPer(oldVO);
		}
	}

	/**
	 * 기본 할인율이 등록안된 상품 조회
	 * 파일명 : selectDefDisPerPrdt
	 * 작성일 : 2016. 8. 3. 오후 2:48:56
	 * 작성자 : 최영철
	 * @param searchVO
	 * @return
	 */
	@Override
	public List<RC_DISPERINFVO> selectDefDisPerPrdt(RC_PRDTINFSVO searchVO){
		return rcDAO.selectDefDisPerPrdt(searchVO);
	}

	/**
	 * 기본 할인율 일괄 등록
	 * 파일명 : insertDefDisPer2
	 * 작성일 : 2016. 8. 3. 오후 5:23:44
	 * 작성자 : 최영철
	 * @param disPerInfVO
	 */
	@Override
	public void insertDefDisPer2(RC_DISPERINFVO disPerInfVO){
		String [] prdtNum;
		prdtNum = disPerInfVO.getPrdtNum().split(",");

		disPerInfVO.setDisPerNum("1");
		disPerInfVO.setAplStartDt("00000101");
		disPerInfVO.setAplEndDt("99991231");

		for(int i=0;i<prdtNum.length;i++){
			disPerInfVO.setPrdtNum(prdtNum[i]);

			rcDAO.insertDisPerInf(disPerInfVO);
		}
	}

	/**
	 * 설명 : 렌터카 예약현황 조회
	 * 파일명 : selectRsvChart
	 * 작성일 : 2023-02-28 오후 3:24
	 * 작성자 : chaewan.jung
	 * @param : [searchVO]
	 * @return : java.util.List<mas.rc.vo.RC_RSVCHARTVO>
	 * @throws Exception
	 */
	@Override
	public List<RC_RSVCHARTVO> selectRsvChart(RC_RSVCHARTSVO searchVO){
		return rcDAO.selectRsvChart(searchVO);
	}

	/**
	 * 예약현황 상세
	 * 파일명 : selectRsvChartDtl
	 * 작성일 : 2016. 8. 9. 오전 9:44:47
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public List<RC_RSVVO> selectRsvChartDtl(RSVSVO rsvSVO){
		return rcDAO.selectRsvChartDtl(rsvSVO);
	}

	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오전 10:33:13
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public Integer checkExsistPrdt(RSVSVO rsvSVO){
		return rcDAO.checkExsistPrdt(rsvSVO);
	}

	/**
	 * 연계 설정/해제
	 * 파일명 : updatePrdtLinkYn
	 * 작성일 : 2016. 12. 5. 오전 10:31:23
	 * 작성자 : 최영철
	 * @param prdtInfVO
	 */
	@Override
	public void updatePrdtLinkYn(RC_PRDTINFVO prdtInfVO){
		rcDAO.updatePrdtLinkYn(prdtInfVO);
	}

	/**
	 * 업체에 해당하는 상품인지 체크
	 * Function : checkCorpPrdt
	 * 작성일 : 2017. 5. 2. 오전 10:16:06
	 * 작성자 : 정동수
	 * @param prdtInfVO
	 * @return
	 */
	@Override
	public Integer checkCorpPrdt(RC_PRDTINFVO prdtInfVO) {
		USERVO corpInfo = (USERVO) EgovUserDetailsHelper.getAuthenticatedMas();

		prdtInfVO.setCorpId(corpInfo.getCorpId());

		return rcDAO.checkCorpPrdt(prdtInfVO);
	}



	@Override
	public RC_CARDIVVO selectCardiv(RC_CARDIVVO rcCardivVO) {
		return rcDAO.selectCardiv(rcCardivVO);
	}

	@Override
	public Map<String, Object> selectCardivList(RC_CARDIVSVO rcCardivSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("resultList", rcDAO.selectCardivList(rcCardivSVO));
		resultMap.put("totalCnt", rcDAO.selectCardivListCnt(rcCardivSVO));

		return resultMap;
	}
	
	@Override
	public List<RC_CARDIVVO> selectCardivTotalList(RC_CARDIVSVO rcCardivSVO) {
		return rcDAO.selectCardivTotalList(rcCardivSVO);
	}
	
	@Override
	public int selectCardivCnt(RC_CARDIVVO rcCardivVO) {
		return rcDAO.selectCardivCnt(rcCardivVO);
	}

	@Override
	public void insertCardiv(RC_CARDIVVO rcCardivVO) {
		rcDAO.insertCardiv(rcCardivVO);

	}

	@Override
	public void updateCardiv(RC_CARDIVVO rcCardivVO) {
		rcDAO.updateCardiv(rcCardivVO);

	}

	@Override
	public void deleteCardiv(RC_CARDIVVO rcCardivVO) {
		rcDAO.deleteCardiv(rcCardivVO);

	}
	
	
	@Override
	public Integer selectCardivAutoIncrementNum(RC_CARDIVVO rcCardivVO) {
		return rcDAO.selectCardivAutoIncrementNum(rcCardivVO);
	}

	@Override
	public List<RC_CARDIVVO> selectCarNmList(RC_CARDIVSVO rcCardivSVO) {
		return rcDAO.selectCarNmList(rcCardivSVO);
	}

	
	
	
	
}
