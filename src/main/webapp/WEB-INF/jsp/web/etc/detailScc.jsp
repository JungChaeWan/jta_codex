<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<head>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?noticeNum=${sccVO.noticeNum}"/>

<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="제주여행 공공플랫폼 탐나오, ${sccVO.subject}"/>
    <jsp:param name="description" value="제주여행 공공플랫폼 탐나오, ${sccVO.simpleExp}"/>
    <jsp:param name="keywords" value="실시간 항공,숙박,렌터카,관광지,맛집,여행사,레저,체험,특산기념품"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 탐나오, ${sccVO.subject}">
<meta property="og:url" content="${strUrl}">
<meta property="og:description" content="제주여행 공공플랫폼 탐나오, ${sccVO.simpleExp}">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/lite-yt-embed.css'/>" />
<script type="text/javascript" src="<c:url value='/js/lite-yt-embed.js'/>"></script>

<script type="text/javascript"></script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
        <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <span>회사소개</span> <span class="gt">&gt;</span>
                <span>홍보영상</span>
            </div>
        </div>
        <!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
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
                                    <h3 class="mainTitle">홍보영상</h3>
                                    <div class="commBoard-wrap">
                                    	<div class="board-view">
									        <div class="view-head">
									            <h5><c:out value="${sccVO.subject}"/></h5>
									            <p><c:out value="${sccVO.simpleExp}"/></p>
									        </div>
									
									        <!-- 콘텐츠 -->
									        <div class="view-content">
									        	<div class="video">
									            	<%-- <iframe width="100%" height="415" src="https://www.youtube.com/embed/${sccVO.youtubeId}" frameborder="0" allowfullscreen></iframe> --%>
									            	<lite-youtube videoid="${fn:replace(sccVO.youtubeId, 'https://www.youtube.com/embed/', '')}" style="width:100%;height:415px;" playlabel="${sccVO.subject}"></lite-youtube>
									            </div>
									        </div> <!--//view-content-->
									        <!-- 콘텐츠 -->
                                            <div class="view-content">
                                                <c:out value='${sccVO.contents}' escapeXml='false' />
                                            </div>
									    </div> <!--//board-view-->
                                    </div> <!--//commBoard-wrap-->
                                </div> <!--//rContents-->
                            </div> <!--//tbWrap-->
                		</div> <!--//inner-->
                	</div> <!--//bgWrap2-->
                </div><!-- //new contents -->
            </div>
        </div> <!-- //subContainer -->
	</main>
	
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>