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
    <jsp:param name="title" value="제주 농부의 장, 탐나오"/>
    <jsp:param name="description" value="제주산 원물을 가공한 6차산업 음식품, 농축산물, 생활용품 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 빠르고 안전하게 배송받을 수 있습니다."/>
    <jsp:param name="keywords" value="6차산업,제주,제주도,간식,음료차,식초,유제품,육가공,발효식품,반찬,원물가공,잼,꿀,조청,과일,생활용품,화장품,분재"/>
</jsp:include>
<meta property="og:title" content="제주 농부의 장, 탐나오">
<meta property="og:url" content="https://www.tamnao.com/mw/sv/sixIntro.do">
<meta property="og:description" content="제주산 원물을 가공한 음식품, 농축산물, 생활용품 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 빠르고 안전하게 배송받을 수 있습니다." >
<meta property="og:image" content="https://www.tamnao.com/images/web/agriculture/aside_img.png">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/ac.css?version=${nowDate}' />">
<link rel="canonical" href="https://www.tamnao.com/web/sv/sixIntro.do">
</head>
<body class="main">
<div id="ac-sub" class="m_wrap">
    <jsp:include page="/mw/newMenu.do"></jsp:include>
    <!-- key-visual -->
    <div class="ac-panels-new">
        <div class="main-list">
            <div class="main-top-slider">
                <div id="main_top_slider" class="swiper-container">
                    <ul class="swiper-wrapper">
                        <li class="swiper-slide">
                            <div class="Fasten">
                                <!-- <a href=""><img src="/images/mw/from/banner/ac_banner_1.jpg" alt="기획전"></a> -->
                                <img src="/images/mw/from/banner/ac_banner_1.jpg" alt="기획전">
                            </div>
                        </li>
                        <li class="swiper-slide">
                            <div class="Fasten">
                                <!-- <a href=""><img src="/images/mw/from/banner/ac_banner_2.jpg" alt="이벤트"></a> -->
                                <img src="/images/mw/from/banner/ac_banner_2.jpg" loading="lazy" alt="이벤트">
                            </div>
                        </li>
                    </ul>
                    <div id="main_top_navi" class="swiper-pagination"></div>
                </div>
            </div>
        </div>
    </div><!-- //key-visual -->

    <!-- 카테고리 메뉴 -->
    <div class="menu-typeA">
        <nav class="ac_scroll-menu">
            <div class="category-menu">
                <div class="row_view">
                    <a class="active" href="/mw/sv/sixProductList.do?sCtgr=SVC1">
                        <img src="/images/mw/agriculture/snack.png" alt="간식·음료 아이콘">
                        <div>간식·음료</div>
                    </a>
                    <a href="/mw/sv/sixProductList.do?sCtgr=SVC2">
                        <img src="/images/mw/agriculture/tea.png" alt="차·식초 아이콘">
                        <div>차·식초</div>
                    </a>
                    <a href="/mw/sv/sixProductList.do?sCtgr=SVC7">
                        <img src="/images/mw/agriculture/fruit.png" alt="원물·과일 아이콘">
                        <div>원물·과일</div>
                    </a>
                    <a href="/mw/sv/sixProductList.do?sCtgr=SVC4">
                        <img src="/images/mw/agriculture/tradition.png" alt="전통·발효식품·반찬 아이콘">
                        <div>전통·발효식품<p>반찬</p></div>
                    </a>
                </div>
                <div class="row_view">
                    <a href="/mw/sv/sixProductList.do?sCtgr=SVC5">
                        <img src="/images/mw/agriculture/cereals.png" alt="곡류·원물가공식품 아이콘">
                        <div>곡류<p>원물가공식품</p></div>
                    </a>
                    <a href="/mw/sv/sixProductList.do?sCtgr=SVC6">
                        <img src="/images/mw/agriculture/jam.png" alt="잼·꿀·당류가공식품 아이콘">
                        <div>잼·꿀<p>당류가공식품</p></div>
                    </a>
                    <a href="/mw/sv/sixProductList.do?sCtgr=SVC3">
                        <img src="/images/mw/agriculture/livestock.png" alt="유제품·육가공·축산식품 아이콘">
                        <div>유제품·육가공<p>축산식품</p></div>
                    </a>
                    <a href="/mw/sv/sixProductList.do?sCtgr=SVC8">
                        <img src="/images/mw/agriculture/life.png" alt="생활용품·화장품·천연염색 아이콘">
                        <div>생활용품·화장품<p>천연염색</p></div>
                    </a>
                </div>
                <div class="row_view">
                    <a href="/mw/sv/sixProductList.do?sCtgr=SPC1">
                        <img src="/images/mw/agriculture/experience.png" alt="체험·관광 아이콘">
                        <div>체험·관광</div>
                    </a>
                    <a href="/mw/sv/sixProductList.do?sCtgr=SVCA">
                        <img src="/images/mw/agriculture/kit.png" alt="체험키트꾸러미 아이콘">
                        <div>체험키트<p>꾸러미</p></div>
                    </a>
                </div>
            </div>
        </nav>
    </div><!-- //카테고리 메뉴 -->

    <!-- agriculture_info -->
    <div class="info-panels-new">
        <div class="framing--introd">
            <h2>제주농부의 <span>정성과 진심</span>만 담습니다.</h2>
            <div id="ac_top_slider" class="category-menu swiper-container">
                <ul class="certification swiper-wrapper">

                    <li class="variant-card swiper-slide certification-2" onclick="layer_popup2('#certification_2');">
                        <div class="content">
                            <img src="/images/mw/agriculture/certification_2.png" alt="착한여행">
                            <h3>제주농촌융복합산업지원센터</h3>
                            <span>농촌관광 활성화 지원 / 인프라 정비</span>
                        </div>
                    </li>

                    <li class="variant-card swiper-slide certification-1" onclick="layer_popup2('#certification_1');">
                        <div class="content">
                            <img src="/images/mw/agriculture/certification_1.png" alt="제주여행">
                            <h3>6차산업이란?</h3>
                            <span>농촌융복합산업(6차산업)</span>
                        </div>
                    </li>

                    <li class="variant-card swiper-slide certification-3" onclick="layer_popup2('#certification_3');">
                        <div class="content">
                            <img src="/images/mw/agriculture/certification_3.png" alt="숙소예약">
                            <h3>농촌융복합사업자인증제</h3>
                            <span>인증 자격요건 / 신청방법 / 인증절차</span>
                        </div>
                    </li>
                </ul>
                <div id="infoSlider" class="swiper-pagination"></div>
            </div>

            <!-- content // certification_1 -->
            <div id="certification_1" class="comm-layer-popup full-layer-popup">
                <div class="content-wrap">
                    <div class="content">
                        <div class="head">
                            <h3 class="title">
                                6차산업이란?
                            </h3>
                            <button type="button" class="close">
                                <img src="/images/mw/icon/close/dark-gray.png" alt="닫기" onclick="itemSingleHide('.full-layer-popup');">
                            </button>
                        </div>
                        <p class="btn-site">
                            <a href="http://www.xn--6-ql4f73knwc95ai5j.com/m" class="btn-detail" rel="nofollow">
                                페이지 바로가기
                            </a>
                        </p>
                        <div class="detail-header">
                            <img src="/images/mw/agriculture/certification_1.jpg" alt="6차산업이란?">
                        </div>
                    </div>
                </div>
            </div><!-- content // -->

            <!-- content // certification_2 -->
            <div id="certification_2" class="comm-layer-popup full-layer-popup">
                <div class="content-wrap">
                    <div class="content">
                        <div class="head">
                            <h3 class="title">
                                제주농촌융복합산업지원센터
                            </h3>
                            <button type="button" class="close">
                                <img src="/images/mw/icon/close/dark-gray.png" alt="닫기" onclick="itemSingleHide('.full-layer-popup');">
                            </button>
                        </div>
                        <div class="detail-header">
                            <img src="/images/mw/agriculture/certification_2.jpg" alt="6차산업지원센터">
                        </div>
                    </div>
                </div>
            </div><!-- content // -->

            <!-- content // certification_3 -->
            <div id="certification_3" class="comm-layer-popup full-layer-popup">
                <div class="content-wrap">
                    <div class="content">
                        <div class="head">
                            <h3 class="title">
                                농촌융복합사업자인증제
                            </h3>
                            <button type="button" class="close">
                                <img src="/images/mw/icon/close/dark-gray.png" alt="닫기" onclick="itemSingleHide('.full-layer-popup');">
                            </button>
                        </div>
                        <div class="detail-header">
                            <img src="/images/mw/agriculture/certification_3.jpg" alt="6차산업인증제란?">
                        </div>
                    </div>
                </div>
            </div><!-- content // -->
        </div><!-- framing introd // -->
    </div><!-- //hotel-info -->

    <!-- promotion/best -->
    <div class="sv-List mw-list-area">
        <div class="according">
            <div class="sv-list">
                <div class="con-header">
                    <p class="con-title"><span>이시간 남들보다 </span>똑똑한 쇼핑</p>
                </div>
                <div id="pop_Slider1" class="swiper-container">
                    <ul class="swiper-wrapper">
                        <c:forEach var="rcmdList" items="${mainCtgrRcmdList}" varStatus="status" end="10">
                            <li class="swiper-slide">
                                <a href="<c:url value='/mw/sv/detailPrdt.do?prdtNum=${rcmdList.prdtNum}'/>">
                                    <div class="main-photo">
                                    	<c:choose>
                                    		<c:when test="${status.count < 3}">
                                    			<img src="${rcmdList.imgPath}" alt="${rcmdList.prdtNm}" onerror="this.src='/images/web/other/no-image.jpg'">
                                    		</c:when>
                                    		<c:otherwise>
                                    			<img src="${rcmdList.imgPath}" alt="${rcmdList.prdtNm}" loading="lazy" onerror="this.src='/images/web/other/no-image.jpg'">
                                    		</c:otherwise>
                                    	</c:choose>
                                    </div>
                                    <div class="main-text">
                                        <div class="j-info">${rcmdList.prdtExp}</div>
                                        <div class="j-title">${rcmdList.prdtNm}</div>
                                        <div class="main-price"><fmt:formatNumber value="${rcmdList.saleAmt}"/><span class="won">원~</span></div>
                                    </div>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div><!--//promotion/best -->

    <!-- line-banner -->
    <div class="beyondfarm">
        <div class="content__banner-inner">
            <img class="middle_banner" src="/images/mw/agriculture/beyond.png" loading="lazy" alt="6차산업인증 비욘드팜">
            <div class="txt">
                <div class="line"></div>
                대한민국정부가 인정한 농촌융복합산업 사업자가 만든 제품에 표기하는 브랜드 표시로
                비욘드팜이 붙은 제품은 <p>각 지역의 신선한 농촌산물을 활용해서 그 원물의 특성을 가장 잘 아는
                농업인이 정성들여 만들어낸 제품</p>
            </div>
        </div>
    </div><!-- //line-banner -->

    <!-- popularity trip -->
    <div class="theme-push">
        <div class="con-header">
            <p class="theme-con-title">
                <span>인기트립</span>
            </p>
        </div>
        <ul class="popularity--trip">
            <li class="">
                <a href="/mw/sv/sixProductList.do?sCtgr=SVC8">
                    <img src="/images/mw/agriculture/life_banner.jpg" loading="lazy" alt="생활">
                    <div class="article">
                        <div class="txt_box">
                            <h3>생 활</h3>
                            <p>#화장품 #마유 #염색</p>
                        </div>
                        <div class="discount-rate">
                            최대 ~30%
                        </div>
                    </div>
                </a>
            </li>
            <li class="">
                <a href="/mw/sv/sixProductList.do?sCtgr=SPC1">
                    <img src="/images/mw/agriculture/experience_banner.jpg" loading="lazy" alt="체험">
                    <div class="article">
                        <div class="txt_box">
                            <h3>체 험</h3>
                            <p>#가공제품 #체험키트 #체험프로그램</p>
                        </div>
                        <div class="discount-rate">
                            최대 ~40%
                        </div>
                    </div>
                </a>
            </li>
        </ul>
    </div><!-- //popularity trip -->

    <!-- theme product -->
    <div class="theme-product_wrap">
        <div class="con-header">
            <p class="theme-con-title"><span><em>테마</em>추천상품</span></p>
            <p class="con-sub-title">청정지역 제주가 생산한 기념품까지 받아볼 수 있는 직배송</p>
        </div>
        <div class="menu-typeA">
            <!-- theme_scroll-menu -->
            <nav class="theme_scroll-menu">
                <div class="category-menu">
                    <ul class="list-tag">
                        <li class="prd-tab">
                            <c:forEach items="${tsCdList }" var="crtn" varStatus="status" end="3">
                                <a href="javascript:fn_SvSearchNoSrc('${crtn.cdNum}')">
                                    <div>${crtn.cdNmLike }</div>
                                </a>
                            </c:forEach>
                        </li>
                    </ul>
                </div>
                <span class="side-bg"></span>
                <span class="side-bg"></span>
            </nav><!-- //theme_scroll-menu -->
        </div>

        <!-- keyword_thumb ornament -->
        <div id="div_productAjax" class="keyword_thumb ornament"></div>
    </div><!-- //theme product -->

    <!-- 푸터 s -->
    <jsp:include page="/mw/foot.do" />
    <!-- 푸터 e -->
