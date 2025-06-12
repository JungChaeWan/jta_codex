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

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_mypage.css'/>">

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<script type="text/javascript">

function fn_ChangePw(){
	if(isNull($("#pwd").val())){
		alert("<spring:message code='errors.required2' arguments='현재 비밀번호'/>");
		$("#pwd").focus();
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
	if($("#newPwd").val() == $("#pwd").val()){
		alert("<spring:message code='fail.user.passwordUpdate3' />");
		$("#newPwd").focus();
		return;
	}
	var parameters = "pwd=" + $("#pwd").val();
	parameters += "&newPwd=" + $("#newPwd").val();
	$.ajax({
		type:"post", 
		url:"<c:url value='/web/mypage/changePw.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.rtnVal == "1"){
				alert("<spring:message code='fail.user.passwordUpdate1'/>");
				$("#pwd").focus();
				return;
			}else if(data.rtnVal == "0"){
				//alert("<spring:message code='success.common.update1' arguments='새로운 비밀번호'/>");
				//location.href="<c:url value='/mw/main.do'/>";
				location.href="<c:url value='/mw/mypage/changePwComplet.do'/>";
			}
		},
		error:fn_AjaxError
	});
}

function fn_OnChangeNewPw(strPw){
	var bChkPw = true;
    var stringRegx = /[%&+]/gi;

    if(stringRegx.test(strPw) == true ){
        alert("특수문자%&+는 사용하실 수 없습니다.")
        $("#newPwd").val("");
        return;
    }

	if(strPw.length == 0 ){
		$("#pwCmtFail").show();
		$("#pwCmtOk").hide();
		$("#pwCmtFail").html("&nbsp;");
		return;
	}

	if(checkIsPwMix(strPw)){
		$("#pwCmtFail").hide();
		$("#pwCmtOk").show();
		//$("#pwCmtOk").html("사용가능");
		return;
	}else{
		$("#pwCmtFail").show();
		$("#pwCmtOk").hide();
		$("#pwCmtFail").html("사용불가");
		return;
	}
}
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="비밀번호 변경"/>
	</jsp:include>
</header>
<!-- 헤더 e -->
<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="sub-content">
		<!-- <h2>비밀번호 변경</h2> -->
		<div class="mypage">
			<div class="pw-wrap">
				<table class="pw-ct">
					<tbody>
						<tr>
							<th>현재 비밀번호</th>
							<td><input type="password" name="pwd" id="pwd" placeholder="현재 비밀번호"></td>
						</tr>
						<tr>
							<th>새 비밀번호</th>
							<td>
								<input type="password" name="newPwd" id="newPwd" placeholder="새 비밀번호" onkeyup="fn_OnChangeNewPw(this.value)">
								<p id='pwCmtFail' class='label1'>&nbsp;</p><p id='pwCmtOk' class='label2' style="display: none;">사용가능</p>
							</td>
						</tr>
						<tr>
							<th>새 비밀번호 확인</th>
							<td><input type="password" name="newPwd_re" id="newPwd_re" placeholder="새 비밀번호 확인"></td>
						</tr>
					</tbody>
				</table>

				<article class="info-wrap">
					<h6>안내</h6>
					<ul>
						<li>비밀번호는 영문, 숫자, 특수문자 조합의 8~20자리입니다.</li>
						<li>특수문자 %&+ 는 사용하실 수 없습니다.</li>
						<li>개인정보 보호를 위해 최소 3개월마다 비밀번호를 변경해 주세요. </li>
					</ul>
				</article>
				<p class="btn-list"><a href="javascript:fn_ChangePw()" class="btn22">확인</a></p>
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