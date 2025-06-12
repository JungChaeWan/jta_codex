package mas.rc.vo;

import java.util.List;

public class RC_PRDTINFVO extends RC_PRDTINFSVO{

	/** 업체 아이디 */
	private String corpId;
	/** 상품 번호 */
	private String prdtNum;
	/** 거래상태 */
	private String tradeStatus;
	/** 상품 명 */
	private String prdtNm;
	/** 상품 설명 */
	private String prdtExp;
	/** 차종 이미지 */
	private String carImg;
	/** 출력 여부 */
	private String printYn;
	/** 정원 */
	private String maxiNum;
	/** 차량 구분 */
	private String carDiv;
	/** 차량 구분 명 */
	private String carDivNm;
	/** 사용 연료 구분 */
	private String useFuelDiv;
	/** 사용 연료 구분 명 */
	private String useFuelDivNm;
	/** 변속기 구분  */
	private String transDiv;
	/** 변속기 구분 명 */
	private String transDivNm;
	/** 제조사 구분  */
	private String makerDiv;
	/** 차량 코드  */
	private String carCd;
	/** 제조사 구분 명 */
	private String makerDivNm;
	/** 차량 설명 */
	private String cardivExp;
	/** 구매 수  */
	private String buyNum;
	/** 승인 요청 일시 */
	private String confRequestDttm;
	/** 승인 일시 */
	private String confDttm;
	/** 최초 등록 일시 */
	private String frstRegDttm;
	/** 최초 등록 아이디 */
	private String frstRegId;
	/** 최종 수정 일시 */
	private String lastModDttm;
	/** 최종 수정 아이디 */
	private String lastModId;
	/** 연식 */
	private String modelYear;
	/** 선택시간 */
	private String rsvTm;
	/** 계산된 기준시간 */
	private String saleTm;
	/** 업체 명 */
	private String corpNm;
	/** 거래 상태명 */
	private String tradeStatusNm;
	/** 정상가 */
	private String nmlAmt;
	/** 판매가 */
	private String saleAmt;
	/** 할인율 */
	private String disPer;
	/** 대표 이미지 저장경로 */
	private String savePath;
	/** 대표 이미지 파일명 */
	private String saveFileNm;
	/** 예약가능여부 */
	private String ableYn;
	/** 평점 평균 */
	private String gpaAvg;
	/** 평점 수량 */
	private String gpaCnt;
	/** 대여 기준 정보 */
	private String rntStdInf;
	/** 차량 인수 정보 */
	private String carTkovInf;
	/** 참고사항 */
	private String nti;
	/** 취소안내 */
	private String cancelGuide;
	/** api차량대여료 */
	private String carAmt;
	/** api보험료 */
	private String isrAmt;
	private String isrCmGuide;
	private String isrAmtGuide;

	private String rcNm;

	/** 예약 전화 번호 */
	private String rsvTelNum;
	/** 이벤트 카운트 */
	private String eventCnt;
	/** 할인쿠폰 카운트 */
	private String couponCnt;
	/** 노출 순서 */
	private String viewSn;
	private Integer newSn;
	private Integer oldSn;
	/** 주요정보 */
	private String iconCds;
	/** 주요정보 */
	private List<String> iconCd;
	/** 검색어 */
	private String srchWord1;
	private String srchWord2;
	private String srchWord3;
	private String srchWord4;
	private String srchWord5;
	private String srchWord6;
	private String srchWord7;
	private String srchWord8;
	private String srchWord9;
	private String srchWord10;

