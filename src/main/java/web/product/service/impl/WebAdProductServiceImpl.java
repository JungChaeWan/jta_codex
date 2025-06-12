package web.product.service.impl;

import api.service.impl.APITLDAO;
import common.Constant;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import mas.ad.service.impl.AdDAO;
import mas.ad.vo.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import oss.ad.vo.*;
import oss.cmm.service.OssCmmService;
import oss.cmm.vo.CDVO;
import oss.prdt.service.impl.PrdtDAO;
import web.order.vo.AD_RSV_DAYPRICEVO;
import web.product.service.WebAdProductService;
import web.product.vo.ADTOTALPRICEVO;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;


@Service("webAdProductService")
public class WebAdProductServiceImpl extends EgovAbstractServiceImpl implements WebAdProductService {

	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(WebAdProductServiceImpl.class);

	@Resource(name = "prdtDAO")
	private PrdtDAO prdtDAO;

	@Resource(name = "webAdDAO")
	private WebAdDAO webAdDAO;

	@Resource(name = "adDAO")
	private AdDAO adDAO;

	@Resource(name = "webAdProductService")
	protected WebAdProductService webAdProductService;

	@Resource(name = "ossCmmService")
	protected OssCmmService ossCmmService;

	@Resource(name = "APITLDAO")
	private APITLDAO apiTlDao;

	//숙소 리스트 - 카운트포함 (모바일에서 쓰임)
	@Override
	public Map<String, Object> selectAdPrdtList(AD_WEBLISTSVO prdtSVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<AD_WEBLISTVO> resultList = new ArrayList<AD_WEBLISTVO>();
		/*Integer totalCnt = 0;*/

		resultList = webAdDAO.selectAdList(prdtSVO);
		/*totalCnt = webAdDAO.getCntAdList(prdtSVO);*/

		resultMap.put("resultList", resultList);
		/*resultMap.put("totalCnt", totalCnt);*/

		return resultMap;
	}

	//숙소 리스트 - 카운트제외 (웹)
	public List<AD_WEBLISTVO> selectAdList(AD_WEBLISTSVO prdtSVO){
		return webAdDAO.selectAdList(prdtSVO);
	}

	////모바일 지도 리스트
	public List<AD_WEBLISTVO> selectAdMapList(AD_WEBLISTSVO prdtSVO){
		return webAdDAO.selectAdMapList(prdtSVO);
	}

	@Override
	public List<AD_WEBLISTVO> selectAdListOssPrmt(AD_WEBLISTSVO prdtSVO) {
		return webAdDAO.selectAdListOssPrmt(prdtSVO);
	}


	@Override
	public List<AD_WEBLISTVO> selectAdPrdtListDist(String strLat, String strLon, int nRowCnt) {

		AD_WEBLISTSVO prdtSVO = new AD_WEBLISTSVO();

		Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	String  strToday = sdf.format(now);

    	prdtSVO.setsLAT(strLat);
    	prdtSVO.setsLON(strLon);    	
    	prdtSVO.setsNights("1");
    	prdtSVO.setsRoomNum("1");
    	prdtSVO.setsToDt(prdtSVO.getsFromDt());
    	prdtSVO.setsSearchYn(Constant.FLAG_N);
    	prdtSVO.setsResEnable("1");//예약가능 여부
    	prdtSVO.setsFromDt(strToday);
    	prdtSVO.setFirstIndex(0);
    	prdtSVO.setLastIndex(nRowCnt);
    	// 2016.4.14 (최영철 추가) 거리순 order by
    	prdtSVO.setOrderCd(Constant.ORDER_DIST);

    	return webAdDAO.selectAdList(prdtSVO);

	}



