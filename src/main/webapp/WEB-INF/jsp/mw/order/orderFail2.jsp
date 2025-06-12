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

<script type="text/javascript" src="<c:url value='/js/mw_adDtlCalendar.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/mw_glDtlCalendar.js'/>"></script>
	
<script type="text/javascript">
$(document).ready(function(){
	
});
</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" />
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent" class="transBG">
	<div class="menu-bar">
		<p class="btn-prev"><img src="/images/mw/common/btn_prev.png" width="20" alt="이전페이지"></p>
		<h2>예약실패</h2>
	</div>
	<div class="sub-content">
		<div class="reserve">
			<div class="txt-box fail">
				<img src="../../images/web/error/tamnarbang_03.png" alt="오류">
				<p class="tit">오류가 발생했습니다.</p>
				<p class="sub-tit">
					* 상품 결제 대기시간(${Constant.WAITING_TIME}분)이 경과하였거나,
					<br> * 잔액부족상태
					<br> 이미 결제완료 상품, 네트워크 오류일 수 있습니다.
					<br> 탐나오 마이페이지를 확인하셔서 예약/구매 내역을 확인해 주시기 바랍니다.
					<br> 홈으로 이동하여 다시 상품 주문을 진행해주세요.
				</p>
			</div>

			<p class="btn-list">
				<a href="<c:url value='/mw/main.do'/>" class="btn btn1 center">홈으로</a>
			</p>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" />
<!-- 푸터 e -->
</div>
</body>
</html>
