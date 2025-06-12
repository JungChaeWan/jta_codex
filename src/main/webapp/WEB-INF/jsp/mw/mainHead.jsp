<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<script>

	function hasScrolled() {
		var st = $(this).scrollTop();

		// Make sure they scroll more than delta
		if(Math.abs(lastScrollTop - st) <= delta)
			return;

		// If they scrolled down and are past the navbar, add class .nav-up.
		// This is necessary so you never see what is "behind" the navbar.
		if (st > lastScrollTop && st > navbarHeight){
			// Scroll Down
			$('.head-wrap').removeClass('nav-down').addClass('nav-up');
		} else {
			// Scroll Up
			if(st + $(window).height() < $(document).height()) {
				$('.head-wrap').removeClass('nav-up').addClass('nav-down');
			}
		}
		lastScrollTop = st;
	}

/** http -> https 변환*/
if(document.location.protocol == 'http:') {
	var chkInclude = document.location.host;
	var chkPath = document.location.pathname;

	// 로그인 페이지는 java 에서 처리
	if(!chkInclude.includes("localhost") && !chkInclude.includes("dev") && !chkInclude.includes("218.157.128.119") && !chkPath.includes("mw/viewLogin.do") && !chkInclude.includes("tamnao.iptime.org") ) {
		document.location.href = document.location.href.replace("http:", "https:");
	}
}

/** 서브도메인없을경우 www 변환*/
var url1 = 'tamnao.com';
var url2 = 'www.tamnao.com';
if( url1 == document.domain ) document.location.href = document.URL.replace(url1, url2);

/** 먹깨비 */
/*if(window.location.search.indexOf("partner=mukkebi") > 0 ){
	document.location.href = "/mw/evnt/detailPromotion.do?prmtDiv=EVNT&prmtNum=PM00001496";
}*/

/**
 * App 체크
 * AA : 안드로이드 앱, AW : 안드로이드 웹, IA : IOS 앱, IW : IOS 웹
 */
function fn_AppCheck() {
	var headInfo = ("${header['User-Agent']}").toLowerCase();
	var mobile = (/iphone|ipad|ipod|android|windows phone|iemobile|blackberry|mobile safari|opera mobi/i.test(headInfo));

	if(mobile) {
		if((/android/.test(headInfo))) {
			if(/webview_android/.test(headInfo)) {
				return "AA";
			} else {
				return "AW";
			}
		} else if((/iphone|ipad|/.test(headInfo))) {
			if(!(/safari/.test(headInfo))) {
				return "IA";
			} else {
				return "IW";
			}
		}
	} else {
		return "PC";
	}
}

/* 미결제 상품 바로가기  : 미사용처리
function fn_DtlRsv(rsvNum) {
	$.cookie("unpaidInfoM", rsvNum, {path: "/"});

	location.href = "<c:url value='/mw/mypage/detailRsv.do'/>" + "?type=rsv&rsvNum=" + rsvNum;
}
function closeUnpaidInfo(rsvNum) {
	$.cookie("unpaidInfoM", rsvNum, {path: "/"});

	$("#unpaidInfo").hide();
}*/

/* 하단으로 변경
//상단 Top Banner Close
function topBanner() {
	var obj = '#top_banner';											//target
	var cookieName = 'topBanner';										//쿠키이름

	if($.cookie(cookieName)) {
		$(obj).hide();
	} else {
		$(obj).show();
	}
	var itemSize = $('#top_banner ul li').length;

	if(itemSize > 0) {
		if(("localStorage" in window) && window.localStorage != null) {
			var prevTime = localStorage.getItem(cookieName);
			var currentTime = new Date().getTime();
			var expirationDuration = 24 * 60 * 60 * 1000;		// 24h

			var notAccepted = (prevTime == undefined);
			var prevAcceptedExpired = (prevTime != undefined) && ((currentTime - prevTime) > expirationDuration);

			if(notAccepted || prevAcceptedExpired) {
				$(obj).show();
			}
		} else {
			$(obj).hide();
		}

		$("#top_close").click(function() {
			$(obj).hide();
			if(("localStorage" in window) && window.localStorage != null) {
				var currentTime = new Date().getTime();
				localStorage.setItem(cookieName, currentTime);
			}
			return false;
		});
	}

	if(itemSize > 1) {
		topBannerSlider();
	}
}
function topBannerSlider() {
	new Swiper('#top_banner', {
		paginationClickable: true,
		direction: 'vertical',
		autoplay: 5000,
		loop: true
	});
}
*/

function fn_searchVisitJejuBtClick() {
	if($.trim($("#visitjejuSearch").val()) == "") {
		alert("검색어를 입력해 주세요.");
		$("#visitjejuSearch").focus();
		return false;
	}else{
		window.open("https://m.visitjeju.net/kr/search?q=" + encodeURIComponent($("#visitjejuSearch").val()),'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes',"_self");
	}
}

