<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />

<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do"></jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_member.css'/>">	
<script type="text/javascript">

function fn_ChangeTab(tab) {
	if(tab == 1) {
		$("#sub2").hide();
		$("#sub1").show();
	} else {
		$("#sub1").hide();
		$("#sub2").show();
	}
	
}

var sendYn1 = "N";
var sendYn2 = "N";

function fn_SendSms1() {
	if(isNull($("#sUserNm1").val())) {
		alert("이름이 입력되지 않았습니다.");
		$("#sUserNm1").focus();
		return;
	}
    var phoneNum = $("#telNum").val();

    if(checkIsHP(phoneNum)) {
        $("#telNum").val(phoneNum);

        var parameters = "sTelNum=" + phoneNum;
        parameters += "&sUserNm=" + $("#sUserNm1").val();

        $.ajax({
            type:"post",
            dataType:"json",
            url:"<c:url value='/web/getAuthNumId.ajax'/>",
            data:parameters,
            success:function(data){
                if(data.success == "Y") {
                    alert("<spring:message code='success.send.certNum' />");
                    sendYn1 = "Y";
                } else {
                    alert(data.failMsg);
                }
            }
        });
    } else {
        alert("<spring:message code='errors.phone' />");
    }
}

function fn_Cert1() {
	if(sendYn1 == "N") {
        alert("<spring:message code='info.phone.cert'/>");
		return;
	}
	var parameters = "telNum=" + $("#telNum").val();
	parameters += "&authNum=" + $("#certNumber1").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/web/checkAuthNum.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "Y") {
				$("#sUserNm").val($("#sUserNm1").val());
				$("#sTelNum").val($("#telNum").val());
				document.frm.action = "<c:url value='/mw/findId.do'/>";
				document.frm.submit();
			} else {
				alert(data.failMsg);
			}
		}
	});

}

function fn_SendSms2() {
	if(isNull($("#sEmail1").val())) {
		alert("이메일이 입력되지 않았습니다.");
		$("#sEmail1").focus();
		return;
	}
	if(isNull($("#sUserNm2").val())) {
		alert("이름이 입력되지 않았습니다.");
		$("#sUserNm2").focus();
		return;
	}
    var phoneNum = $("#telNum2").val();

    if(checkIsHP(phoneNum)) {
        $("#telNum2").val(phoneNum);

        var parameters = "sTelNum=" + $("#telNum2").val();
        parameters += "&sUserNm=" + $("#sUserNm2").val();
        parameters += "&sEmail=" + $("#sEmail1").val();

        $.ajax({
            type:"post",
            dataType:"json",
            url:"<c:url value='/web/getAuthNumPw.ajax'/>",
            data:parameters,
            success:function(data){
                if(data.success == "Y") {
                    alert("<spring:message code='success.send.certNum' />");
                    sendYn2 = "Y";
                } else {
                    alert(data.failMsg);
                }
            }
        });
    } else {
        alert("<spring:message code='errors.phone' />");
    }
}

function fn_Cert2() {
	if(sendYn2 == "N") {
        alert("<spring:message code='info.phone.cert'/>");
		return;
	}
    var parameters = "sTelNum=" + $("#telNum2").val();
	parameters += "&sUserNm=" + $("#sUserNm2").val();
	parameters += "&sEmail=" + $("#sEmail1").val();
	parameters += "&authNum=" + $("#certNumber2").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/web/checkAuthNumPw.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.success == "Y") {
				$("#sUserNm").val($("#sUserNm2").val());
				$("#sEmail").val($("#sEmail1").val());
                $("#sTelNum").val($("#telNum2").val());

				document.frm.action = "<c:url value='/mw/findPwd.do'/>";
				document.frm.submit();
			} else {
				alert(data.failMsg);
			}
		}
	});
}

$(document).ready(function(){
	fn_ChangeTab(${showTab});
});

</script>
</head>
<body class="login-body">
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
	<form name="frm">
   		<input type="hidden" name="sUserNm" id="sUserNm">
   		<input type="hidden" name="sTelNum" id="sTelNum">
   		<input type="hidden" name="sEmail" id="sEmail">
   	</form>
	<div class="sub-content2" id="sub1">
		<div class="join">
			<p class="sub-tabs">
				<a class="active-on">아이디 찾기</a>
				<a class="active-off" href="javascript:fn_ChangeTab(2);">비밀번호 찾기</a>
			</p>
			<p></p>
			<p class="find-txt"> 가입 당시 입력한 휴대폰 번호를 통해 아이디를 찾을 수 있습니다.</p>
			<table>
				<colgroup>
					<col width="23%">
					<col width="*">
				</colgroup>
				<tr>
					<td class="full">
						<input type="text" id="sUserNm1" maxlength="20" placeholder="이름">
					</td>
				</tr>
				<tr>
					<td class="tel">
						<input type="tel" name="telNum" id="telNum" onkeyup="addHyphenToPhone(this);" placeholder="휴대폰 번호"/>
						<a href="javascript:fn_SendSms1();">인증</a>
					</td>
				</tr>
				<tr>
					<td class="full">
						<input type="number" id="certNumber1" placeholder="인증 번호">
						<em>* 인증번호는 발송 후 30분내에서만 유효합니다.</em>
					</td>
				</tr>
			</table>
		</div>
		<p class="btn-list">
			<a href="#" class="btn btn1" onclick="javascript:fn_Cert1();">아이디 찾기</a>
		</p>
	</div>
	<div class="sub-content2" id="sub2" style="display:none;">
		<div class="join">
			<p class="sub-tabs">
				<a class="active-off" href="javascript:fn_ChangeTab(1);">아이디 찾기</a>
				<a class="active-on">비밀번호 찾기</a>
			</p>
			<p></p>
			<p class="find-txt"> 가입 당시 입력한 휴대폰 번호를 통해 비밀번호를 찾을 수 있습니다.</p>
			<table>
				<colgroup>
					<col width="23%">
					<col width="*">
				</colgroup>
				<tr>
					<td class="full">
						<input type="text" id="sUserNm2" placeholder="이름">
					</td>
				</tr>
				<tr>
					<td class="full">
						<input type="text" id="sEmail1" placeholder="아이디(이메일)">
					</td>
				</tr>
				<tr>
					<td class="tel">
						<input type="tel" name="telNum2" id="telNum2" onkeyup="addHyphenToPhone(this);" placeholder="휴대폰 번호" />
						<a href="javascript:fn_SendSms2();">인증</a>
					</td>
				</tr>
				<tr>
					<td class="full">
						<input type="number" id="certNumber2" placeholder="인증 번호">
						<em>* 인증번호는 발송 후 30분내에서만 유효합니다.</em>
					</td>
				</tr>
			</table>
		</div>
		<p class="btn-list">
			<a href="#" class="btn btn1" onclick="javascript:fn_Cert2();">비밀번호 찾기</a>
		</p>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>
