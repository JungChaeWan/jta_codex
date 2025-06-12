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
	<jsp:include page="/mw/includeJs.do"></jsp:include>

	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_member.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css'/>">	
<script type="text/javascript">
$(document).ready(function(){
});
</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>아이디/비밀번호 찾기</h2>
	</div>
	<div class="sub-content2">
		<div class="join">			
			<h4 class="comm-title1">아이디 찾기 완료</h4>
			<div class="bgWrap">
				<h5 class="info">아이디 정보는 아래와 같습니다</h5>
				<div class="memoWrap">

					<c:forEach items="${userVOList}" var="user" varStatus="status">
						<img src="/images/mw/sub/mypage_character.png" alt="아이디 찾기 완료 캐릭터">
						<p class="confMemo">아이디<strong><c:out value="${user.email}"/></strong></p>
					</c:forEach>

				</div>				
			</div>
		</div>
		
		<p class="btn-list form-actions">
			<a href="<c:url value='/mw/viewLogin.do?rtnUrl=/mw/main.do'/>" class="btn btn1 login-btn">로그인</a>
			<a href="<c:url value='/mw/viewFindIdPwd.do'/>?showTab=2" class="btn btn2 forgot-password-btn">비밀번호 찾기</a>
		</p>

	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>
