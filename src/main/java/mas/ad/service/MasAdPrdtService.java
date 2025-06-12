package mas.ad.service;

import java.util.List;
import java.util.Map;

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
import web.order.vo.AD_RSVVO;
import web.order.vo.RSVSVO;



public interface MasAdPrdtService {

	AD_DFTINFVO selectByAdDftinf(AD_DFTINFVO adDftinfVO);
	void insertAdDftinf(AD_DFTINFVO adDftinfVO);
	void updateAdDftinf(AD_DFTINFVO adDftinfVO);
	void deleteAdDftinf(AD_DFTINFVO adDftinfVO);


	Map<String, Object> selectAdAddamtList(AD_ADDAMTSVO ad_ADDAMTSVO);
	AD_ADDAMTVO selectByAdAddamt(AD_ADDAMTVO ad_ADDAMTVO);
	void insertAdAddamt(AD_ADDAMTVO ad_ADDAMTVO);
	void updateAdAddamt(AD_ADDAMTVO ad_ADDAMTVO);
	void deleteAdAddamt(AD_ADDAMTVO ad_ADDAMTVO);
	int getAddAmtListCount(AD_ADDAMTSVO ad_addamtsvo);

	Map<String, Object> selectAdPrdinfList(AD_PRDTINFSVO ad_PRDINFSVO);
	AD_PRDTINFVO selectByAdPrdinf(AD_PRDTINFVO ad_PRDINFVO);
	/**
	 * 요금 설정 시 객실 정보 조회
	 * 파일명 : selectByAdAmtInf
	 * 작성일 : 2017. 7. 24. 오후 4:23:27
	 * 작성자 : 정동수
	 * @param ad_PRDINFVO
	 * @return
	 */
	AD_PRDTINFVO selectByAdAmtInf(AD_PRDTINFVO ad_PRDINFVO);
	List<AD_PRDTINFVO> selectAdPrdinfListOfRT(AD_PRDTINFVO ad_PRDINFSVO);
	void insertAdPrdinf(AD_PRDTINFVO ad_PRDINFVO);
	void updateAdPrdinf(AD_PRDTINFVO ad_PRDINFVO);
	void deleteAdPrdinf(AD_PRDTINFVO ad_PRDINFVO);
	int getCntAdPrdinf(AD_PRDTINFSVO ad_PRDINFSVO);
	AD_PRDTINFVO selectByAdPrdinfTopViewSn(AD_PRDTINFVO ad_PRDINFVO);

	/**
	 * 상품의 연박 사용 여부 수정
	 * Function : updateCtnAplYn
	 * 작성일 : 2017. 6. 19. 오후 4:58:48
	 * 작성자 : 정동수
	 * @param ad_PRDTINFVO
	 */
	void updateCtnAplYn(AD_PRDTINFVO ad_PRDTINFVO);

	void approvalPrdt(AD_PRDTINFVO ad_PRDTINFVO) throws Exception;
	void approvalCancelPrdt(AD_PRDTINFVO ad_PRDTINFVO);
	void salePrintN(AD_PRDTINFVO ad_PRDTINFVO);

	void addAdPrdinfViewSn(AD_PRDTINFVO ad_PRDINFVO);
	void minusAdPrdinfViewSn(AD_PRDTINFVO ad_PRDINFVO);
	void updateAdPrdinfViewSn(AD_PRDTINFVO ad_PRDINFVO);


	AD_AMTINFVO selectByAdAmtinf(AD_AMTINFVO ad_AMTINFVO);
	List<AD_AMTINFVO> selectAdAmtinfList(AD_AMTINFSVO ad_AMTINFSVO);
	List<AD_AMTINFVO> selectAdAmtinfListMas(AD_AMTINFSVO ad_AMTINFSVO);
	void mergeAmtinf(List<AD_AMTINFVO> listAmtinf);
	void mergeAmtinfCalSmp(AD_AMTINFVO ad_AMTINFVO);
	void deleteAdAmtinfPrdtNum(String strPrdtNum);
	void deleteAdAmtinfAplDt(AD_AMTINFVO ad_AMTINFVO);