$(document).ready(function(){
	var device = fn_AppCheck();
	// 모바일 웹
	if(device == "IW" || device == "AW") {
		$("#app_link_banner").show();

		$(".advertising").click(function(){
			if(device == "IW") {
				window.open("https://apps.apple.com/kr/app/%ED%83%90%EB%82%98%EC%98%A4-%EC%A0%9C%EC%A3%BC%EC%97%AC%ED%96%89%EC%8A%A4%ED%86%A0%EC%96%B4/id1489404866");
			} else {
				window.open("https://play.google.com/store/apps/details?id=kr.or.hijeju.tamnao");
			}
		});
	}

	// 상단 배너
	//topBanner();

	/* 미결제 상품 안내 문구 : 미사용처리
	if(${not empty unpaidRsvNum}) {
		// 확인 여부 체크
		var unpaidInfo = $.cookie("unpaidInfoM");

		if(unpaidInfo != "${unpaidRsvNum}") {
			var path = $(location).attr("pathname");
			// 결제, 예약상세 페이지 제외
			if(path.indexOf("order") < 0 && path.indexOf("detailRsv") < 0 ) {
				$("#unpaidInfo").show();
			}
		}
	}*/

	// Hide Header on on scroll down
	var lastScrollTop = 0;
	var delta = 5;
	var navbarHeight = $('.head-wrap').outerHeight();

	$(window).scroll(function(event){
		var st = $(this).scrollTop();

		if(Math.abs(lastScrollTop - st) <= delta)
			return;

		if (st > lastScrollTop && st > navbarHeight){
			// Scroll Down
			$('.head-wrap').removeClass('nav-down').addClass('nav-up');
		} else {
			// Scroll Up
			if(st + $(window).height() < $(document).height()) {
				$('.head-wrap').removeClass('nav-up').addClass('nav-down');
			}
		}
		lastScrollTop = st;
	});

	/*현대캐피탈 특별처리*/
	if('${ssPartnerCode}' == 'hyundai2023' ){
		$(".HomeQuickCategory_Item p").each(function() {
			console.log($(this).text());
			if($(this).text().indexOf("렌터카") >=0 || $(this).text().indexOf("특산/기념품") >=0 || $(this).text().indexOf("숙소") >=0 ){
				$(this).parent().css('display','block');
			}else{
				$(this).parent().css('opacity','0.3');
			}
		});
	}
	//$(".gnb2").show();
});
</script>

<%--비짓제주 헤더--%>
<c:if test="${partner eq 'visitjeju'}">
	<div class="visit_header">
		<div class="inner">
			<div class="visit-logo">
				<a href="https://m.visitjeju.net/kr" target="_self" title="visit jeju - 제주도 공식 관광정보 포털">
					<img src="/images/mw/main/m_visit_logo.png" alt="비짓제주">
				</a>
			</div>
			<div class="srh_area">
				<form onSubmit="return false;">
					<fieldset>
						<legend class="for-a11y">검색</legend>
						<div class="top_search">
							<input type="text" id="visitjejuSearch" placeholder="제주도 공식관광정보 검색" onkeydown="javascript:if(event.keyCode==13){fn_searchVisitJejuBtClick();}">
							<button type="button" onclick="fn_searchVisitJejuBtClick();">
								<img src="/images/mw/icon/search/m_srh_btn.png" alt="검색">
							</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</c:if>

<header id="m_header" class="mo_header react-area">
<!-- //모바일 웹만 노출 -->
<div id="m_gnb" class="mo_gnb">
	<div class="gnb_mall">
		<div class="logo">
			<a href="/mw/main.do" title="홈으로 가기"><img src="${logoUrl}" alt="탐나오"></a>
		</div>
	</div>
	<div class="gnb_util">
		<!--  <a href="javascript:void(0)" class="main-search gnb_util_m" id="top_searchOpen"></a> -->
		<!--장바구니가 실제로 들어간다면 작업 할 예정 -->
		<a href="<c:url value='/mw/cart.do' />" aria-label="topCart" class="main-cart gnb_util_m">
			<span class="cnt" id="headCartCnt2" style="display: none;"></span>
		</a>
	</div>
</div>
<div class="mo-search">
	<div class="search-wrap">
		<fieldset>
			<form id="search_form">
				<div class="search_form_inp">
					<div class="search_inpbox">
						<input type="search" name="query" id="globalSearchInput" aria-label="globalSearchInput" class="search_inpbox_inp" autocomplete="off"  readonly/>
						<button type="button" class="search_inpbox_btn" id="globalSearchButton">
							<span class="blind">검색</span>
						</button>
					</div>
				</div>
			</form>
		</fieldset>
	</div>
</div>
</header>
<!-- 메뉴 s -->
<jsp:include page="/mw/newMenu.do"></jsp:include>
<!-- 메뉴 e -->