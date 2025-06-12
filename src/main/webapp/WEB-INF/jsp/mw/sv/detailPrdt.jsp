<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<c:if test="${fn:length(prdtImg) == 0}">
    <c:set value="" var="seoImage"/>
</c:if>
<c:if test="${fn:length(prdtImg) != 0}">
    <c:set value="${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}" var="seoImage"/>
</c:if>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?prdtNum=${prdtInfo.prdtNum}"/>
<c:set var="imgUrl" value="${pageContext.request.scheme}://${strServerName}${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}"/>

<jsp:include page="/mw/includeJs.do">
    <jsp:param name="title" value="${prdtInfo.prdtNm} - 제주도 공공플랫폼 탐나오"/>
    <jsp:param name="description" value="${prdtInfo.prdtInf}. 탐나오는 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 안전한 구매가 가능합니다."/>
    <jsp:param name="keywordsLinkNum" value="${prdtInfo.prdtNum}"/>
    <jsp:param name="keywordAdd1" value="${prdtInfo.prdtNm}"/>
    <jsp:param name="imagePath" value="${seoImage}"/>
</jsp:include>
<meta property="og:title" content="<c:out value='${prdtInfo.prdtNm}' />"/>
<meta property="og:url" content="<c:out value='${strUrl}' />" />
<meta property="og:description" content="<c:out value='${prdtInfo.prdtNm}'/> - <c:out value='${prdtInfo.prdtInf}'/>" />
<c:if test="${fn:length(prdtImg) != 0}">
<meta property="og:image" content="<c:out value='${imgUrl}' />" />
</c:if>
<meta property="fb:app_id" content="182637518742030" />

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Light.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style2.css?version=${nowDate}'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/swiper.css?version=${nowDate}'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}' />"> --%>

<c:if test="${not empty prdtInfo.adMov}">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/lite-yt-embed.css?version=${nowDate}'/>" />
<script type="text/javascript" src="<c:url value='/js/lite-yt-embed.js?version=${nowDate}'/>"></script>
</c:if>
<link rel="canonical" href="https://www.tamnao.com/web/sv/detailPrdt.do?prdtNum=${prdtInfo.prdtNum}">

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>
<c:if test="${gpaVO.gpaCnt ne null}">
<script type="application/ld+json">
{
	"@context": "https://schema.org/",
    "@type": "Product",
    "name": "${prdtInfo.prdtNm}",
	"image": [
		"${imgUrl}"
	],
	"description": "${prdtInfo.prdtInf}",
	"sku": "${prdtInfo.prdtNum}",
	"brand": {
    	"@type": "Brand",
    	"name": "탐나오"
  	},
	"aggregateRating": {
        "@type": "AggregateRating",
        "ratingValue": ${gpaVO.gpaAvg eq null ? 0 : gpaVO.gpaAvg},
        "reviewCount": ${gpaVO.gpaCnt eq null ? 0 : gpaVO.gpaCnt},
		"worstRating":0,
        "bestRating":5
	},
	"offers": {
        "@type": "Offer",
        "url": "${strUrl}",
        "priceCurrency": "KRW",
        "price": ${prdtInfo.saleAmt}
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
</c:if>
</head>
<body>
<div id="wrap">
    <!-- 헤더 s -->
    <header id="header">
        <jsp:include page="/mw/head.do" />
    </header>
    <!-- 헤더 e -->

    <!-- 콘텐츠 s -->
    <main id="main">
        <!--//change contents-->
        <div class="mw-detail-area">
            <section class="detail-product-area">
                <h2 class="sec-caption">상품 정보</h2>
                <div class="detail-slider">
                    <div id="detail_slider" class="swiper-container">
                        <div class="swiper-wrapper">
                            <c:forEach items="${prdtImg}" var="imgInfo" varStatus="status">
                                <div class="swiper-slide">
                                	<c:choose>
										<c:when test="${status.count < 2}">
											<img src="${imgInfo.savePath}thumb/${imgInfo.saveFileNm}" alt="${prdtInfo.prdtNm}">		
										</c:when>
										<c:otherwise>
											<img src="${imgInfo.savePath}thumb/${imgInfo.saveFileNm}" loading="lazy" alt="${prdtInfo.prdtNm}">
										</c:otherwise>
									</c:choose>	
                                </div>	
                            </c:forEach>
                        </div>
                        <c:if test="${fn:length(prdtImg) > 1}">
                            <div id="detail_paging" class="swiper-pagination"></div>
                        </c:if>
                    </div>
                </div> <!-- //detail-slider -->
                <div class="product-info">
                    <div class="title-area">
                        <div class="memo"><c:out value="${prdtInfo.prdtInf}" /></div>
                        <div class="title"><c:out value='${prdtInfo.prdtNm}'/></div>
                        <div class="grade-area">
                            <div class="score-area">
                                <span class="score" id="ind_grade">평점 <strong class="text-red">3</strong>/5</span>
                                <span class="icon" id="useepil_uiTopHearts"></span>
                            </div>
                            <div class="bxLabel">
                                <c:if test="${prdtInfo.eventCnt > 0}">
                                    <span class="main_label eventblue">이벤트</span>
                                </c:if>
                                <c:if test="${prdtInfo.couponCnt > 0}">
                                    <span class="main_label pink">할인쿠폰</span>
                                </c:if>
                                <c:if test="${prdtInfo.superbSvYn eq 'Y'}">
                                    <span class="main_label back-purple">공모전 수상작</span>
                                </c:if>
                                <c:if test="${prdtInfo.superbCorpYn == 'Y' }">
                                    <span class="main_label back-red">우수관광사업체</span>
                                </c:if>
                                <c:if test="${prdtInfo.tamnacardYn eq 'Y'}">
                                    <span class="main_label yellow">탐나는전</span>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="price-area">
                        <div class="price">
                            <strong><fmt:formatNumber value='${prdtInfo.saleAmt}' type='number' />원~</strong>
                            <c:if test="${prdtInfo.nmlAmt ne prdtInfo.saleAmt}">
                                <del><fmt:formatNumber value='${prdtInfo.nmlAmt}' type='number' />원</del>
                            </c:if>
                        </div>
                    </div>
                    <div class="memo-area">
                        <div class="origin-info">
                            <span class="inline"><span class="info-bold">생산자 </span><c:out value="${prdtInfo.prdc}" /></span>
                        </div>
                        <div class="fee-info">
                            <c:if test="${prdtInfo.deliveryYn == 'Y'}">
                                <p><span class="info-bold">배송비 </span>
                                    <c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_DLV}">
                                        <c:if test="${prdtInfo.dlvAmt eq prdtInfo.inDlvAmt}">
                                            <fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원
                                        </c:if>
                                        <c:if test="${prdtInfo.dlvAmt ne prdtInfo.inDlvAmt}">
                                            도외(<fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원), 도내(<fmt:formatNumber>${prdtInfo.inDlvAmt}</fmt:formatNumber>원)
                                        </c:if>
                                    </c:if>
                                    <c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_APL}">
                                        <c:if test="${prdtInfo.dlvAmt eq prdtInfo.inDlvAmt}">
                                            <fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원
                                        </c:if>
                                        <c:if test="${prdtInfo.dlvAmt ne prdtInfo.inDlvAmt}">
                                            도외(<fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원), 도내(<fmt:formatNumber>${prdtInfo.inDlvAmt}</fmt:formatNumber>원),
                                        </c:if>
                                        (<fmt:formatNumber>${corpDlvAmtVO.aplAmt}</fmt:formatNumber>원 이상 구매시 무료)
                                    </c:if>
                                    <c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_MAXI}">
                                        ${prdtInfo.maxiBuyNum}개당 <fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원
                                    </c:if>
                                    <c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_FREE}">
                                        무료
                                    </c:if>
                                </p>
                            </c:if>
                            <c:if test="${prdtInfo.directRecvYn == 'Y'}">
                                <p><span class="info-bold">직접수령 </span> 매장에 방문하여 주문 상품을 수령 <button class="comm-btn black sm" onclick="javascript:fn_showMap();">위치</button></p>
                            </c:if>
                        </div>
                        <div class="map-info-area" style="display:none;">
                            <div class="map-area" id="sighMap">
                            </div>
                        </div>
                    </div>

                </div> <!-- //product-info -->

                <div class="point-area">
