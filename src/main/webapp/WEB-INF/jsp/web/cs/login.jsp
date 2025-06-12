<!DOCTYPE html>
<html lang="ko">
<%@ page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>
<% session.removeAttribute("lastLoginToken"); %>
           
<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" />

<script src="/js/sha256.js"></script>
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=1.2'/>" />--%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>

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

function fn_Login() {
	
	if($("#email").val() == "") {
		alert("<spring:message code='errors.required2' arguments='이메일'/>");
		$("#email").focus();
		return;
	}
	if($("#pwd").val() == "") {
		alert("<spring:message code='errors.required2' arguments='비밀번호'/>");
		$("#pwd").focus();
		return;
	}
	$("#pwd").val(SHA256($("#pwd").val()));
	
	if(doubleSubmitFlag) {
        return;
    }
	
	doubleSubmitCheck();
	
	document.frm.action = "<c:url value='/web/actionLogin.do'/>";
	document.frm.submit();
}

function fn_ShowLogin(idx) {
    if(idx == 1) {
        $("#user-n").hide();
        $("#user-2").hide();
        $("#memN").hide();
        $("#user-y").show();
        $("#user-1").show();
        $("#memY").show();
        $("#divSns").show();
        $(".tabList").removeClass("on");
    } else {
        $("#user-y").hide();
        $("#user-1").hide();
        $("#memY").hide();
        $("#user-n").show();
        $("#user-2").show();
        $("#memN").show();
        $("#divSns").hide();
        $(".tabList").addClass("on");
    }
}

var sendYn = "N";

function fn_SendSms() {
	if(isNull($("#userNm").val())){
		alert('<spring:message code="errors.required2" arguments="이름" />');
		$("#userNm").focus();
		return;
	}
	var phoneNum = $("#telNum").val();

	if(isNull(phoneNum)) {
		alert('<spring:message code="errors.required2" arguments="휴대폰번호" />');
		$("#telNum").focus();
		return;
	}
	if(checkIsHP(phoneNum)) {
		var parameters = "isMypage=Y&telNum=" + phoneNum;
		parameters += "&userNm=" + $("#userNm").val();

		$.ajax({
			type:"post",
			dataType:"json",
			url:"<c:url value='/web/getAuthNumGuest.ajax'/>",
			data:parameters ,
			success:function(data){
				if(data.success == "Y"){
					alert("<spring:message code='success.send.certNum'/>");
					sendYn = "Y";

                    $("#telNum").val(phoneNum);
                    $("#telNum").readOnly = true;
					$("#certTr").show();
				}else{
					alert(data.failMsg);
				}
			}
		});
	} else {
		alert('<spring:message code="errors.phone"/>');
	}
}

