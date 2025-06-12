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
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<script type="text/javascript" src="<c:url value='/js/printThis.js?version=${nowDate}'/>"></script>
 


<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


<script type="text/javascript">

function sendFreeCoupon(prdtNum) {
	var email = "${loginVO.email}";
	
	$.ajax({
		url: "<c:url value='/web/sp/freeCouponMail.ajax'/>",
		data: "prdtNum=" + prdtNum + "&email="+email,
		success:function(data) {
			alert("이메일을 성공적으로 보냈습니다.");
		},
		error : fn_AjaxError
	});	 
}

function deleteFreeCoupon(prdtNum) {
	if(confirm("<spring:message code='common.delete.msg'/>")) {
		$.ajax({
			url: "<c:url value='/web/mypage/deleteFreeCoupon.ajax'/>",
			data: "itrPrdtNum=" + prdtNum,
			success:function(data) {
				location.reload(true);
			},
			error : fn_AjaxError
		});	 
	}
}

function printFreeCoupon(prdtNum) {
	
	$("#" + prdtNum + "_coupon").printThis({
		importCSS:true,
	});	
}
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
                <span>마이페이지</span> <span class="gt">&gt;</span>
                <span>나의 혜택정보</span> <span class="gt">&gt;</span>
                <span>할인쿠폰 보관함</span>
            </div>
        </div>
        <!-- quick banner -->
   		<jsp:include page="/web/left.do" flush="false"></jsp:include>
        <!-- //quick banner -->
        <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">
                <!-- new contents -->
                <div class="mypage sideON">
                    <div class="bgWrap2">
                        <div class="inner">
                            <div class="tbWrap">
                            	<jsp:include page="/web/mypage/left.do?menu=freeCoupon" flush="false"></jsp:include>
                                
                                <div class="rContents smON">
                                    <h3 class="mainTitle">할인쿠폰 보관함</h3>
                                    <div class="pointInfo">
                                        <p class="main"><img src="<c:url value='/images/web/mypage/sale.png'/>" alt="p"> ${loginVO.userNm}님의 보유 할인쿠폰<strong> <c:out value="${totalCnt}"/></strong><span>장</span></p>
                                    </div>
                                    <div class="sale_coupon">
                                   	<c:forEach items="${resultList}" var="freeCoupon">
									<ul class="sale-couponWrap2">
                                       	<li>
                                       		<div class="coupon__info" id="${freeCoupon.prdtNum}_coupon">
                                       			<div class="coupon-info--point">
													<h3 class="info--title"><c:out value="${freeCoupon.prdtNm}"/></h3>
                                                </div>
                                                <div class="coupon-info--artcle">
                                                    <p class="info--sale"><c:out value="${freeCoupon.disInf}"/></p>
                                                    <p class="info--date">
                                                        <fmt:parseDate value="${freeCoupon.exprStartDt}" var="exprStartDt"	pattern="yyyyMMdd" />
                                                        <fmt:parseDate value="${freeCoupon.exprEndDt}" var="exprEndDt" pattern="yyyyMMdd" />
                                                        <fmt:formatDate value="${exprStartDt}" pattern="yyyy.MM.dd" />~<fmt:formatDate value="${exprEndDt}" pattern="yyyy.MM.dd" />
                                                    </p>
                                                </div>
                                       		</div>
                                            <div class="button">
                                                <p><a class="bt1" href="javascript:sendFreeCoupon('${freeCoupon.prdtNum}');">이메일 받기</a></p>
                                                <p><a class="bt3" href="javascript:deleteFreeCoupon('${freeCoupon.prdtNum}');">삭제하기</a></p>
                                            </div>
                                       	</li> 
									</ul>
									</c:forEach>
                                    <c:if test="${fn:length(resultList)==0}">
                                    <p class="no-content2">할인쿠폰 내역이 없습니다.</p>
                                    </c:if>
                                 	</div>
                                </div> <!--//rContents-->
                            </div> <!--//tbWrap-->
                        </div> <!--//Fasten-->
                    </div> <!--//bgWrap2-->
                </div> <!-- //mypage2_2 -->
                <!-- //new contents -->
            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>
	
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>