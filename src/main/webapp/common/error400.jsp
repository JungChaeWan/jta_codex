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
	<meta charset="UTF-8">
	<title>400 ERROR</title>
	
	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<!-- css -->	    
	<link rel="stylesheet" href="<c:url value='/css/web/common.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/web/error.css'/>">
</head>
<body>	
	
	<div class="error-wrap">
		<img class="icon" src="<c:url value='/images/web/error/error.png'/>" alt="error">

		<h2 class="error-msg">
			방화벽 정책에 의해 차단되었습니다.
		</h2>
		<p class="error-text">관리자에게 문의해 주세요!</p>
	</div>

</body>
</html>