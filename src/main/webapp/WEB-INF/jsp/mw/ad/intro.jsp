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

<head>
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="제주숙소 : 호텔, 펜션, 리조트, 제주도여행 공공플랫폼 탐나오"/>
	<jsp:param name="description" value="잊지 못할 여행을 위한 완벽한 숙박 플랫폼, 제주도가 지원하고 제주관광협회가 운영하는 탐나오"/>
	<jsp:param name="keywords" value="제주숙소,제주도숙소,제주숙박,제주도숙박,제주호텔,제주펜션,제주리조트,제주민박,제주게스트하우스,제주풀빌라"/>
</jsp:include>
<meta property="og:title" content="제주숙소 : 호텔, 펜션, 리조트, 제주도여행 공공플랫폼 탐나오">
<meta property="og:url" content="https://www.tamnao.com/mw/stay/jeju.do">
<meta property="og:description" content="잊지 못할 여행을 위한 완벽한 숙박 플랫폼, 제주도가 지원하고 제주관광협회가 운영하는 탐나오">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Light.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" href="/css/mw/common2.css?version=${nowDate}">
<link rel="stylesheet" href="/css/mw/style.css?version=${nowDate}">
<link rel="stylesheet" href="/css/mw/daterangepicker.css?version=${nowDate}">
<link rel="stylesheet" href="/css/mw/ad.css?version=${nowDate}">
<link rel="canonical" href="https://www.tamnao.com/web/stay/jeju.do">
<script type="application/ld+json">
{
 "@context": "https://schema.org",
 "@type": "BreadcrumbList",
 "itemListElement":
 [
  {
   "@type": "ListItem",
   "position": 1,
   "item":
   {
    "@id": "https://www.tamnao.com/",
    "name": "메인"
    }
  },
 {
   "@type": "ListItem",
  "position": 2,
  "item":
   {
     "@id": "https://www.tamnao.com/web/stay/jeju.do",
     "name": "제주숙소"
   }
  }
 ]
}
</script>

</head>
<body class="main">
<div id="hotel-sub" class="m_wrap">
    <jsp:include page="/mw/newMenu.do"></jsp:include>

    <!-- key-visual -->
    <main id="main">
        <div class="mw-detail-area">
            <!-- GNB -->
            <nav class="navigation">
                <ol class="category-bar">
                    <li class="navigation_tab">
                        <a href="/mw/av/mainList.do" class="navigation_title">
                            <span>항공</span>
                        </a>
                    </li>
                    <li class="navigation_tab active-tab">
                        <a href="/mw/stay/jeju.do" class="navigation_title">
                            <span>숙소</span>
                        </a>
                    </li>
                    <li class="navigation_tab">
                        <a href="/mw/rentcar/jeju.do" class="navigation_title">
                            <span>렌터카</span>
                        </a>
                    </li>
                    <li class="navigation_tab">
                        <a href="/mw/tour/jeju.do" class="navigation_title">
                            <span>관광지/레저</span>
                        </a>
                    </li>
                    <li class="navigation_tab">
                        <a href="/mw/goods/jeju.do " class="navigation_title">
                            <span>특산/기념품</span>
                        </a>
                    </li>
                </ol>
            </nav><!-- //GNB -->
            <c:if test="${not empty adPrmt.prmtNum}">
            <section class="key-visual">
                <a href="/mw/evnt/detailPromotion.do?prmtNum=${adPrmt.prmtNum}">
                    <div class="banner_grid-wrapper">
                        <div class="ad_top_banner">
                            <div class="banner_title">
                                <h2 class="banner-title">독채 펜션부터 특급호텔까지, <span class="ad-blue-txt">제주 감성 숙소는 탐나오</span></h2>
                            </div>
                            <div class="banner_text">
                                <div class="banner-text">Brand New! 탐나오의 신규 상품을 5% 할인된 가격으로 만나보세요</div>
                            </div>
                        </div>
                        <div class="banner_image">
                            <img src="../../../images/mw/hotel/hotel-visual.png" alt="숙소">
                        </div>
                    </div>
                </a>
            </section><!-- //key-visual -->
            </c:if>

            <form name="frm" id="frm" method="get" onSubmit="return false;">