	private String superbCorpYn;
	/** 렌터카 연계 여부 */
	private String prdtLinkYn;
	/** 렌터카 업체 기준 가능여부 */
	private String corpAbleYn;
	/** 보험여부 구분 */
	private String isrDiv;
	private String printSn;
	private String rcCardivNum;
	/** 보험 종류 구분 */
	private String isrTypeDiv;
	/** 대여 조건 */
	private String rntQlfctAge; // 나이
	private String rntQlfctCareer; // 운전경력
	private String rntQlfctLicense; // 면허종류
	/** 일반자차 */
	private String generalIsrAmt; // 요금
	private String generalIsrAge; // 나이
	private String generalIsrCareer; // 운전경력
	private String generalIsrRewardAmt; // 보상한도
	private String generalIsrBurcha; // 고객부담금
	/** 고급자차 */
	private String luxyIsrAmt; // 요금
	private String luxyIsrAge; // 나이
	private String luxyIsrCareer; // 운전경력
	private String luxyIsrRewardAmt; // 보상한도
	private String luxyIsrBurcha; // 고객부담금
	/** 연계 맵핑 번호 */
	private String linkMappingNum;
	/** 연계 맵핑 보험번호 */
	private String linkMappingIsrNum;
	/** 연계 맵핑 기본금액 */
	private String linkMappingSaleAmt;
	/** 연계 맵핑 보험금액 */
	private String linkMappingIsrAmt;
	/** 연계 맵핑 보험금액 매핑여부 */
	private String corpLinkIsrYn;
	/** 업체 연계 맵핑 여부 */
	private String corpLinkYn;
	private String rsvMaxiTmAplYn;
	private String rsvMaxiTm;
	/** 수량만료기한 */
	private String cntAplDt;
	/** 기간할인율 종료일 */
	private String disperEndDt;
	private String corpRandLevel;
	private String isrDivSort;
	/** 탐나는전 예약가능 여부 **/
	private String tamnacardYn;
	/** 렌터카API업체 구분 **/
	private String apiRentDiv;
	/** 인스API 자차포함여부 {1:미포함,2:포함} **/
	private String insIsrDiv0;
	/** 인스API 보험번호1(일반자차) **/
	private String insIsrDiv1;
	/** 인스API 보험번호2(고급자차) **/
	private String insIsrDiv2;
	/** 입금가 */
	private String netAmt;
	/** 보험1포함 입금가 */
	private String net1Amt;
	/** 보험2포함 입금가 */
	private String net2Amt;
	/** 연동방법 */
	private String totalInterlock;

	/** 차량 정요금*/
	private String regularCarAmt;
	/** 차량 판매가격*/
	private String sellCarAmt;
	/** 차량 할인율*/
	private String carDisRate;

