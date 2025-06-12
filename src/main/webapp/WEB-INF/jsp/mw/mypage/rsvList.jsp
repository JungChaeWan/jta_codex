<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant"/>
<head>
    <meta name="robots" content="noindex, nofollow">
    <jsp:include page="/mw/includeJs.do"></jsp:include>

    <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/common2.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/style.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/mw/mypage_2.css'/>">

    <script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>

</head>
<body>
<div id="wrap">
    <!-- 헤더 s -->
    <header id="header">
        <jsp:include page="/mw/head.do">
            <jsp:param name="headTitle" value="나의 예약/구매 내역"/>
        </jsp:include>
    </header>
    <!-- 헤더 e -->

    <!-- 콘텐츠 s -->
    <h2 class="sr-only">서브콘텐츠</h2>
    <div id="delInfo" class="comm-layer-popup delivery-popup" style="top: 0">
        <div class="content-wrap">
            <div class="content">
                <div class="head">
                    <h3 class="title">배송지키미-탐나오 </h3>
                    <button type="button" id="dlvInfoClose" class="close">
                        <img src="/images/mw/icon/close/dark-gray.png" alt="닫기">
                    </button>
                </div>
                <div>
                    <iframe id="goodsflowIframe" width="100%" height="697px;" style="max-width:100%; border:none;"></iframe>
                </div>
            </div>
        </div>
    </div>

    <div id="jlairRsv" class="comm-layer-popup delivery-popup" style="top: 0">
        <div class="content-wrap">
            <div class="content">
                <div class="head">
                    <h3 class="title">JLAIR-탐나오 </h3>
                    <button type="button" id="jlairRsvClose" class="close">
                        <img src="/images/mw/icon/close/dark-gray.png" alt="닫기">
                    </button>
                </div>
                <div>
                    <iframe src="https://www.jlair.net/m/index.php?mid=04&newopen=yes" width="100%" height="100%;" style="border:none; position: fixed; top: 15px;"></iframe>
                </div>
            </div>
        </div>
    </div>

    <div id="sunminRsv" class="comm-layer-popup delivery-popup" style="top: 0">
        <div class="content-wrap">
            <div class="content">
                <div class="head">
                    <h3 class="title">선민투어-탐나오 </h3>
                    <button type="button" id="sunminRsvClose" class="close">
                        <img src="/images/mw/icon/close/dark-gray.png" alt="닫기">
                    </button>
                </div>
                <div>
                    <iframe src="https://air.dcjeju.net/air/login" width="100%" height="100%;" style="border:none; position: fixed; top: 15px;"></iframe>
                </div>
            </div>
        </div>
    </div>

    <section id="subContent">
        <div class="menu-bar">
            <p class="btn-prev"><img src=""></p>
            <h2>나의 예약/구매 내역</h2>
        </div>
        <div class="sub-content">
            <article class="info-wrap top">

                <c:if test="${isLogin eq 'Y'}">
                <div class="affiliate-info-text">
                    <div class="banner_image">
                        <img src="/images/mw/sub/mypage_character.png" alt="로그인 마이페이지 캐릭터">
                        <span class="admin-id">${userEmail}</span>
                    </div>
                </div>
                </c:if>
                <h6><span>항공권 구매내역</span>은 <span>제휴사 페이지</span>를 <br> 통해 확인하실 수 있습니다.</h6>
                <div class="center-btn">
                    <a class="btn btn0" href="javascript:fn_GoJlair();">
                        <img src="/images/mw/list/jlair.png" alt="제이엘 항공">
                    </a>
                    <a class="btn btn1" href="javascript:fn_GoSunmin();">
                        <img src="/images/mw/list/sunmin.png" alt="선민투어">
                    </a>
                </div>
            </article>

            <!-- 리뷰 프로모션 배너롤링 -->
            <div class="review_content__banner">
                <div class="main-top-slider">
                    <div id="main_top_slider" class="swiper-container swiper-container-horizontal">
                        <ul class="swiper-wrapper">
                            <li class="swiper-slide">
                                <div class="Fasten">
                                    <a class="inner--link" href="https://m.site.naver.com/1CMAR" target="_blank">
                                        <img src="/images/mw/from/banner/review_banner.png" alt="리뷰이벤트">
                                    </a>
                                </div>
                            </li>
                        </ul>
                       <div id="main_top_navi" class="swiper-pagination swiper-pagination-fraction" style="display: none">
                            <span class="swiper-pagination-current"></span> / <span class="swiper-pagination-total"></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 구매 내역 목록 시작 -->
            <div class="user-dashboard">

                <!-- [구매 히스토리 필터 선택] 시작 -->
                <form name="frm" id="frm">
                <input type="hidden" name="rsvNum" id="rsvNum"/>
                <input type="hidden" name="type" id="type" value="rsv"/>
                <input type="hidden" name="firstIndex" id="firstIndex" value="3"/>
                <input type="hidden" name="lastIndex" id="lastIndex" value="13"/>
                <c:if test="${isLogin eq 'Y'}">
                <div class="index-history option_before">
                    <div class="mt">
                        <div class="box-search">
                            <div class="d-flex justify-start">
                                <div class="ml">
                                    <div class="txt-history-area" id="txtStartTime">0000-00-00</div>
                                    <span class="arrow">~</span>
                                    <div class="txt-history-area" id="txtEndTime">0000-00-00</div>
                                </div>
                            </div>
                            <div id="viewOrderDetails" class="justify-end">
                                <span class="btn-detail">상세조회</span>
                            </div>

                            <!-- [구매 히스토리 필터 모달 팝업] s -->
                            <div id="history_filter_modal" class="popup-typeA history-filter-modal">

                                <div class="content-area">
                                    <div class="list-group">
                                        <ul class="select-menu col3">
                                            <li>
                                                <div class="lb-box">
                                                    <input id="month0" name="month" type="radio" value="MO1" <c:if test="${RSV_HISSVO.month eq 'MO1' || RSV_HISSVO.month eq null }">checked="checked"</c:if>>
                                                    <label for="month0">3개월</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="lb-box">
                                                    <input id="month1" name="month" type="radio" value="MO2" <c:if test="${RSV_HISSVO.month eq 'MO2'}">checked="checked"</c:if>>
                                                    <label for="month1">6개월</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="lb-box">
                                                    <input id="month2" name="month" type="radio" value="MO3" <c:if test="${RSV_HISSVO.month eq 'MO3'}">checked="checked"</c:if>>
                                                    <label for="month2">12개월</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="lb-box">
                                                    <input id="month3" name="month" type="radio" value="MO4" <c:if test="${RSV_HISSVO.month eq 'MO4'}">checked="checked"</c:if>>
                                                    <label for="month3">최대(10년)</label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="search-area filter">
                                        <div class="date-picker-wrapper">
                                            <div class="area">
                                                <div class="value-text">
                                                    <input class="datepicker" type="text" name="sFromDt" id="sFromDt" placeholder="검색시작일 선택" style="z-index: 10;" value="${RSV_HISSVO.sFromDt}" readonly="readonly">
                                                </div>
                                            </div>
                                            <div class="area">
                                                <div class="value-text">
                                                    <input class="datepicker" type="text" name="sToDt" id="sToDt" placeholder="검색종료일 선택" style="z-index: 10;" value="${RSV_HISSVO.sToDt}" readonly="readonly">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="quick_search">
                                            <div class="searchIcon">
                                                <input type="text" title="주문 상품명 검색" name="sPrdtNm" id="sPrdtNm" value="${RSV_HISSVO.sPrdtNm}" placeholder="주문 상품명 검색">
                                            </div>
                                        </div>

                                        <div class="side-wrap">
                                            <div class="box_terms-all">
                                                <input type="checkbox" name="autoCancelYn" id="autoCancelYn" class="form_checkbox sprite_join-default" value="Y" <c:if test="${RSV_HISSVO.autoCancelYn eq 'Y'}">checked="checked"</c:if>>
                                                <label for="autoCancelYn" class="text_all-agree">자동취소건 포함</label>
                                            </div>
                                        </div>

                                        <div class="fix-cta">
                                            <a href="#" class="result-btn close" id="closeFilter"  onclick="close_popup('#history_filter_modal');">닫기</a>
                                            <a href="#" class="result-btn apply" id="appleFilter">조회하기</a>
                                        </div>
                                   </div>
                                </div>
                            </div>
                            <!-- [구매 히스토리 필터 모달 팝업] e -->
                        </div>
                    </div>
                </div>
                <!-- [구매 히스토리 필터 선택] 끝 -->
                <!-- [구매 카테고리 필터 선택] 시작 -->
                <div class="category-filter">
                    <button id="viewFilterDetails" class="filter-button">
                        <span class="filter-label">
                            <c:if test="${RSV_HISSVO.sPrdtCd eq '' || RSV_HISSVO.sPrdtCd eq null}">전체</c:if>
                            <c:if test="${RSV_HISSVO.sPrdtCd eq 'AD' }">숙소</c:if>
                            <c:if test="${RSV_HISSVO.sPrdtCd eq 'RC' }">렌트카</c:if>
                            <c:if test="${RSV_HISSVO.sPrdtCd eq 'C200' }">관광지</c:if>
                            <c:if test="${RSV_HISSVO.sPrdtCd eq 'C300' }">맛집</c:if>
                            <c:if test="${RSV_HISSVO.sPrdtCd eq 'C100' }">여행사상품</c:if>
                            <c:if test="${RSV_HISSVO.sPrdtCd eq 'SV' }">특산/기념품</c:if>
                        </span>
                    </button>
                </div>
                </c:if>
                <!-- [구매 카테고리 필터 선택] 끝 -->

                <!-- [구매 카테고리 모달 팝업] s -->
                <div id="category_filter_modal" class="popup-typeA category-filter-modal" style="display:">

                    <div class="content-area">
                        <div class="top">
                            <span class="close-btn" style="cursor:pointer;" onclick="close_popup('#category_filter_modal')"></span>
                            <div class="condition_title">카테고리 필터</div>
                        </div>
                        <div class="list-group">
                            <ul class="select-menu col3">
                                <li>
                                    <div class="category-lb-box">
                                        <input id="category0" name="sPrdtCd" type="radio" value="" <c:if test="${RSV_HISSVO.sPrdtCd eq '' || RSV_HISSVO.sPrdtCd eq null}">checked="checked"</c:if>>
                                        <label for="category0">
                                            <span class="txt">전체</span>
                                            <span class="radio-btn"></span>
                                        </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="category-lb-box">
                                        <input id="category1" name="sPrdtCd" type="radio" value="AD" <c:if test="${RSV_HISSVO.sPrdtCd eq 'AD' }">checked="checked"</c:if>>
                                        <label for="category1">
                                            <span class="txt">숙소</span>
                                            <span class="radio-btn"></span>
                                        </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="category-lb-box">
                                        <input id="category2" name="sPrdtCd" type="radio" value="RC" <c:if test="${RSV_HISSVO.sPrdtCd eq 'RC' }">checked="checked"</c:if>>
                                        <label for="category2">
                                            <span class="txt">렌트카</span>
                                            <span class="radio-btn"></span>
                                        </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="category-lb-box">
                                        <input id="category3" name="sPrdtCd" type="radio" value="C200" <c:if test="${RSV_HISSVO.sPrdtCd eq 'C200' }">checked="checked"</c:if>>
                                        <label for="category3">
                                            <span class="txt">관광지</span>
                                            <span class="radio-btn"></span>
                                        </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="category-lb-box">
                                        <input id="category4" name="sPrdtCd" type="radio" value="C300" <c:if test="${RSV_HISSVO.sPrdtCd eq 'C300' }">checked="checked"</c:if>>
                                        <label for="category4">
                                            <span class="txt">맛집</span>
                                            <span class="radio-btn"></span>
                                        </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="category-lb-box">
                                        <input id="category5" name="sPrdtCd" type="radio" value="C100" <c:if test="${RSV_HISSVO.sPrdtCd eq 'C100' }">checked="checked"</c:if>>
                                        <label for="category5">
                                            <span class="txt">여행사 상품</span>
                                            <span class="radio-btn"></span>
                                        </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="category-lb-box">
                                        <input id="category6" name="sPrdtCd" type="radio" value="SV" <c:if test="${RSV_HISSVO.sPrdtCd eq 'SV' }">checked="checked"</c:if>>
                                        <label for="category6">
                                            <span class="txt">특산/기념품</span>
                                            <span class="radio-btn"></span>
                                        </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                </form>
                <!-- [구매 카테고리 모달 팝업] e -->
                <c:set var="preDate" value="" />
                <div class="purchase_list_container">
                    <c:forEach items="${orderList}" var="orderInfo" varStatus="status">
                    <c:choose>
                        <c:when test="${preDate == null or preDate ne orderInfo.regDttm}">
                            <div class="purchase-date"> ${fn:substring(orderInfo.regDttm, 0, 4)}.${fn:substring(orderInfo.regDttm, 4, 6)}.${fn:substring(orderInfo.regDttm, 6, 8)}</div>
                            <c:set var="preDate" value="${orderInfo.regDttm}" />
                        </c:when>
                    </c:choose>
                    <!-- 개별 구매 항목 시작 -->
                    <div class="purchase_list">
                        <div class="purchase_item">
                            <button type="button" class="statusInfo6 done_info_box" data-id="1">
                                <span class="info info-buoy">
                                    <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}">
                                        <span class="text-red text-raise">미결제</span>
                                    </c:if>
                                    <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">결제완료</c:if>
                                    <c:if test="${(orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ) or (orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2)}">취소처리중(철회불가)</c:if>
                                    <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CCOM}">취소완료</c:if>
                                    <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ECOM}">기간만료</c:if>
                                    <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_ACC}">자동취소</c:if>
                                    <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SREQ}">부분환불요청</c:if>
                                    <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM}">부분환불완료</c:if>
                                    <c:if test="${orderInfo.prdtCd ne Constant.SV}">
                                        <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">사용완료</c:if>
                                    </c:if>
                                    <c:if test="${orderInfo.prdtCd eq Constant.SV}">
                                        <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM}">구매완료</c:if>
                                        <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_DLV}">배송중</c:if>
                                        <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_DLVE}">배송완료</c:if>
                                    </c:if>
                                </span>
                                <img class="info_img" src="/images/mw/icon/icon-info-done.png" alt="취소처리 완료">
                            </button>

                            <!-- [button에 따른 레이어팝업] s] -->
                            <div id="done_info_box_1" class="done_info_box_d">
                                <p class="info_artcle">
                                    <span> 예약/구매 담당자 확인 후 취소처리 완료 </span>
                                </p>
                            </div>
                            <!-- [button에 따른 레이어팝업] e] -->

                            <!-- 주문 번호 표시 -->
                            <span class="number">주문번호 ${orderInfo.rsvNum}</span>
                        </div>

                        <!-- 구매 상세 정보 시작 -->
                        <a href="javascript:fn_GoGoodsDtl('${orderInfo.prdtCd}','${orderInfo.prdtNum}');">
                        <div class="purchase_item_details">
                            <div class="purchase_item_image">
                                <div class="purchase_item_image_inner">
                                    <c:choose>
                                        <c:when test="${fn:contains(orderInfo.savePath, 'http') || fn:contains(orderInfo.savePath, '/data/cardiv/') }">
                                            <img src="${orderInfo.savePath}" alt="이미지" onerror="this.src='/images/web/other/no-image.jpg'">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${orderInfo.savePath}thumb/${orderInfo.saveFileNm}" alt="이미지" onerror="this.src='/images/web/other/no-image.jpg'">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="purchase_item_info">
                                <div class="product-list add-option">
                                   <h5 class="product">[${orderInfo.corpNm}] ${orderInfo.prdtNm}</h5>
                                   <span class="infoText">${orderInfo.prdtInf}</span>
                                   <span class="item-newprice"><fmt:formatNumber>${orderInfo.saleAmt}</fmt:formatNumber>원</span>
                                </div>
                            </div>
                        </div>
                        </a>
                        <!-- 구매 상세 정보 끝 -->

                        <!-- 구매 항목 액션 버튼들 시작 -->
                        <div class="purchase_item_actions">
                            <div class="purchase_item_button_container">
                                <div class="purchase_item_buttons">
                                    <a href="javascript:void(0)" onclick="fn_DtlRsv('${orderInfo.rsvNum}')" class="purchase_item_button">
                                        <span class="detail">예약상세</span>
                                    </a>

                                    <!-- 카테고리별 배송조회 또는 재구매로 변경  -->
                                    <c:if test="${orderInfo.prdtCd eq 'SV'}">
                                        <a href="javascript:fn_goDlv('${orderInfo.goodsflowDlvCd}', '${orderInfo.dlvNum}')" class="purchase_item_button item_track_btn"><span>배송조회</span></a>
                                    </c:if>
                                    <a href="javascript:fn_GoGoodsDtl('${orderInfo.prdtCd}','${orderInfo.prdtNum}');" class="purchase_item_button"><span>재구매</span></a>
                                    <c:if test="${(orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM || orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM) && orderInfo.useepilRegYn eq 'N'}">
                                        <c:if test="${isLogin eq 'Y'}">
                                        <a href="/mw/coustomer/viewInsertUseepil.do" class="purchase_item_button item_review_btn"><span>이용후기</span></a>
                                        </c:if>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <!-- 구매 항목 액션 버튼들 끝 -->
                    </div>
                    </c:forEach>
                    <!-- 개별 구매 항목 끝 -->
                </div>
                <!-- 구매 항목 더보기 버튼 -->
                <button class="load-more-btn" type="button">  더보기 ＋ </button>

            </div>
            <!-- 구매 내역 목록 끝 -->
        </div>

    </section>
    <!-- 콘텐츠 e -->
