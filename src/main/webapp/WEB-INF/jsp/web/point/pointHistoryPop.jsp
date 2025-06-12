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
    <jsp:useBean id="today" class="java.util.Date" />
    <fmt:formatDate value="${today}" pattern="yyyyMMdd" var="nowDate"/>
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/jquery-ui.css'/>" />
    <c:if test="${cssView ne 'oss'}">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/common.css?version=${nowDate}'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/style.css?version=${nowDate}'/>" />
    </c:if>
    <c:if test="${divView eq 'mrtn' }">
    	<link rel="stylesheet" type="text/css" href="<c:url value='/css/web/re/marathon.css'/>" />
    </c:if>
    <c:if test="${cssView ne 'oss' && cssView ne 'order' }">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/web/sub.css?version=${nowDate}'/>" />
    </c:if>
</head>
<html>
<body>
    <div class="pointGroup title">포인트 내역</div>
    <div class="point-group-wrap">
        <button type="button" class="close" onclick="close_popup($('.couponRegPop_1'));">
            <img src="../../images/web/air/btn-layerClose.png" alt="닫기">
        </button>

        <!-- 포인트 내역 있을 시 -->
        <div class="point-view" >
            <ul>
                <!-- 사용 -->
                <c:forEach var="phList" items="${pointHistoryList}" varStatus="status">
                <li class="point-list">
                    <div class="point-list-item">
                        <div class="situation">
                            <c:choose>
                                <c:when test="${phList.types eq 'USE'}"><span class="status-icon use">사용</span></c:when>
                                <c:when test="${phList.types eq 'COUPON' || phList.types eq 'ADMIN_REG' }"><span class="status-icon charge">적립</span></c:when>
                                <c:when test="${phList.types eq 'CANCEL'}"><span class="status-icon accumulate">취소</span></c:when>
                                <c:otherwise>기타</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="point-name">
                            <span class="date">${fn:replace(phList.regDttm,'-', '. ')}</span>
                            <strong>
                                <c:choose>
                                    <c:when test="${phList.types eq 'USE'}">
                                        <a href="/web/mypage/detailRsv.do?rsvNum=${phList.rsvNum}"> ${phList.corpNm}
                                            <span>${phList.prdtNm}</span>
                                            <c:if test="${phList.contents == 'CMSS_AMT'}">
                                                <span style="color:red">취소 수수료</span>
                                            </c:if>
                                        </a>
                                    </c:when>
                                    <c:when test="${phList.types eq 'COUPON'}">쿠폰등록 ${phList.cpNum}</c:when>
                                    <c:when test="${phList.types eq 'CANCEL'}">
                                        <a href="/web/mypage/detailRsv.do?rsvNum=${phList.rsvNum}"> ${phList.corpNm}
                                            <span>${phList.prdtNm}</span>
                                            <span style="color:red">포인트반환</span>
                                        </a>
                                    </c:when>
                                    <c:when test="${phList.types eq 'ADMIN_REG'}">관리자 등록</c:when>
                                    <c:otherwise>기타</c:otherwise>
                                </c:choose>
                            </strong>
                        </div>
                            <c:if test="${phList.plusMinus eq 'M'}"><div class="real-point use">-  <fmt:formatNumber value="${phList.point}"/> P</div></c:if>
                            <c:if test="${phList.plusMinus eq 'P'}"><div class="real-point charge">+  <fmt:formatNumber value="${phList.point}"/> P</div></c:if>
                    </div>
                </li>
                </c:forEach>

            </ul>
        </div>
        <!-- 없을 시 -->
        <c:if test="${fn:length(pointHistoryList) == 0}">
        <div class="no-point-view">포인트 내역이 없습니다.</div>
        </c:if>
    </div>
</body>
</html>