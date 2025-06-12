<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<meta name="robots" content="noindex>
<jsp:include page="/mw/includeJs.do" flush="false">
	<jsp:param name="title" value="${notice.subject}"/>
    <jsp:param name="description" value="제주도 항공권, 숙박, 렌터카, 관광지 여행상품 관련 공지사항. 제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영"/>
    <jsp:param name="keywords" value="실시간 항공,숙박,렌터카,관광지,맛집,여행사,레저,체험,특산기념품"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<%--
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_center.css'/>">
--%>	
<script type="text/javascript">

	function fn_Udt(){
		if('${authModYn}'!='Y'){
			alert("권한이 없습니다.");
			return;
		}
		
		document.frm.action = "<c:url value='/mw/bbs/bbsModView.do'/>";
		document.frm.submit();
	}
	
	function fn_Del(){
		
		if('${nBBSAuthDel}'=='N'){
			alert('권한이 없습니다.');	
			return;	
		}
			
		if('${notice.cmtCnt}'!='0'){
			alert('댓글이 있어서 삭제할 수 없습니다.');
			return;	
		}
		
		if(confirm("게시글은 물론 관련 정보들도 같이 삭제됩니다.\n게시글을 삭제 하시겠습니까?")){
			document.frm.hrkNoticeNum.value = "";
			document.frm.ansNum.value = "";
			document.frm.ansSn.value = "";
			document.frm.action = "<c:url value='/mw/bbs/bbsDel.do'/>";
			document.frm.submit();
		}
	}
	
	$(document).ready(function(){
		if('${authDtlYn}'!='Y'){
			alert("권한이 없습니다.");
			location.href = "<c:url value='/mw/bbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}"
		}
	});
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
<jsp:include page="/mw/head.do">
	<jsp:param name="headTitle" value="공지사항"/>
</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="menu-bar">
		<p class="btn-prev"><img src="/images/mw/common/btn_prev.png" width="20" alt="이전페이지"></p>
		<h2>공지사항</h2>
	</div>

	<div class="sub-content">
		<div class="board">
			<div class="view">
				<div class="tit">
					<strong><c:out value="${notice.subject}"/></strong><br>
					<em><c:out value="${notice.frstRegDttm}"/></em>
				</div>
				<div class="text">
					<c:forEach var="data" items="${notiImgList}" varStatus="status">
                    	<img src="${data.savePath}${data.saveFileNm}.${data.ext}" alt="">
                    </c:forEach>
                    <c:out value='${notice.contents}' escapeXml='false' />
				</div>
			</div>
			
			<c:if test="${fn:length(notiFileList) != 0}">
				<div class="view file">
					<c:forEach var="data" items="${notiFileList}" varStatus="status">
						(붙임${status.index+1 })<c:out value="${data.realFileNm }"/><br/>
					</c:forEach>
						※첨부파일은 PC에서 다운로드 할 수 있습니다.
				</div>
			</c:if>
			
			<p class="btn-full">
				<a href="<c:url value='/mw/bbs/bbsList.do'/>?bbsNum=${notice.bbsNum}&pageIndex=${searchVO.pageIndex}&sKeyOpt=${searchVO.sKeyOpt}&sKey=${searchVO.sKey}" class="btn btn-full">목록 보기</a>
			</p>
			
			<p class="editBT">
				<c:if test="${authModYn == 'Y' || (isLogin=='Y' && notice.userId == userInfo.userId)}">
					<a href="javascript:fn_Udt()" class="btn btn-reply">수정</a>
				</c:if>
				<c:if test="${authDelYn == 'Y' || (isLogin=='Y' && notice.userId == userInfo.userId)}">
					<a href="javascript:fn_Del()" class="btn btn-reply">삭제</a>
				</c:if>
			</p>
		</div>
		
		<form name="frm" id="frm" method="post" onSubmit="return false;">
			<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}"/>
			<input type="hidden" name="sKey" value="<c:out value='${searchVO.sKey}'/>"/>
			<input type="hidden" name="sKeyOpt" value="<c:out value='${searchVO.sKeyOpt}'/>"/>
			<input type="hidden" name="bbsNum" id="bbsNum" value="<c:out value='${notice.bbsNum}'/>"/>
			<input type="hidden" name="noticeNum" id="noticeNum" value="<c:out value='${notice.noticeNum}'/>"/>
			<input type="hidden" name="hrkNoticeNum" value="${notice.hrkNoticeNum}"/>
			<input type="hidden" name="ansNum" value="${notice.ansNum}"/>
			<input type="hidden" name="ansSn" value="${notice.ansSn}"/>
			<input type="hidden" name="fileNum" id="fileNum" value=""/>
		</form>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 푸터 e -->
</div>
</body>
</html>