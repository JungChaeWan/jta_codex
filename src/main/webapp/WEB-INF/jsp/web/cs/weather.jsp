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
<meta name="robots" content="noindex, nofollow">

<jsp:include page="/web/includeJs.do" flush="false"></jsp:include>



<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css'/>" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" /> --%>


<script type="text/javascript">

$(document).ready(function(){
	
});
</script>

</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
    <div class="mapLocation"> <!--index page에서는 삭제-->
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>회원가입</span>
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" flush="false"></jsp:include>
    <!-- //quick banner -->
    <div class="subContainer">
		<div class="subHead"></div>
		<div class="subContents">
            <!-- new contents -->
            <div class="weather">
                	<div class="bgWrap">
                		<div class="Fasten">
                			<div class="weather-map">
                				<ul>
                					<c:forEach items="${gribList}" var="grib" varStatus="status">
                						<c:if test="${grib.area eq '0001'}">
                							<li class="jejusi">
                								<span><img src="<c:url value='/images/web/weather/jejusi.png'/>" alt="제주시"></span>
                						</c:if>
                						<c:if test="${grib.area eq '0002'}">
                							<li class="gosan">
                								<span><img src="<c:url value='/images/web/weather/gosan.png'/>" alt="고산"></span>
                						</c:if>
                						<c:if test="${grib.area eq '0003'}">
                							<li class="sunsang">
                								<span><img src="<c:url value='/images/web/weather/sunsang.png'/>" alt="성산"></span>
                						</c:if>
                						<c:if test="${grib.area eq '0004'}">
                							<li class="seogwipo">
                								<span><img src="<c:url value='/images/web/weather/seogwipo.png'/>" alt="서귀포"></span>
                						</c:if>
	                						<div class="detail">
	                							<p class="time">${fn:substring(grib.baseTime, 0, 2)}시 현재날씨</p>
	                							<div class="info-wrap">
	                								<div class="l-area">
	                									<c:choose>
	                										<c:when test="${grib.skyCode eq '1'}"><img src="<c:url value='/images/web/weather/01.png'/>" alt="맑음"></c:when>
	                										<c:when test="${grib.skyCode eq '2'}"><img src="<c:url value='/images/web/weather/02.png'/>" alt="구름조금"></c:when>
	                										<c:when test="${grib.skyCode eq '3'}"><img src="<c:url value='/images/web/weather/03.png'/>" alt="구름많음"></c:when>
	                										<c:otherwise>
	                											<c:choose>
	                												<c:when test="${grib.ptyCode eq '0'}"><img src="<c:url value='/images/web/weather/04.png'/>" alt="흐림"></c:when>
	                												<c:when test="${grib.ptyCode eq '1'}"><img src="<c:url value='/images/web/weather/05.png'/>" alt="비"></c:when>
	                												<c:when test="${grib.ptyCode eq '2'}"><img src="<c:url value='/images/web/weather/06.png'/>" alt="눈/비"></c:when>
	                												<c:when test="${grib.ptyCode eq '3'}"><img src="<c:url value='/images/web/weather/07.png'/>" alt="눈"></c:when>
	                											</c:choose>
	                										</c:otherwise>
	                									</c:choose>
	                								</div>
	                								<div class="r-area">
	                									<p class="temp"><span><c:out value="${grib.t1h}"/></span>℃</p>
	                									<!-- <dl>
	                										<dt>현재풍속 :</dt>
	                										<dd>북서풍 120m/s</dd>
	                									</dl> -->
	                									<dl>
	                										<dt>현재습도 :</dt>
	                										<dd><c:out value="${grib.reh}"/>%</dd>
	                									</dl>
	                									<dl>
	                										<dt>1시간 강수량 :</dt>
	                										<dd><c:out value="${grib.rn1}" /></dd>
	                									</dl>
	                								</div>
	                							</div>
	                						</div>
	                					</li>
                					</c:forEach>
                				</ul>
                			</div> <!-- //weather-map -->
                		</div>
                	</div>
                	
                	<div class="Fasten">
                		<div class="weather-content">
                			<div class="side-title">
                				<h3 class="title1">주간예보</h3>
                			</div>
                			
               				<table class="table-col center">
								<thead>
									<tr>
										<th style="width:80px">날짜</th>
										<c:forEach items="${mlwTaList}" var="mlwTa" varStatus="status">
											<th>
												<fmt:parseDate value='${mlwTa.baseDt}' var='baseDt' pattern="yyyymmdd" scope="page" />
												<fmt:formatDate value="${baseDt}" pattern="yyyy-mm-dd"/> (${mlwTa.yoil})</th>
										</c:forEach>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>오전</td>
										<c:forEach items="${mlwWfList}" var="mlwWf" varStatus="status">
											<c:if test="${mlwWf.timeDiv eq 1}">
												<c:choose>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '눈/비') != -1}"><td><img src="<c:url value='/images/web/weather/06.png'/>" alt="눈,비"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '비/눈') != -1}"><td><img src="<c:url value='/images/web/weather/06.png'/>" alt="눈,비"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '눈') != -1}"><td><img src="<c:url value='/images/web/weather/07.png'/>" alt="눈"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '비') != -1}"><td><img src="<c:url value='/images/web/weather/05.png'/>" alt="비"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '흐림') != -1}"><td><img src="<c:url value='/images/web/weather/04.png'/>" alt="흐림"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '구름많') != -1}"><td><img src="<c:url value='/images/web/weather/03.png'/>" alt="구름많음"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '구름조금') != -1}"><td><img src="<c:url value='/images/web/weather/02.png'/>" alt="구름조금"></td></c:when>
													<c:otherwise><td><img src="<c:url value='/images/web/weather/01.png'/>" alt="맑음"></td></c:otherwise>
												</c:choose>
											</c:if>
											<c:if test="${mlwWf.timeDiv eq 3}">
												<td rowspan="2">
												<c:choose>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '눈/비') != -1}"><img src="<c:url value='/images/web/weather/06.png'/>" alt="눈,비"></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '비/눈') != -1}"><img src="<c:url value='/images/web/weather/06.png'/>" alt="눈,비"></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '눈') != -1}"><img src="<c:url value='/images/web/weather/07.png'/>" alt="눈"></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '비') != -1}"><img src="<c:url value='/images/web/weather/05.png'/>" alt="비"></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '흐림') != -1}"><img src="<c:url value='/images/web/weather/04.png'/>" alt="흐림"></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '구름많') != -1}"><img src="<c:url value='/images/web/weather/03.png'/>" alt="구름많음"></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '구름조금') != -1}"><img src="<c:url value='/images/web/weather/02.png'/>" alt="구름조금"></c:when>
													<c:otherwise><img src="<c:url value='/images/web/weather/01.png'/>" alt="맑음"></c:otherwise>
												</c:choose>
												</td>
											</c:if>
										</c:forEach>
									</tr>
									<tr>
										<td>오후</td>
										<c:forEach items="${mlwWfList}" var="mlwWf" varStatus="status">
											<c:if test="${mlwWf.timeDiv eq 2}">
												<c:choose>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '눈/비') != -1}"><td><img src="<c:url value='/images/web/weather/06.png'/>" alt="눈,비"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '비/눈') != -1}"><td><img src="<c:url value='/images/web/weather/06.png'/>" alt="눈,비"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '눈') != -1}"><td><img src="<c:url value='/images/web/weather/07.png'/>" alt="눈"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '비') != -1}"><td><img src="<c:url value='/images/web/weather/05.png'/>" alt="비"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '흐림') != -1}"><td><img src="<c:url value='/images/web/weather/04.png'/>" alt="흐림"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '구름많') != -1}"><td><img src="<c:url value='/images/web/weather/03.png'/>" alt="구름많음"></td></c:when>
													<c:when test="${fn:indexOf(mlwWf.wfNm, '구름조금') != -1}"><td><img src="<c:url value='/images/web/weather/02.png'/>" alt="구름조금"></td></c:when>
													<c:otherwise><td><img src="<c:url value='/images/web/weather/01.png'/>" alt="맑음"></td></c:otherwise>
												</c:choose>
											</c:if>
										</c:forEach>
									</tr>
									<tr>
										<td><span class="text-red">최고</span> / <span class="text-blue">최저</span> <br>온도 (℃)</td>
										<c:forEach items="${mlwTaList}" var="mlwTa" varStatus="status">
											<td><span class="text-red">${mlwTa.taMax}</span>/<span class="text-blue">${mlwTa.taMin}</span></td>
										</c:forEach>
									</tr>
								</tbody>
							</table>
                		</div> <!-- //weather-content -->
                	</div>
                </div> <!-- weather -->
            <!-- //new contents -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>