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
	<jsp:param name="title" value="제주여행 특가 이벤트, 탐나오"/>
</jsp:include>

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>"> --%>
<link rel="canonical" href="https://www.tamnao.com/web/evnt/promotionList.do">
<script type="text/javascript">
	function fn_Search(pageIndex) {
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/mw/evnt/promotionList.do'/>";
		document.frm.submit();
	}
</script>
</head>
<body>
<div id="wrap">
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="이벤트"/>
	</jsp:include>
</header>

<main id="main">
	<div class="mw-list-area">
		<section class="menu-typeA">
	        <h2 class="sec-caption">메뉴 선택</h2>
	        <nav id="scroll_menuA" class="scroll-menuA center">
	            <div class="scroll-area">
	                <ul>
	                    <li<c:if test="${(searchVO.winsYn eq Constant.FLAG_N) and (searchVO.finishYn eq Constant.FLAG_N)}"> class="active"</c:if>>
							<a href="<c:url value='/mw/evnt/promotionList.do?finishYn=${Constant.FLAG_N}&winsYn=${Constant.FLAG_N}' />">진행중인 이벤트</a>
						</li>
	                    <%-- <li<c:if test="${searchVO.winsYn eq Constant.FLAG_N and searchVO.finishYn ne Constant.FLAG_N }"> class="active"</c:if>>
	                    	<a href="<c:url value='/mw/evnt/promotionList.do?finishYn=${Constant.FLAG_Y}&winsYn=${Constant.FLAG_N}' />">종료된 이벤트</a>
	                    </li> --%>
	                    <li<c:if test="${searchVO.winsYn eq Constant.FLAG_Y}"> class="active"</c:if>>
							<a href="<c:url value='/mw/evnt/promotionList.do?finishYn=${Constant.FLAG_Y}&winsYn=${Constant.FLAG_Y}' />">당첨자 발표</a>
						</li>
	                </ul>
	            </div>
	        </nav>        
	    </section>
	    
		<div class="event-item-area">
	        <ul>
				<form name="frm" id="frm" method="post" onSubmit="return false;">
					<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" id=finishYn name="finishYn" value="${searchVO.finishYn}"/>
					<input type="hidden" id=winsYn name="winsYn" value="${searchVO.winsYn}"/>
				</form>

			  	<c:forEach items="${resultList}" var="result">
					<li>
						<a href="<c:url value='/mw/evnt/detailPromotion.do?prmtNum=${result.prmtNum}&prmtDiv=${Constant.PRMT_DIV_EVNT}&finishYn=${searchVO.finishYn}&winsYn=${searchVO.winsYn}'/>">
							<jsp:useBean id="now" class="java.util.Date" />
							<fmt:parseDate value="${result.startDt}" var="startDt" pattern="yyyyMMdd" />
							<fmt:parseDate value="${result.endDt}" var="endDt" pattern="yyyyMMdd" />
							<fmt:parseNumber value="${now.time / (3600*24*1000)}" integerOnly="true" var="nowTime" scope="request" />
							<fmt:parseNumber value="${endDt.time / (3600*24*1000)}" integerOnly="true" var="endTime" scope="request" />
							<fmt:parseNumber value="${endTime - nowTime + 1}" var="dayNum" scope="request" />
							<c:if test="${(result.ddayViewYn eq Constant.FLAG_Y) and (dayNum > 0) and (dayNum < 8)}">
								<div class="d-day">D-${dayNum}</div>
							</c:if>
							<div class="photo">
								<img class="product" src="${result.listImg}" alt="${result.prmtNm}">
							</div>
							<div class="info">
								<div class="text-area">
									<div class="title"><c:out value="${result.prmtNm}"/></div>
									<div class="date">
										<fmt:formatDate value="${startDt}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${endDt}" pattern="yyyy-MM-dd" />
									</div>
								</div>
							</div>
						</a>
					</li>
	          	</c:forEach>

	          	<c:if test="${fn:length(resultList) eq 0}">
					<div class="item-noContent">
						<p><img src="/images/web/icon/warning2.gif" alt="경고"></p>
						<c:if test="${searchVO.winsYn eq Constant.FLAG_Y}">
							<p class="text">죄송합니다.<br>당첨자가 발표된 <span class="comm-color1">이벤트</span>가 없습니다.</p>
						</c:if>
						<c:if test="${searchVO.winsYn eq Constant.FLAG_N}">
							<p class="text">죄송합니다.<br>현재 진행중인 <span class="comm-color1">이벤트</span>가 없습니다.</p>
						</c:if>
					</div>
	    	  	</c:if>
	        </ul>
		</div> <!--//event-item-area-->

		<c:if test="${fn:length(resultList) > 0}">
			<div class="pageNumber">
				<p class="list_pageing"><ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" /></p>
			</div>
		</c:if>
	</div> <!--//mw-list-area-->
	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>

</body>
</html>
