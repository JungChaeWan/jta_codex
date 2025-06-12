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
<c:choose>
	<c:when test="${searchVO.sCtgr eq Constant.CATEGORY_TOUR}">
		<c:set value="관광지" var="ctgrNm"/>
		<c:set value="관광지,레저" var="keys"/>
	</c:when>
	<c:when test="${searchVO.sCtgr eq Constant.CATEGORY_ETC}">
		<c:set value="맛집" var="ctgrNm"/>
		<c:set value="맛집" var="keys"/>
	</c:when>
	<c:when test="${searchVO.sCtgr eq 'C270'}">
		<c:set value="마을체험" var="ctgrNm"/>
		<c:set value="마을체험" var="keys"/>
	</c:when>
	<c:when test="${searchVO.sCtgr eq Constant.CATEGORY_BACS}">
		<c:set value=" 렌트카 카시트, 유모차 대여" var="ctgrNm"/>
		<c:set value="렌트카 카시트, 유모차 대여" var="keys"/>
	</c:when>
	<c:when test="${searchVO.sCtgrTab eq 'C130'}">
		<c:set value="카텔" var="ctgrNm"/>
		<c:set value="카텔" var="keys"/>
	</c:when>
	<c:when test="${searchVO.sCtgrTab eq 'C170'}">
		<c:set value="골프패키지" var="ctgrNm"/>
		<c:set value="골프패키지" var="keys"/>
	</c:when>
	<c:when test="${searchVO.sCtgr eq 'C160'}">
		<c:set value="버스/택시관광" var="ctgrNm"/>
		<c:set value="버스관광,택시관광" var="keys"/>
	</c:when>
	<c:when test="${searchVO.sCtgrTab eq 'C120'}">
		<c:set value="에어카텔" var="ctgrNm"/>
		<c:set value="에어카텔" var="keys"/>
	</c:when>
	<c:when test="${searchVO.sCtgrTab eq 'C140'}">
		<c:set value="에어카" var="ctgrNm"/>
		<c:set value="에어카" var="keys"/>
	</c:when>
	<c:when test="${searchVO.sCtgr eq 'C180'}">
		<c:set value="테마여행" var="ctgrNm"/>
		<c:set value="테마여행" var="keys"/>
	</c:when>
	<c:when test="${searchVO.sCtgr eq 'C420'}">
		<c:set value="렌터카" var="ctgrNm"/>
		<c:set value="렌터카" var="keys"/>
	</c:when>
	<c:when test="${searchVO.sCtgr eq 'C100'}">
		<c:set value="패키지여행" var="ctgrNm"/>
		<c:set value="패키지여행" var="keys"/>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
<jsp:include page="/mw/includeJs.do">
	<jsp:param name="title" value="제주${ctgrNm} 할인: 제주도관광지의 티켓 및 투어 할인 탐나오"/>
	<jsp:param name="description" value="제주도의 주요 명소 카멜리아힐, 에코랜드, 아르떼뮤지엄등의 수많은 관광지를 제주여행 공공플랫폼 탐나오에서 할인받고 이용하세요."/>
	<jsp:param name="keywords" value="제주관광지,제주도관광지,제주여행,제주도여행,제주핫플,${keys}"/>
