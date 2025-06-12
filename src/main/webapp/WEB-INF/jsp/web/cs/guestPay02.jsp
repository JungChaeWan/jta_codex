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
	
	if(isNull($("#userNm").val())){
		alert("이름이 입력되지 않았습니다.");
		$("#userNm").focus();
		return;
	}

    if(strLengthCheck($("#userNm").val()) > 40 ) {
        alert("이름은 12자를 초과하실 수 없습니다.");
        $("#userNm").focus();
        return;
    }
	
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
		url:"<c:url value='/web/getAuthNumGuest.ajax'/>",
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
	parameters += "&userNm=" + $("#userNm").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/web/checkAuthNumGuest.ajax'/>",
		data:parameters ,
		success:function(data){
			if(data.success == "Y"){
				$("#telNum").val($("#hp1").val() + "-" + $("#hp2").val() + "-" + $("#hp3").val());
				document.frm.action = "/web/order01.do?mode=${param.mode}&cartSn=${param.cartSn}&rsvDiv=${param.rsvDiv}";
				document.frm.submit();
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
    <div class="mapLocation"> <!--index page에서는 삭제-->
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>비회원 구매</span>
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" flush="false"></jsp:include>
    <!-- //quick banner -->
    <div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
            <!-- new contents -->
            <div class="sign-up">
                    <div class="bgWrap2">
                        <div class="Fasten">
                            <div class="member-title">
                                <h2>비회원 구매</h2>
                                <ul class="info">
                                	<!-- 
                                    <li><img src="<c:url value='/images/web/sign/info1.jpg'/>" alt="약관동의"></li>
                                    <li><img src="<c:url value='/images/web/sign/info2_on.jpg'/>" alt="본인인증"></li>
                                    <li><img src="<c:url value='/images/web/sign/info3.jpg'/>" alt="회원정보입력"></li>
                                    <li><img src="<c:url value='/images/web/sign/info4.jpg'/>" alt="가입완료"></li>
                                     -->
                                </ul>
                            </div>
                            
                            <div class="member-ctWrap">
                            	<form name="frm" method="post" onSubmit="return false;">
                            		<input type="hidden" name="telNum" id="telNum" />
                            	</form>
                                <div class="lArea"><img src="<c:url value='/images/web/sign/icon1.jpg'/>" alt="휴대폰인증"></div>
                                <div class="rArea">
                                    <div class="check">
                                        <p class="cite">
                                        	<span class="title">이름</span>
	                                        <input type="text" name="userNm" id="userNm" style="width: 309px">
                                        </p>
                                        <p class="phone">
                                            <span class="title">휴대폰</span>
                                            <input type="text" name="hp1" id="hp1" maxlength="3" onkeydown="javascript:fn_checkNumber();" />
                                            <input type="text" name="hp2" id="hp2" maxlength="4" onkeydown="javascript:fn_checkNumber();" />
                                            <input type="text" name="hp3" id="hp3" maxlength="4" onkeydown="javascript:fn_checkNumber();" />
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
                </div> <!-- //sign-up -->
            <!-- //new contents -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>