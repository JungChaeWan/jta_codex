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
<meta name="robots" content="noindex">
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="제주도 렌터카 최저가 가격비교 예약"/>
	<jsp:param name="keywords" value="제주, 제주도 여행, 제주도 관광, 렌터카, 실시간 예약, 탐나오"/>
	<jsp:param name="description" value="제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 실시간 렌터카예약"/>
</jsp:include>
<meta property="og:title" content="제주도 렌터카 최저가 예약">
<meta property="og:url" content="https://www.tamnao.com/mw/rentcar/car-list.do">
<meta property="og:description" content="제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 실시간 렌터카예약">
<meta property="og:image" content="https://www.tamnao.com/images/mw/rent/rent-visual.png">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui-mobile.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}' />">
<link rel="stylesheet" type="text/css" href="/css/mw/daterangepicker.css?version=${nowDate}">
<link rel="stylesheet" type="text/css" href="/css/mw/rc.css?version=${nowDate}">
<link rel="canonical" href="https://www.tamnao.com/web/rentcar/car-list.do">
<link rel="preload" as="image" href="../../images/mw/rent/r-h-back.png" />
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" >
		<jsp:param name="headTitle" value="렌트카"/>
	</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<main id="main" class="rc-rent">
	<form name="frm" id="frm" method="get" onSubmit="return false;" target="_blank">
		<div class="mw-rent-header">
			<!-- 0920 시간선택 html 수정 -->
			<div class="mw-rent-date">
				<div class="dateRangePickMw">
					<dl>
						<dt>인수일</dt>
						<dd>
							<div>
								<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
								<input placeholder="대여일 선택" name="sFromDtView" id="sFromDtView" value="${searchVO.sFromDtView}" readonly="readonly">
							</div>
						</dd>
					</dl>
					<dl>
						<dt>반납일</dt>
						<dd>
							<div>
								<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
								<input placeholder="반납일" name="sToDtView" id="sToDtView" value="${searchVO.sToDtView}" readonly="readonly">
							</div>
						</dd>
					</dl>
				</div>
				<img class="date-arrow" src="../../images/mw/icon/form/r-h-btn.png" alt="변경">

				<div class="mw-rent-time">
					<!-- 인수일 시간 선택 -->
					<dl>
						<dt></dt>
						<dd>
							<div>
								<select name="sFromTm" id="sFromTm" class="full" title="시간선택" onchange="click_check(false);">
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
						</dd>
					</dl>
					<!-- 반납일 시간 선택 -->
					<dl>
						<dt></dt>
						<dd>
							<div>
								<select name="sToTm" id="sToTm" class="full" title="시간선택" onchange="click_check(false);">
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
						</dd>
					</dl>
				</div>

			</div>
			<div class="mw-rent-etc">
				<a class="mw-rent-insurance" id="carDivStr">
					<img src="../../../images/mw/rent/rent-btn.png" alt="차종선택">
					<c:forEach var="code" items="${carDivCd}" varStatus="status">
						<c:if test="${searchVO.sCarDivCd eq code.cdNum }"> ${code.cdNm}</c:if>
					</c:forEach>
					<c:if test="${empty searchVO.sCarDivCd}"> 차종 전체</c:if>
				</a>

				<a class="mw-rent-type"  id="sIsrTypeDivStr">
					<img src="../../../images/mw/rent/rent-btn.png" alt="보험 전체">
					<c:if test="${empty searchVO.sIsrTypeDiv}">보험 전체</c:if>
					<c:if test="${searchVO.sIsrTypeDiv eq 'FEE' }"> 자차 미포함</c:if>
					<c:if test="${searchVO.sIsrTypeDiv eq 'GENL' }"> 일반자차포함</c:if>
					<c:if test="${searchVO.sIsrTypeDiv eq 'LUXY' }"> 고급자차포함</c:if>
					<c:if test="${searchVO.sIsrTypeDiv eq 'ULIM' }"> 고급자차(전액무제한)</c:if>
				</a>
			</div>
			<!-- 차종 선택 / layer-popup -->
			<div id="rent_zone" class="popup-typeA rent-zone">
				<div class="rent-wrapper">
					<a class="close-btn" onclick="rc_close_popup('#rent_zone')" ></a>
					<div class="content-area">
						<div class="list-group">
							<strong class="list-sub-title">차종을 선택해주세요</strong>
							<ul class="select-menu col3">
								<li>
									<div class="lb-box">
										<input id="sCarDivCd0" name="sCarDivCd" type="radio" value checked>
										<label for="sCarDivCd0">전체</label>
									</div>
								</li>
								<c:forEach var="code" items="${carDivCd}" varStatus="status">
                                    <li>
                                        <div class="lb-box">
                                            <input id="sCarDivCd${status.count}" name="sCarDivCd" type="radio" value="${code.cdNum}" <c:if test="${searchVO.sCarDivCd eq code.cdNum }"> checked</c:if> <c:if test="${searchVO.sCarDivCd eq 'sCarDivCd2' }"> checked</c:if>>
                                            <label for="sCarDivCd${status.count}">${code.cdNm}</label>
                                        </div>
                                    </li>
                                </c:forEach>
							</ul>
						</div>
					</div>
					<div class="fix-cta">
						<button href="#" class="result-btn decide comm-btn" onclick="fn_ClickSearch('#rent_zone')">적용</button>
					</div>
				</div><!-- //hotel-wrapper -->
			</div>


			<!-- 보험 선택 / layer-popup -->
			<div id="rent_zone2" class="popup-typeA rent-zone">
				<div class="rent-wrapper">
					<a class="close-btn" onclick="rc_close_popup('#rent_zone2')"></a>
					<div class="content-area">
						<div class="list-group">
							<strong class="list-sub-title">보험을 선택해주세요.</strong>
							<ul class="select-menu col4">
								<li class="insurance">
									<div class="lb-box">
										<input id="sIsrTypeDiv0" name="sIsrTypeDiv" type="radio" value="" checked>
										<label for="sIsrTypeDiv0">전체</label>
									</div>
								</li>
								<li class="insurance">
									<div class="lb-box">
										<input id="sIsrTypeDiv1" name="sIsrTypeDiv" type="radio" value="FEE" <c:if test="${searchVO.sIsrTypeDiv== 'FEE'}">checked</c:if>>
										<label for="sIsrTypeDiv1">자차 미포함</label>
									</div>
								</li>
								<li class="insurance">
									<div class="lb-box">
										<input id="sIsrTypeDiv2" name="sIsrTypeDiv" type="radio" value="GENL" <c:if test="${searchVO.sIsrTypeDiv== 'GENL'}">checked</c:if>>
										<label for="sIsrTypeDiv2">일반자차포함</label>
									</div>
								</li>
								<li class="insurance">
									<div class="lb-box">
										<input id="sIsrTypeDiv3" name="sIsrTypeDiv" type="radio" value="LUXY" <c:if test="${searchVO.sIsrTypeDiv== 'LUXY'}">checked</c:if>>
										<label for="sIsrTypeDiv3">고급자차포함</label>
									</div>
								</li>
								<li class="insurance">
									<div class="lb-box">
										<input id="sIsrTypeDiv4" name="sIsrTypeDiv" type="radio" value="ULIM" <c:if test="${searchVO.sIsrTypeDiv== 'ULIM'}">checked</c:if>>
										<label for="sIsrTypeDiv4">고급자차(전액무제한)</label>
									</div>
								</li>
							</ul>
						</div>

						<ul class="list-disc type-A">
							<li>오전  8시 ~ 오후 8시 외 차량 대여/반납은 일부 업체만 가능하며, 추가요금이 발생하거나 완전자차 보험가입이 필요할 수 있습니다.</li>
						</ul>
					</div><!-- //content-area -->
					<div class="fix-cta">
						<button href="#" class="result-btn decide comm-btn" onclick="fn_ClickSearch('#rent_zone2')">적용</button>
					</div>
				</div><!-- //rent-wrapper -->
			</div>

		</div>
	<!--//change contents-->
	<div class="mw-list-area">
		<input type="hidden" name="scroll" id="scroll" value="" />
		<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
		<input type="hidden" name="sCarDivCdView" id="sCarDivCdView" value="${searchVO.sCarDivCdView}" />
		<input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
		<input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />
		<input type="hidden" name="mYn" id="mYn" value="${searchVO.mYn}" />
		<input type="hidden" name="searchYn" id="searchYn" value="${Constant.FLAG_Y}" />
		<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}" />
		<input type="hidden" name="prdtNum" id="prdtNum" />
		<input type="hidden" name="sIsrDiv" id="sIsrDiv" value="${searchVO.sIsrDiv}" />	<!-- 보험여부 -->
		<input type="hidden" name="sRcCardivNum" id="sRcCardivNum" value="${searchVO.sRcCardivNum}">
		<input type="hidden" name="sIconCdCnt" id="sIconCdCnt" value="${searchVO.sIconCdCnt}" /> <!-- 제조사 검색 -->
		<input type="hidden" name="sRntQlfctAge" id="sRntQlfctAge" value="${searchVO.sRntQlfctAge}"> <!--운전자 연령-->
		<input type="hidden" name="sRntQlfctCareer" id="sRntQlfctCareer" value="${searchVO.sRntQlfctCareer}">  <!--운전자 경력-->
		<section class="search-typeA">
			<div class="option">
				<div class="option-btn">
					<div id="rent_sort" class="popup-typeA rent-option">
						<div class="rent-wrapper">
							<a class="close-btn" onclick="rc_close_popup('#rent_sort')"></a>
							<div class="content-area">
								<div class="list-group">
									<strong class="list-sub-title">정렬을 선택해주세요.</strong>
									<ul class="select-menu col3">
										<li>
											<div class="lb-box">
												<input id="sOrderCd0" name="sOrderCd" value='' type="radio">
												<label for="sOrderCd0">차량명</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="sOrderCd1" name="sOrderCd" value='PRICE' type="radio" checked>
												<label for="sOrderCd1">가격순</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="sOrderCd2" name="sOrderCd" value='SALE' type="radio">
												<label for="sOrderCd2">인기순</label>
											</div>
										</li>
									</ul>
								</div><!-- //content-area -->
								<div class="fix-cta">
									<button href="#" class="result-btn decide comm-btn" onclick="fn_ClickSearch('#rent_sort')">적용</button>
								</div>
							</div>
						</div>
					</div>
					<button type="button" class="rent-f-btn">필터</button>
					<button type="button" class="sort-f-btn">정렬</button>
					<div id="rent_option" class="popup-typeA rent-option">
						<div class="rent-wrapper">
							<div class="close_wrapper">
								<a class="close-btn" onclick="rc_close_popup('#rent_option')"></a>
							</div>
							<div class="content-area filter">
								<strong class="condition_title">조건을 선택해주세요.</strong>
								<div class="form">
									<input type="text" class="search-rent" name="sPrdtNm" value="${searchVO.sPrdtNm }" id="sPrdtNm" placeholder="차명을 검색해 주세요.">
								</div>

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

		<%--						<div class="list-group">
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
									<strong class="sub-title">사용연료</strong>
									<ul class="select-menu col4">
										<li>
											<div class="lb-box">
												<input id="sUseFuelDiv0" name="sUseFuelDiv" value='' type="radio" checked>
												<label for="sUseFuelDiv0">전체</label>
											</div>
										</li>
										<c:forEach var="fuel" items="${fuelCd}" varStatus="status">
											<li>
												<div class="lb-box">
													<input id="sUseFuelDiv${status.count }" name="sUseFuelDiv" value="${fuel.cdNum}" type="radio" <c:if test="${searchVO.sUseFuelDiv eq fuel.cdNum}">checked</c:if>>
													<label for="sUseFuelDiv${status.count }">${fuel.cdNm}</label>
												</div>
											</li>
										</c:forEach>
									</ul>
								</div>
								<div class="list-group">
									<strong class="sub-title">연식</strong>
									<ul class="select-menu col3">
										<li>
											<div class="lb-box">
												<input id="modelYear1" name="sModelYear" value='' type="radio" checked>
												<label for="modelYear1">전체</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="modelYear2" name="sModelYear" value="2016~2017" type="radio" <c:if test="${searchVO.sModelYear eq '2016~2017'}">checked</c:if>>
												<label for="modelYear2">2016~17년</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="modelYear3" name="sModelYear" value="2017~2018" type="radio" <c:if test="${searchVO.sModelYear eq '2017~2018'}">checked</c:if>>
												<label for="modelYear3">2017~18년</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="modelYear4" name="sModelYear" value="2018~2019" type="radio" <c:if test="${searchVO.sModelYear eq '2018~2019'}">checked</c:if>>
												<label for="modelYear4">2018~19년</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="modelYear5" name="sModelYear" value="2019~2020" type="radio" <c:if test="${searchVO.sModelYear eq '2019~2020'}">checked</c:if>>
												<label for="modelYear5">2019~20년</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="modelYear6" name="sModelYear" value="2020~2021" type="radio" <c:if test="${searchVO.sModelYear eq '2020~2021'}">checked</c:if>>
												<label for="modelYear6">2020~21년</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="modelYear7" name="sModelYear" value="2021~2022" type="radio" <c:if test="${searchVO.sModelYear eq '2021~2022'}">checked</c:if>>
												<label for="modelYear7">2021~22년</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="modelYear8" name="sModelYear" value="2022~2023" type="radio" <c:if test="${searchVO.sModelYear eq '2022~2023'}">checked</c:if>>
												<label for="modelYear8">2022~23년</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="modelYear9" name="sModelYear" value="2023~2024" type="radio" <c:if test="${searchVO.sModelYear eq '2023~2024'}">checked</c:if>>
												<label for="modelYear9">2023~24년</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="modelYear10" name="sModelYear" value="2024~2025" type="radio" <c:if test="${searchVO.sModelYear eq '2024~2025'}">checked</c:if>>
												<label for="modelYear10">2024~25년</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="modelYear11" name="sModelYear" value="2025~2026" type="radio" <c:if test="${searchVO.sModelYear eq '2025~2026'}">checked</c:if>>
												<label for="modelYear11">2024~25년</label>
											</div>
										</li>
									</ul>
								</div>
								<div class="list-group">
									<strong class="sub-title">옵션</strong>
									<ul class="select-menu col3">
										<c:forEach var="icon" items="${iconCd}" varStatus="status">
											<li>
												<div class="lb-box">
													<input id="iconCd${status.index}" name="sIconCd" value="${icon.cdNum}" type="checkbox" <c:if test="${fn:contains(searchVO.sIconCd, icon.cdNum)}">checked</c:if>>
													<label for="iconCd${status.index}">${icon.cdNm}</label>
												</div>
											</li>
										</c:forEach>
									</ul>
								</div>
								<%--<div class="list-group">
									<strong class="sub-title">판매사</strong>
									<ul class="select-menu col3">
										<li>
											<div class="lb-box">
												<input id="sCorpId0" name="sCorpId" value='' type="radio" checked>
												<label for="sCorpId0">전체</label>
											</div>
										</li>
										<li>
											<div class="lb-box">
												<input id="sCorpId1" name="sCorpId" value="C001511024" type="radio">
												<label for="sCorpId1">오케이렌트카</label>
											</div>
										</li>
									</ul>
								</div>--%>
							</div>
							<!-- 적용 btn -->
							<div class="fix-cta">
								<button href="#" class="result-btn decide comm-btn" onclick="rc_close_popup('#rent_option');fn_GoRc(1);">적용</button>
							</div><!-- //적용 btn -->
						</div>
					</div>
				</div>
			</div>
			<div class="form">
				<button type="button" class="search-btn" title="검색" onclick="fn_GoRc(1);">검색</button>
			</div>

			<!-- 0921 로딩바개선 -->
			<div class="modal-spinner">
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

		</section>

		<section class="rent-list-area" id="prdtList">
		<template v-for="(carDiv, index) in carDivList" :key="carDiv.id">
			<div class="rent-group" data-filter="Y" :data-top-price="getRcMinAmt(carDiv)" :data-top-seller="carDiv.buyNum">
				<div class="top-info">
					<div class="photo">
						<img :src="carDiv.carImg" alt="렌터카차량 이미지" @error="onCarImageError" />
					</div>
					<div class="text">
						<img class="logo-play maker" alt="차량로고" :src="'/images/web/rent/' + carDiv.makerDiv + '.png'" @error="onMakerLogoError" />
						<h2 class="title">{{ carDiv.prdtNm }}</h2>
						<div class="sub-memo">
							<div class="list_kind"><img src="/images/web/rent/list_kind.png" alt="차종" />{{ carDiv.carDivNm }}</div>
							<div class="list_people"><img src="/images/web/rent/list_people.png" alt="탑승인원" />{{ carDiv.maxiNum }}명</div>
							<div class="list_oil"><img src="/images/web/rent/list_oil.png" alt="주유" />{{ carDiv.useFuelDivNm }}</div>
						</div>
					</div>
				</div>
				<div class="list">
					<div class="bottom">
						<a :href="'javascript:fn_rcPrdtView(\'' + carDiv.rcCardivNum + '\')'">예약 가능한 업체
						<template v-if="Object.values(prdtMap[carDiv.prdtAllNm]).length > 3">
							<strong :id="'viewTitle_' + carDiv.rcCardivNum">더보기</strong>
						</template>
						</a>
					</div>
					<ul>
						<li v-for="(prdtInfo, pStatusIndex) in Object.values(prdtMap[carDiv.prdtAllNm])" :key="pStatusIndex" :data-price="prdtInfo.saleAmt" data-filter-child="Y" :data-top-carname="carDiv.prdtNm" data-filterWords-visible="Y" :data-filter1="carDiv.carDiv" data-filter1-visible="Y" :data-filter2="prdtInfo.isrTypeDiv" data-filter2-visible="Y" :data-filter3="prdtInfo.rntQlfctAge" data-filter3-visible="Y" :data-filter4="prdtInfo.rntQlfctCareer" data-filter3-visible="Y"  :class="['prdtView_' + carDiv.rcCardivNum, pStatusIndex > 2 ? 'hide' : '', 'listli']">
							<div class="link-area">
								<a :href="'javascript:fn_DetailPrdt(\'' + prdtInfo.prdtNum + '\')'">
									<div class="name"><p>{{ prdtInfo.corpNm }}</p>
										<div class="bxLabel">
											<span v-if="prdtInfo.eventCnt > 0" class="main_label eventblue">이벤트</span>
											<!-- 프로모션 종료 후 ~40%쿠폰에서 할인쿠폰으로 변경 -->
											<span v-if="prdtInfo.couponCnt == '1'" class="main_label pink">할인쿠폰</span>
											<span v-if="prdtInfo.tamnacardYn === 'Y'" class="main_label yellow">탐나는전</span>
											<span v-if="prdtInfo.superbCorpYn === 'Y'" class="main_label back-red">우수관광사업체</span>
										</div>
									</div>
									<div class="rent-option">
										<div class="since">{{ prdtInfo.modelYear }}</div>
										<div class="age">만{{prdtInfo.rntQlfctAge}}세이상</div>
									</div>
									<div v-if="prdtInfo.isrDiv !== 'ID10'" class="text">자차미포함</div>
									<template v-else>
										<div v-if="prdtInfo.isrTypeDiv === constants.RC_ISR_TYPE_GEN" class="text common">일반자차
										</div>
										<div v-else-if="prdtInfo.isrTypeDiv === constants.RC_ISR_TYPE_LUX" class="text advanced">고급자차
										</div>
										<div v-else-if="prdtInfo.isrTypeDiv === constants.RC_ISR_TYPE_ULM" class="text advanced">고급자차<div class="sub_text">(전액무제한)</div>
										</div>
									</template>
									<div class="price">
										<div>
											<span>{{ formatNumber(prdtInfo.saleAmt) }}</span>
											<span class="won">원</span>
										</div>
									</div>
								</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</template>
	    </section> <!-- //rent-list-area -->
 			<!--//mw-list-area-->
	<!--//change contents-->
	</div>
	</form>
