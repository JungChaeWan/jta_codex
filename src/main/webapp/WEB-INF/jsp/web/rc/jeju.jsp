<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="제주도렌트카 가격비교 및 할인 예약 - 탐나오 | 추천 렌터카 서비스"/>
    <jsp:param name="description" value="제주 렌트카, 제주여행공공플랫폼 렌트카 예약은 탐나오. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 안전한 예약이 가능합니다."/>
    <jsp:param name="keywords" value="제주렌트카,제주도렌트카,제주렌터카,제주도렌터카,제주도렌트카비용,제주렌트카가격비교,제주렌트카추천,탐나는전"/>
</jsp:include>
<meta property="og:title" content="제주도렌트카 탐나오: 제주렌트카 가격비교">
<meta property="og:url" content="https://www.tamnao.com/web/rentcar/jeju.do">
<meta property="og:image" content="https://www.tamnao.com/images/web/rent/rent_visual_2.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="800">
<meta property="og:description" content="제주여행공공플랫픔 렌트카 예약은 탐나오. 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 안전한 예약이 가능합니다.">
<meta property="og:site_name" content="탐나오 TAMNAO - 제주도 공식 여행 공공 플랫폼">
<meta property="og:type" content="website" />

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/select2.min.css?version=${nowDate}'/>">
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Light.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/rc.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/daterangepicker-rc-pc.css?version=${nowDate}'/>">
<link rel="canonical" href="https://www.tamnao.com/web/rentcar/jeju.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/rentcar/jeju.do">

<script defer src="<c:url value='/js/select2.min.js'/>"></script>
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
    },
    {
      "@type": "Question",
      "name": "결제수단은 어떻게 되나요?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "신용카드, 휴대폰결제, 실시간계좌이체, 네이버페이, 카카오페이, LPOINT를 사용해 결제를 할 수 있습니다. 부분적으로는 제주도 지역화폐 탐나는전을 사용하실 수 있습니다. 탐나는전 사용가능여부는 렌터카업체에 노란라벨을 확인하시거나 필터를 사용하시면 됩니다."
      }
    },
    {
      "@type": "Question",
      "name": "고객센터 운영시간은 어떻게 되나요?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "평일 09:00~18:00 점심 12:00~13:00 ＊주말/공휴일 휴무"
      }
    }
  ]
}</script>
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
     "@id": "https://www.tamnao.com/web/rentcar/jeju.do",
     "name": "제주도렌트카"
   }
  }
 ]
}
</script>

</head>
<body>
<header id="header">
    <jsp:include page="/web/head.do"></jsp:include>
</header>
<main id="main">

