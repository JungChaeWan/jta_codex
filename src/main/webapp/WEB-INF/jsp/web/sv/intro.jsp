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
<% pageContext.setAttribute("newLine", "\n"); %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<jsp:include page="/web/includeJs.do">
    <jsp:param name="title" value="제주도 공공플랫폼 탐나오 특산기념품 농수산물 배송 - 탐나는전 공식사용 온라인플랫폼"/>
    <jsp:param name="description" value="계절에 따라 감귤, 초당옥수수, 은갈치등 그리고 사계절 즐길 수 있는 흑돼지등 여러가지 특산기념품을 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오는 탐나는전 공식 온라인 사용처입니다."/>
    <jsp:param name="keywords" value="제주,제주도,감귤,오메기떡,은갈치,흑돼지"/>
</jsp:include>
<meta property="og:title" content="제주도 공공플랫폼 탐나오 특산기념품 농수산물 배송 - 탐나는전 공식사용 온라인플랫폼" >
<meta property="og:url" content="https://www.tamnao.com/web/goods/jeju.do">
<meta property="og:description" content="계절에 따라 감귤, 초당옥수수, 은갈치등 그리고 사계절 즐길 수 있는 흑돼지등 여러가지 특산기념품을 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오는 탐나는전 공식 온라인 사용처입니다." >
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/main.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sv.css?version=${nowDate}'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>"> --%>
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>"> --%>
<link rel="canonical" href="https://www.tamnao.com/web/goods/jeju.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/goods/jeju.do">
</head>
<body>
<header id="header">
    <jsp:include page="/web/head.do"></jsp:include>
</header>
<div id="sv_wrap">
    <!-- svmain-renewal -->
    <div class="svmain_topslide">
        <div class="_svmain_topslide_list">
            <!-- lnb(snb) -->
            <article class="sv_lnb">
                <ul class="sv_lnb_ul_0">
                    <li class="sv_lnb_li agricultural">
                        <a class="sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S100&sSubCtgr=S110">
                            <span class="sv_lnb_text">농산품</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li seafood">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S100&sSubCtgr=S120">
                            <span class="sv_lnb_text">수산품</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li livestock">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S100&sSubCtgr=S130">
                            <span class="sv_lnb_text">축산품</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li mochi">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S400&sSubCtgr=S470">
                            <span class="sv_lnb_text">오메기떡/기정떡</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li dish">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S400&sSubCtgr=S480">
                            <span class="sv_lnb_text">반찬/젓갈/간편식</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li oil">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S400&sSubCtgr=S490">
                            <span class="sv_lnb_text">양념/가루/오일</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li snack">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S400&sSubCtgr=S430">
                            <span class="sv_lnb_text">간식/유제품</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li drink">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S400&sSubCtgr=S440">
                            <span class="sv_lnb_text">커피/차/음료</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li jam">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S400&sSubCtgr=S420">
                            <span class="sv_lnb_text">꿀/잼</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li health">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S400&sSubCtgr=S460">
                            <span class="sv_lnb_text">건강식품</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li skin">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S500">
                            <span class="sv_lnb_text">화장품/미용</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li souvenir">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S600">
                            <span class="sv_lnb_text">제주 기념품/공예품</span>
                        </a>
                    </li>
                    <li class="sv_lnb_li pet">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/productList.do?sCtgr=S600&sSubCtgr=S630">
                            <span class="sv_lnb_text">반려동물용품</span>
                        </a>
                    </li>
                </ul>
            </article><!-- //lnb(snb) -->

            <!-- topslide_swiper-container -->
            <div class="swiper-container">
                <c:forEach items="${bannerTop }" var="bannerTop" varStatus="status">
                <div class="mySlides <c:if test="${status.count eq 1}">viewPoint</c:if>">
                    <a href="${bannerTop.url}"><img src="<c:url value='${bannerTop.imgPath}${bannerTop.imgFileNm}' />" width="1903" height="585" <c:if test="${status.count ne 1}">loading="lazy"</c:if> alt="특산/기념품 기획전 이벤트"></a>
                </div>
                </c:forEach>
                <div class="caption-container">
                    <p id="caption"></p>
                </div>

                <!-- topslide_swiper-nav -->
                <div class="svmain_topslide_nav">
                    <div class="pass_over">

                        <!-- topslide_swiper-container_ctrl -->
                        <div class="svmain_topslide_ctrl add-control">
                            <div class="svmain_topslide_pager">
                                <c:forEach items="${bannerTop }" var="bannerTop" varStatus="status">
                                <div class="svmain_pager_tx">
                                    <p class="demo <c:if test="${status.count eq 1}">active</c:if>" onclick="currentSlide(${status.count})">
                                        <span>${bannerTop.bannerNm}</span>
                                    </p>
                                </div>
                                </c:forEach>
                            </div>
                            <div class="arrow_ctrl">
                                <span class="prev" onclick="plusSlides(-1)">
                                    <span class="swiper-button-prev"></span>
                                </span>
                                <span class="next" onclick="plusSlides(1)">
                                    <span class="swiper-button-next"></span>
                                </span>
                            </div>
                        </div>
                    </div><!-- //topslide_swiper-container_ctrl -->
                </div>
            </div><!-- //topslide_swiper-nav -->
        </div><!-- //topslide_swiper-container -->
    </div>
