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

function fn_ChangePw(){
    var stringRegx = /[%&+]/gi;

    if(stringRegx.test($("#newPwd").val()) == true ){
        alert("특수문자%&+는 사용하실 수 없습니다.");
        $("#newPwd").val("");
        return;
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
	var parameters = "newPwd=" + $("#newPwd").val();
	parameters += "&userId=" + $("#userId").val();
	
	$.ajax({
		type:"post", 
		url:"<c:url value='/web/changePwd.ajax'/>",
		data:parameters ,
		success:function(data){
			alert("<spring:message code='success.common.update1' arguments='새로운 비밀번호'/>");
			location.href="<c:url value='/main.do'/>";
		},
		error:fn_AjaxError
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
            	<input type="hidden" name="userId" id="userId" value="${userVO.userId}">
                <div class="bgWrap2">
                    <div class="Fasten">
                        <div class="member-title">
                            <h2>아이디/비밀번호 찾기</h2>
                        </div>
                        <div class="idpw-ctWrap idpw-ctWrap2">
                            <!--비밀번호변경-->
                            <div class="bdWrap">
                                <h3 class="title">비밀번호 변경</h3>
                                <div class="pdWrap">
                                    <h3 class="info">본인 확인이 완료되었습니다</h3>
                                    <div class="memoWrap">
                                        <table class="tb-pw2">
                                            <tr class="password">
                                                <th>새 비밀번호</th>
                                                <td><input class="full" type="password" name="newPwd" id="newPwd" placeholder="영문, 숫자, 특수문자 조합의 8~20자리입니다."></td>
                                            </tr>
                                            <tr class="password2">
                                                <th>새 비밀번호 확인</th>
                                                <td><input class="full" type="password" name="newPwd_re" id="newPwd_re" placeholder="특수문자 %&+ 는 사용할 수 없습니다."></td>
                                            </tr>                                            
                                        </table>
                                    </div>
                                    <div class="smBT">
                                        <button class="comm-arrowBT" type="submit" onclick="javascript:fn_ChangePw();">비밀번호 변경</button>
                                    </div>
                                </div>
                            </div>
                        </div> <!--//idpw-ctWrap-->
                    </div>
                </div>
            </div> <!-- //user-idpw -->
            <!-- //new contents -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>