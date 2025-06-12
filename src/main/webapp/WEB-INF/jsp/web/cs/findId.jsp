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
                <div class="bgWrap2">
                    <div class="Fasten">
                        <div class="member-title">
                            <h2>아이디/비밀번호 찾기</h2>
                        </div>
                        <div class="idpw-ctWrap idpw-ctWrap2">
                            <!--아이디찾기완료-->
                            <div class="bdWrap">
                                <h3 class="title">아이디 찾기 완료</h3>
                                <div class="pdWrap">
                                    <h3 class="info">아이디 정보는 아래와 같습니다</h3>
                                    <div class="memoWrap">
                                    	<c:forEach items="${userVOList}" var="user" varStatus="status">
                                    		<p class="confMemo">아이디 : <strong><c:out value="${user.email}"/></strong></p>
                                    	</c:forEach>
                                    </div>
                                    <!-- <p class="caution">※ 개인정보보호를 위해 아이디 뒷자리는 **로 표시 합니다.</p> -->
                                    <div class="smBT">
                                        <a class="select" href="<c:url value='/web/viewLogin.do?rtnUrl=/main.do'/>">로그인</a>
                                        <a href="<c:url value='/web/viewFindIdPwd.do'/>">비밀번호 찾기</a>
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