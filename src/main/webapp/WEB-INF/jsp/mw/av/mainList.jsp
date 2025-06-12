<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="제주항공권 : 제주도항공권 예약은 탐나오"/>
	<jsp:param name="description" value="제주 및 국내선항공권 예약을 발권수수료 없이 이용할 수 있습니다. 비행기표 예약은 제주도가 지원하고 제주관광협회가 운영하는 탐나오"/>
	<jsp:param name="keywords" value="제주항공편,제주도항공편,제주항공예약,실시간항공,제주비행기표,제주항공항공편"/>
</jsp:include>
<meta property="og:title" content="제주항공권 : 제주도항공권 예약은 탐나오">
<meta property="og:url" content="https://www.tamnao.com/mw/av/mainList.do">
<meta property="og:description" content="제주 및 국내선항공권 예약을 발권수수료 없이 이용할 수 있습니다. 비행기표 예약은 제주도가 지원하고 제주관광협회가 운영하는 탐나오">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">
   
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mw/common.css?version=${nowDate}">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mw/av.css?version=${nowDate}">
<link rel="canonical" href="https://www.tamnao.com/web/av/mainList.do">
</head>
<body class="main">
<div id="air-sub" class="m_wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" >
		<jsp:param name="headTitle" value="항공"/>
	</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<main id="main">
	<!--//change contents-->
	<form name="air_search_form" action="${pageContext.request.contextPath}/mw/av/productList.do" method="get" onsubmit="return check_air_seach_form();">
		<input type="hidden" name="page_type" value="main">
		<input type="hidden" name="start_date" value="${searchVO.start_date}">
		<input type="hidden" name="end_date" value="${searchVO.end_date}">
		<div class="mw-search-area">
			<div class="check-area">
				<input type="hidden" name="trip_type" value="RT">
				<button type="button" id="air_typeRT" value="RT" onclick="airtype_click(this.value);" class="active">왕복</button>
				<button type="button" id="air_typeOW" value="OW" onclick="airtype_click(this.value);">편도</button>
			</div>

			<div class="search-area air">
				<div id="avSearchArea" class="area zone">
					<dl class="clickable">
						<dt class="hide">출발지</dt>
						<dd>
							<div class="value-text">
								<a class="active" id="start_region_str">
									<p class="code"><span>GMP</span>김포</p>
								</a>
							</div>
							<div id="air_departure" class="popup-typeA air-zone">
								<div class="air-wrapper">
									<div class="condition_title">
										<h3 class="title">출발지와 도착지를<br>선택해주세요.</h3>
										<span class="close-btn" onclick="air_close_popup('#air_departure')"></span>
									</div>
									<div class="content-area">
										<div class="air-zone-list">
											<div class="list-group">
												<h4 class="sub-title">출발지</h4>
												<ul class="select-menu col3">
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
											</div>
											<div class="list-group">
												<h4 class="sub-title">도착지</h4>
												<ul class="select-menu col3">
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
											</div>
										</div>
									</div>

							<%--		<div class="fix-cta">
										<a href="#" class="result-btn decide" id="decide_cta">적용</a>
										<a href="#" class="result-btn apply" id="apply_time">다음</a>
									</div>--%>
								</div>
							</div>
						</dd>
					</dl>
                    <div class="path_line"></div>
					<a class="change" id="landing-change">
						<img class="airplane" src="/images/mw/air/airplane.png" alt="출발지 도착지 변경">
                        <img class="path_change" src="/images/mw/air/path_change.png" alt="출발지 도착지 변경">
                    </a>
                    <div class="path_line"></div>
					<dl class="clickable">
						<dt class="hide">도착지</dt>
						<dd>
							<div class="value-text">
								<!-- <a href="javascript:void(0)" onclick="optionPopup('#air_departure', this)" id="end_region_str"> -->
								<a id="end_region_str">
									<p class="code"><span>CJU</span>제주</p>
								</a>
							</div>
						</dd>
					</dl>
				</div>
				<div class="area date">
					<dl id="start_date_tool">
						<dt>가는날</dt>
						<dd>
							<div class="value-text">
								<div class="date-container">
									<span class="date-wrap">
										<input class="datepicker" type="text" name="start_date_view" value="${searchVO.start_date}" placeholder="가는날 선택" onfocus="this.blur()">
									</span>
								</div>
							</div>
						</dd>
					</dl>
			<%--		<a id="end_date_guide" class="calendar"><img src="/images/mw/common/calendar.png" alt="변경"></a>--%>
					<!-- 편도선택 시 삭제(가는날 dl에 single 클래스 추가) -->
					<dl id="end_date_tool">
						<dt>오는날</dt>
						<dd>
							<div class="value-text">
								<div class="date-container">
									<span class="date-wrap">
										<input class="datepicker" type="text" name="end_date_view" value="${searchVO.end_date}" placeholder="오는날 선택" onfocus="this.blur()">
									</span>
								</div>
							</div>
						</dd>
					</dl>
					<!-- //편도선택 시 삭제 -->
				</div>
				<div class="area count select">
					<dl>
						<dt>인원 선택</dt>
						<dd>
							<div class="value-group">
							<div class="value-text2">
								<a id="seat_person_str">성인 1</a>
							</div>
							<div id="air_count" class="popup-typeA air-count">
								<div class="air-wrapper">
									<div class="condition_title">
										<h3 class="title">인원을<br>선택해주세요.</h3>
										<span type="button" class="close-btn" onclick="air_close_popup('#air_count')"></span>
									</div>
									<div class="content-area">
										<div class="detail-area counting-area">
											<div class="counting">
												<div class="l-area">
													<h4 class="sub-title">성 인</h4>
													<h5 class="memo">만 13세 이상</h5>
												</div>
												<div class="r-area">
													<input type="hidden" id="adult_cnt" name="adult_cnt" value="1">
													<button type="button" class="counting-btn" onclick="chg_person('-', 'adult')"><img src="/images/mw/air/minus.png" loading="lazy" alt="빼기"></button>
													<span class="counting-text" id="adult_num">1</span>
													<button type="button" class="counting-btn" onclick="chg_person('+', 'adult')"><img src="/images/mw/air/plus.png" loading="lazy" alt="더하기"></button>
												</div>
											</div>
											<div class="counting">
												<div class="l-area">
													<h4 class="sub-title">소 아</h4>
													<h5 class="memo">만 2세 ~ 13세 미만</h5>
												</div>
												<div class="r-area">
													<input type="hidden" id="child_cnt" name="child_cnt" value="0">
													<button type="button" class="counting-btn" onclick="chg_person('-', 'child')"><img src="/images/mw/air/minus.png" loading="lazy" alt="빼기"></button>
													<span class="counting-text" id="child_num">0</span>
													<button type="button" class="counting-btn" onclick="chg_person('+', 'child')"><img src="/images/mw/air/plus.png" loading="lazy" alt="더하기"></button>
												</div>
											</div>
											<div class="counting">
												<div class="l-area">
													<h4 class="sub-title">유 아</h4>
													<h5 class="memo">만 2세(24개월) 미만</h5>
												</div>
												<div class="r-area">
													<input type="hidden" id="baby_cnt" name="baby_cnt" value="0">
													<button type="button" class="counting-btn" onclick="chg_person('-', 'baby')"><img src="/images/mw/air/minus.png" loading="lazy" alt="빼기"></button>
													<span class="counting-text" id="baby_num">0</span>
													<button type="button" class="counting-btn" onclick="chg_person('+', 'baby')"><img src="/images/mw/air/plus.png" loading="lazy" alt="더하기"></button>
												</div>
											</div>
										</div>
										<div class="detail-area info-area">
											<ul class="list-disc">
												<li>나이는 가는날/오는날 기준으로 적용됩니다.</li>
												<li>유아 선택 시 성인은 꼭 포함되어야 합니다.</li>
												<li>유아는 보호자 1인당 1명만 예약이 가능합니다.</li>
												<li>항공사별로 기준 나이는 상이할 수 있습니다.</li>
											</ul>
										</div>
										<div class="btn-wrap type-full">
											<!-- form 사용시 submit 변경 -->
											<button type="submit" class="comm-btn blue">항공권 검색</button>
										</div>
									</div>
								</div>
							</div>
							</div>
						</dd>
					</dl>
				</div>
				<div class="btn-wrap type-big">
					<!-- form 사용시 type submit 변경 / onclick 삭제 -->
					<button type="submit" class="comm-btn blue">항공권 검색</button>
				</div>
			</div>
		</div> <!-- //mw-search-area -->
	</form>

