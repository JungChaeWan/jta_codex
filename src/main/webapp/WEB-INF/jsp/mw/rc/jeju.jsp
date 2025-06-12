<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<jsp:include page="/mw/includeJs.do">
    <jsp:param name="title" value="제주도렌트카 가격비교 및 할인 예약 - 탐나오 | 추천 렌터카 서비스"/>
    <jsp:param name="description" value="제주 렌트카, 제주여행공공플랫폼 렌트카 예약은 탐나오. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 안전한 예약이 가능합니다."/>
    <jsp:param name="keywords" value="제주렌트카,제주도렌트카,제주렌터카,제주도렌터카,제주도렌트카비용,제주최저가렌트카,제주렌트카가격비교,제주렌트카추천,탐나는전"/>
</jsp:include>
<meta property="og:title" content="제주도렌트카 탐나오: 제주렌트카 가격비교">
<meta property="og:url" content="https://www.tamnao.com/web/rentcar/jeju.do">
<meta property="og:image" content="https://www.tamnao.com/images/web/rent/rent_visual_2.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="800">
<meta property="og:description" content="제주여행공공플랫픔 렌트카 예약은 탐나오. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 안전한 예약이 가능합니다.">
<meta property="og:site_name" content="탐나오 TAMNAO - 제주도 공식 여행 공공 플랫폼">
<meta property="og:type" content="website" />

<jsp:useBean id="today" class="java.util.Date"/>
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Light.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" href="/css/mw/common2.css?version=${nowDate}">
<link rel="stylesheet" href="/css/mw/style.css?version=${nowDate}">
<link rel="stylesheet" href="/css/mw/daterangepicker.css?version=${nowDate}">
<link rel="stylesheet" href="/css/mw/rc.css?version=${nowDate}">
<link rel="canonical" href="https://www.tamnao.com/web/rentcar/jeju.do">
<script type="application/ld+json">
{
    "@context": "https://schema.org/",
    "@type": "TravelAgency",
    "telephone": "1522-3454",
    "logo": "https://www.tamnao.com/images/web/r_main/floating_logo.png",
    "image": "https://www.tamnao.com/images/web/rent/rent_visual_2.png",
    "email": "tamnao@tamnao.com",
    "address": "제주특별자치도 제주시 첨단로 213-65 제주종합비즈니스센터 3층",
    "name": "제주도렌트카 가격비교 및 할인 예약 - 탐나오 | 추천 렌터카 서비스",
    "description": "제주여행공공플랫폼 렌트카 예약은 탐나오. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 안전한 예약이 가능합니다.",
    "url": "https://www.tamnao.com/web/rentcar/jeju.do",
    "keywords": "제주렌트카,제주도렌트카,제주렌터카,제주도렌터카,제주도렌트카비용,제주렌트카가격비교,제주렌트카추천,탐나는전",
    "openingHoursSpecification": {
    "@type": "OpeningHoursSpecification",
    "dayOfWeek": [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday"
        ],
        "opens": "09:00",
        "closes": "18:00"
    },
    "geo": {
        "@type": "GeoCoordinates",
        "latitude": 33.452372,
        "longitude": 126.572763
    },
    "sameAs": [
        "http://www.visitjeju.or.kr",
        "https://www.youtube.com/@tamnaojeju",
        "https://www.instagram.com/tamnao_jeju",
        "https://www.facebook.com/JEJUTAMNAOTRAVEL",
        "https://blog.naver.com/jta0119",
        "https://pf.kakao.com/_xhMCrj"
    ]
}
</script>
<script type="application/ld+json">
{
    "@context": "http://schema.org/",
    "@type": "FAQPage",
    "mainEntity": [
    {
        "@type": "Question",
        "name": "예약자와 운전자가 같아야 하나요?",
        "acceptedAnswer": {
        "@type": "Answer",
        "text": "예약자와 실제 운전자가 달라도 렌트카 대여는 가능합니다.차량 인수 시 현장에서 예약자 정보로 예약 확인이 진행되며, 운전하실 분은 별도로 운전자 등록을 하시면 됩니다. 운전자는 최대 2인까지 등록 가능하며, 도로교통법상 유효한 운전면허증을 반드시 소지하여야 합니다.(렌트카 상품별 대여 조건에 부합한 운전자만 운전자 등록이 가능합니다.)"
        }
    },
    {
        "@type": "Question",
        "name": "외국인도 렌트카 대여가 가능한가요?",
        "acceptedAnswer": {
        "@type": "Answer",
        "text": "렌트카 업체에 따라 외국인은 대여가 제한될 수 있으며, 예약 전 대여 가능 여부 확인이 필요합니다. 대여가 가능한 업체는 외국인의 경우 여권사본 및 유효기간 내의 국제면허증(제네바 및 비엔나 협약국 발급) 또는 국내 면허증(취득일 기준 최소 1년 이상)을 소지해야 하며, 한국어 및 영어로 의사소통이 가능해야 합니다. 국내 면허증을 취득하였더라도 업체에 따라 추가 서류를 요구할 수 있으니, 예약 전 업체로 대여 절차를 확인해주시기 바랍니다."
        }
    },
    {
        "@type": "Question",
        "name": "렌트카 인수와 반납은 어떻게 하나요?",
        "acceptedAnswer": {
        "@type": "Answer",
        "text": "2016년 9월 1일부터 제주공항 렌트카 하우스 내 대여 업무가 종료되어 렌트카 회사의 차고지에서 차량 인수 및 반납이 가능합니다. 제주공항 5번 게이트 부근 렌트카 종합안내센터로 이동하여 렌트카 업체에서 운행하는 셔틀버스를 탑승한 후 차고지까지 이동하시면 됩니다. 셔틀버스 탑승 관련 안내 메시지는 대게 차량 인수 하루 전 업체에서 전송합니다."
        }
    },
    {
        "@type": "Question",
        "name": "렌트카 예약한 후 렌트카 업체로 예약 확인 전화를 해야하나요?",
        "acceptedAnswer": {
        "@type": "Answer",
        "text": "탐나오 렌트카 예약은 실시간 가격 비교이며 예약과 동시에 결제를 하셔야 하며, 결제가 정상적으로 이루어지면 렌트카 업체에 별도로 전화를 안 하셔도 예약이 확정됩니다."
        }
    },
    {
        "@type": "Question",
        "name": "취소하고 싶은데 환불 규정은 어떻게 되나요?",
        "acceptedAnswer": {
        "@type": "Answer",
        "text": "탐나오는 오픈마켓으로 업체마다 취소 수수료 규정이 다릅니다. 상세페이지에 안내되어 있는 렌트카 업체별 규정을 숙지하시고 예약하시기 바랍니다."
        }
    },
    {
        "@type": "Question",
        "name": "예약변경 및 취소는 어떻게 하나요?",
        "acceptedAnswer": {
        "@type": "Answer",
        "text": "예약 변경은 변경되는 날짜에 대한 예약 가능 여부에 따라서 달라질 수 있으므로 직접 변경할 수 없으며, 취소 후 재구매를 하셔야 합니다. 예약취소는 마이페이지 > 나의 예약/구매내역 > 예약 상세 보기에서 취소 요청을 하시면 해당 렌트카 업체에서 취소 처리를 하며, 결제된 금액은 자동 취소됩니다. 이때 취소수수료 규정에 따라서 취수 수수료를 제외한 금액만큼 결제 취소가 됩니다. 결제 자동 취소가 안되는 경우는 별도로 안내해드리며 고객님의 환불계좌로 환불 처리됩니다."
        }
    },
    {
        "@type": "Question",
        "name": "면허증 분실시 어떻게 하나요?",
        "acceptedAnswer": {
        "@type": "Answer",
        "text": "렌트카 대여 시 면허증 지참은 필수 사항이나, 부득이하게 면허증을 분실하셨을 경우에는 가까운 경찰서 또는 정부24(www.gov.kr) 사이트에서 [운전경력증명서]를 발급받아 인수 시 지참해주시면 됩니다. (면허증 및 대체 서류를 지참하지 아니한 경우, 렌트카 인수가 거절되며 당일 고객 귀책의 사유로 취소 처리 및 수수료가 발생됩니다.)"
        }
    },
    {
        "@type": "Question",
        "name": "자차보험은 무엇이고, 요금은 얼마인가요?",
        "acceptedAnswer": {
        "@type": "Answer",
        "text": "렌트카 예약 시 기본적으로 대인/대물/자손보험은 가입되어 있으나 자차보험은 고객님의 선택사항입니다. 자차보험이란 자기차에 대한 보험이라는 뜻입니다. 자신의 실수로 자신의 차가 파손된 경우에 보험처리를 하여 수리비를 보험사로부터 받는 것인데, 보통 상대방 부주의로 사고가 났다 해도 쌍방 과실이 적용되니 가입해두는 것이 좋습니다. 렌트카 회사마다 보험료는 다를 수 있으므로 차량 상세페이지 내 보험안내를 참고하시면 됩니다. 자차보험은 선택사항으로 차량 인수 시 가입 여부 결정 후 계약서를 작성하시면 됩니다."
        }
    }
    ]
}
</script>
<script type="application/ld+json">
{
 "@context": "https://schema.org",
 "@type": "BreadcrumbList",
 "itemListElement":
 [
  {
   "@type": "ListItem",
   "position": 1,
   "item":
   {
    "@id": "https://www.tamnao.com/",
    "name": "메인"
    }
  },
 {
   "@type": "ListItem",
  "position": 2,
  "item":
   {
     "@id": "https://www.tamnao.com/mw/rentcar/jeju.do",
     "name": "제주도렌트카"
   }
  }
 ]
}
</script>

