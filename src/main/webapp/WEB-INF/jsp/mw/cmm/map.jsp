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
<jsp:include page="/mw/includeJs.do" flush="false"></jsp:include>

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/daterangepicker.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/ad.css?version=${nowDate}' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}' />">
</head>
<body>
<div id="wrap">
	<header id="header">
		<div class="head-wrap">
			<h2 class="title">지도검색</h2>
			<div class="l-area">
				<a href="/mw/ad/productList.do" class="back" title="뒤로가기"></a>
			</div>
		</div>
	</header>
	<!-- change contents -->
	<main id="main" class="map-wrap">
		<form name="frm" id="frm" method="post">
			<input type="hidden" name="sSearchYn" id="sSearchYn" value="${Constant.FLAG_Y}" />
			<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
			<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
			<input type="hidden" name="sNights" id="sNights" value="${searchVO.sNights}">
			<input type="hidden" name="sMen" id="sMen" value="${searchVO.sMen}">
		<section class="map-filter">
			<!-- 날짜 선택(입실일/퇴실일) -->
			<div id="dateRangePickMw" class="hotel-area">
				<a id="searchAreaD" class="area take-over">
					<dl>
						<dt>입실일</dt>
						<dd>
							<div class="value-text">
								<div class="date-container">
									<div class="dateRangePickMw">
										<input placeholder="입실일" onfocus="this.blur()" id="sFromDtView" name="sFromDtView" value="${searchVO.sFromDtView}">
									</div>
								</div>
							</div>
						</dd>
					</dl>
					<div class="align-self-center"></div>
					<dl>
						<dt>퇴실일</dt>
						<dd>
							<div class="value-text">
								<div class="date-container">
									<div class="dateRangePickMw">
										<input placeholder="퇴실일" onfocus="this.blur()" id="sToDtView" name="sToDtView" value="${searchVO.sToDtView}">
									</div>
								</div>
							</div>
						</dd>
					</dl>
					<div class="align-self-center"></div>
				</a>
			</div><!-- //날짜 선택(입실일/퇴실일) -->

			<!-- 인원선택 -->
			<div class="map-count">
				<div id="room_person_str">
					<dl>
						<dt>인 원</dt>
						<dd class="guests_count">
							<div class="personnel">
								<span>성인</span>
								<span class="count" id="txtAdultCnt">${searchVO.sAdultCnt}</span>
							</div>
							<div class="personnel">
								<span>소아</span>
								<span class="count" id="txtChildCnt">${searchVO.sChildCnt}</span>
							</div>
							<div class="personnel">
								<span>유아</span>
								<span class="count" id="txtBabyCnt">${searchVO.sBabyCnt}</span>
							</div>
						</dd>
					</dl>
				</div>
			</div><!-- //인원선택 -->

			<!-- 인원선택 / layer-popup -->
			<div id="hotel_count" class="popup-typeA hotel-count">
				<div class="hotel-wrapper">
					<a class="close-btn" onclick="ad_close_popup('#hotel_count')"></a>
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
									<input type="hidden" name="sAdultCnt" value="${searchVO.sAdultCnt}">
									<button type="button" class="counting-btn" onclick="chg_person('-', 'Adult')"><img src="/images/mw/hotel/minus.png" alt="빼기"></button>
									<span class="counting-text" id="AdultNum">${searchVO.sAdultCnt}</span>
									<button type="button" class="counting-btn" onclick="chg_person('+', 'Adult')"><img src="/images/mw/hotel/plus.png" alt="더하기"></button>
								</div>
							</div>
							<div class="counting">
								<div class="l-area">
									<strong class="sub-title">소아</strong>
									<span class="memo">만 2 ~ 13세 미만</span>
								</div>
								<div class="r-area">
									<button type="button" class="counting-btn" onclick="chg_person('-', 'Child')"><img src="/images/mw/hotel/minus.png" alt="빼기"></button>
									<span class="counting-text" id="ChildNum">${searchVO.sChildCnt}</span>
									<button type="button" class="counting-btn" onclick="chg_person('+', 'Child')"><img src="/images/mw/hotel/plus.png" alt="더하기"></button>
								</div>
							</div>
							<input type="hidden" name="sChildCnt" value="${searchVO.sChildCnt}">
							<div class="counting">
								<div class="l-area">
									<strong class="sub-title">유아</strong>
									<span class="memo">만 2세(24개월) 미만</span>
								</div>
								<div class="r-area">
									<button type="button" class="counting-btn" onclick="chg_person('-', 'Baby')"><img src="/images/mw/hotel/minus.png" alt="빼기"></button>
									<span class="counting-text" id="BabyNum">${searchVO.sBabyCnt}</span>
									<button type="button" class="counting-btn" onclick="chg_person('+', 'Baby')"><img src="/images/mw/hotel/plus.png" alt="더하기"></button>
								</div>
							</div>
							<input type="hidden" name="sBabyCnt"  value="${searchVO.sBabyCnt}">
						</div>
						<div class="detail-area info-area">
							<ul class="list-disc sm">
								<li>* 업체별로 연령 기준은 다를 수 있습니다.</li>
							</ul>
						</div>
						<div class="fix-cta">
							<!-- 적용/다음 CTA 수정 -->
