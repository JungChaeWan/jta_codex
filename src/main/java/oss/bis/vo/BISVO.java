package oss.bis.vo;

public class BISVO {
	private String totalMemCnt;		// 총 회원&고객 수	
	private String area;			// 회원 지역
	private String areaMemCnt;		// 지역별 회원수
	private String areaMemPer;		// 지역별 회원 비율
	private String areaCusCnt;		// 지역별 고객수
	private String areaCusPer;		// 지역별 고객 비율
		
	private String rsvDt;			// 예약 일자	
	private String prdtGubun;		// 상품 구분
	private String prdtCateNm;		// 상품 분류명
	private String corpId;			// 입점업체 ID
	private String corpNm;			// 입점업체명
	private String tradeStatusCd;	// 거래상태
	private String rsvCnt;			// 예약 건수
	private String cancelCnt;		// 예약취소 건수
	private String gpaAvg;			// 평점
	private String useepilCnt;		// 이용후기 건수
	private String otoinqCnt;		// 1:1문의 건수
	private String snsCnt;			// SNS 공유 건수
	private String viewCnt;			// View Click 건수
	private String duplCnt;			// 재구매 건수
	
	private String rsvNum;			// 예약번호
	private String cancelRequestDttm; // 취소 요청 일시
	private String cancelAmt;		// 취소 금액
	private String cancelRsn;		// 취소 사유
	private String cmssAmt;			// 수수료
	private String prdtNm;			// 상품명
	private String prdtInf;			// 상품 정보
	private String rsvWeekGubun;	// 예약 요일 구분
	private String cancelWeekGubun;// 예약취소 요일 구분
	private String rsvCntPer;		// 예약 건수 비율
	private String otherRsvCnt;		// 당일 예약 외 건수
	private String otherRsvPer;		// 당일 예약 외 비율
	
	private String adtmAmt;			// 광고비
	private String roasPer;			// 광고수익률
	private String cpaAmt;			// 구매전환비용
	
	private String accountCnt;		// 결제 건수
	private String disAccountCnt;	//쿠폰매출건수
	private String saleAmt;			// 판매 금액
	private String nmlAmt;			// 판매 금액
	private String disAmt;			// 할인 금액
	private String cancelReqAmt;	// 취소 요청 금액
	private String refundReqAmt;	// 환불 요청 금액
	
	private String userJoinCnt;		// 회원 누적 가입자 수
	private String nowJoinCnt;		// 검색일 가입자 수
	private String nowQutCnt;		// 검색일 탈퇴자 수
	private String allJoinCnt;		// 전제 회원 가입자 수 (관리자 포함)
	private String allQutCnt;		// 누적 탈퇴자 수
	private String month1JoinCnt;	// 1개월 이전 가입자 수
	private String month2JoinCnt;	// 2개월 이전 가입자 수
	private String month3JoinCnt;	// 3개월 이전 가입자 수
	
	private String saleCmssAmt;		// 판매수수료
	private String adjAmt;			// 정산 금액
	
	private String totalRsvCnt;		// 총 예약 건수	
	private String totalCancelCnt;	// 총 예약취소 건수
	private String totalGpaAvg;		// 평점 평균
	private String totalUseepilCnt;	// 총 이용후기 건수
	private String totalOtoinqCnt;	// 총 1:1문의 건수
	private String totalSnsCnt;		// 총 SNS 공유 건수
	private String totalViewCnt;	// 총 View Click 건수
	private String totalDuplCnt;	// 총 재구매 건수
	private String totalRsvAmt;		// 총 매출액
	private String totalCancelAmt;	// 총 취소 금액
	private String totalSaleCmss;	// 총 판매수수료
	private String totalAdjAmt;		// 총 정산대상금액
	private String totalDisAmt;		// 총 할인 금액
	private String totalCmssAmt;	// 총 취소 수수료
	
