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
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="제주여행 특가 이벤트 기획전"/>
</jsp:include>
<meta property="og:title" content="제주여행 특가 이벤트 기획전">
<meta property="og:url" content="https://www.tamnao.com/mw/evnt/prmtPlanList.do">
<meta property="og:description" content="제주여행공공플랫폼 탐나오. 제주 항공권, 숙소, 렌터카, 관광지 예약을 모두 한 곳에서, 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다.">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>"> --%>
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
<c:if test="${searchVO.sPrmtDiv eq 'GOVA'}">
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="type" value="gova"/>
		<jsp:param name="headTitle" value="공고 신청"/>
	</jsp:include>
</header>
</c:if>
<c:if test="${empty searchVO.sPrmtDiv}">
	<header id="header">
		<jsp:include page="/mw/head.do">
			<jsp:param name="type" value="plan"/>
			<jsp:param name="headTitle" value="기획전"/>
		</jsp:include>
	</header>
</c:if>
<main id="main">
	<div class="mw-list-area">
		<div class="event-item-area">
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}">
				<input type="hidden" id=finishYn name="finishYn" value="${searchVO.finishYn}">
				<input type="hidden" id=winsYn name="winsYn" value="${searchVO.winsYn}">
			</form>

			<ul id="prmtList">
				<c:forEach items="${resultList}" var="result">
					<li>
						<c:if test="${empty searchVO.sPrmtDiv}">
						<a href="<c:url value='/mw/evnt/detailPromotion.do?type=plan&prmtNum=${result.prmtNum}&prmtDiv=${Constant.PRMT_DIV_PLAN}&finishYn=${searchVO.finishYn}&winsYn=${searchVO.winsYn}'/>">
						</c:if>
						<c:if test="${searchVO.sPrmtDiv eq 'GOVA'}">
						<a href="<c:url value='/mw/evnt/detailGovAnnouncement.do?prmtDiv=GOVA&prmtNum=${result.prmtNum}'/>">
						</c:if>
							<div class="photo">
								<img class="product" src="${result.listImg}" alt="${result.prmtNm}">
							</div>
							<div class="info">
								<div class="text-area">
									<div class="title"><c:out value="${result.prmtNm}"/></div>
									<div class="date">
										<fmt:parseDate value="${result.startDt}" var="startDt" pattern="yyyyMMdd" />
										<fmt:parseDate value="${result.endDt}" var="endDt" pattern="yyyyMMdd" />
										<fmt:formatDate value="${startDt}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" />
									</div>
								</div>
							</div>
						</a>
					</li>
				</c:forEach>

				<c:if test="${fn:length(resultList) == 0}">
					<div class="item-noContent">
						<p><img src="/images/web/icon/warning2.gif" alt="경고"></p>
						<p class="text">죄송합니다.<br>현재 진행중인
							<c:if test="${searchVO.sPrmtDiv ne 'GOVA'}"><span class="comm-color1">기획전</span>이 </c:if>
							<c:if test="${searchVO.sPrmtDiv eq 'GOVA'}"><span class="comm-color1">공고</span>가 </c:if>
						없습니다.</p>
					</div>
				</c:if>
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
