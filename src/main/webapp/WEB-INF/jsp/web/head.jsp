<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags" %>

<%-- reCAPTCHA --%>
<script src="https://www.google.com/recaptcha/api.js?render=6LdLftQqAAAAAG4YfifMJi9NbpV5cE42WXPtHLJX"></script>
<script>
/** http -> https 변환*/
/*if(document.location.protocol == 'http:') {
	var chkInclude = document.location.host;
	var chkPath = document.location.pathname;
	// 로그인 페이지는 java 에서 처리
	if(chkInclude.indexOf("localhost") < 0 && chkInclude.indexOf("dev") < 0 && chkInclude.indexOf("218.157.128.119") < 0 && chkPath.indexOf("mw/viewLogin.do") < 0 && chkInclude.indexOf("tamnao.iptime.org") < 0) {
		document.location.href = document.location.href.replace("http:", "https:");
	}
}*/
/** main.do 모바일 변환
var chkPath = document.location.pathname;
if(chkPath.indexOf("/main.do") >= 0){
	if(fn_AppCheck() != "PC"){
		location.href = "/mw/main.do";
	}
}*/

/** 서브도메인없을경우 www 변환*/
var url1 = 'tamnao.com';
var url2 = 'www.tamnao.com';
if( url1 == document.domain ) document.location.href = document.URL.replace(url1, url2);

var getContextPath = "${pageContext.request.contextPath}";
var queryString = "${pageContext.request.queryString}";
var servletPath = "${requestScope['javax.servlet.forward.servlet_path']}";

/** 먹깨비 */
/*if(window.location.search.indexOf("partner=mukkebi") > 0 ){
	document.location.href = "/web/evnt/detailPromotion.do?prmtDiv=EVNT&prmtNum=PM00001496";
}*/

<%-- 이미지 에러시 대체 이미지 처리
function OnErrorImageNull(obj) {
	if(obj != null) {
		obj.src = "<c:url value='/images/web/comm/no_img.jpg'/>";
	}
} --%>

<%-- main menu
function mainMenu() {
	var speed = 300;
	$('#menuBT').click(function(){
		if($('.subMenu').css('display')=='none') {
			$('.subMenu').slideDown(speed);
		} else {
			$('.subMenu').slideUp(speed);
		}
	});
} --%>

<%-- right aside
function rightAside() {
	$('#floatingBT').click(function() {
		$('#rightAside').toggleClass('rightAside-open');
	});

	//상단에 배너에 따른 시작위치 추가
	if(document.getElementById('topBannerPopup')) {
		// $('#rightAside').css('top', '250px');
	}
	if($('#topBannerPopup').css('display')=='none') {
		// $('#rightAside').css('top', '140px');
	}
}; --%>

//스크롤시
$(window).scroll(function(){
	var scrollHeight = $(window).scrollTop();
	//go-top (상단으로 가기)
	if(scrollHeight > 500) {
		$(".go-top").fadeIn("slow");
	} else {
		$(".go-top").fadeOut("fast");
	}

	//leftAside (좌측 사이드 배너 고정)
	if(scrollHeight > 300) {
		$("#leftAside > ul").css({
			'position': 'fixed',
			'top': '20px'
		});
		//우측배너
		$("#rightAside > .fixed-wrap").css({
			'position': 'fixed',
			'top': '20px'
		});
	} else {
		$("#leftAside > ul").css({
			'position': 'static',
			'top': 'auto'
		});
		//우측배너
		$("#rightAside > .fixed-wrap").css({
			'position': 'static',
			'top': 'auto'
		});
	}
});