</jsp:include>
<meta property="og:title" content="제주${ctgrNm} 할인: 제주도관광지의 티켓 및 투어 할인 탐나오" >
<c:choose>
	<c:when test="${searchVO.sCtgr eq Constant.CATEGORY_TOUR}">
		<meta property="og:url" content="https://www.tamnao.com/mw/tour/jeju.do">
	</c:when>
	<c:when test="${searchVO.sCtgr eq 'C270'}">
		<meta property="og:url" content="https://www.tamnao.com/mw/tour/jeju.do?sCtgr=C270">
	</c:when>
	<c:when test="${searchVO.sCtgr eq Constant.CATEGORY_ETC}">
		<meta property="og:url" content="https://www.tamnao.com/mw/tour/jeju.do?sCtgr=C300">
	</c:when>
	<c:when test="${searchVO.sCtgr eq 'C100'}">
		<meta property="og:url" content="https://www.tamnao.com/mw/sp/packageList.do">
	</c:when>
	<c:when test="${searchVO.sCtgr eq Constant.CATEGORY_BACS}">
		<meta property="og:url" content="https://www.tamnao.com/mw/tour/jeju.do?sCtgr=C500">
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
<meta property="og:description" content="제주도의 주요 명소 카멜리아힐, 에코랜드, 아르떼뮤지엄등의 수많은 관광지를 제주여행 공공플랫폼 탐나오에서 할인받고 이용하세요.">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common.css?version=${nowDate}'/>">
<link rel="canonical" href="https://www.tamnao.com/web/tour/jeju.do">
<%--sitemap canocical충돌--%>
</head>
<body id="solist">
<div id="wrap" class="m_wrap">

<!-- 헤더 s -->
<jsp:include page="/mw/newMenu.do"></jsp:include>
<!-- 헤더 e -->

