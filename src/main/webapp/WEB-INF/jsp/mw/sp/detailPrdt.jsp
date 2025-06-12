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
<c:if test="${fn:length(prdtImg) == 0}">
	<c:set var="seoImage" value=""/>
</c:if>
<c:if test="${fn:length(prdtImg) != 0}">
	<c:set var="seoImage" value="${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}"/>
</c:if>
<c:set var="strServerName" value="${pageContext.request.serverName}"/>
<c:set var="strUrl" value="${pageContext.request.scheme}://${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?prdtNum=${prdtInfo.prdtNum}&prdtDiv=${prdtInfo.prdtDiv}"/>
<c:set var="imgUrl" value="${pageContext.request.scheme}://${strServerName}${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}"/>

<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="${prdtInfo.prdtNm} - 제주도 공공플랫폼 탐나오"/>
	<jsp:param name="description" value="${prdtInfo.prdtInf}. 탐나오는 제주도가 지원하고 제주관광협회가 운영하는 믿을 수 있는 곳. 탐나오와 함께라면 안전한 예약이 가능합니다."/>
	<jsp:param name="keywordsLinkNum" value="${prdtInfo.prdtNum}"/>
	<jsp:param name="keywordAdd1" value="${prdtInfo.prdtNm}"/>
	<jsp:param name="imagePath" value="${seoImage}"/>
</jsp:include>
<meta property="og:title" content="<c:out value='${prdtInfo.prdtNm}' />" />
<meta property="og:url" content="${strUrl}" />
<meta property="og:description" content="<c:out value='${prdtInfo.prdtNm}'/> - <c:out value='${prdtInfo.prdtInf}'/>" />
<c:if test="${fn:length(prdtImg) != 0}">
<meta property="og:image" content="${imgUrl}" />
</c:if>
<c:if test="${fn:length(prdtImg) == 0}">
<meta property="og:image" content="${prdtInfo.apiImgThumb}" />
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
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/swiper.css?version=${nowDate}'/>" /> --%>

