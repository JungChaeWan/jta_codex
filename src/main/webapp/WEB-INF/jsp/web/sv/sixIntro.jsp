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

<un:useConstants var="Constant" className="common.Constant" />
<head>
<jsp:include page="/web/includeJs.do">
    <jsp:param name="title" value="제주 농부의 장, 탐나오"/>
    <jsp:param name="description" value="제주산 원물을 가공한 6차산업 음식품, 농축산물, 생활용품 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 빠르고 안전하게 배송받을 수 있습니다."/>
    <jsp:param name="keywords" value="6차산업,제주,제주도,간식,음료차,식초,유제품,육가공,발효식품,반찬,원물가공,잼,꿀,조청,과일,생활용품,화장품,분재"/>
</jsp:include>
<meta property="og:title" content="제주 농부의 장, 탐나오">
<meta property="og:url" content="https://www.tamnao.com/web/sv/sixIntro.do">
<meta property="og:description" content="제주산 원물을 가공한 음식품, 농축산물, 생활용품 구경하세요. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 빠르고 안전하게 배송받을 수 있습니다." >
<meta property="og:image" content="https://www.tamnao.com/images/web/agriculture/aside_img.png">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" href="/css/web/common.css?version=${nowDate}">
<link rel="stylesheet" href="/css/web/main.css?version=${nowDate}">
<link rel="stylesheet" href="/css/web/agriculture.css?version=${nowDate}">
<link rel="canonical" href="https://www.tamnao.com/web/sv/sixIntro.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/sv/sixIntro.do">
</head>
<body>
<!-- re_header -->
<header id="header">
    <jsp:include page="/web/head.do"></jsp:include>
</header>

