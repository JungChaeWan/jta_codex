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

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_mypage.css'/>">
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
<jsp:include page="/mw/head.do">
	<jsp:param name="headTitle" value="1:1 문의내역"/>
</jsp:include>

<script type="text/javascript">

	function fn_otoinqDelete(otoinqNum){
		if(!confirm("삭제 하시겠습니까?")){
			return;
		}
		
		document.frm.otoinqNum.value = otoinqNum;
		document.frm.action = "<c:url value='/mw/mypage/otoinqDelete.do'/>";
		document.frm.submit();
	}
</script>
</header>
<!-- 헤더 e -->
<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>1:1 문의내역</h2>
	</div>
	<div class="sub-content">
		<div class="counsel-list">
			<p class="txt">※ 상품관련문의</p>
			<c:if test="${fn:length(otoinqList) == 0}">
				<dl>
					<dt>
						<strong>내역이 없습니다.</strong>
					</dt>
				</dl>
			</c:if>
			
			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<input type="hidden" id="otoinqNum" name="otoinqNum" value=""/>
			
				<c:forEach var="data" items="${otoinqList}" varStatus="status">
					<dl>
						<dt>
							<span><em>Q</em></span>
							<span>
								${data.frstRegDttm}
								<a href="<c:out value="/mw/mypage/otoinqUpdateView.do"/>?otoinqNum=${data.otoinqNum}" class="btn btn-reply">수정</a>
								<a href="javascript:fn_otoinqDelete('${data.otoinqNum}')" class="btn btn-reply">삭제</a>
								<br>
								<strong><c:out value="${data.subject}"/></strong><br/>
								<c:out value="${data.contents}" escapeXml="false"/>
							</span>
						</dt>
						<c:if test="${data.ansContents != '' }">
							<dd>
								<span><em>A</em></span>
								<span>
									<strong><c:out value="${data.corpNm}"/> 관리자 / ${data.ansFrstRegDttm}</strong>
									<c:out value="${data.ansContents}" escapeXml="false"/>
								</span>
							</dd>
						</c:if>
					</dl>
				</c:forEach>
			</form>
			
			<div class="pageNumber">
				<p class="list_pageing">
				<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" />
				</p>
			</div>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>