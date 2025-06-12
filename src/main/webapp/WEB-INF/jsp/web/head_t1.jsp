<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%-- reCAPTCHA --%>
<script src="https://www.google.com/recaptcha/api.js?render=6LdLftQqAAAAAG4YfifMJi9NbpV5cE42WXPtHLJX"></script>
<script type="text/javascript">
var getContextPath = "${pageContext.request.contextPath}";
var queryString = "${pageContext.request.queryString}";
var servlet_path = "${requestScope['javax.servlet.forward.servlet_path']}";
//가로 길이
var winWidth = window.innerWidth;
//window.outerWidth;
//세로길이
var winHeight = window.innerHeight;
//window.outerHeight;

//top menu
function topMenu() {
	console.log("test git7")
	$('#topBanner .close').click(function() {
        $('#topBanner').remove();

        //right side menu
       // $('#rightAside').css('top', '140px');
    });
}

/**
 * 이미지 에러시 대체 이미지 처리
 */
function OnErrorImageNull(obj){
	if(obj != null){
		obj.src = "<c:url value='/images/web/comm/no_img.jpg'/>";
	}
}

//main menu
function mainMenu() {
    var speed = 300;
    $('#menuBT').click(function() {
        if($('.subMenu').css('display')=='none'){
            $('.subMenu').slideDown(speed);
        }
        else {
            $('.subMenu').slideUp(speed);
        }
    });
}

/* top (상단으로 가기) */
function go_top() {
    $( '.go-top' ).click( function() {
        $( 'html, body' ).animate( { scrollTop : 0 }, 400 );
        return false;
    });
}

