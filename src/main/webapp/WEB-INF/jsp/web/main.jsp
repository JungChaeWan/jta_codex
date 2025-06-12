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
<jsp:include page="/web/includeJs.do">
    <jsp:param name="title" value="탐나오 TAMNAO - 제주도 공식 여행 공공 플랫폼"/>
    <jsp:param name="description" value="안전하고 편리한 제주여행 예약 플랫폼. 렌트카, 숙소, 관광지, 항공 예약 서비스 제공. 제주특별자치도관광협회 운영."/>
    <jsp:param name="keywords" value="제주여행, 제주렌트카, 제주숙소, 제주관광지, 제주특별자치도관광협회, 탐나오"/>
</jsp:include>
<meta property="og:title" content="탐나오 TAMNAO - 제주도 공식 여행 공공 플랫폼" >
<meta property="og:url" content="https://www.tamnao.com/">
<meta property="og:description" content="안전하고 편리한 제주여행 예약 플랫폼. 렌트카, 숙소, 관광지, 항공 예약 서비스 제공. 제주특별자치도관광협회 운영." />
<meta property="og:image" content="https://www.tamnao.com/data/sub_main/main_jeju.webp" >

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/select2.min.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" >
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" >
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/main.css?version=${nowDate}'/>" >
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/skeleton.css?version=${nowDate}'/>" >
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/daterangepicker-rc-pc.css?version=${nowDate}'/>">

<link rel="canonical" href="https://www.tamnao.com/">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fonts-archive/AppleSDGothicNeo/AppleSDGothicNeo.css" type="text/css"/>
<script defer src="<c:url value='/js/select2.min.js'/>"></script>
<%--수정필요--%>
<style>
    #product_theme .swiper-slide {margin-right: 37px;}
</style>
</head>
<body>
<header id="header">
    <jsp:include page="/web/head.do"></jsp:include>
</header>
<div id="_wrap">
    <!-- Main Top Slider -->
    <div class="mainPrimary">
        <div class="main-top-slider">
            <div id="main_top_slider" class="swiper-container">
                <ul class="swiper-wrapper">
                    <%--                    <c:forEach items="${prmtList}" var="prmt" varStatus="status">
                                        <c:if test="${prmt.prmtNum eq 'PM00001301'}">
                                        <li class="swiper-slide" style="background-color: #${prmt.bgColorNum}">
                                            <div class="main_visual">
                                                <a href="<c:url value='/web/evnt/detailPromotion.do'/>?prmtNum=${prmt.prmtNum}&winsYn=N"><img src="${prmt.mainImg}" alt="<c:out value='${prmt.corpNm}'/>"></a>
                                            </div>
                                        </li>
                                        </c:if>
                                        </c:forEach>--%>

                    <c:forEach items="${prmtList}" var="prmt" varStatus="prmtStatus">
                        <li class="swiper-slide">
                            <div class="main_visual">
                                <a href="<c:url value='/web/evnt/detailPromotion.do'/>?prmtNum=${prmt.prmtNum}&winsYn=N" aria-label="<c:out value='${prmt.prmtNm}'/>">
                                	<c:choose>
                                		<c:when test="${prmtStatus.count < 2}">
                                			<img src="${prmt.mainImg}" width="1920" height="450" alt="<c:out value='${prmt.prmtNm}'/>">	
                                		</c:when>
                                		<c:otherwise>
                                			<img src="${prmt.mainImg}" width="1920" height="450" loading="lazy" alt="<c:out value='${prmt.prmtNm}'/>">
                                		</c:otherwise>
                                	</c:choose>
                                </a>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <div class="main_visual_btn">
                    <div class="pass_over">
                        <span id="main_top_navi" class="swiper-pagination"></span>
                        <span id="main_top_prev" class="swiper-button-prev"></span>
                        <span id="main_top_next" class="swiper-button-next"></span>
                    </div>
                </div>
            </div>
        </div> <!-- //main-top-slider -->
    </div>
    <!-- //Main Top Slider -->

    <!-- 0406 예약 네비게이션 개선 -->
    <!-- 자차보험 안내 레이어팝업 -->
    <div id="insurance_info" class="comm-layer-popup_fixed">
        <div class="content-wrap">
            <div class="content">
                <div class="installment-head">
                    <button type="button" class="close" onclick="close_popup('#insurance_info')"><img src="/images/mw/icon/close/dark-gray.png" loading="lazy" alt="닫기" title="닫기"></button>
                    <div class="rent-qna">

                        <!-- car_insurance -->
                        <div class="car_insurance">
                            <div class="info-head">렌트카 자차보험 <span>안내</span></div>
                            <div class="free-wrap">
                                <div class="allguide">
                                    <table>
                                        <colgroup>
                                            <col style="width:16%">
                                            <col style="width:21%">
                                            <col style="width:21%">
                                            <col style="width:21%">
                                            <col style="width:21%">
                                        </colgroup>
                                        <thead>
                                            <th>구분</th>
                                            <th>일반자차</th>
                                            <th>일반자차(부분무제한)</th>
                                            <th>고급자차</th>
                                            <th>고급자차(전액무제한)</th>
                                        </thead>
                                        <tbody>
                                        <!-- 보상한도 -->
                                        <tr>
                                            <td class="aside_tit">보상한도</td>
                                            <td>한도 내 보상</td>
                                            <td>무제한</td>
                                            <td>한도 내 보상</td>
                                            <td>무제한</td>
                                        </tr><!-- //보상한도 -->

                                        <!-- 면책금 -->
                                        <tr>
                                            <td class="aside_tit">면책금</td>
                                            <td>면책금 발생</td>
                                            <td>면책금 발생</td>
                                            <td>
                                                <dl>
                                                    <dt>한도 내 면제</dt>
                                                    <dd>(일부업체 발생)</dd>
                                                </dl>
                                            </td>
                                            <td>면제</td>
                                        </tr><!--//면책금-->

                                        <!--휴차 보상료-->
                                        <tr>
                                            <td class="aside_tit">휴차 보상료</td>
                                            <td>부담금 발생</td>
                                            <td>부담금 발생</td>
                                            <td>
                                                <dl>
                                                    <dt>한도 내 면제</dt>
                                                    <dd>(일부업체 발생)</dd>
                                                </dl>
                                            </td>
                                            <td>면제</td>
                                        </tr><!-- //휴차 보상료 -->

                                        <!-- 단독 사고 -->
                                        <tr>
                                            <td class="aside_tit">단독 사고</td>
                                            <td>보장 안됨</td>
                                            <td>보장</td>
                                            <td>
                                                <dl>
                                                    <dt>보장 안됨</dt>
                                                    <dd>(일부업체 보장)</dd>
                                                </dl>
                                            </td>
                                            <td>보장</td>
                                        </tr><!-- //단독사고 -->

                                        <!--휠/타이어 -->
                                        <tr>
                                            <td class="aside_tit">휠/타이어</td>
                                            <td>보장 안됨</td>
                                            <td>보장</td>
                                            <td>보장 안됨</td>
                                            <td>보장</td>
                                        </tr><!-- //휠/타이어 -->
                                        </tbody>
                                    </table>

                                </div>

                                <!-- info -->
                                <div class="event-note">
                                    <ul>
                                        <li><span>●</span> <span class="tit">자차보험이란 :</span> 차량 사고 발생 시 대여한 렌트카 파손에 대하여 보장해주는 보험</li>
                                        <li><span>●</span> <span class="tit">보상한도 :</span> 보험으로 처리 가능한 사고비용의 최대한도 비용</li>
                                        <li><span>●</span> <span class="tit">면책금 :</span> 사고에 대한 책임을 면하기 위해 지불 하는 돈</li>
                                        <li><span>●</span> <span class="tit">휴차 보상료 :</span> 사고 발생 후 차량 수리기간 동안 발생한 영업손실 비용</li>
                                        <li><span>●</span> <span class="tit">단독사고 :</span> 과실 유무와 상관없이 주·정차된 차량 및 시설물을 접촉하거나 본인과실 100% 사고인 경우</li>
                                        <li><span>●</span> <span class="tit">휠/타이어 보장 :</span> 타이어, 휠 파손에 대한 수리비용</li>
                                        <li>* 세부 내용은 렌트카 업체마다 다를 수 있습니다. 차량 상세페이지 보험내용을 꼭 확인해주세요.</li>
                                    </ul>
                                </div><!-- //info -->
                                <div class="character">
                                    <img src="/images/web/rent/insurance.png" loading="lazy" alt="탐나르방">
                                </div>
                            </div><!-- //free-wrap -->
                        </div><!-- //car_insurance -->
                    </div>
                </div>
            </div>
        </div>
    </div><!-- //자차보험 안내 레이어팝업 -->
    <!-- 실시간 검색 -->
    <div class="quick-area">
        <div class="product-search-area">
            <div id="product_search" class="nav-tabs1">
                <div class="new-quick-wrap">
                    <ul class="nav-menu">
                        <li class="rent"><a href="#tabs-1">렌트카</a></li>
                        <li class="hotel"><a href="#tabs-2">숙소</a></li>
                        <li class="air"><a href="#tabs-3">항공</a></li>
                    </ul>
                </div>

                <!-- tabs-1 / 렌터카 -->
                <div id="tabs-1" class="tabPanel">
                    <div class="index-box-search">
                        <div class="web-search-area">
                            <div class="form-area">
                                <form name="rcSearchFrm" id="rcSearchFrm" method="get" onSubmit="return false;">
                                    <input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
                                    <input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
                                    <input type="hidden" name="sFromTm" id="sFromTm" value="${searchVO.sFromTm}">
                                    <input type="hidden" name="sToTm" id="sToTm" value="${searchVO.sToTm}">
                                    <input type="hidden" name="sCouponCnt" id="sCouponCnt" value="${searchVO.sCouponCnt}"><!--할인쿠폰필터-->
                                    <div class="skeleton_loading"></div>
                                    <div class="search-area rent">
                                    <div class="skeleton_loading"></div>
                                    <div class="back-bg">
                                        <div class="border--cover">
                                            <div class="area">
                                                <dl>
                                                    <dt>
                                                        <div class="date-icon">
                                                            <div class="skeleton_loading">
                                                                <div class="skeleton_text"></div>
                                                            </div>
                                                            <div class="date-icon">
                                                                <span class="IconSide">대여일</span>
                                                            </div>
                                                        </div>
                                                    </dt>
                                                    <dd>
                                                        <div class="value-text">
                                                            <div class="skeleton_loading">
                                                                <div class="skeleton_text"></div>
                                                                <div class="skeleton_text"></div>
                                                            </div>
                                                            <div class="value-text">
                                                                <input class="datepicker" type="text" name="sFromDtView" id="sFromDtView" placeholder="대여일 선택" value="${rcSearchVO.sFromDtView}" readonly>
                                                            </div>
                                                         <%--   <input type="hidden" name="sFromDt" id="sFromDt" value="${rcSearchVO.sFromDt}">
                                                            <input class="datepicker sRcFromDtView" type="text" name="sFromDtView" id="sRcFromDtView" placeholder="대여일 선택" value="${rcSearchVO.sFromDtView}" onclick="optionClose('.popup-typeA')">--%>
                                                        </div>
                                                    </dd>
                                                </dl>
                                            </div>
                                            <div class="time-picker">
                                                <dl>
                                                    <dt>
                                                        <div class="hour-icon"></div>
                                                    </dt>
                                                    <dd>
                                                        <div class="value-text">
                                                            <input name="sFromTmView" id="sFromTmView" title="시간선택" value="08:00" readonly="readonly" />
                                                           <%-- <select name="sFromTm" id="sFromTm" title="시간선택">
                                                                <c:forEach begin="8" end="20" step="1" var="fromTime">
                                                                    <c:if test='${fromTime < 10}'>
                                                                        <c:set var="fromTime_v" value="0${fromTime}00" />
                                                                        <c:set var="fromTime_t" value="0${fromTime}:00" />
                                                                    </c:if>
                                                                    <c:if test='${fromTime > 9}'>
                                                                        <c:set var="fromTime_v" value="${fromTime}00" />
                                                                        <c:set var="fromTime_t" value="${fromTime}:00" />
                                                                    </c:if>
                                                                    <option value="${fromTime_v}" <c:if test="${rcSearchVO.sFromTm == fromTime_v}">selected="selected"</c:if>>${fromTime_t}</option>
                                                                </c:forEach>
                                                            </select>--%>
                                                            <div class="skeleton_loading"></div>
                                                        </div>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </div>
                                        <div class="align-self-center">
                                            <div class="box_text">
                                                <img src="/../images/web/rent/arrow.png" width="24" height="11" alt="화살표">
                                                <div class="txt-rent-period">
                                                    <div class="skeleton_loading">
                                                        <div class="skeleton_text"></div>
                                                        <div class="skeleton_text"></div>
                                                    </div>
                                                    <span>24시간</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="border--cover">
                                            <div class="area">
                                                <dl>
                                                    <dt>
                                                        <div class="date-icon">
                                                            <div class="skeleton_loading">
                                                                <div class="skeleton_text"></div>
                                                            </div>
                                                            <div class="date-icon">
                                                                 <span class="IconSide">반납일</span>
                                                            </div>
                                                        </div>
                                                    </dt>
                                                    <dd>
                                                        <div class="value-text">
                                                            <div class="skeleton_loading">
                                                                <div class="skeleton_text"></div>
                                                                <div class="skeleton_text"></div>
                                                            </div>

                                                            <div class="value-text">
                                                                <input class="datepicker" type="text" name="sToDtView" id="sToDtView" placeholder="반납일 선택" value="${rcSearchVO.sToDtView}" readonly="readonly">
                                                            </div>
