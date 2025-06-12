<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<head>
<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="제주항공권 : 제주도항공권 예약은 탐나오"/>
	<jsp:param name="description" value="제주 및 국내선항공권 예약을 발권수수료 없이 이용할 수 있습니다. 비행기표 예약은 제주도가 지원하고 제주관광협회가 운영하는 탐나오"/>
	<jsp:param name="keywords" value="제주항공편,제주도항공편,제주항공예약,실시간항공,제주비행기표,제주항공항공편"/>
</jsp:include>
<meta property="og:title" content="제주항공권 : 제주도항공권 예약은 탐나오">
<meta property="og:url" content="https://www.tamnao.com/web/av/mainList.do">
<meta property="og:description" content="제주 및 국내선항공권 예약을 발권수수료 없이 이용할 수 있습니다. 비행기표 예약은 제주도가 지원하고 제주관광협회가 운영하는 탐나오">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common2.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/av.css?version=${nowDate}'/>">
<link rel="canonical" href="https://www.tamnao.com/web/av/mainList.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/av/mainList.do">
<link rel="preload" as="image" href="../../images/web/air/air_visual.jpg" />
</head>
<body>
<jsp:include page="/web/head.do"></jsp:include>
<main id="main">
	<%-- CLS 불량으로 일단 주석처리함.
    <div class="mapLocation"> <!--index page에서는 삭제-->
		<div class="inner">
			<span>홈</span> <span class="gt">&gt;</span>
			<span>항공</span>
		</div>
	</div>
	--%>
	<div class="subContainer" id="avMain">
	    <div class="subHead"></div>
	    <div class="subContents" style="min-height:800px;">
	        <!-- Change Contents -->
	        
	        <!-- 검색바 -->
	        <section class="search-typeA">
	        	<h2 class="sec-caption">항공 검색</h2>
	        	<div class="inner">
	        		<!-- 코드중복(include) -->
					<div class="form-area skeleton_loading">
						<form name="air_search_form" action="<c:url value='/web/av/productList.do' />" method="post" onsubmit="return check_air_seach_form();">
							<input type="hidden" name="page_type" value="main">
							<ul class="check-area">
								<li class="lb-ch active">
									<input type="checkbox" id="air_typeRT" value="RT" name="trip_type" class="textY" <c:if test="${empty searchVO.trip_type || searchVO.trip_type  eq 'RT'}">checked="checked"</c:if> onclick="airWaytype_click(this.id);">
									<label for="air_typeRT" class="label_av">왕복</label>
								</li>
								<li class="lb-ch">
									<input type="checkbox" id="air_typeOW" value="OW" name="trip_type" class="textN" <c:if test="${searchVO.trip_type eq 'OW'}">checked="checked"</c:if> onclick="airWaytype_click(this.id);">
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
												<a onclick="optionPopup('#air_departure', this)" id="start_region_str">김포(GMP)</a>
											</div>
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
											</div>
										</dd>
									</dl>
									<%-- <a href="javascript:void(0)" class="change"><img src="/images/web/air/change.png" alt="변경"></a> --%>
									<span class="change" style="cursor: pointer;"><img src="/images/web/air/change.png" width="14" height="14" alt="변경"></span>
									<dl>
										<dt>
											<div class="rt-icon">
												<span class="IconSide">도착지</span>
											</div>
										</dt>
										<dd>
											<div class="value-text">
												<a onclick="optionPopup('#air_arrival', this)" id="end_region_str">제주(CJU)</a>
											</div>
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
											</div>
										</dd>
									</dl>
								</div>
								
								<div class="area date">
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
														<input class="datepicker" type="text" name="start_date" value="${searchVO.start_date}" placeholder="가는날 선택" onclick="optionClose('.popup-typeA')">
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
														<input class="datepicker" type="text" name="end_date" value="${searchVO.end_date}" placeholder="오는날 선택" onclick="optionClose('.popup-typeA')">
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
												<a onclick="optionPopup('#air_count', this)" id="seat_person_str">성인 1</a>
											</div>
											<div id="air_count" class="popup-typeA air-count">
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
											</div>
										</dd>
									</dl>
								</div>
								<div class="area search">
									<!-- form 사용시 submit 변경 -->
									<button type="submit" class="btn red">
                                        <span class="MagGlass">
                                            <span class="TicSec">항공권 검색</span>
                                        </span>
                                    </button>
								</div>
							</div> <!-- //search-area -->
					    </form>
					</div> <!-- //form-area -->
					<!-- //코드중복(include) -->
				</div>
	        </section> <!-- //search-typeA -->
	        
	        <!-- 항공 Slide -->
	        <div class="product-slide-area">
	        	<div class="inner">
	        		<div class="air-col3-item">
	        			<ul>
	        				<li>
	        					<div class="icon">
	        						<img src="/images/web/air/info-01.png" width="122" height="29" alt="믿을 수 있는 탐나오">
	        					</div>
	        					<dl class="virtic">
	        						<dt>믿을 수 있는 탐나오</dt>
	        						<dd>제주특별자치도가 지원하고<br>제주특별자치도관광협회가 운영합니다.</dd>
	        					</dl>
	        				</li>
	        				<li>
	        					<div class="icon">
	        						<img src="/images/web/air/info-02.png" width="55" height="55" alt="여러 항공사를 한 번에 비교">
	        					</div>
	        					<dl class="virtic">
	        						<dt>여러 항공사를 한 번에 비교</dt>
	        						<dd>대한항공, 아시아나, 에어부산, 제주항공 등<br>8개 항공사를 한 번에 빠르게 비교하세요.</dd>
	        					</dl>
	        				</li>
	        				<li>
	        					<div class="icon">
	        						<img src="/images/web/air/info-04.png" width="76" height="76" alt="항공권 발권수수료 무료">
	        					</div>
	        					<dl class="virtic">
	        						<dt>항공권 발권수수료 무료</dt>
	        						<dd>탐나오와 함께라면<br>국내 여행 항공권 발권수수료는 0원입니다.<br>※ 1인 편도 기준 <span class="won">1,000원</span> <span class="arrow">▶</span> 0원</dd>
	        					</dl>
	        				</li>
	        			</ul>
	        		</div>
	        	</div>
	        </div><!-- //항공 Slide -->

			<!-- 광고 banner -->
			<%--<section class="content__banner">
				<div class="content__banner-inner">
					<a href="/web/sp/detailPrdt.do?prdtNum=SP00001737&prdtDiv=TOUR" class="inner--link" target="_blank">
						<img class="business-lounge__banner" src="/images/web/air/banner_intro.png" alt="비즈니스라운지">
					</a>
				</div>
			</section><!-- //광고 banner -->--%>

			<!-- customerCenter -->
			<section class="customerCenter">
				<div class="inner">
					<dl>
						<dt>
							<img class="jlair-icon" src="/images/web/air/jlair.png" width="82" height="35" alt="제이엘항공">
							<span class="tit">항공 고객센터</span>
						</dt>
						<dd>
							<div class="jl-texNum">
								<img src="/images/web/air/texNum-icon.png" width="30" height="25" alt="모바일아이콘" class="texNum-icon">
								<span class="texNum">064-805-0070</span>
							</div>
							<div class="texTim">
								<span>운영시간 : 09:00 ~ 18:00</span>
								<span>점심시간 : 12:00 ~ 13:00</span>
							</div>
						</dd>
						<dd class="explan">점심시간에는 상담이 제공되지 않습니다.<br>(주말 및 공휴일 휴무)</dd>
					</dl>
					<dl>
						<dt>
							<img class="jeju-icon" src="/images/web/air/sunmintour.png" width="90" height="24" alt="선민투어항공">
							<span class="tit">항공 고객센터</span>
						</dt>
						<dd>
							<div class="jl-texNum">
								<img src="/images/web/air/texNum-icon.png" alt="모바일아이콘" width="30" height="25" class="texNum-icon">
								<span class="texNum">1577-4169</span>
							</div>
							<div class="texTim">
								<span>운영시간 : 10:00 ~ 17:00</span>
								<span>점심시간 : 12:00 ~ 13:00</span>
							</div>
						</dd>
						<dd class="explan">점심시간에는 상담이 제공되지 않습니다.<br>(주말 및 공휴일 휴무)</dd>
					</dl>
					<!-- FAQ -->
					<dl class="faqWrap">
						<dt>
							<span class="faqTit">항공예약 자주하는 문의 <span>FAQ</span></span>
							<span>
								<a class="shortCuts" href="/web/coustmer/qaList.do">더보기 &nbsp; ></a>
							</span>
						</dt>
						<dd>
							<ul class="faqTit">
								<li id="popup_open" class="faqList n1">
									<a id="faq_Select" class="content" href="javascript:show_popup('#faq_info_1');"><span class="faqTxt">일정변경<br>인원변경</span></a>
								</li>
								<li class="faqList n2">
									<a class="content" href="javascript:show_popup('#faq_info_2');"><span class="faqTxt">항공사별 <br> 취소수수료</span></a>
								</li>
								<li class="faqList n3">
									<a class="content" href="javascript:show_popup('#faq_info_3');"><span class="faqTxt">기상악화로 <br> 인한 취소</span></a>
								</li>
							</ul>

							<!-- content // fag_info_1 -->
							<div id="faq_info_1" class="comm-layer-popup_fixed">
								<div class="content-wrap">
									<div class="content">
										<div class="detail-header">
											<div class="header-text">
												<span class="qtxt">Q . </span>
												일정변경과 인원변경은 어떻게 하나요?
                                                <button type="button" class="btnCl" onclick="close_popup('#faq_info_1');">
													<img src="../../images/web/icon/close/white.png" alt="닫기">
												</button>
											</div>
										</div>
										<div class="faqSee btxt1">
											<div>
												<span class="aSize">A . </span>
												일정변경을 원하실 경우 취소 후 재구매를 해야 합니다.
											</div>
											<p class="smtxt"> (항공좌석이 마감될 수 있으므로 잔여석이 있는지 미리 확인하셔야 합니다.)<br>
											인원이 추가되었을 경우에는 항공권 예약 페이지에서 추가로 예약 바랍니다.<br>
											인원이 줄어들었을 경우에는 취소 후 재구매를 하셔야 합니다.</p>
										</div>
									</div>
								</div>
							</div><!-- content // -->

							<!-- content // fag_info_2 -->
							<div id="faq_info_2" class="comm-layer-popup_fixed">
								<div class="content-wrap">
									<div class="content">
										<div class="detail-header">
											<div class="header-text">
												<span class="qtxt">Q . </span>
												항공사별 취소 수수료는 어떻게 되나요?
												<button type="button" class="btnCl" onclick="close_popup('#faq_info_2');">
													<img src="../../images/web/icon/close/white.png" alt="닫기">
												</button>
											</div>
										</div>
										<div class="faqSee btxt2">
											<div class="toptxt"><span class="aSize">A . </span>취소 수수료는 항공사마다 규정이 다르며, 성인/소아 동일하게 적용됩니다.</div>
											<div>
												<h3 class="headtxt">대한항공</h3>
												<ul class="bodytxt">
													<li>· 구매 익일 ~ 출발 1시간 전 : 일반석 편도 3,000원 / 할인석 편도 5,000원 / 특가석 편도 7,000원</li>
													<li>· 출발 1시간 전 ~ 출발시간 이후 : 일반석 편도 11,000원 / 할인석 편도 13,000원 / 특가석 편도 15,000원</li>
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
												<%--	<li>* 특가석</li>
													<li>· 구매 익일 ~ 출발시간 이후(NO-SHOW) : 운임의 100% 징수(변경 시 편도 : 15,000원)</li>--%>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</div><!-- content // -->

							<!-- content // fag_info_3 -->
							<div id="faq_info_3" class="comm-layer-popup_fixed">
								<div class="content-wrap">
									<div class="content">
										<div class="detail-header">
											<div class="header-text">
												<span class="qtxt">Q . </span>
												기상악화로 인한 취소는 어떻게 처리 되나요?
												<button type="button" class="btnCl" onclick="close_popup('#faq_info_3');">
													<img src="../../images/web/icon/close/white.png" alt="닫기">
												</button>
											</div>
										</div>
										<div class="faqSee btxt3">
											<div>
												<span class="aSize">A . </span>
												천재지변, 기상악화 등에 의한 예약취소의 경우 취소 수수료가 부과되지 않습니다.
											</div>
											<p class="smtxt"> 단, 항공 결항 통보 없이 고객이 임의로 취소할 경우 수수료가 부과되며, 결항 통보 전까지는 공항에서 대기를 하셔야 합니다
											 결항 통보는 반드시 출발 전 해당 항공사로 확인 바라며, 결항 통보 전 이동 교통수단에 대한 교통비는 개별 부담입니다.
											 왕복 항공권일 때 이용하는 항공사가 다를 경우 결항되지 않은 편에 대해서 취소시 취소 수수료가 부과됩니다.</p>
										</div>
									</div>
								</div>
							</div><!-- content // -->
							<span class="faqEtc">* 주말, 공휴일 및 업무시간외에는 해당항공사로 문의</span>
						</dd>
					</dl><!-- //FAQ -->
				</div>
			</section><!-- //customerCenter -->	        		       		
	        
	        <!-- Product list -->		