<div id="ag_wrap">
    <div class="svmain_topslide">
        <div class="_svmain_topslide_list">

            <!-- lnb(snb) -->
            <article class="sv_lnb">
                <ul class="sv_lnb_ul_0">
                    <li class="sv_lnb_li snack">
                        <a class="sv_lnb_btn_0" href="/web/sv/sixProductList.do?sCtgr=SVC1">
                            <div class="jb-a">
                                <div class="jb-a__size">
                                    <img class="jb-b" src="../../images/web/agriculture/snack.png" width="18" height="16" alt="간식·음료 비활성">
                                    <img class="jb-c" src="../../images/web/agriculture/snack_hover.png" width="18" height="16" alt="간식·음료 활성">
                                </div>
                                <span class="sv_lnb_text">간식·음료</span>
                            </div>
                        </a>
                    </li>
                    <li class="sv_lnb_li tea">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/sixProductList.do?sCtgr=SVC2">
                            <div class="jb-a">
                                <div class="jb-a__size">
                                    <img class="jb-b" src="../../images/web/agriculture/tea.png" width="19" height="18" alt="차·식초 비활성">
                                    <img class="jb-c" src="../../images/web/agriculture/tea_hover.png" width="19" height="18" alt="차·식초 활성">
                                </div>
                                <span class="sv_lnb_text">차·식초</span>
                            </div>
                        </a>
                    </li>
                    <li class="sv_lnb_li fruit">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/sixProductList.do?sCtgr=SVC7">
                            <div class="jb-a">
                                <div class="jb-a__size">
                                    <img class="jb-b" src="../../images/web/agriculture/fruit.png" width="16" height="17" alt="원물·과일 비활성">
                                    <img class="jb-c" src="../../images/web/agriculture/fruit_hover.png" width="16" height="17" alt="원물·과일 활성">
                                </div>
                                <span class="sv_lnb_text">원물·과일</span>
                            </div>
                        </a>
                    </li>
                    <li class="sv_lnb_li tradition">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/sixProductList.do?sCtgr=SVC4">
                            <div class="jb-a">
                                <div class="jb-a__size">
                                    <img class="jb-b" src="../../images/web/agriculture/tradition.png" width="16" height="15" alt="전통·발효식품·반찬 비활성">
                                    <img class="jb-c" src="../../images/web/agriculture/tradition_hover.png" width="16" height="15" alt="전통·발효식품·반찬 활성">
                                </div>
                                <span class="sv_lnb_text">전통·발효식품·반찬</span>
                            </div>
                        </a>
                    </li>
                    <li class="sv_lnb_li cereals">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/sixProductList.do?sCtgr=SVC5">
                            <div class="jb-a">
                                <div class="jb-a__size">
                                    <img class="jb-b" src="../../images/web/agriculture/cereals.png" width="16" height="15" alt="곡류·원물가공식품 비활성">
                                    <img class="jb-c" src="../../images/web/agriculture/cereals_hover.png" width="16" height="15" alt="곡류·원물가공식품 활성">
                                </div>
                                <span class="sv_lnb_text">곡류·원물가공식품</span>
                            </div>
                        </a>
                    </li>
                    <li class="sv_lnb_li jam">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/sixProductList.do?sCtgr=SVC6">
                            <div class="jb-a">
                                <div class="jb-a__size">
                                    <img class="jb-b" src="../../images/web/agriculture/jam.png" width="14" height="14" alt="잼·꿀·당류가공식품 비활성">
                                    <img class="jb-c" src="../../images/web/agriculture/jam_hover.png" width="14" height="14" alt="잼·꿀·당류가공식품 활성">
                                </div>
                                <span class="sv_lnb_text">잼·꿀·당류가공식품</span>
                            </div>
                        </a>
                    </li>
                    <li class="sv_lnb_li livestock">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/sixProductList.do?sCtgr=SVC3">
                            <div class="jb-a">
                                <div class="jb-a__size">
                                    <img class="jb-b" src="../../images/web/agriculture/livestock.png" width="21" height="15" alt="유제품·육가공·축산식품 비활성">
                                    <img class="jb-c" src="../../images/web/agriculture/livestock_hover.png" width="21" height="15" alt="유제품·육가공·축산식품 활성">
                                </div>
                                <span class="sv_lnb_text">유제품·육가공·축산식품</span>
                            </div>
                        </a>
                    </li>
                    <li class="sv_lnb_li life">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/sixProductList.do?sCtgr=SVC8">
                            <div class="jb-a">
                                <div class="jb-a__size">
                                    <img class="jb-b" src="../../images/web/agriculture/life.png" width="16" height="18" alt="생활용품·화장품·천연염색 비활성">
                                    <img class="jb-c" src="../../images/web/agriculture/life_hover.png" width="16" height="18" alt="생활용품·화장품·천연염색 활성">
                                </div>
                                <span class="sv_lnb_text">생활용품·화장품·천연염색</span>
                            </div>
                        </a>
                    </li>
                    <li class="sv_lnb_li experience">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/sixProductList.do?sCtgr=SPC1">
                            <div class="jb-a">
                                <div class="jb-a__size">
                                    <img class="jb-b" src="../../images/web/agriculture/experience.png" width="19" height="15" alt="체험·관광 비활성">
                                    <img class="jb-c" src="../../images/web/agriculture/experience_hover.png" width="19" height="15" alt="체험·관광 활성">
                                </div>
                                <span class="sv_lnb_text">체험·관광</span>
                            </div>
                        </a>
                    </li>
                    <li class="sv_lnb_li kit">
                        <a class="_categoryDepth0 sv_lnb_btn_0" href="/web/sv/sixProductList.do?sCtgr=SVCA">
                            <div class="jb-a">
                                <div class="jb-a__size">
                                    <img class="jb-b" src="../../images/web/agriculture/kit.png" width="14" height="17" alt="체험키트꾸러미 비활성">
                                    <img class="jb-c" src="../../images/web/agriculture/kit_hover.png" width="14" height="17" alt="체험키트꾸러미 활성">
                                </div>
                                <span class="sv_lnb_text">체험키트꾸러미</span>
                            </div>
                        </a>
                    </li>
                </ul>
            </article><!-- //lnb(snb) -->
            <div class="swiper-container">
                <div class="mySlides viewPoint">
                    <img src="../../images/web/main/banner/top/PM00000910.jpg" width="1903" height="420" alt="제주 농부의 장">
                </div>
            </div>
        </div>
    </div>
