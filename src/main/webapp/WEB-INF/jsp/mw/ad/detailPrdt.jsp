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
<c:if test="${fn:length(imgList) == 0}">
	<c:set value="" var="seoImage"/>
</c:if>
<c:if test="${fn:length(imgList) != 0}">
	<c:set value="${imgList[0].savePath}thumb/${imgList[0].saveFileNm}" var="seoImage"/>
</c:if>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?CorpId=${webdtl.corpId}"/>
<c:set var="imgUrl" value="${pageContext.request.scheme}://${strServerName}${imgList[0].savePath}thumb/${imgList[0].saveFileNm}"/>

<jsp:include page="/mw/includeJs.do" >
	<jsp:param name="title" value="${webdtl.adNm} 특가 - 제주도 ${webdtl.adGrd} 예약"/>
	<jsp:param name="keywordsLinkNum" value="${webdtl.corpId}"/>
	<jsp:param name="keywordAdd1" value="${webdtl.adNm}"/>
	<jsp:param name="description" value="${seoInfo}"/>
	<jsp:param name="imagePath" value="${seoImage}"/>
</jsp:include>
<meta property="og:title" content="${webdtl.adNm} 특가 - 제주도 ${webdtl.adGrd} 예약" />
<meta property="og:url" content="${strUrl}" />
<meta property="og:description" content="${seoInfo}" />
<c:if test="${fn:length(imgList) != 0}">
<meta property="og:image" content="https://${strServerName}${imgList[0].savePath}thumb/${imgList[0].saveFileNm}" />
</c:if>
<meta property="fb:app_id" content="182637518742030" />

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Light.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}' />">

<link rel="canonical" href="https://www.tamnao.com/web/ad/detailPrdt.do?corpId=${webdtl.corpId}">

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
		"https://${strServerName}${imgList[0].savePath}thumb/${imgList[0].saveFileNm}"
	],
	"description": "${webdtl.adSimpleExp}",
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
<div id="wrap">
	<!-- 헤더 s -->
	<header id="header">
		<jsp:include page="/mw/head.do" />
	</header>
	<!-- 헤더 e -->

	<main id="main">
		<!--//change contents-->
		<div class="mw-detail-area">
			<section class="detail-product-area">
				<h2 class="sec-caption">상품 정보</h2>
				<!-- main-slider -->
				<div class="detail-slider">
					<div id="detail_slider" class="swiper-container">
						<div class="swiper-wrapper">
							<c:forEach var="result" items="${imgList}" varStatus="status">
								<div class="swiper-slide img--expand">
									<c:choose>
										<c:when test="${status.count < 2}">
											<img src="${result.savePath}thumb/${result.saveFileNm}" alt="${webdtl.adNm}_${status.count}">		
										</c:when>
										<c:otherwise>
											<img src="${result.savePath}thumb/${result.saveFileNm}" loading="lazy" alt="${webdtl.adNm}_${status.count}">
										</c:otherwise>
									</c:choose>
									<div class="img-caption">
									</div>
								</div>
							</c:forEach>
						</div>
						<div id="detail_paging" class="swiper-pagination"></div>
					</div>
				</div> <!-- //main-slider -->

				<!-- 0112 숙소 구매 상세페이지 개선 -->
				<div class="product-info">
					<div class="title-area">
						<div class="memo"><c:out value="${webdtl.adSimpleExp}"/></div>
						<div class="title"><c:out value="${webdtl.adNm}"/> <span class="guide-title"><c:out value="${webdtl.adAreaNm}"/></span></div>

						<div class="grade-area">
							<div class="score-area"></div>
							<div class="room-conjugate">
								<div class="sns-share icon-area">
									<%-- <a href="javascript:void(0)" onclick="itemSingleShow('#sns_popup');"> --%>
									<a id="ad-sns-share" class="sns-share">
										<img src="<c:url value='/images/mw/icon/sns-share.png' />" alt="sns">
									</a>
								</div>
							<%--	<div class="like">
									<c:if test="${pocketCnt eq 0 }">
										&lt;%&ndash; <a href="javascript:void(0)" onclick="javascript:fn_adAddPocket();" id="pocketBtnId"> &ndash;%&gt;
										<a onclick="javascript:fn_adAddPocket();" id="pocketBtnId">
											<img src="<c:url value='/images/mw/icon/product-like.png' />" alt="찜하기">
										</a>
									</c:if>
									<c:if test="${pocketCnt ne 0 }">
										&lt;%&ndash; <a href="javascript:void(0)" class="product-like"> &ndash;%&gt;
										<a class="product-like">
											<img src="<c:url value='/images/mw/icon/r_product-like_on.png' />" alt="찜하기">
										</a>
									</c:if>
								</div>--%>
							</div>
							<div class="bxLabel">
								<c:if test="${adHotDay.daypriceYn == 'Y'}"><span class="main_label pink">당일특가</span></c:if>
								<c:if test="${adHotDay.eventYn == 'Y'}"><span class="main_label eventblue">이벤트</span></c:if>
								<c:if test="${adHotDay.couponYn == 'Y'}"><span class="main_label pink">할인쿠폰</span></c:if>
								<c:if test="${adHotDay.continueNightYn == 'Y'}"><span class="main_label back-red">연박할인</span></c:if>
								<c:if test="${adHotDay.superbCorpYn == 'Y' }"><span class="main_label back-red">우수관광사업체</span></c:if>
								<c:if test="${adHotDay.tamnacardYn eq 'Y'}"><span class="main_label yellow">탐나는전</span></c:if>
							</div>
						</div>
					</div>
				</div> <!-- //product-info -->

