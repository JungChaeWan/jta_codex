<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

 <un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>



<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


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
	/* if($("input:radio[name=motion]:checked").val() != "Y"){
		alert("본인확인 정보수집을 동의하셔야 합니다.");
		return;
	} */

	var parameters = "telNum=" + $("#hp1").val() + "-" + $("#hp2").val() + "-" + $("#hp3").val();
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

function fn_Next(){
	if(sendYn == "N"){
		alert("인증번호가 전송되지 않았습니다.");
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
                location.href = "<c:url value='/web/logout.do'/>";
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
	<header id="header">
		<jsp:include page="/web/head.do" flush="false"></jsp:include>
	</header>

	<main id="main">
        <div class="mapLocation">
		    <div class="inner">
		        <span>홈</span> <span class="gt">&gt;</span>
		        <span>휴면계정 본인인증</span>
		    </div>
		</div>
		
		<div class="subContainer">
		    <div class="subHead"></div>
		    <div class="subContents">
		
		        <!-- Change Contents -->
		        <div class="sign-up">
			        <div class="bgWrap2">
			            <div class="Fasten">
			                <div class="member-title">
			                    <h2>휴면계정 본인인증</h2>
			                </div>
			                <div class="text-typeA-wrapper">
						        <p class="big">안녕하세요! <strong>${userNm }</strong>님</p>
						        <p class="big">탐나오를 오랫동안 이용하지 않아</p>
						        <p class="big">회원님의 아이디가 휴면 상태로 전환되었습니다.</p>
						        <p class="small">탐나오 서비스를 계속 이용하시려면 <strong class="text-red">본인인증</strong>을 통해 휴면을 해제해주세요.</p>
						    </div>
			                <div class="member-ctWrap">
			                    <form name="frm" method="post" onsubmit="return false;">
			                        <input type="hidden" name="telNum" id="telNum">
			                    </form>
			                    <div class="lArea"><img src="/images/web/sign/icon1.jpg" alt="휴대폰인증"></div>
			                    <div class="rArea">
			                        <div class="check">
			                            <p class="agree">
			                                <span class="title">휴대폰 본인인증</span>
			                                <!--<input id="agree1" type="radio" name="motion" value="Y"><label for="agree1">동의함</label>
			                                <input id="agree2" type="radio" name="motion" value="N"><label for="agree2">동의안함</label>
			                                <a href="" class="viewBT">전문보기</a>-->
			                            </p>
			                            <p class="phone">
			                                <span class="title">휴대폰</span>
			                                <input type="text" name="hp1" id="hp1" maxlength="3" onkeydown="javascript:fn_checkNumber();">
			                                <input type="text" name="hp2" id="hp2" maxlength="4" onkeydown="javascript:fn_checkNumber();">
			                                <input type="text" name="hp3" id="hp3" maxlength="4" onkeydown="javascript:fn_checkNumber();">
			                                <a href="javascript:fn_SendSms();" class="mcBT">인증</a>
			                            </p>
			                            <p class="msg" style="display:none;">인증번호를 발송했습니다.<br>인증번호가 오지 않으면 입력하신 정보가 정확한지 확인하여 주세요.</p>
			                            <p class="cite">
			                                <span class="title">인증번호</span>
			                                <input id="certNumber" type="text">
			                                <a href="javascript:fn_Next();" class="mcBT">확인</a>
			                            </p>
			                        </div>
			                        <ul class="info">
			                            <li>
			                                메시지 수신 가능한 휴대폰으로 인증번호를 받으실 수 있습니다.<br>
			                                인증번호 전송비용은 탐나오에서 부담합니다.
			                            </li>
			                        </ul>
			                    </div>
			                </div> <!--//member-ctWrap-->
			            </div>
			        </div>
			    </div> <!--//sign-up-->
		        <!-- //Change Contents -->
		
		    </div> <!-- //subContents -->
		</div> <!-- //subContainer -->	
	</main>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>