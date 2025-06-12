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
    <jsp:param name="title" value="제주도 공공플랫폼 탐나오 특산기념품 농수산물 배송 - 탐나는전 공식사용 온라인플랫폼"/>
    <jsp:param name="description" value="계절에 따라 감귤, 초당옥수수, 은갈치등 그리고 사계절 즐길 수 있는 흑돼지등 여러가지 특산기념품을 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 빠르고 안전하게 배송받을 수 있습니다."/>
    <jsp:param name="keywords" value="제주,제주도,감귤,오메기떡,은갈치,흑돼지"/>
</jsp:include>
<meta property="og:title" content="제주도 공공플랫폼 탐나오 특산기념품 농수산물 배송 - 탐나는전 공식사용 온라인플랫폼" >
<meta property="og:url" content="https://www.tamnao.com/mw/goods/jeju.do">
<meta property="og:description" content="계절에 따라 감귤, 초당옥수수, 은갈치등 그리고 사계절 즐길 수 있는 흑돼지등 여러가지 특산기념품을 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 빠르고 안전하게 배송받을 수 있습니다." >
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">
   
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/sv.css?version=${nowDate}' />">
<link rel="canonical" href="https://www.tamnao.com/web/goods/jeju.do">
<%--<script src="/js/swiper.8.4.3.js"></script>--%>
</head>
<body class="main">
<div id="hotel-sub" class="m_wrap">
    <jsp:include page="/mw/newMenu.do"></jsp:include>
    <!-- //header -->
    <!-- GNB -->
    <nav class="navigation">
        <ol class="category-bar">
            <li class="navigation_tab">
                <a href="/mw/av/mainList.do" class="navigation_title">
                    <span>항공</span>
                </a>
            </li>
            <li class="navigation_tab">
                <a href="/mw/stay/jeju.do" class="navigation_title">
                    <span>숙소</span>
                </a>
            </li>
            <li class="navigation_tab">
                <a href="/mw/rentcar/jeju.do" class="navigation_title">
                    <span>렌터카</span>
                </a>
            </li>
            <li class="navigation_tab">
                <a href="/mw/tour/jeju.do" class="navigation_title">
                    <span>관광지/레저</span>
                </a>
            </li>
            <li class="navigation_tab active-tab">
                <a href="/mw/goods/jeju.do" class="navigation_title">
                    <span>특산/기념품</span>
                </a>
            </li>
        </ol>
    </nav><!-- //GNB -->

    <!-- key-visual -->
    <div class="sv-panels-new">
        <div class="main-list">
            <div class="main-top-slider">
                <div id="main_top_slider" class="swiper-container">
                    <ul class="swiper-wrapper">
                        <c:forEach items="${bannerTop}" var="bannerTop" varStatus="status">
                            <li class="swiper-slide">
                                <div class="Fasten">
                                    <a href="${bannerTop.url}">
                                    	<c:choose>
                                    		<c:when test="${status.count < 2}">
                                    			<img src="<c:url value='${bannerTop.imgPath}${bannerTop.imgFileNm}' />" alt="특산/기념품 기획전 이벤트${status.count}">
                                    		</c:when>
                                    		<c:otherwise>
                                    			<img src="<c:url value='${bannerTop.imgPath}${bannerTop.imgFileNm}' />" loading="lazy" alt="특산/기념품 기획전 이벤트${status.count}">
                                    		</c:otherwise>
                                    	</c:choose>
                                    </a>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <div id="main_top_navi" class="swiper-pagination"></div>
                </div>
            </div>
        </div>
    </div><!-- //key-visual -->

    <!-- 카테고리 메뉴 -->
    <div class="menu-typeA">
        <nav id="sv_scroll_menu" class="sv_scroll-menu">
            <div class="score-area category-menu">
                <ul>
                    <li class="active">
                        <a class="active" href="/mw/sv/productList.do?sCtgr=S100&sSubCtgr=S110">
                            <img src="../../../images/mw/from/product/Agricultural-product.png" alt="농산품아이콘">
                            <div>농산품</div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S100&sSubCtgr=S120">
                            <img src="../../../images/mw/from/product/seafood.png" alt="수산품아이콘">
                            <div>수산품</div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S100&sSubCtgr=S130">
                            <img src="../../../images/mw/from/product/livestock.png" alt="축산품아이콘">
                            <div>축산품</div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S400&sSubCtgr=S470">
                            <img src="../../../images/mw/from/product/rice-cake.png" alt="오메기떡/기정떡아이콘">
                            <div>오메기떡 <p>기정떡</p></div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S400&sSubCtgr=S480">
                            <img src="../../../images/mw/from/product/side-dish.png" loading="lazy" alt="반찬/젓갈/간편식아이콘">
                            <div>반찬/젓갈<p>간편식</p></div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S400&sSubCtgr=S490">
                            <img src="../../../images/mw/from/product/soy-sauce.png" loading="lazy" alt="양념/가루/오일아이콘">
                            <div>양념 <p>가루/오일</p></div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S400&sSubCtgr=S430">
                            <img src="../../../images/mw/from/product/snack.png" loading="lazy" alt="간식/유제품아이콘">
                            <div>간식 <p>유제품</p></div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S400&sSubCtgr=S440">
                            <img class="coffee" src="../../../images/mw/from/product/coffee.png" loading="lazy" alt="커피/차/음료아이콘">
                            <div>커피/차 <p>음료</p></div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S400&sSubCtgr=S420">
                            <img src="../../../images/mw/from/product/honey.png" loading="lazy" alt="꿀/잼아이콘">
                            <div>꿀/잼</div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S400&sSubCtgr=S460">
                            <img src="../../../images/mw/from/product/health-food.png" loading="lazy" alt="건강식품아이콘">
                            <div>건강식품</div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S500">
                            <img src="../../../images/mw/from/product/cosmetics.png" loading="lazy" alt="화장품/미용아이콘">
                            <div>화장품/미용</div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S600">
                            <img class="souvenir" src="../../../images/mw/from/product/souvenir.png" loading="lazy" alt="제주기념품아이콘">
                            <div>기념품<p>공예품</p></div>
                        </a>
                    </li>
                    <li>
                        <a href="/mw/sv/productList.do?sCtgr=S600&sSubCtgr=S630">
                            <img src="../../../images/mw/from/product/pet.png" loading="lazy" alt="반려동물용품아이콘">
                            <div>반려동물 <p>용품</p></div>
                        </a>
                    </li>
                </ul>
            </div>
            <span class="side-bg"></span>
            <span class="side-bg"></span>
        </nav>
    </div><!-- //카테고리 메뉴 -->

    <!-- promotion/best -->
    <div class="sv-List mw-list-area">
        <div class="according">
            <div class="sv-list">
                <div class="con-header">
                    <p class="con-title">Hot! <span>카테고리별</span> 추천상품</p>
                </div>
                <div id="pop_Slider1" class="swiper-container">
                    <ul class="swiper-wrapper">
                        <c:forEach var="rcmdList" items="${mainCtgrRcmdList}" varStatus="status" end="7">
                        <li class="swiper-slide">
                            <a href="<c:url value='/mw/sv/detailPrdt.do?prdtNum=${rcmdList.prdtNum}'/>">
                                <div class="main-photo">
                                	<c:choose>
                                		<c:when test="${status.count < 3}">
                                			<img src="${rcmdList.imgPath}" alt="기획전" onerror="this.src='/images/web/other/no-image.jpg'">
                                		</c:when>
                                		<c:otherwise>
                                			<img src="${rcmdList.imgPath}" loading="lazy" alt="기획전" onerror="this.src='/images/web/other/no-image.jpg'">
                                		</c:otherwise>
                                	</c:choose>
                                    
                                </div>
                                <div class="main-text">
                                    <div class="j-info"><c:out value="${rcmdList.prdtExp}" default="　"/></div>
                                    <div class="j-title"><c:out value="${rcmdList.prdtNm}"/></div>
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
    <div>
        <div class="main-top-slider">
            <div id="line_top_slider" class="swiper-container">
                <ul class="swiper-wrapper">
                    <c:forEach items="${bannerLine}" var="bannerLine" varStatus="status" end="1">
                    <li class="swiper-slide">
						<%--
                        <a href="${bannerLine.url}" class="">
                            <div class="line-banner brand-new">
                                <img class="" src="<c:url value='${bannerLine.imgPath}${bannerLine.imgFileNm}' />" alt="특산/기념품배너">
                            </div>
                        </a>
						--%>

                        <a href="${bannerLine.url}" class="">
                            <div class="line-banner brand-new">
                                <img class="sv-pic" src="../../../images/mw/from/product/sv-pic-ticket.png" alt="당일특가">
                                <em>신규상품 5% 할인 혜택</em>
                                <img class="sv-icon" src="../../../images/mw/from/product/sv-pic-brand.png" alt="당일특가">
                            </div>
                        </a>
                    </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div><!-- //line-banner -->

    <!-- theme product -->
    <div class="theme-product_wrap">
        <div class="con-header">
            <p class="theme-con-title"><span>테마 추천 상품</span></p>
            <p class="con-sub-title">청정지역 제주가 생산한 기념품까지 받아볼 수 있는 직배송!</p>
        </div>
        <div class="menu-typeA">
            <!-- theme_scroll-menu -->
            <nav class="theme_scroll-menu">
                <div class="score-area category-menu">
                    <ul class="list-tag">
                        <c:forEach items="${crtnList }" var="crtn" varStatus="status" end="3">
                            <li class="prd-tab">
                                <a href="javascript:fn_SvSearchNoSrc('${crtn.crtnNum}')">${crtn.crtnNm }</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <span class="side-bg"></span>
                <span class="side-bg"></span>
            </nav><!-- //theme_scroll-menu -->
        </div>

        <!-- 1012 테마추천상품 수정 -->
        <div id="div_productAjax" class="keyword_thumb ornament">
        </div><!-- //keyword_thumb-1 -->
    </div><!-- //theme product -->

    <!-- 브랜드관 -->
    <section class="brand-wrap">
        <div class="con-header">
            <img src="../../../images/mw/from/banner/brand_tamnao.png" loading="lazy" alt="브랜드관">
            <span>브랜드관</span>
        </div>

        <!-- 1007 pagination-brand-tab -->
        <div class="pagination-brand-tab">
            <ul class="list-tag">
                <li class="swiper-pagination-brand"></li>
            </ul>
        </div><!-- //1007 pagination-brand-tab -->

        <!-- main-hit-brand -->
        <div class="sv-top-slider">
            <div id="pop_Slider4" class="swiper-container swiper-container-horizontal">
                <ul class="list__item-tab swiper-wrapper">
                <c:forEach var="brandList" items="${mainBrandList}" varStatus="status">
                    <li class="tab-content swiper-slide mySlides">
                        <div class="main-hit-brand ">
                            <!-- index-item__wrap -->
                            <div class="index-item__wrap">
                                <div class="production-item-image">
                                    <img src="/data/brand/${brandList.cardImgFileNm}" loading="lazy" alt="${brandList.corpAliasNm}" >
                                </div>
                                <div class="production-item-content">${brandList.corpAliasNm}</div>
                                <h2 class="item-header">${fn:replace(brandList.cardContent, newLine, '<br/>')}</h2>
                                <span class="item_article">${brandList.cardTitle}</span>
                                <a href="/mw/sv/productList.do?sCorpId=${brandList.corpId}&sFlag=Brd&orderCd=NEW"><p class="view-more">더보기</p></a>
                            </div><!-- //index-item__wrap -->
                            <!-- index-item__goods -->

                            <div class="index-item__goods">
                                <div class="prd_list">
                                    <ul class="prd_list">
                                    <c:forEach var="map" items="${arrBrandGoodsList}">
                                        <c:if test="${map.key eq brandList.corpId}">
                                            <c:forEach var="brandGoodsList" items="${map.value}">
                                                <li class="goods-list-thumb">
                                                    <a href="<c:url value='/mw/sv/detailPrdt.do?prdtNum=${brandGoodsList.prdtNum}'/>" class="thumb">
                                                        <img src="${brandGoodsList.savePath}thumb/${brandGoodsList.saveFileNm}" loading="lazy" alt="${brandGoodsList.prdtNm}" onerror="this.src='/images/web/other/no-image.jpg'">
                                                    </a>
                                                    <div class="info">
                                                        <p class="j-title">${brandGoodsList.prdtNm}</p>
                                                        <span class="main-price"><fmt:formatNumber value="${brandGoodsList.saleAmt}"/>원</span>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </c:if>
                                     </c:forEach>
                                    </ul>
                                </div><!-- //prd_list -->
                            </div><!-- //index-item__goods -->
                        </div>
                    </li><!-- //main-hit-brand -->
                </c:forEach>
                </ul>
                <div class="caption-container">
                    <p id="caption"></p>
                </div>
            </div>
        </div>
    </section><!-- //브랜드관 -->
    <!-- 푸터 s -->
    <jsp:include page="/mw/foot.do" />
    <!-- 푸터 e -->
