<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?sCorpId=${corpVO.corpId}"/>
<c:set var="imgUrl" value="${pageContext.request.scheme}://${strServerName}${corpVO.adtmImg}"/>

<jsp:include page="/mw/includeJs.do" flush="false">
	<jsp:param name="title" value="${corpVO.shopNm eq null ? corpVO.corpNm : corpVO.shopNm} - 묶음배송"/>
	<jsp:param name="description" value="${corpVO.shopNm eq null ? corpVO.corpNm : corpVO.shopNm} - ${corpVO.adtmSimpleExp}"/>
	<jsp:param name="keywords" value="특산물,기념품,탐나오"/>
	<jsp:param name="headTitle" value="제주도 제주 특산 기념품"/>
</jsp:include>
<meta property="og:title" content="${corpVO.shopNm eq null ? corpVO.corpNm : corpVO.shopNm}">
<meta property="og:url" content="${strUrl}">
<meta property="og:description" content="${corpVO.shopNm eq null ? corpVO.corpNm : corpVO.shopNm} - ${corpVO.adtmSimpleExp}">
<meta property="og:image" content="${imgUrl}">

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css' />"> --%>

<script src="<c:url value='/js/jquery.bxslider.js' />"></script>
<script src="<c:url value='/js/slider.js' />"></script>
<script type="text/javascript">
	
	function fn_SvSearchNoSrc(pageIndex) {
		
		$("#searchForm input[name=pageIndex]").val(pageIndex);
		$("#curPage").text(pageIndex);
		var parameters = $("#searchForm").serialize();
	
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
	});
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" />
</header>
<!-- 헤더 e -->
<!-- 콘텐츠 s -->
<main id="main">
	<!--//change contents-->
	<div class="mw-detail2-area">
		<section class="rent-info-area from-jeju">
			<h2 class="sec-caption">업체 정보</h2>
			<section class="content-group-area box-shadow">
			  	<c:if test="${not empty corpVO.adtmImg}">
					<div class="product-ci">
						<%-- <img src="${corpVO.adtmImg}" alt="${corpVO.corpNm} ci"> --%>
					</div>
        	  	</c:if>
				<h3 class="title-type6">
				  	<c:if test="${corpVO.superbCorpYn eq 'Y'}">
						<img class="speciality" src="/images/mw/icon/speciality-detail.jpg" alt="우수관광사업체">
				  	</c:if>
					<c:out value="${corpVO.corpNm}"/>
				</h3>
				<div class="text-groupA padding-tb0">
				    <div class="social-text">
						<c:if test="${searchVO.sPrdc ne ''}">
							<p>묶음배송 가능 상품</p>
						</c:if>
	        			<p><c:out value="${corpVO.adtmSimpleExp}" escapeXml="false" /></p>
	        			<p>연락처 : <c:out value="${corpVO.rsvTelNum}"/></p>
	        		</div>
				</div>
			</section> <!-- //content-group-area -->
			
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
			<section class="social-list-area detail2">
			    <h3 class="sec-caption">업체 상품 목록</h3>
			    <ul id="div_productAjax">
			        
			    </ul>
			    <div class="paging-wrap" id="moreBtn">
				    <%-- <a href="javascript:void(0)" id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a> --%>
				    <a id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>
				</div>
			</section>
		</section> <!-- //rent-info-area -->
	</div> <!-- //mw-detail2-area -->
	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" />
<!-- 푸터 e -->
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