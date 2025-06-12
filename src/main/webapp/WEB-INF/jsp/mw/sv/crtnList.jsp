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
<jsp:include page="/mw/includeJs.do" flush="false">
	<jsp:param name="title" value="제주 특산 기념품 목록"/>
	<jsp:param name="keywords" value="제주, 특산물, 기념품, 탐나오"/>
	<jsp:param name="description" value="탐나오 제주특산/기념품 목록"/>
</jsp:include>

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sv.css?version=${nowDate}'/>">	

<script src="<c:url value='/js/jquery.bxslider.js?version=${nowDate}' />"></script>
<script src="<c:url value='/js/slider.js?version=${nowDate}' />"></script>

<script type="text/javascript">
function fn_SvSearchNoSrc(pageIndex) {
	$("#searchForm input[name=pageIndex]").val(pageIndex);
	$("#curPage").text(pageIndex);

	//탐나는전checkbox 설정
	if (sessionStorage.getItem("tamnacardChk") == "Y"){
		$("input:checkbox[id='payCheck']").prop("checked", true);
	} else {
		$("input:checkbox[id='payCheck']").prop("checked", false);
	}

	const parameters = $("#searchForm").serialize()+"&sTamnacardYn="+sessionStorage.getItem("tamnacardChk");
	$.ajax({
		type:"post",
		url:"<c:url value='/mw/sv/productList.ajax'/>",
		data:parameters ,
		success:function(data){
			if (pageIndex == 1) {
				$("#div_productAjax").html("");
			}
			
			$("#div_productAjax").append(data);
			
			$("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));
			
			if (pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0)
				$('#moreBtn').hide();
		},
		error:function(request,status,error){
	    //    alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}

$(document).ready(function(){
	$('#moreBtnLink').click(function() {
		fn_SvSearchNoSrc(eval($("#pageIndex").val()) + 1);
	});
	
	fn_SvSearchNoSrc($("#pageIndex").val());
	
	var xCoordB = $(".scroll-area .on").offset().left;
	$('#scroll_menuB').scrollLeft(xCoordB);

	$('#payCheck').click(function (){
		//탐나는전 session 설정
		if ($("#payCheck").is(":checked") == true) {
			sessionStorage.setItem("tamnacardChk","Y");
		} else{
			sessionStorage.setItem("tamnacardChk","N");
		}

		fn_SvSearchNoSrc(1);
	});
});
</script>
</head>
<body class="svbody">
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false"></jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<main id="main">
	<div class="mw-list-area">
		<div class="menu-typeB">
			<h2 class="sec-caption">메뉴 선택</h2>
			<nav id="scroll_menuB" class="scroll-menuB">
				<div class="scroll-area">
					<ul>
					  	<c:forEach items="${crtnList }" var="crtn" varStatus="status">
							<li>
								<a href="<c:url value='/mw/sv/crtnList.do?crtnNum=${crtn.crtnNum}'/>"  <c:if test="${param.crtnNum eq crtn.crtnNum}">class="on"</c:if>>${crtn.crtnNm }</a>
							</li>
					  	</c:forEach>
					</ul>
				</div>
			</nav>
		</div>

		<!-- 0302 탐나는전 check point -->
		<div class="pay-check">
			<input type="checkbox" name="payCheck" id="payCheck">
			<label for="payCheck">
				<img src="../../images/mw/icon/form/jejupay_icon.png" alt="탐나는전">
			</label>
		</div><!-- //0352 탐나는전 check point -->

		<form action="<c:url value='/mw/sv/productList.do'/>" name="searchForm" id="searchForm" method="get">
			<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
			<input type="hidden" name="sCrtnMainYn" id="sCrtnMainYn" value="${Constant.FLAG_Y}" />
			<input type="hidden" name="sCtgr" id="sCtgr" value="" />
			<input type="hidden" name="sSubCtgr" id="sSubCtgr" value="" />
			<input type="hidden" name="sCrtnNum" id="sCrtnNum" value="${crtnInfo.crtnNum }" />
			<input type="hidden" name="orderCd" id="orderCd" value="${Constant.ORDER_GPA}" />
			<input type="hidden" name="prdtNum" id="prdtNum" />
			<input type="hidden" name="searchWord" id="searchWord" value=""/><%--통합검색 더보기를 위함 --%>
		</form>

		<section class="social-list-area add-according">
			<div class="option-area">
				<div style="height: 40px">
				</div>
			</div>
			<div class="mw-list">
				<ul id="div_productAjax">
				</ul>
			</div> <!-- //from-product-area -->
		</section> <!-- //from-list-area -->

		<div class="paging-wrap" id="moreBtn">
	    	<a href="javascript:void(0)" class="mobile" id="moreBtnLink">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>
		</div>
	</div> <!--//mw-list-area-->
	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'TNdyOePATUamc8VWDrd-ww'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>

