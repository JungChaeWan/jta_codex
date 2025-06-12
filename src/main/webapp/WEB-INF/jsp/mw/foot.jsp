<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-MJBHPNP"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
<script>
var chkPath = document.location.pathname;
    if(chkPath.indexOf("rentcar") >= 0){
        $("h1").append("제주도렌트카 가격비교 및 할인 예약 - 탐나오 | 추천 렌터카 서비스");
    }else if(chkPath.indexOf("stay") >= 0){
        $("h1").append("제주숙소: 제주여행 공공플랫폼 탐나오, 저렴한 숙소 예약");
    }else if(chkPath.indexOf("tour") >= 0){
        $("h1").append("제주관광지: 제주여행 공공플랫폼 탐나오에서 예약하세요.");
    }else if(chkPath.indexOf("av") >= 0){
        $("h1").append("제주도항공권: 제주여행 공공플랫폼 탐나오");
    }else if(chkPath.indexOf("goods") >= 0){
        $("h1").append("제주도 공공플랫폼 탐나오 특산기념품 농수산물 배송");
    }else{
    	$("h1").append("탐나오 TAMNAO - 제주도 공식 여행 공공 플랫폼");
	}

var getContextPath = "${pageContext.request.contextPath}";
var servletPath = "${requestScope['javax.servlet.forward.servlet_path']}";

function go_top() {
    $("html, body").animate({scrollTop : 0}, 400);
    return false;
}

/*//footer 열기/닫기
function openFoldArea() {
    if($("#foldArea").css("display") != "block") {
        $("#foldArea").css("display","block");
        $(".footer-close").css("display","block");
        $(".footer-open").css("display","none");
    } else {
        $("#foldArea").css("display","none");
        $(".footer-open").css("display","block");
        $(".footer-close").css("display","none");
	}
}*/

/*function fn_CartCnt(){
	$.ajax({
		type:"post",
		dataType:"json",
		url:"<c:url value='/web/cartCnt.ajax'/>",
		success:function(data){
			/!** 장바구니 카운트가 1이상일때만 표시*!/
			if(Number(data.cartCnt) > 0){
				$("#headCartCnt").html(data.cartCnt);
				$("#headCartCnt").show();
			}else{
				$("#headCartCnt").hide();
			}
		}
	});
}*/

$(document).ready(function(){
	$("input.search_inpbox_inp, #top_searchOpen2, .search_inpbox_btn").click(function () {
		fn_readSearchWord();
		$("body").addClass("globalSearch-open");
		$("#call-btn").hide();
	});

	$("#top_searchClose_inp").click(function () {
		$("body").removeClass("globalSearch-open");
		$("#call-btn").show()
		$("#dimmed").hide("");
	});
	
	$("#frame_sideOpen3").on('click', function() {
		$("#side_menu").fadeToggle();
		$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
		$('body').addClass('not_scroll');
	});
	
	$(".floating_call").click(function () {
		// 기존 문의게시판/전화연결 레이어오픈에서 문의게시판으로 다이렉트 연결 함. 2022.07.25 chaewan.jung
		//$(this).toggleClass("is_open");
		location.href="/mw/coustomer/qaList.do";
	});

	// $("#top_searchOpen2").on("click", function(){
	// 	$("#top_search").show();
	// });
	var searchWord = location.href;
	var comparWord = [
		"/mw",
	    "/mw/main.do",
		"/mw/av/productList.do",
		"/mw/ad/productList.do",
		"/mw/rentcar/car-list.do",
		"/mw/tour/jeju.do",
		"/mw/sp/packageList.do",
		"/mw/sp/vesselList.do",
		"/mw/sv/productList.do",
		"/mw/sv/mainList.do",
		"/mw/evnt/prmtPlanList.do",
		"/mw/coustomer/mdsPickList.do",
		"/mw/evnt/promotionList.do",
		"/mw/coustomer/qaList.do",
		"/mw/ad/detailPrdt.do",
		"/mw/rentcar/car-detail.do",
		"/mw/sp/detailPrdt.do",
		"/mw/sv/detailPrdt.do",
		"/mw/evnt/detailPromotion.do"
	];
	var compResult;

	for(var i in comparWord) {
		compResult = searchWord.search(comparWord[i]);
		if(compResult > 0) {
			break;
		}
	}
	if(compResult > 0) {
		$("#fixed_foot").addClass("active");
		$("#call-btn").show(); //고객센터

		$(window).scroll(function(){
			var scrollHeight = $(document).height();
			var scrollPosition = $(window).height() + $(window).scrollTop();

			if(scrollHeight - scrollPosition < 500) {
				$("#fixed_foot").removeClass("active");
			} else {
				$("#fixed_foot").addClass("active");
			}
			if(scrollPosition > 1000) {
				$("#top-foot").addClass("active");
			} else {
				$("#top-foot").removeClass("active");
			}
		});
    }
    var comparWord2 = [
		"/mw/order01.do",
		"/mw/order03.do",
		"/mw/cart.do",
		"/mw/mypage/detailRsv.do"
	];
	var compResult2;

	for(var i in comparWord2) {
		compResult2 = searchWord.search(comparWord2[i]);
		if(compResult2 > 0) {
			break;
		}
	}

	if(compResult2 > 0) {
		$("#top-foot").hide();
        $("#call-btn").hide(); //고객센터
        $("#top_banner").hide();
	}
	
	topBanner();
	
	/*fn_PocketCnt();*/
	/*fn_CartCnt();*/
});

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
			/*$("#main").css("margin-top", $(".top_fix").height() + "px" );*/
			return false;
		});
	}

	if(itemSize > 1) {
		topBannerSlider();
	}
	/*$("#main").css("margin-top", $(".top_fix").height() + "px" );*/
}