</main>
<!-- 콘텐츠 e -->

<script type="text/javascript" src="/js/jquery-ui-mw.js?version=${nowDate}"></script>
<script type="text/javascript" src="/js/moment.min.js?version=${nowDate}"></script>
<script type="text/javascript" src="/js/daterangepicker-rc.js?version=${nowDate}"></script>
<script type="text/javascript" src="<c:url value='/js/jquerySetAttrVal.js?version=${nowDate}'/>"></script>
<script src="/js/vue.js?version=${nowDate}"></script>
<script src="/js/axios.min.js?version=${nowDate}"></script>
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

    //창 닫기
    function rc_close_popup(obj) {
        if (typeof obj == "undefined" || obj == "" || obj == null) {
            $('.dateRangePickMw').data('daterangepicker').hide();
        } else {
            $(obj).hide();
        }
        $('#dimmed').fadeOut(100);
        $("html, body").removeClass("not_scroll");
        $('.side-btn').show();
        $('.back').show();
    }
    /** 렌트카 검색 */
    function fn_RcSearch(pageIndex){

        var now = new Date(),
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

        var nowToday = nowYear + '-' + nowMon + '-' + nowDay;
        var nowTime = nowHours + nowMinutes;

        if($('#sFromDtView').val() == nowToday){
            if($("#sFromTm").val() < nowTime){
                alert("현재시간 이후부터 선택이 가능합니다.");
                return false;
            }
        }

        $("#pageIndex").val(pageIndex);
        $("#curPage").text(pageIndex);
        $("#orderCd").val("PRICE");

        var parameters = $("#frm").serialize();

        $('#carTypeStr').text($("label[for=" + $('input[name=sCarDivCd]:checked').attr('id') + "]").text());
        $("label[for=" + $('input[name=sIsrTypeDiv]:checked').attr('id') + "]").text();

        click_check(true);

        app.fetchData(parameters);
    }
    function fn_gotoSearch(){
        document.frm.action = "<c:url value='/mw/rentcar/mainList.do'/>";
        document.frm.submit();
    }

    function fn_DetailPrdt(prdtNum){
        $("#scroll").val($(window).scrollTop());
        ++prevIndex;
        history.replaceState($("#main").html(), "title 1", "?prevIndex="+ prevIndex);
        $("#prdtNum").val(prdtNum);
        document.frm.target = "_self";
        document.frm.action = "<c:url value='/mw/rentcar/car-detail.do'/>";
        document.frm.submit();
    }

    function click_check(val) {
        if(val) {
            $(".loadingRc-wrap").addClass("hide");
        } else {
            $(".loadingRc-wrap").removeClass("hide");
        }
    }

    function fn_rcPrdtView(obj) {
        var i = 0;
        if ($('.prdtView_' + obj + '.hide').length > 0) {
            $('.prdtView_' + obj).removeClass('hide');
            $('#viewTitle_' + obj).text("접기");
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

            $('#viewTitle_' + obj).text("더보기");
        }
    }

    function filterFunc(){
        $(".rent-group").each(function(index) {
            var filter = $(this);
            var filterYn = "N";
            var i = 0;
            $("li", this).each(function (index) {
                if($(this).attr("data-filter1-visible") == "Y" && $(this).attr("data-filter2-visible") == "Y" && $(this).attr("data-filter3-visible") == "Y" && $(this).attr("data-filter4-visible") == "Y"){
                    $(this).attr("data-filter-child","Y");
                    /** .rent-group li가 하나라도 조건에 맞는지 확인 */
                    filterYn = "Y";
                }else{
                    $(this).attr("data-filter-child","N")
                }

                if($(this).attr("data-filter-child") == "Y"){
                    ++i;
                    if(i == 1){
                        var clone = $(this).parents(".rent-group").find(".price").children().html();
                        $(this).parents(".rent-group").find(".top-info .price").html($(".price",this).text() + "<span class='memo'>"+ clone +"</span>");
                        $(this).parents(".rent-group").attr("data-top-price",$(this).attr("data-price"));
                    }
                    if(i<4){
                        $(this).removeClass("hide");
                    }else{
                       $(this).addClass("hide");
                    }

                }else{
                    $(this).addClass("hide");
                }
            });
            /** .rent-group의 li가 하나라도 조건맞으면 */
            if(filterYn == "Y"){
                filter.attr("data-filter","Y");
            }else{
                filter.attr("data-filter","N");
            }
            /** 더보기 개수 구하기*/
           if(i == 0){
                $(this).attr("data-filter-child","N")
            }else if(i < 4){
                $("strong",this).hide();
                $(this).attr("data-filter-child","Y")
            }
            else{
                $("strong",this).show();
                /*$(".bottom .text-red",this).text(i);*/
                $(this).attr("data-filter-child","Y")
            }
        });

        $("[data-filter=Y]").show();
        $("[data-filter=N]").hide();
        $("[data-filter-child=Y]").show();
        $("[data-filter-child=N]").hide();
        sort();
    }

    /** 차종필터*/
    function filter1(searchYn) {
		// Get the value of the checked radio button with the name 'sCarDivCd'
		const sCarDivCd = $('input[name="sCarDivCd"]:checked').val();
		const elements = $("[data-filter1]");
		const updates = [];

		// Iterate over all elements with the 'data-filter1' attribute
		elements.each(function() {
			const element = $(this);
			const filterValue = element.attr("data-filter1");
			let isVisible = "N";

			// Check if the 'data-filter1' attribute matches the selected value or if no radio button is selected
			if (sCarDivCd == filterValue || !sCarDivCd) {
				isVisible = "Y";
			}

			// Collect updates
			updates.push({ element, isVisible });
		});

		// Apply all updates at once
		updates.forEach(update => {
			update.element.attr("data-filter1-visible", update.isVisible);
		});

		// Call filterFunc if searchYn is not "Y"
		if (searchYn != "Y") {
			filterFunc();
		}
	}

    /** 보험필터*/
    function filter2(searchYn) {
		// Get the value of the checked radio button with the name 'sIsrTypeDiv'
		const sIsrTypeDiv = $('input[name="sIsrTypeDiv"]:checked').val();
		const elements = $("[data-filter2]");
		const updates = [];

		// Iterate over all elements with the 'data-filter2' attribute
		elements.each(function() {
			const element = $(this);
			const filterValue = element.attr("data-filter2");
			let isVisible = "N";

			// Check if the 'data-filter2' attribute matches the selected value or if no radio button is selected
			if (sIsrTypeDiv == filterValue || !sIsrTypeDiv) {
				isVisible = "Y";
			}

			// Collect updates
			updates.push({ element, isVisible });
		});

		// Apply all updates at once
		updates.forEach(update => {
			update.element.attr("data-filter2-visible", update.isVisible);
		});

		// Call filterFunc if searchYn is not "Y"
		if (searchYn != "Y") {
			filterFunc();
		}
	}

	function filter3(searchYn) {
		// Get the value of the checked radio button with the name 'sIsrTypeDiv'
		const sRntQlfctAge = "${searchVO.sRntQlfctAge}";
		const elements = $("[data-filter3]");
		const updates = [];

		// Iterate over all elements with the 'data-filter2' attribute
		elements.each(function() {
			const element = $(this);
			const filterValue = element.attr("data-filter3");
			let isVisible = "N";

			// Check if the 'data-filter2' attribute matches the selected value or if no radio button is selected
			if (sRntQlfctAge >= filterValue ) {
				isVisible = "Y";
			}

			// Collect updates
			updates.push({ element, isVisible });
		});

		// Apply all updates at once
		updates.forEach(update => {
			update.element.attr("data-filter3-visible", update.isVisible);
		});

		// Call filterFunc if searchYn is not "Y"
		if (searchYn != "Y") {
			filterFunc();
		}
	}

	function filter4(searchYn) {
		// Get the value of the checked radio button with the name 'sIsrTypeDiv'
		const sRntQlfctCareer = "${searchVO.sRntQlfctCareer}";
		const elements = $("[data-filter4]");
		const updates = [];

		// Iterate over all elements with the 'data-filter2' attribute
		elements.each(function() {
			const element = $(this);
			const filterValue = element.attr("data-filter4");
			let isVisible = "N";

			// Check if the 'data-filter2' attribute matches the selected value or if no radio button is selected
			if (sRntQlfctCareer >= filterValue ) {
				isVisible = "Y";
			}

			// Collect updates
			updates.push({ element, isVisible });
		});

		// Apply all updates at once
		updates.forEach(update => {
			update.element.attr("data-filter4-visible", update.isVisible);
		});

		// Call filterFunc if searchYn is not "Y"
		if (searchYn != "Y") {
			filterFunc();
		}
	}



    /** 사용연료*/
