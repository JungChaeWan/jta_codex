<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="Constant" className="common.Constant" />
<input type="hidden" name="totalCnt" value="${paginationInfo.totalRecordCount}" />
<input type="hidden" name="totalPageCnt" value="${paginationInfo.totalPageCount}" />
	<c:forEach items="${carDivList }" var="carDiv" varStatus="status"><c:if test="${fn:length(prdtMap[carDiv.prdtAllNm]) ne 0 }"><c:if test="${fn:length(prdtMap[carDiv.prdtAllNm]) ne 0}"><c:forEach items="${prdtMap[carDiv.prdtAllNm] }" var="prdtInfo" varStatus="pStatus"><c:set var="rcAmt"><fmt:parseNumber value='${prdtInfo.value.saleAmt }'  /></c:set><c:if test="${pStatus.count eq 1 }"><c:set var="rcMinAmt" value='${rcAmt }'/><c:set var="rcMaxAmt" value='${rcAmt }'/></c:if><c:if test="${pStatus.count ne 1 }"><c:if test="${rcMinAmt+0>rcAmt+0}"><c:set var="rcMinAmt" value='${rcAmt }' /></c:if><c:if test="${rcMaxAmt+0<rcAmt+0}"><c:set var="rcMaxAmt" value='${rcAmt }' /></c:if></c:if></c:forEach></c:if>