function topBannerSlider() {
	new Swiper('#top_banner', {
		paginationClickable: true,
		//direction: 'vertical',
		autoplay: 5000,
		loop: true,
        paginationType: 'fraction',
        effect: 'fade',
        touchRatio: 0
	});
}
</script>
<footer id="footer">
	<div id="foldArea" style="display: block;">
		<nav class="foot-menu">
			<a href="<c:url value='/mw/etc/personalData.do'/>">개인정보처리방침</a>
			<a href="<c:url value='/mw/etc/buyToS.do'/>">이용약관</a>
			<a href="https://pgweb.tosspayments.com/ms/escrow/s_escrowYn.do?mertid=tamnao" target="_blank">매매보호서비스</a>
		</nav>
		<img src="/images/mw/sub/footer_tamnao.png" loading="lazy" alt="탐나오">
		<address class="copyright">
			<p>63309 제주특별자치도 제주시 첨단로 213-65 제주종합비즈니스센터 3층</p>
			<p>고객센터 : <span>1522-3454</span></p>
			<p class="name">제주특별자치도관광협회 │ 대표이사 : 강동훈 │ 사업자등록번호 : 616-82-04092</p>
			<p>법인등록번호 : 220121-0000107 │ 	<a href="https://www.ftc.go.kr/info/bizinfo/communicationViewPopup.jsp?wrkr_no=6168204092&newopen=yes" class="company-confirm" target="_blank">
				통신판매업번호: 제2018-제주아라-0049호</a></p>
			<p>개인정보관리책임자 : 김대철 │ <a href="mailto:tamnao@tamnao.com">	e-mail : tamnao@tamnao.com</a></p>
			<p>탐나오는 통신판매중개자로서 거래당사자가 아니므로 개별 판매자가 등록한 상품거래정보 및 거래에 대해서 책임을 지지 않습니다.</p>
		</address>
		<div class="footer-sns">
			<ul>
				<li class="sns-blog"><a href="https://blog.naver.com/jta0119" target="_blank"><span class="visuallyhidden">탐나오 공식 네이버블로그</span></a></li>
				<li class="sns-insta"><a href="https://www.instagram.com/tamnao_jeju/" target="_blank"><span class="visuallyhidden">탐나오 공식 인스타그램</span></a></li>
				<li class="sns-youtube"><a href="https://www.youtube.com/channel/UC5Hk3MfM3RFDz5_Xm9BDJZQ" target="_blank"><span class="visuallyhidden">탐나오 공식 유튜브</span></a></li>
				<li class="sns-facebook"><a href="https://www.facebook.com/JEJUTAMNAOTRAVEL" target="_blank"><span class="visuallyhidden">탐나오 공식 페이스북</span></a></li>
				<li class="sns-kakao"><a href="https://pf.kakao.com/_xhMCrj" target="_blank"><span class="visuallyhidden">탐나오 공식 카카오채널</span></a></li>
			</ul>
		</div>
	</div>
	<div class="company-area">
		<div><img src="/images/mw/sub/company-logo.png" alt="제주특별자치도관광협회 소개"></div>
		<div class="company-note">1962년 2월 22일 관광진흥법 제45조에 의거 제주관광산업의 성장 발전과 회원업체의 사업발전 및 복리증진에 기여할 목적으로 설립하였습니다. 제주관광정책에 대한 조사ㆍ연구,
			<br>
			관광객 수용시설 및 서비스의 질 개선, 관광통계 작성, 관광안내소 및 국내홍보센터 운영, 관광객 불편사항 처리, 관광윤리 확립 및 관광질서 지도 등의 사업을 수행하고 있습니다.</div>
	</div>
	<div class="open">
 <%--       <a href="javascript:openFoldArea()">
		    <p><img src="/images/mw/sub/footer_jta.png" loading="lazy" alt="제주특별자치도관광협회"></p>
		    <p class="footer-open"><img src="/images/mw/sub/open_arrow.png" alt="열기"></p>
            <p class="footer-close"><img src="/images/mw/sub/close_arrow.png" alt="닫기"></p>
        </a>--%>
	</div>
	<div class="m_floating" id="m_floating_id">
		<div class="floating_right" id="floating_right_id">
			<div class="floating_call" id="call-btn">
				<div class="floating_call_dimmed"></div>
				<div class="floating_center">
					<a href="/mw/coustomer/qaList.do" class="btn_center btn_qna" data-react-tarea="문의게시판">
						<span class="btn_tx">문의게시판</span>
					</a>
					<a href="tel:1522-3454" class="btn_center btn_call" data-react-tarea="전화연결">
						<span class="btn_tx">전화연결</span>
					</a>
				</div>
				<button class="floating_btn floating_btn_call f_call" type="button" aria-expanded="false">
					<span class="blind">알림함</span>
				</button>
			</div>
			<div class="floating_top_btn" id="top-foot">
				<!-- <a class="go-mw-top floating_btn f_top" onclick="go_top();"></a> -->
				<span onclick="go_top();" class="go-mw-top floating_btn f_top" style="cursor:pointer;"></span>
			</div>
		</div>
	</div>
