<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>--%>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<meta name="robots" content="noindex">
<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="제주도 렌트카 최저가 가격비교 예약"/>
	<jsp:param name="keywords" value="렌터카,렌트카,제주,제주도,여행,관광,예약,탐나오"/>
	<jsp:param name="description" value="제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 실시간 렌트카예약"/>
</jsp:include>
<meta property="og:title" content="제주도 렌트카 최저가 예약">
<meta property="og:url" content="https://www.tamnao.com/web/rentcar/car-list.do">
<meta property="og:description" content="제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 실시간 렌트카예약">
<meta property="og:image" content="https://www.tamnao.com/images/mw/rent/rent-visual.png">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/rc.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/re/rc2.css?version=${nowDate}'/>" />
<link rel="canonical" href="https://www.tamnao.com/web/rentcar/car-list.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/rentcar/car-list.do">
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do"></jsp:include>
</header>
<main id="main">
	<div class="mapLocation">
		<div class="inner">
			<span>홈</span> <span class="gt">&gt;</span>
			<span>렌트카 가격비교</span>
		</div>
	</div>
	<!-- subContents -->
	<form name="frm" id="frm" method="get" onSubmit="return false;">
		<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
		<input type="hidden" name="sCarDivCdView" id="sCarDivCdView" value="${searchVO.sCarDivCdView}" />
		<input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />
		<input type="hidden" name="mYn" id="mYn" value="${searchVO.mYn}" />
		<input type="hidden" name="searchYn" id="searchYn" value="${Constant.FLAG_Y}" />
		<input type="hidden" name="prdtNum" id="prdtNum" />
		<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}" />
		<input type="hidden" id="minPrice" value="0" />
		<input type="hidden" id="maxPrice" value="1000000" />
		<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
		<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
		<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
		<input type="hidden" name="sPrdtNm" id="sPrdtNm" value="${searchVO.sPrdtNm}">
		<div id="subContents" class="sub_wrap">
			<div class="subHead"></div>
			<!-- filter_wrap -->
			<div class="filter_wrap">
				<div class="filter_check">
					<div class="f_hd">
						<h2>렌트카검색</h2>
					</div>
					<div class="f_con">
						<div class="date_wrap">
							<div class="date_checkin">
								<label>대여일</label>
								<div class="value-text">
									<div class="date-container">
									<span class="date-pick">
										<%--<input type="hidden" name="vNights" id="vNights" value="${searchVO.sNights}">--%>
										<input class="datepicker" type="text" name="sFromDtView" id="sFromDtView" placeholder="대여일 선택" value="${searchVO.sFromDtView}">
									</span>
										<div class="time-area">
											<select name="sFromTm" id="sFromTm" class="full" title="시간선택">
												<c:forEach begin="8" end="20" step="1" var="fromTime">
													<c:if test='${fromTime < 10}'>
														<c:set var="fromTime_v" value="0${fromTime}00" />
														<c:set var="fromTime_t" value="0${fromTime}:00" />
													</c:if>
													<c:if test='${fromTime > 9}'>
														<c:set var="fromTime_v" value="${fromTime}00" />
														<c:set var="fromTime_t" value="${fromTime}:00" />
													</c:if>
													<option value="${fromTime_v}" <c:if test="${searchVO.sFromTm == fromTime_v}">selected="selected"</c:if>>${fromTime_t}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
							</div>

							<div class="date_checkout">
								<label>반납일</label>
								<div class="value-text">
									<div class="date-container">
									<span class="date-pick">
										<input class="datepicker" type="text" name="sToDtView" id="sToDtView" placeholder="반납일 선택" value="${searchVO.sToDtView}">
									</span>
										<div class="time-area">
											<select name="sToTm" id="sToTm" class="full" title="시간선택">
												<c:forEach begin="8" end="20" step="1" var="toTime">
													<c:if test='${toTime < 10}'>
														<c:set var="toTime_v" value="0${toTime}00" />
														<c:set var="toTime_t" value="0${toTime}:00" />
													</c:if>
													<c:if test='${toTime > 9}'>
														<c:set var="toTime_v" value="${toTime}00" />
														<c:set var="toTime_t" value="${toTime}:00" />
													</c:if>
													<option value="${toTime_v}" <c:if test="${searchVO.sToTm == toTime_v}">selected="selected"</c:if>>${toTime_t}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="search_btn">
							<button type="button" id="searchBtn1" onclick="fn_rcSearchInit('1')" class="search_btn"  >검색</button>
						</div>
					</div>
				</div>
				<div class="filter_btn">
		<%--			<a href="/web/sp/detailPrdt.do?prdtNum=SP00002246" class="carTransArea" target="_self">
						차량탁송서비스
					</a>--%>
					<a href="/web/tour/jeju.do?sCtgr=C500" class="carSeatArea" target="_self">
						카시트/유모차
					</a>
				</div>
				<!-- 0304 탐나는전 check point -->
				<div class="filter_jejupay">
					<div class="pay-check">
						<input type="checkbox" name="tcard_yn" id="tcard_yn" value="Y" onclick="filter7()" <c:if test="${param.tcard_yn eq 'Y'}">checked</c:if>>
						<label for="tcard_yn">
							<img src="../../images/web/icon/jeju_pay_icon.png" width="27" height="20" alt="탐나는전">
							<span>탐나는전 가맹점 보기</span>
						</label>
					</div>
				</div>
				<!-- //0304 탐나는전 check point -->

