<!DOCTYPE html>
<html lang="ko">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<jsp:include page="/mw/includeJs.do" >
	<jsp:param name="title" value="탐나오 TAMNAO - 제주도 공식 여행 공공 플랫폼"/>
    <jsp:param name="description" value="안전하고 편리한 제주여행 예약 플랫폼. 렌트카, 숙소, 관광지, 항공 예약 서비스 제공. 제주특별자치도관광협회 운영."/>
    <jsp:param name="keywords" value="제주여행, 제주렌트카, 제주숙소, 제주관광지, 제주특별자치도관광협회, 탐나오"/>
</jsp:include>
<meta property="og:title" content="탐나오 TAMNAO - 제주도 공식 여행 공공 플랫폼" />
<meta property="og:url" content="https://www.tamnao.com/"/>
<meta property="og:description" content="안전하고 편리한 제주여행 예약 플랫폼. 렌트카, 숙소, 관광지, 항공 예약 서비스 제공. 제주특별자치도관광협회 운영." />
<meta property="og:image" content="https://www.tamnao.com/data/sub_main/main_jeju.webp" >

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" href="<c:url value="${pageContext.request.contextPath}/css/mw/common.css?version=${nowDate}"></c:url>">
<link rel="stylesheet" href="<c:url value="${pageContext.request.contextPath}/css/mw/main4.css?version=${nowDate}"></c:url>">
<%-- <link rel="stylesheet" href="<c:url value="${pageContext.request.contextPath}/css/mw/style.css?version=${nowDate}"></c:url>"> --%>
<link rel="canonical" href="https://www.tamnao.com/">
</head>
<body class="main">
<div id="wrap" class="m_wrap">

	<!--mainHead-->
	<jsp:include page="/mw/mainHead.do" />

	<%-- 이벤트 팝업 --%>
	<c:if test="${not empty eventPopup}">
		<%--
		<div class="popup_con">
			<div class="popup_ad">
				<c:forEach var="event" items="${eventPopup}" varStatus="status">
					<a href="${event.url}">
						<img src="<c:url value='${event.imgPath}${event.imgFileNm}' />" alt="${event.bannerNm}" border="0" onerror="this.src='/images/web/other/no-image.jpg'">
					</a>
				</c:forEach>
			</div>
			<div class="popup_close_set">
				<span id="oneDay" class="popup_close2">하루 동안 보지 않기</span>
				<span class="popup_close">닫기</span>
			</div>
		</div>
		<div class="popup_mask"></div> <!-- 이 부분이 배경 Dim 처리임/ 블랙 쉐도우 처리-->
		--%>
		 
		<div class="popup_con">
			<div id="mainPopupAll" class="swiper-container">
				<ul class="swiper-wrapper popup_ad">
					<c:forEach var="event" items="${eventPopup}" varStatus="status">
						<li class="swiper-slide">
							<a href="${event.url}">
								<img src="<c:url value='${event.imgPath}${event.imgFileNm}' />" alt="${event.bannerNm}" border="0" onerror="this.src='/images/web/other/no-image.jpg'">
							</a>
						</li>
					</c:forEach>
				</ul>
				<div id="mainPopupAll_navi" class="swiper-pagination"></div>
			</div>
			<div class="popup_close_set">
				<span id="oneDay" class="popup_close2">하루 동안 보지 않기</span>
				<span class="popup_close">닫기</span>
			</div>
		</div>
		<div class="popup_mask"></div>
	</c:if>
	
	<main id="main">
		<div id="main_area" class="main-area">
			<div id="m_topnav" class="mo_topnav">
				<ul class="topnav_menu">
					<%--<li class="topnav_item">
						<a href="" class="topnav_lnk on clickable">
							<span class="topnav_txt">홈</span>
						</a>
					</li>
					<li class="topnav_item">
						<a href="" class="topnav_lnk clickable">
							<span class="topnav_txt">특산기념품</span>
						</a>
					</li>
					<li class="topnav_item">
						<a href="" class="topnav_lnk clickable">
							<span class="topnav_txt">신상품</span>
						</a>
					</li>--%>
					<li class="topnav_item">
						<a href="/mw/evnt/prmtPlanList.do" class="topnav_lnk clickable">
							<span class="topnav_txt">기획전</span>
						</a>
					</li>
					<li class="topnav_item">
						<a href="/mw/evnt/promotionList.do?finishYn=N&winsYn=N" class="topnav_lnk clickable">
							<span class="topnav_txt">이벤트</span>
						</a>
					</li>
				</ul>
			</div>
			<div id="main_head" class="main-head">
				<!-- Main Top Slider -->
				<div class="main-top-slider">
					<div id="main_top_slider" class="swiper-container">
						<ul class="swiper-wrapper">
							<%--<li class="swiper-slide">
								<div class="Fasten">
									<a href="${pageContext.request.contextPath}/mw/signUp00.do">
										<img src="${pageContext.request.contextPath}/images/mw/common/mainPromoteImg.png" alt="mainPromoteImg" onerror="this.src='/images/web/other/no-image2.jpg'">
									</a>
								</div>
							</li>--%>
							<%-- <c:forEach items="${prmtList}" var="prmt" varStatus="status">
								<c:if test="${prmt.prmtNum eq 'PM00001301'}">
									<li class="swiper-slide">
										<div class="Fasten">
											<a href="${pageContext.request.contextPath}/mw/evnt/detailPromotion.do?prmtNum=${prmt.prmtNum}&winsYn=N&type=${fn:toLowerCase(prmt.prmtDiv)}">
												<img src="${pageContext.request.contextPath}${prmt.mobileMainImg}" alt="${prmt.prmtNm}" onerror="this.src='/images/web/other/no-image2.jpg'">
											</a>
										</div>
									</li>
								</c:if>
							</c:forEach>--%>
							<c:forEach items="${prmtList}" var="prmt" varStatus="prmtStatus">
								<li class="swiper-slide">
									<div class="Fasten">
										<a href="${pageContext.request.contextPath}/mw/evnt/detailPromotion.do?prmtNum=${prmt.prmtNum}&winsYn=N&type=${fn:toLowerCase(prmt.prmtDiv)}">
											<c:choose>
		                                		<c:when test="${prmtStatus.count < 2}">
		                                			<img src="${pageContext.request.contextPath}${prmt.mobileMainImg}" alt="${prmt.prmtNm}" onerror="this.src='/images/web/other/no-image2.jpg'">	
		                                		</c:when>
		                                		<c:otherwise>
		                                			<img src="${pageContext.request.contextPath}${prmt.mobileMainImg}" loading="lazy" alt="${prmt.prmtNm}" onerror="this.src='/images/web/other/no-image2.jpg'">
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
				<!-- //Main Top Slider -->

				<nav class="HomeQuickCategory">
					<div class="HomeQuickCategory_Wrap">
						<a href="/mw/rentcar/jeju.do" class="HomeQuickCategory_Item">
							<span class="HomeQuickCategory_Badge">HOT</span>
							<img src="../../../images/mw/main/menu_001.png" alt="렌트카아이콘" loading="lazy">
							<p>렌트카</p>
						</a>
						<a href="/mw/stay/jeju.do" class="HomeQuickCategory_Item">
							<span class="HomeQuickCategory_Badge">숙소할인</span>
							<img src="../../../images/mw/main/menu_002.png" alt="숙소아이콘" loading="lazy">
							<p>숙소</p>
						</a>
						<a href="/mw/av/mainList.do" class="HomeQuickCategory_Item">
							<span class="HomeQuickCategory_Badge">발권수수료 0원</span>
							<img src="../../../images/mw/main/menu_003.png" alt="항공아이콘" loading="lazy">
							<p>항공</p>
						</a>
						<%--<a href="javascript:void(0);" onClick="alert('준비중입니다.')" class="HomeQuickCategory_Item">
							<img src="../../../images/mw/main/menu_004.png" alt="선박아이콘" loading="lazy">
							<p>선박</p>
						</a>--%>

						<!-- 0821 6차산업 추가 -->
						<a href="/mw/sv/sixIntro.do" class="HomeQuickCategory_Item">
							<span class="HomeQuickCategory_Badge">제주 농부의 장</span>
							<img src="../../../images/mw/main/menu_009.png" alt="6차산업" loading="lazy">
							<p>6차산업</p>
						</a>
					</div>
					<div class="HomeQuickCategory_Wrap">
						<a href="/mw/tour/jeju.do" class="HomeQuickCategory_Item">
							<img src="../../../images/mw/main/menu_005.png" alt="관광지/레저아이콘" loading="lazy">
							<p>관광지/레저</p>
						</a>
						<a href="/mw/goods/jeju.do" class="HomeQuickCategory_Item">
							<img src="../../../images/mw/main/menu_006.png" alt="특산기념품아이콘" loading="lazy">
							<p>특산/기념품</p>
						</a>
						<a href="/mw/tour/jeju.do?sCtgr=C300" class="HomeQuickCategory_Item">
							<img src="../../../images/mw/main/menu_007.png" alt="제주맛집아이콘" loading="lazy">
							<p>제주맛집</p>
						</a>
						<a href="/mw/sp/packageList.do" class="HomeQuickCategory_Item">
							<img src="../../../images/mw/main/menu_008.png" alt="여행사상품아이콘" loading="lazy">
							<p>여행사상품</p>
						</a>
					</div>
				</nav>
			</div> <!-- //main-head -->
			<div class="contents-area">

				<!-- 컨텐츠 리스트 -->
				<div class="main-list-area">
					<div class="main-list">
						<div class="con-header">
							<p class="con-title">지금 제일 잘나가는 상품</p>
							<span class="memo">인기 있수다</span>
						</div>
						<div id="popSlider1" class="swiper-container">
							<ul class="swiper-wrapper">
								<c:forEach var="prdt" items="${mainHotList}" varStatus="mainHotStatus">
									<li class="swiper-slide">
										<a href="${pageContext.request.contextPath}/mw/${fn:toLowerCase(fn:substring(prdt.prdtNum, 0, 2))}/detailPrdt.do?sPrdtNum=${prdt.prdtNum}&prdtNum=${prdt.prdtNum}">
											<div class="main-photo">
												<c:choose>
													<c:when test="${mainHotStatus.index < 2}">
														<img src="${pageContext.request.contextPath}${prdt.imgPath}" alt="${prdt.prdtNm}" onerror="this.src='/images/web/other/no-image.jpg'">
													</c:when>
													<c:otherwise>
														<img src="${pageContext.request.contextPath}${prdt.imgPath}" alt="${prdt.prdtNm}" loading="lazy" onerror="this.src='/images/web/other/no-image.jpg'">
													</c:otherwise>
												</c:choose>
											</div>
											<div class="main-text">
												<div class="j-info">${prdt.prdtExp}</div>
												<div class="j-title">${prdt.prdtNm}</div>
												<c:choose>
													<c:when test="${prdt.prdtNum == 'SP00001434' }">
														<div class="main-price"><fmt:formatNumber>9000</fmt:formatNumber><span class="won">원~</span></div>
													</c:when>
													<c:otherwise>
														<div class="main-price"><fmt:formatNumber>${prdt.saleAmt}</fmt:formatNumber><span class="won">원~</span></div>
													</c:otherwise>
												</c:choose>
											</div>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<%--
					<c:if test="${fn:length(adList) > 0}">
						<div class="main-list">
							<div class="con-header">
								<p class="con-title">숙소</p>
								<span class="memo">365일 할인 진행중!</span>
								<p class="see-all"><a href="${pageContext.request.contextPath}/mw/ad/productList.do?sDaypriceYn=">더보기</a></p>
							</div>
							<div id="popSlider6" class="swiper-container">
								<ul class="swiper-wrapper">
									<c:forEach var="prdt" items="${adList}" begin="0" end="7" varStatus="status">
										<li class="swiper-slide">
											<a href="${pageContext.request.contextPath}/mw/ad/detailPrdt.do?prdtNum=${prdt.prdtNum}&sPrdtNum=${prdt.prdtNum}&sSearchYn=Y&sRoomNum=1&sMen=2&sAdultCnt=2&sChildCnt=0&sBabyCnt=0&sFromDt=${prdtSVO.sFromDt}&sFromDtView=${prdtSVO.sFromDtView}&sToDt=${prdtSVO.sToDt}&sToDtView=${prdtSVO.sToDtView}&sNights=1">
												<div class="main-photo">
													<img src="${pageContext.request.contextPath}${prdt.savePath}thumb/${prdt.saveFileNm}" alt="${prdt.adNm}" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy">
												</div>
												<div class="main-text">
													<div class="j-info">${prdt.adSimpleExp}</div>
													<div class="j-title">${prdt.adNm}</div>
													<div class="main-price"><fmt:formatNumber>${prdt.saleAmt}</fmt:formatNumber><span class="won">원~</span></div>
												</div>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</c:if>
					--%>
					<div class="main-list">
						<div class="con-header">
							<p class="con-title">관광지/레저</p>
							<span class="memo">심심한 여행은 가라!</span>
							<p class="see-all"><a href="${pageContext.request.contextPath}/mw/tour/jeju.do?sCtgr=C200">더보기</a></p>
						</div>
						<div id="popSlider4" class="swiper-container">
							<ul class="swiper-wrapper">
								<c:forEach items="${mainCtgrRcmdTourList}" var="prdt" varStatus="status">
									<li class="swiper-slide">
										<a href="${pageContext.request.contextPath}/mw/sp/detailPrdt.do?prdtNum=${prdt.prdtNum}">
											<div class="main-photo">
												<img src="${pageContext.request.contextPath}${prdt.imgPath}" alt="${prdt.prdtNm}" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy">
											</div>
											<div class="main-text">
												<div class="j-info">${prdt.prdtExp}</div>
												<div class="j-title">${prdt.prdtNm}</div>
												<div class="main-price"><fmt:formatNumber>${prdt.saleAmt}</fmt:formatNumber><span class="won">원~</span></div>
											</div>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>

					<div class="main-list">
						<div class="con-header">
							<p class="con-title">맛집</p>
							<span class="memo">제주에 오면 꼭꼭 먹어봐야할 음식</span>
							<p class="see-all"><a href="${pageContext.request.contextPath}/mw/tour/jeju.do?sCtgr=C300">더보기</a></p>
						</div>
						<div id="popSlider5" class="swiper-container">
							<ul class="swiper-wrapper">
								<c:forEach items="${mainCtgrRcmdEtcList}" var="prdt" varStatus="status">
									<li class="swiper-slide">
										<a href="${pageContext.request.contextPath}/mw/sp/detailPrdt.do?prdtNum=${prdt.prdtNum}">
											<div class="main-photo">
												<img src="${pageContext.request.contextPath}${prdt.imgPath}" alt="${prdt.prdtNm}" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy">
											</div>
											<div class="main-text">
												<div class="j-info">${prdt.prdtExp}</div>
												<div class="j-title">${prdt.prdtNm}</div>
												<div class="main-price"><fmt:formatNumber>${prdt.saleAmt}</fmt:formatNumber><span class="won">원~</span></div>
											</div>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>

					<div class="main-list">
						<div class="con-header">
							<p class="con-title">특산/기념품</p>
							<span class="memo">청정지역 제주 직배송</span>
							<p class="see-all"><a href="${pageContext.request.contextPath}/mw/sv/mainList.do">더보기</a></p>
						</div>
						<div id="popSlider3" class="swiper-container">
							<ul class="swiper-wrapper">
								<c:forEach items="${mainCtgrRcmdSvList}" var="prdt" varStatus="status">
									<li class="swiper-slide">
										<a href="${pageContext.request.contextPath}/mw/sv/detailPrdt.do?prdtNum=${prdt.prdtNum}">
											<div class="main-photo">
												<img src="${prdt.imgPath}" alt="${prdt.prdtNm}" onerror="this.src='/images/web/other/no-image.jpg'" loading="lazy">
											</div>
											<div class="main-text">
												<div class="j-info">${prdt.prdtExp}</div>
												<div class="j-title">${prdt.prdtNm}</div>
												<div class="main-price"><fmt:formatNumber>${prdt.saleAmt}</fmt:formatNumber><span class="won">원~</span></div>
											</div>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div><!-- //컨텐츠 리스트 -->
			</div><!-- //contents-area -->
		</div><!--//main-area-->
	</main>

	<jsp:include page="/mw/foot.do" />
