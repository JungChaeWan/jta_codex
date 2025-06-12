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

<head>
<meta name="robots" content="noindex">
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?sCorpId=${corpVO.corpId}"/>
<c:set var="imgUrl" value="${pageContext.request.scheme}://${strServerName}${corpVO.adtmImg}"/>

<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="${corpVO.shopNm eq null ? corpVO.corpNm : corpVO.shopNm} - 묶음배송"/>
	<jsp:param name="description" value="${corpVO.shopNm eq null ? corpVO.corpNm : corpVO.shopNm} - ${corpVO.adtmSimpleExp}"/>
	<jsp:param name="keywords" value="특산물,기념품,탐나오"/>
	<jsp:param name="headTitle" value="제주도 제주 특산 기념품"/>
</jsp:include>
<meta property="og:title" content="${corpVO.shopNm eq null ? corpVO.corpNm : corpVO.shopNm}">
<meta property="og:url" content="${strUrl}">
<meta property="og:description" content="${corpVO.shopNm eq null ? corpVO.corpNm : corpVO.shopNm} - ${corpVO.adtmSimpleExp}">
<meta property="og:image" content="${imgUrl}">

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sv.css'/>" />
<script type="text/javascript">
	
	function fn_SvSearchNoSrc(pageIndex) {
		
		$("#searchForm input[name=pageIndex]").val(pageIndex);
		$("#curPage").text(pageIndex);
		var parameters = $("#searchForm").serialize();
		$.ajax({
			type:"post",
			url:"<c:url value='/web/sv/productList.ajax'/>",
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
	});
</script>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
	<div class="mapLocation">
	    <div class="inner">
	        <span>홈</span>
	        <span class="gt">&gt;</span>
	        <span>from jeju</span>
	    </div>
	</div>

	<!-- Change Contents -->
	<div class="socialTx">
		<div class="inner">
			<c:if test="${!(empty corpVO.adtmImg)}">
			<div class="product-ci">
				<img src="${corpVO.adtmImg}" alt="ci" onerror="this.src='/images/web/other/no-image.jpg'">
			</div>
			</c:if>
			<div class="social-title">
			  <c:if test="${corpVO.superbCorpYn eq 'Y'}">
				<img class="excellence" src="<c:url value='/images/web/icon/excellence_02.jpg'/>" alt="우수관광사업체">
			  </c:if>
				<c:out value="${corpVO.corpNm}"/>
			</div>
			<div class="social-memo">
				<c:if test="${searchVO.sPrdc ne ''}">
					<p>묶음배송 가능 상품</p>
				</c:if>
				<p><c:out value="${corpVO.adtmSimpleExp}" escapeXml="false" /></p>
				<p>연락처 : <c:out value="${corpVO.rsvTelNum}"/></p>
			</div>
		</div>
	</div>

	<!-- 상품 목록 -->
	<form action="<c:url value='/web/sv/productList.do'/>" name="searchForm" id="searchForm" method="get">
		<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
		<input type="hidden" name="sCtgr" id="sCtgr" value="" />
		<input type="hidden" name="sSubCtgr" id="sSubCtgr" value="" />
		<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}" /> <!-- 제주특산/기념품 업체 -->
		<input type="hidden" name="sCrtnNum" id="sCrtnNum" value="" />
		<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
		<input type="hidden" name="prdtNum" id="prdtNum" />
		<input type="hidden" name="searchWord" id="searchWord" value=""/><%--통합검색 더보기를 위함 --%>
		<input type="hidden" name="sPrdc" id="sPrdc" value="${searchVO.sPrdc}" />
	</form>
	<!-- 상품 목록 -->
	<div class="socialItem">
		<h2 class="sec-caption">특산품 목록</h2>
		<div class="inner">
			<div class="item-area svGroup">
				<ul class="col4" id="div_productAjax">
				</ul>
			</div> <!-- //item-area -->

			<div class="paging-wrap" id="moreBtn">
				<%-- <a href="javascript:void(0)" id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a> --%>
				<a id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>
			</div>
		</div>
	</div>
	<!-- //Change Contents -->
</main>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
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