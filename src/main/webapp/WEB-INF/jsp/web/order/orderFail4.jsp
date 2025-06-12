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
    var new_curr_url = new URL(document.URL);
    var param = new_curr_url.searchParams.get("closeWin");
    if(param == "Y"){
        var childWindow = window.parent;
        var parentWindow = childWindow.opener;
        parentWindow.location.href ="/web/orderFail4.do";
        childWindow.close();
    }
});

</script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
    <div class="mapLocation"> <!-- index page에서는 삭제 -->
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>예약실패</span>
            <!-- <span>실시간 숙박</span> <span class="gt">&gt;</span>
            <span>숙박상세</span> -->
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" flush="false"></jsp:include>
    <!-- //quick banner -->
    <div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
            <!-- new contents -->
            <div class="pay-end">
                    <div class="bgWrap2">
                        <div class="Fasten">
                            <div class="comm_pay">
                                <div class="pay-title">
                                    <h2>예약실패 안내</h2>
                                    <!-- <p>
                                        <span><img src="../images/web/icon/pay3.jpg" height="70" alt="상품선택"></span>
                                    </p> -->
                                </div>
                                <div class="title-box">
                                    <p class="img"><img src="/images/web/cart/warning.jpg" alt="경고"></p>
                                    <h2>“주문하신 예약건이 취소 또는 정상적으로 처리되지 않았습니다.”</h2>
                                    <p>
                                        <br>홈으로 이동하여 다시 상품 예약을 진행해주세요.
                                    </p>
                                </div>
                                
                                <!--button-->
                                <div class="comm-button2">
                                    <a href="<c:url value='/main.do'/>" class="color1">홈으로</a>
                                </div>
                            </div> <!--//comm_pay-->
                        </div> <!--//Fasten-->
                    </div> <!--//bgWrap2-->
                </div> <!-- //pay-end -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>