<%--				<!-- 프로모션 ui 노출 / 라인배너-->
				<div class="ad-see-promotion">
					<div class="adPromotion">
						<div class="layout_left">
							<img class="gift_icon" src="/images/mw/event/gift.png" alt="할인">
							<div class="title--discount">아래 보이는 상품가에 <br>~30% 슈퍼 할인</div>
						</div>
						<div class="article">결제 단계에서 확인 가능</div>
					</div>
				</div>

				<div class="ad-layerpop">
					<div class="content-wrap">
						<div class="content-article">
							<div class="paragraph">
								<span class="num">Promotion</span>
								<p>총 15만원 즉시 할인 쿠폰 5종 증정 <br>(ID 당 각 1 회 사용 가능)</p>
								<p>• 구매 금액대별 3천원 , 1만 5천원 , 3만원 , 4만 5천원 , 6만원 쿠폰 할인</p>
							</div>

						&lt;%&ndash;	<div class="paragraph">
								<span class="num">Promotion</span>
								<p>총 10만원 즉시 할인 쿠폰 5종 증정<br>(ID당 각 1회 사용 가능)</p>
								<p>• 구매 금액대별 2천원, 1만원, 2만원, 3만원, 4만원 쿠폰 할인</p>
							</div>

							<div class="paragraph">
								<span class="num">Promotion 3</span>
								<p>할인쿠폰 3 장 이상 사용 고객 제주 특산물 증정</p>
							</div>&ndash;%&gt;

						</div>
					</div>
				</div><!-- //빅할인 프로모션 ui 노출 -->--%>

				<div class="point-area">
					<c:if test="${(not empty loginVO) && (fn:length(couponList) > 0)}">
						<div class="col2-area" id="useAbleCoupon">
							<div class="title text-red">할인쿠폰</div>
							<c:forEach var="coupon" items="${couponList}" varStatus="status">
								<c:set var="userCp" value="${userCpMap[coupon.cpId]}"/>

								<div class="row useCouponList" minAmt="${coupon.buyMiniAmt}">
									<span class="col1">
										<div class="coupon-title-wrap">
											<div class="coupon-title">
												${coupon.cpNm}
											</div>
										</div>
										<span class="text-gray"><fmt:formatNumber>${coupon.buyMiniAmt}</fmt:formatNumber>원 이상 구매시<br>사용 가능</span>
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
									</span>
								</div>
							</c:forEach>
						</div>
					</c:if>
					<div class="col2-area line">
						<div class="row">
							<span class="col1">L.POINT적립금</span>
							<span class="col2" id="lpointSavePoint">0원</span>
						</div>
					</div>
				</div>
			</section> <!-- //detail-product-area -->
			<section class="room-option">
				<h2 class="sec-caption">방 정보</h2>
				<div class="selected-option-info side-padding">
					<div class="search-value">
						<div class="text">
							<c:if test="${searchVO.sSearchYn eq 'Y'}">
								<fmt:parseDate var="fromDt" value="${searchVO.sFromDt}" pattern="yyyyMMdd" />
								<fmt:parseDate var="toDt" value="${searchVO.sToDt}" pattern="yyyyMMdd" />
								<a href="javascript:document.frm.submit();" class="text-white" id="dateModBtn">
									<fmt:formatDate value="${fromDt}" pattern="MM월 dd일" /> - <fmt:formatDate value="${toDt}" pattern="MM월 dd일" /> (<c:out value="${searchVO.sNights}"/>박)
									<span>
									<img src="/images/mw/icon/user_2.png" alt="인원수">
									성인 ${searchVO.sAdultCnt}
									<c:if test="${searchVO.sChildCnt > 0}">, 소아 ${searchVO.sChildCnt}</c:if>
									<c:if test="${searchVO.sBabyCnt > 0}">, 유아 ${searchVO.sBabyCnt}</c:if>
								</span>
								</a>
							</c:if>
							<c:if test="${searchVO.sSearchYn eq 'N'}">
								<a href="javascript:document.frm.submit();" >
									날짜선택
								</a>
							</c:if>
						</div>
						<form name="frm" id="frm" method="get" action = "<c:url value='/mw/ad/mainList.do'/>">
							<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}" />
							<input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}" />
							<input type="hidden" name="prdtNum" id="prdtNum" value="${searchVO.sPrdtNum}" />
							<input type="hidden" name="sPrdtNum" id="sPrdtNum" value="${searchVO.sPrdtNum}" />
							<input type="hidden" name="sSearchYn" id="sSearchYn" value="${searchVO.sSearchYn}" />
							<input type="hidden" name="sRoomNum" id="sRoomNum" value="${searchVO.sRoomNum}">
							<input type="hidden" name="sMen" id="sMen" value="${searchVO.sMen}">
							<input type="hidden" name="sAdultCnt" id="sAdultCnt" value="${searchVO.sAdultCnt}">
							<input type="hidden" name="sChildCnt" id="sChildCnt" value="${searchVO.sChildCnt}">
							<input type="hidden" name="sBabyCnt" id="sBabyCnt" value="${searchVO.sBabyCnt}">
							<input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
							<input type="hidden" name="sFromDtView" id="sFromDtView" value="${searchVO.sFromDtView}">
							<input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
							<input type="hidden" name="sToDtView" id="sToDtView" value="${searchVO.sToDtView}">
							<input type="hidden" name="sNights" id="sNights" value="${searchVO.sNights}">
							<input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>
						</form>
					</div>
				</div>
				<div class="room-area">
				<c:set var="prdtCnt" value="1"/>
				<c:forEach var="result" items="${prdtList}" varStatus="status">
					<c:set var="loopCnt" value="${status.count }" />
					<c:if test="${result.memExcdAbleYn == 'Y'}">
						<c:set var="maxMem" value="${result.maxiMem }"/>
					</c:if>
					<c:if test="${result.memExcdAbleYn != 'Y'}">
						<c:set var="maxMem" value="${result.stdMem }"/>
					</c:if>
					<c:if test="${(searchVO.sSearchYn eq 'N') or (maxMem >= searchVO.sAdultCnt + searchVO.sChildCnt + searchVO.sBabyCnt) }">
					<input type="hidden" id="ctnAmt${prdtCnt}" value="${result.ctnAmt }" />
					<input type='hidden' id="disDaypriceAmt${prdtCnt}" value="${result.disDaypriceAmt }" />
					<input type="hidden" id="saleAmt${prdtCnt}" value="${result.saleAmt + result.ctnAmt + result.disDaypriceAmt }" />
					<input type="hidden" id="ableRsvNum${prdtCnt}" value="${result.ableRsvNum }" />
					<div class="room-group">
						<div class="room-gallery">
							<div class="swiper-container room-slide">
								<div class="swiper-wrapper">
									<c:forEach var="prdtImg" items="${result.imgList}" varStatus="status1">
										<div class="swiper-slide">
											<%-- <a href="javascript:void(0)" onclick="fn_ImgList(${loopCnt});" > --%>
											<span onclick="fn_ImgList(${loopCnt});" >
												<img src="${prdtImg.savePath}thumb/${prdtImg.saveFileNm}" loading="lazy" alt="${result.prdtNm}_${status1.count}">
											</span>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
						<div id="detail_slider${loopCnt}" class="detail-slider roomType">
							<%-- <a href="javascript:void(0)" onclick="topClose(${loopCnt});" class="close"> --%>
							<span onclick="topClose(${loopCnt});" class="close">
								<img src="/images/mw/common/side/room_img_close.png" alt="닫기">
							</span>
							<div class="swiper-wrapper">
								<c:forEach var="prdtImg" items="${result.imgList}" varStatus="status2">
									<div class="swiper-slide">
										<img src="${prdtImg.savePath}thumb/${prdtImg.saveFileNm}" loading="lazy" alt="${result.prdtNm}_${status2.count}">
										<div class="img-caption">
											<p>${result.prdtNm}_${status2.count}</p>
										</div>
									</div>
								</c:forEach>
							</div>
							<div id="detail_paging${loopCnt}" class="swiper-pagination"></div>
							<div id="detail_arrow${loopCnt}" class="arrow-area">
								<div id="detail_next${loopCnt}" class="swiper-button-next add--arrow">
									<img src="/images/mw/common/side/room-swiper-button-next.png" alt="오른쪽이동">
								</div>
								<div id="detail_prev${loopCnt}" class="swiper-button-prev add--arrow">
									<img src="/images/mw/common/side/room_swiper-button-prev.png" alt="왼쪽이동">
								</div>
							</div>
						</div>
						<div class="info-area">
							<div class="title"><c:out value="${result.prdtNm}"/></div>
							<div class="memo">
								<c:out value="${result.prdtExp }"/>
							</div>
							<c:set var="addAdultPrice" value="0"/>
							<c:set var="addChildPrice" value="0"/>
							<c:set var="addBabyPrice" value="0"/>

							<fmt:parseNumber var="adultAddAmt" type="number" value="${fn:trim(fn:replace(result.adultAddAmt, ',', '')) }" />
							<fmt:parseNumber var="childAddAmt" type="number" value="${fn:trim(fn:replace(result.juniorAddAmt, ',', '')) }" />
							<fmt:parseNumber var="babyAddAmt" type="number" value="${fn:trim(fn:replace(result.childAddAmt, ',', '')) }" />

							<c:if test="${searchVO.sAdultCnt > result.stdMem}">
								<c:set var="addAdultPrice" value="${(searchVO.sAdultCnt - result.stdMem) * adultAddAmt }"/>
							</c:if>
							<c:if test="${(addAdultPrice > 0) and (searchVO.sChildCnt > 0) }">
								<c:set var="addChildPrice" value="${searchVO.sChildCnt * childAddAmt }"/>
							</c:if>
							<c:if test="${(addAdultPrice eq 0) and (searchVO.sChildCnt > result.stdMem - searchVO.sAdultCnt)}">
								<c:set var="addChildPrice" value="${(searchVO.sChildCnt - (result.stdMem - searchVO.sAdultCnt)) * childAddAmt }"/>
							</c:if>
							<c:if test="${(addAdultPrice + addChildPrice > 0) and (searchVO.sBabyCnt > 0) }">
								<c:set var="addBabyPrice" value="${searchVO.sBabyCnt * babyAddAmt }"/>
							</c:if>
							<c:if test="${((addAdultPrice + addChildPrice) eq 0) and (searchVO.sBabyCnt > (result.stdMem - searchVO.sAdultCnt - searchVO.sChildCnt))}">
								<c:set var="addBabyPrice" value="${(searchVO.sBabyCnt - (result.stdMem - searchVO.sAdultCnt - searchVO.sChildCnt)) * babyAddAmt }"/>
							</c:if>

							<input type="hidden" id="addAdultAmt${prdtCnt}" value="${addAdultPrice * searchVO.sNights }" />
							<input type="hidden" id="addChildAmt${prdtCnt}" value="${addChildPrice * searchVO.sNights }" />
							<input type="hidden" id="addBabyAmt${prdtCnt}" value="${addBabyPrice * searchVO.sNights }" />

							<div class="price">
								<c:if test="${not empty result.saleAmt && result.ableRsvNum > 0  && dayRsvCnt != '0' }">
									<c:if test="${result.saleAmt ne result.nmlAmt}">
										<span class="memo"><del><fmt:formatNumber value="${result.nmlAmt}"/></del></span>
									</c:if>
									<fmt:formatNumber value="${result.saleAmt }"/><span>원</span>
								</c:if>
							</div>
							<div class="bxLabel">
								<c:if test="${result.eventCnt > 0}">
									<span class="main_label eventblue">이벤트</span>
								</c:if>
								<c:if test="${result.couponCnt > 0}">
									<span class="main_label pink">할인쿠폰</span>
								</c:if>
								<c:if test="${(result.daypriceYn == 'Y') and (result.disDaypriceAmt > 0)}">
									<span class="main_label pink">당일특가</span>
									<span class="main_label price-red"><fmt:formatNumber value="${result.disDaypriceAmt}"/>원 <c:if test="${result.saleAmt ne result.nmlAmt}">추가</c:if>할인</span>
								</c:if>
								<c:if test="${(result.ctnAplYn == 'Y') and (result.ctnAmt > 0)}">
									<span class="main_label back-red">연박할인</span>
									<span class="main_label price-red"><fmt:formatNumber value="${result.ctnAmt}"/>원 <c:if test="${result.saleAmt ne result.nmlAmt}">추가</c:if>할인</span>
								</c:if>
								<c:if test="${result.tamnacardYn eq 'Y'}"><span class="main_label yellow">탐나는전</span></c:if>
							</div>
							<div class="inline-typeA">
								<dl class="add-detail">
									<dt>
										<img class="img_width8" src="../../images/mw/icon/user_r.png" alt="기준인원">이용 인원수
									</dt>

									<c:if test="${result.memExcdAbleYn == 'Y'}">
										<dd>기준 <span id="stdMem${prdtCnt}">${result.stdMem }</span>인 / 최대 <span id="maxMem${prdtCnt}">${result.maxiMem }</span>인</dd>
									</c:if>
									<c:if test="${result.memExcdAbleYn != 'Y'}">
										<dd>기준 <span id="stdMem${prdtCnt}">${result.stdMem }</span>인 / 최대 <span id="maxMem${prdtCnt}">${result.stdMem }</span>인</dd>
									</c:if>
								</dl>
								<dl class="add-detail breakfast">
									<dt>
										<img class="img_width10" src="../../images/mw/icon/coffee.png" alt="조식">조식
									</dt>
									<dd>
										<c:choose>
											<c:when test="${result.breakfastYn == 'Y'}">포함</c:when>
											<c:otherwise>불포함</c:otherwise>
										</c:choose>
									</dd>
								</dl>
								<c:if test="${result.addamtYn == 'Y'}">
									<c:if test="${(result.adultAddAmt != '0') or (result.juniorAddAmt != '0') or (result.childAddAmt != '0')}">
										<dl class="add-detail fee-icon">
											<img class="img_width11" src="../../images/mw/icon/money.png" alt="추가요금">
											<dt>추가요금(1일 1인)</dt>
											<dd>성인: ${result.adultAddAmt}원, 소아: ${result.juniorAddAmt}원, 유아: ${result.childAddAmt}원</dd>
										</dl>
									</c:if>
								</c:if>
							</div>
							<c:if test="${chkPointBuyAble eq 'Y'}">
								<c:if test="${empty result.saleAmt || result.ableRsvNum <= 0 || dayRsvCnt == '0' }">
								<div class="another-btn">
									<button class="room-reservation another" onclick="fn_ShowLayer('${result.prdtNum}');return false;">예약마감 ／ 다른날짜로 예약하기</button>
								</div>
								</c:if>
								<c:if test="${not empty result.saleAmt && result.ableRsvNum > 0 && dayRsvCnt != '0' }">
								<div class="reservation-btn">
									<button class="room-reservation" onclick="fn_ShowLayer('${result.prdtNum}');return false;">예약하기</button>
								</div>
								</c:if>
							</c:if>
							<c:if test="${chkPointBuyAble ne 'Y'}">
								<div class="another-btn">
									<button class="room-reservation another">구매불가</button>
								</div>
							</c:if>
						</div>
					</div> <!-- //room-group -->
					</c:if>
				</c:forEach>
				</div> <!-- //room-area -->
			</section> <!-- //room-option -->
			<!-- //0112 숙소 구매 상세페이지 개선 -->

			<section class="map-info-area">
				<h2 class="title-type4">위치 정보</h2>
				<div class="map-area" id="sighMap">
					<!-- 기존코드 동일 -->
				</div>
				<script type="text/javascript">
					//동적 지도 ( 움직이는 지도.)
					var container2 = document.getElementById('sighMap');
					var options2 = {
						center: new daum.maps.LatLng(${corpVO.lat}, ${corpVO.lon}),
						//center: new daum.maps.LatLng(33.4888341, 126.49807970000006),
						level: 6
					};

					var map2 = new daum.maps.Map(container2, options2);
					var positions = [];

					// 현재 위치.
					//마커가 표시될 위치입니다
					var c_markerPosition  = new daum.maps.LatLng(${corpVO.lat}, ${corpVO.lon});
					var c_imageSrc = "<c:url value='/images/web/icon/location_my.png'/>";
					var c_imageSize = new daum.maps.Size(24, 35);
					var c_markerImage = new daum.maps.MarkerImage(c_imageSrc, c_imageSize);
					// 마커를 생성합니다
					var marker = new daum.maps.Marker({
						map : map2,
						position: c_markerPosition,
						image : c_markerImage
					});

					function setMove(lat, lon) {
						var moveLatLon = new daum.maps.LatLng(lat, lon);
						map2.setLevel(4);
						map2.panTo(moveLatLon);
					}
				</script>
				<div class="caption-typeA">
					<p>전화번호 : <a href="tel:${webdtl.rsvTelNum}">${webdtl.rsvTelNum}</a></p>
					주소 : <span id="addr"><c:out value="${webdtl.roadNmAddr}"/> <c:out value="${webdtl.dtlAddr}"/></span>
					<button class="comm-btn blue sm btnCopy" data-clipboard-target="#addr">주소복사</button>
				</div>
			</section> <!-- //map-info-area -->
			<div class="nav-tabs2">
				<div class="menu-wrap">
					<ul id="scroll_tabs"  class="nav-menu">
						<li class="active"><a href="#tabs-info">상품설명</a></li>
						<li><a href="#tabs-cancel">취소/환불</a></li>
						<li><a href="#tabs-review">이용후기</a></li>
						<li><a href="#tabs-counsel">1:1문의</a></li>
					</ul>
				</div>

				<div id="tabs-info" class="tabPanel">
					<div class="text-groupA">
						<c:if test="${fn:length(prmtList) > 0}">
							<!-- 프로모션 추가 -->
							<c:forEach var="prmt" items="${prmtList}">
								<div class="promotion-detail">
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
									<c:if test="${not empty fn:trim(prmt.dtlImg)}">
										<div class="photo">
											<img src="${prmt.dtlImg}" alt="${prmt.prmtNm}">
										</div>
									</c:if>
								</div> <!-- //promotion-detail -->
							</c:forEach>
							<!-- //프로모션 추가 -->
						</c:if>

						<c:if test="${not empty webdtl.sccUrl}">
							<div class="video-area">
								<lite-youtube videoid="${fn:replace(webdtl.sccUrl, 'https://www.youtube.com/embed/', '')}" playlabel="${webdtl.adNm} 유튜브영상"></lite-youtube>
							</div>
							<%--	
							<div class="video-area">
								<iframe title="${webdtl.adNm} 유튜브영상" width="100%" height="276" src="${webdtl.sccUrl}" allowfullscreen></iframe>
							</div>
							--%>
						</c:if>
						<dl>
							<dt class="title-type3">TIP</dt>
							<dd class="type-body1">
								<c:out value="${webdtl.tip}" escapeXml="false"/>
							</dd>
						</dl>
						<dl class="inline">
							<dt class="title-type3">입실 시간</dt>
							<dd class="type-body1"><c:out value="${webdtl.chkinTm}"/></dd>
						</dl>
						<dl class="inline">
							<dt class="title-type3">퇴실 시간</dt>
							<dd class="type-body1"><c:out value="${webdtl.chkoutTm}"/></dd>
						</dl>
						<dl>
							<dt class="title-type3">편의 시설</dt>
							<dd class="type-body1">
								<div class="icon-info-typeA">
									<ul>
										<c:forEach var="icon" items="${iconCdList}">
											<c:choose>
												<c:when test="${icon.checkYn eq 'Y'}">
													<c:set var="flag" value="on" />
												</c:when>
												<c:otherwise>
													<c:set var="flag" value="off" />
												</c:otherwise>
											</c:choose>
											<li class="${flag}">
												<p class="icon"><img src="<c:url value='/images/web/ad/${icon.iconCd}.png' />" loading="lazy" alt="${icon.iconCdNm}"></p>
												<p class="text">${icon.iconCdNm}</p>
											</li>
										</c:forEach>
									</ul>
								</div>
							</dd>
						</dl>
						<dl>
							<dt class="title-type3">숙소소개</dt>
							<dd class="type-body1">
								<c:out value="${webdtl.infIntrolod}" escapeXml="false"/>
							</dd>
						</dl>
						<dl>
							<dt class="title-type3">객실 비품안내</dt>
							<dd class="type-body1">
								<c:out value="${webdtl.infEquinf}" escapeXml="false"/>
							</dd>
						</dl>
						<dl>
							<dt class="title-type3">이용안내</dt>
							<dd class="type-body1">
								<c:out value="${webdtl.infOpergud}" escapeXml="false"/>
							</dd>
						</dl>
						<dl>
							<dt class="title-type3">참고사항(특전사항)</dt>
							<dd class="type-body1">
								<c:out value="${webdtl.infNti}" escapeXml="false"/>
							</dd>
						</dl>
						<dl>
							<dt class="title-type3">연령기준</dt>
							<dd class="type-body1">
								성인 : <c:out value="${webdtl.adultAgeStd}" escapeXml="false"/><br>
								소아 : <c:out value="${webdtl.juniorAgeStd}" escapeXml="false"/><br>
								유아 : <c:out value="${webdtl.childAgeStd}" escapeXml="false"/>
							</dd>
						</dl>
						<c:if test="${corpVO.superbCorpYn eq 'Y'}">
							<dl>
								<dt class="title-type3">우수관광업체</dt>
								<dd class="type-body1">
									<img src="/images/web/icon/excellence_02.jpg" loading="lazy" class="excellence" alt="우수관광사업체">
								</dd>
							</dl>
						</c:if>
						<c:if test="${not empty corpVO.visitMappingId}">
							<dl>
								<dt class="title-type3">주변 관광지 알아보기</dt>
								<dd class="type-body1">
									<a href="https://m.visitjeju.net/kr/detail/view?contentsid=${corpVO.visitMappingId}&newopen=yes#tmap" class="link" target="_blank">
										<img src="/images/mw/institution/visit-jeju.jpg" loading="lazy" alt="visit jeju">
									</a>
								</dd>
							</dl>
						</c:if>
					</div> <!-- //text-groupA -->
				</div> <!-- //tabs-info -->

				<div id="tabs-cancel" class="tabPanel">
					<div class="text-groupA">
						<dl>
							<dt class="title-type3">취소/환불</dt>
							<dd class="type-body1">
								<c:out value="${webdtl.cancelGuide}" escapeXml="false"/>
							</dd>
						</dl>
					</div> <!-- //text-groupA -->
				</div> <!-- //tabs-cancel -->

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
						</div> <!-- //counsel -->
					</div>
				</div> <!-- //tabs-counsel -->
			</div>

			<section class="recommend-product">
				<h2 class="sec-caption">추천 상품</h2>
				<div class="recommend-group">
					<div class="title-side-area">
						<div class="l-area">
							<h3 class="title-type2">주변 추천 숙소</h3>
						</div>
						<div class="r-area icon">
							<a href="<c:url value='/mw/map.do' />">
								<img src="/images/mw/icon/option-map.png" alt="지도보기">
							</a>
						</div>
					</div>
					<div class="promotion-content">
						<div id="promotion_product" class="swiper-container">
							<ul class="swiper-wrapper">
								<c:forEach var="data" items="${listDist}" varStatus="status">
									<li class="swiper-slide">
										<div class="photo">
											<%-- <a href="javascript:void(0)" onclick="fn_DetailPrdt('${data.prdtNum}', '${data.corpCd}');"> --%>
											<span onclick="fn_DetailPrdt('${data.prdtNum}', '${data.corpCd}');">
												<img src="${data.savePath}thumb/${data.saveFileNm}" loading="lazy" class="product" alt="${data.adNm}">
											</span>
										</div>
										<div class="text">
											<div class="title">${data.adNm}</div>
											<div class="info">
												<dl>
													<dt></dt>
													<dd>
														<div class="price">
															<c:if test="${not empty data.saleAmt}">
																<del><fmt:formatNumber value="${data.nmlAmt}" />원</del>
																<strong><fmt:formatNumber value="${data.saleAmt}" />원~</strong>
															</c:if>
															<c:if test="${empty data.saleAmt}">
																<span class="text__deadline">예약마감</span>
															</c:if>
														</div>
													</dd>
												</dl>