<%--                    <c:if test="${not empty loginVO and fn:length(couponList) > 0}">
                        <div class="col2-area" id="useAbleCoupon">
                            <div class="title text-red">할인쿠폰</div>
                            <c:forEach var="coupon" items="${couponList}" varStatus="status">
                                <c:set var="userCp" value="${userCpMap[coupon.cpId]}" />

                                <div class="row useCouponList" minAmt="${coupon.buyMiniAmt}">
                                    <span class="col1">
                                        <div class="coupon-title-wrap">
                                            <div class="coupon-title">
                                                ${coupon.cpNm}
                                            </div>
                                            <span class="text-gray"><fmt:formatNumber>${coupon.buyMiniAmt}</fmt:formatNumber>원 이상 구매시 사용 가능</span>
                                        </div>
                                    </span>
                                    <span class="col2">
                                        <c:if test="${coupon.disDiv eq Constant.CP_DIS_DIV_PRICE}">
                                            <fmt:formatNumber value="${coupon.disAmt}"/>원
                                        </c:if>
                                        <c:if test="${coupon.disDiv eq Constant.CP_DIS_DIV_RATE}">
                                            ${coupon.disPct}%
                                        </c:if>
                                        <c:if test="${coupon.disDiv eq Constant.CP_DIS_DIV_FREE}">
                                            무료
                                        </c:if>
                                    </span>
                                    <c:if test="${not empty userCp}">
                                        <c:if test="${empty userCp.useYn}">
                                            <button class="comm-btn red sm" id="btnCoupon${status.count}" onclick="javascript:goCouponCode();">코드등록</button>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${empty userCp}">
                                        <c:if test="${empty coupon.cpCode}">
                                            <button class="comm-btn red sm" id="btnCoupon${status.count}" onclick="javascript:fn_couponDownload('${coupon.cpId}', ${status.count});">쿠폰받기</button>
                                        </c:if>
                                        <c:if test="${not empty coupon.cpCode}">
                                            <button class="comm-btn red sm" id="btnCoupon${status.count}" onclick="javascript:goCouponCode();">코드등록</button>
                                        </c:if>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>--%>
                    <div class="col2-area line">
                        <div class="row">
                            <span class="col1">L.POINT적립금</span>
                            <span class="col2" id="lpointSavePoint">0원</span>
                        </div>
                    </div>
                </div>
            </section> <!-- //detail-product-area -->

            <div class="nav-tabs2">
                <div class="menu-wrap">
                    <ul id="scroll_tabs" class="nav-menu">
                        <li class="active"><a href="#tabs-info">상품설명</a></li>
                        <c:if test="${not empty prdtInfo.cancelGuide}">
                        	<li><a href="#tabs-cancel">취소/환불</a></li>
                        </c:if>
                        <li><a href="#tabs-review">이용후기</a></li>
                        <li><a href="#tabs-counsel">1:1문의</a></li>
                    </ul>
                </div>

                <div id="tabs-info" class="tabPanel">
                    <c:if test="${fn:length(prmtList) > 0 }">
                        <!-- 프로모션 추가 -->
                        <c:forEach items="${prmtList }" var="prmt">
                            <div class="promotion-detail">
                                <c:if test="${not empty fn:trim(prmt.dtlImg)}">
                                    <div class="photo">
                                        <img src='<c:url value="${prmt.dtlImg}" />' alt="${prmt.prmtNm}">
                                    </div>
                                </c:if>
                                <div class="text-area">
                                    <dl>
                                        <dt class="title">${prmt.prmtNm}</dt>
                                        <dd>
                                            <ul>
                                                <li class="text-right">
                                                    <fmt:parseDate value="${prmt.startDt}" var="startDt" pattern="yyyyMMdd" />
                                                    <fmt:parseDate value="${prmt.endDt}" var="endDt" pattern="yyyyMMdd" />
                                                    <span><fmt:formatDate value="${startDt}" pattern="yyyy년 MM월 dd일" /> ~ <fmt:formatDate value="${endDt}" pattern="yyyy년 MM월 dd일" /></span>
                                                </li>
                                                <c:if test="${not empty prmt.prmtExp}">
                                                    <li>
                                                        <span style="white-space:pre-wrap;"><c:out value="${prmt.prmtExp}" escapeXml="false" /></span>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </dd>
                                    </dl>
                                </div>
                            </div> <!-- //promotion-detail -->
                        </c:forEach>
                        <!-- //프로모션 추가 -->
                    </c:if>

                    <div class="image-groupA">
                        <div class="type-body1 side-padding">
                            <c:out value="${prdtInfo.prdtExp}" escapeXml="false" />
                        </div>
                        <c:if test="${(fn:length(dtlImg) == 0) && (not empty prdtInfo.hdlPrct) && (not empty prdtInfo.prdtExp)}">
                            <p class="no-content">상세 상품 설명이 없습니다.</p>
                        </c:if>
                        <div class="photo">
                            <c:forEach items="${dtlImg}" var="dtlImg">
                                <img src="${dtlImg.savePath}${dtlImg.saveFileNm}" loading="lazy" alt="${prdtInfo.prdtNm} 상세">
                            </c:forEach>
                        </div>
                        <c:if test="${not empty prdtInfo.adMov}">
                        	<div class="video-area youtube">
                                <lite-youtube videoid="${fn:replace(prdtInfo.adMov, 'https://www.youtube.com/embed/', '')}" playlabel="${prdtInfo.prdtNm} 유튜브영상"></lite-youtube>
                            </div>
                        	<%--
                            <div class="video-area youtube">
                                <iframe title="${prdtInfo.prdtNm} 유튜브영상" width="100%" height="200" src="${prdtInfo.adMov}" frameborder="0" allowfullscreen></iframe>
                            </div>
                            --%>
                        </c:if>
                    </div>
                </div> <!-- //tabs-info -->

                <c:if test="${(not empty prdtInfo.org) or (not empty prdtInfo.dlvGuide) or (not empty prdtInfo.cancelGuide) or (not empty prdtInfo.tkbkGuide)}">
                    <div id="tabs-cancel" class="tabPanel">
                        <div class="text-groupA">
                            <dl>
                                <dt class="title-type3">원산지</dt>
                                <dd class="type-body1">
                                    <c:out value="${prdtInfo.org}" escapeXml="false" />
                                </dd>
                            </dl>
                            <c:if test="${not empty prdtInfo.hdlPrct}">
                                <dl>
                                    <dt class="title-type3">취급주의사항</dt>
                                    <dd class="type-body1">
                                        <c:out value="${prdtInfo.hdlPrct}" escapeXml="false" />
                                    </dd>
                                </dl>
                            </c:if>
                            <c:if test="${not empty prdtInfo.dlvGuide}">
                                <dl>
                                    <dt class="title-type3">배송안내</dt>
                                    <dd class="type-body1">
                                        <c:out value="${prdtInfo.dlvGuide}" escapeXml="false" />
                                    </dd>
                                </dl>
                            </c:if>
                            <c:if test="${not empty prdtInfo.cancelGuide}">
                                <dl>
                                    <dt class="title-type3">취소안내</dt>
                                    <dd class="type-body1">
                                        <c:out value="${prdtInfo.cancelGuide}" escapeXml="false" />
                                    </dd>
                                </dl>
                            </c:if>
                            <c:if test="${not empty prdtInfo.tkbkGuide}">
                                <dl>
                                    <dt class="title-type3">교환/반품안내</dt>
                                    <dd class="type-body1">
                                        <c:out value="${prdtInfo.tkbkGuide}" escapeXml="false" />
                                    </dd>
                                </dl>
                            </c:if>
                        </div> <!-- //text-groupA -->
                    </div> <!-- //tabs-cancel -->
                </c:if>

                <!-- 이용후기 -->
                <div id="tabs-review" class="tabPanel">
                    <div class="text-groupA">
                        <!-- 기존코드 동일 -->
                        <div id="review" class="tab-con con-review">
                        </div> <!-- //#review -->
                    </div>
                </div> <!-- //tabs-review -->

                <!-- 1:1문의 -->
                <div id="tabs-counsel" class="tabPanel">
                    <div class="text-groupA">
                        <!-- 기존코드 동일 -->
                        <div id="counsel" class="tab-con con-counsel">
                        </div> <!-- //#counsel -->
                    </div>
                </div> <!-- //tabs-counsel -->
            </div>

            <div class="text-groupA">
                <dl>
                    <dt class="title-type3">판매처 정보</dt>
                    <dd class="float">
                        <c:if test="${prdtInfo.superbCorpYn eq 'Y'}">
                            <div class="l-area icon">
                                <img class="speciality" src="/images/web/icon/excellence_02.jpg" loading="lazy" alt="우수관광사업체">
                            </div>
                        </c:if>
                        <c:if test="${not empty prdtInfo.adtmImg}">
                            <div class="l-area icon">
                                <img class="store" src="${prdtInfo.adtmImg}" loading="lazy" alt="${prdtInfo.shopNm} ci">
                            </div>
                        </c:if>
                        <div class="r-area">
                            <div class="type-body1">
                                상호 : <c:out value="${prdtInfo.shopNm}" /><br>
                                주소 : <c:out value="${corpInfo.roadNmAddr}"/> <c:out value="${corpInfo.dtlAddr}"/><br>
                                전화번호 : <a href="tel:<c:out value="${prdtInfo.rsvTelNum}"/>"><c:out value="${prdtInfo.rsvTelNum}"/></a>
                            </div>
                        </div>
                    </dd>
                </dl>
            </div> <!-- //text-groupA -->

            <c:if test="${fn:length(otherProductList) > 1 }">
                <section class="recommend-product">
                    <h2 class="sec-caption">추천 상품</h2>

                    <div class="recommend-group">
                        <div class="title-side-area">
                            <div class="l-area">
                                <h3 class="title-type2">묶음 배송 가능한 상품</h3>
                            </div>
                            <div class="r-area text">
                                <a href="<c:url value='/mw/sv/corpPrdt.do?sCorpId=${corpInfo.corpId}&sPrdc=${prdtInfo.prdc}'/>">전체보기</a>
                            </div>
                        </div>

                        <div class="promotion-content">
                            <div id="promotion_product" class="swiper-container">
                                <ul class="swiper-wrapper">
                                    <c:forEach items="${otherProductList}" var="product">
                                        <li class="swiper-slide">
                                            <div class="photo">
                                                <a href="<c:url value='/mw/sv/detailPrdt.do?prdtNum=${product.prdtNum}'/>">
                                                    <img class="product" src="${product.savePath}thumb/${product.saveFileNm}" loading="lazy" alt="${product.prdtNm }">
                                                </a>
                                            </div>
                                            <div class="text">
                                                <div class="title"><c:out value='${product.prdtNm }'/></div>
                                                <div class="info">
                                                    <dl>
                                                        <dt class="text-red">탐나오가</dt>
                                                        <dd>
                                                            <div class="price">
                                                                <del><fmt:formatNumber value='${product.nmlAmt}' type='number' />원</del>
                                                                <strong><fmt:formatNumber value='${product.saleAmt}' type='number' />원~</strong>
                                                            </div>
                                                        </dd>
                                                    </dl>
                                                    <div class="like">
                                                        <c:if test="${not empty pocketMap[product.prdtNum] }">
                                                            <%-- <a href="javascript:void(0)"> --%>
                                                            <a>
                                                                <img src="/images/mw/icon/product_like_on.png" alt="찜하기">
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${empty pocketMap[product.prdtNum] }">
                                                            <%-- <a href="javascript:void(0)" id="pocket${product.prdtNum }" onclick="fn_listAddPocket('${Constant.SV}', '${product.corpId }', '${product.prdtNum }')"> --%>
                                                            <a id="pocket${product.prdtNum }" onclick="fn_listAddPocket('${Constant.SV}', '${product.corpId }', '${product.prdtNum }')">
                                                                <img src="/images/mw/icon/product_like_off.png" alt="찜하기">
                                                            </a>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div> <!-- //recommend-group -->
                </section> <!-- //recommend-product -->
            </c:if>

            <!-- 구매하기 -->
            <div class="purchase-area">
                <div class="basic">
                    <div class="icon-area">
                        <%-- <a href="javascript:void(0)" onclick="itemSingleShow('#sns_popup');"> --%>
                        <a id="sv-sns-share" class="sns-share">
                            <img src="/images/mw/icon/sns.png" alt="sns">
                            <span>공유하기</span>
                        </a>
                     <%--   <c:if test="${pocketCnt eq 0 }">
                            &lt;%&ndash; <a href="javascript:void(0)" onclick="javascript:fn_SvAddPocket();" id="pocketBtnId"> &ndash;%&gt;
                            <a onclick="javascript:fn_SvAddPocket();" id="pocketBtnId">
                                <img src="/images/mw/icon/product_like2_off.png" alt="찜하기">
                            </a>
                        </c:if>
                        <c:if test="${pocketCnt ne 0 }">
                            &lt;%&ndash; <a href="javascript:void(0)"> &ndash;%&gt;
                            <a>
                                <img src="/images/mw/icon/product_like2_on.png" alt="찜하기">
                            </a>
                        </c:if>--%>
                    </div>
                    <c:if test="${chkPointBuyAble eq 'Y'}">
                        <button type="button" class="gobuy" onclick="itemSingleShow('#purchase_popup');">구매하기</button>
                    </c:if>
                    <c:if test="${chkPointBuyAble ne 'Y'}">
                        <!-- 0217 구매불가 -->
                        <button type="button" class="gobuy change">구매불가</button>
                    </c:if>
                </div>

                <div id="purchase_popup" class="purchase-popup">
                    <button type="button" class="close" onclick="itemSingleHide('#purchase_popup');">
                        <img src="/images/mw/icon/close/popup-close.png" loading="lazy" alt="닫기">
                    </button>

                    <div class="scroll-area">
                        <div class="purchase-option">
                            <div class="select-area">
                                <dl class="view-select comm-select comm-select1">
                                    <dt title="상품 선택">1. 상품을 선택하세요</dt>
                                    <dd class="in" style="display:none">
                                        <ul class="select-list-option"  id="firstOptionList"></ul>
                                    </dd>
                                </dl>
                                <form id="calendarForm">
                                    <input type="hidden" id="saleStartDt" name="saleStartDt" value="${prdtInfo.saleStartDt }" />
                                    <input type="hidden" id="saleEndDt" name="saleEndDt" value="${prdtInfo.saleEndDt}" />
                                    <input type="hidden" id="svDivSn" name="svDivSn">
                                </form>
                                <dl class="view-select comm-select comm-select3">
                                    <dt title="옵션 선택">2. 옵션을 선택하세요</dt>
                                    <dd class="in in2" style="display:none">
                                        <ul class="select-list-option"  id="secondOptionList"></ul>
                                    </dd>
                                </dl>
                                <c:if test="${fn:length(addOptList) > 0 }">
                                    <dl class="view-select comm-select comm-select4">
                                        <dt>3. 추가옵션을 선택하세요</dt>
                                        <dd class="in in2" style="display:none">
                                            <ul class="select-list-option"  id="addOptionList"></ul>
                                        </dd>
                                    </dl>
                                </c:if>
                                <div class="comm-qtyWrap"  id="selectedItemWrapper" style="display:none">
                                    <ul>
                                    </ul>
                                </div>
                                <c:if test="${prdtInfo.directRecvYn eq 'Y'}">
                                    <div class="parcel">
                                        <select class="width100" name="directRecvYn">
                                            <c:if test="${prdtInfo.deliveryYn eq 'Y'}">
                                                <option value="N">일반 택배</option>
                                            </c:if>
                                            <option value="Y">직접 수령</option>
                                        </select>
                                    </div>
                                </c:if>
                                <c:if test="${prdtInfo.directRecvYn != 'Y' }">
                                    <input type="hidden" id="directRecvYn" name="directRecvYn" value="N">
                                </c:if>
                            </div>
                            <div class="total-area">
                                <div class="text">
                                    <c:if test="${prdtInfo.deliveryYn eq 'Y'}">
                                        <p>배송비 :
                                            <c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_DLV}">
                                                <c:if test="${prdtInfo.dlvAmt eq prdtInfo.inDlvAmt}">
                                                    <fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원
                                                </c:if>
                                                <c:if test="${prdtInfo.dlvAmt ne prdtInfo.inDlvAmt}">
                                                    도외(<fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원), 도내(<fmt:formatNumber>${prdtInfo.inDlvAmt}</fmt:formatNumber>원)
                                                </c:if>
                                            </c:if>
                                            <c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_APL}">
                                                <c:if test="${prdtInfo.dlvAmt eq prdtInfo.inDlvAmt}">
                                                    <fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원
                                                </c:if>
                                                <c:if test="${prdtInfo.dlvAmt ne prdtInfo.inDlvAmt}">
                                                    도외(<fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원), 도내(<fmt:formatNumber>${prdtInfo.inDlvAmt}</fmt:formatNumber>원),
                                                </c:if>
                                                (<fmt:formatNumber>${corpDlvAmtVO.aplAmt}</fmt:formatNumber>원 이상 무료)
                                            </c:if>
                                            <c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_MAXI}">
                                                ${prdtInfo.maxiBuyNum}개당 <fmt:formatNumber>${prdtInfo.dlvAmt}</fmt:formatNumber>원
                                            </c:if>
                                            <c:if test="${prdtInfo.dlvAmtDiv eq Constant.DLV_AMT_DIV_FREE}">
                                                무료
                                            </c:if>
                                        </p>
                                    </c:if>
                                    <c:if test="${prdtInfo.directRecvYn eq 'Y' }">
                                        <p>직접수령 : 배송비 무료</p>
                                    </c:if>
                                </div>
                                <div class="total-price">총 <span id="totalProductAmt">0</span>원</div>
                            </div>
                        </div> <!-- //purchase-option -->
                    </div> <!-- //scroll-area -->

                    <div class="bottom-area">
                        <div class="purchase-btn-group">
                            <button type="button" id="cartBtn" class="gray addcart" onclick="javascript:fn_SvAddCart();">장바구니</button>
                            <button type="button" class="red gobuy" onclick="fn_SvBuy();">바로구매</button>
                        </div>
                    </div>
                </div>
            </div> <!-- //purchase-area -->

            <!-- SNS 링크 -->
            <div id="sns_popup" class="sns-popup">
                <a type="button" class="close" href="javascript:itemSingleHide('#sns_popup');" >
                    <img src="<c:url value='/images/mw/rent/close-btn.png' />" loading="lazy" alt="닫기">
                </a>
                <div class="sns-area">
                    <ul>
                        <li>
                            <a href="javascript:shareKakao('<c:out value='${prdtInfo.prdtNm}'/>', '${imgUrl}', '${strUrl}'); snsCount('${prdtInfo.prdtNum}', 'MO' , 'KAKAO');" id="kakao-link-btn">
                                <img src="/images/mw/icon/sns/kakaotalk.png" loading="lazy" alt="카카오톡">
                                <span>카카오톡</span>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:shareFacebook('${strUrl}'); snsCount('${prdtInfo.prdtNum}', 'MO', 'FACEBOOK');">
                                <img src="/images/mw/icon/sns/facebook.png" loading="lazy" alt="페이스북">
                                <span>페이스북</span>
                            </a>
                        </li>
                        <%-- 기능종료 
                        <li>
                            <a href="javascript:shareStory('${strUrl}'); snsCount('${prdtInfo.prdtNum}', 'MO' , 'KAKAO');">
                                <img src="/images/mw/icon/sns/kakaostory.png" loading="lazy" alt="카카오 스토리">
                                <span>카카오 스토리</span>
                            </a>
                        </li>
                        --%>
                        <li>
                            <a href="javascript:shareBand('${strUrl}'); snsCount('${prdtInfo.prdtNum}', 'MO' , 'BAND');">
                                <img src="/images/mw/icon/sns/band.png" loading="lazy" alt="밴드">
                                <span>밴드</span>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:shareLine('${strUrl}'); snsCount('${prdtInfo.prdtNum}', 'MO' , 'LINE');">
                                <img src="/images/mw/icon/sns/line.png" loading="lazy" alt="라인">
                                <span>라인</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div> <!-- //sns-popup -->
        </div> <!-- //mw-detail-area -->
        <!--//change contents-->
    </main>
    <!-- 콘텐츠 e -->

    <!-- 이용후기 사진 레이어 팝업 (클릭시 호출) -->
    <div class="review-gallery">
    </div>
    <!-- 콘텐츠 e -->
	