<%--							onclick="fn_CntSearch();"--%>
							<button href="#" class="result-btn decide comm-btn" >적용</button>
						</div>
					</div>
				</div>
			</div><!-- //인원선택 / layer-popup -->
		</section>
		</form>

		<!-- 유형별 숙소 선택 -->
		<section class="map-check">
			<ul class="map-check-inner">
				<li>
					<button class="cate" data-tab="HO">
						<svg class="ico1 " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 25.02 32.38">
							<g class="category-svg">
								<path d="M24,0H1A1,1,0,0,0,0,1V31.38a1,1,0,0,0,1,1H9.46a1,1,0,0,0,1-1v-7.3h4.1v7.3a1,1,0,0,0,1,1H24a1,1,0,0,0,1-1V1A1,1,0,0,0,24,0ZM23,30.38H16.56v-7.3a1,1,0,0,0-1-1H9.46a1,1,0,0,0-1,1v7.3H2V2H23Z"/>
								<polygon points="7.72 5.62 5.03 5.62 5.03 6.62 5.03 7.62 7.72 7.62 7.72 5.62"/>
								<polygon points="13.86 5.62 11.16 5.62 11.16 6.62 11.16 7.62 13.86 7.62 13.86 5.62"/>
								<polygon points="19.99 5.62 17.3 5.62 17.3 6.62 17.3 7.62 19.99 7.62 19.99 5.62"/>
								<polygon points="7.72 10.18 5.03 10.18 5.03 11.18 5.03 12.18 7.72 12.18 7.72 10.18"/>
								<polygon points="13.86 10.18 11.16 10.18 11.16 11.18 11.16 12.18 13.86 12.18 13.86 10.18"/>
								<polygon points="19.99 10.18 17.3 10.18 17.3 11.18 17.3 12.18 19.99 12.18 19.99 10.18"/>
								<polygon points="7.72 14.74 5.03 14.74 5.03 15.74 5.03 16.74 7.72 16.74 7.72 14.74"/>
								<polygon points="13.86 14.74 11.16 14.74 11.16 15.74 11.16 16.74 13.86 16.74 13.86 14.74"/>
								<polygon points="19.99 14.74 17.3 14.74 17.3 15.74 17.3 16.74 19.99 16.74 19.99 14.74"/>
							</g>
						</svg>
						호텔
					</button>
				</li>
				<li>
					<button class="cate" data-tab="PE">
						<svg class="ico2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 28.28 26.15">
							<g class="category-svg">
								<path d="M23.72,26.15H4.56a.7.7,0,0,1-.7-.7V12H.7a.7.7,0,0,1-.43-1.25L13.71.15a.69.69,0,0,1,.86,0L28,10.73a.71.71,0,0,1,.23.78.69.69,0,0,1-.66.47H24.42V25.45A.7.7,0,0,1,23.72,26.15ZM5.26,24.75H23V11.28a.71.71,0,0,1,.7-.7h1.84l-11.42-9-11.42,9H4.56a.71.71,0,0,1,.7.7Z"/>
								<path d="M5.39,8.29a.7.7,0,0,1-.7-.7V1.72a.7.7,0,0,1,1.4,0V7.59A.7.7,0,0,1,5.39,8.29Z"/>
								<path d="M16.65,26.15h-5a.7.7,0,0,1-.7-.7V16.54a.7.7,0,0,1,.7-.7h5a.7.7,0,0,1,.7.7v8.91A.7.7,0,0,1,16.65,26.15Zm-4.32-1.4H16V17.24H12.33Z"/>
							</g>
						</svg>
						펜션
					</button>
				</li>
				<li>
					<button class="cate" data-tab="CO">
						<svg class="ico3" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 61.89 53.76">
							<g data-name="레이어 2"  class="category-svg">
								<path d="M42.78,42a9.71,9.71,0,0,1-6.87-2.84,7,7,0,0,0-9.93,0,9.75,9.75,0,0,1-13.75,0,7,7,0,0,0-9.93,0A1.35,1.35,0,0,1,.4,37.24a9.71,9.71,0,0,1,13.74,0,7,7,0,0,0,9.93,0,9.74,9.74,0,0,1,13.75,0,7,7,0,0,0,9.93,0,9.72,9.72,0,0,1,13.75,0,1.35,1.35,0,0,1-1.91,1.91,7,7,0,0,0-9.93,0A9.73,9.73,0,0,1,42.78,42Z"/>
								<path d="M42.78,53.76a9.71,9.71,0,0,1-6.87-2.84,7,7,0,0,0-9.93,0,9.74,9.74,0,0,1-13.75,0,7,7,0,0,0-9.93,0A1.35,1.35,0,1,1,.4,49a9.71,9.71,0,0,1,13.74,0,7,7,0,0,0,9.93,0,9.74,9.74,0,0,1,13.75,0,7,7,0,0,0,9.93,0A9.72,9.72,0,0,1,61.5,49a1.36,1.36,0,0,1,0,1.91,1.35,1.35,0,0,1-1.91,0,7,7,0,0,0-9.93,0A9.73,9.73,0,0,1,42.78,53.76Z"/>
								<path d="M35.52,31.63a1.35,1.35,0,0,1-1.35-1.35V4.82a2.12,2.12,0,1,0-4.23,0V8.28a1.35,1.35,0,0,1-2.7,0V4.82a4.82,4.82,0,1,1,9.63,0V30.28A1.34,1.34,0,0,1,35.52,31.63Z"/>
								<path d="M52.4,31.63a1.34,1.34,0,0,1-1.35-1.35V4.82a2.12,2.12,0,1,0-4.23,0V8.28a1.35,1.35,0,1,1-2.7,0V4.82a4.82,4.82,0,1,1,9.63,0V30.28A1.35,1.35,0,0,1,52.4,31.63Z"/>
								<path d="M52.4,17.17H35.52a1.35,1.35,0,0,1,0-2.7H52.4a1.35,1.35,0,1,1,0,2.7Z"/>
								<path d="M52.4,25.06H35.52a1.35,1.35,0,0,1,0-2.7H52.4a1.35,1.35,0,0,1,0,2.7Z"/>
							</g>
						</svg>
						리조트/풀빌라/콘도
					</button>
				</li>
				<li>
					<button class="cate" data-tab="GE">
						<svg class="ico4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36.26 25.87">
							<g class="category-svg">
								<path d="M26.06,1.5a4.3,4.3,0,1,1,0,8.59,4.25,4.25,0,0,1-2.43-.76A5.7,5.7,0,0,1,23,10.69a5.8,5.8,0,1,0-1.75-8.06,5.75,5.75,0,0,1,1.17,1A4.27,4.27,0,0,1,26.06,1.5Z"/>
								<path d="M32.14,11.23a.75.75,0,0,0-1,0,7.35,7.35,0,0,1-5,2A7.79,7.79,0,0,1,24.22,13l.19.21a12,12,0,0,1,1.21,1.5,9,9,0,0,0,5.93-1.88,14.37,14.37,0,0,1,3.21,9.36c0,.17,0,.32,0,.48H28.27c0,.25,0,.49.05.73s0,.34,0,.52,0,.17,0,.25h7.15a.77.77,0,0,0,.75-.74c0-.41,0-.81,0-1.24A15.37,15.37,0,0,0,32.14,11.23Z"/>
								<path d="M10.19,11.59a5.71,5.71,0,0,0,3.09-.9,6.08,6.08,0,0,1-.65-1.36,4.3,4.3,0,1,1,1.24-5.72,5.49,5.49,0,0,1,1.17-1,5.79,5.79,0,1,0-4.85,9Z"/>
								<path d="M7.94,23.35c0-.24,0-.47,0-.71H1.51c0-.15,0-.31,0-.48A14.38,14.38,0,0,1,4.7,12.8a8.74,8.74,0,0,0,6,1.88,11.87,11.87,0,0,1,1.25-1.56l.15-.16h0a7.48,7.48,0,0,1-6.89-1.74.75.75,0,0,0-1,0A15.33,15.33,0,0,0,0,22.16c0,.44,0,.86,0,1.29a.75.75,0,0,0,.75.69H7.94c0-.08,0-.16,0-.25S7.93,23.53,7.94,23.35Z"/>
								<path d="M13.17,13l0,0c.18.15.36.3.55.44C13.51,13.3,13.34,13.16,13.17,13Z"/>
								<path d="M12.33,7.52a5.72,5.72,0,0,0,.3,1.81,6.08,6.08,0,0,0,.65,1.36,5.78,5.78,0,0,0,9.69,0,5.79,5.79,0,0,0-4.84-9,5.73,5.73,0,0,0-3.09.9,5.49,5.49,0,0,0-1.17,1A5.75,5.75,0,0,0,12.33,7.52Zm5.8-4.29a4.3,4.3,0,1,1-4.3,4.29A4.29,4.29,0,0,1,18.13,3.23Z"/>
								<path d="M28.32,23.37c0-.24,0-.48-.05-.73a16,16,0,0,0-2.65-8,12,12,0,0,0-1.21-1.5L24.22,13h0a.72.72,0,0,0-1.05,0l-.07.06a7.48,7.48,0,0,1-4.85,1.92h-.31a7.25,7.25,0,0,1-4.24-1.49c-.19-.14-.37-.29-.55-.44l0,0a.75.75,0,0,0-1.06,0h0l-.15.16a11.87,11.87,0,0,0-1.25,1.56,15.93,15.93,0,0,0-2.66,8c0,.24,0,.47,0,.71s0,.36,0,.54,0,.17,0,.25q0,.51,0,1a.75.75,0,0,0,.75.71H27.53a.75.75,0,0,0,.75-.69c0-.35,0-.69,0-1,0-.08,0-.16,0-.25S28.33,23.54,28.32,23.37Zm-1.5,1H9.44c0-.16,0-.32,0-.48s0-.3,0-.48a14.07,14.07,0,0,1,3.21-8.88,8.64,8.64,0,0,0,5.15,1.88,1.8,1.8,0,0,0,.57,0,8.75,8.75,0,0,0,5.24-1.89,14.13,14.13,0,0,1,3.21,8.91c0,.15,0,.3,0,.45S26.83,24.21,26.82,24.37Z"/>
							</g>
						</svg>
						게스트하우스
					</button>
				</li>
				<li>
					<button class="cate" data-tab="AL">
						<svg class="ico5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 23.22 26.91">
							<g class="category-svg">
								<path d="M18.7,26.91H10.43a.6.6,0,0,1-.6-.6v-4.4H8.05v4.4a.6.6,0,0,1-.6.6H4.52a.6.6,0,0,1-.6-.6V12.2H.6a.58.58,0,0,1-.55-.37.57.57,0,0,1,.13-.65l11-11a.6.6,0,0,1,.84,0l11,11a.6.6,0,0,1-.42,1H19.3V26.31A.6.6,0,0,1,18.7,26.91ZM11,25.71H18.1V11.6a.6.6,0,0,1,.6-.6h2.47L11.61,1.44,2.05,11H4.52a.6.6,0,0,1,.6.6V25.71H6.85v-4.4a.6.6,0,0,1,.6-.6h3a.6.6,0,0,1,.6.6Z"/>
								<path d="M14.92,24.57H12.74a.6.6,0,0,1-.6-.6V21.31a.6.6,0,0,1,.6-.6h2.18a.6.6,0,0,1,.6.6V24A.6.6,0,0,1,14.92,24.57Zm-1.58-1.2h1V21.91h-1Zm1.58-7.14H12.74a.6.6,0,0,1-.6-.6V13a.6.6,0,0,1,.6-.6h2.18a.6.6,0,0,1,.6.6v2.66A.6.6,0,0,1,14.92,16.23ZM13.34,15h1V13.57h-1Zm-2.86,1.2H8.3a.6.6,0,0,1-.6-.6V13a.6.6,0,0,1,.6-.6h2.18a.6.6,0,0,1,.6.6v2.66A.6.6,0,0,1,10.48,16.23ZM8.9,15h1V13.57h-1Z"/>
							</g>
						</svg>
						독채/단독이용
					</button>
				</li>
			</ul>
		</section><!-- //유형별 숙소 선택 -->

		<!-- 객실 상세 내용 -->
		<section class="hotel-list-area" id="hotel_detail"></section> <!-- //객실 상세 내용 -->

		<!-- 지도---mw-map-area -->
		<div class="mw-map-area">
			<section class="map-view-area">
				<h2 class="sec-caption">숙박 지도</h2>
				<div id="map">
