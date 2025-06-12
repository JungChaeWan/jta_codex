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
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="제주여행 MD's Pick, 탐나오"/>
</jsp:include>
<meta property="og:title" content="제주여행 MD's Pick, 탐나오">
<meta property="og:url" content="https://www.tamnao.com/mw/coustomer/mdsPickList.do">
<meta property="og:description" content="제주여행공공플랫폼 탐나오. 제주 항공권, 숙소, 렌터카, 관광지 추천 예약을 모두 한 곳에서, 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다.">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>"> --%>
<link rel="canonical" href="https://www.tamnao.com/web/coustmer/mdsPickList.do">
<script type="text/javascript">
	function fn_Search(pageIndex) {
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/mw/coustomer/mdsPickList.do'/>";
		document.frm.submit();
	}
</script>
</head>
<body>
<div id="wrap">
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="type" value="plan"/>
	  	<jsp:param name="headTitle" value="MD'S Pick"/>
	</jsp:include>
</header>

<main id="main">
	<div class="mw-list-area">
		<%--
		<section class="menu-typeA">
	        <h2 class="sec-caption">메뉴 선택</h2>
	        <nav id="scroll_menuA" class="scroll-menuA center">
	            <div class="scroll-area">
	                <ul>
	                    <li><a href="<c:url value='/mw/evnt/prmtPlanList.do' />">상품기획전</a></li>
	                    <li class="active"><a href="<c:url value='/mw/coustomer/mdsPickList.do' />">MD's Pick</a></li>
	                </ul>
	            </div>
	        </nav>        
	    </section>
		--%>
		<div class="event-item-area">
			<div class="title-img">
				<img src="/images/mw/main/md-title.jpg" alt="탐나오 MD가 직접가서 보고, 느끼고, 추천해 드립니다">
			</div>
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
			</form>

			<ul>
				<c:forEach items="${resultList}" var="result">
					<li>
						<a href="<c:url value='/mw/coustomer/mdsPickDtl.do?rcmdNum=${result.rcmdNum }' />">
							<div class="photo">
								<img class="product" src="${result.listImgPath}" alt="${result.corpNm}">
							</div>
							<div class="info">
								<div class="text-area">
									<div class="title"><c:out value="${result.corpNm}"/></div>
									<div class="date"><c:out value="${result.subject}"/></div>
								</div>
							</div>
						</a>
					</li>
				</c:forEach>

				<c:if test="${fn:length(resultList) == 0}">
					<div class="item-noContent">
						<p><img src="/images/web/icon/warning2.gif" alt="경고"></p>
						<p class="text">죄송합니다.<br>현재 진행중인 <span class="comm-color1">MD's Pick</span>이 없습니다.</p>
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