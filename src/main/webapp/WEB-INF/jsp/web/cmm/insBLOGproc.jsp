<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head>
	<meta name="robots" content="noindex, nofollow">
	<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>

	<script type="text/javascript">

	$(document).ready(function(){

		window.opener.reloadBlogList('${prdtNum}', '${corpCd}');
		window.close();


	});

	function Winclose(){
		window.opener.reloadBlogList('${prdtNum}', '${corpCd}');

		window.close();
	}

	</script>

	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<!-- css -->
	<link rel="stylesheet" href="<c:url value='/css/web/common.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/web/style.css'/>">
</head>
<body>

<div id="wrap">

    <div class="popup-wrap">
    	<div class="blog-write">
    		<p class="caption-typeA">

				추가완료

			<div class="btn-wrap">
			    <button type="button" class="comm-btn" onclick="Winclose();">닫기</button>
			</div>
    	</div> <!-- //blog-write -->
    </div> <!-- //popup-wrap -->

</div> <!--//wrap-->






</body>
</html>