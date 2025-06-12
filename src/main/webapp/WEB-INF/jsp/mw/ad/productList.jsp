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
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="제주여행 공공플랫폼 저렴한 숙소 예약, 탐나오"/>
	<jsp:param name="keywords" value="제주숙소,제주도숙소,제주숙박,제주도숙박,호텔,펜션,리조트,민박,게스트하우스,실시간 예약"/>
	<jsp:param name="description" value="탐나오 숙소 목록"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 저렴한 숙소 예약, 탐나오">
<meta property="og:url" content="https://www.tamnao.com/mw/ad/productList.do">
<meta property="og:description" content="제주도 숙박은 탐나오에서 예약 하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 제주 여행을 안전하게 즐길 수 있습니다. 제주여행공공플랫폼 탐나오.">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">
   
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="/css/mw/common2.css?version=${nowDate}">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="/css/mw/style.css?version=${nowDate}">
<link rel="stylesheet" type="text/css" href="/css/mw/daterangepicker.css?version=${nowDate}">
<link rel="stylesheet" type="text/css" href="/css/mw/ad.css?version=${nowDate}">
<link rel="preload" as="image" href="../../images/mw/hotel/h-h-back.png" />
</head>
<body>
<div id="wrap">
	<header id="header" class="transBG">
		<jsp:include page="/mw/head.do">
			<jsp:param name="headTitle" value="숙소"/>
		</jsp:include>
	</header>

	<!-- 콘텐츠 s -->
	<main id="main">
		<form name="frm" id="frm" method="post" onSubmit="return false;">
			<div class="mw-hotel-header">
				<div class="mw-hotel-date" id="dateRangePickMw">
					<a id="searchAreaD">
						<dl>
							<dt>입실일</dt>
							<dd>
								<div class="dateRangePickMw">
									<input placeholder="입실일" onfocus="this.blur()" id="startDt" value="${searchVO.sFromDtView}">
									<img src="/images/mw/icon/form/r-h-btn.png" alt="변경">
								</div>
							</dd>
						</dl>
						<dl>
							<dt>퇴실일</dt>
							<dd>
								<div class="dateRangePickMw">
									<input placeholder="퇴실일" onfocus="this.blur()" id="endDt" value="${searchVO.sToDtView}">
								</div>
							</dd>
						</dl>
					</a>
				</div>

				<div class="mw-hotel-etc" id="searchArea">
					<a class="mw-hotel-region" id="area_str">
						<img src="/images/mw/rent/rent-btn.png" alt="지역선택">지역선택
					</a>
				</div>

				<!-- 제주도 여행지 / layer-popup -->
				<div id="hotel_zone" class="popup-typeA hotel-zone">
					<div class="hotel-wrapper">
						<a class="close-btn" onclick="ad_close_popup('#hotel_zone')"></a>
						<div class="condition_title">
							<div class="title">지역을 선택해주세요.</div>
						</div>
						<div class="searchTabGroup stay">
							<div class="searchGroup quick_mapArea">
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680.9 384.06" class="us">
									<!-- 제주시 동부 -->
									<g id="EA" data-area="EA" data-areanm="제주시 동부">
										<path class="cls-1 off" d="M441.3,104.18a363.77,363.77,0,0,1-20.88,46.42c44-10.58,90.14-8.44,135-7.91,26,.31,52.51.89,77.56-6.92,17-5.3,32.71-13.79,47.88-23.09-1.23-4.68-7.51-8.17-16.85-11-12.82-3.86-9.68-8.36-3.9-16.07s5.79-12.86-4.5-19.28-5.14-2.58-17.35-18-16.71-5.79-31.49-5.14S594,33.57,585,14.93s-21.21-3.86-30.85-3.22S534.82-5,521.32,1.43,504.61,13,486,12.21c-11.83-.49-18.48,3.06-24.72,6.88-1.1,10-2.57,19.93-4.48,29.78A357.12,357.12,0,0,1,441.3,104.18Z"/>
										<path class="cls-2 off" d="M506.66,79.66c0,3.39,1.26,6.82,4,8.43l-1.29,1.65a9,9,0,0,1-3.73-5.37,9.83,9.83,0,0,1-3.82,5.85l-1.33-1.67c2.75-1.76,4.05-5.35,4.05-8.89V78.23h-3.43V76.36h8.8v1.87h-3.22Zm4.66-5.08h2.09V93.11h-2.09V83h-2.87V81.18h2.87Zm6-.4V94.05h-2.11V74.18Z"/>
										<path class="cls-2 off" d="M537.75,87.21H530V94.1h-2.22V87.21h-7.63V85.38h17.62Zm-16.62-5.06c3.71-.51,6.45-2.69,6.58-5h-5.93V75.33h14.34v1.82h-5.89c.13,2.31,2.87,4.49,6.58,5l-.8,1.78c-3.21-.48-5.87-2.11-7-4.31-1.19,2.2-3.82,3.83-7,4.31Z"/>
										<path class="cls-2 off" d="M546.74,79.11c0,3.65,2,7.31,5,8.71l-1.29,1.81a9.85,9.85,0,0,1-4.83-6,10.32,10.32,0,0,1-5,6.4l-1.32-1.89c3.11-1.43,5.13-5.24,5.13-9.07V75.85h2.22Zm8.84-4.93V94.12h-2.24V74.18Z"/>
										<path class="cls-2 off" d="M528.07,110.2v1.85H510.48V110.2h7.68v-2h-5.5v-6.74h13.26v1.81H514.86v3.1h11.19v1.83h-5.67v2Zm-2.15,6.66c0,2.31-2.53,3.63-6.71,3.63s-6.7-1.32-6.7-3.63,2.54-3.6,6.7-3.6S525.92,114.58,525.92,116.86Zm-2.25,0c0-1.21-1.61-1.87-4.46-1.87s-4.44.66-4.44,1.87,1.6,1.88,4.44,1.88S523.67,118.1,523.67,116.86Z"/>
										<path class="cls-2 off" d="M547.5,114.05h-7.79v6.44h-2.22v-6.44h-7.65v-1.83H547.5Zm-2.18-4H532v-8.7h2.23v2.51h8.9v-2.51h2.22Zm-2.22-4.36h-8.9v2.53h8.9Z"/>
										<path class="cls-3 off" d="M529.09,35.1a9.59,9.59,0,0,0-9.6,9.59c0,5.3,9.6,20.26,9.6,20.26s9.6-15,9.6-20.26A9.59,9.59,0,0,0,529.09,35.1Zm0,13a3.73,3.73,0,1,1,3.73-3.73A3.73,3.73,0,0,1,529.09,48.07Z"/>
									</g>
									<!-- 시내권 -->
									<g id="JE" data-area="JE" data-areanm="시내권">
										<path class="cls-1 off" d="M185.84,110.08c3.74,5.84,6.58,12.18,9.63,18.38,1.51,3.06,3.07,6.1,4.82,9,.9,1.52,1.85,3,2.87,4.46.31.45.64.89,1,1.33l.44.57c.26.31.51.63.78.93a40.41,40.41,0,0,0,3.61,3.79c.6.55,1.22,1.06,1.84,1.58l.12.11.13.09.94.67a54,54,0,0,0,8.08,4.48c.83.38,1.65.74,2.48,1.1.36.16.72.32,1.08.46-1.18-.47,0,0,.24.1,1.71.72,3.43,1.43,5.14,2.16a86.14,86.14,0,0,1,8.36,4,41,41,0,0,1,14,12.76c3.24,4.72,5.5,10,7.7,15.28.56,1.34,1.11,2.69,1.67,4l.39.93,0,.14c.23.58.5,1.15.75,1.73,1.07,2.45,2.2,4.88,3.5,7.22.65,1.16,1.33,2.3,2.08,3.41.35.53.72,1,1.09,1.56l0,0c.19.23.37.46.56.68a29.34,29.34,0,0,0,2.84,3c.08.07.71.62,1.12,1l.36.25.8.55a5.4,5.4,0,0,1,2.06,2.49,322.69,322.69,0,0,0,63.93-30.71c21.46-13.22,42.72-26,67-33.36l.35-.1a4.84,4.84,0,0,1,.61-2q7.83-13.89,14.41-28.43c1-2.19,1.95-4.38,2.9-6.58.14-.34.28-.68.43-1l0-.06c.2-.49.41-1,.61-1.45.46-1.11.91-2.22,1.36-3.33q2.64-6.57,5-13.23,4.76-13.32,8.44-27t6.31-27.8Q449,36.28,450,29.39c.11-.74.21-1.48.32-2.22,0-.21,0-.42.08-.63v-.05c.06-.51.13-1,.19-1.52l-.59.24c-11.57,4.5-17.35,0-26.35-9s-18.64,0-18.64,0c-12.21,0-20.57,7.72-42.74,19.28S318.87,49,298.62,47.06s-25.07,7.72-38.56,26-26,7.72-40.5,11.57-10.6,7.72-30.85,4.82c-6.3-.9-13.07.82-19.82,4C176.05,97.23,181.53,103.36,185.84,110.08Z"/>
										<path class="cls-2 off" d="M303,141.22c0,3.66,2,7.31,5,8.72l-1.29,1.8a9.88,9.88,0,0,1-4.83-6,10.29,10.29,0,0,1-5,6.4l-1.31-1.89c3.1-1.43,5.13-5.24,5.13-9.07V138H303Zm8.84-4.93v19.94h-2.24V136.29Z"/>
										<path class="cls-2 off" d="M318.34,149.23a35.61,35.61,0,0,0,5.72-.59l.24,1.93a36.3,36.3,0,0,1-6.88.6h-1.3V138.6h2.22Zm13.48-12.91v19.87h-2.11v-10.1H327.4v9.1h-2.09V136.71h2.09v7.51h2.31v-7.9Z"/>
										<path class="cls-2 off" d="M339.84,145.73c-1.79.09-3.51.11-5,.11l-.31-1.8c2.42,0,5.37,0,8.28-.24a35.11,35.11,0,0,0,.46-4.54H336.3v-1.84h9.15v.74a33.59,33.59,0,0,1-.39,5.46c.67-.06,1.36-.15,2-.24l.17,1.61c-1.71.28-3.47.5-5.2.61v4.45h-2.22ZM351.35,154v1.85H337.3v-6.07h2.22V154Zm-2.67-6.91V136.32h2.22v15h-2.22v-2.48h-4.05v-1.79Z"/>
										<path class="cls-3 off" d="M326.16,95.88a9.59,9.59,0,0,0-9.59,9.59c0,5.3,9.59,20.26,9.59,20.26s9.6-15,9.6-20.26A9.59,9.59,0,0,0,326.16,95.88Zm0,13a3.74,3.74,0,1,1,3.74-3.73A3.73,3.73,0,0,1,326.16,108.85Z"/>
									</g>
									<!-- 제주시 서부 -->
									<g id="WE" data-area="WE" data-areanm="제주시 서부">
										<path class="cls-1 off" d="M265.72,221.69A41.83,41.83,0,0,1,256.53,210c-1.41-2.6-2.63-5.3-3.79-8-.7-1.62-1.38-3.26-2.06-4.89-.3-.72-.59-1.45-.89-2.17-.17-.4-.32-.81-.51-1.2l0-.08a70.59,70.59,0,0,0-7.46-13.82l-.24-.3-.63-.74c-.42-.49-.86-1-1.31-1.43s-1-1-1.45-1.39l-.87-.76-.3-.25a37.17,37.17,0,0,0-7.74-4.61c-1.39-.67-2.81-1.3-4.23-1.91l-.5-.22-.81-.34-2.15-.89c-3.14-1.32-6.3-2.62-9.33-4.18A46,46,0,0,1,196.74,150c-8.52-11-12.56-24.42-20.22-35.9-.47-.7-1-1.39-1.45-2.07,0-.08-.37-.5-.47-.64l-.55-.68a45.07,45.07,0,0,0-3.37-3.68c-.66-.63-1.33-1.23-2-1.81-.15-.13-1.21-.9-.21-.18-.22-.16-.42-.32-.64-.47a32.75,32.75,0,0,0-4-2.46c-.46-.24-.93-.47-1.4-.69-.23-.11-1.3-.74-.24-.11a9.76,9.76,0,0,0-2.18-.78c-.7-.22-1.44-.44-2.18-.61-10.87,7.33-20.92,16.87-27.88,23.34-13.5,12.53-20.25-1.93-36.64,21.21s-28.92,40.49-54.23,54S5,245.66,5,245.66c-10.8,24.25-2.33,41.78,9.24,52.71.73.69,1.4,1.39,2,2.09C49.39,276.73,88.77,263,128.13,253.27,173.81,242,220.71,235.68,265.72,221.69Z"/>
										<path class="cls-2 off" d="M78.53,212.36c0,3.39,1.25,6.83,4,8.43l-1.29,1.65a9,9,0,0,1-3.73-5.37,9.9,9.9,0,0,1-3.82,5.86l-1.34-1.68c2.76-1.76,4.06-5.34,4.06-8.89v-1.42H73v-1.87h8.79v1.87H78.53Zm4.66-5.08h2.09v18.53H83.19V215.73H80.32v-1.85h2.87Zm6-.39v19.87H87.11V206.89Z"/>
										<path class="cls-2 off" d="M109.62,219.91h-7.74v6.89H99.66v-6.89H92v-1.82h17.61ZM93,214.85c3.71-.5,6.44-2.68,6.57-5H93.65V208H108v1.83H102.1c.13,2.31,2.86,4.49,6.57,5l-.79,1.78c-3.22-.48-5.87-2.11-7.06-4.31-1.18,2.2-3.81,3.83-7,4.31Z"/>
										<path class="cls-2 off" d="M118.61,211.82c0,3.65,2,7.3,5,8.71l-1.3,1.8a9.91,9.91,0,0,1-4.83-6,10.26,10.26,0,0,1-5,6.4l-1.31-1.89c3.1-1.43,5.13-5.24,5.13-9.06v-3.26h2.22Zm8.84-4.93v19.93h-2.24V206.89Z"/>
										<path class="cls-2 off" d="M143.49,211.79c0,3.7,1.86,7.31,4.83,8.72L147,222.33a9.76,9.76,0,0,1-4.62-6,10.21,10.21,0,0,1-4.68,6.29l-1.4-1.8c3-1.52,4.94-5.35,4.94-9.07v-3.28h2.24Zm9.12-4.93V226.8h-2.24V215.25h-4.16V213.4h4.16v-6.54Z"/>
										<path class="cls-2 off" d="M173.48,220.35H165.7v6.45h-2.22v-6.45h-7.66v-1.82h17.66Zm-2.18-4H158v-8.69h2.22v2.51h8.9v-2.51h2.22ZM169.08,212h-8.9v2.53h8.9Z"/>
										<path class="cls-3 off" d="M127.2,167a9.59,9.59,0,0,0-9.59,9.6c0,5.3,9.59,20.26,9.59,20.26s9.6-15,9.6-20.26A9.6,9.6,0,0,0,127.2,167Zm0,13a3.74,3.74,0,1,1,3.73-3.74A3.74,3.74,0,0,1,127.2,180Z"/>
									</g>
									<!-- 서귀포시 -->
									<g id="SE" data-area="SE" data-areanm="서귀포시">
										<path class="cls-1 off" d="M447,272.78l-12.42-38.39q-11.5-35.55-23-71.08c-5.27,1.56-10.5,3.32-15.67,5.33-23.62,9.17-44.11,24.26-66,36.69a307.89,307.89,0,0,1-56.79,24.5c-.21.4-.42.8-.62,1.21-.3.61-.58,1.23-.86,1.85l-.05.11h0c-.1.26-.21.51-.31.76-.45,1.15-.86,2.31-1.24,3.48a90.66,90.66,0,0,0-3.36,15.2l-.08.55c0,.16-.05.34-.06.41-.07.55-.13,1.11-.2,1.66-.12,1-.24,2.09-.35,3.13-.25,2.38-.46,4.76-.67,7.14q-.72,8.18-1.4,16.35-1.36,16.37-2.57,32.73-1.25,16.92-2.33,33.85c4.57-3.47,9.12-6.12,13.54-1.7,9.64,9.64,13.5,7.72,22.49,4.78s16.07-10.56,41.54-2.21,50.7-.32,71.58-18.64c13.27-11.63,2.58-19.92,48.85-12.21a103.84,103.84,0,0,0,10.6,1.23c-2.34-3.56-4.6-7.16-6.6-10.92C455,297.25,451,285,447,272.78Z"/>
										<path class="cls-2 off" d="M321.22,280.46c0,3.7,1.85,7.3,4.83,8.71L324.73,291a9.74,9.74,0,0,1-4.61-6,10.3,10.3,0,0,1-4.68,6.29l-1.4-1.8c3-1.52,4.93-5.35,4.93-9.07v-3.28h2.25Zm9.12-4.93v19.94h-2.25V283.91h-4.16v-1.84h4.16v-6.54Z"/>
										<path class="cls-2 off" d="M346.55,286.05c-1.88.24-3.8.44-5.69.53v7.78h-2.24v-7.67c-1.73.06-3.39.08-4.9.08l-.28-1.87c2.48,0,5.33,0,8.13-.17a34.08,34.08,0,0,0,.58-5.86h-7V277h9.23V278a36.8,36.8,0,0,1-.52,6.63c.89-.07,1.75-.14,2.59-.25Zm3.32-10.48v19.87h-2.22V275.57Z"/>
										<path class="cls-2 off" d="M370.63,291.22v1.87H353v-1.87h7.68v-4.09h-6.15V285.3h2.81v-6.12h-2.87v-1.82h14.64v1.82h-2.87v6.12H369v1.83h-6.16v4.09Zm-11.12-5.92H364v-6.12h-4.48Z"/>
										<path class="cls-2 off" d="M379.56,280.48c0,3.65,2,7.31,5,8.71L383.31,291a9.88,9.88,0,0,1-4.83-6,10.29,10.29,0,0,1-5,6.4l-1.31-1.89c3.1-1.43,5.13-5.24,5.13-9.07v-3.26h2.22Zm8.84-4.93v19.94h-2.24V275.55Z"/>
										<path class="cls-3 off" d="M353.42,236.32a9.59,9.59,0,0,0-9.59,9.59c0,5.3,9.59,20.26,9.59,20.26s9.6-15,9.6-20.26A9.59,9.59,0,0,0,353.42,236.32Zm0,13a3.73,3.73,0,1,1,3.73-3.73A3.73,3.73,0,0,1,353.42,249.29Z"/>
									</g>
									<!-- 서귀포시 서부-->
									<g id="WS" data-area="WS" data-areanm="서귀포시 서부">
										<path class="cls-1 off" d="M254.41,276.24c.86-10.2,1.52-20.49,3.32-30.58a83.39,83.39,0,0,1,3-12c-46.76,13.6-95.27,19.72-142.24,32.44-34.14,9.25-68.11,22.11-96.84,42.81,3.85,8.23,5.47,17.36,15.69,28,6,6.31,12.52,8,18.06,7.79a12.61,12.61,0,0,1,12.19,8.07c4.67,11.72,24.76,23.17,41.74,29.78,23.14,9,24.42-25.07,34.06-35.35S159.47,344,171,344.64s10.93,19.93,35.35,13.5,27-11.57,36.63-4.4a6.37,6.37,0,0,0,5.63,1.13q.36-6,.74-11.92Q251.58,309.58,254.41,276.24Z"/>
										<path class="cls-2 off" d="M107,309.76c0,3.69,1.85,7.3,4.83,8.71l-1.32,1.83a9.79,9.79,0,0,1-4.61-6,10.26,10.26,0,0,1-4.68,6.3l-1.4-1.81c3-1.52,4.94-5.35,4.94-9.06v-3.28H107Zm9.12-4.93v19.93h-2.24V313.21h-4.16v-1.85h4.16v-6.53Z"/>
										<path class="cls-2 off" d="M132.34,315.34c-1.87.25-3.79.44-5.69.53v7.79h-2.24V316c-1.73.07-3.39.09-4.9.09l-.28-1.87c2.48,0,5.33,0,8.13-.18a33,33,0,0,0,.58-5.85h-7v-1.85h9.23v.95a36.76,36.76,0,0,1-.52,6.62c.89-.06,1.75-.13,2.59-.24Zm3.32-10.47v19.87h-2.22V304.87Z"/>
										<path class="cls-2 off"  d="M156.43,320.52v1.87H138.75v-1.87h7.67v-4.1h-6.14V314.6h2.8v-6.12h-2.87v-1.83h14.64v1.83H152v6.12h2.83v1.82h-6.17v4.1ZM145.3,314.6h4.48v-6.12H145.3Z"/>
										<path class="cls-2 off"  d="M165.35,309.78c0,3.65,2,7.3,5.05,8.71l-1.3,1.81a9.91,9.91,0,0,1-4.83-6,10.31,10.31,0,0,1-5,6.41l-1.31-1.9c3.1-1.43,5.13-5.23,5.13-9.06v-3.26h2.22Zm8.84-4.93v19.93H172V304.85Z"/>
										<path class="cls-2 off"  d="M190.23,309.76c0,3.69,1.86,7.3,4.83,8.71l-1.31,1.83a9.81,9.81,0,0,1-4.62-6,10.26,10.26,0,0,1-4.68,6.3l-1.4-1.81c3-1.52,4.94-5.35,4.94-9.06v-3.28h2.24Zm9.12-4.93v19.93h-2.24V313.21H193v-1.85h4.16v-6.53Z"/>
										<path class="cls-2 off"  d="M220.22,318.32h-7.78v6.44h-2.22v-6.44h-7.66v-1.83h17.66Zm-2.18-4H204.7v-8.69h2.22v2.51h8.9v-2.51H218ZM215.82,310h-8.9v2.53h8.9Z"/>
										<path class="cls-3 off" d="M158.76,265.54a9.6,9.6,0,0,0-9.6,9.6c0,5.3,9.6,20.25,9.6,20.25s9.59-14.95,9.59-20.25A9.59,9.59,0,0,0,158.76,265.54Zm0,13a3.73,3.73,0,1,1,3.73-3.73A3.73,3.73,0,0,1,158.76,278.51Z"/>
									</g>
									<!-- 서귀포시 동부-->
									<g id="ES" data-area="ES" data-areanm="서귀포시 동부">
										<path class="cls-1 off"  d="M542.25,152.51c-40.23-.61-81.7-1.5-121,8.18l11.85,36.64c8.28,25.57,16.48,51.17,24.83,76.73,2,6,4,11.93,6.3,17.77l1,2.34,0,0,.1.24.37.84q.92,2.1,1.91,4.17,2,4.11,4.28,8.06c2.4,4.07,5,8,7.68,11.9,28-2.55,36.88-21.35,43.67-31,8.36-11.88,33.42-8.68,52.06-8.68S574,265,587.52,264.3s23.14-5.78,7.72-15.42S619.66,225.1,614.52,211s0-7.07,14.14-13.5,30.21-16.07,35.35-39.85c3.21-14.87,7.18-23.45,10.65-29.69-17,9.58-34.87,17.61-54.11,21.28C594.84,154.1,568.29,152.9,542.25,152.51Z"/>
										<path class="cls-2 off"  d="M495.73,214.68c0,3.7,1.86,7.31,4.83,8.72l-1.31,1.82a9.79,9.79,0,0,1-4.62-6,10.22,10.22,0,0,1-4.67,6.29l-1.41-1.8c3-1.52,4.94-5.35,4.94-9.07V211.4h2.24Zm9.12-4.93v19.94h-2.24V218.14h-4.16v-1.85h4.16v-6.54Z"/>
										<path class="cls-2 off"  d="M521.07,220.27c-1.88.24-3.8.44-5.69.53v7.79h-2.25v-7.68c-1.72.06-3.38.09-4.89.09l-.28-1.87c2.48,0,5.32,0,8.13-.18a34.07,34.07,0,0,0,.58-5.85h-7v-1.85h9.23v.94a36.8,36.8,0,0,1-.52,6.63c.88-.07,1.75-.13,2.59-.24Zm3.32-10.47v19.87h-2.22V209.8Z"/>
										<path class="cls-2 off"  d="M545.15,225.44v1.87H527.47v-1.87h7.68v-4.09H529v-1.83h2.8v-6.11h-2.86v-1.83h14.64v1.83h-2.87v6.11h2.82v1.83h-6.16v4.09ZM534,219.52h4.48v-6.11H534Z"/>
										<path class="cls-2 off"  d="M554.08,214.7c0,3.66,2,7.31,5,8.72l-1.29,1.8a9.88,9.88,0,0,1-4.83-6,10.32,10.32,0,0,1-5,6.4l-1.32-1.89c3.11-1.43,5.14-5.24,5.14-9.07v-3.25h2.22Zm8.84-4.92v19.93h-2.25V209.78Z"/>
										<path class="cls-2 off"  d="M525.7,245.79v1.85H508.11v-1.85h7.68v-2h-5.5v-6.73h13.26v1.8H512.49V242h11.19v1.83H518v2Zm-2.15,6.67c0,2.31-2.53,3.63-6.71,3.63s-6.7-1.32-6.7-3.63,2.54-3.61,6.7-3.61S523.55,250.17,523.55,252.46Zm-2.25,0c0-1.21-1.61-1.87-4.46-1.87s-4.44.66-4.44,1.87,1.6,1.87,4.44,1.87S521.3,253.69,521.3,252.46Z"/>
										<path class="cls-2 off"  d="M545.13,249.64h-7.79v6.45h-2.22v-6.45h-7.65v-1.83h17.66Zm-2.18-4H529.6V237h2.23v2.51h8.9V237H543Zm-2.22-4.36h-8.9v2.53h8.9Z"/>
										<path class="cls-3 off" d="M526.68,169.69a9.59,9.59,0,0,0-9.59,9.6c0,5.29,9.59,20.25,9.59,20.25s9.6-15,9.6-20.25A9.6,9.6,0,0,0,526.68,169.69Zm0,13a3.73,3.73,0,1,1,3.73-3.73A3.73,3.73,0,0,1,526.68,182.66Z"/>
									</g>
								</svg>

							</div>
						</div>
						<!-- 적용 -->
						<div class="fix-cta">
							<button href="#" class="result-btn decide comm-btn" id="decide_cta" onclick="fn_ClickSearch()">적용</button>
						</div>
					</div><!-- //hotel-wrapper -->
				</div>

				<a class="mw-hotel-people"  id="room_person_str">
					<img src="/images/mw/rent/rent-btn.png" alt="투숙객,객실">성인 2
				</a>

				<!-- 인원선택 / layer-popup -->
				<div id="hotel_count" class="popup-typeA hotel-count">
					<div class="hotel-wrapper">
						<a class="close-btn" onclick="ad_close_popup('#hotel_count')"></a>
						<div class="condition_title">
							<div class="title">인원 선택</div>
						</div>
						<div class="content-area">
							<div class="detail-area">
								<input type="hidden" name="sRoomNum" id="sRoomNum" value="${searchVO.sRoomNum}">
							</div>
							<div class="detail-area counting-area">
								<div class="counting">
									<div class="l-area">
										<strong class="sub-title">성인</strong>
										<span class="memo">만 13세 이상</span>
									</div>
									<div class="r-area">
										<button type="button" class="counting-btn" onclick="chg_person('-', 'Adult')"><img src="/images/mw/hotel/minus.png" loading="lazy" alt="빼기"></button>
										<span class="counting-text" id="AdultNum">${searchVO.sAdultCnt}</span>
										<button type="button" class="counting-btn" onclick="chg_person('+', 'Adult')"><img src="/images/mw/hotel/plus.png" loading="lazy" alt="더하기"></button>
									</div>
								</div>
								<input type="hidden" name="sAdultCnt" value="${searchVO.sAdultCnt}">
								<div class="counting">
									<div class="l-area">
										<strong class="sub-title">소아</strong>
										<span class="memo">만 2 ~ 13세 미만</span>
									</div>
									<div class="r-area">
										<button type="button" class="counting-btn" onclick="chg_person('-', 'Child')"><img src="/images/mw/hotel/minus.png" loading="lazy" alt="빼기"></button>
										<span class="counting-text" id="ChildNum">${searchVO.sChildCnt}</span>
										<button type="button" class="counting-btn" onclick="chg_person('+', 'Child')"><img src="/images/mw/hotel/plus.png" loading="lazy" alt="더하기"></button>
									</div>
								</div>
								<input type="hidden" name="sChildCnt" value="${searchVO.sChildCnt}">
								<div class="counting">
									<div class="l-area">
										<strong class="sub-title">유아</strong>
										<span class="memo">만 2세(24개월) 미만</span>
									</div>
									<div class="r-area">
										<button type="button" class="counting-btn" onclick="chg_person('-', 'Baby')"><img src="/images/mw/hotel/minus.png" loading="lazy" alt="빼기"></button>
										<span class="counting-text" id="BabyNum">${searchVO.sBabyCnt}</span>
										<button type="button" class="counting-btn" onclick="chg_person('+', 'Baby')"><img src="/images/mw/hotel/plus.png" loading="lazy" alt="더하기"></button>
									</div>
								</div>
								<input type="hidden" name="sBabyCnt" value="${searchVO.sBabyCnt}">
							</div>
							<div class="detail-area info-area">
								<ul class="list-disc sm">
									<li>* 업체별로 연령 기준은 다를 수 있습니다.</li>
								</ul>
							</div>
							<div class="fix-cta">
								<!-- 적용/다음 CTA 수정 -->
								<button href="#" class="result-btn decide comm-btn" onclick="fn_ClickSearch()">적용</button>
							</div>
						</div>
					</div>
				</div><!-- //인원선택 / layer-popup --><!-- //인원선택 -->
			</div><!-- // mw-hotel-header -->



		<!--//change contents-->
		<div class="mw-list-area ad search">
			<input type="hidden" name="scroll" id="scroll" value="" />
			<input type="hidden" name="pageUnit" id="pageUnit" value="1000" />
			<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
			<input type="hidden" name="sAdDivCdView" id="sAdDivCdView" value="${searchVO.sAdDivCdView}" />
			<input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />
			<input type="hidden" name="sLON" id="sLON" />
			<input type="hidden" name="sLAT" id="sLAT" />
			<input type="hidden" name="prdtNum" id="prdtNum" />
			<input type="hidden" name="sPrdtNum" id="sPrdtNum" />
			<input type="hidden" name="sSearchYn" id="sSearchYn" value="Y" />
			<input type="hidden" name="sResEnable" id="sResEnable" value="${searchVO.sResEnable}" />
			<input type="hidden" name="sMen" id="sMen" value="${searchVO.sMen}">
			<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
			<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
			<input type="hidden" name="sNights" id="sNights" value="${searchVO.sNights}">
			<input type="hidden" name="sDaypriceYn" id="sDaypriceYn" value="${searchVO.sDaypriceYn}">
			<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>
			<input type="hidden" name="sAdAdar" id="sAdAdar" value="${searchVO.sAdAdar}" />
			<section class="search-typeA">
				<h2 class="sec-caption">상품 검색</h2>
				<div class="form">
					<div class="option">
						<input type="text" class="search-hotel" name="sPrdtNm" id="sPrdtNm" value="" placeholder="숙소명 검색해 주세요.">
						<button type="button" onclick="fn_AdSearch(1);" class="search-btn-hotel" title="검색">검색</button>
						<button type="button" class="map-btn" onclick="go_map()">지도</button>
						<button type="button" class="btn">필터</button>
						<div class="option-btn col2">
							<div id="hotel_option" class="popup-typeA hotel-option">
								<div class="hotel-wrapper">
                                    <div class="close_wrapper">
									    <a class="close-btn" onclick="ad_close_popup('#hotel_option')"></a>
                                    </div>
									<div class="content-area filter">
										<strong class="condition_title">조건을 선택해주세요.</strong>
										<div class="list-group">
											<strong class="sub-title">탐나는전 가맹점</strong>
											<ul class="select-menu col3">
												<li>
													<div class="lb-box">
														<input id="sTamnacardYn" name="sTamnacardYn" value="Y" type="checkbox" <c:if test="${searchVO.sTamnacardYn eq 'Y'}">checked</c:if>>
														<label for="sTamnacardYn"><span></span>탐나는전</label>
													</div>
												</li>
											</ul>
										</div>

		<%--								<div class="list-group">
											<strong class="sub-title">할인쿠폰</strong>
											<ul class="select-menu col3">
												<li>
													<div class="lb-box">
														<input id="sCouponCnt" name="sCouponCnt" value="1" type="checkbox" <c:if test="${searchVO.sCouponCnt eq '1'}">checked</c:if>>
														<label for="sCouponCnt"><span></span>할인쿠폰</label>
													</div>
												</li>
											</ul>
										</div>--%>

										<div class="list-group">
											<strong class="sub-title">숙소 유형</strong>
											<ul class="select-menu col3">
												<li>
													<div class="lb-box">
														<input id="adDiv0" name="sAdDiv" type="radio" value="" <c:if test="${empty searchVO.sAdDiv }">checked</c:if>>
														<label for="adDiv0">전체</label>
													</div>
												</li>
												<c:forEach var="data" items="${cdAddv}" varStatus="status">
													<li>
														<div class="lb-box">
															<input id="adDiv${status.count }" name="sAdDiv" type="radio" value="${data.cdNum}" <c:if test="${data.cdNum eq searchVO.sAdDiv }">checked</c:if>>
															<label for="adDiv${status.count }">${data.cdNm}</label>
														</div>
													</li>
												</c:forEach>
											</ul>
										</div>
										<div class="list-group">
											<strong class="sub-title">정렬</strong>
											<ul class="select-menu col3">
												<li>
													<div class="lb-box">
														<input id="orderCd1" name="orderCd" type="radio" value="${Constant.ORDER_GPA}" <c:if test="${Constant.ORDER_GPA == searchVO.orderCd}">checked</c:if>>
														<label for="orderCd1">탐나오 추천</label>
													</div>
												</li>
												<li>
													<div class="lb-box">
														<input id="orderCd2" name="orderCd" type="radio" value="${Constant.ORDER_PRICE}" <c:if test="${Constant.ORDER_PRICE == searchVO.orderCd}">checked</c:if>>
														<label for="orderCd2">낮은가격순</label>
													</div>
												</li>
												<li>
													<div class="lb-box">
														<input id="orderCd3" name="orderCd" type="radio" value="${Constant.ORDER_PRICE_DESC}" <c:if test="${Constant.ORDER_PRICE_DESC == searchVO.orderCd}">checked</c:if>>
														<label for="orderCd3">높은가격순</label>
													</div>
												</li>
												<li>
													<div class="lb-box">
														<input id="orderCd4" name="orderCd" type="radio" value="${Constant.ORDER_SALE}" <c:if test="${Constant.ORDER_SALE == searchVO.orderCd}">checked</c:if>>
														<label for="orderCd4">판매순</label>
													</div>
												</li>
												<li>
													<div class="lb-box">
														<input id="orderCd5" name="orderCd" type="radio" value="${Constant.ORDER_NEW}" <c:if test="${Constant.ORDER_NEW == searchVO.orderCd}">checked</c:if>>
														<label for="orderCd5">최신상품순</label>
													</div>
												</li>
											</ul>
										</div>

										<div class="list-group">
											<strong class="sub-title">가격</strong>
											<div class="select-menu col3">
												<ul>
													<li>
														<div class="lb-box">
															<input type="radio" name="sPriceSe" id="sPriceSe1" value="" <c:if test="${empty searchVO.sPriceSe}">checked</c:if>>
															<label for="sPriceSe1">전체</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input type="radio" name="sPriceSe" id="sPriceSe2"  value="1" <c:if test="${searchVO.sPriceSe=='1'}">checked</c:if>>
															<label for="sPriceSe2">~5만원</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input type="radio" name="sPriceSe" id="sPriceSe3" value="2" <c:if test="${searchVO.sPriceSe=='2'}">checked</c:if>>
															<label for="sPriceSe3">5~10만원</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input type="radio" name="sPriceSe"  id="sPriceSe4" value="3" <c:if test="${searchVO.sPriceSe=='3'}">checked</c:if>>
															<label for="sPriceSe4">10~20만원</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input type="radio" name="sPriceSe" id="sPriceSe5" value="4" <c:if test="${searchVO.sPriceSe=='4'}">checked</c:if>>
															<label for="sPriceSe5">20만원~</label>
														</div>
													</li>
												</ul>
											</div>
										</div>
										<div class="list-group">
											<strong class="sub-title">편의시설</strong>
											<div class="select-menu col3">
												<ul>
													<c:forEach var="icon" items="${iconCd}" varStatus="status">
													<li>
														<div class="lb-box">
															<input id="sIconCd${status.count}" type="checkbox" name="sIconCd" value="${icon.cdNum}"<c:if test="${fn:indexOf(searchVO.sIconCd, icon.cdNum) ne -1 }"> checked</c:if>>
															<label for="sIconCd${status.count}">${icon.cdNm}</label>
														</div>
													</li>
													</c:forEach>
												</ul>
											</div>
										</div>
									</div>
									<!-- 적용 btn -->
									<div class="fix-cta">
										<button href="#" class="result-btn decide comm-btn" onclick="ad_close_popup('#hotel_option');fn_AdSearch(1)">적용</button>
									</div><!-- //적용 btn -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>

			<section class="hotel-list-area">
				<h2 class="sec-caption">숙소 목록</h2>
				<div id="prdtList"></div>

				<!-- 0921 로딩바개선 -->
				<div class="modal-spinner ad">
					<div class="loading-popup">
						<div class="spinner-con">
							<strong class="spinner-txt">제주여행 공공 플랫폼 탐나오</strong>
							<div class="spinner-sub-txt">
								<span>믿을 수 있는 상품 구매</span>
							</div>
						</div>
					</div>

					<div class="loading-wrap ad" style="display: none;">
						<div class="spinner-con"></div>
					</div>
				</div><!-- //0921 로딩바개선 -->
			</section>

			<div class="paging-wrap" id="moreBtn">
				<a href="javascript:void(0)" class="mobile" id="moreBtnLink">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>
			</div>
		</div> <!--//mw-list-area-->
		</form>
		<!--//change contents-->
	</main>
	