	@Override
	public List<AD_PRDTCNTVO> selectAdPrdtCnt(AD_WEBLISTSVO prdtSVO) {
		List<AD_PRDTCNTVO> resultList = new ArrayList<AD_PRDTCNTVO>();

		if (Constant.FLAG_Y.equals(prdtSVO.getsSearchYn())) {
			List<AD_WEBLISTVO> adList = webAdDAO.selectAdList(prdtSVO);

			for (AD_WEBLISTVO ad : adList) {
				// 마감/미정 체크
				int nPrice = webAdProductService.getTotalPrice(ad.getPrdtNum(), ad.getAplDt(), 1, 1, 0, 0);

				if (nPrice > 0) {
					boolean chkFlag = true;
					for (AD_PRDTCNTVO cnt : resultList) {
						if (ad.getAdDiv().equals(cnt.getAdDiv())) {
							cnt.setCnt("" + (Integer.parseInt(cnt.getCnt()) + 1));
							chkFlag = false;
							break;
						}
					}

					if (chkFlag) {
						AD_PRDTCNTVO cntPrdt = new AD_PRDTCNTVO();
						cntPrdt.setAdDiv(ad.getAdDiv());
						cntPrdt.setCnt("1");
						resultList.add(resultList.size(), cntPrdt);
					}
				}
			}

			// 숙소 유형별 값 보정
	    	List<CDVO> cdAddv = ossCmmService.selectCode("ADDV");
	    	for (CDVO cd : cdAddv) {
	    		boolean chkCd = false;
	    		for (AD_PRDTCNTVO tmp : resultList) {
	    			if (cd.getCdNum().equals(tmp.getAdDiv())) {
	    				chkCd = true;
	    				break;
	    			}
	    		}
	    		if (chkCd)
	    			continue;

	    		AD_PRDTCNTVO cntPrdt = new AD_PRDTCNTVO();
				cntPrdt.setAdDiv(cd.getCdNum());
				cntPrdt.setCnt("0");
				resultList.add(cntPrdt);
	    	}
		} else {
			resultList = webAdDAO.selectAdPrdtCnt(prdtSVO);

		}
		return resultList;
	}


	@Override
	public List<AD_WEBLIST2VO> selectBestAdList(AD_WEBLISTSVO prdtSVO) {
		return webAdDAO.selectBestAdList(prdtSVO);
	}


	@Override
	public AD_WEBDTLVO selectWebdtlByPrdt(AD_WEBDTLSVO prdtVO) {
		return webAdDAO.selectWebdtlByPrdt(prdtVO);
	}


	@Override
	public List<AD_PRDTINFVO> selectAdPrdList(AD_PRDTINFVO prdtSVO) {
		return webAdDAO.selectAdPrdList(prdtSVO);
	}


	@Override
	public List<AD_AMTINFVO> selectAdAmtListDtl(AD_AMTINFSVO prdtSVO) {
		return webAdDAO.selectAdAmtListDtl(prdtSVO);
	}


	@Override
	public AD_ADDAMTVO selectAddamtByDt(AD_ADDAMTVO prdtVO) {
		return webAdDAO.selectAddamtByDt(prdtVO);

	}

	@Override
	public AD_PRDTINFVO selectPrdtInfByMaster(AD_PRDTINFVO prdtVO){
		return webAdDAO.selectPrdtInfByMaster(prdtVO);
	}

	@Override
	public AD_PRDTINFVO selectPrdtInfByPrdtNum(AD_PRDTINFVO adPrdtVO) {
		return webAdDAO.selectPrdtInfByPrdtNum(adPrdtVO);
	}

	/**
	 * 날짜,몇박,인원 입력하면 금액 리턴하는 함수
	 * 파일명 : getTotalPrice
	 * 작성일 : 2015. 11. 4. 오전 9:50:11
	 * 작성자 : 신우섭
	 * @params prdtNum		: 상품명
	 * @params sFromDt		: 예약일자
	 * @params iNight		: 몇박
	 * @params iMenAdult		: 성인 예약인원
	 * @params iMenJunior	: 소아 예약인원
	 * @params iMenChild		: 유아 예약인원
	 * @return 0보다 큰 숫자이면 총금액, 0=예약인원 0, -1=예약가능인원 오버, -2=예약불가(마감/미정), -3=없는 상품번호
	 */
	@Override
	public int getTotalPrice(ADTOTALPRICEVO adTotPrice){
		ADTOTALPRICEVO adTotalPriceVO = getTotalPrice(adTotPrice.getPrdtNum(), adTotPrice);
		
		return adTotalPriceVO.getiTotalPrice();
	}

	@Override
	public int getNmlAmt(ADTOTALPRICEVO adTotPrice){
		ADTOTALPRICEVO adTotalPriceVO = getTotalPrice(adTotPrice.getPrdtNum(), adTotPrice);
		return adTotalPriceVO.getiTotalNmlAmt();
	}
	
