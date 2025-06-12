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
<jsp:include page="/mw/includeJs.do" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_member.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css'/>">
<script type="text/javascript">
//네이버로 회원가입
function fn_Naver(val) {
    var redirectUri = location.origin + "${Constant.NAVER_REDIRECT_PATH}";
    var encUri = encodeURIComponent(redirectUri);

    var parameters = "client_id=${Constant.NAVER_CLIENT_ID}";
    parameters += "&response_type=code";
    parameters += "&redirect_uri=" + encUri;
    parameters += "&state=mw";
    if(val) {
        parameters += "&auth_type=reprompt";
    }
    location.href = "https://nid.naver.com/oauth2.0/authorize?" + parameters;
}

//카카오로 회원가입
function fn_Kakao(val) {
    var redirectUri = location.origin + "${Constant.KAKAO_REDIRECT_PATH}";

    var parameters = "client_id=${Constant.KAKAO_REST_API_KEY}";
    parameters += "&redirect_uri=" + redirectUri;
    parameters += "&response_type=code";
    parameters += "&state=mw";
    parameters += "&encode_state=true";
    if(val) {
        parameters += "&scope=,account_email";
    }
    location.href = "https://kauth.kakao.com/oauth/authorize?" + parameters;
}

//애플 로그인
function fn_Apple(val) {
    var redirectUri = location.origin + "${Constant.APPLE_REDIRECT_PATH}";

    var parameters = "client_id=com.tamnao.applelogin";
    /*parameters += "&redirect_uri=" + "https://tamnao.com/appleLogin.do";*/
    parameters += "&redirect_uri=" + redirectUri;
    parameters += "&response_type=code id_token";
    parameters += "&state=mw_login";
    parameters += "&response_mode=form_post";

        parameters += "&scope=name email";

    location.href = "https://appleid.apple.com/auth/authorize?" + parameters;
}

//기존 가입자의 간편가입 연동
function fn_LinkUserSns() {
    document.frm.action = "<c:url value='/mw/insertUserSns.do' />";
    document.frm.submit();
}

function fn_EmailDuplicationChk(val) {
    var parameters = "email=" + val;

    $.ajax({
        type:"post",
        dataType:"json",
        url:"<c:url value='/emailDuplication.ajax'/>",
        data:parameters,
        success:function(data){
            if(data.chk == "N") {
                alert("<spring:message code='info.sns.link.join'/>");

                $("#email").val(val);
                document.frm.action = "<c:url value='/mw/signUp.do'/>";
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
        success:function(data) {
            if(data.result == "Y") {
                document.frm.action = "<c:url value='/mw/actionSnsLogin.do'/>";
                document.frm.submit();
            } else {
                $("#userNm").val(userNm);

                if(isNull(email)) {
                    alert("<spring:message code='info.sns.link.join'/>");

                    document.frm.action = "<c:url value='/mw/signUp.do'/>";
                    document.frm.submit();
                } else {
                    fn_EmailDuplicationChk(email);
                }
            }
        }
    });
}

$(document).ready(function(){
     var chkIos = fn_AppCheck();

    /** 테스트 */
    /*chkIos = "IW";*/

    if(chkIos == "IA" || chkIos == "IW" ){
        $(".apple").css("display","block");
    }else{
        $(".apple").css("display","none");
    }
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
<body class="login-body">
<div id="wrap">

<header id="header">
	<jsp:include page="/mw/head.do" />
</header>

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">
	<div class="menu-bar">
		<p class="btn-prev"><img src="/images/mw/common/btn_prev.png" width="20" alt="이전페이지"></p>
		<h2>탐나오 회원가입</h2>
	</div>
	<div class="sub-content">
		<div class="join-wrap">
			<!--회원가입-->
            <div class="tamnao-logo">
                <p>회원가입 하신 후 <br> 다양한 혜택을 받아보세요.</p>
            </div>

			<div class="join">
                <%--<h2>회원가입</h2>--%>
                <form name="frm" id="frm" method="post" onSubmit="return false;">
                    <input type="hidden" name="rtnUrl" value="" />
                    <input type="hidden" name="urlParam" value="" />
                    <input type="hidden" name="snsDiv" id="snsDiv" value="${snsMap.snsDiv}"/>
                    <input type="hidden" name="loginKey" id="loginKey" value="${snsMap.loginKey}"/>
                    <input type="hidden" name="token" id="token" value="${snsMap.token}"/>
                    <input type="hidden" name="userNm" id="userNm"/>
                    <input type="hidden" name="email" id="email"/>
                    <input type="hidden" name="userId" id="userId" />
                </form>
                <div class="join-end">
                    <ul class="sns-buttons-wrapper">
                        <li class="btnNaver">
                            <a href="javascript:fn_Naver();">
                                <img src="/images/mw/sns/login/naver_logo.png" alt="네이버 회원가입">
                                <p>네이버로 회원가입</p>
                            </a>
                        </li>
                        <li class="btnKakao">
                            <a href="javascript:fn_Kakao();">
                                <img src="/images/mw/sns/login/kakao_logo.png" alt="카카오톡 회원가입">
                                <p>카카오로 회원가입</p>
                            </a>
                        </li>
                        <li class="btnApple">
                            <a href="javascript:fn_Apple()();">
                                <img src="/images/mw/sns/login/apple_logo.png" alt="네이버 회원가입">
                                <p>Apple로 회원가입</p>
                            </a>
                        </li>
                        <li class="btnEmail">
                            <a href="<c:url value='/mw/signUp.do'/>">
                                <p>이메일로 회원가입</p>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="join-banner-mobile">
                    <img src="/images/mw/banner/mw-join-banner.png" alt="회원가입 프로모션">
                </div>

			</div>
		</div>
	</div>
    <div class="modal">
    </div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" />
<!-- 푸터 e -->
</div>
</body>
</html>