</head>
<body class="main">
    <div id="rent-sub" class="m_wrap">
        <jsp:include page="/mw/newMenu.do"></jsp:include>
        <!-- //header -->

        <main id="main">
            <!-- GNB -->
            <div class="mw-detail-area">
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
                        <li class="navigation_tab active-tab">
                            <a href="/mw/rentcar/jeju.do" class="navigation_title">
                                <span>렌트카</span>
                            </a>
                        </li>
                        <li class="navigation_tab">
                            <a href="/mw/tour/jeju.do" class="navigation_title">
                                <span>관광지/레저</span>
                            </a>
                        </li>
                        <li class="navigation_tab">
                            <a href="/mw/goods/jeju.do" class="navigation_title">
                                <span>특산/기념품</span>
                            </a>
                        </li>
                    </ol>
                </nav><!-- //GNB -->

     <%--           <section><!-- line-banner / 단발성 프로모션 -->
                    <div class="main-top-slider">
                        <div id="line_top_slider">
                            <ul>
                                <li id="lineBanner">
                                    <div class="line-banner day-special">
                                        <em class="promo-label">이벤트</em>
                                        <em>렌트카 전 상품 ~10% 할인! 탐나오 3.1 슈퍼위크</em>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </section><!-- //line-banner -->--%>

                <!-- key-visual -->
                <section class="key-visual">
                    <div class="banner_grid-wrapper">
                        <div class="banner-main-title">
                            <div class="banner-heading-title">신뢰할 수 있는 제주 렌트카
                                <span class="color--red">제주여행 공공플랫폼 탐나오</span>
                            </div>
                        </div>
                        <div class="banner_image">
                            <img src="/images/mw/rent/rent_visual.webp" alt="제주렌트카">
                        </div>
                        <div class="banner_text">
                            <div class="banner-text">편리한 예약, 경제적 가격으로<p>렌트카를 비교해보세요.</p></div>
                        </div>
                    </div>
                </section><!-- //key-visual -->

                <!-- index-box-search -->
                <div class="index-box-search">
                    <div class="mw-search-area">
                        <div id="dateRangePickMw" class="search-area rent" onclick="javascript:fn_resizeHeight(); $('#dimmed').show();">
                            <div class="area take-over">
                                <dl>
                                    <dt>대여일시</dt>
                                    <dd>
                                        <div class="value-text">
                                            <div class="date-time-area">
                                                <div class="date-container">
                                                    <div class="dateRangePickMw">
                                                        <input id="txtStartDt" placeholder="대여일 선택" onfocus="this.blur()" value="0000. 00. 00 (-)">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </dd>
                                    <dd class="txt-rent-time">12:00</dd>
                                </dl>
                                <div class="align-self-center">
                                    <div class="box_text">
                                        <div class="txt-rent-period">
                                            <span>2 4
                                                <br>
                                                <em>시 간</em>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <dl>
                                    <dt>반납일시</dt>
                                    <dd>
                                        <div class="value-text">
                                            <div class="date-time-area">
                                                <div class="date-container">
                                                    <div class="dateRangePickMw">
                                                        <input id="txtEndtDt" placeholder="반납일 선택" onfocus="this.blur()" value="0000. 00. 00 (-)">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </dd>
                                    <dd class="txt-rent-time">12:00</dd>
                                </dl>
                            </div>

                            <!-- CTA -->
                            <div class="btn-wrap">
                                <a id="searchDt" href="#" class="comm-btn red big" onfocus="this.blur()">
                                    <div class="submit-button">
                                        <img src="/images/mw/rent/search.png" alt="검색">
                                        <span class="btn_comm">제주도 렌트카 검색</span>
                                    </div>
                                </a>
                            </div><!-- //CTA -->
                        </div> <!-- //search-area -->
                    </div> <!-- //mw-search-area -->
                </div><!-- //index-box-search -->

                <!-- story-panels-new -->
                <div class="story-panels-new">
                    <div class="bg-red">
                        <div class="statement_img-container">
                            <div class="row">
                                <div class="bg-section">
                                    <img src="/images/mw/rent/rent-sub-visual.webp" alt="렌트카예약">
                                </div>
                                <ol class="section-box">
                                    <li class="cont01">
                                        <div class="about-reason">
                                            <div class="index-img-data-icon">
                                                <img class="ico1" src="/images/mw/rent/tamnao-rent-num-1.png" alt="누적예약">
                                            </div>
                                            <div class="txt1">
                                                <div class="txt1-1">누적예약</div>
                                                <div class="txt1-2" id="allRsv">${cntList.ALL_RSV}</div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="cont02">
                                        <div class="about-reason">
                                            <div class="index-img-data-icon">
                                                <img class="ico1" src="/images/mw/rent/tamnao-rent-num-2.png" alt="예약가능차량">
                                            </div>
                                            <div class="txt1">
                                                <div class="txt1-1">예약 가능 차량</div>
                                                <div class="txt1-2" id="ableRsv">${cntList.ABLE_RSV}</div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="cont03">
                                        <div class="about-reason">
                                            <div class="index-img-data-icon">
                                                <img class="ico1" src="/images/mw/rent/tamnao-rent-num-3.png" alt="제주도렌트카업체">
                                            </div>
                                            <div class="txt1">
                                                <div class="txt1-1">제주도 렌트카 업체</div>
                                                <div id="inCorp" class="txt1-2">${cntList.IN_CORP}</div>
                                            </div>
                                        </div>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div><!-- //story-panels-new -->

                    <!-- 기획전/이벤트 -->
                    <div class="main-list">
                        <div class="con-header">
                            <h2 class="con-title">진행중인 프로모션</h2>
                        </div>
                        <div class="main-top-slider">
                            <div id="main_top_slider" class="swiper-container">
                                <ul class="swiper-wrapper">
                                    <c:forEach items="${prmtList}" var="prmt" varStatus="status">
                                        <li class="swiper-slide">
                                            <div class="Fasten">
                                                <a href="${pageContext.request.contextPath}/mw/evnt/detailPromotion.do?prmtNum=${prmt.prmtNum}&winsYn=N&type=${fn:toLowerCase(prmt.prmtDiv)}">
                                                    <img src="${pageContext.request.contextPath}${prmt.mobileMainImg}"
                                                    	 loading="lazy"
                                                         alt="${prmt.prmtNm}"
                                                         onerror="this.src='/images/web/other/no-image2.jpg'">
                                                </a>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                                <div id="main_top_navi" class="swiper-pagination"></div>
                            </div>
                        </div>
                    </div><!-- //기획전/이벤트 -->


                    <!-- 좋은 렌트카 상품을 찾는 방법 -->
                    <div class="rent-recommand-choice">
                        <div class="con-header">
                           <h2 class="con-title">좋은 렌트카 상품을 찾는 방법</h2>
                        </div>
                        <div id="fineRetal" class="inner-paragraph swiper-container">
                            <ul class="swiper-wrapper">
                                <li class="swiper-slide">
                                    <div class="paragraph--grid">
                                        <div class="article-txt">
                                            <div class="title-wrap">
                                                <img class="paragraph-ico1" src="/images/mw/icon/paragraph-ico_01.png" loading="lazy" alt="최저가">
                                                <div class="title">첫째, 무조건 최저가가 아닌, <br>꼼꼼히 따져보고 예약하기!</div>
                                            </div>
                                            <div class="sub">차량 연식, 옵션 등을 비교하고 따져봐야 합리적으로 구매할 수 있습니다.</div>
                                        </div>
                                    </div>
                                </li>
                                <li class="swiper-slide">
                                    <div class="paragraph--grid">
                                        <div class="article-txt">
                                            <div class="title-wrap">
                                                <img class="paragraph-ico2" src="/images/mw/icon/paragraph-ico_02.png" loading="lazy" alt="자차보험">
                                                <div class="title"> 둘째, 자차보험 가입 여부 <br>결정하기!</div>
                                            </div>
                                            <div class="sub">자차보험은 차량 사고 발생 시 대여한 렌트카 파손에 대하여 보장해 주는 보험입니다. 보험 가입이 의무는 아니지만 사고 발생 시 큰 부담이 발생할 수 있습니다.</div>
                                        </div>
                                    </div>
                                </li>
                                <li class="swiper-slide">
                                    <div class="paragraph--grid">
                                        <div class="article-txt">
                                            <div class="title-wrap">
                                                <img class="paragraph-ico3" src="/images/mw/icon/paragraph-ico_03.png" loading="lazy" alt="환불규정">
                                                <div class="title">셋째, 취소 및 환불 규정 <br>미리 확인하기!</div>
                                            </div>
                                            <div class="sub">렌트카 업체별로 취소 규정이 다릅니다. 여행 일정에는 변수가 생길 수 있으니 예약 전 취소 규정을 꼭 확인 바랍니다.</div>
                                        </div>
                                    </div>
                                </li>
                                <li class="swiper-slide">
                                    <div class="paragraph--grid">
                                        <div class="article-txt">
                                            <div class="title-wrap">
                                                <img class="paragraph-ico4" src="/images/mw/icon/paragraph-ico_04.png" loading="lazy" alt="전기차">
                                                <div class="title">넷째, 친환경적인 전기차 <br>이용해 보기!</div>
                                            </div>
                                            <div class="sub">제주도는 전국에서 가장 많은 전기차를 보유하고 있으며, 도내에서 쉽게 전기차 충전소를 찾을 수 있습니다. </div>
                                        </div>
                                    </div>
                                </li>
                                <li class="swiper-slide">
                                    <div class="paragraph--grid">
                                        <div class="article-txt">
                                            <div class="title-wrap">
                                                <img class="paragraph-ico5" src="/images/mw/icon/paragraph-ico_05.png" loading="lazy" alt="애견동반">
                                                <div class="title">다섯째, 애견 동반이 <br>가능한지 필터로 확인하기!</div>
                                            </div>
                                            <div class="sub">애견 동반, 낚시 용품 지참, 군인 대여 등이 가능한지 필터를 이용하여 조건에 검색할 수 있습니다.</div>
                                        </div>
                                    </div>
                                </li>
                                <li class="swiper-slide">
                                    <div class="paragraph--grid">
                                        <div class="article-txt">
                                            <div class="title-wrap">
                                                <img class="paragraph-ico6" src="/images/mw/icon/paragraph-ico_06.png" loading="lazy" alt="탐나오">
                                                <div class="title">여섯째, 믿을만한 탐나오에서 <br>예약하기!</div>
                                            </div>
                                            <div class="sub">탐나오는 제주특별자치도에서 지원하고 제주특별자치도관광협회에서 운영하는 제주여행 공공 플랫폼입니다.</div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <div id="fineRental-slide" class="swiper-pagination"></div>
                        </div>
                    </div><!-- //좋은 렌트카 상품을 찾는 방법 -->
                </div><!-- //story-panels-new -->

                <!-- 자주하는 문의(FAQ) -->
                <div class="faq-accordion">
                    <div class="con-header">
                        <h2 class="con-title">자주하는 문의(FAQ) </h2>
                    </div>

                    <div id="tabs-3" class="tabPanel">
                        <dl class="default-accordion">
                            <dt>
                                <ul class="tbOption">
                                    <li class="memoWrap">
                                        <p class="memo">자차보험은 무엇이고, 요금은 얼마인가요?</p>
                                    </li>
                                </ul>
                            </dt>
                            <dd>
                                <ul class="question">
                                    <li>
                                        <p class="memo answer">렌터카 예약 시 기본적으로 대인/대물/자손보험은 가입되어 있으나 자차보험은 고객님의 선택사항입니다.<br>
                                            자차보험이란 자기차에 대한 보험이라는 뜻입니다.<br>
                                            자신의 실수로 자신의 차가 파손된 경우에 보험처리를 하여 수리비를 보험사로부터 받는 것인데,
                                            보통 상대방 부주의로 사고가 났다 해도 쌍방 과실이 적용되니 가입해두는 것이 좋습니다.
                                            렌터카 회사마다 보험료는 다를 수 있으므로 차량 상세페이지 내 보험안내를 참고하시면 됩니다.<br>
                                            자차보험은 선택사항으로 차량 인수 시 가입 여부 결정 후 계약서를 작성하시면 됩니다. </p>
                                    </li>
                                </ul>
                            </dd>
                            <dt>
                                <ul class="tbOption">
                                    <li class="memoWrap">
                                        <p class="memo">면허증 분실시 어떻게 하나요?</p>
                                    </li>
                                </ul>
                            </dt>
                            <dd>
                                <ul class="question">
                                    <li>
                                        <p class="memo answer">렌터카 대여 시 면허증 지참은 필수 사항이나, 부득이하게 면허증을 분실하셨을 경우에는 가까운 경찰서 또는 정부24(www.gov.kr) 사이트에서 [운전경력증명서]를 발급받아 인수 시 지참해주시면 됩니다.<br>
                                            (면허증 및 대체 서류를 지참하지 아니한 경우, 렌터카 인수가 거절되며 당일 고객 귀책의 사유로 취소 처리 및 수수료가 발생됩니다.)</p>
                                    </li>
                                </ul>
                            </dd>
                            <dt>
                                <ul class="tbOption">
                                    <li class="memoWrap">
                                        <p class="memo">예약변경 및 취소는 어떻게 하나요?</p>
                                    </li>
                                </ul>
                            </dt>
                            <dd>
                                <ul class="question">
                                    <li>
                                        <p class="memo answer">예약 변경은 변경되는 날짜에 대한 예약 가능 여부에 따라서 달라질 수 있으므로 직접 변경할 수 없으며, 취소 후 재구매를 하셔야 합니다.<br>
                                            예약취소는 마이페이지 > 나의 예약/구매내역 > 예약 상세 보기에서 취소 요청을 하시면 해당 렌터카 업체에서 취소 처리를 하며, 결제된 금액은 자동 취소됩니다. 이때 취소수수료 규정에 따라서 취수 수수료를 제외한 금액만큼 결제 취소가 됩니다.
                                            결제 자동 취소가 안되는 경우는 별도로 안내해드리며 고객님의 환불계좌로 환불 처리됩니다.</p>
                                    </li>
                                </ul>
                            </dd>
                            <dt>
                                <ul class="tbOption">
                                    <li class="memoWrap">
                                        <p class="memo">취소하고 싶은데 환불 규정은 어떻게 되나요?</p>
                                    </li>
                                </ul>
                            </dt>
                            <dd>
                                <ul class="question">
                                    <li>
                                        <p class="memo answer">탐나오는 오픈마켓으로 업체마다 취소 수수료 규정이 다릅니다. 상세페이지에 안내되어 있는 렌터카 업체별 규정을 숙지하시고 예약하시기 바랍니다.</p>
                                    </li>
                                </ul>
                            </dd>
                            <dt>
                                <ul class="tbOption">
                                    <li class="memoWrap">
                                        <p class="memo">렌터카 예약한 후 렌터카 업체로 예약 확인  <br>전화를 해야하나요?</p>
                                    </li>
                                </ul>
                            </dt>
                            <dd>
                                <ul class="question">
                                    <li>
                                        <p class="memo answer">탐나오 렌트카 예약은 실시간 가격 비교이며 예약과 동시에 결제를 하셔야 하며, 결제가 정상적으로 이루어지면 렌트카 업체에 별도로 전화를 안 하셔도 예약이 확정됩니다.</p>
                                    </li>
                                </ul>
                            </dd>
                            <dt>
                                <ul class="tbOption">
                                    <li class="memoWrap">
                                        <p class="memo">렌터카 인수와 반납은 어떻게 하나요?</p>
                                    </li>
                                </ul>
                            </dt>
                            <dd>
                                <ul class="question">
                                    <li>
                                        <p class="memo answer">2016년 9월 1일부터 제주공항 렌터카 하우스 내 대여 업무가 종료되어 렌터카 회사의 차고지에서 차량 인수 및 반납이 가능합니다.<br>
                                            제주공항 5번 게이트 부근 렌터카 종합안내센터로 이동하여 렌터카 업체에서 운행하는 셔틀버스를 탑승한 후 차고지까지 이동하시면 됩니다.<br>
                                            셔틀버스 탑승 관련 안내 메시지는 대게 차량 인수 하루 전 업체에서 전송합니다.</p>
                                    </li>
                                </ul>
                            </dd>
                            <dt>
                                <ul class="tbOption">
                                    <li class="memoWrap">
                                        <p class="memo">외국인도 렌터카 대여가 가능한가요?</p>
                                    </li>
                                </ul>
                            </dt>
                            <dd>
                                <ul class="question">
                                    <li>
                                        <p class="memo answer">렌터카 업체에 따라 외국인은 대여가 제한될 수 있으며, 예약 전 대여 가능 여부 확인이 필요합니다.<br>
                                            대여가 가능한 업체는 외국인의 경우 여권사본 및 유효기간 내의 국제면허증(제네바 및 비엔나 협약국 발급) 또는 국내 면허증(취득일 기준 최소 1년 이상)을 소지해야 하며, 한국어 및 영어로 의사소통이 가능해야 합니다.<br>
                                            국내 면허증을 취득하였더라도 업체에 따라 추가 서류를 요구할 수 있으니, 예약 전 업체로 대여 절차를 확인해주시기 바랍니다.</p>
                                    </li>
                                </ul>
                            </dd>
                            <dt>
                                <ul class="tbOption">
                                    <li class="memoWrap">
                                        <p class="memo">예약자와 운전자가 같아야 하나요?</p>
                                    </li>
                                </ul>
                            </dt>
                            <dd>
                                <ul class="question">
                                    <li>
                                        <p class="memo answer">예약자와 실제 운전자가 달라도 렌터카 대여는 가능합니다.<br>
                                            차량 인수 시 현장에서 예약자 정보로 예약 확인이 진행되며, 운전하실 분은 별도로 운전자 등록을 하시면 됩니다. 운전자는 최대 2인까지 등록 가능하며, 도로교통법상 유효한 운전면허증을 반드시 소지하여야 합니다.(렌터카 상품별 대여 조건에 부합한 운전자만 운전자 등록이 가능합니다.)</p>
                                    </li>
                                </ul>
                            </dd>
                            <dt>
                                <ul class="tbOption">
                                    <li class="memoWrap">
                                        <p class="memo">결제수단은 어떻게 되나요?</p>
                                    </li>
                                </ul>
                            </dt>
                            <dd>
                                <ul class="question">
                                    <li>
                                        <p class="memo answer">
                                            신용카드, 휴대폰결제, 실시간계좌이체, 네이버페이, 카카오페이, LPOINT를 사용해 결제를 할 수 있습니다. 부분적으로는 제주도 지역화폐 탐나는전을 사용하실 수 있습니다. 탐나는전 사용가능여부는 렌터카업체에 노란라벨을 확인하시거나 필터를 사용하시면 됩니다.
                                        </p>
                                    </li>
                                </ul>
                            </dd>
                            <dt>
                                <ul class="tbOption">
                                    <li class="memoWrap">
                                        <p class="memo">고객센터 운영시간은 어떻게 되나요?</p>
                                    </li>
                                </ul>
                            </dt>
                            <dd>
                                <ul class="question">
                                    <li>
                                        <p class="memo answer">
                                            평일 09:00~18:00<br>
                                            점심 12:00~13:00<br>
                                            ＊주말/공휴일 휴무
                                        </p>
                                    </li>
                                </ul>
                            </dd>
                        </dl>
                    </div>
                </div><!-- //자주하는 문의(FAQ) -->

                <!-- 렌트카 seo 디스크립션 영역추가 -->
                <div class="rental-car-overview-section">
                        <div class="car-info">
                            <h2 class="info-logo">탐나오 렌트카 서비스 개요
                                <img src="/images/mw/rent/car-showcase.webp"  alt="탐나오 렌트카 서비스 개요">
                            </h2>
                            <!-- 렌터카(tabs-3) -->

                            <div class="info-article">

                                <p><span>제주도 공식 여행 공공플랫폼 탐나오 렌트카 서비스</span>는<br>비즈니스 및 휴가 목적을 모두 충족할 수 있는 다양한 차량을<br> 보유하고 있습니다.</p>
                                <p>경제형, 고급형, 스포츠형, 하이브리드 차량 등<br>선택의 폭이 넓고 가격은 저렴합니다.</p>
                                <p>현대, 기아, 쉐보레, 벤츠, BMW, 테슬라 등 다양한 모델을<br>검색하고 예약하세요.</p>
                                <p>제주 지역화폐인 탐나는전으로 온라인 결제가 가능한 유일한 가맹점입니다.</p>
                                <p>숨은 비용 없이 실제 지불해야 할 금액을 정확히 안내해 드리며,<br>
                                    탐나오만의 특별한 혜택과 다양한 프로모션으로 비용을 절약할 수 있습니다.</p>
                                <p class="shape-circle">
                                    <span class="circle"></span>
                                    <span class="circle"></span>
                                    <span class="circle"></span>
                                </p>
                                <p><span>제주국제공항에 도착하신 후,<br>안전하고 즐거운 여행을 시작하세요!</span></p>

                            </div>
                        </div>
                </div>

                <!-- datepicker_page2 대여시간 -->
                <section class="search-typeA">
                    <h2 class="sec-caption">대여시간 검색</h2>
                    <div class="form">
                        <!-- option -->
                        <div class="option">
                            <div class="option-btn col2">
                                <!-- rental_time -->
                                <div id="rental_time" class="popup-typeA rent-option">
                                    <!-- rent-wrapper -->
                                    <div class="rent-wrapper">
                                        <!-- <a class="before-btn time_before"></a> -->
                                        <span class="before-btn time_before"></span>
                                        <span class="close-btn" style="cursor:pointer;" onclick="rc_close_popup('#rental_time')"></span>
                                        <div class="condition_title">대여 시간을 선택해주세요.</div>
                                        <div class="mw-search-area">
                                            <div class="search-area rent">
                                                <div class="area date time_before">
                                                    <ul>
                                                        <li>
                                                            <div class="value-text">
                                                                <div class="date-time-area">
                                                                    <div class="date-container set">
                                                                        <div class="set">
                                                                            <input name="selFromDt" id="selFromDt" placeholder="대여일 선택" onfocus="this.blur()" class="date-history" />
                                                                            <span class="arrow"></span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                    <ul>
                                                        <li>
                                                            <div class="value-text">
                                                                <div class="date-time-area">
                                                                    <div class="date-container set">
                                                                        <div class="set">
                                                                            <input name="selToDt" id="selToDt" placeholder="반납일 선택" onfocus="this.blur()" class="date-history"/>
                                                                            <span class="arrow"></span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="timepicker show-open">
                                                    <dl class="factor-txt">
                                                        <dt>인수시간</dt>
                                                        <dd class="date-time date-start">
                                                            <div class="time-select" data-time="12"></div>
                                                        </dd>
                                                    </dl>
                                                    <dl class="return-txt">
                                                        <dt>반납시간</dt>
                                                        <dd class="date-time date-end">
                                                            <div class="time-select" data-time="12"></div>
                                                        </dd>
                                                    </dl>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="fix-cta">
                                            <a href="#" class="result-btn" id="apply_time">다음</a>
                                        </div>
                                    </div><!-- //rent-wrapper -->
                                </div><!-- //rental_time -->
                            </div><!-- //option-btn col2 -->
                        </div><!-- //option  -->
                    </div><!-- //form  -->
                </section><!-- //datepicker_page2 대여시간 -->

                <!-- datepicker_page3 차량조건 -->
                <section class="search-typeA">
                    <h2 class="sec-caption">차량조건 검색</h2>
                    <form name="frm" id="frm" method="get" onSubmit="return false;">
                        <div class="form">
                            <div class="option">
                                <div class="option-btn col2">
                                    <div id="rent_option" class="popup-typeA rent-option">
                                        <!-- rent-wrapper -->
                                        <div class="rent-wrapper">
                                            <!-- <a class="before-btn option_before"></a> -->
                                            <span class="before-btn option_before"></span>
                                            <span class="close-btn" style="cursor:pointer;" onclick="rc_close_popup('#rent_option')"></span>
                                            <div class="condition_title">차량 조건을 선택해주세요.</div>
                                            <div class="index-history option_before">
                                                <div class="mt">
                                                    <div class="box-search">
                                                        <div class="d-flex justify-start">
                                                            <div class="yak-bg-icon">
                                                                <img src="/images/mw/rent/yak.png" loading="lazy" alt="대여시간">
                                                            </div>
                                                            <div class="ml">
                                                                <div class="txt-history-area" id="txtStartTime">
                                                                    00.00(일) <span class="time">12:00</span>
                                                                </div>
                                                                <span class="arrow"></span>
                                                                <div class="txt-history-area" id="txtEndTime">
                                                                    00.00(일) <span class="time">12:00</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="justify-end">
                                                            <span class="" id="diffTime">24시간</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- content-area -->
                                            <div class="content-area">
                                                <div class="list-group">
                                                    <strong class="sub-title">운전자 연령</strong>
                                                    <ul class="select-menu col1">
                                                        <li class="operator-age">
                                                            <div class="lb-box">
                                                                <input id="rAgeDiv1" name="sRntQlfctAge" type="radio" value="25">
                                                                <label for="rAgeDiv1">만 21세~25세</label>
                                                            </div>
                                                        </li>
                                                        <li class="operator-age">
                                                            <div class="lb-box">
                                                                <input id="rAgeDiv2" name="sRntQlfctAge" type="radio" checked="checked" value="99">
                                                                <label for="rAgeDiv2">만 26세 이상</label>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="list-group">
                                                    <strong class="sub-title">경력</strong>
                                                    <ul class="select-menu col2">
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="rCareerDiv1" name="sRntQlfctCareer" type="radio" value="0">
                                                                <label for="rCareerDiv1">1년 미만</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="rCareerDiv2" name="sRntQlfctCareer" type="radio" value="1">
                                                                <label for="rCareerDiv2">2년 미만</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="rCareerDiv3" name="sRntQlfctCareer" type="radio" value="2">
                                                                <label for="rCareerDiv3">3년 미만</label>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="rCareerDiv4" name="sRntQlfctCareer" type="radio" value="99" checked="checked">
                                                                <label for="rCareerDiv4">3년 이상</label>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="list-group">
                                                    <strong class="sub-title">차종</strong>
                                                    <ul class="select-menu col3">
                                                        <li>
                                                            <div class="lb-box">
                                                                <input id="sCarDivCd0" name="sCarDivCdStr" type="radio" value="" checked="checked">
                                                                <label for="sCarDivCd0">전체</label>
                                                            </div>
                                                        </li>
                                                        <c:forEach var="code" items="${carDivCd}" varStatus="status">
                                                            <li>
                                                                <div class="lb-box">
                                                                    <input id="sCarDivCd${status.count}" name="sCarDivCdStr" type="radio" value="${code.cdNum}">
                                                                    <label for="sCarDivCd${status.count}">${code.cdNm}</label>
                                                                </div>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                                <div class="list-group">
                                                    <strong class="sub-title">보험</strong>
                                                    <ul class="select-menu col4">
                                                        <li class="insurance">
                                                            <div class="lb-box">
                                                                <input id="sIsrTypeDiv0" name="sIsrTypeDiv" type="radio" value="">
                                                                <label for="sIsrTypeDiv0">전체</label>
                                                            </div>
                                                        </li>
                                                        <li class="insurance">
                                                            <div class="lb-box">
                                                                <input id="sIsrTypeDiv1" name="sIsrTypeDiv" type="radio" value="FEE">
                                                                <label for="sIsrTypeDiv1">자차 미포함</label>
                                                            </div>
                                                        </li>
                                                        <li class="insurance">
                                                            <div class="lb-box">
                                                                <input id="sIsrTypeDiv2" name="sIsrTypeDiv" type="radio" value="GENL">
                                                                <label for="sIsrTypeDiv2">일반자차포함</label>
                                                            </div>
                                                        </li>
                                                        <li class="insurance">
                                                            <div class="lb-box">
                                                                <input id="sIsrTypeDiv3" name="sIsrTypeDiv" type="radio" value="LUXY" checked="checked">
                                                                <label for="sIsrTypeDiv3">고급자차포함</label>
                                                            </div>
                                                        </li>
                                                        <li class="insurance">
                                                            <div class="lb-box">
                                                                <input id="sIsrTypeDiv4" name="sIsrTypeDiv" type="radio" value="ULIM" >
                                                                <label for="sIsrTypeDiv4">고급자차(전액무제한)포함</label>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <ul class="list-disc type-A">
                                                    <li>오전 8시 ~ 오후 8시 외 차량 대여/반납은 일부 업체만 가능하며, 추가요금이 발생하거나 완전자차 보험가입이 필요할 수
                                                        있습니다.
                                                    </li>
                                                </ul>
                                            </div><!-- //content-area -->
                                        </div><!-- //rent-wrapper -->

                                        <!-- 최저가 검색 btn -->
                                        <div class="fix-cta">
                                            <p>
                                            <span id="adBtnPrdt1">
                                                <a href="#" class="result-btn" onclick="fn_ClickSearchPage()">
                                                    <span>
                                                        <img src="/images/mw/rent/result-btn.png" loading="lazy" alt="최저가 검색">
                                                        최저가 검색
                                                    </span>
                                                </a>
                                            </span>
                                            </p>
                                        </div><!-- //최저가 검색 btn -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" id="sFromDt" name="sFromDt"> <!-- 인수일 -->
                        <input type="hidden" id="sToDt" name="sToDt"> <!-- 반납일 -->
                        <input type="hidden" id="sFromDtView" name="sFromDtView">
                        <input type="hidden" id="sToDtView" name="sToDtView">
                        <input type="hidden" id="sFromDay" name="sFromDay">
                        <input type="hidden" id="sToDay" name="sToDay">
                        <input type="hidden" id="sFromTm" name="sFromTm"> <!-- 인수시간 -->
                        <input type="hidden" id="sToTm" name="sToTm"> <!-- 반납시간 -->
                        <input type="hidden" name="sCarDivCd" id="sCarDivCd"> <!-- 차량 유형 검색 -->
                        <input type="hidden" name="sCouponCnt" id="sCouponCnt" value="${searchVO.sCouponCnt}"><!--할인쿠폰필터-->
                    </form>
                </section><!-- //datepicker_page3 차량조건 -->
            </div>
        </main>
        <!-- footer -->
        <jsp:include page="/mw/foot.do"></jsp:include>
    </div><!-- //rent-sub -->
