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
<c:set var="strURL" value="${strServerName}${pageContext.request.contextPath}${requestScope['javax.servlet.forward.servlet_path']}?prdtNum=${prdtInfo.prdtNum}&prdtDiv=${prdtInfo.prdtDiv}"/>

<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="${prdtInfo.prdtNm}"/>
	<jsp:param name="keywordsLinkNum" value="${prdtInfo.prdtNum}"/>
	<jsp:param name="keywordAdd1" value="${prdtInfo.prdtNm}"/>
	<jsp:param name="description" value="${prdtInfo.prdtInf}"/>
	<jsp:param name="imagePath" value="${seoImage}"/>
</jsp:include>
<meta property="og:title" content="<c:out value='${prdtInfo.prdtNm}' />" />
<meta property="og:url" content="http://${strURL}" />
<meta property="og:description" content="<c:out value='${prdtInfo.prdtNm}'/> - <c:out value='${prdtInfo.prdtInf}'/>" />
<c:if test="${fn:length(prdtImg) != 0}">
<meta property="og:image" content="http://${strServerName}${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}" />
</c:if>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css'/>">

<script type="text/javascript" src="<c:url value='/js/mw_useepil.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/mw_otoinq.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/mw_bloglink.js'/>"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>
<script src="<c:url value='/js/mw_swiper.js'/>"></script>

<!-- SNS관련----------------------------------------- -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/sns.js'/>"></script>

<script type="text/javascript">
function hideSendEmail() {
	$('.pop-seller, #cover').fadeToggle();
}

function sendFreeCoupon() {
	var email = $("#receiver").val();
	if(email == "") {
		alert("이메일을 입력해 주세요.");
		return ;
	}
	if(!fn_is_email(email)) {
		alert("이메일 형식이 맞지 않습니다.");
		return ;
	}
	var parameters = "prdtNum=${prdtInfo.prdtNum}&email=" + email;

	$.ajax({
		url: "<c:url value='/mw/sp/freeCouponMail.ajax'/>",
		data: parameters,
		success:function(data) {
			alert("이메일을 성공적으로 보냈습니다.");
			hideSendEmail();
			$("#receiver").val("");
			$(".modal").hide();
		},
		error: fn_AjaxError
	});
}

function saveInterestProduct() {
	$.ajax({
		url : "<c:url value='/mw/mypage/saveInterestProduct.ajax'/>",
		data: "itrPrdtNum=${prdtInfo.prdtNum}",
		dataType: "json",
		success:function(data) {
			alert("마이페이지에 저장했습니다.");
		},
		error: fn_AjaxError2
	});
}

$(document).ready(function() {
	// 상품 사진
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
	//---------------------------------------------------

});
</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 s -->
<header id="header">
	<jsp:include page="/mw/head.do"></jsp:include>
</header>
<!-- 헤더 e -->