<%--                                                            <input type="hidden" name="sToDt" id="sToDt" value="${rcSearchVO.sToDt}">
                                                            <input class="datepicker sRcToDtView" type="text" name="sToDtView" id="sRcToDtView" placeholder="반납일 선택" value="${rcSearchVO.sToDtView}" onclick="optionClose('.popup-typeA')">--%>
                                                        </div>
                                                    </dd>
                                                </dl>
                                            </div>
                                            <div class="time-picker">
                                                <dl>
                                                    <dt>
                                                        <div class="hour-icon">
                                                        </div>
                                                    </dt>
                                                    <dd>
                                                        <div class="value-text">
                                                            <input name="sToTmView" id="sToTmView" title="시간선택" value="08:00" readonly="readonly">
                                            <%--                <select name="sToTm" id="sToTm" title="시간선택">
                                                                <c:forEach begin="8" end="20" step="1" var="toTime">
                                                                    <c:if test='${toTime < 10}'>
                                                                        <div class="skeleton_loading">
                                                                            <div class="skeleton_text"></div>
                                                                            <div class="skeleton_text"></div>
                                                                        </div>
                                                                        <c:set var="toTime_v" value="0${toTime}00" />
                                                                        <c:set var="toTime_t" value="0${toTime}:00" />
                                                                    </c:if>
                                                                    <c:if test='${toTime > 9}'>
                                                                        <c:set var="toTime_v" value="${toTime}00" />
                                                                        <c:set var="toTime_t" value="${toTime}:00" />
                                                                    </c:if>
                                                                    <option value="${toTime_v}" <c:if test="${rcSearchVO.sToTm == toTime_v}">selected="selected"</c:if>>${toTime_t}</option>
                                                                </c:forEach>
                                                            </select>--%>
                                                        </div>
                                                    </dd>
                                                </dl>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- insurance selection -->
                                    <div class="area select">
                                        <dl>
                                            <dt>
                                                <div class="cn-icon">
                                                    <span class="IconSide">보험선택</span>
                                                </div>
                                            </dt>
                                            <dd>
                                                <div class="skeleton_loading">
                                                    <div class="skeleton_text"></div>
                                                    <div class="skeleton_text"></div>
                                                </div>
                                                <div class="btn-category">
                                                    <input type="radio" id="chkPoint0" name="sIsrTypeDiv" value="">
                                                    <label for="chkPoint0">전체</label>
                                                </div>
                                                <div class="skeleton_loading">
                                                    <div class="skeleton_text"></div>
                                                    <div class="skeleton_text"></div>
                                                    <div class="skeleton_text"></div>
                                                </div>
                                                <div class="btn-category">
                                                    <input type="radio" id="chkPoint1" name="sIsrTypeDiv" value="FEE">
                                                    <label for="chkPoint1">자차 미포함</label>
                                                </div>
                                                <div class="btn-category">
                                                    <input type="radio" id="chkPoint2" name="sIsrTypeDiv" value="GENL">
                                                    <label for="chkPoint2">일반자차포함</label>
                                                </div>
                                                <div class="btn-category">
                                                    <input type="radio" id="chkPoint3" name="sIsrTypeDiv" value="LUXY" checked>
                                                    <label for="chkPoint3">고급자차포함</label>
                                                </div>
                                            </dd>
                                        </dl>
                                        <div class="btnPack">
                                            <div class="insurance_btn">
                                                <div class="skeleton_loading">
                                                    <div class="skeleton_text"></div>
                                                </div>
                                                <a href="javascript:show_popup('#insurance_info');">자차보험 안내
                                                </a>
                                            </div>
                                        </div>
                                    </div><!-- //insurance selection -->
                                    <div class="area search">
                                        <button type="button" class="btn red" onclick="fnGoMainList();">
                                                <span class="MagGlass">
                                                      <div class="skeleton_loading">
                                                          <div class="skeleton_img">
                                                      </div>
                                                </div>
                                                <span class="TicSec">최저가 검색</span>
                                            </span>
                                        </button>
                                    </div>
                                </div>
                                </form><!-- //rent_search_form -->
                            </div><!-- //form-area -->
                        </div><!-- //web-search-area -->
                    </div><!-- //index-box-search -->
                </div><!-- //tabs-1 / 렌터카 -->

                <!-- tabs-2 / 숙소 -->
                <div id="tabs-2" class="tabPanel">
                    <form name="adSearchFrm" id="adSearchFrm" method="get" onSubmit="return false;">
                    <input type="hidden" name="sSearchYn" id="sSearchYn" >
                    <input type="hidden" name="pageIndex" id="pageIndex">
                    <input type="hidden" name="sAdAdar" id="sAdAdar" >
                    <input type="hidden" name="sFromDt" id="sAdFromDt" >
                    <input type="hidden" name="sToDt" id="sAdToDt" >
                    <input type="hidden" name="sFromDtMap" id="sFromDtMap">
                    <input type="hidden" name="sToDtMap" id="sToDtMap">
                    <input type="hidden" name="type" id="type" value="main">
                    <div class="inner">
                        <div class="form-area">
                            <input type="hidden" name="page_type" value="main">
                            <div class="search-area hotel">
                                <div class="area date">
                                    <dl>
                                        <dt>
                                            <div class="date-icon">
                                                <span class="IconSide">입실일</span>
                                            </div>
                                        </dt>
                                        <dd>

                                            <div class="value-text">
                                                <div class="date-container">
                                                        <span class="date-wrap">
                                                            <input class="datepicker sAdFromDtView" type="text" name="sFromDtView" value="${adSearchVO.sFromDtView}" placeholder="입실일 선택" onclick="optionClose('.popup-typeA')">
                                                            <img class="ui-datepicker-trigger" src="/images/web/icon/calendar_icon01.gif" alt="날짜를 입력하세요" title="날짜를 입력하세요">
                                                        </span>
                                                </div>
                                            </div>
                                        </dd>
                                    </dl>
                                    <span class="guide"></span>
                                    <dl>
                                        <dt>
                                            <div class="date-icon">
                                                <span class="IconSide">퇴실일</span>
                                            </div>
                                        </dt>
                                        <dd>
                                            <div class="value-text">
                                                <div class="date-container">
                                                        <span class="date-wrap">
                                                            <input class="datepicker sAdToDtView" type="text" name="sToDtView" value="${adSearchVO.sToDtView}" placeholder="퇴실일 선택" onclick="optionClose('.popup-typeA')">
                                                            <img class="ui-datepicker-trigger" src="/images/web/icon/calendar_icon01.gif" alt="날짜를 입력하세요" title="날짜를 입력하세요">
                                                        </span>
                                                </div>
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="area zone select">
                                    <dl>
                                        <dt>
                                            <div class="rt-icon">
                                                <span class="IconSide">지역</span>
                                            </div>
                                        </dt>
                                        <dd>
                                            <div class="value-text">
                                            	<%-- <a href="javascript:void(0)" onclick="optionPopup('#hotel_zone')" id="txtAreaNm">제주도 전체</a> --%>
                                            	<a onclick="optionPopup('#hotel_zone');" id="txtAreaNm">제주도 전체</a>
                                            </div>

                                            <!-- 지역선택 / layer-popup -->
                                            <div id="hotel_zone" class="popup-typeA hotel-zone" style="display: none;">
                                                <div class="popup-typeA_title">지역선택</div>
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
                                                <button class="map--btn map--btn_default" id="decide_cta">
                                                    적용
                                                </button>
                                            </div><!-- //지역선택 / layer-popup -->
                                        </dd>
                                    </dl>
                                </div>
                                <div class="area count select">
                                    <dl>
                                        <dt>
                                            <div class="cn-icon">
                                                <span class="IconSide">인원 선택</span>
                                            </div>
                                        </dt>
                                        <dd>
                                            <div class="value-text">
                                                <%-- <a href="javascript:void(0)" onclick="optionPopup('#hotel_count', this)" id="room_person_str">성인 2</a> --%>
                                                <a onclick="optionPopup('#hotel_count', this)" id="room_person_str">성인 2</a>
                                            </div>

                                            <!-- 인원선택 / layer-popup -->
                                            <div id="hotel_count" class="popup-typeA hotel-count" style="display: none;">
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
                                                            <input type="hidden" name="sAdultCnt" value="2">
                                                            <button type="button" class="counting-btn" onclick="ad_chg_person('-', 'Adult')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                            <span class="counting-text" id="AdultNum">2</span>
                                                            <button type="button" class="counting-btn" onclick="ad_chg_person('+', 'Adult')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                        </div>
                                                    </div>
                                                    <div class="counting">
                                                        <div class="l-area">
                                                            <strong class="sub-title">소아</strong>
                                                            <span class="memo">만 2 ~ 13세 미만</span>
                                                        </div>
                                                        <div class="r-area">
                                                            <input type="hidden" name="sChildCnt" value="0">
                                                            <button type="button" class="counting-btn" onclick="ad_chg_person('-', 'Child')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                            <span class="counting-text" id="ChildNum">0</span>
                                                            <button type="button" class="counting-btn" onclick="ad_chg_person('+', 'Child')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                        </div>
                                                    </div>
                                                    <div class="counting">
                                                        <div class="l-area">
                                                            <strong class="sub-title">유아</strong>
                                                            <span class="memo">만 2세(24개월) 미만</span>
                                                        </div>
                                                        <div class="r-area">
                                                            <input type="hidden" name="sBabyCnt" value="0">
                                                            <button type="button" class="counting-btn" onclick="ad_chg_person('-', 'Baby')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                            <span class="counting-text" id="BabyNum">0</span>
                                                            <button type="button" class="counting-btn" onclick="ad_chg_person('+', 'Baby')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="detail-area info-area">
                                                    <ul class="list-disc sm">
                                                        <li>업체별로 연령 기준은 다를 수 있습니다.</li>
                                                    </ul>
                                                </div>
                                                <button class="map--btn map--btn_default" onclick="fn_Search_LayerClose();">
                                                    적용
                                                </button>
                                            </div><!-- //인원선택 / layer-popup -->
                                        </dd>
                                        <div class="btnPack">
                                            <div class="insurance_btn">
                                                <%-- <a href='javascript:void(0)' onclick="fn_AdSearch('map')" class="btn dark-gray">지도 검색</a> --%>
                                                <a onclick="fn_AdSearch('map')" class="btn dark-gray" id="map-search">지도 검색</a>
                                            </div>
                                        </div>
                                    </dl>
                                </div>
                                <div class="area search">
                                    <button type="button" class="btn red" onclick="fn_AdSearch('main')">
                                        <span class="MagGlass">
                                            <span class="TicSec">최저가 검색</span>
                                        </span>
                                    </button>
                                </div>
                            </div><!-- //search-area -->
                        </div><!-- //form-area -->
                    </div><!-- //inner -->
                    </form>
                </div><!-- //tabs-2 / 숙소 -->

                <!-- tabs-3 / 항공 -->
                <div id="tabs-3" class="tabPanel">
                    <form name="air_search_form" id="avSearchFrm" action="<c:url value='/web/av/productList.do' />">
                    <input type="hidden" name="page_type" value="main">
                    <div class="inner">
                        <div class="form-area">
                            <ul class="check-area">
                                <li class="lb-ch active">
                                    <input type="checkbox" id="air_typeRT" value="RT" name="trip_type" class="textY" checked="checked" onclick="airtype_click(this.id);">
                                    <label for="air_typeRT" class="label_av">왕복</label>
                                </li>
                                <li class="lb-ch">
                                    <input type="checkbox" id="air_typeOW" value="OW" name="trip_type" class="textN" onclick="airtype_click(this.id);">
                                    <label for="air_typeOW" class="label_av">편도</label>
                                </li>
                            </ul>
                            <div class="search-area air">
                                <div class="area zone">
                                    <dl>
                                        <dt>
                                            <div class="rt-icon">
                                                <span class="IconSide">출발지</span>
                                            </div>
                                        </dt>
                                        <dd>
                                            <div class="value-text">
                                            	<%-- <a href="javascript:void(0)" onclick="optionPopup('#air_departure', this)" id="start_region_str">김포(GMP)</a> --%>
                                            	<a onclick="optionPopup('#air_departure', this)" id="start_region_str">김포(GMP)</a>
                                            </div>
                                            <!-- 출발지선택 / layer-popup -->
                                            <div id="air_departure" class="popup-typeA air-zone">
                                                <ul class="select-menu col4">
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test0" name="start_region" type="radio" value="GMP" checked="checked">
                                                            <label for="air_test0">김포</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test1" name="start_region" type="radio" value="CJU">
                                                            <label for="air_test1">제주</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test2" name="start_region" type="radio" value="PUS">
                                                            <label for="air_test2">부산</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test3" name="start_region" type="radio" value="TAE">
                                                            <label for="air_test3">대구</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test4" name="start_region" type="radio" value="KWJ">
                                                            <label for="air_test4">광주</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test5" name="start_region" type="radio" value="CJJ">
                                                            <label for="air_test5">청주</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test6" name="start_region" type="radio" value="MWX">
                                                            <label for="air_test6">무안</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test7" name="start_region" type="radio" value="RSU">
                                                            <label for="air_test7">여수</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test8" name="start_region" type="radio" value="USN">
                                                            <label for="air_test8">울산</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test9" name="start_region" type="radio" value="HIN">
                                                            <label for="air_test9">진주</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test10" name="start_region" type="radio" value="KUV">
                                                            <label for="air_test10">군산</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test11" name="start_region" type="radio" value="KPO">
                                                            <label for="air_test11">포항</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test12" name="start_region" type="radio" value="WJU">
                                                            <label for="air_test12">원주</label>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div><!-- //출발지선택 / layer-popup -->
                                        </dd>
                                    </dl>
                                    <%-- <a href="javascript:void(0)" class="change"><img src="/images/web/air/change.png" alt="변경"></a> --%>
                                    <a class="change" id="landing-change"><img src="/images/web/air/change.png" alt="변경"></a>
                                    <dl>
                                        <dt>
                                            <div class="rt-icon">
                                                <span class="IconSide">도착지</span>
                                            </div>
                                        </dt>
                                        <dd>
                                            <div class="value-text">
                                            	<%-- <a href="javascript:void(0)" onclick="optionPopup('#air_arrival', this)" id="end_region_str">제주(CJU)</a> --%>
                                            	<a onclick="optionPopup('#air_arrival', this)" id="end_region_str">제주(CJU)</a>
                                            </div>
                                            <!-- 도착지선택 / layer-popup -->
                                            <div id="air_arrival" class="popup-typeA air-zone">
                                                <ul class="select-menu col4">
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test13" name="end_region" type="radio" value="GMP">
                                                            <label for="air_test13">김포</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test14" name="end_region" type="radio" value="CJU" checked="checked">
                                                            <label for="air_test14">제주</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test15" name="end_region" type="radio" value="PUS">
                                                            <label for="air_test15">부산</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test16" name="end_region" type="radio" value="TAE">
                                                            <label for="air_test16">대구</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test17" name="end_region" type="radio" value="KWJ">
                                                            <label for="air_test17">광주</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test18" name="end_region" type="radio" value="CJJ">
                                                            <label for="air_test18">청주</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test19" name="end_region" type="radio" value="MWX">
                                                            <label for="air_test19">무안</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test20" name="end_region" type="radio" value="RSU">
                                                            <label for="air_test20">여수</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test21" name="end_region" type="radio" value="USN">
                                                            <label for="air_test21">울산</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test22" name="end_region" type="radio" value="HIN">
                                                            <label for="air_test22">진주</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test23" name="end_region" type="radio" value="KUV">
                                                            <label for="air_test23">군산</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test24" name="end_region" type="radio" value="KPO">
                                                            <label for="air_test24">포항</label>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="lb-box">
                                                            <input id="air_test25" name="end_region" type="radio" value="WJU">
                                                            <label for="air_test25">원주</label>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div><!-- //도착지선택 / layer-popup -->
                                        </dd>
                                    </dl>
                                </div>
                                <div class="area Date">
                                    <dl>
                                        <dt>
                                            <div class="date-icon">
                                                <span class="IconSide">가는날</span>
                                            </div>
                                        </dt>
                                        <dd>
                                            <div class="value-text">
                                                <div class="date-container">
                                                        <span class="date-wrap">
                                                         	<input class="datepicker" type="text" name="start_date" value="${START_DATE}" placeholder="가는날 선택" onclick="optionClose('.popup-typeA')">
                                                        </span>
                                                </div>
                                            </div>
                                        </dd>
                                    </dl>
                                    <span class="guide"></span>
                                    <dl>
                                        <dt>
                                            <div class="date-icon">
                                                <span class="IconSide">오는날</span>
                                            </div>
                                        </dt>
                                        <dd>
                                            <div class="value-text">
                                                <div class="date-container">
                                                        <span class="date-wrap">
                                                            <input class="datepicker" type="text" name="end_date" value="${END_DATE}" placeholder="오는날 선택" onclick="optionClose('.popup-typeA')">
                                                        </span>
                                                </div>
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="area count select">
                                    <dl>
                                        <dt>
                                            <div class="cn-icon">
                                                <span class="IconSide">인원 선택</span>
                                            </div>
                                        </dt>
                                        <dd>
                                            <div class="value-text">
                                                <%-- <a href="javascript:void(0)" onclick="optionPopup('#air_count', this)" id="seat_person_str">전체 | 성인 1</a> --%>
                                                <a onclick="optionPopup('#air_count', this)" id="seat_person_str">성인 1</a>
                                            </div>

                                            <!-- 좌석 등급 및 인원선택 / layer-popup -->
                                            <div id="air_count" class="popup-typeA air-count">
                                            <%--    <div class="detail-area">
                                                    <strong class="sub-title">좌석 등급</strong>
                                                    <select class="full" name="seat_type" id="seat_type" title="등급 선택" onchange="modify_seat_person();">
                                                        <option value="N@S@B" selected>전체</option>
                                                        <option value="N">일반석</option>
                                                        <option value="S">할인석</option>
                                                        <option value="B">비즈니스석</option>
                                                    </select>
                                                </div>--%>
                                                <div class="detail-area counting-area">
                                                    <div class="counting">
                                                        <div class="l-area">
                                                            <strong class="sub-title">성인</strong>
                                                            <span class="memo">만 13세 이상</span>
                                                        </div>
                                                        <div class="r-area">
                                                            <input type="hidden" name="adult_cnt" value="1">
                                                            <button type="button" class="counting-btn" onclick="chg_person('-', 'adult')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                            <span class="counting-text" id="adult_num">1</span>
                                                            <button type="button" class="counting-btn" onclick="chg_person('+', 'adult')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                        </div>
                                                    </div>
                                                    <div class="counting">
                                                        <div class="l-area">
                                                            <strong class="sub-title">소아</strong>
                                                            <span class="memo">만 2세 ~ 13세 미만</span>
                                                        </div>
                                                        <div class="r-area">
                                                            <input type="hidden" name="child_cnt" value="0">
                                                            <button type="button" class="counting-btn" onclick="chg_person('-', 'child')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                            <span class="counting-text" id="child_num">0</span>
                                                            <button type="button" class="counting-btn" onclick="chg_person('+', 'child')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                        </div>
                                                    </div>
                                                    <div class="counting">
                                                        <div class="l-area">
                                                            <strong class="sub-title">유아</strong>
                                                            <span class="memo">만 2세(24개월) 미만</span>
                                                        </div>
                                                        <div class="r-area">
                                                            <input type="hidden" name="baby_cnt" value="0">
                                                            <button type="button" class="counting-btn" onclick="chg_person('-', 'baby')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                            <span class="counting-text" id="baby_num">0</span>
                                                            <button type="button" class="counting-btn" onclick="chg_person('+', 'baby')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="detail-area info-area">
                                                    <ul class="list-disc sm">
                                                        <li>나이는 가는날/오는날 기준으로 적용됩니다.</li>
                                                        <li>유아 선택 시 성인은 꼭 포함되어야 합니다.</li>
                                                        <li>유아는 보호자 1인당 1명만 예약이 가능합니다.</li>
                                                        <li>항공사별로 기준 나이는 상이할 수 있습니다.</li>
                                                    </ul>
                                                </div>
                                                <p class="map--btn map--btn_default" onclick="fn_Search_LayerClose();">
                                                    적용
                                                </p>
                                            </div><!-- //좌석 등급 및 인원선택 / layer-popup -->
                                        </dd>
                                    </dl>
                                </div>
                                <div class="area search">
                                    <button type="button" class="btn red" onclick="check_air_seach_form();">
                                        <span class="MagGlass">
                                            <span class="TicSec">항공권 검색</span>
                                        </span>
                                    </button>
                                </div>
                            </div><!-- //search-area -->
                        </div><!-- //form-area -->
                    </div><!-- //inner -->
                    </form>
                </div><!-- //tabs-3 / 항공 -->
            </div>
        </div>
    </div><!-- //실시간 검색 -->
    <!-- //0406 예약 네비게이션 개선 -->

    <!-- 인기있수다 -->
    <div class="categoryBestSection">
        <div class="inner">
            <h2>지금 제일 잘나가는 상품</h2>
            <div class="product-area" >
                <div id="product_theme" class="swiper-container swiper-container-horizontal">
                    <ul class="swiper-wrapper" id="hotList">
                        <template v-for="post in posts">
                            <li class="swiper-slide">
                                <a :href="'/web/' + post.prdtNum.substring(0,2).toLowerCase().trim() + '/detailPrdt.do?sPrdtNum=' + post.prdtNum + '&PrdtNum=' + post.prdtNum">
                                    <div class="photo">
                                        <div class="skeleton_loading">
                                            <div class="skeleton_img"></div>
                                        </div>
                                        <img :src="post.imgPath" width="215" height="215" loading="lazy" alt="product">
                                    </div>
                                    <div class="bx-info">

                                        <div class="skeleton_loading">
                                            <div class="skeleton_text"></div>
                                            <div class="skeleton_text"></div>
                                            <div class="skeleton_text"></div>
                                        </div>

                                        <div class="text__name">{{post.prdtNm}}</div>
                                        <div class="text__memo">{{post.prdtExp}}</div>
                                        <div class="box__price">
                                            <span class="text__price">{{post.saleAmt | currency}}</span><span class="text__unit">원~</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        </template>
                        <%-- 시티투어 --%>
                        <%--<template v-for="post in posts">
                            <template v-if="post.prdtNum === 'SP00001022' ">
                                <li class="swiper-slide" >
                                    <a :href="'/web/' + post.prdtNum.substring(0,2).toLowerCase().trim() + '/detailPrdt.do?sPrdtNum=' + post.prdtNum + '&PrdtNum=' + post.prdtNum">
                                        <div class="photo">
                                            <img :src="post.imgPath" alt="product">
                                        </div>
                                        <div class="bx-info">
                                            <div class="text__name">{{post.prdtNm}}</div>
                                            <div class="text__memo">{{post.prdtExp}}</div>
                                            <div class="box__price">
                                                <span class="text__price">{{post.saleAmt | currency}}</span><span class="text__unit">원~</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </template>
                        </template>--%>
                    </ul>
                </div>
                <div id="theme_arrow" class="arrow-box">
                    <div id="theme_next" class="swiper-button-next"></div>
                    <div id="theme_prev" class="swiper-button-prev"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- //인기있수다 -->

    <!-- 카테고리별 숙박/렌터카 추천 -->
    <div class="categoryPopularSection">
        <div class="inner">
            <h2>카테고리별 추천상품</h2>
            <div class="PopularContent PopularContent1">
                <div class="col depth1">
                    <h3>숙소</h3>
                    <span class="con_more"><a href="/web/stay/jeju.do">숙소상품 더 보기 ></a></span>
                    <%--<div class="PopularKeyword" id="hashTagListKW02">
                        <h4>인기키워드</h4>
                        <ul>
                            <template v-for="(post,index) in posts" >
                                <li>
                                    <template v-if="post.pcUrl === null">
                                        <a :href="'/web/kwaSearch.do?kwaNum=' + post.kwaNum" >{{post.kwaNm}}</a>
                                    </template>
                                    <template v-else>
                                        <a :href="post.pcUrl" >{{post.kwaNm}}</a>
                                    </template>
                                </li>
                            </template>
                        </ul>
                    </div>--%>
                </div>
                <div class="col depth2">
                    <div id="ConEvnt" class="ConEvnt swiper-container swiper-container-horizontal">
                        <ul class="swiper-wrapper">
                            <template v-for="post in posts">
                                <li  class="swiper-slide">
                                    <a :href="'/web/ad/detailPrdt.do?sSearchYn=Y&sPrdtNum=' + post.prdtNum">
                                        <div class="ConTx">
                                            <pre>{{post.prmtContents}}</pre>
                                            <span>{{post.adNm}}</span>
                                        </div>
                                        <div class="ConPhoto">
                                            <img :src="post.savePath + 'thumb/' + post.saveFileNm" loading="lazy" alt="adMainProduct">
                                        </div>
                                    </a>
                                </li>
                            </template>
                        </ul>
                    </div>
                    <div class="bxBtn">
                        <a class="bx-prev" id="adPrevBtn" href="">Prev</a>
                        <a class="bx-next" id="adNextBtn" href="">Next</a>
                    </div>
                </div>
                <div class="col depth3">
                    <div id="ADctgr" class="categoryPopularItems">
                        <ul class="col_3" >
                            <template v-for="(post,index) in posts.slice(0,6)">
                                <li>
                                    <a :href="'/web/ad/detailPrdt.do?sSearchYn=Y&sPrdtNum=' + post.prdtNum" class="bx_list">
                                        <div class="bxPhoto">
                                            <img :src="post.imgPath" width="200" height="160" loading="lazy" alt="product">
                                        </div>
                                        <div class="bxInfo">
                                            <div class="bxTitle">{{post.prdtNm}}</div>
                                            <div class="bxEvent">{{post.prdtExp}}</div>
                                            <div class="bxPrice">
                                                <span class="text__price">{{post.saleAmt | currency}}</span><span class="text__unit">원</span>
                                            </div>
                                            <div class="bxLabel">
                                                <span v-if="post.eventCnt > 0" class="main_label">이벤트</span>
                                                <span v-if="post.couponCnt > 0" class="main_label">할인쿠폰</span>
                                                <span v-if="post.daypriceYn === 'Y'" class="main_label">당일특가</span>
                                                <%--<span class="main_label">연박할인</span>--%>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </template>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="PopularContent PopularContent2">
                <div class="col depth1">
                    <h3>렌트카</h3>
                    <span class="con_more"><a href="/web/rentcar/jeju.do">렌트카상품 더 보기 ></a></span>
                    <%--<div class="PopularKeyword" id="hashTagListKW03">
                        <h4>인기키워드</h4>
                        <ul>
                            <template v-for="(post,index) in posts" >
                                <li>
                                    <template v-if="post.pcUrl === null">
                                        <a :href="'/web/kwaSearch.do?kwaNum=' + post.kwaNum" >{{post.kwaNm}}</a>
                                    </template>
                                    <template v-else>
                                        <a :href="post.pcUrl" >{{post.kwaNm}}</a>
                                    </template>
                                </li>
                            </template>
                        </ul>
                    </div>--%>
                </div>
                <div class="col depth2">
                    <div id="ConEvnt2" class="ConEvnt swiper-container swiper-container-horizontal">
                        <ul class="swiper-wrapper">
                            <li class="swiper-slide">
                                <a href="/web/rentcar/car-list.do?sUseFuelDiv=CF04">
                                    <div class="ConTx">
                                        <pre>친환경 전기차<br>모음<br></pre>
                                        <span>청정제주와 함께하는 제주여행</span>
                                    </div>
                                    <div class="ConPhoto">
                                        <img src="/images/web/r_main/cardiv_1.png" loading="lazy" alt="전기차이미지">
                                    </div>
                                </a>
                            </li>
                            <li class="swiper-slide">
                                <a href="/web/rentcar/car-list.do?sCarDivCd=CAR2">
                                    <div class="ConTx">
                                        <pre>중형차<br>모음</pre>
                                        <span>넉넉한 공간, 합리적인 선택</span>
                                    </div>
                                    <div class="ConPhoto">
                                        <img src="/images/web/r_main/cardiv_2.png" loading="lazy" alt="중형차이미지">
                                    </div>
                                </a>
                            </li>
                            <li class="swiper-slide">
                                <a href="/web/rentcar/car-list.do?sCarDivCd=CAR3">
                                    <div class="ConTx">
                                        <pre>고급차<br>모음</pre>
                                        <span>럭셔리하고 편안한 제주여행</span>
                                    </div>
                                    <div class="ConPhoto">
                                        <img src="/images/web/r_main/cardiv_3.png" loading="lazy" alt="고급차이미지">
                                    </div>
                                </a>
                            </li>
                            <li class="swiper-slide">
                                <a href="/web/rentcar/car-list.do?sCarDivCd=CAR4">
                                    <div class="ConTx">
                                        <pre>SUV/승합차<br>모음</pre>
                                        <span>다같이 함께하는 즐거운 드라이빙</span>
                                    </div>
                                    <div class="ConPhoto">
                                        <img src="/images/web/r_main/cardiv_4.png" loading="lazy" alt="SUV/승합차이미지">
                                    </div>
                                </a>
                            </li>
                            <li class="swiper-slide">
                                <a href="/web/rentcar/car-list.do?sCarDivCd=CAR5">
                                    <div class="ConTx">
                                        <pre>오픈카/수입차<br>모음</pre>
                                        <span>새로운 경험, 특별한 제주여행!</span>
                                    </div>
                                    <div class="ConPhoto">
                                        <img src="/images/web/r_main/cardiv_5.png" loading="lazy" alt="오픈카/수입차이미지">
                                    </div>
                                </a>
                            </li>
                            <li class="swiper-slide">
                                <a href="/web/rentcar/car-list.do?sCarDivCd=CAR1">
                                    <div class="ConTx">
                                        <pre>경차/소형차<br>모음</pre>
                                        <span>합리적인 당신, 실속있는 선택!</span>
                                    </div>
                                    <div class="ConPhoto">
                                        <img src="/images/web/r_main/cardiv_6.png" loading="lazy" alt="경차/소형차이미지">
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="bxBtn">
                        <a class="bx-prev" id="rcPrevBtn" href="">Prev</a>
                        <a class="bx-next" id="rcNextBtn" href="">Next</a>
                    </div>
                </div>
                <div class="col depth3">
                    <div id="RCctgr" class="categoryPopularItems">
                        <ul class="col_3">
                            <template v-for="(post,index) in posts.slice(0,6)">
                                <li>
                                    <a :href="'/web/rentcar/car-detail.do?searchYn=Y&prdtNum=' + post.prdtNum" class="bx_list">
                                        <div class="bxPhoto">
                                            <img :src="post.imgPath" width="200" height="144" loading="lazy" alt="product">
                                        </div>
                                        <div class="bxInfo">
                                            <div class="bxTitle">{{post.prdtNm}}</div>
                                            <div class="bxEvent">{{post.etcExp}}</div>
                                            <div class="bxPrice">
                                                <span class="text__price">{{post.saleAmt | currency}}</span><span class="text__unit">원</span>
                                            </div>
                                            <div class="bxLabel">
                                                <span v-if="post.eventCnt > 0" class="main_label">이벤트</span>
                                                <span v-if="post.couponCnt > 0" class="main_label">할인쿠폰</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </template>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //카테고리별 추천상품 -->

    <!-- 여행사상품 -->
    <div class="categoryPackageSection">
        <div class="inner">
            <h2>카테고리별 추천상품</h2>
            <%--<span class="con_more">상품 더 보기 ></span>--%>
            <div class="category-tab">
                <div class="tabList tab-s3"><a href="javascript:tabFunc('food');" class="active">맛집</a></div>
                <div class="tabList tab-s2"><a href="javascript:tabFunc('leisure');">관광지/레저</a></div>
                <div class="tabList tab-s1"><a href="javascript:tabFunc('package');" >여행사 상품</a></div>
            </div>
            <div class="category-area package">
                <div class="item-area">
                    <div class="item__List" id="C100ctgr">
                        <ul>
                            <template v-for="(post,index) in posts.slice(0,10)">
                                <li class="list-item">
                                    <a :href="'/web/sp/detailPrdt.do?sSearchYn=Y&prdtNum=' + post.prdtNum" class="link__item">
                                        <div class="box__image">
                                            <img :src="post.imgPath" alt="상품이미지">
                                        </div>
                                        <div class="box__information">
                                            <strong class="bx_label _green">{{post.etcExp}}</strong>
                                            <div class="bxTitle">{{post.prdtNm}}</div>
                                            <%-- if --%>
                                            <div class="bxEvent" v-if="post.prdtExp !== null">
                                                {{post.prdtExp}}
                                            </div>
                                            <div class="bxEvent" v-else >
                                                &nbsp;
                                            </div>
                                            <%-- //if--%>
                                            <div class="bxPrice">
                                                <span class="text__price">{{post.saleAmt|currency}}</span><span class="text__unit">원</span>
                                            </div>
                                            <div class="bxLabel">
                                                <span v-if="post.eventCnt > 0" class="main_label">이벤트</span>
                                                <span v-if="post.couponCnt > 0" class="main_label">할인쿠폰</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </template>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="category-area leisure">
                <div class="item-area">
                    <div class="item__List" id="C200ctgr">
                        <ul>
                            <template v-for="(post,index) in posts.slice(0,10)">
                                <li class="list-item">
                                    <a :href="'/web/sp/detailPrdt.do?sSearchYn=Y&prdtNum=' + post.prdtNum" class="link__item">
                                        <div class="box__image">
                                            <img :src="post.imgPath" alt="상품이미지">
                                        </div>
                                        <div class="box__information">
                                            <strong class="bx_label _green">{{post.etcExp}}</strong>
                                            <div class="bxTitle">{{post.prdtNm}}</div>
                                            <%-- if --%>
                                            <div class="bxEvent" v-if="post.prdtExp !== null">
                                                {{post.prdtExp}}
                                            </div>
                                            <div class="bxEvent" v-else >
                                                &nbsp;
                                            </div>
                                            <%-- //if--%>
                                            <div class="bxPrice">
                                                <span class="text__price">{{post.saleAmt|currency}}</span><span class="text__unit">원</span>
                                            </div>
                                            <div class="bxLabel">
                                                <span v-if="post.eventCnt > 0" class="main_label">이벤트</span>
                                                <span v-if="post.couponCnt > 0" class="main_label">할인쿠폰</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </template>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="category-area food">
                <div class="item-area">
                    <div class="item__List" id="C300ctgr">
                        <ul>
                            <template v-for="(post,index) in posts.slice(0,10)">
                                <li class="list-item">
                                    <a :href="'/web/sp/detailPrdt.do?sSearchYn=Y&prdtNum=' + post.prdtNum" class="link__item">
                                        <div class="box__image">
                                            <img :src="post.imgPath" width="225" height="225" loading="lazy" alt="상품이미지">
                                        </div>
                                        <div class="box__information">
                                            <strong class="bx_label _green">{{post.etcExp}}</strong>
                                            <div class="bxTitle">{{post.prdtNm}}</div>
                                            <%-- if --%>
                                            <div class="bxEvent" v-if="post.prdtExp !== null">
                                                {{post.prdtExp}}
                                            </div>
                                            <div class="bxEvent" v-else >
                                                &nbsp;
                                            </div>
                                            <%-- //if--%>
                                            <div class="bxPrice">
                                                <span class="text__price">{{post.saleAmt|currency}}</span><span class="text__unit">원</span>
                                            </div>
                                            <div class="bxLabel">
                                                <span v-if="post.eventCnt > 0" class="main_label">이벤트</span>
                                                <span v-if="post.couponCnt > 0" class="main_label">할인쿠폰</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </template>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //여행사상품 -->

    <!-- 특산기념품 -->
    <div class="categoryProductSection">
        <div class="conBg">
            <div class="inner">
                <h2>특산/기념품</h2>
                <span class="con_more"><a href="/web/goods/jeju.do">특산/기념품상품 더 보기 ></a></span>
                <div class="product-area" id="SVctgr">
                    <div id="product_slider" class="swiper-container swiper-container-horizontal">
                        <ul class="swiper-wrapper">
                            <template v-for="post in posts">
                                <li class="swiper-slide">
                                    <a :href="'/web/sv/detailPrdt.do?sSearchYn=Y&prdtNum=' + post.prdtNum">
                                        <div  class="box__image">
                                            <%--<span class="main_label_JQ">JQ인증</span>--%>
                                            <img :src="post.imgPath" width="224" height="224" loading="lazy" alt="상품이미지">
                                        </div>
                                        <div class="box__information">
                                            <strong class="bx_label _red">{{post.etcExp}}</strong>
                                            <div class="bxTitle">{{post.prdtNm}}</div>
                                            <%-- if --%>
                                            <div class="bxEvent" v-if="post.prdtExp !== null">
                                                {{post.prdtExp}}
                                            </div>
                                            <div class="bxEvent" v-else >
                                                &nbsp;
                                            </div>
                                            <%-- //if--%>
                                            <div class="bxPrice">
                                                <span class="text__price">{{post.saleAmt|currency}}</span><span class="text__unit">원</span>
                                            </div>
                                            <div class="bxLabel">
                                                <span v-if="post.eventCnt > 0" class="main_label">이벤트</span>
                                                <span v-if="post.couponCnt > 0" class="main_label">할인쿠폰</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </template>
                        </ul>
                    </div>
                    <div id="product_arrow" class="arrow-box">
                        <div id="svNextBtn" class="swiper-button-next"></div>
                        <div id="svPrevBtn" class="swiper-button-prev"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //특산기념품 -->

    <!-- main foot banner (사이트링크) -->
    <div class="main-footBanner">
        <div class="inner">
            <div id="foot_organBanner" class="swiper-container">
                <ul class="swiper-wrapper">
                    <c:forEach var="result" items="${bannerListBottom}" varStatus="status">
                        <li class="swiper-slide">
                            <a href="${result.url}" <c:if test="${result.nwd == 'Y'}">target="_blank"</c:if>>
                                <img src="<c:url value='${result.imgPath}${result.imgFileNm}'/>" width="145" height="45" loading="lazy" alt="${result.bannerNm}" >
                            </a>
                        </li>
                    </c:forEach>
                    <%-- 이전 배너 --%>
                    <c:if test="${fn:length(bannerListBottom) == 0}">
                        <li><a href="https://www.hijeju.or.kr/" target="_blank"><img src="/images/web/main/foot_banner3.jpg" loading="lazy" alt="하이제주"></a></li>
                        <li><a href="https://www.visitjeju.or.kr" target="_blank"><img src="/images/web/main/foot_banner5.jpg" loading="lazy" alt="제주관광협회"></a></li>
                        <li><a href="https://www.jeju.go.kr" target="_blank"><img src="/images/web/main/foot_banner6.jpg" loading="lazy" alt="제주도청"></a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>

    <c:if test="${not empty eventPopup}">
        <!-- layer-popup-slider -->
        <div id="mainPopupAll" class="layer crm bx-viewport">
            <ul class="swiper-wrapper">
                <c:forEach var="event" items="${eventPopup}" varStatus="status">
                    <c:if test="${'코로나공지' eq event.bannerNm}">
                        <li class="swiper-slide">
                            <c:if test="${not empty event.url}">
                            <a href="${event.url}" target="_blank">
                                </c:if>
                                <img src="<c:url value='${event.imgPath}${event.imgFileNm}' />" alt="${event.bannerNm}">
                                <c:if test="${not empty event.url}">
                            </a>
                            </c:if>
                        </li>
                    </c:if>
                </c:forEach>
                <c:forEach var="event" items="${eventPopup}" varStatus="status">
                    <c:if test="${'코로나공지' ne event.bannerNm}">
                        <li class="swiper-slide">
                            <c:if test="${not empty event.url}">
                            <a href="${event.url}" target="_blank">
                                </c:if>
                                <img src="<c:url value='${event.imgPath}${event.imgFileNm}' />" alt="${event.bannerNm}">
                                <c:if test="${not empty event.url}">
                            </a>
                            </c:if>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
            <div class="bx-controls">
                <div class="bx-controls-direction">
                    <a id="bx-prev" href="">Prev</a>
                    <a id="bx-next" href="">Next</a>
                </div>
                <div class="bx-pager bx-default-pager">
                	<!-- 
                    <div class="bx-pager-item">
                        <a href data-slide-index="0" class="bx-pager-link active">1</a>
                    </div>
                    -->
                </div>
            </div>
            <button type="button" onclick="stopPopupToday();">하루 동안 보지 않기</button>
            <button type="button" class="close" onclick="closePopupToday()">닫기</button>
        </div>
    </c:if>
