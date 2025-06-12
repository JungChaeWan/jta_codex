<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="un" 		uri="http://jakarta.apache.org/taglibs/unstandard-1.0" %>          
<un:useConstants var="Constant" className="common.Constant" />		

<c:forEach items="${product}" var="product">
  <h2 class="sec-caption">숙박 목록</h2>
  <div class="hotel-group">
	  <a class="close-btn" onclick="ad_close_popup('#hotel_detail')"></a>
	  <div class="product-area">
		  <a href="/mw/ad/detailPrdt.do?sPrdtNum=${product.prdtNum}">
			  <div class="i-photo">
				  <img src="${product.savePath}thumb/${product.saveFileNm}" alt="product" alt="product">
			  </div>
			  <div class="text">
				  <div class="tx_comment"></div>
				  <h2>${product.adNm}</h2>
				  <div class="ad_star">
					<span class="star-icon">
						<c:forEach begin="1" end="5" varStatus="status">
							<c:choose>
								<c:when test = "${product.gpaAvg < status.current}">
									<img src="<c:url value='/images/mw/icon/star_off.png'/>" alt="starRate">
								</c:when>
								<c:otherwise>
									<img src="<c:url value='/images/mw/icon/star_on.png'/>" alt="starRate">
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</span>
				    <!-- 0208 현석 class 추가 -->
					<span class="star-num">
						<c:if test="${product.gpaCnt ne 0}">
							(${product.gpaCnt})
						</c:if>
					</span>
				  </div>
				  <div class="memo">
					<img src="<c:url value='/images/mw/icon/place.png'/>" alt="거리">
					<span class="guide-memo">${product.adAreaNm}</span>${product.adSimpleExp}
				  </div>
				  <div class="info">
					  <!-- label -->
					  <div class="bxLabel">
						  <c:if test="${product.daypriceYn == 'Y'}">
							  <span class="main_label pink">당일특가</span>
						  </c:if>
						  <c:if test="${product.eventCnt > 0}">
							  <span class="main_label eventblue">이벤트</span>
						  </c:if>
						  <c:if test="${product.couponCnt > 0}">
							  <span class="main_label pink">할인쿠폰</span>
						  </c:if>
						  <c:if test="${product.continueNightYn == 'Y'}">
							  <span class="main_label back-red">연박할인</span>
						  </c:if>
						  <c:if test="${product.superbCorpYn == 'Y' }">
							  <span class="main_label back-red">우수관광사업체</span>
						  </c:if>
						  <c:if test="${product.tamnacardYn eq 'Y'}">
							  <span class="main_label yellow">탐나는전</span>
						  </c:if>
					  </div>
				  </div>
			  </div>

			  <!-- 가격 -->
			  <div class="map-price">
				  <del><fmt:formatNumber value='${product.nmlAmt * searchVO.sNights}'/>원</del>
				  <em>${searchVO.sNights}박</em>
				  <strong><fmt:formatNumber value='${product.saleAmt}'/></strong>
				  <span class="won">원</span>
			  </div>
		  </a>
	  </div>
  </div> <!-- //hotel-group -->

</c:forEach>
