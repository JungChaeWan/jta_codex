<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
<jsp:include page="/web/includeJs.do">
	<jsp:param name="title" value="제주숙소 : 호텔, 펜션, 리조트, 제주도여행 공공플랫폼 탐나오"/>
	<jsp:param name="description" value="잊지 못할 여행을 위한 완벽한 숙박 플랫폼, 제주도가 지원하고 제주관광협회가 운영하는 탐나오"/>
	<jsp:param name="keywords" value="제주숙소,제주도숙소,제주숙박,제주도숙박,제주호텔,제주펜션,제주리조트,제주민박,제주게스트하우스,제주풀빌라"/>
</jsp:include>
<meta property="og:title" content="제주숙소 : 호텔, 펜션, 리조트, 제주도여행 공공플랫폼 탐나오">
<meta property="og:url" content="https://www.tamnao.com/web/stay/jeju.do">
<meta property="og:description" content="잊지 못할 여행을 위한 완벽한 숙박 플랫폼, 제주도가 지원하고 제주관광협회가 운영하는 탐나오">
<meta property="og:image" content="https://www.tamnao.com/data/kakao_tamnao.jpg">

<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>

<link rel="preload" as="font" href="/font/NotoSansCJKkr-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/NotoSansCJKkr-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Regular.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Medium.woff2" type="font/woff2" crossorigin="anonymous"/>
<link rel="preload" as="font" href="/font/Roboto-Bold.woff2" type="font/woff2" crossorigin="anonymous"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common2.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>">
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style-md.css?version=${nowDate}'/>"> --%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/ad.css?version=${nowDate}'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/skeleton.css?version=${nowDate}'/>" >
<link rel="canonical" href="https://www.tamnao.com/web/stay/jeju.do">
<link rel="alternate" media="only screen and (max-width: 640px)" href="https://www.tamnao.com/mw/stay/jeju.do">
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
     "@id": "https://www.tamnao.com/web/stay/jeju.do",
     "name": "제주숙소"
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
    <div class="mapLocation">
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>숙소</span>
        </div>
    </div>
    <div id="subContents" class="sub_wrap">
        <form name="frm" id="frm" method="post" onSubmit="return false;">
            <input type="hidden" name="sSearchYn" id="sSearchYn" value="${Constant.FLAG_N}">
            <input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}">
            <%--<input type="hidden" name="sAdAdar" id="sAdAdar" value="${searchVO.sAdAdar}" />--%>
            <%--<input type="hidden" name="sAdDiv" id="sAdDiv" value="${searchVO.sAdDiv}" />--%>
            <input type="hidden" name="sPriceSe" id="sPriceSe" value="${searchVO.sPriceSe}">
            <input type="hidden" name="orderCd" id="orderCd" value="${searchVO.orderCd}">
            <input type="hidden" name="orderAsc" id="orderAsc" value="${searchVO.orderAsc}">
            <input type="hidden" name="sLON" id="sLON">
            <input type="hidden" name="sLAT" id="sLAT">
            <input type="hidden" name="prdtNum" id="prdtNum">
            <input type="hidden" name="sPrdtNum" id="sPrdtNum">
            <input type="hidden" name="sFromDt" id="sFromDt" value="${searchVO.sFromDt}">
            <input type="hidden" name="sToDt" id="sToDt" value="${searchVO.sToDt}">
            <input type="hidden" name="sNights" id="sNights" value="${searchVO.sNights}">
            <input type="hidden" name="sMen" id="sMen" value="${searchVO.sMen}">
            <input type="hidden" name="searchWord" id="searchWord" value="${searchVO.searchWord}"/><%--통합검색 더보기를 위함 --%>
            <input type="hidden" id="minPrice" value="0">
            <input type="hidden" id="maxPrice" value="1000000">
            <div class="filter_wrap">
                <div class="filter_check">
                    <div class="f_hd">
                        <h2>숙소검색</h2>
                    </div>
                    <div class="f_con">
                        <div class="date_wrap">
                            <div class="date_checkin">
                                <label>체크인</label>
                                <div class="value-text">
                                    <div class="date-container">
                                		<span class="date-pick">
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
                            <a onclick="optionPopup('#hotel_count', this)" id="room_person_str">
                                <c:if test="${empty searchVO.sAdultCnt}">
                                    성인 2
                                </c:if>
                                <c:if test="${not empty searchVO.sAdultCnt}">
                                    성인 ${searchVO.sAdultCnt }
                                    <c:if test="${searchVO.sChildCnt > 0 }">, 소아 ${searchVO.sChildCnt }</c:if>
                                    <c:if test="${searchVO.sBabyCnt > 0 }">, 유아 ${searchVO.sBabyCnt }</c:if>
                                </c:if>
                            </a></div>
                            <div id="hotel_count" class="popup-typeA hotel-count">
                                <div class="detail-area">
                                    <input type="hidden" name="sRoomNum" id="sRoomNum" value="1">
                                </div>
                                <div class="detail-area counting-area">
                                    <div class="counting">
                                        <div class="l-area">
                                            <strong class="sub-title">성인</strong>
                                            <span class="memo">만 13세 이상</span>
                                        </div>
                                        <div class="r-area">
                                            <input type="hidden" name="sAdultCnt" value="<c:if test="${empty searchVO.sAdultCnt}">2</c:if><c:if test="${not empty searchVO.sAdultCnt}">${searchVO.sAdultCnt }</c:if>">
                                            <button type="button" class="counting-btn" onclick="chg_person('-', 'Adult')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                            <span class="counting-text" id="AdultNum"><c:if test="${empty searchVO.sAdultCnt}">2</c:if><c:if test="${not empty searchVO.sAdultCnt}">${searchVO.sAdultCnt }</c:if></span>
                                            <button type="button" class="counting-btn" onclick="chg_person('+', 'Adult')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                        </div>
                                    </div>
                                    <div class="counting">
                                        <div class="l-area">
                                            <strong class="sub-title">소아</strong>
                                            <span class="memo">만 2 ~ 13세 미만</span>
                                        </div>
                                        <div class="r-area">
                                            <input type="hidden" name="sChildCnt" value="<c:if test="${empty searchVO.sChildCnt}">0</c:if><c:if test="${not empty searchVO.sChildCnt}">${searchVO.sChildCnt }</c:if>">
                                            <button type="button" class="counting-btn" onclick="chg_person('-', 'Child')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                            <span class="counting-text" id="ChildNum"><c:if test="${empty searchVO.sChildCnt}">0</c:if><c:if test="${not empty searchVO.sChildCnt}">${searchVO.sChildCnt }</c:if></span>
                                            <button type="button" class="counting-btn" onclick="chg_person('+', 'Child')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                        </div>
                                    </div>
                                    <div class="counting">
                                        <div class="l-area">
                                            <strong class="sub-title">유아</strong>
                                            <span class="memo">만 2세(24개월) 미만</span>
                                        </div>
                                        <div class="r-area">
                                            <input type="hidden" name="sBabyCnt" value="<c:if test="${empty searchVO.sBabyCnt}">0</c:if><c:if test="${not empty searchVO.sBabyCnt}">${searchVO.sBabyCnt }</c:if>">
                                            <button type="button" class="counting-btn" onclick="chg_person('-', 'Baby')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                            <span class="counting-text" id="BabyNum"><c:if test="${empty searchVO.sBabyCnt}">0</c:if><c:if test="${not empty searchVO.sBabyCnt}">${searchVO.sBabyCnt }</c:if></span>
                                            <button type="button" class="counting-btn" onclick="chg_person('+', 'Baby')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                        </div>
                                    </div>
                                </div>
                                <div class="detail-area info-area">
                                    <ul class="list-disc sm">
                                        <li>업체별로 연령 기준은 다를 수 있습니다.</li>
                                    </ul>
                                </div>
                                <button class="map--btn map--btn_default" onclick="fn_Search_LayerClose();">
                                    적용
                                </button>
                            </div>
                        </div>
                        <div class="search_btn">
                            <a href="javascript:fn_AdSearch('1')">검색</a>
                        </div>
                    </div>
                </div><!-- filter_check -->
                <div class="filter_map">
                    <a href="javascript:funcClear();layer_popup('#ad_map');fn_MapAdSearch('1','mapSearch');">
                        <!-- <a href="/web/map.do?typeCd=AD" > -->
                        <p>지도에서 보기</p>
                        <img src="../../images/web/ad/bkg-map-entry.png" width="265" height="104" alt="지도로 검색">
                    </a>
                </div><!-- filter_map -->
                <!-- 0304 탐나는전 check point -->
                <div class="filter_jejupay">
                    <div class="pay-check">
                        <input type="checkbox" name="tcard_yn" id="tcard_yn" value="Y"  onclick="filter6()">
                        <label for="tcard_yn">
                            <img src="../../images/web/icon/jeju_pay_icon.png" width="22" height="20" alt="탐나는전">
                            <span>탐나는전 가맹점 보기</span>
                        </label>
                    </div>
                </div><!-- //0304 탐나는전 check point -->

