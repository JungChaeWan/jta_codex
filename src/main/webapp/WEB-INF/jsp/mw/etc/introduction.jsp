<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
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
	<jsp:param name="title" value="제주여행 공공플랫폼 탐나오, 회사소개"/>
    <jsp:param name="description" value="제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영 회사소개"/>
    <jsp:param name="keywords" value="실시간 항공,숙박,렌터카,관광지,맛집,여행사,레저,체험,특산기념품"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 탐나오, 회사소개">
<meta property="og:url" content="https://www.tamnao.com/web/etc/introduction.do">
<meta property="og:description" content="제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영 회사소개">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_center.css'/>">	
<script type="text/javascript">
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false">
		<jsp:param name="type" value="introduction"/>
		<jsp:param name="headTitle" value="회사소개"/>
	</jsp:include>
</header>
<!-- 헤더 e -->
<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>회사소개</h2>
	</div>
	<div class="sub-content">
		<img src="/images/web/introduction/introduction.jpg" width="100%" alt="회사소개">
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>
</body>
</html>