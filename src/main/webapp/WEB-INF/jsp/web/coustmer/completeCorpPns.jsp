<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"           uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui"          uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn"          uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring"      uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"        uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt"         uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="validator"   uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="un"          uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" />

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />

<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
        <div class="mapLocation"> <!--index page에서는 삭제-->
            <div class="inner">
                <span>홈</span> <span class="gt">&gt;</span>
                <span>고객센터</span><span class="gt">&gt;</span>
                <span>입점/제휴 완료</span>
             </div>
         </div>
         <!-- quick banner -->
   		<jsp:include page="/web/left.do" />
        <!-- //quick banner -->
        <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="service-center sideON">
                    <div class="bgWrap2">
                        <div class="inner">
                            <div class="tbWrap">
                            	<jsp:include page="/web/coustmer/left.do?menu=corpPns" />
                            	<div class="rContents smON">
                                    <h3 class="mainTitle">입점/제휴 완료</h3>

                                    <div class="end-wrap">
                                        <div class="text-wrap">
                                            <p class="img-box"><img src="/images/web/icon/end_check.png" alt="check"></p>
                                            <h4 class="main-t">탐나오 입점 신청이 완료됐습니다.</h4>
                                            <p class="sub-t">
                                                관리자의 심사 및 승인 완료 후에 정상적인 서비스를 이용하실 수 있습니다.
                                            </p>
                                        </div>
                                        <div class="comm-button2 fixing">
                                            <a href="<c:url value='/main.do'/>" class="color1">홈으로</a>
                                            <!-- <a href="">로그인</a> -->
                                        </div>
                                    </div> <!--//end-wrap-->
                                </div> <!--//rContents-->
                            </div> <!--//tbWrap-->
                        </div> <!--//Fasten-->
                    </div> <!--//bgWrap2-->
                </div> <!-- //affiliates -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>

<jsp:include page="/web/foot.do" />
</body>
</html>