<%--                <input type="hidden" name="sAdAdarChk" id="sAdAdarChk">--%>
                <input type="hidden" name="sAdAdar" id="sAdAdar">
                <input type="hidden" name="sFromDt" id="sFromDt">
                <input type="hidden" name="sToDt" id="sToDt">
                <input type="hidden" name="sNights" id="sNights">
                <input type="hidden" name="sTamnacardYn" id="sTamnacardYn">
                <input type="hidden" name="sDaypriceYn" id="sDaypriceYn">

                <!--인원설정-->
                <input type="hidden" name="sAdultCnt" id="sAdultCnt" value="2">
                <input type="hidden" name="sChildCnt" id="sChildCnt"  value="0">
                <input type="hidden" name="sBabyCnt" id="sBabyCnt"  value="0">
                <input type="hidden" name="sMen" id="sMen"  value="2">

                <!--숙소 detail 이동-->
                <input type="hidden" name="prdtNum" id="prdtNum">
                <input type="hidden" name="sPrdtNum" id="sPrdtNum">
                <!-- index-box-search -->
                <div class="index-box-search">
                    <div class="mw-search-area" >
                        <div class="search-area hotel">
                            <!-- 제주도 여행지(목적지) -->
                            <div class="area zone count select" id="searchArea">
                                <dl class="destination add-items">
                                    <dt class="hide">지역</dt>
                                    <dd class="value-group">
                                        <span class="value-text">제주도 여행지를 선택해주세요</span>
                                        <p class="value-sub-text" id="txtAreaNm">제주도 전체</p>
                                    <dd class="value-img">
                                        <span class="search">
                                            <img src="../../../images/mw/hotel/search.png" alt="검색">
                                        </span>
                                    </dd>
                                </dl>
                            </div>
                            <!-- 제주도 여행지 / layer-popup -->
                            <div id="hotel_zone" class="popup-typeA hotel-zone">
                                <div class="hotel-wrapper">
                                    <%-- <a class="close-btn" onclick="ad_close_popup('#hotel_zone')"></a> --%>
                                    <span class="close-btn" onclick="ad_close_popup('#hotel_zone')"></span>
                                    <div class="condition_title">
                                        <div class="title">여행지 근처 숙소 찾으시나요?</div>
                                    </div>
                                    <div class="quick_search" >
                                        <div class="searchIcon inpDeleteAni staySearch">
                                            <input type="text" title="목적지, 지역 명, 숙소 명으로 검색" id="staySearchBox" placeholder="목적지, 지역 명, 숙소 명으로 검색" class="inSear">
                                            <button type="button" class="icDel" style="display: none;">삭제</button>
                                        </div>
                                    </div>
                                    <div class="searchTabGroup stay">
                                        <div class="searchGroup quick_mapArea">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680.9 384.06" class="us">
                                                <!-- 제주시 동부 -->
                                                <g data-area="EA" data-areanm="제주시 동부">
                                                    <path class="cls-1 off" d="M441.3,104.18a363.77,363.77,0,0,1-20.88,46.42c44-10.58,90.14-8.44,135-7.91,26,.31,52.51.89,77.56-6.92,17-5.3,32.71-13.79,47.88-23.09-1.23-4.68-7.51-8.17-16.85-11-12.82-3.86-9.68-8.36-3.9-16.07s5.79-12.86-4.5-19.28-5.14-2.58-17.35-18-16.71-5.79-31.49-5.14S594,33.57,585,14.93s-21.21-3.86-30.85-3.22S534.82-5,521.32,1.43,504.61,13,486,12.21c-11.83-.49-18.48,3.06-24.72,6.88-1.1,10-2.57,19.93-4.48,29.78A357.12,357.12,0,0,1,441.3,104.18Z"/>
                                                    <path class="cls-2 off" d="M506.66,79.66c0,3.39,1.26,6.82,4,8.43l-1.29,1.65a9,9,0,0,1-3.73-5.37,9.83,9.83,0,0,1-3.82,5.85l-1.33-1.67c2.75-1.76,4.05-5.35,4.05-8.89V78.23h-3.43V76.36h8.8v1.87h-3.22Zm4.66-5.08h2.09V93.11h-2.09V83h-2.87V81.18h2.87Zm6-.4V94.05h-2.11V74.18Z"/>
                                                    <path class="cls-2 off" d="M537.75,87.21H530V94.1h-2.22V87.21h-7.63V85.38h17.62Zm-16.62-5.06c3.71-.51,6.45-2.69,6.58-5h-5.93V75.33h14.34v1.82h-5.89c.13,2.31,2.87,4.49,6.58,5l-.8,1.78c-3.21-.48-5.87-2.11-7-4.31-1.19,2.2-3.82,3.83-7,4.31Z"/>
                                                    <path class="cls-2 off" d="M546.74,79.11c0,3.65,2,7.31,5,8.71l-1.29,1.81a9.85,9.85,0,0,1-4.83-6,10.32,10.32,0,0,1-5,6.4l-1.32-1.89c3.11-1.43,5.13-5.24,5.13-9.07V75.85h2.22Zm8.84-4.93V94.12h-2.24V74.18Z"/>
                                                    <path class="cls-2 off" d="M528.07,110.2v1.85H510.48V110.2h7.68v-2h-5.5v-6.74h13.26v1.81H514.86v3.1h11.19v1.83h-5.67v2Zm-2.15,6.66c0,2.31-2.53,3.63-6.71,3.63s-6.7-1.32-6.7-3.63,2.54-3.6,6.7-3.6S525.92,114.58,525.92,116.86Zm-2.25,0c0-1.21-1.61-1.87-4.46-1.87s-4.44.66-4.44,1.87,1.6,1.88,4.44,1.88S523.67,118.1,523.67,116.86Z"/>
                                                    <path class="cls-2 off" d="M547.5,114.05h-7.79v6.44h-2.22v-6.44h-7.65v-1.83H547.5Zm-2.18-4H532v-8.7h2.23v2.51h8.9v-2.51h2.22Zm-2.22-4.36h-8.9v2.53h8.9Z"/>
                                                    <path class="cls-3 off" d="M529.09,35.1a9.59,9.59,0,0,0-9.6,9.59c0,5.3,9.6,20.26,9.6,20.26s9.6-15,9.6-20.26A9.59,9.59,0,0,0,529.09,35.1Zm0,13a3.73,3.73,0,1,1,3.73-3.73A3.73,3.73,0,0,1,529.09,48.07Z"/>
                                                </g>
                                                <!-- 시내권 -->
                                                <g data-area="JE" data-areanm="시내권">
                                                    <path class="cls-1 off" d="M185.84,110.08c3.74,5.84,6.58,12.18,9.63,18.38,1.51,3.06,3.07,6.1,4.82,9,.9,1.52,1.85,3,2.87,4.46.31.45.64.89,1,1.33l.44.57c.26.31.51.63.78.93a40.41,40.41,0,0,0,3.61,3.79c.6.55,1.22,1.06,1.84,1.58l.12.11.13.09.94.67a54,54,0,0,0,8.08,4.48c.83.38,1.65.74,2.48,1.1.36.16.72.32,1.08.46-1.18-.47,0,0,.24.1,1.71.72,3.43,1.43,5.14,2.16a86.14,86.14,0,0,1,8.36,4,41,41,0,0,1,14,12.76c3.24,4.72,5.5,10,7.7,15.28.56,1.34,1.11,2.69,1.67,4l.39.93,0,.14c.23.58.5,1.15.75,1.73,1.07,2.45,2.2,4.88,3.5,7.22.65,1.16,1.33,2.3,2.08,3.41.35.53.72,1,1.09,1.56l0,0c.19.23.37.46.56.68a29.34,29.34,0,0,0,2.84,3c.08.07.71.62,1.12,1l.36.25.8.55a5.4,5.4,0,0,1,2.06,2.49,322.69,322.69,0,0,0,63.93-30.71c21.46-13.22,42.72-26,67-33.36l.35-.1a4.84,4.84,0,0,1,.61-2q7.83-13.89,14.41-28.43c1-2.19,1.95-4.38,2.9-6.58.14-.34.28-.68.43-1l0-.06c.2-.49.41-1,.61-1.45.46-1.11.91-2.22,1.36-3.33q2.64-6.57,5-13.23,4.76-13.32,8.44-27t6.31-27.8Q449,36.28,450,29.39c.11-.74.21-1.48.32-2.22,0-.21,0-.42.08-.63v-.05c.06-.51.13-1,.19-1.52l-.59.24c-11.57,4.5-17.35,0-26.35-9s-18.64,0-18.64,0c-12.21,0-20.57,7.72-42.74,19.28S318.87,49,298.62,47.06s-25.07,7.72-38.56,26-26,7.72-40.5,11.57-10.6,7.72-30.85,4.82c-6.3-.9-13.07.82-19.82,4C176.05,97.23,181.53,103.36,185.84,110.08Z"/>
                                                    <path class="cls-2 off" d="M303,141.22c0,3.66,2,7.31,5,8.72l-1.29,1.8a9.88,9.88,0,0,1-4.83-6,10.29,10.29,0,0,1-5,6.4l-1.31-1.89c3.1-1.43,5.13-5.24,5.13-9.07V138H303Zm8.84-4.93v19.94h-2.24V136.29Z"/>
                                                    <path class="cls-2 off" d="M318.34,149.23a35.61,35.61,0,0,0,5.72-.59l.24,1.93a36.3,36.3,0,0,1-6.88.6h-1.3V138.6h2.22Zm13.48-12.91v19.87h-2.11v-10.1H327.4v9.1h-2.09V136.71h2.09v7.51h2.31v-7.9Z"/>
                                                    <path class="cls-2 off" d="M339.84,145.73c-1.79.09-3.51.11-5,.11l-.31-1.8c2.42,0,5.37,0,8.28-.24a35.11,35.11,0,0,0,.46-4.54H336.3v-1.84h9.15v.74a33.59,33.59,0,0,1-.39,5.46c.67-.06,1.36-.15,2-.24l.17,1.61c-1.71.28-3.47.5-5.2.61v4.45h-2.22ZM351.35,154v1.85H337.3v-6.07h2.22V154Zm-2.67-6.91V136.32h2.22v15h-2.22v-2.48h-4.05v-1.79Z"/>
                                                    <path class="cls-3 off" d="M326.16,95.88a9.59,9.59,0,0,0-9.59,9.59c0,5.3,9.59,20.26,9.59,20.26s9.6-15,9.6-20.26A9.59,9.59,0,0,0,326.16,95.88Zm0,13a3.74,3.74,0,1,1,3.74-3.73A3.73,3.73,0,0,1,326.16,108.85Z"/>
                                                </g>
                                                <!-- 제주시 서부 -->
                                                <g data-area="WE" data-areanm="제주시 서부">
                                                    <path class="cls-1 off" d="M265.72,221.69A41.83,41.83,0,0,1,256.53,210c-1.41-2.6-2.63-5.3-3.79-8-.7-1.62-1.38-3.26-2.06-4.89-.3-.72-.59-1.45-.89-2.17-.17-.4-.32-.81-.51-1.2l0-.08a70.59,70.59,0,0,0-7.46-13.82l-.24-.3-.63-.74c-.42-.49-.86-1-1.31-1.43s-1-1-1.45-1.39l-.87-.76-.3-.25a37.17,37.17,0,0,0-7.74-4.61c-1.39-.67-2.81-1.3-4.23-1.91l-.5-.22-.81-.34-2.15-.89c-3.14-1.32-6.3-2.62-9.33-4.18A46,46,0,0,1,196.74,150c-8.52-11-12.56-24.42-20.22-35.9-.47-.7-1-1.39-1.45-2.07,0-.08-.37-.5-.47-.64l-.55-.68a45.07,45.07,0,0,0-3.37-3.68c-.66-.63-1.33-1.23-2-1.81-.15-.13-1.21-.9-.21-.18-.22-.16-.42-.32-.64-.47a32.75,32.75,0,0,0-4-2.46c-.46-.24-.93-.47-1.4-.69-.23-.11-1.3-.74-.24-.11a9.76,9.76,0,0,0-2.18-.78c-.7-.22-1.44-.44-2.18-.61-10.87,7.33-20.92,16.87-27.88,23.34-13.5,12.53-20.25-1.93-36.64,21.21s-28.92,40.49-54.23,54S5,245.66,5,245.66c-10.8,24.25-2.33,41.78,9.24,52.71.73.69,1.4,1.39,2,2.09C49.39,276.73,88.77,263,128.13,253.27,173.81,242,220.71,235.68,265.72,221.69Z"/>
                                                    <path class="cls-2 off" d="M78.53,212.36c0,3.39,1.25,6.83,4,8.43l-1.29,1.65a9,9,0,0,1-3.73-5.37,9.9,9.9,0,0,1-3.82,5.86l-1.34-1.68c2.76-1.76,4.06-5.34,4.06-8.89v-1.42H73v-1.87h8.79v1.87H78.53Zm4.66-5.08h2.09v18.53H83.19V215.73H80.32v-1.85h2.87Zm6-.39v19.87H87.11V206.89Z"/>
                                                    <path class="cls-2 off" d="M109.62,219.91h-7.74v6.89H99.66v-6.89H92v-1.82h17.61ZM93,214.85c3.71-.5,6.44-2.68,6.57-5H93.65V208H108v1.83H102.1c.13,2.31,2.86,4.49,6.57,5l-.79,1.78c-3.22-.48-5.87-2.11-7.06-4.31-1.18,2.2-3.81,3.83-7,4.31Z"/>
                                                    <path class="cls-2 off" d="M118.61,211.82c0,3.65,2,7.3,5,8.71l-1.3,1.8a9.91,9.91,0,0,1-4.83-6,10.26,10.26,0,0,1-5,6.4l-1.31-1.89c3.1-1.43,5.13-5.24,5.13-9.06v-3.26h2.22Zm8.84-4.93v19.93h-2.24V206.89Z"/>
                                                    <path class="cls-2 off" d="M143.49,211.79c0,3.7,1.86,7.31,4.83,8.72L147,222.33a9.76,9.76,0,0,1-4.62-6,10.21,10.21,0,0,1-4.68,6.29l-1.4-1.8c3-1.52,4.94-5.35,4.94-9.07v-3.28h2.24Zm9.12-4.93V226.8h-2.24V215.25h-4.16V213.4h4.16v-6.54Z"/>
                                                    <path class="cls-2 off" d="M173.48,220.35H165.7v6.45h-2.22v-6.45h-7.66v-1.82h17.66Zm-2.18-4H158v-8.69h2.22v2.51h8.9v-2.51h2.22ZM169.08,212h-8.9v2.53h8.9Z"/>
                                                    <path class="cls-3 off" d="M127.2,167a9.59,9.59,0,0,0-9.59,9.6c0,5.3,9.59,20.26,9.59,20.26s9.6-15,9.6-20.26A9.6,9.6,0,0,0,127.2,167Zm0,13a3.74,3.74,0,1,1,3.73-3.74A3.74,3.74,0,0,1,127.2,180Z"/>
                                                </g>
                                                <!-- 서귀포시 -->
                                                <g data-area="SE" data-areanm="서귀포시">
                                                    <path class="cls-1 off" d="M447,272.78l-12.42-38.39q-11.5-35.55-23-71.08c-5.27,1.56-10.5,3.32-15.67,5.33-23.62,9.17-44.11,24.26-66,36.69a307.89,307.89,0,0,1-56.79,24.5c-.21.4-.42.8-.62,1.21-.3.61-.58,1.23-.86,1.85l-.05.11h0c-.1.26-.21.51-.31.76-.45,1.15-.86,2.31-1.24,3.48a90.66,90.66,0,0,0-3.36,15.2l-.08.55c0,.16-.05.34-.06.41-.07.55-.13,1.11-.2,1.66-.12,1-.24,2.09-.35,3.13-.25,2.38-.46,4.76-.67,7.14q-.72,8.18-1.4,16.35-1.36,16.37-2.57,32.73-1.25,16.92-2.33,33.85c4.57-3.47,9.12-6.12,13.54-1.7,9.64,9.64,13.5,7.72,22.49,4.78s16.07-10.56,41.54-2.21,50.7-.32,71.58-18.64c13.27-11.63,2.58-19.92,48.85-12.21a103.84,103.84,0,0,0,10.6,1.23c-2.34-3.56-4.6-7.16-6.6-10.92C455,297.25,451,285,447,272.78Z"/>
                                                    <path class="cls-2 off" d="M321.22,280.46c0,3.7,1.85,7.3,4.83,8.71L324.73,291a9.74,9.74,0,0,1-4.61-6,10.3,10.3,0,0,1-4.68,6.29l-1.4-1.8c3-1.52,4.93-5.35,4.93-9.07v-3.28h2.25Zm9.12-4.93v19.94h-2.25V283.91h-4.16v-1.84h4.16v-6.54Z"/>
                                                    <path class="cls-2 off" d="M346.55,286.05c-1.88.24-3.8.44-5.69.53v7.78h-2.24v-7.67c-1.73.06-3.39.08-4.9.08l-.28-1.87c2.48,0,5.33,0,8.13-.17a34.08,34.08,0,0,0,.58-5.86h-7V277h9.23V278a36.8,36.8,0,0,1-.52,6.63c.89-.07,1.75-.14,2.59-.25Zm3.32-10.48v19.87h-2.22V275.57Z"/>
                                                    <path class="cls-2 off" d="M370.63,291.22v1.87H353v-1.87h7.68v-4.09h-6.15V285.3h2.81v-6.12h-2.87v-1.82h14.64v1.82h-2.87v6.12H369v1.83h-6.16v4.09Zm-11.12-5.92H364v-6.12h-4.48Z"/>
                                                    <path class="cls-2 off" d="M379.56,280.48c0,3.65,2,7.31,5,8.71L383.31,291a9.88,9.88,0,0,1-4.83-6,10.29,10.29,0,0,1-5,6.4l-1.31-1.89c3.1-1.43,5.13-5.24,5.13-9.07v-3.26h2.22Zm8.84-4.93v19.94h-2.24V275.55Z"/>
                                                    <path class="cls-3 off" d="M353.42,236.32a9.59,9.59,0,0,0-9.59,9.59c0,5.3,9.59,20.26,9.59,20.26s9.6-15,9.6-20.26A9.59,9.59,0,0,0,353.42,236.32Zm0,13a3.73,3.73,0,1,1,3.73-3.73A3.73,3.73,0,0,1,353.42,249.29Z"/>
                                                </g>
                                                <!-- 서귀포시 서부-->
                                                <g data-area="WS" data-areanm="서귀포시 서부">
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
                                                <g data-area="ES" data-areanm="서귀포시 동부">
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

                                    <div class="fix-cta">
                                        <a href="#" class="result-btn decide" id="decide_cta">적용</a>
                                        <a href="#" class="result-btn apply" id="apply_time">다음</a>
                                    </div>
                                </div><!-- //hotel-wrapper -->
                            </div>

                            <!-- 날짜선택-입실일,퇴실일 -->
                            <div id="dateRangePickMw" class="search-area hotel">
                                <div class="area take-over" id="searchAreaD">
                                    <dl>
                                        <dt>입실일</dt>
                                        <dd>
                                            <div class="value-text">
                                                <div class="date-container">
                                                    <div class="dateRangePickMw">
                                                        <input name="sFromDtView" id="sFromDtView"  value="0000. 00. 00 (-)" placeholder="입실일 선택" onfocus="this.blur()">
                                                    </div>
                                                </div>
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>퇴실일</dt>
                                        <dd>
                                            <div class="value-text">
                                                <div class="date-container">
                                                    <div class="dateRangePickMw">
                                                        <input name="sToDtView" id="sToDtView" value="0000. 00. 00 (-)" placeholder="퇴실일 선택" onfocus="this.blur()">
                                                    </div>
                                                </div>
                                            </div>
                                        </dd>
                                    </dl>
                                </div><!-- //날짜선택-입실일,퇴실일 -->
                            </div>

                            <!-- 인원선택 -->
                            <div class="area zone count select" id="searchAreaP">
                                <ul>
                                    <li class="separate">
                                        <span onfocus="this.blur()">
                                            <div class="guests_count">
                                                <div class="personnel">
                                                    <span>성인</span>
                                                    <span class="count" id="txtAdultCnt">2</span>
                                                </div>
                                            </div>
                                        </span>
                                    </li>
                                    <li class="separate">
                                        <span onfocus="this.blur()">
                                            <div class="guests_count">
                                                <div class="personnel">
                                                    <span>소아</span>
                                                    <span class="count" id="txtChildCnt">0</span>
                                                </div>
                                            </div>
                                        </span>
                                    </li>
                                    <li class="separate">
                                        <span onfocus="this.blur()">
                                            <div class="guests_count">
                                                <div class="personnel">
                                                    <span>유아</span>
                                                    <span class="count" id="txtBabyCnt">0</span>
                                                </div>
                                            </div>
                                        </span>
                                    </li>
                                </ul>
                            </div>

                            <!-- 인원선택 / layer-popup -->
                            <div id="hotel_count" class="popup-typeA hotel-count">
                                <div class="hotel-wrapper">
                                    <%-- <a class="before-btn option_before"></a> --%>
                                    <span class="before-btn option_before"></span>
                                    <div class="condition_title">
                                        <div class="title">인원 선택</div>
                                    </div>
                                    <div class="content-area">
                                        <div class="detail-area">
                                            <input type="hidden" name="sRoomNum" id="sRoomNum" value="1">
                                        </div>
                                        <div class="detail-area counting-area">
                                            <div class="counting">
                                                <div class="l-area">
                                                    <strong class="sub-title">성인</strong>
                                                    <span class="memo">만 13세 이상</span>
                                                </div>
                                                <div class="r-area">
                                                    <button type="button" class="counting-btn" onclick="chg_person('-', 'adult')"><img src="/images/mw/hotel/minus.png" loading="lazy" alt="빼기"></button>
                                                    <span class="counting-text" id="adultNum">2</span>
                                                    <button type="button" class="counting-btn" onclick="chg_person('+', 'adult')"><img src="/images/mw/hotel/plus.png" loading="lazy" alt="더하기"></button>
                                                </div>
                                            </div>

                                            <div class="counting">
                                                <div class="l-area">
                                                    <strong class="sub-title">소아</strong>
                                                    <span class="memo">만 2 ~ 13세 미만</span>
                                                </div>
                                                <div class="r-area">
                                                    <button type="button" class="counting-btn" onclick="chg_person('-', 'child')"><img src="/images/mw/hotel/minus.png" loading="lazy" alt="빼기"></button>
                                                    <span class="counting-text" id="childNum">0</span>
                                                    <button type="button" class="counting-btn" onclick="chg_person('+', 'child')"><img src="/images/mw/hotel/plus.png" loading="lazy" alt="더하기"></button>
                                                </div>
                                            </div>
                                            <div class="counting">
                                                <div class="l-area">
                                                    <strong class="sub-title">유아</strong>
                                                    <span class="memo">만 2세(24개월) 미만</span>
                                                </div>
                                                <div class="r-area">
                                                    <button type="button" class="counting-btn" onclick="chg_person('-', 'baby')"><img src="/images/mw/hotel/minus.png" loading="lazy" alt="빼기"></button>
                                                    <span class="counting-text" id="babyNum">${searchVO.sBabyCnt}</span>
                                                    <button type="button" class="counting-btn" onclick="chg_person('+', 'baby')"><img src="/images/mw/hotel/plus.png" loading="lazy" alt="더하기"></button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="detail-area info-area">
                                            <ul class="list-disc sm">
                                                <li>* 업체별로 연령 기준은 다를 수 있습니다.</li>
                                            </ul>
                                        </div>
                                        <div class="fix-cta">
                                            <!-- 0818 완료/다음 CTA 수정 -->
                                            <a href="#" class="result-btn decide" id="decide_cnt">적용</a>
                                            <a href="#" onclick="fn_ClickSearch()" class="result-btn apply">
                                                <div type="button" class="result-btn right">
                                                    <img src="../../../images/mw/rent/result-btn.png" loading="lazy" alt="최저가 검색">
                                                    최저가 검색
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- //인원선택 / layer-popup --><!-- //인원선택 -->

                            <!-- CTA -->
                            <div class="btn-wrap">
                                <a href="#" onclick="fn_ClickSearch()">
                                    <div type="button" class="comm-btn blue big">
                                        <div class="submit-button">
                                            <img src="../../../images/mw/rent/search.png" alt="검색">
                                            <div class="btn_comm">최저가 검색</div>
                                        </div>
                                    </div>
                                </a>
                            </div><!-- //CTA -->
                        </div> <!-- //search-area -->
                    </div> <!-- //mw-search-area -->
                </div><!-- //index-box-search -->
            </form>
            <!-- popular-keywords -->
            <%--<section class="popular-keywords">
                <ul>
                    <li>
                        <strong>인기키워드</strong>
                        <a href="/web/kwaSearch.do?kwaNum=82" role="button">#럭셔리 끝판왕</a>
                        <a href="/web/ad/productList.do?searchWord=%EB%8F%85%EC%B1%84&amp;searchYn=N" role="button">#독채펜션</a>
                        <a href="/web/kwaSearch.do?kwaNum=48" role="button">#공항근처숙박</a>
                    </li>
                </ul>

            </section>--%><!-- //popular-keywords -->

            <!-- hotel-info -->
            <section class="info-panels-new">
                <div class="snap">
                    <div class="variant-card">
                        <div class="image-container">
                            <img src="../../../images/mw/hotel/hotel-num-1.png" alt="제주여행">
                        </div>
                        <div class="content">
                            <h3>제주 여행 길잡이 / 편리한 여행계획</h3>
                            <span>항공, 렌터카, 숙소 등 여행의 모든과정 고민해결</span>
                        </div>
                    </div>
                    <div class="variant-card">
                        <div class="image-container">
                            <img src="../../../images/mw/hotel/hotel-num-2.png" alt="착한여행">
                        </div>
                        <div class="content">
                            <h3>'착한' 제주 여행</h3>
                            <span>사업체들과 상생.협력하는 탐나오와 함께하는 착한 소비!</span>
                        </div>
                    </div>
                    <div class="variant-card">
                        <div class="image-container">
                            <img src="../../../images/mw/hotel/hotel-num-3.png" alt="숙소예약">
                        </div>
                        <div class="content">
                            <h3>믿을 수 있는 / 신뢰할 수 있는 탐나오</h3>
                            <span>제주도가 지원하고 제주관광협회가 운영하는 '탐나오'</span>
                        </div>
                    </div>
                </div>
            </section><!-- //hotel-info -->

            <!-- line-banner -->
            <section>
                <div class="main-top-slider">
                    <div id="line_top_slider">
                        <ul >
                            <li id="lineBanner1" style="display: none">
                                <a href="javascript:fn_DaypriceSearch();">
                                    <div class="line-banner day-special">
                                        <img class="hotel-pic" src="../../../images/mw/hotel/hotel-pic-clock.png" loading="lazy" alt="당일특가">
                                        <em>잠깐! 당일특가 확인하셨나요?</em>
                                        <img class="hotel-icon" src="../../../images/mw/hotel/hotel-icon-bed.png" loading="lazy" alt="당일특가">
                                    </div>
                                </a>
                            </li>
                            <li id="lineBanner2"  style="display: none">
                                <a href="javascript:fn_tamnacardSearch();">
                                    <div class="line-banner jeju-pay">
                                        <img class="hotel-pic2" src="../../../images/mw/hotel/jeju-pay.png" loading="lazy" alt="탐나는전">
                                        <em>탐나는전 가맹점보기</em>
                                        <img class="hotel-icon2" src="../../../images/mw/hotel/hotel-icon_02.png" loading="lazy" alt="탐나는전">
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </section><!-- //line-banner -->

            <!-- promotion/best -->
            <div class="ad-List mw-list-area">
                <div class="according">

                    <!-- promotion -->
                    <div class="ad-list">
                        <div class="con-header">
                            <p class="con-title">숙소 Best!</p>
                        </div>
                        <div id="pop_Slider1" class="swiper-container">
                            <ul class="swiper-wrapper">
                                <c:forEach items="${bestList }" var="data" varStatus="status" >
                                    <li class="swiper-slide">
                                        <a href="/web/ad/detailPrdt.do?corpId=${data.corpId}" >
                                            <div class="main-photo">
                                                <img src="${data.savePath}thumb/${data.saveFileNm}" loading="lazy" alt="기획전" onerror="this.src='/images/web/other/no-image.jpg'">
                                            </div>
                                            <div class="main-text">
                                                <div class="j-info">${data.simpleExp}</div>
                                                <div class="j-title">${data.corpNm}</div>
                                                <div class="main-price"><fmt:formatNumber value='${data.saleAmt}'/><span class="won">원</span></div>
                                            </div>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div><!-- //promotion -->

                    <!-- best -->
                    <div class="ad-list">
                        <div class="con-header">
                            <p class="con-title">탐나오 promotion!</p>
                        </div>
                        <div id="pop_Slider2" class="swiper-container">
                            <ul class="swiper-wrapper">
                                <c:forEach items="${prmtList }" var="data2" varStatus="status" >
                                    <li class="swiper-slide">
                                        <a href="javascript:fn_DetailPrdt('${data2.prdtNum}', '${data2.corpCd}', '${todayDate}')">
                                            <div class="main-photo">
                                                <img src="${data2.savePath}thumb/${data2.saveFileNm}" loading="lazy" alt="기획전" onerror="this.src='/images/web/other/no-image.jpg'">
                                            </div>
                                            <div class="main-text">
                                                <div class="j-info">${data2.prmtContents}</div>
                                                <div class="j-title">${data2.adNm}</div>
                                                <div class="main-price"><fmt:formatNumber value='${data2.saleAmt}'/><span class="won">원</span></div>
                                            </div>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div><!-- //best -->
                </div>

                <!-- 기획전/이벤트 -->
                <div class="story-panels-new">
                    <div class="main-list">
                        <div class="con-header">
                            <p class="con-title">진행중인 기획전/이벤트</p>
                        </div>
                        <div class="main-top-slider">
                            <div id="main_top_slider" class="swiper-container">
                                <ul class="swiper-wrapper">
                                    <c:forEach items="${prmtIngList}" var="prmt" varStatus="status">
                                        <li class="swiper-slide" style="background-color: #c6f3ef">
                                            <div class="Fasten">
                                                <a href="${pageContext.request.contextPath}/mw/evnt/detailPromotion.do?prmtNum=${prmt.prmtNum}&winsYn=N&type=${fn:toLowerCase(prmt.prmtDiv)}">
                                                    <img src="${pageContext.request.contextPath}${prmt.mobileMainImg}" loading="lazy" alt="${prmt.prmtNm}">
                                                </a>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                                <div id="main_top_navi" class="swiper-pagination"></div>
                            </div>
                        </div>
                    </div>
                </div><!-- //기획전/이벤트 -->

                <!-- member-only -->
                <div class="members-only">
                    <div>
                        <dl class="benefits">
                            <dt class="hide">혜택</dt>
                            <dd class="value-group">
                                <span class="value-text">회원 전용 혜택을 누려보세요!</span>
                                <span class="value-sub-text">회원 가입 후 <span>맞춤 추천 정보와 특가상품</span>을 <br>확인하실 수 있습니다.</span>
                            </dd>
                            <dd class="value-move">
                                <!-- 회원가입으로 가기 -->
                                <a href="/mw/signUp00.do">
                                    <span class="search">가입하러 가기</span>
                                </a>
                            </dd>
                        </dl>
                    </div>
                </div><!-- //member-only -->
            </div>
        </div>
    </main>

    <!-- 푸터 s -->
    <jsp:include page="/mw/foot.do" />
    <!-- 푸터 e -->

