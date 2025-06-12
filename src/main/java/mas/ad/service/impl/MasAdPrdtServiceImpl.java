package mas.ad.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mas.ad.service.MasAdPrdtService;
import mas.ad.vo.AD_ADDAMTSVO;
import mas.ad.vo.AD_ADDAMTVO;
import mas.ad.vo.AD_AMTINFSVO;
import mas.ad.vo.AD_AMTINFVO;
import mas.ad.vo.AD_BREAKFASTAMTVO;
import mas.ad.vo.AD_CNTINFSVO;
import mas.ad.vo.AD_CNTINFVO;
import mas.ad.vo.AD_CTNAMTVO;
import mas.ad.vo.AD_CTNINFVO;
import mas.ad.vo.AD_DFTINFVO;
import mas.ad.vo.AD_PRDTINFSVO;
import mas.ad.vo.AD_PRDTINFVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CM_ICONINFVO;
import oss.cmm.vo.CM_SRCHWORDVO;
import web.order.vo.AD_RSVVO;
import web.order.vo.RSVSVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("masAdPrdtService")
public class MasAdPrdtServiceImpl extends EgovAbstractServiceImpl implements MasAdPrdtService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(MasAdPrdtServiceImpl.class);

	@Resource(name = "adDAO")
	private AdDAO adDAO;

	@Resource(name = "ossCmmService")
	private OssCmmService ossCmmService;
	/**
	 * 숙소 정보 단건 조회
	 * 파일명 : selectByAdDftinf
	 * 작성일 : 2015. 10. 8. 오후 5:48:12
	 * 작성자 : 신우섭
	 * @param adDftinfVO
	 * @return
	 */
	@Override
	public AD_DFTINFVO selectByAdDftinf(AD_DFTINFVO adDftinfVO) {
		AD_DFTINFVO resultVO = adDAO.selectByAdDftinf(adDftinfVO);

		if(resultVO != null){
			resultVO.setSrchWord1(ossCmmService.getSrchWord(resultVO.getCorpId(), "1"));
			resultVO.setSrchWord2(ossCmmService.getSrchWord(resultVO.getCorpId(), "2"));
			resultVO.setSrchWord3(ossCmmService.getSrchWord(resultVO.getCorpId(), "3"));
			resultVO.setSrchWord4(ossCmmService.getSrchWord(resultVO.getCorpId(), "4"));
			resultVO.setSrchWord5(ossCmmService.getSrchWord(resultVO.getCorpId(), "5"));
			resultVO.setSrchWord6(ossCmmService.getSrchWord(resultVO.getCorpId(), "6"));
			resultVO.setSrchWord7(ossCmmService.getSrchWord(resultVO.getCorpId(), "7"));
			resultVO.setSrchWord8(ossCmmService.getSrchWord(resultVO.getCorpId(), "8"));
			resultVO.setSrchWord9(ossCmmService.getSrchWord(resultVO.getCorpId(), "9"));
			resultVO.setSrchWord10(ossCmmService.getSrchWord(resultVO.getCorpId(), "10"));
		}

		return resultVO;
	}


	/**
	 * 숙소 정보 추가
	 * 파일명 : insertAdDftinf
	 * 작성일 : 2015. 10. 8. 오후 5:48:42
	 * 작성자 : 신우섭
	 * @param adDftinfVO
	 */
	@Override
	public void insertAdDftinf(AD_DFTINFVO adDftinfVO) {
		adDAO.insertAdDftinf(adDftinfVO);

		// 주요정보.
		CM_ICONINFVO icon = new CM_ICONINFVO();
		icon.setLinkNum(adDftinfVO.getCorpId());
		icon.setIconCds(adDftinfVO.getIconCd());
		icon.setFrstRegId(adDftinfVO.getFrstRegId());
		ossCmmService.insertCmIconinf(icon);

		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(adDftinfVO.getCorpId());
		srchWordVO.setFrstRegId(adDftinfVO.getFrstRegId());
		srchWordVO.setLastModId(adDftinfVO.getFrstRegId());
		srchWordVO.setSrchWordSn("1");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord1());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("2");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord2());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("3");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord3());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("4");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord4());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("5");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord5());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("6");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord6());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("7");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord7());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("8");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord8());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("9");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord9());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("10");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord10());
		ossCmmService.insertSrchWord2(srchWordVO);

		// ossCmmService.insertSrchWord(srchWordList);
	}


	/**
	 * 숙소 정보 수정
	 * 파일명 : updateAdDftinf
	 * 작성일 : 2015. 10. 8. 오후 5:48:52
	 * 작성자 : 신우섭
	 * @param adDftinfVO
	 */
	@Override
	public void updateAdDftinf(AD_DFTINFVO adDftinfVO) {
		adDAO.updateAdDftinf(adDftinfVO);

		//주요정보 수정 - 기존꺼 삭제 후 저장.
		CM_ICONINFVO icon = new CM_ICONINFVO();
		icon.setLinkNum(adDftinfVO.getCorpId());
		icon.setIconCds(adDftinfVO.getIconCd());
		icon.setFrstRegId(adDftinfVO.getLastModId());
		ossCmmService.updateCmIconinf(icon);

		CM_SRCHWORDVO srchWordVO = new CM_SRCHWORDVO();
		srchWordVO.setLinkNum(adDftinfVO.getCorpId());
		srchWordVO.setFrstRegId(adDftinfVO.getLastModId());
		srchWordVO.setLastModId(adDftinfVO.getLastModId());
		srchWordVO.setSrchWordSn("1");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord1());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("2");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord2());

		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("3");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord3());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("4");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord4());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("5");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord5());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("6");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord6());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("7");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord7());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("8");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord8());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("9");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord9());
		ossCmmService.insertSrchWord2(srchWordVO);

		srchWordVO.setSrchWordSn("10");
		srchWordVO.setSrchWord(adDftinfVO.getSrchWord10());
		ossCmmService.insertSrchWord2(srchWordVO);

		// ossCmmService.insertSrchWord(srchWordList);
	}


	@Override
	public void deleteAdDftinf(AD_DFTINFVO adDftinfVO) {
		//bbsDAO.deleteBbs(bbsV0);

	}


	/**
	 * 숙소 추가 요금 목록
	 * 파일명 : selectAdAddamtList
	 * 작성일 : 2015. 10. 8. 오후 5:49:09
	 * 작성자 : 신우섭
	 * @param ad_ADDAMTSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectAdAddamtList(AD_ADDAMTSVO ad_ADDAMTSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<AD_ADDAMTVO> resultList = adDAO.selectAdAddamtList(ad_ADDAMTSVO);
		Integer totalCnt = adDAO.getCntAdAddamtList(ad_ADDAMTSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public int getAddAmtListCount(AD_ADDAMTSVO ad_addamtsvo) {
		return adDAO.getCntAdAddamtList(ad_addamtsvo);
	}

	/**
	 * 숙소 추가 요금 단건 조회
	 * 파일명 : selectByAdAddamt
	 * 작성일 : 2015. 10. 8. 오후 5:49:28
	 * 작성자 : 신우섭
	 * @param ad_ADDAMTVO
	 * @return
	 */
	@Override
	public AD_ADDAMTVO selectByAdAddamt(AD_ADDAMTVO ad_ADDAMTVO) {
		return adDAO.selectByAdAddamt(ad_ADDAMTVO);
	}


	/**
	 * 숙소 추가 요금 추가
	 * 파일명 : insertAdAddamt
	 * 작성일 : 2015. 10. 8. 오후 5:49:40
	 * 작성자 : 신우섭
	 * @param ad_ADDAMTVO
	 */
	@Override
	public void insertAdAddamt(AD_ADDAMTVO ad_ADDAMTVO) {
		adDAO.insertAdAddamt(ad_ADDAMTVO);

	}


	/**
	 * 숙소 추가 요금 수정
	 * 파일명 : updateAdAddamt
	 * 작성일 : 2015. 10. 8. 오후 5:49:48
	 * 작성자 : 신우섭
	 * @param ad_ADDAMTVO
	 */
	@Override
	public void updateAdAddamt(AD_ADDAMTVO ad_ADDAMTVO) {
		adDAO.updateAdAddamt(ad_ADDAMTVO);

	}


	/**
	 * 숙소 추가 요금 삭제
	 * 파일명 : deleteAdAddamt
	 * 작성일 : 2015. 10. 8. 오후 5:49:55
	 * 작성자 : 신우섭
	 * @param ad_ADDAMTVO
	 */
	@Override
	public void deleteAdAddamt(AD_ADDAMTVO ad_ADDAMTVO) {
		adDAO.deleteAdAddamt(ad_ADDAMTVO);
	}



	/**
	 * 객실 리스트
	 * 파일명 : selectAdPrdinfList
	 * 작성일 : 2015. 10. 15. 오후 3:05:57
	 * 작성자 : 신우섭
	 * @param ad_PRDINFSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectAdPrdinfList(AD_PRDTINFSVO ad_PRDINFSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<AD_PRDTINFVO> resultList = adDAO.selectAdPrdinfList(ad_PRDINFSVO);
		Integer totalCnt = adDAO.getCntAdPrdinfList(ad_PRDINFSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}


	/**
	 * 리얼타임에서 객실 목록
	 * 파일명 : selectAdPrdinfListOfRT
	 * 작성일 : 2015. 12. 2. 오후 4:25:11
	 * 작성자 : 신우섭
	 * @param ad_PRDINFSVO
	 * @return
	 */
	@Override
	public List<AD_PRDTINFVO> selectAdPrdinfListOfRT(AD_PRDTINFVO ad_PRDINFSVO){
		return adDAO.selectAdPrdinfList3(ad_PRDINFSVO);
	}


	/**
	 * 객실 단건
	 * 파일명 : selectByAdPrdinf
	 * 작성일 : 2015. 10. 15. 오후 3:06:15
	 * 작성자 : 신우섭
	 * @param ad_PRDINFVO
	 * @return
	 */
	@Override
	public AD_PRDTINFVO selectByAdPrdinf(AD_PRDTINFVO ad_PRDINFVO) {
		return adDAO.selectByAdPrdinf(ad_PRDINFVO);
	}

	/**
	 * 요금 설정 시 객실 정보 조회
	 * 파일명 : selectByAdAmtInf
	 * 작성일 : 2017. 7. 24. 오후 4:23:27
	 * 작성자 : 정동수
	 * @param ad_PRDINFVO
	 * @return
	 */
	@Override
	public AD_PRDTINFVO selectByAdAmtInf(AD_PRDTINFVO ad_PRDINFVO) {
		return adDAO.selectByAdAmtInf(ad_PRDINFVO);
	}

	@Override
	public AD_PRDTINFVO selectByAdPrdinfTopViewSn(AD_PRDTINFVO ad_PRDINFVO){
		return adDAO.selectByAdPrdinfTopViewSn(ad_PRDINFVO);
	}

	/**
	 * 상품의 연박 사용 여부 수정
	 * Function : updateCtnAplYn
	 * 작성일 : 2017. 6. 19. 오후 4:58:48
	 * 작성자 : 정동수
	 * @param ad_PRDTINFVO
	 */
	@Override
	public void updateCtnAplYn(AD_PRDTINFVO ad_PRDTINFVO) {
		adDAO.updateCtnAplYn(ad_PRDTINFVO);
	}

	/**
	 * 객실 삽입
	 * 파일명 : insertAdPrdinf
	 * 작성일 : 2015. 10. 15. 오후 3:06:39
	 * 작성자 : 신우섭
	 * @param ad_PRDINFVO
	 */
	@Override
	public void insertAdPrdinf(AD_PRDTINFVO ad_PRDINFVO) {

		ad_PRDINFVO.setOldSn(0);
		ad_PRDINFVO.setNewSn(Integer.parseInt(ad_PRDINFVO.getViewSn()));

		addAdPrdinfViewSn(ad_PRDINFVO);

		adDAO.insertAdPrdinf(ad_PRDINFVO);
	}

	/**
	 * 객실 수정
	 * 파일명 : updateAdPrdinf
	 * 작성일 : 2015. 10. 15. 오후 3:07:45
	 * 작성자 : 신우섭
	 * @param ad_PRDINFVO
	 */
	@Override
	public void updateAdPrdinf(AD_PRDTINFVO ad_PRDINFVO) {
		adDAO.updateAdPrdinf(ad_PRDINFVO);

	}

	@Override
	public void approvalPrdt(AD_PRDTINFVO ad_PRDTINFVO) throws Exception{
		adDAO.approvalPrdt(ad_PRDTINFVO);
	}

	@Override
	public void approvalCancelPrdt(AD_PRDTINFVO ad_PRDTINFVO){
		adDAO.approvalCancelPrdt(ad_PRDTINFVO);
	}
	
	@Override
	public void salePrintN(AD_PRDTINFVO ad_PRDTINFVO){
		adDAO.salePrintN(ad_PRDTINFVO);
	}	

	/**
	 * 객실 삭제
	 * 파일명 : deleteAdPrdinf
	 * 작성일 : 2015. 10. 15. 오후 3:07:54
	 * 작성자 : 신우섭
	 * @param ad_PRDINFVO
	 */
	@Override
	public void deleteAdPrdinf(AD_PRDTINFVO ad_PRDINFVO) {

		//객실 수 관련 삭제
		deleteAdCntinfPrdtNum(ad_PRDINFVO.getPrdtNum());

		//객실 가격 관련 삭제
		deleteAdAmtinfPrdtNum(ad_PRDINFVO.getPrdtNum());

		//실재 삭제
		adDAO.deleteAdPrdinf(ad_PRDINFVO);

		//LOGGER.debug(">>>>>>"+ad_PRDINFVO.getViewSn() + ":" +ad_PRDINFVO.getCorpId() );

		//순번 다시 정리
		ad_PRDINFVO.setNewSn(0);
		ad_PRDINFVO.setOldSn(Integer.parseInt(ad_PRDINFVO.getViewSn()));
    	minusAdPrdinfViewSn(ad_PRDINFVO);

	}

	/**
	 * 객실 숫자 얻기
	 * 파일명 : getCntAdPrdinf
	 * 작성일 : 2015. 10. 15. 오후 3:10:25
	 * 작성자 : 신우섭
	 * @param ad_PRDINFSVO
	 * @return
	 */
	@Override
	public int getCntAdPrdinf(AD_PRDTINFSVO ad_PRDINFSVO) {
		Integer totalCnt = adDAO.getCntAdPrdinfList(ad_PRDINFSVO);
		return (int)totalCnt;
	}


	/**
	 * 객실 순번 관련
	 * 파일명 : addAdPrdinfViewSn
	 * 작성일 : 2015. 10. 15. 오후 3:10:36
	 * 작성자 : 신우섭
	 * @param ad_PRDINFVO
	 */
	@Override
	public void addAdPrdinfViewSn(AD_PRDTINFVO ad_PRDINFVO){
		adDAO.addViewSnAdPrdinf(ad_PRDINFVO);
	}

	/**
	 * 객실 순번 관련
	 * 파일명 : minusAdPrdinfViewSn
	 * 작성일 : 2015. 10. 15. 오후 3:10:40
	 * 작성자 : 신우섭
	 * @param ad_PRDINFVO
	 */
	@Override
	public void minusAdPrdinfViewSn(AD_PRDTINFVO ad_PRDINFVO){
		adDAO.minusViewSnAdPrdinf(ad_PRDINFVO);
	}

	/**
	 * 객실 순번 관련
	 * 파일명 : updateAdPrdinfViewSn
	 * 작성일 : 2015. 10. 15. 오후 3:11:05
	 * 작성자 : 신우섭
	 * @param ad_PRDINFVO
	 */
	@Override
	public void updateAdPrdinfViewSn(AD_PRDTINFVO ad_PRDINFVO){
		if(ad_PRDINFVO.getOldSn() > ad_PRDINFVO.getNewSn()){
			// 변경된 순위가 더 낮으므로 원래 변경된 순위에 있는 로우부터 변경전 로우까지 순위들을 +1 시켜준다.
			addAdPrdinfViewSn(ad_PRDINFVO);
		}else{
			minusAdPrdinfViewSn(ad_PRDINFVO);
		}
		adDAO.updateViewSnAdPrdinf(ad_PRDINFVO);
	}



	/**
	 * 객실 요금 단건
	 * 파일명 : selectByAdAmtinf
	 * 작성일 : 2015. 10. 15. 오후 3:11:15
	 * 작성자 : 신우섭
	 * @param ad_AMTINFVO
	 * @return
	 */
	@Override
	public AD_AMTINFVO selectByAdAmtinf(AD_AMTINFVO ad_AMTINFVO) {
		return adDAO.selectByAdAmtinf(ad_AMTINFVO);
	}

	/**
	 * 객실 요금 리스트(달력)
	 * 파일명 : selectAdAmtinfList
	 * 작성일 : 2015. 10. 15. 오후 3:11:31
	 * 작성자 : 신우섭
	 * @param ad_AMTINFSVO
	 * @return
	 */
	@Override
	public List<AD_AMTINFVO> selectAdAmtinfList(AD_AMTINFSVO ad_AMTINFSVO) {
		return (List<AD_AMTINFVO>) adDAO.selectAdAmtinfList(ad_AMTINFSVO);

		//List<AD_AMTINFVO> res = adDAO.selectAdAmtinfList(ad_AMTINFSVO);
		//return res;
	}


	/**
	 * 객실 요금 리스트(달력) - 업체
	 * 파일명 : selectAdAmtinfListMas
	 * 작성일 : 2015. 12. 3. 오후 5:30:51
	 * 작성자 : 신우섭
	 * @param ad_AMTINFSVO
	 * @return
	 */
	@Override
	public List<AD_AMTINFVO> selectAdAmtinfListMas(AD_AMTINFSVO ad_AMTINFSVO) {
		return (List<AD_AMTINFVO>) adDAO.selectAdAmtinfListMas(ad_AMTINFSVO);

		//List<AD_AMTINFVO> res = adDAO.selectAdAmtinfList(ad_AMTINFSVO);
		//return res;
	}


	/**
	 * 객실 요금 달력 입력/수정
	 * 파일명 : mergeAmtinf
	 * 작성일 : 2015. 10. 15. 오후 3:11:46
	 * 작성자 : 신우섭
	 * @param listAmtinf
	 */
	@Override
	public void mergeAmtinf(List<AD_AMTINFVO> listAmtinf) {
		for(Object object :listAmtinf){
			AD_AMTINFVO amtinf = (AD_AMTINFVO)object;

			//LOGGER.debug(">>>>["+ amtinf.getPrdtNum()
			//				+ "][" + amtinf.getAplDt()
			//				+ "][" + amtinf.getSaleAmt()
			//				+ "][" + amtinf.getNmlAmt()
			//				+ "][" + amtinf.getHotdallYn()
			//				+ "][" + amtinf.getDaypriceYn()
			//				+ "][" + amtinf.getDaypriceAmt()
			//				+"]"
			//				);

			adDAO.mergeAdAmtinf(amtinf);
		}

	}

	/**
	 * 객실 요금 - 간단 입력/수정
	 * 파일명 : mergeAmtinfCalSmp
	 * 작성일 : 2015. 10. 14. 오후 5:56:51
	 * 작성자 : 신우섭
	 * @param ad_AMTINFVO
	 */
	@Override
	public void mergeAmtinfCalSmp(AD_AMTINFVO ad_AMTINFVO) {

		adDAO.updateAdAmtinfCalSmp(ad_AMTINFVO);

		adDAO.insertAdAmtinfCalSmp(ad_AMTINFVO);
	}

	/**
	 * 객실 요금 삭제 - 상품번호로
	 * 파일명 : deleteAdAmtinfPrdtNum
	 * 작성일 : 2015. 10. 15. 오후 3:12:20
	 * 작성자 : 신우섭
	 * @param strPrdtNum
	 */
	@Override
	public void deleteAdAmtinfPrdtNum(String strPrdtNum) {
		AD_AMTINFVO ad_AMTINFVO = new AD_AMTINFVO();
		ad_AMTINFVO.setPrdtNum(strPrdtNum);
		adDAO.deleteAdAmtinf(ad_AMTINFVO);

	}
	
	/**
	 * 객실 요금 삭제 - 상품번호로
	 * 파일명 : deleteAdAmtinfAplDt
	 * 작성일 : 2015. 10. 15. 오후 3:12:20
	 * 작성자 : 신우섭
	 * @param ad_AMTINFVO
	 */
	@Override
	public void deleteAdAmtinfAplDt(AD_AMTINFVO ad_AMTINFVO) {
		adDAO.deleteAdAmtinfOne(ad_AMTINFVO);
		
	}




	/**
	 * 객실 수 단건
	 * 파일명 : selectByAdCntinf
	 * 작성일 : 2015. 10. 15. 오후 3:14:34
	 * 작성자 : 신우섭
	 * @param ad_CNTINFVO
	 * @return
	 */
	@Override
	public AD_CNTINFVO selectByAdCntinf(AD_CNTINFVO ad_CNTINFVO) {
		return adDAO.selectByAdCntinf(ad_CNTINFVO);
	}


	/**
	 * 객실 수 목록(달력)
	 * 파일명 : selectAdCntinfList
	 * 작성일 : 2015. 10. 15. 오후 3:14:53
	 * 작성자 : 신우섭
	 * @param ad_CNTINFSVO
	 * @return
	 */
	@Override
	public List<AD_CNTINFVO> selectAdCntinfList(AD_CNTINFSVO ad_CNTINFSVO) {
		return (List<AD_CNTINFVO>) adDAO.selectAdCntinfList(ad_CNTINFSVO);
	}


	/**
	 * 객실 수 달력 추가/수정
	 * 파일명 : mergeCntinf
	 * 작성일 : 2015. 10. 15. 오후 3:23:04
	 * 작성자 : 신우섭
	 * @param listCntinf
	 */
	@Override
	public void mergeCntinf(List<AD_CNTINFVO> listCntinf) {
		for(Object object :listCntinf){
			AD_CNTINFVO cntinf = (AD_CNTINFVO)object;

			//LOGGER.debug(">>>>["+ amtinf.getPrdtNum() + "]["+ amtinf.getAplDt() + "][" + amtinf.getSaleAmt() + "][" + amtinf.getNmlAmt() +"]");

			adDAO.mergeAdCntinf(cntinf);
		}

	}

	/**
	 * 객실수 갱신 - API용
	 * 파일명 : mergeCntinfNoDdl
	 * 작성일 : 2015. 11. 18. 오후 4:35:37
	 * 작성자 : 신우섭
	 * @param listCntinf
	 */
	@Override
	public void mergeCntinfNoDdl(List<AD_CNTINFVO> listCntinf) {
		for(Object object :listCntinf){
			AD_CNTINFVO cntinf = (AD_CNTINFVO)object;
			//LOGGER.debug(">>>>["+ amtinf.getPrdtNum() + "]["+ amtinf.getAplDt() + "][" + amtinf.getSaleAmt() + "][" + amtinf.getNmlAmt() +"]");

			adDAO.mergeAdCntinfNoDdl(cntinf);
		}

	}

	/**
	 * 객실 수 간단 입력 추가/수정
	 * 파일명 : mergeCntinfCalSmp
	 * 작성일 : 2015. 10. 15. 오후 3:23:20
	 * 작성자 : 신우섭
	 * @param ad_CNTINFVO
	 */
	@Override
	public void mergeCntinfCalSmp(AD_CNTINFVO ad_CNTINFVO) {

		adDAO.updateAdCntinfCalSmp(ad_CNTINFVO);

		String strTotalRoom = ad_CNTINFVO.getTotalRoomNum();
		if(strTotalRoom.isEmpty()){
			ad_CNTINFVO.setTotalRoomNum("0");
		}
		String strUseRom = ad_CNTINFVO.getUseRoomNum();
		if(strUseRom.isEmpty()){
			ad_CNTINFVO.setUseRoomNum("0");
		}

		String strDdlYn = ad_CNTINFVO.getDdlYn();
		if(strDdlYn.isEmpty()){
			ad_CNTINFVO.setDdlYn("N");
		}

		adDAO.insertAdCntinfCalSmp(ad_CNTINFVO);

	}

	/**
	 * 객실 수 삭제 - 상품번호
	 * 파일명 : deleteAdCntinfPrdtNum
	 * 작성일 : 2015. 10. 15. 오후 3:23:40
	 * 작성자 : 신우섭
	 * @param strPrdtNum
	 */
	@Override
	public void deleteAdCntinfPrdtNum(String strPrdtNum) {
		AD_CNTINFVO ad_CNTINFVO = new AD_CNTINFVO();
		ad_CNTINFVO.setPrdtNum(strPrdtNum);
		adDAO.deleteAdCntinf(ad_CNTINFVO);
	}


	@Override
	public void updateAdCntInfAddFromAPI(AD_RSVVO adRsvVO) {
		adDAO.updateAdCntInfAddFromAPI(adRsvVO);
	}


	@Override
	public void updateAdCntInfMinFromAPI(AD_RSVVO adRsvVO) {
		adDAO.updateAdCntInfMinFromAPI(adRsvVO);
	}

	/**
	 * 당일 예약불가 여부를 체크한 수량 리스트
	 * 파일명 : selectWebAdCntInfList
	 * 작성일 : 2016. 9. 26. 오후 7:48:32
	 * 작성자 : 최영철
	 * @param ad_CNTINFSVO
	 * @return
	 */
	@Override
	public List<AD_CNTINFVO> selectWebAdCntInfList(AD_CNTINFSVO ad_CNTINFSVO){
		return (List<AD_CNTINFVO>) adDAO.selectWebAdCntInfList(ad_CNTINFSVO);
	}

	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오후 4:09:50
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	@Override
	public Integer checkExsistPrdt(RSVSVO rsvSVO){
		return adDAO.checkExsistPrdt(rsvSVO);
	}

	/**
	 * 해당 상품에 해당하는 연박 정보 리스트
	 * Function : selectAdCtnInfList
	 * 작성일 : 2017. 6. 19. 오후 4:15:00
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 * @return
	 */
	@Override
	public List<AD_CTNINFVO> selectAdCtnInfList(AD_CTNINFVO ad_CtnInf) {
		return (List<AD_CTNINFVO>) adDAO.selectAdCtnInfList(ad_CtnInf);
	}

	/**
	 * 해당 상품에 해당하는 연박 정보 산출
	 * Function : selectAdCtnInfoInfo
	 * 작성일 : 2017. 6. 21. 오후 5:53:07
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 * @return
	 */
	@Override
	public AD_CTNINFVO selectAdCtnInfoInfo(AD_CTNINFVO ad_CtnInf) {
		return (AD_CTNINFVO) adDAO.selectAdCtnInfoInfo(ad_CtnInf);
	}

	/**
	 * 해당 상품에 해당하는 연박 정보 등록
	 * Function : insertAdCtnInf
	 * 작성일 : 2017. 6. 19. 오후 5:42:12
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 */
	@Override
	public void insertAdCtnInf(AD_CTNINFVO ad_CtnInf) {
		ad_CtnInf.setStartDt(ad_CtnInf.getStartDt().replace("-", ""));
		ad_CtnInf.setEndDt(ad_CtnInf.getEndDt().replace("-", ""));

		adDAO.insertAdCtnInf(ad_CtnInf);
	}

	/**
	 * 해당 상품에 해당하는 연박 정보 수정
	 * Function : updateAdCtnInf
	 * 작성일 : 2017. 6. 19. 오후 5:42:34
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 */
	@Override
	public void updateAdCtnInf(AD_CTNINFVO ad_CtnInf) {
		ad_CtnInf.setStartDt(ad_CtnInf.getStartDt().replace("-", ""));
		ad_CtnInf.setEndDt(ad_CtnInf.getEndDt().replace("-", ""));

		adDAO.updateAdCtnInf(ad_CtnInf);
	}
	
	
	/**
	 * 해당 상품에 해당하는 연박 기간 삭제
	 * Function : deleteAdCtnInf
	 * 작성일 : 2018. 1. 12. 오전 11:19:14
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 */
	@Override
	public void deleteAdCtnInf(AD_CTNINFVO ad_CtnInf) {
		adDAO.deleteAdCtnAmt(ad_CtnInf); 	// 연박 요금 삭제
		adDAO.deleteAdCtnInf(ad_CtnInf); 	// 연박 기간 삭제
	}

	/**
	 * 기간 정보에 해당하는 연박 요금 정보 리스트 출력
	 * Function : selectAdCtnAmt
	 * 작성일 : 2017. 6. 27. 오전 10:33:36
	 * 작성자 : 정동수
	 * @param ad_CtnAmt
	 * @return
	 */
	@Override
	public List<AD_CTNAMTVO> selectAdCtnAmt(AD_CTNAMTVO ad_CtnAmt) {
		return adDAO.selectAdCtnAmt(ad_CtnAmt);
	}

	/**
	 * 기간 정보에 해당하는 연박 요금 정보 리스트 출력
	 * Function : selectAdCtnAmt
	 * 작성일 : 2017. 6. 27. 오전 10:33:36
	 * 작성자 : 정동수
	 * @param ad_CtnAmt
	 * @return
	 */
	@Override
	public AD_CTNAMTVO selectCtnAmtStr(AD_CTNAMTVO ad_CtnAmt) {
		return adDAO.selectCtnAmtStr(ad_CtnAmt);
	}


	/**
	 * 해당 상품에 해당하는 연박 요금 정보 저장
	 * Function : updateAdCtnAmt
	 * 작성일 : 2017. 6. 21. 오후 4:12:30
	 * 작성자 : 정동수
	 * @param ad_CtnAmt
	 */
	@Override
	public void updateAdCtnAmt(AD_CTNAMTVO ad_CtnAmt) {
		if (ad_CtnAmt.getDisAmt() == null)
			ad_CtnAmt.setDisAmt("0");

		adDAO.updateAdCtnAmt(ad_CtnAmt);
	}


	@Override
	public AD_BREAKFASTAMTVO selectByAdBreakfastAmt(String corpId) {
		return adDAO.selectByAdBreakfastAmt(corpId);
	}


	@Override
	public void updateAdBreakfastAmt(AD_BREAKFASTAMTVO ad_breakfastamtVO) {
		adDAO.updateAdBreakfastAmt(ad_breakfastamtVO);

	}


	




}
