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
<jsp:include page="/mw/includeJs.do" flush="false">
	<jsp:param name="title" value="제주여행 공공플랫폼 핫플레이스 지도검색, 탐나오"/>
	<jsp:param name="description" value="제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다. 제주여행공공플랫폼 탐나오."/>
	<jsp:param name="keywords" value="제주관광지,제주도관광지,제주여행,제주도여행,제주핫플,지도검색"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 핫플레이스 지도검색, 탐나오">
<meta property="og:url" content="https://www.tamnao.com/mw/mapSp.do?ctgr=C200">
<meta property="og:description" content="제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다. 제주여행공공플랫폼 탐나오.">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/daterangepicker.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css' />">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/ad.css' />"> --%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>
</head>
<body>
<div id="wrap">

	<header id="header">
		<div class="head-wrap">
			<h2 class="title">지도검색</h2>
			<div class="l-area">
				<a href="javascript:history.back()" class="back" title="뒤로가기"></a>
			</div>
		</div>
	</header>

	<!-- change contents -->
	<main id="main" class="map-wrap">

		<!-- 관광지·레저 유형별 선택 -->
		<section class="map-check sp-category">
			<ul class="map-check-inner">
				<li>
					<button class="cate" data-tab="C210">
						<svg class="ico6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 57.41 56.51">
							<g class="category-svg">
								<rect x="0.67" y="54.01" width="7.13" height="2.5"/>
								<rect x="2.98" y="31.52" width="2.5" height="23.74"/>
								<path d="M4.23,29.94a4.23,4.23,0,1,1,4.23-4.23A4.24,4.24,0,0,1,4.23,29.94Zm0-6A1.73,1.73,0,1,0,6,25.71,1.73,1.73,0,0,0,4.23,24Z"/>
								<rect x="9.57" y="23" width="2.5" height="16.14"/>
								<path d="M10.82,21.05a3.69,3.69,0,1,1,3.68-3.68A3.69,3.69,0,0,1,10.82,21.05Zm0-4.87A1.19,1.19,0,1,0,12,17.37,1.19,1.19,0,0,0,10.82,16.18Z"/>
								<rect x="16.69" y="15.91" width="2.5" height="10.32"/>
								<path d="M17.94,14a3.69,3.69,0,1,1,3.68-3.68A3.69,3.69,0,0,1,17.94,14Zm0-4.87a1.19,1.19,0,1,0,1.18,1.19A1.19,1.19,0,0,0,17.94,9.09Z"/>
								<rect x="49.62" y="54.01" width="7.13" height="2.5"/>
								<rect x="51.93" y="31.52" width="2.5" height="23.74"/>
								<path d="M53.18,29.94a4.23,4.23,0,1,1,4.23-4.23A4.24,4.24,0,0,1,53.18,29.94Zm0-6a1.73,1.73,0,1,0,1.73,1.73A1.73,1.73,0,0,0,53.18,24Z"/>
								<rect x="45.35" y="23" width="2.5" height="16.14"/>
								<path d="M46.6,21.05a3.69,3.69,0,1,1,3.68-3.68A3.69,3.69,0,0,1,46.6,21.05Zm0-4.87a1.19,1.19,0,1,0,1.18,1.19A1.19,1.19,0,0,0,46.6,16.18Z"/>
								<rect x="38.23" y="15.91" width="2.5" height="10.32"/>
								<path d="M39.48,14a3.69,3.69,0,1,1,3.68-3.68A3.69,3.69,0,0,1,39.48,14Zm0-4.87a1.19,1.19,0,1,0,1.18,1.19A1.19,1.19,0,0,0,39.48,9.09Z"/>
								<polygon points="9.03 44.96 6.84 43.76 21.18 17.77 36.24 17.77 50.53 43.67 48.34 44.87 34.76 20.27 22.65 20.27 9.03 44.96"/>
								<rect x="10.77" y="54.01" width="35.83" height="2.5"/>
								<path d="M34.4,20.1H23V0H34.4Zm-8.93-2.5H31.9V2.5H25.47Z"/>
							</g>
						</svg>
						전시박물관
					</button>
				</li>
				<li>
					<button class="cate" data-tab="C220">
						<svg class="ico7" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 45.14 29.28">
							<g class="category-svg">
								<path d="M16.82,29.28a15.17,15.17,0,0,1-7.38-1.77,14.7,14.7,0,0,1-6.89-8.64c-.36-1-3.76-11.4,8.14-16.41,6.4-2.69,10.17-.9,13.5.68,2.25,1.06,4.37,2.07,7.24,1.74,9-1,11.8-4.42,11.82-4.46A1,1,0,0,1,45.14,1c0,.19.07,19.82-19.6,26.6A27,27,0,0,1,16.82,29.28ZM4.57,18.3a12.78,12.78,0,0,0,5.89,7.38c3.71,2,8.55,2,14.39,0a26.13,26.13,0,0,0,18-22.23C41,4.7,37.49,6.3,31.67,7c-3.47.39-6-.79-8.38-1.93C20.08,3.51,17,2.07,11.5,4.4.94,8.84,4.37,17.79,4.52,18.17A.69.69,0,0,1,4.57,18.3Z"/>
								<path d="M2.61,28.22a1,1,0,0,1-.87-.47c-1.51-2.27-3.3-7.46.67-10.84A1.06,1.06,0,0,1,3.89,17a1,1,0,0,1-.12,1.48c-3.54,3-.41,7.88-.28,8.08a1,1,0,0,1-.3,1.46A1.12,1.12,0,0,1,2.61,28.22Z"/>
								<path d="M3.1,18.45a1.06,1.06,0,0,1-.75-.32,1,1,0,0,1,0-1.48c.31-.3,7.7-7.37,16.24-4.64A1,1,0,0,1,18,14C10.65,11.67,3.9,18.09,3.83,18.15A1,1,0,0,1,3.1,18.45Z"/>
							</g>
						</svg>
						테마공원
					</button>
				</li>
				<li>
					<button class="cate" data-tab="C250">
						<svg class="ico8" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 51.55 51.75">
							<g class="category-svg">
								<path d="M21.91,51.75a21.91,21.91,0,1,1,21.9-21.91A21.94,21.94,0,0,1,21.91,51.75Zm0-41.61a19.71,19.71,0,1,0,19.7,19.7A19.73,19.73,0,0,0,21.91,10.14Z"/>
								<path d="M21.91,43.61A13.77,13.77,0,1,1,35.67,29.84,13.79,13.79,0,0,1,21.91,43.61Zm0-25.33A11.57,11.57,0,1,0,33.47,29.84,11.58,11.58,0,0,0,21.91,18.28Z"/>
								<path d="M21.91,36.13a6.29,6.29,0,1,1,6.29-6.29A6.3,6.3,0,0,1,21.91,36.13Zm0-10.38A4.09,4.09,0,1,0,26,29.84,4.1,4.1,0,0,0,21.91,25.75Z"/>
								<path d="M22.1,30.56a1.07,1.07,0,0,1-.78-.33,1.09,1.09,0,0,1,0-1.55l22-22a1.1,1.1,0,1,1,1.56,1.55l-22,22A1.06,1.06,0,0,1,22.1,30.56Z"/>
								<path d="M43.88,15.06H37.59a1.1,1.1,0,0,1-1.1-1.1V7.67a1.14,1.14,0,0,1,.32-.78L43.39.32a1.09,1.09,0,0,1,1.87.78V6.29h5.19a1.1,1.1,0,0,1,.78,1.88l-6.57,6.57A1.14,1.14,0,0,1,43.88,15.06Zm-5.19-2.2h4.74l4.36-4.37H44.16a1.1,1.1,0,0,1-1.1-1.1V3.76L38.69,8.13Z"/>
							</g>
						</svg>
						스포츠/레저
					</button>
				</li>
				<li>
					<button class="cate" data-tab="C230">
						<svg class="ico9" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 58.4 50.87">
							<g class="category-svg">
								<path d="M18.76,50.87l-.31-.08C-.23,46-.08,26.06,0,14.12c0-.79,0-1.55,0-2.27h2.5c0,1,5.68,3.47,16.23,3.47S35,12.86,35,11.85h2.5c0,.72,0,1.48,0,2.27.09,11.94.25,31.92-18.43,36.67ZM2.51,15c-.08,11.84.18,29,16.25,33.26C34.82,44,35.09,26.87,35,15c-3.46,1.9-10,2.79-16.25,2.79S6,16.93,2.51,15Z"/>
								<path d="M18.76,41.82c-3.66,0-6.32-1.56-6.32-3.71h2.5c.05.28,1.34,1.21,3.82,1.21s3.77-.93,3.82-1.22h2.5C25.08,40.26,22.42,41.82,18.76,41.82Z"/>
								<path d="M16.63,28.12h-2.5c0-1-1.16-1.84-2.53-1.84s-2.54.84-2.54,1.84H6.56c0-2.39,2.26-4.34,5-4.34S16.63,25.73,16.63,28.12Z"/>
								<path d="M31,28.12h-2.5c0-1-1.16-1.84-2.53-1.84s-2.53.84-2.53,1.84h-2.5c0-2.39,2.25-4.34,5-4.34S31,25.73,31,28.12Z"/>
								<path d="M39.64,39l-.3-.08a24.88,24.88,0,0,1-2.61-.81l.86-2.34c.66.24,1.35.46,2,.65C55.71,32.14,56,15,55.9,3.18,52.43,5.08,45.87,6,39.64,6S26.86,5.08,23.39,3.18c0,2.87,0,6.06.24,9.36l-2.49.19C20.85,9,20.88,5.41,20.9,2.26c0-.79,0-1.54,0-2.26h2.5c0,1,5.69,3.47,16.23,3.47S55.88,1,55.88,0h2.5c0,.72,0,1.48,0,2.27.09,11.94.24,31.92-18.44,36.67Z"/>
								<path d="M46,28.72h-2.5c-.05-.28-1.33-1.22-3.82-1.22V25C43.31,25,46,26.57,46,28.72Z"/>
								<path d="M46.8,17.52c-2.77,0-5-1.95-5-4.35h2.5c0,1,1.16,1.85,2.53,1.85s2.54-.85,2.54-1.85h2.5C51.84,15.57,49.58,17.52,46.8,17.52Z"/>
							</g>
						</svg>
						공연/쇼
					</button>
				</li>
				<li>
					<button class="cate" data-tab="C280">
						<svg class="ico10" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 41.42 42.4">
							<g class="category-svg">
								<path d="M21.08,42.4c-8.36,0-15.15-7.49-15.15-16.7S12.72,9,21.08,9s15.15,7.49,15.15,16.7S29.43,42.4,21.08,42.4Zm0-31.4C13.83,11,7.93,17.59,7.93,25.7s5.9,14.7,13.15,14.7,13.15-6.59,13.15-14.7S28.33,11,21.08,11Z"/>
								<path d="M7.18,32.25a1,1,0,0,1-.54-.16C6.54,32-2.94,25.8.93,12.22A17.86,17.86,0,0,1,13.87.32a1,1,0,0,1,.45,2A16.08,16.08,0,0,0,2.85,12.76C-.6,24.87,7.38,30.19,7.72,30.41a1,1,0,0,1-.54,1.84Z"/>
								<path d="M34.9,32.23a1,1,0,0,1-.84-.46,1,1,0,0,1,.29-1.38c.32-.22,7.47-5.16,4.23-17.65A15.88,15.88,0,0,0,27.11,2.27a1,1,0,0,1-.75-1.2,1,1,0,0,1,1.2-.75,17.91,17.91,0,0,1,13,11.9c3.63,14-4.71,19.61-5.07,19.84A1,1,0,0,1,34.9,32.23Z"/>
								<path d="M28.25,10.18a1,1,0,0,1-1-.72C24.54-.15,15,2.18,14.54,2.29A1,1,0,0,1,14,.35c.12,0,11.89-2.94,15.17,8.56a1,1,0,0,1-.69,1.23A.84.84,0,0,1,28.25,10.18Z"/>
								<path d="M27.22,28.46a3.18,3.18,0,0,1-3.32-2.22A.75.75,0,0,1,25.37,26a1.81,1.81,0,0,0,1.85,1A1.87,1.87,0,0,0,29.05,26a.75.75,0,1,1,1.44.41A3.26,3.26,0,0,1,27.22,28.46Z"/>
								<path d="M15.43,28.46a3.27,3.27,0,0,1-3.28-2A.75.75,0,1,1,13.6,26a1.85,1.85,0,0,0,1.83.95c1,0,1.75-.52,1.84-1a.75.75,0,0,1,1.48.29A3.19,3.19,0,0,1,15.43,28.46Z"/>
								<path d="M21.3,36.46c-1.76,0-3.25-.83-3.64-2A.75.75,0,0,1,19.09,34a2.34,2.34,0,0,0,2.21,1c1.2,0,2.12-.53,2.23-1a.75.75,0,1,1,1.46.33C24.71,35.54,23.15,36.46,21.3,36.46Z"/>
							</g>
						</svg>
						뷰티/테라피
					</button>
				</li>
			</ul>
		</section><!-- //관광지·레저 유형별 선택 -->

		<!-- 관광지·레저 상세 내용 -->
		<section id="sp_detail" class="sp-list-area"></section>

		<!-- 지도---mw-map-area -->
		<div class="mw-map-area">
			<section class="map-view-area">
				<h2 class="sec-caption">숙박 지도</h2>
				<div id="map"></div> <!-- //map -->
			</section> <!-- //map-view-area -->
		</div> <!-- // 지도---mw-map-area -->
	</main>	<!--//change contents-->
	<!-- <footer id="footer"> footer diplay---none </footer> -->