</footer>
<div id="fixed_foot" class="fixed-foot">
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
				<!-- <a href="javascript:void(0)" id="top_close" class="close"><img src="/images/mw/common/close.png" alt="닫기"></a> -->
				<span id="top_close" class="close"><img src="/images/mw/common/close.png" alt="닫기"></span>
			</div>
		</div>
	</c:if>
	<nav id="bottomMenu" class="bottom-menu product-search-area">
		<a class="side-btn" id="frame_sideOpen3">카테고리</a>
		<a class="sch" id="top_searchOpen2">검색</a>
		<a href="<c:url value='/mw/main.do' />" class="home">홈</a>
		<a href="<c:url value='/mw/cart.do' />" class="cart">장바구니
			<span class="cnt" id="headCartCnt" style="display: none;"></span>
		</a>
		<a href="<c:url value='/mw/mypage/mainList.do' />" class="my">마이탐나오</a>
	</nav>
</div>

<%-- 모바일 에이스 카운터 추가 2017.04.25 --%>
<!-- AceCounter Mobile WebSite Gathering Script V.7.5.20170208 -->
<script>
	var _AceGID=(function(){var Inf=['tamnao.com','m.tamnao.com,www.tamnao.com,tamnao.com','AZ3A70537','AM','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;if(_CI.join('.').indexOf(Inf[3])<0){ _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
	var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,'_');_sc.src=(location.protocol.indexOf('http')==0?location.protocol:'http:')+'//cr.acecounter.com/Mobile/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<noscript><img src='//gmb.acecounter.com/mwg/?mid=AZ3A70537&tp=noscript&ce=0&' width='0' height='0' alt="acecounter"></noscript>
<!-- AceCounter Mobile Gathering Script End -->

<!-- 네이버 유입추척 (2018-01-25, By JDongS) --> 

<script src="//wcs.naver.net/wcslog.js"> </script>
<script>
if (!wcs_add) var wcs_add={};
wcs_add["wa"] = "s_34e207b42ae3";
if (!_nasa) var _nasa={};
wcs.inflow("m.tamnao.com");
wcs_do(_nasa);
</script>

<%-- 카카오 유입추적 모바일--%>
<script src="//t1.daumcdn.net/adfit/static/kp.js"></script>
<script>
	kakaoPixel('1824481670434828332').pageView();
</script>
<script>
	kakaoPixel('5986927315880161684').pageView();
</script>

<!-- Facebook Pixel Code 2018.02.26 -->
<script>
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window,document,'script',
'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', '424270624670832');
fbq('track', 'PageView');
var face_url = $(location).attr('href');
/* 웹 모바일 공통  */
if( face_url.match("cart.do") ){ //장바구니 페이지 일때
	fbq('track', 'AddToCart');
/* 웹 모바일 구분 웹 (웹:web/signUp04.do 모바일:mw/signUp02.do)  */	
}else if( face_url.match("mw/signUp02.do") ){ //회원가입 했을때
	fbq('track', 'CompleteRegistration');
/* 웹모바일 공통  */
}else if( face_url.match("orderComplete.do") ){ //구매완료 했을때  ( value_won은 구매 금액 ) 
	setTimeout(function(){
		var value_won =  "${rsvInfo.totalSaleAmt}";
		value_won = parseInt(value_won.replace( /,/gi, ''));
		fbq('track', 'Purchase', {value: value_won, currency: 'KRW'});
	},1000)
}
</script>
<noscript>
	<img height="1" width="1" src="https://www.facebook.com/tr?id=424270624670832&ev=PageView&noscript=1">
</noscript>
<!-- End Facebook Pixel Code -->

<!-- Google 리마케팅 SCRIPT START 2017.03.30 -->
<%--<script>
/* <![CDATA[ */
var google_conversion_id = 856580262;
var google_custom_params = window.google_tag_params;
var google_remarketing_only = true;
/* ]]> */
</script>
<script src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/856580262/?guid=ON&amp;script=0" alt="googleads">
</div>
</noscript>--%>
<!-- // Google 리마케팅 SCRIPT END 2016.03.30 -->

<!-- beusable 웹로그툴 SCRIPT START 2017.07.05 -->
<%--<script>
(function(w, d, a){
	w.__beusablerumclient__ = {
		load : function(src){
			var b = d.createElement("script");
			b.src = src; b.async=true; b.type = "text/javascript";
			d.getElementsByTagName("head")[0].appendChild(b);
		}
	};w.__beusablerumclient__.load(a);
})(window, document, '//rum.beusable.net/script/b170615e132002u114/98b86a49e0');
</script>--%>
<!-- // beusable 웹로그툴 SCRIPT END 2017.07.05 -->

<!-- WIDERPLANET  SCRIPT START 2023.4.17 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script>
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
	return {
		wp_hcuid:"",  	/*고객넘버 등 Unique ID (ex. 로그인  ID, 고객넘버 등 )를 암호화하여 대입.
				 *주의 : 로그인 하지 않은 사용자는 어떠한 값도 대입하지 않습니다.*/
		ti:"54575",	/*광고주 코드 */
		ty:"Home",	/*트래킹태그 타입 */
		device:"mobile"	/*디바이스 종류  (web 또는  mobile)*/
	};
}));
</script>
<script defer src="//cdn-aitg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET  SCRIPT END 2023.4.17 -->