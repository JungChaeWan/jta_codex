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
	
	scrollTop('.rightArea', 500);
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
            <span>예약하기</span>
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
                                    <h2>결제실패 안내</h2>
                                    <!-- <p>
                                        <span><img src="../images/web/icon/pay3.jpg" height="70" alt="상품선택"></span>
                                    </p> -->
                                </div>
                                <div class="title-box">
                                    <p class="img"><img src="<c:url value='/images/web/cart/warning.jpg'/>" alt="경고"></p>
                                    <h2>“결제승인에 실패하였습니다.”</h2>
                                    <table class="commRow pay-error">
                                        <tr>
                                            <th>실패코드</th>
                                            <td><c:out value="${rtnCode}"/></td>
                                        </tr>
                                        <tr>
                                            <th>실패사유</th>
                                            <td><c:out value="${rtnMsg}"/></td>
                                        </tr>
                                    </table>
                                </div>

                                <ul class="commList1">
                                    <li>주문상세내역은 사이트상단의 <a href="<c:url value='/web/mypage/rsvList.do'/>" ><strong>마이페이지 &gt; 나의 예약/구매 내역</strong></a>에서 확인하실 수 있습니다</li>
                                    <li>주문과 관련된 문의사항이 있으신경우 <strong>고객센터</strong>를 통해 문의해 주시기 바랍니다.</li>
                                </ul>
                                
                                <!--button-->
                                <div class="comm-button2">
                                    <a href="<c:url value='/main.do'/>" class="color1">홈으로</a>
                                </div>
                            </div> <!--//comm_pay-->
                        </div> <!--//Fasten-->
                    </div> <!--//bgWrap2-->
                </div>
            <!-- //new contents -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>