</div> <!-- //wrap -->

<%-- 0921 로딩바개선 
<div class="modal-spinner" style="display: none;">
	<div class="loading-popup">
		<div class="popBg"></div>
		<div class="spinner-con any-stick">
			<strong class="spinner-txt">제주여행 공공 플랫폼 탐나오</strong>
			<div class="spinner-sub-txt">
				<span>실시간 가격 비교</span>
			</div>
			<div class="spinner-sub-txt">
				<span>믿을 수 있는 상품 구매</span>
			</div>
		</div>
	</div>
</div>
--%>
<%-- <script src="/js/mw_air_step1.js?version=${nowDate}"></script> --%>
<script type="application/ld+json">
{
    "@context": "https://schema.org/",
    "@type": "TravelAgency",
    "telephone": "1522-3454",
    "logo": "https://www.tamnao.com/images/web/r_main/floating_logo.png",
    "email": "tamnao@tamnao.com",
    "address": "제주특별자치도 제주시 첨단로 213-65 제주종합비즈니스센터 3층",
    "name": "제주 렌트카, 숙소, 관광지 - 제주여행공공플랫폼 탐나오",
    "description": "안전한고 편리한 예약은 제주여행 공공플랫폼 탐나오 | 렌트카,숙소,관광지,항공 온라인예약 제주특별자치도관광협회 운영",
    "url": "https://www.tamnao.com/",
    "keywords": "제주렌트카, 제주숙소, 제주관광지, 제주도렌트카, 제주도숙소, 제주도관광지, 제주렌터카, 제주도렌터카",
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
<script>

		$(document).ready(function() {
			
			//bg click -> hide hyunseok.kang 2021.09.22
			$(document).on('click', function (e){
				if($('.lock-bg').is(e.target)){
					$('.comm-layer-popup').hide();
					$('.lock-bg').remove();
				}
			});
			
			/*
			//항공예약 자주하는 문의 FAQ layer-pop position chaewan.jung 2021.05.11
			$('.faqList').unbind('click').bind('click', function (e) {
				$('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
				const divTop = Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop() - 760); //상단 좌표

				//레이어 팝업 크기 (항공사별 취소수수료 500px)
				const height = $(this).data('id') == 2 ? '500px' : '300px';

				//레이어 팝업 show
				$('#faq_info_' + $(this).data('id')).css({
					'z-index': '10000',
					'top': divTop,
					'height': height,
					'left': '10px',
					'position': 'absolute'
				}).show();
			});
			*/
		});

		let prevIndex = 0;

		// 화면 사이즈별 슬라이드 설정
		var screenWidth = 360;
		var slideCnt = 2;
		var swiper1 = null;
		//var swiper6 = null;
		var swiper4 = null;
		var swiper5 = null;
		var swiper3 = null;

		function doSwiper() {
			screenWidth = $(window).width();

			if(screenWidth < 720) {
				slideCnt = 2;
			} else {
				slideCnt = 3;
			}

			/**인기있수다 슬라이드*/
			if($('#popSlider1 .swiper-slide').length > 1) {
				if(swiper1 != null) {
					swiper1.destroy();
				}
				swiper1 = new Swiper('#popSlider1', {
					spaceBetween: 20,
					slidesPerView: slideCnt,
					paginationClickable: true,
					loop: true
				});
			}
			/**당일숙박
			if($('#popSlider6 .swiper-slide').length > 1) {
				if(swiper6 != null) {
					swiper6.destroy();
				}
				swiper6 = new Swiper('#popSlider6', {
					spaceBetween: 20,
					slidesPerView: slideCnt,
					paginationClickable: true,
					loop: true
				});
			}
			*/
			/**관광지 슬라이드*/
			if($('#popSlider4 .swiper-slide').length > 1) {
				if(swiper4 != null) {
					swiper4.destroy();
				}
				swiper4 = new Swiper('#popSlider4', {
					spaceBetween: 20,
					slidesPerView: slideCnt,
					paginationClickable: true,
					loop: true
				});
			}
			/**맛집 슬라이드*/
			if($('#popSlider5 .swiper-slide').length > 1) {
				if(swiper5 != null) {
					swiper5.destroy();
				}
				swiper5 = new Swiper('#popSlider5', {
					spaceBetween: 20,
					slidesPerView: slideCnt,
					paginationClickable: true,
					loop: true
				});
			}
			/**제주특산/기념품 슬라이드*/
			if($('#popSlider3 .swiper-slide').length > 1) {
				if(swiper3 != null) {
					swiper3.destroy();
				}
				swiper3 = new Swiper('#popSlider3', {
					spaceBetween: 20,
					slidesPerView: slideCnt,
					paginationClickable: true,
					loop: true
				});
			}
		}

		// 화면 사이즈 변경 이벤트
		$(window).resize(function(){
			var screenWidth2 = $(window).width();
			if(screenWidth2 >= 720) {
				if(screenWidth < 720) {
					doSwiper();
				}
			} else {
				if(screenWidth >= 720) {
					doSwiper();
				}
			}
			$(".bx-wrapper").css("max-width", screenWidth2);
		});

		// layer popup
		function popupOpen() {
			
			$(".popup_con").show();
			$(".popup_mask").show();
			
			/**메인팝업 슬라이드*/
			if($('#mainPopupAll .swiper-slide').length > 1) {
				new Swiper('#mainPopupAll', {
					pagination: '#mainPopupAll_navi',
					paginationClickable: true,
	                loop: false,
                    paginationType: 'fraction', // 'bullets' or 'progress' or 'fraction' or 'custom'
	            });
			} else {
				
			}
			
			// scroll touchmove mousewheel 방지
			$("#wrap").on("scroll touchmove mousewheel", function (e) {
				e.preventDefault();
				e.stopPropagation();
				return false;
			});

			// 닫기
			$(".popup_close").on("click", function() {
				popupClose();
			});
			// 하루 동안 보지 않기
			$(".popup_close2").on("click", function() {
				popupClose();

				if(("localStorage" in window) && window.localStorage != null) {
					var currentTime = new Date().getTime();
					localStorage.setItem("eventPopup", currentTime);
				}
			});
		}

		function popupClose() {
			$(".popup_con").hide();
			$(".popup_mask").hide();
			$("#wrap").off("scroll touchmove mousewheel");
		}

		$(document).ready(function(){

			/**메인 기획전 슬라이드*/
			if($('#main_top_slider .swiper-slide').length > 1) {
				new Swiper('#main_top_slider', {
					pagination: '#main_top_navi',
					paginationClickable: true,
					autoplay: 5000,//임시주석해제
					loop: true,
                    paginationType: 'fraction' // 'bullets' or 'progress' or 'fraction' or 'custom'
				});
			}
			
			/* 해시태그 슬라이드
			$(".hashtagSlide").bxSlider({
				minSlides: 3,
				maxSlides: 5,
				slideWidth: 200,
				speed: 20000,
				ticker: true,
				tickerHover: true,
				useCSS: false
			});
			*/
			
			// 슬라이드
			doSwiper();

			// 이벤트 팝업
			<c:if test="${not empty eventPopup}">
			if(("localStorage" in window) && window.localStorage != null) {
				var expirationDuration = 1000 * 60 * 60 * 24;		// 24h
				var prevTime = localStorage.getItem("eventPopup");
				var currentTime = new Date().getTime();

				var notAccepted = prevTime == undefined;
				var prevAcceptedExpired = prevTime != undefined && currentTime - prevTime > expirationDuration;
				if(notAccepted || prevAcceptedExpired) {
					popupOpen();
				}
			} else {
				$("#oneDay").hide();
			}
			</c:if>
		});
</script>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'TdibWf0qS4-4MQUqPx8duQ'
    };
</script>
<script type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>
