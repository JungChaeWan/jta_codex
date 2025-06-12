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
<meta name="robots" content="noindex">
<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="실시간 항공 예약"/>
	<jsp:param name="keywords" value="제주, 실시간 항공, 탐나오"/>
	<jsp:param name="description" value="탐나오 실시간 항공 목록"/>
</jsp:include>
<meta property="og:title" content="실시간 항공 예약">
<meta property="og:description" content="제주, 실시간 항공, 탐나오">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Light.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/av.css?version=${nowDate}'/>" />
</head>
<body>

<jsp:include page="/web/head.do" flush="false"></jsp:include>
<main id="main">
    <div class="mapLocation"> <!--index page에서는 삭제-->
		<div class="inner">
			<span>홈</span> <span class="gt">&gt;</span>
			<span>항공</span>
		</div>
	</div>
	
	<div class="subContainer" id="avMain">
	    <div class="subHead"></div>
	    <div class="subContents">
			<!-- air_research_btn -->
			<section>
				<div id="sch_focus" class="air_srch_result_bar">
					<div class="air_width_fixed">
						<!-- default -->
						<div class="air_research_btn">다른일정검색</div>
						<!-- on 표시 -->
						<div class="air_research_btn_off" style="display: none;">다른일정검색</div>
					</div>
				</div>
			</section>   
			
	        <!-- 검색바 -->
	        <section class="search-typeA" style="display: none">
	        	<h2 class="sec-caption">항공 검색</h2>
	        	<div class="inner">
	        		<!-- 코드중복(include) -->
					<div class="form-area">
						<form name="air_search_form" onsubmit="return check_air_seach_form();">
						<input type="hidden" name="page_type" value="list" />
							<ul class="check-area">
								<li class="lb-ch <c:if test="${empty searchVO.trip_type || searchVO.trip_type eq 'RT'}">active</c:if>">
									<input type="checkbox" id="air_typeRT" value="RT" name="trip_type" class="textY" <c:if test="${empty searchVO.trip_type || searchVO.trip_type eq 'RT'}">checked="checked"</c:if> onclick="airtype_click(this.value);">
									<label for="air_typeRT" class="label_av">왕복</label>
								</li>
								<li class="lb-ch <c:if test="${searchVO.trip_type eq 'OW'}">active</c:if>">
									<input type="checkbox" id="air_typeOW" value="OW" name="trip_type" class="textN" <c:if test="${searchVO.trip_type eq 'OW'}">checked="checked"</c:if> onclick="airtype_click(this.value);">
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
											<div class="value-text"><a href="javascript:void(0)" onclick="optionPopup('#air_departure', this)" id="start_region_str">김포(GMP)</a></div>
											<div id="air_departure" class="popup-typeA air-zone">
												<ul class="select-menu col4">
													<li>
														<div class="lb-box">
															<input id="air_test0" name="start_region" type="radio" value="GMP" <c:if test="${searchVO.start_region=='GMP'}">checked="checked"</c:if>>
															<label for="air_test0">김포</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test1" name="start_region" type="radio" value="CJU" <c:if test="${searchVO.start_region=='CJU'}">checked="checked"</c:if>>
															<label for="air_test1">제주</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test2" name="start_region" type="radio" value="PUS" <c:if test="${searchVO.start_region=='PUS'}">checked="checked"</c:if>>
															<label for="air_test2">부산</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test3" name="start_region" type="radio" value="TAE" <c:if test="${searchVO.start_region=='TAE'}">checked="checked"</c:if>>
															<label for="air_test3">대구</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test4" name="start_region" type="radio" value="KWJ" <c:if test="${searchVO.start_region=='KWJ'}">checked="checked"</c:if>>
															<label for="air_test4">광주</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test5" name="start_region" type="radio" value="CJJ" <c:if test="${searchVO.start_region=='CJJ'}">checked="checked"</c:if>>
															<label for="air_test5">청주</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test6" name="start_region" type="radio" value="MWX" <c:if test="${searchVO.start_region=='MWX'}">checked="checked"</c:if>>
															<label for="air_test6">무안</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test7" name="start_region" type="radio" value="RSU" <c:if test="${searchVO.start_region=='RSU'}">checked="checked"</c:if>>
															<label for="air_test7">여수</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test8" name="start_region" type="radio" value="USN" <c:if test="${searchVO.start_region=='USN'}">checked="checked"</c:if>>
															<label for="air_test8">울산</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test9" name="start_region" type="radio" value="HIN" <c:if test="${searchVO.start_region=='HIN'}">checked="checked"</c:if>>
															<label for="air_test9">진주</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test10" name="start_region" type="radio" value="KUV" <c:if test="${searchVO.start_region=='KUV'}">checked="checked"</c:if>>
															<label for="air_test10">군산</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test11" name="start_region" type="radio" value="KPO" <c:if test="${searchVO.start_region=='KPO'}">checked="checked"</c:if>>
															<label for="air_test11">포항</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test12" name="start_region" type="radio" value="WJU" <c:if test="${searchVO.start_region=='WJU'}">checked="checked"</c:if>>
															<label for="air_test12">원주</label>
														</div>
													</li>
												</ul>
											</div>
										</dd>
									</dl>
									<a href="javascript:void(0)" class="change"><img src="/images/web/air/change.png" alt="변경"></a>
									<dl>
										<dt>
											<div class="rt-icon">
												<span class="IconSide">도착지</span>
											</div>
										</dt>
										<dd>
											<div class="value-text"><a href="javascript:void(0)" onclick="optionPopup('#air_arrival', this)" id="end_region_str">제주(CJU)</a></div>
											<div id="air_arrival" class="popup-typeA air-zone">
												<ul class="select-menu col4">
													<li>
														<div class="lb-box">
															<input id="air_test13" name="end_region" type="radio" value="GMP" <c:if test="${searchVO.end_region=='GMP'}">checked="checked"</c:if>>
															<label for="air_test13">김포</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test14" name="end_region" type="radio" value="CJU" <c:if test="${searchVO.end_region=='CJU'}">checked="checked"</c:if>>
															<label for="air_test14">제주</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test15" name="end_region" type="radio" value="PUS" <c:if test="${searchVO.end_region=='PUS'}">checked="checked"</c:if>>
															<label for="air_test15">부산</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test16" name="end_region" type="radio" value="TAE" <c:if test="${searchVO.end_region=='TAE'}">checked="checked"</c:if>>
															<label for="air_test16">대구</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test17" name="end_region" type="radio" value="KWJ" <c:if test="${searchVO.end_region=='KWJ'}">checked="checked"</c:if>>
															<label for="air_test17">광주</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test18" name="end_region" type="radio" value="CJJ" <c:if test="${searchVO.end_region=='CJJ'}">checked="checked"</c:if>>
															<label for="air_test18">청주</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test19" name="end_region" type="radio" value="MWX" <c:if test="${searchVO.end_region=='MWX'}">checked="checked"</c:if>>
															<label for="air_test19">무안</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test20" name="end_region" type="radio" value="RSU" <c:if test="${searchVO.end_region=='RSU'}">checked="checked"</c:if>>
															<label for="air_test20">여수</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test21" name="end_region" type="radio" value="USN" <c:if test="${searchVO.end_region=='USN'}">checked="checked"</c:if>>
															<label for="air_test21">울산</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test22" name="end_region" type="radio" value="HIN" <c:if test="${searchVO.end_region=='HIN'}">checked="checked"</c:if>>
															<label for="air_test22">진주</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test23" name="end_region" type="radio" value="KUV" <c:if test="${searchVO.end_region=='KUV'}">checked="checked"</c:if>>
															<label for="air_test23">군산</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test24" name="end_region" type="radio" value="KPO" <c:if test="${searchVO.end_region=='KPO'}">checked="checked"</c:if>>
															<label for="air_test24">포항</label>
														</div>
													</li>
													<li>
														<div class="lb-box">
															<input id="air_test25" name="end_region" type="radio" value="WJU" <c:if test="${searchVO.end_region=='WJU'}">checked="checked"</c:if>>
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
												<a href="javascript:void(0)" onclick="optionPopup('#air_count', this)" id="seat_person_str">전체 · 성인 1</a>
											</div>
											<div id="air_count" class="popup-typeA air-count">
												<div class="detail-area counting-area">
													<div class="counting">
														<div class="l-area">
															<strong class="sub-title">성인</strong>
															<span class="memo">만 13세 이상</span>
														</div>
						                                <div class="r-area">
						                                	<input type="hidden" name="adult_cnt" value="${searchVO.adult_cnt}" />
						                                    <button type="button" class="counting-btn" onclick="chg_person('-', 'adult')"><img src="<c:url value='/images/web/main/form/subtraction.png' />" alt="빼기"></button>
						                                    <span class="counting-text" id="adult_num">${searchVO.adult_cnt}</span>
						                                    <button type="button" class="counting-btn" onclick="chg_person('+', 'adult')"><img src="<c:url value='/images/web/main/form/addition.png' />" alt="더하기"></button>
						                                </div>				
													</div>
						                            <div class="counting">
						                                <div class="l-area">
						                                    <strong class="sub-title">소아</strong>
						                                    <span class="memo">만 2 ~ 13세 미만</span>
						                                </div>
						                                <div class="r-area">
						                                	<input type="hidden" name="child_cnt" value="${searchVO.child_cnt}" />
						                                    <button type="button" class="counting-btn" onclick="chg_person('-', 'child')"><img src="<c:url value='/images/web/main/form/subtraction.png' />" alt="빼기"></button>
						                                    <span class="counting-text" id="child_num">${searchVO.child_cnt}</span>
						                                    <button type="button" class="counting-btn" onclick="chg_person('+', 'child')"><img src="<c:url value='/images/web/main/form/addition.png' />" alt="더하기"></button>
						                                </div>
						                            </div>
						                            <div class="counting">
						                                <div class="l-area">
						                                    <strong class="sub-title">유아</strong>
						                                    <span class="memo">만 2세(24개월) 미만</span>
						                                </div>
						                                <div class="r-area">
						                                	<input type="hidden" name="baby_cnt" value="${searchVO.baby_cnt}" />
						                                    <button type="button" class="counting-btn" onclick="chg_person('-', 'baby')"><img src="<c:url value='/images/web/main/form/subtraction.png' />" alt="빼기"></button>
						                                    <span class="counting-text" id="baby_num">${searchVO.baby_cnt}</span>
						                                    <button type="button" class="counting-btn" onclick="chg_person('+', 'baby')"><img src="<c:url value='/images/web/main/form/addition.png' />" alt="더하기"></button>
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
									<button type="submit" class="btn red" id="btnSearch">
										<div class="MagGlass">
											<span class="TicSec">항공권 검색</span>
										</div>
									</button>
								</div>
							</div> <!-- //search-area -->					
					    </form>
					</div> <!-- //form-area -->
					<!-- //코드중복(include) -->
				</div>
	        </section> <!-- //search-typeA -->
	        	        
	        <!-- 항공요금 검색결과 -->
			<section>
		        <div class="air air-area" id="avSearch">
		        	<div class="inner">
		        		<!-- product_result -->
		 				<div class="product_result">
		 					<div class="side-wrap">
							    <h5 class="listTitle1">항공요금 검색결과 <br><span class="subText">* 왕복 항공편은 동일한 판매처인 경우에만 예약이 가능합니다.</span></h5>
								<div class="side-group">

									<div class="dm-filter">
										<select class="side-group" name="airline_code" id="airline_code" onchange="load_air_list();" title="항공사 선택" disabled>
											<option value="ALL" selected>항공사 전체</option>
											<option value="KE">대한항공</option>
											<option value="OZ">아시아나</option>
											<option value="LJ">진에어</option>
											<option value="BX">에어부산</option>
											<option value="ZE">이스타항공</option>
											<option value="TW">티웨이항공</option>
											<option value="7C">제주항공</option>
											<option value="RS">에어서울</option>
										</select>
									</div>

									<a class="side-link" target="_blank" href="https://www.jlair.net/contents/index.php?mid=04&amp;agent_id=TAMNAO">제이엘항공 실시간 예약확인</a>
									<a class="side-link" target="_blank" href="https://air.dcjeju.net/air/login">선민투어 항공 실시간 예약확인</a>

								</div>
								<div class="air-result"> 
								    <!--가는편-->
								    <div class="lArea">
								        <h5 class="date"><img src="<c:url value='/images/web/air/go.png' />" width="25" height="24" alt="가는항공편"></h5>
										<div class="air-list">
								            <div class="loading">
								            	<%-- 
								                <ul class="jl_com">
								                    <li class="title"><span>제이엘항공</span> <span><img src="<c:url value='/images/web/air/sideBar.gif' />" alt="|"></span></li>
								                    <li class="air2"><img src="<c:url value='/images/web/air/line2.gif' />" height="13" alt="아시아나"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
								                    <li class="air3"><img src="<c:url value='/images/web/air/line3.gif' />" height="13" alt="진에어"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
													<li class="air5"><img src="<c:url value='/images/web/air/line5.gif' />" height="13" alt="이스타"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
								                    <li class="air6"><img src="<c:url value='/images/web/air/line6.gif' />" height="13" alt="티웨이"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
								                    <li class="air7"><img src="<c:url value='/images/web/air/line7.gif' />" height="13" alt="제주항공"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
													<li class="air8"><img src="<c:url value='/images/web/air/line8.gif' />" height="13" alt="에어서울"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
								                </ul>
								                <ul class="jc_com">
								                    <li class="title"><span>제주닷컴</span> <span><img src="<c:url value='/images/web/air/sideBar.gif' />" alt="|"></span></li>
								                    <li class="air1"><img src="<c:url value='/images/web/air/line1.gif' />" height="13" alt="대한항공"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
								                    <li class="air2"><img src="<c:url value='/images/web/air/line2.gif' />" height="13" alt="아시아나"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
								                    <li class="air3"><img src="<c:url value='/images/web/air/line3.gif' />" height="13" alt="진에어"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
								                    <li class="air4"><img src="<c:url value='/images/web/air/line4.gif' />" height="13" alt="부산에어"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
													<li class="air5"><img src="<c:url value='/images/web/air/line5.gif' />" height="13" alt="이스타"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
								                    <li class="air6"><img src="<c:url value='/images/web/air/line6.gif' />" height="13" alt="티웨이"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
								                    <li class="air7"><img src="<c:url value='/images/web/air/line7.gif' />" height="13" alt="제주항공"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
													<li class="air8"><img src="<c:url value='/images/web/air/line8.gif' />" height="13" alt="에어서울"> <img class="load" src="<c:url value='/images/web/air/loading_off.gif' />" alt="로딩"></li>
								                </ul>
								                --%>
								            </div>
								        </div>								        
								        		        
										<div class="dm-list-head">
											<div class="dm-date">
												<div class="date-arrow">
													<a href="javascript:void(0)" class="btn-prev" id="prevDate" onclick="prevDate('go')">
														<i class="xi-angle-left-min"></i>
													</a>
													<a href="javascript:void(0)" class="btn-next" id="nextDate" onclick="nextDate('go')"> 
														<i class="xi-angle-right-min"></i>
													</a>
												</div>
												<span class="active" >
												</span>
											</div>
										</div>
								        <div class="air-list">								        
								            <div class="list-wrap">
								                <div class="table-scroll">
								                    <table id="goWrap" class="commCol air-line">
								                        <thead>
								                            <tr class="tr_table_fix_header">
								                                <th class="title1 header"> 항공사편 <a class="down"><img src="/images/web/air/down_02.png"  alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png"  alt="올림"></a></th>
																<th class="title2 header"> 출발시간 <a class="down"><img src="/images/web/air/down_02.png"  alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png"  alt="올림"></a></th>
																<th class="title3 header"> 도착시간 <a class="down"><img src="/images/web/air/down_02.png"  alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png" alt="올림"></a></th>
																<th class="title4 header"> 운임종류 <a class="down"><img src="/images/web/air/down_02.png" alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png" alt="올림"></a></th>
																<th class="title5 header"> 좌석 <a class="down"><img src="/images/web/air/down_02.png" alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png"  alt="올림"></a></th>
																<th class="title6 header"> 요금 <a class="down"><img src="/images/web/air/down_02.png" alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png"  alt="올림"></a></th>
																<th class="title7 header"> 업체선택 <a class="down"><img src="/images/web/air/down_02.png" alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png"  alt="올림"></a></th>
								                            </tr>
								                        </thead>
								                        <tbody id="go_flight">

															<!-- 0921 로딩바 개선 -->
															<div class="loadingAir-wrap hide">
																<div class="spinner-con"></div>
															</div><!-- //0921 로딩바 개선 -->

									                        <div id="init_start_div" class="no-item">
									                        	<div class="txt2">검색 조건에 해당하는 항공권이 없습니다.</div>										
															</div>
								                        </tbody>
								                    </table>
								                </div>						            
								            </div>
								        </div>
								    </div>				    
								    
								    <!--오는편-->
									<div class="one-search" style="display: none;">
										<div class="ico"></div>
										<div class="txt1">편도를 선택하셔서 검색되는 항공권이 없습니다.</div>
										<div class="txt2">도착일을 선택하시고 검색해 주세요.</div>
									</div>
																	    
								    <div class="rArea">
								        <h5 class="date"><img src="<c:url value='/images/web/air/go.png' />" width="25" height="24" alt="오는항공편"></h5>
										<div class="air-list">
								            <div class="loading"></div>
								        </div>
										<div class="dm-list-head">
											<div class="dm-date">
												<div class="date-arrow">
													<a href="javascript:void(0)" class="btn-prev" id="prevDate" onclick="prevDate('come')">
														<i class="xi-angle-left-min"></i>
													</a>
													<a href="javascript:void(0)" class="btn-next" id="nextDate" onclick="nextDate('come')">
														<i class="xi-angle-right-min"></i>
													</a>
												</div>
												
												<span class="active" >
												</span>
											</div>
									        <div class="air-list">
									            <div class="list-wrap">
									                <div class="table-scroll">
									                    <table id="comeWrap" class="commCol air-line">
									                        <thead>
									                            <tr class="tr_table_fix_header">
									                                <th class="title1 header"> 항공사편 <a class="down"><img src="/images/web/air/down_02.png"  alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png" alt="올림"></a></th>
																	<th class="title2 header"> 출발시간 <a class="down"><img src="/images/web/air/down_02.png"  alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png"  alt="올림"></a></th>
																	<th class="title3 header"> 도착시간 <a class="down"><img src="/images/web/air/down_02.png"  alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png"  alt="올림"></a></th>
																	<th class="title4 header"> 운임종류 <a class="down"><img src="/images/web/air/down_02.png" alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png"  alt="올림"></a></th>
																	<th class="title5 header"> 좌석 <a class="down"><img src="/images/web/air/down_02.png"  alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png"  alt="올림"></a></th>
																	<th class="title6 header"> 요금 <a class="down"><img src="/images/web/air/down_02.png"  alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png"  alt="올림"></a></th>
																	<th class="title7 header">업체선택 <a class="down"><img src="/images/web/air/down_02.png"  alt="내림"></a> <a class="up"><img src="/images/web/air/up_02.png"  alt="올림"></a></th>
									                            </tr>
									                        </thead>
									                        <tbody id="come_flight">

																<!-- 0921 로딩바 개선 -->
																<div class="loadingAir-wrap hide">
																	<div class="spinner-con"></div>
																</div><!-- //0921 로딩바 개선 -->

									                        	<div id="init_end_div" class="no-item">
									                        		<div class="txt2">검색 조건에 해당하는 항공권이 없습니다.</div>
																</div>
									                        </tbody>
									                    </table>
									                </div><!-- //table-scroll --> 
									            </div>
									        </div>
										</div>							
								    </div>
								</div>		          
							</div>
		 				</div> <!-- //product_result -->
					
	 					<!-- 선택한 항공 스케줄 -->
		 				<div class="journey" id="choice_air_info">
						    <h5 class="listTitle1">선택한 항공 스케줄</h5>
							<table class="commCol ui-data-table add1">
								<caption>
									선택한 항공 스케줄
								</caption>
								<colgroup>
									<col style="width: 220px;">
									<col style="width: 197px;">
									<col style="width: 210px">
									<col style="width: 210px">
									<col style="width: 111px">
									<col style="width: 127px">
									<col style="width: 118px">
								</colgroup>
								<thead>
									<tr>
										<th>여정</th>
										<th>항공편</th>
										<th>출발일시</th>
										<th>도착일시</th>
										<th>좌석구분</th>
										<th>총요금</th>
										<th>요청좌석</th>
									</tr>
								</thead>
								<tbody>
									<tr id="choice_go_info">
										<td id="choice_go" colspan="7">
											<span>출발편을 선택해 주세요.</span>
										</td>
									</tr>
									<tr id="choice_come_info">
										<td id="choice_come" colspan="7">
											<span>도착편을 선택해 주세요.</span>
										</td>
									</tr>
								</tbody>
							</table><!-- //선택한 항공 스케줄 -->		
											    
						    <div class="payWrap">
						    
						    	<!-- 가는 항공편 / 오는 항공편 -->
						        <div class="jourList">
						            <div class="go">
										<h4 class="title">가는 항공편_1인기준</h4>
						                <table class="commCol">
						                    <thead>
						                        <tr>
						                            <th>항목</th>
													<th>항공운임</th>
													<th>유류할증료</th>
													<th>제세공과금</th>
													<th>발권수수료</th>
													<th>인원</th>
													<th>총액운임</th>
						                        </tr>
						                    </thead>
						                    <tbody>
						                        <tr>
						                            <td>성인</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0명</td>
						                            <td>0원</td>
						                        </tr>
						                        <tr>
						                            <td>소아</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0명</td>
													<td>0원</td>
						                        </tr>
						                    </tbody>
						                </table>
						            </div>
						            <div class="come">
						                <h4 class="title">오는 항공편_1인기준</h4>
						                <table class="commCol">
						                    <thead>
						                      	<tr>
													<th>항목</th>
													<th>항공운임</th>
													<th>유류할증료</th>
													<th>제세공과금</th>
													<th>발권수수료</th>
													<th>인원</th>
													<th>총액운임</th>
												</tr>
						                    </thead>
						                    <tbody>
						                        <tr>
						                            <td>성인</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0명</td>
						                            <td>0원</td>
						                        </tr>
						                        <tr>
						                            <td>소아</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0원</td>
						                            <td>0명</td>
													<td>0원</td>
						                        </tr>
						                    </tbody>
						                </table>
						            </div>
						        </div>
						        <!--결제-->
						        <div class="payForm bl">
						            <form name="reserve_step1_form" method="post" target="_blank" action="https://www.jlair.net/contents/index.php">
						                <input type="hidden" name="mid" value="01" />
										<input type="hidden" name="job" value="insert" />
										<!-- 제이엘항공에서 구분하기 위해 추가(2016-07-07, By jdongs) -->
										<input type="hidden" name="agent_id" value="TAMNAO" />
										<input type="hidden" name="step2_go_air_info" value="" />
										<input type="hidden" name="step2_come_air_info" value="" />
										<input type="hidden" name="step2_adult_cnt" value="1" />
										<input type="hidden" name="step2_child_cnt" value="0" />
										<input type="hidden" name="step2_baby_cnt" value="0" />
										
						                <!-- view -->
						                <ul class="air-price">
						                    <li>
						                        <h4 class="title">선택인원</h4>
						                        <p class="person"></p>
						                    </li>
						                    <li>
						                        <h4 class="title">총 결제금액</h4>
						                        <p class="total"><span class="price">0</span>원 <span class="pay-info">(유료할증료/제세공과금 포함)</span></p>
						                    </li>
						                    <li class="buy">
						                        <div class="air-list">
						                            <p class="logo">
						                            	<span class="h-color">판매처 ㅣ</span>
						                            	<%-- <img id="airLogoImg" class="" src="<c:url value='/images/web/air/jl2.png' />" alt="">&nbsp; --%>
						                            	<img id="airLogoImg" class="" src="" alt="">&nbsp;
						                            </p>
						                            <p class="bt"><a class="cancel" onclick="air_choice_reset(); ">다시선택</a>
						                            	<a href="#reserve_step2_go" onclick="go_reserve_step2(); return false;">예약하기</a>
						                            </p>
						                        </div>
						                    </li>
						                </ul>
						            </form>
						        </div>
						        <!-- //payForm --> 
						
						        <!-- 제주닷컴 예약 폼 -->
	                            <form name="jejucom_reserve" action="https://www.jeju.com/item/air_list.html">
	                            	<input type="hidden" name="flight_scity" value="" />	<!-- 출발공항코드 -->
									<input type="hidden" name="flight_ecity" value="" />	<!-- 도착공항코드 -->
									<input type="hidden" name="flight_sdate" value="" />	<!-- 첫째구간 일정 YYYY-MM-DD -->
									<input type="hidden" name="flight_edate" value="" />	<!-- 둘째구간 일정(편도일땐 필요없음) YYYY-MM-DD -->
									<input type="hidden" name="boarding_adult" value="1" />	<!-- 성인 탑승객수 -->
									<input type="hidden" name="boarding_junior" value="0" /><!-- 소아 탑승객수 -->
									<input type="hidden" name="boarding_baby" value="0" />	<!-- 유아 탑승객수 -->
									<input type="hidden" name="isMain" value="1" />			<!-- 무조건 "1" 값 전달 -->
									<input type="hidden" name="flight_type" value="2" />	<!-- 1:편도 or 2:왕복 -->
									<input type="hidden" name="agt" value="tamnao" />		<!--제주닷컴에서 부여해준 업체코드 -->
									<input type="hidden" name="flight_com[]" value="" />	<!-- 항공사코드. 누락되면 전체항공사 검색 -->
									<input type="hidden" name="id_1" value="" />			<!-- 첫번째 구간 선택한 스케줄 (avail_list > avail > id) -->
									<input type="hidden" name="id_2" value="" />			<!-- 두번째 구간 선택한 스케줄 (avail_list > avail > id) -->
	                            </form>
	                            <!-- 제주닷컴 예약 폼 -->

								<!--선민투어 예약 폼-->
								<form name="sunmin_reserve">
									<input type="hidden" name="landing_url" value="" />
									<input type="hidden" name="go_q" value="" />
									<input type="hidden" name="come_q" value="" />
								</form>
								<!--// 선민투어 예약 폼 -->

		                        <!-- 총가격 계산용 -->
	                            <form name="temp_air">
									<input type="hidden" name="go_adult_total_price" value="0" />
									<input type="hidden" name="go_child_total_price" value="0" />
									<input type="hidden" name="come_adult_total_price" value="0" />
									<input type="hidden" name="come_child_total_price" value="0" />
								</form>
								<!-- 총가격 계산용 -->
						    </div>
						    
							<!-- 항공 예약시 유의사항 -->
							<div class="info">
								<h4 class="tit">항공 예약시 유의사항</h4>
								<div class="txt">
									ㆍ <strong class="comm-color1">즉시결제하지 않으시면 예약이 자동취소됩니다.</strong><br>
									ㆍ <strong class="comm-color1">예약 후 일정/인원/시간/항공사 변경, 불가하며 취소후 재예약하셔야 합니다.</strong><br>
									ㆍ <strong class="comm-color1">항공사로부터 확정된 결항/지연된 항공권은 사이트상 임의로 취소시 수수료 면제가 불가합니다.</strong><br>
									ㆍ 아시아나항공 김포-부산, 부산-제주 구간의 경우 에어부산과 공동운항됩니다. 아시아나항공 마일리지적립은 가능하며 항공편은 에어부산의 항공을 이용합니다.<br>
									ㆍ 잔여석은 실시간 변동이 있으며, 항공사 사정에 따라 항공스케줄이 변동될 수 있습니다.<br>
									ㆍ 출·도착 시각은 현지 시각 기준이며 항공기 스케줄은 정부인가 조건으로, 예고 없이 변경 될 수 있습니다.<br>
									ㆍ 소아 및 유아 할인 적용은 아래와 같이 <strong class="comm-color1">탑승일 기준</strong> 할인 적용 가능 합니다.<br>
									ㆍ 소아-만 2세(만 24개월) ~만 13세 미만<br>
									ㆍ 유아-생후 7일 이상 ~ 만 2세(만 24개월)미만<br>
									ㆍ <strong class="comm-color1">탑승 수속 시 생년월일 확인 가능한 서류 지참 필수 (등본, 가족관계증명서)</strong><br>
									ㆍ 유아는 좌석이 제공되지 않으므로 좌석이 필요한 유아는 소아로 예매하여야 하며 소아운임이 적용됩니다.<br>
									ㆍ 구매 후 탑승시점에 유류할증료가 인상되어도 차액을 징수하지 않으며 인하되어도 환급되지 않습니다.<br>
									ㆍ 항공권 예약변경은 불가능하며, 예약한 항공권을 취소 후 항공권을 재 구매하셔야 합니다.<br>
									ㆍ 국내선 항공권 예약취소는 출발 20분전까지 예약확인/결제 메뉴에서 직접 취소가 가능하며, 출발 이후에는 유선을 통하여 취소가 가능합니다.
								</div>
							</div><!-- //항공 예약시 유의사항 -->
						</div>
					</div> <!-- //Fasten -->
				</div> <!-- //검색 결과 -->
			</section>			
	    </div> <!-- //subContents -->
	</div> <!-- //subContainer -->