<%--    <section>
        <!-- line-banner / 단발성 프로모션 -->
        <div id="lineBanner">
            <div class="line-banner day-special">
                <em class="promo-label">이벤트</em>
                <em>렌트카 전 상품 ~10% 할인! 탐나오 3.1 슈퍼위크</em>
            </div>
        </div>
    </section><!-- //line-banner -->--%>

    <!-- key-visual -->
    <section class="key-visual">
        <div class="banner_grid-wrapper">
            <div class="banner-main-title">

                <div class="banner-heading-title">신뢰할 수 있는 제주 렌트카<span>제주여행 공공플랫폼 탐나오</span></div>
                <div class="banner_text">
                    <div class="banner-text">편리한 예약, 경제적 가격으로 렌트카를 비교해보세요.</div>
                </div>
            </div>
            <div class="banner_image">
                <img src="/images/web/rent/rent_visual_2.webp" width="430" height="auto" alt="제주렌트카">
            </div>
        </div>

        <!-- 자차보험 안내 레이어팝업 -->
        <div id="insurance_info" class="comm-layer-popup_fixed">
            <div class="content-wrap">
                <div class="content">
                    <div class="installment-head">
                        <button type="button" class="close" onclick="close_popup('#insurance_info')"><img src="/images/mw/icon/close/dark-gray.png" loading="lazy" alt="닫기"></button>

                        <!-- 1109 자차보험 안내 레이어팝업 업데이트 -->
                        <div class="rent-qna">
                            <div class="car_insurance">
                                <div class="info-head">자차보험 <span>안내</span></div>
                                <div class="free-wrap">
                                    <div class="allguide">
                                        <table>
                                            <colgroup>
                                                <col style="width:16%">
                                                <col style="width:21%">
                                                <col style="width:21%">
                                                <col style="width:21%">
                                                <col style="width:21%">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th>구분</th>
                                                    <th>일반자차</th>
                                                    <th>일반자차(부분무제한)</th>
                                                    <th>고급자차</th>
                                                    <th>고급자차(전액무제한)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- 보상한도 -->
                                                <tr>
                                                    <td class="aside_tit">보상한도</td>
                                                    <td>한도 내 보상</td>
                                                    <td>무제한</td>
                                                    <td>한도 내 보상</td>
                                                    <td>무제한</td>
                                                </tr><!-- //보상한도 -->

                                                <!-- 면책금 -->
                                                <tr>
                                                    <td class="aside_tit">면책금</td>
                                                    <td>면책금 발생</td>
                                                    <td>면책금 발생</td>
                                                    <td>
                                                        <dl>
                                                            <dt>한도 내 면제</dt>
                                                            <dd>(일부업체 발생)</dd>
                                                        </dl>
                                                    </td>
                                                    <td>면제</td>
                                                </tr><!--//면책금-->

                                                <!--휴차 보상료-->
                                                <tr>
                                                    <td class="aside_tit">휴차 보상료</td>
                                                    <td>부담금 발생</td>
                                                    <td>부담금 발생</td>
                                                    <td>
                                                        <dl>
                                                            <dt>한도 내 면제</dt>
                                                            <dd>(일부업체 발생)</dd>
                                                        </dl>
                                                    </td>
                                                    <td>면제</td>
                                                </tr><!-- //휴차 보상료 -->

                                                <!-- 단독 사고 -->
                                                <tr>
                                                    <td class="aside_tit">단독 사고</td>
                                                    <td>보장 안됨</td>
                                                    <td>보장</td>
                                                    <td>
                                                        <dl>
                                                            <dt>보장 안됨</dt>
                                                            <dd>(일부업체 보장)</dd>
                                                        </dl>
                                                    </td>
                                                    <td>보장</td>
                                                </tr><!-- //단독사고 -->

                                                <!--휠/타이어 -->
                                                <tr>
                                                    <td class="aside_tit">휠/타이어</td>
                                                    <td>보장 안됨</td>
                                                    <td>보장</td>
                                                    <td>보장 안됨</td>
                                                    <td>보장</td>
                                                </tr><!-- //휠/타이어 -->
                                            </tbody>
                                        </table>

                                    </div>

                                    <!-- info -->
                                    <div class="event-note">
                                        <ul>
                                            <li><span>●</span> <span class="tit">자차보험이란 :</span> 차량 사고 발생 시 대여한 렌트카 파손에 대하여 보장해주는 보험</li>
                                            <li><span>●</span> <span class="tit">보상한도 :</span> 보험으로 처리 가능한 사고비용의 최대한도 비용</li>
                                            <li><span>●</span> <span class="tit">면책금 :</span> 사고에 대한 책임을 면하기 위해 지불 하는 돈</li>
                                            <li><span>●</span> <span class="tit">휴차 보상료 :</span> 사고 발생 후 차량 수리기간 동안 발생한 영업손실 비용</li>
                                            <li><span>●</span> <span class="tit">단독사고 :</span> 과실 유무와 상관없이 주·정차된 차량 및 시설물을 접촉하거나 본인과실 100% 사고인 경우</li>
                                            <li><span>●</span> <span class="tit">휠/타이어 보장 :</span> 타이어, 휠 파손에 대한 수리비용</li>
                                            <li>* 세부 내용은 렌트카 업체마다 다를 수 있습니다. 차량 상세페이지 보험내용을 꼭 확인해주세요.</li>
                                        </ul>
                                    </div><!-- //info -->
                                    <div class="character">
                                        <img src="/images/web/rent/insurance.png" loading="lazy" alt="차량보험안내">
                                    </div>
                                </div><!-- //free-wrap -->
                            </div><!-- //free_installment -->
                        </div><!-- //1109 자차보험 안내 레이어팝업 업데이트 -->
                    </div>
                </div>
            </div>
        </div><!-- //자차보험 안내 레이어팝업 -->
    </section><!-- //key-visual -->

    <!-- 검색바 -->
    <section class="index-box-search">
        <form name="frm" id="frm" method="get" onSubmit="return false;">
            <input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
            <input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
            <input type="hidden" name="sFromTm" id="sFromTm" value="${searchVO.sFromTm}">
            <input type="hidden" name="sToTm" id="sToTm" value="${searchVO.sToTm}">
            <input type="hidden" name="sCouponCnt" id="sCouponCnt" value="${searchVO.sCouponCnt}"><!--할인쿠폰필터-->
            <h2 class="sec-caption">제주도 렌트카 검색</h2>
            <div class="web-search-area">
                <div class="form-area skeleton_loading" >
                    <div class="tit-area">렌트카 검색</div>
                    <div class="search-area rent">
                        <div class="back-bg">
                        <!-- 1213 time-picker 변경 -->
                            <div class="date--left">
                                <div class="area">
                                    <dl>
                                        <dt>
                                            <div class="date-icon">
                                                <span class="IconSide">대여일</span>
                                            </div>
                                        </dt>
                                        <dd>
                                            <div class="value-text">
                                                <input class="datepicker" type="text" name="sFromDtView" id="sFromDtView" placeholder="대여일 선택" value="${searchVO.sFromDtView}" readonly>
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="time-picker">
                                    <dl>
                                        <dt></dt>
                                        <dd>
                                            <div class="hour-icon"></div>
                                            <div class="value-text">
                                                <input name="sFromTmView" id="sFromTmView" title="시간선택" value="08:00" readonly="readonly" />
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                            <a class="align-self-center">
                                <div class="box_text">
                                    <img src="/images/web/rent/arrow.png" width="24" height="11" alt="대여시간">
                                    <div class="txt-rent-period">
                                      <span>24시간</span>
                                    </div>
                                </div>
                            </a>
                            <div class="date--right">
                                <div class="area">
                                    <dl>
                                        <dt>
                                            <div class="date-icon">
                                                <span class="IconSide">반납일</span>
                                            </div>
                                        </dt>
                                        <dd>
                                            <div class="value-text">
                                                <input class="datepicker" type="text" name="sToDtView" id="sToDtView" placeholder="반납일 선택" value="${searchVO.sToDtView}" readonly="readonly">
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="time-picker">
                                    <dl>
                                        <dt></dt>
                                        <dd>
                                            <div class="hour-icon"></div>
                                            <div class="value-text">
                                                <input name="sToTmView" id="sToTmView" title="시간선택" value="08:00" readonly="readonly">
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                        <!-- //1213 time-picker 변경 -->

                        <div class="select-back-bg">
                            <!-- insurance selection -->
                            <div class="area select">
                                <div class="btnPack">
                                    <div class="insurance_btn">
                                        <a href="javascript:show_popup('#insurance_info');">자차보험 안내</a>
                                    </div>
                                </div>
                                <dl>
                                    <dt>
                                        <div class="cn-icon">
                                            <span class="IconSide">보험선택</span>
                                        </div>
                                    </dt>
                                    <dd>
                                        <div class="btn-category">
                                            <input type="radio" id="chkPoint0" name="sIsrTypeDiv" value="" >
                                            <label for="chkPoint0">전체</label>
                                        </div>
                                        <div class="btn-category">
                                            <input type="radio" id="chkPoint1" name="sIsrTypeDiv" value="FEE">
                                            <label for="chkPoint1">자차 미포함</label>
                                        </div>
                                        <div class="btn-category">
                                            <input type="radio" id="chkPoint2" name="sIsrTypeDiv" value="GENL">
                                            <label for="chkPoint2">일반자차포함</label>
                                        </div>
                                        <div class="btn-category">
                                            <input type="radio" id="chkPoint3" name="sIsrTypeDiv" value="LUXY" checked>
                                            <label for="chkPoint3">고급자차포함</label>
                                        </div>
                                    </dd>
                                </dl>
                            </div><!-- //insurance selection -->
                        </div>
                        <div class="area search">
                            <a href="#" class="btn red" onclick="fnGoMainList();">
                                <span class="MagGlass">
                                    <em class="TicSec">렌트카 검색</em>
                                </span>
                            </a>
                        </div>
                    </div>
                </div><!-- //form-area -->
            </div><!-- //web-search-area -->
        </form>
    </section><!-- //index-box-search -->

    <!-- story-panels-new -->
    <section class="content__banner">
        <div class="content__banner-inner">
            <div class="row">
                <div class="hidden-box"></div>
                <div class="section-box">
                    <div class="row">
                        <div class="about-reason ico1">
                            <div class="index-img-data-icon">
                                <img src="/images/web/rent/tamnao-rent-num-1.png" width="53" height="53" alt="누적예약">
                            </div>
                            <div class="txt1">
                                <div class="txt1-1">누적예약</div>
                                <div id="allRsv" class="txt1-2">${cntList.ALL_RSV}</div>
                            </div>
                        </div>
                        <span></span>
                        <div class="about-reason ico1">
                            <div class="index-img-data-icon">
                                <img src="/images/web/rent/tamnao-rent-num-2.png" width="53" height="53" alt="예약가능차량">
                            </div>
                            <div class="txt1">
                                <div class="txt1-1">예약 가능 차량</div>
                                <div id="ableRsv" class="txt1-2">${cntList.ABLE_RSV}</div>
                            </div>
                        </div>
                        <span></span>
                        <div class="about-reason ico1">
                            <div class="index-img-data-icon">
                                <img src="/images/web/rent/tamnao-rent-num-3.png" width="53" height="53" alt="제주도렌트카업체">
                            </div>
                            <div class="txt1">
                                <div class="txt1-1">제주도 렌트카 업체</div>
                                <div id="inCorp" class="txt1-2">${cntList.IN_CORP}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section><!-- //story-panels-new -->

    <!-- rent-category-best -->
    <section class="rent-category-best">
        <div class="inner">
            <h2><span class="title">렌트카</span> 카테고리별 추천상품</h2>
            <div id="rent_slider" class="swiper-container swiper-container-horizontal">
                <ul class="swiper-wrapper">
                    <li class="swiper-slide">
                        <a href="/web/rentcar/car-list.do?sCarDivCd=CAR1" target="_self">
                            <div class="suggestion num1">
                                <div class="car-info">
                                    <span class="car-name">경차/소형차</span>
                                    <span class="info">합리적인 당신, 실속있는 예약!</span>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="swiper-slide">
                        <a href="/web/rentcar/car-list.do?sIconCd=RA26" target="_self">
                            <div class="suggestion num2">
                                <div class="car-info">
                                    <span class="car-name">애견동반가능</span>
                                    <span class="info">반려견과 함께하는 제주여행!</span>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="swiper-slide">
                        <a href="/web/rentcar/car-list.do?sUseFuelDiv=CF04" target="_self">
                            <div class="suggestion num3">
                                <div class="car-info">
                                    <span class="car-name">친환경 전기차</span>
                                    <span class="info">청정제주와 함께하는 렌트카여행!</span>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="swiper-slide ">
                        <a href="/web/rentcar/car-list.do?sIconCd=RA27" target="_self">
                            <div class="suggestion num4">
                                <div class="car-info">
                                    <span class="car-name">낚시용품지참</span>
                                    <span class="info">제주바다를 보며 낚시를!</span>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="swiper-slide">
                        <a href="/web/rentcar/car-list.do?sCarDivCd=CAR3" target="_self">
                            <div class="suggestion num5">
                                <div class="car-info">
                                    <span class="car-name">고급차</span>
                                    <span class="info">럭셔리하고 편안한 렌트카여행!</span>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="swiper-slide">
                        <a href="/web/rentcar/car-list.do?sIconCd=RA28" target="_self">
                            <div class="suggestion num6">
                                <div class="car-info">
                                    <span class="car-name">외국인 대여</span>
                                    <span class="info">외국인 고객님들도 안전·신속하게!</span>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="swiper-slide">
                        <a href="/web/rentcar/car-list.do?sCarDivCd=CAR5" target="_self">
                            <div class="suggestion num7">
                                <div class="car-info">
                                    <span class="car-name">오픈카/수입차</span>
                                    <span class="info">새로운 경험, 특별한 제주여행!!</span>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="swiper-slide">
                        <a href="/web/rentcar/car-list.do?sIconCd=RA29" target="_self">
                            <div class="suggestion num8">
                                <div class="car-info">
                                    <span class="car-name">군인 대여</span>
                                    <span class="info">직업군인에서 현역병까지도!</span>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="swiper-slide ">
                        <a href="/web/rentcar/car-list.do?sCarDivCd=CAR4" target="_self">
                            <div class="suggestion num9">
                                <div class="car-info">
                                    <span class="car-name">SUV/승합차</span>
                                    <span class="info">다같이 함께하는 즐거운 드라이빙!</span>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li class="swiper-slide ">
                        <a href="/web/rentcar/car-list.do?sCarDivCd=CAR2" target="_self">
                            <div class="suggestion num10">
                                <div class="car-info">
                                    <span class="car-name">중형차</span>
                                    <span class="info">넉넉한 공간, 합리적인 선택</span>
                                </div>
                            </div>
                        </a>
                    </li>
                </ul>

                <!-- slideItem_arrow -->
                <div id="slideItem_arrow" class="arrow-box">
                    <div id="slideItem_next" class="swiper-button-next"></div>
                    <div id="slideItem_prev" class="swiper-button-prev"></div>
                </div><!-- //slideItem_arrow -->
            </div>
        </div>
    </section><!-- //rent-category-best -->

    <!-- customer-service -->
    <section class="customer-service">
        <div class="inner">
            <div class="inner_interval">
                <div class="car-option">
                    <a href="/web/tour/jeju.do?sCtgr=C500" class="carSeatArea" target="_self">
                    	<dl>
                         <dt class="img">
                             <img src="/images/web/rent/stroller_img_2.png" width="580" height="102" alt="카시트/유모차">
                         </dt>
                         <dd class="service-desc">
                             <span class="title">카시트/유모차</span>
                             <img class="shortcuts" src="/images/web/rent/shortcuts.png" width="31" height="8" alt="카시트유모차">
                             <span class="sub-title">예약하신 렌트카 업체로 무료 배달/수거 서비스<p>(일부 렌트카 업체 이용 불가)</p></span>
                         </dd>
                        </dl>
                    </a>
                </div>
                <div class="car-option">
                    <a href="/web/rentcar/car-list.do?tcard_yn=Y" class="carSeatArea" target="_self">
                    	<dl>
                            <dt class="img jejupay">
                                <img src="/images/web/rent/character.png" width="81" height="157" alt="탐나는전서비스">
                            </dt>
                            <dd class="service-desc jejupay">
                                <span class="title">탐나는전 가맹점보기</span>
                                <img class="shortcuts" src="/images/web/rent/shortcuts_white.png" width="31" height="8" alt="탐나는전가맹점보기">
                                <span class="sub-title">탐나는전 프로모션으로 알뜰한 <p>제주여행 시작하세요!</p></span>
                            </dd>
                        </dl>
                    </a>
                </div>
            </div>
        </div>
    </section><!-- //customer-service -->

    <section class="rent-recommand-choice">
        <div class="inner">
            <h2>좋은 렌트카 상품을 찾는 방법</h2>
            <div class="inner-paragraph">
                <div class="paragraph--grid">
                    <img class="paragraph-ico1" src="/images/web/icon/paragraph-ico_01.png" alt="좋은렌트카상품">
                    <dl>
                        <dt>첫째, 무조건 최저가가 아닌, <br>꼼꼼히 따져보고 예약하기!</dt>
                        <dd>차량 연식, 옵션 등을 비교하고 따져봐야 합리적으로 구매할 수 있습니다.</dd>
                    </dl>
                </div>
                <div class="paragraph--grid">
                    <img class="paragraph-ico2" src="/images/web/icon/paragraph-ico_02.png" alt="자차보험">
                    <dl>
                        <dt>둘째, 자차보험 가입 여부 <br>결정하기!</dt>
                        <dd>자차보험은 차량 사고 발생 시 대여한 렌트카 파손에 대하여 보장해 주는 보험입니다. 보험 가입이 의무는 아니지만 사고 발생 시 큰 부담이 발생할 수 있습니다.</dd>
                    </dl>
                </div>
                <div class="paragraph--grid">
                    <img class="paragraph-ico3" src="/images/web/icon/paragraph-ico_03.png" alt="환불규정">
                    <dl>
                        <dt>셋째, 취소 및 환불 규정 <br>미리 확인하기!</dt>
                        <dd>렌트카 업체별로 취소 규정이 다릅니다. 여행 일정에는 변수가 생길 수 있으니 예약 전 취소 규정을 꼭 확인 바랍니다.</dd>
                    </dl>
                </div>
                <div class="paragraph--grid">
                    <img class="paragraph-ico4" src="/images/web/icon/paragraph-ico_04.png" alt="전기차">
                    <dl>
                        <dt>넷째, 친환경적인 전기차 <br>이용해 보기!</dt>
                        <dd>제주도는 전국에서 가장 많은 전기차를 보유하고 있으며, 도내에서 쉽게 전기차 충전소를 찾을 수 있습니다. </dd>
                    </dl>
                </div>
                <div class="paragraph--grid">
                    <img class="paragraph-ico5" src="/images/web/icon/paragraph-ico_05.png" alt="애견동반">
                    <dl>
                        <dt>다섯째, 애견 동반이 가능한지 <br>필터로 확인하기!</dt>
                        <dd>애견 동반, 낚시 용품 지참, 군인 대여 등이 가능한지 필터를 이용하여 조건에 검색할 수 있습니다.</dd>
                    </dl>
                </div>
                <div class="paragraph--grid">
                    <img class="paragraph-ico6" src="/images/web/icon/paragraph-ico_06.png" alt="탐나오">
                    <dl>
                        <dt>여섯째, 믿을만한 탐나오에서 <br>예약하기!</dt>
                        <dd>탐나오는 제주특별자치도에서 지원하고 제주특별자치도관광협회에서 운영하는 제주여행 공공 플랫폼입니다.</dd>
                    </dl>
                </div>
            </div>
        </div>
    </section>


    <section class="faq-accordion">
        <div class="inner">
            <h2>자주하는 문의(FAQ)</h2>
            <!-- 렌터카(tabs-3) -->
            <div id="tabs-3" class="tabPanel">
                <div class="guide-divide">
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
                                    <p class="memo answer">렌트카 예약 시 기본적으로 대인/대물/자손보험은 가입되어 있으나 자차보험은 고객님의 선택사항입니다.<br>
                                        자차보험이란 자기차에 대한 보험이라는 뜻입니다.<br>
                                        자신의 실수로 자신의 차가 파손된 경우에 보험처리를 하여 수리비를 보험사로부터 받는 것인데,
                                        보통 상대방 부주의로 사고가 났다 해도 쌍방 과실이 적용되니 가입해두는 것이 좋습니다.
                                        렌트카 회사마다 보험료는 다를 수 있으므로 차량 상세페이지 내 보험안내를 참고하시면 됩니다.<br>
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
                                    <p class="memo answer">렌트카 대여 시 면허증 지참은 필수 사항이나, 부득이하게 면허증을 분실하셨을 경우에는 가까운 경찰서 또는 정부24(www.gov.kr) 사이트에서 [운전경력증명서]를 발급받아 인수 시 지참해주시면 됩니다.<br>
                                        (면허증 및 대체 서류를 지참하지 아니한 경우, 렌트카 인수가 거절되며 당일 고객 귀책의 사유로 취소 처리 및 수수료가 발생됩니다.)</p>
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
                                        예약취소는 마이페이지 > 나의 예약/구매내역 > 예약 상세 보기에서 취소 요청을 하시면 해당 렌트카 업체에서 취소 처리를 하며, 결제된 금액은 자동 취소됩니다. 이때 취소수수료 규정에 따라서 취수 수수료를 제외한 금액만큼 결제 취소가 됩니다.
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
                                    <p class="memo answer">탐나오는 오픈마켓으로 업체마다 취소 수수료 규정이 다릅니다. 상세페이지에 안내되어 있는 렌트카 업체별 규정을 숙지하시고 예약하시기 바랍니다.</p>
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
                    </dl>
                </div>

                <div class="guide-divide">
                    <dl class="default-accordion">
                        <dt>
                            <ul class="tbOption">
                                <li class="memoWrap">
                                    <p class="memo">렌트카 예약한 후 렌트카 업체로 예약 확인 전화를 해야하나요?</p>
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
                                    <p class="memo">렌트카 인수와 반납은 어떻게 하나요?</p>
                                </li>
                            </ul>
                        </dt>
                        <dd>
                            <ul class="question">
                                <li>
                                    <p class="memo answer">2016년 9월 1일부터 제주공항 렌트카 하우스 내 대여 업무가 종료되어 렌트카 회사의 차고지에서 차량 인수 및 반납이 가능합니다.<br>
                                        제주공항 5번 게이트 부근 렌트카 종합안내센터로 이동하여 렌트카 업체에서 운행하는 셔틀버스를 탑승한 후 차고지까지 이동하시면 됩니다.<br>
                                        셔틀버스 탑승 관련 안내 메시지는 대게 차량 인수 하루 전 업체에서 전송합니다.</p>
                                </li>
                            </ul>
                        </dd>
                        <dt>
                            <ul class="tbOption">
                                <li class="memoWrap">
                                    <p class="memo">외국인도 렌트카 대여가 가능한가요?</p>
                                </li>
                            </ul>
                        </dt>
                        <dd>
                            <ul class="question">
                                <li>
                                    <p class="memo answer">렌트카 업체에 따라 외국인은 대여가 제한될 수 있으며, 예약 전 대여 가능 여부 확인이 필요합니다.<br>
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
                                    <p class="memo answer">예약자와 실제 운전자가 달라도 렌트카 대여는 가능합니다.<br>
                                        차량 인수 시 현장에서 예약자 정보로 예약 확인이 진행되며, 운전하실 분은 별도로 운전자 등록을 하시면 됩니다. 운전자는 최대 2인까지 등록 가능하며, 도로교통법상 유효한 운전면허증을 반드시 소지하여야 합니다.(렌트카 상품별 대여 조건에 부합한 운전자만 운전자 등록이 가능합니다.)</p>
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
            </div><!-- //렌터카(tabs-3) -->
        </div><!-- //inner -->
    </section>

    <!-- 렌트카 seo 디스크립션 영역추가 -->
    <section class="rental-car-overview-section">
        <div class="inner">
            <div class="car-info">
                <h2 class="info-logo">탐나오 렌트카 서비스 개요
                    <img src="/images/web/rent/car-showcase.webp"  alt="탐나오 렌트카 서비스 개요">
                </h2>
                <!-- 렌터카(tabs-3) -->

                <div class="info-article">

                    <p><span>제주도 공식 여행 공공플랫폼 탐나오 렌트카 서비스</span>는 비즈니스 및 휴가 목적을 모두 충족할 수 있는 다양한 차량을 보유하고 있습니다.</p>
                    <p>경제형, 고급형, 스포츠형, 하이브리드 차량 등 선택의 폭은 넓고 가격은 저렴합니다.</p>
                    <p>현대, 기아, 쉐보레, 벤츠, BMW, 테슬라 등 다양한 모델을 검색하고 예약하세요.</p>
                    <p>제주 지역화폐인 탐나는전으로 온라인 결제가 가능한 유일한 가맹점입니다. 숨은 비용 없이 실제 지불해야 할 금액을 정확히 안내해 드리며,</p>
                    <p>탐나오만의 특별한 혜택과 다양한 프로모션으로 비용을 절약할 수 있습니다. 제주국제공항에 도착하신 후, 안전하고 즐거운 여행을 시작하세요!</p>

                </div>
            </div>
        </div><!-- //inner -->

    </section>

