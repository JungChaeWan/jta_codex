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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css'/>">
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
		<h2>결제실패</h2>
	</div>
	<div class="sub-content">
		<div class="reserve">
			<div class="txt-box fail">
                <img src="/images/mw/etc/tamnarbang_02.png" alt="승인실패">
				<p class="tit">결제승인에 실패했습니다</p>
			</div>
			<table class="fail bt-none">
				<tr>
					<th>예약번호</th>
					<td><c:out value="${rsvNum}"/></td>
				</tr>
				<tr>
					<th>실패사유</th>
					<td>
						<c:out value="${rtnCode}"/><br>
						<c:out value="${rtnMsg}"/>
					</td>
				</tr>
			</table>

			<p class="info-txt">
				* 주문상세내역은 사이트상단의 <em>마이페이지 > 나의예약/구매내역</em>에서 확인하실 수 있습니다.<br>
				* 주문과 관련된 문의사항이 있으신 경우 고객센터를 통해 문의해 주시기 바랍니다.<br>
				* <em>아이폰 사파리에서 결제가 되지않는 문제</em><br>
				원인 : IOS 11.3버전 업데이트로 인해 보안이 강화되어 http를 사용하는 결제창에서 이슈발생<br>
				해결방법 : 아이폰 - 설정 - 사파리 - 위조된 웹사이트 경고 (혹은 웹사이트 경고)를 '비활성화'
			</p>

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
