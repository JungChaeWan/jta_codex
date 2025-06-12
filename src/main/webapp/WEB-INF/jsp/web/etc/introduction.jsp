<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<head>
<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="제주여행 공공플랫폼 탐나오, 회사소개"/>
    <jsp:param name="description" value="제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영 회사소개"/>
    <jsp:param name="keywords" value="실시간 항공,숙박,렌터카,관광지,맛집,여행사,레저,체험,특산기념품"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 탐나오, 회사소개">
<meta property="og:url" content="https://www.tamnao.com/web/etc/introduction.do">
<meta property="og:description" content="제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영 회사소개">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<script type="text/javascript">
</script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do"></jsp:include>
</header>
<main id="main">
        <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <span>회사소개</span>
            </div>
        </div>
        <div class="subContainer">
       		<div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="service-center sideON">
                	<div class="bgWrap2">
                		<div class="inner">
                			<div class="tbWrap">

                                <jsp:include page="/web/introLeft.do?menu=otoinq" flush="false"></jsp:include>
                                <div class="rContents smON">
                                    <h3 class="mainTitle">회사소개</h3>
                                    <div class="introduction">
                                    	<img src="<c:url value='/images/web/introduction/introduction.jpg'/>" alt="인사말">
                                    </div> <!--//introduction-->
                                </div> <!--//rContents-->
                            </div> <!--//tbWrap-->
                		</div>
                	</div>
                </div>
            </div> <!-- //new contents -->
        </div> <!-- //subContainer -->
</main>

<jsp:include page="/web/right.do"></jsp:include>
<jsp:include page="/web/foot.do"></jsp:include>
</body>
</html>