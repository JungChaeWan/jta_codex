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

<head>
<jsp:include page="/mw/includeJs.do" flush="false">
	<jsp:param name="title" value="제주여행 공공플랫폼 탐나오, 공지사항"/>
    <jsp:param name="description" value="제주도 항공권, 숙박, 렌터카, 관광지 여행상품 관련 공지사항. 제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영"/>
    <jsp:param name="keywords" value="실시간 항공,숙박,렌터카,관광지,맛집,여행사,레저,체험,특산기념품"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 탐나오, 공지사항">
<meta property="og:url" content="https://www.tamnao.com/mw/bbs/bbsList.do?bbsNum=NOTICE">
<meta property="og:description" content="제주도 항공권, 숙박, 렌터카, 관광지 여행상품 관련 공지사항. 제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<%--
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_center.css?version=${nowDate}'/>">
--%>	
<script type="text/javascript">

	/**
	 * 조회 & 페이징
	 */
	function fn_Search(pageIndex){
		document.frm.pageIndex.value = pageIndex;
		document.frm.action = "<c:url value='/mw/bbs/bbsList.do'/>";
		document.frm.submit();
	}
	
	function fn_Ins(){
		document.frm.action = "<c:url value='/mw/bbs/bbsRegView.do'/>";
		document.frm.submit();
	}
	
	function fn_dtl(nIdx){
		document.frm.noticeNum.value = nIdx;	
		document.frm.action = "<c:url value='/mw/bbs/bbsDtl.do'/>";
		document.frm.submit();
	}
	
	$(document).ready(function(){
		if('${authListYn}' != 'Y'){
			alert("권한이 없습니다.");
			history.back();
		}
	});
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="공지사항"/>
	</jsp:include>
</header>
<!-- 헤더 e -->
<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="menu-bar">
		<p class="btn-prev"><img src="/images/mw/common/btn_prev.png" width="20" alt="이전페이지"></p>
		<h2>공지사항</h2>
	</div>

	<div class="sub-content">
		<div class="board">
			<form name="frm" id="frm" method="get" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" id="bbsNum" name="bbsNum" value="${bbs.bbsNum}"/>
				<input type="hidden" id="noticeNum" name="noticeNum" value=""/>

				<div class="search">
					<select id="sKeyOpt" name="sKeyOpt">
						<option value="1" <c:if test="${searchVO.sKeyOpt == null || searchVO.sKeyOpt == 1 }">selected="selected"</c:if> >제목</option>
						<option value="2" <c:if test="${searchVO.sKeyOpt == 2 }">selected="selected"</c:if> >작성자</option>
					</select>
					<input type="text" id="sKey" name="sKey" value="<c:out value='${searchVO.sKey}'/>">

					<%-- <a href="javascript:void(0);" class="btns btn-search" onclick="fn_Search(1);">검색</a> --%>
					<a id="notice-search-btn" class="btns btn-search" onclick="fn_Search(1);">검색</a>
				</div>
	
				<p class="txt">총 <strong>${totalCnt }</strong>개의 게시물이 있습니다.</p>
	
				<ul class="list">
					<c:if test="${fn:length(resultList) == 0}">
						<li><strong>내역이 없습니다.</strong></li>
					</c:if>
				
					<c:forEach var="data" items="${resultList}" varStatus="status">
						<li>
							<c:if test="${authDtlYn=='Y' || (isLogin=='Y' && data.userId == userInfo.userId)}"><%--글쓰기 권한 있는사용자만 --%>
								<a href="javascript:fn_dtl(${data.noticeNum})">
							</c:if>
				            <c:if test="${!(authDtlYn=='Y' || (isLogin=='Y' && data.userId == userInfo.userId))}"><%--글쓰기 권한 있는사용자만 --%>
				            	<a href="javascript:alert('권한이 없습니다.')">
				            </c:if>
							<strong>
								<c:if test="${data.anmYn == 'Y' }">[공지]</c:if>
								<c:out value="${data.subject}"/>
							</strong><br>
							<em><c:out value="${data.writer}"/> &nbsp;&nbsp; ${data.frstRegDttm}</em>
							</a>
						</li>
					</c:forEach>
				</ul>
				
				<c:if test="${fn:length(resultList) != 0}">
					<div class="pageNumber">
						<p class="list_pageing">
							<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" />
						</p>
					</div>
				</c:if>
			</form>

			<c:if test="${authRegYn == 'Y'}"><%--글쓰기 권한 있는사용자만 --%>
				<div class="boardBT">
					<div class="boardBT"><a href="javascript:fn_Ins()">글쓰기</a></div>
				</div>
			</c:if>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 푸터 e -->
</div>
</body>
</html>