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

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css' />">
</head>
<script type="text/javascript">
function fn_logout() {
	if(confirm("<spring:message code='common.logout.confirm' />")) {
		var addParam = "";
		if(fn_AppCheck() == "IA"||fn_AppCheck() == "AA") {
			addParam = "?app_id_del=ok";
		}
		location.href = "<c:url value='/mw/logout.do" + addParam + "'/>";
	}
}

function fn_CouponRegPop() {
	$.ajax({
		type: "post",
		data: "isMobile=Y",
		url : "<c:url value='/web/point/couponRegPop.do'/>",
		success: function (data) {
			$(".couponRegPop_2").html(data);
			show_popup($(".couponRegPop_2"));
		},
		error  : fn_AjaxError
	});
}

function fn_PointHistoryPop() {
	$.ajax({
		type: "post",
		data: "isMobile=Y",
		url : "<c:url value='/web/point/pointHistoryPop.do'/>",
		success: function (data) {
			$(".couponRegPop_1").html(data);
			show_popup($(".couponRegPop_1"));
		},
		error  : fn_AjaxError
	});
}
</script>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="마이탐나오"/>
	</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<main id="main">
	<!--//change contents-->
	<div class="mypage-area">
		<div class="mypage-main">
			<div class="page-header-wrap"></div>
				<div class="page-header">
					<ul>
						<li>
							<b>${userNm}</b>님 환영합니다.</li>
						<li><a href="<c:url value='/mw/mypage/viewUpdateUser.do?type=user' />">정보수정</a></li>
					</ul>
				</div>
				<div class="page-main-menu">
					<ul>
						<li class="my-re"><a href="<c:url value='/mw/mypage/rsvList.do?type=rsv'/>">나의 예약/구매 내역</a></li>
						<li class="my-write"><a href="<c:url value='/mw/coustomer/viewInsertUseepil.do'/>">이용후기 쓰기</a></li>
					</ul>

					<!-- 이용후기 프로모션 배너 -->

					<div class="point-line-banner">
						<a href="https://m.site.naver.com/1CMAR">
							<div class="line-banner">
								<img class="point-pic" src="/images/mw/sitemap/mypage_point.png" alt="상품 이용후기 네이버페이 지급">
								<em>상품 이용 후 후기를 작성하면 네이버페이 1,000P!</em>
							</div>
						</a>
					</div>
				</div>
			</div>
			<div class="page-menu">
				<ul class="depth2">
					<c:if test="${ssPartnerCode ne '' && isLogin == 'Y'}">
							<!-- 포인트 등록 -->
							<a class="point-registration">
								<div href="javascript:void(0)" onclick="fn_CouponRegPop();" class="point-registration title">
									<img src="/images/mw/sitemap/coupon-point.png" alt="포인트 등록">포인트 등록
								</div>
							</a>
	
							<!-- 포인트 내역/레이어 팝업 -->
							<div class="couponRegPop_1 pop-seller"></div>
							<ul class="coupon-current depth3">
								<li>
									<a href="javascript:void(0)" onclick="fn_PointHistoryPop();" class="coupon-current title">
										<div class="current-situation">포인트 내역</div>
										<div class="exposure-point"><fmt:formatNumber>${myPoint.ablePoint}</fmt:formatNumber></div>
									</a>
								</li>
							</ul>
	
							<!-- 포인트 등록/레이어 팝업 -->
							<div class="couponRegPop_2 pop-seller2"></div>
						</li>
					</c:if>
				    <li>
				        <a href="<c:url value='/mw/mypage/couponList.do?type=coupon'/>">
							나의 혜택정보
						</a>
				        <ul class="depth3">
				            <li><a href="<c:url value='/mw/mypage/couponList.do?type=coupon'/>">탐나오쿠폰 내역보기</a></li>
				            <%--<li><a href="<c:url value='/mw/mypage/freeCouponList.do?type=free'/>">할인쿠폰 보관함</a></li>--%>
				        </ul>
				    </li>
				    <li>
				        <a href="<c:url value='/mw/mypage/otoinqList.do?type=otoinq'/>">
							나의 게시글 모음
						</a>
				        <ul class="depth3">
				            <li><a href="<c:url value='/mw/mypage/otoinqList.do?type=otoinq'/>">1:1 문의내역</a></li>
				            <li><a href="<c:url value='/mw/mypage/useepilList.do?type=useepil'/>">이용후기 내역</a></li>
				        </ul>
				    </li>
				    <li>
						<a href="<c:url value='/mw/mypage/viewUpdateUser.do?type=update'/>">
							나의 정보
						</a>
						<ul class="depth3">
							<li><a href="<c:url value='/mw/mypage/viewUpdateUser.do?type=update'/>">개인정보수정</a></li>
							<c:if test="${!empty pwd}">
								<li><a href="<c:url value='/mw/mypage/viewChangePw.do?type=pw'/>">비밀번호변경</a></li>
							</c:if>
							<li><a href="<c:url value='/mw/mypage/viewRefundAccNum.do?type=refund'/>">환불계좌관리</a></li>
							<li><a href="<c:url value='/mw/mypage/viewDropUser.do?type=drop'/>">회원탈퇴</a></li>
							<li><a class="site-log-out" href="javascript:fn_logout();">로그아웃</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div> <!-- //mypage-main -->
	</div> <!-- //mypage-area -->
	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>