</div>

<!-- 0921 로딩바개선 -->
<div class="modal-spinner">
    <div class="popBg"></div>
    <div class="loading-popup">
        <div class="spinner-con">
            <strong class="spinner-txt">제주여행 공공 플랫폼 탐나오</strong>
            <div class="spinner-sub-txt">
                <span>실시간 가격 비교</span>
            </div>
            <div class="spinner-sub-txt">
                <span>믿을 수 있는 상품 구매</span>
            </div>
        </div>
    </div>
</div><!-- //0921 로딩바개선 -->
<jsp:include page="/web/right.do"></jsp:include>
<jsp:include page="/web/foot.do"></jsp:include>
<%-- <script src="<c:url value='/js/multiple-select.js?version=${nowDate}'/>"></script> --%>
<%-- <script src="<c:url value='/js/air_step1.js?version=${nowDate}'/>"></script> --%>
<%--<script src="<c:url value='/js/freewall.js?version=${nowDate}'/>"></script>--%>

<script src="/js/vue.js?version=${nowDate}"></script>
<script src="/js/axios.min.js?version=${nowDate}"></script>
<%--<script src="/js/polyfill.js?version=${nowDate}"></script>--%>
<script type="application/ld+json">
{
    "@context": "https://schema.org/",
    "@type": "TravelAgency",
    "telephone": "1522-3454",
    "logo": "https://www.tamnao.com/images/web/r_main/floating_logo.png",
    "email": "tamnao@tamnao.com",
    "address": "제주특별자치도 제주시 첨단로 213-65 제주종합비즈니스센터 3층",
    "name": "제주 렌트카, 숙소, 관광지 - 제주여행공공플랫폼 탐나오",
    "description": "안전한고 편리한 예약은 제주여행 공공플랫폼 탐나오 | 렌트카,숙소,관광지,항공 온라인예약 제주특별자치도관광협회 운영",
    "url": "https://www.tamnao.com/",
    "keywords": "제주렌트카, 제주숙소, 제주관광지, 제주도렌트카, 제주도숙소, 제주도관광지, 제주렌터카, 제주도렌터카",
    "sameAs": [
        "http://www.visitjeju.or.kr",
        "https://www.youtube.com/@tamnaojeju",
        "https://www.instagram.com/tamnao_jeju",
        "https://www.facebook.com/JEJUTAMNAOTRAVEL",
        "https://blog.naver.com/jta0119",
        "https://pf.kakao.com/_xhMCrj"
    ]
}
</script>
<script>
    let prevIndex = 0;
    function stopPopupToday(){
        $.cookie("today", "Y", {expires: 1, path: "/"});
        $("#mainPopupAll").fadeOut(0);
    }

    function closePopupToday(){
        $("#mainPopupAll").fadeOut(0);
    }

    function fn_RcSearch(){
        $('#sFromDt').val($('.sRcFromDtView').val().replace(/-/g, ''));
        $('#sToDt').val($('.sRcToDtView').val().replace(/-/g, ''));
		
        document.rcSearchFrm.action = "<c:url value='/web/rentcar/car-list.do'/>";
        document.rcSearchFrm.submit();
        /*
        ++prevIndex;
        history.replaceState($("#_wrap").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
        currentState = history.state;
        */
    }

    //팝업 닫기
    function closeLayer( obj ) {
        $('.lock-bg').remove();
        $(obj).hide();
    }

    function fn_AdSearch(type){
        $("#sSearchYn").val('Y');
        $("#pageIndex").val(1);
        $('#sAdFromDt').val($('.sAdFromDtView').val().replace(/-/g, ''));
        $('#sAdToDt').val($('.sAdToDtView').val().replace(/-/g, ''));
        $('#sFromDtMap').val($('.sAdFromDtView').val());
        $('#sToDtMap').val($('.sAdToDtView').val());
       	
        document.adSearchFrm.target = "";
        if(type == "main"){
            $('#type').val("main");
            document.adSearchFrm.action = "<c:url value='/web/stay/jeju.do'/>";
        }else{
            $('#type').val("map");
            document.adSearchFrm.action = "<c:url value='/web/stay/jeju.do?type=map'/>";
        }
        document.adSearchFrm.submit();
        /*
        ++prevIndex;
        history.replaceState($("#_wrap").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
        currentState = history.state;
        */
    }

    var adMaxDate = "+12m";
    var rcMaxDate = "+6m";

    // 객실수 및 인원 정보 수정
    function modify_room_person() {
        var str =  "성인 " + $('#AdultNum').text();
        if ($('#ChildNum').text() > 0) {
            str += ", 소아 " + $('#ChildNum').text();
        }
        if ($('#BabyNum').text() > 0) {
            str += ", 유아 " + $('#BabyNum').text();
        }
        $('#room_person_str').text(str);
    }

    // 인원수 변경 이벤트
    function ad_chg_person(type, gubun) {
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
            } else if (num > 9) {
                num = 9;
            }
        } else {
            if (num < 0) {
                num = 0;
            } else if (num > 8) {
                num = 8;
            }
        }
        $('#' + gubun + 'Num').text(num);
        $('input[name=s' + gubun + 'Cnt]').val(num);

        var sMen = eval($('#AdultNum').text()) + eval($('#ChildNum').text()) + eval($('#BabyNum').text());
        $('#sMen').val(sMen);

        modify_room_person();
    }

    function tabFunc(param) {
        $(".category-area").hide();
        $("." + param).show();
        $(".tabList a").removeClass("active");
        if(param == "package"){
            $(".tab-s1 a").addClass("active");
        }else if(param == "leisure"){
            $(".tab-s2 a").addClass("active");
        }else if(param == "food"){
            $(".tab-s3 a").addClass("active");
        }
    }

    $(document).ready(function(){

        //대여시간 size 초기화
        $('#sFromTm').attr('size','0');
        $('#sToTm').attr('size','0');

        var currentState = history.state;
        if(currentState){
            $("#_wrap").html(currentState);
            let tabIndex = $("#product_search li.active a").attr("href");
            let tabActive = 0;

            if(tabIndex == "#tabs-1"){ //렌터카
                tabActive = 0
            }else if(tabIndex == "#tabs-2"){ //숙소
                tabActive = 1
            }else if(tabIndex == "#tabs-3"){ //항공
                tabActive = 2
            }
			
            tabPanel2({
                container: "#product_search",
                firstItem: tabIndex,
                active : tabActive
            });

        }else{
            //실시간 검색 탭패널
            tabPanel2({
                container: "#product_search",
                firstItem: "#tabs-1"
            });
        }

        if($.cookie("today")) {
            $("#mainPopupAll").hide();
        }else{
            $("#mainPopupAll").show();
        }

        $(".category-tab a").click(function(){
            $(".tx").removeClass();
            $(this).addClass("tx");
        })

        $("#_wrap .hasDatepicker ").removeClass(function(index){
            $(this).removeClass("hasDatepicker");
        })

        //datepicker
        $("#avSearchFrm").find("input[name=start_date]").datepicker({
            showOn: "both",
            dateFormat: "yy-mm-dd",
            minDate: "${SVR_TODAY}",
            buttonImage: "/images/web/icon/calendar_icon01.gif",
            buttonImageOnly: true,
            showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
            numberOfMonths: [ 1, 2 ],									//여러개월 달력 표시
            stepMonths: 2,												//좌우 선택시 이동할 개월 수
            onSelect: function(dateText, inst) {
                $("input[name=end_date]").datepicker('option', 'minDate', $("input[name=start_date]").val() );
            }
        });

        $("#avSearchFrm").find("input[name=end_date]").datepicker({
            showOn: "both",
            dateFormat: "yy-mm-dd",
            minDate: "${SVR_TODAY}",
            buttonImage: "/images/web/icon/calendar_icon01.gif",
            buttonImageOnly: true,
            showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
            numberOfMonths: [ 1, 2 ],									//여러개월 달력 표시
            stepMonths: 2												//좌우 선택시 이동할 개월 수
        });

        $(".sAdFromDtView").datepicker({
            showOn: "both",
            buttonImage: "/images/web/icon/calendar_icon01.gif",
            buttonImageOnly: true,
            showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
            numberOfMonths: [1, 2],									//여러개월 달력 표시
            stepMonths: 2, 												//좌우 선택시 이동할 개월 수
            dateFormat: "yy-mm-dd",
            minDate: "${SVR_TODAY}",
            maxDate: adMaxDate,
            onClose : function(selectedDate) {
                var fromDt = new Date(selectedDate);

                $("#sAdFromDt").val("" + fromDt.getFullYear() + (fromDt.getMonth() + 1) + fromDt.getDate());

                fromDt.setDate(fromDt.getDate() + 1);
                selectedDate = fromDt.getFullYear() + "-" + (fromDt.getMonth() + 1) + "-" + fromDt.getDate();
                $(".sAdToDtView").datepicker("option", "minDate", selectedDate);

                var toDt = new Date($(".sAdToDtView").val());
                fromDt.setDate(fromDt.getDate() - 1);

                var nightNum = (toDt.getTime() - fromDt.getTime()) / (3600 * 1000 * 24);
                if(nightNum < 1) {
                    nightNum = 1;
                }
                $("#sNights").val(nightNum);
            }
        });

        $(".sAdToDtView").datepicker({
            showOn: "both",
            buttonImage: "/images/web/icon/calendar_icon01.gif",
            buttonImageOnly: true,
            showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
            numberOfMonths: [1, 2],									//여러개월 달력 표시
            stepMonths: 2, 												//좌우 선택시 이동할 개월 수
            dateFormat: "yy-mm-dd",
            minDate: "${SVR_TODAY}",
            maxDate: adMaxDate,
            onClose : function(selectedDate) {
                var toDt = new Date(selectedDate);
                var fromDt = new Date($(".sAdFromDtView").val());

                $("#sToDt").val("" + toDt.getFullYear() + (toDt.getMonth() + 1) + toDt.getDate());
                $("#sNights").val((toDt.getTime() - fromDt.getTime()) / (3600 * 1000 * 24));
            }
        });

        $(".sRcFromDtView").datepicker({
            showOn: "both",
            buttonImageOnly: true,
            showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
            numberOfMonths: [1, 2],									//여러개월 달력 표시
            stepMonths: 2, 												//좌우 선택시 이동할 개월 수
            dateFormat: "yy-mm-dd",
            minDate: "${SVR_TODAY}",
            maxDate: rcMaxDate,
            onClose : function(selectedDate) {
                const fromDt = new Date(selectedDate);
                /** 시작검색일 SET*/
                $('#sFromDt').val($('#sRcFromDtView').val().replace(/-/g, ''));
                fromDt.setDate(fromDt.getDate());
                selectedDate = fromDt.getFullYear() + "-" + (fromDt.getMonth() + 1) + "-" + fromDt.getDate();
                /** 종료검색일 SET*/
                $("#sRcToDtView").datepicker("option", "minDate", selectedDate);
                $('#sToDt').val($('#sRcToDtView').val().replace(/-/g, ''));
                fromDt.setDate(fromDt.getDate() - 1);
                fnCalcHour();
                $('#sFromTm').attr('size', 2);
                $('#sFromTm').css({"height":"215px"});
            }
        });

        $(".sRcToDtView").datepicker({
            showOn: "both",
            buttonImageOnly: true,
            showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
            numberOfMonths: [1, 2],									//여러개월 달력 표시
            stepMonths: 2, 												//좌우 선택시 이동할 개월 수
            dateFormat: "yy-mm-dd",
            minDate: "${SVR_TODAY}",
            maxDate: rcMaxDate,
            onClose : function(selectedDate) {
                $('#sToDt').val($('#sRcToDtView').val().replace(/-/g, ''));
                fnCalcHour();
                $('#sToTm').attr('size', 2);
                $('#sToTm').css({"height":"215px"});
            }
        });

        $('.sRcFromDtView').change(function() {
            $('#sRcFromDt').val($('.sRcFromDtView').val().replace(/-/g, ''));
        });
        $('.sRcToDtView').change(function() {
            $('#sRcToDt').val($('.sRcToDtView').val().replace(/-/g, ''));
        });

        tabPanel({container:"#tabs"});
        tabPanel({container:"#item_menu_1"});

        /*// slider
        $('#quick-slider ul').after('<div id="nav100" class="slider-number">').cycle({
            pager:'#nav100',
            prev: '#quick_prev',
            next: '#quick_next'
        });*/

        /*$("#sCarCd").multipleSelect({
            filter 		: true,
            multiple 	: true,
            multipleWidth : 85,
            maxHeight	: 110,
            minimumCountSelected : 7
        });*/

        /** Main Top Banner Slider */
        if($('#main_top_slider .swiper-slide').length > 1) {
            new Swiper('#main_top_slider', {
                pagination: '#main_top_navi',
                nextButton: '#main_top_next',
                prevButton: '#main_top_prev',
                paginationClickable: true,
                autoplay: 7000,
                loop: true,
                paginationType: 'fraction',
                effect: 'fade',
                touchRatio: 0
            });
        } else {
            $('#main_top_arrow').hide();
        }

        /** 하단 롤링배너 */
        if($('#foot_organBanner ul li').length > 6) {
            new Swiper('#foot_organBanner', {
                slidesPerView: 6,
                spaceBetween: 9,
                paginationClickable: true,
                nextButton: '#foot_organNext',
                prevButton: '#foot_organPrev',
                autoplay: 5000,
                loop: true
            });
        } else {
            $('#foot_organArrow').hide();
        }

        //실시간 검색 탭패널 > 상단 고정바
        tabPanel2({
            container: "#product_top_search",
            firstItem: "#tabs-33",
            allHide: 1
        });

        /** 항공 관련  */
        // 출발지 선택
        $(document).on("click", 'input[name=start_region]', function() {
            $("#start_region_str").text($("label[for=" + $(this).attr('id') + "]").text() + "(" + $(this).val() + ")");
            optionClose($("#air_departure"));
        });

        /** 도착지 선택 */
        $(document).on("click", 'input[name=end_region]', function() {
            $("#end_region_str").text($("label[for=" + $(this).attr('id') + "]").text() + "(" + $(this).val() + ")");
            optionClose($("#air_arrival"));
        });

        modify_seat_person();

        /** 관련기관 배너 (4개 이상시 롤링) */
        if($('#foot_organBanner ul li').length > 6) {
            new Swiper('#foot_organBanner', {
                slidesPerView: 6,
                spaceBetween: 9,
                paginationClickable: true,
                nextButton: '#foot_organNext',
                prevButton: '#foot_organPrev',
                autoplay: 5000,
                loop: true
            });
        } else {
            $('#foot_organArrow').hide();
        }

        /** 렌터카 슬라이드*/
        new Swiper('#ConEvnt2', {
            slidesPerView: 1,
            paginationClickable: true,
            nextButton: '#rcNextBtn',
            prevButton: '#rcPrevBtn',
            autoplay: 3000,
            loop: true
        });

        //렌터카 시간 클릭
        $(".value-text select").click(function(){
            if($(this).attr("size") == 0){
                $(this).css('height', "215px");
                $(this).attr('size', 2);
            }else{
                $(this).css('height', '70px');
                $(this).attr('size', 0);
            }
            fnCalcHour();
        });

        /** 메인팝업 슬라이드*/
        if ($('#mainPopupAll .swiper-slide').length > 1) {
            new Swiper('#mainPopupAll', {
                nextButton: '#bx-next',
                prevButton: '#bx-prev',
                //pagination: '.bx-pager-item',
                paginationClickable: true,
                loop: true,
                paginationType: 'bullets',
                effect: 'fade',
                touchRatio: 0
            });
        } else {
            $('#main_top_arrow').hide();
            $('.bx-controls-direction').hide();
        }

        // 출발지 <> 도착지 체인지
        $(' .change').on('click', function() {
            let startReg = "";
            let endReg = "";
            startReg = $("input[name=start_region]:checked").val();
            endReg = $("input[name=end_region]:checked").val();

            $("input[name=start_region]").each(function(index) {
                if(endReg == $("#air_test"+index).val()){
                    $("#air_test"+index).prop("checked", true);
                    $("input[name=start_region]:checked").click();
                    return;
                }
                if(startReg == $("#air_test"+index).val()){
                    $("#air_test"+index).prop("checked", false);
                    return;
                }
            });

            $("input[name=end_region]").each(function(index) {
                index = index + 13;
                if(startReg == $("#air_test"+index).val()){
                    $("#air_test"+index).prop("checked", true);
                    $("input[name=end_region]:checked").click();
                    return;
                }
                if(endReg == $("#air_test"+index).val()){
                    $("#air_test"+index).prop("checked", false);
                    return;
                }
            });
        });

        // 여백 클릭 시 팝업 닫기
        $(document).mouseup(function(e){
            var divPop = $(".popup-typeA");
            if(divPop.has(e.target).length == 0){
                divPop.hide();
                return;
            }
        });

        /** 지역선택 */
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

        //숙소 지역 완료 버튼 클릭
        $("#decide_cta").click(function (){
            $("#hotel_zone").hide();
        });

        /**항공 검색 */
        $("#start_region_str").text($("input[name='start_region']:checked").next('label').text() + "(" + $("input[name='start_region']:checked").val() + ")" );
        $("#end_region_str").text($("input[name='end_region']:checked").next('label').text() + "(" + $("input[name='end_region']:checked").val() + ")");
        //datepicker
        $("input[name=start_date]").datepicker({
            showOn: "both",
            dateFormat: "yy-mm-dd",
            minDate: "${SVR_TODAY}",
            buttonImage: "/images/web/icon/calendar_icon01.gif",
            buttonImageOnly: true,
            showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
            numberOfMonths: [ 1, 2 ],									//여러개월 달력 표시
            stepMonths: 2,												//좌우 선택시 이동할 개월 수
            onSelect: function(dateText, inst) {
                $("input[name=end_date]").datepicker('option', 'minDate', $("input[name=start_date]").val() );
            }
        });

        $("input[name=end_date]").datepicker({
            showOn: "both",
            dateFormat: "yy-mm-dd",
            minDate: "${SVR_TODAY}",
            buttonImage: "/images/web/icon/calendar_icon01.gif",
            buttonImageOnly: true,
            showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
            numberOfMonths: [ 1, 2 ],									//여러개월 달력 표시
            stepMonths: 2												//좌우 선택시 이동할 개월 수
        });
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

        if(sAdAdar.length == 6 || sAdAdar.length == 0 ) {
            $("#txtAreaNm").text("제주도 전체");
        }
    }

    function fn_Search_LayerClose(){
        $("#hotel_count").hide();
        $("#air_count").hide();
    }

    //렌터카 시간 계산
    function fnCalcHour(){
        console.log($('#sRcToDtView').val());
        console.log($('#sRcToDtView').val());
        let tmpStartDt = $('#sRcFromDtView').val();
        tmpStartDt = tmpStartDt.split("-");
        let tmpStartTime = $("#sFromTm").val();
        tmpStartTime = tmpStartTime.substring(0,2);
        let tmpEndDt = $('#sRcToDtView').val();
        tmpEndDt = tmpEndDt.split("-");
        let tmpEndTime = $("#sToTm").val();
        tmpEndTime = tmpEndTime.substring(0,2);
        let startDate = new Date(tmpStartDt[0],Number(tmpStartDt[1])-1,Number(tmpStartDt[2]),tmpStartTime,00,00);
        let endDate = new Date(tmpEndDt[0],Number(tmpEndDt[1])-1,Number(tmpEndDt[2]),tmpEndTime,0,0);
        let rentTime = (endDate.getTime() - startDate.getTime()) / 60000 / 60;

        let rentTimeStr;
        if(rentTime >= 25){
            rentTimeStr = parseInt(rentTime / 24) + "일"
            if((rentTime % 24) != 0){
                rentTimeStr +=  " " + rentTime % 24 + "시간";
            }
        }else{
            rentTimeStr = rentTime + "시간";
        }

        $(".txt-rent-period p").text(rentTimeStr);
    }

    // 왕복 <-> 편도 toggle
    function airtype_click(id) {
        $(".check-area > li").removeClass("active");
        $("#"+id).closest("li").addClass("active");

        if(id == "air_typeOW"){ //편도
            $("input[name=end_date]").hide();
            $("#air_typeRT").prop("checked", false);
            $("#air_typeOW").prop("checked", true);
        }else{ //왕복
            $("input[name=end_date]").show();
            $("#air_typeRT").prop("checked", true);
            $("#air_typeOW").prop("checked", false);
        }
    }
	
	//좌석 등급 및 승객 정보 수정
    function modify_seat_person() {
        var str = $("#seat_type option:selected").text();

        str += " 성인 " + $('#adult_num').text();
        if (eval($('#child_num').text()) > 0) {
            str += ", 소아 " + $('#child_num').text();
        }
        if (eval($('#baby_num').text()) > 0) {
            str += ", 유아 " + $('#baby_num').text();
        }
        $('#seat_person_str').text(str);
    }
  	
	//인원수 변경 이벤트
    function chg_person(type, gubun) {
        var num = 0;
        if (type == '+') {
            num = eval($('#' + gubun + '_num').text()) + 1;
        } else {
            num = eval($('#' + gubun + '_num').text()) - 1;
        }

        // 최저 인원 수 - 성인 : 1, 소아&유아 : 0
        if (gubun == 'adult') {
            if (num < 1) num = 1;
            else if (num > 9) num = 9;
        } else {
            if (num < 0) num = 0;
            else if (num > 8) num = 8;
        }

        $('#' + gubun + '_num').text(num);
        $('input[name=' + gubun + '_cnt]').val(num);

        modify_seat_person();
    }
	
	//인원수 체크
    function check_people_cnt() {
        //성인수
        var adult_cnt = $("input[name=adult_cnt]").val();
        adult_cnt = eval(adult_cnt) + 0;

        //소아수
        var child_cnt = $("input[name=child_cnt]").val();
        child_cnt = eval(child_cnt) + 0;

        //유아수
        var baby_cnt = $("input[name=baby_cnt]").val();
        baby_cnt = eval(baby_cnt) + 0;

        //1. 유아인원수는 성인인원수를 초과할 수 없다.
        if(adult_cnt < baby_cnt) {
            alert("성인 1명에 유아 1명만을 예약하실 수 있으며 나머지 유아는 소아로 예약하셔야 합니다.");
            $("select#child").val(adult_cnt);

            return false;
        }

        //2. 총 좌석점유 탑승객이 9명을 초과할 수 없다.
        if(adult_cnt + child_cnt > 9) {
            alert("총 좌석점유 탑승객이 9명을 넘을 수 없습니다.");
            $("select#adult").val("1");
            $("select#children").val("0");
            $("select#child").val("0");

            return false;
        }

        return true;
    }
  
  	//항공 검색폼 체크
	function check_air_seach_form() {
  		
        var start_airport = $.trim($("input[name=start_region]:checked").val());
        var end_airport = $.trim($("input[name=end_region]:checked").val());
        if(start_airport == end_airport) {
            alert("출발지와 도착지가 동일합니다.");
            return false;
        }

        //출발일자 체크
        var start_date = $.trim($("input[name=start_date]").val());
        if(start_date.length < 1) {
            alert("가는날을 선택해주세요.");
            return false;
        }

        //도착일자 체크, 항공유형이 왕복일 경우
        if($("input[name=trip_type]:checked").val() == "RT") {
            var end_date = $.trim($("input[name=end_date]").val());
            if(end_date.length < 1) {
                alert("오는날을 선택해주세요.");
                return false;
            }
        } else { //항공유형이 편도일 경우
            //출발일자를 셋팅한다.
            $("input[name=end_date]").val(start_date);
        }

        //인원수 체크
        if(!check_people_cnt()) {
            return false;
        }

        // 검색 폼의 hidden
        optionClose($("#air_departure"));
        optionClose($("#air_arrival"));
        optionClose($("#air_count"));
		
        document.air_search_form.action = "<c:url value='/web/av/productList.do'/>";
        document.air_search_form.submit();
		/*
        ++prevIndex;
        history.replaceState($("#_wrap").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
        currentState = history.state;
        */
    }
</script>
<%--<script src="/js/browser.js"></script>--%>
<script src="/js/moment.min.js?version=${nowDate}"></script>
<script src="/js/daterangepicker-rc-pc.js?version=${nowDate}" ></script>
<script>

    $(document).ready(function() {

        /** 인기있수다 */
        new Vue({
            el: "#hotList",
            created: function () {
                /** 인기있수다 슬라이드 */
                new Swiper('#product_theme', {
                    slidesPerView: 5,
                    spaceBetween: 30,
                    paginationClickable: true,
                    nextButton: '#theme_next',
                    prevButton: '#theme_prev',
                    loop: true,
                    autoplay: 7000,
                });
                this.fetchData(); },
            data: { posts: [
                    {"prdtNum":"0000000000","prdtNm":"-","prdtExp":"-","imgPath":"/images/web/other/defaultBg.jpg","nmlAmt":"","saleAmt":""},
                    {"prdtNum":"0000000000","prdtNm":"-","prdtExp":"-","imgPath":"/images/web/other/defaultBg.jpg","nmlAmt":"","saleAmt":""},
                    {"prdtNum":"0000000000","prdtNm":"-","prdtExp":"-","imgPath":"/images/web/other/defaultBg.jpg","nmlAmt":"","saleAmt":""},
                    {"prdtNum":"0000000000","prdtNm":"-","prdtExp":"-","imgPath":"/images/web/other/defaultBg.jpg","nmlAmt":"","saleAmt":""},
                    {"prdtNum":"0000000000","prdtNm":"-","prdtExp":"-","imgPath":"/images/web/other/defaultBg.jpg","nmlAmt":"","saleAmt":""}
                ]
            },
            filters: {
                currency: function (value) {
                    let num = new Number(value);
                    return num.toFixed(0).replace(/(\d)(?=(\d{3})+(?:\.\d+)?$)/g, "$1,");
                }
            },
            methods: {
                fetchData: function () {
                    axios.get('/web/getMainHotList.ajax').then(response => {
                        this.posts = response.data.result;
                    });
                }
            },updated:function(){
                /** 인기있수다 슬라이드 */
                new Swiper('#product_theme', {
                    slidesPerView: 5,
                    spaceBetween: 30,
                    paginationClickable: true,
                    nextButton: '#theme_next',
                    prevButton: '#theme_prev',
                    autoplay: 7000
                });
                setInterval(function () {
                    $(".skeleton_loading").hide();
                }, 500);
            }
        });

        /** 렌트카 데이트피커 */
        $('.back-bg').daterangepicker({
            timePicker: true,
            timePicker24Hour:true,
            timePickerIncrement: 60,
            autoApply: false,
            locale: {
                "format": "YYYY년 MM월 DD일",
                "separator": " ~ ",
                "applyLabel": "확인",
                "cancelLabel": "취소",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "weekLabel": "W",
                "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
                "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            },

        }, function(start, end, label) {
            // 선택한 날짜 범위를 콘솔에 출력합니다 (필요에 따라 콜백 내용 추가).
        });

        $('.back-bg').on('apply.daterangepicker', function(ev, picker){

            if (isApplyButtonClicked) {
                if (picker.startDate == null || picker.endDate == null) {
                    alert('대여 일정을 선택 해 주세요.');
                    return;
                }

                const startDate = picker.startDate.format('YYYY-MM-DD');
                const endDate = picker.endDate.format('YYYY-MM-DD');
                let startTime = picker.startDate.format('HH:00');
                let endTime = picker.endDate.format('HH:00');

                if (startTime == "00:00") {
                    startTime = "08:00";
                }

                if (endTime == "00:00" || endTime == "23:00") {
                    endTime = "08:00";
                }

                $("#sFromDtView").val(startDate);
                $("#sToDtView").val(endDate);
                $("#sFromTmView").val(startTime);
                $("#sToTmView").val(endTime);

                // 대여시간 계산
                const timeDifference = new Date(endDate + " " + endTime + ":00") - new Date(startDate + " " + startTime + ":00");
                const hoursDifference = timeDifference / (1000 * 60 * 60);
                $(".txt-rent-period span").text(hoursDifference + "시간");
            }

            $('.lock-bg').remove();
            $('body').removeClass('not_scroll');
            // Daterangepicker 창을 수동으로 닫습니다.
            picker.hide();
        });


        /* let hashTagList = ["KW02", "KW03"];
         hashTagList.forEach(function (item, index) {
             let hashParams = new URLSearchParams();
             hashParams.append('cnt', 5);
             hashParams.append('slocation', item);
             /!** 해시태그 *!/
             new Vue({
                 el: "#hashTagList" + item,
                 created: function () {
                     this.fetchData();
                 },
                 data: {posts: []},
                 filters: {
                     currency: function (value) {
                         let num = new Number(value);
                         return num.toFixed(0).replace(/(\d)(?=(\d{3})+(?:\.\d+)?$)/g, "$1,");
                     }
                 },
                 methods: {
                     fetchData: function () {
                         axios.post('/web/getHashTag.ajax', hashParams).then(response => {
                             this.posts = response.data.result;
                         });
                     }
                 }
             });
         });*/

        /** 숙소 프로모션 */
        new Vue({
            el: "#ConEvnt",
            created: function () { this.fetchData(); },
            data: { posts: [
                    {"prmtContents":"-","adNm":"-","savePath":"/data/ad/","saveFileNm":"defaultBg.jpg"}
                ]
            },
            filters: {
                currency: function (value) {
                    let num = new Number(value);
                    return num.toFixed(0).replace(/(\d)(?=(\d{3})+(?:\.\d+)?$)/g, "$1,");
                }
            },
            methods: {
                fetchData: function () {
                    axios.get('/web/getPrmtAdList.ajax').then(response => {
                        this.posts = response.data.result;
                });
                }
            },updated:function(){
                /** 숙소 슬라이드 */
                new Swiper('#ConEvnt', {
                    slidesPerView: 1,
                    paginationClickable: true,
                    nextButton: '#adNextBtn',
                    prevButton: '#adPrevBtn',
                    autoplay: 3000,
                    loop: true
                });
            }
        });

        /** 숙소,렌터카,여행사 카테고리별 추천 */
        let rcmdCategory = ["AD", "RC","C100","SV","C200","C300"];
        rcmdCategory.forEach(function (item, index) {
            let params = new URLSearchParams();
            params.append('prdtDiv', item);
            new Vue({
                el: "#" + item + "ctgr",
                created: function () { this.fetchData(); },
                data: { posts: [
                        {"prdtNm":"-","prdtExp":"-","saleAmt":"","imgPath":"/images/web/other/defaultBg.jpg"},
                        {"prdtNm":"-","prdtExp":"-","saleAmt":"","imgPath":"/images/web/other/defaultBg.jpg"},
                        {"prdtNm":"-","prdtExp":"-","saleAmt":"","imgPath":"/images/web/other/defaultBg.jpg"},
                        {"prdtNm":"-","prdtExp":"-","saleAmt":"","imgPath":"/images/web/other/defaultBg.jpg"},
                        {"prdtNm":"-","prdtExp":"-","saleAmt":"","imgPath":"/images/web/other/defaultBg.jpg"},
                        {"prdtNm":"-","prdtExp":"-","saleAmt":"","imgPath":"/images/web/other/defaultBg.jpg"},
                        {"prdtNm":"-","prdtExp":"-","saleAmt":"","imgPath":"/images/web/other/defaultBg.jpg"},
                        {"prdtNm":"-","prdtExp":"-","saleAmt":"","imgPath":"/images/web/other/defaultBg.jpg"},
                        {"prdtNm":"-","prdtExp":"-","saleAmt":"","imgPath":"/images/web/other/defaultBg.jpg"},
                        {"prdtNm":"-","prdtExp":"-","saleAmt":"","imgPath":"/images/web/other/defaultBg.jpg"}
                    ] },
                filters: {
                    currency: function (value) {
                        let num = new Number(value);
                        return num.toFixed(0).replace(/(\d)(?=(\d{3})+(?:\.\d+)?$)/g, "$1,");
                    }
                },
                methods: {
                    fetchData: function () {
                        axios.post('/web/getMainCategoryRecommend.ajax', params).then(response => {
                            this.posts = response.data.result;
                        });
                    }
                },updated:function(){
                    if(item === "SV"){
                        /** 특산기념품 슬라이드 */
                        new Swiper('#product_slider', {
                            slidesPerView: 5,
                            spaceBetween: 20,
                            paginationClickable: true,
                            nextButton: '#svNextBtn',
                            prevButton: '#svPrevBtn',
                            autoplay: 3000,
                            loop: true
                        });
                    }
                }
            });
        });
    });


    $(document).on('click', '.back-bg', function() {

        $('body').after('<div class="lock-bg"></div>');
        $('body').addClass('not_scroll');
        // daterangepicker 위치 설정
        var windowHeight = $(window).height();
        var windowWidth = $(window).width();
        var datePickerHeight = $('.daterangepicker').outerHeight();
        var datePickerWidth = $('.daterangepicker').outerWidth();
        var topPosition = (windowHeight - datePickerHeight) / 2;
        var leftPosition = (windowWidth - datePickerWidth) / 2;

        $('.daterangepicker').css({
            'position': 'fixed',
            'top': topPosition + 'px',
            'left': leftPosition + 'px',
        });

        $('.daterangepicker').show();

    });

   function fnGoMainList(){
        document.rcSearchFrm.target = "_self";
        document.rcSearchFrm.action = "<c:url value='/web/rentcar/car-list.do'/>";
        $("#sFromDt").val( $("#sFromDtView").val().replace("-",""));
        $("#sToDt").val( $("#sToDtView").val().replace("-",""));

        $("#sFromTm").val( $("#sFromTmView").val().replace(":",""));
        $("#sToTm").val( $("#sToTmView").val().replace(":",""));
        document.rcSearchFrm.submit();
    }

    let isApplyButtonClicked = false;

    //닫기 button
    function close_calender(){
        isApplyButtonClicked = false;
        const picker = $('.back-bg').data('daterangepicker');
        picker.element.trigger('apply.daterangepicker', picker);
    }

    //적용 button
    function fn_ClickSearch(){
        isApplyButtonClicked = true;
        const picker = $('.back-bg').data('daterangepicker');
        picker.element.trigger('apply.daterangepicker', picker);

    }


    /*// 스켈레톤 요소
    const skeletonItem = document.querySelectorAll('.skeleton_loading');
    // 스켈레톤 요소 전체 삭제
    const hideskeleton = () => {        skeletonItem.forEach(element => {
            $(element).fadeOut();
        });
    };
    // 테스트 코드 (페이지 로딩을 위해 2초간 스켈레톤 애니메이션이 보여짐)
     // window.onload = setTimeout(hideskeleton, 8000);
    // 실제 코드 (실제로 사용될 코드)
     window.onload = hideskeleton;*/

</script>
</body>
</html>