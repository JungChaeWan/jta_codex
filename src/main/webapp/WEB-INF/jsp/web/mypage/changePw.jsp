<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		    uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>
           
<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/web/includeJs.do" />
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>" />

<script type="text/javascript">
var snsDiv = "";

function fn_ChangePw(){
    if(isNull(snsDiv)) {
        if(isNull($("#pwd").val())){
            alert("<spring:message code='errors.required2' arguments='현재 비밀번호'/>");
            $("#pwd").focus();
            return;
        }
    }
	if($("#newPwd").val() != $("#newPwd_re").val()){
		alert("<spring:message code='fail.user.passwordUpdate2'/>");
		$("#newPwd_re").focus();
		return;
	}
	if(!checkIsPwMix($("#newPwd").val())){
		alert("<spring:message code='fail.common.login.password1'/>");
		$("#newPwd").focus();
		return;
	}
    if(isNull(snsDiv)) {
        if($("#newPwd").val() == $("#pwd").val()){
            alert("<spring:message code='fail.user.passwordUpdate3' />");
            $("#newPwd").focus();
            return;
        }
    }
	var parameters = "pwd=" + $("#pwd").val();
	parameters += "&newPwd=" + $("#newPwd").val();
	parameters += "&snsDiv=" + snsDiv;

	$.ajax({
		type:"post", 
		url:"<c:url value='/web/mypage/changePw.ajax'/>",
		data:parameters,
		success:function(data){
			if(data.rtnVal == "1"){
				alert("<spring:message code='fail.user.passwordUpdate1'/>");
				$("#pwd").focus();
				return;
			}else if(data.rtnVal == "0"){
			    if(isNull(snsDiv)) {
			    	alert("비밀번호 변경이 완료됐습니다.");
			    	location.href = "<c:url value='/web/mypage/viewChangePw.do'/>";
                    //location.href = "<c:url value='/web/mypage/changePwComplet.do'/>";
                } else {
			        location.href = "<c:url value='/web/coustmer/viewInsertCorpPns.do?admMemo=ok' />";
                }
			}
		},
		error:fn_AjaxError
	});
}

function fn_OnChangeNewPw(strPw){
	var bChkPw = true;

    var stringRegx = /[%&+]/gi;

    if(stringRegx.test(strPw) == true ){
        alert("특수문자%&+는 사용하실 수 없습니다.")
        $("#newPwd").val("");
        return;
    }
	if(strPw.length == 0 ){
		$("#pwCmtFail").show();
		$("#pwCmtOk").hide();
		$("#pwCmtFail").html("&nbsp;");
		return;
	}
	if(checkIsPwMix(strPw)){
		$("#pwCmtFail").hide();
		$("#pwCmtOk").show();
		return;
	}else{
		$("#pwCmtFail").show();
		$("#pwCmtOk").hide();
		$("#pwCmtFail").html("사용불가");
		return;
	}
}

$(document).ready(function(){
    snsDiv = "${UPDATEUSERVO.snsDiv}";
    console.log(snsDiv);

    if(!isNull(snsDiv)) {
        $("#trPwd").hide();
    }

});

</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" />
</header>
<main id="main">
    <div class="mapLocation"> <!--index page에서는 삭제-->
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>마이페이지</span> <span class="gt">&gt;</span>
            <span>나의 정보</span> <span class="gt">&gt;</span>
            <span>비밀번호 변경</span>
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" />
    <!-- //quick banner -->
    <div class="subContainer">
        <div class="subHead"></div>
        <div class="subContents">
            <!-- new contents -->
            <div class="mypage sideON">
                <div class="bgWrap2">
                    <div class="inner">
                        <div class="tbWrap">
                            <jsp:include page="/web/mypage/left.do?menu=changePw" />
                            <div class="rContents smON">
                                <h3 class="mainTitle">비밀번호 변경</h3>
                                <div class="pass-wrap">
                                    <article class="info">
										<h4 class="tit">안내</h4>
										<div class="txt">
											ㆍ비밀번호는 영문, 숫자, 특수문자 조합으로 8자이상 이어야 합니다.<br>
											ㆍ특수문자 % & + 는 사용이 불가능합니다.<br>
											ㆍ개인정보 보호를 위해 최소 3개월마다 비밀번호를 변경해 주세요.
										</div>
									</article>
                                    <table class="pass">
                                        <tr id="trPwd">
                                            <th>현재 비밀번호</th>
                                            <td><input type="password" name="pwd" id="pwd" placeholder="현재 비밀번호"></td>
                                        </tr>
                                        <tr>
                                            <th>새 비밀번호</th>
                                            <td>
                                                <input type="password" name="newPwd" id="newPwd" placeholder="새 비밀번호" onkeyup="fn_OnChangeNewPw(this.value)">
                                                <p id='pwCmtFail' class='label1'>&nbsp;</p><p id='pwCmtOk' class='label2' style="display: none;">사용가능</p>
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <th>새 비밀번호 확인</th>
                                            <td><input type="password" name="newPwd_re" id="newPwd_re" placeholder="새 비밀번호 확인"></td>
                                        </tr>
                                    </table>
                                    <p class="comm-button2">
                                        <a class="color1" href="javascript:fn_ChangePw()">비밀번호변경</a>
                                    </p>
                                </div>
                            </div> <!--//rContents-->
                        </div> <!--//tbWrap-->
                    </div> <!--//inner-->
                </div> <!--//bgWrap2-->
            </div> <!-- //mypage -->
            <!-- //new contents -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>
	
<jsp:include page="/web/foot.do" />
</body>
</html>