<c:if test="${not empty prdtInfo.adMov}">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/lite-yt-embed.css?version=${nowDate}'/>" />
<script type="text/javascript" src="<c:url value='/js/lite-yt-embed.js?version=${nowDate}'/>"></script>
</c:if>
<link rel="canonical" href="https://www.tamnao.com/web/sp/detailPrdt.do?prdtNum=${prdtInfo.prdtNum}">

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>
<c:if test="${gpaVO.gpaCnt ne null}">
<script type="application/ld+json">
{
	"@context": "https://schema.org/",
    "@type": "Product",
    "name": "[제주여행] ${prdtInfo.prdtNm}",
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
<script type="application/ld+json">
	{
		"@context": "https://schema.org",
		"@type": "BreadcrumbList",
		"itemListElement": [
			{
				"@type": "ListItem",
				"position": 1,
				"item": {
					"@id": "https://www.tamnao.com/",
					"name": "메인"
				}
			},
			{
				"@type": "ListItem",
				"position": 2,
				"item": {
					"@id": "https://www.tamnao.com/mw/sp/detailPrdt.do?prdtNum=${prdtInfo.prdtNum}",
					<c:if test="${(fn:substring(prdtInfo.ctgr, 0,2) eq 'C1') or (fn:substring(prdtInfo.ctgr, 0,2) eq 'C4')}">
					"name": "여행사 상품"
					</c:if>
					<c:if test="${fn:substring(prdtInfo.ctgr, 0,2) eq 'C2'}">
					"name": "관광지/레저"
					</c:if>
					<c:if test="${fn:substring(prdtInfo.ctgr, 0,2) eq 'C3'}">
					"name": "맛집"
					</c:if>
					<c:if test="${fn:substring(prdtInfo.ctgr, 0,2) eq 'C5'}">
					"name": "유모차/카시트"
					</c:if>

				}
			}
		]
	}
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>
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
					<c:if test="${prdtInfo.lsLinkYn ne 'Y'}">
						<div class="swiper-wrapper">
							<c:forEach items="${prdtImg}" var="imgInfo" varStatus="status">
								<div class="swiper-slide">
									<c:choose>
										<c:when test="${status.count < 2}">
											<img src="<c:url value='${imgInfo.savePath}thumb/${imgInfo.saveFileNm}' />" alt="${prdtInfo.prdtNm}">
										</c:when>
										<c:otherwise>
											<img src="<c:url value='${imgInfo.savePath}thumb/${imgInfo.saveFileNm}' />" loading="lazy" alt="${prdtInfo.prdtNm}">
										</c:otherwise>
									</c:choose>
								</div>
							</c:forEach>
						</div>
						<c:if test="${fn:length(prdtImg) > 1}">
							<div id="detail_paging" class="swiper-pagination"></div>
						</c:if>
					</c:if>
					<c:if test="${prdtInfo.lsLinkYn eq 'Y'}">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<img src="${prdtInfo.apiImgThumb}" alt="${prdtInfo.prdtNm}">
							</div>
						</div>
					</c:if>
			    </div>
			</div> <!-- //detail-slider -->
			<div class="product-info">
				<div class="title-area">
					<div class="memo"><c:out value="${prdtInfo.prdtInf}" /></div>
    				<div class="title"><c:out value="${prdtInfo.prdtNm}"/></div>
					<div class="grade-area">
						<div class="score-area">
						</div>
						<div class="bxLabel">
							<c:if test="${prdtInfo.eventCnt > 0}">
								<span class="main_label eventblue">이벤트</span>
							</c:if>
							<c:if test="${prdtInfo.couponCnt > 0}">
								<span class="main_label pink">할인쿠폰</span>
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
						<strong><fmt:formatNumber value='${prdtInfo.saleAmt}' type='number' /><c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">~</c:if><span class="won">원</span></strong>
	                    <del><fmt:formatNumber value='${prdtInfo.nmlAmt}' type='number' />원</del>
	                </div>
                </div>
			</div> <!-- //product-info -->
			
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
										<span class="text-gray"><fmt:formatNumber>${coupon.buyMiniAmt}</fmt:formatNumber>원 이상 구매시<br>사용 가능</span>
									</div>
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
	  	<c:if test="${(fn:substring(prdtInfo.ctgr, 0, 2) ne 'C1') and (prdtInfo.ctgr ne 'C420') and (not empty prdtInfo.lat) and (not empty prdtInfo.lon)}">
			<section class="map-info-area">
				<h2 class="title-type4">위치 정보</h2>
				<div class="map-area" id="mapTab" >
				</div>
				<script type="text/javascript">
					//동적 지도 ( 움직이는 지도.)
					var container = document.getElementById("mapTab");
					var options = {
						center: new daum.maps.LatLng(${prdtInfo.lat}, ${prdtInfo.lon}),
						level: 3
					};
	
					var map = new daum.maps.Map(container, options);
					//마커가 표시될 위치입니다
					var markerPosition  = new daum.maps.LatLng(${prdtInfo.lat}, ${prdtInfo.lon});
					// 마커를 생성합니다
					var marker = new daum.maps.Marker({
						position: markerPosition
					});
					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
				</script>
				<!-- <div class="caption-typeA">주소 : 제주특별자치도 서귀포시 뭐시기뭐시기무시기</div> -->
			</section> <!-- //map-info-area -->
	  	</c:if>
		<div class="nav-tabs2">
		    <div class="menu-wrap">
		        <ul id="scroll_tabs"  class="nav-menu">
		            <li class="active"><a href="#tabs-info">상품설명</a></li>
		            <li><a href="#tabs-terms">사용정보</a></li>
		          	<c:if test="${not empty prdtInfo.cancelGuide}">
		            	<li><a href="#tabs-cancel">취소/환불</a></li>
		          	</c:if>
		            <li><a href="#tabs-review">이용후기</a></li>
		            <li><a href="#tabs-counsel">1:1문의</a></li>
		        </ul>
		    </div>
		
		    <div id="tabs-info" class="tabPanel">
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
									<img src='<c:url value="${prmt.dtlImg}" />' alt="${prmt.prmtNm}">
								</div>
							</c:if>
						</div> <!-- //promotion-detail -->
					</c:forEach>
					<!-- //프로모션 추가 -->
			  	</c:if>

				<c:if test="${prdtInfo.lsLinkYn ne 'Y'}">
					<c:if test="${not empty dtlImg[0].savePath}">
					<div class="image-groupA">
					<img src="<c:url value='${dtlImg[0].savePath}${dtlImg[0].saveFileNm}' />" loading="lazy" alt="상품상세">
					</div>
					</c:if>
				</c:if>
				<c:if test="${prdtInfo.lsLinkYn eq 'Y'}">
					<div class="image-groupA">
					<c:forTokens items="${prdtInfo.apiImgDetail}" delims="||" var="item">
					<img src="${item}" class="full" loading="lazy" alt="상품설명">
					</c:forTokens>
					</div>
				</c:if>

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
			  
			  	<%-- 상세정보 --%>
			  	<c:if test="${empty infoBgColor}"><c:set var="varBgColor" value="2e4b55"/></c:if>
              	<c:if test="${not empty infoBgColor}"><c:set var="varBgColor" value="${infoBgColor}"/></c:if>

			  	<c:if test="${fn:length(dtlInfList) != 0}">
					<div class="product-detailInfo" style="background-color: #${varBgColor}">
						<c:forEach var="data" items="${dtlInfList}" varStatus="status">
							<c:if test="${data.dtlinfType == 'B'}">
								<!-- 소셜기본폼양식 -->
								<div class="item-area">
									<div class="product-title"><strong><c:out value="${data.subject}"/></strong></div>
									<div class="type-body3"><p><c:out value="${data.dtlinfExp}" escapeXml="false"/></p></div>
		
									<c:forEach var="item" items="${data.spDtlinfItem}" varStatus="status1">
										<div class="type-area item">
											<div class="title-area">
												<strong>선택 ${status1.count}</strong>
											</div>
											<div class="text-area">
												<strong class="title"><c:out value="${item.itemNm}"/></strong>
												<ul>
													<li>
														<div class="names"></div>
														<div class="price">
															<c:if test="${(item.itemAmt eq item.itemDisAmt) or (empty item.itemDisAmt)}">
																<div class="sale"><fmt:formatNumber value="${item.itemAmt}"/> <small>원</small></div>
															</c:if>
															<c:if test="${(item.itemAmt ne item.itemDisAmt) and (not empty item.itemDisAmt)}">
																<div class="cost"><del><fmt:formatNumber value="${item.itemAmt}"/> 원</del></div>
																<div class="sale"><fmt:formatNumber value="${item.itemDisAmt}"/> <small>원</small></div>
															</c:if>
														</div>
													</li>
												</ul>
												<div class="memo"><c:out value="${item.itemEtc}" escapeXml="false"/></div>
											</div>
										</div> <!-- //type-area -->
									</c:forEach>
								</div> <!-- //product-detailInfo -->
								<!-- //소셜기본폼양식 -->
							</c:if>
						</c:forEach>
					</div> <!-- //product-detailInfo -->
			  	</c:if>

				<c:if test="${prdtInfo.lsLinkYn ne 'Y'}">
				<c:if test="${not empty dtlImg[0].savePath}">
			    <div class="image-groupA">
		          	<c:forEach var="dtlImg" items="${dtlImg}" varStatus="status">
						<c:if test="${status.index != 0}">
							<img src="<c:url value='${dtlImg.savePath}${dtlImg.saveFileNm}' />" loading="lazy" alt="상품상세">
						</c:if>
		          	</c:forEach>
		        </div>
				</c:if>
				</c:if>

			   	<c:if test="${(not empty SP_GUIDINFOVO) and (SP_GUIDINFOVO.printYn eq 'Y')}">
					<div class="product-detailInfo" style="background-color: #${varBgColor}">
						<div class="info-area item">
							<h3 class="title">안내사항</h3>
							<div class="table-area">
								<table class="table-row">
									<caption>상품관련 안내사항 내용입니다.</caption>
									<colgroup>
										<col style="width: 25%">
										<col>
									</colgroup>
									<tbody>
										<tr>
											<th>문의전화</th>
											<td><c:out value="${SP_GUIDINFOVO.telnum}"/></td>
										</tr>
										<tr>
											<th>주소지</th>
											<td>
												<c:out value="${SP_GUIDINFOVO.roadNmAddr}"/>
												<c:out value="${SP_GUIDINFOVO.dtlAddr}"/>
											</td>
										</tr>
										<c:if test="${not empty SP_GUIDINFOVO.prdtExp}">
											<tr>
												<th>상품설명</th>
												<td><c:out value="${SP_GUIDINFOVO.prdtExp}" escapeXml="false"/></td>
											</tr>
										</c:if>
										<c:if test="${not empty SP_GUIDINFOVO.useQlfct}">
											<tr>
												<th>사용조건</th>
												<td><c:out value="${SP_GUIDINFOVO.useQlfct}" escapeXml="false"/></td>
											</tr>
										</c:if>
										<c:if test="${not empty SP_GUIDINFOVO.useGuide}">
											<tr>
												<th>이용안내</th>
												<td><c:out value="${SP_GUIDINFOVO.useGuide}" escapeXml="false"/></td>
											</tr>
										</c:if>
										<c:if test="${not empty SP_GUIDINFOVO.cancelRefundGuide}">
											<tr>
												<th>취소/환불 안내</th>
												<td><c:out value="${SP_GUIDINFOVO.cancelRefundGuide}" escapeXml="false"/></td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
						</div> <!-- //info-area -->
					</div> <!-- //product-detailInfo -->
			  	</c:if>
		    </div> <!-- //tabs-info -->
		    
		    <div id="tabs-terms" class="tabPanel">
	        	<div class="text-groupA">	        	  
					<c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
						<c:if test="${!((fn:substring(prdtInfo.ctgr, 0,2) eq 'C1') or (fn:substring(prdtInfo.ctgr, 0,2) eq 'C4'))}">
							<c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_TOUR}">
							<dl>
								<dt class="title-type3">이용안내</dt>
								<dd class="type-body1">
									<c:if test="${prdtInfo.exprDaynumYn eq 'Y'}">
										<p>유효기간 : 구매일로 부터 <strong class="comm-color1">${prdtInfo.exprDaynum}</strong>일 까지 사용 가능합니다.</p>
									</c:if>
									<c:if test="${prdtInfo.exprDaynumYn eq 'N'}">
									  	<fmt:parseDate var="exprStartDt" value="${prdtInfo.exprStartDt}" pattern="yyyyMMdd"/>
										<fmt:parseDate var="exprEndDt" value="${prdtInfo.exprEndDt}" pattern="yyyyMMdd"/>
										<p>유효기간 : <fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/></p>
									</c:if>
								</dd>
							</dl>
							</c:if>
							<c:if test="${prdtInfo.prdtNum ne 'SP00000342'}">
								<dl>
									<dt class="title-type3">이용 제한 안내</dt>
									<dd class="type-body1">
										본 상품은 렌터카, 자가운전자, 도보여행객 등 개별여행객만 사용이 가능합니다.<br>
										(일반 정기투어, 단체관광, 택시관광 등 기사를 동반한 여행인 경우 사용하실 수 없습니다.)<br>
										타 할인(국가유공자, 장애인, 경로, 다른 할인 쿠폰 등)과 중복할인 불가합니다.
									</dd>
								</dl>
							</c:if>
						</c:if>
					</c:if>
				  	<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_COUP }">
						<dl>
							<dt class="title-type3">사용정보</dt>
							<dd class="type-body1">
								<c:if test="${prdtInfo.exprDaynumYn eq 'Y'}">
									<p>유효기간 : 구매일로 부터 <strong class="text-red">${prdtInfo.exprDaynum}</strong>일 까지 사용 가능합니다.</p>
								</c:if>
								<c:if test="${prdtInfo.exprDaynumYn eq 'N'}">
								  	<fmt:parseDate var="exprStartDt" value="${prdtInfo.exprStartDt}" pattern="yyyyMMdd"/>
									<fmt:parseDate var="exprEndDt" value="${prdtInfo.exprEndDt}" pattern="yyyyMMdd"/>
									<p>유효기간 : <span class="text-red"><fmt:formatDate value="${exprStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy-MM-dd"/></span></p>
								</c:if>
								<c:if test="${(not empty prdtInfo.useAbleTm) and (prdtInfo.useAbleTm ne 0) and prdtInfo.corpId ne 'C160000276' }">
									<p>사용여부 : <span class="text-red">즉시 사용 불가</span></p>
									<p>유의사항 : 구매하신 상품은 <strong>${prdtInfo.useAbleTm}시간</strong> 이후 사용 가능합니다.</p>
								</c:if>
								<c:if test="${(empty prdtInfo.useAbleTm) or (prdtInfo.useAbleTm eq 0) and prdtInfo.corpId ne 'C160000276'}">
									<p>사용여부 : <span class="text-red">즉시 사용 가능</span></p>
								</c:if>
							</dd>
						</dl>
	        	  	</c:if>
				  	<c:if test="${not empty prdtInfo.useQlfct}">
						<dl>
							<dt class="title-type3">안내 사항</dt>
							<dd class="type-body1">
								<c:out value="${prdtInfo.useQlfct}" escapeXml="false"/>
							</dd>
						</dl>
				  	</c:if>
				  	<c:if test="${not empty prdtInfo.visitMappingId}">
						<dl class="inline">
							<dt class="title-type3">주변 관광지 알아보기</dt>
							<dd class="type-body1">
								<a href="https://m.visitjeju.net/kr/detail/view?contentsid=${prdtInfo.visitMappingId}&newopen=yes#tmap" class="link" target="_blank">
									<img src="/images/mw/institution/visit-jeju.jpg" loading="lazy" alt="visit jeju">
								</a>
							</dd>
						</dl>
				  	</c:if>
				</div> <!-- //text-groupA -->
		    </div> <!-- //tabs-terms -->
		    
		  	<c:if test="${not empty prdtInfo.cancelGuide}">
				<div id="tabs-cancel" class="tabPanel">
					<div class="text-groupA">
						<dl>
							<dt class="title-type3">취소/환불</dt>
							<dd class="type-body1">
								<c:out value="${prdtInfo.cancelGuide}" escapeXml="false"/>
							</dd>
						</dl>
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
		    </div>
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
							<img src="${prdtInfo.adtmImg}" width="95" loading="lazy" alt="판매처">
						</div>
					</c:if>
					<div class="r-area">
						<div class="type-body1">
							상호 : <c:out value="${prdtInfo.shopNm}" /><br>
							전화번호 : <a href="tel:${prdtInfo.rsvTelNum}"><c:out value="${prdtInfo.rsvTelNum}"/></a><br>
							소개 : <c:out value="${prdtInfo.adtmSimpleExp}"/>
						</div>
					</div>	
				</dd>
			</dl>
		</div> <!-- //text-groupA -->
		
		<section class="recommend-product">
			<h2 class="sec-caption">추천 상품</h2>
			<div class="recommend-group">
				<div class="title-side-area">
					<div class="l-area">
					  	<c:if test="${Constant.SP_PRDT_DIV_TOUR eq prdtInfo.prdtDiv}">
							<h3 class="title-type2">추천상품</h3>
		              	</c:if>
		              	<%--<c:if test="${fn:substring(prdtInfo.ctgr, 0, 2) eq 'C2'}">
		             	    <h3 class="title-type2">주변 관광지</h3>
		              	</c:if>--%>
		              	<c:if test="${(fn:length(otherProductList) > 1) and (fn:substring(prdtInfo.ctgr, 0, 2) ne 'C2') and (prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_COUP)}">
		                	<h3 class="title-type2">주변 숙소</h3>
		              	</c:if>
					</div>
					<div class="r-area text">
					</div>
				</div>
				
				<div class="promotion-content">
		            <div id="promotion_product" class="swiper-container">
		                <ul class="swiper-wrapper">
		                  	<%--<c:if test="${((prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR) and (fn:length(otherProductList) > 1)) or (fn:substring(prdtInfo.ctgr, 0, 2) eq 'C2')}">
								<c:forEach var="product" items="${otherProductList}">
									<li class="swiper-slide">
										<div class="photo">
											<a href="<c:url value='/mw/sp/detailPrdt.do?prdtNum=${product.prdtNum}&prdtDiv=${product.prdtDiv}'/>">
												<img src="${product.savePath}thumb/${product.saveFileNm}" class="product" alt="${product.prdtNm}">
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
												  	<c:if test="${not empty pocketMap[product.prdtNum]}">
														<a href="javascript:void(0)">
															<img src="/images/mw/icon/product_like_on.png" alt="찜하기">
														</a>
												 	</c:if>
												  	<c:if test="${empty pocketMap[product.prdtNum]}">
														<a href="javascript:void(0)" id="pocket${product.prdtNum}" onclick="fn_listAddPocket('${Constant.SOCIAL}', '${product.corpId}', '${product.prdtNum}')">
															<img src="/images/mw/icon/product_like_off.png" alt="찜하기">
														</a>
												  	</c:if>
												</div>
											</div>
										</div>
									</li>
								</c:forEach>
		                  	</c:if>--%>
		                  	<c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_TOUR}">
								<c:forEach var="product" items="${otherAdList}">
									<li class="swiper-slide">
										<div class="photo">
											<a href="<c:url value='/mw/ad/detailPrdt.do?sPrdtNum=${product.prdtNum}&sAdultCnt=2&sChildCnt=0&sBabyCnt=0&sSearchYn=N'/>">
												<img src="${product.savePath}thumb/${product.saveFileNm}" class="product" alt="${product.adNm}">
											</a>
										</div>
										<div class="text">
											<div class="title">[<c:out value='${product.adAreaNm}'/>]<c:out value='${product.adNm}'/></div>
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
												  	<c:if test="${not empty pocketMap[product.corpId]}">
														<%-- <a href="javascript:void(0)"> --%>
														<a>
															<img src="/images/mw/icon/product_like_on.png" alt="찜하기">
														</a>
												  	</c:if>
												  	<c:if test="${empty pocketMap[product.corpId]}">
														<%-- <a href="javascript:void(0)" id="pocket${product.corpId }" onclick="fn_listAddPocket('${Constant.ACCOMMODATION}', '${product.corpId }', ' ')"> --%>
														<a id="pocket${product.corpId }" onclick="fn_listAddPocket('${Constant.ACCOMMODATION}', '${product.corpId }', ' ')">
															<img src="/images/mw/icon/product_like_off.png" alt="찜하기">
														</a>
												  	</c:if>
												</div>
											</div>
										</div>
									</li>
								</c:forEach>
		                  	</c:if>
		                </ul>
		            </div>
		        </div>
			</div> <!-- //recommend-group -->
		</section> <!-- //recommend-product -->
		
		<!-- 구매하기 -->
		<div class="purchase-area">
			<div class="basic">
				<div class="icon-area">
					<%-- <a href="javascript:void(0)" onclick="itemSingleShow('#sns_popup');"> --%>
					<a id="sp-sns-share" class="sns-share">
						<img src="/images/mw/icon/sns.png" alt="sns">
						<span>공유하기</span>
					</a>
			<%--		<c:if test="${pocketCnt eq 0}">
						&lt;%&ndash; <a href="javascript:void(0)" onclick="fn_SpAddPocket();" id="pocketBtnId"> &ndash;%&gt;
						<a onclick="fn_SpAddPocket();" id="pocketBtnId">
							<img src="/images/mw/icon/product_like2_off.png" alt="찜하기">
						</a>
					</c:if>
			    	<c:if test="${pocketCnt ne 0}">
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
				
			  	<c:if test="${prdtInfo.linkPrdtYn eq 'N'}">
					<div class="scroll-area">
						<div class="purchase-option">
							<dl class="view-select comm-select comm-select1">
								<dt title="상품 선택">1. 상품을 선택하세요</dt>
								<dd class="in" style="display:none">
									<ul class="select-list-option" id="firstOptionList"></ul>
								</dd>
							</dl>
							<form id="calendarForm">
								<input type="hidden" id="iYear" name="iYear" value="0" />
								<input type="hidden" id="iMonth" name="iMonth" value="0" />
								<input type="hidden" id="sPrevNext" name="sPrevNext" value="" />
								<input type="hidden" id="saleStartDt" name="saleStartDt" value="${prdtInfo.saleStartDt}" />
								<input type="hidden" id="saleEndDt" name="saleEndDt" value="${prdtInfo.saleEndDt}" />
								<input type="hidden" id="spDivSn" name="spDivSn">
							</form>
							<c:set var="idx" value="2" />
							<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
								<dl class="view-select comm-select comm-select2">
									<dt>${idx}. 날짜를 선택하세요</dt>
									<dd class="comm-calendar" id="calendar" style="display:none"></dd>
								</dl>
								<c:set var="idx" value="${idx + 1}" />
							</c:if>
							<dl class="view-select comm-select comm-select3">
								<dt title="옵션 선택">${idx}. 옵션을 선택하세요</dt>
								<dd class="in in2" style="display:none">
									<ul class="select-list-option" id="secondOptionList"></ul>
								</dd>
							</dl>
							<c:if test="${fn:length(addOptList) > 0}">
								<dl class="view-select comm-select comm-select4">
									<dt>${idx + 1}. 추가옵션을 선택하세요</dt>
									<dd class="in in2" style="display:none">
										<ul class="select-list-option" id="addOptionList"></ul>
									</dd>
								</dl>
							</c:if>
							<div class="comm-qtyWrap" id="selectedItemWrapper" style="display:none">
								<ul></ul>
							</div> <!-- //selected-option -->

							<div class="total-area">
							  	<c:if test="${(not empty prdtInfo.useAbleTm) and (prdtInfo.useAbleTm > 0)}">
									<div class="text">본 상품은 ${prdtInfo.useAbleTm}시간 이후부터 사용가능합니다.</div>
							  	</c:if>
								<div class="total-price">총 <span id="totalProductAmt">0</span>원</div>
							</div>
						</div> <!-- //purchase-option -->
					</div> <!-- //scroll-area -->
			  	</c:if>
				
				<div class="bottom-area">
				  	<c:if test="${prdtInfo.linkPrdtYn eq 'N'}">
						<div class="purchase-btn-group">
							<c:if test="${prdtInfo.prdtNum ne 'SP00002180'}">
							<button type="button" id="cartBtn" class="gray addcart" onclick="fn_SpAddCart();">장바구니</button>
							</c:if>
							<button type="button" class="red gobuy" onclick="fn_SpBuy();">바로구매</button>
						</div>
				  	</c:if>
				  	<c:if test="${prdtInfo.linkPrdtYn eq 'Y'}">
						<div class="purchase-btn-group">
							<button type="button" class="gray afterbuy" onclick="location.href='http://coupon.hijeju.or.kr?SCID=tamnao&newopen=yes'">후불결제</button>
							<button type="button" class="red gobuy" onclick="location.href='${prdtInfo.linkUrl}&newopen=yes'">바로구매</button>
						</div>
				  	</c:if>
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
                        <a href="javascript:shareKakao('<c:out value="${prdtInfo.prdtNm}" />', '${imgUrl}', '${strUrl}'); snsCount('${prdtInfo.prdtNum}', 'MO', 'KAKAO');" id="kakao-link-btn">
                            <img src="/images/mw/icon/sns/kakaotalk.png" loading="lazy" alt="카카오톡">
                            <span>카카오톡</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:shareFacebook('${strUrl}'); snsCount('${prdtInfo.prdtNum}', 'MO' , 'FACEBOOK');">
                            <img src="/images/mw/icon/sns/facebook.png" loading="lazy" alt="페이스북">
                            <span>페이스북</span>
                        </a>
                    </li>
                    <%-- 기능종료 
                    <li>
                        <a href="javascript:shareStory('${strUrl}'); snsCount('${prdtInfo.prdtNum}', 'MO', 'KAKAO');">
                            <img src="/images/mw/icon/sns/kakaostory.png" loading="lazy" alt="카카오 스토리">
                            <span>카카오 스토리</span>
                        </a>
                    </li> --%> 
                    <li>
		                <a href="javascript:shareBand('${strUrl}'); snsCount('${prdtInfo.prdtNum}', 'MO', 'BAND');">
		                    <img src="/images/mw/icon/sns/band.png" loading="lazy" alt="밴드">
		                    <span>밴드</span>
		                </a>
		            </li>
		            <li>
		                <a href="javascript:shareLine('${strUrl}'); snsCount('${prdtInfo.prdtNum}', 'MO', 'LINE');">
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
<!-- 콘텐츠 e -->