<%-- 			<section class="u-goods-sec">
				<div class="Fasten">
					<div>
					<h2 class="title-type3">나만의 완벽한 여행을 계획하세요.</h2>
						<ul class="tab-theme">		
				      	<c:forEach var="result" items="${kwaList}" varStatus="status">
							<li>
								<c:if test="${empty result.pcUrl && result.prdtCnt == 0}">
								<a class="tag on" href="/web/search.do?search=<c:out value="${result.kwaNm}"/>" >
								</c:if>
								<c:if test="${not empty result.pcUrl }"><a class="tag" href="${result.pcUrl}" ></c:if>
								<c:if test="${empty result.pcUrl && result.prdtCnt != 0}"><a class="tag" href="/web/kwaSearch.do?kwaNum=<c:out value="${result.kwaNum}"/>" ></c:if>
									<c:out value="${result.kwaNm}"/>
								</a>
							</li>
				      	</c:forEach>		
						</ul>
					</div>	       
				</div>
			</section>  --%>

			<!-- 항공 seo 디스크립션 영역추가 -->
			<section class="air-plane-overview-section">
				<div class="inner">
					<div class="av-info">
						<h2 class="info-logo">탐나오 항공권 서비스 개요
							<img src="/images/web/air/air-showcase.png"  alt="탐나오 항공권 서비스 개요">
						</h2>
						<!-- 렌터카(tabs-3) -->

						<div class="info-article">
							<p><span>제주도 공식 여행 공공플랫폼 항공권 서비스 탐나오</span>에서 제주도 비행기 좌석을 편리하게 예약해 보세요!</p>
							<p>발권 수수료가 없어 추가 비용 없이 합리적인 가격에 항공편을 예매하실 수 있으며,</p>
							<p>국적기부터 저비용항공사까지 다양한 항공사를 폭넓게 비교해볼 수 있습니다.</p>
							<p>탐나오에서는 항공권뿐 아니라 렌트카, 숙소, 관광지 예약까지 한 번에 가능하며,</p>
							<p>숨은 비용 없이 실제 지불 금액을 정확히 안내해 드립니다. 제주국제공항에 도착하신 후, 안전하고 즐거운 여행을 시작하세요!</p>
							<p><span>지금 바로 탐나오에서 원하는 항공권을 검색하고 예약해 보세요.</span></p>
						</div>
					</div>
				</div><!-- //inner -->
			</section>

	    </div> <!-- //subContents -->
	</div> <!-- //subContainer -->