function fn_Cert() {
	if(sendYn == "N"){
		alert('<spring:message code="info.phone.cert" />');
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
			if(data.success == "Y"){
				document.frm.action = "<c:url value='/web/mypage/rsvList.do'/>";
				document.frm.submit();
			}else{
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
		
    localStorage.setItem("rtnUrl", $("#rtnUrl").val().toString());
    localStorage.setItem("urlParam", $("#urlParam").val().toString());

    var redirectUri = location.origin + "${Constant.NAVER_REDIRECT_PATH}";
    var encUri = encodeURIComponent(redirectUri);
	
    var parameters = "client_id=${Constant.NAVER_CLIENT_ID}";
    parameters += "&response_type=code";
    parameters += "&redirect_uri=" + encUri;
    parameters += "&state=web_login";
    
    if(val) {
		parameters += "&auth_type=reprompt";
	}
    location.href = "https://nid.naver.com/oauth2.0/authorize?" + parameters;
};

//카카오 로그인
function fn_Kakao(val) {
	
	if(doubleSubmitKakaoFlag) {
        return;
    }
	
	doubleSubmitKakaoCheck();
	
    localStorage.setItem("rtnUrl", $("#rtnUrl").val().toString());
    localStorage.setItem("urlParam", $("#urlParam").val().toString());

    var redirectUri = location.origin + "${Constant.KAKAO_REDIRECT_PATH}";

    var parameters = "client_id=${Constant.KAKAO_REST_API_KEY}";
    parameters += "&redirect_uri=" + redirectUri;
    parameters += "&response_type=code";
    parameters += "&state=web_login";
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
				$("#rtnUrl").val(localStorage.getItem("rtnUrl"));
				$("#urlParam").val(localStorage.getItem("urlParam"));

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

function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

$(document).ready(function(){
	
    var key = getCookie("key");
    $("#email").val(key); 
     
    if($("#email").val() != ""){
        $("#idSaveCheck").attr("checked", true);
    }
     
    $("#idSaveCheck").change(function(){
        if($("#idSaveCheck").is(":checked")){
            setCookie("key", $("#email").val(), 7);
        }else{
            deleteCookie("key");
        }
    });
     
    $("#email").keyup(function(){
        if($("#idSaveCheck").is(":checked")){
            setCookie("key", $("#email").val(), 7);
        }
    });
    
	if("${failLogin}" != "") {
		alert("${failLogin}");
	}

	if("${mode}" != "user") {
		$("#memY").attr("checked", true);
	}
	
    var sBtn = $("ul.user-check > li");
    sBtn.find("a").click(function(){
        sBtn.removeClass("active");
        $(this).parent().addClass("active");
    })
    
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

    // IE 10 이하 버전 경고
    var browserVersion = browserVersionCheck();
    if(browserVersion.indexOf("IE") > -1 && browserVersion != "IE11") {
    	alert($("#browser").html() + "\n\n- 접속 브라우저: " + browserVersion);
	}
    
    $("#pwd").keyup(function(e){
        if(e.keyCode == 13){
        	if($("#pwd").val() == "") {
        		alert("<spring:message code='errors.required2' arguments='비밀번호'/>");
        		$("#pwd").focus();
        		return;
        	}else{
        		fn_Login();
        	}
        }
    });    
    
    $("#telNum").keyup(function(e){
        if(e.keyCode == 13){
        	if($("#telNum").val() == "") {
        		alert("<spring:message code='errors.required2' arguments='휴대폰 번호'/>");
        		$("#telNum").focus();
        		return;
        	}else{
        		fn_SendSms();
        	}
        }
    });    

    $("#certNumber").keyup(function(e){
        if(e.keyCode == 13){
        	if($("#certNumber").val() == "") {
        		alert("<spring:message code='errors.required2' arguments='인증번호'/>");
        		$("#certNumber").focus();
        		return;
        	}else{
        		fn_Cert();
        	}
        }
    });    

});
</script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
    <%--<div class="mapLocation"> <!-- index page에서는 삭제 -->--%>
        <%--<div class="inner">--%>
            <%--<span>홈</span> <span class="gt">&gt;</span>--%>
            <%--<span>로그인</span>--%>
            <%--<!-- <span>실시간 숙박</span> <span class="gt">&gt;</span>--%>
            <%--<span>숙박상세</span> -->--%>
        <%--</div>--%>
    <%--</div>--%>
    
    <jsp:include page="/web/left.do" />
    
    <div class="subContainer">
		<div class="user-login">
			<div class="Fasten">
				 <!-- title -->
				<div class="member-title">
					<h2 class="login-head">안녕하세요.
						<br>
						<span>Tamnao</span>입니다.
						<br>
						<div id="memY" class="login_service">로그인 후 다양한 서비스를 이용하실 수 있습니다.</div>
						<div id="memN" class="login_service" style="display: none;">비회원 예약시 탐나오쿠폰, 이벤트 참여 등 다양한 혜택을 받으실 수 없습니다.</div>
					</h2>
				</div>

				<!-- login_tab -->
				<div class="lArea">	
					<form name="frm" id="frm" method="post" onSubmit="return false;">
					<input type="hidden" name="rtnUrl" id="rtnUrl" value="<c:out value='${rtnUrl}' escapeXml='false' />" />
					<input type="hidden" name="urlParam" id="urlParam" value="<c:out value='${urlParam}' escapeXml='false' />" />
					<input type="hidden" name="mode" id="mode" value="${mode}" />
					<input type="hidden" name="snsDiv" id="snsDiv" value="${snsMap.snsDiv}"/>
					<input type="hidden" name="loginKey" id="loginKey" value="${snsMap.loginKey}"/>
					<input type="hidden" name="token" id="token" value="${snsMap.token}"/>
					<input type="hidden" name="userId" id="userId" />
					
					<div class="loginBox">
                    	<div class="wrap_tab">
							<c:if test="${mode != 'user'}">
							<ul class="user-check">
								<li class="tlt active">
									<a class="memY " name="memberChoice" checked="checked" onclick="fn_ShowLogin(1)">
										<span>회원 로그인</span>
									</a>
								</li>
								<li class="tit">
									<a class="memN" name="memberChoice" onclick="fn_ShowLogin(2)">
										<span>비회원 로그인</span>
									</a>
								</li>
							</ul>
							</c:if>
						</div>
                         
						<div class="jq_cont tab_cont"> 
							<!-- 회원 로그인 -->
							<c:if test="${mode == ''|| mode == 'user' || mode == 'pay'}">
							<div id="user-1" class="tabcontent user-y">
								<!-- login /* input (ID*PASSWORD) */ -->
								<div class="int-login">
									<div class=" inputSet login">
                                        <div>
                                            <input name="email" id="email" class="email" type="text" placeholder="아이디 또는 이메일">
                                        </div>										
									</div>
                                    <div class="inputSet login">
                                     	<div class="passwordWrap">
                                        	<input name="pwd" id="pwd" class="pwd" type="password" placeholder="비밀번호 (영문＋숫자+특수 8~20자)" autocomplete="new-password" >
                                        </div>
                                    </div>						
								</div>
                                <!-- check box -->
                                <div class="autoLogin">
                                    <input id="idSaveCheck" class="blind" type="checkbox" name="idSaveCheck" checked>
                                    <label for="idSaveCheck" class="chk_box">아이디 저장</label>
                                </div>	
                                <div class="btnConfirmWrap">
                                    <button type="button" class="hasBgColor" onclick="fn_Login();">
                                        <span class="inner">
                                            <span>로그인하기</span>
                                        </span>
                                    </button>
                                </div>
                                <!-- member-find -->
                                <div class="login-info">
                                    <div class="buttonGroup">
                                        <a class="inner_txt" href="/web/viewFindIdPwd.do">아이디 찾기</a>
                                        <a class="inner_txt" href="/web/viewFindIdPwd.do">비밀번호 찾기</a>
                                        <a class="inner_txt" href="/web/signUp00.do">회원가입하기</a>
                                    </div>
                                </div>
							</div>                             
							</c:if>
							
							<!-- 비회원 로그인 -->
							<c:if test="${mode == ''}">
							<div id="user-2" class="tabcontent user-n" style="display: none;">
                                <div class="int-login">
                                    <div class="inputSet login">
                                        <div>
                                            <input name="userNm" id="userNm"class="userNm" type="text" placeholder="이름">
                                        </div>
                                    </div>
                                    <div class="inputSet login">
                                        <div class="int number">
                                            <input name="telNum" id="telNum" class="telNum" type="text" placeholder="휴대폰 번호" onkeyup="addHyphenToPhone(this);">
                                            <button type="button" class="confibtn" onclick="javascript:fn_SendSms();">
                                                <span class="inner">
                                                    <span>인증</span>
                                                </span>
                                            </button>                                            
                                        </div>
                                    </div>
                                    <div id="certTr" class="inputSet login">
                                        <div class="int number">
                                            <input name="certNumber" id="certNumber" class="certNumber" type="text"  placeholder="인증번호를 입력해주세요">
                                        </div>
                                    </div>                                    
                                </div>	
                                <!-- login button -->
                                <div class="btnConfirmWrap">
                                    <button type="button" class="hasBgColor" onclick="javascript:fn_Cert();">
                                    <span class="inner">
                                        <span>인증완료</span>
                                    </span>
                                    </button>
                                </div>
                                <div class="lnfo">
                                    <span class="login-check">체크</span>
                                    비회원 로그인후에
                                    <span class="history">예약/구매내역</span>
                                    으로 이동합니다.
                                </div>   
								<!-- agency button -->
								<div class="air-wrapper">
									<div class="user-n-air">
										<div class="title-line-1"></div>
										<h3 class="user-n-title">비회원 항공예약확인</h3>
										<div class="title-line-2"></div>
                                   </div>
                                   <div class="center-btn">
                                       <button type="button" class="agency" onclick="window.open('https://www.jlair.net/contents/index.php?mid=04')" >
                                          <span class="btn btn0">
                                              <span class="icon-jlair"></span>
                                              <span>제이엘항공</span>
                                          </span>
                                       </button>
                                       <button type="button" class="agency" onclick="window.open('https://air.dcjeju.net/air/login')">
                                       	<span class="btn btn1">
                                           	<span class="icon-jejuair"></span>
                                               <span>선민투어</span>
                                       	</span>
                                       </button>
                                	</div>
                            	</div>
							</div>
							</c:if>
							
                            <!-- 비회원 결제 -->
                            <c:if test="${mode == 'pay'}">
							<div id="user-2" class="tabcontent user-n" style="display: none;">
	                            <div class="urer-ndec">
	                                <div class="info member">
	                                    <span class="login-check">체크</span>
	                                    비회원으로 구매서비스를 이용하시려면
	                                    <span class="history">비회원 구매 약관</span>
	                                    <span class="history-2">동의를 하셔야 합니다.</span>
	                                </div>
	                                <div class="lnfo member">
	                                    <span class="login-check">체크</span>
	                                    <span class="history">다음단계로 이동</span>
	                                    버튼을 클릭해 주십시오.
	                                </div>
	                            </div>
                                <div class="btnConfirmWrap">
                                    <button type="button" class="hasBgColor hasBgColor-member" onclick="location.href='/web/guestPay01.do?mode=${param.mode}&cartSn=${param.cartSn}&rsvDiv=${param.rsvDiv}';">
                                        <span class="inner">
                                            <span>다음단계로 이동</span>
                                        </span>
                                    </button>
                                </div>
							</div>
                            </c:if>
						</div>
						
						<!-- SNS button -->
						<div class="sns-wrapper" id="divSns">
							<div class="sns-login-area">
								<button type="button" class="sns" onclick="javascript:fn_Naver();">
									<span class="naver">
										<span class="icon naverLogin"></span>
										<span class="naver_txt">네이버로 로그인</span>
									</span>
								</button>
								<button type="button" class="sns" onclick="javascript:fn_Kakao();">
									<span class="kakao">
										<span class="icon kakaoLogin"></span>
										<span class="kakao_txt">카카오로 로그인</span>
									</span>
								</button>
							</div>
						</div>			
					</div>
					</form>
				</div>
				
                <!-- 우측 상품썸네일-->
                <div class="rArea">
                    <div class="slideWrap">
                        <script src="../../js/slideshow_dot.js"></script>
                        <script>
                            $(function() {
                                $("#demo3").webwidget_slideshow_dot({
                                    slideshow_window_width: '280',
                                    slideshow_window_height: '280',
                                    slideshow_foreColor: '#9f7357',
                                    directory: '../images/web/lodge/' //icon image
                                });
                            });
                        </script>
                        <div id="demo3" class="webwidget_slideshow_dot">
                            <ul>	
                            	<c:forEach items="${bestProductList}" var="best" varStatus="status">
                            		<c:if test="${status.count < 6 }">
	                                <li>
	                                    <a href="<c:url value='/web/${fn:toLowerCase(fn:substring(best.prdtNum, 0, 2)) }/detailPrdt.do?sPrdtNum=${best.prdtNum}&prdtNum=${best.prdtNum}&searchYn=${Constant.FLAG_N }'/>" data-icon="<p class='proName'><c:if test="${not empty best.etcExp }">[${best.etcExp}] </c:if>${best.prdtNm}</p><p class='price'><fmt:formatNumber>${best.saleAmt}</fmt:formatNumber><span>원</span></p><span class='ShortCuts_text'></span>">
	                                        <img src="${best.imgPath}" width="280" height="280" alt="${best.prdtNm}"/>
	                                    </a>
	                                </li>
	                                </c:if>
                                </c:forEach>
                            </ul>
                            <div style="clear: both"></div>
                        </div>
                    </div>
                </div>

				<!-- 하단_txt -->              
				<div class="browser">※ 탐나오 사이트는 Chrome, Firefox, Safari 및 IE 11 이상의 브라우저에 최적화되어 있습니다.</div>
			</div>
		</div>
    </div>
</main>

<jsp:include page="/web/foot.do" />

</body>
</html>