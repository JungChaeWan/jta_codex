<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		    uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>

<un:useConstants var="Constant" className="common.Constant" />
<head>
    <meta name="robots" content="noindex, nofollow">
    <jsp:include page="/web/includeJs.do" />

    <jsp:useBean id="today" class="java.util.Date" />
    <fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
</head>
<body>
<header id="header">
    <jsp:include page="/web/head.do" />
</header>
<main id="main">
    <div class="mapLocation"> <!--index page에서는 삭제-->
        <div class="inner">
            <span>홈</span> <span class="gt">&gt;</span>
            <span>마이페이지</span> <span class="gt">&gt;</span>
            <span>나의 예약/구매내역</span>
        </div>
    </div>
    <!-- quick banner -->
    <jsp:include page="/web/left.do" flush="false"></jsp:include>
    <!-- //quick banner -->
    <div class="subContainer">
        <div class="subHead"></div>
        <div class="subContents">
            <!-- new contents (마이페이지) -->
            <div class="mypage sideON">
                <div class="bgWrap2">
                    <div class="inner">
                        <div class="tbWrap">
                            <jsp:include page="/web/mypage/left.do?menu=rsv" />
                            <div class="rContents smON">
                                <form name="frm" id="frm">
                                    <input type="hidden" name="rsvNum" id="rsvNum" >
                                    <input type="hidden" name="autoCancelYn" id="autoCancelYn" value="${RSV_HISSVO.autoCancelYn}">
                                    <input type="hidden" name="partnerCode" value="${ssPartnerCode}">
                                    <input type="hidden" id="pageIndex" name="pageIndex" value="${RSV_HISSVO.pageIndex}"/>
                                    <input type="hidden" id="sPrdtCd" name="sPrdtCd" value="${RSV_HISSVO.sPrdtCd}"/>

                                <h3 class="mainTitle">나의 예약/구매 내역</h3>

                                <div class="comm-artWrap top">
                                    <article class="comm-art3">
                                        <div class="comm-art3__text">
                                            <h6>
                                                <span>항공권 구매 내역 확인 및 취소 처리는</span>
                                                <p>제휴사 페이지를 통해 가능합니다.</p>
                                            </h6>
                                        </div>
                                        <div class="side-right">
                                            <a class="comm-btn" href="https://www.jlair.net/contents/index.php?mid=04" target="_blank">
                                                <img class="jlair" src="/images/web/list/jlair.png" alt="제이엘 항공">
                                                제이엘 항공 >
                                            </a>
                                            <a class="comm-btn" href="https://air.dcjeju.net/air/login" target="_blank">
                                                <img class="sunmin" src="/images/web/list/sunmintour.png" alt="선민투어">
                                                선민투어 >
                                            </a>
                                        </div>
                                    </article>
                                </div>

                                <!-- 리뷰 프로모션 배너롤링 -->
                                <div class="review_content__banner">
                                   <div class="main-top-slider">
                                       <div id="main_top_slider" class="swiper-container swiper-container-horizontal">
                                           <ul class="swiper-wrapper">
                                               <li class="swiper-slide">
                                                   <div class="Fasten">
                                                       <a href="https://m.site.naver.com/1CMAR" target="_blank">
                                                           <img src="/images/web/mypage/review_banner.png" alt="리뷰이벤트">
                                                       </a>
                                                   </div>
                                               </li>
                                           </ul>
                                           <div id="main_top_navi" class="swiper-pagination"></div>
                                       </div>
                                   </div> <!-- //top-slider -->
                                </div>

                                <!-- [구매 히스토리 필터 input] s -->
                                <c:if test="${isLogin eq 'Y'}">
                                <div class="history_filter">
                                    <div class="content-area">
                                        <div class="search-area filter">
                                            <div class="date-picker-wrapper">
                                                <div class="area">
                                                    <div class="value-text">
                                                        <input class="datepicker" type="text" name="sFromDt" id="sFromDt" placeholder="검색시작일 선택" style="z-index: 10;" value="${RSV_HISSVO.sFromDt}" readonly="readonly">
                                                    </div>
                                                </div>
                                                <div class="wave">
                                                    ~
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
                                        </div>
                                        <div class="plan-selector">
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
                                                            <label for="month3">최대 (10년)</label>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>

                                            <!-- 자동취소건 포함 / check list -->
                                            <div class="auto-cancel">
                                                <input id="autoCancelChk" class="blind" type="checkbox" name="autoCancelChk" <c:if test="${RSV_HISSVO.autoCancelYn == 'Y'}">checked</c:if>>
                                                <label class="ch-style" for="autoCancelChk">자동취소건 포함</label>
                                            </div><!-- //check list -->

                                            <!-- 조회하기 -->
                                            <a href="#" class="result-btn apply" id="appleFilter">조회하기</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- //[구매 히스토리 필터 input] e -->

                                <!-- 0210 포인트 내역 및 쿠폰등록 -->
                                <c:if test="${ssPartnerCode ne '' && isGuest == 'N'}">
                                    <div class="point-management">
                                        <div class="align-right"><a href="javascript:void(0)" onclick="fn_CouponRegPop();">포인트 등록</a></div>
                                        <div class="exposure-point">
                                            <span>잔여 포인트 </span>
                                            <a href="javascript:void(0)" onclick="fn_PointHistoryPop();"><fmt:formatNumber>${myPoint.ablePoint}</fmt:formatNumber> P</a>
                                        </div>
                                    </div>
                                </c:if>

                                <!-- 포인트 내역 / 레이어팝업 -->
                                <div class="couponRegPop_1 comm-layer-popup"></div>

                                <!-- 쿠폰등록 / 레이어팝업 -->
                                <div class="couponRegPop_2 comm-layer-popup"></div>


                                <!-- [구매 카테고리 필터 선택] s -->
                                <div class="category-filter">
                                    <div id="viewFilterDetails" class="filter-button">
                                        <ul class="filter-label">
                                            <li><a href="javascript:fn_SelCate('');" <c:if test="${RSV_HISSVO.sPrdtCd eq '' || RSV_HISSVO.sPrdtCd eq null}">class="active"</c:if>>전체</a></li>
                                            <li><a href="javascript:fn_SelCate('AD');" <c:if test="${RSV_HISSVO.sPrdtCd eq 'AD' }">class="active"</c:if>>숙소</a></li>
                                            <li><a href="javascript:fn_SelCate('RC');" <c:if test="${RSV_HISSVO.sPrdtCd eq 'RC' }">class="active"</c:if>>렌트카</a></li>
                                            <li><a href="javascript:fn_SelCate('C200');" <c:if test="${RSV_HISSVO.sPrdtCd eq 'C200' }">class="active"</c:if>>관광지</a></li>
                                            <li><a href="javascript:fn_SelCate('C300');" <c:if test="${RSV_HISSVO.sPrdtCd eq 'C300' }">class="active"</c:if>>맛집</a></li>
                                            <li><a href="javascript:fn_SelCate('C100');" <c:if test="${RSV_HISSVO.sPrdtCd eq 'C100' }">class="active"</c:if>>여행사 상품</a></li>
                                            <li><a href="javascript:fn_SelCate('SV');" <c:if test="${RSV_HISSVO.sPrdtCd eq 'SV' }">class="active"</c:if>>특산/기념품</a></li>
                                        </ul>
                                    </div>
                                </div>
                                </c:if>
                                <!-- [구매 카테고리 필터 선택] e -->
                                </form>

                                <!-- 컨텐츠 없을 시에도 ul 부분은 유지 -->
                                <table class="commCol list_tb">

                                    <tbody>
                                    <c:forEach items="${orderList}" var="orderInfo" varStatus="status">
                                        <c:if test="${status.count < 10000}">
                                            <tr>
                                                <td class="left" colspan="2">
                                                    <table class="product-list">
                                                        <c:choose>
                                                            <c:when test="${preDate == null or preDate ne orderInfo.regDttm}">
                                                                <div class="purchase-date"> ${fn:substring(orderInfo.regDttm, 0, 4)}.${fn:substring(orderInfo.regDttm, 4, 6)}.${fn:substring(orderInfo.regDttm, 6, 8)}</div>
                                                                <c:set var="preDate" value="${orderInfo.regDttm}" />
                                                            </c:when>
                                                        </c:choose>
                                                        <div class="top-sauce">
                                                            <div class="in-td sauce1 <c:if test="${isLogin!='Y'}">non-member</c:if> ">
                                                                <div class="Progress">
                                                                    <p class="width20">
                                                                    <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_READY}"><p class="width20 comm-color2">미결제</p></c:if>
                                                                    <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_COM}">결제완료</c:if>
                                                                    <c:if test="${(orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ) or (orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_CREQ2)}"><p class="width20 comm-color1">취소처리중<br>(철회불가)</p></c:if>
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
                                                                        <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_DLV}">
                                                                            배송중
                                                                            <c:if test="${not empty orderInfo.dlvNum}">
                                                                                <p class="btn-tdWrap"><a href="javascript:fn_goDlv('${orderInfo.goodsflowDlvCd}', '${orderInfo.dlvNum}')" class="btn-td02" onclick="show_popup('#delivery_lookup');">배송조회</a></p>
                                                                            </c:if>
                                                                            <p class="btn-tdWrap"><a href="javascript:fn_goComfirmOrder('${orderInfo.prdtRsvNum}', '${rsvInfo.rsvNum}');" class="btn-td">구매확정</a></p>
                                                                        </c:if>
                                                                        <c:if test="${orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_DLVE}">
                                                                            배송완료
                                                                            <p class="btn-tdWrap"><a href="javascript:fn_goComfirmOrder('${orderInfo.prdtRsvNum}', '${rsvInfo.rsvNum}');" class="btn-td">구매확정</a></p>
                                                                        </c:if>
                                                                    </c:if>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="in-td sauce2">
                                                                <a class="number">주문번호 <c:out value="${orderInfo.rsvNum}"/></a>
                                                            </div>
                                                        </div>
                                                        <tbody>
                                                        <tr class="sauce-wraper">
                                                            <td class="in-td sauce3">
                                                                <table>
                                                                    <tr>
                                                                        <td class="my-col in-td left2" colspan="2">
                                                                            <div class="info_bx">
                                                                                <div class="skinny__img">
                                                                                    <c:if test="${orderInfo.prdtCd ne 'RC'}">
                                                                                        <c:choose>
                                                                                            <c:when test="${fn:contains(orderInfo.savePath, 'http')}">
                                                                                                <img class="my-order-unit__thumb-img" src="${orderInfo.savePath}">
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <img class="my-order-unit__thumb-img" src="${orderInfo.savePath}thumb/${orderInfo.saveFileNm}">
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </c:if>
                                                                                    <c:if test="${orderInfo.prdtCd eq 'RC'}">
                                                                                        <img class="my-order-unit__thumb-img" src="${orderInfo.savePath}">
                                                                                    </c:if>
                                                                                </div>
                                                                                <div class="skinny">
                                                                                    <span class="category">${orderInfo.corpNm}</span><br>
                                                                                    <div class="skinny--hover">
                                                                                        <c:choose>
                                                                                            <c:when test="${orderInfo.prdtCd eq 'RC'}">
                                                                                                <a href="<c:url value='/web/rentcar/car-detail.do?${orderInfo.prdtUrlDiv}'/>" class="product-list" target="_blank">
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <a href="<c:url value='/web/${fn:toLowerCase(orderInfo.prdtCd)}/detailPrdt.do?${orderInfo.prdtUrlDiv}'/>" class="product-list" target="_blank">
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                            <h5 class="product">${orderInfo.prdtNm}</h5>
                                                                                            <span class="infoText">${orderInfo.prdtInf}</span>
                                                                                        </a>
                                                                                        <c:if test="${orderInfo.prdtCd eq 'AD'}">
                                                                                        <span class="ad-infoText">숙소예약번호(${orderInfo.prdtRsvNum})</span> </c:if>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td class="in-td sauce4 <c:if test="${isLogin!='Y'}">non-member</c:if> ">
                                                                <div class="Progress">
                                                                    <p class="width20">
                                                                        <div class="purchase_item_buttons">

                                                                            <!-- 배송조회 노출 안될 시 a 태그만 삭제 -->
                                                                            <c:if test="${orderInfo.prdtCd eq 'SV'}">
                                                                            <a href="javascript:fn_goDlv('${orderInfo.goodsflowDlvCd}', '${orderInfo.dlvNum}')" class="purchase_item_button item_track_btn">
                                                                                <span>배송조회</span>
                                                                            </a>
                                                                            </c:if>
                                                                        </div>
                                                                    </p>
                                                                </div>
                                                            </td>
                                                            <td class="in-td sauce5">
                                                                <div class="all-price" onclick="fn_DtlRsv('${orderInfo.rsvNum}')">
                                                                    <p><fmt:formatNumber>${orderInfo.saleAmt}</fmt:formatNumber><span>원</span></p>
                                                                </div>
                                                            </td>
                                                            <td class="in-td sauce6 <c:if test="${isLogin!='Y'}">non-member</c:if> ">
                                                                <div class="Progress">
                                                                    <p class="width20">
                                                                        <!-- 구매 항목 액션 버튼들 시작 -->
                                                                    <div class="purchase_item_actions">
                                                                        <div class="purchase_item_button_container">
                                                                            <div class="purchase_item_buttons">
                                                                                <c:choose>
                                                                                    <c:when test="${orderInfo.prdtCd eq 'RC'}">
                                                                                        <a href="<c:url value='/web/rentcar/car-detail.do?${orderInfo.prdtUrlDiv}'/>" class="purchase_item_button btn-rebuy" target="_blank"><span>재구매</span></a>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <a href="<c:url value='/web/${fn:toLowerCase(orderInfo.prdtCd)}/detailPrdt.do?${orderInfo.prdtUrlDiv}'/>" class="purchase_item_button btn-rebuy" target="_blank"><span>재구매</span></a>
                                                                                    </c:otherwise>
                                                                                </c:choose>

                                                                                <a class="purchase_item_button" onclick="fn_DtlRsv('${orderInfo.rsvNum}')">
                                                                                    <span class="detail">구매상세</span>
                                                                                </a>

                                                                                <c:if test="${(orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_UCOM || orderInfo.rsvStatusCd eq Constant.RSV_STATUS_CD_SCOM) && orderInfo.useepilRegYn eq 'N'}">
                                                                                    <c:if test="${isLogin=='Y'}">
                                                                                        <a class="writeBT purchase_item_button item_review_btn" href="<c:url value='/web/coustmer/viewInsertUseepil.do?sPrdtNum=${orderInfo.prdtRsvNum}'/>">이용후기</a>
                                                                                    </c:if>
                                                                                </c:if>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <!-- 구매 항목 액션 버튼들 끝 -->
                                                                    </p>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>

                                    <c:if test="${fn:length(orderList) == 0}">
                                        <tr>
                                            <th>
                                                <p class="no-content">예약/구매 내역이 없습니다.</p>
                                            </th>
                                        </tr>
                                    </c:if>
                                    </tbody>
                                </table>

                                <!--- [페이지네이션] s --->
                                <c:if test="${fn:length(orderList) != 0}">
                                    <div class="pageNumber">
                                        <p class="list_pageing">
                                            <ui:pagination paginationInfo="${paginationInfo}" type="web" jsFunction="submitForm" />
                                        </p>
                                    </div>
                                </c:if>
                                <!--- [페이지네이션] e --->

                                <!---진행 상태 안내--->
                                <div class="comm-artWrap">
                                    <article class="comm-art2">
                                        <h3 class="mainTitle">진행 상태 안내</h3>
                                        <div class="info-list <c:if test="${isLogin!='Y'}">non-member</c:if> ">
                                            <dl class="my__i-group">
                                                <i class="my__i my__i-order-status1"></i>
                                                <dt class="group-title">미결제</dt>
                                                <dd>예약/구매<br>진행 중 결제하기 전 상태</dd>
                                            </dl>
                                            <dl class="my__i-group">
                                                <i class="my__i my__i-order-status2"></i>
                                                <dt class="group-title">결제완료</dt>
                                                <dd>예약/구매 결제 완료</dd>
                                            </dl>
                                            <dl class="my__i-group">
                                                <i class="my__i my__i-order-status3"></i>
                                                <dt class="group-title">사용완료</dt>
                                                <dd>예약 상품<br>사용 완료</dd>
                                            </dl>
                                            <dl class="my__i-group">
                                                <i class="my__i my__i-order-status4"></i>
                                                <dt class="group-title">구매완료</dt>
                                                <dd>구매 상품 수령<br>완료</dd>
                                            </dl>
                                            <dl class="my__i-group">
                                                <i class="my__i my__i-order-status5"></i>
                                                <dt class="group-title">취소처리중</dt>
                                                <dd>취소 요청 후<br>예약/구매 담당자 확인 전 상태</dd>
                                            </dl>
                                            <dl class="my__i-group">
                                                <i class="my__i my__i-order-status6"></i>
                                                <dt class="group-title">취소완료</dt>
                                                <dd>예약/구매 <br> 담당자 확인 후<br>취소처리 완료</dd>
                                            </dl>
                                            <dl class="my__i-group">
                                                <i class="my__i my__i-order-status7"></i>
                                                <dt class="group-title">자동취소</dt>
                                                <dd>미결제로 예약/<br>구매가 취소된<br>상태</dd>
                                            </dl>
                                        </div>
                                    </article>
                                </div><!---진행 상태 안내--->
                                <%--                                 <p style="text-align:center;margin-top: 20px">
                                                                    <a class="writeBT" href="<c:url value='/web/coustmer/viewInsertUseepil.do'/>"><img src="<c:url value="/images/web/button/write.jpg"/>" alt="이용후기 작성"></a>
                                                                </p> --%>
                            </div> <!--//rContents-->
                        </div> <!--//tbWrap-->
                    </div> <!--//Fasten-->
                </div> <!--//bgWrap2-->
            </div> <!-- //mypage1 -->
            <!-- //new contents -->
        </div> <!-- //subContents -->
    </div> <!-- //subContainer -->
    <div id="delivery_lookup" class="comm-layer-popup">
        <div class="content-wrap">
            <div class="content">
                <div class="installment-head">
                    <h3 class="title">배송지키미 - 탐나오</h3>
                    <a onclick="close_popup('.comm-layer-popup');" class="close"><img src="/images/web/icon/popup_close_white.png" alt="닫기"></a>
                </div>
                <div>
                    <iframe id="goodsflowIframe" height="400px" width="600px" src="" style="border:none" ></iframe>
                </div>
            </div>
        </div>
    </div>