<%-- 즐겨찾기 등록
function bookmarksite(){
	var agent = navigator.userAgent.toLowerCase();

	if(navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1){
		alert("Ctrl+D키를 누르시면 즐겨찾기에 추가하실 수 있습니다.");
		return;
	}

	var bookmarkurl = "${pageContext.request.scheme}" + "://" + "${pageContext.request.serverName}";

	if(window.opera && window.print) { // opera
		var elem = document.createElement('a');
		elem.setAttribute('href',bookmarkurl);
		elem.setAttribute('title','제주여행온라인마켓, 탐나오');
		elem.setAttribute('rel','sidebar');
		elem.click();
	} else if(document.all) { // ie
		window.external.AddFavorite(bookmarkurl, '제주여행온라인마켓, 탐나오');
	} else if (window.sidebar) { // firefox
		window.sidebar.addPanel('제주여행온라인마켓, 탐나오', bookmarkurl, "");
	} else if(window.chrome) {
		alert("Ctrl+D키를 누르시면 즐겨찾기에 추가하실 수 있습니다.");
	}
} --%>

<%--가로 길이
var winWidth = window.innerWidth;
//세로길이
var winHeight = window.innerHeight;
--%>
/* tab panel (detailTabMenu1) */
function tabPanel(params) {
	var defaults = {
		container:"#tabs", //item wrap id
		firstItem:"#tabs-1" //first show item
	};

	for(var def in defaults) { //array object 확인
		if(typeof params[def] == 'undefined') {
			params[def] = defaults[def];
		} else if(typeof params[def] == 'object') {
			for(var deepDef in defaults[def]) {
				if(typeof params[def][deepDef] == 'undefined') {
					params[def][deepDef] = defaults[def][deepDef];
				}
			}
		}
	};

	var item = params.container + " ";
	$(item + ' .tabPanel').css('display', 'none');
	$(item).children(".tabPanel").eq(0).css('display', 'block');
	
	$(item + '.menuList a').each(function(index){
		$(item + '.menuList a').eq(index).click(function(){
			var show = $(this).attr('href');

			$(item + '.menuList a').removeClass('select');
			$(this).addClass('select');

			$(item + ' .tabPanel').css('display', 'none');
			$(show).css('display', 'block');

			return false;
		});
	});
}

//로그인 - 이전 url 정보포함
function fn_login() {
	if(servletPath != "/web/viewLogin.do" && servletPath != "/web/actionLogin.do") {
		var param = "?rtnUrl=" + servletPath;
		if(queryString != "") {
			param += "&" + queryString;
		}
		location.href = "<c:url value='/web/viewLogin.do'/>" + param;
	}
}

//로그인 - 이전 url 정보포함 - 사용자 로그인 전용
function fn_loginUser() {
	if(servletPath != "/web/viewLogin.do" && servletPath != "/web/actionLogin.do") {
		var param = "?mode=user&rtnUrl=" + servletPath;
		if(queryString != "") {
			param += "&" + queryString;
		}
		location.href = "<c:url value='/web/viewLogin.do'/>" + param;
	}
}

//logout
function fn_logout() {
	if(confirm("<spring:message code='common.logout.confirm' />")) {
		location.href = "<c:url value='/web/logout.do'/>";
	}
}

function show_popup(obj) {
	if($(obj).is(":hidden")) {
		$(obj).show();
		$('body').after('<div class="lock-bg"></div>');
		$('body').addClass('not_scroll');
	} else {
		$(obj).hide();
		$('.lock-bg').remove();
	}
}

function close_popup(obj) {
    $(obj).hide();
    $('.lock-bg').remove();
    $('body').removeClass('not_scroll');
}

/* 오늘 본 상품 추가
function fn_AddTodayPrdt(prdtNum, prdtNm, savePath, saveFileNm, url) {
	var cookieList = $.fn.cookieList("todayPrdt");

	var obj = new Object();
	obj.prdtNum = prdtNum;
	obj.prdtNm = prdtNm;
	obj.savePath = savePath;
	obj.saveFileNm = saveFileNm;
	obj.url = url;

	cookieList.add(obj);
}*/

function fn_AddCart(params) {

	$.ajax({
		type:"post",
		dataType:"json",
		contentType:"application/json;",
		url:"<c:url value='/web/addCart.ajax'/>",
		data:JSON.stringify({cartList:params}),
		success:function(data){
			$("#headCartCnt").html(data.cartCnt);
			//	$("#rightCartCnt").html(data.cartCnt);
			if(confirm("장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?")) {
				location.href="<c:url value='/web/cart.do'/>";
			}
		},
		error:fn_AjaxError
	});
}

