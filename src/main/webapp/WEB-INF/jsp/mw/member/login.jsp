<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
<% session.removeAttribute("lastLoginToken"); %>
           
<un:useConstants var="Constant" className="common.Constant" />
<head>

<meta name="robots" content="noindex">
<jsp:include page="/mw/includeJs.do" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_member.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css'/>"> --%>

<script src="/js/sha256.js"></script>    
<script type="text/javascript">

let doubleSubmitFlag = false;
function doubleSubmitCheck() {
	if(doubleSubmitFlag) {
		return doubleSubmitFlag;
	} else {
		doubleSubmitFlag = true;
		return false;
	}
}

let doubleSubmitNaverFlag = false;
function doubleSubmitNaverCheck() {
	if(doubleSubmitNaverFlag) {
		return doubleSubmitNaverFlag;
	} else {
		doubleSubmitNaverFlag = true;
		return false;
	}
}

let doubleSubmitKakaoFlag = false;
function doubleSubmitKakaoCheck() {
	if(doubleSubmitKakaoFlag) {
		return doubleSubmitKakaoFlag;
	} else {
		doubleSubmitKakaoFlag = true;
		return false;
	}
}

function fn_Login(){

	fn_saveID();
	
	$("#pwd").val(SHA256($("#pwd").val()));
	
	if(doubleSubmitFlag) {
        return;
    }
	
	doubleSubmitCheck();

	document.frm.action = "<c:url value='/mw/actionLogin.do'/>";
	document.frm.submit();
}

/**
 * 아이디 저장 기능
 * hamhaja <ezham@nextez.co.kr>
 */
function fn_saveID(){
	 try{
		 if(typeof(Storage) !== "undefined"){
				if($("#idSave").is(":checked")){		
					localStorage.setItem("email", $("#email").val());
				}else{
					localStorage.setItem("email", "");
				}
			}else{
				window.alert("자동저장 기능을 제공하지 않는 브라우져입니다.");
			} 
	 }catch(e){
		 window.alert("자동저장 기능을 제공하지 않는 브라우져입니다.");
	 }
}

function fn_ShowLogin(idx){
	if(idx == 1){
		$("#user-2").hide();
		$("#user-1").show();
        $("#divSns").show();
	}else{
		$("#user-1").hide();
		$("#user-2").show();
		$("#divSns").hide();
	}
}

var sendYn = "N";

function fn_SendSms(){
	
	if(isNull($("#userNm").val())){
		alert("이름이 입력되지 않았습니다.");
		$("#userNm").focus();
		return;
	}
    var phoneNum = $("#telNum").val();

    if(checkIsHP(phoneNum)) {
        $("#telNum").val(phoneNum);

        var parameters = "telNum=" + $("#telNum").val() + "&userNm=" + $("#userNm").val() + "&isMypage=Y";

        $.ajax({
            type:"post",
            dataType:"json",
            url:"<c:url value='/web/getAuthNumGuest.ajax'/>",
            data:parameters,
            success:function(data){
                if(data.success == "Y") {
                    alert("<spring:message code='success.send.certNum' />");
                    $("#telNum").readOnly = true;
                    sendYn = "Y";
                    $("#divCert").show();
                    $("#certBtn").css("display","block");

                } else {
                    alert(data.failMsg);
                }
            }
        });
    } else {
        alert('<spring:message code="errors.phone"/>');
    }
}

function fn_Next() {
	if(sendYn == "N") {
        alert("<spring:message code='info.phone.cert'/>");
		return;
	}
	var parameters = "telNum=" + $("#telNum").val();
	parameters += "&authNum=" + $("#certNumber").val();
	parameters += "&userNm=" + $("#userNm").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/web/checkAuthNumGuest.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.success == "Y") {
				document.frm.action = "<c:url value='/mw/mypage/rsvList.do'/>";
				document.frm.submit();
			} else {
				alert(data.failMsg);
			}
		}
	});
}