</main><!-- //change contents -->
<jsp:include page="/web/foot.do"></jsp:include>
<script src="/js/moment.min.js?version=${nowDate}"></script>
<script src="/js/daterangepicker-rc-pc.js?version=${nowDate}" ></script>
<script>
/** 특별처리빅이벤트*/
let date = new Date();
let yy = date.getFullYear();
let mm = date.getMonth()+1; mm = (mm < 10) ? '0' + mm : mm;
let dd = date.getDate(); dd = (dd < 10) ? '0' + dd : dd;
let curTime = String(yy) + String(mm) + String(dd);
/** 이벤트 배너영역 */
if(curTime >= '20241129' && curTime <= '20250203' ){
    $("#lineBanner").show();
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
        $('.back-bg').daterangepicker({
            timePicker: true,
            timePicker24Hour:true,
            timePickerIncrement: 60,
            autoApply: false,
            locale: {
                "format": "YYYY년 MM월 DD일",
                "separator": " ~ ",
                "applyLabel": "확인",
                "cancelLabel": "취소",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "weekLabel": "W",
                "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
                "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            },

        }, function(start, end, label) {
            // 선택한 날짜 범위를 콘솔에 출력합니다 (필요에 따라 콜백 내용 추가).
        });

        $('.back-bg').on('apply.daterangepicker', function(ev, picker){

            if (isApplyButtonClicked) {
                if (picker.startDate == null || picker.endDate == null) {
                    alert('대여 일정을 선택 해 주세요.');
                    return;
                }

                const startDate = picker.startDate.format('YYYY-MM-DD');
                const endDate = picker.endDate.format('YYYY-MM-DD');
                let startTime = picker.startDate.format('HH:00');
                let endTime = picker.endDate.format('HH:00');

                if (startTime == "00:00") {
                    startTime = "08:00";
                }

                if (endTime == "00:00" || endTime == "23:00") {
                    endTime = "08:00";
                }

                $("#sFromDtView").val(startDate);
                $("#sToDtView").val(endDate);
                $("#sFromTmView").val(startTime);
                $("#sToTmView").val(endTime);

                // 대여시간 계산
                const timeDifference = new Date(endDate + " " + endTime + ":00") - new Date(startDate + " " + startTime + ":00");
                const hoursDifference = timeDifference / (1000 * 60 * 60);
                $(".txt-rent-period span").text(hoursDifference + "시간");
            }

            $('.lock-bg').remove();
            $('body').removeClass('not_scroll');
            // Daterangepicker 창을 수동으로 닫습니다.
            picker.hide();
        });

        /** 카운트 */
        fnCntAnimate();

        /** 슬라이드*/
        if($('#rent_slider .swiper-slide').length > 1) {
            var swiper = new Swiper('#rent_slider', {
                slidesPerView: 4,
                slidesPerGroup: 1,
                pagination: '#slideItem_paging',
                nextButton: '#slideItem_next',
                prevButton: '#slideItem_prev',
                loop: true,
                observer: true,
                observeParents: true
            });
        }

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
    });

    $(document).on('click', '.back-bg', function() {

        $('body').after('<div class="lock-bg"></div>');
        $('body').addClass('not_scroll');
        // daterangepicker 위치 설정
        var windowHeight = $(window).height();
        var windowWidth = $(window).width();
        var datePickerHeight = $('.daterangepicker').outerHeight();
        var datePickerWidth = $('.daterangepicker').outerWidth();
        var topPosition = (windowHeight - datePickerHeight) / 2;
        var leftPosition = (windowWidth - datePickerWidth) / 2;

        $('.daterangepicker').css({
            'position': 'fixed',
            'top': topPosition + 'px',
            'left': leftPosition + 'px',
        });

        $('.daterangepicker').show();

    });

    function fnGoMainList(){
        document.frm.target = "_self";
        document.frm.action = "<c:url value='/web/rentcar/car-list.do'/>";

        $("#sFromTm").val( $("#sFromTmView").val().replace(":",""));
        $("#sToTm").val( $("#sToTmView").val().replace(":",""));
        document.frm.submit();
    }

    function fnCntAnimate(){
        const allRsv = "<c:out value='${cntList.ALL_RSV}'/>";
        const ableRsv = "<c:out value='${cntList.ABLE_RSV}'/>";
        const inCorp = "<c:out value='${cntList.IN_CORP}'/>";

        //누적예약
        $({val: 0}).animate({val: allRsv}, {
            duration: 2000,
            step: function () {
                var num = commaNum(Math.floor(this.val));
                $("#allRsv").text(num);
            },
            complete: function () {
                var num = commaNum(Math.floor(this.val));
                $("#allRsv").text(num);
            }
        });

        //예약 가능 차량
        $({val: 0}).animate({val: ableRsv}, {
            duration: 2000,
            step: function () {
                var num = commaNum(Math.floor(this.val));
                $("#ableRsv").text(num);
            },
            complete: function () {
                var num = commaNum(Math.floor(this.val));
                $("#ableRsv").text(num);
            }
        });

        //제주도 입점 업체
        $({val: 0}).animate({val: inCorp}, {
            duration: 2000,
            step: function () {
                var num = commaNum(Math.floor(this.val));
                $("#inCorp").text(num);
            },
            complete: function () {
                var num = commaNum(Math.floor(this.val));
                $("#inCorp").text(num);
            }
        });

    }

    let isApplyButtonClicked = false;

    //닫기 button
    function close_calender(){
        isApplyButtonClicked = false;
        const picker = $('.back-bg').data('daterangepicker');
        picker.element.trigger('apply.daterangepicker', picker);
    }

    //적용 button
    function fn_ClickSearch(){
        isApplyButtonClicked = true;
        const picker = $('.back-bg').data('daterangepicker');
        picker.element.trigger('apply.daterangepicker', picker);

    }

</script>
</body>
</html>