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

 <un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">

<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
        <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <span>고객센터</span> <span class="gt">&gt;</span>
                <span>이용후기</span>
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
                        <div class="Fasten">
                            <div class="tbWrap">
                                <jsp:include page="/web/coustmer/left.do?menu=qa" flush="false"></jsp:include>


                                <div class="rContents smON">
                                    <h3 class="mainTitle">환불/취소규정</h3>
                                    <!-- 탭 정보 (리뷰, 기타 등등) -->
                                    <div id="tabs" class="detailTabMenu2">
                                        <ul class="menuList">
                                            <li><a class="select" href="#tabs-1">실시간항공</a></li>
                                            <li><a href="#tabs-2">실시간숙박</a></li>
                                            <li><a href="#tabs-3">실시간렌터카</a></li>
                                            <li><a href="#tabs-4">실시간골프</a></li>
                                            <li><a href="#tabs-5">관광지/레저</a></li>
                                            <li><a href="#tabs-6">음식/뷰티</a></li>
                                        </ul>
                                        <!--항공-->
                                        <div id="tabs-1" class="tabPanel">
                                            <!--콘텐츠 없을 시-->
                                            <!--<p class="no-content">환불/취소규정 내역이 없습니다.</p>-->
                                            <article class="comm-art1">
                                                <h6>title text</h6>
                                                <p>1</p>
                                            </article>
                                        </div> <!-- //tabs-1 -->
                                        <!--숙박-->
                                        <div id="tabs-2" class="tabPanel">
                                            <article class="comm-art1">
                                                <h6>title text</h6>
                                                <p>2</p>
                                            </article>
                                        </div> <!-- //tabs-2 -->
                                        <!--렌터카-->
                                        <div id="tabs-3" class="tabPanel">
                                            <article class="comm-art1">
                                                <h6>title text</h6>
                                                <p>3</p>
                                            </article>
                                        </div> <!-- //tabs-3 -->
                                        <!--골프-->
                                        <div id="tabs-4" class="tabPanel">
                                            <article class="comm-art1">
                                                <h6>title text</h6>
                                                <p>4</p>
                                            </article>
                                        </div> <!-- //tabs-4 -->
                                        <!--관광지/레저-->
                                        <div id="tabs-5" class="tabPanel">
                                            <article class="comm-art1">
                                                <h6>title text</h6>
                                                <p>5</p>
                                            </article>
                                        </div> <!-- //tabs-5 -->
                                        <!--음식/레져/뷰티-->
                                        <div id="tabs-6" class="tabPanel">
                                            <article class="comm-art1">
                                                <h6>title text</h6>
                                                <p>6</p>
                                            </article>
                                        </div> <!-- //tabs-6 -->
                                        <script>
                                            tabPanel({container:"#tabs"});
                                        </script>
                                    </div> <!--//tabs-->
                                </div> <!--//rContents-->







                            </div> <!--//tbWrap-->
                        </div> <!--//Fasten-->
                    </div> <!--//bgWrap2-->
                </div> <!-- //mypage2_2 -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>

<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>