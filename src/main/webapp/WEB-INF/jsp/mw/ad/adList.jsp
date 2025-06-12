<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<un:useConstants var="Constant" className="common.Constant" />

<%-- 상품 검색 리스트 --%>
<c:if test="${'Y' ne totSch}">
	<input type="hidden" name="totalCnt" value="${paginationInfo.totalRecordCount}" />
	<input type="hidden" name="totalPageCnt" value="${paginationInfo.totalPageCount}" />

	<c:forEach var="data" items="${resultList}" varStatus="status">
		<div class="hotel-group">
			<div class="product-area">
				<a href="javascript:fn_DetailPrdt('${data.prdtNum}', '${data.corpCd}','${data.corpId}')">
					<div class="photo">
						<c:choose>
							<c:when test="${status.count < 20}">
								<c:if test="${not empty data.saveFileNm}">
									<img class="img" src="${data.savePath}thumb/${data.saveFileNm}" alt="adImg" onerror="this.src='/images/web/other/no-image.jpg'">
								</c:if>
								<c:if test="${empty data.saveFileNm}">
									<img class="img" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="adImg" onerror="this.src='/images/web/other/no-image.jpg'">
								</c:if>
							</c:when>
							<c:otherwise>
								<c:if test="${not empty data.saveFileNm}">
									<img class="img" src="${data.savePath}thumb/${data.saveFileNm}" alt="adImg" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy">
								</c:if>
								<c:if test="${empty data.saveFileNm}">
									<img class="img" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="adImg" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy">
								</c:if>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="text">
						<%--<div class="like">
							<c:if test="${not empty pocketMap[data.corpId] }">
								<a href="javascript:void(0)">
									<img src="<c:url value='/images/mw/icon/product_like_on.png' />" alt="찜하기">
								</a>
							</c:if>
							<c:if test="${empty pocketMap[data.corpId] }">
								<a href="javascript:void(0)" id="pocket${data.corpId }" onclick="fn_listAddPocket('${Constant.ACCOMMODATION}', '${data.corpId }', ' ')">
									<img src="<c:url value='/images/mw/icon/product_like_off.png' />" alt="찜하기">
								</a>
							</c:if>
						</div>--%>
						<div class="tx_comment">
							<c:if test="${data.stayNight < data.minRsvNight }">
							<span >${data.minRsvNight}박이상 예약가능</span>
							</c:if>
						</div>
						<h2>${data.adNm}</h2>
							<div class="ad_star">
								<span class="star-icon">
							<fmt:formatNumber var="varGpa" value="${data.gpaAvg}" pattern="0"/>
							<c:forEach begin="1" end="5" varStatus="status">
								<c:choose>
									<c:when test = "${varGpa < status.current}">
										<img src="<c:url value='/images/mw/icon/star_off.png'/>" alt="starRate">
									</c:when>
									<c:otherwise>
										<img src="<c:url value='/images/mw/icon/star_on.png'/>" alt="starRate">
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</span>
								<span class="star-num">
							<c:if test="${data.gpaCnt ne 0}">
								(${data.gpaCnt})
							</c:if>
						</span>
							</div>
						<div class="memo">
							<img src="<c:url value='/images/mw/icon/place.png'/>" alt="거리">
							<span class="guide-memo">${data.adAreaNm}</span>${data.adSimpleExp}
						</div>
						<%--<div class="title"><a href="javascript:fn_DetailPrdt('${data.prdtNum}', '${data.corpCd}')"><span class="guide-title">${data.adAreaNm}</span><c:out value="${data.adNm}"/></a></div>--%>
						<div class="info">
							<dl>
								<%--<dt class="text-red">${searchVO.sNights}박요금</dt>--%>
								<dt></dt>
								<dd>
									<div class="bxLabel">
										<c:if test="${data.daypriceYn == 'Y'}">
											<span class="main_label pink">당일특가</span>
										</c:if>
										<c:if test="${data.eventCnt > 0}">
											<span class="main_label eventblue">이벤트</span>
										</c:if>
										<c:if test="${data.couponCnt > 0}">
											<span class="main_label pink">할인쿠폰</span>
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
									<div class="price">
										<c:if test="${data.rsvAbleYn == 'Y'}">
											<c:if test="${data.saleAmt ne data.nmlAmt}">
												<del><fmt:formatNumber value='${data.nmlAmt}'/>원</del>
											</c:if>
											<em>${sNights}박</em>
											<strong><fmt:formatNumber value='${data.saleAmt}'/><span class="won">원</span></strong>
										</c:if>
										<c:if test="${data.rsvAbleYn == 'N'}"><span class="text__deadline">예약마감</span></c:if>
									</div>
								</dd>
							</dl>
						</div>
					</div>
				</a>
			</div>
			<%--<c:if test="${not empty data.tip }">
			<div class="bottom">
				<div class="tip"><c:out value="${data.tip }" escapeXml="false"/></div>
			</div>
			</c:if>--%>
		</div>
	</c:forEach>
  
	<c:if test="${fn:length(resultList) == 0}">
		<div class="item-noContent">
			<p class="icon"><img src="<c:url value='/images/mw/sub_common/warning.png' />" alt="경고"></p>
			<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
		</div>
	</c:if>
