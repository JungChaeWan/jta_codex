<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 			uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<c:if test="${fn:length(adImgList) == 0}">
    <c:set value="" var="seoImage"/>
</c:if>
<c:if test="${fn:length(adImgList) != 0}">
    <c:set value="${adImgList[0].savePath}thumb/${adImgList[0].saveFileNm}" var="seoImage"/>
</c:if>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?CorpId=${webdtl.corpId}"/>
<c:set var="imgUrl" value="${pageContext.request.scheme}://${strServerName}${imgList[0].savePath}thumb/${imgList[0].saveFileNm}"/>

<jsp:include page="/web/includeJs.do" flush="false">
    <jsp:param name="title" value="${webdtl.adNm} 특가 - 제주도 ${webdtl.adGrd} 예약"/>
    <jsp:param name="keywordsLinkNum" value="${webdtl.corpId}"/>
    <jsp:param name="keywordAdd1" value="제주숙박, 제주도숙박"/>
    <jsp:param name="keywordAdd2" value="${webdtl.adNm}"/>
    <jsp:param name="description" value="${seoInfo}"/>
    <jsp:param name="imagePath" value="${seoImage}"/>
    <jsp:param name="headTitle" value="${webdtl.adNm}"/>
</jsp:include>
<meta property="og:title" content="${webdtl.adNm} 특가 - 제주도 ${webdtl.adGrd} 예약" />
<meta property="og:url" content="${strUrl}" />
<meta property="og:description" content="${seoInfo}"/>
<c:if test="${fn:length(adImgList) != 0}">
<meta property="og:image" content="https://${strServerName}${adImgList[0].savePath}thumb/${adImgList[0].saveFileNm}" />
</c:if>
<meta property="fb:app_id" content="182637518742030" />

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/ad.css?version=${nowDate}'/>" />

<link rel="canonical" href="https://www.tamnao.com/web/ad/detailPrdt.do?corpId=${webdtl.corpId}">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/ad/detailPrdt.do?corpId=${webdtl.corpId}">

