<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>

<h2 class="sec-caption">관광지/레저 목록</h2>
<!-- sp-group -->
<div class="hotel-group sp-group">
	<a class="close-btn" onclick="sp_close_popup('#sp_detail')"></a>
	<div class="product-area">
		<a href="/mw/sp/detailPrdt.do?prdtNum=${prdtInfo.prdtNum}&prdtDiv=${prdtInfo.prdtDiv}">
			<div class="i-photo">
				<c:if test="${prdtInfo.lsLinkYn eq 'Y' }">
					<img src="${prdtImg[0].savePath}" alt="product" onerror="this.src='/images/web/other/no-image.jpg'">
				</c:if>
				<c:if test="${prdtInfo.lsLinkYn ne 'Y' }">
					<img src="${prdtImg[0].savePath}thumb/${prdtImg[0].saveFileNm}" alt="<c:out value='${prdtInfo.prdtNm}' />">
				</c:if>
			</div>
			<div class="text">
				<div class="tx_comment"></div>
				<h2>${prdtInfo.prdtNm}</h2>
				<div class="memo">
					<img src="../../images/mw/icon/place.png" alt="거리">
					<span class="sp-guide-memo">${prdtInfo.prdtInf}</span>
				</div>
				<div class="info">

					<!-- label -->
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
			<!-- 가격 -->
			<div class="map-price">
				<del><fmt:formatNumber value='${prdtInfo.nmlAmt}' type='number' />원 ~</del>
				<strong><fmt:formatNumber value='${prdtInfo.saleAmt}' type='number' /></strong><span class="won">원 ~</span>
			</div>
		</a>
	</div>
</div> <!-- //sp-group -->