<main id="main">
	<!--//change contents-->
	<div class="mw-detail-area">
		<section class="detail-product-area">
			<h2 class="sec-caption">상품 정보</h2>
			<div class="detail-slider">
				<div id="detail_slider" class="swiper-container">
					<div class="swiper-wrapper">
						<c:forEach var="imgInfo" items="${prdtImg}" varStatus="status">
							<div class="swiper-slide">
								<img src="<c:url value='${imgInfo.savePath}thumb/${imgInfo.saveFileNm}' />" alt="${prdtInfo.prdtNm}">
							</div>
						</c:forEach>
					</div>
					<c:if test="${fn:length(prdtImg) > 1}">
						<div id="detail_paging" class="swiper-pagination"></div>
					</c:if>
				</div>
			</div>

			<div class="product-info">
				<div class="title-area">
					<div class="memo"><c:out value="${prdtInfo.prdtInf}" /></div>
					<div class="title"><c:out value="${prdtInfo.prdtNm}"/></div>
				</div>
			</div>

			<div id="subContent" style="min-height: auto; overflow-y: hidden;">
				<div class="sub-content-img">
					<dl class="view-select">
						<dd class="in coupon">
							<div class="sale-couponWrap2">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td class="text">
											<h3 class="sale"><c:out value="${prdtInfo.disInf}" /></h3>
											<p class="name"><c:out value="${prdtInfo.prdtNm}"/></p>
											<p class="date">
												<fmt:parseDate var="exprStartDt" value="${prdtInfo.exprStartDt}" pattern="yyyyMMdd" />
												<fmt:parseDate var="exprEndDt" value="${prdtInfo.exprEndDt}" pattern="yyyyMMdd" />
												유효기간 : <fmt:formatDate value="${exprStartDt}" pattern="yyyy.MM.dd" /> ~ <fmt:formatDate value="${exprEndDt}" pattern="yyyy.MM.dd" />
											</p>
										</td>
									</tr>
								</table>
								<div class="coupon-save-btn coupon-page-btn">
									<a href="javascript:void(0)" class="view-seller">이메일로 받기</a>
									<a href="javascript:void(0)" onclick="saveInterestProduct();" class="view-app">MY PAGE 저장</a>
								</div>
							</div>
						</dd>
					</dl>
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

				<div class="image-groupA">
					<img src="<c:url value='${dtlImg[0].savePath}${dtlImg[0].saveFileNm}' />" alt="상품상세">
				</div>

				<c:if test="${not empty prdtInfo.adMov}">
					<%-- 홍보영상 --%>
					<div class="video-area youtube">
						<iframe width="100%" height="200" src="${prdtInfo.adMov}" frameborder="0" allowfullscreen></iframe>
					</div>
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

				<div class="image-groupA">
					<c:forEach var="dtlImg" items="${dtlImg}" varStatus="status">
						<c:if test="${status.index != 0}">
							<img src="<c:url value='${dtlImg.savePath}${dtlImg.saveFileNm}' />" alt="상품상세">
						</c:if>
					</c:forEach>
				</div>

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
									<img src="/images/mw/institution/visit-jeju.jpg" alt="visit jeju">
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
							<img class="speciality" src="/images/web/icon/excellence_02.jpg" alt="우수관광사업체">
						</div>
					</c:if>
					<c:if test="${not empty prdtInfo.adtmImg}">
						<div class="l-area icon">
							<img src="${prdtInfo.adtmImg}" width="95" alt="판매처">
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
						<c:if test="${fn:substring(prdtInfo.ctgr, 0, 2) eq 'C2'}">
							<h3 class="title-type2">주변 관광지</h3>
						</c:if>
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
							<c:if test="${((prdtInfo.prdtDiv eq Constant.SP_PRDT_DIV_TOUR) and (fn:length(otherProductList) > 1)) or (fn:substring(prdtInfo.ctgr, 0, 2) eq 'C2')}">
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
							</c:if>
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
														<a href="javascript:void(0)">
															<img src="/images/mw/icon/product_like_on.png" alt="찜하기">
														</a>
													</c:if>
													<c:if test="${empty pocketMap[product.corpId]}">
														<a href="javascript:void(0)" id="pocket${product.corpId }" onclick="fn_listAddPocket('${Constant.ACCOMMODATION}', '${product.corpId }', ' ')">
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
	</div> <!-- //mw-detail-area -->
	<!--//change contents-->
</main>



<!-- 이용후기 사진 레이어 팝업 (클릭시 호출) -->
<div class="review-gallery">
</div>

<!--이메일받기폼-->
<div class="pop-seller">
	<div class="ticket-mail">
		<table class="commRow">
			<tbody>
				<tr>
					<th>받는메일</th>
					<td><input type="text" id="receiver" class="full" placeholder="이메일 주소 입력"></td>
				</tr>
			</tbody>
		</table>
		<p class="comm-button1">
			<a href="javascript:sendFreeCoupon();" class="btn btn1">보내기</a>
			<a href="javascript:hideSendEmail()" class="btn btn5">취소</a>
		</p>
	</div>
</div>
<!-- 콘텐츠 e -->


<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>

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

function timegroup_format(num)
{
    var ret_str = '';
    var n = num.toString();
    if (n.length == 1)
        ret_str += '0' + n;
    else
        ret_str += n;
    return ret_str;
}
$(document).ready(function() {

   // setInterval(updateLeftTime, 1000);
});
</script>
</div>
</body>
</html>

