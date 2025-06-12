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
<c:forEach items="${carDivList }" var="carDiv" varStatus="status"><c:if test="${fn:length(prdtMap[carDiv.prdtAllNm]) ne 0}"><c:forEach items="${prdtMap[carDiv.prdtAllNm] }" var="prdtInfo" varStatus="pStatus"><c:set var="rcAmt"><fmt:parseNumber value='${prdtInfo.value.saleAmt }'  /></c:set>	<c:if test="${pStatus.count eq 1 }"><c:set var="rcMinAmt" value='${rcAmt }'/><c:set var="rcMaxAmt" value='${rcAmt }'/></c:if><c:if test="${pStatus.count ne 1 }"><c:if test="${rcMinAmt+0>rcAmt+0}"><c:set var="rcMinAmt" value='${rcAmt }' /></c:if><c:if test="${rcMaxAmt+0<rcAmt+0}"><c:set var="rcMaxAmt" value='${rcAmt }' /></c:if></c:if></c:forEach></c:if>
<div class="rent-group" data-filter="Y" data-top-price="${rcMinAmt }" data-top-seller="${carDiv.buyNum}">
   	<div class="top-info">
   		<div class="photo">
			<c:if test="${not empty carDiv.carImg }"><img src="${carDiv.carImg }" alt="렌터카이미지" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy"></c:if><c:if test="${empty carDiv.carImg }"><img src="<c:url value='/images/web/other/no-image.jpg' />" alt="렌터카이미지"></c:if>
   		</div>
   		<div class="text">
			<img class="logo-play maker" alt="차량로고" src="/images/web/rent/${carDiv.makerDiv}.png" onerror="this.src='/images/web/rent/defaultMD.png'" >
			<h2 class="title">${carDiv.prdtNm }</h2>
			<div class="sub-memo">
				<div class="list_kind"><img src="/images/mw/rent/list_kind.png" alt="차종">${carDiv.carDivNm }</div>
				<div class="list_people"><img src="/images/mw/rent/list_people.png" alt="탑승인원">${carDiv.maxiNum }명</div>
				<div class="list_oil"><img src="/images/mw/rent/list_oil.png" alt="주유">${carDiv.useFuelDivNm }</div>
			</div>
   		</div>
   	</div>
   	<div class="list">
		<div class="bottom"><a href="javascript:fn_rcPrdtView('${carDiv.rcCardivNum}')">예약 가능한 업체 <c:if test="${fn:length(prdtMap[carDiv.prdtAllNm]) > 3}"><strong id="viewTitle_${carDiv.rcCardivNum}">더보기</strong></c:if></a></div>
		<ul>
			<c:if test="${fn:length(prdtMap[carDiv.prdtAllNm]) ne 0 }"><c:forEach items="${prdtMap[carDiv.prdtAllNm] }" var="prdtInfo" varStatus="pStatus">
				<li data-price="${prdtInfo.value.saleAmt}" data-filter-child="Y" data-filter1="${carDiv.carDiv}" data-filter1-visible="Y" data-filter2="${prdtInfo.value.isrTypeDiv}" data-filter2-visible="Y" class="prdtView_${carDiv.rcCardivNum } <c:if test='${pStatus.count > 3 }' >hide</c:if>">
					<div class="link-area">
						<a href="javascript:fn_DetailPrdt('${prdtInfo.value.prdtNum }')">
							<div class="name"><p>${prdtInfo.value.corpNm }</p>
								<div class="bxLabel"><c:if test="${prdtInfo.value.eventCnt > 0 }"><span class="main_label eventblue">이벤트</span></c:if><c:if test="${prdtInfo.value.couponCnt > 0 }"><span class="main_label pink">할인쿠폰</span></c:if><c:if test="${prdtInfo.value.tamnacardYn eq 'Y' }"><span class="main_label yellow">탐나는전</span></c:if></div>
							</div>
							<div class="rent-option">
								<div class="since">${prdtInfo.value.modelYear}</div>
							</div>
							<div class="text <c:if test="${prdtInfo.value.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX}">advanced</c:if><c:if test="${prdtInfo.value.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN}">common</c:if>"><c:if test="${prdtInfo.value.isrDiv ne 'ID10'}">자차 미포함</c:if><c:if test="${prdtInfo.value.isrDiv eq 'ID10'}"><c:if test="${prdtInfo.value.isrTypeDiv eq Constant.RC_ISR_TYPE_GEN}">일반자차<c:if test="${prdtInfo.value.generalIsrRewardAmt eq '0' and  prdtInfo.value.generalIsrBurcha eq '0'}"><div class="sub_text">(전액무제한)</div></c:if>									<c:if test="${prdtInfo.value.generalIsrRewardAmt eq '-1' and  prdtInfo.value.generalIsrBurcha eq '0' and prdtInfo.value.corpId ne 'CRCO180002'}"><div class="sub_text">(전액무제한)</div></c:if>										<c:if test="${prdtInfo.value.generalIsrRewardAmt eq '0' and  prdtInfo.value.generalIsrBurcha ne '0'}"><div class="sub_text">(부분무제한)</div></c:if><c:if test="${prdtInfo.value.generalIsrRewardAmt eq '-1' and  prdtInfo.value.generalIsrBurcha ne '0' and prdtInfo.value.corpId ne 'CRCO180002' }"><div class="sub_text">(부분무제한)</div></c:if></c:if><c:if test="${prdtInfo.value.isrTypeDiv eq Constant.RC_ISR_TYPE_LUX}">고급자차<c:if test="${prdtInfo.value.luxyIsrRewardAmt eq '0' and  prdtInfo.value.luxyIsrBurcha eq '0'}"><div class="sub_text">(전액무제한)</div></c:if><c:if test="${prdtInfo.value.luxyIsrRewardAmt eq '-1' and  prdtInfo.value.luxyIsrBurcha eq '0' and prdtInfo.value.corpId ne 'CRCO180002'}"><div class="sub_text">(전액무제한)</div></c:if><c:if test="${prdtInfo.value.luxyIsrRewardAmt eq '0' and  prdtInfo.value.luxyIsrBurcha ne '0'}"><div class="sub_text">(부분무제한)</div></c:if><c:if test="${prdtInfo.value.luxyIsrRewardAmt eq '-1' and  prdtInfo.value.luxyIsrBurcha ne '0' and prdtInfo.value.corpId ne 'CRCO180002'}"><div class="sub_text">(부분무제한)</div></c:if></c:if></c:if></div>
							<div class="price">
								<div>
									<span><fmt:formatNumber value="${prdtInfo.value.saleAmt }"/></span>
									<span class="won">원</span>
								</div>
								<span class="arrow"></span>
							</div>
						</a>
					</div>
				</li>
			  </c:forEach>
   		</ul>
   	</div>
</div></c:if>
</c:forEach>
	<div class="loadingRc-wrap hide"><span class="loadingRc">검색날짜가 변경됐습니다.<br>검색 버튼을 클릭해주세요.</span></div>
	<c:if test="${fn:length(carDivList) == 0}">
		<div class="item-noContent"><p class="icon"><img src="<c:url value='/images/mw/sub_common/warning.png' />" alt="경고"></p><p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p></div>
	</c:if>