//찜한 상품
function fn_AddPocket(params, gubun, chgId) {
	<c:if test="${isLogin eq 'N' or isLogin eq 'G' }">
	if(confirm('로그인 후 상품을 찜할 수 있습니다.\n로그인 하시겠습니까?')) {
		fn_login();
	}
	</c:if>
	<c:if test="${isLogin eq 'Y' }">
	$.ajax({
		type:"post",
		dataType:"json",
		contentType:"application/json;",
		url:"<c:url value='/web/mypage/addPocket.ajax'/>",
		data:JSON.stringify({pocketList :params}),
		success:function(data){
			// 찜하기 개수 변경
			fn_PocketCnt();
			// 이미지 변경
			if(gubun == 'list') {
				$('#pocket' + chgId).attr("onclick", "").html('<img src="/images/web/icon/product_like_on.png" alt="찜하기">')
			} else {
				$('#pocketBtnId').attr("onclick", "").html('<img src="/images/web/icon/product_like_on2.png" alt="찜하기">')
			}
			alert("선택하신 상품을 찜 했습니다.");
		},
		error:fn_AjaxError2
	});
	</c:if>
}

/* 각 상품 리스트에서 찜하기 */
function fn_listAddPocket(prdtDiv, corpId, prdtNum) {
	var pocket = [{
		prdtNum:prdtNum,
		prdtNm:' ',
		corpId:corpId,
		corpNm:' ',
		prdtDiv:prdtDiv
	}];
	var chgId = prdtNum != ' ' ? prdtNum : corpId;

	fn_AddPocket(pocket, 'list', chgId);
}

//즉시구매
function fn_InstantBuy(params) {
	$.ajax({
		type:"post",
		dataType:"json",
		contentType:"application/json;",
		url:"<c:url value='/web/instantBuy.ajax'/>",
		data:JSON.stringify({cartList: params}) ,
		success:function(data){
			if(data.result == "N") {
				alert("예약마감 또는 구매불가 상품입니다.");
				return;
			}
			if (data.chkPointBuyAble == "N"){
				alert("포인트 사용기간 또는 예산 한도가 초과되어 종료되었습니다.");
				return;
			}
			location.href = "<c:url value='/web/order01.do?rsvDiv=i'/>";
		},
		error:fn_AjaxError
	});
}

/*function fn_CartCnt() {

	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/web/cartCnt.ajax'/>",
		success:function(data){
			if(data.cartCnt > 0) {
				$("#headCartCnt").html(data.cartCnt);
				$("#footCartCnt").html(data.cartCnt);
			}
			//$("#rightCartCnt").html(data.cartCnt);
		}
	});
}*/

function fn_PocketCnt() {
	
	var parameters = "";
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/web/mypage/pocketCnt.ajax'/>",
		data:parameters,
		success:function(data){
			$("#headPocketCnt").html("(" + data.pocketCnt + ")");
		}
	});
}

function fn_CouponCnt() {
	
	var parameters = "";
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/web/mypage/couponCnt.ajax'/>",
		data:parameters,
		success:function(data){
			$(".coupon .cnt").text(data.pocketCnt);
		}
	});
}

function fn_CloseTopBanner() {
	$.cookie("topB", "Y", {expires: 1, path: "/"});
}

let lastClickTime = 0;
const clickDelay = 5000; // 5초 딜레이
let userScoreThreshold = 0.3; // 기준 점수

window.onload = function () {
	const currentPath = window.location.pathname;
	if (currentPath === "/web/cerca.do") {
		lastClickTime = new Date().getTime();
	}
};

