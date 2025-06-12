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
	<jsp:param name="title" value="제주여행 공공플랫폼 탐나오, 자주하는 문의(FAQ)"/>
   	<jsp:param name="description" value="제주도 항공권, 숙박, 렌터카, 관광지 최저가예약 관련 문의. 제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영"/>
   	<jsp:param name="keywords" value="실시간 항공,숙박,렌터카,관광지,맛집,여행사,레저,체험,특산기념품"/>
</jsp:include>
<meta property="og:title" content="제주여행 공공플랫폼 탐나오, 자주하는 문의(FAQ)">
<meta property="og:url" content="https://www.tamnao.com/mw/coustomer/qaList.do">
<meta property="og:description" content="제주도 항공권, 숙박, 렌터카, 관광지 최저가예약 관련 문의. 제주여행 공공플랫폼 탐나오 | 제주특별자치도관광협회 운영">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>"> --%>
<link rel="canonical" href="https://www.tamnao.com/web/coustmer/qaList.do"/>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do">
		<jsp:param name="headTitle" value="자주하는 문의(FAQ)"/>
	</jsp:include>
</header>
<!-- 헤더 e -->
<script type="text/javascript">
	<!-- Channel Plugin Scripts -->
	(function () {
		var w = window;
		if (w.ChannelIO) {
			return (window.console.error || window.console.log || function () {
			})('ChannelIO script included twice.');
		}
		var ch = function () {
			ch.c(arguments);
		};
		ch.q = [];
		ch.c = function (args) {
			ch.q.push(args);
		};
		w.ChannelIO = ch;

		function l() {
			if (w.ChannelIOInitialized) {
				return;
			}
			w.ChannelIOInitialized = true;
			var s = document.createElement('script');
			s.type = 'text/javascript';
			s.async = true;
			s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
			s.charset = 'UTF-8';
			var x = document.getElementsByTagName('script')[0];
			x.parentNode.insertBefore(s, x);
		}

		if (document.readyState === 'complete') {
			l();
		} else if (window.attachEvent) {
			window.attachEvent('onload', l);
		} else {
			window.addEventListener('DOMContentLoaded', l, false);
			window.addEventListener('load', l, false);
		}
	})();
	ChannelIO('boot', {
		"pluginKey": "62a3a6fb-54cf-4be8-a55e-81525bfefd17",
		"memberId" : "${userId}",
		"profile"  : {
			"name" : "${userNm}",
			"email": "${email}",
			"mobileNumber" : "${mobileNumber}"
			// "CUSTOM_VALUE_1": "VALUE_1", //any other custom meta data
			// "CUSTOM_VALUE_2": "VALUE_2"
		},
		"hideChannelButtonOnBoot": true
	});

	function fn_ChannelTalkOpen() {
		if ('${channelTalkOutDayCnt}' != '0'){
			alert("현재 1:1채팅 상담이 가능하지 않습니다.");
			return;
		}

		ChannelIO('showMessenger');
	}

	function fn_ChangeList(nIdx){
		var i=0;

		for ( i=1; i<=9; i++) {
			if(i==nIdx){
				$("#list"+i).show();
				$("#btnList"+i).addClass("active");
			}else{
				$("#list"+i).hide();
				$("#btnList"+i).removeClass("active");
			}

		}

	}
</script>

<!-- 콘텐츠 s -->
<h2 class="sr-only">서브콘텐츠</h2>
<section id="subContent">

	<div class="menu-bar">
		<p class="btn-prev"><img src="<c:url value='/images/mw/common/btn_prev.png'/>" width="20" alt="이전페이지"></p>
		<h2>자주묻는 질문</h2>
	</div>
	<div class="sub-content">
		<!-- 0718 채널(상담톡) 오픈 -->
<%--			<div class="operation_guide">--%>
<%--				<div class="operation_guide_phone cont" aria-label="전화이용">--%>
<%--					<a href="tel:1522-3454" data-react-tarea="전화상담">--%>
<%--						<div class="service-icon">--%>
<%--							<img src="../../images/mw/faq/customer-call.png" alt="전화">--%>
<%--						</div>--%>
<%--						<div class="service-txt">--%>
<%--							1544-6240 <br><span>전화상담</span>--%>
<%--						</div>--%>
<%--					</a>--%>
<%--				</div>--%>
<%--				<div class="operation_guide_chat cont" aria-label="채널톡이용">--%>
<%--					<a href="#" onclick="fn_ChannelTalkOpen()">--%>
<%--						<div class="service-icon">--%>
<%--							<img src="../../images/mw/faq/customer-talk.png" alt="상담톡">--%>
<%--						</div>--%>
<%--						<div class="service-txt">--%>
<%--							1:1 채팅상담 <br><span>채널톡 상담</span>--%>
<%--						</div>--%>
<%--					</a>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--			<div class="info_list">--%>
<%--				* 평일 09~18시 (점심시간 12~13시)<span class="closed">주말/공휴일 휴무</span>--%>
<%--			</div>--%>
		<!-- //0718 채널(상담톡) 오픈 -->

		<div class="board">

			<!--
               <div class="search">
                   <input type="text" value="검색어를 입력하세요" class="focus-value">
                   <a href="#" class="btns btn-search">검색</a>
                   <a href="#" class="btns btn-write">1:1문의</a>
               </div>
                -->

			<!-- <p class="txt">※ 자주묻는 질문 검색 결과 : 0000 관련 총 <strong>15</strong>개가 검색되었습니다.</p> -->
			<ul class="category">
				<li><a href="javascript:fn_ChangeList(1)" id="btnList1" class="active">항공</a></li>
				<li><a href="javascript:fn_ChangeList(2)" id="btnList2">숙소</a></li>
				<li><a href="javascript:fn_ChangeList(3)" id="btnList3">렌터카</a></li>
				<!-- <li><a href="javascript:fn_ChangeList(4)" id="btnList4">실시간 골프</a></li> -->
				<li><a href="javascript:fn_ChangeList(5)" id="btnList5">관광지/레저</a></li>
				<li><a href="javascript:fn_ChangeList(6)" id="btnList6">맛집</a></li>
				<li><a href="javascript:fn_ChangeList(4)" id="btnList4">여행사 상품</a></li>
