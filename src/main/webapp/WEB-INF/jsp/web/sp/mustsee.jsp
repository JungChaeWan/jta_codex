<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="내손안에제주 관광지 지도, 탐나오"/>
	<jsp:param name="description" value="제주여행공공플랫폼 탐나오. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다."/>
	<jsp:param name="keywords" value="제주,제주도여행,제주도관광,탐나오"/>
</jsp:include>
<meta name="robots" content="noindex, nofollow">
<meta property="og:type" content="website">
<meta property="og:title" content="내손안에제주 관광지 지도, 탐나오">
<meta property="og:url" content="https://www.tamnao.com/mustsee.do">
<meta property="og:image" content="https://www.tamnao.com/images/web/sub/map_jeju.jpg">
<meta property="og:description" content="제주여행공공플랫폼 탐나오. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다.">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<%--<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>">--%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/re/must.css?version=${nowDate}'/>">
</head>
<body>
<div class="container header-wrap">
    <div class="jeju-map-wrap" >
        <div id="zoomMap" class="zoomMap">
            <img id="zoomImg" src="/images/web/sub/map_jeju.jpg" alt="제주관광지지도" class="draggable" style="cursor:pointer;width:1920px;height:955px;">
        </div>
    </div>


</div>
<div class="side-bar" style="position: fixed; top: 0;">
    <section class="side-bar__icon-box">
        <section class="side-bar__icon-1">
            <div></div>
            <div></div>
            <div></div>
        </section>
    </section>
    <ul>
        <li>
            <a href="/web/tour/jeju.do?sCtgr=C200" class="must_content">
                <span><img class="home" src="/images/web/btn/home.png" alt="탐나오 메인"></span>
                <span class="txt">메인으로 이동</span>
            </a>
        </li>
        <li>
            <a href="/mustsee.do" class="must_content active">
                <span><img class="tourist-map__btn" src="/images/web/btn/tourist_map.png" alt="관광지지도"></span>
                <span class="txt">관광지 지도</span>
            </a>
        </li>
        <li>
            <a href="/musteat.do" class="must_content">
                <span><img class="food-map__btn" src="/images/web/btn/food_map.png" alt="맛집지도"></span>
                <span class="txt">맛집 지도</span>
            </a>
        </li>
        <li>
            <a id="see-map-btn" onclick="SaveToDisk('/images/web/sub/map_jeju.jpg','제주관광지지도');">
                    <span>
                        <img class="downaload__btn" src="/images/web/btn/download.png" alt="다운로드버튼">
                    </span>
                <span class="txt">다운로드</span>
            </a>
        <li>
    </ul>
</div>


<script src="<c:url value='/js/jquery.Wheelzoom.js'/>"></script>
<script>

    $(document).ready(function(){

    	//이미지
        $('#zoomImg').wheelzoom({zoom:0.1});
        $('#zoomImg').trigger('wheelzoom.reset');
        
        var currentObj;
        $(".draggable" ).draggable({
            start:function(event, ui ) {
            currentObj = $(".ui-draggable-dragging");
        },
        	containment:".zoomMap"//영역지정 
        });
		
        //사이드바
        $(".side-bar__icon-1, .side-bar ul > li > .must_content").click(function () {
            $(".side-bar").toggleClass("active");
        });
    });

    function SaveToDisk(fileURL, fileName) {
        // for non-IE
        if (!(window.ActiveXObject || "ActiveXObject" in window)) {
            var link = document.createElement('a');
            link.href = fileURL;
            link.target = '_blank';
            link.download = fileName || fileURL;
            var evt = document.createEvent('MouseEvents');
            evt.initMouseEvent('click', true, true, window, 1, 0, 0, 0, 0,
                false, false, false, false, 0, null);
            link.dispatchEvent(evt);
            (window.URL || window.webkitURL).revokeObjectURL(link.href);
		// for IE
        } else if ( window.ActiveXObject || "ActiveXObject" in window ) {	
            var link = document.createElement('a');
            link.href = fileURL;
            link.target = "_blank";
            link.download = fileName;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    }
</script>
</body>
</html>