	private String anlsDt;			// 통계 일자
	private String avJlCnt;			// 항공 JL 건수
	private String avJlSaleamt;		// 항공 JL 판매금액
	private String avJcCnt;			// 항공 Jejucom 건수
	private String avJcSaleamt;		// 항공 Jejucom 판매금액
	private String visitorNum;		// 방문자 수
	
	private String yearVisitorCnt;	// 연간 방문자 수
	private String month1VisitorCnt;// 1개월 이전 방문자 수
	private String month2VisitorCnt;// 2개월 이전 방문자 수
	private String month3VisitorCnt;// 3개월 이전 방문자 수
	
	private String totalAvJlCnt;	// 누적 제이엘항공 건수
	private String totalAvJlSaleamt; // 누적 제이엘항공 판매금액
	private String yearAvJlCnt;		// 연간 제이엘항공 건수
	private String yearAvJlSaleamt; // 연간 제이엘항공 판매금액
	private String prevAvJlCnt;		// 전년 동일 제이엘항공 건수
	private String prevAvJlSaleamt;	 // 전년 동일 제이엘항공 판매금액
	private String month1AvJlCnt;	// 1개월 이전 제이엘항공 건수
	private String month1AvJlSaleamt;	// 1개월 이전 제이엘항공 판매금액
	private String month2AvJlCnt;	// 2개월 이전 제이엘항공 건수
	private String month2AvJlSaleamt;	// 2개월 이전 제이엘항공 판매금액
	private String month3AvJlCnt;	// 3개월 이전 제이엘항공 건수
	private String month3AvJlSaleamt;	// 3개월 이전 제이엘항공 판매금액
	
	private String totalAvJcCnt;	// 누적 제주닷컴항공 건수
	private String totalAvJcSaleamt; // 누적 제주닷컴항공 판매금액
	private String yearAvJcCnt;		// 연간 제주닷컴항공 건수
	private String yearAvJcSaleamt; // 연간 제주닷컴항공 판매금액
	private String prevAvJcCnt;		// 전년 동일 제주닷컴항공 건수
	private String prevAvJcSaleamt;	 // 전년 동일 제주닷컴항공 판매금액
	private String month1AvJcCnt;	// 1개월 이전 제주닷컴항공 건수
	private String month1AvJcSaleamt;	// 1개월 이전 제주닷컴항공 판매금액
	private String month2AvJcCnt;	// 2개월 이전 제주닷컴항공 건수
	private String month2AvJcSaleamt;	// 2개월 이전 제주닷컴항공 판매금액
	private String month3AvJcCnt;	// 3개월 이전 제주닷컴항공 건수
	private String month3AvJcSaleamt;	// 3개월 이전 제주닷컴항공 판매금액
	
	private String prevRsvCnt;			// 전년 동일 예약 건수
	private String prevSaleAmt;			// 전년 동일 매출액
	private String month3RsvCnt;		// 3개월 이전 예약 건수
	private String month3SaleAmt;		// 3개월 이전 매출액
	private String month2RsvCnt;		// 2개월 이전 예약 건수
	private String month2SaleAmt;		// 2개월 이전 매출액
	private String month1RsvCnt;		// 1개월 이전 예약 건수
	private String month1SaleAmt;		// 1개월 이전 매출액
	private String prevMonth3SaleAmt;	// 전년 3개월 이전 매출액
	private String prevMonth2SaleAmt;	// 전년 2개월 이전 매출액
	private String prevMonth1SaleAmt;	// 전년 1개월 이전 매출액
	private String yearRsvCnt;			// 연간 예약 건수
	private String yearSaleAmt;			// 연간 매출액
	private String totalSaleAmt;		// 누적 매출액

	private String saleCnt;
	private String rSaleAmt;
	private String rSaleCnt;
	private String cdNm;
	private String rn;
	private String pointAmt;