	/** 보험 정요금*/
	private String regularInsuranceAmt;
	/** 보험 판매요금*/
	private String sellInsuranceAmt;
	/** 보험 할인율*/
	private String insuranceDisRate;
	/** 입금가/판매가*/
	private String sellLink;

	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getTradeStatusNm() {
		return tradeStatusNm;
	}
	public void setTradeStatusNm(String tradeStatusNm) {
		this.tradeStatusNm = tradeStatusNm;
	}
	public String getNmlAmt() {
		return nmlAmt;
	}
	public void setNmlAmt(String nmlAmt) {
		this.nmlAmt = nmlAmt;
	}
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getDisPer() {
		return disPer;
	}
	public void setDisPer(String disPer) {
		this.disPer = disPer;
	}
	public String getSavePath() {
		return savePath;
	}
	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	public String getSaveFileNm() {
		return saveFileNm;
	}
	public void setSaveFileNm(String saveFileNm) {
		this.saveFileNm = saveFileNm;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getPrdtNum() {
		return prdtNum;
	}
	public void setPrdtNum(String prdtNum) {
		this.prdtNum = prdtNum;
	}
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getPrdtExp() {
		return prdtExp;
	}
	public void setPrdtExp(String prdtExp) {
		this.prdtExp = prdtExp;
	}
	public String getCarImg() {
		return carImg;
	}
	public void setCarImg(String carImg) {
		this.carImg = carImg;
	}
	public String getPrintYn() {
		return printYn;
	}
	public void setPrintYn(String printYn) {
		this.printYn = printYn;
	}
	public String getMaxiNum() {
		return maxiNum;
	}
	public void setMaxiNum(String maxiNum) {
		this.maxiNum = maxiNum;
	}
	public String getCarDiv() {
		return carDiv;
	}
	public void setCarDiv(String carDiv) {
		this.carDiv = carDiv;
	}
	public String getUseFuelDiv() {
		return useFuelDiv;
	}
	public void setUseFuelDiv(String useFuelDiv) {
		this.useFuelDiv = useFuelDiv;
	}
	public String getFrstRegDttm() {
		return frstRegDttm;
	}
	public void setFrstRegDttm(String frstRegDttm) {
		this.frstRegDttm = frstRegDttm;
	}
	public String getFrstRegId() {
		return frstRegId;
	}
	public void setFrstRegId(String frstRegId) {
		this.frstRegId = frstRegId;
	}
	public String getLastModDttm() {
		return lastModDttm;
	}
	public void setLastModDttm(String lastModDttm) {
		this.lastModDttm = lastModDttm;
	}
	public String getLastModId() {
		return lastModId;
	}
	public void setLastModId(String lastModId) {
		this.lastModId = lastModId;
	}
	public String getTradeStatus() {
		return tradeStatus;
	}
	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
	}
	public String getTransDiv() {
		return transDiv;
	}
	public void setTransDiv(String transDiv) {
		this.transDiv = transDiv;
	}
	public String getMakerDiv() {
		return makerDiv;
	}
	public void setMakerDiv(String makerDiv) {
		this.makerDiv = makerDiv;
	}
	public String getCardivExp() {
		return cardivExp;
	}
	public void setCardivExp(String cardivExp) {
		this.cardivExp = cardivExp;
	}
	public String getBuyNum() {
		return buyNum;
	}
	public void setBuyNum(String buyNum) {
		this.buyNum = buyNum;
	}
	public String getConfRequestDttm() {
		return confRequestDttm;
	}
	public void setConfRequestDttm(String confRequestDttm) {
		this.confRequestDttm = confRequestDttm;
	}
	public String getConfDttm() {
		return confDttm;
	}
	public void setConfDttm(String confDttm) {
		this.confDttm = confDttm;
	}
	public String getRsvTm() {
		return rsvTm;
	}
	public void setRsvTm(String rsvTm) {
		this.rsvTm = rsvTm;
	}
	public String getSaleTm() {
		return saleTm;
	}
	public void setSaleTm(String saleTm) {
		this.saleTm = saleTm;
	}
	public String getCarDivNm() {
		return carDivNm;
	}
	public void setCarDivNm(String carDivNm) {
		this.carDivNm = carDivNm;
	}
	public String getUseFuelDivNm() {
		return useFuelDivNm;
	}
	public void setUseFuelDivNm(String useFuelDivNm) {
		this.useFuelDivNm = useFuelDivNm;
	}
	public String getTransDivNm() {
		return transDivNm;
	}
	public void setTransDivNm(String transDivNm) {
		this.transDivNm = transDivNm;
	}
	public String getMakerDivNm() {
		return makerDivNm;
	}
	public void setMakerDivNm(String makerDivNm) {
		this.makerDivNm = makerDivNm;
	}
	public String getAbleYn() {
		return ableYn;
	}
	public void setAbleYn(String ableYn) {
		this.ableYn = ableYn;
	}
	public String getGpaAvg() {
		return gpaAvg;
	}
	public void setGpaAvg(String gpaAvg) {
		this.gpaAvg = gpaAvg;
	}
	public String getGpaCnt() {
		return gpaCnt;
	}
	public void setGpaCnt(String gpaCnt) {
		this.gpaCnt = gpaCnt;
	}
	public String getRntStdInf() {
		return rntStdInf;
	}
	public void setRntStdInf(String rntStdInf) {
		this.rntStdInf = rntStdInf;
	}
	public String getCarTkovInf() {
		return carTkovInf;
	}
	public void setCarTkovInf(String carTkovInf) {
		this.carTkovInf = carTkovInf;
	}
	public String getNti() {
		return nti;
	}
	public void setNti(String nti) {
		this.nti = nti;
	}
	public String getCancelGuide() {
		return cancelGuide;
	}
	public void setCancelGuide(String cancelGuide) {
		this.cancelGuide = cancelGuide;
	}
	public String getIsrAmtGuide() {
		return isrAmtGuide;
	}
	public void setIsrAmtGuide(String isrAmtGuide) {
		this.isrAmtGuide = isrAmtGuide;
	}
	public String getIsrCmGuide() {
		return isrCmGuide;
	}
	public void setIsrCmGuide(String isrCmGuide) {
		this.isrCmGuide = isrCmGuide;
	}
	public String getRcNm() {
		return rcNm;
	}
	public void setRcNm(String rcNm) {
		this.rcNm = rcNm;
	}
	public String getEventCnt() {
		return eventCnt;
	}
	public void setEventCnt(String eventCnt) {
		this.eventCnt = eventCnt;
	}
	public String getCouponCnt() {
		return couponCnt;
	}
	public void setCouponCnt(String couponCnt) {
		this.couponCnt = couponCnt;
	}
	public String getRsvTelNum() {
		return rsvTelNum;
	}
	public void setRsvTelNum(String rsvTelNum) {
		this.rsvTelNum = rsvTelNum;
	}
	public String getViewSn() {
		return viewSn;
	}
	public void setViewSn(String viewSn) {
		this.viewSn = viewSn;
	}
	public Integer getNewSn() {
		return newSn;
	}
	public void setNewSn(Integer newSn) {
		this.newSn = newSn;
	}
	public Integer getOldSn() {
		return oldSn;
	}
	public void setOldSn(Integer oldSn) {
		this.oldSn = oldSn;
	}
	public List<String> getIconCd() {
		return iconCd;
	}
	public void setIconCd(List<String> iconCd) {
		this.iconCd = iconCd;
	}
	public String getCarCd() {
		return carCd;
	}
	public void setCarCd(String carCd) {
		this.carCd = carCd;
	}
	public String getSrchWord1() {
		return srchWord1;
	}
	public void setSrchWord1(String srchWord1) {
		this.srchWord1 = srchWord1;
	}
	public String getSrchWord2() {
		return srchWord2;
	}
	public void setSrchWord2(String srchWord2) {
		this.srchWord2 = srchWord2;
	}
	public String getSrchWord3() {
		return srchWord3;
	}
	public void setSrchWord3(String srchWord3) {
		this.srchWord3 = srchWord3;
	}
	public String getSrchWord4() {
		return srchWord4;
	}
	public void setSrchWord4(String srchWord4) {
		this.srchWord4 = srchWord4;
	}
	public String getSrchWord5() {
		return srchWord5;
	}
	public void setSrchWord5(String srchWord5) {
		this.srchWord5 = srchWord5;
	}
	public String getSrchWord6() {
		return srchWord6;
	}
	public void setSrchWord6(String srchWord6) {
		this.srchWord6 = srchWord6;
	}
	public String getSrchWord7() {
		return srchWord7;
	}
	public void setSrchWord7(String srchWord7) {
		this.srchWord7 = srchWord7;
	}
	public String getSrchWord8() {
		return srchWord8;
	}
	public void setSrchWord8(String srchWord8) {
		this.srchWord8 = srchWord8;
	}
	public String getSrchWord9() {
		return srchWord9;
	}
	public void setSrchWord9(String srchWord9) {
		this.srchWord9 = srchWord9;
	}
	public String getSrchWord10() {
		return srchWord10;
	}
	public void setSrchWord10(String srchWord10) {
		this.srchWord10 = srchWord10;
	}
	public String getModelYear() {
		return modelYear;
	}
	public void setModelYear(String modelYear) {
		this.modelYear = modelYear;
	}
	public String getSuperbCorpYn() {
		return superbCorpYn;
	}
	public void setSuperbCorpYn(String superbCorpYn) {
		this.superbCorpYn = superbCorpYn;
	}
	public String getPrdtLinkYn() {
		return prdtLinkYn;
	}
	public void setPrdtLinkYn(String prdtLinkYn) {
		this.prdtLinkYn = prdtLinkYn;
	}
	public String getCorpAbleYn() {
		return corpAbleYn;
	}
	public void setCorpAbleYn(String corpAbleYn) {
		this.corpAbleYn = corpAbleYn;
	}
	public String getIsrDiv() {
		return isrDiv;
	}
	public void setIsrDiv(String isrDiv) {
		this.isrDiv = isrDiv;
	}
	public String getPrintSn() {
		return printSn;
	}
	public void setPrintSn(String printSn) {
		this.printSn = printSn;
	}
	public String getRcCardivNum() {
		return rcCardivNum;
	}
	public void setRcCardivNum(String rcCardivNum) {
		this.rcCardivNum = rcCardivNum;
	}
	public String getIsrTypeDiv() {
		return isrTypeDiv;
	}
	public void setIsrTypeDiv(String isrTypeDiv) {
		this.isrTypeDiv = isrTypeDiv;
	}
	public String getRntQlfctAge() {
		return rntQlfctAge;
	}
	public void setRntQlfctAge(String rntQlfctAge) {
		this.rntQlfctAge = rntQlfctAge;
	}
	public String getRntQlfctCareer() {
		return rntQlfctCareer;
	}
	public void setRntQlfctCareer(String rntQlfctCareer) {
		this.rntQlfctCareer = rntQlfctCareer;
	}
	public String getRntQlfctLicense() {
		return rntQlfctLicense;
	}
	public void setRntQlfctLicense(String rntQlfctLicense) {
		this.rntQlfctLicense = rntQlfctLicense;
	}
	public String getGeneralIsrAmt() {
		return generalIsrAmt;
	}
	public void setGeneralIsrAmt(String generalIsrAmt) {
		this.generalIsrAmt = generalIsrAmt;
	}
	public String getGeneralIsrAge() {
		return generalIsrAge;
	}
	public void setGeneralIsrAge(String generalIsrAge) {
		this.generalIsrAge = generalIsrAge;
	}
	public String getGeneralIsrCareer() {
		return generalIsrCareer;
	}
	public void setGeneralIsrCareer(String generalIsrCareer) {
		this.generalIsrCareer = generalIsrCareer;
	}
	public String getGeneralIsrRewardAmt() {
		return generalIsrRewardAmt;
	}
	public void setGeneralIsrRewardAmt(String generalIsrRewardAmt) {
		this.generalIsrRewardAmt = generalIsrRewardAmt;
	}
	public String getGeneralIsrBurcha() {
		return generalIsrBurcha;
	}
	public void setGeneralIsrBurcha(String generalIsrBurcha) {
		this.generalIsrBurcha = generalIsrBurcha;
	}
	public String getLuxyIsrAmt() {
		return luxyIsrAmt;
	}
	public void setLuxyIsrAmt(String luxyIsrAmt) {
		this.luxyIsrAmt = luxyIsrAmt;
	}
	public String getLuxyIsrAge() {
		return luxyIsrAge;
	}
	public void setLuxyIsrAge(String luxyIsrAge) {
		this.luxyIsrAge = luxyIsrAge;
	}
	public String getLuxyIsrCareer() {
		return luxyIsrCareer;
	}
	public void setLuxyIsrCareer(String luxyIsrCareer) {
		this.luxyIsrCareer = luxyIsrCareer;
	}
	public String getLuxyIsrRewardAmt() {
		return luxyIsrRewardAmt;
	}
	public void setLuxyIsrRewardAmt(String luxyIsrRewardAmt) {
		this.luxyIsrRewardAmt = luxyIsrRewardAmt;
	}
	public String getLuxyIsrBurcha() {
		return luxyIsrBurcha;
	}
	public void setLuxyIsrBurcha(String luxyIsrBurcha) {
		this.luxyIsrBurcha = luxyIsrBurcha;
	}
	public String getLinkMappingNum() {
		return linkMappingNum;
	}
	public void setLinkMappingNum(String linkMappingNum) {
		this.linkMappingNum = linkMappingNum;
	}
	public String getCorpLinkYn() {
		return corpLinkYn;
	}
	public void setCorpLinkYn(String corpLinkYn) {
		this.corpLinkYn = corpLinkYn;
	}
	public String getCntAplDt() {
		return cntAplDt;
	}
	public void setCntAplDt(String cntAplDt) {
		this.cntAplDt = cntAplDt;
	}
	public String getDisperEndDt() {
		return disperEndDt;
	}
	public void setDisperEndDt(String disperEndDt) {
		this.disperEndDt = disperEndDt;
	}
	public String getRsvMaxiTmAplYn() {
		return rsvMaxiTmAplYn;
	}
	public void setRsvMaxiTmAplYn(String rsvMaxiTmAplYn) {
		this.rsvMaxiTmAplYn = rsvMaxiTmAplYn;
	}
	public String getRsvMaxiTm() {
		return rsvMaxiTm;
	}
	public void setRsvMaxiTm(String rsvMaxiTm) {
		this.rsvMaxiTm = rsvMaxiTm;
	}
	public String getCorpRandLevel() {
		return corpRandLevel;
	}
	public void setCorpRandLevel(String corpRandLevel) {
		this.corpRandLevel = corpRandLevel;
	}
	public String getIsrDivSort() {
		return isrDivSort;
	}
	public void setIsrDivSort(String isrDivSort) {
		this.isrDivSort = isrDivSort;
	}
	public String getLinkMappingIsrNum() {
		return linkMappingIsrNum;
	}
	public void setLinkMappingIsrNum(String linkMappingIsrNum) {
		this.linkMappingIsrNum = linkMappingIsrNum;
	}
	public String getLinkMappingSaleAmt() {
		return linkMappingSaleAmt;
	}
	public void setLinkMappingSaleAmt(String linkMappingSaleAmt) {
		this.linkMappingSaleAmt = linkMappingSaleAmt;
	}
	public String getLinkMappingIsrAmt() {
		return linkMappingIsrAmt;
	}
	public void setLinkMappingIsrAmt(String linkMappingIsrAmt) {
		this.linkMappingIsrAmt = linkMappingIsrAmt;
	}
	public String getCorpLinkIsrYn() {
		return corpLinkIsrYn;
	}
	public void setCorpLinkIsrYn(String corpLinkIsrYn) {
		this.corpLinkIsrYn = corpLinkIsrYn;
	}
	public String getCarAmt() {
		return carAmt;
	}
	public void setCarAmt(String carAmt) {
		this.carAmt = carAmt;
	}
	public String getIsrAmt() {
		return isrAmt;
	}
	public void setIsrAmt(String isrAmt) {
		this.isrAmt = isrAmt;
	}
	public String getIconCds() {
		return iconCds;
	}
	public void setIconCds(String iconCds) {
		this.iconCds = iconCds;
	}
	public String getTamnacardYn() {
		return tamnacardYn;
	}
	public void setTamnacardYn(String tamnacardYn) {
		this.tamnacardYn = tamnacardYn;
	}
	public String getApiRentDiv() {
		return apiRentDiv;
	}
	public void setApiRentDiv(String apiRentDiv) {
		this.apiRentDiv = apiRentDiv;
	}
	public String getInsIsrDiv1() {
		return insIsrDiv1;
	}
	public void setInsIsrDiv1(String insIsrDiv1) {
		this.insIsrDiv1 = insIsrDiv1;
	}
	public String getInsIsrDiv2() {
		return insIsrDiv2;
	}
	public void setInsIsrDiv2(String insIsrDiv2) {
		this.insIsrDiv2 = insIsrDiv2;
	}

