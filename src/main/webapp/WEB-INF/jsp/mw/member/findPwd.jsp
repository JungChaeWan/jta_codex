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
	<jsp:include page="/mw/includeJs.do"></jsp:include>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_member.css'/>">
<script type="text/javascript">

function fn_ChangePw(){

    var stringRegx = /[%&+]/gi;

    if(stringRegx.test($("#newPwd").val()) == true ){
        alert("특수문자 %&+ 는 사용하실 수 없습니다.")
        $("#newPwd").val("");
        return;
    }

	if($("#newPwd").val() != $("#newPwd_re").val()){
		alert("<spring:message code='fail.user.passwordUpdate2'/>");
		$("#newPwd_re").focus();
		return;
	}
	if(!checkIsPwMix($("#newPwd").val())){
		alert("<spring:message code='fail.common.login.password1'/>");
		$("#newPwd").focus();
		return;
	}
	var parameters = "newPwd=" + $("#newPwd").val();
	parameters += "&userId=" + $("#userId").val();
	
	$.ajax({
		type:"post", 
		url:"<c:url value='/web/changePwd.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("<spring:message code='success.common.update1' arguments='새로운 비밀번호'/>");
			location.href="<c:url value='/mw/main.do'/>";
		},
		error:fn_AjaxError
	});
}

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
	<div class="sub-content">
		<div class="sub-content_findpwd">
			<div class="join">
				<h4 class="comm-title1">비밀번호 변경</h4>
				<div class="bgWrap">
					<h5 class="info">본인 확인이 완료되었습니다</h5>
					<table class="tb-pw2">
						<tbody>
							<input type="hidden" name="userId" id="userId" value="${userVO.userId}">
							<tr class="password">
								<th>새 비밀번호</th>
								<td><input class="full" type="password" name="newPwd" id="newPwd" placeholder="영문, 숫자, 특수문자 조합의 8~20자리입니다."></td>
							</tr>
							<tr class="password2">
								<th>새 비밀번호 확인</th>
								<td><input class="full" type="password" name="newPwd_re" id="newPwd_re" placeholder="확인을 위해 한번 더 입력해주세요"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		<p class="btn-list form-pwd-actions">
			<a href="javascript:fn_ChangePw();" class="btn btn1">비밀번호 변경</a>
		</p>

	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>
