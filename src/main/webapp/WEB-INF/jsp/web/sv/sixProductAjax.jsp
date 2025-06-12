<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		    uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<%-- 통합검색 X --%>
<c:if test="${'Y' ne totSch}">
    <c:forEach items="${resultList}" var="result" varStatus="status">
	<li class="list-item"<c:if test="${(paginationInfo.currentPageNo eq 1) and (status.count eq 1)}">id="pageInfoCnt" totalCnt="${paginationInfo.totalRecordCount}" totalPageCnt="${paginationInfo.totalPageCount}" </c:if>>
		<a href="<c:url value='/web/${prdtDiv}/detailPrdt.do?prdtNum=${result.prdtNum}'/>" target="_self">
			<div class="box__image">
				<c:if test="${result.jqYn eq 'Y'}">
				<span class="main_label_JQ">JQ인증</span>
				</c:if>
				<img src="${result.savePath}thumb/${result.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
			</div>
			<div class="box__information">
				<div class="bxTitle"><c:out value="${result.prdtNm}" /></div>
				<div class="bxEvent"><c:out value="${result.prdtInf}" default="　"/></div>
				<div class="bxPrice">
					<span class="text__price"><fmt:formatNumber value="${result.saleAmt}"/></span><span class="text__unit">원</span>
				</div>
				<div class="bxLabel">
					<c:if test="${result.eventCnt > 0}">
						<span class="main_label eventblue">이벤트</span>
					</c:if>
					<c:if test="${result.couponCnt > 0}">
						<span class="main_label pink">할인쿠폰</span>
					</c:if>
					<c:if test="${result.superbSvYn eq 'Y'}">
						<span class="main_label back-purple">공모전 수상작</span>
					</c:if>
					<c:if test="${result.superbCorpYn == 'Y' }">
						<span class="main_label back-red">우수관광사업체</span>
					</c:if>
					<!-- 20211214 탐나는전 label 추가 -->
					<c:if test="${result.tamnacardYn eq 'Y'}">
						<span class="main_label yellow">탐나는전</span>
					</c:if>
				</div>
			</div>
		</a>
	</li>
    </c:forEach>

    <c:if test="${fn:length(resultList) == 0}">
	<div class="item-noContent" id="pageInfoCnt" totalCnt="0" totalPageCnt="0">
		<p><img src="<c:url value='/images/web/icon/warning2.gif'/>" alt="경고"></p>
		<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
	</div>
    </c:if>
</c:if>
<%-- 통합검색 --%>
<!-- 20.05.27 통합검색 리뉴얼 TOBE -->
<c:if test="${'Y' eq totSch}">
	<ul class="col5">
		<c:forEach items="${resultList}" var="result" varStatus="status">
		<li class="list-item <c:if test="${status.index >= 10}">off</c:if>">
			<a href="<c:url value='/web/${prdtDiv}/detailPrdt.do?prdtNum=${result.prdtNum}'/>" target="_self">
				<div class="box__image">
					<img src="${result.savePath}thumb/${result.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
				</div>
				<div class="box__information">
					<div class="bxTitle"><c:out value="${result.prdtNm}" /></div>
					<div class="bxEvent"><c:out value="${result.prdtInf}" default="　"/></div>
					<div class="bxPrice">
						<span class="text__price"><fmt:formatNumber value="${result.saleAmt}" type="number"/></span><span class="text__unit">원</span>
					</div>
					<!-- 20211216 클래스명 추가 -->
					<div class="bxLabel search-box-area">
						<!-- //20211216 클래스명 추가 -->
						<c:if test="${result.eventCnt > 0}">
							<span class="main_label eventblue">이벤트</span>
						</c:if>
						<c:if test="${result.couponCnt > 0}">
							<span class="main_label pink">할인쿠폰</span>
						</c:if>
						<c:if test="${result.superbSvYn eq 'Y'}">
							<span class="main_label back-purple">공모전 수상작</span>
						</c:if>
						<c:if test="${result.superbCorpYn == 'Y' }">
							<span class="main_label back-red">우수관광사업체</span>
						</c:if>
						<!-- 20211214 탐나는전 label 추가 -->
						<c:if test="${result.tamnacardYn eq 'Y'}">
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