	public String getTotalMemCnt() {
		return totalMemCnt;
	}
	public void setTotalMemCnt(String totalMemCnt) {
		this.totalMemCnt = totalMemCnt; 
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getAreaMemCnt() {
		return areaMemCnt;
	}
	public void setAreaMemCnt(String areaMemCnt) {
		this.areaMemCnt = areaMemCnt;
	}
	public String getAreaMemPer() {
		return areaMemPer;
	}
	public void setAreaMemPer(String areaMemPer) {
		this.areaMemPer = areaMemPer;
	}
	public String getAreaCusCnt() {
		return areaCusCnt;
	}
	public void setAreaCusCnt(String areaCusCnt) {
		this.areaCusCnt = areaCusCnt;
	}
	public String getAreaCusPer() {
		return areaCusPer;
	}
	public void setAreaCusPer(String areaCusPer) {
		this.areaCusPer = areaCusPer;
	}
		
	public String getRsvDt() {
		return rsvDt;
	}
	public void setRsvDt(String rsvDt) {
		this.rsvDt = rsvDt;
	}	
	public String getPrdtGubun() {
		return prdtGubun;
	}
	public void setPrdtGubun(String prdtGubun) {
		this.prdtGubun = prdtGubun;
	}
	public String getPrdtCateNm() {
		return prdtCateNm;
	}
	public void setPrdtCateNm(String prdtCateNm) {
		this.prdtCateNm = prdtCateNm;
	}
	public String getCorpId() {
		return corpId;
	}
	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}
	public String getCorpNm() {
		return corpNm;
	}
	public void setCorpNm(String corpNm) {
		this.corpNm = corpNm;
	}
	public String getTradeStatusCd() {
		return tradeStatusCd;
	}
	public void setTradeStatusCd(String tradeStatusCd) {
		this.tradeStatusCd = tradeStatusCd;
	}
	public String getRsvCnt() {
		return rsvCnt;
	}
	public void setRsvCnt(String rsvCnt) {
		this.rsvCnt = rsvCnt;
	}
	public String getGpaAvg() {
		return gpaAvg;
	}
	public void setGpaAvg(String gpaAvg) {
		this.gpaAvg = gpaAvg;
	}
	public String getUseepilCnt() {
		return useepilCnt;
	}
	public void setUseepilCnt(String useepilCnt) {
		this.useepilCnt = useepilCnt;
	}
	public String getOtoinqCnt() {
		return otoinqCnt;
	}
	public void setOtoinqCnt(String otoinqCnt) {
		this.otoinqCnt = otoinqCnt;
	}	
	public String getSnsCnt() {
		return snsCnt;
	}
	public void setSnsCnt(String snsCnt) {
		this.snsCnt = snsCnt;
	}
	public String getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(String viewCnt) {
		this.viewCnt = viewCnt;
	}
	public String getDuplCnt() {
		return duplCnt;
	}
	public void setDuplCnt(String duplCnt) {
		this.duplCnt = duplCnt;
	}
	public String getCancelCnt() {
		return cancelCnt;
	}
	public void setCancelCnt(String cancelCnt) {
		this.cancelCnt = cancelCnt;
	}
		
