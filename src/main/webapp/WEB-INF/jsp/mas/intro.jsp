<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<head><meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>탐나오 입점업체 관리자시스템</title>
<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/intro.css'/>" />
<script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/jquery.cookie.js'/>" ></script>
<script type="text/javascript">

/** http -> https 변환*/
if(document.location.protocol == 'http:') {
	var chkInclude = document.location.host;

	if(chkInclude.indexOf("localhost") < 0 && chkInclude.indexOf("dev") < 0 && chkInclude.indexOf("218.157.128.119") < 0 && chkInclude.indexOf("tamnao.iptime.org") < 0 ) {
		document.location.href = document.location.href.replace("http:", "https:");
	}
}
/** 서브도메인없을경우 www 변환*/
var url1 = 'tamnao.com';
var url2 = 'www.tamnao.com';
if( url1 == document.domain ) document.location.href = document.URL.replace(url1, url2);

var getContextPath = "${pageContext.request.contextPath}";

/**
 * 로그인
 */
function fn_login(){
	if($("#corpId").val() == ""){
		alert("<spring:message code='errors.required2' arguments='상점아이디'/>");
		$("#corpId").focus();
		return;
	}
	/* if($("#email").val() == ""){
		alert("<spring:message code='errors.required2' arguments='이메일'/>");
		$("#email").focus();
		return;
	} */
	if($("#pwd").val() == ""){
		alert("<spring:message code='errors.required2' arguments='비밀번호'/>");
		$("#pwd").focus();
		return;
	}
	
	fn_saveID();
	
	document.frm.action = getContextPath + "/mas/actionMasLogin.do";
	document.frm.submit();
}

/**
 * 아이디 저장 기능
 */
function fn_saveID(){	
	if($("#id_save").is(":checked")){
		$.cookie('masCorpID', $("#corpId").val(), { expires: 7 });
	}else{
		$.cookie('masCorpID', "", { expires: -1 });
	}	
}


$(document).ready(function(){
	if("${failLogin}" == "Y"){
		alert('<spring:message code="fail.common.login"/>');
	}else if("${failLogin}" == "1"){
		alert("아이디를 입력해주세요.");
		$("#corpId").focus();
	}else if("${failLogin}" == "2"){
		alert("비밀번호를 입력해주세요.");
		$("#pwd").focus();
	}else{
		if($.cookie('masCorpID')){
			$("#corpId").val($.cookie('masCorpID'));
			$("#id_save").prop("checked", true);
			$("#pwd").focus();
		}else{
			$("#corpId").focus();
		}
	}
});
</script>

</head>
<body>
<div id="intro_wrapper">
	<div class="intro">
	    <h1><img src="<c:url value='/images/mas/intro/intro_img01.gif'/>" alt="탐나오 입점업체 관리자 시스템 언제 어디서나 편리하고 효율적으로 업무를 처리할 수 있는 공간입니다." /></h1>
	    <form id="frm" name="frm" onSubmit="return false;" method="post">
	    <div class="login agent"> <!--agent를 추가하면 입력폼 3줄에 맞게 적용됨-->
	        <ul>
	            <li>
	                <p>
	                    <label for="corpId">상점 아이디</label>
	                    <input type="text" name="corpId" id="corpId" value="" title="상점 아이디를 입력하세요." /> 
	                </p>
	                <!-- <p>
	                    <label for="email">E-mail</label>
	                    <input type="text" name="email" id="email" value="" title="이메일을 입력하세요." />
	                </p> -->
	                <p>
	                    <label for="pwd">비밀번호</label>
	                    <input type="password" name="pwd" id="pwd" value="" title="비밀번호를 입력하세요." onkeydown="javascript:if(event.keyCode==13){fn_login();}" />
	                </p>
	            </li>
	            <li class="idsave"> <span> 
	                <input type="checkbox" id="id_save" name="id_save" />
	                <label for="id_save">아이디 저장</label>
	            </span></li>
	            <li class="btn"><a href="javascript:fn_login();"><img src="<c:url value='/images/oss/intro/login_btn.gif'/>" alt="로그인" /></a></li>
	        </ul>
	    </div>
	    </form>
	</div>
</div>	
<div id="footer_wrapper">
    <p>CopyRight ⓒ 2015 탐나오. All Rights Reserved.</p>
</div>
</body>
</html>