<%--                <!-- 20241031 할인쿠폰 보기 -->
                <div class="filter_coupon-view">
                    <div class="coupon-toggle">
                        <input type="checkbox" name="couponCnt" id="couponCnt" value="1"  onclick="filter7()">
                        <label for="couponCnt">
                            <img src="../../images/web/icon/coupon-view.png" width="22" height="20" alt="할인쿠폰">
                            <span>할인쿠폰 보기</span>
                        </label>
                    </div>
                </div><!-- //20241031 할인쿠폰 보기 -->--%>

                <div class="filter_refine">
                    <div class="filter_header">
                        <button type="button" onclick="funcClear();"> 전체해제 </button>
                    </div>
                    <div class="item-list">
                        <div class="category-tit">할인혜택</div>
                        <ul>
                            <li>
                                <input type="checkbox" id="d_disct" name="d_disct" class="rf_chk" value="Y" onclick="filter4()">
                                <label for="d_disct" class="label_chk">당일특가</label>
                            </li>
                            <li>
                                <input type="checkbox" id="c_disct" name="c_disct" class="rf_chk" value="Y" onclick="filter5()">
                                <label for="c_disct" class="label_chk">연박할인</label>
                            </li>
                        </ul>
                    </div>
                    <div class="item-list">
                        <div class="category-tit">지역</div>
                        <ul>
                            <c:forEach var="code" items="${cdAdar}" varStatus="status">
                                <li>
                                    <input type="checkbox" id="region_${status.index}" name="sAdAdar" class="rf_chk" value="${code.cdNum}" onclick="filter1()">
                                    <label for="region_${status.index}" class="label_chk">${code.cdNm}</label>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="item-list">
                        <div class="category-tit">유형</div>
                        <ul>
                            <c:forEach var="code" items="${cdAddv}" varStatus="status">
                                <li>
                                    <input type="checkbox" id="type_${status.index}" name="sAdDiv" class="rf_chk" value="${code.cdNum}" onclick="filter2()">
                                    <label for="type_${status.index}" class="label_chk" >${code.cdNm}</label>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="item-list price_bar">
                        <div class="category-tit f_price">가격</div>
                        <p>
                            <input type="text" id="slideAmount" readonly aria-label="slideAmount">
                        </p>
                        <div class="area type select stay">
                            <div class="type1">
                                <div id="slider-range" class="ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all">
                                    <span class="ui-slider-handle ui-state-default ui-corner-all"></span>
                                    <span class="ui-slider-handle ui-state-default ui-corner-all"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item-list">
                        <div class="category-tit">편의시설</div>
                        <ul class="hide_type half">
                            <c:forEach var="code" items="${cdAdat}" varStatus="status">
                                <li>
                                    <input type="checkbox" id="info_${status.index}" name="sIconCd" class="rf_chk" value="${code.cdNum}" onclick="filter3()" >
                                    <label for="info_${status.index}" class="label_chk">${code.cdNm}</label>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div><!-- filter_refine -->
            </div><!-- filter_wrap -->
        </form>
        <div class="list_wrap">
            <div class="stay_best">
                <h2 class="sbt">탐나오 추천숙소!</h2>
                <nav class="stayRegion">
                    <div class="r_list">
                        <span class="r_best promotion active">Promotion</span>
                    </div>
                    <div class="r_list">
                        <span class="r_best">Best</span>
                    </div>
                    <%--<div class="r_list">
                        <span class="r_best">연박할인</span>
                    </div>--%>
                </nav>
                <div id="detail_slider" class="swiper-container" style="display: block;">
                    <ul class="swiper-wrapper">
                        <c:forEach items="${prmtList }" var="data2" varStatus="status" >
                            <li class="swiper-slide">
                                <a href="javascript:fn_DetailPrdt('${data2.prdtNum}', '${data2.corpCd}', '${todayDate}','','${data2.corpId}')" class="bt_stay">
                                    <div class="btPhoto">
                                        <div class="skeleton_loading">
                                            <div class="skeleton_img"></div>
                                        </div>
                                        <img src="<%--<spring:message code='url.real'/>--%>${data2.savePath}thumb/${data2.saveFileNm}" alt="product">
                                    </div>
                                    <div class="btInfo">

                                        <div class="skeleton_loading">
                                            <div class="skeleton_text"></div>
                                            <div class="skeleton_text"></div>
                                            <div class="skeleton_text"></div>
                                        </div>

                                        <div class="btTitle">${data2.adNm}</div>
                                        <div class="btEvent">${data2.prmtContents}</div>
                                        <div class="btPrice"><fmt:formatNumber value='${data2.saleAmt}'/><span class="won">원</span></div>
                                    </div>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                    <div id="slideItem_arrow" class="arrow-box">
                        <div id="slideItem_next" class="swiper-button-next"></div>
                        <div id="slideItem_prev" class="swiper-button-prev"></div>
                    </div>
                </div>
                <div id="detail_slider2" class="swiper-container" style="display: none;">
                    <ul class="swiper-wrapper">
                        <c:forEach items="${bestList }" var="data" varStatus="status" >
                            <li class="swiper-slide">
                                <a href="/web/ad/detailPrdt.do?corpId=${data.corpId}" target="_blank" class="bt_stay">
                                    <div class="btPhoto">
                                        <img src="<%--<spring:message code='url.real'/>--%>${data.savePath}thumb/${data.saveFileNm}" loading="lazy" alt="product">
                                    </div>
                                    <div class="btInfo">
                                        <div class="btTitle">${data.corpNm}</div>
                                        <div class="btEvent">${data.simpleExp}</div>
                                        <div class="btPrice"><fmt:formatNumber value='${data.saleAmt}'/><span class="won">원</span></div>
                                    </div>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                    <div id="slideItem_arrow2" class="arrow-box">
                        <div id="slideItem_next2" class="swiper-button-next"></div>
                        <div id="slideItem_prev2" class="swiper-button-prev"></div>
                    </div>
                </div>

            </div><!-- stay_best -->
            <div class="stay_event">
                <div class="area_flex">
                    <a href="/web/evnt/detailPromotion.do?prmtNum=${adPrmt.prmtNum}" target="_blank" aria-label="이벤트 상세 보기">
                        <p class="ba_t">${adPrmt.prmtNm}</p>
                    </a>
                </div>
            </div>
            <div class="stay_list">
                <div class="__sort">
                    <div class="sort-filter main">
                        <ul>
                            <li class="sortHotel1 main">
                                <button type="button" onclick="fn_OrderChange(this.value,'main'); fn_AdSearch(1);" class="sort active" value="${Constant.ORDER_GPA}">탐나오 추천순</button>
                            </li>
                            <li class="sortHotel2 main">
                                <button type="button" onclick="fn_OrderChange(this.value,'main'); fn_AdSearch(1);" class="sort" value="${Constant.ORDER_SALE}">판매순</button>
                            </li>
                            <li class="sortHotel3 main">
                                <button type="button" onclick="fn_OrderChange(this.value,'main'); fn_AdSearch(1);" class="sort" value="${Constant.ORDER_PRICE}">낮은가격순</button>
                            </li>
                            <li class="sortHotel4 main">
                                <button type="button" onclick="fn_OrderChange(this.value,'main'); fn_AdSearch(1);" class="sort" value="${Constant.ORDER_PRICE_DESC}">높은가격순</button>
                            </li>
                            <li class="sortHotel5 main">
                                <button type="button" onclick="fn_OrderChange(this.value,'main'); fn_AdSearch(1);" class="sort" value="${Constant.ORDER_NEW}">최신등록순</button>
                            </li>
                        </ul>
                        <div class="sort-search">
                            <input type="text" id="searchWord1" class="" placeholder="검색 결과 내 숙소명 검색" autocapitalize="off" onkeyup="filter0(this.value)">
                            <button type="button" title="검색" class="sort-search-btn"></button>
                        </div>
                    </div>
                </div>
                <div id="prdtDiv" class="stay-list"></div>

                <!-- 0921 로딩바개선 -->
                <div class="modal-spinner">
                    <div class="popBg"></div>
                    <div class="loading-popup">
                        <div class="spinner-con">
                            <strong class="spinner-txt">제주여행 공공 플랫폼 탐나오</strong>
                            <div class="spinner-sub-txt">
                                <span>믿을 수 있는 상품 구매</span>
                            </div>
                        </div>
                    </div>
                </div><!-- //0921 로딩바개선 -->

            </div><!-- stay_list -->
        </div><!-- list_wrap -->
        <div class="paging-wrap" id="moreBtn">
            <%-- <a href="javascript:void(0)" id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a> --%>
            <a id="moreBtnLink" class="mobile">더보기 <span id="curPage">1</span>/<span id="totPage">1</span></a>
        </div>
    </div> <!-- //subContents -->
    <div id="ad_map" class="comm-layer-popup_fixed admap">
        <div class="map_wrap">
            <div class="maps-head"></div>
            <div class="maps-body">
                <div class="map_close">
                    <button type="button" class="close">
                        <!--<img src="../../images/web/btn/map_close.png" alt="닫기">-->
                    </button>
                </div>
                <!-- new contents -->
                <div class="map-service">
                    <!--map form-->
                    <div class="bgWrap">
                        <div class="map-sidePanel">
                            <div class="sidebar-con">
                                <div class="f_con">
                                    <div class="date_wrap">
                                        <div class="date_checkin">
                                            <div class="value-text">
                                                <div class="date-container">
													<span class="date-pick">
                                    					<input class="datepicker" type="text" id="sFromDtMap" name="sFromDtMap" value="${searchVO.sFromDtMap}" placeholder="입실일 선택" onclick="optionClose('.popup-typeA')">
													</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="date_checkout">
                                            <div class="value-text">
                                                <div class="date-container">
													<span class="date-pick">
 				                                   		<input class="datepicker" type="text" id="sToDtMap" name="sToDtMap" value="${searchVO.sToDtMap}" placeholder="퇴실일 선택" onclick="optionClose('.popup-typeA')">
													</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- date_wrap -->
                                    <div class="custom_wrap">
                                        <div class="value-text">
                                        <%-- <a href="javascript:void(0)" onclick="optionPopup('#map_hotel_count', this)" id="map_room_person_str"> --%>
                                        <a onclick="optionPopup('#map_hotel_count', this)" id="map_room_person_str">
                                            <c:if test="${empty searchVO.sAdultCnt}">
                                                성인 2
                                            </c:if>
                                            <c:if test="${not empty searchVO.sAdultCnt}">
                                                성인 ${searchVO.sAdultCnt }
                                                <c:if test="${searchVO.sChildCnt > 0 }">, 소아 ${searchVO.sChildCnt }</c:if>
                                                <c:if test="${searchVO.sBabyCnt > 0 }">, 유아 ${searchVO.sBabyCnt }</c:if>
                                            </c:if>

                                        </a></div>
                                        <div id="map_hotel_count" class="popup-typeA hotel-count">
                                            <div class="detail-area counting-area">
                                                <div class="counting">
                                                    <div class="l-area">
                                                        <strong class="sub-title">성인</strong>
                                                        <span class="memo">만 13세 이상</span>
                                                    </div>
                                                    <div class="r-area">
                                                        <button type="button" class="counting-btn" onclick="chg_person('-', 'Adult')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                        <span class="counting-text" id="mapAdultNum"><c:if test="${empty searchVO.sAdultCnt}">2</c:if><c:if test="${not empty searchVO.sAdultCnt}">${searchVO.sAdultCnt }</c:if></span>
                                                        <button type="button" class="counting-btn" onclick="chg_person('+', 'Adult')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                    </div>
                                                </div>
                                                <div class="counting">
                                                    <div class="l-area">
                                                        <strong class="sub-title">소아</strong>
                                                        <span class="memo">만 2 ~ 13세 미만</span>
                                                    </div>
                                                    <div class="r-area">
                                                        <button type="button" class="counting-btn" onclick="chg_person('-', 'Child')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                        <span class="counting-text" id="mapChildNum"><c:if test="${empty searchVO.sChildCnt}">0</c:if><c:if test="${not empty searchVO.sChildCnt}">${searchVO.sChildCnt }</c:if></span>
                                                        <button type="button" class="counting-btn" onclick="chg_person('+', 'Child')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                    </div>
                                                </div>
                                                <div class="counting">
                                                    <div class="l-area">
                                                        <strong class="sub-title">유아</strong>
                                                        <span class="memo">만 2세(24개월) 미만</span>
                                                    </div>
                                                    <div class="r-area">
                                                        <button type="button" class="counting-btn" onclick="chg_person('-', 'Baby')"><img src="/images/web/main/form/subtraction.png" alt="빼기"></button>
                                                        <span class="counting-text" id="mapBabyNum"><c:if test="${empty searchVO.sBabyCnt}">0</c:if><c:if test="${not empty searchVO.sBabyCnt}">${searchVO.sBabyCnt }</c:if></span>
                                                        <button type="button" class="counting-btn" onclick="chg_person('+', 'Baby')"><img src="/images/web/main/form/addition.png" alt="더하기"></button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="map_search_btn">
										<a href="javascript:fn_MapAdSearch('1','mapSearch');">검색</a>
                                    </div>
                                </div>
                                <div class="__sort">
                                    <div class="sort-filter map">
                                        <ul>
                                            <li class="sortHotel1 map">
                                                <button type="button" onclick="fn_OrderChange(this.value,'map'); fn_MapAdSearch(1);" class="sort active" value="${Constant.ORDER_GPA}">탐나오 추천순</button>
                                            </li>
                                            <li class="sortHotel2 map">
                                                <button type="button" onclick="fn_OrderChange(this.value,'map'); fn_MapAdSearch(1);" class="sort" value="${Constant.ORDER_SALE}">판매순</button>
                                            </li>
                                            <li class="sortHotel3 map">
                                                <button type="button" onclick="fn_OrderChange(this.value,'map'); fn_MapAdSearch(1);" class="sort" value="${Constant.ORDER_PRICE}">가격순</button>
                                            </li>
                                            <li class="sortHotel4 map">
                                                <button type="button" onclick="fn_OrderChange(this.value,'map'); fn_MapAdSearch(1);" class="sort" value="${Constant.ORDER_NEW}">최신등록순</button>
                                            </li>
                                        </ul>
                                    </div>
                                    <div id="mapAdList" class="stay-list">	</div>
                                </div>
                                <%-- <a href="javascript:void(0);" class="go-top" onclick="go_top_map()" style="display: none"> --%>
                                <a id="go-top-none" class="go-top" onclick="go_top_map()" style="display: none">
                                    <img src="/images/web/comm/top.png" alt="맨위로">
                                </a>
                            </div><!-- sidebar-con -->
                        </div> <!-- map-sidePanel -->

                        <div class="map-wrap">
                            <!--검색-->
                            <div class="map-check">
                                <div class="map-check-inner">
                                    <c:forEach var="code" items="${cdAddv}" varStatus="status">
                                        <label><input name="mapChk" id="mapType_${status.index}" value="${code.cdNum}" type="checkbox" onclick="fn_check();"><span>${code.cdNm}</span></label>
                                    </c:forEach>
                                </div>
                            </div>
                            <!--map-->
                            <div class="map-box">
                                <div id="map">
                                    <div id="mapAdPoint" class="point"></div>
                                    <p id="result"></p>
                                </div>
                            </div>
                        </div> <!--//map-wrap-->
                    </div> <!--//bgWrap-->
                </div> <!-- //map-service -->
            </div> <!-- //maps-body -->
        </div> <!-- //map_wrap -->
    </div>