</main>

<!--REAL-->
<script type="text/javascript" src="https://pgweb.tosspayments.com/js/DACOMEscrow.js"></script>
<!--TEST-->
<%--<script type="text/javascript" src="https://pgweb.tosspayments.com:9091/js/DACOMEscrow.js"></script>--%>
<script type="text/javascript">
    <%--function fn_DtlRsv(rsvNum) {--%>
    <%--	$("#rsvNum").val(rsvNum);	--%>
    <%--	document.frm.action = "<c:url value='/web/mypage/detailRsv.do'/>";--%>
    <%--	document.frm.submit();--%>
    <%--}--%>

    //예약확인 바로가기
    function goto_direct_confirm(o) {
        if (o.value != '') {
            window.open(o.value, '');
        }
    }

    function fn_goDlv(dlvCd, dlvNum) {

        if("${CST_PLATFORM}" == "test"){
            $('#goodsflowIframe').attr('src', "https://trace.goodsflow.com/VIEW/V1/whereis/visitjejutest/" + dlvCd + "/" + dlvNum);
        }else{
            $('#goodsflowIframe').attr('src', "https://trace.goodsflow.com/VIEW/V1/whereis/visitjeju/" + dlvCd + "/" + dlvNum);
        }

        $('#delivery_lookup').show();
        $('#delivery_lookup').css("top",$(document).scrollTop()+129+"px");

        $('body').after('<div class="lock-bg"></div>'); // 검은 불투명 배경
        $('body').addClass('not_scroll');

    }

    function close_popup(obj){
        $(obj).hide();
        $('.lock-bg').remove();
        $('body').removeClass('not_scroll');
    }

    function fn_goComfirmOrder(svRsvNum, oid) {

        var parameters = "svRsvNum=" + svRsvNum;
        $.ajax({
            type:"post",
            dataType:"json",
            // async:false,
            url:"<c:url value='/web/confirmOrder.ajax'/>",
            data:parameters ,
            success:function(data){
                //에스크로 사용자 구매확인
                checkDacomESC (data.mid, oid, '');
                document.frm.action = "<c:url value='/web/mypage/rsvList.do'/>";
                document.frm.submit();
            }
        });
    }

    function fn_chkLogin() {
        alert('회원은 로그인 후 이용후기를 작성하실 수 있고,\n비회원은 이용후기를 작성할 수 없습니다.');
        return;
    }

    $(document).ready(function() {

        //카테고리, 날짜선택창 클릭 시 active 효과
        $('.filter-label li a,#sFromDt, #sToDt').click(function(e) {
            $('.filter-label li a,#sFromDt, #sToDt').removeClass('active');
            $(this).addClass('active');
        });

        /** 마이페이지 프로모션 슬라이드 */
        if($('#main_top_slider .swiper-slide').length > 1) {
            var swiper = new Swiper('#main_top_slider', {
                slidesPerView: 1,
                slidesPerGroup: 1,
                paginationType: 'bullets',
                pagination: '#main_top_navi',
                paginationClickable: true,
                loop: true,
                observer: true,
                observeParents: true
            });
        }

        $("#autoCancelChk").click(function(){
            if($(this).is(":checked")){
                $("#autoCancelYn").val("Y");
            }else{
                $("#autoCancelYn").val("N");
            }
        });

        $("#package_info .close").click(function(){
            $("#package_info").hide()
        })

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
                // txt active
                $('#sToDt, #sFromDt').removeClass('active');
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
                // txt active
                $('#sToDt, #sFromDt').removeClass('active');
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
            submitForm(1);
        });

        $("#sPrdtNm").on("keydown", function(e) {
            if (e.keyCode === 13) {
                e.preventDefault();
                submitForm(1);
            }
        });
    });

    function submitForm(pageIndex) {
        document.frm.pageIndex.value = pageIndex;
        $("#frm").val(pageIndex);
        $("#frm").attr("action", "/web/mypage/rsvList.do");
        $("#frm").attr("method", "POST");
        $("#frm").submit();
    }

    function fn_CouponRegPop() {
        $.ajax({
            type   : "post",
            url    : "<c:url value='/web/point/couponRegPop.do'/>",
            success: function (data) {
                $(".couponRegPop_2").html(data);
                show_popup($(".couponRegPop_2"));
            },
            error  : fn_AjaxError
        });
    }

    function fn_PointHistoryPop() {
        $.ajax({
            type   : "post",
            url    : "<c:url value='/web/point/pointHistoryPop.do'/>",
            success: function (data) {
                $(".couponRegPop_1").html(data);
                show_popup($(".couponRegPop_1"));
            },
            error  : fn_AjaxError
        });
    }

    function fn_SelCate(pCate){
        $("#sPrdtCd").val(pCate);
        submitForm(1);
    }
</script>
<jsp:include page="/web/right.do" flush="false"></jsp:include>
<jsp:include page="/web/foot.do" flush="false"></jsp:include>
</body>
</html>