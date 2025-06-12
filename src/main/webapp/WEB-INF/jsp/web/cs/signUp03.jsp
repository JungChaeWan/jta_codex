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

<jsp:include page="/web/includeJs.do" />
<script type="text/javascript" src="<c:url value='/js/validate.js'/>"></script>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<script type="text/javascript">
var emailChk = "N";
var telCertYn = false;

/**
 * EMAIL 중복체크
 */
function fn_EmailDuplicationChk() {
    if(isNull($("#email_id").val()) || isNull($("#email_host").val())) {
        alert("<spring:message code='errors.required2' arguments='이메일'/>");

        $("#email_id").focus();
        return;
    }
    var email = $("#email_id").val() + "@" + $("#email_host").val();

    if(!chekIsEmail2(email)) {
        alert(email +"은 유효하지 않은 이메일 주소입니다.");

        $("#email_id").focus();
        return;
    }
	var parameters = "email=" + email;

	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/emailDuplication.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.chk == "N"){
                alert('<spring:message code="info.email.notExist"/>');

                $("#email").val(email);
                emailChk = "Y";
			}else{
			    if(${!empty user.snsDiv}) {
                    alert('<spring:message code="info.sns.link.user"/>');

                    $("#userId").val(data.userId);

                    fn_LinkUserSns();
                } else {
                    alert('<spring:message code="info.email.exist"/>');

                    emailChk = "N";
                }
			}
		}
	});
}

/**
 * 이메일 변경시 중복체크 해제
 */
function fn_EmailOnchange() {
	emailChk = "N";
}

//기존 가입자의 간편가입 연동
function fn_LinkUserSns() {
    document.USERVO.action = "<c:url value='/web/insertUserSns.do' />";
    document.USERVO.submit();
}

var userId;
// 휴대폰인증
function fn_SendSms() {
    var phoneNum = $("#telNum").val();

    if(checkIsHP(phoneNum)) {
        var parameters = "telNum=" + phoneNum;
        parameters += "&snsDiv=${user.snsDiv}";

        $.ajax({
            type:"post",
            dataType:"json",
            url:"<c:url value='/web/getAuthNum.ajax'/>",
            data:parameters,
            success:function(data){
                if(data.success == "Y") {
                    alert('<spring:message code="success.send.certNum"/>');

                    userId = data.userId;
                    $("#userId").val(userId);
                    $("#telNum").val(phoneNum);
                    $(".msg").show();
                    $(".cert").show();
                } else {
                    alert(data.failMsg);
                }
            }
        });
    } else {
        alert("<spring:message code='errors.phone'/>");
    }
}

//인증번호 체크
function fn_Cert() {
    var parameters = "telNum=" + $("#telNum").val();
    parameters += "&authNum=" + $("#certNumber").val();

    $.ajax({
        type:"post",
        dataType:"json",
        url:"<c:url value='/web/checkAuthNum.ajax'/>",
        data:parameters,
        success:function(data){
            if(data.success == "Y") {
                if(isNull(userId)) {
                    alert('<spring:message code="success.phone.cert"/>');

                    $("#telNum").attr("readonly", true);
                    $("#btnSendSms").hide();
                    $(".msg").hide();
                    $(".cert").hide();
                    telCertYn = true;
                } else {
                    alert("<spring:message code='info.sns.link.user'/>");

                    fn_LinkUserSns();
                }
            } else {
                alert(data.failMsg);
            }
        }
    });
}

function fn_SignUp() {
    if(doubleSubmitFlag) {
        return;
    }

    //공통 validate
    var reg_hanengnum = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/;
    if (!reg_hanengnum.test($("#userNm").val())){
        alert("이름은 한글/영문/숫자만 입력 가능합니다.");
        $("#userNm").focus();
        return;
    }
    if(!validator({required:true,byte:40},"userNm", "이름")){return false;};

    //일반회원가입 validate
	if(${empty user.snsDiv}) {

        if(!validator({required:true,min:1, max:30},"email_id", "이메일")){return false;};
        if(!validator({required:true,min:1, max:20},"email_host", "이메일")){return false;};

        if(emailChk == "N") {
            alert('<spring:message code="info.email.duplication"/>');
            $("#email").focus();
            return;
        }
        if($("#pwd").val() != $("#pwd_re").val()) {
            alert("<spring:message code='fail.user.passwordUpdate2'/>");
            $("#pwd_re").focus();
            return;
        }
        if(!checkIsPwMix($("#pwd").val()) && $("#snsDiv").val() == "") {
            alert("<spring:message code='fail.common.login.password1'/>");
            $("#pwd").focus();
            return;
        }
    //간편로그인 validate
    } else {
	    if(${empty user.email}) {
            if(emailChk == "N") {
                alert('<spring:message code="info.email.duplication"/>');
                $("#email").focus();
                return;
            }
        }
    }
    if(!telCertYn) {
        alert("<spring:message code='info.phone.cert'/>");
        $("#telNum").focus();
        return;
    }
    doubleSubmitCheck();

	document.USERVO.action = "<c:url value='/web/insertUser.do' />";
	document.USERVO.submit();
}

