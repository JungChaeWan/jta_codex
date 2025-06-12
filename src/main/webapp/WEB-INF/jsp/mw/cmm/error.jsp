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
<meta name="robots" content="noindex">
<meta name="robots" content="noindex, nofollow">

	<jsp:include page="/mw/includeJs.do" />
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_ticket.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/error.css'/>">
</head>
<body>
	<div class="error-wrap">
		<img class="icon" src="/images/mw/error/error.png" alt="error">

		<h2 class="error-msg">
			<c:if test="${empty errPage.errCord}">
				오류 입니다.
			</c:if>

			<c:if test="${not empty errPage.errCord}">
				<c:if test="${empty errPage.errMsg}">
					<c:choose>
						<%--일반 오류 --%>
						<c:when test="${errPage.errCord == '404'}">없는 페이지입니다.</c:when>
						<c:when test="${errPage.errCord == '500'}">서버 오류입니다.</c:when>

						<%--게시판 관련 오류 --%>
						<c:when test="${errPage.errCord == 'BBS01'}">존재하지 않는 게시판입니다.</c:when>
						<c:when test="${errPage.errCord == 'BBS02'}">존재하지 않는 게시글입니다.</c:when>
						<c:when test="${errPage.errCord == 'BBS03'}">권한이 없습니다.</c:when>

						<%--상품 관련 오류 --%>
						<c:when test="${errPage.errCord == 'PRDT01'}">존재하지 않는 상품입니다.</c:when>
						<c:when test="${errPage.errCord == 'PRDT02'}">
							상세보기(미리보기)가 불가능한 상품입니다.<br>
							상품 옵션의 출력여부를 '출력'으로 수정해주세요.
						</c:when>

						<%--관광지 CCTV 오류 --%>
						<c:when test="${errPage.errCord == 'CCTV'}">
							CCTV 연동 서비스 준비중입니다.<br>
							- 주요 관광지의 실시간 영상 제공 예정
						</c:when>

						<c:otherwise>오류입니다.</c:otherwise>
					</c:choose>
				</c:if>

				<c:if test="${not empty errPage.errMsg}">
					<c:out value="${errPage.errMsg}"/>
				</c:if>
			</c:if>
		</h2>

		<c:if test="${errPage.errCord ne 'PRDT02' && errPage.errCord ne 'CCTV'}">
			<p class="error-text">관리자에게 문의해 주세요!</p>
		</c:if>

		<div class="button">
			<c:choose>
				<%--상품 관련 오류 --%>
				<c:when test="${errPage.errCord == 'PRDT01' }">
					<a href="<c:url value='/'/>">메인페이지로 이동</a>
				</c:when>
				<c:when test="${errPage.errCord == 'PRDT02' }">
					<a onclick="window.close();">현재페이지 닫기</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:history.back();">이전페이지로 이동</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>
	