	/**
	 * 날짜,몇박,인원 입력하면 ADTOTALPRICEVO 리턴
	 * Function : getTotalPrice
	 * 작성일 : 2017. 10. 20. 오후 5:05:26
	 * 작성자 : 정동수
	 * @param prdtNum
	 * @param adTotPrice
	 * @return ADTOTALPRICEVO
	 */
	@Override
	public ADTOTALPRICEVO getTotalPrice(String prdtNum, ADTOTALPRICEVO adTotPrice) {
		//public int getTotalPrice(String prdtNum, String sFromDt, int iNight, int iMenAdult, int iMenJunior, int iMenChild) {
		
		String sFromDt 	= adTotPrice.getsFromDt();
		int iNight		= adTotPrice.getiNight();
		int iMenAdult	= adTotPrice.getiMenAdult();
		int iMenJunior	= adTotPrice.getiMenJunior();
		int iMenChild	= adTotPrice.getiMenChild();

		int nRtnPrice	= 1;
		int iTotalNmlAmt= 1;
		
		// 초과 요금 초기화
		adTotPrice.setiTotalOverAmt(0);

		//입력사용자가 전부 0이면
		if(iMenAdult==0 && iMenJunior==0 && iMenChild==0){
			adTotPrice.setiTotalPrice(0);
			
			return adTotPrice;
		}

		//과거 날짜 이면
		Date now = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	String  strToday = sdf.format(now);
    	if( strToday.compareTo(sFromDt) > 0){
    		adTotPrice.setiTotalPrice(-2);
			
			return adTotPrice;
    	}

		//adDAO.selectAdP

		//객실 정보 얻기
		AD_PRDTINFVO adPrdtVO = new AD_PRDTINFVO();
		adPrdtVO.setPrdtNum(prdtNum);
		AD_PRDTINFVO adPrdtRes = webAdDAO.selectPrdtInfByPrdtNum(adPrdtVO);
		if(adPrdtRes==null){
    		adTotPrice.setiTotalPrice(-3);
			
			return adTotPrice;
		}

		//접수 기준/최대 인원 구하기
		int iMenStd = Integer.parseInt(adPrdtRes.getStdMem());	//기준인원
		int iMenMax = 0;										//최대인원
		if("Y".equals( adPrdtRes.getMemExcdAbleYn() )){
			iMenMax = Integer.parseInt(adPrdtRes.getMaxiMem());
		}else{
			iMenMax = Integer.parseInt(adPrdtRes.getStdMem());
		}

		//최대인원 초과 검사
		if( iMenAdult+iMenJunior+iMenChild > iMenMax ){
    		adTotPrice.setiTotalPrice(-1);
			
			return adTotPrice;
		}

		//수량 정보 얻기
		AD_CNTINFSVO adCntSVO = new AD_CNTINFSVO();
		adCntSVO.setsPrdtNum(prdtNum);
		adCntSVO.setStartDt(sFromDt);
		adCntSVO.setsNights(""+iNight);
		List<AD_CNTINFVO> adCntList =  webAdDAO.selectAdCntinfListByTPrice(adCntSVO);

		//수량 검사하면서 안되는거 검사
		boolean bCntFlag = true;
		for (AD_CNTINFVO ad_CNTINFVO : adCntList) {
			//마감이면 예약 불가
			if("".equals(ad_CNTINFVO.getDdlYn()) ){
				bCntFlag = false;
				break;

			}else if( "Y".equals(ad_CNTINFVO.getDdlYn()) ){
				bCntFlag = false;
				break;

			}else{

				int iTot = Integer.parseInt(ad_CNTINFVO.getTotalRoomNum());
				int iUse = Integer.parseInt(ad_CNTINFVO.getUseRoomNum());

				// 전체수가 0(null)이면 마감
				if( iTot==0 ){
					bCntFlag = false;
					break;
				}

				//사용수가 전체수보다 같거나 많으면 마감
				if( iTot<=iUse ){
					bCntFlag = false;
					break;
				}
			}
		}
		if(bCntFlag == false){
    		adTotPrice.setiTotalPrice(-2);
			
			return adTotPrice;
		}

		//금액 정보 얻기
		AD_AMTINFSVO adAmtSVO = new AD_AMTINFSVO();
		adAmtSVO.setsPrdtNum(prdtNum);
		adAmtSVO.setStartDt(sFromDt);
		adAmtSVO.setsNights(""+iNight);
		List<AD_AMTINFVO> adAmtList =  webAdDAO.selectAdAmtinfListByTPrice(adAmtSVO);

		//날짜별 금액계산
		nRtnPrice = 0;
		iTotalNmlAmt = 0;
		int iBasePrice = 0; //캘린더 예약 합계 구하는 식에서 사용

		boolean bAmtFlag = true;
		for (AD_AMTINFVO ad_AMTINFVO : adAmtList) {
			int iSaleAmt = Integer.parseInt( ad_AMTINFVO.getSaleAmt() );
			int iNmlAmt = Integer.parseInt( ad_AMTINFVO.getNmlAmt() );
			if(iSaleAmt == 0 || iNmlAmt == 0){
				bAmtFlag = false;
				break;
			}
			nRtnPrice += iSaleAmt;
			iTotalNmlAmt += iNmlAmt;
			iBasePrice += iSaleAmt;

		}
		if(bAmtFlag == false){
    		adTotPrice.setiTotalPrice(-2);
			
			return adTotPrice;
		}

		//날짜별 추가요금 얻기
		List<AD_ADDAMTVO> adAddAmtList = new ArrayList<AD_ADDAMTVO>();
		for (AD_AMTINFVO ad_AMTINFVO : adAmtList) {

			//객실 추가 요금 얻기
			AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
    		ad_ADDAMTVO.setAplStartDt( ad_AMTINFVO.getAplDt() );
    		ad_ADDAMTVO.setCorpId( adPrdtRes.getPrdtNum() );
    	//	ad_ADDAMTVO.setCorpId( adPrdtRes.getCorpId() );
    		AD_ADDAMTVO adAddAmt = webAdDAO.selectAddamtDtTPrice(ad_ADDAMTVO);
    		//System.out.println("---------------------1[[["+ad_AMTINFVO.getAplDt() + " - " + adPrdtRes.getPrdtNum());

    		if(adAddAmt == null){

    			//숙소 추가 요금 얻기
	    		ad_ADDAMTVO.setCorpId( adPrdtRes.getCorpId() );
	    		//System.out.println("---------------------2[[["+ad_AMTINFVO.getAplDt() + " - "+adPrdtRes.getCorpId() );

	    		adAddAmt = webAdDAO.selectAddamtDtTPrice(ad_ADDAMTVO);
	    		if(adAddAmt == null){
	    			//System.out.println("---------------------3[[["+ad_AMTINFVO.getAplDt()  );
	    			adAddAmt = new AD_ADDAMTVO();
	    			adAddAmt.setAdultAddAmt("0");
	    			adAddAmt.setJuniorAddAmt("0");
	    			adAddAmt.setChildAddAmt("0");
	    		}
    		}

    		adAddAmtList.add(adAddAmt);
		}


		//오버된 인원 계산
		int iTotalOverAmt = 0;
		int iMenStdC = iMenStd;
		int iMenAdultC = iMenAdult;
		int iMenJuniorC = iMenJunior;
		int iMenChildC = iMenChild;

		//추가인원 추가요금을 받을때
		int iAdultAddAmt = 0;
		int iChildAddAmt = 0;
		int iJuniorAddAmt = 0;

		if("Y".equals(adPrdtRes.getAddamtYn())){

			//LOGGER.debug(">>>>01-MenStd[" + iMenStdC + "][MenMax[" + iMenMaxC + "][TotMen[" + iTotMenC + "][MenAdult[" + iMenAdultC	 + "][MenJunior[" + iMenJuniorC + "][MenChild[" + iMenChildC + "]");

			for(int i=0; i<iMenAdult; i++){
				if(iMenStdC==0){
					break;
				}
				if(iMenAdultC==0){
					break;
				}
				iMenStdC--;
				iMenAdultC--;
			}
			//LOGGER.debug(">>>>02-MenStd[" + iMenStdC + "][MenMax[" + iMenMaxC + "][TotMen[" + iTotMenC + "][MenAdult[" + iMenAdultC	 + "][MenJunior[" + iMenJuniorC + "][MenChild[" + iMenChildC + "]");

			for(int i=0; i<iMenJunior; i++){
				if(iMenStdC==0){
					break;
				}
				if(iMenJuniorC==0){
					break;
				}
				iMenStdC--;
				iMenJuniorC--;
			}
			//LOGGER.debug(">>>>03-MenStd[" + iMenStdC + "][MenMax[" + iMenMaxC + "][TotMen[" + iTotMenC + "][MenAdult[" + iMenAdultC	 + "][MenJunior[" + iMenJuniorC + "][MenChild[" + iMenChildC + "]");

			for(int i=0; i<iMenChild; i++){
				if(iMenStdC==0){
					break;
				}
				if(iMenChildC==0){
					break;
				}
				iMenStdC--;
				iMenChildC--;
			}

			//날짜별 오버된 인원 계산
			for (AD_ADDAMTVO ad_ADDAMTVO : adAddAmtList) {

				//if(!("0".equals(ad_ADDAMTVO.getAdultAddAmt()) ) ){
				nRtnPrice += Integer.parseInt( ad_ADDAMTVO.getAdultAddAmt())*iMenAdultC;
				iTotalNmlAmt += Integer.parseInt( ad_ADDAMTVO.getAdultAddAmt())*iMenAdultC;
				iTotalOverAmt += Integer.parseInt( ad_ADDAMTVO.getAdultAddAmt())*iMenAdultC;
				//}

				//if(!("0".equals(ad_ADDAMTVO.getJuniorAddAmt()) ) ){
				nRtnPrice += Integer.parseInt( ad_ADDAMTVO.getJuniorAddAmt())*iMenJuniorC;
				iTotalNmlAmt += Integer.parseInt( ad_ADDAMTVO.getJuniorAddAmt())*iMenJuniorC;
				iTotalOverAmt += Integer.parseInt( ad_ADDAMTVO.getJuniorAddAmt())*iMenJuniorC;
				//}

				//if(!("0".equals(ad_ADDAMTVO.getChildAddAmt()) ) ){
				nRtnPrice += Integer.parseInt( ad_ADDAMTVO.getChildAddAmt())*iMenChildC;
				iTotalNmlAmt += Integer.parseInt( ad_ADDAMTVO.getChildAddAmt())*iMenChildC;
				iTotalOverAmt += Integer.parseInt( ad_ADDAMTVO.getChildAddAmt())*iMenChildC;
				//}

				iAdultAddAmt += Integer.parseInt( ad_ADDAMTVO.getAdultAddAmt())*iMenAdultC;
				iChildAddAmt += Integer.parseInt( ad_ADDAMTVO.getJuniorAddAmt())*iMenJuniorC;
				iJuniorAddAmt += Integer.parseInt( ad_ADDAMTVO.getChildAddAmt())*iMenChildC;
			}
		}

		// 연박 요금 설정 적용 (2017-06-27, By JDongS)
		if ("Y".equals(adPrdtRes.getCtnAplYn())) {
			// 5박 이상이면 5박으로 설정 후 연박 할인 산출
			if (Integer.parseInt(adAmtSVO.getsNights()) > 5 )
				adAmtSVO.setsNights("" + 5);

			AD_CTNAMTVO ctnAmt = adDAO.selectCtnAmtInfo(adAmtSVO);

			if (ctnAmt != null && Integer.parseInt(ctnAmt.getDisAmt()) > 0)
				nRtnPrice -= Integer.parseInt(ctnAmt.getDisAmt());
		}

		adTotPrice.setiTotalPrice(nRtnPrice	);
		adTotPrice.setiTotalNmlAmt(iTotalNmlAmt);
		adTotPrice.setiTotalOverAmt(iTotalOverAmt);
		adTotPrice.setiAdultAddAmt(iAdultAddAmt);
		adTotPrice.setiChildAddAmt(iChildAddAmt);
		adTotPrice.setiJuniorAddAmt(iJuniorAddAmt);
		adTotPrice.setiBasePrice(iBasePrice);

		LOGGER.debug(">>>>04 [TotalPrice:"+nRtnPrice+"][TotalNmlAmt:"+iTotalNmlAmt+"]");
		
		return adTotPrice;
	}