function fn_searBtClick() {
	const searchValue = $.trim($("#search").val());

	if (searchValue === "") {
		alert("검색어를 입력해 주세요.");
		$("#search").focus();
		return false;
	}

	const now = new Date().getTime();
	const remainingTime = (lastClickTime + clickDelay - now) / 1000;
	if (now - lastClickTime < clickDelay) {
		alert(Math.ceil(remainingTime) + "초 이후에 검색 가능합니다.");
		return;
	}

	lastClickTime = now;

	grecaptcha.ready(function() {
		grecaptcha.execute("6LdLftQqAAAAAG4YfifMJi9NbpV5cE42WXPtHLJX", { action: "submit" }).then(function(token) {
			verifyRecaptcha(token, searchValue);
		});
	});
}

// reCAPTCHA 검증 및 자체 랜덤 키 요청
function verifyRecaptcha(token, searchValue) {
	$.ajax({
		url: "/api/recaptcha/verify.ajax",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({ recaptchaToken: token, scoreThreshold: userScoreThreshold }),
		success: function (response) {
			if (response.success) {
				const tamnaoKey = response.tamnaoKey;
				location.href = "/web/cerca.do?trova=" + encodeURIComponent(searchValue) + "&tamnaoKey=" + encodeURIComponent(tamnaoKey);
			} else {
				alert("점수가 낮아 (" + response.score + ") 추가 검증이 필요합니다.");
			}
		},
		error: function () {
			handleRecaptchaError(searchValue);
		}
	});
}

// reCAPTCHA 오류 발생 시
function handleRecaptchaError(searchValue) {
	$.ajax({
		url: "/api/recaptcha/fallbackKey.ajax",
		type: "POST",
		contentType: "application/json",
		success: function (fallbackResponse) {
			const tamnaoKey = fallbackResponse.tamnaoKey;
			location.href = "/web/cerca.do?trova=" + encodeURIComponent(searchValue) + "&tamnaoKey=" + encodeURIComponent(tamnaoKey);
		},
		error: function () {
			alert("비정상적인 접근 입니다.");
		}
	});
}

// 미결제 상품 바로가기
function fn_DtlRsv(rsvNum) {
	$.cookie("unpaidInfo", rsvNum, {path: "/"});
	location.href = "<c:url value='/web/mypage/detailRsv.do'/>?rsvNum=" + rsvNum + "&partnerCode=${ssPartnerCode}";
}

/**
 * App 체크
 * AA : 안드로이드 앱, AW : 안드로이드 웹, IA : IOS 앱, IW : IOS 웹
 */
