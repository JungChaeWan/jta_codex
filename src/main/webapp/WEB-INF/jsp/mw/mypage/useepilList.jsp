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
	<jsp:param name="headTitle" value="이용후기 내역"/>
</jsp:include>

<script type="text/javascript">

/**
 * 조회 & 페이징
 */
function fn_Search(pageIndex){
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = "<c:url value='/web/mypage/useepilList.do'/>";
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
		<h2>이용후기 내역보기</h2>
	</div>
	<div class="sub-content">
		<div class="review-list">
			<c:if test="${fn:length(useepilList) == 0}">
				<dl>
					<dt>
						<strong>내역이 없습니다.</strong>
					</dt>
				</dl>
			</c:if>
 				
			<c:forEach var="data" items="${useepilList}" varStatus="status">
				<dl>
					<dt>
						<strong>[<c:out value="${data.subjectHeder}"/>] <c:out value="${data.subject}"/></strong>
						<span class="like">
							<c:if test="${data.gpa >= 1 }"><img src="<c:url value='/images/mw/sub_common/h_icon.png'/>" width="10" alt="좋아요"></c:if>
	                 		<c:if test="${data.gpa < 1 }"><img src="<c:url value='/images/mw/sub_common/h_icon2.png'/>" width="10" alt="좋아요"></c:if>
	                 		<c:if test="${data.gpa >= 2 }"><img src="<c:url value='/images/mw/sub_common/h_icon.png'/>" width="10" alt="좋아요"></c:if>
	                 		<c:if test="${data.gpa < 2 }"><img src="<c:url value='/images/mw/sub_common/h_icon2.png'/>" width="10" alt="좋아요"></c:if>
	                 		<c:if test="${data.gpa >= 3 }"><img src="<c:url value='/images/mw/sub_common/h_icon.png'/>" width="10" alt="좋아요"></c:if>
	                 		<c:if test="${data.gpa < 3 }"><img src="<c:url value='/images/mw/sub_common/h_icon2.png'/>" width="10" alt="좋아요"></c:if>
	                 		<c:if test="${data.gpa >= 4 }"><img src="<c:url value='/images/mw/sub_common/h_icon.png'/>" width="10" alt="좋아요"></c:if>
	                 		<c:if test="${data.gpa < 4 }"><img src="<c:url value='/images/mw/sub_common/h_icon2.png'/>" width="10" alt="좋아요"></c:if>
	                 		<c:if test="${data.gpa >= 5 }"><img src="<c:url value='/images/mw/sub_common/h_icon.png'/>" width="10" alt="좋아요"></c:if>
	                 		<c:if test="${data.gpa < 5 }"><img src="<c:url value='/images/mw/sub_common/h_icon2.png'/>" width="10" alt="좋아요"></c:if>
							<em>${data.gpa}/5</em>
						</span>
						<em>${data.frstRegDttm}</em>
						<a href="<c:url value='/mw/coustomer/viewUdateUseepil.do'/>?useEpilNum=${data.useEpilNum}" class="btn btn-reply">수정</a>
					</dt>
					<dd>
						<c:out value="${data.contents}" escapeXml="false"/>
						<dl>
							<!-- <dt><a href="#" class="btn btn-reply">답글보기 <img src="../../images/mw/sub_common/re_arrow.png" width="7" alt=""></a></dt> -->
							
							<c:forEach var="dataCmt" items="${data.cmtList}" varStatus="status">
								<ul class="re_comment">
	                                <li class="ic2"><img src="<c:url value='/images/web/icon/re2.png'/>" alt="re"></li>
	                                <li class="re">
	                                    <c:out value="${dataCmt.contents}" escapeXml="false"/>                                                     
	                                </li>
	                            </ul>
							</c:forEach>
						</dl>
					</dd>
				</dl>
			</c:forEach>

			<form name="frm" id="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
				<div class="pageNumber">
					<p class="list_pageing">
						<ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="fn_Search" />
					</p>
				</div>
			</form>
			
			<p>
				<a href="<c:url value='/mw/coustomer/viewInsertUseepil.do'/>" class="btn btn-submit">이용후기 작성</a>
			</p>
			<!--
			<dl>
				<dt>
					<strong>제주 아이리브 리조트 추천 추천 추천~</strong>
					<span class="like">
						<img src="../../images/mw/sub_common/h_icon.png" width="10" alt="">
						<img src="../../images/mw/sub_common/h_icon.png" width="10" alt="">
						<img src="../../images/mw/sub_common/h_icon.png" width="10" alt="">
						<img src="../../images/mw/sub_common/h_icon.png" width="10" alt="">
						<img src="../../images/mw/sub_common/h_icon2.png" width="10" alt="">
						<em>4/5</em>
					</span>
					<em>navnav**&nbsp;&nbsp;2015. 9. 18&nbsp;&nbsp;14:15:07</em>
				</dt>
				<dd class="hide">
					다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요. 다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요. 다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요.
					<dl>
						<dt><a href="#" class="btn btn-reply">답글보기 <img src="../../images/mw/sub_common/re_arrow.png" width="7" alt=""></a></dt>
						<dd>
							<em>navnav**&nbsp;&nbsp;2015. 9. 18&nbsp;&nbsp;14:15:07</em><br>
							다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요. 다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요. 다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요.
						</dd>
					</dl>
				</dd>
			</dl>
			<dl>
				<dt>
					<strong>제주 아이리브 리조트 추천 추천 추천~</strong>
					<span class="like">
						<img src="../../images/mw/sub_common/h_icon.png" width="10" alt="">
						<img src="../../images/mw/sub_common/h_icon.png" width="10" alt="">
						<img src="../../images/mw/sub_common/h_icon.png" width="10" alt="">
						<img src="../../images/mw/sub_common/h_icon.png" width="10" alt="">
						<img src="../../images/mw/sub_common/h_icon2.png" width="10" alt="">
						<em>4/5</em>
					</span>
					<em>navnav**&nbsp;&nbsp;2015. 9. 18&nbsp;&nbsp;14:15:07</em>
				</dt>
				<dd class="hide">
					다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요. 다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요. 다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요.
					<dl>
						<dt><a href="#" class="btn btn-reply">답글보기 <img src="../../images/mw/sub_common/re_arrow.png" width="7" alt=""></a></dt>
						<dd>
							<em>navnav**&nbsp;&nbsp;2015. 9. 18&nbsp;&nbsp;14:15:07</em><br>
							다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요. 다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요. 다른 사이트랑 가격은 같은데 조식이랑 맥주무한제공 패키치가 있어서 너무 좋았어요.
						</dd>
					</dl>
				</dd>
			</dl>
			 -->
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>