</div>

<!-- Best Category -->
<div class="categoryBestSection thickness">
    <div class="inner">
        <h2>Hot! <span class="title">카테고리별 </span> 추천상품</h2>
        <div class="product-area">
            <div id="product_theme" class="swiper-container swiper-container-horizontal">
                <ul class="swiper-wrapper">
                    <c:forEach var="rcmdList" items="${mainCtgrRcmdList}" varStatus="status" end="7">
	                    <li class="swiper-slide" style="margin-right:37px;">
	                        <a href="<c:url value='/web/sv/detailPrdt.do?prdtNum=${rcmdList.prdtNum}'/>" target="_self">
	                            <div class="photo">
	                                <img src="${rcmdList.imgPath}" alt="product" width="215" height="215" onerror="this.src='/images/web/other/no-image.jpg'">
	                            </div>
	                            <div class="bx-info">
	                                <div class="text__name"><c:out value="${rcmdList.prdtNm}"/></div>
	                                <div class="text__memo"><c:out value="${rcmdList.prdtExp}" default="　"/></div>
	                                <div class="box__price">
	                                    <span class="text__price"><fmt:formatNumber value="${rcmdList.saleAmt}"/></span>
	                                    <span class="text__unit">원</span>
	                                </div>
	                            </div>
	                        </a>
	                    </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="arrow-box" >
                <div id="theme_next" class="swiper-button-next"></div>
                <div id="theme_prev" class="swiper-button-prev"></div>
            </div>
        </div>
    </div>
</div>
<!-- //Best Category -->

<!-- 광고 banner -->
<div class="content__banner">
    <div class="content__banner-inner">
        <c:forEach items="${bannerLine }" var="bannerLine" varStatus="status" end="1">
        <a href="${bannerLine.url}" class="inner--link" target="_blank">
            <img class="middle_banner" src="<c:url value='${bannerLine.imgPath}${bannerLine.imgFileNm}' />" width="1920" height="150" alt="특산/기념품배너">
        </a>
        </c:forEach>
    </div>
</div><!-- //광고 banner -->

<!-- themed merchandise -->
<div class="theme-push">
    <div class="ftLt">
        <h2>
            <strong>
                테마 추천 상품
            </strong>
        </h2>
        <p class="desc">
            청정지역 제주가 생산한
            <br>
            기념품까지 받아볼 수 있는 직배송
        </p>
        <ul class="list-tag">
            <c:forEach items="${crtnList }" var="crtn" varStatus="status" end="3">
            <li>
                <a href="javascript:fn_SvSearchNoSrc('${crtn.crtnNum}')">${crtn.crtnNm }</a>
            </li>
            </c:forEach>
        </ul>
    </div>
    <div class="ftRt">
        <div class="item-area">
            <ul class="col4" id="div_productAjax"></ul>
        </div>
    </div>
</div><!-- //themed merchandise -->