<c:if test="${not empty webdtl.sccUrl}">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/lite-yt-embed.css?version=${nowDate}'/>" />
<script type="text/javascript" src="<c:url value='/js/lite-yt-embed.js?version=${nowDate}'/>"></script>
</c:if>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>
<c:if test="${webdtl.gpaCnt ne null}">
<script type="application/ld+json">
{
	"@context": "https://schema.org/",
    "@type": "Product",
    "name": "[제주도 ${webdtl.adGrd}] ${webdtl.adNm}",
	"image": [
		"https://${strServerName}${adImgList[0].savePath}thumb/${adImgList[0].saveFileNm}"
	],
	"description": "${seoInfo}",
	"sku": "${webdtl.corpId}",
	"brand": {
    	"@type": "Brand",
    	"name": "탐나오"
  	},
	"aggregateRating": {
        "@type": "AggregateRating",
        "ratingValue": ${webdtl.gpaAvg eq null ? 0 : webdtl.gpaAvg},
        "reviewCount": ${webdtl.gpaCnt eq null ? 0 : webdtl.gpaCnt},
		"worstRating":0,
        "bestRating":5
	}
	<c:if test="${saleMinAmt ne null}">
	,	
	"offers": {
        "@type": "Offer",
        "url": "${strUrl}",
        "priceCurrency": "KRW",
		"price": ${saleMinAmt},
 		"lowPrice": ${saleMinAmt},
        "highPrice": ${saleMaxAmt}
	}
	</c:if>
	,
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
</c:if>

</head>
<body>
<header id="header">
    <jsp:include page="/web/head.do"></jsp:include>
</header>

<main id="main">
    <div class="mapLocation">
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>숙소</span>
        </div>
    </div>
    <div id="subContents" class="sub_wrap">
        <div class="subHead"></div>
        <div class="subContents">

            <div class="lodge2 new-detail cart"> <!-- add Class (new-detail) -->
                <div class="bgWrap2">
                    <div class="Fasten">
                        <!-- 숙박정보 -->
                        <div class="ad-detail">

                            <!--메인 이미지-->
                            <div class="ad-detail-head">
                                <div class="MosaicReloaded">
                                    <c:forEach var="result" items="${adImgList}" varStatus="status">
                                        <c:if test="${status.count eq 1}">
                                            <div class="hotel-mosaic moMain">
                                                <%-- <a href="javascript:void(0)"> --%>
                                                <span style="cursor: pointer;">
                                                    <img src="${result.savePath}thumb/${result.saveFileNm}" alt="숙박1" class="SquareImage">
                                                </span>
                                            </div>
                                        </c:if>
                                        <c:if test="${status.count eq 2}">
                                            <div class="hotel-mosaic moSub1">
                                                <%-- <a href="javascript:void(0)"> --%>
                                                <span style="cursor: pointer;">
                                                    <img src="${result.savePath}thumb/${result.saveFileNm}" alt="숙박2" class="SquareImage">
                                                </span>
                                            </div>
                                        </c:if>
                                        <c:if test="${status.count eq 3}">
                                            <div class="hotel-mosaic moSub2">
                                                    <%-- <a href="javascript:void(0)"> --%>
                                                <span style="cursor: pointer;">
                                                    <img src="${result.savePath}thumb/${result.saveFileNm}" alt="숙박3" class="SquareImage">
                                                </span>
                                            </div>
                                        </c:if>
                                        <c:if test="${status.count eq 4}">
                                            <div class="hotel-mosaic moSmall">
                                                <%-- <a href="javascript:void(0)"> --%>
                                                <span style="cursor: pointer;">
                                                    <img src="${result.savePath}thumb/${result.saveFileNm}" alt="숙박4" class="SquareImage">
                                                </span>
                                            </div>
                                        </c:if>
                                        <c:if test="${status.count eq 5}">
                                            <div class="hotel-mosaic moSmall2">
                                                <%-- <a href="javascript:void(0)"> --%>
                                                <span style="cursor: pointer;">
                                                    <img src="${result.savePath}thumb/${result.saveFileNm}" alt="숙박5" class="SquareImage">
                                                    <div class="picOverlay">
                                                        <div class="picOverlay_con">
                                                            <div class="picMore">
                                                                <%-- <a href="javascript:void(0)" onclick="openSlide('');" class="picMore_tx">사진 보기</a> --%>
                                                                <span onclick="openSlide('');" class="picMore_tx" style="cursor: pointer;">사진 보기</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </span>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                    <div id="picAll_area" class="hotel-detail">
                                        <div id="detail_slider" class="swiper-container detail-slider roomType">
                                            <%-- <a class="close"><img src="/images/mw/common/side/close-white.png" alt="닫기" onclick="$('#detail_slider').removeClass('active');" ></a> --%>
                                            <span class="close"><img src="/images/mw/common/side/close-white.png" loading="lazy" alt="닫기" onclick="$('#detail_slider').removeClass('active');" ></span>
                                            <div class="swiper-wrapper">
                                                <c:forEach var="result" items="${adImgList}" varStatus="status">
                                                    <div class="swiper-slide">
                                                        <img src="${result.savePath}thumb/${result.saveFileNm}" loading="lazy" alt="숙박">
                                                            <%--<div class="img-caption">
                                                                <p>숙소소개</p>
                                                            </div>--%>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <div id="detail_paging" class="swiper-pagination"></div>
                                            <div id="detail_arrow" class="arrow-area">
                                                <div id="detail_next" class="swiper-button-next"></div>
                                                <div id="detail_prev" class="swiper-button-prev"></div>
                                            </div>
                                        </div>
                                    </div> <!--//layer-popup-->
                                </div>
                            </div>

                            <div>
                                <!--숙소 상세정보-->
                                <div class="ad-detail-area">
                                    <div class="ad-detail-info">
                                        <div class="ad-info-area">
                                            <div class="ad-memo">${webdtl.adSimpleExp}</div>
                                            <div class="ad-title">${webdtl.adNm }</div>
                                            <div class="score-area">
                                                <span class="icon" id="useepil_uiTopHearts"></span>
                                                <a href="#tabs-5" class="review_num">(0)</a>
                                            </div>
                                            <div class="ad-address">${webdtl.roadNmAddr}</div>
                                        </div>
                                        <div class="bxLabel">
                                            <c:if test="${adHotDay.daypriceYn == 'Y'}"><span class="main_label pink">당일특가</span></c:if>
                                            <c:if test="${adHotDay.eventYn == 'Y'}"><span class="main_label eventblue">이벤트</span></c:if>
                                            <c:if test="${adHotDay.couponYn == 'Y'}"><span class="main_label pink">할인쿠폰</span></c:if>
                                            <c:if test="${adHotDay.continueNightYn == 'Y'}"><span class="main_label back-red">연박할인</span></c:if>
                                            <c:if test="${adHotDay.superbCorpYn == 'Y' }"><span class="main_label back-red">우수관광사업체</span></c:if>
                                            <c:if test="${adHotDay.tamnacardYn eq 'Y'}"><span class="main_label yellow">탐나는전</span></c:if>
                                        </div>
                                        <div>
                             <%--               <a class="ui-open-pop" href="javascript:show_popup('#adLayerpop');">
                                                <div class="ad-see-promotion">
                                                    <div class="adPromotion">
                                                        <div class="title--discount">아래 보이는 상품가에 ~30% 슈퍼 할인</div>
                                                        <div class="article">결제 단계에서 확인 가능</div>
                                                        <div class="more">더보기</div>
                                                    </div>
                                                </div>
                                            </a>--%>

                                            <!-- 프로모션 레이어팝업 -->
                                           <div id="adLayerpop" class="comm-layer-popup_fixed">
                                               <div class="content-wrap">
                                                   <div class="detail-header">
                                                       <div class="pop-title">결제혜택</div>
                                                       <button type="button" class="close" onclick="close_popup('#adLayerpop')">
                                                           <img src="/images/mw/icon/close/dark-gray.png" loading="lazy" alt="닫기" title="닫기">
                                                       </button>
                                                   </div>
                                                   <div class="content-article">
                                                       <div class="paragraph">
                                                           <span class="num">Promotion</span>
                                                           <p>총 15만원 즉시 할인 쿠폰 5종 증정 <br>(ID 당 각 1 회 사용 가능)</p>
                                                           <p>• 구매 금액대별 3천원 , 1만 5천원 , 3만원 , 4만 5천원 , 6만원 쿠폰 할인</p>
                                                       </div>

<%--                                                       <div class="paragraph">
                                                           <span class="num">Promotion</span>
                                                           <p>총 10만원 즉시 할인 쿠폰 5종 증정 <br>(ID당 각 1회 사용 가능)</p>
                                                           <p>• 구매 금액대별 2천원, 1만원, 2만원, 3만원, 4만원 쿠폰 할인</p>
                                                       </div>--%>

                                                       <%--<div class="paragraph">
                                                           <span class="num">Promotion 3</span>
                                                         <p>할인쿠폰 3 장 이상 사용 고객 제주 특산물 증정</p>
                                                       </div>--%>

                                                   </div>
                                               </div>
                                            </div>

                                            <div class="adDetail">
                                                <div class="">
                                                    <ul class="FavFeatures__List">
                                                        <c:forEach var="icon" items="${iconCdList}">
                                                            <c:if test="${icon.checkYn eq 'Y'}">
                                                                <li><img src="/images/web/ad/${icon.iconCd}.png" width="40" height="40" alt="${icon.iconCdNm}_top"><p>${icon.iconCdNm}</p></li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                                <p class="_adDetail">
                                                    ${webdtl.infIntrolod}
                                                </p>
                                                <div class="grayspace"></div>
                                                <div class="show-more"><span class="show-more">더 보기</span></div>
                                                <c:if test="${fn:length(prmtList) > 0}" >
                                                    <div class="ad-event">
                                                        <div class="evnt_label">
                                                <span>
                                                    <svg viewBox="0 0 1000 1000" role="presentation" aria-hidden="true" focusable="false" style="height:14px; width:14px; fill:currentColor">
                                                        <path d="M972 380c9 28 2 50-20 67L725 619l87 280c11 39-18 75-54 75-12 0-23-4-33-12L499 790 273 962a58 58 0 0 1-78-12 50 50 0 0 1-8-51l86-278L46 447c-21-17-28-39-19-67 8-24 29-40 52-40h280l87-279c7-23 28-39 52-39 25 0 47 17 54 41l87 277h280c24 0 45 16 53 40z"></path>
                                                    </svg>
                                                </span>
                                                            Event & Issue
                                                        </div>
                                                        <c:forEach items="${prmtList}" var="prmt">
                                                            <div class="evnt_tx">
                                                                <div class="evnt_title"><c:url value="${prmt.prmtNm}" /></div>
                                                                <div class="evnt_date"><fmt:parseDate value="${prmt.startDt}" var="startDt" pattern="yyyyMMdd" />
                                                                    <fmt:parseDate value="${prmt.endDt}" var="endDt" pattern="yyyyMMdd" />
                                                                    <fmt:formatDate value="${startDt}" pattern="yyyy년 MM월 dd일" /> - <fmt:formatDate value="${endDt}" pattern="yyyy년 MM월 dd일" />
                                                                </div>
                                                                <c:if test="${not empty prmt.prmtExp}">
                                                                    <div class="evnt_memo"  style="white-space:pre-wrap;">${prmt.prmtExp}</div>
                                                                </c:if>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>

                                    <!--필터-->
                                    <div class="filter_right">
                                        <form name="frm" id="frm" method="get" action="<c:url value='/web/ad/detailPrdt.do' />">
                                            <input type="hidden" name="sSearchYn" id="sSearchYn" value="${'Y' }" />
                                            <input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
                                            <input type="hidden" name="sAdAdar" id="sAdAdar" value="${searchVO.sAdAdar}" />
                                            <input type="hidden" name="sAdDiv" id="sAdDiv" value="${searchVO.sAdDiv}" />
                                            <input type="hidden" name="sPriceSe" id="sPriceSe" value="${searchVO.sPriceSe}" />
                                            <input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}" />
                                            <input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />
                                            <input type="hidden" name="corpId" id="corpId" value="${webdtl.corpId}" />
                                            <input type="hidden" name="prdtNum" id="prdtNum" />
                                            <input type="hidden" name="sPrdtNum" id="sPrdtNum" />
                                            <input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
                                            <input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
                                            <input type="hidden" name="sNights" id="sNights" value="${searchVO.sNights}">
                                            <input type="hidden" name="sMen" id="sMen" value="${searchVO.sMen}">
                                            <input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>
                                            <input type="hidden" id="chkSelDate" value="0" />
                                            <%--<div class="boxBackdrop"></div>--%>
                                            <div class="ad-filter-area">

                                                <div class="filter_check">
                                                    <div class="f_con">
                                                        <div class="date_wrap">
                                                            <div class="date_checkin">
                                                                <label>체크인</label>
                                                                <div class="value-text">
                                                                    <div class="date-container">
                                                                <span class="date-pick">
                                                                    <input type="hidden" name="vNights" id="vNights" value="${searchVO.sNights}">
                                                                    <input class="datepicker" type="text" id="sFromDtView" name="sFromDtView" value="${searchVO.sFromDtView}" placeholder="입실일 선택" onclick="optionClose('.popup-typeA')">
                                                                </span>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="date_checkout">
                                                                <label>체크아웃</label>
                                                                <div class="value-text">
                                                                    <div class="date-container">
                                                                <span class="date-pick">
                                                                    <input class="datepicker" type="text" id="sToDtView" name="sToDtView" value="${searchVO.sToDtView}" placeholder="퇴실일 선택" onclick="optionClose('.popup-typeA')">
                                                                </span>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="custom_wrap">
                                                            <label>인원</label>
                                                            <div class="value-text">
                                                                <%-- <a href="javascript:void(0)" onclick="optionPopup('#hotel_count', this)" id="room_person_str"> --%>
                                                                <a onclick="optionPopup('#hotel_count', this)" id="room_person_str">
                                                                    성인 ${searchVO.sAdultCnt }
                                                                    <c:if test="${searchVO.sChildCnt > 0 }">, 소아 ${searchVO.sChildCnt }</c:if>
                                                                    <c:if test="${searchVO.sBabyCnt > 0 }">, 유아 ${searchVO.sBabyCnt }</c:if>
                                                                </a>
                                                            </div>
                                                            <div id="hotel_count" class="popup-typeA hotel-count">
                                                                <div class="detail-area">
                                                                    <input type="hidden" name="sRoomNum" id="sRoomNum" value="1">
                                                                </div>
                                                                <div class="detail-area counting-area">
                                                                    <div class="counting">
                                                                        <div class="l-area">
                                                                            <strong class="sub-title">성인</strong>
                                                                            <span class="memo"><c:out value="${webdtl.adultAgeStd}" /></span>
                                                                        </div>
                                                                        <div class="r-area">
                                                                            <input type="hidden" name="sAdultCnt" value="${searchVO.sAdultCnt }" />
                                                                            <button type="button" class="counting-btn" onclick="chg_person('-', 'Adult')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                                            <span class="counting-text" id="AdultNum">${searchVO.sAdultCnt }</span>
                                                                            <button type="button" class="counting-btn" onclick="chg_person('+', 'Adult')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                                        </div>
                                                                    </div>
                                                                    <c:if test="${webdtl.juniorAbleYn eq 'Y'}">
                                                                    <div class="counting">
                                                                        <div class="l-area">
                                                                            <strong class="sub-title">소아</strong>
                                                                            <span class="memo"><c:out value="${webdtl.juniorAgeStd}" /></span>
                                                                        </div>
                                                                        <div class="r-area">
                                                                            <button type="button" class="counting-btn" onclick="chg_person('-', 'Child')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                                            <span class="counting-text" id="ChildNum">${searchVO.sChildCnt }</span>
                                                                            <button type="button" class="counting-btn" onclick="chg_person('+', 'Child')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                                        </div>
                                                                    </div>
                                                                    </c:if>
                                                                    <input type="hidden" name="sChildCnt" value="${searchVO.sChildCnt }" />
                                                                    <c:if test="${webdtl.childAbleYn eq 'Y'}">
                                                                    <div class="counting">
                                                                        <div class="l-area">
                                                                            <strong class="sub-title">유아</strong>
                                                                            <span class="memo"><c:out value="${webdtl.childAgeStd}" /></span>
                                                                        </div>
                                                                        <div class="r-area">
                                                                            <button type="button" class="counting-btn" onclick="chg_person('-', 'Baby')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                                            <span class="counting-text" id="BabyNum">${searchVO.sBabyCnt }</span>
                                                                            <button type="button" class="counting-btn" onclick="chg_person('+', 'Baby')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                                        </div>
                                                                    </div>
                                                                    </c:if>
                                                                    <input type="hidden" name="sBabyCnt" value="${searchVO.sBabyCnt }" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="search_btn">
                                                            <a href="javascript:document.frm.submit()">재검색</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="total-area">
                                                    <c:if test="${searchVO.sSearchYn eq 'Y'}">
                                                        <div class="money"><small id ="totalRoomCnt"></small><strong id="adTotalPrice">0</strong>원</div>
                                                        <div class="text" id="adTotalStr"></div>

                                                    </c:if>
                                                </div>
                                                <%--<div class="total-area">
                                                    <div class="money"><strong>999,000</strong>원</div>
                                                    <div class="text">
                                                        1박 15,000원 + 소아 추가금액 10,000원
                                                        <span class="text-red"> 연박할인 5,000원</span>
                                                    </div>
                                                </div>--%>

                                                <!-- 0829 프로모션 CTA 삽입 -->
                                               <%--<div class="promotion-coupon">* 예약단계에서 쿠폰 적용시 <span>~20% 추가할인</span> 가능</div>--%>

                                                <div class="purchasing-info">
                                                    <c:if test="${chkPointBuyAble eq 'Y'}">
                                                    <div class="purchase-btn-group">
                                                        <button type="button" id="cartBtn" class="comm-btn gray width40" onclick="javascript:fn_adAddCart();">장바구니</button>
                                                        <c:if test="${searchVO.sSearchYn eq 'N'}">
                                                            <button type="button" class="comm-btn red width60" onclick="return fn_chkDate();">예약하기</button>
                                                        </c:if>
                                                        <c:if test="${searchVO.sSearchYn eq 'Y'}">
                                                            <button type="button" class="comm-btn red width60" id="adBuyBtn" onclick="fn_adAddSale();">예약하기</button>
                                                        </c:if>
                                                    </div>
                                                    </c:if>
                                                    <c:if test="${chkPointBuyAble ne 'Y'}">
                                                        <div class="purchase-btn-group">
                                                            <button type="button" class="comm-btn gray width100">구매불가</button>
                                                        </div>
                                                    </c:if>
                                                </div> <!-- //purchasing-info -->
                                            </div>
                                        </form>
                                    </div>

                                    <div class="ad-detail-con">
                                        <section class="room_info">
                                            <h2 class="sec-caption">방 정보</h2>
                                            <c:set var="veiwCnt" value="1" />
                                            <c:forEach var="result" items="${prdtList}" varStatus="status">
                                                <c:set var="loopCnt" value="${status.count }" />
                                                <c:if test="${result.memExcdAbleYn == 'Y'}">
                                                    <c:set var="maxMem" value="${result.maxiMem }"/>
                                                </c:if>
                                                <c:if test="${result.memExcdAbleYn != 'Y'}">
                                                    <c:set var="maxMem" value="${result.stdMem }"/>
                                                </c:if>
                                                <c:if test="${((searchVO.sSearchYn eq 'N') or (maxMem >= (searchVO.sAdultCnt + searchVO.sChildCnt + searchVO.sBabyCnt))) }">
                                                    <input type="hidden" id="ctnAmt${status.count }" value="${result.ctnAmt }" />
                                                    <input type='hidden' id='disDaypriceAmt${status.count }' value='${result.disDaypriceAmt }' />
                                                    <input type="hidden" id="saleAmt${status.count }" value="${result.saleAmt + result.ctnAmt + result.disDaypriceAmt }" />
                                                    <input type="hidden" id="nmlAmt${status.count }" value="${result.nmlAmt}" />
                                                    <input type="hidden" id="ableRsvNum${status.count }" value="${result.ableRsvNum }" />
                                                    <input type="hidden" id="adultAddAmt" value="${fn:trim(fn:replace(result.adultAddAmt, ',', '')) }" />
                                                    <input type="hidden" id="juniorAddAmt" value="${fn:trim(fn:replace(result.juniorAddAmt, ',', '')) }" />
                                                    <input type="hidden" id="childAddAmt" value="${fn:trim(fn:replace(result.childAddAmt, ',', '')) }" />
                                                    <c:set var="adultAddAmt" value="0"/>
                                                    <c:set var="childAddAmt" value="0"/>
                                                    <c:set var="babyAddAmt" value="0"/>
                                                    <c:set var="addAdultPrice" value="0"/>
                                                    <c:set var="addChildPrice" value="0"/>
                                                    <c:set var="addBabyPrice" value="0"/>

                                                    <c:if test="${result.addamtYn == 'Y'}">
                                                        <c:if test="${not empty result.adultAddAmt}">
                                                            <fmt:parseNumber var="adultAddAmt" type="number" value="${fn:trim(fn:replace(result.adultAddAmt, ',', '')) }" />
                                                        </c:if>
                                                        <c:if test="${not empty result.juniorAddAmt}">
                                                            <fmt:parseNumber var="childAddAmt" type="number" value="${fn:trim(fn:replace(result.juniorAddAmt, ',', '')) }" />
                                                        </c:if>
                                                        <c:if test="${not empty result.childAddAmt}">
                                                            <fmt:parseNumber var="babyAddAmt" type="number" value="${fn:trim(fn:replace(result.childAddAmt, ',', '')) }" />
                                                        </c:if>
                                                        <c:if test="${searchVO.sAdultCnt > result.stdMem}">
                                                            <c:set var="addAdultPrice" value="${(searchVO.sAdultCnt - result.stdMem) * adultAddAmt }"/>
                                                        </c:if>
                                                        <c:if test="${(addAdultPrice > 0) and (searchVO.sChildCnt > 0) }">
                                                            <c:set var="addChildPrice" value="${searchVO.sChildCnt * childAddAmt }"/>
                                                        </c:if>
                                                        <c:if test="${(addAdultPrice eq 0) and (searchVO.sChildCnt > (result.stdMem - searchVO.sAdultCnt))}">
                                                            <c:set var="addChildPrice" value="${(searchVO.sChildCnt - (result.stdMem - searchVO.sAdultCnt)) * childAddAmt }"/>
                                                        </c:if>
                                                        <c:if test="${((addAdultPrice + addChildPrice) > 0) and (searchVO.sBabyCnt > 0) }">
                                                            <c:set var="addBabyPrice" value="${searchVO.sBabyCnt * babyAddAmt }"/>
                                                        </c:if>
                                                        <c:if test="${((addAdultPrice + addChildPrice) eq 0) and (searchVO.sBabyCnt > (result.stdMem - searchVO.sAdultCnt - searchVO.sChildCnt))}">
                                                            <c:set var="addBabyPrice" value="${(searchVO.sBabyCnt - (result.stdMem - searchVO.sAdultCnt - searchVO.sChildCnt)) * babyAddAmt }"/>
                                                        </c:if>
                                                    </c:if>

                                                    <input type="hidden" id="addAdultAmt${status.count }" value="${addAdultPrice * searchVO.sNights }" />
                                                    <input type="hidden" id="addChildAmt${status.count }" value="${addChildPrice * searchVO.sNights }" />
                                                    <input type="hidden" id="addBabyAmt${status.count }" value="${addBabyPrice * searchVO.sNights }" />
                                                    <div class="room">
                                                        <c:if test="${fn:length(result.imgList) > 0}" >
                                                            <%-- <a href="javascript:void(0)" onclick="openSlide(${status.count})" class="pic_view" > --%>
                                                            <span onclick="openSlide(${status.count})" class="pic_view" style="cursor: pointer;">
                                                                <c:forEach var="prdtImg" items="${result.imgList}" varStatus="status1">
                                                                    <c:if test="${status1.count < 2}">
                                                                        <c:if test="${result.prdtNum eq 'AD00002411' || result.prdtNum eq 'AD00002426' || result.prdtNum eq 'AD00002425' || result.prdtNum eq 'AD00002423' || result.prdtNum eq 'AD00002424' || result.prdtNum eq 'AD00002422'  }">
                                                                            <span class="thumLabel">기부객실</span>
                                                                        </c:if>
                                                                        <img id="imgPath${status.count}" src="${prdtImg.savePath}thumb/${prdtImg.saveFileNm}" data-group="group" alt="숙박">
                                                                    </c:if>
                                                                </c:forEach>
                                                            </span>
                                                        </c:if>

                                                        <div class="room_info_memo">
                                                                <%--예약 가능 상태에서만 노출--%>
                                                            <c:if test="${not empty result.saleAmt && result.ableRsvNum > 0 && dayRsvCnt != '0' }">
                                                                <div>
                                                                    <input type="checkbox" name="chkRoom" id="${status.count }" class="rf_chk" aria-label="객실 수 선택" value="${result.prdtNum}"onclick="accountTotAmt();" <%--<c:if test="${result.prdtNum eq searchVO.sPrdtNum }">checked</c:if>--%>>
                                                                    <label for="${status.count }" class="label_chk"></label>
                                                                </div>
                                                            </c:if>
                                                            <div class="item-count-area">
                                                                <c:if test="${not empty result.saleAmt && result.ableRsvNum > 0 && dayRsvCnt != '0' }">
                                                                    <button type="button" class="counting-btn" id="cntMinus${status.count }" <c:if test="${searchVO.sSearchYn eq 'Y'}">onclick="applyCntPrice('-', '${status.count }');"</c:if><c:if test="${searchVO.sSearchYn eq 'N'}">onclick="return fn_chkDate();"</c:if> >
                                                            <span class="num_min">
                                                                <svg viewBox="0 0 24 24" role="img" aria-label="차감" focusable="false" style="height: 1.2em; width: 1.2em; display: block; fill: #e8202e;"><rect height="2" rx="1" width="12" x="6" y="11"></rect></svg>
                                                            </span>
                                                                    </button>
                                                                    <span class="counting-text" id="cntNum${status.count }">1</span>
                                                                    <button type="button" class="counting-btn" id="cntPlus${status.count }" <c:if test="${searchVO.sSearchYn eq 'Y'}">onclick="applyCntPrice('+', '${status.count }');"</c:if><c:if test="${searchVO.sSearchYn eq 'N'}">onclick="return fn_chkDate();"</c:if> >
                                                            <span class="num_plus">
                                                                 <svg viewBox="0 0 24 24" role="img" aria-label="추가" focusable="false" style="height: 1.2em; width: 1.2em; display: block; fill: #e8202e;"><rect height="2" rx="1" width="12" x="6" y="11"></rect><rect height="12" rx="1" width="2" x="11" y="6"></rect></svg>
                                                            </span>
                                                                    </button>
                                                                </c:if>
                                                            </div>
                                                            <div class="title"><span class="ad_option">선택${veiwCnt }</span> <p id="prdtNm${status.count }">${result.prdtNm}</p></div>
                                                            <div class="memo">
                                                                <c:if test="${not empty result.prdtExp }">
                                                                    <c:out value="${result.prdtExp }"/>
                                                                </c:if>
                                                                (조식
                                                                <c:choose>
                                                                    <c:when test="${result.breakfastYn == 'Y' }">포함</c:when>
                                                                    <c:otherwise>미포함</c:otherwise>
                                                                </c:choose>)
                                                            </div>
                                                            <div class="other-group">
                                                                <div class="inline-typeA">
                                                                    <p>
                                                                        <c:if test="${result.memExcdAbleYn == 'Y'}">
                                                                            기준 <span id="stdMem${status.count }">${result.stdMem }</span>인 / 최대 <span id="maxMem${status.count }">${result.maxiMem }</span>인
                                                                        </c:if>
                                                                        <c:if test="${result.memExcdAbleYn != 'Y'}">
                                                                            기준 <span id="stdMem${status.count }">${result.stdMem }</span>인 / 최대 <span id="maxMem${status.count }">${result.stdMem }</span>인
                                                                        </c:if>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="bxLabel">
                                                                <c:if test="${(result.daypriceYn == 'Y') and (result.disDaypriceAmt > 0)}"><span class="main_label pink">당일특가</span></c:if>
                                                                <c:if test="${result.eventCnt > 0}"><span class="main_label eventblue">이벤트</span></c:if>
                                                                <c:if test="${result.couponCnt > 0}"><span class="main_label pink">할인쿠폰</span></c:if>
                                                                <c:if test="${result.ctnAplYn == 'Y'}"><span class="main_label back-red">연박할인</span></c:if>
                                                                <c:if test="${result.tamnacardYn eq 'Y'}"><span class="main_label yellow">탐나는전</span></c:if>
                                                            </div>

                                                            <!--1230 날짜별 객실요금(datepicker) btn 생성-->
                                                            <div class="reservation_confirm">
                                                                <a href="javascript:fn_ShowLayer('${result.prdtNum}')" class="order_btn">
                                                                    <span class="date_icon">D</span>
                                                                    <span class="date_txt">날짜별 객실요금</span>
                                                                </a>
                                                            </div><!-- //1230 날짜별 객실요금(datepicker) btn 생성-->
                                                            <div class="price">
                                                                <div class="sale-position">
                                                                        <%-- 당일특가 + 연박--%>
                                                                    <c:if test="${(result.ctnAmt > 0)  and (result.disDaypriceAmt > 0) }">
                                                                        <span class="label-triangle">당일특가,연박 <span id="disPriceAmtStr${status.count }"><fmt:formatNumber value='${result.disDaypriceAmt + result.ctnAmt }'/></span>원 추가할인</span>
                                                                        <del><span id="oriSaleAmt${status.count }"><fmt:formatNumber value='${result.nmlAmt}'/></span>원</del>
                                                                    </c:if>
                                                                        <%-- 당일특가만--%>
                                                                    <c:if test="${(result.ctnAmt eq 0) and (result.daypriceYn eq 'Y') and (result.disDaypriceAmt > 0) }">
                                                                        <span class="label-triangle">당일특가 <span id="disPriceAmtStr${status.count }"><fmt:formatNumber value='${result.disDaypriceAmt }'/></span>원 추가할인</span>
                                                                        <del><span id="oriSaleAmt${status.count }"><fmt:formatNumber value='${result.nmlAmt}'/></span>원</del>
                                                                    </c:if>
                                                                        <%-- 연박만--%>
                                                                    <c:if test="${(result.ctnAplYn eq 'Y') and (result.ctnAmt > 0) and (result.disDaypriceAmt eq 0) }">
                                                                        <span class="label-triangle">연박 <span id="disPriceAmtStr${status.count }"><fmt:formatNumber value='${result.ctnAmt }'/></span>원 추가할인</span>
                                                                        <del><span id="oriSaleAmt${status.count }"><fmt:formatNumber value='${result.nmlAmt}'/></span>원</del>
                                                                    </c:if>
                                                                        <%-- 기본할인금액만--%>
                                                                    <c:if test="${(result.ctnAmt eq 0) and (result.disDaypriceAmt eq 0) and (result.daypriceYn ne 'Y') and (result.saleAmt ne result.nmlAmt) and (result.rsvAbleYn eq 'Y') }">
                                                                        <del><span id="oriSaleAmt${status.count }"><fmt:formatNumber value='${result.nmlAmt}'/></span>원</del>
                                                                    </c:if>
                                                                </div>
                                                                <c:if test="${result.rsvAbleYn eq 'N'}"><span class="sale text__deadline">예약마감</span></c:if>
                                                                <c:if test="${result.rsvAbleYn eq 'Y'}"><span class="sale"><span id="saleAmtStr${status.count }"><fmt:formatNumber value='${result.saleAmt }'/></span>원</span></c:if>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="hotel-detail">
                                                        <div id="detail_slider${status.count }" class="swiper-container detail-slider roomType">
                                                            <%-- <a onclick="$('#detail_slider${status.count}').removeClass('active');" class="close"><img src="/images/mw/common/side/close-white.png" alt="닫기" ></a> --%>
                                                            <span onclick="$('#detail_slider${status.count}').removeClass('active');" class="close"><img src="/images/mw/common/side/close-white.png" loading="lazy" alt="닫기" ></span>
                                                            <div class="swiper-wrapper">
                                                                <c:forEach var="result2" items="${result.imgList}" varStatus="status2">
                                                                    <div class="swiper-slide">
                                                                        <img src="${result2.savePath}thumb/${result2.saveFileNm}" loading="lazy" alt="숙박">
                                                                        <div class="img-caption">
                                                                            <p>객실이미지${status2.count }</p>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                            <div id="detail_paging${loopCnt}" class="swiper-pagination"></div>
                                                            <div id="detail_arrow${loopCnt}" class="arrow-area">
                                                                <div id="detail_next${loopCnt}" class="swiper-button-next"></div>
                                                                <div id="detail_prev${loopCnt}" class="swiper-button-prev"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <c:set var="veiwCnt" value="${veiwCnt + 1 }" />
                                                </c:if>
                                            </c:forEach>
                                        </section>
                                        <section class="ad_info">
                                            <c:if test="${not empty webdtl.sccUrl}">
                                            	<div class="video-area">
                                                    <lite-youtube videoid="${fn:replace(webdtl.sccUrl, 'https://www.youtube.com/embed/', '')}" playlabel="${webdtl.adNm} 유튜브영상"></lite-youtube>
                                                </div>
                                            	<%--
                                                <div class="video-area">
                                                    <iframe title="${webdtl.adNm} 유튜브영상" width="800" height="350" src="${webdtl.sccUrl}" allowfullscreen></iframe>
                                                </div>
                                                --%>
                                            </c:if>

                                            <!--상품설명-->
                                            <div class="ad-info-title">한눈에 보기</div>
                                            <div class="sub-section">
                                                <div class="sub-section-left">
                                                    <div class="line_seperator"></div>
                                                    <h2 class="sub-section-header"> Tip </h2>
                                                </div>
                                                <div class="sub-section-right">
                                                    <div class="line_seperator"></div>
                                                    <div class="collapsed">
                                                        <div>
                                                            <p class="ad-tip">${webdtl.tip}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="sub-section">
                                                <div class="sub-section-left">
                                                    <div class="line_seperator"></div>
                                                    <h2 class="sub-section-header"> 편의시설 </h2>
                                                </div>
                                                <div class="sub-section-right">
                                                    <div class="line_seperator"></div>
                                                    <div class="collapsed">
                                                        <ul class="FavFeatures__List">
                                                            <c:forEach var="icon" items="${iconCdList}">
                                                                <c:if test="${icon.checkYn eq 'Y'}">
                                                                    <li><img src="/images/web/ad/${icon.iconCd}.png" width="40" height="40" alt="${icon.iconCdNm}_middle"><p>${icon.iconCdNm}</p></li>
                                                                </c:if>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="sub-section">
                                                <div class="sub-section-left">
                                                    <div class="line_seperator"></div>
                                                    <h2 class="sub-section-header">객실 비품 안내</h2>
                                                </div>
                                                <div class="sub-section-right">
                                                    <div class="line_seperator"></div>
                                                    <div class="collapsed">
                                                        <p class="">${webdtl.infEquinf}</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="sub-section">
                                                <div class="sub-section-left">
                                                    <div class="line_seperator"></div>
                                                    <h2 class="sub-section-header">이용안내</h2>
                                                </div>
                                                <div class="sub-section-right">
                                                    <div class="line_seperator"></div>
                                                    <div class="collapsed">
                                                        <p class="">${webdtl.infOpergud}</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="sub-section">
                                                <div class="sub-section-left">
                                                    <div class="line_seperator"></div>
                                                    <h2 class="sub-section-header">참고사항(특전사항)</h2>
                                                </div>
                                                <div class="sub-section-right">
                                                    <div class="line_seperator"></div>
                                                    <div class="collapsed">
                                                        <p class="">${webdtl.infNti}</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="sub-section">
                                                <div class="sub-section-left">
                                                    <div class="line_seperator"></div>
                                                    <h2 class="sub-section-header">체크인</h2>
                                                </div>
                                                <div class="sub-section-right">
                                                    <div class="line_seperator"></div>
                                                    <div class="">
                                                        <div class="collapsed">
                                                            <p>${webdtl.chkinTm}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="sub-section">
                                                <div class="sub-section-left">
                                                    <div class="line_seperator"></div>
                                                    <h2 class="sub-section-header">체크아웃</h2>
                                                </div>
                                                <div class="sub-section-right">
                                                    <div class="line_seperator"></div>
                                                    <div class="">
                                                        <div class="collapsed">
                                                            <p>${webdtl.chkoutTm}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="sub-section">
                                                <div class="sub-section-left">
                                                    <div class="line_seperator"></div>
                                                    <h2 class="sub-section-header">취소/환불</h2>
                                                </div>
                                                <div class="sub-section-right">
                                                    <div class="line_seperator"></div>
                                                    <div class="collapsed">${webdtl.cancelGuide }</div>
                                                </div>
                                            </div>
                                        </section>
                                        <!--위치/주변 관광지-->
                                        <section class="side_info">
                                            <div class="ad-info-title">위치<%--/주변 관광지--%></div>
                                            <div class="type-bodyA">
                                                <div class="typeA">
                                                    <div>
                                                        <div class="map-area rent">
                                                            <div class="sighMap map-area" id="sighMap"></div>
                                                            <%--<div class="sighMap-list">
                                                                <ul id="signMap-ul"></ul>
                                                            </div>--%>
                                                            <script type="text/javascript">
                                                                var mapContainer = document.getElementById("sighMap");
                                                                var mapOption = {
                                                                    //center: new daum.maps.LatLng(33.4888341, 126.49807970000006),
                                                                    center: new daum.maps.LatLng(${corpVO.lat}, ${corpVO.lon}),
                                                                    level: 6
                                                                };

                                                                var map = new daum.maps.Map(mapContainer, mapOption);
                                                                // 현재 위치.
                                                                var markerPosition = new daum.maps.LatLng(${corpVO.lat}, ${corpVO.lon});
                                                                var imageSrc = "/images/web/icon/location_my.png";
                                                                var imageSize = new daum.maps.Size(24, 35);
                                                                var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);
                                                                var marker = new daum.maps.Marker({
                                                                    map: map,
                                                                    position: markerPosition,
                                                                    image: markerImage
                                                                });

                                                               /* $.ajax({
                                                                    url: "<c:url value='/web/api/tour.ajax'/>",
                                                                    data: "lon=${corpVO.lon}&lat=${corpVO.lat}",
                                                                    dataType: "json",
                                                                    success: function(data) {
                                                                        var resultCode = data.response.header.resultCode;

                                                                        if(resultCode == "0000") {
                                                                            var positions = [];
                                                                            var signMapList = [];
                                                                            var bounds = new daum.maps.LatLngBounds();
                                                                            var cnt = 1;

                                                                            var items = data.response.body.items.item;

                                                                            $(items).each(function() {
                                                                                if(this.cat1 == "A01" || this.cat1 == "A02") {
                                                                                    markerPosition = new daum.maps.LatLng(this.mapy, this.mapx);

                                                                                    positions.push({title: this.title, latlng: markerPosition});

                                                                                    var content = "<li>";
                                                                                    content += "<div class='icWrap'>" + cnt + "</div>";
                                                                                    content += "<div class='info'>";
                                                                                    content += "<h5><a href='javascript:setMove(" + this.mapy + "," + this.mapx + ");'>" + this.title + "</a></h5>";
                                                                                    content += "<p>";
                                                                                    content += this.addr1.replace("제주특별자치도", "");
                                                                                    if(this.addr2) {
                                                                                        content += " " + this.addr2;
                                                                                    }
                                                                                    if(this.tel) {
                                                                                        content += ". " + this.tel;
                                                                                    }
                                                                                    content += "</p>";
                                                                                    content += "</div>";
                                                                                    content += "</li>";

                                                                                    signMapList.push(content);

                                                                                    bounds.extend(markerPosition);
                                                                                    cnt++;
                                                                                }
                                                                            });

                                                                            for(var i = 0; i < positions.length; i ++) {
                                                                                imageSrc = "/images/web/icon/location" + (i + 1) +".png";
                                                                                markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);

                                                                                marker = new daum.maps.Marker({
                                                                                    map: map,
                                                                                    position: positions[i].latlng,
                                                                                    title: positions[i].title,
                                                                                    image: markerImage
                                                                                });
                                                                            }
                                                                            if(signMapList.length > 0) {
                                                                                mapContainer.style.width = "630px";
                                                                                map.relayout();
                                                                                map.setBounds(bounds);

                                                                                signMapList.push("<p class='align-right label sm'>제공 : 한국관광공사</p>");
                                                                                $("#signMap-ul").show().append(signMapList);
                                                                            } else {
                                                                                $(".sighMap-list").hide();
                                                                            }
                                                                        } else {
                                                                            $(".sighMap-list").hide();
                                                                        }
                                                                    },
                                                                    error: fn_AjaxError
                                                                });*/

                                                                function setMove(lat, lng) {
                                                                    map.setLevel(4);
                                                                    map.panTo(new daum.maps.LatLng(lat, lng));
                                                                }
                                                            </script>
                                                        </div>
                                                        <div class="map-text-info">
                                                            <p>주소 : ${webdtl.roadNmAddr}</p>
                                                            <p>전화번호 : ${webdtl.rsvTelNum}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </section>
                                        <section>
                                            <div class="nav-tabs2">
                                                <div id="tabs-5" class="tabPanel"></div>
                                                <!-- //tabs-5 -->
                                                <!--1:1문의-->
                                                <div id="tabs-6" class="tabPanel"></div>
                                            </div>
                                        </section>
                                    </div>
                                </div>
                            </div>

                            <!--주변 추천 숙소-->
                            <div class="ad-recommend">
                                <div id="ad-Recommend">
                                    <div class="ad-info-title">다른 추천 숙소</div>
                                    <div class="product-slide-item">
                                        <div id="product_slideItem" class="swiper-container">
                                            <ul class="swiper-wrapper">
                                                <c:forEach var="data" items="${listDist}" varStatus="status">
                                                    <li class="swiper-slide">
                                                        <a href="javascript:fn_DetailPrdt('${data.prdtNum}', '${data.corpCd}')">
                                                            <div class="recommendPhoto">
                                                                <img src="${data.savePath}thumb/${data.saveFileNm}" loading="lazy" alt="${data.adNm }">
                                                            </div>
                                                            <div class="recommendText">
                                                                    <%--<div class="rcSub">중문관광단지의 중심!</div>--%>
                                                                <div class="rcTitle">${data.adNm }</div>
                                                                <div class="rcPrice"><fmt:formatNumber value="${data.saleAmt }" /><span class="won">원</span></div>
                                                            </div>
                                                        </a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <div id="slideItem_arrow" class="arrow-box">
                                            <div id="slideItem_next" class="swiper-button-next"></div>
                                            <div id="slideItem_prev" class="swiper-button-prev"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--20211228_예약옵션설정-->
                            <div class="option-wrap" style="display:none;"></div>
                        </div> <!-- //ad-detail -->

                    </div> <!--//Fasten-->
                </div> <!--//bgWrap-->
            </div> <!-- //new-detail -->
            <!-- //Change Contents -->

        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