<%--					<li><a href="javascript:fn_ChangeList(7)" id="btnList7">탐나오쿠폰</a></li>--%>
				<li><a href="javascript:fn_ChangeList(7)" id="btnList7">제주특산/기념품</a></li>
				<li><a href="javascript:fn_ChangeList(8)" id="btnList8">탐나는전</a></li>
				<li><a href="javascript:fn_ChangeList(9)" id="btnList9">L.POINT</a></li>
				<!-- <li><a href="javascript:fn_ChangeList(9)" id="btnList9">예약변경 및 취소</a></li> -->
			</ul>

			<!-- 항공 -->
			<div class="question-list" id="list1">
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						예약 정보 입력 시 성별 및 생년월일을 입력을 잘못했는데, 어떻게 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						국내 항공권은 성별 및 생년월일을 잘못 입력해도 실제로 탑승할때 탑승자 이름과 신분증의 이름이 일치하면 탑승이 가능합니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						할인석과 일반석이 차이는 무엇인가요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						국내선에서 제공하는 할인석은 좌석 점유율에 따라서 할인율이 변동됩니다. 일반석과 할인석은 요금 차이만 있을 뿐 다른 제약사항은 없습니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						예약번호를 잊어버렸는데, 어떻게 찾나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						마이페이지 > 항공 예약확인 페이지에서 성명과 핸드폰 번호를 입력하시면 예약번호를 확인하실 수 있습니다.<br>
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						항공 예약 시 결제를 반드시 해야 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						항공 예약 후 즉시 결제를 하시거나 발권 시한 내에 결제를 해주셔야 정상적으로 이용하실 수 있으며, 결제를 안 하신 경우는 자동 취소됩니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						 9명 이상일 경우 어떻게 예약하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						항공 좌석은 한 번에 최대 9명까지 조회, 예약이 가능하여 9명 이상 예약은 인원을 나누어 예약하셔야 합니다. 소아 단독 예약은 불가하여 반드시 성인과 함께 예약을 하셔야 합니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						세금계산서 발행이 가능한가요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						여행사는 항공사를 대신해 항공권 판매를 대행하여 고객님들께 수수료를 받기 때문에 세법상 항공권에 대한 세금계산서를 발행하지 못합니다.<br>
						또, 항공권의 경우 세금계산서 교무 의무가 면제되므로 항공사에서도 세금계산서를 발행하지 않습니다. 대신, 항공권은 영수증으로 갈음되어 증빙 서류로 활용할 수 있습니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						기상악화로 인한 취소는 어떻게 처리되나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						천재지변, 기상악화 등에 의한 예약취소의 경우 취소 수수료가 부과되지 않습니다.<br>
						단, 항공 결항 통보 없이 고객이 임의로 취소할 경우 수수료가 부과되며, 결항 통보 전까지는 공항에서 대기를 하셔야 합니다. 결항 통보는 반드시 출발 전 해당 항공사로 확인 바라며, 결항 통보 전 이동 교통수단에 대한 교통비는 개별 부담입니다.<br>
						왕복 항공권일 때 이용하는 항공사가 다를 경우 결항되지 않은 편에 대해서 취소 시 취소 수수료가 부과됩니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						일정변경과 인원변경은 어떻게 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						일정변경을 원하실 경우 취소 후 재구매를 해야 합니다.(항공좌석이 마감될 수 있으므로 잔여석이 있는지 미리 확인하셔야 합니다.)<br>
						인원이 추가되었을 경우에는 항공권 예약 페이지에서 추가로 예약 바랍니다. 인원이 줄어들었을 경우에는 취소 후 재구매를 하셔야 합니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						취소 수수료는 어떻게 되나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						취소 수수료는 항공사마다 규정이 다르며, 성인/소아 동일하게 적용됩니다.<br><br>

						ㄱ. 대한항공<br>
						- 구매 익일 ~ 출발 1시간 전 : 일반석 편도 3,000원 / 할인석 편도 5,000원 / 특가석 편도 7,000원<br>
						- 출발 1시간 전 ~ 출발시간 이후 : 일반석 편도 11,000원 / 할인석 편도 13,000원 / 특가석 편도 15,000원<br><br>

						ㄴ. 아시아나항공<br>
						- 비즈니스석, 일반석(구매 익일 ~ 출발 20분 전) : 편도 3,000원<br>
						- 할인석(구매 익일 ~ 출발 20분 전) : 편도 8,000원<br>
						- 특가석(구매 익일 ~ 출발 20분 전) : 편도 12,000원<br>
						- 출발시간 이후(NO-SHOW) : 편도 15,000원<br><br>

						ㄷ. 티웨이항공<br>
						<%-- * 일반석, 할인석<br>--%>
						- 구매 익일 ~ 출발 61일 전까지 : 일반석 편도 1,000원 / 할인석 편도 2,000원 / 비즈니스석 편도 1,000원<br>
						- 60일 전 ~ 31일 전 : 일반석 편도 3,000원 / 할인석 편도 4,000원 / 비즈니스석 편도 4,000원<br>
						- 30일 전 ~ 8일 전 : 일반석 편도 6,000원 / 할인석 편도 7,000원 / 비즈니스석 편도 6,000원<br>
						- 7일 전 ~ 2일 전 : 일반석 편도 11,000원 / 할인석 편도 12,000원 / 비즈니스석 편도 11,000원<br>
						- 1일 전 ~ 당일 출발 1시간 전 : 일반석 편도 13,000원 / 할인석 편도 14,000원 / 비즈니스석 편도 18,000원<br>
						- 당일 출발 이후(NO-SHOW) : 일반석, 할인석 편도 15,000원 / 비즈니스석 편도 20,000원<br>
						* 특가석<br>
						- 구매 익일 ~ 당일 출발 전 : 변경-편도 15,000원 / 취소-운임의 100% 징수<br>
						- 당일 출발 이후(NO-SHOW) : 운임의 100% 징수<br><br>

						ㄹ. 진에어<br>
						- 구매 익일 ~ 출발 61일 전 : 일반석 편도 1,000원 / 할인석 편도 2,000원 / 특가석 편도 3,000원<br>
						- 60일 전 ~ 31일 전 : 일반석 편도 3,000원 / 할인석 편도 4,000원 / 특가석 편도 5,000원<br>
						- 30일 전 ~ 15일 전 : 일반석 편도 4,000원 / 할인석 편도 6,000원 / 특가석 편도 7,000원<br>
						- 14일 전 ~ 2일 전 : 일반석 편도 8,000원 / 할인석 편도 9,000원 / 특가석 편도 10,000원<br>
						- 1일 전 ~ 출발 시간 전 : : 일반석 편도 10,000원 / 할인석 편도 12,000원 / 특가석 편도 14,000원<br>
						- 출발 시간 이후 : 일반석, 할인석, 특가석 편도 15,000원<br><br>

						ㅁ. 제주항공<br>
						- 구매시점 24시간 이후 ~ 출발 61일 전 : 일반석, 할인석, 특가석 편도 2,000원 / 비즈니스석 편도 1,000원<br>
						- 60일 전 ~ 31일 전 : 일반석, 할인석, 특가석 편도 4,000원 / 비즈니스석 편도 3,000원<br>
						- 30일 전 ~ 15일 전 : 일반석, 할인석, 특가석 편도 6,000원 / 비즈니스석 편도 5,000원<br>
						- 14일 전 ~ 8일 전 : 일반석, 할인석, 특가석 편도 10,000원 / 비즈니스석 편도 9,000원<br>
						- 7일 전 ~ 2일 전 : 일반석, 할인석, 특가석 편도 12,000원 / 비즈니스석 편도 11,000원<br>
						- 1일 전 : 일반석, 할인석, 특가석 편도 14,000원 / 비즈니스석 편도 13,000원<br>
						- 출발 당일(출발 1시간 이내 ~ NO-SHOW 포함) : 일반석, 할인석, 특가석, 비즈니스석 편도 15,000원<br><br>

						ㅂ. 에어부산<br>
						- 구매 익일 ~ 출발 61일 전 : 일반석 편도 1,000원 / 할인석,특가석 편도 2,000원<br>
						- 60일 전 ~ 31일 전 : 일반석 편도 1,000원 / 할인석, 특가석 편도 4,000원<br>
						- 30일 전 ~ 15일 전 : 일반석 편도 3,000원 / 할인석, 특가석 편도 6,000원<br>
						- 14일 전 ~ 3일 전 : 일반석 편도 5,000원 / 할인석, 특가석 편도 9,000원<br>
						- 2일 전 ~ 출발 1시간 전 : 일반석 편도 10,000원 / 할인석, 특가석 편도 12,000원<br>
						- 출발 1시간 이내 ~ 출발 시간 이후(NO-SHOW) : 일반석, 할인석, 특가석 편도 15,000원<br><br>

						ㅅ. 에어서울<br>
						- 구매 익일 ~ 출발 61일 전 : 일반석 편도 1,000원 / 할인석, 특가석 편도 2,000원<br>
						- 60일 전 ~ 31일 전 : 일반석 편도 2,000원 / 할인석, 특가석 편도 4,000원<br>
						- 30일 전 ~ 15일 전 : 일반석 편도 3,000원 / 할인석, 특가석 편도 6,000원<br>
						- 14일 전 ~ 2일 전 : 일반석 편도 5,000원 / 할인석, 특가석 편도 8,000원<br>
						- 1일 전 ~ 출발 1시간 전 : 일반석 편도 12,000원 / 할인석, 특가석 편도 13,000원<br>
						- 출발시간 이후(NO-SHOW) : 일반석, 할인석, 특가석 편도 15,000원<br>
						* 특가석(A)<br>
						- 구매 익일 ~ 출발시간 이후(NO-SHOW) : 편도 15,000원<br><br>

						ㅇ. 이스타항공<br>
						- 구매 익일 ~ 출발 61일 전 : 일반석, 할인석 편도 2,000원<br>
						- 60일 전 ~ 31일 전 : 일반석, 할인석 편도 4,000원<br>
						- 30일 전 ~ 8일 전 : 일반석 편도 8,000원 / 할인석 편도 10,000원<br>
						- 7일 전 ~ 2일 전 : 일반석 편도 12,000원 / 할인석 편도 13,000원<br>
						- 1일 전 ~ 출발 1시간 전 : 일반석, 할인석 편도 14,000원<br>
						- 출발시간 이후(NO-SHOW) : 일반석, 할인석 편도 20,000원<br>
						* 특가석<br>
						- 구매 익일 ~ 당일 출발 전 : 변경-편도 15,000원 / 취소-운임의 100% 징수<br>
						- 당일 출발 이후(NO-SHOW) : 운임의 100% 징수<br>
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						항공권 결제 완료 후 취소는 어떻게 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						[ 제이엘항공 ] <br />
						마이페이지 > 나의 예약/구매 내역 > 항공 제휴사 페이지 접속 > 예약확인 > 상세보기 > ‘취소’ 버튼 클릭 > 취소 관련 내용 확인 후 ‘확인’ 버튼 클릭 <br />
						<img src="/images/mw/faq/jlm11.png" width="300" alt="예약확인"/><br />
						<img src="/images/mw/faq/jlm22.png" width="300" alt="비회원 예약확인"/><br />
						<img src="/images/mw/faq/jlm33.png" width="300" alt="비회원 검색조건"/><br />
						<img src="/images/mw/faq/jlm44.png" width="300" alt="예약내용"/><br />
						<img src="/images/mw/faq/jlm55.png" width="300" alt="탑승객정보"/>
						<br /><%--<br /><br />
						[ 제주닷컴 ]<br />
						마이페이지 > 나의 예약/구매 내역 > 항공 제휴사 페이지 접속 > 예약확인 > 상세내역보기 > ‘예약/결제취소’ 버튼 클릭 > 수수료 관련 내용 확인 후 ‘예약/결제취소’ 버튼 한 번 더 클릭<br />
						<img src="/images/mw/faq/jejum11.png" width="300" alt="비회원 예약화인"/><br />
						<img src="/images/mw/faq/jejum22.png" width="300" alt="예약내역"/><br />
						<img src="/images/mw/faq/jejum33.png" width="300" alt="예약확인/결제"/><br />--%>
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						환불기간 및 방법이 어떻게 되나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						항공 예약은 카드 결제이므로 결제 취소 후 영업일 기준 약 3일~5일 사이에 해당 카드사로부터 자동 환불이 됩니다. <br>
						카드 환불이 늦어질 경우 카드사로 직접 문의 바랍니다.
					</span>
					</dd>
				</dl>
			</div>

			<!-- 숙박 -->
			<div class="question-list" id="list2" style="display: none;">
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						예약 후 숙박업체로 예약확인 전화를 해야 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						탐나오 숙박 예약은 실시간 예약으로 예약과 동시에 결제를 하셔야 하며, 결제가 정상적으로 이루어지면 숙소에 별도로 전화를 안 하셔도 예약이 확정됩니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						취소하고 싶은데 환불규정은 어떻게 되나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						탐나오는 오픈마켓으로 업체마다 취소 수수료 규정이 다릅니다. 상세페이지에 안내되어 있는 숙소별 규정을 숙지하시고 예약하시기 바랍니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						예약변경 및 취소는 어떻게 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						숙박 예약 변경은 변경되는 날짜에 대한 예약 가능 여부에 따라서 달라질 수 있으므로 예약 변경은 직접 할 수 없으며, 취소 후 재구매를 하셔야 합니다.<br>
						예약취소는 마이페이지 > 나의 예약/구매내역 > 예약 상세 보기에서 취소 요청을 하시면 해당 숙소에서 취소 처리를 하며, 결제된 금액은 자동 취소됩니다. 이때 취소수수료 규정에 따라서 취수 수수료를 제외한 금액만큼 결제 취소가 됩니다.<br>
						결제 자동 취소가 안되는 경우는 별도로 안내해드리며 고객님의 환불계좌로 환불 처리됩니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						예약 변경, 취소 등 예약 관련 문의는 어디로 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						탐나오는 오픈마켓으로 예약취소 및 변경 관련 문의는 숙소로 직접 하셔야 합니다.
					</span>
					</dd>
				</dl>
			</div>

			<!-- 렌터카 -->
			<div class="question-list" id="list3" style="display: none;">
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
                                                                                   예약자와 운전자가 같아야 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
                                                                                   예약자와 실제 운전자가 달라도 렌터카 대여는 가능합니다.<br>
                                                                                   차량 인수 시 현장에서 예약자 정보로 예약 확인이 진행되며, 운전하실 분은 별도로 운전자 등록을 하시면 됩니다. 운전자는 최대 2인까지 등록 가능하며, 도로교통법상 유효한 운전면허증을 반드시 소지하여야 합니다.(렌터카 상품별 대여 조건에 부합한 운전자만 운전자 등록이 가능합니다.)
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						외국인도 렌터카 대여가 가능한가요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						렌터카 업체에 따라 외국인은 대여가 제한될 수 있으며, 예약 전 대여 가능 여부 확인이 필요합니다.<br>
                                                                                   대여가 가능한 업체는 외국인의 경우 여권사본 및 유효기간 내의 국제면허증(제네바 및 비엔나 협약국 발급) 또는 국내 면허증(취득일 기준 최소 1년 이상)을 소지해야 하며, 한국어 및 영어로 의사소통이 가능해야 합니다.<br>
                                                                                   국내 면허증을 취득하였더라도 업체에 따라 추가 서류를 요구할 수 있으니, 예약 전 업체로 대여 절차를 확인해주시기 바랍니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						렌터카 인수와 반납은 어떻게 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						2016년 9월 1일부터 제주공항 렌터카 하우스 내 대여 업무가 종료되어 렌터카 회사의 차고지에서 차량 인수 및 반납이 가능합니다.<br>
                                                                                   제주공항 5번 게이트 부근 렌터카 종합안내센터로 이동하여 렌터카 업체에서 운행하는 셔틀버스를 탑승한 후 차고지까지 이동하시면 됩니다.<br>
                                                                                   셔틀버스 탑승 관련 안내 메시지는 대게 차량 인수 하루 전 업체에서 전송합니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						렌터카 예약한 후 렌터카 업체로 예약 확인 전화를 해야하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						탐나오 렌터카 예약은 실시간 예약으로 예약과 동시에 결제를 하셔야 하며, 결제가 정상적으로 이루어지면 렌터카 업체에 별도로 전화를 안 하셔도 예약이 확정됩니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						취소하고 싶은데 환불 규정은 어떻게 되나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						탐나오는 오픈마켓으로 업체마다 취소 수수료 규정이 다릅니다. 상세페이지에 안내되어 있는 렌터카 업체별 규정을 숙지하시고 예약하시기 바랍니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						예약변경 및 취소는 어떻게 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						예약 변경은 변경되는 날짜에 대한 예약 가능 여부에 따라서 달라질 수 있으므로 직접 변경할 수 없으며, 취소 후 재구매를 하셔야 합니다.<br>
						예약취소는 마이페이지 > 나의 예약/구매내역 > 예약 상세 보기에서 취소 요청을 하시면 해당 렌터카 업체에서 취소 처리를 하며, 결제된 금액은 자동 취소됩니다. 이때 취소수수료 규정에 따라서 취수 수수료를 제외한 금액만큼 결제 취소가 됩니다.<br>
						결제 자동 취소가 안되는 경우는 별도로 안내해드리며 고객님의 환불계좌로 환불 처리됩니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						면허증 분실시 어떻게 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						렌터카 대여 시 면허증 지참은 필수 사항이나, 부득이하게 면허증을 분실하셨을 경우에는 가까운 경찰서 또는 정부24(www.gov.kr) 사이트에서 [운전경력증명서]를 발급받아 인수 시 지참해주시면 됩니다.<br>
						(면허증 및 대체 서류를 지참하지 아니한 경우, 렌터카 인수가 거절되며 당일 고객 귀책의 사유로 취소 처리 및 수수료가 발생됩니다.)
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						자차보험은 무엇이고, 요금은 얼마인가요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						기본적으로 렌터카 예약 시 종합보험(대인/대물/자손)은 가입되어 있으나 자차보험은 고객님의 선택사항입니다.<br>
                           					자차보험이란 자기 차에 대한 보험이라는 뜻입니다. 자신의 실수로 자신의 차가 파손된 경우에 보험처리를 하여 수리비를 보험사로부터 받는 것인데, 보통 상대방 부주의로 사고가 발생했다 하더라도 쌍방 과실이 적용되니 가입해두는 것이 좋습니다. <br>
						렌터카 회사마다 보험료는 다를 수 있으므로 차량 상세페이지 내 보험안내를 참고하시면 됩니다.<br>
						자차보험은 선택사항으로 차량 인수 시 가입 여부 결정 후 계약서를 작성하시면 됩니다.
					</span>
					</dd>
				</dl>
			</div>


			<!-- 여행사 상품 -->
			<div class="question-list" id="list4" style="display: none;">
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						여행사 상품 구매는 어떻게 해야 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						여행사 상품은 1인 요금 상품과 2인 이상 상품으로 구성된 상품이 있음으로 사전에 숙지 후 구매하셔야 합니다.<br>
							1인 요금 기준으로 판매되는 상품인 경우는 여행 인원수에 맞추어 수량을 구매해주셔야 됩니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						여행사 상품 구매 후 사용 방법은 어떻게 되나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						여행사 상품은 비실시간 상품으로 구매가 이루어지면 해당 판매 여행사에서 고객님의 구매 내역을 확인하고, 구매 내역에 따라 고객님과 예약 상담을 한 후 예약이 확정됩니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						구매한 상품의 취소 및 변경은 어떻게 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						구매한 상품의 취소는 마이페이지 > 나의 예약/구매내역 > 상품 상세보기에서 취소 요청을 하시면 해당 판매 여행사에서 취소 처리를 해드립니다.<br>
						구매한 상품의 예약 변경은 불가하며 취소 후 재구매를 하셔야 합니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						예약 변경, 취소 등 예약 관련 문의는 어디로 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						탐나오는 오픈마켓으로 예약 변경, 취소 등 예약 관련 문의는 해당 상품 판매 여행사로 직접하셔야 합니다.
					</span>
					</dd>
				</dl>
			</div>

			<!-- 관광지/레저 -->
			<div class="question-list" id="list5" style="display: none;">
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						관광지/레저 입장권 구매는 어떻게 해야하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						관광지/레저 입장권은 1인 요금 기준으로 판매되고 있으므로 여행 인원수에 맞추어 구매해주셔야 합니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						관광지/레저 입장권 구매 후 사용방법은 어떻게 되나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						관광지 입장 시 탐나오 예약 문자를 보여주시면 입장 가능합니다.
						사전 예약 필수인 관광지도 있으니 상세페이지 사용방법을 반드시 숙지해 주시기 바랍니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						구매한 상품의 취소 및 변경은 어떻게 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						구매한 상품의 취소는 마이페이지 > 나의 예약/구매내역 > 상품 상세 보기에서 취소 요청을 하시면 해당 판매처에서 취소 처리를 해드립니다.<br>
							구매한 상품의 예약 변경은 불가하며 취소 후 재구매를 하셔야 합니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						예약 변경, 취소 등 예약 관련 문의는 어디로 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						탐나오는 오픈마켓으로 예약 변경, 취소 등 예약 관련 문의는 해당 관광지 또는 판매처로 직접하셔야 합니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						사용하지 못한 입장권 환불은 어떻게 해야 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						관광지에 따라 취소 수수료가 발생할 수 있사오니 상품 상세페이지에서 취소/환불 규정을 숙지해주시기 바랍니다.<br>
						상품 내용에 명시된 유효기간이 지난 입장권은 환불되지 않습니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						관광지 현장에서 바로 구매해도 사용이 가능한가요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						관광지 특성에 따라서 현장에서 구매 후 바로 사용이 안되는 관광지들이 있습니다. 상품 상세 페이지에서 구매 후 사용 가능한 시간을 명시하고 있으니 확인 후 구매 바랍니다.
					</span>
					</dd>
				</dl>
			</div>

			<!-- 음식/뷰티 -->
			<div class="question-list" id="list6" style="display: none;">
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						음식/뷰티 이용권 구매는 어떻게 해야 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						음식/뷰티 이용권은 1인 요금 기준으로 판매되고 있으므로 이용 인원수에 맞추어 구매해주셔야 합니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						음식/뷰티 이용권 구매 후 사용방법은 어떻게 되나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						업체 입장 시 탐나오 예약 문자를 보여주시면 이용이 가능합니다.<br>
						사전 예약 필수인 업체도 있으니 상세페이지 사용방법을 반드시 숙지해 주시기 바랍니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						구매한 상품의 취소 및 변경은 어떻게 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						구매한 상품의 취소는 마이페이지 > 나의 예약/구매내역 > 상품 상세 보기에서 취소 요청을 하시면 해당 판매처에서 취소 처리를 해드립니다.<br>
							구매한 상품의 예약 변경은 불가하며 취소 후 재구매를 하셔야 합니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						예약 변경, 취소 등 예약 관련 문의는 어디로 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						탐나오는 오픈마켓으로 예약 변경, 취소 등 예약 관련 문의는 해당 업체 또는 판매처로 직접하셔야 합니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						사용하지 못한 이용권 환불은 어떻게 해야 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						업체에 따라 취소 수수료가 발생할 수 있사오니 상품 상세페이지에서 취소/환불 규정을 숙지해주시기 바랍니다.<br>
						상품 내용에 명시된 유효기간이 지난 이용권은 환불되지 않습니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						이용권을 현장에서 바로 구매해도 사용이 가능한가요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						업체 특성에 따라서 현장에서 구매 후 바로 사용이 안되는 이용권들이 있습니다. 상품 상세 페이지에서 구매 후 사용 가능한 시간을 명시하고 있으니 확인 후 구매 바랍니다.
					</span>
					</dd>
				</dl>
			</div>

			<!-- 탐나오 쿠폰 -->