<%--												<div class="like">--%>
<%--													<c:if test="${not empty pocketMap[data.corpId] }">--%>
<%--														<a href="javascript:void(0)">--%>
<%--															<img src="/images/web/icon/product_like_on.png" alt="찜하기">--%>
<%--														</a>--%>
<%--													</c:if>--%>
<%--													<c:if test="${empty pocketMap[data.corpId] }">--%>
<%--														<a href="javascript:void(0)" id="pocket${data.corpId }" onclick="fn_listAddPocket('${Constant.ACCOMMODATION}', '${data.corpId }', ' ')">--%>
<%--															<img src="/images/web/icon/product_like_off.png" alt="찜하기">--%>
<%--														</a>--%>
<%--													</c:if>--%>
<%--												</div>--%>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div> <!-- //recommend-group -->
			</section> <!-- //recommend-product -->

		   <!-- SNS 링크 -->
			<div id="sns_popup" class="sns-popup">
				<a type="button" class="close" href="javascript:itemSingleHide('#sns_popup');" >
					<img src="<c:url value='/images/mw/rent/close-btn.png' />" loading="lazy" alt="닫기">
				</a>
				<div class="sns-area">
					<ul>
						<li>
							<%-- <a href="javascript:void(0)" onclick="shareKakao('<c:out value='${webdtl.adNm}' />', '${imgUrl}', '${strUrl}'); snsCount('${webdtl.corpId}', 'MO', 'KAKAO');" id="kakao-link-btn"> --%>
							<a onclick="shareKakao('<c:out value='${webdtl.adNm}' />', '${imgUrl}', '${strUrl}'); snsCount('${webdtl.corpId}', 'MO', 'KAKAO');" id="kakao-link-btn">
								<img src="/images/mw/icon/sns/kakaotalk.png" loading="lazy" alt="카카오톡">
								<span>카카오톡</span>
							</a>
						</li>
						<li>
							<%-- <a href="javascript:void(0)" onclick="shareFacebook('${strUrl}'); snsCount('${webdtl.corpId}', 'MO', 'FACEBOOK');"> --%>
							<a onclick="shareFacebook('${strUrl}'); snsCount('${webdtl.corpId}', 'MO', 'FACEBOOK');" id="facebook-link-btn">
								<img src="/images/mw/icon/sns/facebook.png" loading="lazy" alt="페이스북">
								<span>페이스북</span>
							</a>
						</li>
			<%--			<li>
							&lt;%&ndash; <a href="javascript:void(0)" onclick="shareStory('${strUrl}'); snsCount('${webdtl.corpId}', 'MO', 'KAKAO');"> &ndash;%&gt;
							<a onclick="shareStory('${strUrl}'); snsCount('${webdtl.corpId}', 'MO', 'KAKAO');" id="story-link-btn">
								<img src="/images/mw/icon/sns/kakaostory.png" loading="lazy" alt="카카오 스토리">
								<span>카카오 스토리</span>
							</a>
						</li>--%>
						<li>
							<%-- <a href="javascript:void(0)" onclick="shareBand('${strUrl}'); snsCount('${webdtl.corpId}', 'MO', 'BAND');"> --%>
							<a onclick="shareBand('${strUrl}'); snsCount('${webdtl.corpId}', 'MO', 'BAND');" id="band-link-btn">
								<img src="/images/mw/icon/sns/band.png" loading="lazy" alt="네이버밴드">
								<span>네이버 밴드</span>
							</a>
						</li>
						<li>
							<%-- <a href="javascript:void(0)" onclick="shareLine('${strUrl}'); snsCount('${webdtl.corpId}', 'MO', 'LINE');"> --%>
							<a onclick="shareLine('${strUrl}'); snsCount('${webdtl.corpId}', 'MO', 'LINE');" id="line-link-btn">
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

	<!-- 이용후기 사진 레이어 팝업 (클릭시 호출) -->
	<div class="review-gallery">
	</div>
	<!-- 날짜별 객실요금 레이어 팝업 (클릭시 호출) -->
	<div class="option-wrap"></div>
	
