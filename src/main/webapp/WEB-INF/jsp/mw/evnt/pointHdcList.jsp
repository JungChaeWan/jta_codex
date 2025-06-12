<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />

<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do"></jsp:include>

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>">
<link rel="canonical" href="https://www.tamnao.com/web/evnt/prmtPlanList.do">
<script>
function fn_Search(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/mw/evnt/prmtPlanList.do'/>";
	document.frm.submit();

}

</script>
</head>

<body>
<div id="wrap">

<header id="header">
	<jsp:include page="/mw/head.do">
	  <jsp:param name="type" value="plan"/>
	</jsp:include>
</header>

<main id="main">
	<div class="mw-list-area">
		<section class="menu-typeA">
	        <h2 class="sec-caption">메뉴 선택</h2>

	    </section>

		<div class="event-item-area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" id=finishYn name="finishYn" value="${searchVO.finishYn}"/>
				<input type="hidden" id=winsYn name="winsYn" value="${searchVO.winsYn}"/>
			</form>
			<ul>
				<li><img src="/images/mw/event/prmtPointImgM.jpg" width="100%"></li>
			</ul>

			<ul id="prmtList">
				<c:forEach items="${resultList}" var="result">
					<c:if test="${fn:contains(result.partnerCode, 'hdc') or fn:contains(result.partnerCode, 'asset')}">
					<li>
						<a href="/mw/viewLogin.do?partnerCode=${result.partnerCode}">
							<div class="photo">
								<img class="product" src="/data/coupon/${result.bannerThumb}" alt="${result.partnerCode}">
							</div>
							<div class="info">
								<div class="text-area">
									<div class="title"><c:out value="${result.partnerNm}"/></div>
									<div class="date">
										<fmt:parseDate value="${result.aplStartDt}" var="startDt" pattern="yyyyMMdd" />
										<fmt:parseDate value="${result.aplEndDt}" var="endDt" pattern="yyyyMMdd" />
										<fmt:formatDate value="${startDt}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" />
									</div>
								</div>
							</div>
						</a>
					</li>
					</c:if>
				</c:forEach>

				<c:if test="${fn:length(resultList) == 0}">
					<div class="item-noContent">
						<p><img src="/images/web/icon/warning2.gif" alt="경고"></p>
						<p class="text">죄송합니다.<br>현재 진행중인 <span class="comm-color1">이벤트</span>가 없습니다.</p>
					</div>
				</c:if>
			</ul>
			<ul>
				<li class="padding-top10"><img src="/images/web/event/prmtPointManualW.jpg" width="100%"></li>
			</ul>
		</div>

		<c:if test="${fn:length(resultList) > 0}">
			<div class="pageNumber">
				<p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" /></p>
			</div>
		</c:if>
	</div>
</main>

<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>