//네이버 로그인
function fn_Naver(val) {
	
	if(doubleSubmitNaverFlag) {
		return;
	}
		
	doubleSubmitNaverCheck();
	
    localStorage.setItem("rtnUrlM", $("#rtnUrl").val().toString());
    localStorage.setItem("urlParamM", $("#urlParam").val().toString());

    var redirectUri = location.origin + "${Constant.NAVER_REDIRECT_PATH}";
    var encUri = encodeURIComponent(redirectUri);

    var parameters = "client_id=${Constant.NAVER_CLIENT_ID}";
    parameters += "&response_type=code";
    parameters += "&redirect_uri=" + encUri;
    parameters += "&state=mw_login";
    if(val) {
        parameters += "&auth_type=reprompt";
    }
    location.href = "https://nid.naver.com/oauth2.0/authorize?" + parameters;
}

//카카오 로그인
function fn_Kakao(val) {
	
	if(doubleSubmitKakaoFlag) {
        return;
    }
	
	doubleSubmitKakaoCheck();
	
    localStorage.setItem("rtnUrlM", $("#rtnUrl").val().toString());
    localStorage.setItem("urlParamM", $("#urlParam").val().toString());

    var redirectUri = location.origin + "${Constant.KAKAO_REDIRECT_PATH}";

    var parameters = "client_id=${Constant.KAKAO_REST_API_KEY}";
    parameters += "&redirect_uri=" + redirectUri;
    parameters += "&response_type=code";
    parameters += "&state=mw_login";
    parameters += "&encode_state=true";
    if(val) {
        parameters += "&scope=,account_email";
    }
    location.href = "https://kauth.kakao.com/oauth/authorize?" + parameters;
}