<script type="text/javascript" src="<c:url value='/js/mw_useepil.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/mw_otoinq.js?version=${nowDate}'/>"></script>
<!--  <script type="text/javascript" src="<c:url value='/js/mw_bloglink.js?version=${nowDate}'/>"></script> -->
<script type="text/javascript" src="<c:url value='/js/mw_adDtlCalendar.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/clipboard.min.js?version=${nowDate}' />"></script>

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>
<script type="text/javascript">
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
				paginationType: 'fraction'
			});
		}

		//주변 숙소
		if($('#promotion_product .swiper-slide').length > 1) {
			var swiper = new Swiper('#promotion_product', {
				slidesPerView: 'auto',
				paginationClickable: true,
				spaceBetween: 15
			});
		}

		//Tab Menu (상품설명, 사용조건 등)
		targetTabMenu('#scroll_tabs');

		//룸 갤러리 다중 Slide
		if($('.room-slide').length >= 1) {
			$( ".room-slide" ).each(function(index) {
				$(this).addClass('room-gallery'+index);
				if($('.swiper-slide', this).length > 1) {
					var swiper = new Swiper('.room-gallery'+index, {
						slidesPerView: 'auto',
						paginationClickable: true,
						spaceBetween: 10
					});
				}
			});
		}

		//숙소
		if($('#detail_slider .swiper-slide').length > 1) {
			new Swiper('#detail_slider', {
				pagination: '#detail_paging',
				paginationType: 'fraction',
				loop: true
			});
		}

		//주변 숙소
		if($('#promotion_product .swiper-slide').length > 1) {
			new Swiper('#promotion_product', {
				slidesPerView: 'auto',
				paginationClickable: true,
				spaceBetween: 15
			});
		}

		//Tab Menu (상품설명, 사용조건 등)
		targetTabMenu('#scroll_tabs');

		//룸 갤러리 다중 Slide
		if($('.room-slide').length >= 1) {
			$(".room-slide").each(function(index) {
				$(this).addClass('room-gallery' + index);

				if($('.swiper-slide', this).length > 1) {
					new Swiper('.room-gallery' + index, {
						slidesPerView: 'auto',
						paginationClickable: true,
						spaceBetween: 10
					});
				}
			});
		}

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
				<c:if test="${(not empty result.saleAmt) and (maxMem >= (searchVO.sAdultCnt + searchVO.sChildCnt + searchVO.sBabyCnt)) }">
					<c:set var="rsvAbleNum" value="${rsvAbleNum + 1 }" />
				</c:if>
			</c:forEach>
		</c:if>

		//-이용 후기 관련 설정 --------------------
		g_UE_getContextPath = "${pageContext.request.contextPath}";
		g_UE_corpId		="${webdtl.corpId}";						//업체 코드 - 넣어야함
		g_UE_prdtnum 	="${searchVO.sPrdtNum}";					//상품번호  - 넣어야함
		g_UE_corpCd 	="${Constant.ACCOMMODATION}";				//숙박/랜트.... - 페이지에 고정

		//이용후기 상단 평점/후기수, 탭 숫자 변경(서비스로 사용해도됨)
		fn_useepilInitUI();
		// * 서비스 사용시 GPAANLSVO ossUesepliService.selectByGpaanls(GPAANLSVO) 사용

		//이용후기 리스트 뿌리기 -> 해당 탭버튼 눌렀을때 호출하면됨
		fn_useepilList();
		//---------------------------------------------------

		//-1:1문의 관련 설정 --------------------------------
		g_Oto_getContextPath = "${pageContext.request.contextPath}";
		g_Oto_corpId	="${webdtl.corpId}";						//업체 코드 - 넣어야함
		g_Oto_prdtnum 	="${searchVO.sPrdtNum}";					//상품번호  - 넣어야함
		g_Oto_corpCd 	="${Constant.ACCOMMODATION}";				//숙박/랜트.... - 페이지에 고정

		//1:1문의 리스트 뿌리기 -> 해당 탭버튼 눌렀을때 호출하면됨
		fn_otoinqList();
		//---------------------------------------------------

		// 총 요금 산출
		accountTotAmt();

		// 주소복사
		var clipboard = new ClipboardJS(".btnCopy");

		clipboard.on('success', function(e) {
			alert("클립보드에 주소가 복사됐습니다.");
			e.clearSelection();
		});

		clipboard.on('error', function(e) {
			alert("주소복사에 실패했습니다.");
		});
	});

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

		fn_AddPocket(pocket,'adDetail');
	}

	function fn_adAddSale() {
		<c:if test="${searchVO.sSearchYn eq 'N'}">
		alert('날짜를 선택해 주세요.');
		return false;
		</c:if>

		var nCnt = 0;
		$('input[name=chkRoom]').each(function() {
			if (this.checked) {
				nCnt++;
			}
		});

		if(nCnt == 0) {
			alert("객실을 선택해주세요.");
			return;
		}

		var cart = [];
		$('input[name=chkRoom]').each(function() {
			if (this.checked) {
				var sId = $(this).attr("id");
				var addAmt = eval($('#addAdultAmt' + sId).val()) + eval($('#addChildAmt' + sId).val()) + eval($('#addBabyAmt' + sId).val());

				for (var i=0; i<$('#cntNum' + sId).text(); i++) {
					cart.push({
						prdtNum 	: $(this).val(),
						prdtNm 		: $('#prdtNm' + sId).text(),
						corpId 		: "<c:out value='${webdtl.corpId}'/>",
						corpNm 		: "<c:out value='${corpVO.corpNm}'/>",
						prdtDivNm 	: "${Constant.ACCOMMODATION}",
						//fromDt 		: $('input[name=adPE_sFromDt]').eq(index).val(),
						startDt		: "<c:out value='${searchVO.sFromDt}'/>",
						night 		: "<c:out value='${searchVO.sNights}'/>",
						adultCnt 	: "<c:out value='${searchVO.sAdultCnt}'/>",
						juniorCnt 	: "<c:out value='${searchVO.sChildCnt}'/>",
						childCnt 	: "<c:out value='${searchVO.sBabyCnt}'/>",
						adOverAmt 	: addAmt
					});
				}
			}
		});

		fn_InstantBuy(cart);
		AM_PRODUCT(1);//모바일 에이스 카운터 추가 2017.04.25
	}


	//인원수 변경 이벤트
	function chg_person(type, gubun) {
		var num = 0;
		if (type == '+') {
			num = eval($('#' + gubun + 'Num').text()) + 1;
		} else {
			num = eval($('#' + gubun + 'Num').text()) - 1;
		}
		// 최저 인원 수 - 성인 : 1, 소아&유아 : 0
		if (gubun == 'Adult') {
			if (num < 1) {
				num = 1;
			} else if (num > 30) {
				num = 30;
			}
		} else {
			if (num < 0) {
				num = 0;
			} else if (num > 30) {
				num = 30;
			}
		}
		$('#' + gubun + 'Num').text(num);
		$('input[name=s' + gubun + 'Cnt]').val(num);

		var sMen = eval($('#AdultNum').text()) + eval($('#ChildNum').text()) + eval($('#BabyNum').text());
		$('#sMen').val(sMen);

		modify_room_person();
	}

	//객실 개수 변경
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

		$('#disPriceAmtStr' + pos).text(commaNum(ctnAmt + disDaypriceAmt));
		$('#oriSaleAmt' + pos).text(commaNum(saleAmt));
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
			totalAmtStr += '[${searchVO.sNights }박] ';
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

		if(roomTotalCnt){
			$("#totalRoomCnt").html("총 상품금액" + "(" + roomTotalCnt + "객실" + ")");
		}else{
			$("#totalRoomCnt").html("총 상품금액");
		}
		// 쿠폰리스트 체크
		fn_chkCouponList();
	}

	function fn_selOptionShow(obj) {
		var pos = obj.id;

		if (obj.checked) {
			var option_str = '<div class="selected-group" id="selPrdtId' + pos + '">';
			option_str += '		<div class="text-area">';
			option_str += '			<p>' + $('#adPrdtNm' + pos).text() + '</p>';
			option_str += '		</div>';
			option_str += '		<div class="counting-area">';
			option_str += '			<div class="item-count-area">';
			option_str += '		    	<button type="button" class="counting-btn" id="cntMinus' + pos + '" onclick="applyCntPrice(\'-\', \'' + pos + '\');"><img src="/images/mw/icon/subtraction2.png" alt="빼기"></button>';
			option_str += '		    	<span class="counting-text" id="cntNum' + pos + '">1</span>';
			option_str += '		    	<button type="button" class="counting-btn" id="cntPlus' + pos + '" onclick="applyCntPrice(\'+\', \'' + pos + '\');"><img src="/images/mw/icon/addition2.png" alt="더하기"></button>';
			option_str += '			</div>';
			option_str += '		<div class="price"><span id="saleAmtStr' + pos + '">' + $('#adPrdtAmt' + pos).text() + '</span>원</div>';
			option_str += '		<button type="button" class="del" onclick="fn_delOption(\'' + pos + '\');"><img src="/images/mw/icon/del/option.png" alt="삭제"></button>';
			option_str += '		</div>';
			option_str += '</div>';

			$('#adOptionDiv').append(option_str);
		} else {
			$('#selPrdtId' + pos).remove();
		}
		accountTotAmt();
	}

	// 객실 선택 삭제
	function fn_delOption(objId) {
		$('#' + objId).prop('checked', false);
		$('#selPrdtId' + objId).remove();

		accountTotAmt();
	}

	function fn_DetailPrdt(prdtNum, corpCd) {
		$("#sPrdtNum").val(prdtNum);
		$("#prdtNum").val(prdtNum);
		//	document.frm.target = "_blank";
		if(corpCd == "${Constant.ACCOMMODATION}") {
			document.frm.action = "<c:url value='/mw/ad/detailPrdt.do'/>";
			document.frm.submit();
		} else {
			document.frm.action = "<c:url value='/mw/sp/detailPrdt.do'/>";
			document.frm.submit();
		}
	}

	//쿠폰 리스트 체크
	function fn_chkCouponList() {
		var copNum = 0;
		var amt = eval(fn_replaceAll($("#adTotalPrice").text(), ",", ""));

		$('.useCouponList').each(function() {
			if (amt < $(this).attr('minAmt')) {
				$(this).addClass('hide');
			} else {
				copNum++;
				$(this).removeClass('hide');
			}
		});

		if (copNum == 0) {
			$("#useAbleCoupon").addClass('hide');
		} else {
			$("#useAbleCoupon").removeClass('hide');
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

	function goCouponCode() {
		if(confirm("<spring:message code='confirm.coupon.code' />")){
			location.href = "<c:url value='/mw/mypage/couponList.do' />";
		}
	}

	function fn_ImgList(selectCnt) {
		$("body").bind('touchmove', function(e){e.preventDefault()});
		$("body").css('overflow','hidden');

		$(".detail-slider.roomType").addClass("active");

		var loopCnt = "${fn:length(prdtList)}";

		for(var i = 1; i <= loopCnt; ++i) {
			$("#detail_slider" + i).hide();
		}
		$("#detail_slider" + selectCnt).show();

		new Swiper("#detail_slider" + selectCnt, {
			pagination: "#detail_paging" + selectCnt,
			paginationType: "fraction",
			nextButton: "#detail_next" + selectCnt,
			prevButton: "#detail_prev" + selectCnt,
			loop: true
		});
	}

	function topClose(cnt) {
		$("body").unbind('touchmove');
		$("body").css('overflow','visible');

		$("#detail_slider" + cnt).hide();
	}

	<!--20220110_예약옵션설정-->
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
			url       : "<c:url value='/mw/adRoomOptionLayer.ajax'/>",
			data      : parameters,
			success   : function (data) {
				$('.option-wrap').html(data);

				//옵션 닫기
				$('.option-change .btn-close').click(function(){
					$('.option-wrap .option-change').fadeOut();
					$('.option-wrap').html("");
					$('.option-change1, #cover').fadeToggle();
					return false;
				});

				$('.option-wrap .option-change').fadeIn();
			},
			error     : fn_AjaxError
		});
	}
