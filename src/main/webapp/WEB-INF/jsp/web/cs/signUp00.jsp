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
<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />

<script type="text/javascript">
//네이버 로그인
function fn_Naver(val) {
    var redirectUri = location.origin + "${Constant.NAVER_REDIRECT_PATH}";
    var encUri = encodeURIComponent(redirectUri);

    var parameters = "client_id=${Constant.NAVER_CLIENT_ID}";
    parameters += "&response_type=code";
    parameters += "&redirect_uri=" + encUri;
    parameters += "&state=web";
    if(val) {
        parameters += "&auth_type=reprompt";
    }
    location.href = "https://nid.naver.com/oauth2.0/authorize?" + parameters;
};

//카카오 로그인
function fn_Kakao(val) {
    var redirectUri = location.origin + "${Constant.KAKAO_REDIRECT_PATH}";

    var parameters = "client_id=${Constant.KAKAO_REST_API_KEY}";
    parameters += "&redirect_uri=" + redirectUri;
    parameters += "&response_type=code";
    parameters += "&state=web";
    parameters += "&encode_state=true";
    if(val) {
        parameters += "&scope=,account_email";
    }
    location.href = "https://kauth.kakao.com/oauth/authorize?" + parameters;
}

//기존 가입자의 간편가입 연동
function fn_LinkUserSns() {
    document.frm.action = "<c:url value='/web/insertUserSns.do' />";
    document.frm.submit();
}

function fn_EmailDuplicationChk(email) {
    var parameters = "email=" + email;

    $.ajax({
        type:"post",
        dataType:"json",
        url:"<c:url value='/emailDuplication.ajax'/>",
        data:parameters,
        success:function(data){
            if(data.chk == "N") {
                alert("<spring:message code='info.sns.link.join'/>");

                $("#email").val(email);
                document.frm.action = "<c:url value='/web/signUp02.do'/>";
                document.frm.submit();
            } else {
                alert("<spring:message code='info.sns.link.user'/>");

                $("#userId").val(data.userId);

                fn_LinkUserSns();
            }
        }
    });
}

function fn_SnsLogin(userNm, email) {

    if(email == "id@naver.com" || email == "네이버id@naver.com" || email == "-"){
        alert("네이버API 오류 입니다. 다시 시도해 주시기 바랍니다.");
        document.frm.action = "<c:url value='/mw/main.do'/>";
        document.frm.submit();
        return;
    }

    var parameters = $("#frm").serialize();

    $.ajax({
        type:"post",
        dataType:"json",
        url:"<c:url value='/web/checkSns.ajax'/>",
        data:parameters,
        success:function(data){
            if(data.result == "Y") {
                document.frm.action = "<c:url value='/web/actionSnsLogin.do'/>";
                document.frm.submit();
            } else {
                $("#userNm").val(userNm);

                if(isNull(email)) {
                    alert("<spring:message code='info.sns.link.join'/>");

                    document.frm.action = "<c:url value='/web/signUp02.do'/>";
                    document.frm.submit();
                } else {
                    fn_EmailDuplicationChk(email);
                }
            }
        }
    });
}

$(document).ready(function(){
    // 간편로그인
    if(${not empty snsMap.loginKey}) {
        // 이메일 제공 동의여부 체크
        if(${empty snsMap.email}) {
            alert("<spring:message code='common.required.msg' arguments='이메일' /> ");

            if("${snsMap.snsDiv}" == "N") {
                fn_Naver("re");
            } else {
                fn_Kakao("re");
            }
        } else {
            $(".modal").show();

            fn_SnsLogin("${snsMap.userNm}", "${snsMap.email}");
        }
    }

});
</script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
    <div class="mapLocation">
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>회원가입</span>
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" />
    <!-- //quick banner -->
    <div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
            <!-- new contents -->
            <div class="sign-up4">
                <div class="bgWrap2">
                    <div class="Fasten">
                        <div class="member-title">
                            <h2>회원가입</h2>
                        </div>
                        <div class="member-ctWrap">
                            <form name="frm" id="frm" method="post" onSubmit="return false;">
                                <input type="hidden" name="snsDiv" id="snsDiv" value="${snsMap.snsDiv}"/>
                                <input type="hidden" name="loginKey" id="loginKey" value="${snsMap.loginKey}"/>
                                <input type="hidden" name="token" id="token" value="${snsMap.token}"/>
                                <input type="hidden" name="userNm" id="userNm" />
                                <input type="hidden" name="email" id="email" />
                                <input type="hidden" name="userId" id="userId" />
                            </form>
                            <div class="join-event-banner">
                                <img src="/images/web/sns/join/join-banner.png">
                            </div>
                            <div id="divJoin">
                                <ul>
                                    <li>
                                        <a href="<c:url value='/web/signUp02.do'/>"><img src="/images/web/sns/join/email_join.png" alt="이메일로 회원가입"></a>
                                    </li>
                                </ul>
                            </div>
                            <div class="login-sns-wrapper">
                                <ul class="sns-login-area typeA">
                                    <li>
                                        <a href="javascript:fn_Naver();"><img src="/images/web/sns/join/naver_join.png" alt="네이버로 회원가입"></a>
                                    </li>
                                    <li>
                                        <a href="javascript:fn_Kakao();"><img src="/images/web/sns/join/kakao_join.png" alt="카카오로 회원가입"></a>
                                    </li>
                                </ul>
                                <span>SNS 계정을 통해 간편하게 가입할 수 있습니다.</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- //sign-up4 -->
            <!-- //new contents -->
            <div class="modal">
            </div>
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>

<jsp:include page="/web/foot.do" />

</body>
</html>