</main>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71cf66fb54158dacb5fb5b656674ad70"></script>

<script>
    let prevIndex = 0;
    /** 검색시에만 지도초기화  */
	mapFlag = true;
	
	function fn_AdSearch(pageIndex){
	    /** 최초실행이 아닐경우 */
	    if($("#sSearchYn").val() != "N"){
	        $(".stay_best").hide();
	        $(".stay_event").hide();
	    }
	    $("#sSearchYn").val("Y");
	
	    $("#pageIndex").val(pageIndex);
	    $("#curPage").text(pageIndex);
	    var parameters = $("#frm").serialize();
	
	    $.ajax({
	        type:"post",
	        url:"<c:url value='/web/ad/adList.ajax'/>",
	        data:parameters ,
	        beforeSend:function(){
	            if (pageIndex == 1) {
	                $("#prdtDiv").html("");
	            }
	            $(".modal-spinner").show();
	        },
	        success:function(data){
	            /** 최초실행 이후 */
	            $(".modal-spinner").hide();
	            $("#prdtDiv").append(data);
	
	            $("#totPage").text($("#pageInfoCnt").attr('totalPageCnt'));
	
	            if (pageIndex == $("#totPage").text() || $("#pageInfoCnt").attr('totalCnt') == 0){
	                $('#moreBtn').hide();
	            }
	            filter1();
	            filter2();
	            filter3();
	            filter4();
	            filter5();
	            filter6();
                filter7();
	
	            var priceCnt = 0;
	            prices = []
	            $("#prdtDiv .itemPrdt").each(function () {
	                var price = $(this).attr('data-price');
	                const rsvAbleYn = $(this).attr('data-rsvAbleYn');
	                if(rsvAbleYn == 'Y') {
	                    prices[priceCnt] = price;
	                    ++priceCnt;
	                }
	            });
	
	            $("#minPrice").val(Math.min.apply(Math,prices));
	            $("#maxPrice").val(Math.max.apply(Math,prices));
	            if($("#minPrice").val() > 0){
	                filterPrice();
	                sliderRange();
	            }
	            ++prevIndex;
				history.replaceState($("main").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
				currentState = history.state;
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        }
	    });
	
	}
	
	function fn_Search_LayerClose(){
	    $("#hotel_count").hide();
	}
	
	function fn_MapAdSearch(pageIndex, flag){
	    if(flag == "mapSearch"){
	        mapFlag = true;
	        $('body').css({overflow:'hidden'});
	    }
	
	    $(".sort-filter.map button").removeClass("active");
	    if($("#orderCd").val() == "${Constant.ORDER_SALE}") {
	        $(".sortHotel2.map button").addClass("active");
	    } else if($("#orderCd").val() == "${Constant.ORDER_PRICE}") {
	        $(".sortHotel3.map button").addClass("active");
	    } else if($("#orderCd").val() == "${Constant.ORDER_NEW}") {
	        $(".sortHotel4.map button").addClass("active");
	    } else if($("#orderCd").val() == "${Constant.ORDER_GPA}") {
	        $(".sortHotel1.map button").addClass("active");
	    }
	
	    if(mapFlag == true){
	        $("#map").empty();
	        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	            mapOption = {
	                center: new kakao.maps.LatLng(33.36571286933408, 126.56998311968185), // 지도의 중심좌표
	                level: 9 // 지도의 확대 레벨
	            };
	
	        map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	        map.relayout();
	
	        kakao.maps.event.addListener(map, 'zoom_changed', function() {
	            fn_check();
	        });
	
	        kakao.maps.event.addListener(map, 'dragend', function() {
	            fn_check();
	        });
	    }
	
	    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
	        $(".MarkerPopup-popup").hide();
	        $(".IconInner").removeClass("active");
	        $("#mapAdList div").removeClass("active");
	        $("#mapAdList div").blur();
	    });
	
	    $("input[name=mapChk]").prop("checked",false);
	    $(".MarkerPopup-popup").hide();
	
	    $("#pageIndex").val(pageIndex);
	    $("#curPage").text(pageIndex);
	
	    var parameters = $("#frm").serialize();
	    $.ajax({
	        type:"post",
	        url:"<c:url value='/web/mapAdList.ajax'/>",
	        data:parameters ,
	        success:function(data){
	
	            $("#mapAdList").html("");
	            var sFromDtMap = $("#sFromDtMap").val().replace(/-/g,'');
	            data.mapAdList.forEach(function(item, index){
	
	                //숙소 List 생성
	                var html = "";
	                html += '<div data-attr-value="' + item.corpId +'" data-filter="' + item.adDiv + '" data-filter-visible="Y" >'
	                html += '<a href="javascript:fn_searchMap(\''+ item.corpId + '\',\''+ item.lat + '\',\''+ item.lon + '\')">'
	                html += '<div class="i-photo">'
	                html +=	 '<img class="product" src="'+  item.savePath + "thumb/" + item.saveFileNm + '" onerror="this.src=\'/images/web/other/no-image.jpg\'" alt="product">'
	                html += '</div>'
	                html += '<div class="inner-info">'
	                html += '<h3>' + item.adNm + '</h3>'
	                html += '<span class="star">'
	                for(i=1 ; i<=5; i++){
	                    if(parseInt(item.gpaAvg)<i){
	                        html += '<svg viewBox="0 0 1000 1000" role="presentation" aria-hidden="true" focusable="false" style="height:12px; width:12px; fill:rgb(202,202,202)">'
	                        html += '   <path d="M972 380c9 28 2 50-20 67L725 619l87 280c11 39-18 75-54 75-12 0-23-4-33-12L499 790 273 962a58 58 0 0 1-78-12 50 50 0 0 1-8-51l86-278L46 447c-21-17-28-39-19-67 8-24 29-40 52-40h280l87-279c7-23 28-39 52-39 25 0 47 17 54 41l87 277h280c24 0 45 16 53 40z"></path>'
	                        html += '</svg>'
	                    }else{
	                        html += '<svg viewBox="0 0 1000 1000" role="presentation" aria-hidden="true" focusable="false" style="height:12px; width:12px; fill:currentColor">'
	                        html += '   <path d="M972 380c9 28 2 50-20 67L725 619l87 280c11 39-18 75-54 75-12 0-23-4-33-12L499 790 273 962a58 58 0 0 1-78-12 50 50 0 0 1-8-51l86-278L46 447c-21-17-28-39-19-67 8-24 29-40 52-40h280l87-279c7-23 28-39 52-39 25 0 47 17 54 41l87 277h280c24 0 45 16 53 40z"></path>'
	                        html += '</svg>'
	                    }
	                }
	                html += '<span class="star-num">'
	                if(item.gpaCnt != 0){
	                    html +=	 '(' + item.gpaCnt + ')'
	                }
	                html += '</span>'
	                html += '</span>'
	                html += '<div class="loc"><img src="/images/web/icon/icon_location02.png" width="10" height="16" alt="위치">' + item.adAreaNm + '</div>'
	                if(item.adSimpleExp != null){
	                    html += '<span class="info_memo">' + item.adSimpleExp + '</span>'
	                }
	                html += '<div class="bxLabel">'
	                if(item.eventCnt > 0) {
	                    html += ' <span class="main_label eventblue">이벤트</span>'
	                }
	                if(item.couponCnt == "1") {
	                    html += ' <span class="main_label pink">할인쿠폰</span>'
	                }
	                if(item.daypriceYn == "Y"){
	                    html += ' <span class="main_label pink">당일특가</span>'
	                }
	                if(item.continueNightYn == "Y"){
	                    html += ' <span class="main_label back-red">연박할인</span>'
	                }
	                if(item.superbCorpYn == "Y"){
	                    html += ' <span class="main_label back-red">우수관광사업체</span>'
	                }
	                if(item.tamnacardYn == "Y"){
	                    html += ' <span class="main_label yellow">탐나는전</span>'
	                }
	                html += '</div>'
	                html += '<div class="inner-price">'
	                if (item.stayNight < item.minRsvNight) {
	                    html += '<span class="text__comment">' + item.minRsvNight + '박 이상 예약 가능</span>'
	                }
	                html += '<span class="bxPrice">'
	                if (item.nmlAmt != item.saleAmt) {
	                    html += '<span class="per_sale">' + parseInt((item.nmlAmt - item.saleAmt) / item.nmlAmt * 100) + '<small>%</small></span>'
	                }
	                html += '<span class="text__price">' + parseInt(item.saleAmt).toLocaleString() + '</span><span class="text__unit">원</span></span>'
	                html += '<em>' + $("#sNights").val() + '박기준</em>'
	
	                html += '</div>'
	                html += '</div>'
	                html += '</a>'
	                html += '<a href="javascript:fn_DetailPrdt(' + "'" + item.prdtNum + "'," + "'" + item.corpCd + "'," + "'" + sFromDtMap + "'," + "'Map'," + "'" + item.corpId + "')" + '" class="detail_btn" type="button">자세히보기</a>';
	                html += '</div>';
	
	                $("#mapAdList").append(html);
	
	                if(!item.adSimpleExp){
	                    item.adSimpleExp = "";
	                }
	
	                if(mapFlag == true){
	                    //지도 금액 오버레이 생성
	                    var content = '<div class="MarkerIcon-content" id="' + item.corpId + '" data-filter="' + item.adDiv + '" data-filter-visible="Y" >'+
	                        '<div class="MarkerIcon-wrap">'+
	                        '<button class="MarkerIcon-btn" onclick="javascript:goPrdtList(\'${Constant.ACCOMMODATION}\', \'' + item.corpId + '\', \''+ item.adNm + '\' , \''+ item.prdtNum + '\', \''+ item.savePath + '\', \''+ item.saveFileNm + '\' , \''+ item.adNm + '\' , \''+ item.adSimpleExp + '\');">'+
	                        '<div class="IconBtn">'+
	                        '<div class="IconInner">'+
	                        '<span>₩ ' + parseInt(item.saleAmt).toLocaleString() + '</span>'+
	                        '</div>'+
	                        '</div>'+
	                        '</button>'+
	                        '</div>'+
	                        '</div>';
	
	                    var overlay = new kakao.maps.CustomOverlay({
	                        map: map,
	                        position: new kakao.maps.LatLng(item.lat, item.lon),
	                        content: content
	                    });
	
	                    // 마커가 지도 위에 표시되도록 설정합니다
	                    overlay.setMap(map);
	                    map.relayout();
	                }
	            });
	        },
	        error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"\n"+"error:"+error);
	        }
	    });
	}

	function fn_searchMap(corpId,lat,lng) {
	    var moveLatLon = new kakao.maps.LatLng(lat, lng);
	    map.setCenter(moveLatLon);
	    $("#map div#" + corpId + " button.MarkerIcon-btn").click();
	}
	
	function goPrdtList(corpCd, corpId, corpNm, prdtNum, savePath, saveFileNm, adNm, adSimpleExp) {
	    $(".IconInner").removeClass("active");
	    $("#"+corpId + " div.IconInner").addClass("active");
	
	    $(".MarkerPopup-popup").remove();
	    var html = "";
	    var sFromDtMap = $("#sFromDtMap").val().replace(/-/g,'');
	
	    html = '<div class="MarkerPopup-popup">';
	    html += '	<a href="javascript:fn_DetailPrdt('+"'"+prdtNum + "'," +"'"+corpCd + "'," +"'"+ sFromDtMap  + "'," + "'Map'," + "'"+corpId+"')" +'" class="MarkerPopup-popup-link">';
	    html += '		<div class="MarkerPopup-popup-container">';
	    html += '			<div class="MarkerPic">';
	    html += '				<figure class="MarkerPopup-popup-media">';
	    html +=	 '				<img class="MarkerPopup-popup-img unfold" src="'+ savePath + "thumb/" + saveFileNm + '" onerror="this.src=\'/images/web/other/no-image.jpg\'" alt="product">';
	    html += '				</figure>';
	    html += '			</div>';
	    html += '			<div class="MarkerPopup-popup-info">';
	    html += '				<div class="btTitle">' + adNm + '</div>';
	    if(adSimpleExp){
	        html += '			<div class="btPrice">' + adSimpleExp + '</div>';
	    }
	    html += '			</div>';
	    html += '		</div>';
	    html += '	</a>';
	    html += '</div>';
	
	    $("#" + corpId).before(html);
	
	    /** 오버레이 팝업 위치 */
	    $(".MarkerPopup-popup").css("position","absolute");
	
	    if(navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1){ //IE버전일 경우에만
	        $(".MarkerPopup-popup").css("top","-260px");
	        $(".MarkerPopup-popup").css("left","-75px");
	    }else{
	        $(".MarkerPopup-popup").css("top","-245px");
	        $(".MarkerPopup-popup").css("left","-110px");
	    }
	
	    /** 팝업Z-INDEX 초기화 */
	    $(".MarkerIcon-content").parent().css("z-index",'1');
	    /** 클릭된 팝업Z-INDEX 최상위 */
	    $(".MarkerPopup-popup").parent().css("z-index",'9999');
	
	    $("[data-attr-value]").each(function() {
	        let compVal = $(this).attr("data-attr-value");
	        let compElement = $(this);
	        compElement.removeClass("active");
	
	        if(compVal == corpId){
	            compElement.attr("tabindex", -1).focus();
	            compElement.addClass("active");
	        }
	    });
	}
	
	// 객실수 및 인원 정보 수정
	function modify_room_person() {
	    var str = "성인 " + $('#AdultNum').text();
	    if ($('#ChildNum').text() > 0) {
	        str += ", 소아 " + $('#ChildNum').text();
	    }
	    if ($('#BabyNum').text() > 0) {
	        str += ", 유아 " + $('#BabyNum').text();
	    }
	    $('#room_person_str').text(str);
	    $('#map_room_person_str').text(str);
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
	
	    $('#map' + gubun + 'Num').text(num);
	    $('#' + gubun + 'Num').text(num);
	    $('input[name=s' + gubun + 'Cnt]').val(num);
	
	    var sMen = eval($('#AdultNum').text()) + eval($('#ChildNum').text()) + eval($('#BabyNum').text());
	    $('#sMen').val(sMen);
	    modify_room_person();
	}
	
	function fn_DetailPrdt(prdtNum, corpCd, fromDt, flag, corpId){
	    if(prdtNum){
	        $("#sPrdtNum").val(prdtNum);
	        $("#prdtNum").val(prdtNum);
	    }
	    if(fromDt){
	        $("#sFromDt").val(fromDt);
	    }
	
	    if(flag == "Map"){
	        $("#sFromDtView").val($("#sFromDtMap").val());
	        $("#sToDtView").val($("#sToDtMap").val());
	    }

	    ++prevIndex;
        history.replaceState($("main").html(), "title"+ prevIndex, "?prevIndex="+ prevIndex);
        currentState = history.state;

	    document.frm.target = "_self";
	    if(corpCd == "${Constant.ACCOMMODATION}"){
	        if(corpId){
	            document.frm.action = "/web/ad/detailPrdt.do?corpId=" + corpId ;
	            document.frm.submit();
            }else{
                document.frm.action = "<c:url value='/web/ad/detailPrdt.do'/>";
    	        document.frm.submit();
            }
	    }else{
	        return false;
	        document.frm.action = "<c:url value='/web/sp/detailPrdt.do'/>";
	        document.frm.submit();
	    }


	}
	
	function fn_OrderChange(orCd, type) {
	    if(type == "main"){
	        $(".sort-filter.main button").removeClass("active");
	        if(orCd == "${Constant.ORDER_GPA}"){
	            $(".sortHotel1.main button").addClass("active");
	        }else if(orCd == "${Constant.ORDER_SALE}"){
	            $(".sortHotel2.main button").addClass("active");
	        }else if(orCd == "${Constant.ORDER_PRICE}"){
	            $(".sortHotel3.main button").addClass("active");
	        }else if(orCd == "${Constant.ORDER_PRICE_DESC}"){
	            $(".sortHotel4.main button").addClass("active");
	        }else if(orCd == "${Constant.ORDER_NEW}"){
	            $(".sortHotel5.main button").addClass("active");
	        }
	    }
	
	    if(type == "map"){
	        mapFlag = false;
	        $(".IconInner").removeClass("active");
	        $(".sort-filter.map button").removeClass("active");
	        if(orCd == "${Constant.ORDER_GPA}"){
	            $(".sortHotel1.map button").addClass("active");
	        }else if(orCd == "${Constant.ORDER_SALE}"){
	            $(".sortHotel2.map button").addClass("active");
	        }else if(orCd == "${Constant.ORDER_PRICE}"){
	            $(".sortHotel3.map button").addClass("active");
	        }else if(orCd == "${Constant.ORDER_PRICE_DESC}"){
	            $(".sortHotel4.main button").addClass("active");
	        }else if(orCd == "${Constant.ORDER_NEW}"){
	            $(".sortHotel5.main button").addClass("active");
	        }
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
	
	function fn_categorySelect(o, v) {
	    $('#' + o).val(v);
	}
	
	$(document).ready(function(){

        const currentState = history.state;
		if(currentState){
			$("#main").html(currentState);
		}else{
			fn_AdSearch(1);
		}

	    //파라미터값 호출 처리
        if ("${searchVO.sCouponCnt}" == "1"){
            $("#couponCnt").prop("checked", true);
        }

        //TOP버튼 클릭 시 스크롤 상단으로 이동
	    $(".sidebar-con").scroll(function(event) {
	        var scrollHeight = $(".sidebar-con").scrollTop();
	        if(scrollHeight > 400){
	            $(".go-top").fadeIn("slow");
	        } else {
	            $(".go-top").fadeOut("fast");
	        }
	    });
	
	    //닫기버튼 클릭 시 메인 스크롤 생성
	    $('.map_close').click( function() {
	        $('body').css({overflow:'visible'});
	    } );
	
	    // 여백 클릭 시 팝업 닫기
	    $(document).mouseup(function (e){
	        var divPop = $(".popup-typeA");
	        var container = $("#hotel_count");
	        var mapContainer = $("#map_hotel_count");
	
	        if(divPop.has(e.target).length == 0){
	            divPop.hide();
	            return;
	        }
	        if( container.has(e.target).length === 0){
	            container.css('display','none');
	            return;
	        }
	        if( mapContainer.has(e.target).length === 0){
	            mapContainer.css('display','none');
	            return;
	        }
	    });
	
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
	        onClose : function(selectedDate) {
	            var fromDt = new Date(selectedDate);
	            /** 시작검색일 SET*/
	            $('#sFromDt').val($('#sFromDtView').val().replace(/-/g, ''));
	            fromDt.setDate(fromDt.getDate() + 1);
	            selectedDate = fromDt.getFullYear() + "-" + (fromDt.getMonth() + 1) + "-" + fromDt.getDate();
	            /** 종료검색일 SET*/
	            $("#sToDtView").datepicker("option", "minDate", selectedDate);
	            $('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
	            var toDt = new Date($("#sToDtView").val());
	            fromDt.setDate(fromDt.getDate() - 1);
	            var nightNum = (toDt.getTime() - fromDt.getTime()) / (3600 * 1000 * 24);
	            if (nightNum < 1)
	                nightNum = 1;
	            $("#sNights").val(nightNum);
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
	        onClose : function(selectedDate) {
	            var toDt = new Date(selectedDate);
	            var fromDt = new Date($("#sFromDtView").val());
	            $('#sToDt').val($('#sToDtView').val().replace(/-/g, ''));
	            $("#sNights").val((toDt.getTime() - fromDt.getTime()) / (3600 * 1000 * 24));
	        }
	    });
	
	    $("#sFromDtMap").datepicker({
	        showOn: "both",
	        buttonImage: "/images/web/icon/calendar_icon01.gif",
	        buttonImageOnly: true,
	        showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
	        numberOfMonths: [ 1, 2 ],									//여러개월 달력 표시
	        stepMonths: 2, 												//좌우 선택시 이동할 개월 수
	        dateFormat: "yy-mm-dd",
	        minDate: "${SVR_TODAY}",
	        maxDate: '+12m',
	        onClose : function(selectedDate) {
	            var fromDt = new Date(selectedDate);
	            /** 시작검색일 SET*/
	            $('#sFromDt').val($('#sFromDtMap').val().replace(/-/g, ''));
	            fromDt.setDate(fromDt.getDate() + 1);
	            selectedDate = fromDt.getFullYear() + "-" + (fromDt.getMonth() + 1) + "-" + fromDt.getDate();
	            /** 종료검색일 SET*/
	            $("#sToDtMap").datepicker("option", "minDate", selectedDate);
	            $('#sToDt').val($('#sToDtMap').val().replace(/-/g, ''));
	            var toDt = new Date($("#sToDtMap").val());
	            fromDt.setDate(fromDt.getDate() - 1);
	            var nightNum = (toDt.getTime() - fromDt.getTime()) / (3600 * 1000 * 24);
	            if (nightNum < 1)
	                nightNum = 1;
	            $("#sNights").val(nightNum);
	        }
	    });
	
	    $("#sToDtMap").datepicker({
	        showOn: "both",
	        buttonImage: "/images/web/icon/calendar_icon01.gif",
	        buttonImageOnly: true,
	        showOtherMonths: true, 										//빈칸 이전달, 다음달 출력
	        numberOfMonths: [ 1, 2 ],									//여러개월 달력 표시
	        stepMonths: 2, 												//좌우 선택시 이동할 개월 수
	        dateFormat: "yy-mm-dd",
	        minDate: "${SVR_TODAY}",
	        maxDate: '+12m',
	        onClose : function(selectedDate) {
	            var toDt = new Date(selectedDate);
	            var fromDt = new Date($("#sFromDtMap").val());
	            $('#sToDt').val($('#sToDtMap').val().replace(/-/g, ''));
	            $("#sNights").val((toDt.getTime() - fromDt.getTime()) / (3600 * 1000 * 24));
	        }
	    });
	
	    /*fn_AdSearch($("#pageIndex").val());*/
	    const sAdadar = '${searchVO.sAdAdar}';
	    const arrAdadar = sAdadar.split(',');
	    if(arrAdadar){
	        for (let i = 0; i < arrAdadar.length; i ++ ){
	            $("input[name=sAdAdar][value='"+arrAdadar[i]+"']").prop("checked",true);
	        }
	        filter1();
	    }
	
	    if("${searchVO.sAdDiv}"){
	        $("input[name=sAdDiv][value='${searchVO.sAdDiv}']").prop("checked",true);
	        filter2();
	    }
	
	    if("${searchVO.sIconCd}"){
	        var sIconCd = "${searchVO.sIconCd}";
	        sIconCd= sIconCd.replace(/\s|\[|\]/g,"");
	
	        $("input[name=sIconCd][value="+sIconCd+"]").click();
	        filter3();
	    }
	
	    if($('#detail_slider .swiper-slide').length > 1) {
	        var swiper = new Swiper('#detail_slider', {
	            slidesPerView: 4,
	            pagination: '#slideItem_paging',
	            nextButton: '#slideItem_next',
	            prevButton: '#slideItem_prev',
                autoplay: 5000,
	            loop: true,
	            observer: true,
	            observeParents: true
	        });
	    }
	
	    if($('#detail_slider2 .swiper-slide').length > 1) {
	        var swiper2 = new Swiper('#detail_slider2', {
	            slidesPerView: 4,
	            pagination: '#slideItem_paging2',
	            nextButton: '#slideItem_next2',
	            prevButton: '#slideItem_prev2',
                autoplay: 5000,
	            loop: true,
	            observer: true,
	            observeParents: true
	        });
	    }
	
	    $('.r_list').each(function(i){
	        $(this).click(function(e){
	            $(".r_best").removeClass("active");
	            $(this).children('.r_best').addClass("active");
	            if($(this).children('.r_best').hasClass("promotion")){
	                $("#detail_slider2").hide();
	                $("#detail_slider").show();
	            }else{
	                $("#detail_slider2").show();
	                $("#detail_slider").hide();
	            }
	        });
	    });

	    $(".sort-filter button").removeClass("active");
	
	    if($("#orderCd").val() == "${Constant.ORDER_SALE}") {
	        $(".sortHotel2 button").addClass("active");
	    } else if($("#orderCd").val() == "${Constant.ORDER_PRICE}") {
	        $(".sortHotel3 button").addClass("active");
	    } else if($("#orderCd").val() == "${Constant.ORDER_NEW}") {
	        $(".sortHotel4 button").addClass("active");
	    } else if($("#orderCd").val() == "${Constant.ORDER_GPA}") {
	        $(".sortHotel1 button").addClass("active");
	    }
	
	    let type = "${param.type}";
	    if(type == "map"){
	        layer_popup('#ad_map');
	        fn_MapAdSearch('1');
	    }

	    window.onload = function() {
            $(".skeleton_loading").hide();
        }
	});
	/** 숙소명필터*/
	function filter0(val){
	    $("[data-filter0]").each(function() {
	        var thisVal = $(this).attr("data-filter0");
	        var compVal = val;
	        thisVal = thisVal.toUpperCase();
	        compVal = compVal.toUpperCase();
	
	        if(thisVal.indexOf(compVal) != -1){
	            $(this).attr("data-filter0-visible","Y");
	        }else{
	            $(this).attr("data-filter0-visible","N");
	        }
	
	    });
	    filterFunc();
	}
	/** 지역필터*/
	function filter1(){
	    if($('input[name=sAdAdar]:checked').length == $('input[name=sAdAdar]').length || $('input[name=sAdAdar]:checked').length == 0 ){
	        $(".itemPrdt").attr("data-filter1-visible","Y");
	        filterFunc();
	        return;
	    }
	    $("[data-filter1]").each(function() {
	        var compVal = $(this).attr("data-filter1");
	        var compElement = $(this);
	        compElement.attr("data-filter1-visible","N");
	        $("input[name=sAdAdar]:checked").each(function() {
	            if($(this).val() == compVal){
	                compElement.attr("data-filter1-visible","Y");
	            }
	        });
	    });
	    filterFunc();
	}
	/** 유형필터 */
	function filter2(){
	    if($('input[name=sAdDiv]:checked').length == $('input[name=sAdDiv]').length || $('input[name=sAdDiv]:checked').length == 0 ){
	        $(".itemPrdt").attr("data-filter2-visible","Y");
	        filterFunc();
	        return;
	    }
	    $("[data-filter2]").each(function() {
	        var compVal = $(this).attr("data-filter2");
	        var compElement = $(this);
	        compElement.attr("data-filter2-visible","N");
	        $("input[name=sAdDiv]:checked").each(function() {
	            if($(this).val() == compVal){
	                compElement.attr("data-filter2-visible","Y");
	            }
	        });
	    });
	    filterFunc();
	}
	
	/** 주요정보필터 */
	function filter3(){
	
	    if($('input[name=sIconCd]:checked').length == 0 ){
	        $(".itemPrdt").attr("data-filter3-visible","Y");
	        filterFunc();
	        return;
	    }
	
	    $(".itemPrdt").attr("data-filter3-visible","Y");
	    $("[data-filter3]").each(function() {
	        var compElement = $(this);
	        $('input[name=sIconCd]:checked').each(function(){
	            if(compElement.attr("data-filter3").indexOf($(this).val()) == -1){
	                compElement.attr("data-filter3-visible","N");
	                return;
	            }
	        });
	    });
	    filterFunc();
	}
	
	/** 당일특가 */
	function filter4(){
	    if($('input[name=d_disct]:checked').length == 0 ){
	        $(".itemPrdt").attr("data-filter4-visible","Y");
	        filterFunc();
	        return;
	    }
	
	    $(".itemPrdt").attr("data-filter4-visible","Y");
	    $("[data-filter4]").each(function() {
	        var compElement = $(this);
	        if($('input[name=d_disct]:checked').val() == compElement.attr("data-filter4")){
	            compElement.attr("data-filter4-visible","Y");
	        }else{
	            compElement.attr("data-filter4-visible","N");
	        }
	    });
	    filterFunc();
	}
	
	/** 연박할인 */
	function filter5(){
	    if($('input[name=c_disct]:checked').length == 0 ){
	        $(".itemPrdt").attr("data-filter5-visible","Y");
	        filterFunc();
	        return;
	    }
	
	    $(".itemPrdt").attr("data-filter5-visible","Y");
	    $("[data-filter5]").each(function() {
	        var compElement = $(this);
	        if($('input[name=c_disct]:checked').val() == compElement.attr("data-filter5")){
	            compElement.attr("data-filter5-visible","Y");
	        }else{
	            compElement.attr("data-filter5-visible","N");
	        }
	    });
	    filterFunc();
	}
	
	/** 탐나는전 */
	function filter6(){
	    if($('input[name=tcard_yn]:checked').length == 0 ){
	        $(".itemPrdt").attr("data-filter6-visible","Y");
	        filterFunc();
	        return;
	    }
	
	    $(".itemPrdt").attr("data-filter6-visible","Y");
	    $("[data-filter6]").each(function() {
	        var compElement = $(this);
	        if($('input[name=tcard_yn]:checked').val() == compElement.attr("data-filter6")){
	            compElement.attr("data-filter6-visible","Y");
	        }else{
	            compElement.attr("data-filter6-visible","N");
	        }
	    });
	    filterFunc();
	}

    /** 할인쿠폰 */
    function filter7(){
        if($('input[name=couponCnt]:checked').length == 0 ){
            $(".itemPrdt").attr("data-filter7-visible","1");
            filterFunc();
            return;
        }

        $(".itemPrdt").attr("data-filter7-visible","1");
        $("[data-filter7]").each(function() {
            var compElement = $(this);
            if($('input[name=couponCnt]:checked').val() == compElement.attr("data-filter7")){
                compElement.attr("data-filter7-visible","1");
            }else{
                compElement.attr("data-filter7-visible","0");
            }
        });
        filterFunc();
    }

	/** 금액필터*/
	function filterPrice(){
	    $("[data-price]").each(function() {
	        if(Number($(this).attr("data-price")) <= Number($("#maxPrice").val()) && Number($(this).attr("data-price")) >= Number($("#minPrice").val()) ){
	            $(this).attr("data-price-visible","Y");
	        }else{
	            $(this).attr("data-price-visible","N");
	        }
	    });
	}
	
	function filterFunc(){
	    $(".itemPrdt").each(function(index) {
	        if($(this).attr("data-filter0-visible") == "N" || $(this).attr("data-filter1-visible") == "N" || $(this).attr("data-filter2-visible") == "N" || $(this).attr("data-filter3-visible") == "N" || $(this).attr("data-filter4-visible") == "N" || $(this).attr("data-filter5-visible") == "N" || $(this).attr("data-filter6-visible") == "N" || $(this).attr("data-filter7-visible") == "0" || $(this).attr("data-price-visible") == "N" ){
	            $(this).hide();
	        }else{
	            $(this).show();
	        }
	    });
	    if(
	        $('.itemPrdt').filter(function() {
	            return $(this).css('display') != 'none';
	        }).length < 1
	    ){
	        $(".item-noContent").remove();
	        var insTag = "";
	        insTag += "<div class=\"item-noContent\">";
	        insTag +=      "<p><img src=\"<c:url value='/images/web/icon/warning2.gif'/>\" alt=\"경고\"></p>";
	        insTag += 	   "<p class=\"text\">죄송합니다.<br><span class=\"comm-color1\">해당상품</span>에 대한 검색결과가 없습니다.</p>";
	        insTag += "</div>";
	        $("#prdtDiv").append(insTag);
	    }else{
	        $(".item-noContent").remove();
	    }
	}
	
	function sliderRange(){
	    $( "#slider-range" ).slider({
	        range: true,
	        step: 5000,
	        min: Number($("#minPrice").val()),
	        max: Number($("#maxPrice").val()),
	        values: [ Number($("#minPrice").val()), Number($("#maxPrice").val()) ],
	        slide: function( event, ui ) {
	            $( "#slideAmount" ).val( commaNum(ui.values[ 0 ]) + "원" + " - " + commaNum(ui.values[ 1 ]) + "원" );
	            $("#minPrice").val(ui.values[ 0 ]);
	            $("#maxPrice").val(ui.values[ 1 ]);
	            filterPrice();
	            filterFunc();
	        }
	    });
	    $( "#slideAmount" ).val( commaNum($( "#slider-range" ).slider( "values", 0 )) + "원" + " - " + commaNum($( "#slider-range" ).slider( "values", 1 )) + "원" );
	}
	
	function funcClear(){
	    $("input[type=checkbox]").prop("checked",false);
	    $("#searchWord1").val("");
	    filter0("");
	    filter1();
	    filter2();
	    filter3();
	    filter4();
	    filter5();
	    filter6();
        filter7();
	    var $slider = $("#slider-range");
	    $slider.slider("values", 0, $( "#slider-range" ).slider( "option", "min" ));
	    $slider.slider("values", 1, $( "#slider-range" ).slider( "option", "max" ));
	    $("#minPrice").val($( "#slider-range" ).slider( "option", "min" ));
	    $("#maxPrice").val($( "#slider-range" ).slider( "option", "max" ));
	    sliderRange();
	    filterPrice();
	    filterFunc();
	}
	
	function fn_check(){
	    $(".MarkerPopup-popup").hide();
	    $(".IconInner").removeClass("active");
	    $("#mapAdList div").removeClass("active");
	    $("#mapAdList div").blur();
	
	    if($('input[name=mapChk]:checked').length == $('input[name=mapChk]').length || $('input[name=mapChk]:checked').length == 0 ){
	        $("[data-attr-value]").attr("data-filter-visible","Y");
	        $(".MarkerIcon-content").attr("data-filter-visible","Y");
	        filterFuncMap();
	        return;
	    }
	
	    $("[data-filter]").each(function() {
	        var compVal = $(this).attr("data-filter");
	        var compElement = $(this);
	        compElement.attr("data-filter-visible","N");
	        $("input[name=mapChk]:checked").each(function() {
	            if($(this).val() == compVal){
	                compElement.attr("data-filter-visible","Y");
	            }
	        });
	    });
	    filterFuncMap();
	}
	
	function filterFuncMap(){
	    $("#mapAdList").each(function(index) {
	        let filterYn = "N";
	        $("[data-attr-value]").each(function(index) {
	            if($(this).attr("data-filter-visible") == "Y"){
	                $(this).show();
	                filterYn = "Y";
	            }else{
	                $(this).hide();
	            }
	        });
	        $(".MarkerIcon-content").each(function(index) {
	            if($(this).attr("data-filter-visible") == "Y"){
	                $(this).show();
	            }else{
	                $(this).hide();
	            }
	        });
	        $(".noContent").remove();
	        if(filterYn == "N"){
	            let insTag = "";
	            insTag += "<li class=\"noContent\">";
	            insTag += "<div class=\"item-noContent\">";
	            insTag +=      "<p><img src=\"<c:url value='/images/web/icon/warning2.gif'/>\" alt=\"경고\"></p>";
	            insTag += 	   "<p class=\"text\">죄송합니다.<br><span class=\"comm-color1\">해당상품</span>에 대한 검색결과가 없습니다.</p>";
	            insTag += "</div>";
	            insTag += "</li>";
	            $("#mapAdList").append(insTag);
	        }
	    });
	}

    /* top (상단으로 가기) */
    function go_top_map() {
        $(".sidebar-con").animate({scrollTop : 0}, 400);
    }

</script>

<!-- 다음DDN SCRIPT START 2017.03.30 -->
<script type="text/j-vascript">
    var roosevelt_params = {
        retargeting_id:'U5sW2MKXVzOa73P2jSFYXw00',
        tag_label:'YKmv5z8ZQBe23U2v7PT-tw'
    };
</script>
<script async type="text/j-vascript" src="//adimg.daumcdn.net/rt/roosevelt.js"></script>
<!-- // 다음DDN SCRIPT END 2016.03.30 -->

<jsp:include page="/web/foot.do"></jsp:include>

</body>
</html>