<script type="text/javascript" src="<c:url value='/js/mw_useepil.js?version=${nowDate}'/>"></script>
<script type="text/javascript" src="<c:url value='/js/mw_otoinq.js?version=${nowDate}'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/mw_bloglink.js?version=${nowDate}'/>"></script> --%>
<%-- <script src="<c:url value='/js/mw_swiper.js?version=${nowDate}'/>"></script> --%>

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<%-- <script type="text/javascript" src="//media.line.me/js/line-button.js?v=20140411" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>
<script type="text/javascript">
	var productCount = 0;			// 상품 수
	var optionCount = 0;			// 옵션 수
	var addOptionCount = 0;			// 추가옵션 수
	
	function getCalOption() {
		var calP = $("#calendarForm").serialize();
		
		$.ajax({
			url: "<c:url value='/mw/sp/getCalOptionList.ajax'/>",
			data: "prdtNum=${prdtInfo.prdtNum}&" + calP,
			success:function(data) {
				$(".comm-select dd").css("display", "none");
				$("#calendar").html(data);
				
				$("#calendar").css("display", "block");
				
				$("#iYear").val($(".calY1").text());
				$("#iMonth").val($(".calM1").text());
	
				/**시티투어 야간특별처리*/
				/*if($("#iMonth").val() == "7" && "${prdtInfo.prdtNum}" == "SP00001434"){
					nextCalendar();
	            };*/
			},
			error: fn_AjaxError
		});
	}
	
	function nextCalendar() {
		$("#sPrevNext").val("next");
	
		getCalOption();
	}
	
	function prevCalendar() {
		$("#sPrevNext").val("prev");
	
		getCalOption();
	}
	
	/** 달력 옵션 선택시 */
	function selectCalOption(selectDay, obj) {
		$(".comm-select2 dt").html("2. 선택날짜 : <span></span>");
		$(".comm-select2 dt span").text(getDayFormat(selectDay, "."));
		$(".comm-select2 dt span").addClass("text-red");
	
		$("table.cal tr>td").removeClass("today");
		$(obj).closest("td").addClass("today");
		
		//$("#calendar").css("display", "none");	//자동open 해제
		
		getSecondOption(selectDay);
	}
	
	/** 추가옵션선택시 */
	function getAddOption() {
		if($(".comm-select4 dd").css("display") == "block") {
			$(".comm-select dd").css("display", "none");
			return ;
		}
	
		if($("#addOptionList li").length > 0) {
			if($("#addOptionList").css("display") == "none") {
				$(".comm-select dd").css("display", "none");
				<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
					$("#calendar").css("display", "none");
				</c:if>
				$(".comm-select4 dd").css("display", "block")
			}
			$(".comm-select").removeClass("open");
	
			<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
				// $(".opCal").removeClass("open");
			</c:if>
			$(".comm-select4").addClass("open");
			return false;
		}
		var b_data = {
			addOptNm: "",
			addOptAmt: 0,
			addOptSn: ""
	 	};
	
		$.ajax({
			url: "<c:url value='/web/sp/getAddOptList.ajax'/>",
			data: "prdtNum=${prdtInfo.prdtNum}",
			success:function(data) {
				var list = data.list;
				var dataArr = "<li><a href='javascript:;' data-raw='' title=''><p class='product'><span>선택안함</span></p></a></li>";
	
				$("#addOptionList").append(dataArr);
	
				var inx = 1;
	
				if(list != "") {
					addOptionCount = list.length;
	
					$(list).each( function() {
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
						$("#addOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this) );
						inx++;
					});
	
					$("#addOptionList li:eq(0)>a").attr("data-raw", JSON.stringify(b_data) );
				}
			},
			error: fn_AjaxError
		});
	
		$(".comm-select").removeClass("open");
	
		<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
			// $(".opCal").removeClass("open");
		</c:if>
		$(".comm-select4").addClass("open");
		$(".comm-select dd").css("display", "none");
		$(".comm-select4 dd").css("display", "block");
	}
	
	function getSecondOption(selectDay) {
		$("#secondOptionList").empty();
	
		var parameters = "prdtNum=${prdtInfo.prdtNum}&spDivSn=" + $("#spDivSn").val() + "&aplDt=" + selectDay;
	
		$.ajax({
			url: "<c:url value='/mw/sp/getOptionList.ajax'/>",
			data: parameters,
			success:function(data) {
				var list = data.list;
				var dataArr;
				var inx = 0;
				var count =1;
	
				if(list != "") {
					optionCount = list.length;
	
					$(list).each(function() {
						if(this.stockNum > 0 && this.ddlYn == "N") {
							dataArr = "<li>";
							dataArr += "<a href='javascript:;' data-raw='' title='" + this.optNm +"'>";
							dataArr += "<p class='product'>";
							dataArr += "<span>[선택" + count + "]" + fn_addDate(this.aplDt) +  " " + this.optNm + "</span>";
	
							if("${prdtInfo.prdtDiv}" != "COUP"){
								dataArr += "<span class='count'> | 잔여 : " + commaNum(this.stockNum) + "개</span>";
							}
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
						$("#secondOptionList li:eq(" + inx + ")>a").attr("data-raw", JSON.stringify(this) );
						count++;
						inx++;
					});
	
					$(".comm-select1 dd").css("display", "none");
					//$(".comm-select3 dd").css("display", "block");	//자동open 해제
					$(".comm-select3 dd").css("display", "none");
					
					$(".scroll-area").scrollTop($(".scroll-area").height());
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
			price = price + Number(fn_replaceAll($(this).text(), ",",""));
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
	function fn_SpAddPocket(){
		var pocket = [{
			prdtNum 	: "<c:out value='${prdtInfo.prdtNum}'/>",
			prdtNm 		: "<c:out value='${prdtInfo.prdtNm}'/>",
			corpId 		: "<c:out value='${prdtInfo.corpId}'/>",
			corpNm 		: "<c:out value='${prdtInfo.corpNm}'/>",
			prdtDiv 	: "${Constant.SOCIAL}",
			spDiv		: "${prdtInfo.ctgr}"
		 }];
		
		 fn_AddPocket(pocket);
	}
	
	function fn_SpAddCart(){
	    if("${prdtInfo.corpId}" == "CSPU190002"){
			alert("즉시결제만 가능한 상품입니다.")
			return;
	    }
	
		var items = $("#selectedItemWrapper ul>li");
	
		if(items.length == 0 ) {
			alert("상품을 선택해 주세요.")
			return false;
		}
		var cart = [];
	
	    items.each(function(){
	        var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	
	        cart.push({
	            prdtNum 	: "<c:out value='${prdtInfo.prdtNum}'/>",
	            prdtNm 		: "<c:out value='${prdtInfo.prdtNm}'/>",
	            prdtDivNm 	: "<c:out value='${prdtInfo.ctgrNm}'/>",
	            corpId 		: "<c:out value='${prdtInfo.corpId}'/>",
	            corpNm 		: "<c:out value='${prdtInfo.corpNm}'/>",
	            nmlAmt 		: 0,
	            qty 		: $(this).find(".list2 .qty-input").val(),
	            spOptSn 	: dataRaw.spOptSn,
	            spDivSn 	: dataRaw.spDivSn,
	            addOptNm 	: dataRaw.addOptNm,
	            addOptAmt 	: dataRaw.addOptAmt
	        });
	    });
	
	    fn_AddCart(cart);
	    // 장바구니에 담고 선택한거 삭제?
	    $("#selectedItemWrapper ul").html("");
	
	    selectedItemSaleAmt();
	
	    AM_PRODUCT(1);  //모바일 에이스 카운터 추가 2017.04.25
	}
	
	/**
	 * 즉시구매
	 */
	function fn_SpBuy(){
		if("${prdtInfo.prdtNum}" == "SP00002180"){
			if($(".qty-list").length > 4){
				alert("해당상품은 최대 4장까지 구매하실 수 있습니다.");
				return false;
			}
		}
	
		var items = $("#selectedItemWrapper ul>li");
	
		if(items.length == 0 ) {
			alert("상품을 선택해 주세요.")
			return false;
		}
		var cart = [];
	
		items.each(function(){
	        var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	        cart.push({
	            prdtNum 	: "<c:out value='${prdtInfo.prdtNum}'/>",
	            prdtNm 		: "<c:out value='${prdtInfo.prdtNm}'/>",
	            prdtDivNm 	: "<c:out value='${prdtInfo.ctgrNm}'/>",
	            corpId 		: "<c:out value='${prdtInfo.corpId}'/>",
	            corpNm 		: "<c:out value='${prdtInfo.corpNm}'/>",
	            nmlAmt 		: 0,
	            qty 		: $(this).find(".list2 .qty-input").val(),
	            spOptSn 	: dataRaw.spOptSn,
	            spDivSn 	: dataRaw.spDivSn,
	            addOptNm 	: dataRaw.addOptNm,
	            addOptAmt 	: dataRaw.addOptAmt
	        });
	    });
	
	    fn_InstantBuy(cart);
	
	    AM_PRODUCT(1);//모바일 에이스 카운터 추가 2017.04.25
	}
	
	function checkDupOption(newData) {
		var result = false ;
	
		$("#selectedItemWrapper ul>li").each(function(){
			var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
	
			if((newData.spDivSn == dataRaw.spDivSn) && (newData.spOptSn == dataRaw.spOptSn)) {
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
	
	//쿠폰 리스트 체크
	function fn_chkCouponList() {
		var copNum = 0;
		var amt = eval(fn_replaceAll($("#totalProductAmt").text(), ",", ""));
		
		$(".useCouponList").each(function() {	
			if (amt < $(this).attr("minAmt")) {
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
	
	// 쿠폰코드 등록
	function goCouponCode() {
		if(confirm("<spring:message code='confirm.coupon.code' />")){
			location.href = "<c:url value='/mw/mypage/couponList.do' />";
		}
	}


    // 구매하기 레이어팝업 잠금
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
		if($("#detail_slider .swiper-slide").length > 1) {
			new Swiper("#detail_slider", {
		        pagination		: "#detail_paging",
		        paginationType	: "fraction",
		        loop			: true
		    });
		}
	
		//주변 관광/레저
		if($("#promotion_product .swiper-slide").length > 1) {
			new Swiper("#promotion_product", {
	            slidesPerView		: "auto",
	            paginationClickable	: true,
	            spaceBetween		: 15
		    });
		}
	
		//Tab Menu (상품설명, 사용조건 등)
		targetTabMenu("#scroll_tabs");
	
		// 상품을 선택하세요
		$(".comm-select1 dt").click(function() {
			if($(".comm-select1 dd").css("display") == "block") {
				$(".comm-select dd").css("display", "none");
				return ;
			}
			if($("#firstOptionList li").length > 0) {
				if($(".comm-select1 dd").css("display") == "none") {
					$(".comm-select dd").css("display", "none");
					$(".comm-select1 dd").css("display", "block")
				}
				return;
			}
	        $.ajax({
	            url: "<c:url value='/mw/sp/getDivInfList.ajax'/>",
	            data: "prdtNum=${prdtInfo.prdtNum}",
	            success:function(data) {
	                var list = data.list;
	                var dataArr;
					var count = 1;
					var inx = 0;
	
	                if(list != "") {
						productCount = list.length;
	
	                    $(list).each(function() {
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
	
	                    $(".comm-select dd").css("display", "none");
	                    $(".comm-select1 dd").css("display", "block");
	
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
		$("#firstOptionList").on("click", "li>a", function() {
			var dataRaw = jQuery.parseJSON($(this).attr("data-raw"));
			var title = $(this).attr("title");
	
			$("#spDivSn").val(dataRaw.spDivSn);
	
			$(".comm-select1 dt").html("1. 선택상품 : <span></span>");
			$(".comm-select1 dt span").text(title);
			$(".comm-select1 dt span").addClass("text-red");
	
			$("#secondOptionList").empty();
	
			<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
				$("#sPrevNext").val("");
	
				getCalOption();
			</c:if>
			<c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_TOUR}">
				getSecondOption("");
			</c:if>
		});
	
		// 날짜를 선택하세요
		$(".comm-select2 dt").click(function(){
			if($("#calendar").css("display") == "block") {
				$("#calendar").css("display", "none");
			} else {
				if($("#calendar strong").length > 0) {
					$("#calendar").css("display", "block");
				}
			}
		});
	
		// 옵션을 선택하세요
		$(".comm-select3 dt").click(function(){
			if($(".comm-select3 dd").css("display") == "block") {
				$(".comm-select3 dd").css("display", "none");
			} else {
				if($("#secondOptionList li").length > 0) {
					$(".comm-select3 dd").css("display", "block");
				}
			}
		});
	
		// 옵션 선택
		$("#secondOptionList").on("click", "li>a", function() {

			/** 승마업체 특별처리 */
			if($(".qty-list").length > 0 && "${prdtInfo.prdtNum}" == "C1"){
				alert("해당상품은 복수의 옵션을 선택할 수 없습니다.");
				$(".in.in2").hide();
				return;
			}

			var dataRaw =  jQuery.parseJSON($(this).attr("data-raw"));
			var ori_dataRaw = $(this).attr("data-raw");
			var firstOptionText = $(".comm-select1 dt span").text();
			var secondOptionText = $(this).attr("title");
	
			// 추가옵션 유무
			if("${fn:length(addOptList)}" == 0) {
				if(checkDupOption(dataRaw)) {
					alert("<spring:message code='fail.product.duplication'/>");
	
					$(".comm-select1 dd").css("display", "none");
					return false;
				}
				var text = "<li class='qty-list'>";
				text += "<ol>";
				text += "<li class='list1'>";
				text += firstOptionText + "<br>";
	
				if(dataRaw.aplDt != null) {
					text += " - " + fn_addDate(dataRaw.aplDt);
				}
				text += " - " + secondOptionText;
				text += "<span class='option-stockNum' style='display:none'>" + commaNum(dataRaw.stockNum) + "</span>";
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
				$("#selectedItemWrapper ul>li").last().attr("data-raw", ori_dataRaw);
				$("#selectedItemWrapper").css("display", "block");
	
				<c:if test="${prdtInfo.prdtDiv ne Constant.SP_PRDT_DIV_TOUR}">
					if(productCount > 1) {
						if(optionCount == 1) {
							$(".comm-select").removeClass("open");
							$(".comm-select1 dt").html("1. 상품을 선택하세요");
							$(".comm-select2 dt").html("2. 옵션을 선택하세요");
							$("#secondOptionList").empty();
						}
					}
				</c:if>
				<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
					if(optionCount == 1) {
						$(".comm-select").removeClass("open");
						$("table.cal tr>td").removeClass("today");
						$(".comm-select2 dt").html("2. 날짜를 선택하세요");
						$(".comm-select3 dt").html("3. 옵션을 선택하세요");
						$("#secondOptionList").empty();
					}
				</c:if>
				$(".comm-select1 dd").css("display", "none");
				$(".comm-select3 dd").css("display", "none");
	
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
		$(".comm-select4 dt").click(function(){
			if($(".comm-select4 dd").css("display") == "block") {
				$(".comm-select4 dd").css("display", "none");
			} else {
				if($("#addOptionList li").length > 0) {
					$(".comm-select4 dd").css("display", "block");
				}
			}
	    });
	
		// 추가옵션 선택
		$("#addOptionList").on("click", "li>a", function() {
			var dataRaw = jQuery.parseJSON($("#addOptionList").attr("data-raw"));
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
	
			if(dataRaw.aplDt != null) {
				text += " - " + fn_addDate(dataRaw.aplDt);
			}
			text += " - " + secondOptionText;
	
			if(addOptionText != "") {
				text += " - " + addOptionText;
			}
			text += "<span class='option-stockNum' style='display:none'>" + commaNum(dataRaw.stockNum) + "</span>";
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
			$("#selectedItemWrapper ul>li").last().attr("data-raw",ori_dataRaw);
			$("#selectedItemWrapper").css("display", "block");
			$(".comm-select1 dd").css("display", "none");
			$(".comm-select3 dd").css("display", "none");
			$(".comm-select4 dd").css("display", "none");
	
			if(productCount > 1) {
				$("#secondOptionList").empty();
			}
			$("#addOptionList").empty();
	
			var idx = 2;
	
			<c:if test="${prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR}">
				$("table.cal tr>td").removeClass("today");
				$(".comm-select2").html(idx + ". 날짜를 선택하세요");
				idx++;
			</c:if>
			$(".comm-select").removeClass("open");
	
			if(productCount > 1) {
				$(".comm-select1 dt").html("1. 상품을 선택하세요");
			}
			$(".comm-select3 dt").html(idx + ". 옵션을 선택하세요");
	
			selectedItemSaleAmt();
		});
	
		$("#selectedItemWrapper").on("click", ".del", function() {
			$(this).parents(".qty-list").remove();
	
			if($(this).parents(".qty-list").length == 0 ) {
				$("#selectedItemWrapper").css("display","block");
			}
			selectedItemSaleAmt();
	
			return ;
		});
	
		$("#selectedItemWrapper").on("keyup", ".qty-input", function() {
			var stockNum = fn_replaceAll($(this).parents(".qty-list").find(".option-stockNum").text(), ",", "");
	
			var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
			var saleAmt = thisDataRaw.saleAmt;
	
			$(this).val($(this).val().replace(/[^0-9]/gi, ""));
	
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
			var stockNum = fn_replaceAll($(this).parents(".qty-list").find(".option-stockNum").text(), ",", "");
			var thisDataRaw = jQuery.parseJSON($(this).parents(".qty-list").attr("data-raw"));
			var saleAmt = thisDataRaw.saleAmt;
			var addtionCount = Number($(this).prev().val()) + 1;
	
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
	
			if(subtractCount >= 1) {
				$(this).parents(".qty-list").find(".qty-input").val(subtractCount);
				$(this).parents(".qty-list").find(".price").text(commaNum(saleAmt * subtractCount));
	
				selectedItemSaleAmt();
			}
		});
	
		//fn_chkCouponList();
	
		//-이용 후기 관련 설정 --------------------
		g_UE_getContextPath = "${pageContext.request.contextPath}";
		g_UE_corpId		="${prdtInfo.corpId}";					//업체 코드 - 넣어야함
		g_UE_prdtnum 	="${prdtInfo.prdtNum}";					//상품번호  - 넣어야함
		g_UE_corpCd 	="${Constant.SOCIAL}";	//숙박/랜트.... - 페이지에 고정
	
		//이용후기 상단 평점/후기수, 탭 숫자 변경(서비스로 사용해도됨)
		fn_useepilInitUI();
		// * 서비스 사용시 GPAANLSVO ossUesepliService.selectByGpaanls(GPAANLSVO) 사용
	
		//이용후기 리스트 뿌리기 -> 해당 탭버튼 눌렀을때 호출하면됨
		fn_useepilList();
		//---------------------------------------------------
	
		//-1:1문의 관련 설정 --------------------------------
		g_Oto_getContextPath = "${pageContext.request.contextPath}";
		g_Oto_corpId	="${prdtInfo.corpId}";					//업체 코드 - 넣어야함
		g_Oto_prdtnum 	="${prdtInfo.prdtNum}";					//상품번호  - 넣어야함
		g_Oto_corpCd 	="${Constant.SOCIAL}";	//숙박/랜트.... - 페이지에 고정
	
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
<jsp:include page="/mw/foot.do"></jsp:include>
<!-- 푸터 e -->
<%--<script type="text/javascript">
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
</script>--%>
</div>

<%-- 모바일 에이스 카운터 추가 2017.04.25 --%>
<!-- *) 제품상세페이지 분석코드 -->
<!-- AceCounter Mobile eCommerce (Product_Detail) v7.5 Start -->
<script language='javascript'>
var m_pd ="<c:out value="${prdtInfo.prdtNm}"/>";

<c:choose>
	<c:when test="${'C1' eq fn:substring(prdtInfo.ctgr,0,2)}">
		<c:set var="strctgrNm" value="패키지할인상품" />
	</c:when>
	<c:when test="${'C2' eq fn:substring(prdtInfo.ctgr,0,2)}">
		<c:set var="strctgrNm" value="관광지/레져" />
	</c:when>
	<c:when test="${'C3' eq fn:substring(prdtInfo.ctgr,0,2)}">
		<c:set var="strctgrNm" value="음식/뷰티" />
	</c:when>
	<c:when test="${'C4' eq fn:substring(prdtInfo.ctgr,0,2)}">
		<c:set var="strctgrNm" value="여행사 단품" />
	</c:when>
</c:choose>
var m_ct ="<c:out value="${strctgrNm}"/>";
var m_amt="${prdtInfo.saleAmt}";
</script>
<!-- AceCounter Mobile WebSite Gathering Script V.7.5.20170208 -->
<script language="javascript">
	var _AceGID=(function(){var Inf=["tamnao.com","m.tamnao.com,www.tamnao.com,tamnao.com","AZ3A70537","AM","0","NaPm,Ncisy","ALL","0"]; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;if(_CI.join(".").indexOf(Inf[3])<0){ _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
	var _AceCounter=(function(){var G=_AceGID;var _sc=document.createElement("script");var _sm=document.getElementsByTagName("script")[0];if(G.o!=0){var _A=G.val[G.o-1];var _G=(_A[0]).substr(0,_A[0].indexOf("."));var _C=(_A[7]!="0")?(_A[2]):_A[3];var _U=(_A[5]).replace(/\,/g,"_");_sc.src=(location.protocol.indexOf("http")==0?location.protocol:"http:")+"//cr.acecounter.com/Mobile/AceCounter_"+_C+".js?gc="+_A[2]+"&py="+_A[1]+"&up="+_U+"&rd="+(new Date().getTime());_sm.parentNode.insertBefore(_sc,_sm);return _sc.src;}})();
</script>
<noscript><img src='https://gmb.acecounter.com/mwg/?mid=AZ3A70537&tp=noscript&ce=0&' border='0' width='0' height='0' alt=''></noscript>
<!-- AceCounter Mobile Gathering Script End -->

</body>
</html>