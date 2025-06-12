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

<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>

<script src="<c:url value='/js/freewall.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/multiple-select.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/air_step1.js'/>"></script>
<!-- main add -->
<script type="text/javascript" src="<c:url value='/js/cycle.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/freewall.js'/>"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/main4.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/layerPopup.css'/>" />


<script>



/* iframeWin.addEventListener('resize', function(){
	console.log("ccc");
}); */

	$(document).ready(function() {
		//관련기관 배너 (4개 이상시 롤링)
		if($('#foot_organBanner ul li').length > 6) {
    		var swiper = new Swiper('#foot_organBanner', {
    	        slidesPerView: 6,
    	        spaceBetween: 9,
    	        paginationClickable: true,
    	        nextButton: '#foot_organNext',
    	        prevButton: '#foot_organPrev',
    	        autoplay: 5000,
    	        loop: true
    	    });
		}
		else {
			$('#foot_organArrow').hide();
		}

	});
</script>


<script type="text/javascript">


	
$(document).ready(function(){
	setInterval(function(){ heightResize() }, 200);
});

function heightResize(){
	var the_height = $("#ifrView").contents().find("body").height();
	$(".subContents").css("height",the_height+"px")
}

</script>
</head>
<body>

<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
   <div class="mapLocation">
	    <div class="inner">
	        <span>홈</span> <span class="gt">&gt;</span>
	        <span>황금빛 가을제주</span>
	    </div>
	</div>
	
	<div class="subContainer">
	    <div class="subHead"></div>
	    <div class="subContents">
	    <iframe id="ifrView" src="/web/grandSale/2018.do" scrolling="no" style="top:0;left: 0;width:100%;height: 100%; position: absolute; border: none" onLoad="heightResize();" ></iframe>
	    </div>
    </div>
</main>

<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>

</body>
</html>