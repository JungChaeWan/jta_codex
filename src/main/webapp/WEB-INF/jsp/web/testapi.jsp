<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		    uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
    <jsp:include page="/web/includeJs.do"></jsp:include>
    <meta property="og:title" content="제주여행 공공플랫폼 탐나오" />
    <meta property="og:description" content="실시간 항공, 숙박, 렌터카, 관광지, 맛집, 특산기념품 할인!" />
    <meta property="og:image" content="https://www.tamnao.com${prmtList[0].listImg}" />
    
    <jsp:useBean id="today" class="java.util.Date" />
    <fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

    <script src="<c:url value='/js/multiple-select.js?version=${nowDate}'/>"></script>
    <script src="<c:url value='/js/air_step1.js?version=${nowDate}'/>"></script>
    <script src="<c:url value='/js/cycle.js?version=${nowDate}'/>"></script>
    <script src="<c:url value='/js/freewall.js?version=${nowDate}'/>"></script>
    <%--<script src="https://unpkg.com/vue/dist/vue.js"></script>--%>
    <script src="/js/vue.js?version=${nowDate}"></script>
    <script src="/js/axios.min.js?version=${nowDate}"></script>
    <script src="/js/polyfill.js?version=${nowDate}" async defer></script>
    <%--<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>--%>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/main.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>" />
    <link rel="canonical" href="https://www.tamnao.com">
    <link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw">
	
    <script>
    var parameters = "xkaskdhrmfladusruf2018";
	parameters += "&sUserId=" + userId;
	parameters += "&firstIndex=" + 0;

	$.ajax({
		type:"post",
		dataType:"jsonp",
		async:false,
		url:"<c:url value='http://tamnao.mygrim.com/carlist.php'/>",
		data:parameters,
		success:function(data){
			console.log(data);
		},
		error:fn_AjaxError
	});
    </script>
</head>
<body>
<div>테스트페이지</div>



</body>
</html>