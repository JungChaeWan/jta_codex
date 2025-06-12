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
<jsp:include page="/web/includeJs.do" flush="false">
	<jsp:param name="title" value="제주${ctgrNm} 할인: 제주도관광지의 티켓 및 투어 할인 탐나오"/>
	<jsp:param name="description" value="제주도의 주요 명소 카멜리아힐, 에코랜드, 아르떼뮤지엄등의 수많은 관광지를 제주여행 공공플랫폼 탐나오에서 할인받고 이용하세요."/>
	<jsp:param name="keywords" value="제주관광지,제주도관광지,제주여행,제주도여행,제주핫플,${keys}"/>
</jsp:include>
<meta property="og:title" content="제주${ctgrNm} 할인: 제주도관광지의 티켓 및 투어 할인 탐나오" >
<c:choose>
	<c:when test="${searchVO.sCtgr eq Constant.CATEGORY_TOUR}">
		<meta property="og:url" content="https://www.tamnao.com/web/tour/jeju.do">
	</c:when>
	<c:when test="${searchVO.sCtgr eq 'C270'}">
		<meta property="og:url" content="https://www.tamnao.com/web/tour/jeju.do?sCtgr=C270">
	</c:when>
	<c:when test="${searchVO.sCtgr eq Constant.CATEGORY_ETC}">
		<meta property="og:url" content="https://www.tamnao.com/web/tour/jeju.do?sCtgr=C300">
	</c:when>
	<c:when test="${searchVO.sCtgr eq 'C500'}">
		<meta property="og:url" content="https://www.tamnao.com/web/tour/jeju.do?sCtgr=C500">
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">
<meta property="og:description" content="제주도의 주요 명소 카멜리아힐, 에코랜드, 아르떼뮤지엄등의 수많은 관광지를 제주여행 공공플랫폼 탐나오에서 할인받고 이용하세요.">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Light.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/skeleton.css?version=${nowDate}'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>"> --%>
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style-md.css?version=${nowDate}'/>"> --%>
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/multiple-select.css?version=${nowDate}'/>"> --%>
<link rel="canonical" href="https://www.tamnao.com/web/tour/jeju.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/tour/jeju.do">
<%--sitemap canocical충돌--%>
</head>
<body>
<header id="header">
	<jsp:include page="/web/head.do" flush="false"></jsp:include>