<!-- 콘텐츠 s -->
<main id="main">
	<!--//change contents-->

	<!-- [0116 상품 큐레이션] 추가 s -->
	<div id="pop_Slider1" class="swiper-container">
		<div class="con-header">
			<p class="con-title">요즘 핫한 제주여행, 꿀잼 보장!</p>
		</div>
		<ul class="swiper-wrapper">
			<c:forEach var="bestProduct" items="${bestProductList}" varStatus="status">
				<li class="swiper-slide">
					<a href="<c:url value='/mw/sp/detailPrdt.do?prdtNum=${bestProduct.prdtNum}&prdtDiv=${bestProduct.prdtDiv}'/>">
						<div class="main-photo">
							<c:choose>
								<c:when test="${status.count < 10}">
									<c:if test="${bestProduct.lsLinkYn eq 'Y' }">
										<img src="${bestProduct.savePath}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
									</c:if>
									<c:if test="${bestProduct.lsLinkYn ne 'Y' }">
										<img src="${bestProduct.savePath}thumb/${bestProduct.saveFileNm}" alt="<c:out value='${bestProduct.prdtNm}' />" onerror="this.src='/images/web/other/no-image.jpg'">
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${bestProduct.lsLinkYn eq 'Y' }">
										<img src="${bestProduct.savePath}" loading="lazy" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
									</c:if>
									<c:if test="${bestProduct.lsLinkYn ne 'Y' }">
										<img src="${bestProduct.savePath}thumb/${bestProduct.saveFileNm}" loading="lazy" alt="<c:out value='${bestProduct.prdtNm}' />" onerror="this.src='/images/web/other/no-image.jpg'">
									</c:if>
								</c:otherwise>
							</c:choose>

						</div>
						<div class="main-text">
							<div class="j-info">${bestProduct.prmtContents}</div>
							<div class="j-title"><c:out value='${bestProduct.prdtNm}' /></div>
							<div>
								<dl>
									<dt></dt>
									<dd>
										<c:if test="${bestProduct.prdtDiv ne Constant.SP_PRDT_DIV_FREE}">
											<div class="main-price">
												<strong><fmt:formatNumber value="${bestProduct.saleAmt}" type="number"/><span class="won">원</span></strong>
												<c:if test="${bestProduct.saleAmt ne bestProduct.nmlAmt}">
													<del><fmt:formatNumber value="${bestProduct.nmlAmt}" type="number"/>원</del>
												</c:if>
											</div>
										</c:if>
										<c:if test="${bestProduct.prdtDiv eq Constant.SP_PRDT_DIV_FREE}">
											<div class="main-price">
												<strong class="coup-price">쿠폰상품</strong>
											</div>
										</c:if>
									</dd>
								</dl>
							</div>
						</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	<!-- [0116 상품 큐레이션 추가] e -->

	<div class="mw-list-area">
		<c:if test="${searchVO.sCtgr eq Constant.CATEGORY_PACKAGE and fn:length(corpRcmdList) > 0}">
			<c:set var="C160Cnt" value="0" />
			<c:set var="C170Cnt" value="0" />

			<c:forEach items="${corpRcmdList}" var="corp">
			  	<c:if test="${corp.rcmdDiv eq 'C160'}">
					<c:set var="C160Cnt" value="${C160Cnt + 1}" />
			  	</c:if>
			  	<c:if test="${corp.rcmdDiv eq 'C170'}">
					<c:set var="C170Cnt" value="${C170Cnt + 1}" />
			  	</c:if>
			</c:forEach>
			<section class="recommend-travel">
				<div class="Fasten">
					<h2 class="title"><img src="/images/web/title/recommend.png" alt="" class="icon"> 탐나오 추천 여행사</h2>
					<div class="travel-agency first">
						<h3 class="recommend-title"><a href="javascript:requestTravel('.recommend-list.first')"><img src="<c:url value='/images/mw/travel/bus.png' />" alt=""> 단체관광 문의</a></h3>
						<h3 class="recommend-title"><a href="javascript:requestTravel('.recommend-list.second')"><img src="<c:url value='/images/mw/travel/golf.png' />" alt=""> 골프패키지 문의</a></h3>
						<c:if test="${C160Cnt > 0}">
							<ul class="recommend-list first" style="display: none;">
								<c:forEach items="${corpRcmdList}" var="corp">
									<c:if test="${corp.rcmdDiv eq 'C160'}">
										<li>
											<a href="<c:url value='/mw/sp/corpPrdt.do?sCorpId=${corp.corpId}' />">
												<strong class="name">${corp.corpNm}</strong>
											</a>
											<a href="tel:${corp.rsvTelNum}">
													<%--<span class="tel">${corp.rsvTelNum}</span>--%>
											</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</c:if>
						<c:if test="${C170Cnt > 0}">
							<ul class="recommend-list second" style="display: none;">
								<c:forEach items="${corpRcmdList}" var="corp">
									<c:if test="${corp.rcmdDiv eq 'C170'}">
										<li>
											<a href="<c:url value='/mw/sp/corpPrdt.do?sCorpId=${corp.corpId}&sCtgr=C170' />">
												<strong class="name">${corp.corpNm}</strong>
											</a>
											<a href="tel:${corp.rsvTelNum}">
											</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</c:if>
					</div> <!-- //travel-agency -->
				</div> <!-- //Fasten -->
			</section>
		</c:if>

		<section class="menu-typeA">
			<h2 class="sec-caption">메뉴 선택</h2>
			<form name="searchForm" id="searchForm" method="get">
	        	<input type="hidden" name="pageIndex" 	id="pageIndex" 	value="${searchVO.pageIndex}">
	        	<input type="hidden" name="sCtgr" 		id="sCtgr" 		value="${searchVO.sCtgr}">
	        	<input type="hidden" name="sTabCtgr" 	id="sTabCtgr" 	value="${searchVO.sTabCtgr}">
	        	<input type="hidden" name="sPrice" 		id="sPrice" 	value="${searchVO.sPrice}">
	        	<input type="hidden" name="orderCd" 	id="orderCd" 	value="${searchVO.orderCd}">
				<input type="hidden" name="orderAsc" 	id="orderAsc" 	value="${searchVO.orderAsc}">
	        	<input type="hidden" name="sPrdtDiv" 	id="sPrdtDiv" 	value="${searchVO.sPrdtDiv}">
	        	<input type="hidden" name="sAplDt" 		id="sAplDt" 	value="${searchVO.sAplDt}">
	        	<input type="hidden" name="prdtNum" 	id="prdtNum" />
	        	<input type="hidden" name="sLON" 		id="sLON" 		value="${searchVO.sLON }">
	        	<input type="hidden" name="sLAT" 		id="sLAT" 		value="${searchVO.sLAT }">
				<input type="hidden" name="sSpAdar" 	id="sSpAdar" 	value="${searchVO.sSpAdar}">
	        	<input type="hidden" name="searchWord" 	id="searchWord" value="${searchVO.searchWord}"><%--통합검색 더보기를 위함 --%>
	        </form>
	      	<c:if test="${(searchVO.sCtgr ne Constant.CATEGORY_BACS) and (searchVO.sCtgr ne Constant.CATEGORY_ETC) and (searchVO.sCtgr ne 'C270')}">
				<nav id="scroll_menuA" class="scroll-menuA">
					<div class="scroll-area">
						<ul id="top_menu_list">
							<li class="all">
								<a class="select tx" href="#" onclick="fn_ChangeTab('',this); return false;">전체</a>
							</li>
							<c:forEach items="${cntCtgrPrdtList}" var="cntCtgrPrdtList">
								<c:if test="${cntCtgrPrdtList.prdtCount > 0}">
										<li>
											<a onclick="javascript:fn_ChangeTab('${cntCtgrPrdtList.ctgr}', this); return false;" id="${cntCtgrPrdtList.ctgr}A"><c:out value="${cntCtgrPrdtList.ctgrNm}"/></a>
										</li>
								</c:if>
						  	</c:forEach>
						</ul>
					</div>
				</nav>
		  	</c:if>
		</section>

		<section class="social-list-area sp-tab">
			<div class="option-area">
				<c:if test="${(searchVO.sCtgr ne Constant.CATEGORY_BACS) and (searchVO.sCtgr ne Constant.CATEGORY_PACKAGE)}">
					<select name="sSpAdarSel" aria-label="sSpAdarSel" onchange="fn_categorySelect('sSpAdar', this.value); fn_SpSearch(1);">
						<option value="">제주전체</option>
						<c:forEach items="${cdAdar}" var="area">
							<option value="${fn:trim(area.cdNum)}">${area.cdNm}</option>
						</c:forEach>
					</select>
				</c:if>

				<select title="정렬 선택" onchange="fn_OrderChange(this.value); fn_SpSearch(1);">
					<option value="${Constant.ORDER_SALE}" <c:if test="${searchVO.orderCd eq Constant.ORDER_SALE}">selected</c:if>>판매순</option>
					<option value="${Constant.ORDER_PRICE}" <c:if test="${searchVO.orderCd eq Constant.ORDER_PRICE}">selected</c:if>>가격순</option>
					<option value="${Constant.ORDER_NEW}" <c:if test="${searchVO.orderCd eq Constant.ORDER_NEW}">selected</c:if>>최신상품순</option>
					<option value="${Constant.ORDER_GPA}" <c:if test="${searchVO.orderCd eq Constant.ORDER_GPA}">selected</c:if>>탐나오 추천순</option>
				</select>

				<c:if test="${searchVO.sCtgr eq Constant.CATEGORY_TOUR}">
					<button type="button" class="map-btn" onclick="fn_searchMap()">지도</button>
				</c:if>
			</div>

		    <ul id="prdtList">
				<div class="sec-caption">소셜상품 목록</div>
		    </ul>
	    </section> <!-- //social-list-area -->

	    <div class="paging-wrap" id="moreBtn">
		    <!-- <a href="javascript:void(0)" id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a> -->
		    <span id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></span>
		</div>
	</div> <!--//mw-list-area-->
	<!--//change contents-->
