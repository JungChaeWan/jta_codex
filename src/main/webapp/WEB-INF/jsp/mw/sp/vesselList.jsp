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
<meta name="robots" content="noindex">

<c:set value="선박" var="ctgrNm"/>
<c:set value="선박" var="keys"/>
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="${ctgrNm} 목록"/>
	<jsp:param name="keywords" value="제주,제주도 여행,제주도 관광,탐나오,${keys}"/>
	<jsp:param name="description" value="탐나오 ${ctgrNm} 목록"/>
</jsp:include>

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>">
<link rel="canonical" href="https://www.tamnao.com/web/sp/vesselList.do">

<script src="<c:url value='/js/jquery.bxslider.js?version=${nowDate}' />"></script>
<script src="<c:url value='/js/slider.js?version=${nowDate}' />"></script>
<script type="text/javascript">
function fn_SpSearch(pageIndex){
	$("#pageIndex").val(pageIndex);
	$("#curPage").text(pageIndex);
	var parameters = $("#searchForm").serialize();

	$.ajax({
		type:"post",
		// dataType:"json",
		// async:false,
		url:"<c:url value='/mw/sp/productList.ajax'/>",
		data:parameters ,
		beforeSend:function(){
	//		$(".loading-wrap").show();
		},
		success:function(data){
	//		$(".loading-wrap").hide();
			if (pageIndex == 1){
				//$("#prdtList").html(data);
				$("#prdtList2").html(data);
				$('#moreBtn').show();
			}else{
				//$("#prdtList").append(data);
				$("#prdtList2").append(data);
			}
				
			
			$("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));
			
			if (pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0)
				$('#moreBtn').hide();

			// $("#prdtList [data-corpid]").each(function() {
			// 	if($(this).attr("data-corpid") != "CSPT190003"){
			// 		$(this).hide();
			// 	}
			// });
			$("#prdtList2 [data-corpid]").each(function() {
				if($(this).attr("data-corpid") == "CSPT190003"){
					$(this).hide();
				}
			});

		},
		error:fn_AjaxError
	});
}

function fn_MoreSearch(){
	fn_SpSearch(parseInt($("#pageIndex").val()) + 1);
}

function fn_OrderChange(){
	$("#orderCd").val($("#orderSelect>option:selected").val());

	if($("#orderSelect>option:selected").val() == '${Constant.ORDER_DIST}'){
		//alert("거리순");
		fn_ChangeOrderDist();
		return;
	}

	fn_SpSearch(1);
}


/* 거리순 */
function fn_ChangeOrderDist() {

	if(window.navigator.geolocation){
		window.navigator.geolocation.getCurrentPosition(fn_getGPS_Success, fn_getGPS_Error);
	}else{
		alert("위치 정보를 지원 하지않아 제주국제공항을 기준으로 검색 합니다.");
		fn_ChangeOrderDist_process('33.510418','126.4891594');
	}

}

function fn_getGPS_Success(pos){
	//alert(pos.coords.latitude + ":" + pos.coords.longitude);

	//pos.coords.timestamp; // 정보를 얻은 시간 (ms)
	//pos.coords.latitude; // 위도
	//pos.coords.longitude; // 경도
	//pos.coords.accuracy; // 위도, 경도 오차 (m)
	//pos.coords.altitude; // 고도
	//pos.coords.altitudeAccuracy; // 고도 오차 (m)
	//pos.coords.speed; // 진행속도 (m/s)
	//pos.coords.heading; // 정북의 시계방향 각도

	fn_ChangeOrderDist_process(pos.coords.latitude, pos.coords.longitude);
}

function fn_getGPS_Error(error ){
	//alert(code + ":" + message);
	//alert("위치 정보를 얻을수 없어 제주국제공항을 기준으로 검색 합니다.");
	var strMsg="";

	switch(error.code) {
		case error.PERMISSION_DENIED:
			strMsg = "GPS 관련 기능이 차단되 있어서";
	        break;
	    case error.POSITION_UNAVAILABLE:
	    	strMsg = "위치 정보를 찾을 수 없어";
	        break;
	    case error.TIMEOUT:
	    	strMsg = "위치 정보를 얻을 수 있는 시간이 지나서";
	        break;
	    case error.UNKNOWN_ERROR:
	    	strMsg = "위치 정보를 얻을 수 없어";
	        break;
	}
	strMsg += " 제주국제공항을 기준으로 검색 합니다.";
	alert(strMsg);
	fn_ChangeOrderDist_process('33.510418','126.4891594');
}

function fn_ChangeOrderDist_process(lon, lat) {
	$("#orderCd").val("${Constant.ORDER_DIST}");
	$("#sLON").val(lon);
	$("#sLAT").val(lat);

	fn_SpSearch(1);

}

function fn_categorySelect(o, v) {
	$('#' + o).val(v);
}

function fn_ChangeTab(carDiv, obj){
	$("#sTabCtgr").val(carDiv);
	$("#top_menu_list>li").removeClass("active");
	$(obj).parent().addClass("active");

	fn_SpSearch(1);
}

function fn_Search(){
	document.frm.action = "<c:url value='/mw/sp/spList.do'/>";
	document.frm.submit();
}

$(document).ready(function(){

	if("${searchVO.sCtgr}" != ""){
		$("#${searchVO.sCtgrTab}A").trigger("click");
	}else{
		fn_SpSearch($("#pageIndex").val());
	}

	$("#proInfo").change(function() {
		$("#sPrdtDiv").val($("#proInfo option:selected").val());
		fn_SpSearch(1);
	});
	
	$('#moreBtnLink').click(function() {
		fn_SpSearch(eval($("#pageIndex").val()) + 1);
	});

	fn_SpSearch(1);

	$('#search_btn').on('click', function() {
		if($('.con-box').css('display')=='none') {
			$(this).text('닫기');
			$('.con-box').css('display', 'block');

		}
		else {
			$(this).text('검색');
			$('.con-box').css('display', 'none');
		}
	});

	// md's pick slider
	$("#md_list").jCarouselLite({
		btnNext: "#md_sliderBTN",
		btnPrev: "",
		vertical: true,
		visible: 1,
		circular: true,
		auto: 5000,
	});
});
</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">	
	<jsp:include page="/mw/head.do" >
		<jsp:param name="headTitle" value="선박"/>
	</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<main id="main">
	<!--//change contents-->
	<div class="mw-list-area">
		<section class="menu-typeA">
			<h2 class="sec-caption">메뉴 선택</h2>
			
			<form name="searchForm" id="searchForm" method="get">
	        	<input type="hidden" name="pageIndex" 	id="pageIndex" 	value="${searchVO.pageIndex}" />
	        	<input type="hidden" name="sCtgr" 		id="sCtgr" 		value="${searchVO.sCtgr}" />
	        	<input type="hidden" name="sTabCtgr" 	id="sTabCtgr" 	value="${searchVO.sTabCtgr}" />
	        	<input type="hidden" name="sPrice" 		id="sPrice" 	value="${searchVO.sPrice}" />
	        	<input type="hidden" name="orderCd" 	id="orderCd" 	value="${searchVO.orderCd}" />
	        	<input type="hidden" name="sPrdtDiv" 	id="sPrdtDiv" 	value="${searchVO.sPrdtDiv}" />
	        	<input type="hidden" name="sAplDt" 		id="sAplDt" 	value="${searchVO.sAplDt}" />
	        	<input type="hidden" name="prdtNum" 	id="prdtNum" />
	        	<input type="hidden" name="sLON" 		id="sLON" 		value="${searchVO.sLON }" />
	        	<input type="hidden" name="sLAT" 		id="sLAT" 		value="${searchVO.sLAT }" />
				<input type="hidden" name="sSpAdar" 	id="sSpAdar" 	value="${searchVO.sSpAdar}" />
	        	<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/>
	        </form>
		</section>

<%--		<section class="vessel-list">--%>
<%--			<div class="vessel-main-banner">--%>
<%--				<img src="/images/mw/vessel/vesselMainMw.jpg" alt="선박이미지">--%>
<%--			</div>--%>


<%--			<div class="social-list-area">--%>
<%--				<h2 class="sec-caption">소셜상품 목록</h2>--%>
<%--				<ul id="prdtList">--%>

<%--				</ul>--%>
<%--			</div>--%>
<%--		</section>--%>

		<%--한일고속영역--%>
		<section class="vessel-list">
			<div class="vessel-main-banner">
				<img src="/images/mw/vessel/vesselMainMw2.jpg" alt="선박이미지">
			</div>


			<div class="social-list-area">
				<h2 class="sec-caption">소셜상품 목록</h2>
				<ul id="prdtList2">

				</ul>
			</div>
		</section>

	</div> <!--//mw-list-area-->
	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 푸터 e -->
</div>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<c:if test="${sCtgr eq 'C200' }">
<!-- 관광지/레저-->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'guZDoCqLQMK9kQ9TJmC1Vg'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
</c:if>
<c:if test="${sCtgr eq 'C200' }">
<!-- 음식/뷰티-->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'d164UG9dQ7C8vQ8lNMcIcg'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
</c:if>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>