<!-- brand building -->
<div class="brand-wrap">
    <div class="brand-inner">
        <div class="box__brandshop">
            <h2 class="text__title">
                <img src="../../images/web/sv-intro/brand_tamnao.png"width="143" height="25" alt="brand_tamnao">
                <span class="text__sub">브랜드관</span>
            </h2>
            <a href="/web/sv/productList.do?sCorpId=${corpId}&sFlag=Brd&orderCd=NEW" class="product__homemain--after link__more">바로가기</a>

            <!-- logo play -->
            <div id="brandList" class="swiper-container swiper-container-horizontal">
                <ul class="list__item-tab swiper-wrapper" >
                    <c:forEach var="brandList" items="${mainBrandList}" varStatus="status">
                    <li class="tab-link swiper-slide <c:if test="${status.count eq 1}">active</c:if>" data-tab="tab-${status.count}" id="li-tab-${status.count}">
                        <div class="box__item-header">
                            <span class="link__tab">
                                <span class="product__homemain">
                                    <img src="/data/brand/${brandList.logoImgFileNm}" alt="${brandList.corpAliasNm}">
                                </span>
                            </span>
                        </div>
                    </li>
                    </c:forEach>
                </ul>
            </div><!-- //logo play -->
            <div id="brand_product_arrow" class="arrow-box">
                <div id="logo_next" class="swiper-button-next"></div>
                <div id="logo_prev" class="swiper-button-prev"></div>
            </div>
            <!-- brand content -->
            <div class="box__item-tab">
                <ul class="list__item-tab">
                    <c:forEach var="brandList" items="${mainBrandList}" varStatus="status">
                    <li id="tab-${status.count}" class="tab-content <c:if test="${status.count eq 1}">current</c:if>">
                        <div class="box__item-banner box__swiper-area">
                            <p class="text__title">${brandList.cardSlogan}</p>
                            <div class="box__swiper-container js-swiper-container swiper-container-initialized swiper-container-horizontal">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide swiper-slide-duplicate swiper-slide-prev">
                                        <a href="/web/sv/productList.do?sCorpId=${brandList.corpId}&sFlag=Brd" class="link__item" style="background-color: ${brandList.cardColor}">
                                            <div class="box__information">
                                                        <span class="company__name">
                                                            <span>${brandList.corpAliasNm}</span>
                                                        </span>
                                                <div>
                                                    <div class="text__banner-title">
                                                        <span class="text">${fn:replace(brandList.cardContent, newLine, '<br>')}</span>
                                                    </div>
                                                    <div class="text__banner-sub-title">${brandList.cardTitle}</div>
                                                </div>
                                                <div class="box__image">
                                                    <img src="/data/brand/${brandList.cardImgFileNm}" alt="product" class="image">
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <button type="button" class="button__prev" onclick="fn_brandSlide('prev',${status.count})">
                                    <span class="sr-only">이전</span>
                                </button>
                                <button type="button" class="button__next"  onclick="fn_brandSlide('next', ${status.count})">
                                    <span class="sr-only">다음</span>
                                </button>
                            </div>
                        </div>
                        <div class="box__item-content">
                            <ul class="list__item">
                                <c:forEach var="map" items="${arrBrandGoodsList}">
                                    <c:if test="${map.key eq brandList.corpId}">
                                    <c:forEach var="brandGoodsList" items="${map.value}">
                                        <li class="list-item">
                                            <a href="<c:url value='/web/sv/detailPrdt.do?prdtNum=${brandGoodsList.prdtNum}'/>" class="link__item">
                                                <div class="box__image">
                                                    <img class="image" src="${brandGoodsList.savePath}thumb/${brandGoodsList.saveFileNm}" alt="" onerror="this.src='/images/web/other/no-image.jpg'">
                                                </div>
                                                <div class="box__information">
                                                    <div class="text__tag">
                                                        <c:if test="${brandGoodsList.eventCnt > 0}">
                                                        <span class="main_label1">이벤트</span>
                                                        </c:if>
                                                        <c:if test="${brandGoodsList.couponCnt > 0}">
                                                        <span class="main_label2">할인쿠폰</span>
                                                        </c:if>
                                                        <c:if test="${brandGoodsList.superbSvYn eq 'Y'}">
                                                            <span class="main_label3">수상작</span>
                                                        </c:if>
                                                        <c:if test="${brandGoodsList.superbCorpYn eq 'Y'}">
                                                            <span class="main_label3">우수관광사업체</span>
                                                        </c:if>
                                                        <c:if test="${brandGoodsList.tamnacardYn eq 'Y'}">
                                                            <span class="main_label4">탐나는전</span>
                                                        </c:if>
                                                    </div>
                                                    <div class="text__name">${brandGoodsList.prdtNm}</div>
                                                    <div class="box__price">
                                                        <span class="text__price"><fmt:formatNumber value="${brandGoodsList.saleAmt}"/></span>
                                                        <span class="text__unit">원</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </li>
                    </c:forEach>

                </ul>
            </div><!-- //brand content -->
        </div>
    </div>
