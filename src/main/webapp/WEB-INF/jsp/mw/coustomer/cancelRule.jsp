<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
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
	<jsp:include page="/mw/includeJs.do" flush="false"></jsp:include>

	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/font-awesome/css/font-awesome.min.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_center.css'/>">
<script type="text/javascript">

</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false"></jsp:include>
	
<script type="text/javascript">
function fn_ChangeList(nIdx){
	var i=0;
	
	for ( i=1; i<=8; i++) {
		if(i==nIdx){
			$("#list"+i).show();
			$("#btnList"+i).addClass("active");
		}else{
			$("#list"+i).hide();
			$("#btnList"+i).removeClass("active");
		}
			
	}
	
}
</script>


</header>
<!-- 헤더 e -->



<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>환불/취소규정</h2>
	</div>
	<div class="sub-content">

			<p class="center-tab">
				<a href="javascript:fn_ChangeList(1)" id="btnList1" class="active">실시간 항공</a>
				<a href="javascript:fn_ChangeList(2)" id="btnList2">실시간 숙박</a>
				<a href="javascript:fn_ChangeList(3)" id="btnList3">실시간 렌터카</a>
				<a href="javascript:fn_ChangeList(4)" id="btnList4">실시간 골프</a>
				<a href="javascript:fn_ChangeList(5)" id="btnList5">관광지 입장권</a>
				<a href="javascript:fn_ChangeList(6)" id="btnList6">음식/뷰티</a>
			</p>
			<div class="center-con" id="list1">
				<dl>
					<dt>에어부산 환불규정</dt>
					<dd>발권이후~출발 3일전 : 10,000원</dd>
					<dd>출발 2일전~출발 1일전 : 15,000원</dd>
					<dd>출발 당일~출발 시간 이후 : 25,000원</dd>
				</dl>
				<dl>
					<dt>에어부산 환불규정</dt>
					<dd>발권이후~출발 3일전 : 10,000원</dd>
					<dd>출발 2일전~출발 1일전 : 15,000원</dd>
					<dd>출발 당일~출발 시간 이후 : 25,000원</dd>
				</dl>
				<dl>
					<dt>에어부산 환불규정</dt>
					<dd>발권이후~출발 3일전 : 10,000원</dd>
					<dd>출발 2일전~출발 1일전 : 15,000원</dd>
					<dd>출발 당일~출발 시간 이후 : 25,000원</dd>
				</dl>
				<dl>
					<dt>에어부산 환불규정</dt>
					<dd>발권이후~출발 3일전 : 10,000원</dd>
					<dd>출발 2일전~출발 1일전 : 15,000원</dd>
					<dd>출발 당일~출발 시간 이후 : 25,000원</dd>
				</dl>
			</div>
			
			<div class="center-con" id="list2" style="display: none;">
				<dl>
					<dt>에어부산 환불규정2</dt>
					<dd>발권이후~출발 3일전 : 10,000원</dd>
					<dd>출발 2일전~출발 1일전 : 15,000원</dd>
					<dd>출발 당일~출발 시간 이후 : 25,000원</dd>
				</dl>
			</div>
			
			<div class="center-con" id="list3" style="display: none;">
				<dl>
					<dt>에어부산 환불규정3</dt>
					<dd>발권이후~출발 3일전 : 10,000원</dd>
					<dd>출발 2일전~출발 1일전 : 15,000원</dd>
					<dd>출발 당일~출발 시간 이후 : 25,000원</dd>
				</dl>
			</div>
			
			<div class="center-con" id="list4" style="display: none;">
				<dl>
					<dt>에어부산 환불규정4</dt>
					<dd>발권이후~출발 3일전 : 10,000원</dd>
					<dd>출발 2일전~출발 1일전 : 15,000원</dd>
					<dd>출발 당일~출발 시간 이후 : 25,000원</dd>
				</dl>
			</div>
			
			<div class="center-con" id="list5" style="display: none;">
				<dl>
					<dt>에어부산 환불규정5</dt>
					<dd>발권이후~출발 3일전 : 10,000원</dd>
					<dd>출발 2일전~출발 1일전 : 15,000원</dd>
					<dd>출발 당일~출발 시간 이후 : 25,000원</dd>
				</dl>
			</div>
			
			<div class="center-con" id="list6" style="display: none;">
				<dl>
					<dt>에어부산 환불규정6</dt>
					<dd>발권이후~출발 3일전 : 10,000원</dd>
					<dd>출발 2일전~출발 1일전 : 15,000원</dd>
					<dd>출발 당일~출발 시간 이후 : 25,000원</dd>
				</dl>
			</div>
	</div>

</section>
<!-- 콘텐츠 e -->


<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>
</body>
</html>
