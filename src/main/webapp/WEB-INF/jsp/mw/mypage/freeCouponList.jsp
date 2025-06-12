<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex, nofollow">
<jsp:include page="/mw/includeJs.do"></jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/bootstrap/css/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_mypage.css'/>">

<script type="text/javascript">
function sendFreeCoupon() {
	var email = $("#receiver").val();
	if(email == "") {
		alert("이메일을 입력해 주세요.");
		return false;
	}
	if(!fn_is_email(email)) {
		alert("이메일 형식이 맞지 않습니다.");
		return false;
	}
	var parameters = "prdtNum=${prdtInfo.prdtNum}&email=" + email;

	$.ajax({
		url: "<c:url value='/mw/sp/freeCouponMail.ajax'/>",
		data: parameters,
		success:function(data) {
			alert("이메일을 성공적으로 보냈습니다.");
			closeSendEmail();
			$("#receiver").val("");
		},
		error: fn_AjaxError
	});
}

function closeSendEmail() {
	$('.pop-seller, #cover').fadeToggle();
}

</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="할인쿠폰 보관함"/>
	</jsp:include>
</header>
<!-- 헤더 e -->
<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent" class="subContent-bg">
	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>할인쿠폰 보관함</h2>
	</div>
	<div class="sub-content sub-top">
		<div class="mypage">
			<c:if test="${fn:length(resultList) == 0}">
				<div class="not-content">
					<p class="icon"><img src="<c:url value='/images/mw/other/no_item.png' />" alt="warning"></p>
					<p class="text">할인쿠폰 내역이 없습니다.</p>
				</div>
			</c:if>
			<ul>
				<c:forEach items="${resultList}" var="freeCoupon">
					<li class="coupon-all-line">
						<%--<h2><c:out value="${freeCoupon.prdtNm}"/></h2>--%>
						<div class="coupon-img">
							<div class="sale-couponWrap2 sub-couponWrap2">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr class="coupon_all">
										<td class="text">
											<h3 class="sale"><c:out value="${freeCoupon.disInf}"/></h3>
											<p class="name"><c:out value="${freeCoupon.prdtNm}"/></p>
											<p class="date">
												<fmt:parseDate value="${freeCoupon.exprStartDt}" var="exprStartDt"	pattern="yyyyMMdd" />
												<fmt:parseDate value="${freeCoupon.exprEndDt}" var="exprEndDt" pattern="yyyyMMdd" />
												유효기간 : <fmt:formatDate value="${exprStartDt}" pattern="yyyy.MM.dd" /> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy.MM.dd" />
											</p>
										</td>
										<td>
											<div class="coupon-save-btn">
												<a class="view-seller">이메일로 받기</a>
											</div>
										</td>
								  	</tr>
								</table>
							</div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</section>

<!--이메일받기폼-->
<div class="pop-seller">
	<h2>이메일로 받기</h2>
	<div class="ticket-mail">
		<table class="commRow">
			<tbody>
			<tr>
				<th>받는메일</th>
				<td><input type="text" id="receiver" class="full" placeholder="이메일 주소 입력"></td>
			</tr>
			</tbody>
		</table>
		<p class="comm-button1">
			<a href="javascript:sendFreeCoupon();" class="btn btn1">보내기</a>
			<a href="javascript:closeSendEmail()" class="btn btn5">취소</a>
		</p>
	</div>
</div>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>
			
			