</div>

<!-- layer popup -->
<!-- certification_1 / 6차산업이란? -->
<div id="certification_1" class="comm-layer-popup_fixed">
    <div class="certification-wrap">
        <div class="table-scroll">
            <button type="button" class="close" onclick="close_popup('#certification_1')">확인</button>
            <img src="../../images/web/agriculture/certification_1.jpg" loading="lazy" alt="6차산업이란">
            <p class="hyper-link">
                <a href="http://www.xn--6-ql4f73knwc95ai5j.com/kor/">페이지 바로가기</a>
            </p>
        </div>
    </div>
</div>
<!-- certification_2 / 6차산업지원센터 -->
<div id="certification_2" class="comm-layer-popup_fixed">
    <div class="certification-wrap">
        <div class="table-scroll">
            <button type="button" class="close" onclick="close_popup('#certification_2')">확인</button>
            <img src="../../images/web/agriculture/certification_2.jpg" loading="lazy" alt="6차산업지원센터">
        </div>
    </div>
</div>
<!-- certification_3 / 6차산업이란? -->
<div id="certification_3" class="comm-layer-popup_fixed">
    <div class="certification-wrap">
        <div class="table-scroll">
            <button type="button" class="close" onclick="close_popup('#certification_3')">확인</button>
            <img src="../../images/web/agriculture/certification_3.jpg" loading="lazy" alt="6차산업이란">
        </div>
    </div>
</div>
<!-- //layer popup -->

<!-- framing introduction -->
<div class="framing--introd">
    <section class="inner">
        <div class="certification">

            <!-- certification_2 -->
            <a class="content" href="javascript:show_popup('#certification_2')">
                <div class="business--info">
                    <div class="image">
                        <img src="../../images/web/agriculture/certification_2.png" width="56" height="56" alt="6차산업지원센터">
                    </div>
                    <div class="article">
                        <h2>제주농촌융복합산업지원센터</h2>
                        <span>농촌관광 활성화 지원 / 인프라 정비</span>
                    </div>
                </div>
            </a>

            <a class="content" href="javascript:show_popup('#certification_1')">
                <div class="business--info">
                    <div class="image">
                        <img src="../../images/web/agriculture/certification_1.png" width="56" height="56" alt="6차산업이란?">
                    </div>
                    <div class="article">
                        <h2>6차산업이란?</h2>
                        <span>농촌융복합산업(6차산업)</span>
                    </div>
                </div>
            </a>

            <!-- certification_3 -->
            <a class="content" href="javascript:show_popup('#certification_3')">
                <div class="business--info">
                    <div class="image">
                          <img src="../../images/web/agriculture/certification_3.png" width="56" height="56" alt="사업자인증제란">
                    </div>
                    <div class="article">
                        <h2>농촌융복합사업자인증제</h2>
                        <span>인증 자격요건 / 신청방법 / 인증절차</span>
                    </div>
                </div>
            </a>
        </div>
    </section><!-- //framing introduction -->

    <!-- Best Category -->
    <div class="categoryBestSection">
        <div class="inner">
            <div class="one-place">
                <div class="left--aside__img">
                    <img src="../../images/web/agriculture/aside_img.png" width="250" height="217" alt="제주농부의 정성과 진심만을 담습니다">
                    <span class="desc">성장 가능성, 기존 제품과의 차별성<br> 정부가 인증합니다.</span>
                </div>
                <div class="product-area">
                    <div id="product_theme" class="swiper-container swiper-container-horizontal">
                        <ul class="swiper-wrapper">
                            <c:forEach var="rcmdList" items="${mainCtgrRcmdList}" varStatus="status" end="10">
                            <li class="swiper-slide">
                                <a href="<c:url value='/web/sv/detailPrdt.do?prdtNum=${rcmdList.prdtNum}'/>">
                                    <div class="photo">
                                        <img src="${rcmdList.imgPath}" width="215" height="215" alt="${rcmdList.prdtNm}" onerror="this.src='/images/web/other/no-image.jpg'">
                                    </div>
                                    <div class="bx-info">
                                        <div class="text__name">${rcmdList.prdtNm}</div>
                                        <div class="text__memo">${rcmdList.prdtExp}</div>
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
    </div><!-- //Best Category -->

    <!-- 광고 banner -->
    <div class="content__banner">
        <div class="content__banner-inner">
            <span class="inner--link">
                <img class="middle_banner" src="/images/web/agriculture/beyondfarm.png" width="1920" height="150" alt="6차산업인증 비욘드팜">
            </span>
        </div>
    </div><!-- //광고 banner -->


    <!-- popularity trip -->
    <section class="theme-push">
        <h2>
            <strong>인기 트립</strong>
        </h2>
        <ul class="popularity--trip">
            <li class="">
                <a href="/web/sv/sixProductList.do?sCtgr=SVC8">
                    <img src="../../images/web/agriculture/experience_banner.jpg" width="590" height="275" loading="lazy" alt="생활">
                    <div class="article">
                        <div class="txt_box">
                            <h3 class="subject">생 활</h3>
                            <p>#화장품 #마유 #염색</p>
                        </div>
                        <div class="discount-rate">
                            최대 ~30%
                        </div>
                    </div>
                </a>
            </li>
            <li class="">
                <a href="/web/sv/sixProductList.do?sCtgr=SPC1">
                    <img src="../../images/web/agriculture/life_banner.jpg" width="590" height="275" loading="lazy" alt="체험">
                    <div class="article">
                        <div class="txt_box">
                            <h3 class="subject">체 험</h3>
                            <p>#감귤체험 #체험키트 #체험프로그램</p>
                        </div>
                        <div class="discount-rate">
                            최대 ~40%
                        </div>
                    </div>
                </a>
            </li>
        </ul>
    </section><!-- //popularity trip -->

    <!-- themed merchandise -->
    <section class="theme-push footer-connection">
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
                <c:forEach items="${tsCdList }" var="crtn" varStatus="status" end="3">
                    <li>
                        <a href="javascript:fn_SvSearchNoSrc('${crtn.cdNum}')">#${crtn.cdNmLike }</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="ftRt">
            <div class="item-area">
                <ul class="col4" id="div_productAjax"></ul>
            </div>
        </div>
    </section><!-- //themed merchandise -->