</main>
<!-- 콘텐츠 e -->
<!-- 푸터 s -->
<jsp:include page="/mw/foot.do"></jsp:include>
</div>
<script>
var prevIndex = 0;
function fn_SpSearch(pageIndex) {
	$("#pageIndex").val(pageIndex);
	$("#curPage").text(pageIndex);

	var parameters = $("#searchForm").serialize();

	$.ajax({
		type:"post",
		url:"<c:url value='/mw/sp/productList.ajax'/>",
		data:parameters,
		beforeSend:function(){
	//		$(".loading-wrap").show();
		},
		success:function(data){
			if(pageIndex == 1) {
				$("#prdtList").html("");
			}
			$("#prdtList").append(data);
			$("#totPage").text($("#pageInfoCnt").attr("totalPageCnt"));
			$('#moreBtn').show();
			if(pageIndex >= $("#totPage").text() || $("#pageInfoCnt").attr("totalCnt") == 0) {
				$('#moreBtn').hide();
			}
			++prevIndex;
			history.replaceState($("main").html(), "title", "?prevIndex="+ prevIndex);
			currentState = history.state;
		},
		error:fn_AjaxError
	});
}

function fn_MoreSearch() {
	fn_SpSearch(parseInt($("#pageIndex").val()) + 1);
}