<%--				<!-- 20241031 할인쿠폰 보기 -->
				<div class="filter_coupon-view">
					<div class="coupon-toggle">
						<input type="checkbox" name="couponCnt" id="couponCnt" value="1"  onclick="filter9()">
						<label for="couponCnt">
							<img src="../../images/web/icon/coupon-view.png" width="22" height="20" alt="할인쿠폰">
							<span>할인쿠폰 보기</span>
						</label>
					</div>
				</div><!-- //20241031 할인쿠폰 보기 -->--%>

				<div class="filter_refine">
					<div class="filter_header">
						<button type="button" onclick="funcClear();"> 전체해제 </button>
					</div>
					<div class="section-box">
						<div class="category-tit">차종</div>
						<ul class="hide_type half">
							<c:forEach var="code" items="${carDivCd}" varStatus="status">
								<li>
									<input type="checkbox" class="rf_chk" id="sCarDivCd${status.count}" name="sCarDivCdStr" value="${code.cdNum}" onclick="filter1()">
									<label for="sCarDivCd${status.count}" class="label_chk"><span></span>${code.cdNm}</label>
								</li>
							</c:forEach>
						</ul>
					</div>

					<div class="section-box">
						<div class="category-tit">보험</div>
						<div class="insurance_wrap">
							<div class="btnPack">
								<div class="insurance_btn">
									<a href="javascript:show_popup('#insurance_info');">자차보험 안내</a>
								</div>
							</div>
						</div>
						<ul class="hide_type">
							<li>
								<a class="sr-only" href="javascript:void(0)">고급자차(전액무제한)</a>
								<div>
									<input type="checkbox" id="sIsrTypeDiv4" name="sIsrTypeDiv" value="ULIM" class="rf_chk" onclick="filter2()" >
									<label for="sIsrTypeDiv4" class="label_chk"><span></span>고급자차(전액무제한)</label>
								</div>
							</li>
							<li><a class="sr-only" href="javascript:void(0)">고급자차</a>
								<div>
									<input type="checkbox" id="sIsrTypeDiv3" name="sIsrTypeDiv" value="LUXY" class="rf_chk" onclick="filter2()" >
									<label for="sIsrTypeDiv3" class="label_chk"><span></span>고급자차</label>
								</div>
							</li>
							<li><a class="sr-only" href="javascript:void(0)">일반자차</a>
								<div>
									<input type="checkbox" id="sIsrTypeDiv2" name="sIsrTypeDiv" value="GENL" class="rf_chk" onclick="filter2()" >
									<label for="sIsrTypeDiv2" class="label_chk"><span></span>일반자차</label>
								</div>
							</li>
							<li><a class="sr-only" href="javascript:void(0)">자차 미포함<</a>
								<div>
									<input type="checkbox" id="sIsrTypeDiv1" name="sIsrTypeDiv" value="FEE" class="rf_chk" onclick="filter2()" >
									<label for="sIsrTypeDiv1" class="label_chk"><span></span>자차 미포함</label>
								</div>
							</li>
						</ul>
					</div>

					<%--<div class="section-box price_bar">
						<div class="category-tit f_price">가격</div>
						<p>
							<input type="text" id="slideAmount" readonly style="border:0; color:#e8202e; font-weight:bold;">
						</p>
						<div class="area type select stay">
							<dl class="type1">
								<div id="slider-range" class="ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all">
									<span class="ui-slider-handle ui-state-default ui-corner-all" href="#"></span>
									<span class="ui-slider-handle ui-state-default ui-corner-all" href="#"></span>
								</div>
							</dl>
						</div>
					</div>--%>

					<div class="section-box item-list open">
						<div class="category-tit">연료</div>
						<ul class="hide_type half">
							<c:forEach var="fuel" items="${fuelCd}" varStatus="status">
								<li>
									<div>
										<input type="checkbox" id="sUseFuelDiv${status.count}" name="sUseFuelDiv" value="${fuel.cdNum}" onclick="filter4()" class="rf_chk">
										<label for="sUseFuelDiv${status.count}" class="label_chk"><span></span>${fuel.cdNm}</label>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>

					<div class="section-box item-list open">
						<div class="category-tit">연령</div>
						<ul class="hide_type half">
							<li>
								<input type="checkbox" id="sRntQlfctAge1" name="sRntQlfctAge" value="21" class="rf_chk" onclick="oneCheckbox(this);filter3()" >
								<label for="sRntQlfctAge1" class="label_chk"><span></span>만21세이상</label>
							</li>
							<li>
								<input type="checkbox" id="sRntQlfctAge2" name="sRntQlfctAge" value="22" class="rf_chk" onclick="oneCheckbox(this);filter3()" >
								<label for="sRntQlfctAge2" class="label_chk"><span></span>만22세이상</label>
							</li>
							<li>
								<input type="checkbox" id="sRntQlfctAge3" name="sRntQlfctAge" value="23" class="rf_chk" onclick="oneCheckbox(this);filter3()" >
								<label for="sRntQlfctAge3" class="label_chk"><span></span>만23세이상</label>
							</li>
							<li>
								<input type="checkbox" id="sRntQlfctAge4" name="sRntQlfctAge" value="24" class="rf_chk" onclick="oneCheckbox(this);filter3()" >
								<label for="sRntQlfctAge4" class="label_chk"><span></span>만24세이상</label>
							</li>
							<li>
								<input type="checkbox" id="sRntQlfctAge5" name="sRntQlfctAge" value="25" class="rf_chk" onclick="oneCheckbox(this);filter3()" >
								<label for="sRntQlfctAge5" class="label_chk"><span></span>만25세이상</label>
							</li>
							<li>
								<input type="checkbox" id="sRntQlfctAge6" name="sRntQlfctAge" value="99" class="rf_chk" onclick="oneCheckbox(this);filter3()" >
								<label for="sRntQlfctAge6" class="label_chk"><span></span>만26세이상</label>
							</li>
						</ul>
					</div>

					<div class="section-box item-list open">
						<div class="category-tit">경력</div>
						<ul class="hide_type half">
							<li>
								<input type="checkbox" id="sRntQlfctCareer1" name="sRntQlfctCareer" value="0" class="rf_chk" onclick="oneCheckbox2(this);filter8()" >
								<label for="sRntQlfctCareer1" class="label_chk"><span></span>1년미만</label>
							</li>
							<li>
								<input type="checkbox" id="sRntQlfctCareer2" name="sRntQlfctCareer" value="1" class="rf_chk" onclick="oneCheckbox2(this);filter8()" >
								<label for="sRntQlfctCareer2" class="label_chk"><span></span>2년미만</label>
							</li>
							<li>
								<input type="checkbox" id="sRntQlfctCareer3" name="sRntQlfctCareer" value="2" class="rf_chk" onclick="oneCheckbox2(this);filter8()" >
								<label for="sRntQlfctCareer3" class="label_chk"><span></span>3년미만</label>
							</li>
							<li>
								<input type="checkbox" id="sRntQlfctCareer4" name="sRntQlfctCareer" value="99" class="rf_chk" onclick="oneCheckbox2(this);filter8()" >
								<label for="sRntQlfctCareer4" class="label_chk"><span></span>3년이상</label>
							</li>
						</ul>
					</div>

					<div class="section-box item-list open">
						<div class="category-tit">연식</div>
						<ul class="hide_type half">
							<li>
								<input type="checkbox" id="sModelYear1" name="sModelYear" value="2016~2017" class="rf_chk" onclick="filter5()" >
								<label for="sModelYear1" class="label_chk"><span></span>2016~17년</label>
							</li>
							<li>
								<input type="checkbox" id="sModelYear2" name="sModelYear" value="2017~2018" class="rf_chk" onclick="filter5()" >
								<label for="sModelYear2" class="label_chk"><span></span>2017~18년</label>
							</li>
							<li>
								<input type="checkbox" id="sModelYear3" name="sModelYear" value="2018~2019" class="rf_chk" onclick="filter5()" >
								<label for="sModelYear3" class="label_chk"><span></span>2018~19년</label>
							</li>
							<li>
								<input type="checkbox" id="sModelYear4" name="sModelYear" value="2019~2020" class="rf_chk" onclick="filter5()" >
								<label for="sModelYear4" class="label_chk"><span></span>2019~20년</label>
							</li>
							<li>
								<input type="checkbox" id="sModelYear5" name="sModelYear" value="2020~2021" class="rf_chk" onclick="filter5()" >
								<label for="sModelYear5" class="label_chk"><span></span>2020~21년</label>
							</li>
							<li>
								<input type="checkbox" id="sModelYear6" name="sModelYear" value="2021~2022" class="rf_chk" onclick="filter5()" >
								<label for="sModelYear6" class="label_chk"><span></span>2021~22년</label>
							</li>
							<li>
								<input type="checkbox" id="sModelYear7" name="sModelYear" value="2022~2023" class="rf_chk" onclick="filter5()" >
								<label for="sModelYear7" class="label_chk"><span></span>2022~23년</label>
							</li>
							<li>
								<input type="checkbox" id="sModelYear8" name="sModelYear" value="2023~2024" class="rf_chk" onclick="filter5()" >
								<label for="sModelYear8" class="label_chk"><span></span>2023~24년</label>
							</li>
							<li>
								<input type="checkbox" id="sModelYear9" name="sModelYear" value="2024~2025" class="rf_chk" onclick="filter5()" >
								<label for="sModelYear9" class="label_chk"><span></span>2024~25년</label>
							</li>
							<li>
								<input type="checkbox" id="sModelYear10" name="sModelYear" value="2025~2026" class="rf_chk" onclick="filter5()" >
								<label for="sModelYear10" class="label_chk"><span></span>2025~26년</label>
							</li>
						</ul>
					</div>

					<div class="section-box item-list open">
						<div class="category-tit">옵션</div>
						<ul class="hide_type half">
							<c:forEach var="code" items="${carOptList}" varStatus="status">
								<li>
									<input type="checkbox" id="info_${status.index}" name="sIconCd" class="rf_chk" value="${code.cdNum}" onclick="filter6()" <c:if test="${code.cdNum eq param.sIconCd}">checked</c:if>  >
									<label for="info_${status.index}" class="label_chk">${code.cdNm}</label>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<!-- // filter_wrap -->
			<!-- list_wrap -->
			<div class="list_wrap">
				<h2 class="sec-caption">렌트카 목록</h2>
				<div class="rc_list">
					<div class="align-area">
						<div class="caption-typeB">아직 날짜 검색 전입니다. 원하는 날짜에 따라 금액이 달라질 수 있습니다.</div>
					</div>
					<div class="__sort">
						<div class="sort-filter">
							<ul>
								<li class="sortRent1">
									<button type="button" id="sOrderCd0" name="sOrderCd" value="GPA" class="sort" >차량명</button>
								</li>
								<li class="sortRent2">
									<button type="button" id="sOrderCd1" name="sOrderCd" value="PRICE" class="sort active">가격순</button>
								</li>
								<li class="sortRent3">
									<button type="button" id="sOrderCd2" name="sOrderCd" value="SALE" class="sort">판매순</button>
								</li>
								<%--<li class="sortRent4">
									<button type="button" onclick="" id="sOrderCd3" name="sOrderCd" value="NEW" class="sort <c:if test="${searchVO.orderCd==Constant.ORDER_NEW}">active</c:if>">최신등록순</button>
								</li>--%>
							</ul>
							<div class="sort-right">
								<div class="area type select">
									<label for="sCorpId">판매처</label>
									<select name="sCorpId" id="sCorpId">
										<option value="" <c:if test="${empty searchVO.sCorpId}">selected="selected"</c:if>>판매처 전체</option>
										<c:forEach var="corp" items="${corpList}" varStatus="status">

											<option value="${corp.corpId}" <c:if test="${searchVO.sCorpId==corp.corpId}">selected="selected"</c:if>>${corp.corpNm}</option>

										</c:forEach>
									</select>
								</div>
								<div class="sort-search">
									<input type="text" id="searchWord1" placeholder="검색 결과 내 차량명 검색" autocapitalize="off" onkeyup="filterWords(this.value)">
									<button type="button" title="검색" class="sort-search-btn"></button>
								</div>
							</div>
						</div>
					</div>
					<div id="prdtDiv" class="rent-list-area rent-list-area2">
						<template v-for="(carDiv, index) in carDivList" :key="carDiv.id">
							<div class="rent-group" data-filter="Y" :data-top-price="getRcMinAmt(carDiv)" :data-top-seller="carDiv.buyNum" :data-top-prdtnm="carDiv.prdtNm">
								<div class="top-info">
									<div class="info-tie">
										<div class="photo">
											<img class="logo-play maker" alt="차량로고" :src="'/images/web/rent/' + carDiv.makerDiv + '.png'" @error="onMakerLogoError" />
											<img :src="carDiv.carImg" alt="렌터카차량 이미지" @error="onCarImageError" />
										</div>
										<div class="text">
											<div class="align-left">
												<h2 class="title">{{ carDiv.prdtNm }}</h2>
												<div class="sub-memo">
													<ul>
														<li><img src="/images/web/rent/list_kind.png" alt="차종" /><span>{{ carDiv.carDivNm }}</span></li>
														<li><img src="/images/web/rent/list_people.png" alt="탑승인원" /><span>{{ carDiv.maxiNum }}명</span></li>
														<li><img src="/images/web/rent/list_oil.png" alt="주유" /><span>{{ carDiv.useFuelDivNm }}</span></li>
													</ul>
												</div>
												<div class="align-right">
												<div class="memo">{{ difTm }}시간</div>
												<div class="info">
													<div class="red-sticker">최저가</div>
													<div class="price">{{ formatNumber(getRcMinAmt(carDiv)) }}원</div>
												</div>
											</div>
											</div>
										</div>
									</div>
									<div class="reservation-btn-group">
										<button class="lowest-price" type="button" onclick="fn_DetailPrdtLowCost(this)">최저가 예약</button>
									</div>
								</div>
								<div class="list">
									<ul>
										<li v-for="(prdtInfo, pStatusIndex) in Object.values(prdtMap[carDiv.prdtAllNm])" :key="pStatusIndex" :data-price="prdtInfo.saleAmt" data-filter-child="Y" :data-top-carname="carDiv.prdtNm" data-filterWords-visible="Y" :data-filter0="prdtInfo.corpId" data-filter0-visible="Y" :data-filter1="carDiv.carDiv" data-filter1-visible="Y" :data-filter2="prdtInfo.isrTypeDiv" data-filter2-visible="Y" :data-filter3="prdtInfo.rntQlfctAge" data-filter3-visible="Y" :data-filter4="prdtInfo.useFuelDiv" data-filter4-visible="Y" :data-filter5="prdtInfo.modelYear" data-filter5-visible="Y" :data-filter6="prdtInfo.iconCds" data-filter6-visible="Y" :data-filter7="prdtInfo.tamnacardYn" data-filter7-visible="Y" :data-filter8="prdtInfo.rntQlfctCareer" data-filter8-visible="Y" :data-filter9="prdtInfo.couponCnt" data-filter9-visible="1" :class="['prdtView_' + carDiv.rcCardivNum, pStatusIndex > 2 ? 'hide' : '', 'listli']">
											<div class="link-area">
												<a :href="'javascript:fn_DetailPrdt(\'' + prdtInfo.prdtNum + '\')'">
													<div class="product-info">
														<div class="name"><p>{{ prdtInfo.corpNm }}</p></div>
														<div class="rent-cover">
															<div v-if="prdtInfo.isrDiv !== 'ID10'" class="text">자차미포함</div>
															<template v-else>
																<div v-if="prdtInfo.isrTypeDiv === constants.RC_ISR_TYPE_GEN" class="text common">일반자차
																</div>
																<div v-else-if="prdtInfo.isrTypeDiv === constants.RC_ISR_TYPE_LUX" class="text advanced">고급자차
																</div>
																<div v-else-if="prdtInfo.isrTypeDiv === constants.RC_ISR_TYPE_ULM" class="text advanced">고급자차(전액무제한)
																</div>
															</template>
															<div class="career">경력{{ prdtInfo.rntQlfctCareer }}년 이상</div>
														</div>
														<div class="rent-option">
															<div class="since">{{ prdtInfo.modelYear }}</div>
															<div class="age">만{{ prdtInfo.rntQlfctAge }}세이상</div>
														</div>
													</div>
													<div class="rc-tx">
														<span class="car_op">
															<ul>
																<li v-for="(value, key, index) in rcCodeMap" :key="index" :class="{ on: isIconCdIncluded(prdtInfo, key) }">{{ value }}</li>
															</ul>
														</span>
													</div>
													<div class="price-info">
														<div class="bxLabel">
															<span v-if="prdtInfo.eventCnt > 0" class="main_label eventblue">이벤트</span>
															<!-- 프로모션 종료 후 ~40%쿠폰에서 할인쿠폰으로 변경 -->
															<span v-if="prdtInfo.couponCnt === '1'" class="main_label pink">할인쿠폰</span>
															<span v-if="prdtInfo.tamnacardYn === 'Y'" class="main_label yellow">탐나는전</span>
															<span v-if="prdtInfo.superbCorpYn === 'Y'" class="main_label back-red">우수관광사업체</span>
														</div>
														<div class="price">{{ formatNumber(prdtInfo.saleAmt) }}<span class="won">원</span></div>
													</div>
												</a>
											</div>
										</li>
									</ul>
									<button v-if="Object.values(prdtMap[carDiv.prdtAllNm]).length > 3" type="button" :onclick="'fn_rcPrdtView(\'' + carDiv.rcCardivNum + '\')'" class="paging-wrap">
										<span :id="'viewTitle_' + carDiv.rcCardivNum" class="mobile">예약 가능한 업체 더보기</span>
										<img class="add_arrow" src="/images/web/rent/add_arrow.png" alt="더보기" />
									</button>
								</div>
							</div>
						</template>
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
					<!-- //rent-list-area -->
					<%--<div class="paging-wrap" id="moreBtn">
						<a href="javascript:void(0);" id="moreBtnLink" class="mobile" style="display:none;">더보기</a>
					</div>--%>
				</div>
			</div>
			<!-- list_wrap -->
		</div>
		<div id="insurance_info" class="comm-layer-popup_fixed">
			<div class="content-wrap">
				<div class="content">
					<div class="installment-head">
						<h3 class="title"></h3>
						<button type="button" class="close" onclick="close_popup('#insurance_info')"><img src="../../images/mw/icon/close/dark-gray.png" loading="lazy" alt="닫기"></button>
						<!-- 1109 자차보험 안내 레이어팝업 업데이트 -->
						<div class="rent-qna">
							<div class="car_insurance">
								<div class="info-head">자차보험 <span>안내</span></div>
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
										<img src="../../images/web/rent/insurance.png" loading="lazy" alt="탐나르방">
									</div>
								</div><!-- //free-wrap -->
							</div><!-- //free_installment -->
						</div>
						<!-- //1109 자차보험 안내 레이어팝업 업데이트 -->
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- // subContents -->
</main>