</div>




    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
    <script type="text/javascript" src="<c:url value='/validator.do'/>"></script>
    <script type="text/javascript">

        function fn_DtlRsv(rsvNum) {
            $("#rsvNum").val(rsvNum);
            document.frm.action = "<c:url value='/mw/mypage/detailRsv.do'/>";
            document.frm.submit();
        }

        //예약확인 바로가기
        function goto_direct_confirm(o) {
            if (o.value != '') {
                window.open(o.value, '');
            }
        }

        function fn_goDlv(dlvCd, dlvNum) {
            $("body").css("overflow","hidden");
            $("body").css("touch-action","hidden");

            if("${CST_PLATFORM}" == "test"){
                $('#goodsflowIframe').attr('src', "https://trace.goodsflow.com/VIEW/V1/whereis/visitjejutest/" + dlvCd + "/" + dlvNum);
            }else{
                $('#goodsflowIframe').attr('src', "https://trace.goodsflow.com/VIEW/V1/whereis/visitjeju/" + dlvCd + "/" + dlvNum);
            }

            $('#dlvInfo').show();
            $('#dlvInfo').css("top", $(document).scrollTop() + 100 + "px");

            // 배송조회 버튼 추가
            $('#delInfo').show();
            $('#delInfo').css("top", $(document).scrollTop() + "px");
        }

        function fn_goComfirmOrder(svRsvNum) {
            var parameters = "svRsvNum=" + svRsvNum;
            $.ajax({
                type: "post",
                dataType: "json",
                // async:false,
                url: "<c:url value='/web/confirmOrder.ajax'/>",
                data: parameters,
                success: function (data) {
                    document.frm.action = "<c:url value='/mw/mypage/rsvList.do'/>";
                    document.frm.submit();
                }
            });
        }

        $(document).ready(function () {

            /** 마이페이지 프로모션 슬라이드 */
            if ($('#main_top_slider .swiper-slide').length > 1) {
                var swiper = new Swiper('#main_top_slider', {
                    pagination         : '#main_top_navi',
                    paginationClickable: true,
                    autoplay           : 5000,
                    loop               : true,
                    paginationType     : 'fraction' // 'bullets' or 'progress' or 'fraction' or 'custom'
                });
                $('#main_top_navi').show();
            }

            //예약확인 바로가기
            $("#layer_selBtn").on("click", function () {
                if ($('.layer-box').css('display') == 'none') {
                    $('.layer-box').css('display', 'block');
                } else {
                    $('.layer-box').css('display', 'none');
                }
                return false;
            });

            $("#dlvInfoClose").click(function () {
                $("body").css("overflow", "visible");
                $("body").css("touch-action", "auto");
                $("#dlvInfo").hide();
                $("#delInfo").hide();
            });

            $("#jlairRsvClose").click(function () {
                $("body").css("overflow", "visible");
                $("body").css("touch-action", "auto");
                $("#jlairRsv").hide();
            });

            $("#sunminRsvClose").click(function () {
                $("body").css("overflow", "visible");
                $("body").css("touch-action", "auto");
                $("#sunminRsv").hide();
                $("#overlaySunmin").hide();
            });

            $(".purchase_list_container").on("click", ".done_info_box", function () {
                // 현재 버튼의 상태값 가져오기
                const statusText = $(this).find(".info .text-raise, .info").text().trim();

                // 동적으로 내용 변경
                const contentMap = {
                    "미결제"        : "예약/구매 진행 중 결제하기 전 상태 입니다.",
                    "결제완료"       : "예약/구매 결제가 완료되었습니다.",
                    "취소처리중(철회불가)": "취소 요청 후 예약/구매 담당자 확인 전 상태입니다.",
                    "취소완료"       : "예약/구매 담당자 확인 후 취소처리 완료 하였습니다.",
                    "기간만료"       : "기간이 만료되었습니다.",
                    "자동취소"       : "미결제로 예약/구매가 취소된 상태 입니다.",
                    "부분환불요청"     : "부분 환불 요청 중입니다.",
                    "부분환불완료"     : "부분 환불이 완료되었습니다.",
                    "사용완료"       : "예약 상품을 사용 완료 하였습니다.",
                    "구매완료"       : "구매 상품을 수령 완료 하였습니다.",
                    "배송중"        : "배송이 진행 중입니다.",
                    "배송완료"       : "배송이 완료되었습니다."
                };

                const popupContent = contentMap[statusText] || "상태 정보가 없습니다.";

                // 레이어 팝업 컨텐츠 설정
                $("#done_info_box_1").find(".info_artcle span").text(popupContent);

                // 기존 타이머 초기화
                if (window.popupTimeout) {
                    clearTimeout(window.popupTimeout);
                }

                // 팝업 보여주기
                $("#done_info_box_1").fadeIn();

                // 5초 후 팝업 닫기
                window.popupTimeout = setTimeout(() => {
                    $("#done_info_box_1").fadeOut();
                }, 5000);
            });


            // [구매 히스토리] 필터 모달 팝업 open
            $("#viewOrderDetails").on("click", function (e) {
                show_popup('#history_filter_modal', this);
                $('#dimmed').show();
                $("html, body").addClass("not_scroll");
                $('.side-btn').hide();
                $('.back').hide();
                $("#header").removeClass("nonClick");
            });

            // [구매 카테고리] 필터 모달 팝업 open
            $("#viewFilterDetails").on("click", function (e) {
                e.preventDefault();
                show_popup('#category_filter_modal', this);
                $('#dimmed').show();
                $('.side-btn').hide();
                $("html, body").addClass("not_scroll");
                $('.back').hide();
                $("#header").removeClass("nonClick");
            });

            // 오늘 날짜와 기본값(3개월 전) 계산
            const today = new Date();
            const oneMonthAgo = new Date();
            oneMonthAgo.setMonth(today.getMonth() - 3);

            const todayString = $.datepicker.formatDate("yy-mm-dd", today);
            const oneMonthAgoString = $.datepicker.formatDate("yy-mm-dd", oneMonthAgo);

            // 초기 hidden input 값 및 readonly input 값 설정
            if (!$("#sFromDt").val()) {
                $("#sFromDt").val(oneMonthAgoString);
            }
            if (!$("#sToDt").val()) {
                $("#sToDt").val(todayString);
            }

            // sFromDt 달력
            $("#sFromDt").datepicker({
                changeMonth       : true,
                changeYear        : true,
                dateFormat        : "yy-mm-dd",
                showMonthAfterYear: true,
                yearRange         : "2015:" + today.getFullYear(),
                maxDate           : today,
                onClose           : function (dateText) {
                    // sToDt 최소 날짜 업데이트
                    $("#sToDt").datepicker("option", "minDate", dateText);
                },
            });

            // sToDt 달력
            $("#sToDt").datepicker({
                changeMonth       : true,
                changeYear        : true,
                dateFormat        : "yy-mm-dd",
                showMonthAfterYear: true,
                yearRange         : "2015:" + today.getFullYear(),
                maxDate           : today,
                minDate           : $("#sFromDt").val(), // 초기 최소값 설정
                onClose           : function (dateText) {
                },
            });

            // 클릭 시 달력 열기
            $("#sFromDt").on("click", function () {
                $(this).datepicker("show");
            });

            $("#sToDt").on("click", function () {
                $(this).datepicker("show");
            });

            // 라디오 버튼 클릭 시 날짜 업데이트
            $("input[name='month']").on("change", function () {
                const selectedValue = $(this).val();
                let monthsToSubtract;

                switch (selectedValue) {
                    case "MO1":
                        monthsToSubtract = 3;
                        break;
                    case "MO2":
                        monthsToSubtract = 6;
                        break;
                    case "MO3":
                        monthsToSubtract = 12;
                        break;
                    case "MO4":
                        monthsToSubtract = 120;
                        break;
                    default:
                        monthsToSubtract = 3;
                }

                const newFromDate = new Date(today);
                newFromDate.setMonth(today.getMonth() - monthsToSubtract);

                const newFromDateString = $.datepicker.formatDate("yy-mm-dd", newFromDate);

                // 값 업데이트
                $("#sFromDt").val(newFromDateString);
                $("#sToDt").val(todayString);

                // sToDtView 최소 날짜 갱신
                $("#sToDt").datepicker("option", "minDate", newFromDateString);
            });

            // 상세조회
            $("#appleFilter").on("click", function () {
                submitForm();
            });

            // 카테고리 검색
            $("input[name='sPrdtCd']").on("change", function () {
                submitForm();
            });

            function submitForm() {
                $("#firstIndex").val('1');
                $("#lastIndex").val('2');
                $("#frm").attr("action", "/mw/mypage/rsvList.do");
                $("#frm").attr("method", "POST");
                $("#frm").submit();
            }


            $("#txtStartTime").text($("#sFromDt").val());
            $("#txtEndTime").text($("#sToDt").val());
        })

        // 외부영역 클릭 시 팝업 닫기
        $(document).mouseup(function (e){
            var LayerPopup = $(".done_info_box_d");
            if(LayerPopup.has(e.target).length === 0){
                LayerPopup.hide("show");
            }
        });


        //창 닫기
        function close_popup(obj) {
            if (typeof obj == "undefined" || obj == "" || obj == null) {
                $('.dateRangePickMw').data('daterangepicker').hide();
            } else {
                $(obj).hide();
            }
            $('#dimmed').fadeOut(100);
            $("html, body").removeClass("not_scroll");
            $('.side-btn').show();
            $('.back').show();
        }

        function show_popup(obj) {
            if($(obj).is(":hidden")) {
                $(obj).fadeIn();
                $("body").after("<div class='lock-bg'></div>"); // 검은 불투명 배경
            } else {
                $(obj).hide();
                $(".lock-bg").remove();
            }
        }

        let isLoading = false; // 중복 호출 방지
        let hasMoreData = true; // 더 불러올 데이터가 있는지 여부
        document.addEventListener("DOMContentLoaded", () => {
            const loadMoreButton = document.querySelector(".load-more-btn");

            if (loadMoreButton) {
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach((entry) => {
                        if (entry.isIntersecting) {
                            loadMoreData(); // 버튼이 보일 때 로드
                        }
                    });
                });

                observer.observe(loadMoreButton); // 관찰 시작
            }
        });

        let preDate = null;
        function loadMoreData() {
            if (isLoading || !hasMoreData) return; // 중복 호출 방지
            isLoading = true; // 로딩 상태로 설정

            const form = document.getElementById("frm");
            const formData = new FormData(form);

            fetch(`/mw/mypage/rsvListLoadMore.ajax`, {
                method: "POST",
                body: formData,
            })
                .then((response) => response.json())
                .then((data) => {
                    const container = document.querySelector(".purchase_list_container");
                    data.forEach((orderInfo) => {
                        let item = "";

                        // 날짜가 변경되었을 경우 날짜 출력
                        const formattedDate = orderInfo.regDttm.substring(0, 4) + "." +
                            orderInfo.regDttm.substring(4, 6) + "." +
                            orderInfo.regDttm.substring(6, 8);

                        if (preDate === null || preDate !== formattedDate) {
                            item += '<div class="purchase-date">' + formattedDate + '</div>';
                            preDate = formattedDate;
                        }

                        // 구매 항목 HTML 추가
                        item += '<div class="purchase_list">' +
                            '<div class="purchase_item">' +
                            '<button type="button" class="statusInfo6 done_info_box" data-id="1">' +
                            '<span class="info info-buoy">';

                        // 예약 상태 코드 처리
                        if (orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_READY}") {
                            item += '<span class="text-red text-raise">미결제</span>';
                        } else if (orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_COM}") {
                            item += '결제완료';
                        } else if (orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_CREQ}" || orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_CREQ2}") {
                            item += '취소처리중(철회불가)';
                        } else if (orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_CCOM}") {
                            item += '취소완료';
                        } else if (orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_ECOM}") {
                            item += '기간만료';
                        } else if (orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_ACC}") {
                            item += '자동취소';
                        } else if (orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_SREQ}") {
                            item += '부분환불요청';
                        } else if (orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_SCOM}") {
                            item += '부분환불완료';
                        } else if (orderInfo.prdtCd !== "SV" && orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_UCOM}") {
                            item += '사용완료';
                        } else if (orderInfo.prdtCd === "SV") {
                            if (orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_UCOM}") {
                                item += '구매완료';
                            } else if (orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_DLV}") {
                                item += '배송중';
                            } else if (orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_DLVE}") {
                                item += '배송완료';
                            }
                        }

                        item += '</span>' +
                            '<img class="info_img" src="/images/mw/icon/icon-info-done.png" alt="취소처리 완료">' +
                            '</button>' +

                            '<div id="done_info_box_1" class="done_info_box_d">' +
                            '<p class="info_artcle">' +
                            '<span> 예약/구매 담당자 확인 후 취소처리 완료 </span>' +
                            '</p>' +
                            '</div>' +

                            '<span class="number">주문번호 ' + orderInfo.rsvNum + '</span>' +
                            '</div>' +
                            '<a href="javascript:fn_GoGoodsDtl(\'' + orderInfo.prdtCd + '\',\'' + orderInfo.prdtNum + '\');"> ' +
                            '<div class="purchase_item_details">' +
                            '<div class="purchase_item_image">' +
                            '<div class="purchase_item_image_inner">'

                            if (orderInfo.savePath && (orderInfo.savePath.indexOf('http') === 0 || orderInfo.savePath.indexOf('/data/cardiv/') === 0 )) {
                                item += '<img src="' + orderInfo.savePath + '" alt="이미지" onerror="this.src=\'/images/web/other/no-image.jpg\'">';
                            } else {
                                item += '<img src="' + orderInfo.savePath + 'thumb/' + orderInfo.saveFileNm + '" alt="이미지" onerror="this.src=\'/images/web/other/no-image.jpg\'">';
                            }

                        item += '</div>' +
                            '</div>' +
                            '</a>' +
                            '<div class="purchase_item_info">' +
                            '<div class="product-list add-option">' +
                            '<h5 class="product">[' + orderInfo.corpNm + '] ' + orderInfo.prdtNm + '</h5>' +
                            '<span class="infoText">' + orderInfo.prdtInf + '</span>' +
                            '<span class="item-newprice">' + Number(orderInfo.saleAmt).toLocaleString() + '원</span>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +

                            '<div class="purchase_item_actions">' +
                            '<div class="purchase_item_button_container">' +
                            '<div class="purchase_item_buttons">' +
                            '<a href="javascript:void(0)" onclick="fn_DtlRsv(\'' + orderInfo.rsvNum + '\')" class="purchase_item_button">' +
                            '<span class="detail">예약상세</span>' +
                            '</a>';

                        if (orderInfo.prdtCd === "SV") {
                            item += '<a href="javascript:fn_goDlv(\'' + orderInfo.goodsflowDlvCd + '\', \'' + orderInfo.dlvNum + '\')" class="purchase_item_button item_track_btn"><span>배송조회</span></a>';
                        }
                        item += '<a href="javascript:fn_GoGoodsDtl(\'' + orderInfo.prdtCd + '\',\'' + orderInfo.prdtNum + '\');" class="purchase_item_button"><span>재구매</span></a>';

                        if ((orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_UCOM}" || orderInfo.rsvStatusCd === "${Constant.RSV_STATUS_CD_SCOM}") && orderInfo.useepilRegYn === 'N') {
                            if('${isLogin}' === 'Y') {
                                item += '<a href="/mw/coustomer/viewInsertUseepil.do" class="purchase_item_button item_review_btn"><span>이용후기</span></a>'
                            }
                        }

                        item += '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>';
                        container.innerHTML += item;
                    });

                    // 페이징 값 업데이트
                    const firstIndex = parseInt(document.getElementById("firstIndex").value, 10) || 0;
                    const lastIndex = parseInt(document.getElementById("lastIndex").value, 10) || 0;

                    document.getElementById("firstIndex").value = firstIndex + 11;
                    document.getElementById("lastIndex").value = lastIndex + 11;

                    if (data.length === 0) {
                        hasMoreData = false;
                        $(".load-more-btn").text("더 이상 예약/구매 내역이 없습니다.");
                    }
                })
                .catch((error) => {
                    console.error("Error loading more data:", error);
                })
                .finally(() => {
                    isLoading = false; // 로딩 상태 해제
                });
        }

        //재구매 및 예약상품 정보 클릭 시
        function fn_GoGoodsDtl(prdtCd, prdtNum){
            console.log(prdtCd);
            if (prdtCd === "SV"){
                location.href = "/mw/sp/detailPrdt.do?prdtNum="+prdtNum;
            }
            if (prdtCd === "SP" || prdtCd.indexOf("C") === 0){
                location.href = "/mw/sp/detailPrdt.do?prdtNum="+prdtNum;
            }
            if (prdtCd === "RC"){
                location.href = "/mw/rentcar/car-detail.do?prdtNum="+prdtNum;
            }
            if (prdtCd === "AD"){
                location.href = "/mw/ad/detailPrdt.do?sPrdtNum="+prdtNum;
            }

        }

        function fn_GoJlair(){
            $("body").css("overflow","hidden");
            $("body").css("touch-action","hidden");

            // JL항공 예약 조회
            $('#jlairRsv').show();
            $('#jlairRsv').css("top", $(document).scrollTop() + "px");
        }

        function fn_GoSunmin(){
            $("body").css("overflow","hidden");
            $("body").css("touch-action","hidden");

            // 선민투어 예약 조회
            $('#overlaySunmin').show();
            $('#sunminRsv').show();
            $('#sunminRsv').css("top", $(document).scrollTop() + "px");
        }
    </script>
    <%--<jsp:include page="/mw/foot.do"></jsp:include>--%>
</div>
<div id="dimmed"></div>
<div id="overlaySunmin"></div>
</body>
</html>