	@Override
	public int getTotalPrice(String prdtNum, String sFromDt, int iNight, int iMenAdult, int iMenJunior, int iMenChild) {
		ADTOTALPRICEVO adTotPrice = new ADTOTALPRICEVO();
		adTotPrice.setPrdtNum(prdtNum);
		adTotPrice.setsFromDt(sFromDt);
		adTotPrice.setiNight(iNight);
		adTotPrice.setiMenAdult(iMenAdult);
		adTotPrice.setiMenJunior(iMenJunior);
		adTotPrice.setiMenChild(iMenChild);

		return getTotalPrice(adTotPrice);
	}

	@Override
	public int getNmlAmt(String prdtNum, String sFromDt, int iNight, int iMenAdult, int iMenJunior, int iMenChild) {
		ADTOTALPRICEVO adTotPrice = new ADTOTALPRICEVO();
		adTotPrice.setPrdtNum(prdtNum);
		adTotPrice.setsFromDt(sFromDt);
		adTotPrice.setiNight(iNight);
		adTotPrice.setiMenAdult(iMenAdult);
		adTotPrice.setiMenJunior(iMenJunior);
		adTotPrice.setiMenChild(iMenChild);

		return getNmlAmt(adTotPrice);
	}

	@Override
	public int getTotalPrice(String prdtNum, String sFromDt, String sNight,
			String sMenAdult, String sMenJunior, String sMenChild) {

		return getTotalPrice(prdtNum
							, sFromDt
							, Integer.parseInt(sNight)
							, Integer.parseInt(sMenAdult)
							, Integer.parseInt(sMenJunior)
							, Integer.parseInt(sMenChild)
							);

	}

