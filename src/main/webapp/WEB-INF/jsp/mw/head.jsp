<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags" %>
<script>
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


function responseRegId(regId) {
	if(isNull(regId)) {
		alert("디바이스 정보가 없습니다.");
	} else {
		$("#pushDiv").show();
		$("#verDiv").show();
		
		var parameters = "regId=" + regId;

		$.ajax({
			type:"post", 
			dataType:"json",
			url:"<c:url value='/mw/selectDeviceInfo.ajax'/>",
			data:parameters,
			success:function(data){
				$(".app-util").show();
				$("#deviceNum").val(data.deviceInfo.deviceNum);
				
				if(data.deviceInfo.pushYn == "Y") {
					$(".app-util dl dd").html("<a href='javascript:fn_PushOff();'><img src='/images/mw/common/on.png' alt='ON'></a>");
				} else {
					$(".app-util dl dd").html("<a href='javascript:fn_PushOn();'><img src='/images/mw/common/off.png' alt='OFF'></a>");
				}
			}
		});
	}
}

function fn_PushOn() {
	var parameters = "pushYn=Y&deviceNum=" + $("#deviceNum").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/mw/updateDevicePush.ajax'/>",
		data:parameters,
		success:function(data){
			$(".app-util dl dd").html("<a href='javascript:fn_PushOff();'><img src='/images/mw/common/on.png' alt='ON'></a>");
		}
	});
}

function fn_PushOff() {
	var parameters = "pushYn=N&deviceNum=" + $("#deviceNum").val();
	
	$.ajax({
		type:"post", 
		dataType:"json",
		url:"<c:url value='/mw/updateDevicePush.ajax'/>",
		data:parameters,
		success:function(data){
			$(".app-util dl dd").html("<a href='javascript:fn_PushOn();'><img src='/images/mw/common/off.png' alt='OFF'></a>");
		}
	});
}

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