//스크롤시
$(window).scroll(function() {

    var scrollHeight = $(window).scrollTop();

    //go-top (상단으로 가기)
    if(scrollHeight > 500){
        $(".go-top").fadeIn("slow");
    }
    else {
        $(".go-top").fadeOut("fast");
    }


  //leftAside (좌측 사이드 배너 고정)
    if(scrollHeight > 300){
        $("#leftAside > ul").css({
            'position': 'fixed',
            'top': '20px'
        });

        //우측배너
        $("#rightAside > .fixed-wrap").css({
            'position': 'fixed',
            'top': '20px'
        });
    }
    else {
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

/**
 * 즐겨찾기 등록
 */
function bookmarksite(){
	var agent = navigator.userAgent.toLowerCase();

	if(navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1){
		alert("Ctrl+D키를 누르시면 즐겨찾기에 추가하실 수 있습니다.");
		return;
	}

	var bookmarkurl = "${pageContext.request.scheme}" + "://" + "${pageContext.request.serverName}"
	if(window.opera && window.print){ // opera
    	var elem = document.createElement('a');
    	elem.setAttribute('href',bookmarkurl);
    	elem.setAttribute('title','제주여행온라인마켓, 탐나오');
    	elem.setAttribute('rel','sidebar');
    	elem.click();
  	}else if(document.all){ // ie
    	window.external.AddFavorite(bookmarkurl, '제주여행온라인마켓, 탐나오');
  	}else if (window.sidebar){ // firefox
    	window.sidebar.addPanel('제주여행온라인마켓, 탐나오', bookmarkurl, "");
  	}else if(window.chrome){
  		alert("Ctrl+D키를 누르시면 즐겨찾기에 추가하실 수 있습니다.");
  	}
}

/* payAccordion */
function payAccordion() {
	var speed = 300;
	$('.payAccordion .downBT').click(function(event) {
		if ($(this).parent().next('dd').css('display')=='none') {
			$('.payAccordion dd').slideUp(speed);
			$(this).parent().next('dd').slideDown(speed);
		}
		else {
			$(this).parent().next('dd').slideUp(speed);
		}
	});
}

/* default Accordion */
function accordion() {
	var speed = 300;
	$('.default-accordion dt').click(function(event) {
		if ($(this).next('dd').css('display')=='none') {
			$('.default-accordion dd').slideUp(speed);
			$(this).next('dd').slideDown(speed);
		}
		else {
			$('.default-accordion dd').slideUp(speed);
		}
	});
}


/* tab panel (detailTabMenu1) */
function tabPanel(params) {
	var defaults = {
		container:"#tabs", //item wrap id
		firstItem:"#tabs-1" //first show item
	};
	for (var def in defaults) { //array object 확인
		if (typeof params[def] === 'undefined') {
			params[def] = defaults[def];
		}
		else if (typeof params[def] === 'object') {
			for (var deepDef in defaults[def]) {
				if (typeof params[def][deepDef] === 'undefined') {
					params[def][deepDef] = defaults[def][deepDef];
				}
			}
		}
	};

	var item = params.container+' ';
	$(item + ' .tabPanel').css('display','none');
	$(item).children(".tabPanel").eq(0).css('display', 'block');

	// alert($(item+'.menuList a').length);

	$(item+'.menuList a').each(function(index){
		$(item+'.menuList a').eq(index).click(function(){
			var show = $(this).attr('href');

			$(item+'.menuList a').removeClass('select');
			$(this).addClass('select');

			$(item+' .tabPanel').css('display', 'none');
			$(show).css('display', 'block');

			return false;
		});
	});
}

/*  항공  */
//가는항공편
function airCheck1() { //선택클릭시
	$('.airCH1').click(function(){
		$('#goWrap tr').removeClass('select');
		$(this).parent().parent().addClass('select');
	});
}
//오는항공편
function airCheck2() { //선택클릭시
	$('.airCH2').click(function(){
		$('#comeWrap tr').removeClass('select');
		$(this).parent().parent().addClass('select');
	});
}

/* 서브 메인 slide (관광지, 레저) */
function carousel() {
	$(".default .carousel").jCarouselLite({
		btnNext: ".default .next",
		btnPrev: ".default .prev",
		visible: 4,
		auto: 5000
	});
}

/* 여행경비산출 스크롤 애니메이션 top banner */
function scrollTop(id, st_top) {
	var select_obj = id; //선택대상
	var currentPosition = parseInt($(select_obj).css("top"));
	var ani_speed = 500; //애니메이션 속도

	$(window).scroll(function() {
	    var position = $(window).scrollTop();
	    var top_scroll = st_top; //언제부터 실행할것인지
	    var total_position = position-top_scroll;
	    if (position > top_scroll) {
	        $(select_obj).stop().animate({"top":total_position+currentPosition+"px"},ani_speed);
	    }
	    else {
	        $(select_obj).stop().animate({"top":"0px"},ani_speed);
	    }
	});
}

/* ---------------------------------------- sub11(마이페이지) ---------------------------------------- */
/* side menu */
function subLeftMenu() {
	$('#sub-leftMenu .depth1 li').click(function(){
		var speed = 300;
		if($(this).children('.depth2').css('display')=='none') {
			/* content slide */
			$('#sub-leftMenu .depth1 li .depth2').slideUp(speed);
			$(this).children('.depth2').slideDown(speed);
			/* arrow */
			$('#sub-leftMenu .depth1 li').removeClass('open');
			$(this).addClass('open');
		}
		else {
			/*$('#sub-leftMenu .depth1 li .depth2').slideUp(speed);
			$('#sub-leftMenu .depth1 li').removeClass('open');*/
		}
	});
}
/* ---------------------------------------- //sub11(마이페이지) ---------------------------------------- */

/**
 * 로그인 - 이전 url 정보포함
 */
function fn_login(){
	if(servlet_path != "/web/viewLogin.do" && servlet_path != "/web/actionLogin.do"){
		var ref = "<c:url value='/web/viewLogin.do?";

		ref += "rtnUrl=" + servlet_path;

		if(queryString != ""){
			ref += "&" + queryString + "'/>";
		}else{
			"'/>";
		}

		/* if(servlet_path == "/signUp.do"
		|| servlet_path == "/findIdPw.do"
		|| servlet_path == "/registMember.do"
		|| servlet_path == "/insertUser.do"
		|| servlet_path == "/insertOrder.do"
		|| servlet_path == "/jumunActionLogin.do"){

			ref += "rtnUrl=/main.do";
		}
		else if(servlet_path != "/viewLogin.do" || servlet_path != "/actionLogin.do"){
			ref += "rtnUrl=" + servlet_path;
		}
		if(queryString != ""){
			ref += "&" + queryString + "'/>";
		}else{
			"'/>";
		} */

		location.href = ref;
	}

}

/**
 * 로그인 - 이전 url 정보포함 - 사용자 로그인 전용
 */
function fn_loginUser(){
	if(servlet_path != "/web/viewLogin.do" && servlet_path != "/web/actionLogin.do"){
		var ref = "<c:url value='/web/viewLogin.do?";

		ref += "mode=user&";
		ref += "rtnUrl=" + servlet_path;

		if(queryString != ""){
			ref += "&" + queryString + "'/>";
		}else{
			"'/>";
		}

		/* if(servlet_path == "/signUp.do"
		|| servlet_path == "/findIdPw.do"
		|| servlet_path == "/registMember.do"
		|| servlet_path == "/insertUser.do"
		|| servlet_path == "/insertOrder.do"
		|| servlet_path == "/jumunActionLogin.do"){

			ref += "rtnUrl=/main.do";
		}
		else if(servlet_path != "/viewLogin.do" || servlet_path != "/actionLogin.do"){
			ref += "rtnUrl=" + servlet_path;
		}
		if(queryString != ""){
			ref += "&" + queryString + "'/>";
		}else{
			"'/>";
		} */

		location.href = ref;
	}

}


/**
 * logout
 */
function fn_logout(){
	if(confirm('<spring:message code="common.logout.confirm" />')){
		location.href = "<c:url value='/web/logout.do'/>";
	}
}

function show_popup(obj){
	if($(obj).is(":hidden")){
		$(obj).show();
		$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
	}else{
		$(obj).hide();
		$('.lock-bg').remove();
	}
}

/**
 * 오늘 본 상품 추가
 */
/*function fn_AddTodayPrdt(prdtNum, prdtNm, savePath, saveFileNm, url){
	 var cookieList = $.fn.cookieList("todayPrdt");
	 var obj = new Object();
	 obj.prdtNum = prdtNum;
	 obj.prdtNm  = prdtNm;
	 obj.savePath  = savePath;
	 obj.saveFileNm  = saveFileNm;
	 obj.url = url;

	 cookieList.add(obj);

}*/

function close_popup(obj){
	$(obj).hide();
	$('.lock-bg').remove();
}

function fn_AddCart(params){
//	if(fn_ValidateCart(params)){
		$.ajax({
			type:"post",
			dataType:"json",
			// processData:false,
			// contentType:false,
			// async:false,
			// traditional: true,
			contentType : "application/json;",
			url:"<c:url value='/web/addCart.ajax'/>",
			data:JSON.stringify({cartList :params}) ,
			success:function(data){
				$("#headCartCnt").html(data.cartCnt);
				$("#rightCartCnt").html(data.cartCnt);
				if(confirm("장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?")) {
					location.href="<c:url value='/web/cart.do'/>";
				}
			},
			error:fn_AjaxError
		});
//	}
}

/**
 * 찜한 상품
 */
function fn_AddPocket(params){
	$.ajax({
		type:"post",
		dataType:"json",
		// processData:false,
		// contentType:false,
		// async:false,
		// traditional: true,
		contentType : "application/json;",
		url:"<c:url value='/web/mypage/addPocket.ajax'/>",
		data:JSON.stringify({pocketList :params}) ,
		success:function(data){
			if(confirm("선택하신 상품을 찜 했습니다.\n찜한 상품 페이지로 이동하시겠습니까?")) {
				location.href="<c:url value='/web/mypage/pocketList.do'/>";
			}
		},
		error:fn_AjaxError2
	});
}

/**
 * 즉시구매
 */
function fn_InstantBuy(params){
	$.ajax({
		type:"post",
		dataType:"json",
		// processData:false,
		// contentType:false,
		// async:false,
		// traditional: true,
		contentType : "application/json;",
		url:"<c:url value='/web/instantBuy.ajax'/>",
		data:JSON.stringify({cartList :params}) ,
		success:function(data){
			if(data.result == "N"){
				alert("예약마감 또는 구매불가 상품입니다.");
				return;
			}else{
				location.href = "<c:url value='/web/order01.do?rsvDiv=i'/>";
			}
		},
		error:fn_AjaxError
	});
}

function fn_CartCnt(){
	var parameters = "";
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/web/cartCnt.ajax'/>",
		data:parameters ,
		success:function(data){
			$("#headCartCnt").html(data.cartCnt);
			$("#rightCartCnt").html(data.cartCnt);
		}
	});
}

function fn_CloseTopBanner(){
	$.cookie("topB", "Y", { expires: 1 , path: "/"});
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

$(document).ready(function(){

	//날씨 롤링 스크립트
	/*
	$('#top_weather ul').cycle({
		fx: 'fade',
		timeout: 5000
	});
	*/

	topMenu();
    mainMenu();
    fn_CartCnt();
    go_top();

  //zoom gallery album
	if($("#gallery_zoom").length > 0) {photoAlbum();}
	//gallery view
	if($(".gallery-view").length > 0) {galleryView();}

	//payAccordion
	if($(".payAccordion").length > 0) {payAccordion();}
	//default accordion
	if($(".default-accordion").length > 0) {accordion();}

	//취소 수수료 안내
	if($("#layer-1").length > 0) {layerP1();}

	//항공 (가는항공편 input check)
	if($(".airCH1").length > 0) {airCheck1();}
	//항공 (오는항공편 input check)
	if($(".airCH2").length > 0) {airCheck2();}

	//sub main slider
	//if($(".product_slide").length > 0) {carousel();}

	//mypage side menu
	if($("#sub-leftMenu").length > 0) {subLeftMenu();}
    // rightAside();

    // 구글 통계
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

	  ga('create', 'UA-70075141-2', 'auto');
	  ga('send', 'pageview');

	/* $("#searBT").click(function() {
		fn_searBtClick();
	}); */

	var topB = $.cookie("topB");

	if(topB == undefined){
		$("#topBanner").show();
	}
});


/**
 * App 체크
 * AA : 안드로이드 앱, AW : 안드로이드 웹, IA : IOS 앱, IW : IOS 웹
 */
function fn_AppCheck(){
	var headInfo = ("${header['User-Agent']}").toLowerCase();

	var mobile = (/iphone|ipad|ipod|android|windows phone|iemobile|blackberry|mobile safari|opera mobi/i.test(headInfo));

	if(mobile){
		// 안드로이드
		if((/android/.test(headInfo))){
			// 안드로이드 앱
			if(/webview_android/.test(headInfo)){
				return "AA";
			}
			// 안드로이드 웹
			else{
				return "AW";
			}
		}
		// IOS
		else if((/iphone|ipad|/.test(headInfo))){
			if(!(/safari/.test(headInfo))){
				return "IA";
			}else{
				return "IW";
			}
		}
	}else{
		return "PC";
	}
}


//-----------------------------------------------------------
//실시간(내부) 배너 관련 함수들
//
//사용시에는 gfn_setRtBannerTm(콜백함수, 시간(초))
//추가기능 ::

var g_rtBannerTmNow = 0;
var g_rtBannerTmMax = 0;
var g_rtBannerTmCallback;


function gfn_setRtBannerTm(callback, time){
	g_rtBannerTmNow = 0;
	g_rtBannerTmMax = time;
	g_rtBannerTmCallback = callback;

	//시간이 0이면 바로 띠우기
	if(time == 0){
		g_rtBannerTmCallback();
		return;
	}

	//마우스 이벤트 등록
	if ( document.addEventListener ) {
	    document.addEventListener("mousemove",gfn_onmousemove,false);
	} else if ( document.attachEvent ) {
	    document.attachEvent("onmousemove",gfn_onmousemove);
	} else {
	    document.onmousemove = gfn_onmousemove;
	}

	//키보드 이벤트 등록
	window.onkeydown = function(){
		g_rtBannerTmNow = 0;
	}

	setTimeout("gfn_setRtBannerTm_Sub()", 1000 ); //1초에 한번씩 호출
}

function gfn_setRtBannerTm_Sub(){
	//console.log("----" + g_rtBannerTmNow +"초");
	if(g_rtBannerTmNow >= g_rtBannerTmMax){
		//끝
		g_rtBannerTmCallback();
	}else{
		g_rtBannerTmNow++;
		setTimeout("gfn_setRtBannerTm_Sub()", 1000 ); //1초에 한번씩 호출
	}
}

function gfn_onmousemove(){
	g_rtBannerTmNow = 0;
}

//-----------------------------------------------------------



</script>
	<div id="topBanner" style="display:none;">
        <div class="Fasten">

			<%-- 추가기능:: 배너 구현 --%>
			<%--
			<c:forEach var="result" items="${bannerList}" varStatus="status">
				<c:if test="${not empty result.url}">
					<a href="${result.url}" <c:if test="${result.nwd == 'Y' }">target="_blank"</c:if> >
				</c:if>
            		<img src="<c:url value='${result.imgPath}${result.imgFileNm}'/>" alt="<c:out value="${result.bannerNm}"/>" height="70" width="1070">
            	<c:if test="${not empty result.url}">
            		</a>
				</c:if>
				<!--
				<c:if test="${empty data.bgColor}"> <li style="background-color:#000000"> </c:if>
				<c:if test="${!(empty data.bgColor)}"> <li style="background-color:#${result.bgColor}"> </c:if>
				-->
            </c:forEach>
             --%>
            <a class="img-btn" onclick="show_popup('.comm-fullPopup2');"><img src="<c:url value='/images/web/comm/top_banner.jpg'/>" alt="상단배너"></a>
            <a class="close" onclick="javascript:fn_CloseTopBanner();"><img id="tbClose" src="<c:url value='/images/web/comm/close.png'/>" alt="닫기"></a>

            <div class="comm-fullPopup2">
                <a class="option-close" onclick="close_popup('.comm-fullPopup2');"><img src="<c:url value='/images/web/comm/view_close.png'/>" alt="닫기"></a>
                <img src="<c:url value='/images/web/comm/top_banner_view.png'/>" alt="배너 상세">
            </div>
        </div>
    </div>
	<div class="Fasten">
		<div class="topSearch">
			<div class="logo"><a href="/"><img src="<c:url value='/data/logo.gif'/>" alt="탐나오"></a></div>
			<%-- <h1 class="logo"><a href="/"><img src="<c:url value='/images/web/comm/logo_02.gif'/>" alt="탐나오"></a></h1> --%>
			<!-- 검색 -->
			<form name="totalSearchForm" id="totalSearchForm" onSubmit="javascript:fn_searBtClick();return false;">
			</form>
			<p class="searchBox">
				<input id="search" name="search" type="text" value="<c:out value='${search}'/>" onkeydown="javascript:if(event.keyCode==13){fn_searBtClick();}" >
				<button id="searBT" onclick="fn_searBtClick();"></button>
				<%-- 추가기능:: 키워드 광고 구현 --%>
<%--				<c:forEach var="result" items="${kwaList}" varStatus="status">--%>
<%--					<c:if test="${empty result.pcUrl}"><a href="/web/search.do?search=<c:out value="${result.kwaNm}"/>" ></c:if>--%>
<%--					<c:if test="${!empty result.pcUrl}"><a href="${result.pcUrl}" ></c:if>--%>
<%--	            		<c:out value="${result.kwaNm}"/>--%>
<%--	            	</a>--%>
<%--	            </c:forEach>--%>
			</p>

			<nav id="topMenu">
				<a href="javascript:bookmarksite();">★즐겨찾기</a>
				<c:if test="${isLogin=='Y'}">
					<a href="javascript:fn_logout();">로그아웃</a>
				</c:if>
				<c:if test="${isLogin=='G'}">
					<a href="javascript:fn_logout();">비회원Logout</a>
				</c:if>
				<c:if test="${isLogin=='N'}">
					<a href="javascript:fn_login();">로그인</a>
					<a href="<c:url value='/web/signUp02.do'/>">회원가입</a>
				</c:if>

				<a href="<c:url value='/web/mypage/rsvList.do'/>">마이페이지</a>
				<a href="<c:url value='/web/coustmer/qaList.do'/>">고객센터</a>
			</nav>
		</div>
	</div>

     <!-- main menu -->
	<nav id="mainMenu">
    	<div class="Fasten">
        	<div class="menuBT"><a id="menuBT"><img src="<c:url value='/images/web/comm/menu.gif'/>" alt="메뉴"></a></div>
        	<div class="subMenu"><!-- 11<br>11<br>11<br>11<br> --></div>
        	<ul class="mainMenu">
	            <li><a href="<c:url value='/web/av/productList.do'/>">항공</a></li>
	            <li><a href="<c:url value='/web/stay/jeju.do'/>">숙박</a></li>
	            <li><a href="<c:url value='/web/rentcar/car-list.do?mYn=Y'/>">렌터카</a></li>
	            <li><a href="<c:url value='/web/tour/jeju.do?sCtgr=C200'/>">관광지/레저</a></li>
	            <li><a href="<c:url value='/web/tour/jeju.do?sCtgr=C300'/>">음식/뷰티</a></li>
	            <li><a href="<c:url value='/web/sp/packageList.do?sCtgrTab=C130'/>">카텔</a></li>
	            <li><a href="<c:url value='/web/sp/packageList.do?sCtgrTab=C170'/>">골프패키지</a></li>
	            <li><a href="<c:url value='/web/sp/packageList.do?sCtgrTab=C160'/>">버스/택시관광</a></li>
	            <li class="img"><a href="<c:url value='/web/sv/productList.do'/>"><img src="<c:url value='/images/web/comm/specialty.gif'/>" alt="제주특산기념품"></a></li>
	            <li><a href="<c:url value='/web/evnt/promotionList.do'/>">특가이벤트</a></li>
	            <%-- <li><a href="<c:url value='/web/te/teMain.do'/>">여행경비산출</a></li> --%>
	        </ul>
	    </div>
	</nav>
	<!-- //main menu -->

	<%-- <div id="top_weather" class="top-weather">
		<div class="Fasten">
	        <ul>
	        	<c:forEach items="${gribList}" var="grib" varStatus="status">
	        		<li style="display:none;">
	        			<c:choose>
	        				<c:when test="${grib.area eq '0001'}"><a href="http://www.kma.go.kr/weather/forecast/timeseries.jsp?searchType=INTEREST&dongCode=5011059000" target="_blank"></c:when>
	        				<c:when test="${grib.area eq '0002'}"><a href="http://www.kma.go.kr/weather/forecast/timeseries.jsp?searchType=INTEREST&dongCode=5011031000" target="_blank"></c:when>
	        				<c:when test="${grib.area eq '0003'}"><a href="http://www.kma.go.kr/weather/forecast/timeseries.jsp?searchType=INTEREST&dongCode=5013025900" target="_blank"></c:when>
	        				<c:when test="${grib.area eq '0004'}"><a href="http://www.kma.go.kr/weather/forecast/timeseries.jsp?searchType=INTEREST&dongCode=5013051000" target="_blank"></c:when>
	        			</c:choose>
							<div class="title"><c:out value="${grib.areaNm}" /> <span class="time">${fn:substring(grib.baseTime, 0, 2)}시</span></div>
							<div class="icon">
								<div class="l-area">
									<c:choose>
   										<c:when test="${grib.skyCode eq '1'}"><img src="<c:url value='/images/web/weather/01.png'/>" alt="맑음"></c:when>
   										<c:when test="${grib.skyCode eq '2'}"><img src="<c:url value='/images/web/weather/02.png'/>" alt="구름조금"></c:when>
   										<c:when test="${grib.skyCode eq '3'}"><img src="<c:url value='/images/web/weather/03.png'/>" alt="구름많음"></c:when>
   										<c:otherwise>
   											<c:choose>
   												<c:when test="${grib.ptyCode eq '0'}"><img src="<c:url value='/images/web/weather/04.png'/>" alt="흐림"></c:when>
   												<c:when test="${grib.ptyCode eq '1'}"><img src="<c:url value='/images/web/weather/05.png'/>" alt="비"></c:when>
   												<c:when test="${grib.ptyCode eq '2'}"><img src="<c:url value='/images/web/weather/06.png'/>" alt="눈/비"></c:when>
   												<c:when test="${grib.ptyCode eq '3'}"><img src="<c:url value='/images/web/weather/07.png'/>" alt="눈"></c:when>
   											</c:choose>
   										</c:otherwise>
   									</c:choose>
								</div>
								<div class="r-area">
									<p class="temp"><c:out value="${grib.t1h}"/>℃</p>
									<p class="text">
										<c:choose>
	   										<c:when test="${grib.skyCode eq '1'}">맑음</c:when>
	   										<c:when test="${grib.skyCode eq '2'}">구름조금</c:when>
	   										<c:when test="${grib.skyCode eq '3'}">구름많음</c:when>
	   										<c:otherwise>
	   											<c:choose>
	   												<c:when test="${grib.ptyCode eq '0'}">흐림</c:when>
	   												<c:when test="${grib.ptyCode eq '1'}">비</c:when>
	   												<c:when test="${grib.ptyCode eq '2'}">눈/비</c:when>
	   												<c:when test="${grib.ptyCode eq '3'}">눈</c:when>
	   											</c:choose>
	   										</c:otherwise>
	   									</c:choose>
									</p>
								</div>
							</div>
						</a>
					</li>
	        	</c:forEach>
	        </ul>
	    </div>
	</div> --%>

	<!-- APP 다운로드 -->
	<div class="app-down">
		<div class="Fasten">
			<dl>
				<dt>모바일앱 다운로드</dt>
				<dd>
					<a href="https://play.google.com/store/apps/details?id=kr.or.hijeju.tamnao" target="_blank">
						<img src="<c:url value='/images/web/comm/play-store.png'/>" alt="플레이스토어">
					</a>
					<a href="https://itunes.apple.com/kr/app/%ED%83%90%EB%82%98%EC%98%A4-%EC%A0%9C%EC%A3%BC%EC%97%AC%ED%96%89%EB%A7%88%EC%BC%93/id1073503585?mt=8" target="_blank">
						<img src="<c:url value='/images/web/comm/apple-stor.png'/>" alt="애플스토어">
					</a>
				</dd>
			</dl>
		</div>
	</div>