	@Override
	public int getNmlAmt(String prdtNum, String sFromDt, String sNight,
			String sMenAdult, String sMenJunior, String sMenChild) {

		return getNmlAmt(prdtNum
							, sFromDt
							, Integer.parseInt(sNight)
							, Integer.parseInt(sMenAdult)
							, Integer.parseInt(sMenJunior)
							, Integer.parseInt(sMenChild)
							);

	}




	/**
	 * 주변숙소 검색
	 * 파일명 : selectAdListDist
	 * 작성일 : 2015. 11. 12. 오후 4:03:43
	 * 작성자 : 신우섭
	 * @param prdtSVO
	 * @return
	 */
	@Override
	public List<AD_WEBLIST4VO> selectAdListDist(AD_WEBDTLSVO prdtSVO) {
		List<AD_WEBLIST4VO> resultList = new ArrayList<AD_WEBLIST4VO>();
		List<AD_WEBLIST4VO> adList = webAdDAO.selectAdListDist(prdtSVO);
		
		ADTOTALPRICEVO adTotPrice = new ADTOTALPRICEVO();
		adTotPrice.setsFromDt(prdtSVO.getsFromDt());
		adTotPrice.setiNight(Integer.parseInt(prdtSVO.getsNights()));
		adTotPrice.setiMenAdult(Integer.parseInt(prdtSVO.getsAdultCnt()));
		adTotPrice.setiMenJunior(Integer.parseInt(prdtSVO.getsChildCnt()));
		adTotPrice.setiMenChild(Integer.parseInt(prdtSVO.getsBabyCnt()));
				
		for (AD_WEBLIST4VO ad : adList) {
			ADTOTALPRICEVO amtInfo = getTotalPrice(ad.getPrdtNum(), adTotPrice);
			
			if ( amtInfo.getiTotalPrice() > 0){
				ad.setNmlAmt("" + amtInfo.getiTotalNmlAmt());
				ad.setSaleAmt("" + amtInfo.getiTotalPrice());
				
				resultList.add(ad);
			}
			
			if (resultList.size() == 4)
				break;
		}
		
		return resultList;
	}