function fn_AppCheck() {
	
	var headInfo = ("${header['User-Agent']}").toLowerCase();
	var mobile = (/iphone|ipad|ipod|android|windows phone|iemobile|blackberry|mobile safari|opera mobi/i.test(headInfo));
	if(mobile) {
		if((/android/.test(headInfo))) {		// 안드로이드
			if(/webview_android/.test(headInfo)) {
				return "AA";
			} else {
				return "AW";
			}
		} else if((/iphone|ipad|/.test(headInfo))) {			// IOS
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

//상단 Top Banner Close
function topBanner() {
	
	var obj = '#top_banner';											//target
	var cookieName = 'topBanner';										//쿠키이름
	if($.cookie(cookieName)) {
		$(obj).css("visibility","hidden");
	} else {
		$(obj).css("visibility","visible");
	}

	$("#top_close").click(function() {
		//$(obj).remove();
		$(obj).css("visibility","hidden");
		$.cookie(cookieName, 'close', {expires: 1, path: "/"});
		return false;
	});

	if($('#top_banner ul li').length > 1) {
		topBannerSlider();
	}
}

function topBannerSlider() {
	new Swiper('#top_banner', {
		paginationClickable: true,
		direction: 'vertical',
		autoplay: 20000,
		loop: true
	});
}

function fn_searchVisitJejuBtClick() {
	if($.trim($("#visitjejuSearch").val()) == "") {
		alert("검색어를 입력해 주세요.");
		$("#visitjejuSearch").focus();
		return false;
	}else{
		window.open("https://www.visitjeju.net/kr/search?q=" + encodeURIComponent($("#visitjejuSearch").val()),'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes',"_self");
	}
}

$(document).ready(function(){

	//mainMenu();
	/*fn_CartCnt();*/
	//fn_PocketCnt();
	/*fn_CouponCnt();*/
	go_top();
	topBanner();

	$('#topBannerPopup .close').click(function(){
		$('#topBannerPopup').remove();
	});

	if($(".default-accordion").length > 0) {accordion();}

	<%-- 취소 수수료 안내
	if($("#layer-1").length > 0) {layerP1();}

	//항공 (가는항공편 input check)
	if($(".airCH1").length > 0) {airCheck1();}
	//항공 (오는항공편 input check)
	if($(".airCH2").length > 0) {airCheck2();}

	//sub main slider
	if($(".product_slide").length > 0) {carousel();}

	//mypage side menu
	if($("#sub-leftMenu").length > 0) {subLeftMenu();}
	// rightAside(); --%>

	// 미결제 상품 안내 문구
	if(${not empty unpaidRsvNum}) {
		// 확인 여부 체크
		var unpaidInfo = $.cookie("unpaidInfo");

		if(unpaidInfo != "${unpaidRsvNum}") {
			// 결제 페이지에서는 제외
			var path = $(location).attr("pathname");
			if(path.indexOf("order") < 0 && path.indexOf("detailRsv") < 0 ) {
				$("#unpaidInfo").show();
			}
		}
	}

	/** 헤더 플로팅 */
	let shrinkHeader = 150;
	$(window).scroll(function() {
		if(document.body.scrollHeight > 1500){
			let scroll = getCurrentScroll();
			if ( scroll >= shrinkHeader ) {
				$('.re_header').addClass('header-floating');
			}else{
				$('.re_header').removeClass('header-floating');
			}
		}else{
			$('.re_header').removeClass('header-floating');
		}
	});
	
	/*현대캐피탈 특별처리*/
	if('${ssPartnerCode}' == 'hyundai2023' ){
		$(".menu li").each(function() {
			console.log($(this).text());
			if($(this).text().indexOf("렌트카") >=0 || $(this).text().indexOf("특산/기념품") >=0 || $(this).text().indexOf("숙소") >=0 ){
				$(this).css('display','inline-block');
			}else{
				$(this).css('opacity','0.3');
			}
		});
	}
});

function getCurrentScroll() {
	return window.pageYOffset || document.documentElement.scrollTop;
}
</script>
<%-- 0913 hidden <h1> --%>
<%--<h1 class="visuallyhidden">제주여행공공플랫폼,탐나오</h1>--%>

<%--비짓제주 헤더--%>
<c:if test="${partner eq 'visitjeju'}">
	<div class="visit_header">
		<div class="inner">
			<div class="visit-logo">
				<a href="https://www.visitjeju.net/kr" target="_self" title="visit jeju - 제주도 공식 관광정보 포털">
					<img src="/images/web/r_main/visit_logo.png" alt="비짓제주">
				</a>
			</div>
			<div class="box__service-all">
				<ul>
					<li><a href="https://www.visitjeju.net/kr/detail/list?menuId=DOM_000001718000000000" target="_self">여행지</a></li>
					<li><a href="https://www.visitjeju.net/kr/thememap/list?menuId=DOM_200000000010920" target="_self">추천</a></li>
					<li><a href="https://www.visitjeju.net/kr/jejudfs?menuId=DOM_200000000010720" target="_self">쇼핑</a></li>
					<li><a href="https://www.visitjeju.net/kr/jejuStory/unesco_one?etc=e04&amp;menuId=DOM_000001703010001000" target="_self">브랜드</a></li>
					<li><a href="https://www.visitjeju.net/kr/jejuStory/culture?tap=one&amp;menuId=DOM_000001703003001000" target="_self">여행정보</a></li>
				</ul>
			</div>
			<div class="srh_area">
				<form onSubmit="return false;">
					<fieldset>
						<legend class="for-a11y">검색</legend>
						<div class="top_search">
							<input type="text" id="visitjejuSearch" placeholder="제주도 공식관광정보 검색" onkeydown="javascript:if(event.keyCode==13){fn_searchVisitJejuBtClick();}">
							<button type="button" onclick="fn_searchVisitJejuBtClick();">
								<img src="/images/web/r_main/srh_btn2.png" alt="검색">
							</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</c:if>

	<!-- top banner zone-->
    <div id="top_banner" class="top-banner swiper-container" style="visibility: hidden">
        <ul class="swiper-wrapper">
            <c:forEach var="result" items="${bannerListTop}" varStatus="status">
                <li class="swiper-slide" style="background-color: \#${result.bgColor};">
                    <c:if test="${not empty result.url}">
                    <a href="${result.url}" <c:if test="${result.nwd == 'Y'}">target="_blank"</c:if>>
                        </c:if>
                        <c:if test="${empty result.imgFileNm}">
                            <div class="bar-tw">
                                <p class="bar-t">${result.bannerNm}</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty result.imgFileNm}">
                            <img src="${result.imgPath}${result.imgFileNm}" alt="${result.bannerNm}">
                        </c:if>
                        <c:if test="${not empty result.url}">
                    </a>
                    </c:if>
                </li>
            </c:forEach>
            <%--
			<li class="swiper-slide" style="background-color: rgb(16 15 15)">
                   <a href="/web/evnt/prmtPlanList.do">
					<div class="bar-tw">
						<p class="bar-t">탐나오 기획전!</p>
					</div>
                   </a>
               </li>
                --%>
        </ul>
        <div class="container">
            <span id="top_close" class="close" style="cursor:pointer;"><img src="/images/web/comm/btn_close.png" width="14" height="14" alt="닫기"></span>
        </div>
    </div>
<!--// top banner zone-->
<div id="_header">
	<%--<div id="topBannerPopup">
		<div class="Fasten">
			<div class="comm-fullPopup2">
				<a href="javascript:void(0)" class="option-close" onclick="close_popup('.comm-fullPopup2');"><img src="/images/web/comm/view_close.png" alt="닫기"></a>
				<img src="/images/web/comm/top_banner_view.png" alt="배너 상세">
				<a href="<c:url value='/web/signUp00.do' />" class="event-a"><img src="/images/web/comm/eventbutton_1.png" alt="회원가입 바로가기 버튼"></a>
				<a href="<c:url value='/web/mypage/useepilList.do' />" class="event-b"><img src="/images/web/comm/eventbutton_2.png" alt="상품평 작성하기 버튼"></a>
			</div>
		</div>
	</div>--%>
	<div class="re_header">
		<div class="inner">
			<div class="header-top">
				<div class="box__usermenu">
					<ul class="list__usermenu">
						<c:if test="${isLogin == 'Y'}">
						<li><b>${userNm}</b>님 환영합니다.</li>
						<li class="list-item">
							<a href="javascript:fn_logout();" class="link__usermenu">로그아웃</a>
						</li>
			<%--			<li class="list-item">
							<a href="<c:url value='/web/mypage/pocketList.do'/>">
								찜하기<span class="count" id="headPocketCnt">(0)</span>
							</a>
						</li>--%>
						</c:if>
						<c:if test="${isLogin == 'G'}">
						<li class="list-item">
							<a href="javascript:fn_logout();">비회원 로그아웃</a>
						</li>
						</c:if>
						<c:if test="${isLogin == 'N'}">
							<li class="list-item">
								<a class="link__usermenu" href="javascript:fn_login();">로그인</a>
							</li>
							<li class="list-item">
								<a class="link__usermenu" href="/web/signUp00.do">회원가입</a>
							</li>
						</c:if>
						<li class="list-item">
							<a class="link__usermenu" href="/web/coustmer/viewCorpPns.do?menuIndex=2">입점신청</a>
						</li>
						<li class="list-item">
							<a class="link__usermenu" href="/web/evnt/prmtPlanList.do?sPrmtDiv=GOVA">공고신청</a>
						</li>
						<li class="list-item">
							<a class="link__usermenu" href="/web/coustmer/qaList.do">고객센터</a>
						</li>
					</ul>
				</div>
				<h1 class="tamnao-logo">
					<a href="/" title="제주렌트카 | 숙소 | 관광지: 제주여행 공공예약플랫폼 탐나오">
						<c:choose>
							<c:when test="${logoUrl eq '/images/web/r_main/nao_logo2.png'}">
								<img src="${logoUrl}" width="194" height="53" alt="탐나오" title="제주여행 공공 플랫폼, 탐나오">
							</c:when>
							<c:otherwise>
								<img src="${logoUrl}" alt="탐나오" title="제주여행 공공 플랫폼, 탐나오">
							</c:otherwise>
						</c:choose>
					</a>
				</h1>
				<div class="srh_area">
					<form name="totalSearchForm" id="totalSearchForm" onSubmit="return false;">
						<fieldset>
							<legend class="for-a11y"> 검색</legend>
							<div class="top_search">
								<input name="search" id="search" title="검색어 입력" class="form_input" value="<c:out value='${search}'/>" onkeydown="javascript:if(event.keyCode==13){fn_searBtClick();}" placeholder="검색어를 입력해주세요">
								<button type="button" title="검색" class="srh_btn" id="searBT" onclick="javascript:fn_searBtClick();">
									<img src="/images/web/r_main/srh_btn.png" alt="검색">
								</button>
							</div>
						</fieldset>
					</form>
				</div>
				<div class="util_menu">
					<ul>
						<c:if test="${!empty unpaidRsvNum}">
						<li id="unpaidInfo" class="nopay">
							<a href="javascript:fn_DtlRsv('${unpaidRsvNum}');" class="blinking text-red">
								<span class="ico count">&nbsp;</span>
								<span class="cnt">1</span>
								<span class="txt">미결제상품</span>
							</a>
						</li>
						</c:if>
						<li class="promotion more">
							<a href="/web/evnt/prmtPlanList.do">
								<span class="ico"></span>
								<span class="txt">기획전/이벤트</span>
							</a>
						</li>
						<c:if test="${isLogin == 'Y'}">
						<li class="coupon more">
							<a href="/web/mypage/couponList.do">
								<span class="ico"></span>
								<%--<span class="cnt">0</span>--%>
								<span class="txt">쿠폰</span>
							</a>
						</li>
						</c:if>
						<li class="cart more">
							<a href="/web/cart.do">
								<span class="ico">&nbsp;</span>
								<%--<span class="cnt" id="headCartCnt">0</span>--%>
								<span class="txt">장바구니</span>
							</a>
						</li>
						<li class="mypage more">
							<a href="/web/mypage/rsvList.do">
								<span class="ico">&nbsp;</span>
								<span class="txt">마이탐나오</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="gnb2">
		<div class="inner">
			<div class="box__service-all">
				<ul class="menu">
					<li><a href="<c:url value='/web/av/mainList.do'/>">항공</a></li>
					<%--<li><a href="<c:url value='/web/sp/vesselList.do'/>">선박</a></li>--%>
					<li><a href="<c:url value='/web/stay/jeju.do'/>">숙소</a></li>
					<li><a href="<c:url value='/web/rentcar/jeju.do'/>">렌트카</a></li>
					<li><a href="<c:url value='/web/tour/jeju.do?sCtgr=C200'/>">관광지</a></li>
					<li><a href="<c:url value='/web/tour/jeju.do?sCtgr=C300'/>">맛집</a></li>
					<li><a href="<c:url value='/web/sp/packageList.do'/>">여행사 상품</a></li>
					<li><a href="<c:url value='/web/goods/jeju.do'/>">특산/기념품</a></li>
					<%--<li><a href="<c:url value='/web/tour/jeju.do?sCtgr=C270'/>">체험</a></li>--%>
					<%--<li><a href="<c:url value='/web/evnt/prmtPlanList.do'/>">기획전</a></li>
					<li><a href="<c:url value='/web/evnt/promotionList.do'/>">이벤트</a></li>--%>
					<li><a href="<c:url value='/web/sv/sixIntro.do'/>">제주 농부의 장</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