<script src="/js/dimmed.js?version=${nowDate}"></script>
<script src="/js/moment.min.js?version=${nowDate}"></script>
<script src="/js/daterangepicker-ad.js?version=${nowDate}"></script>
<script>

    // 인원수 변경 이벤트
    function chg_person(type, gubun) {
        var num = 0;
        if (type == '+') {
            num = eval($('#' + gubun + 'Num').text()) + 1;
        } else {
            num = eval($('#' + gubun + 'Num').text()) - 1;
        }

        // 최저 인원 수 - 성인 : 1, 소아&유아 : 0
        if (gubun == 'adult') {
            if (num < 1) num = 1;
            else if (num > 30) num = 30;
        } else {
            if (num < 0) num = 0;
            else if (num > 30) num = 30;
        }

        $('#' + gubun + 'Num').text(num);
        $('input[name=s' + gubun + 'Cnt]').val(num);

        var sMen = eval($('#adultNum').text()) + eval($('#childNum').text()) + eval($('#babyNum').text());
        $('#sMen').val(sMen);

        setCnt();
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
        $('#dimmed').fadeOut(100);
        $("html, body").removeClass("not_scroll");
    }

    $(document).ready(function () {
        $('#dateRangePickMw').daterangepicker({}, function (start, end, search) {
            //입실/퇴실일 설정
            const sFromDt = start.format('YYYY-MM-DD');
            const sToDt = end.format('YYYY-MM-DD');
            $("#sFromDt").val(sFromDt.replace(/-/gi, ""));
            $("#sToDt").val(sToDt.replace(/-/gi, ""));
            $("#sFromDtView").val(sFromDt+ "(" + getDate(sFromDt) + ")");
            $("#sToDtView").val(sToDt+ "(" + getDate(sToDt) + ")");
            $("#sNights").val(parseInt(moment.duration(end.diff(start)).asDays()));
        });

        //메인 기획전 슬라이드
        if ($('#main_top_slider .swiper-slide').length > 1) {
            new Swiper('#main_top_slider', {
                pagination: '#main_top_navi',
                paginationClickable: true,
                autoplay: 5000,
                loop: true,
                paginationType: 'fraction' // 'bullets' or 'progress' or 'fraction' or 'custom'
            });
        }
        // dimmed lock scroll 처리
        var posY;

        $("#searchArea").on("click", function(e){
            optionPopup('#hotel_zone', this);
            $('#dimmed').show();
            $("html, body").addClass("not_scroll");
            $("#header").removeClass("nonClick");
        });

        $("#searchAreaD").on("click", function(e){
            optionPopup('.daterangepicker', this);
            $('#dimmed').show();
            $("html, body").addClass("not_scroll");
        });

        $("#searchAreaP").on("click", function(e){
            optionPopup('#hotel_count', this);
            $('#dimmed').show();
            $("html, body").addClass("not_scroll");
            $("#header").removeClass("nonClick");
        });

        // datepicker 화면에서 이전페이지 클릭 시
        $(".date_before").click(function () {
            $(".daterangepicker").hide();
            $("#hotel_zone").show();
        });

        // hotel_count 화면에서 이전페이지 클릭 시
        $(".option_before").click(function () {
            $("#hotel_count").hide();
            $('#dateRangePickMw').data('daterangepicker').show();
        });

        doSwiper();

        //map-control
        var allStates = $("svg.us > *");
        allStates.addClass("on");
        allStates.on("click", function() {
            if ( $('.on').length == 6){
                allStates.removeClass("on");
                $(this).addClass("on");
            }else {
                $(this).toggleClass("on", "");
            }

            setArea();
        });

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

        // 화면 사이즈별 슬라이드 설정
        var screenWidth = 360;
        var slideCnt = 2;
        var swiper1 = null;
        var swiper6 = null;

        function doSwiper() {
            screenWidth = $(window).width();

            if (screenWidth < 720) {
                slideCnt = 2;
            } else {
                slideCnt = 3;
            }
            //탐나오 promotion!
            if ($('#pop_Slider1 .swiper-slide').length > 1) {
                if (swiper1 != null) {
                    swiper1.destroy();
                }
                swiper1 = new Swiper('#pop_Slider1', {
                    spaceBetween: 20,
                    slidesPerView: slideCnt,
                    paginationClickable: true,
                    loop: true
                });
            }
            //숙소 BEST
            if ($('#pop_Slider2 .swiper-slide').length > 1) {
                if (swiper6 != null) {
                    swiper6.destroy();
                }
                swiper6 = new Swiper('#pop_Slider2', {
                    spaceBetween: 20,
                    slidesPerView: slideCnt,
                    paginationClickable: true,
                    loop: true
                });
            }
        }

        // 화면 사이즈 변경 이벤트
        $(window).resize(function () {
            var screenWidth2 = $(window).width();

            if (screenWidth2 >= 720) {
                if (screenWidth < 720) {
                    doSwiper();
                }
            } else {
                if (screenWidth >= 720) {
                    doSwiper();
                }
            }
            $(".bx-wrapper").css("max-width", screenWidth2);
        });

        $("#apply_time").click(function () {
            $("#hotel_zone").hide();
            $('#dateRangePickMw').data('daterangepicker').show();
        });

        /** 기본 값 설정 */
        paramBaseSet(1);

        //지역 완료 버튼 클릭
        $("#decide_cta").click(function (){
            $("#hotel_zone").hide();
            $('#dimmed').fadeOut(100);
            $("html, body").removeClass("not_scroll");
        });

        //일정 완료 버튼 클릭 시
        $("#decide_date").click(function (){
            $("#hotel_count").hide();
            $('#dimmed').fadeOut(100);
            $("html, body").removeClass("not_scroll");
        });

        //인원 완료 버튼 클릭 시
        $("#decide_cnt").click(function (){
            $("#hotel_count").hide();
            $('#dimmed').fadeOut(100);
            $("html, body").removeClass("not_scroll");
        });

        $(".decideBtn").click(function (){
            ad_close_popup("");
        });

        //line banner 랜덤 표출
        let randomNumber = Math.floor(Math.random() * 2) + 1;
        $("#lineBanner"+randomNumber).show();

        //history.back()으로 왔을 경우 처리
        window.onpageshow = function(event) {
            if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
                $("#hotel_count").hide();
                $('#dimmed').hide();
            }
        }

        $("#staySearchBox").click(function () {
            $("body").addClass("globalSearch-open");
            $("#dimmed").hide();
            $("#call-btn").hide();
        });

        // dimmed click lock 처리
        $("#dateRangePickMw").click(function (){
            $("#header").addClass("nonClick");
        });

        $("#dimmed").click(function () {
            $("#dateRangePickMw").css("display","block");
        });
    })

    $(document).on("click", ".nonClick", function () {
        $('#dateRangePickMw').data('daterangepicker').show();
    });

    //지역 선택 값 설정
    function setArea(){
        let sAdAdar = [];
        $("#txtAreaNm").text("");
        $(".on").each(function (index,item){
            sAdAdar.push(item.getAttribute("data-area"));
            $("#txtAreaNm").text($("#txtAreaNm").text() + item.getAttribute("data-areanm") + ",");
            $("#sAdAdar").val(sAdAdar);
        });
        $("#sAdAdar").val(sAdAdar);
        $("#txtAreaNm").text($("#txtAreaNm").text().slice(0,-1));
        if(sAdAdar.length == 6) {
            $("#txtAreaNm").text("제주도 전체");
        }
    }

    //인원 선택 값 설정
    function setCnt(){
        $("#sAdultCnt").val($("#adultNum").text());
        $("#sChildCnt").val($("#childNum").text());
        $("#sBabyCnt").val($("#babyNum").text());

        $("#txtAdultCnt").text($("#adultNum").text());
        $("#txtChildCnt").text($("#childNum").text());
        $("#txtBabyCnt").text($("#babyNum").text());
    }

    function fn_ClickSearch(){
        document.frm.action = "<c:url value='/mw/ad/productList.do'/>";
        document.frm.submit();
    }

    function fn_DetailPrdt(prdtNum, corpCd, fromDt, flag){
        if(prdtNum){
            $("#sPrdtNum").val(prdtNum);
            $("#prdtNum").val(prdtNum);
        }
        if(fromDt){
            $("#sFromDt").val(fromDt);
        }

        //document.frm.target = "_blank";
        document.frm.action = "<c:url value='/mw/ad/detailPrdt.do'/>";
        document.frm.submit();
    }

    function fn_tamnacardSearch(){
        paramBaseSet(1);
        $("#sTamnacardYn").val("Y");
        document.frm.action = "<c:url value='/mw/ad/productList.do'/>";
        document.frm.submit();
    }
	
    function fn_DaypriceSearch(){
        paramBaseSet(0);
        $("#sDaypriceYn").val("Y");
        document.frm.action = "<c:url value='/mw/ad/productList.do'/>";
        document.frm.submit();
    }

    //값 설정
    function paramBaseSet(addDay){
        //당일특가는 오늘  / 기본 설정은 오늘+1
        const today = new Date();
        const startDay = new Date(today.setDate(today.getDate() + addDay));
        const endDay = new Date(today.setDate(startDay.getDate() + 1));

        $("#sFromDt").val(startDay.getFullYear() + ('0' + (startDay.getMonth() + 1)).slice(-2) + ('0' + startDay.getDate()).slice(-2) );
        $("#sToDt").val(endDay.getFullYear() + ('0' + (endDay.getMonth() + 1)).slice(-2) + ('0' + endDay.getDate()).slice(-2) );
        $("#sFromDtView").val(startDay.getFullYear() + '. ' + ('0' + (startDay.getMonth() + 1)).slice(-2) + '. ' + ('0' + startDay.getDate()).slice(-2) + "(" + getDate(startDay) + ")");
        $("#sToDtView").val(endDay.getFullYear() + '. ' + ('0' + (endDay.getMonth() + 1)).slice(-2) + '. ' + ('0' + endDay.getDate()).slice(-2) + "(" + getDate(endDay) + ")");

        $("#sAdultCnt").val('2');
        $("#sChildCnt").val('0');
        $("#sBabyCnt").val('0');
        $("#sMem").val('2');
    }

    /**
     * App 체크
     * AA : 안드로이드 앱, AW : 안드로이드 웹, IA : IOS 앱, IW : IOS 웹
     */
    function fn_AppCheck() {
        var headInfo = ("${header['User-Agent']}").toLowerCase();
        var mobile = (/iphone|ipad|ipod|android|windows phone|iemobile|blackberry|mobile safari|opera mobi/i.test(headInfo));

        if (mobile) {
            if ((/android/.test(headInfo))) {
                if (/webview_android/.test(headInfo)) {
                    return "AA";
                } else {
                    return "AW";
                }
            } else if ((/iphone|ipad|/.test(headInfo))) {
                if (!(/safari/.test(headInfo))) {
                    return "IA";
                } else {
                    return "IW";
                }
            }
        } else {
            return "PC";
        }
    }

</script>
</div> <!-- //wrap -->
<div id="dimmed"></div>
</body>
</html>