<div class="rent-group" data-filter="Y" data-top-price="${rcMinAmt }" data-top-seller="${carDiv.buyNum}" data-top-prdtnm="${carDiv.prdtNm}">
	<div class="top-info">
		<div class="info-tie">
			<div class="photo">
				<img class="logo-play maker" alt="차량로고" src="/images/web/rent/${carDiv.makerDiv}.png" onerror="this.src='/images/web/rent/defaultMD.png'" >
				<img src="${carDiv.carImg }" alt="렌터카차량 이미지" onerror="this.src='/images/web/other/no-image.jpg'">
			</div>
				<div class="text">
					<div class="align-left">
						<h2 class="title">${carDiv.prdtNm }</h2>
						<div class="sub-memo">
							<ul>
								<li><img src="/images/web/rent/list_kind.png" alt="차종"><span>${carDiv.carDivNm }</span></li>
								<li><img src="/images/web/rent/list_people.png" alt="탑승인원"><span>${carDiv.maxiNum }명</span></li>
								<li><img src="/images/web/rent/list_oil.png" alt="주유"><span>${carDiv.useFuelDivNm }</span></li>
							</ul>
						</div>
					<div class="align-right">
						<div class="memo">${difTm }시간</div>
						<div class="info">
							<div class="red-sticker">최저가</div>
							<div class="price"><fmt:formatNumber value="${rcMinAmt }"/>원</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="reservation-btn-group">
			<button class="lowest-price" type="button" onclick="fn_DetailPrdtLowCost(this)">최저가 예약</button>
		</div>
	</div>
	<div class="list">
		<ul><c:if test="${fn:length(prdtMap[carDiv.prdtAllNm]) ne 0 }"><c:forEach items="${prdtMap[carDiv.prdtAllNm] }" var="prdtInfo" varStatus="pStatus">
				<li data-price="${prdtInfo.value.saleAmt}" data-filter-child="Y" data-top-carname="${carDiv.prdtNm}" data-filterWords-visible="Y" data-filter0="${prdtInfo.value.corpId}" data-filter0-visible="Y" data-filter1="${carDiv.carDiv}" data-filter1-visible="Y" data-filter2="${prdtInfo.value.isrTypeDiv}" data-filter2-visible="Y" data-filter3="${prdtInfo.value.rntQlfctAge}" data-filter3-visible="Y" data-filter4="${prdtInfo.value.useFuelDiv}" data-filter4-visible="Y" data-filter5="${prdtInfo.value.modelYear}" data-filter5-visible="Y" data-filter6="${prdtInfo.value.iconCds}" data-filter6-visible="Y" data-filter7="${prdtInfo.value.tamnacardYn}" data-filter8-visible="Y" data-filter8="${prdtInfo.value.rntQlfctCareer}" data-filter9="${prdtInfo.value.couponCnt}" class="prdtView_${carDiv.rcCardivNum } <c:if test='${pStatus.count > 3 }' >hide</c:if> listli">
					<div class="link-area">
						<a href="javascript:fn_DetailPrdt('${prdtInfo.value.prdtNum }')">
							<div class="product-info">
								<div class="name"><p>${prdtInfo.value.corpNm} </p></div>
								<div class="rent-cover">
										<c:if test="${prdtInfo.value.isrDiv ne 'ID10'}"><div class="text">자차미포함</div></c:if><c:if test="${prdtInfo.value.isrDiv eq 'ID10'}"><c:if test="${prdtInfo.value.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN}"><div class="text common">일반자차<c:if test="${prdtInfo.value.generalIsrRewardAmt eq '0' and  prdtInfo.value.generalIsrBurcha eq '0'}">(전액무제한)</c:if><c:if test="${prdtInfo.value.generalIsrRewardAmt eq '-1' and  prdtInfo.value.generalIsrBurcha eq '0' and prdtInfo.value.corpId ne 'CRCO180002'}">(전액무제한)</c:if><c:if test="${prdtInfo.value.generalIsrRewardAmt eq '0' and  prdtInfo.value.generalIsrBurcha ne '0'}">(부분무제한)</c:if><c:if test="${prdtInfo.value.generalIsrRewardAmt eq '-1' and  prdtInfo.value.generalIsrBurcha ne '0' and prdtInfo.value.corpId ne 'CRCO180002' }">(부분무제한)</c:if></div></c:if><c:if test="${prdtInfo.value.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX}"><div class="text advanced">고급자차<c:if test="${prdtInfo.value.luxyIsrRewardAmt eq '0' and  prdtInfo.value.luxyIsrBurcha eq '0'}">(전액무제한)</c:if><c:if test="${prdtInfo.value.luxyIsrRewardAmt eq '-1' and  prdtInfo.value.luxyIsrBurcha eq '0' and prdtInfo.value.corpId ne 'CRCO180002'}">(전액무제한)</c:if><c:if test="${prdtInfo.value.luxyIsrRewardAmt eq '0' and  prdtInfo.value.luxyIsrBurcha ne '0'}">(부분무제한)</c:if><c:if test="${prdtInfo.value.luxyIsrRewardAmt eq '-1' and  prdtInfo.value.luxyIsrBurcha ne '0' and prdtInfo.value.corpId ne 'CRCO180002'}">(부분무제한)</c:if></div></c:if></c:if>
									<div class="career">경력 ${prdtInfo.value.rntQlfctCareer}년 이상</div>
								</div>
								<div class="rent-option">
									<div class="since">${prdtInfo.value.modelYear}</div>
									<div class="age">만${prdtInfo.value.rntQlfctAge}세이상</div>
								</div>
							</div>
							<div class="rc-tx">
								<span class="car_op">
									<ul>
										<c:forEach var="rcCode" items="${rcCodeMap}" varStatus="varStatus"><c:if test = "${fn:contains(prdtInfo.value.iconCds, rcCode.key)}"><li class="on">${rcCode.value}</li></c:if><c:if test = "${!fn:contains(prdtInfo.value.iconCds, rcCode.key)}"><li>${rcCode.value}</li></c:if></c:forEach>
									</ul>
								</span>
							</div>
							<div class="price-info">
								<div class="bxLabel"><c:if test="${prdtInfo.value.eventCnt > 0 }"><span class="main_label eventblue">이벤트</span></c:if><c:if test="${prdtInfo.value.couponCnt > 0 }"><span class="main_label pink">할인쿠폰</span></c:if><c:if test="${prdtInfo.value.tamnacardYn eq 'Y' }"><span class="main_label yellow">탐나는전</span></c:if></div>
								<div class="price"><fmt:formatNumber value="${prdtInfo.value.saleAmt }"/><span class="won">원</span></div>
							</div>
						</a>
					</div>
				</li></c:forEach></c:if>
		</ul>
		<c:if test="${fn:length(prdtMap[carDiv.prdtAllNm]) > 3}">
			<button type="button" onclick="fn_rcPrdtView('${carDiv.rcCardivNum}')" class="paging-wrap">
				<span id="viewTitle_${carDiv.rcCardivNum}" class="mobile">예약 가능한 업체 더보기</span>
				<img class="add_arrow" src="/images/web/rent/add_arrow.png" alt="더보기">
			</button>
		</c:if>
	</div>
</div></c:if></c:forEach>