function fn_OrderChange(orCd) {
	var orAs = "${Constant.ORDER_DESC}";

	if(orCd == "${Constant.ORDER_PRICE}") {
		orAs = "${Constant.ORDER_ASC}";
	}
	$("#orderCd").val(orCd);
	$("#orderAsc").val(orAs);
}

/* 거리순 */
function fn_ChangeOrderDist() {
	if(window.navigator.geolocation) {
		window.navigator.geolocation.getCurrentPosition(fn_getGPS_Success, fn_getGPS_Error);
	} else {
		alert("위치 정보를 지원 하지않아 제주국제공항을 기준으로 검색 합니다.");
		fn_ChangeOrderDist_process('33.510418','126.4891594');
	}
}

function fn_getGPS_Success(pos) {
	//alert(pos.coords.latitude + ":" + pos.coords.longitude);
	//pos.coords.timestamp; // 정보를 얻은 시간 (ms)
	//pos.coords.latitude; // 위도
	//pos.coords.longitude; // 경도
	//pos.coords.accuracy; // 위도, 경도 오차 (m)
	//pos.coords.altitude; // 고도
	//pos.coords.altitudeAccuracy; // 고도 오차 (m)
	//pos.coords.speed; // 진행속도 (m/s)
	//pos.coords.heading; // 정북의 시계방향 각도

	fn_ChangeOrderDist_process(pos.coords.latitude, pos.coords.longitude);
}

function fn_getGPS_Error(error) {
	//alert(code + ":" + message);
	//alert("위치 정보를 얻을수 없어 제주국제공항을 기준으로 검색 합니다.");
	var strMsg = "";

	switch(error.code) {
		case error.PERMISSION_DENIED:
			strMsg = "GPS 관련 기능이 차단되 있어서";
	        break;
	    case error.POSITION_UNAVAILABLE:
	    	strMsg = "위치 정보를 찾을 수 없어";
	        break;
	    case error.TIMEOUT:
	    	strMsg = "위치 정보를 얻을 수 있는 시간이 지나서";
	        break;
	    case error.UNKNOWN_ERROR:
	    	strMsg = "위치 정보를 얻을 수 없어";
	        break;
	}
	strMsg += " 제주국제공항을 기준으로 검색 합니다.";
	alert(strMsg);
	fn_ChangeOrderDist_process('33.510418', '126.4891594');
}

function fn_ChangeOrderDist_process(lon, lat) {
	$("#orderCd").val("${Constant.ORDER_DIST}");
	$("#sLON").val(lon);
	$("#sLAT").val(lat);

	fn_SpSearch(1);
}

function fn_categorySelect(o, v) {
	$('#' + o).val(v);
}

//맛집, 여행사 상품일 경우 베스트 비노출
if( "${searchVO.sCtgr}" == "C300" || "${searchVO.sCtgr}" == "C100"){
	$("#pop_Slider1").hide();
}

