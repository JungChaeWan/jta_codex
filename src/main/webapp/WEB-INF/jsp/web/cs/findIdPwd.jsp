<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		    uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
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
		data:parameters,
		success:function(data){
			if(data.success == "Y") {
				$("#sUserNm").val($("#sUserNm1").val());
				$("#sTelNum").val($("#telNum").val());

				document.frm.action = "<c:url value='/web/findId.do'/>";
				document.frm.submit();
			} else {
				alert(JSON.stringify(data.failMsg));
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
                $("#sEmail").val($("#sEmail1").val());
                $("#sUserNm").val($("#sUserNm2").val());
				$("#sTelNum").val($("#telNum2").val());

				document.frm.action = "<c:url value='/web/findPwd.do'/>";
				document.frm.submit();
			} else {
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
            <span>아이디/비밀번호 찾기</span>
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" flush="false"></jsp:include>
    <!-- //quick banner -->
    <div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
            <!-- new contents -->
            <div class="user-idpw">
            	<form name="frm">
            		<input type="hidden" name="sUserNm" id="sUserNm">
            		<input type="hidden" name="sTelNum" id="sTelNum">
            		<input type="hidden" name="sEmail" id="sEmail">
            	</form>
                <div class="bgWrap2">
                    <div class="Fasten">
                        <div class="member-title">
                            <h2>아이디/비밀번호 찾기</h2>
                        </div>
                        <div class="idpw-ctWrap">
                            <!--아이디찾기-->
                            <div class="lArea">
                                <div class="bdWrap">
                                    <h3 class="title">아이디 찾기</h3>
                                    <div class="pdWrap">
                                        <table class="tb-id">
                                            <tr class="name">
                                                <th>이름</th>
                                                <td><input class="full" type="text" name="sUserNm1" id="sUserNm1"></td>
                                            </tr>
                                            <tr class="phone">
                                                <th>휴대폰번호</th>
                                                <td>
                                                    <input type="text" name="telNum" id="telNum" onkeyup="addHyphenToPhone(this);" />
                                                    <button onclick="javascript:fn_SendSms1();">인증요청</button>
                                                </td>
                                            </tr>
                                            <tr class="certification">
                                                <th>인증번호</th>
                                                <td><input class="full" type="text" name="certNumber1" id="certNumber1"></td>
                                            </tr>
                                            <tr class="memo">
                                                <th></th>
                                                <td>* 인증번호는 발송 후 30분내에서만 유효합니다</td>
                                            </tr>
                                        </table>
                                        <div class="smBT">
                                            <button class="comm-arrowBT comm-arrowBT3" type="submit" onclick="javascript:fn_Cert1();">아이디 찾기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--비밀번호찾기-->
                            <div class="rArea">
                                <div class="bdWrap">
                                    <h3 class="title">비밀번호 찾기</h3>
                                    <div class="pdWrap">
                                        <!--휴대폰입력폼-->
                                        <table class="tb-pw">
                                            <tr class="id">
                                                <th>아이디</th>
                                                <td><input class="full" type="text" name="sEmail1" id="sEmail1"></td>
                                            </tr>
                                            <tr class="name">
                                                <th>이름</th>
                                                <td><input class="full" type="text" name="sUserNm2" id="sUserNm2"></td>
                                            </tr>
                                            <tr class="phone">
                                                <th>휴대폰번호</th>
                                                <td>
                                                    <input type="text" name="telNum2" id="telNum2" onkeyup="addHyphenToPhone(this);"/>
                                                    <button onclick="javascript:fn_SendSms2();">인증요청</button>
                                                </td>
                                            </tr>
                                            <tr class="certification">
                                                <th>인증번호</th>
                                                <td><input class="full" type="text" name="certNumber2" id="certNumber2"></td>
                                            </tr>
                                            <tr class="memo">
                                                <th></th>
                                                <td>* 인증번호는 발송 후 30분내에서만 유효합니다</td>
                                            </tr>
                                        </table>
                                        <div class="smBT">
                                            <button class="comm-arrowBT comm-arrowBT3" type="submit" onclick="javascript:fn_Cert2();">비밀번호 찾기</button>
                                        </div>
                                    </div>
                                </div>
                            </div> <!--//rArea-->
                        </div> <!--//idpw-ctWrap-->
                    </div>
                </div>
            </div>
            <!-- //new contents -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>