<%--					<img class="test-map" src="../../../images/mw/other/map_service.jpg" alt="임시맵">--%>
				</div> <!-- //map -->
			</section> <!-- //map-view-area -->
		</div> <!-- // 지도---mw-map-area -->
	</main>	<!--//change contents-->
</div>
<div id="dimmedB"></div>

<script src="/js/moment.min.js"></script>
<script src="/js/daterangepicker-ad.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>
<script type="text/javascript">
	const container = document.getElementById("map");
	const options = {
		center: new daum.maps.LatLng(33.36571286933408, 126.56998311968185),
		level : 9
	};
	const map = new daum.maps.Map(container, options);
	<c:forEach items="${adList}" var="ad" varStatus="status">
		if ('${ad.saleAmt}'){
			var content = ' <div class="MarkerIcon-content" id="${ad.corpId}" data-filter="${ad.adDiv}" data-filter-visible="Y">' +
							'<div class="MarkerIcon-wrap"> ' +
								'<button class="MarkerIcon-btn" onclick="javascript:goPrdtList(\'${Constant.ACCOMMODATION}\', \'${ad.corpId}\');">' +
								'<div class="IconBtn"> ' +
									'<div class="IconInner">' +
										'<span>₩<fmt:formatNumber><c:out value="${ad.saleAmt}" /></fmt:formatNumber></span> ' +
									'</div>' +
								'</div>' +
								'</button>' +
								'</div>' +
							'</div>';

			// 커스텀 오버레이가 표시될 위치입니다
			var position = new kakao.maps.LatLng(${ad.lat}, ${ad.lon});

			// 커스텀 오버레이를 생성합니다
			var customOverlay = new kakao.maps.CustomOverlay({
				position: position,
				content : content
			});

			// 커스텀 오버레이를 지도에 표시합니다
			customOverlay.setMap(map);
			map.relayout();

		}
	</c:forEach>

	kakao.maps.event.addListener(map, 'zoom_changed', function() {
		fn_MapMarking();
	});

	kakao.maps.event.addListener(map, 'dragend', function() {
		fn_MapMarking();
	});