</header>
<main id="main">
    <div class="mapLocation">
	    <div class="inner">
	        <span>홈</span> <span class="gt">&gt;</span>
	        <c:if test="${searchVO.sCtgr eq Constant.CATEGORY_TOUR}">
	            <span>관광지/레저</span>
	        </c:if>
	        <c:if test="${searchVO.sCtgr eq Constant.CATEGORY_ETC}">
	            <span>맛집</span>
	        </c:if>
	        <c:if test="${searchVO.sCtgr eq Constant.CATEGORY_BACS}">
	            <span>유모차/카시트</span>
	        </c:if>
	        <c:if test="${searchVO.sCtgr eq Constant.CATEGORY_ETC_VILLAGE}">
	            <span>체험</span>
	        </c:if>
	    </div>
	</div>
	<c:if test="${searchVO.sCtgr ne Constant.CATEGORY_BACS }">
		<!-- 관광/레저 Slide -->
		<div class="socialTx">
			<div class="inner">
				<c:if test="${searchVO.sCtgr eq Constant.CATEGORY_TOUR}">
					<div class="social-title">관광지/레저</div>
					<div class="social-memo ">심심한 여행은 가라! 다양한 관광지/레저 상품으로 나만의 여행 만들어보세요.</div>
				</c:if>
				<c:if test="${searchVO.sCtgr eq Constant.CATEGORY_ETC}">
					<div class="social-title">제주 맛집</div>
					<div class="social-memo">제주에 오면 꼭꼭 먹어봐야할 음식들 할인받으세요.</div>
					
                    <!-- 제주맛집에만 btn 추가 --> 
                    <div class="contentsWrap restaurant">
                        <div class="btnBox">
                            <button id="popOpenBtnAdd" aria-label="popOpenBtn" class="popOpenBtnCmmn" type="button" data-num="2"></button>
                        </div>
                    </div>
				</c:if>
				<c:if test="${searchVO.sCtgr eq Constant.CATEGORY_ETC_VILLAGE}">
					<div class="social-title">체험</div>
					<div class="social-memo">제주의 자연과 함께, 마을과 함께</div>
				</c:if>
			</div>
		</div>  
					
		<!-- 관광/레저 Slide -->
		<c:if test="${searchVO.sCtgr ne Constant.CATEGORY_ETC and fn:length(bestProductList) > 0 and searchVO.sCtgr ne Constant.CATEGORY_ETC_VILLAGE}">
			<div class="socialBest">
				<div class="inner">
   					<h2 class="tourist-sub">요즘 핫한 제주여행, 꿀잼 보장!</h2>

					<!-- 제주관광지 모아보기 btn 추가 -->
					<div class="contentsWrap">
						<div class="btnBox">
							<button id="popOpenBtn" aria-label="popOpenBtn" class="popOpenBtnCmmn" type="button" data-num="1"></button>
						</div>
					</div>
					<%--
					<div id="popUp_1" class="popCmmn">
						<div class="popBg" data-num="1"></div>
						<div id="zoomMap" class="zoom">
							<img id="zoom_btn" src="/images/web/sub/map_jeju.jpg" width="1520px" height="auto" loading="lazy" alt="제주지도">
						</div>
						<div class="sub_craft">
							<button class="btn_dec" onclick="SaveToDisk('/images/web/sub/map_jeju.jpg','jejuTourMap');">
								<img class="down" src="/images/web/sub/down.png" alt="다운로드">
								<span class="down_txt">다운로드</span>
							</button>
							<button class="popCloseBtnCmmn" type="button" data-num="1">
								<img src="/images/web/sub/close.png" alt="닫기">
							</button>
						</div>
					</div><!-- //제주관광지 모아보기 btn 추가 -->
					--%>
					<!-- 컨텐츠 삽입 -->
					<div></div>
   					<div class="product-area">
   						<div id="product_best" class="swiper-container swiper-container-horizontal">
   							<ul class="swiper-wrapper">
   								<c:forEach items="${bestProductList}" var="bestProduct" varStatus="count" >
    								<li class="swiper-slide" style="margin-right: 37px;">
     									<a href="<c:url value='/web/sp/detailPrdt.do?prdtNum=${bestProduct.prdtNum}&prdtDiv=${bestProduct.prdtDiv}'/>">	
											<div class="photo">
												<c:choose>
													<c:when test="${count.count < 5}">
														<c:if test="${bestProduct.lsLinkYn ne 'Y'}">
															<div class="skeleton_loading">
																<div class="skeleton_img"></div>
															</div>

															<img src="<c:url value='${bestProduct.savePath}thumb/${bestProduct.saveFileNm}'/>" width="275" height="260" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
														</c:if>
														<c:if test="${bestProduct.lsLinkYn eq 'Y'}">
															<img src="<c:url value='${bestProduct.savePath}'/>" width="275" height="260" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
														</c:if>
													</c:when>
													<c:otherwise>
														<c:if test="${bestProduct.lsLinkYn ne 'Y'}">
															<img src="<c:url value='${bestProduct.savePath}thumb/${bestProduct.saveFileNm}'/>" width="275" height="260" loading="lazy" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
														</c:if>
														<c:if test="${bestProduct.lsLinkYn eq 'Y'}">
															<img src="<c:url value='${bestProduct.savePath}'/>" width="275" height="260" alt="product" loading="lazy" onerror="this.src='/images/web/other/no-image.jpg'">
														</c:if>
													</c:otherwise>
												</c:choose>
		                                    </div>
		                                    <div class="bx-info">
												<div class="skeleton_loading">
													<div class="skeleton_text"></div>
													<div class="skeleton_text"></div>
													<div class="skeleton_text"></div>
												</div>
												<div class="text__name"><c:out value='${bestProduct.prdtNm}'/></div>
		                                        <div class="text__memo"><c:out value="${bestProduct.prmtContents}" default="　"/></div>
		                                        <div class="box__price">
		                                        	<span class="text__price">
														<c:if test="${bestProduct.prdtDiv ne Constant.SP_PRDT_DIV_FREE }">
															<fmt:formatNumber value='${bestProduct.saleAmt}'/><span class="text__unit">원~</span>
														</c:if>
														<c:if test="${bestProduct.prdtDiv eq Constant.SP_PRDT_DIV_FREE }">
															무료
														</c:if>					                                            
													</span>
		                                        </div>
		                                    </div>
     									</a>
    								</li>
   								</c:forEach>
   							</ul>
   						</div>
	                    <div id="theme_arrow" class="arrow-box">
	                        <div id="theme_next" class="swiper-button-next"></div>
	                        <div id="theme_prev" class="swiper-button-prev"></div>
	                    </div>   						
   					</div>
				</div>
			</div>
		</c:if>
	</c:if>
	
	<div class="socialItem">
		<h2 class="sec-caption">관광지/레저 목록</h2>

        <div class="inner">

        	<!-- 상품 목록 -->
			<c:if test="${searchVO.sCtgr ne Constant.CATEGORY_BACS}">
				<div class="tab_check">
					<div id="tabArea" class="tabArea1">
						<div class="tabTitle">
							<p>제주지역 선택</p>
	                        <span>여행하실 곳을 선택해주세요.</span>
	                    </div>
	                    <ul class="areaMap">
	                    	<li class="map_list01">
	                        	<div class="areamap">
	                                <input id="area01" type="checkbox" class="are_map" value="" onclick="fn_categorySelect('sSpAdar',this.value); fn_SpSearch(1);">
	                                <label for="area01" class="label_chk">전체</label>
	                            </div>
	                        </li>
	                        <li class="map_list02">
	                            <div class="areamap">
	                                <input name="area" id="area02" type="checkbox" class="are_map" value="JE" onclick="fn_categorySelect('sSpAdar', this.value); fn_SpSearch(1);">
	                                <label for="area02" class="label_chk">제주 시내권</label>
	                            </div>
	                        </li>
	                        <li class="map_list03">
	                            <div class="areamap">
	                                <input name="area" id="area03" type="checkbox" class="are_map" value="EA" onclick="fn_categorySelect('sSpAdar', this.value); fn_SpSearch(1);">
	                                <label for="area03" class="label_chk">제주시 동부</label>
	                            </div>
	                        </li>
	                        <li class="map_list04">
	                            <div class="areamap">
	                                <input name="area" id="area04" type="checkbox" class="are_map" value="WE" onclick="fn_categorySelect('sSpAdar', this.value); fn_SpSearch(1);">
	                                <label for="area04" class="label_chk">제주시 서부</label>
	                            </div>
	                        </li>
	                        <li  class="map_list05">
	                            <div class="areamap">
	                                <input name="area" id="area05" type="checkbox" class="are_map" value="SE" onclick="fn_categorySelect('sSpAdar', this.value); fn_SpSearch(1);">
	                                <label for="area05" class="label_chk">중문/서귀포</label>
	                            </div>
	                        </li>
	                        <li class="map_list06">
	                            <div class="areamap">
	                                <input name="area" id="area06" type="checkbox" class="are_map" value="ES" onclick="fn_categorySelect('sSpAdar', this.value); fn_SpSearch(1);">
	                                <label for="area06" class="label_chk">서귀포 동부</label>
	                            </div>
	                        </li>
	                        <li class="map_list07">
	                            <div class="areamap">
	                                <input name="area" id="area07" type="checkbox" class="are_map" value="WS" onclick="fn_categorySelect('sSpAdar', this.value); fn_SpSearch(1);">
	                                <label for="area07" class="label_chk">서귀포 서부</label>
	                            </div>
	                        </li>
	                    </ul>
					</div>
					<c:if test="${(searchVO.sCtgr ne Constant.CATEGORY_ETC_VILLAGE) and (searchVO.sCtgr ne Constant.CATEGORY_BACS)}">
			            <div id="tabs" class="mainTabMenu1">
			                <div class="tabTitle">
			                    <p>키워드 선택</p>
			                    <span>여행하실 테마를 선택해주세요.</span>
			                </div>
			                <ul id="menuTab" class="menuList">
			                    <li class="all">
			                        <a class="tab select" href="#" onclick="fn_ChangeTab('',this); return false;">전체
			                        </a>
			                    </li>
								<c:forEach items="${cntCtgrPrdtList}" var="cntCtgrPrdtList">
									<c:if test="${cntCtgrPrdtList.prdtCount > 0}">
										<li>
											<a class="tab" id="${cntCtgrPrdtList.ctgr}" href="#" onclick="fn_ChangeTab('${cntCtgrPrdtList.ctgr}',this); return false;"><c:out value="${cntCtgrPrdtList.ctgrNm}"/></a>
										</li>
									</c:if>
								</c:forEach>	                    
			                </ul>
						</div>
					</c:if>
	           	</div>
			</c:if>	
			
            <div class="__sort">
                <div class="sort-filter">
                    <ul>
                        <li class="sortSocial1">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SpSearch(1);" class="sort active" value="${Constant.ORDER_GPA}">탐나오 추천순</button>
                        </li>
                        <li class="sortSocial2">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SpSearch(1);" class="sort" value="${Constant.ORDER_SALE}">판매순</button>
                        </li>
                        <li class="sortSocial3">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SpSearch(1);" class="sort" value="${Constant.ORDER_PRICE}">가격순</button>
                        </li>
                        <li class="sortSocial4">
                            <button type="button" onclick="fn_OrderChange(this.value); fn_SpSearch(1);" class="sort" value="${Constant.ORDER_NEW}">최신등록순</button>
                        </li>
                    </ul>
                </div>
            </div>
            
			<div class="item-area">				
				<ul class="col4" id="div_productAjax"></ul>
				<form action="<c:url value='/web/tour/jeju.do'/>" name="searchForm" id="searchForm" method="get">
					<input type="hidden" name="pageIndex" 	id="pageIndex" 	value="${searchVO.pageIndex}">
					<input type="hidden" name="sCtgr" 		id="sCtgr" 		value="${searchVO.sCtgr}">
					<input type="hidden" name="sTabCtgr" 	id="sTabCtgr" 	value="${searchVO.sTabCtgr}">
					<input type="hidden" name="sPrdtDiv" 	id="sPrdtDiv" 	value="${searchVO.sPrdtDiv}">
					<input type="hidden" name="prdtNum" 	id="prdtNum" />
					<input type="hidden" name="orderCd" 	id="orderCd" 	value="${searchVO.orderCd}">
					<input type="hidden" name="orderAsc" 	id="orderAsc" 	value="${searchVO.orderAsc}">
					<input type="hidden" name="sLON" 		id="sLON" 		value="${searchVO.sLON }">
					<input type="hidden" name="sLAT" 		id="sLAT" 		value="${searchVO.sLAT }">
					<input type="hidden" name="sSpAdar" 	id="sSpAdar" 	value="${searchVO.sSpAdar}">
					<%-- <input type="hidden" name="sPrdtNm" id="sPrdtNm" value="${searchVO.sPrdtNm}"/>통합검색 더보기를 위함 --%>
					<input type="hidden" name="searchWord" 	id="searchWord" value="${searchVO.searchWord}"><%--통합검색 더보기를 위함 --%>
				</form>	
        	</div>
        	<div class="paging-wrap" id="moreBtn">
				<!-- <a href="javascript:void(0)" id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a> -->
				<span id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></span>
			</div>
		</div>
	</div>	        
