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
	<jsp:include page="/mw/includeJs.do" flush="false"></jsp:include>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sub_hotel.css'/>">
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>
</head>	
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" flush="false"></jsp:include>
</header>
<!-- 헤더 e -->


<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>위치 및 주변 업소</h2>
	</div>
	<div class="sub-content">
		<p class="sub-tabs">
			<a onclick="changeMarker('', this); return false;" class="active">전체<br /><em>(${fn:length(adList) + fn:length(tourList) + fn:length(etcList)})</em></a>
			<a onclick="changeMarker('ad', this); return false;">숙소<br /><em>(${fn:length(adList)})</em></a>
			<a onclick="changeMarker('tour', this); return false;">관광지/레저<br /><em>(${fn:length(tourList)})</em></a>
			<a onclick="changeMarker('etc', this); return false;">음식/뷰티<br /><em>(${fn:length(etcList)})</em></a>
		</p>
		
		<div class="map" id="sighMap"></div>
	</div>
</section>
<script type="text/javascript">
	//동적 지도 ( 움직이는 지도.)
	var container = document.getElementById('sighMap');
	var options = {
		center: new daum.maps.LatLng(${resultVO.lat}, ${resultVO.lon}),
		//center: new daum.maps.LatLng(33.4888341, 126.49807970000006),
		level: 8
	};
	
	var map = new daum.maps.Map(container, options);
	
	var adPos=[], tourPos=[], etcPos=[];
	var adContent=[], tourContent=[], etcContent=[];

	<c:forEach items="${adList}" var="ad" varStatus="status">
	adPos.push(new daum.maps.LatLng(${ad.lat},${ad.lon} ));
	adContent.push('<p class="point-info">' +
	'<strong>${ad.corpNm}</strong>'+
	'<span class="addr">${ad.roadNmAddr} ${ad.dtlAddr}</span>' +
	'<a href="javascript:closeOverlay(\'ad\', ${status.index});" class="btn-close"><img src="<c:url value="/images/mw/sub/b_box_close.png"/>" width="12" alt="닫기" /></a>' +
	'</p>');
	</c:forEach>
	
	<c:forEach items="${tourList}" var="tour" varStatus="status">
	tourPos.push(new daum.maps.LatLng(${tour.lat},${tour.lon} ));
	tourContent.push('<p class="point-info">' +
	'<strong>${tour.corpNm}</strong>'+
	'<span class="addr">${tour.roadNmAddr} ${tour.dtlAddr}</span>' +
	'<a href="javascript:closeOverlay(\'tour\', ${status.index});" class="btn-close"><img src="<c:url value="/images/mw/sub/b_box_close.png"/>" width="12" alt="닫기" /></a>' +
	'</p>');
	
	</c:forEach>
	
	<c:forEach items="${etcList}" var="etc" varStatus="status">
	etcPos.push(new daum.maps.LatLng(${etc.lat},${etc.lon} ));
	etcContent.push('<p class="point-info">' +
	'<strong>${etc.corpNm}</strong>'+
	'<span class="addr">${etc.roadNmAddr} ${etc.dtlAddr}</span>' +
	'<a href="javascript:closeOverlay(\'etc\', ${status.index});" class="btn-close"><img src="<c:url value="/images/mw/sub/b_box_close.png"/>" width="12" alt="닫기" /></a>' +
	'</p>');
	
	</c:forEach>
	
	var adMarkers=[], tourMarkers = [], etcMarkers=[];
	var adOverlay=[], tourOverlay=[], etcOverlay=[];
	
	
	function createMarkers() {

		for (var i = 0; i < adPos.length; i++) {  
	        
			var imageSrc = "<c:url value='/images/mw/sub/p_1.png'/>";
		    var imageSize = new daum.maps.Size(28, 35); 
		    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize), 
		    	 marker = createMarker(adPos[i], markerImage, i, 'ad');
	        
	        // 생성된 마커를 숙소 마커 배열에 추가합니다
	        adMarkers.push(marker);
	    }
		
		for (var i = 0; i < tourPos.length; i++) {  
	        
			var imageSrc = "<c:url value='/images/mw/sub/p_2.png'/>";
		    var imageSize = new daum.maps.Size(28, 35); 
		    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize), 
		    	 marker = createMarker(tourPos[i], markerImage, i, 'tour');
	        
	        // 생성된 마커를 관광지 마커 배열에 추가합니다
	        tourMarkers.push(marker);
	    }  
		for (var i = 0; i < etcPos.length; i++) {  
	        
			var imageSrc = "<c:url value='/images/mw/sub/p_3.png'/>";
		    var imageSize = new daum.maps.Size(28, 35); 
		    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize), 
		    	 marker = createMarker(etcPos[i], markerImage, i, 'etc');
	        
		    // 생성된 마커를 관광지 마커 배열에 추가합니다
	        etcMarkers.push(marker);
	    }  
	}
	
	function createMarker(position, image, index, type) {
		var marker = new daum.maps.Marker({
	        position: position,
	        image: image,
	        clickable: true
	    });

		daum.maps.event.addListener(marker, 'click', function() {
			setOverlay(marker, index, type);
			
		}); 
		return marker;  
	}
	
	function createOverlay(position, content) {
		var overlay = new daum.maps.CustomOverlay({
			content:content,
			position:position
		});
			
		return overlay;
	}
	
	function createOverlays() {

		for (var i = 0; i < adPos.length; i++) {
			var overlay = createOverlay(adPos[i], adContent[i]);
		    adOverlay.push(overlay);
	    }
		
		for (var i = 0; i < tourPos.length; i++) {
			var overlay = createOverlay(tourPos[i], tourContent[i]);
		    tourOverlay.push(overlay);
	    }
		
		for (var i = 0; i < etcPos.length; i++) {  
			var overlay = createOverlay(etcPos[i], etcContent[i])
		    etcOverlay.push(overlay);
	    }  
	}
	
	function setOverlay(marker, index, type) {
		if(type == 'ad') {
			adOverlay[index].setMap(map);
		}else if(type == 'tour') {
			tourOverlay[index].setMap(map);
		} else if(type=='etc') {
			etcOverlay[index].setMap(map);
		}
	}
	
	function closeOverlay(type, index) {
		if(type == 'ad') {
			adOverlay[index].setMap(null);
		}else if(type == 'tour') {
			tourOverlay[index].setMap(null);
		} else if(type=='etc') {
			etcOverlay[index].setMap(null);
		} else if(type=='All') {
			for (var i = 0; i < adOverlay.length; i++) {  
				adOverlay[i].setMap(null);
		    } 
			for (var i = 0; i < tourOverlay.length; i++) {  
				tourOverlay[i].setMap(null);
		    } 
			for (var i = 0; i < etcOverlay.length; i++) {  
				etcOverlay[i].setMap(null);
		    }  
		}
		
	}
	function setAdMarkers(map) {
		for (var i = 0; i < adMarkers.length; i++) {  
	    	adMarkers[i].setMap(map);
	    }  
	}
	function setTourMarkers(map) {        
	    for (var i = 0; i < tourMarkers.length; i++) {  
	    	tourMarkers[i].setMap(map);
	    }        
	}
	
	function setEtcMarkers(map) {
		for (var i = 0; i < etcMarkers.length; i++) {  
	    	etcMarkers[i].setMap(map);
	    }  
	}
	
	function changeMarker(type, obj) {
		$(".sub-tabs a").removeClass("active");
		$(obj).addClass("active");
		closeOverlay('All',0);
		
		if( type=='ad') {
			setTourMarkers(null);
			setAdMarkers(map);
			setEtcMarkers(null);
		} else if(type == 'tour') {
			setTourMarkers(map);
			setAdMarkers(null);
			setEtcMarkers(null);
		} else if(type == 'etc') {
			setTourMarkers(null);
			setAdMarkers(null);
			setEtcMarkers(map);
		} else {
			setTourMarkers(map);
			setAdMarkers(map);
			setEtcMarkers(map);
			$(".sub-tabs a:first").addClass("active");
		}
	}
	
	
	
	createMarkers();
	
	changeMarker('');
	
	createOverlays();
	
	
	// 현재 위치 표시.
	var c_markerPosition  = new daum.maps.LatLng(${resultVO.lat}, ${resultVO.lon});
	var c_imageSrc = "<c:url value='/images/mw/sub/location_my.png'/>";
	var c_imageSize = new daum.maps.Size(28, 35);
	var c_markerImage = new daum.maps.MarkerImage(c_imageSrc, c_imageSize); 
	// 마커를 생성합니다
	var marker = new daum.maps.Marker({
		map : map,
		position: c_markerPosition,
		image : c_markerImage,
		clickable: true
	});
	
	var c_content = '<p class="point-info">' +
	'<strong>${resultVO.corpNm}</strong>'+
	'<span class="addr">${resultVO.roadNmAddr} ${resultVO.dtlAddr}</span>' +
	'<a href="javascript:c_closeOverlay();" class="btn-close"><img src="<c:url value="/images/mw/sub/b_box_close.png"/>" width="12" alt="닫기" /></a>' +
	'</p>';
	var overlay = new daum.maps.CustomOverlay({
		content:c_content,
		position:c_markerPosition,
		map : map
	});
	
	daum.maps.event.addListener(marker, 'click', function() {
		overlay.setMap(map);
	}); 
	
	function c_closeOverlay() {
		overlay.setMap(null);
	}
</script>
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>
</body>
</html>			
			
		
		
