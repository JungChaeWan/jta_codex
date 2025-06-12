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
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="author" content="nextez">
	<meta name="format-detection" content="telephone=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	
	<!-- css -->	
	<link rel="stylesheet" href="<c:url value='/css/comm/jquery-ui.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/mw/common.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/mw/qr-code.css'/>">
	
	<!-- script -->
	<jsp:include page="/mw/includeJs.do" />

	<script src="<c:url value='/js/jquery-1.11.1.js'/>"></script>
	<script src="<c:url value='/js/jquery-ui-1.11.4.js'/>"></script>
	
</head>
<body>
  <div id="wrap" style="background-color: #ffffff;">
		<header id="header">
			<h2 class="logo"><img src="/images/mw/common/logo.gif" alt="탐나오"></h2>
			<div class="r-area"><span>고객센터 :</span> <strong>1522-3454</strong></div>
		</header>

		<main id="main">
			<section class="contents-wrap">
				<img class="width100" src="/data/prmt/adv/m1.jpg" alt="면세점">
			</section> <!--//contents-wrap-->
		</main>

	</div> <!-- //wrap -->
</body>
</html>