<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
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
<jsp:include page="/mw/includeJs.do" flush="false"></jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_mypage.css'/>">	
<script type="text/javascript">
</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false"></jsp:include>

<script type="text/javascript">

function fn_Mod(){
	//입력 검사
	
	
	if(document.frm.subject.value.length==0){
		alert("제목을 입력 하세요.");
		document.frm.subject.focus();
		return;
	}
	
	if(document.frm.subject.value.length >= 255){
		alert("제목의 길이는 255자 이하 입니다.");
		document.frm.subject.focus();
		return;
	}
	
	//if($("#contents").val().length == 0){
	if(document.frm.contents.value.length==0){
		alert("내용을 입력 하세요.");
		document.frm.contents.focus();
		return;
	}
	//if($("#contents").val().length >= 500){
	if(document.frm.contents.value.length >= 500){
		alert("내용의 길이는 500자 이하 입니다.");
		document.frm.contents.focus();
		return;
	}
	
	document.frm.action = "<c:url value='/mw/mypage/otoinqUpdate.do'/>";
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

		<div class="board">
			<dl class="txt-box">
				<dt>1:1문의수정</dt>
				<dd>주제에 맞지않거나 음란/홍보/비방 등의 글은 사전 동의없이 삭제 가능합니다.</dd>
			</dl>
			<form name="frm" method="post" onSubmit="return false;">
				<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
                <input type="hidden" id=otoinqNum name="otoinqNum" value="${otoinq.otoinqNum}"/>
                <input type="hidden" id="corpId" name="corpId" value="${otoinq.corpId}"/>
                <input type="hidden" id="prdtNum" name="prdtNum" value="${otoinq.prdtNum}"/>
			
				<table class="write bt-none">
					<colgroup>
						<col width="20%">
						<col width="*">
					</colgroup>
					<tr>
						<th><label for="title">제목</label></th>
						<td class="full">
							<input type="text" id="title" id="subject" name="subject" maxlength="50" value="${otoinq.subject}">
						</td>
					</tr>
					<tr>
						<th><label for="con">내용</label></th>
						<td><textarea id="con" cols="45" rows="5" id="contents" name="contents" maxlength="500">${otoinq.contents}</textarea></td>
					</tr>
				</table>
				<p class="btn-list">
					<a href="#" onclick="fn_Mod()" class="btn btn1">저장</a> 
					<a href="javascript:history.back();" class="btn btn2">취소</a>
				</p>
				
			</form>
		</div>
	</div>

</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>
</body>
</html>