</c:if>
<%-- 통합 검색 리스트 --%>
<c:if test="${'Y' eq totSch}">
	<div class="prdt-wrap">
		<c:forEach var="data" items="${resultList}" varStatus="status">
			<c:if test="${!('Y' == totSch && status.index >= 4)}">
				<div class="goods-list">
					<a href="javascript:fn_DetailPrdt('${data.prdtNum}', '${data.corpCd}', '${data.aplDt}')">
						<div class="goods-image goods-image1">
							<p class="tag-wrap"></p>
							<ul class="view">
								<li>
									<c:if test="${!(empty data.saveFileNm)}">
										<img class="img" src="${data.savePath}thumb/${data.saveFileNm}" alt="">
									</c:if>
									<c:if test="${empty data.saveFileNm}">
										<img class="img" src="<c:url value='/images/web/comm/no_img.jpg'/>" alt="">
									</c:if>
								</li>
							</ul>
						</div>
						<p class="info">
							<span class="txt">
								<em>${data.adSimpleExp}</em>
								<span class="city">${data.adAreaNm} | <strong><c:out value="${data.adNm}"/></strong></span>
							</span>
							<span class="price">
								<%-- <em>${data.salePent}%</em><br> --%>
								<%-- <em><fmt:formatNumber value='${1-data.saleAmt/data.nmlAmt }' type="percent" /></em> --%>
								<br>
								  <%-- <del><fmt:formatNumber value='${data.nmlAmt}'/>원</del>
								  <img src="<c:url value='/images/mw/sub_common/price_arrow.png'/>" width="8" alt=""> --%>
								<c:if test="${data.rsvAbleYn == 'Y'}">
								<strong><fmt:formatNumber value='${data.saleAmt}'/></strong>원
								</c:if>
								<c:if test="${data.rsvAbleYn == 'N'}"><span class="text__deadline">예약마감</span></c:if>
							</span>
							<span class="bxLabel">
								<c:if test="${data.daypriceYn == 'Y'}">
									<span class="main_label pink">당일특가</span>
								</c:if>
								<c:if test="${data.eventCnt > 0}">
									<span class="main_label eventblue">이벤트</span>
								</c:if>
								<c:if test="${data.couponCnt > 0}">
									<span class="main_label pink">할인쿠폰</span>
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
							</span>
						</p>
					</a>
				</div>
			</c:if>
		</c:forEach>
	</div>

	<c:if test="${fn:length(resultList) == 0}">
		<div class="item-noContent">
			<p class="icon"><img src="<c:url value='/images/mw/sub_common/warning.png' />" alt="경고"></p>
			<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
		</div>
	</c:if>
	<%-- 통합검색에서 온거 제외 --%>
	<c:if test="${'Y' != totSch}">
		<c:if test="${fn:length(resultList)!=0}">
			<div class="pageNumber">
				<p class="list_pageing">
					<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_AdSearch" />
				</p>
			</div>
		</c:if>
	</c:if>
</c:if>