<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'z6lvrbj4SSWpNEpzvpAqiA'
    };
</script>
<script async type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js"></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->

<script src="/js/vue.js?version=${nowDate}"></script>
<script src="/js/axios.min.js?version=${nowDate}"></script>
<script type="text/javascript" src="<c:url value='/js/multiple-select.js?version=${nowDate}'/>"></script>
<script type="text/javascript">

	window.addEventListener("beforeunload", (event) => {
      console.log("Page is being unloaded.");
    });
	window.addEventListener('pageshow', function(event) {
  	if (event.persisted) {
		console.log("bf-cache");
	  }else{
  		console.log("no-cache");
	}
	});

    var prevIndex = 0;
	function fn_rcPrdtView(obj) {
        var i = 0;
        if ($('.prdtView_' + obj + '.hide').length > 0) {
            $('.prdtView_' + obj).removeClass('hide');
            $('#viewTitle_' + obj).text("접기");
            $('#viewTitle_' + obj).next().css("transform","rotate(180deg)").animate(200);
        }
        else {
            $('.prdtView_' + obj).each(function() {
                if($(this).attr("data-filter-child") == "Y"){
                    if(i > 2){
                    $(this).addClass('hide');
                    }
                    ++i;
                }
            });

            $('#viewTitle_' + obj).text("예약 가능한 업체 더보기");
            $('#viewTitle_' + obj).next().css("transform","rotate(0deg)").animate(200);
        }
    }

	var reData = "";
	let pageCnt = 0;
	function fn_rcSearchInit(pageIndex){
		/** 검색어 초기화 */
		$("#searchWord1").val("<c:out value='${searchVO.sPrdtNm}'/>");
		/** 렌트카 이용시간 계산 시작 */
		let tmpStartDt = $('#sFromDtView').val();
		tmpStartDt = tmpStartDt.split("-");
		let tmpStartTime = $("#sFromTm").val();
		tmpStartTime = tmpStartTime.substring(0,2);
		let tmpEndDt = $('#sToDtView').val();
		tmpEndDt = tmpEndDt.split("-");
		let tmpEndTime = $("#sToTm").val();
		tmpEndTime = tmpEndTime.substring(0,2);
		let startDate = new Date(tmpStartDt[0],Number(tmpStartDt[1])-1,Number(tmpStartDt[2]),tmpStartTime,00,00);
		let endDate = new Date(tmpEndDt[0],Number(tmpEndDt[1])-1,Number(tmpEndDt[2]),tmpEndTime,00,00);
		let rentTime = (endDate.getTime() - startDate.getTime()) / 60000 / 60;
		let now = new Date(),
				strNow = String(now),
				nowYear = String(now.getFullYear()),
				nowMon = String(now.getMonth()+1),
				nowDay = String(now.getDate()),
				nowHours = String(now.getHours()),
				nowMinutes = String(now.getMinutes());

		if(nowMon.length == 1) {
			nowMon = "0"+nowMon
		}
		if(nowDay.length == 1) {
			nowDay = "0"+nowDay
		}
		if(nowHours.length == 1) {
			nowHours = "0"+nowHours
		}
		if(nowMinutes.length == 1) {
			nowMinutes = "0"+nowMinutes
		}

		let nowToday = nowYear + '-' + nowMon + '-' + nowDay;
		let nowTime = nowHours + nowMinutes;

		if($('#sFromDtView').val() == nowToday){
			if($("#sFromTm").val() < nowTime){
				alert("현재시간 이후부터 선택이 가능합니다.");
				return false;
			}
		}

		let capStr = '<strong class="text-red">' + $('#sFromDtView').val()+"부터 ";
		capStr += rentTime + "시간 기준" + "</strong>" ;
		capStr += " 가격입니다. 자차 보험 포함여부, 차량 연식, 옵션 등을 비교하여 합리적으로 구매할 수 있습니다. ";

		$('.caption-typeB').html(capStr);
		/** 렌트카 이용시간 계산 끝 */
		$("#searchYn").val("${Constant.FLAG_Y}");
		$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
		$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
		$(".product-more-area").hide();
		$(".today-keyword").hide();
		fn_RcSearch(pageIndex);
	}


	function fn_RcSearch(pageIndex) {
		$("#pageIndex").val(pageIndex);
		$("#curPage").text(pageIndex);
		let parameters = $("#frm").serialize();
		app.fetchData(parameters);
	}

	function fn_DetailPrdt(prdtNum){
		++prevIndex;
        history.replaceState($("main").html(), "title 1", "?prevIndex="+ prevIndex);
		$("#prdtNum").val(prdtNum);
		document.frm.target = "_self";
		document.frm.action = "<c:url value='/web/rentcar/car-detail.do'/>";
		document.frm.submit();
	}

	function fn_DetailPrdtLowCost(a){
		let rentGroup = $(a).closest(".rent-group");
		let tempPrdtNum = "";

		$(".list ul .listli", rentGroup).each(function (index) {
			if($(this).attr("data-filter-child") == "Y"){
					tempPrdtNum = $(this).find("a").attr("href");
				return false;
			}
		});

		tempPrdtNum = tempPrdtNum.split("'");
		let prdtNum = tempPrdtNum[1];
		++prevIndex;
        history.replaceState($("main").html(), "title 1", "?prevIndex="+ prevIndex);

		$("#prdtNum").val(prdtNum);
		document.frm.target = "_self";
		document.frm.action = "<c:url value='/web/rentcar/car-detail.do'/>";
		document.frm.submit();
	}

	function sliderRange(){
		$( "#slider-range" ).slider({
			range: true,
			step: 5000,
			min: Number($("#minPrice").val()),
			max: Number($("#maxPrice").val()),
			values: [ Number($("#minPrice").val()), Number($("#maxPrice").val()) ],
			slide: function( event, ui ) {
				$( "#slideAmount" ).val( commaNum(ui.values[ 0 ]) + "원" + " - " + commaNum(ui.values[ 1 ]) + "원" );
				$("#minPrice").val(ui.values[ 0 ]);
				$("#maxPrice").val(ui.values[ 1 ]);
				filterPrice();
				filterFunc();
			}
		});
		$( "#slideAmount" ).val( commaNum($( "#slider-range" ).slider( "values", 0 )) + "원" + " - " + commaNum($( "#slider-range" ).slider( "values", 1 )) + "원" );
	}

	var app;
	$(document).ready(function(){
		app = new Vue({
            el: '#prdtDiv',
            data: {
                carDivList: '',
				prdtMap: '',
				rcCodeMap:'',
				difTm:'',
				constants: {
				RC_ISR_TYPE_GEN: 'GENL',   // 상수 값 업데이트
				RC_ISR_TYPE_LUX: 'LUXY',  // 상수 값 업데이트
				RC_ISR_TYPE_ULM: 'ULIM',  // 상수 값 업데이트
				// 필요한 다른 상수들 추가
			  },
            },
            methods: {
				getRcMinAmt(carDiv) {
				const prdtInfosObj = this.prdtMap[carDiv.prdtAllNm];
				if (!prdtInfosObj || Object.keys(prdtInfosObj).length === 0) {
				return 0;
				}
				// 객체의 값을 배열로 변환
				const prdtInfos = Object.values(prdtInfosObj);

				// 초기 최소값 설정 (숫자로 변환)
				let rcMinAmt = Number(prdtInfos[0].saleAmt);

				prdtInfos.forEach((prdtInfo) => {
					const rcAmt = Number(prdtInfo.saleAmt);
					if (rcAmt < rcMinAmt) {
					rcMinAmt = rcAmt;
					}
				});
				return rcMinAmt;
				},
				isIconCdIncluded(prdtInfo, codeKey) {
					if (!prdtInfo.iconCds) return false;
					const iconCdArray = prdtInfo.iconCds.split(',');
					return iconCdArray.includes(codeKey);
				},
				formatNumber(value) {
				return new Intl.NumberFormat().format(value);
				},
				onMakerLogoError(event) {
				event.target.src = '/images/web/rent/defaultMD.png';
				},
				onCarImageError(event) {
				event.target.src = '/images/web/other/no-image.jpg';
				},
                fetchData(parameters) {
					 $(".modal-spinner").show();
                    axios.post('/web/rc/rcList.ajax',parameters) // JSP에서 데이터를 받아옴
                        .then(response => {
							this.carDivList = response.data.carDivList;
							this.prdtMap = response.data.prdtMap;
							this.rcCodeMap = response.data.rcCodeMap;
							this.difTm = response.data.difTm;
                        })
                        .catch(error => {
						console.error('데이터를 가져오는 중 오류 발생:', error);
						})
						.finally(() => {
							$(".modal-spinner").hide();
							$('#searchBtn1').attr('disabled', false);
							$("#totPage").text($("input[name=totalPageCnt]").val());

							// Setting checked values based on searchVO
							if (pageCnt === 0) {
								if ("${searchVO.sCarDivCd}") {
									$('input[name="sCarDivCdStr"][value="${searchVO.sCarDivCd}"]').prop('checked', true);
								}
								if ("${searchVO.sIsrTypeDiv}") {
									$('input[name="sIsrTypeDiv"][value="${searchVO.sIsrTypeDiv}"]').prop('checked', true);
								}
								if ("${searchVO.sIsrTypeDiv}" == 'LUXY') {
									$('input[name="sIsrTypeDiv"][value="ULIM"]').prop('checked', true);
								}
								if ("${searchVO.sRntQlfctAge}") {
									$('input[name="sRntQlfctAge"][value="${searchVO.sRntQlfctAge}"]').prop('checked', true);
								}
								if ("${searchVO.sUseFuelDiv}") {
									$('input[name="sUseFuelDiv"][value="${searchVO.sUseFuelDiv}"]').prop('checked', true);
								}
								++pageCnt;
							}

							filter0("Y");
							filter1("Y");
							filter2("Y");
							filter3("Y");
							filter4("Y");
							filter5("Y");
							filter6("Y");
							filter7("Y");
							filter8("Y");
							filter9("1");

							filterFunc();
							sort();

							++prevIndex;
							//history.replaceState($("main").html(), "title"+ i, "?prevIndex="+ prevIndex);
							history.replaceState($("main").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
							currentState = history.state;

					});
                },
				onSecondFetch() {
					let parameters = $("#frm").serialize();
					this.fetchData(parameters);
			  },
            }
        });

		//파라미터값 호출 처리
		var currentState = history.state;
        if(currentState){
            $("#main").html(currentState);
            $(window).scrollTop($("#scroll").val());
            $("#sFromDtView").removeClass('hasDatepicker').datepicker();
            $("#sToDtView").removeClass('hasDatepicker').datepicker();
        }else{
            fn_rcSearchInit('1');
        }

        if ("${searchVO.sCouponCnt}" == "1"){
			$("#couponCnt").prop("checked", true);
		}

		$("#sFromDtView").datepicker({
			showOn: "both",
			buttonImage: "/images/web/icon/calendar_icon01.gif",
			buttonImageOnly: true,
			showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
			numberOfMonths: [ 1, 2 ],									//여러개월 달력 표시
			stepMonths: 2, 												//좌우 선택시 이동할 개월 수
			dateFormat: "yy-mm-dd",
			minDate: "${SVR_TODAY}",
			maxDate: "${AFTER_DAY}",
			onClose : function(selectedDate) {
				const fromDt = new Date(selectedDate);
				/** 시작검색일 SET*/
				$('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
				fromDt.setDate(fromDt.getDate());
				selectedDate = fromDt.getFullYear() + "-" + (fromDt.getMonth() + 1) + "-" + fromDt.getDate();
				/** 종료검색일 SET*/
				$("#sToDtView").datepicker("option", "minDate", selectedDate);
				$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
				var toDt = new Date($("#sToDtView").val());
				fromDt.setDate(fromDt.getDate() - 1);
			}
		});

		$("#sToDtView").datepicker({
			showOn: "both",
			buttonImage: "/images/web/icon/calendar_icon01.gif",
			buttonImageOnly: true,
			showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
			numberOfMonths: [ 1, 2 ],									//여러개월 달력 표시
			stepMonths: 2, 												//좌우 선택시 이동할 개월 수
			dateFormat: "yy-mm-dd",
			minDate: "${SVR_TODAY}",
			maxDate: "${AFTER_DAY}",
			onClose : function(selectedDate) {
				$('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
			}
		});



		/** 정렬*/
		$('button[name=sOrderCd]').click(function() {
			$("button[name=sOrderCd]").removeClass("active");
			$("button[name=sOrderCd]:button[value=" + $(this).val() + "]").addClass("active");
			$('#orderCd').val($(this).val());
			sort();
/*			filterFunc();*/
		});

		/** 판매처*/
		$('select[name=sCorpId]').change(function() {
			filter0();
			filterFunc();
		});

		$(".item-list .category-tit").click(function() {
			$(this).closest(".item-list");
			let index = $(".item-list").index($(this).closest(".item-list"));
			if($(".item-list:eq(" + index + ")").hasClass("open")){
				$(".item-list:eq(" + index + ")").removeClass("open");
			}else{
				$(".item-list:eq(" + index + ")").addClass("open");
			};
		});

		/*fn_rcSearchInit('1');*/

		$('input[type="checkbox"]').on('click', function(){
			console.log("차량 수 ::: "+$("[data-filter-child=Y]").length);
  		});
	});

	function enterkey() {
		if (window.event.keyCode == 13) {
			fn_rcSearchInit('1');
		}
	}

	function filterFunc(){
        $(".rent-group").each(function() {

            let $rentGroup = $(this);
            let $listItems = $rentGroup.find(".list ul .listli");

            let filterYn = false;
            let i = 0;
            $listItems.each(function () {
            	let $this = $(this);
                if($this.attr("data-filterWords-visible") == "Y" && $this.attr("data-filter0-visible") == "Y" && $this.attr("data-filter1-visible") == "Y" && $this.attr("data-filter2-visible") == "Y" && $this.attr("data-filter3-visible") == "Y" && $this.attr("data-filter4-visible") == "Y" && $this.attr("data-filter5-visible") == "Y" && $this.attr("data-filter6-visible") == "Y" && $this.attr("data-filter7-visible") == "Y" && $this.attr("data-filter8-visible") == "Y" && $this.attr("data-filter9-visible") == "1"){
                    $this.attr("data-filter-child","Y");
                    if(i == 0){
                        $this.parents(".rent-group").find(".top-info .price").html($(".price",this).text());
                        $rentGroup.attr("data-top-price", $this.attr("data-price"));
                    }
                    if(i<3){
                        $this.removeClass("hide");
                    }else{
                       $this.addClass("hide");
                    }
                    filterYn = true;
                    ++i;
                }else{
                    $this.attr("data-filter-child","N")
					$this.addClass("hide");
                }
            });
            /** .rent-group의 li가 하나라도 조건맞으면 */
            if(filterYn){
                $rentGroup.attr("data-filter","Y");
            }else{
                $rentGroup.attr("data-filter","N");
            }
            /** 더보기 개수 구하기*/
            if(i == 0){
                $rentGroup.attr("data-filter-child","N")
            }else if(i < 4){
                $rentGroup.find(".paging-wrap").hide();
                $rentGroup.attr("data-filter-child","Y")
            }
            else{
                $rentGroup.find(".paging-wrap").show();
                $rentGroup.attr("data-filter-child","Y")
            }
        });

        $("[data-filter=Y]").show();
        $("[data-filter=N]").hide();
        $("[data-filter-child=Y]").show();
        $("[data-filter-child=N]").hide();

        if($("[data-filter=Y]").length === 0) {
        	$(".item-noContent").remove();
            let addHtml = '<div class="item-noContent">';
            addHtml += '<p class="icon"><img src="<c:url value="/images/mw/sub_common/warning.png"/>"  alt="경고"></p>';
            addHtml += '<p class="text"><br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>';
            addHtml += '</div>';
            $("#prdtDiv").append(addHtml);
        }else{
        	$(".item-noContent").remove();
		}
        sort();
    }
	/** 검색어필터*/
	function filterWords(val) {
		let compVal = val.toUpperCase();
		$("[data-top-carname]").each(function() {
			let thisVal = $(this).attr("data-top-carname").toUpperCase();
			let isVisible = thisVal.includes(compVal);
			$(this).attr("data-filterWords-visible", isVisible ? "Y" : "N");
		});
		filterFunc();
	}

	/** 판매처필터*/
	function filter0() {
		let sCorpId = $("select[name=sCorpId]").val();
		$("[data-filter0]").each(function() {
			let isVisible = !sCorpId || sCorpId === $(this).attr("data-filter0");
			$(this).attr("data-filter0-visible", isVisible ? "Y" : "N");
		});
	}

	/** 차종필터*/
     function filter1(searchYn) {

		let $checkedCheckboxes = $('input[name=sCarDivCdStr]:checked');
		let $allCheckboxes = $('input[name=sCarDivCdStr]');
		let allChecked = ($checkedCheckboxes.length === $allCheckboxes.length) || ($checkedCheckboxes.length === 0);

		$(".list .listli").each(function() {
			let compVal = $(this).attr("data-filter1");
			let isVisible = allChecked || $checkedCheckboxes.filter('[value="' + compVal + '"]').length > 0;
			$(this).attr("data-filter1-visible", isVisible ? "Y" : "N");
		});

		if (searchYn !== "Y") {
			filterFunc();
		}


	}

	/** 보험필터*/
	function filter2(searchYn) {
		let $checkedCheckboxes = $('input[name=sIsrTypeDiv]:checked');
		let $allCheckboxes = $('input[name=sIsrTypeDiv]');
		let allChecked = ($checkedCheckboxes.length === $allCheckboxes.length) || ($checkedCheckboxes.length === 0);

		$(".list .listli").each(function() {
			let compVal = $(this).attr("data-filter2");
			let isVisible = allChecked || $checkedCheckboxes.filter('[value="' + compVal + '"]').length > 0;
			$(this).attr("data-filter2-visible", isVisible ? "Y" : "N");
		});
		if (searchYn !== "Y") {
			filterFunc();
		}

	}

	/** 나이필터*/
	function filter3(searchYn) {
		let $checkedCheckboxes = $('input[name=sRntQlfctAge]:checked');
		let $allCheckboxes = $('input[name=sRntQlfctAge]');
		let allChecked = ($checkedCheckboxes.length === $allCheckboxes.length) || ($checkedCheckboxes.length === 0);

		$(".list .listli").each(function() {
			let compVal = parseFloat($(this).attr("data-filter3")); // Parse to float for numeric comparison
			let isVisible = allChecked || $checkedCheckboxes.filter(function() {
				return parseFloat($(this).val()) >= compVal;
			}).length > 0;
			$(this).attr("data-filter3-visible", isVisible ? "Y" : "N");
		});

		if (searchYn !== "Y") {
			filterFunc();
		}
	}

	/** 연료필터*/
	function filter4(searchYn) {
		let $checkedCheckboxes = $('input[name=sUseFuelDiv]:checked');
		let $allCheckboxes = $('input[name=sUseFuelDiv]');
		let allChecked = ($checkedCheckboxes.length === $allCheckboxes.length) || ($checkedCheckboxes.length === 0);

		$(".list .listli").each(function() {
			let compVal = $(this).attr("data-filter4");
			let isVisible = allChecked || $checkedCheckboxes.filter('[value="' + compVal + '"]').length > 0;
			$(this).attr("data-filter4-visible", isVisible ? "Y" : "N");
		});

		if (searchYn !== "Y") {
			filterFunc();
		}
	}

	/** 연식필터*/
	function filter5(searchYn) {
		let $checkedCheckboxes = $('input[name=sModelYear]:checked');
		let $allCheckboxes = $('input[name=sModelYear]');
		let allChecked = ($checkedCheckboxes.length === $allCheckboxes.length) || ($checkedCheckboxes.length === 0);

		$(".list .listli").each(function() {
			let compVal = $(this).attr("data-filter5");
			let isVisible = allChecked || $checkedCheckboxes.filter('[value="' + compVal + '"]').length > 0;
			$(this).attr("data-filter5-visible", isVisible ? "Y" : "N");
		});

		if (searchYn !== "Y") {
			filterFunc();
		}
	}

	/** 주요정보필터 */
	function filter6(searchYn){
		/*$("#prdtDiv").append(reData);*/
		if($('input[name=sIconCd]:checked').length == 0 ){
			$(".list .listli").attr("data-filter6-visible","Y");
			if(searchYn != "Y"){
				filterFunc();
			}
			return;
		}

		$("[data-filter6]").each(function() {
			var compElement = $(this);
			$('input[name=sIconCd]:checked').each(function(){
				if(compElement.attr("data-filter6").indexOf($(this).val()) == -1){
					compElement.attr("data-filter6-visible","N");
					return;
				}
			});
		});
		if(searchYn != "Y"){
			filterFunc();
		}
	}

	/** 탐나는전 */
	function filter7(searchYn) {
		let isChecked = $('input[name=tcard_yn]:checked').length > 0;

		if (!isChecked) {
			$(".list .listli").attr("data-filter7-visible", "Y");
		} else {
			$("[data-filter7]").each(function() {
				let compElement = $(this);
				let compVal = compElement.attr("data-filter7");
				let isVisible = $('input[name=tcard_yn]:checked').toArray().some(input => $(input).val() == compVal);
				compElement.attr("data-filter7-visible", isVisible ? "Y" : "N");
			});
		}

		if (searchYn !== "Y") {
			filterFunc();
		}
	}

	/** 할인쿠폰 */
	function filter9(searchYn) {
		let isChecked = $('input[name=couponCnt]:checked').length > 0;

		if (!isChecked) {
			$(".list .listli").attr("data-filter9-visible", "1");
		} else {
			$("[data-filter9]").each(function() {
				let compElement = $(this);
				let compVal = compElement.attr("data-filter9");
				let isVisible = $('input[name=couponCnt]:checked').toArray().some(input => $(input).val() == compVal);
				compElement.attr("data-filter9-visible", isVisible ? "1" : "0");
			});
		}

		if (searchYn !== "Y") {
			filterFunc();
		}
	}

	/** 경력필터 */
	function filter8(searchYn) {
		if ($('input[name=sRntQlfctCareer]:checked').length === 0) {
			$(".list .listli").attr("data-filter8-visible", "Y");
		} else {
			$("[data-filter8]").each(function() {
				let compVal = parseFloat($(this).attr("data-filter8"));
				let isVisible = $('input[name=sRntQlfctCareer]:checked').toArray().some(input => parseFloat($(input).val()) >= compVal);
				$(this).attr("data-filter8-visible", isVisible ? "Y" : "N");
			});
		}

		if (searchYn !== "Y") {
			filterFunc();
		}
	}

	/** 금액필터*/
	function filterPrice(){
		$("[data-top-price]").each(function() {
			if(Number($(this).attr("data-top-price")) <= Number($("#maxPrice").val()) && Number($(this).attr("data-top-price")) >= Number($("#minPrice").val()) )
			{
				$(this).attr("data-top-price-visible","Y");
			}else{
				$(this).attr("data-top-price-visible","N");
			}
		});
	}

	function sort() {
        let activeButton = document.querySelector("button[name=sOrderCd].active");
        let param = activeButton ? activeButton.value : null;

        // .rent-group 클래스를 가진 모든 요소를 배열로 변환합니다.
        let elements = Array.from(document.querySelectorAll(".rent-group"));

        // 정렬을 위한 값들을 미리 추출하여 배열로 매핑합니다.
        let mapped = elements.map((el, index) => {
            let value;
            switch (param) {
                case "SALE":
                    value = parseInt(el.dataset.topSeller, 10);
                    break;
                case "PRICE":
                    value = parseInt(el.dataset.topPrice, 10);
                    break;
                default:
                    value = el.dataset.topPrdtnm;
                    break;
            }
            return { index, value };
        });

        mapped.sort((a, b) => {
            if (typeof a.value === "string") {
                return a.value.localeCompare(b.value);
            } else {
                if (param === "PRICE") {
                    // PRICE의 경우 내림차순 정렬 (높은 가격 -> 낮은 가격)
                    return a.value - b.value;
                } else {
                    return b.value - a.value;
                }
            }
        });

        // 정렬된 배열을 사용해 새로운 순서로 요소들을 재배열합니다.
        let fragment = document.createDocumentFragment();
        mapped.forEach(({ index }) => {
            fragment.appendChild(elements[index]);
        });

        // 정렬된 요소들을 DOM에 한 번에 삽입합니다.
        let prdtDiv = document.getElementById("prdtDiv");
        prdtDiv.innerHTML = "";  // 기존 내용을 모두 비웁니다.
        prdtDiv.appendChild(fragment);

		if($("[data-filter=Y]").length == 0){
			$(".item-noContent").remove();
            let addHtml = '<div class="item-noContent">';
            addHtml += '<p class="icon"><img src="<c:url value="/images/mw/sub_common/warning.png"/>"  alt="경고"></p>';
            addHtml += '<p class="text"><br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>';
            addHtml += '</div>';
            $("#prdtDiv").append(addHtml);
        }else{
        	$(".item-noContent").remove();
		}
	}

	function funcClear(){
		$("input[type=checkbox]").prop("checked",false);
		$("#searchWord1").val("");
		filterWords("");
		$("select[name=sCorpId] option:eq(0)").prop("selected", true);
		filter0("Y");
		filter1("Y");
		filter2("Y");
		filter3("Y");
		filter4("Y");
		filter5("Y");
		filter6("Y");
		filter7("Y");
		filter8("Y");
		filter9("1");
		filterFunc();
	}

	function oneCheckbox(a){
		let obj = document.getElementsByName("sRntQlfctAge");
		for(let i=0; i<obj.length; i++){
			if(obj[i] != a){
				obj[i].checked = false;
			}
		}
	}

	function oneCheckbox2(a){
		let obj = document.getElementsByName("sRntQlfctCareer");
		for(let i=0; i<obj.length; i++){
			if(obj[i] != a){
				obj[i].checked = false;
			}
		}
	}
</script>
<jsp:include page="/web/foot.do"></jsp:include>
</body>
</html>