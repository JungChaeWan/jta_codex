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
<jsp:include page="/mw/includeJs.do" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_cart.css'/>">
</head>
<script>

	function calcHeight() {
		//find the height of the internal page

		var the_height =
				document.getElementById('the_iframe').contentWindow.document.body.scrollHeight;

		//change the height of the iframe
		document.getElementById('the_iframe').height =
				the_height;

		//document.getElementById('the_iframe').scrolling = "no";
		document.getElementById('the_iframe').style.overflow = "hidden";
	}

	setInterval(function() {
		let chkPath = document.getElementById("the_iframe").contentWindow.location.href;

		if(chkPath.indexOf("orderComplete.do") > 0 || chkPath.indexOf("main.do") > 0 || chkPath.indexOf("orderFail") > 0) {
			window.parent.location.href = chkPath;
		}
	}, 1000);

</script>
<body>
<div id="wrap">

	<!-- 헤더 s -->
	<header id="header">
		<jsp:include page="/mw/head.do" />
	</header>
	<div>
		<iframe src="${tamnacardLinkUrl}"  id="the_iframe" onload="calcHeight();" name="" title="" frameborder="0" scrolling="no" style="overflow-x:hidden; overflow:auto; width:100%; min-height:500px;"></iframe>
	</div>
</div>
</body>
</html>