<%--	<div class="mw-search-area">
		<p>항공권 발권수수료 무료</p>
		<p>탐나오와 함께라면
		국내 여행 항공권 발권수수료는 0원입니다.</p>
		<p>※ 1인 편도 기준 1,000원 ▶ 0원</p>
	</div>--%>

	<h2 class="info-panels-new">
		<div class="snap">
			<div class="variant-card">
				<div class="content">
					<h3>예약 시 <em> 발권수수료</em>를 확인하세요!</h3>
					<h4>탐나오와 함께라면 국내 여행 항공권 <br>발권수수료는 0원입니다 :)</h4>
				</div>
				<h3 class="image-container">
					<span class="visual_txt">1인<br> 편도 기준<span class="price">0<em>원</em></span></span>
				</h3>
			</div>
		</div>
	</h2>

	<!-- customerCenter -->
	<h2 class="customerCenter">
		<div class="inner">
			<div class="customer_wrap">
				<div class="customer_left">
					<p class="operating">Am.9시 - Pm.6시</p>
					<h3 class="tit jl-text">제이엘항공 고객센터</h3>
					<h4 class="explan">점심시간에는 상담이 제공되지 않습니다. <br> (12:00 ~ 13:00) * 주말 및 공휴일 휴무</h4>
				</div>

				<div class="customer_right">
					<a href= "tel:064-805-0070">
						<img src="/images/mw/air/headset.png" alt="헤드셋 아이콘" class="texNum-icon">
						<p class="texNum">
							전화걸기
						</p>
					</a>
				</div>
			</div>

			<div class="customer_wrap sunmin ">
				<div class="customer_left">
					<p class="operating">Am.10시 - Pm.5시</p>
					<h3 class="tit jl-text">선민투어 고객센터</h3>
					<h4 class="explan">점심시간에는 상담이 제공되지 않습니다. <br> (12:00 ~ 13:00) * 주말 및 공휴일 휴무</h4>
				</div>

				<div class="customer_right">
					<a href= "tel:1577-4169">
						<img src="/images/mw/air/headset.png" alt="헤드셋 아이콘" class="texNum-icon">
						<p class="texNum">
							전화걸기
						</p>
					</a>
				</div>
			</div>
		</div>
	</h2><!-- //customerCenter -->

	<!-- FAQ -->
	<section class="faqCenter">
		<div class="inner">

			<dl>
				<dt class="faq_tit">
					<h2 class="faqTit">항공예약 <br>자주하는 문의<br> FAQ</h2>
					<p>
						<a class="shortCuts" href="/mw/coustomer/qaList.do">전체보기</a>
					</p>
					<div class="faqEtc">주말, 공휴일 및 업무시간외에는 해당항공사로 문의</div>
				<dd>
					<ul class="faqTit">
						<li class="faqList n1" data-id="1">
							<img src="/images/mw/air/faq_img_01.png" alt="일정인원 변경">
							<a class="content" id="air-guide-n1"><span class="faqTxt">일정변경/인원변경</span></a>
						</li>
						<li class="faqList n2" data-id="2">
							<img src="/images/mw/air/faq_img_02.png" alt="항공사 수수료">
							<a class="content" id="air-guide-n2"><span class="faqTxt">항공사 취소수수료</span></a>
						</li>
						<li class="faqList n3" data-id="3">
							<img src="/images/mw/air/faq_img_03.png" alt="기상 취소">
							<a class="content" id="air-guide-n3"><span class="faqTxt">기상악화 취소</span></a>
						</li>
						<li class="faqList n4" data-id="4">
							<img src="/images/mw/air/faq_img_04.png" alt="예약번호 확인">
							<a class="content" id="air-guide-n4"><span class="faqTxt">예약번호</span></a>
						</li>
					</ul>

					<!-- content // fag_info_1 -->
					<div id="faq_info_1" class="comm-layer-popup faq-popup">
						<div class="content-wrap">
							<div class="content">
								<div class="detail-header">
									<div class="header-text">
										<span class="qtxt">Q . </span>
										일정변경과 인원변경
									</div>
									<button class="popup_close" onclick="close_popup('.faq-popup');">
										<img src="/images/mw/icon/close/faq_close.png" loading="lazy" alt="닫기">
									</button>
								</div>
								<div class="faqSee btxt1">
									<div>
										<span class="aSize">A . </span>
										일정변경을 원하실 경우 취소 후 재구매를 해야 합니다.
									</div>
									<p class="smtxt"> (항공좌석이 마감될 수 있으므로 잔여석이 있는지 미리 확인하셔야 합니다.)<br>
										인원이 추가되었을 경우에는 항공권 예약 페이지에서 추가로 예약 바랍니다.<br>
										인원이 줄어들었을 경우에는 취소 후 재구매를 하셔야 합니다.
									</p>
								</div>
							</div>
						</div>
					</div><!-- content // -->

					<!-- content // fag_info_2 -->
					<div id="faq_info_2" class="comm-layer-popup faq-popup">
						<div class="content-wrap">
							<div class="content">
								<div class="detail-header">
									<div class="header-text">
										<span class="qtxt">Q . </span>항공사별 취소 수수료
									</div>
									<button class="popup_close" onclick="close_popup('.faq-popup');">
										<img src="/images/mw/icon/close/faq_close.png" loading="lazy" alt="닫기">
									</button>
								</div>
								<div class="faqSee btxt2">
									<div class="toptxt"><span class="aSize">A . </span>취소 수수료는 항공사마다 규정이 다르며, 성인/소아 동일하게 적용됩니다.</div>
									<div>
										<h3 class="headtxt">대한항공</h3>
										<ul class="bodytxt">
											<li>· 구매 익일 ~ 출발 1시간 전 : 일반석 편도 3,000원 / 할인석 편도 5,000원 / 특가석 편도 7,000원(성인/소아동일)</li>
											<li>· 출발 1시간 전 ~ 출발시간 이후 : 일반석 편도 11,000원 / 할인석 편도 13,000원 / 특가석 편도 15,000원(성인/소아동일)</li>
										</ul>
									</div>
									<div>
										<h3 class="headtxt">아시아나항공</h3>
										<ul class="bodytxt">
											<li>· 일반석(구매 익일 ~ 출발 1시간 전) : 편도 3,000원</li>
											<li>· 할인석(구매 익일 ~ 출발 1시간 전) : 편도 7,000원<li>
											<li>· 특가석(구매 익일 ~ 출발 1시간 전) : 편도 9,000원</li>
											<li>· 출발 1시간 전 ~ 출발시간 이후(NO-SHOW) : 편도 10,000원</li>
										</ul>
									</div>
									<div>
										<h3 class = "headtxt">티웨이항공</h3>
										<ul class="bodytxt">
											<li>* 일반석, 할인석</li>
											<li>· 구매 익일 ~ 출발 61일 전까지 : 일반석 편도 1,000원 / 할인석 편도 2,000원 / 비즈니스석 편도 1,000원</li>
											<li>· 60일 전 ~ 31일 전 : 일반석 편도 3,000원 / 할인석 편도 4,000원 / 비즈니스석 편도 4,000원</li>
											<li>· 30일 전 ~ 8일 전 : 일반석 편도 6,000원 / 할인석 편도 7,000원 / 비즈니스석 편도 6,000원</li>
											<li>· 7일 전 ~ 2일 전 : 일반석 편도 11,000원 / 할인석 편도 12,000원 / 비즈니스석 편도 11,000원</li>
											<li>· 1일 전 ~ 당일 출발 전 : 일반석 편도 13,000원 / 할인석 편도 14,000원 / 비즈니스석 편도 18,000원</li>
											<li>· 당일 출발 이후(NO-SHOW) : 일반석, 할인석 편도 15,000원 / 비즈니스석 편도 20,000원 </li>
											<li>* 특가석</li>
											<li>· 구매 익일 ~ 당일 출발 전 : 변경-편도 15,000원 / 취소-운임의 100% 징수</li>
											<li>· 당일 출발 이후(NO-SHOW) : 운임의 100% 징수</li>
										</ul>
									</div>
									<div>
										<h3 class = "headtxt">진에어</h3>
										<ul class="bodytxt">
											<li>· 구매 익일 ~ 출발 61일 전 : 일반석 편도 1,000원 / 할인석 편도 2,000원 / 특가석 편도 3,000원</li>
											<li>· 60일 전 ~ 31일 전 : 일반석 편도 3,000원 / 할인석 편도 4,000원 / 특가석 편도 5,000원</li>
											<li>· 30일 전 ~ 15일 전 : 일반석 편도 4,000원 / 할인석 편도 6,000원 / 특가석 편도 7,000원</li>
											<li>· 14일 전 ~ 2일 전 : 일반석 편도 8,000원 / 할인석 편도 9,000원 / 특가석 편도 10,000원</li>
											<li>· 1일 전 ~ 출발 시간 : 일반석 편도 10,000원 / 할인석 편도 12,000원 / 특가석 편도 14,000원</li>
											<li>· 출발 시간 이후(NO-SHOW) : 일반석, 할인석, 특가석 편도 15,000원</li>
										</ul>
									</div>
									<div>
										<h3 class = "headtxt">제주항공</h3>
										<ul class="bodytxt">
											<li>· 구매시점 24시간 이후 ~ 출발 61일 전 : 일반석, 할인석, 특가석 편도 2,000원 / 비즈니스석 편도 1,000원</li>
											<li>· 60일 전 ~ 31일 전 : 일반석, 할인석, 특가석 편도 4,000원 / 비즈니스석 편도 3,000원</li>
											<li>· 30일 전 ~ 15일 전 : 일반석, 할인석, 특가석 편도 6,000원 / 비즈니스석 편도 5,000원</li>
											<li>· 14일 전 ~ 8일 전 : 일반석, 할인석, 특가석 편도 10,000원 / 비즈니스석 편도 9,000원</li>
											<li>· 7일 전 ~ 2일 전 : 일반석, 할인석, 특가석 편도 12,000원 / 비즈니스석 편도 11,000원</li>
											<li>· 1일 전 : 일반석, 할인석, 특가석 편도 14,000원 / 비즈니스석 편도 13,000원</li>
											<li>· 출발 당일(NO-SHOW 포함) : 일반석, 할인석, 특가석, 비즈니스석 편도 15,000원</li>
										</ul>
									</div>
									<div>
										<h3 class = "headtxt">에어부산</h3>
										<ul class="bodytxt">
											<li>· 구매 익일 ~ 출발 61일 전 : 일반석 편도 1,000원 / 할인석,특가석 편도 2,000원</li>
											<li>· 60일 전 ~ 31일 전 : 일반석 편도 1,000원 / 할인석, 특가석 편도 4,000원</li>
											<li>· 30일 전 ~ 15일 전 : 일반석 편도 3,000원 / 할인석, 특가석 편도 6,000원</li>
											<li>· 14일 전 ~ 3일 전 : 일반석 편도 5,000원 / 할인석, 특가석 편도 9,000원</li>
											<li>· 2일 전 ~ 출발 1시간 전 : 일반석 편도 10,000원 / 할인석, 특가석 편도 12,000원</li>
											<li>· 출발 1시간 이내 ~ 출발 시간 이후(NO-SHOW) : 일반석, 할인석, 특가석 편도 15,000원</li>
										</ul>
									</div>
									<div>
										<h3 class = "headtxt">에어서울</h3>
										<ul class="bodytxt">
											<li>· 구매 익일 ~ 출발 61일 전 : 일반석 편도 1,000원 / 할인석, 특가석 편도 2,000원</li>
											<li>· 60일 전 ~ 31일 전 : 일반석 편도 2,000원 / 할인석, 특가석 편도 4,000원</li>
											<li>· 30일 전 ~ 15일 전 : 일반석 편도 3,000원 / 할인석, 특가석 편도 6,000원</li>
											<li>· 14일 전 ~ 2일 전 : 일반석 편도 5,000원 / 할인석, 특가석 편도 8,000원</li>
											<li>· 1일 전 ~ 출발 1시간 전 : 일반석 편도 12,000원 / 할인석, 특가석 편도 13,000원</li>
											<li>· 출발시간 이후(NO-SHOW) : 일반석, 할인석, 특가석 편도 15,000원</li>
											<li>* 특가석(A)</li>
											<li>· 구매 익일 ~ 출발시간 이후(NO-SHOW) : 편도 15,000원</li>
										</ul>
									</div>
									<div>
										<h3 class = "headtxt">이스타항공</h3>
										<ul class="bodytxt">
											<li>· 구매 익일 ~ 출발 61일 전 : 일반석, 할인석 편도 2,000원</li>
											<li>· 60일 전 ~ 31일 전 : 일반석, 할인석 편도 4,000원</li>
											<li>· 30일 전 ~ 8일 전 : 일반석 편도 8,000원 / 할인석 편도 10,000원</li>
											<li>· 7일 전 ~ 2일 전 : 일반석 편도 12,000원 / 할인석 편도 13,000원</li>
											<li>· 1일 전 ~ 출발 1시간 전 : 일반석, 할인석 편도 14,000원</li>
											<li>· 출발시간 이후(NO-SHOW) : 일반석, 할인석 편도 20,000원</li>
											<%--                            <li>* 특가석</li>
																		<li>· 구매 익일 ~ 출발시간 이후(NO-SHOW) : 운임의 100% 징수(변경 시 편도 : 15,000원)</li>--%>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div><!-- content // -->

					<!-- content // fag_info_3 -->
					<div id="faq_info_3" class="comm-layer-popup faq-popup">
						<div class="content-wrap">
							<div class="content">
								<div class="detail-header">
									<div class="header-text">
										<span class="qtxt">Q . </span>
										기상악화로 인한 취소
									</div>
									<button class="popup_close" onclick="close_popup('.faq-popup');">
										<img src="/images/mw/icon/close/faq_close.png" loading="lazy" alt="닫기">
									</button>
								</div>
								<div class="faqSee btxt3">
									<div>
										<span class="aSize">A . </span>
										천재지변, 기상악화 등에 의한 예약취소의 경우 취소 수수료가 부과되지 않습니다.
									</div>
									<p class="smtxt"> 단, 항공 결항 통보 없이 고객이 임의로 취소할 경우 수수료가 부과되며, 결항 통보 전까지는 공항에서 대기를 하셔야 합니다
										결항 통보는 반드시 출발 전 해당 항공사로 확인 바라며, 결항 통보 전 이동 교통수단에 대한 교통비는 개별 부담입니다.
										왕복 항공권일 때 이용하는 항공사가 다를 경우 결항되지 않은 편에 대해서 취소시 취소 수수료가 부과됩니다.
									</p>
								</div>
							</div>
						</div>
					</div><!-- content // -->

					<!-- content // fag_info_4 -->
					<div id="faq_info_4" class="comm-layer-popup faq-popup">
						<div class="content-wrap">
							<div class="content">
								<div class="detail-header">
									<div class="header-text">
										<span class="qtxt">Q . </span>
										예약번호 분실 및 확인
									</div>
									<button class="popup_close" onclick="close_popup('.faq-popup');">
										<img src="/images/mw/icon/close/faq_close.png" loading="lazy" alt="닫기">
									</button>
								</div>
								<div class="faqSee btxt4">
									<div>
										<span class="aSize">A . </span>
										마이페이지 > 항공 예약확인 페이지에서 성명과 핸드폰 번호를 입력하시면 예약번호를 확인하실 수 있습니다.
									</div>

								</div>
							</div>
						</div>
					</div><!-- content // -->
					<!-- //1201 항공 레이어팝업 수정 -->
				</dd>
				</dt>
			</dl><!-- //FAQ -->
		</div>
	</section>

	<!-- 항공 seo 디스크립션 영역추가 -->
	<section class="air-plane-overview-section">
		<div class="av-info">
			<h2 class="info-logo">탐나오 렌트카 서비스 개요
				<img src="/images/mw/air/air-showcase.png"  alt="탐나오 렌트카 서비스 개요">
			</h2>

			<div class="info-article">
				<p><span>제주도 공식 여행 공공플랫폼 항공권 서비스 탐나오에서</span><br>제주도 비행기 좌석을 편리하게 예약해 보세요!</p>
				<p>발권 수수료가 없어 추가 비용 없이 합리적인 가격에 항공편을<br>예매하실 수 있으며,</p>
				<p>국적기부터 저비용항공사까지 다양한 항공사를<br>폭넓게 비교해볼 수 있습니다.</p>
				<p>탐나오에서는 항공권뿐 아니라<br>렌트카, 숙소, 관광지 예약까지 한 번에 가능하며,</p>
				<p>숨은 비용 없이 실제 지불 금액을 정확히 안내해 드립니다.<br>제주국제공항에 도착하신 후,<br>안전하고 즐거운 여행을 시작하세요!</p>
				<p class="shape-circle">
					<span class="circle"></span>
					<span class="circle"></span>
					<span class="circle"></span>
				</p>
				<p><span>지금 바로 탐나오에서 원하는 항공권을<br>검색하고 예약해 보세요.</span></p>

			</div>
		</div>
	</section>

	<!-- 광고 banner -->
	<%--<section class="content__banner">
			<div class="banner__wrap">
                <a href="/web/sp/detailPrdt.do?prdtNum=SP00001737&prdtDiv=TOUR" class="inner--link" target="_blank">
                    <img class="business-lounge__banner" src="/images/mw/air/banner_kac.png" alt="비즈니스라운지" >
                </a>
			</div>
	</section><!-- //광고 banner -->--%>

	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->
