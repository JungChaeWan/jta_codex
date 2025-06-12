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
<meta name="robots" content="noindex">
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="실시간 항공 예약"/>
	<jsp:param name="keywords" value="제주, 실시간 항공, 탐나오"/>
	<jsp:param name="description" value="탐나오 실시간 항공 목록"/>
</jsp:include>
<meta property="og:title" content="실시간 항공 예약">
<meta property="og:description" content="제주, 실시간 항공, 탐나오">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" href="<c:url value='/css/mw/common.css?version=${nowDate}' />">
<%-- <link rel="stylesheet" href="<c:url value='/css/mw/style.css?version=${nowDate}' />"> --%>
</head>
<body class="main">
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do" >
		<jsp:param name="headTitle" value="항공권"/>
	</jsp:include>
</header>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<main id="main">
	<!--//change contents-->
	<div class="mw-list-area">
		<!-- 제이엘항공 예약 폼 -->
		<form name="reserve_step1_form" method="get" target="_blank" action="https://www.jlair.net/m/index.php"> <!-- https://realtime.jlair.net:444/m/index.php -->
			<input type="hidden" name="mid" value="01" />
			<input type="hidden" name="job" value="insert" />
			<!-- 앱에서 사용 -> 웹브라우져로 열리도록 하기 위해서 -->
			<input type="hidden" name="newopen" value="yes" />
			<!-- 제이엘항공에서 구분하기 위해 추가(2016-07-07, By jdongs) -->
			<input type="hidden" name="agent_id" value="TAMNAO" />
			<input type="hidden" name="step2_go_air_info" value="" />
			<input type="hidden" name="step2_come_air_info" value="" />
			<input type="hidden" name="step2_adult_cnt" value="${searchVO.adult_cnt }" />
			<input type="hidden" name="step2_child_cnt" value="${searchVO.child_cnt }" />
			<input type="hidden" name="step2_baby_cnt" value="${searchVO.baby_cnt }" />
		</form>	
		<!-- 제주닷컴 예약 폼 -->
        <form name="jejucom_reserve" method="get" target="_blank" action="https://m.jeju.com/item/air_real.html">
			<input type="hidden" name="flight_scity" value="${searchVO.start_region }" />	<!-- 출발공항코드 -->
			<input type="hidden" name="flight_ecity" value="${searchVO.end_region }" />	<!-- 도착공항코드 -->
			<input type="hidden" name="flight_sdate" value="${searchVO.start_date }" />	<!-- 첫째구간 일정 YYYY-MM-DD -->
			<input type="hidden" name="flight_edate" value="${searchVO.end_date }" />	<!-- 둘째구간 일정(편도일땐 필요없음) YYYY-MM-DD -->
			<input type="hidden" name="boarding_adult" value="${searchVO.adult_cnt }" />	<!-- 성인 탑승객수 -->
			<input type="hidden" name="boarding_junior" value="${searchVO.child_cnt }" /><!-- 소아 탑승객수 -->
			<input type="hidden" name="boarding_baby" value="${searchVO.baby_cnt }" />	<!-- 유아 탑승객수 -->
			<input type="hidden" name="isMain" value="1" />			<!-- 무조건 "1" 값 전달 -->
			<input type="hidden" name="flight_type" value="2" />	<!-- 1:편도 or 2:왕복 -->
			<input type="hidden" name="agt" value="tamnao" />		<!--제주닷컴에서 부여해준 업체코드 -->
			<input type="hidden" name="flight_com[]" value="" />	<!-- 항공사코드. 누락되면 전체항공사 검색 -->
			<input type="hidden" name="id_1" value="" />			<!-- 첫번째 구간 선택한 스케줄 (avail_list > avail > id) -->
			<input type="hidden" name="id_2" value="" />			<!-- 두번째 구간 선택한 스케줄 (avail_list > avail > id) -->
			<!-- 앱에서 사용 -> 웹브라우져로 열리도록 하기 위해서 -->
			<input type="hidden" name="newopen" value="yes" />
        </form>
		<!-- 총가격 계산용 -->
		<form name="temp_air">
			<input type="hidden" name="go_adult_total_price" value="0" />
			<input type="hidden" name="go_child_total_price" value="0" />
			<input type="hidden" name="come_adult_total_price" value="0" />
			<input type="hidden" name="come_child_total_price" value="0" />
		</form>
        <!--선민투어 예약 폼-->
        <form name="sunmin_reserve">
            <input type="hidden" name="landing_url" value="" />
            <input type="hidden" name="go_q" value="" />
            <input type="hidden" name="come_q" value="" />
        </form>

		<section class="search-typeA" id="avComSection">
			<h2 class="sec-caption">항공사 검색</h2>
			<div class="form">
				<input type="hidden" id="search_com" value="" />
				<input type="hidden" id="search_flag" value="go" />
				<input type="hidden" id="trip_type" value="${searchVO.trip_type }" />
				<input type="hidden" id="seat_type" value="${searchVO.seat_type }" />
				<input type="hidden" id="start_region" value="${searchVO.start_region }" />
				<input type="hidden" id="start_date" value="${searchVO.start_date }" />
				<input type="hidden" id="end_region" value="${searchVO.end_region }" />
				<input type="hidden" id="end_date" value="${searchVO.end_date }" />
				<input type="hidden" id="adult_cnt" value="${searchVO.adult_cnt }" />
				<input type="hidden" id="child_cnt" value="${searchVO.child_cnt }" />
				<input type="hidden" id="baby_cnt" value="${searchVO.baby_cnt }" />

				<select name="airline_code" id="airline_code" class="airline_code" title="항공사 선택">
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
			</div> <!-- //form -->
		</section>
		<section class="air-list-area selected" id="goSelectSection">
			<h2 class="sec-caption">가는편 항공 리스트</h2>
			
			<div class="air-result">
				<h3 class="title-type7">가는 항공편</h3>
				<!-- 가는편 -->
			    <div class="go-wrap">
			        <div class="air-info" id="goSelectInfo">
			        </div>
			    </div> <!-- //go-wrap -->
			</div>
		</section> <!-- //air-list-area -->
		
		<section class="air-list-area" id="avListSection">
			<h2 class="sec-caption">항공 리스트</h2>
			<div class="air-result">
				<h3 class="title-type7">검색 결과</h3>
				<!-- 가는편 -->
			    <div class="go-wrap">
			        <div class="booking-wrap">
			            <div class="booking-info bt-none" id="airInfo">
			            </div>
			        </div>

					<!-- 날짜 변경 팝업 -->
					<div id="change_date" class="comm-layer-popup">
						<div class="content-wrap">
							<div class="content">
								<h3>날짜 변경</h3>
							</div>
						</div>
					</div>
			        <div class="list-wrap">
			            <div class="table-scroll">
			                <table id="goWrap" class="comm-col air-line">
			                    <thead>
			                        <tr class="tr_table_fix_header">
			                            <th class="title1">
			                                항공편
			                                <a class="down"><img src="/images/mw/air/down.gif" alt="내림"></a>
			                                <a class="up"><img src="/images/mw/air/up.gif" alt="올림"></a>
			                            </th>
			                            <th class="title2">
			                                탑승시간
			                                <a class="down"><img src="/images/mw/air/down.gif" alt="내림"></a>
			                                <a class="up"><img src="/images/mw/air/up.gif" alt="올림"></a>
			                            </th>
			                            <th class="title3">
			                                잔여석
			                                <a class="down"><img src="/images/mw/air/down.gif" alt="내림"></a>
			                                <a class="up"><img src="/images/mw/air/up.gif" alt="올림"></a>
			                            </th>
			                            <th class="title4">
			                                요금
			                                <a class="down"><img src="/images/mw/air/down.gif" alt="내림"></a>
			                                <a class="up"><img src="/images/mw/air/up.gif" alt="올림"></a>
			                            </th>
			                            <th class="title5">
											선택
											<a class="down"><img src="/images/mw/air/down.gif" alt="내림"></a>
											<a class="up"><img src="/images/mw/air/up.gif" alt="올림"></a>
										</th>
			                        </tr>
			                    </thead>
			                    <tbody id="flight_list">
			                    	<div id="init_descr_div" class="no-item hide">										
									</div>
			                    </tbody>
								<tbody id="flight_list2" style="display: none">
									<div id="init_descr_div2" class="no-item hide">
									</div>
								</tbody>
			                </table>
			            </div> <!-- //table-scroll -->
			        </div>
			    </div> <!-- //go-wrap -->
			</div>
		</section> <!-- //air-list-area -->

		<section class="air-detail-area hide" id="avSelectSection">
			<h2 class="sec-caption">항공 여정</h2>
			<div class="air-result" id="choice_air_info">
				<h3 class="title-type7">선택하신 여정</h3>
				<!-- 가는편 -->
			    <div class="go-wrap">
			        <div class="booking-wrap">
			            <div class="booking-info bt-none">
			                <span class="info1">가는 항공편</span>
			            </div>
			        </div>
			        <div class="air-info">
			        	<div>
			        		<span class="zone" id="goSelAirInfo">
			        			<%--김포 - 제주
			        			<img src="/images/mw/air/line3.gif" class="airline" alt="진에어"> 진에어 0303편--%>
			        		</span>
			        	</div>
						<div id="goSelDatetimeInfo">
							<%--<span class="date">2017년 10월 22일 14시 30분</span>
							<span class="seat">일반석</span>--%>
						</div>
			        </div>
			        <div class="air-price">
			        	<table class="table-row">
						    <caption>가격 요금표</caption>
						    <colgroup>
						        <col>
						        <col style="width: 30%">
						        <col style="width: 30%">
						    </colgroup>
						    <tbody>
						        <tr>
					                <th>구분</th>
					                <td>성인 1명</td>
					                <td>소아 1명</td>
					            </tr>
					            <tr>
					                <th>항공운임</th>
					                <td>0원</td>
					                <td>0원</td>
					            </tr>
					            <tr>
					                <th>유류할증료</th>
					                <td>0원</td>
					                <td>0원</td>
					            </tr>
					            <tr>
					                <th>공항이용료</th>
					                <td>0원</td>
					                <td>0원</td>
					            </tr>
					            <tr>
					                <th>총액</th>
					                <td>0원</td>
					                <td>0원</td>
					            </tr>
						    </tbody>
						</table>
						<div class="caption-typeB">* 1인 기준 요금입니다.</div>
			        </div>
			    </div> <!-- //go-wrap -->
			    <!-- //가는편 -->
			    
			    <!-- 오는편 -->
			    <div class="come-wrap hide" id="comeSelAirDiv">
			        <div class="booking-wrap">
			            <div class="booking-info bt-none">
			                <span class="info1">오는 항공편</span>
			            </div>
			        </div>
			        <div class="air-info">
			        	<div>
			        		<span class="zone" id="comeSelAirInfo">
			        			<%--제주 - 김포
			        			<img src="/images/mw/air/line6.gif" class="airline" alt="티웨이"> 티웨이항공 702편--%>
			        		</span>
			        	</div>
						<div id="comeSelDatetimeInfo">
							<%--<span class="date">2017년 10월 31일 10시 00분</span>
							<span class="seat">일반석</span>--%>
						</div>
			        </div>
			        <div class="air-price">
			        	<table class="table-row">
						    <caption>가격 요금표</caption>
						    <colgroup>
						        <col>
						        <col style="width: 30%">
						        <col style="width: 30%">
						    </colgroup>
						    <tbody>
						        <tr>
					                <th>구분</th>
					                <td>성인 1명</td>
					                <td>소아 1명</td>
					            </tr>
					            <tr>
					                <th>항공운임</th>
					                <td>0원</td>
					                <td>0원</td>
					            </tr>
					            <tr>
					                <th>유류할증료</th>
					                <td>0원</td>
					                <td>0원</td>
					            </tr>
					            <tr>
					                <th>공항이용료</th>
					                <td>0원</td>
					                <td>0원</td>
					            </tr>
					            <tr>
					                <th>총액</th>
					                <td>0원</td>
					                <td>0원</td>
					            </tr>
						    </tbody>
						</table>
						<div class="caption-typeB">* 1인 기준 요금입니다.</div>
			        </div>
			    </div> <!-- //come-wrap -->
			    <!-- //오는편 -->
			</div> <!-- //air-result -->

			<div class="payment-area pack">
				<div class="side-padding">
					<h4 class="title-type7">판매처</h4>
					<div class="division-typeA">
						<div class="air-company">
							<img id="airLogoImg" src="/images/mw/air/jl.jpg" alt="제이엘">
							<label id="airLogoTitle">제이엘항공</label>
						</div>
					</div>
				</div>
				<div class="side-padding">
					<h4 class="title-type7">총 결제금액</h4>
					<div class="division-typeA">
						<div class="price" id="totalPrice">0원</div>
						<div class="caption-typeC">* 유류할증료/제세공과금 포함</div>
					</div>
				</div>
								
				<div class="btn-wrap cell col46">
				    <a onclick="air_choice_reset();" class="comm-btn gray big">다시선택</a>
				    <a onclick="go_reserve_step2(); return false;" class="comm-btn red big">바로구매</a>
				</div>
			</div> <!-- //payment-area -->
			
			<div class="info-list-group">
				<h4 class="title">예약시 주의사항</h4>
				<ul class="list-disc">
			        <li class="text-red">실시간항공은 예약과 동시에 즉시 카드결제 하여야 합니다. (당일 미결제시 항공 취소될 수있습니다.)</li>
					<li class="text-red">항공사로부터 확정된 결항/지연된 항공권은 사이트상 임의로 취소시 수수료 면제가 불가합니다.</li>
					<li>항공 스케줄은 정부인가 조건이며, 정부인가 조건에 따라 예고없이 변경될 수있습니다.</li>
					<li>실시간 항공은 9명까지 예약이 가능하며 10명이상의 경우 인원을 나눠서 예약 바랍니다.</li>
			    </ul>
			</div>	
		</section> <!-- //air-detail-area -->

		<div class="loadingAir-wrap hide">
            <div class="loadingAir"></div>
		</div>
	</div> <!--//mw-list-area-->
	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->
<div id="widget-container" style="display:none;"></div>
<script type="text/javascript" src="/js/align_tablesorter.js?version=${nowDate}"></script>
<script type="text/javascript" src="/js/mw_air.js?version=${nowDate}"></script>
<script type="text/javascript" src="/js/mw_air_step1.js?version=${nowDate}"></script>
<script type="text/javascript">

$(document).ready(function(){
	//항공편 정렬
	$(".air-line").tablesorter();

	// 가는 항공 리스트
	load_go_air_list();

	// 항공사별 검색
	$('#airline_code').change(function() {
		eval('load_' + $('#search_flag').val() + '_air_list("' + $('#search_com').val() + '");');
	});

});
</script>

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" />

<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'uINg123WTGW-CJnqg-nx4Q'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</div>
</body>
</html>