	/**
	 * 숙박일에 해당하는 연박 적용 요금 리스트 출력
	 * Function : selectCtnAmtList
	 * 작성일 : 2017. 6. 29. 오전 10:30:57
	 * 작성자 : 정동수
	 * @param adAmtSVO
	 * @return
	 */
	@Override
	public List<AD_CTNAMTVO> selectCtnAmtList(AD_AMTINFSVO adAmtSVO) {
		return adDAO.selectCtnAmtList(adAmtSVO);
	}

	/**
	 * 날짜,박수에 핫딜,당일 특가 있는지 검사
	 * 파일명 : getHotdeallAndDayPrice
	 * 작성일 : 2015. 12. 4. 오전 9:44:08
	 * 작성자 : 신우섭
	 * @param adWeb
	 * @return
	 */
	@Override
	public AD_WEBLIST5VO getHotdeallAndDayPrice(AD_WEBLIST5VO adWeb) {
		return webAdDAO.getHotdeallAndDayPrice(adWeb);
	}


	@Override
	public Integer getAllEventCnt(AD_WEBLISTSVO prdtSVO) {
		return webAdDAO.getAllEventCnt(prdtSVO);
	}


	@Override
	public Integer getCntAdList(AD_WEBLISTSVO prdtSVO) {
		return webAdDAO.getCntAdList(prdtSVO);
	}


