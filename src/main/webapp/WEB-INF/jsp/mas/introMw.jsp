<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>탐나오 입점업체 관리자시스템</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/adm_mw/comm_default.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/adm_mw/comm_style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/adm_mw/login.css'/>" />

<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui-1.11.4.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/admin_mw/html_comm.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/admin_mw/html_style.js'/>" ></script>
<script type="text/javascript">
var getContextPath = "${pageContext.request.contextPath}";

/**
 * 로그인
 */
function fn_login(){
	if($("#corpId").val() == ""){
		alert("<spring:message code='errors.required2' arguments='상점아이디'/>");
		$("#corpId").focus();
		return;
	}
	/* if($("#email").val() == ""){
		alert("<spring:message code='errors.required2' arguments='이메일'/>");
		$("#email").focus();
		return;
	} */
	if($("#pwd").val() == ""){
		alert("<spring:message code='errors.required2' arguments='비밀번호'/>");
		$("#pwd").focus();
		return;
	}

	document.frm.action = getContextPath + "/mw/mas/actionMasLogin.do";
	document.frm.submit();
}


$(document).ready(function(){
	if("${failLogin}" == "Y"){
		alert('<spring:message code="fail.common.login"/>');
	}else if("${failLogin}" == "1"){
		alert("아이디를 입력해주세요.");
		$("#corpId").focus();
	}else if("${failLogin}" == "2"){
		alert("비밀번호를 입력해주세요.");
		$("#pwd").focus();
	}else{
		$("#corpId").focus();
	}
});
</script>

</head>
<body>
<div id="wrap">
	<header id="header">
			<!--<h1><img class="logo" src="../../images/adm_mw/login/logo.gif" alt="탐나오"></h1>-->
		</header>

		<main id="main">

			<section class="login-wrap">
				<h2><span class="logo"><img src="<c:url value='/images/adm_mw/login/logo.gif'/>" alt="탐나오"></span> 입점업체 관리자시스템</h2>
				<form id="frm" name="frm" onSubmit="fn_login(); return false;" method="post">
				<div class="login-box">
					<form>
						<h3>ADMIN LOGIN</h3>
						<div class="int-box">
							<label for="userID">상점 아이디</label>
							<input id="corpId" name="corpId" type="text">
						</div>
						<div class="int-box">
							<label for="pwd">비밀번호</label>
							<input id="pwd" name="pwd" type="password">
						</div>
						<div class="login-btn"><button type="submit">LOGIN</button></div>
					</form>
				</div>
				</form>
				<p class="copy">Copyright 2018. 탐나오 All Rights Reserved.</p>
			</section> <!--//login-wrap-->

		</main>

		<footer id="footer">

		</footer>
	</div>
</body>
</html>