	public String getRsvNum() {
		return rsvNum;
	}
	public void setRsvNum(String rsvNum) {
		this.rsvNum = rsvNum;
	}
	public String getCancelRequestDttm() {
		return cancelRequestDttm;
	}
	public void setCancelRequestDttm(String cancelRequestDttm) {
		this.cancelRequestDttm = cancelRequestDttm;
	}
	public String getCancelAmt() {
		return cancelAmt;
	}
	public void setCancelAmt(String cancelAmt) {
		this.cancelAmt = cancelAmt;
	}
	public String getCancelRsn() {
		return cancelRsn;
	}
	public void setCancelRsn(String cancelRsn) {
		this.cancelRsn = cancelRsn;
	}
	public String getCmssAmt() {
		return cmssAmt;
	}
	public void setCmssAmt(String cmssAmt) {
		this.cmssAmt = cmssAmt;
	}
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public String getPrdtInf() {
		return prdtInf;
	}
	public void setPrdtInf(String prdtInf) {
		this.prdtInf = prdtInf;
	}	
	public String getRsvWeekGubun() {
		return rsvWeekGubun;
	}
	public void setRsvWeekGubun(String rsvWeekGubun) {
		this.rsvWeekGubun = rsvWeekGubun;
	}
	public String getCancelWeekGubun() {
		return cancelWeekGubun;
	}
	public void setCancelWeekGubun(String cancelWeekGubun) {
		this.cancelWeekGubun = cancelWeekGubun;
	}	
	public String getRsvCntPer() {
		return rsvCntPer;
	}
	public void setRsvCntPer(String rsvCntPer) {
		this.rsvCntPer = rsvCntPer;
	}
	
	public String getOtherRsvCnt() {
		return otherRsvCnt;
	}
	public void setOtherRsvCnt(String otherRsvCnt) {
		this.otherRsvCnt = otherRsvCnt;
	}
	public String getOtherRsvPer() {
		return otherRsvPer;
	}
	public void setOtherRsvPer(String otherRsvPer) {
		this.otherRsvPer = otherRsvPer;
	}
		
	public String getAdtmAmt() {
		return adtmAmt;
	}
	public void setAdtmAmt(String adtmAmt) {
		this.adtmAmt = adtmAmt;
	}
	public String getRoasPer() {
		return roasPer;
	}
	public void setRoasPer(String roasPer) {
		this.roasPer = roasPer;
	}
	public String getCpaAmt() {
		return cpaAmt;
	}
	public void setCpaAmt(String cpaAmt) {
		this.cpaAmt = cpaAmt;
	}
	
	
	public String getAccountCnt() {
		return accountCnt;
	}
	public void setAccountCnt(String accountCnt) {
		this.accountCnt = accountCnt;
	}
	public String getDisAccountCnt() {
		return disAccountCnt;
	}
	public void setDisAccountCnt(String disAccountCnt) {
		this.disAccountCnt = disAccountCnt;
	}

	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getDisAmt() {
		return disAmt;
	}
	public void setDisAmt(String disAmt) {
		this.disAmt = disAmt;
	}
	public String getCancelReqAmt() {
		return cancelReqAmt;
	}
	public void setCancelReqAmt(String cancelReqAmt) {
		this.cancelReqAmt = cancelReqAmt;
	}
	public String getRefundReqAmt() {
		return refundReqAmt;
	}
	public void setRefundReqAmt(String refundReqAmt) {
		this.refundReqAmt = refundReqAmt;
	}
			
	public String getUserJoinCnt() {
		return userJoinCnt;
	}
	public void setUserJoinCnt(String userJoinCnt) {
		this.userJoinCnt = userJoinCnt;
	}
	public String getNowJoinCnt() {
		return nowJoinCnt;
	}
	public void setNowJoinCnt(String nowJoinCnt) {
		this.nowJoinCnt = nowJoinCnt;
	}
	public String getNowQutCnt() {
		return nowQutCnt;
	}
	public void setNowQutCnt(String nowQutCnt) {
		this.nowQutCnt = nowQutCnt;
	}
	public String getAllJoinCnt() {
		return allJoinCnt;
	}
	public void setAllJoinCnt(String allJoinCnt) {
		this.allJoinCnt = allJoinCnt;
	}	
	public String getMonth1JoinCnt() {
		return month1JoinCnt;
	}
	public void setMonth1JoinCnt(String month1JoinCnt) {
		this.month1JoinCnt = month1JoinCnt;
	}
	public String getMonth2JoinCnt() {
		return month2JoinCnt;
	}
	public void setMonth2JoinCnt(String month2JoinCnt) {
		this.month2JoinCnt = month2JoinCnt;
	}
	public String getMonth3JoinCnt() {
		return month3JoinCnt;
	}
	public void setMonth3JoinCnt(String month3JoinCnt) {
		this.month3JoinCnt = month3JoinCnt;
	}
	