</main>
<div id="widget-container" style="display:none;"></div>
<script type="text/javascript" src="<c:url value='/js/air.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/air_step1.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/align_tablesorter.js?version=${nowDate}'/>"></script>

<script type="text/javascript">
	var goToCome = ""; // 가는날/오는날 구분자 변수
	var nowDate = ""; //기준날짜
	var dateStr = ""; // 날짜 String 변수

	function fn_Search_LayerClose(){
		$("#air_count").hide();
	}

	// 가는항공편, 오는항공편 날짜 이동 ◀ 클릭 시
	function prevDate(goToCome) {
		if(goToCome == "go"){		//가는항공편
			nowDate = $('input[name=start_date]').val();
		}else{	//오는항공편
			nowDate = $('input[name=end_date]').val();
		}
		
		var date = new Date(nowDate);
		var prevDate = date.getDate() -1; //하루전날
		
		date.setDate(prevDate); //하루전날로 날짜 Setting
		
		dateStr = dateToStr(date); //날짜 String 변환 ex) YYYY-MM-DD
		date = dateToStr(new Date());
		
		if(goToCome == "go"){		//가는항공편
			if(date <= dateStr){
				$('input[name=start_date]').val(dateStr);
			}
		}else{	//오는항공편
			if($('input[name=start_date]').val() <= dateStr){
				$('input[name=end_date]').val(dateStr);
			}
		}
		
		$('form[name=air_search_form]').submit();
	}
	
	//가는항공편, 오는항공편 날짜 이동 ▶ 클릭 시
	function nextDate(goToCome) {
		if(goToCome == "go"){		//가는항공편
			nowDate = $('input[name=start_date]').val();
		}else{	//오는항공편
			nowDate = $('input[name=end_date]').val();
		}	
		
		var date = new Date(nowDate); //현재날짜
		var nextDate = date.getDate() +1; //다음날
		
		date.setDate(nextDate); //다음날로 날짜 Setting
		
		dateStr = dateToStr(date); //날짜 String 변환 ex) YYYY-MM-DD
		
		if(goToCome == "go"){		//가는항공편
			$('input[name=start_date]').val(dateStr);
			if(dateStr >= $('input[name=end_date]').val()){
				$('input[name=end_date]').val(dateStr);			
			}
		}else{	//오는항공편
			$('input[name=end_date]').val(dateStr);
		}
		
		$('form[name=air_search_form]').submit();	
	}
	
	function dateToStr(format)
	{
	    var year = format.getFullYear();
	    var month = format.getMonth() + 1;
	    var date = format.getDate();
	
	    if(month<10) month = '0' + month;
	    if(date<10) date = '0' + date;
	
	    format = year + "-" + month + "-" + date;
	    
	    return format;
	}
	
	var getContextPath = "${pageContext.request.contextPath}";
	
	//편도일 경우 오는날 날짜 hide
	function airtype_click(value) {	
		if(value == "OW"){ //편도
			$("input[name=end_date]").hide();
			$("#air_typeRT").prop("checked", false);
			$("#air_typeOW").prop("checked", true);
			$("#choice_come").hide();
			$(".one-search").show();
			$(".rArea").hide();
			$(".come").hide();
		}else{ //왕복
			$("input[name=end_date]").show();
			$("#air_typeRT").prop("checked", true);
			$("#air_typeOW").prop("checked", false);
			$("#choice_come").show();
			$(".one-search").hide();
			$(".rArea").show();
			$(".come").show();
		}
	}
	
	$(document).ready(function(){	
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
	
		//항공편 정렬
		//$(".air-line").tablesorter( {sortList: [[1,0]]} );
		$(".air-line").tablesorter();
		
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
			var divCont = $(".content");
			if(divPop.has(e.target).length == 0){
				divPop.hide();
				return;
			}
			if(divCont.has(e.target).length == 0){
				divCont.hide();
				return;
			}		
		});
		
		// 왕복, 편도 클릭 시 
	  	$(' .check-area li').on('click', function() {
	  		$('.lb-ch').removeClass("active")
	  		$(this).addClass("active");
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
		
		// 다른 일정 검색 클릭 시 ON
	  	$('.air_research_btn').on('click', function() {
	  		$('.search-typeA').show();
	  		$('.air_research_btn').hide();
	  		$('.air_research_btn_off').show();
	 	});
	 	
		// 다른 일정 검색 클릭 시 OFF
	  	$('.air_research_btn_off').on('click', function() {
	  		$('.search-typeA').hide();
	  		$('.air_research_btn_off').hide();
	  		$('.air_research_btn').show();
	 	});		
	
		airtype_click($('input[name=trip_type]:checked').val());
		$('input[name=start_region]:checked').change();
		$('input[name=end_region]:checked').change();
		modify_seat_person();
		$('form[name=air_search_form]').submit();
	
	});
</script>

<jsp:include page="/web/foot.do" flush="false"></jsp:include>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'uINg123WTGW-CJnqg-nx4Q'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>