<script src="/js/dimmed.js?version=${nowDate}"></script>
<script src="/js/moment.min.js?version=${nowDate}"></script>
<script src="/js/daterangepicker.js?version=${nowDate}"></script>
<script src="/js/mw_air_step1.js?version=${nowDate}"></script>
<script>

	var getContextPath = "${pageContext.request.contextPath}";
	
	//js/air_step1 check_air_seach_form() 변수셋팅
	var prevIndex = 0;

	let globalStartDate = null;
	let globalEndDate = null;

    /** custom-select */
	$(document).ready(function() {

		var currentState = history.state;
        if(currentState){
            $("#main").html(currentState);

			// currentState의 HTML 내용에서 값을 검색
			const tripTypeMatch = currentState.match(/<input[^>]*name="trip_type"[^>]*value="([^"]*)"/);
			const startDateMatch = currentState.match(/<input[^>]*name="start_date"[^>]*value="([^"]*)"/);
			const endDateMatch = currentState.match(/<input[^>]*name="end_date"[^>]*value="([^"]*)"/);

			if (tripTypeMatch) {
				const tripType = tripTypeMatch[1];
				globalStartDate = startDateMatch[1];
				globalEndDate = endDateMatch[1];
				$("input[name='start_date_view']").val(globalStartDate);
				$("input[name='end_date_view']").val(globalEndDate);

				// trip_type 분기
				if (tripType === "OW") {
					setTimeout(() => singlePicker(), 0);
				} else {
					setTimeout(() => rangePicker(), 0);
				}
			}
		}

		$("html, body").removeClass("not_scroll");

		var selected = $('.selected');
		var optionsContainer = $('.options');
		var optionsList = $('.option');
		var hiddenSelect = $('#seat_type');

		selected.on('click', function() {
			optionsContainer.toggleClass('show');
		});

		optionsList.each(function() {
			$(this).on('click', function() {
				selected.text($(this).text());
				hiddenSelect.val($(this).data('value')); // hidden select의 값 설정
				optionsContainer.removeClass('show');
			});
		});

		$(window).on('click', function(e) {
			if (!$(e.target).is('.selected')) {
				optionsContainer.removeClass('show');
			}
		});


		// dimmed lock scroll 처리
		var posY;

		$("#start_region_str, #end_region_str").on("click", function(e){
			optionPopup('#air_departure', this);
			$('#dimmed').show();
			$("html, body").addClass("not_scroll");
			$("#header").removeClass("nonClick");
		});

		$("#seat_person_str").on("click", function(e){
			optionPopup('#air_count', this);
			$('#dimmed').show();
			$("html, body").addClass("not_scroll");
			$("#header").removeClass("nonClick");
		});

		$(".comm-btn.blue").click(function (){
			$('#dimmed').fadeOut(100);
			$("html, body").removeClass("not_scroll");
		});

		// 0821 항공 레이어팝업
		$(".faqList").click(function(){
			$('body').append('<div class="lock-bg"></div>');
	/*		const divTop = Math.max(0, (($(window)s.height() - $(this).outerHeight()) / 2)+ $(window).scrollTop() - 760); //상단 좌표*/
	
	        //스크롤 방지
	        $('body').addClass('not_scroll');
	
	        //레이어 팝업 크기 (항공사별 취소수수료 500px)
	/*		const height = $(this).data('id') == 2 ? '500px': '0px';*/
	
			//레이어 팝업 show
			$('#faq_info_'+ $(this).data('id')).fadeToggle();
			$('#faq_info_'+ $(this).data('id')).show();
		});
	
		// 출발지 선택
		$('input[name=start_region]').change(function() {
			$("#start_region_str").html('<p class="code"><span>'+$(this).val()+'</span>'+$("label[for=" + $(this).attr('id') + "]").text()+'</p>');
		});
	
		// 도착지 선택
		$('input[name=end_region]').click(function() {
			$("#end_region_str").html('<p class="code"><span>'+$(this).val()+'</span>'+$("label[for=" + $(this).attr('id') + "]").text()+'</p>');

			optionClose($('#air_departure'));

			$("html, body").removeClass("not_scroll");
			$('#dimmed').fadeOut(100);
		});


		$('form').each(function(){
			this.reset();
		});
	
		/** 왕복 탭 선택시 레인지피커 */
		$('#air_typeRT').click(function() {
			rangePicker();
		})
	
		/** 편도 탭 선택시 싱글피커 */
		$('#air_typeOW').click(function() {
			singlePicker();
		});
	
		/** 레인지 피커 디폴트*/
			rangePicker();

		// 출발지 <> 도착지 체인지
	  	$(' .change').on('click', function() {
			let startReg = "";
	        let endReg = "";
			startReg = $("input[name=start_region]:checked").val();
	        endReg = $("input[name=end_region]:checked").val();
	
			$("input[name=start_region]").each(function(index) {
				if(endReg == $("#air_test"+index).val()){
					$("#air_test"+index).prop("checked", true);
					$("input[name=start_region]:checked").change();
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
	
		//일자 스타일 변경
		$("input[name=start_date_view]").val($("input[name=start_date]").val().replace(/-/gi, ". ")+ "(" + getDate($("input[name=start_date]").val()) + ")");
		$("input[name=end_date_view]").val($("input[name=end_date]").val().replace(/-/gi, ". ")+ "(" + getDate($("input[name=end_date]").val()) + ")");

	});

	//창 닫기
	function air_close_popup(obj) {
		if (typeof obj == "undefined" || obj == "" || obj == null) {
			$('#dateRangePickMw').data('daterangepicker').hide();
		} else {
			$(obj).hide();
		}
		$('#dimmed').fadeOut(100);
		$("html, body").removeClass("not_scroll");
	}

	/** 레인지 피커 */
	function rangePicker(){
		const startDate = globalStartDate  ? moment(globalStartDate , "YYYY-MM-DD") : moment();
		const endDate = globalStartDate  ? moment(globalEndDate , "YYYY-MM-DD") : moment();
		$('.date-container').daterangepicker({
			startDate: startDate,
			endDate: endDate,
			maxDate : moment().add(365, 'days')

		}, function (start, end) {
			/** 항공 날짜설정*/
			$("input[name=start_date]").val(start.format('YYYY-MM-DD'));
			$("input[name=end_date]").val(end.format('YYYY-MM-DD'));
			$("input[name=start_date_view]").val(start.format('YYYY. MM. DD')+ "(" + getDate(start.format('YYYY-MM-DD')) + ")");
			$("input[name=end_date_view]").val(end.format('YYYY. MM. DD')+ "(" + getDate(end.format('YYYY-MM-DD')) + ")");
		});
	}

	/** 싱글 피커 */
	function singlePicker(){
		const startDate = globalStartDate  ? moment(globalStartDate , "YYYY-MM-DD") : moment();
		$('.date-container').daterangepicker({
			singleDatePicker: true,
			startDate: startDate,
			maxDate : moment().add(365, 'days')
		}, function (start, end) {
			/** 항공 날짜설정*/
			$("input[name=start_date]").val(start.format('YYYY-MM-DD'));
			$("input[name=start_date_view]").val(start.format('YYYY. MM. DD')+ "(" + getDate(start.format('YYYY-MM-DD')) + ")");
			$("input[name=end_date_view]").val(end.format('YYYY. MM. DD')+ "(" + getDate(end.format('YYYY-MM-DD')) + ")");
		});
	}

</script>

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'uINg123WTGW-CJnqg-nx4Q'
    };
</script>
<script async type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js">



</script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</div>
<div id="dimmed"></div>
</body>
</html>