	public String getSaleCmssAmt() {
		return saleCmssAmt;
	}
	public void setSaleCmssAmt(String saleCmssAmt) {
		this.saleCmssAmt = saleCmssAmt;
	}
	public String getAdjAmt() {
		return adjAmt;
	}
	
	
	public void setAdjAmt(String adjAmt) {
		this.adjAmt = adjAmt;
	}
	public String getTotalRsvCnt() {
		return totalRsvCnt;
	}
	public void setTotalRsvCnt(String totalRsvCnt) {
		this.totalRsvCnt = totalRsvCnt;
	}
	public String getTotalCancelCnt() {
		return totalCancelCnt;
	}
	public void setTotalCancelCnt(String totalCancelCnt) {
		this.totalCancelCnt = totalCancelCnt;
	}
	public String getTotalGpaAvg() {
		return totalGpaAvg;
	}
	public void setTotalGpaAvg(String totalGpaAvg) {
		this.totalGpaAvg = totalGpaAvg;
	}
	public String getTotalUseepilCnt() {
		return totalUseepilCnt;
	}
	public void setTotalUseepilCnt(String totalUseepilCnt) {
		this.totalUseepilCnt = totalUseepilCnt;
	}
	public String getTotalOtoinqCnt() {
		return totalOtoinqCnt;
	}
	public void setTotalOtoinqCnt(String totalOtoinqCnt) {
		this.totalOtoinqCnt = totalOtoinqCnt;
	}	
	public String getTotalSnsCnt() {
		return totalSnsCnt;
	}
	public void setTotalSnsCnt(String totalSnsCnt) {
		this.totalSnsCnt = totalSnsCnt;
	}
	public String getTotalViewCnt() {
		return totalViewCnt;
	}
	public void setTotalViewCnt(String totalViewCnt) {
		this.totalViewCnt = totalViewCnt;
	}
	public String getTotalDuplCnt() {
		return totalDuplCnt;
	}
	public void setTotalDuplCnt(String totalDuplCnt) {
		this.totalDuplCnt = totalDuplCnt;
	}
	public String getTotalRsvAmt() {
		return totalRsvAmt;
	}
	public void setTotalRsvAmt(String totalRsvAmt) {
		this.totalRsvAmt = totalRsvAmt;
	}
	public String getTotalCancelAmt() {
		return totalCancelAmt;
	}
	public void setTotalCancelAmt(String totalCancelAmt) {
		this.totalCancelAmt = totalCancelAmt;
	}
	public String getTotalSaleCmss() {
		return totalSaleCmss;
	}
	public void setTotalSaleCmss(String totalSaleCmss) {
		this.totalSaleCmss = totalSaleCmss;
	}
	public String getTotalAdjAmt() {
		return totalAdjAmt;
	}
	public void setTotalAdjAmt(String totalAdjAmt) {
		this.totalAdjAmt = totalAdjAmt;
	}
	public String getTotalDisAmt() {
		return totalDisAmt;
	}
	public void setTotalDisAmt(String totalDisAmt) {
		this.totalDisAmt = totalDisAmt;
	}
	public String getTotalCmssAmt() {
		return totalCmssAmt;
	}
	public void setTotalCmssAmt(String totalCmssAmt) {
		this.totalCmssAmt = totalCmssAmt;
	}
	public String getAllQutCnt() {
		return allQutCnt;
	}
	public void setAllQutCnt(String allQutCnt) {
		this.allQutCnt = allQutCnt;
	}
	
