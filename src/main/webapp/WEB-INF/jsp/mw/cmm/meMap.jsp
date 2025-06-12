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
			<a onclick="changeMarker('', this); return false;" class="active">전체<br /><em id="totalCnt"></em></a>
			<a onclick="changeMarker('ad', this); return false;">숙소<br /><em id="adCnt"></em></a>
			<a onclick="changeMarker('tour', this); return false;">관광지/레저<br /><em id="tourCnt"></em></a>
			<a onclick="changeMarker('etc', this); return false;">음식/뷰티<br /><em id="etcCnt"></em></a>
			<!-- <a onclick="changeMarker('golf', this); return false;">골프<br /><em id="golfCnt"></em></a> -->
		</p>

		<div class="map" id="sighMap"></div>
	</div>
</section>
<script type="text/javascript">
	var container = document.getElementById('sighMap');
	var options = {
	        center: new daum.maps.LatLng(33.510418,126.4891594),
	        level: 8 // 지도의 확대 레벨
	    };
	var map = new daum.maps.Map(container, options);

	if("${gps}"!="Off"){

		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다
		if (navigator.geolocation) {

			// GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
		        var lat = position.coords.latitude; // 위도
		        var lon = position.coords.longitude; // 경도

		        var locPosition = new daum.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다

		        // 현재 위치 기준으로 마커 정보를 가져와 뿌립니다.
		        displayMarker(lat, lon);

		        // 마커와 인포윈도우를 표시합니다
		        displayCurrentMarker(locPosition);
		        //alert("--2");

			}, function(error) {
				displayDefaultMarker();
				//alert("[error]"+error.message);
			},{
				//enableHighAccuracy: true
				//timeout:10000
			});

			//aa();

		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
			displayDefaultMarker();
		}

	}else{
		displayDefaultMarker();
	}


	/**
	* 기본 마커 정의(공항을 기준으로 보여준다.)
	* 2016-01-16
	* ezham@nexez.co.kr
	*/
	function displayDefaultMarker() {
		alert("위치 정보를 지원 하지않아 제주국제공항을 기준으로 검색 합니다.");
	    var locPosition = new daum.maps.LatLng(33.510418, 126.4891594);

	    displayCurrentMarker();
	    displayMarker(33.510418, 126.4891594);

	    map.setCenter(locPosition);
	}

	function displayCurrentMarker(position) {
		var imageSrc = "<c:url value='/images/mw/sub/p_6.png'/>";
	    var imageSize = new daum.maps.Size(28, 35);
	    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);

		var currentMarker = new daum.maps.Marker({
			map : map,
			position:position,
			image : markerImage
		});
	}

	var golfPos = [], adPos=[], tourPos=[], etcPos=[];
	var golfContent = [], adContent=[], tourContent=[], etcContent=[];

	function displayMarker(lat, lon) {
		$.ajax({
			type:"post",
			url : "<c:url value='/mw/getMapMarker.ajax'/>",
			data : "lat=" + lat + "&lon=" + lon,
			success: function (data) {
				var adList = data.adList, tourList=data.tourList, etcList=data.etcList, golfList = data.golfList;
				var inx = 0;
				var totalCnt = 0;
				if( adList !="" ) {
					totalCnt += adList.length;
					$("#adCnt").text("(" + adList.length + ")");
					 $(adList).each( function() {
						adPos.push(new daum.maps.LatLng(this.lat,this.lon));
						adContent.push('<p class="point-info">' +
								'<strong>'+ this.corpNm + '</strong>'+
								'<span class="addr">' + this.roadNmAddr + ' ' + this.dtlAddr +'</span>'+
								'<a href="javascript:closeOverlay(\'ad\', '+ inx + ');" class="btn-close"><img src="<c:url value="/images/mw/sub/b_box_close.png"/>" width="12" alt="닫기" /></a>' +
								'</p>');
						inx++;
						});
				} else {
					$("#adCnt").text("(0)");
				}
				if(tourList != "") {
					totalCnt += tourList.length;
					$("#tourCnt").text("(" + tourList.length + ")");
					inx =0;
					 $(tourList).each( function() {
						tourPos.push(new daum.maps.LatLng(this.lat,this.lon));
						tourContent.push('<p class="point-info">' +
								'<strong>'+ this.corpNm + '</strong>'+
								'<span class="addr">' + this.roadNmAddr + ' ' + this.dtlAddr +'</span>'+
								'<a href="javascript:closeOverlay(\'tour\', '+ inx + ');" class="btn-close"><img src="<c:url value="/images/mw/sub/b_box_close.png"/>" width="12" alt="닫기" /></a>' +
								'</p>');
						inx++;
					});
				} else {
					$("#tourCnt").text("(0)");
				}
				if(etcList != "") {
					inx =0;

					totalCnt += etcList.length;
					$("#etcCnt").text("("+etcList.length+")");

					 $(etcList).each( function() {
						etcPos.push(new daum.maps.LatLng(this.lat,this.lon));
						etcContent.push('<p class="point-info">' +
								'<strong>'+ this.corpNm + '</strong>'+
								'<span class="addr">' + this.roadNmAddr + ' ' + this.dtlAddr +'</span>'+
							'<a href="javascript:closeOverlay(\'etc\', '+ inx + ');" class="btn-close"><img src="<c:url value="/images/mw/sub/b_box_close.png"/>" width="12" alt="닫기" /></a>' +
							'</p>');
						inx++;
					});
				} else {
					$("#etcCnt").text("(0)");
				}
				if(golfList != "") {
					inx =0;
					totalCnt += golfList.length;
					$("#golfCnt").text("(" + golfList.length+")");
					$(golfList).each( function() {
						golfPos.push(new daum.maps.LatLng(this.lat,this.lon));
						golfContent.push('<p class="point-info">' +
								'<strong>'+ this.corpNm + '</strong>'+
								'<span class="addr">' + this.roadNmAddr + ' ' + this.dtlAddr +'</span>'+
								'<a href="javascript:closeOverlay(\'golf\', '+ inx + ');" class="btn-close"><img src="<c:url value="/images/mw/sub/b_box_close.png"/>" width="12" alt="닫기" /></a>' +
								'</p>');
						inx++;
					});
				} else {
					$("#golfCnt").text("(0)");
				}

				$("#totalCnt").text("(" + totalCnt + ")");

				createMarkers();

				changeMarker('');

				createOverlays();

			},
			error:fn_AjaxError
		});
	}

	var golfMarkers=[], adMarkers=[], tourMarkers = [], etcMarkers=[];
	var golfOverlay = [], adOverlay=[], tourOverlay=[], etcOverlay=[];


	function createMarkers() {
		for (var i = 0; i < golfPos.length; i++) {

			var imageSrc = "<c:url value='/images/mw/sub/p_4.png'/>";
		    var imageSize = new daum.maps.Size(28, 35);
		    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize),
		    	 marker = createMarker(golfPos[i], markerImage, i, 'golf');
	        // 생성된 마커를 골프 마커 배열에 추가합니다
	        golfMarkers.push(marker);
	    }

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
		for (var i = 0; i < golfPos.length; i++) {
		    golfOverlay.push(createOverlay(golfPos[i], golfContent[i]));
	    }

		for (var i = 0; i < adPos.length; i++) {
		    adOverlay.push(createOverlay(adPos[i], adContent[i]));
	    }

		for (var i = 0; i < tourPos.length; i++) {
		    tourOverlay.push(createOverlay(tourPos[i], tourContent[i]));
	    }
		for (var i = 0; i < etcPos.length; i++) {
		    etcOverlay.push(createOverlay(etcPos[i], etcContent[i]));
	    }
	}

	function setOverlay(marker, index, type) {
		if(type == 'ad') {
			adOverlay[index].setMap(map);
		}else if(type == 'tour') {
			tourOverlay[index].setMap(map);
		} else if(type=='etc') {
			etcOverlay[index].setMap(map);
		} else if(type=='golf') {
			golfOverlay[index].setMap(map);
		}
	}

	function closeOverlay(type, index) {
		if(type == 'ad') {
			adOverlay[index].setMap(null);
		}else if(type == 'tour') {
			tourOverlay[index].setMap(null);
		} else if(type=='etc') {
			etcOverlay[index].setMap(null);
		} else if(type=='golf') {
			golfOverlay[index].setMap(null);
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
			for (var i = 0; i < golfOverlay.length; i++) {
				golfOverlay[i].setMap(null);
		    }
		}
	}
	function setGolfMarkers(map) {
		for (var i = 0; i < golfMarkers.length; i++) {
	    	golfMarkers[i].setMap(map);
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

		closeOverlay('All', 0);

		if( type=='ad') {
			setTourMarkers(null);
			setAdMarkers(map);
			setGolfMarkers(null);
			setEtcMarkers(null);
		} else if(type == 'tour') {
			setTourMarkers(map);
			setAdMarkers(null);
			setGolfMarkers(null);
			setEtcMarkers(null);
		} else if(type == 'etc') {
			setTourMarkers(null);
			setAdMarkers(null);
			setGolfMarkers(null);
			setEtcMarkers(map);
		} else if(type == 'golf') {
			setTourMarkers(null);
			setAdMarkers(null);
			setGolfMarkers(map);
			setEtcMarkers(null);
		} else {
			setTourMarkers(map);
			setAdMarkers(map);
			setGolfMarkers(map);
			setEtcMarkers(map);
			$(".sub-tabs a:first").addClass("active");
		}
	}
</script>
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" flush="false"></jsp:include>
<!-- 푸터 e -->
<jsp:include page="/mw/menu.do" flush="false"></jsp:include>
</div>
</body>
</html>