<%--				<div class="question-list" id="list7" style="display: none;">--%>
<%--					<dl>--%>
<%--						<dt>--%>
<%--							<span><em>Q</em></span>--%>
<%--							<span>--%>
<%--							탐나오 쿠폰은 어떻게 발행받을 수 있나요?--%>
<%--						</span>--%>
<%--						</dt>--%>
<%--						<dd>--%>
<%--							<span><em>A</em></span>--%>
<%--							<span>--%>
<%--							최초 회원가입 시 다양한 할인 쿠폰을 제공해드립니다.--%>
<%--						</span>--%>
<%--						</dd>--%>
<%--					</dl>--%>
<%--					<dl>--%>
<%--						<dt>--%>
<%--							<span><em>Q</em></span>--%>
<%--							<span>--%>
<%--							탐나오 쿠폰 사용방법은 어떻게 되나요?--%>
<%--						</span>--%>
<%--						</dt>--%>
<%--						<dd>--%>
<%--							<span><em>A</em></span>--%>
<%--							<span>--%>
<%--							상품예약페이지 [적용가능쿠폰]에서 선택하여 이용이 가능합니다. 탐나오 쿠폰은 현금으로 환불되지 않습니다.--%>
<%--						</span>--%>
<%--						</dd>--%>
<%--					</dl>--%>
<%--					<dl>--%>
<%--						<dt>--%>
<%--							<span><em>Q</em></span>--%>
<%--							<span>--%>
<%--							구매한 상품을 취소한 경우 쿠폰 환불은 어떻게 되나요?--%>
<%--						</span>--%>
<%--						</dt>--%>
<%--						<dd>--%>
<%--							<span><em>A</em></span>--%>
<%--							<span>--%>
<%--							구매한 상품을 취소한 경우 탐나오 쿠폰도 함께 환원을 시켜드립니다.--%>
<%--						</span>--%>
<%--						</dd>--%>
<%--					</dl>--%>
<%--				</div>--%>

			<!-- 제주특산/기념품 -->
			<div class="question-list" id="list7" style="display: none;">
				<h3 class="title">배송관련</h3>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						배송중인 상품의 위치를 알고 싶어요.
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						[마이페이지 > 나의 예약/구매 내역]에서 구매내역 상세로 들어가신 후 [배송조회] 버튼을 클릭하시면 확인하실 수 있습니다.<br>
						택배 운송장 번호가 등록된 후 배송 중 상태가 되면 SMS를 발송해 드립니다.
					</span>
					</dd>
					<dt>
						<span><em>Q</em></span>
						<span>
						이미 주문을 했는데 배송지를 변경하고 싶어요.
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						배송지 변경은 [마이페이지 > 나의 예약/구매 내역]에서 구매내역 상세로 들어가신 후 [배송지 변경] 버튼을 클릭하여 변경할 수 있습니다.<br>
						단, 배송지 변경은 상품이 발송되기 전 “결제 완료” 상태에서만 변경할 수 있으며, 상품이 발송된 이후에는 [배송지 변경] 버튼이 사라집니다.<br>
						※ 배송 중인 상태에서는 배송지 변경 불가합니다.
					</span>
					</dd>
					<dt>
						<span><em>Q</em></span>
						<span>
						주문한 상품의 배송조회가 안 돼요.
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						대형 상품이나 특수 제작한 상품의 경우 일반 택배사를 이용하지 않을 수 있기 때문에 배송조회가 불가할 수 있습니다. 정확한 배송 현황은 해당 상품의 판매자에게 문의하면 확인하실 수 있습니다.
					</span>
					</dd>
					<dt>
						<span><em>Q</em></span>
						<span>
						여러 상품을 구매했는데 일부만 배송되었어요.
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						상품에 따라 서로 다른 판매처에서 배송되며, 같은 판매처라도 주문 수량이 많은 경우 여러 박스로 분리되어 개별 발송될 수 있습니다.
					</span>
					</dd>
					<dt>
						<span><em>Q</em></span>
						<span>
						여러가지 상품 주문 시, 묶음배송이 가능한가요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						배송 상품은 상품별로 각각 배송되고 있어 묶음 배송이 불가합니다.<br>
						※ 동일한 상품일지라도 구매 번호가 다른 상품 역시 묶음배송으로 배송되지 않습니다.<br>
						※ 다만, 같은 업체에서 같은 배송비 정책을 통해 판매되고 있는 상품은 묶음 상품으로 배송됩니다.
					</span>
					</dd>
					<dt>
						<span><em>Q</em></span>
						<span>
						배송비는 얼마인가요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						배송비는 판매처 및 상품에 따라 각각 다르게 부과되며, 상품의 종류(부피, 무게)와 판매자와 택배사간의 계약조건 등에 따라 다르게 책정됩니다.<br>
						상품의 배송비는 상품 설명 내 '배송비'에서 확인 가능합니다.
					</span>
					</dd>
					<dt>
						<span><em>Q</em></span>
						<span>
						배송비는 상품별로 각각 적용되나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						배송비는 상품별로 각각 부과되며, 판매처나 상품에 따라 다르게 책정됩니다.<br>
						※ 여러 상품을 같이 구매하더라도 배송비는 상품별로 각각 부과됩니다.<br>
						※ 동일한 상품이더라도 판매처에 따라 상품 금액과 배송비가 다르게 책정될 수 있음을 양지하여 주시기 바랍니다.
					</span>
					</dd>
				</dl>

				<h3 class="title">반품/교환/환불</h3>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						판매자 정보는 어디서 확인하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						판매처 정보는 구매하신 상품페이지 내 판매처 정보에서 확인하실 수 있습니다.
					</span>
					</dd>
					<dt>
						<span><em>Q</em></span>
						<span>
						상품을 교환하고 싶어요. 어떻게 해야 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						교환은 배송 완료 후 7일 이내 가능하며, 해당 상품의 판매처에 직접 문의하시면 확인 가능합니다.
					</span>
					</dd>
					<dt>
						<span><em>Q</em></span>
						<span>
						주문한 상품을 취소하고 싶은데 어떻게 해야 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						배송 상태에 따라<br>
						1) “결제 완료” 상태인 경우 [취소] 버튼을 클릭하여 배송 전 취소 가능<br>
						2) “배송 중”~”배송 완료”인 경우 배송 완료 7일 이내 반품 접수 가능<br>
						※ 반품 접수는 해당 상품의 판매처에 직접 문의하시면 확인 가능합니다.
					</span>
					</dd>
					<dt>
						<span><em>Q</em></span>
						<span>
						반품이나 교환은 어느 택배사를 이용하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						반품 혹은 교환 시 이용해야 할 택배사는 판매처에 따라 다릅니다. 해당 상품의 판매처에 직접 문의하시면 안내받으실 수 있습니다.
					</span>
					</dd>
					<dt>
						<span><em>Q</em></span>
						<span>
						여러 상품을 한꺼번에 주문했는데, 부분 취소가 가능한가요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						[마이페이지 > 나의 예약/구매 내역]에서 부분 취소가 가능합니다. 단, 상품단위 혹은 묶음 상품 단위로만 취소할 수 있습니다.
					</span>
					</dd>
				</dl>
			</div>
			<!-- 탐나는전 -->
			<div class="question-list" id="list8" style="display: none;">
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
							탐나는전이란?
						</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
							탐나는전은 지역 내 자금의 역외유출을 막고, 지역 내 소비촉진을 통한 지역 상권 보호와 경제 활성화를 위해 제주특별자치도에서 발행하고 제주특별자치도 가맹점에서만 사용할 수 있는 제주 전용 지역화폐입니다.
						</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						탐나는전은 어떻게 발급하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
							1) 제주BC 체크카드 <br/>
							- 온라인 신청 : 탐나는전 앱에서 '탐나는전 체크카드(제주)'를 선택 후 신청 ▷ 앱 메인화면에 '카드등록' 선택 ▷ 앱에서 카드 관리<br/>
						    - 오프라인 신청 : 제주은행 영업점 방문 ▷ 탐나는전 체크카드 발급 ▷ 탐나는전 앱 등록 및 충전<br/>
							2) 나이스 선불카드<br/>
						    - 온라인 신청 : 탐나는전 앱에서 '탐나는전 선불카드'를 선택 후 신청 ▷ 앱 메인화면에 '카드등록' 선택 ▷ 앱에서 카드 관리<br/>
						    - 오프라인 신청 : 영업점 방문(도내 제주은행 전지점, 농협, 신협, 새마을금고) ▷ 카드발급 ▷ 탐나는전 앱에 등록 및 충전<br/>
							3) 지류(종이상품권)형<br/>
						    - 오프라인 신청 : 도내 제주은행 전지점, 농협, 신협, 새마을금고 영업점 방문 ▷ 10% 할인 혜택 받고 지류상품권 구매(5천원, 1만원, 5만원권)<br/>
						    ▷ 할인 혜택받은 상품권 사용하여 알뜰 소비
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						탐나는전으로 어떤 상품을 결제할 수 있나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
							탐나는전 가맹점으로 등록되어 있는 업체의 상품 구매 시 결제 가능합니다.<br/>
							결제 전 탐나는전 결제 가능 상품인지 확인이 필요하며, 단일 상품만 결제 가능합니다.(탐나는전은 부분취소가 불가하여 옵션 복수 선택 시에는 결제가 되지 않습니다.)
						</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
							결제는 어떻게 하나요?
						</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
							1) 탐나는전 결제 가능 상품인지 확인합니다. (상품 이미지에서 탐나는전 라벨 확인)<br/>
							2) 결제 페이지에서 탐나는전 사용 여부를 결정합니다.<br/>
							3) 탐나는전 앱으로 연결하여 결제를 진행합니다.<br/>
							- PC: 탐나는전 앱 내에서 '모바일 결제' 실행<br/>
							- 모바일: 탐나오 홈페이지 내에서 [탐나는전 결제] 버튼 클릭 시, 탐나는전 앱으로 연결되어 결제 진행
						</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						결제 후 취소는 어떻게 하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
							탐나오 홈페이지-마이 탐나오-나의 예약/구매 내역-예약/구매 번호 클릭 후 '취소 요청'을 하시면 해당 업체에서 취소 처리를 하며, 수수료 규정에 따라 취소 수수료를 제외한 금액만큼 취소 접수됩니다.
						</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
							취소 시 환불은 어떻게 진행되나요?
						</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
							1) 결제 전체 금액 환불인 경우: 탐나는전 카드 취소 진행<br/>
							2) 수수료 제외 후 일부 금액 환불인 경우: 계좌번호로 환불 진행
						</span>
					</dd>
				</dl>
			</div>
			<!-- L.POINT -->
			<div class="question-list" id="list9" style="display: none;">
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						L.POINT 서비스란?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						L.POINT는 롯데멤버스에서 운영하는 온라인 통합 멤버십 서비스로, 탐나오 상품 결제 시 L.POINT 적립과 L.POINT 사용 중 하나를 선택해 이용하실 수 있습니다.<br>
                                                                                   L.POINT 적립을 이용하실 경우 상품 구매 시 결제 금액의 0.5%가 L.POINT로 적립되며, L.POINT 사용을 이용하실 경우 10P 단위로 최대 100%까지 사용하실 수 있습니다.<br>
                                                                                   ※ L.POINT 관련 자세한 내용은 롯데멤버스 홈페이지에서 확인 바랍니다.
					</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						L.POINT 카드는 어떻게 발급하나요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						▣ 제휴사 내방 신청 방법<br>
							- 가까운 롯데백화점 카드센터 및 롯데마트, 롯데슈퍼, 롯데면세점, 롯데하이마트에 배치된     QR코드를 통해 가입하시면 모바일 L.POINT 카드를 발급받으실 수 있습니다.
						<br><br>	
						▣홈페이지/모바일앱 신청 방법<br>
							- L.POINT 홈페이지 또는 모바일 앱에 가입하시면 L.POINT 적립/사용이 가능한 온라인/모바일카드가 자동으로 발급됩니다.	
						</span>
					</dd>
				</dl>
				<dl>
					<dt>
						<span><em>Q</em></span>
						<span>
						L.POINT 비밀번호는 무엇인가요?
					</span>
					</dt>
					<dd>
						<span><em>A</em></span>
						<span>
						'L.POINT 비밀번호'는 온라인에서 포인트를 사용하기 위해 설정된 비밀번호로, 숫자 6자리입니다.<br>
                                                                                   L.POINT Web/App 로그인 시 입력하는 비밀번호와는 별도의 비밀번호이며, L.POINT Web/App에서 언제든 간단하게 등록 및 재설정하실 수 있습니다.<br><br>
						L.POINT 비밀번호 등록 방법은 다음과 같습니다.<br><br>
						▣ L.POINT 홈페이지(https://www.lpoint.com) 로그인<br>
						[MY L > 결제 비밀번호 설정 > 본인인증 진행 후 비밀번호 설정]<br><br>
						▣ L.POINT APP 로그인<br>
						[상단 우측 ≡ 터치 > 결제비밀번호 > 본인인증 및 신규기기 등록 진행 후 비밀번호 설정]<br><br>
                                                                                   ※ L.POINT 관련 자세한 내용은 롯데멤버스 홈페이지에서 확인 바랍니다.
					</span>
					</dd>
				</dl>
			</div>
		</div>
	</div>
</section>
<!-- 콘텐츠 e -->

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
</body>
</html>