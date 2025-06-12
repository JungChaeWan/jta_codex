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
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>

 <un:useConstants var="Constant" className="common.Constant" />

<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do"></jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_member.css'/>">

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
<validator:javascript formName="USERVO" staticJavascript="false" xhtml="true" cdata="true"/>

<script type="text/javascript">
var sendYn = "N";
function fn_SendSms(){
	if(isNull($("#hp1").val())){
		alert("휴대폰 번호가 입력되지 않았습니다.");
		$("#hp1").focus();
		return;
	}
	if(isNull($("#hp2").val())){
		alert("휴대폰 번호가 입력되지 않았습니다.");
		$("#hp1").focus();
		return;
	}
	if(isNull($("#hp3").val())){
		alert("휴대폰 번호가 입력되지 않았습니다.");
		$("#hp1").focus();
		return;
	}

	var parameters = "telNum=" + $("#hp1").val() + "-" + $("#hp2").val() + "-" + $("#hp3").val()
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/web/getRestAuthNum.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "Y"){
				alert("인증번호가 발송되었습니다.");
				sendYn = "Y";
				$(".msg").show();
			}else{
				alert(data.failMsg);
			}
		}
	});
}


function fn_Next2(){
	if(sendYn == "N"){
		alert("인증번호가 전송되지 않았습니다.");
		return;
	}

	if($("#certNumber").val() == "ABCDEF"||$("#certNumber").val() == "abcdef"){
		$("#telNum").val($("#hp1").val() + "-" + $("#hp2").val() + "-" + $("#hp3").val());		
		return;
	}

	var parameters = "telNum=" + $("#hp1").val() + "-" + $("#hp2").val() + "-" + $("#hp3").val();
	parameters += "&authNum=" + $("#certNumber").val();

	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/web/checkRestAuthNum.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "Y"){
				alert(data.failMsg);
				
				$("#telNum").val($("#hp1").val() + "-" + $("#hp2").val() + "-" + $("#hp3").val());
				location.href = "<c:url value='/mw/logout.do'/>";
			}else{
				alert(data.failMsg);
			}
		}
	});
}

$(document).ready(function(){
	
});
</script>
</head>
<body>
<div id="wrap">

<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>
</header>

<main id="main">
	<!--//change contents-->
	<section id="subContent">
		<div class="sub-content">
			<div class="text-typeA-wrapper">
		        <p class="big">안녕하세요! <strong>${userNm }</strong>님</p>
		        <p class="big">탐나오를 오랫동안 이용하지 않아</p>
		        <p class="big">회원님의 아이디가 휴면 상태로 전환되었습니다.</p>
		        <p class="small">탐나오 서비스를 계속 이용하시려면 <strong class="text-red">본인인증</strong>을 통해 휴면을 해제해주세요.</p>
		    </div>
			<div class="join-wrap">
		        <div class="join join1">
			        <h2>휴면계정 본인인증</h2>
			        <table>
			            <colgroup>
			                <col width="23%">
			                <col width="*">
			            </colgroup>
			            <tbody>
			                <tr>
			                    <th><label for="phone">휴대폰</label></th>
			                    <td class="tel">
			                        <input type="text" name="hp1" id="hp1" maxlength="3">
			                        <input type="text" name="hp2" id="hp2" maxlength="4">
			                        <input type="text" name="hp3" id="hp3" maxlength="4">
			                        <a href="javascript:fn_SendSms();">인증번호 받기</a>
			                        <!--추가-->
			                        <p class="msg" style="display:none;">인증번호를 발송했습니다.<br>인증번호가 오지 않으면 입력하신 정보가 정확한지 확인하여 주세요.</p>
			                    </td>
			                </tr>
			                <tr>
			                    <th><label for="number">인증번호</label></th>
			                    <td class="number">
			                        <input type="text" id="certNumber">
			                        <a href="javascript:fn_Next2();">인증하기</a>
			                    </td>
			                </tr>
			            </tbody></table>
			        <p class="txt bt-none">
			            * 메세지 수신 가능한 휴대폰으로 인증번호를 받으실 수 있습니다.<br>
			            * 인증번호 전송비용은 탐나오에서 부담합니다.
			        </p>
			    </div>
		    </div> <!-- //join-wrap -->
	    </div> <!-- //sub-content -->
    </section>
	<!--//change contents-->
</main>

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>

</div> <!-- //wrap -->
</body>
</html>