//애플 로그인
function fn_Apple(val) {
    localStorage.setItem("rtnUrlM", $("#rtnUrl").val().toString());
    localStorage.setItem("urlParamM", $("#urlParam").val().toString());

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
                $("#rtnUrl").val(localStorage.getItem("rtnUrlM"));
                $("#urlParam").val(localStorage.getItem("urlParamM"));

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

function fn_GoJlair(){
    $("body").css("overflow","hidden");
    $("body").css("touch-action","hidden");

    // JL항공 예약 조회
    $('#jlairRsv').show();
    $('#jlairRsv').css("top", $(document).scrollTop() + "px");
}

function fn_GoSunmin(){
    $("body").css("overflow","hidden");
    $("body").css("touch-action","hidden");

    // 선민투어 예약 조회
    $('#overlaySunmin').show();
    $('#sunminRsv').show();
    $('#sunminRsv').css("top", $(document).scrollTop() + "px");
}

$(document).ready(function() {

    var chkIos = fn_AppCheck();
    /** 테스트 */
    /*chkIos = "IW";*/

    if(chkIos == "IA" || chkIos == "IW" ){
        $(".btnApple").css("display","block");
    }
	if("${failLogin}" != "") {
		alert("${failLogin}");
	}
	if(typeof(Storage) !== "undefined") {
		$("#email").val(localStorage.email);
	}
	if("${mode}" != "user") {
		$("#memY").prop("checked", true);
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

    function validateEmail(email) {
        var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return regex.test(email);
    }

    function toggleIconsAndButton() {
        var emailVal = $("#email").val().trim();
        var pwdVal = $("#pwd").val().trim();

        if (validateEmail(emailVal)) {
            $(".id_clean_icon").show();
        } else {
            $(".id_clean_icon").hide();
        }

        if (pwdVal.length > 0) {
            $(".pwd_clean_icon").show();
        } else {
            $(".pwd_clean_icon").hide();
        }

        if ($(".id_clean_icon").is(":visible") && $(".pwd_clean_icon").is(":visible")) {
            $(".btn-login").addClass("active").attr("href", "javascript:fn_Login();");
        } else {
            $(".btn-login").removeClass("active").removeAttr("href");
        }
    }

    $("#email, #pwd").on("input", function() {
        toggleIconsAndButton();
    });

    $(".id_clean_icon").click(function() {
        $("#email").val("");
        $(this).hide();
        toggleIconsAndButton();
    });

    $(".pwd_clean_icon").click(function() {
        $("#pwd").val("");
        $(this).hide();
        toggleIconsAndButton();
    });

    $("#jlairRsvClose").click(function () {
        $("body").css("overflow", "visible");
        $("body").css("touch-action", "auto");
        $("#jlairRsv").hide();
    });

    $("#sunminRsvClose").click(function () {
        $("body").css("overflow", "visible");
        $("body").css("touch-action", "auto");
        $("#sunminRsv").hide();
        $("#overlaySunmin").hide();
    });
});

</script>
</head>
<body class="login-body">
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" />
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>

<div id="jlairRsv" class="comm-layer-popup delivery-popup" style="top: 0">
    <div class="content-wrap">
        <div class="content">
            <div class="head">
                <h3 class="title">JLAIR-탐나오 </h3>
                <button type="button" id="jlairRsvClose" class="close">
                    <img src="/images/mw/icon/close/dark-gray.png" alt="닫기">
                </button>
            </div>
            <div>
                <iframe src="https://www.jlair.net/m/index.php?mid=04&newopen=yes" width="100%" height="100%;" style="border:none; position: fixed; top: 15px;"></iframe>
            </div>
        </div>
    </div>
</div>
    <div id="sunminRsv" class="comm-layer-popup delivery-popup" style="top: 0">
        <div class="content-wrap">
            <div class="content">
                <div class="head">
                    <h3 class="title">선민투어-탐나오 </h3>
                    <button type="button" id="sunminRsvClose" class="close">
                        <img src="/images/mw/icon/close/dark-gray.png" alt="닫기">
                    </button>
                </div>
                <div>
                    <iframe src="https://air.dcjeju.net/air/login" width="100%" height="100%;" style="border:none; position: fixed; top: 15px;"></iframe>
                </div>
            </div>
        </div>
    </div>
<section id="subContent">
    <div class="sub-content2">
        <div class="login">
            <form id="frm" name="frm" method="post" onSubmit="return false;">
                <input type="hidden" name="rtnUrl" id="rtnUrl" value="<c:out value='${rtnUrl}' escapeXml='false' />" />
                <input type="hidden" name="urlParam" id="urlParam" value="<c:out value='${urlParam}' escapeXml='false' />" />
                <input type="hidden" name="mode" value="${mode}" />
                <input type="hidden" name="snsDiv" id="snsDiv" value="${snsMap.snsDiv}"/>
                <input type="hidden" name="loginKey" id="loginKey" value="${snsMap.loginKey}"/>
                <input type="hidden" name="token" id="token" value="${snsMap.token}"/>
                <input type="hidden" name="userId" id="userId" />

                <div class="membership-section">
                    <div class="member-title">
                        <h2 class="login-head">안녕하세요.<br>탐나오입니다.</h2>

                        <div class="login_service" checked="checked">로그인 후 다양한 서비스를 이용하실 수 있습니다.</div>

                    </div>
                    <c:if test="${mode != 'user'}">
                        <div class="user-check">
                            <input id="memY" name="memberChoice"  checked="checked" type="radio" onclick="fn_ShowLogin(1)"><label for="memY">회원</label>
                            <input id="memN" name="memberChoice"  type="radio" onclick="fn_ShowLogin(2)"><label for="memN" >비회원</label>
                        </div>
                    </c:if>
                </div>

                <c:if test="${mode == ''|| mode == 'user' || mode == 'pay'}">
                    <!-- 회원 로그인 -->
                    <div class="user-y" id="user-1">
                        <div class="wrap-form">
                        <!--<p class="keyboard"><a href="">PC 키보드 열기 <img src="../../images/mw/sub_common/more_arrow.png" alt="열기"></a></p>-->
                            <div class="form-value">
                                <!-- <label for="LoginId">아이디를 입력하세요.</label> -->
                                <input id="email" name="email" type="text" placeholder="이메일을 입력하세요">
                                <img class="id_clean_icon" src="/images/mw/sns/login/login_clean_icon.png" alt="클린 아이콘">
                            </div>
                            <div class="form-value form-pw">
                                <input id="pwd" name="pwd" type="password" placeholder="비밀번호를 입력하세요">
                                <img style="display: none;" class="pwd_clean_icon" src="/images/mw/sns/login/login_clean_icon.png" alt="클린 아이콘">
                            </div>
                        </div>
                        <div class="login-check">
                            <input type="checkbox" name="idSave" id="idSave" value="Y" checked="checked">
                            <label for="idSave">아이디 저장</label>
                        </div>
                        <p class="find-join">
                            <a class="text" href="<c:url value='/mw/viewFindIdPwd.do'/>">아이디/비밀번호 찾기</a>
                        </p>
                        <p class="btn-list">
                            <a href="javascript:fn_Login();" class="btn btn1 btn-login">로그인</a>
                            <!-- <a href="" class="btn btn2">비회원구매</a> -->
                        </p>
                        <!--<p class="btn-list">
                            <a href="/mw/signUp00.do" class="btn btn11">회원가입</a>
                            <a href="" class="btn btn2">비회원구매</a>
                        </p>-->
                    </div>
                </c:if>
                <c:if test="${mode == ''}">
                    <!-- 비회원 로그인 -->
                    <div class="user-n" id="user-2" style="display: none;">
                        <div class="form-value">
                            <input type="text" placeholder="이름을 입력하세요" name="userNm" id="userNm">
                        </div>
                        <div class="form-value">
                            <%--<input class="phone" type="tel" placeholder="010"  name="hp1" id="hp1" maxlength="3">
                            <input class="phone" type="tel" placeholder="1234" name="hp2" id="hp2" maxlength="4">
                            <input class="phone" type="tel" placeholder="5678" name="hp3" id="hp3" maxlength="4">--%>
                            <input class="phone" type="tel" name="telNum" id="telNum" onkeyup="addHyphenToPhone(this);" placeholder="휴대폰 번호입력">
                            <a href="javascript:fn_SendSms();" class="btn btn6">인증</a>
                        </div>
                        <div class="form-value" id="divCert" style="display: none;">
                            <input class="phone" type="number" placeholder="인증번호를 입력하세요" id="certNumber">
                            <%--<a href="javascript:fn_Next();" class="btn btn6">확인</a>--%>
                        </div>
                        <p class="btn-list" id="certBtn" style="display: none;">
                            <a href="#" class="btn btn1" onclick="javascript:fn_Next();">확인</a>
                        </p>
                        <div class="user-n-air">
                            <div class="air-login-header">
                                <div class="line"></div>
                                <div class="text">비회원 항공예약확인</div>
                                <div class="line"></div>
                            </div>
                            <div class="center-btn">
                                <a class="btn btn0" href="javascript:fn_GoJlair();">
                                    <img src="/images/mw/list/jlair.png" alt="제이엘 항공">
                                </a>
                                <a class="btn btn1" href="javascript:fn_GoSunmin();">
                                    <img src="/images/mw/list/sunmin.png" alt="선민투어">
                                </a>
                            </div>
                        </div>
                        <ul class="lower-text">
                            <li><span> 비회원 예약시</span> 탐나오쿠폰, 이벤트 참여 등<br> <span>다양한 혜택을 받으실 수 없습니다.</span></li>
                            <li> 비회원 로그인 후에 <span>예약/구매 내역</span>으로 이동합니다.</li>
                        </ul>

                    </div>
                </c:if>
                <c:if test="${mode == 'pay'}">
                    <!-- 비회원 구매 로그인 -->
                    <div class="user-n2" id="user-2" style="display: none;">
                        <div class="wrap-form">
                        <ul class="info">
                            <li>비회원으로 구매서비스를 이용하시려면 <strong>비회원 구매 약관동의</strong>를 하셔야 합니다.</li>
                            <li><strong>다음 단계로 이동버튼</strong>을 클릭해 주십시오.</li>
                        </ul>
                        <p class="btn-list">
                            <a href="/mw/guestPay01.do?mode=${param.mode}&cartSn=${param.cartSn}&rsvDiv=${param.rsvDiv}" class="btn btn1">다음단계로 이동</a>
                        </p>
                        </div>
                    </div>
                </c:if>
            </form>
            <div class="login-sns-wrapper" id="divSns">
                <div class="sns-login-header">
                    <div class="line"></div>
                    <div class="text">SNS 계정으로 간편로그인</div>
                    <div class="line"></div>
                </div>
                <div class="sns-buttons-wrapper">
                    <a href="javascript:fn_Naver();"><p class="btnNaver"></p></a>
                    <a href="javascript:fn_Kakao();"><p class="btnKakao"></p></a>
                    <a href="javascript:fn_Apple();"><p class="btnApple"></p></a>
                </div>
            </div>
            <p class="login-join">아직 회원이 아니신가요? <a href="/mw/signUp00.do">회원가입</a></p>
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
<div id="overlaySunmin"></div>
</body>
</html>