<script type="text/javascript" src="/js/jquery-ui-mw.js?version=${nowDate}"></script>
<script type="text/javascript" src="/js/moment.min.js?version=${nowDate}"></script>
<script type="text/javascript" src="/js/daterangepicker-ad.js?version=${nowDate}"></script>
<script type="text/javascript">
	let prevIndex = 0;

	function fn_AdSearch(pageIndex) {
		$("#pageIndex").val(pageIndex);
		$("#curPage").text(pageIndex);

		var parameters = $("#frm").serialize();

		$.ajax({
			type:"post",
			// dataType:"json",
			/*async:false,*/
			url:"<c:url value='/mw/ad/adList.ajax'/>",
			data:parameters,
			beforeSend:function(){

				if(pageIndex == 1) {
					$(".loading-popup").show();
					$(".loading-wrap").hide();
					$("#prdtList").hide();
				}else{
					$(".loading-wrap").show();
					$(".loading-popup").hide();
				}
				$(".modal-spinner").show();
			},

			success:function(data){
				if(pageIndex == 1) {
					$("#prdtList").show();
					$("#prdtList").html(data);
				} else {
					$("#prdtList").append(data);
				}
				$(".modal-spinner").hide();

				$("#totAdCnt").text($("input[name=totalCnt]").val() + " 개");
				$("#totPage").text($("input[name=totalPageCnt]").val());

				if (pageIndex == $("input[name=totalPageCnt]").val() || $("input[name=totalCnt]").val() == 0) {
					$("#moreBtn").hide();
				} else {
					$("#moreBtn").show();
				}
				++prevIndex;
				history.replaceState($("main").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
				currentState = history.state;
			},
			error:fn_AjaxError
		});
	}

	/** 인원수 변경 이벤트 */
	function chg_person(type, gubun) {
		var num = 0;

		if (type == '+') {
			num = eval($('#' + gubun + 'Num').text()) + 1;
		} else {
			num = eval($('#' + gubun + 'Num').text()) - 1;
		}
		// 최저 인원 수 - 성인 : 1, 소아&유아 : 0
		if (gubun == 'Adult') {
			if (num < 1) {
				num = 1;
			} else if (num > 30) {
				num = 30;
			}
		} else {
			if (num < 0) {
				num = 0;
			} else if (num > 30) {
				num = 30;
			}
		}
		$('#' + gubun + 'Num').text(num);
		$('input[name=s' + gubun + 'Cnt]').val(num);

		var sMen = eval($('#AdultNum').text()) + eval($('#ChildNum').text()) + eval($('#BabyNum').text());
		$('#sMen').val(sMen);

		modify_room_person();
	}

	// Hide Header on on scroll down
	var lastScrollTop = 0;
	var delta = 5;
	var navbarHeight = $('.head-wrap').outerHeight();

	$(window).scroll(function (event) {
		var st = $(this).scrollTop();

		if (Math.abs(lastScrollTop - st) <= delta)
			return;

		if (st > lastScrollTop && st > navbarHeight) {
			// Scroll Down
			$('.head-wrap').removeClass('nav-down').addClass('nav-up');
		} else {
			// Scroll Up
			if (st + $(window).height() < $(document).height()) {
				$('.head-wrap').removeClass('nav-up').addClass('nav-down');
			}
		}
		lastScrollTop = st;
	});

	//창 닫기
	function ad_close_popup(obj) {
		if (typeof obj == "undefined" || obj == "" || obj == null) {
			$('#dateRangePickMw').data('daterangepicker').hide();
		} else {
			$(obj).hide();
		}
		$('#dimmedB').fadeOut(20);
		$("html, body").removeClass("not_scroll");
		$('.side-btn').show();
		$('.back').show();
	}

	$(document).ready(function () {


		const currentState = history.state;
		if(currentState){
			$("#main").html(currentState);
			$(window).scrollTop($("#scroll").val());
		}else{
			fn_AdSearch(1);
		}

		$('#dateRangePickMw').daterangepicker({}, function (start, end, search) {
			//입실/퇴실일 설정
			const sFromDt = start.format('YYYY-MM-DD');
			const sToDt = end.format('YYYY-MM-DD');
			$("#sFromDt").val(sFromDt.replace(/-/gi, ""));
			$("#sToDt").val(sToDt.replace(/-/gi, ""));
			$("#startDt").val(sFromDt+ "(" + getDate(sFromDt) + ")");
			$("#endDt").val(sToDt+ "(" + getDate(sToDt) + ")");
		});


		// daterangepicker 이전버튼 close
		$(".date_before").click(function (){
			ad_close_popup("");
		});

		//더보기
		$('#moreBtnLink').click(function() {
			$('#moreBtn').hide();
			fn_AdSearch(eval($("#pageIndex").val()) + 1);
		});

		$( "#sPrdtNm").bind( "keydown", function( event ) {
			if(event.keyCode==13){
				fn_AdSearch(1);
			}
		}).autocomplete({
			source: function(request, response){
				$.ajax({
					url: "/mw/selectAdNmList.ajax",
					dataType: "json",
					data: {sPrdtNm : $( "#sPrdtNm").val() },
					success:function(json){
						response($.map(json.data,function(data){
							return{
								label:data.adNm,
								value:data.adNm
							};
						}));
					},
					error:function(json){
						alert("err"+json);
					}
				});
			},
			select: function(event, ui) {
				/*console.log(ui.item);*/
			},
			focus: function(event, ui) {
				return false;
			}
		});

		/** 인원 재계산 */
		modify_room_person();

		//지역 클릭
		$("#area_str").on("click", function(e){
			optionPopup('#hotel_zone', this);
			$('#dimmedB').show();
			$("html, body").addClass("not_scroll");
			$('.side-btn').hide();
			$('.back').hide();
			$("#header").removeClass("nonClick");
		});

		//입실일/퇴실일 클릭
		$("#searchAreaD").on("click", function(e){
			optionPopup('.daterangepicker', this);
			$('#dimmedB').show();
			$("html, body").addClass("not_scroll");
			$('.side-btn').hide();
			$('.back').hide();
		});

		//인원수 클릭
		$("#room_person_str").on("click", function(e){
			optionPopup('#hotel_count', this);
			$('#dimmedB').show();
			$("html, body").addClass("not_scroll");
			$('.side-btn').hide();
			$('.back').hide();
			$("#header").removeClass("nonClick");
		});

		//map-control
		var allStates =  $(".searchGroup").find("g");

		const adAdar = '${searchVO.sAdAdar}';
		if (adAdar == ""){
			allStates.attr("class","on");
		}else{
			const arrAdAdar =  adAdar.split(",");
			for(let i = 0; i < arrAdAdar.length; i++){
				$("#"+arrAdAdar[i]).attr("class","on");
			}
		}

		//map click
		allStates.on("click", function() {
			if ( $('.on').length == 6){
				allStates.attr("class","");
				$(this).attr("class","on");
			}else {
				if($(this).attr("class") == "on"){
					$(this).attr("class","off");
				}else{
					$(this).attr("class","on");
				}
			}
			setArea();
		});

		//지역 선택 값 설정
		function setArea(){
			let sAdAdar = [];
			$(".on").each(function (index,item){
				sAdAdar.push(item.getAttribute("data-area"));
				$("#sAdAdar").val(sAdAdar);
			});

			$("#sAdAdar").val(sAdAdar);
		}

		// Hide Header on on scroll down
		var didScroll;
		var lastScrollTop = 0;
		var delta = 5;
		var navbarHeight = $('.head-wrap').outerHeight();

		$(window).scroll(function (event) {
			didScroll = true;
		});

		setInterval(function () {
			if (didScroll) {
				hasScrolled();
				didScroll = false;
			}
		}, 250);

		function hasScrolled() {
			var st = $(this).scrollTop();

			// Make sure they scroll more than delta
			if (Math.abs(lastScrollTop - st) <= delta)
				return;

			// If they scrolled down and are past the navbar, add class .nav-up.
			// This is necessary so you never see what is "behind" the navbar.
			if (st > lastScrollTop && st > navbarHeight) {
				// Scroll Down
				$('.head-wrap').removeClass('nav-down').addClass('nav-up');
			} else {
				// Scroll Up
				if (st + $(window).height() < $(document).height()) {
					$('.head-wrap').removeClass('nav-up').addClass('nav-down');
				}
			}
			lastScrollTop = st;
		}

		$(".decideBtn").click(function (){
			ad_close_popup("");
		});

		// dimmed click lock 처리
		$("#dateRangePickMw").click(function (){
			$("#header").attr("class","transBG nonClick");
		});

		$("#dimmedB").click(function () {
			$(".daterangepicker").css("display","block");
		});

		//필터 click 시
		$(".btn").on("click", function(e){
			optionPopup('#hotel_option', this);
			$('#dimmedB').show();
			$("html, body").addClass("not_scroll");
			$('.side-btn').hide();
			$('.back').hide();
			$("#header").removeClass("nonClick");
		});
	})

	/** 적용버튼 클릭 시 */
	function fn_ClickSearch(){
		//모든 pop 비활성
		$("#hotel_count").css("display","none");
		$("#hotel_zone").css("display","none");
		$('#dateRangePickMw').data('daterangepicker').hide();
		$('#dimmedB').fadeOut(100);
		$("html, body").removeClass("not_scroll");
		$('.side-btn').show();
		$('.back').show();
		fn_AdSearch(1);
	}

	function fn_DetailPrdt(prdtNum, corpCd, corpId){
		if(prdtNum){
			$("#sPrdtNum").val(prdtNum);
			$("#prdtNum").val(prdtNum);
		}
		if(corpId){
			document.frm.action = "/mw/ad/detailPrdt.do?corpId=" + corpId;
			document.frm.submit();
		}else{
			document.frm.action = "<c:url value='/mw/ad/detailPrdt.do'/>";
			document.frm.submit();
		}

	}

	//상단 영역 클릭시 오동작 방지
	$(document).on("click", ".nonClick", function () {
		$('#dateRangePickMw').data('daterangepicker').show();
	});

	/** 인원 재계산 */
	function modify_room_person() {
		let str = "성인 " + $('#AdultNum').text();

		if ($('#ChildNum').text() > 0) {
			str += ", 소아 " + $('#ChildNum').text();
		}
		if ($('#BabyNum').text() > 0)	{
			str += ", 유아 " + $('#BabyNum').text();
		}
		$('#room_person_str').text(str);
		$('#room_person_str').append('<img src="/images/mw/rent/rent-btn.png" alt="투숙객">');
	}

	let doubleSubmitFlag = false;
	function doubleSubmitCheck() {
		if(doubleSubmitFlag) {
			return doubleSubmitFlag;
		} else {
			doubleSubmitFlag = true;
			return false;
		}
	}

	function go_map(){
		if(doubleSubmitFlag) {
			return;
		}
		doubleSubmitCheck();
		location.href = "/mw/map.do";
	}
</script>

<jsp:include page="/mw/foot.do"></jsp:include>
</div> <!-- //wrap -->
<div id="dimmedB"></div>
</body>
</html>