</script>
<script type="text/javascript">
	// 인원수 변경 이벤트
	function chg_person(type, gubun) {
		var num = 0;
		if (type == '+') {
			num = eval($('#' + gubun + 'Num').text()) + 1;
		} else {
			num = eval($('#' + gubun + 'Num').text()) - 1;
		}

		// 최저 인원 수 - 성인 : 1, 소아&유아 : 0
		if (gubun == 'Adult') {
			if (num < 1) num = 1;
			else if (num > 30) num = 30;
		} else {
			if (num < 0) num = 0;
			else if (num > 30) num = 30;
		}

		$('#' + gubun + 'Num').text(num);
		$('input[name=s' + gubun + 'Cnt]').val(num);

		var sMen = eval($('#AdultNum').text()) + eval($('#ChildNum').text()) + eval($('#BabyNum').text());
		$('#sMen').val(sMen);
	}

	//창 닫기
	function ad_close_popup(obj) {
		if (typeof obj == "undefined" || obj == "" || obj == null) {
			$('#dateRangePickMw').data('daterangepicker').hide();
		} else {
			$(obj).hide();
		}
		$('#dimmedB').fadeOut(100);
		$("html, body").removeClass("not_scroll");
	}

	$(document).ready(function () {
		// scroll 방지
		$(".mw-map-area").addClass("not_scroll");

		//유형별 숙소 선택
		$('ul.map-check-inner button').click(function () {
			$(this).toggleClass('active');
			fn_MapMarking();
		})

		//daterangepicker open
		$('#dateRangePickMw').daterangepicker({}, function (start, end, search) {
			//입실/퇴실일 설정
			const sFromDt = start.format('YYYY-MM-DD');
			const sToDt = end.format('YYYY-MM-DD');
			$("#sFromDt").val(sFromDt.replace(/-/gi, ""));
			$("#sToDt").val(sToDt.replace(/-/gi, ""));
			$("#sFromDtView").val(sFromDt+ "(" + getDate(sFromDt) + ")");
			$("#sToDtView").val(sToDt+ "(" + getDate(sToDt) + ")");
			$("#sNights").val(getDayDiff(start,end));
			//검색 실행
			$("#frm").serialize();
			$("#frm").attr("action","/mw/map.do").submit();
		});

		//dimmedB 처리
		$("#searchAreaD").on("click", function(e){
			optionPopup('.daterangepicker', this);
			$('#dimmedB').show();
			$("html, body").addClass("not_scroll");
		});

		$("#room_person_str").on("click", function(e){
			optionPopup('#hotel_count', this);
			$('#dimmedB').show();
			$("html, body").addClass("not_scroll");
		});

		// daterangepicker 뒤로가기버튼 처리
		$(".decideBtn").click(function (){
			ad_close_popup("");
		});

		// daterangepicker 이전버튼 close
		$(".date_before").click(function (){
			ad_close_popup("");
		});

		// dimmed click lock 처리
		$("#dateRangePickMw").click(function (){
			$("#header").addClass("nonClick");
		});
	});

	$(document).on("click", ".nonClick", function () {
		$('#dateRangePickMw').data('daterangepicker').show();
	});

	function goPrdtList(corpCd, corpId) {
		$('#hotel_detail').show();
		$('.IconInner').attr('class','IconInner');
		$('#'+corpId).find('.IconInner').addClass('active');
		$.ajax({
			type:"post",
			url:"<c:url value='/mw/mapPrdtList.ajax'/>",
			data:$("#frm").serialize() + "&sCorpId=" + corpId,
			success:function(data){
				$("#hotel_detail").html(data);
			},
			error:function(request,status,error){
				//    alert("code:"+request.status+"\n"+"\n"+"error:"+error);
			}
		});
	}

	function fn_MapMarking(){
		$("[data-filter]").each(function() {
			let compVal = $(this).attr("data-filter");
			let compElement = $(this);
			compElement.attr("data-filter-visible","N");

			if($("button.cate").hasClass("active")){
				$("button.cate").each(function() {
					if ( $(this).hasClass("active") ){
						if($(this).data('tab') == compVal){
							compElement.attr("data-filter-visible","Y");
						}
					}
				})
			} else{
				compElement.attr("data-filter-visible","Y");
			}
		});

		$(".MarkerIcon-content").each(function() {
			if($(this).attr("data-filter-visible") == "Y"){
				$(this).show();
			}else{
				$(this).hide();
			}
		});
	}

	function fn_ClickSearch(){
		return null;
	}

	//sNights (박수) 구하기
	const getDayDiff = (d1, d2) => {
		const date1 = new Date(d1);
		const date2 = new Date(d2);
		const diffDate = date1.getTime() - date2.getTime();
		return Math.floor(Math.abs(diffDate / (3600 * 1000 * 24)));
	}
</script>
</body>
</html>