function fn_ChangeTab(carDiv, obj) {

	//관광지/레저 전체 일때만 베스트 노출
	if (carDiv != "") {
		$("#pop_Slider1").hide();
	}else{
		$("#pop_Slider1").show();
	}

    ++prevIndex;
	history.replaceState($("main").html(), "title", "?prevIndex="+ prevIndex);
	currentState = history.state;

	$("#sTabCtgr").val(carDiv);
 	$("#top_menu_list>li").removeClass("active");
	$(obj).parent().addClass("active");
	$(".tx").removeClass();
	$(this).addClass("tx");

	fn_SpSearch(1);
}

function requestTravel(param){
    if($(param).css("display") == "none") {
        $(".recommend-list").css("display","none");
        $(param).css("display","block");
    } else {
       $(param).css("display","none");
    }
}

function fn_searchMap() {
	var categoryId = $("#sCtgr").val();

	if($("#sTabCtgr").val() != "") {
		categoryId = $("#sTabCtgr").val();
	}
	location.href='<c:url value="/mw/mapSp.do?ctgr="/>' + categoryId;
}

$(document).ready(function(){
    var currentState = history.state;
    if(currentState){
        $("#main").html(currentState);
    }else{
        fn_SpSearch(1);
        if("${searchVO.sCtgr}" != "") {
			$("#${searchVO.sCtgrTab}A").trigger("click");
		}
    }
	
	$("#proInfo").change(function() {
		$("#sPrdtDiv").val($("#proInfo option:selected").val());
		fn_SpSearch(1);
	});

	$('#moreBtnLink').click(function() {
		fn_SpSearch(eval($("#pageIndex").val()) + 1);
	});

	$('#search_btn').on('click', function(){
		if($('.con-box').css('display')=='none') {
			$(this).text('닫기');
			$('.con-box').css('display', 'block');
		} else {
			$(this).text('검색');
			$('.con-box').css('display', 'none');
		}
	});

 	if("${searchVO.sCtgrTab}"){
        $("#" + "${searchVO.sCtgrTab}" + "A").click();
 	}

 	if("${searchVO.sTabCtgr}"){
        $("#" + "${searchVO.sTabCtgr}" + "A").click();
 	}

 	$("#prdtList li ").click(function(){
		++prevIndex;
		history.replaceState($("main").html(), "title", "?prevIndex="+ prevIndex);
	});

	doSwiper();
});

// 화면 사이즈별 슬라이드 설정
var screenWidth = 360;
var slideCnt = 2;
var swiper1 = null;

function doSwiper() {
	screenWidth = $(window).width();

	if (screenWidth < 720) {
		slideCnt = 2;
	} else {
		slideCnt = 3;
	}

	/**카테고리별 추천상품*/
	if ($('#pop_Slider1 .swiper-slide').length > 1) {
		if (swiper1 != null) {
			swiper1.destroy();
		}
		swiper1 = new Swiper('#pop_Slider1', {
			spaceBetween: 20,
			slidesPerView: slideCnt,
			paginationClickable: true,
			loop: true
		});
	}
}

// 화면 사이즈 변경 이벤트
$(window).resize(function () {
	var screenWidth2 = $(window).width();

	if (screenWidth2 >= 720) {
		if (screenWidth < 720) {
			doSwiper();
		}
	} else {
		if (screenWidth >= 720) {
			doSwiper();
		}
	}
	$(".bx-wrapper").css("max-width", screenWidth2);
});

</script>

<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
	<%--관광지/레저--%>
	<c:if test="${searchVO.sCtgr eq 'C200' }">
		var roosevelt_params = {
        	retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        	tag_label:'guZDoCqLQMK9kQ9TJmC1Vg'
    	};
	</c:if>
	<%--맛집--%>
	<c:if test="${searchVO.sCtgr eq 'C300' }">
    	var roosevelt_params = {
        	retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        	tag_label:'d164UG9dQ7C8vQ8lNMcIcg'
    	};
	</c:if>
</script>
<script async type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js"></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
</body>
</html>