</div> <!-- //wrap -->
<script>

    // Hide Header on on scroll down
    var lastScrollTop = 0;
    var delta = 5;
    var navbarHeight = $('.head-wrap').outerHeight();

    $(window).scroll(function (event) {
        var st = $(this).scrollTop();

        if (Math.abs(lastScrollTop - st) <= delta)
            return;

        if (st > lastScrollTop && st > navbarHeight) {
            // Scroll Down
            $('.head-wrap').removeClass('nav-down').addClass('nav-up');
        } else {
            // Scroll Up
            if (st + $(window).height() < $(document).height()) {
                $('.head-wrap').removeClass('nav-up').addClass('nav-down');
            }
        }
        lastScrollTop = st;
    });

    // 화면 사이즈 변경 이벤트
    $(window).resize(function () {
        var screenWidth2 = $(window).width();

        if (screenWidth2 >= 720) {
            if (screenWidth < 720) {
                doSwiper();
            }
        } else {
            if (screenWidth >= 720) {
                doSwiper();
            }
        }
        $(".bx-wrapper").css("max-width", screenWidth2);
    });

    $(document).ready(function () {

        /**특산/기념품 기획전 슬라이드*/
        if ($('#main_top_slider .swiper-slide').length > 1) {
            new Swiper('#main_top_slider', {
                pagination: '#main_top_navi',
                paginationClickable: true,
                autoplay: 5000,
                loop: true,
                paginationType: 'fraction' // 'bullets' or 'progress' or 'fraction' or 'custom'
            });
        }

        /**띠 배너 슬라이드*/
        if ($('#pop_Slider3 .swiper-slide').length > 1) {
            new Swiper('#pop_Slider3', {
                pagination: '#line_top_navi',
                paginationClickable: true,
                /*			autoplay: 5000,*/
                loop: true
            });
        }

        /**브랜드관 슬라이드*/
        //브랜드관 이름 get
        const arrBrandNm = [];
        <c:forEach items="${arrBrandNm}" var="item">
        arrBrandNm.push('${item}');
        </c:forEach>

        //브랜드관 슬라이드
        if ($('#pop_Slider4 .swiper-slide').length > 1) {
            new Swiper('#pop_Slider4', {
                pagination: {
                    el          : ".swiper-pagination-brand",
                    clickable   : true,
                    renderBullet: function (index, className) {
                        return '<span class="' + className + '">' + arrBrandNm[index] + "</span>";
                    },
                }, loop:true,
                autoplay           : 6000
            });
        }

        /* 브랜드관 로고 */
        if ($('#brandList .swiper-slide').length > 6) {
            new Swiper("#brandList", {
                slidesPerView         : 6,
                slidesPerGroup        : 6,
                loopFillGroupWithBlank: true,
                nextButton            : '#main_top_prev',
                prevButton            : '#main_top_next'
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

    function hasScrolled() {
        var st = $(this).scrollTop();

        // Make sure they scroll more than delta
        if (Math.abs(lastScrollTop - st) <= delta)
            return;

        // If they scrolled down and are past the navbar, add class .nav-up.
        // This is necessary so you never see what is "behind" the navbar.
        if (st > lastScrollTop && st > navbarHeight) {
            // Scroll Down
            $('.head-wrap').removeClass('nav-down').addClass('nav-up');
        } else {
            // Scroll Up
            if (st + $(window).height() < $(document).height()) {
                $('.head-wrap').removeClass('nav-up').addClass('nav-down');
            }
        }
        lastScrollTop = st;
    }

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

    function fn_SvSearchNoSrc(crtnNum) {
        var parameters = "totSch=SVIntro&orderCd=${Constant.ORDER_GPA}&sCrtnNum=" + crtnNum;
        $.ajax({
            type   : "post",
            url    : "<c:url value='/mw/sv/productList.ajax'/>",
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
</body>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'TNdyOePATUamc8VWDrd-ww'
    };
</script>
<script async type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js"></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>