	public String getNetAmt() {
		return netAmt;
	}

	public void setNetAmt(String netAmt) {
		this.netAmt = netAmt;
	}

	public String getNet1Amt() {
		return net1Amt;
	}

	public void setNet1Amt(String net1Amt) {
		this.net1Amt = net1Amt;
	}

	public String getNet2Amt() {
		return net2Amt;
	}

	public void setNet2Amt(String net2Amt) {
		this.net2Amt = net2Amt;
	}

	public String getTotalInterlock() {
		return totalInterlock;
	}

	public void setTotalInterlock(String totalInterlock) {
		this.totalInterlock = totalInterlock;
	}

	public String getInsIsrDiv0() {
		return insIsrDiv0;
	}

	public void setInsIsrDiv0(String insIsrDiv0) {
		this.insIsrDiv0 = insIsrDiv0;
	}

	public String getRegularCarAmt() {
		return regularCarAmt;
	}

	public void setRegularCarAmt(String regularCarAmt) {
		this.regularCarAmt = regularCarAmt;
	}

	public String getSellCarAmt() {
		return sellCarAmt;
	}

	public void setSellCarAmt(String sellCarAmt) {
		this.sellCarAmt = sellCarAmt;
	}

	public String getCarDisRate() {
		return carDisRate;
	}

	public void setCarDisRate(String carDisRate) {
		this.carDisRate = carDisRate;
	}

	public String getRegularInsuranceAmt() {
		return regularInsuranceAmt;
	}

	public void setRegularInsuranceAmt(String regularInsuranceAmt) {
		this.regularInsuranceAmt = regularInsuranceAmt;
	}

	public String getSellInsuranceAmt() {
		return sellInsuranceAmt;
	}

	public void setSellInsuranceAmt(String sellInsuranceAmt) {
		this.sellInsuranceAmt = sellInsuranceAmt;
	}

	public String getInsuranceDisRate() {
		return insuranceDisRate;
	}

	public void setInsuranceDisRate(String insuranceDisRate) {
		this.insuranceDisRate = insuranceDisRate;
	}

	public String getSellLink() {
		return sellLink;
	}

	public void setSellLink(String sellLink) {
		this.sellLink = sellLink;
	}
}