	AD_CNTINFVO selectByAdCntinf(AD_CNTINFVO ad_CNTINFVO);
	List<AD_CNTINFVO> selectAdCntinfList(AD_CNTINFSVO ad_CNTINFSVO);
	void mergeCntinf(List<AD_CNTINFVO> listCntinf);
	void mergeCntinfNoDdl(List<AD_CNTINFVO> listCntinf);
	void mergeCntinfCalSmp(AD_CNTINFVO ad_CNTINFVO);
	void deleteAdCntinfPrdtNum(String strPrdtNum);

	void updateAdCntInfAddFromAPI(AD_RSVVO adRsvVO);
	void updateAdCntInfMinFromAPI(AD_RSVVO adRsvVO);

	/**
	 * 당일 예약불가 여부를 체크한 수량 리스트
	 * 파일명 : selectWebAdCntInfList
	 * 작성일 : 2016. 9. 26. 오후 7:48:32
	 * 작성자 : 최영철
	 * @param ad_CNTINFSVO
	 * @return
	 */
	List<AD_CNTINFVO> selectWebAdCntInfList(AD_CNTINFSVO ad_CNTINFSVO);

	/**
	 * 해당 상품에 예약건이 존재하는지 확인
	 * 파일명 : checkExsistPrdt
	 * 작성일 : 2016. 11. 23. 오후 4:09:50
	 * 작성자 : 최영철
	 * @param rsvSVO
	 * @return
	 */
	Integer checkExsistPrdt(RSVSVO rsvSVO);

	/**
	 * 해당 상품에 해당하는 연박 정보 리스트
	 * Function : selectAdCtnInfList
	 * 작성일 : 2017. 6. 19. 오후 4:15:00
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 * @return
	 */
	List<AD_CTNINFVO> selectAdCtnInfList(AD_CTNINFVO ad_CtnInf);

	/**
	 * 해당 상품에 해당하는 연박 정보 산출
	 * Function : selectAdCtnInfoInfo
	 * 작성일 : 2017. 6. 21. 오후 5:53:07
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 * @return
	 */
	AD_CTNINFVO selectAdCtnInfoInfo(AD_CTNINFVO ad_CtnInf);

	/**
	 * 해당 상품에 해당하는 연박 정보 등록
	 * Function : insertAdCtnInf
	 * 작성일 : 2017. 6. 19. 오후 5:42:12
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 */
	void insertAdCtnInf(AD_CTNINFVO ad_CtnInf);

	/**
	 * 해당 상품에 해당하는 연박 정보 수정
	 * Function : updateAdCtnInf
	 * 작성일 : 2017. 6. 19. 오후 5:42:34
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 */
	void updateAdCtnInf(AD_CTNINFVO ad_CtnInf);
	
	/**
	 * 해당 상품에 해당하는 연박 기간 삭제
	 * Function : deleteAdCtnInf
	 * 작성일 : 2018. 1. 12. 오전 11:19:14
	 * 작성자 : 정동수
	 * @param ad_CtnInf
	 */
	void deleteAdCtnInf(AD_CTNINFVO ad_CtnInf);

	/**
	 * 기간 정보에 해당하는 연박 요금 정보 리스트 출력
	 * Function : selectAdCtnAmt
	 * 작성일 : 2017. 6. 27. 오전 10:33:36
	 * 작성자 : 정동수
	 * @param ad_CtnAmt
	 * @return
	 */
	List<AD_CTNAMTVO> selectAdCtnAmt(AD_CTNAMTVO ad_CtnAmt);

	/**
	 * 적용된 요금 정보 산출
	 * Function : selectCtnAmtStr
	 * 작성일 : 2017. 6. 30. 오후 2:20:58
	 * 작성자 : 정동수
	 * @param ad_CtnAmt
	 * @return
	 */
	AD_CTNAMTVO selectCtnAmtStr(AD_CTNAMTVO ad_CtnAmt);

	/**
	 * 해당 상품에 해당하는 연박 요금 정보 저장
	 * Function : updateAdCtnAmt
	 * 작성일 : 2017. 6. 21. 오후 4:12:30
	 * 작성자 : 정동수
	 * @param ad_CtnAmt
	 */
	void updateAdCtnAmt(AD_CTNAMTVO ad_CtnAmt);


	AD_BREAKFASTAMTVO selectByAdBreakfastAmt(String corpId);

	void updateAdBreakfastAmt(AD_BREAKFASTAMTVO ad_breakfastamtVO);
}