	/**
	 * 지도 현재 판매중인 숙소 리스트
	 */
	@Override
	public List<AD_WEBDTLVO> selectProductCorpMapList() {
		List<AD_WEBDTLVO> mapAdPoint = webAdDAO.selectProductCorpMapList();
		return mapAdPoint;
	}


	/**
	 * 여행경비산출용 숙박 리스트 조회
	 * 파일명 : selectTeAdPrdtList
	 * 작성일 : 2016. 10. 25. 오전 11:33:04
	 * 작성자 : 최영철
	 * @param prdtSVO
	 * @return
	 */
	@Override
	public Map<String, Object> selectTeAdPrdtList(AD_WEBLISTSVO prdtSVO){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<AD_WEBLISTVO> resultList = webAdDAO.selectTeAdList(prdtSVO);
		Integer totalCnt = webAdDAO.getCntTeAdList(prdtSVO);

		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);

		return resultMap;
	}

	@Override
	public List<AD_WEBLISTVO> selectAdListOssKwa(String kwaNum) {
		return webAdDAO.selectAdListOssKwa(kwaNum);
	}


	/**
	 * 숙박 베스트 상품 리스트 조회
	 * Function : selectAdBestList
	 * 작성일 : 2017. 11. 16. 오후 3:16:04
	 * 작성자 : 정동수
	 * @params prdtSVO
	 * @return
	 */
	@Override
	@Cacheable(value = "adPrmtCache", key = "'main'")
	public List<AD_WEBLISTVO> selectAdBestList() {
		List<AD_WEBLISTVO> adList = webAdDAO.selectAdBestList();
		return adList;
	}

	@Override
	public List<AD_WEBLISTVO> selectAdNmList(AD_WEBLISTSVO prdtSVO) {
		/*List<AD_WEBLISTVO> resultList = new ArrayList<AD_WEBLISTVO>();*/
		List<AD_WEBLISTVO> adList = webAdDAO.selectAdNmList(prdtSVO);
		return adList;
	}

	/**
	* 설명 : 일별 숙박요금 저장
	* 파일명 :
	* 작성일 : 2021-06-28 오후 2:12
	* 작성자 : chaewan.jung
	* @param : rsvNum, adRsvNum, ADTOTALPRICEVO
	* @return :
	* @throws Exception
	*/
	public void insertRsvDayPrice(String rsvNum, String adRsvNum, ADTOTALPRICEVO adTotPrice){
		String prdtNum = adTotPrice.getPrdtNum();
		String sFromDt 	= adTotPrice.getsFromDt();
		int iNight		= adTotPrice.getiNight();
		int iMenAdult	= adTotPrice.getiMenAdult();
		int iMenJunior	= adTotPrice.getiMenJunior();
		int iMenChild	= adTotPrice.getiMenChild();

		//객실 정보 얻기
		AD_PRDTINFVO adPrdtVO = new AD_PRDTINFVO();
		adPrdtVO.setPrdtNum(prdtNum);
		AD_PRDTINFVO adPrdtRes = webAdDAO.selectPrdtInfByPrdtNum(adPrdtVO);

		//접수 기준 인원 구하기
		int iMenStd = Integer.parseInt(adPrdtRes.getStdMem());

		//일자별 금액 정보 얻기
		AD_AMTINFSVO adAmtSVO = new AD_AMTINFSVO();
		adAmtSVO.setsPrdtNum(prdtNum);
		adAmtSVO.setStartDt(sFromDt);
		adAmtSVO.setsNights(""+iNight);
		List<AD_AMTINFVO> adAmtList =  webAdDAO.selectAdAmtinfListByTPrice(adAmtSVO);

		// 연박 할인 요금 첫째날에 적용
		int nCtnPrice = 0;
		if ("Y".equals(adPrdtRes.getCtnAplYn())) {
			//5박 이상이면 5박으로 설정 후 연박 할인 산출
			if (Integer.parseInt(adAmtSVO.getsNights()) > 5 )
				adAmtSVO.setsNights("5");

			AD_CTNAMTVO ctnAmt = adDAO.selectCtnAmtInfo(adAmtSVO);
			if (ctnAmt != null && Integer.parseInt(ctnAmt.getDisAmt()) > 0)
				nCtnPrice = Integer.parseInt(ctnAmt.getDisAmt());
		}

		//기본요금 불러오기
		int index = 0;
		for (AD_AMTINFVO ad_AMTINFVO : adAmtList) {

			//일별 숙박요금 저장 VO
			AD_RSV_DAYPRICEVO adRsvDaypriceVO = new AD_RSV_DAYPRICEVO();

			//객실 추가 요금 얻기
			AD_ADDAMTVO ad_ADDAMTVO = new AD_ADDAMTVO();
			ad_ADDAMTVO.setAplStartDt( ad_AMTINFVO.getAplDt() );
			ad_ADDAMTVO.setCorpId( adPrdtRes.getPrdtNum() ); //룸 별 추가요금 있는지 확인

			AD_ADDAMTVO adAddAmt = webAdDAO.selectAddamtDtTPrice(ad_ADDAMTVO);
			if(adAddAmt == null){
				ad_ADDAMTVO.setCorpId( adPrdtRes.getCorpId()); //숙소 추가 요금 있는지 확인
				adAddAmt = webAdDAO.selectAddamtDtTPrice(ad_ADDAMTVO);
				if(adAddAmt == null) {
					adAddAmt = new AD_ADDAMTVO();
					adAddAmt.setAdultAddAmt("0");
					adAddAmt.setJuniorAddAmt("0");
					adAddAmt.setChildAddAmt("0");
				}
			}

			//오버된 인원 계산
			int iMenStdC = iMenStd;
			int iMenAdultC = iMenAdult;
			int iMenJuniorC = iMenJunior;
			int iMenChildC = iMenChild;
			//추가인원 추가요금을 받을때
			if("Y".equals(adPrdtRes.getAddamtYn())){

				for(int i=0; i<iMenAdult; i++){
					if(iMenStdC==0){
						break;
					}
					if(iMenAdultC==0){
						break;
					}
					iMenStdC--;
					iMenAdultC--;
				}

				for(int i=0; i<iMenJunior; i++){
					if(iMenStdC==0){
						break;
					}
					if(iMenJuniorC==0){
						break;
					}
					iMenStdC--;
					iMenJuniorC--;
				}

				for(int i=0; i<iMenChild; i++){
					if(iMenStdC==0){
						break;
					}
					if(iMenChildC==0){
						break;
					}
					iMenStdC--;
					iMenChildC--;
				}
				adRsvDaypriceVO.setAdultAddAmt(Integer.parseInt( adAddAmt.getAdultAddAmt())*iMenAdultC);
				adRsvDaypriceVO.setJuniorAddAmt(Integer.parseInt( adAddAmt.getJuniorAddAmt())*iMenJuniorC);
				adRsvDaypriceVO.setChildAddAmt(Integer.parseInt( adAddAmt.getChildAddAmt())*iMenChildC);
			} else{
				adRsvDaypriceVO.setAdultAddAmt(0);
				adRsvDaypriceVO.setJuniorAddAmt(0);
				adRsvDaypriceVO.setChildAddAmt(0);
			}

			adRsvDaypriceVO.setRsvNum(rsvNum);
			adRsvDaypriceVO.setAdRsvNum(adRsvNum);
			adRsvDaypriceVO.setAplDt(ad_AMTINFVO.getAplDt());
			adRsvDaypriceVO.setSaleAmt(Integer.parseInt(ad_AMTINFVO.getSaleAmt()));
			adRsvDaypriceVO.setTllPriceLink(apiTlDao.getPriceLink(adPrdtRes.getCorpId())); //금액연동기준
			adRsvDaypriceVO.setDepositAmt(ad_AMTINFVO.getDepositAmt()); //입금가

			//첫째날에 연박할인 적용
			if (nCtnPrice > 0 && index == 0){
				adRsvDaypriceVO.setCtnDisAmt(nCtnPrice);
			} else {
				adRsvDaypriceVO.setCtnDisAmt(0);
			}

			webAdDAO.insertAdRsvDayPrice(adRsvDaypriceVO);

			index++;
		}
	}

	@Override
	public String selectTamnacardYn(String sPrdtNum) {
		return webAdDAO.selectTamnacardYn(sPrdtNum);
	}

	/**
	* 설명 : 당일예약 가능여부 체크
	* 파일명 :
	* 작성일 : 2022-01-06 오전 11:33
	* 작성자 : chaewan.jung
	* @param :
	* @return :
	* @throws Exception
	*/
	public int getDayRsvCnt(Map<String, String> dayRsvCntMap){
		return 	webAdDAO.getDayRsvCnt(dayRsvCntMap);
	}

}