/*    function filter3(searchYn){
    	let sUseFuelDiv = $('input[name="sUseFuelDiv"]:checked').val()
        $("[data-filter3]").each(function() {
            if(sUseFuelDiv == $(this).attr("data-filter3")){
                $(this).attr("data-filter3-visible","Y")
            }else if(!sUseFuelDiv){
                $(this).attr("data-filter3-visible","Y")
            }else{
                $(this).attr("data-filter3-visible","N")
            }
        });
        if(searchYn != "Y"){
			filterFunc();
		}
    }*/

    function sort() {
		// Get the value of the checked radio button with the name 'sOrderCd'
		var param = $('input[name="sOrderCd"]:checked').val();

		// Sort the 'div.rent-group' elements
		var sort = $("div.rent-group").sort(function (a, b) {
			var contentA, contentB;

			if (param === "PRICE") {
				// Price sorting
				contentA = parseInt($(a).attr('data-top-price'));
				contentB = parseInt($(b).attr('data-top-price'));
				return contentA - contentB; // Ascending order
			} else if (param === "SALE") {
				// Sale sorting
				contentA = parseInt($(a).attr('data-top-seller'));
				contentB = parseInt($(b).attr('data-top-seller'));
				return contentB - contentA; // Descending order
			} else {
				// Car name sorting
				contentA = $(a).find(".title").text().toUpperCase();
				contentB = $(b).find(".title").text().toUpperCase();
				return contentA.localeCompare(contentB); // Alphabetical order
			}
		});

		// Update the content of #prdtList
		$("#prdtList").html(sort);

		// Prepare additional HTML content
		var addHtml = '<div class="loadingRc-wrap hide"><span class="loadingRc">검색날짜가 변경됐습니다.<br>검색 버튼을 클릭해주세요.</span></div>';

		if ($("[data-filter=Y]").length === 0) {
			addHtml += `
				<div class="item-noContent">
					<p class="icon"><img src="<c:url value='/images/mw/sub_common/warning.png'/>" alt="경고"></p>
					<p class="text">죄송합니다.<br><span class="comm-color1">해당상품</span>에 대한 검색결과가 없습니다.</p>
				</div>`;
		}

		// Append the additional HTML content
		$("#prdtList").append(addHtml);
	}

	var app;

    app = new Vue({
            el: '#prdtList',
            data: {
                carDivList: '',
				prdtMap: '',
				rcCodeMap:'',
				difTm:'',
				constants: {
				RC_ISR_TYPE_GEN: 'GENL',   // 상수 값 업데이트
				RC_ISR_TYPE_LUX: 'LUXY',  // 상수 값 업데이트
				RC_ISR_TYPE_ULM: 'ULIM',  // 상수 값 업데이트
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
				fn_DetailPrdtLowCost(a) {
					fn_DetailPrdtLowCost(a);
				},
                fetchData(parameters) {
					 $(".modal-spinner").show();
                    axios.post('/mw/rc/rcList.ajax',parameters) // JSP에서 데이터를 받아옴
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
							console.log("update");

							$(".modal-spinner").hide();

							$("#totPage").text($("input[name=totalPageCnt]").val());

							if (pageIndex == $("input[name=totalPageCnt]").val() || $("input[name=totalCnt]").val() == 0)
								$('#moreBtn').hide();
							else
								$('#moreBtn').show();

							filter1("Y");
							filter2("Y");
							filter3("Y");
							filter4("Y");
							filterFunc();

							++prevIndex;
							//history.replaceState($("main").html(), "title"+ i, "?prevIndex="+ prevIndex);
							history.replaceState($("#main").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
							currentState = history.state;
					});
                },
				onSecondFetch() {
					let parameters = $("#frm").serialize();
					this.fetchData(parameters);
			  },
            }
        });
    $(document).ready(function(){
    	var currentState = history.state;
        if(currentState){
            $("#main").html(currentState);
            $(window).scrollTop($("#scroll").val());
        }else{
            fn_RcSearch(1);
        }

        /**dateRangePickMw 생성**/
        $('.dateRangePickMw').daterangepicker({}, function(start, end) {
            /*데이트피커*/
            $("#sFromDtView").val(start.format('YYYY. MM. DD')+ "(" + getDate(start.format('YYYY-MM-DD')) + ")");
            $("#sToDtView").val(end.format('YYYY. MM. DD')+ "(" + getDate(end.format('YYYY-MM-DD')) + ")");

            /*DB*/
            $("#sFromDt").val(start.format('YYYYMMDD'));
            $("#sToDt").val(end.format('YYYYMMDD'));

            click_check(false);
        });

        if(!"${searchVO.orderCd}"){
            $("#sOrderCd1").prop("checked", true);
        }

        $("select").change(function () {
            var selThis = $(this);
            var selIdx = $("option", this).index($("option:selected", this));
            $("> option", this).each(function () {
                if ($(this).index() == selIdx) {
                    $("option:eq(" + $(this).index() + ")", selThis).attr("selected", true)
                } else {
                    $("option:eq(" + $(this).index() + ")", selThis).attr("selected", false)
                }
            });
        });

        $("input:radio").change(function () {
            var selThis = $(this);
            $("input[name=" + $(this).attr("name") + "]").attr("checked", false);
            selThis.attr("checked", true);
            selThis.prop("checked", true);
        });

        $("input:checkbox").change(function () {
            if ($(this).prop("checked")) {
                $(this).attr("checked", true);
            } else {
                $(this).attr("checked", false);
            }
        });

        $('.dateRangePickMw').on('show.daterangepicker', function(ev, picker) {
            $("#main").hide();
            $("#foot").hide();
        });

        $('.dateRangePickMw').on('hide.daterangepicker', function(ev, picker) {
            $("#main").show();
            $("#foot").show();
        });

        /** 차종선택 */
        $('input[name=sCarDivCd]').click(function () {
            $('#sCarDivCd').val($(this).val());
            $('#sCarDivCd').attr("value",$(this).val());
        });

        /** 보험구분 선택시 */
        $('input[name=sIsrTypeDiv]').click(function () {
            $('#sIsrTypeDiv').val($(this).val())
            $('#sIsrTypeDiv').attr("value",$(this).val());
        });

        /** 정렬 선택시 */
        $('input[name=sOrderCd]').click(function () {
            sort();
            // optionClose($("#rent_sort"));
        });

        /** 자동완성 */
        $( "#sPrdtNm").bind( "keydown", function( event ) {
            if(event.keyCode==13){
                fn_RcSearch(1);
            }
        }).autocomplete({
            source: function(request, response){
                $.ajax({
                    url: "/mw/selectCarNmList.ajax",
                    dataType: "json",
                    data: {sPrdtNm : $( "#sPrdtNm").val() },
                    success:function(json){
                        //        alert(json);

                        response($.map(json.data,function(data){
                            //            alert(data);
                            return{
                                label:data.prdtNm,
                                value:data.prdtNm
                            };
                        }));
                    },
                    error:function(json){
                        /*alert("err"+json);*/
                    }
                });
            },
            select: function(event, ui) {

            },
            focus: function(event, ui) {
                return false;
                //event.preventDefault();
            },
            appendTo : ".car-name"

        });

        $('input[name=sIconCd]').click(function() {
            var iconCdLen = $('input[name=sIconCd]:checked').length;
            $("#sIconCdCnt").val(iconCdLen);
        });

        // 차종 전체 layer open
        $(".mw-rent-insurance").on("click", function(e){
            optionPopup('#rent_zone', this);
            $('#dimmed').show();
            $("html, body").addClass("not_scroll");
            $('.side-btn').hide();
            $('.back').hide();
            $("#header").removeClass("nonClick");
        });

        $(".dateRangePickMw").on("click", function(e){
            $('#dimmed').show();
            $("html, body").addClass("not_scroll");
            $('.side-btn').hide();
            $('.back').hide();
        });

        // 보험 전체 layer open
        $("#sIsrTypeDivStr").on("click", function(e){
            optionPopup('#rent_zone2', this);
            $('#dimmed').show();
            $("html, body").addClass("not_scroll");
            $('.side-btn').hide();
            $('.back').hide();
            $("#header").removeClass("nonClick");
        });

		// filter click
		$(".rent-f-btn").on("click", function(e){
			optionPopup('#rent_option', this);
			$('#dimmed').show();
			$("html, body").addClass("not_scroll");
			$('.side-btn').hide();
			$('.back').hide();
			$("#header").removeClass("nonClick");
		});

		// 정렬 click
		$(".sort-f-btn").on("click", function(e){
			optionPopup('#rent_sort', this);
			$('#dimmed').show();
			$("html, body").addClass("not_scroll");
			$('.side-btn').hide();
			$('.back').hide();
			$("#header").removeClass("nonClick");
		});
	});
    $(document).on("click", ".nonClick", function () {
        $('.dateRangePickMw').data('daterangepicker').show();
    });

    /** 적용버튼 클릭 시 */
    function fn_ClickSearch(xType){
        //pop 비활성
        $(xType).css("display","none");
        $('.dateRangePickMw').data('daterangepicker').hide();
        $('#dimmed').fadeOut(100);
        $("html, body").removeClass("not_scroll");
        $('.side-btn').show();
        $('.back').show();

        // 차종 pop에서 적용 클릭 시
        if (xType == "#rent_zone"){
            $('#carDivStr').text($("label[for=" + $('input[name=sCarDivCd]:checked').attr('id') +"]").text());
            $('#carDivStr').append('<img src="../../images/mw/rent/rent-btn.png" alt="차종선택">');
            filter1();
        }

        //보험 pop에서 적용 클릭 시
        if (xType == "#rent_zone2") {
            $('#sIsrTypeDivStr').text($("label[for=" + $('input[name=sIsrTypeDiv]:checked').attr('id') + "]").text());
            $('#sIsrTypeDivStr').append('<img src="../../images/mw/rent/rent-btn.png" alt="차종선택">');
            filter2();
        }
    }
	/** 렌터카 바로가기*/
    function fn_GoRc(){
    	document.frm.target = "_self";
        document.frm.action = "<c:url value='/mw/rentcar/car-list.do'/>";
        document.frm.submit();
    }
</script>

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 푸터 e -->
</div>
<div id="dimmed"></div>
</body>
</html>