</div>
<script type="text/javascript">
	
	//창 닫기
	function sp_close_popup(obj) {
		if (typeof obj == "undefined" || obj == "" || obj == null) {
		} else {
			$(obj).hide();
		}
		$('#dimmedB').fadeOut(100);
		$("html, body").removeClass("not_scroll");
	}
	
	function fn_MapMarking(){
		$("[data-filter]").each(function() {
			let compVal = $(this).attr("data-filter");
			let compElement = $(this);
			compElement.attr("data-filter-visible","N");
	
			if($("button.cate").hasClass("active")){
				$("button.cate").each(function() {
	
					if ( $(this).hasClass("active") ){
						if($(this).data('tab') == compVal){
							compElement.attr("data-filter-visible","Y");
						}
					}
				})
			} else{
				compElement.attr("data-filter-visible","Y");
			}
		});
	
		$(".MarkerIcon-content").each(function() {
			if($(this).attr("data-filter-visible") == "Y"){
				$(this).show();
			}else{
				$(this).hide();
			}
		});
	}
	
	$(document).ready(function () {
	
		// scroll 방지
		$(".mw-map-area").addClass("not_scroll");
	
		//관광지·레저 유형별 선택
		$('ul.map-check-inner button').click(function () {
			console.log("click");
			$(this).toggleClass('active');
			fn_MapMarking();
		})
	
		//지도-pin active 유지
		$('.location-pin').on('click', function() {
			$(this).addClass('active');
		})
	})

	const container = document.getElementById("map");
	const options = {
		center: new daum.maps.LatLng(33.36571286933408, 126.56998311968185),
		level : 9
	};
	const map = new daum.maps.Map(container, options);
	<c:forEach items="${tourList}" var="tour" varStatus="status">
	var content = '<div class="MarkerIcon-content" id="${tour.corpId}" data-filter="${tour.ctgr}" data-filter-visible="Y">' +
			'<div class="MarkerIcon-wrap">' +
			'<button class="MarkerIcon-btn" onclick="javascript:goPrdtList(\'${Constant.SV}\', \'${tour.corpId}\');">' +
			'<div class="IconBtn">' +
			'<div class="location-pin"></div>' +
			'</div>' +
			'</button>' +
			'</div>' +
			'</div>';

	// 커스텀 오버레이가 표시될 위치입니다
	var position = new kakao.maps.LatLng(${tour.lat}, ${tour.lon});

	// 커스텀 오버레이를 생성합니다
	var customOverlay = new kakao.maps.CustomOverlay({
		position: position,
		content : content
	});

	// 커스텀 오버레이를 지도에 표시합니다
	customOverlay.setMap(map);
	map.relayout();
	</c:forEach>

	function goPrdtList(corpCd, corpId) {
		$('#sp_detail').show();
		$('.location-pin').attr('class','location-pin');
		$('#'+corpId).find('.location-pin').addClass('active');
		$.ajax({
			type:"post",
			url:"<c:url value='/mw/mapSpPrdtList.ajax'/>",
			data:"prdtNum=" + corpId,
			success:function(data){
				$("#sp_detail").html(data);
			},
			error:function(request,status,error){
				//    alert("code:"+request.status+"\n"+"\n"+"error:"+error);
			}
		});
	}
	
	kakao.maps.event.addListener(map, 'zoom_changed', function() {
		fn_MapMarking();
	});

	kakao.maps.event.addListener(map, 'dragend', function() {
		fn_MapMarking();
	});
</script>
</body>
</html>
