<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<%-- 상품 검색 리스트 --%>
<c:if test="${'Y' ne totSch}">
	<c:forEach var="data" items="${resultList}" varStatus="status">
		<div class="itemPrdt" data-filter0="${data.adNm}" data-filter0-*-visible="Y" data-filter1="${data.adArea}" data-filter1-visible="Y" data-filter2="${data.adDiv}" data-filter2-visible="Y" data-filter3="${data.iconCd}" data-filter3-visible="Y" data-filter4="${data.daypriceYn}" data-filter4-visible="Y" data-filter5="${data.continueNightYn}" data-filter6="${data.tamnacardYn}" data-filter7="${data.couponCnt}" data-price="${data.saleAmt}" data-price-visible="Y" data-rsvAbleYn="${data.rsvAbleYn}">
			<a href="javascript:fn_DetailPrdt('${data.prdtNum}', '${data.corpCd}', '${data.aplDt}', '', '${data.corpId}')">
				<div class="i-photo">
					<c:if test="${!(empty data.saveFileNm)}">
						<img class="product" src="${data.savePath}thumb/${data.saveFileNm}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy">
					</c:if>
					<c:if test="${empty data.saveFileNm}">
						<img class="product" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="product">
					</c:if>
				</div>
				<div class="inner-info">
					<h3>${data.adNm}</h3>
					<span class="star">

							<fmt:formatNumber var="varGpa" value="${data.gpaAvg}" pattern="0"/>
							<c:forEach begin="1" end="5" varStatus="status">
								<c:choose>
									<c:when test = "${varGpa < status.current}">
								<svg viewBox="0 0 1000 1000" role="presentation" aria-hidden="true" focusable="false" style="height:12px; width:12px; fill:rgb(202,202,202)">
								<path d="M972 380c9 28 2 50-20 67L725 619l87 280c11 39-18 75-54 75-12 0-23-4-33-12L499 790 273 962a58 58 0 0 1-78-12 50 50 0 0 1-8-51l86-278L46 447c-21-17-28-39-19-67 8-24 29-40 52-40h280l87-279c7-23 28-39 52-39 25 0 47 17 54 41l87 277h280c24 0 45 16 53 40z"></path>
								</svg>
									</c:when>
									<c:otherwise>
								<svg viewBox="0 0 1000 1000" role="presentation" aria-hidden="true" focusable="false" style="height:12px; width:12px; fill:currentColor">
								<path d="M972 380c9 28 2 50-20 67L725 619l87 280c11 39-18 75-54 75-12 0-23-4-33-12L499 790 273 962a58 58 0 0 1-78-12 50 50 0 0 1-8-51l86-278L46 447c-21-17-28-39-19-67 8-24 29-40 52-40h280l87-279c7-23 28-39 52-39 25 0 47 17 54 41l87 277h280c24 0 45 16 53 40z"></path>
								</svg>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<span class="star-num">
							<c:if test="${data.gpaCnt ne 0}">
								(${data.gpaCnt})
							</c:if>
							</span>
						</span>
					<div class="loc"><img src="/images/web/icon/icon_location02.png" width="10" height="16" alt="위치">${data.adAreaNm}</div>
					<div class="bxLabel">
						<c:if test="${data.eventCnt > 0}">
							<span class="main_label eventblue">이벤트</span>
						</c:if>
						<c:if test="${data.couponCnt == '1'}">
							<span class="main_label pink">할인쿠폰</span>
						</c:if>
						<c:if test="${data.daypriceYn == 'Y'}">
							<span class="main_label pink">당일특가</span>
						</c:if>
						<c:if test="${data.continueNightYn == 'Y'}">
							<span class="main_label back-red">연박할인</span>
						</c:if>
						<c:if test="${data.superbCorpYn == 'Y' }">
							<span class="main_label back-red">우수관광사업체</span>
						</c:if>
						<!-- 20211214 탐나는전 label 추가 -->
						<c:if test="${data.tamnacardYn eq 'Y'}">
							<span class="main_label yellow">탐나는전</span>
						</c:if>
					</div>
					<span class="info_memo">${data.adSimpleExp}</span>
				</div>
				<div class="inner-price">
					<c:if test="${data.stayNight < data.minRsvNight }">
						<span class="text__comment">${data.minRsvNight }박 이상 예약 가능</span>
					</c:if>
					<c:if test="${data.rsvAbleYn == 'Y'}">
							<span class="bxPrice">
								<em>${sNights}박기준</em>
								<c:if test="${data.nmlAmt ne data.saleAmt}">
								<span class="per_sale"><fmt:parseNumber var="percent" value="${(data.nmlAmt - data.saleAmt) / data.nmlAmt * 100 }" integerOnly="true"/>${percent}<small>%</small>
								</span>
								</c:if>
								<%--<del><c:if test="${data.nmlAmt ne data.saleAmt}"><fmt:formatNumber value="${data.nmlAmt}"/></c:if></del>--%>
								<span class="text__price"><fmt:formatNumber value="${data.saleAmt}"/></span><span class="text__unit">원</span>
							</span>
					</c:if>
					<c:if test="${data.rsvAbleYn == 'N'}">
						<span class="text__deadline">예약마감</span>
					</c:if>
				</div>
			</a>
		</div>
	</c:forEach>

	<c:if test="${fn:length(resultList) == 0}">
		<div class="item-noContent" id="pageInfoCnt" totalCnt="0" totalPageCnt="0">
			<p><img src="<c:url value='/images/web/icon/warning2.gif'/>" alt="경고"></p>
			<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
		</div>
	</c:if>