</main>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>

<script>
    function fn_SpSearch(pageIndex) {
	$("#searchForm input[name=pageIndex]").val(pageIndex);
	$("#curPage").text(pageIndex);

	var parameters = $("#searchForm").serialize();

	$.ajax({
		type:"post",
		url:"<c:url value='/web/sp/productList.ajax'/>",
		data:parameters,
		success:function(data){
			if(pageIndex == 1) {
				$("#div_productAjax").html("");
				$('#moreBtn').show();
			}
			$("#div_productAjax").append(data);
			
			$("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));
			
			if(pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0) {
				$('#moreBtn').hide();
			}
		//	var offset = $("#menuTab").offset();
		//	$('html, body').animate({scrollTop : offset.top}, 0);
		},
		error:function(request,status,error){
	    //    alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}

function fn_SpSearchNoSrc(pageIndex) {
	if("${searchVO.sCtgr}" == "C270"){
		$("#sTabCtgr").val("C270");
	}
	
	$("#searchForm input[name=pageIndex]").val(pageIndex);
	$("#curPage").text(pageIndex);

	var parameters = $("#searchForm").serialize();

	$.ajax({
		type:"post",
		url:"<c:url value='/web/sp/productList.ajax'/>",
		data:parameters,
		success:function(data){
			if(pageIndex == 1) {
				$("#div_productAjax").html("");
				$('#moreBtn').show();
			}
			//console.log("aaaa");
			$("#div_productAjax").append(data);

			$("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));
			
			if(pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0) {
				$('#moreBtn').hide();
			}
		},
		error:function(request,status,error){
	    //    alert("code:"+request.status+"\n"+"\n"+"error:"+error);
 	   }
	});
}

function fn_ChangeTab(tabCtgr, obj){
	$("#sTabCtgr").val(tabCtgr);
	$(".tabList a").removeClass("select");
	$(obj).addClass("select");
	
	fn_SpSearchNoSrc("1");
}

function fn_ChangeOrder(sOrder, obj){
	$("#orderCd").val(sOrder);
	$('#orderUl li').removeClass('select');

	$(obj).parent().addClass('select')
	fn_SpSearchNoSrc("1");
}

function fn_ChangeOrderDist( lat, lon) {
	$("#sLON").val(lon);
	$("#sLAT").val(lat);

	fn_ChangeOrder('${Constant.ORDER_DIST}', $(".distance a"));

	close_popup($('.map-wrap'));
}

function fn_DetailPrdt(prdtNum){
	$("#prdtNum").val(prdtNum);

	document.frm.action = "<c:url value='/web/sp/detailPrdt.do'/>";
	document.frm.submit();
}

function fn_categorySelect(o, v) {

	var checkBoxArr = new Array();
	
	if(v==""){
		if($("#area01").prop("checked")){
			$("input[name=area]").prop("checked",false);
		}else{
			$("#area01").prop("checked",true);
			$("input[name=area]").prop("checked",false);
		}
	}else{
		$("#area01").prop("checked",false);
		if($("input[name=area]").is(":checked") == false){
			$("#area01").prop("checked",true);
		}
	}

	$("input[name=area]:checked").each(function(i){
		checkBoxArr.push($(this).val());
	});

	$('#' + o).val(checkBoxArr);
}

/**
 * 정렬 순서 변경
 */
function fn_OrderChange(orCd){
    $(".sort-filter button").removeClass("active");
    if(orCd == "${Constant.ORDER_GPA}"){
        $(".sortSocial1 button").addClass("active");
    }else if(orCd == "${Constant.ORDER_SALE}"){
        $(".sortSocial2 button").addClass("active");
    }else if(orCd == "${Constant.ORDER_PRICE}"){
        $(".sortSocial3 button").addClass("active");
    }else if(orCd == "${Constant.ORDER_NEW}"){
        $(".sortSocial4 button").addClass("active");
    }	
    
    var orAs;
    if (orCd == "${Constant.ORDER_PRICE}") {
        orAs = "${Constant.ORDER_ASC}";
    } else {
        orAs = "${Constant.ORDER_DESC}";
    }
    $("#orderCd").val(orCd);
    $("#orderAsc").val(orAs);
}
function makeFrame(url,target){
	ifrm = document.createElement( "IFRAME" );
	ifrm.setAttribute( "style", "display:none;" ) ;
	ifrm.setAttribute( "src", url ) ;
	ifrm.setAttribute( "name", target) ;
	ifrm.style.width = 0+"px";
	ifrm.style.height = 0+"px";
	document.body.appendChild( ifrm ) ;
}
function SaveToDisk(fileURL, fileName) {
	// for non-IE
	if (!(window.ActiveXObject || "ActiveXObject" in window)) {
		var link = document.createElement('a');
		link.href = fileURL;
		link.target = '_blank';
		link.download = fileName || fileURL;
		var evt = document.createEvent('MouseEvents');
		evt.initMouseEvent('click', true, true, window, 1, 0, 0, 0, 0,
				false, false, false, false, 0, null);
		link.dispatchEvent(evt);
		(window.URL || window.webkitURL).revokeObjectURL(link.href);
	}
	// for IE
	else if ( window.ActiveXObject || "ActiveXObject" in window )     {
		var link = document.createElement('a');
		link.href = fileURL;
		link.target = "_blank";
		link.download = fileName;
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);
	}

}

$(function () {
	$("#proInfo").click(function() {
		if($(this).prop("checked")) {
			$("#sPrdtDiv").val($(this).val());
		} else {
			$("#sPrdtDiv").val('');
		}
		fn_SpSearch("1", "1");
	});

    $('#moreBtnLink').click(function() {
        if(Number($("#pageIndex").val()) < Number($("#pageInfoCnt").attr('totalPageCnt')) ){
            fn_SpSearchNoSrc(eval($("#pageIndex").val()) + 1);
        }
    });

	fn_SpSearchNoSrc($("#pageIndex").val());
});

$(document).ready(function(){
	
	//setPop();
	
	$("input:checkbox[id='area01']").prop("checked", true);
	$(".sort-filter button").removeClass("active");
	
	if($("#orderCd").val() == "${Constant.ORDER_SALE}") {
        $(".sortSocial2 button").addClass("active");		
	} else if($("#orderCd").val() == "${Constant.ORDER_PRICE}") {
        $(".sortSocial3 button").addClass("active");		
	} else if($("#orderCd").val() == "${Constant.ORDER_NEW}") {
        $(".sortSocial4 button").addClass("active");		
	} else if($("#orderCd").val() == "${Constant.ORDER_GPA}") {
        $(".sortSocial1 button").addClass("active");		
	}

	<c:if test="${searchVO.sCtgr ne 'C300'}">
		//Top Slider Item
		if($('#product_slideItem .swiper-slide').length > 3) {			//4개 이상시 실행
			var swiper = new Swiper('#product_slideItem', {
				slidesPerView: 3,
				paginationClickable: true,
				spaceBetween: 15,
				autoplay: 5000,
				nextButton: '#slideItem_next',
				prevButton: '#slideItem_prev'
			});
		} else {
			$('#slideItem_arrow').hide();
		}
	</c:if>

    /* 지금 제일 잘나가는 상품 */
    if ($('#product_best .swiper-slide').length > 4) {
        new Swiper('#product_best', {
            slidesPerView: 4,
            spaceBetween: 30,
            paginationClickable: true,
            nextButton: '#theme_next',
            prevButton: '#theme_prev',
            autoplay: 5000
        });
    } else {
        new Swiper('#product_best', {
            slidesPerView: 4,
            spaceBetween: 30
        });        	
        $('#theme_arrow').hide();
    }
    
    /** 카데고리 Tab*/
    $('#menuTab a').click(function () {
        $('.mainTabMenu1 .tab').removeClass("select")
        $(this).addClass("select");
        return false;
    });

 	if("${searchVO.sTabCtgr}"){
        $("#" + "${searchVO.sTabCtgr}").click();
    }

 	//관광지도
 	$('#popOpenBtn').on('click',function(){
 		location.href = "<c:url value='/mustsee.do'/>";
	});
	
 	//맛집지도
 	$('#popOpenBtnAdd').on('click',function(){
 		location.href = "<c:url value='/musteat.do'/>";
	});

 	window.onload = function() {
		$(".skeleton_loading").hide();
	}
});
</script>
<!-- 다음DDN SCRIPT START 2017.03.30 -->
<c:if test="${searchVO.sCtgr eq 'C200' }">
<!-- 관광지/레저-->
<script>
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'guZDoCqLQMK9kQ9TJmC1Vg'
    };
</script>
<%-- <script async type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js"></script> --%>
</c:if>
<c:if test="${searchVO.sCtgr eq 'C300' }">
<!-- 음식-->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'d164UG9dQ7C8vQ8lNMcIcg'
    };
</script>
</c:if>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->
<script async type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js"></script>
</body>
</html>