function fn_OnChangeNewPw(strPw) {
    var stringRegx = /[%&+]/gi;

    if(stringRegx.test(strPw)) {
        alert("특수문자%&+는 사용하실 수 없습니다.")
        $("#pwd").val("");
        return;
    }

	if(strPw.length == 0) {
		$("#pwCmtFail").show();
		$("#pwCmtOk").hide();
		$("#pwCmtFail").html("&nbsp;");
		return;
	}

	if(checkIsPwMix(strPw)) {
		$("#pwCmtFail").hide();
		$("#pwCmtOk").show();
		//$("#pwCmtOk").html("사용가능");
		return;
	} else {
		$("#pwCmtFail").show();
		$("#pwCmtOk").hide();
		$("#pwCmtFail").html("(사용불가)");
		return;
	}
}

/* 중복 SUBMIT 방지 */
var doubleSubmitFlag = false;

function doubleSubmitCheck() {
    if(doubleSubmitFlag) {
        return doubleSubmitFlag;
    } else {
        doubleSubmitFlag = true;
        return false;
    }
}

$(document).ready(function(){
	// 이메일 주소 변경에 따른 제어
	$("select[name=email_host_s]").change(function(){
		if($("select[name=email_host_s]").val()=="etc") {
			$("input[name=email_host]").removeAttr("readonly");
			$("input[name=email_host]").val("");
		} else {
			$("input[name=email_host]").val($("select[name=email_host_s]").val());
			$("input[name=email_host]").attr("readonly", true);
		}
		emailChk = "N";
	});
});