</script>

<!-- 푸터 s -->
<jsp:include page="/mw/foot.do" />
<!-- 푸터 e -->

</div> <!-- //wrap -->

<%-- 모바일 에이스 카운터 추가 2017.04.25 --%>
<!-- *) 제품상세페이지 분석코드 -->
<!-- AceCounter Mobile eCommerce (Product_Detail) v7.5 Start -->
<script language='javascript'>
	var m_pd ="<c:out value="${webdtl.adNm }"/>";
	var m_ct ="숙소";

	<c:forEach var="result" items="${prdtList}" varStatus="status">
	<c:if test="${status.index == 0 }">
	<c:if test="${empty result.saleAmt }"><c:set var="strSalAmt" value="미정" /></c:if>
	<c:if test="${not empty result.saleAmt }"><c:set var="strSalAmt" value="${result.saleAmt }" /></c:if>
	</c:if>
	</c:forEach>

	var m_amt="${strSalAmt}";
</script>
<!-- AceCounter Mobile WebSite Gathering Script V.7.5.20170208 -->
<script language='javascript'>
	var _AceGID=(function(){var Inf=['tamnao.com','m.tamnao.com,www.tamnao.com,tamnao.com','AZ3A70537','AM','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;if(_CI.join('.').indexOf(Inf[3])<0){ _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
	var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement('script');var _sm=document.getElementsByTagName('script')[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,'_');_sc.src=(location.protocol.indexOf('http')==0?location.protocol:'http:')+'//cr.acecounter.com/Mobile/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<noscript><img src='https://gmb.acecounter.com/mwg/?mid=AZ3A70537&tp=noscript&ce=0&' border='0' width='0' height='0' alt=''></noscript>
<!-- AceCounter Mobile Gathering Script End -->

</body>
</html>