	public String getAnlsDt() {
		return anlsDt;
	}
	public void setAnlsDt(String anlsDt) {
		this.anlsDt = anlsDt;
	}
	public String getAvJlCnt() {
		return avJlCnt;
	}
	public void setAvJlCnt(String avJlCnt) {
		this.avJlCnt = avJlCnt;
	}
	public String getAvJlSaleamt() {
		return avJlSaleamt;
	}
	public void setAvJlSaleamt(String avJlSaleamt) {
		this.avJlSaleamt = avJlSaleamt;
	}
	public String getAvJcCnt() {
		return avJcCnt;
	}
	public void setAvJcCnt(String avJcCnt) {
		this.avJcCnt = avJcCnt;
	}
	public String getAvJcSaleamt() {
		return avJcSaleamt;
	}
	public void setAvJcSaleamt(String avJcSaleamt) {
		this.avJcSaleamt = avJcSaleamt;
	}
	public String getVisitorNum() {
		return visitorNum;
	}
	public void setVisitorNum(String visitorNum) {
		this.visitorNum = visitorNum;
	}
	
	public String getYearVisitorCnt() {
		return yearVisitorCnt;
	}
	public void setYearVisitorCnt(String yearVisitorCnt) {
		this.yearVisitorCnt = yearVisitorCnt;
	}
	public String getMonth1VisitorCnt() {
		return month1VisitorCnt;
	}
	public void setMonth1VisitorCnt(String month1VisitorCnt) {
		this.month1VisitorCnt = month1VisitorCnt;
	}
	public String getMonth2VisitorCnt() {
		return month2VisitorCnt;
	}
	public void setMonth2VisitorCnt(String month2VisitorCnt) {
		this.month2VisitorCnt = month2VisitorCnt;
	}
	public String getMonth3VisitorCnt() {
		return month3VisitorCnt;
	}
	public void setMonth3VisitorCnt(String month3VisitorCnt) {
		this.month3VisitorCnt = month3VisitorCnt;
	}
	
	public String getTotalAvJlCnt() {
		return totalAvJlCnt;
	}
	public void setTotalAvJlCnt(String totalAvJlCnt) {
		this.totalAvJlCnt = totalAvJlCnt;
	}
	public String getTotalAvJlSaleamt() {
		return totalAvJlSaleamt;
	}
	public void setTotalAvJlSaleamt(String totalAvJlSaleamt) {
		this.totalAvJlSaleamt = totalAvJlSaleamt;
	}
	public String getYearAvJlCnt() {
		return yearAvJlCnt;
	}
	public void setYearAvJlCnt(String yearAvJlCnt) {
		this.yearAvJlCnt = yearAvJlCnt;
	}
	public String getYearAvJlSaleamt() {
		return yearAvJlSaleamt;
	}
	public void setYearAvJlSaleamt(String yearAvJlSaleamt) {
		this.yearAvJlSaleamt = yearAvJlSaleamt;
	}
	public String getPrevAvJlCnt() {
		return prevAvJlCnt;
	}
	public void setPrevAvJlCnt(String prevAvJlCnt) {
		this.prevAvJlCnt = prevAvJlCnt;
	}
	public String getPrevAvJlSaleamt() {
		return prevAvJlSaleamt;
	}
	public void setPrevAvJlSaleamt(String prevAvJlSaleamt) {
		this.prevAvJlSaleamt = prevAvJlSaleamt;
	}
	public String getMonth1AvJlCnt() {
		return month1AvJlCnt;
	}
	public void setMonth1AvJlCnt(String month1AvJlCnt) {
		this.month1AvJlCnt = month1AvJlCnt;
	}
	public String getMonth1AvJlSaleamt() {
		return month1AvJlSaleamt;
	}
	public void setMonth1AvJlSaleamt(String month1AvJlSaleamt) {
		this.month1AvJlSaleamt = month1AvJlSaleamt;
	}
	public String getMonth2AvJlCnt() {
		return month2AvJlCnt;
	}
	public void setMonth2AvJlCnt(String month2AvJlCnt) {
		this.month2AvJlCnt = month2AvJlCnt;
	}
	public String getMonth2AvJlSaleamt() {
		return month2AvJlSaleamt;
	}
	public void setMonth2AvJlSaleamt(String month2AvJlSaleamt) {
		this.month2AvJlSaleamt = month2AvJlSaleamt;
	}
	public String getMonth3AvJlCnt() {
		return month3AvJlCnt;
	}
	public void setMonth3AvJlCnt(String month3AvJlCnt) {
		this.month3AvJlCnt = month3AvJlCnt;
	}
	public String getMonth3AvJlSaleamt() {
		return month3AvJlSaleamt;
	}
	public void setMonth3AvJlSaleamt(String month3AvJlSaleamt) {
		this.month3AvJlSaleamt = month3AvJlSaleamt;
	}
	