<script>
	$(document).ready(function () {
	    /**6차산업인증 소개 슬라이드*/
	    if ($('#ac_top_slider .swiper-slide').length > 1) {
	        new Swiper('#ac_top_slider', {
                pagination: '#infoSlider',
                paginationClickable: true,
                autoplay: 5000,
                loop: true,
                paginationType: 'fraction' // 'bullets' or 'progress' or 'fraction' or 'custom'
            });
	    }

	    /**특산/기념품 기획전 슬라이드*/
	    if ($('#main_top_slider .swiper-slide').length > 1) {
	        new Swiper('#main_top_slider', {
	            pagination: '#main_top_navi',
	            paginationClickable: true,
	            /*			autoplay: 5000,*/
	            loop: true,
                paginationType: 'fraction' // 'bullets' or 'progress' or 'fraction' or 'custom'
	        });
	    }
	
	    doSwiper();
	
	    //테마 추천 상품 List (첫번째 테마 상품 리스트 노출)
	    fn_SvSearchNoSrc("${crtnNum}");
	
	    $(".list-tag li a:first").addClass("active");
	    $(".list-tag li a").click(function () {
	        if (!($(this).hasClass("active"))) {
	            $(".list-tag li a.active").removeClass("active");
	            $(this).addClass("active");
	        }
	    });
	})
	
	// Hide Header on on scroll down
	var didScroll;
	var lastScrollTop = 0;
	var delta = 5;
	var navbarHeight = $('.head-wrap').outerHeight();
	
	$(window).scroll(function (event) {
	    didScroll = true;
	});
	
	setInterval(function () {
	    if (didScroll) {
	        hasScrolled();
	        didScroll = false;
	    }
	}, 250);
	
	/*** 찜한 상품 ***/
	function fn_SvAddPocket(){
	    var pocket = [{
	        prdtNum 	: "<c:out value='${prdtInfo.prdtNum}'/>",
	        prdtNm 		: "<c:out value='${prdtInfo.prdtNm}'/>",
	        corpId 		: "<c:out value='${prdtInfo.corpId}'/>",
	        corpNm 		: "<c:out value='${prdtInfo.corpNm}'/>",
	        prdtDiv 	: "${Constant.SV}"
	    }];
	
	    fn_AddPocket(pocket);
	}
	
	// 화면 사이즈별 슬라이드 설정
	var screenWidth = 360;
	var slideCnt = 2;
	var swiper1 = null;
	
	function doSwiper() {
	    screenWidth = $(window).width();
	
	    if (screenWidth < 720) {
	        slideCnt = 2;
	    } else {
	        slideCnt = 3;
	    }
	
	    /**카테고리별 추천상품*/
	    if ($('#pop_Slider1 .swiper-slide').length > 1) {
	        if (swiper1 != null) {
	            swiper1.destroy();
	        }
	        swiper1 = new Swiper('#pop_Slider1', {
	            spaceBetween: 20,
	            slidesPerView: slideCnt,
	            paginationClickable: true,
	            loop: true
	        });
	    }
	}
	
	function fn_SvSearchNoSrc(ctgr) {
	    let parameters = "totSch=SV&orderCd=${Constant.ORDER_GPA}&sCtgr=" + ctgr;
	    $.ajax({
	        type   : "post",
	        url    : "<c:url value='/mw/sv/sixProductList.ajax'/>",
	        data   : parameters,
	        success: function (data) {
	            $("#div_productAjax").html(data);
	        },
	        error  : function (request, status, error) {
	            //    alert("code:"+request.status+"\n"+"\n"+"error:"+error);
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
</script>
</div> <!-- //wrap -->
</body>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'TNdyOePATUamc8VWDrd-ww'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>