/* 미결제 상품 바로가기 : 미사용처리
function fn_DtlRsv(rsvNum){
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
			//$("#main").css("margin-top", $(".top_fix").height() + "px" );
			return false;
		});
	}

	if(itemSize > 1) {
		topBannerSlider();
	}
	//$("#main").css("margin-top", $(".top_fix").height() + "px" );
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

//뒤로가기
function fn_GoBack(){
	if (window.location.href.indexOf("/mw/ad/productList.do") !== -1) {
		location.href="/mw/stay/jeju.do";
	} else{
		history.back();
	}
}

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
        if("${partner}" == 'visitjeju'  && st < 50){
			$('.head-wrap').css("top", 50 - st  + "px")
		}else{
			$('.head-wrap').css("top","0")
		}

    } else {
        // Scroll Up
        if(st + $(window).height() < $(document).height()) {
            $('.head-wrap').removeClass('nav-up').addClass('nav-down');
			if("${partner}" == 'visitjeju' && st < 50){
				$('.head-wrap').css("top", 50 - st  + "px")
			}else{
				$('.head-wrap').css("top","0")
			}
        }
    }
    lastScrollTop = st;    
});

$(document).ready(function(){
	
	/* 미결제 상품 안내 문구 : 미사용처리
	if(${!empty unpaidRsvNum}) {
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
	
	// 상단 배너
	//topBanner();
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
<!-- 헤더 s -->
<c:if test="${menuNm ne '특산/기념품'}">
	<div class="head-wrap" <c:if test="${partner eq 'visitjeju'}">style="top:50px;"</c:if>>
		<c:if test="${not empty menuNm}">
			<div class="title">${menuNm}</div>
		</c:if>
		<c:if test="${empty menuNm}">
			<div class="title"><a href="/mw/main.do" title="홈으로 가기"><img src="/images/mw/main/main_logo_2.png" alt="탐나오"></a></div>
		</c:if>
		<div class="l-area">
			<a href="javascript:fn_GoBack();" class="back" title="뒤로가기"></a>
		</div>
		<div class="r-area-side">
			<button type="button" class="side-btn" title="사이드메뉴 열기" id="frame_sideOpen2"></button>
		</div>
	</div>
</c:if>

<c:if test="${menuNm eq '특산/기념품'}">
	<div class="m-sv head-wrap">
		<div class="title-wrap">
			<c:if test="${not empty menuNm}">
				<div class="title">${menuNm}</div>
			</c:if>
			<c:if test="${empty menuNm}">
				<div class="title"><a href="/mw/main.do" title="홈으로 가기"><img src="/images/mw/main/main_logo_2.png" alt="탐나오"></a></div>
			</c:if>
			<div class="l-area">
				<a href="javascript:history.back()" class="back" title="뒤로가기"></a>
			</div>
			<div class="r-area-side">
				<button type="button" id="frame_sideOpen" class="side-btn" title="사이드메뉴 열기"></button>
			</div>
		</div>
		<c:if test="${empty param.prdtNum}">
		<div class="menu-typeA">
			<h2 class="sec-caption">메뉴 선택</h2>
			<nav id="scroll_menuA" class="scroll-menuA">
				<div class="scroll-area">
					<ul>
						<li <c:if test="${empty param}">class="active"</c:if>><a href="<c:url value='/mw/goods/jeju.do'/>">전체</a></li>
						<c:forEach items="${cntCtgrPrdtList}" var="cntCtgrPrdtList">
							<c:if test="${cntCtgrPrdtList.ctgr != 'S700'}">
							<li <c:if test="${param.sCtgr eq cntCtgrPrdtList.ctgr}">class="active"</c:if>>
								<a href="<c:url value='/mw/sv/productList.do?sCtgr=${cntCtgrPrdtList.ctgr}'/>"><c:out value="${cntCtgrPrdtList.ctgrNm}"/></a>
							</li>
							</c:if>										
						</c:forEach>
						<c:forEach items="${crtnList}" var="crtnList" varStatus="status">
							<c:if test="${status.first}">
								<li <c:if test="${!empty param.crtnNum}">class="active"</c:if>><a href="<c:url value='/mw/sv/crtnList.do?crtnNum=${crtnList.crtnNum}'/>">슬기로운 제주쇼핑</a></li>
							</c:if>
						</c:forEach>
						<c:forEach items="${brandPrdtList}" var="brandList" varStatus="status">
							<c:if test="${status.first}">
								<li <c:if test="${!empty param.sCorpId}">class="active"</c:if>><a href="<c:url value='/mw/sv/productList.do?sCorpId=${brandList.corpId}&sFlag=Brd'/>">브랜드</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</nav>
		</div>
		</c:if>
	</div>	
</c:if>			

<%--
<c:if test="${fn:length(bannerListTop) > 0}">
	<div id="top_banner" class="top-banner swiper-container" style="display: none;">
		<ul class="swiper-wrapper">
			<c:forEach var="result" items="${bannerListTop}" varStatus="status">
				<c:if test="${empty result.imgFileNm}">
					<li class="swiper-slide" style="background-color: \#${result.bgColor};">
						<c:if test="${not empty result.url}">
						<a href="${fn:replace(result.url, "/web/", "/mw/")}" <c:if test="${result.nwd == 'Y'}">target="_blank"</c:if>>
							</c:if>
							<div class="bar-tw">
								<p class="bar-t">${result.bannerNm}</p>
							</div>
							<c:if test="${not empty result.url}">
						</a>
						</c:if>
					</li>
				</c:if>
			</c:forEach>
		</ul>
		<div class="container">
			<a href="javascript:void(0)" id="top_close" class="close"><img src="/images/mw/common/close.png" alt="닫기"></a>
		</div>
	</div>
</c:if>
</div>
--%>
<%--
<!-- top banner zone-->
<c:if test="${fn:length(bannerListTop) > 0}">
	<div id="top_banner" class="top-banner swiper-container" style="display: none;">
		<ul class="swiper-wrapper">
			<c:forEach var="result" items="${bannerListTop}" varStatus="status">
				<c:if test="${empty result.imgFileNm}">
					<li class="swiper-slide" style="background-color: \#${result.bgColor};">
						<c:if test="${not empty result.url}">
							<a href="${fn:replace(result.url, "/web/", "/mw/")}" <c:if test="${result.nwd == 'Y'}">target="_blank"</c:if>>
						</c:if>
							<div class="bar-tw">
								<p class="bar-t">${result.bannerNm}</p>
							</div>
						<c:if test="${not empty result.url}">
							</a>
						</c:if>
					</li>
				</c:if>
			</c:forEach>
		</ul>
		<div class="container">
			<a href="javascript:void(0)" id="top_close" class="close"><img src="/images/mw/common/close.png" alt="닫기"></a>
		</div>
	</div>
</c:if>
<!--// top banner zone-->
--%>

<!-- 이벤트성 광고 -->
<%--<a href="/mw/mypage/couponList.do">
<div style="margin: 0 auto; display: block; background: #e33347; color: #fff; font-family: 'NotoSans L'; letter-spacing: -.3px; height: 30px; line-height: 30px; position: relative;">
	&lt;%&ndash;<a href=""><img src="/images/mw/main/close-2.gif" alt="닫기" style="height: 10px; right: 6px; padding-right: 17px; position: absolute; top: 64px;"></a>&ndash;%&gt;
	<div style="text-align: center; font-size: 0.85rem;">제주여행 2만원 즉시할인 받기</div>
	<div style="padding-right: 17px; position: absolute; right: 6px; top: 0; font-size: 0.7rem;">보기<span style="padding-left: 4px;" >></span></div>
</div>
</a>--%>

<%-- 미결제 상품 안내 문구 : 미사용처리 
	<c:if test="${!empty unpaidRsvNum}">
	<div id="unpaidInfo" style="display: none">
		<a class="head-popup-close" href="javascript:closeUnpaidInfo('${unpaidRsvNum}');"><img src="/images/mw/main/close-2.gif" alt="닫기"></a>
		<a class="head-popup-text" href="javascript:fn_DtlRsv('${unpaidRsvNum}');"><img src="/images/mw/main/exclamation-mark.gif" alt="미결제 상품">미결제 상품이 있습니다. <span>[ 바로가기 ]</span></a>
	</div>
</c:if> --%>
<!-- 메뉴 s -->
<jsp:include page="/mw/newMenu.do"></jsp:include>
<!-- 메뉴 e -->
<!-- 헤더 e -->