	public String getTotalAvJcCnt() {
		return totalAvJcCnt;
	}
	public void setTotalAvJcCnt(String totalAvJcCnt) {
		this.totalAvJcCnt = totalAvJcCnt;
	}
	public String getTotalAvJcSaleamt() {
		return totalAvJcSaleamt;
	}
	public void setTotalAvJcSaleamt(String totalAvJcSaleamt) {
		this.totalAvJcSaleamt = totalAvJcSaleamt;
	}
	public String getYearAvJcCnt() {
		return yearAvJcCnt;
	}
	public void setYearAvJcCnt(String yearAvJcCnt) {
		this.yearAvJcCnt = yearAvJcCnt;
	}
	public String getYearAvJcSaleamt() {
		return yearAvJcSaleamt;
	}
	public void setYearAvJcSaleamt(String yearAvJcSaleamt) {
		this.yearAvJcSaleamt = yearAvJcSaleamt;
	}
	public String getPrevAvJcCnt() {
		return prevAvJcCnt;
	}
	public void setPrevAvJcCnt(String prevAvJcCnt) {
		this.prevAvJcCnt = prevAvJcCnt;
	}
	public String getPrevAvJcSaleamt() {
		return prevAvJcSaleamt;
	}
	public void setPrevAvJcSaleamt(String prevAvJcSaleamt) {
		this.prevAvJcSaleamt = prevAvJcSaleamt;
	}
	public String getMonth1AvJcCnt() {
		return month1AvJcCnt;
	}
	public void setMonth1AvJcCnt(String month1AvJcCnt) {
		this.month1AvJcCnt = month1AvJcCnt;
	}
	public String getMonth1AvJcSaleamt() {
		return month1AvJcSaleamt;
	}
	public void setMonth1AvJcSaleamt(String month1AvJcSaleamt) {
		this.month1AvJcSaleamt = month1AvJcSaleamt;
	}
	public String getMonth2AvJcCnt() {
		return month2AvJcCnt;
	}
	public void setMonth2AvJcCnt(String month2AvJcCnt) {
		this.month2AvJcCnt = month2AvJcCnt;
	}
	public String getMonth2AvJcSaleamt() {
		return month2AvJcSaleamt;
	}
	public void setMonth2AvJcSaleamt(String month2AvJcSaleamt) {
		this.month2AvJcSaleamt = month2AvJcSaleamt;
	}
	public String getMonth3AvJcCnt() {
		return month3AvJcCnt;
	}
	public void setMonth3AvJcCnt(String month3AvJcCnt) {
		this.month3AvJcCnt = month3AvJcCnt;
	}
	public String getMonth3AvJcSaleamt() {
		return month3AvJcSaleamt;
	}
	public void setMonth3AvJcSaleamt(String month3AvJcSaleamt) {
		this.month3AvJcSaleamt = month3AvJcSaleamt;
	}
	