<script type="text/javascript" src="<c:url value='/js/mw_useepil.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/mw_otoinq.js?version=${nowDate}'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/slider.js?version=${nowDate}'/>"></script> --%>
<%-- <script src="<c:url value='/js/mw_swiper.js'/>"></script> --%>

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<%-- <script type="text/javascript" src="//media.line.me/js/line-button.js?v=20140411 "></script> --%>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>

<script type="text/javascript">
	var productCount = 0;			// 상품 수
	var optionCount = 0;			// 옵션 수
	var addOptionCount = 0;			// 추가옵션 수
	
	/** 추가옵션선택시 */
	function getAddOption() {
	    if($(".comm-select4 dd").css("display") == "block") {
	        $(".comm-select dd").css("display", "none");
	        return ;
	    }
	    if($("#addOptionList li").length > 0) {
	        if($("#addOptionList").css("display") == "none") {
	            $(".comm-select dd").css("display", "none");
	            $(".comm-select4 dd").css("display", "block");
	        }
	        $(".comm-select").removeClass("open");
	        $(".comm-select4").addClass("open");
	        return false;
	    }
	    var b_data = {
	        addOptNm    : "",
	        addOptAmt   : 0,
	        addOptSn    : ""
	    };
	
	    $.ajax({
	        url:"<c:url value='/web/sv/getAddOptList.ajax'/>",
	        data:"prdtNum=${prdtInfo.prdtNum}",
	        success:function(data){
	            var list = data.list;
	            var dataArr ="<li><a href='javascript:;' data-raw='' title=''><p class='product'><span>선택안함</span></p></a></li>";
	
	            $("#addOptionList").append(dataArr);
	
	            var inx = 1;
	
	            if(list != "") {
	                addOptionCount = list.length;
	
	                $(list).each(function(){
	                    dataArr = "<li>";
	                    dataArr += "<a href='javascript:;' data-raw='' title='" + this.addOptNm + "'>";
	                    dataArr += "<p class='product'><span>" + this.addOptNm + "</span></p>";
	                    dataArr += "<p class='price'>";
	
	                    if(this.addOptAmt > 0) {
	                        dataArr += commaNum(this.addOptAmt);
	                    }
	                    dataArr += "</p>";
	                    dataArr += "</a>";
	                    dataArr += "</li>";
	
	                    $("#addOptionList").append(dataArr);
	                    $("#addOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
	                    inx++;
	                });
	
	                $("#addOptionList li:eq(0)>a").attr("data-raw", JSON.stringify(b_data));
	            }
	        },
	        error: fn_AjaxError
	    });
	
	    $('.comm-select').removeClass('open');
	    //$('.comm-select4').addClass('open');	//자동open 해제
	    $('.comm-select dd').css('display', 'none');
	    //$(".comm-select4 dd").css('display', 'block');	//자동open 해제
	    $(".comm-select4 dd").css('display', 'none');
	}
	
	function getSecondOption() {
	    $("#secondOptionList").empty();
	
	    var parameters = "prdtNum=${prdtInfo.prdtNum}&svDivSn=" + $("#svDivSn").val();
	
	    $.ajax({
	        url: "<c:url value='/mw/sv/getOptionList.ajax'/>",
	        data: parameters,
	        success: function(data) {
	            var list = data.list;
	            var dataArr;
	            var inx = 0;
	            var count = 1;
	
	            if(list != "") {
	                optionCount = list.length;
	
	                $(list).each( function() {
	                    if(this.stockNum > 0 && this.ddlYn == 'N') {
	                        dataArr = "<li>";
	                        dataArr += "<a href='javascript:;' data-raw='' title='" + this.optNm +"'>";
	                        dataArr += "<p class='product'>";
	                        dataArr += "<span>[선택" + count + "]" + fn_addDate(this.aplDt) +  " " + this.optNm + "</span>";
	                        dataArr += "<span class='count'> | 잔여 : " + commaNum(this.stockNum) + "개</span>";
	                        dataArr += "</p>";
	                        dataArr += "<p class='price'>" + commaNum(this.saleAmt) + "</p>";
	                        dataArr += "</a>";
	                        dataArr += "</li>";
	                    } else {
	                        dataArr = "<li>";
	                        dataArr += "<p class='product'>";
	                        dataArr += "<span>[선택" + count + "]" + fn_addDate(this.aplDt) + " " + this.optNm + "</span>";
	                        // dataArr += "<span class='count'> | 잔여 : " + commaNum(this.stockNum) + "개</span>";
	                        dataArr += "</p>";
	                        dataArr += "<p class='price'>품절</p>";
	                        dataArr += "</li>";
	                    }
	                    $("#secondOptionList").append(dataArr);
	                    $("#secondOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
	                    count++;
	                    inx++;
	                });
	
	                $('.comm-select1 dd').css('display', 'none');
	                //$(".comm-select3 dd").css('display', 'block');	//자동open 해제
	                $(".comm-select3 dd").css('display', 'none');
	            }
	        },
	        error: fn_AjaxError
	    });
	}
	
	/**
	 * 총합계.
	 */
	function selectedItemSaleAmt() {
	    var price = 0;
	
	    $("#selectedItemWrapper .price").each(function(){
	        price = price +  Number(fn_replaceAll($(this).text(), ",", ""));
	    });
	
	    $("#totalProductAmt").html(commaNum(price));
	    // L.Point 적립 금액
	    $("#lpointSavePoint").html(commaNum(parseInt((eval(price) * "${Constant.LPOINT_SAVE_PERCENT}" / 100) / 10) * 10) + "원");
	    // 할인쿠폰 체크
	    fn_chkCouponList();
	}
	/**
	 * 찜한 상품
	 */
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
	
	function fn_SvAddCart(){
	    var items = $("#selectedItemWrapper ul>li");
	
	    if(items.length == 0) {
	        alert("옵션을 선택해 주세요.")
	        return false;
	    }
	    var cart = [];
	
	    items.each(function() {
	        var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	
	        cart.push({
	            prdtNum     : "<c:out value='${prdtInfo.prdtNum}'/>",
	            prdtNm 		: "<c:out value='${prdtInfo.prdtNm}'/>",
	            prdtDivNm 	: "<c:out value='${prdtInfo.ctgrNm}'/>",
	            corpId 		: "<c:out value='${prdtInfo.corpId}'/>",
	            corpNm 		: "<c:out value='${prdtInfo.corpNm}'/>",
	            nmlAmt 		: 0,
	            qty : $(this).find(".list2 .qty-input").val(),
	            svOptSn : dataRaw.svOptSn,
	            svDivSn :dataRaw.svDivSn,
	            addOptNm : dataRaw.addOptNm,
	            addOptAmt : dataRaw.addOptAmt,
	            <c:if test="${prdtInfo.directRecvYn == 'Y' }">
	                directRecvYn : $("select[name=directRecvYn]").val()
	            </c:if>
	            <c:if test="${prdtInfo.directRecvYn != 'Y' }">
	                directRecvYn : 'N'
	            </c:if>
	        });
	    });
	
	    fn_AddCart(cart);
	    // 장바구니에 담고 선택한거 삭제?
	    $("#selectedItemWrapper ul").html('');
	    selectedItemSaleAmt();
	
	    AM_PRODUCT(1);//모바일 에이스 카운터 추가 2017.04.25
	}
	
	/**
	 * 즉시구매
	 */
	function fn_SvBuy(){
	    var item = $("#selectedItemWrapper ul>li");
	
	    if(item.length == 0 ) {
	        alert("옵션을 선택해 주세요.")
	        return false;
	    }
	    var cart = [];
	
	    item.each(function() {
	        var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	        cart.push({
	            prdtNum 	: "<c:out value='${prdtInfo.prdtNum}'/>",
	            prdtNm 		: "<c:out value='${prdtInfo.prdtNm}'/>",
	            prdtDivNm 	: "<c:out value='${prdtInfo.ctgrNm}'/>",
	            corpId 		: "<c:out value='${prdtInfo.corpId}'/>",
	            corpNm 		: "<c:out value='${prdtInfo.corpNm}'/>",
	            nmlAmt 		: 0,
	            qty : $(this).find(".list2 .qty-input").val(),
	            svOptSn : dataRaw.svOptSn,
	            svDivSn :dataRaw.svDivSn,
	            addOptNm : dataRaw.addOptNm,
	            addOptAmt : dataRaw.addOptAmt,
	            <c:if test="${prdtInfo.directRecvYn == 'Y' }">
	                directRecvYn : $("select[name=directRecvYn]").val()
	            </c:if>
	            <c:if test="${prdtInfo.directRecvYn != 'Y' }">
	                directRecvYn : 'N'
	            </c:if>
	        });
	    });
	    fn_InstantBuy(cart);
	
	    AM_PRODUCT(1);//모바일 에이스 카운터 추가 2017.04.25
	}
	
	function checkDupOption(newData) {
	    var result =false ;
	    $("#selectedItemWrapper ul>li").each(function () {
	        var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	
	        if(newData.svDivSn == dataRaw.svDivSn && newData.svOptSn == dataRaw.svOptSn) {
	            // 추가옵션 체크
	            if(typeof newData.addOptSn == "undefined") {
	                result = true;
	                return;
	            } else {
	                if(newData.addOptSn == dataRaw.addOptSn) {
	                    result = true;
	                    return;
	                }
	            }
	        }
	    });
	    return result;
	}
	
	function fn_dlvText(dlvAmtDiv, dlvAmt, inDlvAmt, maxiBuyNum) {
	    if(dlvAmtDiv == "${Constant.DLV_AMT_DIV_DLV}") {
	        return "도외("+ commaNum(dlvAmt) + "),도내(" + commaNum(inDlvAmt) + ")";
	    } else if (dlvAmtDiv == "${Constant.DLV_AMT_DIV_APL}") {
	        return commaNum('${corpDlvAmtVO.aplAmt}') + "원 이상 무료";
	    } else if(dlvAmtDiv == "${Constant.DLV_AMT_DIV_MAXI}") {
	        return commaNum(maxiBuyNum) + "개당 "+ commaNum(dlvAmt) + "원";
	    } else if(dlvAmtDiv == "${Constant.DLV_AMT_DIV_FREE}") {
	        return "무료";
	    }
	}
	
	function onChgDirectRecvYn(obj){
	    if(obj.value == 'N'){
	        //일반 배송
	        $("#directRecvYNBtn").hide();
	    }else{
	        //직접 수령
	        if(!('${svDftinfo.directrecvLon}'=='' || '${svDftinfo.directrecvLat}'=='')){
	            //지도 정보가 있어야 표시
	            $("#directRecvYNBtn").show();
	        }
	    }
	}
	
	//쿠폰 리스트 체크
	function fn_chkCouponList() {
	    var copNum = 0;
	    var amt = eval(fn_replaceAll($("#totalProductAmt").text(), ",", ""));
	
	    $(".useCouponList").each(function() {
	        if(amt < $(this).attr("minAmt")) {
	            $(this).addClass("hide");
	        } else {
	            copNum++;
	
	            $(this).removeClass("hide");
	        }
	    });
	
	    if(copNum == 0) {
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
	
	                alert("<spring:message code='success.coupon.download'/>");
	            } else {
	                alert("<spring:message code='fail.coupon.download'/>");
	            }
	        },
	        error: fn_AjaxError
	    })
	}

    // 1130 구매하기 레이어팝업 잠금
    function itemSingleShow(obj) {
        if($(obj).is(":hidden")) {

            $("#purchase_popup").fadeToggle();

            $(obj).show();
            $("body").addClass("not_scroll");
            $('#purchase_popup').css('position', 'fixed');

            $('.purchase-area').css('z-index', '99');

            $("body").after("<div class='lock-bg'></div>"); // 검은 불투명 배경

        } else {
            $(obj).hide();
            $(".lock-bg").remove();
        }
    }

	// 쿠폰코드 등록
	function goCouponCode() {
	    if(confirm("<spring:message code='confirm.coupon.code' />")){
	        location.href = "<c:url value='/mw/mypage/couponList.do' />";
	    }
	}
	
	// 위치보기
	function fn_showMap() {
	    $(".map-info-area").show();
	
	    //동적 지도 ( 움직이는 지도.)
	    var container2 = document.getElementById('sighMap');
	    var options2 = {
	        center: new daum.maps.LatLng("${svDftinfo.directrecvLat}", "${svDftinfo.directrecvLon}"),
	        //center: new daum.maps.LatLng(33.4888341, 126.49807970000006),
	        level: 4
	    };
	
	    var map2 = new daum.maps.Map(container2, options2);
	
	    // 현재 위치.
	    //마커가 표시될 위치입니다
	    var c_markerPosition  = new daum.maps.LatLng("${svDftinfo.directrecvLat}", "${svDftinfo.directrecvLon}");
	    var c_imageSrc = "<c:url value='/images/web/icon/location_my.png'/>";
	    var c_imageSize = new daum.maps.Size(24, 35);
	    var c_markerImage = new daum.maps.MarkerImage(c_imageSrc, c_imageSize);
	    // 마커를 생성합니다
	    var marker = new daum.maps.Marker({
	        map : map2,
	        position: c_markerPosition,
	        image : c_markerImage
	    });
	}
	
	$(document).ready(function() {

        // 공유하기 레이어팝업
        $(".icon-area > .sns-share").click(function(){

            $("#sns_popup").fadeToggle();

            $("body").addClass("not_scroll");
            $('#sns_popup').css('position', 'fixed');
            $('#sns_popup').animate( {'top' : '75%'}, 200);

            $("body").after("<div class='lock-bg'></div>"); // 검은 불투명 배경

        });

        // 레이어팝업 닫기 btn
        $(".close").click(function() {
            $('body').removeClass('not_scroll');
            $('#sns_popup').css('top', '80%');			//애니에 따른 추가
        });

	    //Top Banner Slider
	    if($('#detail_slider .swiper-slide').length > 1) {
	        var swiper = new Swiper('#detail_slider', {
	            pagination: '#detail_paging',
	            paginationType: 'fraction',
	            loop: true
	        });
	    }
	
	    //주변 관광/레저
	    if($('#promotion_product .swiper-slide').length > 1) {
	        var swiper = new Swiper('#promotion_product', {
	            slidesPerView: 'auto',
	            paginationClickable: true,
	            spaceBetween: 15
	        });
	    }
	
	    //Tab Menu (상품설명, 사용조건 등)
	    targetTabMenu('#scroll_tabs');
	
	    // 상품을 선택하세요
	    $('.comm-select1 dt').click(function() {
	        if($(".comm-select1 dd").css('display') == 'block') {
	            $('.comm-select dd').css('display', 'none');
	            return ;
	        }
	        if($("#firstOptionList li").length > 0) {
	            if($(".comm-select1 dd").css('display') == 'none') {
	                $('.comm-select dd').css('display', 'none');
	                $(".comm-select1 dd").css('display', 'block')
	            }
	            return;
	        }
	
	        $.ajax({
	            url: "<c:url value='/mw/sv/getDivInfList.ajax'/>",
	            data: "prdtNum=${prdtInfo.prdtNum}",
	            success:function(data) {
	                var list = data.list;
	                var dataArr;
	                var inx = 0;
	                var count =1;
	
	                if(list != "") {
	                    productCount = list.length;
	
	                    $(list).each( function() {
	                        dataArr = "<li>";
	                        dataArr += "<a href='javascript:;' data-raw='' title='" + this.prdtDivNm + "'>";
	                        dataArr += "<p class='product'><span>[선택" + count + "]</span><span>" + this.prdtDivNm + "</span></p>";
	                        dataArr += "</a>";
	                        dataArr += "</li>";
	
	                        $("#firstOptionList").append(dataArr);
	                        $("#firstOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this));
	                        count++;
	                        inx++;
	                    });
	
	                    $('.comm-select dd').css('display', 'none');
	                    $('.comm-select1 dd').css('display', 'block');

	                    /*if(productCount == 1) {
	                    	//자동open 해제
	                        //$("#firstOptionList li:eq(0)>a").trigger("click");			// 1개 상품 경우 자동선택
	                    } else if(productCount > 1) {
	                        $(".comm-select1").addClass("open");						// 2개 이상 상품일 경우 open
	                    }else {
	                        $(".comm-select1 dt").trigger("click");
	                    }*/
	                }
	            },
	            error: fn_AjaxError
	        })
	    });
	
	    // 상품 목록 펼침(자동오픈 해제 요청)
	    //$(".comm-select1 dt").trigger("click");
	
	    // 상품 선택
	    $("#firstOptionList").on('click', "li>a", function() {
	        var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	        var title = $(this).attr("title");
	
	        $("#svDivSn").val(dataRaw.svDivSn);
	
	        $(".comm-select1 dt").html("1. 선택상품 : <span></span>");
	        $(".comm-select1 dt span").text(title);
	        $(".comm-select1 dt span").addClass("text-red");
	
	        $("#secondOptionList").empty();
	
	        getSecondOption();
	    });
	
	    // 옵션을 선택하세요
	    $('.comm-select3 dt').click(function(){
	        if($(".comm-select3 dd").css('display') == 'block') {
	            $(".comm-select3 dd").css('display', 'none');
	        } else {
	            if($("#secondOptionList li").length > 0) {
	                $(".comm-select3 dd").css('display', 'block');
	            }
	        }
	    });
	
	    // 옵션 선택
	    $("#secondOptionList").on("click", "li>a", function() {
	        var dataRaw =  jQuery.parseJSON($(this).attr("data-raw"));
	        var ori_dataRaw = $(this).attr("data-raw");
	        var firstOptionText = $(".comm-select1 dt span").text();
	        var secondOptionText = $(this).attr("title");
	
	        if("${fn:length(addOptList)}" == 0 ) {
	            if(checkDupOption(dataRaw)) {
	                alert("<spring:message code='fail.product.duplication'/>");
	
	                $(".comm-select1 dd").css("display", "none");
	                return false;
	            }
	            var text = "<li class='qty-list'>";
	            text += "<ol>";
	            text += "<li class='list1'>";
	            text += firstOptionText + "<br>";
	            text += " - " + secondOptionText;
	            text += "<span class='option-stockNum' style='display:none'>" + commaNum(dataRaw.stockNum) + "</span>";
	            text += "<p class='shipping'>배송비 : " + fn_dlvText(dataRaw.dlvAmtDiv, dataRaw.dlvAmt, dataRaw.inDlvAmt, dataRaw.maxiBuyNum) + "</p>";
	            text += "</li>";
	            text += "<li class='list2'>";
	            text += "<input type='text' value='1' class='qty-input'><button class='addition'>+</button><button class='subtract'>-</button>";
	            text += "</li>";
	            text += "<li class='list3'>";
	            text += "<span class='price'>" + commaNum(dataRaw.saleAmt) + "</span>";
	            text += "<a href='javascript:;'><span class='del'><img src='/images/mw/sub_common/delete.png' alt='삭제'></span></a>";
	            text += "</li>";
	            text += "</ol>";
	            text += "</li>";
	
	            $("#selectedItemWrapper ul").append(text);
	            $("#selectedItemWrapper ul>li").last().attr("data-raw",ori_dataRaw);
	            $("#selectedItemWrapper").css('display', 'block');
	
	            if(productCount > 1) {
	                if(optionCount == 1) {
	                    $(".comm-select").removeClass("open");
	                    $(".comm-select1 dt").html("1. 상품을 선택하세요");
	                    $(".comm-select2 dt").html("2. 옵션을 선택하세요");
	                    $("#secondOptionList").empty();
	                }
	            }
	            $(".comm-select dd").css("display", "none");
	
	            selectedItemSaleAmt();
	        } else {
	            getAddOption();
	
	            $("#addOptionList").attr("data-raw", ori_dataRaw);
	            $(".comm-select3 dt").html("2. 선택옵션 : <span></span>");
	            $(".comm-select3 dt span").text(secondOptionText);
	            $(".comm-select3 dt span").addClass("text-red");
	        }
	    });
	
	    // 추가옵션을 선택하세요
	    $('.comm-select4 dt').click(function(){
	        if($(".comm-select4 dd").css('display') == 'block') {
	            $(".comm-select4 dd").css('display', 'none');
	        } else {
	            if($("#addOptionList li").length > 0) {
	                $(".comm-select4 dd").css('display', 'block');
	            }
	        }
	    });
	
	    // 추가옵션 선택
	    $("#addOptionList").on('click', "li>a", function() {
	        var dataRaw =  jQuery.parseJSON($("#addOptionList").attr("data-raw"));
	        var thisDataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	
	        dataRaw.addOptAmt = thisDataRaw.addOptAmt;
	        dataRaw.addOptNm = thisDataRaw.addOptNm;
	        dataRaw.addOptSn = thisDataRaw.addOptSn;
	
	        var ori_dataRaw = JSON.stringify(dataRaw);
	
	        var firstOptionText = $(".comm-select1 dt span").text();
	        var secondOptionText = $(".comm-select3 dt span").text();
	        var addOptionText = $(this).attr("title");
			
	        if(checkDupOption(dataRaw)) {
				alert("<spring:message code='fail.product.duplication'/>");
				return ;
			}
	        
	        var saleAmt = Number(dataRaw.saleAmt) + Number(thisDataRaw.addOptAmt);
	        // 2016-01-17, 잔여수가 없어져버려서 수량 변경 기능이 오작동됨.. 롤백(by ezham)
	        var text = "<li class='qty-list'>";
	        text += "<ol>";
	        text += "<li class='list1'>";
	        text += firstOptionText + "<br>";
	        text += " - " + secondOptionText;
	
	        if(addOptionText != "") {
	            text += " - " + addOptionText;
	        }
	        text += "<span class='option-stockNum' style='display:none'>" + commaNum(dataRaw.stockNum) + "</span>";
	        text += "<p class='shipping'>배송비 : " + fn_dlvText(dataRaw.dlvAmtDiv, dataRaw.dlvAmt, dataRaw.inDlvAmt, dataRaw.maxiBuyNum) + "</p>";
	        text += "</li>";
	        text += "<li class='list2'>";
	        text += "<input type='text' value='1' class='qty-input'><button class='addition'>+</button><button class='subtract'>-</button>";
	        text += "</li>";
	        text += "<li class='list3'>";
	        text += "<span class='price'>" + commaNum(saleAmt) + "</span>";
	        text += "<a href='javascript:;'><span class='del'><img src='/images/mw/sub_common/delete.png' alt='삭제'></span></a>";
	        text += "</li>";
	        text += "</ol>";
	        text += "</li>";
	
	        $("#selectedItemWrapper ul").append(text);
	        $("#selectedItemWrapper ul>li").last().attr("data-raw", ori_dataRaw);
	        $("#selectedItemWrapper").css('display', 'block');
	        $('.comm-select dd').css('display', 'none');
	
	        if(productCount > 1) {
	            $("#secondOptionList").empty();
	        }
	        $("#addOptionList").empty();
	
	        $(".comm-select").removeClass("open");
	
	        if(productCount > 1) {
	            $(".comm-select1 dt").html("1. 상품을 선택하세요");
	        }
	        $(".comm-select3 dt").html("2. 옵션을 선택하세요");
	
	        selectedItemSaleAmt();
	    });
	
	    $("#selectedItemWrapper").on("click", ".del", function() {
	        $(this).parents(".qty-list").remove();
	
	        if($(this).parents(".qty-list").length == 0 ) {
	            $("#selectedItemWrapper").css('display','block');
	        }
	        selectedItemSaleAmt();
	
	        return ;
	    });
	
	    $("#selectedItemWrapper").on("keyup", ".qty-input", function() {
	        var stockNum =fn_replaceAll($(this).parents(".qty-list").find(".option-stockNum").text(), ",","");
	        var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
	        var saleAmt = thisDataRaw.saleAmt;
	
	        $(this).val($(this).val().replace(/[^0-9]/gi,""));
	
	        var keyCount = Number($(this).val());
	
	        if(keyCount > Number(stockNum)) {
	            keyCount = stockNum;
	            $(this).val(keyCount);
	        }
	
	        $(this).parents(".qty-list").find(".price").text(commaNum(saleAmt * keyCount));
	
	        selectedItemSaleAmt();
	    });
	
	    $("#selectedItemWrapper").on("blur", ".qty-input", function() {
	        var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
	        var saleAmt = thisDataRaw.saleAmt;
	
	        var keyCount = $(this).val();
	
	        if(isNull(keyCount)) {
	            keyCount = 1;
	            $(this).val(keyCount);
	        }
	
	        $(this).parents(".qty-list").find(".price").text(commaNum(saleAmt * keyCount));
	
	        selectedItemSaleAmt();
	    });
	
	    $("#selectedItemWrapper").on("click", ".addition", function() {
	        var stockNum =fn_replaceAll($(this).parents(".qty-list").find(".option-stockNum").text(), ",","");
	        var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
	        var saleAmt = thisDataRaw.saleAmt;
	        var addtionCount = Number($(this).prev().val()) + 1;
	
	        //플러스 버튼 클릭 시 추가옵션 금액 추가 2021.05.03 cahewan.jung
	        if (typeof thisDataRaw.addOptAmt != "undefined" && thisDataRaw.addOptAmt != "" && thisDataRaw.addOptAmt != null){
	            saleAmt = saleAmt + parseInt(thisDataRaw.addOptAmt);
	        }
	
	        if(addtionCount <= stockNum) {
	            $(this).prev().val(addtionCount);
	            $(this).parents(".qty-list").find(".price").text(commaNum(saleAmt * addtionCount));
	
	            selectedItemSaleAmt();
	        }
	    });
	
	    $("#selectedItemWrapper").on("click", ".subtract", function() {
	        var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
	        var saleAmt = thisDataRaw.saleAmt;
	        var subtractCount = Number($(this).parents(".qty-list").find(".qty-input").val()) - 1;
	
	        //마이너스 버튼 클릭 시 추가옵션 금액 추가 2021.05.03 cahewan.jung
	        if (typeof thisDataRaw.addOptAmt != "undefined" && thisDataRaw.addOptAmt != "" && thisDataRaw.addOptAmt != null){
	            saleAmt = saleAmt + parseInt(thisDataRaw.addOptAmt);
	        }
	
	        if(subtractCount >= 1) {
	            $(this).parents(".qty-list").find(".qty-input").val(subtractCount);
	            $(this).parents(".qty-list").find(".price").text(commaNum(saleAmt * subtractCount));
	
	            selectedItemSaleAmt();
	        }
	    });
	
	    // fn_chkCouponList();
	
	    //-이용 후기 관련 설정 --------------------
	    g_UE_getContextPath = "${pageContext.request.contextPath}";
	    g_UE_corpId = "${prdtInfo.corpId}";					//업체 코드 - 넣어야함
	    g_UE_prdtnum = "${prdtInfo.prdtNum}";					//상품번호  - 넣어야함
	    g_UE_corpCd = "${Constant.SV}";	//숙박/랜트.... - 페이지에 고정
	
	    //이용후기 상단 평점/후기수, 탭 숫자 변경(서비스로 사용해도됨)
	    fn_useepilInitUI();
	    // * 서비스 사용시 GPAANLSVO ossUesepliService.selectByGpaanls(GPAANLSVO) 사용
	
	    //이용후기 리스트 뿌리기 -> 해당 탭버튼 눌렀을때 호출하면됨
	    fn_useepilList();
	    //---------------------------------------------------
	
	    //-1:1문의 관련 설정 --------------------------------
	    g_Oto_getContextPath = "${pageContext.request.contextPath}";
	    g_Oto_corpId = "${prdtInfo.corpId}";					//업체 코드 - 넣어야함
	    g_Oto_prdtnum = "${prdtInfo.prdtNum}";					//상품번호  - 넣어야함
	    g_Oto_corpCd = "${Constant.SV}";	//숙박/랜트.... - 페이지에 고정
	
	    //1:1문의 리스트 뿌리기 -> 해당 탭버튼 눌렀을때 호출하면됨
	    fn_otoinqList();
	
	    // L.Point 적립 금액
	    $("#lpointSavePoint").html(commaNum(parseInt((eval("${prdtInfo.saleAmt}") * "${Constant.LPOINT_SAVE_PERCENT}" / 100) / 10) * 10) + "원");
	    //---------------------------------------------------
	
	    // 구매하기 팝업 높이 재설정
	    $(".scroll-area").css("max-height", $(window).height() - 96);
	
	    // IE 브라우저 체크
	    var agent = window.navigator.userAgent;
	    if(agent.indexOf('Edge') > -1 || agent.indexOf('Trident') > -1) {
	        $(".purchase-option").css("padding-bottom", 70);
	    }
	});
</script>
	
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" />
<!-- 푸터 e -->
<script type="text/javascript">
    //남은시간 갱신

    var timeLeft = <c:out value="${difTime}" />;
    var updateLeftTime = function() {
        timeLeft = (timeLeft <= 0) ? 0 : -- timeLeft;

        var hours = Math.floor(timeLeft / 3600);
        var minutes = Math.floor((timeLeft - 3600 * hours) / 60);
        var seconds = timeLeft % 60;

        var time_text = timegroup_format(${difDay}) + "일 "
            + timegroup_format(hours) + ':'
            + timegroup_format(minutes) + ':'
            + timegroup_format(seconds);

        $("#realTimeAttack").text(time_text);
    }

    function timegroup_format(num) {
        var ret_str = '';
        var n = num.toString();
        if (n.length == 1)
            ret_str += '0' + n;
        else
            ret_str += n;
        return ret_str;
    }
    $(document).ready(function() {
        //setInterval(updateLeftTime, 1000);
    });
</script>
</div>

<%-- 모바일 에이스 카운터 추가 2017.04.25 --%>
<!-- *) 제품상세페이지 분석코드 -->
<!-- AceCounter Mobile eCommerce (Product_Detail) v7.5 Start -->
<script language='javascript'>
    var m_pd ="<c:out value='${prdtInfo.prdtNm}'/>";
    var m_ct ="제주특산/기념품";
    var m_amt="${prdtInfo.saleAmt}";
</script>
<!-- AceCounter Mobile WebSite Gathering Script V.7.5.20170208 -->
<script language='javascript'>
    var _AceGID=(function(){var Inf=['tamnao.com','m.tamnao.com,www.tamnao.com,tamnao.com','AZ3A70537','AM','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;if(_CI.join('.').indexOf(Inf[3])<0){ _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
    var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,'_');_sc.src=(location.protocol.indexOf('http')==0?location.protocol:'http:')+'//cr.acecounter.com/Mobile/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<noscript><img src='https://gmb.acecounter.com/mwg/?mid=AZ3A70537&tp=noscript&ce=0&' border='0' width='0' height='0' alt=''></noscript>
<!-- AceCounter Mobile Gathering Script End -->

<!-- beusable 웹로그툴 SCRIPT START 2017.07.05 -->
<%--<script type="text/javascript">
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
</body>
</html>