</div>

<script>

    //팝업 닫기
    function closeLayer( obj ) {
        $('.lock-bg').remove();
        $(obj).hide();
    }

    $(document).ready(function() {
        //테마 추천 상품 List (첫번째 테마 상품 리스트 노출)
        fn_SvSearchNoSrc("${cdNum}");

        $(".list-tag li a:first").addClass("active");
        $(".list-tag li a").click(function () {
            if (!($(this).hasClass("active"))) {
                $(".list-tag li a.active").removeClass("active");
                $(this).addClass("active");
            }
        });

        /* 추천상품 영역 */
        if ($('#product_theme .swiper-slide').length > 4) {
            new Swiper('#product_theme', {
                slidesPerView      : 4,
                spaceBetween       : 18,
                paginationClickable: true,
                nextButton         : '#theme_next',
                prevButton         : '#theme_prev',
                autoplay           : 2000
            });
        } else {
            $('#theme_arrow').hide();
        }

        $('ul.list__item-tab li').click(function(){
            var tab_id = $(this).attr('data-tab');

            $('ul.list__item-tab li').removeClass('current');
            $('.tab-content').removeClass('current');

            $(this).addClass('current');
            $("#"+tab_id).addClass('current');
        });
    });

    function fn_SvSearchNoSrc(ctgr) {
        var parameters = "totSch=SV&orderCd=${Constant.ORDER_GPA}&sCtgr=" + ctgr;
        $.ajax({
            type   : "post",
            url    : "<c:url value='/web/sv/sixProductList.ajax'/>",
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
<div id="_footer" class="footer_wrap">
    <jsp:include page="/web/right.do"></jsp:include>
    <jsp:include page="/web/foot.do"></jsp:include>
</div>
</body>
</html>