	public String getPrevRsvCnt() {
		return prevRsvCnt;
	}
	public void setPrevRsvCnt(String prevRsvCnt) {
		this.prevRsvCnt = prevRsvCnt;
	}	
	public String getPrevSaleAmt() {
		return prevSaleAmt;
	}
	public void setPrevSaleAmt(String prevSaleAmt) {
		this.prevSaleAmt = prevSaleAmt;
	}
	public String getMonth3RsvCnt() {
		return month3RsvCnt;
	}
	public void setMonth3RsvCnt(String month3RsvCnt) {
		this.month3RsvCnt = month3RsvCnt;
	}
	public String getMonth3SaleAmt() {
		return month3SaleAmt;
	}
	public void setMonth3SaleAmt(String month3SaleAmt) {
		this.month3SaleAmt = month3SaleAmt;
	}
	public String getMonth2RsvCnt() {
		return month2RsvCnt;
	}
	public void setMonth2RsvCnt(String month2RsvCnt) {
		this.month2RsvCnt = month2RsvCnt;
	}
	public String getMonth2SaleAmt() {
		return month2SaleAmt;
	}
	public void setMonth2SaleAmt(String month2SaleAmt) {
		this.month2SaleAmt = month2SaleAmt;
	}
	public String getMonth1RsvCnt() {
		return month1RsvCnt;
	}
	public void setMonth1RsvCnt(String month1RsvCnt) {
		this.month1RsvCnt = month1RsvCnt;
	}
	public String getMonth1SaleAmt() {
		return month1SaleAmt;
	}
	public void setMonth1SaleAmt(String month1SaleAmt) {
		this.month1SaleAmt = month1SaleAmt;
	}
	public String getPrevMonth3SaleAmt() {
		return prevMonth3SaleAmt;
	}
	public void setPrevMonth3SaleAmt(String prevMonth3SaleAmt) {
		this.prevMonth3SaleAmt = prevMonth3SaleAmt;
	}
	public String getPrevMonth2SaleAmt() {
		return prevMonth2SaleAmt;
	}
	public void setPrevMonth2SaleAmt(String prevMonth2SaleAmt) {
		this.prevMonth2SaleAmt = prevMonth2SaleAmt;
	}
	public String getPrevMonth1SaleAmt() {
		return prevMonth1SaleAmt;
	}
	public void setPrevMonth1SaleAmt(String prevMonth1SaleAmt) {
		this.prevMonth1SaleAmt = prevMonth1SaleAmt;
	}
	public String getYearRsvCnt() {
		return yearRsvCnt;
	}
	public void setYearRsvCnt(String yearRsvCnt) {
		this.yearRsvCnt = yearRsvCnt;
	}
	public String getYearSaleAmt() {
		return yearSaleAmt;
	}
	public void setYearSaleAmt(String yearSaleAmt) {
		this.yearSaleAmt = yearSaleAmt;
	}
	public String getTotalSaleAmt() {
		return totalSaleAmt;
	}
	public void setTotalSaleAmt(String totalSaleAmt) {
		this.totalSaleAmt = totalSaleAmt;
	}

	public String getNmlAmt() {
		return nmlAmt;
	}

	public void setNmlAmt(String nmlAmt) {
		this.nmlAmt = nmlAmt;
	}

	public String getSaleCnt() {
		return saleCnt;
	}

	public void setSaleCnt(String saleCnt) {
		this.saleCnt = saleCnt;
	}

	public String getrSaleAmt() {
		return rSaleAmt;
	}

	public void setrSaleAmt(String rSaleAmt) {
		this.rSaleAmt = rSaleAmt;
	}

	public String getrSaleCnt() {
		return rSaleCnt;
	}

	public void setrSaleCnt(String rSaleCnt) {
		this.rSaleCnt = rSaleCnt;
	}

	public String getCdNm() {
		return cdNm;
	}

	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}

	public String getRn() {
		return rn;
	}

	public void setRn(String rn) {
		this.rn = rn;
	}

	public String getPointAmt() {
		return pointAmt;
	}

	public void setPointAmt(String pointAmt) {
		this.pointAmt = pointAmt;
	}
}
