<!DOCTYPE html>
<html lang="ko">
<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0"%>

<un:useConstants var="Constant" className="common.Constant" />
<head>

<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/ad.css'/>" />


<script type="text/javascript">
function goPrdtList(corpCd, corpId, corpNm) {
	var parameters = "corpCd=" + corpCd +"&corpId=" + corpId;
	$.ajax({
		type:"post",
		url:"<c:url value='/web/mapPrdtList.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#div_prdtList").html(data);
			$("#h_corpNm").html(corpNm);
		},
		error:function(request,status,error){
	    //    alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}
$(document).ready(function(){
	$("#allCheck").click(function () {
		closeOverlay('All');
		if($("#allCheck").prop("checked")) {
			$("input[name=chk]").prop("checked", true);
			changeMarker('all');
		} else {
			$("input[name=chk]").prop("checked", false);
			changeMarker('none');
		}
	});

	$("input[name=chk]").click(function () {
		closeOverlay('All');
		if($(this).prop("checked")) {
			if($(this).val() == 'ad') {
				changeMarker($("#adDiv").val());
			} else {
				changeMarker($(this).val());
			}
		} else {
			disMarker($(this).val());
		}
	});

	$("#adDiv").change(function () {
		if($("#adChk").prop("checked")){
			closeOverlay('All');
			changeMarker($(this).val());
		}
	});
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
			<span>홈</span> <span class="gt">&gt;</span>
			<span>지역별 상품보기</span>
         </div>
	</div>

	<!-- quick banner -->
	<jsp:include page="/web/left.do" flush="false"></jsp:include>
	<!-- //quick banner -->
	 <div class="subContainer">
            <div class="subHead"></div>
            <div class="subContents">

                <!-- new contents -->
                <div class="map-service">
                    <!--map form-->
                    <div class="bgWrap">
                        <div class="Fasten">
                            <div class="map-wrap">
                                <!--검색-->
                                <div class="map-check">
                                    <label><input type="checkbox" id="allCheck"<c:if test="${empty typeCd }"> checked</c:if>><span>전체</span></label>
                                    <label><input type="checkbox" name="chk" id="adChk" value="ad"<c:if test="${empty typeCd or typeCd eq 'AD' }"> checked</c:if>></label>
                                    <select class="option" title="숙박선택" name="adDiv" id="adDiv">
                                    		<option value="ad" selected>숙박</option>
                                    	<c:forEach var="data" items="${cdAddv}" varStatus="status">
                                           	<option value="${data.cdNum}">${data.cdNm}</option>
										</c:forEach>
									</select>
                                    <label><input type="checkbox" name="chk" value="tour"<c:if test="${empty typeCd }"> checked</c:if>><span>관광지</span></label>
                                    <!-- <label><input type="checkbox" name="chk" value="sport" checked><span>레저</span></label> -->
                                    <label><input type="checkbox" name="chk" value="food"<c:if test="${empty typeCd }"> checked</c:if>><span>음식</span></label>
                                    <label><input type="checkbox" name="chk" value="beauty"<c:if test="${empty typeCd }"> checked</c:if>><span>뷰티/기타</span></label>
                                </div>

                                <!--map-->
                                <div class="map-box">
                                    <div id="map" style="height: 610px;">


                                        <!-- <div class="point" style="top: 180px; left: 150px">
                                            <img class="icon" src="../images/web/icon/map_s01.png" alt="숙박">
                                            <div class="point-layer">
                                                <dl>
                                                    <dt>중문 카오카오</dt>
                                                    <dd>
                                                        <span class="text"><img src="../images/web/icon/map_call.png" alt="call">전화번호 : </span>
                                                        <span class="call">064-803-0391</span>
                                                    </dd>
                                                </dl>
                                                <div class="btn"><a href="">판매상품보기</a></div>
                                                <div class="close"><a href=""><img src="../images/web/icon/map_close.png" alt="닫기"></a></div>
                                            </div>
                                        </div>  -->

                                    </div>
                                </div> <!--//map-box-->
                                <script type="text/javascript">
								//동적 지도 ( 움직이는 지도.)
								var container = document.getElementById('map');
								var options = {
									center: new daum.maps.LatLng(33.371250, 126.588211),
									//center: new daum.maps.LatLng(33.4888341, 126.49807970000006),
									level: 9
								};

								var map = new daum.maps.Map(container, options);

								var adHoPos = [], adPePos = [], adCoPos = [], adGePos = [], tourPos = [], sportPos=[], foodPos=[], beautyPos=[];
								var adHoContent = [], adPeContent = [], adCoContent = [], adGeContent = [], tourContent = [], sportContent = [], foodContent = [], beautyContent=[];

								var hoIndex = 0, peIndex = 0, coIndex = 0, geIndex = 0;
								<c:forEach items="${adList}" var="ad" varStatus="status">
								<c:if test="${'HO' eq ad.adDiv}">
								adHoPos.push(new daum.maps.LatLng(${ad.lat}, ${ad.lon}));
								adHoContent.push('<div class="point-layer hotel">' +
					            					'<dl>' +
					            						'<dt>${ad.adNm}</dt>' +
					            						'<dd>' +
					                						'<span class="icon"><img src="<c:url value="/images/web/icon/map_addr.png"/>" alt="icon"></span>' +
					                						'<span class="addr">${ad.roadNmAddr} ${ad.dtlAddr}</span>' +
					           							 '</dd>' +
					        						'</dl>' +
					        						'<a href="javascript:goPrdtList(\'${Constant.ACCOMMODATION}\', \'${ad.corpId}\', \'${ad.adNm}\');"></a>' +
					        						'<div class="close"><a href="javascript:closeOverlay(\'HO\', '+ hoIndex + ');"><img src="<c:url value="/images/web/icon/map_close.png"/>" alt="닫기"></a></div>'+
					    						'</div>');
								hoIndex++;
								</c:if>
								<c:if test="${'PE' eq ad.adDiv}">
								adPePos.push(new daum.maps.LatLng(${ad.lat}, ${ad.lon}));
								adPeContent.push('<div class="point-layer hotel">' +
					            					'<dl>' +
					            						'<dt>${ad.adNm}</dt>' +
					            						'<dd>' +
					                						'<span class="icon"><img src="<c:url value="/images/web/icon/map_addr.png"/>" alt="icon"></span>' +
					                						'<span class="addr">${ad.roadNmAddr} ${ad.dtlAddr}</span>' +
					           							 '</dd>' +
					        						'</dl>' +
					        						'<a href="javascript:goPrdtList(\'${Constant.ACCOMMODATION}\', \'${ad.corpId}\', \'${ad.adNm}\');"></a>' +
					        						'<div class="close"><a href="javascript:closeOverlay(\'PE\', '+ peIndex + ');"><img src="<c:url value="/images/web/icon/map_close.png"/>" alt="닫기"></a></div>'+
					    						'</div>');
								peIndex++;
								</c:if>
								<c:if test="${'CO' eq ad.adDiv}">
								adCoPos.push(new daum.maps.LatLng(${ad.lat}, ${ad.lon}));
								adCoContent.push('<div class="point-layer hotel">' +
					            					'<dl>' +
					            						'<dt>${ad.adNm}</dt>' +
					            						'<dd>' +
					                						'<span class="icon"><img src="<c:url value="/images/web/icon/map_addr.png"/>" alt="icon"></span>' +
					                						'<span class="addr">${ad.roadNmAddr} ${ad.dtlAddr}</span>' +
					           							 '</dd>' +
					        						'</dl>' +
					        						'<a href="javascript:goPrdtList(\'${Constant.ACCOMMODATION}\', \'${ad.corpId}\', \'${ad.adNm}\');"></a>' +
					        						'<div class="close"><a href="javascript:closeOverlay(\'CO\', ' + coIndex + ');"><img src="<c:url value="/images/web/icon/map_close.png"/>" alt="닫기"></a></div>'+
					    						'</div>');
								coIndex++;
								</c:if>
								<c:if test="${'GE' eq ad.adDiv}">
								adGePos.push(new daum.maps.LatLng(${ad.lat}, ${ad.lon}));
								adGeContent.push('<div class="point-layer hotel">' +
					            					'<dl>' +
					            						'<dt>${ad.adNm}</dt>' +
					            						'<dd>' +
					                						'<span class="icon"><img src="<c:url value="/images/web/icon/map_addr.png"/>" alt="icon"></span>' +
					                						'<span class="addr">${ad.roadNmAddr} ${ad.dtlAddr}</span>' +
					           							 '</dd>' +
					        						'</dl>' +
					        						'<a href="javascript:goPrdtList(\'${Constant.ACCOMMODATION}\', \'${ad.corpId}\', \'${ad.adNm}\');"></a>' +
					        						'<div class="close"><a href="javascript:closeOverlay(\'GE\', ' + geIndex + ');"><img src="<c:url value="/images/web/icon/map_close.png"/>" alt="닫기"></a></div>'+
					    						'</div>');
								geIndex++;
								</c:if>
								</c:forEach>

								<c:forEach items="${tourList}" var="tour" varStatus="status">
									tourPos.push(new daum.maps.LatLng(${tour.lat}, ${tour.lon}));
									tourContent.push('<div class="point-layer tour">' +
						            					'<dl>' +
						            						'<dt>${tour.corpNm}</dt>' +
						            						'<dd>' +
						                						'<span class="icon"><img src="<c:url value="/images/web/icon/map_addr.png"/>" alt="icon"></span>' +
						                						'<span class="addr">${tour.roadNmAddr} ${tour.dtlAddr}</span>' +
						           							 '</dd>' +
						        						'</dl>' +
						        						'<a href="javascript:goPrdtList(\'${Constant.SOCIAL}\', \'${tour.corpId}\', \'${tour.shopNm}\');"></a>' +
						        						'<div class="close"><a href="javascript:closeOverlay(\'tour\', ${status.index});"><img src="<c:url value="/images/web/icon/map_close.png"/>" alt="닫기"></a></div>'+
						    						'</div>');
								</c:forEach>

								/* <c:forEach items="${sportList}" var="sport" varStatus="status">
								sportPos.push(new daum.maps.LatLng(${sport.lat}, ${sport.lon}));
								sportContent.push('<div class="point-layer leisure">' +
					            					'<dl>' +
					            						'<dt>${sport.corpNm}</dt>' +
					            						'<dd>' +
					                						'<span class="icon"><img src="<c:url value="/images/web/icon/map_addr.png"/>" alt="icon"></span>' +
					                						'<span class="addr">${sport.roadNmAddr} ${sport.dtlAddr}</span>' +
					           							 '</dd>' +
					        						'</dl>' +
					        						'<div class="btn"><a href="javascript:goPrdtList(\'${Constant.SOCIAL}\',\'${sport.corpId}\', \'${sport.shopNm}\');">상품보기</a></div>' +
					        						'<div class="close"><a href="javascript:closeOverlay(\'sport\', ${status.index});"><img src="<c:url value="/images/web/icon/map_close.png"/>" alt="닫기"></a></div>'+
					    						'</div>');
								</c:forEach> */

								<c:forEach items="${foodList}" var="food" varStatus="status">
								foodPos.push(new daum.maps.LatLng(${food.lat}, ${food.lon}));
								foodContent.push('<div class="point-layer food">' +
					            					'<dl>' +
					            						'<dt>${fn:escapeXml(food.corpNm)}</dt>' +
					            						'<dd>' +
					                						'<span class="icon"><img src="<c:url value="/images/web/icon/map_addr.png"/>" alt="icon"></span>' +
					                						'<span class="addr">${food.roadNmAddr} ${food.dtlAddr}</span>' +
					           							 '</dd>' +
					        						'</dl>' +
					        						'<a href="javascript:goPrdtList(\'${Constant.SOCIAL}\', \'${food.corpId}\', \'${food.shopNm}\');"></a>' +
					        						'<div class="close"><a href="javascript:closeOverlay(\'food\', ${status.index});"><img src="<c:url value="/images/web/icon/map_close.png"/>" alt="닫기"></a></div>'+
					    						'</div>');
								</c:forEach>

								<c:forEach items="${beautyList}" var="beauty" varStatus="status">
								beautyPos.push(new daum.maps.LatLng(${beauty.lat}, ${beauty.lon}));
								beautyContent.push('<div class="point-layer beauty">' +
					            					'<dl>' +
					            						'<dt>${beauty.corpNm}</dt>' +
					            						'<dd>' +
					                						'<span class="icon"><img src="<c:url value="/images/web/icon/map_addr.png"/>" alt="icon"></span>' +
					                						'<span class="addr">${beauty.roadNmAddr} ${beauty.dtlAddr}</span>' +
					           							 '</dd>' +
					        						'</dl>' +
					        						'<a href="javascript:goPrdtList(\'${Constant.SOCIAL}\', \'${beauty.corpId}\', \'${beauty.shopNm}\');"></a>' +
					        						'<div class="close"><a href="javascript:closeOverlay(\'beauty\', ${status.index});"><img src="<c:url value="/images/web/icon/map_close.png"/>" alt="닫기"></a></div>'+
					    						'</div>');
								</c:forEach>

								var adHoMarkers=[], adPeMarkers=[],adCoMarkers=[], adGeMarkers=[], tourMarkers = [], sportMarkers=[], foodMarkers=[], beautyMarkers=[];
								var adHoOverlay=[], adPeOverlay=[],adCoOverlay=[], adGeOverlay=[], tourOverlay=[], sportOverlay=[], foodOverlay=[], beautyOverlay=[];

							function createMarkers() {


								for (var i = 0; i < adHoPos.length; i++) {

									var imageSrc = "<c:url value='/images/web/icon/map_s01.png'/>";
								    var imageSize = new daum.maps.Size(28, 35);
								    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize),
								    	 marker = createMarker(adHoPos[i], markerImage, i, 'HO');

							        // 생성된 마커를 숙소 마커 배열에 추가합니다
							        adHoMarkers.push(marker);
							    }

								for (var i = 0; i < adPePos.length; i++) {

									var imageSrc = "<c:url value='/images/web/icon/map_s01.png'/>";
								    var imageSize = new daum.maps.Size(28, 35);
								    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize),
								    	 marker = createMarker(adPePos[i], markerImage, i, 'PE');

							        // 생성된 마커를 숙소 마커 배열에 추가합니다
							        adPeMarkers.push(marker);
							    }

								for (var i = 0; i < adCoPos.length; i++) {

									var imageSrc = "<c:url value='/images/web/icon/map_s01.png'/>";
								    var imageSize = new daum.maps.Size(28, 35);
								    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize),
								    	 marker = createMarker(adCoPos[i], markerImage, i, 'CO');

							        // 생성된 마커를 숙소 마커 배열에 추가합니다
							        adCoMarkers.push(marker);
							    }

								for (var i = 0; i < adGePos.length; i++) {

									var imageSrc = "<c:url value='/images/web/icon/map_s01.png'/>";
								    var imageSize = new daum.maps.Size(28, 35);
								    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize),
								    	 marker = createMarker(adGePos[i], markerImage, i, 'GE');

							        // 생성된 마커를 숙소 마커 배열에 추가합니다
							        adGeMarkers.push(marker);
							    }
								for (var i = 0; i < tourPos.length; i++) {

									var imageSrc = "<c:url value='/images/web/icon/map_s02.png'/>";
								    var imageSize = new daum.maps.Size(28, 35);
								    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize),
								    	 marker = createMarker(tourPos[i], markerImage, i, 'tour');

							        // 생성된 마커를 관광지 마커 배열에 추가합니다
							        tourMarkers.push(marker);
							    }

								for (var i = 0; i < sportPos.length; i++) {

									var imageSrc = "<c:url value='/images/web/icon/map_s04.png'/>";
								    var imageSize = new daum.maps.Size(28, 35);
								    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize),
								    	 marker = createMarker(sportPos[i], markerImage, i, 'sport');

								    // 생성된 마커를 레져 마커 배열에 추가합니다
							        sportMarkers.push(marker);
							    }

								for (var i = 0; i < foodPos.length; i++) {

									var imageSrc = "<c:url value='/images/web/icon/map_s05.png'/>";
								    var imageSize = new daum.maps.Size(28, 35);
								    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize),
								    	 marker = createMarker(foodPos[i], markerImage, i, 'food');

								    // 생성된 마커를 음식 마커 배열에 추가합니다
							        foodMarkers.push(marker);
							    }

								for (var i = 0; i < beautyPos.length; i++) {

									var imageSrc = "<c:url value='/images/web/icon/map_s06.png'/>";
								    var imageSize = new daum.maps.Size(28, 35);
								    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize),
								    	 marker = createMarker(beautyPos[i], markerImage, i, 'beauty');

								    // 생성된 마커를 관광지 마커 배열에 추가합니다
								    beautyMarkers.push(marker);
								}

							}

	function createMarker(position, image, index, type) {
		var marker = new daum.maps.Marker({
	        position: position,
	        image: image,
	        clickable: true
	    });

		daum.maps.event.addListener(marker, 'click', function() {
			closeOverlay('All');
			setOverlay(marker, index, type);
			var tempSplitStr =  $(".point-layer a").attr("href");
			var splitStr = tempSplitStr.split(":");
			eval(splitStr[1])			

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
		for (var i = 0; i < adHoPos.length; i++) {
			var overlay = createOverlay(adHoPos[i], adHoContent[i]);
		    adHoOverlay.push(overlay);
	    }

		for (var i = 0; i < adPePos.length; i++) {
			var overlay = createOverlay(adPePos[i], adPeContent[i]);
		    adPeOverlay.push(overlay);
	    }

		for (var i = 0; i < adCoPos.length; i++) {
			var overlay = createOverlay(adCoPos[i], adCoContent[i]);
		    adCoOverlay.push(overlay);
	    }

		for (var i = 0; i < adGePos.length; i++) {
			var overlay = createOverlay(adGePos[i], adGeContent[i]);
		    adGeOverlay.push(overlay);
	    }

		for (var i = 0; i < tourPos.length; i++) {
			var overlay = createOverlay(tourPos[i], tourContent[i]);
		    tourOverlay.push(overlay);
	    }

		for (var i = 0; i < sportPos.length; i++) {
			var overlay = createOverlay(sportPos[i], sportContent[i])
		    sportOverlay.push(overlay);
	    }

		for (var i = 0; i < foodPos.length; i++) {
			var overlay = createOverlay(foodPos[i], foodContent[i])
		    foodOverlay.push(overlay);
	    }

		for (var i = 0; i < beautyPos.length; i++) {
			var overlay = createOverlay(beautyPos[i], beautyContent[i])
		    beautyOverlay.push(overlay);
	    }

	}

	function setOverlay(marker, index, type) {
		if(type == 'HO') {
			adHoOverlay[index].setMap(map);
		} else if(type == 'PE') {
			adPeOverlay[index].setMap(map);
		} else if(type == 'CO') {
			adCoOverlay[index].setMap(map);
		} else if(type == 'GE') {
			adGeOverlay[index].setMap(map);
		} else if(type == 'tour') {
			tourOverlay[index].setMap(map);
		} else if(type=='sport') {
			sportOverlay[index].setMap(map);
		} else if(type=='food') {
			foodOverlay[index].setMap(map);
		} else if(type=='beauty') {
			beautyOverlay[index].setMap(map);
		}
	}

	function closeOverlay(type, index) {
		if(type == 'HO') {
			adHoOverlay[index].setMap(null);
		} else if(type == 'PE') {
			adPeOverlay[index].setMap(null);
		} else if(type == 'CO') {
			adCoOverlay[index].setMap(null);
		} else if(type == 'GE') {
			adGeOverlay[index].setMap(null);
		} else if(type == 'tour') {
			tourOverlay[index].setMap(null);
		} else if(type=='sport') {
			sportOverlay[index].setMap(null);
		} else if(type=='food') {
			foodOverlay[index].setMap(null);
		} else if(type=='beauty') {
			beautyOverlay[index].setMap(null);
		} else if(type=='All') {
			for (var i = 0; i < adHoOverlay.length; i++) {
				adHoOverlay[i].setMap(null);
		    }
			for (var i = 0; i < adPeOverlay.length; i++) {
				adPeOverlay[i].setMap(null);
		    }
			for (var i = 0; i < adCoOverlay.length; i++) {
				adCoOverlay[i].setMap(null);
		    }
			for (var i = 0; i < adGeOverlay.length; i++) {
				adGeOverlay[i].setMap(null);
		    }
			for (var i = 0; i < tourOverlay.length; i++) {
				tourOverlay[i].setMap(null);
		    }
			for (var i = 0; i < sportOverlay.length; i++) {
				sportOverlay[i].setMap(null);
		    }
			for (var i = 0; i < foodOverlay.length; i++) {
				foodOverlay[i].setMap(null);
		    }
			for (var i = 0; i < beautyOverlay.length; i++) {
				beautyOverlay[i].setMap(null);
		    }
		}

	}

	function setAdMarkers(map) {
		setAdHoMarkers(map);
		setAdPeMarkers(map);
		setAdCoMarkers(map);
		setAdGeMarkers(map);
	}

	function setAdHoMarkers(map) {
		for (var i = 0; i < adHoMarkers.length; i++) {
			adHoMarkers[i].setMap(map);
	    }
	}

	function setAdPeMarkers(map) {
		for (var i = 0; i < adPeMarkers.length; i++) {
			adPeMarkers[i].setMap(map);
	    }
	}

	function setAdCoMarkers(map) {
		for (var i = 0; i < adCoMarkers.length; i++) {
			adCoMarkers[i].setMap(map);
	    }
	}

	function setAdGeMarkers(map) {
		for (var i = 0; i < adGeMarkers.length; i++) {
			adGeMarkers[i].setMap(map);
	    }
	}

	function setTourMarkers(map) {
	    for (var i = 0; i < tourMarkers.length; i++) {
	    	tourMarkers[i].setMap(map);
	    }
	}
	function setSportMarkers(map) {
		for (var i = 0; i < sportMarkers.length; i++) {
	    	sportMarkers[i].setMap(map);
	    }
	}

	function setFoodMarkers(map) {
		for (var i = 0; i < foodMarkers.length; i++) {
	    	foodMarkers[i].setMap(map);
	    }
	}

	function setBeautyMarkers(map) {
		for (var i = 0; i < beautyMarkers.length; i++) {
	    	beautyMarkers[i].setMap(map);
	    }
	}

	function changeMarker(type) {
		if( type=='ad') {
			setAdMarkers(map);
		} else if(type == 'tour') {
			setTourMarkers(map);
		} else if(type == 'sport') {
			setSportMarkers(map);
		} else if(type == 'food') {
			setFoodMarkers(map);
		} else if(type == 'beauty') {
			setBeautyMarkers(map);
		} else if(type == 'all') {
			changeMarker($("#adDiv").val());
			setTourMarkers(map);
			setSportMarkers(map);
			setFoodMarkers(map);
			setBeautyMarkers(map);
		} else if(type == 'none') {
			setAdMarkers(null);
			setTourMarkers(null);
			setSportMarkers(null);
			setFoodMarkers(null);
			setBeautyMarkers(null);
		} else if(type == 'HO') {
			setAdMarkers(null);
			setAdHoMarkers(map);
		} else if(type == 'PE') {
			setAdMarkers(null);
			setAdPeMarkers(map);
		} else if(type == 'CO') {
			setAdMarkers(null);
			setAdCoMarkers(map);
		} else if( type == 'GE') {
			setAdMarkers(null);
			setAdGeMarkers(map);
		}
	}

	function disMarker(type) {
		if(type == 'ad') {
			setAdMarkers(null);
		} else if(type == 'tour') {
			setTourMarkers(null);
		} else if(type == 'sport') {
			setSportMarkers(null);
		} else if(type == 'food') {
			setFoodMarkers(null);
		} else if(type == 'beauty') {
			setBeautyMarkers(null);
		}
	}


	createMarkers();
	
	var markerType = 'all';
	<c:if test="${typeCd eq 'AD' }">
	markerType = 'ad'
	</c:if>

	changeMarker(markerType);

	createOverlays();

	/*
	var iwContent = '<div style="padding:5px;">콤바인리조트</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new daum.maps.LatLng(${corpVO.lat}, ${corpVO.lon}), //인포윈도우 표시 위치입니다
    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

	// 인포윈도우를 생성하고 지도에 표시합니다
	var infowindow = new daum.maps.InfoWindow({
	    map: map, // 인포윈도우가 표시될 지도
	    position : iwPosition,
	    content : iwContent,
	    removable : iwRemoveable
	});
    */

</script>
                            </div> <!--//map-wrap-->
                        </div>
                    </div> <!--//bgWrap-->

                    <!--상품정보-->
                    <div class="Fasten">
                        <!--검색결과-->
                        <div class="product-wrap" id="div_prdtList">
                            <!--item 없을 시 출력-->
                            <div class="item-noContent">
                                <p><img src="<c:url value='/images/web/icon/warning2.gif'/>" alt="경고"></p>
                                <p class="text"><span class="comm-color1">지도에서 상품</span>을 선택해주세요.</p>
                            </div>
                        </div> <!-- //product-wrap -->
                    </div>
                </div> <!-- //map-service -->
                <!-- //new contents -->

            </div> <!-- //subContents -->
        </div> <!-- //subContainer -->
	</main>

	<jsp:include page="/web/right.do" flush="false"></jsp:include>
	<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>
