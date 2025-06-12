<!DOCTYPE html>
<html lang="ko">
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
<script type="text/javascript" src="<c:url value='/js/useepil.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/otoinq.js'/>"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />

<script type="text/javascript">

</script>

</head>
<body>


	<div class="memo">
		<div class="rent-map-area">
	    	<div class="around map">
				<div class="sighMap" id="sighMap" style="width: 100%; height: 400px"></div>

	            	<script type="text/javascript">
						//동적 지도 ( 움직이는 지도.)
						var container2 = document.getElementById('sighMap');
						var options2 = {
							center: new daum.maps.LatLng(${svDftinfo.directrecvLat}, ${svDftinfo.directrecvLon}),
							//center: new daum.maps.LatLng(33.4888341, 126.49807970000006),
							level: 4
						};

						var map2 = new daum.maps.Map(container2, options2);

						// 현재 위치.
						//마커가 표시될 위치입니다
						var c_markerPosition  = new daum.maps.LatLng(${svDftinfo.directrecvLat}, ${svDftinfo.directrecvLon});
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
										'<span class="addr">${svDftinfo.directrecvRoadNmAddr} ${svDftinfo.directrecvDtlAddr}</span>' +
										'<a href="javascript:c_closeOverlay();" class="btn-close"><img src="/images/mw/sub/b_box_close.png" width="12" alt="닫기" /></a>' +
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
			</div>
		</div>
	</div>



</body>
</html>