</main>

<%-- <script async src="<c:url value='/js/air.js?version=${nowDate}'/>"></script>
<script async src="<c:url value='/js/align_tablesorter.js?version=${nowDate}'/>"></script> --%>
<script async src="<c:url value='/js/air_step1.js?version=${nowDate}'/>"></script>
<script>

	// js/air_step1 check_air_seach_form() 변수셋팅
	var prevIndex = 0;
	
	/** 레인지 피커 */
	/* function rangePicker(){
		$('.date-container').daterangepicker({
			//singleDatePicker: true
		}, function (start, end) {
			/** 항공 날짜설정 
			$("input[name=start_date]").val(start.format('YYYY-MM-DD'));
			$("input[name=end_date]").val(end.format('YYYY-MM-DD'));
		});
	} */
	
	function fn_Search_LayerClose(){
		$("#air_count").hide();
	}
	
	// 편도일 경우 오는날 날짜 hide, js에서 분리
	function airWaytype_click(id) {
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
	
	var getContextPath = "${pageContext.request.contextPath}";
	
	$(document).ready(function(){
		
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
		
		//Top Slider Item
		/* 	
		if($('#product_slideItem .swiper-slide').length > 3) {			//4개 이상시 실행
			var swiper = new Swiper('#product_slideItem', {
				slidesPerView: 3,
		        paginationClickable: true,
		        spaceBetween: 15,
		        nextButton: '#slideItem_next',
		        prevButton: '#slideItem_prev'
		    });
		}
		else {
			$('#slideItem_arrow').hide();
		} 
		*/
	
		// 출발지 선택
		$('input[name=start_region]').change(function() {
			$("#start_region_str").text($("label[for=" + $(this).attr('id') + "]").text() + "(" + $(this).val() + ")");
			optionClose($("#air_departure"));
		});
	
		// 도착지 선택
		$('input[name=end_region]').change(function() {
			$("#end_region_str").text($("label[for=" + $(this).attr('id') + "]").text() + "(" + $(this).val() + ")");
			optionClose($("#air_arrival"));
		});
	
		// 여백 클릭 시 팝업 닫기
		$(document).mouseup(function(e){
			var divPop = $(".popup-typeA");
			if(divPop.has(e.target).length == 0){
				divPop.hide();
				return;
			}
		});
	
		// 왕복, 편도 클릭 시 
	  	$(' .check-area li').on('click', function() {
	  		$('.lb-ch').removeClass("active")
	  		$(this).addClass("active");
	 	});
	  	
		// 해시태그 클릭 시
	  	$(' .tab-theme li a').on('click', function() {
	  		$('.tag').removeClass("on")
	  		$(this).addClass("on");
	 	});  	
		
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
	             	$("input[name=end_region]:checked").change();
	             	return;
	          	}
	         	if(endReg == $("#air_test"+index).val()){
	            	$("#air_test"+index).prop("checked", false);
	             	return;
	          	}
	       	});
		});
	});
	
	/* layer popup */
	// head.jsp 출력시 삭제
	function show_popup(obj){
		if($(obj).is(":hidden")){
			$(obj).show();
			$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
		}else{
			$(obj).hide();
			$('.lock-bg').remove();
		}
	}
	function close_popup(obj){
		$(obj).hide();
		$('.lock-bg').remove();
	}
</script>

<jsp:include page="/web/foot.do"></jsp:include>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'uINg123WTGW-CJnqg-nx4Q'
    };
</script>
<script async type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js"></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>