</div>
<!-- //brand building -->

<script>

    function closeLayer(obj) {
        $(obj).parent().parent().hide();
    }

    $(document).ready(function () {
    	
        $('#brandList ul.list__item-tab li').click(function () {
            console.log("A");
            const tab_id = $(this).attr('data-tab');

            $('#brandList ul.list__item-tab li').removeClass('current active');
            $('.tab-content').removeClass('current');

            $(this).addClass('current active');
            $("#" + tab_id).addClass('current');
        });
        $(".list-tag li a:first").addClass("active");
        $(".list-tag li a").click(function () {
            if (!($(this).hasClass("active"))) {
                $(".list-tag li a.active").removeClass("active");
                $(this).addClass("active");
            }
        });

        /* Hot! 카테고리별 추천상품 */
        if ($('#product_theme .swiper-slide').length > 5) {
            new Swiper('#product_theme', {
                slidesPerView      : 5,
                spaceBetween       : 30,
                paginationClickable: true,
                nextButton         : '#theme_next',
                prevButton         : '#theme_prev',
                autoplay           : 2000,
                loop: true
            });
        } else {
            $('#theme_arrow').hide();
        }

        /* 브랜드관 로고 */
        if ($('#brandList .swiper-slide').length > 6) {
            new Swiper("#brandList", {
                slidesPerView         : 6,
                slidesPerGroup        : 6,
                loopFillGroupWithBlank: true,
                nextButton            : '#logo_next',
                prevButton            : '#logo_prev'
            });
        } else {
            $('#brand_product_arrow').hide();
        }

        //테마 추천 상품 List (첫번째 테마 상품 리스트 노출)
        fn_SvSearchNoSrc("${crtnNum}");
        
        //메인 배너 롤링
        setInterval(plusSlides, 6000, 1);
        
        //브랜드관 배너 롤링
        setInterval(brandSlides, 6000);
    });
	
    let brandCnt = 2;
    function brandSlides(){
    	var mainBrandListSize = "${fn:length(mainBrandList)}";
    	if(brandCnt > mainBrandListSize){
    		brandCnt = 1;
    	}
    	
    	fn_brandSlide("prev", brandCnt);
    	brandCnt++;
    }
    
    function fn_brandSlide(act, id) {

        let tab_id;
        if (act == "prev") {
            if (id != 1) {
                tab_id = id - 1;
            } else {
                tab_id = $(".tab-link").length;
            }
        }

        if (act == "next") {
            if ($(".tab-link").length > id) {
                tab_id = id + 1;
            } else {
                tab_id = 1;
            }
        }

        $('#brandList ul.list__item-tab li').removeClass('current active');
        $("#li-tab-" + tab_id).addClass('current active');

        $('.tab-content').removeClass('current');
        $("#tab-" + tab_id).addClass('current');
    }

    var slideIndex = 1;
    showSlides(slideIndex);

    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    function currentSlide(n) {
        showSlides(slideIndex = n);
    }

    function showSlides(n) {
        let i;
        const slides = $(".mySlides");
        const dots = $(".demo");

        if (n > slides.length) {
            slideIndex = 1
        }
        if (n < 1) {
            slideIndex = slides.length
        }
        for (i = 0; i < slides.length; i++) {
            slides.eq(i).css("display", "none");
        }
        for (i = 0; i < dots.length; i++) {
            dots.eq(i).removeClass("active");
        }
        slides.eq(slideIndex - 1).css("display", "block");
        dots.eq(slideIndex - 1).addClass("active");
    }

    function fn_SvSearchNoSrc(crtnNum) {
        var parameters = "totSch=SV&orderCd=${Constant.ORDER_GPA}&sCrtnNum=" + crtnNum;
        $.ajax({
            type   : "post",
            url    : "<c:url value='/web/sv/productList.ajax'/>",
            data   : parameters,
            success: function (data) {
                $("#div_productAjax").html(data);
            },
            error  : function (request, status, error) {
                //    alert("code:"+request.status+"\n"+"\n"+"error:"+error);
            }
        });
    }
</script>

<jsp:include page="/web/right.do"></jsp:include>
<jsp:include page="/web/foot.do"></jsp:include>
</body>
</html>