</c:if>
<%-- 통합검색 리스트 --%>
<!-- 20.05.27 통합검색 리뉴얼 TOBE -->
<c:if test="${'Y' eq totSch}">
	<ul class="col5">
		<c:forEach var="data" items="${resultList}" varStatus="status">
			<li class="list-item <c:if test="${status.index >= 10}">off</c:if>">
				<a href="javascript:fn_DetailPrdt('${data.prdtNum}', '${data.corpCd}', '${data.aplDt}', '', '${data.corpId}')"  class="link__item">
					<div class="box__image">
						<img src="${data.savePath}thumb/${data.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
					</div>
					<div class="box__information">
						<div class="bxTitle"> [${data.adAreaNm}] <c:out value="${data.adNm}"/></div>
						<div class="bxEvent"><c:out value="${data.adSimpleExp}" default="　"/></div>
						<div class="bxPrice">
							<c:if test="${data.rsvAbleYn == 'Y'}">
								<span class="text__price"><fmt:formatNumber value="${data.saleAmt}"/></span><span class="text__unit">원</span>
							</c:if>
							<c:if test="${data.rsvAbleYn == 'N'}">
								<span class="text__deadline">예약마감</span>
							</c:if>
						</div>

						<div class="bxLabel">
							<c:if test="${data.eventCnt > 0}">
								<span class="main_label eventblue">이벤트</span>
							</c:if>
							<c:if test="${data.daypriceYn == 'Y'}">
								<span class="main_label pink">당일특가</span>
							</c:if>
							<c:if test="${data.daypriceYn != 'Y'}">
								<c:if test="${data.continueNightYn == 'Y'}">
									<span class="main_label back-red">연박할인</span>
								</c:if>
							</c:if>
							<c:if test="${data.superbCorpYn == 'Y'}">
								<span class="main_label back-red">우수관광사업체</span>
							</c:if>
							<c:if test="${data.tamnacardYn eq 'Y'}">
								<span class="main_label yellow">탐나는전</span>
							</c:if>
						</div>

					</div>
				</a>
			</li>
		</c:forEach>

		<c:if test="${fn:length(resultList) == 0}">
			<div class="item-noContent">
				<p><img src="<c:url value='/images/web/icon/warning2.gif'/>" alt="경고"></p>
				<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
			</div>
		</c:if>

	</ul>
</c:if>