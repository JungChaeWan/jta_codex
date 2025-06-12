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
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="렌터카 목록"/>
	<jsp:param name="keywords" value="제주, 제주도 여행, 제주도 관광, 렌터카, 실시간 예약, 탐나오"/>
	<jsp:param name="description" value="탐나오 렌터카 목록"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css' />">

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>

<script type="text/javascript">

function fn_RcSearch(pageIndex){
	$("#pageIndex").val(pageIndex);
	$("#curPage").text(pageIndex);
	var parameters = $("#frm").serialize();

	$.ajax({
		type:"post",
		// dataType:"json",
		// async:false,
		url:"<c:url value='/mw/rc/corpList.ajax'/>",
		data:parameters ,
		beforeSend:function(){
			if (pageIndex == 1) {
				$("#prdtDiv").html("");
			}			
			$(".loading-wrap").show();
		},
		success:function(data){
			$(".loading-wrap").hide();
			$("#prdtDiv").append(data);
			
			$("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));
			
			if (pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0)
				$('#moreBtn').hide();
		},
		error:fn_AjaxError
	});
}

function fn_ClickSearchPage(pageIndex){

	$("#pageIndex").val(pageIndex);
	$("#mYn").val("");
	// $("#sCarDivCdView").val("");
	$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
//	$("#sFromTm").val($("#vFromTm").val());
	$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
//	$("#sToTm").val($("#vToTm").val());
//	$("#sCarDivCd").val($("input:radio[name=vCarDivCd]:checked").val());
	$("#sCorpId").val($("select[name=vCorpId] option:selected").val());
	$("#sIsrDiv").val($("select[name=vIsrDiv] option:selected").val());

	document.frm.action = "<c:url value='/mw/rentcar/car-list.do'/>";
	document.frm.submit();

}

function fn_DetailPrdt(prdtNum){
	$("#prdtNum").val(prdtNum);
	document.frm.action = "<c:url value='/mw/rentcar/car-detail.do'/>";
	document.frm.target = "_blank";
	document.frm.submit();
}

$(document).ready(function(){
	$(function() {
        
    });

	fn_RcSearch($("#pageIndex").val());
	
	$('#moreBtnLink').click(function() {
		fn_RcSearch(eval($("#pageIndex").val()) + 1);
	});	
});
</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<main id="main">
	<!--//change contents-->
	<div class="mw-detail2-area">
		<form name="frm" id="frm" method="get" onSubmit="return false;">
			<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
			<input type="hidden" name="sCarDivCdView" id="sCarDivCdView" value="${searchVO.sCarDivCdView}" />
			<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
			<input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />
			<input type="hidden" name="mYn" id="mYn" value="${searchVO.mYn}" />
			<input type="hidden" name="searchYn" id="searchYn" value="${Constant.FLAG_N}" />
			<input type="hidden" name="prdtNum" id="prdtNum" />
			<input type="hidden" name="sIsrDiv" id="sIsrDiv" value="${searchVO.sIsrDiv}" />	<!-- 보험여부 -->
			<input type="hidden" name="sCorpId" id="sCorpId" value="${searchVO.sCorpId}" /> <!-- 렌터카회사 -->				
			<input type="hidden" name="sCarDivCd" id="sCarDivCd" value="${searchVO.sCarDivCd}" /> <!-- 차량 유형 검색 -->	
			<input type="hidden" name="sMakerDivCd" id="sMakerDivCd" value="${searchVO.sMakerDivCd}" /> <!-- 제조사 검색 -->
			<input type="hidden" name="sUseFuelDiv" id="sUseFuelDiv" value="${searchVO.sUseFuelDiv}" /> <!-- 사용연료 검색 -->
			<input type="hidden" name="sModelYear" id="sModelYear" value="${searchVO.sModelYear}" /> <!-- 연식 검색 -->
        	<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}" />
			<input type="hidden" name="sFromDtView" id="sFromDtView" value="${searchVO.sFromDtView}" />					                              
			<input type="hidden" name="sFromTm" id="sFromTm" value="${searchVO.sFromTm}" />					                                	
			<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}" />
			<input type="hidden" name="sToDtView" id="sToDtView" value="${searchVO.sToDtView}" />					                                
			<input type="hidden" name="sToTm" id="sToTm" value="${searchVO.sToTm}" />
		</form>
			
		<section class="rent-info-area">
			<h2 class="sec-caption">업체 정보</h2>
			
			<section class="content-group-area box-shadow">
				<h3 class="title-type6"><c:out value="${corpVO.corpNm}"/></h3>
				<div class="text-groupA padding-tb0">
				    <dl>
						<dt class="title-type3">셔틀버스</dt>
						<dd class="type-body1">
							제주공항 도착 게이트 5번 건너편 (구)렌트카하우스
							<strong class="text-red"><c:out value="${rcDftInfo.shutZone1}"/>구역 <c:out value="${rcDftInfo.shutZone2}"/>번</strong>
						</dd>
					</dl>
					<div class="inline-typeA margin-top15">
						<dl>
							<dt>운행간격</dt>
							<dd><c:out value="${rcDftInfo.shutRunInter}"/>분</dd>
						</dl>
						<dl>
							<dt>소요시간</dt>
							<dd><c:out value="${rcDftInfo.shutCostTm}"/>분</dd>
						</dl>
					</div>
					<dl>
						<dt class="title-type3">차량 인수/반납 위치</dt>
						<dd class="type-body1">
							<div class="map-area rent" id="sighMap"></div>
							<script type="text/javascript">
								//동적 지도 ( 움직이는 지도.)
								var container2 = document.getElementById('sighMap');
								var options2 = {
									center: new daum.maps.LatLng(${rcDftInfo.tkovLat}, ${rcDftInfo.tkovLon}),
									//center: new daum.maps.LatLng(33.4888341, 126.49807970000006),
									level: 4
								};

								var map2 = new daum.maps.Map(container2, options2);

								// 현재 위치.
								//마커가 표시될 위치입니다
								var c_markerPosition  = new daum.maps.LatLng(${rcDftInfo.tkovLat}, ${rcDftInfo.tkovLon});
								//var c_markerPosition  = new daum.maps.LatLng(33.4888341, 126.49807970000006);
								var c_imageSrc = "<c:url value='/images/web/icon/location_my.png'/>";
								var c_imageSize = new daum.maps.Size(24, 35);
								var c_markerImage = new daum.maps.MarkerImage(c_imageSrc, c_imageSize);
								// 마커를 생성합니다
								var marker = new daum.maps.Marker({
									map : map2,
									position: c_markerPosition,
									image : c_markerImage,
									clickable: true
								});


								var c_content = '<p class="point-info">' +
												'<strong>${corpVO.corpNm}</strong>'+
												'<span class="addr">${rcDftInfo.tkovRoadNmAddr} ${rcDftInfo.tkovDtlAddr}</span>' +
												'<a href="javascript:c_closeOverlay();" class="btn-close"><img src="<c:url value="/images/mw/sub/b_box_close.png"/>" width="12" alt="닫기" /></a>' +
												'</p>';
								var overlay = new daum.maps.CustomOverlay({
									content:c_content,
									position:c_markerPosition,
									map : map2
								});

								daum.maps.event.addListener(marker, 'click', function() {
									overlay.setMap(map2);
								});

								function c_closeOverlay() {
									overlay.setMap(null);
								}
								</script>
							<div class="map-text-info">
								<p>주소 : <c:out value="${rcDftInfo.tkovRoadNmAddr}"/> <c:out value="${rcDftInfo.tkovDtlAddr}"/></p>
								<p>전화번호 : <c:out value="${corpVO.rsvTelNum}"/></p>
							</div>
						</dd>
					</dl>
				</div>
			</section> <!-- //content-group-area -->
			
			<section class="social-list-area detail2">
			    <h3 class="sec-caption">렌터가 업체 상품 목록</h3>
			    <ul id="prdtDiv">			        
			    </ul>
			    <div class="paging-wrap" id="moreBtn">
				    <a href="javascript:void(0)" id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>
				</div>
			</section>
		</section> <!-- //rent-info-area -->
	</div> <!-- //mw-detail2-area -->
	<!--//change contents-->
</main>

<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 푸터 e -->
</div>
</body>
</html>
