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
<meta name="robots" content="noindex">
<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>

<script src="<c:url value='/js/freewall.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/multiple-select.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/air_step1.js'/>"></script>
<!-- main add -->
<script type="text/javascript" src="<c:url value='/js/cycle.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/freewall.js'/>"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/main4.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>




<script type="text/javascript">
	
$(document).ready(function(){
	
});

console.log("접속 IP => ${connIp}");
</script>

</head>
<body>

<div id="wrap">
    <div class="server-work" style="width: 1135px; margin: 0 auto;">
        <img src="/images/web/other/server.jpg" alt="홈페이지 점검중입니다.">
    </div> <!--//server-work-->

</div> <!--//wrap-->
</body>
</html>