</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
    <div class="mapLocation"> <!-- index page에서는 삭제 -->
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>회원가입</span>
            <!-- <span>실시간 숙박</span> <span class="gt">&gt;</span>
            <span>숙박상세</span> -->
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" />
    <!-- //quick banner -->
    <div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
            <!-- new contents -->
            <div class="sign-up3">
                <div class="bgWrap2">
                    <div class="Fasten">
                        <div class="member-title">
                            <h2>회원가입</h2>
                            <%--<ul class="info">--%>
                                <%--<li><img src="<c:url value='/images/web/sign/info1.jpg'/>" alt="약관동의"></li>--%>
                                <%--<li><img src="<c:url value='/images/web/sign/info2.jpg'/>" alt="본인인증"></li>--%>
                                <%--<li><img src="<c:url value='/images/web/sign/info3_on.jpg'/>" alt="회원정보입력"></li>--%>
                                <%--<li><img src="<c:url value='/images/web/sign/info4.jpg'/>" alt="가입완료"></li>--%>
                            <%--</ul>--%>
                        </div>
                        <div class="member-ctWrap">
                            <form:form commandName="USERVO" name="USERVO" method="post">
                                <input type="hidden" name="snsDiv" id="snsDiv" value="${user.snsDiv}" />
                                <input type="hidden" name="loginKey" id="loginKey" value="${user.loginKey}" />
                                <input type="hidden" name="userId" id="userId" />
                                <input type="hidden" name="email" id="email" value="${user.email}"/>
                                <input type="hidden" name="emailRcvAgrYn" id="emailRcvAgrYn" value="Y" />
                                <input type="hidden" name="smsRcvAgrYn" id="smsRcvAgrYn" value="Y" />
                                <input type="hidden" name="marketingRcvAgrYn" id="marketingRcvAgrYn" value="${user.marketingRcvAgrYn}" />

                                <div class="caption-check">
                                    <strong class="necessary">*</strong> 필수 입력입니다.
                                </div>
                                <table class="commRow">
                                    <tr>
                                        <th>아이디 <span>(이메일)</span> <strong class="necessary">*</strong></th>
                                        <td>
                                            <c:if test="${empty user.email}">
                                                <input type="text" name="email_id" id="email_id" class="mgR commWidth" onchange="fn_EmailOnchange()" />
                                                <span>@</span>
                                                <input type="text" name="email_host" id="email_host" class="mgL commWidth" onchange="fn_EmailOnchange()" />
                                                <select class="width100" name="email_host_s" class="mgL commWidth" id="email_host_s" title="E-mail 호스트 주소를 선택합니다.">
                                                    <option value="etc">직접입력</option>
                                                    <option value="naver.com">naver.com</option>
                                                    <option value="daum.net">daum.net</option>
                                                    <option value="gmail.com">gmail.com</option>
                                                </select>
                                                <a class="commBT" href="javascript:fn_EmailDuplicationChk()">중복확인</a>
                                            </c:if>
                                            <c:if test="${not empty user.email}">
                                                <span>${user.email}</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>이름 <strong class="necessary">*</strong></th>
                                        <td>
                                            <form:input path="userNm" id="userNm" class="mgR commWidth" value="${user.userNm}"/>
                                            <form:errors path="userNm" cssClass="error_text" />
                                        </td>
                                    </tr>
                                    <!-- SNS 회원가입의 경우 비밀번호를 받지 않음 -->
                                    <c:if test="${empty user.snsDiv}">
                                        <tr>
                                            <th>비밀번호 <strong class="necessary">*</strong></th>
                                            <td>
                                                <form:password path="pwd" id="pwd" class="mgR commWidth" value="${user.pwd}" onkeyup="fn_OnChangeNewPw(this.value);"/>
                                                <span class="intInfo">영문, 숫자, 특수문자 조합의 8~20자리입니다. 특수문자 %&+ 는 사용하실 수 없습니다.</span>
                                                <span id='pwCmtFail' class='label1'>&nbsp;</span><span id='pwCmtOk' class='label2' style="display: none;">(사용가능)</span>
                                                <%-- <form:errors path="pwd" cssClass="error_text" /> --%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>비밀번호 확인 <strong class="necessary">*</strong></th>
                                            <td>
                                                <input type="password" name="pwd_re" id="pwd_re" class="mgR commWidth" value="${user.pwd}" >
                                                <span class="intInfo">확인을 위해 한번 더 입력해주세요.</span>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <tr class="phoneWrap">
                                        <th>휴대폰번호 <strong class="necessary">*</strong></th>
                                        <td>
                                            <form:input path="telNum" id="telNum" class="mgR commWidth" onkeyup="addHyphenToPhone(this);"/>
                                            <form:errors path="telNum"  cssClass="error_text" />
                                            <a id="btnSendSms" class="commBT" href="javascript:fn_SendSms();">인증번호받기</a>
                                            <div class="cert" style="display: none;">
                                                <span class="title">인증번호</span>
                                                <input type="text" name="certNumber" id="certNumber">
                                                <a href="javascript:fn_Cert();" class="mgR commBT">확인</a>
                                                <span class="msg" style="display:none;">인증번호가 오지 않으면 입력하신 정보가 정확한지 확인해주세요.</span>
                                            </div>
                                        </td>
                                    </tr>
                                    <%--<tr class="agWrap">
                                        <th>수신동의</th>
                                        <td>
                                            <p>탐나오에서 진행하는 이벤트, 특가 정보를 이메일 또는 휴대폰 문자메시지로 안내 받으실 수 있습니다.</p>
                                            <input id="emailRcvAgrYnView" type="checkbox" name="emailRcvAgrYnView" <c:if test="${user.emailRcvAgrYn=='Y' or empty user.emailRcvAgrYn}">checked="checked"</c:if>><label for="emailRcvAgrYnView">이메일 수신동의</label>
                                            <input id="smsRcvAgrYnView" type="checkbox" name="smsRcvAgrYnView" <c:if test="${user.smsRcvAgrYn=='Y' or empty user.smsRcvAgrYn}">checked="checked"</c:if>><label for="smsRcvAgrYnView">SMS 수신동의</label>
                                        </td>
                                    </tr>--%>
                                </table>
                            </form:form>

                            <p class="button"><button class="comm-arrowBT comm-arrowBT2" onclick="javascript:fn_SignUp();">가입하기</button></p>
                        </div> <!--//member-ctWrap-->
                    </div>
                </div>
            </div> <!-- //sign-up3 -->
            <!-- //new contents -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>
<jsp:include page="/web/foot.do" />
</body>
</html>