</main>

<script type="text/javascript" src="<c:url value='/js/useepil.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/otoinq.js?version=${nowDate}'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/bloglink.js?version=${nowDate}'/>"></script> --%>

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>

<!--20211228_예약옵션설정-->
<script type="text/javascript" src="<c:url value='/js/adDtlCalendar.js'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/glDtlCalendar.js'/>"></script> --%>
<script type="text/javascript">

    var g_adTotalPrice=0;

    function fn_chkDate() {
        if ($("#chkSelDate").val() == '0') {
            $('#sFromDtView').focus();
            alert('날짜를 선택해주세요.');
            return false;
        } else {
            alert('객실을 선택해주세요.');
            $("#frm").submit();
            return false;
        }
    }

    /**
     *찜하기
     */
    function fn_adAddPocket() {
        var pocket = [{
            prdtNum 	: ' ',
            prdtNm 		: ' ',
            corpId 		: "<c:out value='${webdtl.corpId}'/>",
            corpNm 		: "<c:out value='${corpVO.corpNm}'/>",
            prdtDiv 	: "${Constant.ACCOMMODATION}"
        }];

        fn_AddPocket(pocket);
    }

    function fn_adAddCart(){
        <c:if test="${searchVO.sSearchYn eq 'N'}">
        return fn_chkDate();
        </c:if>

        var nCnt = 0;
        $('input[name=chkRoom]').each(function() {
            if (this.checked) {
                nCnt++;
            }
        });

        if(nCnt == 0) {
            alert("객실을 선택해주세요.");

            var offset = $(".room-option").offset();
            $('html, body').animate({scrollTop : offset.top}, 400);

            return;
        }

        var cart = [];
        $('input[name=chkRoom]').each(function() {
            if (this.checked) {
                //alert($('input[name=adPE_sFromDt]').eq(index).val());
                var sId = $(this).attr("id");

                var addAmt = eval($('#addAdultAmt' + sId).val()) + eval($('#addChildAmt' + sId).val()) + eval($('#addBabyAmt' + sId).val());
                var addAdultCnt = $('#addAdultAmt' + sId).val() / $('#adultAddAmt').val();
                var addJuniorCnt = $('#addChildAmt' + sId).val() / $('#juniorAddAmt').val();
                var addChildCnt = $('#addBabyAmt' + sId).val() / $('#childAddAmt').val();

                for (var i=0; i<$('#cntNum' + sId).text(); i++) {
                    cart.push({
                        prdtNum 	: $(this).val(),
                        prdtNm 		: $('#prdtNm' + sId).text(),
                        corpId 		: "<c:out value='${webdtl.corpId}'/>",
                        corpNm 		: "<c:out value='${webdtl.adNm }'/>",
                        prdtDivNm 	: "숙박",
                        //fromDt 		: $('input[name=adPE_sFromDt]').eq(index).val(),
                        startDt		: "<c:out value='${searchVO.sFromDt}'/>",
                        night 		: "<c:out value='${searchVO.sNights}'/>",
                        adultCnt 	: "<c:out value='${searchVO.sAdultCnt}'/>",
                        juniorCnt 	: "<c:out value='${searchVO.sChildCnt}'/>",
                        childCnt 	: "<c:out value='${searchVO.sBabyCnt}'/>",
                        adOverAmt 	: addAmt,
                        addAdultAmt : commaNum(eval($('#addAdultAmt' + sId).val())),
                        addJuniorAmt : commaNum(eval($('#addChildAmt' + sId).val())),
                        addChildAmt   : commaNum(eval($('#addBabyAmt' + sId).val())),
                        addAdultCnt : addAdultCnt,
                        addJuniorCnt : addJuniorCnt,
                        addChildCnt : addChildCnt,
                        imgPath : $('#imgPath' + sId).attr("src")
                    });
                }
            }
        });

        fn_AddCart(cart);
    }

    function fn_adAddSale(){
        <c:if test="${searchVO.sSearchYn eq 'N'}">
        return fn_chkDate();
        </c:if>

        var nCnt = 0;
        $('input[name=chkRoom]').each(function() {
            if (this.checked) {
                nCnt++;
            }
        });

        if(nCnt == 0) {
            alert("객실을 선택해주세요.");

            var offset = $(".room-option").offset();
            $('html, body').animate({scrollTop : offset.top}, 400);
            return;
        }

        var cart = [];
        $('input[name=chkRoom]').each(function() {
            if (this.checked) {
                //alert($('input[name=adPE_sFromDt]').eq(index).val());
                var sId = $(this).attr("id");
                var addAmt = eval($('#addAdultAmt' + sId).val()) + eval($('#addChildAmt' + sId).val()) + eval($('#addBabyAmt' + sId).val());
                var addAdultCnt = $('#addAdultAmt' + sId).val() / $('#adultAddAmt').val();
                var addJuniorCnt = $('#addChildAmt' + sId).val() / $('#juniorAddAmt').val();
                var addChildCnt = $('#addBabyAmt' + sId).val() / $('#childAddAmt').val();

                for (var i=0; i<$('#cntNum' + sId).text(); i++) {
                    cart.push({
                        prdtNum 	: $(this).val(),
                        prdtNm 		: $('#prdtNm' + sId).text(),
                        corpId 		: "<c:out value='${webdtl.corpId}'/>",
                        corpNm 		: "<c:out value='${webdtl.adNm }'/>",
                        prdtDivNm 	: "숙박",
                        //fromDt 		: $('input[name=adPE_sFromDt]').eq(index).val(),
                        startDt		: "<c:out value='${searchVO.sFromDt}'/>",
                        night 		: "<c:out value='${searchVO.sNights}'/>",
                        adultCnt 	: "<c:out value='${searchVO.sAdultCnt}'/>",
                        juniorCnt 	: "<c:out value='${searchVO.sChildCnt}'/>",
                        childCnt 	: "<c:out value='${searchVO.sBabyCnt}'/>",
                        adOverAmt 	: addAmt,
                        addAdultAmt : commaNum(eval($('#addAdultAmt' + sId).val())),
                        addJuniorAmt : commaNum(eval($('#addChildAmt' + sId).val())),
                        addChildAmt   : commaNum(eval($('#addBabyAmt' + sId).val())),
                        addAdultCnt : addAdultCnt,
                        addJuniorCnt : addJuniorCnt,
                        addChildCnt : addChildCnt,
                        imgPath : $('#imgPath' + sId).attr("src")
                    });
                }
            }
        });

        fn_InstantBuy(cart);
    }

    //객실수 및 인원 정보 수정
    function modify_room_person() {
        var str = /* $("#sRoomNum option:selected").val() + "객실, " +  */$('#AdultNum').text() + " 성인";
        if ($('#ChildNum').text() > 0) {
            str += ", " + $('#ChildNum').text() + " 소아";
        }
        if ($('#BabyNum').text() > 0) {
            str += ", " + $('#BabyNum').text() + " 유아";
        }
        $('#room_person_str').text(str);
    }

    // 인원수 변경 이벤트
    function chg_person(type, gubun) {
        var num = 0;
        if (type == '+') {
            num = eval($('#' + gubun + 'Num').text()) + 1;
        } else {
            num = eval($('#' + gubun + 'Num').text()) - 1;
        }

        // 최저 인원 수 - 성인 : 1, 소아&유아 : 0
        if (gubun == 'Adult') {
            if (num < 1) num = 1;
            else if (num > 30) num = 30;
        } else {
            if (num < 0) num = 0;
            else if (num > 30) num = 30;
        }

        $('#' + gubun + 'Num').text(num);
        $('input[name=s' + gubun + 'Cnt]').val(num);

        var sMen = eval($('#AdultNum').text()) + eval($('#ChildNum').text()) + eval($('#BabyNum').text());
        $('#sMen').val(sMen);

        modify_room_person();
        /*fn_dim();*/
        $(".search_btn").addClass("blinking");
        $("#adBuyBtn").attr("onclick","alert('날짜,인원 변경시 상단의 재검색버튼을 눌러주세요')");
    }

    // 객실 개수 변경
    function applyCntPrice(action, pos) {
        var cntNum = $('#cntNum' + pos).text();
        var ableRsvNum = $('#ableRsvNum' + pos).val();
        if (action == '+') {
            if (eval(cntNum) + 1 <= ableRsvNum) {
                $('#cntNum' + pos).text(eval(cntNum) + 1);
            } else {
                alert('더 이상 예약 불가합니다.');
                $('#cntNum' + pos).text(ableRsvNum);
            }
        } else if (action == '-') {
            if (eval(cntNum) - 1 >= 1) {
                $('#cntNum' + pos).text(eval(cntNum) - 1);
            } else {
                $('#cntNum' + pos).text(1);
            }
        }
        ctnAmt = eval($('#cntNum' + pos).text()) * $('#ctnAmt' + pos).val();
        disDaypriceAmt = eval($('#cntNum' + pos).text()) * $('#disDaypriceAmt' + pos).val();
        saleAmt = eval($('#saleAmt' + pos).val()) * eval($('#cntNum' + pos).text());
        nmlAmt = eval($('#nmlAmt' + pos).val()) * eval($('#cntNum' + pos).text());
        $('#disPriceAmtStr' + pos).text(commaNum(ctnAmt + disDaypriceAmt));

        $('#oriSaleAmt' + pos).text(commaNum(nmlAmt));
        $('#saleAmtStr' + pos).text(commaNum(saleAmt - ctnAmt - disDaypriceAmt ));

        accountTotAmt();
    }

    // 총 요금 산출
    function accountTotAmt() {
        var adTotal = 0;
        var ctnPrice = 0;
        var disDayprice = 0;
        var addAdultAmt = 0;
        var addChildAmt = 0;
        var addBabyAmt = 0;
        var roomTotalCnt = 0;

        $('input[name=chkRoom]').each(function() {
            if (this.checked) {
                var sId = $(this).attr("id");
                adTotal += parseInt($('#saleAmtStr' + sId).text().replace(/,/g,""))

                disDayprice += $('#disDaypriceAmt' + sId).val() > 0 ? parseInt($('#disDaypriceAmt' + sId).val()) * eval($('#cntNum' + sId).text()) : 0;
                ctnPrice += $('#ctnAmt' + sId).val() > 0 ? parseInt($('#ctnAmt' + sId).val()) * eval($('#cntNum' + sId).text()) : 0;
                addAdultAmt += eval($('#addAdultAmt' + sId).val()) * eval($('#cntNum' + sId).text());
                addChildAmt += eval($('#addChildAmt' + sId).val()) * eval($('#cntNum' + sId).text());
                addBabyAmt += eval($('#addBabyAmt' + sId).val()) * eval($('#cntNum' + sId).text());
                roomTotalCnt += Number($('#cntNum' + sId).text());
            }
        });

        var totalAmtStr = "";
        if(adTotal > 0) {
            totalAmtStr += "[${searchVO.sNights }박] ";
            totalAmtStr += commaNum(adTotal + disDayprice + ctnPrice - addAdultAmt - addChildAmt - addBabyAmt) + '원 ';
        }
        if (addAdultAmt > 0) {
            totalAmtStr += ' + ' + commaNum(addAdultAmt) + '원(성인) ';
        }
        if (addChildAmt > 0) {
            totalAmtStr += ' + ' + commaNum(addChildAmt) + '원(소아) ';
        }
        if (addBabyAmt > 0) {
            totalAmtStr += ' + ' + commaNum(addBabyAmt) + '원(유아) ';
        }

        if (disDayprice > 0 && ctnPrice > 0) {
            totalAmtStr += '<strong class="text-red">- ' + commaNum(disDayprice) + '원(당일특가) - ' + commaNum(ctnPrice) + '원(연박할인)</strong>';
        } else if (ctnPrice > 0) {
            totalAmtStr += '<strong class="text-red">- ' + commaNum(ctnPrice) + '원(연박할인)</strong>';
        } else if (disDayprice > 0) {
            totalAmtStr += '<strong class="text-red">- ' + commaNum(disDayprice) + '원(당일특가)</strong>';
        }
        $('#adTotalStr').html(totalAmtStr);
        $('#adTotalPrice').text(commaNum(adTotal));
        $("#lpointSavePoint").html(commaNum(parseInt((adTotal * "${Constant.LPOINT_SAVE_PERCENT}" / 100) / 10) * 10) + "원");

        if(roomTotalCnt) {
            $("#totalRoomCnt").html("총 상품금액" + "(" + roomTotalCnt + "객실" + ")");
        } else {
            $("#totalRoomCnt").html("총 상품금액");
        }
        // 쿠폰리스트 체크
        fn_chkCouponList();
    }

    function fn_DetailPrdt(prdtNum, corpCd){
        $("#sPrdtNum").val(prdtNum);
        $("#prdtNum").val(prdtNum);
        $('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
        $('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
        document.frm.target = "_blank";
        if(corpCd == "${Constant.ACCOMMODATION}"){
            document.frm.action = "<c:url value='/web/ad/detailPrdt.do'/>";
            document.frm.submit();
        }else{
            document.frm.action = "<c:url value='/web/sp/detailPrdt.do'/>";
            document.frm.submit();
        }
    }

    //쿠폰 리스트 체크
    function fn_chkCouponList() {
        var copNum = 0;
        var amt = eval(fn_replaceAll($("#adTotalPrice").text(), ",", ""));

        $(".useCouponList").each(function() {
            if (amt < $(this).attr('minAmt')) {
                $("#cpTitle" + $(this).attr("showKey")).addClass("hide");
                $("#useCouponNm_" + $(this).attr("showKey")).addClass("hide");
                $("#useCouponAmt_" + $(this).attr("showKey")).addClass("hide");
            } else {
                copNum++;

                $("#cpTitle" + $(this).attr("showKey")).removeClass("hide");
                $("#useCouponNm_" + $(this).attr("showKey")).removeClass("hide");
                $("#useCouponAmt_" + $(this).attr("showKey")).removeClass("hide");
            }
        });

        if (copNum == 0) {
            $("#useAbleCoupon").addClass("hide");
        } else {
            $("#useAbleCoupon").removeClass("hide");
        }
    }

    // 쿠폰 받기
    function fn_couponDownload(cpId, idx) {
        var parameters = "cpId=" + cpId;

        $.ajax({
            url:"<c:url value='/mw/couponDownload.ajax'/>",
            data:parameters,
            success:function(data){
                if(data.result == "success") {
                    $("#btnCoupon" + idx).addClass("hide");
                    $("#cpTitle" + idx).html("할인쿠폰");

                    alert("<spring:message code='success.coupon.download'/>");
                } else {
                    alert("<spring:message code='fail.coupon.download'/>");
                }
            },
            error: fn_AjaxError
        })
    }

    // 쿠폰코드 등록
    function goCouponCode() {
        if(confirm("<spring:message code='confirm.coupon.code' />")){
            location.href = "<c:url value='/web/mypage/couponList.do' />";
        }
    }

    /** css상에 display=none일경우 Swiper가 초기화 되지않음 */
    var topGallery = false;
    function openTopGallery(){
        if($('#detail_slider .swiper-slide').length > 1 && topGallery == false) {
            var swiper = new Swiper('#detail_slider', {
                pagination: '#detail_paging',
                paginationType: "fraction",
                nextButton: '#detail_next',
                prevButton: '#detail_prev',
                loop: true,
                observer: true,
                observeParents: true
            });
        }
        topGallery = true;
    }

    $(document).ready(function(){
        var loopCnt = "${fn:length(prdtList)}";
        for(var i = 1; i<=loopCnt; ++i ){
            var swiper = new Swiper("#detail_slider"+i, {
                pagination: "#detail_paging"+i,
                paginationType: "fraction",
                nextButton: "#detail_next"+i,
                prevButton: "#detail_prev"+i,
                observer: true,
                observeParents: true
            });
        }

        $(document).mouseup(function (e){
            var container = $("#hotel_count");
            if( container.has(e.target).length === 0){
                container.css('display','none');
            }
        });
        //-이용 후기 관련 설정 --------------------
        g_UE_corpId		="${webdtl.corpId}";					//업체 코드 - 넣어야함
        g_UE_prdtnum 	="${searchVO.sPrdtNum}";					//상품번호  - 넣어야함
        g_UE_corpCd 	="${Constant.ACCOMMODATION}";	//숙박/랜트.... - 페이지에 고정
        g_UE_getContextPath = "${pageContext.request.contextPath}";

        //이용후기 상단 평점/후기수, 탭 숫자 변경(서비스로 사용해도됨)
        //fn_useepilInitUI();
        fn_useepilInitUI("${webdtl.corpId}", "${searchVO.sPrdtNum}", "${Constant.ACCOMMODATION}");
        // * 서비스 사용시 GPAANLSVO ossUesepliService.selectByGpaanls(GPAANLSVO) 사용

        //이용후기 리스트 뿌리기 -> 해당 탭버튼 눌렀을때 호출하면됨
        //fn_useepilList();
        fn_useepilList("${webdtl.corpId}", "${searchVO.sPrdtNum}", "${Constant.ACCOMMODATION}");
        //---------------------------------------------------

        //-1:1문의 관련 설정 --------------------------------
        g_Oto_corpId	="${webdtl.corpId}";					//업체 코드 - 넣어야함
        g_Oto_prdtnum 	="${searchVO.sPrdtNum}";					//상품번호  - 넣어야함
        g_Oto_corpCd 	="${Constant.ACCOMMODATION}";	//숙박/랜트.... - 페이지에 고정
        g_Oto_getContextPath = "${pageContext.request.contextPath}";

        //1:1문의 탭에 숫자 변경 (서비스로 사용해도됨)
        //fn_otoinqInitUI();
        fn_otoinqInitUI("${webdtl.corpId}", "${searchVO.sPrdtNum}", "${Constant.ACCOMMODATION}", "<c:out value='${webdtl.rsvTelNum }'/>");
        // * 서비스 사용시 int ossOtoinqService.getCntOtoinqCnt(OTOINQSVO); 사용

        //1:1문의 리스트 뿌리기 -> 해당 탭버튼 눌렀을때 호출하면됨
        //fn_otoinqList();
        fn_otoinqList("${webdtl.corpId}", "${searchVO.sPrdtNum}", "${Constant.ACCOMMODATION}", "<c:out value='${webdtl.rsvTelNum }'/>");
        //---------------------------------------------------

        // 검색 시 예약 가능 객실 체크
        <c:if test="${searchVO.sSearchYn eq 'Y'}">
        <c:set var="rsvAbleNum" value="0" />

        <c:forEach var="result" items="${prdtList}" varStatus="status">
        <c:if test="${result.memExcdAbleYn == 'Y'}">
        <c:set var="maxMem" value="${result.maxiMem }"/>
        </c:if>
        <c:if test="${result.memExcdAbleYn != 'Y'}">
        <c:set var="maxMem" value="${result.stdMem }"/>
        </c:if>
        <c:if test="${(not empty result.saleAmt ) and (maxMem >= (searchVO.sAdultCnt + searchVO.sChildCnt + searchVO.sBabyCnt)) }">
        <c:set var="rsvAbleNum" value="${rsvAbleNum + 1 }" />
        </c:if>
        </c:forEach>
        <c:if test="${rsvAbleNum eq 0}">
        $(".money").text("선택된 날짜에 예약가능한 객실이 없습니다.");
        $(".purchase-btn-group").hide();
        /*if (confirm('예약가능 룸이 없습니다.\n예약가능한 리스트로 이동하시겠습니까?')) {
            document.frm.action = "<c:url value='/web/stay/jeju.do'/>";
		document.frm.submit();
	}*/
        </c:if>
        </c:if>

        g_AD_getContextPath = "${pageContext.request.contextPath}";

        $("#sFromDtView").datepicker({
            showOn: "both",
            buttonImage: "/images/web/icon/calendar_icon01.gif",
            buttonImageOnly: true,
            showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
            numberOfMonths: [ 1, 2 ],									//여러개월 달력 표시
            stepMonths: 2, 												//좌우 선택시 이동할 개월 수
            dateFormat: "yy-mm-dd",
            minDate: "${SVR_TODAY}",
            maxDate: '+12m',
            onSelect : function(selectedDate) {
                var fromDt = new Date(selectedDate);

                //$("#sFromDt").val("" + fromDt.getFullYear() + (fromDt.getMonth() + 1) + fromDt.getDate());
                $('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));

                fromDt.setDate(fromDt.getDate() + 1);
                selectedDate = fromDt.getFullYear() + "-" + (fromDt.getMonth() + 1) + "-" + fromDt.getDate();
                $("#sToDtView").datepicker("option", "minDate", selectedDate);

                $('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));

                fromDt.setDate(fromDt.getDate() - 1);
                var toDt = new Date($("#sToDtView").val());
                var nightNum = (toDt.getTime() - fromDt.getTime()) / (3600 * 1000 * 24);
                if (nightNum < 1)
                    nightNum = 1;

                $("#sNights").val(nightNum);
                $("#chkSelDate").val(1);
                /*fn_dim();*/
                $(".search_btn").addClass("blinking");
                $("#adBuyBtn").attr("onclick","alert('날짜,인원 변경시 상단의 재검색버튼을 눌러주세요')");
            }
        });

        $("#sToDtView").datepicker({
            showOn: "both",
            buttonImage: "/images/web/icon/calendar_icon01.gif",
            buttonImageOnly: true,
            showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
            numberOfMonths: [ 1, 2 ],									//여러개월 달력 표시
            stepMonths: 2, 												//좌우 선택시 이동할 개월 수
            dateFormat: "yy-mm-dd",
            minDate: "${SVR_TODAY}",
            maxDate: '+12m',
            onSelect : function(selectedDate) {
                var fromDt = new Date($("#sFromDtView").val());
                var toDt = new Date(selectedDate);

                $("#sToDtView").datepicker("option", "minDate", selectedDate);

                $('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));

                var nightNum = (toDt.getTime() - fromDt.getTime()) / (3600 * 1000 * 24);
                if (nightNum < 1) {
                    nightNum = 1;
                }
                $("#sNights").val(nightNum);
                $("#chkSelDate").val(1);
                /*fn_dim();*/
                $(".search_btn").addClass("blinking");
                $("#adBuyBtn").attr("onclick","alert('날짜,인원 변경시 상단의 재검색버튼을 눌러주세요')");
            }
        });

        if($('#product_slideItem .swiper-slide').length > 1) {
            var swiper = new Swiper('#product_slideItem', {
                slidesPerView: 4,
                spaceBetween: 10,
                pagination: '#slideItem_paging',
                nextButton: '#slideItem_next',
                prevButton: '#slideItem_prev',
                loop: true
            });
        }
        accountTotAmt();

        $(window).scroll(function(event) {
            if($(".ad-detail-info").offset().top < $(window).scrollTop() && ($(document).height() - $(".ad-recommend").offset().top) - ($(".ad-recommend").offset().top - $(window).scrollTop()) < 260  ){
                $(".ad-filter-area").css("position","fixed");
                $(".ad-filter-area").css("top","10px");
            }else if(($(document).height() - $(".ad-recommend").offset().top) - ($(".ad-recommend").offset().top - $(window).scrollTop()) > 0){
                $(".ad-filter-area").css("position","absolute");
                $(".ad-filter-area").css("top",$(".ad-detail-area").height()-$(".ad-filter-area").height()-20+"px")
            }else{
                $(".ad-filter-area").css("position","absolute");
                $(".ad-filter-area").css("top","10px");
            }
        });
        /** 부대시설 없을때 hide*/
        if($(".FavFeatures__List li").length < 1){
            $(".FavFeatures__List").hide();
        }
        /** 예약가능한 룸이 없을때 hide*/
        if($(".room_info .room").length < 1){
            $(".room_info").hide();
        }

        if($("._adDetail").height() > 75){
            $(".adDetail .show-more").css("display","block");
            $("._adDetail").css("height","55px");
        }
        $("span.show-more").click(function(){
            if($("span.show-more").text() == "닫기"){
                $("span.show-more").text("더 보기")
                $("._adDetail").css("height","55px");
            }else{
                $("span.show-more").text("닫기")
                $("._adDetail").css("height","");
            }
        })
    });

    function openSlide(status){
        if(status){
            $('#detail_slider' + status ).addClass('active');
        }else{
            openTopGallery();
            $('#detail_slider').addClass('active');
        }
    }

    function fn_dim(){
        $(".boxBackdrop").remove();
        $(".ad-filter-area").addClass("ad-filter-Backdrop");
        $(".ad-filter-area").after("<div class='boxBackdrop'></div>");
        $(".boxBackdrop").click(function(){
            $(".boxBackdrop").remove();
            document.frm.submit();
        });
    }

    <!--20211228_예약옵션설정-->
    function fn_ShowLayer(sPrdtNum) {

        //parameters setting
        const sFromDt = '${searchVO.sFromDt}';
        const sNights = '${searchVO.sNights}';
        const sAdultCnt = '${searchVO.sAdultCnt}';
        const sChildCnt = '${searchVO.sChildCnt}';
        const sBabyCnt = '${searchVO.sBabyCnt}';

        const parameters = "sPrdtNum=" + sPrdtNum + "&sFromDt=" + sFromDt + "&sNights=" + sNights + "&sAdultCnt=" + sAdultCnt + "&sChildCnt=" + sChildCnt + "&sBabyCnt=" + sBabyCnt;
        $.ajax({
            type      : "post",
            url       : "<c:url value='/web/adRoomOptionLayer.ajax'/>",
            data      : parameters,
            success   : function (data) {
                $('.option-wrap').html(data);

                //옵션 닫기
                $('.option-close').click(function () {
                    close_popup($('.option-wrap'));
                    $('.option-wrap').html("");
                });

                show_popup($('.option-wrap'));
            },
            error     : fn_AjaxError
        });
    }
</script>
<%--<jsp:include page="/web/right.do"></jsp:include>--%>
<jsp:include page="/web/foot.do"></jsp:include>
</body>
</html>