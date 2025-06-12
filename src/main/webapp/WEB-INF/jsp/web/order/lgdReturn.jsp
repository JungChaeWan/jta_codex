<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
           
<head>
<meta name="robots" content="noindex, nofollow">
<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<!-- css -->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/other.css'/>" />
<script type="text/javascript">
function setLGDResult() {
	parent.payment_return();
	try {
	} catch (e) {
		alert(e.message);
	}
	// window.close();
}
</script>
</head>
<body onload="setLGDResult()">	
	
	<div class="other-wrap">
<%-- 		<h1>인증결과</h1>
		<h2>결과코드 : ${LGD_RESPCODE}</h2>
		<h2>결과메세지</h2>
		<p>${LGD_RESPMSG}</p>

		<div class="button">
			<a href="javascript:setLGDResult();">닫기</a>
		</div> --%>
		<p class="loading"><img src="../images/web/icon/loading.gif" alt="로딩바"></p>
	</div>
	<form method="post" name="LGD_RETURNINFO" id="LGD_RETURNINFO">
		<input type="hidden" name="LGD_RESPCODE" id="LGD_RESPCODE" value="${LGD_RESPCODE}">
		<input type="hidden" name="LGD_RESPMSG" id="LGD_RESPMSG" value="${LGD_RESPMSG}">
		<input type="hidden" name="LGD_PAYKEY" id="LGD_PAYKEY" value="${LGD_PAYKEY}">
	</form>
</body>
</html>