<div id="dimmed"></div>

<script src="/js/dimmed.js?version=${nowDate}"></script>
<script src="/js/moment.min.js?version=${nowDate}"></script>
<script src="/js/daterangepicker-rc.js?version=${nowDate}"></script>
<script src="/js/mw_timepicker.js?version=${nowDate}"></script>
<script>
/** 특별처리빅이벤트*/
let date = new Date();
let yy = date.getFullYear();
let mm = date.getMonth()+1; mm = (mm < 10) ? '0' + mm : mm;
let dd = date.getDate(); dd = (dd < 10) ? '0' + dd : dd;
let curTime = String(yy) + String(mm) + String(dd);
/** 이벤트 배너영역 */
if(curTime >= '20241129' && curTime <= '20250203' ){
    $("#line_top_slider").show();
}
    $(document).ready(function () {
        window.onpageshow = function(event) {
            if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
                $("#rent_option").hide();
                $('#dimmed').hide();
            }
        }

        /** intro 대여일시/반납일시 설정 **/
        const today = new Date();
        const startDay = new Date(today.setDate(today.getDate() + 1));
        const endDay = new Date(today.setDate(startDay.getDate() + 1));
        $("#txtStartDt").val(startDay.getFullYear() + '. ' + ('0' + (startDay.getMonth() + 1)).slice(-2) + '. ' + ('0' + startDay.getDate()).slice(-2) + "(" + getDate(startDay) + ")");
        $("#txtEndtDt").val(endDay.getFullYear() + '. ' + ('0' + (endDay.getMonth() + 1)).slice(-2) + '. ' + ('0' + endDay.getDate()).slice(-2) + "(" + getDate(endDay) + ")");

        /**dateRangePickMw 생성**/
        $('#dateRangePickMw').daterangepicker({}, function (start, end, search) {
            //인수/반납일 설정
            const sFromDt = start.format('YYYY-MM-DD');
            const sToDt = end.format('YYYY-MM-DD');
            $("#sFromDt").val(sFromDt.replace(/-/gi, ""));
            $("#sToDt").val(sToDt.replace(/-/gi, ""));
            $("#sFromDtView").val(sFromDt.replace(/-/gi, ". ")+ "(" + getDate(sFromDt) + ")");
            $("#sToDtView").val(sToDt.replace(/-/gi, ". ")+ "(" + getDate(sToDt) + ")");

            //시간 계산에서 필요.
            $("#sFromDay").val(sFromDt);
            $("#sToDay").val(sToDt);

            $("#selFromDt").val(start.format('MM. DD') + "(" + getDate(sFromDt) + ")");
            $("#selToDt").val(end.format('MM. DD') + "(" + getDate(sToDt) + ")");
        });

        /** 대여시간 화면에서 다음 버튼 클릭 시 **/
        $("#apply_time").click(function () {

            const sFromTm = getSelectTime('.date-start');
            const sToTm = getSelectTime('.date-end');

            //인수/반납 시간 설정
            $("#sFromTm").val(sFromTm.replace(":", ""));
            $("#sToTm").val(sToTm.replace(":", ""));

            //예약시간 계산
            const diffStart = new Date($("#sFromDay").val() + "T" + sFromTm);
            const diffEnd = new Date($("#sToDay").val() + "T" + sToTm);
            const diffTime = (diffEnd.getTime() - diffStart.getTime()) / (1000 * 60 * 60);

            //validate
            if ($("#sFromDay").val() == currentDay() && parseInt(currentTime().substring(0, 5).replace(":", "")) >= parseInt($("#sFromTm").val())) {
                alert("현재시간 이후부터 선택이 가능합니다.");
                return;
            }

            if (diffTime < 0) {
                alert("대여시간 선택을 확인 해주세요.");
                return;
            }

            $("#diffTime").text(diffTime + "시간");
            $("#txtStartTime").html($("#selFromDt").val() + " " + "<span class='time'>" + sFromTm + "</span>");
            $("#txtEndTime").html($("#selToDt").val() + " " + "<span class='time'>" + sToTm + "</span>");
            $("#rental_time").hide();
            $("#rent_option").show();
        });

        // dimmed lock scroll 처리
        var posY;

        $(".search-area.rent").on("click", function(e){

            posY = $(window).scrollTop();

            $("html, body").addClass("not_scroll");
            $(".daterangepicker").css("display","block");
            $("#rent-sub").css("top",-posY);
        });

        $(".close-btn").on("click", function(){
            $("html, body").removeClass("not_scroll");
            $(".daterangepicker").css("display","none");

            posY = $(window).scrollTop(posY);
        });

        // dimmed click lock 처리
        $("#dimmed").click(function () {
            $(".daterangepicker").css("display","block");
        });

        //대여시간 화면에서 이전페이지 클릭 시
        $(".time_before").click(function () {
            $("#rental_time").hide();
            $('#dateRangePickMw').data('daterangepicker').show();
        });

        //차량조건 화면에서 이전페이지 클릭 시
        $(".option_before").click(function () {
            $("#rent_option").hide();
            $("#rental_time").show();
        });

        //차종 선택시 값 설정
        $('input[name=sCarDivCdStr]').click(function () {
            $('#sCarDivCd').val($(this).val());
        });

        /** 스크롤 발생 시 카운트 애니메이션 처리 **/
        $(window).scroll(function () {
            var scrollT = $(window).scrollTop(); //스크롤바의 상단위치
            var scrollH = $('.navigation').height() + $('.key-visual').height() + $('.mw-search-area').height() - 60; //스크롤바를 갖는 div의 높이

            if (scrollT >= scrollH) {

                const allRsv = "<c:out value='${cntList.ALL_RSV}'/>";
                const ableRsv = "<c:out value='${cntList.ABLE_RSV}'/>";
                const inCorp = "<c:out value='${cntList.IN_CORP}'/>";

                //누적예약
                $({val: 0}).animate({val: allRsv}, {
                    duration: 2000,
                    step: function () {
                        var num = numberWithCommas(Math.floor(this.val));
                        $("#allRsv").text(num);
                    },
                    complete: function () {
                        var num = numberWithCommas(Math.floor(this.val));
                        $("#allRsv").text(num);
                    }
                });

                //예약 가능 차량
                $({val: 0}).animate({val: ableRsv}, {
                    duration: 2000,
                    step: function () {
                        var num = numberWithCommas(Math.floor(this.val));
                        $("#ableRsv").text(num);
                    },
                    complete: function () {
                        var num = numberWithCommas(Math.floor(this.val));
                        $("#ableRsv").text(num);
                    }
                });

                //제주도 입점 업체
                $({val: 0}).animate({val: inCorp}, {
                    duration: 2000,
                    step: function () {
                        var num = numberWithCommas(Math.floor(this.val));
                        $("#inCorp").text(num);
                    },
                    complete: function () {
                        var num = numberWithCommas(Math.floor(this.val));
                        $("#inCorp").text(num);
                    }
                });

                //스크롤 한번만 실행
                $(window).off('scroll');
            }
        });;

        /**기획전 슬라이드 **/
        if ($('#main_top_slider .swiper-slide').length > 1) {
            new Swiper('#main_top_slider', {
                pagination: '#main_top_navi',
                paginationClickable: true,
                autoplay: 5000,
                loop: true,
                paginationType: 'fraction' // 'bullets' or 'progress' or 'fraction' or 'custom'
            });
        }

        /** 좋은렌터카 상품을 찾는 방법 슬라이드 **/
        if ($('#fineRetal .swiper-slide').length > 1) {
            new Swiper('#fineRetal', {
                pagination: '#fineRental-slide',
                paginationClickable: true,
                autoplay: 5000,
                loop: true,
                paginationType: 'fraction' // 'bullets' or 'progress' or 'fraction' or 'custom'
            });
        }

        $('#dateRangePickMw').click(function () {
            $('#rent-sub').addClass('modal-open');
        });
    });

    /* default Accordion */
    function accordion() {
        var speed = 300;
        $('.default-accordion dt').click(function(event) {
            if ($(this).next('dd').css('display')=='none') {
                $('.default-accordion dd').slideUp(speed);
                $(this).next('dd').slideDown(speed);
            } else {
                $('.default-accordion dd').slideUp(speed);
                $(".memoWrap").removeClass("open");
            }
        });
    };


    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    function fn_ClickSearchPage() {
        $("html, body").removeClass("not_scroll");
        document.frm.action = "<c:url value='/mw/rentcar/car-list.do'/>";
        document.frm.submit();
    }

    //창 닫기
    function rc_close_popup(obj) {
        if (typeof obj == "undefined" || obj == "" || obj == null) {
            $('#dateRangePickMw').data('daterangepicker').hide();
        } else {
            $(obj).hide();
        }
        $('#dimmed').fadeOut(100);
    }

    /**
     * App 체크
     * AA : 안드로이드 앱, AW : 안드로이드 웹, IA : IOS 앱, IW : IOS 웹
     */
    function fn_AppCheck() {
        var headInfo = ("${header['User-Agent']}").toLowerCase();
        var mobile = (/iphone|ipad|ipod|android|windows phone|iemobile|blackberry|mobile safari|opera mobi/i.test(headInfo));

        if (mobile) {
            if ((/android/.test(headInfo))) {
                if (/webview_android/.test(headInfo)) {
                    return "AA";
                } else {
                    return "AW";
                }
            } else if ((/iphone|ipad|/.test(headInfo))) {
                if (!(/safari/.test(headInfo))) {
                    return "IA";
                } else {
                    return "IW";
                }
            }
        } else {
            return "PC";
        }
    }

    // 외부영역 클릭 시 닫기(자주하는문의)
    $(document).mouseup(function (e){

        var speed = 300;
        var ArrowUp = $(".memoWrap");

        if(ArrowUp.hasClass("open")) {

            ArrowUp.removeClass("open");

            $('.default-accordion dd').slideUp(speed);

        }
    });

    $(document).ready(function(){

        //자주하는 문의(FAQ) 화살표 처리
        $(".memoWrap").click(function(){

            $(this).closest(".memoWrap");
            let index = $(".memoWrap").index($(this).closest(".memoWrap"));

            if ($(".memoWrap:eq(" + index + ")").hasClass("open")) {
                $(".memoWrap:eq(" + index + ")").removeClass("open");

            } else{
                $(".memoWrap:eq(" + index + ")").addClass("open");

            };
        });

        // FAQ 실행
        if($(".default-accordion").length > 0) {accordion();}

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
    });
</script>
</body>
</html>
